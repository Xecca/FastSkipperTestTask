//
//  DataModel.swift
//  FastSkipperTestTask
//
//  Created by Dreik on 10/13/22.
//

import UIKit

struct DataModel {
    // “Heeling” is when the sailboat leans over to one side due to wind pressure on the sails. To propel the boat, the boat is angled so the wind crosses over the boat at an angle, hitting the sails and pushing them toward one side of the boat.
    var heeling: Double?
    
    // Pitch describes the up and down motion of a vessel. This is characterized by the rising and falling of the bow and stern in much the same way as a teeter-totter moves up and down.
    var pitch: Double?
}

struct Constants {
    static let leftDistanceToView: CGFloat = 16
    static let rigthDistanceToView: CGFloat = 16
    static let galleryMinimumLineSpacing: CGFloat = 16
    static let galleryItemWidth = (UIScreen.main.bounds.width - Constants.leftDistanceToView - Constants.rigthDistanceToView - Constants.galleryMinimumLineSpacing) / 2
}
