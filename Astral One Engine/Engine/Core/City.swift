import Foundation

public class City {
    public let playerId: Int
    public let name: String
    public let assetName: String
    public let row: Int
    public let col: Int
    
    public init(playerId: Int,
                name: String,
                assetName: String,
                row: Int,
                col: Int) {
        self.playerId = playerId
        self.name = name
        self.assetName = Constants.theme + "/Cities/" + assetName
        self.row = row
        self.col = col
    }
    
    public func getDiplomacyStatus(unit: Unit) -> DiplomacyStatus {
        if playerId == unit.playerId {
            return DiplomacyStatus.Same
        }
        
        return DiplomacyStatus.AtWar
    }
    
    public func getDistance(to: Unit) -> Int {
        return abs(row - to.row) + abs(col - to.col) - 1
    }
}
