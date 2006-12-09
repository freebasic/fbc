''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2007 The FreeBASIC development team.
''
''	This program is free software; you can redistribute it and/or modify
''	it under the terms of the GNU General Public License as published by
''	the Free Software Foundation; either version 2 of the License, or
''	(at your option) any later version.
''
''	This program is distributed in the hope that it will be useful,
''	but WITHOUT ANY WARRANTY; without even the implied warranty of
''	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''	GNU General Public License for more details.
''
''	You should have received a copy of the GNU General Public License
''	along with this program; if not, write to the Free Software
''	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.

'' AST address-of nodes
'' l = expression; r = NULL
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ir.bi"
#include once "inc\ast.bi"

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
					FB_DATATYPE_POINTER + l->dtype, _
					l->subtype )

	if( n = NULL ) then
		return NULL
	end if

	'' must preserve the node or optimizations at newDEREF() will fail
	n->l = l
	n->sym = l->sym

	'' var?
	if( astIsVAR( l ) ) then
		n->ofs.ofs = l->var.ofs

	'' array..
	else
		n->ofs.ofs = l->idx.ofs + l->r->var.ofs + _
					 symbGetArrayDiff( l->sym ) + symbGetOfs( l->sym )
	end if

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
		vr = irAllocVROFS( n->dtype, sym, n->ofs.ofs )
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
    dim as integer dtype = any
    dim as FBSYMBOL ptr subtype = any

	if( l = NULL ) then
		return NULL
	end if

	'' check op overloading
	if( symb.globOpOvlTb(AST_OP_ADDROF).head <> NULL ) then
    	dim as FBSYMBOL ptr proc = any
    	dim as FB_ERRMSG err_num = any

		proc = symbFindUopOvlProc( AST_OP_ADDROF, l, @err_num )
		if( proc <> NULL ) then
			'' build a proc call
			return astBuildCall( proc, 1, l )
		else
			if( err_num <> FB_ERRMSG_OK ) then
				exit function
			end if
		end if
	end if

	dtype = l->dtype
	subtype = l->subtype

	select case as const l->class
	case AST_NODECLASS_DEREF
		if( env.clopt.extraerrchk ) then
           	removeNullPtrCheck( l )
		end if

		n = l->l
		'' @*const to const
		if( n->class = AST_NODECLASS_CONST ) then
			astDelNode( l )
			return n
		end if

		'' @[var] to nothing (can't be local or field)
		if( l->ptr.ofs = 0 ) then
			astDelNode( l )
			return n
		end if

	case AST_NODECLASS_FIELD
		'' @0->field to const
		n = l->l
		if( n->class = AST_NODECLASS_DEREF ) then
			if( env.clopt.extraerrchk ) then
           		removeNullPtrCheck( n )
           	end if

			dim as ASTNODE ptr nn = n->l
			if( nn <> NULL ) then
				'' abs address?
				if( nn->class = AST_NODECLASS_CONST ) then
					astDelNode( n )
					astDelNode( l )
					return nn
				end if

			'' just an offset..
			else
				'' !!!FIXME!!! should use LONG in 64-bit adressing mode
				nn = astNewCONSTi( n->ptr.ofs, FB_DATATYPE_INTEGER )

				astDelNode( n )
				astDelNode( l )
				return nn
			end if
		end if

	case AST_NODECLASS_VAR
		dim as FBSYMBOL ptr s = any

		'' module-level or local static scalar? use offset instead
		s = l->sym
		if( s <> NULL ) then
			if( (symbIsLocal( s ) = FALSE) or _
				 ((symbGetAttrib( s ) and (FB_SYMBATTRIB_SHARED or _
				 						   FB_SYMBATTRIB_COMMON or _
				 						   FB_SYMBATTRIB_STATIC)) <> 0) ) then
				return astNewOFFSET( l )
			end if
		end if

    case AST_NODECLASS_IDX
		'' no index expression? it's a const..
		if( l->l = NULL ) then
			dim as FBSYMBOL ptr s = any
			s = l->sym
			'' module-level or local static scalar? use offset instead
			if( (symbIsLocal( s ) = FALSE) or _
				 ((symbGetAttrib( s ) and (FB_SYMBATTRIB_SHARED or _
				 						   FB_SYMBATTRIB_COMMON or _
				 						   FB_SYMBATTRIB_STATIC)) <> 0) ) then

				'' can't be dynamic either
				if( symbGetIsDynamic( s ) = FALSE ) then
					return astNewOFFSET( l )
				end if
			end if
		end if

	end select

	'' alloc new node
	n = astNewNode( AST_NODECLASS_ADDROF, _
					FB_DATATYPE_POINTER + dtype, _
					subtype )
	if( n = NULL ) then
		exit function
	end if

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

			vr = irAllocVREG( FB_DATATYPE_POINTER )
			irEmitADDR( AST_OP_ADDROF, v1, vr )

		else
			vr = v1
		end if
	end if

	astDelNode( p )

	function = vr

end function

