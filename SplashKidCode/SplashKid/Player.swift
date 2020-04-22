//
//  Player.swift
//  SplashKid
//
//  Created by Miles Grossenbacher on 4/14/20.
//  Copyright © 2020 SplashKid. All rights reserved.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode {
    
    init(imageName:String) {
        // Make a texture from an image, a color, and size
        let texture = SKTexture(imageNamed: imageName)
        let color = UIColor.clear
        let size = texture.size()
        
        // Call the designated initializer
        super.init(texture: texture, color: color, size: size)
        
        self.xScale = 0.5
        self.yScale = 0.5
        
        let newSize:CGSize = CGSize(width: self.size.width * 0.7, height: self.size.height)

        // Set physics properties
        let physicsBody:SKPhysicsBody = SKPhysicsBody(rectangleOf: newSize)
        
        
        physicsBody.categoryBitMask = BodyType.player.rawValue
        physicsBody.contactTestBitMask = BodyType.object.rawValue
        physicsBody.isDynamic = true
        physicsBody.affectedByGravity = true
        physicsBody.allowsRotation = false
        physicsBody.restitution = 0.3
        
        self.physicsBody = physicsBody
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
