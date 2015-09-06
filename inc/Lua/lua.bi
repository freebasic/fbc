'' FreeBASIC binding for lua-5.3.1
''
'' based on the C header files:
''   Copyright (C) 1994-2015 Lua.org, PUC-Rio.
''
''   Permission is hereby granted, free of charge, to any person obtaining
''   a copy of this software and associated documentation files (the
''   "Software"), to deal in the Software without restriction, including
''   without limitation the rights to use, copy, modify, merge, publish,
''   distribute, sublicense, and/or sell copies of the Software, and to
''   permit persons to whom the Software is furnished to do so, subject to
''   the following conditions:
''
''   The above copyright notice and this permission notice shall be
''   included in all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
''   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
''   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
''   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
''   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
''   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
''   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "lua"

#if (not defined(LUA_32BITS)) and defined(LUA_C89_NUMBERS)
	#include once "crt/long.bi"
#endif

#include once "crt/stdarg.bi"
#include once "crt/stddef.bi"
#include once "crt/limits.bi"

#if defined(__FB_DOS__) or defined(__FB_UNIX__)
	#include once "crt/stdint.bi"
#endif

'' The following symbols have been renamed:
''     typedef LUA_NUMBER => LUA_NUMBER_
''     typedef LUA_INTEGER => LUA_INTEGER_
''     typedef LUA_UNSIGNED => LUA_UNSIGNED_
''     typedef LUA_KCONTEXT => LUA_KCONTEXT_
''     #define LUA_VERSION => LUA_VERSION_
''     constant LUA_YIELD => LUA_YIELD_

extern "C"

#define lua_h
#define luaconf_h

#ifdef __FB_WIN32__
	#define LUA_USE_WINDOWS
	#define LUA_DL_DLL
	#define LUA_USE_C89
#endif

const LUAI_BITSINT = 32
const LUA_INT_INT = 1
const LUA_INT_LONG = 2
const LUA_INT_LONGLONG = 3
const LUA_FLOAT_FLOAT = 1
const LUA_FLOAT_DOUBLE = 2
const LUA_FLOAT_LONGDOUBLE = 3

#ifdef LUA_32BITS
	const LUA_INT_TYPE = LUA_INT_INT
	const LUA_FLOAT_TYPE = LUA_FLOAT_FLOAT
#elseif (not defined(LUA_32BITS)) and defined(LUA_C89_NUMBERS)
	const LUA_INT_TYPE = LUA_INT_LONG
#else
	const LUA_INT_TYPE = LUA_INT_LONGLONG
#endif

#ifndef LUA_32BITS
	const LUA_FLOAT_TYPE = LUA_FLOAT_DOUBLE
#endif

#define LUA_VDIR LUA_VERSION_MAJOR "." LUA_VERSION_MINOR

#ifdef __FB_WIN32__
	#define LUA_LDIR !"!\\lua\\"
	#define LUA_CDIR !"!\\"
	#define LUA_SHRDIR !"!\\..\\share\\lua\\" LUA_VDIR !"\\"
	#define LUA_PATH_DEFAULT LUA_LDIR "?.lua;" LUA_LDIR !"?\\init.lua;" LUA_CDIR "?.lua;" LUA_CDIR !"?\\init.lua;" LUA_SHRDIR "?.lua;" LUA_SHRDIR !"?\\init.lua;" !".\\?.lua;" !".\\?\\init.lua"
	#define LUA_CPATH_DEFAULT LUA_CDIR "?.dll;" LUA_CDIR !"..\\lib\\lua\\" LUA_VDIR !"\\?.dll;" LUA_CDIR "loadall.dll;" !".\\?.dll"
	#define LUA_DIRSEP !"\\"
#else
	#define LUA_ROOT "/usr/local/"
	#define LUA_LDIR LUA_ROOT "share/lua/" LUA_VDIR "/"
	#define LUA_CDIR LUA_ROOT "lib/lua/" LUA_VDIR "/"
	#define LUA_PATH_DEFAULT LUA_LDIR "?.lua;" LUA_LDIR "?/init.lua;" LUA_CDIR "?.lua;" LUA_CDIR "?/init.lua;" "./?.lua;" "./?/init.lua"
	#define LUA_CPATH_DEFAULT LUA_CDIR "?.so;" LUA_CDIR "loadall.so;" "./?.so"
	#define LUA_DIRSEP "/"
#endif

#ifdef LUA_32BITS
	type LUA_NUMBER_ as single
	#define l_mathlim(n) FLT_##n
#else
	type LUA_NUMBER_ as double
	#define l_mathlim(n) DBL_##n
#endif

type LUAI_UACNUMBER as double
#define LUA_NUMBER_FRMLEN ""

#ifdef LUA_32BITS
	#define LUA_NUMBER_FMT "%.7g"
	#define l_mathop(op) op##f
	#define lua_str2number(s, p) strtof((s), (p))
	#define l_floor(x) floorf(x)
#else
	#define LUA_NUMBER_FMT "%.14g"
	#define l_mathop(op) op
	#define lua_str2number(s, p) strtod((s), (p))
	#define l_floor(x) floor(x)
#endif

#define lua_number2str(s, n) sprintf((s), LUA_NUMBER_FMT, (n))
#define LUA_INTEGER_FMT "%" LUA_INTEGER_FRMLEN "d"
#define lua_integer2str(s, n) sprintf((s), LUA_INTEGER_FMT, (n))
type LUAI_UACINT as LUA_INTEGER_
type LUA_UNSIGNED_ as lua_Unsigned

#ifdef LUA_32BITS
	type LUA_INTEGER_ as long
	#define LUA_INTEGER_FRMLEN ""
	#define LUA_MAXINTEGER INT_MAX
	#define LUA_MININTEGER INT_MIN
#elseif (not defined(LUA_32BITS)) and defined(LUA_C89_NUMBERS)
	type LUA_INTEGER_ as clong
	#define LUA_INTEGER_FRMLEN "l"
	#define LUA_MAXINTEGER LONG_MAX
	#define LUA_MININTEGER LONG_MIN
#else
	type LUA_INTEGER_ as longint
	#define LUA_INTEGER_FRMLEN "ll"
	#define LUA_MAXINTEGER LLONG_MAX
	#define LUA_MININTEGER LLONG_MIN
#endif

private function lua_numbertointeger(byval n as LUA_NUMBER_, byval p as LUA_INTEGER_ ptr) as long
	if (n >= cast(LUA_NUMBER_, LUA_MININTEGER)) andalso (n < (-cast(LUA_NUMBER_, LUA_MININTEGER))) then
		(*p) = cast(LUA_INTEGER_, n)
		return 1
	end if
	return 0
end function

#ifdef __FB_WIN32__
	#undef l_mathop
	#undef lua_str2number
	#define l_mathop(op) cast(lua_Number, op)
	#define lua_str2number(s, p) cast(lua_Number, strtod((s), (p)))
#else
	#define lua_strx2number(s, p) lua_str2number(s, p)
	#define lua_number2strx(L, b, f, n) sprintf(b, f, n)
#endif

type LUA_KCONTEXT_ as integer
#define lua_getlocaledecpoint() localeconv()->decimal_point[0]
const LUAI_MAXSTACK = 1000000
#define LUA_EXTRASPACE sizeof(any ptr)
const LUA_IDSIZE = 60
const LUAL_BUFFERSIZE = 8192
#define LUA_QL(x) "'" x "'"
#define LUA_QS LUA_QL("%s")
#define LUA_VERSION_MAJOR "5"
#define LUA_VERSION_MINOR "3"
const LUA_VERSION_NUM = 503
#define LUA_VERSION_RELEASE "1"
#define LUA_VERSION_ "Lua " LUA_VERSION_MAJOR "." LUA_VERSION_MINOR
#define LUA_RELEASE LUA_VERSION_ "." LUA_VERSION_RELEASE
#define LUA_COPYRIGHT LUA_RELEASE "  Copyright (C) 1994-2015 Lua.org, PUC-Rio"
#define LUA_AUTHORS "R. Ierusalimschy, L. H. de Figueiredo, W. Celes"
#define LUA_SIGNATURE !"\27Lua"
const LUA_MULTRET = -1
const LUA_REGISTRYINDEX = (-LUAI_MAXSTACK) - 1000
#define lua_upvalueindex(i) (LUA_REGISTRYINDEX - (i))
const LUA_OK = 0
const LUA_YIELD_ = 1
const LUA_ERRRUN = 2
const LUA_ERRSYNTAX = 3
const LUA_ERRMEM = 4
const LUA_ERRGCMM = 5
const LUA_ERRERR = 6
const LUA_TNONE = -1
const LUA_TNIL = 0
const LUA_TBOOLEAN = 1
const LUA_TLIGHTUSERDATA = 2
const LUA_TNUMBER = 3
const LUA_TSTRING = 4
const LUA_TTABLE = 5
const LUA_TFUNCTION = 6
const LUA_TUSERDATA = 7
const LUA_TTHREAD = 8
const LUA_NUMTAGS = 9
const LUA_MINSTACK = 20
const LUA_RIDX_MAINTHREAD = 1
const LUA_RIDX_GLOBALS = 2
const LUA_RIDX_LAST = LUA_RIDX_GLOBALS

#ifdef LUA_32BITS
	type lua_Number as single
	type lua_Integer as long
	type lua_Unsigned as ulong
#else
	type lua_Number as double
#endif

#ifndef LUA_32BITS
	#ifdef LUA_C89_NUMBERS
		type lua_Integer as clong
		type lua_Unsigned as culong
	#else
		type lua_Integer as longint
		type lua_Unsigned as ulongint
	#endif
#endif

type lua_KContext as integer
type lua_State as lua_State_
type lua_CFunction as function(byval L as lua_State ptr) as long
type lua_KFunction as function(byval L as lua_State ptr, byval status as long, byval ctx as lua_KContext) as long
type lua_Reader as function(byval L as lua_State ptr, byval ud as any ptr, byval sz as uinteger ptr) as const zstring ptr
type lua_Writer as function(byval L as lua_State ptr, byval p as const any ptr, byval sz as uinteger, byval ud as any ptr) as long
type lua_Alloc as function(byval ud as any ptr, byval ptr as any ptr, byval osize as uinteger, byval nsize as uinteger) as any ptr
extern __lua_ident alias "lua_ident" as const byte
#define lua_ident (*cptr(const zstring ptr, @__lua_ident))

declare function lua_newstate(byval f as lua_Alloc, byval ud as any ptr) as lua_State ptr
declare sub lua_close(byval L as lua_State ptr)
declare function lua_newthread(byval L as lua_State ptr) as lua_State ptr
declare function lua_atpanic(byval L as lua_State ptr, byval panicf as lua_CFunction) as lua_CFunction
declare function lua_version(byval L as lua_State ptr) as const lua_Number ptr
declare function lua_absindex(byval L as lua_State ptr, byval idx as long) as long
declare function lua_gettop(byval L as lua_State ptr) as long
declare sub lua_settop(byval L as lua_State ptr, byval idx as long)
declare sub lua_pushvalue(byval L as lua_State ptr, byval idx as long)
declare sub lua_rotate(byval L as lua_State ptr, byval idx as long, byval n as long)
declare sub lua_copy(byval L as lua_State ptr, byval fromidx as long, byval toidx as long)
declare function lua_checkstack(byval L as lua_State ptr, byval n as long) as long
declare sub lua_xmove(byval from as lua_State ptr, byval to as lua_State ptr, byval n as long)
declare function lua_isnumber(byval L as lua_State ptr, byval idx as long) as long
declare function lua_isstring(byval L as lua_State ptr, byval idx as long) as long
declare function lua_iscfunction(byval L as lua_State ptr, byval idx as long) as long
declare function lua_isinteger(byval L as lua_State ptr, byval idx as long) as long
declare function lua_isuserdata(byval L as lua_State ptr, byval idx as long) as long
declare function lua_type(byval L as lua_State ptr, byval idx as long) as long
declare function lua_typename(byval L as lua_State ptr, byval tp as long) as const zstring ptr
declare function lua_tonumberx(byval L as lua_State ptr, byval idx as long, byval isnum as long ptr) as lua_Number
declare function lua_tointegerx(byval L as lua_State ptr, byval idx as long, byval isnum as long ptr) as lua_Integer
declare function lua_toboolean(byval L as lua_State ptr, byval idx as long) as long
declare function lua_tolstring(byval L as lua_State ptr, byval idx as long, byval len as uinteger ptr) as const zstring ptr
declare function lua_rawlen(byval L as lua_State ptr, byval idx as long) as uinteger
declare function lua_tocfunction(byval L as lua_State ptr, byval idx as long) as lua_CFunction
declare function lua_touserdata(byval L as lua_State ptr, byval idx as long) as any ptr
declare function lua_tothread(byval L as lua_State ptr, byval idx as long) as lua_State ptr
declare function lua_topointer(byval L as lua_State ptr, byval idx as long) as const any ptr

const LUA_OPADD = 0
const LUA_OPSUB = 1
const LUA_OPMUL = 2
const LUA_OPMOD = 3
const LUA_OPPOW = 4
const LUA_OPDIV = 5
const LUA_OPIDIV = 6
const LUA_OPBAND = 7
const LUA_OPBOR = 8
const LUA_OPBXOR = 9
const LUA_OPSHL = 10
const LUA_OPSHR = 11
const LUA_OPUNM = 12
const LUA_OPBNOT = 13
declare sub lua_arith(byval L as lua_State ptr, byval op as long)
const LUA_OPEQ = 0
const LUA_OPLT = 1
const LUA_OPLE = 2

declare function lua_rawequal(byval L as lua_State ptr, byval idx1 as long, byval idx2 as long) as long
declare function lua_compare(byval L as lua_State ptr, byval idx1 as long, byval idx2 as long, byval op as long) as long
declare sub lua_pushnil(byval L as lua_State ptr)
declare sub lua_pushnumber(byval L as lua_State ptr, byval n as lua_Number)
declare sub lua_pushinteger(byval L as lua_State ptr, byval n as lua_Integer)
declare function lua_pushlstring(byval L as lua_State ptr, byval s as const zstring ptr, byval len as uinteger) as const zstring ptr
declare function lua_pushstring(byval L as lua_State ptr, byval s as const zstring ptr) as const zstring ptr
declare function lua_pushvfstring(byval L as lua_State ptr, byval fmt as const zstring ptr, byval argp as va_list) as const zstring ptr
declare function lua_pushfstring(byval L as lua_State ptr, byval fmt as const zstring ptr, ...) as const zstring ptr
declare sub lua_pushcclosure(byval L as lua_State ptr, byval fn as lua_CFunction, byval n as long)
declare sub lua_pushboolean(byval L as lua_State ptr, byval b as long)
declare sub lua_pushlightuserdata(byval L as lua_State ptr, byval p as any ptr)
declare function lua_pushthread(byval L as lua_State ptr) as long
declare function lua_getglobal(byval L as lua_State ptr, byval name as const zstring ptr) as long
declare function lua_gettable(byval L as lua_State ptr, byval idx as long) as long
declare function lua_getfield(byval L as lua_State ptr, byval idx as long, byval k as const zstring ptr) as long
declare function lua_geti(byval L as lua_State ptr, byval idx as long, byval n as lua_Integer) as long
declare function lua_rawget(byval L as lua_State ptr, byval idx as long) as long
declare function lua_rawgeti(byval L as lua_State ptr, byval idx as long, byval n as lua_Integer) as long
declare function lua_rawgetp(byval L as lua_State ptr, byval idx as long, byval p as const any ptr) as long
declare sub lua_createtable(byval L as lua_State ptr, byval narr as long, byval nrec as long)
declare function lua_newuserdata(byval L as lua_State ptr, byval sz as uinteger) as any ptr
declare function lua_getmetatable(byval L as lua_State ptr, byval objindex as long) as long
declare function lua_getuservalue(byval L as lua_State ptr, byval idx as long) as long
declare sub lua_setglobal(byval L as lua_State ptr, byval name as const zstring ptr)
declare sub lua_settable(byval L as lua_State ptr, byval idx as long)
declare sub lua_setfield(byval L as lua_State ptr, byval idx as long, byval k as const zstring ptr)
declare sub lua_seti(byval L as lua_State ptr, byval idx as long, byval n as lua_Integer)
declare sub lua_rawset(byval L as lua_State ptr, byval idx as long)
declare sub lua_rawseti(byval L as lua_State ptr, byval idx as long, byval n as lua_Integer)
declare sub lua_rawsetp(byval L as lua_State ptr, byval idx as long, byval p as const any ptr)
declare function lua_setmetatable(byval L as lua_State ptr, byval objindex as long) as long
declare sub lua_setuservalue(byval L as lua_State ptr, byval idx as long)
declare sub lua_callk(byval L as lua_State ptr, byval nargs as long, byval nresults as long, byval ctx as lua_KContext, byval k as lua_KFunction)
#define lua_call(L, n, r) lua_callk(L, (n), (r), 0, NULL)
declare function lua_pcallk(byval L as lua_State ptr, byval nargs as long, byval nresults as long, byval errfunc as long, byval ctx as lua_KContext, byval k as lua_KFunction) as long
#define lua_pcall(L, n, r, f) lua_pcallk(L, (n), (r), (f), 0, NULL)
declare function lua_load(byval L as lua_State ptr, byval reader as lua_Reader, byval dt as any ptr, byval chunkname as const zstring ptr, byval mode as const zstring ptr) as long
declare function lua_dump(byval L as lua_State ptr, byval writer as lua_Writer, byval data as any ptr, byval strip as long) as long
declare function lua_yieldk(byval L as lua_State ptr, byval nresults as long, byval ctx as lua_KContext, byval k as lua_KFunction) as long
declare function lua_resume(byval L as lua_State ptr, byval from as lua_State ptr, byval narg as long) as long
declare function lua_status(byval L as lua_State ptr) as long
declare function lua_isyieldable(byval L as lua_State ptr) as long

#define lua_yield(L, n) lua_yieldk(L, (n), 0, NULL)
const LUA_GCSTOP = 0
const LUA_GCRESTART = 1
const LUA_GCCOLLECT = 2
const LUA_GCCOUNT = 3
const LUA_GCCOUNTB = 4
const LUA_GCSTEP = 5
const LUA_GCSETPAUSE = 6
const LUA_GCSETSTEPMUL = 7
const LUA_GCISRUNNING = 9

declare function lua_gc(byval L as lua_State ptr, byval what as long, byval data as long) as long
declare function lua_error(byval L as lua_State ptr) as long
declare function lua_next(byval L as lua_State ptr, byval idx as long) as long
declare sub lua_concat(byval L as lua_State ptr, byval n as long)
declare sub lua_len(byval L as lua_State ptr, byval idx as long)
declare function lua_stringtonumber(byval L as lua_State ptr, byval s as const zstring ptr) as uinteger
declare function lua_getallocf(byval L as lua_State ptr, byval ud as any ptr ptr) as lua_Alloc
declare sub lua_setallocf(byval L as lua_State ptr, byval f as lua_Alloc, byval ud as any ptr)

#define lua_getextraspace(L) cptr(any ptr, cptr(zstring ptr, (L)) - LUA_EXTRASPACE)
#define lua_tonumber(L, i) lua_tonumberx(L, (i), NULL)
#define lua_tointeger(L, i) lua_tointegerx(L, (i), NULL)
#define lua_pop(L, n) lua_settop(L, (-(n)) - 1)
#define lua_newtable(L) lua_createtable(L, 0, 0)
#macro lua_register(L, n, f)
	scope
		lua_pushcfunction(L, (f))
		lua_setglobal(L, (n))
	end scope
#endmacro
#define lua_pushcfunction(L, f) lua_pushcclosure(L, (f), 0)
#define lua_isfunction(L, n) (lua_type(L, (n)) = LUA_TFUNCTION)
#define lua_istable(L, n) (lua_type(L, (n)) = LUA_TTABLE)
#define lua_islightuserdata(L, n) (lua_type(L, (n)) = LUA_TLIGHTUSERDATA)
#define lua_isnil(L, n) (lua_type(L, (n)) = LUA_TNIL)
#define lua_isboolean(L, n) (lua_type(L, (n)) = LUA_TBOOLEAN)
#define lua_isthread(L, n) (lua_type(L, (n)) = LUA_TTHREAD)
#define lua_isnone(L, n) (lua_type(L, (n)) = LUA_TNONE)
#define lua_isnoneornil(L, n) (lua_type(L, (n)) <= 0)
#define lua_pushliteral(L, s) lua_pushstring(L, "" s)
#define lua_pushglobaltable(L) lua_rawgeti(L, LUA_REGISTRYINDEX, LUA_RIDX_GLOBALS)
#define lua_tostring(L, i) lua_tolstring(L, (i), NULL)
#define lua_insert(L, idx) lua_rotate(L, (idx), 1)
#macro lua_remove(L, idx)
	scope
		lua_rotate(L, (idx), -1)
		lua_pop(L, 1)
	end scope
#endmacro
#macro lua_replace(L, idx)
	scope
		lua_copy(L, -1, (idx))
		lua_pop(L, 1)
	end scope
#endmacro
const LUA_HOOKCALL = 0
const LUA_HOOKRET = 1
const LUA_HOOKLINE = 2
const LUA_HOOKCOUNT = 3
const LUA_HOOKTAILCALL = 4
const LUA_MASKCALL = 1 shl LUA_HOOKCALL
const LUA_MASKRET = 1 shl LUA_HOOKRET
const LUA_MASKLINE = 1 shl LUA_HOOKLINE
const LUA_MASKCOUNT = 1 shl LUA_HOOKCOUNT
type lua_Debug as lua_Debug_
type lua_Hook as sub(byval L as lua_State ptr, byval ar as lua_Debug ptr)

declare function lua_getstack(byval L as lua_State ptr, byval level as long, byval ar as lua_Debug ptr) as long
declare function lua_getinfo(byval L as lua_State ptr, byval what as const zstring ptr, byval ar as lua_Debug ptr) as long
declare function lua_getlocal(byval L as lua_State ptr, byval ar as const lua_Debug ptr, byval n as long) as const zstring ptr
declare function lua_setlocal(byval L as lua_State ptr, byval ar as const lua_Debug ptr, byval n as long) as const zstring ptr
declare function lua_getupvalue(byval L as lua_State ptr, byval funcindex as long, byval n as long) as const zstring ptr
declare function lua_setupvalue(byval L as lua_State ptr, byval funcindex as long, byval n as long) as const zstring ptr
declare function lua_upvalueid(byval L as lua_State ptr, byval fidx as long, byval n as long) as any ptr
declare sub lua_upvaluejoin(byval L as lua_State ptr, byval fidx1 as long, byval n1 as long, byval fidx2 as long, byval n2 as long)
declare sub lua_sethook(byval L as lua_State ptr, byval func as lua_Hook, byval mask as long, byval count as long)
declare function lua_gethook(byval L as lua_State ptr) as lua_Hook
declare function lua_gethookmask(byval L as lua_State ptr) as long
declare function lua_gethookcount(byval L as lua_State ptr) as long
type CallInfo as CallInfo_

type lua_Debug_
	event as long
	name as const zstring ptr
	namewhat as const zstring ptr
	what as const zstring ptr
	source as const zstring ptr
	currentline as long
	linedefined as long
	lastlinedefined as long
	nups as ubyte
	nparams as ubyte
	isvararg as byte
	istailcall as byte
	short_src as zstring * LUA_IDSIZE
	i_ci as CallInfo ptr
end type

end extern
