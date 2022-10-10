'' misc AST function
''
'' chng: sep/2004 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "list.bi"
#include once "ir.bi"
#include once "rtl.bi"
#include once "ast.bi"
#include once "hlp.bi"

declare sub astReplaceSymbolOnCALL _
	( _
		byval n as ASTNODE ptr, _
		byval old_sym as FBSYMBOL ptr, _
		byval new_sym as FBSYMBOL ptr _
	)

sub astMiscInit( )
	listInit( @ast.dtorlist, 64, len( AST_DTORLIST_ITEM ), LIST_FLAGS_NOCLEAR )
	with( ast.dtorlistscopes )
		.cookies = NULL
		.count = 0
		.room = 0
	end with
	ast.dtorlistcookies = 0
	ast.flushdtorlist = TRUE
end sub

sub astMiscEnd( )
	with( ast.dtorlistscopes )
		assert( .count = 0 )
		deallocate( .cookies )
	end with
	listEnd( @ast.dtorlist )
end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' tree scanning
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

''::::
function astIsTreeEqual _
	( _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr _
	) as integer

	function = FALSE

	if( (l = NULL) or (r = NULL) ) then
		if( l = r ) then
			function = TRUE
		end if
		exit function
	end if

	if( l->class <> r->class ) then
		exit function
	end if

	if( astGetFullType( l ) <> astGetFullType( r ) ) then
		exit function
	end if

	if( l->subtype <> r->subtype ) then
		exit function
	end if

	select case as const l->class
	case AST_NODECLASS_VAR
		if( l->sym <> r->sym ) then
			exit function
		end if

		if( l->var_.ofs <> r->var_.ofs ) then
			exit function
		end if

	case AST_NODECLASS_FIELD
		if( l->sym <> r->sym ) then
			exit function
		end if

	case AST_NODECLASS_CONST
		select case( typeGetClass( l->dtype ) )
		case FB_DATACLASS_FPOINT
			if( l->val.f <> r->val.f ) then
				exit function
			end if

		case FB_DATACLASS_INTEGER
			if( l->val.i <> r->val.i ) then
				exit function
			end if

		end select

	case AST_NODECLASS_DEREF
		if( l->ptr.ofs <> r->ptr.ofs ) then
			exit function
		end if

	case AST_NODECLASS_IDX
		if( l->idx.ofs <> r->idx.ofs ) then
			exit function
		end if

		if( l->idx.mult <> r->idx.mult ) then
			exit function
		end if

	case AST_NODECLASS_BOP
		if( l->op.op <> r->op.op ) then
			exit function
		end if

		if( l->op.options <> r->op.options ) then
			exit function
		end if

		if( l->op.ex <> r->op.ex ) then
			exit function
		end if

	case AST_NODECLASS_UOP
		if( l->op.op <> r->op.op ) then
			exit function
		end if

		if( l->op.options <> r->op.options ) then
			exit function
		end if

	case AST_NODECLASS_ADDROF
		if( l->sym <> r->sym ) then
			exit function
		end if

		if( l->op.op <> r->op.op ) then
			exit function
		end if

	case AST_NODECLASS_OFFSET
		if( l->sym <> r->sym ) then
			exit function
		end if

		if( l->ofs.ofs <> r->ofs.ofs ) then
			exit function
		end if

	case AST_NODECLASS_CONV
		'' do nothing, the l child will be checked below

	case AST_NODECLASS_CALL, AST_NODECLASS_BRANCH, _
		 AST_NODECLASS_LOAD, AST_NODECLASS_ASSIGN, _
		 AST_NODECLASS_LINK
		'' unpredictable nodes
		exit function

	end select

	'' check childs
	if( astIsTreeEqual( l->l, r->l ) = FALSE ) then
		exit function
	end if

	if( astIsTreeEqual( l->r, r->r ) = FALSE ) then
		exit function
	end if

	''
	function = TRUE

end function

''
'' Check whether two parameter initializers are the same (for comparing
'' initializer expressions from prototype and body). This is basically the same
'' as astIsTreeEqual(), except it allows CALLs and such aswell as temp vars,
'' because for a param initializer those things can be treated equal.
''
'' For example, two calls f(1) and f(1) are equal as far as param initializers
'' are concerned, but astIsTreeEqual() wouldn't treat them as equal, so we need
'' a custom function.
''
'' Also, two expressions such as iif(a,b,c) and iif(a,b,c) are equal for param
'' initializers. The two iif()'s will use separate temp vars, causing
'' astIsTreeEqual() to treat them as different, but that doesn't matter for
'' param initializers where the expression and the temp vars it uses will be
'' duplicated & inserted into the call scopes.
''
'' Temp labels stored in BOP's or LOOP's ASTNODE.op.ex field should be treated
'' equal too (e.g. used by iif()).
''
function astIsEqualParamInit _
	( _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr _
	) as integer

	function = FALSE

	if( (l = NULL) or (r = NULL) ) then
		if( l = r ) then
			function = TRUE
		end if
		exit function
	end if

	if( l->class <> r->class ) then
		exit function
	end if

	if( l->dtype <> r->dtype ) then
		exit function
	end if

	if( l->subtype <> r->subtype ) then
		'' If it's a function pointer, the subtype may point to different proc
		'' symbols, but if they have the same signature they should still be
		'' treated equal here.
		if( typeGetDtOnly( l->dtype ) = FB_DATATYPE_FUNCTION ) then
			if( symbCalcProcMatch( l->subtype, r->subtype, 0 ) = FB_OVLPROC_NO_MATCH ) then
				exit function
			end if
		else
			exit function
		end if
	end if

	select case as const( l->class )
	case AST_NODECLASS_LINK
		if( l->link.ret <> r->link.ret ) then
			exit function
		end if

	case AST_NODECLASS_VAR
		'' VARs must access the same symbol, unless they're accessing
		'' temp vars. Those will be duplicated anyways when the param
		'' initializer is inserted in a call.
		if( l->sym <> r->sym ) then
			if( symbIsTemp( l->sym ) = FALSE ) then
				exit function
			end if
			if( symbIsTemp( r->sym ) = FALSE ) then
				exit function
			end if
		end if

		if( l->var_.ofs <> r->var_.ofs ) then
			exit function
		end if

	case AST_NODECLASS_FIELD
		if( l->sym <> r->sym ) then
			if( symbIsTemp( l->sym ) = FALSE ) then
				exit function
			end if
			if( symbIsTemp( r->sym ) = FALSE ) then
				exit function
			end if
		end if

	case AST_NODECLASS_CONST
		if( typeGetClass( l->dtype ) = FB_DATACLASS_FPOINT ) then
			if( l->val.f <> r->val.f ) then
				exit function
			end if
		else
			assert( typeGetClass( l->dtype ) = FB_DATACLASS_INTEGER )
			if( l->val.i <> r->val.i ) then
				exit function
			end if
		end if

	case AST_NODECLASS_DEREF
		if( l->ptr.ofs <> r->ptr.ofs ) then
			exit function
		end if

	case AST_NODECLASS_IDX
		if( l->idx.ofs <> r->idx.ofs ) then
			exit function
		end if

		if( l->idx.mult <> r->idx.mult ) then
			exit function
		end if

	case AST_NODECLASS_BOP, AST_NODECLASS_UOP
		if( l->op.op <> r->op.op ) then
			exit function
		end if

		if( l->op.options <> r->op.options ) then
			exit function
		end if

	case AST_NODECLASS_ADDROF
		if( l->sym <> r->sym ) then
			if( symbIsTemp( l->sym ) = FALSE ) then
				exit function
			end if
			if( symbIsTemp( r->sym ) = FALSE ) then
				exit function
			end if
		end if

		if( l->op.op <> r->op.op ) then
			exit function
		end if

	case AST_NODECLASS_OFFSET
		if( l->sym <> r->sym ) then
			if( symbIsTemp( l->sym ) = FALSE ) then
				exit function
			end if
			if( symbIsTemp( r->sym ) = FALSE ) then
				exit function
			end if
		end if

		if( l->ofs.ofs <> r->ofs.ofs ) then
			exit function
		end if

	case AST_NODECLASS_CALL
		if( l->sym <> r->sym ) then
			exit function
		end if
	end select

	if( astIsEqualParamInit( l->l, r->l ) = FALSE ) then
		exit function
	end if

	if( astIsEqualParamInit( l->r, r->r ) = FALSE ) then
		exit function
	end if

	function = TRUE
end function

function astHasSideFx( byval n as ASTNODE ptr ) as integer
	if( n = NULL ) then
		exit function
	end if

	'' Most CALLs are treated as having side-effects, i.e. mustn't be
	'' duplicated. But for some RTL procedures we know that it's safe to
	'' duplicate calls to them, so they can be excluded here (but the CALL's
	'' arguments must still be checked recursively)
	if( n->class = AST_NODECLASS_CALL ) then
		assert( symbIsProc( n->sym ) )
		if( (n->sym->stats and FB_SYMBSTATS_CANBECLONED) = 0 ) then
			return TRUE
		end if
	end if

	if( astHasSideFx( n->l ) ) then
		return TRUE
	end if
	function = astHasSideFx( n->r )
end function

''::::
function astIsSymbolOnTree _
	( _
		byval sym as FBSYMBOL ptr, _
		byval n as ASTNODE ptr _
	) as integer

	dim as FBSYMBOL ptr s = any

	if( n = NULL ) then
		return FALSE
	end if

	select case as const n->class
	case AST_NODECLASS_VAR, AST_NODECLASS_IDX, AST_NODECLASS_FIELD, _
		 AST_NODECLASS_ADDROF, AST_NODECLASS_OFFSET

		s = astGetSymbol( n )
		'' same symbol?
		if( s = sym ) then
			return TRUE
		end if

		'' passed by ref or by desc? can't do any assumption..
		if( s <> NULL ) then
			if (symbIsParamVarBydescOrByref(s)) then
				return TRUE
			end if
		end if

	'' pointer? could be pointing to source symbol too..
	case AST_NODECLASS_DEREF
		return TRUE
	end select

	'' walk
	if( n->l <> NULL ) then
		if( astIsSymbolOnTree( sym, n->l ) ) then
			return TRUE
		end if
	end if

	if( n->r <> NULL ) then
		if( astIsSymbolOnTree( sym, n->r ) ) then
			return TRUE
		end if
	end if

	function = FALSE

end function

'':::::
sub astReplaceSymbolOnTree _
	( _
		byval n as ASTNODE ptr, _
		byval old_sym as FBSYMBOL ptr, _
		byval new_sym as FBSYMBOL ptr _
	)

	if( n = NULL ) then
		return
	end if

	if( n->sym = old_sym ) then
		n->sym = new_sym
	end if

	'' assuming no other complex node will be on the
	'' tree (TypeIniTree's won't have blocks, breaks, etc)

	select case as const n->class
	case AST_NODECLASS_BOP, AST_NODECLASS_UOP, _
	     AST_NODECLASS_BRANCH, AST_NODECLASS_LOOP
		if( n->op.ex = old_sym ) then
			n->op.ex = new_sym
		end if

	case AST_NODECLASS_IIF
		if( n->iif.falselabel = old_sym ) then
			n->iif.falselabel = new_sym
		end if

	case AST_NODECLASS_CALL
		'' too complex, let a helper function replace the symbols
		astReplaceSymbolOnCALL( n, old_sym, new_sym )

	end select

	'' walk
	if( n->l <> NULL ) then
		astReplaceSymbolOnTree( n->l, old_sym, new_sym )
	end if

	if( n->r <> NULL ) then
		astReplaceSymbolOnTree( n->r, old_sym, new_sym )
	end if

end sub

sub astReplaceFwdref _
	( _
		byval n as ASTNODE ptr, _
		byval oldsubtype as FBSYMBOL ptr, _
		byval newdtype as integer, _
		byval newsubtype as FBSYMBOL ptr _
	)

	if( (typeGetDtOnly( n->dtype ) = FB_DATATYPE_FWDREF) and _
	    (n->subtype = oldsubtype) ) then
		n->dtype = typeMerge( n->dtype, newdtype )
		n->subtype = newsubtype
	end if

	if( n->l ) then
		astReplaceFwdref( n->l, oldsubtype, newdtype, newsubtype )
	end if
	if( n->r ) then
		astReplaceFwdref( n->r, oldsubtype, newdtype, newsubtype )
	end if

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' const helpers
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

function astIsConstant( byval expr as ASTNODE ptr ) as integer
	'' Checks whether an expression is a CONST node (number literals,
	'' numeric constants), an access to a constant symbol (string literals
	'' and string constants are accessed through VAR nodes), or whether it
	'' has CONST on its data type.

	if( expr->sym ) then
		if( symbIsConstant( expr->sym ) ) then
			return TRUE
		end if
	end if

	return (astIsCONST( expr ) or typeIsConst( astGetFullType( expr ) ))
end function

'':::::
function astGetStrLitSymbol _
	( _
		byval n as ASTNODE ptr _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr s = any

	function = NULL

	if( astIsVAR( n ) ) then
		s = astGetSymbol( n )
		if( s <> NULL ) then
			if( symbGetIsLiteral( s ) ) then
				function = s
			end if
		end if
	end if

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' checks
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

sub astCheckConst _
	( _
		byval dtype as integer, _
		byval n as ASTNODE ptr _
	)

	dim as integer result = any
	dim as double dval = any
	dim as single sval = any
	dim as longint lval = any

	result = TRUE

	''
	'' We don't want to show overflow warnings for conversions where only
	'' the sign differs, such as integer <-> uinteger, because in that case
	'' there is no data/precision loss. Technically speaking there can be
	'' overflows in such a conversion, but it's trivial to convert back
	'' and nothing is lost. It would probably be rather annoying to have
	'' warnings about it in many cases, such as:
	''    dim a as uinteger = -1
	''    dim b as uinteger = 1 shl 31
	''
	'' TODO: handle bitfields
	''

	select case as const( typeGetDtAndPtrOnly( dtype ) )
	''case FB_DATATYPE_DOUBLE
		'' DOUBLE can hold all the other dtype's values;
		'' perhaps not with 100% precision (e.g. huge ULONGINTs will
		'' lose some least-significant digits), but the DOUBLE doesn't
		'' overflow to INF (the same can be seen with SINGLEs, but at
		'' least those can be overflown with really huge DOUBLEs).
		'' Thus, no checks are needed for DOUBLE.

	case FB_DATATYPE_SINGLE
		'' anything to SINGLE: show warning when out of SINGLE limits
		'' min = 1.401298e-45
		'' max = 3.402823e+38

		dval = astConstGetAsDouble( n )

		select case abs( dval )
		case 0.0, 2e-45 to 3e+38 '' definitely no overflow: comfortably within SINGLE bounds
			result = TRUE
		case else '' might overflow - slower/more thorough test

			sval = csng( dval )

			#define IS_INFINITY_OR_ZERO(x) ( (x) + (x) = (x) )
			'' if sval is infinity or 0, then dval must also have been otherwise there was an overflow/underflow
			if IS_INFINITY_OR_ZERO( sval ) then
				result = IS_INFINITY_OR_ZERO( dval )
			else
				result = TRUE
			end if
		end select

	case FB_DATATYPE_BOOLEAN
		lval = astConstGetAsInt64( n )
		result = (lval = 0) or (lval = 1) or (lval = -1)

	case else
		'' TODO: bitfields

		select case as const( typeGetSizeType( dtype ) )
		case FB_SIZETYPE_INT8, FB_SIZETYPE_UINT8
			lval = astConstGetAsInt64( n )
			result = ((lval >= -128) and (lval <= 255))

		case FB_SIZETYPE_INT16, FB_SIZETYPE_UINT16
			lval = astConstGetAsInt64( n )
			result = ((lval >= -32768) and (lval <= 65535))

		case FB_SIZETYPE_INT32, FB_SIZETYPE_UINT32
			lval = astConstGetAsInt64( n )
			result = ((lval >= -2147483648ll) and (lval <= 4294967295ll))

		case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64
			'' longints can hold most other type's values, except floats
			'' float?
			if( typeGetClass( n->dtype ) = FB_DATACLASS_FPOINT ) then
				dval = astConstGetAsDouble( n )
				result = ((dval >= -9223372036854775808ull) and _
					  (dval <= 18446744073709551615ull))
			end if
		end select

	end select

	if( (result = FALSE) and astShouldShowWarnings( ) ) then
		errReportWarn( FB_WARNINGMSG_CONVOVERFLOW )
	end if
end sub

function astPtrCheck _
	( _
		byval pdtype as integer, _
		byval psubtype as FBSYMBOL ptr, _
		byval pparammode as integer, _
		byval expr as ASTNODE ptr _
	) as integer

	assert( typeIsPtr( pdtype ) )
	function = FALSE
	var edtype = astGetFullType( expr )

	'' expr not a pointer?
	if( typeIsPtr( edtype ) = FALSE ) then
		'' Only ok if it's a 0 constant
		if( astIsCONST( expr ) ) then
			if( typeGetClass( edtype ) = FB_DATACLASS_INTEGER ) then
				function = astConstEqZero( expr )
			end if
		end if
		exit function
	end if

	'' Are ANY PTRs involved? Then we don't need to do exact type checks
	if( typeGetDtOnly( pdtype ) = FB_DATATYPE_VOID ) then
		if( typeGetDtOnly( edtype ) = FB_DATATYPE_VOID ) then
			return TRUE
		end if
		return (typeGetPtrCnt( pdtype ) <= typeGetPtrCnt( edtype ))
	elseif( typeGetDtOnly( edtype ) = FB_DATATYPE_VOID ) then
		return (typeGetPtrCnt( pdtype ) >= typeGetPtrCnt( edtype ))
	end if

	'' Check type compatibility, but without checking CONSTness. Users of astPtrCheck()
	'' do this manually already (and if there is a CONSTness mismatch, they show an error,
	'' not just a warning, which is astPtrCheck()'s main purpose).
	function = (typeCalcMatch( typeGetDtAndPtrOnly( pdtype ), psubtype, pparammode, _
	                           typeGetDtAndPtrOnly( edtype ), expr->subtype ) > FB_OVLPROC_NO_MATCH)
end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' node type update
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

function astUpdStrConcat( byval n as ASTNODE ptr ) as ASTNODE ptr
	dim as ASTNODE ptr l = any, r = any

	function = n

	if( n = NULL ) then
		exit function
	end if

	select case as const astGetDataType( n )
	case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
		 FB_DATATYPE_WCHAR

	case else
		exit function
	end select

	'' walk
	l = n->l
	if( l <> NULL ) then
		n->l = astUpdStrConcat( l )
	end if

	r = n->r
	if( r <> NULL ) then
		n->r = astUpdStrConcat( r )
	end if

	'' convert "string + string" to "StrConcat( string, string )"
	if( n->class = AST_NODECLASS_BOP ) then
		if( n->op.op = AST_OP_ADD ) then
			l = n->l
			r = n->r
			dim as integer ldtype = astGetDataType( l ), rdtype = astGetDataType( r )
			if( astGetDataType( n ) <> FB_DATATYPE_WCHAR ) then
				function = rtlStrConcat( l, ldtype, r, rdtype )
			else
				function = rtlWstrConcat( l, ldtype, r, rdtype )
			end if
			astDelNode( n )
		end if
	end if

end function

'' Turn a comparison expression (or anything that can be compared = 0)
'' into a (conditional) branch
function astBuildBranch _
	( _
		byval expr as ASTNODE ptr, _
		byval label as FBSYMBOL ptr, _
		byval is_inverse as integer, _
		byval is_iif as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any, parentlink = any, m = any
	dim as integer dtype = any, call_dtors = any
	dim as FBSYMBOL ptr temp = any

	if( expr = NULL ) then
		return NULL
	end if

	'' Optimize here already to ensure the toplevel BOP is final and can be
	'' relied upon for x86 flag assumptions below
	expr = astOptimizeTree( expr )

	dtype = astGetDataType( expr )

	'' string? invalid..
	if( typeGetClass( dtype ) = FB_DATACLASS_STRING ) then
		return NULL
	end if

	'' CHAR and WCHAR literals are also from the INTEGER class
	select case as const dtype
	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
		'' don't allow, unless it's a deref pointer
		if( astIsDEREF( expr ) = FALSE ) then
			return NULL
		end if

	'' UDT or CLASS?
	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		dim as FB_ERRMSG err_num = any
		dim as FBSYMBOL ptr ovlProc = any

		'' check for a scalar overload..
		ovlProc = symbFindCastOvlProc( FB_DATATYPE_VOID, NULL, expr, @err_num )
		if( ovlProc = NULL ) then
			'' no? try pointers...
			ovlProc = symbFindCastOvlProc( typeAddrOf( FB_DATATYPE_VOID ), NULL, expr, @err_num )
			if( ovlProc = NULL ) then
				ovlProc = symbGetCompOpOvlHead( expr->subtype, AST_OP_CAST )
				if( ovlProc = NULL ) then
					errReport( FB_ERRMSG_NOMATCHINGPROC, TRUE, _
					           " """ & *symbGetName( expr->subtype ) & ".cast()""" )
					return NULL
				end if

				errReport( FB_ERRMSG_NOMATCHINGPROC, TRUE )
				return NULL
			end if
		end if

		'' build cast call
		expr = astBuildCall( ovlProc, expr )
		dtype = astGetDataType( expr )

	end select

	'' If the condition expression uses temp vars, we may have to call their
	'' dtors before branching (or instead insert the dtor calls at the two
	'' possible code blocks reached after the conditional branch).
	''
	'' For iif(), it's better to call the temp var dtors later, because
	'' we're still in the middle of an expression. A manual call to
	'' astDtorListFlush() may accidentally emit dtor calls for temp vars
	'' outside the iif(), e.g. in a statement like:
	''    foo = returnUdt( ).field + iif( returnUdt.field = 0, 1, 2 )
	''
	'' If it's a statement though (IF blocks, WHILE/UNTIL loops), we must
	'' call the temp var dtors manually (instead of letting astAdd() do it)
	'' in front of the branch, or else astAdd() would insert them behind
	'' the branch, where they would be unreachable dead code.
	''
	'' This only affects astBuildBranch() calls that may use a condition
	'' expression with temp vars, and are not immediately astAdd()'ed,
	'' but LINKed together with something instead.

	'' Update any remaining TYPEINIs in the condition expression, in case
	'' they result in temp vars with dtors, otherwise astAdd() later would
	'' do that, causing the dtor calls to appear at the end of the
	'' statement (i.e. as dead code behind the branch...)
	expr = astTypeIniUpdate( expr )

	call_dtors = not (is_iif or astDTorListIsEmpty( ))

	if( call_dtors = FALSE ) then
		'' Skip LINK nodes, if any
		n = expr
		parentlink = NULL
		while( n->class = AST_NODECLASS_LINK )
			parentlink = n
			select case n->link.ret
			case AST_LINK_RETURN_LEFT
				n = n->l
			case AST_LINK_RETURN_RIGHT
				n = n->r
			case else
				n = NULL
			end select
		wend

		assert( n )

		select case( n->class )
		case AST_NODECLASS_CONST
			'' Note: a CONST expression will never use temp vars.
			'' Although the AST may have dtors registered from other parts
			'' of the expression if it's an iif(), iif() will (currently)
			'' optimize out itself when the condition is CONST, so this
			'' case never happens.
			assert( is_iif = FALSE )
			assert( call_dtors = FALSE )

			'' If the condition is...
			'' a) false (or true but inverted), emit a simple jump to jump
			''    over the IF block.
			'' b) true (or false but inverted), don't emit a jump at all,
			''    but fall trough to the IF block.
			if( astConstEqZero( n ) <> is_inverse ) then
				m = astNewBRANCH( AST_OP_JMP, label, NULL )
			else
				m = astNewNOP( )
			end if

			astDelNode( n )
			n = m

		case AST_NODECLASS_BOP

			'' relational operator?
			select case as const( n->op.op )
			case AST_OP_EQ, AST_OP_NE, AST_OP_GT, _
			     AST_OP_LT, AST_OP_GE, AST_OP_LE

				'' Not possible if dtors have to be called,
				'' since they must be emitted in between the
				'' expression and the branch...
				assert( call_dtors = FALSE )

				'' Directly update this BOP to do the branch itself
				n->op.ex = label
				if( is_inverse = FALSE ) then
					n->op.op = astGetInverseLogOp( n->op.op )
				end if

			'' BOP that sets x86 flags?
			case AST_OP_ADD, AST_OP_SUB, AST_OP_SHL, AST_OP_SHR, _
			     AST_OP_AND, AST_OP_OR, AST_OP_XOR, AST_OP_IMP
			     ''AST_OP_EQV -- NOT doesn't set any flags, so EQV can't be optimized (x86 assumption)

				'' Can't optimize if dtors have be called, they'd trash the flags
				assert( call_dtors = FALSE )

				dim as integer doopt = any

				if( typeGetClass( dtype ) = FB_DATACLASS_INTEGER ) then
					doopt = irGetOption( IR_OPT_CPUBOPFLAGS )
					if( doopt ) then
						select case as const dtype
						case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
							'' can't be done with longints either, as flag is set twice
							doopt = irGetOption( IR_OPT_64BITCPUREGS )
						end select
					end if
				else
					doopt = irGetOption( IR_OPT_FPUBOPFLAGS )
				end if

				if( doopt ) then
					'' Check against zero (= FALSE), relying on the flags set by the BOP;
					'' so it must not be removed by later astAdd() optimizations.
					n = astNewBRANCH( iif( is_inverse, AST_OP_JNE, AST_OP_JEQ ), label, n )
				else
					n = NULL
				end if

			case else
				n = NULL
			end select

		case else
			n = NULL
		end select

		'' An optimization was done?
		if( n ) then
			'' Update the parent LINK node, if any
			if( parentlink ) then
				select case parentlink->link.ret
				case AST_LINK_RETURN_LEFT
					parentlink->l = n
				case AST_LINK_RETURN_RIGHT
					parentlink->r = n
				case else
					expr = n
				end select
			else
				'' Otherwise the whole expression was replaced
				expr = n
			end if

			return expr
		end if
	else
		n = NULL
	end if

	'' No optimization could be done, check expression against zero

	'' Remap zstring/wstring types, we don't want the temp var to be a
	'' string, or the comparison against zero to be a string comparison...
	select case( dtype )
	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
		dtype = typeRemap( dtype )
	end select

	if( call_dtors ) then
		'' 1. assign the condition to a temp var
		temp = symbAddTempVar( dtype, expr->subtype )
		n = astBuildVarAssign( temp, expr, AST_OPOPT_ISINI )

		'' 2. call dtors
		n = astNewLINK( n, astDtorListFlush( ), AST_LINK_RETURN_NONE )

		'' 3. branch if tempvar = zero
		expr = astNewVAR( temp )
	end if

	'' Check expression against zero (= FALSE)
	n = astNewLINK( n, _
		astNewBOP( iif( is_inverse, AST_OP_NE, AST_OP_EQ ), _
			expr, astNewCONSTz( dtype, expr->subtype ), _
			label, AST_OPOPT_NONE ), AST_LINK_RETURN_NONE )

	function = n
end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' temp destructors handling
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

private function hHasDtor( byval sym as FBSYMBOL ptr ) as integer
	assert( symbIsVar( sym ) )
	assert( symbIsRef( sym ) = FALSE )

	'' Everything with a destructor (classes)
	function = symbHasDtor( sym )

	'' But also dynamic [w]strings
	select case( symbGetType( sym ) )
	case FB_DATATYPE_STRING
		function = TRUE

	case typeAddrOf( FB_DATATYPE_WCHAR )
		if( symbGetIsWstring( sym ) ) then
			function = TRUE
		end if

	end select
end function

#if __FB_DEBUG__
sub astDtorListDump( )
	dim as AST_DTORLIST_ITEM ptr i = any

	print "-------------- dtorlist: ------------------"
	i = listGetTail( @ast.dtorlist )
	while( i )
		if( i->cookie = -1 ) then
			print "    "; "*deleted*"; " cookie: ";i->cookie;" refcount: ";i->refcount
		else
			print "    ";symbDumpToStr( i->sym );" cookie: ";i->cookie;" refcount: ";i->refcount;" has dtor? ";hHasDtor( i->sym )
		end if
		i = listGetPrev( i )
	wend
end sub
#endif

sub astDtorListAdd( byval sym as FBSYMBOL ptr )
	dim as AST_DTORLIST_ITEM ptr n = any

	if( hHasDtor( sym ) = FALSE ) then
		exit sub
	end if

	n = listNewNode( @ast.dtorlist )
	n->sym = sym

	with( ast.dtorlistscopes )
		'' If inside a dtorlist scope, mark the new entry
		'' with the scope's cookie
		if( .count > 0 ) then
			n->cookie = .cookies[.count-1]
		else
			n->cookie = 0
		end if
	end with

	n->refcount = 0
end sub

sub astDtorListAddRef( byval sym as FBSYMBOL ptr )
	dim as AST_DTORLIST_ITEM ptr i = any

	if( hHasDtor( sym ) = FALSE ) then
		exit sub
	end if

	'' Find the entry for this symbol (if any still exists)
	'' and increase its refcount
	i = listGetTail( @ast.dtorlist )
	while( i )
		if( i->sym = sym ) then
			i->refcount += 1
			exit while
		end if

		i = listGetPrev( i )
	wend
end sub

sub astDtorListRemoveRef( byval sym as FBSYMBOL ptr )
	dim as AST_DTORLIST_ITEM ptr i = any

	if( hHasDtor( sym ) = FALSE ) then
		exit sub
	end if

	'' Find the entry for this symbol (if any still exists)
	'' and decrease its refcount
	i = listGetTail( @ast.dtorlist )
	while( i )
		if( i->sym = sym ) then
			assert( i->refcount > 0 )
			i->refcount -= 1

			if( i->refcount <= 0 ) then
				listDelNode( @ast.dtorlist, i )
			end if

			exit while
		end if

		i = listGetPrev( i )
	wend
end sub

function astDtorListFlush( byval cookie as integer ) as ASTNODE ptr
	dim as AST_DTORLIST_ITEM ptr n = any, p = any
	dim as ASTNODE ptr t = any

	'' call the dtors in the reverse order
	t = NULL
	n = listGetTail( @ast.dtorlist )
	while( n )
		p = listGetPrev( n )

		'' astDtorListFlush(0) shouldn't be called without a cookie
		'' while there still are entries registered with cookies.
		'' Any scopes should have either called:
		''    - astDtorListScopeDelete(cookie) to delete the dtors
		''    - astDtorListUnscope(cookie) to move the dtors to after the
		''      expression
		'' Or if a cookie was given (>0) then only flush dtors for
		'' the cookie number given

		assert( iif( cookie = 0, (n->cookie = 0) or (n->cookie = -1), TRUE ) )

		'' Only flush dtors for the given cookie number
		if( n->cookie = cookie ) then
			t = astNewLINK( t, astBuildVarDtorCall( n->sym ), AST_LINK_RETURN_NONE )
			listDelNode( @ast.dtorlist, n )

		'' or delete the cookie was marked for delete
		elseif( n->cookie = -1 ) then
			listDelNode( @ast.dtorlist, n )
		end if

		n = p
	wend

	if( cookie = 0 ) then
		ast.dtorlistcookies = 0  '' Can aswell be reset
	end if

	function = t
end function

sub astDtorListDel( byval sym as FBSYMBOL ptr )
	dim as AST_DTORLIST_ITEM ptr n = any

	if( hHasDtor( sym ) = FALSE ) then
		exit sub
	end if

	n = listGetTail( @ast.dtorlist )
	while( n )
		if( n->sym = sym ) then
			listDelNode( @ast.dtorlist, n )
			exit while
		end if
		n = listGetPrev( n )
	wend
end sub

'' Opens a new dtorlist "scope", the newly allocated cookie number will be used
'' to mark all dtorlist entries added by astDtorListAdd()'s while in this scope.
'' If a "cookie" is given then that will be used to mark new entries, instead of
'' allocating a new cookie.
sub astDtorListScopeBegin( byval cookie as integer )
	if( cookie = 0 ) then
		'' Allocate new cookie
		ast.dtorlistcookies += 1
		cookie = ast.dtorlistcookies
	end if

	'' Add new scope with that cookie
	with( ast.dtorlistscopes )
		'' No more room? Enlarge the array
		if( .count = .room ) then
			.room += 8
			.cookies = xreallocate( .cookies, sizeof( *.cookies ) * .room )
		end if
		.cookies[.count] = cookie
		.count += 1
	end with
end sub

'' Closes the scope and returns its cookie number so it can be passed through
'' to the following astNewIIF()
function astDtorListScopeEnd( ) as integer
	'' Pop entry from the scopes stack
	with( ast.dtorlistscopes )
		assert( .count > 0 )
		function = .cookies[.count-1]
		.count -= 1
	end with
end function

'' Remove cookie markers from the dtor list entries for the given scope,
'' indicating that they should be handled by the next toplevel
'' astDtorListFlush(0).
''
'' if cookie = 0 then emit the dtor at the next astDtorListFlush(0)
''    This is useful if an expression was at first parsed with a,
''    dtor list scope, but then it turns out that it's needed but
''    only after the expression is fully composed.
''
'' if cookie = -1 then delete the dtor at next astDtorListFlush(0)
''    This is useful if an expression was at first parsed with a,
''    dtor list scope, but then it turns out that it's not needed,
''    and can be undone using this function
''
private sub hastDtorListRescope( byval cookie as integer, byval newcookie as integer )
	dim as AST_DTORLIST_ITEM ptr i = any
	i = listGetTail( @ast.dtorlist )
	while( i )
		if( i->cookie = cookie ) then
			i->cookie = newcookie
		end if
		i = listGetPrev( i )
	wend
end sub

sub astDtorListUnscope( byval cookie as integer )
	'' Unscope dtors and emit after the expression
	hastDtorListRescope( cookie, 0 )
end sub

sub astDtorListScopeDelete( byval cookie as integer )
	'' Delete dtors
	'' use a cookie of '-1' to indicate delete
	hastDtorListRescope( cookie, -1 )
end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' hacks
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub astSetType _
	( _
		byval n as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	)

#if __FB_DEBUG__
	if( astIsTYPEINI( n ) ) then
		'' TYPEINI types shouldn't be changed by optimizations,
		'' it would cause astTypeIniUpdate() to use the wrong type
		'' for the temp var.
		'' (astSetType() can still be called, e.g. from astNewDEREF(),
		'' just the type shouldn't be changed)
		assert( typeGetDtAndPtrOnly( n->dtype ) = typeGetDtAndPtrOnly( dtype ) )
		assert( n->subtype = subtype )
	end if
#endif

	astGetFullType( n ) = dtype
	n->subtype = subtype

	select case n->class
	case AST_NODECLASS_LINK
		select case n->link.ret
		case AST_LINK_RETURN_LEFT
			astSetType( n->l, dtype, subtype )
		case AST_LINK_RETURN_RIGHT
			astSetType( n->r, dtype, subtype )
		end select

	case AST_NODECLASS_FIELD
		astSetType( n->l, dtype, subtype )

	case AST_NODECLASS_CALLCTOR
		'' Propagate type change up to the temp VAR access, since that's
		'' what will be returned by astLoadCALLCTOR().
		astSetType( n->r, dtype, subtype )

		'' This happens with field accesses on a CALLCTOR expression
		'' such as (UDT( )).field. The access to offset 0 of the temp
		'' UDT var is optimized out, causing the CALLCTOR expression to
		'' be changed over to the field's dtype for a "direct" access.

	case AST_NODECLASS_IIF
		astSetType( n->l, dtype, subtype )

	end select

end sub

function astSizeOf( byval n as ASTNODE ptr, byref is_fixlenstr as integer ) as longint
	is_fixlenstr = FALSE
	function = symbCalcLen( n->dtype, n->subtype )

	'' If it's a STRING * N, we must get the real length from the
	'' associated symbol, since the N isn't encoded in the dtype/subtype.
	select case( typeGetDtAndPtrOnly( n->dtype ) )
	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR, FB_DATATYPE_FIXSTR
		if( n->sym ) then
			is_fixlenstr = TRUE
			function = symbGetLen( n->sym )
		end if
	end select
end function

private function hSymbIsOnLocalStack( byval sym as FBSYMBOL ptr ) as integer
	function = symbIsLocal( sym ) and (not symbIsStatic( sym ))
end function

function astIsAccessToLocal( byval expr as ASTNODE ptr ) as integer
	function = FALSE

	select case( astGetClass( expr ) )
	case AST_NODECLASS_VAR
		'' Disallow local var accesses
		'' Note: accesses to byref params are automatically allowed,
		'' because they have DEREFs at the top, not VARs.
		function = hSymbIsOnLocalStack( expr->sym )

	case AST_NODECLASS_IDX
		'' Disallow local array accesses, unless it's a bydesc param
		'' (accesses to them also have an IDX at the top)
		if( symbIsParamVarBydesc( expr->sym ) = FALSE ) then
			function = hSymbIsOnLocalStack( expr->sym )
		end if

	case AST_NODECLASS_CALL
		'' No CALLs can be allowed - either their result
		'' is in registers or in a local temp var.
		'' Note: functions returning BYREF are ok, because they have
		'' DEREFs at the top, not CALLs.
		function = TRUE

	case AST_NODECLASS_FIELD
		if( astIsDEREF( expr->l ) ) then
			'' DEREF's lhs can be NULL in case it deref'ed a const
			if( expr->l->l ) then
				if( astIsBOP( expr->l->l, AST_OP_ADD ) ) then
					if( astGetClass( expr->l->l->l ) = AST_NODECLASS_ADDROF ) then
						'' will be a VAR/FIELD again
						function = astIsAccessToLocal( expr->l->l->l->l )
					end if
				end if
			end if
		else
			function = astIsAccessToLocal( expr->l )
		end if

	end select

end function

function astIsRelationalBop( byval n as ASTNODE ptr ) as integer
	if( n->class = AST_NODECLASS_BOP ) then
		function = astOpIsRelational( n->op.op )
	end if
end function
