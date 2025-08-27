//
//  ProductsCollectionViewManager.swift
//  ListProductsProject
//
//  Created by Mohanad Ramdan on 26/08/2025.
//

import UIKit

protocol ProductsCollectionViewManagerDelegate: AnyObject {
    func didReachEndOfScroll()
}

class ProductsCollectionViewManager: NSObject {
    var viewModel: ProductsListViewModel?
    var currentLayout: LayoutType = .list
    weak var collectionView: UICollectionView?
    weak var delegate: ProductsCollectionViewManagerDelegate?
}
