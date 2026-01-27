//
//  Product.swift
//  ProductCatalog
//
//  Created by Ahmed Ashraf on 25/01/2026.
//

import Foundation

struct Product {
    let id: Int
    let title: String
    let price: Double
    let description, category: String
    let image: String
    let rating: Rating
}

struct Rating {
    let rate: Double
    let count: Int
}
