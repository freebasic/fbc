''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2007 The FreeBASIC development team.
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
			dim as FBSYMCHAIN ptr chain_ = cIdentifier( )
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
		    if( cVarOrDeref( expr ) = FALSE ) then
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

			return FALSE
		end if

		lexSkipToken( )

		dim as ASTNODE ptr tree = astDataStmtBegin( )

		dim as ASTNODE ptr expr = NULL
		do
			hMatchExpressionEx( expr, FB_DATATYPE_INTEGER )

			'' not a constant?
			dim as integer isconst = astIsCONST( expr )
			if( isconst = FALSE ) then
				'' not a literal string?
				select case astGetDataType( expr )
				case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
					isconst = astGetStrLitSymbol( expr ) <> NULL
				end select
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

		astDataStmtEnd( tree )

    	'' node is unused, the tree will become an initialized static array
    	astDelNode( tree )

		function = TRUE

	end select

end function

