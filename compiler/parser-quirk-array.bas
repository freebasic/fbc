'' quirk array statements (ERASE, SWAP) and functions (LBOUND, UBOUND) parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "rtl.bi"
#include once "ast.bi"

'' EraseStmt = ERASE ID (',' ID)*
function cEraseStmt() as integer
	lexSkipToken( )

	do
		var expr = cVarOrDeref( FB_VAREXPROPT_NOARRAYCHECK )
		if( expr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
			hSkipUntil( CHAR_COMMA )
		else
			'' ugly hack to deal with arrays w/o indexes
			if( astIsNIDXARRAY( expr ) ) then
				var expr2 = astGetLeft( expr )
				astDelNode( expr )
				expr = expr2
			end if

			'' array?
			var s = astGetSymbol( expr )
			if( s <> NULL ) then
				if( symbIsArray( s ) = FALSE ) then
					s = NULL
				end if
			end if

			if( s = NULL ) then
				errReport( FB_ERRMSG_EXPECTEDARRAY )
				hSkipUntil( CHAR_COMMA )
			else
				if( typeIsConst( astGetFullType( expr ) ) ) then
					errReport( FB_ERRMSG_CONSTANTCANTBECHANGED )
				end if

				if( symbGetIsDynamic( s ) ) then
					expr = rtlArrayErase( expr )
				else
					expr = rtlArrayClear( expr, TRUE )
				end if

				astAdd( expr )
			end if
		end if

	'' ','?
	loop while( hMatch( CHAR_COMMA ) )

	function = TRUE
end function

'' SwapStmt = SWAP VarOrDeref ',' VarOrDeref
function cSwapStmt() as integer
	lexSkipToken( )

	var l = cVarOrDeref( FB_VAREXPROPT_ISASSIGN )
	if( l = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		hSkipStmt( )
		return TRUE
	end if

	hMatchCOMMA( )

	var r = cVarOrDeref( FB_VAREXPROPT_ISASSIGN )
	if( r = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		astDelTree( l )
		hSkipStmt( )
		return TRUE
	end if

	'' don't allow any consts...
	if( typeIsConst( astGetFullType( l ) ) or _
	    typeIsConst( astGetFullType( r ) ) ) then
		errReport( FB_ERRMSG_CONSTANTCANTBECHANGED )
	end if

	dim as integer ldtype = astGetDataType( l )
	dim as integer rdtype = astGetDataType( r )

	select case ldtype
	case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR
		select case rdtype
		case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR
			function = rtlStrSwap( l, r )
		case else
			errReport( FB_ERRMSG_TYPEMISMATCH )
		end select
		exit function
	end select

	if( ldtype = FB_DATATYPE_WCHAR ) then
		if( rdtype = FB_DATATYPE_WCHAR ) then
			function = rtlWstrSwap( l, r )
		else
			errReport( FB_ERRMSG_TYPEMISMATCH )
		end if
		exit function
	end if

	'' Check for invalid types by checking whether a raw assignment
	'' would work (raw because astCheckASSIGN() doesn't check
	'' operator overloads)
	dim as ASTNODE ptr fakelhs = astNewVAR( NULL, 0, astGetFullType( l ), astGetSubtype( l ) )
	dim as integer ok = astCheckASSIGN( fakelhs, r )
	astDelTree( fakelhs )
	if( ok = FALSE ) then
		errReport( FB_ERRMSG_TYPEMISMATCH )
		exit function
	end if

	return rtlMemSwap( l, r )
end function

'':::::
''cArrayFunct =   (LBOUND|UBOUND) '(' ID (',' Expression)? ')' .
''
function cArrayFunct(byval tk as FB_TOKEN) as ASTNODE ptr
	dim as ASTNODE ptr arrayexpr = any, dimexpr = any
	dim as integer is_lbound = any
	dim as FBSYMBOL ptr s = any

	function = NULL

	select case tk

	'' (LBOUND|UBOUND) '(' ID (',' Expression)? ')'
	case FB_TK_LBOUND, FB_TK_UBOUND
		is_lbound = (tk = FB_TK_LBOUND)
		lexSkipToken( )

		'' '('
		hMatchLPRNT( )

		'' ID
		arrayexpr = cVarOrDeref( FB_VAREXPROPT_NOARRAYCHECK )
		if( arrayexpr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
			'' error recovery: skip until next ')' and fake an expr
			hSkipUntil( CHAR_RPRNT, TRUE )
			return astNewCONSTi( 0, FB_DATATYPE_INTEGER )
		end if

		'' ugly hack to deal with arrays w/o indexes
		if( astIsNIDXARRAY( arrayexpr ) ) then
			dim as ASTNODE ptr expr = astGetLeft( arrayexpr )
			astDelNode( arrayexpr )
			arrayexpr = expr
		end if

		'' array?
		s = astGetSymbol( arrayexpr )
		if( s <> NULL ) then
			if( symbIsArray( s ) = FALSE ) then
				s = NULL
			end if
		end if

		if( s = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDARRAY, TRUE )
			'' error recovery: skip until next ')' and fake an expr
			hSkipUntil( CHAR_RPRNT, TRUE )
			return astNewCONSTi( 0, FB_DATATYPE_INTEGER )
		end if

		'' (',' Expression)?
		if( hMatch( CHAR_COMMA ) ) then
			hMatchExpressionEx( dimexpr, FB_DATATYPE_INTEGER )
		else
			dimexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
		end if

		'' ')'
		hMatchRPRNT( )

		function = rtlArrayBound( arrayexpr, dimexpr, is_lbound )
	end select
end function
