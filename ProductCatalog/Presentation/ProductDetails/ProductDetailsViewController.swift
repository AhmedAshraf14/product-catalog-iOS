//
//  ProductDetailsViewController.swift
//  ProductCatalog
//
//  Created by Ahmed Ashraf on 26/01/2026.
//

import UIKit

final class ProductDetailsViewController: UIViewController {

    @IBOutlet private weak var productImageHeader: UIImageView!
    @IBOutlet private weak var productInfo: ProductInfoView!
    
    private let viewModel: ProductDetailsViewModelProtocol
    
    init(viewModel: ProductDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use init(viewModel:)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }

    private func configureViews() {
        let product = viewModel.productInfo()
        if let url = URL(string: product.image) {
            productImageHeader.kf.setImage(with: url)
        }
        productInfo.configure(with: product)
    }
}
