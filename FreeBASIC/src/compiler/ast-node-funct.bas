''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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

'' AST function nodes
'' l = pointer node if any; r = first param to be pushed
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
function astNewFUNCT( byval sym as FBSYMBOL ptr, _
					  byval ptrexpr as ASTNODE ptr = NULL, _
					  byval isprofiler as integer = FALSE ) as ASTNODE ptr
    dim as ASTNODE ptr n
    dim as FBRTLCALLBACK callback
    dim as integer dtype
    dim as FBSYMBOL ptr subtype

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
	n = astNewNode( AST_NODECLASS_FUNCT, dtype, subtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->sym 			= sym
	n->l 			= ptrexpr
	n->proc.params 	= 0

	if( sym <> NULL ) then
		n->proc.arg	= symbGetProcHeadArg( sym )
		n->proc.isrtl = symbGetIsRTL( sym )

		callback = symbGetProcCallback( sym )
		if( callback <> NULL ) then
			callback( sym )
		end if
	else
		n->proc.arg	= NULL
		n->proc.isrtl = FALSE
	end if

	n->proc.arraytail = NULL
	n->proc.strtail = NULL

	'' function profiling
	n->proc.profbegin = NULL
	n->proc.profend   = NULL
	if( env.clopt.profile ) then
		if( isprofiler = FALSE ) then
			n->proc.profbegin = rtlProfileBeginCall( sym )
			if( n->proc.profbegin <> NULL ) then
				n->proc.profend   = rtlProfileEndCall( )
			end if
		end if
	end if

end function



'':::::
private function hCallProc( byval n as ASTNODE ptr, _
					   		byval proc as FBSYMBOL ptr, _
					   		byval mode as integer, _
					   		byval bytestopop as integer, _
					   		byval bytesaligned as integer ) as IRVREG ptr static
    dim as IRVREG ptr vreg, vr
    dim as ASTNODE ptr p
    dim as integer dtype

	'' ordinary pointer?
	if( proc = NULL ) then
		p = n->l
		vr = astLoad( p )
		astDel( p )
		if( ast.doemit ) then
			irEmitCALLPTR( vr, NULL, 0 )
		end if

		return NULL
	end if

	dtype = n->dtype

	'' function returns as string? it's actually a pointer to a string descriptor..
	'' same with UDT's..
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

	'' call function or ptr
	p = n->l
	if( p = NULL ) then
		if( ast.doemit ) then
			irEmitCALLFUNCT( proc, bytestopop, vreg )
		end if
	else
		vr = astLoad( p )
		astDel( p )
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
		'' handle strings and UDT's returned by functions that are actually pointers to
		'' string descriptors or the hidden pointer passed as the 1st argument
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
private sub hCheckTmpStrings( byval f as ASTNODE ptr )
    dim as ASTNODE ptr t
    dim as ASTTEMPSTR ptr n, p
    dim as FBSYMBOL ptr s

	'' copy-back any fix-len string passed as parameter and
	'' delete all temp strings used as parameters
	n = f->proc.strtail
	do while( n <> NULL )

		'' copy back if needed
		if( n->srctree <> NULL ) then
			t = rtlStrAssign( n->srctree, astNewVAR( n->tmpsym, 0, FB_DATATYPE_STRING ) )
			astLoad( t )
			astDel( t )
		end if

		'' delete the temp string (or wstring)
		t = rtlStrDelete( astNewVAR( n->tmpsym, 0, symbGetType( n->tmpsym ) ) )
		astLoad( t )
		astDel( t )

		p = n->prev
		listDelNode( @ast.tempstr, cptr( TLISTNODE ptr, n ) )
		n = p
	loop

end sub

'':::::
private sub hFreeTempArrayDescs( byval f as ASTNODE ptr )
    dim as ASTNODE ptr t
    dim as ASTTEMPARRAY ptr n, p

	n = f->proc.arraytail
	do while( n <> NULL )

		t = rtlArrayFreeTempDesc( n->pdesc )
		if( t <> NULL ) then
			astLoad( t )
			astDel( t )
		end if

		p = n->prev
		listDelNode( @ast.temparray, cptr( TLISTNODE ptr, n ) )
		n = p
	loop

end sub

'':::::
private sub hAllocTempStruct( byval n as ASTNODE ptr, _
							  byval proc as FBSYMBOL ptr ) static
	dim as FBSYMBOL ptr v
	dim as ASTNODE ptr p
	dim as IRVREG ptr vr
	dim as FBSYMBOL a

	'' follow GCC 3.x's ABI
	if( proc->typ = FB_DATATYPE_USERDEF ) then
		if( proc->proc.realtype = FB_DATATYPE_POINTER + FB_DATATYPE_USERDEF ) then
			'' create a temp struct and pass its address
			v = symbAddTempVar( FB_DATATYPE_USERDEF, proc->subtype, TRUE )
        	p = astNewVar( v, 0, FB_DATATYPE_USERDEF, proc->subtype )
        	vr = astLoad( p )

        	a.typ = FB_DATATYPE_VOID
        	a.arg.mode = FB_ARGMODE_BYREF
        	if( ast.doemit ) then
        		irEmitPUSHPARAM( proc, @a, vr, INVALID, FB_POINTERSIZE )
        	end if
		end if
	end if

end sub

'':::::
function astLoadFUNCT( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr p, np, l, pstart, pend
    dim as FBSYMBOL ptr proc, arg, lastarg
    dim as integer mode, bytestopop, toalign
    dim as integer params, inc
    dim as integer args
    dim as IRVREG ptr vr, pcvr

	''
	proc = n->sym

    ''
	pstart = n->proc.profbegin
	pend   = n->proc.profend

	'' ordinary pointer?
	if( proc = NULL ) then

		'' signal function start for profiling
		if( pstart <> NULL ) then
			pcvr = astLoad( pstart )
			astDel( pstart )
		end if

		vr = hCallProc( n, NULL, INVALID, 0, 0 )

		'' signal function end for profiling
		if( pend <> NULL ) then
			if( ast.doemit ) then
				irEmitPUSH( pcvr )
			end if
			proc = pend->sym
			hCallProc( pend, proc, proc->proc.mode, 0, 0 )
			astDel( pend )
		end if

		return vr
	end if

    ''
    mode = proc->proc.mode
	if( mode = FB_FUNCMODE_PASCAL ) then
		params = 0
		inc = 1
	else
		params = n->proc.params
		inc = -1
	end if

	bytestopop = symbGetLen( proc )
	toalign = 0

	''
	args 	= symbGetProcArgs( proc )
	lastarg = symbGetProcTailArg( proc )
	if( params <= args ) then
		arg = symbGetProcFirstArg( proc )
		'' vararg and param not passed?
		if( params < args ) then
			if( mode <> FB_FUNCMODE_PASCAL ) then
				arg = symbGetProcNextArg( proc, arg )
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
		arg = lastarg
	end if

	'' for each param..
	p = n->r
	do while( p <> NULL )
		np = p->r

		l = p->l

		''
		if( arg = lastarg ) then
			if( symbGetArgMode( arg ) = FB_ARGMODE_VARARG ) then
				bytestopop += (symbCalcLen( l->dtype, NULL ) + _
					 		  (FB_INTEGERSIZE-1)) and _
					 		  not (FB_INTEGERSIZE-1) 		'' x86 assumption!
			end if
		end if

		'' flush the param expression
		vr = astLoad( l )
		astDel( l )

		if( ast.doemit ) then
			if( irEmitPUSHPARAM( proc, arg, vr, p->param.mode, p->param.lgt ) = FALSE ) then
				'''''return NULL
			end if
		end if

		astDel( p )

		params += inc

		if( params < args ) then
			arg = symbGetProcNextArg( proc, arg )
		end if

		p = np
	loop

	'' handle functions returning structs
	hAllocTempStruct( n, proc )

	'' signal function start for profiling
	if( pstart <> NULL ) then
		pcvr = astLoad( pstart )
		astDel( pstart )
	end if

	'' return the result (same type as function ones)
	vr = hCallProc( n, proc, mode, bytestopop, toalign )

	'' signal function end for profiling
	if( pend <> NULL ) then
		if( ast.doemit ) then
			irEmitPUSH( pcvr )
		end if
		proc = pend->sym
		hCallProc( pend, proc, proc->proc.mode, 0, 0 )
		astDel( pend )
	end if

	'' del temp strings and copy back if needed
	hCheckTmpStrings( n )

	'' del temp arrays descriptors created for array fields passed by desc
	hFreeTempArrayDescs( n )

    function = vr

end function

