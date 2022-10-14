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

class MainViewController: BaseController {
    
    private let headerView = HeaderView()
    private let navBarView = NavBarView()
    private var mapView = MapView()
    private let dataCollectionView = DataCollectionView()
    private let tabBarView = NavBarView()
    
    private var dataManager = DataManager()
    
    private let motionManager = CMMotionManager()
    private lazy var coordinates: [CLLocationCoordinate2D] = []
    //    //FIXME: hard test
    private let locationManager = CLLocationManager()
    private let locationUpdateInterval = 3.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.addCompassButton()
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
                print("Can't get motionData")
            }
        }
    }
    
    func stopMotionUpdates() {
        motionManager.stopDeviceMotionUpdates()
    }
}

// MARK: - Location Controller
extension MainViewController: MKMapViewDelegate {
    func startLocationUpdates() {

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let regionRadius: CLLocationDistance = 500.0 // in meters
        
        mapView.showsUserLocation = true
        
        Timer.scheduledTimer(withTimeInterval: locationUpdateInterval, repeats: true) { _ in
            
            if let locationData = self.locationManager.location {
                
                let latitude = locationData.coordinate.latitude
                let longitude = locationData.coordinate.longitude
                let region = MKCoordinateRegion(center: locationData.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
                let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
                
                self.mapView.setRegion(region, animated: true)
                self.mapView.delegate = self
                
                self.coordinates.append(coordinate)
                
                self.drawThePath()
                
                if self.coordinates.isEmpty {
                    let annotation = MKPointAnnotation()
                    
                    annotation.coordinate = CLLocationCoordinate2D(latitude: self.coordinates.first!.latitude, longitude: self.coordinates.first!.longitude)
                    annotation.title = "Start Point"
                    annotation.subtitle = "Let's start from here"
                    self.mapView.addAnnotation(annotation)
                } else if self.coordinates.count >= 2 {
//                    self.drawPathBy(self.coordinates)
                }
            }
        }
    }
    
    func stopLocationUpdates() {
        locationManager.stopUpdatingLocation()
    }
}

// MARK: - Drawing Map
extension MainViewController {
    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
        print("rendering")
    }
    
    func drawThePath() {
        // produce overlay
        let polyline = MKPolyline(coordinates: &coordinates, count: coordinates.count)

        mapView.addOverlay(polyline)
        
        // render the overlay
        mapView.renderer(for: polyline)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        return self.mapView.getOverlayRenderer(overlay)
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
