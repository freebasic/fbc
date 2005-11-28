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


'' binary operators (+, \, MOD, ...) parsing
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"
#include once "inc\rtl.bi"

declare function cLogOrExpression			( byref logexpr as ASTNODE ptr ) as integer

declare function cLogAndExpression			( byref logexpr as ASTNODE ptr ) as integer

'':::::
function cUpdPointer( byval op as integer, _
				 	  byval p as ASTNODE ptr, _
				 	  byval e as ASTNODE ptr _
				 	) as ASTNODE ptr static

    dim as integer edtype
    dim as integer lgt

    function = NULL

    edtype = astGetDataType( e )

    '' not integer class?
    if( irGetDataClass( edtype ) <> IR_DATACLASS_INTEGER ) then
    	exit function

    '' CHAR and WCHAR literals are also from the INTEGER class (to allow *p = 0 etc)
    else
    	select case edtype
    	case IR_DATATYPE_CHAR, IR_DATATYPE_WCHAR
    		exit function
    	end select
    end if

    '' calc len( *p )
    lgt = symbCalcLen( astGetDataType( p ) - FB_SYMBTYPE_POINTER, astGetSubType( p ) )

    '' another pointer?
    if( edtype >= IR_DATATYPE_POINTER ) then
    	'' only allow if it's a subtraction
    	if( op = IR_OP_SUB ) then
    		'' types can't be different..
    		if( (edtype <> astGetDataType( p )) or _
    			(astGetSubType( e ) <> astGetSubType( p )) ) then
    			exit function
    		end if

    		'' convert to uint or BOP will complain..
    		p = astNewCONV( INVALID, IR_DATATYPE_UINT, NULL, p )
    		e = astNewCONV( INVALID, IR_DATATYPE_UINT, NULL, e )

 			'' subtract..
 			e = astNewBOP( IR_OP_SUB, p, e )

 			'' and divide by length
 			function = astNewBOP( IR_OP_INTDIV, e, astNewCONSTi( lgt, IR_DATATYPE_INTEGER ) )
    	end if

    	exit function
    end if

    '' not integer? convert
    if( edtype <> IR_DATATYPE_INTEGER ) then
    	e = astNewCONV( INVALID, IR_DATATYPE_INTEGER, NULL, e )
    end if

    '' any op but +|-?
    select case op
    case IR_OP_ADD, IR_OP_SUB
		'' incomplete type?
		if( lgt = 0 ) then
			'' unless it's a void ptr.. pretend it's a byte ptr
			if( astGetDataType( p ) <> FB_SYMBTYPE_POINTER + FB_SYMBTYPE_VOID ) then
				exit function
			end if
		end if

    	'' multiple by length
		e = astNewBOP( IR_OP_MUL, e, astNewCONSTi( lgt, IR_DATATYPE_INTEGER ) )

		'' do op
		function = astNewBOP( op, p, e )

    case else
    	'' allow AND and OR??
    	exit function
    end select

end function

'':::::
''Expression      =   CatExpression .
''
function cExpression( byref expr as ASTNODE ptr ) as integer

	function = cCatExpression( expr )

end function

'':::::
''CatExpression   =   LogExpression ( & LogExpression )* .
''
function cCatExpression( byref catexpr as ASTNODE ptr ) as integer
	dim as ASTNODE ptr expr

	function = FALSE

	'' LogExpression
	if( not cLogExpression( catexpr ) ) then
		exit function
	end if

	'' &
	if( lexGetToken( ) = CHAR_AMP ) then

    	'' convert operand to string if needed
    	select case as const astGetDataType( catexpr )
    	case IR_DATATYPE_STRING, IR_DATATYPE_FIXSTR, _
    		 IR_DATATYPE_CHAR, IR_DATATYPE_WCHAR

    	'' not a string..
    	case else
    		catexpr = rtlToStr( catexpr )
   			if( catexpr = NULL ) then
   				hReportError( FB_ERRMSG_TYPEMISMATCH )
   				exit function
    		end if
    	end select
	end if

	'' ( ... )*
	do
		'' &
		if( lexGetToken( ) <> CHAR_AMP ) then
			exit do
		end if

		lexSkipToken( )

		'' LogExpression
    	if( not cLogExpression( expr ) ) then
    		hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
    		exit function
    	end if

		'' convert operand to string if needed
    	select case as const astGetDataType( expr )
    	case IR_DATATYPE_STRING, IR_DATATYPE_FIXSTR, _
    		 IR_DATATYPE_CHAR, IR_DATATYPE_WCHAR

    	'' not a string..
    	case else
	   		'' expression is not a wstring?
	   		if( astGetDataType( catexpr ) <> IR_DATATYPE_WCHAR ) then
	   			expr = rtlToStr( expr )
	   		else
	   			expr = rtlToWstr( expr )
	   		end if

	   		if( expr = NULL ) then
	   			hReportError( FB_ERRMSG_TYPEMISMATCH )
	   			exit function
	   		end if
    	end select

    	'' concatenate
    	catexpr = astNewBOP( IR_OP_ADD, catexpr, expr )

        if( catexpr = NULL ) then
			hReportError( FB_ERRMSG_TYPEMISMATCH )
            exit function
        end if

	loop

	function = TRUE

end function

'':::::
''LogExpression      =   LogOrExpression ( (XOR | EQV | IMP) LogOrExpression )* .
''
function cLogExpression( byref logexpr as ASTNODE ptr ) as integer
    dim as integer op
    dim as ASTNODE ptr expr

	function = FALSE

    '' LogOrExpression
    if( not cLogOrExpression( logexpr ) ) then
	   	exit function
    end if

    '' ( ... )*
    do
    	'' Logical operator
    	select case as const lexGetToken( )
    	case FB_TK_XOR
    		op = IR_OP_XOR
    	case FB_TK_EQV
    		op = IR_OP_EQV
    	case FB_TK_IMP
 			op = IR_OP_IMP
    	case else
      		exit do
    	end select

    	lexSkipToken( )

    	'' LogOrExpression
    	if( not cLogOrExpression( expr ) ) then
    		hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
    		exit function
    	end if

    	'' do operation
    	logexpr = astNewBOP( op, logexpr, expr )

        if( logexpr = NULL ) then
			hReportError( FB_ERRMSG_TYPEMISMATCH )
            exit function
        end if

    loop

	function = TRUE

end function

'':::::
''LogOrExpression    =   LogAndExpression ( OR LogAndExpression )* .
''
function cLogOrExpression( byref logexpr as ASTNODE ptr ) as integer
    dim as ASTNODE ptr expr

	function = FALSE

    '' LogAndExpression
    if( not cLogAndExpression( logexpr ) ) then
	   	exit function
    end if

    '' ( ... )*
    do
    	'' OR?
    	if( lexGetToken( ) <> FB_TK_OR ) then
    		exit do
    	end if

    	lexSkipToken( )

    	'' LogAndExpression
    	if( not cLogAndExpression( expr ) ) then
    		hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
    		exit function
    	end if

    	'' do operation
    	logexpr = astNewBOP( IR_OP_OR, logexpr, expr )

        if( logexpr = NULL ) then
			hReportError( FB_ERRMSG_TYPEMISMATCH )
            exit function
        end if

    loop

	function = TRUE

end function

'':::::
''LogAndExpression   =   RelExpression ( AND RelExpression )* .
''
function cLogAndExpression( byref logexpr as ASTNODE ptr ) as integer
    dim as ASTNODE ptr expr

	function = FALSE

    '' RelExpression
    if( not cRelExpression( logexpr ) ) then
	   	exit function
    end if

    '' ( ... )*
    do
    	'' AND?
    	if( lexGetToken( ) <> FB_TK_AND ) then
    		exit do
    	end if

    	lexSkipToken( )

    	'' RelExpression
    	if( not cRelExpression( expr ) ) then
    		hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
    		exit function
    	end if

    	'' do operation
    	logexpr = astNewBOP( IR_OP_AND, logexpr, expr )

        if( logexpr = NULL ) then
			hReportError( FB_ERRMSG_TYPEMISMATCH )
            exit function
        end if

    loop

	function = TRUE

end function

'':::::
''RelExpression   =   AddExpression ( (EQ | GT | LT | NE | LE | GE) AddExpression )* .
''
function cRelExpression( byref relexpr as ASTNODE ptr ) as integer
    dim as integer op
    dim as ASTNODE ptr expr

    function = FALSE

   	'' AddExpression
   	if( not cAddExpression( relexpr ) ) then
   		exit function
   	end if

    '' ( ... )*
    do
    	'' Relational operator
    	select case as const lexGetToken( )
    	case FB_TK_EQ
    		op = IR_OP_EQ
    	case FB_TK_GT
    		op = IR_OP_GT
    	case FB_TK_LT
    		op = IR_OP_LT
    	case FB_TK_NE
    		op = IR_OP_NE
    	case FB_TK_LE
    		op = IR_OP_LE
    	case FB_TK_GE
 			op = IR_OP_GE
    	case else
      		exit do
    	end select

    	lexSkipToken( )

    	'' AddExpression
    	if( not cAddExpression( expr ) ) then
    		hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
    		exit function
    	end if

   		'' do operation
   		relexpr = astNewBOP( op, relexpr, expr )

    	if( relexpr = NULL ) Then
    		hReportError( FB_ERRMSG_TYPEMISMATCH )
    		exit function
    	end if
    loop

    function = TRUE

end function

'':::::
''AddExpression   =   ShiftExpression ( ('+' | '-') ShiftExpression )* .
''
function cAddExpression( byref addexpr as ASTNODE ptr ) as integer
    dim as integer op
    dim as ASTNODE ptr expr

    function = FALSE

 	'' ShiftExpression
   	if( not cShiftExpression( addexpr ) ) then
   		exit function
   	end if

    '' ( ... )*
    do
    	'' Add operator
    	select case lexGetToken( )
    	case CHAR_PLUS
    		op = IR_OP_ADD
    	case CHAR_MINUS
 			op = IR_OP_SUB
    	case else
      		exit do
    	end select

    	lexSkipToken( )

    	'' ShiftExpression
    	if( not cShiftExpression( expr ) ) then
    		hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
    		exit do
    	end if

    	'' check pointers
    	if( astGetDataType( addexpr ) >= IR_DATATYPE_POINTER ) then
    		addexpr = cUpdPointer( op, addexpr, expr )

    	elseif( astGetDataType( expr ) >= IR_DATATYPE_POINTER ) then
    		addexpr = cUpdPointer( op, expr, addexpr )

    	else
    		addexpr = astNewBOP( op, addexpr, expr )
    	end if

    	if( addexpr = NULL ) Then
    		hReportError( FB_ERRMSG_TYPEMISMATCH )
    		exit function
    	end if
    loop

    function = TRUE

end function

'':::::
''ShiftExpression  =   ModExpression ( (SHL | SHR) ModExpression )* .
''
function cShiftExpression( byref shiftexpr as ASTNODE ptr ) as integer
    dim as integer op
    dim as ASTNODE ptr expr

    function = FALSE

   	'' ModExpression
   	if( not cModExpression( shiftexpr ) ) then
   		exit function
   	end if

    '' ( ... )*
    do
    	'' Shift operator
    	select case lexGetToken( )
    	case FB_TK_SHL
    		op = IR_OP_SHL
    	case FB_TK_SHR
 			op = IR_OP_SHR
    	case else
      		exit do
    	end select

    	lexSkipToken( )

    	'' ModExpression
    	if( not cModExpression( expr ) ) then
    		hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
    		exit do
    	end if

    	'' do operation
    	shiftexpr = astNewBOP( op, shiftexpr, expr )

    	if( shiftexpr = NULL ) Then
    		hReportError( FB_ERRMSG_TYPEMISMATCH )
    		exit function
    	end if
    loop

    function = TRUE

end function

'':::::
''ModExpression   =   IntDivExpression ( MOD IntDivExpression )* .
''
function cModExpression( byref modexpr as ASTNODE ptr ) as integer
    dim as ASTNODE ptr expr

    function = FALSE

   	'' IntDivExpression
   	if( not cIntDivExpression( modexpr ) ) then
   		exit function
   	end if

    '' ( ... )*
    do
    	'' Add operator
    	if( lexGetToken( ) = FB_TK_MOD ) then
 			lexSkipToken( )
    	else
      		exit do
    	end if

    	'' IntDivExpression
    	if( not cIntDivExpression( expr ) ) then
    		hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
    		exit function
    	end if

    	'' do operation
    	modexpr = astNewBOP( IR_OP_MOD, modexpr, expr )

    	if( modexpr = NULL ) Then
    		hReportError( FB_ERRMSG_TYPEMISMATCH )
    		exit function
    	end if
    loop

    function = TRUE

end function

'':::::
''IntDivExpression=   MultExpression ( '\' MultExpression )* .
''
function cIntDivExpression( byref idivexpr as ASTNODE ptr ) as integer
	dim as ASTNODE ptr expr

    function = FALSE

   	'' MultExpression
   	if( not cMultExpression( idivexpr ) ) then
   		exit function
   	end if

    '' ( ... )*
    do
    	'' '\'
    	if( lexGetToken( ) = CHAR_RSLASH ) then
 			lexSkipToken( )
    	else
      		exit do
    	end if

    	'' MultExpression
    	if( not cMultExpression( expr ) ) then
    		hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
    		exit function
    	end if

    	'' do operation
    	idivexpr = astNewBOP( IR_OP_INTDIV, idivexpr, expr )

    	if( idivexpr = NULL ) Then
    		hReportError( FB_ERRMSG_TYPEMISMATCH )
    		exit function
    	end if
    loop

    function = TRUE

end function

'':::::
''MultExpression  =   ExpExpression ( ('*' | '/') ExpExpression )* .
''
function cMultExpression( byref mulexpr as ASTNODE ptr ) as integer
    dim as integer op
    dim as ASTNODE ptr expr

    function = FALSE

   	'' ExpExpression
   	if( not cExpExpression( mulexpr ) ) then
   		exit function
   	end if

    '' ( ... )*
    do
    	'' Mult operator
    	select case lexGetToken( )
    	case CHAR_CARET
    		op = IR_OP_MUL
    	case CHAR_SLASH
 			op = IR_OP_DIV
    	case else
      		exit do
    	end select

    	lexSkipToken( )

    	'' ExpExpression
    	if( not cExpExpression( expr ) ) then
    		hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
    		exit do
    	end if

    	'' do operation
    	mulexpr = astNewBOP( op, mulexpr, expr )

    	if( mulexpr = NULL ) Then
    		hReportError( FB_ERRMSG_TYPEMISMATCH )
    		exit function
    	end if
    loop

    function = TRUE

end function

'':::::
''ExpExpression   =   NegNotExpression ( '^' NegNotExpression )* .
''
function cExpExpression( byref expexpr as ASTNODE ptr ) as integer
	dim as ASTNODE ptr expr

    function = FALSE

   	'' NegNotExpression
   	if( not cNegNotExpression( expexpr ) ) then
   		exit function
   	end if

    '' ( '^' NegNotExpression )*
    do
    	if( lexGetToken( ) <> CHAR_CART ) then
    		exit do
    	else
    		lexSkipToken( )
    	end if

    	'' NegNotExpression
    	if( not cNegNotExpression( expr ) ) then
    		hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
    		exit do
    	end if

    	'' do operation
    	expexpr = astNewBOP( IR_OP_POW, expexpr, expr )

    	if( expexpr = NULL ) Then
    		hReportError( FB_ERRMSG_TYPEMISMATCH )
    		exit function
    	end if
    loop

    function = TRUE

end function


