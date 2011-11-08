'' constant (CONST) declarations
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

''::::
private function hGetType _
	( _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr _
	) as integer

	function = FALSE

	'' (AS SymbolType)?
	if( lexGetToken( ) = FB_TK_AS ) then
		lexSkipToken( )

		dim as integer lgt = any

		if( cSymbolType( dtype, subtype, lgt ) = FALSE ) then
			exit function
		end if

		'' check for invalid types
		if( subtype <> NULL ) then
			'' only allow if it's an enum
			if( dtype <> FB_DATATYPE_ENUM ) then
				errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE )
				'' error recovery: discard type
				dtype = FB_DATATYPE_INVALID
				subtype = NULL
			end if
		end if

		select case as const typeGet( dtype )
		case FB_DATATYPE_VOID, FB_DATATYPE_FIXSTR, _
			 FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
			errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE )
			'' error recovery: discard type
			dtype = FB_DATATYPE_INVALID
			subtype = NULL

		end select

	else
		dtype = FB_DATATYPE_INVALID
		subtype = NULL
	end if

	function = TRUE

end function

'':::
''ConstAssign     =   ID (AS SymbolType)? '=' ConstExpression .
''
function cConstAssign _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval attrib as FB_SYMBATTRIB = FB_SYMBATTRIB_NONE _
	) as integer

    static as zstring * FB_MAXNAMELEN+1 id
    dim as integer doskip = any
    dim as ASTNODE ptr expr = any
    dim as FBSYMBOL ptr parent = any, litsym = any
    dim as FBVALUE value = any

	function = FALSE

	'' don't allow explicit namespaces
	parent = cParentId( )
    if( parent <> NULL ) then
		hDeclCheckParent( parent )
    else
    	if( errGetLast( ) <> FB_ERRMSG_OK ) then
    		exit function
    	end if
    end if

	dim as integer suffix = lexGetType( )
	hCheckSuffix( suffix )

	'' ID
	select case as const lexGetClass( )
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
			if( (symbIsGlobalNamespc( )) or (parser.scope > FB_MAINSCOPE) ) then
				errReport( FB_ERRMSG_DUPDEFINITION )
				'' error recovery: skip until next stmt or const decl
				hSkipUntil( FB_TK_DECLSEPCHAR )
				return TRUE
			end if
		end if

	case FB_TKCLASS_KEYWORD, FB_TKCLASS_OPERATOR
		if( env.clopt.lang <> FB_LANG_QB ) then
			errReport( FB_ERRMSG_DUPDEFINITION )
			'' error recovery: skip until next stmt or const decl
			hSkipUntil( FB_TK_DECLSEPCHAR )
			return TRUE
		end if

	case else
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		'' error recovery: skip until next stmt or const decl
		hSkipUntil( FB_TK_DECLSEPCHAR )
		return TRUE
	end select

	id = *lexGetText( )
	lexSkipToken( )

	'' not multiple?
	if( dtype = FB_DATATYPE_INVALID ) then
		'' (AS SymbolType)?
		if( hGetType( dtype, subtype ) = FALSE ) then
			exit function
		end if
	end if

	'' both suffix and type given?
	if( suffix <> FB_DATATYPE_INVALID ) then
		if( dtype <> FB_DATATYPE_INVALID ) then
			errReportEx( FB_ERRMSG_SYNTAXERROR, id )
		end if

		dtype = suffix
		subtype = NULL

		attrib or= FB_SYMBATTRIB_SUFFIXED
	end if

	'' '='
	doskip = FALSE
	if( lexGetToken( ) <> FB_TK_ASSIGN ) then
		errReport( FB_ERRMSG_EXPECTEDEQ )
		doskip = TRUE
	else
		lexSkipToken( )
	end if

	'' ConstExpression
	expr = cExpression( )
	if( expr = NULL ) then
		errReportEx( FB_ERRMSG_EXPECTEDCONST, id )
		doskip = TRUE
		expr = NULL
	end if

	if( expr = NULL ) then
		'' error recovery: create a fake node
		expr = astNewCONSTz( dtype )
	end if

	'' check if it's an string
	dim as integer exprdtype = astGetDataType( expr )
	litsym = NULL
	select case exprdtype
	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
		litsym = astGetStrLitSymbol( expr )
	end select

	'' string?
	if( litsym <> NULL ) then

		if( dtype <> FB_DATATYPE_INVALID ) then
			'' not a string?
			if( dtype <> FB_DATATYPE_STRING ) then
				errReportEx( FB_ERRMSG_INVALIDDATATYPES, id )
			end if
		end if

		value.str = litsym

		if( symbAddConst( @id, exprdtype, NULL, @value, attrib ) = NULL ) then
			errReportEx( FB_ERRMSG_DUPDEFINITION, id )
		end if

	'' anything else..
	else

		'' not a constant?
		if( astIsCONST( expr ) = FALSE ) then
			errReportEx( FB_ERRMSG_EXPECTEDCONST, id )
			'' error recovery: create a fake node
			astDelTree( expr )
			expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
			exprdtype = FB_DATATYPE_INTEGER
		end if

		if( dtype <> FB_DATATYPE_INVALID ) then
			'' string?
			if( typeGet( dtype ) = FB_DATATYPE_STRING ) then
				errReportEx( FB_ERRMSG_INVALIDDATATYPES, id )
				'' error recovery: create a fake node
				astDelTree( expr )
				exprdtype = dtype
				subtype = NULL
				expr = astNewCONSTstr( NULL )
			end if

			'' convert if needed
			if( (dtype <> exprdtype) or _
				(subtype <> astGetSubtype( expr )) ) then

				expr = astNewCONV( dtype, subtype, expr )
				if( expr = NULL ) then
					errReportEx( FB_ERRMSG_INVALIDDATATYPES, id )
					'' error recovery: create a fake node
					expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
					dtype = FB_DATATYPE_INTEGER
					subtype = NULL
				end if
			end if

		else
			dtype = exprdtype
			subtype = astGetSubtype( expr )
		end if

		''
		if( symbAddConst( @id, _
						  dtype, _
						  subtype, _
						  @astGetValue( expr ), _
						  attrib ) = NULL ) then
			errReportEx( FB_ERRMSG_DUPDEFINITION, id )
		end if

    end if

	''
	astDelNode( expr )

	if( doskip ) then
		'' error recovery: skip until next stmt or const decl
		hSkipUntil( FB_TK_DECLSEPCHAR )
	end if

	function = TRUE

end function

'':::::
''ConstDecl       =   CONST (AS SymbolType)? ConstAssign (DECL_SEPARATOR ConstAssign)* .
''
function cConstDecl _
	( _
		byval attrib as FB_SYMBATTRIB = FB_SYMBATTRIB_NONE _
	) as integer

    dim as integer dtype = any
    dim as FBSYMBOL ptr subtype = any

    function = FALSE

    '' CONST
    lexSkipToken( )

	'' (AS SymbolType)?
	if( hGetType( dtype, subtype ) = FALSE ) then
		exit function
	end if

	do
		'' ConstAssign
		if( cConstAssign( dtype, subtype, attrib ) = FALSE ) then
			exit function
		end if

    	'' ','?
    	if( lexGetToken( ) <> FB_TK_DECLSEPCHAR ) then
    		exit do
    	end if

    	lexSkipToken( )
	loop

	function = TRUE

end function


