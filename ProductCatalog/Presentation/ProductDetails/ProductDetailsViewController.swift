//
//  ProductDetailsViewController.swift
//  ProductCatalog
//
//  Created by Ahmed Ashraf on 26/01/2026.
//

import UIKit

final class ProductDetailsViewController: UIViewController {

    @IBOutlet private weak var productDetailsHeader: ProductDetailsHeader!
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
        productDetailsHeader.configure(with: product.image)
        productInfo.configure(with: product)
    }
}
