//
//  AnimationWithDurationVC.swift
//  Day1-ActionAndAnimation
//
//  Created by Le Phuc on 5/27/16.
//  Copyright © 2016 Lê Phúc. All rights reserved.
//

import UIKit

class AnimationWithDurationVC: UIViewController {
    @IBOutlet weak var lbLePhuc: UILabel!
    @IBOutlet weak var lbLoopForever: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.lbLePhuc.frame = CGRectMake(self.lbLePhuc.frame.origin.x, 150, self.lbLePhuc.frame.size.width, self.lbLePhuc.layer.bounds.size.height)

        
        UIView.animateWithDuration(3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.2, options: [.Repeat, .Autoreverse], animations: {
            self.lbLePhuc.frame = CGRectMake(self.lbLePhuc.frame.origin.x, 300, self.lbLePhuc.frame.size.width, self.lbLePhuc.layer.bounds.size.height)
            }) { (true) in
                self.lbLePhuc.text = "Are you know me?"
        }

        
    
        
        
        
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
