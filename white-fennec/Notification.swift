//
//  Notification.swift
//  white-fennec
//
//  Created by Michele Randi on 15/12/15.
//  Copyright © 2015 Michele Randi. All rights reserved.
//

import Foundation

class Notification {
    
    func show(title: String, msg: String) -> Void {
        let notification = NSUserNotification()
        notification.title = title
        notification.informativeText = msg
        notification.soundName = NSUserNotificationDefaultSoundName
        NSUserNotificationCenter.defaultUserNotificationCenter().deliverNotification(notification)
    }
    
}