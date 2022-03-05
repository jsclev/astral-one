import SpriteKit
import SwiftUI

class GameCamera: SKCameraNode {
    let entityManager: EntityManager

    let moneyValue = SKLabelNode(fontNamed: "Arial Bold")
    let energyValue = SKLabelNode(fontNamed: "Arial Bold")
    let concreteValue = SKLabelNode(fontNamed: "Arial Bold")
    let metalValue = SKLabelNode(fontNamed: "Arial Bold")
    let mineralValue = SKLabelNode(fontNamed: "Arial Bold")

    let energyIcon = SKSpriteNode(imageNamed: "energy")
    let concreteIcon = SKSpriteNode(imageNamed: "concrete")
    let metalIcon = SKSpriteNode(imageNamed: "metal")
    let mineralIcon = SKSpriteNode(imageNamed: "minerals")

    init(_ entityManager: EntityManager) {
        self.entityManager = entityManager
        
        moneyValue.fontSize = 28
        energyValue.fontSize = 22
        concreteValue.fontSize = 22
        metalValue.fontSize = 22
        mineralValue.fontSize = 22
        
        energyValue.horizontalAlignmentMode = .left
        concreteValue.horizontalAlignmentMode = .left
        metalValue.horizontalAlignmentMode = .left
        mineralValue.horizontalAlignmentMode = .left

        moneyValue.fontColor = SKColor.green
        energyValue.fontColor = SKColor.white
        concreteValue.fontColor = SKColor.white
        metalValue.fontColor = SKColor.white
        mineralValue.fontColor = SKColor.white

        energyIcon.size = CGSize(width: 40.0, height: 35.0)
        concreteIcon.size = CGSize(width: 40.0, height: 35.0)
        metalIcon.size = CGSize(width: 40.0, height: 35.0)
        mineralIcon.size = CGSize(width: 40.0, height: 35.0)

        moneyValue.zPosition = Layer.foreground
        energyValue.zPosition = Layer.foreground
        concreteValue.zPosition = Layer.foreground
        metalValue.zPosition = Layer.foreground
        mineralValue.zPosition = Layer.foreground

        energyIcon.zPosition = Layer.foreground
        concreteIcon.zPosition = Layer.foreground
        metalIcon.zPosition = Layer.foreground
        mineralIcon.zPosition = Layer.foreground
        
        moneyValue.position = CGPoint(x: 285, y: 155)
        energyValue.position = CGPoint(x: -280, y: 155)
        concreteValue.position = CGPoint(x: -280, y: 110)
        metalValue.position = CGPoint(x: -280, y: 65)
        mineralValue.position = CGPoint(x: -280, y: 20)

        energyIcon.position = CGPoint(x: -310, y: 165)
        concreteIcon.position = CGPoint(x: -310, y: 120)
        metalIcon.position = CGPoint(x: -310, y: 75)
        mineralIcon.position = CGPoint(x: -310, y: 30)

        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        moneyValue.text = "$50"
        energyValue.text = "872"
        concreteValue.text = "423"
        metalValue.text = "19"
        mineralValue.text = "76"

        addChild(moneyValue)
        addChild(energyValue)
        addChild(concreteValue)
        addChild(metalValue)
        addChild(mineralValue)

        addChild(energyIcon)
        addChild(concreteIcon)
        addChild(metalIcon)
        addChild(mineralIcon)
    }
}
