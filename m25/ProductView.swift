//
//  ProductView.swift
//  m25
//
//  Created by Jiaqi Yi on 2025.10.16.
//


import SwiftUI

struct ProductView: View {
    let product: ProductModel
    @EnvironmentObject var appData: AppDataManager
    
    @Environment(\.dismiss) private var dismiss
    @State private var selectedRecord: Set<Int> = [] // ✅ multiple selection
    @State private var selectedExtraChoiceIndex: Int? = nil
    @State private var selectedPriceIndex = 0
    @State private var showReading = false
    @State private var currentImageIndex = 0
    
    var body: some View {
        ScrollView {
            ButtonsBar(type: .reading, onClose: { dismiss() })
            VStack(spacing: 20) {
                Headline(type: .reading, heading: product.title)
                
                    // --- Image carousel safely wrapped
//                GeometryReader { geo in
//                    let safeWidth = min(geo.size.width, UIScreen.main.bounds.width)
//                    let uiImage = UIImage(named: product.images[currentImageIndex])
//                    let aspectRatio = (uiImage?.size.height ?? 1) / (uiImage?.size.width ?? 1)
//                    let heightFactor: CGFloat = aspectRatio < 0.8 ? 0.6 : 0.9  // landscape → shorter, portrait → taller
//                    TabView(selection: $currentImageIndex) {
//                        ForEach(product.images.indices, id: \.self) { i in
//                            let imgName = product.images[i]
//                            if let uiImage = UIImage(named: imgName) {
//                                let ratio = uiImage.size.height / uiImage.size.width
//                                ZoomableImageView(imageName: imgName)
//                                    .frame(width: safeWidth * 0.9, height: safeWidth * 0.9 * ratio)
//                                    .clipped()
//                                    .tag(i)
//                            } else {
//                                ZoomableImageView(imageName: imgName)
//                                    .frame(width: safeWidth * 0.9, height: safeWidth * 0.9)
//                                    .tag(i)
//                            }
//                        }
//                    }
//                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
//                    .frame(width: safeWidth, height: safeWidth * heightFactor)
//                    .indexViewStyle(.page(backgroundDisplayMode: .always))
//                    .frame(maxWidth: .infinity)
//                }
//                .frame(height: UIScreen.main.bounds.width * 0.9)
                
                let uiImage = UIImage(named: product.images[currentImageIndex])
                let aspectRatio = (uiImage?.size.height ?? 1) / (uiImage?.size.width ?? 1)
                let heightFactor: CGFloat = aspectRatio < 0.8 ? 0.6 : 0.9
                let carouselHeight = UIScreen.main.bounds.width * heightFactor
                
                TabView(selection: $currentImageIndex) {
                    ForEach(product.images.indices, id: \.self) { i in
                        let imgName = product.images[i]
                        ZoomableImageView(imageName: imgName)
                            .frame(width: UIScreen.main.bounds.width,
                                   height: carouselHeight)
                            .clipped()
                            .tag(i)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .frame(height: carouselHeight)
                .indexViewStyle(.page(backgroundDisplayMode: .always))

                
                
                    // 4. Pricing buttons
                let user = appData.userState
                let isMember: Bool = {
                    guard let user = user else { return false }
                        // Example heuristic: anyone who has finished ≥ 360 days or has progressed beyond Year 1 is a supporter
                    if user.currentYearIndex >= 1 { return true }
                        // Or, if you later add a flag like user.isSupporter / user.isBenefactor, use that instead
                    return false
                }()
                VStack(spacing: 12) {
                    ForEach(product.prices.indices, id: \.self) { i in
                        let price = product.prices[i]
                        let mainPrice = isMember ? price.discounted : (price.original ?? price.discounted)
                        let subPrice  = isMember ? price.original  : price.discounted
                        
                        SelectableButton(
                            type: .multipleText,
                            texts: [price.name, price.subtitle, mainPrice, subPrice].compactMap { $0 },
                            linkURL: nil,
                            onSelect:{
                                selectedPriceIndex = i
                                if let target = price.imageTarget,
                                   let targetIndex = product.images.firstIndex(of: target) {
                                        // scroll or jump carousel to target
                                    withAnimation {
                                        currentImageIndex = targetIndex
                                    }
                                }
                                selectedExtraChoiceIndex = nil
                            },
                            isSelected: Binding(
                                get: { selectedPriceIndex == i },
                                set: { newValue in if newValue { selectedPriceIndex = i } }
                            )

                        )
                            // If this price has a specialAction and extraChoices
                            // Show extra choices ONLY when this price is the one currently selected
                        if selectedPriceIndex == i,
                           let actionTitle = price.specialAction,
                           let choices = product.extraChoices {
                            VStack(spacing: 10) {
                                Text(actionTitle)
                                    .font(.smallHeadline)
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                                
                                ForEach(choices.indices, id: \.self) { j in
                                    let choice = choices[j]
                                    SelectableButton(
                                        type: .multipleText,
                                        texts: [choice.name, choice.original].compactMap { $0 },
                                        linkURL: nil,
                                        onSelect:{
                                            if let target = choice.imageTarget,
                                               let targetIndex = product.images.firstIndex(of: target) {
                                                withAnimation {
                                                    currentImageIndex = targetIndex
                                                }
                                            }
                                        },
                                        isSelected: Binding(
                                            get: { selectedExtraChoiceIndex == j },
                                            set: { newValue in
                                                if newValue {
                                                    selectedExtraChoiceIndex = j
                                                } else {
                                                    selectedExtraChoiceIndex = nil
                                                }
                                            }
                                        )
                                    )
                                }
                            }
                            .padding(.vertical, 8)
                        }
                    }
                    
                        // ✅ Not a member yet (ReadingView initialPage: 4)
                    Text("Not A Member Yet?")
                        .font(.xSmallHeadline)
                        .foregroundColor(.black)
                        .onTapGesture { showReading = true }
                        .padding(.top, 8)
                }
                .padding(.horizontal, 16)
                .padding(.vertical)
                
                
                
                
                    // 5. Available records
                if let records = product.availableRecords,
                   records.contains(where: { [1, 2, 3, 4].contains($0) }) {
                    
                    let currentYear = currentYearIndex(for: appData.userState)
                    Headline(type: .reading, heading: "Available Records:")
                    
                    HStack(spacing: 12) {
                        ForEach(records, id: \.self) { record in
                            let isAvailable = record <= currentYear
                            let isSelected = selectedRecord.contains(record)
                            
                            Text("\(record)")
                                .font(.xSmallHeadline)
                                .frame(width: 48, height: 48)
                                .background(
                                    RoundedRectangle(cornerRadius: 24)
                                        .fill(isSelected ? Color.black : (isAvailable ? Color.clear : Color.gray.opacity(0.3)))
                                )
                                .foregroundColor(isSelected ? .white : .black)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 24)
                                        .stroke(Color.black, lineWidth: 1)
                                )
                                .onTapGesture {
                                    guard isAvailable else { return }
                                    if isSelected {
                                        selectedRecord.remove(record)
                                    } else {
                                        selectedRecord.insert(record)
                                    }
                                }
                        }
                    }
                }
                
                
                    // ✅ 6. Description
                VStack(alignment:.leading,spacing:8){
                    ForEach(product.descriptions.indices, id: \.self) { i in
                        let isBold = product.boldTexts?.contains(i) ?? false
                        
                        Text(product.descriptions[i])
                            .font(isBold ? .smallHeadline : .smallBodyText)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 24)
                    }
                }
                
                    // ✅ 7. Total summary
                let totalText: String = {
                        // Determine if valid availableRecords exist
                    let hasValidRecords = product.availableRecords?.contains(where: { [1, 2, 3, 4].contains($0) }) ?? false
                    
                        // If no valid records → treat as 1 item
                    if selectedRecord.isEmpty && hasValidRecords == false {
                        let basePrice = currentPriceValue(for: product, index: selectedPriceIndex, isMember: isMember)
                        let baseValue = Double(basePrice.replacingOccurrences(of: "$", with: "")) ?? 0
                        let extraTotal = product.extraChoices?
                            .compactMap { Double($0.original.replacingOccurrences(of: "$", with: "")) }
                            .reduce(0, +) ?? 0
                        let total = baseValue + extraTotal
                        return "Your total is: $\(String(format: "%.2f", total))"
                    }
                    
                        // Default case
                    if selectedRecord.isEmpty {
                        return " " // Keeps layout stable
                    } else {
                        let basePrice = currentPriceValue(for: product, index: selectedPriceIndex, isMember: isMember)
                        let baseValue = Double(basePrice.replacingOccurrences(of: "$", with: "")) ?? 0
                        let extraTotal = product.extraChoices?
                            .compactMap { Double($0.original.replacingOccurrences(of: "$", with: "")) }
                            .reduce(0, +) ?? 0
                        let total = Double(selectedRecord.count) * (baseValue + extraTotal)
                        return "Your total is: $\(String(format: "%.2f", total))"
                    }
                }()
                
                Text(totalText)
                    .font(.custom("Rubik-Medium", size: 20))
                    .foregroundColor(.black)
                    .padding(.top, 8)
                
                    // ✅ 8. ORDER button
                SelectableButton(
                    type: .singleText,
                    texts: ["ORDER"],
                    linkURL: nil,
                    isSelected: .constant(true)
                )
            }
            .frame(maxWidth: UIScreen.main.bounds.width)
            .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
            .padding(.bottom, 80)
        }
        .background(Color(hex: "E6E6E6").ignoresSafeArea())
        .ignoresSafeArea(.all)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .fullScreenCover(isPresented: $showReading) {
            ReadingView(initialPage: 4)
        }
    }
    
        // MARK: - Helpers
    
    func currentYearIndex(for user: UserState?) -> Int {
        guard let user = user else { return 1 }
        let daysPassed = user.passedDays
        return min(4, max(1, Int(floor(Double(daysPassed) / 360.0)) + 1))
    }
    
    func currentPriceValue(for product: ProductModel, index: Int, isMember: Bool) -> String {
        guard product.prices.indices.contains(index) else { return "$0" }
        let p = product.prices[index]
        return isMember ? p.discounted : (p.original ?? p.discounted)
    }
}
let sampleProduct = ProductModel(
    title: "Product Title",
    code: 0,
    demonstratedPrice: "from $79",
    images: ["minutiae_poster_notification",
             "minutiae_poster_notification",
             "minutiae_poster_notification"],
    availableRecords: [1, 2, 3, 4],
    descriptions: [
        "The minutiae 360 Edition contains all your captured moments over a one-year period. The spine is stamped with the participant’s initials and the corresponding record number.",
        "Your Shipping address will be added after you press the continue button."
    ],
    prices: [
        ProductPrice(name: "UNFRAMED", subtitle: "Full Price", discounted: "$79", original: "$99"),
        ProductPrice(name: "FRAMED", subtitle: "Full Price", discounted: "$139", original: "$159")
    ]
)

struct ProductPrice: Codable, Hashable {
    let name: String
    let subtitle: String?
    let discounted: String
    let original: String?
    let imageTarget: String?
    let specialAction: String?   // ✅ NEW
    
    init(
        name: String,
        subtitle: String? = nil,
        discounted: String,
        original: String? = nil,
        imageTarget: String? = nil,
        specialAction: String? = nil
    ) {
        self.name = name
        self.subtitle = subtitle
        self.discounted = discounted
        self.original = original
        self.imageTarget = imageTarget
        self.specialAction = specialAction
    }
}

struct ExtraChoice: Codable, Hashable {
    let name: String
    let original: String
    let imageTarget: String?
}


struct ProductModel: Codable, Hashable {
    let title: String
    let code: Int?
    let demonstratedPrice: String
    let images: [String]
    let availableRecords: [Int]?
    let descriptions: [String]
    let boldTexts: [Int]?     // remains optional
    let prices: [ProductPrice]
    let extraChoices: [ExtraChoice]?
    
        // ✅ custom memberwise initializer with default for boldTexts
    init(
        title: String,
        code: Int? = nil,
        demonstratedPrice: String,
        images: [String],
        availableRecords: [Int]? = nil,
        descriptions: [String],
        boldTexts: [Int]? = nil,
        prices: [ProductPrice],
        extraChoices: [ExtraChoice]? = nil
    ) {
        self.title = title
        self.code = code
        self.demonstratedPrice = demonstratedPrice
        self.images = images
        self.availableRecords = availableRecords
        self.descriptions = descriptions
        self.boldTexts = boldTexts
        self.prices = prices
        self.extraChoices = extraChoices
    }
}
#Preview {
    ProductView(product: sampleProduct).environmentObject(AppDataManager())
}


struct ZoomableImageView: View {
    let imageName: String
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    
    var body: some View {
        GeometryReader { geo in
                // Center content to respect outer padding & preserve aspect
            VStack {
                Spacer()
                
                Image(imageName)
                    .resizable()
                    .scaledToFit() // ✅ keeps aspect ratio correctly
                    .scaleEffect(scale)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                scale = lastScale * value
                            }
                            .onEnded { _ in
                                withAnimation(.spring()) {
                                    if scale < 1.0 { scale = 1.0 }  // reset to normal
                                    lastScale = scale
                                }
                            }
                    )
                    // ✅ use geo safe area width to constrain
                    .frame(maxWidth: geo.size.width, maxHeight: geo.size.width)
                    .clipped()
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
        }
    }
}
