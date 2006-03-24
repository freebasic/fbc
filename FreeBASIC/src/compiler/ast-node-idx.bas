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
function astNewIDX( byval var as ASTNODE ptr, _
					byval idx as ASTNODE ptr, _
					byval dtype as integer, _
					byval subtype as FBSYMBOL ptr _
				  ) as ASTNODE ptr static

    dim as ASTNODE ptr n

	if( dtype = INVALID ) then
		dtype = astGetDataType( var )
		subtype = astGetSubType( var )
	end if

	'' alloc new node
	n = astNewNode( AST_NODECLASS_IDX, dtype, subtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->l 			= idx
	n->r 			= var
	n->sym			= var->sym
	n->idx.mult 	= 1
	n->idx.ofs 		= 0

end function

'':::::
private function hEmitIDX( byval n as ASTNODE ptr, _
						   byval var as ASTNODE ptr, _
					  	   byval vidx as IRVREG ptr _
					  	 ) as IRVREG ptr static

    dim as FBSYMBOL ptr s
    dim as IRVREG ptr vd
    dim as integer ofs

	'' ofs * length + difference (non-base 0 indexes) + offset (UDT's offset)
    s = var->sym

    symbSetIsAccessed( s )

    ofs = n->idx.ofs
	if( symbGetIsDynamic( s ) = FALSE ) then
		ofs += symbGetArrayDiff( s ) + symbGetVarOfs( s ) + var->var.ofs
	else
		s = NULL
	end if

    ''
    if( ast.doemit ) then
		if( vidx <> NULL ) then
			vd = irAllocVRIDX( n->dtype, s, ofs, n->idx.mult, vidx )

			if( irIsIDX( vidx ) or irIsVAR( vidx ) ) then
				irEmitLOAD( vidx )
			end if
		else
			vd = irAllocVRVAR( n->dtype, s, ofs )
		end if
	end if

	function = vd

end function

'':::::
function astLoadIDX( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr var, idx
    dim as IRVREG ptr vidx, vr

	var = n->r
	if( var = NULL ) then
		return NULL
	end if

	idx = n->l
	if( idx <> NULL ) then
		vidx = astLoad( idx )
	else
		vidx = NULL
	end if

	if( ast.doemit ) then
    	vr = hEmitIDX( n, var, vidx )
    end if

	astDelNode( idx )
	astDelNode( var )

	function = vr

end function

