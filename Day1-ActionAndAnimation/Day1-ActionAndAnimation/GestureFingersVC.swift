//
//  GestureFingersVC.swift
//  Day1-ActionAndAnimation
//
//  Created by Le Phuc on 5/27/16.
//  Copyright © 2016 Lê Phúc. All rights reserved.
//

import UIKit

class GestureFingersVC: UIViewController {

    @IBOutlet weak var vieMove: UIView!
    @IBOutlet weak var lbTapNumber: UILabel!
    var numberTaped:Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setup viewMove.
        self.vieMove.layer.cornerRadius = self.vieMove.frame.size.width / 2
        self.vieMove.layer.masksToBounds = true
        
        
        // setup gesture of finger
        let tap = UITapGestureRecognizer(target: self, action: #selector(GestureFingersVC.handleTap(_:)))
        vieMove.addGestureRecognizer(tap)
        lbTapNumber.text = "Taped: 0"
        
        let move = UIPanGestureRecognizer(target: self, action: #selector(GestureFingersVC.moveViewWithFinger(_:)))
        move.minimumNumberOfTouches = 1
        move.maximumNumberOfTouches = 1
        self.vieMove.addGestureRecognizer(move)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action.
    func moveViewWithFinger(sender: UIPanGestureRecognizer) {
        self.vieMove.bringSubviewToFront(sender.view!)
        let originalLocation = sender.translationInView(sender.view!)
        
        print("Tọa độ gốc (view chứa): \(originalLocation)")
        print("Tọa độ ban đầu: \(sender.view?.center)")
        
        var newCentralPoint = CGPointMake(0, 0)
        if (sender.state == .Changed) {
            newCentralPoint = (sender.view?.center)!
            newCentralPoint = CGPointMake(originalLocation.x + newCentralPoint.x, originalLocation.y + newCentralPoint.y)
            print("Toạ độ di chuyển đến: \(newCentralPoint)")

            sender.view!.center = newCentralPoint;
            sender.setTranslation(CGPointZero, inView: sender.view)
        }
    
    }
    
    
    func handleTap(sender: UITapGestureRecognizer) {
        numberTaped += 1
        lbTapNumber.text = "Taped: \(numberTaped)"
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
