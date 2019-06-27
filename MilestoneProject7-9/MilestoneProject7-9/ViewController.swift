//
//  ViewController.swift
//  MilestoneProject7-9
//
//  Created by Yury Popov on 26/06/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var englishButtons: [UIButton]!
    @IBOutlet var stepsLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var textField: UITextField!
    
    var englishAlphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    var words = ["Awkward", "Bagpipes", "Banjo", "Bungler", "Croquet", "Crypt", "Dwarves", "Fervid"]
    var currentWord = ""
    var hidenWord = ""
    var textArFinal = [String]()
    var hidenArr = [String]()
    var currentArr = [String]()
    var score = 0 {
        didSet {
            scoreLabel.text = "\(score)"
        }
    }
    var stepsToDeath = 11 {
        didSet {
            stepsLabel.text = "\(stepsToDeath)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.isUserInteractionEnabled = false
        setWord()
        
        stepsLabel.text = "\(stepsToDeath)"
        print(#function, textArFinal)
        

    }

    
    func setButtonTitle() {
        englishAlphabet.shuffle()
        var index = 0
        for button in englishButtons {
            button.setTitle(englishAlphabet[index], for: .normal)
            button.isHidden = false
            index += 1
        }
    }
    
    func setWord() {
        
        hidenArr = []
        currentArr = []
        setButtonTitle()
        print(#function)
        words.shuffle()
        print(words)
        currentWord = words[0].lowercased()
        for _ in currentWord {
            hidenWord += "?"
        }
        textField.text = hidenWord
        textArFinal = Array(repeating: "?", count: currentWord.count)
        print(#function, textArFinal)
    }
    
    func gameOver() {
        let ac = UIAlertController(title: "Game Over", message: nil, preferredStyle: .alert)
        let restart = UIAlertAction(title: "Restart", style: .cancel) { _ in
            self.restartGame()
        }
        ac.addAction(restart)
        present(ac, animated: true)
    }
    
    @objc func restartGame() {
        print("restart")
        hidenWord = ""
        currentWord = ""
        hidenArr = []
        setWord()
        stepsToDeath = 11
        imageView.image = UIImage(named: "hang\(stepsToDeath)")
        print(currentWord)
    }
    
    func guesWord() {
        score += 1
        let ac = UIAlertController(title: "Win!", message: "You guessed! Hooray!!!", preferredStyle: .alert)
        let nextButton = UIAlertAction(title: "Next", style: .cancel) { _ in
            self.nextLevel()
        }
        ac.addAction(nextButton)
        present(ac, animated: true)
        textArFinal.removeAll()
        textArFinal = Array(repeating: "?", count: currentWord.count)
    }
    
    @objc func nextLevel() {
        restartGame()
    }
    
    
    @IBAction func buttonTappde(_ sender: UIButton) {
        
        //создаю пустой массив из где количесвто элементов равно слову разбитому и заменены на ?
        
        for hideWord in hidenWord {
            hidenArr.append(String(hideWord))
        }
        //создаю массив букв из текущего слова
        
        for word in currentWord {
            currentArr.append(String(word))
        }
        let buttonTitle = (sender.titleLabel?.text)!
        if !currentArr.contains(buttonTitle) {
            //код для вешания
            if stepsToDeath == 1 {
                gameOver()
            }
            stepsToDeath -= 1
            imageView.image = UIImage(named: "hang\(stepsToDeath)")
            
        }
        for (index, value) in currentWord.enumerated() {
            if String(value) == buttonTitle {
                print(index, value)
                hidenArr[index] = String(value)
                textArFinal[index] = String(value)
                sender.isHidden = true
                
            }
        }
        
        
        
        print(currentArr)
        print(currentWord)
        print("hidenArr")
        print(hidenArr)
        print("Final")
        print(textArFinal)
        let answer = textArFinal.joined(separator: "")
        textField.text = answer
        //следущее слово
        if currentWord == answer {
            guesWord()
            
        }
    }
}

