//
//  ProductMapper.swift
//  ProductCatalog
//
//  Created by Ahmed Ashraf on 27/01/2026.
//

import Foundation

struct ProductMapper {
    func map(_ dto: ProductDTO) -> Product {
        Product(
            id: dto.id,
            title: dto.title,
            price: dto.price,
            description: dto.description,
            category: dto.category,
            image: dto.image,
            rating: RatingMapper().map(dto.rating)
        )
    }
}
