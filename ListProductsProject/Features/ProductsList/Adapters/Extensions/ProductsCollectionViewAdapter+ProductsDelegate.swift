//
//  ProductsCollectionViewAdapter+ProductsDelegate.swift
//  ListProductsProject
//
//  Created by Mohanad Ramdan on 26/08/2025.
//

import UIKit

extension ProductsCollectionViewAdapter: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = products[indexPath.item]
        print("Selected product: \(product.title)")
    }
    
}
