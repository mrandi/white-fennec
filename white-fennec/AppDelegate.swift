//
//  AppDelegate.swift
//  white-fennec
//
//  Created by Michele Randi on 14/12/15.
//  Copyright © 2015 Michele Randi. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    
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
    
}

