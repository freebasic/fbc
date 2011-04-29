''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2011 The FreeBASIC development team.
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


'' proc (SUB or FUNCTION) declarations
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

'':::::
''ProcDecl        =   DECLARE ((SUB | FUNCTION) ProcHeader | OPERATOR OperatorHeader ) .
''
function cProcDecl as integer
    dim as integer is_nested = any

    function = FALSE

    if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_DECL ) = FALSE ) then
    	exit function
    end if

    '' DECLARE
    lexSkipToken( )

	select case as const lexGetToken( )
	case FB_TK_SUB
		lexSkipToken( )
		function = cProcHeader( 0, _
								is_nested, _
								FB_PROCOPT_ISPROTO or FB_PROCOPT_ISSUB ) <> NULL

	case FB_TK_FUNCTION
		lexSkipToken( )
		function = cProcHeader( 0, is_nested, FB_PROCOPT_ISPROTO ) <> NULL

	case FB_TK_OPERATOR
		lexSkipToken( )
		function = cOperatorHeader( 0, is_nested, FB_PROCOPT_ISPROTO ) <> NULL

	case else
		if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
			exit function
		else
			'' error recovery: try to parse the prototype
			function = cProcHeader( 0, is_nested, FB_PROCOPT_ISPROTO ) <> NULL
		end if
	end select

end function


