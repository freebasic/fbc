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


'':::::
sub parserCompoundStmtInit( )

	parserSelectStmtInit( )

end sub

'':::::
sub parserCompoundStmtEnd( )

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

    env.compoundcnt += 1

	select case as const lexGetToken( )
	case FB_TK_IF
		function = cIfStatement( )
	case FB_TK_FOR
		function = cForStatement( )
	case FB_TK_DO
		function = cDoStatement( )
	case FB_TK_WHILE
		function = cWhileStatement( )
	case FB_TK_ELSE, FB_TK_ELSEIF, FB_TK_CASE, FB_TK_LOOP, FB_TK_NEXT, FB_TK_WEND
		function = cCompoundStmtElm( )
	case FB_TK_SELECT
		function = cSelectStatement( )
	case FB_TK_EXIT
		function = cExitStatement( )
	case FB_TK_CONTINUE
		function = cContinueStatement( )
	case FB_TK_END
		function = cEndStatement( )
	case FB_TK_WITH
		function = cWithStatement( )
	case FB_TK_SCOPE
		function = cScopeStatement( )
	case else
		function = FALSE
	end select

	env.compoundcnt -= 1

end function

'':::::
''EndStatement	  =	  END (Expression | Keyword | ) .
''
function cEndStatement as integer
	dim as ASTNODE ptr errlevel

	function = FALSE

	if( lexGetToken( ) <> FB_TK_END ) then
		exit function
	end if

	'' any compound END will be parsed by the compound stmt
	if( lexGetLookAheadClass(1) = FB_TKCLASS_KEYWORD ) then

		if( env.compoundcnt = 1 ) then
			hReportError( FB_ERRMSG_ILLEGALEND )
			exit function
		end if

		return TRUE

	else
		lexSkipToken( )							'' END
	end if

  	'' (Expression | )
  	select case lexGetToken( )
  	case FB_TK_STATSEPCHAR, FB_TK_EOL, FB_TK_EOF, FB_TK_COMMENTCHAR, FB_TK_REM
  		errlevel = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
  	case else
  		if( cExpression( errlevel ) = FALSE ) then
  			errlevel = NULL
  		end if
  	end select

    ''
	function = rtlExitRt( errlevel )

end function

'':::::
''ExitStatement	  =	  EXIT (FOR | DO | WHILE | SUB | FUNCTION)
''
function cExitStatement as integer
    dim as FBSYMBOL ptr label

	function = FALSE

	'' EXIT
	lexSkipToken( )

	'' (FOR | DO | WHILE | SUB | FUNCTION)
	select case as const lexGetToken( )
	case FB_TK_FOR
		label = env.forstmt.endlabel

	case FB_TK_DO
		label = env.dostmt.endlabel

	case FB_TK_WHILE
		label = env.whilestmt.endlabel

	case FB_TK_SUB, FB_TK_FUNCTION
		label = env.procstmt.endlabel

		if( label = NULL ) then
			hReportError( FB_ERRMSG_ILLEGALOUTSIDEASUB )
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
	astAdd( astNewBRANCH( IR_OP_JMP, label ) )

	function = TRUE

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
		label = env.forstmt.cmplabel

	case FB_TK_DO
		label = env.dostmt.cmplabel

	case FB_TK_WHILE
		label = env.whilestmt.cmplabel

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
	astAdd( astNewBRANCH( IR_OP_JMP, label ) )

	function = TRUE

end function

'':::::
''CompoundStmtElm  =  WEND | LOOP | NEXT | CASE | ELSE | ELSEIF .
''
function cCompoundStmtElm as integer
    dim as integer comp

	function = FALSE

	'' WEND | LOOP | NEXT | CASE | ELSE | ELSEIF
	select case as const lexGetToken( )
	case FB_TK_WEND
		comp = FB_TK_WHILE
	case FB_TK_LOOP
		comp = FB_TK_DO
	case FB_TK_NEXT
		comp = FB_TK_FOR
	case FB_TK_CASE
		comp = FB_TK_SELECT
	case FB_TK_ELSE, FB_TK_ELSEIF
		comp = FB_TK_IF
	case else
		exit function
	end select

	if( comp <> env.lastcompound ) then
		hReportError( FB_ERRMSG_ILLEGALOUTSIDECOMP )
		exit function
	end if

	function = TRUE

end function

