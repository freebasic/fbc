'' proc parameters list declarations (called "arg" by mistake)
''
'' chng: sep/2004 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

declare function hParamDecl	_
	( _
		byval proc as FBSYMBOL ptr, _
		byval procmode as integer, _
		byval isproto as integer _
	) as FBSYMBOL ptr

declare function hParamDeclInstPtr _
	( _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	) as FBSYMBOL ptr

'':::::
''Parameters=   '(' ParamDecl (',' ParamDecl)* ')' .
''
sub cParameters _
	( _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr, _
		byval procmode as integer, _
		byval isproto as integer _
	)

	dim as integer length = any

	length = 0

	'' method? add the instance pointer (must be done here
	'' to check for dups)
	if( symbIsMethod( proc ) ) then
		symbAddProcInstancePtr( parent, proc )
		length += typeGetSize( typeAddrOf( FB_DATATYPE_VOID ) )
	end if

	'' '('?
	if( lexGetToken( ) <> CHAR_LPRNT ) then
		return
	end if

	lexSkipToken( )

	'' ')'?
	if( lexGetToken( ) = CHAR_RPRNT ) then
		lexSkipToken( )
		return
	end if

	do
		dim as FBSYMBOL ptr param = hParamDecl(proc, procmode, isproto)
		if( param = NULL ) then
			exit do
		end if

		length += symbGetLen( param )

		'' vararg?
		if( param->param.mode = FB_PARAMMODE_VARARG ) then
			exit do
		end if

		'' ','
	   	if( lexGetToken( ) <> CHAR_COMMA ) then
	   		exit do
	   	end if

		lexSkipToken( )
	loop

	'' ')'?
	if( lexGetToken( ) <> CHAR_RPRNT ) then
		errReport( FB_ERRMSG_EXPECTEDRPRNT )
		'' error recovery: skip until ')'
		hSkipUntil( CHAR_RPRNT, TRUE )
	else
		lexSkipToken( )
	end if

	'' param list too large?
	if( length > 256 ) then
		errReportWarn( FB_WARNINGMSG_PARAMLISTSIZETOOBIG, symbGetName( proc ) )
	end if
end sub

'':::::
private sub hParamError _
	( _
		byval proc as FBSYMBOL ptr, _
		byval pid as zstring ptr, _
		byval msgnum as FB_ERRMSG = FB_ERRMSG_ILLEGALPARAMSPECAT _
	)

	errReportParam( proc, symbGetProcParams( proc )+1, pid, msgnum )

end sub

'':::::
private sub hParamWarning _
	( _
		byval proc as FBSYMBOL ptr, _
		byval pid as zstring ptr, _
		byval msgnum as FB_ERRMSG _
	)

	errReportParamWarn( proc, symbGetProcParams( proc )+1, pid, msgnum )

end sub

private function hOptionalExpr _
	( _
		byval proc as FBSYMBOL ptr, _
		byval pid as zstring ptr, _
		byval param as FBSYMBOL ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr expr = any

    function = NULL

	'' Must be BYVAL/BYREF in order to allow an optional expression
	'' (not BYDESC nor VARARG)
	if( symbGetParamMode( param ) <> FB_PARAMMODE_BYVAL ) then
		if( symbGetParamMode( param ) <> FB_PARAMMODE_BYREF ) then
    		exit function
    	end if
    end if

	select case as const( symbGetType( param ) )
    '' UDT? let SymbolInit() build a tree..
    case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		expr = cInitializer( param, FB_INIOPT_ISINI )
    	if( expr = NULL ) then
    		exit function
    	end if

    '' anything else..
	case else
		expr = cExpression( )
		if( expr = NULL ) then
			exit function
		end if

		'' check for invalid types
		if( astCheckASSIGNToType( symbGetType( param ), symbGetSubtype( param ), expr ) = FALSE ) then
			exit function
		end if

    end select

	'' remove the temps from the dtors list if any was added
	astDtorListClear( )

    '' don't allow references to local symbols
	if( astFindLocalSymbol( expr ) <> NULL ) then
		hParamError( proc, pid, FB_ERRMSG_INVALIDREFERENCETOLOCAL )
		'' no error recovery, caller will take care
		astDelTree( expr )
		expr = NULL
	end if

	function = expr
end function

private function hMockParam _
	( _
		byval proc as FBSYMBOL ptr, _
		byval pmode as integer = INVALID _
	) as FBSYMBOL ptr

	dim as integer dtype = any

	if( pmode = INVALID ) then
		pmode = env.opt.parammode
	end if

	if( pmode = FB_PARAMMODE_VARARG ) then
		dtype = FB_DATATYPE_INVALID
	else
		dtype = FB_DATATYPE_INTEGER
	end if

	function = symbAddProcParam( proc, NULL, dtype, NULL, pmode, 0 )
end function

'':::::
'' ParamDecl      =   (BYVAL|BYREF)? ID (('(' ')')? (AS SymbolType)?)? ('=" (NUM_LIT|STR_LIT))? .
''
private function hParamDecl _
	( _
		byval proc as FBSYMBOL ptr, _
		byval proc_mode as integer, _
		byval isproto as integer _
	) as FBSYMBOL ptr

	static as zstring * FB_MAXNAMELEN+1 idTB(0 to FB_MAXARGRECLEVEL-1)
	static as integer reclevel = 0
	dim as zstring ptr id = any
	dim as ASTNODE ptr optexpr = any
	dim as integer dtype = any, mode = any, lgt = any
	dim as integer attrib = any
	dim as integer readid = any, dotpos = any, doskip = any, dontinit = any, use_default = any
	dim as FBSYMBOL ptr subtype = any, param = any

	function = NULL

    attrib = 0

	'' '...'?
	if( lexGetToken( ) = CHAR_DOT ) then
		if( lexGetLookAhead( 1 ) = CHAR_DOT ) then
		    lexSkipToken( )
		    lexSkipToken( )

			if( lexGetToken( ) <> CHAR_DOT ) then
				hParamError( proc, "..." )
				'' error recovery: skip until next ')', this is the last param
				hSkipUntil( CHAR_RPRNT )
				hMockParam( proc, FB_PARAMMODE_VARARG )
			else
				lexSkipToken( )
			end if

			'' not cdecl or is it the first arg?
			if( (proc_mode <> FB_FUNCMODE_CDECL) or _
				(symbGetProcParams( proc ) = 0) ) then
				hParamError( proc, "..." )
				return hMockParam( proc, FB_PARAMMODE_VARARG )
			end if

			return symbAddProcParam( proc, NULL, FB_DATATYPE_INVALID, NULL, _
			                         FB_PARAMMODE_VARARG, 0 )

		'' syntax error..
		else
			hParamError( proc, "..." )
			'' error recovery: skip until next ')', this is the last param
			hSkipUntil( CHAR_RPRNT )
			return hMockParam( proc, FB_PARAMMODE_VARARG )
		end if
	end if

	'' (BYVAL|BYREF)?
	select case lexGetToken( )
	case FB_TK_BYVAL
		mode = FB_PARAMMODE_BYVAL
		lexSkipToken( )
	case FB_TK_BYREF
		mode = FB_PARAMMODE_BYREF
		lexSkipToken( )
	case else
		mode = INVALID
	end select

	'' Check whether a param ID was given or not
	'' In prototypes they can be omitted, and in fact we even allow
	'' keywords there and use them as parameter ID, probably to make
	'' translating C headers easier, except for AS of course because that
	'' indicates the parameter type.
	select case( lexGetClass( ) )
	case FB_TKCLASS_IDENTIFIER
		'' ID (most common case)
		readid = TRUE

	case FB_TKCLASS_KEYWORD, FB_TKCLASS_QUIRKWD
		'' Keyword

		'' Only allow keywords in prototypes, but not in bodies
		if( isproto = FALSE ) then
			hParamError( proc, lexGetText( ) )
			'' error recovery: skip until next ',' or ')' and return a mock param
			hSkipUntil( CHAR_COMMA )
			return hMockParam( proc, mode )
		end if

		'' AS? (the only keyword that cannot be ignored/treated as ID here)
		readid = (lexGetToken( ) <> FB_TK_AS)

	case else
		'' It's no ID and no keyword; the only other thing that's
		'' allowed here is an '(' as in '()' array parameter without id,
		'' in prototypes only of course (only there can param IDs be omitted).
		if( (lexGetToken( ) <> CHAR_LPRNT) or (isproto = FALSE) ) then
			hParamError( proc, lexGetText( ) )
			'' error recovery: skip until next ',' or ')' and return a mock param
			hSkipUntil( CHAR_COMMA )
			return hMockParam( proc, mode )
		end if

		readid = FALSE

	end select

	''
	if( reclevel >= FB_MAXARGRECLEVEL ) then
		errReport( FB_ERRMSG_RECLEVELTOODEEP )
		'' error recovery: skip until next ',' or ')' and return a mock param
		hSkipUntil( CHAR_COMMA )
		return hMockParam( proc, mode )
	end if

	id = @idTB(reclevel)
	*id = ""

	'' ID (or keyword used as ID)
	if( readid ) then
		*id = *lexGetText( )
		dotpos = lexGetPeriodPos( )

		dtype = lexGetType( )
		hCheckSuffix( dtype )

		lexSkipToken( )
	else
		'' no id
		dtype  = FB_DATATYPE_INVALID
	end if

	'' '()' array parentheses, '('?
	if( lexGetToken( ) = CHAR_LPRNT ) then
		lexSkipToken( )
		'' Must be followed by ')', and BYVAL/BYREF cannot be used
		'' (array() parameters always implicitly are BYDESC)
		if( (mode <> INVALID) or (hMatch( CHAR_RPRNT ) = FALSE) ) then
			hParamError( proc, id )
		end if
		mode = FB_PARAMMODE_BYDESC
	end if

	use_default = FALSE
	if( mode = INVALID ) then
		mode = env.opt.parammode
		use_default = TRUE
    	if( fbPdCheckIsSet( FB_PDCHECK_PARAMMODE ) ) then
    		hParamWarning( proc, id, FB_WARNINGMSG_NOEXPLICITPARAMMODE )
    	end if
	end if

	'' (AS SymbolType)?
	doskip = FALSE
	if( lexGetToken( ) = FB_TK_AS ) then
		lexSkipToken( )
		if( dtype <> FB_DATATYPE_INVALID ) then
			hParamError( proc, id )
			exit function
		end if

		reclevel += 1

		'' if it's a proto, allow forward types in byref params
		dim as integer options = FB_SYMBTYPEOPT_DEFAULT

		if( mode = FB_PARAMMODE_BYREF ) then
			if( isproto ) then
				options or= FB_SYMBTYPEOPT_ALLOWFORWARD
			end if
			options and= not FB_SYMBTYPEOPT_CHECKSTRPTR
		end if

		if( cSymbolType( dtype, subtype, lgt, options ) = FALSE ) then
			hParamError( proc, id )
			'' error recovery: fake type
			dtype = FB_DATATYPE_INTEGER
			subtype = NULL
			doskip = TRUE
		end if

		if( mode = FB_PARAMMODE_BYVAL ) then
			'' Disallow BYVAL passing of objects of abstract classes
			hComplainIfAbstractClass( dtype, subtype )
		end if

		reclevel -= 1
	else
		if( fbLangOptIsSet( FB_LANG_OPT_DEFTYPE ) = FALSE ) then
			errReportNotAllowed( FB_LANG_OPT_DEFTYPE, FB_ERRMSG_DEFTYPEONLYVALIDINLANG )
			doskip = TRUE
		else
			if( readid = FALSE ) then
				hParamError( proc, NULL )
				doskip = TRUE
			end if
		end if

		subtype = NULL
		attrib or= FB_SYMBATTRIB_SUFFIXED
	end if

	'' in lang FB,
	if( fbLangIsSet( FB_LANG_FB ) ) then
		'' we have to delay the true default until now, since
		'' byval/byref depends on the symbol type
		if( use_default ) then
			mode = symbGetDefaultCallConv( typeGet( dtype ), subtype )
		end if
	end if

    '' QB def-by-letter hax
    if( dtype = FB_DATATYPE_INVALID ) then
        dtype = symbGetDefType( id )
    end if

	if( doskip ) then
		hSkipUntil( CHAR_COMMA )
	end if

    '' check for invalid args
    select case as const typeGet( dtype )
    '' can't be a fixed-len string
	case FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
		if( mode = FB_PARAMMODE_BYVAL or typeGet( dtype ) = FB_DATATYPE_FIXSTR ) then
			hParamError( proc, id )
			'' error recovery: fake correct type
			dtype = typeAddrOf( dtype )
		end if

	'' can't be as ANY on non-prototypes
    case FB_DATATYPE_VOID
    	if( isproto = FALSE ) then
			hParamError( proc, id )
			'' error recovery: fake correct type
			dtype = typeAddrOf( dtype )
    	else
    		if( mode = FB_PARAMMODE_BYVAL ) then
				hParamError( proc, id )
				'' error recovery: fake correct param
				dtype = typeAddrOf( dtype )
    		end if
    	end if

    case FB_DATATYPE_STRUCT
    	if( isproto = FALSE ) then
    		'' contains a period?
    		if( dotpos > 0 ) then
				hParamError( proc, id )
    		end if
    	end if

	case FB_DATATYPE_STRING
		if( mode = FB_PARAMMODE_BYVAL ) then
			if( fbPdCheckIsSet( FB_PDCHECK_PARAMMODE ) ) then
				hParamWarning( proc, id, FB_WARNINGMSG_BYVALASSTRING )
			end if
		end if

    end select

	'' default values
	optexpr = NULL
	dontinit = FALSE

	'' Add new param
	param = symbAddProcParam( proc, iif( isproto, cptr( zstring ptr, NULL ), id ), _
	                          dtype, subtype, mode, attrib )
	if( param = NULL ) then
		exit function
	end if

	if( isproto = FALSE ) then
		if( symbGetLen( param ) > (FB_INTEGERSIZE * 4) ) then
			if( fbPdCheckIsSet( FB_PDCHECK_PARAMSIZE ) ) then
				hParamWarning( proc, id, FB_WARNINGMSG_PARAMSIZETOOBIG )
			end if
		end if
	end if

	'' ('=' (expr | ANY))?
	if( lexGetToken( ) = FB_TK_ASSIGN ) then
		lexSkipToken( )

		if( mode = FB_PARAMMODE_BYDESC ) then
			'' ANY?
			if( lexGetToken( ) = FB_TK_ANY ) then
				lexSkipToken( )
				dontinit = TRUE
			else
				hParamError( proc, id )
				'' error recovery: skip until next ',' or ')'
				hSkipUntil( CHAR_COMMA )
			end if
		else
			optexpr = hOptionalExpr( proc, id, param )
			if( optexpr = NULL ) then
				hParamError( proc, id )
				'' error recovery: skip until next ',' or ')'
				hSkipUntil( CHAR_COMMA )
			end if
		end if
	end if

	if( dontinit ) then
		symbSetDontInit( param )
	end if

	if( optexpr ) then
		symbMakeParamOptional( proc, param, optexpr )
	end if

	function = param
end function
