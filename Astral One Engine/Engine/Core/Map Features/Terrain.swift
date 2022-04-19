import Foundation

public class Terrain: Equatable {
    public let id: Int
    public let type: TerrainType
    public let food: Double
    public let shields: Double
    public let trade: Double
    public let movementCost: Double
    
    public init(id: Int,
                type: TerrainType,
                food: Double,
                shields: Double,
                trade: Double,
                movementCost: Double) {
        self.id = id
        self.type = type
        self.food = food
        self.shields = shields
        self.trade = trade
        self.movementCost = movementCost
    }
    
    public static func == (lhs: Terrain, rhs: Terrain) -> Bool {
        return lhs.type == rhs.type
    }
}
