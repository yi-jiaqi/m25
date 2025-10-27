//
//  LittleShopView.swift
//  m25
//
//  Created by Jiaqi Yi on 2025.10.14.
//

import Foundation
import SwiftUI

struct LittleShopView: View {
    @State private var showShopView = false   // ✅ state to control fullscreen modal
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Headline(type: .menu, heading: "Shop")
                ScrollView {
                    VStack(spacing: 40) {
                            // MARK: - News Section
                        Button {
                            showShopView = true
                        } label: {
                            News(
                                type: .veryBigImage,
                                title: "[NEW] Constellation Posters - Four Years",
                                content: "From $199",
                                image: Image("minutiae_poster_notification")
                            )
                        }
                        .buttonStyle(PlainButtonStyle()) // ✅ prevents highlight
                        
                        Spacer()
                        
                            // MARK: - About-style Text Section
                        VStack(spacing: 20) {
                            Button {
                                showShopView = true
                            } label: {
                                Text("SHOP")
                                    .font(.smallHeadline)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color(hex: "FFFFFF"))
                            }
                            
                            Button {
                                showShopView = true
                            } label: {
                                Text("GIFT")
                                    .font(.smallHeadline)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color(hex: "FFFFFF"))
                            }
                        }
        
                    }
                    .background(Color(hex: "1D1D1D"))
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 60)
            .background(Color(hex: "1D1D1D"))
            .navigationBarBackButtonHidden(true)
            .fullScreenCover(isPresented: $showShopView) {
                ShopView()
            }
        }
    }
}

#Preview {
    LittleShopView()
}
