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

private function hUseGccValistBuiltins() as boolean

	'' backend  bits   builtin   ptr-expr
	'' -------  -----  --------  -------------------------------------
	'' gas      32     no        yes
	'' gas      64     n/a       n/a
	'' gcc      32     yes       only with "-z valist-is-ptr"
	'' gcc      64     yes       only with "-z valist-is-ptr" and on win32
	'' llvm     32     no        yes
	'' llvm     64     no        ???
	''
	'' "-z valist-is-ptr" overides the use of builtins on backend/bits
	'' that also support pointer expressions, and has no effect otherwise

	select case env.clopt.backend
	case FB_BACKEND_GCC
		if( env.clopt.target = FB_COMPTARGET_WIN32 ) then
			function = iif( fbGetOption( FB_COMPOPT_VALISTASPTR ), FALSE, TRUE )
		else
			function = TRUE
		end if

	case FB_BACKEND_GAS
		function = FALSE

	case FB_BACKEND_LLVM
		function = FALSE

	case else
		assert( FALSE )
		function = FALSE

	end select
	
end function

private function hSolveValistAsPtr _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

	'' cva_list? solve for the target	
	if( n->dtype = FB_DATATYPE_VA_LIST ) then
		n->dtype = typeAddrOf( FB_DATATYPE_VOID )
	end if

	function = n

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
		function = astNewBOP( AST_OP_ADD, expr, astNewCONSTi( symbGetLen( vararg_param ), FB_DATATYPE_UINT ),,AST_OPOPT_NOCOERCION )
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

	assert( tk = FB_TK_CVA_ARG )

	'' CVA_ARG
	lexSkipToken( )

	'' '('
	if( hMatch( CHAR_LPRNT ) = FALSE ) then
		errReport( FB_ERRMSG_EXPECTEDLPRNT )
	end if

	expr = cExpression()

	'' expr must be a cva_list data type
	if( expr = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
		'' error recovery: skip until ')' and fake a node
		hSkipUntil( CHAR_RPRNT, TRUE )
		return astNewCONSTi( 0 )
/' 
	'' !!! TODO !!! check data type
	elseif( astGetDataType( expr ) <> FB_DATATYPE_VA_LIST ) then
		errReport( FB_ERRMSG_INVALIDDATATYPES )
		'' error recovery: skip until ')' and fake a node
		hSkipUntil( CHAR_RPRNT, TRUE )
		astDelTree( expr )
		return astNewCONSTi( 0 )
'/
	end if

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

	if( hUseGccValistBuiltins() ) then
		'' delegate to gcc backend to solve "result = __builtin_va_arg( ap, type )"
		function = astNewMACRO( AST_OP_VA_ARG, expr, NULL, dtype, subtype )

	else
		'' pointer expression: modify expr variable & return value of expr variable before modification

		'' size of parameter on the stack depends on stack alignment
		dim lgt as integer = (symbCalcLen( dtype, subtype ) + env.pointersize - 1 and -env.pointersize)

		'' cptr( any ptr, expr ) + lgt	
		var expr1 = astNewBOP( AST_OP_ADD, astNewCONV( typeAddrOf( FB_DATATYPE_VOID ), NULL, hSolveValistAsPtr( astNewVAR( astGetSymbol( expr ) ) ) ), astNewCONSTi(lgt, FB_DATATYPE_UINT ) )
		
		'' cptr( any ptr, expr ) - lgt
		var expr2 = astNewBOP( AST_OP_SUB, astNewCONV( typeAddrOf( FB_DATATYPE_VOID ), NULL, hSolveValistAsPtr( astNewVAR( astGetSymbol( expr ) ) ) ), astNewCONSTi(lgt, FB_DATATYPE_UINT ) )

		'' return ( expr += lgt: *cptr(dtype ptr, expr - lgt) )
		function = astNewLink( astNewASSIGN( astNewCONV( typeAddrOf( FB_DATATYPE_VOID ), NULL, hSolveValistAsPtr( astNewVAR( astGetSymbol( expr ) ) ) ), expr1 ), astNewDEREF( expr2, dtype, subtype ), FALSE )

	end if

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

	select case as const tk
	case FB_TK_CVA_START

		dim as FBSYMBOL ptr vararg_proc = any, vararg_param = any, vararg_sym = any
		if( hGetVarArgProcParam( vararg_proc, vararg_param, vararg_sym ) = FALSE ) then
			exit function
		end if

		'' CVA_START
		lexSkipToken( )

		'' '('
		if( hMatch( CHAR_LPRNT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDLPRNT )
		end if

		'' list
		expr1 = cExpression()

		if( expr1 = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
			'' error recovery: skip until ')'
			hSkipUntil( CHAR_RPRNT, TRUE )
			return FALSE
/'
		'' !!! TODO !!! check data type
		elseif( astGetDataType( expr1 ) <> FB_DATATYPE_VA_LIST ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )
			'' error recovery: skip until ')'
			hSkipUntil( CHAR_RPRNT, TRUE )
			astDelTree( expr1 )
			return FALSE
'/
		end if

		'' ','
		if( lexGetToken( ) <> CHAR_COMMA ) then
			errReport( FB_ERRMSG_EXPECTEDCOMMA )
		else
			lexSkipToken( )
		end if

		'' last_arg
		expr2 = cExpression()

		if( expr2 = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDEXPRESSION )

		

/'
		'' !!! TODO !!! check data type

		This kind of check won't work for strings

		'' variable name must be last argument before the '...'
		elseif( astGetSymbol( expr2 ) <> vararg_sym ) then
			errReport( FB_ERRMSG_SYNTAXERROR )
'/

		end if

		'' ')'
		if( hMatch( CHAR_RPRNT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDRPRNT )
		end if

		

		if( hUseGccValistBuiltins() ) then
			'' delegate to gcc backend to solve "__builtin_va_start( ap, param )"
			astAdd( astNewMACRO( AST_OP_VA_START, expr1, expr2, FB_DATATYPE_INVALID, NULL ) )

		else
			'' @param
			var expr = astNewADDROF( astNewVAR( vararg_sym ) )

			'' Cast to ANY PTR to hide that it's based on the parameter
			expr = astNewCONV( typeAddrOf( FB_DATATYPE_VOID ), NULL, expr )

			'' + paramlen( param )
			expr = astNewBOP( AST_OP_ADD, expr, astNewCONSTi( symbGetLen( vararg_param ), FB_DATATYPE_UINT ) )

			'' cptr( any ptr, list ) = first_vararg
			astAdd( astNewASSIGN( hSolveValistAsPtr( expr1 ), expr ) )

		end if
		function = TRUE

	case FB_TK_CVA_END
		
		'' CVA_END
		lexSkipToken( )

		'' '('
		if( hMatch( CHAR_LPRNT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDLPRNT )
		end if

		expr1 = cExpression()

		'' !!! TODO !!! check data type

		expr2 = NULL

		'' ')'
		if( hMatch( CHAR_RPRNT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDRPRNT )
		end if

		if( hUseGccValistBuiltins() ) then
			'' delegate to gcc backend to solve "__builtin_va_end( ap )"
			astAdd( astNewMACRO( AST_OP_VA_END, expr1, expr2, FB_DATATYPE_INVALID, NULL ) )

		else
			'' pointer expression: no-op

		end if
		function = TRUE

	case FB_TK_CVA_COPY

		'' CVA_COPY
		lexSkipToken( )

		'' '('
		if( hMatch( CHAR_LPRNT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDLPRNT )
		end if

		expr1 = cExpression()

		'' !!! TODO !!! check data type

		'' ','
		if( lexGetToken( ) <> CHAR_COMMA ) then
			errReport( FB_ERRMSG_EXPECTEDCOMMA )
		else
			lexSkipToken( )
		end if

		expr2 = cExpression()

		'' !!! TODO !!! check data type

		'' ')'
		if( hMatch( CHAR_RPRNT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDRPRNT )
		end if

		if( hUseGccValistBuiltins() ) then
			'' delegate to gcc backend to solve "__builtin_va_copy( dst, src )"
			astAdd( astNewMACRO( AST_OP_VA_COPY, expr1, expr2, FB_DATATYPE_INVALID, NULL ) )

		else
			'' pointer expression: assignment
			astAdd( astNewASSIGN( hSolveValistAsPtr( expr1 ), hSolveValistAsPtr( expr2 ) ) )

		end if
		function = TRUE

	end select

end function
