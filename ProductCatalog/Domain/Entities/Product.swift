//
//  Product.swift
//  ProductCatalog
//
//  Created by Ahmed Ashraf on 25/01/2026.
//

import Foundation

struct Product: Decodable {
    let id: Int
    let title: String
    let price: Double
    let description, category: String
    let image: String
    let rating: Rating
}

struct Rating: Decodable {
    let rate: Double
    let count: Int
}

extension Product {
    #warning("This is just a mock for testing the UI")
    static var mockProducts: [Product] {
        let json = """
        [
            {
                "id": 1,
                "title": "Fjallraven - Foldsack No. 1 Backpack",
                "price": 109.95,
                "description": "Your perfect pack for everyday use.",
                "category": "men's clothing",
                "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png",
                "rating": {"rate": 3.9, "count": 120}
            },
            {
                "id": 2,
                "title": "Mens Casual Premium Slim Fit T-Shirts",
                "price": 22.3,
                "description": "Slim-fitting style, contrast raglan long sleeve.",
                "category": "men's clothing",
                "image": "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_t.png",
                "rating": {"rate": 4.1, "count": 259}
            },
            {
                "id": 3,
                "title": "Mens Cotton Jacket",
                "price": 55.99,
                "description": "Great outerwear jackets for Spring/Autumn/Winter.",
                "category": "men's clothing",
                "image": "https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_t.png",
                "rating": {"rate": 4.7, "count": 500}
            },
            {
                "id": 4,
                "title": "Mens Casual Slim Fit",
                "price": 15.99,
                "description": "The color could be slightly different between screen and practice.",
                "category": "men's clothing",
                "image": "https://fakestoreapi.com/img/71YXzeOuslL._AC_UY879_t.png",
                "rating": {"rate": 2.1, "count": 430}
            },
            {
                "id": 5,
                "title": "John Hardy Naga Bracelet",
                "price": 695,
                "description": "Mythical water dragon inspired design.",
                "category": "jewelery",
                "image": "https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_t.png",
                "rating": {"rate": 4.6, "count": 400}
            },
            {
                "id": 6,
                "title": "Solid Gold Petite Micropave",
                "price": 168,
                "description": "Satisfaction Guaranteed.",
                "category": "jewelery",
                "image": "https://fakestoreapi.com/img/61sbMiUnoGL._AC_UL640_QL65_ML3_t.png",
                "rating": {"rate": 3.9, "count": 70}
            },
            {
                "id": 7,
                "title": "White Gold Plated Princess",
                "price": 9.99,
                "description": "Classic Wedding Engagement Solitaire.",
                "category": "jewelery",
                "image": "https://fakestoreapi.com/img/71YAIFU48IL._AC_UL640_QL65_ML3_t.png",
                "rating": {"rate": 3, "count": 400}
            }
        ]
        """.data(using: .utf8)!
        
        do {
            return try JSONDecoder().decode([Product].self, from: json)
        } catch {
            print("Decoding error: \(error)")
            return []
        }
    }
}
