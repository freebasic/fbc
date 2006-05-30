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


'' quirk array statements (ERASE, SWAP) and functions (LBOUND, UBOUND) parsing
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
''ArrayStmt   	  =   ERASE ID (',' ID)*;
''				  |   SWAP Variable, Variable .
''
function cArrayStmt as integer
	dim as FBSYMBOL ptr s
	dim as ASTNODE ptr expr1, expr2

	function = FALSE

	select case lexGetToken( )
	case FB_TK_ERASE
		lexSkipToken( )

		do
			if( cVarOrDeref( expr1, FALSE ) = FALSE ) then
				if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
					exit function
				else
					hSkipUntil( CHAR_COMMA )
				end if

			else
				'' array?
    			s = astGetSymbol( expr1 )
    			if( s <> NULL ) then
    				if( symbIsArray( s ) = FALSE ) then
    					s = NULL
    				end if
    			end if

				if( s = NULL ) then
					if( errReport( FB_ERRMSG_EXPECTEDARRAY ) = FALSE ) then
						exit function
					else
						hSkipUntil( CHAR_COMMA )
					end if

				else
					if( symbGetIsDynamic( s ) ) then
						expr1 = rtlArrayErase( expr1 )
						if( expr1 <> NULL ) then
							astAdd( expr1 )
						end if

					else
						if( rtlArrayClear( expr1 ) = FALSE ) then
							if( errGetLast( ) <> FB_ERRMSG_OK ) then
								exit function
							end if
						end if
					end if
				end if
			end if

		'' ','?
		loop while( hMatch( CHAR_COMMA ) )

		function = TRUE

	'' SWAP Variable, Variable
	case FB_TK_SWAP
		lexSkipToken( )

		if( cVarOrDeref( expr1 ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
				exit function
			else
				hSkipStmt( )
				return true
			end if
		end if

		hMatchCOMMA( )

		if( cVarOrDeref( expr2 ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
				exit function
			else
				astDelTree( expr1 )
				hSkipStmt( )
				return true
			end if
		end if

		select case as const astGetDataType( expr1 )
		case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR

			if( astGetDataType( expr2 ) = FB_DATATYPE_WCHAR ) then
				if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
					exit function
				else
					astDelTree( expr1 )
					astDelTree( expr2 )
				end if

			else
				function = rtlStrSwap( expr1, expr2 )
			end if

		case FB_DATATYPE_WCHAR
			if( astGetDataType( expr2 ) <> FB_DATATYPE_WCHAR ) then
				if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
					exit function
				else
					astDelTree( expr1 )
					astDelTree( expr2 )
				end if

			else
				function = rtlWstrSwap( expr1, expr2 )
			end if

		case else
			function = rtlMemSwap( expr1, expr2 )
		end select

	end select

end function

'':::::
''cArrayFunct =   (LBOUND|UBOUND) '(' ID (',' Expression)? ')' .
''
function cArrayFunct _
	( _
		byref funcexpr as ASTNODE ptr _
	) as integer

	dim as ASTNODE ptr sexpr, expr
	dim as integer islbound
	dim as FBSYMBOL ptr s

	function = FALSE

	select case lexGetToken( )

	'' (LBOUND|UBOUND) '(' ID (',' Expression)? ')'
	case FB_TK_LBOUND, FB_TK_UBOUND
		if( lexGetToken( ) = FB_TK_LBOUND ) then
			islbound = TRUE
		else
			islbound = FALSE
		end if
		lexSkipToken( )

		'' '('
		hMatchLPRNT( )

		'' ID
		if( cVarOrDeref( sexpr, FALSE ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
				exit function
			else
				hSkipUntil( CHAR_RPRNT, TRUE )
				return TRUE
			end if
		end if

		'' array?
		s = astGetSymbol( sexpr )
		if( s <> NULL ) then
			if( symbIsArray( s ) = FALSE ) then
				s = NULL
			end if
		end if

		if( s = NULL ) then
			if( errReport( FB_ERRMSG_EXPECTEDARRAY, TRUE ) = FALSE ) then
				exit function
			else
				hSkipUntil( CHAR_RPRNT, TRUE )
				return TRUE
			end if
		end if

		'' (',' Expression)?
		if( hMatch( CHAR_COMMA ) ) then
			hMatchExpressionEx( expr, FB_DATATYPE_INTEGER )
		else
			expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
		end if

		'' ')'
		hMatchRPRNT( )

		funcexpr = rtlArrayBound( sexpr, expr, islbound )

		function = funcexpr <> NULL

	end select

end function

