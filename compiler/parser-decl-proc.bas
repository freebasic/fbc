'' proc (SUB or FUNCTION) declarations
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

'':::::
''ProcDecl        =   DECLARE ((SUB | FUNCTION) ProcHeader | OPERATOR OperatorHeader ) .
''
function cProcDecl as integer
    dim as integer is_nested = any

    function = FALSE

    if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_DECL ) = FALSE ) then
    	exit function
    end if

    '' DECLARE
    lexSkipToken( )

	select case as const lexGetToken( )
	case FB_TK_SUB
		lexSkipToken( )
		function = cProcHeader( 0, _
								is_nested, _
								FB_PROCOPT_ISPROTO or FB_PROCOPT_ISSUB ) <> NULL

	case FB_TK_FUNCTION
		lexSkipToken( )
		function = cProcHeader( 0, is_nested, FB_PROCOPT_ISPROTO ) <> NULL

	case FB_TK_OPERATOR
		lexSkipToken( )
		function = cOperatorHeader( 0, is_nested, FB_PROCOPT_ISPROTO ) <> NULL

	case else
		errReport( FB_ERRMSG_SYNTAXERROR )
		'' error recovery: try to parse the prototype
		function = cProcHeader( 0, is_nested, FB_PROCOPT_ISPROTO ) <> NULL
	end select

end function
