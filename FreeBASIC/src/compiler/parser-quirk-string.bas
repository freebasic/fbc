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


'' quirk string statements (MID, LSET) and functions (MID, INSTR) parsing
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"

'':::::
''MidStmt   	  =   MID '(' Expression{str}, Expression{int} (',' Expression{int}) ')' '=' Expression{str} .
''
function cMidStmt _
	( _
		_
	) as integer

	dim as ASTNODE ptr expr1 = any, expr2 = any, expr3 = any, expr4 = any

	function = FALSE

	if( hMatch( FB_TK_MID ) ) then

		hMatchLPRNT()

		hMatchExpressionEx( expr1, FB_DATATYPE_STRING )

		hMatchCOMMA( )

		hMatchExpressionEx( expr2, FB_DATATYPE_INTEGER )

		if( hMatch( CHAR_COMMA ) ) then
			hMatchExpressionEx( expr3, FB_DATATYPE_INTEGER )
		else
			expr3 = astNewCONSTi( -1, FB_DATATYPE_INTEGER )
		end if

		hMatchRPRNT( )

		if( hMatch( FB_TK_ASSIGN ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDEQ ) = FALSE ) then
				exit function
			end if
		end if

		hMatchExpressionEx( expr4, FB_DATATYPE_STRING )

		function = rtlStrAssignMid( expr1, expr2, expr3, expr4 ) <> NULL
	end if

end function

#define CREATEFAKEID() _
	astNewVAR( symbAddTempVar( FB_DATATYPE_STRING ), 0, FB_DATATYPE_STRING )

'':::::
'' LsetStmt		=	LSET String|UDT (','|'=') Expression|UDT
function cLSetStmt _
	( _
		_
	) as integer

    dim as ASTNODE ptr dstexpr = any, srcexpr = any
    dim as integer dtype1 = any, dtype2 = any
    dim as FBSYMBOL ptr dst = any, src = any

    function = FALSE

	'' LSET
	lexSkipToken( )

	'' Expression
	if( cVarOrDeref( dstexpr ) = FALSE ) then
		if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
			exit function
		else
			'' error recovery: fake a var
			dstexpr = CREATEFAKEID( )
		end if
	end if

	dtype1 = astGetDataType( dstexpr )
	select case dtype1
	case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
		 FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR, _
		 FB_DATATYPE_USERDEF

	case else
		if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
			exit function
		else
			'' error recovery: fake a var
			astDelTree( dstexpr )
			dstexpr = CREATEFAKEID( )
		end if
	end select

	'' ',' or '='
	if( hMatch( CHAR_COMMA ) = FALSE ) then
        if( hMatch( FB_TK_ASSIGN ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDCOMMA ) = FALSE ) then
				exit function
			end if
        end if
	end if

	'' Expression
	hMatchExpressionEx( srcexpr, dtype1 )

	dtype2 = astGetDataType( srcexpr )
	select case dtype2
	case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
		 FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR, _
		 FB_DATATYPE_USERDEF

	case else
		if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
			exit function
		else
			'' error recovery: fake a var
			astDelTree( srcexpr )
			srcexpr = CREATEFAKEID( )
		end if
	end select

	if( (dtype1 = FB_DATATYPE_USERDEF) or _
		(dtype2 = FB_DATATYPE_USERDEF) ) then

		if( dtype1 <> dtype2 ) then
			if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
				exit function
			else
				'' no error recovery: stmt already parsed
				astDelTree( srcexpr )
				astDelTree( dstexpr )
				return TRUE
			end if
		end if

		dst = astGetSymbol( dstexpr )
		src = astGetSymbol( srcexpr )
		if( (dst = NULL) or (src = NULL) ) then
			if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
				exit function
			else
				'' no error recovery: stmt already parsed
				astDelTree( srcexpr )
				astDelTree( dstexpr )
				return TRUE
			end if
		end if

		function = rtlMemCopyClear( dstexpr, symbGetUDTUnpadLen( dst->subtype ), _
									srcexpr, symbGetUDTUnpadLen( src->subtype ) )
	else
		function = rtlStrLset( dstexpr, srcexpr )
	end if

end function

'':::::
private function cStrCHR _
	( _
		byref funcexpr as ASTNODE ptr, _
		byval is_wstr as integer _
	) as integer

	static as zstring * 32*6+1 zs
	static as wstring * 32*6+1 ws
	static as zstring * 8+1 o
	dim as integer v = any, i = any, cnt = any, isconst = any
	dim as ASTNODE ptr exprtb(0 to 31) = any, expr = any

	function = FALSE

	hMatchLPRNT( )

	cnt = 0
	do
		hMatchExpressionEx( exprtb(cnt), FB_DATATYPE_INTEGER )
		cnt += 1
		if( cnt >= 32 ) then
			exit do
		end if
	loop while( hMatch( CHAR_COMMA ) )

	hMatchRPRNT( )

	'' if wstring, check if compile-time conversion can be done
	if( is_wstr and (env.target.wchar.doconv = FALSE) ) then
		isconst = FALSE

	else
		'' constant? evaluate at compile-time
		isconst = TRUE
		for i = 0 to cnt-1
			if( astIsCONST( exprtb(i) ) = FALSE ) then
				isconst = FALSE
				exit for
        	end if

        	'' when the constant value is 0, we must not handle
            '' this as a constant string
  			v = astGetValueAsInt( exprtb(i) )
			if( v = 0 ) then
				isconst = FALSE
				exit for
			end if
		next
	end if

	if( isconst ) then
		if( is_wstr = FALSE ) then
			zs = ""
		else
			ws = ""
		end if

		for i = 0 to cnt-1
  			expr = exprtb(i)
  			v = astGetValueAsInt( expr )
  			astDelNode( expr )

			if( is_wstr = FALSE ) then
				if( cuint( v ) > 255 ) then
					v = 255
				end if
				if( (v < CHAR_SPACE) or (v > 127) ) then
					zs += "\27"
					o = oct( v )
					zs += chr( len( o ) )
					zs += o
				else
					zs += chr( v )
				end if

			else
				if( (v < CHAR_SPACE) or (v > 127) ) then
					ws += "\27"
					o = oct( v )
					ws += wchr( len( o ) )
					ws += o
				else
					ws += wchr( v )
				end if
			end if
		next

		if( is_wstr = FALSE ) then
			funcexpr = astNewVAR( symbAllocStrConst( zs, cnt ), _
								  0, _
								  FB_DATATYPE_CHAR )
		else
			funcexpr = astNewVAR( symbAllocWstrConst( ws, cnt ), _
								  0, _
								  FB_DATATYPE_WCHAR )
		end if

    else

		funcexpr = rtlStrChr( cnt, exprtb(), is_wstr )

	end if

	function = funcexpr <> NULL

end function

'':::::
private function cStrASC _
	( _
		byref funcexpr as ASTNODE ptr _
	) as integer

    dim as ASTNODE ptr expr1 = any, posexpr = any
    dim as integer p = any
    dim as FBSYMBOL ptr litsym = any

	function = FALSE

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
	litsym = NULL
	select case astGetDataType( expr1 )
	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
		litsym = astGetStrLitSymbol( expr1 )
	end select

	if( litsym <> NULL ) then
		'' if wstring, check if compile-time conversion can be done
        if( (astGetDataType( expr1 ) = FB_DATATYPE_WCHAR) and _
			(env.target.wchar.doconv  = FALSE) ) then
			p = -1

		else
			'' pos is an constant too?
			if( posexpr <> NULL ) then
				if( astIsCONST( posexpr ) ) then
					p = astGetValueAsInt( posexpr )
					astDelNode( posexpr )

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
			'' zstring?
			if( astGetDataType( expr1 ) <> FB_DATATYPE_WCHAR ) then
				'' remove internal escape format
				dim as zstring ptr zs = hUnescape( symbGetVarLitText( litsym ) )
				funcexpr = astNewCONSTi( asc( *zs, p ), FB_DATATYPE_INTEGER )

			'' wstring..
	    	else
				'' ditto
				dim as wstring ptr ws = hUnescapeW( symbGetVarLitTextW( litsym ) )
				funcexpr = astNewCONSTi( asc( *ws, p ), FB_DATATYPE_INTEGER )
			end if

	    	astDelNode( expr1 )
	    	expr1 = NULL
	    end if

	end if

	if( expr1 <> NULL ) then
		funcexpr = rtlStrAsc( expr1, posexpr )
	end if

	function = funcexpr <> NULL

end function

'':::::
'' cStringFunct	=	W|STR$ '(' Expression{int|float|double} ')'
'' 				|   MID$ '(' Expression ',' Expression (',' Expression)? ')'
'' 				|   W|STRING$ '(' Expression ',' Expression{int|str} ')' .
''              |   INSTR '(' (Expression{int} ',')? Expression{str}, "ANY"? Expression{str} ')'
''              |   RTRIM$ '(' Expression{str} (, "ANY" Expression{str} )? ')'
''
function cStringFunct _
	( _
		byref funcexpr as ASTNODE ptr _
	) as integer

    dim as ASTNODE ptr expr1 = any, expr2 = any, expr3 = any
    dim as integer dclass = any, dtype = any, is_any = any, is_wstr = any

	function = FALSE

	select case lexGetToken( )
	'' W|STR '(' Expression{int|float|double|wstring} ')'
	case FB_TK_STR, FB_TK_WSTR
		is_wstr = (lexGetToken( ) = FB_TK_WSTR)
		lexSkipToken( )

		hMatchLPRNT( )

		hMatchExpressionEx( expr1, FB_DATATYPE_INTEGER )

		hMatchRPRNT( )

		if( is_wstr = FALSE ) then
			funcexpr = rtlToStr( expr1 )
		else
			funcexpr = rtlToWstr( expr1 )
		end if

		if( funcexpr = NULL ) then
			if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
               	exit function
			else
				funcexpr = astNewCONST( 0, FB_DATATYPE_INTEGER )
			end if
		end if

		function = TRUE

	'' MID '(' Expression ',' Expression (',' Expression)? ')'
	case FB_TK_MID
		lexSkipToken( )

		hMatchLPRNT( )

		hMatchExpressionEx( expr1, FB_DATATYPE_STRING )

		hMatchCOMMA( )

		hMatchExpressionEx( expr2, FB_DATATYPE_INTEGER )

		if( hMatch( CHAR_COMMA ) ) then
			hMatchExpressionEx( expr3, FB_DATATYPE_INTEGER )
		else
			expr3 = astNewCONSTi( -1, FB_DATATYPE_INTEGER )
		end if

		hMatchRPRNT( )

		funcexpr = rtlStrMid( expr1, expr2, expr3 )

		if( funcexpr = NULL ) then
			if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
               	exit function
			else
				funcexpr = astNewCONST( 0, FB_DATATYPE_INTEGER )
			end if
		end if

		function = TRUE

	'' W|STRING '(' Expression ',' Expression{int|str} ')'
	case FB_TK_STRING, FB_TK_WSTRING
		is_wstr = (lexGetToken( ) = FB_TK_WSTRING)
		lexSkipToken( )

		hMatchLPRNT( )

		hMatchExpressionEx( expr1, FB_DATATYPE_INTEGER )

		hMatchCOMMA( )

		hMatchExpressionEx( expr2, FB_DATATYPE_INTEGER )

		hMatchRPRNT( )

		if( is_wstr = FALSE ) then
			funcexpr = rtlStrFill( expr1, expr2 )
		else
			funcexpr = rtlWstrFill( expr1, expr2 )
		end if

		if( funcexpr = NULL ) then
			if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
               	exit function
			else
				funcexpr = astNewCONST( 0, FB_DATATYPE_INTEGER )
			end if
		end if

		function = TRUE

	'' W|CHR '(' Expression (',' Expression )* ')'
	case FB_TK_CHR, FB_TK_WCHR
		is_wstr = (lexGetToken( ) = FB_TK_WCHR)
		lexSkipToken( )

		function = cStrCHR( funcexpr, is_wstr )

	'' ASC '(' Expression (',' Expression)? ')'
	case FB_TK_ASC
		lexSkipToken( )

		function = cStrASC( funcexpr )

    case FB_TK_INSTR
        lexSkipToken( )

		hMatchLPRNT( )

		hMatchExpressionEx( expr1, FB_DATATYPE_INTEGER )

		hMatchCOMMA( )

        is_any = hMatch( FB_TK_ANY )

		hMatchExpressionEx( expr2, FB_DATATYPE_STRING )

        expr3 = NULL
        if( is_any = FALSE ) then
        	if( hMatch( CHAR_COMMA ) ) then
                is_any = hMatch( FB_TK_ANY )
                hMatchExpressionEx( expr3, FB_DATATYPE_STRING )
            end if
        end if

        if( expr3 = NULL ) then
            expr3 = expr2
            expr2 = expr1
			expr1 = astNewCONSTi( 1, FB_DATATYPE_INTEGER )
        end if

		hMatchRPRNT( )

		funcexpr = rtlStrInstr( expr1, expr2, expr3, is_any )

		if( funcexpr = NULL ) then
			if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
               	exit function
			else
				funcexpr = astNewCONST( 0, FB_DATATYPE_INTEGER )
			end if
		end if

		function = TRUE

    case FB_TK_TRIM
        lexSkipToken( )

        hMatchLPRNT( )

        hMatchExpressionEx( expr1, FB_DATATYPE_STRING )

        if( hMatch( CHAR_COMMA ) ) then
            is_any = hMatch( FB_TK_ANY )
	        hMatchExpressionEx( expr2, FB_DATATYPE_STRING )
        else
            is_any = FALSE
            expr2 = NULL
        end if

        hMatchRPRNT( )

		funcexpr = rtlStrTrim( expr1, expr2, is_any )

		if( funcexpr = NULL ) then
			if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
               	exit function
			else
				funcexpr = astNewCONST( 0, FB_DATATYPE_INTEGER )
			end if
		end if

		function = TRUE

    case FB_TK_RTRIM
        lexSkipToken( )

        hMatchLPRNT( )

        hMatchExpressionEx( expr1, FB_DATATYPE_STRING )

        if( hMatch( CHAR_COMMA ) ) then
            is_any = hMatch( FB_TK_ANY )
	        hMatchExpressionEx( expr2, FB_DATATYPE_STRING )
        else
            is_any = FALSE
            expr2 = NULL
        end if

        hMatchRPRNT( )

		funcexpr = rtlStrRTrim( expr1, expr2, is_any )

		if( funcexpr = NULL ) then
			if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
               	exit function
			else
				funcexpr = astNewCONST( 0, FB_DATATYPE_INTEGER )
			end if
		end if

		function = TRUE

    case FB_TK_LTRIM
        lexSkipToken( )

        hMatchLPRNT( )

        hMatchExpressionEx( expr1, FB_DATATYPE_STRING )

        if( hMatch( CHAR_COMMA ) ) then
            is_any = hMatch( FB_TK_ANY )
	        hMatchExpressionEx( expr2, FB_DATATYPE_STRING )
        else
            is_any = FALSE
            expr2 = NULL
        end if

        hMatchRPRNT( )

		funcexpr = rtlStrLTrim( expr1, expr2, is_any )

		if( funcexpr = NULL ) then
			if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
               	exit function
			else
				funcexpr = astNewCONST( 0, FB_DATATYPE_INTEGER )
			end if
		end if

		function = TRUE

	end select

end function

