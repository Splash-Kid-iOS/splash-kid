//
//  Balloon.swift
//  SplashKid
//
//  Created by Miles Grossenbacher on 4/14/20.
//  Copyright © 2020 SplashKid. All rights reserved.
//

import Foundation
import SpriteKit

class Balloon: SKSpriteNode {
    //global variable for the image name
    var imageName:String = ""
    
    //initialize balloon with a starting position at timmy's position
    init(xPosition:CGFloat, yPosition:CGFloat){
        //randomly generate the balloon image
        let whichBalloon = arc4random_uniform(4)
        if(whichBalloon == 0){ //if 0, use the red balloon image
            imageName = "redBalloon"
        }
        else if(whichBalloon == 1){ //if 1, use the green balloon image
            imageName = "greenBalloon"
        }
        else if(whichBalloon == 2){ //if 2, use the pink balloon image
            imageName = "pinkBalloon"
        }
        
        else if (whichBalloon == 3){ //if 3, use the orange balloon image
            imageName = "orangeBalloon"
        }
        
        //set up the SKSpriteNode properties based on the balloon image
        let texture = SKTexture(imageNamed: imageName)
        let color = UIColor.clear
        let size = texture.size()
        
        //initialize the node
        super.init(texture: texture, color: color, size: size)
        
        //create the physics body circle around the sprite node
        let body:SKPhysicsBody = SKPhysicsBody(circleOfRadius: texture.size().width/2.0, center:CGPoint(x: 0, y: 0))
        //set properties of the physics body
        body.categoryBitMask = BodyType.balloon.rawValue
        body.contactTestBitMask = BodyType.enemy.rawValue | BodyType.object.rawValue
        body.isDynamic = true
        body.affectedByGravity = false
        body.restitution = 0.5
        //set the created physics body to the node's physics body
        self.physicsBody = body
        
        //scale the size of the node
        self.xScale = 0.3
        self.yScale = 0.3
        
        //set the position of the node based on the init parameters
        self.position.x = xPosition
        self.position.y = yPosition
    }
    
    //move the x position of the balloon when updated
    func update(){
        self.position.x += 7
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
