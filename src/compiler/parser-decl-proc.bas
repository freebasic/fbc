'' proc (SUB or FUNCTION) declarations
''
'' chng: sep/2004 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

'' ProcDecl  =  DECLARE SUB|FUNCTION|OPERATOR ProcHeader .
sub cProcDecl( )
	dim as integer tk = any

	if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_DECL ) = FALSE ) then
		hSkipStmt( )
		exit sub
	end if

	'' DECLARE
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' SUB|FUNCTION|OPERATOR
	tk = lexGetToken( )
	select case( tk )
	case FB_TK_SUB, FB_TK_FUNCTION, FB_TK_OPERATOR
		lexSkipToken( LEXCHECK_POST_SUFFIX )

		'' ProcHeader
		cProcHeader( 0, 0, FALSE, FB_PROCOPT_ISPROTO, tk )

	case else
		errReport( FB_ERRMSG_SYNTAXERROR )
		'' error recovery: skip stmt
		hSkipStmt( )
	end select
end sub
