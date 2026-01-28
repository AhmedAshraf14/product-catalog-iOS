//
//  RequestBase.swift
//  ProductCatalog
//
//  Created by Ahmed Ashraf on 27/01/2026.
//

import Foundation

protocol RequestBase {
    var baseURL: String {get}
    var scheme: String {get}
    var method: HTTPMethod {get}
    var path: String {get}
    var parameter: [String: String]? {get}
}

extension RequestBase {
    var scheme: String {
        return "https"
    }

    var baseURL: String {
        return "fakestoreapi.com"
    }

    var path: String {
        return "/products"
    }

    var method: HTTPMethod {
        return .get
    }
}

extension RequestBase {
    func asURLRequest() -> URLRequest {
        var component: URLComponents = URLComponents()
        component.scheme = self.scheme
        component.host = self.baseURL
        component.path = self.path

        if let parameter = self.parameter {
            component.queryItems = parameter
                .map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        var urlRequest = URLRequest(url: component.url!)
        urlRequest.httpMethod = self.method.rawValue
        return urlRequest
    }
}

enum HTTPMethod: String {
    case get = "GET"
}
