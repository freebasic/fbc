'' AST function call nodes
'' l = pointer node if any; r = first arg to be pushed
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "list.bi"
#include once "ir.bi"
#include once "rtl.bi"
#include once "ast.bi"

sub astCallInit
	listInit( @ast.call.tmpstrlist, 32, len( AST_TMPSTRLIST_ITEM ), LIST_FLAGS_NOCLEAR )
end sub

sub astCallEnd
	listEnd( @ast.call.tmpstrlist )
end sub

'':::::
function astNewCALL _
	( _
		byval sym as FBSYMBOL ptr, _
		byval ptrexpr as ASTNODE ptr = NULL _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any
	dim as FBRTLCALLBACK callback = any
	dim as integer dtype = any
	dim as FBSYMBOL ptr subtype = any

	'' sym might be null if user undefined a builtin rtl proc
	'' and it was undefined.  rtlLookUpProc() a.k.a. PROCLOOKUP()
	'' calls often do not check the return value for failure.
	assert( sym <> NULL )

	'' sym might not be a proc if builtin rtl proc was redefined to
	'' something else
	assert( symbIsProc( sym ) )

	''
	'' If calling a procedure pointer, ensure to use the procedure pointer's
	'' subtype procedure symbol, not the procedure symbol for which the
	'' procedure pointer was created; it may be more "precise".
	''
	'' This can happen with bydesc parameter's real subtypes, the descriptor
	'' types. The procedure may use different descriptor types than the
	'' procedure pointer, if they're from different scopes (also see
	'' symbAddArrayDescriptorType()). Then it's better to use the actual
	'' type we're calling - i.e. the procedure pointer. This matters for the
	'' C/LLVM backends due to their type checking, but not for the ASM
	'' backend.
	''
	'' The same can happen with procedure pointer types themselves which are
	'' also scoped (also see symbAddProcPtr()), in case the called procedure
	'' [pointer] has any procedure pointer parameters. However it's not as
	'' big of a problem because the C/LLVM backends will treat different
	'' procedure pointer typedefs as equal as long as the signature matches.
	'' That's not the case for the array descriptor structures.
	''
	if( ptrexpr ) then
		assert( astGetDataType( ptrexpr ) = typeAddrOf( FB_DATATYPE_FUNCTION ) )
		assert( (ptrexpr->subtype = sym) or (symbCalcProcMatch( ptrexpr->subtype, sym, 0 ) > FB_OVLPROC_NO_MATCH) )
		sym = ptrexpr->subtype
	end if

	''
	dtype = symbGetFullType( sym )
	subtype = symbGetSubType( sym )

	''
	symbSetIsAccessed( sym )

	'' alloc new node
	n = astNewNode( AST_NODECLASS_CALL, dtype, subtype )
	function = n

	n->sym = sym
	n->l = ptrexpr
	n->call.args = 0

	if( sym <> NULL ) then
		n->call.currarg = symbGetProcHeadParam( sym )
		n->call.isrtl = symbGetIsRTL( sym )

		callback = symbGetProcCallback( sym )
		if( callback <> NULL ) then
			callback( sym )
		end if
	else
		n->call.currarg = NULL
		n->call.isrtl = FALSE
	end if

	n->call.argtail = NULL
	n->call.strtail = NULL

	'' Allocate temp struct result if needed
	if( symbProcReturnsOnStack( sym ) ) then
		'' create a temp struct (can't be static, could be an object)
		n->call.tmpres = symbAddTempVar( FB_DATATYPE_STRUCT, symbGetSubtype( sym ) )
		astDtorListAdd( n->call.tmpres )
	else
		n->call.tmpres = NULL
	end if

end function

'':::::
function astNewCALLCTOR _
	( _
		byval procexpr as ASTNODE ptr, _
		byval instptr as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any

	n = astNewNode( AST_NODECLASS_CALLCTOR, _
					astGetFullType( instptr ), _
					astGetSubtype( instptr ) )

	n->l = procexpr
	n->r = instptr

	function = n
end function

'' Copy-back any fixed-length strings that were passed to BYREF parameters
private sub hCopyStringsBack( byval f as ASTNODE ptr )
	dim as ASTNODE ptr t = any
	dim as AST_TMPSTRLIST_ITEM ptr n = any, p = any

	n = f->call.strtail
	do while( n <> NULL )

		t = rtlStrAssign( n->srctree, astNewVAR( n->sym ) )
		astLoad( t )
		astDelNode( t )

		p = n->prev
		listDelNode( @ast.call.tmpstrlist, n )
		n = p
	loop
end sub

function astLoadCALL( byval n as ASTNODE ptr ) as IRVREG ptr
	static as integer reclevel = 0
	'' totalstackbytes is the sum of all args and padding currently on the stack
	'' for function calls. (Assumes recursive calls can happen only while
	'' generating IR for nested function calls, all in the same stack frame.)
	static as integer totalstackbytes = 0
	dim as ASTNODE ptr arg = any, nextarg = any, l = any
	dim as FBSYMBOL ptr proc = any
	dim as integer bytestopop = any, bytestoalign = any, argbytes = any
	dim as integer prev_totalstackbytes = totalstackbytes
	dim as IRVREG ptr vr = any, v1 = any, lreg = NULL

	'' ARGs can contain CALLs themselves, then astLoadCALL() will recurse
	reclevel += 1

	proc = n->sym

	if( (env.clopt.backend = FB_BACKEND_GAS) and _
	    (env.target.options and FB_TARGETOPT_STACKALIGN16) <> 0 ) then
		'' Add extra stack alignment to ensure the stack pointer will be
		'' aligned to a multiple of 16 after the arguments were pushed,
		'' assuming the current stack pointer was already aligned that way
		'' before the first (non-recursive) call to astLoadCALL.
		argbytes = 0
		arg = n->r
		while( arg )
			l = arg->l
			if( arg->sym->param.regnum = 0 ) then
				argbytes += symbCalcArgLen( l->dtype, l->subtype, arg->arg.mode )
			end if
			arg = arg->r
		wend

		'' Include the size of the hidden ptr parameter, for returning structs
		'' (We don't care who pops it)
		if( symbProcReturnsOnStack( proc ) ) then
			argbytes += env.pointersize
		end if

		bytestoalign = (16 - ((totalstackbytes + argbytes) and (16-1))) and (16-1)
		if( bytestoalign > 0 ) then
			if( ast.doemit ) then
				irEmitSTACKALIGN( bytestoalign )
			end if
			totalstackbytes += bytestoalign
		end if
	else
		bytestoalign = 0
	end if

	'' Count up the size for the caller's stack clean up (after the call)
	bytestopop = bytestoalign

	'' FB_BACKEND_GAS: THISCALL & FASTCALL
	'' ECX is always loaded last before the function call
	'' so we don't need to worry about preserving it
	'' EDX might get trashed if we have nested function calls
	'' !!!FIXME!!! we maybe need to preserve EDX before we
	'' start pushing arguments to the function call and restore
	'' EDX after the call completes.
	'' if( (env.clopt.backend = FB_BACKEND_GAS) then
	''     arg = n->r
	''     while( arg )
	''         if( arg->sym->param.regnum = 2 ) then
	''             save_edx = TRUE
	''             exit while
	''          end if
	''         arg = arg->r
	''     wend
	'' end if

	'' Push each argument
	arg = n->r
	while( arg )
		nextarg = arg->r
		l = arg->l

		'' cdecl: pushed arguments must be popped by caller
		'' pascal/stdcall: callee does it instead
		'' thiscall: callee does it in gcc 32-bit win32
		'' fastcall: callee does it in gcc 32-bit win32
		'' don't add bytes if argument is passed in a register
		if( arg->sym->param.regnum <> 0 ) then
			argbytes = 0
		else
			argbytes = symbCalcArgLen( l->dtype, l->subtype, arg->arg.mode )
			if( symbGetProcMode( proc ) = FB_FUNCMODE_CDECL ) then
				bytestopop += argbytes
			end if
		end if

		if( l->class = AST_NODECLASS_CONV ) then
			astUpdateCONVFD2FS( l, arg->dtype, FALSE )
		end if

		'' flush the arg expression
		v1 = astLoad( l )
		astDelNode( l )

		if( ast.doemit ) then
			if( arg->sym->param.regnum <> 0 ) then
				lreg = irAllocVREG( typeGetDtAndPtrOnly( l->dtype ), l->subtype )
				'' regFamily should be irrelevent for thiscall/fastcall
				'' lreg->regFamily = IR_REG_FPU_STACK | IR_REG_SSE
				lreg->dtype = l->dtype
			else
				lreg = NULL
			end if
			irEmitPUSHARG( arg->sym, v1, arg->arg.lgt, reclevel, lreg )
		end if
		totalstackbytes += argbytes

		astDelNode( arg )
		arg = nextarg
	wend

	'' Hidden param for functions returning big structs on stack
	if( symbProcReturnsOnStack( proc ) ) then
		'' Pop hidden ptr if cdecl/thiscall/fastcall and target doesn't
		'' want the callee to do it, despite it being cdecl/thiscall/fastcall.
		select case symbGetProcMode( proc )
		case FB_FUNCMODE_CDECL, FB_FUNCMODE_THISCALL, FB_FUNCMODE_FASTCALL
			if( (env.target.options and FB_TARGETOPT_CALLEEPOPSHIDDENPTR) = 0) then
				bytestopop += env.pointersize
			end if
		end select
		if( ast.doemit ) then
			'' Clear the temp struct (so the function can safely
			'' do assignments to it in case it includes STRINGs),
			'' unless it has a constructor (which the function will
			'' call anyways).
			if( symbHasCtor( n->call.tmpres ) = FALSE ) then
				astLoad( astBuildTempVarClear( n->call.tmpres ) )
			end if

			'' Pass the address of the temp result struct
			l = astNewVAR( n->call.tmpres )
			l = astNewADDROF( l )
			v1 = astLoad( l )
			'' (passing NULL param, because no PARAM symbol exists
			'' for the hidden struct result param)
			irEmitPUSHARG( NULL, v1, 0, reclevel, NULL )
		end if
		totalstackbytes += env.pointersize
	end if

	if( ast.doemit ) then
		'' SUB or function result ignored?
		if( astGetDataType( n ) = FB_DATATYPE_VOID ) then
			vr = NULL
		else

			'' va_list
			if( typeGetMangleDt( astGetFullType( n ) ) = FB_DATATYPE_VA_LIST ) then
				'' if dtype has a mangle modifier, let the emitter
				'' handle the remapping
			else

				'' When returning BYREF the CALL's dtype should have
				'' been remapped by astBuildByrefResultDeref()
				assert( iif( symbIsReturnByRef( proc ), _
						typeGetDtPtrAndMangleDtOnly( astGetFullType( n ) ) = typeGetDtPtrAndMangleDtOnly( symbGetProcRealType( proc ) ), _
						TRUE ) )
			end if

			vr = irAllocVREG( symbGetProcRealType( proc ), _
							symbGetProcRealSubtype( proc ) )

			if( proc->proc.returnMethod <> FB_RETURN_SSE ) then
				vr->regFamily = IR_REG_FPU_STACK
			end if
		end if
	end if

	'' function pointer?
	l = n->l
	if( l ) then
		v1 = astLoad( l )
		astDelNode( l )
		if( ast.doemit ) then
			irEmitCALLPTR( proc, v1, vr, bytestopop, reclevel )
		end if
	else
		if( ast.doemit ) then
			irEmitCALLFUNCT( proc, bytestopop, vr, reclevel )
		end if
	end if

	totalstackbytes = prev_totalstackbytes

	hCopyStringsBack( n )

	reclevel -= 1

	function = vr
end function

function astLoadCALLCTOR( byval n as ASTNODE ptr ) as IRVREG ptr
	dim as IRVREG ptr vr = any

	'' flush the ctor CALL to initialize the temp var
	astLoad( n->l )
	astDelNode( n->l )

	'' return the VAR access to the temp var
	vr = astLoad( n->r )
	astDelNode( n->r )

	function = vr
end function

'':::::
sub astCloneCALL _
	( _
		byval n as ASTNODE ptr, _
		byval c as ASTNODE ptr _
	)

	'' copy-back list
	scope
		dim as AST_TMPSTRLIST_ITEM ptr sn = any, sc = any

		c->call.strtail = NULL
		sn = n->call.strtail
		do while( sn <> NULL )
			sc = listNewNode( @ast.call.tmpstrlist )

			sc->sym = sn->sym
			sc->srctree = astCloneTree( sn->srctree )
			sc->prev = c->call.strtail

			c->call.strtail = sc

			sn = sn->prev
		loop
	end scope

	'' Find the last ARG (if any); for each ARG...
	n = c->r
	while( n )
		'' last one?
		if( n->r = NULL ) then
			exit while
		end if
		n = n->r
	wend
	c->call.argtail = n

end sub

'':::::
sub astDelCALL _
	( _
		byval n as ASTNODE ptr _
	)

	'' copy-back list
	scope
	    dim as AST_TMPSTRLIST_ITEM ptr s = any, p = any
		s = n->call.strtail
		do while( s <> NULL )
			p = s->prev

			astDelTree( s->srctree )

			listDelNode( @ast.call.tmpstrlist, s )
			s = p
		loop
	end scope

end sub

'':::::
sub astReplaceSymbolOnCALL _
	( _
		byval n as ASTNODE ptr, _
		byval old_sym as FBSYMBOL ptr, _
		byval new_sym as FBSYMBOL ptr _
	)

	'' check temp res
	if( n->call.tmpres = old_sym ) then
		n->call.tmpres = new_sym
	end if

	'' copy-back list
	scope
		dim as AST_TMPSTRLIST_ITEM ptr s = any
		s = n->call.strtail
		do while( s <> NULL )
			if( s->sym = old_sym ) then
				s->sym = new_sym
			end if

			astReplaceSymbolOnTree( s->srctree, old_sym, new_sym )

			s = s->prev
		loop
	end scope

end sub

'' For accessing the temp result var allocated by CALLs that return on stack
function astBuildCallResultVar( byval expr as ASTNODE ptr ) as ASTNODE ptr
	assert( astIsCALL( expr ) )
	assert( symbProcReturnsOnStack( expr->sym ) )

	'' CALL first, but return the VAR
	function = astNewLINK( expr, _
		astNewVAR( expr->call.tmpres, 0, astGetFullType( expr ), astGetSubtype( expr ) ), _
		AST_LINK_RETURN_RIGHT )
end function

'' For storing UDT CALL results into a temp var and accessing it
function astBuildCallResultUdt( byval expr as ASTNODE ptr ) as ASTNODE ptr
	dim as FBSYMBOL ptr tmp = any

	assert( astIsCALL( expr ) )
	assert( astGetDataType( expr ) = FB_DATATYPE_STRUCT )
	assert( symbIsReturnByRef( expr->sym ) = FALSE )

	if( symbProcReturnsOnStack( expr->sym ) ) then
		'' UDT returned in temp var already, just access that one
		function = astBuildCallResultVar( expr )
	else
		'' UDT returned in registers, copy to a temp var to allow field accesses etc.
		tmp = symbAddTempVar( FB_DATATYPE_STRUCT, expr->subtype )

		'' No need to bother doing astDtorListAdd()
		'' (UDTs with dtor are never returned in registers)
		assert( symbHasDtor( tmp ) = FALSE )

		expr = astNewASSIGN( astBuildVarField( tmp ), expr, AST_OPOPT_DONTCHKOPOVL or AST_OPOPT_ISINI )

		'' ASSIGN first, but return the field access
		function = astNewLINK( expr, _
			astBuildVarField( tmp ), _
			AST_LINK_RETURN_RIGHT )
	end if
end function

function astBuildByrefResultDeref( byval expr as ASTNODE ptr ) as ASTNODE ptr
	dim as integer dtype = any
	dim as FBSYMBOL ptr subtype = any

	'' Only for CALLs; it could be a CONST( 0 ) after error recovery in
	'' cProcArgList()
	if( astIsCALL( expr ) = FALSE ) then
		return expr
	end if

	'' And only if it actually has a BYREF result
	if( symbIsReturnByref( expr->sym ) = FALSE ) then
		return expr
	end if

	'' Do an implicit DEREF with the function's type, and remap the CALL
	'' node's type to the pointer, so the AST is consistent even if that
	'' DEREF gets optimized out.
	''
	'' If the function type is a forward reference, we must show an error.
	'' (essentially a function with BYREF AS FWDREF result cannot be
	'' called until the fwdref was implemented)

	dtype = symbGetProcRealType( expr->sym )
	subtype = symbGetProcRealSubtype( expr->sym )

	if( typeGetDtOnly( dtype ) = FB_DATATYPE_FWDREF ) then
		errReport( FB_ERRMSG_INCOMPLETETYPE )
		dtype = typeJoinDtOnly( dtype, FB_DATATYPE_INTEGER )
		subtype = NULL
	end if

	astSetType( expr, dtype, subtype )

	function = astNewDEREF( expr )
end function

function astIsByrefResultDeref( byval expr as ASTNODE ptr ) as integer
	function = FALSE
	'' DEREF with expression? (and not just DEREF of a constant)
	if( astIsDEREF( expr ) andalso expr->l ) then
		if( astIsCALL( expr->l ) ) then
			function = symbIsReturnByref( expr->l->sym )
		end if
	end if
end function

function astRemoveByrefResultDeref( byval expr as ASTNODE ptr ) as ASTNODE ptr
	assert( astIsByrefResultDeref( expr ) )
	function = expr->l
	astDelNode( expr )
end function

private function hCanIgnoreFunctionResult( byval dtype as integer ) as integer
	'' Only integers (excluding char/wchar) can be ignored
	if( typeGetClass( dtype ) = FB_DATACLASS_INTEGER ) then
		select case( dtype )
		case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR

		case else
			return TRUE
		end select
	end if
	function = FALSE
end function

function astIgnoreCallResult( byval n as ASTNODE ptr ) as ASTNODE ptr
	dim as integer dtype = any

	assert( astIsCALL( n ) )
	dtype = astGetDataType( n )

	'' If it's a SUB, there's no result to ignore
	if( dtype = FB_DATATYPE_VOID ) then
		return n
	end if

	'' Error checking? Then the result isn't ignored afterall.
	if( n->sym ) then
		if( symbGetIsThrowable( n->sym ) ) then
			return rtlErrorCheck( n )
		end if
	end if

	'' Returning string/wstring? Just do fb_hStrDelTemp/fb_WstrDelete to
	'' to delete the returned temp string, no temp var needed.
	'' (for wstrings, a temp var couldn't be used anyways, because there's
	'' no dynamic wstring type)
	select case( dtype )
	case FB_DATATYPE_STRING, FB_DATATYPE_WCHAR
		'' This mustn't be done if returning BYREF, but in that case
		'' we shouldn't come here, since the CALL's dtype should be
		'' remapped already.
		assert( symbIsReturnByref( n->sym ) = FALSE )

		if( dtype = FB_DATATYPE_WCHAR ) then
			'' Actually returning a wstring ptr. Remap the type so the
			'' astNewARG()s done from rtlStrDelete() build the correct code.
			astSetType( n, typeAddrOf( FB_DATATYPE_WCHAR ), NULL )
		end if

		return rtlStrDelete( n )
	end select

	'' Tell astLoadCALL() to not allocate a result vreg. Works for
	'' - integers and small UDTs returned in registers,
	'' - and also UDTs returned on stack: the pointer that is returned in
	''   registers is ignored, and the temp var holding the result will
	''   automatically be destructed at the end of the statement, if needed.
	'' - also floats, because the ASM backend takes care to pop st(0) from
	''   the FPU stack as needed by the ABI
	astSetType( n, FB_DATATYPE_VOID, NULL )
	function = n
end function

'' Build a fake CALL to the given procedure, to be used for error recovery.
function astBuildFakeCall( byval proc as FBSYMBOL ptr ) as ASTNODE ptr
	var c = astNewCALL( proc )

	'' Build fake arg for each param (including the THIS param for methods)
	var param = symbGetProcHeadParam( proc )
	while( param )
		astNewARG( c, astNewCONSTz( symbGetType( param ), param->subtype ) )
		param = param->next
	wend

	function = c
end function
