'' threadcall AST transform
''
'' chng: oct/2011 written [jofers]

#include once "fb.bi"
#include once "fbint.bi"
#include once "ast.bi"
#include once "rtl.bi"

declare function hThreadCallPushType _
	( _
		byval funcexpr as ASTNODE ptr, _
		byval tctype as integer, _
		byval stype as FBSYMBOL ptr _
	) as integer

private function hThreadCallMapType _
	( _
		byval sym as FBSYMBOL ptr, _
		byval udt as integer = FALSE _
	) as integer

	function = -1

	dim as FB_DATATYPE dtype = symbGetType( sym )
	dim as FBSYMBOL ptr subtype = symbGetSubType( sym )

	'' arrays not supported inside udts
	if( symbIsArray( sym ) ) then
		return iif( udt, -1, FB_THREADCALL_PTR )
	end if

	'' Bitfields not supported
	if( symbIsBitfield( sym ) ) then
		exit function
	end if

	if( typeIsPtr( dtype ) ) then
		return FB_THREADCALL_PTR
	end if

	select case( dtype )
	case FB_DATATYPE_STRING
		function = iif( udt, -1, FB_THREADCALL_PTR )
	case FB_DATATYPE_STRUCT
		'' restrictions to simplify life
		if( symbGetUDTIsUnion( subtype ) or symbGetUDTHasAnonUnion( subtype ) ) then
			exit function
		end if
		if symbGetUDTAlign( subtype ) <> 0 then
			exit function
		end if

		'' FB transforms type with 1 element to that element's type
		dim as FBSYMBOL ptr first = symbUdtGetFirstField( subtype )
		'' no second field?
		if( symbUdtGetNextField( first ) = NULL ) then
			function = hThreadCallMapType( first, TRUE )
		else
			function = FB_THREADCALL_STRUCT
		end if
	case FB_DATATYPE_BYTE, FB_DATATYPE_CHAR, FB_DATATYPE_UBYTE, _
	     FB_DATATYPE_SHORT, FB_DATATYPE_WCHAR, FB_DATATYPE_USHORT, _
	     FB_DATATYPE_INTEGER, FB_DATATYPE_ENUM, FB_DATATYPE_UINT, _
	     FB_DATATYPE_LONG, FB_DATATYPE_ULONG, _
	     FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT, _
	     FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		select case as const( typeGetSizeType( dtype ) )
		case FB_SIZETYPE_INT8    : function = FB_THREADCALL_INT8
		case FB_SIZETYPE_UINT8   : function = FB_THREADCALL_UINT8
		case FB_SIZETYPE_INT16   : function = FB_THREADCALL_INT16
		case FB_SIZETYPE_UINT16  : function = FB_THREADCALL_UINT16
		case FB_SIZETYPE_INT32   : function = FB_THREADCALL_INT32
		case FB_SIZETYPE_UINT32  : function = FB_THREADCALL_UINT32
		case FB_SIZETYPE_INT64   : function = FB_THREADCALL_INT64
		case FB_SIZETYPE_UINT64  : function = FB_THREADCALL_UINT64
		case FB_SIZETYPE_FLOAT32 : function = FB_THREADCALL_FLOAT32
		case FB_SIZETYPE_FLOAT64 : function = FB_THREADCALL_FLOAT64
		case else                : assert( FALSE )
		end select
	case else
		exit function
	end select

end function

private function hThreadCallPushStruct _
	( _
		byval funcexpr as ASTNODE ptr, _
		byval struct as FBSYMBOL ptr _
	) as integer

	dim as FBSYMBOL ptr fld = any
	dim as integer count = any

	'' count number of elements
	count = 0
	fld = symbUdtGetFirstField( struct )
	do
		count += 1
		fld = symbUdtGetNextField( fld )
	loop while( fld )

	'' push number of elements
	if( astNewArg( funcexpr, astNewCONSTi( count ) ) = NULL ) then
		exit function
	end if

	'' push each element
	fld = symbUdtGetFirstField( struct )
	do
		if( hThreadCallPushType( funcexpr, _
		                         hThreadCallMapType( fld, TRUE ), _
		                         symbGetSubType( fld ) ) = FALSE ) then
			exit  function
		end if
		fld = symbUdtGetNextField( fld )
	loop while( fld )

	function = TRUE
end function

'':::::
private function hThreadCallPushType _
	( _
		byval funcexpr as ASTNODE ptr, _
		byval tctype as integer, _
		byval stype as FBSYMBOL ptr _
	) as integer

	function = false

	'' Unsupported datatype
	if( tctype = -1 ) then
		errReport( FB_ERRMSG_UNSUPPORTEDFUNCTION )
		exit function
	end if

	'' push argument on stack
	dim as ASTNODE ptr typeexpr
	typeexpr = astNewCONSTi( tctype )
	if( astNewARG( funcexpr, typeexpr ) = NULL ) then
		exit function
	end if

	'' push type info to the stack
	if( tctype = FB_THREADCALL_STRUCT ) then
		if( hThreadCallPushStruct( funcexpr, stype ) = FALSE ) then
			exit function
		end if
	end if

	function = true
end function

'' TODO: Re-use astRemSideFx/astMakeRef instead of this?
private function hGetExprRef( byref expr as ASTNODE ptr ) as ASTNODE ptr
	dim as FBSYMBOL ptr tmpvar = any

	if( astIsVAR( expr ) ) then
		'' already a variable? just get the address
		'' @expr
		expr = astNewADDROF( expr )
	else
		'' copy expression to a variable, and get the address
		tmpvar = symbAddTempVar( astGetDataType( expr ), astGetSubType( expr ) )

		'' tmpvar = expr
		function = astNewASSIGN( astNewVAR( tmpvar ), expr, AST_OPOPT_DONTCHKPTR )

		'' @tmpvar
		expr = astNewADDROF( astNewVAR( tmpvar ) )
	end if
end function

'':::::
function rtlThreadCall(byval callexpr as ASTNODE ptr) as ASTNODE ptr

	function = NULL

	dim as FBSYMBOL ptr proc, param
	dim as ASTNODE ptr procmodeexpr, t
	dim as ASTNODE ptr stacksizeexpr, argsexpr, ptrexpr

	proc = callexpr->sym

	'' copy off symbol and all the arguments
	dim args as integer = callexpr->call.args
	dim arg as ASTNODE ptr = callexpr->r
	dim argupper as integer = iif( args=0, 1, args )
	redim argexpr( 1 to argupper ) as ASTNODE ptr
	redim argmode( 1 to argupper ) as integer
	for i as integer = 1 to args
		if arg = 0 then
			exit function
		end if

		'' Take the argument expression out of the ARG node
		argexpr( args-i+1 ) = arg->l
		arg->l = NULL

		argmode( args-i+1 ) = arg->arg.mode

		arg = arg->r
	next i

	'' Delete the CALL and its now empty ARGs
	astDelTREE( callexpr )

	'' create new call
	dim as ASTNODE ptr expr = astNewCall( PROCLOOKUP( THREADCALL ) )

	'' push function argument
	if( astNewARG( expr, astBuildProcAddrOf( proc ) ) = NULL ) then
		exit function
	end if

	'' get calling convention
	dim as integer procmode, procmode_fb
	procmode_fb = symbGetProcMode( proc )
	if procmode_fb = FB_FUNCMODE_FBCALL then procmode_fb = env.target.fbcall
	if( procmode_fb = FB_FUNCMODE_CDECL ) then
		procmode = FB_THREADCALL_CDECL
	elseif( ((procmode_fb = FB_FUNCMODE_STDCALL) or _
			(procmode_fb = FB_FUNCMODE_STDCALL_MS)) _
		and env.clopt.target = FB_COMPTARGET_WIN32 ) then
		procmode = FB_THREADCALL_STDCALL
	else
		errReport( FB_ERRMSG_UNSUPPORTEDFUNCTION )
		exit function
	end if

	'' push calling convention
	procmodeexpr = astNewCONSTi( procmode )
	if( astNewARG( expr, procmodeexpr ) = NULL ) then
		exit function
	end if

	'' push stack size (not in syntax)
	stacksizeexpr = astNewCONSTi( 0 )
	if( astNewARG( expr, stacksizeexpr ) = NULL ) then
		exit function
	end if

	'' push number of arguments
	argsexpr = astNewCONSTi( args )
	if( astNewARG( expr, argsexpr ) = NULL ) then
		exit function
	end if

	'' push each argument type
	param = symbGetProcLastParam( proc )
	for i as integer = 1 to args

		'' allow byval and byref
		dim as FB_PARAMMODE mode
		dim as integer tctype = -1
		mode = symbGetParamMode( param )

		tctype = hThreadCallMapType( param )
		select case mode
			case FB_PARAMMODE_BYVAL
			case FB_PARAMMODE_BYREF, FB_PARAMMODE_BYDESC
				if( tctype <> -1 ) then
					tctype = FB_THREADCALL_PTR
				end if
			case else
				tctype = -1
		end select

		'' push parameter type
		dim as FBSYMBOL ptr stype = symbGetSubType( param )
		if hThreadCallPushType( expr, tctype, stype ) = FALSE then
			exit function
		end if

		'' get pointer to argument
		ptrexpr = argexpr( i )
		t = astNewLINK( t, hGetExprRef( ptrexpr ), AST_LINK_RETURN_RIGHT )

		''byref
		dim isstring as integer
		isstring = typeGetDtOnly( astGetDataType( argexpr( i ) ) )
		if( mode = FB_PARAMMODE_BYREF and _
			argmode( i ) <> FB_PARAMMODE_BYVAL and _
			isstring = FALSE ) then
			t = astNewLINK( t, hGetExprRef( ptrexpr ), AST_LINK_RETURN_RIGHT )
		end if

		if( ptrexpr = NULL ) then
			exit function
		end if

		'' push pointer to argument
		if( astNewARG( expr, ptrexpr ) = NULL ) then
			exit function
		end if

		param = symbGetProcPrevParam( proc, param )
	next

	function = astNewLINK( t, expr, AST_LINK_RETURN_RIGHT )
end function
