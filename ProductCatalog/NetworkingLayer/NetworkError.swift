//
//  NetworkError.swift
//  ProductCatalog
//
//  Created by Ahmed Ashraf on 27/01/2026.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noInternetConnection
    case requestFailed(Error)
    case invalidResponse
    case decodingError(Error)
    case serverError(statusCode: Int)
    case unknown
    
    var userFriendlyMessage: String {
        switch self {
        case .noInternetConnection:
            return "You're offline. Showing cached data."
        case .serverError:
            return "Something went wrong. Please try again later."
        default:
            return "An error occurred. Please try again."
        }
    }
}
