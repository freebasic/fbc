'' NAMESPACE..END NAMESPACE compound statement parsing
''
'' chng: may/2006 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

'':::::
''NamespaceStmtBegin  =   NAMESPACE (ID (ALIAS LITSTR)?)? .
''
function cNamespaceStmtBegin _
	( _
		_
	) as integer

    static as zstring * FB_MAXNAMELEN+1 id
    dim as zstring ptr palias = any
    dim as FBSYMBOL ptr sym = any
    dim as FBSYMCHAIN ptr chain_ = any
    dim as FB_CMPSTMTSTK ptr stk = any
    dim as integer levels = any

	function = FALSE

    if( fbLangOptIsSet( FB_LANG_OPT_NAMESPC ) = FALSE ) then
    	errReportNotAllowed(FB_LANG_OPT_NAMESPC )
    	'' error recovery: skip the whole compound stmt
    	hSkipCompound( FB_TK_NAMESPACE )
    	exit function
    end if

    if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_NAMESPC ) = FALSE ) then
    	'' error recovery: skip the whole compound stmt
    	hSkipCompound( FB_TK_NAMESPACE )
    	exit function
    end if

	'' skip NAMESPACE
	lexSkipToken( LEXCHECK_NOPERIOD )

	'' ID?
	palias = NULL

	select case as const lexGetToken( )
	'' COMMENT|NEWLINE?
	case FB_TK_COMMENT, FB_TK_REM, FB_TK_EOL, FB_TK_EOF, FB_TK_STMTSEP

		'' anonymous namespace..
		sym = symbAddNamespace( hMakeTmpStr( ), NULL )

		stk = cCompStmtPush( FB_TK_NAMESPACE, _
					 	 	 FB_CMPSTMT_MASK_ALL and (not FB_CMPSTMT_MASK_CODE) _
					 					 	 	 and (not FB_CMPSTMT_MASK_EXTERN) _
					 					 	 	 and (not FB_CMPSTMT_MASK_DATA) )

		stk->nspc.node = astNamespaceBegin( sym )
		stk->nspc.levels = 1

		return TRUE
	end select

    levels = 0
    do
		if( parser.nspcrec + levels >= FB_MAXNAMESPCRECLEVEL ) then
			errReport( FB_ERRMSG_RECLEVELTOODEEP )
			exit function
		end if

        levels += 1

    	'' not an id?
    	select case lexGetClass( )
    	case FB_TKCLASS_IDENTIFIER
			id = *lexGetText( )
			chain_ = lexGetSymChain( )

		case FB_TKCLASS_QUIRKWD
			'' only if inside another ns
			if( symbIsGlobalNamespc( ) ) then
				errReport( FB_ERRMSG_DUPDEFINITION )
				'' error recovery: fake a symbol
				sym = symbAddNamespace( hMakeTmpStr( ), NULL )
				id[0] = 0							'' id = ""
				chain_ = NULL
			else
				id = *lexGetText( )
				chain_ = lexGetSymChain( )
			end if

		case else
			errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
			'' error recovery: fake a symbol
			sym = symbAddNamespace( hMakeTmpStr( ), NULL )
			id[0] = 0							'' id = ""
			chain_ = NULL
		end select

		'' already defined?
		if( chain_ <> NULL ) then
			sym = chain_->sym
			'' not a namespace?
			if( symbIsNamespace( sym ) = FALSE ) then
				errReportEx( FB_ERRMSG_DUPDEFINITION, id )
				'' error recovery: fake an id
				id = *hMakeTmpStr( )
				sym = NULL
			else
				'' not the same hash tb?
				if( symbGetHashTb( sym ) <> symbGetCurrentHashTb( ) ) then
					'' then it's an inner ns with the same name as an outer one..
					sym = NULL
				end if
			end if
		else
			sym = NULL
		end if

		'' skip ID
		if( id[0] <> 0 ) then
			lexSkipToken( LEXCHECK_NOPERIOD )
		end if

		'' create a new symbol?
		if( sym = NULL ) then
			if( levels = 1 )  then
				'' [ALIAS "id"]
				palias = cAliasAttribute()
			end if

			sym = symbAddNamespace( @id, palias )
			if( sym = NULL ) then
				errReportEx( FB_ERRMSG_DUPDEFINITION, id )
				'' error recovery: fake an id
				sym = symbAddNamespace( hMakeTmpStr( ), NULL )
			end if
		end if

		''
		stk = cCompStmtPush( FB_TK_NAMESPACE, _
						 	 FB_CMPSTMT_MASK_ALL and (not FB_CMPSTMT_MASK_CODE) _
						 					 	 and (not FB_CMPSTMT_MASK_DATA) )

		stk->nspc.node = astNamespaceBegin( sym )
		stk->nspc.levels = 1

		'' ALIAS used?
		if( palias <> NULL ) then
			exit do
		end if

		'' not a '.'?
		if( lexGetToken( ) <> CHAR_DOT ) then
			exit do
		end if

		lexSkipToken( LEXCHECK_NOPERIOD )
	loop

	stk->nspc.levels = levels

	parser.nspcrec += levels

	function = TRUE

end function

'':::::
''NamespaceStmtEnd  =     END NAMESPACE .
''
function cNamespaceStmtEnd as integer
	dim as FB_CMPSTMTSTK ptr stk = any
	dim as integer levels = any

	function = FALSE

	stk = cCompStmtGetTOS( FB_TK_NAMESPACE )
	if( stk = NULL ) then
		exit function
	end if

	'' END NAMESPACE
	lexSkipToken( )
	lexSkipToken( )

	levels = stk->nspc.levels

	parser.nspcrec -= levels

	do while( levels > 0 )
		'' back to parent
		astNamespaceEnd( stk->nspc.node )

		'' pop from stmt stack
		cCompStmtPop( stk )

		stk = cCompStmtGetTOS( FB_TK_NAMESPACE, FALSE )
		if( stk = NULL ) then
			exit do
		end if

		levels -= 1
	loop

	function = TRUE

end function

'':::::
''Usingtmt  =     USING ID (',' ID)*
''
function cUsingStmt as integer
    dim as FBSYMBOL ptr sym = any

    function = FALSE

    if( fbLangOptIsSet( FB_LANG_OPT_NAMESPC ) = FALSE ) then
    	errReportNotAllowed( FB_LANG_OPT_NAMESPC )
    	'' error recovery: skip stmt
    	hSkipStmt( )
    	exit function
    end if

    '' USING
    lexSkipToken( LEXCHECK_NOPERIOD )

    do
    	'' ID
    	sym = cParentId( FB_IDOPT_DONTCHKPERIOD )
    	if( sym = NULL ) then
			if( lexGetToken( ) <> FB_TK_ID ) then
				errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
			else
				errReport( FB_ERRMSG_UNDEFINEDSYMBOL )
			end if

			'' error recovery: skip until next ','
			hSkipUntil( CHAR_COMMA )

    	else
			'' not a namespace?
			if( symbIsNamespace( sym ) = FALSE ) then
				errReport( FB_ERRMSG_TYPEMISMATCH )
			else
    			symbNamespaceImport( sym )
			end if
		end if

    '' ','?
    loop while( hMatch( CHAR_COMMA ) )

    function = TRUE

end function
