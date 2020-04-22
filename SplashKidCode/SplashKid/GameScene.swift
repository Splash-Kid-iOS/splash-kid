//
//  GameScene.swift
//  SplashKid
//
//  Created by Miles Grossenbacher on 4/14/20.
//  Copyright © 2020 SplashKid. All rights reserved.
//

import SpriteKit
import GameplayKit

enum BodyType:UInt32 {
    case player = 1
    case object = 2
    case anotherBody1 = 4
    case anotherBody2 = 8
    case anotherBody3 = 16
}

class GameScene: SKScene {
    
    //private var label : SKLabelNode?
    //private var spinnyNode : SKShapeNode?
    
    var levelCounter = -2
    var levelWidth:CGFloat = 0
    var levelHeight:CGFloat = 0
    
    
    
    var screenHeight:CGFloat = 0
    var screenWidth:CGFloat = 0
    var worldMovedIncrement:CGFloat = 0
    let player:Player = Player(imageName: "run02")
    let loopingGround:SKSpriteNode = SKSpriteNode(imageNamed: "ground")
    let loopingGround2:SKSpriteNode = SKSpriteNode(imageNamed: "ground")
    let loopingBG:SKSpriteNode = SKSpriteNode(imageNamed: "skBG")
    let loopingBG2:SKSpriteNode = SKSpriteNode(imageNamed: "skBG")
    let worldNode:SKNode = SKNode()
    let startingPosition:CGPoint = CGPoint(x:50, y:70)
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = SKColor.black
        screenHeight = self.view!.bounds.height
        screenWidth = self.view!.bounds.width
        
//        levelWidth = screenWidth
//        levelHeight = screenHeight
        
        physicsWorld.gravity = CGVector(dx: 0.4, dy: 0.0)
        
        self.anchorPoint = CGPoint(x:0.6, y: 0.0)
        
        
        
        self.addChild(worldNode)
        
        
        worldNode.addChild(player)
        player.position = startingPosition
        
        addChild(loopingGround)
        addChild(loopingGround2)
        
        loopingGround.zPosition = -5
        loopingGround2.zPosition = -5
        
        addChild(loopingBG)
        addChild(loopingBG2)
        
        loopingBG.zPosition = -200
        loopingBG2.zPosition = -200
        
        loopingBG.yScale = 0.7
        loopingBG2.yScale = 0.7
        
        loopingGround.xScale = 2.1
        loopingGround2.xScale = 2.1
        
        loopingGround.yScale = 1.1
        loopingGround2.yScale = 1.1
        
        loopingBG.xScale = 0.8
        loopingBG2.xScale = 0.8
        
        startLoopingBackground()
        startLoopingGround()
        
        addObjectLoop()
        
        moveWorld()
        
    }
    
    func startLoopingBackground(){
        
       setBackgroundPosition()
        
        let move:SKAction = SKAction.moveBy(x: -loopingBG.size.width, y: 0, duration: 25)
        let moveBack:SKAction = SKAction.moveBy(x: loopingBG.size.width, y: 0, duration: 0)
        let seq:SKAction = SKAction.sequence([move, moveBack])
        let rep:SKAction = SKAction.repeatForever(seq)
        
        loopingBG.run(rep)
        loopingBG2.run(rep)
        
        
    }
    
    func setBackgroundPosition(){
        
        loopingBG.position = CGPoint(x: 0, y:  screenHeight/2.0)
        loopingBG2.position = CGPoint(x: loopingBG.size.width, y:  screenHeight/2.0)
        
    }
    
    func startLoopingGround(){
        
       setGroundPosition()
        
        let move:SKAction = SKAction.moveBy(x: -loopingGround.size.width, y: 0, duration: 10)
        let moveBack:SKAction = SKAction.moveBy(x: loopingGround.size.width, y: 0, duration: 0)
        let seq:SKAction = SKAction.sequence([move, moveBack])
        let rep:SKAction = SKAction.repeatForever(seq)
        
        loopingGround.run(rep)
        loopingGround2.run(rep)
        
        
    }
    
    func setGroundPosition(){
        
        loopingGround.position = CGPoint(x: -150, y:  150)
        loopingGround2.position = CGPoint(x: loopingGround.size.width - 150, y:  150)
        
    }
    
    
    
    func moveWorld(){
        let moveWorldNode:SKAction = SKAction.moveBy(x: -screenWidth, y: 0, duration: 5)
        let block:SKAction = SKAction.run(worldMoved)
        let sequence:SKAction = SKAction.sequence([moveWorldNode, block])
        let rep:SKAction = SKAction.repeatForever(sequence)
        worldNode.run(rep)
        
    }
    
    func worldMoved(){
        print("moved the world")
        
        clearOldNodes()
        
        worldMovedIncrement += 1
        
        addObjectLoop()
    }
    
    func clearOldNodes(){
        var nodeCount = 0
        
        worldNode.enumerateChildNodes(withName: "square"){
            node, stop in
            
            if(node.position.x < self.screenWidth * (self.worldMovedIncrement - 1)){
                node.removeFromParent()
            }
            else{
                nodeCount += 1
            }
        }
        
        print(nodeCount)
    }
    
    func addObjectLoop(){
        var i = 0
        while(i < 2){
            
            createObject()
            
            i += 1
        }
    }
    
    func createObject(){
        let someObject:Object = Object()
        someObject.zPosition = -1
        worldNode.addChild(someObject)
        
        let randX = arc4random_uniform(UInt32(screenWidth))
        var randY = 0
        if(someObject.name == "icecream"){
           randY = 85
        }
        else if(someObject.name == "dog"){
           randY = 40
        }
        someObject.position = CGPoint(x: screenWidth * (worldMovedIncrement + 1) + CGFloat(randX), y: CGFloat(randY))
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        let playerLocation:CGPoint = self.convert(player.position, from: worldNode)
        
        var repositionPlayer:Bool = false
        
        if playerLocation.x < -(screenWidth){
            
            repositionPlayer = true
            
        }
        else if playerLocation.x > (screenWidth/2){
            repositionPlayer = true
        }
        else if playerLocation.y > screenHeight{
            repositionPlayer = true
        }
        else if playerLocation.y < 0 {
            repositionPlayer = true
        }
        
        if(repositionPlayer){
            player.position = CGPoint(x: (screenWidth * worldMovedIncrement), y: 70)
            player.physicsBody?.velocity = CGVector(dx: 0.0, dy: 0.0)
        }
    }
}
