//
//  APIEndpoint.swift
//  MyNetworkingLayer
//
//  Created by Mohanad Ramdan on 10/01/2025.
//

import Foundation

enum APIEndpoint: EndpointProvider {
    
    case getProducts(limit: Int)
    
    var path: String {
        switch self {
        case .getProducts:
            return "/products"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getProducts:
            return .get
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getProducts(let limit):
            return [URLQueryItem(name: "limit", value: "\(limit)")]
        }
    }
    
    var body: [String: Any]? {
        switch self {
        default:
            return nil
        }
    }
}


// POST Method Body creation
extension Encodable {
    var toDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
