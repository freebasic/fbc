#ifndef __IR_BI__
#define __IR_BI__

#include once "ast-op.bi"

const IR_INITADDRNODES      = 2048
const IR_INITVREGNODES      = IR_INITADDRNODES*3

const IR_MAXDIST            = 2147483647
const IR_INVALIDDIST        = -1

'' when changing, update vregDumpToStr():vregtypes()
enum IRVREGTYPE_ENUM
	IR_VREGTYPE_IMM
	IR_VREGTYPE_VAR
	IR_VREGTYPE_IDX
	IR_VREGTYPE_PTR
	IR_VREGTYPE_REG
	IR_VREGTYPE_OFS
end enum

'' sections
enum IR_SECTION
	IR_SECTION_CONST
	IR_SECTION_DATA
	IR_SECTION_BSS
	IR_SECTION_CODE
	IR_SECTION_DIRECTIVE
	IR_SECTION_CONSTRUCTOR
	IR_SECTION_DESTRUCTOR
	IR_SECTION_INFO
end enum

enum IR_REGFAMILY
	IR_REG_FPU_STACK
	IR_REG_SSE
end enum

enum IR_OPTIONVALUE
	IR_OPTIONVALUE_MAXMEMBLOCKLEN               = 1
end enum


''
type IRVREG_ as IRVREG
type IRTAC_ as IRTAC

type IRTACVREG
	vreg        as IRVREG_ ptr
	parent      as IRVREG_ ptr  '' pointer to parent if idx or aux
	next        as IRTACVREG ptr                '' next in tac (-> vr, v1 or v2)
end type

type IRTACVREG_GRP
	reg         as IRTACVREG
	idx         as IRTACVREG                    '' index
	aux         as IRTACVREG                    '' auxiliary
end type

type IRTAC
	pos         as integer

	op          as AST_OP                       '' opcode

	vr          as IRTACVREG_GRP                '' result
	v1          as IRTACVREG_GRP                '' operand 1
	v2          as IRTACVREG_GRP                '' operand 2

	ex1         as FBSYMBOL ptr                 '' extra field, used by call/jmp
	ex2         as integer                      '' /
	ex3         as zstring ptr                  '' filename, used by DBG
end type

type IRVREG
	typ         as IRVREGTYPE_ENUM              '' VAR, IMM, IDX, etc

	dtype       as FB_DATATYPE                  '' CHAR, INTEGER, ...
	subtype     as FBSYMBOL ptr

	reg         as integer                      '' reg
	regFamily       as IR_REGFAMILY
	vector      as integer

	value       as FBVALUE                      '' imm value (hi-word of longint's at vaux->value)

	sym         as FBSYMBOL ptr                 '' symbol
	ofs         as longint                  '' +offset
	mult        as integer                      '' multipler, only valid for IDX and PTR under ir-tac

	vidx        as IRVREG ptr                   '' index vreg
	vaux        as IRVREG ptr                   '' aux vreg (used with longint's)

	tacvhead    as IRTACVREG ptr                '' back-link to tac table
	tacvtail    as IRTACVREG ptr                '' /
	taclast     as IRTAC ptr                    '' /
end type

enum AST_ASMTOKTYPE
	AST_ASMTOK_TEXT
	AST_ASMTOK_SYMB
end enum

type ASTASMTOK
	type        as AST_ASMTOKTYPE
	union
		sym as FBSYMBOL ptr
		text    as zstring ptr
	end union
	next        as ASTASMTOK ptr
end type

'' if changed, update the _vtbl symbols at ir-*.bas::*_ctor
type IR_VTBL
	init as sub( )
	end as sub( )

	emitBegin as function _
	( _
	) as integer

	emitEnd as sub( )

	getOptionValue as function _
	( _
		byval opt as IR_OPTIONVALUE _
	) as integer

	supportsOp as function _
	( _
		byval op as integer, _
		byval dtype as integer _
	) as integer

	procBegin as sub _
	( _
		byval proc as FBSYMBOL ptr _
	)

	procEnd as sub _
	( _
		byval proc as FBSYMBOL ptr _
	)

	procAllocArg as sub _
	( _
		byval proc as FBSYMBOL ptr, _
		byval sym as FBSYMBOL ptr _
	)

	procAllocLocal as sub _
	( _
		byval proc as FBSYMBOL ptr, _
		byval sym as FBSYMBOL ptr _
	)

	procGetFrameRegName as function _
	( _
	) as const zstring ptr

	scopeBegin as sub _
	( _
		byval s as FBSYMBOL ptr _
	)

	scopeEnd as sub _
	( _
		byval s as FBSYMBOL ptr _
	)

	procAllocStaticVars as sub( byval head_sym as FBSYMBOL ptr )

	emitConvert as sub( byval v1 as IRVREG ptr, byval v2 as IRVREG ptr )

	emitLabel as sub _
	( _
		byval label as FBSYMBOL ptr _
	)

	emitLabelNF as sub _
	( _
		byval l as FBSYMBOL ptr _
	)

	emitReturn as sub _
	( _
		byval bytestopop as integer _
	)

	emitProcBegin as sub _
	( _
		byval proc as FBSYMBOL ptr, _
		byval initlabel as FBSYMBOL ptr _
	)

	emitProcEnd as sub _
	( _
		byval proc as FBSYMBOL ptr, _
		byval initlabel as FBSYMBOL ptr, _
		byval exitlabel as FBSYMBOL ptr _
	)

	emitPushArg as sub _
	( _
		byval param as FBSYMBOL ptr, _
		byval vr as IRVREG ptr, _
		byval udtlen as longint, _
		byval level as integer, _
		byval lreg as IRVREG ptr _
	)

	emitAsmLine as sub( byval asmtokenhead as ASTASMTOK ptr )

	emitComment as sub _
	( _
		byval text as zstring ptr _
	)

	emitBop as sub _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr, _
		byval vr as IRVREG ptr, _
		byval label as FBSYMBOL ptr _
	)

	emitUop as sub _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval vr as IRVREG ptr _
	)

	emitStore as sub( byval v1 as IRVREG ptr, byval v2 as IRVREG ptr )

	emitSpillRegs as sub _
	( _
	)

	emitLoad as sub _
	( _
		byval v1 as IRVREG ptr _
	)

	emitLoadRes as sub _
	( _
		byval v1 as IRVREG ptr, _
		byval vr as IRVREG ptr _
	)

	emitStack as sub _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr _
	)

	emitAddr as sub _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval vr as IRVREG ptr _
	)

	emitCall as sub _
	( _
		byval proc as FBSYMBOL ptr, _
		byval bytestopop as integer, _
		byval vr as IRVREG ptr, _
		byval level as integer _
	)

	emitCallPtr as sub _
	( _
		byval proc as FBSYMBOL ptr, _
		byval v1 as IRVREG ptr, _
		byval vr as IRVREG ptr, _
		byval bytestopop as integer, _
		byval level as integer _
	)

	emitStackAlign as sub _
	( _
		byval bytes as integer _
	)

	emitJumpPtr as sub( byval v1 as IRVREG ptr )
	emitBranch as sub( byval op as integer, byval label as FBSYMBOL ptr )

	emitJmpTb as sub _
	( _
		byval v1 as IRVREG ptr, _
		byval tbsym as FBSYMBOL ptr, _
		byval values as ulongint ptr, _
		byval labels as FBSYMBOL ptr ptr, _
		byval labelcount as integer, _
		byval deflabel as FBSYMBOL ptr, _
		byval bias as ulongint, _
		byval span as ulongint _
	)

	emitMem as sub _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr, _
		byval bytes as longint _
	)

	emitMacro as sub _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr, _
		byval vr as IRVREG ptr _
	)

	emitScopeBegin as sub _
	( _
		byval s as FBSYMBOL ptr _
	)

	emitScopeEnd as sub _
	( _
		byval s as FBSYMBOL ptr _
	)

	emitDECL as sub( byval sym as FBSYMBOL ptr )

	emitDBG as sub _
	( _
		byval op as integer, _
		byval proc as FBSYMBOL ptr, _
		byval ex as integer, _
		byval filename As zstring ptr = 0 _
	)

	emitVarIniBegin as sub( byval sym as FBSYMBOL ptr )
	emitVarIniEnd as sub( byval sym as FBSYMBOL ptr )
	emitVarIniI   as sub( byval sym as FBSYMBOL ptr, byval value as longint )
	emitVarIniF   as sub( byval sym as FBSYMBOL ptr, byval value as double )
	emitVarIniOfs as sub _
	( _
		byval sym as FBSYMBOL ptr, _
		byval rhs as FBSYMBOL ptr, _
		byval ofs as longint _
	)

	emitVarIniStr as sub _
	( _
		byval totlgt as longint, _
		byval litstr as zstring ptr, _
		byval litlgt as longint _
	)

	emitVarIniWstr as sub _
	( _
		byval totlgt as longint, _
		byval litstr as wstring ptr, _
		byval litlgt as longint _
	)

	emitVarIniPad as sub( byval bytes as longint )
	emitVarIniScopeBegin as sub( byval sym as FBSYMBOL ptr, byval is_array as integer )
	emitVarIniScopeEnd as sub( )

	emitFbctinfBegin as sub( )
	emitFbctinfString as sub( byval s as const zstring ptr )
	emitFbctinfEnd as sub( )

	allocVreg as function _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as IRVREG ptr

	allocVrImm as function _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval value as longint _
	) as IRVREG ptr

	allocVrImmF as function _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval value as double _
	) as IRVREG ptr

	allocVrVar as function _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval symbol as FBSYMBOL ptr, _
		byval ofs as longint _
	) as IRVREG ptr

	allocVrIdx as function _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval symbol as FBSYMBOL ptr, _
		byval ofs as longint, _
		byval mult as integer, _
		byval vidx as IRVREG ptr _
	) as IRVREG ptr

	allocVrPtr as function _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval ofs as longint, _
		byval vidx as IRVREG ptr _
	) as IRVREG ptr

	allocVrOfs as function _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval symbol as FBSYMBOL ptr, _
		byval ofs as longint _
	) as IRVREG ptr

	setVregDataType as sub _
	( _
		byval vreg as IRVREG ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	)

	getDistance as function _
	( _
		byval vreg as IRVREG ptr _
	) as uinteger

	loadVr as sub _
	( _
		byval reg as integer, _
		byval vreg as IRVREG ptr, _
		byval vauxparent as IRVREG ptr _
	)

	storeVr as sub _
		( _
			byval vreg as IRVREG ptr, _
			byval vauxparent as IRVREG ptr _
		)

	xchgTOS as sub _
	( _
		byval reg as integer _
	)

end type

enum IR_OPT
	IR_OPT_FPUCONV       = &h00000001  '' Should float operands always be converted?
	IR_OPT_FPUIMMEDIATES = &h00000002  '' Floating-point immediates allowed?
	IR_OPT_FPUBOPFLAGS   = &h00000004  '' Do float BOPs set flags for conditional jumps (x86)?
	IR_OPT_FPUSELFBOPS   = &h00000008  '' Are float self-BOPs available?

	IR_OPT_CPUBOPFLAGS   = &h00000100  '' Integer BOPs set flags for conditional jumps (x86)?
	IR_OPT_CPUSELFBOPS   = &h00000200  '' Integer self-BOPs available?
	IR_OPT_64BITCPUREGS  = &h00000400  '' 64-bit wide registers?

	IR_OPT_ADDRCISC      = &h00010000  '' complex addressing modes (base+idx*disp)
	IR_OPT_MISSINGOPS    = &h00020000  '' Some "complex" math operators unavailable? (call irSupportsOp() for details)
end enum

type IRCTX
	vtbl            as IR_VTBL
	options         as IR_OPT
end type

''
''
''
extern as IR_VTBL irtac_vtbl
extern as IR_VTBL irhlc_vtbl
extern as IR_VTBL irllvm_vtbl
extern as IR_VTBL irgas64_vtbl
declare sub irInit( )
declare sub irEnd( )
#if __FB_DEBUG__
declare function vregDumpToStr( byval v as IRVREG ptr ) as string
declare sub vregDump( byval v as IRVREG ptr )
#endif

''
'' macros
''
#define irGetOption( op ) ((ir.options and op) <> 0)

#define irSetOption( op ) ir.options or= op

#define irGetOptionValue( opt ) ir.vtbl.getOptionValue( opt )

#define irSupportsOp( op, dtype ) ir.vtbl.supportsOp( op, dtype )

#define irAllocVreg(dtype, stype) ir.vtbl.allocVreg( dtype, stype )

#define irSetVregDataType(v, dtype, stype) ir.vtbl.setVregDataType( v, dtype, stype )

#define irAllocVrImm(dtype, stype, value) ir.vtbl.allocVrImm( dtype, stype, value )

#define irAllocVrImmF(dtype, stype, value) ir.vtbl.allocVrImmF( dtype, stype, value )

#define irAllocVrVar(dtype, stype, sym, ofs) ir.vtbl.allocVrVar( dtype, stype, sym, ofs )

#define irAllocVrIdx(dtype, stype, sym, ofs, mult, vidx) ir.vtbl.allocVrIdx( dtype, stype, sym, ofs, mult, vidx )

#define irAllocVrPtr(dtype, stype, ofs, vidx) ir.vtbl.allocVrPtr( dtype, stype, ofs, vidx )

#define irAllocVrOfs(dtype, stype, sym, ofs) ir.vtbl.allocVrOfs( dtype, stype, sym, ofs )

#define irProcBegin(proc) ir.vtbl.procBegin( proc )

#define irProcEnd(proc) ir.vtbl.procEnd( proc )

#define irScopeBegin(s) ir.vtbl.scopeBegin( s )

#define irScopeEnd(s) ir.vtbl.scopeEnd( s )

#define irProcAllocArg(proc, s) ir.vtbl.procAllocArg( proc, s )

#define irProcAllocLocal(proc, s) ir.vtbl.procAllocLocal( proc, s )

#define irProcAllocStaticVars(head_sym) ir.vtbl.procAllocStaticVars( head_sym )

#define irProcGetFrameRegName() ir.vtbl.procGetFrameRegName( )

#define irEmitBegin() ir.vtbl.emitBegin( )

#define irEmitEnd( ) ir.vtbl.emitEnd( )

#define irEmitPROCBEGIN(proc, initlabel) ir.vtbl.emitProcBegin( proc, initlabel )

#define irEmitPROCEND(proc, initlabel, exitlabel) ir.vtbl.emitProcEnd( proc, initlabel, exitlabel )

#define irEmitVARINIBEGIN(sym) ir.vtbl.emitVarIniBegin( sym )
#define irEmitVARINIEND(sym) ir.vtbl.emitVarIniEnd( sym )
#define irEmitVARINIi(sym, value) ir.vtbl.emitVarIniI( sym, value )
#define irEmitVARINIf(sym, value) ir.vtbl.emitVarIniF( sym, value )
#define irEmitVARINIOFS(sym, rhs, ofs) ir.vtbl.emitVarIniOfs( sym, rhs, ofs )
#define irEmitVARINISTR(totlgt, litstr, litlgt) ir.vtbl.emitVarIniStr( totlgt, litstr, litlgt )
#define irEmitVARINIWSTR(totlgt, litstr, litlgt) ir.vtbl.emitVarIniWstr( totlgt, litstr, litlgt )
#define irEmitVARINIPAD(bytes) ir.vtbl.emitVarIniPad( bytes )
#define irEmitVARINISCOPEBEGIN( sym, is_array ) ir.vtbl.emitVarIniScopeBegin( sym, is_array )
#define irEmitVARINISCOPEEND( ) ir.vtbl.emitVarIniScopeEnd( )

#define irEmitFBCTINFBEGIN( )    ir.vtbl.emitFbctinfBegin( )
#define irEmitFBCTINFSTRING( s ) ir.vtbl.emitFbctinfString( s )
#define irEmitFBCTINFEND( )      ir.vtbl.emitFbctinfEnd( )

#define irEmitCONVERT( v1, v2 ) ir.vtbl.emitConvert( v1, v2 )

#define irEmitLABEL(label) ir.vtbl.emitLabel( label )

#define irEmitRETURN(bytestopop) ir.vtbl.emitReturn( bytestopop )

#define irEmitPUSHARG( param, vr, plen, level, lreg ) ir.vtbl.emitPushArg( param, vr, plen, level, lreg )

#define irEmitAsmLine( asmtokenhead ) ir.vtbl.emitAsmLine( asmtokenhead )

#define irEmitCOMMENT(text) ir.vtbl.emitComment( text )

#define irEmitJMPTB( v1, tbsym, values, labels, labelcount, deflabel, bias, span ) ir.vtbl.emitJmpTb( v1, tbsym, values, labels, labelcount, deflabel, bias, span )

#define irGetDistance(vreg) ir.vtbl.getDistance( vreg )

#define irLoadVR(reg, vreg, vauxparent) ir.vtbl.loadVR( reg, vreg, vauxparent )

#define irStoreVR(vreg, vauxparent) ir.vtbl.storeVR( vreg, vauxparent )

#define irXchgTOS(reg) ir.vtbl.xchgTOS( reg )

#define irEmitBOP( op, v1, v2, vr, label ) ir.vtbl.emitBop( op, v1, v2, vr, label )

#define irEmitUOP(op, v1, vr) ir.vtbl.emitUop( op, v1, vr )

#define irEmitSTORE(v1, v2) ir.vtbl.emitStore( v1, v2 )

#define irEmitSPILLREGS() ir.vtbl.emitSpillRegs( )

#define irEmitLOAD(v1) ir.vtbl.emitLoad( v1 )

#define irEmitLOADRES(v1, vr) ir.vtbl.emitLoadRes( v1, vr )

#define irEmitSTACK(op, v1, v2) ir.vtbl.emitStack( op, v1, v2 )

#define irEmitPUSH(v1) ir.vtbl.emitStack( AST_OP_PUSH, v1 )

#define irEmitPOP(v1) ir.vtbl.emitStack( AST_OP_POP, v1 )

#define irEmitADDR(op, v1, vr) ir.vtbl.emitAddr( op, v1, vr )

#define irEmitLABELNF(s) ir.vtbl.emitLabelNF( s )

#define irEmitCALLFUNCT(proc, bytestopop, vr, level) ir.vtbl.emitCall( proc, bytestopop, vr, level )

#define irEmitCALLPTR(proc, v1, vr, bytestopop, level) ir.vtbl.emitCallPtr( proc, v1, vr, bytestopop, level )

#define irEmitSTACKALIGN(bytes) ir.vtbl.emitStackAlign( bytes )

#define irEmitJUMPPTR(v1) ir.vtbl.emitJumpPtr( v1 )

#define irEmitBRANCH(op, label) ir.vtbl.emitBranch( op, label )

#define irEmitMEM(op, v1, v2, bytes) ir.vtbl.emitMem( op, v1, v2, bytes )

#define irEmitSCOPEBEGIN(s) ir.vtbl.emitScopeBegin( s )

#define irEmitSCOPEEND(s) ir.vtbl.emitScopeEnd( s )

#define irEmitDBG(op, proc, ex, filename) ir.vtbl.emitDBG( op, proc, ex, filename )

#define irEmitDECL( sym ) ir.vtbl.emitDECL( sym )

#define irEmitMACRO(op, v1, v2, vr) ir.vtbl.emitMACRO( op, v1, v2, vr )


#define irIsREG(v) (v->typ = IR_VREGTYPE_REG)

#define irIsIMM(v) (v->typ = IR_VREGTYPE_IMM)

#define irIsVAR(v) (v->typ = IR_VREGTYPE_VAR)

#define irIsIDX(v) (v->typ = IR_VREGTYPE_IDX)

#define irIsPTR(v) (v->typ = IR_VREGTYPE_PTR)

#define ISLONGINT(t) ((t = FB_DATATYPE_LONGINT) or (t = FB_DATATYPE_ULONGINT))


''
'' inter-module globals
''
extern ir as IRCTX


#endif '' __IR_BI__
