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
        
        label.font = Resources.Fonts.helveticaRegular(with: 24)
        label.textColor = Resources.Colors.active
        label.text = "Heel".uppercased()
        label.textAlignment = .left
        
        return label
    }()
    
    let pitchLabel: UILabel = {
        let label = UILabel()
        
        label.font = Resources.Fonts.helveticaRegular(with: 24)
        label.textColor = Resources.Colors.active
        label.text = "Pitch".uppercased()
        label.textAlignment = .left
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        constraintViews()
        configureAppearance()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 10
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 8)
        
        self.clipsToBounds = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DataCollectionCellView {
    func setupViews() {
        setupView(heelLabel)
        setupView(pitchLabel)
    }
    
    func constraintViews() {
        NSLayoutConstraint.activate([
            heelLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -30),
            heelLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 25),
            
            pitchLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 30),
            pitchLabel.leadingAnchor.constraint(equalTo: heelLabel.leadingAnchor),
        ])
    }
    
    func configureAppearance() {
        backgroundColor = Resources.Colors.DataCell.background
    }
}
