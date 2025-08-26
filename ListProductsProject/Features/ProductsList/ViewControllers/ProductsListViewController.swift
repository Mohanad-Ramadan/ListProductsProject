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
        collectionView.alwaysBounceVertical = true
        return collectionView
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private var productsCollectionViewManager = ProductsCollectionViewAdapter()
    private let apiProvider: APIProtocol = APIClient()
    
    private let productsPageCount = 7
    private var isLoadingMore = false
    private var hasMoreData = true
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        setupNavigationBar()
        setupConstraints()
        setupCollectionViewManager()
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
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            productsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            productsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupCollectionViewManager() {
        productsCollectionViewManager.collectionView = productsCollectionView
        productsCollectionViewManager.delegate = self
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
        hasMoreData = true
        loadProducts(isInitialLoad: true)
    }
    
    private func loadProducts(isInitialLoad: Bool = false) {
        guard !isLoadingMore && (isInitialLoad || hasMoreData) else { return }
        
        isLoadingMore = true
        if !isInitialLoad {
            loadingIndicator.startAnimating()
        }
        let endpoint = APIEndpoint.getProducts(limit: productsPageCount)
        
        Task {
            defer {
                isLoadingMore = false
                if !isInitialLoad {
                    loadingIndicator.stopAnimating()
                }
            }
            
            do {
                let fetchedProducts = try await apiProvider.request(endpoint: endpoint, responseModel: [ProductModel].self)
                let products = fetchedProducts.map { Product(from: $0) }
                
                productsCollectionViewManager.updateProducts(
                    with: products,
                    isInitialLoad: isInitialLoad
                )
                
                self.hasMoreData = products.count == self.productsPageCount
                
                self.productsCollectionView.reloadData()
            } catch {
                print("Error loading products: \(error)")
            }
        }
    }
    
}

// MARK: - ProductsCollectionViewAdapterDelegate
extension ProductsListViewController: ProductsCollectionViewAdapterDelegate {

    func didReachEndOfScroll() {
        if !isLoadingMore && hasMoreData {
            loadProducts()
        }
    }
    
}
