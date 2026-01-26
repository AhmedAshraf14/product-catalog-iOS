//
//  ProductListCell.swift
//  ProductCatalogTest
//
//  Created by Ahmed Ashraf on 25/01/2026.
//

import UIKit

final class ProductListCell: UICollectionViewCell, ProductConfigurable {

    @IBOutlet weak var productImageViewContainer: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productRate: UILabel!
    @IBOutlet weak var productPrice: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        contentView.layer.cornerRadius = 8
        contentView.layer.borderColor = UIColor(hex: "DDDDDB").cgColor
        contentView.layer.borderWidth = 1
        productImageViewContainer.backgroundColor = UIColor(hex: "F4F5F7")
        productImageViewContainer.layer.cornerRadius = 8
        productRate.textColor = UIColor(hex: "8A8B7A")
        productPrice.textColor = UIColor(hex: "BA5C3D")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        resetProductUI()
    }
}
