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

'' AST variable nodes
'' l = NULL; r = NULL
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ir.bi"
#include once "inc\ast.bi"

'':::::
function astNewFIELD( byval p as ASTNODE ptr, _
					  byval sym as FBSYMBOL ptr, _
					  byval dtype as integer, _
					  byval subtype as FBSYMBOL ptr = NULL _
					) as ASTNODE ptr static
    dim as ASTNODE ptr n

	'' alloc new node
	n = astNewNode( AST_NODECLASS_FIELD, dtype, subtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->sym = sym
	n->l   = p

end function

'':::::
private function hGetBitField( byval n as ASTNODE ptr ) as ASTNODE ptr static

	dim as ASTNODE ptr c
	dim as FBSYMBOL ptr s

	s = n->subtype

	''
	n->dtype = s->typ
	n->subtype = NULL

	'' make a copy, the node itself can't be used or it will be deleted twice
	c = astNewNode( INVALID, INVALID )
	astCopy( c, n )

	if( s->bitfld.bitpos > 0 ) then
		n = astNewBOP( IR_OP_SHR, c, _
				   	   astNewCONSTi( s->bitfld.bitpos, IR_DATATYPE_UINT ) )
	else
		n = c
	end if

	n = astNewBOP( IR_OP_AND, n, _
				   astNewCONSTi( ast_bitmaskTB(s->bitfld.bits), IR_DATATYPE_UINT ) )

	function = n

end function

'':::::
function astLoadFIELD( byval n as ASTNODE ptr ) as IRVREG ptr static

	'' handle bitfields..
	if( n->dtype = IR_DATATYPE_BITFIELD ) then
		n = hGetBitField( n->l )
		function = astLoad( n )
		astDel( n )
		exit function
	end if

	function = astLoad( n->l )

	astDel( n->l )

end function


