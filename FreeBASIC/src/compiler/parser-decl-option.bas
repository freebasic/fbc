''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2006 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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

'':::::
''OptDecl         =   OPTION (EXPLICIT|BASE NUM_LIT|BYVAL|PRIVATE|ESCAPE|DYNAMIC|STATIC)
''
function cOptDecl as integer
	dim s as FBSYMBOL ptr

	function = FALSE

    if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_DECL ) = FALSE ) then
    	exit function
    end if

	'' OPTION
	lexSkipToken( )

	select case as const lexGetToken( )
	case FB_TK_EXPLICIT
    	if( fbLangOptIsSet( FB_LANG_OPT_QBOPT ) = FALSE ) then
    		if( errReportNotAllowed( FB_LANG_OPT_QBOPT ) = FALSE ) then
    			exit function
    		end if
    	else
    		env.opt.explicit = TRUE
    	end if

		lexSkipToken( )

	case FB_TK_BASE
    	if( fbLangOptIsSet( FB_LANG_OPT_QBOPT ) = FALSE ) then
    		if( errReportNotAllowed( FB_LANG_OPT_QBOPT ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: skip stmt
    			hSkipStmt( )
    		end if
    	else
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
		end if

	case FB_TK_BYVAL
    	if( fbLangOptIsSet( FB_LANG_OPT_DEPRECTOPT ) = FALSE ) then
    		if( errReportNotAllowed( FB_LANG_OPT_DEPRECTOPT ) = FALSE ) then
    			exit function
        	end if
        else
			env.opt.parammode = FB_PARAMMODE_BYVAL
        end if

		lexSkipToken( )

	case FB_TK_PRIVATE
    	if( fbLangOptIsSet( FB_LANG_OPT_DEPRECTOPT ) = FALSE ) then
    		if( errReportNotAllowed( FB_LANG_OPT_DEPRECTOPT ) = FALSE ) then
    			exit function
        	end if
        else
			env.opt.procpublic = FALSE
		end if

		lexSkipToken( )

	case FB_TK_DYNAMIC
    	if( fbLangOptIsSet( FB_LANG_OPT_DEPRECTOPT ) = FALSE ) then
    		if( errReportNotAllowed( FB_LANG_OPT_DEPRECTOPT ) = FALSE ) then
    			exit function
        	end if
        else
			env.opt.dynamic = TRUE
		end if

		lexSkipToken( )

	case FB_TK_STATIC
    	if( fbLangOptIsSet( FB_LANG_OPT_DEPRECTOPT ) = FALSE ) then
    		if( errReportNotAllowed( FB_LANG_OPT_DEPRECTOPT ) = FALSE ) then
    			exit function
        	end if
        else
			env.opt.dynamic = FALSE
		end if

		lexSkipToken( )

	case else

   		if( fbLangOptIsSet( FB_LANG_OPT_DEPRECTOPT ) = FALSE ) then
  			if( errReportNotAllowed( FB_LANG_OPT_DEPRECTOPT ) = FALSE ) then
   				exit function
       		else
       			'' error recovery: skip stmt
       			hSkipStmt( )
       			return TRUE
       		end if
       	end if

		select case ucase( *lexGetText( ) )
		'' ESCAPE? (it's not a reserved word, there are too many already..)
		case "ESCAPE"
			lexSkipToken( )
			env.opt.escapestr = TRUE

		'' NOKEYWORD? (ditto..)
		case "NOKEYWORD"
			lexSkipToken( LEXCHECK_NODEFINE )

			do
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
								symbDelPrototype( s )
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
								symbDelDefine( s )
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

				'' ','?
				if( lexGetToken( ) <> CHAR_COMMA ) then
					exit do
				end if

				lexSkipToken( LEXCHECK_NODEFINE )
			loop

		case else
			if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
				exit function
			end if
		end select

	end select

	function = TRUE

end function

