import GameplayKit

class GameNode: GKGridGraphNode {
    public var tile: Tile = Tile()
    
    override init(gridPosition: vector_int2) {
        super.init(gridPosition: gridPosition)
    }
    
    override func cost(to node: GKGraphNode) -> Float {
        if tile.terrainType == TerrainType.Grassland {
            return 3.0
        }
        else if tile.terrainType == TerrainType.Jungle {
            return 3.0
        }
        else if tile.terrainType == TerrainType.Plains {
            return 1.0
        }
        else if tile.terrainType == TerrainType.Desert {
            return 4.0
        }
        else if tile.terrainType == TerrainType.Swamp {
            return 5.0
        }
        else if tile.terrainType == TerrainType.Tundra {
            return 4.0
        }
        else if tile.terrainType == TerrainType.Forest {
            return 5.0
        }
        else if tile.terrainType == TerrainType.Hills {
            return 5.0
        }
        else if tile.terrainType == TerrainType.Mountains {
            return 9999.0
        }
        else if tile.terrainType == TerrainType.Glacier {
            return 7.0
        }
        else if tile.terrainType == TerrainType.River {
            return 9999.0
        }
        else if tile.terrainType == TerrainType.Water {
            return 9999.0
        }
        else {
            return 2.0
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
}
