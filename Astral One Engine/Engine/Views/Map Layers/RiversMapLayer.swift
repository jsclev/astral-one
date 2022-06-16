import Foundation
import Combine
import SpriteKit

public class RiversMapLayer {
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
        tileMapNode.name = "rivers"
        tileMapNode.position = CGPoint.zero
        tileMapNode.zPosition = Layer.rivers
        tileMapNode.enableAutomapping = true
        tileMapNode.isUserInteractionEnabled = false
        
        for row in 0..<player.map.height {
            for col in 0..<player.map.width {
                let tile = player.map.tile(at: Position(row: row, col: col))
                
                if tile.hasRiver {
                    if let tileGroup = tileSet.tileGroups.first(where: { $0.name == "River" }) {
                        tileMapNode.setTileGroup(tileGroup,
                                                 forColumn: tile.position.col,
                                                 row: tile.position.row)
                    }
                    else {
                        fatalError("Unable to find tile group named \"River\"")
                    }
                }
            }
        }
        
        scene.addChild(tileMapNode)
    }
}
