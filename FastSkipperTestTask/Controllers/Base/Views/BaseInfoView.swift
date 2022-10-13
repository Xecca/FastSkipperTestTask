//
//  BaseInfoView.swift
//  FastSkipperTestTask
//
//  Created by Dreik on 10/13/22.
//

import UIKit

class BaseInfoView: BaseView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = Resources.Fonts.helveticaRegular(with: 15)
        label.textColor = Resources.Colors.inactive
        label.text = "Test".uppercased()
        
        return label
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        view.layer.borderColor = Resources.Colors.divider.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 22
        
        return view
    }()
}

extension BaseInfoView {
    override func setupViews() {
        super.setupViews()
        
        setupView(contentView)
        setupView(titleLabel)
    }
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            
            contentView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22)
        ])
    }
    override func configureAppearance() {
        super.configureAppearance()
        
        backgroundColor = .clear
    }
}

