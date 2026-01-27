//
//  ProductsViewModel.swift
//  ProductCatalog
//
//  Created by Ahmed Ashraf on 25/01/2026.
//

import Foundation

protocol ProductsViewModelProtocol {
    func numberOfProducts() -> Int
    func product(at index: Int) -> Product
}

final class ProductsViewModel: ProductsViewModelProtocol {

    private var products: [Product] = []

    init() {
        products = Product.mockProducts
    }

    func numberOfProducts() -> Int {
        return products.count
    }

    func product(at index: Int) -> Product {
        return products[index]
    }
}
