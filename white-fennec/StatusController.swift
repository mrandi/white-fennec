//
//  StatusController.swift
//  white-fennec
//
//  Created by Michele Randi on 15/12/15.
//  Copyright © 2015 Michele Randi. All rights reserved.
//

import Foundation
import Cocoa

/// The StatusController manages the status item in the menu bar
class StatusController {
    
    /// The countdown stats
    let countdown = Countdown()
    
    /// The latest countdown load
    var countdownLoad: Double
    
    /// The status item in the menu bar
    let statusItem: NSStatusItem
    
    /// The timer updates the statusView
    var timer: Timer?
    
    /// Lazy load the statusView. We can't do this in init() because the statusView needs a reference to the StatusController.
    lazy var statusView: StatusView = StatusView(frame: NSZeroRect, statusController: self)
    
    /// Initialize the values, add the statusItem to the menu bar, and start the timer
    init() {
        let statusItemWidth = LeftMargin + BarWidth + RightMargin
        
        countdownLoad = countdown.load()
        statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(statusItemWidth)
        statusItem.view = statusView
        timer = Timer.repeatEvery(UpdateInterval) {
                [weak self] inTimer in
                if let strongSelf = self {
                    strongSelf.calculateCountdownLoad()
                    strongSelf.updateStatusItem()
                }
        }
    }
    
    func calculateCountdownLoad(){
        countdownLoad = countdown.load()
    }
    
    func getCountdownLoad() -> Double {
        return countdownLoad
    }
    
    /// Get the current load values and update the statusView
    func updateStatusItem() {
        statusView.setNeedsDisplayInRect(statusView.bounds)
    }
}
