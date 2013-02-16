'' AST unary operation nodes
'' l = operand expression; r = NULL
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "rtl.bi"
#include once "ast.bi"

private function hUOPConstFoldInt _
	( _
		byval op as integer, _
		byval v as ASTNODE ptr _
	) as ASTNODE ptr

	dim as integer ldfull = any
	dim as FBSYMBOL ptr lsubtype = any

	select case as const op
	case AST_OP_NOT
		v->con.val.int = not v->con.val.int

	case AST_OP_NEG
		v->con.val.int = -v->con.val.int

	case AST_OP_ABS
		v->con.val.int = abs( v->con.val.int )

	case AST_OP_SGN
		v->con.val.int = sgn( v->con.val.int )
	end select

	'' Pretend the CONST is an integer for a moment, since the result was
	'' calculated and stored at INTEGER precision above, then do a CONV
	'' back to the original type and let it show any overflow warnings in
	'' case the real type cannot hold the calculated value.
	ldfull = v->dtype
	lsubtype = v->subtype
	v->dtype = FB_DATATYPE_INTEGER
	v->subtype = NULL

	function = astNewCONV( ldfull, lsubtype, v )
end function

'':::::
private sub hUOPConstFoldFlt _
	( _
		byval op as integer, _
		byval v as ASTNODE ptr _
	) static

	select case as const op
	case AST_OP_NOT
		v->con.val.int = not cint( v->con.val.float )

	case AST_OP_NEG
		v->con.val.float = -v->con.val.float

	case AST_OP_ABS
		v->con.val.float = abs( v->con.val.float )

	case AST_OP_SGN
		v->con.val.float = sgn( v->con.val.float )

	case AST_OP_SIN
		v->con.val.float = sin( v->con.val.float )

	case AST_OP_ASIN
		v->con.val.float = asin( v->con.val.float )

	case AST_OP_COS
		v->con.val.float = cos( v->con.val.float )

	case AST_OP_ACOS
		v->con.val.float = acos( v->con.val.float )

	case AST_OP_TAN
		v->con.val.float = tan( v->con.val.float )

	case AST_OP_ATAN
		v->con.val.float = atn( v->con.val.float )

	case AST_OP_SQRT
		v->con.val.float = sqr( v->con.val.float )

	case AST_OP_LOG
		v->con.val.float = log( v->con.val.float )

	case AST_OP_EXP
		v->con.val.float = exp( v->con.val.float )

	case AST_OP_FLOOR
		v->con.val.float = int( v->con.val.float )

	case AST_OP_FIX
		v->con.val.float = fix( v->con.val.float )

	case AST_OP_FRAC
		v->con.val.float = frac( v->con.val.float )
	end select

end sub

'':::::
private sub hUOPConstFold64 _
	( _
		byval op as integer, _
		byval v as ASTNODE ptr _
	) static

	select case as const op
	case AST_OP_NOT
		v->con.val.long = not v->con.val.long

	case AST_OP_NEG
		v->con.val.long = -v->con.val.long

	case AST_OP_ABS
		v->con.val.long = abs( v->con.val.long )

	case AST_OP_SGN
		v->con.val.long = sgn( v->con.val.long )
	end select

end sub

'':::::
function astNewUOP _
	( _
		byval op as integer, _
		byval o as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any

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

    dim as integer dclass = any, dtype = any
	dtype = astGetFullType( o )
    dclass = typeGetClass( dtype )

	if( op = AST_OP_SWZ_REPEAT ) then
		'' alloc new node
		n = astNewNode( AST_NODECLASS_UOP, dtype, o->subtype )

		n->l = o
		n->r = NULL
		n->op.op = op
		n->op.ex = NULL
		n->op.options = AST_OPOPT_ALLOCRES
		return n
	end if

    '' string? can't operate
    if( dclass = FB_DATACLASS_STRING ) then
    	exit function
    end if

	select case as const typeGet( dtype )
	'' CHAR and WCHAR literals are also from the INTEGER class..
	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
		'' only if it's a deref pointer, to allow "NOT *p" etc
		if( astIsDEREF( o ) = FALSE ) then
			exit function
		end if

	'' UDT?
	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		'' try to convert to the most precise type
		o = astNewCONV( FB_DATATYPE_VOID, NULL, o )
		if( o = NULL ) then
			exit function
		end if

		dtype = typeJoin( dtype, astGetFullType( o ) )
		dclass = typeGetClass( dtype )

	'' Enum operand? Convert to integer (but preserve CONSTs)
	case FB_DATATYPE_ENUM
		'' See also astNewBOP() - when doing math on enum constants,
		'' we don't know whether the resulting integer value will be
		'' a part of that enum, so it's better to convert to integer.
		'' For typesafe enums, an error would have to be shown here.
		dtype = typeJoin( dtype, FB_DATATYPE_INTEGER )
		dclass = FB_DATACLASS_INTEGER
		o = astNewCONV( dtype, NULL, o )

	'' pointer?
	case FB_DATATYPE_POINTER
		'' only NOT allowed
		if( op <> AST_OP_NOT ) then
			exit function
		end if

	end select

	dim as FBSYMBOL ptr subtype = o->subtype

	'' convert byte to integer
	if( typeGetSize( dtype ) = 1 ) then
		dim as integer nd = any
		if( typeIsSigned( dtype ) ) then
			nd = FB_DATATYPE_INTEGER
		else
			nd = FB_DATATYPE_UINT
		end if

		dtype = typeJoin( dtype, nd )

		'' !!!FIXME!!! if ENUM's could be BYTE's in future, this will fail
		o = astNewCONV( dtype, NULL, o )
		subtype = NULL
	end if

	select case as const op
	'' NOT can only operate on integers
	case AST_OP_NOT
		if( dclass <> FB_DATACLASS_INTEGER ) then
			o = astNewCONV( FB_DATATYPE_INTEGER, NULL, o )
			dtype = typeJoin( dtype, FB_DATATYPE_INTEGER )
			subtype = NULL
		end if

	'' with SGN(int) the result is always a signed integer
	case AST_OP_SGN
		if( dclass = FB_DATACLASS_INTEGER ) then
			dtype = typeJoin( dtype, typeToSigned( dtype ) )
			subtype = NULL
		end if

	'' transcendental can only operate on floats
	case AST_OP_SIN, AST_OP_ASIN, AST_OP_COS, AST_OP_ACOS, _
		 AST_OP_TAN, AST_OP_ATAN, AST_OP_SQRT, AST_OP_LOG, _
		 AST_OP_EXP

		if( dclass <> FB_DATACLASS_FPOINT ) then
			o = astNewCONV( FB_DATATYPE_DOUBLE, NULL, o )
			dtype = typeJoin( dtype, FB_DATATYPE_DOUBLE )
			subtype = NULL
		end if

	'' fix and floor only affect floats
	case AST_OP_FIX, AST_OP_FLOOR
		'' integer?
		if( dclass = FB_DATACLASS_INTEGER ) then
			'' return value unchanged (hack: add 0 to prevent passing byref)
			return astNewBOP(AST_OP_ADD, o, astNewconsti(0, dtype))
		end if

	'' frac returns 0 for non-floats
	case AST_OP_FRAC
		'' integer?
		if( dclass = FB_DATACLASS_INTEGER ) then
			'' return zero (opimization should eliminate 'AND 0' tree if no classes on o)
			return astNewBOP(AST_OP_AND, o, astNewCONSTi(0, dtype))
		end if

	'' '+'? do nothing..
	case AST_OP_PLUS
		return o

	end select

	'' constant folding
	if( astIsCONST( o ) ) then

		if( op = AST_OP_NEG ) then
			if( astGetDataClass( o ) = FB_DATACLASS_INTEGER ) then
				if( typeIsSigned( dtype ) = FALSE ) then
					'' test overflow
					select case typeGet( dtype )
					case FB_DATATYPE_UINT
chk_uint:
						if( astGetValInt( o ) and &h80000000 ) then
							if( astGetValInt( o ) <> &h80000000 ) then
								errReportWarn( FB_WARNINGMSG_IMPLICITCONVERSION )
							end if
						end if

					case FB_DATATYPE_ULONGINT
chk_ulong:
						if( astGetValLong( o ) and &h8000000000000000 ) then
							if( astGetValLong( o ) <> &h8000000000000000 ) then
								errReportWarn( FB_WARNINGMSG_IMPLICITCONVERSION )
							end if
						end if

					case FB_DATATYPE_ULONG
						if( FB_LONGSIZE = len( integer ) ) then
							goto chk_uint
						else
							goto chk_ulong
						end if

					case else
						if( -astGetValueAsLongint( o ) < ast_minlimitTB( astGetDataType( o ) ) ) then
							errReportWarn( FB_WARNINGMSG_IMPLICITCONVERSION )
						end if
					end select

					dtype = typeJoin( dtype, typeToSigned( dtype ) )
				end if
			end if
		end if

		select case as const astGetDataType( o )
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		    hUOPConstFold64( op, o )

		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			hUOPConstFoldFlt( op, o )

		case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
			if( FB_LONGSIZE = len( integer ) ) then
				hUOPConstFoldInt( op, o )
			else
				hUOPConstFold64( op, o )
			end if

		case else
			'' byte's, short's, int's and enum's
			hUOPConstFoldInt( op, o )
		end select

		astGetFullType( o ) = typeJoin( astGetFullType( o ), dtype )
		o->subtype = subtype

		return o
	end if

	'' alloc new node

	''
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

