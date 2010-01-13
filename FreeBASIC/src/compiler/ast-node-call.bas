''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2008 The FreeBASIC development team.
''
''	This program is free software; you can redistribute it and/or modify
''	it under the terms of the GNU General Public License as published by
''	the Free Software Foundation; either version 2 of the License, or
''	(at your option) any later version.
''
''	This program is distributed in the hope that it will be useful,
''	but WITHOUT ANY WARRANTY; without even the implied warranty of
''	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''	GNU General Public License for more details.
''
''	You should have received a copy of the GNU General Public License
''	along with this program; if not, write to the Free Software
''	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.

'' AST function call nodes
'' l = pointer node if any; r = first arg to be pushed
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\list.bi"
#include once "inc\ir.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"

'''''#define DO_STACK_ALIGN

'':::::
sub astCallInit

	listNew( @ast.call.tmpstrlist, 32, len( AST_TMPSTRLIST_ITEM ), LIST_FLAGS_NOCLEAR )

end sub

'':::::
sub astCallEnd

	listFree( @ast.call.tmpstrlist )

end sub

'':::::
private sub hAllocTempStruct _
	( _
		byval n as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr _
	) static

	n->call.tmpres = NULL

	'' follow GCC 3.x's ABI
	if( symbGetUDTInRegister( sym ) = FALSE ) then

		'' create a temp struct (can't be static, could be an object)
		n->call.tmpres = symbAddTempVar( FB_DATATYPE_STRUCT, _
									     symbGetSubtype( sym ), _
									     FALSE, _
									     FALSE )

		if( symbGetHasDtor( symbGetSubtype( sym ) ) ) then
			astDtorListAdd( n->call.tmpres )
		end if

	end if

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

	if( n = NULL ) then
		exit function
	end if

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

	'' handle functions that return structs
	hAllocTempStruct( n, sym )

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
	if( n = NULL ) then
		return NULL
	end if

	n->l = procexpr
	n->r = instptr

	function = n

end function

'':::::
private function hCallProc _
	( _
		byval n as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr, _
		byval mode as integer, _
		byval bytestopop as integer, _
		byval bytesaligned as integer _
	) as IRVREG ptr

    dim as IRVREG ptr vreg = any, vr = any
    dim as ASTNODE ptr p = any
    dim as integer dtype = any
    dim as FBSYMBOL ptr subtype

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
		vreg = NULL
		if( dtype <> FB_DATATYPE_VOID ) then
			vreg = irAllocVREG( dtype, subtype )
			if( sym->proc.returnMethod <> FB_RETURN_SSE ) then
				vreg->regFamily = IR_REG_FPU_STACK
			end if
		end if
	end if

	if( mode <> FB_FUNCMODE_CDECL ) then
		select case mode
		case FB_FUNCMODE_STDCALL, FB_FUNCMODE_STDCALL_MS
			if( env.target.allowstdcall ) then
				bytestopop = 0
			end if
		case else
			bytestopop = 0
		end select
	else
		bytestopop += bytesaligned
		bytesaligned = 0
	end if

	'' function?
	p = n->l
	if( p = NULL ) then
		if( ast.doemit ) then
			irEmitCALLFUNCT( sym, bytestopop, vreg )
		end if

	'' ptr..
	else
		vr = astLoad( p )
		astDelNode( p )
		if( ast.doemit ) then
			irEmitCALLPTR( vr, vreg, bytestopop )
		end if
	end if

	if( bytesaligned > 0 ) then
		if( ast.doemit ) then
			irEmitSTACKALIGN( -bytesaligned )
		end if
	end if

	function = vreg

end function

'':::::
private sub hCheckTmpStrings _
	( _
		byval f as ASTNODE ptr _
	)

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


'':::::
private sub hCheckTempStruct _
	( _
		byval n as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr _
	)

	dim as IRVREG ptr vr = any

	if( ast.doemit = FALSE ) then
		exit sub
	end if

	'' follow GCC 3.x's ABI
	if( symbGetUDTInRegister( sym ) = FALSE ) then

    	'' pass the address of the temp struct (it must be cleared if it
    	'' includes string fields)
    	vr = astLoad( astNewADDROF( astNewVAR( n->call.tmpres, _
    							 			   0, _
    							 			   FB_DATATYPE_STRUCT, _
    							 			   symbGetSubtype( sym ), _
    							 			   TRUE ) ) )

    	irEmitPUSHARG( vr, 0 )

	end if

end sub

'':::::
function astLoadCALL _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

    dim as ASTNODE ptr arg = any, next_arg = any, l = any
    dim as FBSYMBOL ptr sym = any, param = any, last_param = any
    dim as integer mode = any, topop = any, toalign = any
    dim as integer params = any, inc = any, args = any
    dim as IRVREG ptr vr = any

	sym = n->sym

    ''
    mode = sym->proc.mode
	if( mode = FB_FUNCMODE_PASCAL ) then
		args = 0
		inc = 1
	else
		args = n->call.args
		inc = -1
	end if

	topop = symbGetProcParamsLen( sym )
	toalign = 0

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
			toalign = ((FB_INTEGERSIZE*4) - _
					  (topop and (FB_INTEGERSIZE*4-1))) and (FB_INTEGERSIZE*4-1)
			if( toalign > 0 ) then
				if( ast.doemit ) then
					irEmitSTACKALIGN( toalign )
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
				topop += FB_ROUNDLEN( symbCalcLen( astGetDataType( l ), NULL ) )
			end if
		end if

		'' flush the arg expression
		vr = astLoad( l )
		astDelNode( l )

		if( ast.doemit ) then
			irEmitPUSHARG( vr, arg->arg.lgt )
		end if

		astDelNode( arg )

		args += inc
		if( args < params ) then
			param = symbGetProcNextParam( sym, param )
		end if

		arg = next_arg
	loop

	'' handle functions returning structs
	hCheckTempStruct( n, sym )

	'' invoke
	vr = hCallProc( n, sym, mode, topop, toalign )

	'' del temp strings and copy back if needed
	hCheckTmpStrings( n )

    function = vr

end function

'':::::
function astLoadCALLCTOR _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

	dim as IRVREG ptr vr = any

	if( n = NULL ) then
		return NULL
	end if

	astLoad( n->l )
	astDelNode( n->l )

	'' return the anon var
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
		if( symbGetHasDtor( symbGetSubtype( new_sym ) ) ) then
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
function astGetCALLResUDT _
	( _
		byval expr as ASTNODE ptr _
	) as ASTNODE ptr

	'' returning an UDT in registers?
	if( symbGetUDTRetType( astGetSubtype( expr ) ) <> _
						   typeAddrOf( FB_DATATYPE_STRUCT ) ) then

		'' move to a temp var
		'' (note: if it's being returned in regs, there's no DTOR)
		dim as FBSYMBOL ptr tmp = symbAddTempVar( FB_DATATYPE_STRUCT, _
				  	  	  	  					  astGetSubtype( expr ), _
				  	  	  	  					  FALSE, _
				  	  	  	  					  FALSE )

		expr = astNewASSIGN( astBuildVarField( tmp ), _
				  	  	 	 expr, _
				  	  	 	 AST_OPOPT_DONTCHKOPOVL )

    	function = astNewLINK( astBuildVarField( tmp ), expr )

    '' returning result in a hidden arg..
    else
    	function = astBuildCallHiddenResVar( expr )
    end if

end function
