'' AST unary operation nodes
'' l = operand expression; r = NULL
''
'' chng: sep/2004 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "rtl.bi"
#include once "ast.bi"

private function hConstUop _
	( _
		byval op as integer, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval l as ASTNODE ptr _
	) as ASTNODE ptr

	if( typeGetClass( l->dtype ) = FB_DATACLASS_FPOINT ) then
		select case as const( op )
		case AST_OP_NEG
			l->val.f = -l->val.f
		case AST_OP_ABS
			l->val.f = abs( l->val.f )
		case AST_OP_SGN
			l->val.f = sgn( l->val.f )
		case AST_OP_SIN
			l->val.f = sin( l->val.f )
		case AST_OP_ASIN
			l->val.f = asin( l->val.f )
		case AST_OP_COS
			l->val.f = cos( l->val.f )
		case AST_OP_ACOS
			l->val.f = acos( l->val.f )
		case AST_OP_TAN
			l->val.f = tan( l->val.f )
		case AST_OP_ATAN
			l->val.f = atn( l->val.f )
		case AST_OP_SQRT
			l->val.f = sqr( l->val.f )
		case AST_OP_LOG
			l->val.f = log( l->val.f )
		case AST_OP_EXP
			l->val.f = exp( l->val.f )
		case AST_OP_FLOOR
			l->val.f = int( l->val.f )
		case AST_OP_FIX
			l->val.f = fix( l->val.f )
		case AST_OP_FRAC
			l->val.f = frac( l->val.f )
		case else
			assert( FALSE )
		end select
	else
		select case as const( op )
		case AST_OP_NOT
			l->val.i = not l->val.i
		case AST_OP_NEG
			l->val.i = -l->val.i
		case AST_OP_ABS
			l->val.i = abs( l->val.i )
		case AST_OP_SGN
			l->val.i = sgn( l->val.i )
		case else
			assert( FALSE )
		end select

		'' Pretend the CONST is an integer for a moment, since the result was
		'' calculated and stored at INTEGER precision above, then do a CONV
		'' back to the original type and let it show any overflow warnings in
		'' case the real type cannot hold the calculated value.
		l->dtype = FB_DATATYPE_INTEGER
		l->subtype = NULL

		l = astNewCONV( dtype, subtype, l )
	end if

	function = l
end function

function astNewUOP _
	( _
		byval op as integer, _
		byval o as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any
	dim as integer dtype = any, rank = any, intrank = any, uintrank = any
	dim as FBSYMBOL ptr subtype = any

	function = NULL

	if( o = NULL ) then
		exit function
	end if

	'' check op overloading
	if( symb.globOpOvlTb(op).head <> NULL ) then
		dim as FBSYMBOL ptr proc = any
		dim as FB_ERRMSG err_num = any
		proc = symbFindUopOvlProc( op, o, @err_num )
		if( proc <> NULL ) then
			'' build a proc call
			return astBuildCall( proc, o, NULL )
		else
			if( err_num <> FB_ERRMSG_OK ) then
				exit function
			end if
		end if
	end if

	if( op = AST_OP_SWZ_REPEAT ) then
		'' alloc new node
		n = astNewNode( AST_NODECLASS_UOP, o->dtype, o->subtype )

		n->l = o
		n->r = NULL
		n->op.op = op
		n->op.ex = NULL
		n->op.options = AST_OPOPT_ALLOCRES
		return n
	end if

	'' string? can't operate
	if( typeGetClass( o->dtype ) = FB_DATACLASS_STRING ) then
		exit function
	end if

	select case as const( typeGet( o->dtype ) )
	'' CHAR and WCHAR literals are also from the INTEGER class..
	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
		'' only if it's a deref pointer, to allow "NOT *p" etc
		if( astIsDEREF( o ) = FALSE ) then
			exit function
		end if

	'' UDT?
	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		'' try to convert to the most precise type
		'' (astNewCONV() will try symbFindCastOvlProc() which gives
		'' special treatment to the FB_DATATYPE_VOID)
		o = astNewCONV( typeJoin( o->dtype, FB_DATATYPE_VOID ), NULL, o )
		if( o = NULL ) then
			exit function
		end if

	'' Enum operand? Convert to integer (but preserve CONSTs)
	case FB_DATATYPE_ENUM
		'' See also astNewBOP() - when doing math on enum constants,
		'' we don't know whether the resulting integer value will be
		'' a part of that enum, so it's better to convert to integer.
		'' For typesafe enums, an error would have to be shown here.
		o = astNewCONV( typeJoin( o->dtype, FB_DATATYPE_INTEGER ), NULL, o )

	'' pointer?
	case FB_DATATYPE_POINTER
		'' only NOT allowed
		if( op <> AST_OP_NOT ) then
			exit function
		end if

	end select

	''
	'' Promote smaller integer types to [U]INTEGER before the operation,
	'' see also astNewBOP()
	''

	if( (env.clopt.lang <> FB_LANG_QB) and _
	    (typeGetClass( o->dtype ) = FB_DATACLASS_INTEGER) ) then
		rank = typeGetIntRank( typeGetRemapType( o->dtype ) )
		intrank = typeGetIntRank( FB_DATATYPE_INTEGER )
		uintrank = typeGetIntRank( FB_DATATYPE_UINT )

		'' o < INTEGER?
		if( rank < intrank ) then
			o = astNewCONV( typeJoin( o->dtype, FB_DATATYPE_INTEGER ), NULL, o )
		else
			'' INTEGER < o < UINTEGER?
			if( (intrank < rank) and (rank < uintrank) ) then
				'' Convert to UINTEGER for consistency with
				'' the above conversion to INTEGER (this can
				'' happen with ULONG on 32bit, and ULONGINT
				'' on 64bit, due to the ranking order)
				o = astNewCONV( typeJoin( o->dtype, FB_DATATYPE_UINT ), NULL, o )
			end if
		end if
	end if

	'' Result type normally is the same as the operand
	dtype = o->dtype
	subtype = o->subtype

	select case as const op
	'' NOT can only operate on integers
	case AST_OP_NOT
		if( typeGetClass( o->dtype ) <> FB_DATACLASS_INTEGER ) then
			o = astNewCONV( typeJoin( o->dtype, FB_DATATYPE_INTEGER ), NULL, o )
			dtype = o->dtype
			subtype = o->subtype
		end if

	'' with SGN(int) the result is always a signed integer
	case AST_OP_SGN
		if( typeGetClass( o->dtype ) = FB_DATACLASS_INTEGER ) then
			dtype = typeToSigned( dtype )
		end if

	'' transcendental can only operate on floats
	case AST_OP_SIN, AST_OP_ASIN, AST_OP_COS, AST_OP_ACOS, _
		 AST_OP_TAN, AST_OP_ATAN, AST_OP_SQRT, AST_OP_LOG, _
		 AST_OP_EXP

		if( typeGetClass( o->dtype ) <> FB_DATACLASS_FPOINT ) then
			o = astNewCONV( typeJoin( o->dtype, FB_DATATYPE_DOUBLE ), NULL, o )
			dtype = o->dtype
			subtype = o->subtype
		end if

	'' fix and floor only affect floats
	case AST_OP_FIX, AST_OP_FLOOR
		'' integer?
		if( typeGetClass( o->dtype ) = FB_DATACLASS_INTEGER ) then
			'' return value unchanged (hack: add 0 to prevent passing byref)
			return astNewBOP( AST_OP_ADD, o, astNewCONSTi( 0, dtype ) )
		end if

	'' frac returns 0 for non-floats
	case AST_OP_FRAC
		'' integer?
		if( typeGetClass( o->dtype ) = FB_DATACLASS_INTEGER ) then
			'' return zero (opimization should eliminate 'AND 0' tree if no classes on o)
			return astNewBOP( AST_OP_AND, o, astNewCONSTi( 0, dtype ) )
		end if

	'' '+'? do nothing..
	case AST_OP_PLUS
		return o

	end select

	'' constant folding
	if( astIsCONST( o ) ) then
		if( op = AST_OP_NEG ) then
			if( typeIsSigned( o->dtype ) = FALSE ) then
				'' Check for overflows, for example:
				'' NEG( cushort( 32769 ) ) is -32769,
				'' but the lowest short is -32768.

				'' Highest bit set? (meaning the negation cannot be represented,
				'' since the highest bit will be overwritten with the sign bit)
				if( astConstGetUint( o ) > (1ull shl (typeGetBits( dtype ) - 1)) ) then
					errReportWarn( FB_WARNINGMSG_IMPLICITCONVERSION )
				end if

				dtype = typeToSigned( dtype )
			end if
		end if

		o = hConstUop( op, dtype, subtype, o )

		o->dtype = dtype
		return o
	end if

	'' alloc new node

	if( irGetOption( IR_OPT_NOINLINEOPS ) ) then
		select case as const op
		case AST_OP_SGN, AST_OP_ABS, AST_OP_FIX, AST_OP_FRAC, _
			 AST_OP_SIN, AST_OP_ASIN, AST_OP_COS, AST_OP_ACOS, _
			 AST_OP_TAN, AST_OP_ATAN, AST_OP_SQRT, AST_OP_LOG, _
		 	 AST_OP_EXP, AST_OP_FLOOR
		 	 return rtlMathUop( op, o )
		end select
	end if


	n = astNewNode( AST_NODECLASS_UOP, dtype, subtype )

	n->l = o
	n->r = NULL
	n->op.op = op
	n->op.ex = NULL
	n->op.options = AST_OPOPT_ALLOCRES

	function = n
end function

'':::::
function astLoadUOP _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

    dim as ASTNODE ptr o = any
    dim as integer op = any
    dim as IRVREG ptr v1 = any, vr = any

	o = n->l
	op = n->op.op

	if( o = NULL ) then
		return NULL
	end if

	if( o->class = AST_NODECLASS_CONV ) then
		astUpdateCONVFD2FS( o, n->dtype, TRUE )
	end if

	v1 = astLoad( o )

	if( ast.doemit ) then
		if( (n->op.options and AST_OPOPT_ALLOCRES) <> 0 ) then
			vr = irAllocVREG( astGetDataType( o ), o->subtype )
			v1->vector = n->vector
			vr->vector = n->vector
		else
			vr = NULL
			v1->vector = n->vector
		end if

		irEmitUOP( op, v1, vr )

		'' "op var" optimizations
		if( vr = NULL ) then
			vr = v1
		end if
	end if

	astDelNode( o )

	function = vr

end function

