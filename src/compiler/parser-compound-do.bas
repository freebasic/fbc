'' DO..LOOP compound statement parsing
''
'' chng: sep/2004 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

'' DoStmtBegin  =  DO ((WHILE | UNTIL) Expression)? .
sub cDoStmtBegin( )
	dim as ASTNODE ptr expr = any
	dim as integer iswhile = any, isuntil = any
	dim as FBSYMBOL ptr il = any, el = any, cl = any
	dim as FB_CMPSTMTSTK ptr stk = any

	'' DO
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' add ini and end labels (will be used by any EXIT DO)
	il = symbAddLabel( NULL )
	el = symbAddLabel( NULL, FB_SYMBOPT_NONE )

	'' emit ini label
	astAdd( astNewLABEL( il ) )

	'' ((WHILE | UNTIL) Expression)?
	iswhile = FALSE
	isuntil = fALSE

	select case lexGetToken( )
	case FB_TK_WHILE
		iswhile = TRUE
	case FB_TK_UNTIL
		isuntil = TRUE
	end select

	if( iswhile or isuntil ) then
		lexSkipToken( LEXCHECK_POST_SUFFIX )

		'' Expression
		expr = cExpression( )
		if( expr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
			'' error recovery: fake a node
			expr = astNewCONSTi( 0 )
		end if

		'' branch
		expr = astBuildBranch( expr, el, (not iswhile) )
		if( expr = NULL ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )
			'' error recovery: fake a node
			expr = astNewNOP( )
		end if

		astAdd( expr )
		cl = il

	else
		expr = NULL
		cl = symbAddLabel( NULL, FB_SYMBOPT_NONE )
	end if

	'' push to stmt stack
	stk = cCompStmtPush( FB_TK_DO )
	stk->scopenode = astScopeBegin( )
	stk->do.attop = (expr <> NULL)
	stk->do.inilabel = il
	stk->do.cmplabel = cl
	stk->do.endlabel = el
end sub

'' DoStmtEnd  =  LOOP ((WHILE | UNTIL) Expression)? .
sub cDoStmtEnd( )
	dim as ASTNODE ptr expr = any
	dim as integer iswhile = any, isuntil = any
	dim as FB_CMPSTMTSTK ptr stk = any

	stk = cCompStmtGetTOS( FB_TK_DO )
	if( stk = NULL ) then
		hSkipStmt( )
		exit sub
	end if

	'' LOOP
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' ((WHILE | UNTIL | SttSeparator) Expression)?
	iswhile = FALSE
	isuntil = fALSE

	select case lexGetToken( )
	case FB_TK_WHILE
		iswhile = TRUE
	case FB_TK_UNTIL
		isuntil = TRUE
	end select

	if( (iswhile or isuntil) and (stk->do.attop) ) then
		errReport( FB_ERRMSG_SYNTAXERROR )
	end if

	'' end scope
	if( stk->scopenode <> NULL ) then
		astScopeEnd( stk->scopenode )
	end if

	'' emit comp label, if needed
	if( stk->do.cmplabel <> stk->do.inilabel ) then
		astAdd( astNewLABEL( stk->do.cmplabel ) )
	end if

	'' bottom check?
	if( iswhile or isuntil ) then
		lexSkipToken( LEXCHECK_POST_SUFFIX )

		'' Expression
		expr = cExpression( )
		if( expr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
			'' error recovery: fake a node
			expr = astNewCONSTi( 0 )
		end if

		'' branch
		expr = astBuildBranch( expr, stk->do.inilabel, iswhile )
		if( expr = NULL ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )
			'' error recovery: fake a node
			expr = astNewNOP( )
		end if

		astAdd( expr )
	else
		'' top check
		astAdd( astNewBRANCH( AST_OP_JMP, stk->do.inilabel ) )
	end if

	'' end label (loop exit)
	astAdd( astNewLABEL( stk->do.endlabel ) )

	'' pop from stmt stack
	cCompStmtPop( stk )
end sub
