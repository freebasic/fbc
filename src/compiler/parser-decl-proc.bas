'' proc (SUB or FUNCTION) declarations
''
'' chng: sep/2004 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

'' ProcDecl  =  DECLARE SUB|FUNCTION|OPERATOR ProcHeader .
function cProcDecl( ) as integer
	dim as integer tk = any

	function = FALSE

	if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_DECL ) = FALSE ) then
		hSkipStmt( )
		exit function
	end if

	'' DECLARE
	lexSkipToken( )

	'' SUB|FUNCTION|OPERATOR
	tk = lexGetToken( )
	select case( tk )
	case FB_TK_SUB, FB_TK_FUNCTION, FB_TK_OPERATOR
		lexSkipToken( )

		'' ProcHeader
		cProcHeader( 0, FALSE, FB_PROCOPT_ISPROTO, tk )

	case else
		errReport( FB_ERRMSG_SYNTAXERROR )
		'' error recovery: skip stmt
		hSkipStmt( )
	end select

	function = TRUE
end function
