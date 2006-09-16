#ifndef __REG_BI__
#define __REG_BI__

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


'#ifdef TARGET_X86
const REG_MAXREGS	= 8

type REG_FREETB 	as integer

'#endif

#include once "inc\ir.bi"


type REGCLASS

	'' methods
	ensure						as function _
	( _
		byval this_ as REGCLASS ptr, _
		byval vreg as IRVREG ptr, _
		byval doload as integer = TRUE _
	) as integer

	allocate					as function _
	( _
		byval this_ as REGCLASS ptr, _
		byval vreg as IRVREG ptr _
	) as integer

	allocateReg					as function _
	( _
		byval this_ as REGCLASS ptr, _
		byval r as integer, _
		byval vreg as IRVREG ptr _
	) as integer

	free						as sub _
	( _
		byval this_ as REGCLASS ptr, _
		byval r as integer _
	)

	isFree						as function _
	( _
		byval this_ as REGCLASS ptr, _
		byval r as integer _
	) as integer

	setOwner					as sub _
	( _
		byval this_ as REGCLASS ptr, _
		byval r as integer, _
		byval vreg as IRVREG ptr _
	)

	getMaxRegs					as function _
	( _
		byval this_ as REGCLASS ptr _
	) as integer

	getFirst					as function _
	( _
		byval this_ as REGCLASS ptr _
	) as integer

	getNext						as function _
	( _
		byval this_ as REGCLASS ptr, _
		byval r as integer _
	) as integer

	getVreg						as function _
	( _
		byval this_ as REGCLASS ptr, _
		byval r as integer _
	) as IRVREG ptr

	getRealReg					as function _
	( _
		byval this_ as REGCLASS ptr, _
		byval r as integer _
	) as integer

	clear						as sub _
	( _
		byval this_ as REGCLASS ptr _
	)

	dump						as sub _
	( _
		byval this_ as REGCLASS ptr _
	)

	'' private data
	class 						as integer
	isstack						as integer
	regs						as integer

	vregTB(0 to REG_MAXREGS-1) 	as IRVREG ptr	'' virtual register name (index)

	'' f/ non-stacked sets only
	freeTB 						as REG_FREETB 	'' bitmask
	nextTB(0 to REG_MAXREGS-1) 	as uinteger		'' distance of next vreg usage
	fstack(0 to REG_MAXREGS-1) 	as integer		'' free regs stack
    sp							as integer      '' stack pointer

	'' f/ stacked sets only
	regTB(0 to REG_MAXREGS-1)	as integer		'' real register (st(#))
	fregs						as integer      '' free regs
end type

#define REG_ISFREE(m,r) ((m and (1 shl r)) <> 0)
#define REG_ISUSED(m,r) ((m and (1 shl r)) = 0)
#define REG_SETFREE(m,r) m or= (1 shl r)
#define REG_SETUSED(m,r) m and= not (1 shl r)

''
''
''
declare function regNewClass _
	( _
		byval class as integer, _
		byval regs as integer, _
		byval isstack as integer _
	) as REGCLASS ptr

declare function regDelClass _
	( _
		byval reg as REGCLASS ptr _
	) as integer

#endif '' __REG_BI__
