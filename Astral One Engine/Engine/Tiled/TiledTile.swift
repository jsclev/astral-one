import Foundation

public class TiledTerrain {
    public let id: String
    public let terrainType: TerrainType
    
    public init(id: String, terrainType: TerrainType) {
        self.id = id
        self.terrainType = terrainType
    }
}

public class TiledSpecialResource {
    public let id: String
    public let specialResource: SpecialResourceType
    
    public init(id: String, specialResource: SpecialResourceType) {
        self.id = id
        self.specialResource = specialResource
    }
}
