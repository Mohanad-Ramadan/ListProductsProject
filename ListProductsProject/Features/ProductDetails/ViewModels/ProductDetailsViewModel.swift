//
//  ProductDetailsViewModel.swift
//  ListProductsProject
//
//  Created by Mohanad Ramdan on 27/08/2025.
//

import Foundation
import UIKit


class ProductDetailsViewModel {
    
    // MARK:  Properties
    private let product: Product
    
    var productTitle: String {
        return product.title
    }
    
    var productPrice: String {
        return String(format: "$%.2f", product.price)
    }
    
    var productDescription: String {
        return product.description
    }
    
    var productCategory: String {
        return product.category.capitalized
    }
    
    var productRating: String {
        guard let rating = product.rating else { return "No rating" }
        return String(format: "%.1f", rating.rate)
    }
    
    var productRatingCount: String {
        guard let rating = product.rating else { return "" }
        return "(\(rating.count) reviews)"
    }
    
    var productImageURL: String? {
        return product.imageURL
    }
    
    var hasRating: Bool {
        return product.rating != nil
    }
    
    // MARK: - Initialization
    init(product: Product) {
        self.product = product
    }
}
