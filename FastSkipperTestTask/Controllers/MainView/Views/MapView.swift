//
//  MapView.swift
//  FastSkipperTestTask
//
//  Created by Dreik on 10/12/22.
//

import UIKit
import MapKit

class MapView: MKMapView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addCompassButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Compass
extension MapView {
    func addCompassButton() {
        self.showsCompass = false   // hide built-in compass
        
        let compassButton = MKCompassButton(mapView: self)   // Make a new compass
        compassButton.compassVisibility = .visible          // Make it visible
        
        self.addSubview(compassButton) // Add it to the view
        
        // Position it as required
        
        compassButton.translatesAutoresizingMaskIntoConstraints = false
        compassButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12).isActive = true
        compassButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
    }
}

// MARK: - Draw Route On the Map
extension MainViewController: MKMapViewDelegate {
    func produceOverlay(mapView: MapView) {
        
        let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
        
        mapView.addOverlay(polyline)
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        return getOverlayRenderer(overlay)
    }
    
    func getOverlayRenderer(_ overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolygon {
            let lineView = MKPolygonRenderer(overlay: overlay)
            
            lineView.strokeColor = UIColor.green
            lineView.lineWidth = 8.0
            
            return lineView
        } else if overlay is MKPolyline {
            let lineView = MKPolylineRenderer(overlay: overlay)
            
            lineView.strokeColor = UIColor.red
            lineView.lineWidth = 10.0
            
            return lineView
        } else {
            return MKOverlayRenderer(overlay: overlay)
        }
    }
    
    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
        print("rendering")
    }
}
