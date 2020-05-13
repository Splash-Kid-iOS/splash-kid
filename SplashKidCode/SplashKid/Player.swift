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
    
    //global variables for the player class
    var runAction:SKAction?
    var jumpAction:SKAction?
    var isJumping:Bool = false
    var isRunning:Bool = true
    var jumpAmount:CGFloat = 0
    var maxJump:CGFloat = 70
    var maxHeight:CGFloat = 300
    var minSpeed:CGFloat = 0
    let jumpSound = SKAudioNode(fileNamed: "jumpUp.mp3")
    let footsteps = SKAudioNode(fileNamed: "footstep.mp3")

    //initialize the player object with the player image name
    init(imageName:String) {
        
        // Make a texture from an image, a color, and size
        let texture = SKTexture(imageNamed: imageName)
        let color = UIColor.clear
        let size = texture.size()
        
        // Call the designated initializer
        super.init(texture: texture, color: color, size: size)
        
        //set the size of the player node
        self.xScale = 0.5
        self.yScale = 0.5
        
        //size variable to set the size of the physics body
        let newSize:CGSize = CGSize(width: self.size.width * 0.7, height: self.size.height)

        //create the physics body around the desired rectangle size around the node
        let physicsBody:SKPhysicsBody = SKPhysicsBody(rectangleOf: newSize)
        // Set physics properties
        physicsBody.categoryBitMask = BodyType.player.rawValue
        physicsBody.contactTestBitMask = BodyType.object.rawValue | BodyType.enemy.rawValue
        physicsBody.isDynamic = true
        physicsBody.affectedByGravity = false
        physicsBody.allowsRotation = false
        physicsBody.restitution = 0.3
        physicsBody.friction = 0.9
        //set the created physics body to the node's physics body
        self.physicsBody = physicsBody
        
        setUpRun()
        startRun()
        
        //audio setup
        self.addChild(footsteps)
        footsteps.run(SKAction.changeVolume(to: 0.5, duration: 0)) 
        footsteps.run(SKAction.changePlaybackRate(to: 0.75, duration: 0))
        jumpSound.autoplayLooped = false
        self.addChild(jumpSound)
        jumpSound.run(SKAction.changeVolume(by: 3, duration: 0))
        
    }
    
    //set up the sprite animation of timmy running
    func setUpRun() {
        
        //atlas variable based on timmy.atlas
        let atlas = SKTextureAtlas (named: "timmy")
        
        //array to store all image names for the atlas
        var array = [String]()
        //iterate through all of the timmy run images and store in the array
        for i in 0 ... 4 {
            let nameString = String(format: "run0%i", i)
            array.append(nameString)
        }
        
        //an array of textures
        var atlasTextures:[SKTexture] = []
        //iterate through the array to fill atlas array with textures from image names
        for i in 0 ..< array.count{
            let texture:SKTexture = atlas.textureNamed( array[i] )
            atlasTextures.insert(texture, at:i)
        }
        
        //create an animation action based on all of the textures in atlasTextures
        let atlasAnimation = SKAction.animate(with: atlasTextures, timePerFrame: 1.0/7.5, resize: true , restore:false )
        //whenever runaction is called, repeat the animation forever
        runAction =  SKAction.repeatForever(atlasAnimation)
        
        //setup footstep sound
//        let footsteps = SKAction.playSoundFileNamed("footstep.mp3", waitForCompletion: false)
        
    }
    
    //start timmy running
    func startRun() {
        
        //stop the jumping action and run the running action
        self.removeAction(forKey: "jumpKey")
        self.run(runAction! , withKey:"runKey")
        //set boolan variables
        isRunning = true
        isJumping = false
        
    }
    
    //start timmy's jump action
    func startJump(){
        
        //remove the running action
        self.removeAction(forKey: "runKey")
        //display first texture of timmy's initial jumping image
        self.texture = SKTexture(imageNamed: "jump00")
        //set boolean variables
        isRunning = false
        isJumping = true
        
    }
    
    //timmy jumps
    func jump() {
        //only jump if player is currently not jumping
        if ( isJumping == false ) {
            //call function to start the jump
            startJump()
            //set the jump amount to the maxJump height
            jumpAmount = maxJump
            
            //stop footsteps sound and play jumping sound
            footsteps.run(SKAction.stop()) //pause or stop here
            jumpSound.run(SKAction.play())
            
            //sequence for timmy's jumping action
            let callAgain:SKAction = SKAction.run(taperJump)
            let wait:SKAction = SKAction.wait(forDuration: 1/60)
            let seq:SKAction = SKAction.sequence([wait, callAgain])
            let `repeat`:SKAction = SKAction.repeat(seq, count: 20)
            //run the sequence
            self.run(`repeat`)
            
        }
    }
    
    //when jumping decrease the jump amount as timmy goes up
    func taperJump() {
        jumpAmount = jumpAmount * 0.9
    }
    
    //stop the jump
    func stopJump() {
        isJumping = false
        jumpAmount = 0
        //start run again
        startRun()
        //this sound is really harsh
        self.run(SKAction.playSoundFileNamed("jumpLand2.mp3", waitForCompletion: false))
        footsteps.run(SKAction.play())
        
    }
    
    func update() {
        
        //when timmy reaches the peak of his jump
        if (self.position.y > maxHeight){
            //change the displayed texture to timmy coming down from jump
            self.texture = SKTexture(imageNamed: "jump01")
            //decrease timmy's position
            self.position = CGPoint(x: self.position.x + minSpeed, y: self.position.y - 3.0)
            maxHeight -= 3.0
            
            //decrease timmy's y position until he reaches the ground level
            if (maxHeight <= 70){
                //stop jump action
                stopJump()
                //reset timmy's y position to the initial 70
                self.position.y = 70
                //reset the max height
                maxHeight = 300
            }
            
        } else { //timmy is continuing to increase his y position while jumping 
            self.position = CGPoint(x: self.position.x + minSpeed, y: self.position.y + jumpAmount * 0.4)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
