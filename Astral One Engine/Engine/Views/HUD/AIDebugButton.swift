import Foundation
import Combine
import SpriteKit

internal class AIDebugButton: SKNode {
    private let game: Game
    private let buttonNode: SKSpriteNode
    private let uiScaleFactor = 0.20
    private let minButtonSize = 40.0
    private let maxButtonSize = 125.0
    public let size: CGSize
    
    internal init(game: Game) {
        self.game = game
        
        let texture = SKTexture(imageNamed: "ai-debug-button")
        buttonNode = SKSpriteNode(texture: texture,
                                  color: UIColor.systemPink,
                                  size: texture.size())
        buttonNode.position = CGPoint.zero
        
        var size = CGSize(width: game.canvasSize.height * uiScaleFactor,
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
        
        name = "AI Debug Button"
        isUserInteractionEnabled = true
        
        addChild(buttonNode)
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
