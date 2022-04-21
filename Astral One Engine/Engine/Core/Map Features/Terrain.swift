import Foundation

public class Terrain: Equatable {
    public let id: Int
    public let tiledId: Int
    public let name: String
    public let type: TerrainType
    public let food: Double
    public let shields: Double
    public let trade: Double
    public let movementCost: Double
    
    public init(id: Int,
                tiledId: Int,
                name: String,
                type: TerrainType,
                food: Double,
                shields: Double,
                trade: Double,
                movementCost: Double) {
        self.id = id
        self.tiledId = tiledId
        self.name = name
        self.type = type
        self.food = food
        self.shields = shields
        self.trade = trade
        self.movementCost = movementCost
    }
    
    public var description: String {
        return "{id: \(id), name: \"\(name)\", food: \(food), " +
        "shields: \(shields), trade: \(trade), movementCost: \(movementCost)}"
    }
    
    public static func == (lhs: Terrain, rhs: Terrain) -> Bool {
        return lhs.id == rhs.id
    }
}
