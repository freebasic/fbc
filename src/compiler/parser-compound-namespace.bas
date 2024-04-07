'' NAMESPACE..END NAMESPACE compound statement parsing
''
'' chng: may/2006 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

private sub namespaceBegin _
	( _
		byval stk as FB_CMPSTMTSTK ptr, _
		byval sym as FBSYMBOL ptr _
	)

	if( sym = NULL ) then
		'' Fake id for anonymous namespaces or error recovery
		sym = symbAddNamespace( symbUniqueLabel( ), NULL )
	end if

	stk->nspc.sym = sym
	stk->nspc.levels = 1

	symbNestBegin( sym, FALSE )
end sub

'' NamespaceStmtBegin  =  NAMESPACE (ID (ALIAS LITSTR)?)? .
sub cNamespaceStmtBegin( )
	static as zstring * FB_MAXNAMELEN+1 id
	dim as zstring ptr palias = any
	dim as FBSYMBOL ptr sym = any
	dim as FBSYMCHAIN ptr chain_ = any
	dim as FB_CMPSTMTSTK ptr stk = any
	dim as integer levels = any

	if( fbLangOptIsSet( FB_LANG_OPT_NAMESPC ) = FALSE ) then
		errReportNotAllowed(FB_LANG_OPT_NAMESPC )
		'' error recovery: skip the whole compound stmt
		hSkipCompound( FB_TK_NAMESPACE )
		exit sub
	end if

	if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_NAMESPC ) = FALSE ) then
		'' error recovery: skip the whole compound stmt
		hSkipCompound( FB_TK_NAMESPACE )
		exit sub
	end if

	'' skip NAMESPACE
	lexSkipToken( LEXCHECK_NOPERIOD or LEXCHECK_POST_SUFFIX )

	'' ID?
	palias = NULL

	select case as const lexGetToken( )
	'' COMMENT|NEWLINE?
	case FB_TK_COMMENT, FB_TK_REM, FB_TK_EOL, FB_TK_EOF, FB_TK_STMTSEP
		'' Anonymous namespace
		stk = cCompStmtPush(FB_TK_NAMESPACE, _
		                    FB_CMPSTMT_MASK_ALL and (not FB_CMPSTMT_MASK_CODE) _
		                                        and (not FB_CMPSTMT_MASK_EXTERN) _
		                                        and (not FB_CMPSTMT_MASK_DATA))
		namespaceBegin(stk, NULL)
		exit sub
	end select

	levels = 0
	do
		if( parser.nspcrec + levels >= FB_MAXNAMESPCRECLEVEL ) then
			errReport( FB_ERRMSG_RECLEVELTOODEEP )
			exit sub
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
				id[0] = 0                       '' id = ""
				chain_ = NULL
			else
				id = *lexGetText( )
				chain_ = lexGetSymChain( )
			end if

		case else
			errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
			id[0] = 0                           '' id = ""
			chain_ = NULL
		end select

		'' already defined?
		if( chain_ <> NULL ) then
			sym = chain_->sym
			'' not a namespace?
			if( symbIsNamespace( sym ) = FALSE ) then
				errReportEx( FB_ERRMSG_DUPDEFINITION, id )
				'' error recovery: fake an id
				id = *symbUniqueLabel( )
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
			lexSkipToken( LEXCHECK_NOPERIOD or LEXCHECK_POST_SUFFIX )
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
			end if
		end if

		stk = cCompStmtPush(FB_TK_NAMESPACE, _
		                    FB_CMPSTMT_MASK_ALL and (not FB_CMPSTMT_MASK_CODE) _
		                                        and (not FB_CMPSTMT_MASK_DATA))
		namespaceBegin(stk, sym)

		'' ALIAS used?
		if( palias <> NULL ) then
			exit do
		end if

		'' not a '.'?
		if( lexGetToken( ) <> CHAR_DOT ) then
			exit do
		end if

		'' '.'
		lexSkipToken( LEXCHECK_NOPERIOD )
	loop

	'' The new top namespace entry on the stack is used to hold the number
	'' of entries for nested namespaces (from <.nested1.nested2...>
	'' following the "main" namespace block's id) that need to be popped
	'' to reach the entry representing the actual namespace compound block.
	stk->nspc.levels = levels
	parser.nspcrec += levels
end sub

'' NamespaceStmtEnd  =  END NAMESPACE .
sub cNamespaceStmtEnd( )
	dim as FB_CMPSTMTSTK ptr stk = any
	dim as integer levels = any

	stk = cCompStmtGetTOS( FB_TK_NAMESPACE )
	if( stk = NULL ) then
		hSkipStmt( )
		exit sub
	end if

	'' END NAMESPACE
	lexSkipToken( LEXCHECK_POST_SUFFIX )
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	levels = stk->nspc.levels

	parser.nspcrec -= levels

	do while( levels > 0 )
		'' back to parent
		symbNestEnd( FALSE )

		'' reimplementation?
		dim as FBSYMBOL ptr ns = stk->nspc.sym
		symbGetNamespaceCnt( ns ) += 1
		if( symbGetNamespaceCnt( ns ) > 1 ) then
			symbNamespaceReImport( ns )
		end if
		symbGetNamespaceLastTail( ns ) = symbGetCompSymbTb( ns ).tail

		'' pop from stmt stack
		cCompStmtPop( stk )

		stk = cCompStmtGetTOS( FB_TK_NAMESPACE, FALSE )
		if( stk = NULL ) then
			exit do
		end if

		levels -= 1
	loop
end sub

'' Usingtmt  =  USING ID (',' ID)*
sub cUsingStmt( )
	dim as FBSYMBOL ptr sym = any

	if( fbLangOptIsSet( FB_LANG_OPT_NAMESPC ) = FALSE ) then
		errReportNotAllowed( FB_LANG_OPT_NAMESPC )
		'' error recovery: skip stmt
		hSkipStmt( )
		exit sub
	end if

	'' USING
	lexSkipToken( LEXCHECK_NOPERIOD or LEXCHECK_POST_SUFFIX )

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
end sub
