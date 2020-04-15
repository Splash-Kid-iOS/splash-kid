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
        
        let objectSelection = arc4random_uniform(2)
        
        var newSize:CGSize = CGSize()
        
        if(objectSelection == 0){
            
            imageName = "long_blue_block"
            objectSprite = SKSpriteNode(imageNamed: imageName)
            newSize = CGSize(width: objectSprite.size.width * 0.9, height: objectSprite.size.height * 0.75)
        }
        else if (objectSelection == 1){
            
            imageName = "short_orange_block"
            objectSprite = SKSpriteNode(imageNamed: imageName)
            newSize = CGSize(width: objectSprite.size.width * 0.7, height: objectSprite.size.height * 0.7)
        }
        
        self.addChild(objectSprite)
        
        let physicsBody:SKPhysicsBody = SKPhysicsBody(rectangleOf: newSize)
        
        physicsBody.categoryBitMask = BodyType.object.rawValue
        physicsBody.contactTestBitMask = BodyType.object.rawValue | BodyType.player.rawValue
        physicsBody.isDynamic = true
        physicsBody.allowsRotation = true
        physicsBody.affectedByGravity = false
        physicsBody.restitution = 0.4
        
        self.physicsBody = physicsBody
        self.name = "square"
        self.position = CGPoint(x: objectSprite.size.width/2.0, y: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
