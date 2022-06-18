import Foundation
import Combine
import SpriteKit

public class UnitsMapLayer {
    private let player: Player
    private let scene: SKScene
    private let mapView: MapView
    private let tileMapNode: SKTileMapNode
    private var cancellable = Set<AnyCancellable>()
    private let tileSet: SKTileSet
    
    public init(player: Player, scene: SKScene, mapView: MapView, tileSet: SKTileSet) {
        self.player = player
        self.scene = scene
        self.mapView = mapView
        self.tileSet = tileSet
        
        tileMapNode = SKTileMapNode(tileSet: tileSet,
                                    columns: player.map.width,
                                    rows: player.map.height,
                                    tileSize: Constants.tileSize)
        tileMapNode.name = "Roads"
        tileMapNode.position = CGPoint.zero
        tileMapNode.zPosition = Layer.roads
        tileMapNode.enableAutomapping = true
        tileMapNode.isUserInteractionEnabled = false
        scene.addChild(tileMapNode)
        
        attachSubscribers()
    }
    
    private func attachSubscribers() {
        player.$units
            .sink(receiveValue: { units in
                if let unit = units.last {
                    self.renderUnit(unit: unit)
                }
            })
            .store(in: &cancellable)
        
        player.$cityCreators
            .sink(receiveValue: { cityCreators in
                if let cityCreator = cityCreators.last {
                    self.renderUnit(unit: cityCreator)
                }
            })
            .store(in: &cancellable)
    }
    
    private func renderUnit(unit: Unit) {
        let unitNode = UnitNode(player: player, unit: unit, mapView: mapView)
        unitNode.position = mapView.getCenterPointOf(position: unit.position)
        unitNode.zPosition = Layer.units
        
        self.scene.addChild(unitNode)
    }
}
