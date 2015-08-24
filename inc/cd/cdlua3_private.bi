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

#define __CDLUA3_PRIVATE_H
#define COLOR_TAG "CDLUA_COLOR_TAG"
#define CANVAS_TAG "CDLUA_CANVAS_TAG"
#define STATE_TAG "CDLUA_STATE_TAG"
#define BITMAP_TAG "CDLUA_BITMAP_TAG"
#define IMAGE_TAG "CDLUA_IMAGE_TAG"
#define IMAGERGB_TAG "CDLUA_IMAGERGB_TAG"
#define IMAGERGBA_TAG "CDLUA_IMAGERGBA_TAG"
#define STIPPLE_TAG "CDLUA_STIPPLE_TAG"
#define PATTERN_TAG "CDLUA_PATTERN_TAG"
#define PALETTE_TAG "CDLUA_PALETTE_TAG"
#define IMAGEMAP_TAG "CDLUA_IMAGEMAP_TAG"
#define CHANNEL_TAG "CDLUA_CHANNEL_TAG"

type _cdCallbackLUA
	lock as long
	name as zstring ptr
	func as cdCallback
end type

type cdCallbackLUA as _cdCallbackLUA

type _cdContextLUA
	id as long
	name as zstring ptr
	ctx as function() as cdContext ptr
	checkdata as function(byval param as long) as any ptr
	cb_list as cdCallbackLUA ptr
	cb_n as long
end type

type cdContextLUA as _cdContextLUA
declare sub cdlua_addcontext(byval luactx as cdContextLUA ptr)
declare sub cdlua_register(byval name as zstring ptr, byval func as lua_CFunction)
declare sub cdlua_pushnumber(byval num as double, byval name as zstring ptr)

type _canvas_t
	cd_canvas as cdCanvas ptr
end type

type canvas_t as _canvas_t

type _state_t
	state as cdState ptr
end type

type state_t as _state_t

type _stipple_t
	value as ubyte ptr
	width as long
	height as long
	size as clong
end type

type stipple_t as _stipple_t

type _pattern_t
	color as clong ptr
	width as long
	height as long
	size as clong
end type

type pattern_t as _pattern_t

type _palette_t
	color as clong ptr
	size as clong
end type

type palette_t as _palette_t

type _image_t
	cd_image as any ptr
end type

type image_t as _image_t

type _imagergb_t
	red as ubyte ptr
	green as ubyte ptr
	blue as ubyte ptr
	width as long
	height as long
	size as clong
end type

type imagergb_t as _imagergb_t

type _imagergba_t
	red as ubyte ptr
	green as ubyte ptr
	blue as ubyte ptr
	alpha as ubyte ptr
	width as long
	height as long
	size as clong
end type

type imagergba_t as _imagergba_t

type _imagemap_t
	index as ubyte ptr
	width as long
	height as long
	size as clong
end type

type imagemap_t as _imagemap_t

type _channel_t
	value as ubyte ptr
	size as clong
end type

type channel_t as _channel_t

type _bitmap_t
	image as cdBitmap ptr
end type

type bitmap_t as _bitmap_t

end extern
