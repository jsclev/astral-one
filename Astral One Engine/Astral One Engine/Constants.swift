import CoreGraphics

public enum Layer {
    public static let base: CGFloat = 0.0
    public static let terrain: CGFloat = 100.0
    public static let cities: CGFloat = 200.0
    public static let units: CGFloat = 300.0
    public static let unitPath: CGFloat = 400.0
    public static let unitPath2: CGFloat = 450.0
    public static let hud: CGFloat = 500.0
    public static let foreground: CGFloat = 600.0
}

public enum unitType {
    case Explorer
    case Settler
    case Tank
}

public struct Constants {
    public static let mapWidth: CGFloat = 1000.0 / 3.0
    public static let mapHeight: CGFloat = 1000.0 / 3.0
    public static let terrainTypes: [String: TileDef] = [
        "0": TileDef(tileType: TileType.Terrain,
                     terrainType: TerrainType.Grassland,
                     unitType: UnitType.None),
        "1": TileDef(tileType: TileType.Terrain,
                     terrainType: TerrainType.Forest,
                     unitType: UnitType.None),
        "2": TileDef(tileType: TileType.Terrain,
                     terrainType: TerrainType.Forest,
                     unitType: UnitType.None),
        "3": TileDef(tileType: TileType.Terrain,
                     terrainType: TerrainType.Forest,
                     unitType: UnitType.None),
        "4": TileDef(tileType: TileType.Terrain,
                     terrainType: TerrainType.Forest,
                     unitType: UnitType.None),
        "5": TileDef(tileType: TileType.Terrain,
                     terrainType: TerrainType.Forest,
                     unitType: UnitType.None),
        "6": TileDef(tileType: TileType.Terrain,
                     terrainType: TerrainType.Forest,
                     unitType: UnitType.None),
        "7": TileDef(tileType: TileType.Terrain,
                     terrainType: TerrainType.Forest,
                     unitType: UnitType.None),
        "8": TileDef(tileType: TileType.Terrain,
                     terrainType: TerrainType.Forest,
                     unitType: UnitType.None),
        "9": TileDef(tileType: TileType.Terrain,
                     terrainType: TerrainType.Forest,
                     unitType: UnitType.None),
        "10": TileDef(tileType: TileType.Terrain,
                      terrainType: TerrainType.Forest,
                      unitType: UnitType.None),
        "11": TileDef(tileType: TileType.Terrain,
                      terrainType: TerrainType.Forest,
                      unitType: UnitType.None),
        "12": TileDef(tileType: TileType.Terrain,
                      terrainType: TerrainType.Forest,
                      unitType: UnitType.None),
        "13": TileDef(tileType: TileType.Terrain,
                      terrainType: TerrainType.Forest,
                      unitType: UnitType.None),
        "14": TileDef(tileType: TileType.Terrain,
                      terrainType: TerrainType.Forest,
                      unitType: UnitType.None),
        "15": TileDef(tileType: TileType.Terrain,
                      terrainType: TerrainType.Forest,
                      unitType: UnitType.None),
        "16": TileDef(tileType: TileType.Terrain,
                      terrainType: TerrainType.Forest,
                      unitType: UnitType.None),
        "17": TileDef(tileType: TileType.Terrain,
                      terrainType: TerrainType.Mountains,
                      unitType: UnitType.None),
        "18": TileDef(tileType: TileType.Terrain,
                      terrainType: TerrainType.Mountains,
                      unitType: UnitType.None),
        "19": TileDef(tileType: TileType.Terrain,
                      terrainType: TerrainType.Hills,
                      unitType: UnitType.None),
        "20": TileDef(tileType: TileType.Terrain,
                      terrainType: TerrainType.Forest,
                      unitType: UnitType.None),
        "21": TileDef(tileType: TileType.Terrain,
                      terrainType: TerrainType.Forest,
                      unitType: UnitType.None),
        "22": TileDef(tileType: TileType.Terrain,
                      terrainType: TerrainType.Forest,
                      unitType: UnitType.None),
        "23": TileDef(tileType: TileType.Terrain,
                      terrainType: TerrainType.Forest,
                      unitType: UnitType.None),
        "24": TileDef(tileType: TileType.Terrain,
                      terrainType: TerrainType.Water,
                      unitType: UnitType.None),
        "25": TileDef(tileType: TileType.Unit,
                      terrainType: TerrainType.None,
                      unitType: UnitType.Tank),
        "26": TileDef(tileType: TileType.Unit,
                      terrainType: TerrainType.None,
                      unitType: UnitType.Battleship),
        "27": TileDef(tileType: TileType.Unit,
                      terrainType: TerrainType.None,
                      unitType: UnitType.Explorer)
    ]
    
    public static let tiles: [String: String] = [
        "0": "Grass",
        "1": "Forest",
        "2": "Forest",
        "3": "Forest",
        "4": "Forest",
        "5": "Forest",
        "6": "Forest",
        "7": "Forest",
        "8": "Forest",
        "9": "Forest",
        "10": "Forest",
        "11": "Forest",
        "12": "Forest",
        "13": "Forest",
        "14": "Forest",
        "15": "Forest",
        "16": "Forest",
        "17": "Mountain",
        "18": "Mountain",
        "19": "Hills",
        "20": "Forest",
        "21": "Forest",
        "22": "Forest",
        "23": "Forest",
        "24": "Water",
        "25": "Tank",
        "26": "Battleship",
        "27": "Explorer",
//        "28": "Forest",
//        "29": "Forest",
    ]
    
//    public static let terrainTypes: [String: TerrainType] = [
//        "0": TerrainType.Water,
//        "1": TerrainType.Tundra,
//        "2": TerrainType.Water,
//        "3": TerrainType.Water,
//        "4": TerrainType.Swamp,
//        "5": TerrainType.Glacier,
//        "6": TerrainType.Desert,
//        "7": TerrainType.Water,
//        "8": TerrainType.Plains,
//        "9": TerrainType.Jungle,
//        "10": TerrainType.Grassland,
//        "11": TerrainType.Water
//    ]
//
//    public static let tiles: [String: String] = [
//        "0": "Water",
//        "1": "Tundra",
//        "2": "Town",
//        "3": "Tank",
//        "4": "Swamp",
//        "5": "Snow",
//        "6": "Sand",
//        "7": "Plane",
//        "8": "Plains",
//        "9": "Jungle",
//        "10": "Grass",
//        "11": "Fog"
//    ]
}

