//
//  PeripheralDelegate.swift
//  Twinmax
//
//  Created by Annihil on 10/19/16.
//  Copyright © 2016 ISEN. All rights reserved.
//

import Foundation
import CoreBluetooth

class PeripheralDelegate : NSObject, CBPeripheralDelegate {
    let formatter = DateFormatter()
    var start = Date()
    var byteCount: Int = 0
    var lastPacketCount: UInt = 0
    
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        // Iterate through the services of a particular peripheral.
        for service in peripheral.services! {
            // Let's see what characteristics this service has.
            peripheral.discoverCharacteristics(nil, for: service)
            print("Discovered Service of \(peripheral.name!)")
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        // check the uuid of each characteristic to find config and data characteristics
        for charateristic in service.characteristics! {
            let thisCharacteristic = charateristic
            // Set notify for characteristics here.
            peripheral.setNotifyValue(true, for: thisCharacteristic)
            print("Discovered Characteristic of \(peripheral.name!)")
        }
    }
    
    // Get data values when they are updated
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let data = characteristic.value {
            byteCount += data.count
            
            let elapsed = Date().timeIntervalSince(start)
            if elapsed > 1.0 {
                print("Throughput: \(byteCount) B/s - \((frameDecoder?.packetCount)! - lastPacketCount) pt/s")
                lastPacketCount = (frameDecoder?.packetCount)!
                byteCount = 0
                start = Date()
            }

//            formatter.dateFormat = "mm:ss.SSS "
//            print(formatter.string(from: NSDate() as Date), terminator: "")
//            
//            var values = [UInt8](repeating: 0, count: data.count)
//            data.copyBytes(to: &values, count: data.count)
//            
//            print("bin: ", terminator: "")
//            for num in values {
//                let str = String(num, radix: 2)
//                let paddedStr = pad(string: str, toSize: 8)
//                print("\(paddedStr) ", terminator: "")
//            }
//            print("")
//            
//            print("decoded: ", terminator: "")
            frameDecoder?.decode(data: data)
//
//            print("")
        }
    }
    
    func pad(string : String, toSize: Int) -> String {
        var padded = string
        for _ in 0..<toSize - string.characters.count {
            padded = "0" + padded
        }
        return padded
    }
}
