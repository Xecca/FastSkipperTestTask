//
//  Resources.swift
//  FastSkipperTestTask
//
//  Created by Dreik on 10/12/22.
//

import UIKit

enum Resources {
    enum Fonts {
        static func helveticaRegular(with size: CGFloat) -> UIFont {
            UIFont(name: "Helvetica", size: size) ?? UIFont()
        }
    }
    
    enum Colors {
        static let active = UIColor(hexString: "#437BFE")
        static let inactive = UIColor(hexString: "#929DA5")
        static let divider = UIColor(hexString: "#E8ECEF")
        static let background = UIColor(hexString: "#3E4349")
        
        enum NavBar {
            static let background = UIColor(hexString: "#132237")
        }
        
        enum DataCell {
            static let background = UIColor(hexString: "#FFFFFF")
        }
        
        enum TabBar {
            static let background = UIColor(hexString: "#132237")
        }
    }
}
