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
    
    let worldNode:SKNode = SKNode()
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = SKColor.black
        screenHeight = self.view!.bounds.height
        screenWidth = self.view!.bounds.width
        
        self.anchorPoint = CGPoint(x:0.5, y: 0.0)
        
        self.addChild(worldNode)
        
        let someObject:Object = Object()
        worldNode.addChild(someObject)
        
        moveWorld()
        
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
        
        worldMovedIncrement += 1
        
        addObjectLoop()
    }
    
    func addObjectLoop(){
        var i = 0
        while(i < 3){
            
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
        
    }
}
