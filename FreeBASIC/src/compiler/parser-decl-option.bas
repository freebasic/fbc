''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2011 The FreeBASIC development team.
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


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"

declare function hUndefSymbol( ) as integer

'':::::
''OptDecl         =   OPTION (BYVAL|DYNAMIC|STATIC|GOSUB|EXPLICIT|PRIVATE|ESCAPE|BASE NUM_LIT|NOKEYWORD ...|NOGOSUB)
''
function cOptDecl as integer

	function = FALSE

	if( fbLangOptIsSet( FB_LANG_OPT_OPTION ) = FALSE ) then
		if( errReportNotAllowed( FB_LANG_OPT_OPTION ) = FALSE ) then
			exit function
		end if
	end if

    if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_DECL ) = FALSE ) then
    	exit function
    end if

	'' OPTION
	lexSkipToken( )

	select case as const lexGetToken( )
	case FB_TK_BYVAL
		lexSkipToken( )
		env.opt.parammode = FB_PARAMMODE_BYVAL

	case FB_TK_DYNAMIC
		lexSkipToken( )
		env.opt.dynamic = TRUE

	case FB_TK_STATIC
		lexSkipToken( )
		env.opt.dynamic = FALSE

	case FB_TK_GOSUB
		if( fbLangOptIsSet( FB_LANG_OPT_GOSUB ) = FALSE ) then
			if( errReportNotAllowed( FB_LANG_OPT_GOSUB ) = FALSE ) then
				exit function
			end if
		else
			env.opt.gosub = TRUE
		end if

		lexSkipToken( )

	case else

		'' Search for text match with non-keywords - this
		'' prevents us from having to add them to the namespace

		select case ucase( *lexGetText( ) )
		'' EXPLICIT: Not a keyword in lang qb
		case "EXPLICIT"
			env.opt.explicit = TRUE
			lexSkipToken( )

		'' PRIVATE: Ditto
		case "PRIVATE"
			lexSkipToken( )
			env.opt.procpublic = FALSE

		case "ESCAPE"
			lexSkipToken( )
			env.opt.escapestr = TRUE

		case "BASE"
			lexSkipToken( )

			if( lexGetClass( ) <> FB_TKCLASS_NUMLITERAL ) then
				if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
					exit function
				else
					'' error recovery: skip stmt
					hSkipStmt( )
				end if
			else
				env.opt.base = valint( *lexGetText( ) )
				lexSkipToken( )
			end if

		case "NOKEYWORD"
			lexSkipToken( LEXCHECK_NODEFINE )

			do
                if( hUndefSymbol( ) = FALSE ) then
                	exit function
                end if

				'' ','?
				if( lexGetToken( ) <> CHAR_COMMA ) then
					exit do
				end if

				lexSkipToken( LEXCHECK_NODEFINE )
			loop

		case "NOGOSUB"
			if( fbLangOptIsSet( FB_LANG_OPT_GOSUB ) = FALSE ) then
				if( errReportNotAllowed( FB_LANG_OPT_GOSUB ) = FALSE ) then
					exit function
				end if
			else
				env.opt.gosub = FALSE
			end if

			lexSkipToken( )

		case else
			if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
				exit function
			end if
		end select

	end select

	function = TRUE

end function

'':::::
private function hUndefSymbol( ) as integer
	dim s as FBSYMBOL ptr

	function = FALSE

	select case as const lexGetClass( LEXCHECK_NODEFINE )
	case FB_TKCLASS_KEYWORD, FB_TKCLASS_QUIRKWD
		if( symbDelKeyword( lexGetSymChain( )->sym ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
				exit function
			end if
		end if

		lexSkipToken( )

	case FB_TKCLASS_IDENTIFIER
		'' proc?
		s = symbFindByClass( lexGetSymChain( ), FB_SYMBCLASS_PROC )
		if( s <> NULL ) then

			'' is it from the rtlib (gfxlib will be listed as part of the rt too)?
			if( symbGetIsRTL( s ) = FALSE ) then
				if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
					exit function
				end if

			else
				'' don't remove if it was defined inside any namespace (any
				'' USING ref to that ns would break its linked-list)
				if( symbGetNamespace( s ) <> @symbGetGlobalNamespc( ) ) then
					if( errReport( FB_ERRMSG_CANTREMOVENAMESPCSYMBOLS ) = FALSE ) then
						exit function
					end if

				else
					if( symbGetCantUndef( s ) ) then
						if( errReport( FB_ERRMSG_CANTUNDEF ) = FALSE ) then
							exit function
						end if
					else
						symbDelPrototype( s )
					end if
				end if
			end if

		else
			'' macro?
			s = symbFindByClass( lexGetSymChain( ), FB_SYMBCLASS_DEFINE )
			if( s = NULL ) then
				if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
					exit function
				end if

			else
				'' don't remove if it was defined inside any namespace (any
				'' USING ref to that ns would break its linked-list)
				if( symbGetNamespace( s ) <> @symbGetGlobalNamespc( ) ) then
					if( errReport( FB_ERRMSG_CANTREMOVENAMESPCSYMBOLS ) = FALSE ) then
						exit function
					end if

				else
					if( symbGetCantUndef( s ) ) then
						if( errReport( FB_ERRMSG_CANTUNDEF ) = FALSE ) then
							exit function
						end if
					else
						symbDelDefine( s )
					end if
				end if
			end if

		end if

		lexSkipToken( )

	case else
		if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
			exit function
		else
			'' error recovery: skip until next ','
			hSkipUntil( CHAR_COMMA )
		end if
	end select

	function = TRUE

end function
