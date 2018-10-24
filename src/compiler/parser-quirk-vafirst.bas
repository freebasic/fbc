'' quirk varargs function (VA_FIRST) parsing
''
'' chng: sep/2004 written [v1ctor]
'' chng: oct/2018 added   [jeffm], cVALIST*

#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

private function hGetVarArgProcParam _
	( _
		byref proc as FBSYMBOL ptr, _
		byref vararg_param as FBSYMBOL ptr, _
		byref vararg_sym as FBSYMBOL ptr _
	) as integer

	function = FALSE

	if( fbIsModLevel( ) ) then
		exit function
	end if

	proc = parser.currproc
	if( symbGetProcMode( proc ) <> FB_FUNCMODE_CDECL ) then
		exit function
	end if

	vararg_param = symbGetProcTailParam( proc )
	if( vararg_param = NULL ) then
		exit function
	end if
	if( symbGetParamMode( vararg_param ) <> FB_PARAMMODE_VARARG ) then
		exit function
	end if
	vararg_param = vararg_param->prev
	if( vararg_param = NULL ) then
		exit function
	end if

	vararg_sym = symbGetParamVar( vararg_param )
	if( vararg_sym = NULL ) then
		exit function
	end if

	function = TRUE

end function


'':::::
''cVAFunct =     VA_FIRST ('(' ')')? .
''
function cVAFunct() as ASTNODE ptr
	function = FALSE

	dim as FBSYMBOL ptr vararg_proc = any, vararg_param = any, vararg_sym = any
	if( hGetVarArgProcParam( vararg_proc, vararg_param, vararg_sym ) = FALSE ) then
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
		var expr = astNewADDROF( astNewVAR( vararg_sym ) )

		'' Cast to ANY PTR to hide that it's based on the parameter
		expr = astNewCONV( typeAddrOf( FB_DATATYPE_VOID ), NULL, expr )

		'' + paramlen( param )
		function = astNewBOP( AST_OP_ADD, expr, astNewCONSTi( symbGetLen( vararg_param ), FB_DATATYPE_UINT ) )
	end if
end function


'':::::
''cVALISTFunct =     CVA_ARG ('(' ')')? .
''
function cVALISTFunct _
	( _
		byval tk as FB_TOKEN _
	) as ASTNODE ptr

	dim as ASTNODE ptr expr
	dim as integer dtype
	dim as FBSYMBOL ptr subtype

	function = NULL

	dim as FBSYMBOL ptr vararg_proc = any, vararg_param = any, vararg_sym = any
	if( hGetVarArgProcParam( vararg_proc, vararg_param, vararg_sym ) = FALSE ) then
		exit function
	end if

	assert( tk = FB_TK_CVA_ARG )

	'' CVA_ARG
	lexSkipToken( )

	'' '('
	if( hMatch( CHAR_LPRNT ) = FALSE ) then
		errReport( FB_ERRMSG_EXPECTEDLPRNT )
	end if

	expr = cExpression()

	'' ','
	if( lexGetToken( ) <> CHAR_COMMA ) then
		errReport( FB_ERRMSG_EXPECTEDCOMMA )
	else
		lexSkipToken( )
	end if

	if( cSymbolType( dtype, subtype ) = FALSE ) then
		return NULL
	end if

	'' ')'
	if( hMatch( CHAR_RPRNT ) = FALSE ) then
		errReport( FB_ERRMSG_EXPECTEDRPRNT )
	end if

	function = astNewMACRO( AST_OP_VA_ARG, expr, NULL, dtype, subtype )

end function


'':::::
''cVALISTStmt =      CVA_START ('(' expr ',' expr ')')?
''                 | CVA_END ('(' expr ')')?
''                 | CVA_COPY ('(' expr ',' expr ')')?
''
function cVALISTStmt _
	( _
		byval tk as FB_TOKEN _
	) as integer

	dim as ASTNODE ptr expr1, expr2
	dim as integer dtype
	dim as FBSYMBOL ptr sym, subtype

	function = FALSE

	dim as FBSYMBOL ptr vararg_proc = any, vararg_param = any, vararg_sym = any
	if( hGetVarArgProcParam( vararg_proc, vararg_param, vararg_sym ) = FALSE ) then
		exit function
	end if

	select case as const tk
	case FB_TK_CVA_START
		
		'' CVA_START
		lexSkipToken( )

		'' '('
		if( hMatch( CHAR_LPRNT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDLPRNT )
		end if

		expr1 = cExpression()

		'' ','
		if( lexGetToken( ) <> CHAR_COMMA ) then
			errReport( FB_ERRMSG_EXPECTEDCOMMA )
		else
			lexSkipToken( )
		end if

		expr2 = cExpression()

		'' ')'
		if( hMatch( CHAR_RPRNT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDRPRNT )
		end if

		astAdd( astNewMACRO( AST_OP_VA_START, expr1, expr2, FB_DATATYPE_INVALID, NULL ) )
		function = TRUE

	case FB_TK_CVA_END
		
		'' CVA_END
		lexSkipToken( )

		'' '('
		if( hMatch( CHAR_LPRNT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDLPRNT )
		end if

		expr1 = cExpression()
		expr2 = NULL

		'' ')'
		if( hMatch( CHAR_RPRNT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDRPRNT )
		end if

		astAdd( astNewMACRO( AST_OP_VA_END, expr1, expr2, FB_DATATYPE_INVALID, NULL ) )
		function = TRUE

	case FB_TK_CVA_COPY

		'' CVA_COPY
		lexSkipToken( )

		'' '('
		if( hMatch( CHAR_LPRNT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDLPRNT )
		end if

		expr1 = cExpression()

		'' ','
		if( lexGetToken( ) <> CHAR_COMMA ) then
			errReport( FB_ERRMSG_EXPECTEDCOMMA )
		else
			lexSkipToken( )
		end if

		expr2 = cExpression()

		'' ')'
		if( hMatch( CHAR_RPRNT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDRPRNT )
		end if

		astAdd( astNewMACRO( AST_OP_VA_COPY, expr1, expr2, FB_DATATYPE_INVALID, NULL ) )
		function = TRUE

	end select

end function
