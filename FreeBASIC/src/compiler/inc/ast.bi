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


'$include once: 'inc\ir.bi'

const AST.INITTEMPSTRINGS		= 32*4
const AST.INITTEMPARRAYS		= 32*4

const AST.INITNODES				= 8192

enum ASTNODECLASS_ENUM
	AST.NODECLASS.LINK
	AST.NODECLASS.CONST
	AST.NODECLASS.VAR
	AST.NODECLASS.IDX
	AST.NODECLASS.ENUM
	AST.NODECLASS.BOP
	AST.NODECLASS.UOP
	AST.NODECLASS.FUNCT
	AST.NODECLASS.PARAM
	AST.NODECLASS.PTR
	AST.NODECLASS.ADDR
	AST.NODECLASS.ASSIGN
	AST.NODECLASS.CONV
	AST.NODECLASS.LOAD
	AST.NODECLASS.BRANCH
	AST.NODECLASS.IIF
	AST.NODECLASS.OFFSET
	AST.NODECLASS.STACK
end enum

type ASTNODE_ as ASTNODE

type ASTTEMPSTR
	prv				as ASTTEMPSTR ptr				'' linked-list nodes
	nxt				as ASTTEMPSTR ptr				'' /

	tmpsym			as FBSYMBOL ptr
	srctree			as ASTNODE_ ptr
	left			as ASTTEMPSTR ptr
end type

type ASTTEMPARRAY
	prv				as ASTTEMPARRAY ptr				'' linked-list nodes
	nxt				as ASTTEMPARRAY ptr				'' /

	pdesc			as FBSYMBOL ptr
	left			as ASTTEMPARRAY ptr
end type

''
type FUNCTNode
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

type PARAMNode
	mode			as integer						'' to pass NULL's to byref args, etc
	lgt				as integer						'' length, used to push UDT's by value
end type

type VARNode
	sym				as FBSYMBOL ptr					'' symbol
	elm				as FBSYMBOL ptr					'' element, if symbol is an UDT
	ofs				as integer						'' offset
end type

type IDXNode
	ofs				as integer						'' offset
	mult			as integer						'' multipler
end type

type PTRNode
	sym				as FBSYMBOL ptr					'' symbol
	elm				as FBSYMBOL ptr					'' element, if symbol is an UDT
	ofs				as integer						'' offset
end type

type ADDRNode
	sym				as FBSYMBOL ptr					'' symbol
	elm				as FBSYMBOL ptr					'' element, if symbol is an UDT
end type

type IIFNode
	cond			as ASTNODE_ ptr					'' conditonal expression
	falselabel 		as FBSYMBOL ptr
end type

''
type ASTNODE
	prv				as ASTNODE ptr					'' 'pointers' used by the allocator,
	nxt				as ASTNODE ptr					'' /  (can't be swapped/copied!)

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
		var			as VARNode
		idx			as IDXNode
		ptr			as PTRNode
		proc		as FUNCTNode
		param		as PARAMNode
		addr		as ADDRNode
		iif			as IIFNode
	end union

	l				as ASTNODE ptr					'' left node, index of ast tb
	r				as ASTNODE ptr					'' right /     /
end type

declare sub 		astInit				( )

declare sub 		astEnd				( )

declare function 	astNew				( byval typ as integer, _
										  byval dtype as integer, _
										  byval subtype as FBSYMBOL ptr = NULL ) as ASTNODE ptr

declare sub 		astDel				( byval n as ASTNODE ptr )

declare function 	astCloneTree		( byval n as ASTNODE ptr ) as ASTNODE ptr

declare sub 		astDelTree			( byval n as ASTNODE ptr )

declare function 	astIsTreeEqual		( byval l as ASTNODE ptr, _
										  byval r as ASTNODE ptr ) as integer

declare function 	astIsADDR			( byval n as ASTNODE ptr ) as integer

declare function 	astGetSymbol		( byval n as ASTNODE ptr ) as FBSYMBOL ptr

declare sub 		astConvertValue     ( byval n as ASTNODE ptr, _
					       				  byval v as FBVALUE ptr, _
					       				  byval todtype as integer )

declare function 	astGetValueAsInt	( byval n as ASTNODE ptr ) as integer

declare function 	astGetValueAsStr	( byval n as ASTNODE ptr ) as string

declare function	astLoad				( byval n as ASTNODE ptr ) as IRVREG ptr

declare function	astFlush			( byval n as ASTNODE ptr ) as IRVREG ptr

declare function	astUpdComp2Branch	( byval n as ASTNODE ptr, _
										  byval label as FBSYMBOL ptr, _
						    			  byval isinverse as integer ) as ASTNODE ptr

declare function 	astNewASSIGN		( byval l as ASTNODE ptr, _
										  byval r as ASTNODE ptr ) as ASTNODE ptr

declare function 	astLoadASSIGN		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astNewCONV			( byval op as integer, _
										  byval dtype as integer, _
										  byval subtype as FBSYMBOL ptr, _
										  byval l as ASTNODE ptr ) as ASTNODE ptr

declare function 	astLoadCONV			( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astNewBOP			( byval op as integer, _
										  byval l as ASTNODE ptr, _
										  r as ASTNODE ptr, _
					  					  byval ex as FBSYMBOL ptr = NULL, _
					  					  byval allocres as integer = TRUE ) as ASTNODE ptr

declare function 	astLoadBOP			( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astNewUOP			( byval op as integer, _
										  byval o as ASTNODE ptr ) as ASTNODE ptr

declare function 	astLoadUOP			( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astNewCONST			( byval v as FBVALUE ptr, _
					  					  byval dtype as integer ) as ASTNODE ptr

declare function 	astNewCONSTi		( byval value as integer, _
										  byval dtype as integer ) as ASTNODE ptr

declare function 	astNewCONSTf		( byval value as double, _
										  byval dtype as integer ) as ASTNODE ptr

declare function 	astNewCONST64		( byval value as longint, _
										  byval dtype as integer ) as ASTNODE ptr

declare function 	astLoadCONST		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astNewVAR			( byval sym as FBSYMBOL ptr, _
										  byval elm as FBSYMBOL ptr = NULL, _
										  byval ofs as integer = 0, _
										  byval dtype as integer = IR.DATATYPE.INTEGER, _
										  byval subtype as FBSYMBOL ptr = NULL ) as ASTNODE ptr

declare function 	astLoadVAR			( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astNewIDX			( byval v as ASTNODE ptr, _
										  byval i as ASTNODE ptr, _
										  byval dtype as integer, _
										  byval subtype as FBSYMBOL ptr ) as ASTNODE ptr

declare function 	astLoadIDX			( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astNewPTR			( byval sym as FBSYMBOL ptr, _
										  byval elm as FBSYMBOL ptr, _
										  byval ofs as integer, _
										  byval expr as ASTNODE ptr, _
										  byval dtype as integer, _
										  byval subtype as FBSYMBOL ptr ) as ASTNODE ptr

declare function 	astLoadPTR			( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astNewFUNCT			( byval sym as FBSYMBOL ptr, _
										  byval dtype as integer, _
										  byval ptrexpr as ASTNODE ptr = NULL, _
										  byval isprofiler as integer = FALSE ) as ASTNODE ptr

declare function 	astNewPARAM			( byval f as ASTNODE ptr, _
										  byval p as ASTNODE ptr, _
										  byval dtype as integer = INVALID, _
										  byval mode as integer = INVALID ) as ASTNODE ptr

declare function 	astLoadFUNCT		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astNewADDR			( byval op as integer, _
										  byval p as ASTNODE ptr, _
										  byval sym as FBSYMBOL ptr = NULL, _
										  byval elm as FBSYMBOL ptr = NULL ) as ASTNODE ptr

declare function 	astLoadADDR			( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astNewLOAD			( byval l as ASTNODE ptr, _
										  byval dtype as integer ) as ASTNODE ptr

declare function 	astLoadLOAD			( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astNewBRANCH		( byval op as integer, _
										  byval label as FBSYMBOL ptr, _
										  byval l as ASTNODE ptr = NULL ) as ASTNODE ptr

declare function 	astLoadBRANCH		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astNewIIF			( byval condexpr as ASTNODE ptr, _
										  byval truexpr as ASTNODE ptr, _
										  byval falsexpr as ASTNODE ptr ) as ASTNODE ptr

declare function 	astLoadIIF			( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astNewOFFSET		( byval v as ASTNODE ptr, _
					   					  byval sym as FBSYMBOL ptr = NULL, _
					   					  byval elm as FBSYMBOL ptr = NULL ) as ASTNODE ptr

declare function 	astLoadOFFSET		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astNewLINK			( byval l as ASTNODE ptr, _
					 					  byval r as ASTNODE ptr ) as ASTNODE ptr

declare function 	astLoadLINK			( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astNewSTACK			( byval op as integer, _
					  					  byval l as ASTNODE ptr ) as ASTNODE ptr

declare function 	astLoadSTACK		( byval n as ASTNODE ptr ) as IRVREG ptr

declare function 	astNewENUM			( byval value as integer, _
					 					  byval enum as FBSYMBOL ptr ) as ASTNODE ptr

declare function 	astLoadENUM			( byval n as ASTNODE ptr ) as IRVREG ptr

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

#define astIsVAR(n) (n->class = AST.NODECLASS.VAR)

#define astIsIDX(n) (n->class = AST.NODECLASS.IDX)

#define astIsFUNCT(n) (n->class = AST.NODECLASS.FUNCT)

#define astIsPTR(n) (n->class = AST.NODECLASS.PTR)

#define astIsOFFSET(n) (n->class = AST.NODECLASS.OFFSET)

#define astGetValuei(n) n->v.valuei

#define astGetValuef(n) n->v.valuef

#define astGetValue64(n) n->v.value64

#define astGetDataType(n) iif( n <> NULL, n->dtype, INVALID )

#define astGetSubtype(n) iif( n <> NULL, n->subtype, NULL )

#define astGetDataClass(n) iif( n <> NULL, irGetDataClass( n->dtype ), INVALID )

#define astGetDataSize(n) iif( n <> NULL, irGetDataSize( n->dtype ), INVALID )

#define astSetDataType(n,t) if( n <> NULL ) then n->dtype = t end if

#endif '' __AST_BI__
