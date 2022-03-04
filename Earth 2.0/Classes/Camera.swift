import SpriteKit
import SwiftUI

class GameCamera: SKCameraNode {
    var money: Int = 0

    let moneyNode = SKLabelNode(fontNamed: "Arial Bold")

    let entityManager: EntityManager
    
    init(_ entityManager: EntityManager) {
        self.entityManager = entityManager
        super.init()
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        moneyNode.text = "$50"
        moneyNode.zPosition = Layer.foreground
        moneyNode.fontSize = 28
        moneyNode.fontColor = SKColor.green
        
        addChild(moneyNode)
        
        let texture0 = SKTexture(imageNamed: "energy")
        let energy = SKSpriteNode(imageNamed: "energy")
        energy.size = CGSize(width: 50.0, height: 50.0)
        energy.zPosition = Layer.foreground
        energy.position = CGPoint(x: -300,
                                  y: 160)
        addChild(energy)
    }
    
    func setMoney(money: Int) {
        self.money = money
        moneyNode.text = "blah"

    }
}
