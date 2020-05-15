//
//  Object.swift
//  SplashKid
//
//  Created by Miles Grossenbacher on 4/14/20.
//  Copyright © 2020 SplashKid. All rights reserved.
//

import Foundation
import SpriteKit

class Object: SKNode {
    
    // creating a node for each generated object
    var objectSprite:SKSpriteNode = SKSpriteNode()
    var imageName:String = ""
    
    override init() {
        
        super.init()
        
        // random number out of 3 to determine which obstacle sprite to generate
        let objectSelection = arc4random_uniform(3)
        
        // variable to set up obstacle sprite size
        var newSize:CGSize = CGSize()
        
        if (objectSelection == 0){ // if random number is 0, generate ice cream truck obstacle

            imageName = "icecream"
            objectSprite = SKSpriteNode(imageNamed: imageName)
            objectSprite.xScale = 0.5
            objectSprite.yScale = 0.5
            newSize = CGSize(width: objectSprite.size.width * 0.2, height: objectSprite.size.height * 0.3)
            
            self.addChild(objectSprite)
            self.name = "icecream"
            
            //add audio components
            let iceCream = SKAudioNode(fileNamed: "shortIceCream.wav")
            self.addChild(iceCream)
            iceCream.run(SKAction.changeVolume(to: Float(0.2), duration: 0)) //vol at 0.5
            
        }
        
        else if (objectSelection == 1){ // if random number is 1, generate frisbee obstacle

            imageName = "football"
            objectSprite = SKSpriteNode(imageNamed: imageName)
            objectSprite.xScale = 0.08
            objectSprite.yScale = 0.08
            newSize = CGSize(width: objectSprite.size.width * 0.5, height: objectSprite.size.height * 0.5)
            
            self.addChild(objectSprite)
            self.name = "frisbee"
        }
            
        else if (objectSelection == 2){ // if random number is 2, generate sprinkler obstacle
            imageName = "cone"
            objectSprite = SKSpriteNode(imageNamed: imageName)
            objectSprite.xScale = 0.15
            objectSprite.yScale = 0.15
            newSize = CGSize(width: objectSprite.size.width * 0.3, height: objectSprite.size.height)
            
            self.addChild(objectSprite)
            self.name = "sprinkler"
            
        }
        
        // set physics body to obstacle node, and initializing physics body properties
        let physicsBody:SKPhysicsBody = SKPhysicsBody(rectangleOf: newSize)
        physicsBody.categoryBitMask = BodyType.object.rawValue
        physicsBody.contactTestBitMask = BodyType.player.rawValue | BodyType.balloon.rawValue
        physicsBody.isDynamic = true
        physicsBody.allowsRotation = false
        physicsBody.affectedByGravity = false
        physicsBody.restitution = 0.3
        
        self.physicsBody = physicsBody
        
        // set position of obstacle node to generate off the screen
        self.position = CGPoint(x: objectSprite.size.width/2.0, y: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
