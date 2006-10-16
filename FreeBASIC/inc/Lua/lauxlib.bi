''
''
'' lauxlib -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __lua_lauxlib_bi__
#define __lua_lauxlib_bi__

#include once "Lua/lua.bi"

#define luaL_getn(L,i) cint(lua_objlen(L, i))
#define luaL_setn(L,i,j)

#define LUA_ERRFILE (5+1)

type luaL_Reg
	name as zstring ptr
	func as lua_CFunction
end type

declare sub luaL_openlib cdecl alias "luaL_openlib" (byval L as lua_State ptr, byval libname as zstring ptr, byval l as luaL_Reg ptr, byval nup as integer)
declare sub luaL_register cdecl alias "luaL_register" (byval L as lua_State ptr, byval libname as zstring ptr, byval l as luaL_Reg ptr)
declare function luaL_getmetafield cdecl alias "luaL_getmetafield" (byval L as lua_State ptr, byval obj as integer, byval e as zstring ptr) as integer
declare function luaL_callmeta cdecl alias "luaL_callmeta" (byval L as lua_State ptr, byval obj as integer, byval e as zstring ptr) as integer
declare function luaL_typerror cdecl alias "luaL_typerror" (byval L as lua_State ptr, byval narg as integer, byval tname as zstring ptr) as integer
declare function luaL_argerror cdecl alias "luaL_argerror" (byval L as lua_State ptr, byval numarg as integer, byval extramsg as zstring ptr) as integer
declare function luaL_checklstring cdecl alias "luaL_checklstring" (byval L as lua_State ptr, byval numArg as integer, byval l as size_t ptr) as zstring ptr
declare function luaL_optlstring cdecl alias "luaL_optlstring" (byval L as lua_State ptr, byval numArg as integer, byval def as zstring ptr, byval l as size_t ptr) as zstring ptr
declare function luaL_checknumber cdecl alias "luaL_checknumber" (byval L as lua_State ptr, byval numArg as integer) as lua_Number
declare function luaL_optnumber cdecl alias "luaL_optnumber" (byval L as lua_State ptr, byval nArg as integer, byval def as lua_Number) as lua_Number
declare function luaL_checkinteger cdecl alias "luaL_checkinteger" (byval L as lua_State ptr, byval numArg as integer) as lua_Integer
declare function luaL_optinteger cdecl alias "luaL_optinteger" (byval L as lua_State ptr, byval nArg as integer, byval def as lua_Integer) as lua_Integer
declare sub luaL_checkstack cdecl alias "luaL_checkstack" (byval L as lua_State ptr, byval sz as integer, byval msg as zstring ptr)
declare sub luaL_checktype cdecl alias "luaL_checktype" (byval L as lua_State ptr, byval narg as integer, byval t as integer)
declare sub luaL_checkany cdecl alias "luaL_checkany" (byval L as lua_State ptr, byval narg as integer)
declare function luaL_newmetatable cdecl alias "luaL_newmetatable" (byval L as lua_State ptr, byval tname as zstring ptr) as integer
declare function luaL_checkudata cdecl alias "luaL_checkudata" (byval L as lua_State ptr, byval ud as integer, byval tname as zstring ptr) as any ptr
declare sub luaL_where cdecl alias "luaL_where" (byval L as lua_State ptr, byval lvl as integer)
declare function luaL_error cdecl alias "luaL_error" (byval L as lua_State ptr, byval fmt as zstring ptr, ...) as integer
declare function luaL_checkoption cdecl alias "luaL_checkoption" (byval L as lua_State ptr, byval narg as integer, byval def as zstring ptr, byval lst as byte ptr ptr) as integer
declare function luaL_ref cdecl alias "luaL_ref" (byval L as lua_State ptr, byval t as integer) as integer
declare sub luaL_unref cdecl alias "luaL_unref" (byval L as lua_State ptr, byval t as integer, byval ref as integer)
declare function luaL_loadfile cdecl alias "luaL_loadfile" (byval L as lua_State ptr, byval filename as zstring ptr) as integer
declare function luaL_loadbuffer cdecl alias "luaL_loadbuffer" (byval L as lua_State ptr, byval buff as zstring ptr, byval sz as size_t, byval name as zstring ptr) as integer
declare function luaL_loadstring cdecl alias "luaL_loadstring" (byval L as lua_State ptr, byval s as zstring ptr) as integer
declare function luaL_newstate cdecl alias "luaL_newstate" () as lua_State ptr
declare function luaL_gsub cdecl alias "luaL_gsub" (byval L as lua_State ptr, byval s as zstring ptr, byval p as zstring ptr, byval r as zstring ptr) as zstring ptr
declare function luaL_findtable cdecl alias "luaL_findtable" (byval L as lua_State ptr, byval idx as integer, byval fname as zstring ptr, byval szhint as integer) as zstring ptr

#define luaL_argcheck(L, cond,numarg,extramsg) luaL_argerror(L, (numarg), (extramsg))
#define luaL_checkstring(L,n) luaL_checklstring(L, (n), NULL)
#define luaL_optstring(L,n,d) luaL_optlstring(L, (n), (d), NULL)
#define luaL_checkint(L,n) cast(int, luaL_checkinteger(L, (n)))
#define luaL_optint(L,n,d) cast(int, luaL_optinteger(L, (n), (d)))
#define luaL_checklong(L,n) cast(long, luaL_checkinteger(L, (n)))
#define luaL_optlong(L,n,d) cast(long, luaL_optinteger(L, (n), (d)))

#define luaL_typename(L,i) lua_typename(L, lua_type(L,(i)))

private function luaL_dofile(byval L as lua_State ptr, byval fn as zstring ptr) as integer
	if luaL_loadfile(L, fn) then
		function = 1
	else
		function = lua_pcall(L, 0, LUA_MULTRET, 0)
	end if
end function

private function luaL_dostring(byval L as lua_State ptr, byval s as zstring ptr) as integer
	if luaL_loadstring(L, s) then
		function = 1
	else
		function = lua_pcall(L, 0, LUA_MULTRET, 0)
	end if
end function

#define luaL_getmetatable(L,n) lua_getfield(L, LUA_REGISTRYINDEX, (n))
#define luaL_opt(L,f,n,d) iif( lua_isnoneornil(L,(n)), d, f(L,(n)) )

#define LUAL_BUFFERSIZE 8192

type luaL_Buffer
	p as byte ptr
	lvl as integer
	L as lua_State ptr
	buffer(0 to LUAL_BUFFERSIZE-1) as byte
end type

#define luaL_addchar(B,c) if( B->p >= @B->buffer(LUAL_BUFFERSIZE) ) then luaL_prepbuffer( B ) end if : B->p = c : B->p += 1
#define luaL_putchar(B,c) luaL_addchar(B,c)
#define luaL_addsize(B,n) (B)->p += (n)

declare sub luaL_buffinit cdecl alias "luaL_buffinit" (byval L as lua_State ptr, byval B as luaL_Buffer ptr)
declare function luaL_prepbuffer cdecl alias "luaL_prepbuffer" (byval B as luaL_Buffer ptr) as zstring ptr
declare sub luaL_addlstring cdecl alias "luaL_addlstring" (byval B as luaL_Buffer ptr, byval s as zstring ptr, byval l as size_t)
declare sub luaL_addstring cdecl alias "luaL_addstring" (byval B as luaL_Buffer ptr, byval s as zstring ptr)
declare sub luaL_addvalue cdecl alias "luaL_addvalue" (byval B as luaL_Buffer ptr)
declare sub luaL_pushresult cdecl alias "luaL_pushresult" (byval B as luaL_Buffer ptr)

#define LUA_NOREF (-2)
#define LUA_REFNIL (-1)

private function lua_ref(byval L as lua_State ptr, byval lock_ as integer) as integer
	if lock_ then
		function = luaL_ref(L, LUA_REGISTRYINDEX)
	else
		lua_pushstring(L, "unlocked references are obsolete")
		lua_error(L)
		function = 0
	end if
end function

#define lua_unref(L,ref) luaL_unref(L, LUA_REGISTRYINDEX, (ref))

#define lua_getref(L,ref) lua_rawgeti(L, LUA_REGISTRYINDEX, (ref))

#endif
