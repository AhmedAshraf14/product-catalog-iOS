//
//  ProductsViewModel.swift
//  ProductCatalog
//
//  Created by Ahmed Ashraf on 25/01/2026.
//

import Foundation
import Combine

protocol ProductsViewModelProtocol {
    var loading: PassthroughSubject<Bool, Never> { get }
    var errorMessage: PassthroughSubject<String, Never> { get }
    func numberOfProducts() -> Int
    func product(at index: Int) -> Product
    func getProducts()
}

final class ProductsViewModel: ProductsViewModelProtocol {

    let loading = PassthroughSubject<Bool, Never>()
    let errorMessage = PassthroughSubject<String, Never>()

    private var products: [Product] = []
    private let useCase: ProductListUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    private var reachedLastItem = false
    private let limit = 10

    init(useCase: ProductListUseCaseProtocol = ProductListUseCase()) {
        self.useCase = useCase
    }

    func getProducts() {
        guard !reachedLastItem else { return }

        loading.send(true)

        useCase.fetchProducts(numberOfProducts: products.count + limit)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                loading.send(false)

                if case .failure(let error) = completion {
                    errorMessage.send(error.userFriendlyMessage)
                }
            } receiveValue: { [weak self] products in
                guard let self else { return }

                if self.products.count == products.count {
                    reachedLastItem = true
                    return
                }

                self.products.append(contentsOf: products.suffix(limit))
            }
            .store(in: &cancellables)
    }

    func numberOfProducts() -> Int {
        return products.count
    }

    func product(at index: Int) -> Product {
        return products[index]
    }
}

