//
//  StatusView.swift
//  white-fennec
//
//  Created by Michele Randi on 15/12/15.
//  Copyright © 2015 Michele Randi. All rights reserved.
//

import Foundation
import Cocoa
import Darwin

/// The StatusView reflects the current cpu/network load
class StatusView: NSView {
    
    /// The reference to the StatusController
    unowned let statusController: StatusController
    

    lazy var countdownColorRed = NSColor(deviceCyan: 0.00, magenta: 0.84, yellow: 0.90, black: 0.00, alpha: 1.0)
    lazy var countdownColorYellow = NSColor(deviceCyan: 0.00, magenta: 0.13, yellow: 0.80, black: 0.00, alpha: 1.0)
    lazy var countdownColorGreen = NSColor(deviceCyan: 0.62, magenta: 0.0, yellow: 0.50, black: 0.15, alpha: 1.0)
    
    
    /// The stroke color of the load bars
    lazy var strokeColor = NSColor(calibratedWhite: 0.5, alpha: 0.3)
    
    /// The background gradient of the load bars
    lazy var backgroundGradient = NSGradient(colors: [
        NSColor(calibratedWhite: 0.5, alpha: 0.25),
        NSColor(calibratedWhite: 0.5, alpha: 0),
        NSColor(calibratedWhite: 0.5, alpha: 0.25)])
    
    /// Initialize the StatusView with a reference to the StatusController
    init(frame frameRect: NSRect, statusController: StatusController) {
        self.statusController = statusController
        super.init(frame: frameRect)
    }
    
    /// Required initializer for NSView subclasses
    convenience required init?(coder: NSCoder) {
        self.init(frame: NSMakeRect(0, 0, 0, 0), statusController: StatusController())
    }
    
    /// Draw the load bar
    func drawBarInFrame(frame: NSRect, fillColor: NSColor, percentage: Double) {
        backgroundGradient?.drawInRect(frame, angle: 0)
        strokeColor.setStroke()
        NSBezierPath.strokeRect(frame)
        let loadHeight = CGFloat(floor((Double(frame.size.height) + 1) * percentage))
        let loadFrame = NSMakeRect(frame.origin.x - 0.5, frame.origin.y - 0.5, frame.size.width + 1, loadHeight)
        fillColor.setFill()
        NSBezierPath.fillRect(loadFrame)
    }
    
    /// Draw the contents of the StatusView
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        var frame = NSMakeRect(LeftMargin, 3.5, BarWidth, 16)
        
        if (statusController.getCountdownLoad() < 0.25) {
            drawBarInFrame(frame, fillColor: countdownColorRed, percentage: statusController.getCountdownLoad())
        } else if (statusController.getCountdownLoad() < 0.5) {
            drawBarInFrame(frame, fillColor: countdownColorYellow, percentage: statusController.getCountdownLoad())
        } else {
            drawBarInFrame(frame, fillColor: countdownColorGreen, percentage: statusController.getCountdownLoad())
        }
        
        frame.origin.x += (BarWidth + GapBetweenBars)
        
    }
}

