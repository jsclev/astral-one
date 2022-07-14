import Foundation

public class SettlerLevel8Agent: SettlerAgent {
    public override init(player: AIPlayer, settler: Settler) throws {
        try super.init(player: player, settler: settler)
    }
    
    private func getSettleCityScore(tile: Tile) throws -> Double {
        return Double(0.0)
    }
    
    public override func getSettleCityPosition() throws -> PositionScore? {
        let scoreMap = try getBuildCityScores()
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
    
    private func getBuildCityScores() throws -> [[Score]] {
        let scoreMap:[[Score]] = (0..<player.map.width).map { _ in (0..<player.map.height).map { _ in Score() } }

        let scoreMap0 = analyzers[0].getScoreMap()
        let scoreMap1 = analyzers[1].getScoreMap()
        let scoreMap2 = analyzers[2].getScoreMap()
        let scoreMap3 = analyzers[3].getScoreMap()
        let scoreMap4 = analyzers[4].getScoreMap()

        for row in 0..<player.map.height {
            for col in 0..<player.map.width {
                scoreMap[row][col].reasons += scoreMap0[row][col].reasons
                scoreMap[row][col].reasons += scoreMap1[row][col].reasons
                scoreMap[row][col].reasons += scoreMap2[row][col].reasons
                scoreMap[row][col].reasons += scoreMap3[row][col].reasons
                scoreMap[row][col].reasons += scoreMap4[row][col].reasons
            }
        }
        
        // log(scoreMap: scoreMap)
        
        return scoreMap
    }
    
    public override func getBuildScore(player: Player, tile: Tile) throws -> Double {
        return Double(0.0)
    }
    
}
