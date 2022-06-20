import Foundation
import Combine
import SpriteKit

public class UnitNode: SKNode {
    private let player: Player
    private let unit: Unit
    private let mapManager: MapManager
    private let unitSprite: SKSpriteNode
    private let selectedIndicator: SKSpriteNode
    private let selectedSkyIndicator: SKSpriteNode
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
        selectedIndicator.zPosition = 5
        
        let selectedSkyTexture = SKTexture(imageNamed: "unit-select-sky")
        selectedSkyIndicator = SKSpriteNode(texture: selectedSkyTexture,
                                            color: UIColor.systemPink,
                                            size: CGSize(width: 100.0, height: 500.0))
        selectedSkyIndicator.position = CGPoint(x: -50.0, y: 0.0)
        selectedSkyIndicator.anchorPoint = CGPoint.zero
        selectedSkyIndicator.isHidden = true
        selectedSkyIndicator.zPosition = 1
        
        super.init()
        
        name = unit.name
        isUserInteractionEnabled = true
        position = mapManager.getCenterOf(position: unit.position)
        zPosition = Layer.units
        
        addChild(unitSprite)
        addChild(selectedIndicator)
        addChild(selectedSkyIndicator)
        
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
                    self.selectedSkyIndicator.isHidden = !(selectedUnit.name == self.unit.name)
                }
                else {
                    self.selectedIndicator.isHidden = true
                    self.selectedSkyIndicator.isHidden = true
                }
                
                self.selectedSkyIndicator.size.height = (self.player.game.canvasSize.height / 2) - self.position.y - (self.player.game.canvasSize.height * 0.1)
            })
            .store(in: &cancellable)
    }
}
