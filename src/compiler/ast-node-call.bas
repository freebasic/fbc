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

	assert( sym <> NULL )

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
		n->call.currarg	= symbGetProcHeadParam( sym )
		n->call.isrtl = symbGetIsRTL( sym )

		callback = symbGetProcCallback( sym )
		if( callback <> NULL ) then
			callback( sym )
		end if
	else
		n->call.currarg	= NULL
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

private sub hCheckTmpStrings( byval f as ASTNODE ptr )
    dim as ASTNODE ptr t = any
    dim as AST_TMPSTRLIST_ITEM ptr n = any, p = any

	'' copy-back any fix-len string passed as parameter and
	'' delete all temp strings used as parameters
	n = f->call.strtail
	do while( n <> NULL )

		'' copy back if needed
		if( n->srctree <> NULL ) then
			t = rtlStrAssign( n->srctree, astNewVAR( n->sym ) )
			astLoad( t )
			astDelNode( t )
		end if

		'' delete the temp string (or wstring)
		t = rtlStrDelete( astNewVAR( n->sym ) )
		astLoad( t )
		astDelNode( t )

		p = n->prev
		listDelNode( @ast.call.tmpstrlist, n )
		n = p
	loop
end sub

function astLoadCALL( byval n as ASTNODE ptr ) as IRVREG ptr
	static as integer reclevel = 0
	dim as ASTNODE ptr arg = any, nextarg = any, l = any
	dim as FBSYMBOL ptr proc = any
	dim as integer bytestopop = any, bytestoalign = any
	dim as IRVREG ptr vr = any, v1 = any

	'' ARGs can contain CALLs themselves, then astLoadCALL() will recurse
	reclevel += 1

	proc = n->sym

#if 1
	bytestoalign = 0
#else
	'' Add extra stack alignment to ensure the stack pointer will be
	'' aligned to a multiple of 16 after the arguments were pushed,
	'' assuming our current stack pointer already is aligned that way.
	bytestopop = 0
	arg = n->r
	while( arg )
		l = arg->l
		bytestopop += symbCalcArgLen( l->dtype, l->subtype, arg->arg.mode )
		arg = arg->r
	wend

	bytestoalign = (16 - (bytestopop and (16-1))) and (16-1)
	if( bytestoalign > 0 ) then
		if( ast.doemit ) then
			irEmitSTACKALIGN( bytestoalign )
		end if
	end if
#endif

	'' Count up the size for the caller's stack clean up (after the call)
	bytestopop = 0

	'' Push each argument
	arg = n->r
	while( arg )
		nextarg = arg->r
		l = arg->l

		'' cdecl: pushed arguments must be popped by caller
		'' pascal/stdcall: callee does it instead
		if( symbGetProcMode( proc ) = FB_FUNCMODE_CDECL ) then
			bytestopop += symbCalcArgLen( l->dtype, l->subtype, arg->arg.mode )
		end if

		if( l->class = AST_NODECLASS_CONV ) then
			astUpdateCONVFD2FS( l, arg->dtype, FALSE )
		end if

		'' flush the arg expression
		v1 = astLoad( l )
		astDelNode( l )

		if( ast.doemit ) then
			irEmitPUSHARG( arg->sym, v1, arg->arg.lgt, reclevel )
		end if

		astDelNode( arg )
		arg = nextarg
	wend

	'' Hidden param for functions returning big structs on stack
	if( symbProcReturnsOnStack( proc ) ) then
		'' Pop hidden ptr if cdecl and target doesn't want the callee
		'' to do it, despite it being cdecl.
		if( (symbGetProcMode( proc ) = FB_FUNCMODE_CDECL) and _
		    ((env.target.options and FB_TARGETOPT_CALLEEPOPSHIDDENPTR) = 0) ) then
			bytestopop += env.pointersize
		end if
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
			irEmitPUSHARG( NULL, v1, 0, reclevel )
		end if
	end if

	if( ast.doemit ) then
		'' SUB or function result ignored?
		if( astGetDataType( n ) = FB_DATATYPE_VOID ) then
			vr = NULL
		else
			'' When returning BYREF the CALL's dtype should have
			'' been remapped by astBuildByrefResultDeref()
			assert( iif( symbProcReturnsByref( proc ), _
					astGetDataType( n ) = typeGetDtAndPtrOnly( symbGetProcRealType( proc ) ), _
					TRUE ) )

			vr = irAllocVREG( typeGetDtAndPtrOnly( symbGetProcRealType( proc ) ), _
							symbGetProcRealSubtype( proc ) )

			if( proc->proc.returnMethod <> FB_RETURN_SSE ) then
				vr->regFamily = IR_REG_FPU_STACK
			end if
		end if
	end if

	'' caller always has to undo any stack alignment it did
	bytestopop += bytestoalign
	bytestoalign = 0

	'' function pointer?
	l = n->l
	if( l ) then
		v1 = astLoad( l )
		astDelNode( l )
		if( ast.doemit ) then
			irEmitCALLPTR( v1, vr, bytestopop, reclevel )
		end if
	else
		if( ast.doemit ) then
			irEmitCALLFUNCT( proc, bytestopop, vr, reclevel )
		end if
	end if

	'' del temp strings and copy back if needed
	hCheckTmpStrings( n )

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

    '' temp string list
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

    '' temp strings list
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

	'' temp strings list
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

	function = astNewLINK( expr, _
		astNewVAR( expr->call.tmpres, 0, astGetFullType( expr ), astGetSubtype( expr ) ), _
		FALSE ) '' CALL first, but return the VAR
end function

'' For storing UDT CALL results into a temp var and accessing it
function astBuildCallResultUdt( byval expr as ASTNODE ptr ) as ASTNODE ptr
	dim as FBSYMBOL ptr tmp = any

	assert( astIsCALL( expr ) )
	assert( astGetDataType( expr ) = FB_DATATYPE_STRUCT )
	assert( symbProcReturnsByref( expr->sym ) = FALSE )

	if( symbProcReturnsOnStack( expr->sym ) ) then
		'' UDT returned in temp var already, just access that one
		function = astBuildCallResultVar( expr )
	else
		'' UDT returned in registers, copy to a temp var to allow field accesses etc.
		tmp = symbAddTempVar( FB_DATATYPE_STRUCT, expr->subtype )

		'' No need to bother doing astDtorListAdd()
		assert( symbHasDtor( tmp ) = FALSE )

		expr = astNewASSIGN( astBuildVarField( tmp ), expr, AST_OPOPT_DONTCHKOPOVL )

		function = astNewLINK( expr, _
			astBuildVarField( tmp ), _
			FALSE ) '' ASSIGN first, but return the field access
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
	if( symbProcReturnsByref( expr->sym ) = FALSE ) then
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
	if( astIsDEREF( expr ) ) then
		if( astIsCALL( expr->l ) ) then
			function = symbProcReturnsByref( expr->l->sym )
		end if
	end if
end function

function astRemoveByrefResultDeref( byval expr as ASTNODE ptr ) as ASTNODE ptr
	assert( astIsByrefResultDeref( expr ) )
	function = expr->l
	astDelNode( expr )
end function

function astCanIgnoreCallResult( byval n as ASTNODE ptr ) as integer
	dim as integer dtype = any

	assert( astIsCALL( n ) )
	dtype = astGetDataType( n )

	'' If it's a SUB, there's no result so it's always "ignored"
	if( dtype = FB_DATATYPE_VOID ) then
		return TRUE
	end if

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
