import Foundation

public class SettlerLevel8Agent: SettlerAgent {
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
        var scoreMap: [[Double]] = Array(repeating: Array(repeating: Constants.noScore,
                                                          count: player.map.width),
                                         count: player.map.height)
        
        for row in 0..<player.map.height {
            for col in 0..<player.map.width {
                let position = Position(row: row, col: col)
                let tiles = player.getTilesWithinCityRadius(from: position)
                
                for tile in tiles {
                    if player.map.canBuildCity(at: position) {
                        var score = Double(tile.food)
                        score += Double(tile.production)
                        score += Double(tile.trade)
                        score += tile.defenseBonus
                        
                        scoreMap[row][col] = score
                    }
                }
            }
        }
        
        log(scoreMap: scoreMap)
        
        return scoreMap
    }
    
    public override func getBuildScore(player: Player, tile: Tile) throws -> Double {
        return Double(0.0)
    }
    
}
