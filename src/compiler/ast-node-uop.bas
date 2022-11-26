'' AST unary operation nodes
'' l = operand expression; r = NULL
''
'' chng: sep/2004 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "rtl.bi"
#include once "ast.bi"

'' Need to use replacement function for sgn(longint) constant evaluation,
'' because the built-in sgn(longint) was bugged in older fbc versions.
'' This way we can bootstrap safely even using those older versions.
private function hSgnLongInt( byval x as longint ) as longint
	if( x = 0 ) then
		function = 0
	elseif( x > 0 ) then
		function = 1
	else
		function = -1
	end if
end function

private function hConstUop _
	( _
		byval op as integer, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval l as ASTNODE ptr _
	) as ASTNODE ptr

	dim as double d = any
	dim as longint i = any

	if( typeGetClass( l->dtype ) = FB_DATACLASS_FPOINT ) then
		d = l->val.f
		select case as const( op )
		case AST_OP_NEG   : d =      -d
		case AST_OP_ABS   : d =  abs( d )
		case AST_OP_SGN   : d =  sgn( d )
		case AST_OP_SIN   : d =  sin( d )
		case AST_OP_ASIN  : d = asin( d )
		case AST_OP_COS   : d =  cos( d )
		case AST_OP_ACOS  : d = acos( d )
		case AST_OP_TAN   : d =  tan( d )
		case AST_OP_ATAN  : d =  atn( d )
		case AST_OP_SQRT  : d =  sqr( d )
		case AST_OP_LOG   : d =  log( d )
		case AST_OP_EXP   : d =  exp( d )
		case AST_OP_FLOOR : d =  int( d )
		case AST_OP_FIX   : d =  fix( d )
		case AST_OP_FRAC  : d = frac( d )
		case else         : assert( FALSE )
		end select
		l->val.f = d
	else
		i = l->val.i

		if( typeGetSize( l->dtype ) = 8 ) then
			select case as const( op )
			case AST_OP_NOT : i = not i
			case AST_OP_NEG : i = -i
			case AST_OP_ABS : i = abs( i )
			case AST_OP_SGN : i = hSgnLongInt( i )
			case else       : assert( FALSE )
			end select
		else
			select case as const( op )
			case AST_OP_NOT : i = not  clng( i )
			case AST_OP_NEG : i = -    clng( i )
			case AST_OP_ABS : i = abs( clng( i ) )
			case AST_OP_SGN : i = sgn( clng( i ) )
			case else       : assert( FALSE )
			end select
		end if

		l->val.i = i
		l = astConvertRawCONSTi( dtype, subtype, l )
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
	dim as integer do_promote = any

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
			return astBuildCall( proc, o )
		else
			if( err_num <> FB_ERRMSG_OK ) then
				exit function
			end if
		end if
	end if

	select case( op )
	case AST_OP_SWZ_REPEAT
		'' alloc new node
		n = astNewNode( AST_NODECLASS_UOP, o->dtype, o->subtype )

		n->l = o
		n->r = NULL
		n->op.op = op
		n->op.ex = NULL
		n->op.options = AST_OPOPT_ALLOCRES
		return n

	case AST_OP_LEN
		'' The len() UOP is only allowed if overloaded
		exit function
	end select

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
		'' no UOP's allowed with pointers
		exit function

	end select

	''
	'' Promote smaller integer types to [U]INTEGER before the operation,
	'' see also astNewBOP()
	''
	'' - do nothing if operand is boolean with NOT operator

	do_promote = (env.clopt.lang <> FB_LANG_QB) and (typeGetClass( o->dtype ) = FB_DATACLASS_INTEGER)

	if( typeGetDtAndPtrOnly( o->dtype ) = FB_DATATYPE_BOOLEAN ) then
		if( op = AST_OP_NOT ) then
			do_promote = FALSE
		else
			'' no other operation allowed with booleans
			exit function
		end if
	end if

	if( do_promote ) then

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

	'' with SGN(int) and [u]integer negation the result is always a signed integer
	case AST_OP_SGN
		if( typeGetClass( o->dtype ) = FB_DATACLASS_INTEGER ) then
			dtype = typeToSigned( dtype )
		end if

	case AST_OP_NEG
		if( not typeIsSigned( dtype ) ) then
			'' Check for constant overflows, for example:
			'' NEG( cushort( 32769 ) ) is -32769,
			'' but the lowest short is -32768.
			if( astIsCONST( o ) ) then
				if( astShouldShowWarnings( ) ) then
					'' Highest bit set? (meaning the negation cannot be represented,
					'' since the highest bit will be overwritten with the sign bit)
					if( astConstGetUint( o ) > (1ull shl (typeGetBits( dtype ) - 1)) ) then
						errReportWarn( FB_WARNINGMSG_IMPLICITCONVERSION )
					end if
				end if
			end if

			'' Negation on unsigned gives signed result
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
		o = hConstUop( op, dtype, subtype, o )
		o->dtype = dtype
		return o
	end if

	'' Optimize bitwise NOT on boolean expressions (where NOT = logical negation)
	if( op = AST_OP_NOT ) then
		if( astIsRelationalBop( o ) ) then
			o->op.op = astGetInverseLogOp( o->op.op )
			return o
		end if
	end if

	if( irGetOption( IR_OPT_MISSINGOPS ) ) then
		'' Call RTL function if backend doesn't support this op directly
		if( irSupportsOp( op, dtype ) = FALSE ) then
			return rtlMathUop( op, o )
		end if
	end if

	'' alloc new node
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
			vr = irAllocVREG( astGetFullType( o ), o->subtype )
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

