


import Foundation
import SpriteKit

class Balloon: SKSpriteNode {
    var imageName:String = ""
    
    init(xPosition:CGFloat, yPosition:CGFloat){
        let whichBalloon = arc4random_uniform(4)
        if(whichBalloon == 0){
            imageName = "redBalloon"
        }
        else if(whichBalloon == 1){
            imageName = "greenBalloon"
        }
        else if(whichBalloon == 2){
            imageName = "pinkBalloon"
        }
        
        else if (whichBalloon == 3){
            imageName = "orangeBalloon"
        }
        
        let texture = SKTexture(imageNamed: imageName)
        let color = UIColor.clear
        let size = texture.size()
        
        
        super.init(texture: texture, color: color, size: size)
        
        let body:SKPhysicsBody = SKPhysicsBody(circleOfRadius: texture.size().width/2.0, center:CGPoint(x: 0, y: 0))
        
        body.categoryBitMask = BodyType.balloon.rawValue
        body.contactTestBitMask = BodyType.enemy.rawValue | BodyType.object.rawValue
        body.isDynamic = true
        body.affectedByGravity = false
        body.restitution = 0.5
        self.physicsBody = body
        
        self.xScale = 0.3
        self.yScale = 0.3
        
        self.position.x = xPosition
        self.position.y = yPosition
    }
    
    
    func update(){
        self.position.x += 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
