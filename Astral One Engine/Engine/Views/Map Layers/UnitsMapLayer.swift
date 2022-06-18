import Foundation
import Combine
import SpriteKit

public class UnitsMapLayer {
    private let player: Player
    private let scene: SKScene
    private let mapView: MapManager
    private let tileMapNode: SKTileMapNode
    private var cancellable = Set<AnyCancellable>()
    private let tileSet: SKTileSet
    private var localSettlers: [Settler] = []
    private var unitNodes: [UnitNode] = []
    
    public init(player: Player, scene: SKScene, mapView: MapManager, tileSet: SKTileSet) {
        self.player = player
        self.scene = scene
        self.mapView = mapView
        self.tileSet = tileSet
        
        tileMapNode = SKTileMapNode(tileSet: tileSet,
                                    columns: player.map.width,
                                    rows: player.map.height,
                                    tileSize: Constants.tileSize)
        tileMapNode.name = "Units map layer"
        tileMapNode.position = CGPoint.zero
        tileMapNode.zPosition = Layer.units
        tileMapNode.enableAutomapping = true
        tileMapNode.isUserInteractionEnabled = false
        scene.addChild(tileMapNode)
        
        attachSubscribers()
    }
    
    private func attachSubscribers() {
        player.$units
            .sink(receiveValue: { units in
                print("Unit count is \(units.count)")
                if let unit = units.last {
                    self.renderUnit(unit: unit)
                }
            })
            .store(in: &cancellable)
        
        player.$cityCreators
            .sink(receiveValue: { cityCreators in
                print("City creators count is \(cityCreators.count)")
                if cityCreators.count < self.localSettlers.count {
                    
                    for settler in self.localSettlers {
                        var foundIt = false
                        for diff in cityCreators {
                            if diff.name == settler.name {
                                foundIt = true
                            }
                        }
                        
                        if !foundIt {
                            self.localSettlers.remove(at: self.localSettlers.count - 1)
                            
                            if let node = self.scene.childNode(withName: settler.name) {
                                node.removeFromParent()
                            }
                        }
                    }
                    
                }
                else {
                    if let cityCreator = cityCreators.last {
                        self.renderUnit(unit: cityCreator)
                        self.localSettlers.append(cityCreator as! Settler)
                    }
                }
            })
            .store(in: &cancellable)
    }
    
    private func renderUnit(unit: Unit) {
        let unitNode = UnitNode(player: player, unit: unit, mapView: mapView)
        unitNode.position = mapView.getCenterPointOf(position: unit.position)
        unitNode.zPosition = Layer.units
        unitNode.name = unit.name
        
        self.scene.addChild(unitNode)
    }
}
