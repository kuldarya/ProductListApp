//
//  Product.swift
//  TurkcellTechnicalAssignment
//
//  Created by Darya Kuliashova on 11/18/19.
//  Copyright © 2019 Darya Kuliashova. All rights reserved.
//

import Foundation

struct Product: Codable {
    let product_id: String
    let name: String
    let price: Int
    let image: String
    let description: String?
}
