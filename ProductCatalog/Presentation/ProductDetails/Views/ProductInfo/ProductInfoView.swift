//
//  ProductInfoView.swift
//  ProductCatalog
//
//  Created by Ahmed Ashraf on 27/01/2026.
//

import UIKit

final class ProductInfoView: UIView {

    @IBOutlet private weak var productName: UILabel!
    @IBOutlet private weak var productPrice: UILabel!
    @IBOutlet private weak var productRate: UILabel!
    @IBOutlet private weak var productCategory: UILabel!
    @IBOutlet private weak var productDescription: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        loadNibFromBundle()
        productPrice.textColor = UIColor(hex: "BA5C3D")
        productRate.textColor = UIColor(hex: "8A8B7A")
        productCategory.textColor = UIColor(hex: "F7906D")
    }

    func configure(with product: Product) {
        productName.text = product.title
        productPrice.text = "\(product.price)$"
        productRate.text = String(product.rating.rate)
        productCategory.text = product.category
        productDescription.text = product.description
    }
}
