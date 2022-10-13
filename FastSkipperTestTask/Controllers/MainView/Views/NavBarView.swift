//
//  NavBarView.swift
//  FastSkipperTestTask
//
//  Created by Dreik on 10/12/22.
//

import UIKit

class NavBarView: BaseView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = Resources.Fonts.helveticaRegular(with: 15)
        label.textColor = .white
        label.text = "Here Should be placed NavBar".uppercased()
        
        return label
    }()
}

extension NavBarView {
    override func setupViews() {
        super.setupViews()
        
        setupView(titleLabel)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        backgroundColor = Resources.Colors.NavBar.background
        layer.cornerRadius = 25
    }
}
