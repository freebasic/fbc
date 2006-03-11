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
sub astBuildVAR( byval n as ASTNODE ptr, _
				 byval sym as FBSYMBOL ptr, _
				 byval ofs as integer, _
				 byval dtype as integer, _
				 byval subtype as FBSYMBOL ptr = NULL _
			   ) static

	astInitNode( n, AST_NODECLASS_VAR, dtype, subtype )

	n->sym = sym
	n->var.ofs = ofs

end sub

'':::::
function astNewVAR( byval sym as FBSYMBOL ptr, _
					byval ofs as integer, _
					byval dtype as integer, _
					byval subtype as FBSYMBOL ptr = NULL _
				  ) as ASTNODE ptr static

    dim as ASTNODE ptr n

	'' alloc new node
	n = astNewNode( AST_NODECLASS_VAR, dtype, subtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->sym = sym
	n->var.ofs = ofs

end function

'':::::
function astLoadVAR( byval n as ASTNODE ptr ) as IRVREG ptr static
    dim as FBSYMBOL ptr s
    dim as integer ofs

	s = n->sym
	ofs = n->var.ofs
	if( s <> NULL ) then
		symbSetIsAccessed( s )
		ofs += symbGetVarOfs( s )
	end if

	if( ast.doemit ) then
		function = irAllocVRVAR( n->dtype, s, ofs )
	end if

end function


