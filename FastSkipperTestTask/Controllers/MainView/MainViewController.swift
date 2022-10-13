//
//  MainViewController.swift
//  FastSkipperTestTask
//
//  Created by Dreik on 10/12/22.
//

import UIKit
import CoreMotion
import CoreLocation

class MainViewController: BaseController {

    private let headerView = HeaderView()
    private let navBarView = NavBarView()
    private var mapView = MapView()
    private let dataCollectionView = DataCollectionView()
    private let tabBarView = NavBarView()
    
    let motionManager = CMMotionManager()
    var dataManager = DataManager()
    
//    //FIXME: hard test
//    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        stopMotionUpdates()
    }
}

extension MainViewController: CLLocationManagerDelegate {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startMotionUpdates()
//        //FIXME: hard test for gyro
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
        
    }
}

// MARK: - Motion Controller
extension MainViewController {
    func startMotionUpdates() {

        motionManager.startDeviceMotionUpdates()
        Timer.scheduledTimer(withTimeInterval: 1.0 / 5.0, repeats: true) { _ in
            if let motionData = self.motionManager.deviceMotion {
                // pitch
                let pitch = motionData.attitude.pitch
                // heel/roll
                let heel = motionData.attitude.roll
                var dataModel = DataModel()
                
                dataModel.pitch = pitch
                dataModel.heeling = heel
                
                self.didUpdateData(self.dataManager, motionData: dataModel)
            } else {
                print("Can't get gyroData")
            }
        }
    }
    
    func stopMotionUpdates() {
        motionManager.stopDeviceMotionUpdates()
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
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 60),
            
            navBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            navBarView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            navBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            navBarView.heightAnchor.constraint(equalToConstant: 50),
            
            mapView.leadingAnchor.constraint(equalTo: navBarView.leadingAnchor),
            mapView.topAnchor.constraint(equalTo: navBarView.bottomAnchor, constant: Constants.leftDistanceToView),
            mapView.trailingAnchor.constraint(equalTo: navBarView.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: dataCollectionView.topAnchor, constant: -Constants.galleryMinimumLineSpacing),
            
            dataCollectionView.bottomAnchor.constraint(equalTo: tabBarView.topAnchor, constant: -Constants.leftDistanceToView),
            dataCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dataCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dataCollectionView.heightAnchor.constraint(equalToConstant: Constants.galleryItemWidth),
            
            tabBarView.leadingAnchor.constraint(equalTo: navBarView.leadingAnchor),
            tabBarView.trailingAnchor.constraint(equalTo: navBarView.trailingAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            tabBarView.heightAnchor.constraint(equalToConstant: 40),
            
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        view.backgroundColor = Resources.Colors.background
    }
    
}

// MARK: - DataManagerDelegate

extension MainViewController {
    func didUpdateData(_ dataManager: DataManager, motionData: DataModel) {
        DispatchQueue.main.async {
            self.dataCollectionView.set(cells: motionData)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
