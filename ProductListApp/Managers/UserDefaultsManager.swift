//
//  UserDefaultsManager.swift
//  TurkcellTechnicalAssignment
//
//  Created by Darya Kuliashova on 11/22/19.
//  Copyright © 2019 Darya Kuliashova. All rights reserved.
//

import Foundation

final class UserDefaultsManager {
    func saveProductsToUserDefaults(products: [Product]) {
        if let encoded = try? JSONEncoder().encode(products) {
            UserDefaults.standard.set(encoded, forKey: Constants.savedProducts)
        }
    }
    
    func loadProductsFromUserDefaults() -> [Product] {
        guard let data = UserDefaults.standard.value(forKey: Constants.savedProducts) as? Data,
            let loadedProducts = try? JSONDecoder().decode([Product].self, from: data) else {
            return []
        }
        return loadedProducts
    }
    
    func saveProductToUserDefaults(product: Product) {
        var oldProducts = loadProductsFromUserDefaults()
        
        if let index = oldProducts.firstIndex(where: { $0.product_id == product.product_id }) {
            oldProducts.remove(at: index)
            oldProducts.insert(product, at: index)
        }

        saveProductsToUserDefaults(products: oldProducts)
    }
    
    func loadProductFromUserDefaults(by productId: String) -> Product? {
        let loadedProducts = loadProductsFromUserDefaults()
        
        let product = loadedProducts.first(where: { $0.product_id == productId })
        return product
    }
}
