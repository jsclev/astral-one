import Foundation
import CoreGraphics

public class SpawnProximityUtility: AgentUtility {
    private let game: Game
    private let maxScore: Double
    private let center: Position
    
    public init(game: Game, maxScore: Double, center: Position) {
        self.game = game
        self.maxScore = maxScore
        self.center = center
    }
    
    public func getUtilityMap() -> [[Utility]] {
        let scoreMap:[[Utility]] = (0..<game.map.width).map { _ in (0..<game.map.height).map { _ in Utility() } }
        
        for row in 0..<game.map.height {
            for col in 0..<game.map.width {
                let position = Position(row: row, col: col)
                scoreMap[row][col].reasons.append(getReason(position: position))
            }
        }
        
        return scoreMap
    }
    
    private func getReason(position: Position) -> Reason {
        var penalty = -1.0 * maxScore
        
        if game.map.canCreateCity(at: position) {
            // We'll use a quadratic curve for the penalty
            let distanceToCenter = Double(position.distance(to: center))
            let m = 3.0
            let k = 4.0
            penalty = -1.0 * pow((distanceToCenter / m), k)
            
            if penalty < -maxScore {
                penalty = -maxScore
            }
            
            return Reason(reasonType: ReasonType.ProximityToNearestCity,
                          value: penalty,
                          message: "Total food from all tiles in city radius.")
        }
        
        return Reason(reasonType: ReasonType.InvalidCityLocation,
                      value: penalty,
                      message: "Invalid city location.")
    }
}
