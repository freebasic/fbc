''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"

'':::::
''Comment         =   (COMMENT_CHAR | REM) ((DIRECTIVE_CHAR Directive)
''				                              |   (any_char_but_EOL*)) .
''
function cComment( byval lexflags as LEXCHECK_ENUM ) as integer

	select case lexGetToken( lexflags )
	case FB_TK_COMMENTCHAR, FB_TK_REM
    	lexSkipToken( LEXCHECK_NOLINECONT or LEXCHECK_NODEFINE )

    	if( lexGetToken( LEXCHECK_NOLINECONT or LEXCHECK_NODEFINE ) = FB_TK_DIRECTIVECHAR ) then
    		lexSkipToken( LEXCHECK_NOLINECONT or LEXCHECK_NODEFINE )
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
''				  |   INCLIB ':' '\'' STR_LIT '\''
''				  |   LIBPATH ':' '\'' STR_LIT '\''
''				  |   DYNAMIC
''				  |   STATIC .
''
function cDirective as integer static
    static as zstring * FB_MAXPATHLEN+1 incfile
    dim as integer isonce, token

	function = FALSE

	select case as const lexGetToken( )
	case FB_TK_DYNAMIC
		lexSkipToken( )
		env.opt.dynamic = TRUE
		function = TRUE

	case FB_TK_STATIC
		lexSkipToken( )
		env.opt.dynamic = FALSE
		function = TRUE

	case FB_TK_INCLUDE, FB_TK_INCLIB, FB_TK_LIBPATH

		token = lexGetToken( )
		lexSkipToken( )

		'' ONCE?
		isonce = FALSE
		if( ucase( *lexGetText( ) ) = "ONCE" ) then
			lexSkipToken( )
			isonce = TRUE
		end if

		'' ':'
		if( not hMatch( CHAR_COLON ) ) then
			hReportError( FB_ERRMSG_SYNTAXERROR )
			exit function
		end if

		'' "STR_LIT"
		if( lexGetClass( ) = FB_TKCLASS_STRLITERAL ) then
			lexEatToken( incfile )
			if( env.opt.escapestr ) then
				incfile = *hUnescapeStr( incfile )
			end if

		else
			'' '\''
			if( lexGetToken( LEXCHECK_NOLINECONT or LEXCHECK_NODEFINE or LEXCHECK_NOWHITESPC ) <> CHAR_APOST ) then
				hReportError( FB_ERRMSG_SYNTAXERROR )
				exit function
			else
				lexSkipToken( LEXCHECK_NOLINECONT or LEXCHECK_NODEFINE or LEXCHECK_NOWHITESPC )
			end if

			lexReadLine( CHAR_APOST, incfile )

			'' '\''
			if( not hMatch( CHAR_APOST ) ) then
				hReportError( FB_ERRMSG_SYNTAXERROR )
				exit function
			end if
		end if

		select case token
		case FB_TK_INCLUDE
			function = fbIncludeFile( incfile, isonce )
		case FB_TK_INCLIB
			function = symbAddLib( incfile ) <> NULL
		case FB_TK_LIBPATH
			function = fbAddLibPath( incfile )
		end select

	case else
		if( lexGetClass( ) = FB_TKCLASS_KEYWORD ) then
			hReportError( FB_ERRMSG_SYNTAXERROR )
			exit function
		end if
	end select

	do until( (lexGetToken( ) = FB_TK_EOL) or (lexGetToken( ) = FB_TK_EOF) )
		lexSkipToken( )
	loop

end function

