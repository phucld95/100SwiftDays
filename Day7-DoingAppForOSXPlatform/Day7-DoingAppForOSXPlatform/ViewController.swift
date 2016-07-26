//
//  ViewController.swift
//  Day7-DoingAppForOSXPlatform
//
//  Created by Le Phuc on 7/8/16.
//  Copyright © 2016 Lê Phúc. All rights reserved.
//

import Cocoa
import MultipeerConnectivity

class ViewController: NSViewController,MPCManagerDelegate {

    @IBOutlet weak var imgArrow: NSImageView!
    let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        if appDelegate.mpcManager == nil {
            appDelegate.mpcManager = MPCManager()
        }
        
        appDelegate.mpcManager.delegate = self
        // Start brower find peers nearbyService
        appDelegate.mpcManager.browser.startBrowsingForPeers()
        // Setting other device can see this device.
        appDelegate.mpcManager.advertiser.startAdvertisingPeer()
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    
//MARK:- MPCMangerDelegate.
    // Call method when device received invitation.
    func invitationWasReceived(fromPeer: String) {
        // So alert invitation
        let a = NSAlert()
        a.messageText = "Invitation received!"
        a.informativeText = "Are you sure you would like to connect?"
        a.addButtonWithTitle("OK")
        a.addButtonWithTitle("Cancel")
        a.alertStyle = NSAlertStyle.WarningAlertStyle
        
        a.beginSheetModalForWindow(self.view.window!, completionHandler: { (modalResponse) -> Void in
            if modalResponse == NSAlertFirstButtonReturn {
                self.appDelegate.mpcManager.invitationHandler(true, self.appDelegate.mpcManager.session)
            }
            else if modalResponse == NSAlertSecondButtonReturn{
                self.appDelegate.mpcManager.invitationHandler = { (false, nil) in }
            }
        })
    }

    
    func connectedWithPeer(peerID: MCPeerID) {
        print("Connected!")
    }
    
    
    func connectFalse(peerID: MCPeerID) {
        print("ConnectFalse!")
    }

    // Call method when found peer.
    func foundPeer() {
        let listDevice = appDelegate.mpcManager.foundPeers
        print("\(listDevice)")
    }
    
    
    func lostPeer() {
    }
    
    
    
    
    
}

