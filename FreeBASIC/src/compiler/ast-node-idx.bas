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

'' AST array index nodes
'' l = index expression; r = var expression
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ir.bi"
#include once "inc\ast.bi"

'':::::
function astNewIDX( byval v as ASTNODE ptr, _
					byval i as ASTNODE ptr, _
					byval dtype as integer, _
					byval subtype as FBSYMBOL ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr n

	if( dtype = INVALID ) then
		dtype = astGetDataType( i )
	end if

	'' alloc new node
	n = astNewNode( AST_NODECLASS_IDX, dtype, subtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->l 			= i
	n->r 			= v
	n->idx.mult 	= 1
	n->idx.ofs 		= 0
	n->chkbitfld  	= v <> NULL

end function

'':::::
private function hEmitIDX( byval n as ASTNODE ptr, _
						   byval v as ASTNODE ptr, _
					  	   byval vi as IRVREG ptr ) as IRVREG ptr static
    dim as FBSYMBOL ptr s
    dim as IRVREG ptr vd
    dim as integer ofs

	'' ofs * length + difference (non-base 0 indexes) + offset (UDT's offset)
    s = v->var.sym
    ofs = n->idx.ofs
	if( not symbGetIsDynamic( s ) ) then
		ofs += symbGetArrayDiff( s ) + v->var.ofs
	else
		s = NULL
	end if

    ''
    if( ast.doemit ) then
		if( vi <> NULL ) then
			vd = irAllocVRIDX( n->dtype, s, ofs, n->idx.mult, vi )

			if( irIsIDX( vi ) or irIsVAR( vi ) ) then
				irEmitLOAD( vi )
			end if
		else
			vd = irAllocVRVAR( n->dtype, s, ofs )
		end if
	end if

	function = vd

end function

'':::::
function astLoadIDX( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr v, i
    dim as IRVREG ptr vi, vr
    dim as FBSYMBOL ptr s

	v = n->r
	if( v = NULL ) then
		return NULL
	end if

	'' handle bitfields..
	if( n->chkbitfld ) then
		n->chkbitfld = FALSE
		if( v->chkbitfld ) then
			v->chkbitfld = FALSE
			s = v->var.elm
			if( s <> NULL ) then
				if( s->var.elm.bits > 0 ) then
					n = astGetBitField( n, s )
					function = astLoad( n )
					astDel( n )
					exit function
				end if
			end if
		end if
	end if

	i = n->l
	if( i <> NULL ) then
		vi = astLoad( i )
	else
		vi = NULL
	end if

	if( ast.doemit ) then
    	vr = hEmitIDX( n, v, vi )
    end if

	astDel( i )
	astDel( v )

	function = vr

end function

