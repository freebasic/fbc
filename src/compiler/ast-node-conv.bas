'' AST conversion nodes
'' l = expression to convert; r = NULL
''
'' chng: sep/2004 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "rtl.bi"
#include once "ast.bi"

private sub hConstConv( byval todtype as integer, byval l as ASTNODE ptr )
	dim as integer ldtype = any

	ldtype = astGetFullType( l )

	if( typeGetClass( ldtype ) = FB_DATACLASS_FPOINT ) then
		select case as const( typeGetSizeType( todtype ) )
		case FB_SIZETYPE_FLOAT32
			'' SINGLE -> SINGLE: nothing to do
			'' DOUBLE -> SINGLE?
			if( typeGetDtAndPtrOnly( ldtype ) = FB_DATATYPE_DOUBLE ) then
				'' Truncate DOUBLE to SINGLE (note: csng()
				'' before 0.25 didn't truncate in this case,
				'' so using an explicit temp var instead)
				dim as single f = any
				f = l->val.f
				l->val.f = f
			end if
		case FB_SIZETYPE_FLOAT64
			'' SINGLE/DOUBLE -> DOUBLE:
			'' Nothing to do, since float constants are stored as DOUBLE
		case FB_SIZETYPE_INT8
			l->val.i = cbyte( l->val.f )
		case FB_SIZETYPE_UINT8
			l->val.i = cubyte( l->val.f )
		case FB_SIZETYPE_INT16
			l->val.i = cshort( l->val.f )
		case FB_SIZETYPE_UINT16
			l->val.i = cushort( l->val.f )
		case FB_SIZETYPE_INT32
			l->val.i = clng( l->val.f )
		case FB_SIZETYPE_UINT32
			l->val.i = culng( l->val.f )
		case FB_SIZETYPE_INT64
			l->val.i = clngint( l->val.f )
		case FB_SIZETYPE_UINT64
			l->val.i = hCastFloatToULongint( l->val.f )
		end select
	elseif( typeIsSigned( ldtype ) ) then
		select case as const( typeGetSizeType( todtype ) )
		case FB_SIZETYPE_FLOAT32
			l->val.f = csng( l->val.i )
		case FB_SIZETYPE_FLOAT64
			l->val.f = cdbl( l->val.i )
		case FB_SIZETYPE_INT8
			l->val.i = cbyte( l->val.i )
		case FB_SIZETYPE_UINT8
			l->val.i = cubyte( l->val.i )
		case FB_SIZETYPE_INT16
			l->val.i = cshort( l->val.i )
		case FB_SIZETYPE_UINT16
			l->val.i = cushort( l->val.i )
		case FB_SIZETYPE_INT32
			l->val.i = clng( l->val.i )
		case FB_SIZETYPE_UINT32
			l->val.i = culng( l->val.i )
		case FB_SIZETYPE_INT64
			l->val.i = clngint( l->val.i )
		case FB_SIZETYPE_UINT64
			l->val.i = culngint( l->val.i )
		end select
	else
		select case as const( typeGetSizeType( todtype ) )
		case FB_SIZETYPE_FLOAT32
			l->val.f = csng( cunsg( l->val.i ) )
		case FB_SIZETYPE_FLOAT64
			l->val.f = cdbl( cunsg( l->val.i ) )
		case FB_SIZETYPE_INT8
			l->val.i = cbyte( cunsg( l->val.i ) )
		case FB_SIZETYPE_UINT8
			l->val.i = cubyte( cunsg( l->val.i ) )
		case FB_SIZETYPE_INT16
			l->val.i = cshort( cunsg( l->val.i ) )
		case FB_SIZETYPE_UINT16
			l->val.i = cushort( cunsg( l->val.i ) )
		case FB_SIZETYPE_INT32
			l->val.i = clng( cunsg( l->val.i ) )
		case FB_SIZETYPE_UINT32
			l->val.i = culng( cunsg( l->val.i ) )
		case FB_SIZETYPE_INT64
			l->val.i = clngint( cunsg( l->val.i ) )
		case FB_SIZETYPE_UINT64
			l->val.i = culngint( cunsg( l->val.i ) )
		end select
	end if
end sub

private function hGetTypeMismatchErrMsg( byval options as AST_CONVOPT ) as integer
	if( options and AST_CONVOPT_PTRONLY ) then
		function = FB_ERRMSG_EXPECTEDPOINTER
	else
		function = FB_ERRMSG_TYPEMISMATCH
	end if
end function

function astCheckConvNonPtrToPtr _
	( _
		byval to_dtype as integer, _
		byval expr_dtype as integer, _
		byval expr as ASTNODE ptr, _
		byval options as AST_CONVOPT _
	) as integer

	assert( typeIsPtr( to_dtype ) )
	assert( typeIsPtr( expr_dtype ) = FALSE )

	select case as const( typeGetDtAndPtrOnly( expr_dtype ) )
	case FB_DATATYPE_INTEGER, FB_DATATYPE_UINT, FB_DATATYPE_ENUM, _
	     FB_DATATYPE_LONG, FB_DATATYPE_ULONG, _
	     FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		'' Allow integer-to-pointer casts if same size
		if( typeGetSize( expr_dtype ) = env.pointersize ) then
			return FB_ERRMSG_OK
		end if

	'' only allow other int dtypes if it's 0 (due QB's INTEGER = short)
	case FB_DATATYPE_BYTE, FB_DATATYPE_UBYTE, _
	     FB_DATATYPE_SHORT, FB_DATATYPE_USHORT
		if( astIsCONST( expr ) ) then
			if( astConstEqZero( expr ) ) then
				'' Allow 0-to-pointer casts
				return FB_ERRMSG_OK
			end if
		end if

	end select

	function = hGetTypeMismatchErrMsg( options )
end function

private function hCheckPtr _
	( _
		byval to_dtype as integer, _
		byval to_subtype as FBSYMBOL ptr, _
		byval expr_dtype as integer, _
		byval expr as ASTNODE ptr, _
		byval options as AST_CONVOPT _
	) as integer

	function = FB_ERRMSG_OK

	'' to pointer? only allow integers of same size, and pointers
	if( typeIsPtr( to_dtype ) ) then
		if( typeIsPtr( expr_dtype ) = FALSE ) then
			return astCheckConvNonPtrToPtr( to_dtype, expr_dtype, expr, options )
		end if

		'' Both are pointers, fall through to checks below

	'' from pointer? only allow integers of same size and pointers
	elseif( typeIsPtr( expr_dtype ) ) then
		select case as const( typeGetDtAndPtrOnly( to_dtype ) )
		case FB_DATATYPE_INTEGER, FB_DATATYPE_UINT, FB_DATATYPE_ENUM, _
		     FB_DATATYPE_LONG, FB_DATATYPE_ULONG, _
		     FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			'' Allow pointer-to-integer casts if same size
			if( typeGetSize( to_dtype ) = env.pointersize ) then
				exit function
			end if
		end select

		return hGetTypeMismatchErrMsg( options )
	else
		'' No pointers at all, nothing to do
		exit function
	end if

	''
	'' Both are pointers
	''
	'' If any of them is a pointer to a derived class,
	'' only allow casting to a pointer to a class from that
	'' inheritance hierarchy, or ANY PTR.
	''

	'' To derived pointer?
	if( typeGetDtOnly( to_dtype ) = FB_DATATYPE_STRUCT ) then
		if( to_subtype->udt.base <> NULL ) then
			if( typeGetDtOnly( expr_dtype ) <> FB_DATATYPE_STRUCT ) then
				if( typeGetDtOnly( expr_dtype ) <> FB_DATATYPE_VOID ) then
					return FB_ERRMSG_CASTDERIVEDPTRFROMINCOMPATIBLE
				end if
			else			
				'' not a upcasting?
				if( symbGetUDTBaseLevel( expr->subtype, to_subtype ) = 0 ) then
					'' try downcasting..
					if( symbGetUDTBaseLevel( to_subtype, expr->subtype ) = 0 ) then
						return FB_ERRMSG_CASTDERIVEDPTRFROMUNRELATED
					End If
				End If
			end if
		End If
	End If

	'' From derived pointer?
	if( typeGetDtOnly( expr_dtype ) = FB_DATATYPE_STRUCT ) then		
		if( expr->subtype->udt.base <> NULL ) then
			if( typeGetDtOnly( to_dtype ) <> FB_DATATYPE_STRUCT ) then
				if( typeGetDtOnly( to_dtype ) <> FB_DATATYPE_VOID ) then
					return FB_ERRMSG_CASTDERIVEDPTRTOINCOMPATIBLE
				end if
			else
				'' not a upcasting?
				if( symbGetUDTBaseLevel( to_subtype, expr->subtype ) = 0 ) then
					'' try downcasting..
					if( symbGetUDTBaseLevel( expr->subtype, to_subtype ) = 0 ) then
						return FB_ERRMSG_CASTDERIVEDPTRTOUNRELATED
					End If
				End If
			end if
		End If
	End If

end function

'':::::
function astCheckCONV _
	( _
		byval to_dtype as integer, _
		byval to_subtype as FBSYMBOL ptr, _
		byval l as ASTNODE ptr _
	) as integer

	dim as integer ldtype = any

	function = FALSE

	ldtype = astGetFullType( l )

	'' to or from UDT? only upcasting supported by now
	if( (typeGet( to_dtype ) = FB_DATATYPE_STRUCT) or _
	    (typeGet( ldtype   ) = FB_DATATYPE_STRUCT)      ) then
		if( (typeGet( to_dtype ) = FB_DATATYPE_STRUCT) and _
		    (typeGet( ldtype   ) = FB_DATATYPE_STRUCT)      ) then
			function = (symbGetUDTBaseLevel( l->subtype, to_subtype ) > 0)
		end if
		exit function
	end if

	'' string? neither
	if( typeGetClass( ldtype ) = FB_DATACLASS_STRING ) then
		exit function
	end if

	'' check pointers
	if( hCheckPtr( to_dtype, to_subtype, ldtype, l, 0 ) <> FB_ERRMSG_OK ) then
		exit function
	end if

	select case typeGet( ldtype )
	'' CHAR and WCHAR literals are also from the INTEGER class
	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
		'' don't allow, unless it's a deref pointer
		if( astIsDEREF( l ) = FALSE ) then
			exit function
		end if

	end select

	function = TRUE

end function

'':::::
#macro hDoGlobOpOverload( to_dtype, to_subtype, node )
	scope
		dim as FBSYMBOL ptr proc = any
		dim as FB_ERRMSG err_num = any

		proc = symbFindCastOvlProc( to_dtype, to_subtype, node, @err_num )
		if( proc <> NULL ) then
			'' build a proc call
			return astBuildCall( proc, l )
		else
			if( err_num <> FB_ERRMSG_OK ) then
				return NULL
			end if
		end if
	end scope
#endmacro

'':::::
function astNewCONV _
	( _
		byval to_dtype as integer, _
		byval to_subtype as FBSYMBOL ptr, _
		byval l as ASTNODE ptr, _
		byval options as AST_CONVOPT, _
		byval perrmsg as integer ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any
	dim as integer ldclass = any, ldtype = any, errmsg = any, doconv = any

	if( perrmsg ) then
		*perrmsg = FB_ERRMSG_OK
	end if

	ldtype = astGetFullType( l )

	'' same type?
	if( typeGetDtAndPtrOnly( ldtype ) = typeGetDtAndPtrOnly( to_dtype ) ) then
		if( l->subtype = to_subtype ) then
			'' Only CONST bits changed?
			if( ldtype <> to_dtype ) then
				'' CONST node? Evaluate at compile-time
				if( astIsCONST( l ) ) then
					astSetType( l, to_dtype, to_subtype )
					n = l
				else
					'' Otherwise, add a CONV node to represent the changed CONST bits
					'' to the expression parser
					n = astNewNode( AST_NODECLASS_CONV, to_dtype, to_subtype )
					n->l = l
					n->cast.doconv = FALSE
					n->cast.do_convfd2fs = FALSE
				end if
			else
				n = l
			end if

			return n
		end if
	end if

	'' try casting op overloading
	hDoGlobOpOverload( to_dtype, to_subtype, l )

	select case as const typeGet( to_dtype )
	case FB_DATATYPE_VOID, FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
	     FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
		'' refuse void (used by uop/bop to cast to be most precise
		'' possible) and strings, as op overloading already failed
		exit function

	'' to UDT?
	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		'' not from UDT? op overloading already failed, refuse.
		if( typeGet( ldtype ) <> FB_DATATYPE_STRUCT ) then
			exit function
		end if

		if( symbGetUDTBaseLevel( l->subtype, to_subtype ) = 0 ) then
			exit function
		end if

	'' to anything else (integers/floats)
	case else
		'' from UDT? refuse, since op overloading already failed
		if( typeGet( ldtype ) = FB_DATATYPE_STRUCT ) then
			exit function
		end if

	end select

	ldclass = typeGetClass( ldtype )

	'' sign conversion?
	if( options and AST_CONVOPT_SIGNCONV ) then
		'' float? invalid
		if( ldclass <> FB_DATACLASS_INTEGER ) then
			exit function
		end if
	end if

	if( (options and AST_CONVOPT_DONTCHKPTR) = 0 ) then
		'' check pointers
		errmsg = hCheckPtr( to_dtype, to_subtype, ldtype, l, options )
		if( errmsg <> FB_ERRMSG_OK ) then
			if( perrmsg ) then
				*perrmsg = errmsg
			end if
			exit function
		end if
	end if

	'' string?
	if( options and AST_CONVOPT_CHECKSTR ) then
		select case as const typeGet( ldtype )
		case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
			 FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
			return rtlStrToVal( l, to_dtype )
		end select
	else
		if( ldclass = FB_DATACLASS_STRING ) then
			exit function
		'' CHAR and WCHAR literals are also from the INTEGER class
		else
			select case typeGet( ldtype )
			case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
				'' don't allow, unless it's a deref pointer
				if( astIsDEREF( l ) = FALSE ) then
					exit function
				end if
			end select
		end if
	end if

	'' constant? evaluate at compile-time
	if( astIsCONST( l ) ) then
		astCheckConst( to_dtype, l )

		hConstConv( to_dtype, l )

		l->dtype = to_dtype
		l->subtype = to_subtype
		return l
	end if

	doconv = TRUE

	'' only convert if the classes are different (ie, floating<->integer) or
	'' if sizes are different (ie, byte<->int)
	if( ldclass = typeGetClass( to_dtype ) ) then
		select case( typeGet( to_dtype ) )
		case FB_DATATYPE_STRUCT '', FB_DATATYPE_CLASS
			'' do nothing
			doconv = FALSE
		case else
			if( typeGetSize( ldtype ) = typeGetSize( to_dtype ) ) then
				doconv = FALSE
			end if
		end select
	end if

	if( irGetOption( IR_OPT_FPUCONV ) ) then
		if (ldclass = FB_DATACLASS_FPOINT) and ( typeGetClass( to_dtype ) = FB_DATACLASS_FPOINT ) then
			if( typeGetSize( ldtype ) <> typeGetSize( to_dtype ) ) then
				doconv = TRUE
			end if
		end if
	end if

	'' casting another cast?
	if( l->class = AST_NODECLASS_CONV ) then
		'' no conversion in both?
		if( l->cast.doconv = FALSE ) then
			if( doconv = FALSE ) then
				'' just replace the bottom cast()'s type
				astGetFullType( l ) = to_dtype
				l->subtype = to_subtype
				return l
			end if
		end if
	end if

	'' alloc new node
	n = astNewNode( AST_NODECLASS_CONV, to_dtype, to_subtype )

	n->l = l
	n->cast.doconv = doconv
	n->cast.do_convfd2fs = FALSE

	if( env.clopt.backend = FB_BACKEND_GAS ) then
		if( doconv ) then
			'' converting DOUBLE to SINGLE?
			if( typeGet( ldtype ) = FB_DATATYPE_DOUBLE ) then
				n->cast.do_convfd2fs = (typeGet( to_dtype ) = FB_DATATYPE_SINGLE)
			end if
		end if
	end if

	function = n

end function

'':::::
function astNewOvlCONV _
	( _
		byval to_dtype as integer, _
		byval to_subtype as FBSYMBOL ptr, _
		byval l as ASTNODE ptr _
	) as ASTNODE ptr

	'' try casting op overloading only
	hDoGlobOpOverload( to_dtype, to_subtype, l )

	'' nothing to do
	function = l

end function

sub astUpdateCONVFD2FS _
	( _
		byval n as ASTNODE ptr, _
		byval to_dtype as integer, _
		byval is_expr as integer _
	)

	assert( n->class = AST_NODECLASS_CONV )

	'' only when converting DOUBLE to SINGLE
	if( n->cast.do_convfd2fs = FALSE ) then
		exit sub
	end if

	assert( env.clopt.backend = FB_BACKEND_GAS )

	''
	'' x86 assumptions
	''
	'' Don't do the DOUBLE to SINGLE truncation unless needed.
	''
	'' If the target dtype cannot hold bigger values than SINGLE
	'' anyways, then we don't need to do the additional truncation,
	'' that will happen automatically when storing into the target.
	''
	'' This applies to stores (ASSIGN, ARG), and to expressions
	'' that do not use the FPU stack (ST(N) registers).
	''

	'' everything >= 4 bytes, assuming that 4 byte integers can hold values
	'' that still are too big for SINGLE
	n->cast.do_convfd2fs = (typeGetSize( to_dtype ) >= 4)

	'' to SINGLE itself? no need to do anything then, except if it's on
	'' the FPU stack, and won't be automatically truncated because of that.
	if( typeGet( to_dtype ) = FB_DATATYPE_SINGLE ) then
		n->cast.do_convfd2fs = is_expr
	end if

end sub

'':::::
function astLoadCONV _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

	dim as ASTNODE ptr l = any
	dim as IRVREG ptr vs = any, vr = any

	l = n->l

	if( l = NULL ) then
		return NULL
	end if

	vs = astLoad( l )

	if( ast.doemit ) then
		vs->vector = n->vector
		if( n->cast.doconv ) then
			vr = irAllocVreg( astGetDataType( n ), n->subtype )
			vr->vector = n->vector
			irEmitConvert( vr, vs )

			if( n->cast.do_convfd2fs ) then
				'' converting DOUBLE to SINGLE?
				if( vs->dtype = FB_DATATYPE_DOUBLE ) then
					if( vr->dtype = FB_DATATYPE_SINGLE ) then
						if( vr->regFamily = IR_REG_FPU_STACK ) then
							'' Do additional conversion to truncate to SINGLE
							irEmitUOP( AST_OP_CONVFD2FS, vr, NULL )
						end if
					end if
				end if
			end if
		else
			vr = vs
			irSetVregDataType( vr, astGetDataType( n ), n->subtype )
		end if
	end if

	astDelNode( l )

	function = vr

end function

function astSkipNoConvCAST( byval n as ASTNODE ptr ) as ASTNODE ptr
	function = n
	if( n->class = AST_NODECLASS_CONV ) then
		if( n->cast.doconv = FALSE ) then
			function = n->l
		end if
	end if
end function

function astRemoveNoConvCAST( byval n as ASTNODE ptr ) as ASTNODE ptr
	function = n
	if( n->class = AST_NODECLASS_CONV ) then
		if( n->cast.doconv = FALSE ) then
			function = n->l
			n->l = NULL
			astDelTree( n )
		end if
	end if
end function
