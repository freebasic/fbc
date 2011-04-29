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


'' quirk storage statements (RESTORE, READ, DATA) parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"

'':::::
''DataStmt   	  =   RESTORE LABEL?
''				  |   READ Variable{int|flt|str} (',' Variable{int|flt|str})*
''				  |   DATA literal|constant (',' literal|constant)*
''
function cDataStmt  _
	( _
		byval tk as FB_TOKEN _
	) as integer

	function = FALSE

	select case tk
	'' RESTORE LABEL?
	case FB_TK_RESTORE
		lexSkipToken( )

		'' LABEL?
		dim as FBSYMBOL ptr sym = NULL
		select case lexGetClass( )
		case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_QUIRKWD, FB_TKCLASS_NUMLITERAL
			dim as FBSYMCHAIN ptr chain_ = any
			dim as FBSYMBOL ptr base_parent = any

			chain_ = cIdentifier( base_parent )
			if( errGetLast( ) <> FB_ERRMSG_OK ) then
				exit function
			end if

			sym = symbFindByClass( chain_, FB_SYMBCLASS_LABEL )
			if( sym = NULL ) then
				sym = symbAddLabel( lexGetText( ), _
									FB_SYMBOPT_MOVETOGLOB or FB_SYMBOPT_CREATEALIAS )
				if( sym = NULL ) then
					if( errReport( FB_ERRMSG_DUPDEFINITION ) = FALSE ) then
						exit function
					else
						hSkipStmt( )
						return TRUE
					end if
				end if
			end if
			lexSkipToken( )
		end select

		function = rtlDataRestore( sym )

	'' READ Variable{int|flt|str} (',' Variable{int|flt|str})*
	case FB_TK_READ
		lexSkipToken( )

		dim as ASTNODE ptr expr = NULL
		do
		    expr = cVarOrDeref(  )
		    if( expr = NULL ) then
		    	if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
		    		exit function
		    	else
		    		hSkipUntil( CHAR_COMMA )
		    	end if

		    else
            	if( rtlDataRead( expr ) = FALSE ) then
            		exit function
            	end if
		    end if

		loop while( hMatch( CHAR_COMMA ) )

		function = TRUE

	'' DATA literal|constant expr (',' literal|constant expr)*
	case FB_TK_DATA

		if( env.clopt.lang <> FB_LANG_QB ) then
			'' allowed?
			if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_DATA ) = FALSE ) then
				exit function
			end if

			'' not in module-level?
			if( parser.scope > FB_MAINSCOPE ) then
				if( fbIsModLevel( ) = FALSE ) then
					errReport( FB_ERRMSG_ILLEGALINSIDEASUB )
				else
					errReport( FB_ERRMSG_ILLEGALINSIDEASCOPE )
				end if

				hSkipStmt( )
				return FALSE
			end if

		else
			'' in QB, DATA can be declared inside compound stmts..
			if( fbIsModLevel( ) = FALSE ) then
				errReport( FB_ERRMSG_ILLEGALINSIDEASUB )

				hSkipStmt( )
				return FALSE
			end if
		end if

		dim as ASTNODE ptr tree = astDataStmtBegin( )

		dim as ASTNODE ptr expr = NULL

		if( env.clopt.lang <> FB_LANG_QB ) then
			lexSkipToken( )

			do
				hMatchExpressionEx( expr, FB_DATATYPE_INTEGER )

				'' not a constant?
				dim as integer isconst = astIsCONST( expr )
				if( isconst = FALSE ) then
					if( astIsOFFSET( expr ) ) then
						isconst = TRUE
					else
						'' not a literal string?
						select case astGetDataType( expr )
						case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
							isconst = astGetStrLitSymbol( expr ) <> NULL
						end select
					end if
				end if

            	if( isconst = FALSE ) then
					if( errReport( FB_ERRMSG_EXPECTEDCONST ) = FALSE ) then
						exit function
					else
						astDelTree( expr )
					end if

				else
            		if( astDataStmtStore( tree, expr ) = NULL ) then
	          			exit function
    	      		end if
				end if

			loop while( hMatch( CHAR_COMMA ) )

		'' qb mode, read tokens as-is, no lookup, no expressions..
		else
			const LEX_FLAGS = LEXCHECK_NOWHITESPC or _
				   		  	  LEXCHECK_NOSUFFIX or _
				   		  	  LEXCHECK_NODEFINE or _
				   		  	  LEXCHECK_NOQUOTES or _
				   		   	  LEXCHECK_NOSYMBOL

			lexSkipToken( LEX_FLAGS )

			dim as integer do_exit = FALSE
			dim as string text

			do
				'' read until a ',' or EOL is found
				dim as integer tokens = 0
				text = ""
				do
					select case as const lexGetToken( LEX_FLAGS )
					case CHAR_COMMA
						lexSkipToken( LEX_FLAGS )
						exit do

					case CHAR_SPACE, CHAR_TAB
						'' don't count white-spaces
						tokens -= 1

					case FB_TK_EOF, FB_TK_EOL, FB_TK_COMMENT, FB_TK_REM, FB_TK_STMTSEP
						do_exit = TRUE
						exit do
					end select

					text += *lexGetText( )
					lexSkipToken( LEX_FLAGS )
					tokens += 1
				loop

				'' trim it (as it could be a literal number)
				text = trim( text )

				'' another quirk: remove the quotes if it's a single token
				if( tokens = 1 ) then
					if( len( text ) > 1 ) then
						if( text[0] = asc( """" ) ) then
							if( text[len( text )-1] = asc( """" ) ) then
								text = mid( text, 2, len( text ) - 2 )
							end if
						end if
					end if
				end if

				if( astDataStmtStore( tree, astNewCONSTstr( text ) ) = NULL ) then
					exit function
				end if
			loop until( do_exit )
		end if

		astDataStmtEnd( tree )

    	'' node is unused, the tree will become an initialized static array
    	astDelNode( tree )

		function = TRUE

	end select

end function

