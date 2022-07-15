import Foundation

public class SettlerAgent {
    internal let player: AIPlayer
    internal let settler: Settler
    internal var analyzers: [AgentDecorator] = []

    public init(player: AIPlayer, settler: Settler) throws {
        self.player = player
        self.settler = settler
        
        analyzers.append(CityResourcesDecorator(aiPlayer: player, maxScore: 10.0))
        analyzers.append(CityProximityDecorator(aiPlayer: player, maxScore: 25.0))
        analyzers.append(SettlerMovementDecorator(aiPlayer: player, cityCreator: settler, maxScore: 50.0))
        analyzers.append(CityWaterDecorator(aiPlayer: player, maxScore: 10.0))
        analyzers.append(CityDefensiveDecorator(aiPlayer: player, maxScore: 10.0))
    }
    
    public func getSettleCityPosition() throws -> PositionScore? {
        let scoreMap = try getBuildCityScores()
        var positions: [PositionScore] = []
        
        var maxScore = 0.0
        
        for row in 0..<player.map.height {
            for col in 0..<player.map.width {
                if scoreMap[row][col].value > maxScore {
                    maxScore = scoreMap[row][col].value
                    
                    positions.append(PositionScore(position: Position(row: row, col: col),
                                                   score: scoreMap[row][col]))
                }
            }
        }
        
        if let bestPosition = positions.last {
            bestPosition.score.reasons = bestPosition.score.reasons.sorted(by: {
                $0.value > $1.value
            })
            
            return bestPosition
        }
        
        return nil
    }
    
    private func getBuildCityScores() throws -> [[Score]] {
        let scoreMap:[[Score]] = (0..<player.map.width).map { _ in (0..<player.map.height).map { _ in Score() } }
        
        let scoreMap0 = analyzers[0].getScoreMap()
        let scoreMap1 = analyzers[1].getScoreMap()
        let scoreMap2 = analyzers[2].getScoreMap()
        let scoreMap3 = analyzers[3].getScoreMap()
        let scoreMap4 = analyzers[4].getScoreMap()
        
        for row in 0..<player.map.height {
            for col in 0..<player.map.width {
                scoreMap[row][col].reasons += scoreMap0[row][col].reasons
                scoreMap[row][col].reasons += scoreMap1[row][col].reasons
                scoreMap[row][col].reasons += scoreMap2[row][col].reasons
                scoreMap[row][col].reasons += scoreMap3[row][col].reasons
                scoreMap[row][col].reasons += scoreMap4[row][col].reasons
            }
        }
        
        player.agentMap = scoreMap
        
        // log(scoreMap: scoreMap)
        
        return scoreMap
    }
    
    public func getBuildScore(player: Player, tile: Tile) throws -> Double {
        let filename = Bundle.main.path(forResource: "defensive_ai",
                                        ofType: "lua")!
        let luaScript = try String(contentsOfFile: filename)
        let ptrScript = strdup(luaScript)
//        lua.script(ptrScript)
        free(ptrScript)
        
        let ptrFname = strdup("settle_score")
//        let value = lua_Number(0)
//        let value2 = lua_Number(33)
//        let result = lua.call(nil, method: ptrFname, p1: value, p2: value2)
        free(ptrFname)
        
        return Double(0.0)
    }
    
    internal func getBestPositions(scoreMap: [[Double]]) -> [Position] {
//        var maxScore = -1.0
//        var currScore = -1.0
        var positions: [Position] = []
        
        for i in 0..<scoreMap.count {
            for j in 0..<scoreMap[i].count {
                if scoreMap[i][j] > 0.0 {
                    positions.append(Position(row: i, col: j))
                }
//                currScore = scoreMap[i][j]
//
//                if currScore > maxScore {
//                    maxScore = scoreMap[i][j]
//                    positions = [Position(row: i, col: j)]
//                }
//                else if currScore == maxScore {
//                    positions.append(Position(row: i, col: j))
//                }
            }
        }
        
        return positions
    }
    
    internal func log(scoreMap: [[Double]]) {
        return
        // var line1 = "-"
        var line2 = ""
        var line3 = ""
        var line4 = ""
        var line5 = ""
        
        let reversedScoreMap: [[Double]] = scoreMap.reversed()
        
        print("---------------------------------------------------")
        for i in 0..<reversedScoreMap.count {
            line2 = "|"
            line3 = "|"
            
            for j in 0..<reversedScoreMap[i].count {
                let formattedNum = String(format: "%.0f", reversedScoreMap[i][j])
                
                line2 += "     |"

                if formattedNum.count == 1 {
                    line3 += "  " + formattedNum + " |"
                }
                else if formattedNum.count == 2 {
                    line3 += " " + formattedNum + " |"
                }
                else if formattedNum.count == 3 {
                    line3 += "" + formattedNum + " |"
                }
                
                line4 += "     |"
                line5 += "-----"

            }
            
            line5 += "-"
            
//            print(line2)
            print(line3)
//            print(line4)
            print(line5)
            
//            line1 = ""
            line2 = ""
            line3 = ""
            line4 = ""
            line5 = ""
        }
        
//        if scoreMap.count > 0 {
//            for _ in 0..<scoreMap.count {
//                line1 += "----------------"
//
//
//            }
//
//            print(line1)
//            line1 = ""
//
//            for i in 0..<scoreMap {
//                line2 = "|"
//                line3 = "|"
//                line4 = "|"
//                line5 = "-"
//
//                for j in 0..<width {
//                    if let node = self.node(row: i, col: j) {
//                        let formattedNum = String(format: "%.7f", scoreMap[i][j])
//
//                        line2 += "               |"
//
//                        if formattedNum.count == 9 {
//                            line3 += "  " + formattedNum + "    |"
//                        }
//                        else if formattedNum.count == 10 {
//                            line3 += "  " + formattedNum + "   |"
//                        }
//
//                        line4 += "               |"
//                        line5 += "----------------"
//                    }
//                }
//
//                print(line2)
//                print(line3)
//                print(line4)
//                print(line5)
//
//                line1 = ""
//                line2 = ""
//                line3 = ""
//                line4 = ""
//                line5 = ""
//            }
//        }
    }
    
}
