'' WHILE..WEND compound statement parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

'':::::
''WhileStmtBegin  =   WHILE Expression .
''
sub cWhileStmtBegin()
    dim as ASTNODE ptr expr = any
    dim as FBSYMBOL ptr il = any, el = any
    dim as FB_CMPSTMTSTK ptr stk = any

	'' WHILE
	lexSkipToken( )

	'' add ini and end labels
	il = symbAddLabel( NULL )
	el = symbAddLabel( NULL, FB_SYMBOPT_NONE )

	'' emit ini label
	astAdd( astNewLABEL( il ) )

	'' Expression
	expr = cExpression( )
	if( expr = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
		'' error recovery: fake an expr
		expr = astNewCONSTi( 0 )
	end if

	'' branch
	expr = astBuildBranch( expr, el, FALSE )
	if( expr = NULL ) then
		errReport( FB_ERRMSG_INVALIDDATATYPES )
	else
		astAdd( expr )
	end if

	'' push to stmt stack
	stk = cCompStmtPush( FB_TK_WHILE )
	stk->scopenode = astScopeBegin( )
	stk->while.cmplabel = il
	stk->while.endlabel = el
end sub

'':::::
''WhileStmtEnd  =   WEND
''
function cWhileStmtEnd as integer
	dim as FB_CMPSTMTSTK ptr stk = any

	function = FALSE

	stk = cCompStmtGetTOS( FB_TK_WHILE )
	if( stk = NULL ) then
		exit function
	end if

	'' WEND
	lexSkipToken( )

	if( stk->scopenode <> NULL ) then
		astScopeEnd( stk->scopenode )
	end if

    astAdd( astNewBRANCH( AST_OP_JMP, stk->while.cmplabel ) )

    '' end label (loop exit)
    astAdd( astNewLABEL( stk->while.endlabel ) )

	'' pop from stmt stack
	cCompStmtPop( stk )

	function = TRUE

end function
