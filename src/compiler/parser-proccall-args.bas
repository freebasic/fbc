'' function call's arguments list (called "param" by mistake)
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "list.bi"
#include once "parser.bi"
#include once "ast.bi"

'':::::
sub parserProcCallInit( )

	listInit( @parser.ovlarglist, 32*4, len( FB_CALL_ARG ), LIST_FLAGS_NOCLEAR )

end sub

sub parserProcCallEnd( )

	listEnd( @parser.ovlarglist )

end sub

'':::::
''ProcArg        =   BYVAL? (ID(('(' ')')? | Expression) .
''
private function hProcArg _
	( _
		byval proc as FBSYMBOL ptr, _
		byval param as FBSYMBOL ptr, _
		byval argnum as integer, _
		byref expr as ASTNODE ptr, _
		byref amode as integer, _
		byref have_eq_outside_parens as integer, _
		byval options as FB_PARSEROPT _
	) as integer

	dim as integer pmode = any, old_dtype = any
	dim as FBSYMBOL ptr oldsym = any

	function = FALSE

	pmode = symbGetParamMode( param )
	amode = INVALID
	expr = NULL

	'' BYVAL?
	if( lexGetToken( ) = FB_TK_BYVAL ) then
		lexSkipToken( LEXCHECK_POST_SUFFIX )
		amode = FB_PARAMMODE_BYVAL
	end if

	oldsym    = parser.ctxsym
	old_dtype = parser.ctx_dtype
	parser.ctxsym    = symbGetSubType( param )
	parser.ctx_dtype = symbGetType( param )
	parser.have_eq_outside_parens = FALSE

	'' Expression
	expr = cExpression( )

	have_eq_outside_parens or= parser.have_eq_outside_parens

	'' disable optional opening '{' after first parameter
	fbSetPrntOptional( FALSE )

	if( expr = NULL ) then
		if( (options and FB_PARSEROPT_ISFUNC) <> 0 ) then
			expr = NULL
		else
			'' check for BYVAL if it's the first param, due the optional ()'s
			if( (argnum = 0) and (amode = INVALID) ) then
				'' BYVAL?
				if( hMatch( FB_TK_BYVAL, LEXCHECK_POST_SUFFIX ) ) then
					amode = FB_PARAMMODE_BYVAL
					expr = cExpression( )
				end if
			end if
		end if
	end if

	parser.ctxsym    = oldsym
	parser.ctx_dtype = old_dtype

	if( expr = NULL ) then
		'' check if argument is optional
		if( symbParamIsOptional( param ) = FALSE ) then
			if( pmode = FB_PARAMMODE_VARARG ) then
				exit function
			end if
			errReport( FB_ERRMSG_ARGCNTMISMATCH )
			'' error recovery: fake an expr
			expr = astNewCONSTz( symbGetType( param ), symbGetSubType( param ) )
		end if
	else
		'' '('')'?
		if( pmode = FB_PARAMMODE_BYDESC ) then
			if( lexGetToken( ) = CHAR_LPRNT ) then
				if( lexGetLookAhead( 1 ) = CHAR_RPRNT ) then
					if( amode <> INVALID ) then
						errReport( FB_ERRMSG_PARAMTYPEMISMATCH )
					end if
					lexSkipToken( )
					lexSkipToken( )
					amode = FB_PARAMMODE_BYDESC
				end if
			end if
		end if
	end if

	''
	if( amode <> INVALID ) then
		if( amode <> pmode ) then
			if( pmode <> FB_PARAMMODE_VARARG ) then
				'' allow BYVAL params passed to BYREF/BYDESC args
				'' (to pass NULL to pointers and so on)
				if( amode <> FB_PARAMMODE_BYVAL ) then
					if( amode <> pmode ) then
						errReport( FB_ERRMSG_PARAMTYPEMISMATCH )
						'' error recovery: discard arg mode
						amode = pmode
					end if
				end if
			end if
		end if
	end if

	function = TRUE

end function

'':::::
''ProcParam         =   BYVAL? (ID(('(' ')')? | Expression) .
''
private sub hOvlProcArg _
	( _
		byval argnum as integer, _
		byval arg as FB_CALL_ARG ptr, _
		byref have_eq_outside_parens as integer, _
		byval options as FB_PARSEROPT _
	)

	dim as FBSYMBOL ptr oldsym = any
	dim as integer old_dtype = any

	arg->expr = NULL
	arg->mode = INVALID

	'' BYVAL?
	if( hMatch( FB_TK_BYVAL, LEXCHECK_POST_SUFFIX ) ) then
		arg->mode = FB_PARAMMODE_BYVAL
	end if

	oldsym    = parser.ctxsym
	old_dtype = parser.ctx_dtype
	parser.ctxsym    = NULL
	parser.ctx_dtype = FB_DATATYPE_INVALID
	parser.have_eq_outside_parens = FALSE

	'' Expression
	arg->expr = cExpression( )
	if( arg->expr = NULL ) then
		'' function? assume as optional..
		if( (options and FB_PARSEROPT_ISFUNC) <> 0 ) then
			arg->expr = NULL
		else
			'' check for BYVAL if it's the first param, due the optional ()'s
			if( (argnum = 0) and (arg->mode = INVALID) ) then
				'' BYVAL?
				if( hMatch( FB_TK_BYVAL, LEXCHECK_POST_SUFFIX ) ) then
					arg->mode = FB_PARAMMODE_BYVAL
					arg->expr = cExpression( )
				end if
			end if
		end if
	end if

	parser.ctxsym    = oldsym
	parser.ctx_dtype = old_dtype
	have_eq_outside_parens or= parser.have_eq_outside_parens

	'' not optional?
	if( arg->expr <> NULL ) then
		'' '('')'?
		if( lexGetToken( ) = CHAR_LPRNT ) then
			if( lexGetLookAhead( 1 ) = CHAR_RPRNT ) then
				if( arg->mode <> INVALID ) then
					errReport( FB_ERRMSG_PARAMTYPEMISMATCH )
				end if
				lexSkipToken( )
				lexSkipToken( )
				arg->mode = FB_PARAMMODE_BYDESC
			end if
		end if
	end if
end sub

private sub hMaybeWarnAboutEqOutsideParens _
	( _
		byval args as integer, _
		byval have_eq_outside_parens as integer, _
		byval proc as FBSYMBOL ptr _
	)

	dim as integer warn = any

	'' If there was just one argument, with '=' outside parentheses, in a
	'' call to a BYREF function like <f (1) = 2>, show a warning -- it could
	'' easily be misinterpreted as assignment to the BYREF function result.
	''
	'' Also, the warning about this syntax problem should be shown in calls
	'' to overloaded functions, if any of the overloads is a BYREF function,
	'' because the exact overload used depends more on semantics than on
	'' syntax.
	''    f( a ) = b    i.e.    f( (a) = b )
	'' might be a call to BYVAL or BYREF function depending on 'a'
	'' could resolve to a different overload than
	''    (f( a )) = b

	warn = symbIsReturnByRef( proc )

	if( warn = FALSE ) then
		'' Also check other overloads, if any (for this to work,
		'' the passed proc must be the overload head proc)
		if( symbGetProcIsOverloaded( proc ) ) then
			do
				proc = symbGetProcOvlNext( proc )
				if( proc = NULL ) then
					exit do
				end if

				warn = symbIsReturnByRef( proc )
			loop until( warn )
		end if
	end if

	warn and= (args = 1)
	warn and= have_eq_outside_parens

	if( warn ) then
		errReportWarn( FB_WARNINGMSG_BYREFEQAFTERPARENS )
	end if

end sub

private function hGetVtableLookupIfNeeded _
	( _
		byval proc as FBSYMBOL ptr, _
		byval thisexpr as ASTNODE ptr, _
		byval options as FB_PARSEROPT _
	) as ASTNODE ptr

	function = NULL

	'' Explicit BASE.* access?
	if( options and FB_PARSEROPT_EXPLICITBASE ) then
		'' Disallow calling ABSTRACTs directly this way
		if( symbIsAbstract( proc ) ) then
			errReport( FB_ERRMSG_CALLTOABSTRACT )
		end if
	else
		'' Do vtable lookup (function pointer access to be used
		'' by the CALL) if it's a VIRTUAL.
		function = astBuildVtableLookup( proc, thisexpr )
	end if

end function

'':::::
''ProcArgList     =    ProcArg (DECL_SEPARATOR ProcArg)* .
''
private function hOvlProcArgList _
	( _
		byval base_parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr, _
		byval arg_list as FB_CALL_ARG_LIST ptr, _
		byval options as FB_PARSEROPT _
	) as ASTNODE ptr

	dim as integer i = any, params = any, args = any, have_eq_outside_parens = any
	dim as ASTNODE ptr procexpr = any
	dim as FBSYMBOL ptr param = any, ovlproc = any
	dim as FB_CALL_ARG ptr arg = any, nxt = any
	dim as FB_ERRMSG err_num = any

	function = NULL
	have_eq_outside_parens = FALSE

	params = symGetProcOvlMaxParams( proc )

	args = arg_list->args
	if( (options and FB_PARSEROPT_HASINSTPTR) <> 0 ) then
		args -= 1
	end if

	if( (options and FB_PARSEROPT_OPTONLY) = 0 ) then
		dim as integer init_args = args

		do
			'' count mismatch?
			if( args > params ) then
				errReport( FB_ERRMSG_ARGCNTMISMATCH )
				'' error recovery: skip until next stmt or ')'
				if( (options and FB_PARSEROPT_ISFUNC) <> 0 ) then
					hSkipUntil( CHAR_RPRNT )
				else
					hSkipStmt( )
				end if

				args -= 1
				exit do
			end if

			'' alloc a new arg
			arg = symbAllocOvlCallArg( @parser.ovlarglist, arg_list, FALSE )

			hOvlProcArg( args - init_args, arg, have_eq_outside_parens, options )

			'' ','?
			if( lexGetToken( ) <> CHAR_COMMA ) then
				'' only count this arg if it isn't optional
				if( arg->expr <> NULL ) then
					args += 1
				end if

				exit do
			end if

			lexSkipToken( )

			'' next
			args += 1
		loop
	end if

	'' (checking the first overload, the overload head proc)
	hMaybeWarnAboutEqOutsideParens( args, have_eq_outside_parens, proc )

	'' try finding the closest overloaded proc (don't pass the instance ptr, if any)
	dim as FB_SYMBFINDOPT find_options = FB_SYMBFINDOPT_NONE
	if( symbIsProperty( proc ) ) then
		if( (options and FB_PARSEROPT_ISPROPGET) <> 0 ) then
			find_options = FB_SYMBFINDOPT_PROPGET
		end if
	end if

	ovlproc = symbFindClosestOvlProc( proc, _
	                                  args, _
	                                  iif( (options and FB_PARSEROPT_HASINSTPTR) <> 0, _
	                                       arg_list->head->next, _
	                                       arg_list->head ), _
	                                  @err_num, _
	                                  find_options )

	if( ovlproc = NULL ) then
		symbFreeOvlCallArgs( @parser.ovlarglist, arg_list )

		if( err_num = FB_ERRMSG_OK ) then
			err_num = FB_ERRMSG_NOMATCHINGPROC
		end if

		errReportParam( proc, 0, NULL, err_num )
		'' error recovery: fake an expr
		return astBuildFakeCall( proc )
	end if

	proc = ovlproc

	'' Check visibility of the procedure (to be called)
	if( symbCheckAccess( proc ) = FALSE ) then
		errReportEx( iif( symbIsConstructor( proc ), _
		                  FB_ERRMSG_NOACCESSTOCTOR, _
		                  FB_ERRMSG_ILLEGALMEMBERACCESS ), _
		             symbGetFullProcName( proc ) )
		'' error recovery: fake an expr
		return astBuildFakeCall( proc )
	end if

	'' method?
	if( symbIsMethod( proc ) ) then
		'' calling a method without the instance ptr?
		if( (options and FB_PARSEROPT_HASINSTPTR) = 0 ) then
			'' is this really a static access or just a method call from
			'' another method in the same class?
			if( (base_parent <> NULL) or (symbIsMethod( parser.currproc ) = FALSE) ) then
				errReport( FB_ERRMSG_MEMBERISNTSTATIC, TRUE )
				'' error recovery: fake an expr
				return astBuildFakeCall( proc )
			end if

			'' pass the instance ptr of the current method
			arg = symbAllocOvlCallArg( @parser.ovlarglist, arg_list, TRUE )
			arg->expr = astBuildVarField( symbGetParamVar( symbGetProcHeadParam( parser.currproc ) ) )
			arg->mode = INVALID
		end if

		'' re-add the instance ptr
		args += 1

		procexpr = hGetVtableLookupIfNeeded( proc, arg_list->head->expr, options )
	else
		'' remove the instance ptr
		if( (options and FB_PARSEROPT_HASINSTPTR) <> 0 ) then
			arg = arg_list->head
			arg_list->head = arg->next
			astDelTree( arg->expr )
			symbFreeOvlCallArg( @parser.ovlarglist, arg )
		end if
		procexpr = NULL
	end if

	procexpr = astNewCALL( proc, procexpr )

	'' add to tree
	param = symbGetProcHeadParam( proc )
	arg = arg_list->head
	for i = 0 to args-1
		nxt = arg->next

		if( astNewARG( procexpr, arg->expr, , arg->mode ) = NULL ) then
			errReport( FB_ERRMSG_PARAMTYPEMISMATCH )
			'' error recovery: fake an expr (don't try to fake an arg,
			'' different modes and param types like "as any" would break AST)
			astDelTree( procexpr )
			return astBuildFakeCall( proc )
		end if

		symbFreeOvlCallArg( @parser.ovlarglist, arg )

		'' next
		param = param->next
		arg = nxt
	next

	'' add the end-of-list optional args, if any
	params = symbGetProcParams( proc )
	do while( args < params )
		astNewARG( procexpr, NULL )

		'' next
		args += 1
		param = param->next
	loop

	function = procexpr
end function

'':::::
''ProcArgList     =    ProcArg (DECL_SEPARATOR ProcArg)* .
''
'' This function always returns a CALL, even for error recovery - so callers
'' don't have to check before passing it to astNewCALLCTOR() etc.
''
function cProcArgList _
	( _
		byval base_parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr, _
		byval ptrexpr as ASTNODE ptr, _
		byval arg_list as FB_CALL_ARG_LIST ptr, _
		byval options as FB_PARSEROPT _
	) as ASTNODE ptr

	dim as integer args = any, params = any, mode = any, have_eq_outside_parens = any
	dim as FBSYMBOL ptr param = any
	dim as ASTNODE ptr procexpr = any, expr = any
	dim as FB_CALL_ARG ptr arg = any

	'' overloaded?
	if( symbGetProcIsOverloaded( proc ) ) then
		'' only if there's more than one overloaded function
		if( symbGetProcOvlNext( proc ) <> NULL ) then
			return hOvlProcArgList( base_parent, proc, arg_list, options )
		end if
	end if

	function = NULL
	have_eq_outside_parens = FALSE

	'' Check visibility of the procedure (to be called)
	if( symbCheckAccess( proc ) = FALSE ) then
		errReportEx( iif( symbIsConstructor( proc ), _
		                  FB_ERRMSG_NOACCESSTOCTOR, _
		                  FB_ERRMSG_ILLEGALMEMBERACCESS ), _
		             symbGetFullProcName( proc ) )
		'' error recovery: fake an expr
		return astBuildFakeCall( proc )
	end if

	'' method?
	if( symbIsMethod( proc ) ) then
		'' calling a method without the instance ptr?
		if( (options and FB_PARSEROPT_HASINSTPTR) = 0 ) then
			'' is this really a static access or just a method call from
			'' another method in the same class?
			if( (base_parent <> NULL) or (symbIsMethod( parser.currproc ) = FALSE) ) then
				errReport( FB_ERRMSG_MEMBERISNTSTATIC, TRUE )
				'' error recovery: fake an expr
				return astBuildFakeCall( proc )
			end if

			'' pass the instance ptr of the current method
			arg = symbAllocOvlCallArg( @parser.ovlarglist, arg_list, TRUE )
			arg->expr = astBuildVarField( symbGetParamVar( symbGetProcHeadParam( parser.currproc ) ) )
			arg->mode = INVALID
		end if

		'' Assuming there is no existing function pointer access,
		'' since we cannot CALL on two function pointer expressions...
		'' (i.e. no virtual method pointers for now)
		assert( ptrexpr = NULL )

		ptrexpr = hGetVtableLookupIfNeeded( proc, arg_list->head->expr, options )
	else
		'' remove the instance ptr
		if( (options and FB_PARSEROPT_HASINSTPTR) <> 0 ) then
			arg = arg_list->head
			arg_list->head = arg->next
			astDelTree( arg->expr )
			symbFreeOvlCallArg( @parser.ovlarglist, arg )
		end if
	end if

	procexpr = astNewCALL( proc, ptrexpr )

	params = symbGetProcParams( proc )

	param = symbGetProcHeadParam( proc )

	'' any pre-defined args?
	arg = arg_list->head
	do while( arg <> NULL )
		dim as FB_CALL_ARG ptr nxt = arg->next

		if( astNewARG( procexpr, arg->expr, , arg->mode ) = NULL ) then
			astDelTree( procexpr )
			return astBuildFakeCall( proc )
		end if

		symbFreeOvlCallArg( @parser.ovlarglist, arg )

		'' next
		param = param->next
		arg = nxt
		params -= 1
	loop

	args = 0

	'' proc has no args?
	if( params = 0 ) then
		'' sub? check the optional parentheses
		if( (options and FB_PARSEROPT_ISFUNC) = 0 ) then
			'' '('
			if( lexGetToken( ) = CHAR_LPRNT ) then
				lexSkipToken( )
				'' ')'
				if( lexGetToken( ) <> CHAR_RPRNT ) then
					errReport( FB_ERRMSG_EXPECTEDRPRNT )
					'' error recovery: skip until next ')'
					hSkipUntil( CHAR_RPRNT, TRUE )
				else
					lexSkipToken( )
				end if
			end if
		end if

		return procexpr
	end if

	if( (options and FB_PARSEROPT_OPTONLY) = 0 ) then
		do
			'' count mismatch?
			if( args >= params ) then
				if( param->param.mode <> FB_PARAMMODE_VARARG ) then
					errReport( FB_ERRMSG_ARGCNTMISMATCH )
					'' error recovery: skip until next stmt or ')'
					if( (options and FB_PARSEROPT_ISFUNC) <> 0 ) then
						hSkipUntil( CHAR_RPRNT )
					else
						hSkipStmt( )
					end if

					args -= 1
					exit do
				end if
			end if

			if( hProcArg( proc, param, args, expr, mode, have_eq_outside_parens, options ) = FALSE ) then
				exit do
			end if

			'' add to tree
			if( astNewARG( procexpr, expr, , mode ) = NULL ) then
				'' error recovery: skip until next stmt or ')'
				if( (options and FB_PARSEROPT_ISFUNC) <> 0 ) then
					hSkipUntil( CHAR_RPRNT )
				else
					hSkipStmt( )
				end if

				'' don't try to fake an arg, different modes and param
				'' types like "as any" would break AST
				astDelTree( procexpr )
				return astBuildFakeCall( proc )
			end if

			'' next
			args += 1
			if( args < params ) then
				param = param->next
			end if

		'' ','?
		loop while( hMatch( CHAR_COMMA ) )
	end if

	hMaybeWarnAboutEqOutsideParens( args, have_eq_outside_parens, proc )

	'' if not all args were given, check for the optional ones
	do while( args < params )
		'' var-arg? can't be optional..
		if( param->param.mode = FB_PARAMMODE_VARARG ) then
			exit do
		end if

		'' not optional?
		if( symbParamIsOptional( param ) = FALSE ) then
			errReport( FB_ERRMSG_ARGCNTMISMATCH )
			'' error recovery: fake an expr
			astDelTree( procexpr )
			return astBuildFakeCall( proc )
		end if

		'' add to tree
		if( astNewARG( procexpr, NULL ) = NULL ) then
			astDelTree( procexpr )
			return astBuildFakeCall( proc )
		end if

		'' next
		args += 1
		param = param->next
	loop

	function = procexpr
end function
