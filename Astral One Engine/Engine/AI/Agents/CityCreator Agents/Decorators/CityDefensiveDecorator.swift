import Foundation

public class CityDefensiveDecorator: AgentDecorator {
    private let aiPlayer: AIPlayer
    private let maxScore: Double
    
    public init(aiPlayer: AIPlayer, maxScore: Double) {
        self.aiPlayer = aiPlayer
        self.maxScore = maxScore
    }
    
    public func getScoreMap() -> [[Score]] {
        switch aiPlayer.skillLevel {
        case .One: return getLevel1ScoreMap()
        case .Two: return getLevel1ScoreMap()
        case .Three: return getLevel1ScoreMap()
        case .Four: return getLevel1ScoreMap()
        case .Five: return getLevel1ScoreMap()
        case .Six: return getLevel1ScoreMap()
        case .Seven: return getLevel1ScoreMap()
        case .Eight: return getLevel8ScoreMap()
        }
    }
    
    private func getLevel1ScoreMap() -> [[Score]] {
        let scoreMap:[[Score]] = (0..<aiPlayer.map.width).map { _ in (0..<aiPlayer.map.height).map { _ in Score() } }
        
        for row in 0..<aiPlayer.map.height {
            for col in 0..<aiPlayer.map.width {
                let position = Position(row: row, col: col)
                let tile = aiPlayer.map.tile(at: Position(row: row, col: col))
                
                if tile.visibility == Visibility.FullyRevealed {
                    if aiPlayer.map.canCreateCity(at: position) {
                        // let distance = aiPlayer.map.getDistanceToNearestCity(position: position)
                        
                        // if distance == 1 {
                        //                            scoreMap[row][col] = 0.5
                        //                        }
                        //                        else if distance == 2 {
                        //                            scoreMap[row][col] = 1.0
                        //                        }
                        //                        else if distance == 3 {
                        //                            scoreMap[row][col] = 2.0
                        //                        }
                        //                        else if distance == 4 {
                        //                            scoreMap[row][col] = 3.0
                        //                        }
                        //                        else if distance == 5 {
                        //                            scoreMap[row][col] = 10.0
                        //                        }
                        //                        else {
                        //                            scoreMap[row][col] = 1.0
                        //                        }
                    }
                    else {
                        // scoreMap[row][col] = 0.0
                    }
                }
                else {
                    // scoreMap[row][col] = 0.1
                }
                
            }
        }
        
        return scoreMap
    }
    
    //    private func getLevel2ScoreMap() -> [[Double]] {
    //        var scoreMap: [[Double]] = Array(repeating: Array(repeating: 0.0,
    //                                                          count: aiPlayer.map.width),
    //                                         count: aiPlayer.map.height)
    //
    //        for row in 0..<aiPlayer.map.height {
    //            for col in 0..<aiPlayer.map.width {
    //                let position = Position(row: row, col: col)
    //                let tile = aiPlayer.map.tile(at: Position(row: row, col: col))
    //
    //                if tile.visibility == Visibility.FullyRevealed {
    //                    if aiPlayer.map.canCreateCity(at: position) {
    //                        let distance = aiPlayer.map.getDistanceToNearestCity(position: position)
    //
    //                        if distance == 1 {
    //                            scoreMap[row][col] = 0.5
    //                        }
    //                        else if distance == 2 {
    //                            scoreMap[row][col] = 1.0
    //                        }
    //                        else if distance == 3 {
    //                            scoreMap[row][col] = 2.0
    //                        }
    //                        else if distance == 4 {
    //                            scoreMap[row][col] = 3.0
    //                        }
    //                        else if distance == 5 {
    //                            scoreMap[row][col] = 10.0
    //                        }
    //                        else {
    //                            scoreMap[row][col] = 1.0
    //                        }
    //                    }
    //                    else {
    //                        scoreMap[row][col] = 0.0
    //                    }
    //                }
    //                else {
    //                    scoreMap[row][col] = 0.1
    //                }
    //
    //            }
    //        }
    //
    //        return scoreMap
    //    }
    //
    //    private func getLevel3ScoreMap() -> [[Double]] {
    //        var scoreMap: [[Double]] = Array(repeating: Array(repeating: 0.0,
    //                                                          count: aiPlayer.map.width),
    //                                         count: aiPlayer.map.height)
    //
    //        for row in 0..<aiPlayer.map.height {
    //            for col in 0..<aiPlayer.map.width {
    //                let position = Position(row: row, col: col)
    //                let tile = aiPlayer.map.tile(at: Position(row: row, col: col))
    //
    //                if tile.visibility == Visibility.FullyRevealed {
    //                    if aiPlayer.map.canCreateCity(at: position) {
    //                        let distance = aiPlayer.map.getDistanceToNearestCity(position: position)
    //
    //                        if distance == 1 {
    //                            scoreMap[row][col] = 0.5
    //                        }
    //                        else if distance == 2 {
    //                            scoreMap[row][col] = 1.0
    //                        }
    //                        else if distance == 3 {
    //                            scoreMap[row][col] = 2.0
    //                        }
    //                        else if distance == 4 {
    //                            scoreMap[row][col] = 3.0
    //                        }
    //                        else if distance == 5 {
    //                            scoreMap[row][col] = 10.0
    //                        }
    //                        else {
    //                            scoreMap[row][col] = 1.0
    //                        }
    //                    }
    //                    else {
    //                        scoreMap[row][col] = 0.0
    //                    }
    //                }
    //                else {
    //                    scoreMap[row][col] = 0.1
    //                }
    //
    //            }
    //        }
    //
    //        return scoreMap
    //    }
    //
    //    private func getLevel4ScoreMap() -> [[Double]] {
    //        var scoreMap: [[Double]] = Array(repeating: Array(repeating: 0.0,
    //                                                          count: aiPlayer.map.width),
    //                                         count: aiPlayer.map.height)
    //
    //        for row in 0..<aiPlayer.map.height {
    //            for col in 0..<aiPlayer.map.width {
    //                let position = Position(row: row, col: col)
    //                let tile = aiPlayer.map.tile(at: Position(row: row, col: col))
    //
    //                if tile.visibility == Visibility.FullyRevealed {
    //                    if aiPlayer.map.canCreateCity(at: position) {
    //                        let distance = aiPlayer.map.getDistanceToNearestCity(position: position)
    //
    //                        if distance == 1 {
    //                            scoreMap[row][col] = 0.5
    //                        }
    //                        else if distance == 2 {
    //                            scoreMap[row][col] = 1.0
    //                        }
    //                        else if distance == 3 {
    //                            scoreMap[row][col] = 2.0
    //                        }
    //                        else if distance == 4 {
    //                            scoreMap[row][col] = 3.0
    //                        }
    //                        else if distance == 5 {
    //                            scoreMap[row][col] = 10.0
    //                        }
    //                        else {
    //                            scoreMap[row][col] = 1.0
    //                        }
    //                    }
    //                    else {
    //                        scoreMap[row][col] = 0.0
    //                    }
    //                }
    //                else {
    //                    scoreMap[row][col] = 0.1
    //                }
    //
    //            }
    //        }
    //
    //        return scoreMap
    //    }
    //
    //    private func getLevel5ScoreMap() -> [[Double]] {
    //        var scoreMap: [[Double]] = Array(repeating: Array(repeating: 0.0,
    //                                                          count: aiPlayer.map.width),
    //                                         count: aiPlayer.map.height)
    //
    //        for row in 0..<aiPlayer.map.height {
    //            for col in 0..<aiPlayer.map.width {
    //                let position = Position(row: row, col: col)
    //                let tile = aiPlayer.map.tile(at: Position(row: row, col: col))
    //
    //                if tile.visibility == Visibility.FullyRevealed {
    //                    if aiPlayer.map.canCreateCity(at: position) {
    //                        let distance = aiPlayer.map.getDistanceToNearestCity(position: position)
    //
    //                        if distance == 1 {
    //                            scoreMap[row][col] = 0.5
    //                        }
    //                        else if distance == 2 {
    //                            scoreMap[row][col] = 1.0
    //                        }
    //                        else if distance == 3 {
    //                            scoreMap[row][col] = 2.0
    //                        }
    //                        else if distance == 4 {
    //                            scoreMap[row][col] = 3.0
    //                        }
    //                        else if distance == 5 {
    //                            scoreMap[row][col] = 10.0
    //                        }
    //                        else {
    //                            scoreMap[row][col] = 1.0
    //                        }
    //                    }
    //                    else {
    //                        scoreMap[row][col] = 0.0
    //                    }
    //                }
    //                else {
    //                    scoreMap[row][col] = 0.1
    //                }
    //
    //            }
    //        }
    //
    //        return scoreMap
    //    }
    //
    //    private func getLevel6ScoreMap() -> [[Double]] {
    //        var scoreMap: [[Double]] = Array(repeating: Array(repeating: 0.0,
    //                                                          count: aiPlayer.map.width),
    //                                         count: aiPlayer.map.height)
    //
    //        for row in 0..<aiPlayer.map.height {
    //            for col in 0..<aiPlayer.map.width {
    //                let position = Position(row: row, col: col)
    //                let tile = aiPlayer.map.tile(at: Position(row: row, col: col))
    //
    //                if tile.visibility == Visibility.FullyRevealed {
    //                    if aiPlayer.map.canCreateCity(at: position) {
    //                        let distance = aiPlayer.map.getDistanceToNearestCity(position: position)
    //
    //                        if distance == 1 {
    //                            scoreMap[row][col] = 0.5
    //                        }
    //                        else if distance == 2 {
    //                            scoreMap[row][col] = 1.0
    //                        }
    //                        else if distance == 3 {
    //                            scoreMap[row][col] = 2.0
    //                        }
    //                        else if distance == 4 {
    //                            scoreMap[row][col] = 3.0
    //                        }
    //                        else if distance == 5 {
    //                            scoreMap[row][col] = 10.0
    //                        }
    //                        else {
    //                            scoreMap[row][col] = 1.0
    //                        }
    //                    }
    //                    else {
    //                        scoreMap[row][col] = 0.0
    //                    }
    //                }
    //                else {
    //                    scoreMap[row][col] = 0.1
    //                }
    //
    //            }
    //        }
    //
    //        return scoreMap
    //    }
    //
    //    private func getLevel7ScoreMap() -> [[Double]] {
    //        var scoreMap: [[Double]] = Array(repeating: Array(repeating: 0.0,
    //                                                          count: aiPlayer.map.width),
    //                                         count: aiPlayer.map.height)
    //
    //        for row in 0..<aiPlayer.map.height {
    //            for col in 0..<aiPlayer.map.width {
    //                let position = Position(row: row, col: col)
    //                let tile = aiPlayer.map.tile(at: Position(row: row, col: col))
    //
    //                if tile.visibility == Visibility.FullyRevealed {
    //                    if aiPlayer.map.canCreateCity(at: position) {
    //                        let distance = aiPlayer.map.getDistanceToNearestCity(position: position)
    //
    //                        if distance == 1 {
    //                            scoreMap[row][col] = 0.5
    //                        }
    //                        else if distance == 2 {
    //                            scoreMap[row][col] = 1.0
    //                        }
    //                        else if distance == 3 {
    //                            scoreMap[row][col] = 2.0
    //                        }
    //                        else if distance == 4 {
    //                            scoreMap[row][col] = 3.0
    //                        }
    //                        else if distance == 5 {
    //                            scoreMap[row][col] = 10.0
    //                        }
    //                        else {
    //                            scoreMap[row][col] = 1.0
    //                        }
    //                    }
    //                    else {
    //                        scoreMap[row][col] = 0.0
    //                    }
    //                }
    //                else {
    //                    scoreMap[row][col] = 0.1
    //                }
    //
    //            }
    //        }
    //
    //        return scoreMap
    //    }
    
    private func getLevel8ScoreMap() -> [[Score]] {
        let scoreMap:[[Score]] = (0..<aiPlayer.map.width).map { _ in (0..<aiPlayer.map.height).map { _ in Score() } }
        
        for row in 0..<aiPlayer.map.height {
            for col in 0..<aiPlayer.map.width {
                let position = Position(row: row, col: col)
                
                if aiPlayer.map.canCreateCity(at: position) {
                    let tile = aiPlayer.map.tile(at: position)
                    let defensiveScore = (maxScore / 3.0) * (tile.defenseBonus + 1.0)
                    
                    scoreMap[row][col].reasons.append(Reason(reasonType: ReasonType.Defense,
                                                             value: defensiveScore,
                                                             message: "Defensive bonus of tile location."))
                }
            }
        }
        
        return scoreMap
    }

}
