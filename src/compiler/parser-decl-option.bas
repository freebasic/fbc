'' option (OPTION) declarations
''
'' chng: sep/2004 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"

declare sub hUndefSymbol()

'' OptDecl  =  OPTION (BYVAL|DYNAMIC|STATIC|GOSUB|EXPLICIT|PRIVATE|ESCAPE|BASE NUM_LIT|NOKEYWORD ...|NOGOSUB)
sub cOptDecl( )
	if( fbLangOptIsSet( FB_LANG_OPT_OPTION ) = FALSE ) then
		errReportNotAllowed( FB_LANG_OPT_OPTION )
		hSkipStmt( )
		exit sub
	end if

	if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_DECL ) = FALSE ) then
		hSkipStmt( )
		exit sub
	end if

	'' OPTION
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	select case as const lexGetToken( )
	case FB_TK_BYVAL
		lexSkipToken( LEXCHECK_POST_SUFFIX )
		env.opt.parammode = FB_PARAMMODE_BYVAL

	case FB_TK_DYNAMIC
		lexSkipToken( LEXCHECK_POST_SUFFIX )
		env.opt.dynamic = TRUE

	case FB_TK_STATIC
		lexSkipToken( LEXCHECK_POST_SUFFIX )
		env.opt.dynamic = FALSE

	case FB_TK_GOSUB
		if( fbLangOptIsSet( FB_LANG_OPT_GOSUB ) = FALSE ) then
			errReportNotAllowed( FB_LANG_OPT_GOSUB )
		else
			env.opt.gosub = TRUE
		end if

		lexSkipToken( LEXCHECK_POST_SUFFIX )

	case else

		'' Search for text match with non-keywords - this
		'' prevents us from having to add them to the namespace

		select case ucase( *lexGetText( ) )
		'' EXPLICIT: Not a keyword in lang qb
		case "EXPLICIT"
			env.opt.explicit = TRUE
			lexSkipToken( LEXCHECK_POST_SUFFIX )

		'' PRIVATE: Ditto
		case "PRIVATE"
			lexSkipToken( LEXCHECK_POST_SUFFIX )
			env.opt.procpublic = FALSE

		case "ESCAPE"
			lexSkipToken( LEXCHECK_POST_SUFFIX )
			env.opt.escapestr = TRUE

		case "BASE"
			lexSkipToken( LEXCHECK_POST_SUFFIX )

			if( lexGetClass( ) <> FB_TKCLASS_NUMLITERAL ) then
				errReport( FB_ERRMSG_SYNTAXERROR )
				'' error recovery: skip stmt
				hSkipStmt( )
			else
				env.opt.base = clng( *lexGetText( ) )
				lexSkipToken( )
			end if

		case "NOKEYWORD"
			lexSkipToken( LEXCHECK_NODEFINE or LEXCHECK_POST_SUFFIX )

			do
				hUndefSymbol()

				'' ','?
				if( lexGetToken( ) <> CHAR_COMMA ) then
					exit do
				end if

				lexSkipToken( LEXCHECK_NODEFINE )
			loop

		case "NOGOSUB"
			if( fbLangOptIsSet( FB_LANG_OPT_GOSUB ) = FALSE ) then
				errReportNotAllowed( FB_LANG_OPT_GOSUB )
			else
				env.opt.gosub = FALSE
			end if

			lexSkipToken( LEXCHECK_POST_SUFFIX )

		case else
			errReport( FB_ERRMSG_SYNTAXERROR )
		end select

	end select
end sub

private sub hUndefSymbol()
	dim s as FBSYMBOL ptr

	select case as const lexGetClass( LEXCHECK_NODEFINE )
	case FB_TKCLASS_KEYWORD, FB_TKCLASS_QUIRKWD
		s = lexGetSymChain( )->sym
		if( s ) then
			'' Forget the symbol so it's no longer found by lookups,
			'' but don't fully delete it, since it might already be used somewhere.
			symbDelFromHash( s )
		else
			errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		end if

		lexSkipToken( )

	case FB_TKCLASS_IDENTIFIER
		'' proc?
		s = symbFindByClass( lexGetSymChain( ), FB_SYMBCLASS_PROC )
		if( s <> NULL ) then
			'' is it from the rtlib (gfxlib will be listed as part of the rt too)?
			if( symbGetIsRTL( s ) = FALSE ) then
				errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
			else
				'' don't remove if it was defined inside any namespace (any
				'' USING ref to that ns would break its linked-list)
				if( symbGetNamespace( s ) <> @symbGetGlobalNamespc( ) ) then
					errReport( FB_ERRMSG_CANTREMOVENAMESPCSYMBOLS )
				else
					if( symbGetCantUndef( s ) ) then
						errReport( FB_ERRMSG_CANTUNDEF )
					else
						symbDelFromHash( s )
					end if
				end if
			end if
		else
			'' macro?
			s = symbFindByClass( lexGetSymChain( ), FB_SYMBCLASS_DEFINE )
			if( s = NULL ) then
				errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
			else
				'' don't remove if it was defined inside any namespace (any
				'' USING ref to that ns would break its linked-list)
				if( symbGetNamespace( s ) <> @symbGetGlobalNamespc( ) ) then
					errReport( FB_ERRMSG_CANTREMOVENAMESPCSYMBOLS )
				else
					if( symbGetCantUndef( s ) ) then
						errReport( FB_ERRMSG_CANTUNDEF )
					else
						symbDelFromHash( s )
					end if
				end if
			end if
		end if

		lexSkipToken( )

	case else
		errReport( FB_ERRMSG_SYNTAXERROR )
		'' error recovery: skip until next ','
		hSkipUntil( CHAR_COMMA )
	end select
end sub
