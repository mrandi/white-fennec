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
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        
        let icon = NSImage(named: "statusIcon")
        icon?.template = true
        
        statusItem.image = icon
        
        var lines: [String]
        lines = maiList()
        
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
    
    //func applicationWillTerminate(aNotification: NSNotification) {
    // Insert code here to tear down your application
    //}
    
    
    
    @IBAction func Quit(sender: AnyObject?) {
        NSLog("Exit")
        NSApplication.sharedApplication().terminate(self)
    }
    
    
    @IBAction func loginClicked(sender: NSMenuItem) {
        maiLogin(sender.title)
        
    }
    
    func maiLogin(profile: String){
        maiCommand(["login", profile])
        showNotification("Mai login", msg: "Login for \(profile) successfull!")
    }
    
    func maiList() -> [String] {
        let output = maiCommand(["list"])
        
        var result: [String] = []
        for line in output.componentsSeparatedByString("\n"){
            result.append(line.componentsSeparatedByString(" ").first!)
        }
        
        result.removeFirst()
        result.removeLast()
        
        return result
        
    }
    
    func maiCommand(parameters: [String]) -> String {
        
        let task = NSTask()
        task.launchPath = "/usr/local/bin/mai"
        task.arguments = parameters
        task.environment = ["LC_ALL":"en_US.utf-8","LANG":"en_US.utf-8"]
        
        let pipe = NSPipe()
        task.standardOutput = pipe
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output: NSString = NSString(data: data, encoding: NSUTF8StringEncoding)!
        
        print(output)
        task.waitUntilExit()
        
        return output as String
    }
    
    @NSCopying var contentImage: NSImage?
    
    func showNotification(title: String, msg: String) -> Void {
        contentImage = NSImage(named: "statusIcon")
        let notification = NSUserNotification()
        notification.title = title
        notification.informativeText = msg
        notification.soundName = NSUserNotificationDefaultSoundName
        notification.contentImage = NSImage(named: "statusIcon")
        NSUserNotificationCenter.defaultUserNotificationCenter().deliverNotification(notification)
    }

    
}

