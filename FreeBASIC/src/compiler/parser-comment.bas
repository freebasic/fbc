''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2008 The FreeBASIC development team.
''
''	This program is free software; you can redistribute it and/or modify
''	it under the terms of the GNU General Public License as published by
''	the Free Software Foundation; either version 2 of the License, or
''	(at your option) any later version.
''
''	This program is distributed in the hope that it will be useful,
''	but WITHOUT ANY WARRANTY; without even the implied warranty of
''	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''	GNU General Public License for more details.
''
''	You should have received a copy of the GNU General Public License
''	along with this program; if not, write to the Free Software
''	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.


'' comments (REM or "'") and directives ("$") parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"

#define LEX_FLAGS (LEXCHECK_NOLINECONT or LEXCHECK_NODEFINE or LEXCHECK_NOSUFFIX or LEXCHECK_NOMULTILINECOMMENT)

'':::::
''Comment         =   (COMMENT_CHAR | REM) ((DIRECTIVE_CHAR Directive)
''				                              |   (any_char_but_EOL*)) .
''
function cComment _
	( _
		byval lexflags as LEXCHECK _
	) as integer

	select case lexGetToken( lexflags )
	case FB_TK_COMMENT, FB_TK_REM
    	lexSkipToken( LEX_FLAGS )

    	if( lexGetToken( LEX_FLAGS ) = FB_TK_DIRECTIVECHAR ) then
    		lexSkipToken( LEX_FLAGS )
    		function = cDirective( )
    	else
    		lexSkipLine( )
    		function = TRUE
    	end if

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
function cDirective as integer static
    static as zstring * FB_MAXPATHLEN+1 incfile
    dim as integer isonce

	function = FALSE

	select case as const lexGetToken( )
	case FB_TK_DYNAMIC
		if( fbLangOptIsSet( FB_LANG_OPT_METACMD ) = FALSE ) then
		    errReportNotAllowed( FB_LANG_OPT_METACMD )
		else
			lexSkipToken( )
			env.opt.dynamic = TRUE
			function = TRUE
		end if


	case FB_TK_STATIC
		if( fbLangOptIsSet( FB_LANG_OPT_METACMD ) = FALSE ) then
		    errReportNotAllowed( FB_LANG_OPT_METACMD )
		else
			lexSkipToken( )
			env.opt.dynamic = FALSE
			function = TRUE
		end if

	case FB_TK_INCLUDE
		if( fbLangOptIsSet( FB_LANG_OPT_METACMD ) = FALSE ) then
		    errReportNotAllowed( FB_LANG_OPT_METACMD )
		else
			lexSkipToken( )

			'' ONCE?
			isonce = FALSE
			if( hMatchText( "ONCE" ) ) then
				isonce = TRUE
			end if

			'' ':'
			if( hMatch( FB_TK_STMTSEP ) = FALSE ) then
				function = errReport( FB_ERRMSG_SYNTAXERROR )
				exit select
			end if

			'' "STR_LIT"
			if( lexGetClass( ) = FB_TKCLASS_STRLITERAL ) then
				lexEatToken( incfile )

			else
				'' '\''
				if( lexGetToken( LEX_FLAGS or LEXCHECK_NOWHITESPC ) <> FB_TK_COMMENT ) then
					function = errReport( FB_ERRMSG_SYNTAXERROR )
					exit select
				else
					lexSkipToken( LEX_FLAGS or LEXCHECK_NOWHITESPC )
				end if

				lexReadLine( CHAR_APOST, @incfile )

				'' '\''
				if( hMatch( CHAR_APOST ) = FALSE ) then
					function = errReport( FB_ERRMSG_SYNTAXERROR )
					exit select
				end if
			end if

			function = fbIncludeFile( incfile, isonce )
		end if

	case else
		select case lexGetClass( )
		case FB_TKCLASS_KEYWORD, FB_TKCLASS_QUIRKWD
			if( fbLangOptIsSet( FB_LANG_OPT_METACMD ) ) then
				function = errReport( FB_ERRMSG_SYNTAXERROR )
			end if
		
		case else
			'' Special case, allow $LANG metacommand in all dialects
			if( hMatchText( "LANG" ) ) then

				'' ':'
				if( hMatch( FB_TK_STMTSEP ) = FALSE ) then
					function = errReport( FB_ERRMSG_EXPECTEDSTMTSEP, TRUE )
					exit select
				end if

				'' "STR_LIT"
				if( lexGetClass( ) = FB_TKCLASS_STRLITERAL ) then
					dim as FB_LANG id = any

					lexEatToken( incfile )

					id = fbGetLangId( @incfile )

					if( id = FB_LANG_INVALID ) then
						function = errReport( FB_ERRMSG_INVALIDLANG )

					else
						'' fbChangeOption will return FALSE if we should stop 
						'' parsing and TRUE if we should continue.

						function = fbChangeOption( FB_COMPOPT_LANG, id )

					end if

				else
					function = errReport( FB_ERRMSG_SYNTAXERROR )

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

		lexSkipToken( )
	loop

end function

