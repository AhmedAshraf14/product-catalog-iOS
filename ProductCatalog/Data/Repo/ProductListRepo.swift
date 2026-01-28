//
//  ProductListRepo.swift
//  ProductCatalog
//
//  Created by Ahmed Ashraf on 27/01/2026.
//

import Foundation
import Combine

final class ProductListRepo: ProductListRepoInterface {
    
    let network: Network

    init(network: Network = NetworkManager()) {
        self.network = network
    }

    func fetchProducts(numberOfProducts: Int) -> AnyPublisher<[Product], NetworkError> {
        let request = Endpoints.productsList(numberOfProducts: numberOfProducts)
        let model = [ProductDTO].self
        let response = network.execute(request, model: model)

        let mapper = ProductMapper()

        return response
            .map { $0.map(mapper.map) }
            .eraseToAnyPublisher()
    }
}
