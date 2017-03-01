//
//  FrameDecoder.swift
//  Twinmax
//
//  Created by Annihil on 10/19/16.
//  Copyright © 2016 ISEN. All rights reserved.
//

import Foundation

let newDataAvailable = "fr.selectronic.newDataAvailable"

class FrameDecoder {
    var waitingHead: Bool = true
    var buffer = [Int]()
    let differenceFactor: Int = 315
    let conversionFactor = 1.837
    var packetCount: UInt = 0
    var lastPacketCount: UInt = 0
    
    func decode(data: Data) {
        for i in 0..<data.count {
            if waitingHead {
                if isHead(b: data[i]) {
                    waitingHead = false
                }
            }
            else {
                if isHead(b: data[i]) {
                    buffer = []
                    waitingHead = false
                }
                
                if isFrameCorrect(b: data[i]) {
                    buffer.append(Int(data[i]))
                }
                
                if buffer.count == 8 {
                    decodeFrame(array: buffer)
                    waitingHead = true
                    buffer = []
                }
            }
        }
    }
    
    func decodeFrame(array: [Int]) {
        for i in 0..<4 {
            let val = buffer[(3-i)*2] << 5 + buffer[(3-i)*2+1] >> 1
            let fin: Double = Double(val - differenceFactor) / conversionFactor
            cylinders[i].append(fin)
//            print("\(cylinders[i].last!) ", terminator: "")
        }
        packetCount += 1
        
        if UInt(packetCount - lastPacketCount) > 100 {
            NotificationCenter.default.post(name: Notification.Name(rawValue: newDataAvailable), object: self)
            lastPacketCount = packetCount
        }
    }
    
    func isFrameCorrect(b: UInt8) -> Bool {
        return b & 0b00000001 != 1 && b & 0b10000000 != 0b10000000
    }
    
    func isHead(b: UInt8) -> Bool {
        return b == 0b10000000
    }
}
