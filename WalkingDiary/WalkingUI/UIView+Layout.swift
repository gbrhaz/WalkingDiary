//
//  UIView+SimpleLayouts.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 10/05/2021.
//

import Foundation
import UIKit

extension UIView {

    func addSubviewFillingSuperview(_ subview: UIView, withInsets insets: UIEdgeInsets = .zero) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
            subview.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets.right),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom),
        ]
        NSLayoutConstraint.activate(constraints)
    }

}
