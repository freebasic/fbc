''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2006 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\list.bi"
#include once "inc\ir.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"

'''''#define DO_STACK_ALIGN

'':::::
private sub hAllocTempStruct _
	( _
		byval n as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr _
	) static

	'' follow GCC 3.x's ABI
	if( sym->typ = FB_DATATYPE_USERDEF ) then
		if( sym->proc.realtype = FB_DATATYPE_POINTER + FB_DATATYPE_USERDEF ) then
			'' create a temp struct
			n->call.res = symbAddTempVarEx( FB_DATATYPE_USERDEF, sym->subtype )
		end if
	end if

end sub

'':::::
function astNewCALL _
	( _
		byval sym as FBSYMBOL ptr, _
		byval ptrexpr as ASTNODE ptr = NULL, _
		byval isprofiler as integer = FALSE _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any
    dim as FBRTLCALLBACK callback = any
    dim as integer dtype = any
    dim as FBSYMBOL ptr subtype = any

	'' if return type is an UDT, change to the real one
	if( sym <> NULL ) then
		dtype   = symbGetType( sym )
		subtype = symbGetSubType( sym )
		if( dtype = FB_DATATYPE_USERDEF ) then
			'' only if it's not a pointer, but a reg (integer or fpoint)
			if( sym->proc.realtype < FB_DATATYPE_POINTER ) then
				dtype   = sym->proc.realtype
				subtype = NULL
			end if
		end if

		''
		symbSetIsCalled( sym )

	else
		if( ptrexpr = NULL ) then
			return NULL
		end if
		dtype   = ptrexpr->dtype
		subtype = ptrexpr->subtype
	end if

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

	n->call.arraytail = NULL
	n->call.strtail = NULL

	'' handle functions that return structs
	hAllocTempStruct( n, sym )

	'' function profiling
	n->call.profbegin = NULL
	n->call.profend = NULL
	if( env.clopt.profile ) then
		if( isprofiler = FALSE ) then
			n->call.profbegin = rtlProfileBeginCall( sym )
			if( n->call.profbegin <> NULL ) then
				n->call.profend = rtlProfileEndCall( )
			end if
		end if
	end if

end function

'':::::
private function hCallProc _
	( _
		byval n as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr, _
		byval mode as integer, _
		byval bytestopop as integer, _
		byval bytesaligned as integer _
	) as IRVREG ptr static

    dim as IRVREG ptr vreg, vr
    dim as ASTNODE ptr p
    dim as integer dtype

	'' ordinary pointer?
	if( sym = NULL ) then
		p = n->l
		vr = astLoad( p )
		astDelNode( p )
		if( ast.doemit ) then
			irEmitCALLPTR( vr, NULL, 0 )
		end if

		return NULL
	end if

	dtype = n->dtype

	'' function returns as string? it's actually a pointer to a
	'' string descriptor, same with UDT's..
	select case dtype
	case FB_DATATYPE_STRING, _
		 FB_DATATYPE_USERDEF, _
		 FB_DATATYPE_WCHAR
		dtype += FB_DATATYPE_POINTER
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
		'' handle strings and UDT's returned by functions that are actually
		'' pointers to string descriptors or the hidden pointer passed as
		'' the 1st argument
		select case n->dtype
		case FB_DATATYPE_STRING, _
			 FB_DATATYPE_USERDEF, _
			 FB_DATATYPE_WCHAR
			vreg = irAllocVRPTR( n->dtype, 0, vreg )
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
    dim as ASTTEMPSTR ptr n = any, p = any

	'' copy-back any fix-len string passed as parameter and
	'' delete all temp strings used as parameters
	n = f->call.strtail
	do while( n <> NULL )

		'' copy back if needed
		if( n->srctree <> NULL ) then
			t = rtlStrAssign( n->srctree, _
							  astNewVAR( n->tmpsym, 0, FB_DATATYPE_STRING ) )
			astLoad( t )
			astDelNode( t )
		end if

		'' delete the temp string (or wstring)
		t = rtlStrDelete( astNewVAR( n->tmpsym, 0, symbGetType( n->tmpsym ) ) )
		astLoad( t )
		astDelNode( t )

		p = n->prev
		listDelNode( @ast.tempstr, n )
		n = p
	loop

end sub

'':::::
private sub hFreeTempArrayDescs _
	( _
		byval f as ASTNODE ptr _
	)

    dim as ASTNODE ptr t = any
    dim as ASTTEMPARRAY ptr n = any, p = any

	n = f->call.arraytail
	do while( n <> NULL )

		t = rtlArrayFreeTempDesc( n->pdesc )
		if( t <> NULL ) then
			astLoad( t )
			astDelNode( t )
		end if

		p = n->prev
		listDelNode( @ast.temparray, n )
		n = p
	loop

end sub

'':::::
private sub hCheckTempStruct _
	( _
		byval n as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr _
	) static

	dim as IRVREG ptr vr
	dim as FBSYMBOL a

	if( ast.doemit = FALSE ) then
		exit sub
	end if

	'' follow GCC 3.x's ABI
	if( sym->typ = FB_DATATYPE_USERDEF ) then
		if( sym->proc.realtype = FB_DATATYPE_POINTER + FB_DATATYPE_USERDEF ) then
        	'' pass the address of the temp struct
        	vr = astLoad( astNewVar( n->call.res, _
        							 0, _
        							 FB_DATATYPE_USERDEF, _
        							 sym->subtype ) )

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

    dim as ASTNODE ptr arg = any, nextarg = any, l = any, pstart = any, pend = any
    dim as FBSYMBOL ptr sym = any, param = any, lastparam = any
    dim as integer mode = any, bytestopop = any, toalign = any
    dim as integer params = any, inc = any, args = any
    dim as IRVREG ptr vr = any, pcvr = any

	''
	sym = n->sym

    ''
	pstart = n->call.profbegin
	pend = n->call.profend

	'' ordinary pointer?
	if( sym = NULL ) then

		'' signal function start for profiling
		if( pstart <> NULL ) then
			pcvr = astLoad( pstart )
			astDelNode( pstart )
		end if

		vr = hCallProc( n, NULL, INVALID, 0, 0 )

		'' signal function end for profiling
		if( pend <> NULL ) then
			if( ast.doemit ) then
				irEmitPUSH( pcvr )
			end if
			sym = pend->sym
			hCallProc( pend, sym, sym->proc.mode, 0, 0 )
			astDelNode( pend )
		end if

		return vr
	end if

    ''
    mode = sym->proc.mode
	if( mode = FB_FUNCMODE_PASCAL ) then
		args = 0
		inc = 1
	else
		args = n->call.args
		inc = -1
	end if

	bytestopop = symbGetProcParamsLen( sym )
	toalign = 0

	''
	params = symbGetProcParams( sym )
	lastparam = symbGetProcTailParam( sym )

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
					  (bytestopop and (FB_INTEGERSIZE*4-1))) and (FB_INTEGERSIZE*4-1)
			if( toalign > 0 ) then
				if( ast.doemit ) then
					irEmitSTACKALIGN( toalign )
				end if
			end if
#endif
		end if
	'' vararg
	else
		param = lastparam
	end if

	'' for each argument..
	arg = n->r
	do while( arg <> NULL )
		nextarg = arg->r

		l = arg->l

		''
		if( param = lastparam ) then
			if( symbGetParamMode( param ) = FB_PARAMMODE_VARARG ) then
				bytestopop += FB_ROUNDLEN( symbCalcLen( l->dtype, NULL ) )
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

		arg = nextarg
	loop

	'' handle functions returning structs
	hCheckTempStruct( n, sym )

	'' signal function start for profiling
	if( pstart <> NULL ) then
		pcvr = astLoad( pstart )
		astDelNode( pstart )
	end if

	'' return proc's result
	vr = hCallProc( n, sym, mode, bytestopop, toalign )

	'' signal function end for profiling
	if( pend <> NULL ) then
		if( ast.doemit ) then
			irEmitPUSH( pcvr )
		end if
		sym = pend->sym
		hCallProc( pend, sym, sym->proc.mode, 0, 0 )
		astDelNode( pend )
	end if

	'' del temp strings and copy back if needed
	hCheckTmpStrings( n )

	'' del temp arrays descriptors created for array fields passed by desc
	hFreeTempArrayDescs( n )

    function = vr

end function

