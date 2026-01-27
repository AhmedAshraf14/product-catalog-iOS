//
//  ProductDetailsHeader.swift
//  ProductCatalog
//
//  Created by Ahmed Ashraf on 26/01/2026.
//

import UIKit
import Kingfisher

final class ProductDetailsHeader: UIView {
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func configure(with imageURLString: String) {
        guard let url = URL(string: imageURLString) else { return }
        productImageView.kf.setImage(with: url)
    }

    private func commonInit() {
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        addSubview(productImageView)
        backgroundColor = UIColor(hex: "F4F5F7")
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 350),

            productImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            productImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            productImageView.widthAnchor.constraint(equalToConstant: 250),
            productImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
}
