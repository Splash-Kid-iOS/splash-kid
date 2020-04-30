//
//  EndScreen.swift
//  SplashKid
//
//  Created by user169038 on 4/30/20.
//  Copyright © 2020 SplashKid. All rights reserved.
//


import SpriteKit

class EndScreen: SKScene {

    /* UI Connections */
    var buttonPlay: MSButtonNode!
    var screenHeight:CGFloat = 0
    var screenWidth:CGFloat = 0

    override func didMove(to view: SKView) {
        /* Setup your scene here */
        
        let titleScreen:SKSpriteNode = SKSpriteNode(imageNamed: "gameOver")
        
        let startButton:MSButtonNode = MSButtonNode(imageName: "playAgain")
        
        
        addChild(titleScreen)
        addChild(startButton)
        
        screenHeight = self.view!.bounds.height
        screenWidth = self.view!.bounds.width
        
        titleScreen.size.width = screenWidth
        titleScreen.size.height = screenHeight
        
        titleScreen.zPosition = -1
        
        let newPoint:CGPoint = CGPoint(x:0, y: screenHeight/20)
        
        startButton.position = newPoint
        
        startButton.xScale = 0.3
        startButton.yScale = 0.3
        
        startButton.name = "startButton"
        
        /* Set UI connections */
        startButton.selectedHandler = {
            self.loadGame()
        }

    }
    
    func loadGame() {
        /* 1) Grab reference to our SpriteKit view */
        guard let skView = self.view as SKView? else {
            print("Could not get Skview")
            return
        }

        /* 2) Load Game scene */
        guard let scene = GameScene(fileNamed:"GameScene") else {
            print("Could not make GameScene, check the name is spelled correctly")
            return
        }

        /* 3) Ensure correct aspect mode */
        //scene.scaleMode = .aspectFill

        /* Show debug */
//        skView.showsPhysics = true
//        skView.showsDrawCount = true
//        skView.showsFPS = true

        /* 4) Start game scene */
        skView.presentScene(scene)
    }
}
