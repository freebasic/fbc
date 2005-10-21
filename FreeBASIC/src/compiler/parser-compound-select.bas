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


'' SELECT CASE [AS CONST]..CASE..END SELECT compound statement parsing
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"
#include once "inc\rtl.bi"

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
end type

'' globals
	dim shared ctx as FBCTX


'':::::
sub parserSelectStmtInit( )

	ctx.sel.base = 0

	ctx.swt.base = 0

end sub

'':::::
sub parserSelectStmtEnd( )


end sub


'':::::
''SelectStatement =   SELECT CASE (AS CONST)? Expression Comment? SttSeparator
''					   cComment? cStmtSeparator? CaseStatement*
''				      END SELECT .
''
function cSelectStatement as integer
    dim as ASTNODE ptr expr
    dim as integer lastcompstmt, dtype
	dim as FBSYMBOL ptr symbol, elabel

	function = FALSE

	'' SELECT
	lexSkipToken( )

	'' CASE
	if( not hMatch( FB_TK_CASE ) ) then
		hReportError( FB_ERRMSG_EXPECTEDCASE )
		exit function
	end if

	'' AS?
	if( hMatch( FB_TK_AS ) ) then
		'' CONST?
		if( hMatch( FB_TK_CONST ) ) then
			function = cSelectConstStmt( )
		else
			hReportError( FB_ERRMSG_SYNTAXERROR )
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
		hReportError( FB_ERRMSG_INVALIDDATATYPES )
		exit function
	end if

	'' Comment?
	cComment( )

	'' separator
	if( not cStmtSeparator( ) ) then
		hReportError( FB_ERRMSG_EXPECTEDEOL )
		exit function
	end if

	'' save current context
	lastcompstmt = env.lastcompound
	env.lastcompound = FB_TK_SELECT

	'' add exit label
	elabel = symbAddLabel( NULL )

	'' store expression into a temp var
	dtype = astGetDataType( expr )
	select case dtype
	case FB_SYMBTYPE_FIXSTR, FB_SYMBTYPE_CHAR
		dtype = FB_SYMBTYPE_STRING
	end select

	'' !!!FIXME!!! wstring's must be allocated() but size
	'' is unknown at compilet-time, do
	'' 		dim wstring ptr tmp = allocate( len( expr ) )
	'' 		*tmp = expr
	''		select case *tmp <-- implicitly!
	''		...
	''		deallocate( tmp )

	symbol = symbAddTempVar( dtype, astGetSubType( expr ) )
	if( symbol = NULL ) then
		exit function
	end if

	expr = astNewASSIGN( astNewVAR( symbol, NULL, 0, dtype, astGetSubType( expr ) ), expr )
	if( expr = NULL ) then
		exit function
	end if
	astAdd( expr )

	'' SelectLine*
	do

    	'' Comment? SttSeparator?
    	do while( cComment( ) or cStmtSeparator( ) )
    	loop

    	'' CaseStatement
    	if( not cCaseStatement( symbol, dtype, elabel ) ) then
	    	exit do
    	end if

	loop while( lexGetToken( ) <> FB_TK_EOF )

    '' emit exit label
    astAdd( astNewLABEL( elabel ) )

	'' END SELECT
	if( (not hMatch( FB_TK_END )) or (not hMatch( FB_TK_SELECT )) ) then
		hReportError( FB_ERRMSG_EXPECTEDENDSELECT )
		exit function
	end if

	'' if a temp string was allocated, delete it
	select case dtype
	case FB_SYMBTYPE_STRING, FB_SYMBTYPE_WCHAR
		astAdd( rtlStrDelete( astNewVAR( symbol, NULL, 0, dtype ) ) )
	end select

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
		lexSkipToken( )
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
			hReportError( FB_ERRMSG_SYNTAXERROR )
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

	dim as FBSYMBOL ptr il, nl
	dim as integer iselse, cnt, i, cntbase

	function = FALSE

	'' CASE
	if( not hMatch( FB_TK_CASE ) ) then
		exit function
	end if

	'' add labels
	il = symbAddLabel( NULL )

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
	cComment( )

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
		nl = symbAddLabel( NULL )

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
				if( not cSimpleLine( ) ) then
					exit do
				end if
			loop while( lexGetToken( ) <> FB_TK_EOF )

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

	dim as integer probe, high, low, i
	dim as uinteger v

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
	next

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
		deflabel = symbAddLabel( NULL )
		astAdd( astNewLABEL( deflabel ) )

	else

		'' add label
		label = symbAddLabel( NULL )

		'' ConstExpression (COMMA ConstExpression (TO ConstExpression)?)*
		do
			if( not cExpression( expr1 ) ) then
				hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
				exit function
			end if

			if( not astIsCONST( expr1 ) ) then
				hReportError( FB_ERRMSG_EXPECTEDCONST )
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
					if( value < minval ) then
						minval = value
					end if
					if( value > maxval ) then
						maxval = value
					end if

					 '' too big?
					 if( (minval > maxval) or _
					 	 (maxval - minval > FB_MAXSWTCASERANGE) or _
					 	 (culngint(minval) * FB_INTEGERSIZE > 4294967292ULL) ) then
					 	exit function
					 end if

					'' add item
					if( not hSelConstAddCase( swtbase, value, label ) ) then
						exit function
					end if
				next

			else
				if( value < minval ) then
					minval = value
				end if
				if( value > maxval ) then
					maxval = value
				end if

				'' too big?
				if( (minval > maxval) or _
					(maxval - minval > FB_MAXSWTCASERANGE) or _
					(culngint(minval) * FB_INTEGERSIZE > 4294967292ULL) ) then
					exit function
				end if

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
	cComment( )

	'' SttSeparator
	if( not cStmtSeparator( ) ) then
		exit function
	end if

	'' SimpleLine*
	do
		if( not cSimpleLine( ) ) then
			exit do
		end if
	loop while( lexGetToken( ) <> FB_TK_EOF )

	if( hGetLastError( ) <> FB_ERRMSG_OK ) then
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
	if( not cStmtSeparator( ) ) then
		hReportError( FB_ERRMSG_EXPECTEDEOL )
		exit function
	end if

	'' save current context
	lastcompstmt = env.lastcompound
	env.lastcompound = FB_TK_SELECT

	'' add labels
	exitlabel = symbAddLabel( NULL )
	complabel = symbAddLabel( NULL )

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
	minval = &hFFFFFFFFu
	maxval = 0
	do
    	'' Comment? SttSeparator?
    	do while( cComment( ) or cStmtSeparator( ) )
    	loop

    	'' SelConstCaseStmt
    	if( not cSelConstCaseStmt( swtbase, sym, exitlabel, minval, maxval, deflabel ) ) then
	    	exit do
    	end if

	loop while( lexGetToken <> FB_TK_EOF )

    '' too large?
    if( (minval > maxval) or _
    	(maxval - minval > FB_MAXSWTCASERANGE) or _
    	(culngint(minval) * FB_INTEGERSIZE > 4294967292ULL) ) then
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
    next

    ctx.swt.base = swtbase

    '' emit exit label
    astAdd( astNewLABEL( exitlabel ) )

	'' END SELECT
	if( (not hMatch( FB_TK_END )) or (not hMatch( FB_TK_SELECT )) ) then
		hReportError( FB_ERRMSG_EXPECTEDENDSELECT )
		exit function
	end if

	env.lastcompound = lastcompstmt

	function = TRUE

end function

