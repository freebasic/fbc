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

'' AST namespace nodes
'' l = NULL; r = NULL
''
'' chng: jun/2006 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ast.bi"


'':::::
function astNamespaceBegin _
	( _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any

	n = astNewNode( AST_NODECLASS_NAMESPC, FB_DATATYPE_INVALID )
	if( n = NULL ) then
		return NULL
	end if

	n->sym = sym

	symbNestBegin( sym, FALSE )

	function = n

end function

'':::::
sub astNamespaceEnd _
	( _
		byval n as ASTNODE ptr _
	)

	dim as FBSYMBOL ptr ns = n->sym

	symbNestEnd( FALSE )

	'' reimplementation?
	symbGetNamespaceCnt( ns ) += 1
	if( symbGetNamespaceCnt( ns ) > 1 ) then
		symbNamespaceReImport( ns )
	end if

	symbGetNamespaceLastTail( ns ) = symbGetCompSymbTb( ns ).tail

end sub


