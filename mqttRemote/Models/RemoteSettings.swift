//
//  RemoteSettings.swift
//  mqttRemote
//
//  Created by Max Kornyev on 12/5/20.
//  Copyright © 2020 msk. All rights reserved.
//

import Foundation

// Singleton class to hold user preferences for the app
class Preferences {
    // Shared instance
    static var shared = Preferences()
        
    // Preferences
    var clientID = "CocoaMQTTiOSClient-" + String(ProcessInfo().processIdentifier)
    //    let clientID = "mkornyev"
    var host = "mqtt.ideate.cmu.edu"
    var port = UInt16(8884)
    var username = "students"
    var password = "cks"
    var publish_topic = "mkornyev"
    var dieout_topic = "mkornyev"
    var dieout_message = "cocoamqtt_dieout"
}



