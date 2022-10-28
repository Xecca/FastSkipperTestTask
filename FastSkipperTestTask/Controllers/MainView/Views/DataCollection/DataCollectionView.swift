//
//  DataCollectionView.swift
//  FastSkipperTestTask
//
//  Created by Dreik on 10/13/22.
//

import UIKit

class DataCollectionView: UICollectionView {
    
    var cells: DataModel?
    weak var dataManagerDelegate: DataManagerDelegate?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = Constants.galleryMinimumLineSpacing
        layout.scrollDirection = .horizontal
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(cells: DataModel) {
        DispatchQueue.main.async {
            self.cells = cells
            self.reloadData()
        }
    }
}

extension DataCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
//        return cells?.list.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: DataCollectionCellView.reuseID, for: indexPath) as! DataCollectionCellView
        
        cell.heelLabel.text = String(format: "Heel: %.1f°", ((cells?.heeling ?? 0) * 180 / 3.14))
        cell.pitchLabel.text = String(format: "Pitch: %.1f°", ((cells?.pitch ?? 0) * 180 / 3.14))
        
        return cell
    }
    
    // MARK: Freeing cells
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        (cell as! DataCollectionCellView).heelLabel.text = nil
//        (cell as! DataCollectionCellView).pitchLabel.text = nil
//        print("Freeing cells")
    }

    // MARK: Adds data to cells
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

//        (cell as! DataCollectionCellView).pitchLabel.text = "\(String(cells?.pitch ?? 0))°"
//        (cell as! DataCollectionCellView).heelLabel.text = "\(String(cells?.heeling ?? 0))°"
        
    }
}

extension DataCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.galleryItemWidth, height: frame.height * 1)
    }
}

extension DataCollectionView {
    func setupViews() {
        
        backgroundColor = .clear
        
        delegate = self
        dataSource = self
        
        register(DataCollectionCellView.self, forCellWithReuseIdentifier: DataCollectionCellView.reuseID)
        
        contentInset = UIEdgeInsets(top: 0, left: Constants.leftDistanceToView, bottom: 0, right: Constants.rigthDistanceToView)
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
}
