//
//  MainViewController.swift
//  Day1-ActionAndAnimation
//
//  Created by Le Phuc on 5/27/16.
//  Copyright © 2016 Lê Phúc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var tbvListOption: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tbvListOption.delegate = self
        self.tbvListOption.dataSource = self
        
        
        // Setup naviagtion bar
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        self.title = "Menu"
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    

    //MARK:- UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell :UITableViewCell = UITableViewCell.init()
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Animation With Duration."
        case 1:
            cell.textLabel?.text = "CA Animation"
        case 2:
            cell.textLabel?.text = "Action in button."
        case 3:
            cell.textLabel?.text = "Gesture Fingers."
        default:
            cell.textLabel?.text = "NULL"
        }
        cell.backgroundColor = UIColor.grayColor()
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            let view:AnimationWithDurationVC = AnimationWithDurationVC(nibName: "AnimationWithDurationVC", bundle: nil)
            self.navigationController?.pushViewController(view, animated: true)
            
        }
        else if indexPath.row == 1{
            let view:CAAnimationVC = CAAnimationVC(nibName: "CAAnimationVC", bundle: nil)
            self.navigationController?.pushViewController(view, animated: true)
        }
        else if indexPath.row == 2{
            let view:ActionVC = ActionVC(nibName: "ActionVC", bundle: nil)
            self.navigationController?.pushViewController(view, animated: true)
        }
        else if indexPath.row == 3{
            let view:GestureFingersVC = GestureFingersVC(nibName: "GestureFingersVC", bundle: nil)
            self.navigationController?.pushViewController(view, animated: true)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
