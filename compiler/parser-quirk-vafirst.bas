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
	if( proc->proc.mode <> FB_FUNCMODE_CDECL ) then
		exit function
	end if

	dim as FBSYMBOL ptr param = symbGetProcTailParam( proc )
	if( param = NULL ) then
		exit function
	end if
	if( symbGetParamMode( param ) <> FB_PARAMMODE_VARARG ) then
		exit function
	end if
	param = symbGetProcNextParam( proc, param )
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

	'' high-level IR? va_* not supported
	if( irGetOption( IR_OPT_HIGHLEVEL ) ) then
		errReport( FB_ERRMSG_STMTUNSUPPORTEDINGCC, TRUE )

		'' error recovery: fake an expr
		function = astNewCONSTi( 0 )
	else
		'' @param
		dim as ASTNODE ptr expr = astNewVAR( sym, 0, symbGetFullType( sym ), symbGetSubType( sym ) )
		expr = astNewADDROF( expr )

		'' Convert to ANY PTR, to hide that it's based on the last param...
		expr = astNewCONV( typeAddrOf( FB_DATATYPE_VOID ), NULL, expr )

		'' + FB_ROUNDLEN( paramlen( param ) )
		function = astNewBOP( AST_OP_ADD, expr, _
		                      astNewCONSTi( FB_ROUNDLEN( symbCalcParamLen( param->typ, param->subtype, param->param.mode ) ), _
		                                    FB_DATATYPE_UINT ) )
	end if
end function
