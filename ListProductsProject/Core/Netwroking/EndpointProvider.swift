//
//  EndpointProvider.swift
//  MyNetworkingLayer
//
//  Created by Mohanad Ramdan on 20/07/2024.
//

import Foundation


protocol EndpointProvider {
    var scheme: String { get }
    var baseURL: String { get }
    var token: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var body: [String: Any]? { get }
}


extension EndpointProvider {
    var scheme: String {
        return "https"
    }
    
    var baseURL: String {
        return APIConfig.shared.baseURL
    }
    
    var token: String {
        return APIConfig.shared.token
    }
    
    func asURLRequest() throws -> URLRequest {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = baseURL
        urlComponents.path = path
        
        if let queryItems = queryItems {
            urlComponents.queryItems = queryItems
        }
        
        guard let url = urlComponents.url else {
            throw NetworkError.unknown(
                NSError(
                    domain: "url components error: \(urlComponents)",
                    code: 0
                )
            )
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        if let body = body {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            } catch {
                throw NetworkError.unknown(NSError(domain: "error serializing body to json: \(error)", code: 0))
            }
        }
        
        return urlRequest
    }
}
