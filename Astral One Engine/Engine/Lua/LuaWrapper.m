#include "LuaWrapper.h"


LUAMOD_API int luaopen_os (lua_State *L) {
    return 1;
}

@implementation Lua

- (void) setup {
    luaState = luaL_newstate();
    luaL_openlibs(luaState);
}

- (void) script: (const char *) script {
    luaL_loadstring(luaState, script);
    lua_pcall(luaState, 0, 0, 0);
}

- (void) destruct {
    lua_close(luaState);
}

- (LUA_NUMBER) call: (lua_State *) state
             method:  (const char *) method
                 p1: (LUA_NUMBER) p1
                 p2: (LUA_NUMBER) p2 {
    
    lua_State * luaStateEx = luaState;
    
    if (state != Nil) {
        luaStateEx = state;
    }
    
    lua_getglobal(luaStateEx, method);
    lua_pushnumber(luaStateEx, p1);
    lua_pushnumber(luaStateEx, p2);
    
    lua_pcall(luaStateEx, 2, 1, 0);
    
    LUA_NUMBER result = lua_tonumber(luaStateEx, -1);
    lua_pop(luaStateEx, 1);
    return result;
}

- (void) registerFunction: (lua_CFunction)function
                 withName: (const char *)name {
    lua_register(luaState, name, function);
}

@end
