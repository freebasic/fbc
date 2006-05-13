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


'' symbol table module for scopes
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\list.bi"
#include once "inc\ast.bi"
#include once "inc\emit.bi"
#include once "inc\rtl.bi"

'':::::
function symbAddScope _
	( _
		byval backnode as ASTNODE ptr _
	) as FBSYMBOL ptr

    dim as FBSYMBOL ptr s

    s = symbNewSymbol( NULL, _
    				   symb.symtb, NULL, TRUE, _
    				   FB_SYMBCLASS_SCOPE, _
    				   FALSE, NULL, NULL )

	symbSymTbInit( @s->scp.symtb, s )
    s->scp.backnode = backnode

	function = s

end function

'':::::
sub symbDelScope _
	( _
		byval scp as FBSYMBOL ptr _
	)

	dim as FBSYMBOL ptr s, nxt

    if( scp = NULL ) then
    	exit sub
    end if

    '' del all symbols inside the scope block
    do
		s = scp->scp.symtb.head
		if( s = NULL ) then
			exit do
		end if

		symbDelSymbol( s )
	loop

	'' del the scope node
	symbFreeSymbol( scp )

end sub

'':::::
sub symbDelScopeTb _
	( _
		byval scp as FBSYMBOL ptr _
	) static

    dim as FBSYMBOL ptr s

	'' for each symbol declared inside the SCOPE block..
	s = scp->scp.symtb.head
    do while( s <> NULL )
    	'' remove from hash only

    	'' not a namespace import (USING)?
    	if( s->class <> FB_SYMBCLASS_NSIMPORT ) then
    		symbDelFromHash( s )
    	else
    		symbNamespaceRemove( s, TRUE )
    	end if

    	s = s->next
    loop

end sub

'':::::
function symbScopeAllocLocals _
	( _
		byval scp as FBSYMBOL ptr _
	) as integer

    dim as integer lgt
    dim as FBSYMBOL ptr s

    function = FALSE

    s = symbGetScopeTbHead( scp )
    do while( s <> NULL )
		'' variable?
		if( s->class = FB_SYMBCLASS_VAR ) then
    		'' not shared, static?
    		if( (s->attrib and (FB_SYMBATTRIB_SHARED or _
    			 				FB_SYMBATTRIB_STATIC)) = 0 ) then

				lgt = s->lgt * symbGetArrayElements( s )
				s->ofs = emitAllocLocal( env.currproc, lgt )

				symbSetIsAllocated( s )

			end if

		end if

    	s = s->next
    loop

    function = TRUE

end function

'':::::
sub symbFreeScopeDynVars _
	( _
		byval scp as FBSYMBOL ptr _
	) static

    dim as FBSYMBOL ptr s

	'' for each symbol declared inside the SCOPE block..
	s = scp->scp.symtb.head
    do while( s <> NULL )
    	'' variable?
    	if( s->class = FB_SYMBCLASS_VAR ) then
    		'' not shared or static (for locals)
    		if( (s->attrib and (FB_SYMBATTRIB_SHARED or _
    							FB_SYMBATTRIB_STATIC)) = 0 ) then

    			astAdd( symbFreeDynVar( s ) )

    		end if
    	end if

    	s = s->next
    loop

end sub


