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

extension ProductManager {
    enum ProductCategory: String, CaseIterable {
        case book = "Books"
        case poster = "Posters"
        case other = "Others"
    }
    
    func products(for category: ProductCategory) -> [ProductModel] {
            // 1️⃣ Filter products by category (first digit)
        let filtered = products.filter { product in
            guard let code = product.code else { return false }
            switch category {
            case .book:   return code / 100 == 1
            case .poster: return code / 100 == 2
            case .other:  return code / 100 == 3
            }
        }
        
            // 2️⃣ Keep only the first product per two-digit prefix
        var seenPrefixes = Set<Int>()
        var uniqueProducts: [ProductModel] = []
        
        for product in filtered {
            if let code = product.code {
                let prefix = code / 10  // first two digits
                if !seenPrefixes.contains(prefix) {
                    seenPrefixes.insert(prefix)
                    uniqueProducts.append(product)
                }
            }
        }
        
        return uniqueProducts
    }
    
    func product(code: Int) -> ProductModel? {
        return products.first(where: { $0.code == code })
    }
}
