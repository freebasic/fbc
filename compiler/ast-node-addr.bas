'' AST address-of nodes
'' l = expression; r = NULL
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "ast.bi"

'':::::
function astGetOFFSETChildOfs _
	( _
		byval l as ASTNODE ptr _
	) as integer

	'' var?
	if( astIsVAR( l ) ) then
		function = l->var_.ofs

	'' array..
	else
		function = l->idx.ofs + l->r->var_.ofs + _
					 symbGetArrayDiff( l->sym ) + symbGetOfs( l->sym )
	end if

end function

'':::::
function astNewOFFSET _
	( _
		byval l as ASTNODE ptr _
	) as ASTNODE ptr

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

'':::::
function astLoadOFFSET _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

    dim as IRVREG ptr vr = any
    dim as FBSYMBOL ptr sym = any
	dim as ASTNODE ptr l = any

	sym = n->sym
	if( sym <> NULL ) then
		symbSetIsAccessed( sym )
	end if

	if( ast.doemit ) then
		vr = irAllocVROFS( astGetDataType( n ), n->subtype, sym, n->ofs.ofs )
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

'':::::
private sub removeNullPtrCheck _
	( _
		byval l as ASTNODE ptr _
	)

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

'':::::
function astNewADDROF _
	( _
		byval l as ASTNODE ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any
    dim as FBSYMBOL ptr subtype = any

	if( l = NULL ) then
		return NULL
	end if

	subtype = l->subtype

	'' skip any casting if they won't do any conversion
	dim as ASTNODE ptr t = l
	if( l->class = AST_NODECLASS_CONV ) then
		if( l->cast.doconv = FALSE ) then
			t = l->l
		end if
	end if

	select case as const t->class
	case AST_NODECLASS_DEREF
		if( env.clopt.extraerrchk ) then
           	removeNullPtrCheck( t )
		end if

		n = t->l
		
		'' handle error recovery
		if( n = NULL ) then
			return NULL
		end if
		
		'' @*const to const
		if( n->class = AST_NODECLASS_CONST ) then
			astDelNode( t )
			if( t <> l ) then
				astDelNode( l )
			end if
			return n
		end if

		'' @[var] to nothing (can't be local or field)
		if( t->ptr.ofs = 0 ) then
			astDelNode( t )
			if( t <> l ) then
				astDelNode( l )
			end if
			return n
		end if

	case AST_NODECLASS_FIELD
		'' @0->field to const
		n = t->l
		if( n->class = AST_NODECLASS_DEREF ) then
			if( env.clopt.extraerrchk ) then
           		removeNullPtrCheck( n )
           	end if

			dim as ASTNODE ptr nn = n->l
			if( nn <> NULL ) then
				'' abs address?
				if( nn->class = AST_NODECLASS_CONST ) then
					astDelNode( n )
					astDelNode( t )
					if( t <> l ) then
						astDelNode( l )
					end if
					return nn
				end if

			'' just an offset..
			else
				'' !!!FIXME!!! should use LONG in 64-bit adressing mode
				nn = astNewCONSTi( n->ptr.ofs, FB_DATATYPE_INTEGER )

				astDelNode( n )
				astDelNode( t )
				if( t <> l ) then
					astDelNode( l )
				end if
				return nn
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
				if( t <> l ) then
					astDelNode( l )
				end if

				return astNewOFFSET( t )
			end if
		end if

    case AST_NODECLASS_IDX
		'' try to remove the idx node if it's a constant expr
		t = astOptimizeTree( t )
		if( t <> l ) then
			l->l = t
		else
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
					if( t <> l ) then
						astDelNode( l )
					end if
					return astNewOFFSET( t )
				end if
			end if
		end if

	end select

	'' alloc new node
	n = astNewNode( AST_NODECLASS_ADDROF, _
					typeAddrOf( astGetFullType( l ) ), _
					subtype )

	n->op.op = AST_OP_ADDROF
	n->l = l

	function = n

end function

'':::::
function astLoadADDROF _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

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
			(irGetVRDataClass( v1 ) <> FB_DATACLASS_INTEGER) or _
			(irGetVRDataSize( v1 ) <> FB_POINTERSIZE) ) then

			vr = irAllocVREG( astGetDataType( n ), n->subtype )
			irEmitADDR( AST_OP_ADDROF, v1, vr )

		else
			vr = v1
		end if
	end if

	astDelNode( p )

	function = vr

end function

