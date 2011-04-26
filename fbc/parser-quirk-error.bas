'' quirk error statements (ERROR, ERR) parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "rtl.bi"
#include once "ast.bi"

'':::::
''ErrorStmt 	=	ERROR Expression
''				|   ERR '=' Expression .
''
function cErrorStmt _
	( _
		byval tk as FB_TOKEN _
	) as integer

	dim as ASTNODE ptr expr

	function = FALSE

	select case tk

	'' ERROR Expression
	case FB_TK_ERROR
		lexSkipToken( )

		'' Expression
		hMatchExpressionEx( expr, FB_DATATYPE_INTEGER )

		rtlErrorThrow( expr, lexLineNum( ), env.inf.name )

		function = TRUE

	'' ERR '=' Expression
	case FB_TK_ERR
		lexSkipToken( )

		'' '='
		if( hMatch( FB_TK_ASSIGN ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDEQ ) = FALSE ) then
				exit function
			end if
		end if

		'' Expression
		hMatchExpressionEx( expr, FB_DATATYPE_INTEGER )

		rtlErrorSetnum( expr )

		function = TRUE

	end select

end function

'':::::
''cErrorFunct =   ERR .
''
function cErrorFunct _
	( _
		byref funcexpr as ASTNODE ptr _
	) as integer

	function = FALSE

	'' ERR
	lexSkipToken( )

	'' ('(' ')')?
	if( hMatch( CHAR_LPRNT ) ) then
		'' ')'
		hMatchRPRNT( )
	end if

	funcexpr = rtlErrorGetNum( )

	function = TRUE

end function

