'' intrinsic runtime lib gfx functions (SCREEN, PSET, LINE, ...)
''
'' chng: oct/2004 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "ast.bi"
#include once "lex.bi"
#include once "rtl.bi"

declare function hGfxlib_cb _
	( _
		byval sym as FBSYMBOL ptr _
	) as integer

declare function hPorts_cb _
	( _
		byval sym as FBSYMBOL ptr _
	) as integer

	dim shared as FB_RTL_PROCDEF funcdata( 0 to ... ) = _
	{ _
		/' sub fb_GfxPset _
			( _
				byval target as any ptr = 0, _
				byval x as const single, _
				byval y as const single, _
				byval color as const ulong, _
				byval coord_type as const long, _
				byval ispreset as const long _
			) '/ _
		( _
			@FB_RTL_GFXPSET, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NONE, _
			6, _
			{ _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_ULONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_GfxPoint _
			( _
				byval target as any ptr = 0, _
				byval x as const single, _
				byval y as const single _
			) as ulong '/ _
		( _
			@FB_RTL_GFXPOINT, NULL, _
			FB_DATATYPE_ULONG, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_GfxLine _
			( _
				byval target as any ptr = 0, _
				byval x1 as const single = 0, _
				byval y1 as const single = 0, _
				byval x2 as const single = 0, _
				byval y2 as const single = 0, _
				byval color as const ulong = DEFAULT_COLOR, _
				byval type as const long = LINE_TYPE_LINE, _
				byval style as const ulong = &hFFFF, _
				byval coord_type as const long = COORD_TYPE_AA _
			) '/ _
		( _
			@FB_RTL_GFXLINE, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NONE, _
			9, _
			{ _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_ULONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_ULONG ), FB_PARAMMODE_BYVAL, TRUE, &hFFFF ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_GfxEllipse _
			( _
				byval target as any ptr = 0, _
				byval x as const single, _
				byval y as const single, _
				byval radius as const single, _
				byval color as const ulong = DEFAULT_COLOR, _
				byval aspect as const single = 0.0, _
				byval start as const single = 0.0, _
				byval end as const single = 6.283186, _
				byval fill as const long = 0, _
				byval coord_type as const long = COORD_TYPE_A _
			) '/ _
		( _
			@FB_RTL_GFXCIRCLE, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NONE, _
			10, _
			{ _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_ULONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_GfxPaint _
			( _
				byval target as any ptr = 0, _
				byval fx as const single, _
				byval fy as const single, _
				byval color as const ulong = DEFAULT_COLOR, _
				byval border_color as const ulong = DEFAULT_COLOR, _
				byref pattern as const string, _
				byval mode as const long = PAINT_TYPE_FILL, _
				byval coord_type as const long = COORD_TYPE_A _
			) '/ _
		( _
			@FB_RTL_GFXPAINT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NONE, _
			8, _
			{ _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_ULONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_ULONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_GfxDraw( byval target as any ptr = 0, byref cmd as const string ) '/ _
		( _
			@FB_RTL_GFXDRAW, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function fb_GfxDrawString _
			( _
				byval target as any ptr = 0, _
				byval fx as const single, _
				byval fy as const single, _
				byval coord_type as const long = COORD_TYPE_A, _
				byref string as const string, _
				byval color as const ulong = DEFAULT_COLOR, _
				byval font as const any ptr = 0, _
				byval mode as const long, _
				byval putter as PUTTER ptr, _
				byval blender as BLENDER ptr = 0, _
				byval param as any ptr _
			) '/ _
		( _
			@FB_RTL_GFXDRAWSTRING, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_ERROR, _
			11, _
			{ _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_ULONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_VOID ) ), FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_GfxView _
			( _
				byval x1 as const long = -32768, _
				byval y1 as const long = -32768, _
				byval x2 as const long = -32768, _
				byval y2 as const long = -32768, _
				byval fill_color as const ulong = 0, _
				byval border_color as const ulong = 0, _
				byval screen as const long _
			) '/ _
		( _
			@FB_RTL_GFXVIEW, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NONE, _
			7, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -32768 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -32768 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -32768 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -32768 ), _
				( typeSetIsConst( FB_DATATYPE_ULONG ), FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_ULONG ), FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_GfxWindow _
			( _
				byval x1 as const single = 0, _
				byval y1 as const single = 0, _
				byval x2 as const single = 0, _
				byval y2 as const single = 0, _
				byval screen as const long = 0 _
			) '/ _
		( _
			@FB_RTL_GFXWINDOW, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NONE, _
			5, _
			{ _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, 0 ) _
			} _
		), _
		/' sub fb_GfxPalette _
			( _
				byval index as const long = -1, _
				byval r as const long = -1, _
				byval g as const long = -1, _
				byval b as const long = -1 _
			) '/ _
		( _
			@FB_RTL_GFXPALETTE, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NONE, _
			4, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -1 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -1 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -1 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -1 ) _
			} _
		), _
		/' sub fb_GfxPaletteUsing( byval data as const long ptr ) '/ _
		( _
			@FB_RTL_GFXPALETTEUSING, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_LONG ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_GfxPaletteUsing64( byval data as const longint ptr ) '/ _
		( _
			@FB_RTL_GFXPALETTEUSING64, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_LONGINT ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_GfxPaletteGet _
			( _
				byval index as const long = -1, _
				byref r as long, _
				byref g as long, _
				byref b as long _
			) '/ _
		( _
			@FB_RTL_GFXPALETTEGET, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NONE, _
			4, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -1 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' sub fb_GfxPaletteGet64 _
			( _
				byval index as const long = -1, _
				byref r as longint, _
				byref g as longint, _
				byref b as longint _
			) '/ _
		( _
			@FB_RTL_GFXPALETTEGET64, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NONE, _
			4, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -1 ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' sub fb_GfxPaletteGetUsing( byval data as long ptr ) '/ _
		( _
			@FB_RTL_GFXPALETTEGETUSING, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeAddrOf( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_GfxPaletteGetUsing64( byval data as longint ptr ) '/ _
		( _
			@FB_RTL_GFXPALETTEGETUSING64, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeAddrOf( FB_DATATYPE_LONGINT ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_GfxPut _
			( _
				byval target as any ptr = 0, _
				byval x as const single, _
				byval y as const single, _
				byval src as const any ptr, _
				byval x1 as const long = &hFFFF0000, _
				byval y1 as const long = &hFFFF0000, _
				byval x2 as const long = &hFFFF0000, _
				byval y2 as const long = &hFFFF0000, _
				byval coord_type as const long, _
				byval mode as const long, _
				byval putter as PUTTER ptr, _
				byval alpha as const long = -1, _
				byval blender as BLENDER ptr = 0, _
				byval param as any ptr = 0 _
			) as long '/ _
		( _
			@FB_RTL_GFXPUT, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_ERROR, _
			14, _
			{ _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_VOID ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, &hFFFF0000 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, &hFFFF0000 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, &hFFFF0000 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, &hFFFF0000 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -1 ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, TRUE, 0 ) _
			} _
		), _
		/' function fb_GfxGet _
			( _
				byval target as const any ptr = 0, _
				byval x1 as const single, _
				byval y1 as const single, _
				byval x2 as const single, _
				byval y2 as const single, _
				byval dest as any ptr, _
				byval coord_type as long, _
				array() as any _
			) as long '/ _
		( _
			@FB_RTL_GFXGET, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_ERROR or FB_RTL_OPT_FBONLY, _
			8, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_VOID ) ), FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_VOID ), FB_PARAMMODE_BYDESC, FALSE ) _
			} _
		), _
		/' function fb_GfxGetQB _
			( _
				byval target as const any ptr = 0, _
				byval x1 as const single, _
				byval y1 as const single, _
				byval x2 as const single, _
				byval y2 as const single, _
				byval dest as any ptr, _
				byval coord_type as const long, _
				array() as any _
			) as long '/ _
		( _
			@FB_RTL_GFXGETQB, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_ERROR or FB_RTL_OPT_NOFB, _
			8, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_VOID ) ), FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE ) _
			} _
		), _
		/' function fb_GfxScreen _
			( _
				byval mode as const long, _
				byval depth as const long = 8, _
				byval num_pages as const long = 0, _
				byval flags as const long = 0, _
				byval refresh_rate as const long = 0 _
			) as long '/ _
		( _
			@FB_RTL_GFXSCREENSET, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NONE, _
			5, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, 8 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, 0 ) _
			} _
		), _
		/' function fb_GfxScreenQB _
			( _
				byval mode as const long, _
				byval visible as const long = -1,
				byval active as const long = -1 _
			) as long '/ _
		( _
			@FB_RTL_GFXSCREENSETQB, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -1 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -1 ) _
			} _
		), _
		/' function screenres _
			( _
				byval width as const long, _
				byval height as const long, _
				byval depth as const long = 8, _
				byval num_pages as const long = 1, _
				byval flags as const long = 0, _
				byval refresh_rate as const long = 0 _
			) as long '/ _
		( _
			@"screenres", @"fb_GfxScreenRes", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_ERROR or FB_RTL_OPT_NOQB, _
			6, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, 8 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, 1 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, 0 ) _
			} _
		), _
		/' function bload _
			( _
				byref filename as const string, _
				byval dest as any ptr = NULL, _
				byval pal as any ptr = NULL _
			) as long '/ _
		( _
			@"bload", @"fb_GfxBload", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_ERROR or FB_RTL_OPT_FBONLY, _
			3, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, TRUE, NULL ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, TRUE, NULL ) _
			} _
		), _
		/' function bload _
			( _
				byref filename as const string, _
				byval dest as any ptr = NULL, _
				byval pal as any ptr = NULL _
			) as long '/ _
		( _
			@"bload", @"fb_GfxBloadQB", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_ERROR or FB_RTL_OPT_NOFB, _
			3, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, TRUE, NULL ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, TRUE, NULL ) _
			} _
		), _
		/' function bsave overload _
			( _
				byref filename as const string, _
				byval src as const any ptr, _
				byval size as const ulong = 0, _
				byval pal as const any ptr = 0 _
			) as long '/ _
		( _
			@"bsave", @"fb_GfxBsave", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_OVER or FB_RTL_OPT_ERROR, _
			4, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_VOID ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_ULONG ), FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_VOID ) ), FB_PARAMMODE_BYVAL, TRUE, 0 ) _
			} _
		), _
		/' function bsave overload _
			( _
				byref filename as const string, _
				byval src as const any ptr, _
				byval size as const ulong = 0, _
				byval pal as const any ptr, _
				byval bitsperpixel as const long _
			) as long '/ _
		( _
			@"bsave", @"fb_GfxBsaveEx", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_OVER or FB_RTL_OPT_ERROR, _
			5, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_VOID ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_ULONG ), FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_VOID ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function flip _
			( _
				byval from_page as const long = -1, _
				byval to_page as const long = -1 _
			) as long '/ _
		( _
			@"flip", @"fb_GfxFlip", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -1 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -1 ) _
			} _
		), _
		/' function screencopy _
			( _
				byval from_page as const long = -1, _
				byval to_page as const long = -1 _
			) as long '/ _
		( _
			@"screencopy", @"fb_GfxFlip", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -1 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -1 ) _
			} _
		), _
		/' function pointcoord( byval func as const long ) as single '/ _
		( _
			@"pointcoord", @"fb_GfxCursor", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function pmap( byval coord as const single, byval func as const long ) as single '/ _
		( _
			@"pmap", @"fb_GfxPMap", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function out( byval port as const ushort, byval value as const ubyte ) as long '/ _
		( _
			@"out", @"fb_Out", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			 @hPorts_cb, FB_RTL_OPT_ERROR, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_USHORT ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function inp( byval port as const ushort ) as long '/ _
		( _
			@"inp", @"fb_In", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			@hPorts_cb, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_USHORT ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function wait _
			( _
				byval port as const ushort, _
				byval and as const long, _
				byval xor as const long = 0 _
			) as long '/ _
		( _
			@"wait", @"fb_Wait", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			@hPorts_cb, FB_RTL_OPT_ERROR, _
			3, _
			{ _
				( typeSetIsConst( FB_DATATYPE_USHORT ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, 0 ) _
			} _
		), _
		/' function screensync( ) as long '/ _
		( _
			@"screensync", @"fb_GfxWaitVSync", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			0 _
		), _
		/' function screenset cdecl _
			( _
				byval work_page as const long = -1, _
				byval visible_page as const long = -1 _
			) as long '/ _
		( _
			@"screenset", @"fb_GfxPageSet", _
			FB_DATATYPE_LONG, FB_FUNCMODE_CDECL, _
			@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -1 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -1 ) _
			} _
		), _
		/' sub screenlock( ) '/ _
		( _
			@"screenlock", @"fb_GfxLock", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			0 _
		), _
		/' sub screenunlock( byval start_line as const long, byval end_line as const long ) '/ _
		( _
			@"screenunlock", @"fb_GfxUnlock", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -1 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -1 ) _
			} _
		), _
		/' function screenptr( ) as any ptr '/ _
		( _
			@"screenptr", @"fb_GfxScreenPtr", _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			0 _
		), _
		/' sub windowtitle( byref title as const string ) '/ _
		( _
			@"windowtitle", @"fb_GfxSetWindowTitle", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function multikey( byval scancode as const long ) as long '/ _
		( _
			@"multikey", @"fb_Multikey", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function getmouse overload _
			( _
				byref x as long, _
				byref y as long, _
				byref z as long = 0, _
				byref buttons as long = 0, _
				byref clip as long = 0 _
			) as long '/ _
		( _
			@"getmouse", @"fb_GetMouse", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			5, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, FALSE, 0 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, FALSE, 0 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, TRUE, 0 ) _
			} _
		), _
		/' function getmouse overload _
			( _
				byref x as longint, _
				byref y as longint, _
				byref z as longint = 0, _
				byref buttons as longint = 0, _
				byref clip as longint = 0 _
			) as long '/ _
		( _
			@"getmouse", @"fb_GetMouse64", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			5, _
			{ _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, FALSE, 0  ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, FALSE, 0 ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, TRUE, 0 ) _
			} _
		), _
		/' function setmouse _
			( _
				byval x as const long = &h80000000, _
				byval y as const long = &h80000000, _
				byval cursor as const long = -1, _
				byval clip as const long = -1 _
			) as long '/ _
		( _
			@"setmouse", @"fb_SetMouse", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NOQB, _
			4, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, &h80000000 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, &h80000000 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -1 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -1 ) _
			} _
		), _
		/' function getjoystick _
			( _
				byval id as const long, _
				byref buttons as integer = 0, _
				byref a1 as single = 0, _
				byref a2 as single = 0, _
				byref a3 as single = 0, _
				byref a4 as single = 0, _
				byref a5 as single = 0, _
				byref a6 as single = 0, _
				byref a7 as single = 0, _
				byref a8 as single = 0 _
			) as long '/ _
		( _
			@"getjoystick", @"fb_GfxGetJoystick", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			10, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE, 0 ), _
				( FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, TRUE, 0 ) _
			} _
		), _
		/' function stick( byval n as const long ) as long '/ _
		( _
			@"stick", @"fb_GfxStickQB", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_QBONLY, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function strig( byval n as const long ) as long '/ _
		( _
			@"strig", @"fb_GfxStrigQB", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_QBONLY, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub screeninfo overload _
			( _
				byref width as long = 0, _
				byref height as long = 0, _
				byref depth as long = 0, _
				byref bpp as long = 0, _
				byref pitch as long = 0, _
				byref refresh_rate as long = 0, _
				byref driver as string = byval NULL _
			) '/ _
		( _
			@"screeninfo", @"fb_GfxScreenInfo32", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			7, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, TRUE, NULL ) _
			} _
		), _
		/' sub screeninfo overload _
			( _
				byref width as longint, _
				byref height as longint, _
				byref depth as longint = 0, _
				byref bpp as longint = 0, _
				byref pitch as longint = 0, _
				byref refresh_rate as longint = 0, _
				byref driver as string = byval NULL _
			) '/ _
		( _
			@"screeninfo", @"fb_GfxScreenInfo64", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			7, _
			{ _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, TRUE, NULL ) _
			} _
		), _
		/' function screenlist( byval depth as const long = 0 ) as long '/ _
		( _
			@"screenlist", @"fb_GfxScreenList", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, 0 ) _
			} _
		), _
		/' function fb_GfxImageCreate _
			( _
				byval width as const long, _
				byval height as const long, _
				byval color as const ulong = 0, _
				byval depth as const long = 0, _
				byval flags as const long = 0 _
			) as any ptr '/ _
		( _
			@FB_RTL_GFXIMAGECREATE, NULL, _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_FBONLY, _
			5, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_ULONG ), FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, 0 ) _
			} _
		), _
		/' function fb_GfxImageCreateQB _
			( _
				byval width as const long, _
				byval height as const long, _
				byval color as const ulong = 0, _
				byval depth as const long = 0, _
				byval flags as const long = 0 _
			) as any ptr '/ _
		( _
			@FB_RTL_GFXIMAGECREATEQB, NULL, _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			5, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_ULONG ), FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, 0 ) _
			} _
		), _
		/' sub imagedestroy( byval image as const any ptr ) '/ _
		( _
			@"imagedestroy", @"fb_GfxImageDestroy", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_VOID ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function imageinfo overload _
			( _
				byval img     as const any ptr, _
				byref width   as long = 0, _
				byref height  as long = 0, _
				byref bpp     as long = 0, _
				byref pitch   as long = 0, _
				byref imgdata as any ptr = 0, _
				byref size    as long = 0 _
			) as long '/ _
		( _
			@"imageinfo", @"fb_GfxImageInfo32", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			7, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_VOID ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, TRUE, 0 ) _
			} _
		), _
		/' function imageinfo overload _
			( _
				byval img     as const any ptr, _
				byref width   as longint, _
				byref height  as longint, _
				byref bpp     as longint = 0, _
				byref pitch   as longint = 0, _
				byref imgdata as any ptr = 0, _
				byref size    as longint = 0 _
			) as long '/ _
		( _
			@"imageinfo", @"fb_GfxImageInfo64", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			7, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_VOID ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, TRUE, 0 ) _
			} _
		), _
		/' sub imageconvertrow _
			( _
				byval src as const any ptr, _
				byval src_bpp as const long, _
				byval dest as any ptr, _
				byval dst_bpp as const long, _
				byval width as const long, _
				byval isrgb as const long = 1 _
			) '/ _
		( _
			@"imageconvertrow", @"fb_GfxImageConvertRow", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			6, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_VOID ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, 1 ) _
			} _
		), _
		/' function screenevent( byval event as EVENT ptr ) as long '/ _
		( _
			@"screenevent", @"fb_GfxEvent", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, TRUE, 0 ) _
			} _
		), _
		/' sub screencontrol overload _
			( _
				byval what as const long, _
				byref param as string _
			) '/ _
		( _
			@"screencontrol", @"fb_GfxControl_s", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF ) _
			} _
		), _
		/' sub screencontrol overload _
			( _
				byval what as const long, _
				byref param1 as long = &h80000000, _
				byref param2 as long = &h80000000, _
				byref param3 as long = &h80000000, _
				byref param4 as long = &h80000000 _
			) '/ _
		( _
			@"screencontrol", @"fb_GfxControl_i32", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			5, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, TRUE, &h80000000 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, TRUE, &h80000000 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, TRUE, &h80000000 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, TRUE, &h80000000 ) _
			} _
		), _
		/' sub screencontrol overload _
			( _
				byval what as const long, _
				byref param1 as longint, _
				byref param2 as longint = &h80000000, _
				byref param3 as longint = &h80000000, _
				byref param4 as longint = &h80000000 _
			) '/ _
		( _
			@"screencontrol", @"fb_GfxControl_i64", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			5, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, TRUE, &h80000000 ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, TRUE, &h80000000 ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, TRUE, &h80000000 ) _
			} _
		), _
		/' function screenglproc( byval proc as const zstring ptr ) as any ptr '/ _
		( _
			@"screenglproc", @"fb_GfxGetGLProcAddress", _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_CHAR ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_hPutTrans cdecl _
			( _
				byval src as const ubyte ptr, _
				byval dest as ubyte ptr, _
				byval w as const long, _
				byval h as const long, _
				byval src_pitch as const long, _
				byval dest_pitch as const long, _
				byval alpha as const long, _
				byval blender as BLENDER ptr, _
				byval param as any ptr _
			) '/ _
		( _
			@FB_RTL_GFXPUTTRANS, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
			@hGfxlib_cb, FB_RTL_OPT_NONE, _
			9, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_UBYTE ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_hPutPSet cdecl _
			( _
				byval src as const ubyte ptr, _
				byval dest as ubyte ptr, _
				byval w as const long, _
				byval h as const long, _
				byval src_pitch as const long, _
				byval dest_pitch as const long, _
				byval alpha as const long, _
				byval blender as BLENDER ptr, _
				byval param as any ptr _
			) '/ _
		( _
			@FB_RTL_GFXPUTPSET, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
			@hGfxlib_cb, FB_RTL_OPT_NONE, _
			9, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_UBYTE ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_hPutPReset cdecl _
			( _
				byval src as const ubyte ptr, _
				byval dest as ubyte ptr, _
				byval w as const long, _
				byval h as const long, _
				byval src_pitch as const long, _
				byval dest_pitch as const long, _
				byval alpha as const long, _
				byval blender as BLENDER ptr, _
				byval param as any ptr _
			) '/ _
		( _
			@FB_RTL_GFXPUTPRESET, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
			@hGfxlib_cb, FB_RTL_OPT_NONE, _
			9, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_UBYTE ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_hPutAnd cdecl _
			( _
				byval src as const ubyte ptr, _
				byval dest as ubyte ptr, _
				byval w as const long, _
				byval h as const long, _
				byval src_pitch as const long, _
				byval dest_pitch as const long, _
				byval alpha as const long, _
				byval blender as BLENDER ptr, _
				byval param as any ptr _
			) '/ _
		( _
			@FB_RTL_GFXPUTAND, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
			@hGfxlib_cb, FB_RTL_OPT_NONE, _
			9, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_UBYTE ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_hPutOr cdecl _
			( _
				byval src as const ubyte ptr, _
				byval dest as ubyte ptr, _
				byval w as const long, _
				byval h as const long, _
				byval src_pitch as const long, _
				byval dest_pitch as const long, _
				byval alpha as const long, _
				byval blender as BLENDER ptr, _
				byval param as any ptr _
			) '/ _
		( _
			@FB_RTL_GFXPUTOR, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
			@hGfxlib_cb, FB_RTL_OPT_NONE, _
			9, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_UBYTE ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_hPutXor cdecl _
			( _
				byval src as const ubyte ptr, _
				byval dest as ubyte ptr, _
				byval w as const long, _
				byval h as const long, _
				byval src_pitch as const long, _
				byval dest_pitch as const long, _
				byval alpha as const long, _
				byval blender as BLENDER ptr, _
				byval param as any ptr _
			) '/ _
		( _
			@FB_RTL_GFXPUTXOR, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
			@hGfxlib_cb, FB_RTL_OPT_NONE, _
			9, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_UBYTE ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_hPutAlpha cdecl _
			( _
				byval src as const ubyte ptr, _
				byval dest as ubyte ptr, _
				byval w as const long, _
				byval h as const long, _
				byval src_pitch as const long, _
				byval dest_pitch as const long, _
				byval alpha as const long, _
				byval blender as BLENDER ptr, _
				byval param as any ptr _
			) '/ _
		( _
			@FB_RTL_GFXPUTALPHA, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
			@hGfxlib_cb, FB_RTL_OPT_NONE, _
			9, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_UBYTE ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_hPutBlend cdecl _
			( _
				byval src as const ubyte ptr, _
				byval dest as ubyte ptr, _
				byval w as const long, _
				byval h as const long, _
				byval src_pitch as const long, _
				byval dest_pitch as const long, _
				byval alpha as const long, _
				byval blender as BLENDER ptr, _
				byval param as any ptr _
			) '/ _
		( _
			@FB_RTL_GFXPUTBLEND, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
			@hGfxlib_cb, FB_RTL_OPT_NONE, _
			9, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_UBYTE ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_hPutAdd cdecl _
			( _
				byval src as const ubyte ptr, _
				byval dest as ubyte ptr, _
				byval w as const long, _
				byval h as const long, _
				byval src_pitch as const long, _
				byval dest_pitch as const long, _
				byval alpha as const long, _
				byval blender as BLENDER ptr, _
				byval param as any ptr _
			) '/ _
		( _
			@FB_RTL_GFXPUTADD, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
			@hGfxlib_cb, FB_RTL_OPT_NONE, _
			9, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_UBYTE ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_hPutCustom cdecl _
			( _
				byval src as const ubyte ptr, _
				byval dest as ubyte ptr, _
				byval w as const long, _
				byval h as const long, _
				byval src_pitch as const long, _
				byval dest_pitch as const long, _
				byval alpha as const long, _
				byval blender as BLENDER ptr, _
				byval param as any ptr _
			) '/ _
		( _
			@FB_RTL_GFXPUTCUSTOM, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
			@hGfxlib_cb, FB_RTL_OPT_NONE, _
			9, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_UBYTE ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' EOL '/ _
		( _
			NULL _
		) _
	}

'':::::
sub rtlGfxModInit( )

	rtlAddIntrinsicProcs( @funcdata(0) )

end sub

'':::::
sub rtlGfxModEnd( )

	'' procs will be deleted when symbEnd is called

end sub

'':::::
private function hPorts_cb _
	( _
		byval sym as FBSYMBOL ptr _
	) as integer

	'' minor optimization to avoid having to lookup env.libs hash
	fbRestartableStaticVariable( integer, libsAdded, FALSE )

	if( libsadded = FALSE ) then
		libsAdded = TRUE

		select case env.clopt.target
		case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
			fbAddLib("advapi32")
		end select
	end if

	function = TRUE

end function

private function hGfxlib_cb( byval sym as FBSYMBOL ptr ) as integer
	env.clopt.gfx = TRUE
	function = TRUE
end function

'':::::
private function hGetPutter _
	( _
		byval mode as integer _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr proc = any

	select case as const mode
	case FBGFX_PUTMODE_TRANS
		proc = PROCLOOKUP( GFXPUTTRANS )
	case FBGFX_PUTMODE_PSET
		proc = PROCLOOKUP( GFXPUTPSET )
	case FBGFX_PUTMODE_PRESET
		proc = PROCLOOKUP( GFXPUTPRESET )
	case FBGFX_PUTMODE_AND
		proc = PROCLOOKUP( GFXPUTAND )
	case FBGFX_PUTMODE_OR
		proc = PROCLOOKUP( GFXPUTOR )
	case FBGFX_PUTMODE_XOR
		proc = PROCLOOKUP( GFXPUTXOR )
	case FBGFX_PUTMODE_ALPHA
		proc = PROCLOOKUP( GFXPUTALPHA )
	case FBGFX_PUTMODE_BLEND
		proc = PROCLOOKUP( GFXPUTBLEND )
	case FBGFX_PUTMODE_ADD
		proc = PROCLOOKUP( GFXPUTADD )
	case else
		assert(mode = FBGFX_PUTMODE_CUSTOM)
		proc = PROCLOOKUP( GFXPUTCUSTOM )
	end select

	function = astBuildProcAddrof( proc )
end function

function rtlGfxPset _
	( _
		byval target as ASTNODE ptr, _
		byval xexpr as ASTNODE ptr, _
		byval yexpr as ASTNODE ptr, _
		byval cexpr as ASTNODE ptr, _
		byval coordtype as integer, _
		byval ispreset as integer _
	) as integer

	dim as ASTNODE ptr proc = any

	function = FALSE

	proc = astNewCALL( PROCLOOKUP( GFXPSET ) )

	'' byval target as any ptr
	if( astNewARG( proc, target ) = NULL ) then
		exit function
	end if

	'' byval x as single
	if( astNewARG( proc, xexpr ) = NULL ) then
		exit function
	end if

	'' byval y as single
	if( astNewARG( proc, yexpr ) = NULL ) then
		exit function
	end if

	'' byval color as uinteger
	if( astNewARG( proc, cexpr ) = NULL ) then
		exit function
	end if

	'' byval coordtype as integer
	if( astNewARG( proc, astNewCONSTi( coordtype ) ) = NULL ) then
		exit function
	end if

	'' byval ispreset as integer
	if( astNewARG( proc, astNewCONSTi( ispreset ) ) = NULL ) then
		exit function
	end if

	astAdd( proc )
	function = TRUE
end function

function rtlGfxPoint _
	( _
		byval target as ASTNODE ptr, _
		byval xexpr as ASTNODE ptr, _
		byval yexpr as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any

	function = NULL

	proc = astNewCALL( PROCLOOKUP( GFXPOINT ) )

	'' byval target as any ptr
	if( astNewARG( proc, target ) = NULL ) then
		exit function
	end if

	'' byval x as single
	if( astNewARG( proc, xexpr ) = NULL ) then
		exit function
	end if

	'' byval y as single
	if( yexpr = NULL ) then
		yexpr = astNewCONSTf( -8388607, FB_DATATYPE_SINGLE )
	end if
	if( astNewARG( proc, yexpr ) = NULL ) then
		exit function
	end if

	function = proc
end function

function rtlGfxLine _
	( _
		byval target as ASTNODE ptr, _
		byval x1expr as ASTNODE ptr, _
		byval y1expr as ASTNODE ptr, _
		byval x2expr as ASTNODE ptr, _
		byval y2expr as ASTNODE ptr, _
		byval cexpr as ASTNODE ptr, _
		byval linetype as integer, _
		byval styleexpr as ASTNODE ptr, _
		byval coordtype as integer _
	) as integer

	dim as ASTNODE ptr proc = any

	function = FALSE

	proc = astNewCALL( PROCLOOKUP( GFXLINE ) )

	'' byval target as any ptr
	if( astNewARG( proc, target ) = NULL ) then
		exit function
	end if

	'' byval x1 as single
	if( astNewARG( proc, x1expr ) = NULL ) then
		exit function
	end if

	'' byval y1 as single
	if( astNewARG( proc, y1expr ) = NULL ) then
		exit function
	end if

	'' byval x2 as single
	if( astNewARG( proc, x2expr ) = NULL ) then
		exit function
	end if

	'' byval y2 as single
	if( astNewARG( proc, y2expr ) = NULL ) then
		exit function
	end if

	'' byval color as uinteger
	if( astNewARG( proc, cexpr ) = NULL ) then
		exit function
	end if

	'' byval linetype as integer
	if( astNewARG( proc, astNewCONSTi( linetype ) ) = NULL ) then
		exit function
	end if

	'' byval style as uinteger
	if( astNewARG( proc, styleexpr ) = NULL ) then
		exit function
	end if

	'' byval coordtype as integer
	if( astNewARG( proc, astNewCONSTi( coordtype ) ) = NULL ) then
		exit function
	end if

	astAdd( proc )
	function = TRUE
end function

'':::::
function rtlGfxCircle _
	( _
		byval target as ASTNODE ptr, _
		byval xexpr as ASTNODE ptr, _
		byval yexpr as ASTNODE ptr, _
		byval radexpr as ASTNODE ptr, _
		byval cexpr as ASTNODE ptr, _
		byval aspexpr as ASTNODE ptr, _
		byval iniexpr as ASTNODE ptr, _
		byval endexpr as ASTNODE ptr, _
		byval fillflag as integer, _
		byval coordtype as integer _
	) as integer

	dim as ASTNODE ptr proc = any

	function = FALSE

	proc = astNewCALL( PROCLOOKUP( GFXCIRCLE ) )

	'' byval target as any ptr
	if( astNewARG( proc, target ) = NULL ) then
		exit function
	end if

	'' byval x as single
	if( astNewARG( proc, xexpr ) = NULL ) then
		exit function
	end if

	'' byval y as single
	if( astNewARG( proc, yexpr ) = NULL ) then
		exit function
	end if

	'' byval radians as single
	if( astNewARG( proc, radexpr ) = NULL ) then
		exit function
	end if

	'' byval color as uinteger
	if( astNewARG( proc, cexpr ) = NULL ) then
		exit function
	end if

	'' byval aspect as single
	if( aspexpr = NULL ) then
		aspexpr = astNewCONSTf( 0.0, FB_DATATYPE_SINGLE )
	end if
	if( astNewARG( proc, aspexpr ) = NULL ) then
		exit function
	end if

	'' byval arcini as single
	if( iniexpr = NULL ) then
		iniexpr = astNewCONSTf( 0.0, FB_DATATYPE_SINGLE )
	end if
	if( astNewARG( proc, iniexpr ) = NULL ) then
		exit function
	end if

	'' byval arcend as single
	if( endexpr = NULL ) then
		endexpr = astNewCONSTf( 3.141593*2, FB_DATATYPE_SINGLE )
	end if
	if( astNewARG( proc, endexpr ) = NULL ) then
		exit function
	end if

	'' byval fillflag as integer
	if( astNewARG( proc, astNewCONSTi( fillflag ) ) = NULL ) then
		exit function
	end if

	'' byval coordtype as integer
	if( astNewARG( proc, astNewCONSTi( coordtype ) ) = NULL ) then
		exit function
	end if

	astAdd( proc )
	function = TRUE
end function

function rtlGfxPaint _
	( _
		byval target as ASTNODE ptr, _
		byval xexpr as ASTNODE ptr, _
		byval yexpr as ASTNODE ptr, _
		byval pexpr as ASTNODE ptr, _
		byval bexpr as ASTNODE ptr, _
		byval coord_type as integer _
	) as integer

	dim as ASTNODE ptr proc = any
	dim as integer pattern = any

	function = FALSE

	proc = astNewCALL( PROCLOOKUP( GFXPAINT ) )

	'' byval target as any ptr
	if( astNewARG( proc, target ) = NULL ) then
		exit function
	end if

	'' byval x as single
	if( astNewARG( proc, xexpr ) = NULL ) then
		exit function
	end if

	'' byval y as single
	if( astNewARG( proc, yexpr ) = NULL ) then
		exit function
	end if

	'' byval color as uinteger
	if( symbIsString( astGetDataType( pexpr ) ) ) then
		pattern = TRUE
		if( astNewARG( proc, astNewCONSTi( &hFFFF0000 ) ) = NULL ) then
			exit function
		end if
	else
		pattern = FALSE
		if( astNewARG( proc, pexpr ) = NULL ) then
			exit function
		end if
	end if

	'' byval border_color as uinteger
	if( astNewARG( proc, bexpr ) = NULL ) then
		exit function
	end if

	'' pattern as string
	if( pattern ) then
		if( astNewARG( proc, pexpr ) = NULL ) then
			exit function
		end if
	else
		if( astNewARG( proc, astNewVAR( symbAllocStrConst( "", 0 ) ) ) = NULL ) then
			exit function
		end if
	end if

	'' byval mode as integer
	if( astNewARG( proc, astNewCONSTi( iif( pattern, 1, 0 ) ) ) = NULL ) then
		exit function
	end if

	'' byval coord_type as integer
	if( astNewARG( proc, astNewCONSTi( coord_type ) ) = NULL ) then
		exit function
	end if

	astAdd( proc )
	function = TRUE
end function

function rtlGfxDraw _
	( _
		byval target as ASTNODE ptr, _
		byval cexpr as ASTNODE ptr _
	) as integer

	dim as ASTNODE ptr proc = any

	function = FALSE

	proc = astNewCALL( PROCLOOKUP( GFXDRAW ) )

	'' byval target as any ptr
	if( astNewARG( proc, target ) = NULL ) then
		exit function
	end if

	'' cmd as string
	if( astNewARG( proc, cexpr ) = NULL ) then
		exit function
	end if

	astAdd( proc )
	function = TRUE
end function

function rtlGfxDrawString _
	( _
		byval target as ASTNODE ptr, _
		byval xexpr as ASTNODE ptr, _
		byval yexpr as ASTNODE ptr, _
		byval sexpr as ASTNODE ptr, _
		byval cexpr as ASTNODE ptr, _
		byval fexpr as ASTNODE ptr, _
		byval coord_type as integer, _
		byval mode as integer, _
		byval alphaexpr as ASTNODE ptr, _
		byval funcexpr as ASTNODE ptr, _
		byval paramexpr as ASTNODE ptr _
	) as integer

	dim as ASTNODE ptr proc = any, putter = any

	function = FALSE

	proc = astNewCALL( PROCLOOKUP( GFXDRAWSTRING ) )

	'' byval target as any ptr
	if( astNewARG( proc, target ) = NULL ) then
		exit function
	end if

	'' byval x as single
	if( astNewARG( proc, xexpr ) = NULL ) then
		exit function
	end if

	'' byval y as single
	if( astNewARG( proc, yexpr ) = NULL ) then
		exit function
	end if

	'' byval coord_type as integer
	if( astNewARG( proc, astNewCONSTi( coord_type ) ) = NULL ) then
		exit function
	end if

	'' text as string
	if( astNewARG( proc, sexpr ) = NULL ) then
		exit function
	end if

	'' byval color as uinteger
	if( alphaexpr <> NULL ) then
		cexpr = alphaexpr
	end if
	if( astNewARG( proc, cexpr ) = NULL ) then
		exit function
	end if

	'' byref font as any
	if( astNewARG( proc, fexpr ) = NULL ) then
		exit function
	end if

	'' byval mode as integer
	if( astNewARG( proc, astNewCONSTi( mode ) ) = NULL ) then
		exit function
	end if

	'' byval putter as integer
	if( astNewARG( proc, iif( fexpr, hGetPutter( mode ), astNewCONSTi( 0 ) ) ) = NULL ) then
		exit function
	end if

	'' byval func as function( src as uinteger, dest as uinteger ) as uinteger
	if( astNewARG( proc, funcexpr ) = NULL ) then
		exit function
	end if

	'' byval param as any ptr
	if( paramexpr = NULL ) then
		paramexpr = astNewCONSTi( 0 )
	end if
	if( astNewARG( proc, paramexpr ) = NULL ) then
		exit function
	end if

	astAdd( rtlErrorCheck( proc ) )
	function = TRUE
end function

function rtlGfxView _
	( _
		byval x1expr as ASTNODE ptr, _
		byval y1expr as ASTNODE ptr, _
		byval x2expr as ASTNODE ptr, _
		byval y2expr as ASTNODE ptr, _
		byval fillexpr as ASTNODE ptr, _
		byval bordexpr as ASTNODE ptr, _
		byval screenflag as integer _
	) as integer

	dim as ASTNODE ptr proc = any

	function = FALSE

	proc = astNewCALL( PROCLOOKUP( GFXVIEW ) )

	'' byval x1 as integer
	if( astNewARG( proc, x1expr ) = NULL ) then
		exit function
	end if

	'' byval y1 as integer
	if( astNewARG( proc, y1expr ) = NULL ) then
		exit function
	end if

	'' byval x2 as integer
	if( astNewARG( proc, x2expr ) = NULL ) then
		exit function
	end if

	'' byval y2 as integer
	if( astNewARG( proc, y2expr ) = NULL ) then
		exit function
	end if

	'' byval fillcolor as uinteger
	if( astNewARG( proc, fillexpr ) = NULL ) then
		exit function
	end if

	'' byval bordercolor as uinteger
	if( astNewARG( proc, bordexpr ) = NULL ) then
		exit function
	end if

	'' byval screenflag as integer
	if( astNewARG( proc, astNewCONSTi( screenflag ) ) = NULL ) then
		exit function
	end if

	astAdd( proc )
	function = TRUE
end function

function rtlGfxWindow _
	( _
		byval x1expr as ASTNODE ptr, _
		byval y1expr as ASTNODE ptr, _
		byval x2expr as ASTNODE ptr, _
		byval y2expr as ASTNODE ptr, _
		byval screenflag as integer _
	) as integer

	dim as ASTNODE ptr proc = any

	function = FALSE

	proc = astNewCALL( PROCLOOKUP( GFXWINDOW ) )

	'' byval x1 as single
	if( x1expr = NULL ) then
		x1expr = astNewCONSTf( 0.0, FB_DATATYPE_SINGLE )
	end if
	if( astNewARG( proc, x1expr ) = NULL ) then
		exit function
	end if

	'' byval y1 as single
	if( y1expr = NULL ) then
		y1expr = astNewCONSTf( 0.0, FB_DATATYPE_SINGLE )
	end if
	if( astNewARG( proc, y1expr ) = NULL ) then
		exit function
	end if

	'' byval x2 as single
	if( x2expr = NULL ) then
		x2expr = astNewCONSTf( 0.0, FB_DATATYPE_SINGLE )
	end if
	if( astNewARG( proc, x2expr ) = NULL ) then
		exit function
	end if

	'' byval y2 as single
	if( y2expr = NULL ) then
		y2expr = astNewCONSTf( 0.0, FB_DATATYPE_SINGLE )
	end if
	if( astNewARG( proc, y2expr ) = NULL ) then
		exit function
	end if

	'' byval screenflag as integer
	if( astNewARG( proc, astNewCONSTi( screenflag ) ) = NULL ) then
		exit function
	end if

	astAdd( proc )
	function = TRUE
end function

function rtlGfxPalette  _
	( _
		byval attexpr as ASTNODE ptr, _
		byval rexpr as ASTNODE ptr, _
		byval gexpr as ASTNODE ptr, _
		byval bexpr as ASTNODE ptr, _
		byval isget as integer _
	) as integer

	dim as ASTNODE ptr proc = any
	dim as FBSYMBOL ptr f = any
	dim as integer gbdefval = any, gbmode = any

	function = FALSE

	if( isget ) then
		'' Choose one of these two:
		''
		'' fb_GfxPaletteGet():   r/g/b BYREF parameters = 32bit integers
		'' fb_GfxPaletteGet64(): r/g/b BYREF parameters = 64bit integers
		''
		'' There are only these two overloads available, so we can
		'' choose one based on the r parameter's type.
		''
		'' It probably wouldn't be useful to have overloads where the
		'' r/g/b BYREF parameters have mixed types, because who'd use
		'' a 32bit r/g and 64bit b, or similar?
		if( typeGetSize( astGetDataType( rexpr ) ) = 8 ) then
			f = PROCLOOKUP( GFXPALETTEGET64 )
		else
			f = PROCLOOKUP( GFXPALETTEGET )
		end if
	else
		f = PROCLOOKUP( GFXPALETTE )
	end if

	proc = astNewCALL( f )

	'' byval index as long
	if( astNewARG( proc, attexpr ) = NULL ) then
		exit function
	end if

	'' byval|byref r as long|longint
	if( rexpr = NULL ) then
		rexpr = astNewCONSTi( -1 )
	end if
	if( astNewARG( proc, rexpr ) = NULL ) then
		exit function
	end if

	'' The g/b parameters can be omitted. In that case r is the (whole) color.
	''    PALETTE [GET] index, color
	''    PALETTE [GET] index, r, g, b
	assert( (gexpr <> NULL) = (bexpr <> NULL) )
	if( gexpr ) then
		gbmode = INVALID  '' Let astNewARG() use the param's default
	else
		'' In case of PALETTE, g/b are BYVAL params and we pass BYVAL -1 as
		'' default value. In case of PALETTE GET, they're BYREF params and we
		'' pass BYVAL null pointers.
		if( isget ) then
			gbdefval = 0    '' BYVAL null arg to BYREF param
		else
			gbdefval = -1   '' BYVAL -1 arg to BYVAL param
		end if
		gexpr = astNewCONSTi( gbdefval )
		bexpr = astNewCONSTi( gbdefval )
		gbmode = FB_PARAMMODE_BYVAL
	end if

	'' byval|byref g as long|longint
	if( astNewARG( proc, gexpr, , gbmode ) = NULL ) then
		exit function
	end if

	'' byval|byref b as long|longint
	if( astNewARG( proc, bexpr, , gbmode ) = NULL ) then
		exit function
	end if

	astAdd( proc )
	function = TRUE
end function

function rtlGfxPaletteUsing  _
	( _
		byval arrayexpr as ASTNODE ptr, _
		byval isget as integer, _
		byval is64bit as integer _
	) as integer

	dim as ASTNODE ptr proc = any
	dim as FBSYMBOL ptr f = any

	function = FALSE

	if( is64bit ) then
		if( isget ) then
			f = PROCLOOKUP( GFXPALETTEGETUSING64 )
		else
			f = PROCLOOKUP( GFXPALETTEUSING64 )
		end if
	else
		if( isget ) then
			f = PROCLOOKUP( GFXPALETTEGETUSING )
		else
			f = PROCLOOKUP( GFXPALETTEUSING )
		end if
	end if
	proc = astNewCALL( f )

	'' byval array as long|longint ptr
	if( astNewARG( proc, arrayexpr ) = NULL ) then
		exit function
	end if

	astAdd( proc )
	function = TRUE
end function

function rtlGfxPut _
	( _
		byval target as ASTNODE ptr, _
		byval xexpr as ASTNODE ptr, _
		byval yexpr as ASTNODE ptr, _
		byval arrayexpr as ASTNODE ptr, _
		byval x1expr as ASTNODE ptr, _
		byval x2expr as ASTNODE ptr, _
		byval y1expr as ASTNODE ptr, _
		byval y2expr as ASTNODE ptr, _
		byval mode as integer, _
		byval alphaexpr as ASTNODE ptr, _
		byval funcexpr as ASTNODE ptr, _
		byval paramexpr as ASTNODE ptr, _
		byval coordtype as integer _
	) as integer

	dim as ASTNODE ptr proc = any

	function = FALSE

	proc = astNewCALL( PROCLOOKUP( GFXPUT ) )

	'' byval target as any ptr
	if( astNewARG( proc, target ) = NULL ) then
		exit function
	end if

	'' byval x as single
	if( astNewARG( proc, xexpr ) = NULL ) then
		exit function
	end if

	'' byval y as single
	if( astNewARG( proc, yexpr ) = NULL ) then
		exit function
	end if

	'' byval array as any ptr
	if( astNewARG( proc, arrayexpr ) = NULL ) then
		exit function
	end if

	'' area coordinates, if any
	if( astNewARG( proc, x1expr ) = NULL ) then
		exit function
	end if
	if( astNewARG( proc, x2expr ) = NULL ) then
		exit function
	end if
	if( astNewARG( proc, y1expr ) = NULL ) then
		exit function
	end if
	if( astNewARG( proc, y2expr ) = NULL ) then
		exit function
	end if

	'' byval coordtype as integer
	if( astNewARG( proc, astNewCONSTi( coordtype ) ) = NULL ) then
		exit function
	end if

	'' byval mode as integer
	if( astNewARG( proc, astNewCONSTi( mode ) ) = NULL ) then
		exit function
	end if

	'' byval putter as integer
	if( astNewARG( proc, hGetPutter( mode ) ) = NULL ) then
		exit function
	end if

	'' byval alpha as integer
	if( astNewARG( proc, alphaexpr ) = NULL ) then
		exit function
	end if

	'' byval func as function( src as uinteger, dest as uinteger ) as uinteger
	if( astNewARG( proc, funcexpr ) = NULL ) then
		exit function
	end if

	'' byval param as any ptr
	if( astNewARG( proc, paramexpr ) = NULL ) then
		exit function
	end if

	astAdd( rtlErrorCheck( proc ) )
	function = TRUE
end function

function rtlGfxGet _
	( _
		byval target as ASTNODE ptr, _
		byval x1expr as ASTNODE ptr, _
		byval y1expr as ASTNODE ptr, _
		byval x2expr as ASTNODE ptr, _
		byval y2expr as ASTNODE ptr, _
		byval arrayexpr as ASTNODE ptr, _
		byval coordtype as integer, _
		byval descexpr as ASTNODE ptr _
	) as integer

	dim as ASTNODE ptr proc = any

	function = FALSE

	'' use new header in -lang fb, otherwise old header
	proc = astNewCALL( iif( fbLangIsSet( FB_LANG_FB ), PROCLOOKUP( GFXGET ), PROCLOOKUP( GFXGETQB ) ) )

	'' byval target as any ptr
	if( astNewARG( proc, target ) = NULL ) then
		exit function
	end if

	'' byval x1 as single
	if( astNewARG( proc, x1expr ) = NULL ) then
		exit function
	end if

	'' byval y1 as single
	if( astNewARG( proc, y1expr ) = NULL ) then
		exit function
	end if

	'' byval x2 as single
	if( astNewARG( proc, x2expr ) = NULL ) then
		exit function
	end if

	'' byval y2 as single
	if( astNewARG( proc, y2expr ) = NULL ) then
		exit function
	end if

	'' byval array as any ptr
	if( astNewARG( proc, arrayexpr ) = NULL ) then
		exit function
	end if

	'' byval coordtype as integer
	if( astNewARG( proc, astNewCONSTi( coordtype ) ) = NULL ) then
		exit function
	end if

	'' array() as any
	if( descexpr ) then
		'' Pass array BYDESC, so a temp array descriptor will
		'' automatically be used if needed.
		if( astNewARG( proc, descexpr ) = NULL ) then
			exit function
		end if
	else
		if( astNewARG( proc, astNewCONSTi( 0 ), , FB_PARAMMODE_BYVAL ) = NULL ) then
			exit function
		end if
	end if

	astAdd( rtlErrorCheck( proc ) )
	function = TRUE
end function

function rtlGfxScreenSet _
	( _
		byval mexpr as ASTNODE ptr, _
		byval dexpr as ASTNODE ptr, _
		byval pexpr as ASTNODE ptr, _
		byval fexpr as ASTNODE ptr, _
		byval rexpr as ASTNODE ptr _
	) as integer

	dim as ASTNODE ptr proc = any

	function = FALSE

	proc = astNewCALL( PROCLOOKUP( GFXSCREENSET ) )

	'' byval m as integer
	if( astNewARG( proc, mexpr ) = NULL ) then
		exit function
	end if

	'' byval d as integer
	if( astNewARG( proc, dexpr ) = NULL ) then
		exit function
	end if

	'' byval depth as integer
	if( astNewARG( proc, pexpr ) = NULL ) then
		exit function
	end if

	'' byval flags as integer
	if( astNewARG( proc, fexpr ) = NULL ) then
		exit function
	end if

	'' byval refresh_rate as integer
	if( astNewARG( proc, rexpr ) = NULL ) then
		exit function
	end if

	astAdd( rtlErrorCheck( proc ) )
	function = TRUE
end function

function rtlGfxScreenSetQB _
	( _
		byval mode as ASTNODE ptr, _
		byval active as ASTNODE ptr, _
		byval visible as ASTNODE ptr _
	) as integer

	dim as ASTNODE ptr proc = any

	function = FALSE

	proc = astNewCALL( PROCLOOKUP( GFXSCREENSETQB ) )

	'' byval mode as integer
	if( astNewARG( proc, mode ) = NULL ) then
		exit function
	end if

	'' byval active as integer
	if( astNewARG( proc, active ) = NULL ) then
		exit function
	end if

	'' byval visible as integer
	if( astNewARG( proc, visible ) = NULL ) then
		exit function
	end if

	astAdd( rtlErrorCheck( proc ) )
	function = TRUE
end function

function rtlGfxImageCreate _
	( _
		byval wexpr as ASTNODE ptr, _
		byval hexpr as ASTNODE ptr, _
		byval cexpr as ASTNODE ptr, _
		byval dexpr as ASTNODE ptr, _
		byval flags as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any

	function = NULL

	'' use new header in -lang fb, otherwise old header
	proc = astNewCALL( iif( fbLangIsSet( FB_LANG_FB ), PROCLOOKUP( GFXIMAGECREATE ), PROCLOOKUP( GFXIMAGECREATEQB ) ) )

	'' byval w as integer
	if( astNewARG( proc, wexpr ) = NULL ) then
		exit function
	end if

	'' byval h as integer
	if( astNewARG( proc, hexpr ) = NULL ) then
		exit function
	end if

	'' byval c as integer
	if( astNewARG( proc, cexpr ) = NULL ) then
		exit function
	end if

	'' byval d as integer
	if( astNewARG( proc, dexpr ) = NULL ) then
		exit function
	end if

	'' byval flags as integer
	if( astNewARG( proc, astNewCONSTi( flags ) ) = NULL ) then
		exit function
	end if

	function = proc
end function
