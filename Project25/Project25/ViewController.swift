//
//  ViewController.swift
//  Project25
//
//  Created by Yury Popov on 25/07/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ViewController: UICollectionViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, MCSessionDelegate, MCBrowserViewControllerDelegate {

    var images = [UIImage]()
    var message = ""
    
    var peerID = MCPeerID(displayName: UIDevice.current.name)
    var mcSession: MCSession?
    var mcAdvertiserAssistant: MCAdvertiserAssistant?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Selfie Share"
        let cameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(importPicture))
        let hostButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showConnectionPrompt))
        let namesButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(namesOfConnection))
        let messageButton = UIBarButtonItem(title: "Text", style: .plain, target: self, action: #selector(sendMessage))
        navigationItem.rightBarButtonItems = [cameraButton, namesButton]
        navigationItem.leftBarButtonItems = [hostButton, messageButton]
        
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        mcSession?.delegate = self
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageView", for: indexPath)
        
        if let imageView = cell.viewWithTag(1000) as? UIImageView {
            imageView.image = images[indexPath.item]
        }
        
        return cell
    }
    
    func startHosting(action: UIAlertAction) {
        guard let mcSession = mcSession else { return }
        mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "hws-project25", discoveryInfo: nil, session: mcSession)
        mcAdvertiserAssistant?.start()
    }
    
    func joinSession(action: UIAlertAction) {
        guard let mcSession = mcSession else { return }
        let mcBrowser = MCBrowserViewController(serviceType: "hws-project25", session: mcSession)
        mcBrowser.delegate = self
        present(mcBrowser, animated: true)
    }
    
    @objc func sendMessage() {
        let ac = UIAlertController(title: "Send Message", message: nil, preferredStyle: .alert)
        ac.addTextField { (textField) in
            textField.placeholder = "Your Message"
        }
        let send = UIAlertAction(title: "Send", style: .default) { (_) in
            //send message
            guard let text = ac.textFields?[0].text else { return }
            self.message = text
            self.sendTextToPears(message: text)
            
            
        }
        ac.addAction(send)
        ac.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
    func sendTextToPears(message: String) {
        guard let mcSession = mcSession else { return }
        let data = Data(message.utf8)
        // 2
        if mcSession.connectedPeers.count > 0 {
            
            if message != "" {
                do {
                    print(#function)
                    print("----")
                    print(message)
                    try mcSession.send(data, toPeers: mcSession.connectedPeers, with: .reliable)
                } catch {
                    // 5
                    let ac = UIAlertController(title: "Send error", message: error.localizedDescription, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    present(ac, animated: true)
                }
            }
            
        }
    }
    
    @objc func namesOfConnection() {
        guard let mcSession = mcSession else { return }
        let connection = mcSession.connectedPeers.description
        let ac = UIAlertController(title: "connectedPeers", message: connection, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
    @objc func showConnectionPrompt() {
        let ac = UIAlertController(title: "Connect to others", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Host a session", style: .default, handler: startHosting))
        ac.addAction(UIAlertAction(title: "Join a session", style: .default, handler: joinSession))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        dismiss(animated: true)
        
        images.insert(image, at: 0)
        collectionView.reloadData()
        
        //The final piece of code to finish up this whole project is the bit that sends image data to peers.
        /*
         This final code needs to:
 
         Check if we have an active session we can use.
         Check if there are any peers to send to.
         Convert the new image to a Data object.
         Send it to all peers, ensuring it gets delivered.
         Show an error message if there's a problem.
         Converting that into code, you get the below. Put this into your didFinishPickingMediaWithInfo method, just after the call to reloadData():
         */
        
        // 1
        guard let mcSession = mcSession else { return }
        
        // 2
        if mcSession.connectedPeers.count > 0 {
            // 3
            if let imageData = image.pngData() {
                // 4
                do {
                    try mcSession.send(imageData, toPeers: mcSession.connectedPeers, with: .reliable)
                } catch {
                    // 5
                    let ac = UIAlertController(title: "Send error", message: error.localizedDescription, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    present(ac, animated: true)
                }
            }
        }
        
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            print("Connected: \(peerID.displayName)")
            
        case .connecting:
            print("Connecting: \(peerID.displayName)")
            
        case .notConnected:
            disconnectAlert(peerId: peerID)
            print("Not Connected: \(peerID.displayName)")
            
        @unknown default:
            print("Unknown state received: \(peerID.displayName)")
        }
    }
    
    func disconnectAlert(peerId: MCPeerID) {
        let ac = UIAlertController(title: "User has disconnected:", message: peerId.displayName, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
    /*
    Once the data arrives at each peer, the method session(_:didReceive:fromPeer:) will get called with that data, at which point we can create a UIImage from it and add it to our images array. There is one catch: when you receive data it might not be on the main thread, and you never manipulate user interfaces anywhere but the main thread, right? Right.
    
    Here's the final protocol method, to catch data being received in our session:
    */
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        DispatchQueue.main.async { [weak self] in
            var strData = String(decoding: data, as: UTF8.self)
            if let image = UIImage(data: data) {
                
                self?.images.insert(image, at: 0)
                strData = ""
                self?.collectionView.reloadData()
                
            }
            
            
            if strData != "" {
                let ac = UIAlertController(title: "Message", message: strData, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self?.present(ac, animated: true)
            }
            print(#function)
            print(strData)
            
        }
    }
}

