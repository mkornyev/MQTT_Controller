//
//  SecondViewController.swift
//  mqttRemote
//
//  Created by Max Kornyev on 12/4/20.
//  Copyright © 2020 msk. All rights reserved.
//

import UIKit
import CoreMotion


class RemoteController: UIViewController, ElementAnimations {
    
    // MARK: - Vars
    let TRANSMISSION_TYPE:TRANSMISSION_TYPE = .DEVICEMOTION
    let MESSAGE_INTERVAL = 0.25 // Seconds
    
    var remote:Remote = Remote()
    var motionManager:CMMotionManager = (UIApplication.shared.delegate as! AppDelegate).motionManager
    
    var timer:Timer?
    var isParsing = false
    
    // Broadcast variables
    var x:Double = 0.0 {
        didSet {
            rollLabel.text = String(x)
        }
    }
    var y:Double = 0.0 {
        didSet {
            pitchLabel.text = String(y)
        }
    }
    var z:Double = 0.0
    
    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var rollLabel: UILabel!
    @IBOutlet weak var pitchLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var viewLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleButton.setTitle("Start", for: .normal)
        toggleButton.layer.cornerRadius = 4
        rollLabel.text = "0.0000"
        pitchLabel.text = "0.0000"
    }
    

    // MARK: - Functions
    override func viewDidAppear(_ animated: Bool) {
        remote.connectToServer()
        Self.bounceImage(viewLogo)
    }
    
    @IBAction func toggleButtonPressed(_ sender: UIButton) {
        if isParsing {
            stopSensorParsing()
            toggleTimer()
            isParsing.toggle()
            activityIndicator.stopAnimating()
            toggleButton.setTitle("Start", for: .normal)
        } else {
            startSensorParsing()
            toggleTimer()
            isParsing.toggle()
            activityIndicator.startAnimating()
            toggleButton.setTitle("Stop", for: .normal)
        }
    }
    
    func toggleTimer() {
        if (self.timer as Timer?) != nil {
            timer?.invalidate()
            timer = nil
        }
        else {
            self.timer = Timer.scheduledTimer(withTimeInterval: MESSAGE_INTERVAL, repeats: true, block: { timer in
                print("Timer fired")
                self.broadcastVariables()
            })
        }
    }
    
    func broadcastVariables() {
        let message = "\(x*100),\(y*100)\n"
        self.remote.sendMessage(message)
    }
    
    func startSensorParsing() {
        switch TRANSMISSION_TYPE {
        case .GYROSCOPE:
            motionManager.gyroUpdateInterval = 0.2
            motionManager.startGyroUpdates(to: OperationQueue.current!) { (data, error) in
                if let motionData = data as CMGyroData?
                {
                    self.x = motionData.rotationRate.x
                    self.y = motionData.rotationRate.y
                    self.z = motionData.rotationRate.z
                }
            }
            
        case .ACCELEROMETER:
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
                if let motionData = data as CMAccelerometerData?
                {
                    self.x = motionData.acceleration.x
                    self.y = motionData.acceleration.y
                    self.z = motionData.acceleration.z
                }
            }
        
        case .DEVICEMOTION:
            motionManager.startDeviceMotionUpdates(to: OperationQueue.current!) { (data, error) in
                if let motionData = data as CMDeviceMotion?
                {
                    self.x = motionData.attitude.roll
                    self.y = motionData.attitude.pitch
                    self.z = motionData.attitude.yaw
                }
            }
        }
    }
    
    func stopSensorParsing() {
        motionManager.stopGyroUpdates()
        motionManager.stopAccelerometerUpdates()
        motionManager.stopDeviceMotionUpdates()
    }


}
