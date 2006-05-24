''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2006 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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

'' AST pointer nodes
'' l = pointer expression; r = NULL
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ir.bi"
#include once "inc\ast.bi"

'':::::
function astNewPTR _
	( _
		byval ofs as integer, _
		byval l as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr static

    dim as ASTNODE ptr n
    dim as integer delchild

	'' alloc new node
	n = astNewNode( AST_NODECLASS_PTR, _
					dtype, _
					subtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	if( l <> NULL ) then
		delchild = FALSE

		'' convert *@ to nothing
		select case l->class
		case AST_NODECLASS_ADDR
			if( l->op.op = AST_OP_ADDROF ) then
				delchild = TRUE
			end if

		case AST_NODECLASS_OFFSET
			delchild = TRUE
		end select

		''
		if( delchild ) then
			n = l->l
			astSetType( n, dtype, subtype )
			astDelNode( l )
			return n
		end if
	end if

	n->l = l
	n->ptr.ofs = ofs

end function

'':::::
function astLoadPTR _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

    dim as ASTNODE ptr l
    dim as IRVREG ptr v1, vp, vr

	l = n->l
	'' no index? can happen with absolute addresses + ptr typecasting
	if( l = NULL ) then
		if( ast.doemit ) then
			vr = irAllocVRPTR( n->dtype, n->ptr.ofs, NULL )
		end if
		return vr
	end if

	v1 = astLoad( l )

	''
	if( ast.doemit ) then
		'' src is not a reg?
		if( (irIsREG( v1 ) = FALSE) or _
			(irGetVRDataClass( v1 ) <> FB_DATACLASS_INTEGER) or _
			(irGetVRDataSize( v1 ) <> FB_POINTERSIZE) ) then

			vp = irAllocVREG( FB_DATATYPE_POINTER )
			irEmitADDR( AST_OP_DEREF, v1, vp )
		else
			vp = v1
		end if

		vr = irAllocVRPTR( n->dtype, n->ptr.ofs, vp )
	end if

	astDelNode( l )

	function = vr

end function

