''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2010 The FreeBASIC development team.
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


'' intrinsic runtime lib math functions (FIX, ACOS, LOG, ...)
''
'' chng: oct/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ast.bi"
#include once "inc\rtl.bi"

	dim shared as FB_RTL_PROCDEF funcdata( 0 to 63 ) = _
	{ _
		/' fb_LongintDIV cdecl ( byval x as longint, byval y as longint ) as longint '/ _
		( _
			@FB_RTL_LONGINTDIV, NULL, _
			FB_DATATYPE_LONGINT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
	 		{ _
	 			( _
					FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_ULongintDIV cdecl ( byval x as ulongint, byval y as ulongint ) as ulongint '/ _
		( _
			@FB_RTL_ULONGINTDIV, NULL, _
			FB_DATATYPE_ULONGINT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
	 		{ _
	 			( _
					FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_LongintMOD cdecl ( byval x as longint, byval y as longint ) as longint '/ _
		( _
			@FB_RTL_LONGINTMOD, NULL, _
			FB_DATATYPE_LONGINT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
	 		{ _
	 			( _
					FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_ULongintMOD cdecl ( byval x as ulongint, byval y as ulongint ) as ulongint '/ _
		( _
			@FB_RTL_ULONGINTMOD, NULL, _
			FB_DATATYPE_ULONGINT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
	 		{ _
	 			( _
					FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_Dbl2ULongint cdecl ( byval x as double ) as ulongint '/ _
		( _
			@FB_RTL_DBL2ULONGINT, NULL, _
			FB_DATATYPE_ULONGINT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_Pow CDECL ( byval x as double, byval y as double ) as double '/ _
		( _
			@FB_RTL_POW, @"pow", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
	 		{ _
	 			( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' randomize ( byval seed as double = -1.0, byval algorithm as integer = 0 ) as void '/ _
		( _
			@"randomize", @"fb_Randomize", _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
	 		{ _
	 			( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, TRUE, -1.0 _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			) _
	 		} _
		), _
		/' rnd ( byval n as single ) as double '/ _
		( _
			@"rnd", @"fb_Rnd", _
			FB_DATATYPE_DOUBLE, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, TRUE, 1.0 _
	 			) _
	 		} _
	 	), _
		/' sinf CDECL overload ( byval x as single ) as single '/ _
		( _
			@FB_RTL_SIN, @"sinf", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' sinl CDECL overload ( byval x as double ) as double '/ _
		( _
			@FB_RTL_SIN, @"sinl", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' asinf CDECL overload ( byval x as single ) as single '/ _
		( _
			@FB_RTL_ASIN, @"asinf", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' asinl CDECL overload ( byval x as double ) as double '/ _
		( _
			@FB_RTL_ASIN, @"asinl", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' cosf CDECL overload ( byval x as single ) as single '/ _
		( _
			@FB_RTL_COS, @"cosf", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' cosl CDECL overload ( byval x as double ) as double '/ _
		( _
			@FB_RTL_COS, @"cosl", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' acosf CDECL overload ( byval x as single ) as single '/ _
		( _
			@FB_RTL_ACOS, @"acosf", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' acosl CDECL overload ( byval x as double ) as double '/ _
		( _
			@FB_RTL_ACOS, @"acosl", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' tanf CDECL overload ( byval x as single ) as single '/ _
		( _
			@FB_RTL_TAN, @"tanf", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' tanl CDECL overload ( byval x as double ) as double '/ _
		( _
			@FB_RTL_TAN, @"tanl", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' atanf CDECL overload ( byval x as single ) as single '/ _
		( _
			@FB_RTL_ATAN, @"atanf", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' atanl CDECL overload ( byval x as double ) as double '/ _
		( _
			@FB_RTL_ATAN, @"atanl", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' sqrtf CDECL overload ( byval x as single ) as single '/ _
		( _
			@FB_RTL_sqrt, @"sqrtf", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' sqrtl CDECL overload ( byval x as double ) as double '/ _
		( _
			@FB_RTL_sqrt, @"sqrtl", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' logf CDECL overload ( byval x as single ) as single '/ _
		( _
			@FB_RTL_log, @"logf", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' logl CDECL overload ( byval x as double ) as double '/ _
		( _
			@FB_RTL_log, @"logl", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' expf CDECL overload ( byval x as single ) as single '/ _
		( _
			@FB_RTL_exp, @"expf", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' expl CDECL overload ( byval x as double ) as double '/ _
		( _
			@FB_RTL_exp, @"expl", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' floorf CDECL overload ( byval x as single ) as single '/ _
		( _
			@FB_RTL_floor, @"floorf", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' floorl CDECL overload ( byval x as double ) as double '/ _
		( _
			@FB_RTL_floor, @"floorl", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' abs CDECL overload ( byval x as integer ) as integer '/ _
		( _
			@FB_RTL_abs, @"abs", _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' abs CDECL overload ( byval x as longint ) as longint '/ _
		( _
			@FB_RTL_abs, @"abs", _
			FB_DATATYPE_LONGINT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN or FB_RTL_OPT_DUPDECL, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fabsf CDECL overload ( byval x as single ) as single '/ _
		( _
			@FB_RTL_abs, @"fabsf", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fabsl CDECL overload ( byval x as double ) as double '/ _
		( _
			@FB_RTL_abs, @"fabsl", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' sgn overload ( byval x as byte ) as integer '/ _
		( _
			@FB_RTL_sgn, @"fb_SGNb", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_BYTE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' sgn overload ( byval x as short ) as integer '/ _
		( _
			@FB_RTL_sgn, @"fb_SGNs", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_SHORT, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' sgn overload ( byval x as integer ) as integer '/ _
		( _
			@FB_RTL_sgn, @"fb_SGNi", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' sgn overload ( byval x as longint ) as integer '/ _
		( _
			@FB_RTL_sgn, @"fb_SGNl", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' sgn overload ( byval x as single ) as integer '/ _
		( _
			@FB_RTL_sgn, @"fb_SGNSingle", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' sgn overload ( byval x as double ) as integer '/ _
		( _
			@FB_RTL_sgn, @"fb_SGNDouble", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fix overload ( byval x as single ) as single '/ _
		( _
			@FB_RTL_fix, @"fb_FIXSingle", _
			FB_DATATYPE_SINGLE, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fix overload ( byval x as double ) as double '/ _
		( _
			@FB_RTL_fix, @"fb_FIXDouble", _
			FB_DATATYPE_DOUBLE, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' frac overload ( byval x as single ) as single '/ _
		( _
			@FB_RTL_frac, @"fb_FRACf", _
			FB_DATATYPE_SINGLE, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' frac overload ( byval x as double ) as double '/ _
		( _
			@FB_RTL_frac, @"fb_FRACd", _
			FB_DATATYPE_DOUBLE, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' atan2f CDECL overload ( byval x as single, byval y as single ) as single '/ _
		( _
			@FB_RTL_ATAN2, @"atan2f", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			2, _
	 		{ _
	 			( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' atan2l CDECL overload ( byval x as double, byval y as double ) as double '/ _
		( _
			@FB_RTL_ATAN2, @"atan2l", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			2, _
	 		{ _
	 			( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' ftosl cdecl ( byval x as single ) as long '/ _
		( _
			@FB_RTL_FTOSL, @"fb_ftosl", _
			FB_DATATYPE_LONGINT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_DUPDECL, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' dtosl cdecl ( byval x as double ) as long '/ _
		( _
			@FB_RTL_DTOSL, @"fb_dtosl", _
			FB_DATATYPE_LONGINT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_DUPDECL, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' ftosi cdecl ( byval x as single ) as integer '/ _
		( _
			@FB_RTL_FTOSI, @"fb_ftosi", _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_DUPDECL, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' dtosi cdecl ( byval x as double ) as integer '/ _
		( _
			@FB_RTL_DTOSI, @"fb_dtosi", _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_DUPDECL, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' ftoss cdecl ( byval x as single ) as short '/ _
		( _
			@FB_RTL_FTOSS, @"fb_ftoss", _
			FB_DATATYPE_SHORT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_DUPDECL, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' dtoss cdecl ( byval x as double ) as short '/ _
		( _
			@FB_RTL_DTOSS, @"fb_dtoss", _
			FB_DATATYPE_SHORT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_DUPDECL, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' ftosb cdecl ( byval x as single ) as byte '/ _
		( _
			@FB_RTL_FTOSB, @"fb_ftosb", _
			FB_DATATYPE_BYTE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_DUPDECL, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' dtosb cdecl ( byval x as double ) as byte '/ _
		( _
			@FB_RTL_DTOSB, @"fb_dtosb", _
			FB_DATATYPE_BYTE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_DUPDECL, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' ftoul cdecl ( byval x as single ) as long '/ _
		( _
			@FB_RTL_FTOUL, @"fb_ftoul", _
			FB_DATATYPE_ULONGINT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_DUPDECL, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' dtoul cdecl ( byval x as double ) as long '/ _
		( _
			@FB_RTL_DTOUL, @"fb_dtoul", _
			FB_DATATYPE_ULONGINT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_DUPDECL, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' ftoui cdecl ( byval x as single ) as integer '/ _
		( _
			@FB_RTL_FTOUI, @"fb_ftoui", _
			FB_DATATYPE_UINT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_DUPDECL, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' dtoui cdecl ( byval x as double ) as integer '/ _
		( _
			@FB_RTL_DTOUI, @"fb_dtoui", _
			FB_DATATYPE_UINT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_DUPDECL, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' ftous cdecl ( byval x as single ) as short '/ _
		( _
			@FB_RTL_FTOUS, @"fb_ftous", _
			FB_DATATYPE_USHORT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_DUPDECL, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' dtous cdecl ( byval x as double ) as short '/ _
		( _
			@FB_RTL_DTOUS, @"fb_dtous", _
			FB_DATATYPE_USHORT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_DUPDECL, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' ftoub cdecl ( byval x as single ) as byte '/ _
		( _
			@FB_RTL_FTOUB, @"fb_ftoub", _
			FB_DATATYPE_UBYTE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_DUPDECL, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' dtoub cdecl ( byval x as double ) as byte '/ _
		( _
			@FB_RTL_DTOUB, @"fb_dtoub", _
			FB_DATATYPE_UBYTE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_DUPDECL, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
	 	/' EOL '/ _
	 	( _
	 		NULL _
	 	) _
	 }



'':::::
sub rtlMathModInit( )

	rtlAddIntrinsicProcs( @funcdata(0) )

end sub

'':::::
sub rtlMathModEnd( )

	'' procs will be deleted when symbEnd is called

end sub

'':::::
function rtlMathPow	_
	( _
		byval xexpr as ASTNODE ptr, _
		byval yexpr as ASTNODE ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any

	function = NULL

	''
    proc = astNewCALL( PROCLOOKUP( POW ) )

    '' byval x as double
    if( astNewARG( proc, xexpr ) = NULL ) then
 		exit function
 	end if

    '' byval y as double
    if( astNewARG( proc, yexpr ) = NULL ) then
 		exit function
 	end if

    ''
    function = proc

end function

'':::::
function rtlMathLen _
	( _
		byval expr as ASTNODE ptr, _
		byval islen as integer = TRUE _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any
    dim as integer dtype = any, lgt = any
    dim as FBSYMBOL ptr litsym = any

	function = NULL

	dtype = astGetDataType( expr )

	'' LEN()?
	if( islen ) then
		select case as const dtype
		'' dyn-len or zstring?
		case FB_DATATYPE_STRING, FB_DATATYPE_CHAR

    		'' literal? evaluate at compile-time..
    		if( dtype = FB_DATATYPE_CHAR ) then
    			litsym = astGetStrLitSymbol( expr )
    			if( litsym <> NULL ) then
    				lgt = symbGetStrLen( litsym ) - 1
    			end if
    		else
    			litsym = NULL
    		end if

    		if( litsym = NULL ) then
    			proc = astNewCALL( PROCLOOKUP( STRLEN ) )

    			'' always calc len before pushing the param
    			lgt = rtlCalcStrLen( expr, dtype )

    			'' str as any
    			if( astNewARG( proc, expr, FB_DATATYPE_STRING ) = NULL ) then
 					exit function
 				end if

    			'' byval strlen as integer
				if( astNewARG( proc, _
							   astNewCONSTi( lgt, FB_DATATYPE_INTEGER ), _
							   FB_DATATYPE_INTEGER ) = NULL ) then
 					exit function
 				end if

				return proc
			end if

		'' wstring?
		case FB_DATATYPE_WCHAR

    		'' literal? evaluate at compile-time..
    		litsym = astGetStrLitSymbol( expr )
    		if( litsym <> NULL ) then
    			lgt = symbGetWstrLen( litsym ) - 1

    		else
    			proc = astNewCALL( PROCLOOKUP( WSTRLEN ) )

    			'' byval str as wchar ptr
    			if( astNewARG( proc, expr ) = NULL ) then
 					exit function
 				end if

 				return proc
 			end if

		'' anything else..
		case else
type_size:
			lgt = rtlCalcExprLen( expr, FALSE )

			'' handle fix-len strings (evaluated at compile-time)
			if( dtype = FB_DATATYPE_FIXSTR ) then
				if( lgt > 0 ) then
					lgt -= 1						'' less the null-term
				end if
			end if

		end select

	'' SIZEOF()
	else
		lgt = rtlCalcExprLen( expr, FALSE )

		'' wstring? multiply by sizeof(wchar) to get the
		'' number of bytes, not of chars
		if( dtype = FB_DATATYPE_WCHAR ) then
			lgt *= symbGetDataSize( FB_DATATYPE_WCHAR )
		end if

	end if

	''
	astDelTree( expr )

	function = astNewCONSTi( lgt, FB_DATATYPE_INTEGER )

end function

'':::::
function rtlMathLongintDIV _
	( _
		byval dtype as integer, _
		byval lexpr as ASTNODE ptr, _
		byval ldtype as integer, _
		byval rexpr as ASTNODE ptr, _
		byval rdtype as integer _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any
    dim as FBSYMBOL ptr f = any

	function = NULL

	if( typeGet( dtype ) = FB_DATATYPE_LONGINT ) then
		f = PROCLOOKUP( LONGINTDIV )
	else
		f = PROCLOOKUP( ULONGINTDIV )
	end if

    proc = astNewCALL( f )

    ''
    if( astNewARG( proc, lexpr, ldtype ) = NULL ) then
    	exit function
    end if

    if( astNewARG( proc, rexpr, rdtype ) = NULL ) then
    	exit function
    end if

    function = proc

end function

'':::::
function rtlMathLongintMOD _
	( _
		byval dtype as integer, _
		byval lexpr as ASTNODE ptr, _
		byval ldtype as integer, _
		byval rexpr as ASTNODE ptr, _
		byval rdtype as integer _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any
    dim as FBSYMBOL ptr f = any

	function = NULL

	if( typeGet( dtype ) = FB_DATATYPE_LONGINT ) then
		f = PROCLOOKUP( LONGINTMOD )
	else
		f = PROCLOOKUP( ULONGINTMOD )
	end if

    proc = astNewCALL( f )

    ''
    if( astNewARG( proc, lexpr, ldtype ) = NULL ) then
    	exit function
    end if

    if( astNewARG( proc, rexpr, rdtype ) = NULL ) then
    	exit function
    end if

    function = proc

end function

'':::::
function rtlMathFp2ULongint _
	( _
		byval expr as ASTNODE ptr, _
		byval dtype as integer _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any

	function = NULL

    proc = astNewCALL( PROCLOOKUP( DBL2ULONGINT)  )

    ''
    if( astNewARG( proc, expr, dtype ) = NULL ) then
    	exit function
    end if

    function = proc

end function


'':::::
function rtlMathUop _
	( _
		byval op as integer, _
		byval expr as ASTNODE ptr _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr sym = any

	function = NULL

	select case as const op
	case AST_OP_SGN
		sym = PROCLOOKUP( SGN )

	case AST_OP_ABS
		sym = PROCLOOKUP( ABS )

	case AST_OP_FIX
		sym = PROCLOOKUP( FIX )

	case AST_OP_FRAC
		sym = PROCLOOKUP( FRAC )

	case AST_OP_SIN
    	sym = PROCLOOKUP( SIN )

	case AST_OP_ASIN
    	sym = PROCLOOKUP( ASIN )

	case AST_OP_COS
    	sym = PROCLOOKUP( COS )

	case AST_OP_ACOS
    	sym = PROCLOOKUP( ACOS )

	case AST_OP_TAN
    	sym = PROCLOOKUP( TAN )

	case AST_OP_ATAN
    	sym = PROCLOOKUP( ATAN )

	case AST_OP_SQRT
    	sym = PROCLOOKUP( SQRT )

	case AST_OP_LOG
    	sym = PROCLOOKUP( LOG )

	case AST_OP_EXP
    	sym = PROCLOOKUP( EXP )

	case AST_OP_FLOOR
    	sym = PROCLOOKUP( FLOOR )

	case else
		exit function

	end select

	function = rtlOvlProcCall( sym, expr )

end function

'':::::
function rtlMathBop _
	( _
		byval op as integer, _
		byval lexpr as ASTNODE ptr, _
		byval rexpr as ASTNODE ptr _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr sym = any

	function = NULL

	select case as const op
	case AST_OP_ATAN2
		sym = PROCLOOKUP( ATAN2 )

	case else
		exit function

	end select

	function = rtlOvlProcCall( sym, lexpr, rexpr )

end function

'':::::
function rtlMathFTOI _
	( _
		byval expr as ASTNODE ptr, _
		byval to_dtype as integer _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr sym = any

	function = NULL

	var from_dtype = astGetDataType( expr )

	select case as const typeGet( to_dtype )
	case FB_DATATYPE_BYTE
		if( from_dtype = FB_DATATYPE_SINGLE ) then
			sym = PROCLOOKUP( FTOSB )
		else
			sym = PROCLOOKUP( DTOSB )
		end if

	case FB_DATATYPE_UBYTE
		if( from_dtype = FB_DATATYPE_SINGLE ) then
			sym = PROCLOOKUP( FTOUB )
		else
			sym = PROCLOOKUP( DTOUB )
		end if

	case FB_DATATYPE_SHORT
		if( from_dtype = FB_DATATYPE_SINGLE ) then
			sym = PROCLOOKUP( FTOSS )
		else
			sym = PROCLOOKUP( DTOSS )
		end if

	case FB_DATATYPE_USHORT
		if( from_dtype = FB_DATATYPE_SINGLE ) then
			sym = PROCLOOKUP( FTOUS )
		else
			sym = PROCLOOKUP( DTOUS )
		end if

	case FB_DATATYPE_INTEGER
		if( from_dtype = FB_DATATYPE_SINGLE ) then
			sym = PROCLOOKUP( FTOSI )
		else
			sym = PROCLOOKUP( DTOSI )
		end if

	case FB_DATATYPE_UINT
		if( from_dtype = FB_DATATYPE_SINGLE ) then
			sym = PROCLOOKUP( FTOUI )
		else
			sym = PROCLOOKUP( DTOUI )
		end if

	case FB_DATATYPE_LONGINT
		if( from_dtype = FB_DATATYPE_SINGLE ) then
			sym = PROCLOOKUP( FTOSL )
		else
			sym = PROCLOOKUP( DTOSL )
		end if

	case FB_DATATYPE_ULONGINT
		if( from_dtype = FB_DATATYPE_SINGLE ) then
			sym = PROCLOOKUP( FTOUL )
		else
			sym = PROCLOOKUP( DTOUL )
		end if

	case else
		exit function

	end select

    var proc = astNewCALL( sym )

    if( astNewARG( proc, expr ) = NULL ) then
    	exit function
    end if

    function = proc

end function

