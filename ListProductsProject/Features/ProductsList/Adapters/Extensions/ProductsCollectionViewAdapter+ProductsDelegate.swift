//
//  ProductsCollectionViewAdapter+ProductsDelegate.swift
//  ListProductsProject
//
//  Created by Mohanad Ramdan on 26/08/2025.
//

import UIKit

//MARK: - CollectionView Delegate
extension ProductsCollectionViewAdapter: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = viewModel?.products[indexPath.item]
        print("Selected product: \(product?.title)")
    }
    
}

// MARK: - Scroll Delegate
extension ProductsCollectionViewAdapter: UIScrollViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        
        let threshold = contentHeight - (screenHeight - 100)
        
        if offsetY >= threshold {
            delegate?.didReachEndOfScroll()
        }
    }
    
}
