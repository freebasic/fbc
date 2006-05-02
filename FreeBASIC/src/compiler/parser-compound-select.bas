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

type FBCASECTX
	typ 		as integer
	op 			as integer
	expr1		as ASTNODE ptr
	expr2		as ASTNODE ptr
end type

type FBCTX
	base		as integer
	caseTB(0 to FB_MAXCASEEXPR-1) as FBCASECTX
end type

'' globals
	dim shared ctx as FBCTX


'':::::
sub parserSelectStmtInit( )

	ctx.base = 0

end sub

'':::::
sub parserSelectStmtEnd( )


end sub

'':::::
''SelectStatement =   SELECT CASE (AS CONST)? Expression .
''
function cSelectStmtBegin as integer
    dim as ASTNODE ptr expr
    dim as integer dtype
	dim as FBSYMBOL ptr sym, el, subtype
	dim as FB_CMPSTMTSTK ptr stk

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
			function = cSelConstStmtBegin( )
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

	'' add exit label
	el = symbAddLabel( NULL, FALSE )

	'' store expression into a temp var
	dtype = astGetDataType( expr )
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
		sym = symbAddTempVar( dtype, subtype )
		if( sym = NULL ) then
			exit function
		end if

		expr = astNewASSIGN( astNewVAR( sym, 0, dtype, subtype ), expr )
		if( expr = NULL ) then
			exit function
		end if
		astAdd( expr )

	else
		'' the wstring must be allocated() but size
		'' is unknown at compilet-time, do:

		''  dim wstring ptr tmp
		sym = symbAddTempVar( FB_DATATYPE_POINTER+FB_DATATYPE_WCHAR, NULL )
		if( sym = NULL ) then
			exit function
		end if

		'' tmp = WstrAlloc( len( expr ) )
		astAdd( astNewASSIGN( astNewVAR( sym, _
										 0, _
										 FB_DATATYPE_POINTER+FB_DATATYPE_WCHAR ), _
							  rtlWstrAlloc( rtlMathLen( astCloneTree( expr ), TRUE ) ) ) )

		'' *tmp = expr
		expr = astNewASSIGN( astNewPTR( 0, _
								  		astNewVAR( sym, _
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

	'' push to stmt stack
	stk = stackPush( @env.stmtstk )
	stk->last = env.stmt.select
	stk->id = FB_TK_SELECT
	stk->select.isconst = FALSE
	stk->select.sym = sym
	stk->select.dtype = dtype
	stk->select.casecnt = 0

	env.stmt.select.cmplabel = symbAddLabel( NULL, FALSE )
	env.stmt.select.endlabel = el

	function = TRUE

end function

'':::::
''CaseExpression  =   (Expression (TO Expression)?)?
''				  |   (IS REL_OP Expression)? .
''
private function hCaseExpression( byref casectx as FBCASECTX ) as integer

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
private function hFlushCaseExpr( byref casectx as FBCASECTX, _
				           	     byval sym as FBSYMBOL ptr, _
				           	     byval dtype as integer, _
				           	     byval inilabel as FBSYMBOL ptr, _
				           	     byval nxtlabel as FBSYMBOL ptr, _
				           	     byval islast as integer _
				           	   ) as integer static

	dim as ASTNODE ptr expr

	if( casectx.typ <> FB_CASETYPE_RANGE ) then
        expr = NEWCASEVAR( sym, dtype )

		if( islast ) then
			expr = astNewBOP( astGetInverseLogOp( casectx.op ), _
						  	  expr, _
						  	  casectx.expr1, _
						  	  nxtlabel, _
						  	  FALSE )

		else
			expr = astNewBOP( casectx.op, _
						  	  expr, _
						  	  casectx.expr1, _
						  	  inilabel, _
						  	  FALSE )
		end if

	else
		expr = NEWCASEVAR( sym, dtype )

		expr = astNewBOP( AST_OP_LT, expr, casectx.expr1, nxtlabel, FALSE )

		if( expr = NULL ) then
			return FALSE
		end if

		astAdd( expr )

		expr = NEWCASEVAR( sym, dtype )

		if( islast ) then
			expr = astNewBOP( AST_OP_GT, expr, casectx.expr2, nxtlabel, FALSE )
		else
			expr = astNewBOP( AST_OP_LE, expr, casectx.expr2, inilabel, FALSE )
		end if
	end if

	if( expr = NULL ) then
		return FALSE
	end if

	astAdd( expr )

	function = TRUE

end function

'':::::
''SelectStmtNext   =    CASE (ELSE | (CaseExpression (COMMA CaseExpression)*)) .
''
function cSelectStmtNext( ) as integer
	dim as FBSYMBOL ptr sym, il, nl
	dim as integer dtype, cnt, i, cntbase, iserror
	dim as FB_CMPSTMTSTK ptr stk

	function = FALSE

	stk = stackGetTOS( @env.stmtstk )
	iserror = (stk = NULL)
	if( iserror = FALSE ) then
		iserror = (stk->id <> FB_TK_SELECT)
	end if

	if( iserror ) then
		hReportError( FB_ERRMSG_CASEWITHOUTSELECT )
		exit function
	end if

	'' ELSE already parsed?
	if( stk->select.casecnt = -1 ) then
		hReportError( FB_ERRMSG_SYNTAXERROR )
		exit function
	end if

    '' AS CONST?
    if( stk->select.isconst ) then
    	return cSelConstStmtNext( stk )
    end if

	'' CASE
	lexSkipToken( )

	if( stk->select.casecnt > 0 ) then
		'' break from block
		astAdd( astNewBRANCH( AST_OP_JMP, env.stmt.select.endlabel ) )

		astAdd( astNewLABEL( env.stmt.select.cmplabel ) )
		env.stmt.select.cmplabel = symbAddLabel( NULL, TRUE )
	end if

	'' CaseExpression (COMMA CaseExpression)*
	'' ELSE?
	if( lexGetToken( ) = FB_TK_ELSE ) then
		lexSkipToken( )
		stk->select.casecnt = -1

	else
		cnt = 0
		cntbase = ctx.base

		do
			if( hCaseExpression( ctx.caseTB(cntbase + cnt) ) = FALSE ) then
				hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
				exit function
			end if

			cnt += 1
		loop while( hMatch( CHAR_COMMA ) )

		''
		ctx.base += cnt

		sym = stk->select.sym
		dtype = stk->select.dtype

		'' add block ini label
		il = symbAddLabel( NULL, TRUE )

		for i = 0 to cnt-1

			if( i < cnt-1 ) then
				'' add next label
				nl = symbAddLabel( NULL, FALSE )
			else
				nl = env.stmt.select.cmplabel
			end if

			if( ctx.caseTB(cntbase+i).typ <> FB_CASETYPE_ELSE ) then
				if( hFlushCaseExpr( ctx.caseTB(cntbase+i), _
									sym, dtype, _
									il, nl, _
									i = cnt-1 ) = FALSE ) then
					hReportError( FB_ERRMSG_INVALIDDATATYPES, TRUE )
					exit function
				end if
			end if

			if( i < cnt-1 ) then
				'' emit next label
				astAdd( astNewLABEL( nl ) )
			end if

		next

 		ctx.base -= cnt

		'' emit init block label
		astAdd( astNewLABEL( il ) )

		stk->select.casecnt += 1

	end if

	function = TRUE

end function

'':::::
''SelectStmtEnd =   END SELECT .
''
function cSelectStmtEnd as integer
	dim as integer dtype
	dim as integer iserror
	dim as FB_CMPSTMTSTK ptr stk

	function = FALSE

	stk = stackGetTOS( @env.stmtstk )
	iserror = (stk = NULL)
	if( iserror = FALSE ) then
		iserror = (stk->id <> FB_TK_SELECT)
	end if

	if( iserror ) then
		hReportError( FB_ERRMSG_ENDSELECTWITHOUTSELECT )
		exit function
	end if

    '' no CASE's?
    if( stk->select.casecnt = 0 ) then
		hReportError( FB_ERRMSG_SYNTAXERROR )
		exit function
    end if

    '' AS CONST?
    if( stk->select.isconst ) then
    	return cSelConstStmtEnd( stk )
    end if

	'' END SELECT
	lexSkipToken( )
	lexSkipToken( )

    '' emit end label
    astAdd( astNewLABEL( env.stmt.select.cmplabel ) )
    astAdd( astNewLABEL( env.stmt.select.endlabel ) )

	'' if a temp string was allocated, delete it
	select case stk->select.dtype
	case FB_DATATYPE_STRING
		astAdd( rtlStrDelete( astNewVAR( stk->select.sym, _
										 0, _
										 FB_DATATYPE_STRING ) ) )

	case FB_DATATYPE_WCHAR
		astAdd( rtlStrDelete( astNewVAR( stk->select.sym, _
										 0, _
										 FB_DATATYPE_POINTER+FB_DATATYPE_WCHAR ) ) )
	end select

	'' pop from stmt stack
	env.stmt.select = stk->last
	stackPop( @env.stmtstk )

	function = TRUE

end function


