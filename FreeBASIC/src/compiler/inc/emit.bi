#ifndef __EMIT_BI__
#define __EMIT_BI__

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


#include once "inc\flist.bi"
#include once "inc\reg.bi"
#include once "inc\ast.bi"
#include once "inc\ir.bi"

const NEWLINE = "\r\n"

const EMIT_INITNODES	= 1024
const EMIT_INITVREGNODES= EMIT_INITNODES*4

'#ifdef TARGET_X86
const EMIT_REGCLASSES	= 2						'' assuming IR_DATACLASS_ will start at 0!
const EMIT_LOCSTART 	= 0
const EMIT_ARGSTART 	= FB_POINTERSIZE + FB_INTEGERSIZE '' skip return address + saved ebp

enum EMITREG_ENUM
	EMIT_REG_FP0	= 0
	EMIT_REG_FP1
	EMIT_REG_FP2
	EMIT_REG_FP3
	EMIT_REG_FP4
	EMIT_REG_FP5
	EMIT_REG_FP6
	EMIT_REG_FP7

	EMIT_REG_EDX	= EMIT_REG_FP0				'' aliased
	EMIT_REG_EDI
	EMIT_REG_ESI
	EMIT_REG_ECX
	EMIT_REG_EBX
	EMIT_REG_EAX
	EMIT_REG_EBP
	EMIT_REG_ESP
end enum
'#endif

'' section types
enum EMITSECTYPE_ENUM
	EMIT_SECTYPE_CONST
	EMIT_SECTYPE_DATA
	EMIT_SECTYPE_BSS
	EMIT_SECTYPE_CODE
	EMIT_SECTYPE_DIRECTIVE
    EMIT_SECTYPE_CONSTRUCTOR
    EMIT_SECTYPE_DESTRUCTOR
end enum

enum EMIT_NODEOP_ENUM
	'' load
	EMIT_OP_LOADI2I, EMIT_OP_LOADF2I, EMIT_OP_LOADL2I
	EMIT_OP_LOADI2F, EMIT_OP_LOADF2F, EMIT_OP_LOADL2F
	EMIT_OP_LOADI2L, EMIT_OP_LOADF2L, EMIT_OP_LOADL2L

	'' store
	EMIT_OP_STORI2I, EMIT_OP_STORF2I, EMIT_OP_STORL2I
	EMIT_OP_STORI2F, EMIT_OP_STORF2F, EMIT_OP_STORL2F
	EMIT_OP_STORI2L, EMIT_OP_STORF2L, EMIT_OP_STORL2L

	'' bop
	EMIT_OP_MOVI, EMIT_OP_MOVF, EMIT_OP_MOVL
	EMIT_OP_ADDI, EMIT_OP_ADDF, EMIT_OP_ADDL
	EMIT_OP_SUBI, EMIT_OP_SUBF, EMIT_OP_SUBL
	EMIT_OP_MULI, EMIT_OP_MULF, EMIT_OP_MULL, EMIT_OP_SMULI
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
	EMIT_OP_ABSI, EMIT_OP_ABSF, EMIT_OP_ABSL
	EMIT_OP_SGNI, EMIT_OP_SGNF, EMIT_OP_SGNL

	EMIT_OP_SIN, EMIT_OP_ASIN
	EMIT_OP_COS, EMIT_OP_ACOS
	EMIT_OP_TAN, EMIT_OP_ATAN
	EMIT_OP_SQRT
	EMIT_OP_LOG
	EMIT_OP_FLOOR
	EMIT_OP_XCHGTOS

	EMIT_OP_ALIGN
	EMIT_OP_STKALIGN

	EMIT_OP_PUSHI, EMIT_OP_PUSHF, EMIT_OP_PUSHL
	EMIT_OP_POPI, EMIT_OP_POPF, EMIT_OP_POPL
	EMIT_OP_PUSHUDT

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

	EMIT_MAXOPS
end enum

enum EMIT_NODECLASS_ENUM
	EMIT_NODECLASS_BOP
	EMIT_NODECLASS_UOP
	EMIT_NODECLASS_REL
	EMIT_NODECLASS_STK
	EMIT_NODECLASS_BRC
	EMIT_NODECLASS_LIT
	EMIT_NODECLASS_JTB
	EMIT_NODECLASS_SOP
	EMIT_NODECLASS_MEM
end enum

type EMIT_BOPNODE
	op			as integer
	dvreg		as IRVREG ptr
	svreg		as IRVREG ptr
end type

type EMIT_UOPNODE
	op			as integer
	dvreg		as IRVREG ptr
end type

type EMIT_RELNODE
	op			as integer
	rvreg		as IRVREG ptr
	label		as FBSYMBOL ptr
	dvreg		as IRVREG ptr
	svreg		as IRVREG ptr
end type

type EMIT_STKNODE
	op			as integer
	vreg		as IRVREG ptr
	extra		as integer
end type

type EMIT_BRCNODE
	op			as integer
	vreg		as IRVREG ptr
	sym			as FBSYMBOL ptr
	extra		as integer
end type

type EMIT_SOPNODE
	op			as integer
	sym			as FBSYMBOL ptr
end type

type EMIT_LITNODE
	text		as string
end type

type EMIT_JTBNODE
	dtype		as integer
	text		as string
end type

type EMIT_MEMNODE
	op			as integer
	dvreg		as IRVREG ptr
	svreg		as IRVREG ptr
	bytes		as integer
end type

type EMIT_NODE
	ll_nxt							as EMIT_NODE ptr

	class							as EMIT_NODECLASS_ENUM

	union
		bop							as EMIT_BOPNODE
		uop							as EMIT_UOPNODE
		rel							as EMIT_RELNODE
		stk						 	as EMIT_STKNODE
		brc							as EMIT_BRCNODE
		sop							as EMIT_SOPNODE
		lit							as EMIT_LITNODE
		jtb							as EMIT_JTBNODE
		mem							as EMIT_MEMNODE
	end union

	regFreeTB(EMIT_REGCLASSES-1) 	as REG_FREETB
end type


type EMIT_BOPCB as sub( byval dvreg as IRVREG ptr, byval svreg as IRVREG ptr )

type EMIT_UOPCB as sub( byval dvreg as IRVREG ptr )

type EMIT_RELCB as sub( byval rvreg as IRVREG ptr, byval label as FBSYMBOL ptr, _
						byval dvreg as IRVREG ptr, byval svreg as IRVREG ptr )

type EMIT_STKCB as sub( byval vreg as IRVREG ptr, byval extra as integer )

type EMIT_BRCCB as sub( byval vreg as IRVREG ptr, byval sym as FBSYMBOL ptr, byval extra as integer )

type EMIT_SOPCB as sub( byval sym as FBSYMBOL ptr )

type EMIT_LITCB as sub( byval text as string )

type EMIT_JTBCB as sub( byval dtype as integer, byval text as string )

type EMIT_MEMCB as sub( byval dvreg as IRVREG ptr, byval svreg as IRVREG ptr, _
						byval bytes as integer )


type EMITMAIN
	node			as ASTPROCNODE ptr
	proc			as FBSYMBOL ptr
	argc			as FBSYMBOL ptr
	argv			as FBSYMBOL ptr
	initlabel		as FBSYMBOL ptr
	exitlabel		as FBSYMBOL ptr
	initnode		as ASTNODE ptr
end type

type EMITCTX
	inited								as integer

	pos									as integer			'' to help debugging

	regTB(0 to EMIT_REGCLASSES-1) 		as REGCLASS ptr		'' reg classes

	'' node tb
	nodeTB								as TFLIST
	vregTB								as TFLIST
	curnode								as EMIT_NODE ptr

	regUsedTB(EMIT_REGCLASSES-1) 		as REG_FREETB       '' keep track of register usage

	''
	main								as EMITMAIN

	'' platform-dependent
	dataend								as integer

	lastsection							as integer

	keyinited							as integer
	keyhash								as THASH

    '' header flags, TRUE= emited already
    bssheader							as integer
    conheader							as integer
    datheader							as integer
    expheader       					as integer
end type

''
''
''
declare sub 		emitInit			( )

declare sub 		emitEnd				( )

declare function 	emitOpen			( ) as integer

declare sub 		emitClose			( byval tottime as double )

declare function 	emitGetRegClass		( byval dclass as integer ) as REGCLASS ptr

declare	function 	emitGetPos 			( ) as integer

declare function 	emitIsKeyword		( byval text as string ) as integer

declare sub 		emitProcBegin		( byval proc as FBSYMBOL ptr )

declare sub 		emitProcEnd			( byval proc as FBSYMBOL ptr )

declare function 	emitGetVarName		( byval s as FBSYMBOL ptr ) as string

declare function 	emitIsRegPreserved 	( byval dtype as integer, _
										  byval dclass as integer, _
										  byval reg as integer ) as integer

declare sub			emitGetResultReg 	( byval dtype as integer, _
										  byval dclass as integer, _
										  r1 as integer, _
										  r2 as integer )

declare function 	emitGetFreePreservedReg( byval dtype as integer, _
											 byval dclass as integer ) as integer

declare function 	emitAllocLocal		( byval proc as FBSYMBOL ptr, _
										  byval lgt as integer, _
										  ofs as integer ) as zstring ptr

declare sub 		emitFreeLocal		( byval proc as FBSYMBOL ptr, _
										  byval lgt as integer )

declare function 	emitAllocArg		( byval proc as FBSYMBOL ptr, _
										  byval lgt as integer, _
										  ofs as integer ) as zstring ptr

declare sub 		emitFreeArg			( byval proc as FBSYMBOL ptr, _
										  byval lgt as integer )

declare sub 		emitPROCHEADER		( byval proc as FBSYMBOL ptr, _
										  byval initlabel as FBSYMBOL ptr )

declare sub 		emitPROCFOOTER		( byval proc as FBSYMBOL ptr, _
										  byval bytestopop as integer, _
										  byval initlabel as FBSYMBOL ptr, _
										  byval exitlabel as FBSYMBOL ptr )

declare sub 		emitASM				( byval text as string )

declare sub 		emitCOMMENT			( byval text as string )

declare sub 		emitLIT				( byval text as string )

declare sub 		emitJMPTB			( byval dtype as integer, _
										  byval text as string )

declare sub 		emitALIGN			( byval bytes as integer )

declare sub 		emitSTACKALIGN		( byval bytes as integer )

declare sub 		emitCALL			( byval label as FBSYMBOL ptr, _
										  byval bytestopop as integer )

declare sub 		emitCALLPTR			( byval svreg as IRVREG ptr, _
										  byval bytestopop as integer )

declare sub 		emitJUMP			( byval label as FBSYMBOL ptr )

declare sub 		emitJUMPPTR			( byval svreg as IRVREG ptr )

declare sub 		emitLABEL			( byval label as FBSYMBOL ptr )

declare sub 		emitRET				( byval bytestopop as integer )

declare sub 		emitPUBLIC			( byval label as FBSYMBOL ptr )

declare sub 		emitBRANCH			( byval op as integer, _
										  byval label as FBSYMBOL ptr )

declare sub 		emitXchgTOS			( byval svreg as IRVREG ptr )

declare sub 		emitMOV				( byval dvreg as IRVREG ptr, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitSTORE			( byval dvreg as IRVREG ptr, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitLOAD			( byval dvreg as IRVREG ptr, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitADD				( byval dvreg as IRVREG ptr, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitSUB				( byval dvreg as IRVREG ptr, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitMUL				( byval dvreg as IRVREG ptr, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitDIV				( byval dvreg as IRVREG ptr, _
		     							  byval svreg as IRVREG ptr )

declare sub 		emitINTDIV			( byval dvreg as IRVREG ptr, _
		     							  byval svreg as IRVREG ptr )

declare sub 		emitMOD				( byval dvreg as IRVREG ptr, _
		     							  byval svreg as IRVREG ptr )

declare sub 		emitSHL				( byval dvreg as IRVREG ptr, _
			 					  	 	  byval svreg as IRVREG ptr )

declare sub 		emitSHR				( byval dvreg as IRVREG ptr, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitAND				( byval dvreg as IRVREG ptr, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitOR				( byval dvreg as IRVREG ptr, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitXOR				( byval dvreg as IRVREG ptr, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitEQV				( byval dvreg as IRVREG ptr, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitIMP				( byval dvreg as IRVREG ptr, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitADDROF			( byval dvreg as IRVREG ptr, _
			    						  byval svreg as IRVREG ptr )

declare sub 		emitDEREF			( byval dvreg as IRVREG ptr, _
			    						  byval svreg as IRVREG ptr )

declare sub 		emitGT				( byval rvreg as IRVREG ptr, _
										  byval label as FBSYMBOL ptr, _
								  		  byval dvreg as IRVREG ptr, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitLT				( byval rvreg as IRVREG ptr, _
										  byval label as FBSYMBOL ptr, _
								  		  byval dvreg as IRVREG ptr, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitEQ				( byval rvreg as IRVREG ptr, _
										  byval label as FBSYMBOL ptr, _
								  		  byval dvreg as IRVREG ptr, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitNE				( byval rvreg as IRVREG ptr, _
										  byval label as FBSYMBOL ptr, _
								  		  byval dvreg as IRVREG ptr, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitLE				( byval rvreg as IRVREG ptr, _
										  byval label as FBSYMBOL ptr, _
								  		  byval dvreg as IRVREG ptr, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitGE				( byval rvreg as IRVREG ptr, _
										  byval label as FBSYMBOL ptr, _
								  		  byval dvreg as IRVREG ptr, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitATN2			( byval dvreg as IRVREG ptr, _
			   							  byval svreg as IRVREG ptr )

declare sub 		emitPOW				( byval dvreg as IRVREG ptr, _
			   							  byval svreg as IRVREG ptr )

declare sub 		emitNEG				( byval dvreg as IRVREG ptr )

declare sub 		emitNOT				( byval dvreg as IRVREG ptr )

declare sub 		emitABS				( byval dvreg as IRVREG ptr )

declare sub 		emitSGN				( byval dvreg as IRVREG ptr )

declare sub 		emitSIN				( byval dvreg as IRVREG ptr )

declare sub 		emitASIN			( byval dvreg as IRVREG ptr )

declare sub 		emitCOS				( byval dvreg as IRVREG ptr )

declare sub 		emitACOS			( byval dvreg as IRVREG ptr )

declare sub 		emitTAN				( byval dvreg as IRVREG ptr )

declare sub 		emitATAN			( byval dvreg as IRVREG ptr )

declare sub 		emitSQRT			( byval dvreg as IRVREG ptr )

declare sub 		emitLOG				( byval dvreg as IRVREG ptr )

declare sub 		emitFLOOR			( byval dvreg as IRVREG ptr )

declare sub 		emitPUSH			( byval svreg as IRVREG ptr )

declare sub 		emitPUSHUDT			( byval svreg as IRVREG ptr, _
										  byval sdsize as integer )

declare sub 		emitPOP				( byval svreg as IRVREG ptr )

declare sub 		emitMEMMOVE			( byval dvreg as IRVREG ptr, _
			 					  		  byval svreg as IRVREG ptr, _
			 					  		  byval bytes as integer )

declare sub 		emitMEMSWAP			( byval dvreg as IRVREG ptr, _
			 					  		  byval svreg as IRVREG ptr, _
			 					  		  byval bytes as integer )

declare sub 		emitMEMCLEAR		( byval dvreg as IRVREG ptr, _
			 					  		  byval svreg as IRVREG ptr, _
			 					  		  byval bytes as integer )

declare sub 		emitSECTION			( byval section as integer )

declare sub 		emitDATALABEL		( byval label as string )

declare sub 		emitDATABEGIN		( byval lname as string )

declare sub 		emitDATA			( byval litext as string, _
										  byval litlen as integer, _
										  byval dtype as integer )

declare sub 		emitDATAOFS			( byval sname as string )

declare sub 		emitDATAEND			( )

declare sub 		emitVARINIBEGIN		( byval sym as FBSYMBOL ptr )

declare sub 		emitVARINIEND		( byval sym as FBSYMBOL ptr )

declare sub 		emitVARINIi			( byval dtype as integer, _
										  byval value as integer )

declare sub 		emitVARINIf			( byval dtype as integer, _
										  byval value as double )

declare sub 		emitVARINI64		( byval dtype as integer, _
										  byval value as longint )

declare sub 		emitVARINIOFS		( byval sname as string )

declare sub 		emitVARINISTR		( byval s as string )

declare sub 		emitVARINIWSTR		( byval s as string )

declare sub 		emitVARINIPAD		( byval bytes as integer )

declare sub 		hWriteStr			( byval addtab as integer, _
										  byval s as string )

declare sub 		emitReset			( )

declare sub 		emitFlush			( )

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
