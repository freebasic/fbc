''
''
'' cdlua3_private -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cdlua3_private_bi__
#define __cdlua3_private_bi__

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
	lock as integer
	name as zstring ptr
	func as cdCallback
end type

type cdCallbackLUA as _cdCallbackLUA

type _cdContextLUA
	id as integer
	name as zstring ptr
	ctx as function cdecl() as cdContext ptr
	checkdata as sub cdecl(byval as integer)
	cb_list as cdCallbackLUA ptr
	cb_n as integer
end type

type cdContextLUA as _cdContextLUA

declare sub cdlua_addcontext cdecl alias "cdlua_addcontext" (byval luactx as cdContextLUA ptr)
declare sub cdlua_register cdecl alias "cdlua_register" (byval name as zstring ptr, byval func as lua_CFunction)
declare sub cdlua_pushnumber cdecl alias "cdlua_pushnumber" (byval num as double, byval name as zstring ptr)

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
	width as integer
	height as integer
	size as integer
end type

type stipple_t as _stipple_t

type _pattern_t
	color as integer ptr
	width as integer
	height as integer
	size as integer
end type

type pattern_t as _pattern_t

type _palette_t
	color as integer ptr
	size as integer
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
	width as integer
	height as integer
	size as integer
end type

type imagergb_t as _imagergb_t

type _imagergba_t
	red as ubyte ptr
	green as ubyte ptr
	blue as ubyte ptr
	alpha as ubyte ptr
	width as integer
	height as integer
	size as integer
end type

type imagergba_t as _imagergba_t

type _imagemap_t
	index as ubyte ptr
	width as integer
	height as integer
	size as integer
end type

type imagemap_t as _imagemap_t

type _channel_t
	value as ubyte ptr
	size as integer
end type

type channel_t as _channel_t

type _bitmap_t
	image as cdBitmap ptr
end type

type bitmap_t as _bitmap_t

#endif
