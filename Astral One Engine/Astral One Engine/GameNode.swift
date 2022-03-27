import GameplayKit

public class GameNode: GKGridGraphNode {
    private var tiles: [Tile] = []
    private var enemyAttack: Float = 0.0
    private var enemyDefense: Float = 0.0
    private var avgEnemyMovement: Float = 0.0
    
    override init(gridPosition: vector_int2) {
        super.init(gridPosition: gridPosition)
    }
    
    override public func cost(to node: GKGraphNode) -> Float {
        for item in connectedNodes {
            if let connectedNode = item as? GameNode {
                print("Num tiles: \(connectedNode.getTiles().count)") }
        }
        var cost: Float = 0.0
        
        for tile in tiles {
            if tile.spec.terrainType == TerrainType.Grassland {
                cost += 1.0
            }
            else if tile.spec.terrainType == TerrainType.Jungle {
                cost += 2.0
            }
            else if tile.spec.terrainType == TerrainType.Plains {
                cost += 1.0
            }
            else if tile.spec.terrainType == TerrainType.Desert {
                cost += 1.0
            }
            else if tile.spec.terrainType == TerrainType.Swamp {
                cost += 2.0
            }
            else if tile.spec.terrainType == TerrainType.Tundra {
                cost += 1.0
            }
            else if tile.spec.terrainType == TerrainType.Forest {
                cost += 2.0
            }
            else if tile.spec.terrainType == TerrainType.Hills {
                cost += 2.0
            }
            else if tile.spec.terrainType == TerrainType.Mountains {
                cost += 3.0
            }
            else if tile.spec.terrainType == TerrainType.Glacier {
                cost += 2.0
            }
            else if tile.spec.terrainType == TerrainType.River {
                cost += 9999.0
            }
            else if tile.spec.terrainType == TerrainType.Water {
                cost += 9999.0
            }
            else {
                cost += 9999.0
            }
        }
        
        return cost
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
                enemyAttack += 10.0
                enemyDefense += 5.0
            }
        }
        
        tiles.append(tile)
    }
    
    public func getEnemyAttack() -> Float {
        return enemyAttack
    }
    
    public func getEnemyDefense() -> Float {
        return enemyDefense
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
}
