import Foundation

public class SettlerLevel1Agent: SettlerAgent {
    public override init(player: AIPlayer, settler: Settler) throws {
        try super.init(player: player, settler: settler)
    }
    
    private func getSettleCityScore(tile: Tile) throws -> Double {
        return Double(0.0)
    }
    
    public override func getSettleCityPosition() throws -> Position? {
        let scoreMap = try getBuildCityScoreMap()
        var positions: [Position] = []
        
        var maxScore = 0.0
        
        for row in 0..<player.map.height {
            for col in 0..<player.map.width {
                if scoreMap[row][col] > maxScore {
                    maxScore = scoreMap[row][col]
                    positions.append(Position(row: row, col: col))
                }
            }
        }
        
        if let bestPosition = positions.last {
            return bestPosition
        }
//        positions = positions.sorted {
//            settler.position.distance(from: $0) < settler.position.distance(from: $1)
//        }
//
//        print("Found \(positions.count) potential city locations.")
//
//        if positions.count > 0 {
//            if positions.count == 1 {
//                return positions[0]
//            }
//            else {
//                let random = Int.random(in: 0..<positions.count)
//                return positions[random]
//            }
//        }
        
        return nil
    }
    
    private func getBuildCityScoreMap() throws -> [[Double]] {
        var scoreMap: [[Double]] = Array(repeating: Array(repeating: 0.0,
                                                          count: player.map.width),
                                         count: player.map.height)
        let scoreMap2 = cityProximity.process()
        
        for row in 0..<player.map.height {
            for col in 0..<player.map.width {
                let position = Position(row: row, col: col)
                let tile = player.map.tile(at: Position(row: row, col: col))
                
                if tile.visibility == Visibility.FullyRevealed {
                    if player.map.canCreateCity(at: position) {
                        scoreMap[row][col] = Double(tile.score)
                    }
                    else {
                        scoreMap[row][col] = 0.0
                    }
                }
                else {
                    scoreMap[row][col] = 1.0
                }
                
                scoreMap[row][col] += scoreMap2[row][col]
            }
        }
        
        return scoreMap
    }
    
    public override func getBuildScore(player: Player, tile: Tile) throws -> Double {
        return Double(0.0)
    }
    
}
