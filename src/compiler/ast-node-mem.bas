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
		byval bytes as integer _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any

    var blkmaxlen = irGetOptionValue( IR_OPTIONVALUE_MAXMEMBLOCKLEN )

	dim as integer lgt = bytes
    if( op = AST_OP_MEMCLEAR ) then
    	if( astIsCONST( r ) ) then
    		lgt = r->con.val.int
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
	tree = astBuildForBegin( tree, cnt, label, 0 )

	'' ctor( *iter )
	tree = astNewLINK( tree, astBuildCtorCall( subtype, astBuildVarDeref( iter ) ) )

	'' iter += 1
	tree = astNewLINK( tree, astBuildVarInc( iter, 1 ) )

	'' next
	tree = astBuildForEnd( tree, cnt, label, 1, elementsexpr )

	function = tree
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
		byval placementexpr as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr newexpr = any, lenexpr = any, bytesexpr = any, tree = any
	dim as integer do_init = any, save_elmts = any, clone_elmts = any

	'' note: assuming ptr_expr will be an ordinary temp var
	tree = NULL
	bytesexpr = NULL
	do_init = (initexpr <> NULL)
	save_elmts = FALSE
	clone_elmts = FALSE

	'' still initialize if no explicit ctor call was given,
	'' in case it has a default ctor.
	do_init or= ((not do_init) and typeHasDefCtor( dtype, subtype ))

	'' save elements count?
	if( op = AST_OP_NEW_VEC ) then
		save_elmts = typeHasDtor( dtype, subtype )
	end if

	'' elms *= sizeof( typeof( expr ) )
	if( save_elmts or (do_init and (op = AST_OP_NEW_VEC)) ) then
		'' side-effect?
		if( astIsClassOnTree( AST_NODECLASS_CALL, elementsexpr ) ) then
			tree = astRemSideFx( elementsexpr )
		end if
		clone_elmts = TRUE
	end if

	lenexpr = astNewBOP( AST_OP_MUL, _
			iif( clone_elmts, astCloneTree( elementsexpr ), elementsexpr ), _
			astNewCONSTi( symbCalcLen( dtype, subtype ), FB_DATATYPE_UINT ) )

	if( (do_init = FALSE) and do_clear ) then
		bytesexpr = astCloneTree( lenexpr )
	end if

	if( save_elmts ) then
		lenexpr = astNewBOP( AST_OP_ADD, lenexpr, _
				astNewCONSTi( FB_INTEGERSIZE, FB_DATATYPE_UINT ) )
	end if

	if( placementexpr ) then
		newexpr = placementexpr
	else
		newexpr = rtlMemNewOp( op, lenexpr, dtype, subtype )
		if( newexpr = NULL ) then
			return NULL
		end if
	end if

	'' save elements count?
	if( save_elmts ) then
		'' tempptr = new( len )
		tree = astNewLINK( tree, astBuildVarAssign( tmp, newexpr ) )

		'' *tempptr = elements
		tree = astNewLINK( tree, _
			astNewASSIGN( _
				astNewDEREF( astNewVAR( tmp, , typeAddrOf( FB_DATATYPE_INTEGER ) ) ), _
				iif( do_init and (op = AST_OP_NEW_VEC), _
					astCloneTree( elementsexpr ), _
					elementsexpr ) ) )

		'' tempptr += len( integer )
		tree = astNewLINK( tree, _
			astNewSelfBOP( AST_OP_ADD_SELF, _
				astNewVAR( tmp, , typeAddrOf( FB_DATATYPE_VOID ) ), _
				astNewCONSTi( FB_INTEGERSIZE ), _
				NULL ) )
	else
		'' tempptr = new( len )
		tree = astNewLINK( tree, astNewASSIGN( astNewVAR( tmp ), newexpr ) )
	end if

	'' no initialization?
	if( do_init = FALSE ) then
		'' initialize buffer to 0's?
		if( do_clear ) then
			tree = astNewLINK( tree, _
				astNewMEM( AST_OP_MEMCLEAR, _
					astNewDEREF( astNewVAR( tmp ) ), _
					astNewCONV( FB_DATATYPE_UINT, NULL, bytesexpr ) ) )
		end if
		return tree
	end if

	'' just a init-tree?
	if( typeHasCtor( dtype, subtype ) = FALSE ) then
		return astNewLINK( tree, astTypeIniFlush( initexpr, tmp, AST_INIOPT_ISINI or AST_INIOPT_DODEREF ) )
	end if

	'' ctors..

	if( op = AST_OP_NEW_VEC ) then
		initexpr = hCallCtorList( tmp, elementsexpr, dtype, subtype )
	else
		'' call default ctor?
		if( initexpr = NULL ) then
			initexpr = astBuildCtorCall( subtype, astNewDEREF( astNewVAR( tmp ) ) )
		'' explicit ctor call, patch it..
		else
			'' check if a ctor call (because error recovery)..
			if( astIsCALLCTOR( initexpr ) ) then
				initexpr = astPatchCtorCall( astCALLCTORToCALL( initexpr ), astNewDEREF( astNewVAR( tmp ) ) )
			end if
		end if
	end if

	tree = astNewLINK( tree, initexpr )

	function = tree
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
	'' (casting to ANY PTR first to support derived UDT pointers)
	tree = astBuildVarAssign( elmts, astNewDEREF( _
		astNewCONV( typeAddrOf( FB_DATATYPE_INTEGER ), NULL, _
			astNewBOP( AST_OP_ADD, _
				astNewCONV( typeAddrOf( FB_DATATYPE_VOID ), NULL, _
					astCloneTree( ptrexpr ) ), _
				astNewCONSTi( -FB_INTEGERSIZE ) ) ) ) )

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
	tree = astBuildForEnd( tree, cnt, label, 1, astNewVAR( elmts ) )

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
	if( astIsClassOnTree( AST_NODECLASS_CALL, ptrexpr ) ) then
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
			ptrexpr = astNewBOP( AST_OP_SUB, ptrexpr, astNewCONSTi( FB_INTEGERSIZE ) )
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
