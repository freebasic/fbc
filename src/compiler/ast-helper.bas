'' AST misc helpers/builders
''
'' chng: sep/2006 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "ast.bi"
#include once "lex.bi"
#include once "rtl.bi"

''
'' vars
''

function astBuildVarAssign _
	( _
		byval lhs as FBSYMBOL ptr, _
		byval rhs as integer, _
		byval options as integer _
	) as ASTNODE ptr

	function = astNewASSIGN( astNewVAR( lhs ), astNewCONSTi( rhs ), options )

end function

function astBuildVarAssign _
	( _
		byval lhs as FBSYMBOL ptr, _
		byval rhs as ASTNODE ptr, _
		byval options as integer _
	) as ASTNODE ptr

	function = astNewASSIGN( astNewVAR( lhs ), rhs, options )

end function

function astBuildFakeWstringAccess( byval sym as FBSYMBOL ptr ) as ASTNODE ptr
	assert( symbGetIsWstring( sym ) )
	function = astNewDEREF( astNewVAR( sym ) )
end function

function astBuildFakeWstringAssign _
	( _
		byval sym as FBSYMBOL ptr, _
		byval expr as ASTNODE ptr, _
		byval options as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr t = any

	assert( symbGetIsWstring( sym ) )
	t = NULL

	'' side-effect?
	if( astHasSideFx( expr ) ) then
		t = astNewLINK( t, astRemSideFx( expr ), AST_LINK_RETURN_RIGHT )
	end if

	assert( astGetDataType( expr ) = FB_DATATYPE_WCHAR )

	'' wcharptr = WstrAlloc( WstrLen( expr ) )
	t = astNewLINK( t, _
	                astBuildVarAssign( sym, rtlWstrAlloc( rtlWstrLen( astCloneTree( expr ) ) ), options ), _
	                AST_LINK_RETURN_NONE )

	'' *wcharptr = expr
	t = astNewLINK( t, _
	                astNewASSIGN( astBuildFakeWstringAccess( sym ), expr, options ), _
	                AST_LINK_RETURN_RIGHT )

	function = t
end function

'':::::
function astBuildVarInc _
	( _
		byval lhs as FBSYMBOL ptr, _
		byval rhs as integer _
	) as ASTNODE ptr

	dim as AST_OPOPT options = any
	dim as AST_OP op = any

	options = AST_OPOPT_DEFAULT
	if( typeIsPtr( symbGetType( lhs ) ) ) then
		options or= AST_OPOPT_LPTRARITH
	end if

	if( rhs > 0 ) then
		op = AST_OP_ADD_SELF
	else
		op = AST_OP_SUB_SELF
		rhs = -rhs
	end if

	function = astNewSelfBOP( op, astNewVAR( lhs ), _
	                          astNewCONSTi( rhs ), NULL, options )

end function

function astBuildVarDeref( byval sym as FBSYMBOL ptr ) as ASTNODE ptr
	function = astNewDEREF( astNewVAR( sym ) )
end function

function astBuildVarAddrof( byval sym as FBSYMBOL ptr ) as ASTNODE ptr
	function = astNewADDROF( astNewVAR( sym ) )
end function

function astBuildVarDtorCall overload _
	( _
		byval varexpr as ASTNODE ptr _
	) as ASTNODE ptr

	if( astGetDataType( varexpr ) = FB_DATATYPE_STRING ) then
		function = rtlStrDelete( varexpr )
	elseif( typeHasDtor( varexpr->dtype, varexpr->subtype ) ) then
		function = astBuildDtorCall( varexpr->subtype, varexpr )
	end if

end function

function astBuildVarDtorCall overload _
	( _
		byval s as FBSYMBOL ptr, _
		byval check_access as integer _
	) as ASTNODE ptr

	'' assuming conditions were checked already
	function = NULL

	assert( symbIsRef( s ) = FALSE )

	'' array? dims can be -1 with "DIM foo()" arrays..
	if( symbGetArrayDimensions( s ) <> 0 ) then
		'' destruct and/or free array, if needed
		function = rtlArrayErase( astNewVAR( s ), symbIsDynamic( s ), check_access )
	else
		select case symbGetType( s )
		'' dyn string?
		case FB_DATATYPE_STRING
			function = rtlStrDelete( astNewVAR( s ) )

		'' wchar ptr marked as "dynamic wstring"?
		case typeAddrOf( FB_DATATYPE_WCHAR )
			assert( symbGetIsWstring( s ) ) '' This check should be done in symbGetVarHasDtor() already
			'' It points to a dynamically allocated wchar buffer
			'' that must be deallocated.
			function = rtlStrDelete( astNewVAR( s ) )

		case else
			'' UDT var with dtor?
			if( symbHasDtor( s ) ) then
				if( check_access ) then
					'' Check visibility of the destructor
					if( symbCheckAccess( symbGetCompDtor1( symbGetSubtype( s ) ) ) = FALSE ) then
						errReport( FB_ERRMSG_NOACCESSTODTOR )
					end if
				end if
				function = astBuildDtorCall( symbGetSubtype( s ), astNewVAR( s ) )
			end if
		end select
	end if

end function

'' Build a field access on the target:
''    n = *cptr( dtype ptr, @n + offset )
'' If offset = 0, then it's basically just a type cast.
function astBuildDerefAddrOf overload _
	( _
		byval n as ASTNODE ptr, _
		byval offsetexpr as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval maybeafield as FBSYMBOL ptr _
	) as ASTNODE ptr

	n = astNewADDROF( n )

	'' Note: should not do +0 here, because astNewBOP() won't (yet)
	'' remove it immediately. And a +0 BOP between the DEREF/ADDROF prevents
	'' those being folded immediately, which affects other parts in the
	'' compiler that expects VARs and is suddenly seeing DEREF(ADDROF(VAR)),
	'' e.g. DEREF'ed zstring ptrs behave differently than zstring VARs in
	'' many places. This matters only because some astBuildDerefAddrOf()
	'' callers (i.e. astTypeIniFlush()) use it even when assigning to normal
	'' variables, while it should only be used for field accesses...
	if( offsetexpr ) then
		n = astNewBOP( AST_OP_ADD, n, offsetexpr )
	end if

	'' Don't warn on CONST qualifier changes, astBuildDerefAddrOf() is only
	'' called for internal expressions in:
	''      - astBuildVarField(),
	''      - hShallowCopy()
	''      - hCallCtorList()
	''      - cDynamicArrayIndex()
	''      - cVariableEx()
	''      - hAssignDynamicArray()
	'' Except:
	''      - astTypeIniFlush(), HOWEVER, astNewASSIGN() does it's own
	''        checks and calls astNewCONV()

	n = astNewCONV( typeAddrOf( dtype ), subtype, n, AST_CONVOPT_DONTCHKPTR or AST_CONVOPT_DONTWARNCONST )
	n = astNewDEREF( n )

	if( maybeafield ) then
		if( symbIsField( maybeafield ) ) then
			n = astNewFIELD( n, maybeafield )
		end if
	end if

	function = n
end function

function astBuildDerefAddrOf overload _
	( _
		byval n as ASTNODE ptr, _
		byval offset as longint, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval maybeafield as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr offsetexpr = any

	if( offset = 0 ) then
		offsetexpr = NULL
	else
		offsetexpr = astNewCONSTi( offset )
	end if

	function = astBuildDerefAddrOf( n, offsetexpr, dtype, subtype, maybeafield )
end function

function astBuildVarField _
	( _
		byval sym as FBSYMBOL ptr, _
		byval fld as FBSYMBOL ptr, _
		byval offset as longint _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any

	'' Do implicit DEREF if it's a byref symbol
	if( symbIsParamVarByRef( sym ) or symbIsImport( sym ) ) then
		n = astNewDEREF( astNewVAR( sym, , typeAddrOf( symbGetFullType( sym ) ), symbGetSubtype( sym ) ) )
	else
		n = astNewVAR( sym )
	end if

	if( fld ) then
		offset += symbGetOfs( fld )
		n = astBuildDerefAddrOf( n, offset, symbGetFullType( fld ), symbGetSubtype( fld ), fld )
	else
		n = astBuildDerefAddrOf( n, offset, symbGetFullType( sym ), symbGetSubtype( sym ), NULL )
	end if

	function = n
end function

function astBuildTempVarClear( byval sym as FBSYMBOL ptr ) as ASTNODE ptr
	'' Don't need to clear if it's a STATIC, it will be initialized on
	'' startup, and e.g. we should definitely not overwrite a string var
	'' that was already initialized/used (which could happen with a STATIC),
	'' because then we'd leak the string memory if any was allocated.
	if( symbIsStatic( sym ) ) then
		return NULL
	end if

	assert( symbIsShared( sym ) = FALSE )

	'' Usually this will be called on TEMP vars only, except if their
	'' lifetime was extended and the TEMP flag was removed (e.g. done by
	'' WITH compound).

	'' Clear variable's memory
	function = astNewMEM( AST_OP_MEMCLEAR, astNewVAR( sym ), _
	                      astNewCONSTi( symbGetLen( sym ) ) )
end function

''
'' loops
''

'' While Counter:
''
''     CNT = INIVALUE
''     WHILE( CNT )
''        <user code>
''        CNT -= 1
''     WEND

function astBuildWhileCounterBegin _
	( _
		byval tree as ASTNODE ptr, _
		byval cnt as FBSYMBOL ptr, _
		byval label as FBSYMBOL ptr, _
		byval exitlabel as FBSYMBOL ptr, _
		byval initexpr as ASTNODE ptr, _
		byval flush_label as integer _
	) as ASTNODE ptr

	'' counter = initvalue
	tree = astNewLINK( tree, astBuildVarAssign( cnt, initexpr ), AST_LINK_RETURN_NONE )

	'' do
	tree = astNewLINK( tree, astNewLABEL( label, flush_label ), AST_LINK_RETURN_NONE )

	'' if( counter = 0 ) then
	''     goto exitlabel
	'' end if
	tree = astNewLINK( tree, _
		astBuildBranch( _
			astNewBOP( AST_OP_EQ, astNewVAR( cnt ), astNewCONSTi( 0 ) ), _
			exitlabel, TRUE ), AST_LINK_RETURN_NONE )

	function = tree
end function

function astBuildWhileCounterEnd _
	( _
		byval tree as ASTNODE ptr, _
		byval cnt as FBSYMBOL ptr, _
		byval label as FBSYMBOL ptr, _
		byval exitlabel as FBSYMBOL ptr, _
		byval flush_label as integer _
	) as ASTNODE ptr

	'' counter -= 1
	tree = astNewLINK( tree, astBuildVarInc( cnt, -1 ), AST_LINK_RETURN_NONE )

	'' goto label
	tree = astNewLINK( tree, astNewBranch( AST_OP_JMP, label ), AST_LINK_RETURN_NONE )

	'' loop
	tree = astNewLINK( tree, astNewLABEL( exitlabel, flush_label ), AST_LINK_RETURN_NONE )

	function = tree
end function

'' For:
''
''     CNT = INIVALUE
''     DO
''         <user code>
''         CNT += 1
''     LOOP UNTIL CNT=ENDVALUE

function astBuildForBegin _
	( _
		byval tree as ASTNODE ptr, _
		byval cnt as FBSYMBOL ptr, _
		byval label as FBSYMBOL ptr, _
		byval inivalue as integer, _
		byval flush_label as integer _
	) as ASTNODE ptr

	'' cnt = 0
	tree = astNewLINK( tree, astBuildVarAssign( cnt, inivalue ), AST_LINK_RETURN_NONE )

	'' do
	tree = astNewLINK( tree, astNewLABEL( label, flush_label ), AST_LINK_RETURN_NONE )

	function = tree
end function

function astBuildForEnd _
	( _
		byval tree as ASTNODE ptr, _
		byval cnt as FBSYMBOL ptr, _
		byval label as FBSYMBOL ptr, _
		byval endvalue as ASTNODE ptr _
	) as ASTNODE ptr

	'' counter += stepvalue
	tree = astNewLINK( tree, astBuildVarInc( cnt, 1 ), AST_LINK_RETURN_NONE )

	'' if( counter = endvalue ) then
	''     goto label
	'' end if
	tree = astNewLINK( tree, _
		astBuildBranch( _
			astNewBOP( AST_OP_EQ, astNewVAR( cnt ), endvalue ), _
			label, FALSE ), AST_LINK_RETURN_NONE )

	function = tree
end function

''
'' calls
''

function astBuildVtableLookup _
	( _
		byval proc as FBSYMBOL ptr, _
		byval thisexpr as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr p = any
	dim as integer vtableindex = any

	if( symbIsVirtual( proc ) ) then
		vtableindex = symbProcGetVtableIndex( proc )
		assert( vtableindex > 0 )

		'' calling virtual method
		''    method( this )
		'' becomes
		''    (*(this.vptr[vtableindex]))( this )
		'' i.e. the procptr must be read out from the vtable based on
		'' the vtable index of this method, and then it is called.
		''
		'' The this.vptr points to the 3rd element of the vtable,
		'' but the vtable index actually is absolute, not relative to
		'' the 3rd element, so it actually should be:
		''    (*(this.vptr[vtableindex-2]))( this )
		''
		'' Also, the vptr always is at the top of the object,
		'' so we can just do:
		''    (*((*cptr( any ptr ptr ptr, @this ))[vtableindex-2]))( this )

		'' Get the vtable pointer of type ANY PTR PTR
		p = astCloneTree( thisexpr )
		p = astNewADDROF( p )
		p = astNewCONV( typeMultAddrOf( FB_DATATYPE_VOID, 3 ), NULL, p, AST_CONVOPT_DONTCHKPTR )
		p = astNewDEREF( p )

		'' Apply the index
		p = astNewBOP( AST_OP_ADD, p, astNewCONSTi( vtableindex - 2 ), _
		               NULL, AST_OPOPT_DEFAULT or AST_OPOPT_DOPTRARITH )

		'' Deref to get the procptr stored in that vtable slot
		p = astNewDEREF( p )

		'' Cast to proper procptr type
		'' (this is important for C/LLVM backends, which are pretty strict about types)
		p = astNewCONV( typeAddrOf( FB_DATATYPE_FUNCTION ), symbAddProcPtrFromFunction( proc ), p )

		'' null pointer checking for ABSTRACTs
		'' (in case it wasn't overridden)
		if( env.clopt.nullptrchk ) then
			if( symbIsAbstract( proc ) ) then
				p = astBuildPTRCHK( p )
			end if
		end if
	else
		'' Calling normal non-virtual method, nothing to do
		p = NULL
	end if

	function = p
end function

function astBuildCall _
	( _
		byval proc as FBSYMBOL ptr, _
		byval arg1 as ASTNODE ptr, _
		byval arg2 as ASTNODE ptr, _
		byval arg3 as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr p = any, ptrexpr = any

	'' astBuildCall() is used to call operator overloads - they can be
	'' virtual methods, at least for self-ops.
	if( symbIsVirtual( proc ) ) then
		'' The first arg should be the THIS ptr
		assert( symbIsMethod( proc ) )
		assert( astGetDataType( arg1 ) = FB_DATATYPE_STRUCT )
		assert( astGetSubtype( arg1 ) = symbGetNamespace( proc ) )

		ptrexpr = astBuildVtableLookup( proc, arg1 )
	else
		ptrexpr = NULL
	end if

	p = astNewCALL( proc, ptrexpr )

	if( arg1 ) then
		if( astNewARG( p, arg1 ) = NULL ) then
			return NULL
		end if
	end if

	if( arg2 ) then
		if( astNewARG( p, arg2 ) = NULL ) then
			return NULL
		end if
	end if

	if( arg3 ) then
		if( astNewARG( p, arg3 ) = NULL ) then
			return NULL
		end if
	end if

	'' Take care of functions returning BYREF
	p = astBuildByrefResultDeref( p )

	function = p
end function

function astBuildCtorCall _
	( _
		byval sym as FBSYMBOL ptr, _
		byval thisexpr as ASTNODE ptr _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr ctor = any
	dim as ASTNODE ptr proc = any
	dim as integer params = any

	ctor = symbGetCompDefCtor( sym )
	if( ctor = NULL ) then
		return NULL
	end if

	proc = astNewCALL( ctor )

	astNewARG( proc, thisexpr )

	'' add the optional params, if any
	params = symbGetProcParams( ctor ) - 1
	do while( params > 0 )
		astNewARG( proc, NULL )
		params -= 1
	loop

	function = proc

end function

function astBuildDtorCall _
	( _
		byval sym as FBSYMBOL ptr, _
		byval thisexpr as ASTNODE ptr, _
		byval ignore_virtual as integer _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr dtor = any
	dim as ASTNODE ptr callexpr = any

	'' Can be virtual
	dtor = symbGetCompDtor1( sym )
	if( ignore_virtual ) then
		callexpr = astNewCALL( dtor )
	else
		callexpr = astNewCALL( dtor, astBuildVtableLookup( dtor, thisexpr ) )
	end if

	astNewARG( callexpr, thisexpr )

	function = callexpr
end function

private function astFakeInstPtr( byval subtype as FBSYMBOL ptr ) as ASTNODE ptr
	assert( symbIsStruct( subtype ) )
	function = astNewCONSTi( 0, typeAddrOf( FB_DATATYPE_STRUCT ), subtype )
end function

function astPatchCtorCall _
	( _
		byval procexpr as ASTNODE ptr, _
		byval thisexpr as ASTNODE ptr _
	) as ASTNODE ptr

	'' Note: ctors cannot be virtual, so there's no need to worry about
	'' updating any vtable lookup here (which would use the thisexpr too)
	assert( astIsCALL( procexpr ) )
	assert( symbProcGetVtableIndex( procexpr->sym ) = 0 )

	'' replace the instance pointer
	astReplaceInstanceArg( procexpr, thisexpr )

	function = procexpr
end function

function astCALLCTORToCALL _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr sym = any
	dim as ASTNODE ptr procexpr = any

	assert( astIsCALLCTOR( n ) )
	assert( astIsVAR( n->r ) )

	sym = astGetSymbol( n->r )

	'' the function call is in the left leaf
	procexpr = n->l

	'' Update the CALL: Replace the old THIS ptr ARG with a NULL ptr (given
	'' BYVAL to the BYREF THIS param), since the temp var will be deleted.
	assert( symbGetType( sym ) = FB_DATATYPE_STRUCT )
	astReplaceInstanceArg( procexpr, astFakeInstPtr( symbGetSubtype( sym ) ), FB_PARAMMODE_BYVAL )

	'' remove right leaf (the VAR access on the temp var)
	astDelTree( n->r )

	'' if the temp has a dtor it was added to the dtor list,
	'' remove it too
	astDtorListDel( sym )

	'' Delete the temp var itself
	symbDelSymbol( sym )

	'' remove the CALLCTOR node
	astDelNode( n )

	function = procexpr
end function

function astBuildImplicitCtorCall _
	( _
		byval subtype as FBSYMBOL ptr, _
		byval expr as ASTNODE ptr, _
		byval arg_mode as FB_PARAMMODE, _
		byref is_ctorcall as integer _
	) as ASTNODE ptr

	dim as integer err_num = any
	dim as FBSYMBOL ptr proc = any

	proc = symbFindCtorOvlProc( subtype, expr, arg_mode, @err_num )
	if( proc = NULL ) then
		is_ctorcall = FALSE

		if( err_num <> FB_ERRMSG_OK ) then
			errReportParam( symbGetCompCtorHead( subtype ), 0, NULL, err_num )
			return NULL
		end if

		'' could be a shallow copy..
		return expr
	end if

	'' Check visibility of the constructor
	if( symbCheckAccess( proc ) = FALSE ) then
		errReport( FB_ERRMSG_NOACCESSTOCTOR )
	end if

	'' build a ctor call
	dim as ASTNODE ptr procexpr = astNewCALL( proc )

	'' Use a fake THIS ptr for now,
	'' a NULL ptr given BYVAL to the BYREF THIS param
	astNewARG( procexpr, astFakeInstPtr( subtype ), , FB_PARAMMODE_BYVAL )

	astNewARG( procexpr, expr, , arg_mode )

	'' add the optional params, if any
	dim as integer params = symbGetProcParams( proc ) - 2
	do while( params > 0 )
		astNewARG( procexpr, NULL )
		params -= 1
	loop

	is_ctorcall = TRUE
	function = procexpr

end function

'':::::
function astBuildImplicitCtorCallEx _
	( _
		byval sym as FBSYMBOL ptr, _
		byval expr as ASTNODE ptr, _
		byval arg_mode as FB_PARAMMODE, _
		byref is_ctorcall as integer _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr subtype = any

	subtype = symbGetSubType( sym )

	'' check ctor call
	if( astIsCALLCTOR( expr ) ) then
		if( symbGetSubtype( expr ) = subtype ) then
			is_ctorcall = TRUE
			'' remove the the anon/temp instance
			return astCALLCTORToCALL( expr )
		end if
	end if

	'' try calling any ctor with the expression
	function = astBuildImplicitCtorCall( subtype, expr, arg_mode, is_ctorcall )

end function

''
'' procs
''

function astBuildProcAddrof( byval proc as FBSYMBOL ptr ) as ASTNODE ptr
	symbSetIsAccessed( proc )
	function = astNewADDROF( astNewVAR( proc ) )
end function

'' For accessing the function result from within the function
function astBuildProcResultVar _
	( _
		byval proc as FBSYMBOL ptr, _
		byval res as FBSYMBOL ptr _
	) as ASTNODE ptr

	'' proc returns UDT in hidden byref UDT param?
	if( symbProcReturnsOnStack( proc ) ) then
		function = astNewDEREF( astNewVAR( res, 0, typeAddrOf( FB_DATATYPE_STRUCT ), symbGetSubtype( res ) ) )
	else
		function = astNewVAR( res )
	end if

end function

''
'' misc
''

'':::::
function astBuildTypeIniCtorList _
	( _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr tree

	tree = astTypeIniBegin( symbGetFullType( sym ), symbGetSubtype( sym ), TRUE )

	astTypeIniAddCtorList( tree, sym, symbGetArrayElements( sym ) )

	astTypeIniEnd( tree, TRUE )

	function = tree

end function

'':::::
function astBuildMultiDeref _
	( _
		byval cnt as integer, _
		byval expr as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

	do while( cnt > 0 )
		if( typeIsPtr( dtype ) = FALSE ) then
			if( symb.globOpOvlTb(AST_OP_DEREF).head = NULL ) then
				errReport( FB_ERRMSG_EXPECTEDPOINTER, TRUE )
				exit do
			end if

			'' check op overloading
			dim as FBSYMBOL ptr proc = any
			dim as FB_ERRMSG err_num = any

			proc = symbFindUopOvlProc( AST_OP_DEREF, expr, @err_num )
			if( proc <> NULL ) then
				'' build a proc call
				expr = astBuildCall( proc, expr )
				if( expr = NULL ) then
					return NULL
				end if

				dtype = astGetFullType( expr )
				subtype = astGetSubType( expr )
			else
				errReport( FB_ERRMSG_EXPECTEDPOINTER, TRUE )
				exit do
			end if
		else
			dtype = typeDeref( dtype )

			'' incomplete type?
			select case typeGet( dtype )
			case FB_DATATYPE_VOID, FB_DATATYPE_FWDREF
				errReport( FB_ERRMSG_INCOMPLETETYPE, TRUE )
				'' error recovery: fake a type
				dtype = FB_DATATYPE_BYTE

			'' Function pointer?
			case FB_DATATYPE_FUNCTION
				'' Disallow dereferencing them with '*', because that would only access
				'' the function's code, that's not a good idea.
				'' (This is only a parser check though, using cast() it's still possible)
				errReport( FB_ERRMSG_TYPEMISMATCH, TRUE )
				dtype = FB_DATATYPE_BYTE

			end select

			'' null pointer checking
			if( env.clopt.nullptrchk ) then
				expr = astBuildPTRCHK( expr )
			end if

			expr = astNewDEREF( expr, dtype, subtype )
		end if

		cnt -= 1
	loop

	function = expr

end function

''
'' arrays
''

'':::::
function astBuildArrayDescIniTree _
	( _
		byval desc as FBSYMBOL ptr, _
		byval array as FBSYMBOL ptr, _
		byval array_expr as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr tree = any
	dim as integer dtype = any, dimensions = any, max_dimensions = any, flags = 0
	dim as FBSYMBOL ptr elm = any, dimtb = any, subtype = any

	'' COMMON or EXTERN? Cannot be initialized
	if( symbIsCommon( array ) or symbIsExtern( array ) ) then
		return NULL
	end if

	assert( symbIsDescriptor( desc ) )
	assert( symbGetType( desc ) = FB_DATATYPE_STRUCT )
	assert( symbIsDescriptor( desc->subtype ) )
	assert( symbIsParamVarBydesc( array ) = FALSE )
	assert( symbIsVar( desc ) or symbIsField( desc ) )

	tree = astTypeIniBegin( symbGetFullType( desc ), symbGetSubtype( desc ), not symbIsField( desc ), symbGetOfs( desc ) )

	dtype = symbGetFullType( array )
	subtype = symbGetSubType( array )

	elm = symbGetUDTSymbTbHead( symbGetSubtype( desc ) )
	assert( symbIsField( elm ) )

	if( symbIsDynamic( array ) ) then
		'' Dynamic arrays: Initializing the descriptor to its initial
		'' "unallocated" state, ptr = NULL
		array_expr = astNewCONSTi( 0, typeAddrOf( dtype ), subtype )
	else
		'' Fixed-size arrays: Initializing the descriptor to point to
		'' the existing array.
		if( array_expr ) then
			'' For fields, the access expression must be given
			assert( symbIsField( array ) )
		else
			'' For vars, we just build it here
			assert( symbIsVar( array ) )
			assert( array_expr = NULL )
			array_expr = astNewVAR( array )
		end if
		array_expr = astNewADDROF( array_expr )
		flags or= FBARRAY_FLAGS_FIXED_LEN
	end if

	astTypeIniScopeBegin( tree, desc, FALSE )

	'' .data = @array(0) + diff
	astTypeIniAddAssign( tree, _
		astNewBOP( AST_OP_ADD, astCloneTree( array_expr ), _
			astNewCONSTi( _
				iif( symbIsDynamic( array ), _
					0ll, _
					symbGetArrayDiff( array ) ) ) ), _
		elm )

	elm = symbGetNext( elm )

	'' .ptr = @array(0)
	astTypeIniAddAssign( tree, array_expr, elm )

	elm = symbGetNext( elm )

	'' .size = len( array ) * elements( array )
	astTypeIniAddAssign( tree, _
	                     astNewCONSTi( iif( symbIsDynamic( array ), 0ll, symbGetRealSize( array ) ) ), _
	                     elm )

	elm = symbGetNext( elm )

	'' .element_len = len( array )
	astTypeIniAddAssign( tree, astNewCONSTi( symbGetLen( array ) ), elm )

	elm = symbGetNext( elm )

	'' .dimensions = dims( array )
	dimensions = symbGetArrayDimensions( array )
	'' If the dimensions count is unknown at compile-time, then the
	'' descriptor must have room for FB_MAXARRAYDIMS and we have to
	'' initialize the dimensions field to 0, so that the rtlib can detect
	'' this as a special case (see also fb_hArrayAlloc()).
	if( dimensions = -1 ) then
		assert( symbDescriptorHasRoomFor( desc, FB_MAXARRAYDIMS ) )
		dimensions = 0
		max_dimensions = FB_MAXARRAYDIMS
	else
		assert( symbDescriptorHasRoomFor( desc, dimensions ) )
		max_dimensions = dimensions
		flags or= FBARRAY_FLAGS_FIXED_DIM
	end if
	assert( dimensions >= 0 )
	astTypeIniAddAssign( tree, astNewCONSTi( dimensions ), elm )

	elm = symbGetNext( elm )

	'' .flags = flags
	flags or= ( max_dimensions and FBARRAY_FLAGS_DIMENSIONS )
	astTypeIniAddAssign( tree, astNewCONSTi( flags ), elm )

	elm = symbGetNext( elm )

	'' setup dimTB
	var dimtbfield = elm
	dimtb = symbGetUDTSymbTbHead( symbGetSubtype( elm ) )

	astTypeIniScopeBegin( tree, dimtbfield, TRUE )

	'' static array?
	if( symbGetIsDynamic( array ) = FALSE ) then
		for i as integer = 0 to symbGetArrayDimensions( array ) - 1
			elm = dimtb

			astTypeIniScopeBegin( tree, dimtbfield, FALSE )

			'' .elements = (ubound( array, d ) - lbound( array, d )) + 1
			astTypeIniAddAssign( tree, astNewCONSTi( symbArrayUbound( array, i ) - symbArrayLbound( array, i ) + 1 ), elm )

			elm = symbGetNext( elm )

			'' .lbound = lbound( array, d )
			astTypeIniAddAssign( tree, astNewCONSTi( symbArrayLbound( array, i ) ), elm )

			elm = symbGetNext( elm )

			'' .ubound = ubound( array, d )
			astTypeIniAddAssign( tree, astNewCONSTi( symbArrayUbound( array, i ) ), elm )

			astTypeIniScopeEnd( tree, dimtbfield )
		next
	else
		'' Just clear the dimTB entries (dynamic array; not yet allocated)
		dimensions = symbGetArrayDimensions( array )
		'' If the dimensions count is unknown at compile-time, then the
		'' descriptor must have room for FB_MAXARRAYDIMS (see above).
		if( dimensions = -1 ) then
			dimensions = FB_MAXARRAYDIMS
		end if
		assert( dimensions > 0 )
		assert( symbDescriptorHasRoomFor( desc, dimensions ) )
		astTypeIniAddPad( tree, dimensions * symbGetLen( symb.fbarraydim ) )
	end if

	astTypeIniScopeEnd( tree, dimtbfield )
	astTypeIniScopeEnd( tree, desc )
	astTypeIniEnd( tree, TRUE )

	function = tree
end function

private function hConstBound _
	( _
		byval arrayexpr as ASTNODE ptr, _
		byval dimexpr as ASTNODE ptr, _
		byval is_lbound as integer _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr array = any
	dim as integer dimension = any
	dim as longint bound = any

	function = NULL

	'' We must know the array symbol, it's carrying the bounds information
	select case( arrayexpr->class )
	case AST_NODECLASS_VAR, AST_NODECLASS_FIELD

	case else
		exit function
	end select

	array = arrayexpr->sym
	if( array = NULL ) then
		exit function
	end if

	'' It must be a fixed-size array
	if( symbGetIsDynamic( array ) ) then
		exit function
	end if

	'' The dimension argument must be constant
	if( astIsCONST( dimexpr ) = FALSE ) then
		exit function
	end if

	'' u/lbound()'s dimension argument is 1-based, turn into 0-based
	assert( astGetDataType( dimexpr ) = FB_DATATYPE_INTEGER )
	dimension = astConstGetInt( dimexpr ) - 1

	if( (dimension >= 0) and (dimension < symbGetArrayDimensions( array )) ) then
		if( is_lbound ) then
			bound = symbArrayLbound( array, dimension )
		else
			bound = symbArrayUbound( array, dimension )
			'' Ellipsis ubound? can happen if ubound() is used in
			'' an array initializer, when the ubound isn't fully
			'' known yet, e.g. in this case:
			''    dim array(0 to ...) as integer = { 1, ubound( array ), 3 }
			if( bound = FB_ARRAYDIM_UNKNOWN ) then
				exit function
			end if
		end if
	else
		'' Out-of-bounds dimension argument
		'' For 0 (1-based, that's -1 when 0-based) we return l/ubound of the
		'' array's dimTB, with lbound=1 and ubound=dimensions.
		if( dimension = -1 ) then
			bound = iif( is_lbound, 1, symbGetArrayDimensions( array ) )
		else
			'' Otherwise, return lbound=0 and ubound=-1.
			bound = iif( is_lbound, 0, -1 )
		end if
	end if

	function = astNewCONSTi( bound )
end function

function astBuildArrayBound _
	( _
		byval arrayexpr as ASTNODE ptr, _
		byval dimexpr as ASTNODE ptr, _
		byval tk as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr expr = any

	'' Ensure it's an INTEGER, show overflow warnings
	'' (normally astNewARG() would do it, but only for the runtime version
	'' of course, not when evaluated at compile-time)
	errPushParamLocation( NULL, tk, 2, "dimension" )
	dimexpr = astNewCONV( FB_DATATYPE_INTEGER, NULL, dimexpr )
	errPopParamLocation( )

	'' Try to evaluate l/ubound( array, dimension ) at compile-time
	expr = hConstBound( arrayexpr, dimexpr, (tk = FB_TK_LBOUND) )

	if( expr = NULL ) then
		'' Fall back to run-time ubound(), that will work for array
		'' declarations that can have non-const initializers, and cause
		'' an error if a constant initializer was expected.
		expr = rtlArrayBound( arrayexpr, dimexpr, (tk = FB_TK_LBOUND) )
	end if

	function = expr
end function

''
'' strings
''

function astBuildStrPtr( byval lhs as ASTNODE ptr ) as ASTNODE ptr
	'' note: only var-len strings expressions should be passed
	dim as ASTNODE ptr expr = any
	dim as integer dtype = any

	'' *cast( [const] zstring const ptr ptr, @lhs )
	'' - preserving string's CONSTness, like string indexing, or field
	''   access for UDTs
	'' - making result pointer CONST too, to prevent assignments like
	''   <STRPTR(s) = 0>
	dtype = FB_DATATYPE_CHAR
	if( typeIsConst( lhs->dtype ) ) then
		dtype = typeSetIsConst( dtype )
	end if
	dtype = typeSetIsConst( typeAddrOf( dtype ) )
	dtype = typeAddrOf( dtype )

	'' Don't warn on CONST qualifier changes, we are explicitly forcing the conversion
	expr = astNewDEREF( astNewCONV( dtype, NULL, astNewADDROF( lhs ), AST_CONVOPT_DONTWARNCONST ) )

	return expr
end function
