import Foundation
import Combine
import SpriteKit

public class UnitMovementMapLayer {
    private let player: Player
    private let tileSet: SKTileSet
    private let tilemapNode: SKTileMapNode
    private var cancellable = Set<AnyCancellable>()
    private var indicatedPositions: [Position] = []
    
    public init(player: Player, scene: SKScene, tileSet: SKTileSet) {
        self.player = player
        self.tileSet = tileSet
        
        tilemapNode = SKTileMapNode(tileSet: tileSet,
                                 columns: player.map.width,
                                 rows: player.map.height,
                                 tileSize: Constants.tileSize)
        tilemapNode.name = "Unit movement indicators map layer"
        tilemapNode.zPosition = Layer.unitMovementIndicators
        tilemapNode.isHidden = true
        
        attachSubscribers()
        
        scene.addChild(tilemapNode)
    }
    
    private func attachSubscribers() {
        self.player.$selectedUnit
            .sink(receiveValue: { selectedUnit in
                if let unit = selectedUnit {
                    for row in (unit.position.row - 1)..<(unit.position.row + 2) {
                        for col in (unit.position.col - 1)..<(unit.position.col + 2 ) {
                            if row == unit.position.row && col == unit.position.col {
                                continue
                            }
                            else {
                                let tile = self.player.map.tile(at: Position(row: row, col: col))
                                
                                if tile.visibility == Visibility.FullyRevealed {
                                    self.indicatedPositions.append(Position(row: row, col: col))
                                    
                                    if let tileGroup = self.tileSet.tileGroups.first(where: { $0.name == "Movement Indicator" }) {
                                        self.tilemapNode.setTileGroup(tileGroup, forColumn: col, row: row)
                                    }
                                    else {
                                        fatalError("Unable to find movement indicator.")
                                    }
                                }
                            }
                        }
                    }
                    
                    self.tilemapNode.isHidden = false
                }
                else {
                    self.tilemapNode.isHidden = true

                    for position in self.indicatedPositions {
                        self.tilemapNode.setTileGroup(nil, forColumn: position.col, row: position.row)
                    }
                }
            })
            .store(in: &cancellable)
    }
    
}
