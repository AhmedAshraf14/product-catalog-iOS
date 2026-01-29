//
//  NetworkManager.swift
//  ProductCatalog
//
//  Created by Ahmed Ashraf on 27/01/2026.
//

import Foundation
import Combine

final class NetworkManager: Network {

    func execute<T>(_ request: RequestBase, model: T.Type) -> AnyPublisher<T, NetworkError> where T : Decodable {
        let request = request.asURLRequest()
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }

                guard 200..<300 ~= httpResponse.statusCode else {
                    throw NetworkError.invalidResponse
                }

                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let networkError = error as? NetworkError {
                    return networkError
                } else if let decodingError = error as? DecodingError {
                    return NetworkError.decodingError(decodingError)
                } else {
                    return NetworkError.unknown
                }
            }
            .eraseToAnyPublisher()
    }

}
