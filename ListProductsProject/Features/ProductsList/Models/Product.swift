//
//  Product.swift
//  ListProductsProject
//
//  Created by Mohanad Ramdan on 26/08/2025.
//

import Foundation

struct ProductModel: Codable {
    let id: Int
    let title: String?
    let price: Double?
    let description: String?
    let category: String?
    let imageURL: String?
    let rating: ProductRating?
}

struct ProductRating: Codable {
    let rate: Double
    let count: Int
}
