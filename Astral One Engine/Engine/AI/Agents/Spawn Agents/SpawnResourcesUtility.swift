import Foundation

public class SpawnResourcesUtility: AgentUtility {
    private let game: Game
    private let aiPlayer: AIPlayer
    private let maxScore: Double
    
    public init(game: Game, aiPlayer: AIPlayer, maxScore: Double) {
        self.game = game
        self.aiPlayer = aiPlayer
        self.maxScore = maxScore
    }
    
    public func getUtilityMap() -> [[Utility]] {
        let scoreMap:[[Utility]] = (0..<game.map.width).map { _ in (0..<game.map.height).map { _ in Utility() } }
        
        for row in 0..<game.map.height {
            for col in 0..<game.map.width {
                let position = Position(row: row, col: col)
                
                if aiPlayer.map.canCreateCity(at: position) {
                    var foodScore = 0.0
                    var productionScore = 0.0
                    var tradeScore = 0.0
                    let tiles = aiPlayer.getTilesInCityRadius(from: position)
                    
                    for tile in tiles {
                        foodScore += Double(tile.food)
                        productionScore += Double(tile.production)
                        tradeScore += Double(tile.trade)
                    }
                    
                    scoreMap[row][col].reasons.append(Reason(reasonType: ReasonType.FoodSource,
                                                             value: foodScore,
                                                             message: "Total food from all tiles in city radius."))
                    scoreMap[row][col].reasons.append(Reason(reasonType: ReasonType.ProductionSource,
                                                             value: productionScore,
                                                             message: "Total production from all tiles in city radius."))
                    scoreMap[row][col].reasons.append(Reason(reasonType: ReasonType.TradeSource,
                                                             value: tradeScore,
                                                             message: "Total trade from all tiles in city radius."))
                }
            }
        }
        
        return scoreMap
    }
    
    private func check(position: Position) -> Double {
        var score = 1.0
        let distance = aiPlayer.map.getDistanceToNearestCity(position: position)
        
        if distance == 1 {
            score = -4.0 * maxScore
        }
        else if distance == 2 {
            score = -3.0 * maxScore
        }
        else if distance == 3 {
            score = -maxScore
        }
        else if distance == 4 {
            score = -maxScore / 3.0
        }
        else if distance == 5 && distance <= 6 {
            score = maxScore
        }
        else {
            score = 0
        }
        
        return score
    }
}
