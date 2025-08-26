//
//  ProductsCollectionViewAdapter.swift
//  ListProductsProject
//
//  Created by Mohanad Ramdan on 26/08/2025.
//

import UIKit

protocol ProductsCollectionViewAdapterDelegate: AnyObject {
    func didReachEndOfScroll()
}

class ProductsCollectionViewAdapter: NSObject {
    var products: [Product] = []
    var currentLayout: LayoutType = .list
    weak var collectionView: UICollectionView?
    weak var delegate: ProductsCollectionViewAdapterDelegate?
}
