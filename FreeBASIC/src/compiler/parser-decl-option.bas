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


'' option (OPTION) declarations
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"

'':::::
''OptDecl         =   OPTION (EXPLICIT|BASE NUM_LIT|BYVAL|PRIVATE|ESCAPE|DYNAMIC|STATIC)
''
function cOptDecl as integer
	dim s as FBSYMBOL ptr

	function = FALSE

	'' OPTION
	lexSkipToken( )

	select case as const lexGetToken( )
	case FB_TK_EXPLICIT
		lexSkipToken( )
		env.opt.explicit = TRUE

	case FB_TK_BASE
		lexSkipToken( )
		if( lexGetClass( ) <> FB_TKCLASS_NUMLITERAL ) then
			hReportError( FB_ERRMSG_SYNTAXERROR )
			exit function
		end if
		env.opt.base = valint( *lexGetText( ) )
		lexSkipToken( )

	case FB_TK_BYVAL
		lexSkipToken( )
		env.opt.argmode = FB_ARGMODE_BYVAL

	case FB_TK_PRIVATE
		lexSkipToken( )
		env.opt.procpublic = FALSE

	case FB_TK_DYNAMIC
		lexSkipToken( )
		env.opt.dynamic = TRUE

	case FB_TK_STATIC
		lexSkipToken( )
		env.opt.dynamic = FALSE

	case else

		'' ESCAPE? (it's not a reserved word, there are too many already..)
		select case ucase$( *lexGetText( ) )
		case "ESCAPE"
			lexSkipToken( )
			env.opt.escapestr = TRUE

		'' NOKEYWORD? (ditto..)
		case "NOKEYWORD"
			lexSkipToken( LEXCHECK_NODEFINE )

			do
				select case lexGetClass( LEXCHECK_NODEFINE )
				case FB_TKCLASS_KEYWORD
					if( symbDelKeyword( lexGetSymbol ) = FALSE ) then
						hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
						exit function
					end if

					lexSkipToken( )

				case FB_TKCLASS_IDENTIFIER
					'' proc?
					s = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_PROC )
					if( s <> NULL ) then

						'' is it from the rtlib (gfxlib will be listed as part of the rt too)?
						if( symbGetProcIsRTL( s ) = FALSE ) then
							hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
							exit function
						end if

						symbDelPrototype( s )
					else

						'' macro?
						s = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_DEFINE )
						if( s = NULL ) then
							hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
							exit function
						end if

						symbDelDefine( s )
					end if

					lexSkipToken( )

				case else
					hReportError( FB_ERRMSG_SYNTAXERROR )
					exit function
				end select

				'' ','?
				if( lexGetToken( ) <> CHAR_COMMA ) then
					exit do
				else
					lexSkipToken( LEXCHECK_NODEFINE )
				end if

			loop

		case else
			hReportError( FB_ERRMSG_SYNTAXERROR )
			exit function
		end select

	end select

	function = TRUE

end function

