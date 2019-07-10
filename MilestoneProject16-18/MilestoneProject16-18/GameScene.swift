//
//  GameScene.swift
//  MilestoneProject16-18
//
//  Created by Yury Popov on 09/07/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var scoreLabel: SKLabelNode!
    var timerLabel: SKLabelNode!
    var finalScore: SKLabelNode!
    var bulletsLabel: SKLabelNode!
    var reloadLabel: SKLabelNode!
    var player: SKSpriteNode!
    var time = 60 {
        didSet {
            timerLabel.text = "Time: \(time)"
        }
    }
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    let possibleTargets = ["spider", "Hobgoblin", "venom", "thanos", "doctor", "misterio", "rihno"]
    var isGameOver = false
    var gameTimer: Timer?
    var timeToLeft: Timer?
    var targetsGenerated = 0
    var bullets = 6 {
        didSet {
            bulletsLabel.text = "Bullets: \(bullets)"
        }
    }
   
    
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "back3")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        
        scoreLabel = SKLabelNode(fontNamed: "GillSans-Bold")
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)
        
        timerLabel = SKLabelNode(fontNamed: "GillSans-Bold")
        timerLabel.position = CGPoint(x: 16, y: 740)
        timerLabel.horizontalAlignmentMode = .left
        addChild(timerLabel)
        
        bulletsLabel = SKLabelNode(fontNamed: "GillSans-Bold")
        bulletsLabel.position = CGPoint(x: 520, y: 740)
        bulletsLabel.text = "Bullets: \(bullets)"
        bulletsLabel.horizontalAlignmentMode = .center
        addChild(bulletsLabel)
        
        reloadLabel = SKLabelNode(fontNamed: "GillSans-Bold")
        reloadLabel.text = "Reload"

        reloadLabel.isHidden = true
        reloadLabel.position = CGPoint(x: 520, y: 740)
        reloadLabel.horizontalAlignmentMode = .center
        addChild(reloadLabel)
        
        
        score = 0
        time = 60
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        startGame()
        
        physicsWorld.contactDelegate = self
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        for node in children {
            if node.position.x < -300 || node.position.y > 800 || node.position.x > 1100 {
                node.removeFromParent()
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        var locationBall = touch.location(in: self)
        locationBall.y = 10
        let tappedNodes = nodes(at: location)
        
        if bullets <= 1 {
            reloadLabel.isHidden = false
            bulletsLabel.isHidden = true
            run(SKAction.playSoundFileNamed("empty.wav", waitForCompletion:false))
            if tappedNodes.contains(reloadLabel) {
                bullets = 6
                run(SKAction.playSoundFileNamed("reload.wav", waitForCompletion:false))
                reloadLabel.isHidden = true
                bulletsLabel.isHidden = false
            }
        } else {
            bullets -= 1
            createBall(in: locationBall)
            run(SKAction.playSoundFileNamed("shot.wav", waitForCompletion:false))
            
            
        }

    }
    
    func createBall(in location: CGPoint) {
        let ball = SKSpriteNode(imageNamed: "sp1")
        ball.physicsBody = SKPhysicsBody(texture: ball.texture!, size: ball.size)
        ball.position = location
        ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 500)
        ball.name = "ball"
        addChild(ball)
        let spin = SKAction.rotate(byAngle: .pi, duration: 2)
        let spinForever = SKAction.repeatForever(spin)
        ball.run(spinForever)
        smoke(box: ball)
    }
    
//    func deleteTargets(node: SKNode) {
//        guard let nodeName = node.name else { return }
//        switch nodeName {
//        case "doctor", "venom", "Hobgoblin", "thanos":
//            node.xScale = 0.50
//            node.yScale = 0.50
//            node.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
//            score += 1
//            time += 2
//        case "misterio", "rihno":
//            node.removeFromParent()
//            score += 3
//            time += 4
//        case "spider":
//            node.removeFromParent()
//            score -= 5
//        default:
//            break
//        }
//    }
    
    func startGame() {
        gameTimer?.invalidate()
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(createTargets), userInfo: nil, repeats: true)
        timeToLeft?.invalidate()
        timeToLeft = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(gameTime), userInfo: nil, repeats: true)
        run(SKAction.playSoundFileNamed("spiderMusic.mp3", waitForCompletion:false))
        
    }
    
    func gameOver() {
        
        finalScore = SKLabelNode(fontNamed: "GillSans-Bold")
        finalScore.text = "Final Score: \(score)"
        finalScore.position = CGPoint(x: 512, y: 600)
        finalScore.fontColor = UIColor.black
        
        finalScore.fontSize = 48
        addChild(finalScore)
        gameTimer?.invalidate()
        timeToLeft?.invalidate()
        let gameOver = SKSpriteNode(imageNamed: "gameOver")
        gameOver.position = CGPoint(x: 512, y: 384)
        gameOver.zPosition = 1
        addChild(gameOver)
        run(SKAction.playSoundFileNamed("gameOver.m4a", waitForCompletion:false))
    }
    
    @objc func gameTime() {
        time -= 1
        if time < 1 {
            gameOver()
            return
        } else if time <= 5 {
            timerLabel.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.timerLabel.isHidden = false
            }
        }
    }
    
    @objc func createTargets() {
        
        
        guard let target = possibleTargets.randomElement() else { return }
        
        let lineOne = CGPoint(x: 10, y: 650)
        let lineTwo = CGPoint(x: 1200, y: 450)
        let lineThree = CGPoint(x: 10, y: 250)
        let lines = [lineOne, lineTwo, lineThree]
        let randomSpeed = CGFloat.random(in: 100...500)
        
        
        let sprite = SKSpriteNode(imageNamed: target)
        sprite.name = target
    
        switch target {
        case "doctor", "venom", "Hobgoblin", "thanos":
            sprite.name = "enemy"
        case "misterio", "rihno":
            sprite.name = "superEnemy"
        case "spider":
            sprite.name = "spider"
        default:
            break
        }
        
        sprite.position = lines.randomElement()!
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        if sprite.position == lineTwo {
            sprite.physicsBody?.velocity = CGVector(dx: -(randomSpeed), dy: 0)
        } else {
            sprite.physicsBody?.velocity = CGVector(dx: (randomSpeed), dy: 0)
        }
        sprite.physicsBody!.contactTestBitMask = sprite.physicsBody!.collisionBitMask
    
        addChild(sprite)
    }
    
    func collisionBetween(ball: SKNode, object: SKNode) {
        if object.name == "enemy" {
            destroy(box: ball, object: object)
            print("enemy")
            score += 1
            time += 2
            
        } else if object.name == "superEnemy" {
            destroy(box: ball, object: object)
            print("superEnemy")
            score += 3
            time += 4
        } else if object.name == "spider" {
            destroy(box: ball, object: object)
            print("spider")
            score -= 5
        }
    }
    func destroy(box: SKNode, object: SKNode) {
        box.removeFromParent()
        object.removeFromParent()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA.name == "ball" {
            collisionBetween(ball: nodeA, object: nodeB)
            fire(box: nodeA)
        } else if nodeB.name == "ball" {
            collisionBetween(ball: nodeB, object: nodeA)
            fire(box: nodeA)
        } else if nodeA.name == "enemy" {
            nodeA.removeFromParent()
            nodeB.removeFromParent()
            mud(box: nodeA)
            touchInField()
        } else if nodeA.name == "superEnemy" {
            nodeA.removeFromParent()
            nodeB.removeFromParent()
            mud(box: nodeA)
            touchInField()
        } else if nodeA.name == "spider" {
            nodeA.removeFromParent()
            nodeB.removeFromParent()
            mud(box: nodeA)
            touchInField()
        }
    }
    
    func touchInField() {
        scoreLabel.xScale = 2.85
        scoreLabel.yScale = 2.50
        score -= 5
        time -= 5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.scoreLabel.xScale = 1
            self.scoreLabel.yScale = 1
        }
    }
    
    func smoke(box: SKNode) {
        if let smokeParticles = SKEmitterNode(fileNamed: "SmokeParticles") {
            smokeParticles.position = box.position
            smokeParticles.zPosition = 1
            smokeParticles.position.y += 15
            addChild(smokeParticles)
        }
        
    }
    func fire(box: SKNode) {
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = box.position
            fireParticles.zPosition = 1
            fireParticles.position.y += 15
            addChild(fireParticles)
        }
        
    }
    
    func mud(box: SKNode) {
        if let mudParticles = SKEmitterNode(fileNamed: "Mud") {
            mudParticles.position = box.position
            mudParticles.zPosition = 1
            mudParticles.position.y += 15
            addChild(mudParticles)
            run(SKAction.playSoundFileNamed("hihi.m4a", waitForCompletion:false))
        }
        
    }


}

