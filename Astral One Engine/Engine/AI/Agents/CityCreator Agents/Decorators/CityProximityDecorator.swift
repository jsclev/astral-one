import Foundation

public class CityProximityDecorator: AgentDecorator {
    private let aiPlayer: AIPlayer
    private let maxScore: Double
    
    public init(aiPlayer: AIPlayer, maxScore: Double) {
        self.aiPlayer = aiPlayer
        self.maxScore = maxScore
    }
    
    public func getScoreMap() -> [[Double]] {
        switch aiPlayer.skillLevel {
        case .One: return getLevel1ScoreMap()
        case .Two: return getLevel2ScoreMap()
        case .Three: return getLevel3ScoreMap()
        case .Four: return getLevel4ScoreMap()
        case .Five: return getLevel5ScoreMap()
        case .Six: return getLevel6ScoreMap()
        case .Seven: return getLevel7ScoreMap()
        case .Eight: return getLevel8ScoreMap()
        }
    }
    
    private func getLevel1ScoreMap() -> [[Double]] {
        var scoreMap: [[Double]] = Array(repeating: Array(repeating: 0.0,
                                                          count: aiPlayer.map.width),
                                         count: aiPlayer.map.height)
        
        for row in 0..<aiPlayer.map.height {
            for col in 0..<aiPlayer.map.width {
                let position = Position(row: row, col: col)
                let tile = aiPlayer.map.tile(at: Position(row: row, col: col))
                
                if tile.visibility == Visibility.FullyRevealed {
                    if aiPlayer.map.canCreateCity(at: position) {
                        let distance = aiPlayer.map.getDistanceToNearestCity(position: position)
                        
                        if distance == 1 {
                            scoreMap[row][col] = 0.5
                        }
                        else if distance == 2 {
                            scoreMap[row][col] = 1.0
                        }
                        else if distance == 3 {
                            scoreMap[row][col] = 2.0
                        }
                        else if distance == 4 {
                            scoreMap[row][col] = 3.0
                        }
                        else if distance == 5 {
                            scoreMap[row][col] = 10.0
                        }
                        else {
                            scoreMap[row][col] = 1.0
                        }
                    }
                    else {
                        scoreMap[row][col] = 0.0
                    }
                }
                else {
                    scoreMap[row][col] = 0.1
                }
                
            }
        }
        
        return scoreMap
    }
    
    private func getLevel2ScoreMap() -> [[Double]] {
        var scoreMap: [[Double]] = Array(repeating: Array(repeating: 0.0,
                                                          count: aiPlayer.map.width),
                                         count: aiPlayer.map.height)
        
        for row in 0..<aiPlayer.map.height {
            for col in 0..<aiPlayer.map.width {
                let position = Position(row: row, col: col)
                let tile = aiPlayer.map.tile(at: Position(row: row, col: col))
                
                if tile.visibility == Visibility.FullyRevealed {
                    if aiPlayer.map.canCreateCity(at: position) {
                        let distance = aiPlayer.map.getDistanceToNearestCity(position: position)
                        
                        if distance == 1 {
                            scoreMap[row][col] = 0.5
                        }
                        else if distance == 2 {
                            scoreMap[row][col] = 1.0
                        }
                        else if distance == 3 {
                            scoreMap[row][col] = 2.0
                        }
                        else if distance == 4 {
                            scoreMap[row][col] = 3.0
                        }
                        else if distance == 5 {
                            scoreMap[row][col] = 10.0
                        }
                        else {
                            scoreMap[row][col] = 1.0
                        }
                    }
                    else {
                        scoreMap[row][col] = 0.0
                    }
                }
                else {
                    scoreMap[row][col] = 0.1
                }
                
            }
        }
        
        return scoreMap
    }
    
    private func getLevel3ScoreMap() -> [[Double]] {
        var scoreMap: [[Double]] = Array(repeating: Array(repeating: 0.0,
                                                          count: aiPlayer.map.width),
                                         count: aiPlayer.map.height)
        
        for row in 0..<aiPlayer.map.height {
            for col in 0..<aiPlayer.map.width {
                let position = Position(row: row, col: col)
                let tile = aiPlayer.map.tile(at: Position(row: row, col: col))
                
                if tile.visibility == Visibility.FullyRevealed {
                    if aiPlayer.map.canCreateCity(at: position) {
                        let distance = aiPlayer.map.getDistanceToNearestCity(position: position)
                        
                        if distance == 1 {
                            scoreMap[row][col] = 0.5
                        }
                        else if distance == 2 {
                            scoreMap[row][col] = 1.0
                        }
                        else if distance == 3 {
                            scoreMap[row][col] = 2.0
                        }
                        else if distance == 4 {
                            scoreMap[row][col] = 3.0
                        }
                        else if distance == 5 {
                            scoreMap[row][col] = 10.0
                        }
                        else {
                            scoreMap[row][col] = 1.0
                        }
                    }
                    else {
                        scoreMap[row][col] = 0.0
                    }
                }
                else {
                    scoreMap[row][col] = 0.1
                }
                
            }
        }
        
        return scoreMap
    }
    
    private func getLevel4ScoreMap() -> [[Double]] {
        var scoreMap: [[Double]] = Array(repeating: Array(repeating: 0.0,
                                                          count: aiPlayer.map.width),
                                         count: aiPlayer.map.height)
        
        for row in 0..<aiPlayer.map.height {
            for col in 0..<aiPlayer.map.width {
                let position = Position(row: row, col: col)
                let tile = aiPlayer.map.tile(at: Position(row: row, col: col))
                
                if tile.visibility == Visibility.FullyRevealed {
                    if aiPlayer.map.canCreateCity(at: position) {
                        let distance = aiPlayer.map.getDistanceToNearestCity(position: position)
                        
                        if distance == 1 {
                            scoreMap[row][col] = 0.5
                        }
                        else if distance == 2 {
                            scoreMap[row][col] = 1.0
                        }
                        else if distance == 3 {
                            scoreMap[row][col] = 2.0
                        }
                        else if distance == 4 {
                            scoreMap[row][col] = 3.0
                        }
                        else if distance == 5 {
                            scoreMap[row][col] = 10.0
                        }
                        else {
                            scoreMap[row][col] = 1.0
                        }
                    }
                    else {
                        scoreMap[row][col] = 0.0
                    }
                }
                else {
                    scoreMap[row][col] = 0.1
                }
                
            }
        }
        
        return scoreMap
    }
    
    private func getLevel5ScoreMap() -> [[Double]] {
        var scoreMap: [[Double]] = Array(repeating: Array(repeating: 0.0,
                                                          count: aiPlayer.map.width),
                                         count: aiPlayer.map.height)
        
        for row in 0..<aiPlayer.map.height {
            for col in 0..<aiPlayer.map.width {
                let position = Position(row: row, col: col)
                let tile = aiPlayer.map.tile(at: Position(row: row, col: col))
                
                if tile.visibility == Visibility.FullyRevealed {
                    if aiPlayer.map.canCreateCity(at: position) {
                        let distance = aiPlayer.map.getDistanceToNearestCity(position: position)
                        
                        if distance == 1 {
                            scoreMap[row][col] = 0.5
                        }
                        else if distance == 2 {
                            scoreMap[row][col] = 1.0
                        }
                        else if distance == 3 {
                            scoreMap[row][col] = 2.0
                        }
                        else if distance == 4 {
                            scoreMap[row][col] = 3.0
                        }
                        else if distance == 5 {
                            scoreMap[row][col] = 10.0
                        }
                        else {
                            scoreMap[row][col] = 1.0
                        }
                    }
                    else {
                        scoreMap[row][col] = 0.0
                    }
                }
                else {
                    scoreMap[row][col] = 0.1
                }
                
            }
        }
        
        return scoreMap
    }
    
    private func getLevel6ScoreMap() -> [[Double]] {
        var scoreMap: [[Double]] = Array(repeating: Array(repeating: 0.0,
                                                          count: aiPlayer.map.width),
                                         count: aiPlayer.map.height)
        
        for row in 0..<aiPlayer.map.height {
            for col in 0..<aiPlayer.map.width {
                let position = Position(row: row, col: col)
                let tile = aiPlayer.map.tile(at: Position(row: row, col: col))
                
                if tile.visibility == Visibility.FullyRevealed {
                    if aiPlayer.map.canCreateCity(at: position) {
                        let distance = aiPlayer.map.getDistanceToNearestCity(position: position)
                        
                        if distance == 1 {
                            scoreMap[row][col] = 0.5
                        }
                        else if distance == 2 {
                            scoreMap[row][col] = 1.0
                        }
                        else if distance == 3 {
                            scoreMap[row][col] = 2.0
                        }
                        else if distance == 4 {
                            scoreMap[row][col] = 3.0
                        }
                        else if distance == 5 {
                            scoreMap[row][col] = 10.0
                        }
                        else {
                            scoreMap[row][col] = 1.0
                        }
                    }
                    else {
                        scoreMap[row][col] = 0.0
                    }
                }
                else {
                    scoreMap[row][col] = 0.1
                }
                
            }
        }
        
        return scoreMap
    }
    
    private func getLevel7ScoreMap() -> [[Double]] {
        var scoreMap: [[Double]] = Array(repeating: Array(repeating: 0.0,
                                                          count: aiPlayer.map.width),
                                         count: aiPlayer.map.height)
        
        for row in 0..<aiPlayer.map.height {
            for col in 0..<aiPlayer.map.width {
                let position = Position(row: row, col: col)
                let tile = aiPlayer.map.tile(at: Position(row: row, col: col))
                
                if tile.visibility == Visibility.FullyRevealed {
                    if aiPlayer.map.canCreateCity(at: position) {
                        let distance = aiPlayer.map.getDistanceToNearestCity(position: position)
                        
                        if distance == 1 {
                            scoreMap[row][col] = 0.5
                        }
                        else if distance == 2 {
                            scoreMap[row][col] = 1.0
                        }
                        else if distance == 3 {
                            scoreMap[row][col] = 2.0
                        }
                        else if distance == 4 {
                            scoreMap[row][col] = 3.0
                        }
                        else if distance == 5 {
                            scoreMap[row][col] = 10.0
                        }
                        else {
                            scoreMap[row][col] = 1.0
                        }
                    }
                    else {
                        scoreMap[row][col] = 0.0
                    }
                }
                else {
                    scoreMap[row][col] = 0.1
                }
                
            }
        }
        
        return scoreMap
    }
    
    private func getLevel8ScoreMap() -> [[Double]] {
        var scoreMap: [[Double]] = Array(repeating: Array(repeating: 0.0,
                                                          count: aiPlayer.map.width),
                                         count: aiPlayer.map.height)
        
        if aiPlayer.map.cities.isEmpty {
            return scoreMap
        }
        
        for row in 0..<aiPlayer.map.height {
            for col in 0..<aiPlayer.map.width {
                let position = Position(row: row, col: col)
                let tile = aiPlayer.map.tile(at: Position(row: row, col: col))
                
                if tile.visibility == Visibility.FullyRevealed {
                    if aiPlayer.map.canCreateCity(at: position) {
                        scoreMap[row][col] = check(position: position)
                    }
                    else {
                        scoreMap[row][col] = -maxScore
                    }
                }
                else {
                    scoreMap[row][col] = maxScore / 100.0
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
            score = 0.0
        }
        
        return score
    }
}
