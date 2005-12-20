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


'' quirk pointer statements (PEEK and POKE) parsing
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

'':::::
''PokeStmt =   POKE Expression, Expression .
''
function cPokeStmt as integer
	dim as ASTNODE ptr expr1, expr2
	dim as integer poketype, lgt, ptrcnt
	dim as FBSYMBOL ptr subtype

	function = FALSE

	'' POKE
	lexSkipToken

	'' (SymbolType ',')?
	if( cSymbolType( poketype, subtype, lgt, ptrcnt ) ) then

		'' check for invalid types
		select case poketype
		case FB_SYMBTYPE_VOID, FB_SYMBTYPE_FIXSTR
			hReportError FB_ERRMSG_INVALIDDATATYPES, TRUE
			exit function
		end select

		'' ','
		hMatchCOMMA( )

	else
		poketype = IR_DATATYPE_UBYTE
		subtype  = NULL
	end if

	'' Expression, Expression
	hMatchExpression( expr1 )

	hMatchCOMMA( )

	hMatchExpression( expr2 )

    select case astGetDataClass( expr1 )
    case IR_DATACLASS_STRING
    	hReportError FB_ERRMSG_INVALIDDATATYPES
        exit function
	case IR_DATACLASS_FPOINT
    	expr1 = astNewCONV( INVALID, IR_DATATYPE_UINT, NULL, expr1 )
	case else
        if( astGetDataSize( expr1 ) <> FB_POINTERSIZE ) then
        	hReportError FB_ERRMSG_INVALIDDATATYPES
        	exit function
        end if
	end select

    expr1 = astNewPTR( 0, expr1, poketype, subtype )

    expr1 = astNewASSIGN( expr1, expr2 )

	astAdd( expr1 )

    function = TRUE

end function

'':::::
'' PeekFunct =   PEEK '(' (SymbolType ',')? Expression ')' .
''
function cPeekFunct( byref funcexpr as ASTNODE ptr ) as integer
	dim as ASTNODE ptr expr
	dim as integer peektype, lgt, ptrcnt
	dim as FBSYMBOL ptr subtype

	function = FALSE

	'' PEEK
	lexSkipToken

	'' '('
	hMatchLPRNT( )

	'' (SymbolType ',')?
	if( cSymbolType( peektype, subtype, lgt, ptrcnt ) ) then

		'' check for invalid types
		select case peektype
		case FB_SYMBTYPE_VOID, FB_SYMBTYPE_FIXSTR
			hReportError FB_ERRMSG_INVALIDDATATYPES
			exit function
		end select

		'' ','
		hMatchCOMMA( )

	else
		peektype = IR_DATATYPE_UBYTE
		subtype = NULL
	end if

	'' Expression
	hMatchExpression( expr )

	' ')'
	hMatchRPRNT( )

    ''
    select case astGetDataClass( expr )
    case IR_DATACLASS_STRING
    	hReportError FB_ERRMSG_INVALIDDATATYPES
		exit function
	case IR_DATACLASS_FPOINT
		expr = astNewCONV( INVALID, IR_DATATYPE_UINT, NULL, expr )
	case else
		if( astGetDataSize( expr ) <> FB_POINTERSIZE ) then
        	hReportError FB_ERRMSG_INVALIDDATATYPES
        	exit function
		end if
	end select

    funcexpr = astNewPTR( 0, expr, peektype, subtype )

    function = TRUE

end function

