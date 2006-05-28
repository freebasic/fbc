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
function cConstantEx _
	( _
		byval sym as FBSYMBOL ptr, _
		byref expr as ASTNODE ptr _
	) as integer static

	dim as integer dtype

  	'' ID
  	lexSkipToken( )

	dtype = symbGetType( sym )
  	select case as const dtype
  	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
  		expr = astNewVAR( symbGetConstValStr( sym ), 0, dtype )

  	case FB_DATATYPE_ENUM
  		expr = astNewENUM( symbGetConstValInt( sym ), symbGetSubType( sym ) )

  	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
  		expr = astNewCONSTl( symbGetConstValLong( sym ), dtype )

  	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
  		expr = astNewCONSTf( symbGetConstValFloat( sym ), dtype )

  	case else
  		expr = astNewCONSTi( symbGetConstValInt( sym ), dtype, symbGetSubType( sym ) )

  	end select

  	function = TRUE

end function

'':::::
'' EnumConstant	=		ID '.' ID .
''
function cEnumConstant _
	( _
		byval sym as FBSYMBOL ptr, _
		byref expr as ASTNODE ptr _
	) as integer static

	dim as FBSYMBOL ptr elm

	function = FALSE

	'' ID
	lexSkipToken( )

	'' '.'
	lexSkipToken( LEXCHECK_NOLOOKUP )

	'' ID
	if( lexGetToken( ) <> FB_TK_ID ) then
		if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
			exit function
		else
			'' error recovery: fake a node
			expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
			return TRUE
		end if
	end if

	elm = symbFindByClass( lexGetSymChain( ), FB_SYMBCLASS_CONST )
    if( elm = NULL ) then
    	if( errReportUndef( FB_ERRMSG_ELEMENTNOTDEFINED, lexGetText( ) ) = FALSE ) then
    		exit function
		else
			'' error recovery: fake a node
			lexSkipToken( )
			expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
			return TRUE
		end if
    end if

    if( symbGetParent( elm ) <> sym ) then
    	if( errReportUndef( FB_ERRMSG_ELEMENTNOTDEFINED, lexGetText( ) ) = FALSE ) then
    		exit function
		else
			'' error recovery: fake a node
			lexSkipToken( )
			expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
			return TRUE
		end if
    end if

    lexSkipToken( )

    function = cConstantEx( sym, expr )

end function

'':::::
'' Constant       = ID .
''
function cConstant _
	( _
		byval chain_ as FBSYMCHAIN ptr, _
		byref expr as ASTNODE ptr _
	) as integer static

	dim as FBSYMBOL ptr sym

	sym = symbFindByClass( chain_, FB_SYMBCLASS_CONST )
	if( sym <> NULL ) then
  		function = cConstantEx( sym, expr )
  	else
		function = FALSE
  	end if

end function

'':::::
'' LitString	= 	STR_LITERAL STR_LITERAL* .
''
function cStrLiteral _
	( _
		byref expr as ASTNODE ptr, _
		byval checkescape as integer _
	) as integer static

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

	function = TRUE

end function

'':::::
function cNumLiteral _
	( _
		byref expr as ASTNODE ptr _
	) as integer

	dim as integer dtype

  	dtype = lexGetType( )
  	select case as const dtype
  	case FB_DATATYPE_LONGINT
		expr = astNewCONSTl( vallng( *lexGetText( ) ), dtype )

	case FB_DATATYPE_ULONGINT
		expr = astNewCONSTl( valulng( *lexGetText( ) ), dtype )

  	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		expr = astNewCONSTf( val( *lexGetText( ) ), dtype )

	case FB_DATATYPE_UINT
		expr = astNewCONSTi( valuint( *lexGetText( ) ), dtype )

	case else
		expr = astNewCONSTi( valint( *lexGetText( ) ), dtype )
  	end select

  	lexSkipToken( )

  	function = TRUE

end function

'':::::
''Literal		  = NUM_LITERAL
''				  | STR_LITERAL STR_LITERAL* .
''
function cLiteral _
	( _
		byref litexpr as ASTNODE ptr _
	) as integer

	function = FALSE

	select case lexGetClass( )
	'' NUM_LITERAL?
	case FB_TKCLASS_NUMLITERAL
		return cNumLiteral( litexpr )

  	'' (STR_LITERAL STR_LITERAL*)?
  	case FB_TKCLASS_STRLITERAL
        return cStrLiteral( litexpr, env.opt.escapestr )

  	case else
  		'' '$'?
  		if( lexGetToken( ) = CHAR_DOLAR ) then
  			'' literal string?
  			if( lexGetLookAheadClass( 1 ) = FB_TKCLASS_STRLITERAL ) then
  				lexSkipToken( )
  				return cStrLiteral( litexpr, FALSE )
  			end if
  		end if
  	end select

end function

