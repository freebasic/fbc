'' FreeBASIC binding for cd-5.8.2
''
'' based on the C header files:
''   Copyright (C) 1994-2014 Tecgraf, PUC-Rio.
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

#include once "crt/long.bi"

extern "C"

#define __CDLUA5_PRIVATE_H

type _cdluaCallback
	lock as long
	name as const zstring ptr
	func as cdCallback
end type

type cdluaCallback as _cdluaCallback

type _cdluaContext
	id as long
	name as const zstring ptr
	ctx as function() as cdContext ptr
	checkdata as function(byval L as lua_State ptr, byval param as long) as any ptr
	cb_list as cdluaCallback ptr
	cb_n as long
end type

type cdluaContext as _cdluaContext

type _cdluaLuaState
	void_canvas as cdCanvas ptr
	drivers(0 to 49) as cdluaContext ptr
	numdrivers as long
end type

type cdluaLuaState as _cdluaLuaState

type _cdluaStipple
	stipple as ubyte ptr
	width as long
	height as long
	size as clong
end type

type cdluaStipple as _cdluaStipple

type _cdluaPattern
	pattern as clong ptr
	width as long
	height as long
	size as clong
end type

type cdluaPattern as _cdluaPattern

type _cdluaPalette
	color as clong ptr
	count as long
end type

type cdluaPalette as _cdluaPalette

type _cdluaImageRGB
	red as ubyte ptr
	green as ubyte ptr
	blue as ubyte ptr
	width as long
	height as long
	size as clong
	free as long
end type

type cdluaImageRGB as _cdluaImageRGB

type _cdluaImageRGBA
	red as ubyte ptr
	green as ubyte ptr
	blue as ubyte ptr
	alpha as ubyte ptr
	width as long
	height as long
	size as clong
	free as long
end type

type cdluaImageRGBA as _cdluaImageRGBA

type _cdluaImageMap
	index as ubyte ptr
	width as long
	height as long
	size as clong
end type

type cdluaImageMap as _cdluaImageMap

type _cdluaImageChannel
	channel as ubyte ptr
	size as clong
end type

type cdluaImageChannel as _cdluaImageChannel
declare function cdlua_getstate(byval L as lua_State ptr) as cdluaLuaState ptr
declare function cdlua_getcontext(byval L as lua_State ptr, byval param as long) as cdluaContext ptr
declare function cdlua_getplaystate() as lua_State ptr
declare sub cdlua_setplaystate(byval L as lua_State ptr)
declare sub cdlua_kill_active(byval L as lua_State ptr, byval canvas as cdCanvas ptr)
declare sub cdlua_open_active(byval L as lua_State ptr, byval cdL as cdluaLuaState ptr)
declare sub cdlua_open_canvas(byval L as lua_State ptr)
declare sub cdlua_addcontext(byval L as lua_State ptr, byval cdL as cdluaLuaState ptr, byval luactx as cdluaContext ptr)
declare sub cdlua_initdrivers(byval L as lua_State ptr, byval cdL as cdluaLuaState ptr)
declare function cdlua_checkpalette(byval L as lua_State ptr, byval param as long) as cdluaPalette ptr
declare function cdlua_checkstipple(byval L as lua_State ptr, byval param as long) as cdluaStipple ptr
declare function cdlua_checkpattern(byval L as lua_State ptr, byval param as long) as cdluaPattern ptr
declare function cdlua_checkimagergb(byval L as lua_State ptr, byval param as long) as cdluaImageRGB ptr
declare function cdlua_checkimagergba(byval L as lua_State ptr, byval param as long) as cdluaImageRGBA ptr
declare function cdlua_checkimagemap(byval L as lua_State ptr, byval param as long) as cdluaImageMap ptr
declare function cdlua_checkchannel(byval L as lua_State ptr, byval param as long) as cdluaImageChannel ptr
declare function cdlua_checkcolor(byval L as lua_State ptr, byval param as long) as clong
declare function cdlua_checkimage(byval L as lua_State ptr, byval param as long) as cdImage ptr
declare function cdlua_checkstate(byval L as lua_State ptr, byval param as long) as cdState ptr
declare function cdlua_checkbitmap(byval L as lua_State ptr, byval param as long) as cdBitmap ptr
declare sub cdlua_pushpalette(byval L as lua_State ptr, byval palette as clong ptr, byval size as long)
declare sub cdlua_pushstipple(byval L as lua_State ptr, byval stipple as ubyte ptr, byval width as long, byval height as long)
declare sub cdlua_pushpattern(byval L as lua_State ptr, byval pattern as clong ptr, byval width as long, byval height as long)
declare sub cdlua_pushimagergb(byval L as lua_State ptr, byval red as ubyte ptr, byval green as ubyte ptr, byval blue as ubyte ptr, byval width as long, byval height as long)
declare sub cdlua_pushimagergba(byval L as lua_State ptr, byval red as ubyte ptr, byval green as ubyte ptr, byval blue as ubyte ptr, byval alpha as ubyte ptr, byval width as long, byval height as long)
declare sub cdlua_pushimagemap(byval L as lua_State ptr, byval index as ubyte ptr, byval width as long, byval height as long)
declare sub cdlua_pushchannel(byval L as lua_State ptr, byval channel as ubyte ptr, byval size as long)
declare sub cdlua_pushimage(byval L as lua_State ptr, byval image as cdImage ptr)
declare sub cdlua_pushstate(byval L as lua_State ptr, byval state as cdState ptr)
declare sub cdlua_pushbitmap(byval L as lua_State ptr, byval bitmap as cdBitmap ptr)
declare sub cdlua_pushimagergb_ex(byval L as lua_State ptr, byval red as ubyte ptr, byval green as ubyte ptr, byval blue as ubyte ptr, byval width as long, byval height as long)
declare sub cdlua_pushimagergba_ex(byval L as lua_State ptr, byval red as ubyte ptr, byval green as ubyte ptr, byval blue as ubyte ptr, byval alpha as ubyte ptr, byval width as long, byval height as long)

end extern
