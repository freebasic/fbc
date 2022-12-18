'' quirk string statements (MID, LSET) and functions (MID, INSTR) parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "rtl.bi"
#include once "ast.bi"

'' MidStmt  =  MID '(' Expression{str}, Expression{int} (',' Expression{int}) ')' '=' Expression{str} .
function cMidStmt( ) as integer
	dim as ASTNODE ptr expr1 = any, expr2 = any, expr3 = any, expr4 = any

	function = FALSE

	'' MID
	lexSkipToken( LEXCHECK_POST_STRING_SUFFIX )

	'' '('
	hMatchLPRNT()

	'' Expression{str}
	hMatchExpressionEx( expr1, FB_DATATYPE_STRING )
	if( astIsConstant( expr1 ) ) then
		errReport( FB_ERRMSG_CONSTANTCANTBECHANGED, TRUE )
	end if

	'' ','
	hMatchCOMMA( )

	'' Expression{int}
	hMatchExpressionEx( expr2, FB_DATATYPE_INTEGER )

	'' ','?
	if( hMatch( CHAR_COMMA ) ) then
		'' Expression{int}
		hMatchExpressionEx( expr3, FB_DATATYPE_INTEGER )
	else
		expr3 = astNewCONSTi( -1 )
	end if

	'' ')'
	hMatchRPRNT( )

	'' '='
	if( cAssignToken( ) = FALSE ) then
		errReport( FB_ERRMSG_EXPECTEDEQ )
	end if

	'' Expression{str}
	hMatchExpressionEx( expr4, FB_DATATYPE_STRING )

	function = rtlStrAssignMid( expr1, expr2, expr3, expr4 ) <> NULL
end function

#define CREATEFAKEID() _
	astNewVAR( symbAddTempVar( FB_DATATYPE_STRING ) )

'':::::
'' LRsetStmt        =   LSET|RSET String|UDT (','|'=') Expression|UDT
function cLRSetStmt(byval tk as FB_TOKEN) as integer
	dim as ASTNODE ptr dstexpr = any, srcexpr = any
	dim as integer dtype1 = any, dtype2 = any
	dim as FBSYMBOL ptr dst = any, src = any
	dim as integer is_rset = any

	function = FALSE

	'' (LSET|RSET)
	is_rset = (tk = FB_TK_RSET)
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' Expression
	dstexpr = cVarOrDeref( )
	if( dstexpr = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		'' error recovery: fake a var
		dstexpr = CREATEFAKEID( )
	end if

	astTryOvlStringCONV( dstexpr )

	dtype1 = astGetDataType( dstexpr )
	select case as const dtype1
	case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
		 FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR, _
		 FB_DATATYPE_STRUCT

		if( is_rset and (dtype1 = FB_DATATYPE_STRUCT) ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )
			'' error recovery: do lset instead
			is_rset = FALSE
		end if

		dim as FBSYMBOL ptr sym = astGetSymbol( dstexpr )

		if( sym = NULL ) then
			'' deref...
			if (astGetClass( dstexpr ) = AST_NODECLASS_DEREF) then
				sym = iif( astGetLeft( dstexpr ), astGetSymbol( astGetLeft( dstexpr ) ), NULL )
			end if
		end if

		if( sym = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDIDENTIFIER, TRUE )
		else
			if( symbIsConstant( sym ) or typeIsConst( astGetFullType( dstexpr ) ) ) then
				errReport( FB_ERRMSG_CONSTANTCANTBECHANGED, TRUE )
			end if
		end if

	case else
		errReport( FB_ERRMSG_INVALIDDATATYPES )
		'' error recovery: fake a var
		astDelTree( dstexpr )
		dstexpr = CREATEFAKEID( )
	end select

	'' ',' or '='
	if( hMatch( CHAR_COMMA ) = FALSE ) then
		if( cAssignToken( ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDCOMMA )
		end if
	end if

	'' Expression
	hMatchExpressionEx( srcexpr, dtype1 )

	astTryOvlStringCONV( srcexpr )

	dtype2 = astGetDataType( srcexpr )
	select case as const dtype2
	case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
		 FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR, _
		 FB_DATATYPE_STRUCT

	case else
		errReport( FB_ERRMSG_INVALIDDATATYPES )
		'' error recovery: fake a var
		astDelTree( srcexpr )
		srcexpr = CREATEFAKEID( )
	end select

	if( (dtype1 = FB_DATATYPE_STRUCT) or _
		(dtype2 = FB_DATATYPE_STRUCT) ) then

		if( dtype1 <> dtype2 ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )
			'' no error recovery: stmt already parsed
			astDelTree( srcexpr )
			astDelTree( dstexpr )
			return TRUE
		end if

		dst = astGetSymbol( dstexpr )
		src = astGetSymbol( srcexpr )
		if( (dst = NULL) or (src = NULL) ) then
			errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
			'' no error recovery: stmt already parsed
			astDelTree( srcexpr )
			astDelTree( dstexpr )
			return TRUE
		end if

		assert( symbGetLen( dst->subtype ) > 0 )
		assert( symbGetLen( src->subtype ) > 0 )

		function = rtlMemCopyClear( dstexpr, symbGetLen( dst->subtype ), _
									srcexpr, symbGetLen( src->subtype ) )
	else
		'' !!!TODO!!! - if udt extends z|wstring, check if operator len()
		'' was overloaded and pass the length parameters to a separate
		'' rtlib function
		function = rtlStrLRSet( dstexpr, srcexpr, is_rset )
	end if

end function

private function cStrCHR(byval is_wstr as integer) as ASTNODE ptr
		'' Max length of a single octal code is 11 digits for &hffffffffU
	static as zstring * 11+1 o
	static as zstring * 32*(2+11)+1 zs
	static as wstring * 32*(2+11)+1 ws
	dim as integer v = any, i = any, cnt = any, isconst = any
	dim as ASTNODE ptr exprtb(0 to 31) = any

	hMatchLPRNT( )

	cnt = 0
	do
		hMatchExpressionEx( exprtb(cnt), FB_DATATYPE_ULONG )
		cnt += 1
		if( cnt >= 32 ) then
			exit do
		end if
	loop while( hMatch( CHAR_COMMA ) )

	hMatchRPRNT( )

	'' If all arguments are constant do the evaluation at compile-time.
	'' We can do this because we generate internal escape codes which are
	'' independent of compiler or target's sizeof(wstring) or the locale.
	isconst = TRUE
	for i = 0 to cnt-1
		if( astIsCONST( exprtb(i) ) = FALSE ) then
			isconst = FALSE
			exit for
		end if

		'' when the constant value is 0, we must not handle
		'' this as a constant string
		if( astConstEqZero( exprtb(i) ) ) then
			isconst = FALSE
			exit for
		end if
	next

	if( isconst ) then
		if( is_wstr = FALSE ) then
			zs = ""
		else
			ws = ""
		end if

		for i = 0 to cnt-1
			v = astConstFlushToInt( exprtb(i), FB_DATATYPE_ULONG )
			exprtb(i) = NULL

			if( is_wstr = FALSE ) then
				if( culngint( v ) > 255 ) then
					v = 255
				end if
				if( (v < CHAR_SPACE) or (v > 127) ) then
					zs += ESCCHAR
					o = oct( v )
					zs += chr( len( o ) )
					zs += o
				else
					zs += chr( v )
				end if
			else
				if( (v < CHAR_SPACE) or (v > 127) ) then
					ws += ESCCHAR
					o = oct( v )
					ws += wchr( len( o ) )
					ws += o
				else
					ws += wchr( v )
				end if
			end if
		next

		if( is_wstr = FALSE ) then
			function = astNewVAR( symbAllocStrConst( zs, cnt ) )
		else
			function = astNewVAR( symbAllocWstrConst( ws, cnt ) )
		end if
	else
		function = rtlStrChr( cnt, exprtb(), is_wstr )
	end if
end function

private function cStrASC() as ASTNODE ptr
	dim as ASTNODE ptr expr1 = any, posexpr = any
	dim as longint p = any

	hMatchLPRNT( )
	hMatchExpressionEx( expr1, FB_DATATYPE_STRING )

	'' (',' Expression)?
	if( hMatch( CHAR_COMMA ) ) then
		hMatchExpressionEx( posexpr, FB_DATATYPE_INTEGER )
	else
		posexpr = NULL
	end if

	hMatchRPRNT( )

	'' constant? evaluate at compile-time
	dim as FBSYMBOL ptr litsym = NULL
	select case astGetDataType( expr1 )
	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
		litsym = astGetStrLitSymbol( expr1 )
	end select

	if( litsym <> NULL ) then
		'' if wstring, check if compile-time conversion can be done
		if( (astGetDataType( expr1 ) = FB_DATATYPE_WCHAR) and _
			(env.wchar_doconv = FALSE) ) then
			p = -1
		else
			'' pos is an constant too?
			if( posexpr <> NULL ) then
				if( astIsCONST( posexpr ) ) then
					p = astConstFlushToInt( posexpr )
					posexpr = NULL

					if( p < 0 ) then
						p = 0
					end if
				else
					p = -1
				end if
			else
				p = 1
			end if
		end if

		if( p >= 0 ) then

			'' !!!TODO!!! we would probably prefer that fbc just call ASC() in the runtime lib
			'' - maybe add new ASC() entry points to rtlib?:
			'' - a new rtlib function allowing the actual length to specified would move this function
			''   from here back in to the rtlib
			''     ASC( const zstring ptr, pos as integer, textlen as integer ) as ulong
			''     ASC( const wstring ptr, pos as integer, textlen as integer ) as ulong
			'' Because previously in either the zstring or wstring case:
			''    function = astNewCONSTi( asc( *zs, p ), FB_DATATYPE_UINT )
			''    function = astNewCONSTi( asc( *ws, p ), FB_DATATYPE_UINT )
			'' The zstring|wstring ptr loses the actual length when passed to ASC() in the rtlib
			'' if the constant string contains an embedded NUL CHAR then ASC will fail for any
			'' position after the first embedded NUL char.

			dim textlen as integer
			'' zstring?
			if( astGetDataType( expr1 ) <> FB_DATATYPE_WCHAR ) then
				'' remove internal escape format
				dim as zstring ptr zs = hUnescape( symbGetVarLitText( litsym ), textlen )

				'' use the textlen returned from hUnescape() to check the range on position
				if( (zs = NULL) orelse (textlen = 0) orelse  (p <= 0) orelse (p > textlen) ) then
					function = astNewCONSTi( clngint( 0 ), FB_DATATYPE_UINT )
				else
					function = astNewCONSTi( clngint( (*zs)[p-1] ), FB_DATATYPE_UINT )
				end if
			'' wstring..
			else
				'' remove internal escape format
				dim as wstring ptr ws = hUnescapeW( symbGetVarLitTextW( litsym ), textlen )

				'' use the textlen returned from hUnescapeW() to check the range on position
				if( (ws = NULL) orelse (textlen = 0) orelse  (p <= 0) orelse (p > textlen) ) then
					function = astNewCONSTi( clngint( 0 ), FB_DATATYPE_UINT )
				else
					function = astNewCONSTi( clngint( (*ws)[p-1] ), FB_DATATYPE_UINT )
				end if
			end if
			astDelNode( expr1 )
			expr1 = NULL
		end if
	end if

	if( expr1 <> NULL ) then
		function = rtlStrAsc( expr1, posexpr )
	end if
end function

'':::::
'' cCVXFunct    =   CVD       '(' Expression{str} ')'
''              |   CVS       '(' Expression{str} ')'
''              |   CVI       '(' Expression{str} ')'
''              |   CVL       '(' Expression{str} ')'
''              |   CVSHORT   '(' Expression{str} ')'
''              |   CVLONGINT '(' Expression{str} ')'
''
function cCVXFunct(byval tk as FB_TOKEN) as ASTNODE ptr
	'' CVD | CVS | CVI | CVL | CVSHORT | CVLONGINT
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	dim as FB_DATATYPE dtype = FB_DATATYPE_INVALID

	'' ['<' lgt '>']
	if( (tk = FB_TK_CVI) andalso hMatch( FB_TK_LT ) ) then

		'' expr
		var lgt = cConstIntExpr( cGtInParensOnlyExpr( ) )

		 '' disallow BYTEs here (would need to use ASC)
		if( lgt = 8 ) then lgt = 0

		dtype = hIntegerTypeFromBitSize( lgt, FALSE )

		if( hMatch( FB_TK_GT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDGT )
		end if

	end if

	'' '('
	hMatchLPRNT( )

	'' string expression
	dim as ASTNODE ptr expr1 = any
	hMatchExpressionEx( expr1, FB_DATATYPE_STRING )

	'' ')'
	hMatchRPRNT( )

	'' constant? evaluate at compile-time
	dim as FBSYMBOL ptr litsym = NULL
	dim as integer is_str = FALSE
	select case astGetDataType( expr1 )
	case FB_DATATYPE_CHAR
		litsym = astGetStrLitSymbol( expr1 )
		is_str = TRUE
	case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, FB_DATATYPE_WCHAR
		is_str = TRUE
	end select

	dim as integer allowconst = TRUE

	'' determine return type (use this to determine function name)
	dim as FB_DATATYPE functype = any
	select case as const tk
	case FB_TK_CVD
		functype = FB_DATATYPE_DOUBLE
		allowconst = FALSE
	case FB_TK_CVS
		functype = FB_DATATYPE_SINGLE
		allowconst = FALSE
	case FB_TK_CVI
		if( dtype <> FB_DATATYPE_INVALID ) then
			functype = dtype
		else
			functype = env.lang.integerkeyworddtype
		end if

	case FB_TK_CVL
		functype = FB_DATATYPE_LONG
	case FB_TK_CVSHORT
		functype = FB_DATATYPE_SHORT
	case else
		assert(tk = FB_TK_CVLONGINT)
		functype = FB_DATATYPE_LONGINT
	end select

	dim as zstring ptr zs = any
	dim as integer zslen = any
	if( (allowconst <> FALSE) and (litsym <> NULL) ) then
		'' remove internal escape format
		zs = hUnescape( symbGetVarLitText( litsym ) )
		zslen = len( *zs )
	else
		zs = NULL
		zslen = 0
	end if

	dim as ASTNODE ptr funcexpr = NULL
	'' string parameter, or CVSHORT/CVI<16> (which can only take strings)
	if( is_str orelse (functype = FB_DATATYPE_SHORT) ) then
		if( zslen >= typeGetSize( functype ) ) then
			select case( functype )
			case FB_DATATYPE_DOUBLE
				funcexpr = astNewCONSTf( cvd( *zs ), FB_DATATYPE_DOUBLE )
			case FB_DATATYPE_SINGLE
				funcexpr = astNewCONSTf( cvs( *zs ), FB_DATATYPE_SINGLE )
			case else
				select case( typeGetSize( functype ) )
				case 2
					funcexpr = astNewCONSTi( cvshort( *zs ), FB_DATATYPE_SHORT )
				case 4
					funcexpr = astNewCONSTi( cvl( *zs ), functype )
				case else
					funcexpr = astNewCONSTi( cvlongint( *zs ), functype )
				end select
			end select
			astDelNode( expr1 )
		else
			select case( functype )
			case FB_DATATYPE_DOUBLE
				funcexpr = astNewCALL( PROCLOOKUP( CVD ) )
			case FB_DATATYPE_SINGLE
				funcexpr = astNewCALL( PROCLOOKUP( CVS ) )
			case else
				select case( typeGetSize( functype ) )
				case 2
					funcexpr = astNewCALL( PROCLOOKUP( CVSHORT ) )
				case 4
					funcexpr = astNewCALL( PROCLOOKUP( CVL ) )
				case else
					funcexpr = astNewCALL( PROCLOOKUP( CVLONGINT ) )
				end select
			end select

			'' byref expr as string
			if( astNewARG( funcexpr, expr1 ) = NULL ) then
				funcexpr = NULL
			end if
		end if
	else
		select case( functype )
		case FB_DATATYPE_DOUBLE
			funcexpr = astNewCALL( PROCLOOKUP( CVDFROMLONGINT ) )
		case FB_DATATYPE_SINGLE
			funcexpr = astNewCALL( PROCLOOKUP( CVSFROML ) )
		case else
			if( typeGetSize( functype ) = 4 ) then
				funcexpr = astNewCALL( PROCLOOKUP( CVLFROMS ) )
			else
				funcexpr = astNewCALL( PROCLOOKUP( CVLONGINTFROMD ) )
			end if
		end select

		if( funcexpr <> NULL ) then
			'' byref expr as numtype
			if( astNewARG( funcexpr, expr1 ) = NULL ) then
				funcexpr = NULL
			end if
		end if
	end if

	if( funcexpr <> NULL ) then
		funcexpr = astNewCONV( functype, NULL, funcexpr )
	end if

	if( funcexpr = NULL ) then
		'' miscellaneous problem, this message should be roughly appropriate
		errReport( FB_ERRMSG_INVALIDDATATYPES )
	end if

	function = funcexpr
end function

'':::::
'' cMKXFunct    =   MKD       '(' Expression{double}  ')'
''              |   MKS       '(' Expression{float}   ')'
''              |   MKI       '(' Expression{int}     ')'
''              |   MKL       '(' Expression{long}    ')'
''              |   MKSHORT   '(' Expression{short}   ')'
''              |   MKLONGINT '(' Expression{longint} ')'
''
function cMKXFunct(byval tk as FB_TOKEN) as ASTNODE ptr
	'' MKD | MKS | MKI | MKL | MKSHORT | MKLONGINT
	lexSkipToken( LEXCHECK_POST_STRING_SUFFIX )

	dim as FB_DATATYPE dtype = FB_DATATYPE_INVALID

	'' ['<' lgt '>']
	if( (tk = FB_TK_MKI) andalso hMatch( FB_TK_LT ) ) then

		'' expr
		var lgt = cConstIntExpr( cGtInParensOnlyExpr( ) )

		 '' disallow BYTEs here (would need to use CHR)
		if( lgt = 8 ) then lgt = 0

		dtype = hIntegerTypeFromBitSize( lgt, FALSE )

		if( hMatch( FB_TK_GT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDGT )
		end if

	end if


	hMatchLPRNT( )

	dim as ASTNODE ptr expr1 = any
	hMatchExpressionEx( expr1, FB_DATATYPE_STRING )

	hMatchRPRNT( )

	dim as ASTNODE ptr funcexpr = NULL

	#macro doMKX( token )
		select case as const astGetDataType( expr1 )
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			funcexpr = astNewCONSTstr( str( token( astConstGetAsInt64( expr1 ) ) ) )
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			funcexpr = astNewCONSTstr( str( token( astConstGetAsDouble( expr1 ) ) ) )
		case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
			if( 4 = len( integer ) ) then
				funcexpr = astNewCONSTstr( str( token( astGetValueAsInt( expr1 ) ) ) )
			else
				funcexpr = astNewCONSTstr( str( token( astConstGetAsInt64( expr1 ) ) ) )
			end if
		case else
			funcexpr = astNewCONSTstr( str( token( astGetValueAsInt( expr1 ) ) ) )
		end select
	#endmacro

'   '' I don't know how to do this properly, the NULLs ruin it.
'   '' constant? eval at compile-time
'   if( astIsCONST( expr1 ) ) then
'       select case as const tk
'       case FB_TK_MKD
'           doMKX( mkd )
'       case FB_TK_MKS
'           doMKX( mks )
'       case FB_TK_MKI
'           doMKX( mki )
'       case FB_TK_MKL
'           doMKX( mkl )
'       case FB_TK_MKSHORT
'           doMKX( mkshort )
'       case FB_TK_MKLONGINT
'           doMKX( mklongint )
'       end select
'       astDelNode( expr1 )
'       expr1 = NULL
'   end if

	if( expr1 <> NULL ) then
		select case as const tk
		case FB_TK_MKD
			funcexpr = astNewCALL( PROCLOOKUP( MKD ) )
		case FB_TK_MKS
			funcexpr = astNewCALL( PROCLOOKUP( MKS ) )
		case FB_TK_MKI
			if( dtype = FB_DATATYPE_INVALID ) then
				dtype = env.lang.integerkeyworddtype
			end if

			if( typeGetDtAndPtrOnly( dtype ) = FB_DATATYPE_INTEGER ) then
				'' fb_MKI() is for INTEGERs, both on 32bit and on 64bit
				funcexpr = astNewCALL( PROCLOOKUP( MKI ) )
			else
				select case( typeGetSizeType( dtype ) )
				case FB_SIZETYPE_INT16
					funcexpr = astNewCALL( PROCLOOKUP( MKSHORT ) )
				case FB_SIZETYPE_INT32
					funcexpr = astNewCALL( PROCLOOKUP( MKL ) )
				case FB_SIZETYPE_INT64
					funcexpr = astNewCALL( PROCLOOKUP( MKLONGINT ) )
				end select
			end if

		case FB_TK_MKL
			funcexpr = astNewCALL( PROCLOOKUP( MKL ) )
		case FB_TK_MKSHORT
			funcexpr = astNewCALL( PROCLOOKUP( MKSHORT ) )
		case else
			assert(tk = FB_TK_MKLONGINT)
			funcexpr = astNewCALL( PROCLOOKUP( MKLONGINT ) )
		end select

		'' byval expr as {type}
		if( astNewARG( funcexpr, expr1 ) = NULL ) then
			funcexpr = NULL
		end if
	end if

	if( funcexpr = NULL ) then
		'' miscellaneous problem, this message should be roughly appropriate
		errReport( FB_ERRMSG_INVALIDDATATYPES )
	end if

	function = funcexpr
end function


'':::::
'' cStringFunct =   W|STR$ '(' Expression{bool|int|float|double} ')'
''              |   MID$ '(' Expression ',' Expression (',' Expression)? ')'
''              |   W|STRING$ '(' Expression ',' Expression{int|str} ')' .
''              |   INSTR '(' (Expression{int} ',')? Expression{str}, "ANY"? Expression{str} ')'
''              |   INSTRREV '(' Expression{str}, "ANY"? Expression{str} (',' Expression{int})? ')'
''              |   RTRIM$ '(' Expression{str} (, "ANY" Expression{str} )? ')'
''              |   LCASE|UCASE '(' Expression{str} [, Expression{integer}] ')'
''
function cStringFunct(byval tk as FB_TOKEN) as ASTNODE ptr
	dim as ASTNODE ptr expr1 = any, expr2 = any, expr3 = any
	dim as integer dclass = any, dtype = any, is_any = any, is_wstr = any

	function = NULL

	select case tk
	'' W|STR '(' Expression{bool|int|float|double|wstring} ')'
	case FB_TK_STR, FB_TK_WSTR
		is_wstr = (tk = FB_TK_WSTR)
		lexSkipToken( iif( is_wstr, LEXCHECK_POST_SUFFIX, LEXCHECK_POST_STRING_SUFFIX ) )

		hMatchLPRNT( )
		hMatchExpressionEx( expr1, FB_DATATYPE_INTEGER )
		hMatchRPRNT( )

		if( is_wstr = FALSE ) then
			expr1 = rtlToStr( expr1, fbLangIsSet( FB_LANG_QB ) )
		else
			expr1 = rtlToWstr( expr1 )
		end if
		if( expr1 = NULL ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )
			expr1 = astNewCONSTi( 0 )
		end if

		function = expr1

	'' MID '(' Expression ',' Expression (',' Expression)? ')'
	case FB_TK_MID
		lexSkipToken( LEXCHECK_POST_STRING_SUFFIX )

		hMatchLPRNT( )
		hMatchExpressionEx( expr1, FB_DATATYPE_STRING )
		hMatchCOMMA( )
		hMatchExpressionEx( expr2, FB_DATATYPE_INTEGER )
		if( hMatch( CHAR_COMMA ) ) then
			hMatchExpressionEx( expr3, FB_DATATYPE_INTEGER )
		else
			expr3 = astNewCONSTi( -1 )
		end if
		hMatchRPRNT( )

		expr1 = rtlStrMid( expr1, expr2, expr3 )
		if( expr1 = NULL ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )
			expr1 = astNewCONSTi( 0 )
		end if

		function = expr1

	'' W|STRING '(' Expression ',' Expression{int|str} ')'
	case FB_TK_STRING, FB_TK_WSTRING
		is_wstr = (tk = FB_TK_WSTRING)
		lexSkipToken( iif( is_wstr, LEXCHECK_POST_SUFFIX, LEXCHECK_POST_STRING_SUFFIX ) )


		hMatchLPRNT( )
		hMatchExpressionEx( expr1, FB_DATATYPE_INTEGER )
		hMatchCOMMA( )
		hMatchExpressionEx( expr2, FB_DATATYPE_INTEGER )
		hMatchRPRNT( )

		if( is_wstr = FALSE ) then
			expr1 = rtlStrFill( expr1, expr2 )
		else
			expr1 = rtlWstrFill( expr1, expr2 )
		end if
		if( expr1 = NULL ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )
			expr1 = astNewCONSTi( 0 )
		end if

		function = expr1

	'' W|CHR '(' Expression (',' Expression )* ')'
	case FB_TK_CHR, FB_TK_WCHR
		is_wstr = (tk = FB_TK_WCHR)
		lexSkipToken( iif( is_wstr, LEXCHECK_POST_SUFFIX, LEXCHECK_POST_STRING_SUFFIX ) )

		function = cStrCHR(is_wstr)

	'' ASC '(' Expression (',' Expression)? ')'
	case FB_TK_ASC
		lexSkipToken( LEXCHECK_POST_SUFFIX )

		function = cStrASC()

	case FB_TK_INSTR
		lexSkipToken( LEXCHECK_POST_SUFFIX )

		hMatchLPRNT( )
		hMatchExpressionEx( expr1, FB_DATATYPE_INTEGER )
		hMatchCOMMA( )
		is_any = hMatch( FB_TK_ANY, LEXCHECK_POST_SUFFIX )
		hMatchExpressionEx( expr2, FB_DATATYPE_STRING )
		expr3 = NULL
		if( is_any = FALSE ) then
			if( hMatch( CHAR_COMMA ) ) then
				is_any = hMatch( FB_TK_ANY, LEXCHECK_POST_SUFFIX )
				hMatchExpressionEx( expr3, FB_DATATYPE_STRING )
			end if
		end if
		if( expr3 = NULL ) then
			expr3 = expr2
			expr2 = expr1
			expr1 = astNewCONSTi( 1 )
		end if
		hMatchRPRNT( )

		expr1 = rtlStrInstr( expr1, expr2, expr3, is_any )
		if( expr1 = NULL ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )
			expr1 = astNewCONSTi( 0 )
		end if

		function = expr1

	case FB_TK_INSTRREV
		lexSkipToken( LEXCHECK_POST_SUFFIX )

		hMatchLPRNT( )
		hMatchExpressionEx( expr1, FB_DATATYPE_STRING )
		hMatchCOMMA( )
		is_any = hMatch( FB_TK_ANY, LEXCHECK_POST_SUFFIX )
		hMatchExpressionEx( expr2, FB_DATATYPE_STRING )
		if( hMatch( CHAR_COMMA ) ) then
			hMatchExpressionEx( expr3, FB_DATATYPE_INTEGER )
		else
			expr3 = astNewCONSTi( -1 )
		end if
		hMatchRPRNT( )

		expr1 = rtlStrInstrRev( expr3, expr1, expr2, is_any )
		if( expr1 = NULL ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )
			expr1 = astNewCONSTi( 0 )
		end if

		function = expr1

	case FB_TK_TRIM, FB_TK_LTRIM, FB_TK_RTRIM
		lexSkipToken( LEXCHECK_POST_STRING_SUFFIX )

		hMatchLPRNT( )
		hMatchExpressionEx( expr1, FB_DATATYPE_STRING )
		if( hMatch( CHAR_COMMA ) ) then
			is_any = hMatch( FB_TK_ANY, LEXCHECK_POST_SUFFIX )
			hMatchExpressionEx( expr2, FB_DATATYPE_STRING )
		else
			is_any = FALSE
			expr2 = NULL
		end if
		hMatchRPRNT( )

		select case (tk)
		case FB_TK_TRIM
			expr1 = rtlStrTrim( expr1, expr2, is_any )
		case FB_TK_LTRIM
			expr1 = rtlStrLTrim( expr1, expr2, is_any )
		case FB_TK_RTRIM
			expr1 = rtlStrRTrim( expr1, expr2, is_any )
		end select

		if( expr1 = NULL ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )
			expr1 = astNewCONSTi( 0 )
		end if

		function = expr1

	'' LCASE|UCASE '(' Expression{string} [, Expression{integer}] ')'
	case FB_TK_LCASE, FB_TK_UCASE
		lexSkipToken( LEXCHECK_POST_STRING_SUFFIX )

		hMatchLPRNT( )
		hMatchExpressionEx( expr1, FB_DATATYPE_STRING )

		'' Mode parameter given?
		if( hMatch( CHAR_COMMA ) ) then
			hMatchExpressionEx( expr2, FB_DATATYPE_INTEGER )
		else
			expr2 = NULL  '' Let rtlStrCase() use the default value
		end if

		hMatchRPRNT( )

		function = rtlStrCase( expr1, expr2, (tk = FB_TK_LCASE) )

	end select

end function
