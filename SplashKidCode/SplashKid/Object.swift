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
    
    var objectSprite:SKSpriteNode = SKSpriteNode()
    var imageName:String = ""
    
    override init() {
        
        super.init()
        
        let objectSelection = arc4random_uniform(6)
        
        var newSize:CGSize = CGSize()
        
        if(objectSelection == 0){
            
            imageName = "icecream"
            objectSprite = SKSpriteNode(imageNamed: imageName)
            objectSprite.xScale = 0.7
            objectSprite.yScale = 0.7
            newSize = CGSize(width: objectSprite.size.width * 0.5, height: objectSprite.size.height * 0.5)
            
            self.addChild(objectSprite)
            self.name = "icecream"
        }
        else if (objectSelection == 1){
            
            imageName = "pug00"
            objectSprite = SKSpriteNode(imageNamed: imageName)
            objectSprite.xScale = 0.5
            objectSprite.yScale = 0.5
            newSize = CGSize(width: objectSprite.size.width, height: objectSprite.size.height)
            
            self.addChild(objectSprite)
            self.name = "dog"
        }
        else if (objectSelection == 2){
            
            imageName = "run02-girl"
            objectSprite = SKSpriteNode(imageNamed: imageName)
            objectSprite.xScale = 0.5
            objectSprite.yScale = 0.5
            newSize = CGSize(width: objectSprite.size.width * 0.7, height: objectSprite.size.height)
            
            self.addChild(objectSprite)
            self.name = "girl"
        }
        else if (objectSelection == 3){
            
            imageName = "run02-boy"
            objectSprite = SKSpriteNode(imageNamed: imageName)
            objectSprite.xScale = 0.5
            objectSprite.yScale = 0.5
            newSize = CGSize(width: objectSprite.size.width * 0.7, height: objectSprite.size.height)
            
            self.addChild(objectSprite)
            self.name = "boy"
        }
        else if (objectSelection == 4){
            
            imageName = "frisbee"
            objectSprite = SKSpriteNode(imageNamed: imageName)
            objectSprite.xScale = 0.15
            objectSprite.yScale = 0.15
            newSize = CGSize(width: objectSprite.size.width, height: objectSprite.size.height)
            
            self.addChild(objectSprite)
            self.name = "frisbee"
        }
        //should sprinkler be in else and not become physics body
        else if (objectSelection == 5){
            
            imageName = "sprinkler"
            objectSprite = SKSpriteNode(imageNamed: imageName)
            objectSprite.xScale = 0.15
            objectSprite.yScale = 0.15
            newSize = CGSize(width: objectSprite.size.width * 0.3, height: objectSprite.size.height)
            
            self.addChild(objectSprite)
            self.name = "sprinkler"
        }
        
        let physicsBody:SKPhysicsBody = SKPhysicsBody(rectangleOf: newSize)
        
        physicsBody.categoryBitMask = BodyType.object.rawValue
        physicsBody.contactTestBitMask = BodyType.object.rawValue | BodyType.player.rawValue
        physicsBody.isDynamic = true
        physicsBody.allowsRotation = true
        physicsBody.affectedByGravity = false
        physicsBody.restitution = 0.3
        
        self.physicsBody = physicsBody
        
        self.position = CGPoint(x: objectSprite.size.width/2.0, y: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
