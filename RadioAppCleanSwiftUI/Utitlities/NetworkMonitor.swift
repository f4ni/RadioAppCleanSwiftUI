//
//  NetworkMonitor.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 20.08.2024.
//

import Observation
import Network
import SwiftUI

@Observable
final class NetworkMonitor {
    
    let monitor = NWPathMonitor()
    
    var connected: Bool = false
    
    init() {
        startMonitoring()
    }
    
    func startMonitoring () {
        
        monitor.pathUpdateHandler  = { [weak self] path in
            guard let self else { return }
            self.connected = path.status == .satisfied
        }
        monitor.start(queue: DispatchQueue.global(qos: .background))
    }
    
    deinit {
        monitor.cancel()
    }
}

struct NetworkMonitorKey: EnvironmentKey {
    static let defaultValue: NetworkMonitor = NetworkMonitor()
}

extension EnvironmentValues {
    var network: NetworkMonitor {
        get { self[NetworkMonitorKey.self] }
        set { self[NetworkMonitorKey.self] = newValue}
    }
}
