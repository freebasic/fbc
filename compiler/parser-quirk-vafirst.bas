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
function cVAFunct( byref funcexpr as ASTNODE ptr ) as integer
    dim as ASTNODE ptr expr
    dim as FBSYMBOL ptr param, proc, sym

	function = FALSE

	if( fbIsModLevel( ) ) then
		exit function
	end if

	proc = parser.currproc

	if( proc->proc.mode <> FB_FUNCMODE_CDECL ) then
		exit function
	end if

	param = symbGetProcTailParam( proc )
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

	sym = symbGetParamVar( param )
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
		if( errReport( FB_ERRMSG_STMTUNSUPPORTEDINGCC, TRUE ) = FALSE ) then
			exit function
		end if

		'' error recovery: fake an expr
		funcexpr = astNewCONSTi( 0 )

	else
		'' @param
		expr = astNewVAR( sym, 0, symbGetFullType( sym ), NULL )
		expr = astNewADDROF( expr )

		'' + FB_ROUNDLEN( paramlen( param ) )
		funcexpr = astNewBOP( AST_OP_ADD, _
						  	  expr, _
						  	  astNewCONSTi( FB_ROUNDLEN( symbCalcParamLen( param->typ, _
                                                                           param->subtype, _
						  								  	               param->param.mode ) ), _
						  					FB_DATATYPE_UINT ) )
	end if

	function = TRUE

end function

