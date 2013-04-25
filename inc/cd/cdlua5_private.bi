''
''
'' cdlua5_private -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cdlua5_private_bi__
#define __cdlua5_private_bi__

type _cdluaCallback
	lock as integer
	name as zstring ptr
	func as cdCallback
end type

type cdluaCallback as _cdluaCallback

type _cdluaContext
	id as integer
	name as zstring ptr
	ctx as function cdecl() as cdContext ptr
	checkdata as sub cdecl(byval as lua_State ptr, byval as integer)
	cb_list as cdluaCallback ptr
	cb_n as integer
end type

type cdluaContext as _cdluaContext

type _cdluaLuaState
	void_canvas as cdCanvas ptr
	drivers(0 to 50-1) as cdluaContext ptr
	numdrivers as integer
end type

type cdluaLuaState as _cdluaLuaState

type _cdluaStipple
	stipple as ubyte ptr
	width as integer
	height as integer
	size as integer
end type

type cdluaStipple as _cdluaStipple

type _cdluaPattern
	pattern as integer ptr
	width as integer
	height as integer
	size as integer
end type

type cdluaPattern as _cdluaPattern

type _cdluaPalette
	color as integer ptr
	count as integer
end type

type cdluaPalette as _cdluaPalette

type _cdluaImageRGB
	red as ubyte ptr
	green as ubyte ptr
	blue as ubyte ptr
	width as integer
	height as integer
	size as integer
	free as integer
end type

type cdluaImageRGB as _cdluaImageRGB

type _cdluaImageRGBA
	red as ubyte ptr
	green as ubyte ptr
	blue as ubyte ptr
	alpha as ubyte ptr
	width as integer
	height as integer
	size as integer
	free as integer
end type

type cdluaImageRGBA as _cdluaImageRGBA

type _cdluaImageMap
	index as ubyte ptr
	width as integer
	height as integer
	size as integer
end type

type cdluaImageMap as _cdluaImageMap

type _cdluaImageChannel
	channel as ubyte ptr
	size as integer
end type

type cdluaImageChannel as _cdluaImageChannel

declare function cdlua_getstate cdecl alias "cdlua_getstate" (byval L as lua_State ptr) as cdluaLuaState ptr
declare function cdlua_getcontext cdecl alias "cdlua_getcontext" (byval L as lua_State ptr, byval param as integer) as cdluaContext ptr
declare function cdlua_getplaystate cdecl alias "cdlua_getplaystate" () as lua_State ptr
declare sub cdlua_setplaystate cdecl alias "cdlua_setplaystate" (byval L as lua_State ptr)
declare sub cdlua_kill_active cdecl alias "cdlua_kill_active" (byval L as lua_State ptr, byval canvas as cdCanvas ptr)
declare sub cdlua_open_active cdecl alias "cdlua_open_active" (byval L as lua_State ptr, byval cdL as cdluaLuaState ptr)
declare sub cdlua_open_canvas cdecl alias "cdlua_open_canvas" (byval L as lua_State ptr)
declare sub cdlua_addcontext cdecl alias "cdlua_addcontext" (byval L as lua_State ptr, byval cdL as cdluaLuaState ptr, byval luactx as cdluaContext ptr)
declare sub cdlua_initdrivers cdecl alias "cdlua_initdrivers" (byval L as lua_State ptr, byval cdL as cdluaLuaState ptr)
declare function cdlua_checkpalette cdecl alias "cdlua_checkpalette" (byval L as lua_State ptr, byval param as integer) as cdluaPalette ptr
declare function cdlua_checkstipple cdecl alias "cdlua_checkstipple" (byval L as lua_State ptr, byval param as integer) as cdluaStipple ptr
declare function cdlua_checkpattern cdecl alias "cdlua_checkpattern" (byval L as lua_State ptr, byval param as integer) as cdluaPattern ptr
declare function cdlua_checkimagergb cdecl alias "cdlua_checkimagergb" (byval L as lua_State ptr, byval param as integer) as cdluaImageRGB ptr
declare function cdlua_checkimagergba cdecl alias "cdlua_checkimagergba" (byval L as lua_State ptr, byval param as integer) as cdluaImageRGBA ptr
declare function cdlua_checkimagemap cdecl alias "cdlua_checkimagemap" (byval L as lua_State ptr, byval param as integer) as cdluaImageMap ptr
declare function cdlua_checkchannel cdecl alias "cdlua_checkchannel" (byval L as lua_State ptr, byval param as integer) as cdluaImageChannel ptr
declare function cdlua_checkcolor cdecl alias "cdlua_checkcolor" (byval L as lua_State ptr, byval param as integer) as integer
declare function cdlua_checkimage cdecl alias "cdlua_checkimage" (byval L as lua_State ptr, byval param as integer) as cdImage ptr
declare function cdlua_checkstate cdecl alias "cdlua_checkstate" (byval L as lua_State ptr, byval param as integer) as cdState ptr
declare function cdlua_checkbitmap cdecl alias "cdlua_checkbitmap" (byval L as lua_State ptr, byval param as integer) as cdBitmap ptr
declare sub cdlua_pushpalette cdecl alias "cdlua_pushpalette" (byval L as lua_State ptr, byval palette as integer ptr, byval size as integer)
declare sub cdlua_pushstipple cdecl alias "cdlua_pushstipple" (byval L as lua_State ptr, byval stipple as ubyte ptr, byval width as integer, byval height as integer)
declare sub cdlua_pushpattern cdecl alias "cdlua_pushpattern" (byval L as lua_State ptr, byval pattern as integer ptr, byval width as integer, byval height as integer)
declare sub cdlua_pushimagergb cdecl alias "cdlua_pushimagergb" (byval L as lua_State ptr, byval red as ubyte ptr, byval green as ubyte ptr, byval blue as ubyte ptr, byval width as integer, byval height as integer)
declare sub cdlua_pushimagergba cdecl alias "cdlua_pushimagergba" (byval L as lua_State ptr, byval red as ubyte ptr, byval green as ubyte ptr, byval blue as ubyte ptr, byval alpha as ubyte ptr, byval width as integer, byval height as integer)
declare sub cdlua_pushimagemap cdecl alias "cdlua_pushimagemap" (byval L as lua_State ptr, byval index as ubyte ptr, byval width as integer, byval height as integer)
declare sub cdlua_pushchannel cdecl alias "cdlua_pushchannel" (byval L as lua_State ptr, byval channel as ubyte ptr, byval size as integer)
declare sub cdlua_pushimage cdecl alias "cdlua_pushimage" (byval L as lua_State ptr, byval image as cdImage ptr)
declare sub cdlua_pushstate cdecl alias "cdlua_pushstate" (byval L as lua_State ptr, byval state as cdState ptr)
declare sub cdlua_pushbitmap cdecl alias "cdlua_pushbitmap" (byval L as lua_State ptr, byval bitmap as cdBitmap ptr)
declare sub cdlua_pushimagergb_ex cdecl alias "cdlua_pushimagergb_ex" (byval L as lua_State ptr, byval red as ubyte ptr, byval green as ubyte ptr, byval blue as ubyte ptr, byval width as integer, byval height as integer)
declare sub cdlua_pushimagergba_ex cdecl alias "cdlua_pushimagergba_ex" (byval L as lua_State ptr, byval red as ubyte ptr, byval green as ubyte ptr, byval blue as ubyte ptr, byval alpha as ubyte ptr, byval width as integer, byval height as integer)

#endif
