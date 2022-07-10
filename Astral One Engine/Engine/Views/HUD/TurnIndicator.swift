import Foundation
import SpriteKit
import Combine

public class TurnIndicator: SKNode {
    private let labelNode: SKLabelNode
    private let bgNode: SKSpriteNode
    private let game: Game
    internal var size: CGSize
    private let uiScaleFactor = 0.25
    private let minBarHeight = 20.0
    private let maxBarHeight = 40.0
    private var cancellable = Set<AnyCancellable>()

    public init(game: Game) {
        self.game = game
        
        labelNode = SKLabelNode(fontNamed: "Arial Bold")
        labelNode.horizontalAlignmentMode = .center
        labelNode.zPosition = Layer.hud
        
        let texture = SKTexture(imageNamed: "turn-indicator-bg")
        bgNode = SKSpriteNode(texture: texture,
                              color: UIColor.systemPink,
                              size: texture.size())
        bgNode.zPosition = Layer.hud - 1.0
        
        var fontSize = game.canvasSize.height / 18.0
        if fontSize < 8 {
            fontSize = 8
        }
        else if fontSize > 32 {
            fontSize = 32
        }
        
        fontSize = floor(fontSize)
        
        labelNode.fontSize = fontSize
        labelNode.fontColor = UIColor(red: 104.0/255.0,
                                      green: 75.0/255.0,
                                      blue: 59.0/255.0,
                                      alpha: 1.0)

        bgNode.size = CGSize(width: labelNode.frame.size.width * 1.25,
                             height: labelNode.frame.size.height * 2.0)
        self.size = bgNode.size
        super.init()

        addChild(bgNode)
        addChild(labelNode)
        
        attachSubscribers()
        bgNode.size = CGSize(width: labelNode.frame.size.width * 1.25,
                             height: labelNode.frame.size.height * 2.25)
        self.size = bgNode.size
        labelNode.position = CGPoint(x: 0.0, y: -labelNode.frame.size.height / 3.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attachSubscribers() {
        self.game.$turnIndex
            .sink(receiveValue: { newValue in
                let turn = self.game.turns[newValue]
                self.labelNode.text = "Turn \(turn.ordinal): \(turn.displayText)"

            })
            .store(in: &cancellable)
    }
    
}
