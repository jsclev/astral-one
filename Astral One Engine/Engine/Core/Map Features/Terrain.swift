import Foundation

public class Terrain {
    public let name: String
    public let food: Double
    public let shields: Double
    public let trade: Double
    public let movementCost: Double
    
    public init(name: String, food: Double, shields: Double, trade: Double, movementCost: Double) {
        self.name = name
        self.food = food
        self.shields = shields
        self.trade = trade
        self.movementCost = movementCost
    }
}
