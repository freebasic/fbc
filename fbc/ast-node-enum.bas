''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2010 The FreeBASIC development team.
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

'' AST enumeration nodes
'' l = NULL; r = NULL
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "ast.bi"

'':::::
function astNewENUM _
	( _
		byval value as integer, _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr static

    dim as ASTNODE ptr n

	'' alloc new node
	n = astNewNode( AST_NODECLASS_ENUM, FB_DATATYPE_ENUM, sym )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->con.val.int = value
	n->defined	= TRUE

end function

'':::::
function astLoadENUM _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

	if( ast.doemit ) then
		function = irAllocVRIMM( FB_DATATYPE_INTEGER, NULL, n->con.val.int )
	end if

end function

