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


'' quirk error statements (ERROR, ERR) parsing
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"

'':::::
''ErrorStmt 	=	ERROR Expression
''				|   ERR '=' Expression .
''
function cErrorStmt as integer
	dim as ASTNODE ptr expr

	function = FALSE


	select case lexGetToken( )

	'' ERROR Expression
	case FB_TK_ERROR
		lexSkipToken( )

		'' Expression
		hMatchExpression( expr )

		rtlErrorThrow( expr, lexLineNum( ), env.inf.name )

		function = TRUE

	'' ERR '=' Expression
	case FB_TK_ERR
		lexSkipToken( )

		'' '='
		if( hMatch( FB_TK_ASSIGN ) = FALSE ) then
			hReportError( FB_ERRMSG_EXPECTEDEQ )
			exit function
		end if

		'' Expression
		hMatchExpression( expr )

		rtlErrorSetnum( expr )

		function = TRUE

	end select

end function

'':::::
''cErrorFunct =   ERR .
''
function cErrorFunct( byref funcexpr as ASTNODE ptr ) as integer

	function = FALSE

	if( hMatch( FB_TK_ERR ) ) then

		funcexpr = rtlErrorGetNum

		function = TRUE
	end if

end function

