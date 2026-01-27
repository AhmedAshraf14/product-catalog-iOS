//
//  UIView+Ext.swift
//  ProductCatalog
//
//  Created by Ahmed Ashraf on 27/01/2026.
//

import UIKit

extension UIView {
    func loadNibFromBundle() {
        let nibName = String(describing: type(of: self))
        let bundle = Bundle(for: type(of: self))

        guard let view = bundle.loadNibNamed(
            nibName,
            owner: self,
            options: nil
        )?.first as? UIView else {
            assertionFailure("failed to load nib \(nibName)")
            return
        }

        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
}

