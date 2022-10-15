'' intrinsic runtime lib memory functions (ALLOCATE, SWAP, ...)
''
'' chng: oct/2004 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "ast.bi"
#include once "rtl.bi"

	dim shared as FB_RTL_PROCDEF funcdata( 0 to ... ) = _
	{ _
		/' function fb_NullPtrChk _
			( _
				byval p as const any ptr, _
				byval linenum as const long, _
				byval fname as const zstring ptr _
			) as any ptr '/ _
		( _
			@FB_RTL_NULLPTRCHK, NULL, _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_CANBECLONED, _
			3, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_VOID ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_CHAR ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_MemSwap( byref dst as any, byref src as any, byval bytes as const integer ) '/ _
		( _
			@FB_RTL_MEMSWAP, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE, 0 ), _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_MemCopyClear _
			( _
				byref dst as any, _
				byval dstlen as const uinteger, _
				byref src as const any, _
				byval srclen as const uinteger _
			) '/ _
		( _
			@FB_RTL_MEMCOPYCLEAR, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			4, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_UINT ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_VOID ), FB_PARAMMODE_BYREF, FALSE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_UINT ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fre( byval mode as const long = 0 ) as uinteger '/ _
		( _
			@"fre", @"fb_GetMemAvail", _
			FB_DATATYPE_UINT, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, 0 ) _
			} _
		), _
		/' function allocate cdecl( byval size as const uinteger ) as any ptr '/ _
		( _
			@"allocate", @"malloc", _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_UINT ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function callocate cdecl( byval items as const uinteger, byval size as const uinteger = 1 ) as any ptr '/ _
		( _
			@"callocate", @"calloc", _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_UINT ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_UINT ), FB_PARAMMODE_BYVAL, TRUE, 1 ) _
			} _
		), _
		/' function reallocate cdecl( byval p as const any ptr, byval size as const uinteger ) as any ptr '/ _
		( _
			@"reallocate", @"realloc", _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_VOID ) ), FB_PARAMMODE_BYVAL, FALSE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_UINT ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub deallocate cdecl( byval p as const any ptr ) '/ _
		( _
			@"deallocate", @"free", _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_VOID ) ), FB_PARAMMODE_BYVAL, FALSE, 0 ) _
			} _
		), _
		/' function clear cdecl _
			( _
				byref dst as any, _
				byval value as const long = 0, _
				byval bytes as const uinteger _
			) as any ptr '/ _
		( _
			@"clear", @"memset", _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_UINT ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_MemMove cdecl _
			( _
				byref dst as any, _
				byref src as const any, _
				byval bytes as const uinteger_
			) as any ptr '/ _
		( _
			@FB_RTL_MEMMOVE, @"memmove", _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_VOID ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_UINT ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_MemCopy cdecl _
			( _
				byref dst as any, _
				byref src as const any, _
				byval bytes as const uinteger_
			) as any ptr '/ _
		( _
			@FB_RTL_MEMCOPY, @"memcpy", _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_VOID ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_UINT ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' EOL '/ _
		( _
			NULL _
		) _
	}

'':::::
sub rtlMemModInit( )

	rtlAddIntrinsicProcs( @funcdata(0) )

end sub

'':::::
sub rtlMemModEnd( )

	'' procs will be deleted when symbEnd is called

end sub

'':::::
function rtlNullPtrCheck _
	( _
		byval p as ASTNODE ptr, _
		byval linenum as integer, _
		byval module as zstring ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any

	function = NULL

	proc = astNewCALL( PROCLOOKUP( NULLPTRCHK ) )

	'' ptr
	'' we are forcing a CAST to any ptr, so quiet the const checks with AST_CONVOPT_DONTWARNCONST
	if( astNewARG( proc, _
				   astNewCONV( typeAddrOf( FB_DATATYPE_VOID ), NULL, p, AST_CONVOPT_DONTWARNCONST ), _
				   typeAddrOf( FB_DATATYPE_VOID ) ) = NULL ) then
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

'':::::
function rtlMemSwap _
	( _
		byval dst as ASTNODE ptr, _
		byval src as ASTNODE ptr _
	) as integer

	function = FALSE

	dim as ASTNODE ptr proc = astNewCALL( PROCLOOKUP( MEMSWAP ) )

	'' always calc len before pushing the param
	dim as longint bytes = rtlCalcExprLen( dst )

	'' dst as any
	if( astNewARG( proc, dst ) = NULL ) then
		exit function
	end if

	'' src as any
	if( astNewARG( proc, src ) = NULL ) then
		exit function
	end if

	'' byval bytes as integer
	if( astNewARG( proc, astNewCONSTi( bytes ) ) = NULL ) then
		exit function
	end if

	astAdd( proc )

	function = TRUE
end function

'':::::
function rtlMemCopyClear _
	( _
		byval dstexpr as ASTNODE ptr, _
		byval dstlen as longint, _
		byval srcexpr as ASTNODE ptr, _
		byval srclen as longint _
	) as integer

	dim as ASTNODE ptr proc = any

	function = FALSE

	''
	proc = astNewCALL( PROCLOOKUP( MEMCOPYCLEAR ) )

	'' dst as any
	if( astNewARG( proc, dstexpr ) = NULL ) then
		exit function
	end if

	'' byval dstlen as integer
	if( astNewARG( proc, astNewCONSTi( dstlen ) ) = NULL ) then
		exit function
	end if

	'' src as any
	if( astNewARG( proc, srcexpr ) = NULL ) then
		exit function
	end if

	'' byval srclen as integer
	if( astNewARG( proc, astNewCONSTi( srclen ) ) = NULL ) then
		exit function
	end if

	''
	astAdd( proc )

	function = TRUE

end function

function rtlMemNewOp _
	( _
		byval op as integer, _
		byval len_expr as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any
	dim as FBSYMBOL ptr sym = any

	'' try to find an overloaded new()
	if( typeGet( dtype ) = FB_DATATYPE_STRUCT ) then
		assert( (astGetOpSelfVer( op ) = AST_OP_NEW_SELF) or (astGetOpSelfVer( op ) = AST_OP_NEW_VEC_SELF) )
		sym = symbGetCompOpOvlHead( subtype, astGetOpSelfVer( op ) )
		if( sym ) then
			'' Check visibility of the new operator
			if( symbCheckAccess( sym ) = FALSE ) then
				errReport( FB_ERRMSG_ILLEGALMEMBERACCESS )
			end if
		end if
	else
		sym = NULL
	end if

	'' If no new overload was declared, just call allocate()
	if( sym = NULL ) then

		sym = rtlProcLookup( @"allocate", FB_RTL_IDX_ALLOCATE )

		'' maybe had '#undef allocate'?
		if( sym = NULL ) then
			'' rtlProcLookup() already reported the error
			return NULL
		end if
	end if

	proc = astNewCALL( sym )

	'' byval len as uinteger
	if( astNewARG( proc, len_expr ) = NULL ) then
		exit function
	end if

	function = proc
end function

function rtlMemDeleteOp _
	( _
		byval op as integer, _
		byval ptr_expr as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any
	dim as FBSYMBOL ptr sym = any

	'' try to find an overloaded delete()
	if( typeGet( dtype ) = FB_DATATYPE_STRUCT ) then
		assert( (astGetOpSelfVer( op ) = AST_OP_DEL_SELF) or (astGetOpSelfVer( op ) = AST_OP_DEL_VEC_SELF) )
		sym = symbGetCompOpOvlHead( subtype, astGetOpSelfVer( op ) )
		if( sym ) then
			'' Check visibility of the delete operator
			if( symbCheckAccess( sym ) = FALSE ) then
				errReport( FB_ERRMSG_ILLEGALMEMBERACCESS )
			end if
		end if
	else
		sym = NULL
	end if

	'' If no delete overload was declared, just call deallocate()
	if( sym = NULL ) then
		sym = rtlProcLookup( @"deallocate", FB_RTL_IDX_DEALLOCATE )

		'' maybe had '#undef deallocate'?
		if( sym = NULL ) then
			'' rtlProcLookup() already reported the error
			return NULL
		end if
	end if

	proc = astNewCALL( sym )

	'' byval ptr as any ptr
	if( astNewARG( proc, ptr_expr ) = NULL ) then
		exit function
	end if

	function = proc
end function
