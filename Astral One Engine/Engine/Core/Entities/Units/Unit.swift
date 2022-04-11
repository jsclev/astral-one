import Foundation
import GameplayKit

public class Unit: GKEntity {
    public let playerId: Int
    public let name: String
    public let cost: Int
    public let hp: Int
    public var currentHp: Int
    public let attackRating: Int
    public let defenseRating: Int
    public let firepower: Int
    public let movementPoints: Float
    public var currentMovementPoints: Float
    public let row: Int
    public let col: Int
    
    public init(playerId: Int,
                name: String,
                cost: Int,
                hp: Int,
                attackRating: Int,
                defenseRating: Int,
                firepower: Int,
                movementPoints: Float,
                row: Int,
                col: Int) {
        self.playerId = playerId
        self.name = name
        self.cost = cost
        self.hp = hp
        self.currentHp = hp
        self.attackRating = attackRating
        self.defenseRating = defenseRating
        self.firepower = firepower
        self.movementPoints = movementPoints
        self.currentMovementPoints = movementPoints
        self.row = row
        self.col = col
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func getDiplomacyStatus(between: Unit) -> DiplomacyStatus {
        if playerId == between.playerId {
            return DiplomacyStatus.Same
        }
        
        return DiplomacyStatus.AtWar
    }
    
    public func getDistance(to: Unit) -> Int {
        return abs(row - to.row) + abs(col - to.col) - 1
    }
}
