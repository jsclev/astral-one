import Foundation

public struct TileDef {
    public let tileType: TileType
    public let terrainType: TerrainType
    public let unitType: UnitType
    
    public init(tileType: TileType, terrainType: TerrainType, unitType: UnitType) {
        self.tileType = tileType
        self.terrainType = terrainType
        self.unitType = unitType
    }
}

public enum TileType {
    case Unknown
    case Resource
    case Terrain
    case Unit
}

public struct Tile {
    public var id: String = ""
    public var spec: TileDef
    public var ordinal: Int = 0
    
    public init(id: String, spec: TileDef, ordinal: Int) {
        self.id = id
        self.spec = spec
        self.ordinal = ordinal
    }
}
