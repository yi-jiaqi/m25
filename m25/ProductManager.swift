//
//  ProductManager.swift
//  m25
//
//  Created by Jiaqi Yi on 2025.10.21.
//

import Foundation

class ProductManager: ObservableObject {
    static let shared = ProductManager()
    @Published var products: [ProductModel] = []
    
    private init() {
        loadProducts()
    }
    
    private func loadProducts() {
        guard let url = Bundle.main.url(forResource: "products", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("❌ Could not find products.json")
            return
        }
        
        do {
            let decoded = try JSONDecoder().decode([ProductModel].self, from: data)
            DispatchQueue.main.async {
                self.products = decoded
            }
        } catch {
            print("❌ Failed to decode products: \(error)")
        }
    }
}
