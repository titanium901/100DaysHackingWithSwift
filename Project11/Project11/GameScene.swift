//
//  GameScene.swift
//  Project11
//
//  Created by Yury Popov on 28/06/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//

import SpriteKit
import UIKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var scoreLabel: SKLabelNode!
    var ballsLabel: SKLabelNode!
    var infoLabel: SKLabelNode!
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var limit = 5 {
        didSet{
            ballsLabel.text = "Balls limit: \(limit)"
        }
    }
    
    var editLabel: SKLabelNode!
    
    var editingMode: Bool = true {
        didSet {
            if editingMode {
                editLabel.text = "Done"
            } else {
                editLabel.text = "Edit"
            }
        }
    }
    
    
    
    override func didMove(to view: SKView) {
        print(#function)
        let background = SKSpriteNode(imageNamed: "background.jpg")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame) // края экрана чувствуют другие объекты
        
        physicsWorld.contactDelegate = self
        
       
        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: 256, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 768, y: 0))
        makeBouncer(at: CGPoint(x: 1024, y: 0))
        
        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)
        
        ballsLabel = SKLabelNode(fontNamed: "Chalkduster")
        ballsLabel.text = "Balls limit: 5"
        ballsLabel.horizontalAlignmentMode = .right
        ballsLabel.position = CGPoint(x: 980, y: 660)
        addChild(ballsLabel)
        
        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Done"
        editLabel.position = CGPoint(x: 80, y: 700)
        addChild(editLabel)
        
        infoLabel = SKLabelNode(fontNamed: "Chalkduster")
        infoLabel.text = "How to Play?"
        infoLabel.position = CGPoint(x: 130, y: 630)
        addChild(infoLabel)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            let location = touch.location(in: self)
            var locationBall = touch.location(in: self)
            locationBall.y = 700
            let objects = nodes(at: location)
            
            if objects.contains(editLabel) {
                editingMode.toggle()
            } else if objects.contains(infoLabel) {
                showWelcomeAlert()
            } else {
                if editingMode {
                    makeBox(at: location)
                } else {
                    // rest of ball code
                    let ball = SKSpriteNode(imageNamed: "\(randomBall())")
                    ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
                    ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask // The contactTestBitMask bitmask means "which collisions do you want to know about?" and by default it's set to nothing. So by setting contactTestBitMask to the value of collisionBitMask we're saying, "tell me about every collision."
                    ball.physicsBody?.restitution = 0.4 // от 0 до 1 сила отскока
                    ball.position = locationBall
                    ball.name = "ball"
                    addChild(ball)
                }
                
            }
          
        }
    }
    
    func makeBox(at location: CGPoint) {
        let size = CGSize(width: Int.random(in: 16...128), height: 16)
        let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
        box.zRotation = CGFloat.random(in: 0...3)
        box.position = location
        
        box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
        box.physicsBody?.isDynamic = false
        box.name = "box"
        
        addChild(box)
    }
    
    func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
        bouncer.physicsBody?.isDynamic = false
        addChild(bouncer)
    }
    
    func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
        }
        
        slotBase.position = position
        slotGlow.position = position
        
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false //что бы объект не двигался при контакте
        
        addChild(slotBase)
        addChild(slotGlow)
        
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }
    
    func collisionBetween(ball: SKNode, object: SKNode) {
        if object.name == "good" {
            destroy(ball: ball)
            score += 1
            limit += 1
        } else if object.name == "bad" {
            destroy(ball: ball)
            score -= 1
            limit -= 1
            gameOver()
        } else if object.name == "box" {
            destroy(box: object)
        }
    }
    func destroy(box: SKNode) {
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticlesTwo") {
            fireParticles.position = box.position
            addChild(fireParticles)
        }
        box.removeFromParent()
    }
    
    func destroy(ball: SKNode) {
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = ball.position
            addChild(fireParticles)
        }

        ball.removeFromParent()
        
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA.name == "ball" {
            collisionBetween(ball: nodeA, object: nodeB)
        } else if nodeB.name == "ball" {
            collisionBetween(ball: nodeB, object: nodeA)
        }
        
    }
    
    func randomBall() -> String {
        let ballNames = ["ballBlue","ballCyan","ballGreen","ballGrey","ballPurple","ballRed","ballYellow",]
        let indexRandom = Int.random(in: 0..<ballNames.count)
        
        return ballNames[indexRandom]
    }
    
    func gameOver() {
        if limit < 1 {
            print("Lose")
            let ac = UIAlertController(title: "You Lose", message: "Please don`t cry", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default) { _ in
                self.newGame()
            }
            ac.addAction(ok)
            DispatchQueue.main.async {
                self.view?.window?.rootViewController?.present(ac, animated: true, completion: nil)
            }
            
        }
    }
    
    @objc func newGame() {
        score = 0
        limit = 5
        editingMode = true
    }
    
    func showWelcomeAlert() {
        let message = """
            1. Tap the screen and make some barriers.
            2. You have 5 balls to destroy these barriers.
            3. If you get into the green zone, you get an extra ball.
            4. Click on the "done" button to start the game.
        """
        
        let ac = UIAlertController(title: "Welcome to Pachinko!", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel)
        ac.addAction(ok)
        DispatchQueue.main.async {
            self.view?.window?.rootViewController?.present(ac, animated: true, completion: nil)
        }
        
    }
    
}


