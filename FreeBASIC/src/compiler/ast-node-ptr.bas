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

'' AST deref pointer nodes
'' l = pointer expression; r = NULL
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ir.bi"
#include once "inc\ast.bi"

'':::::
function astNewDEREF _
	( _
		byval ofs as integer, _
		byval l as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any

	if( l <> NULL ) then
		if( ofs = 0 ) then
			'' check op overloading
			if( symb.globOpOvlTb(AST_OP_DEREF).head <> NULL ) then
    			dim as FBSYMBOL ptr proc = any
    			dim as FB_ERRMSG err_num = any

				proc = symbFindUopOvlProc( AST_OP_DEREF, l, @err_num )
				if( proc <> NULL ) then
					'' build a proc call
					return astBuildCall( proc, 1, l )
				else
					if( err_num <> FB_ERRMSG_OK ) then
						exit function
					end if
				end if
			end if

    		dim as integer delchild = any

			'' convert *@ to nothing
			select case l->class
			case AST_NODECLASS_ADDROF
				delchild = TRUE

			case AST_NODECLASS_OFFSET
				delchild = (l->ofs.ofs = 0)

			case else
				delchild = FALSE
			end select

			''
			if( delchild ) then
				n = l->l
				astSetType( n, dtype, subtype )
				astDelNode( l )
				return n
			end if
		end if

		if( l->defined ) then
			ofs += astGetValueAsInt( l )
			astDelNode( l )
			l = NULL
		end if
	end if

	'' alloc new node
	n = astNewNode( AST_NODECLASS_DEREF, dtype, subtype )

	if( n = NULL ) then
		return NULL
	end if

	n->l = l
	n->ptr.ofs = ofs

	function = n

end function

'':::::
function astLoadDEREF _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

    dim as ASTNODE ptr l = any
    dim as IRVREG ptr v1 = any, vp = any, vr = any

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

