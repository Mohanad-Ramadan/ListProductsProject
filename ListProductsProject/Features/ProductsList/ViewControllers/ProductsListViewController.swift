//
//  ProductsListViewController.swift
//  ListProductsProject
//
//  Created by Mohanad Ramdan on 26/08/2025.
//

import UIKit

class ProductsListViewController: UIViewController {
    
    // MARK: Properties
    private lazy var switchLayoutButton = UIBarButtonItem(
        image: UIImage(systemName: "square.grid.2x2"),
        style: .plain,
        target: self,
        action: #selector(toggleLayout)
    )
    
    private lazy var productsCollectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var productsCollectionViewManager = ProductsCollectionViewAdapter()

    private let apiProvider: APIProtocol = APIClient()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        setupNavigationBar()
        setupConstraints()
        setupCollectionView()
        setupNavigationBar()
        loadInitialProductsList()
    }
    
    // MARK: - Setup Views
    private func setupNavigationBar() {
        title = "Products:"
        navigationItem.rightBarButtonItem = switchLayoutButton
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc private func toggleLayout() {
        productsCollectionViewManager.switchLayout()
        let currentLayout = productsCollectionViewManager.currentLayout
        let buttonImage = currentLayout == .grid ? "list.bullet" : "square.grid.2x2"
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: buttonImage)
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
        productsCollectionViewManager.collectionView = productsCollectionView
        productsCollectionView.dataSource = productsCollectionViewManager
        productsCollectionView.delegate = productsCollectionViewManager
        productsCollectionView.register(
            ProductCollectionViewCell.self,
            forCellWithReuseIdentifier: ProductCollectionViewCell.identifier
        )
    }
    
    // MARK: - Data Loading
    private func loadInitialProductsList() {
        let endpoint = APIEndpoint.getProducts(limit: 7)
        Task {
            do {
                let fetchedProducts = try await apiProvider.request(endpoint: endpoint, responseModel: [ProductModel].self)
                let products = fetchedProducts.map { Product(from: $0) }
                productsCollectionViewManager.updateProducts(products)
                productsCollectionView.reloadData()
            } catch {
                throw error
            }
        }
    }
    
}
