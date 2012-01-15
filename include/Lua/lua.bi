''
''
'' lua -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __lua_lua_bi__
#define __lua_lua_bi__

#inclib "lua"

#include once "crt/stddef.bi"
#include once "crt/stdarg.bi"

#define LUA_VERSION "Lua 5.1"
#define LUA_RELEASE "Lua 5.1.1"
#define LUA_VERSION_NUM 501
#define LUA_COPYRIGHT "Copyright (C) 1994-2006 Lua.org, PUC-Rio"
#define LUA_AUTHORS "R. Ierusalimschy, L. H. de Figueiredo & W. Celes"
#define LUA_SIGNATURE "Lua"
#define LUA_MULTRET (-1)
#define LUA_REGISTRYINDEX (-10000)
#define LUA_ENVIRONINDEX (-10001)
#define LUA_GLOBALSINDEX (-10002)
#define LUA_YIELD_ 1
#define LUA_ERRRUN 2
#define LUA_ERRSYNTAX 3
#define LUA_ERRMEM 4
#define LUA_ERRERR 5

#define lua_upvalueindex(i)	(LUA_GLOBALSINDEX-(i))

type lua_State as any

type lua_CFunction as function cdecl(byval as lua_State ptr) as integer
type lua_Reader as function cdecl(byval as lua_State ptr, byval as any ptr, byval as size_t ptr) as byte ptr
type lua_Writer as function cdecl(byval as lua_State ptr, byval as any ptr, byval as size_t, byval as any ptr) as integer
type lua_Alloc as function cdecl(byval as any ptr, byval as any ptr, byval as size_t, byval as size_t) as any ptr

#define LUA_TNONE (-1)
#define LUA_TNIL 0
#define LUA_TBOOLEAN 1
#define LUA_TLIGHTUSERDATA 2
#define LUA_TNUMBER 3
#define LUA_TSTRING 4
#define LUA_TTABLE 5
#define LUA_TFUNCTION 6
#define LUA_TUSERDATA 7
#define LUA_TTHREAD 8
#define LUA_MINSTACK 20

type lua_Number as double
type lua_Integer as ptrdiff_t

#define LUA_GCSTOP 0
#define LUA_GCRESTART 1
#define LUA_GCCOLLECT 2
#define LUA_GCCOUNT 3
#define LUA_GCCOUNTB 4
#define LUA_GCSTEP 5
#define LUA_GCSETPAUSE 6
#define LUA_GCSETSTEPMUL 7

#define lua_pop(L,n) lua_settop(L, -(n)-1)
#define lua_newtable(L)	lua_createtable(L, 0, 0)
#define lua_register(L,n,f) lua_pushcfunction(L, (f)): lua_setglobal(L, (n))
#define lua_pushcfunction(L,f) lua_pushcclosure(L, (f), 0)
#define lua_strlen(L,i)	lua_objlen(L, (i))
#define lua_isfunction(L,n)	(lua_type(L, (n)) = LUA_TFUNCTION)
#define lua_istable(L,n) (lua_type(L, (n)) = LUA_TTABLE)
#define lua_islightuserdata(L,n) (lua_type(L, (n)) = LUA_TLIGHTUSERDATA)
#define lua_isnil(L,n) (lua_type(L, (n)) = LUA_TNIL)
#define lua_isboolean(L,n) (lua_type(L, (n)) = LUA_TBOOLEAN)
#define lua_isthread(L,n) (lua_type(L, (n)) = LUA_TTHREAD)
#define lua_isnone(L,n) (lua_type(L, (n)) = LUA_TNONE)
#define lua_isnoneornil(L, n) (lua_type(L, (n)) <= 0)
#define lua_pushliteral(L, s) lua_pushlstring(L, "" s, (sizeof(s)\sizeof(zstring))-1)
#define lua_setglobal(L,s) lua_setfield(L, LUA_GLOBALSINDEX, (s))
#define lua_getglobal(L,s) lua_getfield(L, LUA_GLOBALSINDEX, (s))
#define lua_tostring(L,i) lua_tolstring(L, (i), NULL)

#define lua_open() luaL_newstate()
#define lua_getregistry(L) lua_pushvalue(L, LUA_REGISTRYINDEX)
#define lua_getgccount(L) lua_gc(L, LUA_GCCOUNT, 0)
#define lua_Chunkreader	lua_Reader
#define lua_Chunkwriter	lua_Writer

#define LUA_HOOKCALL 0
#define LUA_HOOKRET 1
#define LUA_HOOKLINE 2
#define LUA_HOOKCOUNT 3
#define LUA_HOOKTAILRET 4
#define LUA_MASKCALL (1 shl 0)
#define LUA_MASKRET (1 shl 1)
#define LUA_MASKLINE (1 shl 2)
#define LUA_MASKCOUNT (1 shl 3)

type lua_Debug as lua_Debug_
type lua_Hook as sub cdecl(byval as lua_State ptr, byval as lua_Debug ptr)

#define LUA_IDSIZE 60

type lua_Debug_
	event as integer
	name as zstring ptr
	namewhat as zstring ptr
	what as zstring ptr
	source as zstring ptr
	currentline as integer
	nups as integer
	linedefined as integer
	lastlinedefined as integer
	short_src as zstring * LUA_IDSIZE
	i_ci as integer
end type

extern "c"
declare function lua_newstate (byval f as lua_Alloc, byval ud as any ptr) as lua_State ptr
declare sub lua_close (byval L as lua_State ptr)
declare function lua_newthread (byval L as lua_State ptr) as lua_State ptr
declare function lua_atpanic (byval L as lua_State ptr, byval panicf as lua_CFunction) as lua_CFunction
declare function lua_gettop (byval L as lua_State ptr) as integer
declare sub lua_settop (byval L as lua_State ptr, byval idx as integer)
declare sub lua_pushvalue (byval L as lua_State ptr, byval idx as integer)
declare sub lua_remove (byval L as lua_State ptr, byval idx as integer)
declare sub lua_insert (byval L as lua_State ptr, byval idx as integer)
declare sub lua_replace (byval L as lua_State ptr, byval idx as integer)
declare function lua_checkstack (byval L as lua_State ptr, byval sz as integer) as integer
declare sub lua_xmove (byval from as lua_State ptr, byval to as lua_State ptr, byval n as integer)
declare function lua_isnumber (byval L as lua_State ptr, byval idx as integer) as integer
declare function lua_isstring (byval L as lua_State ptr, byval idx as integer) as integer
declare function lua_iscfunction (byval L as lua_State ptr, byval idx as integer) as integer
declare function lua_isuserdata (byval L as lua_State ptr, byval idx as integer) as integer
declare function lua_type (byval L as lua_State ptr, byval idx as integer) as integer
declare function lua_typename (byval L as lua_State ptr, byval tp as integer) as zstring ptr
declare function lua_equal (byval L as lua_State ptr, byval idx1 as integer, byval idx2 as integer) as integer
declare function lua_rawequal (byval L as lua_State ptr, byval idx1 as integer, byval idx2 as integer) as integer
declare function lua_lessthan (byval L as lua_State ptr, byval idx1 as integer, byval idx2 as integer) as integer
declare function lua_tonumber (byval L as lua_State ptr, byval idx as integer) as lua_Number
declare function lua_tointeger (byval L as lua_State ptr, byval idx as integer) as lua_Integer
declare function lua_toboolean (byval L as lua_State ptr, byval idx as integer) as integer
declare function lua_tolstring (byval L as lua_State ptr, byval idx as integer, byval len as size_t ptr) as zstring ptr
declare function lua_objlen (byval L as lua_State ptr, byval idx as integer) as size_t
declare function lua_tocfunction (byval L as lua_State ptr, byval idx as integer) as lua_CFunction
declare function lua_touserdata (byval L as lua_State ptr, byval idx as integer) as any ptr
declare function lua_tothread (byval L as lua_State ptr, byval idx as integer) as lua_State ptr
declare function lua_topointer (byval L as lua_State ptr, byval idx as integer) as any ptr
declare sub lua_pushnil (byval L as lua_State ptr)
declare sub lua_pushnumber (byval L as lua_State ptr, byval n as lua_Number)
declare sub lua_pushinteger (byval L as lua_State ptr, byval n as lua_Integer)
declare sub lua_pushlstring (byval L as lua_State ptr, byval s as zstring ptr, byval l as size_t)
declare sub lua_pushstring (byval L as lua_State ptr, byval s as zstring ptr)
declare function lua_pushvfstring (byval L as lua_State ptr, byval fmt as zstring ptr, byval argp as va_list) as zstring ptr
declare function lua_pushfstring (byval L as lua_State ptr, byval fmt as zstring ptr, ...) as zstring ptr
declare sub lua_pushcclosure (byval L as lua_State ptr, byval fn as lua_CFunction, byval n as integer)
declare sub lua_pushboolean (byval L as lua_State ptr, byval b as integer)
declare sub lua_pushlightuserdata (byval L as lua_State ptr, byval p as any ptr)
declare function lua_pushthread (byval L as lua_State ptr) as integer
declare sub lua_gettable (byval L as lua_State ptr, byval idx as integer)
declare sub lua_getfield (byval L as lua_State ptr, byval idx as integer, byval k as zstring ptr)
declare sub lua_rawget (byval L as lua_State ptr, byval idx as integer)
declare sub lua_rawgeti (byval L as lua_State ptr, byval idx as integer, byval n as integer)
declare sub lua_createtable (byval L as lua_State ptr, byval narr as integer, byval nrec as integer)
declare function lua_newuserdata (byval L as lua_State ptr, byval sz as size_t) as any ptr
declare function lua_getmetatable (byval L as lua_State ptr, byval objindex as integer) as integer
declare sub lua_getfenv (byval L as lua_State ptr, byval idx as integer)
declare sub lua_settable (byval L as lua_State ptr, byval idx as integer)
declare sub lua_setfield (byval L as lua_State ptr, byval idx as integer, byval k as zstring ptr)
declare sub lua_rawset (byval L as lua_State ptr, byval idx as integer)
declare sub lua_rawseti (byval L as lua_State ptr, byval idx as integer, byval n as integer)
declare function lua_setmetatable (byval L as lua_State ptr, byval objindex as integer) as integer
declare function lua_setfenv (byval L as lua_State ptr, byval idx as integer) as integer
declare sub lua_call (byval L as lua_State ptr, byval nargs as integer, byval nresults as integer)
declare function lua_pcall (byval L as lua_State ptr, byval nargs as integer, byval nresults as integer, byval errfunc as integer) as integer
declare function lua_cpcall (byval L as lua_State ptr, byval func as lua_CFunction, byval ud as any ptr) as integer
declare function lua_load (byval L as lua_State ptr, byval reader as lua_Reader, byval dt as any ptr, byval chunkname as zstring ptr) as integer
declare function lua_dump (byval L as lua_State ptr, byval writer as lua_Writer, byval data as any ptr) as integer
declare function lua_yield (byval L as lua_State ptr, byval nresults as integer) as integer
declare function lua_resume (byval L as lua_State ptr, byval narg as integer) as integer
declare function lua_status (byval L as lua_State ptr) as integer
declare function lua_gc (byval L as lua_State ptr, byval what as integer, byval data as integer) as integer
declare function lua_error (byval L as lua_State ptr) as integer
declare function lua_next (byval L as lua_State ptr, byval idx as integer) as integer
declare sub lua_concat (byval L as lua_State ptr, byval n as integer)
declare function lua_getallocf (byval L as lua_State ptr, byval ud as any ptr ptr) as lua_Alloc
declare sub lua_setallocf (byval L as lua_State ptr, byval f as lua_Alloc, byval ud as any ptr)
declare function lua_getstack (byval L as lua_State ptr, byval level as integer, byval ar as lua_Debug ptr) as integer
declare function lua_getinfo (byval L as lua_State ptr, byval what as zstring ptr, byval ar as lua_Debug ptr) as integer
declare function lua_getlocal (byval L as lua_State ptr, byval ar as lua_Debug ptr, byval n as integer) as zstring ptr
declare function lua_setlocal (byval L as lua_State ptr, byval ar as lua_Debug ptr, byval n as integer) as zstring ptr
declare function lua_getupvalue (byval L as lua_State ptr, byval funcindex as integer, byval n as integer) as zstring ptr
declare function lua_setupvalue (byval L as lua_State ptr, byval funcindex as integer, byval n as integer) as zstring ptr
declare function lua_sethook (byval L as lua_State ptr, byval func as lua_Hook, byval mask as integer, byval count as integer) as integer
declare function lua_gethook (byval L as lua_State ptr) as lua_Hook
declare function lua_gethookmask (byval L as lua_State ptr) as integer
declare function lua_gethookcount (byval L as lua_State ptr) as integer
end extern

#endif
