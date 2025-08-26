//
//  ProductsCollectionViewAdapter+ProductsDataSource.swift
//  ListProductsProject
//
//  Created by Mohanad Ramdan on 26/08/2025.
//

import UIKit

//MARK: - Data Management
extension ProductsCollectionViewAdapter {
    
    func updateProducts(with products: [Product], isInitialLoad: Bool) {
        if isInitialLoad {
            self.products = products
        } else {
            self.products.append(contentsOf: products)
        }
    }
    
}

//MARK: - DataSource Delegate
extension ProductsCollectionViewAdapter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
        
        let product = products[indexPath.item]
        cell.setupContent(with: product)
        return cell
    }
}
