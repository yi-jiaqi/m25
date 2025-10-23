//
//  ProductView.swift
//  m25
//
//  Created by Jiaqi Yi on 2025.10.16.
//

import SwiftUI

struct ProductView: View {
    let product: ProductModel
    
    @Environment(\.dismiss) private var dismiss
    @State private var selectedRecord: Int? = nil
    @State private var selectedPriceIndex = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                    // 1. Buttons Bar
                ButtonsBar(type: .reading, onClose: { dismiss() })
                
                    // 2. Headline
                Headline(type: .reading, heading: product.title)
                
                    // 3. Image Carousel
                TabView {
                    ForEach(product.images, id: \.self) { imgName in
                        Image(imgName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width,
                                   height: UIScreen.main.bounds.width)
                            .clipped()
                            .cornerRadius(10)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .frame(height: UIScreen.main.bounds.width)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                
                    // 4. Pricing buttons
                VStack(spacing: 12) {
                    ForEach(product.prices.indices, id: \.self) { i in
                        let price = product.prices[i]
                        SelectableButton(
                            type: .multipleText,
                            texts: [price.name, price.subtitle, price.current, price.original].compactMap { $0 },
                            linkURL: nil,
                            isSelected: .constant(i == selectedPriceIndex)
                        )
                        .onTapGesture {
                            selectedPriceIndex = i
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical)
                
                    // 5. Available records
                if let records = product.availableRecords {
                    Headline(type: .reading, heading: "Available Records:")
                    
                    HStack(spacing: 12) {
                        ForEach(records, id: \.self) { record in
                            Text("\(record)")
                                .font(.xSmallHeadline)
                                .frame(width: 48, height: 48)
                                .background(
                                    RoundedRectangle(cornerRadius: 24)
                                        .fill(selectedRecord == record ? Color.black : Color.clear)
                                )
                                .foregroundColor(selectedRecord == record ? .white : .black)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 24)
                                        .stroke(Color.black, lineWidth: 1)
                                )
                                .onTapGesture {
                                    selectedRecord = record
                                }
                        }
                    }
                }
                
                    // 6. Descriptive texts
                ForEach(product.descriptions.indices, id: \.self) { i in
                    Text(product.descriptions[i])
                        .font(.custom(i == product.descriptions.count - 1
                                      ? "Rubik-Medium" : "Rubik-Light",
                                      size: i == product.descriptions.count - 1 ? 20 : 20))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 24)
                }
                
                    // 7. BUY
                SelectableButton(
                    type: .singleText,
                    texts: ["BUY"],
                    linkURL: nil,
                    isSelected: .constant(true)
                )
                
                    // 8. SHOP MORE
                SelectableButton(
                    type: .externalLink,
                    texts: ["SHOP MORE"],
                    linkURL: URL(string: "https://minutiae-app.com/shop"),
                    isSelected: .constant(false)
                )
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 80)
            .frame(maxWidth: 512)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(Color(hex: "E6E6E6").ignoresSafeArea())
        .ignoresSafeArea(.all)
        .padding(.horizontal, 16)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
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
        ProductPrice(name: "UNFRAMED", subtitle: "Full Price", current: "$79", original: "$99"),
        ProductPrice(name: "FRAMED", subtitle: "Full Price", current: "$139", original: "$159")
    ]
)

struct ProductPrice: Codable, Hashable {
    let name: String
    let subtitle: String?
    let current: String
    let original: String?
}

struct ProductModel: Codable, Hashable {
    let title: String
    let code: Int?
    let demonstratedPrice: String
    let images: [String]
    let availableRecords: [Int]?
    let descriptions: [String]
    let prices: [ProductPrice]
}

struct ProductPosterView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isUnframedSelected = true
    @State private var isFramedSelected = false
    @State private var selectedRecord = 3
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                    // 1. Buttons Bar
                ButtonsBar(type: .reading, onClose: { dismiss() })
                
                    // 2. Headline
                Headline(type: .reading, heading: "Poster")
                
                    // 3. Image Carousel
                TabView {
                    ForEach(0..<3) { index in
                        Image("minutiae_poster_notification")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                            .clipped()
                            .cornerRadius(10)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .frame(height: UIScreen.main.bounds.width)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                
                    // 4. Selectable Buttons for Options
                VStack(spacing: 12) {
                    SelectableButton(
                        type: .multipleText,
                        texts: ["UNFRAMED", "Full Price", "$79", "$99"],
                        linkURL: nil,
                        isSelected: $isUnframedSelected
                    )
                    .onTapGesture {
                        isUnframedSelected = true
                        isFramedSelected = false
                    }
                    
                    SelectableButton(
                        type: .multipleText,
                        texts: ["FRAMED", "Full Price", "$139", "$159"],
                        linkURL: nil,
                        isSelected: $isFramedSelected
                    )
                    .onTapGesture {
                        isFramedSelected = true
                        isUnframedSelected = false
                    }
                }
                .padding()
                
                    // 5. Headline for Records
                Headline(type: .reading, heading: "Available Records:")
                
                    // 6. Record number selector
                HStack(spacing: 12) {
                    ForEach(1..<5) { i in
                        Text("\(i)")
                            .font(.xSmallHeadline)
                            .frame(width: 48, height: 48)
                            .background(
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(i == selectedRecord ? Color.black : Color.clear)
                            )
                            .foregroundColor(i == selectedRecord ? .white : .black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                            .onTapGesture {
                                selectedRecord = i
                            }
                    }
                }
                
                    // 7. Normal descriptive text
                Text("""
The minutiae 360 Edition contains all your captured moments over a one-year period. The spine is stamped with the participant’s initials and the corresponding record number.
""")
                .font(.custom("Rubik-Light", size: 20))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                
                    // 8. Bold notice text
                Text("Your Shipping address will be added after you press the continue button.")
                    .font(.custom("Rubik-Medium", size: 20))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                
                    // 9. BUY button
                SelectableButton(
                    type: .singleText,
                    texts: ["BUY"],
                    linkURL: nil,
                    isSelected: .constant(true)
                )
                
                    // 10. SHOP MORE button
                SelectableButton(
                    type: .externalLink,
                    texts: ["SHOP MORE"],
                    linkURL: URL(string: "https://minutiae-app.com/shop"),
                    isSelected: .constant(false)
                )
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 80)
            .frame(maxWidth: 512)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(Color(hex: "E6E6E6").ignoresSafeArea())
    }
}

#Preview {
    ProductView(product: sampleProduct)
}
