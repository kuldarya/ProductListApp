//
//  DownloadManager.swift
//  TurkcellTechnicalAssignment
//
//  Created by Darya Kuliashova on 11/20/19.
//  Copyright © 2019 Darya Kuliashova. All rights reserved.
//

import Foundation
import UIKit

final class DownloadManager {
    static let shared = DownloadManager()
    
    func getProductImage(with url: URL, completion: @escaping (UIImage?) -> Void) {
        let fileManager = FileManager.default
        
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent("\(url.absoluteString.md5())")
                    
        if !fileManager.fileExists(atPath: fileURL.path) {
            DispatchQueue.global().async {
                do {
                    let data = try Data(contentsOf: url)
                    try data.write(to: fileURL)
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        completion(image)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
        } else {
            do {
                let data = try Data(contentsOf: fileURL)
                let image = UIImage(data: data)
                completion(image)
            } catch {
                completion(nil)
            }
        }
    }
}
