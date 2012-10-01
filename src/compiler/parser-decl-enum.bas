'' enumerator (ENUM) declarations
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

'':::
''EnumConstDecl     =   ID ('=' ConstExpression)? .
''
private sub hEnumConstDecl(byval id as zstring ptr, byref value as integer)
	dim as ASTNODE ptr expr = any

	'' '='?
	if( lexGetToken( ) = FB_TK_ASSIGN ) then
		lexSkipToken( )

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

		value = astGetValueAsInt( expr )
		astDelNode( expr )
	end if
end sub

'':::::
''EnumBody      =   (EnumDecl (',' EnumDecl)? Comment? SttSeparator)+ .
''
sub cEnumBody(byval s as FBSYMBOL ptr, byval attrib as integer)
	static as zstring * FB_MAXNAMELEN+1 id
	dim as integer value = any

	value = 0

	do
		'' Comment? SttSeparator?
		do while( cComment( ) or cStmtSeparator( ) )
		loop

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
						id = *hMakeTmpStr( )
					else
						id = *lexGetText( )
					end if

				case else
					exit do
				end select

				lexSkipToken( )

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

'':::::
''EnumDecl        =   ENUM ID? (ALIAS LITSTR)? EXPLICIT? Comment? SttSeparator
''                        EnumLine+
''					  END ENUM .
sub cEnumDecl(byval attrib as FB_SYMBATTRIB)
	static as zstring * FB_MAXNAMELEN+1 id
	dim as FBSYMBOL ptr e = any

	'' ENUM
	lexSkipToken( )

	'' Namespace identifier if it matches the current namespace
	cCurrentParentId()

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
		lexSkipToken( )

    case else
    	id = *hMakeTmpStrNL( )
    end select

	'' [ALIAS "id"]
	dim as zstring ptr palias = cAliasAttribute()

	e = symbAddEnum( @id, palias, attrib )
	if( e = NULL ) then
		errReportEx( FB_ERRMSG_DUPDEFINITION, id )
		'' error recovery: create a fake symbol
		e = symbAddEnum( hMakeTmpStr( ), NULL, FB_SYMBATTRIB_NONE )
	end if

	'' EXPLICIT?
	dim as integer isexplicit = FALSE
	if( lexGetToken( ) = FB_TK_EXPLICIT ) then
		lexSkipToken( )
		isexplicit = TRUE
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
	if( (symbGetMangling( e ) = FB_MANGLING_BASIC) or (isexplicit = TRUE) ) then
		symbNestBegin( e, FALSE )
	end if

	'' EnumBody
	cEnumBody( e, attrib )

	'' close scope
	if( (symbGetMangling( e ) = FB_MANGLING_BASIC) or (isexplicit = TRUE) ) then
		symbNestEnd( FALSE )
	end if

	'' END ENUM
	if( lexGetToken( ) <> FB_TK_END ) then
		errReport( FB_ERRMSG_EXPECTEDENDENUM )
		'' error recovery: skip until next stmt
		hSkipStmt( )
	else
		lexSkipToken( )

		if( lexGetToken( ) <> FB_TK_ENUM ) then
			errReport( FB_ERRMSG_EXPECTEDENDENUM )
			'' error recovery: skip until next stmt
			hSkipStmt( )
		else
			lexSkipToken( )

			if( isexplicit = FALSE ) then
				'' if in BASIC mangling mode, do an implicit 'USING enum'
				if( symbGetMangling( e ) = FB_MANGLING_BASIC ) then
					symbNamespaceImport( e )
				end if
			end if
		end if
	end if
end sub
