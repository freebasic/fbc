'' compound statements (FOR, DO, WHILE, ...) top-level plus EXIT, END and CONTINUE parsing
''
'' chng: sep/2004 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"
#include once "rtl.bi"

declare sub parserSelectStmtInit ( )
declare sub parserSelectStmtEnd ( )
declare sub parserSelConstStmtInit ( )
declare sub parserSelConstStmtEnd ( )
declare sub cCompoundEnd( )

sub parserCompoundStmtSetCtx( )
	parser.stmt.for = NULL
	parser.stmt.do  = NULL
	parser.stmt.while = NULL
	parser.stmt.select = NULL
	parser.stmt.proc = NULL
	parser.stmt.with = NULL
end sub

sub parserCompoundStmtInit( )
	parserSelectStmtInit( )
	parserSelConstStmtInit( )
end sub

sub parserCompoundStmtEnd( )
	parserSelConstStmtEnd( )
	parserSelectStmtEnd( )
end sub

#macro CHECK_CODEMASK( for_tk, until_tk )
	if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_CODE ) = FALSE ) then
		hSkipCompound( for_tk, until_tk )
		exit function
	end if
#endmacro

'':::::
''CompoundStmt    =   IfStatement
''                |   ForStatement
''                |   DoStatement
''                |   WhileStatement
''                |   SelectStatement
''                |   ExitStatement
''                |   ContinueStatement
''                |   EndStatement
''
function cCompoundStmt as integer
	'' QB mode?
	if( env.clopt.lang = FB_LANG_QB ) then
		if( lexGetType() <> FB_DATATYPE_INVALID ) then
			return FALSE
		end if
	end if

	select case as const lexGetToken( )
	case FB_TK_IF
		CHECK_CODEMASK( FB_TK_IF, FB_TK_IF )
		cIfStmtBegin( )

	case FB_TK_FOR
		CHECK_CODEMASK( FB_TK_FOR, FB_TK_NEXT )
		cForStmtBegin( )

	case FB_TK_DO
		CHECK_CODEMASK( FB_TK_DO, FB_TK_LOOP )
		cDoStmtBegin( )

	case FB_TK_WHILE
		CHECK_CODEMASK( FB_TK_WHILE, FB_TK_WEND )
		cWhileStmtBegin( )

	case FB_TK_SELECT
		CHECK_CODEMASK( FB_TK_SELECT, FB_TK_SELECT )
		cSelectStmtBegin( )

	case FB_TK_WITH
		CHECK_CODEMASK( FB_TK_WITH, FB_TK_WITH )
		cWithStmtBegin()

	case FB_TK_SCOPE
		CHECK_CODEMASK( FB_TK_SCOPE, FB_TK_SCOPE )
		cScopeStmtBegin( )

	case FB_TK_NAMESPACE
		cNamespaceStmtBegin( )

	case FB_TK_EXTERN
		cExternStmtBegin( )

	case FB_TK_ELSE, FB_TK_ELSEIF
		cIfStmtNext( )

	case FB_TK_CASE
		cSelectStmtNext( )

	case FB_TK_LOOP
		cDoStmtEnd( )

	case FB_TK_NEXT
		cForStmtEnd( )

	case FB_TK_WEND
		cWhileStmtEnd( )

	case FB_TK_EXIT
		cExitStatement( )

	case FB_TK_CONTINUE
		cContinueStatement( )

	case FB_TK_END
		'' any compound END will be parsed by the compound stmt
		if( lexGetLookAheadClass( 1 ) <> FB_TKCLASS_KEYWORD ) then
			CHECK_CODEMASK( INVALID, INVALID )
			cEndStatement( )
		else
			cCompoundEnd( )
		end if

	case FB_TK_ENDIF
		cIfStmtEnd( )

	case FB_TK_USING
		cUsingStmt( )

	case else
		return FALSE
	end select

	function = TRUE
end function

'' EndStatement  =  END Expression? .
sub cEndStatement( )
	dim as ASTNODE ptr errlevel = any

	'' END
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' Expression?
	select case as const lexGetToken( )
	case FB_TK_STMTSEP, FB_TK_EOL, FB_TK_EOF, FB_TK_COMMENT, FB_TK_REM, _
		 FB_TK_ELSE, FB_TK_END, FB_TK_ENDIF
		errlevel = NULL
	case else
		errlevel = cExpression( )
	end select

	rtlExitApp( errlevel )
end sub

private function hCheckForCtorResult( ) as integer
	if( symbGetProcStatReturnUsed( parser.currproc ) ) then
		if( symbHasCtor( parser.currproc ) and _
		    (not symbIsReturnByRef( parser.currproc )) ) then
			'' EXIT FUNCTION cannot be allowed in combination
			'' with RETURN and a ctor result for byval functions,
			'' because it would not call the result constructor.
			return FB_ERRMSG_MISSINGRETURNFORCTORRESULT
		end if
	end if

	'' EXIT FUNCTION used; mark the function as if FUNCTION= was used,
	'' to ensure the result will be constructed at the top if needed.
	symbSetProcStatAssignUsed( parser.currproc )
	function = FB_ERRMSG_OK
end function

'':::::
#macro hExitError( errnum )
	errReport( errnum )
	'' error recovery: skip stmt
	hSkipStmt( )
	return
#endmacro

'' ExitStatement  =  EXIT (FOR | DO | WHILE | SELECT | SUB | FUNCTION)
sub cExitStatement( )
	dim as FBSYMBOL ptr label = NULL

	'' EXIT
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' between SELECT CASE and first CASE? ... that's not allowed
	if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_DECL or FB_CMPSTMT_MASK_CODE ) = FALSE ) then
		hSkipStmt( )
	end if

	'' (FOR | DO | WHILE | SELECT | SUB | FUNCTION) (',')*
	var tk = lexGetToken( )
	select case as const( tk )
	case FB_TK_FOR
		if( parser.stmt.for = NULL ) then
			hExitError( FB_ERRMSG_ILLEGALOUTSIDEFORSTMT )
		end if

		lexSkipToken( LEXCHECK_POST_SUFFIX )

		dim as FB_CMPSTMTSTK ptr stk = parser.stmt.for
		do while( lexGetToken( ) = CHAR_COMMA )
			lexSkipToken( )

			if( lexGetToken( ) <> FB_TK_FOR ) then
				hExitError( FB_ERRMSG_EXPECTEDFOR )
			end if

			stk = stk->for.last
			if( stk = NULL ) then
				hExitError( FB_ERRMSG_NOENCLOSEDFORSTMT )
			end if

			lexSkipToken( LEXCHECK_POST_SUFFIX )
		loop

		label = stk->for.endlabel

	case FB_TK_DO
		if( parser.stmt.do = NULL ) then
			hExitError( FB_ERRMSG_ILLEGALOUTSIDEDOSTMT )
		end if

		lexSkipToken( LEXCHECK_POST_SUFFIX )

		dim as FB_CMPSTMTSTK ptr stk = parser.stmt.do
		do while( lexGetToken( ) = CHAR_COMMA )
			lexSkipToken( )

			if( lexGetToken( ) <> FB_TK_DO ) then
				hExitError( FB_ERRMSG_EXPECTEDDO )
			end if

			stk = stk->do.last
			if( stk = NULL ) then
				hExitError( FB_ERRMSG_NOENCLOSEDDOSTMT )
			end if

			lexSkipToken( LEXCHECK_POST_SUFFIX )
		loop

		label = stk->do.endlabel

	case FB_TK_WHILE
		if( parser.stmt.while = NULL ) then
			hExitError( FB_ERRMSG_ILLEGALOUTSIDEWHILESTMT )
		end if

		lexSkipToken( LEXCHECK_POST_SUFFIX )

		dim as FB_CMPSTMTSTK ptr stk = parser.stmt.while
		do while( lexGetToken( ) = CHAR_COMMA )
			lexSkipToken( )

			if( lexGetToken( ) <> FB_TK_WHILE ) then
				hExitError( FB_ERRMSG_EXPECTEDWHILE )
			end if

			stk = stk->while.last
			if( stk = NULL ) then
				hExitError( FB_ERRMSG_NOENCLOSEDWHILESTMT )
			end if

			lexSkipToken( LEXCHECK_POST_SUFFIX )
		loop

		label = stk->while.endlabel

	case FB_TK_SELECT
		if( parser.stmt.select = NULL ) then
			hExitError( FB_ERRMSG_ILLEGALOUTSIDESELSTMT )
		end if

		lexSkipToken( LEXCHECK_POST_SUFFIX )

		dim as FB_CMPSTMTSTK ptr stk = parser.stmt.select
		do while( lexGetToken( ) = CHAR_COMMA )
			lexSkipToken( )

			if( lexGetToken( ) <> FB_TK_SELECT ) then
				hExitError( FB_ERRMSG_EXPECTEDSELECT )
			end if

			stk = stk->select.last
			if( stk = NULL ) then
				hExitError( FB_ERRMSG_NOENCLOSEDSELSTMT )
			end if

			lexSkipToken( LEXCHECK_POST_SUFFIX )
		loop

		label = stk->select.endlabel

	case FB_TK_SUB, FB_TK_FUNCTION, FB_TK_PROPERTY, FB_TK_OPERATOR, _
		 FB_TK_CONSTRUCTOR, FB_TK_DESTRUCTOR

		if( parser.stmt.proc <> NULL ) then
			label = parser.stmt.proc->proc.endlabel
		end if

		if( label = NULL ) then
			dim errmsg as integer
			select case as const( tk )
			case FB_TK_SUB         : errmsg = FB_ERRMSG_ILLEGALOUTSIDEASUB
			case FB_TK_PROPERTY    : errmsg = FB_ERRMSG_ILLEGALOUTSIDEAPROPERTY
			case FB_TK_OPERATOR    : errmsg = FB_ERRMSG_ILLEGALOUTSIDEANOPERATOR
			case FB_TK_CONSTRUCTOR : errmsg = FB_ERRMSG_ILLEGALOUTSIDEACTOR
			case FB_TK_DESTRUCTOR  : errmsg = FB_ERRMSG_ILLEGALOUTSIDEADTOR
			case else              : errmsg = FB_ERRMSG_ILLEGALOUTSIDEAFUNCTION
			end select
			hExitError( errmsg )
		end if

		dim as FB_ERRMSG errnum = FB_ERRMSG_OK

		select case as const lexGetToken( )
		case FB_TK_SUB
			if( symbGetType( parser.currproc ) = FB_DATATYPE_VOID ) then
				if( (parser.currproc->pattrib and _
					 (FB_PROCATTRIB_PROPERTY or FB_PROCATTRIB_OPERATOR or _
					  FB_PROCATTRIB_CONSTRUCTOR or FB_PROCATTRIB_DESTRUCTOR1 or FB_PROCATTRIB_DESTRUCTOR0)) <> 0 ) then
					errnum = FB_ERRMSG_ILLEGALOUTSIDEASUB
				end if
			else
				errnum = FB_ERRMSG_ILLEGALOUTSIDEASUB
			end if

		case FB_TK_FUNCTION
			if( symbGetType( parser.currproc ) <> FB_DATATYPE_VOID ) then
				if( (parser.currproc->pattrib and _
					 (FB_PROCATTRIB_PROPERTY or FB_PROCATTRIB_OPERATOR or _
					  FB_PROCATTRIB_CONSTRUCTOR or FB_PROCATTRIB_DESTRUCTOR1 or FB_PROCATTRIB_DESTRUCTOR0)) <> 0 ) then
					errnum = FB_ERRMSG_ILLEGALOUTSIDEAFUNCTION
				else
					errnum = hCheckForCtorResult( )
				end if
			else
				errnum = FB_ERRMSG_ILLEGALOUTSIDEAFUNCTION
			end if

		case FB_TK_PROPERTY
			if( symbIsProperty( parser.currproc ) ) then
				errnum = hCheckForCtorResult( )
			else
				errnum = FB_ERRMSG_ILLEGALOUTSIDEAPROPERTY
			end if

		case FB_TK_OPERATOR
			if( symbIsOperator( parser.currproc ) ) then
				errnum = hCheckForCtorResult( )
			else
				errnum = FB_ERRMSG_ILLEGALOUTSIDEANOPERATOR
			end if

		case FB_TK_CONSTRUCTOR
			if( symbIsConstructor( parser.currproc ) = FALSE ) then
				errnum = FB_ERRMSG_ILLEGALOUTSIDEACTOR
			end if

		case FB_TK_DESTRUCTOR
			if( symbIsDestructor1( parser.currproc ) = FALSE ) then
				errnum = FB_ERRMSG_ILLEGALOUTSIDEADTOR
			end if

		end select

		if( errnum <> FB_ERRMSG_OK ) then
			hExitError( errnum )
		end if

		lexSkipToken( LEXCHECK_POST_SUFFIX )

	case else
		hExitError( FB_ERRMSG_INVALIDEXITSTMT )
	end select

	astScopeBreak( label )
end sub

'' ContinueStatement  =  CONTINUE (FOR | DO | WHILE)
sub cContinueStatement( )
	dim as FBSYMBOL ptr label = NULL

	'' CONTINUE
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' (FOR | DO | WHILE) (',')*
	select case as const lexGetToken( )
	case FB_TK_FOR
		if( parser.stmt.for = NULL ) then
			hExitError( FB_ERRMSG_ILLEGALOUTSIDEFORSTMT )
		end if

		lexSkipToken( LEXCHECK_POST_SUFFIX )

		dim as FB_CMPSTMTSTK ptr stk = parser.stmt.for
		do while( lexGetToken( ) = CHAR_COMMA )
			lexSkipToken( )

			if( lexGetToken( ) <> FB_TK_FOR ) then
				hExitError( FB_ERRMSG_EXPECTEDFOR )
			end if

			stk = stk->for.last
			if( stk = NULL ) then
				hExitError( FB_ERRMSG_NOENCLOSEDFORSTMT )
			end if

			lexSkipToken( LEXCHECK_POST_SUFFIX )
		loop

		label = stk->for.cmplabel

	case FB_TK_DO
		if( parser.stmt.do = NULL ) then
			hExitError( FB_ERRMSG_ILLEGALOUTSIDEDOSTMT )
		end if

		lexSkipToken( LEXCHECK_POST_SUFFIX )

		dim as FB_CMPSTMTSTK ptr stk = parser.stmt.do
		do while( lexGetToken( ) = CHAR_COMMA )
			lexSkipToken( )

			if( lexGetToken( ) <> FB_TK_DO ) then
				hExitError( FB_ERRMSG_EXPECTEDDO )
			end if

			stk = stk->do.last
			if( stk = NULL ) then
				hExitError( FB_ERRMSG_NOENCLOSEDDOSTMT )
			end if

			lexSkipToken( LEXCHECK_POST_SUFFIX )
		loop

		label = stk->do.cmplabel

	case FB_TK_WHILE
		if( parser.stmt.while = NULL ) then
			hExitError( FB_ERRMSG_ILLEGALOUTSIDEWHILESTMT )
		end if

		lexSkipToken( LEXCHECK_POST_SUFFIX )

		dim as FB_CMPSTMTSTK ptr stk = parser.stmt.while
		do while( lexGetToken( ) = CHAR_COMMA )
			lexSkipToken( )

			if( lexGetToken( ) <> FB_TK_WHILE ) then
				hExitError( FB_ERRMSG_EXPECTEDWHILE )
			end if

			stk = stk->while.last
			if( stk = NULL ) then
				hExitError( FB_ERRMSG_NOENCLOSEDWHILESTMT )
			end if

			lexSkipToken( LEXCHECK_POST_SUFFIX )
		loop

		label = stk->while.cmplabel

	case else
		hExitError( FB_ERRMSG_INVALIDCONTINUESTMT )
	end select

	astScopeBreak( label )
end sub

'' CompoundEnd  =  END (IF | SELECT | SUB | FUNCTION | SCOPE | WITH | NAMESPACE | EXTERN)
private sub cCompoundEnd( )
	select case as const lexGetLookAhead( 1 )
	case FB_TK_IF
		cIfStmtEnd( )

	case FB_TK_SELECT
		cSelectStmtEnd( )

	case FB_TK_SUB, FB_TK_FUNCTION, FB_TK_CONSTRUCTOR, FB_TK_DESTRUCTOR, _
		 FB_TK_OPERATOR, FB_TK_PROPERTY
		cProcStmtEnd( )

	case FB_TK_SCOPE
		cScopeStmtEnd( )

	case FB_TK_WITH
		cWithStmtEnd( )

	case FB_TK_NAMESPACE
		cNamespaceStmtEnd( )

	case FB_TK_EXTERN
		cExternStmtEnd( )

	'' QB quirk: IF expr THEN END ELSE ...|ENDIF|END IF
	case FB_TK_ELSE, FB_TK_END, FB_TK_ENDIF
		cEndStatement( )

	case else
		errReport( FB_ERRMSG_ILLEGALEND )
		'' error recovery: skip stmt
		hSkipStmt( )
	end select
end sub

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
		select case as const stk->proc.tkn
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
		case FB_TK_PROPERTY
			errmsg = FB_ERRMSG_EXPECTEDENDPROPERTY
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
		stk->do.last = parser.stmt.do
		parser.stmt.do = stk

	case FB_TK_FOR
		stk->for.last = parser.stmt.for
		parser.stmt.for = stk

	case FB_TK_SELECT
		stk->select.last = parser.stmt.select
		parser.stmt.select = stk

	case FB_TK_WHILE
		stk->while.last = parser.stmt.while
		parser.stmt.while = stk

	case FB_TK_FUNCTION
		stk->proc.last = parser.stmt.proc
		parser.stmt.proc = stk

	case FB_TK_WITH
		stk->with.last = parser.stmt.with
		parser.stmt.with = stk
	end select

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

sub cCompStmtPop( byval stk as FB_CMPSTMTSTK ptr )
	'' restore old values if any
	select case as const stk->id
	case FB_TK_DO
		parser.stmt.do = stk->do.last

	case FB_TK_FOR
		parser.stmt.for = stk->for.last

	case FB_TK_SELECT
		parser.stmt.select = stk->select.last

	case FB_TK_WHILE
		parser.stmt.while = stk->while.last

	case FB_TK_FUNCTION
		parser.stmt.proc = stk->proc.last

	case FB_TK_WITH
		parser.stmt.with = stk->with.last
	end select

	stackPop( @parser.stmt.stk )

	stk = stackGetTOS( @parser.stmt.stk )
	if( stk ) then
		parser.stmt.id = stk->id
	else
		parser.stmt.id = 0
	end if
end sub

function cCompStmtIsAllowed( byval allowmask as FB_CMPSTMT_MASK ) as integer
	dim as FB_CMPSTMTSTK ptr stk = any
	dim as integer errmsg = any

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
	if( fbIsModLevel( ) = FALSE ) then
		if( stk->id = FB_TK_SELECT ) then
			errmsg = FB_ERRMSG_ILLEGALINSIDESELECT
		else
			errmsg = FB_ERRMSG_ILLEGALINSIDEASUB
		end if
	else
		if( symbIsGlobalNamespc( ) ) then
			if( stk->id = FB_TK_SELECT ) then
				errmsg = FB_ERRMSG_ILLEGALINSIDESELECT
			else
				errmsg = FB_ERRMSG_ILLEGALINSIDEASCOPE
			end if
		else
			errmsg = FB_ERRMSG_ILLEGALINSIDEANAMESPC
		end if
	end if

	errReportEx( errmsg, "" )

	function = FALSE
end function
