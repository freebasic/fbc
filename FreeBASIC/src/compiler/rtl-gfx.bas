''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
''
''	This program is free software; you can redistribute it and/or modify
''	it under the terms of the GNU General Public License as published by
''	the Free Software Foundation; either version 2 of the License, or
''	(at your option) any later version.
''
''	This program is distributed in the hope that it will be useful,
''	but WITHOUT ANY WARRANTY; without even the implied warranty of
''	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''	GNU General Public License for more details.
''
''	You should have received a copy of the GNU General Public License
''	along with this program; if not, write to the Free Software
''	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.


'' intrinsic runtime lib gfx functions (SCREEN, PSET, LINE, ...)
''
'' chng: oct/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ast.bi"
#include once "inc\lex.bi"
#include once "inc\rtl.bi"

declare function    hGfxlib_cb          ( byval sym as FBSYMBOL ptr ) as integer
declare function 	hPorts_cb			( byval sym as FBSYMBOL ptr ) as integer


'' name, alias, _
'' type, mode, _
'' callback, checkerror, overloaded, _
'' args, _
'' [arg typ,mode,optional[,value]]*args
funcdata:

''
'' fb_GfxPset ( byref target as any, byval x as single, byval y as single, byval color as uinteger, _
''				byval coordType as integer, byval ispreset as integer ) as void
data @FB_RTL_GFXPSET, "", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 6, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_UINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_GfxPoint ( byref target as any, byval x as single, byval y as single ) as integer
data @FB_RTL_GFXPOINT, "", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE

'' fb_GfxLine ( byref target as any, byval x1 as single = 0, byval y1 as single = 0, byval x2 as single = 0, byval y2 as single = 0, _
''              byval color as uinteger = DEFAULT_COLOR, byval line_type as integer = LINE_TYPE_LINE, _
''              byval style as uinteger = &hFFFF, byval coordType as integer = COORD_TYPE_AA ) as integer
data @FB_RTL_GFXLINE, "", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 9, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_UINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_UINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_GfxEllipse ( byref target as any, byval x as single, byval y as single, byval radius as single, _
''				   byval color as uinteger = DEFAULT_COLOR, byval aspect as single = 0.0, _
''				   byval iniarc as single = 0.0, byval endarc as single = 6.283185, _
''				   byval FillFlag as integer = 0, byval CoordType as integer = COORD_TYPE_A ) as integer
data @FB_RTL_GFXCIRCLE, "", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 10, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_UINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_GfxPaint ( byref target as any, byval x as single, byval y as single, byval color as uinteger = DEFAULT_COLOR, _
''				 byval border_color as uinteger = DEFAULT_COLOR, pattern as string, _
''				 byval mode as integer = PAINT_TYPE_FILL, byval coord_type as integer = COORD_TYPE_A ) as integer
data @FB_RTL_GFXPAINT, "", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 8, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_UINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_UINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_GfxDraw ( byval target as any, cmd as string )
data @FB_RTL_GFXDRAW, "", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_GfxView ( byval x1 as integer = -32768, byval y1 as integer = -32768, _
''              byval x1 as integer = -32768, byval y1 as integer = -32768, _
''				byval fillcol as uinteger = DEFAULT_COLOR, byval bordercol as uinteger = DEFAULT_COLOR, _
''              byval screenFlag as integer = 0) as integer
data @FB_RTL_GFXVIEW, "", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 7, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_UINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_UINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_GfxWindow (byval x1 as single = 0, byval y1 as single = 0, byval x2 as single = 0, _
'' 				 byval y2 as single = 0, byval screenflag as integer = 0 ) as integer
data @FB_RTL_GFXWINDOW, "", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 5, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0

'' fb_GfxPalette( byval attribute as integer = -1, byval r as integer = -1, _
''				  byval g as integer = -1, byval b as integer = -1 ) as void
data @FB_RTL_GFXPALETTE, "", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 4, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1

'' fb_GfxPaletteUsing ( array as integer ) as void
data @FB_RTL_GFXPALETTEUSING, "", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, FALSE

'' fb_GfxPaletteGet( byval attribute as integer, byref r as integer, _
''					 byref g as integer, byref b as integer ) as void
data @FB_RTL_GFXPALETTEGET, "", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 4, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, FALSE

'' fb_GfxPaletteGetUsing ( array as integer ) as void
data @FB_RTL_GFXPALETTEGETUSING, "", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, FALSE

'' fb_GfxPut ( byref target as any, byval x as single, byval y as single, byref array as any, _
''			   byval x1 as integer = &hFFFF0000, byval y1 as integer = &hFFFF0000, _
''			   byval x2 as integer = &hFFFF0000, byval y2 as integer = &hFFFF0000, _
''			   byval coordType as integer, byval mode as integer, byval alpha as integer = -1, _
''			   byval func as function( src as uinteger, dest as uinteger ) as uinteger = 0 ) as integer
data @FB_RTL_GFXPUT, "", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 12, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_ARGMODE_BYVAL, FALSE

'' fb_GfxGet ( byref target as any, byval x1 as single, byval y1 as single, byval x2 as single, byval y2 as single, _
''			   byref array as any, byval coordType as integer, array() as any ) as integer
data @FB_RTL_GFXGET, "", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 8, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYDESC, FALSE

'' fb_GfxScreen ( byval w as integer, byval h as integer = 0, byval depth as integer = 0, _
''                byval fullscreenFlag as integer = 0 ) as integer
data @FB_RTL_GFXSCREENSET, "", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 5, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0

'' fb_GfxScreenRes ( byval w as integer, byval h as integer, byval depth as integer = 8, _
''					 byval num_pages as integer = 1, byval flags as integer = 0, byval refresh_rate as integer = 0 )
data @FB_RTL_GFXSCREENRES, "", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 6, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,8, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0

'' fb_ProfileBeginCall ( procname as string ) as any ptr
data @FB_RTL_PROFILEBEGINCALL, "", _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYVAL, FALSE

'' fb_ProfileEndCall ( call as any ptr ) as void
data @FB_RTL_PROFILEENDCALL, "", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_ARGMODE_BYVAL, FALSE

'' fb_EndProfile ( byval errlevel as integer ) as integer
data @FB_RTL_PROFILEEND, "", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'':::::::::::::::::::::::::::::::::::::::::::::::::::

'' fb_GfxBload ( filename as string, byval dest as any ptr = NULL ) as integer
data @"bload", "fb_GfxBload", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, TRUE, FALSE, _
	 2, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_ARGMODE_BYVAL, TRUE,NULL

'' fb_GfxBsave ( filename as string, byval src as any ptr, byval length as integer ) as integer
data @"bsave", "fb_GfxBsave", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, TRUE, FALSE, _
	 3, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE, 0


'' fb_GfxFlip ( byval frompage as integer = -1, byval topage as integer = -1 ) as void
data @"flip", "fb_GfxFlip", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1

'' pcopy ( byval frompage as integer, byval topage as integer ) as void
data @"pcopy", "fb_GfxFlip", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

data @"screencopy", "fb_GfxFlip", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1

'' fb_GfxCursor ( number as integer) as single
data @"pointcoord", "fb_GfxCursor", _
	 FB_SYMBTYPE_SINGLE,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_GfxPMap ( byval Coord as single, byval num as integer ) as single
data @"pmap", "fb_GfxPMap", _
	 FB_SYMBTYPE_SINGLE,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_Out( byval port as ushort, byval data as ubyte ) as void
data @"out", "fb_Out", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hPorts_cb, TRUE, FALSE, _
	 2, _
	 FB_SYMBTYPE_USHORT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_UBYTE,FB_ARGMODE_BYVAL, FALSE

'' fb_In( byval port as ushort ) as integer
data @"inp", "fb_In", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hPorts_cb, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_USHORT,FB_ARGMODE_BYVAL, FALSE

'' fb_Wait ( byval port as ushort, byval and_mask as integer, byval xor_mask as integer = 0 )
data @"wait", "fb_Wait", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hPorts_cb, TRUE, FALSE, _
	 3, _
	 FB_SYMBTYPE_USHORT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0

'' fb_GfxWaitVSync ( void ) as integer
data @"screensync", "fb_GfxWaitVSync", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, TRUE, FALSE, _
	 0

'' fb_GfxSetPage ( byval work_page as integer = -1, byval visible_page as integer = -1 ) as void
data @"screenset", "fb_GfxSetPage", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1

'' fb_GfxLock ( ) as void
data @"screenlock", "fb_GfxLock", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 0

'' fb_GfxUnlock ( ) as void
data @"screenunlock", "fb_GfxUnlock", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1

'' fb_GfxScreenPtr ( ) as any ptr
data @"screenptr", "fb_GfxScreenPtr", _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 0

'' fb_GfxSetWindowTitle ( title as string ) as void
data @"windowtitle", "fb_GfxSetWindowTitle", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_Multikey ( byval scancode as integer ) as integer
data @"multikey", "fb_Multikey", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @rtlMultinput_cb, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_GfxGetMouse ( byref x as integer, byref y as integer, byref z as integer, byref buttons as integer ) as integer
data @"getmouse", "fb_GetMouse", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @rtlMultinput_cb, TRUE, FALSE, _
	 4, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, TRUE,0

'' fb_GfxSetMouse ( byval x as integer = -1, byval y as integer = -1, byval cursor as integer = -1 ) as integer
data @"setmouse", "fb_SetMouse", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @rtlMultinput_cb, TRUE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1

'' fb_GfxGetJoystick ( byval id as integer, byref buttons as integer = 0, _
''					   byref a1 as single = 0, byref a2 as single = 0, byref a3 as single = 0, _
''					   byref a4 as single = 0, byref a5 as single = 0, byref a6 as single = 0 ) as integer
data @"getjoystick", "fb_GfxGetJoystick", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, TRUE, FALSE, _
	 8, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, TRUE,0, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYREF, TRUE,0, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYREF, TRUE,0, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYREF, TRUE,0, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYREF, TRUE,0, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYREF, TRUE,0, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYREF, TRUE,0

'' fb_GfxScreenInfo ( byref w as integer, byref h as integer, byref depth as integer, _
''					  byref bpp as integer, byref pitch as integer, byref driver_name as string ) as void
data @"screeninfo", "fb_GfxScreenInfo", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 7, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, TRUE,0, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, TRUE,""

'' fb_GfxScreenList ( byval depth as integer ) as integer
data @"screenlist", "fb_GfxScreenList", _
FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, TRUE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0

'' fb_GfxImageCreate ( byval width as integer, byval height as integer ) as any ptr
data @"imagecreate", "fb_GfxImageCreate", _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,&hFEFF00FF

'' fb_GfxImageDestroy ( byval image as any ptr ) as void
data @"imagedestroy", "fb_GfxImageDestroy", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hGfxlib_cb, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_ARGMODE_BYVAL, FALSE

'' EOL
data NULL


'':::::
sub rtlGfxModInit( )

	restore funcdata
	rtlAddIntrinsicProcs( )

end sub

'':::::
sub rtlGfxModEnd( )

	'' procs will be deleted when symbEnd is called

end sub

'':::::
private function hPorts_cb( byval sym as FBSYMBOL ptr ) as integer
    static as integer libsAdded = FALSE

	if( not libsadded ) then
		libsAdded = TRUE

		select case env.clopt.target
		case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
			symbAddLib( "advapi32" )
		end select
	end if

	function = TRUE

end function

'':::::
function rtlMultinput_cb( byval sym as FBSYMBOL ptr ) as integer static
    static as integer libsAdded = FALSE

	if( not libsadded ) then
		libsAdded = TRUE

		select case env.clopt.target
		case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
			symbAddLib( "user32" )
		end select
	end if

	function = TRUE

end function

'':::::
private function hGfxlib_cb( byval sym as FBSYMBOL ptr ) as integer static
    static as integer libsAdded = FALSE

	if( not libsadded ) then
		libsAdded = TRUE

		symbAddLib( "fbgfx" )

		select case as const env.clopt.target
		case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
			symbAddLib( "user32" )
			symbAddLib( "gdi32" )
			symbAddLib( "winmm" )

		case FB_COMPTARGET_LINUX
#ifdef TARGET_LINUX
			fbAddLibPath( "/usr/X11R6/lib" )
#endif

			symbAddLib( "X11" )
			symbAddLib( "Xext" )
			symbAddLib( "Xpm" )
			symbAddLib( "Xrandr" )
			symbAddLib( "Xrender" )

		end select
	end if

	return TRUE
end function

'':::::
function rtlGfxPset( byval target as ASTNODE ptr, _
					 byval targetisptr as integer, _
					 byval xexpr as ASTNODE ptr, _
					 byval yexpr as ASTNODE ptr, _
					 byval cexpr as ASTNODE ptr, _
					 byval coordtype as integer, _
					 byval ispreset as integer ) as integer

    dim as ASTNODE ptr proc
    dim as integer targetmode

	function = FALSE

    proc = astNewFUNCT( PROCLOOKUP( GFXPSET ) )

 	'' byref target as any
 	if( target = NULL ) then
 		target = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
 		targetmode = FB_ARGMODE_BYVAL
 	else
		if( targetisptr ) then
			targetmode = FB_ARGMODE_BYVAL
		else
			targetmode = INVALID
		end if
	end if
	if( astNewPARAM( proc, target, INVALID, targetmode ) = NULL ) then
 		exit function
 	end if

 	'' byval x as single
 	if( astNewPARAM( proc, xexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval y as single
 	if( astNewPARAM( proc, yexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval color as uinteger
 	if( astNewPARAM( proc, cexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval coordtype as integer
 	if( astNewPARAM( proc, astNewCONSTi( coordtype, IR_DATATYPE_INTEGER ) ) = NULL ) then
 		exit function
 	end if

 	'' byval ispreset as integer
 	if( astNewPARAM( proc, astNewCONSTi( ispreset, IR_DATATYPE_INTEGER ) ) = NULL ) then
 		exit function
 	end if

 	''
 	astAdd( proc )

	function = TRUE

end function

'':::::
function rtlGfxPoint( byval target as ASTNODE ptr, _
					  byval targetisptr as integer, _
					  byval xexpr as ASTNODE ptr, _
					  byval yexpr as ASTNODE ptr ) as ASTNODE ptr

	dim as ASTNODE ptr proc
	dim as integer targetmode

	function = NULL

	proc = astNewFUNCT( PROCLOOKUP( GFXPOINT ) )

	'' byref target as any
	if( target = NULL ) then
 		target = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
 		targetmode = FB_ARGMODE_BYVAL
 	else
		if( targetisptr ) then
			targetmode = FB_ARGMODE_BYVAL
		else
			targetmode = INVALID
		end if
	end if
	if( astNewPARAM( proc, target, INVALID, targetmode ) = NULL ) then
 		exit function
 	end if

 	'' byval x as single
 	if( astNewPARAM( proc, xexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval y as single
 	if( yexpr = NULL ) then
 		yexpr = astNewCONSTf( -1, IR_DATATYPE_SINGLE )
 	end if
 	if( astNewPARAM( proc, yexpr ) = NULL ) then
 		exit function
 	end if

	function = proc

end function

'':::::
function rtlGfxLine( byval target as ASTNODE ptr, _
					 byval targetisptr as integer, _
					 byval x1expr as ASTNODE ptr, _
					 byval y1expr as ASTNODE ptr, _
					 byval x2expr as ASTNODE ptr, _
					 byval y2expr as ASTNODE ptr, _
					 byval cexpr as ASTNODE ptr, _
					 byval linetype as integer, _
					 byval styleexpr as ASTNODE ptr, _
					 byval coordtype as integer ) as integer

    dim as ASTNODE ptr proc
    dim as integer targetmode

	function = FALSE

    proc = astNewFUNCT( PROCLOOKUP( GFXLINE ) )

 	'' byref target as any
 	if( target = NULL ) then
 		target = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
 		targetmode = FB_ARGMODE_BYVAL
 	else
		if( targetisptr ) then
			targetmode = FB_ARGMODE_BYVAL
		else
			targetmode = INVALID
		end if
	end if
	if( astNewPARAM( proc, target, INVALID, targetmode ) = NULL ) then
 		exit function
 	end if

 	'' byval x1 as single
 	if( astNewPARAM( proc, x1expr ) = NULL ) then
 		exit function
 	end if

 	'' byval y1 as single
 	if( astNewPARAM( proc, y1expr ) = NULL ) then
 		exit function
 	end if

 	'' byval x2 as single
 	if( astNewPARAM( proc, x2expr ) = NULL ) then
 		exit function
 	end if

 	'' byval y2 as single
 	if( astNewPARAM( proc, y2expr ) = NULL ) then
 		exit function
 	end if

 	'' byval color as uinteger
 	if( astNewPARAM( proc, cexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval linetype as integer
 	if( astNewPARAM( proc, astNewCONSTi( linetype, IR_DATATYPE_INTEGER ) ) = NULL ) then
 		exit function
 	end if

 	'' byval style as uinteger
 	if( styleexpr = NULL ) then
 		styleexpr = astNewCONSTi( &h0000FFFF, IR_DATATYPE_UINT )
 	end if
 	if( astNewPARAM( proc, styleexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval coordtype as integer
 	if( astNewPARAM( proc, astNewCONSTi( coordtype, IR_DATATYPE_INTEGER ) ) = NULL ) then
 		exit function
 	end if

 	''
 	astAdd( proc )

	function = TRUE

end function

'':::::
function rtlGfxCircle( byval target as ASTNODE ptr, _
					   byval targetisptr as integer, _
					   byval xexpr as ASTNODE ptr, _
					   byval yexpr as ASTNODE ptr, _
					   byval radexpr as ASTNODE ptr, _
					   byval cexpr as ASTNODE ptr, _
					   byval aspexpr as ASTNODE ptr, _
					   byval iniexpr as ASTNODE ptr, _
					   byval endexpr as ASTNODE ptr, _
					   byval fillflag as integer, _
					   byval coordtype as integer ) as integer

    dim as ASTNODE ptr proc
    dim as integer targetmode

	function = FALSE

    proc = astNewFUNCT( PROCLOOKUP( GFXCIRCLE ) )

 	'' byref target as any
 	if( target = NULL ) then
 		target = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
 		targetmode = FB_ARGMODE_BYVAL
 	else
		if( targetisptr ) then
			targetmode = FB_ARGMODE_BYVAL
		else
			targetmode = INVALID
		end if
	end if
	if( astNewPARAM( proc, target, INVALID, targetmode ) = NULL ) then
 		exit function
 	end if

 	'' byval x as single
 	if( astNewPARAM( proc, xexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval y as single
 	if( astNewPARAM( proc, yexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval radians as single
 	if( astNewPARAM( proc, radexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval color as uinteger
 	if( astNewPARAM( proc, cexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval aspect as single
 	if( aspexpr = NULL ) then
 		aspexpr = astNewCONSTf( 0.0, IR_DATATYPE_SINGLE )
 	end if
 	if( astNewPARAM( proc, aspexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval arcini as single
 	if( iniexpr = NULL ) then
 		iniexpr = astNewCONSTf( 0.0, IR_DATATYPE_SINGLE )
 	end if
 	if( astNewPARAM( proc, iniexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval arcend as single
 	if( endexpr = NULL ) then
 		endexpr = astNewCONSTf( 3.141593*2, IR_DATATYPE_SINGLE )
 	end if
 	if( astNewPARAM( proc, endexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval fillflag as integer
 	if( astNewPARAM( proc, astNewCONSTi( fillflag, IR_DATATYPE_INTEGER ) ) = NULL ) then
 		exit function
 	end if

 	'' byval coordtype as integer
 	if( astNewPARAM( proc, astNewCONSTi( coordtype, IR_DATATYPE_INTEGER ) ) = NULL ) then
 		exit function
 	end if

 	''
 	astAdd( proc )

	function = TRUE

end function

'':::::
function rtlGfxPaint( byval target as ASTNODE ptr, _
					  byval targetisptr as integer, _
					  byval xexpr as ASTNODE ptr, _
					  byval yexpr as ASTNODE ptr, _
					  byval pexpr as ASTNODE ptr, _
					  byval bexpr as ASTNODE ptr, _
					  byval coord_type as integer ) as integer

    dim as ASTNODE ptr proc
    dim as integer targetmode, pattern

    function = FALSE

	proc = astNewFUNCT( PROCLOOKUP( GFXPAINT ) )

 	'' byref target as any
 	if( target = NULL ) then
 		target = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
 		targetmode = FB_ARGMODE_BYVAL
 	else
		if( targetisptr ) then
			targetmode = FB_ARGMODE_BYVAL
		else
			targetmode = INVALID
		end if
	end if
	if( astNewPARAM( proc, target, INVALID, targetmode ) = NULL ) then
 		exit function
 	end if

 	'' byval x as single
 	if( astNewPARAM( proc, xexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval y as single
 	if( astNewPARAM( proc, yexpr ) = NULL ) then
 		exit function
 	end if

	'' byval color as uinteger
	pattern = astGetDataType( pexpr )
	if( ( pattern = IR_DATATYPE_FIXSTR ) or ( pattern = IR_DATATYPE_STRING ) ) then
		pattern = TRUE
		if( astNewPARAM( proc, astNewCONSTi( &hFFFF0000, IR_DATATYPE_INTEGER ) ) = NULL ) then
 			exit function
 		end if
	else
		pattern = FALSE
		if( astNewPARAM( proc, pexpr ) = NULL ) then
 			exit function
 		end if
	end if

	'' byval border_color as uinteger
	if( astNewPARAM( proc, bexpr ) = NULL ) then
 		exit function
 	end if

	'' pattern as string, byval mode as integer
	if( pattern = TRUE ) then
		if( astNewPARAM( proc, pexpr ) = NULL ) then
 			exit function
 		end if
		if( astNewPARAM( proc, astNewCONSTi( 1, IR_DATATYPE_INTEGER ) ) = NULL ) then
 			exit function
 		end if
	else
    	if( astNewPARAM( proc, astNewVAR( hAllocStringConst( "", 0 ), NULL, 0, IR_DATATYPE_FIXSTR ) ) = NULL ) then
 			exit function
 		end if
		if( astNewPARAM( proc, astNewCONSTi( 0, IR_DATATYPE_INTEGER ) ) = NULL ) then
 			exit function
 		end if
	end if

	'' byval coord_type as integer
	if( astNewPARAM( proc, astNewCONSTi( coord_type, IR_DATATYPE_INTEGER ) ) = NULL ) then
 		exit function
 	end if

 	''
 	astAdd( proc )

	function = TRUE

end function

'':::::
function rtlGfxDraw( byval target as ASTNODE ptr, _
					 byval targetisptr as integer, _
					 byval cexpr as ASTNODE ptr )

    dim as ASTNODE ptr proc
    dim as integer targetmode

	function = FALSE

    proc = astNewFUNCT( PROCLOOKUP( GFXDRAW ) )

 	'' byref target as any
 	if( target = NULL ) then
 		target = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
 		targetmode = FB_ARGMODE_BYVAL
 	else
		if( targetisptr ) then
			targetmode = FB_ARGMODE_BYVAL
		else
			targetmode = INVALID
		end if
	end if
	if( astNewPARAM( proc, target, INVALID, targetmode ) = NULL ) then
 		exit function
 	end if

 	'' cmd as string
 	if( astNewPARAM( proc, cexpr ) = NULL ) then
 		exit function
 	end if

 	''
 	astAdd( proc )

	function = TRUE

end function

'':::::
function rtlGfxView( byval x1expr as ASTNODE ptr, _
					 byval y1expr as ASTNODE ptr, _
					 byval x2expr as ASTNODE ptr, _
					 byval y2expr as ASTNODE ptr, _
			    	 byval fillexpr as ASTNODE ptr, _
			    	 byval bordexpr as ASTNODE ptr, _
			    	 byval screenflag as integer ) as integer

    dim as ASTNODE ptr proc

	function = FALSE

    proc = astNewFUNCT( PROCLOOKUP( GFXVIEW ) )

 	'' byval x1 as integer
 	if( x1expr = NULL ) then
        x1expr = astNewCONSTi( -32768, IR_DATATYPE_INTEGER )
    end if
 	if( astNewPARAM( proc, x1expr ) = NULL ) then
 		exit function
 	end if

 	'' byval y1 as integer
 	if( y1expr = NULL ) then
        y1expr = astNewCONSTi( -32768, IR_DATATYPE_INTEGER )
    end if
 	if( astNewPARAM( proc, y1expr ) = NULL ) then
 		exit function
 	end if

 	'' byval x2 as integer
 	if( x2expr = NULL ) then
        x2expr = astNewCONSTi( -32768, IR_DATATYPE_INTEGER )
    end if
 	if( astNewPARAM( proc, x2expr ) = NULL ) then
 		exit function
 	end if

 	'' byval y2 as integer
 	if( y2expr = NULL ) then
        y2expr = astNewCONSTi( -32768, IR_DATATYPE_INTEGER )
    end if
 	if( astNewPARAM( proc, y2expr ) = NULL ) then
 		exit function
 	end if

 	'' byval fillcolor as uinteger
 	if( fillexpr = NULL ) then
 		fillexpr = astNewCONSTi( &hFEFF00FF, IR_DATATYPE_UINT )
 	end if
 	if( astNewPARAM( proc, fillexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval bordercolor as uinteger
 	if( bordexpr = NULL ) then
 		bordexpr = astNewCONSTi( &hFEFF00FF, IR_DATATYPE_UINT )
 	end if
 	if( astNewPARAM( proc, bordexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval screenflag as integer
 	if( astNewPARAM( proc, astNewCONSTi( screenflag, IR_DATATYPE_INTEGER ) ) = NULL ) then
 		exit function
 	end if

 	''
 	astAdd( proc )

	function = TRUE

end function

'':::::
function rtlGfxWindow( byval x1expr as ASTNODE ptr, _
					   byval y1expr as ASTNODE ptr, _
					   byval x2expr as ASTNODE ptr, _
					   byval y2expr as ASTNODE ptr, _
					   byval screenflag as integer ) as integer

    dim as ASTNODE ptr proc

	function = FALSE

    proc = astNewFUNCT( PROCLOOKUP( GFXWINDOW ) )

 	'' byval x1 as single
 	if( x1expr = NULL ) then
        x1expr = astNewCONSTf( 0.0, IR_DATATYPE_SINGLE )
    end if
 	if( astNewPARAM( proc, x1expr ) = NULL ) then
 		exit function
 	end if

 	'' byval y1 as single
 	if( y1expr = NULL ) then
        y1expr = astNewCONSTf( 0.0, IR_DATATYPE_SINGLE )
    end if
 	if( astNewPARAM( proc, y1expr ) = NULL ) then
 		exit function
 	end if

 	'' byval x2 as single
 	if( x2expr = NULL ) then
        x2expr = astNewCONSTf( 0.0, IR_DATATYPE_SINGLE )
    end if
 	if( astNewPARAM( proc, x2expr ) = NULL ) then
 		exit function
 	end if

 	'' byval y2 as single
 	if( y2expr = NULL ) then
        y2expr = astNewCONSTf( 0.0, IR_DATATYPE_SINGLE )
    end if
 	if( astNewPARAM( proc, y2expr ) = NULL ) then
 		exit function
 	end if

 	'' byval screenflag as integer
 	if( astNewPARAM( proc, astNewCONSTi( screenflag, IR_DATATYPE_INTEGER ) ) = NULL ) then
 		exit function
 	end if

 	''
 	astAdd( proc )

	function = TRUE

end function

'':::::
function rtlGfxPalette ( byval attexpr as ASTNODE ptr, _
						 byval rexpr as ASTNODE ptr, _
						 byval gexpr as ASTNODE ptr, _
						 byval bexpr as ASTNODE ptr, _
						 byval isget as integer ) as integer

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f
    dim as integer defval, targetmode

	function = FALSE

    if( isget ) then
    	f = PROCLOOKUP( GFXPALETTEGET )
    else
    	f = PROCLOOKUP( GFXPALETTE )
    end if
	proc = astNewFUNCT( f )

	if( isget ) then
		targetmode = FB_ARGMODE_BYREF
		defval = 0
	else
		targetmode = FB_ARGMODE_BYVAL
		defval = -1
	end if

 	'' byval attr as integer
 	if( attexpr = NULL ) then
        attexpr = astNewCONSTi( -1, IR_DATATYPE_INTEGER )
    end if
 	if( astNewPARAM( proc, attexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval r as integer
 	if( rexpr = NULL ) then
        rexpr = astNewCONSTi( -1, IR_DATATYPE_INTEGER )
    end if
 	if( astNewPARAM( proc, rexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval g as integer
 	if( gexpr = NULL ) then
 		targetmode = FB_ARGMODE_BYVAL
        gexpr = astNewCONSTi( defval, IR_DATATYPE_INTEGER )
    end if
 	if( astNewPARAM( proc, gexpr, INVALID, targetmode ) = NULL ) then
 		exit function
 	end if

 	'' byval b as integer
 	if( bexpr = NULL ) then
        bexpr = astNewCONSTi( defval, IR_DATATYPE_INTEGER )
    end if
 	if( astNewPARAM( proc, bexpr, INVALID, targetmode ) = NULL ) then
 		exit function
 	end if

 	''
 	astAdd( proc )

	function = TRUE

end function

'':::::
function rtlGfxPaletteUsing ( byval arrayexpr as ASTNODE ptr, _
							  byval isget as integer ) as integer

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f

	function = FALSE

    if( isget ) then
    	f = PROCLOOKUP( GFXPALETTEGETUSING )
    else
    	f = PROCLOOKUP( GFXPALETTEUSING )
    end if
	proc = astNewFUNCT( f )

 	'' byref array as integer
 	if( astNewPARAM( proc, arrayexpr ) = NULL ) then
 		exit function
 	end if

 	''
 	astAdd( proc )

	function = TRUE

end function

'':::::
function rtlGfxPut( byval target as ASTNODE ptr, _
					byval targetisptr as integer, _
					byval xexpr as ASTNODE ptr, _
					byval yexpr as ASTNODE ptr, _
			   		byval arrayexpr as ASTNODE ptr, _
			   		byval isptr as integer, _
					byval x1expr as ASTNODE ptr, _
					byval x2expr as ASTNODE ptr, _
					byval y1expr as ASTNODE ptr, _
					byval y2expr as ASTNODE ptr, _
			   		byval mode as integer, _
			   		byval alphaexpr as ASTNODE ptr, _
			   		byval funcexpr as ASTNODE ptr, _
			   		byval coordtype as integer ) as integer

    dim as ASTNODE ptr proc
    dim as integer targetmode, argmode
    dim as FBSYMBOL ptr reslabel

    function = FALSE

    proc = astNewFUNCT( PROCLOOKUP( GFXPUT ) )

 	'' byref target as any
 	if( target = NULL ) then
 		target = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
 		targetmode = FB_ARGMODE_BYVAL
 	else
		if( targetisptr ) then
			targetmode = FB_ARGMODE_BYVAL
		else
			targetmode = INVALID
		end if
	end if
	if( astNewPARAM( proc, target, INVALID, targetmode ) = NULL ) then
 		exit function
 	end if

 	'' byval x as single
 	if( astNewPARAM( proc, xexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval y as single
 	if( astNewPARAM( proc, yexpr ) = NULL ) then
 		exit function
 	end if

 	'' byref array as any
	if( isptr ) then
		argmode = FB_ARGMODE_BYVAL
	else
		argmode = INVALID
	end if
 	if( astNewPARAM( proc, arrayexpr, INVALID, argmode ) = NULL ) then
 		exit function
 	end if

 	'' area coordinates, if any
 	if( x1expr = NULL ) then
 		x1expr = astNewCONSTi( &hFFFF0000, IR_DATATYPE_INTEGER )
 		x2expr = astNewCONSTi( &hFFFF0000, IR_DATATYPE_INTEGER )
 		y1expr = astNewCONSTi( &hFFFF0000, IR_DATATYPE_INTEGER )
 		y2expr = astNewCONSTi( &hFFFF0000, IR_DATATYPE_INTEGER )
 	end if
  	if( astNewPARAM( proc, x1expr ) = NULL ) then
 		exit function
 	end if
  	if( astNewPARAM( proc, x2expr ) = NULL ) then
 		exit function
 	end if
  	if( astNewPARAM( proc, y1expr ) = NULL ) then
 		exit function
 	end if
  	if( astNewPARAM( proc, y2expr ) = NULL ) then
 		exit function
 	end if

 	'' byval coordtype as integer
 	if( astNewPARAM( proc, astNewCONSTi( coordtype, IR_DATATYPE_INTEGER ) ) = NULL ) then
 		exit function
 	end if

 	'' byval mode as integer
 	if( astNewPARAM( proc, astNewCONSTi( mode, IR_DATATYPE_INTEGER ) ) = NULL ) then
 		exit function
 	end if

	'' byval alpha as integer
	if( alphaexpr = NULL ) then
		alphaexpr = astNewCONSTi( -1, IR_DATATYPE_INTEGER )
	end if
 	if( astNewPARAM( proc, alphaexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval func as function( src as uinteger, dest as uinteger ) as uinteger
 	if( funcexpr = NULL ) then
 		funcexpr = astNewCONSTi(0, IR_DATATYPE_INTEGER )
 	end if
 	if( astNewPARAM( proc, funcexpr ) = NULL ) then
 		exit function
 	end if

    ''
    if( env.clopt.resumeerr ) then
    	reslabel = symbAddLabel( NULL )
    	astAdd( astNewLABEL( reslabel ) )
    else
    	reslabel = NULL
    end if

	function = rtlErrorCheck( proc, reslabel, lexLineNum( ) )

end function

'':::::
function rtlGfxGet( byval target as ASTNODE ptr, _
					byval targetisptr as integer, _
					byval x1expr as ASTNODE ptr, _
					byval y1expr as ASTNODE ptr, _
					byval x2expr as ASTNODE ptr, _
					byval y2expr as ASTNODE ptr, _
			   		byval arrayexpr as ASTNODE ptr, _
			   		byval isptr as integer, _
			   		byval symbol as FBSYMBOL ptr, _
			   		byval coordtype as integer ) as integer

    dim as ASTNODE ptr proc
    dim as integer targetmode, argmode
    dim as FBSYMBOL ptr reslabel

    function = FALSE

    proc = astNewFUNCT( PROCLOOKUP( GFXGET ) )

 	'' byref target as any
 	if( target = NULL ) then
 		target = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
 		targetmode = FB_ARGMODE_BYVAL
 	else
		if( targetisptr ) then
			targetmode = FB_ARGMODE_BYVAL
		else
			targetmode = INVALID
		end if
	end if
	if( astNewPARAM( proc, target, INVALID, targetmode ) = NULL ) then
 		exit function
 	end if

 	'' byval x1 as single
 	if( astNewPARAM( proc, x1expr ) = NULL ) then
 		exit function
 	end if

 	'' byval y1 as single
 	if( astNewPARAM( proc, y1expr ) = NULL ) then
 		exit function
 	end if

 	'' byval x2 as single
 	if( astNewPARAM( proc, x2expr ) = NULL ) then
 		exit function
 	end if

 	'' byval y2 as single
 	if( astNewPARAM( proc, y2expr ) = NULL ) then
 		exit function
 	end if

 	'' byref array as any
	if( isptr ) then
		argmode = FB_ARGMODE_BYVAL
	else
		argmode = INVALID
	end if
 	if( astNewPARAM( proc, arrayexpr, INVALID, argmode ) = NULL ) then
 		exit function
 	end if

 	'' byval coordtype as integer
 	if( astNewPARAM( proc, astNewCONSTi( coordtype, IR_DATATYPE_INTEGER ) ) = NULL ) then
 		exit function
 	end if

 	'' array() as any
 	if( not isptr ) then
 		arrayexpr = astNewVAR( symbol, NULL, 0, symbGetType( symbol ) )
 	else
 		arrayexpr = astNewCONSTi( NULL, IR_DATATYPE_POINTER+IR_DATATYPE_VOID )
 	end if
 	if( astNewPARAM( proc, arrayexpr, INVALID, argmode ) = NULL ) then
 		exit function
 	end if

    ''
    if( env.clopt.resumeerr ) then
    	reslabel = symbAddLabel( NULL )
    	astAdd( astNewLABEL( reslabel ) )
    else
    	reslabel = NULL
    end if

	function = rtlErrorCheck( proc, reslabel, lexLineNum( ) )

end function

'':::::
function rtlGfxScreenSet( byval wexpr as ASTNODE ptr, _
						  byval hexpr as ASTNODE ptr, _
						  byval dexpr as ASTNODE ptr, _
						  byval pexpr as ASTNODE ptr, _
						  byval fexpr as ASTNODE ptr, _
						  byval rexpr as ASTNODE ptr ) as integer

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f, reslabel

	function = FALSE

	if( hexpr = NULL ) then
		f = PROCLOOKUP( GFXSCREENSET )
	else
		f = PROCLOOKUP( GFXSCREENRES )
	end if
    proc = astNewFUNCT( f )

 	'' byval m as integer
 	if( astNewPARAM( proc, wexpr ) = NULL ) then
 		exit function
 	end if

	if( hexpr <> NULL ) then
		if( astNewPARAM( proc, hexpr ) = NULL ) then
			exit function
		end if
	end if

 	'' byval d as integer
 	if( dexpr = NULL ) then
 		dexpr = astNewCONSTi( 8, IR_DATATYPE_INTEGER )
 	end if
 	if( astNewPARAM( proc, dexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval depth as integer
 	if( pexpr = NULL ) then
 		pexpr = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
 	end if
 	if( astNewPARAM( proc, pexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval fullscreen s integer
 	if( fexpr = NULL ) then
 		fexpr = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
 	end if
 	if( astNewPARAM( proc, fexpr ) = NULL ) then
 		exit function
 	end if

	'' byval refresh_rate as integer
	if( rexpr = NULL ) then
		rexpr = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
	end if
 	if( astNewPARAM( proc, rexpr ) = NULL ) then
 		exit function
 	end if

    ''
    if( env.clopt.resumeerr ) then
    	reslabel = symbAddLabel( NULL )
    	astAdd( astNewLABEL( reslabel ) )
    else
    	reslabel = NULL
    end if

	function = rtlErrorCheck( proc, reslabel, lexLineNum( ) )

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' profiling
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private function hGetProcName( byval proc as FBSYMBOL ptr ) as ASTNODE ptr
	dim as string procname
	dim as FBSYMBOL ptr s
	dim as ASTNODE ptr expr
	dim as integer at

	if( proc = NULL ) then
		s = hAllocStringConst( "(??)", -1 )

	else
		procname = symbGetName( proc )

		select case fbGetNaming( )
        case FB_COMPNAMING_WIN32, FB_COMPNAMING_CYGWIN
			procname = mid( procname, 2)
			at = instr( procname, "@" )
			if( at ) then
				procname = mid( procname, 1, at - 1 )
			end if
        end select

		if( len( procname ) and 3 ) then
			procname += string( 4 - ( len( procname ) and 3 ), 32 )
		end if
		s = hAllocStringConst( procname, -1 )
	end if

	expr = astNewADDR( IR_OP_ADDROF, astNewVAR( s, NULL, 0, IR_DATATYPE_FIXSTR ), s, NULL )

	function = expr

end function

'':::::
function rtlProfileBeginCall( byval symbol as FBSYMBOL ptr ) as ASTNODE ptr
	dim as ASTNODE ptr proc, expr

	function = NULL

	proc = astNewFUNCT( PROCLOOKUP( PROFILEBEGINCALL ), NULL, TRUE )

	expr = hGetProcName( symbol )
	if( astNewPARAM( proc, expr, INVALID, FB_ARGMODE_BYVAL ) = NULL ) then
		exit function
	end if

	function = proc

end function

'':::::
function rtlProfileEndCall( ) as ASTNODE ptr
    dim as ASTNODE ptr proc

	function = NULL

    proc = astNewFUNCT( PROCLOOKUP( PROFILEENDCALL ), NULL, TRUE )

  	function = proc

end function
