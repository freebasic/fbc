#ifndef __REG_BI__
#define __REG_BI__

'' TODO: x86 specific
const REG_MAXREGS   = 8

type REG_FREETB     as integer

#include once "ir.bi"

enum REG_SIZEMASK
	REG_SIZEMASK_8  = &h0001
	REG_SIZEMASK_16 = &h0002
	REG_SIZEMASK_32 = &h0004
	REG_SIZEMASK_64 = &h0008
end enum

type REG_REG
	num             as integer
	prev            as REG_REG ptr
end type

'' f/ non-stacked sets only
type REG_REGCTX
	freetail    as REG_REG ptr
	usedtail    as REG_REG ptr

	freeTB      as REG_FREETB   '' bitmask

	regTB ( _
				0 to REG_MAXREGS-1 _
		)       as REG_REG

	sizeTB ( _
				0 to REG_MAXREGS-1 _
		)       as REG_SIZEMASK

	nextTB ( _
				0 to REG_MAXREGS-1 _
		)       as uinteger     '' distance of next vreg usage
end type

'' f/ stacked sets only
type REG_STKCTX
	regTB ( _
				0 to REG_MAXREGS-1 _
		)       as integer      '' real register (st(#))

	fregs       as integer      '' free regs
end type

type REGCLASS

	'' methods
	ensure          as function _
	( _
		byval this_ as REGCLASS ptr, _
		byval vreg as IRVREG ptr, _
		byval vauxparent as IRVREG ptr, _
		byval size as uinteger _                '' in bytes
	) as integer

	_allocate       as function _
	( _
		byval this_ as REGCLASS ptr, _
		byval vreg as IRVREG ptr, _
		byval vauxparent as IRVREG ptr, _
		byval size as uinteger _                '' in bytes
	) as integer

	allocateReg     as function _
	( _
		byval this_ as REGCLASS ptr, _
		byval r as integer, _
		byval vreg as IRVREG ptr, _
		byval vauxparent as IRVREG ptr _
	) as integer

	free            as sub _
	( _
		byval this_ as REGCLASS ptr, _
		byval r as integer _
	)

	isFree          as function _
	( _
		byval this_ as REGCLASS ptr, _
		byval r as integer _
	) as integer

	setOwner        as sub _
	( _
		byval this_ as REGCLASS ptr, _
		byval r as integer, _
		byval vreg as IRVREG ptr, _
		byval vauxparent as IRVREG ptr _
	)

	getMaxRegs      as function _
	( _
		byval this_ as REGCLASS ptr _
	) as integer

	getFirst        as function _
	( _
		byval this_ as REGCLASS ptr _
	) as integer

	getNext         as function _
	( _
		byval this_ as REGCLASS ptr, _
		byval r as integer _
	) as integer

	getVreg         as function _
	( _
		byval this_ as REGCLASS ptr, _
		byval r as integer, _
		byref vreg as IRVREG ptr _
	) as IRVREG ptr

	getRealReg      as function _
	( _
		byval this_ as REGCLASS ptr, _
		byval r as integer _
	) as integer

	clear           as sub _
	( _
		byval this_ as REGCLASS ptr _
	)

	dump            as sub _
	( _
		byval this_ as REGCLASS ptr _
	)

	'' private data
	class           as integer
	isstack         as integer
	regs            as integer

	vregTB(0 to REG_MAXREGS-1)  as IRVREG ptr '' vregs currently using each register
	vauxparent(0 to REG_MAXREGS-1)  as IRVREG ptr '' if vregTB(i) is a vaux, this points to the main longint vreg

	regctx          as REG_REGCTX

	stkctx          as REG_STKCTX
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
		sizeTb() as REG_SIZEMASK, _
		byval isstack as integer _
	) as REGCLASS ptr

declare function regDelClass _
	( _
		byval this_ as REGCLASS ptr _
	) as integer

#if __FB_DEBUG__
declare sub regDump2( byval this_ as REGCLASS ptr )
#endif

#endif '' __REG_BI__
