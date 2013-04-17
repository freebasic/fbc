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
		byval rhs as integer _
	) as ASTNODE ptr

	function = astNewASSIGN( astNewVAR( lhs ), astNewCONSTi( rhs ) )

end function

function astBuildVarAssign _
	( _
		byval lhs as FBSYMBOL ptr, _
		byval rhs as ASTNODE ptr _
	) as ASTNODE ptr

	function = astNewASSIGN( astNewVAR( lhs ), rhs )

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
	if( astIsClassOnTree( AST_NODECLASS_CALL, expr ) <> NULL ) then
		t = astNewLINK( t, astRemSideFx( expr ), FALSE )
	end if

	assert( astGetDataType( expr ) = FB_DATATYPE_WCHAR )

	'' wcharptr = WstrAlloc( WstrLen( expr ) )
	t = astNewLINK( t, _
		astBuildVarAssign( sym, rtlWstrAlloc( rtlWstrLen( astCloneTree( expr ) ) ) ), _
		FALSE )

	'' *wcharptr = expr
	t = astNewLINK( t, _
		astNewASSIGN( astBuildFakeWstringAccess( sym ), expr, options ), _
		FALSE )

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

'':::::
function astBuildVarDtorCall _
	( _
		byval s as FBSYMBOL ptr, _
		byval check_access as integer _
	) as ASTNODE ptr

	'' assuming conditions were checked already
	function = NULL

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
					if( symbCheckAccess( symbGetCompDtor( symbGetSubtype( s ) ) ) = FALSE ) then
						errReport( FB_ERRMSG_NOACCESSTODTOR )
					end if
				end if
				function = astBuildDtorCall( symbGetSubtype( s ), astNewVAR( s ) )
			end if
		end select
	end if

end function

'':::::
function astBuildVarField _
	( _
		byval sym as FBSYMBOL ptr, _
		byval fld as FBSYMBOL ptr, _
		byval ofs as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr expr = any

	if( fld ) then
		ofs += symbGetOfs( fld )

		'' byref or import?
		if( symbIsParamByRef( sym ) or symbIsImport( sym ) ) then
			expr = astNewDEREF( _
				astNewVAR( sym, , typeAddrOf( symbGetFullType( sym ) ), _
					symbGetSubtype( sym ) ), _
				symbGetFullType( fld ), symbGetSubtype( fld ), ofs )
		else
			expr = astNewVAR( sym, ofs, symbGetFullType( fld ), symbGetSubtype( fld ) )
		end if

		expr = astNewFIELD( expr, fld )
	else
		'' byref or import?
		if( symbIsParamByRef( sym ) or symbIsImport( sym ) ) then
			expr = astNewDEREF( _
				astNewVAR( sym, , typeAddrOf( symbGetFullType( sym ) ), _
					symbGetSubtype( sym ) ), _
				, , ofs )
		else
			expr = astNewVAR( sym, ofs )
		end if
	end if

	function = expr
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
	assert( symbIsTemp( sym ) )

	'' Clear variable's memory
	function = astNewMEM( AST_OP_MEMCLEAR, astNewVAR( sym ), _
			astNewCONSTi( symbGetLen( sym ) ) )
end function

''
'' loops
''

function astBuildForBegin _
	( _
		byval tree as ASTNODE ptr, _
		byval cnt as FBSYMBOL ptr, _
		byval label as FBSYMBOL ptr, _
		byval inivalue as integer, _
		byval flush_label as integer _
	) as ASTNODE ptr

	'' cnt = 0
	tree = astNewLINK( tree, astBuildVarAssign( cnt, inivalue ) )

	'' do
	tree = astNewLINK( tree, astNewLABEL( label, flush_label ) )

	function = tree
end function

function astBuildForEnd _
	( _
		byval tree as ASTNODE ptr, _
		byval cnt as FBSYMBOL ptr, _
		byval label as FBSYMBOL ptr, _
		byval stepvalue as integer, _
		byval endvalue as ASTNODE ptr _
	) as ASTNODE ptr

	'' counter += stepvalue
	tree = astNewLINK( tree, astBuildVarInc( cnt, stepvalue ) )

	'' if( counter = endvalue ) then
	''     goto label
	'' end if
	tree = astNewLINK( tree, _
		astBuildBranch( _
			astNewBOP( AST_OP_EQ, astNewVAR( cnt ), endvalue ), _
			label, FALSE ) )

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
		'' (casting to any ptr first to avoid issues with derived UDT ptrs)
		p = astCloneTree( thisexpr )
		p = astNewADDROF( p )
		p = astNewCONV( typeAddrOf( FB_DATATYPE_VOID ), NULL, p )
		p = astNewCONV( typeMultAddrOf( FB_DATATYPE_VOID, 3 ), NULL, p )
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
		if( env.clopt.extraerrchk ) then
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
	dtor = symbGetCompDtor( sym )
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

	'' check visibility
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
'' instance ptr
''

'':::::
function astBuildInstPtr _
	( _
		byval sym as FBSYMBOL ptr, _
		byval fld as FBSYMBOL ptr, _
		byval idxexpr as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr expr = any
	dim as integer dtype = any, ofs = any
	dim as FBSYMBOL ptr subtype = any

	dtype = symbGetFullType( sym )
	subtype = symbGetSubtype( sym )

	'' it's always a param
	expr = astNewVAR( sym, 0, typeAddrOf( dtype ), subtype )

	if( fld <> NULL ) then
		dtype = symbGetFullType( fld )
		subtype = symbGetSubtype( fld )

		'' build sym.field( index )

		ofs = symbGetOfs( fld )
		if( ofs <> 0 ) then
			expr = astNewBOP( AST_OP_ADD, expr, astNewCONSTi( ofs ) )
		end if

		'' array access?
		if( idxexpr <> NULL ) then
			'' times length
			expr = astNewBOP( AST_OP_ADD, expr, _
				astNewBOP( AST_OP_MUL, idxexpr, _
					astNewCONSTi( symbGetLen( fld ) ) ) )
		end if

	end if

	expr = astNewDEREF( expr, dtype, subtype )

	if( fld <> NULL ) then
		expr = astNewFIELD( expr, fld )
	end if

	function = expr

end function

'':::::
function astBuildInstPtrAtOffset _
	( _
		byval sym as FBSYMBOL ptr, _
		byval fld as FBSYMBOL ptr, _
		byval ofs as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr expr = any
	dim as integer dtype = any
	dim as FBSYMBOL ptr subtype = any

	dtype = symbGetFullType( sym )
	subtype = symbGetSubtype( sym )

	'' THIS is a BYREF AS UDT parameter, the typeAddrOf() is needed to
	'' make the expression be an UDT PTR.
	expr = astNewVAR( sym, 0, typeAddrOf( dtype ), subtype )

	if( fld <> NULL ) then
		dtype = symbGetFullType( fld )
		subtype = symbGetSubtype( fld )
	end if

	if( ofs <> 0 ) then
		expr = astNewBOP( AST_OP_ADD, expr, astNewCONSTi( ofs ) )
	end if

	expr = astNewDEREF( expr, dtype, subtype )

	if( fld <> NULL ) then
		expr = astNewFIELD( expr, fld )
	end if

	function = expr

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
			if( env.clopt.extraerrchk ) then
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
    dim as integer dtype = any, dims = any
    dim as FBSYMBOL ptr elm = any, dimtb = any, subtype = any

	'' COMMON or EXTERN? Cannot be initialized
	if( symbIsCommon( array ) or symbIsExtern( array ) ) then
		return NULL
	end if

    ''
    tree = astTypeIniBegin( symbGetFullType( desc ), symbGetSubtype( desc ), TRUE )

    dtype = symbGetFullType( array )
    subtype = symbGetSubType( array )
    dims = symbGetArrayDimensions( array )

	'' note: assuming the arrays descriptors won't be objects with methods
	elm = symbGetUDTSymbTbHead( symbGetSubtype( desc ) )

    if( array_expr = NULL ) then
    	if( symbGetIsDynamic( array ) ) then
    		array_expr = astNewCONSTi( 0, typeAddrOf( dtype ), subtype )
    	else
			array_expr = astNewADDROF( astNewVAR( array ) )
    	end if
    else
    	array_expr = astNewADDROF( array_expr )
    end if

    astTypeIniScopeBegin( tree, NULL )

    '' .data = @array(0) + diff
	astTypeIniAddAssign( tree, _
		astNewBOP( AST_OP_ADD, astCloneTree( array_expr ), _
			astNewCONSTi( symbGetArrayOffset( array ) ) ), _
		elm )

	elm = symbGetNext( elm )

	'' .ptr	= @array(0)
	astTypeIniAddAssign( tree, array_expr, elm )

    elm = symbGetNext( elm )

    '' .size = len( array ) * elements( array )
	astTypeIniAddAssign( tree, _
		astNewCONSTi( symbGetLen( array ) * symbGetArrayElements( array ) ), _
		elm )

    elm = symbGetNext( elm )

    '' .element_len	= len( array )
	astTypeIniAddAssign( tree, astNewCONSTi( symbGetLen( array ) ), elm )

    elm = symbGetNext( elm )

	'' .dimensions = dims( array )
	'' If the dimension count is unknown, store 0 as dimension count,
	'' since it's an unallocated dynamic array.
	astTypeIniAddAssign( tree, astNewCONSTi( iif( dims = -1, 0, dims ) ), elm )

    elm = symbGetNext( elm )

    '' setup dimTB
    dimtb = symbGetUDTSymbTbHead( symbGetSubtype( elm ) )

    astTypeIniScopeBegin( tree, NULL )

    '' static array?
    if( symbGetIsDynamic( array ) = FALSE ) then
		assert( dims <> -1 )

    	dim as FBVARDIM ptr d

    	d = symbGetArrayFirstDim( array )
    	do while( d <> NULL )
			elm = dimtb

			astTypeIniScopeBegin( tree, NULL )

			'' .elements = (ubound( array, d ) - lbound( array, d )) + 1
			astTypeIniAddAssign( tree, astNewCONSTi( d->upper - d->lower + 1 ), elm )

			elm = symbGetNext( elm )

			'' .lbound = lbound( array, d )
			astTypeIniAddAssign( tree, astNewCONSTi( d->lower ), elm )

			elm = symbGetNext( elm )

			'' .ubound = ubound( array, d )
			astTypeIniAddAssign( tree, astNewCONSTi( d->upper ), elm )

			astTypeIniScopeEnd( tree, NULL )

			d = d->next
    	loop

	'' dynamic..
	else
		'' If the dimension count is unknown, we actually reserved room
		'' for the max amount
		if( dims = -1 ) then
			dims = FB_MAXARRAYDIMS
		end if

		'' Clear all dimTB entries
		astTypeIniAddPad( tree, dims * len( FB_ARRAYDESCDIM ) )
	end if

    astTypeIniScopeEnd( tree, NULL )

    ''
    astTypeIniScopeEnd( tree, NULL )

    astTypeIniEnd( tree, TRUE )

    ''
    symbSetIsInitialized( desc )

    function = tree

end function

private function hConstBound _
	( _
		byval arrayexpr as ASTNODE ptr, _
		byval dimexpr as ASTNODE ptr, _
		byval is_lbound as integer _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr array = any
	dim as FBVARDIM ptr d = any
	dim as integer dimension = any, bound = any

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
	if( symbIsDynamic( array ) or symbIsParamBydesc( array ) ) then
		exit function
	end if

	'' The dimension argument must be constant
	if( astIsCONST( dimexpr ) = FALSE ) then
		exit function
	end if

	'' dimension is 1-based
	assert( astGetDataType( dimexpr ) = FB_DATATYPE_INTEGER )
	dimension = astGetValInt( dimexpr )

	'' Find the referenced dimension
	if( dimension >= 1 ) then
		d = symbGetArrayFirstDim( array )
		while( (d <> NULL) and (dimension > 1) )
			dimension -= 1
			d = d->next
		wend
	else
		d = NULL
	end if

	if( d ) then
		if( is_lbound ) then
			bound = d->lower
		else
			'' Ellipsis ubound? can happen if ubound() is used in
			'' an array initializer, when the ubound isn't fully
			'' known yet, e.g. in this case:
			''    dim array(0 to ...) as integer = { 1, ubound( array ), 3 }
			if( d->upper = FB_ARRAYDIM_UNKNOWN ) then
				exit function
			end if
			bound = d->upper
		end if
	else
		'' Out-of-bounds dimension argument: For dimension = 0 we
		'' return l/ubound of the array's dimTB, with lbound=1 and
		'' ubound=dimensions. For other out-of-bound dimension values,
		'' we return lbound=1 and ubound=0.
		bound = iif( is_lbound, 1, _
		             iif( dimension = 0, _
		                  symbGetArrayDimensions( array ), _
		                  0 ) )
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

	'' *cast( zstring ptr ptr, @lhs )
	expr = astNewDEREF( astNewCONV( typeMultAddrOf( FB_DATATYPE_CHAR, 2 ), NULL, _
	                                astNewADDROF( lhs ) ) )

	'' HACK: make it return an immutable value by returning (expr + 0)
	'' in order to prevent things like STRPTR(s) = 0
	'' (TODO: find a better way of doing this?)
	expr = astNewBOP( AST_OP_ADD, expr, astNewCONSTi( 0 ), NULL )

	return expr
end function
