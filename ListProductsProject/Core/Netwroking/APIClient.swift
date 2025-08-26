//
//  APIClient.swift
//  MyNetworkingLayer
//
//  Created by Mohanad Ramdan on 10/01/2025.
//

import Foundation


//MARK: - APIProtocol
protocol APIProtocol {
    func request<T: Decodable>(endpoint: EndpointProvider, responseModel: T.Type) async throws -> T
}


//MARK: - APIClint
final class APIClient: APIProtocol {
    
    var session: URLSession {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration)
    }
    
    func request<T: Decodable>(endpoint: EndpointProvider, responseModel: T.Type) async throws -> T {
        do {
            let apiRequest = try endpoint.asURLRequest()
            let (data, response) = try await session.data(for: endpoint.asURLRequest())
            NetworkLogger.shared.logNetworkRequest(apiRequest, response: response, data: data)
            return try self.manageResponse(data: data, response: response)
        } catch let error as NetworkError {
            print("‼️‼️", error)
            throw error
        } catch {
            print("‼️‼️", error)
            throw error
        }
    }
}


//MARK: - Response Manage
extension APIClient {
    
    private func manageResponse<T: Decodable>(data: Data, response: URLResponse) throws -> T {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown(NSError(domain: "Invalid response", code: 0))
        }
        
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}
