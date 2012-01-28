'' quirk array statements (ERASE, SWAP) and functions (LBOUND, UBOUND) parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "rtl.bi"
#include once "ast.bi"

'':::::
''ArrayStmt   	  =   ERASE ID (',' ID)*;
''				  |   SWAP Variable, Variable .
''
function cArrayStmt _
	( _
		byval tk as FB_TOKEN _
	) as integer

	dim as FBSYMBOL ptr s
	dim as ASTNODE ptr expr1, expr2

	function = FALSE

	select case tk
	case FB_TK_ERASE
		lexSkipToken( )

		do
			expr1 = cVarOrDeref( FB_VAREXPROPT_NOARRAYCHECK )
			if( expr1 = NULL ) then
				errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
				hSkipUntil( CHAR_COMMA )
			else
				'' ugly hack to deal with arrays w/o indexes
				if( astIsNIDXARRAY( expr1 ) ) then
					expr2 = astGetLeft( expr1 )
					astDelNode( expr1 )
					expr1 = expr2
				end if

				'' array?
    			s = astGetSymbol( expr1 )
    			if( s <> NULL ) then
    				if( symbIsArray( s ) = FALSE ) then
    					s = NULL
    				end if
    			end if

				if( s = NULL ) then
					errReport( FB_ERRMSG_EXPECTEDARRAY )
					hSkipUntil( CHAR_COMMA )
				else
					if( typeIsConst( astGetFullType( expr1 ) ) ) then
						errReport( FB_ERRMSG_CONSTANTCANTBECHANGED )
					end if
					
					if( symbGetIsDynamic( s ) ) then
						expr1 = rtlArrayErase( expr1 )
					else
						expr1 = rtlArrayClear( expr1, TRUE )
					end if

					astAdd( expr1 )
				end if
			end if

		'' ','?
		loop while( hMatch( CHAR_COMMA ) )

		function = TRUE

	'' SWAP Variable, Variable
	case FB_TK_SWAP
		lexSkipToken( )

		expr1 = cVarOrDeref( FB_VAREXPROPT_ISASSIGN )
		if( expr1 = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
			hSkipStmt( )
			return TRUE
		end if

		hMatchCOMMA( )

		expr2 = cVarOrDeref( FB_VAREXPROPT_ISASSIGN )
		if( expr2 = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
			astDelTree( expr1 )
			hSkipStmt( )
			return TRUE
		end if

		select case as const astGetDataType( expr1 )
		case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR
			select case astGetDataType( expr2 )
			case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR
				function = rtlStrSwap( expr1, expr2 )
			case else
				errReport( FB_ERRMSG_TYPEMISMATCH )
			end select

		case FB_DATATYPE_WCHAR
			if( astGetDataType( expr2 ) <> FB_DATATYPE_WCHAR ) then
				errReport( FB_ERRMSG_TYPEMISMATCH )
			else
				function = rtlWstrSwap( expr1, expr2 )
			end if

		case else
			'' don't allow any consts...
			if( typeIsConst( astGetFullType( expr1 ) ) or _
			    typeIsConst( astGetFullType( expr2 ) ) ) then
				errReport( FB_ERRMSG_CONSTANTCANTBECHANGED )
			end if

			'' Check for invalid types by checking whether a raw assignment
			'' would work (raw because astCheckASSIGN() doesn't check
			'' operator overloads)
			dim as ASTNODE ptr fakelhs = astNewVAR( NULL, 0, astGetFullType( expr1 ), astGetSubtype( expr1 ) )
			if( astCheckASSIGN( fakelhs, expr2 ) = FALSE ) then
				errReport( FB_ERRMSG_TYPEMISMATCH )
			end if
			astDelTree( fakelhs )

			function = rtlMemSwap( expr1, expr2 )
		end select

	end select

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
