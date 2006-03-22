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
''ForStatement    =   FOR ID '=' Expression TO Expression (STEP Expression)? Comment? SttSeparator
''					  SimpleLine*
''					  NEXT ID? .
''
function cForStatement as integer
    dim as integer iscomplex, ispositive, isconst
    dim as FBSYMBOL ptr il, tl, el, cl, c2l
    dim as FBSYMBOL ptr cnt, endc, stp
    dim as FBVALUE sval, eval, ival
    dim as ASTNODE ptr idexpr, expr
    dim as integer op, dtype, dclass, typ, lastcompstmt
    dim as FBCMPSTMT oldforstmt

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

	cnt = astGetSymbol( idexpr )

	typ = symbGetType( cnt )

	if( (typ < FB_DATATYPE_BYTE) or (typ > FB_DATATYPE_DOUBLE) ) then
		hReportError( FB_ERRMSG_EXPECTEDSCALAR, TRUE )
		exit function
	end if

	'' =
	if( hMatch( FB_TK_ASSIGN ) = FALSE ) then
		hReportError( FB_ERRMSG_EXPECTEDEQ )
		exit function
	end if

	'' get counter type (endc and step must be the same type)
	dtype  = typ
	dclass = symbGetDataClass( dtype )
	isconst = 0

    '' Expression
    if( cExpression( expr ) = FALSE ) then
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
		hReportError( FB_ERRMSG_EXPECTEDTO )
		exit function
	end if

	'' end condition (Expression)
	if( cExpression( expr ) = FALSE ) then
		hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
		exit function
	end if

	''
	if( astIsCONST( expr ) ) then
		astConvertValue( expr, @eval, dtype )
		astDelNode( expr )
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
		if( cExpression( expr ) = FALSE ) then
			hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
			exit function
		end if

		'' store step into a temp var
		if( astIsCONST( expr ) ) then
			select case as const astGetDataType( expr )
			case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
				ispositive = (astGetValLong( expr ) >= 0)
			case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
				ispositive = (astGetValFloat( expr ) >= 0)
			case else
				ispositive = (astGetValInt( expr ) >= 0)
			end select
		else
			iscomplex = TRUE
		end if

		if( iscomplex ) then

			stp = symbAddTempVar( typ )
			if( stp = NULL ) then
				exit function
			end if

			astAdd( astNewASSIGN( astNewVAR( stp, 0, dtype ), expr ) )

		else
            '' get constant step
            astConvertValue( expr, @sval, dtype )
			astDelNode( expr )
			stp = NULL
			isconst += 1
		end if

	else
		select case as const dtype
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			sval.long = 1
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			sval.float = 1.0
		case else
			sval.int = 1
		end select
		stp = NULL
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

		if( ispositive ) then
			op = AST_OP_LE
    	else
			op = AST_OP_GE
    	end if

    	expr = astNewBOP( op, astNewCONST( @ival, dtype ), astNewCONST( @eval, dtype ) )
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

	'' save old for stmt info
	oldforstmt = env.forstmt

	env.forstmt.cmplabel = cl
	env.forstmt.endlabel = el

	''
	lastcompstmt = env.lastcompound
	env.lastcompound = FB_TK_FOR

	'' Comment?
	cComment( )

	'' separator
	if( cStmtSeparator( ) = FALSE ) then
		hReportError( FB_ERRMSG_EXPECTEDEOL )
		exit function
	end if

	'' loop body
	do
		if( cSimpleLine( ) = FALSE ) then
			exit do
		end if
	loop while( lexGetToken( ) <> FB_TK_EOF )

	'' NEXT
	if( hMatch( FB_TK_NEXT ) = FALSE ) then
		hReportError( FB_ERRMSG_EXPECTEDNEXT )
		exit function
	end if

	'' counter?
	if( lexGetClass( ) = FB_TKCLASS_IDENTIFIER ) then
		lexSkipToken( )

		'' ( ',' counter? )*
		if( lexGetToken( ) = CHAR_COMMA ) then
			'' hack to handle multiple identifiers...
			lexSetToken( FB_TK_NEXT, FB_TKCLASS_KEYWORD )
		end if
	end if

	'' cmp label
	astAdd( astNewLABEL( cl ) )

	'' counter += step
	cFlushSelfBOP( AST_OP_ADD, dtype, cnt, stp, @sval )

	'' test label
	astAdd( astNewLABEL( tl ) )

    if( iscomplex = FALSE ) then

		if( ispositive ) then
			op = AST_OP_LE
    	else
			op = AST_OP_GE
    	end if

    	'' counter <= or >= end cond?
		cFlushBOP( op, dtype, cnt, NULL, endc, @eval, il )

		c2l = NULL
    else
		c2l = symbAddLabel( NULL, TRUE )

    	'' test step sign and branch
		select case as const dtype
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			ival.long = 0
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			ival.float = 0.0
		case else
			ival.int = 0
		end select

		cFlushBOP( AST_OP_GE, dtype, stp, @sval, NULL, @ival, c2l )

    	'' negative, loop if >=
		cFlushBOP( AST_OP_GE, dtype, cnt, NULL, endc, @eval, il )
		'' exit loop
		astAdd( astNewBRANCH( AST_OP_JMP, el ) )
    	'' control label
    	astAdd( astNewLABEL( c2l, FALSE ) )
    	'' positive, loop if <=
		cFlushBOP( AST_OP_LE, dtype, cnt, NULL, endc, @eval, il )
    end if

    '' end label (loop exit)
    astAdd( astNewLABEL( el ) )

	'' restore old for stmt info
	env.forstmt = oldforstmt

	''
	env.lastcompound = lastcompstmt

	function = TRUE

end function

