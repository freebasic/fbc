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
				byref target as any, _
				byval x as single, _
				byval y as single, _
				byval color as ulong, _
				byval coord_type as long, _
				byval ispreset as long _
			) '/ _
		( _
			@FB_RTL_GFXPSET, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
			6, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_GfxPoint _
			( _
				byref target as any, _
				byval x as single, _
				byval y as single _
			) as long '/ _
		( _
			@FB_RTL_GFXPOINT, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_GfxLine _
			( _
				byref target as any, _
				byval x1 as single = 0, _
				byval y1 as single = 0, _
				byval x2 as single = 0, _
				byval y2 as single = 0, _
				byval color as ulong = DEFAULT_COLOR, _
				byval type as long = LINE_TYPE_LINE, _
				byval style as ulong = &hFFFF, _
				byval coord_type as long = COORD_TYPE_AA _
			) '/ _
		( _
			@FB_RTL_GFXLINE, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
			9, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_GfxEllipse _
			( _
				byref target as any, _
				byval x as single, _
				byval y as single, _
				byval radius as single, _
				byval color as ulong = DEFAULT_COLOR, _
				byval aspect as single = 0.0, _
				byval start as single = 0.0, _
				byval end as single = 6.283186, _
				byval fill as long = 0, _
				byval coord_type as long = COORD_TYPE_A _
			) '/ _
		( _
			@FB_RTL_GFXCIRCLE, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
			10, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_GfxPaint _
			( _
				byref target as any, _
				byval fx as single, _
				byval fy as single, _
				byval color as ulong = DEFAULT_COLOR, _
				byval border_color as ulong = DEFAULT_COLOR, _
				byref pattern as string, _
				byval mode as long = PAINT_TYPE_FILL, _
				byval coord_type as long = COORD_TYPE_A _
			) '/ _
		( _
			@FB_RTL_GFXPAINT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
			8, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_GfxDraw( byref target as any, byref cmd as string ) '/ _
		( _
			@FB_RTL_GFXDRAW, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE ) _
	 		} _
		), _
		/' function fb_GfxDrawString _
			( _
				byref target as any, _
				byval fx as single, _
				byval fy as single, _
				byval coord_type as long = COORD_TYPE_A, _
				byref string as string, _
				byval color as ulong = DEFAULT_COLOR, _
				byval font as any = NULL, _
				byval mode as long, _
				byval putter as PUTTER ptr, _
				byval blender as BLENDER ptr, _
				byval param as any ptr _
			) '/ _
		( _
			@FB_RTL_GFXDRAWSTRING, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_ERROR, _
			11, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_GfxView _
			( _
				byval x1 as long, _
				byval y1 as long, _
				byval x2 as long, _
				byval y2 as long, _
				byval fill_color as ulong, _
				byval border_color as ulong, _
				byval screen as long _
			) '/ _
		( _
			@FB_RTL_GFXVIEW, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
			7, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_GfxWindow _
			( _
				byval x1 as single = 0, _
				byval y1 as single = 0, _
				byval x2 as single = 0, _
				byval y2 as single = 0, _
				byval screen as long = 0 _
			) '/ _
		( _
			@FB_RTL_GFXWINDOW, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
			5, _
			{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ) _
	 		} _
		), _
		/' sub fb_GfxPalette _
			( _
				byval index as long = -1, _
				byval r as long = -1, _
				byval g as long = -1, _
				byval b as long = -1 _
			) '/ _
		( _
			@FB_RTL_GFXPALETTE, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
			4, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, -1 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, -1 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, -1 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, -1 ) _
	 		} _
		), _
		/' sub fb_GfxPaletteUsing( byref data as long ) '/ _
		( _
			@FB_RTL_GFXPALETTEUSING, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' sub fb_GfxPaletteUsing64( byref data as longint ) '/ _
		( _
			@FB_RTL_GFXPALETTEUSING64, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' sub fb_GfxPaletteGet _
			( _
				byval index as long, _
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
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' sub fb_GfxPaletteGet64 _
			( _
				byval index as long, _
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
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' sub fb_GfxPaletteGetUsing( byref data as long ) '/ _
		( _
			@FB_RTL_GFXPALETTEGETUSING, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' sub fb_GfxPaletteGetUsing64( byref data as longint ) '/ _
		( _
			@FB_RTL_GFXPALETTEGETUSING64, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function fb_GfxPut _
			( _
				byref target as any, _
				byval x as single, _
				byval y as single, _
				byref src as any, _
				byval x1 as long, _
				byval y1 as long, _
				byval x2 as long, _
				byval y2 as long, _
				byval coord_type as long, _
				byval mode as long, _
				byval putter as PUTTER ptr, _
				byval alpha as long, _
				byval blender as BLENDER ptr,
				byval param as any ptr _
			) as long '/ _
		( _
			@FB_RTL_GFXPUT, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_ERROR, _
			14, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_GfxGet _
			( _
				byref target as any, _
				byval x1 as single, _
				byval y1 as single, _
				byval x2 as single, _
				byval y2 as single, _
				byref dest as any, _
				byval coord_type as long, _
				array() as any _
			) as long '/ _
		( _
			@FB_RTL_GFXGET, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_ERROR or FB_RTL_OPT_FBONLY, _
			8, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE ) _
	 		} _
		), _
		/' function fb_GfxGetQB _
			( _
				byref target as any, _
				byval x1 as single, _
				byval y1 as single, _
				byval x2 as single, _
				byval y2 as single, _
				byref dest as any, _
				byval coord_type as long, _
				array() as any _
			) as long '/ _
		( _
			@FB_RTL_GFXGETQB, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_ERROR or FB_RTL_OPT_NOFB, _
			8, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE ) _
	 		} _
		), _
		/' function fb_GfxScreen _
			( _
				byval mode as long, _
				byval depth as long = 0, _
				byval num_pages as long = 0, _
		                byval flags as long = 0, _
				byval refresh_rate as long = 0 _
			) as long '/ _
		( _
			@FB_RTL_GFXSCREENSET, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
			5, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ) _
	 		} _
		), _
		/' function fb_GfxScreenQB _
			( _
				byval mode as long, _
				byval visible as long = -1,
				byval active as long = -1 _
			) as long '/ _
		( _
			@FB_RTL_GFXSCREENSETQB, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, -1 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, -1 ) _
	 		} _
		), _
		/' function screenres _
			( _
				byval width as long, _
				byval height as long, _
				byval depth as long = 8, _
				byval num_pages as long = 1, _
				byval flags as long = 0, _
				byval refresh_rate as long = 0 _
			) as long '/ _
		( _
			@"screenres", @"fb_GfxScreenRes", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_ERROR or FB_RTL_OPT_NOQB, _
			6, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 8 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 1 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ) _
	 		} _
		), _
		/' function bload _
			( _
				byref filename as string, _
				byval dest as any ptr = NULL, _
				byval pal as any ptr = NULL _
			) as long '/ _
		( _
			@"bload", @"fb_GfxBload", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_ERROR or FB_RTL_OPT_FBONLY, _
			3, _
			{ _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, TRUE, NULL ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, TRUE, NULL ) _
	 		} _
		), _
		/' function bload _
			( _
				byref filename as string, _
				byval dest as any ptr = NULL, _
				byval pal as any ptr = NULL _
			) as long '/ _
		( _
			@"bload", @"fb_GfxBloadQB", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_ERROR or FB_RTL_OPT_NOFB, _
			3, _
			{ _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, TRUE, NULL ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, TRUE, NULL ) _
	 		} _
		), _
		/' function bsave overload _
			( _
				byref filename as string, _
				byval src as any ptr, _
				byval size as ulong = 0, _
				byval pal as any ptr = 0 _
			) as long '/ _
		( _
			@"bsave", @"fb_GfxBsave", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_OVER or FB_RTL_OPT_ERROR, _
			4, _
			{ _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, TRUE, 0 ) _
	 		} _
		), _
		/' function bsave overload _
			( _
				byref filename as string, _
				byval src as any ptr, _
				byval size as ulong = 0, _
				byval pal as any ptr, _
				byval bitsperpixel as long _
			) as long '/ _
		( _
			@"bsave", @"fb_GfxBsaveEx", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_OVER or FB_RTL_OPT_ERROR, _
			5, _
			{ _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function flip _
			( _
				byval from_page as long = -1, _
				byval to_page as long = -1 _
			) as long '/ _
		( _
			@"flip", @"fb_GfxFlip", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, -1 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, -1 ) _
	 		} _
		), _
		/' function screencopy _
			( _
				byval from_page as long = -1, _
				byval to_page as long = -1 _
			) as long '/ _
		( _
			@"screencopy", @"fb_GfxFlip", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, -1 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, -1 ) _
	 		} _
		), _
		/' function pointcoord( byval func as long ) as single '/ _
		( _
			@"pointcoord", @"fb_GfxCursor", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function pmap( byval coord as single, byval func as long ) as single '/ _
		( _
			@"pmap", @"fb_GfxPMap", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function out( byval port as ushort, byval value as ubyte ) as long '/ _
		( _
			@"out", @"fb_Out", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			 @hPorts_cb, FB_RTL_OPT_ERROR, _
			2, _
			{ _
				( FB_DATATYPE_USHORT, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_UBYTE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function inp( byval port as ushort ) as long '/ _
		( _
			@"inp", @"fb_In", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			@hPorts_cb, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( FB_DATATYPE_USHORT, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function wait _
			( _
				byval port as ushort, _
				byval and as long, _
				byval xor as long = 0 _
			) as long '/ _
		( _
			@"wait", @"fb_Wait", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			@hPorts_cb, FB_RTL_OPT_ERROR, _
			3, _
			{ _
				( FB_DATATYPE_USHORT, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ) _
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
				byval work_page as integer = -1, _
				byval visible_page as integer = -1 _
			) as long '/ _
		( _
			@"screenset", @"fb_GfxPageSet", _
			FB_DATATYPE_LONG, FB_FUNCMODE_CDECL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, -1 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, -1 ) _
	 		} _
		), _
		/' sub screenlock( ) '/ _
		( _
			@"screenlock", @"fb_GfxLock", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			0 _
		), _
		/' sub screenunlock( byval start_line as long, byval end_line as long ) '/ _
		( _
			@"screenunlock", @"fb_GfxUnlock", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, -1 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, -1 ) _
	 		} _
		), _
		/' function screenptr( ) as any ptr '/ _
		( _
			@"screenptr", @"fb_GfxScreenPtr", _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			0 _
		), _
		/' sub windowtitle( byref title as string ) '/ _
		( _
			@"windowtitle", @"fb_GfxSetWindowTitle", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE ) _
	 		} _
		), _
		/' function multikey( byval scancode as long ) as long '/ _
		( _
			@"multikey", @"fb_Multikey", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
	 		@rtlMultinput_cb, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function getmouse overload _
			( _
				byref x as long = 0, _
				byref y as long = 0, _
				byref z as long = 0, _
				byref buttons as long = 0, _
				byref clip as long = 0 _
			) as long '/ _
		( _
			@"getmouse", @"fb_GetMouse", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			@rtlMultinput_cb, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			5, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, FALSE, 0, TRUE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, FALSE, 0, TRUE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, TRUE, 0, TRUE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, TRUE, 0, TRUE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, TRUE, 0, TRUE ) _
			} _
		), _
		/' function getmouse overload _
			( _
				byref x as longint = 0, _
				byref y as longint = 0, _
				byref z as longint = 0, _
				byref buttons as longint = 0, _
				byref clip as longint = 0 _
			) as long '/ _
		( _
			@"getmouse", @"fb_GetMouse64", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			@rtlMultinput_cb, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			5, _
			{ _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, FALSE, 0, TRUE ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, FALSE, 0, TRUE ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, TRUE, 0, TRUE ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, TRUE, 0, TRUE ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, TRUE, 0, TRUE ) _
			} _
		), _
		/' function setmouse _
			( _
				byval x as long = -1, _
				byval y as long = -1, _
				byval cursor as long = -1, _
				byval clip as long = -1 _
			) as long '/ _
		( _
			@"setmouse", @"fb_SetMouse", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
	 		@rtlMultinput_cb, FB_RTL_OPT_NOQB, _
			4, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, -1 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, -1 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, -1 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, -1 ) _
	 		} _
		), _
		/' function getjoystick overload _
			( _
				byval id as long = 0, _
				byref buttons as long = 0, _
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
			@hGfxlib_cb, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			10, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE, 0, TRUE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, TRUE, 0, TRUE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, TRUE, 0, TRUE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, TRUE, 0, TRUE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, TRUE, 0, TRUE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, TRUE, 0, TRUE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, TRUE, 0, TRUE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, TRUE, 0, TRUE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, TRUE, 0, TRUE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, TRUE, 0, TRUE ) _
			} _
		), _
		/' function getjoystick overload _
			( _
				byval id as long = 0, _
				byref buttons as longint = 0, _
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
			@"getjoystick", @"fb_GfxGetJoystick64", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			10, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE, 0, TRUE ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, TRUE, 0, TRUE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, TRUE, 0, TRUE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, TRUE, 0, TRUE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, TRUE, 0, TRUE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, TRUE, 0, TRUE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, TRUE, 0, TRUE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, TRUE, 0, TRUE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, TRUE, 0, TRUE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, TRUE, 0, TRUE ) _
			} _
		), _
		/' function stick( byval n as long ) as long '/ _
		( _
			@"stick", @"fb_GfxStickQB", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_QBONLY, _
			1, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function strig( byval n as long ) as long '/ _
		( _
			@"strig", @"fb_GfxStrigQB", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_QBONLY, _
			1, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub screeninfo overload _
			( _
				byref width as long, _
				byref height as long, _
				byref depth as long, _
				byref bpp as long, _
				byref pitch as long, _
				byref refresh_rate as long, _
				byref driver as string _
			) '/ _
		( _
			@"screeninfo", @"fb_GfxScreenInfo", _
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
				byref depth as longint, _
				byref bpp as longint, _
				byref pitch as longint, _
				byref refresh_rate as longint, _
				byref driver as string _
			) '/ _
		( _
			@"screeninfo", @"fb_GfxScreenInfo64", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			7, _
			{ _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, TRUE, NULL ) _
			} _
		), _
		/' function screenlist( byval depth as long = 0 ) as long '/ _
		( _
			@"screenlist", @"fb_GfxScreenList", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ) _
	 		} _
		), _
		/' function fb_GfxImageCreate _
			( _
				byval width as long, _
				byval height as long, _
				byval color as ulong = 0, _
				byval depth as long = 0, _
				byval flags as long = 0 _
			) as any ptr '/ _
		( _
			@FB_RTL_GFXIMAGECREATE, NULL, _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_FBONLY, _
			5, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ) _
	 		} _
		), _
		/' function fb_GfxImageCreateQB _
			( _
				byval width as long, _
				byval height as long, _
				byval color as ulong = 0, _
				byval depth as long = 0, _
				byval flags as long = 0 _
			) as any ptr '/ _
		( _
			@FB_RTL_GFXIMAGECREATEQB, NULL, _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			5, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ) _
	 		} _
		), _
		/' sub imagedestroy( byval image as any ptr ) '/ _
		( _
			@"imagedestroy", @"fb_GfxImageDestroy", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function imageinfo _
			( _
				byval img as any ptr, _
				byref width as long = 0, _
				byref height as long = 0, _
				byref bpp as long = 0, _
				byref pitch as long = 0, _
				byref imgdata as any ptr = 0, _
				byref size as long = 0 _
			) as long '/ _
		( _
			@"imageinfo", @"fb_GfxImageInfo", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			7, _
			{ _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYREF, TRUE, 0 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, TRUE, 0 ) _
			} _
		), _
		/' sub imageconvertrow _
			( _
				byval src as any ptr, _
				byval src_bpp as long, _
				byval dest as any ptr, _
				byval dst_bpp as long, _
				byval width as long, _
				byval isrgb as long = 1 _
			) '/ _
		( _
			@"imageconvertrow", @"fb_GfxImageConvertRow", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			6, _
			{ _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 1 ) _
	 		} _
	 	), _
		/' function screenevent( byval event as EVENT ptr ) as long '/ _
		( _
			@"screenevent", @"fb_GfxEvent", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, TRUE, 0, TRUE ) _
	 		} _
		), _
		/' sub screencontrol overload _
			( _
				byval what as long, _
				byref param as string _
			) '/ _
		( _
			@"screencontrol", @"fb_GfxControl_s", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF ) _
	 		} _
		), _
		/' sub screencontrol overload _
			( _
				byval what as long, _
				byref param1 as integer = &h80000000, _
				byref param2 as integer = &h80000000, _
				byref param3 as integer = &h80000000, _
				byref param4 as integer = &h80000000 _
			) '/ _
		( _
			@"screencontrol", @"fb_GfxControl_i", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			5, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, TRUE, &h80000000 ), _
				( FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, TRUE, &h80000000 ), _
				( FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, TRUE, &h80000000 ), _
				( FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, TRUE, &h80000000 ) _
	 		} _
		), _
		/' function screenglproc( byval proc as zstring ptr ) as any ptr '/ _
		( _
			@"screenglproc", @"fb_GfxGetGLProcAddress", _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeAddrOf( FB_DATATYPE_CHAR ), FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_hPutTrans cdecl _
			( _
				byval src as ubyte ptr, _
				byval dest as ubyte ptr, _
				byval w as long, _
				byval h as long, _
				byval src_pitch as long, _
				byval dest_pitch as long, _
				byval alpha as long, _
				byval blender as BLENDER ptr, _
				byval param as any ptr _
			) '/ _
		( _
			@FB_RTL_GFXPUTTRANS, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
	 		9, _
	 		{ _
				( typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_hPutPSet cdecl _
			( _
				byval src as ubyte ptr, _
				byval dest as ubyte ptr, _
				byval w as long, _
				byval h as long, _
				byval src_pitch as long, _
				byval dest_pitch as long, _
				byval alpha as long, _
				byval blender as BLENDER ptr, _
				byval param as any ptr _
			) '/ _
		( _
			@FB_RTL_GFXPUTPSET, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
	 		9, _
	 		{ _
				( typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_hPutPReset cdecl _
			( _
				byval src as ubyte ptr, _
				byval dest as ubyte ptr, _
				byval w as long, _
				byval h as long, _
				byval src_pitch as long, _
				byval dest_pitch as long, _
				byval alpha as long, _
				byval blender as BLENDER ptr, _
				byval param as any ptr _
			) '/ _
		( _
			@FB_RTL_GFXPUTPRESET, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
	 		9, _
	 		{ _
				( typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_hPutAnd cdecl _
			( _
				byval src as ubyte ptr, _
				byval dest as ubyte ptr, _
				byval w as long, _
				byval h as long, _
				byval src_pitch as long, _
				byval dest_pitch as long, _
				byval alpha as long, _
				byval blender as BLENDER ptr, _
				byval param as any ptr _
			) '/ _
		( _
			@FB_RTL_GFXPUTAND, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
	 		9, _
	 		{ _
				( typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_hPutOr cdecl _
			( _
				byval src as ubyte ptr, _
				byval dest as ubyte ptr, _
				byval w as long, _
				byval h as long, _
				byval src_pitch as long, _
				byval dest_pitch as long, _
				byval alpha as long, _
				byval blender as BLENDER ptr, _
				byval param as any ptr _
			) '/ _
		( _
			@FB_RTL_GFXPUTOR, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
	 		9, _
	 		{ _
				( typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_hPutXor cdecl _
			( _
				byval src as ubyte ptr, _
				byval dest as ubyte ptr, _
				byval w as long, _
				byval h as long, _
				byval src_pitch as long, _
				byval dest_pitch as long, _
				byval alpha as long, _
				byval blender as BLENDER ptr, _
				byval param as any ptr _
			) '/ _
		( _
			@FB_RTL_GFXPUTXOR, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
	 		9, _
	 		{ _
				( typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_hPutAlpha cdecl _
			( _
				byval src as ubyte ptr, _
				byval dest as ubyte ptr, _
				byval w as long, _
				byval h as long, _
				byval src_pitch as long, _
				byval dest_pitch as long, _
				byval alpha as long, _
				byval blender as BLENDER ptr, _
				byval param as any ptr _
			) '/ _
		( _
			@FB_RTL_GFXPUTALPHA, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
	 		9, _
	 		{ _
				( typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_hPutBlend cdecl _
			( _
				byval src as ubyte ptr, _
				byval dest as ubyte ptr, _
				byval w as long, _
				byval h as long, _
				byval src_pitch as long, _
				byval dest_pitch as long, _
				byval alpha as long, _
				byval blender as BLENDER ptr, _
				byval param as any ptr _
			) '/ _
		( _
			@FB_RTL_GFXPUTBLEND, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
	 		9, _
	 		{ _
				( typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_hPutAdd cdecl _
			( _
				byval src as ubyte ptr, _
				byval dest as ubyte ptr, _
				byval w as long, _
				byval h as long, _
				byval src_pitch as long, _
				byval dest_pitch as long, _
				byval alpha as long, _
				byval blender as BLENDER ptr, _
				byval param as any ptr _
			) '/ _
		( _
			@FB_RTL_GFXPUTADD, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
	 		9, _
	 		{ _
				( typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sub fb_hPutCustom cdecl _
			( _
				byval src as ubyte ptr, _
				byval dest as ubyte ptr, _
				byval w as long, _
				byval h as long, _
				byval src_pitch as long, _
				byval dest_pitch as long, _
				byval alpha as long, _
				byval blender as BLENDER ptr, _
				byval param as any ptr _
			) '/ _
		( _
			@FB_RTL_GFXPUTCUSTOM, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
	 		9, _
	 		{ _
				( typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
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

    static as integer libsAdded = FALSE

	if( libsadded = FALSE ) then
		libsAdded = TRUE

		select case env.clopt.target
		case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
			fbAddLib("advapi32")
		end select
	end if

	function = TRUE

end function

'':::::
function rtlMultinput_cb _
	( _
		byval sym as FBSYMBOL ptr _
	) as integer

    static as integer libsAdded = FALSE

	if( libsadded = FALSE ) then
		libsAdded = TRUE

		select case env.clopt.target
		case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
			fbAddLib("user32")
		end select
	end if

	function = TRUE

end function

'':::::
private function hGfxlib_cb _
	( _
		byval sym as FBSYMBOL ptr _
	) as integer

	static as integer added = FALSE

	if (added = FALSE) then
		added = TRUE

		fbAddLib("fbgfx")

		select case as const fbGetOption( FB_COMPOPT_TARGET )
		case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
			fbAddLib("user32")
			fbAddLib("gdi32")
			fbAddLib("winmm")

		case FB_COMPTARGET_LINUX, FB_COMPTARGET_FREEBSD, _
		     FB_COMPTARGET_OPENBSD, FB_COMPTARGET_NETBSD

			#if defined(__FB_LINUX__) or _
			    defined(__FB_FREEBSD__) or _
			    defined(__FB_OPENBSD__) or _
			    defined(__FB_NETBSD__)
				fbAddLibPath("/usr/X11R6/lib")
			#endif

			fbAddLib("X11")
			fbAddLib("Xext")
			fbAddLib("Xpm")
			fbAddLib("Xrandr")
			fbAddLib("Xrender")

		end select

	end if

	return TRUE
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

'':::::
function rtlGfxPset _
	( _
		byval target as ASTNODE ptr, _
		byval targetisptr as integer, _
		byval xexpr as ASTNODE ptr, _
		byval yexpr as ASTNODE ptr, _
		byval cexpr as ASTNODE ptr, _
		byval coordtype as integer, _
		byval ispreset as integer _
	) as integer

    dim as ASTNODE ptr proc = any
    dim as integer targetmode = any

	function = FALSE

    proc = astNewCALL( PROCLOOKUP( GFXPSET ) )

 	'' byref target as any
 	if( target = NULL ) then
		target = astNewCONSTi( 0 )
 		targetmode = FB_PARAMMODE_BYVAL
 	else
		if( targetisptr ) then
			targetmode = FB_PARAMMODE_BYVAL
		else
			targetmode = INVALID
		end if
	end if
	if( astNewARG( proc, target, , targetmode ) = NULL ) then
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

 	''
 	astAdd( proc )

	function = TRUE

end function

'':::::
function rtlGfxPoint _
	( _
		byval target as ASTNODE ptr, _
		byval targetisptr as integer, _
		byval xexpr as ASTNODE ptr, _
		byval yexpr as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any
	dim as integer targetmode = any

	function = NULL

	proc = astNewCALL( PROCLOOKUP( GFXPOINT ) )

	'' byref target as any
	if( target = NULL ) then
		target = astNewCONSTi( 0 )
 		targetmode = FB_PARAMMODE_BYVAL
 	else
		if( targetisptr ) then
			targetmode = FB_PARAMMODE_BYVAL
		else
			targetmode = INVALID
		end if
	end if
	if( astNewARG( proc, target, , targetmode ) = NULL ) then
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

'':::::
function rtlGfxLine _
	( _
		byval target as ASTNODE ptr, _
		byval targetisptr as integer, _
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
    dim as integer targetmode = any

	function = FALSE

    proc = astNewCALL( PROCLOOKUP( GFXLINE ) )

 	'' byref target as any
 	if( target = NULL ) then
		target = astNewCONSTi( 0 )
 		targetmode = FB_PARAMMODE_BYVAL
 	else
		if( targetisptr ) then
			targetmode = FB_PARAMMODE_BYVAL
		else
			targetmode = INVALID
		end if
	end if
	if( astNewARG( proc, target, , targetmode ) = NULL ) then
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
 	if( styleexpr = NULL ) then
 		styleexpr = astNewCONSTi( &h0000FFFF, FB_DATATYPE_UINT )
 	end if
 	if( astNewARG( proc, styleexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval coordtype as integer
	if( astNewARG( proc, astNewCONSTi( coordtype ) ) = NULL ) then
 		exit function
 	end if

 	''
 	astAdd( proc )

	function = TRUE

end function

'':::::
function rtlGfxCircle _
	( _
		byval target as ASTNODE ptr, _
		byval targetisptr as integer, _
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
    dim as integer targetmode = any

	function = FALSE

    proc = astNewCALL( PROCLOOKUP( GFXCIRCLE ) )

 	'' byref target as any
 	if( target = NULL ) then
		target = astNewCONSTi( 0 )
 		targetmode = FB_PARAMMODE_BYVAL
 	else
		if( targetisptr ) then
			targetmode = FB_PARAMMODE_BYVAL
		else
			targetmode = INVALID
		end if
	end if
	if( astNewARG( proc, target, , targetmode ) = NULL ) then
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

 	''
 	astAdd( proc )

	function = TRUE

end function

'':::::
function rtlGfxPaint _
	( _
		byval target as ASTNODE ptr, _
		byval targetisptr as integer, _
		byval xexpr as ASTNODE ptr, _
		byval yexpr as ASTNODE ptr, _
		byval pexpr as ASTNODE ptr, _
		byval bexpr as ASTNODE ptr, _
		byval coord_type as integer _
	) as integer

    dim as ASTNODE ptr proc = any
    dim as integer targetmode = any, pattern = any

    function = FALSE

	proc = astNewCALL( PROCLOOKUP( GFXPAINT ) )

 	'' byref target as any
 	if( target = NULL ) then
		target = astNewCONSTi( 0 )
 		targetmode = FB_PARAMMODE_BYVAL
 	else
		if( targetisptr ) then
			targetmode = FB_PARAMMODE_BYVAL
		else
			targetmode = INVALID
		end if
	end if
	if( astNewARG( proc, target, , targetmode ) = NULL ) then
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

	'' pattern as string, byval mode as integer
	if( pattern = TRUE ) then
		if( astNewARG( proc, pexpr ) = NULL ) then
 			exit function
 		end if
		if( astNewARG( proc, astNewCONSTi( 1 ) ) = NULL ) then
 			exit function
 		end if
	else
		if( astNewARG( proc, astNewVAR( symbAllocStrConst( "", 0 ) ) ) = NULL ) then
 			exit function
 		end if
		if( astNewARG( proc, astNewCONSTi( 0 ) ) = NULL ) then
 			exit function
 		end if
	end if

	'' byval coord_type as integer
	if( astNewARG( proc, astNewCONSTi( coord_type ) ) = NULL ) then
 		exit function
 	end if

 	''
 	astAdd( proc )

	function = TRUE

end function

'':::::
function rtlGfxDraw _
	( _
		byval target as ASTNODE ptr, _
		byval targetisptr as integer, _
		byval cexpr as ASTNODE ptr _
	) as integer

    dim as ASTNODE ptr proc = any
    dim as integer targetmode = any

	function = FALSE

    proc = astNewCALL( PROCLOOKUP( GFXDRAW ) )

 	'' byref target as any
 	if( target = NULL ) then
		target = astNewCONSTi( 0 )
 		targetmode = FB_PARAMMODE_BYVAL
 	else
		if( targetisptr ) then
			targetmode = FB_PARAMMODE_BYVAL
		else
			targetmode = INVALID
		end if
	end if
	if( astNewARG( proc, target, , targetmode ) = NULL ) then
 		exit function
 	end if

 	'' cmd as string
 	if( astNewARG( proc, cexpr ) = NULL ) then
 		exit function
 	end if

 	''
 	astAdd( proc )

	function = TRUE

end function

'':::::
function rtlGfxDrawString _
	( _
		byval target as ASTNODE ptr, _
		byval targetisptr as integer, _
		byval xexpr as ASTNODE ptr, _
		byval yexpr as ASTNODE ptr, _
		byval sexpr as ASTNODE ptr, _
		byval cexpr as ASTNODE ptr, _
		byval fexpr as ASTNODE ptr, _
		byval fisptr as integer, _
		byval coord_type as integer, _
		byval mode as integer, _
		byval alphaexpr as ASTNODE ptr, _
		byval funcexpr as ASTNODE ptr, _
		byval paramexpr as ASTNODE ptr _
	) as integer

    dim as ASTNODE ptr proc = any, putter = any
    dim as integer targetmode = any

    function = FALSE

	proc = astNewCALL( PROCLOOKUP( GFXDRAWSTRING ) )

 	'' byref target as any
 	if( target = NULL ) then
		target = astNewCONSTi( 0 )
 		targetmode = FB_PARAMMODE_BYVAL
 	else
		if( targetisptr ) then
			targetmode = FB_PARAMMODE_BYVAL
		else
			targetmode = INVALID
		end if
	end if
	if( astNewARG( proc, target, , targetmode ) = NULL ) then
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
 	if( fexpr = NULL ) then
		fexpr = astNewCONSTi( 0 )
 		targetmode = FB_PARAMMODE_BYVAL
		putter = astNewCONSTi( 0 )
 	else
		if( fisptr ) then
			targetmode = FB_PARAMMODE_BYVAL
		else
			targetmode = INVALID
		end if
		putter = hGetPutter( mode )
	end if
	if( astNewARG( proc, fexpr, , targetmode ) = NULL ) then
 		exit function
 	end if

 	'' byval mode as integer
	if( astNewARG( proc, astNewCONSTi( mode ) ) = NULL ) then
 		exit function
 	end if

 	'' byval putter as integer
 	if( astNewARG( proc, putter ) = NULL ) then
 		exit function
 	end if

 	'' byval func as function( src as uinteger, dest as uinteger ) as uinteger
 	if( funcexpr = NULL ) then
		funcexpr = astNewCONSTi( 0 )
 	end if
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

'':::::
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
 	if( x1expr = NULL ) then
		x1expr = astNewCONSTi( -32768 )
    end if
 	if( astNewARG( proc, x1expr ) = NULL ) then
 		exit function
 	end if

 	'' byval y1 as integer
 	if( y1expr = NULL ) then
		y1expr = astNewCONSTi( -32768 )
    end if
 	if( astNewARG( proc, y1expr ) = NULL ) then
 		exit function
 	end if

 	'' byval x2 as integer
 	if( x2expr = NULL ) then
		x2expr = astNewCONSTi( -32768 )
    end if
 	if( astNewARG( proc, x2expr ) = NULL ) then
 		exit function
 	end if

 	'' byval y2 as integer
 	if( y2expr = NULL ) then
		y2expr = astNewCONSTi( -32768 )
    end if
 	if( astNewARG( proc, y2expr ) = NULL ) then
 		exit function
 	end if

 	'' byval fillcolor as uinteger
 	if( fillexpr = NULL ) then
 		fillexpr = astNewCONSTi( 0, FB_DATATYPE_UINT )
 	end if
 	if( astNewARG( proc, fillexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval bordercolor as uinteger
 	if( bordexpr = NULL ) then
 		bordexpr = astNewCONSTi( 0, FB_DATATYPE_UINT )
 	end if
 	if( astNewARG( proc, bordexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval screenflag as integer
	if( astNewARG( proc, astNewCONSTi( screenflag ) ) = NULL ) then
 		exit function
 	end if

 	''
 	astAdd( proc )

	function = TRUE

end function

'':::::
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

 	''
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
    dim as integer defval = any, targetmode = any

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
		targetmode = FB_PARAMMODE_BYREF
		defval = 0
	else
		f = PROCLOOKUP( GFXPALETTE )
		targetmode = FB_PARAMMODE_BYVAL
		defval = -1
	end if

	proc = astNewCALL( f )

	'' byval index as long
	if( attexpr = NULL ) then
		attexpr = astNewCONSTi( -1 )
	end if
	if( astNewARG( proc, attexpr ) = NULL ) then
		exit function
	end if

	'' byval r as long|longint
 	if( rexpr = NULL ) then
		rexpr = astNewCONSTi( -1 )
	end if
	if( astNewARG( proc, rexpr ) = NULL ) then
		exit function
	end if

	'' byval g as long|longint
	if( gexpr = NULL ) then
		targetmode = FB_PARAMMODE_BYVAL
		gexpr = astNewCONSTi( defval )
	end if
	if( astNewARG( proc, gexpr, , targetmode ) = NULL ) then
		exit function
	end if

	'' byval b as long|longint
	if( bexpr = NULL ) then
		bexpr = astNewCONSTi( defval )
	end if
	if( astNewARG( proc, bexpr, , targetmode ) = NULL ) then
		exit function
	end if

	astAdd( proc )
	function = TRUE
end function

function rtlGfxPaletteUsing  _
	( _
		byval arrayexpr as ASTNODE ptr, _
		byval isptr as integer, _
		byval isget as integer _
	) as integer

    dim as ASTNODE ptr proc = any
    dim as FBSYMBOL ptr f = any
    dim as integer mode = any

	function = FALSE

	if( typeGetSize( astGetDataType( arrayexpr ) ) = 8 ) then
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

	'' byref array as long|longint
	mode = iif( isptr, FB_PARAMMODE_BYVAL, INVALID )
	if( astNewARG( proc, arrayexpr, , mode ) = NULL ) then
		exit function
	end if

	astAdd( proc )
	function = TRUE
end function

'':::::
function rtlGfxPut _
	( _
		byval target as ASTNODE ptr, _
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
		byval paramexpr as ASTNODE ptr, _
		byval coordtype as integer _
	) as integer

    dim as ASTNODE ptr proc = any
    dim as integer targetmode = any, argmode = any

    function = FALSE

    proc = astNewCALL( PROCLOOKUP( GFXPUT ) )

 	'' byref target as any
 	if( target = NULL ) then
		target = astNewCONSTi( 0 )
 		targetmode = FB_PARAMMODE_BYVAL
 	else
		if( targetisptr ) then
			targetmode = FB_PARAMMODE_BYVAL
		else
			targetmode = INVALID
		end if
	end if
	if( astNewARG( proc, target, , targetmode ) = NULL ) then
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

 	'' byref array as any
	if( isptr ) then
		argmode = FB_PARAMMODE_BYVAL
	else
		argmode = INVALID
	end if
	if( astNewARG( proc, arrayexpr, , argmode ) = NULL ) then
 		exit function
 	end if

 	'' area coordinates, if any
 	if( x1expr = NULL ) then
		x1expr = astNewCONSTi( &hFFFF0000 )
		x2expr = astNewCONSTi( &hFFFF0000 )
		y1expr = astNewCONSTi( &hFFFF0000 )
		y2expr = astNewCONSTi( &hFFFF0000 )
 	end if
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
	if( alphaexpr = NULL ) then
		alphaexpr = astNewCONSTi( -1 )
	end if
 	if( astNewARG( proc, alphaexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval func as function( src as uinteger, dest as uinteger ) as uinteger
 	if( funcexpr = NULL ) then
		funcexpr = astNewCONSTi( 0 )
 	end if
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

'':::::
function rtlGfxGet _
	( _
		byval target as ASTNODE ptr, _
		byval targetisptr as integer, _
		byval x1expr as ASTNODE ptr, _
		byval y1expr as ASTNODE ptr, _
		byval x2expr as ASTNODE ptr, _
		byval y2expr as ASTNODE ptr, _
		byval arrayexpr as ASTNODE ptr, _
		byval isptr as integer, _
		byval symbol as FBSYMBOL ptr, _
		byval coordtype as integer _
	) as integer

    dim as ASTNODE ptr proc = any, descexpr = any
    dim as integer targetmode = any, argmode = any

    function = FALSE

	'' use new header in -lang fb, otherwise old header
    proc = astNewCALL( iif( fbLangIsSet( FB_LANG_FB ), PROCLOOKUP( GFXGET ), PROCLOOKUP( GFXGETQB ) ) )

 	'' byref target as any
 	if( target = NULL ) then
		target = astNewCONSTi( 0 )
 		targetmode = FB_PARAMMODE_BYVAL
 	else
		if( targetisptr ) then
			targetmode = FB_PARAMMODE_BYVAL
		else
			targetmode = INVALID
		end if
	end if
	if( astNewARG( proc, target, , targetmode ) = NULL ) then
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

 	'' byref array as any
	if( isptr ) then
		argmode = FB_PARAMMODE_BYVAL
		descexpr = astNewCONSTi( NULL, typeAddrOf( FB_DATATYPE_VOID ) )
	else
		argmode = INVALID

		if( astIsFIELD( arrayexpr ) = FALSE ) then
			descexpr = astNewVAR( symbol )
		else
			'' side-effect?
			if( astIsClassOnTree( AST_NODECLASS_CALL, arrayexpr ) <> NULL ) then
				astAdd( astRemSideFx( arrayexpr ) )
			end if

			descexpr = astCloneTree( arrayexpr )
		end if
	end if

	if( astNewARG( proc, arrayexpr, , argmode ) = NULL ) then
 		exit function
 	end if

 	'' byval coordtype as integer
	if( astNewARG( proc, astNewCONSTi( coordtype ) ) = NULL ) then
 		exit function
 	end if

 	'' array() as any
	if( astNewARG( proc, descexpr, , argmode ) = NULL ) then
 		exit function
 	end if

	astAdd( rtlErrorCheck( proc ) )
	function = TRUE
end function

'':::::
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
 	if( dexpr = NULL ) then
		dexpr = astNewCONSTi( 8 )
 	end if
 	if( astNewARG( proc, dexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval depth as integer
 	if( pexpr = NULL ) then
		pexpr = astNewCONSTi( 0 )
 	end if
 	if( astNewARG( proc, pexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval flags as integer
 	if( fexpr = NULL ) then
		fexpr = astNewCONSTi( 0 )
 	end if
 	if( astNewARG( proc, fexpr ) = NULL ) then
 		exit function
 	end if

	'' byval refresh_rate as integer
	if( rexpr = NULL ) then
		rexpr = astNewCONSTi( 0 )
	end if
 	if( astNewARG( proc, rexpr ) = NULL ) then
 		exit function
 	end if

	astAdd( rtlErrorCheck( proc ) )
	function = TRUE
end function

'':::::
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
 	if( active = NULL ) then
		active = astNewCONSTi( -1 )
 	end if
 	if( astNewARG( proc, active ) = NULL ) then
 		exit function
 	end if

 	'' byval visible as integer
 	if( visible = NULL ) then
		visible = astNewCONSTi( -1 )
 	end if
 	if( astNewARG( proc, visible ) = NULL ) then
 		exit function
 	end if

	astAdd( rtlErrorCheck( proc ) )
	function = TRUE
end function

'':::::
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
	if( cexpr = NULL ) then
		cexpr = astNewCONSTi( 0 )
	end if
 	if( astNewARG( proc, cexpr ) = NULL ) then
 		exit function
 	end if

	'' byval d as integer
	if( dexpr = NULL ) then
		dexpr = astNewCONSTi( 0 )
	end if
 	if( astNewARG( proc, dexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval flags as integer
	if( astNewARG( proc, astNewCONSTi( flags ) ) = NULL ) then
 		exit function
 	end if

	function = proc

end function
