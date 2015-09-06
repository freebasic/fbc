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

#include once "crt/stddef.bi"
#include once "crt/stdio.bi"
#include once "lua.bi"

extern "C"

#define lauxlib_h
const LUA_ERRFILE = LUA_ERRERR + 1

type luaL_Reg
	name as const zstring ptr
	func as lua_CFunction
end type

#define LUAL_NUMSIZES ((sizeof(lua_Integer) * 16) + sizeof(lua_Number))
declare sub luaL_checkversion_(byval L as lua_State ptr, byval ver as lua_Number, byval sz as uinteger)
#define luaL_checkversion(L) luaL_checkversion_(L, LUA_VERSION_NUM, LUAL_NUMSIZES)
declare function luaL_getmetafield(byval L as lua_State ptr, byval obj as long, byval e as const zstring ptr) as long
declare function luaL_callmeta(byval L as lua_State ptr, byval obj as long, byval e as const zstring ptr) as long
declare function luaL_tolstring(byval L as lua_State ptr, byval idx as long, byval len as uinteger ptr) as const zstring ptr
declare function luaL_argerror(byval L as lua_State ptr, byval arg as long, byval extramsg as const zstring ptr) as long
declare function luaL_checklstring(byval L as lua_State ptr, byval arg as long, byval l as uinteger ptr) as const zstring ptr
declare function luaL_optlstring(byval L as lua_State ptr, byval arg as long, byval def as const zstring ptr, byval l as uinteger ptr) as const zstring ptr
declare function luaL_checknumber(byval L as lua_State ptr, byval arg as long) as lua_Number
declare function luaL_optnumber(byval L as lua_State ptr, byval arg as long, byval def as lua_Number) as lua_Number
declare function luaL_checkinteger(byval L as lua_State ptr, byval arg as long) as lua_Integer
declare function luaL_optinteger(byval L as lua_State ptr, byval arg as long, byval def as lua_Integer) as lua_Integer
declare sub luaL_checkstack(byval L as lua_State ptr, byval sz as long, byval msg as const zstring ptr)
declare sub luaL_checktype(byval L as lua_State ptr, byval arg as long, byval t as long)
declare sub luaL_checkany(byval L as lua_State ptr, byval arg as long)
declare function luaL_newmetatable(byval L as lua_State ptr, byval tname as const zstring ptr) as long
declare sub luaL_setmetatable(byval L as lua_State ptr, byval tname as const zstring ptr)
declare function luaL_testudata(byval L as lua_State ptr, byval ud as long, byval tname as const zstring ptr) as any ptr
declare function luaL_checkudata(byval L as lua_State ptr, byval ud as long, byval tname as const zstring ptr) as any ptr
declare sub luaL_where(byval L as lua_State ptr, byval lvl as long)
declare function luaL_error(byval L as lua_State ptr, byval fmt as const zstring ptr, ...) as long
declare function luaL_checkoption(byval L as lua_State ptr, byval arg as long, byval def as const zstring ptr, byval lst as const zstring const ptr ptr) as long
declare function luaL_fileresult(byval L as lua_State ptr, byval stat as long, byval fname as const zstring ptr) as long
declare function luaL_execresult(byval L as lua_State ptr, byval stat as long) as long
const LUA_NOREF = -2
const LUA_REFNIL = -1
declare function luaL_ref(byval L as lua_State ptr, byval t as long) as long
declare sub luaL_unref(byval L as lua_State ptr, byval t as long, byval ref as long)
declare function luaL_loadfilex(byval L as lua_State ptr, byval filename as const zstring ptr, byval mode as const zstring ptr) as long
#define luaL_loadfile(L, f) luaL_loadfilex(L, f, NULL)
declare function luaL_loadbufferx(byval L as lua_State ptr, byval buff as const zstring ptr, byval sz as uinteger, byval name as const zstring ptr, byval mode as const zstring ptr) as long
declare function luaL_loadstring(byval L as lua_State ptr, byval s as const zstring ptr) as long
declare function luaL_newstate() as lua_State ptr
declare function luaL_len(byval L as lua_State ptr, byval idx as long) as lua_Integer
declare function luaL_gsub(byval L as lua_State ptr, byval s as const zstring ptr, byval p as const zstring ptr, byval r as const zstring ptr) as const zstring ptr
declare sub luaL_setfuncs(byval L as lua_State ptr, byval l as const luaL_Reg ptr, byval nup as long)
declare function luaL_getsubtable(byval L as lua_State ptr, byval idx as long, byval fname as const zstring ptr) as long
declare sub luaL_traceback(byval L as lua_State ptr, byval L1 as lua_State ptr, byval msg as const zstring ptr, byval level as long)
declare sub luaL_requiref(byval L as lua_State ptr, byval modname as const zstring ptr, byval openf as lua_CFunction, byval glb as long)
#define luaL_newlibtable(L, l_) lua_createtable(L, 0, (ubound(l_) - lbound(l_) + 1) - 1)
#macro luaL_newlib(L, l_)
	scope
		luaL_checkversion(L)
		luaL_newlibtable(L, l_)
		luaL_setfuncs(L, l_, 0)
	end scope
#endmacro
#macro luaL_argcheck(L, cond, arg, extramsg)
	if (cond) = 0 then
		luaL_argerror(L, (arg), (extramsg))
	end if
#endmacro
#define luaL_checkstring(L, n) luaL_checklstring(L, (n), NULL)
#define luaL_optstring(L, n, d) luaL_optlstring(L, (n), (d), NULL)
#define luaL_typename(L, i) lua_typename(L, lua_type(L, (i)))
private function luaL_dofile(byval L as lua_State ptr, byval fn as const zstring ptr) as long
	function = (luaL_loadfile(L, fn) orelse lua_pcall(L, 0, LUA_MULTRET, 0))
end function
private function luaL_dostring(byval L as lua_State ptr, byval s as const zstring ptr) as long
	function = (luaL_loadstring(L, s) orelse lua_pcall(L, 0, LUA_MULTRET, 0))
end function
#define luaL_getmetatable(L, n) lua_getfield(L, LUA_REGISTRYINDEX, (n))
#define luaL_opt(L, f, n, d) iif(lua_isnoneornil(L, (n)), (d), f(L, (n)))
#define luaL_loadbuffer(L, s, sz, n) luaL_loadbufferx(L, s, sz, n, NULL)

type luaL_Buffer
	b as zstring ptr
	size as uinteger
	n as uinteger
	L as lua_State ptr
	initb(0 to LUAL_BUFFERSIZE - 1) as byte
end type

#macro luaL_addchar(B,c)
	if (B)->n >= (B)->size then
		luaL_prepbuffsize((B), 1)
	end if
	(B)->b[(B)->n] = (c)
	(B)->n += 1
#endmacro
#define luaL_addsize(B, s) scope : (B)->n += (s) : end scope
declare sub luaL_buffinit(byval L as lua_State ptr, byval B as luaL_Buffer ptr)
declare function luaL_prepbuffsize(byval B as luaL_Buffer ptr, byval sz as uinteger) as zstring ptr
declare sub luaL_addlstring(byval B as luaL_Buffer ptr, byval s as const zstring ptr, byval l as uinteger)
declare sub luaL_addstring(byval B as luaL_Buffer ptr, byval s as const zstring ptr)
declare sub luaL_addvalue(byval B as luaL_Buffer ptr)
declare sub luaL_pushresult(byval B as luaL_Buffer ptr)
declare sub luaL_pushresultsize(byval B as luaL_Buffer ptr, byval sz as uinteger)
declare function luaL_buffinitsize(byval L as lua_State ptr, byval B as luaL_Buffer ptr, byval sz as uinteger) as zstring ptr
#define luaL_prepbuffer(B) luaL_prepbuffsize(B, LUAL_BUFFERSIZE)
#define LUA_FILEHANDLE "FILE*"

type luaL_Stream
	f as FILE ptr
	closef as lua_CFunction
end type

declare sub luaL_pushmodule(byval L as lua_State ptr, byval modname as const zstring ptr, byval sizehint as long)
declare sub luaL_openlib(byval L as lua_State ptr, byval libname as const zstring ptr, byval l as const luaL_Reg ptr, byval nup as long)
#define luaL_register(L, n, l_) luaL_openlib(L, (n), (l_), 0)
#define lua_writestring(s, l_) fwrite((s), sizeof(byte), (l_), stdout)
#macro lua_writeline()
	scope
		lua_writestring(!"\n", 1)
		fflush(stdout)
	end scope
#endmacro
#macro lua_writestringerror(s, p)
	scope
		fprintf(stderr, (s), (p))
		fflush(stderr)
	end scope
#endmacro

end extern
