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
		/' sub randomize( byval seed as double = -1.0, byval algorithm as long = 0 ) '/ _
		( _
			@"randomize", @"fb_Randomize", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			@hRndCallback, FB_RTL_OPT_NONE, _
			2, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, TRUE, -1.0 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ) _
	 		} _
		), _
		/' rnd ( byval n as single ) as double '/ _
		( _
			@"rnd", @"fb_Rnd", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_FBCALL, _
			@hRndCallback, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, TRUE, 1.0 ) _
	 		} _
	 	), _
		/' asinf CDECL overload ( byval x as single ) as single '/ _
		( _
			@FB_RTL_ASIN, @"asinf", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' asin CDECL overload ( byval x as double ) as double '/ _
		( _
			@FB_RTL_ASIN, @"asin", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' acosf CDECL overload ( byval x as single ) as single '/ _
		( _
			@FB_RTL_ACOS, @"acosf", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' acos CDECL overload ( byval x as double ) as double '/ _
		( _
			@FB_RTL_ACOS, @"acos", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' tanf CDECL overload ( byval x as single ) as single '/ _
		( _
			@FB_RTL_TAN, @"tanf", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' tan CDECL overload ( byval x as double ) as double '/ _
		( _
			@FB_RTL_TAN, @"tan", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' atanf CDECL overload ( byval x as single ) as single '/ _
		( _
			@FB_RTL_ATAN, @"atanf", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' atan CDECL overload ( byval x as double ) as double '/ _
		( _
			@FB_RTL_ATAN, @"atan", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function abs cdecl overload( byval x as long ) as long '/ _
		( _
			@FB_RTL_ABS, @"abs", _
			FB_DATATYPE_LONG, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function abs cdecl overload( byval x as longint ) as longint '/ _
		( _
			@FB_RTL_ABS, @"llabs", _
			FB_DATATYPE_LONGINT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' fabsf CDECL overload ( byval x as single ) as single '/ _
		( _
			@FB_RTL_ABS, @"fabsf", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' fabs CDECL overload ( byval x as double ) as double '/ _
		( _
			@FB_RTL_ABS, @"fabs", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function sgn overload( byval x as byte ) as long '/ _
		( _
			@FB_RTL_SGN, @"fb_SGNb", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
				( FB_DATATYPE_BYTE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function sgn overload( byval x as short ) as long '/ _
		( _
			@FB_RTL_SGN, @"fb_SGNs", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
				( FB_DATATYPE_SHORT, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function sgn overload( byval x as long ) as long '/ _
		( _
			@FB_RTL_SGN, @"fb_SGNi", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function sgn overload( byval x as longint ) as long '/ _
		( _
			@FB_RTL_SGN, @"fb_SGNl", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function sgn overload( byval x as single ) as long '/ _
		( _
			@FB_RTL_SGN, @"fb_SGNSingle", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function sgn overload( byval x as double ) as long '/ _
		( _
			@FB_RTL_SGN, @"fb_SGNDouble", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' fix overload ( byval x as single ) as single '/ _
		( _
			@FB_RTL_FIX, @"fb_FIXSingle", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' fix overload ( byval x as double ) as double '/ _
		( _
			@FB_RTL_FIX, @"fb_FIXDouble", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' frac overload ( byval x as single ) as single '/ _
		( _
			@FB_RTL_FRAC, @"fb_FRACf", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' frac overload ( byval x as double ) as double '/ _
		( _
			@FB_RTL_FRAC, @"fb_FRACd", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function {atan2} alias "atan2f" cdecl overload( byval x as single, byval y as single ) as single '/ _
		( _
			@FB_RTL_ATAN2, @"atan2f", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER, _
			2, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function {atan2} alias "atan2" cdecl overload( byval x as double, byval y as double ) as double '/ _
		( _
			@FB_RTL_ATAN2, @"atan2", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_OVER, _
			2, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function ftosl cdecl( byval x as single ) as longint '/ _
		( _
			@FB_RTL_FTOSL, @FB_RTL_FTOSL, _
			FB_DATATYPE_LONGINT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_IRHLCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function dtosl cdecl( byval x as double ) as longint '/ _
		( _
			@FB_RTL_DTOSL,@FB_RTL_DTOSL, _
			FB_DATATYPE_LONGINT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_IRHLCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function ftosi cdecl( byval x as single ) as long '/ _
		( _
			@FB_RTL_FTOSI, @FB_RTL_FTOSI, _
			FB_DATATYPE_LONG, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_IRHLCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function dtosi cdecl( byval x as double ) as long '/ _
		( _
			@FB_RTL_DTOSI, @FB_RTL_DTOSI, _
			FB_DATATYPE_LONG, FB_FUNCMODE_CDECL, _
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
		/' function ftoui cdecl( byval x as single ) as ulong '/ _
		( _
			@FB_RTL_FTOUI, @FB_RTL_FTOUI, _
			FB_DATATYPE_ULONG, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_IRHLCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function dtoui cdecl( byval x as double ) as ulong '/ _
		( _
			@FB_RTL_DTOUI, @FB_RTL_DTOUI, _
			FB_DATATYPE_ULONG, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_IRHLCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function ftous cdecl( byval x as single ) as ushort '/ _
		( _
			@FB_RTL_FTOUS, @FB_RTL_FTOUS, _
			FB_DATATYPE_USHORT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_IRHLCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function dtous cdecl( byval x as double ) as ushort '/ _
		( _
			@FB_RTL_DTOUS, @FB_RTL_DTOUS, _
			FB_DATATYPE_USHORT, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_IRHLCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function ftoub cdecl( byval x as single ) as ubyte '/ _
		( _
			@FB_RTL_FTOUB, @FB_RTL_FTOUB, _
			FB_DATATYPE_UBYTE, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_IRHLCBUILTIN, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function dtoub cdecl( byval x as double ) as ubyte '/ _
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

'' RTL functions to implement UOPs not directly supported by C/LLVM backends
'' (for reference: irSupportsOp() implementations)
function rtlMathUop _
	( _
		byval op as integer, _
		byval expr as ASTNODE ptr _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr sym = any

	select case as const( op )
	case AST_OP_SGN  : sym = PROCLOOKUP( SGN  )  '' C/LLVM
	case AST_OP_ABS  : sym = PROCLOOKUP( ABS  )  '' LLVM (abs/llabs integer versions only, not fabs)
	case AST_OP_FIX  : sym = PROCLOOKUP( FIX  )  '' C/LLVM
	case AST_OP_FRAC : sym = PROCLOOKUP( FRAC )  '' C/LLVM
	'case AST_OP_SIN  : sym = PROCLOOKUP( SIN  )  '' unused
	case AST_OP_ASIN : sym = PROCLOOKUP( ASIN )  '' LLVM
	'case AST_OP_COS  : sym = PROCLOOKUP( COS  )  '' unused
	case AST_OP_ACOS : sym = PROCLOOKUP( ACOS )  '' LLVM
	case AST_OP_TAN  : sym = PROCLOOKUP( TAN  )  '' LLVM
	case AST_OP_ATAN : sym = PROCLOOKUP( ATAN )  '' LLVM
	'case AST_OP_SQRT : sym = PROCLOOKUP( SQRT )  '' unused
	'case AST_OP_LOG  : sym = PROCLOOKUP( LOG  )  '' unused
	'case AST_OP_EXP  : sym = PROCLOOKUP( EXP  )  '' unused
	'case AST_OP_FLOOR : sym = PROCLOOKUP( FLOOR )  '' unused
	case else
		assert( FALSE )
		exit function
	end select

	function = rtlOvlProcCall( sym, expr )
end function

'' RTL functions to implement BOPs not directly supported by C/LLVM backends
'' (for reference: irSupportsOp() implementations)
function rtlMathBop _
	( _
		byval op as integer, _
		byval lexpr as ASTNODE ptr, _
		byval rexpr as ASTNODE ptr _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr sym = any

	select case as const( op )
	case AST_OP_ATAN2
		sym = PROCLOOKUP( ATAN2 )  '' LLVM
	case else
		assert( FALSE )
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

	select case as const( typeGetSizeType( to_dtype ) )
	case FB_SIZETYPE_INT8
		if( from_dtype = FB_DATATYPE_SINGLE ) then
			sym = PROCLOOKUP( FTOSB )
		else
			sym = PROCLOOKUP( DTOSB )
		end if

	case FB_SIZETYPE_UINT8
		if( from_dtype = FB_DATATYPE_SINGLE ) then
			sym = PROCLOOKUP( FTOUB )
		else
			sym = PROCLOOKUP( DTOUB )
		end if

	case FB_SIZETYPE_INT16
		if( from_dtype = FB_DATATYPE_SINGLE ) then
			sym = PROCLOOKUP( FTOSS )
		else
			sym = PROCLOOKUP( DTOSS )
		end if

	case FB_SIZETYPE_UINT16
		if( from_dtype = FB_DATATYPE_SINGLE ) then
			sym = PROCLOOKUP( FTOUS )
		else
			sym = PROCLOOKUP( DTOUS )
		end if

	case FB_SIZETYPE_INT32
		if( from_dtype = FB_DATATYPE_SINGLE ) then
			sym = PROCLOOKUP( FTOSI )
		else
			sym = PROCLOOKUP( DTOSI )
		end if

	case FB_SIZETYPE_UINT32
		if( from_dtype = FB_DATATYPE_SINGLE ) then
			sym = PROCLOOKUP( FTOUI )
		else
			sym = PROCLOOKUP( DTOUI )
		end if

	case FB_SIZETYPE_INT64
		if( from_dtype = FB_DATATYPE_SINGLE ) then
			sym = PROCLOOKUP( FTOSL )
		else
			sym = PROCLOOKUP( DTOSL )
		end if

	case FB_SIZETYPE_UINT64
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
