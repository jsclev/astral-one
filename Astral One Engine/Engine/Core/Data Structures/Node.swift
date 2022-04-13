import Foundation

public class Node: Hashable {
    public let row: Int
    public let col: Int
    
    private var tiles: [Tile] = []
    private var enemyHP: Float = 0.0
    private var enemyLandAttack: Float = 0.0
    private var enemyLandDefense: Float = 0.0
    private var avgEnemyMovement: Float = 0.0
    
    public init(row: Int, col: Int) {
        self.row = row
        self.col = col
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(row)
        hasher.combine(col)
    }
    
    public static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.row == rhs.row && lhs.col == rhs.col
    }
    
    public func getTiles() -> [Tile] {
        return tiles
    }
    
    public func addTile(tile: Tile) {
        if tile.id == "" {
            fatalError("Cannot add tile with empty id.")
        }
        
        let spec = tile.spec
        if spec.tileType == TileType.Unit {
            if tile.spec.terrainType == TerrainType.Tank {
                enemyHP += 3.0
                enemyLandAttack += 10.0
                enemyLandDefense += 5.0
            }
        }
        
        tiles.append(tile)
    }
    
    public func getEnemyLandAttack() -> Float {
        return enemyLandAttack
    }
    
    public func getEnemyLandDefense() -> Float {
        return enemyLandDefense
    }
    
    public func getScore(accordingTo: Unit) -> Float {
        //        var score: Float = 0.0
        let help: Float = 100.0
        let threat: Float = 0.0
        var movementCost: Float = 0.0
        
        for tile in tiles {
            if tile.spec.tileType == TileType.Terrain {
                if tile.spec.terrainType == TerrainType.Forest {
                    movementCost += 1.0
                }
                else {
                    movementCost += 1.0
                }
            }
        }
        
        return help - 5.0 * movementCost - threat
    }

}
