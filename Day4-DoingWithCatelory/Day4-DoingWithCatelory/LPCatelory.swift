//
//  Catelory.swift
//  Day4-DoingWithCatelory
//
//  Created by Le Phuc on 6/13/16.
//  Copyright © 2016 Lê Phúc. All rights reserved.
//

import UIKit

/**
 In Swift, you can use Extensions to add new functionality to existing classes, structs and enumeration types.
 
 They differ from Objective-C categories in a few ways, mainly:
 
 They aren't named
 You don't need to import an Extension explicitly. If you define an extension to add new functionality to an existing type, the new functionality will be available on all existing instances of that type, even if they were created before the extension was defined.
 As stated above, they work not only with classes, but with other types as well.
 As it stands today, Extensions can:
 
 Add computed properties and computed static properties
 Define instance methods and type methods
 Provide new initializers
 Define subscripts
 Define and use new nested types
 Make an existing type conform to a protocol
 The basic syntax to declare an extension is as follows:
 
 
 extension SomeType {
    // new functionality to add to SomeType goes here
 }

 NOTE: Extensions can add new functionality to a type, but they cannot override existing functionality.
 
 An extension can extend an existing type to make it adopt one or more protocols. Where this is the case, the protocol names are written in exactly the same way as for a class or structure:
 
 extension SomeType: SomeProtocol, AnotherProtocol {
    // implementation of protocol requirements goes here
 }
 
 */





extension UIColor {
    func colorWithHexString (hexCode hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.grayColor()
        }
        
        var rgbValue:UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}





























