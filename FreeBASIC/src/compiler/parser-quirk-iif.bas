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


'' quirk conditional statement (IIF) parsing
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

'':::::
''cIIFFunct =   IIF '(' condexpr ',' truexpr ',' falsexpr ')' .
''
function cIIFFunct( byref funcexpr as ASTNODE ptr ) as integer
	dim as ASTNODE ptr condexpr, truexpr, falsexpr

	function = FALSE

	'' IIF
	lexSkipToken

	'' '('
	hMatchLPRNT( )

	'' condexpr
	hMatchExpression( condexpr )

	'' ','
	hMatchCOMMA( )

	'' truexpr
	hMatchExpression( truexpr )

	'' ','
	hMatchCOMMA( )

	'' falsexpr
	hMatchExpression( falsexpr )

	'' ')'
	hMatchRPRNT( )

	''
	funcexpr = astNewIIF( condexpr, truexpr, falsexpr )

	if( funcexpr = NULL ) then
		hReportError( FB_ERRMSG_INVALIDDATATYPES, TRUE )
		exit function
	end if

	function = TRUE

end function

