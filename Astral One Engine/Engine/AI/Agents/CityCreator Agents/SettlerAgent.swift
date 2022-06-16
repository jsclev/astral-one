import Foundation

public class SettlerAgent {
    internal let player: AIPlayer
    internal let settler: Settler
//    private let luaState: OpaquePointer!
    
    public init(player: AIPlayer, settler: Settler) throws {
        self.player = player
        self.settler = settler
        
//        luaState = luaL_newstate()
//        luaL_openlibs(luaState);
//
//        var scriptName = "level"
//        switch player.skillLevel {
//        case .One:
//            scriptName += "1"
//        case .Two:
//            scriptName += "2"
//        case .Three:
//            scriptName += "3"
//        case .Four:
//            scriptName += "4"
//        case .Five:
//            scriptName += "5"
//        case .Six:
//            scriptName += "6"
//        case .Seven:
//            scriptName += "7"
//        case .Eight:
//            scriptName += "8"
//        }
//
//        scriptName += "_settler"
//
//        let filename = Bundle.main.path(forResource: scriptName, ofType: "lua")!
//        let luaScript = try String(contentsOfFile: filename)
//        let ptrScript = strdup(luaScript)
//        luaL_loadstring(luaState, ptrScript)
//        free(ptrScript)
    }
    
//    deinit {
//        lua.destruct()
//    }
    
    public static func getAgent(aiPlayer: AIPlayer, settler: Settler) throws -> SettlerAgent {
        switch aiPlayer.skillLevel {
        case .One:
            return try SettlerLevel1Agent(player: aiPlayer, settler: settler)
        case .Two:
            return try SettlerLevel2Agent(player: aiPlayer, settler: settler)
        case .Three:
            return try SettlerLevel1Agent(player: aiPlayer, settler: settler)
        case .Four:
            return try SettlerLevel1Agent(player: aiPlayer, settler: settler)
        case .Five:
            return try SettlerLevel1Agent(player: aiPlayer, settler: settler)
        case .Six:
            return try SettlerLevel1Agent(player: aiPlayer, settler: settler)
        case .Seven:
            return try SettlerLevel1Agent(player: aiPlayer, settler: settler)
        case .Eight:
            return try SettlerLevel8Agent(player: aiPlayer, settler: settler)
        }
    }
    
    public func getSettleCityPosition() throws -> Position? {
        fatalError("Must be implemented in subclasses.")
    }
    
    private func getSettleCityScore(tile: Tile) throws -> Double {
//        let ptrFname = strdup("settle_score")
//        let value = lua_Number(0)
//        let value2 = lua_Number(33)
//        let result = lua.call(nil, method: ptrFname, p1: value, p2: value2)
        
//        var luaStateEx: OpaquePointer!
//
//        if (luaState != nil) {
//            luaStateEx = luaState
//        }
//
//        lua_getglobal(luaStateEx, "settle_score");
//        lua_pushnumber(luaStateEx, 1.0);
//        lua_pushnumber(luaStateEx, 5.0);
//
//        lua_pcallk(luaStateEx, 2, 1, 0, 0, nil);

//        let result = lua_tonumber(luaStateEx, -1);
//        lua_pop(luaStateEx, 1);
//        return result;
//        free(ptrFname)
        
        fatalError("Must be implemented in subclasses.")
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
    
    public func getCityRadiusScores() -> [Position:Double] {
        var scores: [Position: Double] = [:]

        for row in 0..<player.map.height {
            for col in 0..<player.map.width {
                let position = Position(row: row, col: col)
                let tile = player.map.tile(at: position)
                
                if tile.visibility == Visibility.FullyRevealed ||
                   tile.visibility == Visibility.SemiRevealed {

                    if tile.canCreateCity {
                        let cityRadiusTiles = player.getTilesInCityRadius(from: position)
                        
                        var sum = 0.0
                        for tile in cityRadiusTiles {
                            sum += tile.score + tile.movementCost
                        }
                        
                        scores[position] = sum
                    }
                    else {
                        scores[position] = 0.0
                    }
                }
                else {
                    scores[position] = 1.0
                }
            }
        }
        
        return scores
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
