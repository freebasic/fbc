'' AST nodes related to memory operations
'' bop (l = destine; r = source or bytes to clear)
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "ast.bi"
#include once "rtl.bi"

function astNewMEM _
	( _
		byval op as integer, _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr, _
		byval bytes as longint _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any

	dim as uinteger blkmaxlen = irGetOptionValue( IR_OPTIONVALUE_MAXMEMBLOCKLEN )

	dim as ulongint lgt = bytes
	if( op = AST_OP_MEMCLEAR ) then
		if( astIsCONST( r ) ) then
			lgt = astConstGetInt( r )
		else
			lgt = blkmaxlen + 1
		end if
	end if

	'' when clearing/moving more than IR_MEMBLOCK_MAXLEN bytes, take
	'' the adress-of and let emit() do the rest
	if( lgt > blkmaxlen ) then
		l = astNewADDROF( l )

		if( op = AST_OP_MEMMOVE ) then
			r = astNewADDROF( r )
		end if
	end if

	'' alloc new node
	n = astNewNode( AST_NODECLASS_MEM, FB_DATATYPE_INVALID )

	n->mem.op = op
	n->l = l
	n->r = r
	n->mem.bytes = bytes

	function = n
end function

private function hCallCtorList _
	( _
		byval tmp as FBSYMBOL ptr, _
		byval elementsexpr as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

    dim as FBSYMBOL ptr cnt = any, label = any, iter = any
    dim as ASTNODE ptr tree = any

	cnt = symbAddTempVar( FB_DATATYPE_INTEGER )
	label = symbAddLabel( NULL )
	iter = symbAddTempVar( typeAddrOf( dtype ), subtype )

	'' iter = @vector[0]
	tree = astBuildVarAssign( iter, astNewVAR( tmp ) )

	'' for cnt = 0 to elements-1
	'' Note: Using a non-flushing LABEL here because the LABEL node will
	'' end up as part of an expression tree, not as a "standalone statement"
	tree = astBuildForBegin( tree, cnt, label, 0, FALSE /' non-flushing '/ )

	'' ctor( *iter )
	tree = astNewLINK( tree, astBuildCtorCall( subtype, astBuildVarDeref( iter ) ) )

	'' iter += 1
	tree = astNewLINK( tree, astBuildVarInc( iter, 1 ) )

	'' next
	tree = astBuildForEnd( tree, cnt, label, elementsexpr )

	'' Wrap into LOOP node so astCloneTree() can clone the label and update
	'' the loop code, because it's part of the new[] expression, and not
	'' a standalone statement.
	function = astNewLOOP( label, tree )
end function

private function hElements _
	( _
		byval elementsexpr as ASTNODE ptr, _
		byref elementstreecount as integer _
	) as ASTNODE ptr

	if( elementstreecount > 1 ) then
		function = astCloneTree( elementsexpr )
	else
		function = elementsexpr
	end if

	elementstreecount -= 1
	assert( elementstreecount >= 0 )

end function

function astBuildNewOp _
	( _
		byval op as AST_OP, _
		byval tmp as FBSYMBOL ptr, _
		byval elementsexpr as ASTNODE ptr, _
		byval initexpr as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval do_clear as integer, _
		byval newexpr as ASTNODE ptr _
	) as ASTNODE ptr

	enum
		INIT_TYPEINI = 0
		INIT_CTORCALL
		INIT_DEFCTOR
		INIT_DEFCTORLIST
		INIT_CLEAR
		INIT_NONE
	end enum

	dim as ASTNODE ptr lenexpr = any, tree = any
	dim as integer save_elmts = any, init = any, elementstreecount = any

	init = INIT_NONE
	tree = NULL
	save_elmts = FALSE
	elementstreecount = 0

	'' explicit initialization?
	if( initexpr ) then
		'' Just an UDT initializer?
		if( typeHasCtor( dtype, subtype ) = FALSE ) then
			init = INIT_TYPEINI
		'' really a CTORCALL? (check due to error recovery)
		elseif( astIsCALLCTOR( initexpr ) ) then
			'' Explicit ctor call
			init = INIT_CTORCALL
		end if
	else
		'' If there is a default constructor, call it
		if( typeHasDefCtor( dtype, subtype ) ) then
			if( op = AST_OP_NEW_VEC ) then
				init = INIT_DEFCTORLIST
				elementstreecount += 1
			else
				init = INIT_DEFCTOR
			end if
		'' Zero-initialize the buffer?
		elseif( do_clear ) then
			init = INIT_CLEAR
			elementstreecount += 1
		end if
	end if

	'' new[] stores the element count, if there is a destructor,
	'' so delete[] knows how many objects to destroy
	if( op = AST_OP_NEW_VEC ) then
		'' Not placement new[] though, because
		'' 1) we can't assume the given buffer to have room for the cookie at buffer[-1],
		'' 2) and the cookie is only needed for the built-in delete[] which can only be
		''    used with new[], but not placement new[]
		if( newexpr = NULL ) then
			save_elmts = typeHasDtor( dtype, subtype )
		end if
	end if

	if( newexpr = NULL ) then
		elementstreecount += 1
	end if

	if( save_elmts ) then
		elementstreecount += 1
	end if

	'' If the elementsexpr will be cloned, take care of side-effects
	if( elementstreecount > 1 ) then
		'' side-effect?
		if( astHasSideFx( elementsexpr ) ) then
			tree = astRemSideFx( elementsexpr )
		end if
	end if

	'' address not already given? (placement new)
	if( newexpr = NULL ) then
		'' elements * sizeof( type )
		lenexpr = astNewBOP( AST_OP_MUL, hElements( elementsexpr, elementstreecount ), _
				astNewCONSTi( symbCalcLen( dtype, subtype ), FB_DATATYPE_UINT ) )

		if( save_elmts ) then
			'' length + sizeof( integer )   (to store the vector size)
			lenexpr = astNewBOP( AST_OP_ADD, lenexpr, _
					astNewCONSTi( typeGetSize( FB_DATATYPE_INTEGER ), FB_DATATYPE_UINT ) )
		end if

		newexpr = rtlMemNewOp( op, lenexpr, dtype, subtype )
		if( newexpr = NULL ) then
			return NULL
		end if
	end if

	'' tempptr = new( len )
	tree = astNewLINK( tree, astBuildVarAssign( tmp, newexpr ) )

	'' save elements count?
	if( save_elmts ) then
		'' *tempptr = elements
		tree = astNewLINK( tree, _
			astNewASSIGN( _
				astNewDEREF( astNewVAR( tmp, , typeAddrOf( FB_DATATYPE_INTEGER ) ) ), _
				hElements( elementsexpr, elementstreecount ) ) )

		'' tempptr += len( integer )
		tree = astNewLINK( tree, _
			astNewSelfBOP( AST_OP_ADD_SELF, _
				astNewVAR( tmp, , typeAddrOf( FB_DATATYPE_VOID ) ), _
				astNewCONSTi( typeGetSize( FB_DATATYPE_INTEGER ) ), _
				NULL ) )
	end if

	select case as const( init )
	case INIT_TYPEINI
		assert( astIsTYPEINI( initexpr ) )
		initexpr = astTypeIniFlush( initexpr, tmp, _
				AST_INIOPT_ISINI or AST_INIOPT_DODEREF )

	case INIT_CTORCALL
		initexpr = astPatchCtorCall( astCALLCTORToCALL( initexpr ), _
				astNewDEREF( astNewVAR( tmp ) ) )

	case INIT_DEFCTOR
		initexpr = astBuildCtorCall( subtype, astNewDEREF( astNewVAR( tmp ) ) )

	case INIT_DEFCTORLIST
		initexpr = hCallCtorList( tmp, hElements( elementsexpr, elementstreecount ), dtype, subtype )

	case INIT_CLEAR
		'' elements * sizeof( type )
		lenexpr = astNewBOP( AST_OP_MUL, hElements( elementsexpr, elementstreecount ), _
				astNewCONSTi( symbCalcLen( dtype, subtype ), FB_DATATYPE_UINT ) )

		initexpr = astNewMEM( AST_OP_MEMCLEAR, _
				astNewDEREF( astNewVAR( tmp ) ), _
				astNewCONV( FB_DATATYPE_UINT, NULL, lenexpr ) )

	case else
		initexpr = NULL

	end select

	function = astNewLINK( tree, initexpr )
end function

private function hCallDtorList _
	( _
		byval ptrexpr as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

    dim as FBSYMBOL ptr cnt = any, label = any, iter = any, elmts = any
    dim as ASTNODE ptr tree = any, expr = any

	cnt = symbAddTempVar( FB_DATATYPE_INTEGER )
	label = symbAddLabel( NULL )
	iter = symbAddTempVar( typeAddrOf( dtype ), subtype )
	elmts = symbAddTempVar( FB_DATATYPE_INTEGER )

	'' DELETE[]'s counter is at: cast(integer ptr, vector)[-1]

	'' elmts = *cast( integer ptr, cast( any ptr, vector ) + -sizeof( integer ) )
	'' (using AST_CONVOPT_DONTCHKPTR to support derived UDT pointers)
	tree = astBuildVarAssign( elmts, astNewDEREF( _
		astNewCONV( typeAddrOf( FB_DATATYPE_INTEGER ), NULL, _
			astNewBOP( AST_OP_ADD, _
				astCloneTree( ptrexpr ), _
				astNewCONSTi( -typeGetSize( FB_DATATYPE_INTEGER ) ) ), _
			AST_CONVOPT_DONTCHKPTR ) ) )

	'' iter = @vector[elmts]
	tree = astNewLINK( tree, astBuildVarAssign( iter, _
		astNewBOP( AST_OP_ADD, ptrexpr, astNewVAR( elmts ), NULL, _
				AST_OPOPT_DEFAULT or AST_OPOPT_DOPTRARITH ) ) )

	'' for cnt = 0 to elmts-1
	tree = astBuildForBegin( tree, cnt, label, 0 )

	'' iter -= 1
	tree = astNewLINK( tree, astBuildVarInc( iter, -1 ) )

	'' dtor( *iter )
	tree = astNewLINK( tree, astBuildDtorCall( subtype, astBuildVarDeref( iter ) ) )

	'' next
	tree = astBuildForEnd( tree, cnt, label, astNewVAR( elmts ) )

	function = tree
end function

function astBuildDeleteOp _
	( _
		byval op as AST_OP, _
		byval ptrexpr as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr tree = any
	dim as FBSYMBOL ptr label = any

	tree = NULL

	'' side-effect?
	if( astHasSideFx( ptrexpr ) ) then
		tree = astRemSideFx( ptrexpr )
	end if

	'' if ptr <> NULL then
	label = symbAddLabel( NULL )
	tree = astNewLINK( tree, _
		astNewBOP( AST_OP_EQ, _
			astCloneTree( ptrexpr ), _
			astNewCONSTi( 0 ), _
			label, AST_OPOPT_NONE ) )

	'' call dtors?
	if( typeHasDtor( dtype, subtype ) ) then
		if( op = AST_OP_DEL_VEC ) then
			tree = astNewLINK( tree, hCallDtorList( astCloneTree( ptrexpr ), dtype, subtype ) )
			'' ptr -= len( integer )
			ptrexpr = astNewBOP( AST_OP_SUB, ptrexpr, astNewCONSTi( typeGetSize( FB_DATATYPE_INTEGER ) ) )
		else
			tree = astNewLINK( tree, astBuildDtorCall( subtype, astNewDEREF( astCloneTree( ptrexpr ) ) ) )
		end if
	end if

	'' delete( ptr )
	tree = astNewLINK( tree, rtlMemDeleteOp( op, ptrexpr, dtype, subtype ) )

	'' end if
	tree = astNewLINK( tree, astNewLABEL( label ) )

	function = tree
end function

function astLoadMEM( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr l = any, r = any
    dim as IRVREG ptr v1 = any, v2 = any

	l = n->l
	r = n->r

	if( l = NULL ) then
		return NULL
	end if

	v1 = astLoad( l )
	astDelNode( l )

	if( r <> NULL ) then
		v2 = astLoad( r )
		astDelNode( r )
	else
		v2 = NULL
	end if

	if( ast.doemit ) then
		irEmitMEM( n->mem.op, v1, v2, n->mem.bytes )
	end if

	function = NULL
end function
