'' quirk math functions (ABS, SGN, FIX, LEN, ...) parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "rtl.bi"
#include once "ast.bi"

private function hMathOp(byval op as AST_OP) as ASTNODE ptr
	dim as ASTNODE ptr expr = any
	lexSkipToken( )
	hMatchLPRNT( )
	hMatchExpressionEx( expr, FB_DATATYPE_INTEGER )
	hMatchRPRNT( )

	expr = astNewUOP( op, expr )
	if( expr = NULL ) then
		errReport( FB_ERRMSG_INVALIDDATATYPES )
		expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
	end if

	function = expr
end function

private function hAtan2() as ASTNODE ptr
	dim as ASTNODE ptr expr = any, expr2 = any

	'' ATAN2( Expression ',' Expression )
	lexSkipToken( )
	hMatchLPRNT( )
	hMatchExpressionEx( expr, FB_DATATYPE_INTEGER )
	hMatchCOMMA( )
	hMatchExpressionEx( expr2, FB_DATATYPE_INTEGER )
	hMatchRPRNT( )

	expr = astNewBOP( AST_OP_ATAN2, expr, expr2 )
	if( expr = NULL ) then
		errReport( FB_ERRMSG_INVALIDDATATYPES )
		expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
	end if

	function = expr
end function

private function hLenSizeof _
	( _
		byval is_len as integer, _
		byval isasm as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr expr = any, expr2 = any
	dim as integer dtype = any, lgt = any, is_type = any
	dim as FBSYMBOL ptr sym = any, subtype = any

	'' LEN | SIZEOF
	lexSkipToken( )

	'' '('
	hMatchLPRNT( )

	'' Type or an Expression
	expr = cTypeOrExpression( is_len, dtype, subtype, lgt )

	'' Was it an expression?
	if( expr ) then
		'' Array without index makes this a SIZEOF()
		if( astIsNIDXARRAY( expr ) ) then
			is_len = FALSE
			expr2 = astGetLeft( expr )
			astDelNode( expr )
			expr = expr2
		end if

		'' Disallow string expressions in SIZEOF()
		if( is_len = FALSE ) then
			if( astGetDataClass( expr ) = FB_DATACLASS_STRING ) then
				if( (astGetSymbol( expr ) = NULL) or astIsCALL( expr ) ) then
					errReport( FB_ERRMSG_EXPECTEDIDENTIFIER, TRUE )
					'' error recovery: fake an expr
					astDelTree( expr )
					expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
				end if
			end if
		end if
	end if

	'' ')'
	if( lexGetToken( ) <> CHAR_RPRNT ) then
		errReport( FB_ERRMSG_EXPECTEDRPRNT )
		hSkipUntil( CHAR_RPRNT, TRUE )
	else
		if( isasm = FALSE ) then
			lexSkipToken( )
		end if
	end if

	if( expr <> NULL ) then
		if( is_len ) then
			function = rtlMathLen( expr )
		else
			function = astNewCONSTi( astSizeOf( expr ) )
			astDelTree( expr )
		end if
	else
		function = astNewCONSTi( lgt, FB_DATATYPE_INTEGER )
	end if
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
		byval isasm as integer _
	) as ASTNODE ptr

	function = FALSE

	select case as const tk
	'' ABS( Expression )
	case FB_TK_ABS
		function = hMathOp(AST_OP_ABS)

	'' SGN( Expression )
	case FB_TK_SGN
		function = hMathOp(AST_OP_SGN)

	'' FIX( Expression )
	case FB_TK_FIX
		function = hMathOp(AST_OP_FIX)

	'' FRAC( Expression )
	case FB_TK_FRAC
		function = hMathOp(AST_OP_FRAC)

	'' INT( Expression )
	case FB_TK_INT
		function = hMathOp(AST_OP_FLOOR)

	'' SIN/COS/...( Expression )
	case FB_TK_SIN
		function = hMathOp(AST_OP_SIN)

	case FB_TK_ASIN
		function = hMathOp(AST_OP_ASIN)

	case FB_TK_COS
		function = hMathOp(AST_OP_COS)

	case FB_TK_ACOS
		function = hMathOp(AST_OP_ACOS)

	case FB_TK_TAN
		function = hMathOp(AST_OP_TAN)

	case FB_TK_ATN
		function = hMathOp(AST_OP_ATAN)

	case FB_TK_SQR
		function = hMathOp(AST_OP_SQRT)

	case FB_TK_LOG
		function = hMathOp(AST_OP_LOG)

	case FB_TK_EXP
		function = hMathOp(AST_OP_EXP)

	'' ATAN2( Expression ',' Expression )
	case FB_TK_ATAN2
		function = hAtan2()

	'' LEN|SIZEOF( data type | Expression{idx-less arrays too} )
	case FB_TK_LEN
		function = hLenSizeof(TRUE, isasm)

	case FB_TK_SIZEOF
		function = hLenSizeof(FALSE, isasm)

	end select

end function
