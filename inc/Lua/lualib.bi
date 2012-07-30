''
''
'' lualib -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __lua_lualib_bi__
#define __lua_lualib_bi__

#include once "lua.bi"

#define LUA_FILEHANDLE "FILE*"
#define LUA_COLIBNAME "coroutine"
#define LUA_TABLIBNAME "table"
#define LUA_IOLIBNAME "io"
#define LUA_OSLIBNAME "os"
#define LUA_STRLIBNAME "string"
#define LUA_MATHLIBNAME "math"
#define LUA_DBLIBNAME "debug"
#define LUA_LOADLIBNAME "package"

extern "c"
declare function luaopen_base (byval L as lua_State ptr) as integer
declare function luaopen_table (byval L as lua_State ptr) as integer
declare function luaopen_io (byval L as lua_State ptr) as integer
declare function luaopen_os (byval L as lua_State ptr) as integer
declare function luaopen_string (byval L as lua_State ptr) as integer
declare function luaopen_math (byval L as lua_State ptr) as integer
declare function luaopen_debug (byval L as lua_State ptr) as integer
declare function luaopen_package (byval L as lua_State ptr) as integer
declare sub luaL_openlibs (byval L as lua_State ptr)
end extern

#ifndef lua_assert
#define lua_assert(x)
#endif

#endif
