'' AST nodes related to memory operations
'' bop (l = destine; r = source or bytes to clear)
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "ast.bi"
#include once "rtl.bi"

'':::::
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

'':::::
private function hCallCtorList _
	( _
		byval ptr_expr as ASTNODE ptr, _
		byval elmts_expr as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

    dim as FBSYMBOL ptr cnt = any, label = any, iter = any
    dim as ASTNODE ptr tree = any

    cnt = symbAddTempVar( FB_DATATYPE_INTEGER, NULL, FALSE, FALSE )
    label = symbAddLabel( NULL )
    iter = symbAddTempVar( typeAddrOf( dtype ), subtype, FALSE, FALSE )

	'' iter = @vector[0]
	tree = astBuildVarAssign( iter, ptr_expr )

	'' for cnt = 0 to elements-1
	tree = astBuildForBeginEx( tree, cnt, label, 0 )

	'' ctor( *iter )
	tree = astNewLINK( tree, _
					   astBuildCtorCall( subtype, astBuildVarDeref( iter ) ) )

	'' iter += 1
    tree = astNewLINK( tree, _
    				   astBuildVarInc( iter, 1 ) )

    '' next
    tree = astBuildForEndEx( tree, cnt, label, 1, elmts_expr )

	function = tree

end function

'':::::
private function hNewOp _
	( _
		byval op as AST_OP, _
		byval ptr_expr as ASTNODE ptr, _
		byval elmts_expr as ASTNODE ptr, _
		byval init_expr as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval do_clear as integer, _
		byval placement_expr as ASTNODE ptr _
	) as ASTNODE ptr

	dim as integer do_init = FALSE, has_ctor = FALSE, save_elmts = FALSE

	'' check ctor or initialization
	select case typeGet( dtype )
	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		has_ctor = symbGetHasCtor( subtype )
	end select

	if( has_ctor ) then
		'' no explicit ctor call?
		if( init_expr = NULL ) then
			'' default ctor?
			do_init = symbGetCompDefCtor( subtype ) <> NULL
		else
			do_init = TRUE
		end if

		'' save elements count?
		if( op = AST_OP_NEW_VEC ) then
			save_elmts = symbGetCompDtor( subtype ) <> NULL
		end if

	else
		'' save elements count?
		if( op = AST_OP_NEW_VEC ) then
			select case typeGet( dtype )
			case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
				save_elmts = symbGetHasDtor( subtype )
			end select
		end if

		do_init = init_expr <> NULL
	end if

    '' note: assuming ptr_expr will be an ordinary temp var
    dim as FBSYMBOL ptr ptr_sym = astGetSymbol( ptr_expr )

	dim as ASTNODE ptr tree = NULL

	dim as ASTNODE ptr new_expr = any, len_expr = any
	dim as integer clone_elmts = FALSE

	'' elms *= sizeof( typeof( expr ) )
	if( save_elmts or (do_init and (op = AST_OP_NEW_VEC)) ) then
		'' side-effect?
		if( astIsClassOnTree( AST_NODECLASS_CALL, elmts_expr ) <> NULL ) then
			tree = astRemSideFx( elmts_expr )
		end if

		clone_elmts = TRUE
	end if

	len_expr = astNewBOP( AST_OP_MUL, _
						  iif( clone_elmts, astCloneTree( elmts_expr ), elmts_expr ), _
						  astNewCONSTi( symbCalcLen( dtype, subtype ), FB_DATATYPE_UINT ) )

	dim as ASTNODE ptr bytes_expr = NULL

	if( (do_init = FALSE) and (do_clear = TRUE) ) then
		bytes_expr = astCloneTree( len_expr )
	end if

	if( save_elmts ) then
		len_expr = astNewBOP( AST_OP_ADD, _
							  len_expr, _
							  astNewCONSTi( FB_INTEGERSIZE, FB_DATATYPE_UINT ) )
	end if

	''
	if( placement_expr ) then
		new_expr = placement_expr
	else
		new_expr = rtlMemNewOp( op = AST_OP_NEW_VEC, len_expr, typeGet( dtype ), subtype )
		if( new_expr = NULL ) then
			return NULL
		end if
	end if

	'' save elements count?
	if( save_elmts ) then
    	'' ptr = new( len )
		tree = astNewLINK( tree, _
						   astBuildVarAssign( ptr_sym, new_expr ) )

		'' *ptr = elmts
		tree = astNewLINK( tree, _
						   astNewASSIGN( astNewDEREF( astNewVAR( ptr_sym, _
						   									     0, _
						   									     typeAddrOf( FB_DATATYPE_INTEGER ), _
						   									     NULL ), _
                                                      FB_DATATYPE_INTEGER, _
                                                      NULL ), _
						  	iif( do_init and (op = AST_OP_NEW_VEC), _
						  	   	 astCloneTree( elmts_expr ), _
						  	   	 elmts_expr ) ) )

		'' ptr += len( integer )
		tree = astNewLINK( tree, _
						   astNewSelfBOP( AST_OP_ADD_SELF, _
						   	  			  astNewVAR( ptr_sym, _
						   	  			 			 0, _
						   	  			 			 typeAddrOf( FB_DATATYPE_VOID ), _
						   	  			 			 NULL ), _
            			   	  			  astNewCONSTi( FB_INTEGERSIZE, FB_DATATYPE_INTEGER ), _
            			   	  			  NULL ) )

		astDelTree( ptr_expr )
		ptr_expr = astNewVAR( ptr_sym, 0, typeAddrOf( FB_DATATYPE_VOID ), NULL )

    else
		'' ptr = new( len )
		tree = astNewLINK( tree, astNewASSIGN( astCloneTree( ptr_expr ), new_expr ) )
	end if

    '' no initialization?
    if( do_init = FALSE ) then
    	'' initialize buffer to 0's?
    	if( do_clear = FALSE ) then
    		astDelTree( ptr_expr )
    		return tree
    	else
    		return astNewLINK( tree, _
    					   	   astNewMEM( AST_OP_MEMCLEAR, _
    								  	  astNewDEREF( ptr_expr ), _
    								  	  astNewCONV( FB_DATATYPE_UINT, _
    								  			  	  NULL, _
    								  			  	  bytes_expr ) ) )
		end if
    end if

	'' just a init-tree?
	if( has_ctor = FALSE ) then
		astDelTree( ptr_expr )

		return astNewLINK( tree, _
						   astTypeIniFlush( init_expr, _
						   					ptr_sym, _
						   					AST_INIOPT_ISINI or AST_INIOPT_DODEREF ) )
	end if

	'' ctors..

	'' note: ptr_expr is never a complex node, no need to check for side-effects

	if( op = AST_OP_NEW_VEC ) then
		init_expr = hCallCtorList( ptr_expr, _
								   elmts_expr, _
								   dtype, _
								   subtype )

	'' not a vector..
	else
		'' call default ctor?
		if( init_expr = NULL ) then
			init_expr = astBuildCtorCall( subtype, _
								  		  astBuildVarDeref( ptr_expr ) )

		'' explicit ctor call, patch it..
		else
            '' check if a ctor call (because error recovery)..
			if( astIsCALLCTOR( init_expr ) ) then
               	init_expr = astPatchCtorCall( astCALLCTORToCALL( init_expr ), _
               						  		  astBuildVarDeref( ptr_expr ) )
            end if
		end if
	end if

	tree = astNewLINK( tree, init_expr )

	function = tree

end function

'':::::
private function hCallDtorList _
	( _
		byval ptr_expr as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

    dim as FBSYMBOL ptr cnt = any, label = any, iter = any, elmts = any
    dim as ASTNODE ptr tree = any, expr = any

    cnt = symbAddTempVar( FB_DATATYPE_INTEGER, NULL, FALSE, FALSE )
    label = symbAddLabel( NULL )
    iter = symbAddTempVar( typeAddrOf( dtype ), subtype, FALSE, FALSE )
    elmts = symbAddTempVar( FB_DATATYPE_INTEGER, NULL, FALSE, FALSE )

	'' DELETE[]'s counter is at: cast(integer ptr, vector)[-1]

	'' elmts = cast(integer ptr, vector)[-1]
	expr = astNewDEREF( astNewBOP( AST_OP_ADD, _
					  			   astNewCONV( typeAddrOf( FB_DATATYPE_INTEGER ), _
							 			 	   NULL, _
							 			 	   astCloneTree( ptr_expr ) ), _
					  			   astNewCONSTi( -FB_INTEGERSIZE, FB_DATATYPE_INTEGER ) ), _
					    FB_DATATYPE_INTEGER, _
					    NULL )

	tree = astBuildVarAssign( elmts, expr )

	'' iter = @vector[elmts]
	ptr_expr = astNewBOP( AST_OP_ADD, _
					  	  ptr_expr, _
					  	  astNewVAR( elmts, 0, FB_DATATYPE_INTEGER, NULL ), _
					  	  NULL, _
					  	  AST_OPOPT_DEFAULT or AST_OPOPT_DOPTRARITH )

	tree = astNewLINK( tree, astBuildVarAssign( iter, ptr_expr ) )

	'' for cnt = 0 to elmts-1
	tree = astBuildForBeginEx( tree, cnt, label, 0 )

	'' iter -= 1
    tree = astNewLINK( tree, _
    				   astBuildVarInc( iter, -1 ) )

	'' dtor( *iter )
	tree = astNewLINK( tree, _
					   astBuildDtorCall( subtype, astBuildVarDeref( iter ) ) )

    '' next
    tree = astBuildForEndEx( tree, _
    						 cnt, _
    						 label, _
    						 1, _
    						 astNewVAR( elmts, 0, FB_DATATYPE_INTEGER, NULL ) )

	function = tree

end function

'':::::
private function hDelOp _
	( _
		byval op as AST_OP, _
		byval ptr_expr as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as integer has_dtor = FALSE

	select case as const typeGet( dtype )
	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		has_dtor = symbGetCompDtor( subtype ) <> NULL
	end select

	dim as ASTNODE ptr tree = NULL

	'' side-effect?
	if( astIsClassOnTree( AST_NODECLASS_CALL, ptr_expr ) <> NULL ) then
		tree = astRemSideFx( ptr_expr )
	end if

	'' if ptr <> NULL then
	dim as FBSYMBOL ptr blk_label = symbAddLabel( NULL )
	tree = astNewLINK( tree, _
					   astNewBOP( AST_OP_EQ, _
					   			  astCloneTree( ptr_expr ), _
					   			  astNewCONSTi( 0, FB_DATATYPE_INTEGER ), _
					   			  blk_label, _
					   			  AST_OPOPT_NONE ) )

	'' call dtors?
	if( has_dtor ) then
		if( op = AST_OP_DEL_VEC ) then
			tree = astNewLINK( tree, _
							   hCallDtorList( astCloneTree( ptr_expr ), _
									   		  dtype, _
									   		  subtype ) )

			'' ptr -= len( integer )
			ptr_expr = astNewBOP( AST_OP_SUB, _
								  ptr_expr, _
            			   	  	  astNewCONSTi( FB_INTEGERSIZE, _
            			   	  			  	  	FB_DATATYPE_INTEGER ) )

		'' not a vector..
		else
			tree = astNewLINK( tree, _
							   astBuildDtorCall( subtype, _
								  	astBuildVarDeref( astCloneTree( ptr_expr ) ) ) )
		end if

	end if

	'' delete( ptr )
	dim as ASTNODE ptr del_expr = any

	del_expr = rtlMemDeleteOp( op = AST_OP_DEL_VEC, ptr_expr, typeGet( dtype ), subtype )
	if( del_expr = NULL ) then
		return NULL
	end if

	tree = astNewLINK( tree, del_expr )

	'' end if
	tree = astNewLINK( tree, astNewLABEL( blk_label ) )

	function = tree

end function

'':::::
function astNewMEM _
	( _
		byval op as integer, _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr, _
		byval ex as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval do_clear as integer, _
		byval placement_expr as ASTNODE ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any

	select case as const op
	case AST_OP_NEW, AST_OP_NEW_VEC
		n = hNewOp( op, l, r, ex, dtype, subtype, do_clear, placement_expr )

	case AST_OP_DEL, AST_OP_DEL_VEC
		n = hDelOp( op, l, dtype, subtype )

	case else
		n = astNewMEM( op, l, r, 0 )
	end select

	function = n

end function

'':::::
function astLoadMEM _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

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

