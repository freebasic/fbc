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
		/' fb_ArrayErase ( array() as ANY, byval isvarlen as integer ) as integer '/ _
		( _
			@FB_RTL_ARRAYERASE, NULL, _
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
		/' fb_ArrayEraseObj ( array() as ANY, byval dtor as sub cdecl() ) as integer '/ _
		( _
			@FB_RTL_ARRAYERASE_OBJ, NULL, _
	 		FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
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
		/' fb_ArrayClear ( array() as ANY, byval isvarlen as integer ) as integer '/ _
		( _
			@FB_RTL_ARRAYCLEAR, NULL, _
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
		/' fb_ArrayClearObj ( array() as ANY, byval ctor as sub cdecl(), byval dtor as sub cdecl(), _
							  byval dofill as integer ) as integer '/ _
		( _
			@FB_RTL_ARRAYCLEAR_OBJ, NULL, _
	 		FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		4, _
	 		{ _
	 			( _
	 				FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
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
		/' fb_ArrayStrErase ( array() as any ) as void '/ _
		( _
			@FB_RTL_ARRAYSTRERASE, NULL, _
	 		FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE _
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


'':::::
sub rtlArrayModInit( )

	rtlAddIntrinsicProcs( @funcdata(0) )

end sub

'':::::
sub rtlArrayModEnd( )

	'' procs will be deleted when symbEnd is called

end sub

private function hBuildProcPtr(byval proc as FBSYMBOL ptr) as ASTNODE ptr
	if( proc = NULL ) then
		return astNewCONSTi( 0, FB_DATATYPE_INTEGER )
	end if
	function = astBuildProcAddrof(proc)
end function

'':::::
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
    dim as FBSYMBOL ptr f = any, ctor = any, dtor = any
    dim as integer dtype = any

    function = FALSE

    dtype = symbGetFullType( s )

	'' only objects get instantiated
	select case typeGet( dtype )
	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		ctor = symbGetCompDefCtor( symbGetSubtype( s ) )
		dtor = symbGetCompDtor( symbGetSubtype( s ) )
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
		if( ctor <> NULL ) then
			if( symbGetProcMode( ctor ) <> FB_FUNCMODE_CDECL ) then
				errReport( FB_ERRMSG_REDIMCTORMUSTBECDEL )
			end if
		end if

		if( dtor <> NULL ) then
			if( symbGetProcMode( dtor ) <> FB_FUNCMODE_CDECL ) then
				errReport( FB_ERRMSG_REDIMCTORMUSTBECDEL )
			end if
		end if

		'' byval ctor as sub()
		if( astNewARG( proc, hBuildProcPtr( ctor ) ) = NULL ) then
    		exit function
    	end if

		'' byval dtor as sub()
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

'':::::
function rtlArrayErase _
	( _
		byval arrayexpr as ASTNODE ptr, _
		byval check_access as integer _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any
    dim as integer dtype = any
    dim as FBSYMBOL ptr dtor = any

	function = NULL

	dtype = astGetDataType( arrayexpr )

	''
	select case as const dtype
	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		dtor = symbGetCompDtor( astGetSubtype( arrayexpr ) )
    case else
    	dtor = NULL
    end select

    if( dtor = NULL ) then
    	proc = astNewCALL( PROCLOOKUP( ARRAYERASE ) )
    else
    	proc = astNewCALL( PROCLOOKUP( ARRAYERASE_OBJ ) )
    end if

    '' array() as ANY
    if( astNewARG( proc, arrayexpr, dtype ) = NULL ) then
    	exit function
    end if

	if( dtor = NULL ) then
		'' byval isvarlen as integer
		if( astNewARG( proc, _
					   astNewCONSTi( dtype = FB_DATATYPE_STRING, _
					   				 FB_DATATYPE_INTEGER ), _
					   FB_DATATYPE_INTEGER ) = NULL ) then
			exit function
		end if
	else
		if( check_access ) then
			if( symbCheckAccess( dtor ) = FALSE ) then
				errReport( FB_ERRMSG_NOACCESSTODTOR )
			end if
		end if

		if( symbGetProcMode( dtor ) <> FB_FUNCMODE_CDECL ) then
			errReport( FB_ERRMSG_REDIMCTORMUSTBECDEL )
		end if

		'' byval dtor as sub()
		if( astNewARG( proc, hBuildProcPtr( dtor ) ) = NULL ) then
    		exit function
    	end if
    end if

	function = proc

end function

'':::::
function rtlArrayClear _
	( _
		byval arrayexpr as ASTNODE ptr, _
		byval dofill as integer, _
		byval check_access as integer _
	) as ASTNODE ptr
	
	'' no const filtering needed, clear is for dynamic, can't be const...
	
    dim as ASTNODE ptr proc = any
    dim as integer dtype = any
    dim as FBSYMBOL ptr ctor = any, dtor = any

    function = NULL

    dtype = astGetDataType( arrayexpr )

	''
	select case typeGet( dtype )
	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		ctor = symbGetCompDefCtor( astGetSubtype( arrayexpr ) )
		dtor = symbGetCompDtor( astGetSubtype( arrayexpr ) )
	case else
		ctor = NULL
		dtor = NULL
	end select

    if( (ctor = NULL) and (dtor = NULL) ) then
    	proc = astNewCALL( PROCLOOKUP( ARRAYCLEAR ) )
    else
    	proc = astNewCALL( PROCLOOKUP( ARRAYCLEAR_OBJ ) )
    end if

    '' array() as ANY
    if( astNewARG( proc, arrayexpr, dtype ) = NULL ) then
    	exit function
    end if

	if( (ctor = NULL) and (dtor = NULL) ) then
		'' byval isvarlen as integer
		if( astNewARG( proc, _
					   astNewCONSTi( dtype = FB_DATATYPE_STRING, _
					   				 FB_DATATYPE_INTEGER ), _
					   FB_DATATYPE_INTEGER ) = NULL ) then
			exit function
		end if
	else
		if( check_access ) then
			if( symbCheckAccess( dtor ) = FALSE ) then
				errReport( FB_ERRMSG_NOACCESSTODTOR )
			end if
		end if

		if( ctor <> NULL ) then
			if( symbGetProcMode( ctor ) <> FB_FUNCMODE_CDECL ) then
				errReport( FB_ERRMSG_REDIMCTORMUSTBECDEL )
			end if
		end if

		if( dtor <> NULL ) then
			if( symbGetProcMode( dtor ) <> FB_FUNCMODE_CDECL ) then
				errReport( FB_ERRMSG_REDIMCTORMUSTBECDEL )
			end if
		end if

		'' byval ctor as sub()
		if( astNewARG( proc, hBuildProcPtr( ctor ) ) = NULL ) then
    		exit function
    	end if

		'' byval dtor as sub()
		if( astNewARG( proc, hBuildProcPtr( dtor ) ) = NULL ) then
    		exit function
    	end if

		'' byval dofill as integer
		if( astNewARG( proc, astNewCONSTi( dofill, FB_DATATYPE_INTEGER ) ) = NULL ) then
    		exit function
    	end if
    end if

    function = proc

end function

'':::::
function rtlArrayStrErase _
	( _
		byval arrayexpr as ASTNODE ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any

	function = NULL

	''
    proc = astNewCALL( PROCLOOKUP( ARRAYSTRERASE ) )

    '' array() as ANY
    if( astNewARG( proc, arrayexpr ) = NULL ) then
    	exit function
    end if

	function = proc

end function

'':::::
function rtlArrayBound _
	( _
		byval sexpr as ASTNODE ptr, _
		byval dimexpr as ASTNODE ptr, _
		byval islbound as integer _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any
    dim as FBSYMBOL ptr f = any

	function = NULL

	''
	if( islbound ) then
		f = PROCLOOKUP( ARRAYLBOUND )
	else
		f = PROCLOOKUP( ARRAYUBOUND )
	end if
    proc = astNewCALL( f )

    '' array() as ANY
    if( astNewARG( proc, sexpr ) = NULL ) then
    	exit function
    end if

	'' byval dimension as integer
	if( astNewARG( proc, dimexpr ) = NULL ) then
		exit function
	end if

    ''
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

