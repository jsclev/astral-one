import Foundation

public class City {
    public let playerId: Int
    public let name: String
    public let row: Int
    public let col: Int
    
    public init(playerId: Int, name: String, row: Int, col: Int) {
        self.playerId = playerId
        self.name = name
        self.row = row
        self.col = col
    }
    
    public func getDiplomacyStatus(unit: Unit) -> DiplomacyStatus {
        if playerId == unit.playerId {
            return DiplomacyStatus.Same
        }
        
        return DiplomacyStatus.AtWar
    }
    
    public func getDistance(toUnit: Unit) -> Int {
        return abs(row - toUnit.row) + abs(col - toUnit.col) - 1
    }
}
