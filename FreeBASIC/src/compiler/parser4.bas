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
'$include once: 'inc\fb.bi'
'$include once: 'inc\fbint.bi'
'$include once: 'inc\parser.bi'
'$include once: 'inc\rtl.bi'
'$include once: 'inc\ast.bi'
'$include once: 'inc\ir.bi'
'$include once: 'inc\emit.bi'

const FB.CASETYPE.RANGE = 1
const FB.CASETYPE.IS    = 2
const FB.CASETYPE.ELSE  = 3

const FB.MAXCASEEXPR 	= 1024
const FB.MAXSWTCASEEXPR = 8192

const FB.MAXSWTCASERANGE= 4096

type FBCASECTX
	typ 		as integer
	op 			as integer
	expr1		as ASTNODE ptr
	expr2		as ASTNODE ptr
end type

type FBSELECTCTX
	base		as integer
	caseTB(0 to FB.MAXCASEEXPR-1) as FBCASECTX
end type

type FBSWTCASECTX
	label		as FBSYMBOL ptr
	value		as uinteger
end type

type FBSWITCHCTX
	base		as integer
	caseTB(0 to FB.MAXSWTCASEEXPR-1) as FBSWTCASECTX
end type

type FBCTX
	sel 		as FBSELECTCTX
	swt 		as FBSWITCHCTX
	withcnt		as integer
end type

'' globals
	dim shared ctx as FBCTX


'':::::
sub parser4Init

	ctx.sel.base 	= 0

	ctx.swt.base 	= 0

	ctx.withcnt		= 0

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
function cCompoundStmt as integer

    env.compoundcnt += 1

	select case as const lexCurrentToken
	case FB.TK.IF
		function = cIfStatement( )
	case FB.TK.FOR
		function = cForStatement( )
	case FB.TK.DO
		function = cDoStatement( )
	case FB.TK.WHILE
		function = cWhileStatement( )
	case FB.TK.ELSE, FB.TK.ELSEIF, FB.TK.CASE, FB.TK.LOOP, FB.TK.NEXT, FB.TK.WEND
		function = cCompoundStmtElm( )
	case FB.TK.SELECT
		function = cSelectStatement( )
	case FB.TK.EXIT
		function = cExitStatement( )
	case FB.TK.CONTINUE
		function = cContinueStatement( )
	case FB.TK.END
		function = cEndStatement( )
	case FB.TK.WITH
		function = cWithStatement( )
	case else
		function = FALSE
	end select

	env.compoundcnt -= 1

end function

'':::::
''SingleIfStatement=  !(COMMENT|NEWLINE) NUM_LIT | SimpleStatement*)
''                    (ELSE SimpleStatement*)?
''
function cSingleIfStatement( byval expr as ASTNODE ptr ) as integer
	dim as FBSYMBOL ptr el, nl, l
	dim as integer lastcompstmt

	function = FALSE

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
	expr = astUpdComp2Branch( expr, nl, FALSE )
	if( expr = NULL ) then
		hReportError FB.ERRMSG.INVALIDDATATYPES
		exit function
	end if

	astFlush( expr )

	'' NUM_LIT | SimpleStatement*
	if( lexCurrentTokenClass = FB.TKCLASS.NUMLITERAL ) then
		l = symbFindByClass( lexTokenSymbol, FB.SYMBCLASS.LABEL )
		if( l = NULL ) then
			l = symbAddLabel( lexTokenText, FALSE, TRUE )
		end if
		lexSkipToken

		astFlush( astNewBRANCH( IR.OP.JMP, l ) )

	elseif( not cSimpleStatement ) then
		if( hGetLastError <> FB.ERRMSG.OK ) then
			exit function
		end if
	end if

	'' (ELSE SimpleStatement*)?
	if( hMatch( FB.TK.ELSE ) ) then

		'' exit if stmt
		astFlush( astNewBRANCH( IR.OP.JMP, el ) )

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

	'' END IF? -- added to make complex macros easier to be done
	if( lexCurrentToken = FB.TK.END ) then
		if( lexLookahead(1) = FB.TK.IF ) then
			lexSkipToken
			lexSkipToken
		end if
	end if

	''
	env.lastcompound = lastcompstmt

	''
	'''''symbDelLabel el
	'''''symbDelLabel nl

	function = TRUE

end function

'':::::
function cIfStmtBody( byval expr as ASTNODE ptr, _
					  byval nl as FBSYMBOL ptr, _
					  byval el as FBSYMBOL ptr, _
					  byval checkstmtsep as integer = TRUE ) as integer

	function = FALSE

	'' branch
	expr = astUpdComp2Branch( expr, nl, FALSE )
	if( expr = NULL ) then
		hReportError FB.ERRMSG.INVALIDDATATYPES
		exit function
	end if
	astFlush( expr )

	if( checkstmtsep ) then
		'' Comment?
		cComment

		'' separator
		if( not cSttSeparator ) then
			hReportError FB.ERRMSG.EXPECTEDEOL
			exit function
		end if
	end if

	'' loop body
	do
	loop while( (cSimpleLine) and (lexCurrentToken <> FB.TK.EOF) )

	if( hGetLastError = FB.ERRMSG.OK ) then
		function = TRUE
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
function cBlockIfStatement( byval expr as ASTNODE ptr ) as integer
	dim el as FBSYMBOL ptr, nl as FBSYMBOL ptr
	dim lastcompstmt as integer

	function = FALSE

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
		astFlush( astNewBRANCH( IR.OP.JMP, el ) )

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
		astFlush( astNewBRANCH( IR.OP.JMP, el ) )

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

	function = TRUE

end function

'':::::
''IfStatement	  =   IF Expression THEN (BlockIfStatement | SingleIfStatement) .
''
function cIfStatement as integer
	dim expr as ASTNODE ptr

	function = FALSE

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


	function = TRUE

end function

'':::::
private function cStoreTemp( byval expr as ASTNODE ptr, _
							 byval dtype as integer ) as FBSYMBOL ptr static
    dim as FBSYMBOL ptr s
    dim as ASTNODE ptr vexpr

	function = NULL

	s = symbAddTempVar( dtype )
	if( s = NULL ) then
		exit function
	end if

	vexpr = astNewVAR( s, NULL, 0, dtype )
	astFlush( astNewASSIGN( vexpr, expr ) )

	function = s

end function

'':::::
private sub cFlushBOP( byval op as integer, _
					   byval dtype as integer, _
	 		   		   byval v1 as FBSYMBOL ptr, _
	 		   		   byval val1 as FBVALUE ptr, _
			   		   byval v2 as FBSYMBOL ptr, _
			   		   byval val2 as FBVALUE ptr, _
			   		   byval ex as FBSYMBOL ptr ) static

	dim as ASTNODE ptr expr1, expr2, expr

	'' bop
	if( v1 <> NULL ) then
		expr1 = astNewVAR( v1, NULL, 0, dtype )
	else
		select case as const dtype
		case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
			expr1 = astNewCONST64( val1->value64, dtype )
		case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
			expr1 = astNewCONSTf( val1->valuef, dtype )
		case else
			expr1 = astNewCONSTi( val1->valuei, dtype )
		end select
	end if

	if( v2 <> NULL ) then
		expr2 = astNewVAR( v2, NULL, 0, dtype )
	else
		select case as const dtype
		case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
			expr2 = astNewCONST64( val2->value64, dtype )
		case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
			expr2 = astNewCONSTf( val2->valuef, dtype )
		case else
			expr2 = astNewCONSTi( val2->valuei, dtype )
		end select
	end if

	expr = astNewBOP( op, expr1, expr2, ex, FALSE )

	''
	astFlush( expr )

end sub

'':::::
private sub cFlushSelfBOP( byval op as integer, _
						   byval dtype as integer, _
	 		       		   byval v1 as FBSYMBOL PTR, _
			       		   byval v2 as FBSYMBOL PTR, _
			       		   byval val2 as FBVALUE ptr ) static

	dim as ASTNODE ptr expr1, expr2, expr

	'' bop
	expr1 = astNewVAR( v1, NULL, 0, dtype )

	if( v2 <> NULL ) then
		expr2 = astNewVAR( v2, NULL, 0, dtype )
	else
		select case as const dtype
		case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
			expr2 = astNewCONST64( val2->value64, dtype )
		case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
			expr2 = astNewCONSTf( val2->valuef, dtype )
		case else
			expr2 = astNewCONSTi( val2->valuei, dtype )
		end select
	end if

	expr = astNewBOP( op, expr1, expr2 )

	'' assign
	expr1 = astNewVAR( v1, NULL, 0, dtype )

	expr = astNewASSIGN( expr1, expr )

	''
	astFlush( expr )

end sub

'':::::
''ForStatement    =   FOR ID '=' Expression TO Expression (STEP Expression)? Comment? SttSeparator
''					  SimpleLine*
''					  NEXT ID? .
''
function cForStatement as integer
    dim as integer iscomplex, ispositive, isconst
    dim as FBSYMBOL ptr il, tl, el, cl, c2l
    dim as FBSYMBOL ptr cnt, endc, stp, elm
    dim as FBVALUE sval, eval, ival
    dim as ASTNODE ptr idexpr, expr
    dim as integer op, dtype, dclass, typ, lastcompstmt
    dim as FBCMPSTMT oldforstmt

	function = FALSE

	'' FOR
	lexSkipToken

	'' ID
	if( not cVariable( idexpr, cnt, elm ) ) then
		hReportError FB.ERRMSG.EXPECTEDVAR
		exit function
	end if

	if( (not astIsVAR( idexpr )) or (elm <> NULL) ) then
		hReportError FB.ERRMSG.EXPECTEDSCALAR, TRUE
		exit function
	end if

	typ = symbGetType( cnt )

	if( (typ < FB.SYMBTYPE.BYTE) or (typ > FB.SYMBTYPE.DOUBLE) ) then
		hReportError FB.ERRMSG.EXPECTEDSCALAR, TRUE
		exit function
	end if

	'' =
	if( not hMatch( FB.TK.ASSIGN ) ) then
		hReportError FB.ERRMSG.EXPECTEDEQ
		exit function
	end if

	'' get counter type (endc and step must be the same type)
	dtype  = typ
	dclass = irGetDataClass( dtype )
	isconst = 0

    '' Expression
    if( not cExpression( expr ) ) then
    	exit function
    end if

	''
	if( astIsCONST( expr ) ) then
		astConvertValue( expr, @ival, dtype )
		isconst += 1
	end if

	'' save initial condition into counter
	expr = astNewASSIGN( idexpr, expr )
	astFlush( expr )

	'' TO
	if( not hMatch( FB.TK.TO ) ) then
		hReportError FB.ERRMSG.EXPECTEDTO
		exit function
	end if

	'' end condition (Expression)
	if( not cExpression( expr ) ) then
		exit function
	end if

	''
	if( astIsCONST( expr ) ) then
		astConvertValue( expr, @eval, dtype )
		astDel expr
		endc = NULL
		isconst += 1

	'' store end condition into a temp var
	else
		endc = cStoreTemp( expr, dtype )
	end if

	'' STEP
	ispositive 	= TRUE
	iscomplex 	= FALSE
	if( lexCurrentToken = FB.TK.STEP ) then
		lexSkipToken
		if( not cExpression( expr ) ) then
			exit function
		end if

		'' store step into a temp var
		if( astIsCONST( expr ) ) then
			select case as const astGetDataType( expr )
			case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
				ispositive = (astGetValue64( expr ) >= 0)
			case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
				ispositive = (astGetValueF( expr ) >= 0)
			case else
				ispositive = (astGetValueI( expr ) >= 0)
			end select
		else
			iscomplex = TRUE
		end if

		if( iscomplex ) then

			stp = symbAddTempVar( typ )
			if( stp = NULL ) then
				exit function
			end if

			astFlush( astNewASSIGN( astNewVAR( stp, NULL, 0, dtype ), expr ) )

		else
            '' get constant step
            astConvertValue( expr, @sval, dtype )
			astDel expr
			stp = NULL
			isconst += 1
		end if

	else
		select case as const dtype
		case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
			sval.value64 = 1
		case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
			sval.valuef = 1.0
		case else
			sval.valuei = 1
		end select
		stp = NULL
		isconst += 1
	end if

	'' labels
    tl = symbAddLabel( hMakeTmpStr )
	'' add comp and end label (will be used by any CONTINUE/EXIT FOR)
	cl = symbAddLabel( hMakeTmpStr )
	el = symbAddLabel( hMakeTmpStr )

    '' if inic, endc and stepc are all constants,
    '' check if this branch is needed
    if( isconst = 3 ) then

		if( ispositive ) then
			op = IR.OP.LE
    	else
			op = IR.OP.GE
    	end if

    	expr = astNewBOP( op, astNewCONST( @ival, dtype ), astNewCONST( @eval, dtype ) )
    	if( not astGetValueI( expr ) ) then
    		astFlush( astNewBRANCH( IR.OP.JMP, el ) )
    	end if
    	astDel expr

    else
    	astFlush( astNewBRANCH( IR.OP.JMP, tl ) )
    end if

	'' add start label
	il = symbAddLabel( hMakeTmpStr )
	irEmitLABEL il, FALSE

	'' save old for stmt info
	oldforstmt = env.forstmt

	env.forstmt.cmplabel = cl
	env.forstmt.endlabel = el

	''
	lastcompstmt = env.lastcompound
	env.lastcompound = FB.TK.FOR

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
	cFlushSelfBOP IR.OP.ADD, dtype, cnt, stp, @sval

	'' test label
	irEmitLABEL tl, FALSE

    if( not iscomplex ) then

		if( ispositive ) then
			op = IR.OP.LE
    	else
			op = IR.OP.GE
    	end if

    	'' counter <= or >= end cond?
		cFlushBOP op, dtype, cnt, NULL, endc, @eval, il

		c2l = NULL
    else
		c2l = symbAddLabel( hMakeTmpStr )

    	'' test step sign and branch
		select case as const dtype
		case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
			ival.value64 = 0
		case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
			ival.valuef = 0.0
		case else
			ival.valuei = 0
		end select

		cFlushBOP IR.OP.GE, dtype, stp, @sval, NULL, @ival, c2l

    	'' negative, loop if >=
		cFlushBOP IR.OP.GE, dtype, cnt, NULL, endc, @eval, il
		'' exit loop
		astFlush( astNewBRANCH( IR.OP.JMP, el ) )
    	'' control label
    	irEmitLABELNF( c2l )
    	'' positive, loop if <=
		cFlushBOP IR.OP.LE, dtype, cnt, NULL, endc, @eval, il
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

	function = TRUE

end function

'':::::
''DoStatement     =   DO ((WHILE | UNTIL) Expression)? Comment? SttSeparator
''					  SimpleLine*
''					  LOOP ((WHILE | UNTIL) Expression)? .
''
function cDoStatement as integer
    dim as ASTNODE ptr expr
    dim as IRVREG ptr vr
	dim as integer iswhile, isuntil, isinverse, lastcompstmt, op
    dim as FBSYMBOL ptr il, el, cl
    dim as FBCMPSTMT olddostmt

	function = FALSE

	'' DO
	lexSkipToken

	'' add ini and end labels (will be used by any EXIT DO)
	il = symbAddLabel( hMakeTmpStr )
	el = symbAddLabel( hMakeTmpStr )

	'' emit ini label
	irEmitLABEL il, FALSE

	'' ((WHILE | UNTIL) Expression)?
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

		expr = astUpdComp2Branch( expr, el, isinverse )
		if( expr = NULL ) then
			hReportError FB.ERRMSG.INVALIDDATATYPES
			exit function
		end if

		vr = astFlush( expr )
		cl = il

	else
		vr = NULL
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

	if( (iswhile or isuntil) and (vr <> NULL) ) then
		hReportError FB.ERRMSG.SYNTAXERROR
		exit function
	end if

	'' emit comp label, if needed
	if( cl <> il ) then
		irEmitLABEL cl, FALSE
	end if

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

		expr = astUpdComp2Branch( expr, il, isinverse )
		if( expr = NULL ) then
			hReportError FB.ERRMSG.INVALIDDATATYPES
			exit function
		end if
		astFlush( expr )

	else
		astFlush( astNewBRANCH( IR.OP.JMP, il ) )
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


	function = TRUE

end function

'':::::
''WhileStatement  =   WHILE Expression Comment? SttSeparator
''					  SimpleLine*
''					  WEND .
''
function cWhileStatement as integer
    dim as ASTNODE ptr expr
    dim as integer lastcompstmt
    dim as FBSYMBOL ptr il, el
    dim as FBCMPSTMT oldwhilestmt

	function = FALSE

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
	expr = astUpdComp2Branch( expr, el, FALSE )
	if( expr = NULL ) then
		hReportError FB.ERRMSG.INVALIDDATATYPES
		exit function
	end if
	astFlush( expr )

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

    astFlush( astNewBRANCH( IR.OP.JMP, il ) )

    '' end label (loop exit)
    irEmitLABEL el, FALSE

	'' restore old while stmt info
	env.whilestmt = oldwhilestmt

	''
	env.lastcompound = lastcompstmt

    ''
    '''''symbDelLabel el
    '''''symbDelLabel il


	function = TRUE

end function

'':::::
''SelectStatement =   SELECT CASE (AS CONST)? Expression Comment? SttSeparator
''					   cComment? cSttSeparator? CaseStatement*
''				      END SELECT .
''
function cSelectStatement as integer
    dim as ASTNODE ptr expr
    dim as integer lastcompstmt
	dim symbol as FBSYMBOL ptr, dtype as integer
	dim elabel as FBSYMBOL ptr

	function = FALSE

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
			function = cSelectConstStmt( )
		else
			hReportError FB.ERRMSG.SYNTAXERROR
		end if
		exit function
	end if

	'' Expression
	if( not cExpression( expr ) ) then
		exit function
	end if

	'' can't be an UDT
	if( astGetDataType( expr ) = IR.DATATYPE.USERDEF ) then
		hReportError FB.ERRMSG.INVALIDDATATYPES
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
	dtype  = astGetDataType( expr )
	if( (dtype = FB.SYMBTYPE.FIXSTR) or (dtype = FB.SYMBTYPE.CHAR) ) then
		dtype = FB.SYMBTYPE.STRING
	end if

	symbol = symbAddTempVar( dtype )
	if( symbol = NULL ) then
		exit function
	end if

	expr = astNewASSIGN( astNewVAR( symbol, NULL, 0, dtype ), expr )
	if( expr = NULL ) then
		exit function
	end if
	astFlush( expr )

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
		astFlush( expr )
	end if

	env.lastcompound = lastcompstmt

	function = TRUE

end function

'':::::
''CaseExpression  =   (Expression (TO Expression)?)?
''				  |   (IS REL_OP Expression)? .
''
function cCaseExpression( casectx as FBCASECTX ) as integer

	function = FALSE

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

	function = TRUE

end function

'':::::
private function hExecCaseExpr( casectx as FBCASECTX, _
				           	    byval s as FBSYMBOL ptr, _
				           	    byval sdtype as integer, _
				           	    byval initlabel as FBSYMBOL ptr, _
				           	    byval nextlabel as FBSYMBOL ptr, _
				           		byval inverselogic as integer ) as integer static

	dim as ASTNODE ptr expr, v

	if( casectx.typ <> FB.CASETYPE.RANGE ) then
		v = astNewVAR( s, NULL, 0, sdtype )

		if( not inverselogic ) then
			expr = astNewBOP( casectx.op, v, casectx.expr1, initlabel, FALSE )
		else
			expr = astNewBOP( irGetInverseLogOp( casectx.op ), v, casectx.expr1, nextlabel, FALSE )
		end if

		astFlush( expr )

	else
		v = astNewVAR( s, NULL, 0, sdtype )
		expr = astNewBOP( IR.OP.LT, v, casectx.expr1, nextlabel, FALSE )
		astFlush( expr )

		if( expr = NULL ) then
			return FALSE
		end if

		v = astNewVAR( s, NULL, 0, sdtype )
		if( not inverselogic ) then
			expr = astNewBOP( IR.OP.LE, v, casectx.expr2, initlabel, FALSE )
		else
			expr = astNewBOP( IR.OP.GT, v, casectx.expr2, nextlabel, FALSE )
		end if
		astFlush( expr )
	end if

	function = expr <> NULL

end function


'':::::
''CaseStatement   =    CASE (ELSE | (CaseExpression (COMMA CaseExpression)*)) Comment? SttSeparator
''					   SimpleLine*.
''
function cCaseStatement( byval s as FBSYMBOL ptr, _
						 byval sdtype as integer, _
						 byval exitlabel as FBSYMBOL ptr )

	dim il as FBSYMBOL ptr, nl as FBSYMBOL ptr
	dim iselse as integer, res as integer
	dim cnt as integer, i as integer, cntbase as integer

	function = FALSE

	'' CASE
	if( not hMatch( FB.TK.CASE ) ) then
		exit function
	end if

	'' add labels
	il = symbAddLabel( hMakeTmpStr )

	'' CaseExpression (COMMA CaseExpression)*
	cnt = 0
	cntbase = ctx.sel.base

	do
		if( cnt = 0 ) then
			if( hMatch( FB.TK.ELSE ) ) then
				ctx.sel.caseTB(cntbase + cnt).typ = FB.CASETYPE.ELSE
				cnt = 1
				exit do
			end if
		end if

		if( not cCaseExpression( ctx.sel.caseTB(cntbase + cnt) ) ) then
			exit function
		end if

		cnt += 1

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
	ctx.sel.base += cnt

	for i = cntbase to cntbase + cnt-1

		'' add next label
		nl = symbAddLabel( hMakeTmpStr )

		if( ctx.sel.caseTB(i).typ <> FB.CASETYPE.ELSE ) then
			if( not hExecCaseExpr( ctx.sel.caseTB(i), s, sdtype, il, nl, i = cntbase ) ) then
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

			if( ctx.sel.caseTB(i).typ = FB.CASETYPE.ELSE ) then
				exit for
			end if

			'' break from block
			astFlush( astNewBRANCH( IR.OP.JMP, exitlabel ) )

		end if

		'' emit next label
		irEmitLABEL nl, FALSE
		'''''symbDelLabel nl

	next i

	ctx.sel.base -= cnt

	function = TRUE

end function

'':::::
private function hSelConstAddCase( byval swtbase as integer, _
								   byval value as uinteger, _
							       byval label as FBSYMBOL ptr ) as integer static

	dim probe as integer, high as integer, low as integer
	dim v as uinteger, i as integer

	'' nothing left?
	if( ctx.swt.base >= FB.MAXSWTCASEEXPR ) then
		return FALSE
	end if

	function = TRUE

	'' find the slot using bin-search
	high = ctx.swt.base - swtbase
	low  = -1

	do while( high - low > 1 )
		probe = (high + low) \ 2
		v = ctx.swt.caseTB(swtbase+probe).value
		if( v < value ) then
			low = probe
		elseif( v > value ) then
			high = probe
		else
			exit function
		end if
	loop

	'' move up
	for i = ctx.swt.base+1 to swtbase+high+1 step -1
		ctx.swt.caseTB(i) = ctx.swt.caseTB(i-1)
	next i

	'' insert new item
	ctx.swt.caseTB(swtbase+high).value = value
	ctx.swt.caseTB(swtbase+high).label = label
	ctx.swt.base += 1

end function

'':::::
''SelConstCaseStmt =   CASE (ELSE | (ConstExpression{int} (COMMA ConstExpression{int})*)) Comment? SttSeparator
''					       SimpleLine*.
''
function cSelConstCaseStmt( byval swtbase as integer, _
						    byval sym as FBSYMBOL ptr, _
						    byval exitlabel as FBSYMBOL ptr, _
						    minval as uinteger, _
						    maxval as uinteger, _
						    deflabel as FBSYMBOL ptr ) as integer

	dim as ASTNODE ptr expr1, expr2
	dim as uinteger value, tovalue
	dim as FBSYMBOL ptr label

	function = FALSE

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

			if( not astIsCONST( expr1 ) ) then
				hReportError FB.ERRMSG.EXPECTEDCONST
				exit function
			end if

			select case as const astGetDataType( expr1 )
			case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
				value = astGetValue64( expr1 )
			case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
				value = astGetValueF( expr1 )
			case else
				value = astGetValueI( expr1 )
			end select

			astDel expr1

			'' TO?
			if( hMatch( FB.TK.TO ) ) then
				if( not cExpression( expr2 ) ) then
					exit function
				end if

				if( not astIsCONST( expr2 ) ) then
					hReportError FB.ERRMSG.EXPECTEDCONST
					exit function
				end if

				select case as const astGetDataType( expr2 )
				case IR.DATATYPE.LONGINT, IR.DATATYPE.ULONGINT
					tovalue = astGetValue64( expr2 )
				case IR.DATATYPE.SINGLE, IR.DATATYPE.DOUBLE
					tovalue = astGetValueF( expr2 )
				case else
					tovalue = astGetValueI( expr2 )
				end select

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
	astFlush( astNewBRANCH( IR.OP.JMP, exitlabel ) )

	function = TRUE

end function

'':::::
private function hSelConstAllocTbSym( ) as FBSYMBOL ptr static
	dim dTB(0) as FBARRAYDIM

	function = symbAddVarEx( hMakeTmpStr, "", FB.SYMBTYPE.UINT, NULL, 0, _
							 FB.INTEGERSIZE, 1, dTB(), FB.ALLOCTYPE.SHARED, _
							 FALSE, FALSE, FALSE )

end function

'':::::
''SelectConstStmt =   SELECT CASE AS CONST Expression{int} Comment? SttSeparator
''					   cComment? cSttSeparator? SelConstCaseStmt*
''				      END SELECT .
''
function cSelectConstStmt as integer
    dim as ASTNODE ptr expr, idxexpr
    dim as integer lastcompstmt
	dim as FBSYMBOL ptr sym, exitlabel, complabel, deflabel, tbsym
	dim as uinteger minval, maxval, value
	dim as integer l, swtbase

	function = FALSE

	'' Expression
	if( not cExpression( expr ) ) then
		exit function
	end if

	if( astGetDataClass( expr ) <> IR.DATACLASS.INTEGER ) then
		hReportError( FB.ERRMSG.INVALIDDATATYPES )
		exit function
	end if

	if( astGetDataType( expr ) <> IR.DATATYPE.UINT ) then
		expr = astNewCONV( INVALID, IR.DATATYPE.UINT, expr )
	end if

	'' Comment?
	cComment( )

	'' separator
	if( not cSttSeparator ) then
		hReportError( FB.ERRMSG.EXPECTEDEOL )
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
	if( expr = NULL ) then
		exit function
	end if
	astFlush( expr )

	'' skip the statements
	astFlush( astNewBRANCH( IR.OP.JMP, complabel ) )

	'' SwitchLine*
	swtbase = ctx.swt.base
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
    	hReportError( FB.ERRMSG.RANGETOOLARGE )
    	exit function
    end if

    if( deflabel = NULL ) then
    	deflabel = exitlabel
    end if

    '' emit comp label
    irEmitLABEL( complabel, FALSE )
    '''''symbDelLabel complabel

	'' check min val
	if( minval > 0 ) then
		expr = astNewBOP( IR.OP.LT, astNewVAR( sym, NULL, 0, IR.DATATYPE.UINT ), _
						  astNewCONSTi( minval, IR.DATATYPE.UINT ), deflabel, FALSE )
		astFlush( expr )
	end if

	'' check max val
	expr = astNewBOP( IR.OP.GT, astNewVAR( sym, NULL, 0, IR.DATATYPE.UINT ), _
					  astNewCONSTi( maxval, IR.DATATYPE.UINT ), deflabel, FALSE )
	astFlush( expr )

    '' jump to table[idx]
    tbsym = hSelConstAllocTbSym( )

	idxexpr = astNewBOP( IR.OP.MUL, astNewVAR( sym, NULL, 0, IR.DATATYPE.UINT ), _
    				  			    astNewCONSTi( FB.INTEGERSIZE, IR.DATATYPE.UINT ) )

    expr = astNewIDX( astNewVAR( tbsym, NULL, -minval*FB.INTEGERSIZE, IR.DATATYPE.UINT ), idxexpr, _
    				  IR.DATATYPE.UINT, NULL )

    astFlush( astNewBRANCH( IR.OP.JUMPPTR, NULL, expr ) )

    '' emit table
    irEmitLABEL tbsym, FALSE

    ''!!!FIXME!!! parser shouldn't call IR directly, always use the AST
    irFlush( )

    ''
    l = swtbase
    for value = minval to maxval
    	if( value = ctx.swt.caseTB(l).value ) then
    		emitTYPE( IR.DATATYPE.UINT, symbGetName( ctx.swt.caseTB(l).label ) )
    		l += 1
    	else
    		emitTYPE( IR.DATATYPE.UINT, symbGetName( deflabel ) )
    	end if
    next value

    '' the table is not needed anymore
    symbDelVar( tbsym )

    ctx.swt.base = swtbase

    '' emit exit label
    irEmitLABEL( exitlabel, FALSE )
    '''''symbDelLabel exitlabel

	'' END SELECT
	if( (not hMatch( FB.TK.END )) or (not hMatch( FB.TK.SELECT )) ) then
		hReportError FB.ERRMSG.EXPECTEDENDSELECT
		exit function
	end if

	env.lastcompound = lastcompstmt

	function = TRUE

end function

'':::::
''ExitStatement	  =	  EXIT (FOR | DO | WHILE | SUB | FUNCTION)
''
function cExitStatement as integer
    dim label as FBSYMBOL ptr

	function = FALSE

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
	astFlush( astNewBRANCH( IR.OP.JMP, label ) )

	function = TRUE

end function

'':::::
''ContinueStatement	  =	  CONTINUE (FOR | DO | WHILE)
''
function cContinueStatement as integer
    dim label as FBSYMBOL ptr

	function = FALSE

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
	astFlush( astNewBRANCH( IR.OP.JMP, label ) )

	function = TRUE

end function

'':::::
''EndStatement	  =	  END (Expression | Keyword | ) .
''
function cEndStatement as integer
	dim as ASTNODE ptr errlevel

	function = FALSE

	if( lexCurrentToken <> FB.TK.END ) then
		exit function
	end if

	'' any compound END will be parsed by the compound stmt
	if( lexLookAheadClass(1) = FB.TKCLASS.KEYWORD ) then

		if( env.compoundcnt = 1 ) then
			hReportError FB.ERRMSG.ILLEGALEND
			exit function
		end if

		return TRUE

	else
		lexSkipToken							'' END
	end if

  	'' (Expression | )
  	select case lexCurrentToken
  	case FB.TK.STATSEPCHAR, FB.TK.EOL, FB.TK.EOF, FB.TK.COMMENTCHAR, FB.TK.REM
  		errlevel = astNewCONSTi( 0, IR.DATATYPE.INTEGER )
  	case else
  		if( not cExpression( errlevel ) ) then
  		end if
  	end select

    ''
	function = rtlExit( errlevel )

end function


'':::::
''CompoundStmtElm  =  WEND | LOOP | NEXT | CASE | ELSE | ELSEIF .
''
function cCompoundStmtElm as integer
    dim comp as integer

	function = FALSE

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

	function = TRUE

end function

'':::::
private function hReadWithText( byval text as string ) as integer
    static as zstring * FB.MAXNAMELEN+1 id
    dim as FBSYMBOL ptr sym
    dim as integer dpos

    ''
    dpos = lexTokenDotpos( )
    id = lexTokenText( )

    if( dpos > 0 ) then
    	id[dpos-1] = 0 							'' left$( id, dpos-1 )
    end if

    sym = symbFindByNameAndClass( id, FB.SYMBCLASS.VAR )
    if( sym = NULL ) then
    	hReportError( FB.ERRMSG.EXPECTEDIDENTIFIER )
    	return FALSE
    end if

	if( sym->typ <> FB.SYMBTYPE.USERDEF ) then
		hReportError( FB.ERRMSG.EXPECTEDIDENTIFIER )
		return FALSE
	end if

    ''
    text = lexEatToken( )

    do
    	select case lexCurrentToken( )
		case FB.TK.EOL, FB.TK.STATSEPCHAR, FB.TK.COMMENTCHAR, FB.TK.REM, FB.TK.EOF
			exit do
		end select

    	text += lexEatToken
    loop

	return TRUE

end function

'':::::
''WithStatement   =   WITH Variable Comment?
''					  SimpleLine*
''					  END WITH .
''
function cWithStatement as integer
    dim as zstring * FB.MAXWITHLEN+1 oldwithtext
    dim as integer lastcompstmt

	function = FALSE

	if( ctx.withcnt >= FB.MAXWITHLEVELS ) then
		hReportError( FB.ERRMSG.RECLEVELTOODEPTH )
		exit function
	end if

	'' WITH
	lexSkipToken( )

	'' save old
	oldwithtext = env.withtext

	'' Variable

	if( not hReadWithText( env.withtext ) ) then
		exit function
	end if

	'' Comment?
	cComment( )

	'' separator
	if( not cSttSeparator ) then
		env.withtext = oldwithtext
		hReportError FB.ERRMSG.EXPECTEDEOL
		exit function
	end if

	''
	lastcompstmt     = env.lastcompound
	env.lastcompound = FB.TK.WITH

	ctx.withcnt += 1

	'' loop body
	do
	loop while( (cSimpleLine( )) and (lexCurrentToken( ) <> FB.TK.EOF) )

	'' restore old
	env.withtext = oldwithtext

	ctx.withcnt -= 1

	''
	env.lastcompound = lastcompstmt

	'' END WITH
	if( (not hMatch( FB.TK.END )) or (not hMatch( FB.TK.WITH )) ) then
		hReportError( FB.ERRMSG.EXPECTEDENDWITH )
		exit function
	end if

	function = TRUE

end function

