import Foundation

public class CityWaterDecorator: AgentDecorator {
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
        let scoreMap: [[Score]] = Array(repeating: Array(repeating: Score(),
                                                          count: aiPlayer.map.width),
                                         count: aiPlayer.map.height)
        
        for row in 0..<aiPlayer.map.height {
            for col in 0..<aiPlayer.map.width {
                let position = Position(row: row, col: col)
                let tile = aiPlayer.map.tile(at: Position(row: row, col: col))
                
                if tile.visibility == Visibility.FullyRevealed {
                    if aiPlayer.map.canCreateCity(at: position) {
                        let distance = aiPlayer.map.getDistanceToNearestCity(position: position)
                        var reason: Reason
                        
                        if distance == 1 {
                            reason = Reason(reasonType: ReasonType.ProximityToWater,
                                            value: 0.5,
                                            message: "Location is 1 tile away from closest city.")
                        }
                        else if distance == 2 {
                            reason = Reason(reasonType: ReasonType.ProximityToWater,
                                            value: 1.0,
                                            message: "2 tiles .")
                        }
                        else if distance == 3 {
                            reason = Reason(reasonType: ReasonType.ProximityToWater,
                                            value: 2.0,
                                            message: "1 tile away from water.")
                        }
                        else if distance == 4 {
                            reason = Reason(reasonType: ReasonType.ProximityToWater,
                                            value: 3.0,
                                            message: "1 tile away from water.")
                        }
                        else if distance == 5 {
                            reason = Reason(reasonType: ReasonType.ProximityToWater,
                                            value: 0.5,
                                            message: "1 tile away from water.")
                        }
                        else {
                            reason = Reason(reasonType: ReasonType.ProximityToWater,
                                            value: 0.5,
                                            message: "1 tile away from water.")
                        }
                        
                        scoreMap[row][col].reasons.append(reason)
                    }
                    else {
                        let reason = Reason(reasonType: ReasonType.ProximityToWater,
                                        value: 0.5,
                                        message: "1 tile away from water.")
                        
                        scoreMap[row][col].reasons.append(reason)
                    }
                }
                else {
                    let reason = Reason(reasonType: ReasonType.ProximityToWater,
                                        value: 0.5,
                                        message: "1 tile away from water.")
                    scoreMap[row][col].reasons.append(reason)

                }
                
            }
        }
        
        return scoreMap
    }
    
//    private func getLevel2ScoreMap() -> [[Score]] {
//        var scoreMap: [[Score]] = Array(repeating: Array(repeating: Score(),
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
//    private func getLevel3ScoreMap() -> [[Score]] {
//        var scoreMap: [[Score]] = Array(repeating: Array(repeating: Score(),
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
//    private func getLevel4ScoreMap() -> [[Score]] {
//        var scoreMap: [[Score]] = Array(repeating: Array(repeating: Score(),
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
//    private func getLevel5ScoreMap() -> [[Score]] {
//        var scoreMap: [[Score]] = Array(repeating: Array(repeating: Score(),
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
//    private func getLevel6ScoreMap() -> [[Score]] {
//        var scoreMap: [[Score]] = Array(repeating: Array(repeating: Score(),
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
//    private func getLevel7ScoreMap() -> [[Score]] {
//        var scoreMap: [[Score]] = Array(repeating: Array(repeating: Score(),
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
                let tile = aiPlayer.map.tile(at: position)
                
                if tile.visibility == Visibility.FullyRevealed {
                    if aiPlayer.map.canCreateCity(at: position) {
                        if tile.hasRiver {
                            let reason = Reason(reasonType: ReasonType.OnRiver,
                                                value: 40.0,
                                                message: "Tile location is on a river.")
                            scoreMap[row][col].reasons.append(reason)
                        }
                        else {
                            if aiPlayer.map.accessToOcean(tile: tile) {
                                let reason = Reason(reasonType: ReasonType.OnCoast,
                                                    value: 25.0,
                                                    message: "Tile is a coastal tile.")
                                scoreMap[row][col].reasons.append(reason)
                            }
                            else {
                                // If this tile is not on a river, and it's not on the coast,
                                // check the number of river tiles in the city radius, and give
                                // a bonus for other tiles that have rivers on them.  In general,
                                // rivers are very good, so settling in a place where there are
                                // rivers within the city radius, is a good thing.
                                let cityRadiusTiles = aiPlayer.getTilesInCityRadius(from: position)
                                var scoreValue = 0.0

                                
                                for aTile in cityRadiusTiles {
                                    if aTile.hasRiver {
                                        scoreValue += 1.0
                                    }
                                }
                                
                                if scoreValue > 0.0 {
                                    let reason = Reason(reasonType: ReasonType.RiverWithinCityRadius,
                                                        value: 9.0,
                                                        message: "Tile location has rivers within the city radius.")
                                    scoreMap[row][col].reasons.append(reason)
                                }

                            }

                        }
                    }
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
