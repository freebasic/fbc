'' SELECT CASE AS CONST..CASE..END SELECT compound statement parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"
#include once "rtl.bi"

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
	expr = cExpression( )
	if( expr = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
		'' error recovery: fake an expr
		expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
	end if

	if( astGetDataClass( expr ) <> FB_DATACLASS_INTEGER ) then
		astDelTree( expr )
		expr = NULL

    '' CHAR and WCHAR literals are also from the INTEGER class
    else
    	select case astGetDataType( expr )
    	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
    		'' don't allow, unless it's a deref pointer
    		if( astIsDEREF( expr ) = FALSE ) then
				astDelTree( expr )
				expr = NULL
    		end if
    	end select
	end if

	if( expr = NULL ) then
		errReport( FB_ERRMSG_INVALIDDATATYPES )
		'' error recovery: fake an expr
		expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
	end if

	if( astGetDataType( expr ) <> FB_DATATYPE_UINT ) then
		expr = astNewCONV( FB_DATATYPE_UINT, NULL, expr )
	end if

	'' add labels
	el = symbAddLabel( NULL, FB_SYMBOPT_NONE )
	cl = symbAddLabel( NULL, FB_SYMBOPT_NONE )

	'' store expression into a temp var
	sym = symbAddTempVar( FB_DATATYPE_UINT )
	if( sym = NULL ) then
		exit function
	end if

	expr = astNewASSIGN( astNewVAR( sym, 0, FB_DATATYPE_UINT ), expr )
	if( expr <> NULL ) then
		astAdd( expr )
	end if

	'' skip the statements
	astAdd( astNewBRANCH( AST_OP_JMP, cl ) )

	'' push to stmt stack
	stk = cCompStmtPush( FB_TK_SELECT, _
						 FB_CMPSTMT_MASK_NOTHING )	'' nothing allowed but CASE's
	stk->select.isconst = TRUE
	stk->select.sym = sym
	stk->select.casecnt = 0
	stk->select.const_.base = ctx.base
	stk->select.const_.deflabel = NULL
	stk->select.const_.minval = &hFFFFFFFFu
	stk->select.const_.maxval = 0
	stk->select.cmplabel = cl
	stk->select.endlabel = el

	function = TRUE

end function

'':::::
private function hSelConstAddCase _
	( _
		byval swtbase as integer, _
		byval value as uinteger, _
		byval label as FBSYMBOL ptr _
	) as integer static

	dim as integer probe, high, low, i
	dim as uinteger v

	'' nothing left?
	if( ctx.base >= FB_MAXSWTCASEEXPR ) then
		return FALSE
	end if

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

	function = TRUE

end function

'':::::
''cSelConstStmtNext =   CASE (ELSE | (ConstExpression{int} (',' ConstExpression{int})*)) .
''
sub cSelConstStmtNext(byval stk as FB_CMPSTMTSTK ptr)
	dim as ASTNODE ptr expr1, expr2
	dim as uinteger value, tovalue, maxval, minval
	dim as FBSYMBOL ptr label
	dim as integer swtbase

	'' CASE
	lexSkipToken( )

	'' end scope
	if( stk->scopenode <> NULL ) then
		astScopeEnd( stk->scopenode )
	end if

	if( stk->select.casecnt > 0 ) then
		'' break from block
		astAdd( astNewBRANCH( AST_OP_JMP, stk->select.endlabel ) )
    end if

	'' ELSE?
	if( lexGetToken( ) = FB_TK_ELSE ) then
		lexSkipToken( )

		stk->select.const_.deflabel = symbAddLabel( NULL )
		astAdd( astNewLABEL( stk->select.const_.deflabel ) )

		'' begin scope
		stk->scopenode = astScopeBegin( )

		stk->select.casecnt = -1

		return
	end if

	'' ConstExpression{int} ((',' | TO) ConstExpression{int})*
	swtbase = stk->select.const_.base

	'' add label
	label = symbAddLabel( NULL, FB_SYMBOPT_NONE )

	do
		expr1 = cExpression( )
		if( expr1 = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
			'' error recovery: fake an expr
			expr1 = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
		end if

		if( astIsCONST( expr1 ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDCONST )
			'' error recovery: skip until next ',' and fake an expr
			if( lexGetToken( ) <> FB_TK_TO ) then
				hSkipUntil( CHAR_COMMA )
			end if
			astDelTree( expr1 )
			expr1 = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
		end if

		value = astGetValueAsInt( expr1 )
		astDelNode( expr1 )

		minval = stk->select.const_.minval
		maxval = stk->select.const_.maxval

		'' TO?
		if( lexGetToken( ) = FB_TK_TO ) then
			lexSkipToken( )

			expr2 = cExpression( )
			if( expr2 = NULL ) then
				errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
				'' error recovery: skip until next ',' and fake an expr
				hSkipUntil( CHAR_COMMA )
				expr2 = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
			end if

			if( astIsCONST( expr2 ) = FALSE ) then
				errReport( FB_ERRMSG_EXPECTEDCONST )
				'' error recovery: fake an expr
				astDelTree( expr2 )
				expr2 = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
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

					errReport( FB_ERRMSG_RANGETOOLARGE )
					'' error recovery: reset values
					minval = stk->select.const_.minval
					maxval = stk->select.const_.maxval
				else
					'' add item
					if( hSelConstAddCase( swtbase, value, label ) = FALSE ) then
						errReport( FB_ERRMSG_DUPDEFINITION )
					end if
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

				errReport( FB_ERRMSG_RANGETOOLARGE )
				'' error recovery: reset values
				minval = stk->select.const_.minval
				maxval = stk->select.const_.maxval
			else
				'' add item
				if( hSelConstAddCase( swtbase, value, label ) = FALSE ) then
					errReport( FB_ERRMSG_DUPDEFINITION )
				end if
			end if

		end if

		stk->select.const_.minval = minval
		stk->select.const_.maxval = maxval

	loop while( hMatch( CHAR_COMMA ) )

	''
	astAdd( astNewLABEL( label ) )

	'' begin scope
	stk->scopenode = astScopeBegin( )

	stk->select.casecnt += 1
end sub

'':::::
''SelConstStmtEnd =   END SELECT .
''
sub cSelConstStmtEnd(byval stk as FB_CMPSTMTSTK ptr)
	dim as uinteger minval, maxval, value
	dim as FBSYMBOL ptr deflabel, tbsym
	dim as ASTNODE ptr expr, idxexpr
	dim as integer i

    minval = stk->select.const_.minval
    maxval = stk->select.const_.maxval

	'' END SELECT
	lexSkipToken( )
	lexSkipToken( )

    deflabel = stk->select.const_.deflabel
    if( deflabel = NULL ) then
    	deflabel = stk->select.endlabel
    end if

	'' end scope
	if( stk->scopenode <> NULL ) then
		astScopeEnd( stk->scopenode )
	end if

	'' break from block
	astAdd( astNewBRANCH( AST_OP_JMP, stk->select.endlabel ) )

    '' emit comp label
    astAdd( astNewLABEL( stk->select.cmplabel ) )

	'' check min val
	if( minval > 0 ) then
		expr = astNewBOP( AST_OP_LT, _
						  astNewVAR( stk->select.sym, 0, FB_DATATYPE_UINT ), _
						  astNewCONSTi( minval, FB_DATATYPE_UINT ), _
						  deflabel, _
						  AST_OPOPT_NONE )
		astAdd( expr )
	end if

	'' check max val
	expr = astNewBOP( AST_OP_GT, _
					  astNewVAR( stk->select.sym, 0, FB_DATATYPE_UINT ), _
					  astNewCONSTi( maxval, FB_DATATYPE_UINT ), _
					  deflabel, _
					  AST_OPOPT_NONE )
	astAdd( expr )

    '' jump to table[idx]
    tbsym = hJumpTbAllocSym( )

	idxexpr = astNewBOP( AST_OP_MUL, _
						 astNewVAR( stk->select.sym, 0, FB_DATATYPE_UINT ), _
    				  	 astNewCONSTi( FB_POINTERSIZE, FB_DATATYPE_UINT ) )

    expr = astNewIDX( astNewVAR( tbsym, -minval * FB_POINTERSIZE, typeAddrOf( FB_DATATYPE_VOID ) ), _
    				  idxexpr, typeAddrOf( FB_DATATYPE_VOID ), NULL )

	'' not high-level IR? emit the jump before the table
	if( irGetOption( IR_OPT_HIGHLEVEL ) = FALSE ) then
    	astAdd( astNewBRANCH( AST_OP_JUMPPTR, NULL, expr ) )
    end if

    '' emit table
    astAdd( astNewJMPTB_Begin( tbsym ) )

    ''
    i = stk->select.const_.base
    for value = minval to maxval
    	if( value = ctx.caseTB(i).value ) then
    		astAdd( astNewJMPTB_Label( FB_DATATYPE_UINT, ctx.caseTB(i).label ) )
    		i += 1
    	else
    		astAdd( astNewJMPTB_Label( FB_DATATYPE_UINT, deflabel ) )
    	end if
    next

    ctx.base = stk->select.const_.base

    astAdd( astNewJMPTB_End( tbsym ) )

	'' high-level IR? emit the jump after the table
	if( irGetOption( IR_OPT_HIGHLEVEL ) ) then
    	astAdd( astNewBRANCH( AST_OP_JUMPPTR, NULL, expr ) )
    end if

    '' emit exit label
    astAdd( astNewLABEL( stk->select.endlabel ) )

	'' pop from stmt stack
	cCompStmtPop( stk )
end sub
