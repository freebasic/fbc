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


'' quirk storage statements (RESTORE, READ, DATA) parsing
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

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
function cDataStmt as integer static
	dim as ASTNODE ptr expr
	dim as FBSYMBOL ptr litsym, sym
	dim as string littext

	function = FALSE

	select case lexGetToken( )
	'' RESTORE LABEL?
	case FB_TK_RESTORE
		lexSkipToken( )

		'' LABEL?
		sym = NULL
		select case lexGetClass( )
		case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_NUMLITERAL
			sym = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_LABEL )
			if( sym = NULL ) then
				sym = symbAddLabel( lexGetText( ), FALSE, TRUE )
				if( sym = NULL ) then
					hReportError( FB_ERRMSG_DUPDEFINITION )
					exit function
				end if
			end if
			lexSkipToken( )
		end select

		function = rtlDataRestore( sym )

	'' READ Variable{int|flt|str} (',' Variable{int|flt|str})*
	case FB_TK_READ
		lexSkipToken( )

		do
		    if( not cVarOrDeref( expr ) ) then
		    	hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
		    	exit function
		    end if

            if( not rtlDataRead( expr ) ) then
            	exit function
            end if

		loop while( hMatch( CHAR_COMMA ) )

		function = TRUE

	'' DATA literal|constant expr (',' literal|constant expr)*
	case FB_TK_DATA

		'' not allowed if inside an scope block
		if( env.scope > 0 ) then
			if( env.lastcompound = FB_TK_SCOPE ) then
				hReportError( FB_ERRMSG_ILLEGALINSIDEASCOPE )
				exit function
			end if
		end if

		lexSkipToken( )

		rtlDataStoreBegin( )

		do
			hMatchExpression( expr )

			'' check if it's an string
			litsym = NULL
			select case astGetDataType( expr )
			case IR_DATATYPE_CHAR, IR_DATATYPE_WCHAR
				litsym = astGetStrLitSymbol( expr )
			end select

			'' string?
			if( litsym <> NULL ) then
                '' not a wstring?
                if( astGetDataType( expr ) <> IR_DATATYPE_WCHAR ) then
            		if( not rtlDataStore( symbGetVarText( litsym ), _
            							  symbGetStrLen( litsym ) - 1, _ '' less the null-char
            							  IR_DATATYPE_CHAR ) ) then
	            		exit function
    	        	end if

    	        '' wstring..
    	        else
            		if( not rtlDataStoreW( symbGetVarTextW( litsym ), _
            							   symbGetWstrLen( litsym ) - 1, _ '' ditto
            							   IR_DATATYPE_WCHAR ) ) then
	            		exit function
    	        	end if

    	        end if

			'' scalar..
			else
				'' address of?
				if( astIsOFFSET( expr ) ) then
            		if( not rtlDataStoreOFS( astGetSymbol( expr ) ) ) then
	            		exit function
    	        	end if

				else
					'' not a constant?
					if( not astIsCONST( expr ) ) then
						hReportError( FB_ERRMSG_EXPECTEDCONST )
						exit function
					end if

            		littext = astGetValueAsStr( expr )
            		if( not rtlDataStore( littext, _
            							  len( littext ), _
            							  IR_DATATYPE_CHAR ) ) then
	            		exit function
    	        	end if

  				end if

		    end if

			astDel( expr )

		loop while( hMatch( CHAR_COMMA ) )

		rtlDataStoreEnd( )

		function = TRUE

	end select

end function

