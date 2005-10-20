#ifndef __IR_BI__
#define __IR_BI__

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


const IR_INITVREGNODES		= 1024

const IR_INITADDRNODES		= 2048

const IR_MAXDIST			= 65536

enum IRDATACLASS_ENUM
	IR_DATACLASS_INTEGER                        '' must be the first
	IR_DATACLASS_FPOINT
	IR_DATACLASS_STRING
	IR_DATACLASS_UDT
	IR_DATACLASS_UNKNOWN
end enum

'' data types (must be in order of precision and in the signed/non-signed order!)
enum IRDATATYPE_ENUM
	IR_DATATYPE_VOID
	IR_DATATYPE_BYTE
	IR_DATATYPE_UBYTE
	IR_DATATYPE_CHAR
	IR_DATATYPE_SHORT
	IR_DATATYPE_USHORT
	IR_DATATYPE_WCHAR
	IR_DATATYPE_INTEGER
	IR_DATATYPE_LONG		= IR_DATATYPE_INTEGER
	IR_DATATYPE_UINT
	IR_DATATYPE_ENUM
	IR_DATATYPE_LONGINT
	IR_DATATYPE_ULONGINT
	IR_DATATYPE_SINGLE
	IR_DATATYPE_DOUBLE
	IR_DATATYPE_STRING
	IR_DATATYPE_FIXSTR
	IR_DATATYPE_USERDEF
	IR_DATATYPE_FUNCTION
	IR_DATATYPE_FWDREF
	IR_DATATYPE_POINTER							'' ptr must be the last!

	IR_MAXDATATYPES
end enum

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
enum IROP_ENUM									'' if order is changed, update the opTB array
	IR_OP_LOAD				= 0
	IR_OP_LOADRESULT
	IR_OP_STORE
	IR_OP_SPILLREGS
	IR_OP_ADD
	IR_OP_SUB
	IR_OP_MUL
	IR_OP_DIV
	IR_OP_INTDIV
	IR_OP_MOD
	IR_OP_AND
	IR_OP_OR
	IR_OP_XOR
	IR_OP_EQV
	IR_OP_IMP
	IR_OP_SHL
	IR_OP_SHR
	IR_OP_POW
	IR_OP_MOV
	IR_OP_ATAN2
	IR_OP_EQ
	IR_OP_GT
	IR_OP_LT
	IR_OP_NE
	IR_OP_GE
	IR_OP_LE
	IR_OP_NOT
	IR_OP_NEG
	IR_OP_ABS
	IR_OP_SGN
	IR_OP_SIN
	IR_OP_ASIN
	IR_OP_COS
	IR_OP_ACOS
	IR_OP_TAN
	IR_OP_ATAN
	IR_OP_SQRT
	IR_OP_LOG
	IR_OP_FLOOR
	IR_OP_ADDROF
	IR_OP_DEREF
	IR_OP_TOINT
	IR_OP_TOFLT
	IR_OP_PUSH
	IR_OP_POP
	IR_OP_PUSHUDT
	IR_OP_STACKALIGN
	IR_OP_JEQ
	IR_OP_JGT
	IR_OP_JLT
	IR_OP_JNE
	IR_OP_JGE
	IR_OP_JLE
	IR_OP_JMP
	IR_OP_CALL
	IR_OP_LABEL
	IR_OP_RET
	IR_OP_CALLFUNCT
	IR_OP_CALLPTR
	IR_OP_JUMPPTR
	IR_OP_MEMMOVE
	IR_OP_MEMSWAP
	IR_OP_MEMCLEAR

	IR_OPS										'' total
end enum

'' operations below won't reach IR, used by AST
enum
	IR_OP_DBG_LINEINI		= 200
	IR_OP_DBG_LINEEND
	IR_OP_DBG_SCOPEINI
	IR_OP_DBG_SCOPEEND
	IR_OP_TOPOINTER
	IR_OP_TOSIGNED
	IR_OP_TOUNSIGNED
end enum

''
type IRVREG_ as IRVREG
type IRTAC_ as IRTAC

type IRTACVREG
	vreg		as IRVREG_ ptr
	next		as IRTACVREG ptr
end type

type IRTAC
	next		as IRTAC ptr					'' linked-list field

	pos			as integer

	op			as integer						'' opcode

	res			as IRTACVREG                    '' result
	arg1		as IRTACVREG                    '' operand 1
	arg2		as IRTACVREG					'' operand 2

	ex1			as FBSYMBOL ptr					'' extra field, used by call/jmp
	ex2			as integer						'' /
end type

type IRVREG
	next		as IRVREG ptr					'' linked-list field

	typ			as integer						'' VAR, IMM, IDX, etc
	dtype		as integer						'' CHAR, INTEGER, ...

	reg			as integer						'' reg
	value		as integer						'' imm value (high word of longint's at vaux->value)

	sym			as FBSYMBOL ptr					'' symbol
	ofs			as integer						'' +offset
	mult		as integer						'' multipler

	vidx		as IRVREG ptr					'' index vreg
	vaux		as IRVREG ptr					'' aux vreg (used with longint's)

	tacvhead	as IRTACVREG ptr				'' back-link to tac table
	tacvtail	as IRTACVREG ptr				'' /
	taclast		as IRTAC ptr					'' /
end type

type IRDATATYPE
	class		as integer						'' INTEGER, FPOINT
	size		as integer						'' in bytes
	bits		as integer						'' number of bits
	signed		as integer						'' TRUE or FALSE
	remaptype	as integer						'' remapped type for ENUM, POINTER, etc
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
				     					  byval litstr as string, _
				     					  byval litlgt as integer )

declare sub 		irEmitVARINIWSTR	( byval totlgt as integer, _
				     					  byval litstr as string, _
				     					  byval litlgt as integer )

declare sub 		irEmitVARINIPAD		( byval bytes as integer )

declare sub 		irEmitCONVERT		( byval v1 as IRVREG ptr, _
										  byval dtype1 as integer, _
										  byval v2 as IRVREG ptr, _
										  byval dtype2 as integer )

declare sub 		irEmitLABEL			( byval label as FBSYMBOL ptr )

declare sub 		irEmitRETURN		( byval bytestopop as integer )

declare function	irEmitPUSHPARAM		( byval proc as FBSYMBOL ptr, _
										  byval arg as FBSYMBOL ptr, _
										  byval vr as IRVREG ptr, _
										  byval pmode as integer, _
										  byval plen as integer ) as integer

declare sub 		irEmitASM			( byval text as string )

declare sub 		irEmitCOMMENT		( byval text as string )

declare sub 		irEmitJMPTB			( byval dtype as integer, _
				 						  byval label as FBSYMBOL ptr )

declare sub 		irEmitDBG			( byval proc as FBSYMBOL ptr, _
										  byval op as integer, _
			   							  byval ex as integer )

declare sub 		irEmitMEM			( byval op as integer, _
			   							  byval v1 as IRVREG ptr, _
			   							  byval v2 as IRVREG ptr, _
			   							  byval bytes as integer )

declare function 	irIsVAR				( byval vreg as IRVREG ptr ) as integer

declare function 	irIsIDX				( byval vreg as IRVREG ptr ) as integer

declare function 	irGetVRDataClass	( byval vreg as IRVREG ptr ) as integer

declare function 	irGetVRDataSize		( byval vreg as IRVREG ptr ) as integer

declare function 	irMaxDataType		( byval dtype1 as integer, _
										  byval dtype2 as integer ) as integer

declare function 	irGetDataClass  	( byval dtype as integer ) as integer

declare function 	irGetDataSize		( byval dtype as integer ) as integer

declare function 	irGetDataBits		( byval dtype as integer ) as integer

declare function 	irIsSigned			( byval dtype as integer ) as integer

declare function 	irGetSignedType		( byval dtype as integer ) as integer

declare function 	irGetUnsignedType	( byval dtype as integer ) as integer

declare sub 		irFlush 			( )

declare function 	irGetDistance		( byval vreg as IRVREG ptr ) as uinteger

declare function 	irGetInverseLogOp	( byval op as integer ) as integer

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

#define irEmitSTORE(v1,v2) irEmit( IR_OP_STORE, v1, v2, NULL )

#define irEmitSPILLREGS() irEmit( IR_OP_SPILLREGS, NULL, NULL, NULL )

#define irEmitLOAD(v1) irEmit( IR_OP_LOAD, v1, NULL, NULL )

#define irEmitLOADRES(v1,vr) irEmit( IR_OP_LOADRESULT, v1, NULL, vr )

#define irEmitSTACK(op,v1) irEmit( op, v1, NULL, NULL )

#define irEmitPUSH(v1) irEmitSTACK( IR_OP_PUSH, v1 )

#define irEmitPOP(v1) irEmitSTACK( IR_OP_POP, v1 )

#define irEmitPUSHUDT(v1,lgt) irEmit( IR_OP_PUSHUDT, v1, NULL, NULL, NULL, lgt )

#define irEmitADDR(op,v1,vr) irEmit( op, v1, NULL, vr )

#define irEmitLABELNF(l) irEmit( IR_OP_LABEL, NULL, NULL, NULL, l )

#define irEmitCALLFUNCT(proc,bytestopop,vr) irEmit( IR_OP_CALLFUNCT, NULL, NULL, vr, proc, bytestopop )

#define irEmitCALLPTR(v1,vr,bytestopop) irEmit( IR_OP_CALLPTR, v1, NULL, vr, NULL, bytestopop )

#define irEmitSTACKALIGN(bytes) irEmit( IR_OP_STACKALIGN, NULL, NULL, NULL, NULL, bytes )

#define irEmitJUMPPTR(v1) irEmit( IR_OP_JUMPPTR, v1, NULL, NULL, NULL )

#define irEmitBRANCH(op,label) irEmit( op, NULL, NULL, NULL, label )


#define ISLONGINT(t) ((t = IR_DATATYPE_LONGINT) or (t = IR_DATATYPE_ULONGINT))


#endif '' __IR_BI__
