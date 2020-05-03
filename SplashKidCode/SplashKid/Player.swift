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
    var maxJump:CGFloat = 70
    var minSpeed:CGFloat = 0
    var maxHeight:CGFloat = 300
    
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
        physicsBody.contactTestBitMask = BodyType.object.rawValue | BodyType.enemy.rawValue
        physicsBody.isDynamic = true
        physicsBody.affectedByGravity = false
        physicsBody.allowsRotation = false
        physicsBody.restitution = 0.3
        physicsBody.friction = 0.9
        
        self.physicsBody = physicsBody
        
        setUpRun()
        setUpJump()
        startRun()
        
    }
    
    func setUpRun() {
        let atlas = SKTextureAtlas (named: "timmy")
         
         var array = [String]()
         
         for i in 0 ... 4 {
         
             let nameString = String(format: "run0%i", i)
             array.append(nameString)
             
         }
         
         var atlasTextures:[SKTexture] = []
         
         for i in 0 ..< array.count{
             
             let texture:SKTexture = atlas.textureNamed( array[i] )
             atlasTextures.insert(texture, at:i)
             
         }
         
        let atlasAnimation = SKAction.animate(with: atlasTextures, timePerFrame: 1.0/7.5, resize: true , restore:false )
         runAction =  SKAction.repeatForever(atlasAnimation)
        
    }
    
    
    func startRun() {
        
        self.removeAction(forKey: "jumpKey")
        self.removeAction(forKey: "glideKey")
        self.run(runAction! , withKey:"runKey")
        
        isRunning = true
        isJumping = false
        


    }
    
    func setUpJump() {
        
        
    }
    
    func startJump(){
        
        self.removeAction(forKey: "runKey")
        self.texture = SKTexture(imageNamed: "jump00")

        
        
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
        jumpAmount = jumpAmount * 0.9
    }
    
    
    func stopJump() {
        isJumping = false
        jumpAmount = 0
        startRun()
    }
    
    
    
    
    func update() {
        
        if (self.position.y > maxHeight){
            self.texture = SKTexture(imageNamed: "jump01")
            self.position = CGPoint(x: self.position.x + minSpeed, y: self.position.y - 3.0)
            maxHeight -= 3.0
            
            if (maxHeight <= 70){
                stopJump()
                self.position.y = 70
                maxHeight = 300
            }
            
        } else {
            self.position = CGPoint(x: self.position.x + minSpeed, y: self.position.y + jumpAmount * 0.4)
        }
        
        
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
