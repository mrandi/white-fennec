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
    let shell = Shell()
    
    func login(profile: String){
        
        do {
            try
                _ = shell.run("mai login \(profile)")
                notification.show("Mai login", msg: "Login for \(profile) successfull!")
        } catch ShellException.ShellError {
            
            ProfileToRefresh = ""
            notification.show("Mai login", msg: "Error during login for \(profile)!")
        
        } catch {
            
        }
    }
    
    func list() -> [String] {

        var output: String = ""
        
        do {
            output = try shell.run("mai list")
        } catch ShellException.ShellError {
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
    
}
