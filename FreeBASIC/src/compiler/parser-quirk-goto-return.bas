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


'' quirk branch statements (GOTO, GOSUB, RETURN, RESUME) parsing
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
function cFuncReturn( byval checkexpr as integer = TRUE ) as integer

    function = FALSE

	if( (env.currproc = NULL) or (env.procstmt.endlabel = NULL) ) then
		hReportError( FB_ERRMSG_ILLEGALOUTSIDEASUB )
		exit function
	end if

	if( checkexpr ) then
		if( hAssignFunctResult( env.currproc ) = FALSE ) then
			exit function
		end if
	end if

	'' do an implicit exit function
	astAdd( astNewBRANCH( IR_OP_JMP, env.procstmt.endlabel ) )

	function = TRUE

end function

'':::::
''GotoStmt   	  =   GOTO LABEL
''				  |   GOSUB LABEL
''				  |	  RETURN LABEL?
''				  |   RESUME NEXT? .
''
function cGotoStmt as integer
	dim as FBSYMBOL ptr l
	dim as integer isglobal, isnext

	function = FALSE

	select case as const lexGetToken( )
	'' GOTO LABEL
	case FB_TK_GOTO
		lexSkipToken( )

		if( lexGetClass( ) = FB_TKCLASS_NUMLITERAL ) then
			l = symbFindByNameAndClass( lexGetText( ), FB_SYMBCLASS_LABEL )
		else
			l = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_LABEL )
		end if

		if( l = NULL ) then
			l = symbAddLabel( lexGetText( ), FALSE, TRUE )
		end if
		lexSkipToken( )

		astAdd( astNewBRANCH( IR_OP_JMP, l ) )

		function = TRUE

	'' GOSUB LABEL
	case FB_TK_GOSUB
		lexSkipToken( )

		if( lexGetClass = FB_TKCLASS_NUMLITERAL ) then
			l = symbFindByNameAndClass( lexGetText( ), FB_SYMBCLASS_LABEL )
		else
			l = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_LABEL )
		end if

		if( l = NULL ) then
			l = symbAddLabel( lexGetText( ), FALSE, TRUE )
		end if
		lexSkipToken( )

		astAdd( astNewBRANCH( IR_OP_CALL, l ) )

		function = TRUE

	'' RETURN ((LABEL? Comment|StmtSep|EOF) | Expression)
	case FB_TK_RETURN
		lexSkipToken( )

		'' Comment|StmtSep|EOF|ELSE? just return
		select case lexGetToken( )
		case FB_TK_EOL, FB_TK_STATSEPCHAR, FB_TK_EOF, FB_TK_COMMENTCHAR, _
			 FB_TK_REM, FB_TK_ELSE

			'' try to guess here.. if inside a proc currently and no user label was
			'' emitted, it's probably a FUNCTION return, not a GOSUB return
			l = NULL
			if( fbIsLocal( ) ) then
				l = symbGetLastLabel( )
				if( l <> NULL ) then
					if( l->scope <> env.scope ) then
						l = NULL
					end if
				end if
			end if

			if( (fbIsLocal( ) = FALSE) or (l <> NULL) ) then
				'' return 0
				astAdd( astNewBRANCH( IR_OP_RET, NULL ) )
			else
				function = cFuncReturn( FALSE )
			end if

		case else

			l = NULL

			'' Comment|StmtSep|EOF following? check if it's not an already defined label
			select case lexGetLookAhead( 1 )
			case FB_TK_EOL, FB_TK_STATSEPCHAR, FB_TK_EOF, FB_TK_COMMENTCHAR, _
				 FB_TK_REM, FB_TK_ELSE
				if( lexGetClass( ) = FB_TKCLASS_NUMLITERAL ) then
					l = symbFindByNameAndClass( lexGetText( ), FB_SYMBCLASS_LABEL )
				else
					l = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_LABEL )
				end if
			end select

			'' label?
			if( l <> NULL ) then
				lexSkipToken( )
				astAdd( astNewBRANCH( IR_OP_JMP, l ) )
				function = TRUE

			'' must be a function return then
			else
				function = cFuncReturn( )
			end if

		end select


	'' RESUME NEXT?
	case FB_TK_RESUME

		if( env.clopt.resumeerr = FALSE ) then
			hReportError( FB_ERRMSG_ILLEGALRESUMEERROR )
			exit function
		end if

		lexSkipToken( )

		if( hMatch( FB_TK_NEXT ) ) then
			isnext = TRUE
		else
			isnext = FALSE
		end if

		rtlErrorResume( isnext )

		function = TRUE
	end select

end function

