#ifndef __AST_BI__
#define __AST_BI__

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


#include once "inc\list.bi"

const AST_INITTEMPSTRINGS		= 32*4
const AST_INITTEMPARRAYS		= 32*4

const AST_INITNODES				= 8192
const AST_INITPROCNODES			= 128

'' if order is changed, update the opTB array at ir.bas
enum AST_OPCODE
	AST_OP_LOAD				= 0
	AST_OP_LOADRESULT
	AST_OP_STORE
	AST_OP_SPILLREGS
	AST_OP_ADD
	AST_OP_SUB
	AST_OP_MUL
	AST_OP_DIV
	AST_OP_INTDIV
	AST_OP_MOD
	AST_OP_AND
	AST_OP_OR
	AST_OP_XOR
	AST_OP_EQV
	AST_OP_IMP
	AST_OP_SHL
	AST_OP_SHR
	AST_OP_POW
	AST_OP_MOV
	AST_OP_ATAN2
	AST_OP_EQ
	AST_OP_GT
	AST_OP_LT
	AST_OP_NE
	AST_OP_GE
	AST_OP_LE
	AST_OP_NOT
	AST_OP_NEG
	AST_OP_ABS
	AST_OP_SGN
	AST_OP_SIN
	AST_OP_ASIN
	AST_OP_COS
	AST_OP_ACOS
	AST_OP_TAN
	AST_OP_ATAN
	AST_OP_SQRT
	AST_OP_LOG
	AST_OP_FLOOR
	AST_OP_ADDROF
	AST_OP_DEREF
	AST_OP_TOINT
	AST_OP_TOFLT
	AST_OP_PUSH
	AST_OP_POP
	AST_OP_PUSHUDT
	AST_OP_STACKALIGN
	AST_OP_JEQ
	AST_OP_JGT
	AST_OP_JLT
	AST_OP_JNE
	AST_OP_JGE
	AST_OP_JLE
	AST_OP_JMP
	AST_OP_CALL
	AST_OP_LABEL
	AST_OP_RET
	AST_OP_CALLFUNCT
	AST_OP_CALLPTR
	AST_OP_JUMPPTR
	AST_OP_MEMMOVE
	AST_OP_MEMSWAP
	AST_OP_MEMCLEAR
	AST_OP_STKCLEAR

	AST_OP_DBG_LINEINI
	AST_OP_DBG_LINEEND
	AST_OP_DBG_SCOPEINI
	AST_OP_DBG_SCOPEEND
	AST_OP_TOPOINTER
	AST_OP_TOSIGNED
	AST_OP_TOUNSIGNED

	AST_OPCODES									'' total
end enum

enum AST_NODECLASS
	AST_NODECLASS_NOP
	AST_NODECLASS_LINK
	AST_NODECLASS_CONST
	AST_NODECLASS_VAR
	AST_NODECLASS_IDX
	AST_NODECLASS_FIELD
	AST_NODECLASS_ENUM
	AST_NODECLASS_BOP
	AST_NODECLASS_UOP
	AST_NODECLASS_CALL
	AST_NODECLASS_ARG
	AST_NODECLASS_PTR
	AST_NODECLASS_ADDR
	AST_NODECLASS_ASSIGN
	AST_NODECLASS_CONV
	AST_NODECLASS_LOAD
	AST_NODECLASS_BRANCH
	AST_NODECLASS_IIF
	AST_NODECLASS_OFFSET
	AST_NODECLASS_STACK
	AST_NODECLASS_LABEL
	AST_NODECLASS_LIT
	AST_NODECLASS_ASM
	AST_NODECLASS_JMPTB
	AST_NODECLASS_DBG
	AST_NODECLASS_MEM
	AST_NODECLASS_BOUNDCHK
	AST_NODECLASS_PTRCHK
	AST_NODECLASS_SCOPEBEGIN
	AST_NODECLASS_SCOPEEND
	AST_NODECLASS_SCOPE_BREAK
	AST_NODECLASS_TYPEINI
	AST_NODECLASS_TYPEINI_PAD
	AST_NODECLASS_TYPEINI_EXPR
	AST_NODECLASS_PROC
end enum

#ifndef ASTNODE_
type ASTNODE_ as ASTNODE
#endif

type ASTTEMPSTR
	tmpsym			as FBSYMBOL ptr
	srctree			as ASTNODE_ ptr
	prev			as ASTTEMPSTR ptr
end type

type ASTTEMPARRAY
	pdesc			as FBSYMBOL ptr
	prev			as ASTTEMPARRAY ptr
end type

''
type AST_CALL
	isrtl			as integer

	args			as integer
	currarg			as FBSYMBOL ptr
	lastarg			as ASTNODE_ ptr					'' used to speed up PASCAL conv. only

	arraytail 		as ASTTEMPARRAY ptr
	strtail 		as ASTTEMPSTR ptr

	profbegin		as ASTNODE_ ptr
	profend			as ASTNODE_ ptr
end type

type AST_ARG
	mode			as integer						'' to pass NULL's to byref args, etc
	lgt				as integer						'' length, used to push UDT's by value
end type

type AST_VAR
	ofs				as integer						'' offset
end type

type AST_IDX
	ofs				as integer						'' offset
	mult			as integer						'' multipler
end type

type AST_PTR
	ofs				as integer						'' offset
end type

type AST_IIF
	falselabel 		as FBSYMBOL ptr
end type

type AST_LOAD
	isres			as integer
end type

type AST_LABEL
	flush			as integer
end type

type AST_LIT
	text			as zstring ptr
end type

type FB_ASMTOK_ as FB_ASMTOK

type AST_ASM
	head			as FB_ASMTOK_ ptr
end type

type AST_OP                                        	'' used by: bop, uop, conv & addr
	op				as integer
	allocres 		as integer
	ex				as FBSYMBOL ptr					'' (extra: label, etc)
end type

type AST_CONST
	val				as FBVALUE
end type

type AST_JMPTB
	label			as FBSYMBOL ptr
end type

type AST_DBG
	ex				as integer
	op				as integer
end type

type AST_MEM
	bytes			as integer
	op				as integer
end type

type AST_STACK
	op				as integer
end type

type AST_TYPEINI
	ofs				as integer
    bytes			as integer
end type

type AST_BREAK
	parent			as ASTNODE_ ptr
	scope			as integer
	linenum			as integer
	stmtnum			as integer						'' can't use colnum as it's unreliable
end type

type AST_BREAKLIST
	head			as ASTNODE_ ptr
	tail			as ASTNODE_ ptr
end type

type AST_BLOCK
	parent			as ASTNODE_ ptr
	inistmt			as integer
	endstmt			as integer
	ismain			as integer
	initlabel		as FBSYMBOL ptr
	exitlabel		as FBSYMBOL ptr
	breaklist		as AST_BREAKLIST
end type

''
type ASTNODE
	class			as integer						'' CONST, VAR, BOP, UOP, IDX, FUNCT, etc

	dtype			as integer
	subtype			as FBSYMBOL ptr					'' if dtype is an USERDEF or ENUM

	defined 		as integer						'' only true for constants

	sym				as FBSYMBOL ptr					'' attached symbol

	union
		con			as AST_CONST
		var			as AST_VAR
		idx			as AST_IDX
		ptr			as AST_PTR
		call		as AST_CALL
		arg			as AST_ARG
		iif			as AST_IIF
		op			as AST_OP
		lod			as AST_LOAD
		lbl			as AST_LABEL
		lit			as AST_LIT
		asm			as AST_ASM
		jmptb		as AST_JMPTB
		dbg			as AST_DBG
		mem			as AST_MEM
		stack		as AST_STACK
		typeini		as AST_TYPEINI
		block		as AST_BLOCK					'' shared by PROC and SCOPE nodes
		break		as AST_BREAK
	end union

	prev			as ASTNODE ptr					'' used by Add
	next			as ASTNODE ptr					'' /

	l				as ASTNODE ptr					'' left node, index of ast tb
	r				as ASTNODE ptr					'' right /     /
end type

type AST_PROCCTX
	head			as ASTNODE ptr
	tail			as ASTNODE ptr
	curr			as ASTNODE ptr
	oldns			as FBSYMBOL ptr					'' last namespace
	oldsymtb		as FBSYMBOLTB ptr
	oldhashtb		as FBHASHTB ptr
end type

type ASTCTX
	astTB			as TLIST

	proc			as AST_PROCCTX

	currblock		as ASTNODE ptr					'' current scope block (PROC or SCOPE)

	doemit			as integer
	isopt			as integer

	tempstr			as TLIST
	temparray		as TLIST

	typeinicnt		as integer
end Type

type ASTVALUE
	dtype			as integer
	val				as FBVALUE
end type


#include once "inc\ir.bi"


declare sub 		astInit				( _
											_
										)

declare sub 		astEnd				( _
											_
										)

declare sub 		astDelNode			( _
											byval n as ASTNODE ptr _
										)

declare function 	astCloneTree		( _
											byval n as ASTNODE ptr _
										) as ASTNODE ptr

declare sub 		astDelTree			( _
											byval n as ASTNODE ptr _
										)

declare function 	astIsTreeEqual		( _
											byval l as ASTNODE ptr, _
											byval r as ASTNODE ptr _
										) as integer

declare function 	astIsADDR			( _
											byval n as ASTNODE ptr _
										) as integer

declare sub 		astConvertValue     ( _
											byval n as ASTNODE ptr, _
											byval v as FBVALUE ptr, _
											byval todtype as integer _
										)

declare function 	astGetValueAsInt	( _
											byval n as ASTNODE ptr _
										) as integer

declare function 	astGetValueAsLongInt( _
											byval n as ASTNODE ptr _
										) as longint

declare function 	astGetValueAsULongInt( _
											byval n as ASTNODE ptr _
										) as ulongint

declare function 	astGetValueAsDouble ( _
											byval n as ASTNODE ptr _
										) as double

declare function 	astGetValueAsStr	( _
											byval n as ASTNODE ptr _
										) as string

declare function 	astGetValueAsWstr	( _
											byval n as ASTNODE ptr _
										) as wstring ptr

declare function 	astProcBegin		( _
											byval proc as FBSYMBOL ptr, _
					   					  	byval ismain as integer = FALSE _
										) as ASTNODE ptr

declare function	astProcEnd			( _
											byval p as ASTNODE ptr, _
											byval callrtexit as integer = FALSE _
										) as integer

declare function	astScopeBegin		( _
											_
										) as ASTNODE ptr

declare sub 		astScopeEnd			( _
											byval s as ASTNODE ptr _
										)

declare function 	astScopeBreak		( _
											byval tolabel as FBSYMBOL ptr _
										) as integer

declare function 	astScopeUpdBreakList( _
											byval proc as ASTNODE ptr _
										) as integer

declare sub			astAdd				( _
											byval n as ASTNODE ptr _
										)

declare sub 		astAddAfter			( _
											byval n as ASTNODE ptr, _
											byval p as ASTNODE ptr _
										)

declare sub 		astAddBefore		( _
											byval n as ASTNODE ptr, _
											byval p as ASTNODE ptr _
										)

declare function	astUpdComp2Branch	( _
											byval n as ASTNODE ptr, _
											byval label as FBSYMBOL ptr, _
											byval isinverse as integer _
										) as ASTNODE ptr

declare function 	astPtrCheck			( _
											byval pdtype as integer, _
											byval psubtype as FBSYMBOL ptr, _
											byval expr as ASTNODE ptr _
										) as integer

declare function 	astFuncPtrCheck		( _
											byval pdtype as integer, _
											byval psubtype as FBSYMBOL ptr, _
											byval expr as ASTNODE ptr _
										) as integer

declare function 	astNewNOP			( _
											_
										) as ASTNODE ptr

declare function 	astNewASSIGN		( _
											byval l as ASTNODE ptr, _
											byval r as ASTNODE ptr, _
											byval checktypes as integer = TRUE _
										) as ASTNODE ptr

declare function 	astNewCONV			( _
											byval op as integer, _
											byval to_dtype as integer, _
											byval to_subtype as FBSYMBOL ptr, _
											byval l as ASTNODE ptr, _
											byval check_str as integer = FALSE _
										) as ASTNODE ptr

declare function 	astNewBOP			( _
											byval op as integer, _
											byval l as ASTNODE ptr, _
											byval r as ASTNODE ptr, _
											byval ex as FBSYMBOL ptr = NULL, _
											byval allocres as integer = TRUE _
										) as ASTNODE ptr

declare function 	astNewUOP			( _
											byval op as integer, _
											byval o as ASTNODE ptr _
										) as ASTNODE ptr

declare function 	astNewCONST			( _
											byval v as FBVALUE ptr, _
											byval dtype as integer _
										) as ASTNODE ptr

declare function 	astNewCONSTstr		( _
											byval v as zstring ptr _
										) as ASTNODE ptr

declare function 	astNewCONSTwstr		( _
											byval v as wstring ptr _
										) as ASTNODE ptr

declare function 	astNewCONSTi		( _
											byval value as integer, _
											byval dtype as integer, _
											byval subtype as FBSYMBOL ptr = NULL _
										) as ASTNODE ptr

declare function 	astNewCONSTf		( _
											byval value as double, _
											byval dtype as integer _
										) as ASTNODE ptr

declare function 	astNewCONSTl		( _
											byval value as longint, _
											byval dtype as integer _
										) as ASTNODE ptr

declare function 	astNewVAR			( _
											byval sym as FBSYMBOL ptr, _
											byval ofs as integer = 0, _
											byval dtype as integer = FB_DATATYPE_INTEGER, _
											byval subtype as FBSYMBOL ptr = NULL _
										) as ASTNODE ptr

declare function 	astNewIDX			( _
											byval v as ASTNODE ptr, _
											byval i as ASTNODE ptr, _
											byval dtype as integer, _
											byval subtype as FBSYMBOL ptr _
										) as ASTNODE ptr

declare function 	astNewFIELD			( _
											byval p as ASTNODE ptr, _
											byval sym as FBSYMBOL ptr, _
											byval dtype as integer = FB_DATATYPE_INTEGER, _
											byval subtype as FBSYMBOL ptr = NULL _
										) as ASTNODE ptr

declare function 	astNewPTR			( _
											byval ofs as integer, _
											byval l as ASTNODE ptr, _
											byval dtype as integer, _
											byval subtype as FBSYMBOL ptr _
										) as ASTNODE ptr

declare function 	astNewCALL			( _
											byval sym as FBSYMBOL ptr, _
											byval ptrexpr as ASTNODE ptr = NULL, _
											byval isprofiler as integer = FALSE _
										) as ASTNODE ptr

declare function 	astNewARG			( _
											byval f as ASTNODE ptr, _
											byval p as ASTNODE ptr, _
											byval dtype as integer = INVALID, _
											byval mode as integer = INVALID _
										) as ASTNODE ptr

declare function 	astNewADDR			( _
											byval op as integer, _
											byval p as ASTNODE ptr _
										) as ASTNODE ptr

declare function 	astNewLOAD			( _
											byval l as ASTNODE ptr, _
											byval dtype as integer, _
											byval isresult as integer = FALSE _
										) as ASTNODE ptr

declare function 	astNewBRANCH		( _
											byval op as integer, _
											byval label as FBSYMBOL ptr, _
											byval l as ASTNODE ptr = NULL _
										) as ASTNODE ptr

declare function 	astNewIIF			( _
											byval condexpr as ASTNODE ptr, _
											byval truexpr as ASTNODE ptr, _
											byval falsexpr as ASTNODE ptr _
										) as ASTNODE ptr

declare function 	astNewOFFSET		( _
											byval v as ASTNODE ptr _
										) as ASTNODE ptr

declare function 	astNewLINK			( _
											byval l as ASTNODE ptr, _
					 					  	byval r as ASTNODE ptr _
										) as ASTNODE ptr

declare function 	astNewSTACK			( _
											byval op as integer, _
											byval l as ASTNODE ptr _
										) as ASTNODE ptr

declare function 	astNewENUM			( _
											byval value as integer, _
					 					  	byval enum as FBSYMBOL ptr _
										) as ASTNODE ptr

declare function 	astNewLABEL			( _
											byval sym as FBSYMBOL ptr, _
											byval doflush as integer = TRUE _
										) as ASTNODE ptr

declare function 	astNewLIT			( _
											byval text as zstring ptr _
										) as ASTNODE ptr

declare function 	astNewASM			( _
											byval listhead as FB_ASMTOK_ ptr _
										) as ASTNODE ptr

declare function 	astNewJMPTB			( _
											byval dtype as integer, _
											byval label as FBSYMBOL ptr _
										) as ASTNODE ptr

declare function 	astNewDBG			( _
											byval op as integer, _
											byval ex as integer = 0 _
										) as ASTNODE ptr

declare function 	astNewMEM			( _
											byval op as integer, _
											byval l as ASTNODE ptr, _
											byval r as ASTNODE ptr, _
											byval bytes as integer _
										) as ASTNODE ptr

declare function 	astNewBOUNDCHK		( _
											byval l as ASTNODE ptr, _
											byval lb as ASTNODE ptr, _
											byval ub as ASTNODE ptr, _
											byval linenum as integer _
										) as ASTNODE ptr

declare function 	astNewPTRCHK		( _
											byval l as ASTNODE ptr, _
											byval linenum as integer _
										) as ASTNODE ptr

declare sub 		astDump 			( _
											byval p as ASTNODE ptr, _
											byval n as ASTNODE ptr, _
											byval isleft as integer, _
											byval ln as integer, _
											byval cn as integer _
										)

declare function 	astNewNode			( _
											byval class_ as integer, _
											byval dtype as integer, _
											byval subtype as FBSYMBOL ptr = NULL _
										) as ASTNODE ptr

declare function 	astLoad				( _
											byval n as ASTNODE ptr _
										) as IRVREG ptr

declare function 	astOptimize			( _
											byval n as ASTNODE ptr _
										) as ASTNODE ptr

declare function 	astOptAssignment	( _
											byval n as ASTNODE ptr _
										) as ASTNODE ptr

declare function 	astCheckConst		( _
											byval dtype as integer, _
											byval n as ASTNODE ptr _
										) as ASTNODE ptr

declare function 	astCheckASSIGN		( _
											byval l as ASTNODE ptr, _
											byval r as ASTNODE ptr _
										) as integer

declare function 	astCheckCONV		( _
											byval to_dtype as integer, _
											byval to_subtype as FBSYMBOL ptr, _
											byval l as ASTNODE ptr _
										) as integer

declare function	astUpdStrConcat		( _
											byval n as ASTNODE ptr _
										) as ASTNODE ptr

declare function 	astIsClassOnTree	( _
											byval class as integer, _
						   				  	byval n as ASTNODE ptr _
										) as ASTNODE ptr

declare function 	astIsSymbolOnTree	( _
											byval sym as FBSYMBOL ptr, _
											byval n as ASTNODE ptr _
										) as integer

declare function 	astGetStrLitSymbol	( _
											byval n as ASTNODE ptr _
										) as FBSYMBOL ptr

declare sub 		astBuildVAR			( _
											byval n as ASTNODE ptr, _
				 						  	byval sym as FBSYMBOL ptr, _
				 						  	byval ofs as integer, _
				 						  	byval dtype as integer, _
				 						  	byval subtype as FBSYMBOL ptr = NULL _
										)

declare function 	astTypeIniBegin		( _
											byval dtype as integer, _
						  				  	byval subtype as FBSYMBOL ptr _
										) as ASTNODE ptr

declare sub 		astTypeIniEnd		( _
											byval tree as ASTNODE ptr, _
											byval isinitializer as integer _
										)

declare function 	astTypeIniAddPad	( _
											byval tree as ASTNODE ptr, _
						   				  	byval bytes as integer _
										) as ASTNODE ptr

declare function 	astTypeIniAddExpr	( _
											byval tree as ASTNODE ptr, _
						 				  	byval expr as ASTNODE ptr, _
						 				  	byval sym as FBSYMBOL ptr, _
						 				  	byval ofs as integer _
										) as ASTNODE ptr

declare function 	astTypeIniFlush		( _
											byval tree as ASTNODE ptr, _
						  				  	byval basesym as FBSYMBOL ptr, _
						  				  	byval isstatic as integer, _
						  				  	byval isinitializer as integer _
										) as integer

declare function 	astTypeIniIsConst	( _
											byval tree as ASTNODE ptr _
										) as integer

declare function 	astTypeIniUpdate	( _
											byval tree as ASTNODE ptr _
										) as ASTNODE ptr

declare sub 		astTypeIniUpdCnt	( _
											byval tree as ASTNODE ptr _
										)

declare function 	astTypeIniGetHead	( _
											byval tree as ASTNODE ptr _
										) as ASTNODE ptr

declare function 	astGetInverseLogOp	( _
											byval op as integer _
										) as integer


''
'' macros
''
#define astInitNode(n, class_, dtype, subtype)		:_
	n->class 		= class_						:_
	n->dtype 		= dtype							:_
	n->subtype		= subtype						:_
	n->defined		= FALSE							:_
	n->l    		= NULL							:_
	n->r    		= NULL							:_
	n->sym			= NULL

#define astCopy(dst, src) *dst = *src

#define astSwap(dst, src) swap *dst, *src

#define astGetClass(n) n->class

#define astGetLeft( n ) n->l

#define astGetRight( n ) n->r

#define astIsCONST(n) n->defined

#define astIsVAR(n) (n->class = AST_NODECLASS_VAR)

#define astIsIDX(n) (n->class = AST_NODECLASS_IDX)

#define astIsFUNCT(n) (n->class = AST_NODECLASS_CALL)

#define astIsPTR(n) (n->class = AST_NODECLASS_PTR)

#define astIsOFFSET(n) (n->class = AST_NODECLASS_OFFSET)

#define astIsFIELD(n) (n->class = AST_NODECLASS_FIELD)

#define astGetValue(n) n->con.val

#define astGetValInt(n) n->con.val.int

#define astGetValFloat(n) n->con.val.float

#define astGetValLong(n) n->con.val.long

#define astGetDataType(n) n->dtype

#define astGetSubtype(n) n->subtype

#define astGetDataClass(n) symbGetDataClass( n->dtype )

#define astGetDataSize(n) symbGetDataSize( n->dtype )

#define astGetSymbol(n)	n->sym

#define astGetProcInitlabel(n) n->block.initlabel

#define astGetProcExitlabel(n) n->block.exitlabel

#define astSetDataType(n, _dtype) 							_
    n->dtype = _dtype                                       :_
	if( n->class = AST_NODECLASS_FIELD ) then               :_
		n->l->dtype = _dtype                                :_
	end if

#define astSetType(n, _dtype, _subtype) 					_
    n->dtype   = _dtype                                     :_
    n->subtype = _subtype                                   :_
	if( n->class = AST_NODECLASS_FIELD ) then               :_
		n->l->dtype   = _dtype                              :_
		n->l->subtype = _subtype                            :_
	end if

#define astTypeIniGetOfs( n ) n->typeini.ofs

''
'' inter-module globals
''
extern ast as ASTCTX

extern ast_bitmaskTB( 0 to 32 ) as uinteger

extern ast_minlimitTB( FB_DATATYPE_BYTE to FB_DATATYPE_ULONGINT ) as longint

#endif '' __AST_BI__
