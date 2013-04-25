''
''
'' lauxlib -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __lauxlib_bi__
#define __lauxlib_bi__

type luaL_Reg
	name as zstring ptr
	func as lua_CFunction
end type

type luaL_Reg as any

declare function luaL_getmetafield cdecl alias "luaL_getmetafield" (byval L as lua_State ptr, byval obj as integer, byval e as zstring ptr) as integer
declare function luaL_callmeta cdecl alias "luaL_callmeta" (byval L as lua_State ptr, byval obj as integer, byval e as zstring ptr) as integer
declare function luaL_tolstring cdecl alias "luaL_tolstring" (byval L as lua_State ptr, byval idx as integer, byval len as size_t ptr) as zstring ptr
declare function luaL_argerror cdecl alias "luaL_argerror" (byval L as lua_State ptr, byval numarg as integer, byval extramsg as zstring ptr) as integer
declare function luaL_checklstring cdecl alias "luaL_checklstring" (byval L as lua_State ptr, byval numArg as integer, byval l as size_t ptr) as zstring ptr
declare function luaL_optlstring cdecl alias "luaL_optlstring" (byval L as lua_State ptr, byval numArg as integer, byval def as zstring ptr, byval l as size_t ptr) as zstring ptr
declare function lua_Number cdecl alias "lua_Number" (byval as luaL_checknumber) as LUALIB_API
declare function lua_Number cdecl alias "lua_Number" (byval as luaL_optnumber) as LUALIB_API
declare function lua_Integer cdecl alias "lua_Integer" (byval as luaL_checkinteger) as LUALIB_API
declare function lua_Integer cdecl alias "lua_Integer" (byval as luaL_optinteger) as LUALIB_API
declare function lua_Unsigned cdecl alias "lua_Unsigned" (byval as luaL_checkunsigned) as LUALIB_API
declare function lua_Unsigned cdecl alias "lua_Unsigned" (byval as luaL_optunsigned) as LUALIB_API
declare sub luaL_checkstack cdecl alias "luaL_checkstack" (byval L as lua_State ptr, byval sz as integer, byval msg as zstring ptr)
declare sub luaL_checktype cdecl alias "luaL_checktype" (byval L as lua_State ptr, byval narg as integer, byval t as integer)
declare sub luaL_checkany cdecl alias "luaL_checkany" (byval L as lua_State ptr, byval narg as integer)
declare function luaL_newmetatable cdecl alias "luaL_newmetatable" (byval L as lua_State ptr, byval tname as zstring ptr) as integer
declare sub luaL_setmetatable cdecl alias "luaL_setmetatable" (byval L as lua_State ptr, byval tname as zstring ptr)
declare function luaL_testudata cdecl alias "luaL_testudata" (byval L as lua_State ptr, byval ud as integer, byval tname as zstring ptr) as any ptr
declare function luaL_checkudata cdecl alias "luaL_checkudata" (byval L as lua_State ptr, byval ud as integer, byval tname as zstring ptr) as any ptr
declare sub luaL_where cdecl alias "luaL_where" (byval L as lua_State ptr, byval lvl as integer)
declare function luaL_error cdecl alias "luaL_error" (byval L as lua_State ptr, byval fmt as zstring ptr, ...) as integer
declare function luaL_checkoption cdecl alias "luaL_checkoption" (byval L as lua_State ptr, byval narg as integer, byval def as zstring ptr, byval lst as byte ptr ptr) as integer
declare function luaL_fileresult cdecl alias "luaL_fileresult" (byval L as lua_State ptr, byval stat as integer, byval fname as zstring ptr) as integer
declare function luaL_execresult cdecl alias "luaL_execresult" (byval L as lua_State ptr, byval stat as integer) as integer

#define LUA_NOREF (-2)
#define LUA_REFNIL (-1)

declare function luaL_ref cdecl alias "luaL_ref" (byval L as lua_State ptr, byval t as integer) as integer
declare sub luaL_unref cdecl alias "luaL_unref" (byval L as lua_State ptr, byval t as integer, byval ref as integer)
declare function luaL_loadfilex cdecl alias "luaL_loadfilex" (byval L as lua_State ptr, byval filename as zstring ptr, byval mode as zstring ptr) as integer
declare function luaL_loadbufferx cdecl alias "luaL_loadbufferx" (byval L as lua_State ptr, byval buff as zstring ptr, byval sz as size_t, byval name as zstring ptr, byval mode as zstring ptr) as integer
declare function luaL_loadstring cdecl alias "luaL_loadstring" (byval L as lua_State ptr, byval s as zstring ptr) as integer
declare function luaL_len cdecl alias "luaL_len" (byval L as lua_State ptr, byval idx as integer) as integer
declare function luaL_gsub cdecl alias "luaL_gsub" (byval L as lua_State ptr, byval s as zstring ptr, byval p as zstring ptr, byval r as zstring ptr) as zstring ptr
declare sub luaL_setfuncs cdecl alias "luaL_setfuncs" (byval L as lua_State ptr, byval l as luaL_Reg ptr, byval nup as integer)
declare function luaL_getsubtable cdecl alias "luaL_getsubtable" (byval L as lua_State ptr, byval idx as integer, byval fname as zstring ptr) as integer
declare sub luaL_traceback cdecl alias "luaL_traceback" (byval L as lua_State ptr, byval L1 as lua_State ptr, byval msg as zstring ptr, byval level as integer)
declare sub luaL_requiref cdecl alias "luaL_requiref" (byval L as lua_State ptr, byval modname as zstring ptr, byval openf as lua_CFunction, byval glb as integer)

type luaL_Buffer
	b as zstring ptr
	size as size_t
	n as size_t
	L as lua_State ptr
	initb as zstring * LUAL_BUFFERSIZE
end type

type luaL_Buffer as any

declare sub luaL_buffinit cdecl alias "luaL_buffinit" (byval L as lua_State ptr, byval B as luaL_Buffer ptr)
declare function luaL_prepbuffsize cdecl alias "luaL_prepbuffsize" (byval B as luaL_Buffer ptr, byval sz as size_t) as zstring ptr
declare sub luaL_addlstring cdecl alias "luaL_addlstring" (byval B as luaL_Buffer ptr, byval s as zstring ptr, byval l as size_t)
declare sub luaL_addstring cdecl alias "luaL_addstring" (byval B as luaL_Buffer ptr, byval s as zstring ptr)
declare sub luaL_addvalue cdecl alias "luaL_addvalue" (byval B as luaL_Buffer ptr)
declare sub luaL_pushresult cdecl alias "luaL_pushresult" (byval B as luaL_Buffer ptr)
declare sub luaL_pushresultsize cdecl alias "luaL_pushresultsize" (byval B as luaL_Buffer ptr, byval sz as size_t)
declare function luaL_buffinitsize cdecl alias "luaL_buffinitsize" (byval L as lua_State ptr, byval B as luaL_Buffer ptr, byval sz as size_t) as zstring ptr

#define LUA_FILEHANDLE "FILE*"

type luaL_Stream
	f as FILE ptr
	closef as lua_CFunction
end type

type luaL_Stream as any

#endif
