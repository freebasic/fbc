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
#include once "inc\ir.bi"

const AST_INITTEMPSTRINGS		= 32*4
const AST_INITTEMPARRAYS		= 32*4

const AST_INITNODES				= 8192
const AST_INITPROCNODES			= 128

enum ASTNODECLASS_ENUM
	AST_NODECLASS_LINK
	AST_NODECLASS_CONST
	AST_NODECLASS_VAR
	AST_NODECLASS_IDX
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
	AST_NODECLASS_ASM
	AST_NODECLASS_JMPTB
	AST_NODECLASS_DBG
end enum

type ASTNODE_ as ASTNODE

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
	sym				as FBSYMBOL ptr					'' symbol
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
	sym				as FBSYMBOL ptr					'' symbol
	elm				as FBSYMBOL ptr					'' element, if symbol is an UDT
	ofs				as integer						'' offset
end type

type AST_IDX
	ofs				as integer						'' offset
	mult			as integer						'' multipler
end type

type AST_PTR
	sym				as FBSYMBOL ptr					'' symbol
	elm				as FBSYMBOL ptr					'' element, if symbol is an UDT
	ofs				as integer						'' offset
end type

type AST_ADDR
	sym				as FBSYMBOL ptr					'' symbol
	elm				as FBSYMBOL ptr					'' element, if symbol is an UDT
end type

type AST_IIF
	cond			as ASTNODE_ ptr					'' conditonal expression
	falselabel 		as FBSYMBOL ptr
end type

type AST_LOAD
	isres			as integer
end type

type AST_LABEL
	sym				as FBSYMBOL ptr					'' symbol
	flush			as integer
end type

type AST_ASM
	line			as string
end type

type AST_JMPTB
	label			as FBSYMBOL ptr
end type

type AST_DBG
	ex				as integer
end type

''
type ASTNODE
	ll_prv			as ASTNODE ptr					'' linked-list nodes
	ll_nxt			as ASTNODE ptr					'' /  (can't be swapped/copied!)

	class			as integer						'' CONST, VAR, BOP, UOP, IDX, FUNCT, etc

	dtype			as integer
	subtype			as FBSYMBOL ptr					'' if dtype is an USERDEF or ENUM

	defined 		as integer						'' only true for constants
	v				as FBVALUE

	op				as integer						'' f/ BOP, UOP, ... nodes
	allocres 		as integer						'' /
	ex				as FBSYMBOL ptr					'' / (extra: label, etc)
	chkbitfld		as integer

	union
		var			as AST_VAR
		idx			as AST_IDX
		ptr			as AST_PTR
		proc		as AST_FUNCT
		param		as AST_PARAM
		addr		as AST_ADDR
		iif			as AST_IIF
		lod			as AST_LOAD
		lbl			as AST_LABEL
		asm			as AST_ASM
		jtb			as AST_JMPTB
		dbg			as AST_DBG
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

	loctb			as FBSYMBOLTB					'' local symbols list

	head			as ASTNODE ptr					'' first node
	tail			as ASTNODE ptr					'' last node
end type


declare sub 		astInit				( )

declare sub 		astEnd				( )

declare sub 		astDel				( byval n as ASTNODE ptr )

declare function 	astCloneTree		( byval n as ASTNODE ptr ) as ASTNODE ptr

declare sub 		astDelTree			( byval n as ASTNODE ptr )

declare function 	astIsTreeEqual		( byval l as ASTNODE ptr, _
										  byval r as ASTNODE ptr ) as integer

declare function 	astIsADDR			( byval n as ASTNODE ptr ) as integer

declare function 	astGetSymbolOrElm	( byval n as ASTNODE ptr ) as FBSYMBOL ptr

declare function 	astGetSymbol		( byval n as ASTNODE ptr ) as FBSYMBOL ptr

declare function 	astGetElm			( byval n as ASTNODE ptr ) as FBSYMBOL ptr

declare sub 		astConvertValue     ( byval n as ASTNODE ptr, _
					       				  byval v as FBVALUE ptr, _
					       				  byval todtype as integer )

declare function 	astGetValueAsInt	( byval n as ASTNODE ptr ) as integer

declare function 	astGetValueAsStr	( byval n as ASTNODE ptr ) as string

declare function 	astProcBegin		( byval proc as FBSYMBOL ptr, _
					   					  byval initlabel as FBSYMBOL ptr, _
					   					  byval exitlabel as FBSYMBOL ptr, _
					   					  byval ismain as integer = FALSE ) as ASTPROCNODE ptr

declare sub 		astProcEnd			( byval p as ASTPROCNODE ptr )

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

declare function 	astNewASSIGN		( byval l as ASTNODE ptr, _
										  byval r as ASTNODE ptr ) as ASTNODE ptr

declare function 	astNewCONV			( byval op as integer, _
										  byval dtype as integer, _
										  byval subtype as FBSYMBOL ptr, _
										  byval l as ASTNODE ptr ) as ASTNODE ptr

declare function 	astNewBOP			( byval op as integer, _
										  byval l as ASTNODE ptr, _
										  byval r as ASTNODE ptr, _
					  					  byval ex as FBSYMBOL ptr = NULL, _
					  					  byval allocres as integer = TRUE ) as ASTNODE ptr

declare function 	astNewUOP			( byval op as integer, _
										  byval o as ASTNODE ptr ) as ASTNODE ptr

declare function 	astNewCONST			( byval v as FBVALUE ptr, _
					  					  byval dtype as integer ) as ASTNODE ptr

declare function 	astNewCONSTi		( byval value as integer, _
										  byval dtype as integer, _
										  byval subtype as FBSYMBOL ptr = NULL ) as ASTNODE ptr

declare function 	astNewCONSTf		( byval value as double, _
										  byval dtype as integer ) as ASTNODE ptr

declare function 	astNewCONST64		( byval value as longint, _
										  byval dtype as integer ) as ASTNODE ptr

declare function 	astNewVAR			( byval sym as FBSYMBOL ptr, _
										  byval elm as FBSYMBOL ptr = NULL, _
										  byval ofs as integer = 0, _
										  byval dtype as integer = IR_DATATYPE_INTEGER, _
										  byval subtype as FBSYMBOL ptr = NULL ) as ASTNODE ptr

declare function 	astNewIDX			( byval v as ASTNODE ptr, _
										  byval i as ASTNODE ptr, _
										  byval dtype as integer, _
										  byval subtype as FBSYMBOL ptr ) as ASTNODE ptr

declare function 	astNewPTR			( byval sym as FBSYMBOL ptr, _
										  byval elm as FBSYMBOL ptr, _
										  byval ofs as integer, _
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
										  byval p as ASTNODE ptr, _
										  byval sym as FBSYMBOL ptr = NULL, _
										  byval elm as FBSYMBOL ptr = NULL ) as ASTNODE ptr

declare function 	astNewLOAD			( byval l as ASTNODE ptr, _
										  byval dtype as integer, _
										  byval isresult as integer = FALSE ) as ASTNODE ptr

declare function 	astNewBRANCH		( byval op as integer, _
										  byval label as FBSYMBOL ptr, _
										  byval l as ASTNODE ptr = NULL ) as ASTNODE ptr

declare function 	astNewIIF			( byval condexpr as ASTNODE ptr, _
										  byval truexpr as ASTNODE ptr, _
										  byval falsexpr as ASTNODE ptr ) as ASTNODE ptr

declare function 	astNewOFFSET		( byval v as ASTNODE ptr, _
					   					  byval sym as FBSYMBOL ptr = NULL, _
					   					  byval elm as FBSYMBOL ptr = NULL ) as ASTNODE ptr

declare function 	astNewLINK			( byval l as ASTNODE ptr, _
					 					  byval r as ASTNODE ptr ) as ASTNODE ptr

declare function 	astNewSTACK			( byval op as integer, _
					  					  byval l as ASTNODE ptr ) as ASTNODE ptr

declare function 	astNewENUM			( byval value as integer, _
					 					  byval enum as FBSYMBOL ptr ) as ASTNODE ptr

declare function 	astNewLABEL			( byval sym as FBSYMBOL ptr, _
					  					  byval doflush as integer = TRUE ) as ASTNODE ptr

declare function 	astNewASM			( byval asmline as string ) as ASTNODE ptr

declare function 	astNewJMPTB			( byval dtype as integer, _
					   					  byval label as FBSYMBOL ptr ) as ASTNODE ptr

declare function 	astNewDBG			( byval op as integer, _
					   					  byval ex as integer = 0 ) as ASTNODE ptr

declare sub 		astDump 			( byval p as ASTNODE ptr, _
										  byval n as ASTNODE ptr, _
										  byval isleft as integer, _
										  byval ln as integer, _
										  byval cn as integer )


''
'' macros
''
#define astGetClass(n) iif( n <> NULL, n->class, INVALID )

#define astIsCONST(n) n->defined

#define astIsVAR(n) (n->class = AST_NODECLASS_VAR)

#define astIsIDX(n) (n->class = AST_NODECLASS_IDX)

#define astIsFUNCT(n) (n->class = AST_NODECLASS_FUNCT)

#define astIsPTR(n) (n->class = AST_NODECLASS_PTR)

#define astIsOFFSET(n) (n->class = AST_NODECLASS_OFFSET)

#define astGetValuei(n) n->v.valuei

#define astGetValuef(n) n->v.valuef

#define astGetValue64(n) n->v.value64

#define astGetDataType(n) iif( n <> NULL, n->dtype, INVALID )

#define astGetSubtype(n) iif( n <> NULL, n->subtype, NULL )

#define astGetDataClass(n) iif( n <> NULL, irGetDataClass( n->dtype ), INVALID )

#define astGetDataSize(n) iif( n <> NULL, irGetDataSize( n->dtype ), INVALID )

#define astSetDataType(n,t) if( n <> NULL ) then n->dtype = t end if

#define astSetSubType(n,t) if( n <> NULL ) then n->subtype = t end if

#endif '' __AST_BI__
