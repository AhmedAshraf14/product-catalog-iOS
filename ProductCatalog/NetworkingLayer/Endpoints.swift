//
//  Endpoints.swift
//  ProductCatalog
//
//  Created by Ahmed Ashraf on 27/01/2026.
//

import Foundation

enum Endpoints: RequestBase {

    case productsList(numberOfProducts: Int)

    var parameter: [String : String]? {
        switch self {
        case .productsList(numberOfProducts: let numberOfProducts):
            return ["limit" : "\(numberOfProducts)"]
        }
    }
}
