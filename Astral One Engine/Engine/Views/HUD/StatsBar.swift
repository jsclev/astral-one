import Foundation
import Combine
import SpriteKit

internal class StatsBar: SKNode {
    private let game: Game
    private let buttonNode: SKSpriteNode
    private var cancellable = Set<AnyCancellable>()
    private let uiScaleFactor = 0.22
    private let minButtonSize = 100.0
    private let maxButtonSize = 180.0
    public var size: CGSize
    
    internal init(game: Game) {
        self.game = game
        
        let texture = SKTexture(imageNamed: "turn-indicator-bg")
        buttonNode = SKSpriteNode(texture: texture,
                                  color: UIColor.systemPink,
                                  size: texture.size())
        buttonNode.position = CGPoint.zero
        
        var size = CGSize(width: game.canvasSize.width * uiScaleFactor,
                          height: game.canvasSize.height * uiScaleFactor)
        
        if size.width < minButtonSize {
            size = CGSize(width: minButtonSize, height: minButtonSize)
        }
        else if size.width > maxButtonSize {
            size = CGSize(width: maxButtonSize, height: maxButtonSize)
        }
        
        buttonNode.size = size
        self.size = size
        
        super.init()
        
        addChild(buttonNode)
        
        self.size = buttonNode.size
        attachSubscribers()
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attachSubscribers() {
        
    }
}
