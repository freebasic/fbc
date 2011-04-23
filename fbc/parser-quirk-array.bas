''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2010 The FreeBASIC development team.
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


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "rtl.bi"
#include once "ast.bi"

'':::::
''ArrayStmt   	  =   ERASE ID (',' ID)*;
''				  |   SWAP Variable, Variable .
''
function cArrayStmt _
	( _
		byval tk as FB_TOKEN _
	) as integer

	dim as FBSYMBOL ptr s
	dim as ASTNODE ptr expr1, expr2

	function = FALSE

	select case tk
	case FB_TK_ERASE
		lexSkipToken( )

		do
			expr1 = cVarOrDeref( FALSE )
			if( expr1 = NULL ) then
				if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
					exit function
				else
					hSkipUntil( CHAR_COMMA )
				end if

			else
				'' ugly hack to deal with arrays w/o indexes
				if( astIsNIDXARRAY( expr1 ) ) then
					expr2 = astGetLeft( expr1 )
					astDelNode( expr1 )
					expr1 = expr2
				end if

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
					
					if( typeIsConst( astGetFullType( expr1 ) ) ) then
						if( errReport( FB_ERRMSG_CONSTANTCANTBECHANGED ) = FALSE ) then
							exit function
						end if
					end if
					
					if( symbGetIsDynamic( s ) ) then
						expr1 = rtlArrayErase( expr1 )
					else
						expr1 = rtlArrayClear( expr1, TRUE )
					end if

					astAdd( expr1 )

					if( errGetLast( ) <> FB_ERRMSG_OK ) then
						exit function
					end if
				end if
			end if

		'' ','?
		loop while( hMatch( CHAR_COMMA ) )

		function = TRUE

	'' SWAP Variable, Variable
	case FB_TK_SWAP
		lexSkipToken( )

		expr1 = cVarOrDeref(  )
		if( expr1 = NULL ) then
			if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
				exit function
			else
				hSkipStmt( )
				return TRUE
			end if
		end if

		hMatchCOMMA( )

		expr2 = cVarOrDeref(  )
		if( expr2 = NULL ) then
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
			'' don't allow any consts...
			if( typeIsConst( astGetFullType( expr1 ) ) ) then
				if( errReport( FB_ERRMSG_CONSTANTCANTBECHANGED ) = FALSE ) then
					exit function
				end if
			end if
			if( typeIsConst( astGetFullType( expr2 ) ) ) then
				if( errReport( FB_ERRMSG_CONSTANTCANTBECHANGED ) = FALSE ) then
					exit function
				end if
			end if
			
			function = rtlMemSwap( expr1, expr2 )
		end select

	end select

end function

'':::::
''cArrayFunct =   (LBOUND|UBOUND) '(' ID (',' Expression)? ')' .
''
function cArrayFunct _
	( _
		byval tk as FB_TOKEN, _
		byref funcexpr as ASTNODE ptr _
	) as integer

	dim as ASTNODE ptr arrayexpr = any, dimexpr = any
	dim as integer is_lbound = any
	dim as FBSYMBOL ptr s = any

	function = FALSE

	select case tk

	'' (LBOUND|UBOUND) '(' ID (',' Expression)? ')'
	case FB_TK_LBOUND, FB_TK_UBOUND
		if( tk = FB_TK_LBOUND ) then
			is_lbound = TRUE
		else
			is_lbound = FALSE
		end if
		lexSkipToken( )

		'' '('
		hMatchLPRNT( )

		'' ID
		arrayexpr = cVarOrDeref( FALSE )
		if( arrayexpr = NULL ) then
			if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
				exit function
			else
				'' error recovery: skip until next ')' and fake an expr
				hSkipUntil( CHAR_RPRNT, TRUE )
				funcexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
				return TRUE
			end if
		end if

		'' ugly hack to deal with arrays w/o indexes
		if( astIsNIDXARRAY( arrayexpr ) ) then
			dim as ASTNODE ptr expr = astGetLeft( arrayexpr )
			astDelNode( arrayexpr )
			arrayexpr = expr
		end if

		'' array?
		s = astGetSymbol( arrayexpr )
		if( s <> NULL ) then
			if( symbIsArray( s ) = FALSE ) then
				s = NULL
			end if
		end if

		if( s = NULL ) then
			if( errReport( FB_ERRMSG_EXPECTEDARRAY, TRUE ) = FALSE ) then
				exit function
			else
				'' error recovery: skip until next ')' and fake an expr
				hSkipUntil( CHAR_RPRNT, TRUE )
				funcexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
				return TRUE
			end if
		end if

		'' (',' Expression)?
		if( hMatch( CHAR_COMMA ) ) then
			hMatchExpressionEx( dimexpr, FB_DATATYPE_INTEGER )
		else
			dimexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
		end if

		'' ')'
		hMatchRPRNT( )

		funcexpr = rtlArrayBound( arrayexpr, dimexpr, is_lbound )

		function = funcexpr <> NULL

	end select

end function

