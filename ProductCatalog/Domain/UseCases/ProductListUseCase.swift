//
//  ProductListUseCase.swift
//  ProductCatalog
//
//  Created by Ahmed Ashraf on 27/01/2026.
//

import Foundation
import Combine

protocol ProductListUseCaseProtocol {
    func fetchProducts(numberOfProducts: Int) -> AnyPublisher<[Product], NetworkError>
}

final class ProductListUseCase: ProductListUseCaseProtocol {

    let repo: ProductListRepoInterface

    init(repo: ProductListRepoInterface = ProductListRepo()) {
        self.repo = repo
    }

    func fetchProducts(numberOfProducts: Int) -> AnyPublisher<[Product], NetworkError> {
        repo.fetchProducts(numberOfProducts: numberOfProducts)
    }
}
