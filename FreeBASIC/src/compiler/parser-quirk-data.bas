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
	) as integer static

	dim as ASTNODE ptr expr
	dim as FBSYMBOL ptr litsym, sym
	dim as string littext
	dim as FBSYMCHAIN ptr chain_

	function = FALSE

	select case tk
	'' RESTORE LABEL?
	case FB_TK_RESTORE
		lexSkipToken( )

		'' LABEL?
		sym = NULL
		select case lexGetClass( )
		case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_QUIRKWD, FB_TKCLASS_NUMLITERAL
			chain_ = cIdentifier( )
			if( errGetLast( ) <> FB_ERRMSG_OK ) then
				exit function
			end if

			sym = symbFindByClass( chain_, FB_SYMBCLASS_LABEL )
			if( sym = NULL ) then
				sym = symbAddLabel( lexGetText( ), FALSE, TRUE )
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

		lexSkipToken( )

		rtlDataStoreBegin( )

		do
			hMatchExpressionEx( expr, FB_DATATYPE_INTEGER )

			'' check if it's an string
			litsym = NULL
			select case astGetDataType( expr )
			case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
				litsym = astGetStrLitSymbol( expr )
			end select

			'' string?
			if( litsym <> NULL ) then
                '' not a wstring?
                if( astGetDataType( expr ) <> FB_DATATYPE_WCHAR ) then
            		if( rtlDataStore( symbGetVarLitText( litsym ), _
            						  symbGetStrLen( litsym ) - 1, _ '' less the null-char
            						  FB_DATATYPE_CHAR ) = FALSE ) then
	            		exit function
    	        	end if

    	        '' wstring..
    	        else
            		if( rtlDataStoreW( symbGetVarLitTextW( litsym ), _
            						   symbGetWstrLen( litsym ) - 1, _ '' ditto
            						   FB_DATATYPE_WCHAR ) = FALSE ) then
	            		exit function
    	        	end if

    	        end if

			'' scalar..
			else
				'' address of?
				if( astIsOFFSET( expr ) ) then
            		if( rtlDataStoreOFS( astGetSymbol( expr ) ) = FALSE ) then
	            		exit function
    	        	end if

				else
					'' not a constant?
					if( astIsCONST( expr ) = FALSE ) then
						if( errReport( FB_ERRMSG_EXPECTEDCONST ) = FALSE ) then
							exit function
						end if

					else
            			littext = astGetValueAsStr( expr )
            			if( rtlDataStore( littext, _
            						  	  len( littext ), _
            						  	  FB_DATATYPE_CHAR ) = FALSE ) then
	            			exit function
    	        		end if
					end if
  				end if

		    end if

			astDelNode( expr )

		loop while( hMatch( CHAR_COMMA ) )

		rtlDataStoreEnd( )

		function = TRUE

	end select

end function

