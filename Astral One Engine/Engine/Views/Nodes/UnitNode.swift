import Foundation
import Combine
import SpriteKit

public class UnitNode: SKNode {
    private let player: Player
    private let unit: Unit
    private let mapManager: MapManager
    private let unitSprite: SKSpriteNode
    private let selectedIndicator: SKSpriteNode
    private var cancellable = Set<AnyCancellable>()
    
    public init(player: Player, unit: Unit, mapManager: MapManager) {
        self.player = player
        self.unit = unit
        self.mapManager = mapManager
        
        let unitTexture = SKTexture(imageNamed: unit.assetName)
        unitSprite = SKSpriteNode(texture: unitTexture,
                                  color: UIColor.systemPink,
                                  size: unitTexture.size())
        unitSprite.position = CGPoint.zero
        unitSprite.zPosition = 10
        
        let selectedTexture = SKTexture(imageNamed: "select-single")
        selectedIndicator = SKSpriteNode(texture: selectedTexture,
                                    color: UIColor.systemPink,
                                    size: selectedTexture.size())
        selectedIndicator.position = CGPoint.zero
        selectedIndicator.isHidden = true
        selectedIndicator.zPosition = 1
        
        super.init()

        name = unit.name
        isUserInteractionEnabled = true
        position = mapManager.getCenterOf(position: unit.position)
        zPosition = Layer.units

        addChild(unitSprite)
        addChild(selectedIndicator)
        
        attachSubscribers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attachSubscribers() {
        self.player.$selectedUnit
            .sink(receiveValue: { updatedUnit in
                if let selectedUnit = updatedUnit {
                    self.selectedIndicator.isHidden = !(selectedUnit.name == self.unit.name)
                }
                else {
                    self.selectedIndicator.isHidden = true
                }
            })
            .store(in: &cancellable)
    }
}
