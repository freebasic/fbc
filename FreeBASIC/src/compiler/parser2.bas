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


'' parser part 2 - expression evaluator including atom's (but variables)
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

defint a-z
#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"
#include once "inc\ir.bi"
#include once "inc\emit.bi"
#include once "inc\rtl.bi"

'':::::
sub cUpdPointer( byval op as integer, _
				 byref p as ASTNODE ptr, _
				 byref e as ASTNODE ptr ) static

    dim as integer edtype
    dim as integer lgt

    edtype = astGetDataType( e )

    '' not integer class?
    if( irGetDataClass( edtype ) <> IR_DATACLASS_INTEGER ) then
    	e = NULL
    	exit sub
    end if

    '' another pointer?
    if( edtype >= IR_DATATYPE_POINTER ) then
    	'' if sub, convert both to uint
    	if( op = IR_OP_SUB ) then
    		p = astNewCONV( INVALID, IR_DATATYPE_UINT, NULL, p )
    		e = astNewCONV( INVALID, IR_DATATYPE_UINT, NULL, e )
    	else
    		e = NULL
    	end if

    	exit sub
    end if

    '' not integer? convert
    if( edtype <> IR_DATATYPE_INTEGER ) then
    	e = astNewCONV( INVALID, IR_DATATYPE_INTEGER, NULL, e )
    end if

    '' any op but +|-?
    select case op
    case IR_OP_ADD, IR_OP_SUB
    	'' multiple by pdtype - POINTER
		lgt = symbCalcLen( astGetDataType( p ) - FB_SYMBTYPE_POINTER, astGetSubType( p ) )
		'' incomplete type?
		if( lgt = 0 ) then
			'' void ptr? pretend it's a byte ptr
			if( astGetDataType( p ) <> FB_SYMBTYPE_POINTER + FB_SYMBTYPE_VOID ) then
				e = NULL
			end if
			exit sub
		end if

		e = astNewBOP( IR_OP_MUL, e, astNewCONSTi( lgt, IR_DATATYPE_INTEGER ) )

    case else
    	'' allow AND and OR??
    	e = NULL
    	exit sub
    end select

end sub

'':::::
''Expression      =   LogExpression .
''
function cExpression( byref expr as ASTNODE ptr ) as integer

	function = cCatExpression( expr )

end function

'':::::
''CatExpression   =   LogExpression ( & LogExpression )* .
''
function cCatExpression( byref catexpr as ASTNODE ptr ) as integer
	dim as ASTNODE ptr logexpr

	function = FALSE

	'' LogExpression
	if( not cLogExpression( catexpr ) ) then
		exit function
	end if

	'' &
	if( lexGetToken( ) = CHAR_AMP ) then

    	'' convert operand to string if needed
    	if( astGetDataClass( catexpr ) <> IR_DATACLASS_STRING ) then
    		catexpr = rtlToStr( catexpr )

   			if( catexpr = NULL ) then
   				hReportError FB_ERRMSG_TYPEMISMATCH
   				exit function
    		end if
    	end if
	end if

	'' ( ... )*
	do
		'' &
		if( lexGetToken( ) <> CHAR_AMP ) then
			exit do
		end if

		lexSkipToken( )

		'' LogExpression
    	if( not cLogExpression( logexpr ) ) then
    		hReportError FB_ERRMSG_EXPECTEDEXPRESSION
    		exit function
    	end if

		'' convert operand to string if needed
		if( astGetDataClass( logexpr ) <> IR_DATACLASS_STRING ) then
	   		logexpr = rtlToStr( logexpr )

	   		if( logexpr = NULL ) then
	   			hReportError FB_ERRMSG_TYPEMISMATCH
	   			exit function
	   		end if
    	end if

    	'' concatenate
    	catexpr = astNewBOP( IR_OP_ADD, catexpr, logexpr )

        if( catexpr = NULL ) then
			hReportError FB_ERRMSG_TYPEMISMATCH
            exit function
        end if

	loop

	function = TRUE

end function

'':::::
''LogExpression      =   RelExpression ( (AND | OR | XOR | EQV | IMP) RelExpression )* .
''
function cLogExpression( byref logexpr as ASTNODE ptr ) as integer
    dim as integer op
    dim as ASTNODE ptr relexpr

	function = FALSE

    '' RelExpression
    if( not cRelExpression( logexpr ) ) then
	   	exit function
    end if

    '' ( ... )*
    do
    	'' Logical operator
    	select case as const lexGetToken( )
    	case FB_TK_AND
    	    op = IR_OP_AND
    	case FB_TK_OR
    	    op = IR_OP_OR
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

    	'' RelExpression
    	if( not cRelExpression( relexpr ) ) then
    		hReportError FB_ERRMSG_EXPECTEDEXPRESSION
    		exit function
    	end if

    	'' do operation
    	logexpr = astNewBOP( op, logexpr, relexpr )

        if( logexpr = NULL ) then
			hReportError FB_ERRMSG_TYPEMISMATCH
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
    dim as ASTNODE ptr addexpr

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
    	if( not cAddExpression( addexpr ) ) then
    		hReportError FB_ERRMSG_EXPECTEDEXPRESSION
    		exit function
    	end if

   		'' do operation
   		relexpr = astNewBOP( op, relexpr, addexpr )

    	if( relexpr = NULL ) Then
    		hReportError FB_ERRMSG_TYPEMISMATCH
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
    dim as ASTNODE ptr shiftexpr

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
    	if( not cShiftExpression( shiftexpr ) ) then
    		hReportError FB_ERRMSG_EXPECTEDEXPRESSION
    		exit do
    	end if

    	'' check pointers
    	if( astGetDataType( addexpr ) >= IR_DATATYPE_POINTER ) then
    		cUpdPointer( op, addexpr, shiftexpr )
    		if( shiftexpr = NULL ) then
    			hReportError( FB_ERRMSG_TYPEMISMATCH )
    			exit function
    		end if

    	elseif( astGetDataType( shiftexpr ) >= IR_DATATYPE_POINTER ) then
    		cUpdPointer( op, shiftexpr, addexpr )
    		if( addexpr = NULL ) then
    			hReportError( FB_ERRMSG_TYPEMISMATCH )
    			exit function
    		end if
    	end if

    	'' do operation
    	addexpr = astNewBOP( op, addexpr, shiftexpr )

    	if( addexpr = NULL ) Then
    		hReportError FB_ERRMSG_TYPEMISMATCH
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
    dim as ASTNODE ptr modexpr

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
    	if( not cModExpression( modexpr ) ) then
    		hReportError FB_ERRMSG_EXPECTEDEXPRESSION
    		exit do
    	end if

    	'' do operation
    	shiftexpr = astNewBOP( op, shiftexpr, modexpr )

    	if( shiftexpr = NULL ) Then
    		hReportError FB_ERRMSG_TYPEMISMATCH
    		exit function
    	end if
    loop

    function = TRUE

end function

'':::::
''ModExpression   =   IntDivExpression ( MOD IntDivExpression )* .
''
function cModExpression( byref modexpr as ASTNODE ptr ) as integer
    dim as ASTNODE ptr idivexpr

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
    	if( not cIntDivExpression( idivexpr ) ) then
    		hReportError FB_ERRMSG_EXPECTEDEXPRESSION
    		exit function
    	end if

    	'' do operation
    	modexpr = astNewBOP( IR_OP_MOD, modexpr, idivexpr )

    	if( modexpr = NULL ) Then
    		hReportError FB_ERRMSG_TYPEMISMATCH
    		exit function
    	end if
    loop

    function = TRUE

end function

'':::::
''IntDivExpression=   MultExpression ( '\' MultExpression )* .
''
function cIntDivExpression( byref idivexpr as ASTNODE ptr ) as integer
	dim as ASTNODE ptr mulexpr

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
    	if( not cMultExpression( mulexpr ) ) then
    		hReportError FB_ERRMSG_EXPECTEDEXPRESSION
    		exit function
    	end if

    	'' do operation
    	idivexpr = astNewBOP( IR_OP_INTDIV, idivexpr, mulexpr )

    	if( idivexpr = NULL ) Then
    		hReportError FB_ERRMSG_TYPEMISMATCH
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
    dim as ASTNODE ptr expexpr

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
    	if( not cExpExpression( expexpr ) ) then
    		hReportError FB_ERRMSG_EXPECTEDEXPRESSION
    		exit do
    	end if

    	'' do operation
    	mulexpr = astNewBOP( op, mulexpr, expexpr )

    	if( mulexpr = NULL ) Then
    		hReportError FB_ERRMSG_TYPEMISMATCH
    		exit function
    	end if
    loop

    function = TRUE

end function

'':::::
''ExpExpression   =   NegNotExpression ( '^' NegNotExpression )* .
''
function cExpExpression( byref expexpr as ASTNODE ptr ) as integer
	dim as ASTNODE ptr negexpr

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
    	if( not cNegNotExpression( negexpr ) ) then
    		hReportError FB_ERRMSG_EXPECTEDEXPRESSION
    		exit do
    	end if

    	'' do operation
    	expexpr = astNewBOP( IR_OP_POW, expexpr, negexpr )

    	if( expexpr = NULL ) Then
    		hReportError FB_ERRMSG_TYPEMISMATCH
    		exit function
    	end if
    loop

    function = TRUE

end function

'':::::
''NegNotExpression=   ('-'|'+'|) ExpExpression
''				  |   NOT RelExpression
''				  |   HighestPresExpr .
''
function cNegNotExpression( byref negexpr as ASTNODE ptr ) as integer

	function = FALSE

	select case lexGetToken( )
	'' '-'
	case CHAR_MINUS
		lexSkipToken( )

		'' ExpExpression
		if( not cExpExpression( negexpr ) ) then
			exit function
		end if

		negexpr = astNewUOP( IR_OP_NEG, negexpr )

    	if( negexpr = NULL ) Then
    		hReportError FB_ERRMSG_TYPEMISMATCH
    		exit function
    	end if

		return TRUE

	'' '+'
	case CHAR_PLUS
		lexSkipToken( )

		'' ExpExpression
		if( not cExpExpression( negexpr ) ) then
			exit function
		end if

    	'' not numeric? can't operate..
    	if( astGetDataClass( negexpr ) >= IR_DATACLASS_STRING ) then
    		hReportError( FB_ERRMSG_TYPEMISMATCH )
    		exit function
    	end if

    	return TRUE

	'' NOT
	case FB_TK_NOT
		lexSkipToken( )

		'' RelExpression
		if( not cRelExpression( negexpr ) ) then
			exit function
		end if

		negexpr = astNewUOP( IR_OP_NOT, negexpr )

    	if( negexpr = NULL ) Then
    		hReportError FB_ERRMSG_TYPEMISMATCH
    		exit function
    	end if

		return TRUE
	end select

	function = cHighestPrecExpr( negexpr )

end function

''::::
'' HighestPrecExpr=   AddrOfExpression
''				  |	  DerefExpr FuncPtrOrDerefFields?
''				  |	  PtrTypeCastingExpr FuncPtrOrDerefFields?
''				  |   ParentExpression FuncPtrOrDerefFields?
''				  |   Atom .
''
function cHighestPrecExpr( byref highexpr as ASTNODE ptr ) as integer
	dim as FBSYMBOL ptr sym, elm, subtype
	dim as integer isfuncptr, dtype

	select case lexGetToken( )
	'' AddrOfExpression
	case FB_TK_ADDROFCHAR
		return cAddrOfExpression( highexpr )

	'' DerefExpr
	case FB_TK_DEREFCHAR
		if( not cDerefExpression( highexpr ) ) then
			exit function
		end if

	'' ParentExpression
	case CHAR_LPRNT
		if( not cParentExpression( highexpr ) ) then
			exit function
		end if

	case else

		select case as const lexGetToken( )
		'' AddrOfExpression
		case FB_TK_VARPTR, FB_TK_PROCPTR, FB_TK_SADD, FB_TK_STRPTR
			return cAddrOfExpression( highexpr )

		'' PtrTypeCastingExpr
		case FB_TK_CPTR
			if( not cPtrTypeCastingExpr( highexpr ) ) then
				exit function
			end if

		'' Atom
		case else
			return cAtom( highexpr )

		end select

	end select

    '' FuncPtrOrDerefFields?
	dtype = astGetDataType( highexpr )
	if( dtype >= IR_DATATYPE_POINTER ) then
		isfuncptr = FALSE
		if( dtype = IR_DATATYPE_POINTER+IR_DATATYPE_FUNCTION ) then
			if( lexGetToken( ) = CHAR_LPRNT ) then
				isfuncptr = TRUE
			end if
		end if

		sym 	= astGetSymbol( highexpr )
		elm 	= astGetElm( highexpr )
		subtype = astGetSubType( highexpr )

		cFuncPtrOrDerefFields( sym, elm, dtype, subtype, highexpr, isfuncptr, TRUE )
	end if

	function = (hGetLastError() = FB_ERRMSG_OK)

end function

'':::::
'' PtrTypeCastingExpr	=   CPTR '(' SymbolType ',' Expression{int|uint|ptr} ')'
''
function cPtrTypeCastingExpr( byref castexpr as ASTNODE ptr ) as integer
	dim as integer dtype, lgt, ptrcnt
	dim as FBSYMBOL ptr subtype
	dim as ASTNODE ptr expr

	function = FALSE

	'' CPTR
	if( lexGetToken( ) <> FB_TK_CPTR ) then
		exit function
	end if

	lexSkipToken( )

	'' '('
	if( not hMatch( CHAR_LPRNT ) ) then
		hReportError( FB_ERRMSG_EXPECTEDLPRNT )
		exit function
	end if

	'' SymbolType
	if( not cSymbolType( dtype, subtype, lgt, ptrcnt ) ) then
		hReportError( FB_ERRMSG_SYNTAXERROR )
		exit function
	end if

	'' check if it's a pointer
	if( dtype < IR_DATATYPE_POINTER ) then
		hReportError( FB_ERRMSG_EXPECTEDPOINTER, TRUE )
		exit function
	end if

	'' ','
	if( not hMatch( CHAR_COMMA ) ) then
		hReportError( FB_ERRMSG_EXPECTEDCOMMA )
		exit function
	end if

	'' Expression
	if( not cExpression( expr ) ) then
		hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
		exit function
	end if

	select case astGetDataType( expr )
	case IR_DATATYPE_INTEGER, IR_DATATYPE_UINT, is >= IR_DATATYPE_POINTER

	case else
		hReportError( FB_ERRMSG_EXPECTEDPOINTER )
		exit function
	end select

	'' ')'
	if( not hMatch( CHAR_RPRNT ) ) then
		hReportError( FB_ERRMSG_EXPECTEDRPRNT )
		exit function
	end if

	'' convert to new type
	castexpr = astNewCONV( IR_OP_TOPOINTER, dtype, subtype, expr )

	function = (castexpr <> NULL)

end function

'':::::
private function hDoDeref( byval cnt as integer, _
						   byref expr as ASTNODE ptr, _
					       byval sym as FBSYMBOL ptr, _
					       byval elm as FBSYMBOL ptr, _
					       byval dtype as integer, _
					       byval subtype as FBSYMBOL ptr ) as integer

	function = INVALID

	if( (expr = NULL) or (cnt <= 0) ) then
		exit function
	end if

	do while( cnt > 1 )
		'' not a pointer?
		if( dtype < IR_DATATYPE_POINTER ) then
			hReportError( FB_ERRMSG_EXPECTEDPOINTER, TRUE )
			exit function
		end if

		dtype -= IR_DATATYPE_POINTER

		'' incomplete type?
		if( (dtype = FB_SYMBTYPE_VOID) or (dtype = FB_SYMBTYPE_FWDREF) ) then
			hReportError( FB_ERRMSG_INCOMPLETETYPE, TRUE )
			exit function
		end if

		'' null pointer checking
		if( env.clopt.extraerrchk ) then
			expr = astNewPTRCHK( expr, lexLineNum( ) )
		end if

		expr = astNewPTR( NULL, NULL, 0, expr, dtype, NULL )
		cnt -= 1
	loop

	'' not a pointer?
	if( dtype < IR_DATATYPE_POINTER ) then
		hReportError( FB_ERRMSG_EXPECTEDPOINTER, TRUE )
		exit function
	end if

    dtype -= FB_SYMBTYPE_POINTER

	'' incomplete type?
	if( (dtype = FB_SYMBTYPE_VOID) or (dtype = FB_SYMBTYPE_FWDREF) ) then
		hReportError( FB_ERRMSG_INCOMPLETETYPE, TRUE )
		exit function
	end if

	'' null pointer checking
	if( env.clopt.extraerrchk ) then
		expr = astNewPTRCHK( expr, lexLineNum( ) )
	end if

    expr = astNewPTR( sym, elm, 0, expr, dtype, subtype )

    function = dtype

end function

'':::::
''DerefExpression	= 	DREF+ HighestPresExpr .
''
function cDerefExpression( byref derefexpr as ASTNODE ptr ) as integer
    dim as FBSYMBOL ptr sym, elm, subtype
    dim as integer derefcnt, dtype
    dim as ASTNODE ptr funcexpr

	function = FALSE

	'' DREF?
	if( lexGetToken( ) <> FB_TK_DEREFCHAR ) then
		exit function
	end if

	'' DREF+
    derefcnt = 0
	do
		lexSkipToken( )
		derefcnt += 1
	loop while( lexGetToken( ) = FB_TK_DEREFCHAR )

	'' HighestPresExpr
	if( not cHighestPrecExpr( derefexpr ) ) then
        hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
        exit function
	end if

	''
	sym		= astGetSymbol( derefexpr )
	elm		= astGetElm( derefexpr )
	dtype   = astGetDataType( derefexpr )
	subtype = astGetSubType( derefexpr )

	''
	dtype = hDoDeref( derefcnt, derefexpr, sym, elm, dtype, subtype )
	if( dtype = INVALID ) then
		exit function
	end if

	function = TRUE

end function

'':::::
private function hProcPtrBody( byval proc as FBSYMBOL ptr, _
							   byref addrofexpr as ASTNODE ptr ) as integer
	dim as ASTNODE ptr expr

	function = FALSE

	'' '('')'?
	if( hMatch( CHAR_LPRNT ) ) then
		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError( FB_ERRMSG_EXPECTEDRPRNT )
			exit function
		end if
	end if

	expr = astNewVAR( proc, NULL, 0, IR_DATATYPE_FUNCTION, proc )
	addrofexpr = astNewADDR( IR_OP_ADDROF, expr, proc )

	''
	symbSetProcIsCalled( proc, TRUE )

	function = (addrofexpr <> NULL)

end function

'':::::
private function hVarPtrBody( byref addrofexpr as ASTNODE ptr) as integer

	function = FALSE

	if( not cHighestPrecExpr( addrofexpr ) ) then
		exit function
	end if

	select case as const astGetClass( addrofexpr )
	case AST_NODECLASS_VAR, AST_NODECLASS_IDX, AST_NODECLASS_PTR

	case else
		hReportErrorEx( FB_ERRMSG_INVALIDDATATYPES, "for @ or VARPTR" )
		exit function
	end select

	addrofexpr = astNewADDR( IR_OP_ADDROF, addrofexpr, _
						 	 astGetSymbol( addrofexpr ), astGetElm( addrofexpr ) )

    function = (addrofexpr <> NULL)

end function

'':::::
''AddrOfExpression  =   VARPTR '(' HighPrecExpr ')'
''					|   PROCPTR '(' Proc ('('')')? ')'
'' 					| 	'@' (Proc ('('')')? | HighPrecExpr)
''					|   SADD|STRPTR '(' Variable{str}|Const{str}|Literal{str} ')' .
''
function cAddrOfExpression( byref addrofexpr as ASTNODE ptr ) as integer
    dim as ASTNODE ptr expr
    dim as integer dtype
    dim as FBSYMBOL ptr sym, elm

	function = FALSE

	'' '@' (Proc ('('')')? | Variable)
	if( lexGetToken( ) = FB_TK_ADDROFCHAR ) then
		lexSkipToken( )

		'' proc?
		if( lexGetClass( ) = FB_TKCLASS_IDENTIFIER ) then
			sym = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_PROC )
			if( sym <> NULL ) then
				lexSkipToken( )
				return hProcPtrBody( sym, addrofexpr )
			end if
        end if

		return hVarPtrBody( addrofexpr )
	end if

	select case as const lexGetToken( )
	'' VARPTR '(' Variable ')'
	case FB_TK_VARPTR
		lexSkipToken( )

		'' '('
		if( not hMatch( CHAR_LPRNT ) ) then
			hReportError( FB_ERRMSG_EXPECTEDLPRNT )
			exit function
		end if

		if( not hVarPtrBody( addrofexpr ) ) then
			exit function
		end if

		'' ')'
		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError( FB_ERRMSG_EXPECTEDRPRNT )
			exit function
		end if

		return TRUE

	'' PROCPTR '(' Proc ('('')')? ')'
	case FB_TK_PROCPTR
		lexSkipToken( )

		'' '('
		if( not hMatch( CHAR_LPRNT ) ) then
			hReportError( FB_ERRMSG_EXPECTEDLPRNT )
			exit function
		end if

		'' proc?
		sym = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_PROC )
		if( sym = NULL ) then
			hReportError( FB_ERRMSG_UNDEFINEDSYMBOL )
			exit function
		else
			lexSkipToken( )
		end if

		if( not hProcPtrBody( sym, addrofexpr ) ) then
			exit function
		end if

		'' ')'
		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError( FB_ERRMSG_EXPECTEDRPRNT )
			exit function
		end if

		return TRUE

	'' SADD|STRPTR '(' Variable{str} ')'
	case FB_TK_SADD, FB_TK_STRPTR
		lexSkipToken( )

		'' '('
		if( not hMatch( CHAR_LPRNT ) ) then
			hReportError( FB_ERRMSG_EXPECTEDLPRNT )
			exit function
		end if

		if( not cLiteral( expr ) ) then
			if( not cConstant( expr ) ) then
				if( not cVariable( expr, sym, elm ) ) then
					exit function
				end if
			end if
		end if

		sym = astGetSymbol( expr )
		elm = astGetElm( expr )

		dtype = astGetDataType( expr )
		if( not hIsString( dtype ) ) then
			hReportError( FB_ERRMSG_INVALIDDATATYPES )
			exit function
		end if

		'' ')'
		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError( FB_ERRMSG_EXPECTEDRPRNT )
			exit function
		end if

		if( dtype = IR_DATATYPE_STRING ) then
			expr = astNewADDR( IR_OP_DEREF, expr, sym, elm )
		else
			expr = astNewADDR( IR_OP_ADDROF, expr, sym, elm )
		end if

		addrofexpr = astNewCONV( IR_OP_TOPOINTER, IR_DATATYPE_POINTER+IR_DATATYPE_CHAR, NULL, expr )

		return (addrofexpr <> NULL)
	end select

end function

'':::::
''ParentExpression=   '(' Expression ')' .
''
function cParentExpression( byref parexpr as ASTNODE ptr ) as integer

  	function = FALSE

  	'' '('
  	if( not hMatch( CHAR_LPRNT ) ) then
  		exit function
  	end if

  	'' ++parent cnt
  	env.prntcnt += 1

  	if( not cExpression( parexpr ) ) then
  		'' calling a SUB? it can be a BYVAL or nothing due the optional ()'s
  		if( not env.prntopt ) then
  			hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
  			exit function
  		end if

  	else
  		'' ')'
  		if( hMatch( CHAR_RPRNT ) ) then
  			'' --parent cnt
  			env.prntcnt -= 1
  		else
  			'' not calling a SUB or parent cnt = 0?
  			if( (not env.prntopt) or (env.prntcnt = 0) ) then
  				hReportError( FB_ERRMSG_EXPECTEDRPRNT )
  				exit function
  			end if
  		end if

  		function = TRUE
  	end if

end function

'':::::
''Atom            =   Constant | Function | QuirkFunction | Variable | Literal .
''
function cAtom( byref atom as ASTNODE ptr ) as integer
    dim as FBSYMBOL ptr sym, elm
    dim as integer res

  	atom = NULL

  	select case lexGetClass
  	case FB_TKCLASS_KEYWORD
  		return cQuirkFunction( atom )

  	case FB_TKCLASS_IDENTIFIER
  		res = cConstant( atom )
  		if( not res ) then
  			res = cFunction( atom, sym, elm )
  			if( not res ) then
  				res = cVariable( atom, sym, elm, env.checkarray )
  			end if
  		end if

  		return res

  	case else
  		return cLiteral( atom )
  	end select

end function

'':::::
'' Constant       = ID .
''
function cConstant( byref constexpr as ASTNODE ptr ) as integer static
	static as zstring * FB_MAXLITLEN+1 text
	dim as FBSYMBOL ptr s
	dim as integer typ

	function = FALSE

	s = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_CONST )
	if( s <> NULL ) then

  		text = symbGetConstText( s )
  		typ = symbGetType( s )

  		if( irGetDataClass( typ ) = IR_DATACLASS_STRING ) then

			s = hAllocStringConst( text, symbGetLen( s ) )
			constexpr = astNewVAR( s, NULL, 0, IR_DATATYPE_FIXSTR )

  		else
  			select case as const typ
  			case IR_DATATYPE_ENUM
  				constexpr = astNewENUM( valint( text ), symbGetSubType( s ) )

			'' !!!REMOVEME!!!
#ifdef val64
  			case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
  				constexpr = astNewCONST64( val64( text ), typ )
#else
  			case IR_DATATYPE_LONGINT
  				constexpr = astNewCONST64( vallng( text ), typ )

  			case IR_DATATYPE_ULONGINT
  				constexpr = astNewCONST64( valulng( text ), typ )
#endif

  			case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
  				constexpr = astNewCONSTf( val( text ), typ )

			'' !!!REMOVEME!!!
#ifdef valuint
			case IR_DATATYPE_UINT
				constexpr = astNewCONSTi( valuint( text ), typ )
#endif
  			case else
  				constexpr = astNewCONSTi( valint( text ), typ, symbGetSubType( s ) )

  			end select
  		end if

  		lexSkipToken( )
  		function = TRUE
  	end if

end function

'':::::
''Literal		  = NUM_LITERAL | STR_LITERAL .
''
function cLiteral( byref litexpr as ASTNODE ptr ) as integer
	dim as FBSYMBOL ptr tc
	dim as integer typ

	function = FALSE

	select case lexGetClass( )
	case FB_TKCLASS_NUMLITERAL
  		typ = lexGetType( )
  		select case as const typ

		'' !!!REMOVEME!!!
#ifdef val64
  		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
			litexpr = astNewCONST64( val64( *lexGetText( ) ), typ )
#else
  		case IR_DATATYPE_LONGINT
			litexpr = astNewCONST64( vallng( *lexGetText( ) ), typ )

		case IR_DATATYPE_ULONGINT
			litexpr = astNewCONST64( valulng( *lexGetText( ) ), typ )
#endif

  		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			litexpr = astNewCONSTf( val( *lexGetText( ) ), typ )

		'' !!!REMOVEME!!!
#ifdef valuint
		case IR_DATATYPE_UINT
			litexpr = astNewCONSTi( valuint( *lexGetText( ) ), typ )
#endif
		case else
			litexpr = astNewCONSTi( valint( *lexGetText( ) ), typ )
  		end select

  		lexSkipToken( )
  		function = TRUE

  	case FB_TKCLASS_STRLITERAL
		tc = hAllocStringConst( *lexGetText( ), lexGetTextLen( ) )
		litexpr = astNewVAR( tc, NULL, 0, IR_DATATYPE_FIXSTR )

		lexSkipToken( )
        function = TRUE
  	end select

end function

'':::::
function cFunctionCall( byval sym as FBSYMBOL ptr, _
						byref elm as FBSYMBOL ptr, _
						byref funcexpr as ASTNODE ptr, _
						byval ptrexpr as ASTNODE ptr ) as integer

	dim as integer typ, isfuncptr
	dim as FBSYMBOL ptr subtype

	function = FALSE

    if( sym = NULL ) then
    	exit function
    end if

    typ = symbGetType( sym )

	'' is it really a function?
	if( typ = FB_SYMBTYPE_VOID ) then
		hReportError( FB_ERRMSG_SYNTAXERROR )
		exit function
	end if

	'' '('?
	if( lexGetToken( ) = CHAR_LPRNT ) then
		lexSkipToken( )

		'' ProcParamList
		funcexpr = cProcParamList( sym, ptrexpr, TRUE, FALSE )
		if( funcexpr = NULL ) then
			exit function
		end if

		'' ')'
		if( not hMatch( CHAR_RPRNT ) ) then
    		hReportError FB_ERRMSG_EXPECTEDRPRNT
    		exit function
		end if

	else
		'' ProcParamList (function can have optional args)
		funcexpr = cProcParamList( sym, ptrexpr, TRUE, TRUE )
		if( funcexpr = NULL ) then
			exit function
		end if
	end if

	'' if function returns a pointer, check for field deref
	elm = NULL
	if( typ >= FB_SYMBTYPE_POINTER ) then
    	subtype = symbGetSubType( sym )

		isfuncptr = FALSE
   		if( lexGetToken( ) = CHAR_LPRNT ) then
   			if( typ = FB_SYMBTYPE_POINTER + FB_SYMBTYPE_FUNCTION ) then
				isfuncptr = TRUE
   			end if
   		end if

		'' FuncPtrOrDerefFields?
		cFuncPtrOrDerefFields( sym, elm, typ, subtype, funcexpr, isfuncptr, TRUE )

		if( hGetLastError( ) <> FB_ERRMSG_OK ) then
			exit function
		end if
	end if

	function = TRUE

end function

'':::::
''Function        =   ID ('(' ProcParamList ')')? FuncPtrOrDerefFields? .
''
function cFunction( byref funcexpr as ASTNODE ptr, _
					byref sym as FBSYMBOL ptr, _
					byref elm as FBSYMBOL ptr ) as integer

	function = FALSE

	'' ID
	sym = symbFindByClass( lexGetSymbol, FB_SYMBCLASS_PROC )
	if( sym = NULL ) then
		exit function
	end if

	lexSkipToken( )

	function = cFunctionCall( sym, elm, funcexpr, NULL )

end function
