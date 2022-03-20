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

        moneyValue.zPosition = Layer.hud
        energyValue.zPosition = Layer.hud
        concreteValue.zPosition = Layer.hud
        metalValue.zPosition = Layer.hud
        mineralValue.zPosition = Layer.hud

        energyIcon.zPosition = Layer.hud
        concreteIcon.zPosition = Layer.hud
        metalIcon.zPosition = Layer.hud
        mineralIcon.zPosition = Layer.hud
        
        super.init()
        name = "camera"
        print("Camera size: \(self.calculateAccumulatedFrame().size)")
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

        print("Camera size: \(self.calculateAccumulatedFrame().size)")

        addChild(moneyValue)
        addChild(energyValue)
        addChild(concreteValue)
        addChild(metalValue)
        addChild(mineralValue)

        addChild(energyIcon)
        addChild(concreteIcon)
        addChild(metalIcon)
        addChild(mineralIcon)
        
        if let scene = self.scene {
            let topIconEdge: CGFloat = (scene.size.height / 2.0) - 25.0
            let topTextEdge: CGFloat = topIconEdge - 9.0
            let verticalSpacer: CGFloat = 45.0
            
            let leftIconEdge: CGFloat = 65.0 + scene.size.width / -2.0
            let leftTextEdge: CGFloat = leftIconEdge + 40.0
            let rightTextEdge: CGFloat = (scene.size.width / 2.0) - 40.0
            
            moneyValue.position = CGPoint(x: rightTextEdge, y: topTextEdge)
            energyValue.position = CGPoint(x: leftTextEdge, y: topTextEdge)
            concreteValue.position = CGPoint(x: leftTextEdge, y: topTextEdge - verticalSpacer)
            metalValue.position = CGPoint(x: leftTextEdge, y: topTextEdge - 2.0 * verticalSpacer)
            mineralValue.position = CGPoint(x: leftTextEdge, y: topTextEdge - 3.0 * verticalSpacer)

            energyIcon.position = CGPoint(x: leftIconEdge, y: topIconEdge)
            concreteIcon.position = CGPoint(x: leftIconEdge, y: topIconEdge - verticalSpacer)
            metalIcon.position = CGPoint(x: leftIconEdge, y: topIconEdge - 2.0 * verticalSpacer)
            mineralIcon.position = CGPoint(x: leftIconEdge, y: topIconEdge - 3.0 * verticalSpacer)
            
            if let myScene = self.scene {
                print("scene size: \(myScene.size)")

            }
            print("Camera size: \(self.calculateAccumulatedFrame().size)")
        }

    }
}
