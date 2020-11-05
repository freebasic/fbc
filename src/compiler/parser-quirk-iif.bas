'' quirk conditional statement (IIF) parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

'' cIIFFunct  =  IIF '(' condition-expr ',' true-expr ',' false-expr ')' .
function cIIFFunct() as ASTNODE ptr
	dim as ASTNODE ptr expr = any, truexpr = any, falsexpr = any
	dim as integer truecookie = any, falsecookie = any

	function = NULL

	'' The condition expression is always executed,
	'' the true/false expressions only conditionally though.

	'' IIF
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' '('
	hMatchLPRNT( )

	'' condition-expr
	hMatchExpressionEx( expr, FB_DATATYPE_INTEGER )

	'' ','
	hMatchCOMMA( )

	'' true-expr
	astDtorListScopeBegin( )
	hMatchExpressionEx( truexpr, FB_DATATYPE_INTEGER )
	truecookie = astDtorListScopeEnd( )

	'' ','
	hMatchCOMMA( )

	'' false-expr
	astDtorListScopeBegin( )
	hMatchExpressionEx( falsexpr, astGetDataType( truexpr ) )
	falsecookie = astDtorListScopeEnd( )

	'' ')'
	hMatchRPRNT( )

	expr = astNewIIF( expr, truexpr, truecookie, falsexpr, falsecookie )
	if( expr = NULL ) then
		errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE )
		'' error recovery: fake an expr
		expr = astNewCONSTi( 0 )
	end if

	function = expr
end function
