import Foundation

public class SettlerLevel2Agent: SettlerAgent {
    public override init(player: AIPlayer, settler: Settler) throws {
        try super.init(player: player, settler: settler)
    }
    
    private func getSettleCityScore(tile: Tile) throws -> Double {
        return Double(0.0)
    }
    
    private func getBuildCityScoreMap() throws -> [[Double]] {
        var scoreMap: [[Double]] = Array(repeating: Array(repeating: 0.0,
                                                          count: player.map.width),
                                         count: player.map.height)
        
        for row in 0..<player.map.height {
            for col in 0..<player.map.width {
                let position = Position(row: row, col: col)
                let tile = player.map.tile(at: position)
                
                if tile.visibility == Visibility.FullyRevealed {
                    if player.map.canCreateCity(at: position) {
                        var score = Double(tile.food)
                        score += Double(tile.production)
                        score += Double(tile.trade)
                        score += tile.defenseBonus
                        
                        if score < 0.0 {
                            scoreMap[row][col] = 0.0
                        }
                        else {
                            scoreMap[row][col] = score
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
