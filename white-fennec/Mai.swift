//
//  Mai.swift
//  white-fennec
//
//  Created by Michele Randi on 15/12/15.
//  Copyright © 2015 Michele Randi. All rights reserved.
//

import Foundation

class Mai{
    
    let notification = Notification()
    
    func login(profile: String){
        
        do{
            try command(["login", profile])
            notification.show("Mai login", msg: "Login for \(profile) successfull!")
        }catch MaiException.CommandError{
            
            ProfileToRefresh = ""
            notification.show("Mai login", msg: "Error during login for \(profile)!")
        } catch{
            
        }
    }
    
    func list() -> [String] {

        var output: String = ""
        
        do {
            output = try command(["list"])
        } catch MaiException.CommandError {
           notification.show("Mai list", msg: "Error during ´mai list´ command execution!")
        } catch{
            
        }
    
        var result: [String] = []
        for line in output.componentsSeparatedByString("\n"){
            result.append(line.componentsSeparatedByString(" ").first!)
        }
        
        result.removeFirst()
        result.removeLast()
        
        return result
        
    }
    
    func command(parameters: [String]) throws -> String {
        
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

        if (task.terminationStatus != 0){
            throw MaiException.CommandError
        }
        
        return output as String
    }
    
}
