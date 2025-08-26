//
//  ProductsCollectionViewAdapter.swift
//  ListProductsProject
//
//  Created by Mohanad Ramdan on 26/08/2025.
//

import UIKit

class ProductsCollectionViewAdapter: NSObject {
    private var products: [Product] = []
    
    func updateProducts(_ products: [Product]) {
        self.products = products
    }
    
    func addProducts(_ newProducts: [Product]) {
        self.products.append(contentsOf: newProducts)
    }
}

// MARK: - FlowLayout
extension ProductsCollectionViewAdapter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 20
        return CGSize(width: width, height: 100)
    }
}

// MARK: - DataSource
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

// MARK: - Collection Delegate
extension ProductsCollectionViewAdapter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = products[indexPath.item]
        print("Selected product: \(product.name)")
    }
}
