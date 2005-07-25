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
#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"
#include once "inc\ir.bi"
#include once "inc\emit.bi"

const FB_CASETYPE_RANGE = 1
const FB_CASETYPE_IS    = 2
const FB_CASETYPE_ELSE  = 3

const FB_MAXCASEEXPR 	= 1024
const FB_MAXSWTCASEEXPR = 8192

const FB_MAXSWTCASERANGE= 4096

type FBCASECTX
	typ 		as integer
	op 			as integer
	expr1		as ASTNODE ptr
	expr2		as ASTNODE ptr
end type

type FBSELECTCTX
	base		as integer
	caseTB(0 to FB_MAXCASEEXPR-1) as FBCASECTX
end type

type FBSWTCASECTX
	label		as FBSYMBOL ptr
	value		as uinteger
end type

type FBSWITCHCTX
	base		as integer
	caseTB(0 to FB_MAXSWTCASEEXPR-1) as FBSWTCASECTX
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

	select case as const lexGetToken
	case FB_TK_IF
		function = cIfStatement( )
	case FB_TK_FOR
		function = cForStatement( )
	case FB_TK_DO
		function = cDoStatement( )
	case FB_TK_WHILE
		function = cWhileStatement( )
	case FB_TK_ELSE, FB_TK_ELSEIF, FB_TK_CASE, FB_TK_LOOP, FB_TK_NEXT, FB_TK_WEND
		function = cCompoundStmtElm( )
	case FB_TK_SELECT
		function = cSelectStatement( )
	case FB_TK_EXIT
		function = cExitStatement( )
	case FB_TK_CONTINUE
		function = cContinueStatement( )
	case FB_TK_END
		function = cEndStatement( )
	case FB_TK_WITH
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
	select case lexGetToken
	case FB_TK_COMMENTCHAR, FB_TK_REM, FB_TK_EOL
		exit function
	end select

	'' add end and next label (at ELSE/ELSEIF)
	nl = symbAddLabel( "" )
	el = symbAddLabel( "" )

	''
	lastcompstmt = env.lastcompound
	env.lastcompound = FB_TK_IF

	'' branch
	expr = astUpdComp2Branch( expr, nl, FALSE )
	if( expr = NULL ) then
		hReportError FB_ERRMSG_INVALIDDATATYPES
		exit function
	end if

	astAdd( expr )

	'' NUM_LIT | SimpleStatement*
	if( lexGetClass = FB_TKCLASS_NUMLITERAL ) then
		l = symbFindByClass( lexGetSymbol, FB_SYMBCLASS_LABEL )
		if( l = NULL ) then
			l = symbAddLabel( *lexGetText( ), FALSE, TRUE )
		end if
		lexSkipToken( )

		astAdd( astNewBRANCH( IR_OP_JMP, l ) )

	elseif( not cSimpleStatement ) then
		if( hGetLastError <> FB_ERRMSG_OK ) then
			exit function
		end if
	end if

	'' (ELSE SimpleStatement*)?
	if( hMatch( FB_TK_ELSE ) ) then

		'' exit if stmt
		astAdd( astNewBRANCH( IR_OP_JMP, el ) )

		'' emit next label
		astAdd( astNewLABEL( nl ) )

		'' SimpleStatement|IF*
		if( not cSimpleStatement ) then
			exit function
		end if

		'' emit end label
		astAdd( astNewLABEL( el ) )

	else
		'' emit next label
		astAdd( astNewLABEL( nl ) )
	end if

	'' END IF? -- added to make complex macros easier to be done
	if( lexGetToken = FB_TK_END ) then
		if( lexGetLookAhead(1) = FB_TK_IF ) then
			lexSkipToken
			lexSkipToken
		end if
	end if

	''
	env.lastcompound = lastcompstmt

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
		hReportError FB_ERRMSG_INVALIDDATATYPES
		exit function
	end if
	astAdd( expr )

	if( checkstmtsep ) then
		'' Comment?
		cComment

		'' separator
		if( not cStmtSeparator ) then
			hReportError FB_ERRMSG_EXPECTEDEOL
			exit function
		end if
	end if

	'' loop body
	do
	loop while( (cSimpleLine) and (lexGetToken <> FB_TK_EOF) )

	if( hGetLastError = FB_ERRMSG_OK ) then
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
	select case lexGetToken
	case FB_TK_COMMENTCHAR, FB_TK_REM, FB_TK_EOL
	case else
		exit function
	end select

	'' add end label (at ENDIF)
	el = symbAddLabel( "" )

	'' add next label (at ELSE/ELSEIF)
	nl = symbAddLabel( "" )

	''
	lastcompstmt = env.lastcompound
	env.lastcompound = FB_TK_IF

	if( not cIfStmtBody( expr, nl, el ) ) then
		exit function
	end if

	'' (ELSEIF Expression THEN SimpleLine*)?
    do while( hMatch( FB_TK_ELSEIF ) )

		'' exit last if stmt
		astAdd( astNewBRANCH( IR_OP_JMP, el ) )

		'' emit next label
		astAdd( astNewLABEL( nl ) )

		'' add next label (at ELSE/ELSEIF)
		nl = symbAddLabel( "" )

	    '' Expression
    	if( not cExpression( expr ) ) then
    		hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
    		exit function
    	end if

		'' THEN
		if( not hMatch( FB_TK_THEN ) ) then
			hReportError FB_ERRMSG_EXPECTEDTHEN
			exit function
		end if

		if( not cIfStmtBody( expr, nl, el, FALSE ) ) then
			exit function
		end if

    loop

	'' (ELSE SimpleLine*)?
	if( hMatch( FB_TK_ELSE ) ) then

		'' exit last if stmt
		astAdd( astNewBRANCH( IR_OP_JMP, el ) )

		'' emit next label
		astAdd( astNewLABEL( nl ) )

		'' loop body
		do
		loop while( (cSimpleLine) and (lexGetToken <> FB_TK_EOF) )

	else
		'' emit next label
		astAdd( astNewLABEL( nl ) )
	end if

	'' emit end label
	astAdd( astNewLABEL( el ) )

	'' ENDIF or END IF
    if( not hMatch( FB_TK_ENDIF ) ) then
        if( (not hMatch( FB_TK_END )) or (not hMatch( FB_TK_IF )) ) then
            hReportError FB_ERRMSG_EXPECTEDENDIF
            exit function
        end if
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
	lexSkipToken( )

    '' Expression
    if( not cExpression( expr ) ) then
    	hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
    	exit function
    end if

	'' THEN
	if( hMatch( FB_TK_THEN ) ) then

		'' (BlockIfStatement | SingleIfStatement)
		if( not cBlockIfStatement( expr ) ) then
			if( hGetLastError = FB_ERRMSG_OK ) then
				if( not cSingleIfStatement( expr ) ) then
					hReportError FB_ERRMSG_SYNTAXERROR
					exit function
				end if
			end if
		end if

	else

		'' GOTO
		if( lexGetToken <> FB_TK_GOTO ) then
			hReportError FB_ERRMSG_EXPECTEDTHEN
			exit function
		end if

		if( not cSingleIfStatement( expr ) ) then
			hReportError FB_ERRMSG_SYNTAXERROR
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
	astAdd( astNewASSIGN( vexpr, expr ) )

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
		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
			expr1 = astNewCONST64( val1->value64, dtype )
		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			expr1 = astNewCONSTf( val1->valuef, dtype )
		case else
			expr1 = astNewCONSTi( val1->valuei, dtype )
		end select
	end if

	if( v2 <> NULL ) then
		expr2 = astNewVAR( v2, NULL, 0, dtype )
	else
		select case as const dtype
		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
			expr2 = astNewCONST64( val2->value64, dtype )
		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			expr2 = astNewCONSTf( val2->valuef, dtype )
		case else
			expr2 = astNewCONSTi( val2->valuei, dtype )
		end select
	end if

	expr = astNewBOP( op, expr1, expr2, ex, FALSE )

	''
	astAdd( expr )

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
		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
			expr2 = astNewCONST64( val2->value64, dtype )
		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
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
	astAdd( expr )

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
		hReportError FB_ERRMSG_EXPECTEDVAR
		exit function
	end if

	if( (not astIsVAR( idexpr )) or (elm <> NULL) ) then
		hReportError FB_ERRMSG_EXPECTEDSCALAR, TRUE
		exit function
	end if

	typ = symbGetType( cnt )

	if( (typ < FB_SYMBTYPE_BYTE) or (typ > FB_SYMBTYPE_DOUBLE) ) then
		hReportError FB_ERRMSG_EXPECTEDSCALAR, TRUE
		exit function
	end if

	'' =
	if( not hMatch( FB_TK_ASSIGN ) ) then
		hReportError FB_ERRMSG_EXPECTEDEQ
		exit function
	end if

	'' get counter type (endc and step must be the same type)
	dtype  = typ
	dclass = irGetDataClass( dtype )
	isconst = 0

    '' Expression
    if( not cExpression( expr ) ) then
    	hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
    	exit function
    end if

	''
	if( astIsCONST( expr ) ) then
		astConvertValue( expr, @ival, dtype )
		isconst += 1
	end if

	'' save initial condition into counter
	expr = astNewASSIGN( idexpr, expr )
	astAdd( expr )

	'' TO
	if( not hMatch( FB_TK_TO ) ) then
		hReportError FB_ERRMSG_EXPECTEDTO
		exit function
	end if

	'' end condition (Expression)
	if( not cExpression( expr ) ) then
		hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
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
	if( lexGetToken( ) = FB_TK_STEP ) then
		lexSkipToken( )
		if( not cExpression( expr ) ) then
			hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
			exit function
		end if

		'' store step into a temp var
		if( astIsCONST( expr ) ) then
			select case as const astGetDataType( expr )
			case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
				ispositive = (astGetValue64( expr ) >= 0)
			case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
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

			astAdd( astNewASSIGN( astNewVAR( stp, NULL, 0, dtype ), expr ) )

		else
            '' get constant step
            astConvertValue( expr, @sval, dtype )
			astDel expr
			stp = NULL
			isconst += 1
		end if

	else
		select case as const dtype
		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
			sval.value64 = 1
		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			sval.valuef = 1.0
		case else
			sval.valuei = 1
		end select
		stp = NULL
		isconst += 1
	end if

	'' labels
    tl = symbAddLabel( "" )
	'' add comp and end label (will be used by any CONTINUE/EXIT FOR)
	cl = symbAddLabel( "" )
	el = symbAddLabel( "" )

    '' if inic, endc and stepc are all constants,
    '' check if this branch is needed
    if( isconst = 3 ) then

		if( ispositive ) then
			op = IR_OP_LE
    	else
			op = IR_OP_GE
    	end if

    	expr = astNewBOP( op, astNewCONST( @ival, dtype ), astNewCONST( @eval, dtype ) )
    	if( not astGetValueI( expr ) ) then
    		astAdd( astNewBRANCH( IR_OP_JMP, el ) )
    	end if
    	astDel expr

    else
    	astAdd( astNewBRANCH( IR_OP_JMP, tl ) )
    end if

	'' add start label
	il = symbAddLabel( "" )
	astAdd( astNewLABEL( il ) )

	'' save old for stmt info
	oldforstmt = env.forstmt

	env.forstmt.cmplabel = cl
	env.forstmt.endlabel = el

	''
	lastcompstmt = env.lastcompound
	env.lastcompound = FB_TK_FOR

	'' Comment?
	cComment

	'' separator
	if( not cStmtSeparator ) then
		hReportError FB_ERRMSG_EXPECTEDEOL
		exit function
	end if

	'' loop body
	do
	loop while( (cSimpleLine) and (lexGetToken <> FB_TK_EOF) )

	'' NEXT
	if( not hMatch( FB_TK_NEXT ) ) then
		hReportError FB_ERRMSG_EXPECTEDNEXT
		exit function
	end if

	'' counter?
	if( lexGetClass = FB_TKCLASS_IDENTIFIER ) then
		lexSkipToken

		'' ( ',' counter? )*
		if( lexGetToken = CHAR_COMMA ) then
			'' hack to handle multiple identifiers...
			lexSetToken FB_TK_NEXT, FB_TKCLASS_KEYWORD
		end if
	end if

	'' cmp label
	astAdd( astNewLABEL( cl ) )

	'' counter += step
	cFlushSelfBOP( IR_OP_ADD, dtype, cnt, stp, @sval )

	'' test label
	astAdd( astNewLABEL( tl ) )

    if( not iscomplex ) then

		if( ispositive ) then
			op = IR_OP_LE
    	else
			op = IR_OP_GE
    	end if

    	'' counter <= or >= end cond?
		cFlushBOP( op, dtype, cnt, NULL, endc, @eval, il )

		c2l = NULL
    else
		c2l = symbAddLabel( "" )

    	'' test step sign and branch
		select case as const dtype
		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
			ival.value64 = 0
		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			ival.valuef = 0.0
		case else
			ival.valuei = 0
		end select

		cFlushBOP( IR_OP_GE, dtype, stp, @sval, NULL, @ival, c2l )

    	'' negative, loop if >=
		cFlushBOP( IR_OP_GE, dtype, cnt, NULL, endc, @eval, il )
		'' exit loop
		astAdd( astNewBRANCH( IR_OP_JMP, el ) )
    	'' control label
    	astAdd( astNewLABEL( c2l, FALSE ) )
    	'' positive, loop if <=
		cFlushBOP( IR_OP_LE, dtype, cnt, NULL, endc, @eval, il )
    end if

    '' end label (loop exit)
    astAdd( astNewLABEL( el ) )

	'' restore old for stmt info
	env.forstmt = oldforstmt

	''
	env.lastcompound = lastcompstmt

	function = TRUE

end function

'':::::
''DoStatement     =   DO ((WHILE | UNTIL) Expression)? Comment? SttSeparator
''					  SimpleLine*
''					  LOOP ((WHILE | UNTIL) Expression)? .
''
function cDoStatement as integer
    dim as ASTNODE ptr expr
	dim as integer iswhile, isuntil, isinverse, lastcompstmt, op
    dim as FBSYMBOL ptr il, el, cl
    dim as FBCMPSTMT olddostmt

	function = FALSE

	'' DO
	lexSkipToken

	'' add ini and end labels (will be used by any EXIT DO)
	il = symbAddLabel( "" )
	el = symbAddLabel( "" )

	'' emit ini label
	astAdd( astNewLABEL( il ) )

	'' ((WHILE | UNTIL) Expression)?
	iswhile = FALSE
	isuntil = fALSE

	select case lexGetToken
	case FB_TK_WHILE
		iswhile = TRUE
	case FB_TK_UNTIL
		isuntil = TRUE
	end select

	if( iswhile or isuntil ) then
		lexSkipToken( )

		'' Expression
		if( not cExpression( expr ) ) then
			hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
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
			hReportError( FB_ERRMSG_INVALIDDATATYPES )
			exit function
		end if

		astAdd( expr )
		cl = il

	else
		expr = NULL
		cl = symbAddLabel( "" )
	end if

	'' save old do stmt info
	olddostmt = env.dostmt

	env.dostmt.cmplabel = cl
	env.dostmt.endlabel = el

	''
	lastcompstmt = env.lastcompound
	env.lastcompound = FB_TK_DO

	'' Comment?
	cComment

	'' separator
	if( not cStmtSeparator ) then
		hReportError FB_ERRMSG_EXPECTEDEOL
		exit function
	end if

	'' loop body
	do
	loop while( (cSimpleLine) and (lexGetToken <> FB_TK_EOF) )

	'' LOOP
	if( not hMatch( FB_TK_LOOP ) ) then
		hReportError FB_ERRMSG_EXPECTEDLOOP
		exit function
	end if

	'' ((WHILE | UNTIL | SttSeparator) Expression)?
	iswhile = FALSE
	isuntil = fALSE

	select case lexGetToken
	case FB_TK_WHILE
		iswhile = TRUE
	case FB_TK_UNTIL
		isuntil = TRUE
	end select

	if( (iswhile or isuntil) and (expr <> NULL) ) then
		hReportError( FB_ERRMSG_SYNTAXERROR )
		exit function
	end if

	'' emit comp label, if needed
	if( cl <> il ) then
		astAdd( astNewLABEL( cl ) )
	end if

	if( iswhile or isuntil ) then
		lexSkipToken( )

		'' Expression
		if( not cExpression( expr ) ) then
			hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
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
			hReportError( FB_ERRMSG_INVALIDDATATYPES )
			exit function
		end if
		astAdd( expr )

	else
		astAdd( astNewBRANCH( IR_OP_JMP, il ) )
	end if

    '' end label (loop exit)
    astAdd( astNewLABEL( el ) )

	'' restore old for stmt info
	env.dostmt = olddostmt

	''
	env.lastcompound = lastcompstmt

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
	il = symbAddLabel( "" )
	el = symbAddLabel( "" )

	'' save old while stmt info
	oldwhilestmt = env.whilestmt

	env.whilestmt.cmplabel = il
	env.whilestmt.endlabel = el

	''
	lastcompstmt = env.lastcompound
	env.lastcompound = FB_TK_WHILE

	'' emit ini label
	astAdd( astNewLABEL( il ) )

	'' Expression
	if( not cExpression( expr ) ) then
		hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
		exit function
	end if

	'' branch
	expr = astUpdComp2Branch( expr, el, FALSE )
	if( expr = NULL ) then
		hReportError FB_ERRMSG_INVALIDDATATYPES
		exit function
	end if
	astAdd( expr )

	'' Comment?
	cComment

	'' separator
	if( not cStmtSeparator ) then
		hReportError FB_ERRMSG_EXPECTEDEOL
		exit function
	end if

	'' loop body
	do
	loop while( (cSimpleLine) and (lexGetToken <> FB_TK_EOF) )

	'' WEND
	if( not hMatch( FB_TK_WEND ) ) then
		hReportError FB_ERRMSG_EXPECTEDWEND
		exit function
	end if

    astAdd( astNewBRANCH( IR_OP_JMP, il ) )

    '' end label (loop exit)
    astAdd( astNewLABEL( el ) )

	'' restore old while stmt info
	env.whilestmt = oldwhilestmt

	''
	env.lastcompound = lastcompstmt

	function = TRUE

end function

'':::::
''SelectStatement =   SELECT CASE (AS CONST)? Expression Comment? SttSeparator
''					   cComment? cStmtSeparator? CaseStatement*
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
	if( not hMatch( FB_TK_CASE ) ) then
		hReportError FB_ERRMSG_EXPECTEDCASE
		exit function
	end if

	'' AS?
	if( hMatch( FB_TK_AS ) ) then
		'' CONST?
		if( hMatch( FB_TK_CONST ) ) then
			function = cSelectConstStmt( )
		else
			hReportError FB_ERRMSG_SYNTAXERROR
		end if
		exit function
	end if

	'' Expression
	if( not cExpression( expr ) ) then
		hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
		exit function
	end if

	'' can't be an UDT
	if( astGetDataType( expr ) = IR_DATATYPE_USERDEF ) then
		hReportError FB_ERRMSG_INVALIDDATATYPES
		exit function
	end if

	'' Comment?
	cComment

	'' separator
	if( not cStmtSeparator ) then
		hReportError FB_ERRMSG_EXPECTEDEOL
		exit function
	end if

	'' save current context
	lastcompstmt = env.lastcompound
	env.lastcompound = FB_TK_SELECT

	'' add exit label
	elabel = symbAddLabel( "" )

	'' store expression into a temp var
	dtype  = astGetDataType( expr )
	if( (dtype = FB_SYMBTYPE_FIXSTR) or (dtype = FB_SYMBTYPE_CHAR) ) then
		dtype = FB_SYMBTYPE_STRING
	end if

	symbol = symbAddTempVar( dtype )
	if( symbol = NULL ) then
		exit function
	end if

	expr = astNewASSIGN( astNewVAR( symbol, NULL, 0, dtype ), expr )
	if( expr = NULL ) then
		exit function
	end if
	astAdd( expr )

	'' SelectLine*
	do

    	'' Comment? SttSeparator?
    	do while( cComment or cStmtSeparator )
    	loop

    	'' CaseStatement
    	if( not cCaseStatement( symbol, dtype, elabel ) ) then
	    	exit do
    	end if

	loop while( lexGetToken <> FB_TK_EOF )

    '' emit exit label
    astAdd( astNewLABEL( elabel ) )

	'' END SELECT
	if( (not hMatch( FB_TK_END )) or (not hMatch( FB_TK_SELECT )) ) then
		hReportError FB_ERRMSG_EXPECTEDENDSELECT
		exit function
	end if

	'' if a temp string was allocated, delete it
	if( dtype = FB_SYMBTYPE_STRING ) then
		expr = rtlStrDelete( astNewVAR( symbol, NULL, 0, dtype ) )
		astAdd( expr )
	end if

	env.lastcompound = lastcompstmt

	function = TRUE

end function

'':::::
''CaseExpression  =   (Expression (TO Expression)?)?
''				  |   (IS REL_OP Expression)? .
''
function cCaseExpression( byref casectx as FBCASECTX ) as integer

	function = FALSE

	casectx.op 	= IR_OP_EQ

	'' IS REL_OP Expression
	if( hMatch( FB_TK_IS ) ) then
		casectx.op = hFBrelop2IRrelop( lexGetToken )
		lexSkipToken
		casectx.typ = FB_CASETYPE_IS
	else
		casectx.typ = 0
	end if

	'' Expression
	if( not cExpression( casectx.expr1 ) ) then
		hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
		exit function
	end if

	'' TO Expression
	if( hMatch( FB_TK_TO ) ) then
		if( casectx.typ <> 0 ) then
			hReportError FB_ERRMSG_SYNTAXERROR
			exit function
		end if

		if( not cExpression( casectx.expr2 ) ) then
			hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
			exit function
		end if

		casectx.typ =  FB_CASETYPE_RANGE
	end if

	function = TRUE

end function

'':::::
private function hExecCaseExpr( byref casectx as FBCASECTX, _
				           	    byval s as FBSYMBOL ptr, _
				           	    byval sdtype as integer, _
				           	    byval initlabel as FBSYMBOL ptr, _
				           	    byval nextlabel as FBSYMBOL ptr, _
				           		byval inverselogic as integer ) as integer static

	dim as ASTNODE ptr expr, v

	if( casectx.typ <> FB_CASETYPE_RANGE ) then
		v = astNewVAR( s, NULL, 0, sdtype )

		if( not inverselogic ) then
			expr = astNewBOP( casectx.op, v, casectx.expr1, initlabel, FALSE )
		else
			expr = astNewBOP( irGetInverseLogOp( casectx.op ), v, casectx.expr1, nextlabel, FALSE )
		end if

		astAdd( expr )

	else
		v = astNewVAR( s, NULL, 0, sdtype )
		expr = astNewBOP( IR_OP_LT, v, casectx.expr1, nextlabel, FALSE )
		astAdd( expr )

		if( expr = NULL ) then
			return FALSE
		end if

		v = astNewVAR( s, NULL, 0, sdtype )
		if( not inverselogic ) then
			expr = astNewBOP( IR_OP_LE, v, casectx.expr2, initlabel, FALSE )
		else
			expr = astNewBOP( IR_OP_GT, v, casectx.expr2, nextlabel, FALSE )
		end if
		astAdd( expr )
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
	if( not hMatch( FB_TK_CASE ) ) then
		exit function
	end if

	'' add labels
	il = symbAddLabel( "" )

	'' CaseExpression (COMMA CaseExpression)*
	cnt = 0
	cntbase = ctx.sel.base

	do
		if( cnt = 0 ) then
			if( hMatch( FB_TK_ELSE ) ) then
				ctx.sel.caseTB(cntbase + cnt).typ = FB_CASETYPE_ELSE
				cnt = 1
				exit do
			end if
		end if

		if( not cCaseExpression( ctx.sel.caseTB(cntbase + cnt) ) ) then
			hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
			exit function
		end if

		cnt += 1

	loop while( hMatch( CHAR_COMMA ) )

	'' Comment?
	cComment

	'' SttSeparator
	if( not cStmtSeparator( ) ) then
		exit function
	end if

	if( hGetLastError( ) <> FB_ERRMSG_OK ) then
		exit function
	end if

	''
	ctx.sel.base += cnt

	for i = cntbase to cntbase + cnt-1

		'' add next label
		nl = symbAddLabel( "" )

		if( ctx.sel.caseTB(i).typ <> FB_CASETYPE_ELSE ) then
			if( not hExecCaseExpr( ctx.sel.caseTB(i), s, sdtype, il, nl, i = cntbase ) ) then
				hReportError FB_ERRMSG_INVALIDDATATYPES, TRUE
				exit function
			end if
		end if

		if( i = cntbase ) then
			''
			astAdd( astNewLABEL( il ) )

			'' SimpleLine*
			do
				res = cSimpleLine
			loop while( (res) and (lexGetToken <> FB_TK_EOF) )

			if( ctx.sel.caseTB(i).typ = FB_CASETYPE_ELSE ) then
				exit for
			end if

			'' break from block
			astAdd( astNewBRANCH( IR_OP_JMP, exitlabel ) )

		end if

		'' emit next label
		astAdd( astNewLABEL( nl ) )

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
	if( ctx.swt.base >= FB_MAXSWTCASEEXPR ) then
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
						    byref minval as uinteger, _
						    byref maxval as uinteger, _
						    byref deflabel as FBSYMBOL ptr ) as integer

	dim as ASTNODE ptr expr1, expr2
	dim as uinteger value, tovalue
	dim as FBSYMBOL ptr label

	function = FALSE

	'' CASE
	if( not hMatch( FB_TK_CASE ) ) then
		exit function
	end if

	'' ELSE
	if( hMatch( FB_TK_ELSE ) ) then
		deflabel = symbAddLabel( "" )
		astAdd( astNewLABEL( deflabel ) )

	else

		'' add label
		label = symbAddLabel( "" )

		'' ConstExpression (COMMA ConstExpression (TO ConstExpression)?)*
		do
			if( not cExpression( expr1 ) ) then
				hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
				exit function
			end if

			if( not astIsCONST( expr1 ) ) then
				hReportError FB_ERRMSG_EXPECTEDCONST
				exit function
			end if

			value = astGetValueAsInt( expr1 )
			astDel( expr1 )

			'' TO?
			if( hMatch( FB_TK_TO ) ) then
				if( not cExpression( expr2 ) ) then
					hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
					exit function
				end if

				if( not astIsCONST( expr2 ) ) then
					hReportError FB_ERRMSG_EXPECTEDCONST
					exit function
				end if

				tovalue = astGetValueAsInt( expr2 )
				astDel( expr2 )

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
		astAdd( astNewLABEL( label ) )

	end if

	'' Comment?
	cComment

	'' SttSeparator
	if( not cStmtSeparator ) then
		exit function
	end if

	'' SimpleLine*
	do
	loop while( cSimpleLine and (lexGetToken <> FB_TK_EOF) )

	if( hGetLastError <> FB_ERRMSG_OK ) then
		exit function
	end if

	'' break from block
	astAdd( astNewBRANCH( IR_OP_JMP, exitlabel ) )

	function = TRUE

end function

'':::::
''SelectConstStmt =   SELECT CASE AS CONST Expression{int} Comment? SttSeparator
''					   cComment? cStmtSeparator? SelConstCaseStmt*
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
		hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
		exit function
	end if

	if( astGetDataClass( expr ) <> IR_DATACLASS_INTEGER ) then
		hReportError( FB_ERRMSG_INVALIDDATATYPES )
		exit function
	end if

	if( astGetDataType( expr ) <> IR_DATATYPE_UINT ) then
		expr = astNewCONV( INVALID, IR_DATATYPE_UINT, NULL, expr )
	end if

	'' Comment?
	cComment( )

	'' separator
	if( not cStmtSeparator ) then
		hReportError( FB_ERRMSG_EXPECTEDEOL )
		exit function
	end if

	'' save current context
	lastcompstmt = env.lastcompound
	env.lastcompound = FB_TK_SELECT

	'' add labels
	exitlabel = symbAddLabel( "" )
	complabel = symbAddLabel( "" )

	'' store expression into a temp var
	sym = symbAddTempVar( FB_SYMBTYPE_UINT )
	if( sym = NULL ) then
		exit function
	end if

	expr = astNewASSIGN( astNewVAR( sym, NULL, 0, IR_DATATYPE_UINT ), expr )
	if( expr = NULL ) then
		exit function
	end if
	astAdd( expr )

	'' skip the statements
	astAdd( astNewBRANCH( IR_OP_JMP, complabel ) )

	'' SwitchLine*
	swtbase = ctx.swt.base
	deflabel = NULL
	minval = &hFFFFFFFF
	maxval = 0
	do
    	'' Comment? SttSeparator?
    	do while( cComment or cStmtSeparator )
    	loop

    	'' SelConstCaseStmt
    	if( not cSelConstCaseStmt( swtbase, sym, exitlabel, minval, maxval, deflabel ) ) then
	    	exit do
    	end if

	loop while( lexGetToken <> FB_TK_EOF )

    '' too large?
    if( (minval > maxval) or (maxval - minval > FB_MAXSWTCASERANGE) ) then
    	hReportError( FB_ERRMSG_RANGETOOLARGE )
    	exit function
    end if

    if( deflabel = NULL ) then
    	deflabel = exitlabel
    end if

    '' emit comp label
    astAdd( astNewLABEL( complabel ) )

	'' check min val
	if( minval > 0 ) then
		expr = astNewBOP( IR_OP_LT, _
						  astNewVAR( sym, NULL, 0, IR_DATATYPE_UINT ), _
						  astNewCONSTi( minval, IR_DATATYPE_UINT ), _
						  deflabel, FALSE )
		astAdd( expr )
	end if

	'' check max val
	expr = astNewBOP( IR_OP_GT, _
					  astNewVAR( sym, NULL, 0, IR_DATATYPE_UINT ), _
					  astNewCONSTi( maxval, IR_DATATYPE_UINT ), _
					  deflabel, FALSE )
	astAdd( expr )

    '' jump to table[idx]
    tbsym = hJumpTbAllocSym( )

	idxexpr = astNewBOP( IR_OP_MUL, _
						 astNewVAR( sym, NULL, 0, IR_DATATYPE_UINT ), _
    				  	 astNewCONSTi( FB_INTEGERSIZE, IR_DATATYPE_UINT ) )

    expr = astNewIDX( astNewVAR( tbsym, NULL, -minval*FB_INTEGERSIZE, IR_DATATYPE_UINT ), _
    				  idxexpr, IR_DATATYPE_UINT, NULL )

    astAdd( astNewBRANCH( IR_OP_JUMPPTR, NULL, expr ) )

    '' emit table
    astAdd( astNewLABEL( tbsym ) )

    ''
    l = swtbase
    for value = minval to maxval
    	if( value = ctx.swt.caseTB(l).value ) then
    		astAdd( astNewJMPTB( IR_DATATYPE_UINT, ctx.swt.caseTB(l).label ) )
    		l += 1
    	else
    		astAdd( astNewJMPTB( IR_DATATYPE_UINT, deflabel ) )
    	end if
    next value

    ctx.swt.base = swtbase

    '' emit exit label
    astAdd( astNewLABEL( exitlabel ) )

	'' END SELECT
	if( (not hMatch( FB_TK_END )) or (not hMatch( FB_TK_SELECT )) ) then
		hReportError FB_ERRMSG_EXPECTEDENDSELECT
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
	select case as const lexGetToken
	case FB_TK_FOR
		label = env.forstmt.endlabel

	case FB_TK_DO
		label = env.dostmt.endlabel

	case FB_TK_WHILE
		label = env.whilestmt.endlabel

	case FB_TK_SUB, FB_TK_FUNCTION
		label = env.procstmt.endlabel

		if( label = NULL ) then
			hReportError FB_ERRMSG_ILLEGALOUTSIDEASUB
			exit function
		end if

	case else
		hReportError FB_ERRMSG_ILLEGALOUTSIDEASTMT
		exit function
	end select

	''
	if( label = NULL ) then
		hReportError FB_ERRMSG_ILLEGALOUTSIDECOMP
		exit function
	end if

	lexSkipToken

	''
	astAdd( astNewBRANCH( IR_OP_JMP, label ) )

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
	select case as const lexGetToken
	case FB_TK_FOR
		label = env.forstmt.cmplabel

	case FB_TK_DO
		label = env.dostmt.cmplabel

	case FB_TK_WHILE
		label = env.whilestmt.cmplabel

	case else
		hReportError FB_ERRMSG_ILLEGALOUTSIDEASTMT
		exit function
	end select

	if( label = NULL ) then
		hReportError FB_ERRMSG_ILLEGALOUTSIDECOMP
		exit function
	end if

	lexSkipToken

	''
	astAdd( astNewBRANCH( IR_OP_JMP, label ) )

	function = TRUE

end function

'':::::
''EndStatement	  =	  END (Expression | Keyword | ) .
''
function cEndStatement as integer
	dim as ASTNODE ptr errlevel

	function = FALSE

	if( lexGetToken <> FB_TK_END ) then
		exit function
	end if

	'' any compound END will be parsed by the compound stmt
	if( lexGetLookAheadClass(1) = FB_TKCLASS_KEYWORD ) then

		if( env.compoundcnt = 1 ) then
			hReportError FB_ERRMSG_ILLEGALEND
			exit function
		end if

		return TRUE

	else
		lexSkipToken							'' END
	end if

  	'' (Expression | )
  	select case lexGetToken
  	case FB_TK_STATSEPCHAR, FB_TK_EOL, FB_TK_EOF, FB_TK_COMMENTCHAR, FB_TK_REM
  		errlevel = astNewCONSTi( 0, IR_DATATYPE_INTEGER )
  	case else
  		if( not cExpression( errlevel ) ) then
  			errlevel = NULL
  		end if
  	end select

    ''
	function = rtlExitRt( errlevel )

end function


'':::::
''CompoundStmtElm  =  WEND | LOOP | NEXT | CASE | ELSE | ELSEIF .
''
function cCompoundStmtElm as integer
    dim comp as integer

	function = FALSE

	'' WEND | LOOP | NEXT | CASE | ELSE | ELSEIF
	select case as const lexGetToken
	case FB_TK_WEND
		comp = FB_TK_WHILE
	case FB_TK_LOOP
		comp = FB_TK_DO
	case FB_TK_NEXT
		comp = FB_TK_FOR
	case FB_TK_CASE
		comp = FB_TK_SELECT
	case FB_TK_ELSE, FB_TK_ELSEIF
		comp = FB_TK_IF
	case else
		exit function
	end select

	if( comp <> env.lastcompound ) then
		hReportError FB_ERRMSG_ILLEGALOUTSIDECOMP
		exit function
	end if

	function = TRUE

end function

'':::::
private function hReadWithText( byval text as string ) as integer
    static as zstring * FB_MAXNAMELEN+1 id
    dim as FBSYMBOL ptr sym
    dim as integer dpos

    ''
    dpos = lexGetPeriodPos( )
    id = *lexGetText( )

    if( dpos > 0 ) then
    	id[dpos-1] = 0 							'' left$( id, dpos-1 )
    end if

    sym = symbFindByNameAndClass( id, FB_SYMBCLASS_VAR )
    if( sym = NULL ) then
    	hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
    	return FALSE
    end if

	if( sym->typ <> FB_SYMBTYPE_USERDEF ) then
		hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
		return FALSE
	end if

    ''
    lexEatToken( text )

    do
    	select case lexGetToken( )
		case FB_TK_EOL, FB_TK_STATSEPCHAR, FB_TK_COMMENTCHAR, FB_TK_REM, FB_TK_EOF
			exit do
		end select

    	text += *lexGetText( )
    	lexSkipToken( )
    loop

	return TRUE

end function

'':::::
''WithStatement   =   WITH Variable Comment?
''					  SimpleLine*
''					  END WITH .
''
function cWithStatement as integer
    dim as zstring * FB_MAXWITHLEN+1 oldwithtext
    dim as integer lastcompstmt

	function = FALSE

	if( ctx.withcnt >= FB_MAXWITHLEVELS ) then
		hReportError( FB_ERRMSG_RECLEVELTOODEPTH )
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
	if( not cStmtSeparator ) then
		env.withtext = oldwithtext
		hReportError FB_ERRMSG_EXPECTEDEOL
		exit function
	end if

	''
	lastcompstmt     = env.lastcompound
	env.lastcompound = FB_TK_WITH

	ctx.withcnt += 1

	'' loop body
	do
	loop while( (cSimpleLine( )) and (lexGetToken( ) <> FB_TK_EOF) )

	'' restore old
	env.withtext = oldwithtext

	ctx.withcnt -= 1

	''
	env.lastcompound = lastcompstmt

	'' END WITH
	if( (not hMatch( FB_TK_END )) or (not hMatch( FB_TK_WITH )) ) then
		hReportError( FB_ERRMSG_EXPECTEDENDWITH )
		exit function
	end if

	function = TRUE

end function

