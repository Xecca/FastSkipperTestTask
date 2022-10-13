//
//  BaseController.swift
//  FastSkipperTestTask
//
//  Created by Dreik on 10/12/22.
//

import UIKit

class BaseController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        constraintViews()
        configureAppearance()
    }
}

@objc extension BaseController {
    func setupViews() {}
    
    func constraintViews() {}
    
    func configureAppearance() {
        view.backgroundColor = Resources.Colors.background
    }
}
