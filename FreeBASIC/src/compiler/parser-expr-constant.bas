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
''Literal		  = NUM_LITERAL
''				  | STR_LITERAL STR_LITERAL* .
''
function cLiteral( byref litexpr as ASTNODE ptr ) as integer
	dim as FBSYMBOL ptr s
	dim as integer typ

	function = FALSE

	select case lexGetClass( )
	'' NUM_LITERAL?
	case FB_TKCLASS_NUMLITERAL
  		typ = lexGetType( )
  		select case as const typ
  		case FB_DATATYPE_LONGINT
			litexpr = astNewCONSTl( vallng( *lexGetText( ) ), typ )

		case FB_DATATYPE_ULONGINT
			litexpr = astNewCONSTl( valulng( *lexGetText( ) ), typ )

  		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			litexpr = astNewCONSTf( val( *lexGetText( ) ), typ )

		case FB_DATATYPE_UINT
			litexpr = astNewCONSTi( valuint( *lexGetText( ) ), typ )

		case else
			litexpr = astNewCONSTi( valint( *lexGetText( ) ), typ )
  		end select

  		lexSkipToken( )
  		function = TRUE

  	'' (STR_LITERAL STR_LITERAL*)?
  	case FB_TKCLASS_STRLITERAL

        litexpr = NULL
  		do
  			typ = lexGetType( )
  			if( typ <> FB_DATATYPE_WCHAR ) then
				s = symbAllocStrConst( *lexGetText( ), lexGetTextLen( ) )
  			else
				s = symbAllocWstrConst( *lexGetTextW( ), lexGetTextLen( ) )
			end if

			if( litexpr = NULL ) then
				litexpr = astNewVAR( s, 0, typ )
			else
				litexpr = astNewBOP( AST_OP_ADD, litexpr, astNewVAR( s, 0, typ ) )
			end if

			lexSkipToken( )
		loop while lexGetClass( ) = FB_TKCLASS_STRLITERAL

        function = TRUE
  	end select

end function

