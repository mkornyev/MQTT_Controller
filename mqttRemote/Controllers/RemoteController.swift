//
//  SecondViewController.swift
//  mqttRemote
//
//  Created by Max Kornyev on 12/4/20.
//  Copyright © 2020 msk. All rights reserved.
//

import UIKit

class RemoteController: UIViewController {
    var remote:Remote = Remote()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        let message = "SWIFT PING"
        print("Sending: \(message)")
        
        remote.sendMessage(message)
    }


}

