//
//  RegisterViewController.swift
//  MilestoneProject28-30
//
//  Created by Yury Popov on 22/08/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//

import UIKit
import LocalAuthentication

class RegisterViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        guard !usernameField.text!.isEmpty, !passwordField.text!.isEmpty else {
            errorRegisterAlert()
            return
        }
        
        let userName = usernameField!.text
        let password = passwordField!.text
        KeychainWrapper.standard.set(userName!, forKey: "Login")
        KeychainWrapper.standard.set(password!, forKey: "Password")
        
        succesRegistation()
        
    }
    @IBAction func exitAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func errorRegisterAlert() {
        let ac = UIAlertController(title: "Oops", message: "Something went wrong, check the fields", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    func succesRegistation() {
        let ac = UIAlertController(title: "Congrats!", message: "Registration completed successfully!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }))
        present(ac, animated: true)
        
        usernameField.text = nil
        passwordField.text = nil
    }
    

}
