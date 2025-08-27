//
//  Product.swift
//  ListProductsProject
//
//  Created by Mohanad Ramdan on 27/08/2025.
//

import Foundation

struct Product {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let imageURL: String?
    let rating: ProductRating?
    
    init(from data: ProductModel) {
        self.id = data.id
        self.title = data.title ?? "N/A"
        self.price = data.price ?? 0.0
        self.description = data.description ?? "N/A"
        self.category = data.category ?? "N/A"
        self.imageURL = data.image
        self.rating = data.rating
    }
}
