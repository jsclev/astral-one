import GameplayKit

public class GameNode: GKGridGraphNode {
    private var tiles: [Tile] = []
    
    override init(gridPosition: vector_int2) {
        super.init(gridPosition: gridPosition)
    }
    
    override public func cost(to node: GKGraphNode) -> Float {
        var cost: Float = 0.0
        
        for tile in tiles {
            if tile.terrainType == TerrainType.Grassland {
                cost += 1.0
            }
            else if tile.terrainType == TerrainType.Jungle {
                cost += 2.0
            }
            else if tile.terrainType == TerrainType.Plains {
                cost += 1.0
            }
            else if tile.terrainType == TerrainType.Desert {
                cost += 1.0
            }
            else if tile.terrainType == TerrainType.Swamp {
                cost += 2.0
            }
            else if tile.terrainType == TerrainType.Tundra {
                cost += 1.0
            }
            else if tile.terrainType == TerrainType.Forest {
                cost += 2.0
            }
            else if tile.terrainType == TerrainType.Hills {
                cost += 2.0
            }
            else if tile.terrainType == TerrainType.Mountains {
                cost += 3.0
            }
            else if tile.terrainType == TerrainType.Glacier {
                cost += 2.0
            }
            else if tile.terrainType == TerrainType.River {
                cost += 9999.0
            }
            else if tile.terrainType == TerrainType.Water {
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
        
        tiles.append(tile)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
}
