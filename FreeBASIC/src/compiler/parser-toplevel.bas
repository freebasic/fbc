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
''Program         =   Line* EOF .
''
function cProgram as integer
    dim res as integer

    do
    	res = cLine( )
    loop while( (res) and (lexGetToken( ) <> FB_TK_EOF) )

    if( res ) then
    	if( hMatch( FB_TK_EOF ) = FALSE ) then
    		'hReportError FB_ERRMSG_EXPECTEDEOF
    		res = FALSE
    	else
    		res = TRUE
    	end if
    end if

    function = res

end function

'':::::
''Line            =   Label? Statement? Comment? EOL .
''
function cLine as integer

	''
	astAdd( astNewDBG( AST_OP_DBG_LINEINI, lexLineNum( ) ) )

    '' Label? Statement? Comment?
    cLabel( )
    cStatement( )
    cComment( )

	if( hGetLastError( ) <> FB_ERRMSG_OK ) then
		return FALSE
	end if

	if( hMatch( FB_TK_EOL ) = FALSE ) then
		if( lexGetToken( ) <> FB_TK_EOF ) then
			hReportError( FB_ERRMSG_EXPECTEDEOL )
			return FALSE
		end if
    end if

	''
	astAdd( astNewDBG( AST_OP_DBG_LINEEND ) )

    function = TRUE

end function

'':::::
''SimpleLine      =   Label? SimpleStatement? Comment? EOL .
''
function cSimpleLine as integer
    dim res as integer

	''
	astAdd( astNewDBG( AST_OP_DBG_LINEINI, lexLineNum( ) ) )

    '' Label? SimpleStatement? Comment?
    cLabel( )
    res = cSimpleStatement( )
    cComment( )

	if( hGetLastError( ) <> FB_ERRMSG_OK ) then
		return FALSE
	end if

	if( hMatch( FB_TK_EOL ) = FALSE ) then
		if( res ) then
			return FALSE
		else
			if( lexGetToken( ) <> FB_TK_EOF ) then
				hReportError( FB_ERRMSG_EXPECTEDEOL )
				return FALSE
			end if
		end if
	end if

	''
	astAdd( astNewDBG( AST_OP_DBG_LINEEND ) )

    function = TRUE

end function

