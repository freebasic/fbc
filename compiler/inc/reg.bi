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


type REGCLASS
	regs			as integer
	vreg(0 to 7) 	as integer					'' virtual register name (index)
	nxt(0 to 7) 	as integer					'' distance of next vreg usage
	free(0 to 7) 	as integer                  '' true or false
	fstack(0 to 7) 	as integer					'' free regs stack
    sp				as integer                  '' stack pointer
end type


type SREGCLASS
	regs			as integer
    fregs			as integer                  '' free regs
	vreg(0 to 7)	as integer					'' virtual register name (index)
	reg(0 to 7)		as integer					'' real register (st(#))
end Type



''
''
''
declare sub 		regInit			( byval classes as integer )
declare sub 		regInitClass	( byval c as integer, byval regs as integer )
declare sub 		regClear		( byval c as integer )
declare function 	regEnsure		( byval t as integer, byval c as integer, byval vreg as integer ) as integer
declare function 	regAllocate		( byval t as integer, byval c as integer, byval vreg as integer ) as integer
declare function 	regAllocateReg	( byval t as integer, byval c as integer, byval r as integer, byval vreg as integer ) as integer
declare sub 		regSetOwner		( byval t as integer, byval c as integer, byval r as integer, byval vreg as integer )
declare sub 		regFree			( byval t as integer, byval c as integer, byval r as integer )
declare function 	regIsFree		( byval typ as integer, byval class as integer, byval reg as integer ) as integer
declare function 	regGetMaxRegs	( byval c as integer ) as integer

declare function 	regGetFirst		( byval class as integer ) as integer
declare function 	regGetNext		( byval class as integer, byval r as integer ) as integer
declare function 	regGetVreg		( byval class as integer, byval r as integer ) as integer

declare function 	sregGetRealReg	( byval r as integer ) as integer
