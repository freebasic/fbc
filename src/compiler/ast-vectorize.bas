'' AST vectorization
''
'' chng: june/2008 written [bryan]
'' chng: nov/2008 allow singles/doubles mixed expression [bryan]

#include once "fb.bi"
#include once "fbint.bi"
#include once "ast.bi"

dim shared as integer           vectorWidth
dim shared as integer           maxVectorWidth          '' 2 if doubles are found anywhere, otherwise 4

private function hNodesMatch _
	( _
		byval vn as ASTNODE ptr, _
		byval n as ASTNODE ptr _
	) as integer

	if( vn->class <> n->class ) then
		return FALSE
	end if

	if( vn->class = AST_NODECLASS_VAR ) then
		if( vn->sym <> n->sym ) then
			return FALSE
		end if
	end if

	if( astIsCONST( vn ) ) then
		if( astGetDataType( vn ) <> astGetDataType( n ) ) then
			return FALSE
		end if

		if( typeGetClass( vn->dtype ) = FB_DATACLASS_FPOINT ) then
			if( astConstGetFloat( vn ) <> astConstGetFloat( n ) ) then
				return FALSE
			end if
		else
			if( astConstGetInt( vn ) <> astConstGetInt( n ) ) then
				return FALSE
			end if
		end if
	end if

	return TRUE
end function

private function hAllowedInVectorize _
	( _
		byval n as ASTNODE ptr, _
		byval deref as integer _
	) as integer

	dim as integer dtype = any

	'' if this node is inside a deref or array idx, anything goes
	if( deref ) then return TRUE

	'' check if this node could possibly be included in the vectorization
	select case as const n->class
	case AST_NODECLASS_BOP
		if( n->op.op = AST_OP_ADD ) then return TRUE
		if( n->op.op = AST_OP_SUB ) then return TRUE
		if( n->op.op = AST_OP_MUL ) then return TRUE
		if( n->op.op = AST_OP_DIV ) then return TRUE
		if( n->op.op = AST_OP_ASSIGN ) then return TRUE

	case AST_NODECLASS_UOP
		if( n->op.op = AST_OP_SWZ_REPEAT ) then return TRUE

	case AST_NODECLASS_ASSIGN, AST_NODECLASS_LOAD
		return TRUE

	case AST_NODECLASS_CONV, AST_NODECLASS_CONST
		dtype = ( n->dtype And FB_DT_TYPEMASK )
		if( dtype = FB_DATATYPE_SINGLE ) then return TRUE
		if( dtype = FB_DATATYPE_DOUBLE ) then
			maxVectorWidth = 2
			return TRUE
		end if

	case AST_NODECLASS_VAR
		'' can't use FB_DATACLASS because pointers would return FB_DATACLASS_INTEGER
		dtype = ( n->sym->typ And FB_DT_TYPEMASK )

		'' if it's a UDT, the "field" node will catch non-float fields
		if( ( dtype = FB_DATATYPE_SINGLE ) or ( dtype = FB_DATATYPE_STRUCT ) ) then
			return TRUE
		elseif ( dtype = FB_DATATYPE_DOUBLE ) then
			maxVectorWidth = 2
			return TRUE
		end if
		return FALSE

	case AST_NODECLASS_FIELD
		'' can't use FB_DATACLASS because pointers would return FB_DATACLASS_INTEGER
		dtype = ( n->sym->typ And FB_DT_TYPEMASK )

		'' only floats
		if( dtype = FB_DATATYPE_SINGLE ) then return TRUE
		if( dtype = FB_DATATYPE_DOUBLE ) then
			maxVectorWidth = 2
			return TRUE
		end if

		return FALSE
	case AST_NODECLASS_DEREF, AST_NODECLASS_ADDROF, AST_NODECLASS_IDX
		return TRUE
	case else

	end select

	return FALSE

end function


''::::
private sub hGetVarDistance _
	( _
		byval vn as ASTNODE ptr, _
		byval vn_ofs as integer ptr, _
		byval n as ASTNODE ptr, _
		byval n_ofs as integer ptr _
	)

	if( ( vn->class = AST_NODECLASS_DEREF ) or ( vn->class = AST_NODECLASS_IDX ) ) then
		*vn_ofs += vn->idx.ofs
		*n_ofs += n->idx.ofs
	end if

	if( vn->class = AST_NODECLASS_VAR ) then
		*vn_ofs += vn->var_.ofs
		*n_ofs += n->var_.ofs
	end if

	if( vn->l = NULL ) then exit sub
	if( n->l = NULL ) then exit sub

	hGetVarDistance( vn->l, vn_ofs, n->l, n_ofs )

end sub


'' skip any added nodes, as they couldn't possibly be in the new node
'' possible nodes to check: SWZ_REPEAT and HADD
''::::
private function hSkipNewNodes _
	( _
		byval n as ASTNODE ptr, _
		byval doMerge as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr oldNode = any

	do
		oldnode = n
		if( n->class = AST_NODECLASS_UOP ) then
			if( ( n->op.op = AST_OP_SWZ_REPEAT ) or ( n->op.op = AST_OP_HADD ) ) then
				if( doMerge ) then
					n->vector = iif( n->vector = 0, 2, n->vector + 1)
				end if
				n = n->l
			end if
		end if
		if( oldnode = n ) then
			exit do
		end if
	loop

	return n

end function


''::::
private function hCheckLoad _
	( _
		byval vn as ASTNODE ptr, _
		byval n as ASTNODE ptr, _
		byval deref as integer _
	) as integer

	'' it's okay if they're both done
	if( ( vn = NULL ) and ( n = NULL ) ) then return TRUE

	'' not okay if only one is done
	if( ( vn = NULL ) or ( n = NULL ) ) then return FALSE

	vn = hSkipNewNodes( vn, FALSE )

	if( ( vn->class = AST_NODECLASS_DEREF ) or ( vn->class = AST_NODECLASS_IDX ) ) then
		deref = TRUE
	end if

	if( hAllowedInVectorize( vn, deref ) = FALSE ) then
		return FALSE
	end if

	if( hNodesMatch( vn, n ) = FALSE ) then
		return FALSE
	end if


	if( hCheckLoad( vn->l, n->l, deref ) = FALSE ) then return FALSE
	if( hCheckLoad( vn->r, n->r, deref ) = FALSE ) then return FALSE

	return TRUE

end function


''::::
private sub hInsertSwizzle _
	( _
		byval n as ASTNODE ptr _
	)

	dim as ASTNODE ptr swznode = NULL, varNode = NULL

	'' do a swizzle load of the scalar var
	varNode = astNewNode( 0, 0, 0 )
	*varNode = *n

	swznode = astNewUOP( AST_OP_SWZ_REPEAT, varNode )
	*n = *swznode
	n->vector = 2

	n->l = varNode
	varNode->vector = 0

	astDelNode( swznode )

end sub


''::::
private function hVectorizeNode _
	( _
		byval n as ASTNODE ptr, _
		byval dist as integer _
	) as ASTNODE ptr

	if( n = NULL ) then return n

	if( ( n->class = AST_NODECLASS_UOP ) or ( n->class = AST_NODECLASS_BOP ) ) then
		n->vector = iif( n->vector = 0, 2, n->vector + 1)
	else
		if( dist = 0 ) then
			n->vector = 0
		else
			n->vector = iif( n->vector = 0, 2, n->vector + 1)
		end if
	end if

	return n

end function


'' ::::
'' check if the deref points to a floating-point variable.
'' following the left nodes of the tree, the first variable encountered is the pointer
private function hCheckDerefVar _
	( _
		byval n as ASTNODE ptr, _
		byval dtype as integer ptr _
	) as integer

	dim as integer result = FALSE

	if( n = NULL ) then return result

	do while( n )
		select case n->class
			case AST_NODECLASS_CONV
				'' the first encountered conversion will be the final datatype of the pointer
				*dtype = ( n->dtype and FB_DT_TYPEMASK )

				'' if the final type is not a float then return FALSE
				if( ( *dtype = FB_DATATYPE_SINGLE ) or ( *dtype = FB_DATATYPE_DOUBLE ) ) then
					result = TRUE
				end if
				'' since we know the final datatype of the pointer, we can quit now
				exit do
			case AST_NODECLASS_VAR, AST_NODECLASS_FIELD
				*dtype = ( n->sym->typ and FB_DT_TYPEMASK )
				if( ( *dtype = FB_DATATYPE_SINGLE ) or ( *dtype = FB_DATATYPE_DOUBLE ) ) then
					result = TRUE
				end if
				exit do
			case else
		end select
		n = n->l
	loop

	return result

end function


'' ::::
'' check if the array variable is a floating-point variable
private function hCheckArrayVar _
	( _
		byval n as ASTNODE ptr, _
		byval dtype as integer ptr _
	) as integer

	function = FALSE

	if( n = NULL ) then exit function

	if( n->class = AST_NODECLASS_VAR ) then
		*dtype = ( n->sym->typ and FB_DT_TYPEMASK )
		if( ( *dtype = FB_DATATYPE_SINGLE ) or ( *dtype = FB_DATATYPE_DOUBLE ) ) then
			function = TRUE
		end if
	end if

end function


''::::
private function hCheckMemOffset _
	( _
		byval vectorNode as ASTNODE ptr, _
		byval offset as integer, _
		byval dtype as FB_DATATYPE _
	) as integer

	dim as integer needOffset = 0

	'' calc required distance of memory offsets
	if( vectorNode->vector ) then
		if( vectorNode->vector > vectorWidth ) then vectorWidth = vectorNode->vector
		needOffset = ( vectorWidth * typeGetSize( dtype ) )
	else
		needOffset = typeGetSize( dtype )
	end if

	function = TRUE

	if( ( dtype = FB_DATATYPE_SINGLE ) or ( dtype = FB_DATATYPE_DOUBLE ) ) then

		'' if node has already been vectorized, offset must be greater than 0.

		'' advanced swizzling not supported yet
		if( ( vectorNode->vector ) and ( offset = 0 ) ) then
			return FALSE
		end if

		if( ( offset <> needOffset ) and ( offset <> 0 ) ) then
			function = FALSE
		end if
	end if

end function


''::::
private function hGetAssignDataType _
	( _
		byval n as ASTNODE ptr _
	) as FB_DATATYPE

	if( n = NULL ) then return 0

	select case n->class
		case AST_NODECLASS_CONV
			return ( n->dtype And FB_DT_TYPEMASK )
		case AST_NODECLASS_VAR, AST_NODECLASS_FIELD
			return ( n->sym->typ And FB_DT_TYPEMASK )

		case else
			return hGetAssignDataType( n->l )
	end select
end function


''::::
'' vectorNode is the (potentially) vectorized tree.
'' n is checked against vectorNode to possibly be removed.

private function hMergeNode _
	( _
		byval vectorNode as ASTNODE ptr, _
		byval n as ASTNODE ptr, _
		byval doMerge as integer _
	) as integer

	dim as integer offset = any, needOffset = 0
	dim as integer vn_ofs = any, n_ofs = any
	dim as integer dtype = any

	function = TRUE

	'' prevent NULL pointer access
	if( n = NULL ) then return TRUE
	if( vectorNode = NULL ) then return TRUE

	'' ignore any nodes that have been added
	vectorNode = hSkipNewNodes( vectorNode, doMerge )

	if( doMerge = 0 ) then
		if( hNodesMatch( vectorNode, n ) = FALSE ) then
			return FALSE
		end if

		if( hAllowedInVectorize( vectorNode, FALSE ) = FALSE ) then
			return FALSE
		end if
	end if

	'' ASSIGN is usually the starting point in the search of vectorizable trees.
	'' make sure the assigns are in contiguous memory locations
	if( vectorNode->class = AST_NODECLASS_ASSIGN ) then
		dtype = hGetAssignDataType( vectorNode )

		n_ofs = 0: vn_ofs = 0
		hGetVarDistance( vectorNode, @vn_ofs, n, @n_ofs )

		offset = ( n_ofs - vn_ofs )

		if( vectorNode->vector ) then
			if( vectorNode->vector > vectorWidth ) then vectorWidth = vectorNode->vector
			needOffset = ( vectorWidth * typeGetSize( dtype ) )
		else
			needOffset = typeGetSize( dtype )
		end if

		if( offset <> needOffset ) then
			return FALSE
		end if
	end if

	'' cap the vector width
	if( vectorNode->vector = maxVectorWidth ) then
		return FALSE
	end if

	if( vectorNode->class = AST_NODECLASS_FIELD ) then
		if( doMerge = FALSE ) then
			if( hCheckLoad( vectorNode, n, FALSE ) = FALSE ) then
				return FALSE
			end if
		end if

		n_ofs = 0: vn_ofs = 0
		hGetVarDistance( vectorNode, @vn_ofs, n, @n_ofs )

		offset = ( n_ofs - vn_ofs )

		dtype = vectorNode->sym->typ And FB_DT_TYPEMASK
		if( hCheckMemOffset( vectorNode, offset, dtype ) = FALSE ) then
			return FALSE
		end if

		if( doMerge ) then
			if( ( offset = 0 ) and ( vectorWidth = 0 ) ) then
				hInsertSwizzle vectorNode
			else
				hVectorizeNode vectorNode, offset
			end if
		end if

		return TRUE
	end if

	if( ( vectorNode->class = AST_NODECLASS_DEREF ) or ( vectorNode->class = AST_NODECLASS_IDX ) ) then
		if( doMerge = FALSE ) then
			if( hCheckLoad( vectorNode, n, TRUE ) = FALSE ) then
				return FALSE
			end if
		end if

		if( vectorNode->class = AST_NODECLASS_DEREF ) then
			'' check if the deref points to a float
			if( hCheckDerefVar( vectorNode->l, @dtype ) = FALSE ) then
				return FALSE
			end if
		else
			'' check if the array is of floats
			if( hCheckArrayVar( vectorNode->r, @dtype ) = FALSE ) then
				return FALSE
			end if
		end if

		'' it points to a float; get the distance (pointer address) between the pointers
		n_ofs = 0: vn_ofs = 0
		hGetVarDistance( vectorNode, @vn_ofs, n, @n_ofs )

		offset = ( n_ofs - vn_ofs )

		if( hCheckMemOffset( vectorNode, offset, dtype ) = FALSE ) then
			return FALSE
		end if

		if( doMerge ) then
			if( ( offset = 0 ) and ( vectorWidth = 0 ) ) then
				hInsertSwizzle vectorNode
			else
				hVectorizeNode vectorNode, offset
			end if
		end if
		return TRUE
	end if

	if( vectorNode->class = AST_NODECLASS_VAR ) then
		if( doMerge = FALSE ) then
			if( hCheckLoad( vectorNode, n, FALSE ) = FALSE ) then
				return FALSE
			end if
		end if

		if( doMerge ) then
			if( vectorWidth = 0 ) then
				hInsertSwizzle vectorNode
			end if
		end if

		return TRUE
	end if

	if( vectorNode->class = AST_NODECLASS_CONST ) then
		dtype = ( n->dtype And FB_DT_TYPEMASK )
		if( ( dtype = FB_DATATYPE_SINGLE ) or ( dtype = FB_DATATYPE_DOUBLE ) ) then
			'' constants always get swizzled
			if( doMerge ) then
				if( vectorWidth = 0 ) then
					hInsertSwizzle vectorNode
				end if
			end if
		else
			return FALSE
		end if

		return TRUE
	end if

	if( doMerge ) then
		hVectorizeNode vectorNode, offset
	end if

	if( hMergeNode( vectorNode->l, n->l, doMerge ) = FALSE ) then return FALSE
	if( hMergeNode( vectorNode->r, n->r, doMerge ) = FALSE ) then return FALSE

end function


''::::
private function hIsVectorizable _
	( _
		byval n as ASTNODE ptr _
	) as integer

	if( n->class = AST_NODECLASS_ASSIGN ) then return TRUE

	return FALSE

end function



''::::
private function astIntraTreeVectorize _
	( _
		byval n as ASTNODE ptr _
	) as integer

	dim as ASTNODE ptr l = any
	dim as integer changed = FALSE

	if( n = NULL ) then return FALSE

	if( n->class = AST_NODECLASS_BOP ) then
		if( n->op.op = AST_OP_ADD ) then

			'' test if nodes can be merged / vectorized
			'' careful, maxVectorWidth & vectorWidth are shared
			maxVectorWidth = 4
			vectorWidth = 0

			if( hMergeNode( n->l, n->r, FALSE ) ) then

				'' go ahead and do the merge / vectorize
				''
				maxVectorWidth = 4
				vectorWidth = 0
				hMergeNode( n->l, n->r, TRUE )

				'' n    = AST_OP_ADD, can be removed
				'' n->l = vectorized node or an existing AST_OP_HADD
				'' n->r = can be discarded

				assert( n->l )

				l = n->l

				'' check for multiple AST_OP_HADD's
				if( l->class = AST_NODECLASS_UOP ) then
					if( l->op.op = AST_OP_HADD ) then

						'' replace the callers node
						*n = *l

						assert( n->l )
						assert( n->l->vector <> 0 )

						'' copy the new value of the vector to AST_OP_HADD node
						n->vector = n->l->vector

						'' remove this node
						astDelNode( l )
						return TRUE
					end if
				end if

				'' n    = AST_OP_ADD, can be replaced
				'' n->l = vectorized node
				'' n->r = can be discarded
				assert( n->l )

				astDelTree( n->r )
				n->r = NULL
				n->class = AST_NODECLASS_UOP
				n->op.op = AST_OP_HADD
				n->vector = n->l->vector

				return TRUE
			end if
		end if
	end if
	if( astIntraTreeVectorize( n->l ) = TRUE ) then
		changed = TRUE
	end if

	if( astIntraTreeVectorize( n->r ) = TRUE ) then
		changed = TRUE
	end if

	function = changed
end function


private function hGetNextTree _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr nextNode = NULL

	do while ( n )
		'' if( hNodeEmitsCode( treeA ) ) then
		if( n->class <> AST_NODECLASS_DBG ) And _
			( n->class <> AST_NODECLASS_LIT ) And _
				( n->class <> AST_NODECLASS_LABEL ) And _
					( n->class <> AST_NODECLASS_DECL ) And _
						( n->class <> AST_NODECLASS_NOP ) And _
							( n->class <> AST_NODECLASS_SCOPEBEGIN ) And _
								( n->class <> AST_NODECLASS_SCOPEEND ) then
			nextNode = n
		end if
		if( nextNode ) then exit do
		n = n->next
	loop
	function = nextNode

end function

''  handle the variable initializer
private function hCheckLink _
	( _
		byval n as ASTNODE ptr _
	) as integer

	function = FALSE

	if( n->class <> AST_NODECLASS_LINK ) then exit function

	if( n->l->class <> AST_NODECLASS_DECL ) then exit function
	if( n->r->class = AST_NODECLASS_ASSIGN ) then
		function = TRUE
	end if

end function

''::::
'' compare treeA against treeB to see if they can be combined into vector operations.
'' if vectorization can be done, the ops in treeA are turned to vector ops and treeB is deleted.

sub astProcVectorize _
	( _
		byval p as ASTNODE ptr _
	)

	dim as ASTNODE ptr treeA = any, treeB = any, nodeA = any, nodeB = any, prev = any, nxt = any
	dim as integer intraTree = any, parallelA = any, parallelB = any, doNext = any

	treeA = hGetNextTree( p )

	do

		if( treeA = NULL ) then exit do

		nodeA = NULL
		parallelA = FALSE
		if( hCheckLink( treeA ) = TRUE ) then
			nodeA = treeA->r
		elseif( hIsVectorizable( treeA ) = TRUE ) then
			nodeA = treeA
			parallelA = TRUE
		end if

		maxVectorWidth = 4
		vectorWidth = 0

		treeB = treeA
		do

			treeB = hGetNextTree( treeB->next )

			intraTree = FALSE
			parallelB = FALSE

			if( ( treeB = NULL ) or ( parallelA = FALSE ) )then
				intraTree = TRUE
			else
				if( hIsVectorizable( treeB ) = TRUE ) then
					parallelB = TRUE
					nodeB = treeB
				else
					intraTree = TRUE
				end if
			end if

			doNext = TRUE
			if( parallelA and parallelB ) then
				if( hMergeNode( nodeA, nodeB, FALSE ) ) then
					vectorWidth = 0
					hMergeNode( nodeA, nodeB, TRUE )

					prev = treeB->prev
					nxt = treeB->next

					astDelTree treeB
					treeB = astNewNOP()
					treeB->prev = prev
					treeB->next = nxt

					treeB->prev->next = treeB
					if( treeB->next ) then
						treeB->next->prev = treeB
					end if
					doNext = FALSE
				else
					intraTree = TRUE
				end if
			end if

			if( ( intraTree = TRUE ) and ( env.clopt.vectorize >= FB_VECTORIZE_INTRATREE ) ) then
				maxVectorWidth = 4
				vectorWidth = 0
				do while ( astIntraTreeVectorize( nodeA ) )
				loop
			end if

			if( treeB ) then
				if( doNext ) then
					treeA = treeB
					exit do
				else
					treeB = treeB->next
				end if
			else
				exit do, do
			end if
		loop
	loop

end sub
