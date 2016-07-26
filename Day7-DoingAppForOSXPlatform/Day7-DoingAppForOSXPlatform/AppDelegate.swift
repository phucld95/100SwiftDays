//
//  AppDelegate.swift
//  Day7-DoingAppForOSXPlatform
//
//  Created by Le Phuc on 7/8/16.
//  Copyright © 2016 Lê Phúc. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var mpcManager: MPCManager! = nil


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        mpcManager = MPCManager()

        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

