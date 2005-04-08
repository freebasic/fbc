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
const AST.MAXTEMPARRAYS			= 32

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

type ASTTEMPSTR
	prv				as ASTTEMPSTR ptr				'' linked-list nodes
	nxt				as ASTTEMPSTR ptr				'' /

	tmpsym			as FBSYMBOL ptr
	srctree			as integer
	left			as ASTTEMPSTR ptr
end type

type ASTTEMPARRAY
	prv				as ASTTEMPARRAY ptr				'' linked-list nodes
	nxt				as ASTTEMPARRAY ptr				'' /

	pdesc			as FBSYMBOL ptr
	left			as ASTTEMPARRAY ptr
end type

type FUNCTNode
	sym				as FBSYMBOL ptr					'' symbol
	params			as integer
	arg				as FBSYMBOL ptr
	lastparam		as integer						'' used to speed up PASCAL calling conv. only
	isrtl			as integer
	arraytail 		as ASTTEMPARRAY ptr
	strtail 		as ASTTEMPSTR ptr
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

type ASTNODE
	prv				as integer						'' 'pointers' used by the allocator,
	nxt				as integer						'' /  (can't be swapped/copied!)

	class			as integer						'' CONST, VAR, BOP, UOP, IDX, FUNCT, etc

	dtype			as integer						'' BYTE, INTEGER, SINGLE, DOUBLE, USERDEF, etc
	subtype			as FBSYMBOL ptr					'' if dtype is an USERDEF

	defined 		as integer						'' only true for constants
	union
		value		as double						'' /
		value64		as longint
	end union

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

	l				as integer						'' left node, index of ast tb
	r				as integer						'' right /     /
end type

declare sub 		astInit				( )

declare sub 		astEnd				( )

declare function 	astNew				( byval typ as integer, _
										  byval dtype as integer, _
										  byval subtype as FBSYMBOL ptr = NULL ) as integer

declare sub 		astDel				( byval n as integer )

declare function 	astCloneTree		( byval n as integer ) as integer

declare sub 		astDelTree			( byval n as integer )

declare function 	astIsTreeEqual		( byval l as integer, _
										  byval r as integer ) as integer

declare function 	astGetClass			( byval n as integer ) as integer

declare function 	astGetDataType		( byval n as integer ) as integer

declare function 	astGetSubtype		( byval n as integer ) as FBSYMBOL ptr

declare function 	astGetDataClass		( byval n as integer ) as integer

declare function 	astGetDataSize		( byval n as integer ) as integer

declare function 	astGetSymbol		( byval n as integer ) as FBSYMBOL ptr

declare function 	astGetValue			( byval n as integer ) as double

declare function 	astGetValue64		( byval n as integer ) as longint

declare sub 		astSetDataType		( byval n as integer, _
										  byval dtype as integer )

declare function	astLoad				( byval n as integer ) as integer

declare function	astFlush			( byval n as integer ) as integer

declare function	astUpdComp2Branch	( byval n as integer, _
										  byval label as FBSYMBOL ptr, _
						    			  byval isinverse as integer ) as integer

declare function 	astNewASSIGN		( byval l as integer, _
										  byval r as integer ) as integer

declare function 	astLoadASSIGN		( byval n as integer ) as integer

declare function 	astNewCONV			( byval op as integer, _
										  byval dtype as integer, _
										  byval l as integer ) as integer

declare function 	astLoadCONV			( byval n as integer ) as integer

declare function 	astNewBOP			( byval op as integer, _
										  byval l as integer, _
										  r as integer, _
					  					  byval ex as FBSYMBOL ptr = NULL, _
					  					  byval allocres as integer = TRUE ) as integer

declare function 	astLoadBOP			( byval n as integer ) as integer

declare function 	astNewUOP			( byval op as integer, _
										  byval o as integer ) as integer

declare function 	astLoadUOP			( byval n as integer ) as integer

declare function 	astNewCONST			( byval value as double, _
										  byval dtype as integer ) as integer

declare function 	astNewCONST64		( byval value as longint, _
										  byval dtype as integer ) as integer

declare function 	astLoadCONST		( byval n as integer ) as integer

declare function 	astNewVAR			( byval sym as FBSYMBOL ptr, _
										  byval elm as FBSYMBOL ptr, _
										  byval ofs as integer, _
										  byval dtype as integer, _
										  byval subtype as FBSYMBOL ptr = NULL ) as integer

declare function 	astLoadVAR			( byval n as integer ) as integer

declare function 	astNewIDX			( byval v as integer, _
										  byval i as integer, _
										  byval dtype as integer, _
										  byval subtype as FBSYMBOL ptr ) as integer

declare function 	astLoadIDX			( byval n as integer ) as integer

declare function 	astNewPTR			( byval sym as FBSYMBOL ptr, _
										  byval elm as FBSYMBOL ptr, _
										  byval ofs as integer, _
										  byval expr as integer, _
										  byval dtype as integer, _
										  byval subtype as FBSYMBOL ptr ) as integer

declare function 	astLoadPTR			( byval n as integer ) as integer

declare function 	astNewFUNCT			( byval sym as FBSYMBOL ptr, _
										  byval dtype as integer, _
										  byval ptrexpr as integer = INVALID ) as integer

declare function 	astNewPARAM			( byval f as integer, _
										  byval p as integer, _
										  byval dtype as integer = INVALID, _
										  byval mode as integer = INVALID ) as integer

declare function 	astLoadFUNCT		( byval n as integer ) as integer

declare function 	astNewADDR			( byval op as integer, _
										  byval p as integer, _
										  byval sym as FBSYMBOL ptr = NULL, _
										  byval elm as FBSYMBOL ptr = NULL, _
										  byval dtype as integer = INVALID, _
										  byval subtype as FBSYMBOL ptr = NULL ) as integer

declare function 	astLoadADDR			( byval n as integer ) as integer

declare function 	astNewLOAD			( byval l as integer, _
										  byval dtype as integer ) as integer

declare function 	astLoadLOAD			( byval n as integer ) as integer

declare function 	astNewBRANCH		( byval op as integer, _
										  byval label as FBSYMBOL ptr, _
										  byval l as integer = INVALID ) as integer

declare function 	astLoadBRANCH		( byval n as integer ) as integer

declare function 	astNewIIF			( byval condexpr as integer, _
										  byval truexpr as integer, _
										  byval falsexpr as integer ) as integer

declare function 	astLoadIIF			( byval n as integer ) as integer

declare sub 		astDump1 			( byval p as integer, _
										  byval n as integer, _
										  byval isleft as integer, _
										  byval ln as integer, _
										  byval cn as integer )
