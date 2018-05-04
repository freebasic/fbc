'' SELECT CASE AS CONST..CASE..END SELECT compound statement parsing
''
'' chng: sep/2004 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"
#include once "rtl.bi"

const FB_MAXJUMPTBSLOTS = 8192

type SELECTCTX
	base		as integer
	casevalues(0 to FB_MAXJUMPTBSLOTS-1) as ulongint
	caselabels(0 to FB_MAXJUMPTBSLOTS-1) as FBSYMBOL ptr
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
	dim as integer options = any
	dim as integer dtype = any

	''
	'' Open outer scope (perhaps not really needed, but done to match the
	'' normal SELECT CASE, also the scope might help with stack usage)
	''
	'' The scope must be created before parsing the expression given to
	'' SELECT, otherwise any temporaries it uses would be destroyed too
	'' early by astScopeBegin() because that flushes the AST dtor list.
	''
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

	'' keep track of original data type
	dtype = astGetDataType( expr )

	if( dtype <> FB_DATATYPE_UINT ) then
		if( typeGetSize( dtype ) <= typeGetSize( FB_DATATYPE_UINT ) ) then
			expr = astNewCONV( FB_DATATYPE_UINT, NULL, expr )
		else
			expr = astNewCONV( FB_DATATYPE_ULONGINT, NULL, expr )
		end if
	end if

	'' remap CHAR and WCHAR to work with cConstIntExpr()
	select case dtype
	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
		dtype = typeGetRemapType( dtype )
	end select

	'' add labels
	el = symbAddLabel( NULL, FB_SYMBOPT_NONE )
	cl = symbAddLabel( NULL, FB_SYMBOPT_NONE )

	options = 0
	if( fbLangOptIsSet( FB_LANG_OPT_SCOPE ) = FALSE ) then
		options or= FB_SYMBOPT_UNSCOPE
	end if

	'' dim temp as uinteger = expr
	sym = symbAddImplicitVar( astGetDataType( expr ), NULL, options )

	'' a) Don't bother clearing the temp var, it's just an integer
	'' b) Silence "branch crossing" warnings, the temp var won't be
	''    accessed anymore once a CASE was entered anyways
	symbSetDontInit( sym )

	if( options and FB_SYMBOPT_UNSCOPE ) then
		astAddUnscoped( astNewDECL( sym, TRUE ) )
		astAdd( astNewASSIGN( astNewVAR( sym ), expr ) )
	else
		astAdd( astNewLINK( _
			astNewDECL( sym, FALSE ), _
			astNewASSIGN( astNewVAR( sym ), expr, AST_OPOPT_ISINI ) ) )
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
	stk->select.const_.dtype = dtype
	stk->select.const_.bias = 0
	stk->select.cmplabel = cl
	stk->select.endlabel = el
	stk->select.outerscopenode = outerscopenode
end sub

private function hSelConstAddCase _
	( _
		byval swtbase as integer, _
		byval value as ulongint, _
		byval label as FBSYMBOL ptr _
	) as integer

	'' no free slots left?
	if( ctx.base >= FB_MAXJUMPTBSLOTS ) then
		return FALSE
	end if

	'' find the slot using bin-search
	var high = ctx.base - swtbase
	var low  = -1

	do while( high - low > 1 )
		dim as integer probe = cunsg(high + low) \ 2
		var v = ctx.casevalues(swtbase+probe)
		if( v < value ) then
			low = probe
		elseif( v > value ) then
			high = probe
		else
			return FALSE
		end if
	loop

	'' move up tail items to free a slot at swtbase+high
	for i as integer = ctx.base to swtbase+high+1 step -1
		ctx.casevalues(i) = ctx.casevalues(i-1)
		ctx.caselabels(i) = ctx.caselabels(i-1)
	next

	'' insert new item
	ctx.casevalues(swtbase+high) = value
	ctx.caselabels(swtbase+high) = label
	ctx.base += 1

	function = TRUE
end function

''
type RANGEVALUES
	as longint smin
	as longint smax
	as ulongint umax
end type

''
function cConstIntExprRanged _
	( _
		byval expr as ASTNODE ptr, _
		byval todtype as integer _
	) as longint

	static range( FB_SIZETYPE_BOOLEAN to FB_SIZETYPE_UINT64 ) as RANGEVALUES = _
		{ _
			/' FB_SIZETYPE_BOOLEAN '/ ( -1, 0, 0 ),  _
			/' FB_SIZETYPE_INT8    '/ ( -128, 127, 127 ), _
			/' FB_SIZETYPE_UINT8   '/ ( 0, 127, 255 ), _
			/' FB_SIZETYPE_INT16   '/ ( -32768, 32767, 32767 ), _
			/' FB_SIZETYPE_UINT16  '/ ( 0, 32767, 65535 ), _
			/' FB_SIZETYPE_INT32   '/ ( -2147483648ll, 2147483647ll, 2147483647ll ), _
			/' FB_SIZETYPE_UINT32  '/ ( 0, 2147483647ll, 4294967295ll ),  _
			/' FB_SIZETYPE_INT64   '/ ( -9223372036854775808ull, 9223372036854775807ull, 9223372036854775807ull ), _
			/' FB_SIZETYPE_UINT64  '/ ( 0, 9223372036854775807ull, 18446744073709551615ull ) _
		}

	dim as longint value = any
	dim as integer dtype = any
	dim as integer result = any
	dim as RANGEVALUES ptr r = any

	r = @range( typeGetSizeType( todtype ) )

	dtype = astGetDataType( expr )

	'' cConstIntExpr() will flush expr
	value = cConstIntExpr( expr, FB_DATATYPE_LONGINT )

	if( typeIsSigned( dtype ) ) then
		if( typeIsSigned( todtype ) ) then
			result = (value >= r->smin) and (value <= r->smax)
		else
			if( dtype = FB_DATATYPE_LONGINT and todtype = FB_DATATYPE_ULONGINT ) then
				result = (value >= 0) and (culngint(value) <= culngint(r->smax))
			else
				result = (value >= 0) and (culngint(value) <= culngint(r->umax))
			end if
		endif
	else
		if( typeIsSigned( todtype ) ) then
			if( dtype = FB_DATATYPE_ULONGINT and todtype = FB_DATATYPE_LONGINT ) then
				result = (culngint(value) <= culngint(r->smax))
			else
				result = (culngint(value) <= culngint(r->umax))
			end if
		else
			result = (culngint(value) <= r->umax)
		endif
	end if

	if( not result ) then
		errReportWarn( FB_WARNINGMSG_CONVOVERFLOW )
	end if

	function = value

end function

'' cSelConstStmtNext  =  CASE (ELSE | (ConstExpression{int} (',' ConstExpression{int})*)) .
sub cSelConstStmtNext( byval stk as FB_CMPSTMTSTK ptr )
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
	var swtbase = stk->select.const_.base

	'' add label
	var label = symbAddLabel( NULL, FB_SYMBOPT_NONE )

	do
		'' ConstExpression{int}
		dim as ulongint value = cConstIntExprRanged( cExpression( ), stk->select.const_.dtype )

		'' first case?
		if( swtbase = ctx.base ) then
			stk->select.const_.bias = value - FB_MAXJUMPTBSLOTS
		end if

		'' bias the value
		value -= stk->select.const_.bias
			
		'' TO?
		dim as ulongint tovalue
		if( lexGetToken( ) = FB_TK_TO ) then
			lexSkipToken( )

			'' ConstExpression{int}
			tovalue = cConstIntExprRanged( cExpression( ), stk->select.const_.dtype )
			tovalue -= stk->select.const_.bias

			if( tovalue < value ) then
				errReport( FB_ERRMSG_INVALIDCASERANGE )
				tovalue = value
			end if

		else
			tovalue = value
		end if

		'' not possible to fit case value range in the jump table?
		if( (tovalue - value + 1) > (FB_MAXJUMPTBSLOTS - ctx.base) ) then
			errReport( FB_ERRMSG_RANGETOOLARGE )
			continue do
		end if

		assert( value <= (FB_MAXJUMPTBSLOTS*2) )
		assert( tovalue <= (FB_MAXJUMPTBSLOTS*2) )
		assert( tovalue >= value )

		'' Add Case values in range
		do
			if( hSelConstAddCase( swtbase, value, label ) = FALSE ) then
				if( ctx.base >= FB_MAXJUMPTBSLOTS ) then
					errReport( FB_ERRMSG_TOOMANYLABELS )
				else
					errReport( FB_ERRMSG_DUPDEFINITION )
				end if
				exit do
			end if

			'' "Early" exit check to avoid overflow problems
			if( value = tovalue ) then
				exit do
			end if
			value += 1
		loop

	loop while( hMatch( CHAR_COMMA ) )

	''
	astAdd( astNewLABEL( label ) )

	'' begin scope
	stk->scopenode = astScopeBegin( )

	stk->select.casecnt += 1
end sub

'' SelConstStmtEnd =   END SELECT .
sub cSelConstStmtEnd( byval stk as FB_CMPSTMTSTK ptr )
	dim as FBSYMBOL ptr deflabel = any

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

	'' re-bias case values and set max value
	dim as ulongint span = 0
	if( ctx.base > stk->select.const_.base ) then
		dim as ulongint adjust_bias = ctx.casevalues(stk->select.const_.base)
		for i as integer = stk->select.const_.base to ctx.base - 1
			ctx.casevalues(i) -= adjust_bias
			if( ctx.casevalues(i) > span ) then
				span = ctx.casevalues(i)
			end if
		next
		stk->select.const_.bias += adjust_bias
	end if

	astAdd( astBuildJMPTB( stk->select.sym, _
	                       @ctx.casevalues(stk->select.const_.base), _
	                       @ctx.caselabels(stk->select.const_.base), _
	                       ctx.base - stk->select.const_.base, _
	                       deflabel, _
	                       stk->select.const_.bias, span ) )

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
