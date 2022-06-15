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
        var positions = getBestPositions(scoreMap: scoreMap)
        positions = positions.sorted {
            settler.position.distance(from: $0) < settler.position.distance(from: $1)
        }
        
        print("Found \(positions.count) potential city locations.")
        
        if positions.count > 0 {
            if positions.count == 1 {
                return positions[0]
            }
            else {
                let random = Int.random(in: 0..<positions.count)
                return positions[random]
            }
        }
        
        return nil
    }
    
    private func getBuildCityScoreMap() throws -> [[Double]] {
        var scoreMap: [[Double]] = Array(repeating: Array(repeating: 0.0,
                                                          count: player.map.width),
                                         count: player.map.height)
        
        for row in 0..<player.map.height {
            for col in 0..<player.map.width {
                let position = Position(row: row, col: col)
                let tile = player.map.tile(at: Position(row: row, col: col))
                
                if tile.visibility == Visibility.FullyRevealed {
                    if player.map.canCreateCity(at: position) {
                        let distance = player.map.getDistanceToNearestCity(from: position)
                        let score = 100 - distance
                        
                        if score < 0 {
                            scoreMap[row][col] = 0.0
                        }
                        else if score > 100 {
                            scoreMap[row][col] = 100.0
                        }
                        else {
                            scoreMap[row][col] = Double(score)
                        }
                    }
                    else {
                        scoreMap[row][col] = 0.0
                    }
                }
                else {
                    scoreMap[row][col] = 1.0
                }
                
            }
        }
        
        return scoreMap
    }
    
    public override func getBuildScore(player: Player, tile: Tile) throws -> Double {
        return Double(0.0)
    }
    
}
