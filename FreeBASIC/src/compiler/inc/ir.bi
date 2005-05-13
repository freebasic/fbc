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


const IR.INITVREGNODES		= 1024

const IR.INITADDRNODES		= 2048

const IR.MAXDIST			= 65536

enum IRDATACLASS_ENUM
	IR.DATACLASS.INTEGER                        '' must be the first
	IR.DATACLASS.FPOINT
	IR.DATACLASS.STRING							'' /    /  /   last
	IR.DATACLASS.UDT
	IR.DATACLASS.FUNCT
	IR.DATACLASS.UNKNOWN
end enum

'' data types (must be in order of precision and in the other signed/non-signed!)
enum IRDATATYPE_ENUM
	IR.DATATYPE.VOID
	IR.DATATYPE.BYTE
	IR.DATATYPE.UBYTE
	IR.DATATYPE.CHAR
	IR.DATATYPE.SHORT
	IR.DATATYPE.USHORT
	IR.DATATYPE.INTEGER
	IR.DATATYPE.LONG		= IR.DATATYPE.INTEGER
	IR.DATATYPE.UINT
	IR.DATATYPE.LONGINT
	IR.DATATYPE.ULONGINT
	IR.DATATYPE.SINGLE
	IR.DATATYPE.DOUBLE
	IR.DATATYPE.STRING
	IR.DATATYPE.FIXSTR
	IR.DATATYPE.USERDEF
	IR.DATATYPE.FUNCTION
	IR.DATATYPE.FWDREF
	IR.DATATYPE.POINTER							'' ptr must be the last!
end enum

const IR.MAXDATATYPES 		= 18-1				'' pointer not taken into account

''
enum IRVREGTYPE_ENUM
	IR.VREGTYPE.OPER							'' used by DAG only
	IR.VREGTYPE.IMM
	IR.VREGTYPE.VAR
	IR.VREGTYPE.IDX
	IR.VREGTYPE.PTR
	IR.VREGTYPE.TMPVAR
	IR.VREGTYPE.REG
	IR.VREGTYPE.OFS
end enum

''
enum IROPTYPE_ENUM
	IR.OPTYPE.BINARY
	IR.OPTYPE.UNARY
	IR.OPTYPE.LOAD
	IR.OPTYPE.STORE
	IR.OPTYPE.BRANCH
	IR.OPTYPE.COMP
	IR.OPTYPE.CONVERT
	IR.OPTYPE.CALL
	IR.OPTYPE.STACK
	IR.OPTYPE.ADDRESSING
end enum

''
const IR.OP.NOP			= 255

enum IROP_ENUM
	IR.OP.LOAD
	IR.OP.LOADRESULT
	IR.OP.STORE
	IR.OP.ADD
	IR.OP.SUB
	IR.OP.MUL
	IR.OP.DIV
	IR.OP.MOD
	IR.OP.AND
	IR.OP.OR
	IR.OP.XOR
	IR.OP.SHL
	IR.OP.SHR
	IR.OP.POW
	IR.OP.EQV
	IR.OP.IMP
	IR.OP.MOV
	IR.OP.EQ
	IR.OP.GT
	IR.OP.LT
	IR.OP.NE
	IR.OP.LE
	IR.OP.GE
	IR.OP.JEQ
	IR.OP.JGT
	IR.OP.JLT
	IR.OP.JNE
	IR.OP.JLE
	IR.OP.JGE
	IR.OP.NOT
	IR.OP.NEG
	IR.OP.ABS
	IR.OP.SGN
	IR.OP.JMP
	IR.OP.CALL
	IR.OP.LABEL
	IR.OP.PUSH
	IR.OP.POP
	IR.OP.PUSHUDT
	IR.OP.INTDIV
	IR.OP.TOINT
	IR.OP.TOFLT
	IR.OP.ADDROF
	IR.OP.DEREF
	IR.OP.CALLFUNCT
	IR.OP.CALLPTR
	IR.OP.STACKALIGN
	IR.OP.JUMPPTR
	IR.OP.SIN
	IR.OP.ASIN
	IR.OP.COS
	IR.OP.ACOS
	IR.OP.TAN
	IR.OP.ATAN
	IR.OP.SQRT
	IR.OP.LOG
	IR.OP.FLOOR
	IR.OP.ATAN2
end enum

'' operations below won't reach IR, used by AST
const IR.OP.TOSIGNED		= 253
const IR.OP.TOUNSIGNED		= 254

''
type IRVREG_ as IRVREG
type IRTAC_ as IRTAC

type IRTACVREG
	vreg		as IRVREG_ ptr
	next		as IRTACVREG ptr
end type

type IRTAC
	nxt			as IRTAC ptr					'' linked-list field

	pos			as integer

	op			as integer						'' opcode

	res			as IRTACVREG                    '' result
	arg1		as IRTACVREG                    '' operand 1
	arg2		as IRTACVREG					'' operand 2

	ex1			as FBSYMBOL ptr					'' extra field, used by call/jmp
	ex2			as integer						'' /
end type

type IRVREG
	nxt			as IRVREG ptr					'' linked-list field

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
	dname		as string * 7
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

declare sub 		irEmit				( byval op as integer, _
										  byval v1 as IRVREG ptr, _
										  byval v2 as IRVREG ptr, _
										  byval vr as IRVREG ptr, _
										  byval ex1 as FBSYMBOL ptr = NULL, _
										  byval ex2 as integer = 0 )

declare sub 		irEmitPROCBEGIN		( byval proc as FBSYMBOL ptr, _
										  byval initlabel as FBSYMBOL ptr, _
										  byval endlabel as FBSYMBOL ptr, _
										  byval ispublic as integer )

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

declare sub 		irEmitVARINIPAD		( byval bytes as integer )

declare sub 		irEmitCONVERT		( byval v1 as IRVREG ptr, _
										  byval dtype1 as integer, _
										  byval v2 as IRVREG ptr, _
										  byval dtype2 as integer )

declare sub 		irEmitLABEL			( byval label as FBSYMBOL ptr, _
										  byval isglobal as integer )

declare sub 		irEmitRETURN		( byval bytestopop as integer )

declare function	irEmitPUSHPARAM		( byval proc as FBSYMBOL ptr, _
										  byval arg as FBSYMBOL ptr, _
										  byval vr as IRVREG ptr, _
										  byval pmode as integer, _
										  byval plen as integer ) as integer

declare function 	irIsVAR				( byval vreg as IRVREG ptr ) as integer

declare function 	irIsIDX				( byval vreg as IRVREG ptr ) as integer

declare function 	irGetVRDataClass	( byval vreg as IRVREG ptr ) as integer

declare function 	irGetVRDataSize		( byval vreg as IRVREG ptr ) as integer

declare sub 		irGetVRNameEx		( byval vreg as IRVREG ptr, _
										  byval typ as integer, _
										  vname as string )

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
#define irIsREG(v) iif( v->typ = IR.VREGTYPE.REG, TRUE, FALSE )

#define irIsIMM(v) iif( v->typ = IR.VREGTYPE.IMM, TRUE, FALSE )


#define irGetVRType(v) v->typ

#define irGetVRDataType(v) v->dtype

#define irGetVRName(v,n) irGetVRNameEx( v, v->typ, n )


#define irEmitBOP(op,v1,v2,vr) irEmit( op, v1, v2, vr )

#define irEmitBOPEx(op,v1,v2,vr,ex) irEmit( op, v1, v2, vr, ex )

#define irEmitUOP(op,v1,vr) irEmit( op, v1, NULL, vr )

#define irEmitSTORE(v1,v2) irEmit( IR.OP.STORE, v1, v2, NULL )

#define irEmitLOAD(op,v1) irEmit( op, v1, NULL, NULL )

#define irEmitPUSH(v1) irEmit( IR.OP.PUSH, v1, NULL, NULL )

#define irEmitPUSHUDT(v1,lgt) irEmit( IR.OP.PUSHUDT, v1, NULL, NULL, NULL, lgt )

#define irEmitPOP(v1) irEmit( IR.OP.POP, v1, NULL, NULL )

#define irEmitADDR(op,v1,vr) irEmit( op, v1, NULL, vr )

#define irEmitLABELNF(l) irEmit( IR.OP.LABEL, NULL, NULL, NULL, l )

#define irEmitCALLFUNCT(proc,bytestopop,vr) irEmit( IR.OP.CALLFUNCT, NULL, NULL, vr, proc, bytestopop )

#define irEmitCALLPTR(v1,vr,bytestopop) irEmit( IR.OP.CALLPTR, v1, NULL, vr, NULL, bytestopop )

#define irEmitSTACKALIGN(bytes) irEmit( IR.OP.STACKALIGN, NULL, NULL, NULL, NULL, bytes )

#define irEmitBRANCHPTR(v1) irEmit( IR.OP.JUMPPTR, v1, NULL, NULL, NULL )

#define irEmitBRANCH(op,label) irEmit( op, NULL, NULL, NULL, label )


#endif '' __IR_BI__
