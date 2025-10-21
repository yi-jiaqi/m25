//
//  ShopView.swift
//  m25
//
//  Created by Jiaqi Yi on 2025.10.15.
//

import SwiftUI

struct ShopView: View {
    
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 30){
                ButtonsBar(
                    type: .setting,
                    onClose: { dismiss() } //
                )
                ScrollView{
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Headline(type: .shop, heading: "What's New").padding(.horizontal, 16)
                        let columns = [
                            GridItem(.flexible(), spacing: 6),
                            GridItem(.flexible(), spacing: 6)
                        ]
                        
                        LazyVGrid(columns: columns, spacing: 6) {
                            NavigationLink(destination: ProductView(product: sampleProduct)) {
                                News(type: .thumbImage,
                                     title: "Minutiae Poster",
                                     content: "From $199",
                                     image: Image("minutiae_poster_notification"))
                            }
                            NavigationLink(destination: ProductView(product: sampleProduct)) {
                                News(type: .thumbImage,
                                     title: "Minutiae Poster",
                                     content: "From $199",
                                     image: Image("minutiae_poster_notification"))
                            }
                            
                        }
                    }.padding(.horizontal, 16)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Headline(type: .shop, heading: "Books").padding(.horizontal, 16)
                        let columns = [
                            GridItem(.flexible(), spacing: 6),
                            GridItem(.flexible(), spacing: 6)
                        ]
                        
                        LazyVGrid(columns: columns, spacing: 6) {
                            NavigationLink(destination: ProductView(product: sampleProduct)) {
                                News(type: .thumbImage,
                                     title: " 360 Edition - One Year Book",
                                     content: "From $109",
                                     image: Image("minutiae_poster_notification"))
                            }
                            NavigationLink(destination: ProductView(product: sampleProduct)) {
                                News(type: .thumbImage,
                                     title: "1440 Edition - Four years",
                                     content: "From $249",
                                     image: Image("minutiae_poster_notification"))
                            }
                            NavigationLink(destination: ProductView(product: sampleProduct)) {
                                News(type: .thumbImage,
                                     title: "Limited Edition Book",
                                     content: "From $1440",
                                     image: Image("minutiae_poster_notification"))
                            }
                            
                        }
                    }.padding(.horizontal, 16)
                    
                    
                }
                
            }
            .background(Color(hex: "6C6C6C").ignoresSafeArea())
        }
    }
}

#Preview {
    ShopView()
}
