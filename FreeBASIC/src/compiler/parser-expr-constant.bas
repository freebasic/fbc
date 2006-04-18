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


'' atom constants and literals parsing
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

'':::::
'' Constant       = ID .
''
function cConstant( byref constexpr as ASTNODE ptr ) as integer static
	dim as FBSYMBOL ptr s
	dim as integer dtype

	function = FALSE

	s = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_CONST )
	if( s <> NULL ) then

  		dtype = symbGetType( s )
  		select case as const dtype
  		case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
  			constexpr = astNewVAR( symbGetConstValStr( s ), 0, dtype )

  		case FB_DATATYPE_ENUM
  			constexpr = astNewENUM( symbGetConstValInt( s ), symbGetSubType( s ) )

  		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
  			constexpr = astNewCONSTl( symbGetConstValLong( s ), dtype )

  		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
  			constexpr = astNewCONSTf( symbGetConstValFloat( s ), dtype )

  		case else
  			constexpr = astNewCONSTi( symbGetConstValInt( s ), dtype, symbGetSubType( s ) )

  		end select

  		lexSkipToken( )
  		function = TRUE
  	end if

end function

'':::::
'' LitString	= 	STR_LITERAL STR_LITERAL* .
''
private function hLiteralString( byval checkescape as integer ) as ASTNODE ptr static
    dim as ASTNODE ptr expr
    dim as integer dtype
	dim as FBSYMBOL ptr sym
    dim as integer lgt, isunicode
    dim as zstring ptr zs
	dim as wstring ptr ws

    expr = NULL

	do
  		dtype = lexGetType( )
		lgt = lexGetTextLen( )

  		if( dtype <> FB_DATATYPE_WCHAR ) then
			'' opt escape on? convert to internal format..
			if( checkescape ) then
				zs = hReEscape( lexGetText( ), lgt, isunicode )
			else
				zs = lexGetText( )
				isunicode = FALSE
			end if

			if( isunicode = FALSE ) then
               	sym = symbAllocStrConst( zs, lgt )
			'' convert to unicode..
			else
				sym = symbAllocWstrConst( wstr( *zs ), lgt )
				dtype = FB_DATATYPE_WCHAR
			end if

  		else
			if( checkescape ) then
				ws = hReEscapeW( lexGetTextW( ), lgt )
			else
				ws = lexGetTextW( )
			end if

			sym = symbAllocWstrConst( ws, lgt )
		end if

		if( expr = NULL ) then
			expr = astNewVAR( sym, 0, dtype )
		else
			expr = astNewBOP( AST_OP_ADD, expr, astNewVAR( sym, 0, dtype ) )
		end if

		lexSkipToken( )

  		'' another literal string? concat..
  		if( lexGetClass( ) = FB_TKCLASS_STRLITERAL ) then
			checkescape = env.opt.escapestr

  		else
  			'' not a '$'?
  			if( lexGetToken( ) <> CHAR_DOLAR ) then
  				exit do
  			end if

  			'' not a literal string?
  			if( lexGetLookAheadClass( 1 ) <> FB_TKCLASS_STRLITERAL ) then
  				exit do
  			end if

  			lexSkipToken( )
  			checkescape = FALSE
  		end if
	loop

	function = expr

end function

'':::::
''Literal		  = NUM_LITERAL
''				  | STR_LITERAL STR_LITERAL* .
''
function cLiteral( byref litexpr as ASTNODE ptr ) as integer
	dim as integer dtype

	function = FALSE

	select case lexGetClass( )
	'' NUM_LITERAL?
	case FB_TKCLASS_NUMLITERAL
  		dtype = lexGetType( )
  		select case as const dtype
  		case FB_DATATYPE_LONGINT
			litexpr = astNewCONSTl( vallng( *lexGetText( ) ), dtype )

		case FB_DATATYPE_ULONGINT
			litexpr = astNewCONSTl( valulng( *lexGetText( ) ), dtype )

  		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			litexpr = astNewCONSTf( val( *lexGetText( ) ), dtype )

		case FB_DATATYPE_UINT
			litexpr = astNewCONSTi( valuint( *lexGetText( ) ), dtype )

		case else
			litexpr = astNewCONSTi( valint( *lexGetText( ) ), dtype )
  		end select

  		lexSkipToken( )
  		function = TRUE

  	'' (STR_LITERAL STR_LITERAL*)?
  	case FB_TKCLASS_STRLITERAL
        litexpr = hLiteralString( env.opt.escapestr )
        function = TRUE

  	case else
  		'' '$'?
  		if( lexGetToken( ) = CHAR_DOLAR ) then
  			'' literal string?
  			if( lexGetLookAheadClass( 1 ) = FB_TKCLASS_STRLITERAL ) then
  				lexSkipToken( )
  				litexpr = hLiteralString( FALSE )
  				function = TRUE
  			end if
  		end if
  	end select

end function

