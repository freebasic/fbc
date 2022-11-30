'' AST address-of nodes
'' l = expression; r = NULL
''
'' chng: sep/2004 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "ast.bi"

function astGetOFFSETChildOfs( byval l as ASTNODE ptr ) as longint
	'' var?
	if( astIsVAR( l ) ) then
		function = l->var_.ofs
	'' array..
	else
		function = l->idx.ofs + l->r->var_.ofs + _
					 symbGetArrayDiff( l->sym ) + symbGetOfs( l->sym )
	end if
end function

private function astNewOFFSET( byval l as ASTNODE ptr ) as ASTNODE ptr
	dim as ASTNODE ptr n = any

	if( l = NULL ) then
		return NULL
	end if

	'' alloc new node
	n = astNewNode( AST_NODECLASS_OFFSET, _
					typeAddrOf( astGetFullType( l ) ), _
					l->subtype )

	'' must preserve the node or optimizations at newDEREF() will fail
	n->l = l
	n->sym = l->sym

	'' must be computed here or optimizations that depend on 0 offset values will fail
	n->ofs.ofs = astGetOFFSETChildOfs( l )

	'' access counter must be updated here too
	'' because the var initializers used with static strings
	if( l->sym <> NULL ) then
		symbSetIsAccessed( l->sym )
	end if

	function = n
end function

function astLoadOFFSET( byval n as ASTNODE ptr ) as IRVREG ptr
	dim as IRVREG ptr vr = any
	dim as FBSYMBOL ptr sym = any
	dim as ASTNODE ptr l = any

	sym = n->sym
	if( sym <> NULL ) then
		symbSetIsAccessed( sym )
	end if

	if( ast.doemit ) then
		vr = irAllocVROFS( astGetFullType( n ), n->subtype, sym, n->ofs.ofs )
	end if

	l = n->l

	'' array?
	if( astIsIDX( l ) ) then
		astDelNode( l->l )
		astDelNode( l->r )
	end if

	astDelNode( l )

	function = vr
end function

private sub hRemoveNullPtrCheck( byval l as ASTNODE ptr )
	dim as ASTNODE ptr n = any, t = any

	'' ptr checks must be removed because a null pointer is ok
	'' when taking the address-of an expression

	n = l->l

	if( n = NULL ) then
		exit sub
	end if

	select case n->class
	case AST_NODECLASS_PTRCHK
		l->l = n->l
		'' del func call tree
		astDelTree( n->r )
		'' del the checking node
		astDelNode( n )

	'' remove null-ptr checks in ptr indexing
	case AST_NODECLASS_BOP
		do
			t = n->l
			select case t->class
			case AST_NODECLASS_PTRCHK
				n->l = t->l
				astDelTree( t->r )
				astDelNode( t )
				exit do

			case AST_NODECLASS_BOP
				n = t

			case else
				exit do
			end select
		loop
	end select
end sub

function astNewADDROF( byval l as ASTNODE ptr ) as ASTNODE ptr
	dim as ASTNODE ptr n = any
	dim as integer dtype = any
	dim as FBSYMBOL ptr subtype = any

	if( l = NULL ) then
		return NULL
	end if

	'' skip any casting if they won't do any conversion
	dim as ASTNODE ptr t = astSkipNoConvCAST( l )

	n = NULL

	select case( t->class )
	case AST_NODECLASS_DEREF
		if( env.clopt.nullptrchk ) then
			hRemoveNullPtrCheck( t )
		end if

		'' astNewDEREF() on a CONST stores the CONST's value into its
		'' ASTNODE.ptr.ofs field and then uses a NULL lhs.
		if( t->l ) then
			'' @*nonconst  ->  nonconst
			if( t->ptr.ofs = 0 ) then
				n = t->l
				astDelNode( t ) '' DEREF
			end if
		else
			'' @*const  ->  const
			n = astNewCONSTi( t->ptr.ofs )
			astDelNode( t )  '' DEREF
		end if

	case AST_NODECLASS_FIELD
		'' @0->field to const
		if( t->l->class = AST_NODECLASS_DEREF ) then
			if( env.clopt.nullptrchk ) then
				hRemoveNullPtrCheck( t->l )
			end if

			'' astNewDEREF() on a CONST stores the CONST's value into its
			'' ASTNODE.ptr.ofs field and then uses a NULL lhs.
			if( t->l->l = NULL ) then
				'' @*const  ->  const
				n = astNewCONSTi( t->l->ptr.ofs )
				astDelNode( t->l )  '' DEREF
				astDelNode( t )     '' FIELD
			end if
		end if

	case AST_NODECLASS_VAR
		dim as FBSYMBOL ptr s = any

		'' module-level or local static scalar? use offset instead
		s = t->sym
		if( s <> NULL ) then
			if( (symbIsLocal( s ) = FALSE) or _
				 ((symbGetAttrib( s ) and (FB_SYMBATTRIB_SHARED or _
				                           FB_SYMBATTRIB_COMMON or _
				                           FB_SYMBATTRIB_STATIC)) <> 0) ) then
				n = astNewOFFSET( t )
			end if
		end if

	case AST_NODECLASS_IDX
		'' try to remove the idx node if it's a constant expr
		if( t <> l ) then
			t = astOptimizeTree( t )
			l->l = t
		else
			t = astOptimizeTree( t )
			l = t
		end if

		'' no index expression? it's a const..
		if( t->l = NULL ) then
			dim as FBSYMBOL ptr s = any
			s = t->sym
			'' module-level or local static scalar? use offset instead
			if( (symbIsLocal( s ) = FALSE) or _
				 ((symbGetAttrib( s ) and (FB_SYMBATTRIB_SHARED or _
				                           FB_SYMBATTRIB_COMMON or _
				                           FB_SYMBATTRIB_STATIC)) <> 0) ) then
				'' can't be dynamic either
				if( symbGetIsDynamic( s ) = FALSE ) then
					n = astNewOFFSET( t )
				end if
			end if
		end if

	end select

	'' ADDROF's data type should always be determined based on the data type
	'' of the top level node of its lhs.
	dtype = typeAddrOf( l->dtype )
	subtype = l->subtype

	if( n ) then
		if( t <> l ) then
			astDelNode( l )  '' CONV that was skipped above
		end if
		'' Don't warn CONST changes, we should have already got the warnings on previous CONV node's
		return astNewCONV( dtype, subtype, n, AST_CONVOPT_DONTCHKPTR or AST_CONVOPT_DONTWARNCONST )
	end if

	'' alloc new node
	n = astNewNode( AST_NODECLASS_ADDROF, dtype, subtype )
	n->op.op = AST_OP_ADDROF
	n->l = l

	function = n
end function

function astLoadADDROF( byval n as ASTNODE ptr ) as IRVREG ptr
	dim as ASTNODE ptr p = any
	dim as IRVREG ptr v1 = any, vr = any

	p  = n->l
	if( p = NULL ) then
		return NULL
	end if

	v1 = astLoad( p )

	if( ast.doemit ) then
		'' src is not a reg?
		if( (irIsREG( v1 ) = FALSE) or _
			(typeGetClass(v1->dtype) <> FB_DATACLASS_INTEGER) or _
			(typeGetSize(v1->dtype) <> env.pointersize) ) then

			vr = irAllocVREG( astGetFullType( n ), n->subtype )
			irEmitADDR( AST_OP_ADDROF, v1, vr )

		else
			vr = v1
		end if
	end if

	astDelNode( p )

	function = vr
end function
