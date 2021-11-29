'' emit abstract interface
''
'' chng: jun/2005 written [v1ctor]
'' chng: jun/2018 use FB_SIZETYPE_* for emitter calls [jeffm]

#include once "fb.bi"
#include once "fbint.bi"
#include once "reg.bi"
#include once "ir.bi"
#include once "rtl.bi"
#include once "emit.bi"
#include once "symb.bi"

/'
	From the point of view of emit.bas and EMIT_NODEOP,
	only x86 32 bit emitter is available.
	The one letter codes in the EMIT_OP_* enum names have
	the meaning:

		I = 32 bit or smaller
		L = 64 bit
'/

declare function emitGasX86_ctor _
	( _
	) as integer

'' globals
	dim shared emit as EMITCTX

function emitInit( ) as integer
	if( emit.inited ) then
		return TRUE
	end if

	emitGasX86_ctor( )

	flistInit( @emit.nodeTB, EMIT_INITNODES, len( EMIT_NODE ) )
	flistInit( @emit.vregTB, EMIT_INITVREGNODES, len( IRVREG ) )

	emit.inited = TRUE
	emit.pos = 0

	function = emit.vtbl.init( )
end function

sub emitEnd( )
	if( emit.inited = FALSE ) then
		exit sub
	end if

	emit.vtbl.end( )
	emit.inited = FALSE
end sub

'':::::
sub emitWriteStr _
	( _
		byval s as const zstring ptr, _
		byval addtab as integer _
	)

	static as string ostr

	if( addtab ) then
		ostr = TABCHAR
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
	dim as integer c

	flistReset( @emit.nodeTB )
	flistReset( @emit.vregTB )

	emit.curnode = NULL

	'' reset reg usage
	for c = 0 to EMIT_REGCLASSES-1
		EMIT_REGCLEARALL( c )
	next

end sub

'':::::
private function hOptSYMOP _
	( _
		byval p as EMIT_NODE ptr, _
		byval n as EMIT_NODE ptr _
	) as EMIT_NODE ptr

	select case n->sop.op
	case EMIT_OP_LABEL
		if( p <> NULL ) then
			'' convert "jxx foo \n foo:" to "foo:"
			if( p->class = EMIT_NODECLASS_BRC ) then
				select case p->brc.op
				case EMIT_OP_BRANCH, EMIT_OP_JUMP
					if( p->brc.sym = n->sop.sym ) then
						p->class = EMIT_NODECLASS_NOP
					end if
				end select
			end if
		end if

		'' don't count the label so "jmp foo \n bar: \n foo:" could be handled
		return p
	end select

	function = n

end function

'':::::
private sub hPeepHoleOpt( )
	dim as EMIT_NODE ptr n = any, p = any

	p = NULL
	n = flistGetHead( @emit.nodeTB )
	do while( n <> NULL )

		select case as const n->class
		case EMIT_NODECLASS_SOP
			p = hOptSYMOP( p, n )

		case EMIT_NODECLASS_DBG
			'' don't count debugging nodes, they won't gen any code

		case EMIT_NODECLASS_LIT
			'' don't count literal text, unless it's inline asm
			if( n->lit.isasm ) then
				p = n
			end if

		case else
			p = n
		end select

		n = flistGetNext( n )
	loop

end sub

'':::::
sub emitFlush( )
	dim as EMIT_NODE ptr n = any

	hPeepHoleOpt( )

	n = flistGetHead( @emit.nodeTB )
	do while( n <> NULL )

		emit.curnode = n

		select case as const n->class
		case EMIT_NODECLASS_NOP

		case EMIT_NODECLASS_BOP
			cast( EMIT_BOPCB, emit.opFnTb[n->bop.op] )( _
				n->bop.dvreg, _
				n->bop.svreg )

		case EMIT_NODECLASS_UOP
			cast( EMIT_UOPCB, emit.opFnTb[n->uop.op ] )( n->uop.dvreg )

		case EMIT_NODECLASS_REL
			cast( EMIT_RELCB, emit.opFnTb[n->rel.op] )( _
				n->rel.rvreg, _
				n->rel.label, _
				n->rel.dvreg, _
				n->rel.svreg )

		case EMIT_NODECLASS_STK
			cast( EMIT_STKCB, emit.opFnTb[n->stk.op] )( _
				n->stk.vreg, _
				n->stk.extra )

		case EMIT_NODECLASS_BRC
			cast( EMIT_BRCCB, emit.opFnTb[n->brc.op] )( _
				n->brc.vreg, _
				n->brc.sym, _
				n->brc.extra )

		case EMIT_NODECLASS_SOP
			cast( EMIT_SOPCB, emit.opFnTb[n->sop.op] )( n->sop.sym )

		case EMIT_NODECLASS_LIT
			cast( EMIT_LITCB, emit.opFnTb[EMIT_OP_LIT] )( n->lit.text )

			ZstrFree( n->lit.text )

		case EMIT_NODECLASS_JTB
			cast( EMIT_JTBCB, emit.opFnTb[EMIT_OP_JMPTB] )( n->jtb.tbsym, _
				n->jtb.values, n->jtb.labels, _
				n->jtb.labelcount, n->jtb.deflabel, _
				n->jtb.bias, n->jtb.span )

			deallocate( n->jtb.values )
			deallocate( n->jtb.labels )

		case EMIT_NODECLASS_MEM
			cast( EMIT_MEMCB, emit.opFnTb[n->mem.op] )( _
				n->mem.dvreg, _
				n->mem.svreg, _
				n->mem.bytes, _
				n->mem.extra )

		case EMIT_NODECLASS_DBG
			cast( EMIT_DBGCB, emit.opFnTb[n->dbg.op] )( _
				n->dbg.sym, _
				n->dbg.lnum, _
				n->dbg.pos, _
				n->dbg.filename )

		end select

		n = flistGetNext( n )
	loop

end sub

'':::::
function emitGetRegClass _
	( _
		byval dclass as integer _
	) as REGCLASS ptr

	function = emit.regTB(dclass)

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' node creation
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private function hNewVR _
	( _
		byval v as IRVREG ptr _
	) as IRVREG ptr

	dim as IRVREG ptr n = any
	dim as integer dclass = any

	if( v = NULL ) then
		return NULL
	end if

	n = flistNewItem( @emit.vregTB )

	n->typ = v->typ
	astGetFullType( n ) = v->dtype
	n->sym = v->sym
	n->ofs = v->ofs
	n->mult = v->mult
	n->value = v->value

	n->regFamily = v->regFamily
	n->vector = v->vector

	if( v->typ = IR_VREGTYPE_REG ) then
		dclass = typeGetClass( v->dtype )
		n->reg = emit.regTB(dclass)->getRealReg( emit.regTB(dclass), v->reg )
		assert( n->reg <> INVALID )
		EMIT_REGSETUSED( dclass, n->reg )
	end if

	'' recursive
	n->vaux = hNewVR( v->vaux )
	n->vidx = hNewVR( v->vidx )

	function = n

end function

'':::::
private function hNewNode _
	( _
		byval class_ as EMIT_NODECLASS_ENUM, _
		byval updatepos as integer = TRUE _
	) as EMIT_NODE ptr static

	dim as EMIT_NODE ptr n
	dim as integer i

	n = flistNewItem( @emit.nodeTB )

	n->class = class_

	'' save register's state
	for i = 0 to EMIT_REGCLASSES-1
		n->regFreeTB(i) = emit.regTB(i)->regctx.freeTB
	next

	if( updatepos ) then
		emit.pos += 1
	end if

	function = n

end function

'':::::
private function hNewBOP _
	( _
		byval op as integer, _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	dim as EMIT_NODE ptr n

	n = hNewNode( EMIT_NODECLASS_BOP )

	n->bop.op = op
	n->bop.dvreg = hNewVR( dvreg )
	n->bop.svreg = hNewVR( svreg )

	function = n

end function

'':::::
private function hNewUOP _
	( _
		byval op as integer, _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	dim as EMIT_NODE ptr n

	n = hNewNode( EMIT_NODECLASS_UOP )

	n->uop.op = op
	n->uop.dvreg = hNewVR( dvreg )

	function = n

end function

'':::::
private function hNewREL _
	( _
		byval op as integer, _
		byval rvreg as IRVREG ptr, _
		byval label as FBSYMBOL ptr, _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	dim as EMIT_NODE ptr n

	n = hNewNode( EMIT_NODECLASS_REL )

	n->rel.op = op
	n->rel.rvreg = hNewVR( rvreg )
	n->rel.label = label
	n->rel.dvreg = hNewVR( dvreg )
	n->rel.svreg = hNewVR( svreg )

	function = n

end function

'':::::
private function hNewSTK _
	( _
		byval op as integer, _
		byval vreg as IRVREG ptr, _
		byval extra as integer = 0 _
	) as EMIT_NODE ptr static

	dim as EMIT_NODE ptr n

	n = hNewNode( EMIT_NODECLASS_STK )

	n->stk.op = op
	n->stk.vreg = hNewVR( vreg )
	n->stk.extra = extra

	function = n

end function

'':::::
private function hNewBRANCH _
	( _
		byval op as integer, _
		byval vreg as IRVREG ptr, _
		byval sym as FBSYMBOL ptr, _
		byval extra as integer = 0 _
	) as EMIT_NODE ptr static

	dim as EMIT_NODE ptr n

	n = hNewNode( EMIT_NODECLASS_BRC )

	n->brc.op = op
	n->brc.sym = sym
	n->brc.vreg = hNewVR( vreg )
	n->brc.extra = extra

	function = n

end function

'':::::
private function hNewSYMOP _
	( _
		byval op as integer, _
		byval sym as FBSYMBOL ptr _
	) as EMIT_NODE ptr static

	dim as EMIT_NODE ptr n

	n = hNewNode( EMIT_NODECLASS_SOP, FALSE )

	n->sop.op = op
	n->sop.sym = sym

	function = n

end function

private sub hNewLIT( byval text as zstring ptr, byval isasm as integer )
	dim as EMIT_NODE ptr n = any

	n = hNewNode( EMIT_NODECLASS_LIT, isasm )

	n->lit.isasm = isasm
	n->lit.text = ZstrAllocate( len( *text ) )
	*n->lit.text = *text
end sub

'':::::
private function hNewMEM _
	( _
		byval op as integer, _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr, _
		byval bytes as integer, _
		byval extra as integer = 0 _
	) as EMIT_NODE ptr static

	dim as EMIT_NODE ptr n

	n = hNewNode( EMIT_NODECLASS_MEM )

	n->mem.op = op
	n->mem.dvreg = hNewVR( dvreg )
	n->mem.svreg = hNewVR( svreg )
	n->mem.bytes = bytes
	n->mem.extra = extra

	function = n

end function

'':::::
private function hNewDBG _
	( _
		byval op as integer, _
		byval sym as FBSYMBOL ptr, _
		byval lnum as integer = 0, _
		byval pos_ as integer = 0, _
		byval filename As zstring ptr = 0 _
	) as EMIT_NODE ptr static

	dim as EMIT_NODE ptr n

	n = hNewNode( EMIT_NODECLASS_DBG, FALSE )

	n->dbg.op = op
	n->dbg.sym = sym
	n->dbg.lnum = lnum
	n->dbg.filename = filename
	n->dbg.pos = pos_

	function = n

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' load & store
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function emitLOAD _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	select case as const typeGetSizeType( dvreg->dtype )
	'' longint?
	case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64

		select case as const typeGetSizeType( svreg->dtype )
		'' longint?
		case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64
			function = hNewBOP( EMIT_OP_LOADL2L, dvreg, svreg )

		'' float?
		case FB_SIZETYPE_FLOAT32, FB_SIZETYPE_FLOAT64
			function = hNewBOP( EMIT_OP_LOADF2L, dvreg, svreg )

		'' boolean?
		case FB_SIZETYPE_BOOLEAN
			function = hNewBOP( EMIT_OP_LOADB2L, dvreg, svreg )

		case else
			function = hNewBOP( EMIT_OP_LOADI2L, dvreg, svreg )
		end select

	'' float?
	case FB_SIZETYPE_FLOAT32, FB_SIZETYPE_FLOAT64

		select case as const typeGetSizeType( svreg->dtype )
		'' longint?
		case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64
			function = hNewBOP( EMIT_OP_LOADL2F, dvreg, svreg )

		'' float?
		case FB_SIZETYPE_FLOAT32, FB_SIZETYPE_FLOAT64
			function = hNewBOP( EMIT_OP_LOADF2F, dvreg, svreg )

		'' boolean?
		case FB_SIZETYPE_BOOLEAN
			function = hNewBOP( EMIT_OP_LOADB2F, dvreg, svreg )

		case else
			function = hNewBOP( EMIT_OP_LOADI2F, dvreg, svreg )
		end select

	'' boolean?
	case FB_SIZETYPE_BOOLEAN

		select case as const typeGetSizeType( svreg->dtype )
		'' longint?
		case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64
			function = hNewBOP( EMIT_OP_LOADL2B, dvreg, svreg )

		'' float?
		case FB_SIZETYPE_FLOAT32, FB_SIZETYPE_FLOAT64
			function = hNewBOP( EMIT_OP_LOADF2B, dvreg, svreg )

		'' boolean?
		case FB_SIZETYPE_BOOLEAN
			function = hNewBOP( EMIT_OP_LOADB2B, dvreg, svreg )

		case else
			function = hNewBOP( EMIT_OP_LOADI2B, dvreg, svreg )
		end select

	case else

		select case as const typeGetSizeType( svreg->dtype )
		'' longint?
		case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64
			function = hNewBOP( EMIT_OP_LOADL2I, dvreg, svreg )

		'' float?
		case FB_SIZETYPE_FLOAT32, FB_SIZETYPE_FLOAT64
			function = hNewBOP( EMIT_OP_LOADF2I, dvreg, svreg )

		'' boolean?
		case FB_SIZETYPE_BOOLEAN
			function = hNewBOP( EMIT_OP_LOADB2I, dvreg, svreg )

		case else
			function = hNewBOP( EMIT_OP_LOADI2I, dvreg, svreg )
		end select

	end select

end function

'':::::
function emitSTORE _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	select case as const typeGetSizeType( dvreg->dtype )
	'' longint?
	case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64

		select case as const typeGetSizeType( svreg->dtype )
		'' longint?
		case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64
			function = hNewBOP( EMIT_OP_STORL2L, dvreg, svreg )

		'' float?
		case FB_SIZETYPE_FLOAT32, FB_SIZETYPE_FLOAT64
			function = hNewBOP( EMIT_OP_STORF2L, dvreg, svreg )

		'' boolean?
		case FB_SIZETYPE_BOOLEAN
			function = hNewBOP( EMIT_OP_STORB2L, dvreg, svreg )

		case else
			function = hNewBOP( EMIT_OP_STORI2L, dvreg, svreg )
		end select

	'' float?
	case FB_SIZETYPE_FLOAT32, FB_SIZETYPE_FLOAT64

		select case as const typeGetSizeType( svreg->dtype )
		'' longint?
		case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64
			function = hNewBOP( EMIT_OP_STORL2F, dvreg, svreg )

		'' float?
		case FB_SIZETYPE_FLOAT32, FB_SIZETYPE_FLOAT64
			function = hNewBOP( EMIT_OP_STORF2F, dvreg, svreg )

		'' boolean?
		case FB_SIZETYPE_BOOLEAN
			function = hNewBOP( EMIT_OP_STORB2F, dvreg, svreg )

		case else
			function = hNewBOP( EMIT_OP_STORI2F, dvreg, svreg )
		end select

	'' boolean?
	case FB_SIZETYPE_BOOLEAN

		select case as const typeGetSizeType( svreg->dtype )
		'' longint?
		case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64
			function = hNewBOP( EMIT_OP_STORL2B, dvreg, svreg )

		'' float?
		case FB_SIZETYPE_FLOAT32, FB_SIZETYPE_FLOAT64
			function = hNewBOP( EMIT_OP_STORF2B, dvreg, svreg )

		'' boolean?
		case FB_SIZETYPE_BOOLEAN
			function = hNewBOP( EMIT_OP_STORB2B, dvreg, svreg )

		case else
			function = hNewBOP( EMIT_OP_STORI2B, dvreg, svreg )
		end select

	case else

		select case as const typeGetSizeType( svreg->dtype )
		'' longint?
		case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64
			function = hNewBOP( EMIT_OP_STORL2I, dvreg, svreg )

		'' float?
		case FB_SIZETYPE_FLOAT32, FB_SIZETYPE_FLOAT64
			function = hNewBOP( EMIT_OP_STORF2I, dvreg, svreg )

		'' boolean?
		case FB_SIZETYPE_BOOLEAN
			function = hNewBOP( EMIT_OP_STORB2I, dvreg, svreg )

		case else
			function = hNewBOP( EMIT_OP_STORI2I, dvreg, svreg )
		end select

	end select

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' BOP
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function emitMOV _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	select case as const typeGetSizeType( dvreg->dtype )
	'' longint?
	case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64
		function = hNewBOP( EMIT_OP_MOVL, dvreg, svreg )

	'' float?
	case FB_SIZETYPE_FLOAT32, FB_SIZETYPE_FLOAT64
		function = hNewBOP( EMIT_OP_MOVF, dvreg, svreg )

	case else
		function = hNewBOP( EMIT_OP_MOVI, dvreg, svreg )
	end select

end function

'':::::
function emitADD _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	select case as const typeGetSizeType( dvreg->dtype )
	'' longint?
	case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64
		function = hNewBOP( EMIT_OP_ADDL, dvreg, svreg )

	'' float?
	case FB_SIZETYPE_FLOAT32, FB_SIZETYPE_FLOAT64
		function = hNewBOP( EMIT_OP_ADDF, dvreg, svreg )

	case else
		function = hNewBOP( EMIT_OP_ADDI, dvreg, svreg )
	end select

end function

'':::::
function emitSUB _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	select case as const typeGetSizeType( dvreg->dtype )
	'' longint?
	case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64
		function = hNewBOP( EMIT_OP_SUBL, dvreg, svreg )

	'' float?
	case FB_SIZETYPE_FLOAT32, FB_SIZETYPE_FLOAT64
		function = hNewBOP( EMIT_OP_SUBF, dvreg, svreg )

	case else
		function = hNewBOP( EMIT_OP_SUBI, dvreg, svreg )
	end select

end function

'':::::
function emitMUL _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	select case as const typeGetSizeType( dvreg->dtype )
	'' longint?
	case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64
		function = hNewBOP( EMIT_OP_MULL, dvreg, svreg )

	'' float?
	case FB_SIZETYPE_FLOAT32, FB_SIZETYPE_FLOAT64
		function = hNewBOP( EMIT_OP_MULF, dvreg, svreg )

	case else
		function = hNewBOP( EMIT_OP_MULI, dvreg, svreg )
	end select

end function

'':::::
function emitDIV _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	function = hNewBOP( EMIT_OP_DIVF, dvreg, svreg )

end function

'':::::
function emitINTDIV _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	function = hNewBOP( EMIT_OP_DIVI, dvreg, svreg )

end function

'':::::
function emitMOD _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	function = hNewBOP( EMIT_OP_MODI, dvreg, svreg )

end function

'':::::
function emitSHL _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	select case typeGetSizeType( dvreg->dtype )
	'' longint?
	case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64
		function = hNewBOP( EMIT_OP_SHLL, dvreg, svreg )

	case else
		function = hNewBOP( EMIT_OP_SHLI, dvreg, svreg )
	end select

end function

'':::::
function emitSHR _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	select case typeGetSizeType( dvreg->dtype )
	'' longint?
	case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64
		function = hNewBOP( EMIT_OP_SHRL, dvreg, svreg )

	case else
		function = hNewBOP( EMIT_OP_SHRI, dvreg, svreg )
	end select

end function

'':::::
function emitAND _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	select case typeGetSizeType( dvreg->dtype )
	'' longint?
	case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64
		function = hNewBOP( EMIT_OP_ANDL, dvreg, svreg )

	case else
		function = hNewBOP( EMIT_OP_ANDI, dvreg, svreg )
	end select

end function

'':::::
function emitOR _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	select case typeGetSizeType( dvreg->dtype )
	'' longint?
	case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64
		function = hNewBOP( EMIT_OP_ORL, dvreg, svreg )

	case else
		function = hNewBOP( EMIT_OP_ORI, dvreg, svreg )
	end select

end function

'':::::
function emitXOR _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	select case typeGetSizeType( dvreg->dtype )
	'' longint?
	case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64
		function = hNewBOP( EMIT_OP_XORL, dvreg, svreg )

	case else
		function = hNewBOP( EMIT_OP_XORI, dvreg, svreg )
	end select

end function

'':::::
function emitEQV _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	select case typeGetSizeType( dvreg->dtype )
	'' longint?
	case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64
		function = hNewBOP( EMIT_OP_EQVL, dvreg, svreg )

	case else
		function = hNewBOP( EMIT_OP_EQVI, dvreg, svreg )
	end select

end function

'':::::
function emitIMP _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	select case typeGetSizeType( dvreg->dtype )
	'' longint?
	case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64
		function = hNewBOP( EMIT_OP_IMPL, dvreg, svreg )

	case else
		function = hNewBOP( EMIT_OP_IMPI, dvreg, svreg )
	end select

end function

'':::::
function emitATN2 _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	function = hNewBOP( EMIT_OP_ATN2, dvreg, svreg )

end function

'':::::
function emitPOW _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	function = hNewBOP( EMIT_OP_POW, dvreg, svreg )

end function

'':::::
function emitADDROF _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	function = hNewBOP( EMIT_OP_ADDROF, dvreg, svreg )

end function

'':::::
function emitDEREF _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	function = hNewBOP( EMIT_OP_DEREF, dvreg, svreg )

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' REL
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function emitGT _
	( _
		byval rvreg as IRVREG ptr, _
		byval label as FBSYMBOL ptr, _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	select case typeGetSizeType( dvreg->dtype )
	'' longint?
	case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64
		function = hNewREL( EMIT_OP_CGTL, rvreg, label, dvreg, svreg )

	'' float?
	case FB_SIZETYPE_FLOAT32, FB_SIZETYPE_FLOAT64
		function = hNewREL( EMIT_OP_CGTF, rvreg, label, dvreg, svreg )

	case else
		function = hNewREL( EMIT_OP_CGTI, rvreg, label, dvreg, svreg )
	end select

end function

'':::::
function emitLT _
	( _
		byval rvreg as IRVREG ptr, _
		byval label as FBSYMBOL ptr, _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	select case typeGetSizeType( dvreg->dtype )
	'' longint?
	case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64
		function = hNewREL( EMIT_OP_CLTL, rvreg, label, dvreg, svreg )

	'' float?
	case FB_SIZETYPE_FLOAT32, FB_SIZETYPE_FLOAT64
		function = hNewREL( EMIT_OP_CLTF, rvreg, label, dvreg, svreg )

	case else
		function = hNewREL( EMIT_OP_CLTI, rvreg, label, dvreg, svreg )
	end select

end function

'':::::
function emitEQ _
	( _
		byval rvreg as IRVREG ptr, _
		byval label as FBSYMBOL ptr, _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	select case typeGetSizeType( dvreg->dtype )
	'' longint?
	case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64
		function = hNewREL( EMIT_OP_CEQL, rvreg, label, dvreg, svreg )

	'' float?
	case FB_SIZETYPE_FLOAT32, FB_SIZETYPE_FLOAT64
		function = hNewREL( EMIT_OP_CEQF, rvreg, label, dvreg, svreg )

	case else
		function = hNewREL( EMIT_OP_CEQI, rvreg, label, dvreg, svreg )
	end select

end function

'':::::
function emitNE _
	( _
		byval rvreg as IRVREG ptr, _
		byval label as FBSYMBOL ptr, _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	select case typeGetSizeType( dvreg->dtype )
	'' longint?
	case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64
		function = hNewREL( EMIT_OP_CNEL, rvreg, label, dvreg, svreg )

	'' float?
	case FB_SIZETYPE_FLOAT32, FB_SIZETYPE_FLOAT64
		function = hNewREL( EMIT_OP_CNEF, rvreg, label, dvreg, svreg )

	case else
		function = hNewREL( EMIT_OP_CNEI, rvreg, label, dvreg, svreg )
	end select

end function

'':::::
function emitGE _
	( _
		byval rvreg as IRVREG ptr, _
		byval label as FBSYMBOL ptr, _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	select case typeGetSizeType( dvreg->dtype )
	'' longint?
	case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64
		function = hNewREL( EMIT_OP_CGEL, rvreg, label, dvreg, svreg )

	'' float?
	case FB_SIZETYPE_FLOAT32, FB_SIZETYPE_FLOAT64
		function = hNewREL( EMIT_OP_CGEF, rvreg, label, dvreg, svreg )

	case else
		function = hNewREL( EMIT_OP_CGEI, rvreg, label, dvreg, svreg )
	end select

end function

'':::::
function emitLE _
	( _
		byval rvreg as IRVREG ptr, _
		byval label as FBSYMBOL ptr, _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	select case typeGetSizeType( dvreg->dtype )
	'' longint?
	case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64
		function = hNewREL( EMIT_OP_CLEL, rvreg, label, dvreg, svreg )

	'' float?
	case FB_SIZETYPE_FLOAT32, FB_SIZETYPE_FLOAT64
		function = hNewREL( EMIT_OP_CLEF, rvreg, label, dvreg, svreg )

	case else
		function = hNewREL( EMIT_OP_CLEI, rvreg, label, dvreg, svreg )
	end select

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' UOP
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function emitNEG _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	select case typeGetSizeType( dvreg->dtype )
	'' longint?
	case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64
		function = hNewUOP( EMIT_OP_NEGL, dvreg )

	'' float?
	case FB_SIZETYPE_FLOAT32, FB_SIZETYPE_FLOAT64
		function = hNewUOP( EMIT_OP_NEGF, dvreg )

	case else
		function = hNewUOP( EMIT_OP_NEGI, dvreg )
	end select

end function

'':::::
function emitNOT _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	select case typeGetSizeType( dvreg->dtype )
	'' longint?
	case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64
		function = hNewUOP( EMIT_OP_NOTL, dvreg )

	case else
		function = hNewUOP( EMIT_OP_NOTI, dvreg )
	end select

end function

'':::::
function emitHADD _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	select case typeGetSizeType( dvreg->dtype )
	'' float?
	case FB_SIZETYPE_FLOAT32, FB_SIZETYPE_FLOAT64
		function = hNewUOP( EMIT_OP_HADDF, dvreg )

	case else
		'function = hNewUOP( EMIT_OP_HADDI, dvreg )
	end select

end function

'':::::
function emitABS _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	select case typeGetSizeType( dvreg->dtype )
	'' longint?
	case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64
		function = hNewUOP( EMIT_OP_ABSL, dvreg )

	'' float?
	case FB_SIZETYPE_FLOAT32, FB_SIZETYPE_FLOAT64
		function = hNewUOP( EMIT_OP_ABSF, dvreg )

	case else
		function = hNewUOP( EMIT_OP_ABSI, dvreg )
	end select

end function

'':::::
function emitSGN _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	select case typeGetSizeType( dvreg->dtype )
	'' longint?
	case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64
		function = hNewUOP( EMIT_OP_SGNL, dvreg )

	'' float?
	case FB_SIZETYPE_FLOAT32, FB_SIZETYPE_FLOAT64
		function = hNewUOP( EMIT_OP_SGNF, dvreg )

	case else
		function = hNewUOP( EMIT_OP_SGNI, dvreg )
	end select

end function

'':::::
function emitFIX _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	function = hNewUOP( EMIT_OP_FIX, dvreg )

end function

'':::::
function emitFRAC _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	function = hNewUOP( EMIT_OP_FRAC, dvreg )

end function

function emitCONVFD2FS( byval dvreg as IRVREG ptr ) as EMIT_NODE ptr
	function = hNewUOP( EMIT_OP_CONVFD2FS, dvreg )
end function

'':::::
function emitSIN _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	function = hNewUOP( EMIT_OP_SIN, dvreg )

end function

'':::::
function emitASIN _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	function = hNewUOP( EMIT_OP_ASIN, dvreg )

end function

'':::::
function emitCOS _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	function = hNewUOP( EMIT_OP_COS, dvreg )

end function

'':::::
function emitACOS _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	function = hNewUOP( EMIT_OP_ACOS, dvreg )

end function

'':::::
function emitTAN _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	function = hNewUOP( EMIT_OP_TAN, dvreg )

end function

'':::::
function emitATAN _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	function = hNewUOP( EMIT_OP_ATAN, dvreg )

end function

'':::::
function emitSQRT _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	function = hNewUOP( EMIT_OP_SQRT, dvreg )

end function

'':::::
function emitRSQRT _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	function = hNewUOP( EMIT_OP_RSQRT, dvreg )

end function

'':::::
function emitRCP _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	function = hNewUOP( EMIT_OP_RCP, dvreg )

end function

'':::::
function emitLOG _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	function = hNewUOP( EMIT_OP_LOG, dvreg )

end function

'':::::
function emitEXP _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	function = hNewUOP( EMIT_OP_EXP, dvreg )

end function

'':::::
function emitFLOOR _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	function = hNewUOP( EMIT_OP_FLOOR, dvreg )

end function

'':::::
function emitXchgTOS _
	( _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	function = hNewUOP( EMIT_OP_XCHGTOS, svreg )

end function

'':::::
function emitSWZREP _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	function = hNewUOP( EMIT_OP_SWZREP, dvreg )

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' STK
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

function emitSTACKALIGN( byval bytes as integer ) as EMIT_NODE ptr
	dim as IRVREG vr

	vr.typ = IR_VREGTYPE_IMM
	vr.value.i = bytes

	function = hNewSTK( EMIT_OP_STACKALIGN, @vr )
end function

'':::::
function emitPUSH _
	( _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	select case as const typeGetSizeType( svreg->dtype )
	'' longint?
	case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64
		function = hNewSTK( EMIT_OP_PUSHL, svreg )

	'' float?
	case FB_SIZETYPE_FLOAT32, FB_SIZETYPE_FLOAT64
		function = hNewSTK( EMIT_OP_PUSHF, svreg )

	case else
		function = hNewSTK( EMIT_OP_PUSHI, svreg )
	end select

end function

'':::::
function emitPOP _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	select case as const typeGetSizeType( dvreg->dtype )
	'' longint?
	case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64
		function = hNewSTK( EMIT_OP_POPL, dvreg )

	'' float?
	case FB_SIZETYPE_FLOAT32, FB_SIZETYPE_FLOAT64
		function = hNewSTK( EMIT_OP_POPF, dvreg )

	case else
		function = hNewSTK( EMIT_OP_POPI, dvreg )
	end select

end function

'':::::
function emitPUSHUDT _
	( _
		byval svreg as IRVREG ptr, _
		byval sdsize as integer _
	) as EMIT_NODE ptr static

	function = hNewSTK( EMIT_OP_PUSHUDT, svreg, sdsize )

end function

function emitPOPST0( ) as EMIT_NODE ptr
	function = hNewSTK( EMIT_OP_POPST0, NULL )
end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' MISC
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

sub emitCOMMENT( byval text as zstring ptr )
	hNewLIT( "##" + *text, FALSE )
end sub

sub emitASM( byval text as zstring ptr )
	hNewLIT( text, TRUE )

	'' reset reg usage
	for c as integer = 0 to EMIT_REGCLASSES-1
		EMIT_REGTRASHALL( c )                       '' can't check the reg usage
	next
end sub

function emitJMPTB _
	( _
		byval tbsym as FBSYMBOL ptr, _
		byval values1 as ulongint ptr, _
		byval labels1 as FBSYMBOL ptr ptr, _
		byval labelcount as integer, _
		byval deflabel as FBSYMBOL ptr, _
		byval bias as ulongint, _
		byval span as ulongint _
	) as EMIT_NODE ptr

	dim as EMIT_NODE ptr n = any
	dim as ulongint ptr values = any
	dim as FBSYMBOL ptr ptr labels = any

	assert( labelcount > 0 )

	'' Duplicate the values/labels arrays
	values = callocate( sizeof( *values ) * labelcount )
	labels = callocate( sizeof( *labels ) * labelcount )
	for i as integer = 0 to labelcount - 1
		values[i] = values1[i]
		labels[i] = labels1[i]
	next

	n = hNewNode( EMIT_NODECLASS_JTB, FALSE )

	n->jtb.tbsym = tbsym
	n->jtb.values = values
	n->jtb.labels = labels
	n->jtb.labelcount = labelcount
	n->jtb.deflabel = deflabel
	n->jtb.bias = bias
	n->jtb.span = span

	function = n
end function

'':::::
function emitCALL _
	( _
		byval label as FBSYMBOL ptr, _
		byval bytestopop as integer _
	) as EMIT_NODE ptr static

	function = hNewBRANCH( EMIT_OP_CALL, NULL, label, bytestopop )

end function

'':::::
function emitCALLPTR _
	( _
		byval svreg as IRVREG ptr, _
		byval bytestopop as integer _
	) as EMIT_NODE ptr static

	function = hNewBRANCH( EMIT_OP_CALLPTR, svreg, NULL, bytestopop )

end function

'':::::
function emitBRANCH _
	( _
		byval op as integer, _
		byval label as FBSYMBOL ptr _
	) as EMIT_NODE ptr static

	function = hNewBRANCH( EMIT_OP_BRANCH, NULL, label, op )

end function

'':::::
function emitJUMP _
	( _
		byval label as FBSYMBOL ptr _
	) as EMIT_NODE ptr static

	function = hNewBRANCH( EMIT_OP_JUMP, NULL, label )

end function

'':::::
function emitJUMPPTR _
	( _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	function = hNewBRANCH( EMIT_OP_JUMPPTR, svreg, NULL )

end function

function emitRET( byval bytestopop as integer ) as EMIT_NODE ptr
	dim as IRVREG vr

	vr.typ = IR_VREGTYPE_IMM
	vr.value.i = bytestopop

	function = hNewUOP( EMIT_OP_RET, @vr )
end function

'':::::
function emitLABEL _
	( _
		byval label as FBSYMBOL ptr _
	) as EMIT_NODE ptr static

	function = hNewSYMOP( EMIT_OP_LABEL, label )

end function

'':::::
function emitPUBLIC _
	( _
		byval label as FBSYMBOL ptr _
	) as EMIT_NODE ptr static

	function = hNewSYMOP( EMIT_OP_PUBLIC, label )

end function


''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' MEM
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function emitMEMMOVE _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr, _
		byval bytes as integer _
	) as EMIT_NODE ptr static

	function = hNewMEM( EMIT_OP_MEMMOVE, dvreg, svreg, bytes )

end function

'':::::
function emitMEMSWAP _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr, _
		byval bytes as integer _
	) as EMIT_NODE ptr static

	function = hNewMEM( EMIT_OP_MEMSWAP, dvreg, svreg, bytes )

end function

'':::::
function emitMEMCLEAR _
	( _
		byval dvreg as IRVREG ptr, _
		byval bytes_vreg as IRVREG ptr _
	) as EMIT_NODE ptr static

	function = hNewMEM( EMIT_OP_MEMCLEAR, dvreg, bytes_vreg, 0 )

end function

'':::::
function emitSTKCLEAR _
	( _
		byval bytes as integer, _
		byval baseofs as integer _
	) as EMIT_NODE ptr static

	function = hNewMEM( EMIT_OP_STKCLEAR, NULL, NULL, bytes, baseofs )

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' DBG
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function emitDBGLineBegin _
	( _
		byval proc as FBSYMBOL ptr, _
		byval lnum as integer, _
		byval filename As zstring ptr _
	) as EMIT_NODE ptr

	function = hNewDBG( EMIT_OP_LINEINI, proc, lnum, emit.pos, filename )

end function

'':::::
function emitDBGLineEnd _
	( _
		byval proc as FBSYMBOL ptr, _
		byval lnum as integer _
	) as EMIT_NODE ptr

	function = hNewDBG( EMIT_OP_LINEEND, proc, lnum, emit.pos )

end function

'':::::
function emitDBGScopeBegin _
	( _
		byval sym as FBSYMBOL ptr _
	) as EMIT_NODE ptr

	function = hNewDBG( EMIT_OP_SCOPEINI, sym )

end function

'':::::
function emitDBGScopeEnd _
	( _
		byval sym as FBSYMBOL ptr _
	) as EMIT_NODE ptr

	function = hNewDBG( EMIT_OP_SCOPEEND, sym )

end function


