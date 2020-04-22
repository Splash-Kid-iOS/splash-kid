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
    var screenHeight:CGFloat = 0
    var screenWidth:CGFloat = 0
    var worldMovedIncrement:CGFloat = 0
    let player:Player = Player(imageName: "ball")
    let loopingBG:SKSpriteNode = SKSpriteNode(imageNamed: "skBG")
    let loopingBG2:SKSpriteNode = SKSpriteNode(imageNamed: "skBG")
    let worldNode:SKNode = SKNode()
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = SKColor.black
        screenHeight = self.view!.bounds.height
        screenWidth = self.view!.bounds.width
        
        physicsWorld.gravity = CGVector(dx: 0.4, dy: 0.0)
        
        self.anchorPoint = CGPoint(x:0.6, y: 0.0)
        
        
        
        self.addChild(worldNode)
        
        
        worldNode.addChild(player)
        player.position = CGPoint(x: 0, y: screenHeight/2.0)
        
        addChild(loopingBG)
        addChild(loopingBG2)
        
        loopingBG.zPosition = -200
        loopingBG2.zPosition = -200
        
        loopingBG.yScale = 0.7
        loopingBG2.yScale = 0.7
        
        loopingBG.xScale = 0.8
        loopingBG2.xScale = 0.8
        
        startLoopingBackground()
        
        addObjectLoop()
        
        moveWorld()
        
    }
    
    func startLoopingBackground(){
        
       setBackgroundPosition()
        
        let move:SKAction = SKAction.moveBy(x: -loopingBG.size.width, y: 0, duration: 20)
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
        while(i < 4){
            
            createObject()
            
            i += 1
        }
    }
    
    func createObject(){
        let someObject:Object = Object()
        someObject.zPosition = -1
        worldNode.addChild(someObject)
        
        let randX = arc4random_uniform(UInt32(screenWidth))
        let randY = arc4random_uniform(UInt32(screenHeight))
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
            player.position = CGPoint(x: (screenWidth * worldMovedIncrement), y: screenHeight/2)
            player.physicsBody?.velocity = CGVector(dx: 0.0, dy: 0.0)
        }
    }
}
