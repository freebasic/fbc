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


const AST.MAXTEMPSTRINGS%		= 32
const AST.MAXTEMPARRAYDESCS		= 32

const AST.INITNODES%			= 2048

const AST.NODETYPE.CONST% 		= 1
const AST.NODETYPE.VAR% 		= 2
const AST.NODETYPE.BOP% 		= 3
const AST.NODETYPE.UOP% 		= 4
const AST.NODETYPE.IDX% 		= 5
const AST.NODETYPE.FUNCT% 		= 6
const AST.NODETYPE.PARAM%		= 7
const AST.NODETYPE.PTR%			= 8
const AST.NODETYPE.ADDR% 		= 9
const AST.NODETYPE.ASSIGN%		= 10
const AST.NODETYPE.CONV%		= 11
const AST.NODETYPE.LOAD%		= 12

type FUNCTNode
	sym				as FBSYMBOL ptr					'' symbol
	p				as integer						'' ptr expr, f/ function pointers
	args			as integer
	argnum			as integer
	arg				as FBPROCARG ptr
	tmparraybase 	as integer
end type

type PARAMNode
	mode			as integer						'' to pass NULL's to byref args, etc
	lgt				as integer						'' length, used to push UDT's by value
	prv				as integer						'' preview node
	nxt				as integer						'' next    /
end type

type VARNode
	sym				as FBSYMBOL ptr					'' symbol
	elm				as FBTYPELEMENT ptr				'' field element, if any
	ofs				as integer						'' offset
	lgt				as integer						'' length
end type

type IDXNode
	sym				as FBSYMBOL ptr					'' symbol
	elm				as FBTYPELEMENT ptr				'' field element, if any
	ofs				as integer						'' offset
	lgt				as integer						'' length
	var				as integer						'' AST tb index to a VARNode
end type

type PTRNode
	sym				as FBSYMBOL ptr					'' symbol
	elm				as FBTYPELEMENT ptr				'' field element, if any
	ofs				as integer						'' offset
end type

type ASTNode
	prv				as integer						'' 'pointers' used by the allocator,
	nxt				as integer						'' /  (can't be swapped/copied!)

	typ				as integer						'' CONST, VAR, BOP, UOP, IDX, etc

	dtype			as integer						'' BYTE, INTEGER, SINGLE, DOUBLE, etc

	defined 		as integer						'' only true for constants
	value			as double						'' /

	op				as integer						'' f/ BOP & UOP nodes
	allocres 		as integer						'' /
	ex				as FBSYMBOL ptr					'' / (extra: label, etc)

	union
		var			as VARNode
		idx			as IDXNode
		ptr			as PTRNode
		proc		as FUNCTNode
		param		as PARAMNode
	end union

	l				as integer						'' left node, index of ast tb
	r				as integer						'' right /     /
end type


declare sub 		astInit				( )
declare sub 		astEnd				( )
declare function 	astNew				( byval typ as integer, byval dtype as integer ) as integer
declare sub 		astDel				( n as integer )

declare function 	astCloneTree		( byval n as integer ) as integer
declare sub 		astDelTree			( byval n as integer )

declare function 	astGetType			( byval n as integer ) as integer
declare function 	astGetDataType		( byval n as integer ) as integer
declare function 	astGetDataClass		( byval n as integer ) as integer
declare function 	astGetDataSize		( byval n as integer ) as integer
declare function 	astGetValue			( byval n as integer ) as double
declare function 	astGetSymbol		( byval n as integer ) as FBSYMBOL ptr
declare function 	astGetUDTElm		( byval n as integer ) as FBTYPELEMENT ptr
declare function 	astGetOffset		( byval n as integer ) as integer

declare sub 		astLoad				( byval n as integer, dst as integer )
declare sub 		astBinOperation		( byval op as integer, byval v1 as integer, byval v2 as integer, byval vr as integer, byval ex as FBSYMBOL ptr )
declare sub 		astUnaOperation		( byval op as integer, byval v1 as integer, byval vr as integer )
declare sub 		astAddrOperation	( byval op as integer, byval v1 as integer, byval vr as integer )

declare function 	astFlush			( byval n as integer, vreg as integer, byval label as FBSYMBOL ptr = NULL, byval isinverse as integer = FALSE ) as integer

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

declare function 	astNewVAREx			( byval symbol as FBSYMBOL ptr, byval elm as FBTYPELEMENT ptr, byval ofs as integer, byval dtype as integer ) as integer
declare function 	astNewVAR			( byval symbol as FBSYMBOL ptr, byval ofs as integer, byval dtype as integer )  as integer
declare sub 		astLoadVAR			( byval n as integer, vr as integer )

declare function 	astNewIDX			( byval v as integer, byval i as integer, byval dtype as integer )  as integer
declare sub 		astLoadIDX			( byval n as integer, vr as integer )

declare function 	astNewPTREx			( byval s as FBSYMBOL ptr, byval elm as FBTYPELEMENT ptr, byval ofs as integer, byval dtype as integer, byval expr as integer ) as integer
declare function 	astNewPTR			( byval ofs as integer, byval dtype as integer, byval expr as integer ) as integer
declare sub 		astLoadPTR			( byval n as integer, vreg as integer )

declare function 	astNewFUNCT			( byval symbol as FBSYMBOL ptr, byval dtype as integer, byval args as integer ) as integer
declare function 	astNewFUNCTPTR		( byval ptrexpr as integer, byval symbol as FBSYMBOL ptr, byval dtype as integer, byval args as integer ) as integer
declare function 	astNewPARAM			( byval f as integer, byval p as integer, byval dtype as integer = INVALID, byval mode as integer = INVALID ) as integer
declare sub 		astLoadFUNCT		( byval n as integer, vr as integer )

declare function 	astNewADDR			( byval op as integer, byval p as integer ) as integer
declare sub 		astLoadADDR			( byval n as integer, vr as integer )

declare function 	astNewLOAD			( byval l as integer, byval dtype as integer ) as integer
declare sub 		astLoadLOAD			( byval n as integer, vr as integer )

declare sub 		astOptimize			( byval n as integer )

declare sub 		astDump1 			( byval p as integer, byval n as integer, byval isleft as integer, byval ln as integer, byval cn as integer )
