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

'' AST stack nodes
'' l = expression; r = NULL
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ir.bi"
#include once "inc\ast.bi"

'':::::
function astNewSTACK _
	( _
		byval op as integer, _
		byval l as ASTNODE ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any

    if( l = NULL ) then
    	return NULL
    end if

	'' alloc new node
	n = astNewNode( AST_NODECLASS_STACK, astGetFullType( l ), NULL )
	if( n = NULL ) then
		return NULL
	end if

	n->stack.op = op
	n->l = l

	function = n

end function

'':::::
function astLoadSTACK _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

    dim as ASTNODE ptr l = any
    dim as IRVREG ptr vr = any

	l  = n->l
	if( l = NULL ) then
		return NULL
	end if

	vr = astLoad( l )

	if( ast.doemit ) then
		irEmitSTACK( n->stack.op, vr )
	end if

	astDelNode( l )

	function = vr

end function

