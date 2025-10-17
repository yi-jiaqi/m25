//
//  GridView.swift
//  m25
//
//  Created by Jiaqi Yi on 2025.10.17.
//

import SwiftUI

struct GridView: View {
    @State private var selectedTab = 0
    @State private var showInfoModal = false
    @State private var isDateVisible = [false, false, false, false, false]
    @State private var zoomScale: CGFloat = 1.0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(0..<5, id: \.self) { index in
                GridPageView(
                    index: index,
                    showInfoModal: $showInfoModal,
                    isDateVisible: $isDateVisible[index],
                    zoomScale: $zoomScale
                )
                .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic)) // ✅ show page indicator
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .ignoresSafeArea()
        .sheet(isPresented: $showInfoModal) {
            GridViewModal() // to be implemented later
                .presentationDetents([.fraction(0.4)])
        }
    }
}

#Preview {
    GridView()
}

struct GridPageView: View {
    let index: Int
    @Binding var showInfoModal: Bool
    @Binding var isDateVisible: Bool
    @Binding var zoomScale: CGFloat
    
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
                ButtonsBar(type: .grid)
                    .padding(.top, 20)
                    .onTapGesture {} // prevents tap passing through
                Spacer()
            }
        }
        .frame(width: UIScreen.main.bounds.width,
               height: UIScreen.main.bounds.height)
        .ignoresSafeArea(.all)
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
    var body: some View {
        VStack(spacing: 20) {
            Text("Grid Info")
                .font(.custom("Rubik-Medium", size: 24))
            Text("This will show contextual information about the current grid.")
                .font(.custom("Rubik-Light", size: 18))
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.ultraThinMaterial)
    }
}
