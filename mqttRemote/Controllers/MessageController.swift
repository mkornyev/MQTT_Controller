//
//  FirstViewController.swift
//  mqttRemote
//
//  Created by Max Kornyev on 12/4/20.
//  Copyright © 2020 msk. All rights reserved.
//

import UIKit

class MessageController: UIViewController, ElementAnimations {
    
    var preferences = Preferences()
    @IBOutlet weak var viewLogo: UIImageView!
    @IBOutlet weak var updateButton: UIButton!
    
    // Form fields
    @IBOutlet weak var hostField: UITextField!
    @IBOutlet weak var portField: UITextField!
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var pubTopicField: UITextField!
    @IBOutlet weak var dieoutMsgField: UITextField!
    
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        updateButton.layer.cornerRadius = 4
        hostField.text = Preferences.shared.host
        portField.text = String(Preferences.shared.port)
        userField.text = Preferences.shared.username
        passField.text = Preferences.shared.password
        pubTopicField.text = Preferences.shared.publish_topic
        dieoutMsgField.text = Preferences.shared.dieout_message
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Self.bounceImage(viewLogo)
    }
    
    @IBAction func updateButtonPressed(_ sender: UIButton) {
        Preferences.shared.host = hostField.text ?? Preferences.shared.host
        if let port = portField?.text as String? {
          Preferences.shared.port = UInt16(port) ?? UInt16(8884)
        } else {
          Preferences.shared.port = Preferences.shared.port
        }
        Preferences.shared.username = userField.text ?? Preferences.shared.username
        Preferences.shared.password = passField.text ?? Preferences.shared.password
        Preferences.shared.publish_topic = pubTopicField.text ?? Preferences.shared.publish_topic
        Preferences.shared.dieout_message = dieoutMsgField.text ?? Preferences.shared.dieout_message
    }
}
