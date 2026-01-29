//
//  ProductsViewModel.swift
//  ProductCatalog
//
//  Created by Ahmed Ashraf on 25/01/2026.
//

import Foundation
import Combine

protocol ProductsViewModelProtocol {
    var state: CurrentValueSubject<ViewState, Never> { get }
    func numberOfProducts() -> Int
    func product(at index: Int) -> Product
    func getProducts()
}

final class ProductsViewModel: ProductsViewModelProtocol {

    let state: CurrentValueSubject<ViewState, Never> = .init(.idle)

    private var products: [Product] = []
    private let useCase: ProductListUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()

    private var reachedLastItem = false
    private let limit = 7

    init(useCase: ProductListUseCaseProtocol = ProductListUseCase()) {
        self.useCase = useCase
    }

    func getProducts() {
        guard !reachedLastItem, state.value != .loading else { return }

        state.send(products.isEmpty ? .loading : .idle)

        useCase.fetchProducts(numberOfProducts: products.count + limit)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }

                if case .failure(let error) = completion {
                    state.send(.error(error.userFriendlyMessage))
                }
            } receiveValue: { [weak self] products in
                guard let self else { return }

                if self.products.count == products.count {
                    reachedLastItem = true
                    return
                }
                let newProductsCount = products.count - self.products.count
                self.products.append(contentsOf: products.suffix(newProductsCount))

                self.products.isEmpty
                ? state.send(.empty)
                : state.send(.loaded)
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

