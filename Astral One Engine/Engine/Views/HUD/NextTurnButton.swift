import Foundation
import Combine
import SpriteKit

internal class NextTurnButton: SKNode {
    private let game: Game
    private let buttonNode: SKSpriteNode
    private let selectedIndicator: SKSpriteNode
    public let size: CGSize
    private var cancellable = Set<AnyCancellable>()
    
    internal init(game: Game, screenSize: CGSize) {
        self.game = game
        
        let texture = SKTexture(imageNamed: "next-turn-button")
        buttonNode = SKSpriteNode(texture: texture,
                                  color: UIColor.systemPink,
                                  size: texture.size())
        buttonNode.position = CGPoint.zero
        
        let tempSize = screenSize.width / 10
        if tempSize < 40.0 {
            size = CGSize(width: 40.0, height: 40.0)
        }
        else {
            size = CGSize(width: tempSize, height: tempSize)
        }
        buttonNode.size = CGSize(width: size.width, height: size.height)
        print("Next turn button size is \(buttonNode.size)")
        
        let selectedTexture = SKTexture(imageNamed: "next-turn-button")
        selectedIndicator = SKSpriteNode(texture: selectedTexture,
                                         color: UIColor.systemPink,
                                         size: selectedTexture.size())
        selectedIndicator.position = CGPoint.zero
        selectedIndicator.isHidden = true
        selectedIndicator.zPosition = 1
        
        super.init()
        
        if let parent = self.parent {
            let size = parent.frame.size
            print("Camera size: \(size)")
        }
        
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
