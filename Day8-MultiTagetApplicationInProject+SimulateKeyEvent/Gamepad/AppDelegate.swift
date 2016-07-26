//
//  AppDelegate.swift
//  Gamepad
//
//  Created by Le Phuc on 7/10/16.
//
//

import Cocoa
import AppKit
import Carbon
import MultipeerConnectivity
import Foundation

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, MCProtocol {

    // MARK: Properties
    
    let _keyMapping = [
        "a" : 0,
        "s" : 1,
        "d" : 2,
        "f" : 3,
        "h" : 4,
        "g" : 5,
        "z" : 6,
        "x" : 7,
        "c" : 8,
        "v" : 9,
        "b" : 11,
        "q" : 12,
        "w" : 13,
        "e" : 14,
        "r" : 15,
        "y" : 16,
        "t" : 17,
        "1" : 18,
        "2" : 19,
        "3" : 20,
        "4" : 21,
        "6" : 22,
        "5" : 23,
        "=" : 24,
        "9" : 25,
        "7" : 26,
        "-" : 27,
        "8" : 28,
        "0" : 29,
        "]" : 30,

//    if (strcmp(keyString, "o") == 0) return 31;
//    if (strcmp(keyString, "u") == 0) return 32;
//    if (strcmp(keyString, "[") == 0) return 33;
//    if (strcmp(keyString, "i") == 0) return 34;
//    if (strcmp(keyString, "p") == 0) return 35;
//    if (strcmp(keyString, "RETURN") == 0) return 36;
//    if (strcmp(keyString, "l") == 0) return 37;
//    if (strcmp(keyString, "j") == 0) return 38;
//    if (strcmp(keyString, "'") == 0) return 39;
//    if (strcmp(keyString, "k") == 0) return 40;
//    if (strcmp(keyString, ";") == 0) return 41;
//    if (strcmp(keyString, "\\") == 0) return 42;
//    if (strcmp(keyString, ",") == 0) return 43;
//    if (strcmp(keyString, "/") == 0) return 44;
//    if (strcmp(keyString, "n") == 0) return 45;
//    if (strcmp(keyString, "m") == 0) return 46;
//    if (strcmp(keyString, ".") == 0) return 47;
//    if (strcmp(keyString, "TAB") == 0) return 48;
//    if (strcmp(keyString, "SPACE") == 0) return 49;
//    if (strcmp(keyString, "`") == 0) return 50;
//    if (strcmp(keyString, "DELETE") == 0) return 51;
//    if (strcmp(keyString, "ENTER") == 0) return 52;
//    if (strcmp(keyString, "ESCAPE") == 0) return 53;
//    
//    // some more missing codes abound, reserved I presume, but it would
//    // have been helpful for Apple to have a document with them all listed
//    
//    if (strcmp(keyString, ".") == 0) return 65;
//    
//    if (strcmp(keyString, "*") == 0) return 67;
//    
//    if (strcmp(keyString, "+") == 0) return 69;
//    
//    if (strcmp(keyString, "CLEAR") == 0) return 71;
//    
//    if (strcmp(keyString, "/") == 0) return 75;
//    if (strcmp(keyString, "ENTER") == 0) return 76;  // numberpad on full kbd
//    
//    if (strcmp(keyString, "=") == 0) return 78;
//    
//    if (strcmp(keyString, "=") == 0) return 81;
//    if (strcmp(keyString, "0") == 0) return 82;
//    if (strcmp(keyString, "1") == 0) return 83;
//    if (strcmp(keyString, "2") == 0) return 84;
//    if (strcmp(keyString, "3") == 0) return 85;
//    if (strcmp(keyString, "4") == 0) return 86;
//    if (strcmp(keyString, "5") == 0) return 87;
//    if (strcmp(keyString, "6") == 0) return 88;
//    if (strcmp(keyString, "7") == 0) return 89;
//    
//    if (strcmp(keyString, "8") == 0) return 91;
//    if (strcmp(keyString, "9") == 0) return 92;
//    
//    if (strcmp(keyString, "F5") == 0) return 96;
//    if (strcmp(keyString, "F6") == 0) return 97;
//    if (strcmp(keyString, "F7") == 0) return 98;
//    if (strcmp(keyString, "F3") == 0) return 99;
//    if (strcmp(keyString, "F8") == 0) return 100;
//    if (strcmp(keyString, "F9") == 0) return 101;
//    
//    if (strcmp(keyString, "F11") == 0) return 103;
//    
//    if (strcmp(keyString, "F13") == 0) return 105;
//    
//    if (strcmp(keyString, "F14") == 0) return 107;
//    
//    if (strcmp(keyString, "F10") == 0) return 109;
//    
//    if (strcmp(keyString, "F12") == 0) return 111;
//    
//    if (strcmp(keyString, "F15") == 0) return 113;
//    if (strcmp(keyString, "HELP") == 0) return 114;
//    if (strcmp(keyString, "HOME") == 0) return 115;
//    if (strcmp(keyString, "PGUP") == 0) return 116;
//    if (strcmp(keyString, "DELETE") == 0) return 117;
//    if (strcmp(keyString, "F4") == 0) return 118;
//    if (strcmp(keyString, "END") == 0) return 119;
//    if (strcmp(keyString, "F2") == 0) return 120;
//    if (strcmp(keyString, "PGDN") == 0) return 121;
//    if (strcmp(keyString, "F1") == 0) return 122;
//    if (strcmp(keyString, "LEFT") == 0) return 123;
//    if (strcmp(keyString, "RIGHT") == 0) return 124;
//    if (strcmp(keyString, "DOWN") == 0) return 125;
//    if (strcmp(keyString, "UP") == 0) return 126;
    ]
    

    let multipeerClient = MultipeerClient()
    private let menuView = MenuView()
    let mouse = SimulateMouse()

    // MARK: App

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        self.multipeerClient.delegate = self
        multipeerClient.onStateChange = { state, fromPeer in
            let stateString: String
            switch state {
            case .NotConnected:
                stateString = "Not Connected"
            case .Connecting:
                stateString = "Connecting..."
            case .Connected:
                stateString = (fromPeer?.displayName)!
            }
            dispatch_async(dispatch_get_main_queue()) {
                self.menuView.menu?.itemAtIndex(0)?.title = stateString
            }
        }
        
        
        
        
        
    }
    

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    //MARK:- MCProtocol
    func didReceivedData(data: NSData) {
        guard let dataUnarchier = NSKeyedUnarchiver.unarchiveObjectWithData(data) else{ return }
        let dicData = dataUnarchier as! NSDictionary
        if dicData.valueForKey("command") as! String == "press" {
            let char = dicData.valueForKey("key") as! NSString
            self.pushKeyStrocksEvent(getIndexFromCharactor(char))
        }
        else if dicData.valueForKey("command") as! String == "hold"{
            let char = dicData.valueForKey("key") as! NSString
            self.pushHoldOnKeyStrocksEvent(getIndexFromCharactor(char))
        }
        else if dicData.valueForKey("command") as! String == "release"{
            let char = dicData.valueForKey("key") as! NSString
            self.pushReleaseKeyStrocksEvent(getIndexFromCharactor(char))
        }
        else if dicData.valueForKey("command") as! String == "moveMouse"{
            let ratioWidth = dicData.valueForKey("width") as! CGFloat
            let ratioHeight = dicData.valueForKey("height") as! CGFloat
            mouse.moveTo(ratioHeight, ratioWidth)
        }
        else if dicData.valueForKey("command") as! String == "setDistance"{
            let distance = dicData.valueForKey("distance") as! CGFloat
            mouse.setDistanceToMac(distance)
        }
        
    }
    

    //MARK:- Action.
    
    func quit() {
        NSApplication.sharedApplication().terminate(self)
    }
    
    private func setKey(keyChar: NSString?) {
        guard let keyChar = keyChar else { return }
        print("Key received: \(keyChar)")
        self.pushKeyStrocksEvent(getIndexFromCharactor(keyChar))
        
    }
    
    private func getIndexFromCharactor(keyString: NSString) -> NSInteger{
        return _keyMapping[keyString as String]!
    }
    
    private func pushKeyStrocksEvent(index: NSInteger){
        let src = CGEventSourceCreate(CGEventSourceStateID.HIDSystemState);

        let aDown = CGEventCreateKeyboardEvent(src, 0, true)
        let aUp = CGEventCreateKeyboardEvent(src, 0, false)
        let loc = CGEventTapLocation.CGHIDEventTap; // kCGSessionEventTap also works
        CGEventPost(loc, aDown);
        CGEventPost(loc, aUp);
    }
    
    private func pushHoldOnKeyStrocksEvent(index: NSInteger){
        let src = CGEventSourceCreate(CGEventSourceStateID.HIDSystemState);
        
        let aDown = CGEventCreateKeyboardEvent(src, 0, true)
        //let aUp = CGEventCreateKeyboardEvent(src, 0, false)
        let loc = CGEventTapLocation.CGHIDEventTap; // kCGSessionEventTap also works
        CGEventPost(loc, aDown);
        //CGEventPost(loc, aUp);
    }
    
    private func pushReleaseKeyStrocksEvent(index: NSInteger){
        let src = CGEventSourceCreate(CGEventSourceStateID.HIDSystemState);
        
        let aUp = CGEventCreateKeyboardEvent(src, 0, false)
        let loc = CGEventTapLocation.CGHIDEventTap; // kCGSessionEventTap also works
        CGEventPost(loc, aUp);
    }
}

