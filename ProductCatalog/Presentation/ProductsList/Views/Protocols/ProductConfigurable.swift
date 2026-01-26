//
//  ProductConfigurable.swift
//  ProductCatalogTest
//
//  Created by Ahmed Ashraf on 25/01/2026.
//

import UIKit
import Kingfisher

protocol ProductConfigurable: AnyObject where Self: UIView {
    var productImageView: UIImageView! { get }
    var productTitle: UILabel! { get }
    var productPrice: UILabel! { get }
    var productRate: UILabel! { get }
}

extension ProductConfigurable {
    func configure(with product: Product) {
        productTitle.text = product.title
        productPrice.text = "\(product.price)$"
        productRate.text = "\(product.rating.rate)"

        if let url = URL(string: product.image) {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                productImageView.kf.setImage(with: url)
            }
        }
    }

    func resetProductUI() {
        productImageView.image = nil
        productTitle.text = nil
        productPrice.text = nil
        productRate.text = nil
    }
}
