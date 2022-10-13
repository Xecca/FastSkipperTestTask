//
//  HeaderView.swift
//  FastSkipperTestTask
//
//  Created by Dreik on 10/13/22.
//

import UIKit

class HeaderView: BaseView {
    let logoImage: UIImageView = {
        var image = UIImageView()
        
        image.image = UIImage(named: "logo_fastSkipper") ?? UIImage()
        
        return image
    }()
}

extension HeaderView {
    override func setupViews() {
        super.setupViews()
        
        setupView(logoImage)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            logoImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 40),
            logoImage.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        backgroundColor = .none
    }
}
