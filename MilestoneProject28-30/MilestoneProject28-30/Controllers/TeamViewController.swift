//
//  TeamViewController.swift
//  MilestoneProject28-30
//
//  Created by Yury Popov on 22/08/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//

import UIKit

class TeamViewController: UIViewController {
    @IBOutlet weak var lokoButton: UIButton!
    @IBOutlet weak var krasnButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lokoButton.layer.borderWidth = 2
        krasnButton.layer.borderWidth = 2
        lokoButton.layer.borderColor = UIColor.black.cgColor
        krasnButton.layer.borderColor = UIColor.black.cgColor
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let gameVC = segue.destination as! GameFieldViewController
        if segue.identifier == "lokoSeque" {
            gameVC.titleText = "FC Lokomotiv"
        } else {
            gameVC.titleText = "FC Krasnodar"
            
        }
    }
    
    
    @IBAction func lokoButton(_ sender: UIButton) {
    }
    
    @IBAction func krasnButton(_ sender: UIButton) {
    }
    
    @IBAction func exitButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
