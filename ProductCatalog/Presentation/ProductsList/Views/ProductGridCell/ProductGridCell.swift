//
//  ProductGridCell.swift
//  ProductCatalog
//
//  Created by Ahmed Ashraf on 24/01/2026.
//

import UIKit
import Kingfisher
import SkeletonView

final class ProductGridCell: UICollectionViewCell, ProductConfigurable {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productInfoView: UIView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productRate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        contentView.backgroundColor = UIColor(hex: "F4F5F7")
        contentView.layer.cornerRadius = 8
        productPrice.textColor = UIColor(hex: "BA5C3D")
        productRate.textColor = UIColor(hex: "8A8B7A")
        productInfoView.layer.cornerRadius = 8
        productInfoView.backgroundColor = .white
        productInfoView.layer.masksToBounds = false
        productInfoView.layer.shadowColor = UIColor.black.cgColor
        productInfoView.layer.shadowOpacity = 0.05
        productInfoView.layer.shadowOffset = CGSize(width: 0, height: 2)
        productInfoView.layer.shadowRadius = 4
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetProductUI()
    }
}
