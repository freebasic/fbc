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


'' top-level parser
''
'' a deterministic, top-down, linear directional (LL(2)), recursive descent parser
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

declare sub		 parserCompoundStmtInit		( )
declare sub		 parserCompoundStmtEnd		( )

'':::::
sub	parserInit( )

	parserCompoundStmtInit( )

end sub

'':::::
sub	parserEnd( )

	parserCompoundStmtEnd( )

end sub

'':::::
''Program         =   Line* EOF? .
''
function cProgram( ) as integer

    do
    	if( cLine( ) = FALSE ) then
    		exit do
    	end if
    loop

    if( hGetLastError( ) = FB_ERRMSG_OK ) then
    	'' EOF?
    	if( lexGetToken( ) = FB_TK_EOF ) then
    		lexSkipToken( )
    	end if

    	if( env.includerec = 0 ) then
    		function = cCompStmtCheck( )
    	else
    		function = TRUE
    	end if

    else
    	function = FALSE
    end if

end function

'':::::
''Line            =   Label? Statement? Comment? EOL .
''
function cLine as integer

	''
	astAdd( astNewDBG( AST_OP_DBG_LINEINI, lexLineNum( ) ) )

    '' Label?
    cLabel( )

    '' Statement?
    cStatement( )

    '' Comment?
    cComment( )

	if( hGetLastError( ) <> FB_ERRMSG_OK ) then
		return FALSE
	end if

	select case lexGetToken( )
	case FB_TK_EOL
		lexSkipToken( )
		function = TRUE

	case FB_TK_EOF
		function = FALSE

	case else
		hReportError( FB_ERRMSG_EXPECTEDEOL )
		function = FALSE
    end select

	''
	astAdd( astNewDBG( AST_OP_DBG_LINEEND ) )

end function

