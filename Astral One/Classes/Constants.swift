import CoreGraphics

enum ImageName {
    static let background = "Background"
    static let ground = "Ground"
    static let water = "Water"
    static let vineTexture = "VineTexture"
    static let vineHolder = "VineHolder"
    static let crocMouthClosed = "CrocMouthClosed"
    static let energy = "energy"
}

enum SoundFile {
    static let backgroundMusic = "Background4.m4a"
    static let slice = "Slice.caf"
    static let splash = "Splash.caf"
    static let nomNom = "NomNom.caf"
}

enum Layer {
    static let base: CGFloat = 0
    static let terrain: CGFloat = 1
    static let overlays: CGFloat = 2
    static let hudStats: CGFloat = 3
    static let foreground: CGFloat = 4
}

enum PhysicsCategory {
    static let crocodile: UInt32 = 1
    static let vineHolder: UInt32 = 2
    static let vine: UInt32 = 4
    static let prize: UInt32 = 8
}

enum GameConfiguration {
    static let vineDataFile = "VineData.plist"
    static let canCutMultipleVinesAtOnce = false
}

var terrainTiles: [String: String] = [
    "0": "scrubland03",
    "1": "scrubland02",
    "2": "scrubland01",
    "3": "scrubland00",
    "4": "woodlands03",
    "5": "woodlands02",
    "6": "woodlands01",
    "7": "woodlands00",
    "8": "highlands03",
    "9": "highlands02",
    "10": "highlands01",
    "11": "highlands00",
    "12": "mountain03",
    "13": "mountain02",
    "14": "mountain01",
    "15": "mountain00",
    "16": "forestBroadleaf00",
    "17": "forestBroadleaf01",
    "18": "forestBroadleaf02",
    "19": "forestBroadleaf03",
    "20": "base00",
    "21": "base01",
    "22": "base02",
    "23": "base03",
    "24": "hills00",
    "25": "hills01",
    "26": "hills02",
    "27": "hills03",
    "28": "void03",
    "29": "void02",
    "30": "void00",
    "31": "void01",
    "32": "dirt00",
    "33": "dirt01",
    "34": "dirt02",
    "35": "dirt03",
    "36": "marsh03",
    "37": "marsh02",
    "38": "marsh01",
    "39": "marsh00",
    "40": "desertDunes03",
    "41": "desertDunes02",
    "42": "desertDunes01",
    "43": "desertDunes00",
    "44": "ocean03",
    "45": "ocean02",
    "46": "ocean01",
    "47": "ocean00",
    "48": "plains03",
    "49": "plains02",
    "50": "plains01",
    "51": "plains00"
]

