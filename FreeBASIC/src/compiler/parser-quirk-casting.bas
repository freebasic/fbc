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


'' quirk casting functions (CBYTE, CSHORT, CINT, ...) parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

'':::::
''TypeConvExpr		=    (C### '(' expression ')') .
''
function cTypeConvExpr _
	( _
		byval tk as FB_TOKEN, _
		byval isASM as integer = FALSE _
	) as ASTNODE ptr

    dim as integer dtype = any, op = any
    dim as ASTNODE ptr expr = any

	dtype = INVALID
	op = INVALID

	select case as const tk
	case FB_TK_CBYTE
		dtype = FB_DATATYPE_BYTE

	case FB_TK_CUBYTE
		dtype = FB_DATATYPE_UBYTE

	case FB_TK_CSHORT
		dtype = FB_DATATYPE_SHORT

	case FB_TK_CUSHORT
		dtype = FB_DATATYPE_USHORT

	case FB_TK_CINT
		dtype = FB_DATATYPE_INTEGER

	case FB_TK_CUINT
		dtype = FB_DATATYPE_UINT

	case FB_TK_CLNG
		dtype = FB_DATATYPE_LONG

	case FB_TK_CULNG
		dtype = FB_DATATYPE_ULONG

	case FB_TK_CLNGINT
		dtype = FB_DATATYPE_LONGINT

	case FB_TK_CULNGINT
		dtype = FB_DATATYPE_ULONGINT

	case FB_TK_CSNG
		dtype = FB_DATATYPE_SINGLE

	case FB_TK_CDBL
		dtype = FB_DATATYPE_DOUBLE

	case FB_TK_CSIGN
		op = AST_OP_TOSIGNED

	case FB_TK_CUNSG
		op = AST_OP_TOUNSIGNED

	end select

	if( dtype = INVALID ) then
		if( op = INVALID ) then
			return NULL
		end if
	end if

	lexSkipToken( )

	'' '('
	if( hMatch( CHAR_LPRNT ) = FALSE ) then
		if( errReport( FB_ERRMSG_EXPECTEDLPRNT ) = FALSE ) then
			return NULL
		end if
	end if

	expr = cExpression( )
	if( expr = NULL ) then
		if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
			return NULL
		else
			expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
		end if
	end if

	select case op
	case AST_OP_TOSIGNED
		dtype = symbGetSignedType( astGetDataType( expr ) )
	case AST_OP_TOUNSIGNED
	    dtype = symbGetUnsignedType( astGetDataType( expr ) )
	end select

	expr = astNewCONV( dtype, NULL, expr, INVALID, TRUE )
    if( expr = NULL ) Then
    	if( errReport( FB_ERRMSG_TYPEMISMATCH, TRUE ) = FALSE ) then
    		return NULL
		else
			expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
    	end if
    end if

	'' ')'
	if( lexGetToken( ) <> CHAR_RPRNT ) then
		if( errReport( FB_ERRMSG_EXPECTEDRPRNT ) = FALSE ) then
			return NULL
		else
			hSkipUntil( CHAR_RPRNT, TRUE )
		end if
	else
		if isASM = FALSE then
			lexSkipToken( )
		end if
	end if

	function = expr

end function

'':::::
'' AnonUDT			=	TYPE ('<' Symbol '>')? '(' ... ')'
function cAnonUDT _
	( _
		_
	) as ASTNODE ptr

    dim as FBSYMBOL ptr sym = any, subtype = any
    dim as FBSYMCHAIN ptr chain_ = any
    dim as FBSYMBOL ptr base_parent = any

	'' TYPE
	lexSkipToken( )

    '' ('<' Symbol '>')?
    if( lexGetToken( ) = FB_TK_LT ) then
    	lexSkipToken( )
    	chain_ = cIdentifier( base_parent )
    	if( chain_ = NULL ) then
			if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
				return NULL
			else
				'' error recovery: skip until next '>', fake a node
				hSkipUntil( FB_TK_GT, TRUE )
				return astNewCONSTi( 0, FB_DATATYPE_INTEGER )
			end if
    	end if

    	subtype = chain_->sym

		'' typedef? resolve..
		if( symbIsTypedef( subtype ) ) then
			subtype = symbGetSubtype( subtype )

    		if( subtype = NULL ) then
				if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
					return NULL
				else
					'' error recovery: skip until next '>', fake a node
					hSkipUntil( FB_TK_GT, TRUE )
					return astNewCONSTi( 0, FB_DATATYPE_INTEGER )
				end if
			end if
		end if

    	if( symbIsStruct( subtype ) = FALSE ) then
			if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
				return NULL
			else
				'' error recovery: skip until next '>', fake a node
				hSkipUntil( FB_TK_GT, TRUE )
				return astNewCONSTi( 0, FB_DATATYPE_INTEGER )
			end if
    	end if

    	lexSkipToken( )

    	'' '>'
    	if( lexGetToken( ) <> FB_TK_GT ) then
			if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
				return NULL
			else
				'' error recovery: skip until next '>'
				hSkipUntil( FB_TK_GT, TRUE )
			end if

    	else
    		lexSkipToken( )
    	end if

    else
    	subtype = parser.ctxsym

		if( subtype <> NULL ) then
			'' typedef? resolve..
			if( symbIsTypedef( subtype ) ) then
				subtype = symbGetSubtype( subtype )
			end if
		end if

    	if( subtype = NULL ) then
			if( errReport( FB_ERRMSG_SYNTAXERROR, TRUE ) = FALSE ) then
				return NULL
			else
				'' error recovery: fake a node
				return astNewCONSTi( 0, FB_DATATYPE_INTEGER )
			end if
    	end if

    	if( symbIsStruct( subtype ) = FALSE ) then
			if( errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE ) = FALSE ) then
				return NULL
			else
				'' error recovery: fake a node
				return astNewCONSTi( 0, FB_DATATYPE_INTEGER )
			end if
		end if
    end if

    '' has a ctor?
    if( symbGetHasCtor( subtype ) ) then
    	return cCtorCall( subtype )
    end if

    '' alloc temp var
    sym = symbAddTempVar( FB_DATATYPE_STRUCT, subtype, FALSE, FALSE )

    '' let the initializer do the rest..
    function = cInitializer( sym, FB_INIOPT_NONE )

    '' del temp var
    symbDelVar( sym )

end function


