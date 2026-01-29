//
//  ProductsViewController.swift
//  ProductCatalog
//
//  Created by Ahmed Ashraf on 25/01/2026.
//

import UIKit
import Combine
import SkeletonView

final class ProductsViewController: UIViewController {

    @IBOutlet private weak var productsCollectionView: UICollectionView!

    private var currentLayout: LayoutType = .list {
        didSet {
            productsCollectionView.reloadData()
        }
    }
    private let viewModel: ProductsViewModelProtocol
    private var cancellables = Set<AnyCancellable>()

    init(viewModel: ProductsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use init(viewModel:)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sink()
        setupNavigationHeader()
        setupProductsCollectionView()
        viewModel.getProducts()
    }

    private func setupNavigationHeader() {
        title = "Product Catalog"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: currentLayout.rightBarButtonImage,
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

    private func sink() {
        viewModel.state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self else { return }

                switch state {

                case .idle:
                    break

                case .loading:
                    productsCollectionView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .clouds), animation: nil, transition: .crossDissolve(0.25))

                case .loaded:
                    productsCollectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                    productsCollectionView.reloadData()

                case .empty:
                    productsCollectionView.hideSkeleton()
                    #warning("TODO: add empty state view")

                case .error(let message):
                    productsCollectionView.hideSkeleton()
                    showAlert(message: message)
                }
            }
            .store(in: &cancellables)
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productDetailsViewController = ProductDetailsViewController(
            viewModel: ProductDetailsViewModel(
                product: viewModel.product(at: indexPath.item)
            )
        )
        navigationController?.pushViewController(productDetailsViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastIndex = viewModel.numberOfProducts() - 1
        if indexPath.row >= lastIndex {
            viewModel.getProducts()
        }
    }
}

extension ProductsViewController: SkeletonCollectionViewDataSource, SkeletonCollectionViewDelegate {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return currentLayout.cellIdentifier
    }
}
