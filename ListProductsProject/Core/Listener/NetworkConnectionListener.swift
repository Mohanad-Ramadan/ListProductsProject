//
//  NetworkConnectionListener.swift
//  ListProductsProject
//
//  Created by Mohanad Ramdan on 27/08/2025.
//

import SystemConfiguration

class NetworkConnectionListener {
    var isReachable: Bool = false
    private var connectionRestoredCallback: (() -> Void)?
    private var connectionLostCallback: (() -> Void)?
    static let shared = NetworkConnectionListener()
    
    private init() {
        startMonitoring()
    }
    
    func startMonitoring() {
        let reachability = SCNetworkReachabilityCreateWithName(nil, "www.google.com")
        var context = SCNetworkReachabilityContext()
        context.info = UnsafeMutableRawPointer(
            Unmanaged<NetworkConnectionListener>.passUnretained(self).toOpaque()
        )
        if SCNetworkReachabilitySetCallback(reachability!, { (reachability, flags, info) in
            if let info = info {
                let manager = Unmanaged<NetworkConnectionListener>.fromOpaque(info).takeUnretainedValue()
                manager.networkStatusChanged(flags: flags)
            }
        }, &context) {
            SCNetworkReachabilitySetDispatchQueue(reachability!, DispatchQueue.main)
        }
    }
    
    private func networkStatusChanged(flags: SCNetworkReachabilityFlags) {
        let isReachable = flags.contains(.reachable)
        let wasReachable = self.isReachable
        self.isReachable = isReachable
        
        if !wasReachable && isReachable {
            connectionRestoredCallback?()
        } else if wasReachable && !isReachable {
            connectionLostCallback?()
        }
    }
    
    func setNetworkCallbacks(restored: (() -> Void)?, lost: (() -> Void)?) {
        connectionRestoredCallback = restored
        connectionLostCallback = lost
        self.startMonitoring()
    }
    
    // MARK: - Testing Methods (for development only)
    #if DEBUG
    func simulateNetworkLoss() {
        let wasReachable = isReachable
        isReachable = false
        if wasReachable {
            connectionLostCallback?()
        }
    }
    
    func simulateNetworkRestoration() {
        let wasReachable = isReachable
        isReachable = true
        if !wasReachable {
            connectionRestoredCallback?()
        }
    }
    #endif
}
