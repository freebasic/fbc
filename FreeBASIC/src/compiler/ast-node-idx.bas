''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2011 The FreeBASIC development team.
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


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ir.bi"
#include once "inc\ast.bi"

'':::::
function astNewIDX _
	( _
		byval var_ as ASTNODE ptr, _
		byval idx as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr 

    dim as ASTNODE ptr n = any

	if( dtype = FB_DATATYPE_INVALID ) then
		dtype = astGetFullType( var_ )
		subtype = astGetSubType( var_ )
	end if

	'' alloc new node
	n = astNewNode( AST_NODECLASS_IDX, dtype, subtype )

	if( n = NULL ) then
		return NULL
	end if

	n->l = idx
	n->r = var_
	n->sym = var_->sym
	n->idx.mult	= 1
	n->idx.ofs = 0

	function = n

end function

'':::::
private function hEmitIDX _
	( _
		byval n as ASTNODE ptr, _
		byval var_ as ASTNODE ptr, _
		byval vidx as IRVREG ptr _
	) as IRVREG ptr static

    dim as FBSYMBOL ptr s
    dim as IRVREG ptr vd
    dim as integer ofs

	'' ofs * length + difference (non-base 0 indexes) + offset (UDT's offset)
    s = var_->sym

    symbSetIsAccessed( s )

    ofs = n->idx.ofs
	if( symbGetIsDynamic( s ) = FALSE ) then
		ofs += symbGetArrayDiff( s ) + symbGetOfs( s ) + var_->var_.ofs
	else
		s = NULL
	end if

    ''
    if( ast.doemit ) then
		if( vidx <> NULL ) then
			'' not a reg already? load
			if( irIsREG( vidx ) = FALSE ) then
				irEmitLOAD( vidx )
			end if

			vd = irAllocVRIDX( astGetDataType( n ), n->subtype, s, ofs, n->idx.mult, vidx )

		else
			vd = irAllocVRVAR( astGetDataType( n ), n->subtype, s, ofs )
		end if
	end if

	function = vd

end function

'':::::
function astLoadIDX _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

    dim as ASTNODE ptr var_ = any, idx = any
    dim as IRVREG ptr vidx = any, vr = any

	var_ = n->r
	if( var_ = NULL ) then
		return NULL
	end if

	idx = n->l
	if( idx <> NULL ) then
		vidx = astLoad( idx )
	else
		vidx = NULL
	end if

	if( ast.doemit ) then
		vr = hEmitIDX( n, var_, vidx )
		vr->vector = n->vector
	end if

	astDelNode( idx )
	astDelNode( var_ )

	function = vr

end function

