#ifndef REG_BI__
#define REG_BI__

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


'#ifdef TARGET_X86
const REG.MAXREGS	= 8
'#else
'#endif


type REGCLASS

	'' methods
	ensure			as function ( byval this_ as REGCLASS ptr, byval vreg as integer ) as integer
	allocate		as function ( byval this_ as REGCLASS ptr, byval vreg as integer ) as integer
	allocateReg		as function ( byval this_ as REGCLASS ptr, byval r as integer, byval vreg as integer ) as integer
	free			as sub 		( byval this_ as REGCLASS ptr, byval r as integer )
	isFree			as function ( byval this_ as REGCLASS ptr, byval r as integer ) as integer
	setOwner		as sub 		( byval this_ as REGCLASS ptr, byval r as integer, byval vreg as integer )
	getMaxRegs		as function ( byval this_ as REGCLASS ptr ) as integer
	getFirst		as function ( byval this_ as REGCLASS ptr ) as integer
	getNext			as function ( byval this_ as REGCLASS ptr, byval r as integer ) as integer
	getVreg			as function ( byval this_ as REGCLASS ptr, byval r as integer ) as integer
	getRealReg		as function ( byval this_ as REGCLASS ptr, byval r as integer ) as integer

	'' private data
	class 						as integer
	isstack						as integer
	regs						as integer

	vregTB(0 to REG.MAXREGS-1) 	as integer		'' virtual register name (index)

	'' f/ non-stack sets only
	nextTB(0 to REG.MAXREGS-1) 	as integer		'' distance of next vreg usage
	freeTB(0 to REG.MAXREGS-1) 	as integer      '' true or false
	fstack(0 to REG.MAXREGS-1) 	as integer		'' free regs stack
    sp							as integer      '' stack pointer

	'' f/ stack sets only
	regTB(0 to REG.MAXREGS-1)	as integer		'' real register (st(#))
	fregs						as integer      '' free regs
end type



''
''
''
declare function 	regNewClass			( byval class as integer, byval regs as integer, byval isstack as integer ) as REGCLASS ptr
declare function 	regDelClass			( byval reg as REGCLASS ptr ) as integer

#endif '' REG_BI__
