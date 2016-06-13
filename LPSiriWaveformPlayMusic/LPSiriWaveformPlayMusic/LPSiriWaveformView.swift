//
//  LPSiriWaveformView.swift
//  LPSiriWaveformPlayMusic
//
//  Created by Le Phuc on 6/9/16.
//  Copyright © 2016 Lê Phúc. All rights reserved.
//

import UIKit
import Foundation


@IBDesignable
class LPSiriWaveformView: UIView {
    /*
     * Number of waves:
     * Default: 5
     */
     var numberOfWaves: Int! = 5
    
    /*
     * Color to use when drawing the waves
     * Default: while
     */
    @IBInspectable var waveColor:UIColor! = UIColor.whiteColor()
    
    /*
     * Line width used for the proeminent wave
     * Default: 3.0f
     */
    @IBInspectable var primaryWaveLineWidth:CGFloat! = 3.0
    
    /*
     * Line width used for all secondary waves
     * Default: 1.0f
     */
    @IBInspectable var secondaryWaveLineWidth: CGFloat! = 1.0
    
    /*
     * The amplitude that is used when the incoming amplitude is near zero.
     * Setting a value greater 0 provides a more vivid visualization.
     * Default: 0.01
     */
    
    @IBInspectable var idleAmplitude: CGFloat! = 0.01
    
    /*
     * The frequency of the sinus wave. The higher the value, the more sinus wave peaks you will have.
     * Default: 1.5
     */
    @IBInspectable var frequency: CGFloat! = 1.5
    
    
    /*
     * The current amplitude
     */
    
    @IBInspectable var amplitude: CGFloat! = 0.15
    
    /*
     * The lines are joined stepwise, the more dense you draw, the more CPU power is used.
     * Default: 5
     */
    @IBInspectable var density: CGFloat! = 5
    
    /*
     * The phase shift that will be applied with each level setting
     * Change this to modify the animation speed or direction
     * Default: -0.15
     */
    @IBInspectable var phaseShift: CGFloat! = -0.15
    
//MARK:- key (constant)
    let kDefaultFrequency: CGFloat          = 1.5;
    let kDefaultAmplitude: CGFloat          = 1.0;
    let kDefaultIdleAmplitude: CGFloat      = 0.01;
    let kDefaultNumberOfWaves: Int      = 5;
    let kDefaultPhaseShift: CGFloat         = -0.15;
    let kDefaultDensity: CGFloat            = 5.0;
    let kDefaultPrimaryLineWidth: CGFloat   = 3.0;
    let kDefaultSecondaryLineWidth: CGFloat = 1.0;
    
//MARK: -----------------
    private var phase: CGFloat?
    private var amplotude: CGFloat?
    
    /*
     * Tells the waveform to redraw itself using the given level (normalized value)
     */
    internal func updateWithLevel(level: CGFloat) {
        self.phase = self.phase! + self.phaseShift;
        self.amplitude = fmax(level, self.idleAmplitude);
        
        self.setNeedsDisplay()
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.setup()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
        self.waveColor = UIColor.orangeColor()
        self.frequency = kDefaultFrequency
        self.amplitude = kDefaultAmplitude
        self.idleAmplitude = kDefaultIdleAmplitude
        
        self.numberOfWaves = kDefaultNumberOfWaves
        self.phaseShift = kDefaultPhaseShift
        self.density = kDefaultDensity
        
        self.primaryWaveLineWidth = kDefaultPrimaryLineWidth
        self.secondaryWaveLineWidth = kDefaultSecondaryLineWidth
    }
    
    
    override func drawRect(rect: CGRect) {
        let context: CGContextRef = UIGraphicsGetCurrentContext()!
        CGContextClearRect(context, self.bounds)
        self.backgroundColor?.set()
        CGContextFillRect(context, rect)
        
        // We draw multiple sinus waves, with equal phases but altered amplitudes, multiplied by a parable function.

        for i in 0...numberOfWaves {
            let context:CGContextRef = UIGraphicsGetCurrentContext()!
            CGContextSetLineWidth(context, (i == 0 ? self.primaryWaveLineWidth : self.secondaryWaveLineWidth))
            let halfHeight:CGFloat = CGRectGetHeight(self.bounds)
            let width:CGFloat = CGRectGetWidth(self.bounds)
            let mid:CGFloat = width / 2.0
            
            let maxAmplitude:CGFloat = halfHeight - 4.0
            
            let progress:CGFloat = 1.0
            let normedAmplitude: CGFloat = (1.5 * progress - 0.5) * self.amplitude
            
            let multiplier:CGFloat = min(1.0, (progress / 3.0 * 2.0) + (1.0 / 3.0))
            
            self.waveColor.colorWithAlphaComponent(multiplier * CGColorGetAlpha(self.waveColor.CGColor)).set()
            
            var x:CGFloat = 0
            while x < (width + self.density) {
                x = x + self.density
                // We use a parable to scale the sinus wave, that has its peak in the middle of the view.
                let scaling: CGFloat = -pow(1 / mid * (x - mid), 2) + 1
//                let sinfValue = sinf(2 * 3.14 * Float(x / width) * Float(self.frequency) + Float(self.phase!))
                
//                let y = scaling * maxAmplitude * normedAmplitude * CGFloat(sinfValue) + halfHeight
                let y = scaling * maxAmplitude * normedAmplitude + halfHeight

                if x == 0 {
                    CGContextMoveToPoint(context, x, y);
                }
                else{
                    CGContextAddLineToPoint(context, x, y);
                }
                
            }

            CGContextStrokePath(context);
            
        }
    }
    
    
    
    
    
    
    
    
    
}
