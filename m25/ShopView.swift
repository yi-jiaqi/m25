//
//  ShopView.swift
//  m25
//
//  Created by Jiaqi Yi on 2025.10.14.
//

import Foundation
import SwiftUI

struct ShopView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                
                    // MARK: - News Section
                News(type: .veryBigImage, title: "[NEW] Constellation Posters - Four Years", content: "_", image: Image("minutiae_poster_notification"))
                
                    // MARK: - About-style Text Section
                VStack(spacing: 20) {
                    Text("SHOP")
                        .font(.system(size: 22, weight: .semibold))
                        .multilineTextAlignment(.center)
                    
                    Text("GIFT minutiae")
                        .font(.system(size: 20, weight: .light))
                        .multilineTextAlignment(.center)
                }
                .padding(.bottom, 40)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    ShopView()
}
