//
//  Shell.swift
//  white-fennec
//
//  Created by Gregor Kneitschel on 07/01/16.
//  Copyright © 2016 Michele Randi. All rights reserved.
//

import Foundation

class Shell {
    
    let command = NSTask()
    let pipe = NSPipe()
    
    init(){
        /// python and locales on a mac
        command.environment = ["LC_ALL":"en_US.utf-8","LANG":"en_US.utf-8"]
        
        command.standardOutput = pipe //TODO: What about stderr?
        
        /// use current user shell
        command.launchPath = NSProcessInfo().environment["SHELL"] as String!
        
    }
    
    func run(runCommand: String) throws -> String{
        /// use the users login shell
        command.arguments = ["-c", "-l", runCommand]
        
        /// run the command
        command.launch()
        
        /// fetch data from pipe
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        
        /// block till ready
        command.waitUntilExit()
       
        if command.terminationStatus != 0 {
            throw ShellException.ShellError
        }
        
        /// convert to string and return
        return NSString(data: data, encoding: NSUTF8StringEncoding)! as String
    }
}