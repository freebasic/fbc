#ifndef __EMIT_BI__
#define __EMIT_BI__

#include once "flist.bi"
#include once "reg.bi"
#include once "ast.bi"
#include once "ir.bi"

const EMIT_INITNODES    = 2048
const EMIT_INITVREGNODES= EMIT_INITNODES*3

'' x86 specific: FB_DATACLASS_INTEGER and FB_DATACLASS_FPOINT
const EMIT_REGCLASSES = 2                       '' assuming FB_DATACLASS_ will start at 0!

'' if changed, update the _opFnTB() arrays at emit_*.bas
enum EMIT_NODEOP
	EMIT_OP_NOP

	'' load
	EMIT_OP_LOADI2I, EMIT_OP_LOADF2I, EMIT_OP_LOADL2I, EMIT_OP_LOADB2I
	EMIT_OP_LOADI2F, EMIT_OP_LOADF2F, EMIT_OP_LOADL2F, EMIT_OP_LOADB2F
	EMIT_OP_LOADI2L, EMIT_OP_LOADF2L, EMIT_OP_LOADL2L, EMIT_OP_LOADB2L
	EMIT_OP_LOADI2B, EMIT_OP_LOADF2B, EMIT_OP_LOADL2B, EMIT_OP_LOADB2B

	'' store
	EMIT_OP_STORI2I, EMIT_OP_STORF2I, EMIT_OP_STORL2I, EMIT_OP_STORB2I
	EMIT_OP_STORI2F, EMIT_OP_STORF2F, EMIT_OP_STORL2F, EMIT_OP_STORB2F
	EMIT_OP_STORI2L, EMIT_OP_STORF2L, EMIT_OP_STORL2L, EMIT_OP_STORB2L
	EMIT_OP_STORI2B, EMIT_OP_STORF2B, EMIT_OP_STORL2B, EMIT_OP_STORB2B

	'' bop
	EMIT_OP_MOVI, EMIT_OP_MOVF, EMIT_OP_MOVL
	EMIT_OP_ADDI, EMIT_OP_ADDF, EMIT_OP_ADDL
	EMIT_OP_SUBI, EMIT_OP_SUBF, EMIT_OP_SUBL
	EMIT_OP_MULI, EMIT_OP_MULF, EMIT_OP_MULL
	EMIT_OP_DIVI, EMIT_OP_DIVF, EMIT_OP_DIVL
	EMIT_OP_MODI, EMIT_OP_MODF, EMIT_OP_MODL
	EMIT_OP_SHLI, EMIT_OP_SHLL
	EMIT_OP_SHRI, EMIT_OP_SHRL
	EMIT_OP_ANDI, EMIT_OP_ANDL
	EMIT_OP_ORI , EMIT_OP_ORL
	EMIT_OP_XORI, EMIT_OP_XORL
	EMIT_OP_EQVI, EMIT_OP_EQVL
	EMIT_OP_IMPI, EMIT_OP_IMPL

	EMIT_OP_ATN2
	EMIT_OP_POW

	EMIT_OP_ADDROF
	EMIT_OP_DEREF

	'' rel
	EMIT_OP_CGTI, EMIT_OP_CGTF, EMIT_OP_CGTL
	EMIT_OP_CLTI, EMIT_OP_CLTF, EMIT_OP_CLTL
	EMIT_OP_CEQI, EMIT_OP_CEQF, EMIT_OP_CEQL
	EMIT_OP_CNEI, EMIT_OP_CNEF, EMIT_OP_CNEL
	EMIT_OP_CGEI, EMIT_OP_CGEF, EMIT_OP_CGEL
	EMIT_OP_CLEI, EMIT_OP_CLEF, EMIT_OP_CLEL

	'' uop
	EMIT_OP_NEGI, EMIT_OP_NEGF, EMIT_OP_NEGL
	EMIT_OP_NOTI, EMIT_OP_NOTL

	EMIT_OP_HADDF

	EMIT_OP_ABSI, EMIT_OP_ABSF, EMIT_OP_ABSL
	EMIT_OP_SGNI, EMIT_OP_SGNF, EMIT_OP_SGNL

	EMIT_OP_FIX
	EMIT_OP_FRAC
	EMIT_OP_CONVFD2FS

	EMIT_OP_SWZREP

	EMIT_OP_SIN, EMIT_OP_ASIN
	EMIT_OP_COS, EMIT_OP_ACOS
	EMIT_OP_TAN, EMIT_OP_ATAN
	EMIT_OP_SQRT
	EMIT_OP_RSQRT
	EMIT_OP_RCP
	EMIT_OP_LOG
	EMIT_OP_EXP
	EMIT_OP_FLOOR
	EMIT_OP_XCHGTOS

	EMIT_OP_STACKALIGN
	EMIT_OP_PUSHI, EMIT_OP_PUSHF, EMIT_OP_PUSHL
	EMIT_OP_POPI, EMIT_OP_POPF, EMIT_OP_POPL
	EMIT_OP_PUSHUDT
	EMIT_OP_POPST0

	'' branch
	EMIT_OP_CALL
	EMIT_OP_CALLPTR
	EMIT_OP_BRANCH
	EMIT_OP_JUMP
	EMIT_OP_JUMPPTR
	EMIT_OP_RET

	'' misc
	EMIT_OP_LABEL
	EMIT_OP_PUBLIC
	EMIT_OP_LIT
	EMIT_OP_JMPTB

	'' mem
	EMIT_OP_MEMMOVE
	EMIT_OP_MEMSWAP
	EMIT_OP_MEMCLEAR
	EMIT_OP_STKCLEAR

	'' dgb
	EMIT_OP_LINEINI
	EMIT_OP_LINEEND
	EMIT_OP_SCOPEINI
	EMIT_OP_SCOPEEND

	EMIT_MAXOPS
end enum

enum EMIT_NODECLASS_ENUM
	EMIT_NODECLASS_NOP
	EMIT_NODECLASS_BOP
	EMIT_NODECLASS_UOP
	EMIT_NODECLASS_REL
	EMIT_NODECLASS_STK
	EMIT_NODECLASS_BRC
	EMIT_NODECLASS_LIT
	EMIT_NODECLASS_JTB
	EMIT_NODECLASS_SOP
	EMIT_NODECLASS_MEM
	EMIT_NODECLASS_DBG
end enum

type EMIT_BOPNODE
	op          as integer
	dvreg       as IRVREG ptr
	svreg       as IRVREG ptr
end type

type EMIT_UOPNODE
	op          as integer
	dvreg       as IRVREG ptr
end type

type EMIT_RELNODE
	op          as integer
	rvreg       as IRVREG ptr
	label       as FBSYMBOL ptr
	dvreg       as IRVREG ptr
	svreg       as IRVREG ptr
end type

type EMIT_STKNODE
	op          as integer
	vreg        as IRVREG ptr
	extra       as integer
end type

type EMIT_BRCNODE
	op          as integer
	vreg        as IRVREG ptr
	sym         as FBSYMBOL ptr
	extra       as integer
end type

type EMIT_SOPNODE
	op          as integer
	sym         as FBSYMBOL ptr
end type

type EMIT_LITNODE
	isasm       as integer
	text        as zstring ptr
end type

type EMIT_JTBNODE
	tbsym               as FBSYMBOL ptr

	'' Dynamically allocated buffer holding the jmptb's value/label pairs
	values              as ulongint ptr
	labels              as FBSYMBOL ptr ptr
	labelcount          as integer

	deflabel            as FBSYMBOL ptr
	bias                as ulongint
	span                as ulongint
end type

type EMIT_MEMNODE
	op          as integer
	dvreg       as IRVREG ptr
	svreg       as IRVREG ptr
	bytes       as integer
	extra       as integer
end type

type EMIT_DBGNODE
	op          as integer
	sym         as FBSYMBOL ptr
	lnum        as integer
	filename    as zstring ptr
	pos         as integer
end type

type EMIT_NODE
	class                           as EMIT_NODECLASS_ENUM

	union
		bop                         as EMIT_BOPNODE
		uop                         as EMIT_UOPNODE
		rel                         as EMIT_RELNODE
		stk                         as EMIT_STKNODE
		brc                         as EMIT_BRCNODE
		sop                         as EMIT_SOPNODE
		lit                         as EMIT_LITNODE
		jtb                         as EMIT_JTBNODE
		mem                         as EMIT_MEMNODE
		dbg                         as EMIT_DBGNODE
	end union

	regFreeTB(EMIT_REGCLASSES-1)    as REG_FREETB
end type


type EMIT_BOPCB as sub( byval dvreg as IRVREG ptr, _
						byval svreg as IRVREG ptr )

type EMIT_UOPCB as sub( byval dvreg as IRVREG ptr )

type EMIT_RELCB as sub( byval rvreg as IRVREG ptr, _
						byval label as FBSYMBOL ptr, _
						byval dvreg as IRVREG ptr, _
						byval svreg as IRVREG ptr )

type EMIT_STKCB as sub( byval vreg as IRVREG ptr, _
						byval extra as integer )

type EMIT_BRCCB as sub( byval vreg as IRVREG ptr, _
						byval sym as FBSYMBOL ptr, _
						byval extra as integer )

type EMIT_SOPCB as sub( byval sym as FBSYMBOL ptr )

type EMIT_LITCB as sub( byval text as zstring ptr )

type EMIT_JTBCB as sub _
	( _
		byval tbsym as FBSYMBOL ptr, _
		byval values1 as ulongint ptr, _
		byval labels1 as FBSYMBOL ptr ptr, _
		byval labelcount as integer, _
		byval deflabel as FBSYMBOL ptr, _
		byval bias as ulongint, _
		byval span as ulongint _
	)

type EMIT_MEMCB as sub _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr, _
		byval bytes as integer, _
		byval extra as integer _
	)

type EMIT_DBGCB as sub _
	( _
		byval sym as FBSYMBOL ptr, _
		byval lnum as integer, _
		byval pos as Integer, _
		ByVal filename As ZString Ptr = 0 _
	)

'' if changed, update the _vtbl symbols at emit_*.bas::*_ctor
type EMIT_VTBL
	init as function _
	( _
	) as integer

	end as sub _
	( _
	)

	getOptionValue as function _
	( _
		byval opt as IR_OPTIONVALUE _
	) as integer

	open as function _
	( _
	) as integer

	close as sub( )

	isRegPreserved as function _
	( _
		byval dclass as integer, _
		byval reg as integer _
	) as integer

	getFreePreservedReg as function _
	( _
		byval dclass as integer, _
		byval dtype as integer _
	) as integer

	getArgReg as sub _
	( _
		byval dtype as integer, _
		byval dclass as integer, _
		byval argnum as integer, _
		byref r1 as integer _
	)

	getResultReg as sub _
	( _
		byval dtype as integer, _
		byval dclass as integer, _
		byref r1 as integer, _
		byref r2 as integer _
	)

	procGetFrameRegName as function _
	( _
	) as const zstring ptr

	procBegin as sub _
	( _
		byval proc as FBSYMBOL ptr _
	)

	procEnd as sub _
	( _
		byval proc as FBSYMBOL ptr _
	)

	procHeader as sub _
	( _
		byval proc as FBSYMBOL ptr, _
		byval initlabel as FBSYMBOL ptr _
	)

	procFooter as sub _
	( _
		byval proc as FBSYMBOL ptr, _
		byval bytestopop as integer, _
		byval initlabel as FBSYMBOL ptr, _
		byval exitlabel as FBSYMBOL ptr _
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

	procAllocStaticVars as sub(byval head_sym as FBSYMBOL ptr)

	scopeBegin as sub _
	( _
		byval s as FBSYMBOL ptr _
	)

	scopeEnd as sub _
	( _
		byval s as FBSYMBOL ptr _
	)

	setSection as sub _
	( _
		byval section as integer, _
		byval priority as integer _
	)

	getTypeString as function _
	( _
		byval dtype as integer _
	) as const zstring ptr

	getSectionString as function _
	( _
		byval section as integer, _
		byval priority as integer _
	) as const zstring ptr
end type

type EMITCTX
	inited                              as integer

	pos                                 as integer          '' to help debugging

	regTB(0 to EMIT_REGCLASSES-1)       as REGCLASS ptr     '' reg classes

	'' node tb
	nodeTB                              as TFLIST
	vregTB                              as TFLIST
	curnode                             as EMIT_NODE ptr

	regUsedTB(EMIT_REGCLASSES-1)        as REG_FREETB       '' keep track of register usage

	'' platform-dependent
	lastsection                         as integer
	lastpriority                        as integer

	''
	vtbl                                as EMIT_VTBL
	opFnTb                              as any ptr ptr
end type

''
''
''
declare function emitInit( ) as integer
declare sub emitEnd( )

#if __FB_DEBUG__
declare function emitDumpRegName( byval dtype as integer, byval reg as integer ) as string
#endif

declare function emitGetRegClass _
	( _
		byval dclass as integer _
	) as REGCLASS ptr

declare sub emitCOMMENT( byval text as zstring ptr )
declare sub emitASM( byval text as zstring ptr )

declare function emitJMPTB _
	( _
		byval tbsym as FBSYMBOL ptr, _
		byval values1 as ulongint ptr, _
		byval labels1 as FBSYMBOL ptr ptr, _
		byval labelcount as integer, _
		byval deflabel as FBSYMBOL ptr, _
		byval bias as ulongint, _
		byval span as ulongint _
	) as EMIT_NODE ptr

declare function emitCALL _
	( _
		byval label as FBSYMBOL ptr, _
		byval bytestopop as integer _
	) as EMIT_NODE ptr

declare function emitCALLPTR _
	( _
		byval svreg as IRVREG ptr, _
		byval bytestopop as integer _
	) as EMIT_NODE ptr

declare function emitJUMP _
	( _
		byval label as FBSYMBOL ptr _
	) as EMIT_NODE ptr

declare function emitJUMPPTR _
	( _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitLABEL _
	( _
		byval label as FBSYMBOL ptr _
	) as EMIT_NODE ptr

declare function emitRET( byval bytestopop as integer ) as EMIT_NODE ptr

declare function emitPUBLIC _
	( _
		byval label as FBSYMBOL ptr _
	) as EMIT_NODE ptr

declare function emitBRANCH _
	( _
		byval op as integer, _
		byval label as FBSYMBOL ptr _
	) as EMIT_NODE ptr

declare function emitXchgTOS _
	( _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitMOV _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitSTORE _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitLOAD _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitADD _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitSUB _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitMUL _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitDIV _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitINTDIV _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitMOD _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitSHL _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitSHR _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitAND _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitOR _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitXOR _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitEQV _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitIMP _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitADDROF _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitDEREF _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitGT _
	( _
		byval rvreg as IRVREG ptr, _
		byval label as FBSYMBOL ptr, _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitLT _
	( _
		byval rvreg as IRVREG ptr, _
		byval label as FBSYMBOL ptr, _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitEQ _
	( _
		byval rvreg as IRVREG ptr, _
		byval label as FBSYMBOL ptr, _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitNE _
	( _
		byval rvreg as IRVREG ptr, _
		byval label as FBSYMBOL ptr, _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitLE _
	( _
		byval rvreg as IRVREG ptr, _
		byval label as FBSYMBOL ptr, _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitGE _
	( _
		byval rvreg as IRVREG ptr, _
		byval label as FBSYMBOL ptr, _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitATN2 _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitPOW _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitNEG _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitNOT _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitABS _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitHADD _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitSGN _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitFIX _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitFRAC _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitCONVFD2FS( byval dvreg as IRVREG ptr ) as EMIT_NODE ptr

declare function emitSWZREP _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitSIN _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitASIN _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitCOS _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitACOS _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitTAN _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitATAN _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitSQRT _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitRSQRT _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitRCP _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitLOG _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitEXP _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitFLOOR _
	( _
		byval dvreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitSTACKALIGN( byval bytes as integer ) as EMIT_NODE ptr

declare function emitPUSH _
	( _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitPOP _
	( _
		byval svreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitPUSHUDT _
	( _
		byval svreg as IRVREG ptr, _
		byval sdsize as integer _
	) as EMIT_NODE ptr

declare function emitPOPST0( ) as EMIT_NODE ptr

declare function emitMEMMOVE _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr, _
		byval bytes as integer _
	) as EMIT_NODE ptr

declare function emitMEMSWAP _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr, _
		byval bytes as integer _
	) as EMIT_NODE ptr

declare function emitMEMCLEAR _
	( _
		byval dvreg as IRVREG ptr, _
		byval bytes_vreg as IRVREG ptr _
	) as EMIT_NODE ptr

declare function emitSTKCLEAR _
	( _
		byval bytes as integer, _
		byval baseofs as integer _
	) as EMIT_NODE ptr

declare function emitDBGLineBegin _
	( _
		byval proc as FBSYMBOL ptr, _
		byval ex as integer, _
		byval filename as zstring ptr _
	) as EMIT_NODE ptr

declare function emitDBGLineEnd _
	( _
		byval proc as FBSYMBOL ptr, _
		byval ex as integer _
	) as EMIT_NODE ptr

declare function emitDBGScopeBegin _
	( _
		byval sym as FBSYMBOL ptr _
	) as EMIT_NODE ptr

declare function emitDBGScopeEnd _
	( _
		byval sym as FBSYMBOL ptr _
	) as EMIT_NODE ptr

declare sub emitVARINIBEGIN( byval sym as FBSYMBOL ptr )
declare sub emitVARINIi( byval dtype as integer, byval value as longint )
declare sub emitVARINIf( byval dtype as integer, byval value as double )
declare sub emitVARINIOFS( byval sname as zstring ptr, byval ofs as integer )
declare sub emitVARINISTR( byval s as const zstring ptr )
declare sub emitVARINIWSTR( byval s as zstring ptr )
declare sub emitVARINIPAD( byval bytes as integer )
declare sub emitFBCTINFBEGIN( )
declare sub emitFBCTINFSTRING( byval s as const zstring ptr )
declare sub emitFBCTINFEND( )

declare sub emitWriteStr _
	( _
		byval s as const zstring ptr, _
		byval addtab as integer = FALSE _
	)

declare sub emitWriteObjinfo _
	( _
		byval liblist as TLIST ptr, _
		byval libpathlist as TLIST ptr _
	)

declare sub emitReset _
	( _
		_
	)

declare sub emitFlush _
	( _
		_
	)


#define emitGetOptionValue( opt ) emit.vtbl.getOptionValue( opt )

#define emitOpen( ) emit.vtbl.open( )

#define emitClose( ) emit.vtbl.close( )

#define emitProcBegin( proc ) emit.vtbl.procBegin( proc )

#define emitProcEnd( proc ) emit.vtbl.procEnd( proc )

#define emitProcHeader( proc, initlabel ) emit.vtbl.procHeader( proc, initlabel )

#define emitProcFooter( proc, bytestopop, initlabel, exitlabel ) emit.vtbl.procFooter( proc, bytestopop, initlabel, exitlabel )

#define emitProcAllocArg( proc, s ) emit.vtbl.procAllocArg( proc, s )

#define emitProcAllocLocal( proc, s ) emit.vtbl.procAllocLocal( proc, s )

#define emitProcGetFrameRegName( ) emit.vtbl.procGetFrameRegName( )

#define emitScopeBegin( s ) emit.vtbl.scopeBegin( s )

#define emitScopeEnd( s ) emit.vtbl.scopeEnd( s )

#define emitProcAllocStaticVars( head_sym ) emit.vtbl.procAllocStaticVars( head_sym )

#define emitIsRegPreserved( dclass, reg ) emit.vtbl.isRegPreserved( dclass, reg )

#define emitGetFreePreservedReg( dclass, dtype ) emit.vtbl.getFreePreservedReg( dclass, dtype )

#define emitGetArgReg( dclass, dtype, argnum, reg ) emit.vtbl.getArgReg( dclass, dtype, argnum, reg )

#define emitGetResultReg( dtype, dclass, reg, reg2 ) emit.vtbl.getResultReg( dtype, dclass, reg, reg2 )

#define emitSetSection( sec, priority ) emit.vtbl.setSection( sec, priority )

''::::
#define EMIT_REGSETUSED(c,r) emit.regUsedTB(c) or= (1 shl r)
#define EMIT_REGISUSED(c,r) ((emit.regUsedTB(c) and (1 shl r)) <> 0)
#define EMIT_REGCLEARALL(c) emit.regUsedTB(c) = 0
#define EMIT_REGTRASHALL(c) emit.regUsedTB(c) = -1

''
'' inter-module globals
''
extern emit as EMITCTX

extern emit_opfTB(0 to EMIT_MAXOPS-1) as any ptr

#endif '' __EMIT_BI__
