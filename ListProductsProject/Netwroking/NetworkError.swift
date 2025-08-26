//
//  NetworkError.swift
//  MyNetworkingLayer
//
//  Created by Mohanad Ramdan on 10/01/2025.
//

import Foundation

//MARK: - APIError
enum NetworkError: Error {
    case invalidURL
    case decodingError
    case serverError(statusCode: Int)
    case unknown(Error)
}
