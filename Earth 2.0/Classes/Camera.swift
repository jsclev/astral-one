import SpriteKit
import SwiftUI

class GameCamera: SKCameraNode {
    var money: Int = 0

    let moneyNode = SKLabelNode(fontNamed: "Arial Bold")
    
    override init() {
        super.init()
        
        moneyNode.text = "$50"
        moneyNode.zPosition = Layer.foreground
        moneyNode.fontSize = 28
        moneyNode.fontColor = SKColor.green
        
        addChild(moneyNode)
        
        
        moneyNode.position = CGPoint(x: (frame.width) - 100,
                                     y: (frame.height) - 50)
        print("camera width is \(frame.width)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setMoney(money: Int) {
        self.money = money
        moneyNode.text = "blah"

    }
}
