import Foundation

public class SettlerAgent {
    internal let player: Player
    internal let settler: Settler
    internal var analyzers: [AgentUtility] = []

    public init(player: Player, settler: Settler) throws {
        self.player = player
        self.settler = settler
        
        switch player.skillLevel {
        case .One:
            analyzers.append(CityResourcesUtility(player: player, maxScore: 10.0))
            analyzers.append(CityProximityUtility(player: player, maxScore: 25.0))
            analyzers.append(DistanceToCityUtility(player: player, cityCreator: settler, maxScore: 50.0))
            analyzers.append(CityWaterUtility(player: player, maxScore: 10.0))
            analyzers.append(CityDefensiveUtility(player: player, maxScore: 10.0))
            break
        case .Two:
            analyzers.append(CityResourcesUtility(player: player, maxScore: 10.0))
            analyzers.append(CityProximityUtility(player: player, maxScore: 25.0))
            analyzers.append(DistanceToCityUtility(player: player, cityCreator: settler, maxScore: 50.0))
            analyzers.append(CityWaterUtility(player: player, maxScore: 10.0))
            analyzers.append(CityDefensiveUtility(player: player, maxScore: 10.0))
            break
        case .Three:
            analyzers.append(CityResourcesUtility(player: player, maxScore: 10.0))
            analyzers.append(CityProximityUtility(player: player, maxScore: 25.0))
            analyzers.append(DistanceToCityUtility(player: player, cityCreator: settler, maxScore: 50.0))
            analyzers.append(CityWaterUtility(player: player, maxScore: 10.0))
            analyzers.append(CityDefensiveUtility(player: player, maxScore: 10.0))
            break
        case .Four:
            analyzers.append(CityResourcesUtility(player: player, maxScore: 10.0))
            analyzers.append(CityProximityUtility(player: player, maxScore: 25.0))
            analyzers.append(DistanceToCityUtility(player: player, cityCreator: settler, maxScore: 50.0))
            analyzers.append(CityWaterUtility(player: player, maxScore: 10.0))
            analyzers.append(CityDefensiveUtility(player: player, maxScore: 10.0))
            break
        case .Five:
            analyzers.append(CityResourcesUtility(player: player, maxScore: 10.0))
            analyzers.append(CityProximityUtility(player: player, maxScore: 25.0))
            analyzers.append(DistanceToCityUtility(player: player, cityCreator: settler, maxScore: 50.0))
            analyzers.append(CityWaterUtility(player: player, maxScore: 10.0))
            analyzers.append(CityDefensiveUtility(player: player, maxScore: 10.0))
            break
        case .Six:
            analyzers.append(CityResourcesUtility(player: player, maxScore: 10.0))
            analyzers.append(CityProximityUtility(player: player, maxScore: 25.0))
            analyzers.append(DistanceToCityUtility(player: player, cityCreator: settler, maxScore: 50.0))
            analyzers.append(CityWaterUtility(player: player, maxScore: 10.0))
            analyzers.append(CityDefensiveUtility(player: player, maxScore: 10.0))
            break
        case .Seven:
            analyzers.append(CityResourcesUtility(player: player, maxScore: 10.0))
            analyzers.append(CityProximityUtility(player: player, maxScore: 25.0))
            analyzers.append(DistanceToCityUtility(player: player, cityCreator: settler, maxScore: 50.0))
            analyzers.append(CityWaterUtility(player: player, maxScore: 10.0))
            analyzers.append(CityDefensiveUtility(player: player, maxScore: 10.0))
            break
        case .Eight:
            analyzers.append(CityResourcesUtility(player: player, maxScore: 10.0))
            analyzers.append(CityProximityUtility(player: player, maxScore: 25.0))
            analyzers.append(DistanceToCityUtility(player: player, cityCreator: settler, maxScore: 50.0))
            analyzers.append(CityWaterUtility(player: player, maxScore: 10.0))
            analyzers.append(CityDefensiveUtility(player: player, maxScore: 10.0))
            break
        }
    }
    
    public func getSettleCityPosition() throws -> PositionUtility? {
        let scoreMap = try getBuildCityScores()
        var positions: [PositionUtility] = []
        
        var maxScore = 0.0
        
        for row in 0..<player.map.height {
            for col in 0..<player.map.width {
                if scoreMap[row][col].score > maxScore {
                    maxScore = scoreMap[row][col].score
                    
                    positions.append(PositionUtility(position: Position(row: row, col: col),
                                                   utility: scoreMap[row][col]))
                }
            }
        }
        
        if let bestPosition = positions.last {
            bestPosition.utility.reasons = bestPosition.utility.reasons.sorted(by: {
                $0.score > $1.score
            })
            
            return bestPosition
        }
        
        return nil
    }
    
    private func getBuildCityScores() throws -> [[Utility]] {
        let scoreMap:[[Utility]] = (0..<player.map.width).map { _ in (0..<player.map.height).map { _ in Utility() } }
        
        let scoreMap0 = analyzers[0].getUtilityMap()
        let scoreMap1 = analyzers[1].getUtilityMap()
        let scoreMap2 = analyzers[2].getUtilityMap()
        let scoreMap3 = analyzers[3].getUtilityMap()
        let scoreMap4 = analyzers[4].getUtilityMap()
        
//        for analyzer in analyzers {
//            scoreMaps.append(analyzer.getScoreMap())
//        }
        
        // TODO: Add scorer to boost river tiles if there are few rivers on the map.
        // TODO: Add scorer to boost coastal tiles if there are few ocean tiles on the map.
        // TODO: Add scorer to boost tiles that are already near or on a road
        
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
//        var line2 = ""
//        var line3 = ""
//        var line4 = ""
//        var line5 = ""
//
//        let reversedScoreMap: [[Double]] = scoreMap.reversed()
//
//        print("---------------------------------------------------")
//        for i in 0..<reversedScoreMap.count {
//            line2 = "|"
//            line3 = "|"
//
//            for j in 0..<reversedScoreMap[i].count {
//                let formattedNum = String(format: "%.0f", reversedScoreMap[i][j])
//
//                line2 += "     |"
//
//                if formattedNum.count == 1 {
//                    line3 += "  " + formattedNum + " |"
//                }
//                else if formattedNum.count == 2 {
//                    line3 += " " + formattedNum + " |"
//                }
//                else if formattedNum.count == 3 {
//                    line3 += "" + formattedNum + " |"
//                }
//
//                line4 += "     |"
//                line5 += "-----"
//
//            }
//
//            line5 += "-"
//
////            print(line2)
//            print(line3)
////            print(line4)
//            print(line5)
//
////            line1 = ""
//            line2 = ""
//            line3 = ""
//            line4 = ""
//            line5 = ""
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
//    }
    
}
