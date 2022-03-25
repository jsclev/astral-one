import CoreGraphics

public enum Layer {
    public static let base: CGFloat = 0.0
    public static let terrain: CGFloat = 1.0
    public static let cities: CGFloat = 2.0
    public static let units: CGFloat = 3.0
    public static let unitPath: CGFloat = 4.0
    public static let unitPath2: CGFloat = 4.5
    public static let hud: CGFloat = 5.0
    public static let foreground: CGFloat = 6.0
}

public struct Constants {
    public static let terrainTypes: [String: TerrainType] = [
        "0": TerrainType.Grassland,
        "1": TerrainType.Grassland,
        "2": TerrainType.Grassland,
        "3": TerrainType.Grassland,
        "4": TerrainType.Grassland,
        "5": TerrainType.Grassland,
        "6": TerrainType.Grassland,
        "7": TerrainType.Grassland,
        "8": TerrainType.Grassland,
        "9": TerrainType.Grassland,
        "10": TerrainType.Grassland,
        "11": TerrainType.Grassland
    ]
    
    public static let tiles: [String: String] = [
        "0": "Grass",
        "1": "Grass",
        "2": "Grass",
        "3": "Grass",
        "4": "Grass",
        "5": "Grass",
        "6": "Grass",
        "7": "Grass",
        "8": "Grass",
        "9": "Grass",
        "10": "Grass",
        "11": "Grass"
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

