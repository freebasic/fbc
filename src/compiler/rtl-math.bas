'' intrinsic runtime lib math functions (FIX, ACOS, LOG, ...)
''
'' chng: oct/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "ast.bi"
#include once "rtl.bi"

declare function hRndCallback( byval sym as FBSYMBOL ptr ) as integer

	dim shared as FB_RTL_PROCDEF funcdata( 0 to ... ) = _
	{ _
		/' fb_LongintDIV cdecl ( byval x as longint, byval y as longint ) as longint '/ _
		( _
			@FB_RTL_LONGINTDIV, @"__divdi3", _
			FB_DATATYPE_LONGINT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
	 		{ _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' fb_ULongintDIV cdecl ( byval x as ulongint, byval y as ulongint ) as ulongint '/ _
		( _
			@FB_RTL_ULONGINTDIV, @"__udivdi3", _
			FB_DATATYPE_ULONGINT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
	 		{ _
				( FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' fb_LongintMOD cdecl ( byval x as longint, byval y as longint ) as longint '/ _
		( _
			@FB_RTL_LONGINTMOD, @"__moddi3", _
			FB_DATATYPE_LONGINT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
	 		{ _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' fb_ULongintMOD cdecl ( byval x as ulongint, byval y as ulongint ) as ulongint '/ _
		( _
			@FB_RTL_ULONGINTMOD, @"__umoddi3", _
			FB_DATATYPE_ULONGINT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
	 		{ _
				( FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' fb_Dbl2ULongint cdecl ( byval x as double ) as ulongint '/ _
		( _
			@FB_RTL_DBL2ULONGINT, @"__fixunsdfdi", _
			FB_DATATYPE_ULONGINT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' fb_Pow CDECL ( byval x as double, byval y as double ) as double '/ _
		( _
			@FB_RTL_POW, @"pow", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' randomize ( byval seed as double = -1.0, byval algorithm as integer = 0 ) as void '/ _
		( _
			@"randomize", @"fb_Randomize", _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
			@hRndCallback, FB_RTL_OPT_NONE, _
			2, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, TRUE, -1.0 ), _
				( FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 ) _
	 		} _
		), _
		/' rnd ( byval n as single ) as double '/ _
		( _
			@"rnd", @"fb_Rnd", _
			FB_DATATYPE_DOUBLE, FB_USE_FUNCMODE_FBCALL, _
			@hRndCallback, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, TRUE, 1.0 ) _
	 		} _
	 	), _
		/' sinf CDECL overload ( byval x as single ) as single '/ _
		( _
			@FB_RTL_SIN, @"sinf", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sin CDECL overload ( byval x as double ) as double '/ _
		( _
			@FB_RTL_SIN, @"sin", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' asinf CDECL overload ( byval x as single ) as single '/ _
		( _
			@FB_RTL_ASIN, @"asinf", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' asin CDECL overload ( byval x as double ) as double '/ _
		( _
			@FB_RTL_ASIN, @"asin", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' cosf CDECL overload ( byval x as single ) as single '/ _
		( _
			@FB_RTL_COS, @"cosf", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' cos CDECL overload ( byval x as double ) as double '/ _
		( _
			@FB_RTL_COS, @"cos", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' acosf CDECL overload ( byval x as single ) as single '/ _
		( _
			@FB_RTL_ACOS, @"acosf", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' acos CDECL overload ( byval x as double ) as double '/ _
		( _
			@FB_RTL_ACOS, @"acos", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' tanf CDECL overload ( byval x as single ) as single '/ _
		( _
			@FB_RTL_TAN, @"tanf", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' tan CDECL overload ( byval x as double ) as double '/ _
		( _
			@FB_RTL_TAN, @"tan", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' atanf CDECL overload ( byval x as single ) as single '/ _
		( _
			@FB_RTL_ATAN, @"atanf", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' atan CDECL overload ( byval x as double ) as double '/ _
		( _
			@FB_RTL_ATAN, @"atan", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sqrtf CDECL overload ( byval x as single ) as single '/ _
		( _
			@FB_RTL_sqrt, @"sqrtf", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sqrt CDECL overload ( byval x as double ) as double '/ _
		( _
			@FB_RTL_sqrt, @"sqrt", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' logf CDECL overload ( byval x as single ) as single '/ _
		( _
			@FB_RTL_log, @"logf", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' log CDECL overload ( byval x as double ) as double '/ _
		( _
			@FB_RTL_log, @"log", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' expf CDECL overload ( byval x as single ) as single '/ _
		( _
			@FB_RTL_exp, @"expf", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' exp CDECL overload ( byval x as double ) as double '/ _
		( _
			@FB_RTL_exp, @"exp", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' floorf CDECL overload ( byval x as single ) as single '/ _
		( _
			@FB_RTL_floor, @"floorf", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' floor CDECL overload ( byval x as double ) as double '/ _
		( _
			@FB_RTL_floor, @"floor", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' abs CDECL overload ( byval x as integer ) as integer '/ _
		( _
			@FB_RTL_abs, @"abs", _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' abs CDECL overload ( byval x as longint ) as longint '/ _
		( _
			@FB_RTL_abs, @"llabs", _
			FB_DATATYPE_LONGINT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' fabsf CDECL overload ( byval x as single ) as single '/ _
		( _
			@FB_RTL_abs, @"fabsf", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' fabs CDECL overload ( byval x as double ) as double '/ _
		( _
			@FB_RTL_abs, @"fabs", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sgn overload ( byval x as byte ) as integer '/ _
		( _
			@FB_RTL_sgn, @"fb_SGNb", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
				( FB_DATATYPE_BYTE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sgn overload ( byval x as short ) as integer '/ _
		( _
			@FB_RTL_sgn, @"fb_SGNs", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
				( FB_DATATYPE_SHORT, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sgn overload ( byval x as integer ) as integer '/ _
		( _
			@FB_RTL_sgn, @"fb_SGNi", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
				( FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sgn overload ( byval x as longint ) as integer '/ _
		( _
			@FB_RTL_sgn, @"fb_SGNl", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sgn overload ( byval x as single ) as integer '/ _
		( _
			@FB_RTL_sgn, @"fb_SGNSingle", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' sgn overload ( byval x as double ) as integer '/ _
		( _
			@FB_RTL_sgn, @"fb_SGNDouble", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' fix overload ( byval x as single ) as single '/ _
		( _
			@FB_RTL_fix, @"fb_FIXSingle", _
			FB_DATATYPE_SINGLE, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' fix overload ( byval x as double ) as double '/ _
		( _
			@FB_RTL_fix, @"fb_FIXDouble", _
			FB_DATATYPE_DOUBLE, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' frac overload ( byval x as single ) as single '/ _
		( _
			@FB_RTL_frac, @"fb_FRACf", _
			FB_DATATYPE_SINGLE, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' frac overload ( byval x as double ) as double '/ _
		( _
			@FB_RTL_frac, @"fb_FRACd", _
			FB_DATATYPE_DOUBLE, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' atan2f CDECL overload ( byval x as single, byval y as single ) as single '/ _
		( _
			@FB_RTL_ATAN2, @"atan2f", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			2, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' atan2 CDECL overload ( byval x as double, byval y as double ) as double '/ _
		( _
			@FB_RTL_ATAN2, @"atan2", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_GCCBUILTIN, _
			2, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' ftosl cdecl ( byval x as single ) as long '/ _
		( _
			@FB_RTL_FTOSL, @FB_RTL_FTOSL, _
			FB_DATATYPE_LONGINT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_IRHLCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' dtosl cdecl ( byval x as double ) as long '/ _
		( _
			@FB_RTL_DTOSL,@FB_RTL_DTOSL, _
			FB_DATATYPE_LONGINT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_IRHLCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' ftosi cdecl ( byval x as single ) as integer '/ _
		( _
			@FB_RTL_FTOSI, @FB_RTL_FTOSI, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_IRHLCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' dtosi cdecl ( byval x as double ) as integer '/ _
		( _
			@FB_RTL_DTOSI, @FB_RTL_DTOSI, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_IRHLCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' ftoss cdecl ( byval x as single ) as short '/ _
		( _
			@FB_RTL_FTOSS, @FB_RTL_FTOSS, _
			FB_DATATYPE_SHORT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_IRHLCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' dtoss cdecl ( byval x as double ) as short '/ _
		( _
			@FB_RTL_DTOSS, @FB_RTL_DTOSS, _
			FB_DATATYPE_SHORT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_IRHLCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' ftosb cdecl ( byval x as single ) as byte '/ _
		( _
			@FB_RTL_FTOSB, @FB_RTL_FTOSB, _
			FB_DATATYPE_BYTE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_IRHLCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' dtosb cdecl ( byval x as double ) as byte '/ _
		( _
			@FB_RTL_DTOSB, @FB_RTL_DTOSB, _
			FB_DATATYPE_BYTE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_IRHLCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' ftoul cdecl ( byval x as single ) as long '/ _
		( _
			@FB_RTL_FTOUL, @FB_RTL_FTOUL, _
			FB_DATATYPE_ULONGINT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_IRHLCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' dtoul cdecl ( byval x as double ) as long '/ _
		( _
			@FB_RTL_DTOUL, @FB_RTL_DTOUL, _
			FB_DATATYPE_ULONGINT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_IRHLCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' ftoui cdecl ( byval x as single ) as integer '/ _
		( _
			@FB_RTL_FTOUI, @FB_RTL_FTOUI, _
			FB_DATATYPE_UINT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_IRHLCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' dtoui cdecl ( byval x as double ) as integer '/ _
		( _
			@FB_RTL_DTOUI, @FB_RTL_DTOUI, _
			FB_DATATYPE_UINT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_IRHLCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' ftous cdecl ( byval x as single ) as short '/ _
		( _
			@FB_RTL_FTOUS, @FB_RTL_FTOUS, _
			FB_DATATYPE_USHORT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_IRHLCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' dtous cdecl ( byval x as double ) as short '/ _
		( _
			@FB_RTL_DTOUS, @FB_RTL_DTOUS, _
			FB_DATATYPE_USHORT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_IRHLCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' ftoub cdecl ( byval x as single ) as byte '/ _
		( _
			@FB_RTL_FTOUB, @FB_RTL_FTOUB, _
			FB_DATATYPE_UBYTE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_IRHLCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' dtoub cdecl ( byval x as double ) as byte '/ _
		( _
			@FB_RTL_DTOUB, @FB_RTL_DTOUB, _
			FB_DATATYPE_UBYTE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_IRHLCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
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

	case FB_DATATYPE_LONG
		'' TODO: Use longint versions when compiling for 64bit
		if( from_dtype = FB_DATATYPE_SINGLE ) then
			sym = PROCLOOKUP( FTOSI )
		else
			sym = PROCLOOKUP( DTOSI )
		end if

	case FB_DATATYPE_ULONG
		'' TODO: Use longint versions when compiling for 64bit
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

private function hRndCallback( byval sym as FBSYMBOL ptr ) as integer
	static as integer added = FALSE

	if( added = FALSE ) then
		added = TRUE
		select case env.clopt.target
		case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
			fbAddLib( "advapi32" )
		end select
	end if

        return TRUE
end function
