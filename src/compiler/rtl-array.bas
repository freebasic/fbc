'' intrinsic runtime lib array functions (REDIM, ERASE, LBOUND, ...)
''
'' chng: oct/2004 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "ast.bi"
#include once "lex.bi"
#include once "rtl.bi"

	dim shared as FB_RTL_PROCDEF funcdata( 0 to ... ) = _
	{ _
		/' function fb_ArrayRedimEx cdecl _
			( _
				array() as any, _
				byval elementlen as const uinteger, _
				byval doclear as const long, _
				byval isvarlen as const long, _
				byval dimensions as const uinteger, _
				... _
			) as long '/ _
		( _
			@FB_RTL_ARRAYREDIM, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			6, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_UINT ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_UINT ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INVALID ), FB_PARAMMODE_VARARG, FALSE ) _
			} _
		), _
		/' function fb_ArrayRedimPresvEx cdecl _
			( _
				array() as any, _
				byval elementlen as const uinteger, _
				byval doclear as const long, _
				byval isvarlen as const long, _
				byval dimensions as const uinteger, _
				... _
			) as integer '/ _
		( _
			@FB_RTL_ARRAYREDIMPRESV, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			6, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_UINT ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_UINT ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INVALID ), FB_PARAMMODE_VARARG, FALSE ) _
			} _
		), _
		/' function fb_ArrayRedimObj cdecl _
			( _
				array() as any, _
				byval elementlen as const uinteger, _
				byval ctor as sub cdecl( byval this_ as any ptr), _
				byval dtor as sub cdecl( byval this_ as any ptr), _
				byval dimensions as const uinteger, _
				... _
			) as long '/ _
		( _
			@FB_RTL_ARRAYREDIM_OBJ, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			6, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_UINT ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_UINT ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_INVALID, FB_PARAMMODE_VARARG, FALSE ) _
			} _
		), _
		/' function fb_ArrayRedimPresvObj cdecl _
			( _
				array() as any, _
				byval elementlen as const uinteger, _
				byval ctor as sub cdecl( ), _
				byval dtor as sub cdecl( ), _
				byval dimensions as const uinteger, _
				... _
			) as long '/ _
		( _
			@FB_RTL_ARRAYREDIMPRESV_OBJ, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			6, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_UINT ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_UINT ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_INVALID, FB_PARAMMODE_VARARG, FALSE ) _
			} _
		), _
		/' function fb_ArrayRedimTo _
			( _
				dest() as any, _
				source() as any, _
				byval isvarlen as const long, _
				byval ctor as sub cdecl( byval this_ as any ptr), _
				byval dtor as sub cdecl( byval this_ as any ptr) _
			) as long '/ _
		( _
			@FB_RTL_ARRAYREDIMTO, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			5, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE ), _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_ArrayDestructObj( array() as any, byval dtor as sub cdecl( ) ) '/ _
		( _
			@FB_RTL_ARRAYDESTRUCTOBJ, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_ArrayDestructStr( array() as any ) '/ _
		( _
			@FB_RTL_ARRAYDESTRUCTSTR, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE ) _
			} _
		), _
		/' function fb_ArrayClear( array() as any ) as long '/ _
		( _
			@FB_RTL_ARRAYCLEAR, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE ) _
			} _
		), _
		/' function fb_ArrayClearObj _
			( _
				array() as any, _
				byval ctor as sub cdecl( ), _
				byval dtor as sub cdecl( ) _
			) as long '/ _
		( _
			@FB_RTL_ARRAYCLEAROBJ, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_ArrayErase( array() as any ) as long '/ _
		( _
			@FB_RTL_ARRAYERASE, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE ) _
			} _
		), _
		/' function fb_ArrayEraseObj _
			( _
				array() as any, _
				byval ctor as sub cdecl( ), _
				byval dtor as sub cdecl( ) _
			) as long '/ _
		( _
			@FB_RTL_ARRAYERASEOBJ, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_ArrayStrErase( array() as any ) '/ _
		( _
			@FB_RTL_ARRAYERASESTR, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE ) _
			} _
		), _
		/' function fb_ArrayLBound( array() as any, byval dimension as const integer ) as integer '/ _
		( _
			@FB_RTL_ARRAYLBOUND, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_VOID ), FB_PARAMMODE_BYDESC, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_ArrayUBound( array() as any, byval dimension as const integer ) as integer '/ _
		( _
			@FB_RTL_ARRAYUBOUND, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_VOID ), FB_PARAMMODE_BYDESC, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_ArraySngBoundChk _
			( _
				byval idx as const uinteger, _
				byval ubound as const uinteger, _
				byval linenum as const long, _
				byval fname as const zstring ptr _
			) as any ptr '/ _
		( _
			@FB_RTL_ARRAYSNGBOUNDCHK, NULL, _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_CANBECLONED, _
			4, _
			{ _
				( typeSetIsConst( FB_DATATYPE_UINT ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_UINT ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_CHAR ) ), FB_PARAMMODE_BYVAL, FALSE, 0 ) _
			} _
		), _
		/' function fb_ArrayBoundChk _
			( _
				byval idx as const integer, _
				byval lbound as const integer, _
				byval ubound as const integer, _
				byval linenum as const long, _
				byval fname as const zstring ptr _
			) as any ptr '/ _
		( _
			@FB_RTL_ARRAYBOUNDCHK, NULL, _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_CANBECLONED, _
			5, _
			{ _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_CHAR ) ), FB_PARAMMODE_BYVAL, FALSE, 0 ) _
			} _
		), _
		/' EOL '/ _
		( _
			NULL _
		) _
	}

sub rtlArrayModInit( )
	rtlAddIntrinsicProcs( @funcdata(0) )
end sub

sub rtlArrayModEnd( )
	'' procs will be deleted when symbEnd is called
end sub

private function hBuildProcPtr(byval proc as FBSYMBOL ptr) as ASTNODE ptr
	if( proc = NULL ) then
		return astNewCONSTi( 0 )
	end if
	function = astBuildProcAddrof( proc )
end function

private sub hCheckDefCtor _
	( _
		byval ctor as FBSYMBOL ptr, _
		byval check_access as integer, _
		byval is_erase as integer _
	)

	if( ctor = NULL ) then exit sub

	assert( symbIsConstructor( ctor ) )

	if( check_access ) then
		'' Check visibility of the default constructor
		if( symbCheckAccess( ctor ) = FALSE ) then
			errReport( FB_ERRMSG_NOACCESSTODEFAULTCTOR )
		end if
	end if

	'' Check whether the given default ctor matches the rtlib's FB_DEFCTOR
	if( symbGetProcMode( ctor ) <> FB_FUNCMODE_CDECL ) then
		errReport( iif( is_erase, FB_ERRMSG_ERASECTORMUSTBECDEL, _
		                          FB_ERRMSG_REDIMCTORMUSTBECDEL ) )
	end if

	'' Must have only the THIS ptr parameter
	if( symbGetProcParams( ctor ) <> 1 ) then
		errReport( iif( is_erase, FB_ERRMSG_ERASECTORMUSTHAVEONEPARAM, _
		                          FB_ERRMSG_REDIMCTORMUSTHAVEONEPARAM ) )
	end if

end sub

private sub hCheckDtor _
	( _
		byval dtor as FBSYMBOL ptr, _
		byval check_access as integer, _
		byval is_erase as integer _
	)

	if( dtor = NULL ) then exit sub

	assert( symbIsDestructor1( dtor ) )

	if( check_access ) then
		'' Check visibility of the default destructor
		if( symbCheckAccess( dtor ) = FALSE ) then
			errReport( FB_ERRMSG_NOACCESSTODTOR )
		end if
	end if

	'' Check whether the given dtor matches the rtlib's FB_DEFCTOR
	if( symbGetProcMode( dtor ) <> FB_FUNCMODE_CDECL ) then
		errReport( iif( is_erase, FB_ERRMSG_ERASEDTORMUSTBECDEL, _
		                          FB_ERRMSG_REDIMDTORMUSTBECDEL ) )
	end if

	assert( symbGetProcParams( dtor ) = 1 )

end sub

'' fb_ArrayClear*
'' destruct elements if needed and then re-initialize
''
'' fb_ArrayClear* rtlib functions are called when it is known at
'' compile time that array is static (fixed length).  It it is unknown
'' at compile time, then rtlArrayErase() should be used instead and
'' the runtime library will do a run time check on the array's
'' descriptor flags to determine if it is static or dynamic.
''
function rtlArrayClear( byval arrayexpr as ASTNODE ptr ) as ASTNODE ptr
	dim as ASTNODE ptr proc = any
	dim as integer dtype = any
	dim as FBSYMBOL ptr ctor = any, dtor = any, subtype = any

	function = NULL

	dtype = astGetDataType( arrayexpr )

	if( dtype = FB_DATATYPE_STRUCT ) then
		subtype = astGetSubtype( arrayexpr )
		ctor = symbGetCompDefCtor( subtype )
		dtor = symbGetCompDtor1( subtype )

		'' No default ctor, but others? Then the rtlib cannot just clear
		'' that array of objects.
		if( (ctor = NULL) and (symbGetCompCtorHead( subtype ) <> NULL) ) then
			errReport( FB_ERRMSG_NODEFAULTCTORDEFINED )
		end if
	else
		ctor = NULL
		dtor = NULL
	end if

	if( (ctor <> NULL) or (dtor <> NULL) ) then
		hCheckDefCtor( ctor, TRUE, TRUE )
		hCheckDtor( dtor, TRUE, TRUE )

		'' fb_ArrayClearObj()
		proc = astNewCALL( PROCLOOKUP( ARRAYCLEAROBJ ) )

		'' array() as any
		if( astNewARG( proc, arrayexpr, dtype ) = NULL ) then
			exit function
		end if

		'' byval ctor as sub cdecl( )
		if( astNewARG( proc, hBuildProcPtr( ctor ) ) = NULL ) then
			exit function
		end if

		'' byval dtor as sub cdecl( )
		if( astNewARG( proc, hBuildProcPtr( dtor ) ) = NULL ) then
			exit function
		end if

	elseif( dtype = FB_DATATYPE_STRING ) then
		'' fb_ArrayDestructStr() to clear the string array
		'' - there is no fb_ArrayClearStr() in rtlib
		proc = astNewCALL( PROCLOOKUP( ARRAYDESTRUCTSTR ) )

		'' array() as any
		if( astNewARG( proc, arrayexpr, dtype ) = NULL ) then
			exit function
		end if
	else
		'' fb_ArrayClear()
		proc = astNewCALL( PROCLOOKUP( ARRAYCLEAR ) )

		'' array() as any
		if( astNewARG( proc, arrayexpr, dtype ) = NULL ) then
			exit function
		end if

	end if

	function = proc
end function

'' fb_ArrayErase* or fb_ArrayDestruct*
'' destruct elements, and free array if it's dynamic
''
'' if it is unknown at compile time if the array is
'' dynamic or static, the rtlib will do a run time
'' check on the array descriptor flags to determine
'' if the array is to be freed, or cleared only
''
function rtlArrayErase _
	( _
		byval arrayexpr as ASTNODE ptr, _
		byval is_dynamic as integer, _
		byval check_access as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any
	dim as integer dtype = any
	dim as FBSYMBOL ptr ctor = any, dtor = any, subtype = any

	function = NULL

	dtype = astGetDataType( arrayexpr )

	if( dtype = FB_DATATYPE_STRUCT ) then
		subtype = astGetSubtype( arrayexpr )
		ctor = symbGetCompDefCtor( subtype )
		dtor = symbGetCompDtor1( subtype )

		'' No default ctor, but others? Then the rtlib cannot just clear
		'' that array of objects.
		if( (ctor = NULL) and (symbGetCompCtorHead( subtype ) <> NULL) ) then
			errReport( FB_ERRMSG_NODEFAULTCTORDEFINED )
		end if
	else
		ctor = NULL
		dtor = NULL
	end if

	if( (ctor <> NULL) or (dtor <> NULL) ) then
		hCheckDtor( dtor, check_access, TRUE )

		if( is_dynamic ) then
			'' fb_ArrayEraseObj()
			proc = astNewCALL( PROCLOOKUP( ARRAYERASEOBJ ) )
		else
			'' fb_ArrayDestructObj()
			proc = astNewCALL( PROCLOOKUP( ARRAYDESTRUCTOBJ ) )
		end if

		'' array() as any
		if( astNewARG( proc, arrayexpr, dtype ) = NULL ) then
			exit function
		end if

		if( is_dynamic ) then
			'' byval ctor as sub cdecl( )
			if( astNewARG( proc, hBuildProcPtr( ctor ) ) = NULL ) then
				exit function
			end if
		end if

		'' byval dtor as sub cdecl( )
		if( astNewARG( proc, hBuildProcPtr( dtor ) ) = NULL ) then
			exit function
		end if
	elseif( dtype = FB_DATATYPE_STRING ) then
		if( is_dynamic ) then
			'' fb_ArrayStrErase()
			proc = astNewCALL( PROCLOOKUP( ARRAYERASESTR ) )
		else
			'' fb_ArrayDestructStr()
			proc = astNewCALL( PROCLOOKUP( ARRAYDESTRUCTSTR ) )
		end if

		'' array() as any
		if( astNewARG( proc, arrayexpr, dtype ) = NULL ) then
			exit function
		end if
	else
		if( is_dynamic = FALSE ) then
			'' No dtor, not dynamic = nothing to do
			exit function
		end if

		'' fb_ArrayErase()
		proc = astNewCALL( PROCLOOKUP( ARRAYERASE ) )

		'' array() as any
		if( astNewARG( proc, arrayexpr, dtype ) = NULL ) then
			exit function
		end if

	end if

	function = proc
end function

private sub hGetCtorDtorForRedim _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byref ctor as FBSYMBOL ptr, _
		byref dtor as FBSYMBOL ptr _
	)

	if( typeGetDtAndPtrOnly( dtype ) = FB_DATATYPE_STRUCT ) then
		ctor = symbGetCompDefCtor( subtype )
		dtor = symbGetCompDtor1( subtype )

		'' Assuming there aren't any other ctors if there is no default one,
		'' because if it were possible to declare such a dynamic array,
		'' the rtlib couldn't REDIM it.
		assert( iif( ctor = NULL, (symbGetCompCtorHead( subtype ) = NULL) or (errGetCount( ) > 0), TRUE ) )
	else
		ctor = NULL
		dtor = NULL
	end if

end sub

function rtlArrayRedim _
	( _
		byval arrayexpr as ASTNODE ptr, _
		byval dimensions as integer, _
		exprTB() as ASTNODE ptr, _
		byval dopreserve as integer, _
		byval doclear as integer _
	) as ASTNODE ptr

	'' no const filtering needed... dynamic arrays can't be const

	dim as ASTNODE ptr proc = any, expr = any
	dim as FBSYMBOL ptr f = any, sym = any, subtype = any
	dim as FBSYMBOL ptr ctor = any, dtor = any
	dim as integer dtype = any
	dim as longint elementlen = any

	sym = astGetSymbol( arrayexpr )
	dtype = symbGetFullType( sym )
	elementlen = symbGetLen( sym )

	hGetCtorDtorForRedim( dtype, symbGetSubtype( sym ), ctor, dtor )

	if( (ctor = NULL) and (dtor = NULL) ) then
		if( dopreserve = FALSE ) then
			f = PROCLOOKUP( ARRAYREDIM )
		else
			f = PROCLOOKUP( ARRAYREDIMPRESV )
		end if
	else
		if( dopreserve = FALSE ) then
			f = PROCLOOKUP( ARRAYREDIM_OBJ )
		else
			f = PROCLOOKUP( ARRAYREDIMPRESV_OBJ )
		end if
	end if

	proc = astNewCALL( f )

	'' array() as ANY
	if( astNewARG( proc, arrayexpr ) = NULL ) then
		exit function
	end if

	'' byval element_len as integer
	if( astNewARG( proc, astNewCONSTi( elementlen ) ) = NULL ) then
		exit function
	end if

	if( (ctor = NULL) and (dtor = NULL) ) then
		'' byval doclear as integer
		if( astNewARG( proc, astNewCONSTi( doclear ) ) = NULL ) then
			exit function
		end if

		'' byval isvarlen as integer
		if( astNewARG( proc, astNewCONSTi( (dtype = FB_DATATYPE_STRING) ) ) = NULL ) then
			exit function
		end if
	else
		hCheckDefCtor( ctor, TRUE, FALSE )
		hCheckDtor( dtor, TRUE, FALSE )

		'' byval ctor as sub cdecl( )
		if( astNewARG( proc, hBuildProcPtr( ctor ) ) = NULL ) then
			exit function
		end if

		'' byval dtor as sub cdecl( )
		if( astNewARG( proc, hBuildProcPtr( dtor ) ) = NULL ) then
			exit function
		end if
	end if

	'' byval dimensions as integer
	if( astNewARG( proc, astNewCONSTi( dimensions ) ) = NULL ) then
		exit function
	end if

	'' ...
	for i as integer = 0 to dimensions-1
		'' lbound
		expr = exprTB(i, 0)

		'' convert to int
		if( astGetDataType( expr ) <> FB_DATATYPE_INTEGER ) then
			expr = astNewCONV( FB_DATATYPE_INTEGER, NULL, expr )

			if( expr = NULL ) then
				exit function
			end if

		end if

		if( astNewARG( proc, expr ) = NULL ) then
			exit function
		end if

		'' ubound
		expr = exprTB(i, 1)

		'' convert to int
		if( astGetDataType( expr ) <> FB_DATATYPE_INTEGER ) then
			expr = astNewCONV( FB_DATATYPE_INTEGER, NULL, expr )

			if( expr = NULL ) then
				exit function
			end if

		end if

		if( astNewARG( proc, expr ) = NULL ) then
			exit function
		end if
	next

	function = rtlErrorCheck( proc )
end function

function rtlArrayRedimTo _
	( _
		byval dstexpr as ASTNODE ptr, _
		byval srcexpr as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any
	dim as FBSYMBOL ptr ctor = any, dtor = any

	hGetCtorDtorForRedim( dtype, subtype, ctor, dtor )

	proc = astNewCALL( PROCLOOKUP( ARRAYREDIMTO ) )

	'' dest() as any
	if( astNewARG( proc, dstexpr ) = NULL ) then
		exit function
	end if

	'' source() as any
	if( astNewARG( proc, srcexpr ) = NULL ) then
		exit function
	end if

	'' byval isvarlen as long
	if( astNewARG( proc, astNewCONSTi( _
	    (typeGetDtAndPtrOnly( dtype ) = FB_DATATYPE_STRING) ) ) = NULL ) then
		exit function
	end if

	hCheckDefCtor( ctor, FALSE, FALSE )
	hCheckDtor( dtor, FALSE, FALSE )

	'' byval ctor as sub cdecl( )
	if( astNewARG( proc, hBuildProcPtr( ctor ) ) = NULL ) then
		exit function
	end if

	'' byval dtor as sub cdecl( )
	if( astNewARG( proc, hBuildProcPtr( dtor ) ) = NULL ) then
		exit function
	end if

	function = rtlErrorCheck( proc )
end function

function rtlArrayBound _
	( _
		byval arrayexpr as ASTNODE ptr, _
		byval dimexpr as ASTNODE ptr, _
		byval islbound as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any

	function = NULL

	proc = astNewCALL( iif( islbound, _
	                   PROCLOOKUP( ARRAYLBOUND ), _
	                   PROCLOOKUP( ARRAYUBOUND ) ) )

	'' array() as ANY
	if( astNewARG( proc, arrayexpr ) = NULL ) then
		exit function
	end if

	'' byval dimension as integer
	if( astNewARG( proc, dimexpr ) = NULL ) then
		exit function
	end if

	function = proc
end function

'':::::
function rtlArrayBoundsCheck _
	( _
		byval idx as ASTNODE ptr, _
		byval lb as ASTNODE ptr, _
		byval rb as ASTNODE ptr, _
		byval linenum as integer, _
		byval module as zstring ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any
	dim as FBSYMBOL ptr f = any

	function = NULL

	'' lbound 0? do a single check
	if( lb = NULL ) then
		f = PROCLOOKUP( ARRAYSNGBOUNDCHK )
	else
		f = PROCLOOKUP( ARRAYBOUNDCHK )
	end if

	proc = astNewCALL( f )

	'' idx
	if( astNewARG( proc, astNewCONV( FB_DATATYPE_INTEGER, NULL, idx, AST_CONVOPT_DONTWARNCONST ) ) = NULL ) then
		exit function
	end if

	'' lbound
	if( lb <> NULL ) then
		if( astNewARG( proc, lb, FB_DATATYPE_INTEGER ) = NULL ) then
			exit function
		end if
	end if

	'' rbound
	if( astNewARG( proc, rb, FB_DATATYPE_INTEGER ) = NULL ) then
		exit function
	end if

	'' linenum
	if( astNewARG( proc, astNewCONSTi( linenum ) ) = NULL ) then
		exit function
	end if

	'' module
	if( astNewARG( proc, astNewCONSTstr( module ) ) = NULL ) then
		exit function
	end if

	function = proc

end function
