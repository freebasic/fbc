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

declare sub		parserCompoundStmtInit		( )

declare sub		parserCompoundStmtEnd		( )

declare sub		parserProcCallInit			( )

declare sub		parserProcCallEnd			( )

'':::::
sub	parserInit( )

	parserCompoundStmtInit( )

	parserProcCallInit( )

end sub

'':::::
sub	parserEnd( )

	parserProcCallEnd( )

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

    if( hGetErrorCnt( ) = 0 ) then
    	'' EOF?
    	if( lexGetToken( ) = FB_TK_EOF ) then
    		lexSkipToken( )
    	end if

    	'' only check compound stmts if not parsing an include file
    	if( env.includerec = 0 ) then
    		cCompStmtCheck( )
    		function = (hGetErrorCnt( ) = 0)
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

	function = FALSE

	''
	astAdd( astNewDBG( AST_OP_DBG_LINEINI, lexLineNum( ) ) )

    '' Label?
    cLabel( )

    '' Statement?
    cStatement( )

    '' Comment?
    cComment( )

	if( hGetLastError( ) <> FB_ERRMSG_OK ) then
		exit function
	end if

	select case lexGetToken( )
	case FB_TK_EOL
		lexSkipToken( )
		function = TRUE

	case FB_TK_EOF
		exit function

	case else
		if( hReportError( FB_ERRMSG_EXPECTEDEOL ) = FALSE ) then
			exit function
		else
			'' error recovery: skip until EOL
			hSkipStmt( )
			if( lexGetToken( ) = FB_TK_EOL ) then
				lexSkipToken( )
			end if
		end if

		function = TRUE
    end select

	''
	astAdd( astNewDBG( AST_OP_DBG_LINEEND ) )

end function

''::::
sub hSkipUntil _
	( _
		byval token as integer, _
		byval doeat as integer, _
		byval flags as LEXCHECK _
	)

	dim as integer prntcnt

	prntcnt = 0
	do
		select case as const lexGetToken( flags )
		case FB_TK_EOL
			exit do

		case FB_TK_STATSEPCHAR, FB_TK_COMMENTCHAR, FB_TK_REM
			if( token <> FB_TK_EOL ) then
				exit do
			end if

		case FB_TK_EOF
			exit sub

		'' '('?
		case CHAR_LPRNT, CHAR_LBRACE
			prntcnt += 1

		'' ')'?
		case CHAR_RPRNT, CHAR_RBRACE
			'' inside parentheses?
			if( prntcnt > 0 ) then
				prntcnt -= 1
			else
				exit do
			end if

		'' ','?
		case CHAR_COMMA
			'' skip until ','?
			if( token = CHAR_COMMA ) then
				'' not inside parentheses?
				if( prntcnt = 0 ) then
					exit do
				end if
			end if

		case else
			'' token found? exit..
			if( lexGetToken( flags ) = token ) then
				exit do
			end if

		end select

		lexSkipToken( flags )
	loop

	''
	if( doeat ) then
		if( token = lexGetToken( flags ) ) then
			lexSkipToken( flags )
		end if
	end if

end sub

'':::::
function hMatchExpr _
	( _
		byval dtype as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr expr

	if( cExpression( expr ) = FALSE ) then
		if( hReportError( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
			return NULL
		else
			'' error recovery: fake an expr
			if( dtype = INVALID ) then
				return NULL
			end if

			expr = astNewCONSTz( dtype )
		end if
	end if

	function = expr

end function

