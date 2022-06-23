import Foundation
import SpriteKit
import Combine

public class TurnView: SKNode {
    private let yearNode: SKLabelNode
    private let game: Game
    internal let size: CGSize
    private let uiScaleFactor = 0.18
    private var cancellable = Set<AnyCancellable>()

    public init(game: Game) {
        self.game = game
        
        yearNode = SKLabelNode(fontNamed: "Arial Bold")
        yearNode.horizontalAlignmentMode = .right
        yearNode.zPosition = Layer.hud
        
        size = yearNode.frame.size
        super.init()
        
        var fontSize = game.canvasSize.height / 20.0
        if fontSize < 8 {
            fontSize = 8
        }
        else if fontSize > 32 {
            fontSize = 32
        }
        
        fontSize = floor(fontSize)
        
        yearNode.fontSize = fontSize

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
