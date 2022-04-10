import Foundation
import GameplayKit

public class Unit: GKEntity {
    let playerId: Int
    let name: String
    let maxHP: Int
    let row: Int
    let col: Int
    
    public init(playerId: Int, name: String, maxHP: Int, row: Int, col: Int) {
        self.playerId = playerId
        self.name = name
        self.maxHP = maxHP
        self.row = row
        self.col = col
        
        super.init()
    }
    
    public func getDiplomacyStatus(otherUnit: Unit) -> DiplomacyStatus {
        if playerId == otherUnit.playerId {
            return DiplomacyStatus.Same
        }
        
        return DiplomacyStatus.AtWar
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
