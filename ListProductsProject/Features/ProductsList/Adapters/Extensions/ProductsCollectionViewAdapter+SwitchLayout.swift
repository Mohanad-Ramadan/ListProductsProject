//
//  ProductsCollectionViewAdapter+FlowLayout.swift
//  ListProductsProject
//
//  Created by Mohanad Ramdan on 26/08/2025.
//

import UIKit

//MARK: - Layouts
enum LayoutType {
    case grid
    case list
}

//MARK: - Switch Layout Logic
extension ProductsCollectionViewManager {
    
    func switchLayout() {
        guard let collectionView = collectionView else { return }
        currentLayout = currentLayout == .grid ? .list : .grid
        
        UIView.animate(withDuration: 0.4) {
            collectionView.reloadData()
            collectionView.layoutIfNeeded()
        }
    }
}

//MARK: - FlowLayout Delegate
extension ProductsCollectionViewManager: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let padding: CGFloat = 12
        
        switch currentLayout {
        case .grid:
            let minimumSpacing: CGFloat = 10
            let avatarsRowWidth = width - padding*2 - minimumSpacing*2
            let itemWidth = avatarsRowWidth / 3
            return CGSize(width: itemWidth, height: itemWidth + 40)
        case .list:
            return CGSize(width: width - padding*2, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch currentLayout {
        case .grid:
            return 10
        case .list:
            return 8
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch currentLayout {
        case .grid:
            return 10
        case .list:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let padding: CGFloat = 12
        return UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    }
}
