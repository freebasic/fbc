#ifndef lua_h_
#define lua_h_

#inclib "lua"

''
'' $Id$
'' Lua - An Extensible Extension Language
'' Tecgraf: Computer Graphics Technology Group, PUC-Rio, Brazil
'' http://www.lua.org	mailto:info@lua.org
'' See Copyright Notice at the end of this file
''

'' option for multiple returns in `lua_pcall' and `lua_call'
#define LUA_MULTRET	(-1)

''
'' pseudo-indices
''
#define LUA_REGISTRYINDEX	(-10000)
#define LUA_GLOBALSINDEX	(-10001)
#define lua_upvalueindex(i)	(LUA_GLOBALSINDEX-(i))


'' error codes for `lua_load' and `lua_pcall'
#define LUA_ERRRUN	1
#define LUA_ERRFILE	2
#define LUA_ERRSYNTAX	3
#define LUA_ERRMEM	4
#define LUA_ERRERR	5


type lua_State as any

type lua_CFunction as function cdecl(byval L as lua_State ptr) as integer


''
'' functions that read/write blocks when loading/dumping Lua chunks
''
type lua_Chunkreader as function cdecl(byval L as lua_State ptr, byval ud as any ptr, byval sz as integer ptr) as zstring ptr

type lua_Chunkwriter as function cdecl(byval L as lua_State ptr, byval p as any ptr, byval sz as integer, byval ud as any ptr ) as integer


''
'' basic types
''
#define LUA_TNONE	(-1)

#define LUA_TNIL	0
#define LUA_TBOOLEAN	1
#define LUA_TLIGHTUSERDATA	2
#define LUA_TNUMBER	3
#define LUA_TSTRING	4
#define LUA_TTABLE	5
#define LUA_TFUNCTION	6
#define LUA_TUSERDATA	7
#define LUA_TTHREAD	8


'' minimum Lua stack available to a C function 
#define LUA_MINSTACK	20


''
'' generic extra include file
''
#ifdef LUA_USER_H
#include LUA_USER_H
#endif


'' type of numbers in Lua
#ifndef LUA_NUMBER
#define LUA_NUMBER double
#endif


'' mark for all API functions
#ifndef LUA_API
#define LUA_API		cdecl
#endif


''
'' state manipulation
''
declare function lua_open LUA_API alias "lua_open" () as lua_State ptr
declare sub lua_close LUA_API alias "lua_close" (byval L as lua_State ptr)
declare function lua_newthread LUA_API alias "lua_newthread" (byval L as lua_State ptr) as lua_State ptr

declare function lua_atpanic LUA_API alias "lua_atpanic" (byval L as lua_State ptr, byval panicf as lua_CFunction) as lua_CFunction


''
'' basic stack manipulation
''
declare function lua_gettop LUA_API alias "lua_gettop" (byval L as lua_State ptr) as integer
declare sub lua_settop LUA_API alias "lua_settop" (byval L as lua_State ptr, byval idx as integer)
declare sub lua_pushvalue LUA_API alias "lua_pushvalue" (byval L as lua_State ptr, byval idx as integer)
declare sub lua_remove LUA_API alias "lua_remove" (byval L as lua_State ptr, byval idx as integer)
declare sub lua_insert LUA_API alias "lua_insert" (byval L as lua_State ptr, byval idx as integer)
declare sub lua_replace LUA_API alias "lua_replace" (byval L as lua_State ptr, byval idx as integer)
declare function lua_checkstack LUA_API alias "lua_checkstack" (byval L as lua_State ptr, byval sz as integer) as integer

declare sub lua_xmove LUA_API alias "lua_xmove" (byval from as lua_State ptr, byval to as lua_State ptr, byval n as integer)


''
'' access functions (stack -> C)
''

declare function lua_isnumber LUA_API alias "lua_isnumber" (byval L as lua_State ptr, byval idx as integer) as integer
declare function lua_isstring LUA_API alias "lua_isstring" (byval L as lua_State ptr, byval idx as integer) as integer
declare function lua_iscfunction LUA_API alias "lua_iscfunction" (byval L as lua_State ptr, byval idx as integer) as integer
declare function lua_isuserdata LUA_API alias "lua_isuserdata" (byval L as lua_State ptr, byval idx as integer) as integer
declare function lua_type LUA_API alias "lua_type" (byval L as lua_State ptr, byval idx as integer) as integer
declare function lua_typename LUA_API alias "lua_typename" (byval L as lua_State ptr, byval tp as integer) as zstring ptr

declare function lua_equal LUA_API alias "lua_equal" (byval L as lua_State ptr, byval idx1 as integer, byval idx2 as integer) as integer
declare function lua_rawequal LUA_API alias "lua_rawequal" (byval L as lua_State ptr, byval idx1 as integer, byval idx2 as integer) as integer
declare function lua_lessthan LUA_API alias "lua_lessthan" (byval L as lua_State ptr, byval idx1 as integer, byval idx2 as integer) as integer

declare function lua_tonumber LUA_API alias "lua_tonumber" (byval L as lua_State ptr, byval idx as integer) as lua_Number
declare function lua_toboolean LUA_API alias "lua_toboolean" (byval L as lua_State ptr, byval idx as integer) as integer
declare function lua_tostring LUA_API alias "lua_tostring" (byval L as lua_State ptr, byval idx as integer) as zstring ptr
declare function lua_strlen LUA_API alias "lua_strlen" (byval L as lua_State ptr, byval idx as integer) as integer
declare function lua_tocfunction LUA_API alias "lua_tocfunction" (byval L as lua_State ptr, byval idx as integer) as lua_CFunction
declare function lua_touserdata LUA_API alias "lua_touserdata" (byval L as lua_State ptr, byval idx as integer) as any ptr
declare function lua_tothread LUA_API alias "lua_tothread" (byval L as lua_State ptr, byval idx as integer) as lua_State ptr
declare function lua_topointer LUA_API alias "lua_topointer" (byval L as lua_State ptr, byval idx as integer) as any ptr


''
'' push functions (C -> stack)
''
declare sub lua_pushnil LUA_API alias "lua_pushnil" (byval L as lua_State ptr)
declare sub lua_pushnumber LUA_API alias "lua_pushnumber" (byval L as lua_State ptr, byval n as lua_Number)
declare sub lua_pushlstring LUA_API alias "lua_pushlstring" (byval L as lua_State ptr, byval s as zstring ptr, byval l as integer)
declare sub lua_pushstring LUA_API alias "lua_pushstring" (byval L as lua_State ptr, byval s as zstring ptr)
declare function lua_pushvfstring LUA_API alias "lua_pushvfstring" (byval L as lua_State ptr, byval fmt as zstring ptr, byval argp as any ptr ) as zstring ptr
declare function lua_pushfstring LUA_API alias "lua_pushfstring" (byval L as lua_State ptr, byval fmt as zstring ptr, ...) as zstring ptr
declare sub lua_pushcclosure LUA_API alias "lua_pushcclosure" (byval L as lua_State ptr, byval fn as lua_CFunction, byval n as integer)
declare sub lua_pushboolean LUA_API alias "lua_pushboolean" (byval L as lua_State ptr, byval b as integer)
declare sub lua_pushlightuserdata LUA_API alias "lua_pushlightuserdata" (byval L as lua_State ptr, byval p as any ptr)


''
'' get functions (Lua -> stack)
''
declare sub lua_gettable LUA_API alias "lua_gettable" (byval L as lua_State ptr, byval idx as integer)
declare sub lua_rawget LUA_API alias "lua_rawget" (byval L as lua_State ptr, byval idx as integer)
declare sub lua_rawgeti LUA_API alias "lua_rawgeti" (byval L as lua_State ptr, byval idx as integer, byval n as integer)
declare sub lua_newtable LUA_API alias "lua_newtable" (byval L as lua_State ptr)
declare function lua_newuserdata LUA_API alias "lua_newuserdata" (byval L as lua_State ptr, byval sz as integer) as any ptr
declare function lua_getmetatable LUA_API alias "lua_getmetatable" (byval L as lua_State ptr, byval objindex as integer) as integer
declare sub lua_getfenv LUA_API alias "lua_getfenv" (byval L as lua_State ptr, byval idx as integer)


''
'' set functions (stack -> Lua)
''
declare sub lua_settable LUA_API alias "lua_settable" (byval L as lua_State ptr, byval idx as integer)
declare sub lua_rawset LUA_API alias "lua_rawset" (byval L as lua_State ptr, byval idx as integer)
declare sub lua_rawseti LUA_API alias "lua_rawseti" (byval L as lua_State ptr, byval idx as integer, byval n as integer)
declare function lua_setmetatable LUA_API alias "lua_setmetatable" (byval L as lua_State ptr, byval objindex as integer) as integer
declare function lua_setfenv LUA_API alias "lua_setfenv" (byval L as lua_State ptr, byval idx as integer) as integer


''
'' `load' and `call' functions (load and run Lua code)
''
declare sub lua_call LUA_API alias "lua_call" (byval L as lua_State ptr, byval nargs as integer, byval nresults as integer)
declare function lua_pcall LUA_API alias "lua_pcall" (byval L as lua_State ptr, byval nargs as integer, byval nresults as integer, byval errfunc as integer) as integer
declare function lua_cpcall LUA_API alias "lua_cpcall" (byval L as lua_State ptr, byval func as lua_CFunction, byval ud as any ptr) as integer
declare function lua_load LUA_API alias "lua_load" (byval L as lua_State ptr, byval reader as lua_Chunkreader, byval dt as any ptr, byval chunkname as zstring ptr) as integer

declare function lua_dump LUA_API alias "lua_dump" (byval L as lua_State ptr, byval writer as lua_Chunkwriter, byval data as any ptr) as integer


''
'' coroutine functions
''
declare function lua_yield LUA_API alias "lua_yield" (byval L as lua_State ptr, byval nresults as integer) as integer
declare function lua_resume LUA_API alias "lua_resume" (byval L as lua_State ptr, byval narg as integer) as integer

''
'' garbage-collection functions
''
declare function lua_getgcthreshold LUA_API alias "lua_getgcthreshold" (byval L as lua_State ptr) as integer
declare function lua_getgccount LUA_API alias "lua_getgccount" (byval L as lua_State ptr) as integer
declare sub lua_setgcthreshold LUA_API alias "lua_setgcthreshold" (byval L as lua_State ptr, byval newthreshold as integer)

''
'' miscellaneous functions
''

declare function lua_version LUA_API alias "lua_version" () as zstring ptr

declare function lua_error LUA_API alias "lua_error" (byval L as lua_State ptr) as integer

declare function lua_next LUA_API alias "lua_next" (byval L as lua_State ptr, byval idx as integer) as integer

declare sub lua_concat LUA_API alias "lua_concat" (byval L as lua_State ptr, byval n as integer)


'' 
'' ===============================================================
'' some useful macros
'' ===============================================================
''

#define lua_boxpointer(L,u) *lua_newuserdata(L,len(any ptr)) = (u)	'' (*(void **)(lua_newuserdata(L, sizeof(void *))) = (u))

#define lua_unboxpointer(L,i) lua_touserdata(L,i) '' (*(void **)(lua_touserdata(L, i)))

#define lua_pop(L,n) lua_settop(L,-(n)-1)

#define lua_pushcfunction(L,f) lua_pushcclosure(L,f,0)

#define lua_register(L,n,f) lua_pushstring(L,n) : lua_pushcfunction(L,f) : lua_settable(L,LUA_GLOBALSINDEX)

#define lua_isfunction(L,n) (lua_type(L,n) = LUA_TFUNCTION)

#define lua_istable(L,n) (lua_type(L,n) = LUA_TTABLE)

#define lua_islightuserdata(L,n) (lua_type(L,n) = LUA_TLIGHTUSERDATA)

#define lua_isnil(L,n) (lua_type(L,n) = LUA_TNIL)

#define lua_isboolean(L,n) (lua_type(L,n) = LUA_TBOOLEAN)

#define lua_isnone(L,n) (lua_type(L,n) = LUA_TNONE)

#define lua_isnoneornil(L,n) (lua_type(L,n) <= 0)

#define lua_pushliteral(L,s) lua_pushlstring(L,s,len( s ))


''
'' {======================================================================
'' Debug API
'' =======================================================================
''


''
'' Event codes
''
#define LUA_HOOKCALL	0
#define LUA_HOOKRET	1
#define LUA_HOOKLINE	2
#define LUA_HOOKCOUNT	3
#define LUA_HOOKTAILRET 4


''
'' Event masks
''
#define LUA_MASKCALL	(1 shl LUA_HOOKCALL)
#define LUA_MASKRET	(1 shl LUA_HOOKRET)
#define LUA_MASKLINE	(1 shl LUA_HOOKLINE)
#define LUA_MASKCOUNT	(1 shl LUA_HOOKCOUNT)

#define LUA_IDSIZE	60

type lua_Debug 
  event 	as integer
  name		as byte ptr
  namewhat	as byte ptr
  what		as byte ptr
  source	as byte ptr
  currentline	as integer
  nups		as integer
  linedefined	as integer
  short_src as string * LUA_IDSIZE-1
  '' private part
  i_ci		as integer
end type

type lua_Hook as sub cdecl(byval L as lua_State ptr, byval ar as lua_Debug ptr)

declare function lua_getstack LUA_API alias "lua_getstack" (byval L as lua_State ptr, byval level as integer, byval ar as lua_Debug ptr) as integer
declare function lua_getinfo LUA_API alias "lua_getinfo" (byval L as lua_State ptr, byval what as zstring ptr, byval ar as lua_Debug ptr) as integer
declare function lua_getlocal LUA_API alias "lua_getlocal" (byval L as lua_State ptr, byval ar as lua_Debug ptr, byval n as integer) as byte ptr
declare function lua_setlocal LUA_API alias "lua_setlocal" (byval L as lua_State ptr, byval ar as lua_Debug ptr, byval n as integer) as byte ptr
declare function lua_getupvalue LUA_API alias "lua_getupvalue" (byval L as lua_State ptr, byval funcindex as integer, byval n as integer) as byte ptr
declare function lua_setupvalue LUA_API alias "lua_setupvalue" (byval L as lua_State ptr, byval funcindex as integer, byval n as integer) as byte ptr

declare function lua_sethook LUA_API alias "lua_sethook" (byval L as lua_State ptr, byval func as lua_Hook, byval mask as integer, byval count as integer) as integer
declare function lua_gethook LUA_API alias "lua_gethook" (byval L as lua_State ptr) as lua_Hook
declare function lua_gethookmask LUA_API alias "lua_gethookmask" (byval L as lua_State ptr) as integer
declare function lua_gethookcount LUA_API alias "lua_gethookcount" (byval L as lua_State ptr) as integer


'******************************************************************************
' Copyright (C) 1994-2004 Tecgraf, PUC-Rio.  All rights reserved.
'
' Permission is hereby granted, free of charge, to any person obtaining
' a copy of this software and associated documentation files (the
' "Software"), to deal in the Software without restriction, including
' without limitation the rights to use, copy, modify, merge, publish,
' distribute, sublicense, and/or sell copies of the Software, and to
' permit persons to whom the Software is furnished to do so, subject to
' the following conditions:
'
' The above copyright notice and this permission notice shall be
' included in all copies or substantial portions of the Software.
'
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
' EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
' MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
' IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
' CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
' TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
' SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
'******************************************************************************

#endif