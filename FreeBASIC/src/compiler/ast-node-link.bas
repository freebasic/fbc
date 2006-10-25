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
		byval r as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any

	if( l = NULL ) then
		return r
	elseif( r = NULL ) then
		return l
	end if

	''
	n = astNewNode( AST_NODECLASS_LINK, l->dtype, l->subtype )
	if( n = NULL ) then
		return NULL
	end if

	''
	n->l = l
	n->r = r

	function = n

end function

'':::::
sub astSetTypeLINK _
	( _
		byval n as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	)

    n->dtype = dtype
    n->subtype = subtype

	n->l->dtype = dtype
	n->l->subtype = subtype

end sub

'':::::
function astLoadLINK _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

	dim as IRVREG ptr vr = any

	vr = astLoad( n->l )
	astDelNode( n->l )

	astLoad( n->r )
	astDelNode( n->r )

	function = vr

end function

