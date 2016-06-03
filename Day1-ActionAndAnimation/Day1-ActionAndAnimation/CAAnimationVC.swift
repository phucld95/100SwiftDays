//
//  CAAnimationVC.swift
//  Day1-ActionAndAnimation
//
//  Created by Le Phuc on 5/27/16.
//  Copyright © 2016 Lê Phúc. All rights reserved.
//

import UIKit

class CAAnimationVC: UIViewController {

    @IBOutlet weak var lbWecome: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        let transformAnim            = CAKeyframeAnimation(keyPath:"transform")
        transformAnim.values         = [
            NSValue(CATransform3D: CATransform3DMakeRotation(60 * CGFloat(M_PI/180), 0, 0, -1)),
            NSValue(CATransform3D: CATransform3DConcat(CATransform3DMakeScale(1.5, 1.5, 1), CATransform3DMakeRotation(60 * CGFloat(M_PI/180), 0, 0, 1))),
            NSValue(CATransform3D: CATransform3DMakeScale(1.5, 1.5, 1)),
            NSValue(CATransform3D: CATransform3DConcat(CATransform3DMakeScale(1.5, 1.5, 1.9), CATransform3DMakeRotation(-8 * CGFloat(M_PI/180), 0, 0, 1)))]
        transformAnim.keyTimes       = [0, 0.349, 0.618, 1]
        transformAnim.duration       = 3
        self.lbWecome.layer.addAnimation(transformAnim, forKey: "transform")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
