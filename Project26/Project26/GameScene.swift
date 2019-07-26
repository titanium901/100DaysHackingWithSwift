//
//  GameScene.swift
//  Project26
//
//  Created by Yury Popov on 25/07/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//

import SpriteKit
import CoreMotion

enum CollisionTypes: UInt32 {
    case player = 1
    case wall = 2
    case star = 4
    case vortex = 8
    case finish = 16
    case teleport = 32
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player: SKSpriteNode!
    var wall: SKSpriteNode!
    var star: SKSpriteNode!
    var vortex: SKSpriteNode!
    var finish: SKSpriteNode!
    var teleportOn: SKSpriteNode!
    var teleportOff: SKSpriteNode!
    var background: SKSpriteNode!
    
    var lastTouchPosition: CGPoint?
    var motionManager: CMMotionManager!
    
    var scoreLabel: SKLabelNode!
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var isGameOver = false

    
    override func didMove(to view: SKView) {
        createBackground(imageName: "back3")
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.zPosition = 2
        addChild(scoreLabel)
        
        physicsWorld.contactDelegate = self
        
        physicsWorld.gravity = .zero
        
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()
        
        loadLevel(level: "level1")
        createPlayer()
    }
    
    func createBackground(imageName: String) {
        background = SKSpriteNode(imageNamed: "\(imageName)")
        background.name = "background"
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
    }
    
    
    func loadLevel(level: String) {
        print(level)
        guard let levelURL = Bundle.main.url(forResource: level, withExtension: "txt") else {
            fatalError("Could not find level1.txt in the app bundle.")
        }
        guard let levelString = try? String(contentsOf: levelURL) else {
            fatalError("Could not load level1.txt from the app bundle.")
        }
        
        let lines = levelString.components(separatedBy: "\n")
        
        for (row, line) in lines.reversed().enumerated() {
            for (column, letter) in line.enumerated() {
                let position = CGPoint(x: (64 * column) + 32, y: (64 * row) + 32)
                
                if letter == "x" {
                    // load wall
                    createWall(position: position)
                } else if letter == "v"  {
                    // load vortex
                    createVortex(position: position)
                } else if letter == "s"  {
                    // load star
                    createStar(position: position)
                } else if letter == "f"  {
                    // load finish
                    createFinish(position: position)
                } else if letter == "t" {
                    createOnTeleport(position: position)
                } else if letter == "q" {
                    createOffTeleport(position: position)
                } else if letter == " " {
                    // this is an empty space – do nothing!
                } else {
                    fatalError("Unknown level letter: \(letter)")
                }
            }
        }
    }
    
    func createPlayer() {
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 96, y: 672)
        player.zPosition = 1
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width / 2)
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.linearDamping = 0.5
        
        player.physicsBody?.categoryBitMask = CollisionTypes.player.rawValue
        player.physicsBody?.contactTestBitMask = CollisionTypes.star.rawValue | CollisionTypes.vortex.rawValue | CollisionTypes.finish.rawValue
        player.physicsBody?.collisionBitMask = CollisionTypes.wall.rawValue
        addChild(player)
    }
    
    func createOnTeleport(position: CGPoint) {
        teleportOn = SKSpriteNode(imageNamed: "teleport")
        teleportOn.position = position
        teleportOn.name = "teleportOn"
        teleportOn.physicsBody = SKPhysicsBody(rectangleOf: wall.size)
        teleportOn.physicsBody?.categoryBitMask = CollisionTypes.teleport.rawValue
        teleportOn.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
        teleportOn.physicsBody?.isDynamic = false
        addChild(teleportOn)
    }
    
    func createOffTeleport(position: CGPoint) {
        teleportOff = SKSpriteNode(imageNamed: "teleport")
        teleportOff.position = position
        teleportOff.name = "teleportOff"
        teleportOff.physicsBody = SKPhysicsBody(rectangleOf: wall.size)
//        teleport.physicsBody?.categoryBitMask = CollisionTypes.finish.rawValue
//        teleport.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
        teleportOff.physicsBody?.isDynamic = false
        addChild(teleportOff)
    }
    
    func createWall(position: CGPoint) {
        wall = SKSpriteNode(imageNamed: "block")
        wall.position = position
        wall.name = "wall"
        wall.physicsBody = SKPhysicsBody(rectangleOf: wall.size)
        wall.physicsBody?.categoryBitMask = CollisionTypes.wall.rawValue
        wall.physicsBody?.isDynamic = false
        addChild(wall)
    }
    
    func createVortex(position: CGPoint) {
        vortex = SKSpriteNode(imageNamed: "vortex")
        vortex.name = "vortex"
        vortex.position = position
        vortex.run(SKAction.repeatForever(SKAction.rotate(byAngle: .pi, duration: 1)))
        vortex.physicsBody = SKPhysicsBody(circleOfRadius: vortex.size.width / 2)
        vortex.physicsBody?.isDynamic = false
        
        vortex.physicsBody?.categoryBitMask = CollisionTypes.vortex.rawValue
        vortex.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
        vortex.physicsBody?.collisionBitMask = 0
        addChild(vortex)
    }
    
    func createStar(position: CGPoint) {
        star = SKSpriteNode(imageNamed: "star")
        star.name = "star"
        star.physicsBody = SKPhysicsBody(circleOfRadius: star.size.width / 2)
        star.physicsBody?.isDynamic = false
        
        star.physicsBody?.categoryBitMask = CollisionTypes.star.rawValue
        star.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
        star.physicsBody?.collisionBitMask = 0
        star.position = position
        addChild(star)
    }
    
    func createFinish(position: CGPoint) {
        finish = SKSpriteNode(imageNamed: "finish")
        finish.name = "finish"
        finish.physicsBody = SKPhysicsBody(circleOfRadius: finish.size.width / 2)
        finish.physicsBody?.isDynamic = false
        
        finish.physicsBody?.categoryBitMask = CollisionTypes.finish.rawValue
        finish.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
        finish.physicsBody?.collisionBitMask = 0
        finish.position = position
        addChild(finish)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        lastTouchPosition = location
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        lastTouchPosition = location
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchPosition = nil
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard isGameOver == false else { return }
        
        #if targetEnvironment(simulator)
        if let currentTouch = lastTouchPosition {
            let diff = CGPoint(x: currentTouch.x - player.position.x, y: currentTouch.y - player.position.y)
            physicsWorld.gravity = CGVector(dx: diff.x / 100, dy: diff.y / 100)
        }
        #else
        if let accelerometerData = motionManager.accelerometerData {
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -50, dy: accelerometerData.acceleration.x * 50)
        }
        #endif
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA == player {
            playerCollided(with: nodeB)
        } else if nodeB == player {
            playerCollided(with: nodeA)
        }
    }
    
    func playerCollided(with node: SKNode) {
        if node.name == "vortex" {
            player.physicsBody?.isDynamic = false
            isGameOver = true
            score -= 1

            let move = SKAction.move(to: node.position, duration: 0.25)
            let scale = SKAction.scale(to: 0.0001, duration: 0.25)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([move, scale, remove])

            player.run(sequence) { [weak self] in
                self?.createPlayer()
                self?.isGameOver = false
            }
        } else if node.name == "star" {
            node.removeFromParent()
            score += 1
        } else if node.name == "teleportOn" {
            print("On")
            let move = SKAction.move(to: node.position, duration: 0.25)
            let scale = SKAction.scale(to: 0.0001, duration: 0.25)
            
            let sequence = SKAction.sequence([move, scale])
            let newPosition = CGPoint(x: teleportOff.position.x + 30, y: teleportOff.position.y)
            
            player.run(sequence) { [weak self] in
                self?.player.position = newPosition
                let scaleBack = SKAction.scale(to: 1, duration: 0.25)
                self?.player.run(scaleBack)
            }
        } else if node.name == "finish" {
            player.removeFromParent()
            removeNode(name: "star")
            removeNode(name: "finish")
            removeNode(name: "wall")
            removeNode(name: "vortex")
            removeNode(name: "background")
            removeNode(name: "teleportOn")
            removeNode(name: "teleportOff")
            
            let randomInt = Int.random(in: 2...4)
            createBackground(imageName: "back\(randomInt)")
            loadLevel(level: "level\(4)")
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.createPlayer()
            }
            
        }
    }
    
    func removeNode(name: String) {
        self.enumerateChildNodes(withName: name) { (node, _) in
            node.removeFromParent()
        }
    }
   
}
