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


'' parser part 4 - compound statements (FOR, DO, WHILE, IF and SELECT)
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

defint a-z
'$include: 'inc\fb.bi'
'$include: 'inc\fbint.bi'
'$include: 'inc\parser.bi'
'$include: 'inc\rtl.bi'
'$include: 'inc\ast.bi'
'$include: 'inc\ir.bi'
'$include: 'inc\emit.bi'

type FBSELECTCTX
	base		as integer
end type

type FBSWITCHCTX
	base		as integer
end type

type FBCASECTX
	typ 		as integer
	op 			as integer
	expr1		as integer
	expr2		as integer
end type

type FBSWTCASECTX
	label		as FBSYMBOL ptr
	value		as uinteger
end type

const FB.CASETYPE.RANGE = 1
const FB.CASETYPE.IS    = 2
const FB.CASETYPE.ELSE  = 3

const FB.MAXCASEEXPR 	= 1024
const FB.MAXSWTCASEEXPR = 8192

const FB.MAXSWTCASERANGE= 4096

'' globals
	dim shared selctx as FBSELECTCTX
	dim shared swtctx as FBSWITCHCTX
	dim shared caseTB(0 to FB.MAXCASEEXPR-1) as FBCASECTX
	dim shared swtcaseTB(0 to FB.MAXSWTCASEEXPR-1) as FBSWTCASECTX


'':::::
sub parser4Init

	selctx.base 	= 0

	swtctx.base 	= 0

end sub

'':::::
sub parser4End


end sub


'':::::
''CompoundStmt	  =   IfStatement
''				  |   ForStatement
''	              |   DoStatement
''				  |   WhileStatement
''				  |   SelectStatement
''				  |   ExitStatement
''				  |   ContinueStatement
''				  |   EndStatement
''
function cCompoundStmt
    dim res as integer

    env.compoundcnt = env.compoundcnt + 1

	res = FALSE

	select case as const lexCurrentToken
	case FB.TK.IF
		res = cIfStatement
	case FB.TK.FOR
		res = cForStatement
	case FB.TK.DO
		res = cDoStatement
	case FB.TK.WHILE
		res = cWhileStatement
	case FB.TK.ELSE, FB.TK.ELSEIF, FB.TK.CASE, FB.TK.LOOP, FB.TK.NEXT, FB.TK.WEND
		res = cCompoundStmtElm
	case FB.TK.SELECT
		res = cSelectStatement
	case FB.TK.EXIT
		res = cExitStatement
	case FB.TK.CONTINUE
		res = cContinueStatement
	case FB.TK.END
		res = cEndStatement
	case FB.TK.WITH
		res = cWithStatement
	end select

	env.compoundcnt = env.compoundcnt - 1

	cCompoundStmt = res

end function

'':::::
''SingleIfStatement=  !(COMMENT|NEWLINE) NUM_LIT | SimpleStatement*)
''                    (ELSE SimpleStatement*)?
''
function cSingleIfStatement( byval expr as integer )
	dim vr as integer
	dim el as FBSYMBOL ptr, nl as FBSYMBOL ptr, l as FBSYMBOL ptr
	dim lastcompstmt as integer

	cSingleIfStatement = FALSE

	'' !COMMENT|NEWLINE
	select case lexCurrentToken
	case FB.TK.COMMENTCHAR, FB.TK.REM, FB.TK.EOL
		exit function
	end select

	'' add end and next label (at ELSE/ELSEIF)
	nl = symbAddLabel( hMakeTmpStr )
	el = symbAddLabel( hMakeTmpStr )

	''
	lastcompstmt = env.lastcompound
	env.lastcompound = FB.TK.IF

	'' branch
	astUpdNodeResult expr
	astUpdComp2Branch expr, nl, FALSE
	astFlush expr, vr

	'' NUM_LIT | SimpleStatement*
	if( lexCurrentTokenClass = FB.TKCLASS.NUMLITERAL ) then
		l = symbLookupLabel( lexTokenText )
		if( l = NULL ) then
			l = symbAddLabelEx( lexTokenText, FALSE )
		end if
		lexSkipToken

		astFlush astNewBRANCH( IR.OP.JMP, l ), vr

	elseif( not cSimpleStatement ) then
		if( hGetLastError <> FB.ERRMSG.OK ) then
			exit function
		end if
	end if

	'' (ELSE SimpleStatement*)?
	if( hMatch( FB.TK.ELSE ) ) then

		'' exit if stmt
		astFlush astNewBRANCH( IR.OP.JMP, el ), vr

		'' emit next label
		irEmitLABEL nl, FALSE

		'' SimpleStatement|IF*
		if( not cSimpleStatement ) then
			exit function
		end if

		'' emit end label
		irEmitLABEL el, FALSE

	else
		'' emit next label
		irEmitLABEL nl, FALSE
	end if

	''
	env.lastcompound = lastcompstmt

	''
	'''''symbDelLabel el
	'''''symbDelLabel nl

	cSingleIfStatement = TRUE

end function

'':::::
function cIfStmtBody( byval expr as integer, byval nl as FBSYMBOL ptr, byval el as FBSYMBOL ptr, _
					  byval checkstmtsep as integer = TRUE ) as integer
	dim vr as integer
	dim res as integer

	cIfStmtBody = FALSE

	'' branch
	astUpdNodeResult expr
	astUpdComp2Branch expr, nl, FALSE
	astFlush expr, vr

	if( checkstmtsep ) then
		'' Comment?
		res = cComment

		'' separator
		if( not cSttSeparator ) then
			hReportError FB.ERRMSG.EXPECTEDEOL
			exit function
		end if
	end if

	'' loop body
	do
		res = cSimpleLine
	loop while( (res) and (lexCurrentToken <> FB.TK.EOF) )

	if( hGetLastError = FB.ERRMSG.OK ) then
		cIfStmtBody = TRUE
	end if

end function

'':::::
''BlockIfStatement=   (COMMENT|NEWLINE)
''					  SimpleLine*
''					  (ELSEIF Expression THEN Comment? SttSeparator
''					   SimpleLine*)?
''                    (ELSE Comment? SttSeparator
''					   SimpleLine*)?
''					  END IF.
''
function cBlockIfStatement( byval expr as integer )
	dim el as FBSYMBOL ptr, nl as FBSYMBOL ptr
	dim lastcompstmt as integer
	dim vr as integer

	cBlockIfStatement = FALSE

	'' COMMENT|NEWLINE
	select case lexCurrentToken
	case FB.TK.COMMENTCHAR, FB.TK.REM, FB.TK.EOL
	case else
		exit function
	end select

	'' add end label (at ENDIF)
	el = symbAddLabel( hMakeTmpStr )

	'' add next label (at ELSE/ELSEIF)
	nl = symbAddLabel( hMakeTmpStr )

	''
	lastcompstmt = env.lastcompound
	env.lastcompound = FB.TK.IF

	if( not cIfStmtBody( expr, nl, el ) ) then
		exit function
	end if

	'' (ELSEIF Expression THEN SimpleLine*)?
    do while( hMatch( FB.TK.ELSEIF ) )

		'' exit last if stmt
		astFlush astNewBRANCH( IR.OP.JMP, el ), vr

		'' emit next label
		irEmitLABEL nl, FALSE
		'''''symbDelLabel nl

		'' add next label (at ELSE/ELSEIF)
		nl = symbAddLabel( hMakeTmpStr )

	    '' Expression
    	if( not cExpression( expr ) ) then
    		exit function
    	end if

		'' THEN
		if( not hMatch( FB.TK.THEN ) ) then
			hReportError FB.ERRMSG.EXPECTEDTHEN
			exit function
		end if

		if( not cIfStmtBody( expr, nl, el, FALSE ) ) then
			exit function
		end if

    loop

	'' (ELSE SimpleLine*)?
	if( hMatch( FB.TK.ELSE ) ) then

		'' exit last if stmt
		astFlush astNewBRANCH( IR.OP.JMP, el ), vr

		'' emit next label
		irEmitLABEL nl, FALSE
		'''''symbDelLabel nl

		'' loop body
		do
		loop while( (cSimpleLine) and (lexCurrentToken <> FB.TK.EOF) )

	else
		'' emit next label
		irEmitLABEL nl, FALSE
	end if

	'' emit end label
	irEmitLABEL el, FALSE
	'''''symbDelLabel el

	'' END IF
	if( (not hMatch( FB.TK.END )) or (not hMatch( FB.TK.IF )) ) then
		hReportError FB.ERRMSG.EXPECTEDENDIF
		exit function
	end if

	''
	env.lastcompound = lastcompstmt

	cBlockIfStatement = TRUE

end function

'':::::
''IfStatement	  =   IF Expression THEN (BlockIfStatement | SingleIfStatement) .
''
function cIfStatement
	dim expr as integer

	cIfStatement = FALSE

	'' IF
	lexSkipToken

    '' Expression
    if( not cExpression( expr ) ) then
    	exit function
    end if

	'' THEN
	if( hMatch( FB.TK.THEN ) ) then

		'' (BlockIfStatement | SingleIfStatement)
		if( not cBlockIfStatement( expr ) ) then
			if( hGetLastError = FB.ERRMSG.OK ) then
				if( not cSingleIfStatement( expr ) ) then
					hReportError FB.ERRMSG.SYNTAXERROR
					exit function
				end if
			end if
		end if

	else

		'' GOTO
		if( lexCurrentToken <> FB.TK.GOTO ) then
			hReportError FB.ERRMSG.EXPECTEDTHEN
			exit function
		end if

		if( not cSingleIfStatement( expr ) ) then
			hReportError FB.ERRMSG.SYNTAXERROR
			exit function
		end if

	end if


	cIfStatement = TRUE

end function

'':::::
private function cStoreTemp( byval expr as integer, byval dtype as integer, byval dclass as integer, _
					 byval typ as integer, isvar as integer ) as FBSYMBOL ptr static
    dim s as FBSYMBOL ptr
    dim v as integer, vr as integer

	cStoreTemp = NULL

	if( (astGetClass( expr ) <> AST.NODECLASS.CONST) or (dclass = IR.DATACLASS.FPOINT) ) then
		s = symbAddTempVar( typ )
		if( s = NULL ) then
			exit function
		end if
		v = astNewVAR( s, NULL, 0, dtype )
		astFlush astNewASSIGN( v, expr ), vr
		isvar = TRUE
	else
		s = cint( astGetValue( expr ) )
		astDel expr
		isvar = FALSE
	end if

	cStoreTemp = s

end function

'':::::
private sub cFlushBOP( byval op as integer, byval dtype as integer, _
	 		   		   byval v1 as FBSYMBOL ptr, byval v1isvar as integer, _
			   		   byval v2 as FBSYMBOL ptr, byval v2isvar as integer, _
			   		   byval ex as FBSYMBOL ptr ) static
	dim expr1 as integer, expr2 as integer, expr as integer
	dim vr as integer

	'' bop
	if( v1isvar ) then
		expr1 = astNewVAR( v1, NULL, 0, dtype )
	else
		expr1 = astNewCONST( v1, dtype )
	end if

	if( v2isvar ) then
		expr2 = astNewVAR( v2, NULL, 0, dtype )
	else
		expr2 = astNewCONST( v2, dtype )
	end if

	expr = astNewBOP( op, expr1, expr2, ex, FALSE )

	''
	astFlush expr, vr

end sub

'':::::
private sub cFlushSelfBOP( byval op as integer, byval dtype as integer, _
	 		       		   byval v1 as integer, _
			       		   byval v2 as integer, byval v2isvar as integer ) static
	dim expr1 as integer, expr2 as integer, expr as integer
	dim vr as integer

	'' bop
	expr1 = astNewVAR( v1, NULL, 0, dtype )

	if( v2isvar ) then
		expr2 = astNewVAR( v2, NULL, 0, dtype )
	else
		expr2 = astNewCONST( v2, dtype )
	end if

	expr = astNewBOP( op, expr1, expr2 )

	'' assign
	expr1 = astNewVAR( v1, NULL, 0, dtype )

	expr = astNewASSIGN( expr1, expr )

	''
	astFlush expr, vr

end sub

'':::::
''ForStatement    =   FOR ID '=' Expression TO Expression (STEP Expression)? Comment? SttSeparator
''					  SimpleLine*
''					  NEXT ID? .
''
function cForStatement
    dim res as integer, iscomplex as integer, ispositive as integer
    dim il as FBSYMBOL ptr, tl as FBSYMBOL ptr, el as FBSYMBOL ptr, cl as FBSYMBOL ptr, c2l as FBSYMBOL ptr
    dim cnt as integer, elm as FBSYMBOL ptr
    dim endc as integer, endc_isvar as integer
    dim stp as integer, stp_isvar as integer
	dim cmp as integer, cmp_isvar as integer
    dim vr as integer, vt as integer
    dim idexpr as integer, expr as integer
    dim dtype as integer, dclass as integer, typ as integer
    dim oldforstmt as FBCMPSTMT, lastcompstmt as integer

	cForStatement = FALSE

	'' FOR
	lexSkipToken

	'' ID
	if( not cVariable( idexpr, cnt, elm ) ) then
		hReportError FB.ERRMSG.EXPECTEDVAR
		exit function
	end if

	if( (astGetClass( idexpr ) <> AST.NODECLASS.VAR) or (elm <> NULL) ) then
		hReportError FB.ERRMSG.EXPECTEDSCALAR, TRUE
		exit function
	end if

	typ = symbGetType( cnt )

	if( typ < FB.SYMBTYPE.BYTE or typ > FB.SYMBTYPE.DOUBLE ) then
		hReportError FB.ERRMSG.EXPECTEDSCALAR, TRUE
		exit function
	end if

	'' =
	if( not hMatch( FB.TK.ASSIGN ) ) then
		hReportError FB.ERRMSG.EXPECTEDEQ
		exit function
	end if

    '' Expression
    if( not cExpression( expr ) ) then
    	exit function
    end if

	'' save initial condition into counter
	expr = astNewASSIGN( idexpr, expr )
	astFlush expr, vr

	'' get counter type (endc and step must be the same type)
	dtype  = typ
	dclass = irGetDataClass( dtype )


	'' TO
	if( not hMatch( FB.TK.TO ) ) then
		hReportError FB.ERRMSG.EXPECTEDTO
		exit function
	end if

	'' end condition (Expression)
	if( not cExpression( expr ) ) then
		exit function
	end if

	'' store end condition into a temp var
	endc = cStoreTemp( expr, dtype, dclass, typ, endc_isvar )

	'' STEP
	ispositive 	= TRUE
	iscomplex 	= FALSE
	stp_isvar	= FALSE
	if( lexCurrentToken = FB.TK.STEP ) then
		lexSkipToken
		if( not cExpression( expr ) ) then
			exit function
		end if

		'' store step into a temp var
		if( astGetClass( expr ) = AST.NODECLASS.CONST ) then
			ispositive = (astGetValue( expr ) >= 0)
		else
			iscomplex = TRUE
		end if

		if( (iscomplex) or (dclass = IR.DATACLASS.FPOINT) ) then

			stp = symbAddTempVar( typ )
			if( stp = NULL ) then
				exit function
			end if

			astFlush astNewASSIGN( astNewVAR( stp, NULL, 0, dtype ), expr ), vr

			stp_isvar = TRUE

		else
			stp = astGetValue( expr )
			astDel expr
		end if

	else
		stp = 1
	end if

	'' jump to test
    tl = symbAddLabel( hMakeTmpStr )

    '' !!!FIXME!!! this branch could be eliminated if inic, endc and step are constants !!!FIXME!!!
    astFlush astNewBRANCH( IR.OP.JMP, tl ), vr

	'' add start label
	il = symbAddLabel( hMakeTmpStr )
	irEmitLABEL il, FALSE

	'' add comp and end label (will be used by any CONTINUE/EXIT FOR)
	cl = symbAddLabel( hMakeTmpStr )
	el = symbAddLabel( hMakeTmpStr )

	'' save old for stmt info
	oldforstmt = env.forstmt

	env.forstmt.cmplabel = cl
	env.forstmt.endlabel = el

	''
	lastcompstmt = env.lastcompound
	env.lastcompound = FB.TK.FOR

	'' Comment?
	res = cComment

	'' separator
	if( not cSttSeparator ) then
		hReportError FB.ERRMSG.EXPECTEDEOL
		exit function
	end if

	'' loop body
	do
		res = cSimpleLine
	loop while( (res) and (lexCurrentToken <> FB.TK.EOF) )

	'' NEXT
	if( not hMatch( FB.TK.NEXT ) ) then
		hReportError FB.ERRMSG.EXPECTEDNEXT
		exit function
	end if

	'' counter?
	if( lexCurrentTokenClass = FB.TKCLASS.IDENTIFIER ) then
		lexSkipToken

		'' ( ',' counter? )*
		if( lexCurrentToken = CHAR_COMMA ) then
			'' hack to handle multiple identifiers...
			lexSetCurrentToken FB.TK.NEXT, FB.TKCLASS.KEYWORD
		end if
	end if

	'' cmp label
	irEmitLABEL cl, FALSE

	'' counter += step
	cFlushSelfBOP IR.OP.ADD, dtype, cnt, stp, stp_isvar

	'' test label
	irEmitLABEL tl, FALSE

    if( not iscomplex ) then

		if( ispositive ) then
    		'' counter <= end cond?
			cFlushBOP IR.OP.LE, dtype, cnt, TRUE, endc, endc_isvar, il
    	else
    		'' counter >= end cond?
			cFlushBOP IR.OP.GE, dtype, cnt, TRUE, endc, endc_isvar, il
    	end if

		c2l = NULL
    else
		c2l = symbAddLabel( hMakeTmpStr )

    	'' test step sign and branch
    	if( dclass = IR.DATACLASS.INTEGER ) then
    		cmp = 0
    		cmp_isvar = FALSE
    	else
    		cmp = hAllocFloatConst( "0", typ )
    		cmp_isvar = TRUE
    	end if

		cFlushBOP IR.OP.GE, dtype, stp, stp_isvar, cmp, cmp_isvar, c2l

    	'' negative, loop if >=
		cFlushBOP IR.OP.GE, dtype, cnt, TRUE, endc, endc_isvar, il
		'' exit loop
		astFlush astNewBRANCH( IR.OP.JMP, el ), vr
    	'' control label
    	irEmitLABELNF c2l
    	'' positive, loop if <=
		cFlushBOP IR.OP.LE, dtype, cnt, TRUE, endc, endc_isvar, il
    end if

    '' end label (loop exit)
    irEmitLABEL el, FALSE

	'' restore old for stmt info
	env.forstmt = oldforstmt

	''
	env.lastcompound = lastcompstmt

    ''
    '''''if( c2l <> NULL ) then symbDelLabel c2l
    '''''symbDelLabel cl
    '''''symbDelLabel el
    '''''symbDelLabel il
    '''''symbDelLabel tl

	cForStatement = TRUE

end function

'':::::
''DoStatement     =   DO ((WHILE | UNTIL) Expression)? Comment? SttSeparator
''					  SimpleLine*
''					  LOOP ((WHILE | UNTIL) Expression)? .
''
function cDoStatement
    dim expr as integer, vr as integer, op as integer
	dim iswhile as integer, isuntil as integer
    dim il as FBSYMBOL ptr, el as FBSYMBOL ptr, cl as FBSYMBOL ptr
    dim olddostmt as FBCMPSTMT, lastcompstmt as integer
    dim isinverse as integer

	cDoStatement = FALSE

	'' DO
	lexSkipToken

	'' add ini and end labels (will be used by any EXIT DO)
	il = symbAddLabel( hMakeTmpStr )
	el = symbAddLabel( hMakeTmpStr )

	'' emit ini label
	irEmitLABEL il, FALSE

	'' ((WHILE | UNTIL) Expression)?
	vr = INVALID

	iswhile = FALSE
	isuntil = fALSE

	select case lexCurrentToken
	case FB.TK.WHILE
		iswhile = TRUE
	case FB.TK.UNTIL
		isuntil = TRUE
	end select

	if( iswhile or isuntil ) then
		lexSkipToken

		'' Expression
		if( not cExpression( expr ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if

		'' branch
		if( iswhile ) then
			isinverse = FALSE
		else
			isinverse = TRUE
		end if
		astUpdNodeResult expr
		astUpdComp2Branch expr, el, isinverse
		astFlush expr, vr

		cl = il
	else
		cl = symbAddLabel( hMakeTmpStr )
	end if

	'' save old do stmt info
	olddostmt = env.dostmt

	env.dostmt.cmplabel = cl
	env.dostmt.endlabel = el

	''
	lastcompstmt = env.lastcompound
	env.lastcompound = FB.TK.DO

	'' Comment?
	cComment

	'' separator
	if( not cSttSeparator ) then
		hReportError FB.ERRMSG.EXPECTEDEOL
		exit function
	end if

	'' loop body
	do
	loop while( (cSimpleLine) and (lexCurrentToken <> FB.TK.EOF) )

	'' LOOP
	if( not hMatch( FB.TK.LOOP ) ) then
		hReportError FB.ERRMSG.EXPECTEDLOOP
		exit function
	end if

	'' ((WHILE | UNTIL | SttSeparator) Expression)?
	iswhile = FALSE
	isuntil = fALSE

	select case lexCurrentToken
	case FB.TK.WHILE
		iswhile = TRUE
	case FB.TK.UNTIL
		isuntil = TRUE
	end select

	if( (iswhile or isuntil) and (vr <> INVALID) ) then
		hReportError FB.ERRMSG.SYNTAXERROR
		exit function
	end if

	'' emit comp label, if needed
	if( cl <> il ) then irEmitLABEL cl, FALSE

	if( iswhile or isuntil ) then
		lexSkipToken

		'' Expression
		if( not cExpression( expr ) ) then
			exit function
		end if

		'' branch
		if( iswhile ) then
			isinverse = TRUE
		else
			isinverse = FALSE
		end if

		astUpdNodeResult expr
		astUpdComp2Branch expr, il, isinverse
		astFlush expr, vr

	else
		astFlush astNewBRANCH( IR.OP.JMP, il ), vr
	end if

    '' end label (loop exit)
    irEmitLABEL el, FALSE

	'' restore old for stmt info
	env.dostmt = olddostmt

	''
	env.lastcompound = lastcompstmt

    ''
    '''''if( cl <> il ) then symbDelLabel cl
    '''''symbDelLabel el
    '''''symbDelLabel il


	cDoStatement = TRUE

end function

'':::::
''WhileStatement  =   WHILE Expression Comment? SttSeparator
''					  SimpleLine*
''					  WEND .
''
function cWhileStatement
    dim expr as integer, vr as integer
    dim il as FBSYMBOL ptr, el as FBSYMBOL ptr
    dim oldwhilestmt as FBCMPSTMT, lastcompstmt as integer

	cWhileStatement = FALSE

	'' WHILE
	lexSkipToken

	'' add ini and end labels
	il = symbAddLabel( hMakeTmpStr )
	el = symbAddLabel( hMakeTmpStr )

	'' save old while stmt info
	oldwhilestmt = env.whilestmt

	env.whilestmt.cmplabel = il
	env.whilestmt.endlabel = el

	''
	lastcompstmt = env.lastcompound
	env.lastcompound = FB.TK.WHILE

	'' emit ini label
	irEmitLABEL il, FALSE

	'' Expression
	if( not cExpression( expr ) ) then
		exit function
	end if

	'' branch
	astUpdNodeResult expr
	astUpdComp2Branch expr, el, FALSE
	astFlush expr, vr

	'' Comment?
	cComment

	'' separator
	if( not cSttSeparator ) then
		hReportError FB.ERRMSG.EXPECTEDEOL
		exit function
	end if

	'' loop body
	do
	loop while( (cSimpleLine) and (lexCurrentToken <> FB.TK.EOF) )

	'' WEND
	if( not hMatch( FB.TK.WEND ) ) then
		hReportError FB.ERRMSG.EXPECTEDWEND
		exit function
	end if

    astFlush astNewBRANCH( IR.OP.JMP, il ), vr

    '' end label (loop exit)
    irEmitLABEL el, FALSE

	'' restore old while stmt info
	env.whilestmt = oldwhilestmt

	''
	env.lastcompound = lastcompstmt

    ''
    '''''symbDelLabel el
    '''''symbDelLabel il


	cWhileStatement = TRUE

end function

'':::::
''SelectStatement =   SELECT CASE (AS CONST)? Expression Comment? SttSeparator
''					   cComment? cSttSeparator? CaseStatement*
''				      END SELECT .
''
function cSelectStatement
    dim expr as integer, vr as integer, lastcompstmt as integer
	dim symbol as FBSYMBOL ptr, dtype as integer
	dim elabel as FBSYMBOL ptr

	cSelectStatement = FALSE

	'' SELECT
	lexSkipToken

	'' CASE
	if( not hMatch( FB.TK.CASE ) ) then
		hReportError FB.ERRMSG.EXPECTEDCASE
		exit function
	end if

	'' AS?
	if( hMatch( FB.TK.AS ) ) then
		'' CONST?
		if( hMatch( FB.TK.CONST ) ) then
			cSelectStatement = cSelectConstStmt
		else
			hReportError FB.ERRMSG.SYNTAXERROR
		end if
		exit function
	end if

	'' Expression
	if( not cExpression( expr ) ) then
		exit function
	end if

	'' Comment?
	cComment

	'' separator
	if( not cSttSeparator ) then
		hReportError FB.ERRMSG.EXPECTEDEOL
		exit function
	end if

	'' save current context
	lastcompstmt = env.lastcompound
	env.lastcompound = FB.TK.SELECT

	'' add exit label
	elabel = symbAddLabel( hMakeTmpStr )

	'' store expression into a temp var
	astUpdNodeResult expr
	dtype  = astGetDataType( expr )
	if( dtype = FB.SYMBTYPE.FIXSTR ) then
		dtype = FB.SYMBTYPE.STRING
	end if

	symbol = symbAddTempVar( dtype )
	if( symbol = NULL ) then
		exit function
	end if

	expr = astNewASSIGN( astNewVAR( symbol, NULL, 0, dtype ), expr )
	if( expr = INVALID ) then
		exit function
	end if
	astFlush expr, vr

	'' SelectLine*
	do

    	'' Comment? SttSeparator?
    	do while( cComment or cSttSeparator )
    	loop

    	'' CaseStatement
    	if( not cCaseStatement( symbol, dtype, elabel ) ) then
	    	exit do
    	end if

	loop while( lexCurrentToken <> FB.TK.EOF )

    '' emit exit label
    irEmitLABEL elabel, FALSE
    '''''symbDelLabel elabel

	'' END SELECT
	if( (not hMatch( FB.TK.END )) or (not hMatch( FB.TK.SELECT )) ) then
		hReportError FB.ERRMSG.EXPECTEDENDSELECT
		exit function
	end if

	'' if a temp string was allocated, delete it
	if( dtype = FB.SYMBTYPE.STRING ) then
		expr = rtlStrDelete( astNewVAR( symbol, NULL, 0, dtype ) )
		astFlush expr, vr
	end if

	env.lastcompound = lastcompstmt

	cSelectStatement = TRUE

end function

'':::::
''CaseExpression  =   (Expression (TO Expression)?)?
''				  |   (IS REL_OP Expression)? .
''
function cCaseExpression( casectx as FBCASECTX )

	cCaseExpression = FALSE

	casectx.op 	= IR.OP.EQ

	'' IS REL_OP Expression
	if( hMatch( FB.TK.IS ) ) then
		casectx.op = hFBrelop2IRrelop( lexCurrentToken )
		lexSkipToken
		casectx.typ = FB.CASETYPE.IS
	else
		casectx.typ = 0
	end if

	'' Expression
	if( not cExpression( casectx.expr1 ) ) then
		exit function
	end if

	'' TO Expression
	if( hMatch( FB.TK.TO ) ) then
		if( casectx.typ <> 0 ) then
			hReportError FB.ERRMSG.SYNTAXERROR
			exit function
		end if

		if( not cExpression( casectx.expr2 ) ) then
			exit function
		end if

		casectx.typ =  FB.CASETYPE.RANGE
	end if

	cCaseExpression = TRUE

end function

'':::::
private function hExecCaseExpr( casectx as FBCASECTX, _
				           	    byval s as FBSYMBOL ptr, byval sdtype as integer, _
				           	    byval initlabel as FBSYMBOL ptr, byval nextlabel as FBSYMBOL ptr, _
				           		byval inverselogic as integer ) as integer static

	dim vr as integer, v as integer, expr as integer

	if( casectx.typ <> FB.CASETYPE.RANGE ) then
		v = astNewVAR( s, NULL, 0, sdtype )

		if( not inverselogic ) then
			expr = astNewBOP( casectx.op, v, casectx.expr1, initlabel, FALSE )
		else
			expr = astNewBOP( irGetInverseLogOp( casectx.op ), v, casectx.expr1, nextlabel, FALSE )
		end if

		astFlush expr, vr

	else
		v = astNewVAR( s, NULL, 0, sdtype )
		expr = astNewBOP( IR.OP.LT, v, casectx.expr1, nextlabel, FALSE )
		astFlush expr, vr

		if( expr = INVALID ) then
			hExecCaseExpr = FALSE
			exit function
		end if

		v = astNewVAR( s, NULL, 0, sdtype )
		if( not inverselogic ) then
			expr = astNewBOP( IR.OP.LE, v, casectx.expr2, initlabel, FALSE )
		else
			expr = astNewBOP( IR.OP.GT, v, casectx.expr2, nextlabel, FALSE )
		end if
		astFlush expr, vr
	end if

	hExecCaseExpr = expr <> INVALID

end function


'':::::
''CaseStatement   =    CASE (ELSE | (CaseExpression (COMMA CaseExpression)*)) Comment? SttSeparator
''					   SimpleLine*.
''
function cCaseStatement( byval s as FBSYMBOL ptr, byval sdtype as integer, byval exitlabel as FBSYMBOL ptr )
	dim il as FBSYMBOL ptr, nl as FBSYMBOL ptr
	dim iselse as integer, res as integer
	dim cnt as integer, i as integer, cntbase as integer
	dim vr as integer

	cCaseStatement = FALSE

	'' CASE
	if( not hMatch( FB.TK.CASE ) ) then
		exit function
	end if

	'' add labels
	il = symbAddLabel( hMakeTmpStr )

	'' CaseExpression (COMMA CaseExpression)*
	cnt = 0
	cntbase = selctx.base

	do
		if( cnt = 0 ) then
			if( hMatch( FB.TK.ELSE ) ) then
				caseTB(cntbase + cnt).typ = FB.CASETYPE.ELSE
				cnt = 1
				exit do
			end if
		end if

		if( not cCaseExpression( caseTB(cntbase + cnt) ) ) then
			exit function
		end if

		cnt = cnt + 1

	loop while( hMatch( CHAR_COMMA ) )

	'' Comment?
	cComment

	'' SttSeparator
	if( not cSttSeparator ) then
		exit function
	end if

	if( hGetLastError <> FB.ERRMSG.OK ) then
		exit function
	end if

	''
	selctx.base = selctx.base + cnt

	for i = cntbase to cntbase + cnt-1

		'' add next label
		nl = symbAddLabel( hMakeTmpStr )

		if( caseTB(i).typ <> FB.CASETYPE.ELSE ) then
			if( not hExecCaseExpr( caseTB(i), s, sdtype, il, nl, i = cntbase ) ) then
				hReportError FB.ERRMSG.INVALIDDATATYPES, TRUE
				exit function
			end if
		end if

		if( i = cntbase ) then
			''
			irEmitLABEL il, FALSE
			'''''symbDelLabel il

			'' SimpleLine*
			do
				res = cSimpleLine
			loop while( (res) and (lexCurrentToken <> FB.TK.EOF) )

			if( caseTB(i).typ = FB.CASETYPE.ELSE ) then
				exit for
			end if

			'' break from block
			astFlush astNewBRANCH( IR.OP.JMP, exitlabel ), vr

		end if

		'' emit next label
		irEmitLABEL nl, FALSE
		'''''symbDelLabel nl

	next i

	selctx.base = selctx.base - cnt

	cCaseStatement = TRUE

end function

'':::::
private function hSelConstAddCase( byval swtbase as integer, byval value as uinteger, _
							       byval label as FBSYMBOL ptr ) as integer static

	dim probe as integer, high as integer, low as integer
	dim v as uinteger, i as integer

	'' nothing left?
	if( swtctx.base >= FB.MAXSWTCASEEXPR ) then
		hSelConstAddCase = FALSE
		exit function
	end if

	hSelConstAddCase = TRUE

	'' find the slot using bin-search
	high = swtctx.base - swtbase
	low  = -1

	do while( high - low > 1 )
		probe = (high + low) \ 2
		v = swtcaseTB(swtbase+probe).value
		if( v < value ) then
			low = probe
		elseif( v > value ) then
			high = probe
		else
			exit function
		end if
	loop

	'' move up
	for i = swtctx.base+1 to swtbase+high+1 step -1
		swtcaseTB(i) = swtcaseTB(i-1)
	next i

	'' insert new item
	swtcaseTB(swtbase+high).value = value
	swtcaseTB(swtbase+high).label = label
	swtctx.base = swtctx.base + 1

end function

'':::::
''SelConstCaseStmt =   CASE (ELSE | (ConstExpression{int} (COMMA ConstExpression{int})*)) Comment? SttSeparator
''					       SimpleLine*.
''
function cSelConstCaseStmt( byval swtbase as integer, _
						    byval sym as FBSYMBOL ptr, byval exitlabel as FBSYMBOL ptr, _
						    minval as uinteger, maxval as uinteger, deflabel as FBSYMBOL ptr ) as integer

	dim expr1 as integer, expr2 as integer
	dim value as uinteger, tovalue as uinteger
	dim label as FBSYMBOL ptr
	dim vr as integer

	cSelConstCaseStmt = FALSE

	'' CASE
	if( not hMatch( FB.TK.CASE ) ) then
		exit function
	end if

	'' ELSE
	if( hMatch( FB.TK.ELSE ) ) then
		deflabel = symbAddLabel( hMakeTmpStr )
		irEmitLABEL deflabel, FALSE

	else

		'' add label
		label = symbAddLabel( hMakeTmpStr )

		'' ConstExpression (COMMA ConstExpression (TO ConstExpression)?)*
		do
			if( not cExpression( expr1 ) ) then
				exit function
			end if

			if( astGetClass( expr1 ) <> AST.NODECLASS.CONST ) then
				hReportError FB.ERRMSG.EXPECTEDCONST
				exit function
			end if

			value = astGetValue( expr1 )
			astDel expr1

			'' TO?
			if( hMatch( FB.TK.TO ) ) then
				if( not cExpression( expr2 ) ) then
					exit function
				end if

				if( astGetClass( expr2 ) <> AST.NODECLASS.CONST ) then
					hReportError FB.ERRMSG.EXPECTEDCONST
					exit function
				end if

				tovalue = astGetValue( expr2 )
				astDel expr2

				for value = value to tovalue
					if( value < minval ) then minval = value
					if( value > maxval ) then maxval = value

					'' add item
					if( not hSelConstAddCase( swtbase, value, label ) ) then
						exit function
					end if
				next

			else
				if( value < minval ) then minval = value
				if( value > maxval ) then maxval = value

				'' add item
				if( not hSelConstAddCase( swtbase, value, label ) ) then
					exit function
				end if

			end if

		loop while( hMatch( CHAR_COMMA ) )

		''
		irEmitLABEL label, FALSE

	end if

	'' Comment?
	cComment

	'' SttSeparator
	if( not cSttSeparator ) then
		exit function
	end if

	'' SimpleLine*
	do
	loop while( cSimpleLine and (lexCurrentToken <> FB.TK.EOF) )

	if( hGetLastError <> FB.ERRMSG.OK ) then
		exit function
	end if

	'' break from block
	astFlush astNewBRANCH( IR.OP.JMP, exitlabel ), vr

	cSelConstCaseStmt = TRUE

end function

'':::::
private function hSelConstAllocTbSym( ) as FBSYMBOL ptr static
	dim dTB(0) as FBARRAYDIM

	hSelConstAllocTbSym = symbAddVarEx( hMakeTmpStr, "", FB.SYMBTYPE.UINT, FB.INTEGERSIZE, NULL, _
							            1, dTB(), FB.ALLOCTYPE.SHARED, FALSE, FALSE, FALSE )

end function

'':::::
''SelectConstStmt =   SELECT CASE AS CONST Expression{int} Comment? SttSeparator
''					   cComment? cSttSeparator? SelConstCaseStmt*
''				      END SELECT .
''
function cSelectConstStmt as integer
    dim expr as integer, idxexpr as integer, vr as integer, lastcompstmt as integer
	dim sym as FBSYMBOL ptr
	dim exitlabel as FBSYMBOL ptr, complabel as FBSYMBOL ptr, deflabel as FBSYMBOL ptr
	dim tbsym as FBSYMBOL ptr
	dim minval as uinteger, maxval as uinteger
	dim value as uinteger, l as integer, swtbase as integer

	cSelectConstStmt = FALSE

	'' Expression
	if( not cExpression( expr ) ) then
		exit function
	end if

	if( astGetDataClass( expr ) <> IR.DATACLASS.INTEGER ) then
		hReportError FB.ERRMSG.INVALIDDATATYPES
		exit function
	end if

	if( astGetDataType( expr ) <> IR.DATATYPE.UINT ) then
		expr = astNewCONV( INVALID, IR.DATATYPE.UINT, expr )
	end if

	'' Comment?
	cComment

	'' separator
	if( not cSttSeparator ) then
		hReportError FB.ERRMSG.EXPECTEDEOL
		exit function
	end if

	'' save current context
	lastcompstmt = env.lastcompound
	env.lastcompound = FB.TK.SELECT

	'' add labels
	exitlabel = symbAddLabel( hMakeTmpStr )
	complabel = symbAddLabel( hMakeTmpStr )

	'' store expression into a temp var
	sym = symbAddTempVar( FB.SYMBTYPE.UINT )
	if( sym = NULL ) then
		exit function
	end if

	expr = astNewASSIGN( astNewVAR( sym, NULL, 0, IR.DATATYPE.UINT ), expr )
	if( expr = INVALID ) then
		exit function
	end if
	astFlush expr, vr

	'' skip the statements
	astFlush astNewBRANCH( IR.OP.JMP, complabel ), vr

	'' SwitchLine*
	swtbase = swtctx.base
	deflabel = NULL
	minval = &hFFFFFFFF
	maxval = 0
	do
    	'' Comment? SttSeparator?
    	do while( cComment or cSttSeparator )
    	loop

    	'' SelConstCaseStmt
    	if( not cSelConstCaseStmt( swtbase, sym, exitlabel, minval, maxval, deflabel ) ) then
	    	exit do
    	end if

	loop while( lexCurrentToken <> FB.TK.EOF )

    '' too large?
    if( (minval > maxval) or (maxval - minval > FB.MAXSWTCASERANGE) ) then
    	hReportError FB.ERRMSG.RANGETOOLARGE
    	exit function
    end if

    if( deflabel = NULL ) then
    	deflabel = exitlabel
    end if

    '' emit comp label
    irEmitLABEL complabel, FALSE
    '''''symbDelLabel complabel

	'' check min val
	if( minval > 0 ) then
		expr = astNewBOP( IR.OP.LT, astNewVAR( sym, NULL, 0, IR.DATATYPE.UINT ), _
						  astNewCONST( minval, IR.DATATYPE.UINT ), deflabel, FALSE )
		astFlush expr, vr
	end if

	'' check max val
	expr = astNewBOP( IR.OP.GT, astNewVAR( sym, NULL, 0, IR.DATATYPE.UINT ), _
					  astNewCONST( maxval, IR.DATATYPE.UINT ), deflabel, FALSE )
	astFlush expr, vr

    '' jump to table[idx]
    tbsym = hSelConstAllocTbSym( )

	idxexpr = astNewBOP( IR.OP.MUL, astNewVAR( sym, NULL, 0, IR.DATATYPE.UINT ), _
    				  			    astNewCONST( FB.INTEGERSIZE, IR.DATATYPE.UINT ) )

    expr = astNewIDX( astNewVAR( tbsym, NULL, -minval*FB.INTEGERSIZE, IR.DATATYPE.UINT ), idxexpr, _
    				  IR.DATATYPE.UINT, NULL )

    astFlush astNewBRANCH( IR.OP.JUMPPTR, NULL, expr ), vr

    '' emit table
    irEmitLABEL tbsym, FALSE

    ''!!!FIXME!!! parser shouldn't call IR directly, always use the AST
    irFlush

    ''
    l = swtbase
    for value = minval to maxval
    	if( value = swtcaseTB(l).value ) then
    		emitTYPE IR.DATATYPE.UINT, symbGetLabelName( swtcaseTB(l).label )
    		l = l + 1
    	else
    		emitTYPE IR.DATATYPE.UINT, symbGetLabelName( deflabel )
    	end if
    next value

    '' the table is not needed anymore
    symbDelVar tbsym

    swtctx.base = swtbase

    '' emit exit label
    irEmitLABEL exitlabel, FALSE
    '''''symbDelLabel exitlabel

	'' END SELECT
	if( (not hMatch( FB.TK.END )) or (not hMatch( FB.TK.SELECT )) ) then
		hReportError FB.ERRMSG.EXPECTEDENDSELECT
		exit function
	end if

	env.lastcompound = lastcompstmt

	cSelectConstStmt = TRUE

end function

'':::::
''ExitStatement	  =	  EXIT (FOR | DO | WHILE | SUB | FUNCTION)
''
function cExitStatement
    dim label as FBSYMBOL ptr
    dim vr as integer

	cExitStatement = FALSE

	'' EXIT
	lexSkipToken

	'' (FOR | DO | WHILE | SUB | FUNCTION)
	select case as const lexCurrentToken
	case FB.TK.FOR
		label = env.forstmt.endlabel

	case FB.TK.DO
		label = env.dostmt.endlabel

	case FB.TK.WHILE
		label = env.whilestmt.endlabel

	case FB.TK.SUB, FB.TK.FUNCTION
		label = env.procstmt.endlabel

		if( label = NULL ) then
			hReportError FB.ERRMSG.ILLEGALOUTSIDEASUB
			exit function
		end if

	case else
		hReportError FB.ERRMSG.ILLEGALOUTSIDEASTMT
		exit function
	end select

	''
	if( label = NULL ) then
		hReportError FB.ERRMSG.ILLEGALOUTSIDECOMP
		exit function
	end if

	lexSkipToken

	''
	astFlush astNewBRANCH( IR.OP.JMP, label ), vr

	cExitStatement = TRUE

end function

'':::::
''ContinueStatement	  =	  CONTINUE (FOR | DO | WHILE)
''
function cContinueStatement
    dim label as FBSYMBOL ptr
    dim vr as integer

	cContinueStatement = FALSE

	'' CONTINUE
	lexSkipToken

	'' (FOR | DO | WHILE)
	select case as const lexCurrentToken
	case FB.TK.FOR
		label = env.forstmt.cmplabel

	case FB.TK.DO
		label = env.dostmt.cmplabel

	case FB.TK.WHILE
		label = env.whilestmt.cmplabel

	case else
		hReportError FB.ERRMSG.ILLEGALOUTSIDEASTMT
		exit function
	end select

	if( label = NULL ) then
		hReportError FB.ERRMSG.ILLEGALOUTSIDECOMP
		exit function
	end if

	lexSkipToken

	''
	astFlush astNewBRANCH( IR.OP.JMP, label ), vr

	cContinueStatement = TRUE

end function

'':::::
''EndStatement	  =	  END (Expression | Keyword | ) .
''
function cEndStatement
	dim errlevel as integer, vr as integer

	cEndStatement = FALSE

	if( lexCurrentToken <> FB.TK.END ) then
		exit function
	end if

	'' any compound END will be parsed by the compound stmt
	if( lexLookAheadClass(1) = FB.TKCLASS.KEYWORD ) then

		if( env.compoundcnt = 1 ) then
			hReportError FB.ERRMSG.ILLEGALEND
			exit function
		end if

		cEndStatement = TRUE
		exit function

	else
		lexSkipToken							'' END
	end if

  	'' (Expression | )
  	select case lexCurrentToken
  	case FB.TK.STATSEPCHAR, FB.TK.EOL, FB.TK.EOF, FB.TK.COMMENTCHAR, FB.TK.REM
  		errlevel = astNewCONST( 0, IR.DATATYPE.INTEGER )
  	case else
  		if( not cExpression( errlevel ) ) then
  		end if
  	end select

    ''
	cEndStatement = rtlExit( errlevel )

end function


'':::::
''CompoundStmtElm  =  WEND | LOOP | NEXT | CASE | ELSE | ELSEIF .
''
function cCompoundStmtElm
    dim comp as integer

	cCompoundStmtElm = FALSE

	'' WEND | LOOP | NEXT | CASE | ELSE | ELSEIF
	select case as const lexCurrentToken
	case FB.TK.WEND
		comp = FB.TK.WHILE
	case FB.TK.LOOP
		comp = FB.TK.DO
	case FB.TK.NEXT
		comp = FB.TK.FOR
	case FB.TK.CASE
		comp = FB.TK.SELECT
	case FB.TK.ELSE, FB.TK.ELSEIF
		comp = FB.TK.IF
	case else
		exit function
	end select

	if( comp <> env.lastcompound ) then
		hReportError FB.ERRMSG.ILLEGALOUTSIDECOMP
		exit function
	end if

	cCompoundStmtElm = TRUE

end function

'':::::
private function hReadWithText as string
    dim text as string

    text = ""
    do
    	select case lexCurrentToken
		case FB.TK.EOL, FB.TK.STATSEPCHAR, FB.TK.COMMENTCHAR, FB.TK.REM, FB.TK.EOF
			exit do
		end select

    	text = text + lexEatToken
    loop

	hReadWithText = text

end function

'':::::
''WithStatement   =   WITH Variable Comment?
''					  SimpleLine*
''					  END WITH .
''
function cWithStatement
    dim oldwithtextidx as integer, lastcompstmt as integer
    dim res as integer

	cWithStatement = FALSE

	'' WITH
	lexSkipToken

	'' save old
	oldwithtextidx = env.withtextidx

	'' Variable
	env.withtextidx = strpAdd( hReadWithText )

	''
	lastcompstmt     = env.lastcompound
	env.lastcompound = FB.TK.WITH

	'' Comment?
	res = cComment

	'' separator
	if( not cSttSeparator ) then
		hReportError FB.ERRMSG.EXPECTEDEOL
		exit function
	end if

	'' loop body
	do
		res = cSimpleLine
	loop while( (res) and (lexCurrentToken <> FB.TK.EOF) )

	'' END WITH
	if( (not hMatch( FB.TK.END )) or (not hMatch( FB.TK.WITH )) ) then
		hReportError FB.ERRMSG.EXPECTEDENDWITH
		exit function
	end if

	'' restore old
	strpDel env.withtextidx
	env.withtextidx = oldwithtextidx

	''
	env.lastcompound = lastcompstmt

	cWithStatement = TRUE

end function

