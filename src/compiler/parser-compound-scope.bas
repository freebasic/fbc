'' SCOPE..END SCOPE compound statement parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

'':::::
''ScopeStmtBegin  =   SCOPE .
''
function cScopeStmtBegin as integer
    dim as ASTNODE ptr n = any
    dim as FB_CMPSTMTSTK ptr stk = any

	function = FALSE

    if( fbLangOptIsSet( FB_LANG_OPT_SCOPE ) = FALSE ) then
    	errReportNotAllowed( FB_LANG_OPT_SCOPE )
    	'' error recovery: skip the whole compound stmt
    	hSkipCompound( FB_TK_SCOPE )
    	exit function
    end if

	'' SCOPE
	lexSkipToken( )

	n = astScopeBegin( )
	if( n = NULL ) then
		errReport( FB_ERRMSG_RECLEVELTOODEEP )
	end if

	''
	stk = cCompStmtPush( FB_TK_SCOPE )
	stk->scopenode = n

	'' deprecated quirk: implicit vars inside implicit scope blocks
	'' must be allocated in the function scope
	stk->scp.lastis_scope = fbGetIsScope( )
	fbSetIsScope( TRUE )

	function = TRUE

end function

'':::::
''ScopeStmtEnd  =     END SCOPE .
''
function cScopeStmtEnd as integer
	dim as FB_CMPSTMTSTK ptr stk = any

	function = FALSE

	stk = cCompStmtGetTOS( FB_TK_SCOPE )
	if( stk = NULL ) then
		exit function
	end if

	'' END SCOPE
	lexSkipToken( )
	lexSkipToken( )

	fbSetIsScope( stk->scp.lastis_scope )

	''
	if( stk->scopenode <> NULL ) then
		astScopeEnd( stk->scopenode )
	end if

	'' pop from stmt stack
	cCompStmtPop( stk )

	function = TRUE

end function
