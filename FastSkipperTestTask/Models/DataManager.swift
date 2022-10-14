//
//  DataManager.swift
//  FastSkipperTestTask
//
//  Created by Dreik on 10/13/22.
//

import UIKit
import CoreMotion

protocol DataManagerDelegate {
    
    func didUpdateData(_ dataManager: DataManager, motionData: DataModel)
    func didFailWithError(error: Error)
}

struct DataManager {

}
