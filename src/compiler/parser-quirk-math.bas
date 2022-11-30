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

	'' ABS|SGN|FIX|FRAC|INT|SIN|ASIN|COS|ACOS|TAN|ATN|SQR|LOG|EXP
	lexSkipToken( LEXCHECK_POST_SUFFIX )
	hMatchLPRNT( )
	hMatchExpressionEx( expr, FB_DATATYPE_INTEGER )
	hMatchRPRNT( )

	expr = astNewUOP( op, expr )
	if( expr = NULL ) then
		errReport( FB_ERRMSG_INVALIDDATATYPES )
		expr = astNewCONSTi( 0 )
	end if

	function = expr
end function

private function hAtan2() as ASTNODE ptr
	dim as ASTNODE ptr expr = any, expr2 = any

	'' ATAN2( Expression ',' Expression )
	lexSkipToken( LEXCHECK_POST_SUFFIX )
	hMatchLPRNT( )
	hMatchExpressionEx( expr, FB_DATATYPE_INTEGER )
	hMatchCOMMA( )
	hMatchExpressionEx( expr2, FB_DATATYPE_INTEGER )
	hMatchRPRNT( )

	expr = astNewBOP( AST_OP_ATAN2, expr, expr2 )
	if( expr = NULL ) then
		errReport( FB_ERRMSG_INVALIDDATATYPES )
		expr = astNewCONSTi( 0 )
	end if

	function = expr
end function

private function hLen _
	( _
		byval expr as ASTNODE ptr, _
		byref lgt as longint _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr litsym = any
	dim as ASTNODE ptr lenexpr = any

	select case( astGetDataType( expr ) )
	case FB_DATATYPE_STRING
		return rtlStrLen( expr )

	case FB_DATATYPE_CHAR
		litsym = astGetStrLitSymbol( expr )
		if( litsym = NULL ) then
			return rtlStrLen( expr )
		end if

		'' String literal, evaluate at compile-time
		lgt = symbGetStrLen( litsym ) - 1

	case FB_DATATYPE_WCHAR
		litsym = astGetStrLitSymbol( expr )
		if( litsym = NULL ) then
			return rtlWstrLen( expr )
		end if

		'' String literal, evaluate at compile-time
		'' symbGetStrLen( litsym ) will return the number of codepoints
		'' that are used to store the escaped WSTRING literal, when what
		'' we really want is the number of codepoints unescaped.
		lgt = len( *hUnescapeW( symbGetVarLitTextW( litsym ) ) )

	case FB_DATATYPE_FIXSTR
		'' len( fixstr ) returns the N from STRING * N, i.e. it works
		'' like sizeof() - 1 (-1 for the implicit null terminator),
		'' it does not return the length of the stored string data.
		lgt = astSizeOf( expr ) - 1
		assert( lgt >= 0 )

	case FB_DATATYPE_STRUCT
		'' Check whether there is a matching len() UOP overload
		lenexpr = astNewUOP( AST_OP_LEN, expr )
		if( lenexpr <> NULL ) then
			return lenexpr
		end if

		lgt = astSizeOf( expr )

	case else
		'' For anything else, len() means sizeof()
		lgt = astSizeOf( expr )

	end select

	astDelTree( expr )
	return NULL
end function

private function hLenSizeof( byval tk as integer, byval isasm as integer ) as ASTNODE ptr
	dim as ASTNODE ptr expr = any
	dim as integer dtype = any
	dim as longint lgt = any
	dim as FBSYMBOL ptr subtype = any

	'' LEN | SIZEOF
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' '('
	hMatchLPRNT( )

	'' Type or an Expression
	expr = cTypeOrExpression( tk, dtype, subtype, lgt )

	'' Was it an expression?
	if( expr ) then
		'' Array without index makes this a SIZEOF()
		if( astIsNIDXARRAY( expr ) ) then
			tk = FB_TK_SIZEOF
			expr = astRemoveNIDXARRAY( expr )
		end if

	'' then must be a type
	elseif( tk = FB_TK_SIZEOF ) then
		dim is_fixlenstr as integer
		cUdtTypeMember( dtype, subtype, lgt, is_fixlenstr )

	elseif( tk = FB_TK_LEN ) then
		dim is_fixlenstr as integer
		cUdtTypeMember( dtype, subtype, lgt, is_fixlenstr )

		if( is_fixlenstr ) then
			'' assume that constant string has no embedded nulls
			select case typeGetDtAndPtrOnly( dtype )
			case FB_DATATYPE_CHAR, FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR
				lgt -= typeGetSize( FB_DATATYPE_CHAR )
				lgt /= typeGetSize( FB_DATATYPE_CHAR )
			case FB_DATATYPE_WCHAR
				lgt -= typeGetSize( FB_DATATYPE_WCHAR )
				lgt /= typeGetSize( FB_DATATYPE_WCHAR )
			end select
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

	if( expr ) then
		if( tk = FB_TK_LEN ) then
			'' len()
			'' If an expression is returned, then it's an
			'' fb_[W]StrLen() call, otherwise it's a sizeof() and
			'' the length is returned in lgt.
			expr = hLen( expr, lgt )
			if( expr = NULL ) then
				expr = astNewCONSTi( lgt )
			end if
		else
			'' sizeof()
			lgt = astSizeOf( expr )
			astDelTree( expr )
			expr = astNewCONSTi( lgt )
		end if
	else
		expr = astNewCONSTi( lgt )
	end if

	function = expr
end function

'':::::
'' cMathFunct   =   ABS( Expression )
''              |   SGN( Expression )
''              |   FIX( Expression )
''              |   INT( Expression )
''              |   LEN( data type | Expression ) .
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
	case FB_TK_LEN, FB_TK_SIZEOF
		function = hLenSizeof( tk, isasm )

	end select

end function
