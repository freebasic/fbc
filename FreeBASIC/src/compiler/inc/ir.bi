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


const IR.INITVREGNODES%		= 1024

const IR.INITADDRNODES%		= 2048

const IR.MAXDIST%			= 32767

enum IRDATACLASS_ENUM
	IR.DATACLASS.INTEGER                        '' must be the first
	IR.DATACLASS.FPOINT
	IR.DATACLASS.STRING							'' /    /  /   last
end enum

'' data types (must be in order of precision and in the other signed/non-signed!)
enum IRDATATYPE_ENUM
	IR.DATATYPE.VOID
	IR.DATATYPE.BYTE
	IR.DATATYPE.UBYTE
	IR.DATATYPE.SHORT
	IR.DATATYPE.USHORT
	IR.DATATYPE.INTEGER
	IR.DATATYPE.LONG		= IR.DATATYPE.INTEGER
	IR.DATATYPE.UINT
	IR.DATATYPE.SINGLE
	IR.DATATYPE.DOUBLE
	IR.DATATYPE.STRING
	IR.DATATYPE.FIXSTR
	IR.DATATYPE.USERDEF
	IR.DATATYPE.FUNCTION
	IR.DATATYPE.POINTER							'' ptr must be the last!
end enum

const IR.MAXDATATYPES% 		= 14-1				'' pointer not taken into account

''
enum IRVREGTYPE_ENUM
	IR.VREGTYPE.OPER							'' used by DAG only
	IR.VREGTYPE.IMM
	IR.VREGTYPE.VAR
	IR.VREGTYPE.IDX
	IR.VREGTYPE.PTR
	IR.VREGTYPE.TMPVAR
	IR.VREGTYPE.REG
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
const IR.OP.NOP%			= 255

enum IROP_ENUM
	IR.OP.LOAD
	IR.OP.STORE
	IR.OP.ADD
	IR.OP.SUB
	IR.OP.MUL
	IR.OP.DIV
	IR.OP.MOD
	IR.OP.AND
	IR.OP.OR
	IR.OP.XOR
	IR.OP.EQ
	IR.OP.GT
	IR.OP.LT
	IR.OP.NE
	IR.OP.LE
	IR.OP.GE
	IR.OP.PUSH
	IR.OP.POP
	IR.OP.NOT
	IR.OP.NEG
	IR.OP.CALL
	IR.OP.JMP
	IR.OP.JEQ
	IR.OP.JGT
	IR.OP.JLT
	IR.OP.JNE
	IR.OP.JLE
	IR.OP.JGE
	IR.OP.INTDIV
	IR.OP.TOINT
	IR.OP.TOFLT
	IR.OP.LABEL
	IR.OP.MOV
	IR.OP.ADDROF
	IR.OP.DEREF
	IR.OP.SHL
	IR.OP.SHR
	IR.OP.POW
	IR.OP.EQV
	IR.OP.IMP
	IR.OP.LDFUNCRESULT
	IR.OP.ABS
	IR.OP.SGN
	IR.OP.CALLPTR
	IR.OP.JUMPPTR
	IR.OP.PUSHUDT
end enum

'' operations below won't reach IR, used by AST
const IR.OP.TOSIGNED%		= 253
const IR.OP.TOUNSIGNED%		= 254


''
type IRVREG
	typ			as integer						'' VAR, IMM, IDX, etc
	dtype		as integer						'' CHAR, INTEGER, ...

	s			as FBSYMBOL ptr					'' symbol
	ofs			as integer						'' +offset
	lgt			as integer						'' *length
	vi			as integer						'' index vreg

	r			as integer						'' reg

	value		as integer						'' imm value
end type

type IRDATATYPE
	class		as integer						'' INTEGER, FPOINT
	size		as integer						'' in bytes
	signed		as integer						'' TRUE or FALSE
	dname		as string * 8
end type

''
''
''
declare sub 		irInit				( )
declare sub 		irEnd				( )

declare function 	irAllocVREG			( byval dtype as integer ) as integer
declare function 	irAllocVRIMM		( byval dtype as integer, byval value as integer ) as integer
declare function 	irAllocVRVAR		( byval dtype as integer, byval symbol as FBSYMBOL ptr, byval ofs as integer ) as integer
declare function 	irAllocVRIDX		( byval dtype as integer, byval symbol as FBSYMBOL ptr, byval ofs as integer, byval lgt as integer, byval vidx as integer ) as integer
declare function 	irAllocVRPTR		( byval dtype as integer, byval ofs as integer, byval vidx as integer ) as integer
declare sub 		irPreserveVR		( byval vreg as integer )
declare sub 		irTrashVR			( byval vreg as integer )
declare function 	irCloneVR			( byval src as integer ) as integer
declare sub 		irCopyVR			( byval src as integer, byval dst as integer )

declare sub 		irEmitPROCBEGIN		( byval proc as FBSYMBOL ptr, byval initlabel as FBSYMBOL ptr, byval endlabel as FBSYMBOL ptr, byval ispublic as integer )
declare sub 		irEmitPROCEND		( byval proc as FBSYMBOL ptr, byval initlabel as FBSYMBOL ptr, byval exitlabel as FBSYMBOL ptr )

declare sub 		irEmitPUSH			( byval v1 as integer )
declare sub 		irEmitPUSHUDT		( byval v1 as integer, byval lgt as integer )
declare sub 		irEmitPOP			( byval v1 as integer )
declare sub 		irEmitBOP			( byval op as integer, byval v1 as integer, byval v2 as integer, byval vr as integer )
declare sub 		irEmitBOPEx			( byval op as integer, byval v1 as integer, byval v2 as integer, byval vr as integer, byval ex as FBSYMBOL ptr )
declare sub 		irEmitUOP			( byval op as integer, byval v1 as integer, byval vr as integer )
declare sub 		irEmitSTORE			( byval v1 as integer, byval v2 as integer )
declare sub 		irEmitLOAD			( byval op as integer, byval v1 as integer )
declare sub 		irEmitCONVERT		( byval v1 as integer, byval dtype1 as integer, byval v2 as integer, byval dtype2 as integer )
declare sub 		irEmitADDR			( byval op as integer, byval v1 as integer, byval vr as integer )

declare sub 		irEmitLABEL			( byval label as FBSYMBOL ptr, byval isglobal as integer )
declare sub 		irEmitLABELNF		( byval label as FBSYMBOL ptr )
declare sub 		irEmitCALL			( pname as string, byval bytestopop as integer, byval isglobal as integer )
declare sub 		irEmitCALLSUB		( byval proc as FBSYMBOL ptr )
declare sub 		irEmitCALLFUNCT		( byval proc as FBSYMBOL ptr, byval bytestopop as integer, byval vr as integer )
declare sub 		irEmitCALLPTR		( byval v1 as integer, byval vr as integer, byval bytestopop as integer )
declare sub 		irEmitBRANCHPTR		( byval v1 as integer )

declare sub 		irEmitBRANCH		( byval op as integer, byval label as FBSYMBOL ptr, byval isglobal as integer )
declare sub 		irEmitBRANCHNF		( byval op as integer, byval label as FBSYMBOL ptr )
declare sub 		irEmitCOMPBRANCH	( byval op as integer, byval v1 as integer, byval v2 as integer, byval label as FBSYMBOL ptr )
declare sub 		irEmitCOMPBRANCHNF	( byval op as integer, byval v1 as integer, byval v2 as integer, byval label as FBSYMBOL ptr )
declare sub 		irEmitRETURN		( byval bytestopop as integer )
declare function	irEmitPUSHPARAM		( byval proc as FBSYMBOL ptr, byval arg as FBPROCARG ptr, _
										  byval vr as integer, byval pmode as integer, _
										  byval plen as integer ) as integer

declare function 	irIsIMM				( byval vreg as integer ) as integer
declare function 	irIsVAR				( byval vreg as integer ) as integer
declare function 	irIsIDX				( byval vreg as integer ) as integer
declare function 	irIsREG				( byval vreg as integer ) as integer

declare function 	irGetVRValue	( byval vreg as integer ) as integer
declare function 	irGetVRDataType	( byval vreg as integer ) as integer
declare function 	irGetVRDataClass( byval vreg as integer ) as integer
declare function 	irGetVRDataSize	( byval vreg as integer ) as integer
declare function 	irGetVRName		( byval vreg as integer ) as string
declare function 	irGetVRNameEx	( byval vreg as integer, byval typ as integer ) as string
declare function 	irGetVRType		( byval vreg as integer ) as integer
declare function 	irGetVRSymbol	( byval vreg as integer ) as FBSYMBOL ptr


declare function 	irMaxDataType	( byval dtype1 as integer, byval dtype2 as integer ) as integer

declare function 	irGetDataClass  ( byval dtype as integer ) as integer
declare function 	irGetDataSize	( byval dtype as integer ) as integer
declare function 	irIsSigned		( byval dtype as integer ) as integer

declare function 	irGetSignedType	( byval dtype as integer ) as integer
declare function 	irGetUnsignedType( byval dtype as integer ) as integer

declare function 	irGetVARSymbol	( byval vreg as integer ) as FBSYMBOL ptr
declare function 	irGetVAROffset	( byval vreg as integer ) as integer

declare sub 		irFlush 		( )
declare function 	irGetDistance	( byval vreg as integer ) as integer
declare function 	irGetVRRealValue( byval vreg as integer ) as integer

declare function 	irGetInverseLogOp( byval op as integer ) as integer

declare sub 		irLoadVR		( byval reg as integer, byval vreg as integer )
declare sub 		irStoreVR		( byval vreg as integer, byval reg as integer )
declare sub 		irSetVR			( byval reg as integer, byval vreg as integer )
declare sub 		irXchgTOS		( byval reg as integer )

