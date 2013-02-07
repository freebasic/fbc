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

type SELECTCTX
	base		as integer
	casevalues(0 to FB_MAXSWTCASEEXPR-1) as uinteger
	caselabels(0 to FB_MAXSWTCASEEXPR-1) as FBSYMBOL ptr
end type

dim shared ctx as SELECTCTX

sub parserSelConstStmtInit( )
	ctx.base = 0
end sub

sub parserSelConstStmtEnd( )
end sub

'':::::
''SelConstStmtBegin =   SELECT CASE AS CONST Expression{int} .
''
sub cSelConstStmtBegin()
    dim as ASTNODE ptr expr
	dim as FBSYMBOL ptr sym, el, cl
	dim as FB_CMPSTMTSTK ptr stk

	'' Open outer scope (perhaps not really needed, but done to match the
	'' normal SELECT CASE, also the scope might help with stack usage)
	dim as ASTNODE ptr outerscopenode = astScopeBegin( )
	if( outerscopenode = NULL ) then
		errReport( FB_ERRMSG_RECLEVELTOODEEP )
	end if

	'' Expression
	expr = cExpression( )
	if( expr = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
		'' error recovery: fake an expr
		expr = astNewCONSTi( 0 )
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
		expr = astNewCONSTi( 0 )
	end if

	if( astGetDataType( expr ) <> FB_DATATYPE_UINT ) then
		expr = astNewCONV( FB_DATATYPE_UINT, NULL, expr )
	end if

	'' add labels
	el = symbAddLabel( NULL, FB_SYMBOPT_NONE )
	cl = symbAddLabel( NULL, FB_SYMBOPT_NONE )

	'' temp = expr
	sym = symbAddTempVar( FB_DATATYPE_UINT )
	astAdd( astBuildVarAssign( sym, expr ) )

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
	stk->select.outerscopenode = outerscopenode
end sub

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
		v = ctx.casevalues(swtbase+probe)
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
		ctx.casevalues(i) = ctx.casevalues(i-1)
		ctx.caselabels(i) = ctx.caselabels(i-1)
	next

	'' insert new item
	ctx.casevalues(swtbase+high) = value
	ctx.caselabels(swtbase+high) = label
	ctx.base += 1

	function = TRUE

end function

'' cSelConstStmtNext  =  CASE (ELSE | (ConstExpression{int} (',' ConstExpression{int})*)) .
sub cSelConstStmtNext( byval stk as FB_CMPSTMTSTK ptr )
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
		'' ConstExpression{int}
		value = cIntConstExprValue( 0 )

		minval = stk->select.const_.minval
		maxval = stk->select.const_.maxval

		'' TO?
		if( lexGetToken( ) = FB_TK_TO ) then
			lexSkipToken( )

			tovalue = cIntConstExprValue( 0 )

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

'' SelConstStmtEnd =   END SELECT .
sub cSelConstStmtEnd( byval stk as FB_CMPSTMTSTK ptr )
	dim as uinteger minval = any, maxval = any
	dim as FBSYMBOL ptr deflabel = any

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

	astAdd( astBuildJMPTB( stk->select.sym, _
	                       @ctx.casevalues(stk->select.const_.base), _
	                       @ctx.caselabels(stk->select.const_.base), _
	                       ctx.base - stk->select.const_.base, _
	                       deflabel, minval, maxval ) )

    ctx.base = stk->select.const_.base

    '' emit exit label
    astAdd( astNewLABEL( stk->select.endlabel ) )

	'' Close the outer scope block
	if( stk->select.outerscopenode <> NULL ) then
		astScopeEnd( stk->select.outerscopenode )
	end if

	'' pop from stmt stack
	cCompStmtPop( stk )
end sub
