//
//  BluetoothDelegate.swift
//  Twinmax
//
//  Created by Annihil on 10/19/16.
//  Copyright © 2016 ISEN. All rights reserved.
//

import UIKit
import Foundation
import CoreBluetooth

class CentralManagerDelegate : NSObject, CBCentralManagerDelegate {
    let notification = CWStatusBarNotification()
    
    override init() {
        super.init()
        notification.notificationAnimationInStyle = CWNotificationAnimationStyle.top
        self.notification.notificationLabelBackgroundColor = UIColor.orange
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state.rawValue == 5 { // PowerOn
            // Scan for peripherals if Bluetooth is turned on
            central.scanForPeripherals(withServices: nil, options: nil)
//            print("Scanning BLE peripherals")
            self.notification.displayNotificationWithMessage(message: "Scan des péripheriques BLE", forDuration: 2.0)
        }
        else {
            // Can have different conditions for all states if needed - print generic message for now
//            print("Bluetooth switched off or not initialized")
            self.notification.displayNotificationWithMessage(message: "Activez le Bluetooth", forDuration: 2.0)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if let name = peripheral.name {
            if name == "TwinMax" {
                peripheralDevice = peripheral
                print("Found TwinMax")
                
                // Attach the peripheral delegate
                peripheral.delegate = peripheralDelegate
                
                // Stop looking for more peripherals
                central.stopScan()
                print("BLE peripheral scan stopped")
                
                // Connect to this peripheral
                central.connect(peripheral, options: nil)
                print("Connecting to \(name)")
            }
        }
    }
    
    // Discover services of the peripheral
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.discoverServices(nil)
        print("Connected to \(peripheral.name!)")
        self.notification.displayNotificationWithMessage(message: "TwinMax appairé", forDuration: 2.0)
    }
    
    // If disconnected, start searching again
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        central.scanForPeripherals(withServices: nil, options: nil)
        print("Disconnected of \(peripheral.name!)")
        self.notification.displayNotificationWithMessage(message: "TwinMax déconnecté", forDuration: 2.0)
    }
}
