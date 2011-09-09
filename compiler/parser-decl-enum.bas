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
private function hEnumConstDecl _
	( _
		byval id as zstring ptr, _
		byref value as integer _
	) as integer

    dim as ASTNODE ptr expr = any

	function = FALSE

	'' '='?
	if( lexGetToken( ) = FB_TK_ASSIGN ) then
		lexSkipToken( )

		'' ConstExpression
		expr = cExpression( )
		if( expr = NULL ) then
			if( errReport( FB_ERRMSG_EXPECTEDCONST ) = FALSE ) then
				exit function
			else
				'' error recovery: skip till next ','
				hSkipUntil( CHAR_COMMA )
				return TRUE
			end if
		end if

		if( astIsCONST( expr ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDCONST ) = FALSE ) then
				exit function
			else
				'' error recovery: no value change
				astDelTree( expr )
				return TRUE
			end if
		end if

		'' not an integer? (CHAR or WCHAR will fail in astIsCONST())
		if( astGetDataClass( expr ) <> FB_DATACLASS_INTEGER ) then
			errReportWarn( FB_WARNINGMSG_IMPLICITCONVERSION, id )
		end if

		value = astGetValueAsInt( expr )
		astDelNode( expr )

    end if

	function = TRUE

end function

'':::::
''EnumBody      =   (EnumDecl (',' EnumDecl)? Comment? SttSeparator)+ .
''
function cEnumBody _
	( _
		byval s as FBSYMBOL ptr, _
		byval attrib as integer _
	) as integer

	static as zstring * FB_MAXNAMELEN+1 id
	dim as integer value = any

	function = FALSE

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
  								if( errReport( FB_ERRMSG_CANTINCLUDEPERIODS ) = FALSE ) then
	  								exit function
								end if
							end if
						end if
					end if

					id = *lexGetText( )

				case FB_TKCLASS_QUIRKWD
					'' only if inside a ns and if not local
					if( (symbIsGlobalNamespc( )) or (parser.scope > FB_MAINSCOPE) ) then
    					if( errReport( FB_ERRMSG_DUPDEFINITION ) = FALSE ) then
    						exit function
    					else
    						'' error recovery: fake an id
    						id = *hMakeTmpStr( )
    					end if

    				else
						id = *lexGetText( )
    				end if

				case else
					exit do
				end select

				lexSkipToken( )

				'' ConstDecl
				if( hEnumConstDecl( @id, value ) = FALSE ) then
					exit function
				end if

				if( symbAddEnumElement( s, @id, value, attrib ) = NULL ) then
					if( errReportEx( FB_ERRMSG_DUPDEFINITION, id ) = FALSE ) then
						exit function
					end if
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
    			if( errReport( FB_ERRMSG_EXPECTEDEOL ) = FALSE ) then
    				exit function
    			else
    				'' error recovery: skip until next line or stmt
    				hSkipUntil( INVALID, TRUE )
    			end if
			end if
		end select

	loop

	'' nothing added?
	if( symbGetEnumElements( s ) = 0 ) then
		if( errReport( FB_ERRMSG_NOELEMENTSDEFINED ) = FALSE ) then
			exit function
		end if
	end if

    function = TRUE

end function

'':::::
''EnumDecl        =   ENUM ID? (ALIAS LITSTR)? EXPLICIT? Comment? SttSeparator
''                        EnumLine+
''					  END ENUM .
function cEnumDecl _
	( _
		byval attrib as FB_SYMBATTRIB _
	) as integer

    static as zstring * FB_MAXNAMELEN+1 id, id_alias
    dim as zstring ptr palias = any
    dim as FBSYMBOL ptr parent = any, e = any

	function = FALSE

	'' ENUM
	lexSkipToken( )

	'' don't allow explicit namespaces
	parent = cParentId( )
    if( parent <> NULL ) then
		if( hDeclCheckParent( parent ) = FALSE ) then
			exit function
    	end if
    else
    	if( errGetLast( ) <> FB_ERRMSG_OK ) then
    		exit function
    	end if
    end if

	'' ID?
	select case lexGetClass( )
	case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_QUIRKWD

		if( fbLangOptIsSet( FB_LANG_OPT_PERIODS ) ) then
			'' if inside a namespace, symbols can't contain periods (.)'s
			if( symbIsGlobalNamespc( ) = FALSE ) then
  				if( lexGetPeriodPos( ) > 0 ) then
  					if( errReport( FB_ERRMSG_CANTINCLUDEPERIODS ) = FALSE ) then
	  					exit function
					end if
				end if
			end if
		end if

		id = *lexGetText( )
		lexSkipToken( )

    case else
    	id = *hMakeTmpStrNL( )
    end select

	'' (ALIAS LITSTR)?
	palias = NULL
	if( lexGetToken( ) = FB_TK_ALIAS ) then
    	lexSkipToken( )

		if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
			if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
				exit function
			end if
        else
			lexEatToken( @id_alias )
			palias = @id_alias
		end if
	end if

	e = symbAddEnum( @id, palias, attrib )
	if( e = NULL ) then
    	if( errReportEx( FB_ERRMSG_DUPDEFINITION, id ) = FALSE ) then
    		exit function
    	else
    		'' error recovery: create a fake symbol
    		e = symbAddEnum( hMakeTmpStr( ), NULL, FB_SYMBATTRIB_NONE )
    	end if
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
    	if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
    		exit function
    	else
    		'' error recovery: skip until next line or stmt
    		hSkipUntil( INVALID, TRUE )
    	end if
	end if

	'' if in BASIC mangling mode, start a new scope
	if( (symbGetMangling( e ) = FB_MANGLING_BASIC) or (isexplicit = TRUE) ) then
		symbNestBegin( e, FALSE )
	end if

	'' EnumBody
	dim as integer res = cEnumBody( e, attrib )

	'' close scope
	if( (symbGetMangling( e ) = FB_MANGLING_BASIC) or (isexplicit = TRUE) ) then
		symbNestEnd( FALSE )
	end if

	if( res = FALSE ) then
		exit function
	end if

	'' END ENUM
	if( lexGetToken( ) <> FB_TK_END ) then
    	if( errReport( FB_ERRMSG_EXPECTEDENDENUM ) = FALSE ) then
    		exit function
    	else
    		'' error recovery: skip until next stmt
    		hSkipStmt( )
    	end if

	else
		lexSkipToken( )

		if( lexGetToken( ) <> FB_TK_ENUM ) then
    		if( errReport( FB_ERRMSG_EXPECTEDENDENUM ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: skip until next stmt
    			hSkipStmt( )
    		end if

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

    ''
	function = TRUE

end function

