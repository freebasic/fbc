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

'' AST linking nodes
'' l = curr node; r = next link
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ir.bi"
#include once "inc\ast.bi"

'':::::
function astNewLINK _
	( _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr, _
		byval ret_left as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any

	if( l = NULL ) then
		return r
	elseif( r = NULL ) then
		return l
	end if

	''
	if( ret_left ) then
		n = astNewNode( AST_NODECLASS_LINK, astGetFullType( l ), l->subtype )
	else
		n = astNewNode( AST_NODECLASS_LINK, astGetFullType( r ), r->subtype )
	end if

	if( n = NULL ) then
		return NULL
	end if

	''
	n->link.ret_left = ret_left
	n->l = l
	n->r = r

	function = n

end function

'':::::
function astLoadLINK _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

	dim as IRVREG ptr vrl = any, vrr = any

	vrl = astLoad( n->l )
	astDelNode( n->l )

	vrr = astLoad( n->r )
	astDelNode( n->r )

	if( n->link.ret_left ) then
		function = vrl
	else
		function = vrr
	end if

end function

