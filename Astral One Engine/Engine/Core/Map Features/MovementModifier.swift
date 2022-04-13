import Foundation

public class MovementModifier {
    public let name: String
    public let movementCost: Double
    
    public init(name: String, movementCost: Double) {
        self.name = name
        self.movementCost = movementCost
    }
}
