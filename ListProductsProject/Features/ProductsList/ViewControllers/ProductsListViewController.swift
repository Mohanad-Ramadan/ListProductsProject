//
//  ProductsListViewController.swift
//  ListProductsProject
//
//  Created by Mohanad Ramdan on 26/08/2025.
//

import UIKit

class ProductsListViewController: UIViewController {
    
    // MARK: Properties
    private lazy var productsCollectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var productsCollectionViewManager = ProductsCollectionViewAdapter()

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupCollectionView()
        setupCollectionViewLayout()
        loadInitialProductsList()
    }
    
    
    // MARK: - Setup View
    private func setupView() {
        title = "Products:"
        view.backgroundColor = .systemGroupedBackground
    }
    
    private func setupCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        productsCollectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    private func setupConstraints() {
        view.addSubview(productsCollectionView)
        
        NSLayoutConstraint.activate([
            productsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            productsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupCollectionView() {
        productsCollectionView.dataSource = productsCollectionViewManager
        productsCollectionView.delegate = productsCollectionViewManager
        productsCollectionView.register(
            ProductCollectionViewCell.self,
            forCellWithReuseIdentifier: ProductCollectionViewCell.identifier
        )
    }
    
    // MARK: - Data Loading
    private func loadInitialProductsList() {
        let sampleProducts = [
            Product(id: "1", name: "iPhone 15 Pro", price: 999.99, imageURL: nil),
            Product(id: "2", name: "MacBook Air M2", price: 1199.99, imageURL: nil),
            Product(id: "3", name: "iPad Air", price: 599.99, imageURL: nil),
            Product(id: "4", name: "Apple Watch Series 9", price: 399.99, imageURL: nil),
            Product(id: "5", name: "AirPods Pro", price: 249.99, imageURL: nil),
            Product(id: "6", name: "iMac 24-inch", price: 1299.99, imageURL: nil),
            Product(id: "7", name: "Mac mini M2", price: 599.99, imageURL: nil),
            Product(id: "8", name: "Apple TV 4K", price: 179.99, imageURL: nil)
        ]
        
        productsCollectionViewManager.updateProducts(sampleProducts)
        productsCollectionView.reloadData()
    }
    
}
