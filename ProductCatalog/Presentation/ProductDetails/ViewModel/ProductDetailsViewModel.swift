//
//  ProductDetailsViewModel.swift
//  ProductCatalog
//
//  Created by Ahmed Ashraf on 27/01/2026.
//

import Foundation

protocol ProductDetailsViewModelProtocol {
    func productInfo() -> Product
}

final class ProductDetailsViewModel: ProductDetailsViewModelProtocol {

    private let product: Product

    init(product: Product) {
        self.product = product
    }

    func productInfo() -> Product {
        return product
    }
}
