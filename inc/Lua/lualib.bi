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
#define LUA_UTF8LIBNAME "utf8"
declare function luaopen_utf8(byval L as lua_State ptr) as long
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
