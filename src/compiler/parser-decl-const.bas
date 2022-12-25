'' constant (CONST) declarations
''
'' chng: sep/2004 written [v1ctor]
'' chng: jul/2021 don't allow CONST between SELECT and CASE [jeffm]

#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

private sub hGetType( byref dtype as integer, byref subtype as FBSYMBOL ptr )
	'' (AS SymbolType)?
	if( lexGetToken( ) = FB_TK_AS ) then
		lexSkipToken( LEXCHECK_POST_SUFFIX )

		if( cSymbolType( dtype, subtype ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
			dtype = FB_DATATYPE_INTEGER
			subtype = NULL
		end if

		'' Check for invalid (ANY, forward references) and unsupported
		'' types (UDTs except enums, fixed-length strings)
		select case( typeGetDtAndPtrOnly( dtype ) )
		case FB_DATATYPE_VOID, FB_DATATYPE_FIXSTR, _
		     FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR, _
		     FB_DATATYPE_STRUCT, FB_DATATYPE_FWDREF
			errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE )
			'' error recovery: discard type
			dtype = FB_DATATYPE_INVALID
			subtype = NULL
		end select
	else
		dtype = FB_DATATYPE_INVALID
		subtype = NULL
	end if
end sub

'' ConstAssign  =  ID (AS SymbolType)? '=' ConstExpression .
private sub cConstAssign _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval attrib as FB_SYMBATTRIB _
	)

	static as zstring * FB_MAXNAMELEN+1 id
	dim as integer doskip = any, suffix = any
	dim as ASTNODE ptr expr = any
	dim as FBSYMBOL ptr litsym = any
	dim as FBVALUE value = any

	'' Namespace identifier if it matches the current namespace
	cCurrentParentId()

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
				exit sub
			end if
		end if

	case FB_TKCLASS_KEYWORD, FB_TKCLASS_OPERATOR
		if( env.clopt.lang <> FB_LANG_QB ) then
			errReport( FB_ERRMSG_DUPDEFINITION )
			'' error recovery: skip until next stmt or const decl
			hSkipUntil( FB_TK_DECLSEPCHAR )
			exit sub
		end if

	case else
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		'' error recovery: skip until next stmt or const decl
		hSkipUntil( FB_TK_DECLSEPCHAR )
		exit sub
	end select

	id = *lexGetText( )

	'' ID
	lexCheckToken( LEXCHECK_POST_LANG_SUFFIX )
	suffix = lexGetType( )
	lexSkipToken( )

	'' not multiple?
	if( dtype = FB_DATATYPE_INVALID ) then
		'' (AS SymbolType)?
		hGetType( dtype, subtype )
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
	if( cAssignToken( ) = FALSE ) then
		errReport( FB_ERRMSG_EXPECTEDEQ )
		doskip = TRUE
	end if

	'' ConstExpression
	expr = cExpression( )
	if( expr = NULL ) then
		errReportEx( FB_ERRMSG_EXPECTEDCONST, id )
		doskip = TRUE
		'' Error recovery:
		'' 1. If the dtype was supposed to be determined based on the
		''    expression which we just failed to parse, use a default.
		if( dtype = FB_DATATYPE_INVALID ) then
			dtype = FB_DATATYPE_INTEGER
		end if
		'' 2. Create a fake expression
		expr = astNewCONSTz( dtype, subtype )
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
			if( typeGetDtAndPtrOnly( dtype ) <> FB_DATATYPE_STRING ) then
				errReportEx( FB_ERRMSG_INVALIDDATATYPES, id )
			end if
		end if

		value.s = litsym
		if( symbReuseOrAddConst( @id, exprdtype, NULL, @value, attrib ) = NULL ) then
			errReportEx( FB_ERRMSG_DUPDEFINITION, id )
		end if
	'' anything else..
	else
		'' not a constant?
		if( astIsCONST( expr ) = FALSE ) then
			errReportEx( FB_ERRMSG_EXPECTEDCONST, id )
			'' error recovery: create a fake node
			astDelTree( expr )
			expr = astNewCONSTi( 0 )
			exprdtype = FB_DATATYPE_INTEGER
		end if

		'' Type explicitly specified?
		if( dtype <> FB_DATATYPE_INVALID ) then
			'' Check for type mismatch & warn about suspicious pointer assignments etc.
			if( astCheckASSIGNToType( dtype, subtype, expr, FALSE ) = FALSE ) then
				errReportEx( FB_ERRMSG_TYPEMISMATCH, id )
				'' error recovery: create a fake node
				astDelTree( expr )
				exprdtype = dtype
				subtype = NULL
				expr = astNewCONSTstr( NULL )
			end if

			'' Convert expression to given type if needed
			if( (dtype <> exprdtype) or _
				(subtype <> astGetSubtype( expr )) ) then
				expr = astNewCONV( dtype, subtype, expr )
				if( expr = NULL ) then
					errReportEx( FB_ERRMSG_INVALIDDATATYPES, id )
					'' error recovery: create a fake node
					expr = astNewCONSTi( 0 )
					dtype = FB_DATATYPE_INTEGER
					subtype = NULL
				end if
			end if
		else
			'' Use expression's type
			'' (no need to check for conversion overflow,
			''  since it's the same type)
			dtype = exprdtype
			subtype = astGetSubtype( expr )
		end if

		if( symbReuseOrAddConst( @id, dtype, subtype, astConstGetVal( expr ), attrib ) = NULL ) then
			errReportEx( FB_ERRMSG_DUPDEFINITION, id )
		end if
	end if

	astDelNode( expr )

	if( doskip ) then
		'' error recovery: skip until next stmt or const decl
		hSkipUntil( FB_TK_DECLSEPCHAR )
	end if
end sub

'' ConstDecl  =  CONST (AS SymbolType)? ConstAssign (DECL_SEPARATOR ConstAssign)* .
sub cConstDecl( byval attrib as FB_SYMBATTRIB )
	dim as integer dtype = any
	dim as FBSYMBOL ptr subtype = any

	'' CONST doesn't generate any code, but should not be allowed between SELECT and CASE
	if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_DECL or FB_CMPSTMT_MASK_CODE ) = FALSE ) then
		hSkipStmt( )
		exit sub
	end if

	'' CONST
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' (AS SymbolType)?
	hGetType( dtype, subtype )

	do
		'' ConstAssign
		cConstAssign( dtype, subtype, attrib )

		'' ','?
		if( lexGetToken( ) <> FB_TK_DECLSEPCHAR ) then
			exit do
		end if

		lexSkipToken( )
	loop
end sub
