import Foundation
import GameplayKit

public class Unit: GKEntity {
    public let playerId: Int
    public let name: String
    public let cost: Double
    public let maxHp: Double
    public var currentHp: Double
    public let attackRating: Double
    public let defenseRating: Double
    public let fp: Double
    public let maxMovementPoints: Double
    public var currentMovementPoints: Double
    public let row: Int
    public let col: Int
    
    public init(playerId: Int,
                name: String,
                cost: Double,
                maxHp: Double,
                attackRating: Double,
                defenseRating: Double,
                fp: Double,
                maxMovementPoints: Double,
                row: Int,
                col: Int) {
        self.playerId = playerId
        self.name = name
        self.cost = cost
        self.maxHp = maxHp
        self.currentHp = maxHp
        self.attackRating = attackRating
        self.defenseRating = defenseRating
        self.fp = fp
        self.maxMovementPoints = maxMovementPoints
        self.currentMovementPoints = maxMovementPoints
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
    
    public func getChebyshevDistance(to: Unit) -> Int {
        // This is also known as the "Chessboard distance"
        let xDistance = abs(to.col - col)
        let yDistance = abs(to.row - row)
        
        return max(xDistance, yDistance)
    }
}
