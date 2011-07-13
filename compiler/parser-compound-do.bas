'' DO..LOOP compound statement parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

'':::::
'' DoStmtBegin     =   DO ((WHILE | UNTIL) Expression)? .
''
function cDoStmtBegin as integer
    dim as ASTNODE ptr expr = any
	dim as integer iswhile = any, isuntil = any, isinverse = any
    dim as FBSYMBOL ptr il = any, el = any, cl = any
    dim as FB_CMPSTMTSTK ptr stk = any

	function = FALSE

	'' DO
	lexSkipToken( )

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
		lexSkipToken( )

		'' Expression
		expr = cExpression( )
		if( expr = NULL ) then
			if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
				exit function
			else
				'' error recovery: fake a node
				expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
			end if
		end if

		'' branch
		if( iswhile ) then
			isinverse = FALSE
		else
			isinverse = TRUE
		end if

		expr = astUpdComp2Branch( expr, el, isinverse )
		if( expr = NULL ) then
			if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
				exit function
			else
				'' error recovery: fake a node
				expr = astNewNOP( )
			end if
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

	function = TRUE

end function

'':::::
'' DoStmtEnd     =   LOOP ((WHILE | UNTIL) Expression)? .
''
function cDoStmtEnd as integer
    dim as ASTNODE ptr expr = any
	dim as integer iswhile = any, isuntil = any, isinverse = any
	dim as FB_CMPSTMTSTK ptr stk = any

	function = FALSE

	stk = cCompStmtGetTOS( FB_TK_DO )
	if( stk = NULL ) then
		exit function
	end if

	'' LOOP
	lexSkipToken( )

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
		if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
			exit function
		end if
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
		lexSkipToken( )

		'' Expression
		expr = cExpression( )
		if( expr = NULL ) then
			if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
				exit function
			else
				'' error recovery: fake a node
				expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
			end if
		end if

		'' branch
		if( iswhile ) then
			isinverse = TRUE
		else
			isinverse = FALSE
		end if

		expr = astUpdComp2Branch( expr, stk->do.inilabel, isinverse )
		if( expr = NULL ) then
			if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
				exit function
			else
				'' error recovery: fake a node
				expr = astNewNOP( )
			end if
		end if

		astAdd( expr )

	'' top check..
	else

		astAdd( astNewBRANCH( AST_OP_JMP, stk->do.inilabel ) )
	end if

    '' end label (loop exit)
    astAdd( astNewLABEL( stk->do.endlabel ) )

	'' pop from stmt stack
	cCompStmtPop( stk )

	function = TRUE

end function
