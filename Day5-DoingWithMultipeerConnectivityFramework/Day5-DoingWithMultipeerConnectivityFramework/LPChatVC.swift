//
//  LPChatVC.swift
//  Day5-DoingWithMultipeerConnectivityFramework
//
//  Created by Le Phuc on 6/23/16.
//  Copyright © 2016 Lê Phúc. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class LPChatVC: UIViewController ,UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var vieInsertText: UIView!
    @IBOutlet weak var tfTextInput: UITextField!
    @IBOutlet weak var tbvChat: UITableView!
    @IBOutlet weak var btnAttach: UIButton!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var ctsBottomTextField: NSLayoutConstraint!
    var hideKeyboardTap:UITapGestureRecognizer!
    var messagesArray: [Dictionary<String, String>] = []
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbvChat.delegate = self
        tbvChat.dataSource = self
        tbvChat.estimatedRowHeight = 60
        tbvChat.rowHeight = UITableViewAutomaticDimension
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(willShowKeyBoard(_:)), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(willHideKeyBoard(_:)), name:UIKeyboardWillHideNotification, object: nil)
        hideKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(self.tapScreen))
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.handleMPCReceivedDataWithNotification(_:)), name: "receivedMPCDataNotification", object: nil)
        
        
        btnSend.addTarget(self, action: #selector(self.sendMessage), forControlEvents: .TouchUpInside)
        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(animated: Bool) {
        let messageDictionary: [String: String] = ["message": "_end_chat_"]
        
        if appDelegate.mpcManager.sendData(dictionaryWithData: messageDictionary, toPeer: appDelegate.mpcManager.session.connectedPeers[0] as MCPeerID){
            self.appDelegate.mpcManager.session.disconnect()
        }

        super.viewWillDisappear(animated)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK:-UITableView Datasource + Delegate
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let currentMessage = messagesArray[indexPath.row] as Dictionary<String, String>
        
        if let sender = currentMessage["sender"] {
            
            if sender == "self"{
                let cell = tableView.dequeueReusableCellWithIdentifier("cell1")! as! Cell1
                if let message = currentMessage["message"] {
                    cell.lbMessage.text = message
                }
                return cell

            }
            else{
                let cell = tableView.dequeueReusableCellWithIdentifier("cell2")! as! Cell2
                if let message = currentMessage["message"] {
                    cell.lbMessage.text = message
                }
                return cell
            }
        }
        else{
            let cell = UITableViewCell()
            return cell
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }
    
    //MARK:-UITextField Delegate
    func sendMessage() {
        self.view.endEditing(true)
        
        let messageDictionary: [String: String] = ["message": tfTextInput.text!]
        
        if appDelegate.mpcManager.sendData(dictionaryWithData: messageDictionary, toPeer: appDelegate.mpcManager.session.connectedPeers[0] as MCPeerID){
            
            let dictionary: [String: String] = ["sender": "self", "message": tfTextInput.text!]
            messagesArray.append(dictionary)
            
            self.updateTableview()
        }
        else{
            print("Could not send data")
        }
        
        tfTextInput.text = ""
    }
    
    func tapScreen() {
        self.view.endEditing(true)
        
    }
    
    func handleKeyboardWillShow(duration: NSTimeInterval, keyBoardRect: CGRect) {
        //return
        self.view.addGestureRecognizer(hideKeyboardTap)
        keyBoardChatDetailControl(0, duration: duration, keyBoardRect: keyBoardRect)
    }
    
    func handleKeyboardWillHide(duration: NSTimeInterval, keyBoardRect: CGRect) {
        //return
        self.view.removeGestureRecognizer (hideKeyboardTap)
        keyBoardChatDetailControl(1, duration: duration, keyBoardRect: keyBoardRect)
        
    }
    
    func willShowKeyBoard(notification : NSNotification){
        let userInfo: NSDictionary! = notification.userInfo
        
        var duration : NSTimeInterval = 0
        
        duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
        let keyboardFrame = (userInfo.objectForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue).CGRectValue()
        
        handleKeyboardWillShow(duration,keyBoardRect: keyboardFrame)
    }
    
    func willHideKeyBoard(notification : NSNotification){
        var userInfo: NSDictionary!
        userInfo = notification.userInfo
        
        var duration : NSTimeInterval = 0
        duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
        
        let keyboardFrame = (userInfo.objectForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue).CGRectValue()
        
        handleKeyboardWillHide(duration, keyBoardRect: keyboardFrame)
    }
    
    func keyBoardChatDetailControl(flagKeyboard: Int, duration: NSTimeInterval, keyBoardRect: CGRect) {
        //flagKeyboard == 0 : Keyboard will show.
        //flagKeyboard == 1 : Keyboard will hide.
        
        var keyboardHeight: CGFloat = 0
        keyboardHeight = 0

        // If have tab bar need slash more height of tab bar. Else tabbarHeight = 0
        let tabbarHeight:CGFloat = tabBarController?.tabBar.bounds.size.height ?? 0
        
        if flagKeyboard == 0 {
            keyboardHeight = (keyBoardRect.height - tabbarHeight )
        }
        
        
        UIView.animateWithDuration(duration, animations: {
            self.ctsBottomTextField.constant = keyboardHeight
            
            self.vieInsertText.superview?.layoutIfNeeded()
            
            self.tbvChat.contentInset.bottom = (flagKeyboard == 0) ? keyBoardRect.height + 40  : 40 + tabbarHeight
            
//            if self.messages.count == 0 { return }
//            if flagKeyboard == 0 {
//                
//                let lastIndexPath = NSIndexPath(forRow: self.messages.count - 1, inSection: 0)
//                self.chatTableView.scrollToRowAtIndexPath(lastIndexPath, atScrollPosition: UITableViewScrollPosition.Bottom , animated: false)
//            }
            //self.view.layoutIfNeeded()
        }) { (Bool) in
            
        }
    }
    
    func updateTableview(){
        tbvChat.reloadData()
        
        if self.tbvChat.contentSize.height > self.tbvChat.frame.size.height {
            tbvChat.scrollToRowAtIndexPath(NSIndexPath(forRow: messagesArray.count - 1, inSection: 0), atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
        }
    }
    
    func handleMPCReceivedDataWithNotification(notification: NSNotification) {
        // Get the dictionary containing the data and the source peer from the notification.
        let receivedDataDictionary = notification.object as! Dictionary<String, AnyObject>
        
        // "Extract" the data and the source peer from the received dictionary.
        let data = receivedDataDictionary["data"] as? NSData
        let fromPeer = receivedDataDictionary["fromPeer"] as! MCPeerID
        
        // Convert the data (NSData) into a Dictionary object.
        let dataDictionary = NSKeyedUnarchiver.unarchiveObjectWithData(data!) as! Dictionary<String, String>
        
        // Check if there's an entry with the "message" key.
        if let message = dataDictionary["message"] {
            // Make sure that the message is other than "_end_chat_".
            if message != "_end_chat_"{
                /// Create a new dictionary and set the sender and the received message to it.
                let messageDictionary: [String: String] = ["sender": fromPeer.displayName, "message": message]
                
                /// Add this dictionary to the messagesArray array.
                messagesArray.append(messageDictionary)
                
                /// Reload the tableview data and scroll to the bottom using the main thread.
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.updateTableview()
                })
            }
            else{
                // In this case an "_end_chat_" message was received.
                // Show an alert view to the user.
                let alert = UIAlertController(title: "", message: "\(fromPeer.displayName) ended this chat.", preferredStyle: UIAlertControllerStyle.Alert)
                
                let doneAction: UIAlertAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
                    self.appDelegate.mpcManager.session.disconnect()
                    self.navigationController?.popViewControllerAnimated(true)
                }
                
                alert.addAction(doneAction)
                
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.presentViewController(alert, animated: true, completion: nil)
                })
            }
        }
    }

    
}
