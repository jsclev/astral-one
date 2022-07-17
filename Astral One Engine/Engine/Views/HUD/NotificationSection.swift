import Foundation
import SpriteKit
import Combine

public class NotificationSection: SKNode {
    private let labelNode: SKLabelNode
    private let game: Game
    internal let size: CGSize
    private var cancellable = Set<AnyCancellable>()
    
    public init(game: Game) {
        self.game = game
        
        labelNode = SKLabelNode(fontNamed: "Arial Bold")
        labelNode.fontSize = 16
        labelNode.horizontalAlignmentMode = .left
        labelNode.fontColor = SKColor(red: 1, green: 0, blue: 0, alpha: 1)
        labelNode.zPosition = Layer.hud
        
        size = labelNode.frame.size
        super.init()
        
        addChild(labelNode)
        
        attachSubscribers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attachSubscribers() {
//        player.$notificationMsg
//            .sink(receiveValue: { notificationMsg in
//                if let msg = notificationMsg {
//                    self.labelNode.text = msg
//                }
//
//            })
//            .store(in: &cancellable)
    }
    
}
