import Foundation
import SpriteKit
import Combine

public class TurnView: SKNode {
    public let yearNode: SKLabelNode
    private let game: Game
    
    private var cancellable = Set<AnyCancellable>()

    public init(parent: SKNode, game: Game) {
        self.game = game
        
        yearNode = SKLabelNode(fontNamed: "Arial Bold")
        yearNode.fontSize = 20
        yearNode.horizontalAlignmentMode = .right
        yearNode.zPosition = Layer.hud
//        yearNode.position = CGPoint(x: game.canvasSize.width / 2 - 100.0,
//                                    y: game.canvasSize.height / 2 - 50)
        super.init()

        addChild(yearNode)
        parent.addChild(self)
        
        
        self.position = CGPoint(x: game.canvasSize.width / 2 - 100.0,
                                y: game.canvasSize.height / 2 - 50)
        
        print("Turn: \(self.position)")

        
        
        self.game.$turnIndex
            .sink(receiveValue: { turnIndex in
                self.render(turn: game.turns[turnIndex])
            })
            .store(in: &cancellable)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func render(turn: Turn) {
        yearNode.text = "Turn \(turn.ordinal): \(turn.displayText)"
    }
}
