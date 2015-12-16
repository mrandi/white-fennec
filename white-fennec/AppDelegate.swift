//
//  AppDelegate.swift
//  white-fennec
//
//  Created by Michele Randi on 14/12/15.
//  Copyright © 2015 Michele Randi. All rights reserved.
//

import Cocoa

// Visual Parameters
let BarWidth: CGFloat = 7.0
let GapBetweenBars: CGFloat = 6.0
let LeftMargin: CGFloat = 5.5
let RightMargin: CGFloat = 5.5

// Update interval in seconds
let UpdateInterval = 60.0

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let statusController = StatusController()
    
    let speechController = SpeechController()
    
    @IBOutlet weak var maiLogin: NSMenu!
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    
    let mai = Mai()
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        let icon = NSImage(named: "statusIcon")
        icon?.template = true
        statusItem.image = icon
        
        var lines: [String]
        lines = mai.list()
        
        for line in lines{
            let nsmi = NSMenuItem()
            nsmi.title = line
            nsmi.action = Selector("loginClicked:")
            maiLogin.addItem(nsmi)
        }
        
        maiLogin.addItem(NSMenuItem.separatorItem())
        
        let listen = NSMenuItem()
        listen.title = "Listen"
        listen.action = Selector("Listen:")
        maiLogin.addItem(listen)
        
        let stopListen = NSMenuItem()
        stopListen.title = "Stop listen"
        stopListen.action = Selector("StopListen:")
        maiLogin.addItem(stopListen)
        
        maiLogin.addItem(NSMenuItem.separatorItem())
        
        let q = NSMenuItem()
        q.title = "Quit"
        q.action = Selector("Quit:")
        maiLogin.addItem(q)
        
        statusItem.menu = maiLogin
        
    }
    
    
    @IBAction func Quit(sender: AnyObject?) {
        NSLog("Exit")
        NSApplication.sharedApplication().terminate(self)
    }
    
    
    @IBAction func loginClicked(sender: NSMenuItem) {
        mai.login(sender.title)
        
    }
    
    @IBAction func Listen(sender: AnyObject) {
        speechController.listen()
    }
    
    @IBAction func StopListen(sender: AnyObject) {
        speechController.stop()
    }
    
}

