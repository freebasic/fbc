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
	symbol	as FBSYMBOL ptr
	dtype	as integer
	elabel	as FBSYMBOL ptr
end type

'' globals
	dim shared selctx as FBSELECTCTX


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

	res = cIfStatement
	if( not res ) then
		res = cForStatement
		if( not res ) then
			res = cDoStatement
			if( not res ) then
				res = cWhileStatement
				if( not res ) then
					res = cSelectStatement
					if( not res ) then
						res = cExitStatement
						if( not res ) then
							res = cContinueStatement
							if( not res ) then
								res = cEndStatement
								if( not res ) then
									res = cCompoundStmtElm
								end if
							end if
						end if
					end if
				end if
			end if
		end if
	end if

	env.compoundcnt = env.compoundcnt - 1

	cCompoundStmt = res

end function

'':::::
''SingleIfStatement=  !(COMMENT|NEWLINE) NUM_LIT | SimpleStatement*)
''                    (ELSE SimpleStatement*)?
''
function cSingleIfStatement( byval expr as integer )
	dim vr as integer, cr as integer, dtype as integer, skipcompare as integer, s as FBSYMBOL ptr
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

	'' try to optimize if an logical op is at top of tree
	skipcompare = astFlush( expr, vr, nl, FALSE )

	if( not skipcompare ) then
		dtype = irGetVRDataType( vr )
		if( irGetDataClass( dtype ) = IR.DATACLASS.INTEGER ) then
			cr = irAllocVRIMM( dtype, FALSE )
		else
			s = hAllocFloatConst( "0", hDtype2Stype( dtype ) )
			cr = irAllocVRVAR( dtype, s, 0 )
		end if
		irEmitCOMPBRANCHNF IR.OP.EQ, vr, cr, nl
	end if

	'' NUM_LIT | SimpleStatement*
	if( lexCurrentTokenClass = FB.TKCLASS.NUMLITERAL ) then
		l = symbLookupLabel( lexTokenText )
		if( l = NULL ) then
			l = symbAddLabelEx( lexTokenText, FALSE )
		end if
		lexSkipToken

		irEmitBRANCH IR.OP.JMP, l, symbGetLabelScope( l ) = 0

	elseif( not cSimpleStatement ) then
		exit function
	end if

	'' (ELSE SimpleStatement*)?
	if( hMatch( FB.TK.ELSE ) ) then

		'' exit if stmt
		irEmitBRANCH IR.OP.JMP, el, FALSE

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
	dim vr as integer, cr as integer, dtype as integer, skipcompare as integer, s as FBSYMBOL ptr
	dim res as integer

	cIfStmtBody = FALSE

	'' try to optimize if an logical op is at top of tree
	skipcompare = astFlush( expr, vr, nl, FALSE )

	if( not skipcompare ) then
		dtype = irGetVRDataType( vr )
        if( irGetDataClass( dtype ) = IR.DATACLASS.INTEGER ) then
			cr = irAllocVRIMM( dtype, FALSE )
		else
			s = hAllocFloatConst( "0", hDtype2Stype( dtype ) )
			cr = irAllocVRVAR( dtype, s, 0 )
		end if
		irEmitCOMPBRANCHNF IR.OP.EQ, vr, cr, nl
	end if

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

	cIfStmtBody = TRUE

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
	dim res as integer

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
		irEmitBRANCH IR.OP.JMP, el, FALSE

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
		irEmitBRANCH IR.OP.JMP, el, FALSE

		'' emit next label
		irEmitLABEL nl, FALSE
		'''''symbDelLabel nl

		'' loop body
		do
			res = cSimpleLine
		loop while( (res) and (lexCurrentToken <> FB.TK.EOF) )

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
	if( not hMatch( FB.TK.IF ) ) then
		exit function
	end if

    '' Expression
    if( not cExpression( expr ) ) then
    	exit function
    end if

	'' THEN
	if( hMatch( FB.TK.THEN ) ) then

		'' (BlockIfStatement | SingleIfStatement)
		if( not cBlockIfStatement( expr ) ) then
			if( not cSingleIfStatement( expr ) ) then
				hReportError FB.ERRMSG.SYNTAXERROR
				exit function
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
function cStoreTemp( byval vs as integer, byval dtype as integer, byval dclass as integer, _
					 byval typ as integer, isvar as integer ) as FBSYMBOL ptr static
    dim vr as integer, v as FBSYMBOL ptr

	cStoreTemp = NULL

	if( (not irIsIMM( vs )) or (dclass = IR.DATACLASS.FPOINT) ) then
		v = symbAddTempVar( typ )
		if( v = NULL ) then
			exit function
		end if
		vr = irAllocVRVAR( dtype, v, 0 )
		irEmitSTORE vr, vs
		isvar = TRUE
	else
		v = irGetVRValue( vs )
		isvar = FALSE
	end if

	cStoreTemp = v

end function

'':::::
function cAddNode( byval v as FBSYMBOL ptr, byval dtype as integer, byval isvar as integer ) as integer static

	if( isvar ) then
		cAddNode = astNewVAR( v, 0, dtype )
	else
		cAddNode = astNewCONST( v, dtype )
	end if

end function

'':::::
sub cFlushBOP( byval op as integer, byval dtype as integer, _
	 		   byval v1 as FBSYMBOL ptr, byval v1isvar as integer, _
			   byval v2 as FBSYMBOL ptr, byval v2isvar as integer, _
			   byval ex as FBSYMBOL ptr, byval allocres as integer ) static
	dim expr1 as integer, expr2 as integer, expr as integer
	dim vr as integer

	'' bop
	if( v1isvar ) then
		expr1 = astNewVAR( v1, 0, dtype )
	else
		expr1 = astNewCONST( v1, dtype )
	end if

	if( v2isvar ) then
		expr2 = astNewVAR( v2, 0, dtype )
	else
		expr2 = astNewCONST( v2, dtype )
	end if

	expr = astNewBOP( op, expr1, expr2, ex, allocres )

	''
	astFlush expr, vr

end sub

'':::::
sub cFlushSelfBOP( byval op as integer, byval dtype as integer, _
	 		       byval v1 as integer, _
			       byval v2 as integer, byval v2isvar as integer ) static
	dim expr1 as integer, expr2 as integer, expr as integer
	dim vr as integer

	'' bop
	expr1 = astNewVAR( v1, 0, dtype )

	if( v2isvar ) then
		expr2 = astNewVAR( v2, 0, dtype )
	else
		expr2 = astNewCONST( v2, dtype )
	end if

	expr = astNewBOP( op, expr1, expr2 )

	'' assign
	expr1 = astNewVAR( v1, 0, dtype )

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
    dim cnt as integer
    dim endc as integer, endc_isvar as integer
    dim stp as integer, stp_isvar as integer
	dim cmp as integer, cmp_isvar as integer
    dim vr as integer, vt as integer
    dim idexpr as integer, expr as integer
    dim dtype as integer, dclass as integer, typ as integer
    dim oldforstmt as FBCMPSTMT, lastcompstmt as integer

	cForStatement = FALSE

	'' FOR
	if( not hMatch( FB.TK.FOR ) ) then
		exit function
	end if

	'' ID
	if( not cVariableEx( idexpr, TRUE, FALSE ) ) then
		hReportError FB.ERRMSG.EXPECTEDVAR
		exit function
	end if

	if( (astGetType( idexpr ) <> AST.NODETYPE.VAR) or _
		(astGetVAROfs( idexpr ) <> 0) ) then
		hReportError FB.ERRMSG.EXPECTEDSCALAR, TRUE
		exit function
	end if

	cnt = astGetSymbol( idexpr )
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
    if( not cExpression( expr ) ) then exit function

	'' save initial condition into counter
	expr = astNewASSIGN( idexpr, expr )
	astFlush expr, vr

	'' get counter type (endc and step must be the same type)
	dtype  = hStyp2Dtype( typ )
	dclass = irGetDataClass( dtype )


	'' TO
	if( not hMatch( FB.TK.TO ) ) then
		hReportError FB.ERRMSG.EXPECTEDTO
		exit function
	end if

	'' end condition (Expression)
	if( not cExpression( expr ) ) then exit function

	'' store end condition into a temp var
	astFlush expr, vr
	endc = cStoreTemp( vr, dtype, dclass, typ, endc_isvar )

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
		astFlush expr, vr

		if( irIsIMM( vr ) ) then
			ispositive = (irGetVRValue( vr ) >= 0)
		else
			iscomplex = TRUE
		end if

		if( (iscomplex) or (dclass = IR.DATACLASS.FPOINT) ) then

			stp = symbAddTempVar( typ )
			if( stp = NULL ) then
				exit function
			end if
			vt = irAllocVRVAR( dtype, stp, 0 )
			irEmitSTORE vt, vr

			stp_isvar = TRUE

		else
			stp = irGetVRValue( vr )
		end if

	else
		stp = 1
	end if

	'' jump to test
    tl = symbAddLabel( hMakeTmpStr )

    '' !!!FIXME!!! this branch could be eliminated if inic, endc and step are constants !!!FIXME!!!
    irEmitBRANCH IR.OP.JMP, tl, FALSE

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
	if( lexCurrentToken = FB.TK.ID ) then
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
			cFlushBOP IR.OP.LE, dtype, cnt, TRUE, endc, endc_isvar, il, FALSE
    	else
    		'' counter >= end cond?
			cFlushBOP IR.OP.GE, dtype, cnt, TRUE, endc, endc_isvar, il, FALSE
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

		cFlushBOP IR.OP.GE, dtype, stp, stp_isvar, cmp, cmp_isvar, c2l, FALSE

    	'' negative, loop if >=
		cFlushBOP IR.OP.GE, dtype, cnt, TRUE, endc, endc_isvar, il, FALSE
		'' exit loop
		irEmitBRANCH IR.OP.JMP, el, FALSE
    	'' control label
    	irEmitLABELNF c2l
    	'' positive, loop if <=
		cFlushBOP IR.OP.LE, dtype, cnt, TRUE, endc, endc_isvar, il, FALSE
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
    dim expr as integer, vr as integer, cr as integer, dtype as integer, op as integer
    dim s as FBSYMBOL ptr
	dim iswhile as integer, isuntil as integer
    dim il as FBSYMBOL ptr, el as FBSYMBOL ptr, cl as FBSYMBOL ptr
    dim olddostmt as FBCMPSTMT, lastcompstmt as integer
    dim res as integer, skipcompare as integer, isinverse as integer

	cDoStatement = FALSE

	'' DO
	if( not hMatch( FB.TK.DO ) ) then
		exit function
	end if

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

		'' try to optimize if an logical op is at top of tree
		if( iswhile ) then
			isinverse = FALSE
		else
			isinverse = TRUE
		end if
		skipcompare = astFlush( expr, vr, el, isinverse )

		if( not skipcompare ) then
			if( iswhile ) then
				op = IR.OP.EQ
			else
				op = IR.OP.NE
			end if

			dtype = irGetVRDataType( vr )
			if( irGetDataClass( dtype ) = IR.DATACLASS.INTEGER ) then
				cr = irAllocVRIMM( dtype, FALSE )
			else
				s = hAllocFloatConst( "0", hDtype2Stype( dtype ) )
				cr = irAllocVRVAR( dtype, s, 0 )
			end if
			irEmitCOMPBRANCHNF op, vr, cr, el
		end if

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

		'' try to optimize if an logical op is at top of tree
		if( iswhile ) then
			isinverse = TRUE
		else
			isinverse = FALSE
		end if
		skipcompare = astFlush( expr, vr, il, isinverse )

		if( not skipcompare ) then
			if( iswhile ) then
				op = IR.OP.NE
			else
				op = IR.OP.EQ
			end if

			dtype = irGetVRDataType( vr )
			if( irGetDataClass( dtype ) = IR.DATACLASS.INTEGER ) then
				cr = irAllocVRIMM( dtype, FALSE )
			else
				s = hAllocFloatConst( "0", hDtype2Stype( dtype ) )
				cr = irAllocVRVAR( dtype, s, 0 )
			end if
			irEmitCOMPBRANCHNF op, vr, cr, il
		end if

	else
		irEMITBRANCHNF IR.OP.JMP, il
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
    dim expr as integer, vr as integer, cr as integer, dtype as integer, s as FBSYMBOL ptr
    dim il as FBSYMBOL ptr, el as FBSYMBOL ptr
    dim oldwhilestmt as FBCMPSTMT, lastcompstmt as integer
    dim res as integer, skipcompare as integer

	cWhileStatement = FALSE

	'' WHILE
	if( not hMatch( FB.TK.WHILE ) ) then
		exit function
	end if

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

	'' try to optimize if an logical op is at top of tree
	skipcompare = astFlush( expr, vr, el, FALSE )

	if( not skipcompare ) then
		dtype = irGetVRDataType( vr )
		if( irGetDataClass( dtype ) = IR.DATACLASS.INTEGER ) then
			cr = irAllocVRIMM( dtype, FALSE )
		else
			s = hAllocFloatConst( "0", hDtype2Stype( dtype ) )
			cr = irAllocVRVAR( dtype, s, 0 )
		end if
		irEmitCOMPBRANCHNF IR.OP.EQ, vr, cr, el
	end if

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

	'' WEND
	if( not hMatch( FB.TK.WEND ) ) then
		hReportError FB.ERRMSG.EXPECTEDWEND
		exit function
	end if

    irEMITBRANCHNF IR.OP.JMP, il

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
function cSelectLine as integer

    cSelectLine = FALSE

    '' Comment? SttSeparator?
    do while( cComment or cSttSeparator )
    loop

    '' CaseStatement
    if( not cCaseStatement( selctx.symbol, selctx.dtype, selctx.elabel ) ) then
    	exit function
    end if

    cSelectLine = TRUE

end function

'':::::
''SelectStatement =   SELECT CASE Expression Comment? SttSeparator
''					   cComment? cSttSeparator? CaseStatement*
''				      END SELECT .
''
function cSelectStatement
    dim expr as integer, vr as integer, lastcompstmt as integer
    dim res as integer
    dim oldselctx as FBSELECTCTX

	cSelectStatement = FALSE

	'' SELECT
	if( not hMatch( FB.TK.SELECT ) ) then
		exit function
	end if

	'' CASE
	if( not hMatch( FB.TK.CASE ) ) then
		hReportError FB.ERRMSG.EXPECTEDCASE
		exit function
	end if

	'' Expression
	if( not cExpression( expr ) ) then
		exit function
	end if

	'' Comment?
	res = cComment

	'' separator
	if( not cSttSeparator ) then
		hReportError FB.ERRMSG.EXPECTEDEOL
		exit function
	end if

	'' save current context
	lastcompstmt = env.lastcompound
	env.lastcompound = FB.TK.SELECT

	oldselctx = selctx

	'' add exit label
	selctx.elabel = symbAddLabel( hMakeTmpStr )

	'' store expression into a temp var
	selctx.dtype  = astGetDataType( expr )			'' !!!FIXME!!! can ret wrong types w/ a complex expr
	if( selctx.dtype = FB.SYMBTYPE.FIXSTR ) then
		selctx.dtype = FB.SYMBTYPE.STRING
	end if

	selctx.symbol = symbAddTempVar( hDtype2Stype( selctx.dtype ) )
	if( selctx.symbol = NULL ) then
		exit function
	end if

	expr = astNewASSIGN( astNewVAR( selctx.symbol, 0, selctx.dtype ), expr )
	if( expr = INVALID ) then
		exit function
	end if
	astFlush expr, vr

	'' SelectLine*
	do
		res = cSelectLine
	loop while( (res) and (lexCurrentToken <> FB.TK.EOF) )

    '' emit exit label
    irEmitLABEL selctx.elabel, FALSE
    '''''symbDelLabel selctx.elabel

	'' END SELECT
	if( (not hMatch( FB.TK.END )) or (not hMatch( FB.TK.SELECT )) ) then
		hReportError FB.ERRMSG.EXPECTEDENDSELECT
		exit function
	end if

	'' if a temp string was allocated, delete it
	if( selctx.dtype = FB.SYMBTYPE.STRING ) then
		expr = rtlStrDelete( astNewVAR( selctx.symbol, 0, selctx.dtype ) )
		astFlush expr, vr
	end if

	'' restore old context
	selctx = oldselctx

	env.lastcompound = lastcompstmt

	cSelectStatement = TRUE

end function

'':::::
''CaseStatement   =    CASE (ELSE | (CaseExpression (COMMA CaseExpression)*)) Comment? SttSeparator
''					   SimpleLine*.
''
function cCaseStatement( byval s as FBSYMBOL ptr, byval sdtype as integer, byval exitlabel as FBSYMBOL ptr )
	dim il as FBSYMBOL ptr, nl as FBSYMBOL ptr
	dim iselse as integer
	dim res as integer

	cCaseStatement = FALSE

	'' CASE
	if( not hMatch( FB.TK.CASE ) ) then
		exit function
	end if

	'' add labels
	il = symbAddLabel( hMakeTmpStr )

	'' CaseExpression (COMMA CaseExpression)*
	iselse = FALSE
	do
		'' add next label
		nl = symbAddLabel( hMakeTmpStr )

		if( hMatch( FB.TK.ELSE ) ) then
			iselse = TRUE
			exit do
		elseif( not cCaseExpression( s, sdtype, il, nl ) ) then
			exit function
		end if

		if( not hMatch( CHAR_COMMA ) ) then
			exit do
		end if

    	'' emit next label
    	irEmitLABEL nl, FALSE
    	'''''symbDelLabel nl

	loop

	'' Comment?
	res = cComment

	'' SttSeparator
	if( not cSttSeparator ) then
		exit function
	end if

	if( not iselse ) then
		irEmitBRANCH IR.OP.JMP, nl, FALSE
	end if

	''
	irEmitLABEL il, FALSE
	'''''symbDelLabel il

	'' SimpleLine*
	do
		res = cSimpleLine
	loop while( (res) and (lexCurrentToken <> FB.TK.EOF) )

	'' break from block
	if( not iselse ) then
		irEmitBRANCH IR.OP.JMP, exitlabel, FALSE
	end if

    '' emit next label
    irEmitLABEL nl, FALSE
    '''''symbDelLabel nl

	cCaseStatement = TRUE

end function

'':::::
''CaseExpression  =   (Expression (TO Expression)?)?
''				  |   (IS REL_OP Expression)? .
''
function cCaseExpression( byval s as FBSYMBOL ptr, byval sdtype as integer, byval initlabel as FBSYMBOL ptr, byval nextlabel as FBSYMBOL ptr )
	dim op as integer, iscomp as integer, isrange as integer
	dim expr1 as integer, expr2 as integer
	dim vr as integer, v as integer

	cCaseExpression = FALSE

	expr1		= INVALID
	expr2		= INVALID

	iscomp		= FALSE
	isrange		= FALSE
	op 			= IR.OP.EQ

	'' IS REL_OP Expression
	if( hMatch( FB.TK.IS ) ) then
		op = hFBrelop2IRrelop( lexCurrentToken )
		lexSkipToken
		iscomp = TRUE
	end if

	'' Expression
	if( not cExpression( expr1 ) ) then
		exit function
	end if

	'' TO Expression
	if( hMatch( FB.TK.TO ) ) then
		if( iscomp ) then
			hReportError FB.ERRMSG.SYNTAXERROR
			exit function
		end if

		if( not cExpression( expr2 ) ) then
			exit function
		end if

		isrange = TRUE
	end if

	if( not isrange ) then
		v = astNewVAR( s, 0, sdtype )
		expr1 = astNewBOP( op, v, expr1, initlabel, FALSE )

		astFlush expr1, vr

	else
		v = astNewVAR( s, 0, sdtype )
		expr1 = astNewBOP( IR.OP.LT, v, expr1, nextlabel, FALSE )

		v = astNewVAR( s, 0, sdtype )
		expr2 = astNewBOP( IR.OP.LE, v, expr2, initlabel, FALSE )

		astFlush expr1, vr
		astFlush expr2, vr
	end if

	cCaseExpression = TRUE

end function

'':::::
''ExitStatement	  =	  EXIT (FOR | DO | WHILE | SUB | FUNCTION)
''
function cExitStatement
    dim label as FBSYMBOL ptr

	cExitStatement = FALSE

	'' EXIT
	if( not hMatch( FB.TK.EXIT ) ) then
		exit function
	end if

	'' (FOR | DO | WHILE | SUB | FUNCTION)
	select case lexCurrentToken
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
	irEmitBRANCH IR.OP.JMP, label, FALSE

	cExitStatement = TRUE

end function

'':::::
''ContinueStatement	  =	  CONTINUE (FOR | DO | WHILE)
''
function cContinueStatement
    dim label as FBSYMBOL ptr

	cContinueStatement = FALSE

	'' CONTINUE
	if( not hMatch( FB.TK.CONTINUE ) ) then
		exit function
	end if

	'' (FOR | DO | WHILE)
	select case lexCurrentToken
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
	irEmitBRANCH IR.OP.JMP, label, FALSE

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
    rtlExit errlevel

	cEndStatement = TRUE

end function


'':::::
''CompoundStmtElm  =  WEND | LOOP | NEXT | CASE | ELSE | ELSEIF .
''
function cCompoundStmtElm
    dim comp as integer

	cCompoundStmtElm = FALSE

	'' WEND | LOOP | NEXT | CASE | ELSE | ELSEIF
	select case lexCurrentToken
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
