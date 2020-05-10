//
//  GameScene.swift
//  SplashKid
//
//  Created by Miles Grossenbacher on 4/14/20.
//  Copyright © 2020 SplashKid. All rights reserved.
//

import SpriteKit
import GameplayKit

//contact values
enum BodyType:UInt32 {
    case player = 1
    case object = 2
    case balloon = 4
    case enemy = 8
}

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    //score display
    var scoreLabel : SKLabelNode!
    var scoreNum:Int = 0{didSet{scoreLabel.text = "SCORE: \(scoreNum)"}}
    
    //balloon display
    var balloonOnScene = false
    var balloon:Balloon = Balloon(xPosition: 0, yPosition: 0)
    
    var screenHeight:CGFloat = 0
    var screenWidth:CGFloat = 0
    
    
    //initialize starting nodes
    let worldNode:SKNode = SKNode()
    var worldMovedIncrement:CGFloat = 0
    var worldSpeed:TimeInterval = 5
    //world speed display
    var levelLabel: SKLabelNode!
    
    let loopingBG:SKSpriteNode = SKSpriteNode(imageNamed: "houses")
    let loopingBG2:SKSpriteNode = SKSpriteNode(imageNamed: "houses")
    
    let loopingSky:SKSpriteNode = SKSpriteNode(imageNamed: "clouds")
    let loopingSky2:SKSpriteNode = SKSpriteNode(imageNamed: "clouds")
    
    
    let loopingGround:SKSpriteNode = SKSpriteNode(imageNamed: "ground")
    let loopingGround2:SKSpriteNode = SKSpriteNode(imageNamed: "ground")
    
    let player:Player = Player(imageName: "run02")
    
    let backgroundMusic = SKAudioNode(fileNamed: "splashKidMusic.mp3")
    
    //initialize gestures
    let swipeUpRec = UISwipeGestureRecognizer()
    let tapRec = UITapGestureRecognizer()
    
    //global var to check player status
    var isDead:Bool = false
    
    override func didMove(to view: SKView) {
        
        //add contact delegate for collision detection
        physicsWorld.contactDelegate = self
        
        //get screen dimensions
        screenHeight = self.view!.bounds.height
        screenWidth = self.view!.bounds.width
        
        //set score display position/style
        scoreLabel = SKLabelNode(text: "SCORE: 0")
        scoreLabel.position = CGPoint(x:screenWidth/3.5 ,y:screenHeight-70)
        scoreLabel.zPosition = 5
        scoreLabel.fontSize = 45
        scoreLabel.fontName = "ChalkboardSE-Bold"
        scoreLabel.fontColor = UIColor.systemTeal
        self.addChild(scoreLabel)
        
        //set level label
        levelLabel = SKLabelNode(text: "NEXT LEVEL!")
        levelLabel.position = CGPoint(x:0 ,y:screenHeight/1.5)
        levelLabel.zPosition = 5
        levelLabel.fontSize = 45
        levelLabel.fontName = "ChalkboardSE-Bold"
        levelLabel.fontColor = UIColor.systemYellow
        
        //set up gesture recognition
        swipeUpRec.addTarget(self, action: #selector(GameScene.swipedUp))
        swipeUpRec.direction = .up
        self.view!.addGestureRecognizer(swipeUpRec)
        
        tapRec.addTarget(self, action: #selector(GameScene.tapped))
        tapRec.numberOfTapsRequired = 2
        self.view!.addGestureRecognizer(tapRec)
        
        //set screen anchor point (center of screen is xposition=0)
        self.anchorPoint = CGPoint(x:0.5, y: 0.0)
        
        //add background music
        
        self.addChild(backgroundMusic)
        
        //add highest level nodes to GameScene
        
        self.addChild(worldNode)
        self.addChild(player)
        
        //initialize player position
        let startingPosition:CGPoint = CGPoint(x:-screenWidth/4, y:70)
        player.position = startingPosition
        
        //add background image nodes to scene
        self.addChild(loopingBG)
        self.addChild(loopingBG2)
        self.addChild(loopingGround)
        self.addChild(loopingGround2)
        self.addChild(loopingSky)
        self.addChild(loopingSky2)
        
        //setting z pos for background nodes
        loopingGround.zPosition = -5
        loopingGround2.zPosition = -5
        loopingBG.zPosition = -200
        loopingBG2.zPosition = -200
        loopingSky.zPosition = -400
        loopingSky2.zPosition = -400
        
        //scale the nodes
        loopingBG.xScale = 0.8
        loopingBG2.xScale = 0.8
        loopingBG.yScale = 0.7
        loopingBG2.yScale = 0.7
        
        //scale sky
        loopingSky.xScale = 0.8
        loopingSky2.xScale = 0.8
        loopingSky.yScale = 0.7
        loopingSky2.yScale = 0.7
        
        loopingGround.xScale = 2.5
        loopingGround2.xScale = 2.5
        loopingGround.yScale = 1.1
        loopingGround2.yScale = 1.1
    
        //initialize the animation loops
        startLoopingBackground()
        startLoopingGround()
        startLoopingSky()
        addObject()
        moveWorld()
        
    }
    
    //create 'forever' repeating sequence that moves 'world node'
    func moveWorld(){
        let moveWorldNode:SKAction = SKAction.moveBy(x: -screenWidth, y: 0, duration: worldSpeed)
        let process:SKAction = SKAction.run(worldMoved)
        let sequence:SKAction = SKAction.sequence([moveWorldNode, process])
        let rep:SKAction = SKAction.repeatForever(sequence)
        worldNode.run(rep)
    }
    
    //after world node moves off screen, run inner functions
    func worldMoved(){
        print("moved the world")
        
        clearOldNodes()
        worldMovedIncrement += 1
        addObject()
        if(Int(worldMovedIncrement) == 3){

        }
        else if(Int(worldMovedIncrement) % 10 == 0 && worldSpeed > 2.5 ){
            worldSpeed -= 0.5
            print("lowered world duration speed")
            worldNode.removeAllActions()
            moveWorld()
            //display
            self.addChild(levelLabel)
        }
        else if(Int(worldMovedIncrement) % 10 == 1 && worldSpeed >= 2.5){
            levelLabel.removeFromParent()
        }
        
    }
    
    //set initial background position
    func setBackgroundPosition(){
        
        loopingBG.position = CGPoint(x: 0, y:  screenHeight/2.0)
        loopingBG2.position = CGPoint(x: loopingBG.size.width - 1, y:  screenHeight/2.0)
        loopingSky.position = CGPoint(x: 0, y:  screenHeight/2.0)
        loopingSky2.position = CGPoint(x: loopingSky.size.width - 1, y:  screenHeight/2.0)
        
    }

    //create 'forever' repeating sequence that moves background
    func startLoopingBackground(){
        
       setBackgroundPosition()
        
        let move:SKAction = SKAction.moveBy(x: -loopingBG.size.width, y: 0, duration: 25)
        let moveBack:SKAction = SKAction.moveBy(x: loopingBG.size.width, y: 0, duration: 0)
        let seq:SKAction = SKAction.sequence([move, moveBack])
        let rep:SKAction = SKAction.repeatForever(seq)
        
        loopingBG.run(rep)
        loopingBG2.run(rep)
        
    }
    
    //create 'forever' repeating sequence that moves sky
    func startLoopingSky(){
        
//       setBackgroundPosition()
        
        let move:SKAction = SKAction.moveBy(x: -loopingSky.size.width, y: 0, duration: 100)
        let moveBack:SKAction = SKAction.moveBy(x: loopingSky.size.width, y: 0, duration: 0)
        let seq:SKAction = SKAction.sequence([move, moveBack])
        let rep:SKAction = SKAction.repeatForever(seq)
        
        loopingSky.run(rep)
        loopingSky2.run(rep)
        
    }
    
    //set initial ground position
    func setGroundPosition(){
        
        loopingGround.position = CGPoint(x: -150, y:  150)
        loopingGround2.position = CGPoint(x: loopingGround.size.width - 151, y:  150)
        
    }
    
    //create 'forever' repeating sequence that moves ground
    func startLoopingGround(){
        
       setGroundPosition()
        
        let move:SKAction = SKAction.moveBy(x: -loopingGround.size.width, y: 0, duration: 10)
        let moveBack:SKAction = SKAction.moveBy(x: loopingGround.size.width, y: 0, duration: 0)
        let seq:SKAction = SKAction.sequence([move, moveBack])
        let rep:SKAction = SKAction.repeatForever(seq)
        
        loopingGround.run(rep)
        loopingGround2.run(rep)
        
    }
    
    // get rid of obstacles/enemies that have passed the screen
    func clearOldNodes(){
        
        for case let node in worldNode.children{
            if(node.position.x < self.screenWidth * (self.worldMovedIncrement - 1)){
                node.removeFromParent()
                print("node deleted")
            }
        }
    }
    
    //randomly create either an obstacle or enemy
    func addObject(){
        
        let randObject = arc4random_uniform(2)
            
        if(randObject == 0){
            createEnemy()
        }
        else{
            createObject()
        }
    }
    
    //create a new enemy SpriteKitNode and position
    func createEnemy(){
        let someObject:Enemy = Enemy()
        someObject.zPosition = -1
        worldNode.addChild(someObject)
        let randX = arc4random_uniform(UInt32(screenWidth))
        var randY = 70
        
        if(someObject.name == "dog"){
            randY = 30
        }
        
        //x position is in the world node to the right of the screen
        someObject.position = CGPoint(x: screenWidth * (worldMovedIncrement + 1) + CGFloat(randX), y: CGFloat(randY))
        
    }
    
    //create new obstacle and position
    func createObject(){
        let someObject:Object = Object()
        someObject.zPosition = -1
        worldNode.addChild(someObject)
        
        let randX = arc4random_uniform(UInt32(screenWidth))
        var randY = 0
        
        if(someObject.name == "icecream"){
           randY = 70
        }
        else if(someObject.name == "frisbee"){
            randY = 90
        }
        else if(someObject.name == "sprinkler"){
            randY = 40
        }
        
        someObject.position = CGPoint(x: screenWidth * (worldMovedIncrement + 1) + CGFloat(randX), y: CGFloat(randY))
    }
    
    //testing collisions between objects
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
    
    //if player collides with object, end game
    func killPlayer() {
    
        if ( isDead == false) {
            isDead = true
            print(isDead)
            backgroundMusic.run(SKAction.stop())
            endGame()
        }
        
    }
    
    //if balloon collides with enemy, remove enemy/balloon and increase score
    func killEnemy(object1:SKNode, object2:SKNode){
        scoreNum += 10
        object1.removeFromParent()
        object2.removeFromParent()
    }
    
    //if balloon hits non-enemy object, remove balloon
    func killBalloon(object1:SKNode){
        object1.removeFromParent()
    }
    
    //transition to EndScreen and send player's final score
    func endGame() {
            guard let skView = self.view as SKView? else {
                print("Could not get Skview")
                return
            }

            let transition = SKTransition.fade(withDuration: 0.5)
            guard let scene = EndScreen(fileNamed:"EndScreen") else {
                print("Could not make EndScreen, check the name is spelled correctly")
                return
            }
            
            scene.score = scoreNum
            skView.presentScene(scene, transition: transition)
        }
    
    
    // run function on swipe up gesture
    @objc func swipedUp(){
        
         player.jump()
        
    }
    
    //run function on double tap gesture
    @objc func tapped(){
        print("throw a balloon")
        killBalloon(object1: balloon)
        //if(player.isJumping == false){
            balloon = Balloon(xPosition:player.position.x + 15, yPosition: player.position.y)
            self.addChild(balloon)
            balloonOnScene = true
            player.position.x = CGFloat(-screenWidth/4)
        //}
    }
    
    // check player status and balloon status
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered

        if (isDead == false){
            player.update()
        }
        
        if(balloonOnScene){
            balloon.update()
            if((balloon.position.x) > screenWidth/2 - screenWidth/12){
                killBalloon(object1: balloon)
            }
        }
        
    }
}
