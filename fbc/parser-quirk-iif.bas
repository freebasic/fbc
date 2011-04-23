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


'' quirk conditional statement (IIF) parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

'':::::
''cIIFFunct =   IIF '(' condexpr ',' truexpr ',' falsexpr ')' .
''
function cIIFFunct _
	( _
		byref funcexpr as ASTNODE ptr _
	) as integer

	dim as ASTNODE ptr condexpr = any, truexpr = any, falsexpr = any

	function = FALSE

	'' IIF
	lexSkipToken( )

	'' '('
	hMatchLPRNT( )

	'' condexpr
	hMatchExpressionEx( condexpr, FB_DATATYPE_INTEGER )

	'' ','
	hMatchCOMMA( )

	'' truexpr
	hMatchExpressionEx( truexpr, FB_DATATYPE_INTEGER )

	'' ','
	hMatchCOMMA( )

	'' falsexpr
	hMatchExpressionEx( falsexpr, astGetDataType( truexpr ) )

	'' ')'
	hMatchRPRNT( )

	''
	funcexpr = astNewIIF( condexpr, truexpr, falsexpr )

	if( funcexpr = NULL ) then
		if( errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE ) = FALSE ) then
			exit function
		else
			'' error recovery: fake an expr
			funcexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
		end if
	end if

	function = TRUE

end function

