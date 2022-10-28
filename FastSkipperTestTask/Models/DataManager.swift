//
//  DataManager.swift
//  FastSkipperTestTask
//
//  Created by Dreik on 10/13/22.
//

import UIKit
import CoreMotion
import CoreLocation
//import MapKit

protocol DataManagerDelegate: AnyObject {
    func didUpdateData(_ dataManager: DataManager, motionData: DataModel)
    func didFailWithError(error: Error)
}

struct DataManager {

}
