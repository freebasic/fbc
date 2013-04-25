''
''
'' lua -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __lua_bi__
#define __lua_bi__

#inclib "lua52"

#define LUA_VERSION_MAJOR "5"
#define LUA_VERSION_MINOR "2"
#define LUA_VERSION_NUM 502
#define LUA_VERSION_RELEASE "1"
#define LUA_VERSION "Lua 5.2"
#define LUA_RELEASE "Lua 5.2.1"
#define LUA_COPYRIGHT "Lua 5.2.1  Copyright (C) 1994-2012 Lua.org, PUC-Rio"
#define LUA_AUTHORS "R. Ierusalimschy, L. H. de Figueiredo, W. Celes"
#define LUA_SIGNATURE "Lua"
#define LUA_MULTRET (-1)
#define LUA_OK 0
#define LUA_YIELD 1
#define LUA_ERRRUN 2
#define LUA_ERRSYNTAX 3
#define LUA_ERRMEM 4
#define LUA_ERRGCMM 5
#define LUA_ERRERR 6

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
#define LUA_NUMTAGS 9
#define LUA_MINSTACK 20
#define LUA_RIDX_MAINTHREAD 1
#define LUA_RIDX_GLOBALS 2
#define LUA_RIDX_LAST LUA_RIDX_GLOBALS

type lua_Number as double
type lua_Integer as integer
type lua_Unsigned as uinteger

extern "C"

declare function lua_newstate ( byval f as lua_Alloc, byval ud as any ptr ) as lua_State ptr
declare sub lua_close (byval L as lua_State ptr)
declare function lua_newthread ( byval l as lua_State ptr ) as lua_State ptr
declare function lua_atpanic (byval as lua_State ptr, byval panicf as lua_CFunction ) as lua_CFunction
declare function lua_version ( byval l as lua_State ptr ) as const lua_Number ptr
declare function lua_absindex (byval L as lua_State ptr, byval idx as integer) as integer
declare function lua_gettop (byval L as lua_State ptr) as integer
declare sub lua_settop (byval L as lua_State ptr, byval idx as integer)
declare sub lua_pushvalue (byval L as lua_State ptr, byval idx as integer)
declare sub lua_remove (byval L as lua_State ptr, byval idx as integer)
declare sub lua_insert (byval L as lua_State ptr, byval idx as integer)
declare sub lua_replace (byval L as lua_State ptr, byval idx as integer)
declare sub lua_copy (byval L as lua_State ptr, byval fromidx as integer, byval toidx as integer)
declare function lua_checkstack (byval L as lua_State ptr, byval sz as integer) as integer
declare sub lua_xmove (byval from as lua_State ptr, byval to as lua_State ptr, byval n as integer)
declare function lua_isnumber (byval L as lua_State ptr, byval idx as integer) as integer
declare function lua_isstring (byval L as lua_State ptr, byval idx as integer) as integer
declare function lua_iscfunction (byval L as lua_State ptr, byval idx as integer) as integer
declare function lua_isuserdata (byval L as lua_State ptr, byval idx as integer) as integer
declare function lua_type (byval L as lua_State ptr, byval idx as integer) as integer
declare function lua_typename (byval L as lua_State ptr, byval tp as integer) as zstring ptr
declare function lua_tonumberx (byval as lua_State ptr, byval as integer, byval as integer ptr) as lua_Number
declare function lua_tointegerx(byval as lua_State ptr, byval as integer, byval as integer ptr) as lua_Integer
declare function lua_tounsignedx(byval as lua_State ptr, byval as integer, byval as integer ptr) as lua_Unsigned
declare function lua_toboolean (byval L as lua_State ptr, byval idx as integer) as integer
declare function lua_tolstring (byval L as lua_State ptr, byval idx as integer, byval len as size_t ptr) as const zstring ptr
declare function lua_rawlen (byval as lua_rawlen) as size_t
declare function lua_tocfunction (byval as lua_State ptr, byval as integer) as lua_CFunction
declare function lua_touserdata (byval L as lua_State ptr, byval idx as integer) as any ptr
declare function lua_tothread ( byval as lua_State ptr, byval as integer ) as lua_State ptr
declare function lua_topointer (byval L as lua_State ptr, byval idx as integer) as any ptr

#define LUA_OPADD 0
#define LUA_OPSUB 1
#define LUA_OPMUL 2
#define LUA_OPDIV 3
#define LUA_OPMOD 4
#define LUA_OPPOW 5
#define LUA_OPUNM 6

declare sub lua_arith (byval L as lua_State ptr, byval op as integer)

#define LUA_OPEQ 0
#define LUA_OPLT 1
#define LUA_OPLE 2

declare function lua_rawequal (byval L as lua_State ptr, byval idx1 as integer, byval idx2 as integer) as integer
declare function lua_compare (byval L as lua_State ptr, byval idx1 as integer, byval idx2 as integer, byval op as integer) as integer

declare sub lua_pushnil (byval L as lua_State ptr)
declare sub lua_pushnumber (byval L as lua_State ptr, byval n as lua_Number)
declare sub lua_pushinteger (byval L as lua_State ptr, byval n as lua_Integer)
declare sub lua_pushunsigned (byval L as lua_State ptr, byval n as lua_Unsigned)
declare function lua_pushlstring (byval L as lua_State ptr, byval s as const zstring ptr, byval l as size_t) as const zstring ptr
declare function lua_pushstring (byval L as lua_State ptr, byval s as const zstring ptr) as const zstring ptr
declare function lua_pushvfstring (byval L as lua_State ptr, byval fmt as const zstring ptr, byval argp as va_list) as const zstring ptr
declare function lua_pushfstring (byval L as lua_State ptr, byval fmt as const zstring ptr, ...) as const zstring ptr
declare sub lua_pushcclosure (byval L as lua_State ptr, byval fn as lua_CFunction, byval n as integer)
declare sub lua_pushboolean (byval L as lua_State ptr, byval b as integer)
declare sub lua_pushlightuserdata (byval L as lua_State ptr, byval p as any ptr)
declare function lua_pushthread (byval L as lua_State ptr) as integer

declare sub lua_getglobal (byval L as lua_State ptr, byval var as const zstring ptr)
declare sub lua_gettable (byval L as lua_State ptr, byval idx as integer)
declare sub lua_getfield (byval L as lua_State ptr, byval idx as integer, byval k as const zstring ptr)
declare sub lua_rawget (byval L as lua_State ptr, byval idx as integer)
declare sub lua_rawgeti (byval L as lua_State ptr, byval idx as integer, byval n as integer)
declare sub lua_rawgetp (byval L as lua_State ptr, byval idx as integer, byval p as const any ptr)
declare sub lua_createtable (byval L as lua_State ptr, byval narr as integer, byval nrec as integer)
declare function lua_newuserdata (byval L as lua_State ptr, byval sz as size_t) as any ptr
declare function lua_getmetatable (byval L as lua_State ptr, byval objindex as integer) as integer
declare sub lua_getuservalue (byval L as lua_State ptr, byval idx as integer)

declare sub lua_setglobal (byval L as lua_State ptr, byval var as zstring ptr)
declare sub lua_settable (byval L as lua_State ptr, byval idx as integer)
declare sub lua_setfield (byval L as lua_State ptr, byval idx as integer, byval k as zstring ptr)
declare sub lua_rawset (byval L as lua_State ptr, byval idx as integer)
declare sub lua_rawseti (byval L as lua_State ptr, byval idx as integer, byval n as integer)
declare sub lua_rawsetp (byval L as lua_State ptr, byval idx as integer, byval p as any ptr)
declare function lua_setmetatable (byval L as lua_State ptr, byval objindex as integer) as integer
declare sub lua_setuservalue (byval L as lua_State ptr, byval idx as integer)

declare sub lua_callk (byval L as lua_State ptr, byval nargs as integer, byval nresults as integer, byval ctx as integer, byval k as lua_CFunction)
#define lua_call(L,n,r)		lua_callk(L, (n), (r), 0, 0)
declare function lua_getctx (byval L as lua_State ptr, byval ctx as integer ptr) as integer
declare function lua_pcallk (byval L as lua_State ptr, byval nargs as integer, byval nresults as integer, byval errfunc as integer, byval ctx as integer, byval k as lua_CFunction) as integer
#define lua_pcall(L,n,r,f)	lua_pcallk(L, (n), (r), (f), 0, 0)

declare function lua_load (byval L as lua_State ptr, byval reader as lua_Reader, byval dt as any ptr, byval chunkname as const zstring ptr, byval mode as const zstring ptr) as integer
declare function lua_dump (byval L as lua_State ptr, byval writer as lua_Writer, byval data_ as any ptr) as integer

declare function lua_yieldk (byval L as lua_State ptr, byval nresults as integer, byval ctx as integer, byval k as lua_CFunction) as integer
#define lua_yield(L,n)		lua_yieldk(L, (n), 0, 0)
declare function lua_resume (byval L as lua_State ptr, byval from as lua_State ptr, byval narg as integer) as integer
declare function lua_status (byval L as lua_State ptr) as integer

#define LUA_GCSTOP 0
#define LUA_GCRESTART 1
#define LUA_GCCOLLECT 2
#define LUA_GCCOUNT 3
#define LUA_GCCOUNTB 4
#define LUA_GCSTEP 5
#define LUA_GCSETPAUSE 6
#define LUA_GCSETSTEPMUL 7
#define LUA_GCSETMAJORINC 8
#define LUA_GCISRUNNING 9
#define LUA_GCGEN 10
#define LUA_GCINC 11

declare function lua_gc (byval L as lua_State ptr, byval what as integer, byval data as integer) as integer

declare function lua_error (byval L as lua_State ptr) as integer
declare function lua_next (byval L as lua_State ptr, byval idx as integer) as integer
declare sub lua_concat (byval L as lua_State ptr, byval n as integer)
declare sub lua_len (byval L as lua_State ptr, byval idx as integer)
declare function lua_getallocf (byval as lua_State ptr, byval as any ptr ptr) as lua_Alloc
declare sub lua_setallocf (byval L as lua_State ptr, byval f as lua_Alloc, byval ud as any ptr)

#define lua_tonumber(L,i)	lua_tonumberx(L,i,0)
#define lua_tointeger(L,i)	lua_tointegerx(L,i,0)
#define lua_tounsigned(L,i)	lua_tounsignedx(L,i,0)

#define lua_pop(L,n)		lua_settop(L, -(n)-1)

#define lua_newtable(L)		lua_createtable(L, 0, 0)

#define lua_register(L,n,f) (lua_pushcfunction(L, (f)), lua_setglobal(L, (n)))

#define lua_pushcfunction(L,f)	lua_pushcclosure(L, (f), 0)

#define lua_isfunction(L,n)	(lua_type(L, (n)) = LUA_TFUNCTION)
#define lua_istable(L,n)	(lua_type(L, (n)) = LUA_TTABLE)
#define lua_islightuserdata(L,n)	(lua_type(L, (n)) = LUA_TLIGHTUSERDATA)
#define lua_isnil(L,n)		(lua_type(L, (n)) = LUA_TNIL)
#define lua_isboolean(L,n)	(lua_type(L, (n)) = LUA_TBOOLEAN)
#define lua_isthread(L,n)	(lua_type(L, (n)) = LUA_TTHREAD)
#define lua_isnone(L,n)		(lua_type(L, (n)) = LUA_TNONE)
#define lua_isnoneornil(L, n)	(lua_type(L, (n)) <= 0)

#define lua_pushliteral(L, s)	lua_pushlstring(L, "" s, (sizeof(s)/sizeof(zstring))-1)

#define lua_pushglobaltable(L)  lua_rawgeti(L, LUA_REGISTRYINDEX, LUA_RIDX_GLOBALS)

#define lua_tostring(L,i)	lua_tolstring(L, (i), 0)

#define LUA_HOOKCALL 0
#define LUA_HOOKRET 1
#define LUA_HOOKLINE 2
#define LUA_HOOKCOUNT 3
#define LUA_HOOKTAILCALL 4
#define LUA_MASKCALL (1 shl 0)
#define LUA_MASKRET (1 shl 1)
#define LUA_MASKLINE (1 shl 2)
#define LUA_MASKCOUNT (1 shl 3)

type lua_Debug as any
type lua_Hook as sub cdecl(byval as lua_State ptr, byval as lua_Debug ptr)

declare function lua_getstack (byval L as lua_State ptr, byval level as integer, byval ar as lua_Debug ptr) as integer
declare function lua_getinfo (byval L as lua_State ptr, byval what as zstring ptr, byval ar as lua_Debug ptr) as integer
declare function lua_getlocal (byval L as lua_State ptr, byval ar as lua_Debug ptr, byval n as integer) as zstring ptr
declare function lua_setlocal (byval L as lua_State ptr, byval ar as lua_Debug ptr, byval n as integer) as zstring ptr
declare function lua_getupvalue (byval L as lua_State ptr, byval funcindex as integer, byval n as integer) as zstring ptr
declare function lua_setupvalue (byval L as lua_State ptr, byval funcindex as integer, byval n as integer) as zstring ptr
declare function lua_upvalueid (byval L as lua_State ptr, byval fidx as integer, byval n as integer) as any ptr
declare sub lua_upvaluejoin (byval L as lua_State ptr, byval fidx1 as integer, byval n1 as integer, byval fidx2 as integer, byval n2 as integer)
declare function lua_sethook (byval L as lua_State ptr, byval func as lua_Hook, byval mask as integer, byval count as integer) as integer
declare function lua_gethook (byval as lua_State ptr) as lua_Hook
declare function lua_gethookmask (byval L as lua_State ptr) as integer
declare function lua_gethookcount (byval L as lua_State ptr) as integer

type lua_Debug
    event as integer
    name as zstring ptr
    namewhat as zstring ptr
    what as zstring ptr
    source as zstring ptr
    currentline as integer
    linedefined as integer
    lastlinedefined as integer
    nups as ubyte
    nparams as ubyte
    isvararg as byte
    istailcall as byte
    short_src as zstring * LUA_IDSIZE
    i_ci as CallInfo ptr
end type

'/******************************************************************************
'* Copyright (C) 1994-2012 Lua.org, PUC-Rio.
'*
'* Permission is hereby granted, free of charge, to any person obtaining
'* a copy of this software and associated documentation files (the
'* "Software"), to deal in the Software without restriction, including
'* without limitation the rights to use, copy, modify, merge, publish,
'* distribute, sublicense, and/or sell copies of the Software, and to
'* permit persons to whom the Software is furnished to do so, subject to
'* the following conditions:
'*
'* The above copyright notice and this permission notice shall be
'* included in all copies or substantial portions of the Software.
'*
'* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
'* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
'* MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
'* IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
'* CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
'* TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
'* SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
'******************************************************************************/

#endif
