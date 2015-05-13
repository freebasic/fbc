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
		/' fb_GfxPset ( byref target as any, byval x as single, byval y as single, byval color as uinteger, _
						byval coordType as integer, byval ispreset as integer ) as void '/ _
		( _
			@FB_RTL_GFXPSET, NULL, _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
			6, _
			{ _
				( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_GfxPoint ( byref target as any, byval x as single, byval y as single ) as integer '/ _
		( _
			@FB_RTL_GFXPOINT, NULL, _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_GfxLine ( byref target as any, byval x1 as single = 0, byval y1 as single = 0, byval x2 as single = 0, byval y2 as single = 0, _
		              byval color as uinteger = DEFAULT_COLOR, byval line_type as integer = LINE_TYPE_LINE, _
		              byval style as uinteger = &hFFFF, byval coordType as integer = COORD_TYPE_AA ) as integer '/ _
		( _
			@FB_RTL_GFXLINE, NULL, _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
			9, _
			{ _
				( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_GfxEllipse ( byref target as any, byval x as single, byval y as single, byval radius as single, _
						   byval color as uinteger = DEFAULT_COLOR, byval aspect as single = 0.0, _
						   byval iniarc as single = 0.0, byval endarc as single = 6.283186, _
						   byval FillFlag as integer = 0, byval CoordType as integer = COORD_TYPE_A ) as integer '/ _
		( _
			@FB_RTL_GFXCIRCLE, NULL, _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
			10, _
			{ _
				( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_GfxPaint ( byref target as any, byval x as single, byval y as single, byval color as uinteger = DEFAULT_COLOR, _
								byval border_color as uinteger = DEFAULT_COLOR, pattern as string, _
								byval mode as integer = PAINT_TYPE_FILL, byval coord_type as integer = COORD_TYPE_A ) as integer '/ _
		( _
			@FB_RTL_GFXPAINT, NULL, _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
			8, _
			{ _
				( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_GfxDraw ( byref target as any, cmd as string ) '/ _
		( _
			@FB_RTL_GFXDRAW, NULL, _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_GfxDrawString ( byref target as any, byval x as single, byval y as single, _
		                    byval byval coord_type as integer = COORD_TYPE_A, text as string, _
		                    byval col as uinteger = DEFAULT_COLOR, byval font as any = NULL, byval mode as integer, _
		                    byval putter as any ptr, _
		                    byval func as function( src as uinteger, dest as uinteger ) as uinteger = 0, _
		                    byval param as any ptr = NULL ) '/ _
		( _
			@FB_RTL_GFXDRAWSTRING, NULL, _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_ERROR, _
			11, _
			{ _
				( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
				),_
				( _
 					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_GfxView ( byval x1 as integer = -32768, byval y1 as integer = -32768, _
		                byval x1 as integer = -32768, byval y1 as integer = -32768, _
					    byval fillcol as uinteger = DEFAULT_COLOR, byval bordercol as uinteger = DEFAULT_COLOR, _
		                byval screenFlag as integer = 0) as integer '/ _
		( _
			@FB_RTL_GFXVIEW, NULL, _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
			7, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_GfxWindow (byval x1 as single = 0, byval y1 as single = 0, byval x2 as single = 0, _
		 						byval y2 as single = 0, byval screenflag as integer = 0 ) as integer '/ _
		( _
			@FB_RTL_GFXWINDOW, NULL, _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
			5, _
			{ _
				( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, TRUE, 0 _
				), _
				( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, TRUE, 0 _
				), _
				( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, TRUE, 0 _
				), _
				( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, TRUE, 0 _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			) _
	 		} _
		), _
		/' fb_GfxPalette( byval attribute as integer = -1, byval r as integer = -1, _
						  byval g as integer = -1, byval b as integer = -1 ) as void '/ _
		( _
			@FB_RTL_GFXPALETTE, NULL, _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
			4, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, -1 _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, -1 _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, -1 _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, -1 _
	 			) _
	 		} _
		), _
		/' fb_GfxPaletteUsing ( array as integer ) as void '/ _
		( _
			@FB_RTL_GFXPALETTEUSING, NULL, _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_GfxPaletteGet( byval attribute as integer, byref r as integer, _
									byref g as integer, byref b as integer ) as void '/ _
		( _
			@FB_RTL_GFXPALETTEGET, NULL, _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
			4, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_GfxPaletteGetUsing ( array as integer ) as void '/ _
		( _
			@FB_RTL_GFXPALETTEGETUSING, NULL, _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_GfxPut ( byref target as any, byval x as single, byval y as single, byref array as any, _
					   byval x1 as integer = &hFFFF0000, byval y1 as integer = &hFFFF0000, _
					   byval x2 as integer = &hFFFF0000, byval y2 as integer = &hFFFF0000, _
					   byval coordType as integer, byval mode as integer, byval putter as any ptr, _
					   byval alpha as integer = -1, _
					   byval func as function( src as uinteger, dest as uinteger ) as uinteger = 0,
					   byval param as any ptr = NULL ) as integer '/ _
		( _
			@FB_RTL_GFXPUT, NULL, _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_ERROR, _
			14, _
			{ _
				( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
				),_
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_GfxGet ( byref target as any, byval x1 as single, byval y1 as single, byval x2 as single, byval y2 as single, _
					   byref array as any, byval coordType as integer, array() as any ) as integer '/ _
		( _
			@FB_RTL_GFXGET, NULL, _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_ERROR or FB_RTL_OPT_FBONLY, _
			8, _
			{ _
				( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE _
	 			) _
	 		} _
		), _
		/' fb_GfxGetQB ( byref target as any, byval x1 as single, byval y1 as single, byval x2 as single, byval y2 as single, _
					   byref array as any, byval coordType as integer, array() as any ) as integer '/ _
		( _
			@FB_RTL_GFXGETQB, NULL, _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_ERROR or FB_RTL_OPT_NOFB, _
			8, _
			{ _
				( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE _
	 			) _
	 		} _
		), _
		/' fb_GfxScreen ( byval mode as integer, byval depth as integer = 0, byval num_pages as integer = 0, _
		                byval flags as integer = 0, byval refresh_rate as integer = 0 ) as integer '/ _
		( _
			@FB_RTL_GFXSCREENSET, NULL, _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
			5, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			) _
	 		} _
		), _
		/' fb_GfxScreenQB ( byval mode as integer, byval active as integer = -1,
							byval visible as integer = -1 ) as integer '/ _
		( _
			@FB_RTL_GFXSCREENSETQB, NULL, _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, -1 _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, -1 _
	 			) _
	 		} _
		), _
		/' fb_GfxScreenRes ( byval w as integer, byval h as integer, byval depth as integer = 8, _
									byval num_pages as integer = 1, byval flags as integer = 0, byval refresh_rate as integer = 0 ) '/ _
		( _
			@"screenres", @FB_RTL_GFXSCREENRES, _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_ERROR or FB_RTL_OPT_NOQB, _
			6, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 8 _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 1 _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			) _
	 		} _
		), _
		/' fb_GfxBload ( filename as string, byval dest as any ptr = NULL, byval pal as any ptr = NULL ) as integer '/ _
		( _
			@"bload", @"fb_GfxBload", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_ERROR or FB_RTL_OPT_FBONLY, _
			3, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, TRUE, NULL _
	 			), _
				( _
 					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, TRUE, NULL _
	 			) _
	 		} _
		), _
		/' fb_GfxBloadQB ( filename as string, byval dest as any ptr = NULL, byval pal as any ptr = NULL ) as integer '/ _
		( _
			@"bload", @"fb_GfxBloadQB", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_ERROR or FB_RTL_OPT_NOFB, _
			3, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, TRUE, NULL _
	 			), _
				( _
 					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, TRUE, NULL _
	 			) _
	 		} _
		), _
		/' fb_GfxBsave( byref filename as string, byval src as any ptr, byval length as uinteger = 0, byval pal as any ptr ) as integer '/ _
		( _
			@"bsave", @"fb_GfxBsave", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_OVER or FB_RTL_OPT_ERROR, _
			4, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
				( _
 					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			) _
	 		} _
		), _
		/' fb_GfxBsave( byref filename as string, byval src as any ptr, byval length as uinteger = 0, byval pal as any ptr = NULL, byval bpp as integer ) as integer '/ _
		( _
			@"bsave", @"fb_GfxBsaveEx", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_OVER or FB_RTL_OPT_ERROR, _
			5, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
				( _
 					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_GfxFlip ( byval frompage as integer = -1, byval topage as integer = -1 ) as void '/ _
		( _
			@"flip", @"fb_GfxFlip", _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, -1 _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, -1 _
	 			) _
	 		} _
		), _
		( _
			@"screencopy", @"fb_GfxFlip", _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, -1 _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, -1 _
	 			) _
	 		} _
		), _
		/' fb_GfxCursor ( number as integer) as single '/ _
		( _
			@"pointcoord", @"fb_GfxCursor", _
			FB_DATATYPE_SINGLE, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_GfxPMap ( byval Coord as single, byval num as integer ) as single '/ _
		( _
			@"pmap", @"fb_GfxPMap", _
			FB_DATATYPE_SINGLE, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_Out( byval port as ushort, byval data as ubyte ) as void '/ _
		( _
			@"out", @"fb_Out", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			 @hPorts_cb, FB_RTL_OPT_ERROR, _
			2, _
			{ _
				( _
					FB_DATATYPE_USHORT, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_UBYTE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_In( byval port as ushort ) as integer '/ _
		( _
			@"inp", @"fb_In", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			@hPorts_cb, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_USHORT, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_Wait ( byval port as ushort, byval and_mask as integer, byval xor_mask as integer = 0 ) '/ _
		( _
			@"wait", @"fb_Wait", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			@hPorts_cb, FB_RTL_OPT_ERROR, _
			3, _
			{ _
				( _
					FB_DATATYPE_USHORT, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			) _
	 		} _
		), _
		/' fb_GfxWaitVSync ( void ) as integer '/ _
		( _
			@"screensync", @"fb_GfxWaitVSync", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			0 _
		), _
		/' fb_GfxPageSet cdecl ( byval work_page as integer = -1, byval visible_page as integer = -1 ) as void '/ _
		( _
			@"screenset", @"fb_GfxPageSet", _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, -1 _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, -1 _
	 			) _
	 		} _
		), _
		/' fb_GfxLock ( ) as void '/ _
		( _
			@"screenlock", @"fb_GfxLock", _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			0 _
		), _
		/' fb_GfxUnlock ( ) as void '/ _
		( _
			@"screenunlock", @"fb_GfxUnlock", _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, -1 _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, -1 _
	 			) _
	 		} _
		), _
		/' fb_GfxScreenPtr ( ) as any ptr '/ _
		( _
			@"screenptr", @"fb_GfxScreenPtr", _
			typeAddrOf( FB_DATATYPE_VOID ), FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			0 _
		), _
		/' fb_GfxSetWindowTitle ( title as string ) as void '/ _
		( _
			@"windowtitle", @"fb_GfxSetWindowTitle", _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_Multikey ( byval scancode as integer ) as integer '/ _
		( _
			@"multikey", @"fb_Multikey", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		@rtlMultinput_cb, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_GfxGetMouse ( byref x as integer, byref y as integer, byref z as integer, byref buttons as integer, byref clip as integer ) as integer '/ _
		( _
			@"getmouse", @"fb_GetMouse", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			@rtlMultinput_cb, FB_RTL_OPT_NOQB, _
			5, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, FALSE, 0, TRUE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, FALSE, 0, TRUE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, TRUE, 0, TRUE _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, TRUE, 0, TRUE _
	 			), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, TRUE, 0, TRUE _
				) _
	 		} _
		), _
		/' fb_GfxSetMouse ( byval x as integer = -1, byval y as integer = -1, byval cursor as integer = -1, byval clip as integer = -1 ) as integer '/ _
		( _
			@"setmouse", @"fb_SetMouse", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		@rtlMultinput_cb, FB_RTL_OPT_NOQB, _
			4, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, -1 _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, -1 _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, -1 _
	 			), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, -1 _
				) _
	 		} _
		), _
		/' fb_GfxGetJoystick ( byval id as integer, byref buttons as integer = 0, _
							   byref a1 as single = 0, byref a2 as single = 0, byref a3 as single = 0, _
							   byref a4 as single = 0, byref a5 as single = 0, byref a6 as single = 0, _
							   byref a7 as single = 0, byref a8 as single = 0 _
							    ) as integer '/ _
		( _
			@"getjoystick", @"fb_GfxGetJoystick", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			10, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE, 0, TRUE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, TRUE, 0, TRUE _
				), _
				( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, TRUE, 0, TRUE _
				), _
				( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, TRUE, 0, TRUE _
				), _
				( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, TRUE, 0, TRUE _
				), _
				( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, TRUE, 0, TRUE _
				), _
				( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, TRUE, 0, TRUE _
				), _
				( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, TRUE, 0, TRUE _
	 			), _
				( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, TRUE, 0, TRUE _
				), _
				( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, TRUE, 0, TRUE _
	 			) _
	 		} _
		), _
		/' fb_GfxStickQB ( byval arg as integer ) as integer '/ _
		( _
			@"stick", @"fb_GfxStickQB", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_QBONLY, _
			1, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE, 0 _
				) _
	 		} _
		), _
		/' fb_GfxStrigQB ( byval arg as integer ) as integer '/ _
		( _
			@"strig", @"fb_GfxStrigQB", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_QBONLY, _
			1, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE, 0 _
				) _
	 		} _
		), _
		/' fb_GfxScreenInfo ( byref w as integer, byref h as integer, byref depth as integer, _
							  byref bpp as integer, byref pitch as integer, byref driver_name as string ) as void '/ _
		( _
			@"screeninfo", @"fb_GfxScreenInfo", _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			7, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, TRUE, 0 _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, TRUE, 0 _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, TRUE, 0 _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, TRUE, 0 _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, TRUE, 0 _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, TRUE, 0 _
				), _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, TRUE, NULL _
	 			) _
	 		} _
		), _
		/' fb_GfxScreenList ( byval depth as integer ) as integer '/ _
		( _
			@"screenlist", @"fb_GfxScreenList", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			) _
	 		} _
		), _
		/' fb_GfxImageCreate ( byval width as integer, byval height as integer, _
							   byval color as uinteger = DEFAULT_COLOR, byval depth as integer = 0 ) as any ptr '/ _
		( _
			@FB_RTL_GFXIMAGECREATE, NULL, _
			typeAddrOf( FB_DATATYPE_VOID ), FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_FBONLY, _
			5, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE,0 _
	 			), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE,0 _
	 			), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE,0 _
	 			) _
	 		} _
		), _
		/' fb_GfxImageCreateQB ( byval width as integer, byval height as integer, _
							   byval color as uinteger = DEFAULT_COLOR, byval depth as integer = 0 ) as any ptr '/ _
		( _
			@FB_RTL_GFXIMAGECREATEQB, NULL, _
			typeAddrOf( FB_DATATYPE_VOID ), FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			5, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE,0 _
	 			), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE,0 _
	 			), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE,0 _
	 			) _
	 		} _
		), _
		/' fb_GfxImageDestroy ( byval image as any ptr ) as void '/ _
		( _
			@"imagedestroy", @"fb_GfxImageDestroy", _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_GfxImageInfo( byval img as any ptr, byref width as integer = 0, _
							byref height as integer = 0, byref bpp as integer = 0, _
							byref pitch as integer = 0, byref pixdata as any ptr = 0, _
							byref imgsize as integer = 0 ) as integer '/ _
		( _
			@"imageinfo", @"fb_GfxImageInfo", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			7, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, TRUE, 0 _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, TRUE, 0 _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, TRUE, 0 _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, TRUE, 0 _
				), _
				( _
					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYREF, TRUE, 0 _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, TRUE, 0 _
				) _
			} _
		), _
		/' fb_GfxImageConvertRow( byval src as any ptr, byval src_bpp as integer, _
								  byval dst as any ptr, byval dst_bpp as integer, _
								  byval width as integer, byval isrgb as integer = 1 ) as void '/ _
		( _
			@"imageconvertrow", @"fb_GfxImageConvertRow", _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			6, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 1 _
	 			) _
	 		} _
	 	), _
		/' fb_GfxEvent ( byval e as any ptr = NULL ) as integer '/ _
		( _
			@"screenevent", @"fb_GfxEvent", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, TRUE, 0, TRUE _
	 			) _
	 		} _
		), _
		/' fb_GfxControl_s ( byval what as integer, byref param1 as string ) as void '/ _
		( _
			@"screencontrol", @"fb_GfxControl_s", _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF _
	 			) _
	 		} _
		), _
		/' fb_GfxControl_i ( byval what as integer, byref param1 as integer, byref param2 as integer, _
		                                            byref param3 as integer, byref param4 as integer ) as void '/ _
		( _
			@"screencontrol", @"fb_GfxControl_i", _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			5, _
			{ _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, TRUE, &h80000000 _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, TRUE, &h80000000 _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, TRUE, &h80000000 _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, TRUE, &h80000000 _
				) _
	 		} _
		), _
		/' fb_GfxGetGLProcAddress ( byval proc as zstring ptr ) as any ptr '/ _
		( _
			@"screenglproc", @"fb_GfxGetGLProcAddress", _
			typeAddrOf( FB_DATATYPE_VOID ), FB_USE_FUNCMODE_FBCALL, _
	 		@hGfxlib_cb, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_CHAR ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
        /' fb_hPutTrans cdecl ( byval src as ubyte ptr, byval dest as ubyte ptr, byval w as integer, byval h as integer, _
                                byval src_pitch as integer, byval dest_pitch as integer, byval alpha as integer, _
                                byval blender as any ptr, byval param as any ptr ) as void '/ _
		( _
			@FB_RTL_GFXPUTTRANS, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
	 		9, _
	 		{ _
	 			( _
	 				typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
        /' fb_hPutPSet cdecl ( byval src as ubyte ptr, byval dest as ubyte ptr, byval w as integer, byval h as integer, _
                               byval src_pitch as integer, byval dest_pitch as integer, byval alpha as integer, _
                               byval blender as any ptr, byval param as any ptr ) as void '/ _
		( _
			@FB_RTL_GFXPUTPSET, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
	 		9, _
	 		{ _
	 			( _
	 				typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
        /' fb_hPutPReset cdecl ( byval src as ubyte ptr, byval dest as ubyte ptr, byval w as integer, byval h as integer, _
                                 byval src_pitch as integer, byval dest_pitch as integer, byval alpha as integer, _
                                 byval blender as any ptr, byval param as any ptr ) as void '/ _
		( _
			@FB_RTL_GFXPUTPRESET, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
	 		9, _
	 		{ _
	 			( _
	 				typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
        /' fb_hPutAnd cdecl ( byval src as ubyte ptr, byval dest as ubyte ptr, byval w as integer, byval h as integer, _
                              byval src_pitch as integer, byval dest_pitch as integer, byval alpha as integer, _
                              byval blender as any ptr, byval param as any ptr ) as void '/ _
		( _
			@FB_RTL_GFXPUTAND, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
	 		9, _
	 		{ _
	 			( _
	 				typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
        /' fb_hPutOr cdecl ( byval src as ubyte ptr, byval dest as ubyte ptr, byval w as integer, byval h as integer, _
                             byval src_pitch as integer, byval dest_pitch as integer, byval alpha as integer, _
                             byval blender as any ptr, byval param as any ptr ) as void '/ _
		( _
			@FB_RTL_GFXPUTOR, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
	 		9, _
	 		{ _
	 			( _
	 				typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
        /' fb_hPutXor cdecl ( byval src as ubyte ptr, byval dest as ubyte ptr, byval w as integer, byval h as integer, _
                              byval src_pitch as integer, byval dest_pitch as integer, byval alpha as integer, _
                              byval blender as any ptr, byval param as any ptr ) as void '/ _
		( _
			@FB_RTL_GFXPUTXOR, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
	 		9, _
	 		{ _
	 			( _
	 				typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
        /' fb_hPutAlpha cdecl ( byval src as ubyte ptr, byval dest as ubyte ptr, byval w as integer, byval h as integer, _
                                byval src_pitch as integer, byval dest_pitch as integer, byval alpha as integer, _
                                byval blender as any ptr, byval param as any ptr ) as void '/ _
		( _
			@FB_RTL_GFXPUTALPHA, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
	 		9, _
	 		{ _
	 			( _
	 				typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
        /' fb_hPutBlend cdecl ( byval src as ubyte ptr, byval dest as ubyte ptr, byval w as integer, byval h as integer, _
                                byval src_pitch as integer, byval dest_pitch as integer, byval alpha as integer, _
                                byval blender as any ptr, byval param as any ptr ) as void '/ _
		( _
			@FB_RTL_GFXPUTBLEND, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
	 		9, _
	 		{ _
	 			( _
	 				typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
        /' fb_hPutAdd cdecl ( byval src as ubyte ptr, byval dest as ubyte ptr, byval w as integer, byval h as integer, _
                              byval src_pitch as integer, byval dest_pitch as integer, byval alpha as integer, _
                              byval blender as any ptr, byval param as any ptr ) as void '/ _
		( _
			@FB_RTL_GFXPUTADD, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
	 		9, _
	 		{ _
	 			( _
	 				typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
        /' fb_hPutCustom cdecl ( byval src as ubyte ptr, byval dest as ubyte ptr, byval w as integer, byval h as integer, _
                                 byval src_pitch as integer, byval dest_pitch as integer, byval alpha as integer, _
                                 byval blender as any ptr, byval param as any ptr ) as void '/ _
		( _
			@FB_RTL_GFXPUTCUSTOM, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
	 		@hGfxlib_cb, FB_RTL_OPT_NONE, _
	 		9, _
	 		{ _
	 			( _
	 				typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
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

	function = rtlErrorCheck( proc )

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

'':::::
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
    	f = PROCLOOKUP( GFXPALETTEGET )
    else
    	f = PROCLOOKUP( GFXPALETTE )
    end if
	proc = astNewCALL( f )

	if( isget ) then
		targetmode = FB_PARAMMODE_BYREF
		defval = 0
	else
		targetmode = FB_PARAMMODE_BYVAL
		defval = -1
	end if

 	'' byval attr as integer
 	if( attexpr = NULL ) then
		attexpr = astNewCONSTi( -1 )
    end if
 	if( astNewARG( proc, attexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval r as integer
 	if( rexpr = NULL ) then
		rexpr = astNewCONSTi( -1 )
    end if
 	if( astNewARG( proc, rexpr ) = NULL ) then
 		exit function
 	end if

 	'' byval g as integer
 	if( gexpr = NULL ) then
 		targetmode = FB_PARAMMODE_BYVAL
		gexpr = astNewCONSTi( defval )
    end if
	if( astNewARG( proc, gexpr, , targetmode ) = NULL ) then
 		exit function
 	end if

 	'' byval b as integer
 	if( bexpr = NULL ) then
		bexpr = astNewCONSTi( defval )
    end if
	if( astNewARG( proc, bexpr, , targetmode ) = NULL ) then
 		exit function
 	end if

 	''
 	astAdd( proc )

	function = TRUE

end function

'':::::
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

    if( isget ) then
    	f = PROCLOOKUP( GFXPALETTEGETUSING )
    else
    	f = PROCLOOKUP( GFXPALETTEUSING )
    end if
	proc = astNewCALL( f )

 	'' byref array as integer
 	mode = iif( isptr, FB_PARAMMODE_BYVAL, INVALID )
	if( astNewARG( proc, arrayexpr, , mode ) = NULL ) then
 		exit function
 	end if

 	''
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

	function = rtlErrorCheck( proc )

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

	function = rtlErrorCheck( proc )

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

	function = rtlErrorCheck( proc )

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

	function = rtlErrorCheck( proc )

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
