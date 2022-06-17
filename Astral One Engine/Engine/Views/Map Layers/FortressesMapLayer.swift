import Foundation
import Combine
import SpriteKit

public class FortressesMapLayer {
    private let player: Player
    private let mapView: MapView
    private let tileMapNode: SKTileMapNode
    private var cancellable = Set<AnyCancellable>()
    private let tileSet: SKTileSet
    
    public init(player: Player, scene: SKScene, mapView: MapView, tileSet: SKTileSet) {
        self.player = player
        self.mapView = mapView
        self.tileSet = tileSet
        
        tileMapNode = SKTileMapNode(tileSet: tileSet,
                                    columns: player.map.width,
                                    rows: player.map.height,
                                    tileSize: Constants.tileSize)
        tileMapNode.name = "Fortresses"
        tileMapNode.position = CGPoint.zero
        tileMapNode.zPosition = Layer.fortresses
        tileMapNode.enableAutomapping = true
        tileMapNode.isUserInteractionEnabled = false
        scene.addChild(tileMapNode)
        
        attachSubscribers()
    }
    
    private func attachSubscribers() {
        for row in 0..<player.map.height {
            for col in 0..<player.map.width {
                let tile = player.map.tile(at: Position(row: row, col: col))
                
                tile.$hasFortress
                    .sink(receiveValue: { hasFortress in
                        self.updateImprovement(at: tile.position, hasFortress: hasFortress)
                    })
                    .store(in: &cancellable)
            }
        }
    }
    
    private func updateImprovement(at: Position, hasFortress: Bool) {
        if hasFortress {
            if let tileGroup = tileSet.tileGroups.first(where: { $0.name == "Fortress" }) {
                tileMapNode.setTileGroup(tileGroup, forColumn: at.col, row: at.row)
            }
            else {
                fatalError("Unable to find tile group \"Fortress\"")
            }
        }
        else {
//            if let tileGroup = tileSet.tileGroups.first(where: { $0.name == "Railroad" }) {
//                tileMapNode.setTileGroup(tileGroup, forColumn: at.col, row: at.row)
//            }
//            else {
//                fatalError("Unable to find tile group \"Railroad\"")
//            }
        }
    }
}
