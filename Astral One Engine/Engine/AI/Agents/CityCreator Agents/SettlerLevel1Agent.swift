import Foundation

public class SettlerLevel1Agent: SettlerAgent {
    public override init(player: AIPlayer, settler: Settler) throws {
        try super.init(player: player, settler: settler)
    }
    
    private func getSettleCityScore(tile: Tile) throws -> Double {
        return Double(0.0)
    }
    
    public override func getSettleCityPosition() throws -> PositionScore? {
        let scoreMap = try getBuildCityScoreMap()
        var positions: [PositionScore] = []
        
        var maxScore = 0.0
        
        for row in 0..<player.map.height {
            for col in 0..<player.map.width {
                if scoreMap[row][col].value > maxScore {
                    maxScore = scoreMap[row][col].value
                    
                    positions.append(PositionScore(position: Position(row: row, col: col),
                                                   score: scoreMap[row][col]))
                }
            }
        }
        
        if let bestPosition = positions.last {
            return bestPosition
        }
        
        return nil
    }
    
    private func getBuildCityScoreMap() throws -> [[Score]] {
        let scoreMap: [[Score]] = Array(repeating: Array(repeating: Score(),
                                                          count: player.map.width),
                                         count: player.map.height)
        let scoreMap2 = analyzers[0].getScoreMap()
        
        for row in 0..<player.map.height {
            for col in 0..<player.map.width {
                let position = Position(row: row, col: col)
                let tile = player.map.tile(at: Position(row: row, col: col))
                
                if tile.visibility == Visibility.FullyRevealed {
                    if player.map.canCreateCity(at: position) {
                        scoreMap[row][col].reasons.append(Reason(reasonType: ReasonType.FoodSource,
                                                                 value: tile.score,
                                                                 message: ""))
                    }
                    else {
                        scoreMap[row][col].reasons.append(Reason(reasonType: ReasonType.InvalidCityLocation,
                                                                 value: 0,
                                                                 message: ""))
                    }
                }
                else {
                    
                    scoreMap[row][col].reasons.append(Reason(reasonType: ReasonType.TileNotRevealed,
                                                             value: 1,
                                                             message: ""))
                }
                
                // scoreMap[row][col].reasons.append(contentsOf: scoreMap2[row][col].reasons)
            }
        }
        
        return scoreMap
    }
    
    public override func getBuildScore(player: Player, tile: Tile) throws -> Double {
        return Double(0.0)
    }
    
}
