//
//  ViewController.swift
//  Project28
//
//  Created by Yury Popov on 20/08/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    @IBOutlet weak var secret: UITextView!
    
    var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Nothing to see here"
        
        doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(saveSecretMessage))
        self.navigationItem.rightBarButtonItem = nil
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(saveSecretMessage), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    @IBAction func registerAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Register", message: "Check in", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            let emailField = alert.textFields![0]
            let passwordField = alert.textFields![1]
            //save to keychain
            guard !emailField.text!.isEmpty, !passwordField.text!.isEmpty else { return }
            KeychainWrapper.standard.set(emailField.text!, forKey: "Login")
            KeychainWrapper.standard.set(passwordField.text!, forKey: "Password")
            
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
    

    @IBAction func authenticateTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Login", message: nil, preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "In", style: .default) { [weak self] action in
            let loginField = alert.textFields![0]
            let passwordField = alert.textFields![1]
            //load from keychain
            guard !loginField.text!.isEmpty, !passwordField.text!.isEmpty else { return }
            
            if (KeychainWrapper.standard.string(forKey: "Login") == loginField.text) && (KeychainWrapper.standard.string(forKey: "Password") == passwordField.text) {
                self?.authBiometric()
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
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            secret.contentInset = .zero
        } else {
            secret.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        secret.scrollIndicatorInsets = secret.contentInset
        
        let selectedRange = secret.selectedRange
        secret.scrollRangeToVisible(selectedRange)
    }
    
    func unlockSecretMessage() {
        secret.isHidden = false
        title = "Secret stuff!"
        
        secret.text = KeychainWrapper.standard.string(forKey: "SecretMessage") ?? ""
    }
    
    @objc func saveSecretMessage() {
        guard secret.isHidden == false else { return }
        
        KeychainWrapper.standard.set(secret.text, forKey: "SecretMessage")
        secret.resignFirstResponder()
        secret.isHidden = true
        self.navigationItem.rightBarButtonItem = nil
        title = "Nothing to see here"
    }
    
    func authBiometric() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        self?.unlockSecretMessage()
                        self?.navigationItem.rightBarButtonItem = self?.doneButton
                    } else {
                        // error
                        let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self?.present(ac, animated: true)
                    }
                }
            }
        } else {
            // no biometry
            let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
}

