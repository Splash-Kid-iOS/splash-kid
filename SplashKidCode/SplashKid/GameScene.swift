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
    case balloon = 4
    case enemy = 8
}

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    //private var label : SKLabelNode?
    //private var spinnyNode : SKShapeNode?
    var balloonOnScene = false
    var balloon:Balloon = Balloon(xPosition: 0, yPosition: 0)
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
    let startingPosition:CGPoint = CGPoint(x:-50, y:70)
    
    let swipeUpRec = UISwipeGestureRecognizer()
    let tapRec = UITapGestureRecognizer()
    
    var isDead:Bool = false
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        self.backgroundColor = SKColor.black
        screenHeight = self.view!.bounds.height
        screenWidth = self.view!.bounds.width
        
//        levelWidth = screenWidth
//        levelHeight = screenHeight
        
        swipeUpRec.addTarget(self, action: #selector(GameScene.swipedUp))
        swipeUpRec.direction = .up
        self.view!.addGestureRecognizer(swipeUpRec)
        
        tapRec.addTarget(self, action: #selector(GameScene.tapped))
        tapRec.numberOfTapsRequired = 2
        self.view!.addGestureRecognizer(tapRec)
        
        
        physicsWorld.gravity = CGVector(dx: 0.4, dy: 0.0)
        
        self.anchorPoint = CGPoint(x:0.5, y: 0.0)
        
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
        
        loopingGround.xScale = 2.3
        loopingGround2.xScale = 2.3
        
        loopingGround.yScale = 1.1
        loopingGround2.yScale = 1.1
        
        loopingBG.xScale = 0.8
        loopingBG2.xScale = 0.8
        
        startLoopingBackground()
        startLoopingGround()
        
        addObjectLoop()
        
        moveWorld()
        
    }
    
    func didBegin(_ contact: SKPhysicsContact){
        print("Contact!!")
        var firstBody:SKPhysicsBody
        var secondBody:SKPhysicsBody
        
        firstBody = contact.bodyA
        secondBody = contact.bodyB
        
        if(firstBody.categoryBitMask == BodyType.object.rawValue && secondBody.categoryBitMask == BodyType.player.rawValue){
            killPlayer()
            print("DEAD")
        }
        else if(firstBody.categoryBitMask == BodyType.enemy.rawValue && secondBody.categoryBitMask == BodyType.player.rawValue){
            killPlayer()
            print("DEAD")
        }
        else if (firstBody.categoryBitMask == BodyType.player.rawValue  && secondBody.categoryBitMask == BodyType.object.rawValue ) {
            killPlayer()
            print("DEAD")
        }
        else if (firstBody.categoryBitMask == BodyType.player.rawValue  && secondBody.categoryBitMask == BodyType.enemy.rawValue ) {
            killPlayer()
            print("DEAD")
        }
        else if(firstBody.categoryBitMask == BodyType.balloon.rawValue && secondBody.categoryBitMask == BodyType.enemy.rawValue){
            killEnemy(object1: firstBody.node!, object2: secondBody.node!)
            print("balloon hit enemy")
        }
        else if(firstBody.categoryBitMask == BodyType.enemy.rawValue && secondBody.categoryBitMask == BodyType.balloon.rawValue){
            killEnemy(object1: firstBody.node!, object2: secondBody.node!)
            print("balloon hit enemy")
        }
        else if(firstBody.categoryBitMask == BodyType.object.rawValue && secondBody.categoryBitMask == BodyType.balloon.rawValue){
            killBalloon(object1: secondBody.node!)
        }
        else if(firstBody.categoryBitMask == BodyType.balloon.rawValue && secondBody.categoryBitMask == BodyType.object.rawValue){
            killBalloon(object1: firstBody.node!)
        }
    }
    
    func killPlayer() {
    
        if ( isDead == false) {
            isDead = true
            print(isDead)
            endGame()
            }
    }
    
    func killEnemy(object1:SKNode, object2:SKNode){
        object1.removeFromParent()
        object2.removeFromParent()
    }
    
    func killBalloon(object1:SKNode){
        object1.removeFromParent()
    }
    
    func endGame() {
            guard let skView = self.view as SKView? else {
                print("Could not get Skview")
                return
            }

            guard let scene = EndScreen(fileNamed:"EndScreen") else {
                print("Could not make GameScene, check the name is spelled correctly")
                return
            }

            skView.presentScene(scene)
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
    
    @objc func swipedUp(){
        
         player.jump()
        
    }
    
    @objc func tapped(){
        print("throw a balloon")
        
        if(player.isJumping == false){
            balloon = Balloon(xPosition:player.position.x, yPosition: player.position.y)
            worldNode.addChild(balloon)
            balloonOnScene = true
        }
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
        
        worldNode.enumerateChildNodes(withName: "dog"){
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
        
        let randObject = arc4random_uniform(2)
            
        if(randObject == 0){
            createEnemy()
        }
        else{
            createObject()
        }
    }
    
    func createEnemy(){
        let someObject:Enemy = Enemy()
        someObject.zPosition = -1
        worldNode.addChild(someObject)
        let randX = arc4random_uniform(UInt32(screenWidth))
        var randY = 70
        
        if(someObject.name == "dog"){
            randY = 30
        }
        
        someObject.position = CGPoint(x: screenWidth * (worldMovedIncrement + 1) + CGFloat(randX), y: CGFloat(randY))
        
    }
    
    func createObject(){
        let someObject:Object = Object()
        someObject.zPosition = -1
        worldNode.addChild(someObject)
        
        let randX = arc4random_uniform(UInt32(screenWidth))
        var randY = 0
        if(someObject.name == "icecream"){
           randY = 70
        }
        else if(someObject.name == "dog"){
           randY = 40
        }
        else if(someObject.name == "girl"){
           randY = 70
        }
        else if(someObject.name == "boy"){
           randY = 70
        }
        else if(someObject.name == "frisbee"){
            randY = 100
        }
        else if(someObject.name == "sprinkler"){
            randY = 40
        }
        
        someObject.position = CGPoint(x: screenWidth * (worldMovedIncrement + 1) + CGFloat(randX), y: CGFloat(randY))
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered

        if (isDead == false){
            player.update()
        }
        if(balloonOnScene){
            balloon.update()
        }
    }
}
