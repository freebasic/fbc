'' quirk error statements (ERROR, ERR) parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "rtl.bi"
#include once "ast.bi"

'' ERROR Expression
function cErrorStmt() as integer
	function = FALSE

	'' ERROR
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' Expression
	dim as ASTNODE ptr expr
	hMatchExpressionEx(expr, FB_DATATYPE_INTEGER)

	rtlErrorThrow(expr, lexLineNum(), env.inf.name)

	function = TRUE
end function

'' ERR '=' Expression
function cErrSetStmt() as integer
	function = FALSE

	'' ERR
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' '='
	if( cAssignToken( ) = FALSE ) then
		errReport( FB_ERRMSG_EXPECTEDEQ )
	end if

	'' Expression
	dim as ASTNODE ptr expr
	hMatchExpressionEx(expr, FB_DATATYPE_INTEGER)

	rtlErrorSetnum(expr)

	function = TRUE
end function

'' ERR()
function cErrorFunct() as ASTNODE ptr
	'' ERR
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' ('(' ')')?
	if( hMatch( CHAR_LPRNT ) ) then
		'' ')'
		hMatchRPRNT( )
	end if

	function = rtlErrorGetNum( )
end function
