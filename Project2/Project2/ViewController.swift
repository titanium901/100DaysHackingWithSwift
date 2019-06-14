//
//  ViewController.swift
//  Project2
//
//  Created by Yury Popov on 14/06/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var scoreButton: UIBarButtonItem!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var askedQuestion = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        setupUI()
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased()
    }
    
    func setupUI() {
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    func restartGame(action: UIAlertAction! = nil) {
        askedQuestion = 0
        score = 0
        scoreButton.title = "Score: 0"
    }
    
    func chekQuestion(title: String) {
        if askedQuestion == 10 {
            let ac = UIAlertController(title: title, message: "That was the last question. Your score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Restart", style: .default, handler: restartGame))
            present(ac, animated: true)
            askQuestion()
        } else {
            let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        askedQuestion += 1
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            chekQuestion(title: title)
        } else {
            title = "Wrong! That’s the flag of \(countries[sender.tag].uppercased())"
            score -= 1
            chekQuestion(title: title)
        }
        scoreButton.title = "Score: \(score)"
        
        
        
        
    }
    
}



