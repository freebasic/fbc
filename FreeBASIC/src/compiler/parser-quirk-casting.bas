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


'' quirk casting functions (CBYTE, CSHORT, CINT, ...) parsing
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

'':::::
''TypeConvExpr		=    (C### '(' expression ')') .
''
function cTypeConvExpr( byref expr as ASTNODE ptr ) as integer
    dim as integer dtype, op

	function = FALSE

	dtype = INVALID
	op = INVALID

	select case as const lexGetToken( )
	case FB_TK_CBYTE
		dtype = FB_DATATYPE_BYTE
	case FB_TK_CSHORT
		dtype = FB_DATATYPE_SHORT
	case FB_TK_CINT, FB_TK_CLNG
		dtype = FB_DATATYPE_INTEGER
	case FB_TK_CLNGINT
		dtype = FB_DATATYPE_LONGINT

	case FB_TK_CUBYTE
		dtype = FB_DATATYPE_UBYTE
	case FB_TK_CUSHORT
		dtype = FB_DATATYPE_USHORT
	case FB_TK_CUINT
		dtype = FB_DATATYPE_UINT
	case FB_TK_CULNGINT
		dtype = FB_DATATYPE_ULONGINT

	case FB_TK_CSNG
		dtype = FB_DATATYPE_SINGLE
	case FB_TK_CDBL
		dtype = FB_DATATYPE_DOUBLE

	case FB_TK_CSIGN
		dtype = FB_DATATYPE_VOID				'' hack! AST will handle that
		op = AST_OP_TOSIGNED
	case FB_TK_CUNSG
		dtype = FB_DATATYPE_VOID				'' hack! /
		op = AST_OP_TOUNSIGNED

	end select

	if( dtype = INVALID ) then
		exit function
	else
		lexSkipToken( )
	end if

	'' '('
	if( hMatch( CHAR_LPRNT ) = FALSE ) then
		hReportError( FB_ERRMSG_EXPECTEDLPRNT )
		exit function
	end if

	if( cExpression( expr ) = FALSE ) then
		exit function
	end if

	expr = astNewCONV( op, dtype, NULL, expr, TRUE )
    if( expr = NULL ) Then
    	hReportError( FB_ERRMSG_TYPEMISMATCH, TRUE )
    	exit function
    end if

	'' ')'
	if( hMatch( CHAR_RPRNT ) = FALSE ) then
		hReportError( FB_ERRMSG_EXPECTEDRPRNT )
		exit function
	end if

	function = TRUE

end function

