//
//  ProductDTO.swift
//  ProductCatalog
//
//  Created by Ahmed Ashraf on 27/01/2026.
//

import Foundation

struct ProductDTO: Decodable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: RatingDTO
}

struct RatingDTO: Decodable {
    let rate: Double
    let count: Int
}
