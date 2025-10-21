import SwiftUI

struct MenuView: View {
    let sections = ["News", "Progress", "About", "Shop", "Credits"]
    
    @Environment(\.dismiss) private var dismiss
    @State private var showGrid = false
    
    /*
     TODO:
     1. Snapping in vertical card swiping;
     2. Dots indicator of segments;
     3. Export the icon of M and Done Button from Storyboards/Main.storyboard
     4. Confirmation of Rubik-light & Rubik-regular & Rubik-medium is correctly loaded
     5. Correct snapping;
     */
    
    // MARK: - Horizontal Tab View (Replaces Vertical Cards)
    @State private var currentTab = 0
    let tabCount = 5 // News, Progress, About, Shop, Credits
    
    var body: some View {
        ZStack {
            Color(hex: "1D1D1D").ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                    // MARK: - Fixed Header
                VStack(spacing: 0) {
                    ButtonsBar(
                        type: .menu,
                        onMenu: {
                                // Close menu and reopen GridView
                            dismiss()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                withAnimation(nil) {
                                    showGrid = true
                                }
                            }
                        }
                    )
                    .padding(.bottom,30)
                    
//                    Rectangle()
//                        .foregroundColor(.clear)
//                        .frame(width: 115, height: 115)
//                        .background(
//                            Image("logo")
//                                .resizable()
//                                .scaledToFit()
//                                .opacity(0.5)
//                        )
                }
                .background(Color(hex: "1D1D1D"))
                .padding(.bottom,30)
                .zIndex(1)
                
                    // MARK: - Tab Content
                ZStack(alignment: .bottom) {
                    TabView(selection: $currentTab) {
                            // Each content page
                        NewsView()
                            .tag(0)
                        ProgressView()
                            .tag(1)
                        AboutView()
                            .tag(2)
                        LittleShopView()
                            .tag(3)
                        CreditsView()
                            .tag(4)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .ignoresSafeArea()
                    
                        // Static Indicator (does not move)
                    HStack(spacing: 8) {
                        ForEach(0..<tabCount, id: \.self) { index in
                            Circle()
                                .fill(index == currentTab ? Color.white : Color.gray)
                                .frame(width: 8, height: 8)
                        }
                    }
                    .padding(.bottom, 30)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .fullScreenCover(isPresented: $showGrid) {
            GridView()
                .transaction { t in t.animation = nil }
        }
        .onChange(of: currentTab) { newValue in
            if newValue == tabCount {
                currentTab = 0
            } else if newValue < 0 {
                currentTab = tabCount - 1
            }
        }
    }
}
#Preview {
    MenuView()
}
