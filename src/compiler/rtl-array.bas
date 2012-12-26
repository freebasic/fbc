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
		/' fb_ArrayRedimEx CDECL ( array() as ANY, byval elementlen as integer, _
							   	   byval doclear as integer, byval isvarlen as integer, _
							   	   byval dimensions as integer, ... ) as integer '/ _
		( _
			@FB_RTL_ARRAYREDIM, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			6, _
			{ _
				( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE _
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
					FB_DATATYPE_INVALID, FB_PARAMMODE_VARARG, FALSE _
				) _
			} _
		), _
		/' fb_ArrayRedimPresvEx CDECL ( array() as ANY, byval elementlen as integer, _
					            		byval doclear as integer, byval isvarlen as integer, _
								        byval dimensions as integer, ... ) as integer '/ _
		( _
			@FB_RTL_ARRAYREDIMPRESV, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			6, _
			{ _
				( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE _
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
					FB_DATATYPE_INVALID, FB_PARAMMODE_VARARG, FALSE _
				) _
			} _
		), _
		/' fb_ArrayRedimObj CDECL ( array() as ANY, byval elementlen as integer, _
							   	    byval ctor as sub cdecl( byval this_ as any ptr), _
							   	    byval dtor as sub cdecl( byval this_ as any ptr), _
							   	    byval dimensions as integer, ... ) as integer '/ _
		( _
			@FB_RTL_ARRAYREDIM_OBJ, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			6, _
			{ _
				( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
					FB_DATATYPE_INVALID, FB_PARAMMODE_VARARG, FALSE _
				) _
			} _
		), _
		/' fb_ArrayRedimPresvObj CDECL ( array() as ANY, byval elementlen as integer, _
					            		 byval ctor as cdecl sub(), _
					            		 byval dtor as cdecl sub(), _
								         byval dimensions as integer, ... ) as integer '/ _
		( _
			@FB_RTL_ARRAYREDIMPRESV_OBJ, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			6, _
			{ _
				( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
					FB_DATATYPE_INVALID, FB_PARAMMODE_VARARG, FALSE _
				) _
			} _
		), _
		/' sub fb_ArrayDestructObj( array() as any, byval dtor as sub cdecl() ) '/ _
		( _
			@FB_RTL_ARRAYDESTRUCTOBJ, NULL, _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE _
				), _
				( _
					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
		), _
		/' sub fb_ArrayDestructStr( array() as any ) '/ _
		( _
			@FB_RTL_ARRAYDESTRUCTSTR, NULL, _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE _
				) _
			} _
		), _
		/' sub fb_ArrayClear( array() as any ) '/ _
		( _
			@FB_RTL_ARRAYCLEAR, NULL, _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE _
				) _
			} _
		), _
		/' sub fb_ArrayClearObj( array() as any, byval ctor as sub cdecl(), byval dtor as sub cdecl() ) '/ _
		( _
			@FB_RTL_ARRAYCLEAROBJ, NULL, _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE _
				), _
				( _
					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
		), _
		/' sub fb_ArrayErase( array() as any ) '/ _
		( _
			@FB_RTL_ARRAYERASE, NULL, _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE _
				) _
			} _
		), _
		/' sub fb_ArrayEraseObj( array() as any, byval dtor as sub cdecl() ) '/ _
		( _
			@FB_RTL_ARRAYERASEOBJ, NULL, _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE _
				), _
				( _
					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
		), _
		/' sub fb_ArrayEraseStr( array() as any ) '/ _
		( _
			@FB_RTL_ARRAYERASESTR, NULL, _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE _
				) _
			} _
		), _
		/' fb_ArrayLBound ( array() as ANY, byval dimension as integer ) as integer '/ _
		( _
			@FB_RTL_ARRAYLBOUND, NULL, _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
		), _
		/' fb_ArrayUBound ( array() as ANY, byval dimension as integer ) as integer '/ _
		( _
			@FB_RTL_ARRAYUBOUND, NULL, _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
		), _
		/' fb_ArraySngBoundChk ( byval idx as integer, byval ubound as integer, _
								 byval linenum as integer ) as any ptr '/ _
		( _
			@FB_RTL_ARRAYSNGBOUNDCHK, NULL, _
			typeAddrOf( FB_DATATYPE_VOID ), FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			4, _
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
					typeAddrOf( FB_DATATYPE_CHAR ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
		), _
		/' fb_ArrayBoundChk ( byval idx as integer, byval lbound as integer, _
							  byval ubound as integer, _
							  byval linenum as integer ) as any ptr '/ _
		( _
			@FB_RTL_ARRAYBOUNDCHK, NULL, _
			typeAddrOf( FB_DATATYPE_VOID ), FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			5, _
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
					typeAddrOf( FB_DATATYPE_CHAR ), FB_PARAMMODE_BYVAL, FALSE _
				) _
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
		return astNewCONSTi( 0, FB_DATATYPE_INTEGER )
	end if
	function = astBuildProcAddrof(proc)
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

	assert( symbIsDestructor( dtor ) )

	if( check_access ) then
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

'' fb_ArrayClear* - destruct elements if needed and then re-initialize
function rtlArrayClear _
	( _
		byval arrayexpr as ASTNODE ptr, _
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
		dtor = symbGetCompDtor( subtype )

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
		hCheckDefCtor( ctor, check_access, TRUE )
		hCheckDtor( dtor, check_access, TRUE )

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
	else
		if( dtype = FB_DATATYPE_STRING ) then
			'' fb_ArrayDestructStr() works as fb_ArrayClearStr() too
			proc = astNewCALL( PROCLOOKUP( ARRAYDESTRUCTSTR ) )
		else
			'' fb_ArrayClear()
			proc = astNewCALL( PROCLOOKUP( ARRAYCLEAR ) )
		end if

		'' array() as any
		if( astNewARG( proc, arrayexpr, dtype ) = NULL ) then
			exit function
		end if
	end if

	function = proc
end function

'' fb_ArrayErase* or fb_ArrayDestruct*
'' - destruct elements, and free array if it's dynamic
function rtlArrayErase _
	( _
		byval arrayexpr as ASTNODE ptr, _
		byval is_dynamic as integer, _
		byval check_access as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any
	dim as integer dtype = any
	dim as FBSYMBOL ptr dtor = any

	function = NULL

	dtype = astGetDataType( arrayexpr )

	if( dtype = FB_DATATYPE_STRUCT ) then
		dtor = symbGetCompDtor( astGetSubtype( arrayexpr ) )
	else
		dtor = NULL
	end if

	if( dtor ) then
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

		'' byval dtor as sub cdecl( )
		if( astNewARG( proc, hBuildProcPtr( dtor ) ) = NULL ) then
			exit function
		end if
	else
		if( dtype = FB_DATATYPE_STRING ) then
			if( is_dynamic ) then
				'' fb_ArrayEraseStr()
				proc = astNewCALL( PROCLOOKUP( ARRAYERASESTR ) )
			else
				'' fb_ArrayDestructStr()
				proc = astNewCALL( PROCLOOKUP( ARRAYDESTRUCTSTR ) )
			end if
		else
			if( is_dynamic = FALSE ) then
				'' No dtor, not dynamic = nothing to do
				exit function
			end if

			'' fb_ArrayErase()
			proc = astNewCALL( PROCLOOKUP( ARRAYERASE ) )
		end if

		'' array() as any
		if( astNewARG( proc, arrayexpr, dtype ) = NULL ) then
			exit function
		end if
	end if

	function = proc
end function

function rtlArrayRedim _
	( _
		byval s as FBSYMBOL ptr, _
		byval elementlen as integer, _
		byval dimensions as integer, _
		exprTB() as ASTNODE ptr, _
		byval dopreserve as integer, _
		byval doclear as integer _
	) as integer
	
	'' no const filtering needed... dynamic arrays can't be const
	
    dim as ASTNODE ptr proc = any, expr = any
    dim as FBSYMBOL ptr f = any, ctor = any, dtor = any, subtype = any
    dim as integer dtype = any

    function = FALSE

    dtype = symbGetFullType( s )

	'' only objects get instantiated
	select case typeGet( dtype )
	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		subtype = symbGetSubtype( s )
		ctor = symbGetCompDefCtor( subtype )
		dtor = symbGetCompDtor( subtype )

		'' Assuming there aren't any other ctors if there is no default one,
		'' because if it were possible to declare such a dynamic array,
		'' the rtlib couldn't REDIM it.
		assert( iif( ctor = NULL, (symbGetCompCtorHead( subtype ) = NULL) or (errGetCount( ) > 0), TRUE ) )
	case else
		ctor = NULL
		dtor = NULL
	end select

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
	expr = astNewVAR( s, 0, dtype )
    if( astNewARG( proc, expr, dtype ) = NULL ) then
    	exit function
    end if

	'' byval element_len as integer
	expr = astNewCONSTi( elementlen, FB_DATATYPE_INTEGER )
	if( astNewARG( proc, expr, FB_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

	if( (ctor = NULL) and (dtor = NULL) ) then
		'' byval doclear as integer
		if( astNewARG( proc, _
					   astNewCONSTi( doclear, FB_DATATYPE_INTEGER ), _
					   FB_DATATYPE_INTEGER ) = NULL ) then
    		exit function
    	end if

		'' byval isvarlen as integer
		if( astNewARG( proc, _
					   astNewCONSTi( (dtype = FB_DATATYPE_STRING), _
									 FB_DATATYPE_INTEGER ), _
					   FB_DATATYPE_INTEGER ) = NULL ) then
    		exit function
    	end if
    else
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
    end if

	'' byval dimensions as integer
	if( astNewARG( proc, _
				   astNewCONSTi( dimensions, FB_DATATYPE_INTEGER ), _
				   FB_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

	'' ...
	for i as integer = 0 to dimensions-1

		'' lbound
		expr = exprTB(i, 0)

    	'' convert to int
    	if( astGetDataType( expr ) <> FB_DATATYPE_INTEGER ) then
    		expr = astNewCONV( FB_DATATYPE_INTEGER, NULL, expr )
    	end if

		if( astNewARG( proc, expr, FB_DATATYPE_INTEGER ) = NULL ) then
    		exit function
    	end if

		'' ubound
		expr = exprTB(i, 1)

    	'' convert to int
    	if( astGetDataType( expr ) <> FB_DATATYPE_INTEGER ) then
    		expr = astNewCONV( FB_DATATYPE_INTEGER, NULL, expr )
    	end if

		if( astNewARG( proc, expr, FB_DATATYPE_INTEGER ) = NULL ) then
    		exit function
    	end if
	next

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
	if( astNewARG( proc, _
					 astNewCONV( FB_DATATYPE_INTEGER, NULL, idx ), _
					 FB_DATATYPE_INTEGER ) = NULL ) then
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
	if( astNewARG( proc, astNewCONSTi( linenum, FB_DATATYPE_INTEGER ), FB_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    '' module
	if( astNewARG( proc, astNewCONSTstr( module ) ) = NULL ) then
    	exit function
    end if

    function = proc

end function
