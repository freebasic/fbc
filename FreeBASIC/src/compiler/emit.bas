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


'' emit abstract interface
''
'' chng: jun/2005 written [v1ctor]
''

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\reg.bi"
#include once "inc\ir.bi"
#include once "inc\rtl.bi"
#include once "inc\emit.bi"
#include once "inc\emitdbg.bi"
#include once "inc\symb.bi"

declare sub 	 emitSubInit			( )
declare sub 	 emitSubEnd				( )

declare sub 	 emitWriteHeader		( )
declare sub 	 emitWriteFooter		( byval tottime as double )
declare sub 	 emitWriteBss			( byval s as FBSYMBOL ptr )
declare sub 	 emitWriteConst			( byval s as FBSYMBOL ptr )
declare sub 	 emitWriteData			( byval s as FBSYMBOL ptr )
declare sub 	 emitWriteExport		( )


'' globals
	dim shared emit as EMITCTX

'':::::
sub emitInit static

	if( emit.inited ) then
		exit sub
	end if

	''
	emitSubInit( )

	''
	flistNew( @emit.nodeTB, EMIT_INITNODES, len( EMIT_NODE ) )

	''
	flistNew( @emit.vregTB, EMIT_INITVREGNODES, len( IRVREG ) )

	''
	emit.inited 		= TRUE
	emit.pos			= 0

	''
	edbgInit( )

end sub

'':::::
sub emitEnd static

	if( emit.inited = FALSE ) then
		exit sub
	end if

	''
	edbgEnd( )

	''
	emitSubEnd( )

	''
	emit.inited = FALSE

end sub

'':::::
function emitOpen( ) as integer

	if( hFileExists( env.outf.name ) ) then
		kill env.outf.name
	end if

	env.outf.num = freefile
	if( open( env.outf.name, for binary, access read write, as #env.outf.num ) <> 0 ) then
		return FALSE
	end if

	'' header
	emitWriteHeader( )

	function = TRUE

end function

'':::::
sub emitClose( byval tottime as double )

    ''
    emitWriteFooter( tottime )

	'' const
	emitWriteConst( symbGetGlobalTbHead( ) )

	'' data
	emitWriteData( symbGetGlobalTbHead( ) )

	'' bss
	emitWriteBss( symbGetGlobalTbHead( ) )

	''
	if( env.clopt.export ) then
		emitWriteExport( )
	end if

	''
	edbgEmitFooter( )

	''
	if( close( #env.outf.num ) <> 0 ) then
		'' ...
	end if

end sub

'':::::
sub hWriteStr( byval addtab as integer, _
			   byval s as zstring ptr ) static
    dim as string ostr

	if( addtab ) then
		ostr = "\t"
		ostr += *s
	else
		ostr = *s
	end if

	ostr += NEWLINE

	if( put( #env.outf.num, , ostr ) <> 0 ) then
		'' ...
	end if

end sub

'':::::
sub emitReset( ) static
	dim as integer c, r

	flistReset( @emit.nodeTB )
	flistReset( @emit.vregTB )

	emit.curnode = NULL

	'' reset reg usage
	for c = 0 to EMIT_REGCLASSES-1
		EMIT_REGCLEARALL( c )
	next

end sub

'':::::
sub emitFlush( ) static
    dim as EMIT_NODE ptr n

	n = flistGetHead( @emit.nodeTB )
	do while( n <> NULL )

		emit.curnode = n

		select case as const n->class

		case EMIT_NODECLASS_BOP
			cast( EMIT_BOPCB, emit_opfTB(n->bop.op) )( n->bop.dvreg, _
													   n->bop.svreg )

		case EMIT_NODECLASS_UOP
			cast( EMIT_UOPCB, emit_opfTB(n->uop.op ) )( n->uop.dvreg )

		case EMIT_NODECLASS_REL
			cast( EMIT_RELCB, emit_opfTB(n->rel.op) )( n->rel.rvreg, _
													   n->rel.label, _
													   n->rel.dvreg, _
													   n->rel.svreg )

		case EMIT_NODECLASS_STK
			cast( EMIT_STKCB, emit_opfTB(n->stk.op) )( n->stk.vreg, _
													   n->stk.extra )

		case EMIT_NODECLASS_BRC
			cast( EMIT_BRCCB, emit_opfTB(n->brc.op) )( n->brc.vreg, _
													   n->brc.sym, _
													   n->brc.extra )

		case EMIT_NODECLASS_SOP
			cast( EMIT_SOPCB, emit_opfTB(n->sop.op) )( n->sop.sym )

		case EMIT_NODECLASS_LIT
			cast( EMIT_LITCB, emit_opfTB(EMIT_OP_LIT) )( n->lit.text )

			ZstrFree( n->lit.text )

		case EMIT_NODECLASS_JTB
			cast( EMIT_JTBCB, emit_opfTB(EMIT_OP_JMPTB) )( n->jtb.dtype, _
														   n->jtb.text )

			ZstrFree( n->jtb.text )

		case EMIT_NODECLASS_MEM
			cast( EMIT_MEMCB, emit_opfTB(n->mem.op) )( n->mem.dvreg, _
													   n->mem.svreg, _
													   n->mem.bytes, _
													   n->mem.extra )

		end select

		n = flistGetNext( n )
	loop

end sub

'':::::
function emitGetRegClass( byval dclass as integer ) as REGCLASS ptr

	function = emit.regTB(dclass)

end function

'':::::
function emitGetPos as integer static

	function = emit.pos

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' procs
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub emitProcBegin( byval proc as FBSYMBOL ptr ) static

    proc->proc.ext->stk.localofs = EMIT_LOCSTART
    proc->proc.ext->stk.localmax = EMIT_LOCSTART
	proc->proc.ext->stk.argofs = EMIT_ARGSTART

end sub

'':::::
sub emitProcEnd( byval proc as FBSYMBOL ptr ) static

	'' do nothing

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' node creation
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private function hNewVR( byval v as IRVREG ptr ) as IRVREG ptr
    dim as IRVREG ptr n
    dim as integer dclass

	if( v = NULL ) then
		return NULL
	end if

	n = flistNewItem( @emit.vregTB )

	n->typ   = v->typ
	n->dtype = v->dtype
	n->sym	 = v->sym
	n->ofs	 = v->ofs
	n->mult  = v->mult
	n->value = v->value

	if( v->typ = IR_VREGTYPE_REG ) then
		dclass = symbGetDataClass( v->dtype )
		n->reg = emit.regTB(dclass)->getRealReg( emit.regTB(dclass), v->reg )
		assert( n->reg <> INVALID )
		EMIT_REGSETUSED( dclass, n->reg )
	end if

	'' recursive
	n->vaux  = hNewVR( v->vaux )
	n->vidx  = hNewVR( v->vidx )

	function = n

end function

'':::::
private function hNewNode( byval class as EMIT_NODECLASS_ENUM, _
						   byval updatepos as integer = TRUE ) as EMIT_NODE ptr static
	dim as EMIT_NODE ptr n
	dim as integer i

	n = flistNewItem( @emit.nodeTB )

	n->class 	= class

	'' save register's state
	for i = 0 to EMIT_REGCLASSES-1
		n->regFreeTB(i) = emit.regTB(i)->freeTB
	next

	if( updatepos ) then
		emit.pos += 1
	end if

	function = n

end function

'':::::
private function hNewBOP( byval op as integer, _
					 	  byval dvreg as IRVREG ptr, _
			 		 	  byval svreg as IRVREG ptr ) as EMIT_NODE ptr static

	dim as EMIT_NODE ptr n

	n = hNewNode( EMIT_NODECLASS_BOP )

	n->bop.op	 = op
	n->bop.dvreg = hNewVR( dvreg )
	n->bop.svreg = hNewVR( svreg )

	function = n

end function

'':::::
private function hNewUOP( byval op as integer, _
					 	  byval dvreg as IRVREG ptr ) as EMIT_NODE ptr static

	dim as EMIT_NODE ptr n

	n = hNewNode( EMIT_NODECLASS_UOP )

	n->uop.op	 = op
	n->uop.dvreg = hNewVR( dvreg )

	function = n

end function

'':::::
private function hNewREL( byval op as integer, _
					 	  byval rvreg as IRVREG ptr, _
					 	  byval label as FBSYMBOL ptr, _
					 	  byval dvreg as IRVREG ptr, _
			 		 	  byval svreg as IRVREG ptr ) as EMIT_NODE ptr static

	dim as EMIT_NODE ptr n

	n = hNewNode( EMIT_NODECLASS_REL )

	n->rel.op	 = op
	n->rel.rvreg = hNewVR( rvreg )
	n->rel.label = label
	n->rel.dvreg = hNewVR( dvreg )
	n->rel.svreg = hNewVR( svreg )

	function = n

end function

'':::::
private function hNewSTK( byval op as integer, _
					 	  byval vreg as IRVREG ptr, _
					 	  byval extra as integer = 0 ) as EMIT_NODE ptr static

	dim as EMIT_NODE ptr n

	n = hNewNode( EMIT_NODECLASS_STK )

	n->stk.op	 = op
	n->stk.vreg  = hNewVR( vreg )
	n->stk.extra = extra

	function = n

end function

'':::::
private function hNewBRANCH( byval op as integer, _
					 	  	 byval vreg as IRVREG ptr, _
					 	  	 byval sym as FBSYMBOL ptr, _
					 	  	 byval extra as integer = 0 ) as EMIT_NODE ptr static

	dim as EMIT_NODE ptr n

	n = hNewNode( EMIT_NODECLASS_BRC )

	n->brc.op	 = op
	n->brc.sym	 = sym
	n->brc.vreg  = hNewVR( vreg )
	n->brc.extra = extra

	function = n

end function

'':::::
private function hNewSYMOP( byval op as integer, _
					 	    byval sym as FBSYMBOL ptr ) as EMIT_NODE ptr static

	dim as EMIT_NODE ptr n

	n = hNewNode( EMIT_NODECLASS_SOP, FALSE )

	n->sop.op	= op
	n->sop.sym	= sym

	function = n

end function

'':::::
private function hNewLIT( byval text as zstring ptr, _
						  byval doupdate as integer ) as EMIT_NODE ptr static

	dim as EMIT_NODE ptr n

	n = hNewNode( EMIT_NODECLASS_LIT, doupdate )

	n->lit.text   = ZstrAllocate( len( *text ) )
	*n->lit.text  = *text

	function = n

end function

'':::::
private function hNewJMPTB( byval dtype as integer, _
							byval text as zstring ptr ) as EMIT_NODE ptr static

	dim as EMIT_NODE ptr n

	n = hNewNode( EMIT_NODECLASS_JTB, FALSE )

	n->jtb.dtype = dtype
	n->jtb.text = ZstrAllocate( len( *text ) )
	*n->jtb.text = *text

	function = n

end function

'':::::
private function hNewMEM( byval op as integer, _
					 	  byval dvreg as IRVREG ptr, _
			 		 	  byval svreg as IRVREG ptr, _
			 		 	  byval bytes as integer, _
			 		 	  byval extra as integer = 0 ) as EMIT_NODE ptr static

	dim as EMIT_NODE ptr n

	n = hNewNode( EMIT_NODECLASS_MEM )

	n->mem.op	 = op
	n->mem.dvreg = hNewVR( dvreg )
	n->mem.svreg = hNewVR( svreg )
	n->mem.bytes = bytes
	n->mem.extra = extra

	function = n

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' load & store
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function emitLOAD( byval dvreg as IRVREG ptr, _
			  	   byval svreg as IRVREG ptr ) as EMIT_NODE ptr static

	select case as const dvreg->dtype
	'' longint?
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT

		select case as const svreg->dtype
		'' longint?
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			function = hNewBOP( EMIT_OP_LOADL2L, dvreg, svreg )

		'' float?
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			function = hNewBOP( EMIT_OP_LOADF2L, dvreg, svreg )

		case else
			function = hNewBOP( EMIT_OP_LOADI2L, dvreg, svreg )
		end select

	'' float?
	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE

		select case as const svreg->dtype
		'' longint?
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			function = hNewBOP( EMIT_OP_LOADL2F, dvreg, svreg )

		'' float?
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			function = hNewBOP( EMIT_OP_LOADF2F, dvreg, svreg )

		case else
			function = hNewBOP( EMIT_OP_LOADI2F, dvreg, svreg )
		end select

	case else

		select case as const svreg->dtype
		'' longint?
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			function = hNewBOP( EMIT_OP_LOADL2I, dvreg, svreg )

		'' float?
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			function = hNewBOP( EMIT_OP_LOADF2I, dvreg, svreg )

		case else
			function = hNewBOP( EMIT_OP_LOADI2I, dvreg, svreg )
		end select

	end select

end function

'':::::
function emitSTORE( byval dvreg as IRVREG ptr, _
			   		byval svreg as IRVREG ptr ) as EMIT_NODE ptr static

	select case as const dvreg->dtype
	'' longint?
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT

		select case as const svreg->dtype
		'' longint?
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			function = hNewBOP( EMIT_OP_STORL2L, dvreg, svreg )

		'' float?
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			function = hNewBOP( EMIT_OP_STORF2L, dvreg, svreg )

		case else
			function = hNewBOP( EMIT_OP_STORI2L, dvreg, svreg )
		end select

	'' float?
	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE

		select case as const svreg->dtype
		'' longint?
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			function = hNewBOP( EMIT_OP_STORL2F, dvreg, svreg )

		'' float?
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			function = hNewBOP( EMIT_OP_STORF2F, dvreg, svreg )

		case else
			function = hNewBOP( EMIT_OP_STORI2F, dvreg, svreg )
		end select

	case else

		select case as const svreg->dtype
		'' longint?
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			function = hNewBOP( EMIT_OP_STORL2I, dvreg, svreg )

		'' float?
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			function = hNewBOP( EMIT_OP_STORF2I, dvreg, svreg )

		case else
			function = hNewBOP( EMIT_OP_STORI2I, dvreg, svreg )
		end select

	end select

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' BOP
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function emitMOV( byval dvreg as IRVREG ptr, _
			 	  byval svreg as IRVREG ptr ) as EMIT_NODE ptr static

	select case as const dvreg->dtype
	'' longint?
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		function = hNewBOP( EMIT_OP_MOVL, dvreg, svreg )

	'' float?
	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		function = hNewBOP( EMIT_OP_MOVF, dvreg, svreg )

	case else
		function = hNewBOP( EMIT_OP_MOVI, dvreg, svreg )
	end select

end function

'':::::
function emitADD( byval dvreg as IRVREG ptr, _
			 	  byval svreg as IRVREG ptr ) as EMIT_NODE ptr static

	select case as const dvreg->dtype
	'' longint?
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		function = hNewBOP( EMIT_OP_ADDL, dvreg, svreg )

	'' float?
	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		function = hNewBOP( EMIT_OP_ADDF, dvreg, svreg )

	case else
		function = hNewBOP( EMIT_OP_ADDI, dvreg, svreg )
	end select

end function

'':::::
function emitSUB( byval dvreg as IRVREG ptr, _
			 	  byval svreg as IRVREG ptr ) as EMIT_NODE ptr static

	select case as const dvreg->dtype
	'' longint?
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		function = hNewBOP( EMIT_OP_SUBL, dvreg, svreg )

	'' float?
	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		function = hNewBOP( EMIT_OP_SUBF, dvreg, svreg )

	case else
		function = hNewBOP( EMIT_OP_SUBI, dvreg, svreg )
	end select

end function

'':::::
function emitMUL( byval dvreg as IRVREG ptr, _
			 	  byval svreg as IRVREG ptr ) as EMIT_NODE ptr static

	select case as const dvreg->dtype
	'' longint?
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		function = hNewBOP( EMIT_OP_MULL, dvreg, svreg )

	'' float?
	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		function = hNewBOP( EMIT_OP_MULF, dvreg, svreg )

	case else
		if( symbIsSigned( dvreg->dtype ) ) then
			function = hNewBOP( EMIT_OP_SMULI, dvreg, svreg )
		else
			function = hNewBOP( EMIT_OP_MULI, dvreg, svreg )
		end if
	end select

end function

'':::::
function emitDIV( byval dvreg as IRVREG ptr, _
			 	  byval svreg as IRVREG ptr ) as EMIT_NODE ptr static

	function = hNewBOP( EMIT_OP_DIVF, dvreg, svreg )

end function

'':::::
function emitINTDIV( byval dvreg as IRVREG ptr, _
			    	 byval svreg as IRVREG ptr ) as EMIT_NODE ptr static

	function = hNewBOP( EMIT_OP_DIVI, dvreg, svreg )

end function

'':::::
function emitMOD( byval dvreg as IRVREG ptr, _
			 	  byval svreg as IRVREG ptr ) as EMIT_NODE ptr static

	function = hNewBOP( EMIT_OP_MODI, dvreg, svreg )

end function

'':::::
function emitSHL( byval dvreg as IRVREG ptr, _
			 	  byval svreg as IRVREG ptr ) as EMIT_NODE ptr static

	select case dvreg->dtype
	'' longint?
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		function = hNewBOP( EMIT_OP_SHLL, dvreg, svreg )

	case else
		function = hNewBOP( EMIT_OP_SHLI, dvreg, svreg )
	end select

end function

'':::::
function emitSHR( byval dvreg as IRVREG ptr, _
			 	  byval svreg as IRVREG ptr ) as EMIT_NODE ptr static

	select case dvreg->dtype
	'' longint?
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		function = hNewBOP( EMIT_OP_SHRL, dvreg, svreg )

	case else
		function = hNewBOP( EMIT_OP_SHRI, dvreg, svreg )
	end select

end function

'':::::
function emitAND( byval dvreg as IRVREG ptr, _
			 	  byval svreg as IRVREG ptr ) as EMIT_NODE ptr static

	select case dvreg->dtype
	'' longint?
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		function = hNewBOP( EMIT_OP_ANDL, dvreg, svreg )

	case else
		function = hNewBOP( EMIT_OP_ANDI, dvreg, svreg )
	end select

end function

'':::::
function emitOR( byval dvreg as IRVREG ptr, _
			 	 byval svreg as IRVREG ptr ) as EMIT_NODE ptr static

	select case dvreg->dtype
	'' longint?
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		function = hNewBOP( EMIT_OP_ORL, dvreg, svreg )

	case else
		function = hNewBOP( EMIT_OP_ORI, dvreg, svreg )
	end select

end function

'':::::
function emitXOR( byval dvreg as IRVREG ptr, _
			 	  byval svreg as IRVREG ptr ) as EMIT_NODE ptr static

	select case dvreg->dtype
	'' longint?
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		function = hNewBOP( EMIT_OP_XORL, dvreg, svreg )

	case else
		function = hNewBOP( EMIT_OP_XORI, dvreg, svreg )
	end select

end function

'':::::
function emitEQV( byval dvreg as IRVREG ptr, _
			 	  byval svreg as IRVREG ptr ) as EMIT_NODE ptr static

	select case dvreg->dtype
	'' longint?
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		function = hNewBOP( EMIT_OP_EQVL, dvreg, svreg )

	case else
		function = hNewBOP( EMIT_OP_EQVI, dvreg, svreg )
	end select

end function

'':::::
function emitIMP( byval dvreg as IRVREG ptr, _
			 	  byval svreg as IRVREG ptr ) as EMIT_NODE ptr static

	select case dvreg->dtype
	'' longint?
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		function = hNewBOP( EMIT_OP_IMPL, dvreg, svreg )

	case else
		function = hNewBOP( EMIT_OP_IMPI, dvreg, svreg )
	end select

end function

'':::::
function emitATN2( byval dvreg as IRVREG ptr, _
			  	   byval svreg as IRVREG ptr ) as EMIT_NODE ptr static

	function = hNewBOP( EMIT_OP_ATN2, dvreg, svreg )

end function

'':::::
function emitPOW( byval dvreg as IRVREG ptr, _
			 	  byval svreg as IRVREG ptr ) as EMIT_NODE ptr static

	function = hNewBOP( EMIT_OP_POW, dvreg, svreg )

end function

'':::::
function emitADDROF( byval dvreg as IRVREG ptr, _
			    	 byval svreg as IRVREG ptr ) as EMIT_NODE ptr static

	function = hNewBOP( EMIT_OP_ADDROF, dvreg, svreg )

end function

'':::::
function emitDEREF( byval dvreg as IRVREG ptr, _
			   		byval svreg as IRVREG ptr ) as EMIT_NODE ptr static

	function = hNewBOP( EMIT_OP_DEREF, dvreg, svreg )

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' REL
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function emitGT( byval rvreg as IRVREG ptr, _
		    	 byval label as FBSYMBOL ptr, _
		    	 byval dvreg as IRVREG ptr, _
		    	 byval svreg as IRVREG ptr ) as EMIT_NODE ptr static

	select case as const dvreg->dtype
	'' longint?
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		function = hNewREL( EMIT_OP_CGTL, rvreg, label, dvreg, svreg )

	'' float?
	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		function = hNewREL( EMIT_OP_CGTF, rvreg, label, dvreg, svreg )

	case else
		function = hNewREL( EMIT_OP_CGTI, rvreg, label, dvreg, svreg )
	end select

end function

'':::::
function emitLT( byval rvreg as IRVREG ptr, _
		    	 byval label as FBSYMBOL ptr, _
		    	 byval dvreg as IRVREG ptr, _
		    	 byval svreg as IRVREG ptr ) as EMIT_NODE ptr static

	select case as const dvreg->dtype
	'' longint?
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		function = hNewREL( EMIT_OP_CLTL, rvreg, label, dvreg, svreg )

	'' float?
	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		function = hNewREL( EMIT_OP_CLTF, rvreg, label, dvreg, svreg )

	case else
		function = hNewREL( EMIT_OP_CLTI, rvreg, label, dvreg, svreg )
	end select

end function

'':::::
function emitEQ( byval rvreg as IRVREG ptr, _
		    	 byval label as FBSYMBOL ptr, _
		    	 byval dvreg as IRVREG ptr, _
		    	 byval svreg as IRVREG ptr ) as EMIT_NODE ptr static

	select case as const dvreg->dtype
	'' longint?
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		function = hNewREL( EMIT_OP_CEQL, rvreg, label, dvreg, svreg )

	'' float?
	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		function = hNewREL( EMIT_OP_CEQF, rvreg, label, dvreg, svreg )

	case else
		function = hNewREL( EMIT_OP_CEQI, rvreg, label, dvreg, svreg )
	end select

end function

'':::::
function emitNE( byval rvreg as IRVREG ptr, _
		    	 byval label as FBSYMBOL ptr, _
		    	 byval dvreg as IRVREG ptr, _
		    	 byval svreg as IRVREG ptr ) as EMIT_NODE ptr static

	select case as const dvreg->dtype
	'' longint?
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		function = hNewREL( EMIT_OP_CNEL, rvreg, label, dvreg, svreg )

	'' float?
	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		function = hNewREL( EMIT_OP_CNEF, rvreg, label, dvreg, svreg )

	case else
		function = hNewREL( EMIT_OP_CNEI, rvreg, label, dvreg, svreg )
	end select

end function

'':::::
function emitGE( byval rvreg as IRVREG ptr, _
		    	 byval label as FBSYMBOL ptr, _
		    	 byval dvreg as IRVREG ptr, _
		    	 byval svreg as IRVREG ptr ) as EMIT_NODE ptr static

	select case as const dvreg->dtype
	'' longint?
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		function = hNewREL( EMIT_OP_CGEL, rvreg, label, dvreg, svreg )

	'' float?
	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		function = hNewREL( EMIT_OP_CGEF, rvreg, label, dvreg, svreg )

	case else
		function = hNewREL( EMIT_OP_CGEI, rvreg, label, dvreg, svreg )
	end select

end function

'':::::
function emitLE( byval rvreg as IRVREG ptr, _
		    	 byval label as FBSYMBOL ptr, _
		    	 byval dvreg as IRVREG ptr, _
		    	 byval svreg as IRVREG ptr ) as EMIT_NODE ptr static

	select case as const dvreg->dtype
	'' longint?
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		function = hNewREL( EMIT_OP_CLEL, rvreg, label, dvreg, svreg )

	'' float?
	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		function = hNewREL( EMIT_OP_CLEF, rvreg, label, dvreg, svreg )

	case else
		function = hNewREL( EMIT_OP_CLEI, rvreg, label, dvreg, svreg )
	end select

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' UOP
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function emitNEG( byval dvreg as IRVREG ptr ) as EMIT_NODE ptr static

	select case as const dvreg->dtype
	'' longint?
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		function = hNewUOP( EMIT_OP_NEGL, dvreg )

	'' float?
	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		function = hNewUOP( EMIT_OP_NEGF, dvreg )

	case else
		function = hNewUOP( EMIT_OP_NEGI, dvreg )
	end select

end function

'':::::
function emitNOT( byval dvreg as IRVREG ptr ) as EMIT_NODE ptr static

	select case dvreg->dtype
	'' longint?
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		function = hNewUOP( EMIT_OP_NOTL, dvreg )

	case else
		function = hNewUOP( EMIT_OP_NOTI, dvreg )
	end select

end function

'':::::
function emitABS( byval dvreg as IRVREG ptr ) as EMIT_NODE ptr static

	select case as const dvreg->dtype
	'' longint?
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		function = hNewUOP( EMIT_OP_ABSL, dvreg )

	'' float?
	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		function = hNewUOP( EMIT_OP_ABSF, dvreg )

	case else
		function = hNewUOP( EMIT_OP_ABSI, dvreg )
	end select

end function

'':::::
function emitSGN( byval dvreg as IRVREG ptr ) as EMIT_NODE ptr static

	select case as const dvreg->dtype
	'' longint?
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		function = hNewUOP( EMIT_OP_SGNL, dvreg )

	'' float?
	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		function = hNewUOP( EMIT_OP_SGNF, dvreg )

	case else
		function = hNewUOP( EMIT_OP_SGNI, dvreg )
	end select

end function

'':::::
function emitSIN( byval dvreg as IRVREG ptr ) as EMIT_NODE ptr static

	function = hNewUOP( EMIT_OP_SIN, dvreg )

end function

'':::::
function emitASIN( byval dvreg as IRVREG ptr ) as EMIT_NODE ptr static

	function = hNewUOP( EMIT_OP_ASIN, dvreg )

end function

'':::::
function emitCOS( byval dvreg as IRVREG ptr ) as EMIT_NODE ptr static

	function = hNewUOP( EMIT_OP_COS, dvreg )

end function

'':::::
function emitACOS( byval dvreg as IRVREG ptr ) as EMIT_NODE ptr static

	function = hNewUOP( EMIT_OP_ACOS, dvreg )

end function

'':::::
function emitTAN( byval dvreg as IRVREG ptr ) as EMIT_NODE ptr static

	function = hNewUOP( EMIT_OP_TAN, dvreg )

end function

'':::::
function emitATAN( byval dvreg as IRVREG ptr ) as EMIT_NODE ptr static

	function = hNewUOP( EMIT_OP_ATAN, dvreg )

end function

'':::::
function emitSQRT( byval dvreg as IRVREG ptr ) as EMIT_NODE ptr static

	function = hNewUOP( EMIT_OP_SQRT, dvreg )

end function

'':::::
function emitLOG( byval dvreg as IRVREG ptr ) as EMIT_NODE ptr static

	function = hNewUOP( EMIT_OP_LOG, dvreg )

end function

'':::::
function emitFLOOR( byval dvreg as IRVREG ptr ) as EMIT_NODE ptr static

	function = hNewUOP( EMIT_OP_FLOOR, dvreg )

end function

'':::::
function emitXchgTOS( byval svreg as IRVREG ptr ) as EMIT_NODE ptr static

	function = hNewUOP( EMIT_OP_XCHGTOS, svreg )

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' STK
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function emitPUSH( byval svreg as IRVREG ptr ) as EMIT_NODE ptr static

	select case as const svreg->dtype
	'' longint?
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		function = hNewSTK( EMIT_OP_PUSHL, svreg )

	'' float?
	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		function = hNewSTK( EMIT_OP_PUSHF, svreg )

	case else
		function = hNewSTK( EMIT_OP_PUSHI, svreg )
	end select

end function

'':::::
function emitPOP( byval dvreg as IRVREG ptr ) as EMIT_NODE ptr static

	select case as const dvreg->dtype
	'' longint?
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		function = hNewSTK( EMIT_OP_POPL, dvreg )

	'' float?
	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		function = hNewSTK( EMIT_OP_POPF, dvreg )

	case else
		function = hNewSTK( EMIT_OP_POPI, dvreg )
	end select

end function

'':::::
function emitPUSHUDT( byval svreg as IRVREG ptr, _
				 byval sdsize as integer ) as EMIT_NODE ptr static

	function = hNewSTK( EMIT_OP_PUSHUDT, svreg, sdsize )

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' MISC
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function emitCOMMENT( byval text as zstring ptr ) as EMIT_NODE ptr static

	function = hNewLIT( "##" + *text, FALSE )

end function

'':::::
function emitASM( byval text as zstring ptr ) as EMIT_NODE ptr static
    dim as integer c

    function = hNewLIT( text, TRUE )

	'' reset reg usage
	for c = 0 to EMIT_REGCLASSES-1
		EMIT_REGTRASHALL( c )						'' can't check the reg usage
	next

end function

'':::::
function emitLIT( byval text as zstring ptr ) as EMIT_NODE ptr static

	function = hNewLIT( text, FALSE )

end function

'':::::
function emitALIGN( byval bytes as integer ) as EMIT_NODE ptr static
    static as IRVREG vr

	vr.typ   = IR_VREGTYPE_IMM
	vr.value = bytes
	function = hNewUOP( EMIT_OP_ALIGN, @vr )

end function

'':::::
function emitSTACKALIGN( byval bytes as integer ) as EMIT_NODE ptr static
    static as IRVREG vr

	vr.typ   = IR_VREGTYPE_IMM
	vr.value = bytes
	function = hNewUOP( EMIT_OP_STKALIGN, @vr )

end function

'':::::
function emitJMPTB( byval dtype as integer, _
			   		byval text as zstring ptr ) as EMIT_NODE ptr static

	function = hNewJMPTB( dtype, text )

end function

'':::::
function emitCALL( byval label as FBSYMBOL ptr, _
			  	   byval bytestopop as integer ) as EMIT_NODE ptr static

	function = hNewBRANCH( EMIT_OP_CALL, NULL, label, bytestopop )

end function

'':::::
function emitCALLPTR( byval svreg as IRVREG ptr, _
				 	  byval bytestopop as integer ) as EMIT_NODE ptr static

	function = hNewBRANCH( EMIT_OP_CALLPTR, svreg, NULL, bytestopop )

end function

'':::::
function emitBRANCH( byval op as integer, _
		 			 byval label as FBSYMBOL ptr ) as EMIT_NODE ptr static

	function = hNewBRANCH( EMIT_OP_BRANCH, NULL, label, op )

end function

'':::::
function emitJUMP( byval label as FBSYMBOL ptr ) as EMIT_NODE ptr static

	function = hNewBRANCH( EMIT_OP_JUMP, NULL, label )

end function

'':::::
function emitJUMPPTR( byval svreg as IRVREG ptr ) as EMIT_NODE ptr static

	function = hNewBRANCH( EMIT_OP_JUMPPTR, svreg, NULL )

end function

'':::::
function emitRET( byval bytestopop as integer ) as EMIT_NODE ptr static
    static as IRVREG vr

	vr.typ   = IR_VREGTYPE_IMM
	vr.value = bytestopop
	function = hNewUOP( EMIT_OP_RET, @vr )

end function

'':::::
function emitLABEL( byval label as FBSYMBOL ptr ) as EMIT_NODE ptr static

	function = hNewSYMOP( EMIT_OP_LABEL, label )

end function

'':::::
function emitPUBLIC( byval label as FBSYMBOL ptr ) as EMIT_NODE ptr static

	function = hNewSYMOP( EMIT_OP_PUBLIC, label )

end function


''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' MEM
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function emitMEMMOVE( byval dvreg as IRVREG ptr, _
			    	  byval svreg as IRVREG ptr, _
			     	  byval bytes as integer ) as EMIT_NODE ptr static

	function = hNewMEM( EMIT_OP_MEMMOVE, dvreg, svreg, bytes )

end function

'':::::
function emitMEMSWAP( byval dvreg as IRVREG ptr, _
			     	  byval svreg as IRVREG ptr, _
			     	  byval bytes as integer ) as EMIT_NODE ptr static

	function = hNewMEM( EMIT_OP_MEMSWAP, dvreg, svreg, bytes )

end function

'':::::
function emitMEMCLEAR( byval dvreg as IRVREG ptr, _
			      	   byval svreg as IRVREG ptr, _
			      	   byval bytes as integer ) as EMIT_NODE ptr static

	function = hNewMEM( EMIT_OP_MEMCLEAR, dvreg, svreg, bytes )

end function

'':::::
function emitSTKCLEAR( byval bytes as integer, _
				  	   byval baseofs as integer ) as EMIT_NODE ptr static

	function = hNewMEM( EMIT_OP_STKCLEAR, NULL, NULL, bytes, baseofs )

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' SCOPE
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function emitSCOPEHEADER( byval s as FBSYMBOl ptr ) as EMIT_NODE ptr static

	s->scp.emit.clrnode = emitSTKCLEAR( 0, s->scp.emit.baseofs )

	function = s->scp.emit.clrnode

end function

'':::::
function emitSCOPEFOOTER( byval s as FBSYMBOl ptr ) as EMIT_NODE ptr static

	s->scp.emit.clrnode->mem.bytes = s->scp.emit.bytes

	function = s->scp.emit.clrnode

end function

