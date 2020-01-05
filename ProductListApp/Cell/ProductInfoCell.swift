//
//  ProductInfoCell.swift
//  TurkcellTechnicalAssignment
//
//  Created by Darya Kuliashova on 11/18/19.
//  Copyright © 2019 Darya Kuliashova. All rights reserved.
//

import UIKit

final class ProductInfoCell: UICollectionViewCell {
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var productName: UILabel!
    @IBOutlet private weak var productPrice: UILabel!
    
    private let downloadManager = DownloadManager()
    
    var product: Product? {
        didSet {
            if let product = product {
                getImages()
                
                productName.text = product.name
                productPrice.text = "\(product.price)"
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        productImageView.image = nil
    }
    
    private func getImages() {
        if let product = product,
            let url = URL(string: product.image) {
            downloadManager.getProductImage(with: url, completion: { [weak self] image in
                self?.productImageView.image = image
            })
        }
    }
}

