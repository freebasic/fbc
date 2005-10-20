''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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

'' AST addresing nodes
'' l = expression; r = NULL
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ir.bi"
#include once "inc\ast.bi"

'':::::
function astNewOFFSET( byval l as ASTNODE ptr, _
					   byval sym as FBSYMBOL ptr = NULL, _
					   byval elm as FBSYMBOL ptr = NULL ) as ASTNODE ptr static
	dim as ASTNODE ptr n

	if( l = NULL ) then
		return NULL
	end if

	'' alloc new node
	n = astNewNode( AST_NODECLASS_OFFSET, IR_DATATYPE_POINTER + l->dtype, l->subtype )

	if( n = NULL ) then
		return NULL
	end if

	n->l  		= l
	n->addr.sym	= sym
	n->addr.elm	= elm
	n->chkbitfld= elm <> NULL

	'' access counter must be updated here too
	'' because the var initializers used with static strings
	if( sym <> NULL ) then
		symbIncAccessCnt( sym )
	end if

	function = n

end function

'':::::
function astLoadOFFSET( byval n as ASTNODE ptr ) as IRVREG ptr static
    dim as ASTNODE ptr v
    dim as IRVREG ptr vr
    dim as FBSYMBOL ptr s

	v = n->l
	if( v = NULL ) then
		return NULL
	end if

	s = v->var.sym
	if( s <> NULL ) then
		symbIncAccessCnt( s )
	end if

	if( ast.doemit ) then
		vr = irAllocVROFS( n->dtype, s )
	end if

	astDel( v )

	function = vr

end function

'':::::
function astNewADDR( byval op as integer, _
					 byval l as ASTNODE ptr, _
					 byval sym as FBSYMBOL ptr = NULL, _
					 byval elm as FBSYMBOL ptr = NULL ) as ASTNODE ptr static

    dim as ASTNODE ptr n
    dim as integer delchild, dtype
    dim as FBSYMBOL ptr subtype

	if( l = NULL ) then
		return NULL
	end if

	dtype    = l->dtype
	subtype  = l->subtype
	delchild = FALSE

	if( op = IR_OP_ADDROF ) then
		select case l->class
		'' convert @* to nothing
		case AST_NODECLASS_ADDR
			if( l->op = IR_OP_DEREF ) then
				delchild = TRUE
				dtype -= IR_DATATYPE_POINTER
			end if

		case AST_NODECLASS_PTR
			'' abs address?
			if( l->l->class = AST_NODECLASS_CONST ) then
				n = l->l
				astDel( l )
				return n
			'' not local or field?
			elseif( l->ptr.ofs = 0 ) then
				delchild = TRUE
			end if

		'' static scalar? use offset instead
		case AST_NODECLASS_VAR
			if( l->var.ofs = 0 ) then
				return astNewOFFSET( l, sym, elm )
			end if

		end select

		''
		if( delchild ) then
			n = l->l
			astDel( l )
			l = n
			op = IR_OP_DEREF
		end if

	'' DEREF
	else
		'' convert *@ to nothing
		select case l->class
		case AST_NODECLASS_ADDR
			if( l->op = IR_OP_ADDROF ) then
				delchild = TRUE
			end if
		case AST_NODECLASS_OFFSET
			delchild = TRUE
		end select

		''
		if( delchild ) then
			n = l->l
			n->dtype   = dtype - IR_DATATYPE_POINTER
			n->subtype = subtype
			astDel( l )
			return n
		end if
	end if

	'' alloc new node
	n = astNewNode( AST_NODECLASS_ADDR, IR_DATATYPE_POINTER + dtype, subtype )
	if( n = NULL ) then
		exit function
	end if

	n->op 		= op
	n->l  		= l
	n->addr.sym	= sym
	n->addr.elm	= elm
	n->chkbitfld= elm <> NULL

	function = n

end function

'':::::
function astLoadADDR( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr p
    dim as IRVREG ptr v1, vr

	p  = n->l
	if( p = NULL ) then
		return NULL
	end if

	v1 = astLoad( p )

	if( ast.doemit ) then
		'' src is not a reg?
		if( (not irIsREG( v1 )) or _
			(irGetVRDataClass( v1 ) <> IR_DATACLASS_INTEGER) or _
			(irGetVRDataSize( v1 ) <> FB_POINTERSIZE) ) then

			vr = irAllocVREG( IR_DATATYPE_POINTER )
			irEmitADDR( n->op, v1, vr )

		else
			vr = v1
		end if
	end if

	astDel( p )

	function = vr

end function

