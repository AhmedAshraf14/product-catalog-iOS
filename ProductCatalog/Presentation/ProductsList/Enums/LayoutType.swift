//
//  LayoutType.swift
//  ProductCatalogTest
//
//  Created by Ahmed Ashraf on 25/01/2026.
//

import UIKit

enum LayoutType {
    case grid
    case list

    var cellIdentifier: String {
        switch self {
        case .grid:
            "ProductGridCell"
        case .list:
            "ProductListCell"
        }
    }

    var nib: UINib {
        switch self {
        case .grid:
            return UINib(nibName: cellIdentifier, bundle: nil)
        case .list:
            return UINib(nibName: cellIdentifier, bundle: nil)
        }
    }

    var rightBarButtonImage: UIImage? {
        switch self {
        case .grid:
            return UIImage(systemName: "list.bullet")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        case .list:
            return UIImage(systemName: "square.grid.2x2")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        }
    }
}
