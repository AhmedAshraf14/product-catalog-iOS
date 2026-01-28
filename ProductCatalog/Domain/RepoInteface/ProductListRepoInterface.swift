//
//  ProductListRepoInterface.swift
//  ProductCatalog
//
//  Created by Ahmed Ashraf on 27/01/2026.
//

import Foundation
import Combine

protocol ProductListRepoInterface {
    func fetchProducts(numberOfProducts: Int) -> AnyPublisher<[Product], NetworkError>
}
