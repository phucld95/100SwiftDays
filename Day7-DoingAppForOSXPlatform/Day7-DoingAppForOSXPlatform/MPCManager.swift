//
//  MPCManager.swift
//  Day5-DoingWithMultipeerConnectivityFramework
//
//  Created by Le Phuc on 6/22/16.
//  Copyright © 2016 Lê Phúc. All rights reserved.
//

import Cocoa
import MultipeerConnectivity


protocol MPCManagerDelegate {
    func foundPeer()
    
    func lostPeer()
    
    func invitationWasReceived(fromPeer: String)
    
    func connectedWithPeer(peerID: MCPeerID)
    
    func connectFalse(peerID: MCPeerID)
}

class MPCManager: NSObject, MCSessionDelegate, MCNearbyServiceBrowserDelegate, MCNearbyServiceAdvertiserDelegate {
    var delegate: MPCManagerDelegate?
    
    var session: MCSession!
    
    var peer: MCPeerID!
    
    var browser: MCNearbyServiceBrowser!
    
    var advertiser: MCNearbyServiceAdvertiser!
    
    
    // List store all the peers that the browser of a device will discover.
    var foundPeers = [MCPeerID]()
    
    // Clousues completion handler declaration
    var invitationHandler: ((Bool, MCSession)->Void)!
    
    
    override init() {
        super.init()
        
        peer = MCPeerID(displayName: NSHost.currentHost().localizedName!)
        //[[NSHost currentHost] localizedName]
        session = MCSession(peer: peer)
        session.delegate = self
        
        browser = MCNearbyServiceBrowser(peer: peer, serviceType: "lephuc123")
        browser.delegate = self
        
        advertiser = MCNearbyServiceAdvertiser(peer: peer, discoveryInfo: nil, serviceType: "lephuc123")
        advertiser.delegate = self
    }
    
    
    // MARK: MCNearbyServiceBrowserDelegate method implementation
    
    
    func browser(browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        for (index, peer) in foundPeers.enumerate() {
            if peer.displayName == peerID.displayName {
                foundPeers.removeAtIndex(index)
            }
        }
        
        foundPeers.append(peerID)
        
        delegate?.foundPeer()
    }
    
    // When a peer stop working. This function will be called. peerID have name of peer stoped.
    func browser(browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        for (index, aPeer) in foundPeers.enumerate(){
            if aPeer == peerID {
                foundPeers.removeAtIndex(index)
                break
            }
        }
        
        delegate?.lostPeer()
    }
    
    
    func browser(browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: NSError) {
        print(error.localizedDescription)
    }
    
    
    // MARK: MCNearbyServiceAdvertiserDelegate method implementation
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: NSData?, invitationHandler: (Bool, MCSession) -> Void){
        self.invitationHandler = invitationHandler
        delegate?.invitationWasReceived(peerID.displayName)
    }

    
    func advertiser(advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: NSError) {
        print(error.localizedDescription)
    }
    
    
    // MARK: MCSessionDelegate method implementation
    
    func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        switch state{
        case MCSessionState.Connected:
            print("Connected to session: \(session)")
            delegate?.connectedWithPeer(peerID)
            
        case MCSessionState.Connecting:
            print("Connecting to session: \(session)")
            
        default:
            delegate?.connectFalse(peerID)
            print("Did not connect to session: \(session)")
            print("Rival not accept!")
        }
    }
    
    
    func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
        let dictionary: [String: AnyObject] = ["data": data, "fromPeer": peerID]
        NSNotificationCenter.defaultCenter().postNotificationName("receivedMPCDataNotification", object: dictionary)
    }
    
    
    func session(session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, withProgress progress: NSProgress) { }
    
    func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) { }
    
    func session(session: MCSession, didReceiveStream stream: NSInputStream, withName streamName: String, fromPeer peerID: MCPeerID) { }
    
    
    
    // MARK: Custom method implementation
    
    func sendData(dictionaryWithData dictionary: Dictionary<String, String>, toPeer targetPeer: MCPeerID) -> Bool {
        let dataToSend = NSKeyedArchiver.archivedDataWithRootObject(dictionary)
        let peersArray = NSArray(object: targetPeer)
       
        do {
            try session.sendData(dataToSend, toPeers: peersArray as! [MCPeerID], withMode: MCSessionSendDataMode.Reliable)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        
        
        
        return true
    }

}
