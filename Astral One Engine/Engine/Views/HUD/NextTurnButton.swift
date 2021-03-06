import Foundation
import Combine
import SpriteKit

internal class NextTurnButton: SKNode {
    private let game: Game
    private let buttonNode: SKSpriteNode
    private let selectedIndicator: SKSpriteNode
    private var cancellable = Set<AnyCancellable>()
    private let uiScaleFactor = 0.22
    private let minButtonSize = 100.0
    private let maxButtonSize = 180.0
    public let size: CGSize
    
    internal init(game: Game) {
        self.game = game
        
        let texture = SKTexture(imageNamed: "next-turn-button")
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
        
        let selectedTexture = SKTexture(imageNamed: "next-turn-button")
        selectedIndicator = SKSpriteNode(texture: selectedTexture,
                                         color: UIColor.systemPink,
                                         size: selectedTexture.size())
        selectedIndicator.position = CGPoint.zero
        selectedIndicator.isHidden = true
        selectedIndicator.zPosition = 1
        
        super.init()
        
        name = "Next Turn"
        isUserInteractionEnabled = true

        addChild(buttonNode)
        addChild(selectedIndicator)
        
        attachSubscribers()
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attachSubscribers() {

    }
}
