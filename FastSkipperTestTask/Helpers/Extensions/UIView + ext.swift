//
//  UIView + ext.swift
//  FastSkipperTestTask
//
//  Created by Dreik on 10/13/22.
//

import UIKit

extension UIView {
    func setupView(_ view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}
