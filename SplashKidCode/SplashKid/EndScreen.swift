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
    //variables for screen height and width
    var screenHeight:CGFloat = 0
    var screenWidth:CGFloat = 0
    //score variable to display
    var score:Int = 0

    override func didMove(to view: SKView) {
        
        //set up background image for the game over screen
        let titleScreen:SKSpriteNode = SKSpriteNode(imageNamed: "gameOver")
        //set up the play again button with our button image
        let startButton:MSButtonNode = MSButtonNode(imageName: "playAgain")
        //create a label node to disply score
        var scoreLabel : SKLabelNode!
        //set screen height and width based on bounds on phone
        screenHeight = self.view!.bounds.height
        screenWidth = self.view!.bounds.width
        
        print("the score is: \(score)")
        //set the score label node with the int value in the score variable
        scoreLabel = SKLabelNode(text: "SCORE: \(score)")
        //set the position the label node and customize the font
        scoreLabel.position = CGPoint(x:0 ,y:50)
        scoreLabel.zPosition = 5
        scoreLabel.fontSize = 45
        scoreLabel.fontName = "ChalkboardSE-Bold"
        scoreLabel.fontColor = UIColor.white
        
        //add nodes to the endscreen scene
        addChild(titleScreen)
        addChild(startButton)
        addChild(scoreLabel!)
        
        //set the size of the title screen node to the phone dimensions
        titleScreen.size.width = screenWidth
        titleScreen.size.height = screenHeight
        //put the screen "behind" the other nodes so we can click the button
        titleScreen.zPosition = -1
        
        //set the size and position of the play again button
        let newPoint:CGPoint = CGPoint(x:0, y: -32)
        startButton.position = newPoint
        startButton.xScale = 0.27
        startButton.yScale = 0.27
        startButton.name = "startButton"
        
        //Set UI connections for when the play again button is pressed
        startButton.selectedHandler = {
            self.loadGame()
        }

    }
    
    //called when the play again button is pressed to take back to game scene
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
