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


'' compound statements (FOR, DO, WHILE, ...) top-level plus EXIT, END and CONTINUE parsing
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"
#include once "inc\rtl.bi"

declare sub 	 parserSelectStmtInit		( )

declare sub 	 parserSelectStmtEnd		( )

declare sub 	 parserSelConstStmtInit		( )

declare sub 	 parserSelConstStmtEnd		( )

declare function cCompoundEnd				( ) as integer

'':::::
sub parserCompoundStmtInit( )

	parserSelectStmtInit( )

	parserSelConstStmtInit( )

end sub

'':::::
sub parserCompoundStmtEnd( )

	parserSelConstStmtEnd( )

	parserSelectStmtEnd( )

end sub

'':::::
''CompoundStmt	  =   IfStatement
''				  |   ForStatement
''	              |   DoStatement
''				  |   WhileStatement
''				  |   SelectStatement
''				  |   ExitStatement
''				  |   ContinueStatement
''				  |   EndStatement
''
function cCompoundStmt as integer

	select case as const lexGetToken( )
	case FB_TK_IF
		function = cIfStmtBegin( )

	case FB_TK_FOR
		function = cForStmtBegin( )

	case FB_TK_DO
		function = cDoStmtBegin( )

	case FB_TK_WHILE
		function = cWhileStmtBegin( )

	case FB_TK_SELECT
		function = cSelectStmtBegin( )

	case FB_TK_WITH
		function = cWithStmtBegin( )

	case FB_TK_SCOPE
		function = cScopeStmtBegin( )

	case FB_TK_ELSE, FB_TK_ELSEIF
		function = cIfStmtNext( )

	case FB_TK_CASE
		function = cSelectStmtNext( )

	case FB_TK_LOOP
		function = cDoStmtEnd( )

	case FB_TK_NEXT
		function = cForStmtEnd( )

	case FB_TK_WEND
		function = cWhileStmtEnd( )

	case FB_TK_EXIT
		function = cExitStatement( )

	case FB_TK_CONTINUE
		function = cContinueStatement( )

	case FB_TK_END
		'' any compound END will be parsed by the compound stmt
		if( lexGetLookAheadClass( 1 ) <> FB_TKCLASS_KEYWORD ) then
			return cEndStatement( )
		end if

		function = cCompoundEnd( )

	case FB_TK_ENDIF
		function = cIfStmtEnd( )

	case else
		return FALSE
	end select

end function

'':::::
''EndStatement	  =	  END Expression? .
''
function cEndStatement as integer
	dim as ASTNODE ptr errlevel

	function = FALSE

	'' END
	lexSkipToken( )

  	'' Expression?
  	select case lexGetToken( )
  	case FB_TK_STATSEPCHAR, FB_TK_EOL, FB_TK_EOF, FB_TK_COMMENTCHAR, FB_TK_REM
  		errlevel = astNewCONSTi( 0, FB_DATATYPE_INTEGER )

  	case else
  		if( cExpression( errlevel ) = FALSE ) then
  			errlevel = NULL
  		end if
  	end select

    ''
	function = rtlExitApp( errlevel )

end function

'':::::
''ExitStatement	  =	  EXIT (FOR | DO | WHILE | SELECT | SUB | FUNCTION)
''
function cExitStatement as integer
    dim as FBSYMBOL ptr label

	function = FALSE

	'' EXIT
	lexSkipToken( )

	'' (FOR | DO | WHILE | SELECT | SUB | FUNCTION)
	select case as const lexGetToken( )
	case FB_TK_FOR
		label = env.stmt.for.endlabel

	case FB_TK_DO
		label = env.stmt.do.endlabel

	case FB_TK_WHILE
		label = env.stmt.while.endlabel

	case FB_TK_SELECT
		label = env.stmt.select.endlabel

	case FB_TK_SUB, FB_TK_FUNCTION
		label = env.stmt.proc.endlabel

		if( label = NULL ) then
			hReportError( FB_ERRMSG_ILLEGALOUTSIDEASUB )
			exit function
		end if

		'' useless check
		if( lexGetToken( ) <> iif( symbGetType( env.currproc ) = FB_DATATYPE_VOID, _
								   FB_TK_SUB, _
								   FB_TK_FUNCTION ) ) then
			hReportError( FB_ERRMSG_SYNTAXERROR )
			exit function
		end if

	case else
		hReportError( FB_ERRMSG_ILLEGALOUTSIDEASTMT )
		exit function
	end select

	''
	if( label = NULL ) then
		hReportError( FB_ERRMSG_ILLEGALOUTSIDECOMP )
		exit function
	end if

	lexSkipToken( )

	''
	function = astScopeBreak( label )

end function

'':::::
''ContinueStatement	  =	  CONTINUE (FOR | DO | WHILE)
''
function cContinueStatement as integer
    dim as FBSYMBOL ptr label

	function = FALSE

	'' CONTINUE
	lexSkipToken( )

	'' (FOR | DO | WHILE)
	select case as const lexGetToken( )
	case FB_TK_FOR
		label = env.stmt.for.cmplabel

	case FB_TK_DO
		label = env.stmt.do.cmplabel

	case FB_TK_WHILE
		label = env.stmt.while.cmplabel

	case else
		hReportError( FB_ERRMSG_ILLEGALOUTSIDEASTMT )
		exit function
	end select

	if( label = NULL ) then
		hReportError( FB_ERRMSG_ILLEGALOUTSIDECOMP )
		exit function
	end if

	lexSkipToken( )

	''
	function = astScopeBreak( label )

end function

'':::::
''CompoundEnd	  =	  END (IF | SELECT | SUB | FUNCTION | SCOPE | WITH)
''
function cCompoundEnd( ) as integer

	select case as const lexGetLookAhead( 1 )
	case FB_TK_IF
		function = cIfStmtEnd( )

	case FB_TK_SELECT
		function = cSelectStmtEnd( )

	case FB_TK_SUB, FB_TK_FUNCTION
		function = cProcStmtEnd( )

	case FB_TK_SCOPE
		function = cScopeStmtEnd( )

	case FB_TK_WITH
		function = cWithStmtEnd( )

	case else
		hReportError( FB_ERRMSG_ILLEGALEND )
		function = FALSE
	end select

end function

'':::::
function cCompStmtCheck( ) as integer
    dim as integer errmsg
    dim as FB_CMPSTMTSTK ptr stk

    stk = stackGetTOS( @env.stmtstk )
    if( stk = NULL ) then
    	return TRUE
    end if

    select case as const stk->id
    case FB_TK_IF
    	errmsg = FB_ERRMSG_EXPECTEDENDIF

    case FB_TK_SELECT
    	errmsg = FB_ERRMSG_EXPECTEDENDSELECT

    case FB_TK_SCOPE
    	errmsg = FB_ERRMSG_EXPECTEDENDSCOPE

    case FB_TK_WITH
    	errmsg = FB_ERRMSG_EXPECTEDENDWITH

    case FB_TK_SUB, FB_TK_FUNCTION
    	errmsg = FB_ERRMSG_EXPECTEDENDSUBORFUNCT

    case FB_TK_DO
    	errmsg = FB_ERRMSG_EXPECTEDLOOP

    case FB_TK_WHILE
    	errmsg = FB_ERRMSG_EXPECTEDWEND

    case FB_TK_FOR
    	errmsg = FB_ERRMSG_EXPECTEDNEXT

    end select

    hReportError( errmsg )

    function = FALSE

end function

