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

public enum AnimationPreset: String {
    case SlideLeft = "slideLeft"
    case SlideRight = "slideRight"
    case SlideDown = "slideDown"
    case SlideUp = "slideUp"
    case SqueezeLeft = "squeezeLeft"
    case SqueezeRight = "squeezeRight"
    case SqueezeDown = "squeezeDown"
    case SqueezeUp = "squeezeUp"
    case FadeIn = "fadeIn"
    case FadeOut = "fadeOut"
    case FadeOutIn = "fadeOutIn"
    case FadeInLeft = "fadeInLeft"
    case FadeInRight = "fadeInRight"
    case FadeInDown = "fadeInDown"
    case FadeInUp = "fadeInUp"
    case ZoomIn = "zoomIn"
    case ZoomOut = "zoomOut"
    case Fall = "fall"
    case Shake = "shake"
    case Pop = "pop"
    case FlipX = "flipX"
    case FlipY = "flipY"
    case Morph = "morph"
    case Squeeze = "squeeze"
    case Flash = "flash"
    case Wobble = "wobble"
    case Swing = "swing"
}

public enum AnimationCurve: String {
    case EaseIn = "easeIn"
    case EaseOut = "easeOut"
    case EaseInOut = "easeInOut"
    case Linear = "linear"
    case Spring = "spring"
    case EaseInSine = "easeInSine"
    case EaseOutSine = "easeOutSine"
    case EaseInOutSine = "easeInOutSine"
    case EaseInQuad = "easeInQuad"
    case EaseOutQuad = "easeOutQuad"
    case EaseInOutQuad = "easeInOutQuad"
    case EaseInCubic = "easeInCubic"
    case EaseOutCubic = "easeOutCubic"
    case EaseInOutCubic = "easeInOutCubic"
    case EaseInQuart = "easeInQuart"
    case EaseOutQuart = "easeOutQuart"
    case EaseInOutQuart = "easeInOutQuart"
    case EaseInQuint = "easeInQuint"
    case EaseOutQuint = "easeOutQuint"
    case EaseInOutQuint = "easeInOutQuint"
    case EaseInExpo = "easeInExpo"
    case EaseOutExpo = "easeOutExpo"
    case EaseInOutExpo = "easeInOutExpo"
    case EaseInCirc = "easeInCirc"
    case EaseOutCirc = "easeOutCirc"
    case EaseInOutCirc = "easeInOutCirc"
    case EaseInBack = "easeInBack"
    case EaseOutBack = "easeOutBack"
    case EaseInOutBack = "easeInOutBack"
}


extension UIView {
    
    @IBInspectable public var autostart: Bool = false
    @IBInspectable public var autohide: Bool = false
    @IBInspectable public var animation: String = ""
    @IBInspectable public var force: CGFloat = 1
    @IBInspectable public var delay: CGFloat = 0
    @IBInspectable public var duration: CGFloat = 0.7
    @IBInspectable public var damping: CGFloat = 0.7
    @IBInspectable public var velocity: CGFloat = 0.7
    @IBInspectable public var repeatCount: Float = 1
    @IBInspectable public var x: CGFloat = 0
    @IBInspectable public var y: CGFloat = 0
    @IBInspectable public var scaleX: CGFloat = 1
    @IBInspectable public var scaleY: CGFloat = 1
    @IBInspectable public var rotate: CGFloat = 0
    @IBInspectable public var curve: String = ""
    public var opacity: CGFloat = 1
    public var animateFrom: Bool = false
    
}





























