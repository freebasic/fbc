''
'' $Id$
'' Lua standard libraries
'' See Copyright Notice in lua.h
''

#ifndef lualib_h_
#define lualib_h_

#inclib "lualib" 

#include once "Lua/lua.bi"


#ifndef LUALIB_API
#define LUALIB_API	LUA_API
#endif


#define LUA_COLIBNAME	"coroutine"
declare function luaopen_base LUALIB_API alias "luaopen_base"  (byval L as lua_State ptr) as integer

#define LUA_TABLIBNAME	"table"
declare function luaopen_table LUALIB_API alias "luaopen_table"  (byval L as lua_State ptr) as integer

#define LUA_IOLIBNAME	"io"
#define LUA_OSLIBNAME	"os"
declare function luaopen_io LUALIB_API alias "luaopen_io"  (byval L as lua_State ptr) as integer

#define LUA_STRLIBNAME	"string"
declare function luaopen_string LUALIB_API alias "luaopen_string"  (byval L as lua_State ptr) as integer

#define LUA_MATHLIBNAME	"math"
declare function luaopen_math LUALIB_API alias "luaopen_math"  (byval L as lua_State ptr) as integer

#define LUA_DBLIBNAME	"debug"
declare function luaopen_debug LUALIB_API alias "luaopen_debug"  (byval L as lua_State ptr) as integer


declare function luaopen_loadlib LUALIB_API alias "luaopen_loadlib"  (byval L as lua_State ptr) as integer

#endif
