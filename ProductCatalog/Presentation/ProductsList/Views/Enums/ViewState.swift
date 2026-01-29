//
//  ViewState.swift
//  ProductCatalog
//
//  Created by Ahmed Ashraf on 29/01/2026.
//

import Foundation

enum ViewState: Equatable {
    case idle
    case loading
    case loaded
    case empty
    case error(String)
}
