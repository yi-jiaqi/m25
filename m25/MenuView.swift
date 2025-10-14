import SwiftUI

struct MenuView: View {
    let sections = ["News", "Progress", "About", "Shop", "Credits"]
    let safeTopInset = UIApplication.shared.safeAreaInsets.top
    let safeBottomInset = UIApplication.shared.safeAreaInsets.bottom
    /*
     TODO:
     1. Snapping in vertical card swiping;
     2. Dots indicator of segments;
     3. Export the icon of M and Done Button from Storyboards/Main.storyboard
     4. Confirmation of Rubik-light & Rubik-regular & Rubik-medium is correctly loaded
     */
    var body: some View {
        VStack(spacing: 0) {
            
                // MARK: - Fixed Header
            VStack(spacing: 0) {
                ButtonsBar(type: .menu)
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 135, height: 135)
                    .background(
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .opacity(0.5)
                    )
            }
            .background(Color(hex: "1D1D1D"))
            .zIndex(1)
            
                // MARK: - Vertical Cards
            GeometryReader { proxy in
                let cardHeight = proxy.size.height - safeTopInset - safeBottomInset
                ScrollViewReader { scrollProxy in
                        // Use @State for currentIndex and drag offset
                    SnapScrollView(
                        sections: sections,
                        cardHeight: cardHeight,
                        width: proxy.size.width,
                        scrollProxy: scrollProxy
                    )
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color(hex: "1D1D1D"))
    }
}

extension UIApplication {
    var safeAreaInsets: UIEdgeInsets {
        connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?.safeAreaInsets ?? .zero
    }
}

#Preview {
    MenuView()
}


    // MARK: - SnapScrollView Implementation
struct SnapScrollView: View {
    let sections: [String]
    let cardHeight: CGFloat
    let width: CGFloat
    let scrollProxy: ScrollViewProxy
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 80) {
                ForEach(Array(sections.enumerated()), id: \.element) { idx, title in
                    Group {
                        switch title {
                        case "News":
                            // MARK: - NEWS
                            /*
                             TODO:
                             1. News(type: .bigImage should have a responsive height adjustment;
                             2. Heading's Z index will be finalized with logo, after all adjustments;
                             */
                            VStack {
                                Headline(type: .menu, heading: title)
                                News(type: .noImage, title: "Demo", content: "Quick demo on how the project works.")
                                News(type: .littleImage, title: "Do not Disturb", content: "Set a time for when you don’t want to receive your minutiae notifications.",image: Image("minutiae_clock_square"))
                                News(type: .bigImage, title: "NEW POSTERS AVAILABLE!", content: "We’ve just launched a new design of annual posters, inspired by the stars and constellations. ",image: Image("minutiae_poster_notification"))
                            }
                            .frame(
                                width: width,
                                height: cardHeight
                            )
                        case "Progress":
                                // MARK: - PROGRESS
                            /*
                             TODO:
                             1. Add API for fetching data; Applying to Grid;
                             2.
                             */
                            VStack {
                                Headline(type: .menu, heading: title)
                                Spacer()
                                ProgressView()
                            }
                            .frame(
                                width: width,
                                height: cardHeight
                            )
                        case "About":
                                // MARK: - ABOUT
                            VStack {
                                Headline(type: .menu, heading: title)
                                AboutView()
                            }
                            .frame(
                                width: width,
                                height: cardHeight
                            )
                        case "Shop":
                                // MARK: - SHOP
                            VStack {
                                Headline(type: .menu, heading: title)
                                Spacer()
                            }
                            .frame(
                                width: width,
                                height: cardHeight
                            )
                        case "Credits":
                                // MARK: - CREDITS
                            VStack {
                            Headline(type: .menu, heading: title)
                            Spacer()
                        }
                        .frame(
                            width: width,
                            height: cardHeight
                        )
                        default:
                            VStack {
                                Headline(type: .menu, heading: title)
                                Spacer()
                            }
                        }
                    }
                    .frame(width: width, height: cardHeight)
                    .background(Color(hex: "1D1D1D"))
                    .id(idx)
                }
            }
            .padding(.vertical, 20)
        }
        .content.offset(y: -CGFloat(currentIndex) * (cardHeight + 80) + dragOffset)
        .gesture(
            DragGesture()
                .updating($dragOffset) { value, state, _ in
                    state = value.translation.height
                }
                .onEnded { value in
                    let threshold: CGFloat = cardHeight / 3
                    var newIndex = currentIndex
                    if value.translation.height < -threshold, currentIndex < sections.count - 1 {
                        newIndex += 1
                    } else if value.translation.height > threshold, currentIndex > 0 {
                        newIndex -= 1
                    }
                    withAnimation(.spring()) {
                        currentIndex = newIndex
                        scrollProxy.scrollTo(newIndex, anchor: .top)
                    }
                }
        )
        .onChange(of: currentIndex) { idx in
            withAnimation(.spring()) {
                scrollProxy.scrollTo(idx, anchor: .top)
            }
        }
    }
}
