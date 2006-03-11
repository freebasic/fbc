#ifndef __AST_BI__
#define __AST_BI__

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
	AST_NODECLASS_FUNCT
	AST_NODECLASS_PARAM
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
	AST_NODECLASS_SCOPE
	AST_NODECLASS_TYPEINI
	AST_NODECLASS_TYPEINI_PAD
	AST_NODECLASS_TYPEINI_EXPR
end enum

#ifndef ASTNODE_
type ASTNODE_ as ASTNODE
#endif

type ASTTEMPSTR
	ll_prv			as ASTTEMPSTR ptr				'' linked-list nodes
	ll_nxt			as ASTTEMPSTR ptr				'' /

	tmpsym			as FBSYMBOL ptr
	srctree			as ASTNODE_ ptr
	prev			as ASTTEMPSTR ptr
end type

type ASTTEMPARRAY
	ll_prv			as ASTTEMPARRAY ptr				'' linked-list nodes
	ll_nxt			as ASTTEMPARRAY ptr				'' /

	pdesc			as FBSYMBOL ptr
	prev			as ASTTEMPARRAY ptr
end type

''
type AST_FUNCT
	isrtl			as integer

	params			as integer
	arg				as FBSYMBOL ptr
	lastparam		as ASTNODE_ ptr					'' used to speed up PASCAL calling conv. only

	arraytail 		as ASTTEMPARRAY ptr
	strtail 		as ASTTEMPSTR ptr

	profbegin		as ASTNODE_ ptr
	profend			as ASTNODE_ ptr
end type

type AST_PARAM
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
	sym				as FBSYMBOL ptr
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

type AST_STK
	op				as integer
end type

type AST_CHK
	sym				as FBSYMBOL ptr
end type

type AST_SCOPE
	sym				as FBSYMBOL ptr
end type

type AST_TYPEINI
	ofs				as integer
    bytes			as integer
end type

''
type ASTNODE
	ll_prv			as ASTNODE ptr					'' linked-list nodes
	ll_nxt			as ASTNODE ptr					'' /  (can't be swapped/copied!)

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
		proc		as AST_FUNCT
		param		as AST_PARAM
		iif			as AST_IIF
		op			as AST_OP
		lod			as AST_LOAD
		lbl			as AST_LABEL
		lit			as AST_LIT
		asm			as AST_ASM
		jtb			as AST_JMPTB
		dbg			as AST_DBG
		mem			as AST_MEM
		stk			as AST_STK
		chk			as AST_CHK
		scp			as AST_SCOPE
		typeini		as AST_TYPEINI
	end union

	prev			as ASTNODE ptr					'' used by Add
	next			as ASTNODE ptr					'' /

	l				as ASTNODE ptr					'' left node, index of ast tb
	r				as ASTNODE ptr					'' right /     /
end type

''
type ASTPROCNODE
	ll_prv			as ASTPROCNODE ptr				'' linked-list nodes
	ll_nxt			as ASTPROCNODE ptr				'' /

	proc			as FBSYMBOL ptr
	ismain			as integer

	initlabel		as FBSYMBOL ptr
	exitlabel		as FBSYMBOL ptr

	head			as ASTNODE ptr					'' first node
	tail			as ASTNODE ptr					'' last node
end type

type ASTCTX
	astTB			as TLIST

	proclist		as TLIST
	curproc			as ASTPROCNODE ptr
	oldsymtb		as FBSYMBOLTB ptr

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


declare sub 		astInit				( )

declare sub 		astEnd				( )

declare sub 		astDel				( byval n as ASTNODE ptr )

declare function 	astCloneTree		( byval n as ASTNODE ptr ) as ASTNODE ptr

declare sub 		astDelTree			( byval n as ASTNODE ptr )

declare function 	astIsTreeEqual		( byval l as ASTNODE ptr, _
										  byval r as ASTNODE ptr ) as integer

declare function 	astIsADDR			( byval n as ASTNODE ptr ) as integer

declare sub 		astConvertValue     ( byval n as ASTNODE ptr, _
					       				  byval v as FBVALUE ptr, _
					       				  byval todtype as integer )

declare function 	astGetValueAsInt	( byval n as ASTNODE ptr ) as integer

declare function 	astGetValueAsLongInt( byval n as ASTNODE ptr ) as longint

declare function 	astGetValueAsULongInt( byval n as ASTNODE ptr ) as ulongint

declare function 	astGetValueAsDouble ( byval n as ASTNODE ptr ) as double

declare function 	astGetValueAsStr	( byval n as ASTNODE ptr ) as string

declare function 	astGetValueAsWstr	( byval n as ASTNODE ptr ) as wstring ptr

declare function 	astProcBegin		( byval proc as FBSYMBOL ptr, _
					   					  byval ismain as integer = FALSE ) as ASTPROCNODE ptr

declare sub 		astProcEnd			( byval p as ASTPROCNODE ptr, _
										  byval callrtexit as integer = FALSE )

declare function	astScopeBegin		( ) as ASTNODE ptr

declare sub 		astScopeEnd			( byval s as ASTNODE ptr )

declare sub			astAdd				( byval n as ASTNODE ptr )

declare sub 		astAddAfter			( byval n as ASTNODE ptr, _
										  byval p as ASTNODE ptr )

declare function	astUpdComp2Branch	( byval n as ASTNODE ptr, _
										  byval label as FBSYMBOL ptr, _
						    			  byval isinverse as integer ) as ASTNODE ptr

declare function 	astPtrCheck			( byval pdtype as integer, _
					  					  byval psubtype as FBSYMBOL ptr, _
					  					  byval expr as ASTNODE ptr ) as integer

declare function 	astFuncPtrCheck		( byval pdtype as integer, _
					      				  byval psubtype as FBSYMBOL ptr, _
					      				  byval expr as ASTNODE ptr ) as integer

declare function 	astNewNOP			( ) as ASTNODE ptr

declare function 	astNewASSIGN		( byval l as ASTNODE ptr, _
										  byval r as ASTNODE ptr, _
										  byval checktypes as integer = TRUE ) as ASTNODE ptr

declare function 	astNewCONV			( byval op as integer, _
										  byval to_dtype as integer, _
										  byval to_subtype as FBSYMBOL ptr, _
										  byval l as ASTNODE ptr, _
										  byval check_str as integer = FALSE ) as ASTNODE ptr

declare function 	astNewBOP			( byval op as integer, _
										  byval l as ASTNODE ptr, _
										  byval r as ASTNODE ptr, _
					  					  byval ex as FBSYMBOL ptr = NULL, _
					  					  byval allocres as integer = TRUE ) as ASTNODE ptr

declare function 	astNewUOP			( byval op as integer, _
										  byval o as ASTNODE ptr ) as ASTNODE ptr

declare function 	astNewCONST			( byval v as FBVALUE ptr, _
					  					  byval dtype as integer ) as ASTNODE ptr

declare function 	astNewCONSTstr		( byval v as zstring ptr ) as ASTNODE ptr

declare function 	astNewCONSTwstr		( byval v as wstring ptr ) as ASTNODE ptr

declare function 	astNewCONSTi		( byval value as integer, _
										  byval dtype as integer, _
										  byval subtype as FBSYMBOL ptr = NULL ) as ASTNODE ptr

declare function 	astNewCONSTf		( byval value as double, _
										  byval dtype as integer ) as ASTNODE ptr

declare function 	astNewCONST64		( byval value as longint, _
										  byval dtype as integer ) as ASTNODE ptr

declare function 	astNewVAR			( byval sym as FBSYMBOL ptr, _
										  byval ofs as integer = 0, _
										  byval dtype as integer = FB_DATATYPE_INTEGER, _
										  byval subtype as FBSYMBOL ptr = NULL ) as ASTNODE ptr

declare function 	astNewIDX			( byval v as ASTNODE ptr, _
										  byval i as ASTNODE ptr, _
										  byval dtype as integer, _
										  byval subtype as FBSYMBOL ptr ) as ASTNODE ptr

declare function 	astNewFIELD			( byval p as ASTNODE ptr, _
										  byval sym as FBSYMBOL ptr, _
										  byval dtype as integer = FB_DATATYPE_INTEGER, _
										  byval subtype as FBSYMBOL ptr = NULL ) as ASTNODE ptr

declare function 	astNewPTR			( byval ofs as integer, _
										  byval l as ASTNODE ptr, _
										  byval dtype as integer, _
										  byval subtype as FBSYMBOL ptr ) as ASTNODE ptr

declare function 	astNewFUNCT			( byval sym as FBSYMBOL ptr, _
										  byval ptrexpr as ASTNODE ptr = NULL, _
										  byval isprofiler as integer = FALSE ) as ASTNODE ptr

declare function 	astNewPARAM			( byval f as ASTNODE ptr, _
										  byval p as ASTNODE ptr, _
										  byval dtype as integer = INVALID, _
										  byval mode as integer = INVALID ) as ASTNODE ptr

declare function 	astNewADDR			( byval op as integer, _
										  byval p as ASTNODE ptr ) as ASTNODE ptr

declare function 	astNewLOAD			( byval l as ASTNODE ptr, _
										  byval dtype as integer, _
										  byval isresult as integer = FALSE ) as ASTNODE ptr

declare function 	astNewBRANCH		( byval op as integer, _
										  byval label as FBSYMBOL ptr, _
										  byval l as ASTNODE ptr = NULL ) as ASTNODE ptr

declare function 	astNewIIF			( byval condexpr as ASTNODE ptr, _
										  byval truexpr as ASTNODE ptr, _
										  byval falsexpr as ASTNODE ptr ) as ASTNODE ptr

declare function 	astNewOFFSET		( byval v as ASTNODE ptr ) as ASTNODE ptr

declare function 	astNewLINK			( byval l as ASTNODE ptr, _
					 					  byval r as ASTNODE ptr ) as ASTNODE ptr

declare function 	astNewSTACK			( byval op as integer, _
					  					  byval l as ASTNODE ptr ) as ASTNODE ptr

declare function 	astNewENUM			( byval value as integer, _
					 					  byval enum as FBSYMBOL ptr ) as ASTNODE ptr

declare function 	astNewLABEL			( byval sym as FBSYMBOL ptr, _
					  					  byval doflush as integer = TRUE ) as ASTNODE ptr

declare function 	astNewLIT			( byval text as zstring ptr ) as ASTNODE ptr

declare function 	astNewASM			( byval listhead as FB_ASMTOK_ ptr ) as ASTNODE ptr

declare function 	astNewJMPTB			( byval dtype as integer, _
					   					  byval label as FBSYMBOL ptr ) as ASTNODE ptr

declare function 	astNewDBG			( byval op as integer, _
					   					  byval ex as integer = 0 ) as ASTNODE ptr

declare function 	astNewMEM			( byval op as integer, _
										  byval l as ASTNODE ptr, _
					 					  byval r as ASTNODE ptr, _
					 					  byval bytes as integer ) as ASTNODE ptr

declare function 	astNewBOUNDCHK		( byval l as ASTNODE ptr, _
					     				  byval lb as ASTNODE ptr, _
					     				  byval ub as ASTNODE ptr, _
					     				  byval linenum as integer ) as ASTNODE ptr

declare function 	astNewPTRCHK		( byval l as ASTNODE ptr, _
					   					  byval linenum as integer ) as ASTNODE ptr



declare sub 		astDump 			( byval p as ASTNODE ptr, _
										  byval n as ASTNODE ptr, _
										  byval isleft as integer, _
										  byval ln as integer, _
										  byval cn as integer )

declare function 	astNewNode			( byval class_ as integer, _
									  	  byval dtype as integer, _
									  	  byval subtype as FBSYMBOL ptr = NULL ) as ASTNODE ptr

declare function 	astLoad				( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astOptimize			( byval n as ASTNODE ptr ) as ASTNODE ptr

declare function 	astOptAssignment	( byval n as ASTNODE ptr ) as ASTNODE ptr

declare function 	astCheckConst		( byval dtype as integer, _
					   		    		  byval n as ASTNODE ptr ) as ASTNODE ptr

declare function 	astCheckASSIGN		( byval l as ASTNODE ptr, _
					   	 				  byval r as ASTNODE ptr ) as integer

declare function 	astCheckCONV		( byval to_dtype as integer, _
					   					  byval to_subtype as FBSYMBOL ptr, _
					   					  byval l as ASTNODE ptr ) as integer

declare function	astUpdStrConcat		( byval n as ASTNODE ptr ) as ASTNODE ptr

declare sub 		astCopy				( byval d as ASTNODE ptr, _
			 							  byval s as ASTNODE ptr )

declare sub 		astSwap				( byval d as ASTNODE ptr, _
			 							  byval s as ASTNODE ptr )

declare function 	astIsClassOnTree	( byval class as integer, _
						   				  byval n as ASTNODE ptr ) as ASTNODE ptr

declare function 	astIsSymbolOnTree	( byval sym as FBSYMBOL ptr, _
										  byval n as ASTNODE ptr ) as integer

declare function 	astGetStrLitSymbol	( byval n as ASTNODE ptr ) as FBSYMBOL ptr

declare sub 		astBuildVAR			( byval n as ASTNODE ptr, _
				 						  byval sym as FBSYMBOL ptr, _
				 						  byval ofs as integer, _
				 						  byval dtype as integer, _
				 						  byval subtype as FBSYMBOL ptr = NULL )

declare function 	astTypeIniBegin		( byval dtype as integer, _
						  				  byval subtype as FBSYMBOL ptr ) as ASTNODE ptr

declare sub 		astTypeIniEnd		( byval tree as ASTNODE ptr, _
										  byval isinitializer as integer )

declare function 	astTypeIniAddPad	( byval tree as ASTNODE ptr, _
						   				  byval bytes as integer ) as ASTNODE ptr

declare function 	astTypeIniAddExpr	( byval tree as ASTNODE ptr, _
						 				  byval expr as ASTNODE ptr, _
						 				  byval sym as FBSYMBOL ptr, _
						 				  byval ofs as integer ) as ASTNODE ptr

declare function 	astTypeIniFlush		( byval tree as ASTNODE ptr, _
						  				  byval basesym as FBSYMBOL ptr, _
										  byval doclone as integer, _
						  				  byval isstatic as integer, _
						  				  byval isinitializer as integer ) as integer

declare function 	astTypeIniIsConst	( byval tree as ASTNODE ptr ) as integer

declare function 	astTypeIniUpdate	( byval tree as ASTNODE ptr ) as ASTNODE ptr

''
'' macros
''
#define astInitNode( n, class_, dtype, subtype)		:_
	n->class 		= class_						:_
	n->dtype 		= dtype							:_
	n->subtype		= subtype						:_
	n->defined		= FALSE							:_
	n->l    		= NULL							:_
	n->r    		= NULL							:_
	n->sym			= NULL

#define astGetClass(n) n->class

#define astIsCONST(n) n->defined

#define astIsVAR(n) (n->class = AST_NODECLASS_VAR)

#define astIsIDX(n) (n->class = AST_NODECLASS_IDX)

#define astIsFUNCT(n) (n->class = AST_NODECLASS_FUNCT)

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
