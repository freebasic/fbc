''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2008 The FreeBASIC development team.
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


'' quirk math functions (ABS, SGN, FIX, LEN, ...) parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"

'':::::
private function hMathOp _
	( _
		byval op as AST_OP, _
		byref funcexpr as ASTNODE ptr _
	) as integer

	dim as ASTNODE ptr expr = any

	lexSkipToken( )

	hMatchLPRNT( )

	hMatchExpressionEx( expr, FB_DATATYPE_INTEGER )

	hMatchRPRNT( )

	funcexpr = astNewUOP( op, expr )
	if( funcexpr = NULL ) then
		if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
			return FALSE
		else
			funcexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
		end if
	end if

	function = TRUE

end function

'':::::
private function hAtan2 _
	( _
		byref funcexpr as ASTNODE ptr _
	) as integer

	dim as ASTNODE ptr expr = any, expr2 = any

	'' ATAN2( Expression ',' Expression )
	lexSkipToken( )

	hMatchLPRNT( )

	hMatchExpressionEx( expr, FB_DATATYPE_INTEGER )

	hMatchCOMMA( )

	hMatchExpressionEx( expr2, FB_DATATYPE_INTEGER )

	hMatchRPRNT( )

	funcexpr = astNewBOP( AST_OP_ATAN2, expr, expr2 )
	if( funcexpr = NULL ) then
		if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
			exit function
		else
			funcexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
		end if
	end if

	function = TRUE

end function

'':::::
private function hLenSizeof _
	( _
		byval is_len as integer, _
		byref funcexpr as ASTNODE ptr, _
		byval isasm as integer _
	) as integer

	dim as ASTNODE ptr expr = any, expr2 = any
	dim as integer dtype = any, lgt = any, is_type = any
	dim as FBSYMBOL ptr sym = any, subtype = any

	'' LEN | SIZEOF
	lexSkipToken( )

	hMatchLPRNT( )

	'' token after next is operator or '['? 
	if( (lexGetLookAheadClass( 1 ) = FB_TKCLASS_OPERATOR andalso lexGetLookAhead( 1 ) <> CHAR_TIMES) _
		orelse lexGetLookAhead( 1 ) = CHAR_LBRACKET ) then
		'' disambiguation: types can't be followed by an operator
		'' (note: can't check periods here, because it could be a namespace resolution, or '*' because it could be STRING * n)
		is_type = FALSE
	elseif( fbLangIsSet( FB_LANG_QB ) ) then
		'' QB quirk: LEN() only takes expressions
		if( is_len ) then
			is_type = FALSE
		else
			'' SIZEOF()
			is_type = cSymbolType( dtype, subtype, lgt, FB_SYMBTYPEOPT_NONE )
		end if
	else
		is_type = cSymbolType( dtype, subtype, lgt, FB_SYMBTYPEOPT_NONE )
	end if

	''
	expr = NULL
	if( is_type = FALSE ) then
		fbSetCheckArray( FALSE )
		expr = cExpression( )
		if( expr = NULL ) then
			fbSetCheckArray( TRUE )
			if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
				exit function
			else
				'' error recovery: fake an expr
				expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
			end if

		else
			'' ugly hack to deal with arrays w/o indexes
			if( astIsNIDXARRAY( expr ) ) then
				is_len = FALSE
				expr2 = astGetLeft( expr )
				astDelNode( expr )
				expr = expr2
			end if
		end if

		fbSetCheckArray( TRUE )
	end if

	'' string expressions with SIZEOF() are not allowed
	if( expr <> NULL ) then
		if( is_len = FALSE ) then
			if( astGetDataClass( expr ) = FB_DATACLASS_STRING ) then
				if( (astGetSymbol( expr ) = NULL) or (astIsCALL( expr )) ) then
					if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER, TRUE ) = FALSE ) then
						exit function
					else
						'' error recovery: fake an expr
						astDelTree( expr )
						expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
					end if
				end if
			end if
		end if
	end if

	if( lexGetToken( ) <> CHAR_RPRNT ) then
		if( errReport( FB_ERRMSG_EXPECTEDRPRNT ) = FALSE ) then
			exit function
		else
			hSkipUntil( CHAR_RPRNT, TRUE )
		end if
	else
		if( isasm = FALSE ) then
			lexSkipToken( )
		end if
	end if

	if( expr <> NULL ) then
		funcexpr = rtlMathLen( expr, is_len )
	else
		funcexpr = astNewCONSTi( lgt, FB_DATATYPE_INTEGER )
	end if

	function = TRUE

end function

'':::::
'' cMathFunct	=	ABS( Expression )
'' 				|   SGN( Expression )
''				|   FIX( Expression )
''				|   INT( Expression )
''				|	LEN( data type | Expression ) .
''
function cMathFunct _
	( _
		byval tk as FB_TOKEN, _
		byref funcexpr as ASTNODE ptr, _
		byval isasm as integer = FALSE _
	) as integer

	function = FALSE

	select case as const tk
	'' ABS( Expression )
	case FB_TK_ABS
		function = hMathOp( AST_OP_ABS, funcexpr )

	'' SGN( Expression )
	case FB_TK_SGN
		function = hMathOp( AST_OP_SGN, funcexpr )

	'' FIX( Expression )
	case FB_TK_FIX
		function = hMathOp( AST_OP_FIX, funcexpr )

	'' FRAC( Expression )
	case FB_TK_FRAC
		function = hMathOp( AST_OP_FRAC, funcexpr )

	'' INT( Expression )
	case FB_TK_INT
		function = hMathOp( AST_OP_FLOOR, funcexpr )

	'' SIN/COS/...( Expression )
	case FB_TK_SIN
		function = hMathOp( AST_OP_SIN, funcexpr )

	case FB_TK_ASIN
		function = hMathOp( AST_OP_ASIN, funcexpr )

	case FB_TK_COS
		function = hMathOp( AST_OP_COS, funcexpr )

	case FB_TK_ACOS
		function = hMathOp( AST_OP_ACOS, funcexpr )

	case FB_TK_TAN
		function = hMathOp( AST_OP_TAN, funcexpr )

	case FB_TK_ATN
		function = hMathOp( AST_OP_ATAN, funcexpr )

	case FB_TK_SQR
		function = hMathOp( AST_OP_SQRT, funcexpr )

	case FB_TK_LOG
		function = hMathOp( AST_OP_LOG, funcexpr )

	case FB_TK_EXP
		function = hMathOp( AST_OP_EXP, funcexpr )

	'' ATAN2( Expression ',' Expression )
	case FB_TK_ATAN2
		function = hAtan2( funcexpr )

	'' LEN|SIZEOF( data type | Expression{idx-less arrays too} )
	case FB_TK_LEN
		function = hLenSizeof( TRUE, funcexpr, isasm )

	case FB_TK_SIZEOF
		function = hLenSizeof( FALSE, funcexpr, isasm )

	end select

end function

