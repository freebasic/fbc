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

'' AST scope nodes
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
function astScopeBegin( ) as ASTNODE ptr static
    dim as ASTNODE ptr n
    dim as FBSYMBOL ptr s

	if( env.scope >= FB_MAXSCOPEDEPTH ) then
		return NULL
	end if

	''
	n = astNewNode( AST_NODECLASS_SCOPE, INVALID )
	if( n = NULL ) then
		return NULL
	end if

	s = symbAddScope( )

    '' change to scope's symbol tb
    s->scp.loctb.head = NULL
    s->scp.loctb.tail = NULL
    s->scp.bytes = 0

    n->scp.sym = s

    astAdd( n )

	''
	env.scope += 1

	symbSetLocalTb( @s->scp.loctb )

	''
	irScopeBegin( s )

	''
	astAdd( astNewDBG( AST_OP_DBG_SCOPEINI, cint( s ) ) )

	function = n

end function

'':::::
sub astScopeEnd( byval n as ASTNODE ptr ) static
	dim as FBSYMBOL ptr s

	s = n->scp.sym

	'' free dynamic vars
	symbFreeScopeDynVars( s )

	'' remove symbols from hash table
	symbDelScopeTb( s )

	''
	astAdd( astNewDBG( AST_OP_DBG_SCOPEEND, cint( s ) ) )

	''
	irScopeEnd( s )

	'' back to preview symbol tb
	symbSetLocalTb( s->symtb )

	env.scope -= 1

end sub

'':::::
function astLoadSCOPE( byval n as ASTNODE ptr ) as IRVREG ptr static
    dim as FBSYMBOL ptr s

	if( ast.doemit ) then
		s = n->scp.sym
		if( s->scp.bytes > 0 ) then
			irEmitSTKCLEAR( s->scp.bytes, s->scp.baseofs )
		end if
	end if

end function

