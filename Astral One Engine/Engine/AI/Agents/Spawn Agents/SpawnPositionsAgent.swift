import Foundation

public class SpawnPositionsAgent {
    internal let game: Game
    internal var playerScorers: [AIPlayer:[AgentUtility]] = [:]
    
    public init(game: Game) throws {
        self.game = game
        
        for player in game.players {
            playerScorers[player] = [
                SpawnResourcesUtility(game: game, aiPlayer: player, maxScore: 10.0),
                SpawnWaterUtility(game: game, aiPlayer: player, maxScore: 10.0),
                SpawnProximityUtility(game: game, aiPlayer: player, maxScore: 10.0)
            ]
        }
    }
    
    public func getSpawnPositions() throws -> [AIPlayer:PositionUtility] {
        var startingPositions: [AIPlayer:PositionUtility] = [:]
        
        for player in game.players {
            let utilityMap = try getCityUtilityMap(player: player)
            var positions: [PositionUtility] = []
            
            var maxScore = 0.0
            
            for row in 0..<player.map.height {
                for col in 0..<player.map.width {
                    if utilityMap[row][col].score > maxScore {
                        maxScore = utilityMap[row][col].score
                        
                        positions.append(PositionUtility(position: Position(row: row, col: col),
                                                         utility: utilityMap[row][col]))
                    }
                }
            }
            
            if let bestPosition = positions.last {
                bestPosition.utility.reasons = bestPosition.utility.reasons.sorted(by: {
                    $0.score > $1.score
                })
                
                print("Best position for \(player.name) is \(bestPosition.position)")
                
                startingPositions[player] = bestPosition
            }
        }
        
        return startingPositions
    }
    
    private func getCityUtilityMap(player: AIPlayer) throws -> [[Utility]] {
        let utilityMap:[[Utility]] = (0..<player.map.width).map {
            _ in (0..<player.map.height).map {
                _ in Utility()
            }
        }
        
        if let scorers = playerScorers[player] {
            let utilityMap0 = scorers[0].getUtilityMap()
            let utilityMap1 = scorers[1].getUtilityMap()
            let utilityMap2 = scorers[2].getUtilityMap()
            
            // TODO: Add scorer to boost river tiles if there are few rivers on the map.
            // TODO: Add scorer to boost coastal tiles if there are few ocean tiles on the map.
            
            for row in 0..<game.map.height {
                for col in 0..<game.map.width {
                    utilityMap[row][col].reasons += utilityMap0[row][col].reasons
                    utilityMap[row][col].reasons += utilityMap1[row][col].reasons
                    utilityMap[row][col].reasons += utilityMap2[row][col].reasons
                    
                    //                    if utilityMap[row][col].reasons.count > 0 {
                    //                        let utility = utilityMap[row][col]
                    //                        print(utility)
                    //                    }
                }
            }
            
            player.agentMap = utilityMap
        }
        
        return utilityMap
    }
    
}
