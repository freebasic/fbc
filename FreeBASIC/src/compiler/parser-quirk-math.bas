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
'' cMathFunct	=	ABS( Expression )
'' 				|   SGN( Expression )
''				|   FIX( Expression )
''				|   INT( Expression )
''				|	LEN( data type | Expression ) .
''
function cMathFunct _
	( _
		byval tk as FB_TOKEN, _
		byref funcexpr as ASTNODE ptr _
	) as integer

    dim as ASTNODE ptr expr = any, expr2 = any
    dim as integer islen = any, dtype = any, lgt = any, ptrcnt = any
    dim as FBSYMBOL ptr sym = any, subtype = any

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

	'' ATAN2( Expression ',' Expression )
	case FB_TK_ATAN2
		lexSkipToken( )

		hMatchLPRNT( )

		hMatchExpressionEx( expr, FB_DATATYPE_INTEGER )

		hMatchCOMMA( )

		hMatchExpressionEx( expr2, FB_DATATYPE_INTEGER )

		hMatchRPRNT( )

		'' hack! implemented as Binary OP for better speed on x86's
		funcexpr = astNewBOP( AST_OP_ATAN2, expr, expr2 )
		if( funcexpr = NULL ) then
			if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
				exit function
			else
				funcexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
			end if
		end if

		function = TRUE

	'' LEN|SIZEOF( data type | Expression{idx-less arrays too} )
	case FB_TK_LEN, FB_TK_SIZEOF
		islen = (tk = FB_TK_LEN)
		lexSkipToken( )

		hMatchLPRNT( )

		expr = NULL
		if( cSymbolType( dtype, subtype, lgt, ptrcnt, FB_SYMBTYPEOPT_NONE ) = FALSE ) then
			fbSetCheckArray( FALSE )
			if( cExpression( expr ) = FALSE ) then
				fbSetCheckArray( TRUE )
				if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
					exit function
				else
					'' error recovery: fake an expr
					expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
				end if
			end if
			fbSetCheckArray( TRUE )
		end if

		'' string expressions with SIZEOF() are not allowed
		if( expr <> NULL ) then
			if( islen = FALSE ) then
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

		hMatchRPRNT( )

		if( expr <> NULL ) then
			funcexpr = rtlMathLen( expr, islen )
		else
			funcexpr = astNewCONSTi( lgt, FB_DATATYPE_INTEGER )
		end if

		function = TRUE

	end select

end function

