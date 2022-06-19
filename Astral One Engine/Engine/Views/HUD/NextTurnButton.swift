import Foundation
import Combine
import SpriteKit

internal class NextTurnButton: SKNode {
    private let game: Game
    private let buttonNode: SKSpriteNode
    private let selectedIndicator: SKSpriteNode
    private var cancellable = Set<AnyCancellable>()
    private let uiScaleFactor = 0.18
    private let minButtonSize = 40.0
    private let maxButtonSize = 125.0
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
        
        print("Next turn button size is \(buttonNode.size)")
        
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
//        position = mapManager.getCenterOf(position: unit.position)
//        zPosition = Layer.units
        
        addChild(buttonNode)
        addChild(selectedIndicator)
        
        attachSubscribers()
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attachSubscribers() {
//        self.player.$selectedUnit
//            .sink(receiveValue: { updatedUnit in
//                if let selectedUnit = updatedUnit {
//                    self.selectedIndicator.isHidden = !(selectedUnit.name == self.unit.name)
//                }
//                else {
//                    self.selectedIndicator.isHidden = true
//                }
//            })
//            .store(in: &cancellable)
    }
}
