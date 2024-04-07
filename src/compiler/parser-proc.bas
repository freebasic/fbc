'' proc (SUB, FUNCTION, OPERATOR, PROPERTY, CTOR/DTOR) header and body parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "rtl.bi"
#include once "ast.bi"

'' [ALIAS "id"]
function cAliasAttribute( ) as zstring ptr
	static as zstring * FB_MAXNAMELEN+1 aliasid

	if( lexGetToken( ) = FB_TK_ALIAS ) then
		lexSkipToken( LEXCHECK_POST_SUFFIX )

		if( lexGetClass( ) = FB_TKCLASS_STRLITERAL ) then
			aliasid = *lexGetText( )
			lexSkipToken( )

			if( len( aliasid ) > 0 ) then
				function = @aliasid
			else
				errReport( FB_ERRMSG_EMPTYALIASSTRING )
			end if
		else
			errReport( FB_ERRMSG_SYNTAXERROR )
		end if
	end if
end function

'' [LIB "string"]
sub cLibAttribute( )
	dim as zstring ptr libname = any

	if( lexGetToken( ) = FB_TK_LIB ) then
		lexSkipToken( LEXCHECK_POST_SUFFIX )

		if( lexGetClass( ) = FB_TKCLASS_STRLITERAL ) then
			libname = lexGetText( )

			if( len( *libname ) > 0 ) then
				fbAddLib( libname )
			else
				errReport( FB_ERRMSG_EMPTYLIBSTRING )
			end if

			lexSkipToken( )
		else
			errReport( FB_ERRMSG_SYNTAXERROR )
		end if
	end if
end sub

sub cMethodAttributes _
	( _
		byval parent as FBSYMBOL ptr, _
		byref attrib as FB_SYMBATTRIB, _
		byref pattrib as FB_PROCATTRIB _
	)

	'' STATIC?
	if( hMatch( FB_TK_STATIC, LEXCHECK_POST_SUFFIX ) ) then
		attrib or= FB_SYMBATTRIB_STATIC
		'' STATIC methods can't be any of the below
		exit sub
	end if

	'' CONST?
	if( hMatch( FB_TK_CONST, LEXCHECK_POST_SUFFIX ) ) then
		attrib or= FB_SYMBATTRIB_CONST
	end if

	'' (ABSTRACT|VIRTUAL)?
	select case( lexGetToken( ) )
	case FB_TK_ABSTRACT
		pattrib or= FB_PROCATTRIB_VIRTUAL or FB_PROCATTRIB_ABSTRACT

		'' Abstracts can only be allowed in UDTs that extend OBJECT,
		'' because that is what provides the needed vtable ptr.
		if( parent ) then
			if( symbGetHasRTTI( parent ) = FALSE ) then
				errReport( FB_ERRMSG_ABSTRACTWITHOUTRTTI )
				pattrib and= not (FB_PROCATTRIB_VIRTUAL or FB_PROCATTRIB_ABSTRACT)
			end if
		end if

		lexSkipToken( LEXCHECK_POST_SUFFIX )

	case FB_TK_VIRTUAL
		pattrib or= FB_PROCATTRIB_VIRTUAL

		'' ditto for virtuals
		if( parent ) then
			if( symbGetHasRTTI( parent ) = FALSE ) then
				errReport( FB_ERRMSG_VIRTUALWITHOUTRTTI )
				pattrib and= not FB_PROCATTRIB_VIRTUAL
			end if
		end if

		lexSkipToken( LEXCHECK_POST_SUFFIX )

	end select

end sub

'':::::
private sub hParamError _
	( _
		byval proc as FBSYMBOL ptr, _
		byval argnum as integer, _
		byval errnum as integer = FB_ERRMSG_PARAMTYPEMISMATCHAT _
	)

	errReportParam( proc, argnum, NULL, errnum )

end sub

private sub hCheckPrototype _
	( _
		byval proto as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr, _
		byval palias as zstring ptr, _
		byval proc_dtype as integer, _
		byval proc_subtype as FBSYMBOL ptr, _
		byval mode as integer _
	)

	dim as FBSYMBOL ptr param = any, proto_param = any
	dim as integer params = any, proto_params = any, i = any

	'' Check ALIAS id
	if( (palias <> NULL) and ((proto->stats and FB_SYMBSTATS_HASALIAS) <> 0) ) then
		if( *palias <> *proto->id.alias ) then
			errReportEx( FB_ERRMSG_DIFFERENTALIASTHANPROTO, """" + *palias + """" )
		end if
	end if

	'' check return type
	if( (symbGetFullType( proto ) <> proc_dtype) or _
	    (symbGetSubtype( proto ) <> proc_subtype) ) then
		errReport( FB_ERRMSG_RETURNTYPEMISMATCH, TRUE )
	end if

	'' check return method
	if( (proc->proc.returnMethod <> FB_RETURN_DEFAULT) and _
	    (proto->proc.returnMethod <> proc->proc.returnMethod) ) then
		errReportWarn( FB_WARNINGMSG_RETURNMETHODMISMATCH )
	end if

	'' check calling convention
	if( symbGetProcMode( proto ) <> mode ) then
		errReport( FB_ERRMSG_CALLINGCONVMISMATCH, TRUE )
	end if

	'' check arg count
	param = symbGetProcHeadParam( proc )
	params = symbGetProcParams( proc )
	if( symbIsMethod( proc ) ) then
		params -= 1
		param = param->next
	end if

	proto_param = symbGetProcHeadParam( proto )
	proto_params = symbGetProcParams( proto )
	if( symbIsMethod( proto ) ) then
		proto_params -= 1
		proto_param = proto_param->next
	end if

	if( proto_params <> params ) then
		errReport( FB_ERRMSG_ARGCNTMISMATCH, TRUE )
	end if

	'' Check each parameter. In case they had different amounts of
	'' parameters, we already showed an error, but still can check at least
	'' the common parameters, for better error recovery.
	i = 1
	while( (i <= proto_params) and (i <= params) )
		dim as integer dtype = symbGetFullType( proto_param )

		'' convert any AS ANY arg to the final one
		if( typeGet( dtype ) = FB_DATATYPE_VOID ) then
			proto_param->typ = param->typ
			proto_param->subtype = param->subtype

		'' check if types don't conflit
		else
			if( param->typ <> dtype ) then
				hParamError( proc, i )
			elseif( param->subtype <> symbGetSubtype( proto_param ) ) then
				hParamError( proc, i )
			end if
		end if

		'' and mode
		if( param->param.mode <> proto_param->param.mode ) then
			hParamError( proc, i )
		end if

		'' Different BYDESC dimensions?
		'' (even if one is unknown, both should be unknown)
		if( param->param.mode = FB_PARAMMODE_BYDESC ) then
			if( param->param.bydescdimensions <> proto_param->param.bydescdimensions ) then
				hParamError( proc, i )
			end if
		end if

		'' check names and change to the new one if needed
		if( param->param.mode <> FB_PARAMMODE_VARARG ) then
			symbSetName( proto_param, symbGetName( param ) )

			'' as both have the same type, re-set the suffix, because for example
			'' "a as integer" on the prototype and "a%" or just "a" on the proc
			'' declaration when in a defint context is allowed in QB
			if( symbIsSuffixed( param ) ) then
				symbGetAttrib( proto_param ) or= FB_SYMBATTRIB_SUFFIXED
			else
				symbGetAttrib( proto_param ) and = not FB_SYMBATTRIB_SUFFIXED
			end if
		end if

		'' Warn about mismatching param initializers?
		'' If both params are optional, compare the two initializers
		if( symbParamIsOptional( proto_param ) and symbParamIsOptional( param ) ) then
			if( astIsEqualParamInit( proto_param->param.optexpr, param->param.optexpr ) = FALSE ) then
				errReportParamWarn( proc, i, NULL, FB_WARNINGMSG_MISMATCHINGPARAMINIT )
			end if
		end if

		proto_param = proto_param->next
		param = param->next
		i += 1
	wend

end sub

private sub hCheckAttribs _
	( _
		byval proto as FBSYMBOL ptr, _
		byval attrib as FB_SYMBATTRIB, _
		byval pattrib as FB_PROCATTRIB _
	)

	'' if one returns BYREF, the other must too
	if( ((pattrib and FB_PROCATTRIB_RETURNBYREF) <> 0) <> symbIsReturnByRef( proto ) ) then
		errReport( FB_ERRMSG_TYPEMISMATCH, TRUE )
		'' Error recovery: if the proto had BYREF, add it for the body
		'' too, otherwise remove it from the body
		if( symbIsReturnByRef( proto ) ) then
			pattrib or= FB_PROCATTRIB_RETURNBYREF
		else
			pattrib and= not FB_PROCATTRIB_RETURNBYREF
		end if
	end if

	'' the body can only be STATIC if the proto is too
	if( (attrib and FB_SYMBATTRIB_STATIC) and (not symbIsStatic( proto )) ) then
		errReport( FB_ERRMSG_PROCPROTOTYPENOTSTATIC )
	end if

	'' same for CONST
	if( (attrib and FB_SYMBATTRIB_CONST) and (not symbIsConstant( proto )) ) then
		errReport( FB_ERRMSG_PROCPROTOTYPENOTCONST )
	end if

	'' and ABSTRACT (abstracts are VIRTUAL too, so checking them first)
	if( (pattrib and FB_PROCATTRIB_ABSTRACT) and (not symbIsAbstract( proto )) ) then
		errReport( FB_ERRMSG_PROCPROTOTYPENOTABSTRACT )
	'' and VIRTUAL
	elseif( (pattrib and FB_PROCATTRIB_VIRTUAL) and (not symbIsVirtual( proto )) ) then
		errReport( FB_ERRMSG_PROCPROTOTYPENOTVIRTUAL )
	end if

	proto->attrib or= attrib
	proto->pattrib or= pattrib

end sub

private function hCheckIdToken( byval has_parent as integer ) as integer
	function = FALSE

	select case as const( lexGetClass( ) )
	case FB_TKCLASS_IDENTIFIER
		if( fbLangOptIsSet( FB_LANG_OPT_PERIODS ) ) then
			'' if inside a namespace, symbols can't contain periods (.)'s
			if( symbIsGlobalNamespc( ) = FALSE ) then
				if( lexGetPeriodPos( ) > 0 ) then
					errReport( FB_ERRMSG_CANTINCLUDEPERIODS )
				end if
			end if
		end if

	case FB_TKCLASS_QUIRKWD
		if( env.clopt.lang <> FB_LANG_QB ) then
			'' only if inside a ns and if not local
			if( (not has_parent) or (parser.scope > FB_MAINSCOPE) ) then
				errReport( FB_ERRMSG_DUPDEFINITION )
				exit function
			end if
		end if

	case FB_TKCLASS_KEYWORD, FB_TKCLASS_OPERATOR
		if( env.clopt.lang <> FB_LANG_QB ) then
			errReport( FB_ERRMSG_DUPDEFINITION )
			exit function
		end if

	case else
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		exit function
	end select

	function = TRUE
end function

private function hGetId _
	( _
		byval parent as FBSYMBOL ptr, _
		byval id as zstring ptr, _
		byval dtype as integer ptr, _
		byval is_sub as integer _
	) as FBSYMBOL ptr

	dim as FBSYMCHAIN ptr chain_ = any
	dim as FBSYMBOL ptr sym = any

	function = NULL

	'' No parent?
	if( parent = NULL ) then
		'' Read as-is
		chain_ = lexGetSymChain( )
	else
		'' Otherwise, lookup in that namespace
		chain_ = symbLookupAt( parent, lexGetText( ), FALSE, FALSE )
	end if

	'' Any symbol found?
	if( chain_ ) then
		'' same class?
		sym = symbFindByClass( chain_, FB_SYMBCLASS_PROC )
	else
		sym = NULL
	end if

	if( hCheckIdToken( (parent <> NULL) ) = FALSE ) then
		'' error recovery: fake an id, skip until next '('
		*id = *symbUniqueLabel( )
		*dtype = FB_DATATYPE_INVALID
		hSkipUntil( CHAR_LPRNT )
		exit function
	end if

	*id = *lexGetText( )
	*dtype = lexGetType( )

	'' Disallow type suffix on SUBs
	if( is_sub ) then
		if( *dtype <> FB_DATATYPE_INVALID ) then
			'' TODO: error message is weird because it reports proc name
			'' as the invalid character, when it should probably:
			''    a) a different error message
			''    b) point to the invalid suffix character
			errReport( FB_ERRMSG_INVALIDCHARACTER )
			'' error recovery: invalidate the data type and suffix
			*dtype = FB_DATATYPE_INVALID
			lexGetType() = FB_DATATYPE_INVALID
			lexGetSuffixChar() = CHAR_NULL
		end if
	end if

	'' ID
	lexSkipToken( LEXCHECK_POST_LANG_SUFFIX )

	function = sym
end function

sub cProcRetType _
	( _
		byval attrib as FB_SYMBATTRIB, _
		byval pattrib as FB_PROCATTRIB, _
		byval proc as FBSYMBOL ptr, _
		byval is_proto as integer, _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr _
	)

	dim as integer options = any

	'' AS
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	options = FB_SYMBTYPEOPT_DEFAULT

	'' Returns BYREF?
	if( pattrib and FB_PROCATTRIB_RETURNBYREF ) then
		'' In prototypes, allow BYREF AS FWDREF
		if( is_proto ) then
			options or= FB_SYMBTYPEOPT_ALLOWFORWARD
		end if

		'' Then allow BYREF AS Z/WSTRING as the type
		options and= not FB_SYMBTYPEOPT_CHECKSTRPTR
		options or= FB_SYMBTYPEOPT_ISBYREF
	end if

	' prototype? allow wstring
	if( is_proto ) then
		options and= not FB_SYMBTYPEOPT_CHECKSTRPTR
	end if

	if( cSymbolType( dtype, subtype, , , options ) = FALSE ) then
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		'' error recovery: fake a type
		dtype = FB_DATATYPE_INTEGER
		subtype = NULL
	else
		'' check for invalid types
		select case( typeGetDtAndPtrOnly( dtype ) )
		case FB_DATATYPE_WCHAR
			'' WSTRING allowed only if BYREF, or is prototype
			if( ((pattrib and FB_PROCATTRIB_RETURNBYREF) = 0) and (is_proto = FALSE) ) then
				errReport( FB_ERRMSG_CANNOTRETURNFIXLENFROMFUNCTS )
				'' error recovery: fake a type
				dtype = FB_DATATYPE_STRING
				subtype = NULL
			end if

		case FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR
			'' FIXSTR is never allowed; ZSTRING only if BYREF
			if( ((pattrib and FB_PROCATTRIB_RETURNBYREF) = 0) or _
				(typeGetDtAndPtrOnly( dtype ) = FB_DATATYPE_FIXSTR) ) then
				errReport( FB_ERRMSG_CANNOTRETURNFIXLENFROMFUNCTS )
				'' error recovery: fake a type
				dtype = FB_DATATYPE_STRING
				subtype = NULL
			end if

		case FB_DATATYPE_VOID
			'' Not even allowed when returning BYREF, because of
			'' the implicit DEREF on the CALL, but we cannot DEREF
			'' an ANY PTR...
			errReport( FB_ERRMSG_INVALIDDATATYPES )
			'' error recovery: fake a type
			dtype = typeAddrOf( dtype )
			subtype = NULL

		case FB_DATATYPE_STRUCT
			'' __builtin_va_list[] not allowed as a byval return type
			'' __builtin_va_list on ARM fails translation in C backend
			if( subtype ) then
				select case symbGetUdtValistType( subtype )
				case FB_CVA_LIST_BUILTIN_C_STD, FB_CVA_LIST_BUILTIN_ARM
					if( ((pattrib and FB_PROCATTRIB_RETURNBYREF) = 0) and _
						typeIsPtr( dtype ) = FALSE ) then
						errReport( FB_ERRMSG_INVALIDDATATYPES )
						'' error recovery: fake a type
						dtype = typeAddrOf( dtype )
						subtype = NULL
					end if
				end select
			end if

		end select

		if( (pattrib and FB_PROCATTRIB_RETURNBYREF) = 0 ) then
			'' Disallow BYVAL return of objects of abstract classes
			hComplainIfAbstractClass( dtype, subtype )
		end if
	end if

	proc->proc.returnMethod = cProcReturnMethod( dtype )

end sub

function cProcReturnMethod( byval dtype as FB_DATATYPE ) as FB_PROC_RETURN_METHOD
	'' (OPTION(LIT_STRING))?

	dim as string returnMethod

	function = FB_RETURN_DEFAULT

	'' not allowed for non floating-point types
	if( typeGetClass( dtype ) <> FB_DATACLASS_FPOINT ) then exit function

	if( lexGetToken( ) = FB_TK_OPTION ) then
		lexSkipToken( LEXCHECK_POST_SUFFIX )
		hMatchLPRNT( )
		if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
			errReport( FB_ERRMSG_SYNTAXERROR )
		else
			returnMethod = trim( ucase( *lexGetText( ) ) )
			if( returnMethod = "SSE" ) then
				function = FB_RETURN_SSE
			elseif( returnMethod = "FPU" ) then
				function = FB_RETURN_FPU
			end if
			lexSkipToken( )
		end if
		hMatchRPRNT( )
	end if
end function

function cProcCallingConv _
	( _
		byval default as FB_FUNCMODE, _
		byref is_explicit as integer _
	) as FB_FUNCMODE

	is_explicit = FALSE

	'' Use the default FBCALL?
	if( default = FB_FUNCMODE_FBCALL ) then
		default = env.target.fbcall
	end if

	'' (CDECL|STDCALL|PASCAL|THISCALL|FASTCALL)?
	select case as const lexGetToken( )
	case FB_TK_CDECL
		is_explicit = TRUE
		function = FB_FUNCMODE_CDECL
		lexSkipToken( LEXCHECK_POST_SUFFIX )

	case FB_TK_STDCALL
		'' FB_FUNCMODE_STDCALL may be remapped to FB_FUNCMODE_STDCALL_MS
		'' for targets that do not support the @N suffix
		is_explicit = TRUE
		function = env.target.stdcall
		lexSkipToken( LEXCHECK_POST_SUFFIX )

	case FB_TK_PASCAL
		function = FB_FUNCMODE_PASCAL
		is_explicit = TRUE
		lexSkipToken( LEXCHECK_POST_SUFFIX )

	case FB_TK_THISCALL
		'' ignore thiscall if '-z no-thiscall' was given
		if( env.clopt.nothiscall = FALSE ) then
			'' keep the thiscall call convention even if the target/archictecture wont't support it
			'' this will allow us to check that the declaration matches the definition.  Also,
			'' gcc supports extensions for using thiscall even with normal procedures
			is_explicit = TRUE
			function = FB_FUNCMODE_THISCALL
		end if
		lexSkipToken( )

	case FB_TK_FASTCALL
		'' ignore fastcall if '-z no-fastcall' was given
		if( env.clopt.nofastcall = FALSE ) then
			'' keep the fastcall call convention even if the target/archictecture wont't support it
			'' this will allow us to check that the declaration matches the definition.
			is_explicit = TRUE
			function = FB_FUNCMODE_FASTCALL
		end if
		lexSkipToken( )

	end select

	'' no explicit calling convention given? then, calculate a default
	if( is_explicit = FALSE ) then
		select case as const parser.mangling
		case FB_MANGLING_BASIC, FB_MANGLING_RTLIB
			function = default

		case FB_MANGLING_CDECL, FB_MANGLING_CPP
			if( default = FB_FUNCMODE_THISCALL ) then
				function = default
			else
				function = FB_FUNCMODE_CDECL
			end if

		case FB_MANGLING_STDCALL
			'' FB_FUNCMODE_STDCALL may be remapped to FB_FUNCMODE_STDCALL_MS
			'' for targets that do not support the @N suffix
			function = env.target.stdcall

		case FB_MANGLING_STDCALL_MS
			function = FB_FUNCMODE_STDCALL_MS
		end select
	end if
end function

private sub cNakedAttribute( byref pattrib as FB_PROCATTRIB )
	if( ucase( *lexGetText( ) ) = "NAKED" ) then
		lexSkipToken( LEXCHECK_POST_SUFFIX )
		pattrib or= FB_PROCATTRIB_NAKED
	end if
end sub

'' OVERRIDE?
private sub cOverrideAttribute( byval proc as FBSYMBOL ptr )
	'' Check that this method really is allowed to override the overridden method
	symbProcCheckOverridden( proc, FALSE )

	'' Don't bother doing the text comparisons below if at EOL (common case)
	if( lexGetToken( ) = FB_TK_EOL ) then
		exit sub
	end if

	'' OVERRIDE?
	if( ucase( *lexGetText( ) ) = "OVERRIDE" ) then
		if( symbProcGetOverridden( proc ) = NULL ) then
			errReport( FB_ERRMSG_OVERRIDINGNOTHING )
		end if
		lexSkipToken( LEXCHECK_POST_SUFFIX )
	end if
end sub

sub cByrefAttribute( byref pattrib as FB_PROCATTRIB, byval is_func as integer )
	'' BYREF?
	if( lexGetToken( ) = FB_TK_BYREF ) then
		if( is_func = FALSE ) then
			errReport( FB_ERRMSG_SYNTAXERROR )
		end if
		lexSkipToken( LEXCHECK_POST_SUFFIX )
		pattrib or= FB_PROCATTRIB_RETURNBYREF
	end if
end sub

private sub hCheckAttrib _
	( _
		byref attrib as integer, _
		byval attr as integer, _
		byval errmsg as integer _
	)

	if( attrib and attr ) then
		errReport( errmsg, TRUE )
		attrib and= not attr
	end if

end sub

private function hCheckOpOvlParams _
	( _
		byval parent as FBSYMBOL ptr, _
		byval op as integer, _
		byval proc as FBSYMBOL ptr _
	) as integer

	dim as integer found_mismatch = any
	dim as integer is_method = symbIsMethod( proc )

#macro hCheckParam( proc, param, num )
	'' vararg?
	if( symbGetParamMode( param ) = FB_PARAMMODE_VARARG ) then
		hParamError( proc, num, FB_ERRMSG_VARARGPARAMNOTALLOWED )
		exit function
	end if

	'' optional?
	if( symbParamIsOptional( param ) ) then
		hParamError( proc, num, FB_ERRMSG_PARAMCANTBEOPTIONAL )
		exit function
	end if
#endmacro

	function = FALSE

	'' check the number of params
	dim as integer min_params = any, max_params = any
	select case as const astGetOpClass( op )
	case AST_NODECLASS_UOP, AST_NODECLASS_ADDROF
		min_params = iif( astGetOpIsSelf( op ), 0, 1 )
		max_params = min_params

	case AST_NODECLASS_CONV
		min_params = 0
		max_params = min_params

	case AST_NODECLASS_ASSIGN, AST_NODECLASS_MEM
		min_params = 1
		max_params = min_params

	case AST_NODECLASS_COMP
		'' self only if FOR, STEP and NEXT
		if( astGetOpIsSelf( op ) ) then
			min_params = 0
	'           min_params = iif( op = AST_OP_NEXT, 1, 0 )
			max_params = 1
			if( op = AST_OP_NEXT ) then
				min_params += 1
				max_params += 1
			end if
		else
			min_params = 2
			max_params = min_params
		end if

	'' bop..
	case else
		min_params = iif( astGetOpIsSelf( op ), 1, 2 )
		max_params = min_params
	end select

	dim as integer params = symbGetProcParams( proc )
	dim as integer real_params = params - iif( is_method, 1, 0 )
	if( (real_params < min_params) or (real_params > max_params) ) then
		errReport( FB_ERRMSG_ARGCNTMISMATCH, TRUE )
		exit function
	end if

	if( params > 0 ) then
		'' check the params, at least one param must be an UDT
		dim as FBSYMBOL ptr param = symbGetProcHeadParam( proc )

		hCheckParam( proc, param, 1 )

		select case as const astGetOpClass( op )
		'' unary, cast or addressing?
		case AST_NODECLASS_UOP, AST_NODECLASS_CONV, AST_NODECLASS_ADDROF
			'' is the param an UDT?
			select case symbGetType( param )
			case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM ', FB_DATATYPE_CLASS

			case else
				hParamError( proc, 1, FB_ERRMSG_ATLEASTONEPARAMMUSTBEANUDT )
				exit function
			end select

		'' binary?
		case AST_NODECLASS_BOP
			if( params > 1 ) then
				dim as FBSYMBOL ptr nxtparam = param->next

				hCheckParam( proc, nxtparam, 2 )

				'' is the 1st param an UDT?
				select case symbGetType( param )
				case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM ', FB_DATATYPE_CLASS

				case else
					'' try the 2nd one..
					select case symbGetType( nxtparam )
					case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM ', FB_DATATYPE_CLASS

					case else
						hParamError( proc, 2, FB_ERRMSG_ATLEASTONEPARAMMUSTBEANUDT )
						exit function
					end select
				end select
			end if

		'' NEW or DELETE?
		case AST_NODECLASS_MEM
			select case op
			case AST_OP_NEW_SELF, AST_OP_NEW_VEC_SELF
				'' must be an integer
				if( typeGetClass( symbGetType( param ) ) = FB_DATACLASS_INTEGER ) then
					dim as integer is_integer = TRUE
					if( typeIsPtr( symbGetType( param ) ) ) then
						is_integer = FALSE
					end if
					select case symbGetType( param )
					case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
						is_integer = FALSE
					end select
					if( is_integer = FALSE ) then
						hParamError( proc, 1, FB_ERRMSG_PARAMMUSTBEANINTEGER )
						exit function
					end if
				else
					hParamError( proc, 1, FB_ERRMSG_PARAMMUSTBEANINTEGER )
					exit function
				end if

			case else
				'' must be a pointer
				if( typeGetClass( symbGetType( param ) ) = FB_DATACLASS_INTEGER ) then
					if( typeIsPtr( symbGetType( param ) ) = FALSE ) then
						hParamError( proc, 1, FB_ERRMSG_PARAMMUSTBEAPOINTER )
						exit function
					end if
				else
					hParamError( proc, 1, FB_ERRMSG_PARAMMUSTBEAPOINTER )
					exit function
				end if

			end select

		'' FOR, STEP or NEXT?
		case AST_NODECLASS_COMP
			select case as const op
			'' relational? it must return an integer
			case AST_OP_EQ, AST_OP_NE, AST_OP_GT, AST_OP_LT, AST_OP_GE, AST_OP_LE
				if( params > 1 ) then
					dim as FBSYMBOL ptr nxtparam = param->next

					hCheckParam( proc, nxtparam, 2 )

					'' is the 1st param an UDT?
					select case symbGetType( param )
					case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM ', FB_DATATYPE_CLASS

					case else
						'' try the 2nd one..
						select case symbGetType( nxtparam )
						case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM ', FB_DATATYPE_CLASS

						case else
							hParamError( proc, 2, FB_ERRMSG_ATLEASTONEPARAMMUSTBEANUDT )
							exit function
						end select
					end select
				end if

			'' FOR, STEP or NEXT?
			case AST_OP_FOR, AST_OP_STEP, AST_OP_NEXT
				if( astGetOpIsSelf( op ) ) then
					if( params > 1 ) then
						'' skip the instance ptr
						if( is_method ) then
							param = param->next
						end if

						'' must be of the same type as parent
						if( (param = NULL) or (parent = NULL) ) then
							hParamError( proc, 1, FB_ERRMSG_PARAMTYPEINCOMPATIBLEWITHPARENT )
							exit function
						end if

						hCheckParam( proc, param, 1 )

						'' same type?
						if( (symbGetType( param ) <> symbGetType( parent )) or _
						    (symbGetSubtype( param ) <> parent) ) then
							hParamError( proc, 1, FB_ERRMSG_PARAMTYPEINCOMPATIBLEWITHPARENT )
							exit function
						end if
					end if
				end if
			case else
				assert( FALSE )
			end select
		end select
	end if

	'' check the result
	found_mismatch = FALSE

	select case astGetOpClass( op )
	case AST_NODECLASS_CONV
		'' return and param types can't be the same
		if( symbGetSubtype( proc ) = parent ) then
			errReport( FB_ERRMSG_SAMEPARAMANDRESULTTYPES, TRUE )
			exit function
		end if

		'' return type can't be a void
		found_mismatch = (symbGetType( proc ) = FB_DATATYPE_VOID)

	'' unary?
	case AST_NODECLASS_UOP
		'' return type can't be a void
		found_mismatch = (symbGetType( proc ) = FB_DATATYPE_VOID)

	'' assignment?
	case AST_NODECLASS_ASSIGN
		'' it must be a SUB
		found_mismatch = (symbGetType( proc ) <> FB_DATATYPE_VOID)

	'' addressing?
	case AST_NODECLASS_ADDROF
		select case op
		case AST_OP_ADDROF
			'' return type must be a pointer
			found_mismatch = not typeIsPtr( symbGetType( proc ) )

		case AST_OP_FLDDEREF
			'' return type must be an UDT
			found_mismatch = (symbGetType( proc ) <> FB_DATATYPE_STRUCT)

		case else
			assert( op = AST_OP_DEREF )
			'' Must be a function, not a sub
			found_mismatch = (symbGetType( proc ) = FB_DATATYPE_VOID)

		end select

	'' mem?
	case AST_NODECLASS_MEM
		select case op
		case AST_OP_NEW_SELF, AST_OP_NEW_VEC_SELF
			'' should return a pointer
			found_mismatch = not typeIsPtr( symbGetType( proc ) )

		case else
			'' should not return anything
			found_mismatch = (symbGetType( proc ) <> FB_DATATYPE_VOID)
		end select

	'' binary?
	case AST_NODECLASS_BOP
		select case as const op
		'' relational? it must return an integer
		case AST_OP_EQ, AST_OP_NE, AST_OP_GT, AST_OP_LT, AST_OP_GE, AST_OP_LE
			found_mismatch = (symbGetType( proc ) <> FB_DATATYPE_INTEGER)
		case AST_OP_PTRINDEX
			'' Must be a function, not a sub
			found_mismatch = (symbGetType( proc ) = FB_DATATYPE_VOID)
		case else
			'' self? must be a SUB
			if( astGetOpIsSelf( op ) ) then
				found_mismatch = (symbGetType( proc ) <> FB_DATATYPE_VOID)
			'' anything else, it can't be a void
			else
				found_mismatch = (symbGetType( proc ) = FB_DATATYPE_VOID)
			end if
		end select

	case AST_NODECLASS_COMP
		'' FOR, STEP or NEXT?
		if( astGetOpIsSelf( op ) ) then
			'' it must return an integer (if NEXT) or void otherwise
			if( op = AST_OP_NEXT ) then
				found_mismatch = (symbGetType( proc ) <> FB_DATATYPE_INTEGER)
			else
				found_mismatch = (symbGetType( proc ) <> FB_DATATYPE_VOID)
			end if
		'' anything else, it can't be a void
		else
			found_mismatch = (symbGetType( proc ) = FB_DATATYPE_VOID)
		end if

	end select

	if( found_mismatch ) then
		errReport( FB_ERRMSG_INVALIDRESULTTYPEFORTHISOP, TRUE )
		exit function
	end if

	function = TRUE
end function

private function hCheckIsSelfCloneByval _
	( _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr, _
		byval options as integer _
	) as integer

	function = FALSE

	dim as FBSYMBOL ptr param = symbGetProcHeadParam( proc )

	'' if it's a proto, skip the instance param
	if( options and FB_PROCOPT_ISPROTO ) then
		param = param->next
	end if

	if( param = NULL ) then
		exit function
	end if

	'' struct?
	if( symbGetType( param ) <> FB_DATATYPE_STRUCT ) then
		exit function
	end if

	'' same parent?
	if( symbGetSubtype( param ) <> parent ) then
		exit function
	end if

	'' byval?
	if( symbGetParamMode( param ) <> FB_PARAMMODE_BYVAL ) then
		exit function
	end if

	'' pointer?
	if( typeGetClass( symbGetType( param ) ) = FB_DATACLASS_INTEGER ) then
		if( typeIsPtr( symbGetType( param ) ) ) then
			exit function
		end if
	end if

	'' At least one additional non-optional parameter?
	param = param->next
	while( param <> NULL )
		if( symbParamIsOptional( param ) = FALSE ) then
			exit function
		end if
		param = param->next
	wend

	function = TRUE

end function

private sub hCheckPropParams _
	( _
		byval proc as FBSYMBOL ptr, _
		byval is_get as integer _
	)

	dim as integer min_params = any, max_params = any, i = any
	dim as FBSYMBOL ptr param = any

	if( is_get ) then
		min_params = 0
		max_params = 1
	else
		min_params = 1
		max_params = 2
	end if

	if ((symbGetProcParams( proc ) < 1 + min_params) or _
	    (symbGetProcParams( proc ) > 1 + max_params)) then
		errReport( iif( is_get, _
		                FB_ERRMSG_PARAMCNTFORPROPGET, _
		                FB_ERRMSG_PARAMCNTFORPROPSET ), TRUE )
	end if

	'' any optional param?
	param = symbGetProcHeadParam( proc )
	i = 0
	while( param )
		if( symbParamIsOptional( param ) ) then
			hParamError( proc, 1+i, FB_ERRMSG_PARAMCANTBEOPTIONAL )
		end if

		i += 1
		param = param->next
	wend
end sub

private sub hSetUdtPropertyFlags _
	( _
		byval parent as FBSYMBOL ptr, _
		byval is_indexed as integer, _
		byval is_get as integer _
	)

	if( is_indexed ) then
		if( is_get = FALSE ) then
			symbSetUDTHasIdxSetProp( parent )
		else
			symbSetUDTHasIdxGetProp( parent )
		end if
	else
		if( is_get = FALSE ) then
			symbSetUDTHasSetProp( parent )
		else
			symbSetUDTHasGetProp( parent )
		end if
	end if

end sub

'' ProcHeader  =
''    ParentID? (ID|Operator)? CallConvention? OVERLOAD? (ALIAS LIT_STRING)?
''    Parameters? BYREF? (AS SymbolType)?
''    (CONSTRUCTOR|DESTRUCTOR)? Priority? STATIC? EXPORT?
function cProcHeader _
	( _
		byval attrib as FB_SYMBATTRIB, _
		byval pattrib as FB_PROCATTRIB, _
		byref is_nested as integer, _
		byval options as FB_PROCOPT, _
		byval tk as integer _
	) as FBSYMBOL ptr

	#define CREATEFAKE( ) _
		symbAddProc( proc, symbUniqueLabel( ), NULL, dtype, subtype, _
				attrib, pattrib, mode, FB_SYMBOPT_DECLARING )

	static as zstring * FB_MAXNAMELEN+1 id
	dim as zstring ptr palias = any
	dim as FBSYMBOL ptr head_proc = any, proc = any, parent = any, subtype = any
	dim as FBSYMBOL ptr param = any
	dim as integer dtype = any, is_outside = any, is_memberproc = any
	dim as integer mode = any, stats = any, op = any, is_get = any, is_indexed = any
	dim as integer priority = any, idopt = any
	dim as integer mode_is_explicit = any

	is_nested = FALSE
	is_outside = FALSE
	is_memberproc = FALSE
	is_get = FALSE
	is_indexed = FALSE
	dtype = FB_DATATYPE_INVALID
	subtype = NULL
	stats = 0
	priority = 0
	mode_is_explicit = FALSE

	select case( tk )
	case FB_TK_CONSTRUCTOR, FB_TK_DESTRUCTOR
		'' Ctors/dtors always are methods
		pattrib or= FB_PROCATTRIB_METHOD

		'' Ctors always are overloaded by default,
		'' dtors are not (they cannot have params anyways)
		if( tk = FB_TK_CONSTRUCTOR ) then
			pattrib or= FB_PROCATTRIB_CONSTRUCTOR or FB_PROCATTRIB_OVERLOADED
		else
			'' destructor defined by user source is always the complete dtor
			'' the deleting dtor is implicitly defined later
			pattrib or= FB_PROCATTRIB_DESTRUCTOR1
		end if

	case FB_TK_OPERATOR
		'' Operators are always overloaded
		pattrib or= FB_PROCATTRIB_OPERATOR or FB_PROCATTRIB_OVERLOADED

	case FB_TK_PROPERTY
		'' Properties are always methods and overloaded
		pattrib or= FB_PROCATTRIB_PROPERTY or FB_PROCATTRIB_METHOD or _
		           FB_PROCATTRIB_OVERLOADED

	end select

	'' Parent UDT/namespace ID (if allowed)
	'' Inside UDT body?
	if( options and FB_PROCOPT_HASPARENT ) then
		'' No explicit parent ID allowed
		parent = NULL
	else
		'' Parent/namespace ID
		idopt = FB_IDOPT_ISDECL or FB_IDOPT_SHOWERROR or FB_IDOPT_ALLOWSTRUCT
		select case( tk )
		case FB_TK_OPERATOR
			idopt or= FB_IDOPT_ALLOWOPERATOR
		case FB_TK_CONSTRUCTOR, FB_TK_DESTRUCTOR
			idopt or= FB_IDOPT_DONTCHKPERIOD
		end select
		'' don't check access if we are defining the procedure
		'' (which must be done outside of the TYPE declaration)
		if( (options and FB_PROCOPT_ISPROTO) = 0 ) then
			idopt or= idopt or FB_IDOPT_ISDEFN
		end if
		parent = cParentId( idopt )
	end if

	'' Namespace prefix explicitly given?
	if( parent ) then
		'' Note: we assume to be outside this namespace's block;
		'' it's not allowed to explicitly specify the namespace
		'' while inside its block.
		if( options and FB_PROCOPT_ISPROTO ) then
			'' An explicit namespace isn't allowed on prototypes,
			'' declarations should be put in the namespace block,
			'' only bodies can be written outside.
			errReport( FB_ERRMSG_DECLOUTSIDECLASS )
			'' Error recovery: Forget the namespace prefix
			parent = NULL
			assert( (pattrib and FB_PROCATTRIB_METHOD) = 0 )  '' method flag shouldn't be set yet anyways
		else
			'' Proc body with explicitly specified parent:
			'' outside of the original namespace
			is_outside = TRUE
		end if
	else
		'' Use the "default" namespace:
		'' If inside a namespace block, use that as parent.
		'' If at toplevel, the proc doesn't have a parent.
		if( symbGetCurrentNamespc( ) <> @symbGetGlobalNamespc( ) ) then
			parent = symbGetCurrentNamespc( )
		end if
	end if

	if( parent ) then
		'' Parent namespace is a UDT?
		is_memberproc = symbIsStruct( parent )
	end if

	if( is_memberproc ) then
		'' prototypes inside UDTs that are not STATIC are METHODs
		'' (for bodies it depends on the attributes inherited
		'' from the corresponding prototype)
		if( ((options and FB_PROCOPT_ISPROTO) <> 0) and _
		    ((attrib and FB_SYMBATTRIB_STATIC) = 0)       ) then
			pattrib or= FB_PROCATTRIB_METHOD
		end if
	else
		'' Ctors/dtors/properties must always have an UDT parent
		select case( tk )
		case FB_TK_CONSTRUCTOR, FB_TK_DESTRUCTOR, FB_TK_PROPERTY
			if( parent = NULL ) then
				errReport( FB_ERRMSG_EXPECTEDCLASSID )
			elseif( symbIsStruct( parent ) = FALSE ) then
				errReport( FB_ERRMSG_PARENTISNOTACLASS )
			end if

			if( options and FB_PROCOPT_ISPROTO ) then
				hSkipStmt( )
			else
				hSkipCompound( tk )
			end if

			exit function
		end select

		'' Check whether STATIC, CONST, ABSTRACT and VIRTUAL were used correctly
		hCheckAttrib(  attrib, FB_SYMBATTRIB_STATIC  , FB_ERRMSG_STATICNONMEMBERPROC   )
		hCheckAttrib(  attrib, FB_SYMBATTRIB_CONST   , FB_ERRMSG_CONSTNONMEMBERPROC    )
		hCheckAttrib( pattrib, FB_PROCATTRIB_ABSTRACT, FB_ERRMSG_ABSTRACTNONMEMBERPROC )
		hCheckAttrib( pattrib, FB_PROCATTRIB_VIRTUAL , FB_ERRMSG_VIRTUALNONMEMBERPROC  )
	end if

	select case( tk )
	case FB_TK_CONSTRUCTOR, FB_TK_DESTRUCTOR
		'' Ctors/dtors don't have an ID on their own
		proc = symbPreAddProc( NULL )

	case FB_TK_OPERATOR
		'' Operator (instead of an ID)
		op = cOperator( TRUE )
		select case( op )
		case INVALID, _
		     AST_OP_ANDALSO, AST_OP_ANDALSO_SELF, _
		     AST_OP_ORELSE, AST_OP_ORELSE_SELF
			errReport( FB_ERRMSG_EXPECTEDOPERATOR )
			'' error recovery: fake an op
			op = AST_OP_ADD
		end select

		'' self-op?
		if( astGetOpIsSelf( op ) ) then
			'' Must always be a member procedure
			if( is_memberproc = FALSE ) then
				errReport( FB_ERRMSG_OPMUSTBEAMETHOD, TRUE )
				'' error recovery: Change to a non-self op
				op = AST_OP_ADD
			end if
		else
			'' non-self op in a type declaration... !!WRITEME!! static global operators should be allowed?
			if( is_memberproc ) then
				errReport( FB_ERRMSG_OPCANNOTBEAMETHOD, TRUE, " (TODO)" )
			end if
		end if

		select case as const( op )
		case AST_OP_NEW_SELF, AST_OP_NEW_VEC_SELF, _
		     AST_OP_DEL_SELF, AST_OP_DEL_VEC_SELF

			'' These ops are made STATIC implicitly, and they can't
			'' be CONST/VIRTUAL/ABSTRACT

			if( pattrib and (FB_PROCATTRIB_VIRTUAL or FB_PROCATTRIB_ABSTRACT) ) then
				errReport( FB_ERRMSG_OPERATORCANTBEVIRTUAL, TRUE )
				pattrib and= not (FB_PROCATTRIB_VIRTUAL or FB_PROCATTRIB_ABSTRACT)
			end if

			if( attrib and FB_SYMBATTRIB_CONST ) then
				errReport( FB_ERRMSG_OPERATORCANTBECONST, TRUE )
				attrib and= not FB_SYMBATTRIB_CONST
			end if

			attrib or= FB_SYMBATTRIB_STATIC
			pattrib and= not FB_PROCATTRIB_METHOD

		case else
			if( is_memberproc ) then
				if( attrib and FB_SYMBATTRIB_STATIC ) then
					errReport( FB_ERRMSG_OPERATORCANTBESTATIC, TRUE )
					attrib and= not FB_SYMBATTRIB_STATIC
				end if
				'' Then it must be a method
				pattrib or= FB_PROCATTRIB_METHOD
			end if
		end select

		proc = symbPreAddProc( NULL )

	case else
		'' Procedure/property ID
		head_proc = hGetId( parent, @id, @dtype, _
				(tk = FB_TK_SUB) or (tk = FB_TK_PROPERTY) )

		if( fbLangOptIsSet( FB_LANG_OPT_SUFFIX ) ) then
			if( dtype <> FB_DATATYPE_INVALID ) then
				attrib or= FB_SYMBATTRIB_SUFFIXED
			end if
		end if

		proc = symbPreAddProc( @id )
	end select

	'' [NAKED]
	cNakedAttribute( pattrib )

	'' CallConvention?
	select case( tk )
	case FB_TK_CONSTRUCTOR, FB_TK_DESTRUCTOR
		'' ctors/dtors default to CDECL, so they can be passed to
		'' the rtlib's REDIM or ERASE functions by procptr
		mode = FB_FUNCMODE_CDECL
	case else
		mode = FB_FUNCMODE_FBCALL
	end select

	'' extern "c++" / win32 / x86 / non-static member ? then default to THISCALL
	if( is_memberproc ) then
		if( (attrib and FB_SYMBATTRIB_STATIC) = 0 ) then
			if( parser.mangling = FB_MANGLING_CPP ) then
				if( env.clopt.target = FB_COMPTARGET_WIN32 ) then
					if( fbIs64bit( ) = FALSE ) then
						if( env.clopt.nothiscall = FALSE ) then
							mode = FB_FUNCMODE_THISCALL
						end if
					end if
				end if
			end if
		end if
	end if

	mode = cProcCallingConv( mode, mode_is_explicit )

	'' OVERLOAD?
	if( lexGetToken( ) = FB_TK_OVERLOAD ) then
		if( fbLangOptIsSet( FB_LANG_OPT_FUNCOVL ) = FALSE ) then
			errReportNotAllowed( FB_LANG_OPT_FUNCOVL )
		else
			pattrib or= FB_PROCATTRIB_OVERLOADED
		end if
		lexSkipToken( LEXCHECK_POST_SUFFIX )
	end if

	if( options and FB_PROCOPT_ISPROTO ) then
		'' [LIB "string"]
		cLibAttribute( )
	end if

	'' [ALIAS "id"]
	palias = cAliasAttribute( )

	'' If this is a proc body (not a proto), then we'll open a new scope
	'' with astProcBegin(), and additionally we may have to re-open the
	'' proc's namespace, in case it's being declared outside the original
	'' namespace where we found the prototype.
	''
	'' This ensures the proc and code in it behaves as if it was written
	'' in the original namespace to begin with. For example, it must be
	'' possible to access symbols from that namespace without using the
	'' namespace prefix explicitly, even if the body is written outside
	'' the namespace block that contains the prototype.
	''
	'' Note: Even parameter initializers are affected, thus this must be
	'' done even before parsing the parameter list.
	if( ((options and FB_PROCOPT_ISPROTO) = 0) and (parent <> NULL) ) then
		if( parent <> symbGetCurrentNamespc( ) ) then
			symbNestBegin( parent, TRUE )
			is_nested = TRUE
		end if
	end if

	proc->attrib = attrib
	proc->pattrib = pattrib

	'' Parameters?
	cParameters( parent, proc, mode, ((options and FB_PROCOPT_ISPROTO) <> 0) )

	select case( tk )
	case FB_TK_DESTRUCTOR
		if( symbGetProcParams( proc ) > 1 ) then
			errReport( FB_ERRMSG_DTORCANTCONTAINPARAMS )
		end if

		dtype = FB_DATATYPE_VOID
		subtype = NULL

	case FB_TK_CONSTRUCTOR
		'' ctor can't take a byval arg of its own type as only non-optional arg
		if( hCheckIsSelfCloneByval( parent, proc, options ) ) then
			errReport( FB_ERRMSG_CLONECANTTAKESELFBYVAL, TRUE )
			exit function
		end if

		'' vararg?
		if( symbGetParamMode( symbGetProcTailParam( proc ) ) = FB_PARAMMODE_VARARG ) then
			hParamError( proc, 0, FB_ERRMSG_VARARGPARAMNOTALLOWED )
			'' error recovery: remove the param
			param = symbGetProcTailParam( proc )
			symbGetProcTailParam( proc ) = param->prev
			if( param->prev <> NULL ) then
				param->prev->next = NULL
			end if
			symbGetProcParams( proc ) -= 1
			symbFreeSymbol( param )
		end if

		dtype = FB_DATATYPE_VOID
		subtype = NULL

	case FB_TK_OPERATOR
		'' special cases, '-' or '+' with just one param are actually unary ops
		select case op
		case AST_OP_SUB
			if( symbGetProcParams( proc ) = 1 ) then
				op = AST_OP_NEG
			end if

		case AST_OP_ADD
			if( symbGetProcParams( proc ) = 1 ) then
				op = AST_OP_PLUS
			end if

		'' '*' with one param is actually a deref
		case AST_OP_MUL
			if( symbGetProcParams( proc ) = 1 ) then
				op = AST_OP_DEREF
			end if

		end select

		'' self? (but type casting)
		if( astGetOpNoResult( op ) ) then
			dtype = FB_DATATYPE_VOID
		else
			'' BYREF?
			cByrefAttribute( pattrib, TRUE )

			'' AS SymbolType
			if( lexGetToken( ) = FB_TK_AS ) then
				cProcRetType( attrib, pattrib, proc, ((options and FB_PROCOPT_ISPROTO) <> 0), _
				              dtype, subtype )
			else
				errReport( FB_ERRMSG_EXPECTEDRESTYPE )
				'' error recovery: fake a type
				dtype = FB_DATATYPE_INTEGER
			end if
		end if

		symbGetFullType( proc ) = dtype
		symbGetSubtype( proc ) = subtype

		symbSetProcOpOvl( proc, op )

		'' operator LET can't take a byval arg of its own type
		if( op = AST_OP_ASSIGN ) then
			if( hCheckIsSelfCloneByval( parent, proc, options ) ) then
				errReport( FB_ERRMSG_CLONECANTTAKESELFBYVAL, TRUE )
				exit function
			end if
		end if

		'' Check param/result types
		if( hCheckOpOvlParams( parent, op, proc ) = FALSE ) then
			exit function
		end if

	case FB_TK_PROPERTY
		'' BYREF?
		cByrefAttribute( pattrib, TRUE )

		'' (AS SymbolType)?
		if( lexGetToken( ) = FB_TK_AS ) then
			cProcRetType( attrib, pattrib, proc, ((options and FB_PROCOPT_ISPROTO) <> 0), _
			              dtype, subtype )
			is_indexed = (symbGetProcParams( proc ) = 1+1)
			is_get = TRUE
		else
			'' found BYREF before?
			if( pattrib and FB_PROCATTRIB_RETURNBYREF ) then
				errReport( FB_ERRMSG_EXPECTEDRESTYPE )
				'' error recovery: remove BYREF attribute and treat as setter
				pattrib and= not FB_PROCATTRIB_RETURNBYREF
			end if
			dtype = FB_DATATYPE_VOID
			is_indexed = (symbGetProcParams( proc ) = 1+2)
		end if

		symbGetFullType( proc ) = dtype
		symbGetSubType( proc ) = subtype
		hCheckPropParams( proc, is_get )

	case else
		'' Member procedures are overloaded by default, unless they're vararg
		if( is_memberproc ) then
			if( (symbGetProcParams( proc ) <= 0) orelse _
			    (symbGetProcTailParam( proc )->param.mode <> FB_PARAMMODE_VARARG) ) then
				pattrib or= FB_PROCATTRIB_OVERLOADED
			end if
		end if

		'' BYREF?
		cByrefAttribute( pattrib, (tk = FB_TK_FUNCTION) )

		'' (AS SymbolType)?
		if( lexGetToken( ) = FB_TK_AS ) then
			if( (dtype <> FB_DATATYPE_INVALID) or (tk = FB_TK_SUB) ) then
				errReport( FB_ERRMSG_SYNTAXERROR )
			end if
			cProcRetType( attrib, pattrib, proc, ((options and FB_PROCOPT_ISPROTO) <> 0), _
			              dtype, subtype )
		else
			if( tk = FB_TK_FUNCTION ) then
				if( fbLangOptIsSet( FB_LANG_OPT_DEFTYPE ) ) then
					'' No suffix yet?
					if( dtype = FB_DATATYPE_INVALID ) then
						'' Then use type from DEF*
						dtype = symbGetDefType( id )
					end if
				else
					errReportNotAllowed( FB_LANG_OPT_DEFTYPE, FB_ERRMSG_DEFTYPEONLYVALIDINLANG )
					'' error recovery: fake a type
					dtype = FB_DATATYPE_INTEGER
				end if
			else
				'' SUB
				dtype = FB_DATATYPE_VOID
			end if
		end if

	end select

	'' Prototype?
	if( options and FB_PROCOPT_ISPROTO ) then
		select case( tk )
		case FB_TK_CONSTRUCTOR, FB_TK_DESTRUCTOR
			proc = symbAddCtor( proc, palias, attrib, pattrib, mode )
		case FB_TK_OPERATOR
			proc = symbAddOperator( proc, op, palias, dtype, subtype, attrib, pattrib, mode )
		case else
			proc = symbAddProc( proc, @id, palias, dtype, subtype, attrib, pattrib, mode, FB_SYMBOPT_NONE )
		end select

		if( proc = NULL ) then
			errReport( FB_ERRMSG_DUPDEFINITION )
			exit function
		end if

		'' OVERRIDE?
		'' - Only allowed inside the TYPE compound, since it's a
		''   compile-time check in the inheritance hierarchy, and does
		''   not affect the method at all
		'' - Not allowed on ctors, since they cannot be VIRTUAL
		if( ((options and FB_PROCOPT_HASPARENT) <> 0) and _
		    (tk <> FB_TK_CONSTRUCTOR) ) then
			cOverrideAttribute( proc )
		end if

		'' destructor? maybe implicitly declare the deleting destructor too
		if( tk = FB_TK_DESTRUCTOR ) then
			'' fbc won't generate any code that calls the deleting destructor
			'' so don't create the deleting destructor unless we're binding to c++
			if( symbGetMangling( parent ) = FB_MANGLING_CPP ) then
				'' - inherit all the attribs from the declared destructor
				''   except for the destructor type
				dim dtor0 as FBSYMBOL ptr = symbPreAddProc( NULL )
				symbAddProcInstanceParam( parent, dtor0 )
				dtor0 = symbAddCtor( dtor0, NULL, attrib, ((pattrib and not FB_PROCATTRIB_DESTRUCTOR1) or FB_PROCATTRIB_DESTRUCTOR0), mode )
			end if
		end if

		if( tk = FB_TK_PROPERTY ) then
			hSetUdtPropertyFlags( parent, is_indexed, is_get )
		end if

		return proc
	end if

	''
	'' Body
	''

	'' (CONSTRUCTOR | DESTRUCTOR)?
	select case( lexGetToken( ) )
	case FB_TK_CONSTRUCTOR, FB_TK_DESTRUCTOR
		'' A module ctor/dtor must be a sub with no params,
		'' it cannot be a method or function (static member
		'' procs are ok though).
		'' Note: if this body is a member procedure and didn't have an
		'' explicit STATIC, then we don't know whether it's a method or
		'' a static member yet, as it depends on the corresponding
		'' prototype which we only check below. I.e. this check must be
		'' repeated later.
		if( ((pattrib and FB_PROCATTRIB_METHOD) <> 0) or _
		    (tk = FB_TK_FUNCTION) ) then
			errReport( FB_ERRMSG_SYNTAXERROR, TRUE )
		elseif( symbGetProcParams( proc ) <> 0 ) then
			errReport( FB_ERRMSG_ARGCNTMISMATCH, TRUE )
		else
			if( lexGetToken( ) = FB_TK_CONSTRUCTOR ) then
				stats or= FB_SYMBSTATS_GLOBALCTOR
			else
				stats or= FB_SYMBSTATS_GLOBALDTOR
			end if
		end if

		lexSkipToken( LEXCHECK_POST_SUFFIX )

		'' Priority?
		if( lexGetClass( ) = FB_TKCLASS_NUMLITERAL ) then
			'' not an integer?
			if( lexGetType( ) <> FB_DATATYPE_INTEGER ) then
				errReport( FB_ERRMSG_INVALIDPRIORITY )
				'' error recovery: skip token
				lexSkipToken( )
			else
				priority = clng( *lexGetText() )
				if priority < 101 or priority > 65535 then
					errReport( FB_ERRMSG_INVALIDPRIORITY )
					'' error recovery: skip token
					lexSkipToken( )
				else
					priority and= &hffff
					lexSkipToken( )
				end if
			end if
		end if

	end select

	'' STATIC?
	if( hMatch( FB_TK_STATIC, LEXCHECK_POST_SUFFIX ) ) then
		pattrib or= FB_PROCATTRIB_STATICLOCALS
	end if

	'' EXPORT?
	if( lexGetToken( ) = FB_TK_EXPORT ) then
		'' ctor or dtor?
		if( (stats and (FB_SYMBSTATS_GLOBALCTOR or FB_SYMBSTATS_GLOBALDTOR)) <> 0 ) then
			errReport( FB_ERRMSG_SYNTAXERROR )
		end if

		'' private?
		if( attrib and FB_SYMBATTRIB_PRIVATE ) then
			errReport( FB_ERRMSG_SYNTAXERROR )
			attrib and= not FB_SYMBATTRIB_PRIVATE
		end if

		lexSkipToken( LEXCHECK_POST_SUFFIX )

		fbSetOption( FB_COMPOPT_EXPORT, TRUE )
		'''''if( fbGetOption( FB_COMPOPT_EXPORT ) = FALSE ) then
		'''''   errReportWarn( FB_WARNINGMSG_CANNOTEXPORT )
		'''''end if
		attrib or= FB_SYMBATTRIB_EXPORT or FB_SYMBATTRIB_PUBLIC
	end if

	select case( tk )
	case FB_TK_CONSTRUCTOR
		head_proc = symbGetCompCtorHead( parent )
	case FB_TK_DESTRUCTOR
		head_proc = symbGetCompDtor1( parent )
	case FB_TK_OPERATOR
		head_proc = symbGetCompOpOvlHead( parent, op )
	end select

	'' No preview proc (forward CALL?) or existing prototype found in
	'' the parent namespace?
	if( head_proc = NULL ) then
		'' Body outside its parent namespace block?
		if( is_outside ) then
			errReport( FB_ERRMSG_DECLOUTSIDECLASS )
		end if

		'' Add new proc based on the body
		select case( tk )
		case FB_TK_CONSTRUCTOR, FB_TK_DESTRUCTOR
			head_proc = symbAddCtor( proc, palias, attrib, pattrib, mode, FB_SYMBOPT_DECLARING )
		case FB_TK_OPERATOR
			head_proc = symbAddOperator( proc, op, palias, dtype, subtype, _
				attrib, pattrib, mode, FB_SYMBOPT_DECLARING )
		case else
			head_proc = symbAddProc( proc, @id, palias, dtype, subtype, _
				attrib, pattrib, mode, FB_SYMBOPT_DECLARING )

		end select

		if( head_proc = NULL ) then
			errReport( FB_ERRMSG_DUPDEFINITION, TRUE )
			proc = CREATEFAKE( )
		else
			proc = head_proc
		end if
	else
		'' A proc or proto with this name already exists, this is
		'' either a duplicate definition or the corresponding body.

		'' non-properties cannot implement properties, and vice-versa
		if( symbIsProperty( head_proc ) <> (tk = FB_TK_PROPERTY) ) then
			errReport( FB_ERRMSG_DUPDEFINITION, TRUE )
			return CREATEFAKE( )
		end if

		'' overloaded?
		if( symbGetProcIsOverloaded( head_proc ) ) then
			'' Try to find a prototype with the same signature
			select case( tk )
			case FB_TK_CONSTRUCTOR
				head_proc = symbFindCtorProc( head_proc, proc )
			case FB_TK_OPERATOR
				head_proc = symbFindOpOvlProc( op, head_proc, proc )
			case else
				head_proc = symbFindOverloadProc( head_proc, proc, _
						iif( is_get, FB_SYMBFINDOPT_PROPGET, FB_SYMBFINDOPT_NONE ) )
			end select
			pattrib or= FB_PROCATTRIB_OVERLOADED
		end if

		'' No prototype with the same signature found?
		if( head_proc = NULL ) then
			if( is_outside ) then
				errReport( FB_ERRMSG_DECLOUTSIDECLASS )
			end if

			'' Then try to add the new overload
			select case( tk )
			case FB_TK_CONSTRUCTOR, FB_TK_DESTRUCTOR
				head_proc = symbAddCtor( proc, palias, attrib, pattrib, mode, FB_SYMBOPT_DECLARING )
			case FB_TK_OPERATOR
				head_proc = symbAddOperator( proc, op, palias, dtype, subtype, _
				                             attrib, pattrib, mode, FB_SYMBOPT_DECLARING )
			case else
				head_proc = symbAddProc( proc, @id, palias, dtype, subtype, _
				                         attrib, pattrib, mode, FB_SYMBOPT_DECLARING )
			end select

			'' dup def?
			if( head_proc = NULL ) then
				errReport( FB_ERRMSG_DUPDEFINITION, TRUE )
				return CREATEFAKE( )
			end if

			proc = head_proc
		else
			'' already parsed?
			if( symbGetIsDeclared( head_proc ) ) then
				errReport( FB_ERRMSG_DUPDEFINITION, TRUE )
				return CREATEFAKE( )
			end if

			'' no explicit calling convention? then use the proc declaration
			if( mode_is_explicit = FALSE ) then
				'' patch the proc with the declaration's calling convention
				mode = symbGetProcMode( head_proc )
				proc->proc.mode = mode
			end if

			'' There already is a prototype for this proc, check for
			'' declaration conflicts and fix up the parameters
			hCheckPrototype( head_proc, proc, palias, dtype, subtype, mode )

			'' use the prototype
			proc = head_proc

			hCheckAttribs( proc, attrib, pattrib )

			if( stats and (FB_SYMBSTATS_GLOBALCTOR or FB_SYMBSTATS_GLOBALDTOR) ) then
				if( symbIsMethod( proc ) ) then
					errReport( FB_ERRMSG_SYNTAXERROR, TRUE )
				end if
			end if

			symbSetIsDeclared( proc )
		end if
	end if

	if( proc ) then
		var is_global = (symbGetAttrib( proc ) and _
			(FB_SYMBATTRIB_COMMON or FB_SYMBATTRIB_PUBLIC or _
			FB_SYMBATTRIB_EXTERN or FB_SYMBATTRIB_SHARED)) <> 0

		'' only warn if the symbol is global and in the global namespace
		if( is_global ) then
			if( (len(id) > 0) and (symbGetNamespace( proc ) = @symbGetGlobalNamespc( )) ) then
				if( parserIsGlobalAsmKeyword( @id ) ) then
					errReportWarnEx( FB_WARNINGMSG_RESERVEDGLOBALSYMBOL, @id , lexLineNum( ) )
				end if
			end if
		end if
	end if

	'' Register global ctors/dtors
	if( stats and FB_SYMBSTATS_GLOBALCTOR ) then
		if( proc->attrib and (FB_SYMBATTRIB_VIS_PRIVATE or FB_SYMBATTRIB_VIS_PROTECTED) ) then
			errReport( FB_ERRMSG_NOACCESSTOCTOR, TRUE )
		end if
		symbAddGlobalCtor( proc )
		symbSetProcPriority( proc, priority )
	elseif( stats and FB_SYMBSTATS_GLOBALDTOR ) then
		if( proc->attrib and (FB_SYMBATTRIB_VIS_PRIVATE or FB_SYMBATTRIB_VIS_PROTECTED) ) then
			errReport( FB_ERRMSG_NOACCESSTODTOR, TRUE )
		end if
		symbAddGlobalDtor( proc )
		symbSetProcPriority( proc, priority )
	end if

	if( tk = FB_TK_PROPERTY ) then
		hSetUdtPropertyFlags( parent, is_indexed, is_get )
	end if

	function = proc
end function

sub hDisallowStaticAttrib( byref attrib as FB_SYMBATTRIB, byref pattrib as FB_PROCATTRIB )
	if( (attrib and FB_SYMBATTRIB_STATIC) <> 0 ) then
		errReport( FB_ERRMSG_MEMBERCANTBESTATIC )
		attrib and= not FB_SYMBATTRIB_STATIC
	end if
end sub

sub hDisallowVirtualCtor( byref attrib as FB_SYMBATTRIB, byref pattrib as FB_PROCATTRIB )
	'' Constructors cannot be virtual (they initialize the vptr
	'' needed for virtual calls, chicken-egg problem)
	if( pattrib and (FB_PROCATTRIB_ABSTRACT or FB_PROCATTRIB_VIRTUAL) ) then
		if( pattrib and FB_PROCATTRIB_ABSTRACT ) then
			errReport( FB_ERRMSG_ABSTRACTCTOR )
		else
			errReport( FB_ERRMSG_VIRTUALCTOR )
		end if
		pattrib and= not (FB_PROCATTRIB_ABSTRACT or FB_ERRMSG_VIRTUALCTOR)
	end if
end sub

sub hDisallowAbstractDtor( byref attrib as FB_SYMBATTRIB, byref pattrib as FB_PROCATTRIB )
	'' Destructors cannot be abstract; they need to have a body to ensure
	'' that base and field destructors are called.
	if( pattrib and FB_PROCATTRIB_ABSTRACT ) then
		errReport( FB_ERRMSG_ABSTRACTDTOR )
		pattrib and= not FB_PROCATTRIB_ABSTRACT
	end if
end sub

sub hDisallowConstCtorDtor( byval tk as integer, byref attrib as FB_SYMBATTRIB, byref pattrib as FB_PROCATTRIB )
	'' It doesn't make sense for ctors/dtors to be CONST. It's a ctor's
	'' purpose to initialize an object and it couldn't do that if it used
	'' a CONST This. And as for dtors, they need to be able to destroy all
	'' objects, CONST or not. It doesn't matter whether the dtor modifies
	'' the object in the process since it's dead afterwards anyways.
	if( attrib and FB_SYMBATTRIB_CONST ) then
		errReport( iif( tk = FB_TK_CONSTRUCTOR, _
			FB_ERRMSG_CONSTCTOR, FB_ERRMSG_CONSTDTOR ) )
		attrib and= not FB_SYMBATTRIB_CONST
	end if
end sub

'' ProcStmtBegin  =  (PRIVATE|PUBLIC)? (STATIC? | CONST? VIRTUAL?)
''                   (SUB|FUNCTION|CONSTRUCTOR|DESTRUCTOR|OPERATOR) ProcHeader .
sub cProcStmtBegin( byval attrib as FB_SYMBATTRIB, byval pattrib as FB_PROCATTRIB )
	dim as integer tkn = any, is_nested = any
	dim as FBSYMBOL ptr proc = any
	dim as FB_CMPSTMTSTK ptr stk = any

	if( (attrib and (FB_SYMBATTRIB_PUBLIC or FB_SYMBATTRIB_PRIVATE)) = 0 ) then
		if( env.opt.procpublic ) then
			attrib or= FB_SYMBATTRIB_PUBLIC
		else
			attrib or= FB_SYMBATTRIB_PRIVATE
		end if
	end if

	cMethodAttributes( NULL, attrib, pattrib )

	'' SUB|FUNCTION|CONSTRUCTOR|DESTRUCTOR|OPERATOR
	tkn = lexGetToken( )
	select case as const tkn
	case FB_TK_SUB, FB_TK_FUNCTION

	case FB_TK_CONSTRUCTOR
		if( fbLangOptIsSet( FB_LANG_OPT_CLASS ) = FALSE ) then
			errReportNotAllowed( FB_LANG_OPT_CLASS )
		else
			pattrib or= FB_PROCATTRIB_CONSTRUCTOR
		end if

		hDisallowStaticAttrib( attrib, pattrib )
		hDisallowVirtualCtor( attrib, pattrib )
		hDisallowConstCtorDtor( tkn, attrib, pattrib )

	case FB_TK_DESTRUCTOR
		if( fbLangOptIsSet( FB_LANG_OPT_CLASS ) = FALSE ) then
			errReportNotAllowed( FB_LANG_OPT_CLASS )
		else
			'' destructor defined by user source is always the complete dtor
			'' the deleting dtor is implicitly defined later
			pattrib or= FB_PROCATTRIB_DESTRUCTOR1
		end if

		hDisallowStaticAttrib( attrib, pattrib )
		hDisallowAbstractDtor( attrib, pattrib )
		hDisallowConstCtorDtor( tkn, attrib, pattrib )

	case FB_TK_OPERATOR
		if( fbLangOptIsSet( FB_LANG_OPT_OPEROVL ) = FALSE ) then
			errReportNotAllowed( FB_LANG_OPT_OPEROVL )
		end if

	case FB_TK_PROPERTY
		if( fbLangOptIsSet( FB_LANG_OPT_CLASS ) = FALSE ) then
			errReportNotAllowed( FB_LANG_OPT_CLASS )
		end if

		hDisallowStaticAttrib( attrib, pattrib )

	case else
		errReport( FB_ERRMSG_SYNTAXERROR )
		hSkipStmt( )
		exit sub
	end select

	if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_PROC ) = FALSE ) then
		'' error recovery: skip the whole compound stmt
		hSkipCompound( tkn )
		exit sub
	end if

	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' ProcHeader
	proc = cProcHeader( attrib, pattrib, is_nested, FB_PROCOPT_NONE, tkn )
	if( proc = NULL ) then
		'' Close namespace again if cProcHeader() opened it, for better
		'' error recovery.
		if( is_nested ) then
			symbNestEnd( TRUE )
		end if
		hSkipCompound( tkn )
		exit sub
	end if

	'' ABSTRACTs shouldn't have a body implemented, VIRTUAL should be used instead
	if( symbIsAbstract( proc ) ) then
		errReport( FB_ERRMSG_ABSTRACTBODY )
	end if

	'' emit proc setup
	astProcBegin( proc, FALSE )

	'' push to stmt stack
	stk = cCompStmtPush( FB_TK_FUNCTION, FB_CMPSTMT_MASK_DEFAULT or FB_CMPSTMT_MASK_DATA )
	stk->proc.tkn = tkn
	stk->proc.is_nested = is_nested
	stk->proc.endlabel = astGetProcExitlabel( ast.proc.curr )
end sub

'' ProcStmtEnd  =  END (SUB | FUNCTION | OPERATOR | CONSTRUCTOR | DESTRUCTOR | PROPERTY) .
sub cProcStmtEnd( )
	dim as FB_CMPSTMTSTK ptr stk = any
	dim as FBSYMBOL ptr proc_res = any

	stk = cCompStmtGetTOS( FB_TK_FUNCTION )
	if( stk = NULL ) then
		hSkipStmt( )
		exit sub
	end if

	'' END
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' SUB | FUNCTION | ...
	if( hMatch( stk->proc.tkn, LEXCHECK_POST_SUFFIX ) = FALSE ) then
		select case stk->proc.tkn
		case FB_TK_SUB
			errReport( FB_ERRMSG_EXPECTEDENDSUB )
		case FB_TK_FUNCTION
			errReport( FB_ERRMSG_EXPECTEDENDFUNCTION )
		case FB_TK_CONSTRUCTOR
			errReport( FB_ERRMSG_EXPECTEDENDCTOR )
		case FB_TK_DESTRUCTOR
			errReport( FB_ERRMSG_EXPECTEDENDDTOR )
		case FB_TK_OPERATOR
			errReport( FB_ERRMSG_EXPECTEDENDOPERATOR )
		case FB_TK_PROPERTY
			errReport( FB_ERRMSG_EXPECTEDENDPROPERTY )
		end select
	end if

	'' function and the result wasn't set?
	proc_res = symbGetProcResult( parser.currproc )
	if( proc_res <> NULL ) then
		if( symbGetIsAccessed( proc_res ) = FALSE ) then
			if( symbIsNaked( parser.currproc ) = FALSE ) then
				if( symbIsReturnByRef( parser.currproc ) ) then
					errReport( FB_ERRMSG_NOBYREFFUNCTIONRESULT )
				else
					errReportWarn( FB_WARNINGMSG_NOFUNCTIONRESULT )
				end if
			end if
		end if
	end if

	'' always finish
	astProcEnd( FALSE )

	'' Close namespace again if cProcHeader() opened it
	if( stk->proc.is_nested ) then
		symbNestEnd( TRUE )
	end if

	'' pop from stmt stack
	cCompStmtPop( stk )
end sub
