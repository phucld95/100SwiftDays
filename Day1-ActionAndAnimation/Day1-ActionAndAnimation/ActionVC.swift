//
//  ActionVC.swift
//  Day1-ActionAndAnimation
//
//  Created by Le Phuc on 5/27/16.
//  Copyright © 2016 Lê Phúc. All rights reserved.
//

import UIKit

class ActionVC: UIViewController {

    @IBOutlet weak var bt1: UIButton!
    @IBOutlet weak var bt2: UIButton!
    @IBOutlet weak var bt3: UIButton!
    @IBOutlet weak var lbResult: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        bt1.addTarget(self, action: #selector(ActionVC.show(_:)), forControlEvents: .TouchUpInside)
        bt2.addTarget(self, action: #selector(ActionVC.show(_:)), forControlEvents: .TouchUpInside)
        bt3.addTarget(self, action: #selector(ActionVC.show(_:)), forControlEvents: .TouchUpInside)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Action.
    
    func show(tag: UIButton) -> Void {
        self.lbResult.text = tag.titleLabel?.text
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
