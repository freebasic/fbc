#ifndef __IR_BI__
#define __IR_BI__

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


const IR_INITVREGNODES		= 1024

const IR_INITADDRNODES		= 2048

const IR_MAXDIST			= 2147483647

''
enum IRVREGTYPE_ENUM
	IR_VREGTYPE_OPER							'' used by DAG only
	IR_VREGTYPE_IMM
	IR_VREGTYPE_VAR
	IR_VREGTYPE_IDX
	IR_VREGTYPE_PTR
	IR_VREGTYPE_REG
	IR_VREGTYPE_OFS
end enum

''
enum IROPTYPE_ENUM
	IR_OPTYPE_BINARY
	IR_OPTYPE_UNARY
	IR_OPTYPE_LOAD
	IR_OPTYPE_STORE
	IR_OPTYPE_BRANCH
	IR_OPTYPE_COMP
	IR_OPTYPE_CONVERT
	IR_OPTYPE_CALL
	IR_OPTYPE_STACK
	IR_OPTYPE_ADDRESS
	IR_OPTYPE_MEM
end enum

''

''
type IRVREG_ as IRVREG
type IRTAC_ as IRTAC

type IRTACVREG
	vreg		as IRVREG_ ptr
	pParent		as IRVREG_ ptr ptr              '' pointer to parent if idx or aux
	next		as IRTACVREG ptr				'' next in tac (-> vr, v1 or v2)
end type

type IRTACVREG_GRP
	reg			as IRTACVREG
	idx			as IRTACVREG					'' index
	aux			as IRTACVREG                    '' auxiliary
end type

type IRTAC
	ll_nxt		as IRTAC ptr					'' linked-list field

	pos			as integer

	op			as AST_OPCODE					'' opcode

	vr			as IRTACVREG_GRP                   '' result
	v1			as IRTACVREG_GRP                   '' operand 1
	v2			as IRTACVREG_GRP				'' operand 2

	ex1			as FBSYMBOL ptr					'' extra field, used by call/jmp
	ex2			as integer						'' /
end type

type IRVREG
	ll_nxt		as IRVREG ptr					'' linked-list field

	typ			as IRVREGTYPE_ENUM				'' VAR, IMM, IDX, etc
	dtype		as FB_DATATYPE					'' CHAR, INTEGER, ...

	reg			as integer						'' reg
	value		as integer						'' imm value (hi-word of longint's at vaux->value)

	sym			as FBSYMBOL ptr					'' symbol
	ofs			as integer						'' +offset
	mult		as integer						'' multipler

	vidx		as IRVREG ptr					'' index vreg
	vaux		as IRVREG ptr					'' aux vreg (used with longint's)

	tacvhead	as IRTACVREG ptr				'' back-link to tac table
	tacvtail	as IRTACVREG ptr				'' /
	taclast		as IRTAC ptr					'' /
end type

''
''
''
declare sub 		irInit				( )

declare sub 		irEnd				( )

declare function 	irAllocVREG			( byval dtype as integer ) as IRVREG ptr

declare function 	irAllocVRIMM		( byval dtype as integer, _
										  byval value as integer ) as IRVREG ptr

declare function 	irAllocVRIMM64		( byval dtype as integer, _
										  byval value as longint ) as IRVREG ptr

declare function 	irAllocVRVAR		( byval dtype as integer, _
										  byval symbol as FBSYMBOL ptr, _
										  byval ofs as integer ) as IRVREG ptr

declare function 	irAllocVRIDX		( byval dtype as integer, _
										  byval symbol as FBSYMBOL ptr, _
										  byval ofs as integer, _
										  byval mult as integer, _
										  byval vidx as IRVREG ptr ) as IRVREG ptr

declare function 	irAllocVRPTR		( byval dtype as integer, _
										  byval ofs as integer, _
										  byval vidx as IRVREG ptr ) as IRVREG ptr

declare function 	irAllocVROFS		( byval dtype as integer, _
					   					  byval symbol as FBSYMBOL ptr ) as IRVREG ptr

declare sub 		irProcBegin			( byval proc as FBSYMBOL ptr )

declare sub 		irProcEnd			( byval proc as FBSYMBOL ptr )

declare sub 		irScopeBegin		( byval s as FBSYMBOL ptr )

declare sub 		irScopeEnd			( byval s as FBSYMBOL ptr )

declare sub 		irEmit				( byval op as integer, _
										  byval v1 as IRVREG ptr, _
										  byval v2 as IRVREG ptr, _
										  byval vr as IRVREG ptr, _
										  byval ex1 as FBSYMBOL ptr = NULL, _
										  byval ex2 as integer = 0 )

declare sub 		irEmitPROCBEGIN		( byval proc as FBSYMBOL ptr, _
					 					  byval initlabel as FBSYMBOL ptr )

declare sub 		irEmitPROCEND		( byval proc as FBSYMBOL ptr, _
										  byval initlabel as FBSYMBOL ptr, _
										  byval exitlabel as FBSYMBOL ptr )

declare sub 		irEmitSCOPEBEGIN	( byval s as FBSYMBOL ptr )

declare sub 		irEmitSCOPEEND		( byval s as FBSYMBOL ptr )

declare sub 		irEmitVARINIBEGIN	( byval sym as FBSYMBOL ptr )

declare sub 		irEmitVARINIEND		( byval sym as FBSYMBOL ptr )

declare sub 		irEmitVARINIi		( byval dtype as integer, _
										  byval value as integer )

declare sub 		irEmitVARINIf		( byval dtype as integer, _
										  byval value as double )

declare sub 		irEmitVARINI64		( byval dtype as integer, _
										  byval value as longint )

declare sub 		irEmitVARINIOFS		( byval sym as FBSYMBOL ptr )

declare sub 		irEmitVARINISTR		( byval totlgt as integer, _
				     					  byval litstr as zstring ptr, _
				     					  byval litlgt as integer )

declare sub 		irEmitVARINIWSTR	( byval totlgt as integer, _
				     					  byval litstr as wstring ptr, _
				     					  byval litlgt as integer )

declare sub 		irEmitVARINIPAD		( byval bytes as integer )

declare sub 		irEmitCONVERT		( byval v1 as IRVREG ptr, _
										  byval dtype1 as integer, _
										  byval v2 as IRVREG ptr, _
										  byval dtype2 as integer )

declare sub 		irEmitLABEL			( byval label as FBSYMBOL ptr )

declare sub 		irEmitRETURN		( byval bytestopop as integer )

declare function	irEmitPUSHARG		( byval proc as FBSYMBOL ptr, _
										  byval param as FBSYMBOL ptr, _
										  byval vr as IRVREG ptr, _
										  byval pmode as integer, _
										  byval plen as integer ) as integer

declare sub 		irEmitASM			( byval text as zstring ptr )

declare sub 		irEmitCOMMENT		( byval text as zstring ptr )

declare sub 		irEmitJMPTB			( byval dtype as integer, _
				 						  byval label as FBSYMBOL ptr )

declare sub 		irEmitDBG			( byval proc as FBSYMBOL ptr, _
										  byval op as integer, _
			   							  byval ex as integer )

declare function 	irIsVAR				( byval vreg as IRVREG ptr ) as integer

declare function 	irIsIDX				( byval vreg as IRVREG ptr ) as integer

declare function 	irGetVRDataClass	( byval vreg as IRVREG ptr ) as integer

declare function 	irGetVRDataSize		( byval vreg as IRVREG ptr ) as integer

declare sub 		irFlush 			( )

declare function 	irGetDistance		( byval vreg as IRVREG ptr ) as uinteger

declare sub 		irLoadVR			( byval reg as integer, _
										  byval vreg as IRVREG ptr, _
										  byval doload as integer = TRUE )

declare sub 		irStoreVR			( byval vreg as IRVREG ptr, _
										  byval reg as integer )

declare sub 		irSetVR				( byval reg as integer, _
										  byval vreg as IRVREG ptr )

declare sub 		irXchgTOS			( byval reg as integer )


''
'' macros
''
#define irIsREG(v) iif( v->typ = IR_VREGTYPE_REG, TRUE, FALSE )

#define irIsIMM(v) iif( v->typ = IR_VREGTYPE_IMM, TRUE, FALSE )


#define irGetVRType(v) v->typ

#define irGetVRDataType(v) v->dtype


#define irEmitBOP(op,v1,v2,vr) irEmit( op, v1, v2, vr )

#define irEmitBOPEx(op,v1,v2,vr,ex) irEmit( op, v1, v2, vr, ex )

#define irEmitUOP(op,v1,vr) irEmit( op, v1, NULL, vr )

#define irEmitSTORE(v1,v2) irEmit( AST_OP_STORE, v1, v2, NULL )

#define irEmitSPILLREGS() irEmit( AST_OP_SPILLREGS, NULL, NULL, NULL )

#define irEmitLOAD(v1) irEmit( AST_OP_LOAD, v1, NULL, NULL )

#define irEmitLOADRES(v1,vr) irEmit( AST_OP_LOADRESULT, v1, NULL, vr )

#define irEmitSTACK(op,v1) irEmit( op, v1, NULL, NULL )

#define irEmitPUSH(v1) irEmitSTACK( AST_OP_PUSH, v1 )

#define irEmitPOP(v1) irEmitSTACK( AST_OP_POP, v1 )

#define irEmitPUSHUDT(v1,lgt) irEmit( AST_OP_PUSHUDT, v1, NULL, NULL, NULL, lgt )

#define irEmitADDR(op,v1,vr) irEmit( op, v1, NULL, vr )

#define irEmitLABELNF(l) irEmit( AST_OP_LABEL, NULL, NULL, NULL, l )

#define irEmitCALLFUNCT(proc,bytestopop,vr) irEmit( AST_OP_CALLFUNCT, NULL, NULL, vr, proc, bytestopop )

#define irEmitCALLPTR(v1,vr,bytestopop) irEmit( AST_OP_CALLPTR, v1, NULL, vr, NULL, bytestopop )

#define irEmitSTACKALIGN(bytes) irEmit( AST_OP_STACKALIGN, NULL, NULL, NULL, NULL, bytes )

#define irEmitJUMPPTR(v1) irEmit( AST_OP_JUMPPTR, v1, NULL, NULL, NULL )

#define irEmitBRANCH(op,label) irEmit( op, NULL, NULL, NULL, label )

#define irEmitMEM(op,v1,v2,bytes) irEmit( op, v1, v2, NULL, 0, bytes )

#define irEmitSTKCLEAR(bytes,baseofs) irEmit( AST_OP_STKCLEAR, NULL, NULL, NULL, cast( any ptr, baseofs ), bytes )


#define ISLONGINT(t) ((t = FB_DATATYPE_LONGINT) or (t = FB_DATATYPE_ULONGINT))


#endif '' __IR_BI__
