//
//  MainViewController.swift
//  FastSkipperTestTask
//
//  Created by Dreik on 10/12/22.
//

import UIKit
import CoreMotion

class MainViewController: BaseController {

    private let headerView = HeaderView()
    private let navBarView = NavBarView()
    private var mapView = MapView()
    private let dataCollectionView = DataCollectionView()
    private let tabBarView = NavBarView()
    
    //FIXME: hard test
    let motionManager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //FIXME: hard test
        motionManager.startGyroUpdates()
        //FIXME: hard test
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if let gyroData = self.motionManager.gyroData {
                // pitch
                let pitch = gyroData.rotationRate.x
                // heel
                let heel = gyroData.rotationRate.y
                
                self.dataCollectionView.cells?.heeling = heel
                print(heel)
                self.dataCollectionView.cells?.pitch = pitch
            }
            print("Can't get gyroData")
        }
    }
}

// MARK: - Configures

extension MainViewController {
    override func setupViews() {
        super.setupViews()
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        navBarView.translatesAutoresizingMaskIntoConstraints = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        dataCollectionView.translatesAutoresizingMaskIntoConstraints = false
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        
        tabBarView.titleLabel.text = "Here Should be a TabBar".uppercased()
        
        view.addSubview(headerView)
        view.addSubview(navBarView)
        view.addSubview(mapView)
        view.addSubview(dataCollectionView)
        view.addSubview(tabBarView)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 35),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 80),
            
            navBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            navBarView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            navBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            navBarView.heightAnchor.constraint(equalToConstant: 50),
            
            mapView.leadingAnchor.constraint(equalTo: navBarView.leadingAnchor),
            mapView.topAnchor.constraint(equalTo: navBarView.bottomAnchor, constant: 20),
            mapView.trailingAnchor.constraint(equalTo: navBarView.trailingAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 400),
            
            dataCollectionView.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: Constants.leftDistanceToView),
            dataCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dataCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dataCollectionView.heightAnchor.constraint(equalToConstant: Constants.galleryItemWidth),
            
            tabBarView.leadingAnchor.constraint(equalTo: navBarView.leadingAnchor),
            tabBarView.trailingAnchor.constraint(equalTo: navBarView.trailingAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            tabBarView.heightAnchor.constraint(equalToConstant: 40),
            
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        view.backgroundColor = Resources.Colors.background
    }
    
}

// MARK: - DataManagerDelegate

extension MainViewController: DataManagerDelegate {
    func didUpdateData(_ dataManager: DataManager, motionData: DataModel) {
        DispatchQueue.main.async {
            print(motionData.pitch ?? 13)
//            // set just for view
//            self.dataView.configure pitch: motionData.pitch, heel: motionData.heel)
            
            self.dataCollectionView.set(cells: motionData)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
