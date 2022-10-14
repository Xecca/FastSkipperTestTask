//
//  MapView.swift
//  FastSkipperTestTask
//
//  Created by Dreik on 10/12/22.
//

import UIKit
import MapKit

class MapView: MKMapView {

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
extension MapView: MKMapViewDelegate {
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
}
