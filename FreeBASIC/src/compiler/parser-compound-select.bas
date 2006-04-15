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
	dim as FBSYMBOL ptr symbol, elabel, subtype

	function = FALSE

	'' SELECT
	lexSkipToken( )

	'' CASE
	if( hMatch( FB_TK_CASE ) = FALSE ) then
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
	if( cExpression( expr ) = FALSE ) then
		hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
		exit function
	end if

	'' can't be an UDT
	if( astGetDataType( expr ) = FB_DATATYPE_USERDEF ) then
		hReportError( FB_ERRMSG_INVALIDDATATYPES )
		exit function
	end if

	'' Comment?
	cComment( )

	'' separator
	if( cStmtSeparator( ) = FALSE ) then
		hReportError( FB_ERRMSG_EXPECTEDEOL )
		exit function
	end if

	'' save current context
	lastcompstmt = env.lastcompound
	env.lastcompound = FB_TK_SELECT

	'' add exit label
	elabel = symbAddLabel( NULL, FALSE )

	'' store expression into a temp var
	dtype   = astGetDataType( expr )
	subtype = astGetSubType( expr )
	select case dtype
	'' fixed-len or zstring? temp will be a var-len string..
	case FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR
		dtype = FB_DATATYPE_STRING

	'' bitfield? they are always converted to uint's..
	case FB_DATATYPE_BITFIELD
		dtype   = FB_DATATYPE_UINT
	    subtype = NULL
	end select

    '' not a wstring?
	if( dtype <> FB_DATATYPE_WCHAR ) then
		symbol = symbAddTempVar( dtype, subtype )
		if( symbol = NULL ) then
			exit function
		end if

		expr = astNewASSIGN( astNewVAR( symbol, 0, dtype, subtype ), expr )
		if( expr = NULL ) then
			exit function
		end if
		astAdd( expr )

	else
		'' the wstring must be allocated() but size
		'' is unknown at compilet-time, do:

		''  dim wstring ptr tmp
		symbol = symbAddTempVar( FB_DATATYPE_POINTER+FB_DATATYPE_WCHAR, NULL )
		if( symbol = NULL ) then
			exit function
		end if

		'' tmp = WstrAlloc( len( expr ) )
		astAdd( astNewASSIGN( astNewVAR( symbol, _
										 0, _
										 FB_DATATYPE_POINTER+FB_DATATYPE_WCHAR ), _
							  rtlWstrAlloc( rtlMathLen( astCloneTree( expr ), TRUE ) ) ) )

		'' *tmp = expr
		expr = astNewASSIGN( astNewPTR( 0, _
								  		astNewVAR( symbol, _
								  		 		   0, _
								  		 		   FB_DATATYPE_POINTER+FB_DATATYPE_WCHAR ), _
								  	    FB_DATATYPE_WCHAR, _
								  	    NULL ), _
				      		 expr )

		if( expr = NULL ) then
			exit function
		end if
		astAdd( expr )
	end if

	'' SelectLine*
	do

    	'' Comment? SttSeparator?
    	do while( cComment( ) or cStmtSeparator( ) )
    	loop

    	'' CaseStatement
    	if( cCaseStatement( symbol, dtype, elabel ) = FALSE ) then
	    	exit do
    	end if

	loop while( lexGetToken( ) <> FB_TK_EOF )

    '' emit exit label
    astAdd( astNewLABEL( elabel ) )

	'' END SELECT
	if( (hMatch( FB_TK_END ) = FALSE) or _
		(hMatch( FB_TK_SELECT ) = FALSE) ) then
		hReportError( FB_ERRMSG_EXPECTEDENDSELECT )
		exit function
	end if

	'' if a temp string was allocated, delete it
	select case dtype
	case FB_DATATYPE_STRING
		astAdd( rtlStrDelete( astNewVAR( symbol, 0, dtype ) ) )
	case FB_DATATYPE_WCHAR
		astAdd( rtlStrDelete( astNewVAR( symbol, _
										 0, _
										 FB_DATATYPE_POINTER+FB_DATATYPE_WCHAR ) ) )
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

	casectx.op 	= AST_OP_EQ

	'' IS REL_OP Expression
	if( hMatch( FB_TK_IS ) ) then
		casectx.op = hFBrelop2IRrelop( lexGetToken( ) )
		lexSkipToken( )
		casectx.typ = FB_CASETYPE_IS
	else
		casectx.typ = 0
	end if

	'' Expression
	if( cExpression( casectx.expr1 ) = FALSE ) then
		hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
		exit function
	end if

	'' TO Expression
	if( hMatch( FB_TK_TO ) ) then
		if( casectx.typ <> 0 ) then
			hReportError( FB_ERRMSG_SYNTAXERROR )
			exit function
		end if

		if( cExpression( casectx.expr2 ) = FALSE ) then
			hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
			exit function
		end if

		casectx.typ =  FB_CASETYPE_RANGE
	end if

	function = TRUE

end function

'':::::
'' if it's a wstring, do "if *tmp op expr"
#define NEWCASEVAR(symbol,dtype) 				_
	iif( dtype <> FB_DATATYPE_WCHAR, 			_
		 astNewVAR( symbol, 0, dtype ), 		_
		 astNewPTR( 0, 							_
					astNewVAR( symbol, 0, FB_DATATYPE_POINTER+FB_DATATYPE_WCHAR ), _
					FB_DATATYPE_WCHAR, 			_
					NULL ) 						_
	   )


'':::::
private function hExecCaseExpr( byref casectx as FBCASECTX, _
				           	    byval s as FBSYMBOL ptr, _
				           	    byval sdtype as integer, _
				           	    byval initlabel as FBSYMBOL ptr, _
				           	    byval nextlabel as FBSYMBOL ptr, _
				           		byval inverselogic as integer ) as integer static

	dim as ASTNODE ptr expr

	if( casectx.typ <> FB_CASETYPE_RANGE ) then
        expr = NEWCASEVAR( s, sdtype )

		if( inverselogic = FALSE ) then
			expr = astNewBOP( casectx.op, _
							  expr, _
							  casectx.expr1, _
							  initlabel, _
							  FALSE )
		else
			expr = astNewBOP( irGetInverseLogOp( casectx.op ), _
							  expr, _
							  casectx.expr1, _
							  nextlabel, _
							  FALSE )
		end if

	else
		expr = NEWCASEVAR( s, sdtype )

		expr = astNewBOP( AST_OP_LT, expr, casectx.expr1, nextlabel, FALSE )
		astAdd( expr )

		if( expr = NULL ) then
			return FALSE
		end if

		expr = NEWCASEVAR( s, sdtype )

		if( inverselogic = FALSE ) then
			expr = astNewBOP( AST_OP_LE, expr, casectx.expr2, initlabel, FALSE )
		else
			expr = astNewBOP( AST_OP_GT, expr, casectx.expr2, nextlabel, FALSE )
		end if
	end if

	astAdd( expr )

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
	if( hMatch( FB_TK_CASE ) = FALSE ) then
		exit function
	end if

	'' add labels
	il = symbAddLabel( NULL, TRUE )

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

		if( cCaseExpression( ctx.sel.caseTB(cntbase + cnt) ) = FALSE ) then
			hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
			exit function
		end if

		cnt += 1

	loop while( hMatch( CHAR_COMMA ) )

	'' Comment?
	cComment( )

	'' SttSeparator
	if( cStmtSeparator( ) = FALSE ) then
		exit function
	end if

	if( hGetLastError( ) <> FB_ERRMSG_OK ) then
		exit function
	end if

	''
	ctx.sel.base += cnt

	for i = cntbase to cntbase + cnt-1

		'' add next label
		nl = symbAddLabel( NULL, FALSE )

		if( ctx.sel.caseTB(i).typ <> FB_CASETYPE_ELSE ) then
			if( hExecCaseExpr( ctx.sel.caseTB(i), s, sdtype, il, nl, i = cntbase ) = FALSE ) then
				hReportError( FB_ERRMSG_INVALIDDATATYPES, TRUE )
				exit function
			end if
		end if

		if( i = cntbase ) then
			''
			astAdd( astNewLABEL( il ) )

			'' SimpleLine*
			do
				if( cSimpleLine( ) = FALSE ) then
					exit do
				end if
			loop while( lexGetToken( ) <> FB_TK_EOF )

			if( ctx.sel.caseTB(i).typ = FB_CASETYPE_ELSE ) then
				exit for
			end if

			'' break from block
			astAdd( astNewBRANCH( AST_OP_JMP, exitlabel ) )

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
		probe = cunsg(high + low) \ 2
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
	if( hMatch( FB_TK_CASE ) = FALSE ) then
		exit function
	end if

	'' ELSE
	if( hMatch( FB_TK_ELSE ) ) then
		deflabel = symbAddLabel( NULL, TRUE )
		astAdd( astNewLABEL( deflabel ) )

	else

		'' add label
		label = symbAddLabel( NULL, FALSE )

		'' ConstExpression (COMMA ConstExpression (TO ConstExpression)?)*
		do
			if( cExpression( expr1 ) = FALSE ) then
				hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
				exit function
			end if

			if( astIsCONST( expr1 ) = FALSE ) then
				hReportError( FB_ERRMSG_EXPECTEDCONST )
				exit function
			end if

			value = astGetValueAsInt( expr1 )
			astDelNode( expr1 )

			'' TO?
			if( hMatch( FB_TK_TO ) ) then
				if( cExpression( expr2 ) = FALSE ) then
					hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
					exit function
				end if

				if( astIsCONST( expr2 ) = FALSE ) then
					hReportError FB_ERRMSG_EXPECTEDCONST
					exit function
				end if

				tovalue = astGetValueAsInt( expr2 )
				astDelNode( expr2 )

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
					if( hSelConstAddCase( swtbase, value, label ) = FALSE ) then
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
				if( hSelConstAddCase( swtbase, value, label ) = FALSE ) then
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
	if( cStmtSeparator( ) = FALSE ) then
		exit function
	end if

	'' SimpleLine*
	do
		if( cSimpleLine( ) = FALSE ) then
			exit do
		end if
	loop while( lexGetToken( ) <> FB_TK_EOF )

	if( hGetLastError( ) <> FB_ERRMSG_OK ) then
		exit function
	end if

	'' break from block
	astAdd( astNewBRANCH( AST_OP_JMP, exitlabel ) )

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
	if( cExpression( expr ) = FALSE ) then
		hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
		exit function
	end if

	if( astGetDataClass( expr ) <> FB_DATACLASS_INTEGER ) then
		hReportError( FB_ERRMSG_INVALIDDATATYPES )
		exit function

    '' CHAR and WCHAR literals are also from the INTEGER class
    else
    	select case astGetDataType( expr )
    	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
    		'' don't allow, unless it's a deref pointer
    		if( astIsPTR( expr ) = FALSE ) then
    			hReportError( FB_ERRMSG_INVALIDDATATYPES )
    			exit function
    		end if
    	end select
	end if

	if( astGetDataType( expr ) <> FB_DATATYPE_UINT ) then
		expr = astNewCONV( INVALID, FB_DATATYPE_UINT, NULL, expr )
	end if

	'' Comment?
	cComment( )

	'' separator
	if( cStmtSeparator( ) = FALSE ) then
		hReportError( FB_ERRMSG_EXPECTEDEOL )
		exit function
	end if

	'' save current context
	lastcompstmt = env.lastcompound
	env.lastcompound = FB_TK_SELECT

	'' add labels
	exitlabel = symbAddLabel( NULL, FALSE )
	complabel = symbAddLabel( NULL, FALSE )

	'' store expression into a temp var
	sym = symbAddTempVar( FB_DATATYPE_UINT )
	if( sym = NULL ) then
		exit function
	end if

	expr = astNewASSIGN( astNewVAR( sym, 0, FB_DATATYPE_UINT ), expr )
	if( expr = NULL ) then
		exit function
	end if
	astAdd( expr )

	'' skip the statements
	astAdd( astNewBRANCH( AST_OP_JMP, complabel ) )

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
    	if( cSelConstCaseStmt( swtbase, _
    						   sym, _
    						   exitlabel, _
    						   minval, _
    						   maxval, _
    						   deflabel ) = FALSE ) then
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
		expr = astNewBOP( AST_OP_LT, _
						  astNewVAR( sym, 0, FB_DATATYPE_UINT ), _
						  astNewCONSTi( minval, FB_DATATYPE_UINT ), _
						  deflabel, FALSE )
		astAdd( expr )
	end if

	'' check max val
	expr = astNewBOP( AST_OP_GT, _
					  astNewVAR( sym, 0, FB_DATATYPE_UINT ), _
					  astNewCONSTi( maxval, FB_DATATYPE_UINT ), _
					  deflabel, FALSE )
	astAdd( expr )

    '' jump to table[idx]
    tbsym = hJumpTbAllocSym( )

	idxexpr = astNewBOP( AST_OP_MUL, _
						 astNewVAR( sym, 0, FB_DATATYPE_UINT ), _
    				  	 astNewCONSTi( FB_INTEGERSIZE, FB_DATATYPE_UINT ) )

    expr = astNewIDX( astNewVAR( tbsym, -minval*FB_INTEGERSIZE, FB_DATATYPE_UINT ), _
    				  idxexpr, FB_DATATYPE_UINT, NULL )

    astAdd( astNewBRANCH( AST_OP_JUMPPTR, NULL, expr ) )

    '' emit table
    astAdd( astNewLABEL( tbsym ) )

    ''
    l = swtbase
    for value = minval to maxval
    	if( value = ctx.swt.caseTB(l).value ) then
    		astAdd( astNewJMPTB( FB_DATATYPE_UINT, ctx.swt.caseTB(l).label ) )
    		l += 1
    	else
    		astAdd( astNewJMPTB( FB_DATATYPE_UINT, deflabel ) )
    	end if
    next

    ctx.swt.base = swtbase

    '' emit exit label
    astAdd( astNewLABEL( exitlabel ) )

	'' END SELECT
	if( (hMatch( FB_TK_END ) = FALSE) or _
		(hMatch( FB_TK_SELECT ) = FALSE) ) then
		hReportError( FB_ERRMSG_EXPECTEDENDSELECT )
		exit function
	end if

	env.lastcompound = lastcompstmt

	function = TRUE

end function

