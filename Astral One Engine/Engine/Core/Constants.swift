import CoreGraphics

public struct Constants {
    public static let noId = 1
    public static let db = Db(fullRefresh: false)
    public static let mapNumTilesHeight = 10
    public static let tileSize = CGSize(width: 128, height: 64)
    public static let mapFilename = "freeland-10x10"
    public static let tilesetName = "freeland"
    public static let themeName = "Sci-Fi"
    public static let minDefense: Double = 0.001
    public static let minMovementCost: Double = 0.0
    public static let mapWidth: CGFloat = 1000.0 / 3.0
    public static let mapHeight: CGFloat = 1000.0 / 3.0
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
        "17": TerrainType.Mountains,
        "18": TerrainType.Mountains,
        "19": TerrainType.Hills,
        "20": TerrainType.Forest,
        "21": TerrainType.Unknown,
        "22": TerrainType.Ocean,
        "23": TerrainType.Unknown,
        "24": TerrainType.Ocean,
        "47": TerrainType.Glacier,
        "49": TerrainType.Plains
    ]
    
    public static let specialResources: [String: SpecialResource] = [
        "28": SpecialResource.Wine,
        "29": SpecialResource.Wine,
        "30": SpecialResource.Wine,
        "31": SpecialResource.Wine,
        "32": SpecialResource.Wine,
        "33": SpecialResource.Wine,
        "34": SpecialResource.Wine,
        "35": SpecialResource.Wine,
        "36": SpecialResource.Wine,
        "37": SpecialResource.Wine,
        "38": SpecialResource.Wine,
        "39": SpecialResource.Wine,
        "40": SpecialResource.Wine,
        "41": SpecialResource.Wine,
        "42": SpecialResource.Wine,
        "43": SpecialResource.Wine,
        "44": SpecialResource.Wine,
        "45": SpecialResource.Wine,
        "46": SpecialResource.Wine,
        "48": SpecialResource.Wine,
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
}

