import Foundation

public class DistanceToCityUtility: AgentUtility {
    private let player: Player
    private let settler: Settler
    private let maxScore: Double
    
    public init(player: Player, cityCreator: Settler, maxScore: Double) {
        self.player = player
        self.settler = cityCreator
        self.maxScore = maxScore
    }
    
    public func getUtilityMap() -> [[Utility]] {
        switch player.skillLevel {
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
    
    private func getLevel1ScoreMap() -> [[Utility]] {
        let scoreMap:[[Utility]] = (0..<player.map.width).map { _ in (0..<player.map.height).map { _ in Utility() } }

        for row in 0..<player.map.height {
            for col in 0..<player.map.width {
                let position = Position(row: row, col: col)
                let distance = settler.position.distance(to: position)
                var reason: Reason
                
                if distance < 4 {
                    reason = Reason(reasonType: ReasonType.DistanceToTargetTile,
                                        value: -1.0 * Double(distance),
                                        message: "\(distance) movement cost to target tile location.")
                }
                else if distance >= 4 && distance <= 6 {
                    reason = Reason(reasonType: ReasonType.DistanceToTargetTile,
                                    value: -4.0 * Double(distance),
                                    message: "\(distance) movement cost to target tile location.")
                }
                else if distance >= 7 && distance <= 10 {
                    reason = Reason(reasonType: ReasonType.DistanceToTargetTile,
                                    value: -6.0 * Double(distance),
                                    message: "\(distance) movement cost to target tile location.")
                }
                else {
                    reason = Reason(reasonType: ReasonType.DistanceToTargetTile,
                                    value: -7.0 * Double(distance),
                                    message: "\(distance) movement cost to target tile location.")
                }
                
                scoreMap[row][col].reasons.append(reason)

            }
        }
        
        return scoreMap
    }
    
//    private func getLevel2ScoreMap() -> [[Double]] {
//        var scoreMap: [[Double]] = Array(repeating: Array(repeating: 0.0,
//                                                          count: player.map.width),
//                                         count: player.map.height)
//
//        for row in 0..<player.map.height {
//            for col in 0..<player.map.width {
//                let position = Position(row: row, col: col)
//                let tile = player.map.tile(at: Position(row: row, col: col))
//
//                if tile.visibility == Visibility.FullyRevealed {
//                    if player.map.canCreateCity(at: position) {
//                        let distance = player.map.getDistanceToNearestCity(position: position)
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
//                                                          count: player.map.width),
//                                         count: player.map.height)
//
//        for row in 0..<player.map.height {
//            for col in 0..<player.map.width {
//                let position = Position(row: row, col: col)
//                let tile = player.map.tile(at: Position(row: row, col: col))
//
//                if tile.visibility == Visibility.FullyRevealed {
//                    if player.map.canCreateCity(at: position) {
//                        let distance = player.map.getDistanceToNearestCity(position: position)
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
//                                                          count: player.map.width),
//                                         count: player.map.height)
//
//        for row in 0..<player.map.height {
//            for col in 0..<player.map.width {
//                let position = Position(row: row, col: col)
//                let tile = player.map.tile(at: Position(row: row, col: col))
//
//                if tile.visibility == Visibility.FullyRevealed {
//                    if player.map.canCreateCity(at: position) {
//                        let distance = player.map.getDistanceToNearestCity(position: position)
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
//                                                          count: player.map.width),
//                                         count: player.map.height)
//
//        for row in 0..<player.map.height {
//            for col in 0..<player.map.width {
//                let position = Position(row: row, col: col)
//                let tile = player.map.tile(at: Position(row: row, col: col))
//
//                if tile.visibility == Visibility.FullyRevealed {
//                    if player.map.canCreateCity(at: position) {
//                        let distance = player.map.getDistanceToNearestCity(position: position)
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
//                                                          count: player.map.width),
//                                         count: player.map.height)
//
//        for row in 0..<player.map.height {
//            for col in 0..<player.map.width {
//                let position = Position(row: row, col: col)
//                let tile = player.map.tile(at: Position(row: row, col: col))
//
//                if tile.visibility == Visibility.FullyRevealed {
//                    if player.map.canCreateCity(at: position) {
//                        let distance = player.map.getDistanceToNearestCity(position: position)
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
//                                                          count: player.map.width),
//                                         count: player.map.height)
//
//        for row in 0..<player.map.height {
//            for col in 0..<player.map.width {
//                let position = Position(row: row, col: col)
//                let tile = player.map.tile(at: Position(row: row, col: col))
//
//                if tile.visibility == Visibility.FullyRevealed {
//                    if player.map.canCreateCity(at: position) {
//                        let distance = player.map.getDistanceToNearestCity(position: position)
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
    
    private func getLevel8ScoreMap() -> [[Utility]] {
        let scoreMap:[[Utility]] = (0..<player.map.width).map { _ in (0..<player.map.height).map { _ in Utility() } }
        
        for row in 0..<player.map.height {
            for col in 0..<player.map.width {
                let position = Position(row: row, col: col)
                let tile = player.map.tile(at: Position(row: row, col: col))
                var reason: Reason
                
                if tile.visibility == Visibility.FullyRevealed {
                    if player.map.canCreateCity(at: position) {
                        let distance = settler.position.distance(to: position)

                        reason = Reason(reasonType: ReasonType.DistanceToTargetTile,
                                        value: check(position: position),
                                        message: "\(distance) movement cost to target tile location.")
                    }
                    else {
                        reason = Reason(reasonType: ReasonType.InvalidCityLocation,
                                        value: -maxScore,
                                        message: "Cannot create city on tile.")
                    }
                }
                else {
                    reason = Reason(reasonType: ReasonType.TileNotRevealed,
                                    value: maxScore / 100.0,
                                    message: "Tile location is not revealed.")
                }
                
                scoreMap[row][col].reasons.append(reason)
            }
        }
        
        return scoreMap
    }
    
    private func check(position: Position) -> Double {
        // FIXME: Need to add a parameter that will penalize the score
        //        if we are on the first few turns of the game.  If it
        //        is the first turn of the game, for example, we want
        //        to spend very few turns finding the ideal tile before
        //        settling our first city.
        let distance = Double(settler.position.distance(to: position))
        
        let k = 2.0
        let m = 2.0
        var score = pow(distance / m, k)
        if score > maxScore {
            score = maxScore
        }
        
        return -score        
    }
}
