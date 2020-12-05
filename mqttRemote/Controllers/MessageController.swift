//
//  FirstViewController.swift
//  mqttRemote
//
//  Created by Max Kornyev on 12/4/20.
//  Copyright © 2020 msk. All rights reserved.
//

import UIKit

class MessageController: UIViewController, ElementAnimations {
    
    @IBOutlet weak var viewLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Self.bounceImage(viewLogo)
    }
    
}
