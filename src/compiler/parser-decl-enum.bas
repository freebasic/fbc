'' enumerator (ENUM) declarations
''
'' chng: sep/2004 written [v1ctor]
'' chng: jul/2021 don't allow ENUM between SELECT and CASE [jeffm]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

'':::
''EnumConstDecl     =   ID ('=' ConstExpression)? .
''
private sub hEnumConstDecl( byval id as zstring ptr, byref value as longint )
	dim as ASTNODE ptr expr = any

	'' '='?
	if( cAssignToken( ) ) then
		'' ConstExpression
		expr = cExpression( )
		if( expr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDCONST )
			'' error recovery: skip till next ','
			hSkipUntil( CHAR_COMMA )
			return
		end if

		if( astIsCONST( expr ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDCONST )
			'' error recovery: no value change
			astDelTree( expr )
			return
		end if

		'' not an integer? (CHAR or WCHAR will fail in astIsCONST())
		if( astGetDataClass( expr ) <> FB_DATACLASS_INTEGER ) then
			errReportWarn( FB_WARNINGMSG_IMPLICITCONVERSION, id )
		end if

		value = astConstFlushToInt( expr )
	end if
end sub

'':::::
''EnumBody      =   (EnumDecl (',' EnumDecl)? Comment? SttSeparator)+ .
''
sub cEnumBody( byval s as FBSYMBOL ptr, byval attrib as FB_SYMBATTRIB )
	static as zstring * FB_MAXNAMELEN+1 id
	dim as longint value = any

	value = 0

	do
		'' Comment? SttSeparator?
		while( (cComment( ) or cStmtSeparator( )) and _
		       (lexGetToken( ) <> FB_TK_EOF) )
		wend

		select case lexGetToken( )
		'' EOF?
		case FB_TK_EOF
			exit do

		'' END?
		case FB_TK_END
			exit do

		case else

			'' ID ConstDecl (',' ID ConstDecl)*
			do
				'' ID?
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

					id = *lexGetText( )

				case FB_TKCLASS_QUIRKWD
					'' only if inside a ns and if not local
					if( (symbIsGlobalNamespc( )) or (parser.scope > FB_MAINSCOPE) ) then
						errReport( FB_ERRMSG_DUPDEFINITION )
						'' error recovery: fake an id
						id = *symbUniqueLabel( )
					else
						id = *lexGetText( )
					end if

				case else
					exit do
				end select

				lexSkipToken( LEXCHECK_POST_SUFFIX )

				'' ConstDecl
				hEnumConstDecl( @id, value )

				if( symbAddEnumElement( s, @id, value, attrib ) = NULL ) then
					errReportEx( FB_ERRMSG_DUPDEFINITION, id )
				end if

				value += 1

				'' ','?
				if( lexGetToken( ) <> CHAR_COMMA ) then
					exit do
				end if

				lexSkipToken( )
			loop

			'' Comment? SttSeparator
			cComment( )

			'' emit the current line in text form
			hEmitCurrLine( )

			if( cStmtSeparator( ) = FALSE ) then
				errReport( FB_ERRMSG_EXPECTEDEOL )
				'' error recovery: skip until next line or stmt
				hSkipUntil( INVALID, TRUE )
			end if
		end select
	loop

	'' nothing added?
	if( symbGetEnumElements( s ) = 0 ) then
		errReport( FB_ERRMSG_NOELEMENTSDEFINED )
	end if
end sub

'' EnumDecl  =
''  ENUM ID? (ALIAS LITSTR)? EXPLICIT?
''      EnumLine+
''  END ENUM .
sub cEnumDecl( byval attrib as FB_SYMBATTRIB )
	static as zstring * FB_MAXNAMELEN+1 id
	dim as FBSYMBOL ptr e = any

	'' ENUM doesn't generate any code, but should not be allowed between SELECT and CASE
	if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_DECL or FB_CMPSTMT_MASK_CODE ) = FALSE ) then
		'' error recovery: skip the whole compound stmt
		hSkipCompound( FB_TK_ENUM )
		exit sub
	end if

	'' ENUM
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' ID?
	select case lexGetClass( )
	case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_QUIRKWD

		if( fbLangOptIsSet( FB_LANG_OPT_PERIODS ) ) then
			'' if inside a namespace, symbols can't contain periods (.)'s
			if( symbIsGlobalNamespc( ) = FALSE ) then
				if( lexGetPeriodPos( ) > 0 ) then
					errReport( FB_ERRMSG_CANTINCLUDEPERIODS )
				end if
			end if
		end if

		id = *lexGetText( )
		lexSkipToken( LEXCHECK_POST_LANG_SUFFIX )

	case else
		id = *symbUniqueId( )
		attrib or= FB_SYMBATTRIB_ANONYMOUS
	end select

	'' [ALIAS "id"]
	dim as zstring ptr palias = cAliasAttribute()

	'' EXPLICIT?
	dim as integer isexplicit = FALSE
	if( lexGetToken( ) = FB_TK_EXPLICIT ) then
		lexSkipToken( LEXCHECK_POST_SUFFIX )
		isexplicit = TRUE
	end if

	''
	'' Normally, Enums are namespaces containing their constants, and a
	'' Using will automatically be done below to import the constants into
	'' the parent namespace unless the Enum was declared Explicit.
	''
	'' This way, an Enum's constants can be accessed via "constid" or
	'' "enumid.constid", and an Explicit Enum's constants can only be
	'' accessed via the latter.
	''
	'' Non-Explicit Enums inside Extern blocks have special behaviour
	'' though, they're not treated as separate namespaces. Instead, the
	'' constants are added to the parent namespace directly. Access to them
	'' via "enumid.constid" is disallowed (FB_ERRMSG_NONSCOPEDENUM).
	''

	dim as integer use_hashtb = (parser.mangling = FB_MANGLING_BASIC)
	use_hashtb or= isexplicit

	e = symbAddEnum( @id, palias, attrib, use_hashtb )
	if( e = NULL ) then
		errReportEx( FB_ERRMSG_DUPDEFINITION, id )
		'' error recovery: create a fake symbol
		e = symbAddEnum( symbUniqueLabel( ), NULL, FB_SYMBATTRIB_NONE, use_hashtb )
	end if

	'' Comment? SttSeparator
	cComment( )

	'' emit the current line in text form
	hEmitCurrLine( )

	if( cStmtSeparator( ) = FALSE ) then
		errReport( FB_ERRMSG_SYNTAXERROR )
		'' error recovery: skip until next line or stmt
		hSkipUntil( INVALID, TRUE )
	end if

	'' if in BASIC mangling mode, start a new scope
	if( use_hashtb ) then
		symbNestBegin( e, FALSE )
	end if

	'' EnumBody (enum elements don't inherit anonymous attribute)
	cEnumBody( e, attrib and (not FB_SYMBATTRIB_ANONYMOUS) )

	'' close scope
	if( use_hashtb ) then
		symbNestEnd( FALSE )
	end if

	'' END ENUM
	if( lexGetToken( ) <> FB_TK_END ) then
		errReport( FB_ERRMSG_EXPECTEDENDENUM )
		'' error recovery: skip until next stmt
		hSkipStmt( )
	else
		lexSkipToken( LEXCHECK_POST_SUFFIX )

		if( lexGetToken( ) <> FB_TK_ENUM ) then
			errReport( FB_ERRMSG_EXPECTEDENDENUM )
			'' error recovery: skip until next stmt
			hSkipStmt( )
		else
			lexSkipToken( LEXCHECK_POST_SUFFIX )

			if( isexplicit = FALSE ) then
				'' if in BASIC mangling mode, do an implicit 'USING enum'
				if( use_hashtb ) then
					symbNamespaceImport( e )
				end if
			end if
		end if
	end if
end sub
