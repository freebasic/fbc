''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2010 The FreeBASIC development team.
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


'' local register allocation, based on the bottom-up algorithm (both
'' for stacked and normal sets)
''
'' obs: only works locally, can't be used between blocks
''
'' chng: sep/2004 written [v1ctor]
'' 		 jan/2005 much more modular using fake classes [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ir.bi"
#include once "inc\reg.bi"

'' internals

declare sub regInitClass _
	( _
		byval this_ as REGCLASS ptr, _
		sizeTb() as REG_SIZEMASK _
	)

declare sub sregInitClass _
	( _
		byval this_ as REGCLASS ptr, _
		sizeTb() as REG_SIZEMASK _
	)

'':::::
function regNewClass _
	( _
		byval class_ as integer, _
		byval regs as integer, _
		sizeTb() as REG_SIZEMASK, _
		byval isstack as integer _
	) as REGCLASS ptr

    dim as REGCLASS ptr this_

	this_ = callocate( len( REGCLASS ) )

	this_->class = class_
	this_->regs = regs
	this_->isstack = isstack

	if( this_->isstack = FALSE ) then
		regInitClass( this_, sizeTb() )
	else
		sregInitClass( this_, sizeTb() )
	end if

	function = this_

end function

'':::::
function regDelClass _
	( _
		byval this_ as REGCLASS ptr _
	) as integer

	function = FALSE

	if( this_ = NULL ) then
		exit function
	end if

	deallocate( this_ )

	function = TRUE

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' non-stack registers allocator
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub regPush _
	( _
		byval this_ as REGCLASS ptr, _
		byval n as integer _
	) static

    dim as REG_REG ptr r

    '' take from used list
    r = this_->regctx.usedtail

    this_->regctx.usedtail = r->prev

	'' add to free list
	r->prev = this_->regctx.freetail
	this_->regctx.freetail = r

	r->num = n

end sub

'':::::
private function regPop _
	( _
		byval this_ as REGCLASS ptr, _
		byval size as integer _					'' in bytes
	) as integer static

    dim as REG_REG ptr r, last

	r = this_->regctx.freetail
	do while( r <> NULL )
		'' same size?
		if( (this_->regctx.sizeTB(r->num) and size) <> 0 ) then
			'' remove from free list
			if( this_->regctx.freetail = r ) then
				this_->regctx.freetail = r->prev
			else
				last->prev = r->prev
			end if

			'' add to used list
			r->prev = this_->regctx.usedtail
			this_->regctx.usedtail = r

			return r->num
		end if

		last = r
		r = r->prev
	loop

	function = INVALID

end function

'':::::
private sub regPopReg _
	( _
		byval this_ as REGCLASS ptr, _
		byval n as integer _
	) static

    dim as REG_REG ptr r, last

	r = this_->regctx.freetail
	do while( r <> NULL )
		'' same?
		if( r->num = n ) then
			'' remove from free list
			if( this_->regctx.freetail = r ) then
				this_->regctx.freetail = r->prev
			else
				last->prev = r->prev
			end if

			'' add to used list
			r->prev = this_->regctx.usedtail
			this_->regctx.usedtail = r

			exit sub
		end if

		last = r
		r = r->prev
	loop

	'' loop shouldn't fail
	errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )

end sub

'':::::
private sub regClear _
	( _
		byval this_ as REGCLASS ptr _
	) static

    dim as REG_REG ptr r
    dim as integer n

	this_->regctx.freeTB = -1
	this_->regctx.freetail = NULL
	this_->regctx.usedtail = NULL

	for n = 0 to this_->regs - 1
		this_->vregTB(n) = NULL
		this_->regctx.nextTB(n) = 0

		r = @this_->regctx.regTB(n)

		'' add to free list
		r->prev = this_->regctx.freetail
		this_->regctx.freetail = r

		r->num = n
	next

end sub

'':::::
private function regFindFarest _
	( _
		byval this_ as REGCLASS ptr, _
		byval size as integer _					'' in bytes
	) as integer static

    dim as integer n, r
    dim as uinteger maxdist

    '' all regs must be used atm

    maxdist = 0
    r = INVALID
    for n = 0 to this_->regs - 1
		'' valid bits?
		if( (this_->regctx.sizeTB(n) and size) <> 0 ) then
    		''
    		if( this_->regctx.nextTB(n) > maxdist ) then
    			maxdist = this_->regctx.nextTB(n)
    			r = n
    		end if
    	end if
    next

	function = r

end function

'':::::
private function regAllocate _
	( _
		byval this_ as REGCLASS ptr, _
		byval vreg as IRVREG ptr, _
		byval size as uinteger _				'' in bytes
	) as integer static

    dim as integer r

	r = regPop( this_, size )
	if( r = INVALID ) then
		r = regFindFarest( this_, size )
	    irStoreVR( this_->vregTB(r), r )
	end if

	REG_SETUSED( this_->regctx.freeTB, r )
	this_->vregTB(r) = vreg
	this_->regctx.nextTB(r) = irGetDistance( vreg )

	function = r

end function

'':::::
private function regAllocateReg _
	( _
		byval this_ as REGCLASS ptr, _
		byval r as integer, _
		byval vreg as IRVREG ptr _
	) as integer static

	if( REG_ISFREE( this_->regctx.freeTB, r ) ) then
		regPopReg( this_, r )
		REG_SETUSED( this_->regctx.freeTB, r )
	end if

	this_->vregTB(r) = vreg
	this_->regctx.nextTB(r) = irGetDistance( vreg )

	function = r

end function

'':::::
private function regEnsure _
	( _
		byval this_ as REGCLASS ptr, _
		byval vreg as IRVREG ptr, _
		byval size as uinteger, _
		byval doload as integer _
	) as integer static

    dim as integer r

    r = vreg->reg
    if( r = INVALID ) then
    	r = regAllocate( this_, vreg, size )
    	irLoadVR( r, vreg, doload )
    end if

    function = r

end function

'':::::
private sub regSetOwner _
	( _
		byval this_ as REGCLASS ptr, _
		byval r as integer, _
		byval vreg as IRVREG ptr _
	)

	REG_SETUSED( this_->regctx.freeTB, r )
	this_->vregTB(r) = vreg
	this_->regctx.nextTB(r) = irGetDistance( vreg )

end sub

'':::::
private sub regFree _
	( _
		byval this_ as REGCLASS ptr, _
		byval r as integer _
	) static

	if( REG_ISUSED( this_->regctx.freeTB, r ) ) then
		REG_SETFREE( this_->regctx.freeTB, r )
		this_->vregTB(r) = NULL
		this_->regctx.nextTB(r) = 0
		regPush( this_, r )
	end if

end sub

'':::::
private function regIsFree _
	( _
		byval this_ as REGCLASS ptr, _
		byval r as integer _
	) as integer static

	function = REG_ISFREE( this_->regctx.freeTB, r )

end function

'':::::
private function regGetMaxRegs _
	( _
		byval this_ as REGCLASS ptr _
	) as integer static

    function = this_->regs

end function

'':::::
private function regGetFirst _
	( _
		byval this_ as REGCLASS ptr _
	) as integer static

	function = 0

end function

'':::::
private function regGetNext _
	( _
		byval this_ as REGCLASS ptr, _
		byval r as integer _
	) as integer static

	function = INVALID

	if( r >= 0 ) then
		r += 1
		if( r < this_->regs ) then
			function = r
		end if
	end if

end function

'':::::
private function regGetVreg _
	( _
		byval this_ as REGCLASS ptr, _
		byval r as integer _
	) as IRVREG ptr static

	function = this_->vregTB(r)

end function

'':::::
private function regGetRealReg _
	( _
		byval this_ as REGCLASS ptr, _
		byval r as integer _
	) as integer static

	function = r

end function

'':::::
private sub regDump _
	( _
		byval this_ as REGCLASS ptr _
	)
#if 0
	dim as integer i, cnt

	cnt = 0
	for i = 0 to this_->regs - 1
		if( REG_ISUSED( this_->regctx.freeTB, i ) ) then
			print i;
			cnt += 1
		end If
	next

	if( cnt > 0 ) then print
#endif
end sub

'':::::
private sub regInitClass _
	( _
		byval this_ as REGCLASS ptr, _
		sizeTb() as REG_SIZEMASK _
	) static

	dim as integer i

	regClear( this_ )

	for i = 0 to this_->regs - 1
		this_->regctx.sizeTb(i) = sizeTb(i)
	next

	this_->ensure = @regEnsure
	this_->_allocate = @regAllocate
	this_->allocateReg = @regAllocateReg
	this_->free = @regFree
	this_->isFree = @regIsFree
	this_->setOwner = @regSetOwner
	this_->getMaxRegs = @regGetMaxRegs
	this_->getFirst = @regGetFirst
	this_->getNext = @regGetNext
	this_->getVreg = @regGetVreg
	this_->getRealReg = @regGetRealReg
	this_->clear = @regClear
	this_->dump	= @regDump

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' stack registers allocator
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private function sregFindReg _
	( _
		byval this_ as REGCLASS ptr, _
		byval vreg as IRVREG ptr _
	) as integer static

	dim as integer r

	function = INVALID

	if( this_->stkctx.fregs = this_->regs ) then
		exit function
	end if

	for r = 0 to this_->regs - 1
		if( this_->stkctx.regTB(r) <> INVALID ) then
			if( this_->vregTB(r) = vreg ) then
				return r
			end If
		end if
	next

end function

'':::::
private sub sregXchg _
	( _
		byval this_ as REGCLASS ptr, _
		byval r1 as integer _
	) Static

    dim as integer i, r2

	irXchgTOS( r1 )

	r2 = INVALID

	for i = 0 to this_->regs - 1
		if( this_->stkctx.regTB(i) = 0 ) then
			r2 = i
			exit for
		end if
	next

	swap this_->stkctx.regTB(r1), this_->stkctx.regTB(r2)

end sub

'':::::
private function sregFindFreeReg _
	( _
		byval this_ as REGCLASS ptr _
	) as integer Static

	dim as integer r

    function = INVALID

    if( this_->stkctx.fregs = 0 ) then
    	exit function
    end if

	for r = 0 to this_->regs - 1
		if( this_->stkctx.regTB(r) = INVALID ) then
			return r
		end If
	next

end function

'':::::
private function sregFindLowestReg _
	( _
		byval this_ as REGCLASS ptr _
	) as integer Static

	dim as integer r, i, lowest

	i = INVALID
	lowest = -32768

	for r = 0 to this_->regs - 1
		if( this_->stkctx.regTB(r) <> INVALID ) then
			if( this_->stkctx.regTB(r) > lowest ) then
				lowest = this_->stkctx.regTB(r)
				i = r
			end if
		end If
	next

	function = i

end function

'':::::
private function sregFindTOSReg _
	( _
		byval this_ as REGCLASS ptr _
	) as integer Static

	dim as integer r

	for r = 0 to this_->regs - 1
		if( this_->stkctx.regTB(r) = 0 ) then
			return r
		end If
	next

	function = INVALID

end function

'':::::
private function sregAllocate _
	( _
		byval this_ as REGCLASS ptr, _
		byval vreg as IRVREG ptr, _
		byval size as uinteger _				'' unused
	) as integer Static

	dim as integer r, i

	r = sregFindFreeReg( this_ )
	if( r = INVALID ) then

	    r = sregFindTOSReg( this_ )
	    irStoreVR( this_->vregTB(r), r )

	else
		this_->stkctx.fregs -= 1

		for i = 0 to this_->regs - 1
			if( this_->stkctx.regTB(i) <> INVALID ) then
				this_->stkctx.regTB(i) += 1
			end If
		next
	end If

	this_->vregTB(r) = vreg
	this_->stkctx.regTB(r)  = 0

	function = r

End Function

'':::::
private function sregAllocateReg _
	( _
		byval this_ as REGCLASS ptr, _
		byval r as integer, _
		byval vreg as IRVREG ptr _
	) as integer Static

	'' assuming r will be always 0 (result, TOS)
    function = sregAllocate( this_, vreg, REG_SIZEMASK_64 )

end function

'':::::
private function sregEnsure _
	( _
		byval this_ as REGCLASS ptr, _
		byval vreg as IRVREG ptr, _
		byval size as uinteger, _				'' unused
		byval doload as integer _
	) as integer Static

	dim as integer r

	r = sregFindReg( this_, vreg )
	if( r = INVALID ) then
		r = sregAllocate( this_, vreg, REG_SIZEMASK_64 )
		irLoadVR( r, vreg, doload )
	else
		assert( vreg->reg = r )
		if( this_->stkctx.regTB(r) <> 0 ) then
			sregXchg( this_, r )
		end if
	end if

	function = r

end function

'':::::
private sub sregFree _
	( _
		byval this_ as REGCLASS ptr, _
		byval r as integer _
	) static

	dim as integer i, realreg

	if( this_->stkctx.regTB(r) = INVALID ) then
		exit sub
	end if

	realreg = this_->stkctx.regTB(r)
	this_->stkctx.regTB(r) = INVALID
	this_->vregTB(r) = NULL

	for i = 0 to this_->regs - 1
		if( this_->stkctx.regTB(i) <> INVALID ) then
			if( this_->stkctx.regTB(i) > realreg ) then
				this_->stkctx.regTB(i) -= 1
			end if
		end If
	next

	this_->stkctx.fregs += 1

end sub

'':::::
private function sregIsFree _
	( _
		byval this_ as REGCLASS ptr, _
		byval r as integer _
	) as integer static

	function = this_->stkctx.regTB(r) = INVALID

end function

'':::::
private sub sregSetOwner _
	( _
		byval this_ as REGCLASS ptr, _
		byval r as integer, _
		byval vreg as IRVREG ptr _
	) static

	this_->vregTB(r) = vreg

end sub

'':::::
private function sregGetRealReg _
	( _
		byval this_ as REGCLASS ptr, _
		byval r as integer _
	) as integer static

	function = this_->stkctx.regTB(r)

end function

'':::::
private function sregGetMaxRegs _
	( _
		byval this_ as REGCLASS ptr _
	) as integer static

    function = this_->regs

end function

'':::::
private function sregGetFirst _
	( _
		byval this_ as REGCLASS ptr _
	) as integer static

	function = sregFindTOSReg( this_ )

end function

'':::::
private function sregGetNext _
	( _
		byval this_ as REGCLASS ptr, _
		byval r as integer _
	) as integer static

	if( (r < 0) or (r >= this_->regs) ) then
		function = INVALID
	else
		function = sregFindTOSReg( this_ )
	end if

end function

'':::::
private function sregGetVreg _
	( _
		byval this_ as REGCLASS ptr, _
		byval r as integer _
	) as IRVREG ptr static

	function = this_->vregTB(r)

end function

'':::::
private sub sregDump _
	( _
		byval this_ as REGCLASS ptr _
	)
#if 0
	dim as integer i, cnt

	cnt = 0
	for i = 0 to this_->regs - 1
		if( this_->stkctx.regTB(i) <> INVALID ) then
			print i;
			cnt += 1
		end If
	next

	if( cnt > 0 ) then print
#endif
end sub

'':::::
private sub sregClear _
	( _
		byval reg as REGCLASS ptr _
	)

	dim as integer r = any

	reg->stkctx.fregs = reg->regs

	for r = 0 to reg->regs - 1
		reg->stkctx.regTB(r) = INVALID
		reg->vregTB(r) = NULL
	next

end sub

'':::::
private sub sregInitClass _
	( _
		byval this_ as REGCLASS ptr, _
		sizeTb() as REG_SIZEMASK _
	)

	'' sizeTb() is unused (x86 assumption)

	sregClear( this_ )

	this_->ensure = @sregEnsure
	this_->_allocate	= @sregAllocate
	this_->allocateReg = @sregAllocateReg
	this_->free = @sregFree
	this_->isFree = @sregIsFree
	this_->setOwner = @sregSetOwner
	this_->getMaxRegs = @sregGetMaxRegs
	this_->getFirst	= @sregGetFirst
	this_->getNext = @sregGetNext
	this_->getVreg = @sregGetVreg
	this_->getRealReg = @sregGetRealReg
	this_->clear = @sregClear
	this_->dump	= @sregDump

end sub


