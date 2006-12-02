''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2007 The FreeBASIC development team.
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
	listNew( @ast.call.dtorlist, 32, len( AST_DTORLIST_ITEM ), LIST_FLAGS_NOCLEAR )

end sub

'':::::
sub astCallEnd

	listFree( @ast.call.dtorlist )
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
	if( symbGetType( sym ) = FB_DATATYPE_STRUCT ) then
		'' not returned in registers?
		if( symbGetProcRealType( sym ) = FB_DATATYPE_POINTER + FB_DATATYPE_STRUCT ) then

			'' create a temp struct (can't be static, could be an object)
			n->call.tmpres = symbAddTempVar( FB_DATATYPE_STRUCT, _
										     symbGetSubtype( sym ), _
										     FALSE, _
										     FALSE )

			if( symbGetHasDtor( symbGetSubtype( sym ) ) ) then
				symbSetIsTempWithDtor( n->call.tmpres, TRUE )
			end if
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
	dtype = symbGetType( sym )
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
	n->call.dtortail = NULL

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
					astGetDataType( instptr ), _
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

	dtype = n->dtype

	select case dtype
	'' returning an string? it's actually a pointer to a string descriptor
	case FB_DATATYPE_STRING, FB_DATATYPE_WCHAR
		dtype += FB_DATATYPE_POINTER

	'' UDT's can be returned in regs or as a pointer to the hidden param passed
	case FB_DATATYPE_STRUCT
		dtype = symbGetUDTRetType( n->subtype )

	'case FB_DATATYPE_CLASS
		' ...
	end select

	if( ast.doemit ) then
		vreg = NULL
		if( dtype <> FB_DATATYPE_VOID ) then
			vreg = irAllocVREG( dtype )
		end if
	end if

	if( mode <> FB_FUNCMODE_CDECL ) then
		if( mode = FB_FUNCMODE_STDCALL ) then
			if( env.clopt.nostdcall = FALSE ) then
				bytestopop = 0
			end if
		else
			bytestopop = 0
		end if
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

	if( ast.doemit ) then
		select case n->dtype
		'' string or wstring? it's actually a pointer to a descriptor
		case FB_DATATYPE_STRING, FB_DATATYPE_WCHAR
			vreg = irAllocVRPTR( n->dtype, 0, vreg )

		'' udt? if not retuned in registers, deref the pointer
		case FB_DATATYPE_STRUCT
			if( symbGetUDTRetType( n->subtype ) = FB_DATATYPE_POINTER+FB_DATATYPE_STRUCT ) then
				vreg = irAllocVRPTR( FB_DATATYPE_STRUCT, 0, vreg )
			end if

		'case FB_DATATYPE_CLASS
			' ...
		end select
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
		t = rtlStrDelete( astNewVAR( n->sym, 0, symbGetType( n->sym ) ) )
		astLoad( t )
		astDelNode( t )

		p = n->prev
		listDelNode( @ast.call.tmpstrlist, n )
		n = p
	loop

end sub

'':::::
private sub hDtorListFlush _
	( _
		byval f as ASTNODE ptr _
	)

    dim as ASTNODE ptr t = any
    dim as AST_DTORLIST_ITEM ptr n = any, p = any

	n = f->call.dtortail
	do while( n <> NULL )
        t = astBuildVarDtorCall( n->sym )
        astLoad( t )
        astDelNode( t )

		p = n->prev
		listDelNode( @ast.call.dtorlist, n )
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
	dim as FBSYMBOL a = any

	if( ast.doemit = FALSE ) then
		exit sub
	end if

	'' follow GCC 3.x's ABI
	if( symbGetType( sym ) = FB_DATATYPE_STRUCT ) then
		if( symbGetProcRealType( sym ) = FB_DATATYPE_POINTER + FB_DATATYPE_STRUCT ) then

        	'' pass the address of the temp struct (it must be cleared if it
        	'' includes string fields)
        	vr = astLoad( astNewVAR( n->call.tmpres, _
        							 0, _
        							 FB_DATATYPE_STRUCT, _
        							 symbGetSubtype( sym ), _
        							 TRUE ) )

        	a.typ = FB_DATATYPE_VOID
        	a.param.mode = FB_PARAMMODE_BYREF

        	irEmitPUSHARG( sym, @a, vr, INVALID, FB_POINTERSIZE )
		end if
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
				topop += FB_ROUNDLEN( symbCalcLen( l->dtype, NULL ) )
			end if
		end if

		'' flush the arg expression
		vr = astLoad( l )
		astDelNode( l )

		if( ast.doemit ) then
			irEmitPUSHARG( sym, param, vr, arg->arg.mode, arg->arg.lgt )
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

	'' return proc's result
	vr = hCallProc( n, sym, mode, topop, toalign )

	''
	hDtorListFlush( n )

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

    '' temp dtor list
    scope
    	dim as AST_DTORLIST_ITEM ptr dn = any, dc = any

		c->call.dtortail = NULL
		dn = n->call.dtortail
		do while( dn <> NULL )
        	dc = listNewNode( @ast.call.dtorlist )

        	dc->sym = dn->sym
        	dc->prev = c->call.dtortail

        	c->call.dtortail = dc

			dn = dn->prev
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

    '' temp dtor list
    scope
	    dim as AST_DTORLIST_ITEM ptr d = any, p = any
		d = n->call.dtortail
		do while( d <> NULL )
			p = d->prev
			listDelNode( @ast.call.dtorlist, d )
			d = p
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

    '' temp dtor list
    scope
	    dim as AST_DTORLIST_ITEM ptr d = any
		d = n->call.dtortail
		do while( d <> NULL )
			if( d->sym = old_sym ) then
				d->sym = new_sym
			end if

			d = d->prev
    	loop
    end scope

end sub
