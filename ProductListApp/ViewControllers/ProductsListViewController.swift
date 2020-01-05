//
//  ProductsListViewController.swift
//  TurkcellTechnicalAssignment
//
//  Created by Darya Kuliashova on 11/18/19.
//  Copyright © 2019 Darya Kuliashova. All rights reserved.
//

import UIKit
import Alamofire

final class ProductsListViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let productAPIClient = ProductAPIClient()
    private let userDefaultsManager = UserDefaultsManager()
    
    var productsList = [Product]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        productsList = userDefaultsManager.loadProductsFromUserDefaults()
        
        getAllProducts()
    }
    
    private func getAllProducts() {
        productAPIClient.fetchAllProducts { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let products):
                self.productsList = products
            case .failure(let error):
                UIAlertController.showError(error: error, controller: self)
            }
        }
    }
}

extension ProductsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductInfoCell.className, for: indexPath) as? ProductInfoCell else {
            assertionFailure()
            return UICollectionViewCell()
        }
        cell.product = productsList[indexPath.item]
        
        return cell
    }
}

extension ProductsListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let controller = UIStoryboard.mainStoryboard?.instantiateVC(ProductDetailViewController.self) else {
            assertionFailure()
            return
        }
        controller.product = productsList[indexPath.item]
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension ProductsListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 25
        let collectionCellSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionCellSize / 2, height: collectionCellSize / 2)
    }
}
