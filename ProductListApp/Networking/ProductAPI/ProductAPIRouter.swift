//
//  ProductAPIRouter.swift
//  TurkcellTechnicalAssignment
//
//  Created by Darya Kuliashova on 11/27/19.
//  Copyright © 2019 Darya Kuliashova. All rights reserved.
//

import Foundation

enum ProductAPIRouter: Router {
    case getAll
    case get(id: String)
    
    var path: String {
        switch self {
        case .getAll:
            return "/cart/list"
        case .get(let id):
            return "/cart/\(id)/detail"
        }
    }
    
    func asURL() -> URL {
        if let url = URL(string: Constants.basePath)?.appendingPathComponent(path) {
            return url
        } else {
            fatalError("URL can't be nil.")
        }
    }
}
