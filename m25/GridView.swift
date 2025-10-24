    //
    //  GridView.swift
    //  m25
    //
    //  Created by Jiaqi Yi on 2025.10.17.
    //

import SwiftUI

struct GridView: View {
    @EnvironmentObject var appData: AppDataManager
    @State private var selectedTab = 0
    @State private var showInfoModal = false
    @State private var activeTabIndex: Int? = nil
    @State private var isDateVisible = [false, false, false, false, false]
    @State private var zoomScale: CGFloat = 1.0
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                if let user = appData.userState {
                    let yearCount = max(1, min(user.currentYearIndex + 1, 4)) // Year 0 (Collection) + 1..N
                    ForEach((0...yearCount).reversed(), id: \.self) { index in
                        GridPageView(
                            index: index,
                            showInfoModal: $showInfoModal,
                            activeTabIndex: $activeTabIndex,
                            isDateVisible: $isDateVisible[index],
                            zoomScale: $zoomScale
                        )
                        .tag(index)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .ignoresSafeArea()
            
                // ✅ Overlay modal on top of everything
            if showInfoModal, let tabIndex = activeTabIndex {
                GridViewModal(tabIndex: tabIndex, isVisible: $showInfoModal)
                    .environmentObject(appData)
                    .transition(.opacity)
                    .zIndex(10)
                    .background(Color.clear) // ensures no white background
                    .presentationBackground(.clear)
            }
        }
        .animation(.easeInOut, value: showInfoModal)
        
    }
}

#Preview {
    GridView()
}

struct GridPageView: View {
    let index: Int
    @Binding var showInfoModal: Bool
    @Binding var activeTabIndex: Int?
    @Binding var isDateVisible: Bool
    @Binding var zoomScale: CGFloat
    @State private var showMenu = false
    
    var body: some View {
        ZStack(alignment: .top) {
                // Background image (full screen)
            ZoomableScrollView(scale: $zoomScale) {
                Image(isDateVisible ? gridDateImageName : gridImageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width,
                           height: UIScreen.main.bounds.height)
                    .clipped()
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isDateVisible.toggle()
                        }
                    }
            }
            .ignoresSafeArea(.all)
            
                // Buttons bar overlay
            VStack {
                ButtonsBar(type: .grid,
                           onInfo: {
                    activeTabIndex = index // ✅ store which page triggered it
                    showInfoModal = true
                },
                           onMenu: {     withAnimation(nil) {
                    showMenu = true
                } })
                .padding(.top, 20)
                .onTapGesture {} // prevents tap passing through
                Spacer()
            }
        }
        .frame(width: UIScreen.main.bounds.width,
               height: UIScreen.main.bounds.height)
        .ignoresSafeArea(.all)
        .fullScreenCover(isPresented: $showMenu) {
            MenuView()
                .transaction { t in
                    t.animation = nil
                }
        }
    }
    
    private var gridImageName: String {
        index == 0 ? "minutiae_grid_1440" : "minutiae_grid_360"
    }
    private var gridDateImageName: String {
        index == 0 ? "minutiae_grid_date_1440" : "minutiae_grid_date_360"
    }
}

struct ZoomableScrollView<Content: View>: UIViewRepresentable {
    @Binding var scale: CGFloat
    var content: () -> Content
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
        scrollView.bouncesZoom = true
        scrollView.delegate = context.coordinator
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        let hostedView = context.coordinator.hostingController.view!
        hostedView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(hostedView)
        
        NSLayoutConstraint.activate([
            hostedView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostedView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hostedView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostedView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            hostedView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            hostedView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        context.coordinator.hostingController.rootView = AnyView(content())
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: ZoomableScrollView
        var hostingController: UIHostingController<AnyView>
        
        init(parent: ZoomableScrollView) {
            self.parent = parent
            self.hostingController = UIHostingController(rootView: AnyView(parent.content()))
        }
        
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            hostingController.view
        }
        
        func scrollViewDidZoom(_ scrollView: UIScrollView) {
            parent.scale = scrollView.zoomScale
        }
    }
}



struct GridViewModal: View {
    var tabIndex: Int // 0 for Collection View, 1 for Record 1, etc.
    @Binding var isVisible: Bool
    @Environment(\.dismiss) private var dismiss
    
        // MARK: - Applied values
    @EnvironmentObject var appData: AppDataManager
    
    private var capturedCount: Int {
        guard let user = appData.userState else { return 0 }
        
        if tabIndex == 0 {
                // Sum of all captured moments across 4 years
            return user.eachYearCapturedMoments.reduce(0, +)
        } else {
            return user.eachYearCapturedMoments[tabIndex - 1]
        }
    }
    
    private var remainingCount: Int {
        guard let user = appData.userState else { return 0 }
        
        if tabIndex == 0 {
                // Total remaining moments out of 1440
            return max(1440 - user.passedDays, 0)
        } else {
            let endOfThisYear = tabIndex * 360
            return max(endOfThisYear - user.passedDays, 0)
        }
    }
    
    private var progress: Double {
        guard let user = appData.userState else { return 0 }
        
        if tabIndex == 0 {
                // Overall progress for 1440-day cycle
            let value = Double(user.passedDays) / 1440.0
            return min(max(value, 0), 1)
        } else {
            let value = user.eachYearProgress[tabIndex - 1]
            return min(max(value, 0), 1)
        }
    }
    
    @State private var showPosterProduct = false
    @State private var showBookProduct = false
    @State private var showReadingFAQ = false
        // MARK: - Dates
    private var startDate: Date {
        guard let user = appData.userState else { return Date() }
        if tabIndex == 0 { return user.startingDate }
        return Calendar.current.date(byAdding: .day, value: (tabIndex - 1) * 360, to: user.startingDate) ?? user.startingDate
    }
    
    private var endDate: Date {
        guard let user = appData.userState else { return Date() }
        if tabIndex == 0 { return user.finishingDate }
        return Calendar.current.date(byAdding: .day, value: (tabIndex) * 360, to: user.startingDate) ?? user.finishingDate
    }
    
        // MARK: - Date Formatter
    private var dateFormatter: DateFormatter {
        let f = DateFormatter()
        f.dateFormat = "yyyy.MM.dd"
        return f
    }
    
    private var thisBook: ProductModel? {
            // tabIndex 1–4 correspond to year 1–4
        let year = max(1, min(tabIndex, 4)) // clamp between 1–4
        let code = 110 + year // → 111, 112, 113, 114
        return ProductManager.shared.product(code: code)
    }
    
    private var thisPoster: ProductModel? {
        let year = max(1, min(tabIndex, 4))
        let code = 230 + year // → 231, 232, 233, 234
        return ProductManager.shared.product(code: code)
    }
    
    var body: some View {
        NavigationStack{
            ZStack {
                    // Background overlay (tapping outside dismisses)
                Color.black.opacity(0.001)
                    .blendMode(.destinationOver)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isVisible = false
                        }
                    }
                
                    // Modal content
                VStack(spacing: 20) {
                        // 1. Title
                    Text(tabIndex == 0 ? "COLLECTION VIEW" : "RECORD \(tabIndex)")
                        .font(.smallHeadline)
                        .foregroundColor(.white)
                        .textCase(.uppercase)
                    
                        // 2. Date Range + Progress
                    VStack(spacing: 0) {
                        HStack {
                            Text(dateFormatter.string(from: startDate))
                            Spacer()
                            Text(dateFormatter.string(from: endDate))
                        }
                        .font(.smallBodyText)
                        .foregroundColor(.white)
                        .padding(.horizontal, 4)
                        
                            // Progress bar
                        GeometryReader { geo in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: geo.size.height / 2)
                                    .fill(Color(hex: "C6C6C6"))
                                    .frame(width: geo.size.width+8)
                                RoundedRectangle(cornerRadius: geo.size.height / 4)
                                    .fill(Color(hex: "6C6C6C"))
                                    .frame(width: geo.size.width * progress,height:8)
                                    .offset(x:4)
                            }
                        }
                        .frame(height: 16)
                        .padding(.vertical, 8)
                        
                        HStack {
                            Text("Captured: \(capturedCount)")
                            Spacer()
                            if remainingCount == 0{
                                Text("Finished!")
                            }else{
                                Text("Remaining: \(remainingCount)")
                            }
                        }
                        .font(.smallBodyText)
                        .foregroundColor(.white)
                        .padding(.horizontal, 4)
                    }
                    
                        // 3. Demo text section
                    VStack(spacing: 12) {
                            // Always show DEMO
                        Text("DEMO")
                            .font(.xSmallHeadline)
                            .foregroundColor(.white)
                            .textCase(.uppercase)
                        
                            // Conditional content
                        if progress < 1.0 {
                                // Show "WHEN I FINISH..." only
                            Button("WHEN I FINISH...") {
                                showReadingFAQ = true
                            }
                            .font(.xSmallHeadline)
                            .foregroundColor(.white)
                            .textCase(.uppercase)
                        } else {
                                // Show "ORDER BOOK" and "ORDER POSTER"
                            Button("ORDER BOOK") {
                                showBookProduct = true
                            }
                            .font(.xSmallHeadline)
                            .foregroundColor(.white)
                            .textCase(.uppercase)
                            
                            Button("ORDER POSTER") {
                                showPosterProduct = true
                            }
                            .font(.xSmallHeadline)
                            .foregroundColor(.white)
                            .textCase(.uppercase)
                        }
                    }
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 25)
                .background(Color(hex: "6C6C6C"))
                .cornerRadius(10)
                .padding(.horizontal, 30)
            }
        }
        .fullScreenCover(isPresented: $showBookProduct) {
            if let thisBook = thisBook {
                ProductView(product: thisBook)
            } else {
                Text("Book not found.")
            }
        }
        .fullScreenCover(isPresented: $showPosterProduct) {
            if let thisPoster = thisPoster {
                ProductView(product: thisPoster)
            } else {
                Text("Poster not found.")
            }
        }.fullScreenCover(isPresented: $showReadingFAQ) {
            ReadingView(initialPage: 3)
        } .background(Color.clear) // ensures no white background
            .presentationBackground(.clear)
    }
}


