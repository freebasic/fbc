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
		case FB_SIZETYPE_BOOLEAN
			l->val.i = cbool( l->val.f )
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
		case FB_SIZETYPE_BOOLEAN
			l->val.i = cbool( l->val.i )
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
		case FB_SIZETYPE_BOOLEAN
			l->val.i = cbool( cunsg( l->val.i ) )
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

'':::::
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

	if( typeGetClass( expr_dtype ) = FB_DATACLASS_INTEGER ) then
		'' Allow converting literal 0 with any integer type to any pointer type
		if( astIsCONST( expr ) ) then
			if( astConstEqZero( expr ) ) then
				return FB_ERRMSG_OK
			end if
		end if

		'' Allow integer-to-pointer casts only if same size
		if( typeGetSize( expr_dtype ) = env.pointersize ) then
			return FB_ERRMSG_OK
		end if
	end if

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
		if( typeGetClass( to_dtype ) = FB_DATACLASS_INTEGER ) then
			'' Allow converting literal 0 with any pointer type to any integer type
			if( astIsCONST( expr ) ) then
				if( astConstEqZero( expr ) ) then
					exit function
				end if
			end if

			'' Allow pointer-to-integer casts if same size
			if( typeGetSize( to_dtype ) = env.pointersize ) then
				exit function
			end if
		end if

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
		(typeGet( ldtype   ) = FB_DATATYPE_STRUCT)) then
		if( (typeGet( to_dtype ) = FB_DATATYPE_STRUCT) and _
			(typeGet( ldtype   ) = FB_DATATYPE_STRUCT)) then
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
private function astTryOvlOpCastCONV _
	( _
		byref n as ASTNODE ptr, _
		byval to_dtype as integer, _
		byval to_subtype as FBSYMBOL ptr, _
		byval node as ASTNODE ptr, _
		byval options as AST_CONVOPT _
	) as integer

	dim as FBSYMBOL ptr proc = any
	dim as FB_ERRMSG err_num = any
	dim as FB_SYMBFINDOPT find_options = FB_SYMBFINDOPT_NONE

	if( (options and AST_CONVOPT_EXACT_CAST)<>0 ) then
		find_options = FB_SYMBFINDOPT_EXPLICIT
	end if

	proc = symbFindCastOvlProc( to_dtype, to_subtype, node, @err_num, find_options )

	if( proc <> NULL ) then
		'' build a proc call
		n = astBuildCall( proc, node )
		return TRUE
	else
		if( err_num <> FB_ERRMSG_OK ) then
			n = NULL
			return TRUE
		end if
	end if

	return FALSE

end function

'':::::
function astTryOvlStringCONV( byref expr as ASTNODE ptr ) as integer

	dim as FBSYMBOL ptr proc = any, sym = any
	dim as FB_ERRMSG err_num = any
	dim as integer dtype = any

	assert( expr )

	if( astGetDataType( expr ) = FB_DATATYPE_STRUCT ) then
		sym = astGetSubType( expr )

		if( symbGetUdtIsZstring( sym ) ) then
			dtype = FB_DATATYPE_CHAR
		elseif( symbGetUdtIsWstring( sym ) ) then
			dtype = FB_DATATYPE_WCHAR
		else
			dtype = FB_DATATYPE_VOID
		end if

		if( dtype <> FB_DATATYPE_VOID ) then
			'' can cast to z|wstring?
			proc = symbFindCastOvlProc( dtype, NULL, expr, @err_num )
			if( proc ) then
				'' same type?
				if( symbGetType( proc ) = dtype ) then
					expr = astBuildCall( proc, expr )
					return TRUE
				end if
			end if
		end if
	end if

	return FALSE

end function

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
	dim as integer ldclass = any, ldtype = any, errmsg = any, wrnmsg = any, doconv = any

	if( perrmsg ) then
		*perrmsg = FB_ERRMSG_OK
	end if

	ldtype = astGetFullType( l )

	'' same type?
	if( typeGetDtAndPtrOnly( ldtype ) = typeGetDtAndPtrOnly( to_dtype ) ) then
		if( l->subtype = to_subtype ) then
			'' Only CONST bits changed?
			if( typeGetConstMask( ldtype ) <> typeGetConstMask( to_dtype ) ) then
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

					'' data types and levels of pointer inderection are the same,
					'' always record this as const conversion
					n->cast.convconst = TRUE

					if( (options and AST_CONVOPT_DONTWARNCONST) = 0 ) then
						if( fbPdCheckIsSet( FB_PDCHECK_CONSTNESS ) ) then
							errReportWarn( FB_WARNINGMSG_CONSTQUALIFIERDISCARDED )
						end if
					end if
				end if
			else
				n = l
			end if

			return n
		end if
	end if

	'' UDT? check if it is z|wstring?
	if( typeGet( ldtype ) = FB_DATATYPE_STRUCT ) then
		dim as FBSYMBOL ptr subtype = astGetSubtype( l )

		if( symbGetUdtIsZstring( subtype ) or symbGetUdtIsWstring( subtype ) ) then
			dim as FBSYMBOL ptr proc = NULL
			dim as FB_ERRMSG err_num = any

			'' check exact casts
			proc = symbFindCastOvlProc _
				( _
					to_dtype, _
					to_subtype, _
					l, _
					@err_num, _
					FB_SYMBFINDOPT_EXPLICIT _
				)

			if( proc <> NULL ) then
				'' build a proc call
				return astBuildCall( proc, l )
			end if

			'' check exact string pointer casts
			if( symbGetUdtIsZstring( subtype ) ) then
				proc = symbFindCastOvlProc _
					( _
						typeAddrof( FB_DATATYPE_CHAR ), _
						NULL, _
						l, _
						@err_num, _
						FB_SYMBFINDOPT_EXPLICIT _
					)
			elseif( symbGetUdtIsWstring( subtype ) ) then
				proc = symbFindCastOvlProc _
					( _
						typeAddrof( FB_DATATYPE_WCHAR ), _
						NULL, _
						l, _
						@err_num, _
						FB_SYMBFINDOPT_EXPLICIT _
					)
			end if
			if( proc <> NULL ) then
				'' build a proc call
				return astBuildCall( proc, l )
			end if

			'' strings? convert.
			if( options and AST_CONVOPT_CHECKSTR ) then
				if( astTryOvlStringCONV( l ) ) then
					ldtype = astGetFullType( l )
				end if
			end if
		end if
	end if

	'' try casting op overloading
	if( astTryOvlOpCastCONV( n, to_dtype, to_subtype, l, options ) ) then
		return n
	end if

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

		'' don't allow cast to base types?
		if( (options and AST_CONVOPT_NOCONVTOBASE) <> 0 ) then
			exit function
		end if

		'' no valid cast to base type?
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
	'' or one is a boolean and the other is not boolean
	if( ldclass = typeGetClass( to_dtype ) ) then
		select case( typeGet( to_dtype ) )
		case FB_DATATYPE_STRUCT '', FB_DATATYPE_CLASS
			'' do nothing
			doconv = FALSE
		case else
			if( (ldtype = FB_DATATYPE_BOOLEAN) or (to_dtype = FB_DATATYPE_BOOLEAN) ) then
				if( ldtype = to_dtype ) then
					doconv = FALSE
				end if
			else
				if( typeGetSize( ldtype ) = typeGetSize( to_dtype ) ) then
					doconv = FALSE
				end if
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
	n->cast.convconst = FALSE

	'' Discarding/changing const qualifier bits ?
	if( typeIsPtr( ldtype ) and typeIsPtr( to_dtype ) ) then

		wrnmsg = 0

		n->cast.convconst = ( symbCheckConstAssign( to_dtype, ldtype, to_subtype, l->subtype, , , wrnmsg ) = FALSE )

		'' -w funcptr  -w constness
		''    no           no          don't warn anything
		''    yes          yes         warn everything
		''    yes          no          warn if wrnmsg<>0
		''    no           yes         warn everything (-w constness implies -w funcptr)

		'' else check if const conversion
		if( n->cast.convconst ) then

			'' wrnmsg is <> 0 only if funcptr check failed
			'' specific warning message takes priority over const warning
			if( wrnmsg <> 0 ) then
				if( (options and AST_CONVOPT_DONTWARNFUNCPTR) = 0 ) then
					errReportWarn( wrnmsg, , , strptr(" in function pointer") )
				end if

			'' else, must be const warning
			else

				if( (options and AST_CONVOPT_DONTWARNCONST) = 0 ) then
					if( fbPdCheckIsSet( FB_PDCHECK_CONSTNESS ) ) then
						errReportWarn( FB_WARNINGMSG_CONSTQUALIFIERDISCARDED )
					end if
				end if

			end if

		end if

	end if

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

	dim as ASTNODE ptr n = NULL

	if( astTryOvlOpCastCONV( n, to_dtype, to_subtype, l, AST_CONVOPT_NONE ) ) then
		return n
	end if

	'' nothing to do
	return l

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

	'' n->cast
	'' doconv convconst    do_convfd2fs
	'' false  false        n/a           same size
	'' false  true         n/a           same size - different const qualifiers, doesn't matter now
	'' true   false        false         different sizes
	'' true   false        true          convert floating point double to single
	'' true   true         n/a           different sizes  - different const qualifiers, doesn't matter now

	if( ast.doemit ) then
		vs->vector = n->vector
		if( n->cast.doconv ) then
			vr = irAllocVreg( astGetFullType( n ), n->subtype )
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
			irSetVregDataType( vr, astGetFullType( n ), n->subtype )
		end if
	end if

	astDelNode( l )

	function = vr

end function

function astSkipConstCASTs( byval n as ASTNODE ptr ) as ASTNODE ptr
	function = n
	if( n->class = AST_NODECLASS_CONV ) then
		if( n->cast.doconv = FALSE ) then
			function = n->l
		end if
	end if
end function

function astSkipNoConvCAST( byval n as ASTNODE ptr ) as ASTNODE ptr
	function = n
	if( n->class = AST_NODECLASS_CONV ) then
		if( n->cast.doconv = FALSE and n->cast.convconst = FALSE ) then
			function = n->l
		end if
	end if
end function

function astRemoveNoConvCAST( byval n as ASTNODE ptr ) as ASTNODE ptr
	function = n
	if( n->class = AST_NODECLASS_CONV ) then
		if( n->cast.doconv = FALSE and n->cast.convconst = FALSE ) then
			function = n->l
			n->l = NULL
			astDelTree( n )
		end if
	end if
end function

function astSkipCASTs( byval n as ASTNODE ptr ) as ASTNODE ptr
	while( n->class = AST_NODECLASS_CONV )
		n = n->l
	wend
	function = n
end function

function astRemoveCASTs( byval n as ASTNODE ptr ) as ASTNODE ptr
	while( n->class = AST_NODECLASS_CONV )
		var l = n->l
		astDelNode( n )
		n = l
	wend
	function = n
end function
