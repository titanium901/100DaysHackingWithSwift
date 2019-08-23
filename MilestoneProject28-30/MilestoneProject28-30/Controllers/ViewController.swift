//
//  ViewController.swift
//  MilestoneProject28-30
//
//  Created by Yury Popov on 22/08/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    @IBOutlet weak var touchIDButton: UIButton!
    
    let laContext = LAContext()
    let biometricsPolicy = LAPolicy.deviceOwnerAuthenticationWithBiometrics

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func enterAction(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Login", message: nil, preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "In", style: .default) { [weak self] action in
            let loginField = alert.textFields![0]
            let passwordField = alert.textFields![1]
            //load from keychain
            guard !loginField.text!.isEmpty, !passwordField.text!.isEmpty else { return }
            if (KeychainWrapper.standard.string(forKey: "Login") == loginField.text) && (KeychainWrapper.standard.string(forKey: "Password") == passwordField.text) {
                self?.performSegue(withIdentifier: "ToGame", sender: nil)
            } else {
                let ac  = UIAlertController(title: "Wrong", message: "Password or Login not match", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Ok", style: .default))
                self?.present(ac, animated: true)
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your login"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func biometryAction(_ sender: UIButton) {
        var error: NSError?
        if (laContext.canEvaluatePolicy(biometricsPolicy, error: &error)) {
            
            if let laError = error {
                print("laError - \(laError)")
                return
            }
            
            var localizedReason = "Unlock device"
            if #available(iOS 11.0, *) {
                switch laContext.biometryType {
                case .faceID: localizedReason = "Unlock using Face ID"; print("FaceId support")
                case .touchID: localizedReason = "Unlock using Touch ID"; print("TouchId support")
                case .none: print("No Biometric support")
                @unknown default:
                    fatalError()
                }
            } else {
                // Fallback on earlier versions
            }
            
            laContext.evaluatePolicy(biometricsPolicy, localizedReason: localizedReason, reply: { (isSuccess, error) in
                
                DispatchQueue.main.async(execute: {
                    
                    if let laError = error {
                        print("laError - \(laError)")
                    } else {
                        if isSuccess {
                            print("sucess")
                            self.performSegue(withIdentifier: "ToGame", sender: nil)
                        } else {
                            print("failure")
                            
                        }
                    }
                    
                })
            })
        }
    }
    
}

