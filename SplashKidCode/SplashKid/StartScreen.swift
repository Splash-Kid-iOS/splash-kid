//
//  StartScreen.swift
//  SplashKid
//
//  Created by Miles Grossenbacher on 4/29/20.
//  Copyright © 2020 SplashKid. All rights reserved.
//

import SpriteKit

class StartScreen: SKScene {

    /* UI Connections */
    var buttonPlay: MSButtonNode!
    var screenHeight:CGFloat = 0
    var screenWidth:CGFloat = 0

    override func didMove(to view: SKView) {
        /* Setup your scene here */
        
        // variables setting up start screen image and button
        let titleScreen:SKSpriteNode = SKSpriteNode(imageNamed: "startScreen")
        let startButton:MSButtonNode = MSButtonNode(imageName: "startButton")
        var info : SKLabelNode!
        
        addChild(titleScreen)
        addChild(startButton)
        
        // setting screen dimensions
        screenHeight = self.view!.bounds.height
        screenWidth = self.view!.bounds.width
        
        // setting start screen image dimensions
        titleScreen.size.width = screenWidth
        titleScreen.size.height = screenHeight
        titleScreen.zPosition = -1
        
        info = SKLabelNode(text: "Swipe up to jump, double tap to throw a balloon!")
        //set the position the label node and customize the font
        info.position = CGPoint(x:0 ,y: -screenHeight/2.3)
        info.zPosition = 5
        info.fontSize = 25
        info.fontName = "ChalkboardSE-Bold"
        info.fontColor = UIColor.white
        addChild(info!)
        
        // setting start button properties
        let newPoint:CGPoint = CGPoint(x:0, y: screenHeight/15)
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
        // grab reference to our SpriteKit view
        guard let skView = self.view as SKView? else {
            print("Could not get Skview")
            return
        }

        // load game scene
        guard let scene = GameScene(fileNamed:"GameScene") else {
            print("Could not make GameScene, check the name is spelled correctly")
            return
        }

        // start game scene
        skView.presentScene(scene)
    }
}
