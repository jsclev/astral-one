//
//public final class LuaVM {
//    internal let state: OpaquePointer!
//
//    /// Holds all functions that were registered
////    internal var functions = [LuaFunction]()
//
//    internal init() {
//        self.state = luaL_newstate()
//    }
//
//    /// Create a new LuaVM from a lua_state pointer
//    ///
//    /// - Parameter state: The state pointer
//    internal init(state: OpaquePointer!) {
//        self.state = state
//    }
//
//    deinit {
//        lua_close(self.state)
//    }
//
//    internal func load(scriptName: String) {
//        luaL_loadstring(state, scriptName)
//        lua_pcallk(state, 0, 0, 0, 0, nil);
//    }
//
////    private func getSettleCityScore(functionName: String,
////                                    food: Int,
////                                    defenseBonus: Double) throws -> Double {
////        lua_getglobal(state, functionName);
////
////        let ptrFname = strdup(functionName)
////        let value = lua_Number(food)
////        let value2 = lua_Number(defenseBonus)
////        let result = lua_pcallk(self.state,
////                                2,
////                                1,
////                                messageHandlerIndex,
////                                0,
////                                nil)
////        //        let result = lua.call(nil, method: ptrFname, p1: value, p2: value2)
////        free(ptrFname)
////
////        return Double(result)
////    }
//
////    internal func protectedCall(nargs: Count, nrets: Count,
////                                messageHandlerIndex: Index = 0) throws {
////        let result = lua_pcallk(self.state,
////                                nargs, nrets,
////                                messageHandlerIndex,
////                                0, nil)
////        let status = Status(rawValue: result)
////        if status == .OK { return }
////        let message = self.getString(atIndex: TopIndex)!
////        self.pop(1)
////        switch status {
////        case .RunError:    throw LuaError.Runtime(message)
////        case .MemoryError: fatalError("Out of memory")
////        case .Error:       throw LuaError.MessageHandler(message)
////        case .ErrGCMM:     throw LuaError.GarbageCollector(message)
////        default:           fatalError("Unhandled Status: \(status)")
////        }
////    }
//
////    internal func getCitySettleScore() {
////        var luaStateEx: OpaquePointer!
////
////        if (state != nil) {
////            luaStateEx = state;
////        }
////
////        lua_getglobal(luaStateEx, "settle_score");
////        lua_pushnumber(luaStateEx, 1.0);
////        lua_pushnumber(luaStateEx, 5.0);
////
////        lua_pcallk(luaStateEx, 2, 1, 0, 0, nil);
////
////        let result = lua_tonumber(luaStateEx, -1);
////        lua_pop(luaStateEx, 1);
////        return result;
////    }
//}
//
////extension LuaVM {
////    /// Pop a key from the stack and push the next key-value pair from the table
////    /// at `Index`
////    ///
////    /// - Returns: `false` if there are no more pairs
////    /// ```
////    /// /* the table is in the stack at index 't' */
////    /// lua.raw.pushNil(); /* first key */
////    /// while lua.raw.next(atIndex: t) {
////    ///     /* 'key' (at `SecondIndex`) and 'value' (at `TopIndex`) */
////    ///     let value = lua.pop()
////    ///     /* keep 'key' for next iteration */
////    /// }
////    /// ```
////    ///
////    /// - Note: While traversing a table, do not call `getString(atIndex:)`
////    /// directly on a key, unless you know that the key is actually a string.
////    internal func next(atIndex index: Index) -> Bool {
////        return lua_next(self.state, index) != 0
////    }
////}
