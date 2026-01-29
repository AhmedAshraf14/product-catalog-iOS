//
//  Connectivity.swift
//  ProductCatalog
//
//  Created by Ahmed Ashraf on 29/01/2026.
//

import Network
import Combine

protocol ConnectivityProtocol {
    func isConnected() -> AnyPublisher<Bool, Never>
}

final class Connectivity: ConnectivityProtocol {

    static let shared = Connectivity()
    private init() {}

    func isConnected() -> AnyPublisher<Bool, Never> {
        Future { promise in
            let monitor = NWPathMonitor()
            monitor.pathUpdateHandler = { path in
                promise(.success(path.status == .satisfied))
                monitor.cancel()
            }
            monitor.start(queue: .global())
        }
        .eraseToAnyPublisher()
    }
}
