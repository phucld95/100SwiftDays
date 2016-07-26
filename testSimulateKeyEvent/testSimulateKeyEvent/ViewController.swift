//
//  ViewController.swift
//  testSimulateKeyEvent
//
//  Created by Le Phuc on 7/10/16.
//  Copyright © 2016 Lê Phúc. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.excuteCommandQ()
    }
    func excuteCommandQ() {
        let src = CGEventSourceCreate(CGEventSourceStateID.HIDSystemState)
        
        let cmdd = CGEventCreateKeyboardEvent(src, 0x37, true)
        let cmdu = CGEventCreateKeyboardEvent(src, 0x37, false)
        let spcd = CGEventCreateKeyboardEvent(src, 0x0C, true)
        let spcu = CGEventCreateKeyboardEvent(src, 0x0C, false)
        
        CGEventSetFlags(spcd, CGEventFlags.MaskCommand)
        CGEventSetFlags(spcu, CGEventFlags.MaskCommand)
        
        let loc = CGEventTapLocation.CGHIDEventTap
        
        CGEventPost(loc, cmdd)
        CGEventPost(loc, spcd)
        CGEventPost(loc, spcu)
        CGEventPost(loc, cmdu)
    }
    
    
    
    
    

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

