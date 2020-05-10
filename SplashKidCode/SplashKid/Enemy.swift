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
        
        // random number variable out of 3 to determine which enemy (animation) gets generated
        let objectSelection = arc4random_uniform(4)
        
        // variable to set enemy size
        var newSize:CGSize = CGSize()
        
        if (objectSelection == 0){ // if random number is 0, generate girl enemy animation/sprite
            imageName = "run02-girl"
            objectSprite = SKSpriteNode(imageNamed: imageName)
            objectSprite.xScale = 0.5
            objectSprite.yScale = 0.5
            newSize = CGSize(width: objectSprite.size.width * 0.7, height: objectSprite.size.height)
            
            self.addChild(objectSprite)
            self.name = "girl"
        }
            
        else if (objectSelection == 1 || objectSelection == 3){ // if random number is 1 or 4, generate boy enemy animation/sprite
            imageName = "run02-boy"
            objectSprite = SKSpriteNode(imageNamed: imageName)
            objectSprite.xScale = 0.5
            objectSprite.yScale = 0.5
            newSize = CGSize(width: objectSprite.size.width * 0.7, height: objectSprite.size.height)
            
            self.addChild(objectSprite)
            self.name = "boy"
        }
            
        else if (objectSelection == 2){ // if random number is 2, generate dog animation/sprite
            imageName = "pug00"
            objectSprite = SKSpriteNode(imageNamed: imageName)
            objectSprite.xScale = 0.5
            objectSprite.yScale = 0.5
            newSize = CGSize(width: objectSprite.size.width, height: objectSprite.size.height)
            
            self.addChild(objectSprite)
            self.name = "dog"
        }

        // setting physics properties
        let physicsBody:SKPhysicsBody = SKPhysicsBody(rectangleOf: newSize)
        
        physicsBody.categoryBitMask = BodyType.enemy.rawValue
        physicsBody.contactTestBitMask = BodyType.player.rawValue | BodyType.balloon.rawValue
        physicsBody.isDynamic = true
        physicsBody.allowsRotation = true
        physicsBody.affectedByGravity = false
        physicsBody.restitution = 0.3
        
        self.physicsBody = physicsBody
        
        self.position = CGPoint(x: objectSprite.size.width/2.0, y: 0)
        
        setUpRun() // calls function to run animation sequence
    }
    
    // executes animation sequence of all enemy sprites
    func setUpRun() {
        
        if (self.name == "boy"){
            
            let atlas = SKTextureAtlas (named: "timmy") // user sprite
            var array = [String]() // array to store all animation frames
             
            for i in 0 ... 5 { // iterate through all frames and add to array
             
                 let nameString = String(format: "boy_run0%i", i) // searching for the specified png frame
                 array.append(nameString)
                 
            }
             
            var atlasTextures:[SKTexture] = [] // array to hold animation textures
             
            for i in 0 ..< array.count{ // iterate through array of frames and sets atlas texture to each array frame
                 
                 let texture:SKTexture = atlas.textureNamed( array[i] )
                 atlasTextures.insert(texture, at:i)
                 
            }
            
            // creates the atlas animation sequence with boy enemy frames
            let atlasAnimation = SKAction.animate(with: atlasTextures, timePerFrame: 1.0/7.5, resize: true , restore:false )
            runAction =  SKAction.repeatForever(atlasAnimation) // loops animation infinitely
            
            objectSprite.run(runAction! , withKey:"runKey") // executes the enemy run animation sequence
            
        }
            
        else if (self.name == "girl"){
            
             let atlas = SKTextureAtlas (named: "timmy") // frames are stored in timmy.atlas folder
             var array = [String]() // array to hold girl animation frames
             
             for i in 0 ... 5 { // iterates through frames and adds girl pngs to array
             
                 let nameString = String(format: "girl_run0%i", i) // searching for the specified png frame
                 array.append(nameString)
                 
             }
             
             var atlasTextures:[SKTexture] = [] // texture array
             
             for i in 0 ..< array.count{ // iterates through frame array and sets atlas texture to each array frame
                 
                 let texture:SKTexture = atlas.textureNamed( array[i] )
                 atlasTextures.insert(texture, at:i)
                 
             }
             
             // creates the atlas animation sequence with girl enemy frames
             let atlasAnimation = SKAction.animate(with: atlasTextures, timePerFrame: 1.0/7.5, resize: true , restore:false )
             runAction =  SKAction.repeatForever(atlasAnimation) // loops animation infinitely
            
             objectSprite.run(runAction! , withKey:"runKey") // executes the enemy run animation sequence
        }
        
        else if (self.name == "dog"){ // iterates through frames and adds dog pngs to array
            
            let atlas = SKTextureAtlas (named: "timmy") // frames are stored in timmy.atlas folder
            var array = [String]() // array to hold dog animation frames
             
            for i in 0 ... 4 { // iterates through frames and adds dog pngs to array
             
                 let nameString = String(format: "0%i", i) // searching for the specified png frame
                 array.append(nameString)
                 
            }
             
            var atlasTextures:[SKTexture] = [] // texture array
             
            for i in 0 ..< array.count{ // iterates through frame array and sets atlas texture to each array frame
                 
                 let texture:SKTexture = atlas.textureNamed( array[i] )
                 atlasTextures.insert(texture, at:i)
                 
            }
             
            // creates the atlas animation sequence with dog frames
            let atlasAnimation = SKAction.animate(with: atlasTextures, timePerFrame: 1.0/7.5, resize: true , restore:false )
            runAction =  SKAction.repeatForever(atlasAnimation) // loops animation infinitely
            
            objectSprite.run(runAction! , withKey:"runKey") // executes the enemy run animation sequence
        
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
