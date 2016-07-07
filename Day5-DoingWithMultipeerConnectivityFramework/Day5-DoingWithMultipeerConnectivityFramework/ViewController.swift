//
//  ViewController.swift
//  Day5-DoingWithMultipeerConnectivityFramework
//
//  Created by Le Phuc on 6/22/16.
//  Copyright © 2016 Lê Phúc. All rights reserved.
//

import UIKit
import MultipeerConnectivity



class ViewController: UIViewController, MPCManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tbvPeers: UITableView!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var isAdvertising: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbvPeers.delegate = self
        tbvPeers.dataSource = self
        
        appDelegate.mpcManager.delegate = self
        // Start brower find peers nearbyService
        appDelegate.mpcManager.browser.startBrowsingForPeers()
        // Setting other device can see this device.
        appDelegate.mpcManager.advertiser.startAdvertisingPeer()
        
        isAdvertising = true

        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//MARK:-Tableview datasource + delegate
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell1")! as UITableViewCell

        cell.textLabel?.text = appDelegate.mpcManager.foundPeers[indexPath.row].displayName
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.mpcManager.foundPeers.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // Select peer in row.
        let selectedPeer = appDelegate.mpcManager.foundPeers[indexPath.row] as MCPeerID
        
        // Send invite connect to peer with context (data want to send). Time out 20 timeInterval.
        appDelegate.mpcManager.browser.invitePeer(selectedPeer, toSession: appDelegate.mpcManager.session, withContext: nil, timeout: 20)
        
    }

//MARK:- MPCManagerDelegate
    // Call method when found peer.
    func foundPeer() {
        tbvPeers.reloadData()
    }
    
    
    func lostPeer() {
        tbvPeers.reloadData()
    }

    // Call method when device received invitation.
    func invitationWasReceived(fromPeer: String) {
        // So alert invitation
        let alert = UIAlertController(title: "Ding dong!", message: "\(fromPeer) wants to chat with you!", preferredStyle: UIAlertControllerStyle.Alert)
        
        let acceptAction: UIAlertAction = UIAlertAction(title: "Accept", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            self.appDelegate.mpcManager.invitationHandler(true, self.appDelegate.mpcManager.session)
        }
        
        let declineAction = UIAlertAction(title: "Not now", style: UIAlertActionStyle.Cancel) { (alertAction) -> Void in
            
            self.appDelegate.mpcManager.invitationHandler = { (false, nil) in }
        }
        
        alert.addAction(acceptAction)
        alert.addAction(declineAction)
        
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
    func connectedWithPeer(peerID: MCPeerID) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("chatView") as! LPChatVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


