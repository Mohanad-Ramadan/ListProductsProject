//
//  NetworkLogger.swift
//  MyNetworkingLayer
//
//  Created by Mohanad Ramdan on 27/08/2025.
//

import Foundation
import OSLog

class NetworkLogger {
    static let shared = NetworkLogger()
    
    private init() {}
    
    private let networkLogger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "network")
    
    func logNetworkRequest(_ request: URLRequest, response: URLResponse?, data: Data?) {
        Task {
            var completeLog = """
            •••••••
            URL: \(request.url?.absoluteString ?? "Unknown URL")
            Method: \(request.httpMethod ?? "Unknown method")
            Headers: \(request.allHTTPHeaderFields?.description ?? "No headers")
            """
            
            // Add request body if exists
            if let httpBody = request.httpBody,
               let bodyString = String(data: httpBody, encoding: .utf8) {
                completeLog += "\nRequest Body: \(bodyString)"
            }
            
            // Add response details
            completeLog += "\n⁂⁂⁂⁂"
            if let data = data {
                let responseSize = ByteCountFormatter.string(fromByteCount: Int64(data.count), countStyle: .file)
                completeLog += "\nsize: \(responseSize)"
                
                if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
                   let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                    let prettyJSONData = String(decoding: jsonData, as: UTF8.self)
                    completeLog += "\nbody: \(prettyJSONData)"
                } else {
                    completeLog += "\nbody: json data malformed"
                }
                
            }
            
            // Log everything in a single debug message
            networkLogger.debug("\(completeLog, privacy: .private)")
        }
    }
}
