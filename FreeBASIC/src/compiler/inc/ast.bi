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


const AST.MAXTEMPSTRINGS		= 32
const AST.MAXTEMPARRAYDESCS		= 32

const AST.INITNODES				= 2048

enum ASTNODECLASS_ENUM
	AST.NODECLASS.CONST
	AST.NODECLASS.VAR
	AST.NODECLASS.BOP
	AST.NODECLASS.UOP
	AST.NODECLASS.IDX
	AST.NODECLASS.FUNCT
	AST.NODECLASS.PARAM
	AST.NODECLASS.PTR
	AST.NODECLASS.ADDR
	AST.NODECLASS.ASSIGN
	AST.NODECLASS.CONV
	AST.NODECLASS.LOAD
	AST.NODECLASS.BRANCH
	AST.NODECLASS.IIF
end enum

type FUNCTNode
	sym				as FBSYMBOL ptr					'' symbol
	params			as integer
	arg				as FBPROCARG ptr
	lastparam		as integer						'' used to speed up PASCAL calling conv. only
	tmparraybase 	as integer
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
	cond			as integer						'' conditonal expression
	falselabel 		as FBSYMBOL ptr
end type

type ASTNode
	prv				as integer						'' 'pointers' used by the allocator,
	nxt				as integer						'' /  (can't be swapped/copied!)

	class			as integer						'' CONST, VAR, BOP, UOP, IDX, FUNCT, etc

	dtype			as integer						'' BYTE, INTEGER, SINGLE, DOUBLE, USERDEF, etc
	subtype			as FBSYMBOL ptr					'' if dtype is an USERDEF

	defined 		as integer						'' only true for constants
	value			as double						'' /

	op				as integer						'' f/ BOP, UOP, ... nodes
	allocres 		as integer						'' /
	ex				as FBSYMBOL ptr					'' / (extra: label, etc)

	union
		var			as VARNode
		idx			as IDXNode
		ptr			as PTRNode
		proc		as FUNCTNode
		param		as PARAMNode
		addr		as ADDRNode
		iif			as IIFNode
	end union

	l				as integer						'' left node, index of ast tb
	r				as integer						'' right /     /
end type


declare sub 		astInit				( )
declare sub 		astEnd				( )
declare function 	astNew				( byval typ as integer, byval dtype as integer, _
										  byval subtype as FBSYMBOL ptr = NULL ) as integer
declare sub 		astDel				( byval n as integer )

declare function 	astCloneTree		( byval n as integer ) as integer
declare sub 		astDelTree			( byval n as integer )
declare function 	astIsTreeEqual		( byval l as integer, byval r as integer ) as integer

declare function 	astGetClass			( byval n as integer ) as integer
declare function 	astGetDataType		( byval n as integer ) as integer
declare function 	astGetSubtype		( byval n as integer ) as FBSYMBOL ptr
declare function 	astGetDataClass		( byval n as integer ) as integer
declare function 	astGetDataSize		( byval n as integer ) as integer
declare function 	astGetValue			( byval n as integer ) as double
declare function 	astGetSymbol		( byval n as integer ) as FBSYMBOL ptr

declare sub 		astLoad				( byval n as integer, dst as integer )
declare sub 		astBinOperation		( byval op as integer, byval v1 as integer, byval v2 as integer, byval vr as integer, byval ex as FBSYMBOL ptr )
declare sub 		astUnaOperation		( byval op as integer, byval v1 as integer, byval vr as integer )
declare sub 		astAddrOperation	( byval op as integer, byval v1 as integer, byval vr as integer )

declare sub 		astFlush			( byval n as integer, vreg as integer )

declare sub 		astUpdComp2Branch	( n as integer, byval label as FBSYMBOL ptr, _
						    			  byval isinverse as integer )

declare sub 		astUpdNodeResult	( byval n as integer )

declare function 	astNewASSIGN		( byval l as integer, byval r as integer ) as integer
declare sub 		astLoadASSIGN		( byval n as integer, vr as integer )

declare function 	astNewCONV			( byval op as integer, byval dtype as integer, byval l as integer ) as integer
declare sub 		astLoadCONV			( byval n as integer, vr as integer )

declare function 	astNewBOP			( byval op as integer, byval l as integer, r as integer, _
					  					  byval ex as FBSYMBOL ptr = NULL, byval allocres as integer = TRUE ) as integer
declare sub 		astLoadBOP			( byval n as integer, vr as integer )

declare function 	astNewUOP			( byval op as integer, byval o as integer ) as integer
declare sub 		astLoadUOP			( byval n as integer, vr as integer )

declare function 	astNewCONST			( byval value as double, byval dtype as integer ) as integer
declare sub 		astLoadCONST		( byval n as integer, vr as integer )

declare function 	astNewVAR			( byval sym as FBSYMBOL ptr, byval elm as FBSYMBOL ptr, _
										  byval ofs as integer, _
										  byval dtype as integer, byval subtype as FBSYMBOL ptr = NULL ) as integer
declare sub 		astLoadVAR			( byval n as integer, vr as integer )

declare function 	astNewIDX			( byval v as integer, byval i as integer, _
										  byval dtype as integer, byval subtype as FBSYMBOL ptr ) as integer
declare sub 		astLoadIDX			( byval n as integer, vr as integer )

declare function 	astNewPTR			( byval sym as FBSYMBOL ptr, byval elm as FBSYMBOL ptr, _
										  byval ofs as integer, byval expr as integer, _
										  byval dtype as integer, byval subtype as FBSYMBOL ptr ) as integer
declare sub 		astLoadPTR			( byval n as integer, vreg as integer )

declare function 	astNewFUNCT			( byval sym as FBSYMBOL ptr, byval dtype as integer ) as integer
declare function 	astNewFUNCTPTR		( byval ptrexpr as integer, byval sym as FBSYMBOL ptr, _
										  byval dtype as integer ) as integer
declare function 	astNewPARAM			( byval f as integer, byval p as integer, _
										  byval dtype as integer = INVALID, byval mode as integer = INVALID ) as integer
declare sub 		astLoadFUNCT		( byval n as integer, vr as integer )

declare function 	astNewADDR			( byval op as integer, byval p as integer, _
										  byval sym as FBSYMBOL ptr = NULL, byval elm as FBSYMBOL ptr = NULL, _
										  byval dtype as integer = INVALID, byval subtype as FBSYMBOL ptr = NULL ) as integer
declare sub 		astLoadADDR			( byval n as integer, vr as integer )

declare function 	astNewLOAD			( byval l as integer, byval dtype as integer ) as integer
declare sub 		astLoadLOAD			( byval n as integer, vr as integer )

declare function 	astNewBRANCH		( byval op as integer, byval label as FBSYMBOL ptr, _
										  byval l as integer = INVALID ) as integer
declare sub 		astLoadBRANCH		( byval n as integer, vr as integer )

declare function 	astNewIIF			( byval condexpr as integer, byval truexpr as integer, _
										  byval falsexpr as integer ) as integer
declare sub 		astLoadIIF			( byval n as integer, vr as integer )

declare sub 		astDump1 			( byval p as integer, byval n as integer, byval isleft as integer, byval ln as integer, byval cn as integer )
