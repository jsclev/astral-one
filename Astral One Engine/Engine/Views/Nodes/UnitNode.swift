import Foundation
import Combine
import SpriteKit

  public class UnitNode: SKNode {
    private let player: Player
    private let unit: Unit
    private let mapManager: MapManager
    private let unitSprite: SKSpriteNode
      private let labelNode: SKLabelNode
//    private let selectedIndicator: SKSpriteNode
//    private let selectedSkyIndicator: SKSpriteNode
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
        
        labelNode = SKLabelNode(fontNamed: "Arial Bold")
        labelNode.position = CGPoint(x: -5.0, y: -50.0)
        labelNode.fontSize = 32
        labelNode.horizontalAlignmentMode = .center
        labelNode.zPosition = unitSprite.zPosition + 1.0
        
        var color = UIColor.white
        
        if unit.player.ordinal == 0 {
            color = UIColor.green
        }
        else if unit.player.ordinal == 1 {
            color = UIColor.red
        }
        else if unit.player.ordinal == 2 {
            color = UIColor.blue
        }
        else if unit.player.ordinal == 3 {
            color = UIColor.yellow
        }
        else if unit.player.ordinal == 4 {
            color = UIColor.cyan
        }
        
        if unit.assetName.contains("Americans") {
            color = UIColor.cyan
        }
        else if unit.assetName.contains("Americans") {
            color = UIColor.red
        }
        else if unit.assetName.contains("Americans") {
            color = UIColor.blue
        }
        else if unit.assetName.contains("Russians") {
            color = UIColor.red
        }
        else if unit.assetName.contains("Russians") {
            color = UIColor.cyan
        }
        
        labelNode.fontColor = color
        
        if unit.assetName.contains("cavalry") ||
           unit.assetName.contains("naval"){
            labelNode.text = "------"
        }
        else {
            labelNode.text = ""
        }
        

        
//        let selectedTexture = SKTexture(imageNamed: "select-single")
//        selectedIndicator = SKSpriteNode(texture: selectedTexture,
//                                         color: UIColor.systemPink,
//                                         size: selectedTexture.size())
//        selectedIndicator.position = CGPoint.zero
//        selectedIndicator.isHidden = true
//        selectedIndicator.zPosition = 5
        
//        let selectedSkyTexture = SKTexture(imageNamed: "unit-select-sky")
//        selectedSkyIndicator = SKSpriteNode(texture: selectedSkyTexture,
//                                            color: UIColor.systemPink,
//                                            size: CGSize(width: 100.0, height: 500.0))
//        selectedSkyIndicator.position = CGPoint(x: -50.0, y: 0.0)
//        selectedSkyIndicator.anchorPoint = CGPoint.zero
//        selectedSkyIndicator.isHidden = true
//        selectedSkyIndicator.zPosition = 1
        
        super.init()
        
        name = unit.name
        isUserInteractionEnabled = true
        position = mapManager.getCenterOf(position: unit.position)
        zPosition = Layer.units
        
        addChild(unitSprite)
        addChild(labelNode)
//        addChild(selectedIndicator)
//        addChild(selectedSkyIndicator)
        
        attachSubscribers()
        
        if unit.assetName.contains("cavalry-6") {
            unitSprite.size = CGSize(width: 74.0, height: 62.0)
            //unitSprite.position = CGPoint(x: 90, y: 20)
        }
        
        if unit.assetName == "Units/Skins/Upgraded/Naval/naval-1" {
            unitSprite.size = CGSize(width: 60.0, height: 55.0)
            //unitSprite.position = CGPoint(x: 90, y: 20)
        }
        
        if unit.assetName == "Units/Skins/Upgraded/Naval/naval-3" {
            unitSprite.size = CGSize(width: 65.0, height: 79.0)
            //unitSprite.position = CGPoint(x: 90, y: 20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attachSubscribers() {
        self.unit.$skin
            .sink(receiveValue: { skin in
                print("Skin of \(self.unit.name) changed to \(skin.name)")
            })
            .store(in: &cancellable)
        
        self.unit.$position
            .sink(receiveValue: { unitPosition in
                self.position = self.mapManager.getCenterOf(position: unitPosition)
                


                
            })
            .store(in: &cancellable)
        
//        self.player.$selectedUnit
//            .sink(receiveValue: { updatedUnit in
//                if let selectedUnit = updatedUnit {
//                    self.selectedIndicator.isHidden = !(selectedUnit.name == self.unit.name)
//                    self.selectedSkyIndicator.isHidden = !(selectedUnit.name == self.unit.name)
//                }
//                else {
//                    self.selectedIndicator.isHidden = true
//                    self.selectedSkyIndicator.isHidden = true
//                }
//
//                self.selectedSkyIndicator.size.height = (self.player.game.canvasSize.height / 2) - self.position.y - (self.player.game.canvasSize.height * 0.1)
//            })
//            .store(in: &cancellable)
    }
}
