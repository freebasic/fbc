''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2006 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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


'' FOR..NEXT compound statement parsing
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

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

	vexpr = astNewVAR( s, 0, dtype )
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
		expr1 = astNewVAR( v1, 0, dtype )
	else
		select case as const dtype
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			expr1 = astNewCONSTl( val1->long, dtype )
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			expr1 = astNewCONSTf( val1->float, dtype )
		case else
			expr1 = astNewCONSTi( val1->int, dtype )
		end select
	end if

	if( v2 <> NULL ) then
		expr2 = astNewVAR( v2, 0, dtype )
	else
		select case as const dtype
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			expr2 = astNewCONSTl( val2->long, dtype )
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			expr2 = astNewCONSTf( val2->float, dtype )
		case else
			expr2 = astNewCONSTi( val2->int, dtype )
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
	expr1 = astNewVAR( v1, 0, dtype )

	if( v2 <> NULL ) then
		expr2 = astNewVAR( v2, 0, dtype )
	else
		select case as const dtype
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			expr2 = astNewCONSTl( val2->long, dtype )
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			expr2 = astNewCONSTf( val2->float, dtype )
		case else
			expr2 = astNewCONSTi( val2->int, dtype )
		end select
	end if

	expr = astNewBOP( op, expr1, expr2 )

	'' assign
	expr1 = astNewVAR( v1, 0, dtype )

	expr = astNewASSIGN( expr1, expr )

	''
	astAdd( expr )

end sub

'':::::
''ForStmtBegin    =   FOR ID '=' Expression TO Expression (STEP Expression)? .
''
function cForStmtBegin as integer
    dim as FBSYMBOL ptr il, tl, el, cl
    dim as FBVALUE ival
    dim as ASTNODE ptr idexpr, expr
    dim as integer op, dtype, isconst
    dim as FB_CMPSTMTSTK ptr stk

	function = FALSE

	'' FOR
	lexSkipToken( )

	'' ID
	if( cVariable( idexpr ) = FALSE ) then
		hReportError( FB_ERRMSG_EXPECTEDVAR )
		exit function
	end if

	if( astIsVAR( idexpr ) = FALSE ) then
		hReportError( FB_ERRMSG_EXPECTEDSCALAR, TRUE )
		exit function
	end if

	stk = stackPush( @env.stmtstk )

	stk->for.cnt = astGetSymbol( idexpr )

	dtype = symbGetType( stk->for.cnt )

	if( (dtype < FB_DATATYPE_BYTE) or (dtype > FB_DATATYPE_DOUBLE) ) then
		stackPop( @env.stmtstk )
		hReportError( FB_ERRMSG_EXPECTEDSCALAR, TRUE )
		exit function
	end if

	'' =
	if( hMatch( FB_TK_ASSIGN ) = FALSE ) then
		stackPop( @env.stmtstk )
		hReportError( FB_ERRMSG_EXPECTEDEQ )
		exit function
	end if

	'' get counter type (endc and step must be the same type)
	isconst = 0

    '' Expression
    if( cExpression( expr ) = FALSE ) then
    	stackPop( @env.stmtstk )
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
	if( hMatch( FB_TK_TO ) = FALSE ) then
		stackPop( @env.stmtstk )
		hReportError( FB_ERRMSG_EXPECTEDTO )
		exit function
	end if

	'' end condition (Expression)
	if( cExpression( expr ) = FALSE ) then
		stackPop( @env.stmtstk )
		hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
		exit function
	end if

	''
	if( astIsCONST( expr ) ) then
		astConvertValue( expr, @stk->for.eval, dtype )
		astDelNode( expr )
		stk->for.endc = NULL
		isconst += 1

	'' store end condition into a temp var
	else
		stk->for.endc = cStoreTemp( expr, dtype )
	end if

	'' STEP
	stk->for.ispositive	= TRUE
	stk->for.iscomplex = FALSE

	if( lexGetToken( ) = FB_TK_STEP ) then
		lexSkipToken( )
		if( cExpression( expr ) = FALSE ) then
			stackPop( @env.stmtstk )
			hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
			exit function
		end if

		'' store step into a temp var
		if( astIsCONST( expr ) ) then
			select case as const astGetDataType( expr )
			case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
				stk->for.ispositive = (astGetValLong( expr ) >= 0)
			case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
				stk->for.ispositive = (astGetValFloat( expr ) >= 0)
			case else
				stk->for.ispositive = (astGetValInt( expr ) >= 0)
			end select
		else
			stk->for.iscomplex = TRUE
		end if

		if( stk->for.iscomplex ) then
			stk->for.stp = symbAddTempVar( dtype )
			astAdd( astNewASSIGN( astNewVAR( stk->for.stp, 0, dtype ), expr ) )

		else
            '' get constant step
            astConvertValue( expr, @stk->for.sval, dtype )
			astDelNode( expr )
			stk->for.stp = NULL
			isconst += 1
		end if

	else
		select case as const dtype
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			stk->for.sval.long = 1
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			stk->for.sval.float = 1.0
		case else
			stk->for.sval.int = 1
		end select
		stk->for.stp = NULL
		isconst += 1
	end if

	'' labels
    tl = symbAddLabel( NULL, FALSE )
	'' add comp and end label (will be used by any CONTINUE/EXIT FOR)
	cl = symbAddLabel( NULL, FALSE )
	el = symbAddLabel( NULL, FALSE )

    '' if inic, endc and stepc are all constants,
    '' check if this branch is needed
    if( isconst = 3 ) then
		if( stk->for.ispositive ) then
			op = AST_OP_LE
    	else
			op = AST_OP_GE
    	end if

    	expr = astNewBOP( op, _
    					  astNewCONST( @ival, dtype ), _
    					  astNewCONST( @stk->for.eval, dtype ) )

    	if( astGetValInt( expr ) = FALSE ) then
    		astAdd( astNewBRANCH( AST_OP_JMP, el ) )
    	end if

    	astDelNode( expr )

    else
    	astAdd( astNewBRANCH( AST_OP_JMP, tl ) )
    end if

	'' add start label
	il = symbAddLabel( NULL, TRUE )
	astAdd( astNewLABEL( il ) )

	'' push to stmt stack
	stk->last = env.stmt.for
	stk->id = FB_TK_FOR
	stk->for.testlabel = tl
	stk->for.inilabel = il

	env.stmt.for.cmplabel = cl
	env.stmt.for.endlabel = el

	function = TRUE

end function

'':::::
private function hForStmtClose( byval stk as FB_CMPSTMTSTK ptr ) as integer static
	dim as FBSYMBOL ptr cl
	dim as integer op, dtype
	dim as FBVALUE ival

	dtype = symbGetType( stk->for.cnt )

	'' cmp label
	astAdd( astNewLABEL( env.stmt.for.cmplabel ) )

	'' counter += step
	cFlushSelfBOP( AST_OP_ADD, dtype, _
				   stk->for.cnt, _
				   stk->for.stp, @stk->for.sval )

	'' test label
	astAdd( astNewLABEL( stk->for.testlabel ) )

    if( stk->for.iscomplex = FALSE ) then

		if( stk->for.ispositive ) then
			op = AST_OP_LE
    	else
			op = AST_OP_GE
    	end if

    	'' counter <= or >= end cond?
		cFlushBOP( op, dtype, _
				   stk->for.cnt, NULL, _
				   stk->for.endc, @stk->for.eval, _
				   stk->for.inilabel )

    else
		cl = symbAddLabel( NULL, TRUE )

    	'' test step sign and branch
		select case as const dtype
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			ival.long = 0
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			ival.float = 0.0
		case else
			ival.int = 0
		end select

		cFlushBOP( AST_OP_GE, dtype, _
				   stk->for.stp, @stk->for.sval, _
				   NULL, @ival, _
				   cl )

    	'' negative, loop if >=
		cFlushBOP( AST_OP_GE, dtype, _
				   stk->for.cnt, NULL, _
				   stk->for.endc, @stk->for.eval, _
				   stk->for.inilabel )
		'' exit loop
		astAdd( astNewBRANCH( AST_OP_JMP, env.stmt.for.endlabel ) )
    	'' control label
    	astAdd( astNewLABEL( cl, FALSE ) )
    	'' positive, loop if <=
		cFlushBOP( AST_OP_LE, dtype, _
				   stk->for.cnt, NULL, _
				   stk->for.endc, @stk->for.eval, _
				   stk->for.inilabel )
    end if

    '' end label (loop exit)
    astAdd( astNewLABEL( env.stmt.for.endlabel ) )

	function = TRUE

end function

'':::::
''ForStmtEnd      =   NEXT (ID (',' ID?))? .
''
function cForStmtEnd as integer
	dim as integer iserror
	dim as FB_CMPSTMTSTK ptr stk

	function = FALSE

	'' NEXT
	lexSkipToken( )

	do
		stk = stackGetTOS( @env.stmtstk )
		iserror = (stk = NULL)
		if( iserror = FALSE ) then
			iserror = (stk->id <> FB_TK_FOR)
		end if

		if( iserror ) then
			hReportError( FB_ERRMSG_NEXTWITHOUTFOR )
			exit function
		end if

		hForStmtClose( stk )

		'' pop from stmt stack
		env.stmt.for = stk->last
		stackPop( @env.stmtstk )

		'' ID?
		if( lexGetClass( ) <> FB_TKCLASS_IDENTIFIER ) then
			exit do
		end if
		lexSkipToken( )

		'' ','?
		if( lexGetToken( ) <> CHAR_COMMA ) then
			exit do
		end if
		lexSkipToken( )
	loop

	function = TRUE

end function



