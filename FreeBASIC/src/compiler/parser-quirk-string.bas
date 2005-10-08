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
function cMidStmt as integer
	dim as ASTNODE ptr expr1, expr2, expr3, expr4

	function = FALSE

	if( hMatch( FB_TK_MID ) ) then

		hMatchLPRNT()

		hMatchExpression( expr1 )

		hMatchCOMMA( )

		hMatchExpression( expr2 )

		if( hMatch( CHAR_COMMA ) ) then
			hMatchExpression( expr3 )
		else
			expr3 = astNewCONSTi( -1, IR_DATATYPE_INTEGER )
		end if

		hMatchRPRNT( )

		if( not hMatch( FB_TK_ASSIGN ) ) then
			hReportError( FB_ERRMSG_EXPECTEDEQ )
			exit function
		end if

		hMatchExpression( expr4 )

		function = rtlStrAssignMid( expr1, expr2, expr3, expr4 ) <> NULL
	end if

end function

'':::::
'' LsetStmt		=	LSET String|UDT (','|'=') Expression|UDT
function cLSetStmt( ) as integer
    dim as ASTNODE ptr dstexpr, srcexpr
    dim as integer dtype1, dtype2
    dim as FBSYMBOL ptr dst, src

    function = FALSE

	'' LSET
	lexSkipToken( )

	'' Expression
	if( not cVarOrDeref( dstexpr ) ) then
		hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
		exit function
	end if

	dtype1 = astGetDataType( dstexpr )
	select case dtype1
	case IR_DATATYPE_STRING, IR_DATATYPE_FIXSTR, IR_DATATYPE_CHAR, IR_DATATYPE_USERDEF
	case else
		hReportError( FB_ERRMSG_INVALIDDATATYPES )
		exit function
	end select

	'' ',' or '='
	if( not hMatch( CHAR_COMMA ) ) then
        if( not hMatch( CHAR_EQ ) ) then
			hReportError( FB_ERRMSG_EXPECTEDCOMMA )
			exit function
        end if
	end if

	'' Expression
	hMatchExpression( srcexpr )

	dtype2 = astGetDataType( srcexpr )
	select case dtype2
	case IR_DATATYPE_STRING, IR_DATATYPE_FIXSTR, IR_DATATYPE_CHAR, IR_DATATYPE_USERDEF
	case else
		hReportError( FB_ERRMSG_INVALIDDATATYPES )
		exit function
	end select

	if( (dtype1 = IR_DATATYPE_USERDEF) or (dtype2 = IR_DATATYPE_USERDEF) ) then

		if( dtype1 <> dtype2 ) then
			hReportError( FB_ERRMSG_INVALIDDATATYPES )
			exit function
		end if

		dst = astGetSymbolOrElm( dstexpr )
		src = astGetSymbolOrElm( srcexpr )
		if( (dst = NULL) or (src = NULL) ) then
			hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
			exit function
		end if

		function = rtlMemCopyClear( dstexpr, symbGetUDTLen( dst->subtype ), _
									srcexpr, symbGetUDTLen( src->subtype ) )
	else
		function = rtlStrLset( dstexpr, srcexpr )
	end if

end function

'':::::
private function cStrCHR( byref funcexpr as ASTNODE ptr ) as integer
	static as zstring * 32*6+1 s
	static as zstring * 8+1 o
	dim as integer v, i, cnt, isconst
	dim as ASTNODE ptr exprtb(0 to 31), expr

	function = FALSE

	hMatchLPRNT( )

	cnt = 0
	do
		hMatchExpression( exprtb(cnt) )
		cnt += 1
		if( cnt >= 32 ) then
			exit do
		end if
	loop while( hMatch( CHAR_COMMA ) )

	hMatchRPRNT( )

	'' constant? evaluate at compile-time
	isconst = TRUE
	for i = 0 to cnt-1
		if( not astIsCONST( exprtb(i) ) ) then
			isconst = FALSE
			exit for
        else

            '' when the constant value is 0, we must not handle this as a
            '' constant string
  			expr = exprtb(i)
  			v = astGetValueAsInt( expr )

			if( v = 0 ) then
				isconst = FALSE
				exit for
			end if

		end if
	next i

	if( isconst ) then
		s = ""

		for i = 0 to cnt-1
  			expr = exprtb(i)
  			v = astGetValueAsInt( expr )
  			astDel( expr )

			if( (v < CHAR_SPACE) or (v > 127) ) then
				s += "\27"
				o = oct$( v )
				s += chr$( len( o ) )
				s += o
			else
				s += chr$( v )
			end if
		next i

		funcexpr = astNewVAR( hAllocStringConst( s, cnt ), NULL, 0, IR_DATATYPE_FIXSTR )

    else

		funcexpr = rtlStrChr( cnt, exprtb() )

	end if

	function = funcexpr <> NULL

end function

'':::::
private function cStrASC( byref funcexpr as ASTNODE ptr ) as integer
    dim as ASTNODE ptr expr1, posexpr
    dim as integer p
    dim as FBSYMBOL ptr sym

	cStrASC = FALSE

	hMatchLPRNT( )

	hMatchExpression( expr1 )

	'' (',' Expression)?
	if( hMatch( CHAR_COMMA ) ) then
		hMatchExpression( posexpr )
	else
		posexpr = NULL
	end if

	hMatchRPRNT( )

	'' constant? evaluate at compile-time
	if( astIsVAR( expr1 ) ) then
		if( astGetDataType( expr1 ) = IR_DATATYPE_FIXSTR ) then
			sym = astGetSymbolOrElm( expr1 )
			if( sym <> NULL ) then
				if( symbGetVarInitialized( sym ) ) then

					'' pos is an constant too?
					if( posexpr <> NULL ) then
						if( astIsCONST( posexpr ) ) then

							p = astGetValueAsInt( posexpr )
							astDel( posexpr )

							if( p < 0 ) then
								p = 0
							end if
						else
							p = -1
						end if
					else
						p = 1
					end if

					if( p >= 0 ) then
						funcexpr = _
							astNewCONSTi( asc( hEscapeToChar( symbGetVarText( sym ) ) , p ), _
										  IR_DATATYPE_INTEGER )

	    				astDel( expr1 )
	    				expr1 = NULL
	    			end if

	    		end if
	    	end if
		end if
	end if

	if( expr1 <> NULL ) then
		funcexpr = rtlStrAsc( expr1, posexpr )
	end if

	function = funcexpr <> NULL

end function

'':::::
'' cStringFunct	=	STR$ '(' Expression{int|float|double} ')'
'' 				|   MID$ '(' Expression ',' Expression (',' Expression)? ')'
'' 				|   STRING$ '(' Expression ',' Expression{int|str} ')' .
''              |   INSTR '(' (Expression{int} ',')? Expression{str}, "ANY"? Expression{str} ')'
''              |   RTRIM$ '(' Expression{str} (, "ANY" Expression{str} )? ')'
''
function cStringFunct( byref funcexpr as ASTNODE ptr ) as integer
    dim as ASTNODE ptr expr1, expr2, expr3
    dim as integer dclass, dtype, is_any

	function = FALSE

	select case lexGetToken( )
	'' STR$ '(' Expression{int|float|double} ')'
	case FB_TK_STR
		lexSkipToken( )
		hMatchLPRNT( )

		hMatchExpression( expr1 )

		hMatchRPRNT( )

		funcexpr = rtlToStr( expr1 )

		function = funcexpr <> NULL

	'' MID$ '(' Expression ',' Expression (',' Expression)? ')'
	case FB_TK_MID
		lexSkipToken( )

		hMatchLPRNT( )

		hMatchExpression( expr1 )

		hMatchCOMMA( )

		hMatchExpression( expr2 )

		if( hMatch( CHAR_COMMA ) ) then
			hMatchExpression( expr3 )
		else
			expr3 = astNewCONSTi( -1, IR_DATATYPE_INTEGER )
		end if

		hMatchRPRNT( )

		funcexpr = rtlStrMid( expr1, expr2, expr3 )

		function = funcexpr <> NULL


	'' STRING$ '(' Expression ',' Expression{int|str} ')'
	case FB_TK_STRING
		lexSkipToken( )

		hMatchLPRNT( )

		hMatchExpression( expr1 )

		hMatchCOMMA( )

		hMatchExpression( expr2 )

		hMatchRPRNT( )

		funcexpr = rtlStrFill( expr1, expr2 )

		function = funcexpr <> NULL

	'' CHR$ '(' Expression (',' Expression )* ')'
	case FB_TK_CHR
		lexSkipToken( )

		function = cStrCHR( funcexpr )

	'' ASC '(' Expression (',' Expression)? ')'
	case FB_TK_ASC
		lexSkipToken( )

		function = cStrASC( funcexpr )

    case FB_TK_INSTR
        lexSkipToken( )

		hMatchLPRNT( )

		hMatchExpression( expr1 )

		hMatchCOMMA( )

        is_any = hMatch( FB_TK_ANY )

		hMatchExpression( expr2 )

        if( not is_any ) then
        	if( hMatch( CHAR_COMMA ) ) then
                is_any = hMatch( FB_TK_ANY )
                hMatchExpression( expr3 )
            end if
        end if

        if( expr3 = NULL ) then
            expr3 = expr2
            expr2 = expr1
			expr1 = astNewCONSTi( 1, IR_DATATYPE_INTEGER )
        end if

		hMatchRPRNT( )

		funcexpr = rtlStrInstr( expr1, expr2, expr3, is_any )

		function = funcexpr <> NULL

    case FB_TK_TRIM
        lexSkipToken( )

        hMatchLPRNT( )

        hMatchExpression( expr1 )

        if( hMatch( CHAR_COMMA ) ) then
            is_any = hMatch( FB_TK_ANY )
	        hMatchExpression( expr2 )
        else
            is_any = FALSE
            expr2 = NULL
        end if

        hMatchRPRNT( )

		funcexpr = rtlStrTrim( expr1, expr2, is_any )

		function = funcexpr <> NULL

    case FB_TK_RTRIM
        lexSkipToken( )

        hMatchLPRNT( )

        hMatchExpression( expr1 )

        if( hMatch( CHAR_COMMA ) ) then
            is_any = hMatch( FB_TK_ANY )
	        hMatchExpression( expr2 )
        else
            is_any = FALSE
            expr2 = NULL
        end if

        hMatchRPRNT( )

		funcexpr = rtlStrRTrim( expr1, expr2, is_any )

		function = funcexpr <> NULL

    case FB_TK_LTRIM
        lexSkipToken( )

        hMatchLPRNT( )

        hMatchExpression( expr1 )

        if( hMatch( CHAR_COMMA ) ) then
            is_any = hMatch( FB_TK_ANY )
	        hMatchExpression( expr2 )
        else
            is_any = FALSE
            expr2 = NULL
        end if

        hMatchRPRNT( )

		funcexpr = rtlStrLTrim( expr1, expr2, is_any )

		function = funcexpr <> NULL

	end select

end function

