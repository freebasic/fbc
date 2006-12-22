''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2007 The FreeBASIC development team.
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


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"

'':::::
private function hFuncReturn _
	( _
	) as integer

    dim as integer checkexpr = any

    function = FALSE

	if( parser.stmt.proc.endlabel = NULL ) then
		if( errReport( FB_ERRMSG_ILLEGALOUTSIDEASUB ) = FALSE ) then
			exit function
		else
			hSkipStmt( )
			return TRUE
		end if
	end if

	'' skip RETURN
	lexSkipToken( )

	'' function?
	if( symbGetType( parser.currproc ) <> FB_DATATYPE_VOID ) then
		checkexpr = TRUE

	else
		'' Comment|StmtSep|EOF? just exit
		select case as const lexGetToken( )
		case FB_TK_EOL, FB_TK_STMTSEP, FB_TK_EOF, FB_TK_COMMENT, FB_TK_REM
			checkexpr = FALSE
		case else
			checkexpr = TRUE
		end select
	end if

	if( checkexpr ) then
		if( cAssignFunctResult( parser.currproc, TRUE ) = FALSE ) then
			exit function
		end if
	end if

	'' do an implicit exit function
	function = astScopeBreak( parser.stmt.proc.endlabel )

end function

'':::::
''GotoStmt   	  =   GOTO LABEL
''				  |   GOSUB LABEL
''				  |	  RETURN LABEL?
''				  |   RESUME NEXT? .
''
function cGotoStmt _
	( _
		byval tk as FB_TOKEN _
	) as integer

	dim as FBSYMBOL ptr l = any
	dim as FBSYMCHAIN ptr chain_ = any
	dim as FBSYMBOL ptr base_parent = any

	function = FALSE

	select case as const tk
	'' GOTO LABEL
	case FB_TK_GOTO
		lexSkipToken( )

		if( lexGetClass( ) = FB_TKCLASS_NUMLITERAL ) then
			l = symbLookupByNameAndClass( symbGetCurrentNamespc( ), _
										  lexGetText( ), _
										  FB_SYMBCLASS_LABEL )

		else
			chain_ = cIdentifier( base_parent, FB_IDOPT_ISDECL or FB_IDOPT_DEFAULT )
			if( errGetLast( ) <> FB_ERRMSG_OK ) then
				exit function
			end if

			l = symbFindByClass( chain_, FB_SYMBCLASS_LABEL )
		end if

		if( l = NULL ) then
			l = symbAddLabel( lexGetText( ), FB_SYMBOPT_CREATEALIAS )
		end if

		lexSkipToken( )

		function = astScopeBreak( l )

	'' GOSUB LABEL
	case FB_TK_GOSUB

		if( fbLangOptIsSet( FB_LANG_OPT_GOSUB ) = FALSE ) then
			if( errReportNotAllowed( FB_LANG_OPT_GOSUB ) = FALSE ) then
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
			chain_ = cIdentifier( base_parent, FB_IDOPT_ISDECL or FB_IDOPT_DEFAULT )
			if( errGetLast( ) <> FB_ERRMSG_OK ) then
				exit function
			end if

			l = symbFindByClass( chain_, FB_SYMBCLASS_LABEL )
		end if

		if( l = NULL ) then
			l = symbAddLabel( lexGetText( ), FB_SYMBOPT_CREATEALIAS )
		end if

		lexSkipToken( )

		astAdd( astNewBRANCH( AST_OP_CALL, l ) )

		function = TRUE

	'' RETURN ((LABEL? Comment|StmtSep|EOF) | Expression)
	case FB_TK_RETURN

		'' proc return?
		if( fbLangOptIsSet( FB_LANG_OPT_GOSUB ) = FALSE ) then
			return hFuncReturn( )
		end if

		'' it's a GOSUB's RETURN..
		lexSkipToken( )

		'' Comment|StmtSep|EOF|ELSE? just return
		select case as const lexGetToken( )
		case FB_TK_EOL, FB_TK_STMTSEP, FB_TK_EOF, FB_TK_COMMENT, _
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
				chain_ = cIdentifier( base_parent, FB_IDOPT_ISDECL or FB_IDOPT_DEFAULT )
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

	'' RESUME NEXT?
	case FB_TK_RESUME

		if( fbLangOptIsSet( FB_LANG_OPT_ONERROR ) = FALSE ) then
			if( errReportNotAllowed( FB_LANG_OPT_ONERROR ) = FALSE ) then
				exit function
			else
				hSkipStmt( )
				return TRUE
			end if
		end if

		lexSkipToken( )

		rtlErrorResume( hMatch( FB_TK_NEXT ) )

		function = TRUE
	end select

end function

