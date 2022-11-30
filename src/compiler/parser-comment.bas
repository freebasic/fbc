'' comments (REM or "'") and directives ("$") parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"

#define LEX_FLAGS (LEXCHECK_NOLINECONT or LEXCHECK_NODEFINE or LEXCHECK_NOSUFFIX or LEXCHECK_NOMULTILINECOMMENT)

declare sub cDirective( )

'':::::
''Comment         =   (COMMENT_CHAR | REM) ((DIRECTIVE_CHAR Directive)
''                                            |   (any_char_but_EOL*)) .
''
function cComment _
	( _
		byval lexflags as LEXCHECK _
	) as integer

	select case lexGetToken( lexflags )
	case FB_TK_COMMENT, FB_TK_REM

		'' lang qb quirks
		if( lexGetToken( lexflags ) = FB_TK_REM ) then
			if( fbLangIsSet( FB_LANG_QB ) ) then
				'' suffix?
				'' in QB only '$' was allowed, fbc allows REM[$ % ! & #]
				'' for a variable in qb mode.  To restrict to '$' only
				'' as in QB, then would need to check FB_TK_STRTYPECHAR
				'' below, plus update the parser code that deals with
				'' suffixes on variables.
				if( lexGetSuffixChar() <> CHAR_NULL ) then
					return FALSE
				end if
			end if
		end if

		'' Prevent the PP from trying to parse (pointless in a comment
		'' anyways), and -pp from emitting the tokens (specifically due
		'' to the lexSkipToken() calls for '$' and from cDirective(),
		'' when parsing a $ meta command)
		lex.ctx->reclevel += 1
		lexSkipToken( LEX_FLAGS )
		if( lexGetToken( LEX_FLAGS ) = FB_TK_DIRECTIVECHAR ) then
			lexSkipToken( LEX_FLAGS )
			cDirective( )
		else
			lexSkipLine( )
		end if

		lex.ctx->reclevel -= 1
		function = TRUE

	case else
		function = FALSE
	end select

end function

'':::::
''Directive       =   INCLUDE ONCE? ':' '\'' STR_LIT '\''
''                |   DYNAMIC
''                |   STATIC .
''                |   LANG ':' '\"' STR_LIT '\"'
''
private sub cDirective( ) static
	static as zstring * FB_MAXPATHLEN+1 incfile
	dim as integer isonce

	select case as const lexGetToken( )
	case FB_TK_DYNAMIC
		if( fbLangOptIsSet( FB_LANG_OPT_METACMD ) = FALSE ) then
		    errReportNotAllowed( FB_LANG_OPT_METACMD )
		else
			'' DYNAMIC
			lexSkipToken( )
			env.opt.dynamic = TRUE

			'' Preserve under -pp
			if( env.ppfile_num > 0 ) then
				lexPPOnlyEmitText( "'$dynamic" )
			end if
		end if


	case FB_TK_STATIC
		if( fbLangOptIsSet( FB_LANG_OPT_METACMD ) = FALSE ) then
		    errReportNotAllowed( FB_LANG_OPT_METACMD )
		else
			'' STATIC
			lexSkipToken( )
			env.opt.dynamic = FALSE

			'' Preserve under -pp
			if( env.ppfile_num > 0 ) then
				lexPPOnlyEmitText( "'$static" )
			end if
		end if

	case FB_TK_INCLUDE
		if( fbLangOptIsSet( FB_LANG_OPT_METACMD ) = FALSE ) then
		    errReportNotAllowed( FB_LANG_OPT_METACMD )
		else
			lexSkipToken( )

			'' ONCE?
			isonce = hMatchIdOrKw( "ONCE", LEXCHECK_POST_SUFFIX )

			'' ':'
			if( hMatch( FB_TK_STMTSEP ) = FALSE ) then
				errReport( FB_ERRMSG_SYNTAXERROR )
				exit select
			end if

			'' "STR_LIT"
			if( lexGetClass( ) = FB_TKCLASS_STRLITERAL ) then
				lexEatToken( incfile )

			else
				'' '\''
				if( lexGetToken( LEX_FLAGS or LEXCHECK_NOWHITESPC ) <> FB_TK_COMMENT ) then
					errReport( FB_ERRMSG_SYNTAXERROR )
					exit select
				else
					lexSkipToken( LEX_FLAGS or LEXCHECK_NOWHITESPC )
				end if

				lexReadLine( CHAR_APOST, @incfile )

				'' '\''
				if( hMatch( CHAR_APOST ) = FALSE ) then
					errReport( FB_ERRMSG_SYNTAXERROR )
					exit select
				end if
			end if

			fbIncludeFile( incfile, isonce )
		end if

	case else
		select case lexGetClass( )
		case FB_TKCLASS_KEYWORD, FB_TKCLASS_QUIRKWD
			if( fbLangOptIsSet( FB_LANG_OPT_METACMD ) ) then
				errReport( FB_ERRMSG_SYNTAXERROR )
			end if

		case else
			'' Special case, allow $LANG metacommand in all dialects
			if( hMatchIdOrKw( "LANG" ) ) then

				'' ':'
				if( hMatch( FB_TK_STMTSEP ) = FALSE ) then
					errReport( FB_ERRMSG_EXPECTEDSTMTSEP, TRUE )
					exit select
				end if

				'' "STR_LIT"
				if( lexGetClass( ) = FB_TKCLASS_STRLITERAL ) then
					dim as FB_LANG id = any

					lexEatToken( incfile )

					id = fbGetLangId( @incfile )

					if( id = FB_LANG_INVALID ) then
						errReport( FB_ERRMSG_INVALIDLANG )
					else
						fbChangeOption( FB_COMPOPT_LANG, id )

						'' Preserve under -pp
						if( env.ppfile_num > 0 ) then
							lexPPOnlyEmitText( "'$lang: """ + fbGetLangName( id ) + """" )
						end if
					end if
				else
					errReport( FB_ERRMSG_SYNTAXERROR )
				end if
			end if
		end select
	end select

	'' skip until next line
	do
		select case lexGetToken( )
		case FB_TK_EOL, FB_TK_EOF
			exit do
		end select
		lexSkipToken( LEX_FLAGS )
	loop
end sub
