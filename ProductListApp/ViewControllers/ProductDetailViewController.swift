//
//  ProductDetailViewController.swift
//  TurkcellTechnicalAssignment
//
//  Created by Darya Kuliashova on 11/18/19.
//  Copyright © 2019 Darya Kuliashova. All rights reserved.
//

import UIKit
import Foundation

final class ProductDetailViewController: UIViewController {
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var productName: UILabel!
    @IBOutlet private weak var productDescription: UILabel!
    
    private let downloadManager = DownloadManager.shared
    private let userDefaultsManager = UserDefaultsManager()
    private let productAPIClient = ProductAPIClient()
    
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadProductFromUserDefaults()
        getProductDetails()
        getImages()
    }
    
    private func loadProductFromUserDefaults() {
        if var product = product,
            let loadedProduct = userDefaultsManager.loadProductFromUserDefaults(by: product.product_id) {
            product = loadedProduct
            productName.text = product.name
            productDescription.text = product.description
        }
    }
    
    private func getProductDetails() {
        guard let product = product else {
            return
        }
        
        productAPIClient.fetchProduct(id: product.product_id) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let product):
                self.product = product
            case .failure(let error):
                UIAlertController.showError(error: error, controller: self)
            }
        }
    }
    
    func getImages() {
        if let product = product, let url = URL(string: product.image) {
            downloadManager.getProductImage(with: url, completion: { [weak self] image in
                guard let self = self else {
                    return
                }
                self.productImageView.image = image
            })
        }
    }
}
