import Foundation

public struct PlayerDiff {
    public let attack: Double
    public let defense: Double
    public let defenseAgainstGroundAttacks: Double
    
    public init(attack: Double,
                defense: Double,
                defenseAgainstGroundAttacks: Double) {
        self.attack = attack
        self.defense = defense
        self.defenseAgainstGroundAttacks = defenseAgainstGroundAttacks
    }
}
