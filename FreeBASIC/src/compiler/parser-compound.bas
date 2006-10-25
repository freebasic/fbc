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


'' compound statements (FOR, DO, WHILE, ...) top-level plus EXIT, END and CONTINUE parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"
#include once "inc\rtl.bi"

declare sub parserSelectStmtInit ( )

declare sub parserSelectStmtEnd	( )

declare sub parserSelConstStmtInit ( )

declare sub parserSelConstStmtEnd ( )

declare function cCompoundEnd ( ) as integer

'':::::
sub parserCompoundStmtSetCtx( )

	parser.stmt.for.cmplabel = NULL
	parser.stmt.for.endlabel = NULL
	parser.stmt.do.cmplabel	= NULL
	parser.stmt.do.endlabel	= NULL
	parser.stmt.while.cmplabel = NULL
	parser.stmt.while.endlabel = NULL
	parser.stmt.select.cmplabel = NULL
	parser.stmt.select.endlabel = NULL
	parser.stmt.proc.cmplabel = NULL
	parser.stmt.proc.endlabel = NULL
	parser.stmt.with.sym = NULL

end sub

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

#define CHECK_CODEMASK( for_tk, until_tk )								_
    if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_CODE ) = FALSE ) then		:_
    	hSkipCompound( for_tk, until_tk )								:_
    	exit function													:_
    end if

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

	function = FALSE

	select case as const lexGetToken( )
	case FB_TK_IF
		CHECK_CODEMASK( FB_TK_IF, FB_TK_IF )
		function = cIfStmtBegin( )

	case FB_TK_FOR
		CHECK_CODEMASK( FB_TK_FOR, FB_TK_NEXT )
		function = cForStmtBegin( )

	case FB_TK_DO
		CHECK_CODEMASK( FB_TK_DO, FB_TK_LOOP )
		function = cDoStmtBegin( )

	case FB_TK_WHILE
		CHECK_CODEMASK( FB_TK_WHILE, FB_TK_WEND )
		function = cWhileStmtBegin( )

	case FB_TK_SELECT
		CHECK_CODEMASK( FB_TK_SELECT, FB_TK_SELECT )
		function = cSelectStmtBegin( )

	case FB_TK_WITH
		CHECK_CODEMASK( FB_TK_WITH, FB_TK_WITH )
		function = cWithStmtBegin( )

	case FB_TK_SCOPE
		CHECK_CODEMASK( FB_TK_SCOPE, FB_TK_SCOPE )
		function = cScopeStmtBegin( )

	case FB_TK_NAMESPACE
		function = cNamespaceStmtBegin( )

	case FB_TK_EXTERN
		function = cExternStmtBegin( )

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
			CHECK_CODEMASK( INVALID, INVALID )
			return cEndStatement( )
		end if

		function = cCompoundEnd( )

	case FB_TK_ENDIF
		function = cIfStmtEnd( )

	case FB_TK_USING
		function = cUsingStmt( )

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
  	select case as const lexGetToken( )
  	case FB_TK_STMTSEP, FB_TK_EOL, FB_TK_EOF, FB_TK_COMMENT, FB_TK_REM
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
		label = parser.stmt.for.endlabel

	case FB_TK_DO
		label = parser.stmt.do.endlabel

	case FB_TK_WHILE
		label = parser.stmt.while.endlabel

	case FB_TK_SELECT
		label = parser.stmt.select.endlabel

	case FB_TK_SUB, FB_TK_FUNCTION
		label = parser.stmt.proc.endlabel

		if( label = NULL ) then
			if( errReport( FB_ERRMSG_ILLEGALOUTSIDEASUB ) = FALSE ) then
				exit function
			else
				'' error recovery: skip stmt
				lexSkipToken( )
				return TRUE
			end if
		end if

		'' useless check
		if( lexGetToken( ) <> iif( symbGetType( parser.currproc ) = FB_DATATYPE_VOID, _
								   FB_TK_SUB, _
								   FB_TK_FUNCTION ) ) then

			if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
				exit function
			else
				'' error recovery: skip stmt
				lexSkipToken( )
				return TRUE
			end if
		end if

	case else
		if( errReport( FB_ERRMSG_ILLEGALOUTSIDEASTMT ) = FALSE ) then
			exit function
		else
			'' error recovery: skip stmt
			lexSkipToken( )
			return TRUE
		end if
	end select

	''
	if( label = NULL ) then
		if( errReport( FB_ERRMSG_ILLEGALOUTSIDECOMP ) = FALSE ) then
			exit function
		else
			'' error recovery: skip stmt
			lexSkipToken( )
			return TRUE
		end if
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
		label = parser.stmt.for.cmplabel

	case FB_TK_DO
		label = parser.stmt.do.cmplabel

	case FB_TK_WHILE
		label = parser.stmt.while.cmplabel

	case else
		if( errReport( FB_ERRMSG_ILLEGALOUTSIDEASTMT ) = FALSE ) then
			exit function
		else
			'' error recovery: skip stmt
			lexSkipToken( )
			return TRUE
		end if
	end select

	if( label = NULL ) then
		if( errReport( FB_ERRMSG_ILLEGALOUTSIDECOMP ) = FALSE ) then
			exit function
		else
			'' error recovery: skip stmt
			lexSkipToken( )
			return TRUE
		end if
	end if

	lexSkipToken( )

	''
	function = astScopeBreak( label )

end function

'':::::
''CompoundEnd	  =	  END (IF | SELECT | SUB | FUNCTION | SCOPE | WITH | NAMESPACE | EXTERN)
''
function cCompoundEnd( ) as integer

	select case as const lexGetLookAhead( 1 )
	case FB_TK_IF
		function = cIfStmtEnd( )

	case FB_TK_SELECT
		function = cSelectStmtEnd( )

	case FB_TK_SUB, FB_TK_FUNCTION, FB_TK_CONSTRUCTOR, FB_TK_DESTRUCTOR, FB_TK_OPERATOR
		function = cProcStmtEnd( )

	case FB_TK_SCOPE
		function = cScopeStmtEnd( )

	case FB_TK_WITH
		function = cWithStmtEnd( )

	case FB_TK_NAMESPACE
		function = cNamespaceStmtEnd( )

	case FB_TK_EXTERN
		function = cExternStmtEnd( )

	case else
		if( errReport( FB_ERRMSG_ILLEGALEND ) = FALSE ) then
			exit function
		else
			'' error recovery: skip stmt
			hSkipStmt( )
			return TRUE
		end if
	end select

end function

'':::::
function cCompStmtCheck( ) as integer
    dim as integer errmsg
    dim as FB_CMPSTMTSTK ptr stk

    stk = stackGetTOS( @parser.stmt.stk )
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

    case FB_TK_NAMESPACE
    	errmsg = FB_ERRMSG_EXPECTEDENDNAMESPACE

    case FB_TK_EXTERN
    	errmsg = FB_ERRMSG_EXPECTEDENDEXTERN

    case FB_TK_FUNCTION
		select case stk->proc.tkn
		case FB_TK_SUB
			errmsg = FB_ERRMSG_EXPECTEDENDSUB
		case FB_TK_FUNCTION
			errmsg = FB_ERRMSG_EXPECTEDENDFUNCTION
		case FB_TK_CONSTRUCTOR
			errmsg = FB_ERRMSG_EXPECTEDENDCTOR
		case FB_TK_DESTRUCTOR
			errmsg = FB_ERRMSG_EXPECTEDENDDTOR
		case FB_TK_OPERATOR
			errmsg = FB_ERRMSG_EXPECTEDENDOPERATOR
		end select

    case FB_TK_DO
    	errmsg = FB_ERRMSG_EXPECTEDLOOP

    case FB_TK_WHILE
    	errmsg = FB_ERRMSG_EXPECTEDWEND

    case FB_TK_FOR
    	errmsg = FB_ERRMSG_EXPECTEDNEXT

    end select

    errReport( errmsg )

    function = FALSE

end function

'':::::
function cCompStmtPush _
	( _
		byval id as FB_TOKEN, _
		byval allowmask as FB_CMPSTMT_MASK _
	) as FB_CMPSTMTSTK ptr static

	dim as FB_CMPSTMTSTK ptr stk

	stk = stackPush( @parser.stmt.stk )
	stk->id = id
	stk->allowmask = allowmask
	stk->scopenode = NULL

	'' same current values, if any
	select case as const id
	case FB_TK_DO
		stk->last = parser.stmt.do

	case FB_TK_FOR
		stk->last = parser.stmt.for

	case FB_TK_SELECT
		stk->last = parser.stmt.select

	case FB_TK_WHILE
		stk->last = parser.stmt.while

	case FB_TK_FUNCTION
		stk->last = parser.stmt.proc
	end select

	parser.stmt.lastid = parser.stmt.id
	parser.stmt.id = id

	function = stk

end function

'':::::
function cCompStmtGetTOS _
	( _
		byval forid as FB_TOKEN, _
		byval showerror as integer _
	) as FB_CMPSTMTSTK ptr static

	dim as FB_CMPSTMTSTK ptr stk
	dim as integer iserror

	stk = stackGetTOS( @parser.stmt.stk )
	iserror = (stk = NULL)

	if( iserror = FALSE ) then
		'' not the expected id?
		iserror = (stk->id <> forid)
	end if

	if( iserror ) then
		if( showerror ) then
			if( stk <> NULL ) then
				cCompStmtCheck( )

			else
				dim as integer errmsg
				select case as const forid
				case FB_TK_DO
					errmsg = FB_ERRMSG_LOOPWITHOUTDO

        		case FB_TK_EXTERN
        			errmsg = FB_ERRMSG_ENDEXTERNWITHOUTEXTERN

				case FB_TK_FOR
					errmsg = FB_ERRMSG_NEXTWITHOUTFOR

				case FB_TK_IF
					errmsg = FB_ERRMSG_ENDIFWITHOUTIF

				case FB_TK_SCOPE
					errmsg = FB_ERRMSG_ENDSCOPEWITHOUTSCOPE

				case FB_TK_SELECT
					errmsg = FB_ERRMSG_ENDSELECTWITHOUTSELECT

				case FB_TK_WHILE
					errmsg = FB_ERRMSG_WENDWITHOUTWHILE

				case FB_TK_WITH
					errmsg = FB_ERRMSG_ENDWITHWITHOUTWITH

            	case FB_TK_FUNCTION
            		errmsg = FB_ERRMSG_ENDSUBWITHOUTSUB

				case FB_TK_NAMESPACE
            		errmsg = FB_ERRMSG_ENDNAMESPACEWITHOUTNAMESPACE
				end select

				errReport( errmsg )
			end if
		end if

		function = NULL

	else
		function = stk
	end if

end function

'':::::
sub cCompStmtPop _
	( _
		byval stk as FB_CMPSTMTSTK ptr _
	) static

	'' restore old values if any
	select case as const stk->id
	case FB_TK_DO
		parser.stmt.do = stk->last

	case FB_TK_FOR
		parser.stmt.for = stk->last

	case FB_TK_SELECT
		parser.stmt.select = stk->last

	case FB_TK_WHILE
		parser.stmt.while = stk->last

	case FB_TK_FUNCTION
		parser.stmt.proc = stk->last
	end select

	stackPop( @parser.stmt.stk )

	parser.stmt.id = parser.stmt.lastid

end sub

'':::::
function cCompStmtIsAllowed _
	( _
		byval allowmask as FB_CMPSTMT_MASK _
	) as integer static

	dim as FB_CMPSTMTSTK ptr stk

	stk = stackGetTOS( @parser.stmt.stk )

	'' module-level? anything allowed..
	if( stk = NULL ) then
		return TRUE
	end if

	'' allowed?
	if( stk->allowmask and allowmask ) then
		return TRUE
	end if

	'' error..
	dim as integer errmsg

	if( fbIsModLevel( ) = FALSE ) then
		errmsg = FB_ERRMSG_ILLEGALINSIDEASUB
	else
		if( symbIsGlobalNamespc( ) ) then
			errmsg = FB_ERRMSG_ILLEGALINSIDEASCOPE
		else
			errmsg = FB_ERRMSG_ILLEGALINSIDEANAMESPC
		end if
	end if

    errReport( errmsg )

	function = FALSE

end function
