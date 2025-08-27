//
//  ProductsCollectionViewAdapter+ProductsDataSource.swift
//  ListProductsProject
//
//  Created by Mohanad Ramdan on 26/08/2025.
//

import UIKit

//MARK: - DataSource Delegate
extension ProductsCollectionViewManager: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.products.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
        guard let product = viewModel?.products[indexPath.item] else {
            return cell
        }
        cell.setupContent(with: product)
        cell.applyLayout(currentLayout)
        return cell
    }
}
