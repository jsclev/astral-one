import Foundation
import Combine
import SpriteKit

public class RoadsMapLayer {
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
        tileMapNode.name = "Roads"
        tileMapNode.position = CGPoint.zero
        tileMapNode.zPosition = Layer.roads
        tileMapNode.enableAutomapping = true
        tileMapNode.isUserInteractionEnabled = false
        scene.addChild(tileMapNode)
        
        attachSubscribers()
    }
    
    private func attachSubscribers() {
        for row in 0..<player.map.height {
            for col in 0..<player.map.width {
                let tile = player.map.tile(at: Position(row: row, col: col))
                
                tile.$roadType
                    .dropFirst()
                    .sink(receiveValue: { roadType in
                        self.updateImprovement(at: tile.position, roadType: roadType)
                    })
                    .store(in: &cancellable)
            }
        }
    }
    
    private func updateImprovement(at: Position, roadType: RoadType) {
        print(roadType)
        
        if roadType == RoadType.Road {
            if let tileGroup = tileSet.tileGroups.first(where: { $0.name == "Road" }) {
                tileMapNode.setTileGroup(tileGroup, forColumn: at.col, row: at.row)
            }
            else {
                fatalError("Unable to find tile group \"Road\"")
            }
        }
        else if roadType == RoadType.Railroad {
            if let tileGroup = tileSet.tileGroups.first(where: { $0.name == "Road" }) {
                tileMapNode.setTileGroup(tileGroup, forColumn: at.col, row: at.row)
            }
            else {
                fatalError("Unable to find tile group \"Road\"")
            }
        }
    }
}
