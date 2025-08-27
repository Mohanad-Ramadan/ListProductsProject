//
//  ProductsListViewModel.swift
//  ListProductsProject
//
//  Created by Mohanad Ramdan on 26/08/2025.
//

import Foundation

protocol ProductsListViewModelDelegate: AnyObject {
    func didUpdateProducts()
    func didStartLoading()
    func didStopLoading()
}

class ProductsListViewModel {
    
    // MARK: - Properties
    private let apiProvider: APIProtocol
    
    private let initialPageCount = 7
    private var currentPage = 0
    private var isLoadingMore = false
    private var hasMoreData = true
    
    private(set) var products: [Product] = []
    
    weak var delegate: ProductsListViewModelDelegate?
    
    // MARK: - Initialization
    init(apiProvider: APIProtocol = APIClient()) {
        self.apiProvider = apiProvider
    }
    
    //MARK: - Data Fetching
    func loadInitialProducts() {
        resetPaginationState()
        loadProducts(isInitialLoad: true)
    }
    
    func loadMoreProductsIfPossible() {
        if !isLoadingMore && hasMoreData {
            loadProducts(isInitialLoad: false)
        }
    }
    
    private func resetPaginationState() {
        hasMoreData = true
        currentPage = 0
    }
    
    private func loadProducts(isInitialLoad: Bool) {
        guard shouldLoadMore(isInitialLoad: isInitialLoad) else { return }
        
        startLoading(isInitialLoad: isInitialLoad)
        
        let endpoint = createEndpoint()
        
        Task {
            defer { stopLoading(isInitialLoad: isInitialLoad) }
            
            do {
                let allProducts = try await fetchProducts(from: endpoint)
                let newProducts = filterNewProducts(from: allProducts, isInitialLoad: isInitialLoad)
                
                updateProductsAndPagination(with: newProducts, allProducts: allProducts, isInitialLoad: isInitialLoad)
            } catch {
                print("error: \(error)")
            }
        }
    }
    
    private func createEndpoint() -> APIEndpoint {
        let currentLimit = initialPageCount * Int(pow(2.0, Double(currentPage)))
        return APIEndpoint.getProducts(limit: currentLimit)
    }
    
    private func fetchProducts(from endpoint: APIEndpoint) async throws -> [Product] {
        let fetchedProducts = try await apiProvider.request(endpoint: endpoint, responseModel: [ProductModel].self)
        return fetchedProducts.map { Product(from: $0) }
    }
    
    // MARK: - State Management
    private func shouldLoadMore(isInitialLoad: Bool) -> Bool {
        return !isLoadingMore && (isInitialLoad || hasMoreData)
    }
    
    private func startLoading(isInitialLoad: Bool) {
        isLoadingMore = true
        if !isInitialLoad {
            delegate?.didStartLoading()
        }
    }
    
    private func stopLoading(isInitialLoad: Bool) {
        isLoadingMore = false
        if !isInitialLoad {
            delegate?.didStopLoading()
        }
    }
    
    // MARK: - Data Processing
    private func filterNewProducts(
        from allProducts: [Product],
        isInitialLoad: Bool
    ) -> [Product] {
        if isInitialLoad {
            return allProducts
        }
        
        // Get all existing product IDs to avoid duplicates
        let existingIds = Set(products.map { $0.id })
        
        // Filter out products that we already have
        return allProducts.filter { !existingIds.contains($0.id) }
    }
    
    private func updateProductsAndPagination(
        with newProducts: [Product],
        allProducts: [Product],
        isInitialLoad: Bool
    ) {
        // update pagination state
        currentPage += 1
        
        let currentLimit = initialPageCount * Int(pow(2.0, Double(currentPage - 1)))
        hasMoreData = newProducts.count > 0 && allProducts.count == currentLimit
        
        // update products
        if isInitialLoad {
            products = newProducts
        } else {
            products.append(contentsOf: newProducts)
        }
        
        delegate?.didUpdateProducts()
    }
}
