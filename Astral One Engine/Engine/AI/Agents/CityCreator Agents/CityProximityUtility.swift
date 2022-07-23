import Foundation

public class CityProximityUtility: AgentUtility {
    private let player: Player
    private let maxScore: Double
    
    public init(player: Player, maxScore: Double) {
        self.player = player
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
                if !player.map.isPlayable(row: row, col: col) {
                    continue
                }
                Debug.shared.bumpCounter()
                
                let position = Position(row: row, col: col)
                let tile = player.map.tile(at: Position(row: row, col: col))
                
                if tile.visibility == Visibility.FullyRevealed {
                    if player.map.canCreateCity(at: position) {
                        let distance = player.map.getDistanceToNearestCity(position: position)
                        var reason: Reason
                        
                        if distance == 1 {
                            reason = Reason(reasonType: ReasonType.ProximityToWater,
                                            value: 0.5,
                                            message: "1 tile away from water.")
                        }
                        else if distance == 2 {
                            reason = Reason(reasonType: ReasonType.ProximityToWater,
                                            value: 1.0,
                                            message: "2 tiles away from water.")
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
                        let reason = Reason(reasonType: ReasonType.InvalidCityLocation,
                                            value: -maxScore,
                                            message: "Invalid city location.")
                        
                        scoreMap[row][col].reasons.append(reason)
                    }
                }
                else {
                    let reason = Reason(reasonType: ReasonType.ProximityToWater,
                                        value: 0.0,
                                        message: "1 tile away from water.")
                    
                    scoreMap[row][col].reasons.append(reason)
                }
                
            }
        }
        
        return scoreMap
    }
    
    private func getLevel2ScoreMap() -> [[Double]] {
        // FIXME: This is the wrong way to initialize a 2d array
        var scoreMap: [[Double]] = Array(repeating: Array(repeating: 0.0,
                                                          count: player.map.width),
                                         count: player.map.height)
        
        for row in 0..<player.map.height {
            for col in 0..<player.map.width {
                let position = Position(row: row, col: col)
                let tile = player.map.tile(at: Position(row: row, col: col))
                
                if tile.visibility == Visibility.FullyRevealed {
                    if player.map.canCreateCity(at: position) {
                        let distance = player.map.getDistanceToNearestCity(position: position)
                        
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
                                                          count: player.map.width),
                                         count: player.map.height)
        
        for row in 0..<player.map.height {
            for col in 0..<player.map.width {
                let position = Position(row: row, col: col)
                let tile = player.map.tile(at: Position(row: row, col: col))
                
                if tile.visibility == Visibility.FullyRevealed {
                    if player.map.canCreateCity(at: position) {
                        let distance = player.map.getDistanceToNearestCity(position: position)
                        
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
                                                          count: player.map.width),
                                         count: player.map.height)
        
        for row in 0..<player.map.height {
            for col in 0..<player.map.width {
                let position = Position(row: row, col: col)
                let tile = player.map.tile(at: Position(row: row, col: col))
                
                if tile.visibility == Visibility.FullyRevealed {
                    if player.map.canCreateCity(at: position) {
                        let distance = player.map.getDistanceToNearestCity(position: position)
                        
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
                                                          count: player.map.width),
                                         count: player.map.height)
        
        for row in 0..<player.map.height {
            for col in 0..<player.map.width {
                let position = Position(row: row, col: col)
                let tile = player.map.tile(at: Position(row: row, col: col))
                
                if tile.visibility == Visibility.FullyRevealed {
                    if player.map.canCreateCity(at: position) {
                        let distance = player.map.getDistanceToNearestCity(position: position)
                        
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
                                                          count: player.map.width),
                                         count: player.map.height)
        
        for row in 0..<player.map.height {
            for col in 0..<player.map.width {
                let position = Position(row: row, col: col)
                let tile = player.map.tile(at: Position(row: row, col: col))
                
                if tile.visibility == Visibility.FullyRevealed {
                    if player.map.canCreateCity(at: position) {
                        let distance = player.map.getDistanceToNearestCity(position: position)
                        
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
                                                          count: player.map.width),
                                         count: player.map.height)
        
        for row in 0..<player.map.height {
            for col in 0..<player.map.width {
                let position = Position(row: row, col: col)
                let tile = player.map.tile(at: Position(row: row, col: col))
                
                if tile.visibility == Visibility.FullyRevealed {
                    if player.map.canCreateCity(at: position) {
                        let distance = player.map.getDistanceToNearestCity(position: position)
                        
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
    
    private func getLevel8ScoreMap() -> [[Utility]] {
        let scoreMap:[[Utility]] = (0..<player.map.width).map { _ in (0..<player.map.height).map { _ in Utility() } }

        if player.map.cities.isEmpty {
            return scoreMap
        }
        
        for row in 0..<player.map.height {
            for col in 0..<player.map.width {
                if !player.map.isPlayable(row: row, col: col) {
                    continue
                }
                
                Debug.shared.bumpCounter()

                let position = Position(row: row, col: col)
                let tile = player.map.tile(at: Position(row: row, col: col))
                
                if tile.visibility == Visibility.FullyRevealed {
                    if player.map.canCreateCity(at: position) {
                        let reason = Reason(reasonType: ReasonType.ProximityToNearestCity,
                                            value: check(position: position),
                                            message: "Proximity to nearest city.")
                        
                        scoreMap[row][col].reasons.append(reason)
                    }
                    else {
                        let reason = Reason(reasonType: ReasonType.InvalidCityLocation,
                                            value: -maxScore,
                                            message: "Invalid city location.")
                        
                        scoreMap[row][col].reasons.append(reason)
                    }
                }
                else {
                    let reason = Reason(reasonType: ReasonType.TileNotRevealed,
                                        value: -maxScore / 5.0,
                                        message: "Location not fully revealed.")
                    
                    scoreMap[row][col].reasons.append(reason)
                }
                
            }
        }
        
        return scoreMap
    }
    
    private func check(position: Position) -> Double {
        var score = 1.0
        let distance = player.map.getDistanceToNearestCity(position: position)

        if distance <= 1 {
            score = -maxScore
        }
        else if distance == 2 {
            score = -maxScore / 2.0
        }
        else if distance == 3 {
            score = 0.0
        }
        else if distance == 4 {
            score = maxScore / 2.0
        }
        else if distance >= 5 && distance <= 7 {
            score = maxScore
        }
        else if distance <= 9 {
            score = maxScore / 2.0
        }
        else {
            score = -maxScore
        }
        
        return score
    }
}
