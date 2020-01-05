//
//  APIClient.swift
//  TurkcellTechnicalAssignment
//
//  Created by Darya Kuliashova on 11/21/19.
//  Copyright © 2019 Darya Kuliashova. All rights reserved.
//

import Foundation
import Alamofire

final class APIClient {
    static let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        return URLSession.init(configuration: config)
    }()
    
    class func fetch<T: Decodable>(route: Router, completion: @escaping (Result<T, Error>) -> Void) {
        
        APIClient.session.dataTask(with: route.asURL()) { (data, response, error) in
            
            if let error = error as NSError? {
                let networkError = NetworkError(errorCode: error.code)
                DispatchQueue.main.async {
                    completion(.failure(networkError))
                }
                return
            }
            guard let data = data, error == nil else {
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
                return
            }
            do {
                let decoder = JSONDecoder()
                let product = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(product))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
