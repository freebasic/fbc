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
function rtlMathPow _
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

private function hRndCallback( byval sym as FBSYMBOL ptr ) as integer
	'' minor optimization to avoid having to lookup env.libs hash
	fbRestartableStaticVariable( integer, libsAdded, FALSE )

	if( libsAdded = FALSE ) then
		libsAdded = TRUE
		select case env.clopt.target
		case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
			fbAddLib( "advapi32" )
		end select
	end if

	return TRUE
end function
