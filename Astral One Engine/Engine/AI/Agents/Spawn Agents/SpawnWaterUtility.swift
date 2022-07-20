import Foundation

public class SpawnWaterUtility: AgentUtility {
    private let game: Game
    private let maxScore: Double
    
    public init(game: Game, maxScore: Double) {
        self.game = game
        self.maxScore = maxScore
    }
    
    public func getUtilityMap() -> [[Utility]] {
        // TODO: Add scorer to boost river tiles if there are few rivers on the map.
        // TODO: Add scorer to boost coastal tiles if there are few ocean tiles on the map.
        let scoreMap:[[Utility]] = (0..<game.map.width).map { _ in (0..<game.map.height).map { _ in Utility() } }
        
        for row in 0..<game.map.height {
            for col in 0..<game.map.width {
                let position = Position(row: row, col: col)
                let tile = game.map.tile(at: position)
                if game.map.canCreateCity(at: position) {
                    if tile.hasRiver {
                        let reason = Reason(reasonType: ReasonType.OnRiver,
                                            value: maxScore / 2.0,
                                            message: "Tile location is on a river.")
                        scoreMap[row][col].reasons.append(reason)
                    }
                        
                    if game.map.accessToOcean(tile: tile) {
                        let reason = Reason(reasonType: ReasonType.OnCoast,
                                            value: maxScore / 3.0,
                                            message: "Tile is a coastal tile.")
                        scoreMap[row][col].reasons.append(reason)
                    }
                    
                    // If this tile is not on a river, and it's not on the coast,
                    // check the number of river tiles in the city radius, and give
                    // a bonus for other tiles that have rivers on them.  In general,
                    // rivers are very good, so settling in a place where there are
                    // rivers within the city radius, is a good thing.
                    let cityRadiusTiles = game.map.getTilesInCityRadius(from: position)
                    var riverScore = 0.0
                    
                    for aTile in cityRadiusTiles {
                        if aTile.position != position {
                            if aTile.hasRiver {
                                riverScore += maxScore / 30.0
                            }
                        }
                    }
                    
                    if riverScore > 0.0 {
                        let reason = Reason(reasonType: ReasonType.RiverWithinCityRadius,
                                            value: riverScore,
                                            message: "Tile location has rivers within the city radius.")
                        scoreMap[row][col].reasons.append(reason)
                    }
                }
            }
        }
        
        return scoreMap
    }
}
