import Foundation

public struct PlayStyle {
    public let offense: Double
    public let defense: Double
    
    public init(offense: Double,
                defense: Double) {
        self.offense = offense
        self.defense = defense
    }
}
