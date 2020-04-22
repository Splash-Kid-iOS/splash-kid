//
//  Level.swift
//  SplashKid
//
//  Created by Miles Grossenbacher on 4/22/20.
//  Copyright © 2020 SplashKid. All rights reserved.
//

import Foundation
import SpriteKit

class Level:SKNode{
    var levelWidth:CGFloat = 0.0
    var levelHeight:CGFloat = 0.0
    
    var imageName:String = ""
    var backgroundSprite:SKSpriteNode = SKSpriteNode()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
           
        super.init()
        
    }
    
    func createLevel(){
        
        let levelSize:CGSize = CGSize(width: levelWidth,height: levelHeight)
        
        imageName = "Wild_West_Background2"
        
        let tex:SKTexture = SKTexture(imageNamed: imageName)
        backgroundSprite = SKSpriteNode(texture: tex, color: SKColor.clear, size: levelSize)
        
        self.position = CGPoint(x: backgroundSprite.size.width / 2, y: 0)
        
        backgroundSprite.physicsBody = SKPhysicsBody(rectangleOf: backgroundSprite.size, center:CGPoint(x: 0, y: -backgroundSprite.size.height * 0.88))
        
         backgroundSprite.physicsBody!.isDynamic = false
         backgroundSprite.physicsBody!.restitution = 0
        
        //createObstacle()
    }
    
    
    
    
    
}
