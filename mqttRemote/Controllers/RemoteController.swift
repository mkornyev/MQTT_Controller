//
//  SecondViewController.swift
//  mqttRemote
//
//  Created by Max Kornyev on 12/4/20.
//  Copyright © 2020 msk. All rights reserved.
//

import UIKit
import CoreMotion

class RemoteController: UIViewController {
    
    // MARK: - Vars
    var remote:Remote = Remote()
    var motionManager:CMMotionManager = (UIApplication.shared.delegate as! AppDelegate).motionManager
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    
    override func viewDidAppear(_ animated: Bool)
    {
        
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        motionManager.gyroUpdateInterval = 0.2
        motionManager.startGyroUpdates(to: OperationQueue.current!) { (data, error) in
            if let motionData = data as CMGyroData?
            {
                let x = motionData.rotationRate.x
                let y = motionData.rotationRate.y
                let z = motionData.rotationRate.z
                let message = "\(x) : \(y) : \(z)"
                self.remote.sendMessage(message)
            }
        }
        
        motionManager.startAccelerometerUpdates()

        if let accelerometerData = motionManager.accelerometerData {
            print("Accel Data1: \(accelerometerData)")
            remote.sendMessage("Got accel data 1")
        }
        
//        remote.sendMessage(message)
    }


}

