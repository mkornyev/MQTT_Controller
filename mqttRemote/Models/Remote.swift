//
//  Remote.swift
//  mqttRemote
//
//  Created by Max Kornyev on 12/4/20.
//  Copyright © 2020 msk. All rights reserved.
//

import Foundation
import CocoaMQTT

class Remote {

    let preferences = Preferences()
    var mqtt:CocoaMQTT = CocoaMQTT(clientID: Preferences.shared.clientID, host: Preferences.shared.host, port: Preferences.shared.port)
    
    
    init() {
        connectToServer()
    }
    
    func connectToServer() {
        // Send the disconnect signal if possible
        mqtt.disconnect()
        
        // Send diout on same channel
        Preferences.shared.dieout_topic = Preferences.shared.publish_topic

        // Client setup
        mqtt = CocoaMQTT(clientID: Preferences.shared.clientID,
                         host: Preferences.shared.host,
                         port: Preferences.shared.port)
        mqtt.username = Preferences.shared.username
        mqtt.password = Preferences.shared.password
        mqtt.willMessage = CocoaMQTTWill(topic: Preferences.shared.dieout_topic,
                                         message: Preferences.shared.dieout_message) // TCP
        mqtt.keepAlive = 30 // seconds
        mqtt.delegate = self
        mqtt.logLevel = .off //.debug
        mqtt.enableSSL = true;
        
        _ = mqtt.connect()
    }
    
    func sendMessage(_ message:String = "SWIFT PING") {
        _ = mqtt.publish(Preferences.shared.publish_topic,
                         withString: message,
                         qos: .qos0) // Returns msg id
    }
}

// MARK: - Delegate Functions

extension Remote: CocoaMQTTDelegate {
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        print("-- didConnectAck")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        print("-- didPublishMessage")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        print("-- 3")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16) {
        print("-- 4")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopic topics: [String]) {
        print("-- 5")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopic topic: String) {
        print("-- 6")
    }
    
    func mqttDidPing(_ mqtt: CocoaMQTT) {
        print("-- didPing")
    }
    
    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
        print("-- didRecievePong")
    }
    
    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
        print("-- didDisconnect")
    }
    
}
