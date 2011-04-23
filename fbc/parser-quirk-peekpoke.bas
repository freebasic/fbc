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


'' quirk pointer statements (PEEK and POKE) parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

'':::::
''PokeStmt =   POKE Expression, Expression .
''
function cPokeStmt _
	( _
		_
	) as integer

	dim as ASTNODE ptr expr1 = any, expr2 = any
	dim as integer poketype = any, lgt = any
	dim as FBSYMBOL ptr subtype = any

	function = FALSE

	'' POKE
	lexSkipToken( )

	'' (SymbolType ',')?
	if( cSymbolType( poketype, subtype, lgt ) ) then

		'' check for invalid types
		select case poketype
		case FB_DATATYPE_VOID, FB_DATATYPE_FIXSTR
			if( errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE ) = FALSE ) then
				exit function
			else
				'' error recovery: fake a type
				poketype = FB_DATATYPE_UBYTE
				subtype = NULL
			end if
		end select

		'' ','
		hMatchCOMMA( )

	else
		poketype = FB_DATATYPE_UBYTE
		subtype  = NULL
	end if

	'' Expression, Expression
	hMatchExpressionEx( expr1, FB_DATATYPE_INTEGER )

	hMatchCOMMA( )

	hMatchExpressionEx( expr2, FB_DATATYPE_INTEGER )

    select case astGetDataClass( expr1 )
    case FB_DATACLASS_STRING
    	errReport( FB_ERRMSG_INVALIDDATATYPES )
    	'' no error recovery: stmt was already parsed
    	astDelTree( expr1 )
        exit function

	case FB_DATACLASS_FPOINT
    	expr1 = astNewCONV( FB_DATATYPE_UINT, NULL, expr1 )

	case else
        if( astGetDataSize( expr1 ) <> FB_POINTERSIZE ) then
        	errReport( FB_ERRMSG_INVALIDDATATYPES )
        	'' no error recovery: ditto
        	astDelTree( expr1 )
        	exit function
        end if
	end select

    expr1 = astNewDEREF( expr1, poketype, subtype )

    expr1 = astNewASSIGN( expr1, expr2 )
    if( expr1 = NULL ) then
    	if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
    		exit function
    	end if
	else
		astAdd( expr1 )
	end if

    function = TRUE

end function

'':::::
'' PeekFunct =   PEEK '(' (SymbolType ',')? Expression ')' .
''
function cPeekFunct _
	( _
		byref funcexpr as ASTNODE ptr _
	) as integer

	dim as ASTNODE ptr expr = any
	dim as integer dtype = any, lgt = any
	dim as FBSYMBOL ptr subtype = any

	function = FALSE

	'' PEEK
	lexSkipToken( )

	'' '('
	hMatchLPRNT( )

	'' (SymbolType ',')?
	if( cSymbolType( dtype, subtype, lgt ) ) then

		'' check for invalid types
		select case typeGet( dtype )
		case FB_DATATYPE_VOID, FB_DATATYPE_FIXSTR
			if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
				exit function
			else
				'' error recovery: fake a type
				dtype = FB_DATATYPE_UBYTE
				subtype = NULL
			end if
		end select

		'' ','
		hMatchCOMMA( )

	else
		dtype = FB_DATATYPE_UBYTE
		subtype = NULL
	end if

	'' Expression
	hMatchExpressionEx( expr, FB_DATATYPE_INTEGER )

	' ')'
	hMatchRPRNT( )

    ''
    select case astGetDataClass( expr )
    case FB_DATACLASS_STRING
    	if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
			exit function
		else
			'' error recovery: fake an expr
			astDelTree( expr )
			expr = NULL
		end if

	case FB_DATACLASS_FPOINT
		expr = astNewCONV( FB_DATATYPE_UINT, NULL, expr )

	case else
		if( astGetDataSize( expr ) <> FB_POINTERSIZE ) then
        	if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
        		exit function
        	else
				'' error recovery: fake an expr
				astDelTree( expr )
				expr = NULL
        	end if
		end if
	end select

    if( expr = NULL ) then
    	expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
    end if

   	'' ('.' UdtMember)?
   	if( lexGetToken( ) = CHAR_DOT ) then
		select case	dtype
		case FB_DATATYPE_STRUCT	', FB_DATATYPE_CLASS

		case else
			if(	errReport( FB_ERRMSG_EXPECTEDUDT, TRUE ) = FALSE ) then
				exit function
			end	if
		end	select

    	lexSkipToken( LEXCHECK_NOPERIOD )

    	funcexpr = cUdtMember( dtype, subtype, expr, TRUE )

    else
		funcexpr = astNewDEREF( expr, dtype, subtype )
    end if

	''
	function = (errGetLast() = FB_ERRMSG_OK)

end function

