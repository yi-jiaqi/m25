    //
    //  NewsView.swift
    //  m25
    //
    //  Created by Jiaqi Yi on 2025.10.20.
    //

import SwiftUI

struct NewsView: View {
    @State private var showShop = false
    var body: some View {
        VStack(spacing: 20) { // Major group gap = 20
            
            Headline(type: .menu, heading: "News")
            ScrollView {
                News(type: .noImage, title: "Demo", content: "Quick demo on how the app works.")
                News(type: .littleImage, title: "Do not Disturb", content: "Set a time for when you don’t want to receive your minutiae notifications.", image: Image("minutiae_clock_square"))
                News(type: .bigImage, title: "NEW POSTERS AVAILABLE!", content: "", image: Image("minutiae_poster_notification")).onTapGesture {
                    showShop = true
                }
            }
            .background(Color(hex: "1D1D1D"))}
        .padding(.horizontal, 20)
        .fullScreenCover(isPresented: $showShop) {
            ShopView()
        }
    }
}

#Preview {
    NewsView().environmentObject(AppDataManager())
}
