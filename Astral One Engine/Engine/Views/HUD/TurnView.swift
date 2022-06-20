import Foundation
import SpriteKit
import Combine

public class TurnView: SKNode {
    private let yearNode: SKLabelNode
    private let game: Game
    internal let size: CGSize
    private var cancellable = Set<AnyCancellable>()

    public init(game: Game) {
        self.game = game
        
        yearNode = SKLabelNode(fontNamed: "Arial Bold")
        yearNode.fontSize = 20
        yearNode.horizontalAlignmentMode = .right
        yearNode.zPosition = Layer.hud
        
        size = yearNode.frame.size
        super.init()

        addChild(yearNode)
        
        attachSubscribers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attachSubscribers() {
        self.game.$turnIndex
            .sink(receiveValue: { newValue in
                let turn = self.game.turns[newValue]
                self.yearNode.text = "Turn \(turn.ordinal): \(turn.displayText)"

            })
            .store(in: &cancellable)
    }
 
}
