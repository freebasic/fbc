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


'' symbol table module for bit fields
''
'' chng: nov/2005 written [v1ctor]
''


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\hash.bi"
#include once "inc\list.bi"
#include once "inc\ast.bi"

'':::::
function symbAddBitField _
	( _
		byval bitpos as integer, _
		byval bits as integer, _
		byval dtype as integer, _
		byval lgt as integer _
	) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr sym

    '' table must be the global one, if the UDT is been defined
    '' at main(), it will be deleted before some private function
    '' accessing the bitfield

    sym = symbNewSymbol( FB_SYMBOPT_NONE, _
    					 NULL, _
    					 NULL, NULL, _
    					 FB_SYMBCLASS_BITFIELD, _
    				   	 NULL, NULL, _
    				   	 dtype, NULL )
	if( sym = NULL ) then
		return NULL
	end if

    sym->bitfld.bitpos = bitpos
    sym->bitfld.bits = bits
    sym->lgt = lgt

	function = sym

end function

