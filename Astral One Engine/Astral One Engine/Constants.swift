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

public struct Constants {
    public static let terrainTypes: [String: TerrainType] = [
        "0": TerrainType.Grassland,
        "1": TerrainType.Forest,
        "2": TerrainType.Forest,
        "3": TerrainType.Forest,
        "4": TerrainType.Forest,
        "5": TerrainType.Forest,
        "6": TerrainType.Forest,
        "7": TerrainType.Forest,
        "8": TerrainType.Forest,
        "9": TerrainType.Forest,
        "10": TerrainType.Forest,
        "11": TerrainType.Forest,
        "12": TerrainType.Forest,
        "13": TerrainType.Forest,
        "14": TerrainType.Forest,
        "15": TerrainType.Forest,
        "16": TerrainType.Forest,
        "17": TerrainType.Forest,
        "18": TerrainType.Forest,
        "19": TerrainType.Forest,
        "20": TerrainType.Forest,
        "21": TerrainType.Forest,
        "22": TerrainType.Forest,
        "23": TerrainType.Forest
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
        "17": "Forest",
        "18": "Forest",
        "19": "Forest",
        "20": "Forest",
        "21": "Forest",
        "22": "Forest",
        "23": "Forest",
        "24": "Forest",
        "25": "Forest",
        "26": "Forest",
        "27": "Forest",
        "28": "Forest",
        "29": "Forest",
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

