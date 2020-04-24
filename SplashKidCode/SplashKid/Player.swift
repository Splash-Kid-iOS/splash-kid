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
    
    var jumpAction:SKAction?
    var isJumping:Bool = false
    var isRunning:Bool = true
    var jumpAmount:CGFloat = 0
    var maxJump:CGFloat = 50
    var minSpeed:CGFloat = 2.6
    var maxHeight:CGFloat = 200
    
    var runAction:SKAction?

    
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
        physicsBody.affectedByGravity = false
        physicsBody.allowsRotation = false
        physicsBody.restitution = 0.3
        physicsBody.friction = 0.9
        
        self.physicsBody = physicsBody
        
        startRun()
        
    }
    
    func setUpRun() {
        self.texture = SKTexture(imageNamed: "run02")
    }
    
    func startRun() {
        isRunning = true
        isJumping = false
        
        self.texture = SKTexture(imageNamed: "run02")

//        self.removeAction(forKey: "jumpKey")
//        self.run(runAction! , withKey:"runKey")
    }
    
    func setUpJump() {
        self.texture = SKTexture(imageNamed: "jump00")
    }
    
    func startJump(){
        
        self.texture = SKTexture(imageNamed: "jump00")

//        self.removeAction(forKey: "runKey")
//        self.run(jumpAction!, withKey:"jumpKey" )
        
        isRunning = false
        isJumping = true
        
    }
    
    func jump() {
        
        if ( isJumping == false ) {
            
            startJump()
            jumpAmount = maxJump
            
            let callAgain:SKAction = SKAction.run(taperJump)
            let wait:SKAction = SKAction.wait(forDuration: 1/60)
            let seq:SKAction = SKAction.sequence([wait, callAgain])
            let `repeat`:SKAction = SKAction.repeat(seq, count: 20)

            self.run(`repeat`)
            
        }
        
    }
    
    
    func taperJump() {
        jumpAmount = jumpAmount * 0.1
    }
    
    
    func stopJump() {
        isJumping = false
        jumpAmount = 0
        startRun()
    }
    
    func update() {
        
        if (self.position.y > maxHeight){
            self.position = CGPoint(x: self.position.x + minSpeed, y: self.position.y - 1.0)
            maxHeight -= 1.0
            
            if (maxHeight <= 70){
                stopJump()
                self.position.y = 70
                maxHeight = 200
            }
            
        } else {
            self.position = CGPoint(x: self.position.x + minSpeed, y: self.position.y + jumpAmount)
        }
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
