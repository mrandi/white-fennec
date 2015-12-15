//
//  Countdown.swift
//  white-fennec
//
//  Created by Michele Randi on 15/12/15.
//  Copyright © 2015 Michele Randi. All rights reserved.
//
import Foundation
import Cocoa
import Darwin

class Countdown {
    
    let oneHour: Double = 60.0
    var counter: Double = 0.0
    
    func load() -> Double {
        let result = 1 - (counter * (Double(1) / oneHour))
        counter++
        return result
    }
}
