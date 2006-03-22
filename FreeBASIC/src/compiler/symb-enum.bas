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


'' symbol table module for enumerations
''
'' chng: sep/2004 written [v1ctor]
''		 jan/2005 updated to use real linked-lists [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\hash.bi"
#include once "inc\list.bi"

'':::::
function symbAddEnum( byval symbol as zstring ptr ) as FBSYMBOL ptr static
    dim as FBSYMBOL ptr e
    dim as FBSYMBOLTB ptr symtb

    function = NULL

    '' if parsing main, all enums must go to the global table
    if( fbIsModLevel( ) ) then
    	symtb = @symb.globtb
    else
    	symtb = symb.loctb
    end if

    ''
    e = symbNewSymbol( NULL, symtb, fbIsModLevel( ), FB_SYMBCLASS_ENUM, _
    				   TRUE, symbol, NULL )
	if( e = NULL ) then
		exit function
	end if

	e->enum.elements = 0
	e->enum.elmtb.owner = e
	e->enum.elmtb.head = NULL
	e->enum.elmtb.tail = NULL
	e->enum.dbg.typenum = INVALID

	'' check for forward references
	if( symb.fwdrefcnt > 0 ) then
		symbCheckFwdRef( e, FB_SYMBCLASS_ENUM )
	end if

	function = e

end function

'':::::
function symbAddEnumElement( byval parent as FBSYMBOL ptr, _
							 byval symbol as zstring ptr, _
					         byval intval as integer _
					       ) as FBSYMBOL ptr static

	dim as FBSYMBOL ptr elm, tail
	dim as FBVALUE value

	value.int = intval
	elm = symbAddConst( symbol, FB_DATATYPE_ENUM, parent, @value )

	if( elm = NULL ) then
		return NULL
	end if

	parent->enum.elements += 1

	''
	function = elm

end function

'':::::
sub symbDelEnum( byval s as FBSYMBOL ptr, _
				 byval dolookup as integer )

	dim as FBSYMBOL ptr e, nxt

    if( dolookup ) then
    	s = symbFindByClass( s, FB_SYMBCLASS_ENUM )
    end if

    if( s = NULL ) then
    	exit sub
    end if

    '' del all enum constants
	e = s->enum.elmtb.head
    do while( e <> NULL )
        nxt = e->next
		symbFreeSymbol( e )
		e = nxt
	loop

	'' del the enum node
	symbFreeSymbol( s )

end sub


