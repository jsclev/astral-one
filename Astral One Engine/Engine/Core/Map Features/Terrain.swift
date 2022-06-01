import Foundation

public class Terrain: Equatable {
    public let id: Int
    public let tiledId: Int
    public let name: String
    public let type: TerrainType
    
    public init(id: Int,
                tiledId: Int,
                name: String,
                type: TerrainType) {
        self.id = id
        self.tiledId = tiledId
        self.name = name
        self.type = type
    }
    
    public var description: String {
        return "{id: \(id), name: \"\(name)\"}"
    }
    
    public static func == (lhs: Terrain, rhs: Terrain) -> Bool {
        return lhs.id == rhs.id
    }
}
