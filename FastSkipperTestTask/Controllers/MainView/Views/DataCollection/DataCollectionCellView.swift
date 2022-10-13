//
//  DataCollectionCellView.swift
//  FastSkipperTestTask
//
//  Created by Dreik on 10/12/22.
//

import UIKit

class DataCollectionCellView: UICollectionViewCell {
    
    static let reuseID = "GalleryCollectionViewCell"
    
    let heelLabel: UILabel = {
        let label = UILabel()
        
        label.font = Resources.Fonts.helveticaRegular(with: 27)
        label.textColor = Resources.Colors.active
        label.text = "Heel".uppercased()
        
        return label
    }()
    
    let pitchLabel: UILabel = {
        let label = UILabel()
        
        label.font = Resources.Fonts.helveticaRegular(with: 27)
        label.textColor = Resources.Colors.active
        label.text = "Pitch".uppercased()
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView(heelLabel)
        setupView(pitchLabel)
        
        backgroundColor = Resources.Colors.DataCell.background
        
        heelLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        heelLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        heelLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/3).isActive = true
        
        pitchLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pitchLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.galleryMinimumLineSpacing).isActive = true
        pitchLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/3).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 10
        self.layer.shadowRadius = 8
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 8)
        
        self.clipsToBounds = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

