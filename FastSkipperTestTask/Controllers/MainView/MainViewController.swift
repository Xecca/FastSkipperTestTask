//
//  MainViewController.swift
//  FastSkipperTestTask
//
//  Created by Dreik on 10/12/22.
//

import UIKit
import CoreMotion
import CoreLocation
import MapKit

final class MainViewController: BaseController, DataManagerDelegate {
    
    let mainView = MainView()
    
    private var dataManager = DataManager()
    
    private let motionManager = CMMotionManager()
    
    lazy var coordinates: [CLLocationCoordinate2D] = []
    //FIXME: hard test
    private let locationManager = CLLocationManager()
    private let locationUpdateInterval = 3.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        stopMotionUpdates()
        stopLocationUpdates()
    }
}

extension MainViewController: CLLocationManagerDelegate {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startMotionUpdates()
        startLocationUpdates()
    }
}

// MARK: - Motion Controller
extension MainViewController {
    func startMotionUpdates() {
        
        motionManager.startDeviceMotionUpdates()
        
        Timer.scheduledTimer(withTimeInterval: 1.0 / 5.0, repeats: true) { [weak self] _ in
            if let motionData = self?.motionManager.deviceMotion {

                // pitch
                let pitch = motionData.attitude.pitch
                // heel/roll
                let heel = motionData.attitude.roll
                var dataModel = DataModel()
                
                dataModel.pitch = pitch
                dataModel.heeling = heel
                
                if let manager = self?.dataManager {
                    self?.didUpdateData(manager, motionData: dataModel)
                }
            } else {
                print("Can't get motionData")
            }
        }
    }
    
    func stopMotionUpdates() {
        motionManager.stopDeviceMotionUpdates()
    }
}

// MARK: - Location Controller
extension MainViewController {
    func startLocationUpdates() {

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        let regionRadius: CLLocationDistance = 500.0 // in meters

        mainView.mapView.showsUserLocation = true

        Timer.scheduledTimer(withTimeInterval: locationUpdateInterval, repeats: true) { [weak self] _ in

            if let locationData = self?.locationManager.location {

                let latitude = locationData.coordinate.latitude
                let longitude = locationData.coordinate.longitude
                let region = MKCoordinateRegion(center: locationData.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
                let coordinate = CLLocationCoordinate2DMake(latitude, longitude)

                self?.mainView.mapView.setRegion(region, animated: true)
                self?.mainView.mapView.delegate = self
                
                self?.coordinates.append(coordinate)
                
                if self?.coordinates.count ?? 0 >= 2 {
                    self?.drawPath()
                } else if self?.coordinates.count ?? 0 == 1 {
                    self?.setAnnotationToMap()
                }
            }
        }
    }

    func stopLocationUpdates() {
        locationManager.stopUpdatingLocation()
    }
}

// MARK: - Map Manager
extension MainViewController {
    func setAnnotationToMap() {
        let annotation = MKPointAnnotation()

        annotation.coordinate = CLLocationCoordinate2D(latitude: coordinates.first!.latitude, longitude: coordinates.first!.longitude)
        annotation.title = "Start Point"
        annotation.subtitle = "Let's start from here"
        mainView.mapView.addAnnotation(annotation)
    }
    
    func drawPath() {
        produceOverlay(mapView: mainView.mapView)
    }
}

// MARK: - Configure Main View
extension MainViewController {
    override func setupViews() {
        super.setupViews()
        
        view.setupView(mainView)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
            //FIXME: Move to DataCollectionView to delegate
            self.mainView.dataCollectionView.set(cells: motionData)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
