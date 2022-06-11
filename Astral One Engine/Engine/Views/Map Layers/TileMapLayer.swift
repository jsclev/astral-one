import Foundation
import Combine
import SpriteKit

public class TileMapLayer {
    let player: Player
    let scene: SKScene
    let tileSet: SKTileSet
    let layer1Terrain: SKTileMapNode
    let layer2Terrain: SKTileMapNode
    
    public init(player: Player, scene: SKScene, tileSet: SKTileSet) {
        self.player = player
        self.scene = scene
        self.tileSet = tileSet
        
        layer1Terrain = SKTileMapNode(tileSet: tileSet,
                                    columns: player.map.width,
                                    rows: player.map.height,
                                    tileSize: Constants.tileSize)
        layer1Terrain.name = "base terrain"
        layer1Terrain.zPosition = Layer.base
        layer1Terrain.position = CGPoint.zero
        layer1Terrain.enableAutomapping = true
        
        layer2Terrain = SKTileMapNode(tileSet: tileSet,
                                      columns: player.map.width,
                                      rows: player.map.height,
                                      tileSize: Constants.tileSize)
        layer2Terrain.name = "layer 2 terrain"
        layer2Terrain.zPosition = Layer.terrain
        layer2Terrain.position = CGPoint.zero
        layer2Terrain.enableAutomapping = true
        
        for row in 0..<player.map.height {
            for col in 0..<player.map.width {
                if let grassTile = tileSet.tileGroups.first(where: { $0.name == "Grass" }) {
                    set(tile: player.map.tile(at: Position(row: row, col: col)), grassTile: grassTile)
                }
            }
        }
        
        scene.addChild(layer1Terrain)
        scene.addChild(layer2Terrain)
    }
    
    public func tap(location: CGPoint) {
//        let row = layer1Terrain.tileRowIndex(fromPosition: location)
//        let col = layer1Terrain.tileColumnIndex(fromPosition: location)
//
//        print("Tapped [\(row), \(col)]")
//
//        player.revealTile(at: Position(row: row, col: col))
//        set(tile: player.map.tile(at: Position(row: row, col: col)))
    }
    
    private func set(tile: Tile, grassTile: SKTileGroup) {
        let row = tile.position.row
        let col = tile.position.col
        
        layer1Terrain.setTileGroup(grassTile, forColumn: col, row: row)
        
        if tile.visibility == Visibility.FullyRevealed {
            if let tileGroup = tileSet.tileGroups.first(where: { $0.name == tile.terrain.name }) {
                layer2Terrain.setTileGroup(tileGroup, forColumn: col, row: row)
            }
            else {
                fatalError("Unable to find tile group \"\(tile.terrain.name)\"")
            }
        }
        else {
            if let tileGroup = tileSet.tileGroups.first(where: { $0.name == "Fog" }) {
                // Make sure we are setting the tile on the correct layered terrain map
                layer2Terrain.setTileGroup(tileGroup, forColumn: col, row: row)
            }
            else {
                fatalError("Unable to find tile group \"\(tile.terrain.name)\"")
            }
        }
    }
}
