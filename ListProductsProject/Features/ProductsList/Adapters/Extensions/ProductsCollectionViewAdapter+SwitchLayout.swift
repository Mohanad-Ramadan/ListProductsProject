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
extension ProductsCollectionViewAdapter {
    
    func switchLayout() {
        guard let collectionView = collectionView else { return }
        
        currentLayout = currentLayout == .grid ? .list : .grid
        
        let newLayout: UICollectionViewFlowLayout = switch currentLayout {
        case .grid:
            setupGridLayout(in: collectionView)
        case .list:
            setupListLayout(in: collectionView)
        }
        
        collectionView.setCollectionViewLayout(newLayout, animated: true)
    }
    
    private func setupGridLayout(in collectionView: UICollectionView) -> UICollectionViewFlowLayout {
        let width = collectionView.bounds.width
        let padding: CGFloat = 12
        let minimumSpacing: CGFloat = 10
        let avatarsRowWidth = width - padding*2 - minimumSpacing*2
        let itemWidth = avatarsRowWidth / 3
        
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowlayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        flowlayout.minimumLineSpacing = 10
        flowlayout.minimumInteritemSpacing = minimumSpacing
        
        return flowlayout
    }
    
    private func setupListLayout(in collectionView: UICollectionView) -> UICollectionViewFlowLayout {
        let width = collectionView.bounds.width
        let padding: CGFloat = 12
        
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowlayout.itemSize = CGSize(width: width - padding*2, height: 100)
        flowlayout.minimumLineSpacing = 8
        flowlayout.minimumInteritemSpacing = 0
        
        return flowlayout
    }
}

//MARK: - FlowLayout Delegate
extension ProductsCollectionViewAdapter: UICollectionViewDelegateFlowLayout {
    
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
