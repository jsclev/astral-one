import Foundation

public struct TileDef {
    let tileType: TileType
    let terrainType: TerrainType
    let unitType: UnitType
}

public enum TileType {
    case Unknown
    case Resource
    case Terrain
    case Unit
}

public enum TerrainType {
    case None
    case Desert
    case Forest
    case Glacier
    case Grassland
    case Hills
    case Jungle
    case Mountains
    case Ocean
    case Plains
    case River
    case Swamp
    case Tank
    case Tundra
    case Water
}

public enum UnitType {
    case None
    case Battleship
    case Bomber
    case Chariot
    case Tank
}

public struct Tile {
    public var id: String = ""
    public var spec: TileDef
    public var ordinal: Int = 0
}
