//
//  Extension.swift
//  BookStore_PedroOrtiz
//
//  Created by Pedro Del Rio Ortiz on 29/05/22.
//

import Foundation
import UIKit

extension ViewConfiguration {
    func initialize() {
        addViews()
        addConstraints()
    }
}

extension UILabel {
    func applyStyle(color: UIColor, fontName: FontName, size: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        textColor = color
        font = UIFont(name: fontName.rawValue, size: size)
    }
}
