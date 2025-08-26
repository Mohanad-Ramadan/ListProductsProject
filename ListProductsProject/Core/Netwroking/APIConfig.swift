//
//  APIConfig.swift
//  MyNetworkingLayer
//
//  Created by Mohanad Ramdan on 10/01/2025.
//

import Foundation


class APIConfig {
    static let shared = APIConfig()
    
    private init() {}
    
    let baseURL = "fakestoreapi.com"
    var token: String = ""
}
