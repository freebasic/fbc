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
private function hFuncReturn( ) as integer
    dim as integer checkexpr

    function = FALSE

	if( env.stmt.proc.endlabel = NULL ) then
		if( errReport( FB_ERRMSG_ILLEGALOUTSIDEASUB ) = FALSE ) then
			exit function
		else
			hSkipStmt( )
			return TRUE
		end if
	end if

	'' Comment|StmtSep|EOF? just exit
	select case lexGetToken( )
	case FB_TK_EOL, FB_TK_STATSEPCHAR, FB_TK_EOF, FB_TK_COMMENTCHAR, FB_TK_REM
		checkexpr = FALSE
	case else
		checkexpr = TRUE
	end select

	if( checkexpr ) then
		if( cAssignFunctResult( env.currproc ) = FALSE ) then
			exit function
		end if
	end if

	'' do an implicit exit function
	function = astScopeBreak( env.stmt.proc.endlabel )

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
	dim as FBSYMCHAIN ptr chain_

	function = FALSE

	select case as const lexGetToken( )
	'' GOTO LABEL
	case FB_TK_GOTO
		lexSkipToken( )

		if( lexGetClass( ) = FB_TKCLASS_NUMLITERAL ) then
			l = symbLookupByNameAndClass( symbGetCurrentNamespc( ), _
										  lexGetText( ), _
										  FB_SYMBCLASS_LABEL )

		else
			chain_ = cIdentifier( TRUE )
			if( errGetLast( ) <> FB_ERRMSG_OK ) then
				exit function
			end if

			l = symbFindByClass( chain_, FB_SYMBCLASS_LABEL )
		end if

		if( l = NULL ) then
			l = symbAddLabel( lexGetText( ), FALSE, TRUE )
		end if

		lexSkipToken( )

		function = astScopeBreak( l )

	'' GOSUB LABEL
	case FB_TK_GOSUB
		'' difference from QB: not allowed inside procs
		if( fbIsModLevel() = FALSE ) then
			if( errReport( FB_ERRMSG_ILLEGALINSIDEASUB ) = FALSE ) then
				exit function
			else
				hSkipStmt( )
				return TRUE
			end if
		end if

		lexSkipToken( )

		if( lexGetClass( ) = FB_TKCLASS_NUMLITERAL ) then
			l = symbLookupByNameAndClass( symbGetCurrentNamespc( ), _
										  lexGetText( ), _
										  FB_SYMBCLASS_LABEL )

		else
			chain_ = cIdentifier( TRUE )
			if( errGetLast( ) <> FB_ERRMSG_OK ) then
				exit function
			end if

			l = symbFindByClass( chain_, FB_SYMBCLASS_LABEL )
		end if

		if( l = NULL ) then
			l = symbAddLabel( lexGetText( ), FALSE, TRUE )
		end if

		lexSkipToken( )

		astAdd( astNewBRANCH( AST_OP_CALL, l ) )

		function = TRUE

	'' RETURN ((LABEL? Comment|StmtSep|EOF) | Expression)
	case FB_TK_RETURN
		lexSkipToken( )

		'' inside a proc? GOSUB not allowed, see above
		if( fbIsModLevel() = FALSE ) then
			function = hFuncReturn( )

		'' module level, it's a GOSUB's RETURN
		else
			'' Comment|StmtSep|EOF|ELSE? just return
			select case lexGetToken( )
			case FB_TK_EOL, FB_TK_STATSEPCHAR, FB_TK_EOF, FB_TK_COMMENTCHAR, _
				 FB_TK_REM, FB_TK_ELSE

				'' return 0
				astAdd( astNewBRANCH( AST_OP_RET, NULL ) )
				function = TRUE

			case else
				if( lexGetClass( ) = FB_TKCLASS_NUMLITERAL ) then
					l = symbLookupByNameAndClass( symbGetCurrentNamespc( ), _
												  lexGetText( ), _
												  FB_SYMBCLASS_LABEL )

				else
					chain_ = cIdentifier( TRUE )
					if( errGetLast( ) <> FB_ERRMSG_OK ) then
						exit function
					end if

					l = symbFindByClass( chain_, FB_SYMBCLASS_LABEL )
				end if

				'' label?
				if( l <> NULL ) then
					lexSkipToken( )
					astAdd( astNewBRANCH( AST_OP_JMP, l ) )
					function = TRUE
				end if
			end select

		end if

	'' RESUME NEXT?
	case FB_TK_RESUME

		if( env.clopt.resumeerr = FALSE ) then
			if( errReport( FB_ERRMSG_ILLEGALRESUMEERROR ) = FALSE ) then
				exit function
			else
				hSkipStmt( )
				return TRUE
			end if
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

