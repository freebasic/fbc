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

'':::::
''Expression      =   LogExpression .
''
function cExpression( expr as ASTNODE ptr ) as integer

	function = cLogExpression( expr )

end function

'':::::
''LogExpression      =   RelExpression ( (AND | OR | XOR | EQV | IMP) RelExpression )* .
''
function cLogExpression( logexpr as ASTNODE ptr ) as integer
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
    	op = lexCurrentToken
    	select case as const op
    	case FB_TK_AND, FB_TK_OR, FB_TK_XOR, FB_TK_EQV, FB_TK_IMP
 			lexSkipToken
    	case else
      		exit do
    	end select

    	'' RelExpression
    	if( not cRelExpression( relexpr ) ) then
    		hReportError FB_ERRMSG_EXPECTEDEXPRESSION
    		exit function
    	end if

    	'' do operation
    	select case as const op
    	case FB_TK_AND
    		logexpr = astNewBOP( IR_OP_AND, logexpr, relexpr )
    	case FB_TK_OR
    		logexpr = astNewBOP( IR_OP_OR, logexpr, relexpr )
    	case FB_TK_XOR
    		logexpr = astNewBOP( IR_OP_XOR, logexpr, relexpr )
    	case FB_TK_EQV
    		logexpr = astNewBOP( IR_OP_EQV, logexpr, relexpr )
    	case FB_TK_IMP
    		logexpr = astNewBOP( IR_OP_IMP, logexpr, relexpr )
    	end select

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
function cRelExpression( relexpr as ASTNODE ptr ) as integer
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
    	op = lexCurrentToken
    	select case as const op
    	case FB_TK_EQ, FB_TK_GT, FB_TK_LT, FB_TK_NE, FB_TK_LE, FB_TK_GE
 			lexSkipToken
    	case else
      		exit do
    	end select

    	'' AddExpression
    	if( not cAddExpression( addexpr ) ) then
    		hReportError FB_ERRMSG_EXPECTEDEXPRESSION
    		exit function
    	end if

   		'' do operation
   		select case as const op
   		case FB_TK_EQ
   			relexpr = astNewBOP( IR_OP_EQ, relexpr, addexpr )
   		case FB_TK_GT
   			relexpr = astNewBOP( IR_OP_GT, relexpr, addexpr )
   		case FB_TK_LT
   			relexpr = astNewBOP( IR_OP_LT, relexpr, addexpr )
   		case FB_TK_NE
   			relexpr = astNewBOP( IR_OP_NE, relexpr, addexpr )
   		case FB_TK_LE
   			relexpr = astNewBOP( IR_OP_LE, relexpr, addexpr )
   		case FB_TK_GE
   			relexpr = astNewBOP( IR_OP_GE, relexpr, addexpr )
   		end select

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
function cAddExpression( addexpr as ASTNODE ptr ) as integer
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
    	op = lexCurrentToken
    	select case op
    	case CHAR_PLUS, CHAR_MINUS
 			lexSkipToken
    	case else
      		exit do
    	end select

    	'' ShiftExpression
    	if( not cShiftExpression( shiftexpr ) ) then
    		hReportError FB_ERRMSG_EXPECTEDEXPRESSION
    		exit do
    	end if

    	'' do operation
    	select case op
    	case CHAR_PLUS
    		addexpr = astNewBOP( IR_OP_ADD, addexpr, shiftexpr )
    	case CHAR_MINUS
    		addexpr = astNewBOP( IR_OP_SUB, addexpr, shiftexpr )
    	end select

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
function cShiftExpression( shiftexpr as ASTNODE ptr ) as integer
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
    	op = lexCurrentToken
    	select case op
    	case FB_TK_SHL, FB_TK_SHR
 			lexSkipToken
    	case else
      		exit do
    	end select

    	'' ModExpression
    	if( not cModExpression( modexpr ) ) then
    		hReportError FB_ERRMSG_EXPECTEDEXPRESSION
    		exit do
    	end if

    	'' do operation
    	select case op
    	case FB_TK_SHL
    		shiftexpr = astNewBOP( IR_OP_SHL, shiftexpr, modexpr )
    	case FB_TK_SHR
    		shiftexpr = astNewBOP( IR_OP_SHR, shiftexpr, modexpr )
    	end select

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
function cModExpression( modexpr as ASTNODE ptr ) as integer
    dim as ASTNODE ptr idivexpr

    function = FALSE

   	'' IntDivExpression
   	if( not cIntDivExpression( modexpr ) ) then
   		exit function
   	end if

    '' ( ... )*
    do
    	'' Add operator
    	if( lexCurrentToken = FB_TK_MOD ) then
 			lexSkipToken
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
function cIntDivExpression( idivexpr as ASTNODE ptr ) as integer
	dim as ASTNODE ptr mulexpr

    function = FALSE

   	'' MultExpression
   	if( not cMultExpression( idivexpr ) ) then
   		exit function
   	end if

    '' ( ... )*
    do
    	'' '\'
    	if( lexCurrentToken = CHAR_RSLASH ) then
 			lexSkipToken
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
function cMultExpression( mulexpr as ASTNODE ptr ) as integer
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
    	op = lexCurrentToken
    	select case op
    	case CHAR_CARET, CHAR_SLASH
 			lexSkipToken
    	case else
      		exit do
    	end select

    	'' ExpExpression
    	if( not cExpExpression( expexpr ) ) then
    		hReportError FB_ERRMSG_EXPECTEDEXPRESSION
    		exit do
    	end if

    	'' do operation
    	select case op
    	case CHAR_CARET
    		mulexpr = astNewBOP( IR_OP_MUL, mulexpr, expexpr )
    	case CHAR_SLASH
    		mulexpr = astNewBOP( IR_OP_DIV, mulexpr, expexpr )
    	end select

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
function cExpExpression( expexpr as ASTNODE ptr ) as integer
	dim as ASTNODE ptr negexpr

    function = FALSE

   	'' NegNotExpression
   	if( not cNegNotExpression( expexpr ) ) then
   		exit function
   	end if

    '' ( '^' NegNotExpression )*
    do
    	if( lexCurrentToken <> CHAR_CART ) then
    		exit do
    	else
    		lexSkipToken
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
function cNegNotExpression( negexpr as ASTNODE ptr ) as integer

	function = FALSE

	select case lexCurrentToken
	'' '-'
	case CHAR_MINUS
		lexSkipToken

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
		lexSkipToken

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
		lexSkipToken
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

	function = cHighestPresExpr( negexpr )

end function

''::::
'' HighestPresExpr=   AddrOfExpression
''				  |	  DerefExpr
''                |   TypeConvExpr
''				  |   ParentExpression
''				  |   Atom .
''
function cHighestPresExpr( highexpr as ASTNODE ptr ) as integer
    dim as FBSYMBOL ptr sym, elm

	select case lexCurrentToken
	'' AddrOfExpression
	case FB_TK_ADDROFCHAR
		return cAddrOfExpression( highexpr, sym, elm )

	'' DerefExpr
	case FB_TK_DEREFCHAR
		return cDerefExpression( highexpr )

	'' ParentExpression
	case CHAR_LPRNT
		return cParentExpression( highexpr )

	case else

		select case as const lexCurrentToken
		'' AddrOfExpression
		case FB_TK_VARPTR, FB_TK_PROCPTR, FB_TK_SADD, FB_TK_STRPTR
			return cAddrOfExpression( highexpr, sym, elm )

		'' TypeConvExpr
		case FB_TK_CBYTE, FB_TK_CSHORT, FB_TK_CINT, FB_TK_CLNG, FB_TK_CLNGINT, _
			 FB_TK_CUBYTE, FB_TK_CUSHORT, FB_TK_CUINT, FB_TK_CULNGINT, _
			 FB_TK_CSNG, FB_TK_CDBL, _
         	 FB_TK_CSIGN, FB_TK_CUNSG
			return cTypeConvExpr( highexpr )

		'' Atom
		case else
			return cAtom( highexpr )

		end select

	end select

end function

'':::::
''TypeConvExpr		=    (C### '(' expression ')') .
''
function cTypeConvExpr( tconvexpr as ASTNODE ptr ) as integer
    dim totype as integer, op as integer

	function = FALSE

	totype = INVALID
	op = INVALID

	select case as const lexCurrentToken
	case FB_TK_CBYTE
		totype = IR_DATATYPE_BYTE
	case FB_TK_CSHORT
		totype = IR_DATATYPE_SHORT
	case FB_TK_CINT, FB_TK_CLNG
		totype = IR_DATATYPE_INTEGER
	case FB_TK_CLNGINT
		totype = IR_DATATYPE_LONGINT

	case FB_TK_CUBYTE
		totype = IR_DATATYPE_UBYTE
	case FB_TK_CUSHORT
		totype = IR_DATATYPE_USHORT
	case FB_TK_CUINT
		totype = IR_DATATYPE_UINT
	case FB_TK_CULNGINT
		totype = IR_DATATYPE_ULONGINT

	case FB_TK_CSNG
		totype = IR_DATATYPE_SINGLE
	case FB_TK_CDBL
		totype = IR_DATATYPE_DOUBLE

	case FB_TK_CSIGN
		totype = IR_DATATYPE_VOID				'' hack! AST will handle that
		op = IR_OP_TOSIGNED
	case FB_TK_CUNSG
		totype = IR_DATATYPE_VOID				'' hack! /
		op = IR_OP_TOUNSIGNED
	end select

	if( totype = INVALID ) then
		exit function
	else
		lexSkipToken
	end if

	if( not hMatch( CHAR_LPRNT ) ) then
		hReportError FB_ERRMSG_EXPECTEDLPRNT
		exit function
	end if

	if( not cExpression( tconvexpr ) ) then
		exit function
	end if

	tconvexpr = astNewCONV( op, totype, NULL, tconvexpr )

    if( tconvexpr = NULL ) Then
    	hReportError FB_ERRMSG_TYPEMISMATCH, TRUE
    	exit function
    end if

	if( not hMatch( CHAR_RPRNT ) ) then
		hReportError FB_ERRMSG_EXPECTEDRPRNT
		exit function
	end if

	function = TRUE

end function

'':::::
private function hDoDeref( byval cnt as integer, _
						   expr as ASTNODE ptr, _
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
			hReportError FB_ERRMSG_EXPECTEDPOINTER, TRUE
			exit function
		end if

		dtype -= IR_DATATYPE_POINTER

		'' incomplete type?
		if( (dtype = FB_SYMBTYPE_VOID) or (dtype = FB_SYMBTYPE_FWDREF) ) then
			hReportError FB_ERRMSG_INCOMPLETETYPE, TRUE
			exit function
		end if

		expr = astNewPTR( NULL, NULL, 0, expr, dtype, NULL )
		cnt -= 1
	loop

	'' not a pointer?
	if( dtype < IR_DATATYPE_POINTER ) then
		hReportError FB_ERRMSG_EXPECTEDPOINTER, TRUE
		exit function
	end if

    dtype -= FB_SYMBTYPE_POINTER

	'' incomplete type?
	if( (dtype = FB_SYMBTYPE_VOID) or (dtype = FB_SYMBTYPE_FWDREF) ) then
		hReportError FB_ERRMSG_INCOMPLETETYPE, TRUE
		exit function
	end if

    ''
    expr = astNewPTR( sym, elm, 0, expr, dtype, subtype )

    function = dtype

end function

'':::::
''ParentDeref	= 	'(' (AddrOfExpression|Variable) ('+'|'-' Expression)? ')')
''
function cParentDeref( derefexpr as ASTNODE ptr, _
					   sym as FBSYMBOL ptr, _
					   elm as FBSYMBOL ptr, _
					   derefcnt as integer, _
					   dtype as integer, _
					   subtype as FBSYMBOL ptr ) as integer

    dim as FBSYMBOL ptr s
    dim as integer lgt, op
    dim as ASTNODE ptr expr

	function = FALSE

	'' '('
	if( not hMatch( CHAR_LPRNT ) ) then
		exit function
	end if

  	'' AddrOfExpression
	if( cAddrOfExpression( derefexpr, sym, elm ) ) then

		if( elm <> NULL ) then
			dtype   = IR_DATATYPE_POINTER + symbGetType( elm )
			subtype = symbGetSubtype( elm )
		else
			dtype   = IR_DATATYPE_POINTER + symbGetType( sym )
			subtype = symbGetSubtype( sym )
		end if

	else
		'' Variable
  		if( not cVariable( derefexpr, sym, elm ) ) then
			hReportError FB_ERRMSG_EXPECTEDIDENTIFIER
		    exit function
		end if

  		dtype   = astGetDataType( derefexpr )
		subtype = astGetSubType( derefexpr )
  	end if


	'' '-' | '+'
	select case lexCurrentToken
	case CHAR_MINUS
		lexSkipToken
		op = IR_OP_SUB
	case CHAR_PLUS
		lexSkipToken
		op = IR_OP_ADD
	case else
		op = INVALID
	end select

	if( op <> INVALID ) then
		if( not cExpression( expr ) ) then
			hReportError FB_ERRMSG_EXPECTEDEXPRESSION
			exit function
		end if

		'' if index isn't an integer, convert
		if( (astGetDataClass( expr ) <> IR_DATACLASS_INTEGER) or _
			(astGetDataSize( expr ) <> FB_POINTERSIZE) ) then
			expr = astNewCONV( INVALID, IR_DATATYPE_INTEGER, NULL, expr )
			if( expr = NULL ) then
				hReportError FB_ERRMSG_INVALIDDATATYPES
				exit function
			end if
		end if

		'' times length
		lgt = symbCalcLen( dtype - FB_SYMBTYPE_POINTER, subtype )

		if( lgt = 0 ) then
			hReportError FB_ERRMSG_INCOMPLETETYPE, TRUE
			exit function
		end if

		expr = astNewBOP( IR_OP_MUL, expr, astNewCONSTi( lgt, IR_DATATYPE_INTEGER ) )

	end if

	'' ')'
	if( not hMatch( CHAR_RPRNT ) ) then
		hReportError FB_ERRMSG_EXPECTEDRPRNT
		exit function
	end if

	''
	if( op <> INVALID ) then
		derefexpr = astNewBOP( op, derefexpr, expr )
	end if

    ''
	if( cDerefFields( sym, elm, dtype, subtype, derefexpr, TRUE, FALSE ) ) then
		derefcnt -= 1
	else
		if( hGetLastError <> FB_ERRMSG_OK ) then
			exit function
		end if
	end if

	function = TRUE

end function

'':::::
''DerefExpression	= 	DREF+ ( AddrOfExpression
''							  | Function
''							  | Variable
''							  | ParentDeref) .
''
function cDerefExpression( derefexpr as ASTNODE ptr ) as integer
    dim as FBSYMBOL ptr sym, elm, subtype
    dim as integer derefcnt, dtype
    dim as ASTNODE ptr funcexpr

	function = FALSE

	'' DREF?
	if( lexCurrentToken <> FB_TK_DEREFCHAR ) then
		exit function
	end if

	'' DREF+
    derefcnt = 0
	do
		lexSkipToken( )
		derefcnt += 1
	loop while( lexCurrentToken( ) = FB_TK_DEREFCHAR )

	'' AddrOfExpression
	if(  cAddrOfExpression( derefexpr, sym, elm ) ) then

		if( elm <> NULL ) then
			dtype   = IR_DATATYPE_POINTER + symbGetType( elm )
			subtype = symbGetSubtype( elm )
		else
			dtype   = IR_DATATYPE_POINTER + symbGetType( sym )
			subtype = symbGetSubtype( sym )
		end if

	else

  		sym = NULL
  		elm = NULL

        '' ParentDeref
  		if( not cParentDeref( derefexpr, sym, elm, derefcnt, dtype, subtype ) ) then

			if( hGetLastError <> FB_ERRMSG_OK ) then
				exit function
			end if

  			'' can be PEEK() or VA_ARG()..
  			if( not cQuirkFunction( derefexpr ) ) then
  				'' Function
  				if( not cFunction( derefexpr, sym, elm ) ) then
  					'' Variable
  					if( not cVariable( derefexpr, sym, elm ) ) then
  						exit function
		    		end if
				end if
			end if

			dtype   = astGetDataType( derefexpr )
			subtype = astGetSubType( derefexpr )

		end if

	end if

	''
	if( derefcnt > 0 ) then
		dtype = hDoDeref( derefcnt, derefexpr, sym, elm, dtype, subtype )
		if( dtype = INVALID ) then
			exit function
		end if
	end if

	'' function ptr?
	if( dtype = IR_DATATYPE_POINTER+IR_DATATYPE_FUNCTION ) then
		if( lexCurrentToken = CHAR_LPRNT ) then

			if( elm <> NULL ) then
				sym = elm
			end if

			sym = symbGetSubtype( sym )
			elm = NULL

			''
			if( symbGetType( sym ) <> FB_SYMBTYPE_VOID ) then
				if( not cFunctionCall( sym, elm, funcexpr, derefexpr ) ) then
					exit function
				end if
				derefexpr = funcexpr

			else
				if( not cProcCall( sym, funcexpr, derefexpr ) ) then
					exit function
				end if
		    	derefexpr = funcexpr
			end if
		end if
	end if

	function = TRUE

end function

'':::::
private function hProcPtrBody( byval proc as FBSYMBOL ptr, _
							   addrofexpr as ASTNODE ptr ) as integer
	dim as ASTNODE ptr expr
	dim as integer dtype

	function = FALSE

	'' '('')'?
	if( hMatch( CHAR_LPRNT ) ) then
		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB_ERRMSG_EXPECTEDRPRNT
			exit function
		end if
	end if

	expr = astNewVAR( proc, NULL, 0, IR_DATATYPE_UINT )
	addrofexpr = astNewADDR( IR_OP_ADDROF, expr, proc )

	function = TRUE

end function

'':::::
private function hVarPtrBody( addrofexpr as ASTNODE ptr, _
							  sym as FBSYMBOL ptr, _
							  elm as FBSYMBOL ptr ) as integer

	function = FALSE

	if( not cVariable( addrofexpr, sym, elm ) ) then
		exit function
	end if

	addrofexpr = astNewADDR( IR_OP_ADDROF, addrofexpr, sym, elm )

    function = TRUE

end function

'':::::
''AddrOfExpression  =   VARPTR '(' Variable ')'
''					|   PROCPTR '(' Proc ('('')')? ')'
'' 					| 	'@' (Proc ('('')')? | Variable)
''					|   SADD|STRPTR '(' Variable{str}|Const{str}|Literal{str} ')' .
''
function cAddrOfExpression( addrofexpr as ASTNODE ptr, _
							sym as FBSYMBOL ptr, _
							elm as FBSYMBOL ptr ) as integer

    dim as ASTNODE ptr expr
    dim as integer dtype
    dim as FBSYMBOL ptr s

	function = FALSE

	'' '@' (Proc ('('')')? | Variable)
	if( lexCurrentToken = FB_TK_ADDROFCHAR ) then
		lexSkipToken

		'' proc?
		s = symbFindByClass( lexTokenSymbol, FB_SYMBCLASS_PROC )
		if( s <> NULL ) then
			lexSkipToken

			if( not hProcPtrBody( s, addrofexpr ) ) then
				exit function
			end if
			sym = s
			elm = NULL

		else
			if( not hVarPtrBody( addrofexpr, sym, elm ) ) then
				exit function
			end if
		end if

		return TRUE
	end if

	select case as const lexCurrentToken
	'' VARPTR '(' Variable ')'
	case FB_TK_VARPTR
		lexSkipToken

		if( not hMatch( CHAR_LPRNT ) ) then
			hReportError FB_ERRMSG_EXPECTEDLPRNT
			exit function
		end if

		if( not hVarPtrBody( addrofexpr, sym, elm ) ) then
			exit function
		end if

		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB_ERRMSG_EXPECTEDRPRNT
			exit function
		end if

		return TRUE

	'' PROCPTR '(' Proc ('('')')? ')'
	case FB_TK_PROCPTR
		lexSkipToken

		if( not hMatch( CHAR_LPRNT ) ) then
			hReportError FB_ERRMSG_EXPECTEDLPRNT
			exit function
		end if

		'' proc?
		s = symbFindByClass( lexTokenSymbol, FB_SYMBCLASS_PROC )
		if( s = NULL ) then
			hReportError FB_ERRMSG_UNDEFINEDSYMBOL
			exit function
		else
			lexSkipToken
		end if

		if( not hProcPtrBody( s, addrofexpr ) ) then
			exit function
		end if

		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB_ERRMSG_EXPECTEDRPRNT
			exit function
		end if
		sym = s
		elm	= NULL

		return TRUE

	'' SADD|STRPTR '(' Variable{str} ')'
	case FB_TK_SADD, FB_TK_STRPTR
		lexSkipToken

		if( not hMatch( CHAR_LPRNT ) ) then
			hReportError FB_ERRMSG_EXPECTEDLPRNT
			exit function
		end if

		elm = NULL
		if( not cLiteral( expr ) ) then
			if( not cConstant( expr ) ) then
				if( not cVariable( expr, sym, elm ) ) then
					exit function
				end if
			end if
		end if
		sym = astGetSymbol( expr )

		dtype = astGetDataType( expr )
		if( not hIsString( dtype ) ) then
			hReportError FB_ERRMSG_INVALIDDATATYPES
			exit function
		end if

		if( dtype = IR_DATATYPE_STRING ) then
			addrofexpr = astNewADDR( IR_OP_DEREF, expr, sym, elm )
		else
			addrofexpr = astNewADDR( IR_OP_ADDROF, expr, sym, elm )
		end if

		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB_ERRMSG_EXPECTEDRPRNT
			exit function
		end if

		return TRUE
	end select

end function

'':::::
''ParentExpression=   '(' Expression ')' .
''
function cParentExpression( parexpr as ASTNODE ptr ) as integer

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
  			hReportError FB_ERRMSG_EXPECTEDEXPRESSION
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
  				hReportError FB_ERRMSG_EXPECTEDRPRNT
  				exit function
  			end if
  		end if

  		function = TRUE
  	end if

end function

'':::::
''Atom            =   Constant | Function | QuirkFunction | Variable | Literal .
''
function cAtom( atom as ASTNODE ptr ) as integer
    dim as FBSYMBOL ptr sym, elm
    dim as integer res

  	atom = NULL

  	select case lexCurrentTokenClass
  	case FB_TKCLASS_KEYWORD
  		return cQuirkFunction( atom )

  	case FB_TKCLASS_IDENTIFIER
  		res = cConstant( atom )
  		if( not res ) then
  			res = cFunction( atom, sym, elm )
  			if( not res ) then
  				res = cVariable( atom, sym, elm, env.varcheckarray )
  			end if
  		end if

  		return res

  	case else
  		return cLiteral( atom )
  	end select

end function

'':::::
'' Constant       = ID .                                    !!ambiguity w/ var!!
''
function cConstant( constexpr as ASTNODE ptr ) as integer static
	static as zstring * FB_MAXLITLEN+1 text
	dim as FBSYMBOL ptr s
	dim as integer typ

	function = FALSE

	s = symbFindByClass( lexTokenSymbol( ), FB_SYMBCLASS_CONST )
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
  			case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
  				constexpr = astNewCONST64( val64( text ), typ )
  			case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
  				constexpr = astNewCONSTf( val( text ), typ )
  			case else
  				constexpr = astNewCONSTi( valint( text ), typ )
  			end select
  		end if

  		lexSkipToken( )
  		function = TRUE
  	end if

end function

'':::::
''Literal		  = NUM_LITERAL | STR_LITERAL .
''
function cLiteral( litexpr as ASTNODE ptr ) as integer
	dim as FBSYMBOL ptr tc
	dim as integer typ

	function = FALSE

	select case lexCurrentTokenClass( )
	case FB_TKCLASS_NUMLITERAL
  		typ = lexTokenType( )
  		select case as const typ
  		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
			litexpr = astNewCONST64( val64( *lexTokenText( ) ), typ )
  		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			litexpr = astNewCONSTf( val( *lexTokenText( ) ), typ )
		case else
			litexpr = astNewCONSTi( valint( *lexTokenText( ) ), typ )
  		end select

  		lexSkipToken( )
  		function = TRUE

  	case FB_TKCLASS_STRLITERAL
		tc = hAllocStringConst( *lexTokenText( ), lexTokenTextLen( ) )
		litexpr = astNewVAR( tc, NULL, 0, IR_DATATYPE_FIXSTR )

		lexSkipToken( )
        function = TRUE
  	end select

end function

'':::::
function cFunctionCall( byval sym as FBSYMBOL ptr, _
						elm as FBSYMBOL ptr, _
						funcexpr as ASTNODE ptr, _
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
		hReportError FB_ERRMSG_SYNTAXERROR
		exit function
	end if

	'' '('?
	if( lexCurrentToken = CHAR_LPRNT ) then
		lexSkipToken

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
   		if( lexCurrentToken = CHAR_LPRNT ) then
   			if( typ = FB_SYMBTYPE_POINTER + FB_SYMBTYPE_FUNCTION ) then
				isfuncptr = TRUE
   			end if
   		end if

		'' FuncPtrOrDerefFields?
		cFuncPtrOrDerefFields( sym, elm, typ, subtype, funcexpr, isfuncptr, TRUE )

		if( hGetLastError <> FB_ERRMSG_OK ) then
			exit function
		end if
	end if

	function = TRUE

end function

'':::::
''Function        =   ID ('(' ProcParamList ')')? .	 			//ambiguity w/ var!!
''
function cFunction( funcexpr as ASTNODE ptr, _
					sym as FBSYMBOL ptr, _
					elm as FBSYMBOL ptr ) as integer

	function = FALSE

	'' ID
	sym = symbFindByClass( lexTokenSymbol, FB_SYMBCLASS_PROC )
	if( sym = NULL ) then
		exit function
	end if

	lexSkipToken( )

	function = cFunctionCall( sym, elm, funcexpr, NULL )

end function
