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

        if( logexpr = NULL ) then
			hReportError FB.ERRMSG.TYPEMISMATCH
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

    	if( relexpr = NULL ) Then
    		hReportError FB.ERRMSG.TYPEMISMATCH
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

    	if( addexpr = NULL ) Then
    		hReportError FB.ERRMSG.TYPEMISMATCH
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

    	if( shiftexpr = NULL ) Then
    		hReportError FB.ERRMSG.TYPEMISMATCH
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

    	if( modexpr = NULL ) Then
    		hReportError FB.ERRMSG.TYPEMISMATCH
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
    		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
    		exit function
    	end if

    	'' do operation
    	idivexpr = astNewBOP( IR.OP.INTDIV, idivexpr, mulexpr )

    	if( idivexpr = NULL ) Then
    		hReportError FB.ERRMSG.TYPEMISMATCH
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

    	if( mulexpr = NULL ) Then
    		hReportError FB.ERRMSG.TYPEMISMATCH
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
    		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
    		exit do
    	end if

    	'' do operation
    	expexpr = astNewBOP( IR.OP.POW, expexpr, negexpr )

    	if( expexpr = NULL ) Then
    		hReportError FB.ERRMSG.TYPEMISMATCH
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

		negexpr = astNewUOP( IR.OP.NEG, negexpr )

    	if( negexpr = NULL ) Then
    		hReportError FB.ERRMSG.TYPEMISMATCH
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
    	if( astGetDataClass( negexpr ) >= IR.DATACLASS.STRING ) then
    		hReportError( FB.ERRMSG.TYPEMISMATCH )
    		exit function
    	end if

    	return TRUE

	'' NOT
	case FB.TK.NOT
		lexSkipToken
		'' RelExpression
		if( not cRelExpression( negexpr ) ) then
			exit function
		end if

		negexpr = astNewUOP( IR.OP.NOT, negexpr )

    	if( negexpr = NULL ) Then
    		hReportError FB.ERRMSG.TYPEMISMATCH
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
	case FB.TK.ADDROFCHAR
		return cAddrOfExpression( highexpr, sym, elm )

	'' DerefExpr
	case FB.TK.DEREFCHAR
		return cDerefExpression( highexpr )

	'' ParentExpression
	case CHAR_LPRNT
		return cParentExpression( highexpr )

	case else

		select case as const lexCurrentToken
		'' AddrOfExpression
		case FB.TK.VARPTR, FB.TK.PROCPTR, FB.TK.SADD, FB.TK.STRPTR
			return cAddrOfExpression( highexpr, sym, elm )

		'' TypeConvExpr
		case FB.TK.CBYTE, FB.TK.CSHORT, FB.TK.CINT, FB.TK.CLNG, FB.TK.CLNGINT, _
			 FB.TK.CUBYTE, FB.TK.CUSHORT, FB.TK.CUINT, FB.TK.CULNGINT, _
			 FB.TK.CSNG, FB.TK.CDBL, _
         	 FB.TK.CSIGN, FB.TK.CUNSG
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

	tconvexpr = astNewCONV( op, totype, NULL, tconvexpr )

    if( tconvexpr = NULL ) Then
    	hReportError FB.ERRMSG.TYPEMISMATCH, TRUE
    	exit function
    end if

	if( not hMatch( CHAR_RPRNT ) ) then
		hReportError FB.ERRMSG.EXPECTEDRPRNT
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
		if( dtype < IR.DATATYPE.POINTER ) then
			hReportError FB.ERRMSG.EXPECTEDPOINTER, TRUE
			exit function
		end if

		dtype -= IR.DATATYPE.POINTER

		'' incomplete type?
		if( (dtype = FB.SYMBTYPE.VOID) or (dtype = FB.SYMBTYPE.FWDREF) ) then
			hReportError FB.ERRMSG.INCOMPLETETYPE, TRUE
			exit function
		end if

		expr = astNewPTR( NULL, NULL, 0, expr, dtype, NULL )
		cnt -= 1
	loop

	'' not a pointer?
	if( dtype < IR.DATATYPE.POINTER ) then
		hReportError FB.ERRMSG.EXPECTEDPOINTER, TRUE
		exit function
	end if

    dtype -= FB.SYMBTYPE.POINTER

	'' incomplete type?
	if( (dtype = FB.SYMBTYPE.VOID) or (dtype = FB.SYMBTYPE.FWDREF) ) then
		hReportError FB.ERRMSG.INCOMPLETETYPE, TRUE
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
			dtype   = IR.DATATYPE.POINTER + symbGetType( elm )
			subtype = symbGetSubtype( elm )
		else
			dtype   = IR.DATATYPE.POINTER + symbGetType( sym )
			subtype = symbGetSubtype( sym )
		end if

	else
		'' Variable
  		if( not cVariable( derefexpr, sym, elm ) ) then
			hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
		    exit function
		end if

  		dtype   = astGetDataType( derefexpr )
		subtype = astGetSubType( derefexpr )
  	end if


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
			expr = astNewCONV( INVALID, IR.DATATYPE.INTEGER, NULL, expr )
			if( expr = NULL ) then
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
	if( cDerefFields( sym, elm, dtype, subtype, derefexpr, TRUE, FALSE ) ) then
		derefcnt -= 1
	else
		if( hGetLastError <> FB.ERRMSG.OK ) then
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
	if( lexCurrentToken <> FB.TK.DEREFCHAR ) then
		exit function
	end if

	'' DREF+
    derefcnt = 0
	do
		lexSkipToken( )
		derefcnt += 1
	loop while( lexCurrentToken( ) = FB.TK.DEREFCHAR )

	'' AddrOfExpression
	if(  cAddrOfExpression( derefexpr, sym, elm ) ) then

		if( elm <> NULL ) then
			dtype   = IR.DATATYPE.POINTER + symbGetType( elm )
			subtype = symbGetSubtype( elm )
		else
			dtype   = IR.DATATYPE.POINTER + symbGetType( sym )
			subtype = symbGetSubtype( sym )
		end if

	else

  		sym = NULL
  		elm = NULL

        '' ParentDeref
  		if( not cParentDeref( derefexpr, sym, elm, derefcnt, dtype, subtype ) ) then

			if( hGetLastError <> FB.ERRMSG.OK ) then
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
			hReportError FB.ERRMSG.EXPECTEDRPRNT
			exit function
		end if
	end if

	expr = astNewVAR( proc, NULL, 0, IR.DATATYPE.UINT )
	addrofexpr = astNewADDR( IR.OP.ADDROF, expr, proc )

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

	addrofexpr = astNewADDR( IR.OP.ADDROF, addrofexpr, sym, elm )

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

		return TRUE
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

		return TRUE

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

		return TRUE

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
		end if
		sym = astGetSymbol( expr )

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
  			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
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
  				hReportError FB.ERRMSG.EXPECTEDRPRNT
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
  	case FB.TKCLASS.KEYWORD
  		return cQuirkFunction( atom )

  	case FB.TKCLASS.IDENTIFIER
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
	static as zstring * FB.MAXLITLEN+1 text
	dim as FBSYMBOL ptr s
	dim as integer typ

	function = FALSE

	s = symbFindByClass( lexTokenSymbol( ), FB.SYMBCLASS.CONST )
	if( s <> NULL ) then

  		text = symbGetConstText( s )
  		typ = symbGetType( s )

  		if( irGetDataClass( typ ) = IR.DATACLASS.STRING ) then

			s = hAllocStringConst( text, symbGetLen( s ) )
			constexpr = astNewVAR( s, NULL, 0, IR.DATATYPE.FIXSTR )

  		else
  			select case as const typ
  			case IR.DATATYPE.ENUM
  				constexpr = astNewENUM( valint( text ), symbGetSubType( s ) )
  			case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
  				constexpr = astNewCONST64( val64( text ), typ )
  			case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
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
	case FB.TKCLASS.NUMLITERAL
  		typ = lexTokenType( )
  		select case as const typ
  		case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
			litexpr = astNewCONST64( val64( *lexTokenText( ) ), typ )
  		case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
			litexpr = astNewCONSTf( val( *lexTokenText( ) ), typ )
		case else
			litexpr = astNewCONSTi( valint( *lexTokenText( ) ), typ )
  		end select

  		lexSkipToken( )
  		function = TRUE

  	case FB.TKCLASS.STRLITERAL
		tc = hAllocStringConst( *lexTokenText( ), lexTokenTextLen( ) )
		litexpr = astNewVAR( tc, NULL, 0, IR.DATATYPE.FIXSTR )

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
	if( typ = FB.SYMBTYPE.VOID ) then
		hReportError FB.ERRMSG.SYNTAXERROR
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
    		hReportError FB.ERRMSG.EXPECTEDRPRNT
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
	sym = symbFindByClass( lexTokenSymbol, FB.SYMBCLASS.PROC )
	if( sym = NULL ) then
		exit function
	end if

	lexSkipToken( )

	function = cFunctionCall( sym, elm, funcexpr, NULL )

end function
