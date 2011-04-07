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


'' symbol table module for scopes
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\list.bi"
#include once "inc\ast.bi"
#include once "inc\rtl.bi"

'':::::
function symbAddScope _
	( _
		byval backnode as ASTNODE ptr _
	) as FBSYMBOL ptr

    dim as FBSYMBOL ptr s

    s = symbNewSymbol( FB_SYMBOPT_NONE, _
    				   NULL, _
    				   symb.symtb, NULL, _
    				   FB_SYMBCLASS_SCOPE, _
    				   NULL, NULL, _
    				   FB_DATATYPE_INVALID, NULL )

	symbSymbTbInit( s->scp.symtb, s )
    s->scp.backnode = backnode

	function = s

end function

'':::::
sub symbDelScope _
	( _
		byval scp as FBSYMBOL ptr, _
		byval is_tbdel as integer _
	)

    if( scp = NULL ) then
    	exit sub
    end if

    '' del all symbols inside the scope block
    do
		'' starting from last because of the USING's that could be
		'' referencing a namespace in the same scope block
		dim as FBSYMBOL ptr s = scp->scp.symtb.tail
		if( s = NULL ) then
			exit do
		end if

		symbDelSymbol( s, TRUE )
	loop

	'' del the scope node
	symbFreeSymbol( scp )

end sub

'':::::
sub symbDelScopeTb _
	( _
		byval scp as FBSYMBOL ptr _
	)

	'' for each symbol declared inside the SCOPE block..
	dim as FBSYMBOL ptr s = scp->scp.symtb.tail
    do while( s <> NULL )
    	'' remove from hash only

    	'' not a namespace import (USING)?
    	if( s->class <> FB_SYMBCLASS_NSIMPORT ) then
    		symbDelFromHash( s )
    	else
    		symbNamespaceRemove( s, TRUE, FALSE )
    	end if

    	s = s->prev
    loop

end sub

'':::::
function symbScopeAllocLocals _
	( _
		byval scp as FBSYMBOL ptr _
	) as integer

    dim as FBSYMBOL ptr s = any
    dim as integer lgt = any
    dim as integer mask = any

    function = FALSE

    '' prepare mask (if the IR is HL, pass the local static vars too)
    if( irGetOption( IR_OPT_HIGHLEVEL ) ) then
    	mask = FB_SYMBATTRIB_SHARED
    else
    	mask = FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_STATIC
    end if

    s = symbGetScopeSymbTbHead( scp )
    do while( s <> NULL )
		'' variable?
		if( s->class = FB_SYMBCLASS_VAR ) then
    		'' not shared or static?
    		if( (s->attrib and mask) = 0 ) then

				lgt = s->lgt * symbGetArrayElements( s )
				s->ofs = irProcAllocLocal( parser.currproc, s, lgt )

				symbSetVarIsAllocated( s )

			end if

		end if

    	s = s->next
    loop

    function = TRUE

end function


