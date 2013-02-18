'' quirk varargs function (VA_FIRST) parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

'':::::
''cVAFunct =     VA_FIRST ('(' ')')? .
''
function cVAFunct() as ASTNODE ptr
	function = FALSE

	if( fbIsModLevel( ) ) then
		exit function
	end if

	dim as FBSYMBOL ptr proc = parser.currproc
	if( symbGetProcMode( proc ) <> FB_FUNCMODE_CDECL ) then
		exit function
	end if

	dim as FBSYMBOL ptr param = symbGetProcTailParam( proc )
	if( param = NULL ) then
		exit function
	end if
	if( symbGetParamMode( param ) <> FB_PARAMMODE_VARARG ) then
		exit function
	end if
	param = param->prev
	if( param = NULL ) then
		exit function
	end if

	dim as FBSYMBOL ptr sym = symbGetParamVar( param )
	if( sym = NULL ) then
		exit function
	end if

	'' VA_FIRST
	lexSkipToken( )

	'' ('(' ')')?
	if( hMatch( CHAR_LPRNT ) ) then
		hMatchRPRNT( )
	end if

	'' C backend? va_* not supported
	if( env.clopt.backend = FB_BACKEND_GCC ) then
		errReport( FB_ERRMSG_STMTUNSUPPORTEDINGCC, TRUE )

		'' error recovery: fake an expr
		function = astNewCONSTi( 0 )
	else
		'' @param
		var expr = astNewADDROF( astNewVAR( sym ) )

		'' Cast to ANY PTR to hide that it's based on the parameter
		expr = astNewCONV( typeAddrOf( FB_DATATYPE_VOID ), NULL, expr )

		'' + paramlen( param )
		function = astNewBOP( AST_OP_ADD, expr, astNewCONSTi( symbGetLen( param ), FB_DATATYPE_UINT ) )
	end if
end function
