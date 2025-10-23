//
//  ShopView.swift
//  m25
//
//  Created by Jiaqi Yi on 2025.10.15.
//

import SwiftUI

struct ShopView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var productManager = ProductManager.shared
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    ButtonsBar(type: .setting, onClose: { dismiss() })
                    
                    ForEach(ProductManager.ProductCategory.allCases, id: \.self) { category in
                        let products = productManager.products(for: category)
                        if !products.isEmpty {
                            SectionView(category: category, products: products)
                        }
                    }
                }
                .padding(.bottom, 60)
            }
            .background(Color(hex: "6C6C6C").ignoresSafeArea())
            .ignoresSafeArea(.all)
        }
    }
}


#Preview {
    ShopView()
}

struct SectionView: View {
    let category: ProductManager.ProductCategory
    let products: [ProductModel]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Headline(type: .shop, heading: category.rawValue)
                .padding(.horizontal, 16)
            
            let columns = [
                GridItem(.flexible(), spacing: 6),
                GridItem(.flexible(), spacing: 6)
            ]
            
            LazyVGrid(columns: columns, spacing: 6) {
                ForEach(products, id: \.self) { product in
                    NavigationLink(destination: ProductView(product: product)) {
                        VStack(alignment: .leading, spacing: 0) {
                            News(type: .thumbImage,
                                 title: product.title,
                                 content: product.demonstratedPrice,
                                 image: Image(product.images.first ?? "minutiae_poster_notification"))
                        }
                        .frame(maxWidth: .infinity, alignment: .top)
                    }
                }
            }
        }
        .padding(.horizontal, 16)
    }
}
