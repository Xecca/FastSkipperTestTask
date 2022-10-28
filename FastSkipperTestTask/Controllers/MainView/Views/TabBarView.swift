//
//  TabBarView.swift
//  FastSkipperTestTask
//
//  Created by Dreik on 10/12/22.
//

import UIKit

class TabBarView: NavBarView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.text = "Here Should be a TabBar".uppercased()
        backgroundColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
