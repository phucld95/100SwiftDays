//
//  ViewController.swift
//  testAnimatonWithTouch
//
//  Created by Le Phuc on 6/10/16.
//  Copyright © 2016 Lê Phúc. All rights reserved.
//

import UIKit
import Spring
import AVFoundation
import QuartzCore

class ViewController: UIViewController,UIGestureRecognizerDelegate {
    @IBOutlet weak var viePlay: UIView!
    @IBOutlet weak var vieBackGround: UIView!
    @IBOutlet weak var vie1: SpringView!
    @IBOutlet weak var vie2: SpringView!
    @IBOutlet weak var vie3: SpringView!
    @IBOutlet weak var vie4: SpringView!
    @IBOutlet weak var vieWaveform: SpringView!
    @IBOutlet weak var lbScore: UILabel!
    

    //Touch view
    @IBOutlet weak var vieTouch1: UIView!
    @IBOutlet weak var vieTouch2: UIView!
    @IBOutlet weak var vieTouch3: UIView!
    @IBOutlet weak var vieTouch4: UIView!
    
    
    var heightDevice:CGFloat! = nil
    var widthDevice: CGFloat! = nil
    var player: AVAudioPlayer!
    var score: Int!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenRect = UIScreen.mainScreen()
        heightDevice = screenRect.bounds.height
        widthDevice = screenRect.bounds.width
        
        // Init variable
        self.score = 0
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.setupViewDrum(vie1)
        self.setupViewDrum(vie2)
        self.setupViewDrum(vie3)
        self.setupViewDrum(vie4)
        vieWaveform.layer.cornerRadius = vieWaveform.bounds.size.width/2
        vieWaveform.layer.masksToBounds = true
        vieWaveform.animation = "pop"
        vieWaveform.curve = "easeOutSine"
        vieWaveform.duration = 0.1
        if #available(iOS 9.0, *) {
            loadViewIfNeeded()
        } else {
        }
        let fileUrl = NSBundle.mainBundle().URLForResource("ido", withExtension: "m4a")!
        
        do {
            player = try AVAudioPlayer(contentsOfURL: fileUrl)
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord, withOptions: AVAudioSessionCategoryOptions.DefaultToSpeaker)
            
            let updater = CADisplayLink(target: self, selector: #selector(ViewController.convertIntensity))
            updater.frameInterval = 1
            updater.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
            self.player.prepareToPlay()
            self.player.meteringEnabled = true
            self.player.play()
            
        } catch {
            // handle error
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func convertIntensity() {
        self.player.updateMeters()
        self.showDeeping(self.player.averagePowerForChannel(0))
    }
    
//    func setUpViewTouch(drum: UIView) {
//        drum.backgroundColor = UIColor.yellowColor()
//        let tapInDrum = UITapGestureRecognizer(target: self, action:#selector(ViewController.handleTap(_:)))
//        tapInDrum.delegate = self
//        drum.addGestureRecognizer(tapInDrum)
//        drum.userInteractionEnabled = true
//    }
    
    func setupViewDrum(drum: SpringView) {
        drum.backgroundColor = UIColor.yellowColor()
        drum.layer.cornerRadius = drum.layer.bounds.size.width/2
        drum.layer.masksToBounds = false
        let tapInDrum = UITapGestureRecognizer(target: self, action:#selector(ViewController.handleTap(_:)))
        tapInDrum.delegate = self
        drum.addGestureRecognizer(tapInDrum)
        drum.userInteractionEnabled = true
    }
    
//    func handleTap2(tap: UITapGestureRecognizer) {
//        let view: UIView = tap.view!
//        let className = NSStringFromClass(view.dynamicType)
//        print("View cliced: \(className)")
//        if view.tag == 1 {
//            view.center = CGPointMake(view.center.x, heightDevice + 25)
//            score = score + 1
//            self.updateLabelScore()
//        }
//        else{
//            
//        }
//        
//        
//    }
    
    func handleTap(tap: UITapGestureRecognizer) {
        let view: SpringView = tap.view! as! SpringView
        let className = NSStringFromClass(view.dynamicType)
        print("View cliced: \(className)")
        if view.tag == 1 {
            score = score + 1
            self.updateLabelScore()
            self.setDefault(view)
        }
        else{
            score = score - 1
            self.updateLabelScore()
        }
        view.animation = "zoomIn"
        view.curve = "easeOutQuad"
        view.duration = 1.0
        view.damping = 0.7
        view.velocity = 0
        view.animate()
        
    }
    
    func showDeeping(intensity: Float) {
        if intensity < -60.0 || intensity == 0.0 {
            vieWaveform.scaleX = 1.0
            vieWaveform.scaleY = 1.0
            vieWaveform.animate()
        }
        
        var out = powf((powf(10.0, 0.05 * intensity) - powf(10.0, 0.05 * -60.0)) * (1.0 / (1.0 - powf(10.0, 0.05 * -60.0))), 1.0 / 2.0)
        
        out = out * 1.2
        if out < 0.5 {
            out = 0.5
        }
        print("Scale: \(out)")

        vieWaveform.scaleX = CGFloat(out)
        vieWaveform.scaleY = CGFloat(out)
        vieWaveform.animate()
        if out > 1 {
            let drum: SpringView = self.randomDrum()
            if drum.tag == 1 {
                return
            }
            drum.backgroundColor = UIColor.blueColor()
            drum.tag = 1
//            UIView.animateWithDuration(3, animations: {
//                drum.center = CGPointMake(drum.center.x, -25)
//                }, completion: { (true) in
//                    drum.center = CGPointMake(drum.center.x, self.heightDevice + 25)
//            })

            
            let dispatchTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))
            dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                self.setDefault(drum)
            })
        }
    }
    
    func setDefault(view: SpringView) {
        if view.tag == 0 {
            return
        }
        view.backgroundColor = UIColor.yellowColor()
        view.tag = 0
    }
    
    func updateLabelScore() {
        lbScore.text = "Score: \(score)"
    }
    
    
    func randomDrum() -> (SpringView) {
        let rand = Int(arc4random_uniform(4) + 1)
        switch rand {
        case 1:
            return vie1
        case 2:
            return vie2
        case 3:
            return vie3
        case 4:
            return vie4
        default:
            return vie4
        }
    }

}

