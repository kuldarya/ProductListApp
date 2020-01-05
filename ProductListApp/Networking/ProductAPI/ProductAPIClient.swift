//
//  ProductAPIClient.swift
//  TurkcellTechnicalAssignment
//
//  Created by Darya Kuliashova on 11/18/19.
//  Copyright © 2019 Darya Kuliashova. All rights reserved.
//

import Foundation
import Alamofire

final class ProductAPIClient {
    
    func fetchAllProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        APIClient.fetch(route: ProductAPIRouter.getAll) { (result: Result<[String: [Product]], Error>) in
            switch result {
            case .success(let dict):
                let products = dict["products"] ?? []
                UserDefaultsManager().saveProductsToUserDefaults(products: products)
                completion(.success(products))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchProduct(id: String, completion: @escaping (Result<Product, Error>) -> Void) {
        APIClient.fetch(route: ProductAPIRouter.get(id: id)) { (result: Result<Product, Error>) in
            switch result {
            case .success(let product):
                UserDefaultsManager().saveProductToUserDefaults(product: product)
                completion(.success(product))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
