import Foundation
import SpriteKit
import Combine

public class TurnView {
    public let yearNode: SKLabelNode
    private let game: Game
    
    private var cancellable = Set<AnyCancellable>()

    public init(parent: SKNode, game: Game) {
        self.game = game
        
        yearNode = SKLabelNode(fontNamed: "Arial Bold")
        yearNode.fontSize = 20
        yearNode.horizontalAlignmentMode = .right
        yearNode.zPosition = Layer.hud
        yearNode.position = CGPoint(x: 490, y: 340)
        parent.addChild(yearNode)
        
        print(parent.frame.width)
        
        self.game.$turnIndex
            .sink(receiveValue: { _ in
                self.refresh()
            })
            .store(in: &cancellable)
        
        refresh()
    }
    
    private func refresh() {
        yearNode.text = "Turn \(game.getCurrentTurn().ordinal): \(game.getCurrentTurn().displayText)"
    }
}
