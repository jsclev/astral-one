import Foundation
import Combine
import SpriteKit

public class TileMapLayer {
    let player: Player
    let scene: SKScene
    let tileSet: SKTileSet
    let tileMapNode: SKTileMapNode
    let tileSize = CGSize(width: 96, height: 48)
    
    public init(player: Player, scene: SKScene, tileSet: SKTileSet) {
        self.player = player
        self.scene = scene
        self.tileSet = tileSet
        
        tileMapNode = SKTileMapNode(tileSet: tileSet,
                                 columns: player.map.width,
                                 rows: player.map.height,
                                 tileSize: tileSize)
        tileMapNode.name = "base terrain"
        tileMapNode.zPosition = Layer.terrain
        tileMapNode.position = CGPoint.zero
        tileMapNode.enableAutomapping = true
        
        for row in 0..<player.map.height {
            for col in 0..<player.map.width {
                set(tile: player.map.tile(at: Position(row: row, col: col)))
            }
        }
        
        scene.addChild(tileMapNode)
    }
    
    public func tap(location: CGPoint) {
        let row = tileMapNode.tileRowIndex(fromPosition: location)
        let col = tileMapNode.tileColumnIndex(fromPosition: location)
        
        print("Tapped [\(row), \(col)]")
        
        player.revealTile(at: Position(row: row, col: col))
        set(tile: player.map.tile(at: Position(row: row, col: col)))
    }
    
    private func set(tile: Tile) {
        if tile.visibility == Visibility.FullyRevealed {
            if let tileGroup = tileSet.tileGroups.first(where: { $0.name == tile.terrain.name }) {
                // Make sure we are setting the tile on the correct layered terrain map
                tileMapNode.setTileGroup(tileGroup,
                                         forColumn: tile.position.col, row: tile.position.row)
            }
            else {
                fatalError("Unable to find tile group \"\(tile.terrain.name)\"")
            }
        }
        else {
            if let tileGroup = tileSet.tileGroups.first(where: { $0.name == "Fog" }) {
                // Make sure we are setting the tile on the correct layered terrain map
                tileMapNode.setTileGroup(tileGroup,
                                         forColumn: tile.position.col, row: tile.position.row)
            }
            else {
                fatalError("Unable to find tile group \"\(tile.terrain.name)\"")
            }
        }
    }
}
