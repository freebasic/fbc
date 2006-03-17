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

'' AST linking nodes
'' l = curr node; r = next link
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ir.bi"
#include once "inc\ast.bi"

'':::::
function astNewLINK( byval l as ASTNODE ptr, _
					 byval r as ASTNODE ptr ) as ASTNODE ptr static

	dim as ASTNODE ptr n
	dim as integer dtype

	if( l = NULL ) then
		if( r = NULL ) then
			return NULL
		end if
		dtype =	r->dtype
	else
		dtype =	l->dtype
	end if

	''
	n = astNewNode( AST_NODECLASS_LINK, dtype )
	if( n = NULL ) then
		return NULL
	end if

	''
	n->l = l
	n->r = r

	function = n

end function

'':::::
function astLoadLINK( byval n as ASTNODE ptr ) as IRVREG ptr

	if( n = NULL ) then
		return NULL
	end if

	astLoad( n->l )
	astDelNode( n->l )

	astLoad( n->r )
	astDelNode( n->r )

	function = NULL

end function

