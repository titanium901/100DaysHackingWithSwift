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
    
    var englishAlphabet = ["а", "б", "в", "г", "д", "е", "ё", "ж", "з", "и", "й", "к", "л", "м", "н", "о", "п", "р", "с", "т", "у", "ф", "х", "ц", "ч", "ш", "щ", "ь", "ы", "э", "ю", "я", "ъ"]
    
  //  var englishAlphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
//    var words = ["Awkward", "Bagpipes", "Banjo", "Bungler", "Croquet", "Crypt", "Dwarves", "Fervid"]
    var words = ["ежедневник", "календарь", "леопард", "сауна", "издательство", "переводчик", "ириска", "логика", "тхэквондо", "Фантастика", "радар", "акция", "овощи", "банан", "абонемент", "тир", "Пират", "Автомобиль", "Торт"]
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
        print(englishButtons.count, englishAlphabet.count)
        textField.isUserInteractionEnabled = false
        setWord()
        
        stepsLabel.text = "\(stepsToDeath)"
        print(#function, textArFinal)
        print(englishAlphabet.count)

    }

    
    func setButtonTitle() {
        englishAlphabet.shuffle()
        var index = 0
        for button in englishButtons {
            button.setTitle(englishAlphabet[index].uppercased(), for: .normal)
            button.isHidden = false
            button.isEnabled = true
            button.alpha = 1
            button.setTitleColor(.red, for: .disabled)
            index += 1
            button.center.y = 25
            
            
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
        let ac = UIAlertController(title: "Game Over", message: "It was \(currentWord.uppercased())", preferredStyle: .alert)
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
        let buttonTitle = (sender.titleLabel?.text)!.lowercased()
        if !currentArr.contains(buttonTitle) {
            //код для вешания
            if stepsToDeath == 1 {
                gameOver()
            }
            sender.isEnabled = false
            
            sender.titleLabel?.textColor = .red
            let animator = UIViewPropertyAnimator(duration: 1, curve: .easeInOut) {
                sender.center.y -= 10
                
            }
            animator.startAnimation()
            sender.desapere()
            
            
            print(#function)
            stepsToDeath -= 1
            imageView.image = UIImage(named: "hang\(stepsToDeath)")
            
        }
        for (index, value) in currentWord.enumerated() {
            if String(value) == buttonTitle {
                print(index, value)
                hidenArr[index] = String(value)
                textArFinal[index] = String(value)
                sender.isEnabled = false
                sender.setTitleColor(.black, for: .disabled)
                let animator = UIViewPropertyAnimator(duration: 1, curve: .linear) {
                    sender.center.y += 100
                    sender.alpha -= 1
                }
                animator.startAnimation()
                
                
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

extension UIButton {
    
    func desapere() {
        let desapere = CASpringAnimation(keyPath: "transform.scale")
        desapere.duration = 0.6
        desapere.fromValue = 0.95
        desapere.toValue = 1
        desapere.autoreverses = true
        desapere.repeatCount = 2
        desapere.initialVelocity = 0.5
        desapere.damping = 1
        
        layer.add(desapere, forKey: nil)
    }
}



