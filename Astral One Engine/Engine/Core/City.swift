import Foundation

public class City {
    public let player: Player
    public let name: String
    public let assetName: String
    public let position: Position
    
    public init(theme: Theme,
                player: Player,
                name: String,
                assetName: String,
                position: Position) {
        self.player = player
        self.name = name
        self.assetName = theme.name + "/Cities/" + assetName
        self.position = position
    }
    
    public func getDiplomacyStatus(unit: Unit) -> DiplomacyStatus {
        if player.playerId == unit.playerId {
            return DiplomacyStatus.Same
        }
        
        return DiplomacyStatus.AtWar
    }
    
    public func getDistance(to: Unit) -> Int {
        return abs(position.row - to.position.row) + abs(position.col - to.position.col) - 1
    }
}
