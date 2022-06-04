import Foundation
import Combine
import SpriteKit

public class TileMapLayer {
    let tileSize = CGSize(width: 96, height: 48)
    
    public init(player: Player, scene: SKScene, mapView: MapView, tileSet: SKTileSet) {
        let tileMapNode = SKTileMapNode(tileSet: tileSet,
                                 columns: player.map.width,
                                 rows: player.map.height,
                                 tileSize: tileSize)
        tileMapNode.name = "base tiles"
        tileMapNode.zPosition = Layer.terrain
        tileMapNode.position = CGPoint.zero
        tileMapNode.enableAutomapping = true
        
        for row in 0..<player.map.height {
            for col in 0..<player.map.width {
                let tile = player.map.tile(at: Position(row: row, col: col))
                
                if tile.isRevealed {
                    if let tileGroup = tileSet.tileGroups.first(where: { $0.name == tile.terrain.name }) {
                        // Make sure we are setting the tile on the correct layered terrain map
                        tileMapNode.setTileGroup(tileGroup, forColumn: col, row: row)
                    }
                    else {
                        fatalError("Unable to find tile group \"\(tile.terrain.name)\"")
                    }
                }
                else {
                    if let tileGroup = tileSet.tileGroups.first(where: { $0.name == "Fog" }) {
                        // Make sure we are setting the tile on the correct layered terrain map
                        tileMapNode.setTileGroup(tileGroup, forColumn: col, row: row)
                    }
                    else {
                        fatalError("Unable to find tile group \"\(tile.terrain.name)\"")
                    }
                }
                
            }
        }
        
        scene.addChild(tileMapNode)
    }
    
}
