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
'$include: 'inc\fb.bi'
'$include: 'inc\fbint.bi'
'$include: 'inc\parser.bi'
'$include: 'inc\ast.bi'
'$include: 'inc\ir.bi'
'$include: 'inc\emit.bi'

'':::::
''Expression      =   LogExpression .
''
function cExpression( expr as integer )

	cExpression = cLogExpression( expr )

end function

'':::::
''LogExpression      =   NOT? RelExpression ( (AND | OR | XOR | EQV | IMP) NOT? RelExpression )* .
''
function cLogExpression( logexpr as integer )
    dim donot as integer, op as integer, relexpr as integer

	cLogExpression = FALSE

    '' NOT?
    donot = FALSE
    if( hMatch( FB.TK.NOT ) ) then
    	donot = TRUE
    end if

    '' RelExpression
    if( not cRelExpression( logexpr ) ) then
	   	exit function
    end if

    '' exec not
    if( donot ) then
    	logexpr = astNewUOP( IR.OP.NOT, logexpr )

       	if( logexpr = INVALID ) then
			hReportError FB.ERRMSG.TYPEMISMATCH
           	exit function
       	end if
    end if

    '' ( ... )*
    do
    	'' Logical operator
    	op = lexCurrentToken
    	select case op
    	case FB.TK.AND, FB.TK.OR, FB.TK.XOR, FB.TK.EQV, FB.TK.IMP
 			lexSkipToken
    	case else
      		exit do
    	end select

    	'' NOT?
    	donot = FALSE
    	if( hMatch( FB.TK.NOT ) ) then
    		donot = TRUE
    	end if

    	'' RelExpression
    	if( not cRelExpression( relexpr ) ) then
    		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
    		exit function
    	end if

    	'' exec not
    	if( donot ) then
    		relexpr = astNewUOP( IR.OP.NOT, relexpr )

        	if( relexpr = INVALID ) then
				hReportError FB.ERRMSG.TYPEMISMATCH
            	exit function
        	end if
    	end if

    	'' do operation
    	select case op
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
   	relexpr = INVALID
   	if( not cAddExpression( relexpr ) ) then
   		exit function
   	end if

    '' ( ... )*
    do
    	'' Relational operator
    	op = lexCurrentToken
    	select case op
    	case FB.TK.EQ, FB.TK.GT, FB.TK.LT, FB.TK.NE, FB.TK.LE, FB.TK.GE
 			lexSkipToken
    	case else
      		exit do
    	end select

    	'' AddExpression
    	addexpr = INVALID
    	if( not cAddExpression( addexpr ) ) then
    		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
    		exit function
    	end if

   		'' do operation
   		select case op
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

    if( addexpr = INVALID ) then
    	'' ShiftExpression
    	if( not cShiftExpression( addexpr ) ) then
    		exit function
    	end if
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
''ExpExpression   =   NegExpression ( '^' NegExpression )* .
''
function cExpExpression( expexpr as integer )
	dim negexpr as integer

    cExpExpression = FALSE

   	'' NegExpression
   	if( not cNegExpression( expexpr ) ) then
   		exit function
   	end if

    '' ( '^' NegExpression )*
    do
    	if( lexCurrentToken <> CHAR_CART ) then
    		exit do
    	else
    		lexSkipToken
    	end if

    	'' NegExpression
    	if( not cNegExpression( negexpr ) ) then
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
''NegExpression   =   ('-'|'+') ExpExpression
''				  |   HighestPresExpr .
''
function cNegExpression( negexpr as integer )
    dim res as integer

	cNegExpression = FALSE

	select case lexCurrentToken
	'' '-'
	case CHAR_MINUS
		lexSkipToken
		if( not cExpExpression( negexpr ) ) then
			exit function
		end if

		negexpr = astNewUOP( IR.OP.NEG, negexpr )

    	if( negexpr = INVALID ) Then
    		hReportError FB.ERRMSG.TYPEMISMATCH
    		exit function
    	end if

		cNegExpression = TRUE
		exit function

	'' '+'
	case CHAR_PLUS
		lexSkipToken

		cNegExpression = cExpExpression( negexpr )
		exit function

	end select

	cNegExpression = cHighestPresExpr( negexpr )

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
    dim symb as FBSYMBOL ptr, elm as FBSYMBOL ptr

	select case lexCurrentToken
	'' AddrOfExpression
	case FB.TK.VARPTR, FB.TK.PROCPTR, FB.TK.ADDROFCHAR, FB.TK.SADD, FB.TK.STRPTR
		res = cAddrOfExpression( highexpr, symb, elm )

	'' DerefExpr
	case FB.TK.DEREFCHAR
		res = cDerefExpression( highexpr )

	'' TypeConvExpr
	case FB.TK.CBYTE, FB.TK.CSHORT, FB.TK.CINT, FB.TK.CLNG, FB.TK.CSNG, FB.TK.CDBL, _
         FB.TK.CSIGN, FB.TK.CUNSG
		res = cTypeConvExpr( highexpr )

	'' ParentExpression
	case CHAR_LPRNT
		res = cParentExpression( highexpr )

	'' Atom
	case else
		res = cAtom( highexpr )

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

	select case lexCurrentToken
	case FB.TK.CBYTE
		totype = IR.DATATYPE.BYTE
	case FB.TK.CSHORT
		totype = IR.DATATYPE.SHORT
	case FB.TK.CINT, FB.TK.CLNG
		totype = IR.DATATYPE.INTEGER
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
					       byval symb as FBSYMBOL ptr, byval elm as FBSYMBOL ptr, _
					       byval dtype as integer ) as integer

	hDoDeref = FALSE

	if( (expr = INVALID) or (cnt <= 0) ) then
		exit function
	end if

	do while( cnt > 1 )
		'' not a pointer?
		if( dtype < IR.DATATYPE.POINTER ) then
			exit function
		end if
		dtype = dtype - IR.DATATYPE.POINTER

		expr = astNewPTR( 0, dtype, expr )
		cnt = cnt - 1
	loop

	'' not a pointer?
	if( dtype < IR.DATATYPE.POINTER ) then
		exit function
	end if
    dtype = dtype - FB.SYMBTYPE.POINTER

    ''
    expr = astNewPTREx( symb, elm, 0, dtype, expr )

    hDoDeref = TRUE

end function

'':::::
''ParentDeref	= 	'(' (AddrOfExpression|Variable) ('+'|'-' Expression)? ')')
''
function cParentDeref( derefexpr as integer, symbol as FBSYMBOL ptr, elm as FBSYMBOL ptr, _
					   derefcnt as integer )

    dim s as FBSYMBOL ptr, subtype as FBSYMBOL ptr
    dim lgt as integer, dtype as integer
    dim op as integer, expr as integer

	cParentDeref = FALSE

	'' '('
	if( not hMatch( CHAR_LPRNT ) ) then
		hReportError FB.ERRMSG.EXPECTEDLPRNT
		exit function
	end if

  	'' AddrOfExpression
	if( cAddrOfExpression( derefexpr, symbol, elm ) ) then
		if( elm <> NULL ) then
			s = elm
		else
			s = symbol
		end if

		dtype = symbGetType( s )

	else
		'' Variable
  		if( not cVariable( derefexpr ) ) then
			hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
		    exit function
		end if

		symbol = astGetSymbol( derefexpr )
		elm    = astGetUDTElm( derefexpr )

		if( elm <> NULL ) then
			s = elm
		else
			s = symbol
		end if

  		dtype = symbGetType( s ) - FB.SYMBTYPE.POINTER
  	end if

	subtype = symbGetSubType( s )

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
		astUpdNodeResult( expr )
		if( (astGetDataClass( expr ) <> IR.DATACLASS.INTEGER) or _
			(astGetDataSize( expr ) <> FB.POINTERSIZE) ) then
			expr = astNewCONV( INVALID, IR.DATATYPE.INTEGER, expr )
		end if

		'' times length
		lgt = symbCalcLen( dtype, subtype )

		expr = astNewBOP( IR.OP.MUL, expr, astNewCONST( lgt, IR.DATATYPE.INTEGER ) )

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
	if( not cDerefFields( symbol, elm, subtype, dtype + FB.SYMBTYPE.POINTER, derefexpr, TRUE, FALSE ) ) then
		if( hGetLastError <> FB.ERRMSG.OK ) then
			exit function
		end if
	else
		derefcnt = derefcnt - 1
	end if

	cParentDeref = TRUE

end function

'':::::
''DerefExpression	= 	DREF+ (AddrOfExpression
''							  | Function
''							  | Variable
''							  | ParentDeref) .
''
function cDerefExpression( derefexpr as integer ) as integer
    dim symbol as FBSYMBOL ptr, elm as FBSYMBOL ptr
    dim derefcnt as integer

	cDerefExpression = FALSE

	'' DREF?
	if( lexCurrentToken <> FB.TK.DEREFCHAR ) then
		exit function
	end if

	'' DREF+
    derefcnt = 0
	do
		lexSkipToken
		derefcnt = derefcnt + 1
	loop while( lexCurrentToken = FB.TK.DEREFCHAR )

	'' AddrOfExpression
	if( not cAddrOfExpression( derefexpr, symbol, elm ) ) then

  		'' Function
  		if( cFunction( derefexpr ) ) then
			symbol = astGetSymbol( derefexpr )
			elm    = NULL

  		else

  			'' Variable
  			if( cVariable( derefexpr ) ) then
				symbol = astGetSymbol( derefexpr )
				elm    = astGetUDTElm( derefexpr )

  			else

                '' ParentDeref
  				if( not cParentDeref( derefexpr, symbol, elm, derefcnt ) ) then
  					exit function
  				end if

		    end if
		end if
	end if

	''
	if( derefcnt > 0 ) then
		if( not hDoDeref( derefcnt, derefexpr, symbol, elm, astGetDataType( derefexpr ) ) ) then
			hReportError FB.ERRMSG.EXPECTEDPOINTER, TRUE
			exit function
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

	expr = astNewVAR( proc, 0, IR.DATATYPE.UINT )
	addrofexpr = astNewADDR( IR.OP.ADDROF, expr )

	hProcPtrBody = TRUE

end function

'':::::
private function hVarPtrBody( addrofexpr as integer, symbol as FBSYMBOL ptr, elm as FBSYMBOL ptr ) as integer

	hVarPtrBody = FALSE

	if( not cVariable( addrofexpr ) ) then
		exit function
	end if

	symbol = astGetSymbol( addrofexpr )
	elm	   = astGetUDTElm( addrofexpr )

	addrofexpr = astNewADDR( IR.OP.ADDROF, addrofexpr )

    hVarPtrBody = TRUE

end function

'':::::
''AddrOfExpression  =   VARPTR '(' Variable ')'
''					|   PROCPTR '(' Proc ('('')')? ')'
'' 					| 	'@' (Proc ('('')')? | Variable)
''					|   SADD|STRPTR '(' Variable{str}|Const{str}|Literal{str} ')' .
''
function cAddrOfExpression( addrofexpr as integer, symbol as FBSYMBOL ptr, elm as FBSYMBOL ptr )
    dim expr as integer, dtype as integer, proc as FBSYMBOL ptr

	cAddrOfExpression = FALSE

	select case lexCurrentToken
	'' VARPTR '(' Variable ')'
	case FB.TK.VARPTR
		lexSkipToken

		if( not hMatch( CHAR_LPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDLPRNT
			exit function
		end if

		if( not hVarPtrBody( addrofexpr, symbol, elm ) ) then
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

		proc = symbLookupProc( lexTokenText )
		if( proc = NULL ) then
			hReportError FB.ERRMSG.UNDEFINEDSYMBOL
			exit function
		else
			lexSkipToken
		end if

		if( not hProcPtrBody( proc, addrofexpr ) ) then
			exit function
		end if

		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDRPRNT
			exit function
		end if
		symbol = proc
		elm	   = NULL

		cAddrOfExpression = TRUE
        exit function

	'' '@' (Proc ('('')')? | Variable)
	case FB.TK.ADDROFCHAR
		lexSkipToken

		proc = symbLookupProc( lexTokenText )
		if( proc <> NULL ) then
			lexSkipToken

			if( not hProcPtrBody( proc, addrofexpr ) ) then
				exit function
			end if
			symbol = proc
			elm	   = NULL

		else
			if( not hVarPtrBody( addrofexpr, symbol, elm ) ) then
				exit function
			end if
		end if

		cAddrOfExpression = TRUE
        exit function

	'' SADD|STRPTR '(' Variable{str} ')'
	case FB.TK.SADD, FB.TK.STRPTR
		lexSkipToken

		if( not hMatch( CHAR_LPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDLPRNT
			exit function
		end if

		if( not cVariable( expr ) ) then
			if( not cConstant( expr ) ) then
				if( not cLiteral( expr ) ) then
					exit function
				end if
			end if
		end if

		dtype = astGetDataType( expr )
		if( not hIsString( dtype ) ) then
			hReportError FB.ERRMSG.INVALIDDATATYPES
			exit function
		end if

		symbol = astGetSymbol( addrofexpr )
		elm	   = astGetUDTElm( addrofexpr )

		if( hIsStrFixed( dtype ) ) then
			addrofexpr = astNewADDR( IR.OP.ADDROF, expr )
		else
			addrofexpr = astNewADDR( IR.OP.DEREF, expr )
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
    dim res as integer

  	atom = INVALID

  	if( lexCurrentTokenClass = FB.TKCLASS.KEYWORD ) then
  		res = cQuirkFunction( atom )

  	elseif( lexCurrentToken = FB.TK.ID ) then
  		res = cConstant( atom )
  		if( not res ) then
  			res = cFunction( atom )
  			if( not res ) then
  				res = cVariable( atom )
  			end if
  		end if

  	else
  		res = cLiteral( atom )
  	end if

	cAtom = res

end function

'':::::
'' Constant       = ID .                                    !!ambiguity w/ var!!
''
function cConstant( constexpr as integer )
	dim res as integer, c as FBSYMBOL ptr, typ as integer, expr as integer
	dim text as string

	res = FALSE

	if( lexCurrentToken = FB.TK.ID ) then
		typ = lexTokenType

		c = symbLookupConst( lexTokenText, typ )
		if( c <> NULL ) then

  			text = symbGetConstText( c )
  			typ = symbGetType( c )

  			if( irGetDataClass( typ ) = IR.DATACLASS.STRING ) then

				c = hAllocStringConst( text, symbGetLen( c ) )
				constexpr = astNewVAR( c, 0, IR.DATATYPE.FIXSTR )

  			else
  				constexpr = astNewCONST( val( text ), typ )
  			end if

  			lexSkipToken
  			res = TRUE
  		end if
  	end if

  	cConstant = res

end function

'':::::
''Literal		  = NUM_LITERAL | STR_LITERAL .
''
function cLiteral( litexpr as integer )
	dim res as integer
	dim tc as FBSYMBOL ptr, p as integer, expr as integer

	cLiteral = FALSE

	select case lexCurrentTokenClass
	case FB.TKCLASS.NUMLITERAL
  		litexpr = astNewCONST( val( lexTokenText ), lexTokenType )

  		lexSkipToken
  		cLiteral = TRUE

  	case FB.TKCLASS.STRLITERAL
		tc = hAllocStringConst( lexTokenText, lexTokenTextLen )
		litexpr = astNewVAR( tc, 0, IR.DATATYPE.FIXSTR )

		lexSkipToken
        cLiteral = TRUE
  	end select

end function

'':::::
''FuncParam         =   BYVAL? (ID(('(' ')')? | Expression) .
''
function cFuncParam( byval proc as FBSYMBOL ptr, byval arg as FBPROCARG ptr, byval procexpr as integer, _
					 byval optonly as integer ) as integer
	dim paramexpr as integer, amode as integer, pmode as integer
	dim dtype as integer

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
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if

		'' create an arg
		paramexpr = astNewCONST( symbGetArgDefvalue( proc, arg ), _
								 symbGetArgType( proc, arg ) )

	else

		'' '('')'?
		if( amode = FB.ARGMODE.BYDESC ) then
			if( lexCurrentToken = CHAR_LPRNT ) then
				if( lexLookahead(1) = CHAR_RPRNT ) then
					lexSkipToken
					lexSkipToken
					pmode = FB.ARGMODE.BYDESC
				end if
			end if
    	end if

    end if

	if( pmode <> INVALID ) then
		if( amode <> pmode ) then
            '' allow BYVAL param passed to BYREF arg (to pass NULL to pointers and so on)
            if( (amode <> FB.ARGMODE.BYREF) or (pmode <> FB.ARGMODE.BYVAL) ) then
				hReportError FB.ERRMSG.PARAMTYPEMISMATCH
				exit function
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
function cFuncParamList( byval proc as FBSYMBOL ptr, byval procexpr as integer, byval optonly as integer ) as integer
    dim param as integer, args as integer, arg as FBPROCARG ptr

	cFuncParamList = FALSE

	args = symbGetProcArgs( proc )

	'' function has no args?
	if( args = 0 ) then
		cFuncParamList = TRUE
		exit function
	end if

	param = 0
	arg = symbGetProcLastArg( proc )
	if( not optonly ) then
		do
			if( param >= args ) then
				hReportError FB.ERRMSG.ARGCNTMISMATCH
				exit function
			end if

			if( not cFuncParam( proc, arg, procexpr, optonly ) ) then
				exit function
			end if

			param = param + 1
			arg = symbGetProcPrevArg( proc, arg )

		loop while( hMatch( CHAR_COMMA ) )
	end if

	''
	if( param < args ) then

		do while( param < args )

			if( not cFuncParam( proc, arg, procexpr, optonly ) ) then
				exit function
			end if

			param = param + 1
			arg = symbGetProcPrevArg( proc, arg )
		loop

	end if

	cFuncParamList = TRUE

end function

'':::::
function cFunctionCall( byval proc as FBSYMBOL ptr, funcexpr as integer, byval ptrexpr as integer ) as integer
	dim res as integer, typ as integer

	cFunctionCall = FALSE

    if( proc = NULL ) then
    	exit function
    end if

    typ = symbGetType( proc )
    if( ptrexpr = INVALID ) then
    	funcexpr = astNewFUNCT( proc, typ, symbGetProcArgs( proc ) )
    else
    	funcexpr = astNewFUNCTPTR( ptrexpr, proc, typ, symbGetProcArgs( proc ) )
    end if

	'' is it really a function?
	if( typ = FB.SYMBTYPE.VOID ) then
		hReportError FB.ERRMSG.SYNTAXERROR
		exit function
	end if

	'' '('?
	if( lexCurrentToken = CHAR_LPRNT ) then
		lexSkipToken

		'' ProcParamList
		if( not cFuncParamList( proc, funcexpr, FALSE ) ) then
			exit function
		end if

		'' ')'
		if( not hMatch( CHAR_RPRNT ) ) then
    		hReportError FB.ERRMSG.EXPECTEDRPRNT
    		exit function
		end if

	else
		'' function has no args?
		if( symbGetProcArgs( proc ) <> 0 ) then

			'' ProcParamList (function can have optional args)
			if( not cFuncParamList( proc, funcexpr, TRUE ) ) then
				exit function
			end if

		end if
	end if

	cFunctionCall = TRUE

end function

'':::::
''Function        =   ID ('(' ProcParamList ')')? .	 			//ambiguity w/ var!!
''
function cFunction( funcexpr as integer )
	dim id as string, f as FBSYMBOL ptr

	cFunction = FALSE

	'' ID
	if( lexCurrentToken <> FB.TK.ID ) then
		exit function
	end if

	id = lexTokenText

	f = symbLookupProc( id )

	if( f = NULL ) then
		exit function
	else
		lexSkipToken
	end if

	cFunction = cFunctionCall( f, funcexpr, INVALID )

end function
