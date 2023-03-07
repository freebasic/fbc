'' AST type initializer nodes
'' tree     : l = head; r = (when constructing: tail, when updating: base var)
'' expr node: l = expr; r = next
'' pad node : l = NULL; r = next
''
'' chng: mar/2006 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ir.bi"
#include once "ast.bi"

'':::::
function astTypeIniBegin _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval is_local as integer, _
		byval ofs as longint _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any

	'' alloc new node
	n = astNewNode( AST_NODECLASS_TYPEINI, _
					dtype, _
					subtype )
	function = n

	'' n is a newly allocated INITREE

	'' ofs will be zero unless the symbol passed in to cInitializer()
	'' had an offset due to a field initializers
	'' however, bytes initialized by this tree should start at zero.  Only
	'' when(if) this tree is merged to another tree do the bytes contribute
	'' to the parent.

	n->typeini.ofs = ofs
	n->typeini.bytes = 0

	dim as integer add_scope = FALSE
	if( is_local = FALSE ) then
		if( symbIsScope( parser.currblock ) ) then
			'' Don't add a new temp scope if already inside one
			'' (from a parent TYPEINI)
			add_scope = not astIsTYPEINI( parser.currblock->scp.backnode )
		else
			add_scope = TRUE
		end if
	end if

	if( add_scope ) then
		'' create a new scope block to handle temp vars allocated inside the
		'' tree - with shared vars, the temps must be moved to another function
		n->typeini.scp = astTempScopeBegin( n->typeini.lastscp, n )
	else
		n->typeini.scp = NULL
	end if

end function

private sub hAstTypeIniMaybeConvertUpcast _
	( _
		byval n as ASTNODE ptr, _
		byval l as ASTNODE ptr _
	)

	dim as FBSYMBOL ptr sym = any
	dim as longint maxsize = any

	sym = n->sym

	'' we want the size of the elements (type) not the whole array
	'' !!!TODO!!! byrefs? with symbGetRealSize( sym )?

	maxsize = symbGetLen( sym )

	'' This should only be true if astTypeIniAddAssign()
	'' determined that the initree was constant

	'' !!!TODO!!! there is a few places where we use the same
	'' pattern of if statements to check if one ast node is a type
	'' derived from another.  Maybe make a common function?

	if( typeGet( astGetDataType( n ) ) = FB_DATATYPE_STRUCT ) then
		if( typeGet( astGetDataType( l ) ) = FB_DATATYPE_STRUCT ) then
			if( astGetSubtype( n ) <> astGetSubtype( l ) ) then
				if( symbGetUDTBaseLevel( astGetSubtype( l ), astGetSubtype( n ) ) > 0 ) then

					'' patch the subtype (up-cast)
					l->subtype = n->subtype
					l->typeini.bytes = maxsize

					'' patch the next node too
					l->l->typeini.ofs = n->typeini.ofs
					l->l->typeini.bytes = maxsize
					l->l->subtype = n->subtype

					'' !!!TODO!!! confirm ast class? - it only makes sense if it
					'' is another TYPEINI node that tracks offset/bytes/type
					'' do we need this, or can it be assumed that everywhere handled
					'' this correctly?

					#ifdef __FB_DEBUG__
					select case astGetClass( l->l )
					case AST_NODECLASS_TYPEINI
					case AST_NODECLASS_TYPEINI_ASSIGN
					case AST_NODECLASS_TYPEINI_SCOPEINI
					case else
						assert( FALSE )
					end select
					#endif
				end if
			end if
		end if
	end if
end sub

'':::::
sub astTypeIniEnd _
	( _
		byval tree as ASTNODE ptr, _
		byval is_initializer as integer _
	)

	dim as ASTNODE ptr n = any, p = any, l = any, r = any
	dim as longint ofs = any, bytes = any

	assert( astIsTYPEINI( tree ) )

	'' can't leave r pointing to the any node as the
	'' tail node is linked already
	tree->r = NULL

	if( is_initializer = FALSE ) then
		'' We're going to use the TYPEINI as expression that will be astAdd'ed,
		'' to be updated by e.g. astTypeIniUpdate() later
		ast.typeinicount += 1
	end if
	'' Otherwise, if it's an initializer, it will either be passed to astTypeIniFlush() immediately,
	'' or kept in an FBSYMBOL.var_.initree. In this case there is no TYPEINI that would need to be
	'' registered for astTypeIniUpdate() later.

	'' merge nested type ini trees
	p = NULL
	n = tree->l
	do while( n <> NULL )
		'' expression node?
		if( n->class = AST_NODECLASS_TYPEINI_ASSIGN ) then

			'' n    = the typeini tree we want to update (what we are assigning)
			'' n->l = what we want to assign
			'' n->r = next item in the list

			l = n->l
			'' is it an ini tree too?
			if( astIsTYPEINI( l ) ) then
				ast.typeinicount -= 1

				'' current offset and size from the tree we are updating
				ofs = n->typeini.ofs
				bytes = n->typeini.bytes

				'' up-cast?
				hAstTypeIniMaybeConvertUpcast( n, l )

				r = n->r
				astDelNode( n )
				n = l->l
				astDelNode( l )

				'' relink
				if( p <> NULL ) then
					p->r = n
				else
					tree->l = n
				end if

				'' update the offset, using the parent's
				do while( n->r <> NULL )
					n->typeini.ofs += ofs
					n->typeini.bytes += bytes
					n = n->r
				loop
				n->typeini.ofs += ofs
				n->typeini.bytes += bytes

				n->r = r
			end if
		end if

		'' next
		p = n
		n = n->r
	loop

	'' close the scope block
	if( tree->typeini.scp <> NULL ) then
		astTempScopeEnd( tree->typeini.scp, tree->typeini.lastscp )
	end if

end sub

private function hAddNode _
	( _
		byval tree as ASTNODE ptr, _
		byval class_ as integer, _
		byval sym as FBSYMBOL ptr = NULL, _
		byval dtype as integer = FB_DATATYPE_INVALID, _
		byval subtype as FBSYMBOL ptr = NULL _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any

	assert( astIsTYPEINI( tree ) )

	if( (dtype = FB_DATATYPE_INVALID) and (sym <> NULL) ) then
		dtype = symbGetFullType( sym )
		subtype = symbGetSubtype( sym )
	end if

	''      tree      =>     tree
	''                       / \
	''                      n   n
	''
	''      tree      =>     tree     =>    tree
	''      / \              / \            / \
	''     l   r            l   r          l   n
	''                       \   \          \
	''                        n   n          n
	''
	''  tree       = AST_NODE_TYPEINI AST_NODECLASS_TYPEINI
	''  tree->l... = list of items in TREE
	''  tree->r    = last node of list

	n = astNewNode( class_, dtype, subtype )

	if( tree->r <> NULL ) then
		tree->r->r = n
	else
		tree->l = n
	end if
	tree->r = n

	function = n
end function

sub astTypeIniRemoveLastNode( byval tree as ASTNODE ptr )
	dim as ASTNODE ptr prev = any, n = any

	assert( astIsTYPEINI( tree ) )

	'' Find the last node, and the previous one
	prev = NULL
	n = tree->l
	while( n )

		'' Last node reached?
		if( n->r = NULL ) then
			assert( tree->r = n )
			assert( n <> prev )

			'' Unlink from the TYPEINI tree
			if( prev ) then
				assert( prev->r = n )
				prev->r = NULL
			else
				tree->l = NULL
			end if
			tree->r = prev

			astDelTree( n )
			exit while
		end if

		prev = n
		n = n->r
	wend
end sub

function astTypeIniAddPad _
	( _
		byval tree as ASTNODE ptr, _
		byval bytes as longint _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any

	assert( astIsTYPEINI( tree ) )

	n = hAddNode( tree, AST_NODECLASS_TYPEINI_PAD )
	n->typeini.bytes = bytes
	n->typeini.ofs = tree->typeini.ofs

	'' accumulate total bytes in this tree
	tree->typeini.bytes += n->typeini.bytes

	function = n
end function

private function hAstIniTreeIsConstant _
	( _
		byval tree as ASTNODE ptr _
	) as integer

	if( tree = NULL ) then
		return TRUE
	end if

	'' determine if the tree only contains constants and
	'' references and nothing that would need a temporary
	'' variable when upcasting.

	select case astGetClass( tree )
	case AST_NODECLASS_TYPEINI
	case AST_NODECLASS_TYPEINI_PAD
	case AST_NODECLASS_TYPEINI_ASSIGN
	case AST_NODECLASS_TYPEINI_CTORCALL
		return FALSE
	case AST_NODECLASS_TYPEINI_CTORLIST
		return FALSE
	case AST_NODECLASS_TYPEINI_SCOPEINI
	case AST_NODECLASS_TYPEINI_SCOPEEND
	case AST_NODECLASS_CALL
		return FALSE
	case AST_NODECLASS_CALLCTOR
		return FALSE
	case AST_NODECLASS_VAR
		return TRUE
	case AST_NODECLASS_CONST
		return TRUE

	'' assume anything else is not constant
	case else
		return FALSE

	end select

	if( tree->l ) then
		if( hAstIniTreeIsConstant( tree->l ) = FALSE ) then
			return FALSE
		end if
	end if

	if( tree->r ) then
		if( hAstIniTreeIsConstant( tree->r ) = FALSE ) then
			return FALSE
		end if
	end if

	return TRUE
end function


private sub hAstTypeIniTreeMergeUpcast _
	( _
		byval tree as ASTNODE ptr, _
		byval n as ASTNODE ptr, _
		byref expr as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr _
	)

	assert( astGetClass( n ) = AST_NODECLASS_TYPEINI_ASSIGN )
	assert( astGetClass( expr ) = AST_NODECLASS_TYPEINI )
	assert( n->l = expr )
	assert( typeGet( astGetDataType( n ) ) = FB_DATATYPE_STRUCT )

	''
	''              n (TYPEINI_ASSIGN)  base
	''             /
	''          expr (TYPEINI)          derived
	''
	'' if we got to here, then hDoAssign() would have identified this
	'' as an up-cast and we should take care when merging the trees
	'' our goal is that any assignment should not write outside the
	'' size of the target. hAstCheckTypeIniAssignment() called
	'' by astTypeIniFlush() will also check for initializers that
	'' write outside of the target and generate a warning with
	'' -w upcast.  This allows us to preserve the original typeini
	'' here for now.  What we don't want to do is lose information
	'' about the size of the original, lose any intitialers
	'' that are calls, or lose the size of the target.

	dim as integer maxsize = any

	'' maxsize = symbGetRealSize( sym )
	maxsize = symbGetLen( sym )

	'' too big for target?
	if( tree->typeini.ofs + expr->typeini.bytes > maxsize ) then

		'' If the struct we are initializing has no ctor/dtor and,
		'' if expr is all constant with no function calls, then we
		'' don't need the conversion and astTypeIniFlush() will warn
		'' us on discarded initializers.
		'' otherwise, assignment of expr to the tree would cause us
		'' to write outside of the target, so we need to add a
		'' conversion to force the use of a temprary variable

		var isconst = (hAstIniTreeIsConstant( expr ) = TRUE )
		var hasdtor = (symbGetCompDtor1( astGetSubtype( tree ) ) <> NULL)

		if( (isconst = FALSE) or (hasdtor = TRUE) ) then

			dim as ASTNODE ptr l = any

			'' hDoAssign() and astCheckASSIGNToType() should have ensured that
			'' this conversion should always work...
			l = astNewCONV( symbGetType( sym ), symbGetSubtype( sym ), expr )
			assert( l <> NULL )

			if( l <> NULL ) then
				n->l = l
			end if

		end if

		'' either way, don't exceed the maximum size
		tree->typeini.ofs += maxsize
		tree->typeini.bytes += maxsize

	'' otherwise, we are still writing within the
	'' limits of the target
	else
		tree->typeini.ofs += expr->typeini.bytes
		tree->typeini.bytes += expr->typeini.bytes
	end if

end sub

function astTypeIniAddAssign _
	( _
		byval tree as ASTNODE ptr, _
		byval expr as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval check_upcast as integer = FALSE _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any

	assert( astIsTYPEINI( tree ) )

	n = hAddNode( tree, AST_NODECLASS_TYPEINI_ASSIGN, sym, dtype, subtype )

	n->l = expr
	n->sym = sym
	n->typeini.ofs = tree->typeini.ofs
	n->typeini.bytes = 0

	'' sym only tells us the first field
	'' but the tree might actually be larger

	if( astGetClass( expr ) = AST_NODECLASS_TYPEINI ) then
		'' Check for up-casting but only if the caller requested it.
		'' Maybe we can always check for up-casting but until every caller
		'' is analyzed, it seems safer to only check if requested.
		dim as integer upcast = FALSE

		if( check_upcast ) then
			'' We need to preserve the size of the target even after the
			'' expression is merged with the initializer tree.  The merge is
			'' a kind of of assignment that won't be handled properly
			'' anywhere else if type or size information is lost or replaced
			'' by a larger type.  We need to avoid writing beyond the limits
			'' of the target.

			if( typeGet( dtype ) = FB_DATATYPE_STRUCT ) then
				if( typeGet( astGetDataType( expr ) ) = FB_DATATYPE_STRUCT ) then
					if( subtype <> astGetSubtype( expr ) ) then
						if( symbGetUDTBaseLevel( astGetSubtype( expr ), subtype ) > 0 ) then
							upcast = TRUE
						end if
					end if
				end if
			end if
		end if

		if( upcast ) then
			hAstTypeIniTreeMergeUpcast( tree, n, expr, sym )
		else
			tree->typeini.ofs += expr->typeini.bytes
			tree->typeini.bytes += expr->typeini.bytes
		end if
	else
		'' vars and fields could be byref / array / etc
		'' and boundstypeini may pass a NULL sym
		if( sym ) then
			if( symbIsRef( sym ) ) then
				n->typeini.bytes = env.pointersize
			else
				n->typeini.bytes = symbGetLen( sym )
			end if
		end if

		tree->typeini.ofs += n->typeini.bytes
		tree->typeini.bytes += n->typeini.bytes
	end if
	function = n
end function

function astTypeIniAddCtorCall _
	( _
		byval tree as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr, _
		byval procexpr as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any

	assert( astIsTYPEINI( tree ) )

	n = hAddNode( tree, AST_NODECLASS_TYPEINI_CTORCALL, sym, dtype, subtype )

	n->sym = sym
	n->typeini.ofs = tree->typeini.ofs
	n->typeini.bytes = symbGetLen( sym )

	n->l = procexpr

	tree->typeini.ofs += n->typeini.bytes
	tree->typeini.bytes += n->typeini.bytes

	function = n
end function

function astTypeIniAddCtorList _
	( _
		byval tree as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr, _
		byval elements as longint, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any

	assert( astIsTYPEINI( tree ) )

	n = hAddNode( tree, AST_NODECLASS_TYPEINI_CTORLIST, sym, dtype, subtype )

	n->sym = sym
	n->typeini.ofs = tree->typeini.ofs

	'' AST_NODECLASS_TYPEINI_CTORLIST node uses typeini.elements
	'' instead of typeini.bytes to track position in the typeini tree

	n->typeini.elements = elements

	tree->typeini.ofs += symbGetLen( sym ) * elements
	tree->typeini.bytes += symbGetLen( sym ) * elements

	function = n
end function

'' is_array tells the LLVM backend whether the initializer is for an array or a struct.
function astTypeIniScopeBegin _
	( _
		byval tree as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr, _
		byval is_array as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any

	assert( astIsTYPEINI( tree ) )

	n = hAddNode( tree, AST_NODECLASS_TYPEINI_SCOPEINI )
	n->sym = sym
	n->typeiniscope.is_array = is_array

	'' ofs and bytes (elements) should never be used for typeini scopes
	'' zero them out anyway so debugging display is a little nicer
	n->typeini.ofs = 0
	n->typeini.bytes = 0

	function = n
end function

function astTypeIniScopeEnd _
	( _
		byval tree as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any

	assert( astIsTYPEINI( tree ) )

	n = hAddNode( tree, AST_NODECLASS_TYPEINI_SCOPEEND )
	n->sym = sym

	'' ofs and bytes (elements) should never be used for typeini scopes
	'' zero them out anyway so debugging display is a little nicer
	n->typeini.ofs = 0
	n->typeini.bytes = 0

	function = n
end function

'' Takes an array elements initializer and adds the same TYPEINI_ASSIGN's to
'' the new typeini tree (duplicating the expressions),
'' but not the TYPEINI_SCOPEINI/TYPEINI_SCOPEEND,
'' and assuming there are only TYPEINI_ASSIGN's and no ctorcalls or padding etc.
'' "beginindex" is the index of the first TYPEINI_ASSIGN that should be copied,
'' this allows to skip some array elements at the front.
sub astTypeIniCopyElements _
	( _
		byval tree as ASTNODE ptr, _
		byval source as ASTNODE ptr, _
		byval beginindex as integer _
	)

	dim as integer i = any

	assert( astIsTYPEINI( tree ) )

	assert( astIsTYPEINI( source ) )
	source = source->l

	assert( source->class = AST_NODECLASS_TYPEINI_SCOPEINI )
	source = source->r

	i = 0
	while( source->class = AST_NODECLASS_TYPEINI_ASSIGN )
		if( i >= beginindex ) then
			astTypeIniAddAssign( tree, astCloneTree( source->l ), source->sym )
		end if
		source = source->r
		i += 1
	wend

	assert( source->class = AST_NODECLASS_TYPEINI_SCOPEEND )
end sub

sub astTypeIniReplaceElement _
	( _
		byval tree as ASTNODE ptr, _
		byval element as integer, _
		byval expr as ASTNODE ptr _
	)

	'' Walk through the TYPEINI tree until the assign at index "element"
	'' is reached, then replace the expression.
	'' assumptions:
	''    - tree is an array initializer,
	''    - there are only TYPEINI_ASSIGN's, no ctorcalls/padding

	dim as integer i = any

	assert( astIsTYPEINI( tree ) )
	tree = tree->l

	assert( tree->class = AST_NODECLASS_TYPEINI_SCOPEINI )
	tree = tree->r

	i = 0
	while( tree->class = AST_NODECLASS_TYPEINI_ASSIGN )
		if( i = element ) then
			astDelTree( tree->l )
			tree->l = expr
			exit sub
		end if
		tree = tree->r
		i += 1
	wend

	'' should always be found
	assert( FALSE )
end sub

private function hCallCtorList _
	( _
		byval t as ASTNODE ptr, _
		byval n as ASTNODE ptr, _
		byval target as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr fldexpr = any

	'' iter = *cast( subtype ptr, cast( byte ptr, @array(0) ) + ofs) )
	fldexpr = astBuildDerefAddrOf( astCloneTree( target ), n->typeini.ofs, n->dtype, n->subtype, n->sym )

	if( n->typeini.elements > 1 ) then
		dim as FBSYMBOL ptr cnt, label, iter

		cnt = symbAddTempVar( FB_DATATYPE_INTEGER )
		label = symbAddLabel( NULL )
		iter = symbAddTempVar( typeAddrOf( n->dtype ), n->subtype )

		t = astNewLINK( t, astBuildVarAssign( iter, astNewADDROF( fldexpr ), AST_OPOPT_ISINI ), AST_LINK_RETURN_NONE )

		'' for cnt = 0 to elements-1
		t = astBuildForBegin( t, cnt, label, 0 )

		'' ctor( *iter )
		t = astNewLINK( t, astBuildCtorCall( n->subtype, astBuildVarDeref( iter ) ), AST_LINK_RETURN_NONE )

		'' iter += 1
		t = astNewLINK( t, astBuildVarInc( iter, 1 ), AST_LINK_RETURN_NONE )

		'' next
		t = astBuildForEnd( t, cnt, label, astNewCONSTi( n->typeini.elements ) )
	else
		'' ctor( this )
		t = astNewLINK( t, astBuildCtorCall( n->subtype, fldexpr ), AST_LINK_RETURN_NONE )
	end if

	function = t
end function

private function hAstCheckTypeIniAssignment _
	( _
		byval n as ASTNODE ptr, _
		byval maxsize as longint, _
		byval scoped as integer _
	) as integer

	if( (maxsize > 0) ) then
		select case n->class
		case AST_NODECLASS_TYPEINI_PAD
			if( n->typeini.ofs + n->typeini.bytes > maxsize ) then
				return FALSE
			end if

		case else
			if( n->typeini.ofs + n->typeini.bytes > maxsize ) then
				if( fbPdCheckIsSet( FB_PDCHECK_UPCAST ) ) then
					errReportWarn( FB_WARNINGMSG_UPCASTDISCARDSINITIALIZER )
				end if
				return FALSE
			end if
		end select
	end if

	return TRUE
end function


'' Builds up code to write a TYPEINI tree into a target variable/deref,
'' and deletes the TYPEINI tree.
function astTypeIniFlush overload _
	( _
		byval target as ASTNODE ptr, _
		byval initree as ASTNODE ptr, _
		byval update_typeinicount as integer, _
		byval assignoptions as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any, nxt = any, t = any, l = any
	dim as longint maxsize = any
	dim as integer scoped = 0

	assert( astIsTYPEINI( initree ) )
	assert( astIsVAR( target ) or astIsDEREF( target ) or _
			astIsFIELD( target ) or astIsIDX( target ) )

	if( update_typeinicount ) then
		'' Unregister the TYPEINI - we're emitting it right now, no need
		'' for astTypeIniUpdate() later. This only makes sense for TYPEINIs
		'' that were previously registered via astTypeIniEnd(..., FALSE).
		ast.typeinicount -= 1
	end if

	'' maxsize of 0 indicates no checking for target size
	maxsize = 0

	if( astIsVAR( target ) or astIsField( target ) ) then
		maxsize = symbGetRealSize( target->sym )
	end if

	t = NULL
	n = initree->l

	'' Remove side-effects, if there's more than one initializer element,
	'' because every element uses one "instance" of the target expression.
	if( n ) then
		if( n->r ) then
			if( astHasSideFx( target ) ) then
				t = astRemSideFx( target )
			end if
		end if
	end if

	while( n )
		select case( n->class )
		'' Write the given initializer expression to the given offset in the target
		case AST_NODECLASS_TYPEINI_ASSIGN
			if( hAstCheckTypeIniAssignment( n, maxsize, scoped ) ) then
				if( n->sym ) then
					'' Field?
					if( symbIsField( n->sym ) ) then
						'' If it's a bitfield, clear the whole field containing this bitfield,
						'' otherwise the bitfield assignment(s) would leave unused bits
						'' uninitialized.
						if( symbFieldIsBitfield( n->sym ) ) then
							'' Beginning of a field containing one or more bitfields?
							if( n->sym->var_.bitpos = 0 ) then
								l = astBuildDerefAddrOf( astCloneTree( target ), n->typeini.ofs, n->dtype, n->subtype )
								l = astNewMEM( AST_OP_MEMCLEAR, l, astNewCONSTi( typeGetSize( symbGetFullType( n->sym ) ) ) )
								t = astNewLINK( t, l, AST_LINK_RETURN_NONE )
							end if
						end if
					end if
				end if

				l = astBuildDerefAddrOf( astCloneTree( target ), n->typeini.ofs, n->dtype, n->subtype, n->sym )

				l = astNewASSIGN( l, n->l, assignoptions or AST_OPOPT_DONTCHKPTR )
				assert( l )
				t = astNewLINK( t, l, AST_LINK_RETURN_NONE )
			end if

		'' Clear the given amount of bytes at the given offset in the target
		case AST_NODECLASS_TYPEINI_PAD
			if( hAstCheckTypeIniAssignment( n, maxsize, scoped ) ) then
				l = astBuildDerefAddrOf( astCloneTree( target ), n->typeini.ofs, n->dtype, n->subtype )
				l = astNewMEM( AST_OP_MEMCLEAR, l, astNewCONSTi( n->typeini.bytes ) )
				t = astNewLINK( t, l, AST_LINK_RETURN_NONE )
			end if

		'' Use the given CALL (and its ARGs) as-is, but insert the byref instance argument,
		'' pointing to the given offset in the target
		case AST_NODECLASS_TYPEINI_CTORCALL
			if( hAstCheckTypeIniAssignment( n, maxsize, scoped ) ) then
				l = astBuildDerefAddrOf( astCloneTree( target ), n->typeini.ofs, n->dtype, n->subtype, n->sym )

				l = astPatchCtorCall( n->l, l )
				t = astNewLINK( t, l, AST_LINK_RETURN_NONE )
			end if

		'' Build constructor calls for an array of elements
		case AST_NODECLASS_TYPEINI_CTORLIST
			t = hCallCtorList( t, n, target )

		case AST_NODECLASS_TYPEINI_SCOPEINI
			scoped += 1

		case AST_NODECLASS_TYPEINI_SCOPEEND
			scoped -= 1

		case else
			assert( FALSE )
		end select

		nxt = n->r
		astDelNode( n )
		n = nxt
	wend

	astDelNode( initree )

	astDelTree( target )
	function = t
end function

function astTypeIniFlush overload _
	( _
		byval target as FBSYMBOL ptr, _
		byval initree as ASTNODE ptr, _
		byval update_typeinicount as integer, _
		byval assignoptions as integer _
	) as ASTNODE ptr
	assert( astIsTYPEINI( initree ) )
	assert( symbIsVar( target ) )
	function = astTypeIniFlush( astNewVAR( target ), initree, update_typeinicount, assignoptions )
end function

private sub hFlushExprStatic( byval n as ASTNODE ptr, byval basesym as FBSYMBOL ptr )
	'' Get lhs symbol: maybe a field (in case of TYPEINI_ASSIGN in a struct),
	'' or the basesym (in case of TYPEINI_ASSIGN to global var).
	var sym = n->sym
	if( sym = NULL ) then
		sym = basesym
	end if

	var sdtype = symbGetType( sym )
	var sfulldtype = symbGetFullType( sym )
	if( symbIsRef( sym ) ) then
		'' Initializers for references initialize the pointer,
		'' not an object of the symbol's type.
		sdtype = typeAddrOf( sdtype )
		sfulldtype = typeAddrOf( sfulldtype )
	end if

	'' Get rhs expression
	var expr = n->l
	var edtype = astGetDataType( expr )

	dim as FBSYMBOL ptr litsym = NULL
	select case edtype
	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
		litsym = astGetStrLitSymbol( expr )
	end select

	'' not a literal string?
	if( litsym = NULL ) then
		'' offset?
		if( astIsOFFSET( expr ) ) then
			irEmitVARINIOFS( sym, astGetSymbol( expr ), expr->ofs.ofs )

		'' anything else
		else
			'' Explicit cast of an address?  We can discard the cast if it's an offset.
			scope
					var lexpr = expr->l
				while( lexpr )
					if( astIsOFFSET( lexpr ) ) then
						irEmitVARINIOFS( sym, astGetSymbol( lexpr ), lexpr->ofs.ofs )
						expr = NULL
						exit while
					end if
					lexpr = lexpr->l
				wend
			end scope

			if( expr ) then
				'' must be a constant
				assert( astIsCONST( expr ) )

				'' different types? and there was no explicit cast?
				if( edtype <> sdtype ) then
					expr = astNewCONV( sfulldtype, symbGetSubtype( sym ), expr, AST_CONVOPT_DONTCHKPTR )
					assert( expr <> NULL )
				end if

				if( typeGetClass( sdtype ) = FB_DATACLASS_FPOINT ) then
					irEmitVARINIf( sym, astConstGetFloat( expr ) )
				else
					irEmitVARINIi( sym, astConstGetInt( expr ) )
				end if
			end if
		end if
	'' literal string..
	else
		'' not a wstring?
		if( sdtype <> FB_DATATYPE_WCHAR ) then
			'' convert?
			if( edtype <> FB_DATATYPE_WCHAR ) then
				'' less the null-char
				irEmitVARINISTR( symbGetStrLen( sym ) - 1, _
				                 symbGetVarLitText( litsym ), _
				                 symbGetStrLen( litsym ) - 1 )
			else
				'' ditto
				irEmitVARINISTR( symbGetStrLen( sym ) - 1, _
				                 str( *symbGetVarLitTextW( litsym ) ), _
				                 symbGetWstrLen( litsym ) - 1 )
			end if
		'' wstring..
		else
			'' convert?
			if( edtype <> FB_DATATYPE_WCHAR ) then
				'' less the null-char
				irEmitVARINIWSTR( symbGetWstrLen( sym ) - 1, _
				                  wstr( *symbGetVarLitText( litsym ) ), _
				                  symbGetStrLen( litsym ) - 1 )
			else
				'' ditto
				irEmitVARINIWSTR( symbGetWstrLen( sym ) - 1, _
				                  symbGetVarLitTextW( litsym ), _
				                  symbGetWstrLen( litsym ) - 1 )
			end if
		end if
	end if

	astDelTree( n->l )
	n->l = NULL
end sub

sub astLoadStaticInitializer _
	( _
		byval tree as ASTNODE ptr, _
		byval basesym as FBSYMBOL ptr _
	)

	dim as ASTNODE ptr n = any, nxt = any

	assert( astIsTYPEINI( tree ) )

	irEmitVARINIBEGIN( basesym )

	n = tree->l
	do while( n <> NULL )
		nxt = n->r

		select case as const n->class
		case AST_NODECLASS_TYPEINI_PAD
			irEmitVARINIPAD( n->typeini.bytes )

		case AST_NODECLASS_TYPEINI_SCOPEINI
			irEmitVARINISCOPEBEGIN( n->sym, n->typeiniscope.is_array )

		case AST_NODECLASS_TYPEINI_SCOPEEND
			irEmitVARINISCOPEEND( )

		case else
			hFlushExprStatic( n, basesym )
		end select

		astDelNode( n )
		n = nxt
	loop

	irEmitVARINIEND( basesym )

	astDelNode( tree )
end sub

private function hExprIsConst( byval n as ASTNODE ptr ) as integer
	var lsym = n->sym
	if( lsym ) then
		'' Disallow initialization of global bitfields (not implemented)
		if( symbIsBitfield( lsym ) ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE )
			return FALSE
		end if
	end if

	var expr = n->l

	'' Expression must be:
	'' - constant, or
	'' - address-of global, or
	'' - conversion of address of global
	'' to be usable in global initializer.
	'' we should not need to worry about conversions / castings of contants
	'' because they should have been constant folded by now.

	select case( expr->class )
	case AST_NODECLASS_OFFSET, AST_NODECLASS_CONST
		return TRUE
	case AST_NODECLASS_CONV
		'' allow conversion of OFFSET's
		while( expr )
			select case( expr->class )
			case AST_NODECLASS_CONV
			case AST_NODECLASS_OFFSET
				return TRUE
			case else
				exit while
			end select
			expr = expr->l
		wend
		return FALSE
	end select

	'' Or a string literal, for a global string.
	select case( astGetDataType( expr ) )
	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
		if( astGetStrLitSymbol( expr ) ) then
			return TRUE
		end if
	end select

	return FALSE
end function

function astTypeIniIsConst( byval tree as ASTNODE ptr ) as integer
	assert( astIsTYPEINI( tree ) )

	var n = tree->l
	while( n )
		select case( n->class )
		case AST_NODECLASS_TYPEINI_ASSIGN
			if( hExprIsConst( n ) = FALSE ) then
				return FALSE
			end if
		case AST_NODECLASS_TYPEINI_CTORCALL, AST_NODECLASS_TYPEINI_CTORLIST
			return FALSE
		end select
		n = n->r
	wend
	return TRUE
end function

function astTypeIniUsesLocals _
	( _
		byval n as ASTNODE ptr, _
		byval ignoreattrib as integer _
	) as integer

	if( n = NULL ) then
		return FALSE
	end if

	#if __FB_DEBUG__
		static as integer reclevel
		if( reclevel = 0 ) then
			assert( astIsTYPEINI( n ) )
		end if
	#endif

	'' Some TYPEINI expressions (like param/field initializers) can not
	'' reference local vars because they may be duplicated into other scope
	'' contexts, where those locals do not exist. In their case, only temp
	'' vars/descriptors can be allowed, because they're handled by the
	'' TYPEINI's implicit scope and will be duplicated along with the
	'' expression. Local STATICs can be allowed too, because they're not
	'' allocated on stack but instead as globals.
	''
	'' For other TYPEINI expressions such as global var initializers,
	'' no locals (including local statics) can be allowed at all, because by
	'' the time the global vars will be emitted, procs and their locals are
	'' emitted and deleted already.
	''
	'' TYPEINI expressions for local vars don't even need to be checked with
	'' this function because they stay in the scope where they are found
	'' and thus can use as many locals as they want.

	if( astIsVAR( n ) ) then
		'' ignoreattrib = the "good" attributes that should be allowed,
		'' i.e. don't count as "locals" to this function. If we find
		'' a LOCAL here, we only report it back to the caller if it
		'' has none of these attributes.
		if( symbIsLocal( n->sym ) and _
			((symbGetAttrib( n->sym ) and ignoreattrib) = 0) ) then
			return TRUE
		end if
	end if

	#if __FB_DEBUG__
		reclevel += 1
	#endif

	'' walk
	function = astTypeIniUsesLocals( n->l, ignoreattrib ) or _
			astTypeIniUsesLocals( n->r, ignoreattrib )

	#if __FB_DEBUG__
		reclevel -= 1
	#endif
end function

private function hWalk _
	( _
		byval n as ASTNODE ptr, _
		byval parent as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr expr = any
	dim as FBSYMBOL ptr sym = any

	if( n = NULL ) then
		return NULL
	end if

	if( astIsTYPEINI( n ) ) then
		'' Create a temporary variable which is initialized by the
		'' astTypeIniFlush() below.
		sym = symbAddTempVar( astGetFullType( n ), n->subtype )
		astDtorListAdd( sym )

		'' Update the parent node in the original tree to access the
		'' temporary variable, instead of the TYPEINI. (it could be an
		'' ASSIGN, ADDROF, ARG, etc, or a fake temporary parent node in
		'' case that TYPEINI was the root of the original tree)
		expr = astNewVAR( sym )
		if( parent->l = n ) then
			parent->l = expr
		else
			parent->r = expr
		end if

		'' Turn this TYPEINI into real code
		n = astTypeIniFlush( sym, n, TRUE, AST_OPOPT_ISINI )

		'' Also update any nested TYPEINIs, for example this can be a
		'' TYPEINI CTORCALL, which carries a CALL with ARGs that can
		'' have TYPEINIs themselves.
		return astTypeIniUpdate( n )
	end if

	'' walk
	return astNewLINK( hWalk( n->l, n ), hWalk( n->r, n ), AST_LINK_RETURN_NONE )
end function

#if __FB_DEBUG__
'' Count the TYPEINI nodes in a tree
function astCountTypeinis( byval n as ASTNODE ptr ) as integer
	dim as integer count = any

	count = 0

	if( n ) then
		if( astIsTYPEINI( n ) ) then
			count += 1
		end if

		count += astCountTypeinis( n->l )
		count += astCountTypeinis( n->r )
	end if

	function = count
end function
#endif

function astTypeIniUpdate( byval tree as ASTNODE ptr ) as ASTNODE ptr
	dim as ASTNODE ptr tempvarinitcode = any
	dim as ASTNODE treeparent = any

	'' tree passed in here can be any kind of tree, not just TYPEINI

	'' Shouldn't miss any TYPEINIs
	assert( astCountTypeinis( tree ) <= ast.typeinicount )

	'' Shortcut if there are no TYPEINIs
	if( ast.typeinicount <= 0 ) then
		return tree
	end if

	'' Wrap the tree in a fake temporary parent node, so hWalk() has a
	'' parent node to update in case the tree's root already is a TYPEINI.
	'' (Set it to NOP, to add some consistency with real ASTNODEs, better
	'' than nothing. NOPs don't require any other ASTNODE fields to be set)
	astInitNode( (@treeparent), AST_NODECLASS_NOP, FB_DATATYPE_INVALID, NULL )
	treeparent.l = tree

	'' Walk to expand any TYPEINIs. Note that the original tree will be
	'' updated too, and both are needed. The new tree built up by hWalk()
	'' initializes the temp var with the TYPEINI data; the original tree
	'' must be updated to now access that temp var instead of the TYPEINI.
	tempvarinitcode = hWalk( tree, @treeparent )

	'' The temp var initialization must be first in the LINK because it must
	'' be executed before the tree which accesses that temp var. The LINK
	'' as a whole should still return the result of the tree though, so that
	'' astTypeIniUpdate() can be used in the middle of an expression.
	function = astNewLINK( tempvarinitcode, treeparent.l, AST_LINK_RETURN_RIGHT )
end function

'' Duplicates a TYPEINI initializer into the current context. The cloned TYPEINI
'' won't have a temp scope on its own; instead any temp symbols from the
'' original TYPEINI's temp scope are duplicated into the current scope context.
function astTypeIniClone( byval tree as ASTNODE ptr ) as ASTNODE ptr
	dim as ASTNODE ptr clonetree = any

	assert( astIsTYPEINI( tree ) )

	clonetree = astCloneTree( tree )

	if( tree->typeini.scp ) then
		astTempScopeClone( tree->typeini.scp, clonetree )
	end if

	function = clonetree
end function

'' If it's only a TYPEINI_ASSIGN, and not for an UDT with a single field,
'' then just remove the TYPEINI( TYPEINI_ASSIGN( foo ) ) and return only foo.
function astTypeIniTryRemove( byval tree as ASTNODE ptr ) as ASTNODE ptr
	assert( astIsTYPEINI( tree ) )

	function = tree

	'' More than one node?
	if( tree->l->r ) then
		exit function
	end if

	'' First node is not a TYPEINI_ASSIGN?
	if( tree->l->class <> AST_NODECLASS_TYPEINI_ASSIGN ) then
		exit function
	end if

	'' Not the same type (detects the case when the TYPEINI is for an UDT,
	'' and the first TYPEINI_ASSIGN is for the first field)
	if( (astGetDataType( tree ) <> astGetDataType( tree->l )) or _
		(tree->subtype <> tree->l->subtype) ) then
		exit function
	end if

	function = tree->l->l
	astDelNode( tree->l )
	astDelNode( tree )
	ast.typeinicount -= 1
end function

'' For deleting param/var/field initializer TYPEINIs and their temp scope
sub astTypeIniDelete( byval tree as ASTNODE ptr )
	assert( astIsTYPEINI( tree ) )

	if( tree->typeini.scp ) then
		astTempScopeDelete( tree->typeini.scp )
		tree->typeini.scp = NULL
	end if

	astDelTree( tree )
end sub
