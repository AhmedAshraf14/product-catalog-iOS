//
//  ProductListRepo.swift
//  ProductCatalog
//
//  Created by Ahmed Ashraf on 27/01/2026.
//

import Foundation
import Combine

final class ProductListRepo: ProductListRepoInterface {
    
    private let network: Network
    private let connectivity: ConnectivityProtocol

    init(
        network: Network = NetworkManager(),
        connectivity: ConnectivityProtocol = Connectivity.shared
    ) {
        self.network = network
        self.connectivity = connectivity
    }

    func fetchProducts(numberOfProducts: Int) -> AnyPublisher<[Product], NetworkError> {
        return connectivity.isConnected()
            .flatMap { [weak self] isConnected -> AnyPublisher<[Product], NetworkError> in
                guard let self else { return Fail(error: .unknown).eraseToAnyPublisher() }
                guard isConnected else {
                    return Fail(error: .noInternetConnection)
                        .eraseToAnyPublisher()
                }

                return fetchFromNetwork(numberOfProducts: numberOfProducts)
            }
            .eraseToAnyPublisher()
    }


    private func fetchFromNetwork(numberOfProducts: Int) -> AnyPublisher<[Product], NetworkError> {
        let request = Endpoints.productsList(numberOfProducts: numberOfProducts)
        let mapper = ProductMapper()

        return network
            .execute(request, model: [ProductDTO].self)
            .map { $0.map(mapper.map) }
            .eraseToAnyPublisher()
    }
}
