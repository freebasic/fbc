'' intermediate representation - three-address-codes module
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "reg.bi"
#include once "emit.bi"
#include once "flist.bi"
#include once "ir.bi"
#include once "hlp.bi"

type IRTAC_CTX
	tacTB			as TFLIST
	taccnt			as integer
	tacidx			as IRTAC ptr

	vregTB			as TFLIST
end type

declare sub hFlushUOP _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval vr as IRVREG ptr _
	)

declare sub hFlushBOP _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr, _
		byval vr as IRVREG ptr _
	)

declare sub hFlushCOMP _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr, _
		byval vr as IRVREG ptr, _
		byval label as FBSYMBOL ptr _
	)

declare sub hFlushSTORE _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr _
	)

declare sub hFlushLOAD _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval vr as IRVREG ptr _
	)

declare sub hFlushCONVERT _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr _
	)

declare sub hFlushCALL _
	( _
		byval op as integer, _
		byval proc as FBSYMBOL ptr, _
		byval bytestopop as integer, _
		byval v1 as IRVREG ptr, _
		byval vr as IRVREG ptr _
	)

declare sub hFlushBRANCH _
	( _
		byval op as integer, _
		byval label as FBSYMBOL ptr _
	)

declare sub hFlushSTACK _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval ex as integer _
	)

declare sub hFlushADDR _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval vr as IRVREG ptr _
	)

declare sub hFlushMEM _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr, _
		byval bytes as integer, _
		byval extra as any ptr _
	)

declare sub hFlushDBG _
	( _
		byval op as integer, _
		byval proc as FBSYMBOL ptr, _
		byval ex as integer _
	)

declare sub hFlushLIT( byval op as integer, byval text as zstring ptr )

declare sub hFreeIDX _
	( _
		byval vreg as IRVREG ptr, _
		byval force as integer = FALSE _
	)

declare sub hFreeREG _
	( _
		byval vreg as IRVREG ptr, _
		byval force as integer = FALSE _
	)

declare sub hFreePreservedRegs _
	( _
 		_
	)

#if __FB_DEBUG__
declare sub hDumpFreeIntRegs( )
declare sub hDump _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr, _
		byval vr as IRVREG ptr, _
		byval wrapline as integer = FALSE _
	)
declare function tacvregDump( byval tacvreg as IRTACVREG ptr ) as string
declare sub tacDump( byval tac as IRTAC ptr )
#endif

declare sub _flush _
	( _
	)


'' globals
	dim shared ctx as IRTAC_CTX

	dim shared regTB(0 to EMIT_REGCLASSES-1) as REGCLASS ptr

private sub _init( )
	ctx.tacidx = NULL
	ctx.taccnt = 0

	flistInit( @ctx.tacTB, IR_INITADDRNODES, len( IRTAC ) )
	flistInit( @ctx.vregTB, IR_INITVREGNODES, len( IRVREG ) )

	emitInit( )

	for i as integer = 0 to EMIT_REGCLASSES-1
		regTB(i) = emitGetRegClass( i )
	next
end sub

private sub _end( )
	emitEnd( )

	flistEnd( @ctx.vregTB )
	flistEnd( @ctx.tacTB )

	ctx.tacidx = NULL
	ctx.taccnt = 0
end sub

'':::::
private function _emitBegin _
	( _
	) as integer

	function = emitOpen( )

end function

'':::::
private sub _emitEnd( )
	emitClose( )
end sub

'':::::
private function _getOptionValue _
	( _
		byval opt as IR_OPTIONVALUE _
	) as integer

    function = emitGetOptionValue( opt )

end function

private sub hLoadIDX( byval vreg as IRVREG ptr )
    dim as IRVREG ptr vi = any

	if( vreg = NULL ) then
		exit sub
	end if

	select case vreg->typ
	case IR_VREGTYPE_IDX, IR_VREGTYPE_PTR
	case else
		exit sub
	end select

	'' any vreg attached?
	vi = vreg->vidx
	if( vi = NULL ) then
		exit sub
	end if

	'' don't load immediates to registers
	if( vi->typ = IR_VREGTYPE_IMM ) then
		exit sub
	end if

	regTB(FB_DATACLASS_INTEGER)->ensure( regTB(FB_DATACLASS_INTEGER), vi, NULL, typeGetSize( FB_DATATYPE_INTEGER ) )
end sub

'':::::
#macro hGetVREG( vreg, dt, dc, t )
	if( vreg <> NULL ) then
		t = vreg->typ

		dt = typeGet( vreg->dtype )
		if( dt = FB_DATATYPE_POINTER ) then
			dt = FB_DATATYPE_ULONG
		end if

		dc = symb_dtypeTB(dt).class

	else
		t  = INVALID
		dt = FB_DATATYPE_INVALID
		dc = INVALID
	end if
#endmacro

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'' Add the IRTACVREG to the IRVREG's list
private sub hRelink( byval vreg as IRVREG ptr, byval tvreg as IRTACVREG ptr )
	if( vreg->tacvhead = NULL ) then
		vreg->tacvhead = tvreg
	else
		vreg->tacvtail->next = tvreg
	end if
	vreg->tacvtail = tvreg
end sub

'' Setup an IRTAC's vr, v1 or v2 fields for the given IRVREG and its idx/aux
'' sub-IRVREGs.
#macro hRelinkVreg(v,t)
    t->v.reg.parent = NULL
    t->v.reg.next = NULL

    if( v <> NULL ) then
    	hRelink( v, @t->v.reg )
    	v->taclast = t

    	if( v->vidx <> NULL ) then
    		t->v.idx.vreg = v->vidx
    		t->v.idx.parent = v
    		t->v.idx.next = NULL
    		hRelink( v->vidx, @t->v.idx )
    		v->vidx->taclast = t
    	end if

    	if( v->vaux <> NULL ) then
    		t->v.aux.vreg = v->vaux
    		t->v.aux.parent = v
    		t->v.aux.next = NULL
    		hRelink( v->vaux, @t->v.aux )
    		v->vaux->taclast = t
    	end if
    end if
#endmacro

'':::::
private sub _emit _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr, _
		byval vr as IRVREG ptr, _
		byval ex1 as FBSYMBOL ptr = NULL, _
		byval ex2 as integer = 0 _
	) static

    dim as IRTAC ptr t

	'' Add a new IRTAC node to represent the three operand vregs
    t = flistNewItem( @ctx.tacTB )

    t->pos = ctx.taccnt

    t->op = op

    t->v1.reg.vreg = v1
    hRelinkVreg( v1, t )

    t->v2.reg.vreg = v2
    hRelinkVreg( v2, t )

    t->vr.reg.vreg = vr
    hRelinkVreg( vr, t )

    t->ex1 = ex1
    t->ex2 = ex2

    ctx.taccnt += 1

end sub

'':::::
private sub _procBegin _
	( _
		byval proc as FBSYMBOL ptr _
	) static

	emitProcBegin( proc )

end sub

'':::::
private sub _procEnd _
	( _
		byval proc as FBSYMBOL ptr _
	) static

	emitProcEnd( proc )

end sub

private sub _procAllocArg _
	( _
		byval proc as FBSYMBOL ptr, _
		byval sym as FBSYMBOL ptr _
	)

	emitProcAllocArg( proc, sym )

end sub

private sub _procAllocLocal _
	( _
		byval proc as FBSYMBOL ptr, _
		byval sym as FBSYMBOL ptr _
	)

	emitProcAllocLocal( proc, sym )

end sub

'':::::
private function _procGetFrameRegName _
	( _
	) as const zstring ptr

	function = emitProcGetFrameRegName( )

end function

'':::::
private sub _scopeBegin _
	( _
		byval s as FBSYMBOL ptr _
	) static

	emitScopeBegin( s )

end sub

'':::::
private sub _scopeEnd _
	( _
		byval s as FBSYMBOL ptr _
	) static

	emitScopeEnd( s )

end sub

private sub _procAllocStaticVars( byval head_sym as FBSYMBOL ptr )
	emitProcAllocStaticVars( head_sym )
end sub

'':::::
private sub _emitLabel _
	( _
		byval label as FBSYMBOL ptr _
	) static

	_flush( )

	emitLABEL( label )

end sub

'':::::
private sub _emitReturn _
	( _
		byval bytestopop as integer _
	) static

	_flush( )

	emitRET( bytestopop )

end sub

'':::::
private sub _emitProcBegin _
	( _
		byval proc as FBSYMBOL ptr, _
		byval initlabel as FBSYMBOL ptr _
	) static

	dim as integer class_

	_flush( )

	'' clear regs so they aren't different from one proc to another
	for class_ = 0 to EMIT_REGCLASSES-1
		regTB(class_)->Clear( regTB(class_) )
	next

	emitProcHeader( proc, initlabel )

end sub

private sub _emitProcEnd _
	( _
		byval proc as FBSYMBOL ptr, _
		byval initlabel as FBSYMBOL ptr, _
		byval exitlabel as FBSYMBOL ptr _
	)

	_flush( )

	emitProcFooter( proc, symbProcCalcBytesToPop( proc ), initlabel, exitlabel )

end sub

'':::::
private sub _emitScopeBegin _
	( _
		byval s as FBSYMBOL ptr _
	)

	_flush( )

end sub

'':::::
private sub _emitScopeEnd _
	( _
		byval s as FBSYMBOL ptr _
	)

	_flush( )

end sub

'':::::
private sub _emitBop _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr, _
		byval vr as IRVREG ptr, _
		byval label as FBSYMBOL ptr _
	)

	_emit( op, v1, v2, vr, label )

end sub

'':::::
private sub _emitUop _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval vr as IRVREG ptr _
	)

	_emit( op, v1, NULL, vr )

end sub

private sub _emitConvert( byval v1 as IRVREG ptr, byval v2 as IRVREG ptr )
	select case( typeGetClass( v1->dtype ) )
	case FB_DATACLASS_INTEGER
		if( typeGetDtAndPtrOnly( v1->dtype ) = FB_DATATYPE_BOOLEAN ) then
			_emit( AST_OP_TOBOOL, v1, v2, NULL )
		else
			_emit( AST_OP_TOINT, v1, v2, NULL )
		end if
	case FB_DATACLASS_FPOINT
		_emit( AST_OP_TOFLT, v1, v2, NULL )
	end select
end sub

private sub _emitStore( byval v1 as IRVREG ptr, byval v2 as IRVREG ptr )
	_emit( AST_OP_ASSIGN, v1, v2, NULL )
end sub

'':::::
private sub _emitSpillRegs _
	( _
	)

	_emit( AST_OP_SPILLREGS, NULL, NULL, NULL )

end sub

'':::::
private sub _emitLoad _
	( _
		byval v1 as IRVREG ptr _
	)

	_emit( AST_OP_LOAD, v1, NULL, NULL )

end sub

'':::::
private sub _emitLoadRes _
	( _
		byval v1 as IRVREG ptr, _
		byval vr as IRVREG ptr _
	)

	_emit( AST_OP_LOADRES, v1, NULL, vr )

end sub

'':::::
private sub _emitStack _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr _
	)

	_emit( op, v1, NULL, NULL )

end sub

'':::::
private sub _emitPushArg _
	( _
		byval param as FBSYMBOL ptr, _
		byval vr as IRVREG ptr, _
		byval udtlen as longint, _
		byval level as integer _
	)

	if( udtlen = 0 ) then
		_emitStack( AST_OP_PUSH, vr )
	else
		_emit( AST_OP_PUSHUDT, vr, NULL, NULL, NULL, udtlen )
	end if

end sub

'':::::
private sub _emitAddr _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval vr as IRVREG ptr _
	)

	_emit( op, v1, NULL, vr )

end sub

'':::::
private sub _emitLabelNF _
	( _
		byval l as FBSYMBOL ptr _
	)

	_emit( AST_OP_LABEL, NULL, NULL, NULL, l )

end sub

'':::::
private sub _emitCall _
	( _
		byval proc as FBSYMBOL ptr, _
		byval bytestopop as integer, _
		byval vr as IRVREG ptr, _
		byval level as integer _
	)

	_emit( AST_OP_CALLFUNCT, NULL, NULL, vr, proc, bytestopop )

end sub

'':::::
private sub _emitCallPtr _
	( _
		byval proc as FBSYMBOL ptr, _
		byval v1 as IRVREG ptr, _
		byval vr as IRVREG ptr, _
		byval bytestopop as integer, _
		byval level as integer _
	)

	_emit( AST_OP_CALLPTR, v1, NULL, vr, proc, bytestopop )

end sub

'':::::
private sub _emitStackAlign _
	( _
		byval bytes as integer _
	)

	_emit( AST_OP_STACKALIGN, NULL, NULL, NULL, NULL, bytes )

end sub

private sub _emitJumpPtr( byval v1 as IRVREG ptr )
	_emit( AST_OP_JUMPPTR, v1, NULL, NULL, NULL )
end sub

private sub _emitBranch( byval op as integer, byval label as FBSYMBOL ptr )
	_emit( op, NULL, NULL, NULL, label )
end sub

private sub _emitJmpTb _
	( _
		byval v1 as IRVREG ptr, _
		byval tbsym as FBSYMBOL ptr, _
		byval values as ulongint ptr, _
		byval labels as FBSYMBOL ptr ptr, _
		byval labelcount as integer, _
		byval deflabel as FBSYMBOL ptr, _
		byval minval as ulongint, _
		byval maxval as ulongint _
	)

	_flush( )
	emitJMPTB( tbsym, values, labels, labelcount, deflabel, minval, maxval )

end sub

'':::::
private sub _emitMem _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr, _
		byval bytes as longint _
	)

	_emit( op, v1, v2, NULL, 0, bytes )

end sub

private sub _emitDECL( byval sym as FBSYMBOL ptr )
	'' Nothing to do - used by C backend
end sub

'':::::
private sub _emitDBG _
	( _
		byval op as integer, _
		byval proc as FBSYMBOL ptr, _
		byval ex as integer _
	)

	_emit( op, NULL, NULL, NULL, proc, ex )

end sub

private sub _emitComment( byval text as zstring ptr )
	_emit( AST_OP_LIT_COMMENT, NULL, NULL, NULL, cast( any ptr, ZstrDup( text ) ) )
end sub

private sub _emitAsmLine( byval asmtokenhead as ASTASMTOK ptr )
	dim ln as string

	var n = asmtokenhead
	while( n )

		select case( n->type )
		case AST_ASMTOK_TEXT
			ln += *n->text
		case AST_ASMTOK_SYMB
			ln += *symbGetMangledName( n->sym )
			var ofs = symbGetOfs( n->sym )
			if( ofs <> 0 ) then
				if( ofs > 0 ) then
					ln += "+"
				end if
				ln += str( ofs )
			end if
		end select

		n = n->next
	wend

	_emit( AST_OP_LIT_ASM, NULL, NULL, NULL, cast( any ptr, ZstrDup( strptr( ln ) ) ) )
end sub

private sub _emitVarIniBegin( byval sym as FBSYMBOL ptr )
	'' no flush, all var-ini go to data sections
	emitVARINIBEGIN( sym )
end sub

private sub _emitVarIniEnd( byval sym as FBSYMBOL ptr )
end sub

private sub _emitVarIniI( byval sym as FBSYMBOL ptr, byval value as longint )
	emitVARINIi( symbGetType( sym ), value )
end sub

private sub _emitVarIniF( byval sym as FBSYMBOL ptr, byval value as double )
	emitVARINIf( symbGetType( sym ), value )
end sub

private sub _emitVarIniOfs _
	( _
		byval sym as FBSYMBOL ptr, _
		byval rhs as FBSYMBOL ptr, _
		byval ofs as longint _
	)
	emitVARINIOFS( symbGetMangledName( rhs ), ofs )
end sub

private sub _emitVarIniStr _
	( _
		byval totlgt as longint, _
		byval litstr as zstring ptr, _
		byval litlgt as longint _
	)

	dim as const zstring ptr s

	'' zstring * 1?
	if( totlgt = 0 ) then
		emitVARINIi( FB_DATATYPE_BYTE, 0 )
		exit sub
	end if

	''
	if( litlgt > totlgt ) then
		errReportWarn( FB_WARNINGMSG_LITSTRINGTOOBIG )
		'' !!!FIXME!!! truncate will fail if it lies on an escape seq
		s = hEscape( left( *litstr, totlgt ) )
	else
		s = hEscape( litstr )
	end if

	''
	emitVARINISTR( s )

	if( litlgt < totlgt ) then
		emitVARINIPAD( totlgt - litlgt )
	end if

end sub

'':::::
private sub _emitVarIniWstr _
	( _
		byval totlgt as longint, _
		byval litstr as wstring ptr, _
		byval litlgt as longint _
	)

	dim as zstring ptr s
	dim as integer wclen

	'' wstring * 1?
	if( totlgt = 0 ) then
		emitVARINIi( env.target.wchar, 0 )
		exit sub
	end if

	''
	if( litlgt > totlgt ) then
		errReportWarn( FB_WARNINGMSG_LITSTRINGTOOBIG )
		'' !!!FIXME!!! truncate will fail if it lies on an escape seq
		s = hEscapeW( left( *litstr, totlgt ) )
	else
		s = hEscapeW( litstr )
	end if

	''
	wclen = typeGetSize( FB_DATATYPE_WCHAR )

	emitVARINIWSTR( s )

	if( litlgt < totlgt ) then
		emitVARINIPAD( (totlgt - litlgt) * wclen )
	end if

end sub

private sub _emitVarIniPad( byval bytes as longint )
	emitVARINIPAD( bytes )
end sub

private sub _emitVarIniScopeBegin( byval sym as FBSYMBOL ptr, byval is_array as integer )
	'' Used by C-emitter only
end sub

private sub _emitVarIniScopeEnd( )
	'' Used by C-emitter only
end sub

private sub _emitFbctinfBegin( )
	emitFBCTINFBEGIN( )
end sub

private sub _emitFbctinfString( byval s as const zstring ptr )
	emitFBCTINFSTRING( s )
end sub

private sub _emitFbctinfEnd( )
	emitFBCTINFEND( )
end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private function hNewVR _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval vtype as integer _
	) as IRVREG ptr

	dim as IRVREG ptr v = any

	v = flistNewItem( @ctx.vregTB )

	v->typ = vtype
	v->dtype = typeGet( dtype )
	v->subtype = subtype
	v->reg = INVALID
	if( env.clopt.fputype = FB_FPUTYPE_FPU ) then
		v->regFamily = IR_REG_FPU_STACK
	else
		v->regFamily = IR_REG_SSE
	end if
	v->vector = 0
	v->sym = NULL
	v->ofs = 0
	v->mult = 0
	v->vidx	= NULL
	v->vaux	= NULL
	v->tacvhead = NULL
	v->tacvtail = NULL
	v->taclast = NULL

	function = v
end function

'':::::
private function _allocVreg _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as IRVREG ptr

	dim as IRVREG ptr vr = any

	vr = hNewVR( dtype, subtype, IR_VREGTYPE_REG )

	'' longint?
	if( ISLONGINT( dtype ) ) then
		 vr->vaux = hNewVR( FB_DATATYPE_INTEGER, NULL, IR_VREGTYPE_REG )
	end if

	function = vr

end function

private function _allocVrImm _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval value as longint _
	) as IRVREG ptr

	dim as IRVREG ptr vr = any

	vr = hNewVR( dtype, subtype, IR_VREGTYPE_IMM )

	if( ISLONGINT( dtype ) ) then
		'' Only the low 32bits go in the main vreg
		vr->value.i = value and &hFFFFFFFFll

		'' The aux vreg takes the high 32bits
		'' (doing cunsg() to get an unsigned shr, no sign extension)
		vr->vaux = hNewVR( FB_DATATYPE_INTEGER, NULL, IR_VREGTYPE_IMM )
		vr->vaux->value.i = cunsg( value ) shr 32
	else
		vr->value.i = value
	end if

	function = vr
end function

private function _allocVrImmF _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval value as double _
	) as IRVREG ptr

	dim as IRVREG ptr vr = any
	dim as FBSYMBOL ptr s = any

	'' float immediates supported by the FPU?
	if( irGetOption( IR_OPT_FPUIMMEDIATES ) ) then
		vr = hNewVR( dtype, subtype, IR_VREGTYPE_IMM )
		vr->value.f = value
	else
		'' create a temp const var
		s = symbAllocFloatConst( value, dtype )
		vr = irAllocVRVAR( dtype, subtype, s, symbGetOfs( s ) )
	end if

	function = vr
end function

'':::::
private function _allocVrVar _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval symbol as FBSYMBOL ptr, _
		byval ofs as longint _
	) as IRVREG ptr

	dim as IRVREG ptr vr = any, va = any

	assert( symbol )

	vr = hNewVR( dtype, subtype, IR_VREGTYPE_VAR )

	vr->sym = symbol
	vr->ofs = ofs

	'' longint?
	if( ISLONGINT( dtype ) ) then
		va = hNewVR( FB_DATATYPE_INTEGER, NULL, IR_VREGTYPE_VAR )
		vr->vaux = va
		va->ofs = ofs + 4  '' vaux = the upper 4 bytes
	end if

	function = vr

end function

'':::::
private function _allocVrIdx _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval symbol as FBSYMBOL ptr, _
		byval ofs as longint, _
		byval mult as integer, _
		byval vidx as IRVREG ptr _
	) as IRVREG ptr

	dim as IRVREG ptr vr = any, va = any

	vr = hNewVR( dtype, subtype, IR_VREGTYPE_IDX )

	vr->sym = symbol
	vr->ofs = ofs
	vr->mult = mult
	vr->vidx = vidx

	'' longint?
	if( ISLONGINT( dtype ) ) then
		va = hNewVR( FB_DATATYPE_INTEGER, NULL, IR_VREGTYPE_IDX )
		vr->vaux= va
		va->ofs = ofs + 4  '' vaux = the upper 4 bytes
	end if

	function = vr

end function

'':::::
private function _allocVrPtr _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval ofs as longint, _
		byval vidx as IRVREG ptr _
	) as IRVREG ptr

	dim as IRVREG ptr vr = any, va = any

	vr = hNewVR( dtype, subtype, IR_VREGTYPE_PTR )

	vr->ofs = ofs
	vr->mult = 1
	vr->vidx = vidx

	'' longint?
	if( ISLONGINT( dtype ) ) then
		va = hNewVR( FB_DATATYPE_INTEGER, NULL, IR_VREGTYPE_PTR )
		vr->vaux= va
		va->ofs = ofs + 4  '' vaux = the upper 4 bytes
	end if

	function = vr

end function

'':::::
private function _allocVrOfs _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval symbol as FBSYMBOL ptr, _
		byval ofs as longint _
	) as IRVREG ptr

	dim as IRVREG ptr vr = any

	vr = hNewVR( dtype, subtype, IR_VREGTYPE_OFS )

	vr->sym = symbol
	vr->ofs = ofs

	function = vr

end function

'':::::
private sub _setVregDataType _
	( _
		byval vreg as IRVREG ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	)

	if( vreg <> NULL ) then
		vreg->dtype = typeGet( dtype )
		vreg->subtype = subtype
	end if

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

#if __FB_DEBUG__
private sub hDumpFreeIntRegs( )
	dim as string free, used
	dim as integer reg = any

	'' For each register in the integer class
	reg = regTB(FB_DATACLASS_INTEGER)->getFirst( regTB(FB_DATACLASS_INTEGER) )
	while( reg <> INVALID )

		if( regTB(FB_DATACLASS_INTEGER)->isFree( regTB(FB_DATACLASS_INTEGER), reg ) ) then
			if( len( free ) > 0 ) then free += ", "
			free += emitDumpRegName( FB_DATATYPE_INTEGER, reg )
		else
			if( len( used ) > 0 ) then used += ", "
			used += emitDumpRegName( FB_DATATYPE_INTEGER, reg )
		end if

		reg = regTB(FB_DATACLASS_INTEGER)->getNext( regTB(FB_DATACLASS_INTEGER), reg )
	wend

	print , "used: " & used & " | free: " & free
end sub

private sub hDump _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr, _
		byval vr as IRVREG ptr, _
		byval wrapline as integer = FALSE _
	)

	dim s as string

	if( astGetOpId( op ) <> NULL ) then
		s = *astGetOpId( op )
	else
		s = str( op )
	end if

	const MAXLEN = 4
	select case( len( s ) )
	case is > MAXLEN
		s = left( s, MAXLEN )
	case is < MAXLEN
		s += space( MAXLEN - len( s ) )
	end select
	s = "[" + s + "]"

	#macro hDumpVr( id, v )
		if( v <> NULL ) then
			if( wrapline ) then
				s += !"\t"
			else
				s += " "
			end if
			s += id + " = " + vregDump( v )
			if( wrapline ) then
				s += NEWLINE
			else
				s += !"\t"
			end if
		end if
	#endmacro

	hDumpVr( "d", vr )
	hDumpVr( "l", v1 )
	hDumpVr( "r", v2 )

	if( wrapline = FALSE ) then
		s += NEWLINE
	end if

	if( (wrapline = FALSE) and (len( s ) > 79) ) then
		hDump( op, v1, v2, vr, TRUE )
	else
		print s;
	end if

end sub

function tacvregDump( byval tacvreg as IRTACVREG ptr ) as string
	if( tacvreg = NULL ) then
		return "<NULL>"
	end if
	function = "IRTACVREG( " & _
		"vreg=" & vregDump( tacvreg->vreg ) & ", " & _
		"parent=" & vregDump( tacvreg->parent ) & ", " & _
		"next=" & tacvregDump( tacvreg->next ) & " )"
end function

sub tacDump( byval tac as IRTAC ptr )
	if( tac = NULL ) then
		print "IRTAC: <NULL>"
		exit sub
	end if
	print "IRTAC: pos=" & tac->pos & ", op=" & tac->op
	print , "vr vreg: " & tacvregDump( @tac->vr.reg )
	print , "vr vidx: " & tacvregDump( @tac->vr.idx )
	print , "vr vaux: " & tacvregDump( @tac->vr.aux )
	print , "v1 vreg: " & tacvregDump( @tac->v1.reg )
	print , "v1 vidx: " & tacvregDump( @tac->v1.idx )
	print , "v1 vaux: " & tacvregDump( @tac->v1.aux )
	print , "v2 vreg: " & tacvregDump( @tac->v2.reg )
	print , "v2 vidx: " & tacvregDump( @tac->v2.idx )
	print , "v2 vaux: " & tacvregDump( @tac->v2.aux )
end sub
#endif

'':::::
private sub hRename _
	( _
		byval vold as IRVREG ptr, _
		byval vnew as IRVREG ptr _
	)

    dim as IRTACVREG ptr t = any
    dim as IRVREG ptr v = any

	'' reassign tac table vregs
	'' (assuming res, v1 and v2 will never point to the same vreg!)
	t = vold->tacvhead
	do
		'' if it's an index or auxiliary vreg, update parent
		if( t->parent ) then
			assert( (t->parent->vidx = vold) or (t->parent->vaux = vold) )
			if( t->parent->vidx = vold ) then
				t->parent->vidx = vnew
			else
				t->parent->vaux = vnew
			end if
		end if
		t->vreg = vnew
		t = t->next
	loop while( t <> NULL )

	vnew->tacvhead = vold->tacvhead
	vnew->tacvtail = vold->tacvtail
	vnew->taclast = vold->taclast

end sub

'':::::
private sub hReuse _
	( _
		byval t as IRTAC ptr _
	)

    dim as IRVREG ptr v1 = any, v2 = any, vr = any
    dim as integer v1_dtype = any, v1_dclass = any, v1_typ = any
    dim as integer v2_dtype = any, v2_dclass = any, v2_typ = any
    dim as integer vr_dtype = any, vr_dclass = any, vr_typ = any
    dim as integer op = any

	op = t->op
	v1 = t->v1.reg.vreg
	v2 = t->v2.reg.vreg
	vr = t->vr.reg.vreg

	hGetVREG( v1, v1_dtype, v1_dclass, v1_typ )
	hGetVREG( v2, v2_dtype, v2_dclass, v2_typ )
    hGetVREG( vr, vr_dtype, vr_dclass, vr_typ )

	'' Allow operand reg to be re-used as result reg (to avoid allocating yet another reg)
	'' but only if the dtype is similar (same size, same signedness),
	'' otherwise vr would have unintended properties which can affect code generation.

	select case astGetOpClass( op )
	case AST_NODECLASS_UOP
		if( vr <> v1 ) then
			if( typeGetSizeType( vr_dtype ) = typeGetSizeType( v1_dtype ) ) then
           		if( irGetDistance( v1 ) = IR_MAXDIST ) then
           			hRename( vr, v1 )
           		end if
           	end if
		end if

	case AST_NODECLASS_BOP, AST_NODECLASS_COMP
		dim as integer v1rename = any, v2rename = any

		if( vr = NULL ) then
			exit sub
		end if

		'' check if operands have the same class (can happen 'cause the x86 FPU hacks)
		if( v1_dclass <> v2_dclass ) then
			exit sub
		end if

		v1rename = FALSE
		if( vr <> v1 ) then
			if( typeGetSizeType( vr_dtype ) = typeGetSizeType( v1_dtype ) ) then
           		if( irGetDistance( v1 ) = IR_MAXDIST ) then
           			v1rename = TRUE
           		end if
           	end if
		end if

		v2rename = FALSE
		if( astGetOpIsCommutative( op ) ) then
			if( vr <> v2 ) then
				if( typeGetSizeType( vr_dtype ) = typeGetSizeType( v2_dtype ) ) then
					if( v2_typ <> IR_VREGTYPE_IMM ) then
           				if( irGetDistance( v2 ) = IR_MAXDIST ) then
           					v2rename = TRUE
           				end if
           			end if
           		end if
			end if
		end if

		if( v1rename and v2rename ) then
			if( irIsREG( v1 ) = FALSE ) then
           		v1rename = FALSE
			end if
		end if

		if( v1rename ) then
           	hRename( vr, v1 )

		elseif( v2rename ) then
		 	swap t->v1, t->v2

			hRename( vr, v2 )
		end if

	end select

end sub

'':::::
private sub _flush static
    dim as integer op
    dim as IRTAC ptr t
    dim as IRVREG ptr v1, v2, vr

	if( ctx.taccnt = 0 ) then
		exit sub
	end if

	t = flistGetHead( @ctx.tacTB )
	do
		ctx.tacidx = t

		hReuse( t )

		op = t->op
		v1 = t->v1.reg.vreg
		v2 = t->v2.reg.vreg
		vr = t->vr.reg.vreg

		''
		'hDump( op, v1, v2, vr )

        ''
		select case as const astGetOpClass( op )
		case AST_NODECLASS_UOP
			hFlushUOP( op, v1, vr )

		case AST_NODECLASS_BOP
			hFlushBOP( op, v1, v2, vr )

		case AST_NODECLASS_COMP
			hFlushCOMP( op, v1, v2, vr, t->ex1 )

		case AST_NODECLASS_ASSIGN
			hFlushSTORE( op, v1, v2 )

		case AST_NODECLASS_LOAD
			hFlushLOAD( op, v1, vr )

		case AST_NODECLASS_CONV
			hFlushCONVERT( op, v1, v2 )

		case AST_NODECLASS_STACK
			hFlushSTACK( op, v1, t->ex2 )

		case AST_NODECLASS_CALL
			hFlushCALL( op, t->ex1, t->ex2, v1, vr )

		case AST_NODECLASS_BRANCH
			hFlushBRANCH( op, t->ex1 )

		case AST_NODECLASS_ADDROF
			hFlushADDR( op, v1, vr )

		case AST_NODECLASS_MEM
			hFlushMEM( op, v1, v2, t->ex2, t->ex1 )

		case AST_NODECLASS_DBG
			hFlushDBG( op, t->ex1, t->ex2 )

		case AST_NODECLASS_LIT
			hFlushLIT( op, cast( any ptr, t->ex1 ) )

		end select

		if( env.clopt.fputype >= FB_FPUTYPE_SSE ) then
			'' after vr has been used for the first time, force reg family to be SSE
			if( astGetOpClass( op ) <> AST_NODECLASS_CALL ) then
				if( vr ) then
					if( vr->regFamily = IR_REG_FPU_STACK ) then vr->regFamily = IR_REG_SSE
				end if
			end if
		end if

		t = flistGetNext( t )
	loop while( t <> NULL )

	''
	ctx.tacidx = NULL
	ctx.taccnt = 0
	flistReset( @ctx.tacTB )

	''
	flistReset( @ctx.vregTB )

    ''
    hFreePreservedRegs( )

end sub

private sub hFlushBRANCH _
	( _
		byval op as integer, _
		byval label as FBSYMBOL ptr _
	)

	select case as const op
	case AST_OP_LABEL
		emitLABEL( label )

	case AST_OP_JMP
		emitJUMP( label )

	case AST_OP_CALL
		emitCALL( label, 0 )

	case AST_OP_RET
		emitRET( 0 )

	case else
		emitBRANCH( op, label )
	end select

end sub

'':::::
private sub hFreePreservedRegs( ) static
    dim as integer class_, reg

	'' for each reg class
	for class_ = 0 to EMIT_REGCLASSES-1

		'' for each register on that class
		reg = regTB(class_)->getFirst( regTB(class_) )
		do until( reg = INVALID )
			'' if not free
			if( regTB(class_)->isFree( regTB(class_), reg ) = FALSE ) then

        		assert( emitIsRegPreserved( class_, reg ) )

        		'' free reg
        		regTB(class_)->free( regTB(class_), reg )

			end if

        	'' next reg
        	reg = regTB(class_)->getNext( regTB(class_), reg )
		loop

	next

end sub

private function hPreserveReg( byval vr as IRVREG ptr ) as integer
	dim as integer vr_dclass = any, vr_dtype = any, vr_typ = any
	dim as integer preserved1 = any, preserved2 = any
	dim as integer freg1 = any, freg2 = any
	dim as IRVREG origvreg = any, origvaux = any, destvreg = any

	'' If the vreg uses a register that isn't preserved across calls,
	'' we have to allocate another register that is preserved, and copy
	'' over the data. If there is no other free preserved register
	'' available, we must spill and put the data into a temp var on stack.
	''
	'' For LONGINTs this is more complex, because both main and aux vregs
	'' must be checked. If either needs to be spilled, both should be
	'' spilled, to ensure the LONGINT's dwords stay together, either both
	'' in regs, or both on stack.

	hGetVREG( vr, vr_dtype, vr_dclass, vr_typ )

	assert( irIsREG( vr ) )
	origvreg = *vr
	preserved1 = emitIsRegPreserved( vr_dclass, vr->reg )
	if( ISLONGINT( vr_dtype ) ) then
		assert( irIsREG( vr->vaux ) )
		origvaux = *vr->vaux
		origvreg.vaux = @origvaux
		preserved2 = emitIsRegPreserved( vr_dclass, vr->vaux->reg )
	else
		preserved2 = TRUE
	end if

	if( preserved1 and preserved2 ) then
		'' Both vr and vaux (if any) already use regs that will be
		'' preserved, nothing to do
		return TRUE
	end if

	if( preserved1 = FALSE ) then
		'' Find a free preserved reg to copy to
		freg1 = emitGetFreePreservedReg( vr_dclass, vr_dtype )
		if( freg1 = INVALID ) then
			'' None free, need to spill
			return FALSE
		end if
		vr->reg = regTB(vr_dclass)->allocateReg( regTB(vr_dclass), freg1, vr, NULL )
	end if

	if( preserved2 = FALSE ) then
		'' Find a 2nd free preserved reg (this relies on the 1st one
		'' already being allocated, otherwise this would just return
		'' the same reg again)
		freg2 = emitGetFreePreservedReg( FB_DATACLASS_INTEGER, FB_DATATYPE_INTEGER )
		if( freg2 = INVALID ) then
			'' None free, need to spill
			if( preserved1 = FALSE ) then
				'' Restore vr to its old reg
				regTB(vr_dclass)->free( regTB(vr_dclass), vr->reg )
				vr->reg = origvreg.reg
			end if
			return FALSE
		end if
		vr->vaux->reg = regTB(FB_DATACLASS_INTEGER)->allocateReg( regTB(FB_DATACLASS_INTEGER), freg2, vr->vaux, vr )
	end if

	if( (not preserved1) and (not preserved2) ) then
		'' Both vr and its vaux changed, move both to their new regs
		emitMOV( vr, @origvreg )
	elseif( preserved1 = FALSE ) then
		'' vr changed, vaux (if any) didn't
		if( ISLONGINT( vr_dtype ) ) then
			'' Copy vr temporarily, remapping its type and removing
			'' the vaux vreg, so we can move only the low dword
			destvreg = *vr
			destvreg.dtype = FB_DATATYPE_INTEGER
			destvreg.vaux = NULL

			origvreg.dtype = FB_DATATYPE_INTEGER
			origvreg.vaux = NULL

			emitMOV( @destvreg, @origvreg )
		else
			emitMOV( vr, @origvreg )
		end if
	else
		'' vaux changed, vr didn't
		emitMOV( vr->vaux, @origvaux )
	end if

	'' Free the original register(s)
	if( preserved1 = FALSE ) then
		regTB(vr_dclass)->free( regTB(vr_dclass), origvreg.reg )
	end if
	if( preserved2 = FALSE ) then
		regTB(FB_DATACLASS_INTEGER)->free( regTB(FB_DATACLASS_INTEGER), origvaux.reg )
	end if

	function = TRUE
end function

private sub hPreserveRegs( byval ptrvreg as IRVREG ptr = NULL )
	dim as integer npreg = any, reg = any
	dim as IRVREG ptr vr = any, vauxparent = any

	'' for each reg class
	for class_ as integer = 0 to EMIT_REGCLASSES-1
    	'' set the register that shouldn't be preserved (used for CALLPTR only)

    	npreg = INVALID
    	if( class_ = FB_DATACLASS_INTEGER ) then
    		if( ptrvreg <> NULL ) then

    			select case ptrvreg->typ
    			case IR_VREGTYPE_REG
    				npreg = ptrvreg->reg

    			case IR_VREGTYPE_IDX, IR_VREGTYPE_PTR
    				ptrvreg = ptrvreg->vidx
    				if( ptrvreg <> NULL ) then
    					npreg = ptrvreg->reg
    				end if
    			end select

    			ptrvreg = NULL
    		end if
    	end if

		'' for each register on that class
		reg = regTB(class_)->getFirst( regTB(class_) )
		do until( reg = INVALID )
			'' if not free
			if( (regTB(class_)->isFree( regTB(class_), reg ) = FALSE) and _
				(reg <> npreg) ) then

				'' get the attached vreg
				vr = regTB(class_)->getVreg( regTB(class_), reg, vauxparent )
				assert( irIsREG( vr ) and (vr->reg = reg) )

				'' If this is a LONGINT vreg's vaux, use the main vreg instead.
				'' This way we ensure that we'll always check both the main and
				'' aux vregs, no matter which one is found first in this loop.
				if( vauxparent ) then
					assert( vauxparent->vaux = vr )
					vr = vauxparent
				end if

				'' Move to other registers if needed and possible
				if( hPreserveReg( vr ) = FALSE ) then
					'' Failed, no more free regs, spill to stack
					irStoreVR( vr, NULL )
				end if
			end if

			'' next reg
			reg = regTB(class_)->getNext( regTB(class_), reg )
		loop
	next

end sub

private sub hLoadPointer( byval v1 as IRVREG ptr )
	dim as integer vtype = any, dtype = any, dclass = any
	hGetVREG( v1, dtype, dclass, vtype )
	hLoadIDX( v1 )
	if( vtype = IR_VREGTYPE_REG ) then
		regTB(dclass)->ensure( regTB(dclass), v1, NULL, typeGetSize( dtype ) )
	end if
end sub

private sub hLoadResult( byval proc as FBSYMBOL ptr, byval vr as IRVREG ptr )
	dim as integer vtype = any, dtype = any, dclass = any, reg1 = any, reg2 = any
	dim as IRVREG ptr va = any

	'' Load result, if any (fb allows function calls w/o saving the result)
	if( vr ) then
		hGetVREG( vr, dtype, dclass, vtype )
		emitGetResultReg( dtype, dclass, reg1, reg2 )

		if( ISLONGINT( dtype ) ) then
			va = vr->vaux
			va->reg = regTB(dclass)->allocateReg( regTB(dclass), reg2, va, vr )
			va->typ = IR_VREGTYPE_REG
		end if

		vr->reg = regTB(dclass)->allocateReg( regTB(dclass), reg1, vr, NULL )
		vr->typ = IR_VREGTYPE_REG

		hFreeREG( vr )
	else
		'' Integer function results in EAX[:EDX] or float results in xmm0 can just be ignored,
		'' but float results in st(0) must be popped from the FPU stack.
		if( (typeGetClass( symbGetProcRealType( proc ) ) = FB_DATACLASS_FPOINT) and _
		    (proc->proc.returnMethod <> FB_RETURN_SSE) ) then
			emitPOPST0( )
		end if
	end if
end sub

private sub hFlushCALL _
	( _
		byval op as integer, _
		byval proc as FBSYMBOL ptr, _
		byval bytestopop as integer, _
		byval v1 as IRVREG ptr, _
		byval vr as IRVREG ptr _
	)

	select case( op )
	case AST_OP_CALLFUNCT
		'' save used registers and free the FPU stack
		hPreserveRegs( )

		emitCALL( proc, bytestopop )
		hLoadResult( proc, vr )

	case AST_OP_CALLPTR
		hPreserveRegs( v1 )

		hLoadPointer( v1 )
		emitCALLPTR( v1, bytestopop )
		hFreeREG( v1 )
		hLoadResult( proc, vr )

	case AST_OP_JUMPPTR
		hLoadPointer( v1 )
		emitJUMPPTR( v1 )
		hFreeREG( v1 )
		assert( vr = NULL )

	case else
		assert( FALSE )
	end select

end sub

'':::::
private sub hFlushSTACK _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval ex as integer _
	) static

	dim as integer v1_typ, v1_dtype, v1_dclass
	dim as IRVREG ptr va

	''
	if( op = AST_OP_STACKALIGN ) then
		emitSTACKALIGN( ex )
		exit sub
	end if

	''
	hGetVREG( v1, v1_dtype, v1_dclass, v1_typ )

	hLoadIDX( v1 )

	'' load only if it's a reg (x86 assumption)
	if( v1_typ = IR_VREGTYPE_REG ) then
		'' handle longint
		if( ISLONGINT( v1_dtype ) ) then
			va = v1->vaux
			regTB(v1_dclass)->ensure( regTB(v1_dclass), va, v1, typeGetSize( FB_DATATYPE_INTEGER ) )
			v1_dtype = FB_DATATYPE_INTEGER
		end if
		regTB(v1_dclass)->ensure( regTB(v1_dclass), v1, NULL, typeGetSize( v1_dtype ) )
	end if

	''
	select case op
	case AST_OP_PUSH
		emitPUSH( v1 )
	case AST_OP_PUSHUDT
		emitPUSHUDT( v1, ex )
	case AST_OP_POP
		emitPOP( v1 )
	end select

    ''
	hFreeREG( v1 )

end sub

'':::::
private sub hFlushUOP _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval vr as IRVREG ptr _
	) static

	dim as integer v1_typ, v1_dtype, v1_dclass
	dim as integer vr_typ, vr_dtype, vr_dclass
	dim as IRVREG ptr va

	dim as integer v1vector
	v1vector = v1->vector

	''
	hGetVREG( v1, v1_dtype, v1_dclass, v1_typ )
	hGetVREG( vr, vr_dtype, vr_dclass, vr_typ )

	hLoadIDX( v1 )
	hLoadIDX( vr )

    ''
    if ( vr <> NULL ) then
		if( v1 <> vr ) then
			'' handle longint
			if( ISLONGINT( vr_dtype ) ) then
				va = vr->vaux
				regTB(vr_dclass)->ensure( regTB(vr_dclass), va, vr, typeGetSize( FB_DATATYPE_INTEGER ) )
				vr_dtype = FB_DATATYPE_INTEGER
			end if
			regTB(vr_dclass)->ensure( regTB(vr_dclass), vr, NULL, typeGetSize( vr_dtype ) )
		end if
	end if

	'' UOP to self? x86 assumption at AST
	if( vr <> NULL ) then
		'' handle longint
		if( ISLONGINT( v1_dtype ) ) then
			va = v1->vaux
			regTB(v1_dclass)->ensure( regTB(v1_dclass), va, v1, typeGetSize( FB_DATATYPE_INTEGER ) )
			v1_dtype = FB_DATATYPE_INTEGER
		end if

		if( op = AST_OP_SWZ_REPEAT ) then
			'' v1 must be loaded as a scalar
			v1->vector = 0
		end if

		regTB(v1_dclass)->ensure( regTB(v1_dclass), v1, NULL, typeGetSize( v1_dtype ) )

		if( op = AST_OP_SWZ_REPEAT ) then
			v1->vector = v1vector
		end if
	end if

	''
	select case as const op
	case AST_OP_NEG
		emitNEG( v1 )
	case AST_OP_NOT
		emitNOT( v1 )

	case AST_OP_HADD
		emitHADD( v1 )
		v1->vector = 0

	case AST_OP_ABS
		emitABS( v1 )
	case AST_OP_SGN
		emitSGN( v1 )
	case AST_OP_FIX
		emitFIX( v1 )
	case AST_OP_FRAC
		emitFRAC( v1 )
	case AST_OP_CONVFD2FS
		emitCONVFD2FS( v1 )

	case AST_OP_SIN
		emitSIN( v1 )
	case AST_OP_ASIN
		emitASIN( v1 )
	case AST_OP_COS
		emitCOS( v1 )
	case AST_OP_ACOS
		emitACOS( v1 )
	case AST_OP_TAN
		emitTAN( v1 )
	case AST_OP_ATAN
		emitATAN( v1 )
	case AST_OP_SQRT
		emitSQRT( v1 )
	case AST_OP_RSQRT
		emitRSQRT( v1 )
	case AST_OP_RCP
		emitRCP( v1 )
	case AST_OP_LOG
		emitLOG( v1 )
	case AST_OP_EXP
		emitEXP( v1 )
	case AST_OP_FLOOR
		emitFLOOR( v1 )

	case AST_OP_SWZ_REPEAT
		emitSWZREP( v1 )

	end select

    ''
    if ( vr <> NULL ) then
		if( v1 <> vr ) then
			emitMOV( vr, v1 )
		end if
	end if

    ''
	hFreeREG( v1 )
	hFreeREG( vr )

end sub

'':::::
private sub hFlushBOP _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr, _
		byval vr as IRVREG ptr _
	) static

	dim as integer v1_typ, v1_dtype, v1_dclass
	dim as integer v2_typ, v2_dtype, v2_dclass
	dim as integer vr_typ, vr_dtype, vr_dclass
	dim as IRVREG ptr va

	''
	hGetVREG( v1, v1_dtype, v1_dclass, v1_typ )
	hGetVREG( v2, v2_dtype, v2_dclass, v2_typ )
	hGetVREG( vr, vr_dtype, vr_dclass, vr_typ )

	hLoadIDX( v1 )
	hLoadIDX( v2 )
	hLoadIDX( vr )

	'' BOP to self? (x86 assumption at AST)
	if( vr = NULL ) then
		if( v2_typ <> IR_VREGTYPE_IMM ) then		'' x86 assumption
			'' handle longint
			if( ISLONGINT( v2_dtype ) ) then
				va = v2->vaux
				regTB(v2_dclass)->ensure( regTB(v2_dclass), va, v2, typeGetSize( FB_DATATYPE_INTEGER ) )
				v2_dtype = FB_DATATYPE_INTEGER
			end if
			regTB(v2_dclass)->ensure( regTB(v2_dclass), v2, NULL, typeGetSize( v2_dtype ) )
		end if
	else
		if( v2_typ = IR_VREGTYPE_REG ) then			'' x86 assumption
			'' handle longint
			if( ISLONGINT( v2_dtype ) ) then
				va = v2->vaux
				regTB(v2_dclass)->ensure( regTB(v2_dclass), va, v2, typeGetSize( FB_DATATYPE_INTEGER ) )
				v2_dtype = FB_DATATYPE_INTEGER
			end if
			regTB(v2_dclass)->ensure( regTB(v2_dclass), v2, NULL, typeGetSize( v2_dtype ) )
		end if

		'' destine allocation comes *after* source, 'cause the x86 FPU stack
		'' handle longint
		if( ISLONGINT( v1_dtype ) ) then
			va = v1->vaux
			regTB(v1_dclass)->ensure( regTB(v1_dclass), va, v1, typeGetSize( FB_DATATYPE_INTEGER ) )
			v1_dtype = FB_DATATYPE_INTEGER
		end if
		regTB(v1_dclass)->ensure( regTB(v1_dclass), v1, NULL, typeGetSize( v1_dtype ) )
	end if

    ''
	select case as const op
	case AST_OP_ADD
		emitADD( v1, v2 )
	case AST_OP_SUB
		emitSUB( v1, v2 )
	case AST_OP_MUL
		emitMUL( v1, v2 )
	case AST_OP_DIV
        emitDIV( v1, v2 )
	case AST_OP_INTDIV
        emitINTDIV( v1, v2 )
	case AST_OP_MOD
		emitMOD( v1, v2 )

	case AST_OP_SHL
		emitSHL( v1, v2 )
	case AST_OP_SHR
		emitSHR( v1, v2 )

	case AST_OP_AND
		emitAND( v1, v2 )
	case AST_OP_OR
		emitOR( v1, v2 )
	case AST_OP_XOR
		emitXOR( v1, v2 )
	case AST_OP_EQV
		emitEQV( v1, v2 )
	case AST_OP_IMP
		emitIMP( v1, v2 )

	case AST_OP_ATAN2
        emitATN2( v1, v2 )
    case AST_OP_POW
    	emitPOW( v1, v2 )
	end select

    '' not BOP to self?
	if ( vr <> NULL ) then
		'' result not equal destine? (can happen with DAG optimizations)
		if( (v1 <> vr) ) then
			'' handle longint
			if( ISLONGINT( vr_dtype ) ) then
				va = vr->vaux
				regTB(vr_dclass)->ensure( regTB(vr_dclass), va, vr, typeGetSize( FB_DATATYPE_INTEGER ) )
				vr_dtype = FB_DATATYPE_INTEGER
			end if
			regTB(vr_dclass)->ensure( regTB(vr_dclass), vr, NULL, typeGetSize( vr_dtype ) )
			emitMOV( vr, v1 )
		end if
	end if

    ''
	hFreeREG( v1 )
	hFreeREG( v2 )
	hFreeREG( vr )

end sub

'':::::
private sub hFlushCOMP _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr, _
		byval vr as IRVREG ptr, _
		byval label as FBSYMBOL ptr _
	) static

	dim as string lname
	dim as integer v1_typ, v1_dtype, v1_dclass
	dim as integer v2_typ, v2_dtype, v2_dclass
	dim as integer vr_typ, vr_dtype, vr_dclass
	dim as IRVREG ptr va
	dim as integer doload

	''
	hGetVREG( v1, v1_dtype, v1_dclass, v1_typ )
	hGetVREG( v2, v2_dtype, v2_dclass, v2_typ )
	hGetVREG( vr, vr_dtype, vr_dclass, vr_typ )

	hLoadIDX( v1 )
	hLoadIDX( v2 )
	hLoadIDX( vr )

	'' load source if it's a reg, or if result was not allocated
	doload = FALSE
	if( vr = NULL ) then							'' x86 assumption
		if( v2_dclass = FB_DATACLASS_INTEGER ) then	'' /
			if( v2_typ <> IR_VREGTYPE_IMM ) then	'' /
				if( v1_dclass <> FB_DATACLASS_FPOINT ) then
					doload = TRUE
				end if
			end if
		end if
	end if

	if( (v2_typ = IR_VREGTYPE_REG) or doload ) then
		'' handle longint
		if( ISLONGINT( v2_dtype ) ) then
			va = v2->vaux
			regTB(v2_dclass)->ensure( regTB(v2_dclass), va, v2, typeGetSize( FB_DATATYPE_INTEGER ) )
			v2_dtype = FB_DATATYPE_INTEGER
		end if
		regTB(v2_dclass)->ensure( regTB(v2_dclass), v2, NULL, typeGetSize( v2_dtype ) )
		v2_typ = IR_VREGTYPE_REG
	end if

	'' destine allocation comes *after* source, 'cause the FPU stack
	doload = FALSE
	if( (vr <> NULL) and (vr = v1) ) then			'' x86 assumption
		doload = TRUE
	elseif( v1_dclass = FB_DATACLASS_FPOINT ) then	'' /
		doload = TRUE
	elseif( v1_typ = IR_VREGTYPE_IMM) then          '' /
		doload = TRUE
	elseif( v2_typ <> IR_VREGTYPE_REG ) then        '' /
		if( v2_typ <> IR_VREGTYPE_IMM ) then
			doload = TRUE
		end if
	elseif( v1_typ = IR_VREGTYPE_OFS ) then
		doload = TRUE
	end if

	if( (v1_typ = IR_VREGTYPE_REG) or doload ) then
		'' handle longint
		if( ISLONGINT( v1_dtype ) ) then
			va = v1->vaux
			regTB(v1_dclass)->ensure( regTB(v1_dclass), va, v1, typeGetSize( FB_DATATYPE_INTEGER ) )
			v1_dtype = FB_DATATYPE_INTEGER
		end if
		regTB(v1_dclass)->ensure( regTB(v1_dclass), v1, NULL, typeGetSize( v1_dtype ) )
	end if

	'' result not equal destine? (can happen with DAG optimizations and floats comparations)
	if( vr <> NULL ) then
		if( vr <> v1 ) then
			vr->reg = regTB(vr_dclass)->_allocate( regTB(vr_dclass), vr, NULL, typeGetSize( vr_dtype ) )
			vr->typ = IR_VREGTYPE_REG
		end if
	end if

	''
	select case as const op
	case AST_OP_EQ
		emitEQ( vr, label, v1, v2 )
	case AST_OP_NE
		emitNE( vr, label, v1, v2 )
	case AST_OP_GT
		emitGT( vr, label, v1, v2 )
	case AST_OP_LT
		emitLT( vr, label, v1, v2 )
	case AST_OP_LE
		emitLE( vr, label, v1, v2 )
	case AST_OP_GE
		emitGE( vr, label, v1, v2 )
	end select

    ''
	hFreeREG( v1 )
	hFreeREG( v2 )
	if( vr <> NULL ) then
		hFreeREG( vr )
	end if

end sub

private sub hSpillRegs( )
	dim as IRVREG ptr vr = any, vauxparent = any
	dim as integer reg = any

	'' for each reg class
	for class_ as integer = 0 to EMIT_REGCLASSES-1
		'' for each register on that class
		reg = regTB(class_)->getFirst( regTB(class_) )
		do until( reg = INVALID )
			'' if not free
			if( regTB(class_)->isFree( regTB(class_), reg ) = FALSE ) then
				'' get the attached vreg
				vr = regTB(class_)->getVreg( regTB(class_), reg, vauxparent )
				assert( irIsREG( vr ) )
				assert( vr->reg = reg )

				'' spill
				irStoreVR( vr, vauxparent )
			end if

			'' next reg
			reg = regTB(class_)->getNext( regTB(class_), reg )
		loop
	next
end sub

'':::::
private sub hFlushSTORE _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr _
	) static

	dim as integer v1_typ, v1_dtype, v1_dclass
	dim as integer v2_typ, v2_dtype, v2_dclass
	dim as IRVREG ptr va

	''
	if( op = AST_OP_SPILLREGS ) then
		hSpillRegs( )
		exit sub
	end if

	''
	hGetVREG( v1, v1_dtype, v1_dclass, v1_typ )
	hGetVREG( v2, v2_dtype, v2_dclass, v2_typ )

	hLoadIDX( v1 )
	hLoadIDX( v2 )

    '' if dst is a fpoint, only load src if its a reg (x86 assumption)
	if( (v2_typ = IR_VREGTYPE_REG) or _
		((v2_typ <> IR_VREGTYPE_IMM) and (v1_dclass = FB_DATACLASS_INTEGER)) ) then
		'' handle longint
		if( ISLONGINT( v2_dtype ) ) then
			va = v2->vaux
			regTB(v2_dclass)->ensure( regTB(v2_dclass), va, v2, typeGetSize( FB_DATATYPE_INTEGER ) )
			v2_dtype = FB_DATATYPE_INTEGER
		end if
		regTB(v2_dclass)->ensure( regTB(v2_dclass), v2, NULL, typeGetSize( v2_dtype ) )
	end if

	''
	emitSTORE( v1, v2 )

    ''
	hFreeREG( v1 )
	hFreeREG( v2 )

end sub

'':::::
private sub hFlushLOAD _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval vr as IRVREG ptr _
	) static

	dim as integer v1_typ, v1_dtype, v1_dclass, v1_reg
	dim as IRVREG ptr va

	''
	hGetVREG( v1, v1_dtype, v1_dclass, v1_typ )

	hLoadIDX( v1 )

	''
	select case op
	case AST_OP_LOAD
		'' handle longint
		if( ISLONGINT( v1_dtype ) ) then
			va = v1->vaux
			regTB(v1_dclass)->ensure( regTB(v1_dclass), va, v1, typeGetSize( FB_DATATYPE_INTEGER ) )
			v1_dtype = FB_DATATYPE_INTEGER
		end if
		regTB(v1_dclass)->ensure( regTB(v1_dclass), v1, NULL, typeGetSize( v1_dtype ) )

	case AST_OP_LOADRES
		if( v1_typ = IR_VREGTYPE_REG ) then
			'' handle longint
			if( ISLONGINT( v1_dtype ) ) then
				va = v1->vaux
				regTB(v1_dclass)->ensure( regTB(v1_dclass), va, v1, typeGetSize( FB_DATATYPE_INTEGER ) )
				'' can't change v1_dtype
				v1_reg = regTB(v1_dclass)->ensure( regTB(v1_dclass), v1, NULL, typeGetSize( FB_DATATYPE_INTEGER ) )
			else
				v1_reg = regTB(v1_dclass)->ensure( regTB(v1_dclass), v1, NULL, typeGetSize( v1_dtype ) )
			end if
		else
			v1_reg = INVALID
		end if

		dim as integer vr_reg, vr_reg2

		emitGetResultReg( v1_dtype, v1_dclass, vr_reg, vr_reg2 )

		if( vr_reg <> v1_reg ) then
			'' handle longint
			if( ISLONGINT( v1_dtype ) ) then
				va = vr->vaux
				va->reg = regTB(v1_dclass)->allocateReg( regTB(v1_dclass), vr_reg2, va, vr )
				va->typ = IR_VREGTYPE_REG
			end if

			vr->reg = regTB(v1_dclass)->allocateReg( regTB(v1_dclass), vr_reg, vr, NULL )
			vr->typ = IR_VREGTYPE_REG

			'' decide where to put the float (st(0) or xmm0) at the end of the function
			if( ast.proc.curr->sym->proc.returnMethod <> FB_RETURN_SSE ) then
				vr->regFamily = IR_REG_FPU_STACK
			end if

			''
			emitLOAD( vr, v1 )

			''
			hFreeREG( vr )						'' assuming this is the last operation
		end if
    end select

	''
	hFreeREG( v1 )

end sub

'':::::
private sub hFlushCONVERT _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr _
	) static

	dim as integer v1_typ, v1_dtype, v1_dclass
	dim as integer v2_typ, v2_dtype, v2_dclass
	dim as integer reuse
	dim as IRVREG ptr va

	''
	hGetVREG( v1, v1_dtype, v1_dclass, v1_typ )
	hGetVREG( v2, v2_dtype, v2_dclass, v2_typ )

	hLoadIDX( v1 )
	hLoadIDX( v2 )

    '' x86 assumption: if src is a reg and if classes are the same and
    ''                 src won't be used (DAG?), reuse src
	reuse = FALSE
	if( (v1_dclass = v2_dclass) and (v2_typ = IR_VREGTYPE_REG) ) then

		'' fp to fp conversion with source already on stack? do nothing..
		if( v2_dclass = FB_DATACLASS_FPOINT ) then
			if( irGetOption( IR_OPT_FPUCONV ) ) then
				v1->regFamily = v2->regFamily
				if( v2->regFamily = IR_REG_FPU_STACK ) then exit sub
			else
				v1->reg = v2->reg
				v2->reg = INVALID
				v1->typ = IR_VREGTYPE_REG
				regTB(v1_dclass)->setOwner( regTB(v1_dclass), v1->reg, v1, NULL )
				exit sub
			end if
		end if

		'' it's an integer, check if used again
		if( irGetDistance( v2 ) = IR_MAXDIST ) then
			'' don't reuse if any operand is a byte (because [E]SI/[E]DI) or longint
			select case typeGetSize( v1_dtype )
			case 1, 8

			case else
				select case typeGetSize( v2_dtype )
				case 1, 8

				case else
					reuse = TRUE
				end select
			end select
		end if
	end if

	if( reuse ) then
		v1->reg = v2->reg
		v1->typ = IR_VREGTYPE_REG
		regTB(v1_dclass)->setOwner( regTB(v1_dclass), v1->reg, v1, NULL )
	else
		if( v2_typ = IR_VREGTYPE_REG ) then			'' x86 assumption
			'' handle longint
			if( ISLONGINT( v2_dtype ) ) then
				va = v2->vaux
				regTB(v2_dclass)->ensure( regTB(v2_dclass), va, v2, typeGetSize( FB_DATATYPE_INTEGER ) )
				v2_dtype = FB_DATATYPE_INTEGER
			end if
			regTB(v2_dclass)->ensure( regTB(v2_dclass), v2, NULL, typeGetSize( v2_dtype ) )
		end if

		'' handle longint
		if( ISLONGINT( v1_dtype ) ) then
			va = v1->vaux
			va->reg = regTB(v1_dclass)->_allocate( regTB(v1_dclass), va, v1, typeGetSize( FB_DATATYPE_INTEGER ) )
			va->typ = IR_VREGTYPE_REG
			v1_dtype = FB_DATATYPE_INTEGER
		end if
		v1->reg = regTB(v1_dclass)->_allocate( regTB(v1_dclass), v1, NULL, typeGetSize( v1_dtype ) )
		v1->typ = IR_VREGTYPE_REG
	end if

	''
	emitLOAD( v1, v2 )

	''
	if( reuse = FALSE ) then
		hFreeREG( v2 )
	else
		v2->reg = INVALID
	end if

	''
	hFreeREG( v1 )

end sub

'':::::
private sub hFlushADDR _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval vr as IRVREG ptr _
	) static

	dim as integer v1_typ, v1_dtype, v1_dclass
	dim as integer vr_typ, vr_dtype, vr_dclass

	''
	hGetVREG( v1, v1_dtype, v1_dclass, v1_typ )
	hGetVREG( vr, vr_dtype, vr_dclass, vr_typ )

	hLoadIDX( v1 )
	hLoadIDX( vr )

	''
	if( v1_typ = IR_VREGTYPE_REG ) then				'' x86 assumption
		regTB(v1_dclass)->ensure( regTB(v1_dclass), v1, NULL, typeGetSize( v1_dtype ) )
	end if

	if( vr_typ = IR_VREGTYPE_REG ) then             '' x86 assumption
		regTB(vr_dclass)->ensure( regTB(vr_dclass), vr, NULL, typeGetSize( vr_dtype ) )
	end if

	''
	select case op
	case AST_OP_ADDROF
		emitADDROF( vr, v1 )
	case AST_OP_DEREF
		emitDEREF( vr, v1 )
	end select

    ''
	hFreeREG( v1 )
	hFreeREG( vr )

end sub

'':::::
private sub hFlushMEM _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr, _
		byval bytes as integer, _
		byval extra as any ptr _
	) static

	''
	hLoadIDX( v1 )
	hLoadIDX( v2 )

	''
	select case as const op
	case AST_OP_MEMMOVE
		emitMEMMOVE( v1, v2, bytes )

	case AST_OP_MEMSWAP
		emitMEMSWAP( v1, v2, bytes )

	case AST_OP_MEMCLEAR
		emitMEMCLEAR( v1, v2 )

	case AST_OP_STKCLEAR
		emitSTKCLEAR( bytes, cint( extra ) )
	end select

    ''
	hFreeREG( v1 )
	hFreeREG( v2 )

end sub

'':::::
private sub hFlushDBG _
	( _
		byval op as integer, _
		byval proc as FBSYMBOL ptr, _
		byval ex as integer _
	)

	select case as const op
	case AST_OP_DBG_LINEINI
		emitDBGLineBegin( proc, ex )

	case AST_OP_DBG_LINEEND
		emitDBGLineEnd( proc, ex )

	case AST_OP_DBG_SCOPEINI
		emitDBGScopeBegin( cast( FBSYMBOL ptr, ex ) )

	case AST_OP_DBG_SCOPEEND
		emitDBGScopeEnd( cast( FBSYMBOL ptr, ex ) )
	end select

end sub

private sub hFlushLIT( byval op as integer, byval text as zstring ptr )
	select case op
	case AST_OP_LIT_COMMENT
		emitComment( text )
	case AST_OP_LIT_ASM
		emitASM( text )
	end select

	ZstrFree( text )
end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub hFreeIDX _
	( _
		byval vreg as IRVREG ptr, _
		byval force as integer = FALSE _
	)

	dim as IRVREG ptr vidx

	if( vreg = NULL ) then
		exit sub
	end if

	vidx = vreg->vidx
    if( vidx <> NULL ) then
    	if( vidx->reg <> INVALID ) then
    		hFreeREG( vidx, force )				'' recursively
    		vreg->vidx = NULL
		end if
	end if

end sub

'':::::
private sub hFreeREG _
	( _
		byval vreg as IRVREG ptr, _
		byval force as integer = FALSE _
	)

	dim as integer dclass, dist
	dim as IRVREG ptr vaux

	if( vreg = NULL ) then
		exit sub
	end if

	'' free any attached index
	hFreeIDX( vreg, force )

    ''
	if( vreg->typ <> IR_VREGTYPE_REG ) then
		exit sub
	end if

	if( vreg->reg = INVALID ) then
		exit sub
	end if

	''
	dist = IR_MAXDIST
	if( force = FALSE ) then
		dist = irGetDistance( vreg )
	end if

	if( dist = IR_MAXDIST ) then
		'' aux?
		if( vreg->vaux <> NULL ) then
			vaux = vreg->vaux
			if( vaux->reg <> INVALID ) then
				hFreeREG( vaux, TRUE )
			end if
		end if

		dclass = typeGetClass(vreg->dtype)
		regTB(dclass)->free( regTB(dclass), vreg->reg )
		vreg->reg = INVALID
	end if

end sub

'':::::
private function _GetDistance _
	( _
		byval vreg as IRVREG ptr _
	) as uinteger

    dim as IRVREG ptr v
    dim as IRTAC ptr t
    dim as integer dist

	if( vreg = NULL ) then
		return IR_MAXDIST
	end if

	'' skip the current tac
	t = flistGetNext( ctx.tacidx )

	'' eol?
	if( t = NULL ) then
		return IR_MAXDIST
	end if

	''
	dist = vreg->taclast->pos - t->pos

	'' not used anymore?
	if( dist < 0 ) then
		function = IR_MAXDIST
	else
		function = dist
	end if

end function

private sub _loadVR _
	( _
		byval reg as integer, _
		byval vreg as IRVREG ptr, _
		byval vauxparent as IRVREG ptr _
	)

	dim as IRVREG rvreg

	if( vreg->typ <> IR_VREGTYPE_REG ) then
		'' Don't load aux vregs now - they'll be loaded when their
		'' parent vreg is loaded
		if( vauxparent = NULL ) then
			rvreg.typ 	= IR_VREGTYPE_REG
			rvreg.dtype = vreg->dtype
			rvreg.reg	= reg
			rvreg.vaux	= vreg->vaux
			rvreg.regFamily = vreg->regFamily
			emitLOAD( @rvreg, vreg )
		end if

    	'' free any attached reg, forcing if needed
    	hFreeIDX( vreg, TRUE )

    	vreg->typ = IR_VREGTYPE_REG
    end if

	vreg->reg = reg

	if( (env.clopt.fputype >= FB_FPUTYPE_SSE) and (vauxparent <> NULL) ) then
		vreg->regFamily = IR_REG_SSE
	end if

end sub

private sub _storeVR _
	( _
		byval vreg as IRVREG ptr, _
		byval vauxparent as IRVREG ptr _
	)

	dim as IRVREG origvreg = any, origvaux = any
	dim as integer vr_dclass = any

	if( vauxparent ) then
		assert( vauxparent->vaux = vreg )
		vreg = vauxparent
	end if

	'' Store a REG vreg into a temp var on stack (spilling registers)
	'' If this is a LONGINT vreg or the vaux of a LONGINT vreg, then the
	'' whole qword (both vregs) should be spilled, not just one dword.
	'' This way we ensure to always keep the two dwords together, either
	'' both in registers or both in consecutive memory.
	'' This also allows us to free up the registers used by the vreg(s).

	assert( irIsREG( vreg ) )
	assert( iif( vreg->vaux, irIsREG( vreg->vaux ), TRUE ) )

	'' Back up the old vreg
	origvreg = *vreg
	if( ISLONGINT( vreg->dtype ) ) then
		'' Back up the old vaux too
		origvaux = *vreg->vaux
		origvreg.vaux = @origvaux
	end if

	if( irGetDistance( vreg ) <> IR_MAXDIST ) then
		'' Turn the old vreg into a VAR
		vreg->typ = IR_VREGTYPE_VAR
		vreg->sym = symbAddAndAllocateTempVar( vreg->dtype )
		vreg->ofs = symbGetOfs( vreg->sym )
		vreg->reg = INVALID
		if( ISLONGINT( vreg->dtype ) ) then
			'' Turn the old vaux into a VAR
			vreg->vaux->reg = INVALID
			vreg->vaux->typ = IR_VREGTYPE_VAR
			vreg->vaux->ofs = vreg->ofs + 4  '' vaux = the upper 4 bytes
		end if
		if( env.clopt.fputype >= FB_FPUTYPE_SSE ) then
			vreg->regFamily = IR_REG_SSE
		end if

		'' Copy data from old vreg into new VAR vreg
		emitSTORE( vreg, @origvreg )
	end if

	if( ISLONGINT( origvreg.dtype ) ) then
		regTB(FB_DATACLASS_INTEGER)->free( regTB(FB_DATACLASS_INTEGER), origvaux.reg )
	end if
	vr_dclass = typeGetClass( origvreg.dtype )
	regTB(vr_dclass)->free( regTB(vr_dclass), origvreg.reg )

end sub

'':::::
private sub _xchgTOS _
	( _
		byval reg as integer _
	) static

    dim as IRVREG rvreg

	rvreg.typ 	= IR_VREGTYPE_REG
	rvreg.dtype = FB_DATATYPE_DOUBLE
	rvreg.reg	= reg

	emitXchgTOS( @rvreg )

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

dim shared as IR_VTBL irtac_vtbl = _
( _
	@_init, _
	@_end, _
	@_emitBegin, _
	@_emitEnd, _
	@_getOptionValue, _
	NULL, _  '' supportsOp() unimplemented, because the ASM backend supports all ops anyways, and doesn't use IR_OPT_MISSINGOPS
	@_procBegin, _
	@_procEnd, _
	@_procAllocArg, _
	@_procAllocLocal, _
	@_procGetFrameRegName, _
	@_scopeBegin, _
	@_scopeEnd, _
	@_procAllocStaticVars, _
	@_emitConvert, _
	@_emitLabel, _
	@_emitLabelNF, _
	@_emitReturn, _
	@_emitProcBegin, _
	@_emitProcEnd, _
	@_emitPushArg, _
	@_emitAsmLine, _
	@_emitComment, _
	@_emitBop, _
	@_emitUop, _
	@_emitStore, _
	@_emitSpillRegs, _
	@_emitLoad, _
	@_emitLoadRes, _
	@_emitStack, _
	@_emitAddr, _
	@_emitCall, _
	@_emitCallPtr, _
	@_emitStackAlign, _
	@_emitJumpPtr, _
	@_emitBranch, _
	@_emitJmpTb, _
	@_emitMem, _
	@_emitScopeBegin, _
	@_emitScopeEnd, _
	@_emitDECL, _
	@_emitDBG, _
	@_emitVarIniBegin, _
	@_emitVarIniEnd, _
	@_emitVarIniI, _
	@_emitVarIniF, _
	@_emitVarIniOfs, _
	@_emitVarIniStr, _
	@_emitVarIniWstr, _
	@_emitVarIniPad, _
	@_emitVarIniScopeBegin, _
	@_emitVarIniScopeEnd, _
	@_emitFbctinfBegin, _
	@_emitFbctinfString, _
	@_emitFbctinfEnd, _
	@_allocVreg, _
	@_allocVrImm, _
	@_allocVrImmF, _
	@_allocVrVar, _
	@_allocVrIdx, _
	@_allocVrPtr, _
	@_allocVrOfs, _
	@_setVregDataType, _
	@_getDistance, _
	@_loadVr, _
	@_storeVr, _
	@_xchgTOS _
)
