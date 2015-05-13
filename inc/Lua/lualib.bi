#pragma once

#include once "lua.bi"

extern "C"

#define lualib_h

declare function luaopen_base(byval L as lua_State ptr) as long

#define LUA_COLIBNAME "coroutine"

declare function luaopen_coroutine(byval L as lua_State ptr) as long

#define LUA_TABLIBNAME "table"

declare function luaopen_table(byval L as lua_State ptr) as long

#define LUA_IOLIBNAME "io"

declare function luaopen_io(byval L as lua_State ptr) as long

#define LUA_OSLIBNAME "os"

declare function luaopen_os(byval L as lua_State ptr) as long

#define LUA_STRLIBNAME "string"

declare function luaopen_string(byval L as lua_State ptr) as long

#define LUA_BITLIBNAME "bit32"

declare function luaopen_bit32(byval L as lua_State ptr) as long

#define LUA_MATHLIBNAME "math"

declare function luaopen_math(byval L as lua_State ptr) as long

#define LUA_DBLIBNAME "debug"

declare function luaopen_debug(byval L as lua_State ptr) as long

#define LUA_LOADLIBNAME "package"

declare function luaopen_package(byval L as lua_State ptr) as long
declare sub luaL_openlibs(byval L as lua_State ptr)

end extern
