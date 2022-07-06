import Foundation

public class AIStrategy {
    public let offense: Double
    public let defense: Double
    public let cityQuantity: Double
    
    public convenience init() {
        self.init(offense: 50.0,
                  defense: 50.0,
             cityQuantity: 50.0)
    }
    
    public init(offense: Double,
                defense: Double,
                cityQuantity: Double) {
        self.offense = offense
        self.defense = defense
        self.cityQuantity = cityQuantity
    }
}
