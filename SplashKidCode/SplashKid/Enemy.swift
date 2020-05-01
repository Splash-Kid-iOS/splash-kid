//
//  Enemy.swift
//  SplashKid
//
//  Created by Miles Grossenbacher on 4/26/20.
//  Copyright © 2020 SplashKid. All rights reserved.
//

import Foundation
import SpriteKit

class Enemy: SKNode {
    
    var runAction:SKAction?
    var imageName:String = ""
    var objectSprite:SKSpriteNode = SKSpriteNode()
    
    override init() {
        
        super.init()
        
        
        let objectSelection = arc4random_uniform(3)
        
        var newSize:CGSize = CGSize()
        
        if(objectSelection == 0){
            
            imageName = "run02-girl"
            objectSprite = SKSpriteNode(imageNamed: imageName)
            objectSprite.xScale = 0.5
            objectSprite.yScale = 0.5
            newSize = CGSize(width: objectSprite.size.width * 0.7, height: objectSprite.size.height)
            
            self.addChild(objectSprite)
            self.name = "girl"
            
        }
        else if (objectSelection == 1){
            imageName = "run02-boy"
            objectSprite = SKSpriteNode(imageNamed: imageName)
            objectSprite.xScale = 0.5
            objectSprite.yScale = 0.5
            newSize = CGSize(width: objectSprite.size.width * 0.7, height: objectSprite.size.height)
            
            self.addChild(objectSprite)
            self.name = "boy"
        }
        else if (objectSelection == 2){
            imageName = "pug00"
            objectSprite = SKSpriteNode(imageNamed: imageName)
            objectSprite.xScale = 0.5
            objectSprite.yScale = 0.5
            newSize = CGSize(width: objectSprite.size.width, height: objectSprite.size.height)
            
            self.addChild(objectSprite)
            self.name = "dog"
        }
        
        

        // Set physics properties
        
        let physicsBody:SKPhysicsBody = SKPhysicsBody(rectangleOf: newSize)
        
        physicsBody.categoryBitMask = BodyType.enemy.rawValue
        physicsBody.contactTestBitMask = BodyType.player.rawValue | BodyType.balloon.rawValue
        physicsBody.isDynamic = true
        physicsBody.allowsRotation = true
        physicsBody.affectedByGravity = false
        physicsBody.restitution = 0.3
        
        self.physicsBody = physicsBody
        
        self.position = CGPoint(x: objectSprite.size.width/2.0, y: 0)
        
        setUpRun()
    }
    
    func setUpRun() {
        
        
        
        if(self.name == "boy"){
            let atlas = SKTextureAtlas (named: "timmy")
             
             var array = [String]()
             
             for i in 0 ... 5 {
             
                 let nameString = String(format: "boy_run0%i", i)
                 array.append(nameString)
                 
             }
             
             var atlasTextures:[SKTexture] = []
             
             for i in 0 ..< array.count{
                 
                 let texture:SKTexture = atlas.textureNamed( array[i] )
                 atlasTextures.insert(texture, at:i)
                 
             }
             
            let atlasAnimation = SKAction.animate(with: atlasTextures, timePerFrame: 1.0/7.5, resize: true , restore:false )
             runAction =  SKAction.repeatForever(atlasAnimation)
            
             objectSprite.run(runAction! , withKey:"runKey")
        }
        else if(self.name == "girl"){
            let atlas = SKTextureAtlas (named: "timmy")
             
             var array = [String]()
             
             for i in 0 ... 5 {
             
                 let nameString = String(format: "girl_run0%i", i)
                 array.append(nameString)
                 
             }
             
             var atlasTextures:[SKTexture] = []
             
             for i in 0 ..< array.count{
                 
                 let texture:SKTexture = atlas.textureNamed( array[i] )
                 atlasTextures.insert(texture, at:i)
                 
             }
             
            let atlasAnimation = SKAction.animate(with: atlasTextures, timePerFrame: 1.0/7.5, resize: true , restore:false )
             runAction =  SKAction.repeatForever(atlasAnimation)
            
             objectSprite.run(runAction! , withKey:"runKey")
        }
        
        else if(self.name == "dog"){
            let atlas = SKTextureAtlas (named: "timmy")
             
             var array = [String]()
             
             for i in 0 ... 4 {
             
                 let nameString = String(format: "0%i", i)
                 array.append(nameString)
                 
             }
             
             var atlasTextures:[SKTexture] = []
             
             for i in 0 ..< array.count{
                 
                 let texture:SKTexture = atlas.textureNamed( array[i] )
                 atlasTextures.insert(texture, at:i)
                 
             }
             
            let atlasAnimation = SKAction.animate(with: atlasTextures, timePerFrame: 1.0/7.5, resize: true , restore:false )
             runAction =  SKAction.repeatForever(atlasAnimation)
            
             objectSprite.run(runAction! , withKey:"runKey")
        }
        
        
        
    }
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
