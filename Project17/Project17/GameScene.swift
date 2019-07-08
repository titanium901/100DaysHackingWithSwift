//
//  GameScene.swift
//  Project17
//
//  Created by Yury Popov on 08/07/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
   
    var starfield: SKEmitterNode!
    var player: SKSpriteNode!
    
    var scoreLabel: SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    let possibleEnemies = ["ball", "hammer", "tv", "allien2", "putin2"]
    var isGameOver = false {
        didSet {
            starfield.isHidden = true
            starfield.removeFromParent()
            gameTimer?.invalidate()
            
        }
    }
    var gameTimer: Timer?
    var enemyTimeInterval: Double = 1.0
    var enemiesGenerated: Int = 0
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        
        starfield = SKEmitterNode(fileNamed: "starfield")!
        starfield.position = CGPoint(x: 1024, y: 384)
        starfield.advanceSimulationTime(10)
        
        
        addChild(starfield)
        starfield.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "trump2")
        player.position = CGPoint(x: 100, y: 384)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.contactTestBitMask = 1
        addChild(player)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)
        
        score = 0
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        //The scheduledTimer() timer not only creates a timer, but also starts it immediately.
        startTimer()
        
        }
    
    override func update(_ currentTime: TimeInterval) {
        //удаляем объект когда он далеко
        for node in children {
            if node.position.x < -300 {
                node.removeFromParent()
            }
        }
        
        if !isGameOver {
            score += 1
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        var location = touch.location(in: self)
//        print(#function, location)
        //что бы нельзя было наехать на наш score label и ограничить по высоте
        if location.y < 100 {
            location.y = 100
        } else if location.y > 668 {
            location.y = 668
        }
        
        player.position = location
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        gameOver()
        
        
        
    }
    
    func startTimer() {
        
        gameTimer?.invalidate()
        gameTimer = Timer.scheduledTimer(timeInterval: enemyTimeInterval, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        gameOver()
    }
    
    func gameOver() {
        let explosion = SKEmitterNode(fileNamed: "explosion")!
        explosion.position = player.position
        addChild(explosion)
        
        player.removeFromParent()
        
        isGameOver = true
    }
    
    @objc func createEnemy() {
        guard let enemy = possibleEnemies.randomElement() else { return }
        
        let sprite = SKSpriteNode(imageNamed: enemy)
        sprite.position = CGPoint(x: 1200, y: Int.random(in: 50...736))
        addChild(sprite)
        
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.categoryBitMask = 1
        // скорость полета  The velocity property of a physics body controls how fast it's moving in a particular direction.
        sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
        //отвечает за кручение объекта
        sprite.physicsBody?.angularVelocity = 5
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.angularDamping = 0
        
        enemiesGenerated += 1
        if enemiesGenerated.isMultiple(of: 20) {
            enemyTimeInterval -= 0.1
            startTimer()
        }
    }
}
