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
    var motion = CMMotionManager()
    var timer = Timer()
    
    var delegate: DataManagerDelegate?
    
    mutating func startDeviceMotion() {
        if motion.isDeviceMotionAvailable {
            motion.deviceMotionUpdateInterval = 1.0 / 60.0
            motion.showsDeviceMovementDisplay = true
            motion.startDeviceMotionUpdates(using: .xMagneticNorthZVertical)
            
            // Configure a timer to fetch the motion data.
            timer = Timer(fire: Date(), interval: (1.0 / 60.0), repeats: true,
                          block: { [self] (timer) in
                if let data = motion.deviceMotion {
                    // Get the attitude relative to the magnetic north reference frame.
                    // pitch
                    let x = data.attitude.pitch
                    // heel/roll
                    let y = data.attitude.roll
                    let z = data.attitude.yaw
                    
                    var dataModel = DataModel()
                    dataModel.pitch = x
                    dataModel.heeling = y
                    // Use the motion data in your app.
                    
                    print("pitch: \(x)")
                    print("heel: \(y)")
                    self.delegate?.didUpdateData(self, motionData: dataModel)
                }
            })
            
            // Add the timer to the current run loop.
            RunLoop.current.add(timer, forMode: RunLoop.Mode.default)
        }
    }
}
