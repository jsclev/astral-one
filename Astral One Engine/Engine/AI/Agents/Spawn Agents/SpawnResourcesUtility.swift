import Foundation

public class SpawnResourcesUtility: AgentUtility {
    private let game: Game
    private let maxScore: Double
    
    public init(game: Game,
                maxScore: Double) {
        self.game = game
        self.maxScore = maxScore
    }
    
    public func getUtilityMap() -> [[Utility]] {
        let scoreMap:[[Utility]] = (0..<game.map.width).map { _ in
            (0..<game.map.height).map { _ in
                Utility()
            }
        }
        
        for row in 0..<game.map.height {
            for col in 0..<game.map.width {
                let position = Position(row: row, col: col)
                
                if game.map.canCreateCity(at: position) {
                    var foodScore = 0.0
                    var productionScore = 0.0
                    var tradeScore = 0.0
                    var totalScore = 0.0
                    let tiles = game.map.getTilesInCityRadius(from: position)
                    
                    for tile in tiles {
                        foodScore += Double(tile.food)
                        productionScore += Double(tile.production)
                        tradeScore += Double(tile.trade)
                        totalScore += Double(tile.food + tile.production + tile.trade)
                        
                    }
                    totalScore *= totalScore
                    
                    if totalScore > maxScore {
                        scoreMap[row][col].reasons.append(Reason(reasonType: ReasonType.BasicResources,
                                                                 value: maxScore,
                                                                 message: "Total resources from all tiles in city radius."))
                    }
                    else {
                        scoreMap[row][col].reasons.append(Reason(reasonType: ReasonType.BasicResources,
                                                                 value: totalScore,
                                                                 message: "Total resources from all tiles in city radius."))
                    }
//                    scoreMap[row][col].reasons.append(Reason(reasonType: ReasonType.FoodSource,
//                                                             value: foodScore,
//                                                             message: "Total food from all tiles in city radius."))
//                    scoreMap[row][col].reasons.append(Reason(reasonType: ReasonType.ProductionSource,
//                                                             value: productionScore,
//                                                             message: "Total production from all tiles in city radius."))
//                    scoreMap[row][col].reasons.append(Reason(reasonType: ReasonType.TradeSource,
//                                                             value: tradeScore,
//                                                             message: "Total trade from all tiles in city radius."))
                }
                else {
                    scoreMap[row][col].reasons.append(Reason(reasonType: ReasonType.InvalidCityLocation,
                                                             value: -maxScore,
                                                             message: "Invalid city location."))
                }
            }
        }
        
        return scoreMap
    }
}
