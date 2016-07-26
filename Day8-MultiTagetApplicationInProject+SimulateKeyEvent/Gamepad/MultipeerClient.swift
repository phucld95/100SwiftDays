//
//  MultipeerClient.swift
//  DeckRocket
//
//  Created by JP Simard on 6/13/14.
//  Copyright (c) 2014 JP Simard. All rights reserved.
//

import Foundation
import MultipeerConnectivity


protocol MCProtocol {
    func didReceivedData (data: NSData)
}

typealias stateChange = ((state: MCSessionState, fromPeer: MCPeerID?) -> ())?

final class MultipeerClient: NSObject, MCNearbyServiceAdvertiserDelegate, MCSessionDelegate {

    // MARK: Properties

    private let localPeerID = MCPeerID(displayName: NSHost.currentHost().localizedName!)
    private var advertiser: MCNearbyServiceAdvertiser?
    private var session: MCSession?
    private var pdfProgress: NSProgress?
    var onStateChange: stateChange?
    private let serviceName = "lephucDemoApp"
    var delegate: MCProtocol?
    
    // MARK: Lifecycle

    override init() {
        advertiser = MCNearbyServiceAdvertiser(peer: localPeerID, discoveryInfo: nil,
                                               serviceType: serviceName)
        super.init()
        advertiser?.delegate = self
        advertiser?.startAdvertisingPeer()
    }
    
    // MARK: MCNearbyServiceAdvertiserDelegate
    // (Public my advertiser.)
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer
                    peerID: MCPeerID, withContext context: NSData?,
                    invitationHandler: (Bool, MCSession) -> Void) {
        session = MCSession(peer: localPeerID, securityIdentity: nil,
                            encryptionPreference: .Required)
        guard let session = session else { return }
        session.delegate = self
        invitationHandler(true, session)
    }

    // MARK: MCSessionDelegate

    func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        onStateChange??(state: state, fromPeer: peerID)
    }

    func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
        // Did receive data from iOS.
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
