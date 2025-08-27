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
    
    private var productsCollectionViewManager = ProductsCollectionViewManager()
    private let viewModel = ProductsListViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        
        setupNavigationBar()
        setupViewModel()
        setupConstraints()
        setupCollectionViewManager()
        setupCollectionView()
        
        monitorConnectionLost()
    }
    
    // MARK: - Setup Views
    private func setupNavigationBar() {
        title = "Products"
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
        productsCollectionViewManager.viewModel = viewModel
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
        viewModel.loadMoreProductsIfPossible()
    }
    
    private func monitorConnectionLost() {
        let networkListener = NetworkConnectionListener.shared
        guard networkListener.isReachable else {
            Toast.showError("No Internet Connection", in: self.view)
            return
        }
        
        networkListener.setNetworkCallbacks(
            restored: { [weak self] in
                guard let self else { return }
                viewModel.handleReloadProducts()
            },
            lost: { [weak self] in
                guard let self else { return }
                Toast.showError("No Internet Connection", in: self.view)
        })
    }
    
}

// MARK: - ViewModel Delegate
extension ProductsListViewController: ProductsListViewModelDelegate {
    
    func didUpdateProducts() {
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
    
    func didFailLoadingProducts(withError error: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            Toast.showError(error, in: self.view)
        }
    }
    
}

// MARK: - Products Manager Delegate
extension ProductsListViewController: ProductsCollectionViewManagerDelegate {
    
    func didReachEndOfScroll() {
        viewModel.loadMoreProductsIfPossible()
    }
    
    func didSelectProduct(_ product: Product) {
        let productDetailsVC = ProductDetailsViewController(product: product)
        navigationController?.pushViewController(productDetailsVC, animated: true)
    }
    
}
