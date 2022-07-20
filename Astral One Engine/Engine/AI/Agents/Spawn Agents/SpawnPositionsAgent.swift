import Foundation
import CoreGraphics

public class SpawnPositionsAgent {
    private let game: Game
    
    public init(game: Game) throws {
        self.game = game
    }
    
    public func getSpawnPositions() throws -> [AIPlayer:PositionUtility] {
        var startingPositions: [AIPlayer:PositionUtility] = [:]
        var center = Position.zero
        
        let resourcesUtility = SpawnResourcesUtility(game: game, maxScore: 100.0)
        let waterUtility = SpawnWaterUtility(game: game, maxScore: 100.0)
        
        let resourcesMap = resourcesUtility.getUtilityMap()
        let waterMap = waterUtility.getUtilityMap()
        
        //game.currentPlayer.agentMap = waterMap
        
        for player in game.players {
            let utilityMap:[[Utility]] = (0..<game.map.width).map {
                _ in (0..<game.map.height).map {
                    _ in Utility()
                }
            }
            
            if player.ordinal == 0 {
                center = Position(row: 27, col: 15)
            }
            else if player.ordinal == 1 {
                center = Position(row: 40, col: 27)
            }
            else if player.ordinal == 2 {
                center = Position(row: 54, col: 42)
            }
            else if player.ordinal == 3 {
                center = Position(row: 15, col: 27)
            }
            else if player.ordinal == 4 {
                center = Position(row: 28, col: 40)
            }
            else if player.ordinal == 5 {
                center = Position(row: 42, col: 54)
            }
            
            let proximityUtility = SpawnProximityUtility(game: game,
                                                         maxScore: 5000,
                                                         center: center)
            let proximityMap = proximityUtility.getUtilityMap()
            
            for row in 0..<game.map.height {
                for col in 0..<game.map.width {
                    utilityMap[row][col].reasons += resourcesMap[row][col].reasons
                    utilityMap[row][col].reasons += waterMap[row][col].reasons
                    utilityMap[row][col].reasons += proximityMap[row][col].reasons
                }
            }
            
            if player.ordinal == 1 {
                game.currentPlayer.agentMap = proximityMap
            }
            
            startingPositions[player] = getBestPosition(utilityMap: utilityMap)
        }
        
        return startingPositions
    }
        
    private func getBestPosition(utilityMap: [[Utility]]) -> PositionUtility {
        var bestPosition = PositionUtility(position: Position(row: 0, col: 0),
                                           utility: utilityMap[0][0])
        var maxScore = -Double.greatestFiniteMagnitude

        for row in 0..<game.map.height {
            for col in 0..<game.map.width {
                if utilityMap[row][col].score > maxScore {
                    maxScore = utilityMap[row][col].score

                    bestPosition = PositionUtility(position: Position(row: row, col: col),
                                                     utility: utilityMap[row][col])
                }
            }
        }
        
        return bestPosition
    }
        
}
