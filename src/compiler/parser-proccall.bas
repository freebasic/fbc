'' proc calls (CALL or foo[(...)]) and function result assignments (function=expr)
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "rtl.bi"
#include once "ast.bi"

declare sub hCtorChain( )
declare sub hBaseInit( )
declare function hBaseMemberAccess( ) as integer
declare function hForwardCall( ) as integer

function cBydescArrayArgParens( byval arg as ASTNODE ptr ) as FB_PARAMMODE
	function = INVALID
	if( lexGetToken( ) = CHAR_LPRNT ) then
		if( lexGetLookAhead( 1 ) = CHAR_RPRNT ) then
			if( astGetSymbol( arg ) <> NULL ) then
				if( symbIsArray( astGetSymbol( arg ) ) ) then
					lexSkipToken( )
					lexSkipToken( )
					function = FB_PARAMMODE_BYDESC
				end if
			end if
		end if
	end if
end function

function cAssignFunctResult( byval is_return as integer ) as integer
	dim as FBSYMBOL ptr res = any, subtype = any
	dim as ASTNODE ptr rhs = any, expr = any
	dim as integer has_ctor = any, has_defctor = any, assignoptions = any

	function = FALSE

	res = symbGetProcResult( parser.currproc )
	if( res = NULL ) then
		errReport( FB_ERRMSG_SYNTAXERROR )
		'' error recovery: skip stmt, return
		hSkipStmt( )
		return TRUE
	end if

	has_ctor = symbHasCtor( parser.currproc )
	has_defctor = symbHasDefCtor( parser.currproc )
	var returns_byref = symbIsReturnByRef( parser.currproc )

	'' RETURN?
	if( is_return ) then
		if( symbGetProcStatAssignUsed( parser.currproc ) ) then
			if( has_defctor and (not returns_byref) ) then
				errReport( FB_ERRMSG_RETURNMIXEDWITHASSIGN )
			end if
		end if

		symbSetProcStatReturnUsed( parser.currproc )
	else
		if( symbGetProcStatReturnUsed( parser.currproc ) ) then
			if( has_defctor and (not returns_byref) ) then
				errReport( FB_ERRMSG_ASSIGNMIXEDWITHRETURN )
			end if
		end if

		symbSetProcStatAssignUsed( parser.currproc )
	end if

	'' set the context symbol to allow taking the address of overloaded
	'' procs and also to allow anonymous UDT's
	parser.ctxsym = symbGetSubType( parser.currproc )
	parser.ctx_dtype = symbGetType( parser.currproc )

	'' Expression
	''
	'' Any Expression is allowed in "FUNCTION = expr" or "RETURN expr",
	'' as long as the type matches, unless the function returns BYREF,
	'' then it must be a variable/deref (since we do an implicit ADDROF).
	'' However if BYVAL is explicitly given then any pointer expression
	'' is allowed, no implicit ADDROF is done, just like with BYREF params.

	'' Returning BYREF and no explicit BYVAL given?
	if( returns_byref and (not hMatch( FB_TK_BYVAL )) ) then
		'' BYREF return, must be able to do addrof on the expression
		'' (this disallows expressions like constants, BOPs, @ UOP, ...)
		rhs = cVarOrDeref( FB_VAREXPROPT_ISEXPR )

		if( rhs ) then
			if( astIsAccessToLocal( rhs ) ) then
				errReport( FB_ERRMSG_INVALIDREFERENCETOLOCAL )
			end if

			'' Even though we'll only assign a pointer (it's byref afterall),
			'' check the types as if it was a direct assignment. Advantages:
			''  * errors instead of warnings
			''  * nicer error messages such as "type mismatch" instead of
			''    "suspicious pointer assignment" warnings (which don't make sense
			''    since the pointer basically is an implementation detail)
			if( astCheckByrefAssign( parser.currproc->typ, parser.currproc->subtype, rhs ) ) then
				'' Implicit addrof due to BYREF
				rhs = astNewADDROF( rhs )
			else
				errReport( FB_ERRMSG_TYPEMISMATCHINBYREFRESULTASSIGN )
				astDelTree( rhs )
				'' Place-holder value to be assigned to the byref result pointer
				'' Done separately from the astNewADDROF() on the main code path, because we
				'' 1. shouldn't create a CONST and do astNewADDROF() on it
				'' 2. would still get a zstring VAR if the result type is a string,
				''    which would still trigger a "mismatch" warning which we don't want
				''    during error recovery.
				rhs = astNewCONSTz( typeAddrOf( parser.currproc->typ ), parser.currproc->subtype )
			end if
		end if
	else
		rhs = cExpression( )
	end if

	parser.ctxsym = NULL
	parser.ctx_dtype = FB_DATATYPE_INVALID

	if( rhs = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
		'' error recovery: skip stmt, return
		hSkipStmt( )
		return TRUE
	end if

	'' set accessed flag here, as proc will be ended before AST is flushed
	symbSetIsAccessed( res )

	'' For RETURN in return-byval functions, the result object is only being
	'' constructed now, so try to call a constructor, or fallback to
	'' copy-construction by shallow copy.
	assignoptions = 0
	if( is_return and (not returns_byref) ) then
		if( has_ctor ) then
			dim as integer is_ctorcall = any
			rhs = astBuildImplicitCtorCallEx( res, rhs, cBydescArrayArgParens( rhs ), is_ctorcall )
			if( rhs = NULL ) then
				exit function
			end if

			if( is_ctorcall ) then
				'' Result constructed by ctor call, no assignment needed after this.
				astAdd( astPatchCtorCall( rhs, astBuildProcResultVar( parser.currproc, res ) ) )
				return TRUE
			end if
		end if

		'' Do copy-construction by shallow copy (i.e. don't call any LET overload)
		assignoptions = AST_OPOPT_ISINI
	end if

	'' do the assignment
	expr = astNewASSIGN( astBuildProcResultVar( parser.currproc, res ), rhs, assignoptions )
	if( expr = NULL ) then
		astDelTree( rhs )
		errReport( FB_ERRMSG_ILLEGALASSIGNMENT )
	else
		astAdd( expr )
	end if

	function = TRUE
end function

sub hMethodCallAddInstPtrOvlArg _
	( _
		byval proc as FBSYMBOL ptr, _
		byval thisexpr as ASTNODE ptr, _
		byval arg_list as FB_CALL_ARG_LIST ptr, _
		byval options as FB_PARSEROPT ptr _
	)

	'' Only for method calls
	if( thisexpr = NULL ) then
		return
	end if

	'' The proc given here can be a method with THIS pointer or a static
	'' member proc, depending on which was declared/found first, but it's
	'' not known yet whether the exact overload that's going to be called
	'' will be static or not. So the thisexpr needs to be preserved here,
	'' the rest is done after the args were parsed.

	dim as FB_CALL_ARG ptr arg = symbAllocOvlCallArg( @parser.ovlarglist, arg_list, FALSE )

	dim as FBSYMBOL ptr parent = symbGetParent( proc )
	if( astGetSubtype( thisexpr ) <> parent ) then
		thisexpr = astNewCONV( symbGetType( parent ), parent, thisexpr )
	end if

	arg->expr = thisexpr
	arg->mode = hGetInstPtrMode( thisexpr )

	*options or= FB_PARSEROPT_HASINSTPTR

end sub

private function hLooksLikeEndOfStatement( ) as integer
	select case( lexGetToken( ) )
	case FB_TK_STMTSEP, FB_TK_EOL, FB_TK_EOF, _
	     FB_TK_COMMENT, FB_TK_REM
		function = TRUE
	case else
		function = FALSE
	end select
end function

function cMaybeIgnoreCallResult( byval expr as ASTNODE ptr ) as integer
	'' Allow ignoring function call results even if there are any casts on
	'' top of the CALL
	var t = astSkipCASTs( expr )

	'' Normal CALL at the beginning of a statement? This is only
	'' possible if its result is being ignored.
	if( astIsCALL( t ) ) then
		astAdd( astIgnoreCallResult( astRemoveCASTs( expr ) ) )
		function = TRUE

	'' Call to byref function? Either it's the lhs of an assignment,
	'' or the result is being ignored: need to disambiguate.
	elseif( astIsByrefResultDeref( t ) and hLooksLikeEndOfStatement( ) ) then
		astAdd( astIgnoreCallResult( astRemoveByrefResultDeref( astRemoveCASTs( expr ) ) ) )
		function = TRUE

	else
		'' It's not just a CALL - don't allow the result value of this
		'' expression to be ignored.
		function = FALSE
	end if
end function

'':::::
function cProcCall _
	( _
		byval base_parent as FBSYMBOL ptr, _
		byval sym as FBSYMBOL ptr, _
		byval ptrexpr as ASTNODE ptr, _
		byval thisexpr as ASTNODE ptr, _
		byval checkprnts as integer, _
		byval options as FB_PARSEROPT _
	) as ASTNODE ptr

	dim as integer is_propset = FALSE
	dim as ASTNODE ptr procexpr = any
	dim as FB_CALL_ARG_LIST arg_list = ( 0, NULL, NULL )

	function = NULL

	hMethodCallAddInstPtrOvlArg( sym, thisexpr, @arg_list, @options )

	'' property?
	if( symbIsProperty( sym ) ) then

		dim as integer is_indexed = FALSE

		'' '('? indexed..
		if( lexGetToken( ) = CHAR_LPRNT ) then
			is_indexed = TRUE

			lexSkipToken( )

			'' index expr
			dim as ASTNODE ptr expr = cExpression( )
			if( expr = NULL ) then
				errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
				'' error recovery: fake an expr
				expr = astNewCONSTi( 0 )
			end if

			dim as FB_CALL_ARG ptr arg = symbAllocOvlCallArg( @parser.ovlarglist, @arg_list, FALSE )
			arg->expr = expr
			arg->mode = INVALID

			'' ')'
			if( lexGetToken( ) <> CHAR_RPRNT ) then
				errReport( FB_ERRMSG_EXPECTEDRPRNT )
				'' error recovery: skip until next ')'
				hSkipUntil( CHAR_RPRNT, TRUE )
			else
				lexSkipToken( )
			end if
		end if

		'' '='?
		if( hIsAssignToken( lexGetToken( ) ) ) then
			if( is_indexed ) then
				if( symbGetUDTHasIdxSetProp( symbGetParent( sym ) ) = FALSE ) then
					errReport( FB_ERRMSG_PROPERTYHASNOIDXSETMETHOD, TRUE )
					exit function
				end if
			else
				if( symbGetUDTHasSetProp( symbGetParent( sym ) ) = FALSE ) then
					errReport( FB_ERRMSG_PROPERTYHASNOSETMETHOD )
					exit function
				end if
			end if

			lexSkipToken( )
			is_propset = TRUE

			'' the value arg is the lhs expression

		else
			options or= FB_PARSEROPT_ISPROPGET

			if( is_indexed ) then
				if( symbGetUDTHasIdxGetProp( symbGetParent( sym ) ) = FALSE ) then
					errReport( FB_ERRMSG_PROPERTYHASNOIDXGETMETHOD, TRUE )
					exit function
				end if
			else
				if( symbGetUDTHasGetProp( symbGetParent( sym ) ) = FALSE ) then
					errReport( FB_ERRMSG_PROPERTYHASNOGETMETHOD )
					exit function
				end if
			end if

			'' it's a property get call being deref'd or discarded
		end if

		checkprnts = FALSE

	'' anything else..
	else
		if( checkprnts = TRUE ) then
			'' if the sub has no args, prnts are optional
			if( symbGetProcParams( sym ) = 0 ) then
				checkprnts = FALSE
			end if

		'' if it's a function pointer, prnts are obligatory
		elseif( ptrexpr <> NULL ) then
			checkprnts = TRUE

		end if
	end if

	if( checkprnts ) then
		'' '('
		if( hMatch( CHAR_LPRNT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDLPRNT )
		end if
	end if

	parser.prntcnt = 0
	fbSetPrntOptional( not checkprnts )

	'' ProcArgList
	procexpr = cProcArgList( base_parent, sym, ptrexpr, @arg_list, options )

	'' ')'
	if( (checkprnts) or (parser.prntcnt > 0) ) then
		'' --parent cnt
		parser.prntcnt -= 1

		if( hMatch( CHAR_RPRNT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDRPRNT )
			'' error recovery: skip until next ')'
			hSkipUntil( CHAR_RPRNT, TRUE )
		elseif( parser.prntcnt > 0 ) then
			'' error recovery: skip until all ')'s are found
			do while( parser.prntcnt > 0 )
				hSkipUntil( CHAR_RPRNT, TRUE )
				parser.prntcnt -= 1
			loop
		end if
	end if

	fbSetPrntOptional( FALSE )

	if( is_propset = FALSE ) then
		'' Take care of functions returning BYREF
		procexpr = astBuildByrefResultDeref( procexpr )

		'' StrIdxOrMemberDeref?
		procexpr = cStrIdxOrMemberDeref( procexpr )

		'' if it's a SUB, the expr will be NULL
		if( procexpr = NULL ) then
			exit function
		end if
	end if

	'' If it's a CALL, ignore the result
	if( cMaybeIgnoreCallResult( procexpr ) ) then
		function = NULL
	else
		function = procexpr
	end if

end function

private function hProcSymbol _
	( _
		byval base_parent as FBSYMBOL ptr, _
		byval sym as FBSYMBOL ptr, _
		byval iscall as integer, _
		byval options as FB_PARSEROPT = 0 _
	) as integer

	dim as integer do_call = any

	function = FALSE

	if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_CODE ) = FALSE ) then
		hSkipStmt( )
		return TRUE
	end if

	lexSkipToken( LEXCHECK_POST_LANG_SUFFIX )

	'' '='?
	do_call = not hIsAssignToken( lexGetToken( ) )

	if( do_call = FALSE ) then
		'' special case: property
			if( symbIsProperty( sym ) ) then
			do_call = TRUE

			'' unless it's inside a PROPERTY GET block
			if( symbIsProperty( parser.currproc ) ) then
				if( symbGetProcParams( parser.currproc ) = 1 ) then
					if( symbIsProcOverloadOf( parser.currproc, sym ) ) then
						do_call = FALSE
					end if
				end if
			end if
		end if
	end if

	'' ID ProcParamList?
	if( do_call ) then
		dim as ASTNODE ptr expr = any
		expr = cProcCall( base_parent, sym, NULL, NULL, FALSE, options )

		'' assignment of a function deref?
		if( expr <> NULL ) then
			cAssignment( expr )
		end if

		return TRUE
	end if

	'' ID '=' Expression

	'' CALL?
	if( iscall ) then
		errReport( FB_ERRMSG_SYNTAXERROR )
		'' error recovery: skip stmt, return
		hSkipStmt( )
		return TRUE
	end if

	'' check if name is valid (or if overloaded)
	if( symbIsProcOverloadOf( parser.currproc, sym ) = FALSE ) then
		errReport( FB_ERRMSG_RESULTASSIGNOUTSIDEFUNCTION )
		'' error recovery: skip stmt, return
		hSkipStmt( )
		return TRUE
	end if

	'' skip the '='
	lexSkipToken( )

	function = cAssignFunctResult( FALSE )
end function

'':::::
private function hVarSymbol _
	( _
		byval sym as FBSYMBOL ptr, _
		byval iscall as integer _
	) as integer

	dim as ASTNODE ptr expr = any

	function = FALSE

	'' must process variables here, multiple calls to
	'' Identifier() will fail if a namespace was explicitly
	'' given, because the next call will return an inner symbol
	expr = cVariableEx( sym, TRUE )
	if( expr = NULL ) then
		exit function
	end if

	'' CALL?
	if( iscall ) then
		'' not a ptr call?
		if( astIsCALL( expr ) = FALSE ) then
			astDelTree( expr )
			errReport( FB_ERRMSG_SYNTAXERROR )
			'' error recovery: skip stmt, return
			hSkipStmt( )
			return TRUE
		end if
	end if

	function = cAssignmentOrPtrCallEx( expr )

end function

private function hMatchesDefdtype( byval sym as FBSYMBOL ptr, byval defdtype as integer ) as integer
	if( defdtype = FB_DATATYPE_STRING ) then
		select case( symbGetType( sym ) )
		case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR
			function = TRUE
		case else
			function = FALSE
		end select
	else
		function = (symbGetType( sym ) = defdtype)
	end if
end function

''::::
private function hAssignOrCall_QB _
	( _
		byval chain_ as FBSYMCHAIN ptr, _
		byval iscall as integer _
	) as integer

	function = FALSE

	dim as zstring ptr id = lexGetText( )
	dim as integer suffix = lexGetType( )
	dim as integer defdtype = symbGetDefType( id )

	do while( chain_ <> NULL )

		dim as FBSYMBOL ptr sym = chain_->sym
		dim as FBSYMBOL ptr var_sym = NULL

		'' no suffix?
		if( suffix = FB_DATATYPE_INVALID ) then
			do
				dim as integer is_match = TRUE
				'' is the original symbol suffixed?
				if( symbIsSuffixed( sym ) ) then
					'' if it's a VAR, lookup the default type (last DEF###) in
					'' the case symbol could not be found..
					if( symbGetClass( sym ) = FB_SYMBCLASS_VAR ) then
						is_match = hMatchesDefdtype( sym, defdtype )
					end if
				end if

				if( is_match ) then
					select case as const symbGetClass( sym )
					'' proc?
					case FB_SYMBCLASS_PROC
						'' if it's a RTL func, the suffix is obligatory
						if( symbGetIsRTL( sym ) ) then
							is_match = (symbIsSuffixed( sym ) = FALSE)
						end if

						if( is_match ) then
							return hProcSymbol( NULL, sym, iscall )
						end if

					'' variable?
					case FB_SYMBCLASS_VAR
						if( var_sym = NULL ) then
							if( symbVarCheckAccess( sym ) ) then
								var_sym = sym
							end if
						end if

					'' quirk-keyword?
					case FB_SYMBCLASS_KEYWORD
						'' only if not suffixed
						if( symbIsSuffixed( sym ) = FALSE ) then
							return cQuirkStmt( sym->key.id )
						end if

					end select
				end if

				sym = sym->hash.next
			loop while( sym <> NULL )

		'' suffix..
		else
			do
				if( hMatchesDefdtype( sym, suffix ) ) then
					select case as const symbGetClass( sym )
					'' proc?
					case FB_SYMBCLASS_PROC
						return hProcSymbol( NULL, sym, iscall )

					'' variable?
					case FB_SYMBCLASS_VAR
						if( var_sym = NULL ) then
							if( symbVarCheckAccess( sym ) ) then
								var_sym = sym
							end if
						end if

					'' quirk-keyword?
					case FB_SYMBCLASS_KEYWORD
						return cQuirkStmt( sym->key.id )

					end select
				end if

				sym = sym->hash.next
			loop while( sym <> NULL )
		end if

		'' vars have the less priority than keywords and rtl procs
		if( var_sym <> NULL ) then
			return hVarSymbol( var_sym, iscall )
		end if

		chain_ = symbChainGetNext( chain_ )
	loop

end function

private function hAssignOrPtrCall _
	( _
		byval expr as ASTNODE ptr, _
		byval iscall as integer _
	) as integer

	if( expr = NULL ) then
		exit function
	end if

	'' CALL?
	if( iscall ) then
		'' not a ptr call?
		if( astIsCALL( expr ) = FALSE ) then
			astDelTree( expr )
			errReport( FB_ERRMSG_SYNTAXERROR )
			'' error recovery: skip stmt, return
			hSkipStmt( )
			return TRUE
		end if
	end if

	function = cAssignmentOrPtrCallEx( expr )
end function

''::::
private function hAssignOrCall _
	( _
		byval base_parent as FBSYMBOL ptr, _
		byval chain_ as FBSYMCHAIN ptr, _
		byval iscall as integer, _
		byval options as FB_PARSEROPT = 0 _
	) as integer

	function = FALSE

	do while( chain_ <> NULL )

		dim as FBSYMBOL ptr sym = chain_->sym
		do
			select case as const symbGetClass( sym )
			'' proc?
			case FB_SYMBCLASS_PROC
				return hProcSymbol( base_parent, sym, iscall, options )

			case FB_SYMBCLASS_VAR
				'' must process variables here, multiple calls to
				'' cIdentifier() will fail if a namespace was explicitly
				'' given, because the next call will return an inner symbol
				return hAssignOrPtrCall( cVariableEx( chain_, TRUE ), iscall )

			case FB_SYMBCLASS_FIELD
				return hAssignOrPtrCall( cImplicitDataMember( base_parent, chain_, TRUE, options ), iscall )

			case FB_SYMBCLASS_CONST
				'' This covers misuse of constants as "statements",
				'' or on the lhs of assignments:
				''     ns.someconst
				''     ns.someconst = 123
				'' both isn't allowed; so we finish parsing the constant,
				'' then let cAssignment() show & handle the error.
				return hAssignOrPtrCall( cConstant( sym ), iscall )

			'' quirk-keyword?
			case FB_SYMBCLASS_KEYWORD
				return cQuirkStmt( sym->key.id )

			end select

			sym = sym->hash.next
		loop while( sym <> NULL )

		chain_ = symbChainGetNext( chain_ )
	loop

end function

private function hProcCallOrAssign_QB( ) as integer
	function = FALSE

	select case as const lexGetClass( )
	case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_QUIRKWD, FB_TKCLASS_OPERATOR

		return hAssignOrCall_QB( lexGetSymChain( ), FALSE )

	case FB_TKCLASS_KEYWORD

		if( lexGetToken( ) <> FB_TK_CALL ) then
			return hAssignOrCall_QB( lexGetSymChain( ), FALSE )
		end if

		if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_CODE ) = FALSE ) then
			hSkipStmt( )
			exit function
		end if

		lexSkipToken( LEXCHECK_POST_SUFFIX )

		if( lexGetSymChain( ) = NULL ) then
			return hForwardCall( )
		else
			return hAssignOrCall_QB( lexGetSymChain( ), TRUE )
		end if

	end select

end function

'':::::
''ProcCallOrAssign=   CALL ID ('(' ProcParamList ')')?
''                |   ID ProcParamList?
''                |   (ID | FUNCTION | OPERATOR | PROPERTY) '=' Expression .
''
function cProcCallOrAssign _
	( _
	) as integer

	dim as FBSYMCHAIN ptr chain_ = any
	dim as FBSYMBOL ptr base_parent = any
	dim as ASTNODE ptr expr = any

	function = FALSE

	'' QB mode?
	if( env.clopt.lang = FB_LANG_QB ) then
		return hProcCallOrAssign_QB( )
	end if

	select case as const lexGetClass( )
	case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_QUIRKWD

		chain_ = cIdentifier( base_parent, FB_IDOPT_DEFAULT or FB_IDOPT_ALLOWSTRUCT )

		return hAssignOrCall( base_parent, chain_, FALSE )

	case FB_TKCLASS_KEYWORD

		select case as const lexGetToken( )
		'' FUNCTION?
		case FB_TK_FUNCTION

			'' no need to check for '=', that was done already by Declaration()

			if( fbIsModLevel( ) ) then
				errReport( FB_ERRMSG_ILLEGALOUTSIDEAFUNCTION )
				'' error recovery: skip stmt, return
				hSkipStmt( )
				return TRUE
			end if

			'' useless check.. don't allow FUNCTION inside OPERATOR or PROPERTY
			if( symbIsOperator( parser.currproc ) ) then
				errReport( FB_ERRMSG_EXPECTEDOPERATOR )
			elseif( symbIsProperty( parser.currproc ) ) then
				errReport( FB_ERRMSG_EXPECTEDPROPERTY )
			end if

			'' FUNCTION
			lexSkipToken( LEXCHECK_POST_SUFFIX )

			'' =
			lexSkipToken( )

			return cAssignFunctResult( FALSE )

		'' OPERATOR?
		case FB_TK_OPERATOR

			'' not inside an OPERATOR function?
			if( symbIsOperator( parser.currproc ) = FALSE ) then
				errReport( FB_ERRMSG_ILLEGALOUTSIDEANOPERATOR )
				'' error recovery: skip stmt, return
				hSkipStmt( )
				return TRUE
			end if

			'' OPERATOR
			lexSkipToken( LEXCHECK_POST_SUFFIX )

			'' =
			lexSkipToken( )

			return cAssignFunctResult( FALSE )

		'' PROPERTY?
		case FB_TK_PROPERTY

			'' no need to check for '=', that was done already by Declaration()

			if( fbIsModLevel( ) ) then
				errReport( FB_ERRMSG_ILLEGALOUTSIDEAPROPERTY )
				'' error recovery: skip stmt, return
				hSkipStmt( )
				return TRUE
			else
				if( symbIsProperty( parser.currproc ) = FALSE ) then
					errReport( FB_ERRMSG_ILLEGALOUTSIDEAPROPERTY )
				end if
			end if

			'' PROPERTY
			lexSkipToken( LEXCHECK_POST_SUFFIX )

			'' =
			lexSkipToken( )

			return cAssignFunctResult( FALSE )

		'' CONSTRUCTOR?
		case FB_TK_CONSTRUCTOR
			hCtorChain( )
			return TRUE

		'' BASE?
		case FB_TK_BASE

			'' accessing a base member?
			if( lexGetLookAhead( 1 ) = CHAR_DOT ) then
				return hBaseMemberAccess( )
			else
				hBaseInit( )
				return TRUE
			end if

		'' CALL?
		case FB_TK_CALL

			if( fbLangOptIsSet( FB_LANG_OPT_CALL ) = FALSE ) then
				errReportNotAllowed( FB_LANG_OPT_CALL )
				'' error recovery: skip stmt
				hSkipStmt( )
				return TRUE
			end if

			if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_CODE ) = FALSE ) then
				hSkipStmt( )
				return TRUE
			end if

			'' CALL
			lexSkipToken( LEXCHECK_POST_SUFFIX )

			chain_ = cIdentifier( base_parent )
			if( chain_ <> NULL ) then
				return hAssignOrCall( base_parent, chain_, TRUE )
			end if

			errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
			return TRUE

		end select

	case FB_TKCLASS_OPERATOR
		if( lexGetToken( ) = FB_TK_DELETE ) then
			cOperatorDelete( )
			return TRUE
		end if

	case FB_TKCLASS_DELIMITER

		'' '.'?
		if( lexGetToken( ) = CHAR_DOT ) then
			'' inside a WITH block?
			if( parser.stmt.with ) then
				'' not '..'?
				if( lexGetLookAhead( 1, LEXCHECK_NOPERIOD ) <> CHAR_DOT ) then
					expr = cWithVariable( fbGetCheckArray( ) )
					if( expr = NULL ) then
						exit function
					end if

					return cAssignmentOrPtrCallEx( expr )
				end if
			end if

			'' global namespace access..
			chain_ = cIdentifier( base_parent, FB_IDOPT_DEFAULT or FB_IDOPT_ALLOWSTRUCT )
			if( chain_ <> NULL ) then
				return hAssignOrCall( base_parent, chain_, FALSE )
			end if
		end if

	end select

end function

private sub hCtorChain( )
	dim as FBSYMBOL ptr proc = any, parent = any, this_ = any, ctor_head = any
	dim as ASTNODE ptr this_expr = any

	'' CONSTRUCTOR() chaining is only allowed inside constructors.
	if( symbIsConstructor( parser.currproc ) = FALSE ) then
		errReport( FB_ERRMSG_ILLEGALOUTSIDEACTOR )
		'' error recovery: skip stmt, return
		hSkipStmt( )
		exit sub
	end if

	parent = symbGetNamespace( parser.currproc )

	'' A CONSTRUCTOR() chain call replaces a constructor's initialization
	'' code, so it's only allowed at the top. Is there already another
	'' statement (including CONSTRUCTOR()), or maybe a BASE() initializer?
	'' (BASE() is pointless combined with CONSTRUCTOR() chaining, since
	'' it will be unused)
	if( (astFindFirstCode( ast.proc.curr ) <> NULL) or _
	    (parser.currproc->proc.ext->base_initree <> NULL) ) then
		errReport( FB_ERRMSG_CTORCHAINMUSTBEFIRST )
	end if

	'' Tell astProcEnd() to omit the default init code at the top of ctors
	symbSetIsCtorInited( parser.currproc )

	'' CONSTRUCTOR
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	cProcCall( NULL, symbGetCompCtorHead( parent ), NULL, _
	           astBuildVarField( symbGetParamVar( symbGetProcHeadParam( parser.currproc ) ) ) )
end sub

''  BaseInit  =  BASE (CtorCall | Initializer)
private sub hBaseInit( )
	dim as FBSYMBOL ptr parent = any, base_ = any, subtype = any
	dim as ASTNODE ptr initree = any, ctorcall = any

	'' BASE() is only allowed inside constructors...
	if( symbIsConstructor( parser.currproc ) = FALSE ) then
		errReport( FB_ERRMSG_ILLEGALOUTSIDEACTOR )
		'' error recovery: skip stmt, return
		hSkipStmt( )
		exit sub
	end if

	'' ...and only if there even is a base UDT.
	base_ = symbGetNamespace( parser.currproc )->udt.base
	if( base_ = NULL ) then
		errReport( FB_ERRMSG_CLASSNOTDERIVED )
		'' error recovery: skip stmt, return
		hSkipStmt( )
		exit sub
	end if

	'' We expect BASE() to appear as the first statement. The base ctor
	'' cannot be called in the same place where BASE() was given, anyways --
	'' it must be inserted above the other implicit ctorinit code at the
	'' top of the constructor, to ensure the vtbl pointer is initialized in
	'' the proper order.

	'' Is there another statement already (including CONSTRUCTOR()), or
	'' another BASE()?
	if( (astFindFirstCode( ast.proc.curr ) <> NULL) or _
	    (parser.currproc->proc.ext->base_initree <> NULL) ) then
		errReport( FB_ERRMSG_BASEINITMUSTBEFIRST )
		'' error recovery: skip stmt, return
		hSkipStmt( )
		exit sub
	end if

	'' BASE
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	subtype = symbGetSubtype( base_ )

	'' Has a ctor?
	if( symbGetCompCtorHead( subtype ) ) then
		'' CtorCall
		ctorcall = cCtorCall( subtype )
		'' cCtorCall() created a temporary object to
		'' call the constructor on, we delete it though:
		ctorcall = astCALLCTORToCALL( ctorcall )

		'' Turn the ctorcall into an initree
		initree = astTypeIniBegin( FB_DATATYPE_STRUCT, subtype, TRUE )
		astTypeIniAddCtorCall( initree, base_, ctorcall )
		astTypeIniEnd( initree, TRUE )
	else
		'' Initializer
		initree = cInitializer( base_, FB_INIOPT_ISINI )
	end if

	parser.currproc->proc.ext->base_initree = initree
end sub

'' BaseMemberAccess  =  (BASE '.')+ ID
private function hBaseMemberAccess( ) as integer
	var proc = parser.currproc

	'' not inside a method?
	if( symbIsMethod( proc ) = FALSE ) then
		errReport( FB_ERRMSG_ILLEGALOUTSIDEAMETHOD )
		'' error recovery: skip stmt, return
		hSkipStmt( )
		return TRUE
	end if

	var parent = symbGetNamespace( proc )

	'' is class derived?
	var base_ = parent->udt.base

	do
		if( base_ = NULL ) then
			errReport( FB_ERRMSG_CLASSNOTDERIVED )
			'' error recovery: skip stmt, return
			hSkipStmt( )
			return TRUE
		end if

		'' skip BASE
		lexSkipToken( LEXCHECK_NOPERIOD or LEXCHECK_POST_SUFFIX )

		'' skip '.'
		lexSkipToken( )

		'' (BASE '.')?
		if( lexGetToken() <> FB_TK_BASE ) then
			exit do
		end if

		'' '.'
		if( lexGetLookAhead( 1 ) <> CHAR_DOT ) then
			errReport( FB_ERRMSG_EXPECTEDPERIOD )
			'' error recovery: skip stmt, return
			hSkipStmt( )
			return TRUE
		end if

		base_ = symbGetSubtype( base_ )->udt.base
	loop

	dim as FBSYMCHAIN chain_ = (base_, NULL, FALSE)
	function = hAssignOrCall( symbGetSubType( base_ ), @chain_, FALSE, FB_PARSEROPT_EXPLICITBASE )
end function

function hForwardCall( ) as integer
	function = FALSE

	select case lexGetClass( )
	case FB_TKCLASS_IDENTIFIER
		if( fbLangOptIsSet( FB_LANG_OPT_PERIODS ) ) then
			'' if inside a namespace, symbols can't contain periods (.)'s
			if( symbIsGlobalNamespc( ) = FALSE ) then
				if( lexGetPeriodPos( ) > 0 ) then
					errReport( FB_ERRMSG_CANTINCLUDEPERIODS )
				end if
			end if
		end if

	case else
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		'' error recovery: skip until next '('
		hSkipUntil( CHAR_LPRNT )
		exit function
	end select

	dim as string id = *lexGetText( )

	if( lexGetType( ) <> FB_DATATYPE_INVALID ) then
		errReport( FB_ERRMSG_SYNTAXERROR )
	end if

	'' don't report on suffix, was already checked above
	lexSkipToken( )

	dim as FBSYMBOL ptr proc = symbPreAddProc( id )

	'' '('?
	dim as integer check_prnt = FALSE
	if( lexGetToken( ) = CHAR_LPRNT ) then
		lexSkipToken( )
		check_prnt = TRUE
	end if

	dim as FB_CALL_ARG_LIST arg_list = ( 0, NULL, NULL )

	do
		dim as ASTNODE ptr expr = cExpression( )
		if( expr = NULL ) then
			exit do
		end if

		dim as FB_PARAMMODE mode = FB_PARAMMODE_BYREF

		'' ('('')')?
		if( lexGetToken( ) = CHAR_LPRNT ) then
			if( lexGetLookAhead( 1 ) = CHAR_RPRNT ) then
				lexSkipToken( )
				lexSkipToken( )
				mode = FB_PARAMMODE_BYDESC
			end if
		end if

		''
		dim as integer dtype = FB_DATATYPE_VOID
		select case astGetDataType( expr )
		case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
			 FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
			 dtype = FB_DATATYPE_STRING
		end select

		if( symbAddProcParam( proc, NULL, dtype, NULL, iif( mode = FB_PARAMMODE_BYDESC, -1, 0 ), mode, 0, 0 ) = NULL ) then
			exit do
		end if

		dim as FB_CALL_ARG ptr arg = symbAllocOvlCallArg( @parser.ovlarglist, @arg_list, FALSE )
		arg->expr = expr
		arg->mode = INVALID

		'' ','
		if( lexGetToken( ) <> CHAR_COMMA ) then
			exit do
		end if

		lexSkipToken( )
	loop

	'' ')'?
	if( check_prnt ) then
		if( lexGetToken( ) <> CHAR_RPRNT ) then
			errReport( FB_ERRMSG_EXPECTEDRPRNT )
			'' error recovery: skip until ')'
			hSkipUntil( CHAR_RPRNT, TRUE )
		else
			lexSkipToken( )
		end if
	end if

	proc = symbAddProc( proc, id, NULL, FB_DATATYPE_VOID, NULL, 0, 0, env.target.fbcall, FB_SYMBOPT_NONE )
	if( proc = NULL ) then
		errReport( FB_ERRMSG_DUPDEFINITION, TRUE )
		exit function
	end if

	astAdd( cProcArgList( NULL, proc, NULL, @arg_list, FB_PARSEROPT_OPTONLY ) )
	function = TRUE
end function
