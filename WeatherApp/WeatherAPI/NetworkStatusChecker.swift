//
//  NetworkStatusChecker.swift
//  WeatherApp
//
//  Created by Slava Stepanov on 23/12/2023.
//

import Network

protocol NetworkStatusProtocol {
    func isOffline() -> Bool
}

class NetworkStatusChecker: NetworkStatusProtocol {
    private let monitor: NWPathMonitor
    private let queue = DispatchQueue(label: "NetworkMonitor")

    init() {
        monitor = NWPathMonitor()
        monitor.start(queue: queue)
    }

    func isOffline() -> Bool {
        return monitor.currentPath.status == .unsatisfied
    }
}
