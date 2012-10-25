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

'''''#define DO_STACK_ALIGN

'':::::
sub astCallInit

	listInit( @ast.call.tmpstrlist, 32, len( AST_TMPSTRLIST_ITEM ), LIST_FLAGS_NOCLEAR )

end sub

'':::::
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
	symbSetIsCalled( sym )

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

	n->call.strtail = NULL

	'' follow GCC 3.x's ABI
	if( symbProcReturnsUdtOnStack( sym ) ) then
		'' create a temp struct (can't be static, could be an object)
		n->call.tmpres = symbAddTempVar( FB_DATATYPE_STRUCT, symbGetSubtype( sym ), FALSE )

		if( symbHasDtor( sym ) ) then
			astDtorListAdd( n->call.tmpres )
		end if
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
			t = rtlStrAssign( n->srctree, _
							  astNewVAR( n->sym, 0, FB_DATATYPE_STRING ) )
			astLoad( t )
			astDelNode( t )
		end if

		'' delete the temp string (or wstring)
		t = rtlStrDelete( astNewVAR( n->sym, 0, symbGetFullType( n->sym ) ) )
		astLoad( t )
		astDelNode( t )

		p = n->prev
		listDelNode( @ast.call.tmpstrlist, n )
		n = p
	loop
end sub

function astLoadCALL( byval n as ASTNODE ptr ) as IRVREG ptr
    static as integer reclevel = 0
    dim as ASTNODE ptr arg = any, next_arg = any, l = any
    dim as FBSYMBOL ptr sym = any, param = any, last_param = any
	dim as FBSYMBOL ptr subtype = any
	dim as integer dtype = any
    dim as integer mode = any, bytestopop = any, bytestoalign = any
    dim as integer params = any, inc = any, args = any
	dim as IRVREG ptr vr = any, v1 = any

    reclevel += 1

	sym = n->sym

	mode = symbGetProcMode( sym )
	if( mode = FB_FUNCMODE_PASCAL ) then
		args = 0
		inc = 1
	else
		args = n->call.args
		inc = -1
	end if

	bytestopop = symbGetProcParamsLen( sym )
	bytestoalign = 0

	''
	params = symbGetProcParams( sym )
	last_param = symbGetProcTailParam( sym )

	if( args <= params ) then
		param = symbGetProcFirstParam( sym )
		'' vararg and param not passed?
		if( args < params ) then
			if( mode <> FB_FUNCMODE_PASCAL ) then
				param = symbGetProcNextParam( sym, param )
			end if

		else
#ifdef DO_STACK_ALIGN
			bytestoalign = ((FB_INTEGERSIZE*4) - _
					  (bytestopop and (FB_INTEGERSIZE*4-1))) and (FB_INTEGERSIZE*4-1)
			if( bytestoalign > 0 ) then
				if( ast.doemit ) then
					irEmitSTACKALIGN( bytestoalign )
				end if
			end if
#endif
		end if
	'' vararg
	else
		param = last_param
	end if

	'' for each argument..
	arg = n->r
	do while( arg <> NULL )
		next_arg = arg->r

		l = arg->l

		''
		if( param = last_param ) then
			if( symbGetParamMode( param ) = FB_PARAMMODE_VARARG ) then
				bytestopop += FB_ROUNDLEN( symbCalcLen( astGetDataType( l ), NULL ) )
			end if
		end if

		if( l->class = AST_NODECLASS_CONV ) then
			astUpdateCONVFD2FS( l, arg->dtype, FALSE )
		end if

		'' flush the arg expression
		v1 = astLoad( l )
		astDelNode( l )

		if( ast.doemit ) then
			irEmitPUSHARG( v1, arg->arg.lgt, reclevel )
		end if

		astDelNode( arg )

		args += inc
		if( args < params ) then
			param = symbGetProcNextParam( sym, param )
		end if

		arg = next_arg
	loop

	if( symbProcReturnsUdtOnStack( sym ) ) then
		if( ast.doemit ) then
			'' pass the address of the temp struct (it must be cleared if it
			'' includes string fields)
			l = astNewVAR( n->call.tmpres, 0, FB_DATATYPE_STRUCT, symbGetSubtype( sym ), TRUE )
			l = astNewADDROF( l )
			v1 = astLoad( l )
			irEmitPUSHARG( v1, 0, reclevel )
		end if
	end if

	dtype = astGetDataType( n )
	subtype = n->subtype

	select case as const dtype
	'' returning a string? it's actually a pointer to a string descriptor
	case FB_DATATYPE_STRING, FB_DATATYPE_WCHAR
		dtype = typeAddrOf( dtype )
		subtype = NULL

	'' UDT's can be returned in regs or as a pointer to the hidden param passed
	case FB_DATATYPE_STRUCT
		dtype = typeGet( symbGetUDTRetType( n->subtype ) )
		if( dtype <> FB_DATATYPE_STRUCT ) then
			subtype = NULL
		end if

	'case FB_DATATYPE_CLASS
		' ...
	end select

	if( ast.doemit ) then
		vr = NULL
		if( dtype <> FB_DATATYPE_VOID ) then
			vr = irAllocVREG( dtype, subtype )
			if( sym->proc.returnMethod <> FB_RETURN_SSE ) then
				vr->regFamily = IR_REG_FPU_STACK
			end if
		end if
	end if

	if( mode = FB_FUNCMODE_CDECL ) then
		bytestopop += bytestoalign
		bytestoalign = 0
	else
		bytestopop = 0
	end if

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
			irEmitCALLFUNCT( sym, bytestopop, vr, reclevel )
		end if
	end if

	if( bytestoalign > 0 ) then
		if( ast.doemit ) then
			irEmitSTACKALIGN( -bytestoalign )
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

		'' add to temp dtor list?
		if( symbHasDtor( new_sym ) ) then
			astDtorListAdd( new_sym )
		end if
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

'':::::
function astGetCALLResUDT(byval expr as ASTNODE ptr) as ASTNODE ptr
	var subtype = astGetSubtype( expr )

	'' returning an UDT in registers or as-is, i.e. not as a hidden arg?
	'' (the latter is an exception made for the C emitter)
	if( symbIsUDTReturnedInRegs( subtype ) or _
	    (typeIsPtr( symbGetUDTRetType( subtype ) ) = FALSE) ) then
		'' move to a temp var
		'' (note: if it's being returned in regs, there's no DTOR)
		dim as FBSYMBOL ptr tmp = symbAddTempVar( FB_DATATYPE_STRUCT, subtype, FALSE )
		expr = astNewASSIGN( astBuildVarField( tmp ), expr, AST_OPOPT_DONTCHKOPOVL )
		function = astNewLINK( astBuildVarField( tmp ), expr )
	else
		'' returning result in a hidden arg
		function = astBuildCallHiddenResVar( expr )
	end if
end function
