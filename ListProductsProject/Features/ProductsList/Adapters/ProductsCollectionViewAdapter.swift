//
//  ProductsCollectionViewAdapter.swift
//  ListProductsProject
//
//  Created by Mohanad Ramdan on 26/08/2025.
//

import UIKit

class ProductsCollectionViewAdapter: NSObject {
    var products: [Product] = []
    var currentLayout: LayoutType = .grid
    weak var collectionView: UICollectionView?
}
