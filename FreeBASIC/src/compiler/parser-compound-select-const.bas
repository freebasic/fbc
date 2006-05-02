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


'' SELECT CASE AS CONST..CASE..END SELECT compound statement parsing
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"
#include once "inc\rtl.bi"

const FB_MAXSWTCASEEXPR = 8192
const FB_MAXSWTCASERANGE= 4096

type FBCASECTX
	label		as FBSYMBOL ptr
	value		as uinteger
end type

type FBCTX
	base		as integer
	caseTB(0 to FB_MAXSWTCASEEXPR-1) as FBCASECTX
end type

'' globals
	dim shared ctx as FBCTX

'':::::
sub parserSelConstStmtInit( )

	ctx.base = 0

end sub

'':::::
sub parserSelConstStmtEnd( )


end sub

'':::::
''SelConstStmtBegin =   SELECT CASE AS CONST Expression{int} .
''
function cSelConstStmtBegin( ) as integer
    dim as ASTNODE ptr expr
	dim as FBSYMBOL ptr sym, el, cl
	dim as FB_CMPSTMTSTK ptr stk

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

	'' add labels
	el = symbAddLabel( NULL, FALSE )
	cl = symbAddLabel( NULL, FALSE )

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
	astAdd( astNewBRANCH( AST_OP_JMP, cl ) )

	'' push to stmt stack
	stk = stackPush( @env.stmtstk )
	stk->last = env.stmt.select
	stk->id = FB_TK_SELECT
	stk->select.isconst = TRUE
	stk->select.sym = sym
	stk->select.casecnt = 0
	stk->select.const.base = ctx.base
	stk->select.const.deflabel = NULL
	stk->select.const.minval = &hFFFFFFFFu
	stk->select.const.maxval = 0

	env.stmt.select.cmplabel = cl
	env.stmt.select.endlabel = el

	function = TRUE

end function

'':::::
private function hSelConstAddCase( byval swtbase as integer, _
								   byval value as uinteger, _
							       byval label as FBSYMBOL ptr _
							     ) as integer static

	dim as integer probe, high, low, i
	dim as uinteger v

	'' nothing left?
	if( ctx.base >= FB_MAXSWTCASEEXPR ) then
		return FALSE
	end if

	function = TRUE

	'' find the slot using bin-search
	high = ctx.base - swtbase
	low  = -1

	do while( high - low > 1 )
		probe = cunsg(high + low) \ 2
		v = ctx.caseTB(swtbase+probe).value
		if( v < value ) then
			low = probe
		elseif( v > value ) then
			high = probe
		else
			exit function
		end if
	loop

	'' move up
	for i = ctx.base+1 to swtbase+high+1 step -1
		ctx.caseTB(i) = ctx.caseTB(i-1)
	next

	'' insert new item
	ctx.caseTB(swtbase+high).value = value
	ctx.caseTB(swtbase+high).label = label
	ctx.base += 1

end function

'':::::
''cSelConstStmtNext =   CASE (ELSE | (ConstExpression{int} (COMMA ConstExpression{int})*)) .
''
function cSelConstStmtNext( byval stk as FB_CMPSTMTSTK ptr ) as integer
	dim as ASTNODE ptr expr1, expr2
	dim as uinteger value, tovalue, maxval, minval
	dim as FBSYMBOL ptr label
	dim as integer swtbase

	function = FALSE

	'' CASE
	lexSkipToken( )

	if( stk->select.casecnt > 0 ) then
		'' break from block
		astAdd( astNewBRANCH( AST_OP_JMP, env.stmt.select.endlabel ) )
    end if

	'' ELSE
	if( lexGetToken( ) = FB_TK_ELSE ) then
		lexSkipToken( )
		stk->select.const.deflabel = symbAddLabel( NULL, TRUE )
		astAdd( astNewLABEL( stk->select.const.deflabel ) )
		stk->select.casecnt = -1

	else

		swtbase = stk->select.const.base
		minval = stk->select.const.minval
		maxval = stk->select.const.maxval

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
					hReportError( FB_ERRMSG_EXPECTEDCONST )
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

		stk->select.const.minval = minval
		stk->select.const.maxval = maxval
		stk->select.casecnt += 1

	end if

	function = TRUE

end function

'':::::
''SelConstStmtEnd =   END SELECT .
''
function cSelConstStmtEnd( byval stk as FB_CMPSTMTSTK ptr ) as integer
	dim as uinteger minval, maxval, value
	dim as FBSYMBOL ptr deflabel, tbsym
	dim as ASTNODE ptr expr, idxexpr
	dim as integer i

    '' too large?
    minval = stk->select.const.minval
    maxval = stk->select.const.maxval
    if( (minval > maxval) or _
    	(maxval - minval > FB_MAXSWTCASERANGE) or _
    	(culngint(minval) * FB_INTEGERSIZE > 4294967292ULL) ) then
    	hReportError( FB_ERRMSG_RANGETOOLARGE )
    	exit function
    end if

	'' END SELECT
	lexSkipToken( )
	lexSkipToken( )

    deflabel = stk->select.const.deflabel
    if( deflabel = NULL ) then
    	deflabel = env.stmt.select.endlabel
    end if

	'' break from block
	astAdd( astNewBRANCH( AST_OP_JMP, env.stmt.select.endlabel ) )

    '' emit comp label
    astAdd( astNewLABEL( env.stmt.select.cmplabel ) )

	'' check min val
	if( minval > 0 ) then
		expr = astNewBOP( AST_OP_LT, _
						  astNewVAR( stk->select.sym, 0, FB_DATATYPE_UINT ), _
						  astNewCONSTi( minval, FB_DATATYPE_UINT ), _
						  deflabel, FALSE )
		astAdd( expr )
	end if

	'' check max val
	expr = astNewBOP( AST_OP_GT, _
					  astNewVAR( stk->select.sym, 0, FB_DATATYPE_UINT ), _
					  astNewCONSTi( maxval, FB_DATATYPE_UINT ), _
					  deflabel, FALSE )
	astAdd( expr )

    '' jump to table[idx]
    tbsym = hJumpTbAllocSym( )

	idxexpr = astNewBOP( AST_OP_MUL, _
						 astNewVAR( stk->select.sym, 0, FB_DATATYPE_UINT ), _
    				  	 astNewCONSTi( FB_INTEGERSIZE, FB_DATATYPE_UINT ) )

    expr = astNewIDX( astNewVAR( tbsym, -minval*FB_INTEGERSIZE, FB_DATATYPE_UINT ), _
    				  idxexpr, FB_DATATYPE_UINT, NULL )

    astAdd( astNewBRANCH( AST_OP_JUMPPTR, NULL, expr ) )

    '' emit table
    astAdd( astNewLABEL( tbsym ) )

    ''
    i = stk->select.const.base
    for value = minval to maxval
    	if( value = ctx.caseTB(i).value ) then
    		astAdd( astNewJMPTB( FB_DATATYPE_UINT, ctx.caseTB(i).label ) )
    		i += 1
    	else
    		astAdd( astNewJMPTB( FB_DATATYPE_UINT, deflabel ) )
    	end if
    next

    ctx.base = stk->select.const.base

    '' emit exit label
    astAdd( astNewLABEL( env.stmt.select.endlabel ) )

	'' pop from stmt stack
	env.stmt.select = stk->last
	stackPop( @env.stmtstk )

	function = TRUE

end function
