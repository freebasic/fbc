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
'$include once: 'inc\fb.bi'
'$include once: 'inc\fbint.bi'
'$include once: 'inc\parser.bi'
'$include once: 'inc\ast.bi'
'$include once: 'inc\ir.bi'
'$include once: 'inc\emit.bi'

'':::::
''Expression      =   LogExpression .
''
function cExpression( expr as integer )

	cExpression = cLogExpression( expr )

end function

'':::::
''LogExpression      =   RelExpression ( (AND | OR | XOR | EQV | IMP) RelExpression )* .
''
function cLogExpression( logexpr as integer )
    dim op as integer, relexpr as integer

	cLogExpression = FALSE

    '' RelExpression
    if( not cRelExpression( logexpr ) ) then
	   	exit function
    end if

    '' ( ... )*
    do
    	'' Logical operator
    	op = lexCurrentToken
    	select case as const op
    	case FB.TK.AND, FB.TK.OR, FB.TK.XOR, FB.TK.EQV, FB.TK.IMP
 			lexSkipToken
    	case else
      		exit do
    	end select

    	'' RelExpression
    	if( not cRelExpression( relexpr ) ) then
    		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
    		exit function
    	end if

    	'' do operation
    	select case as const op
    	case FB.TK.AND
    		logexpr = astNewBOP( IR.OP.AND, logexpr, relexpr )
    	case FB.TK.OR
    		logexpr = astNewBOP( IR.OP.OR, logexpr, relexpr )
    	case FB.TK.XOR
    		logexpr = astNewBOP( IR.OP.XOR, logexpr, relexpr )
    	case FB.TK.EQV
    		logexpr = astNewBOP( IR.OP.EQV, logexpr, relexpr )
    	case FB.TK.IMP
    		logexpr = astNewBOP( IR.OP.IMP, logexpr, relexpr )
    	end select

        if( logexpr = INVALID ) then
			hReportError FB.ERRMSG.TYPEMISMATCH
            exit function
        end if

    loop

	cLogExpression = TRUE

end function

'':::::
''RelExpression   =   AddExpression ( (EQ | GT | LT | NE | LE | GE) AddExpression )* .
''
function cRelExpression( relexpr as integer )
    dim op as integer, addexpr as integer

    cRelExpression = FALSE

   	'' AddExpression
   	if( not cAddExpression( relexpr ) ) then
   		exit function
   	end if

    '' ( ... )*
    do
    	'' Relational operator
    	op = lexCurrentToken
    	select case as const op
    	case FB.TK.EQ, FB.TK.GT, FB.TK.LT, FB.TK.NE, FB.TK.LE, FB.TK.GE
 			lexSkipToken
    	case else
      		exit do
    	end select

    	'' AddExpression
    	if( not cAddExpression( addexpr ) ) then
    		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
    		exit function
    	end if

   		'' do operation
   		select case as const op
   		case FB.TK.EQ
   			relexpr = astNewBOP( IR.OP.EQ, relexpr, addexpr )
   		case FB.TK.GT
   			relexpr = astNewBOP( IR.OP.GT, relexpr, addexpr )
   		case FB.TK.LT
   			relexpr = astNewBOP( IR.OP.LT, relexpr, addexpr )
   		case FB.TK.NE
   			relexpr = astNewBOP( IR.OP.NE, relexpr, addexpr )
   		case FB.TK.LE
   			relexpr = astNewBOP( IR.OP.LE, relexpr, addexpr )
   		case FB.TK.GE
   			relexpr = astNewBOP( IR.OP.GE, relexpr, addexpr )
   		end select

    	if( relexpr = INVALID ) Then
    		hReportError FB.ERRMSG.TYPEMISMATCH
    		exit function
    	end if
    loop

    cRelExpression = TRUE

end function

'':::::
''AddExpression   =   ShiftExpression ( ('+' | '-') ShiftExpression )* .
''
function cAddExpression( addexpr as integer )
    dim op as integer, shiftexpr as integer

    cAddExpression = FALSE

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
    		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
    		exit do
    	end if

    	'' do operation
    	select case op
    	case CHAR_PLUS
    		addexpr = astNewBOP( IR.OP.ADD, addexpr, shiftexpr )
    	case CHAR_MINUS
    		addexpr = astNewBOP( IR.OP.SUB, addexpr, shiftexpr )
    	end select

    	if( addexpr = INVALID ) Then
    		hReportError FB.ERRMSG.TYPEMISMATCH
    		exit function
    	end if
    loop

    cAddExpression = TRUE

end function

'':::::
''ShiftExpression  =   ModExpression ( (SHL | SHR) ModExpression )* .
''
function cShiftExpression( shiftexpr as integer )
    dim op as integer, modexpr as integer

    cShiftExpression = FALSE

   	'' ModExpression
   	if( not cModExpression( shiftexpr ) ) then
   		exit function
   	end if

    '' ( ... )*
    do
    	'' Shift operator
    	op = lexCurrentToken
    	select case op
    	case FB.TK.SHL, FB.TK.SHR
 			lexSkipToken
    	case else
      		exit do
    	end select

    	'' ModExpression
    	if( not cModExpression( modexpr ) ) then
    		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
    		exit do
    	end if

    	'' do operation
    	select case op
    	case FB.TK.SHL
    		shiftexpr = astNewBOP( IR.OP.SHL, shiftexpr, modexpr )
    	case FB.TK.SHR
    		shiftexpr = astNewBOP( IR.OP.SHR, shiftexpr, modexpr )
    	end select

    	if( shiftexpr = INVALID ) Then
    		hReportError FB.ERRMSG.TYPEMISMATCH
    		exit function
    	end if
    loop

    cShiftExpression = TRUE

end function

'':::::
''ModExpression   =   IntDivExpression ( MOD IntDivExpression )* .
''
function cModExpression( modexpr as integer )
    dim idivexpr as integer

    cModExpression = FALSE

   	'' IntDivExpression
   	if( not cIntDivExpression( modexpr ) ) then
   		exit function
   	end if

    '' ( ... )*
    do
    	'' Add operator
    	if( lexCurrentToken = FB.TK.MOD ) then
 			lexSkipToken
    	else
      		exit do
    	end if

    	'' IntDivExpression
    	if( not cIntDivExpression( idivexpr ) ) then
    		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
    		exit function
    	end if

    	'' do operation
    	modexpr = astNewBOP( IR.OP.MOD, modexpr, idivexpr )

    	if( modexpr = INVALID ) Then
    		hReportError FB.ERRMSG.TYPEMISMATCH
    		exit function
    	end if
    loop

    cModExpression = TRUE

end function

'':::::
''IntDivExpression=   MultExpression ( '\' MultExpression )* .
''
function cIntDivExpression( idivexpr as integer )
	dim mulexpr as integer

    cIntDivExpression = FALSE

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
    		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
    		exit function
    	end if

    	'' do operation
    	idivexpr = astNewBOP( IR.OP.INTDIV, idivexpr, mulexpr )

    	if( idivexpr = INVALID ) Then
    		hReportError FB.ERRMSG.TYPEMISMATCH
    		exit function
    	end if
    loop

    cIntDivExpression = TRUE

end function

'':::::
''MultExpression  =   ExpExpression ( ('*' | '/') ExpExpression )* .
''
function cMultExpression( mulexpr as integer )
    dim op as integer, expexpr as integer

    cMultExpression = FALSE

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
    		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
    		exit do
    	end if

    	'' do operation
    	select case op
    	case CHAR_CARET
    		mulexpr = astNewBOP( IR.OP.MUL, mulexpr, expexpr )
    	case CHAR_SLASH
    		mulexpr = astNewBOP( IR.OP.DIV, mulexpr, expexpr )
    	end select

    	if( mulexpr = INVALID ) Then
    		hReportError FB.ERRMSG.TYPEMISMATCH
    		exit function
    	end if
    loop

    cMultExpression = TRUE

end function

'':::::
''ExpExpression   =   NegNotExpression ( '^' NegNotExpression )* .
''
function cExpExpression( expexpr as integer )
	dim negexpr as integer

    cExpExpression = FALSE

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
    		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
    		exit do
    	end if

    	'' do operation
    	expexpr = astNewBOP( IR.OP.POW, expexpr, negexpr )

    	if( expexpr = INVALID ) Then
    		hReportError FB.ERRMSG.TYPEMISMATCH
    		exit function
    	end if
    loop

    cExpExpression = TRUE

end function

'':::::
''NegNotExpression=   ('-'|'+'|) ExpExpression
''				  |   NOT RelExpression
''				  |   HighestPresExpr .
''
function cNegNotExpression( negexpr as integer )
    dim res as integer

	cNegNotExpression = FALSE

	select case lexCurrentToken
	'' '-'
	case CHAR_MINUS
		lexSkipToken

		'' ExpExpression
		if( not cExpExpression( negexpr ) ) then
			exit function
		end if

		negexpr = astNewUOP( IR.OP.NEG, negexpr )

    	if( negexpr = INVALID ) Then
    		hReportError FB.ERRMSG.TYPEMISMATCH
    		exit function
    	end if

		cNegNotExpression = TRUE
		exit function

	'' '+'
	case CHAR_PLUS
		lexSkipToken

		'' ExpExpression
		cNegNotExpression = cExpExpression( negexpr )
		exit function

	'' NOT
	case FB.TK.NOT
		lexSkipToken
		'' RelExpression
		if( not cRelExpression( negexpr ) ) then
			exit function
		end if

		negexpr = astNewUOP( IR.OP.NOT, negexpr )

    	if( negexpr = INVALID ) Then
    		hReportError FB.ERRMSG.TYPEMISMATCH
    		exit function
    	end if

		cNegNotExpression = TRUE
		exit function
	end select

	cNegNotExpression = cHighestPresExpr( negexpr )

end function

''::::
'' HighestPresExpr=   AddrOfExpression
''				  |	  DerefExpr
''                |   TypeConvExpr
''				  |   ParentExpression
''				  |   Atom .
''
function cHighestPresExpr( highexpr as integer ) as integer
    dim res as integer
    dim sym as FBSYMBOL ptr, elm as FBSYMBOL ptr

	select case lexCurrentToken
	'' AddrOfExpression
	case FB.TK.ADDROFCHAR
		res = cAddrOfExpression( highexpr, sym, elm )

	'' DerefExpr
	case FB.TK.DEREFCHAR
		res = cDerefExpression( highexpr )

	'' ParentExpression
	case CHAR_LPRNT
		res = cParentExpression( highexpr )

	case else

		select case as const lexCurrentToken
		'' AddrOfExpression
		case FB.TK.VARPTR, FB.TK.PROCPTR, FB.TK.SADD, FB.TK.STRPTR
			res = cAddrOfExpression( highexpr, sym, elm )

		'' TypeConvExpr
		case FB.TK.CBYTE, FB.TK.CSHORT, FB.TK.CINT, FB.TK.CLNG, FB.TK.CLNGINT, _
			 FB.TK.CUBYTE, FB.TK.CUSHORT, FB.TK.CUINT, FB.TK.CULNGINT, _
			 FB.TK.CSNG, FB.TK.CDBL, _
         	 FB.TK.CSIGN, FB.TK.CUNSG
			res = cTypeConvExpr( highexpr )

		'' Atom
		case else
			res = cAtom( highexpr )

		end select

	end select

	cHighestPresExpr = res

end function

'':::::
''TypeConvExpr		=    (C### '(' expression ')') .
''
function cTypeConvExpr( tconvexpr as integer )
    dim totype as integer, op as integer

	cTypeConvExpr = FALSE

	totype = INVALID
	op = INVALID

	select case as const lexCurrentToken
	case FB.TK.CBYTE
		totype = IR.DATATYPE.BYTE
	case FB.TK.CSHORT
		totype = IR.DATATYPE.SHORT
	case FB.TK.CINT, FB.TK.CLNG
		totype = IR.DATATYPE.INTEGER
	case FB.TK.CLNGINT
		totype = IR.DATATYPE.LONGINT

	case FB.TK.CUBYTE
		totype = IR.DATATYPE.UBYTE
	case FB.TK.CUSHORT
		totype = IR.DATATYPE.USHORT
	case FB.TK.CUINT
		totype = IR.DATATYPE.UINT
	case FB.TK.CULNGINT
		totype = IR.DATATYPE.ULONGINT

	case FB.TK.CSNG
		totype = IR.DATATYPE.SINGLE
	case FB.TK.CDBL
		totype = IR.DATATYPE.DOUBLE

	case FB.TK.CSIGN
		totype = IR.DATATYPE.VOID				'' hack! AST will handle that
		op = IR.OP.TOSIGNED
	case FB.TK.CUNSG
		totype = IR.DATATYPE.VOID				'' hack! /
		op = IR.OP.TOUNSIGNED
	end select

	if( totype = INVALID ) then
		exit function
	else
		lexSkipToken
	end if

	if( not hMatch( CHAR_LPRNT ) ) then
		hReportError FB.ERRMSG.EXPECTEDLPRNT
		exit function
	end if

	if( not cExpression( tconvexpr ) ) then
		exit function
	end if

	tconvexpr = astNewCONV( op, totype, tconvexpr )

    if( tconvexpr = INVALID ) Then
    	hReportError FB.ERRMSG.TYPEMISMATCH, TRUE
    	exit function
    end if

	if( not hMatch( CHAR_RPRNT ) ) then
		hReportError FB.ERRMSG.EXPECTEDRPRNT
		exit function
	end if

	cTypeConvExpr = TRUE

end function

'':::::
private function hDoDeref( byval cnt as integer, expr as integer, _
					       byval sym as FBSYMBOL ptr, byval elm as FBSYMBOL ptr ) as integer

	dim dtype as integer, subtype as FBSYMBOL ptr

	dtype   = astGetDataType( expr )
	subtype = astGetSubType( expr )

	hDoDeref = INVALID

	if( (expr = INVALID) or (cnt <= 0) ) then
		exit function
	end if

	do while( cnt > 1 )
		'' not a pointer?
		if( dtype < IR.DATATYPE.POINTER ) then
			hReportError FB.ERRMSG.EXPECTEDPOINTER, TRUE
			exit function
		end if

		dtype -= IR.DATATYPE.POINTER

		'' incomplete type?
		if( dtype = FB.SYMBTYPE.FWDREF ) then
			hReportError FB.ERRMSG.INCOMPLETETYPE, TRUE
			exit function
		end if

		expr = astNewPTR( NULL, NULL, 0, expr, dtype, NULL )
		cnt = cnt - 1
	loop

	'' not a pointer?
	if( dtype < IR.DATATYPE.POINTER ) then
		hReportError FB.ERRMSG.EXPECTEDPOINTER, TRUE
		exit function
	end if

    dtype -= FB.SYMBTYPE.POINTER

	'' incomplete type?
	if( dtype = FB.SYMBTYPE.FWDREF ) then
		hReportError FB.ERRMSG.INCOMPLETETYPE, TRUE
		exit function
	end if

    ''
    expr = astNewPTR( sym, elm, 0, expr, dtype, subtype )

    hDoDeref = dtype

end function

'':::::
''ParentDeref	= 	'(' (AddrOfExpression|Variable) ('+'|'-' Expression)? ')')
''
function cParentDeref( derefexpr as integer, sym as FBSYMBOL ptr, elm as FBSYMBOL ptr, _
					   derefcnt as integer )

    dim as FBSYMBOL ptr s, subtype
    dim as integer lgt, dtype, expr, op

	cParentDeref = FALSE

	'' '('
	if( not hMatch( CHAR_LPRNT ) ) then
		hReportError FB.ERRMSG.EXPECTEDLPRNT
		exit function
	end if

  	'' AddrOfExpression
	if( cAddrOfExpression( derefexpr, sym, elm ) ) then

		dtype = astGetDataType( derefexpr )

	else
		'' Variable
  		if( not cVariable( derefexpr, sym, elm ) ) then
			hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
		    exit function
		end if

  		dtype = astGetDataType( derefexpr )
  	end if

	subtype = astGetSubType( derefexpr )

	'' '-' | '+'
	select case lexCurrentToken
	case CHAR_MINUS
		lexSkipToken
		op = IR.OP.SUB
	case CHAR_PLUS
		lexSkipToken
		op = IR.OP.ADD
	case else
		op = INVALID
	end select

	if( op <> INVALID ) then
		if( not cExpression( expr ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if

		'' if index isn't an integer, convert
		if( (astGetDataClass( expr ) <> IR.DATACLASS.INTEGER) or _
			(astGetDataSize( expr ) <> FB.POINTERSIZE) ) then
			expr = astNewCONV( INVALID, IR.DATATYPE.INTEGER, expr )
			if( expr = INVALID ) then
				hReportError FB.ERRMSG.INVALIDDATATYPES
				exit function
			end if
		end if

		'' times length
		lgt = symbCalcLen( dtype - FB.SYMBTYPE.POINTER, subtype )

		if( lgt = 0 ) then
			hReportError FB.ERRMSG.INCOMPLETETYPE, TRUE
			exit function
		end if

		expr = astNewBOP( IR.OP.MUL, expr, astNewCONSTi( lgt, IR.DATATYPE.INTEGER ) )

	end if

	'' ')'
	if( not hMatch( CHAR_RPRNT ) ) then
		hReportError FB.ERRMSG.EXPECTEDRPRNT
		exit function
	end if

	''
	if( op <> INVALID ) then
		derefexpr = astNewBOP( op, derefexpr, expr )
	end if

    ''
	if( not cDerefFields( sym, elm, dtype, subtype, derefexpr, TRUE, FALSE ) ) then
		if( hGetLastError <> FB.ERRMSG.OK ) then
			exit function
		end if
	else
		derefcnt -= 1
	end if

	cParentDeref = TRUE

end function

'':::::
''DerefExpression	= 	DREF+ ( AddrOfExpression
''							  | Function
''							  | Variable
''							  | ParentDeref) .
''
function cDerefExpression( derefexpr as integer ) as integer
    dim as FBSYMBOL ptr sym, elm
    dim as integer derefcnt, funcexpr, dtype

	cDerefExpression = FALSE

	'' DREF?
	if( lexCurrentToken <> FB.TK.DEREFCHAR ) then
		exit function
	end if

	'' DREF+
    derefcnt = 0
	do
		lexSkipToken
		derefcnt += 1
	loop while( lexCurrentToken = FB.TK.DEREFCHAR )

	'' AddrOfExpression
	if( not cAddrOfExpression( derefexpr, sym, elm ) ) then

  		sym = NULL
  		elm = NULL

  		'' can be PEEK() or VA_ARG()..
  		if( not cQuirkFunction( derefexpr ) ) then
  			'' Function
  			if( not cFunction( derefexpr, sym, elm ) ) then
  				'' Variable
  				if( not cVariable( derefexpr, sym, elm ) ) then
                	'' ParentDeref
  					if( not cParentDeref( derefexpr, sym, elm, derefcnt ) ) then
  						exit function
  					end if
		    	end if
			end if
		end if

	end if

	''
	if( derefcnt > 0 ) then
		dtype = hDoDeref( derefcnt, derefexpr, sym, elm )
		if( dtype = INVALID ) then
			exit function
		end if
	end if

	'' function ptr?
	if( dtype = IR.DATATYPE.POINTER+IR.DATATYPE.FUNCTION ) then
		if( lexCurrentToken = CHAR_LPRNT ) then

			if( elm <> NULL ) then
				sym = elm
			end if

			sym = symbGetSubtype( sym )
			elm = NULL

			''
			if( symbGetType( sym ) <> FB.SYMBTYPE.VOID ) then
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

	cDerefExpression = TRUE

end function

'':::::
private function hProcPtrBody( byval proc as FBSYMBOL ptr, addrofexpr as integer ) as integer
	dim expr as integer, dtype as integer

	hProcPtrBody = FALSE

	'' '('')'?
	if( hMatch( CHAR_LPRNT ) ) then
		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDRPRNT
			exit function
		end if
	end if

	expr = astNewVAR( proc, NULL, 0, IR.DATATYPE.UINT )
	addrofexpr = astNewADDR( IR.OP.ADDROF, expr, proc )

	hProcPtrBody = TRUE

end function

'':::::
private function hVarPtrBody( addrofexpr as integer, sym as FBSYMBOL ptr, elm as FBSYMBOL ptr ) as integer

	hVarPtrBody = FALSE

	if( not cVariable( addrofexpr, sym, elm ) ) then
		exit function
	end if

	addrofexpr = astNewADDR( IR.OP.ADDROF, addrofexpr, sym, elm )

    hVarPtrBody = TRUE

end function

'':::::
''AddrOfExpression  =   VARPTR '(' Variable ')'
''					|   PROCPTR '(' Proc ('('')')? ')'
'' 					| 	'@' (Proc ('('')')? | Variable)
''					|   SADD|STRPTR '(' Variable{str}|Const{str}|Literal{str} ')' .
''
function cAddrOfExpression( addrofexpr as integer, _
							sym as FBSYMBOL ptr, _
							elm as FBSYMBOL ptr )

    dim expr as integer, dtype as integer, s as FBSYMBOL ptr

	cAddrOfExpression = FALSE

	'' '@' (Proc ('('')')? | Variable)
	if( lexCurrentToken = FB.TK.ADDROFCHAR ) then
		lexSkipToken

		'' proc?
		s = symbFindByClass( lexTokenSymbol, FB.SYMBCLASS.PROC )
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

		cAddrOfExpression = TRUE
        exit function
	end if

	select case as const lexCurrentToken
	'' VARPTR '(' Variable ')'
	case FB.TK.VARPTR
		lexSkipToken

		if( not hMatch( CHAR_LPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDLPRNT
			exit function
		end if

		if( not hVarPtrBody( addrofexpr, sym, elm ) ) then
			exit function
		end if

		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDRPRNT
			exit function
		end if

		cAddrOfExpression = TRUE
        exit function

	'' PROCPTR '(' Proc ('('')')? ')'
	case FB.TK.PROCPTR
		lexSkipToken

		if( not hMatch( CHAR_LPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDLPRNT
			exit function
		end if

		'' proc?
		s = symbFindByClass( lexTokenSymbol, FB.SYMBCLASS.PROC )
		if( s = NULL ) then
			hReportError FB.ERRMSG.UNDEFINEDSYMBOL
			exit function
		else
			lexSkipToken
		end if

		if( not hProcPtrBody( s, addrofexpr ) ) then
			exit function
		end if

		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDRPRNT
			exit function
		end if
		sym = s
		elm	= NULL

		cAddrOfExpression = TRUE
        exit function


	'' SADD|STRPTR '(' Variable{str} ')'
	case FB.TK.SADD, FB.TK.STRPTR
		lexSkipToken

		if( not hMatch( CHAR_LPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDLPRNT
			exit function
		end if

		elm = NULL
		if( not cLiteral( expr ) ) then
			if( not cConstant( expr ) ) then
				if( not cVariable( expr, sym, elm ) ) then
					exit function
				end if
			end if
			sym = astGetSymbol( expr )
		end if

		dtype = astGetDataType( expr )
		if( not hIsString( dtype ) ) then
			hReportError FB.ERRMSG.INVALIDDATATYPES
			exit function
		end if

		if( dtype = IR.DATATYPE.STRING ) then
			addrofexpr = astNewADDR( IR.OP.DEREF, expr, sym, elm )
		else
			addrofexpr = astNewADDR( IR.OP.ADDROF, expr, sym, elm )
		end if

		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDRPRNT
			exit function
		end if

		cAddrOfExpression = TRUE
        exit function
	end select

end function

'':::::
''ParentExpression=   '(' Expression ')' .
''
function cParentExpression( parexpr as integer )

  	cParentExpression = FALSE

  	'' '('
  	if( not hMatch( CHAR_LPRNT ) ) then
  		exit function
  	end if

  	'' ++parent cnt
  	env.prntcnt = env.prntcnt + 1

  	if( not cExpression( parexpr ) ) then
  		'' calling a SUB? it can be a BYVAL or nothing due the optional ()'s
  		if( not env.prntopt ) then
  			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
  			exit function
  		end if

  	else
  		'' ')'
  		if( hMatch( CHAR_RPRNT ) ) then
  			'' --parent cnt
  			env.prntcnt = env.prntcnt - 1
  		else
  			'' not calling a SUB or parent cnt = 0?
  			if( (not env.prntopt) or (env.prntcnt = 0) ) then
  				hReportError FB.ERRMSG.EXPECTEDRPRNT
  				exit function
  			end if
  		end if

  		cParentExpression = TRUE
  	end if

end function

'':::::
''Atom            =   Constant | Function | QuirkFunction | Variable | Literal .
''
function cAtom( atom as integer )
    dim sym as FBSYMBOL ptr, elm as FBSYMBOL ptr
    dim res as integer

  	atom = INVALID

  	select case lexCurrentTokenClass
  	case FB.TKCLASS.KEYWORD
  		res = cQuirkFunction( atom )

  	case FB.TKCLASS.IDENTIFIER
  		res = cConstant( atom )
  		if( not res ) then
  			res = cFunction( atom, sym, elm )
  			if( not res ) then
  				res = cVariable( atom, sym, elm, env.varcheckarray )
  			end if
  		end if

  	case else
  		res = cLiteral( atom )
  	end select

	cAtom = res

end function

'':::::
'' Constant       = ID .                                    !!ambiguity w/ var!!
''
function cConstant( constexpr as integer )
	dim res as integer, s as FBSYMBOL ptr, typ as integer, expr as integer
	dim text as string

	res = FALSE

	s = symbFindByClass( lexTokenSymbol, FB.SYMBCLASS.CONST )
	if( s <> NULL ) then

  		text = symbGetConstText( s )
  		typ = symbGetType( s )

  		if( irGetDataClass( typ ) = IR.DATACLASS.STRING ) then

			s = hAllocStringConst( text, symbGetLen( s ) )
			constexpr = astNewVAR( s, NULL, 0, IR.DATATYPE.FIXSTR )

  		else
  			select case as const typ
  			case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
  				constexpr = astNewCONST64( val64( text ), typ )
  			case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
  				constexpr = astNewCONSTf( val( text ), typ )
  			case else
  				constexpr = astNewCONSTi( valint( text ), typ )
  			end select
  		end if

  		lexSkipToken
  		res = TRUE
  	end if

  	cConstant = res

end function

'':::::
''Literal		  = NUM_LITERAL | STR_LITERAL .
''
function cLiteral( litexpr as integer )
	dim res as integer
	dim tc as FBSYMBOL ptr, p as integer, expr as integer
	dim typ as integer

	cLiteral = FALSE

	select case lexCurrentTokenClass
	case FB.TKCLASS.NUMLITERAL
  		typ = lexTokenType
  		select case as const typ
  		case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
			litexpr = astNewCONST64( val64( lexTokenText ), typ )
  		case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
			litexpr = astNewCONSTf( val( lexTokenText ), typ )
		case else
			litexpr = astNewCONSTi( valint( lexTokenText ), typ )
  		end select

  		lexSkipToken
  		cLiteral = TRUE

  	case FB.TKCLASS.STRLITERAL
		tc = hAllocStringConst( lexTokenText, lexTokenTextLen )
		litexpr = astNewVAR( tc, NULL, 0, IR.DATATYPE.FIXSTR )

		lexSkipToken
        cLiteral = TRUE
  	end select

end function

'':::::
''FuncParam         =   BYVAL? (ID(('(' ')')? | Expression) .
''
function cFuncParam( byval proc as FBSYMBOL ptr, _
					 byval arg as FBSYMBOL ptr, _
					 byval procexpr as integer, _
					 byval optonly as integer ) as integer

	dim paramexpr as integer, amode as integer, pmode as integer
	dim typ as integer

	cFuncParam = FALSE

	amode = symbGetArgMode( proc, arg )

	pmode = INVALID
	paramexpr = INVALID

	if( not optonly ) then
		'' BYVAL?
		if( hMatch( FB.TK.BYVAL ) ) then
			pmode = FB.ARGMODE.BYVAL
		end if

		'' Expression
		if( not cExpression( paramexpr ) ) then
			paramexpr = INVALID
		end if
	end if

	if( paramexpr = INVALID ) then

		'' check if argument is optional
		if( not symbGetArgOptional( proc, arg ) ) then
			if( amode <> FB.ARGMODE.VARARG ) then
				hReportError FB.ERRMSG.ARGCNTMISMATCH
			end if
			exit function
		end if

		'' create an arg
		typ = symbGetType( arg )
		select case as const typ
		case IR.DATATYPE.FIXSTR, IR.DATATYPE.STRING, IR.DATATYPE.CHAR
			paramexpr = astNewVAR( symbGetArgOptvalStr( proc, arg ), NULL, 0, IR.DATATYPE.FIXSTR )

		case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
			paramexpr = astNewCONST64( symbGetArgOptval64( proc, arg ), typ )

		case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
			paramexpr = astNewCONSTf( symbGetArgOptvalF( proc, arg ), typ )

		case else
			paramexpr = astNewCONSTi( symbGetArgOptvalI( proc, arg ), typ )
		end select

	else

		'' '('')'?
		if( amode = FB.ARGMODE.BYDESC ) then
			if( lexCurrentToken = CHAR_LPRNT ) then
				if( lexLookahead(1) = CHAR_RPRNT ) then
					if( pmode <> INVALID ) then
						hReportError FB.ERRMSG.PARAMTYPEMISMATCH
						exit function
					end if
					lexSkipToken
					lexSkipToken
					pmode = FB.ARGMODE.BYDESC
				end if
			end if
    	end if

    end if

	if( pmode <> INVALID ) then
		if( amode <> pmode ) then
            if( amode <> FB.ARGMODE.VARARG ) then
            	'' allow BYVAL param passed to BYREF arg (to pass NULL to pointers and so on)
            	if( pmode <> FB.ARGMODE.BYVAL ) then
					hReportError FB.ERRMSG.PARAMTYPEMISMATCH
					exit function
				end if
			end if
		end if
	end if

    if( astNewPARAM( procexpr, paramexpr, INVALID, pmode ) = INVALID ) then
		hReportError FB.ERRMSG.PARAMTYPEMISMATCH
		exit function
    end if

    cFuncParam = TRUE

end function

'':::::
''FuncParamList     =    FuncParam (DECL_SEPARATOR FuncParam)* .
''
function cFuncParamList( byval proc as FBSYMBOL ptr, _
						 byval procexpr as integer, _
						 byval optonly as integer ) as integer

    dim params as integer, args as integer, arg as FBSYMBOL ptr

	cFuncParamList = FALSE

	args = symbGetProcArgs( proc )

	'' function has no args?
	if( args = 0 ) then
		cFuncParamList = TRUE
		exit function
	end if

	params = 0
	arg = symbGetProcLastArg( proc )
	if( not optonly ) then
		do
			if( params >= args ) then
				if( arg->arg.mode <> FB.ARGMODE.VARARG ) then
					hReportError FB.ERRMSG.ARGCNTMISMATCH
					exit function
				end if
			end if

			if( not cFuncParam( proc, arg, procexpr, optonly ) ) then
				if( hGetLastError <> FB.ERRMSG.OK ) then
					exit function
				else
					exit do
				end if
			end if

			params += 1

			if( params < args ) then
				arg = symbGetProcPrevArg( proc, arg )
			end if

		loop while( hMatch( CHAR_COMMA ) )
	end if

	''
	do while( params < args )
		if( arg->arg.mode = FB.ARGMODE.VARARG ) then
			exit do
		end if

		if( not cFuncParam( proc, arg, procexpr, optonly ) ) then
			exit function
		end if

		params += 1
		arg = symbGetProcPrevArg( proc, arg )
	loop

	cFuncParamList = TRUE

end function

'':::::
function cFunctionCall( byval sym as FBSYMBOL ptr, _
						elm as FBSYMBOL ptr, _
						funcexpr as integer, _
						byval ptrexpr as integer ) as integer

	dim as integer typ, isfuncptr
	dim as FBSYMBOL ptr subtype

	cFunctionCall = FALSE

    if( sym = NULL ) then
    	exit function
    end if

    typ = symbGetType( sym )

    funcexpr = astNewFUNCT( sym, typ, ptrexpr )

	'' is it really a function?
	if( typ = FB.SYMBTYPE.VOID ) then
		hReportError FB.ERRMSG.SYNTAXERROR
		exit function
	end if

	'' '('?
	if( lexCurrentToken = CHAR_LPRNT ) then
		lexSkipToken

		'' ProcParamList
		if( not cFuncParamList( sym, funcexpr, FALSE ) ) then
			exit function
		end if

		'' ')'
		if( not hMatch( CHAR_RPRNT ) ) then
    		hReportError FB.ERRMSG.EXPECTEDRPRNT
    		exit function
		end if

	else
		'' function has no args?
		if( symbGetProcArgs( sym ) <> 0 ) then

			'' ProcParamList (function can have optional args)
			if( not cFuncParamList( sym, funcexpr, TRUE ) ) then
				exit function
			end if

		end if
	end if

	'' if function returns a pointer, check for field deref
	elm = NULL
	if( typ >= FB.SYMBTYPE.POINTER ) then
    	subtype = symbGetSubType( sym )

		isfuncptr = FALSE
   		if( lexCurrentToken = CHAR_LPRNT ) then
   			if( typ = FB.SYMBTYPE.POINTER + FB.SYMBTYPE.FUNCTION ) then
				isfuncptr = TRUE
   			end if
   		end if

		'' FuncPtrOrDerefFields?
		cFuncPtrOrDerefFields( sym, elm, typ, subtype, funcexpr, isfuncptr, TRUE )

		if( hGetLastError <> FB.ERRMSG.OK ) then
			exit function
		end if
	end if

	cFunctionCall = TRUE

end function

'':::::
''Function        =   ID ('(' ProcParamList ')')? .	 			//ambiguity w/ var!!
''
function cFunction( funcexpr as integer, _
					sym as FBSYMBOL ptr, _
					elm as FBSYMBOL ptr )

	cFunction = FALSE

	'' ID
	sym = symbFindByClass( lexTokenSymbol, FB.SYMBCLASS.PROC )
	if( sym = NULL ) then
		exit function
	end if

	lexSkipToken

	cFunction = cFunctionCall( sym, elm, funcexpr, INVALID )

end function
