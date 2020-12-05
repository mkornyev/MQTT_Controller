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
    
    let clientID = "CocoaMQTTiOSClient-" + String(ProcessInfo().processIdentifier)
//    let clientID = "mkornyev"
    let host = "mqtt.ideate.cmu.edu"
    let port = UInt16(8884)
    let username = "students"
    let password = "cks"
    let publish_topic = "mkornyev"
    let dieout_topic: String
    let dieout_message = "cocoamqtt_dieout"
//    let websocket:CocoaMQTTWebSocket
    let mqtt:CocoaMQTT
    
    
    init() {
        // Send diout on same channel
        dieout_topic = publish_topic

        // Client setup
        mqtt = CocoaMQTT(clientID: self.clientID, host: host, port: port)
        mqtt.username = username
        mqtt.password = password
        mqtt.willMessage = CocoaMQTTWill(topic: dieout_topic, message: dieout_message) // TCP
        mqtt.keepAlive = 30 // seconds
        mqtt.delegate = self
        mqtt.logLevel = .off //.debug
        mqtt.enableSSL = true;

        // Callbacks
        mqtt.didReceiveMessage = { mqtt, message, id in
            print("Message received in topic \(message.topic) with payload \(message.string!)")
        }
        
//        mqtt.subscribe("mk")
        
        _ = mqtt.connect()
    }
    
    func sendMessage(_ message:String = "SWIFT PING") {
        _ = mqtt.publish(publish_topic, withString: message, qos: .qos0) // Returns msg id
    }
}

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
