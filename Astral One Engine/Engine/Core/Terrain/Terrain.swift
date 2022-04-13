import Foundation

public class Terrain {
    public let name: String
    public let food: Float
    public let shields: Float
    public let trade: Float
    public let movementCost: Float
    
    public init(name: String, food: Float, shields: Float, trade: Float, movementCost: Float) {
        self.name = name
        self.food = food
        self.shields = shields
        self.trade = trade
        self.movementCost = movementCost
    }
}
