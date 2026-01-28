//
//  Network.swift
//  ProductCatalog
//
//  Created by Ahmed Ashraf on 27/01/2026.
//

import Foundation
import Combine

protocol Network {
    func execute<T: Decodable>(_ request: RequestBase, model: T.Type) -> AnyPublisher<T, NetworkError>
}
