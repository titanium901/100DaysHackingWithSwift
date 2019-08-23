//
//  GameFieldViewController.swift
//  MilestoneProject28-30
//
//  Created by Yury Popov on 22/08/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//

import UIKit
import AVFoundation

class GameFieldViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstStackView: UIStackView!
    @IBOutlet weak var hitLabel: UILabel!
    
    var titleText: String!
    var cardFlipSound: AVAudioPlayer?
    var names = [String]()
    var cards = [Card]()
    var buttonTag = 0
    var cardFlipped = 0
    var cardOneMatch: Card!
    var cardTwoMatch: Card!
    var selectedCards = [Int]()
    var buttons = [UIButton]()
    var teamImage = ""
    var score = 0
    var tappedCount = 0 {
        didSet {
            hitLabel.text = "Hit: \(tappedCount)"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hitLabel.text = "Hit: 0"
        titleLabel.text = titleText
        
        if titleText == "FC Krasnodar" {
            names = ["safonov", "ari", "gas", "ignatiev", "kambolov", "klassen", "martinovich", "olsen", "ramires", "remi", "shapi", "stockiy", "tonny", "vanderson"]
            teamImage = "kran"
            setupBtn()
            
        } else {
            names = ["marinato", "boris", "brat", "charli", "farfan", "ghegok", "benya", "brat2", "eder", "fedor", "idovu", "murilo", "semin", "loc"]
            teamImage = "loko"
            setupBtn()
        }
        
        
        
        cards = Card.createCards(names: names.shuffled())
    }
    
    func setupBtn() {
        for case let stack as UIStackView in view.subviews {
            for case let miniStack as UIStackView in stack.arrangedSubviews {
                for case let btn as UIButton in miniStack.arrangedSubviews {
                    btn.layer.borderWidth = 2
                    btn.layer.borderColor = UIColor.black.cgColor
                    btn.tag = buttonTag
                    buttons.append(btn)
                    buttonTag += 1
                    btn.setImage(UIImage(named: teamImage), for: .normal)
                    
                }
            }
        }
    }
    
    
    @IBAction func cardTapped(_ sender: UIButton) {
        if cardFlipped == 0 {
            selectedCards.append(sender.tag)
        } else if cardFlipped == 1 {
            selectedCards.append(sender.tag)
            tappedCount += 1
        }
        
        if let path = Bundle.main.path(forResource: "cardflip", ofType: "wav") {
            let url = URL(fileURLWithPath: path)
            do {
                cardFlipSound = try AVAudioPlayer(contentsOf: url)
                cardFlipSound?.play()
            } catch  {
                print(error.localizedDescription)
            }
        }
        
        let name = cards[sender.tag].name
        let image = UIImage(named: name)
        sender.setImage(image, for: .normal)
//        sender.isUserInteractionEnabled = false
        UIView.transition(with: sender, duration: 0.4, options: .transitionFlipFromRight, animations: nil, completion: nil)
        cardFlipped += 1
        print(selectedCards)
        print("card flipped")
        print(cardFlipped)
        
        guard selectedCards.count == 2 else { return }
        checkMatch()
        
        
        
        
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func checkMatch() {
        let cardOne = cards[selectedCards[0]]
        let cardTwo = cards[selectedCards[1]]
        
        if cardOne.name == cardTwo.name {
            // match
            score += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.buttons[(self?.selectedCards[0])!].isEnabled = true
                self?.buttons[(self?.selectedCards[1])!].isEnabled = true
                self?.buttons[(self?.selectedCards[0])!].alpha = 0
                self?.buttons[(self?.selectedCards[1])!].alpha = 0
                self?.cardFlipped = 0
                self?.selectedCards.removeAll()
                self?.playFlipSound()
            }
            if score == 6 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.gameOver()
                }
                
            }
            
        } else {
            //not match
            print("not")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let btn = self.buttons[self.selectedCards[0]]
                let btnTwo = self.buttons[self.selectedCards[1]]
                
                let image = UIImage(named: self.teamImage)
                btn.setImage(image, for: .normal)
                btnTwo.setImage(image, for: .normal)
                UIView.transition(with: btn, duration: 0.4, options: .transitionFlipFromLeft, animations: nil, completion: nil)
                UIView.transition(with: btnTwo, duration: 0.4, options: .transitionFlipFromLeft, animations: nil, completion: nil)
                
                self.playFlipSound()
                
                self.cardFlipped = 0
                self.selectedCards.removeAll()
            }
        }
    }
    
    func playFlipSound() {
        if let path = Bundle.main.path(forResource: "cardflip", ofType: "wav") {
            let url = URL(fileURLWithPath: path)
            do {
                self.cardFlipSound = try AVAudioPlayer(contentsOf: url)
                self.cardFlipSound?.play()
            } catch  {
                print(error.localizedDescription)
            }
        }
    }
    
    func gameOver() {
        let ac = UIAlertController(title: "Game Over", message: "You tapped \(tappedCount) times", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
            self.dismiss(animated: true, completion: nil)
        }))
        present(ac, animated: true)
    }
    
}
