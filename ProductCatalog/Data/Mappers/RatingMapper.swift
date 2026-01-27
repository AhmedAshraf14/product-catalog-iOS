//
//  RatingMapper.swift
//  ProductCatalog
//
//  Created by Ahmed Ashraf on 27/01/2026.
//

import Foundation

struct RatingMapper {
    func map(_ dto: RatingDTO) -> Rating {
        Rating(
            rate: dto.rate,
            count: dto.count
        )
    }
}
