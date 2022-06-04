import Foundation

public class SettlerAgent {
    private let player: AIPlayer
    private let settler: Settler
    private let luaState: OpaquePointer!
    
    public init(player: AIPlayer, settler: Settler) throws {
        self.player = player
        self.settler = settler
        
        luaState = luaL_newstate()
        luaL_openlibs(luaState);
        
        var scriptName = "level"
        switch player.skillLevel {
        case .One:
            scriptName += "1"
        case .Two:
            scriptName += "2"
        case .Three:
            scriptName += "3"
        case .Four:
            scriptName += "4"
        case .Five:
            scriptName += "5"
        case .Six:
            scriptName += "6"
        case .Seven:
            scriptName += "7"
        case .Eight:
            scriptName += "8"
        }
        
        scriptName += "_settler"
        
        let filename = Bundle.main.path(forResource: scriptName, ofType: "lua")!
        let luaScript = try String(contentsOfFile: filename)
        let ptrScript = strdup(luaScript)
        luaL_loadstring(luaState, ptrScript)
        free(ptrScript)
    }
    
//    deinit {
//        lua.destruct()
//    }
    
    private func getSettleCityScore(tile: Tile) throws -> Double {
//        let ptrFname = strdup("settle_score")
//        let value = lua_Number(0)
//        let value2 = lua_Number(33)
//        let result = lua.call(nil, method: ptrFname, p1: value, p2: value2)
        
        var luaStateEx: OpaquePointer!

        if (luaState != nil) {
            luaStateEx = luaState
        }

        lua_getglobal(luaStateEx, "settle_score");
        lua_pushnumber(luaStateEx, 1.0);
        lua_pushnumber(luaStateEx, 5.0);

        lua_pcallk(luaStateEx, 2, 1, 0, 0, nil);

//        let result = lua_tonumber(luaStateEx, -1);
//        lua_pop(luaStateEx, 1);
//        return result;
//        free(ptrFname)
        
        return Double(0.0)
    }
    
    public func getBuildCityScoreMap() throws -> [[Double]] {
        switch player.skillLevel {
        case .One:
            return try levelOneGetBuildCityScoreMap()
        case .Two:
            return try levelTwoGetBuildCityScoreMap()
        case .Three:
            fatalError("Not implemented yet")
        case .Four:
            fatalError("Not implemented yet")
        case .Five:
            fatalError("Not implemented yet")
        case .Six:
            fatalError("Not implemented yet")
        case .Seven:
            fatalError("Not implemented yet")
        case .Eight:
            fatalError("Not implemented yet")
        }
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
    
    private func levelOneGetBuildCityScoreMap() throws -> [[Double]] {
        var scoreMap: [[Double]] = Array(repeating: Array(repeating: 0.0,
                                                          count: player.map.width),
                                         count: player.map.height)
        
        for row in 0..<player.map.height {
            for col in 0..<player.map.width {
                let position = Position(row: row, col: col)
                let tile = player.map.tile(at: Position(row: row, col: col))
                
                if tile.isRevealed {
                    if player.map.canBuildCity(at: position) {
                        let distance = player.map.getDistanceFromNearestCity(from: position)
                        let score = 100 - distance
                        
                        if score < 0 {
                            scoreMap[row][col] = 0.0
                        }
                        else if score > 100 {
                            scoreMap[row][col] = 100.0
                        }
                        else {
                            scoreMap[row][col] = Double(score)
                        }
                    }
                    else {
                        scoreMap[row][col] = 0.0
                    }
                }
                else {
                    scoreMap[row][col] = 1.0
                }
                
            }
        }
        
        return scoreMap
    }
    
    private func levelTwoGetBuildCityScoreMap() throws -> [[Double]] {
        var scoreMap: [[Double]] = Array(repeating: Array(repeating: 0.0,
                                                          count: player.map.width),
                                         count: player.map.height)
        
        for row in 0..<player.map.height {
            for col in 0..<player.map.width {
                let position = Position(row: row, col: col)
                let tile = player.map.tile(at: position)
                
                if tile.isRevealed {
                    if player.map.canBuildCity(at: position) {
                        var score = Double(tile.food)
                        score += Double(tile.production)
                        score += Double(tile.trade)
                        score += tile.defenseBonus
                        
                        if score < 0.0 {
                            scoreMap[row][col] = 0.0
                        }
                        else {
                            scoreMap[row][col] = score
                        }
                    }
                    else {
                        scoreMap[row][col] = 0.0
                    }
                }
                else {
                    scoreMap[row][col] = 1.0
                }
                
            }
        }
        
        return scoreMap
    }
}
