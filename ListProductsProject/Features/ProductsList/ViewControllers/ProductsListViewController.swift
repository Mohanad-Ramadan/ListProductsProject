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
    private let viewModel = ProductsListViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        
        setupNavigationBar()
        setupConstraints()
        setupCollectionViewManager()
        setupCollectionView()
        
        setupViewModel()
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
    
    private func setupViewModel() {
        viewModel.delegate = self
        viewModel.loadInitialProducts()
    }
    
}

// MARK: - ProductsListViewModelDelegate
extension ProductsListViewController: ProductsListViewModelDelegate {
    
    func didUpdateProducts() {
        productsCollectionViewManager.updateProducts(
            with: viewModel.products,
            isInitialLoad: productsCollectionViewManager.products.isEmpty
        )
        
        DispatchQueue.main.async { [weak self] in
            self?.productsCollectionView.reloadData()
        }
    }
    
    func didStartLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.loadingIndicator.startAnimating()
        }
    }
    
    func didStopLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.loadingIndicator.stopAnimating()
        }
    }
}

// MARK: - ProductsCollectionViewAdapterDelegate
extension ProductsListViewController: ProductsCollectionViewAdapterDelegate {
    
    func didReachEndOfScroll() {
        viewModel.loadMoreProductsIfPossible()
    }
    
}
