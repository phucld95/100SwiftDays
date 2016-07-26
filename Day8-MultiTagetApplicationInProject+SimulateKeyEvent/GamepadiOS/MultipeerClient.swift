//
//  MultipeerClient.swift
//  DeckRocket
//
//  Created by JP Simard on 6/14/14.
//  Copyright (c) 2014 JP Simard. All rights reserved.
//

import Foundation
import MultipeerConnectivity

typealias stateChange = ((state: MCSessionState, peerID: MCPeerID) -> ())?


protocol MCProtocol {
    func didReceivedData (data: NSData)
    
    func sendData()
}


final class MultipeerClient: NSObject, MCNearbyServiceBrowserDelegate, MCSessionDelegate {

    // MARK: Properties

    private let localPeerID = MCPeerID(displayName: UIDevice.currentDevice().name)
    let browser: MCNearbyServiceBrowser?
    private(set) var session: MCSession?
    private(set) var state = MCSessionState.NotConnected
    var onStateChange: stateChange?
    private let serviceName = "lephucDemoApp"
    var delegate: MCProtocol?
    
    
    // MARK: Init

    override init() {
        browser = MCNearbyServiceBrowser(peer: localPeerID, serviceType: serviceName)
        super.init()
        browser?.delegate = self
        browser?.startBrowsingForPeers()
    }

    // MARK: MCNearbyServiceBrowserDelegate

    func browser(browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo
                 info: [String : String]?) {
        if session == nil {
            session = MCSession(peer: localPeerID)
            session?.delegate = self
        }
        browser.invitePeer(peerID, toSession: session!, withContext: nil, timeout: 30)
    }

    func browser(browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {

    }

    // MARK: MCSessionDelegate

    func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        self.state = state
        onStateChange??(state: state, peerID: peerID)
    }

    func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
        delegate?.didReceivedData(data)
    }

    func session(session: MCSession, didReceiveStream stream: NSInputStream,
                 withName streamName: String, fromPeer peerID: MCPeerID) {
    }

    func session(session: MCSession, didStartReceivingResourceWithName resourceName: String,
                 fromPeer peerID: MCPeerID, withProgress progress: NSProgress) {
    }

    func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String,
                 fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) {
    }
}
