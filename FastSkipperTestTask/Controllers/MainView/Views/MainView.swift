//
//  MainView.swift
//  FastSkipperTestTask
//
//  Created by RedOrcDron on 10/28/22.
//

import UIKit
import MapKit

final class MainView: BaseView {
    private let headerView = HeaderView()
    private let navBarView = NavBarView()
    var mapView = MapView()
    let dataCollectionView = DataCollectionView()
    private let tabBarView = TabBarView()
    
    weak var delegate: DataManagerDelegate?
}

extension MainView {
    func didDataUpdate() {
//        delegate?.didUpdateData(<#T##DataManager#>, motionData: <#T##DataModel#>)
    }
}

// MARK: - Configure Main View
extension MainView {
    override func setupViews() {
        super.setupViews()
        
        setupView(headerView)
        setupView(navBarView)
        setupView(mapView)
        setupView(dataCollectionView)
        setupView(tabBarView)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 60),
            
            navBarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            navBarView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            navBarView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            navBarView.heightAnchor.constraint(equalToConstant: 50),
            
            mapView.topAnchor.constraint(equalTo: navBarView.bottomAnchor, constant: Constants.leftDistanceToView),
            mapView.leadingAnchor.constraint(equalTo: navBarView.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: navBarView.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: dataCollectionView.topAnchor, constant: -Constants.galleryMinimumLineSpacing),
            
            dataCollectionView.bottomAnchor.constraint(equalTo: tabBarView.topAnchor, constant: -Constants.leftDistanceToView),
            dataCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dataCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dataCollectionView.heightAnchor.constraint(equalToConstant: Constants.galleryItemWidth),
            
            tabBarView.leadingAnchor.constraint(equalTo: navBarView.leadingAnchor),
            tabBarView.trailingAnchor.constraint(equalTo: navBarView.trailingAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.galleryMinimumLineSpacing),
            tabBarView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        backgroundColor = Resources.Colors.background
    }
}
