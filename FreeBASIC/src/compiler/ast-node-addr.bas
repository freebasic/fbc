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

'' AST addressing nodes
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

	n->l = l
	n->sym = l->sym
	n->ofs.ofs = l->var.ofs

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

    dim as ASTNODE ptr v = any
    dim as IRVREG ptr vr = any
    dim as FBSYMBOL ptr sym = any

	v = n->l
	if( v = NULL ) then
		return NULL
	end if

	sym = v->sym
	if( sym <> NULL ) then
		symbSetIsAccessed( sym )
	end if

	if( ast.doemit ) then
		vr = irAllocVROFS( n->dtype, sym, n->ofs.ofs )
	end if

	astDelNode( v )

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
function astNewADDR _
	( _
		byval op as integer, _
		byval l as ASTNODE ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any
    dim as integer delchild = any, dtype = any
    dim as FBSYMBOL ptr subtype = any, s = any, proc = any
    dim as FB_ERRMSG err_num = any

	if( l = NULL ) then
		return NULL
	end if

	'' check op overloading
	if( symb.globOpOvlTb(op).head <> NULL ) then
		proc = symbFindUopOvlProc( op, l, @err_num )
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
	delchild = FALSE

	if( op = AST_OP_ADDROF ) then

		select case as const l->class
		case AST_NODECLASS_ADDR
			'' convert @* to nothing
			if( l->op.op = AST_OP_DEREF ) then
				delchild = TRUE
				dtype -= FB_DATATYPE_POINTER
			end if

		case AST_NODECLASS_PTR
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
				delchild = TRUE
			end if

		case AST_NODECLASS_FIELD
			'' @0->field to const
			n = l->l
			if( n->class = AST_NODECLASS_PTR ) then
				if( env.clopt.extraerrchk ) then
            		removeNullPtrCheck( n )
            	end if

				n = n->l
				'' abs address?
				if( n->class = AST_NODECLASS_CONST ) then
					astDelNode( l->l )
					astDelNode( l )
					return n
				end if
			end if

		case AST_NODECLASS_VAR
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
		end select

		''
		if( delchild ) then
			n = l->l
			astDelNode( l )
			l = n
			op = AST_OP_DEREF
		end if

	'' DEREF
	else
		'' convert *@ to nothing
		select case l->class
		case AST_NODECLASS_ADDR
			delchild = (l->op.op = AST_OP_ADDROF)

		case AST_NODECLASS_OFFSET
			delchild = (l->ofs.ofs = 0)
		end select

		''
		if( delchild ) then
			n = l->l
			astSetType( n, dtype - FB_DATATYPE_POINTER, subtype )
			astDelNode( l )
			return n
		end if
	end if

	'' alloc new node
	n = astNewNode( AST_NODECLASS_ADDR, _
					FB_DATATYPE_POINTER + dtype, _
					subtype )
	if( n = NULL ) then
		exit function
	end if

	n->op.op = op
	n->l = l

	function = n

end function

'':::::
function astLoadADDR _
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
			irEmitADDR( n->op.op, v1, vr )

		else
			vr = v1
		end if
	end if

	astDelNode( p )

	function = vr

end function

