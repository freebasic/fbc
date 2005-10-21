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
	dim as integer typ, litlen
	dim as FBSYMBOL ptr s
	static as zstring * FB_MAXLITLEN+1 littext

	function = FALSE

	select case lexGetToken( )
	'' RESTORE LABEL?
	case FB_TK_RESTORE
		lexSkipToken( )

		'' LABEL?
		s = NULL
		select case lexGetClass( )
		case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_NUMLITERAL
			s = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_LABEL )
			if( s = NULL ) then
				s = symbAddLabel( lexGetText( ), FALSE, TRUE )
				if( s = NULL ) then
					hReportError( FB_ERRMSG_DUPDEFINITION )
					exit function
				end if
			end if
			lexSkipToken( )
		end select

		function = rtlDataRestore( s )

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
			littext = ""
			typ = INVALID

			hMatchExpression( expr )

			'' check if it's an string
			s = NULL
			if( astGetDataType( expr ) = IR_DATATYPE_CHAR ) then
				if( astIsVAR( expr ) ) then
					s = astGetSymbolOrElm( expr )
					if( s <> NULL ) then
						if( not symbGetVarInitialized( s ) ) then
							s = NULL
						end if
					end if
				end if
			end if

			'' string?
			if( s <> NULL ) then
				astDel( expr )

                typ = FB_SYMBTYPE_CHAR
				litlen  = symbGetStrLen( s ) - 1 			'' less the null-char
				littext = symbGetVarText( s )

            	if( not rtlDataStore( littext, litlen, typ ) ) then
	            	exit function
    	        end if

			else

				if( astIsOFFSET( expr ) ) then
            		if( not rtlDataStoreOFS( astGetSymbolOrElm( expr ) ) ) then
	            		exit function
    	        	end if

				else

					if( not astIsCONST( expr ) ) then
						hReportError( FB_ERRMSG_EXPECTEDCONST )
						exit function
					end if

  					littext = astGetValueAsStr( expr )
  					litlen = len( littext )

            		if( not rtlDataStore( littext, litlen, IR_DATATYPE_CHAR ) ) then
	            		exit function
    	        	end if

  				end if

  				astDel( expr )

		    end if

		loop while( hMatch( CHAR_COMMA ) )

		rtlDataStoreEnd( )

		function = TRUE

	end select

end function

