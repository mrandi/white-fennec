//
//  Speech.swift
//  white-fennec
//
//  Created by Michele Randi on 16/12/15.
//  Copyright © 2015 Michele Randi. All rights reserved.
//

import Cocoa

class SpeechController: NSObject, NSSpeechRecognizerDelegate {
    
    let mai = Mai()
    
    var sr = NSSpeechRecognizer()
    
    override init(){
        super.init()
        
        sr!.delegate = self
        sr!.commands = mai.list()
    }
    
    func listen() {
        sr!.startListening()
    }
    
    func stop() {
        sr!.stopListening()
    }
    
    func speechRecognizer(sender: NSSpeechRecognizer, didRecognizeCommand command: String){
        
        print("\(command)\n")
        ProfileToRefresh = command
        mai.login(command)
        
    }
}