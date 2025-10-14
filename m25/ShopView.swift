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
                VStack(spacing: 12) {
                    Image("constellation_posters") // Replace with your asset name
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .shadow(radius: 6)
                    
                    Text("[NEW] Constellation Posters - Four Years")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding(.top, 20)
                
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
            .background(Color(.systemBackground))
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    ShopView()
}
