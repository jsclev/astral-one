//
//  LuaUtil.swift
//  Engine
//
//  Created by John Cleveland on 5/22/22.
//

import Foundation

public class LuaUtil {
    public init() {
//        let filename = Bundle.main.path(forResource: "script",
//                                        ofType: "lua")!
//        do {
//            let lua = Lua()
//            lua.setup()
//
//            let luaScript = try String(contentsOfFile: filename)
//            let ptrScript = strdup(luaScript)
//            lua.script(ptrScript)
//            free(ptrScript)
//
//            let ptrFname = strdup("settle_score")
//            let value = lua_Number(0)
//            let value2 = lua_Number(33)
//            let result = lua.call(nil, method: ptrFname, p1: value, p2: value2)
//            free(ptrFname)
//
//            print(result)
//
//            lua.destruct()
//        } catch let error {
//            print("can not read file", filename, error)
//        }
    }
    
    public func getSettleCityScore(player: Player, tile: Tile) throws -> Double {
        let filename = Bundle.main.path(forResource: "settler",
                                        ofType: "lua")!
        let lua = Lua()
        lua.setup()
        
        let luaScript = try String(contentsOfFile: filename)
        let ptrScript = strdup(luaScript)
        lua.script(ptrScript)
        free(ptrScript)
        
        let ptrFname = strdup("settle_score")
        let value = lua_Number(0)
        let value2 = lua_Number(33)
        let result = lua.call(nil, method: ptrFname, p1: value, p2: value2)
        free(ptrFname)
        
        print(result)
        
        lua.destruct()
        
        return Double(result)
    }
    
    public func getBuildScore(player: Player, tile: Tile) throws -> Double {
        let filename = Bundle.main.path(forResource: "defensive_ai",
                                        ofType: "lua")!
        let lua = Lua()
        lua.setup()
        
        let luaScript = try String(contentsOfFile: filename)
        let ptrScript = strdup(luaScript)
        lua.script(ptrScript)
        free(ptrScript)
        
        let ptrFname = strdup("settle_score")
        let value = lua_Number(0)
        let value2 = lua_Number(33)
        let result = lua.call(nil, method: ptrFname, p1: value, p2: value2)
        free(ptrFname)
        
        print(result)
        
        lua.destruct()
        
        return Double(result)
    }
}
