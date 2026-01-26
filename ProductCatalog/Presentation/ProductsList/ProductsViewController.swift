//
//  ProductsViewController.swift
//  ProductCatalogTest
//
//  Created by Ahmed Ashraf on 25/01/2026.
//

import UIKit

final class ProductsViewController: UIViewController {

    @IBOutlet private weak var productsCollectionView: UICollectionView!

    private var currentLayout: LayoutType = .grid {
        didSet {
            productsCollectionView.reloadData()
        }
    }
    private let viewModel: ProductsViewModelProtocol

    init(viewModel: ProductsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use init(viewModel:)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationHeader()
        setupProductsCollectionView()
    }

    private func setupNavigationHeader() {
        title = "Product Catalog"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "list.bullet")?.withTintColor(.black, renderingMode: .alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(changeViewLayout)
        )
    }

    @objc private func changeViewLayout() {
        currentLayout = currentLayout == .grid ? .list : .grid
        navigationItem.rightBarButtonItem?.image = currentLayout.rightBarButtonImage
    }

    private func setupProductsCollectionView() {
        productsCollectionView.register(LayoutType.grid.nib, forCellWithReuseIdentifier: LayoutType.grid.cellIdentifier)
        productsCollectionView.register(LayoutType.list.nib, forCellWithReuseIdentifier: LayoutType.list.cellIdentifier)
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
    }
}

extension ProductsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfProducts()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: currentLayout.cellIdentifier,
            for: indexPath
        )

        if let productCell = cell as? ProductConfigurable {
            let product = viewModel.product(at: indexPath.item)
            productCell.configure(with: product)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = productsCollectionView.bounds.width

        if currentLayout == .grid {
            let padding: CGFloat = 20
            let availableWidth = width - (padding)
            return CGSize(width: availableWidth / 2, height: 190)
        } else {
            return CGSize(width: width, height: 110)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
