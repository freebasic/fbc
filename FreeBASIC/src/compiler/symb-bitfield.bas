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


'' symbol table module for bit fields
''
'' chng: nov/2005 written [v1ctor]
''

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\hash.bi"
#include once "inc\list.bi"
#include once "inc\ast.bi"

'':::::
function symbAddBitField( byval bitpos as integer, _
					      byval bits as integer, _
						  byval typ as integer, _
						  byval lgt as integer _
					    ) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr s

    '' the symbol table doesn't matter

    s = symbNewSymbol( NULL, symb.loctb, TRUE, FB_SYMBCLASS_BITFIELD, _
    				   FALSE, NULL, NULL, typ, NULL )

    s->bitfld.bitpos = bitpos
    s->bitfld.bits = bits
    s->lgt = lgt

	function = s

end function

