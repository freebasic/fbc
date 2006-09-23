''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2006 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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
	) as ASTNODE ptr static

	dim as ASTNODE ptr n
	dim as integer dtype
	dim as FBSYMBOL ptr subtype

	if( l = NULL ) then
		if( r = NULL ) then
			return NULL
		end if
		dtype =	r->dtype
		subtype = r->subtype
	else
		dtype =	l->dtype
		subtype = l->subtype
	end if

	''
	n = astNewNode( AST_NODECLASS_LINK, dtype, subtype )
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

	if( n = NULL ) then
		return NULL
	end if

	vr = astLoad( n->l )
	astDelNode( n->l )

	astLoad( n->r )
	astDelNode( n->r )

	function = vr

end function

