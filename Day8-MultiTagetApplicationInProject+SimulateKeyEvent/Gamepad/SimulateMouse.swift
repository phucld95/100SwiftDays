//
//  SimulateMouse.swift
//  Day8-MultiTagetApplicationInProject+SimulateKeyEvent
//
//  Created by Le Phuc on 7/11/16.
//
//

import Foundation
import Cocoa

final class SimulateMouse: NSObject{
    //MARK:- Property
    
    // Góc chiếu tối da từ người dùng đến màn hình.
    var distanceToMac: CGFloat?
    var startLocation: NSInteger?
    var startMagentic: NSInteger?
    
    var screenFrame = NSScreen.mainScreen()?.frame;
    var heightScreen: CGFloat?
    var weightScreen: CGFloat?
    
    var physicHeightScreen: CGFloat?
    var physicWeightScreen: CGFloat?
    
    
    let displayWidth: CGFloat = 30
    let displayHeight: CGFloat = 20
    
    var ratioWidth: CGFloat?
    var ratioHeight: CGFloat?
    
    var oldPoint = CGPoint()
    
//    var angleHeight: CGFloat?
//    var angleWidth: CGFloat?
    
    
    
    
    // MARK: Init
    
    override init() {
        super.init()
        heightScreen = screenFrame?.size.height
        weightScreen = screenFrame?.size.width
        distanceToMac = 11

        
        print("height Screen: \(heightScreen)")
        print("weight Screen: \(weightScreen)")
        
        ratioHeight = heightScreen! / 11 / 2
        ratioWidth = weightScreen! / 17 / 2
        
        oldPoint = CGPoint(x: weightScreen! / 2, y: heightScreen! / 2)
        
        
//        let screen = NSScreen.mainScreen();
//        let description = (screen?.deviceDescription)! as NSDictionary
//        let displayPhysicalSize = CGDisplayScreenSize(
//            description.objectForKey("NSScreenNumber"))
//        let screenSize: CGRect = NSScreen.mainScreen().bounds
//        let screenWidth = screenSize.width
//        let screenHeight = screenSize.height
        
    }
    
    func setDistanceToMac(distance: CGFloat) {
        self.distanceToMac = distance
    }
    
    func moveTo (angleHeight: CGFloat, _ angleWidth: CGFloat) {
//        print("height: \(angleHeight)")
//        print("width : \(angleWidth)")
        print("\(angleHeight) | \(angleWidth)")
        
        let point = self.calculateNewMousePosion(angleHeight, angleWidth)
        self.moveMouse(to: point)
    }
    
    
    private func calculateNewMousePosion(angleHeight: CGFloat, _ angleWidth: CGFloat) -> CGPoint {
        var newPoint = CGPoint()
//        newPoint.y = heightScreen! / 2 + tan(angleHeight) * distanceToMac! * ratioHeight!
//        newPoint.x = weightScreen! / 2 + tan(angleWidth) * distanceToMac! * ratioWidth!
        print("\(angleHeight) | \(angleWidth)")
        newPoint.y = oldPoint.y - angleHeight  * (800 / 50)
        newPoint.x = oldPoint.x + angleWidth * (1280 / 160)
        if newPoint.y > 1600 {
            newPoint.y = 1600
        }
        if newPoint.y < 0 {
            newPoint.y = 0
        }
        if newPoint.x > 2560 {
            newPoint.x = 2560
        }
        if newPoint.x < 0 {
            newPoint.x = 0
        }
        
        print("newPoint = \(newPoint)")
        oldPoint = newPoint
        
        return newPoint
    }
    
    private func moveMouse(to newPoint: CGPoint) {
        let moveTo = CGEventCreateMouseEvent(nil, CGEventType.MouseMoved, newPoint, CGMouseButton.Center)
        CGEventPost(CGEventTapLocation.CGHIDEventTap, moveTo)
    }
    
}