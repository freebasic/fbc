'' local register allocation, based on the bottom-up algorithm (both
'' for stacked and normal sets)
''
'' obs: only works locally, can't be used between blocks
''
'' chng: sep/2004 written [v1ctor]
''       jan/2005 much more modular using fake classes [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "reg.bi"
#include once "emit.bi"

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

	this_ = xcallocate( len( REGCLASS ) )

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

#if __FB_DEBUG__
sub regDump2( byval this_ as REGCLASS ptr )
	for i as integer = 0 to this_->regs - 1
		print i & " " & emitDumpRegName( iif( this_->class = FB_DATACLASS_INTEGER, FB_DATATYPE_INTEGER, FB_DATATYPE_DOUBLE ), i );

		if( REG_ISUSED( this_->regctx.freeTB, i ) ) then
			print ", used";
		else
			print ", free";
		end if

		if( this_->vregTB(i) ) then
			print ", vreg=" & vregDumpToStr( this_->vregTB(i) );
		else
			print ", no vreg";
		end if
		if( this_->vauxparent(i) ) then
			print ", vauxparent=" & vregDumpToStr( this_->vauxparent(i) );
		end if
		print
	next
end sub
#endif

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
		byval size as integer _                 '' in bytes
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
		this_->vauxparent(n) = NULL
		this_->regctx.nextTB(n) = IR_INVALIDDIST

		r = @this_->regctx.regTB(n)

		'' add to free list
		r->prev = this_->regctx.freetail
		this_->regctx.freetail = r

		r->num = n
	next

end sub

private function regFindFarest _
	( _
		byval this_ as REGCLASS ptr, _
		byval size as integer, _ '' in bytes
		byval reservedreg as integer _
	) as integer

	'' all regs must be used atm

	dim as uinteger maxdist = 0
	var r = INVALID
	for i as integer = 0 to this_->regs - 1
		if( i <> reservedreg ) then
			'' valid bits?
			if( this_->regctx.sizeTB(i) and size ) then
				if( maxdist <= this_->regctx.nextTB(i) ) then
					maxdist = this_->regctx.nextTB(i)
					r = i
				end if
			end if
		end if
	next

	assert( r <> INVALID )
	function = r
end function

'':::::
private function regAllocate _
	( _
		byval this_ as REGCLASS ptr, _
		byval vreg as IRVREG ptr, _
		byval vauxparent as IRVREG ptr, _
		byval size as uinteger _                '' in bytes
	) as integer

	dim as integer r = any

	r = regPop( this_, size )
	if( r = INVALID ) then
		'' No register free; need to spill something.
		'' But don't spill our vaux if we have one (it doesn't make
		'' sense to spill one half while trying to allocate the other).
		'' In that case, we need to find something else to spill.
		var reservedreg = INVALID
		if( vreg->vaux andalso irIsREG( vreg->vaux ) ) then
			reservedreg = vreg->vaux->reg
		end if
		r = regFindFarest( this_, size, reservedreg )

		assert( vreg->vaux <> this_->vregTB(r) )  '' shouldn't spill vaux when trying to allocate vauxparent
		assert( vauxparent <> this_->vregTB(r) )  '' shouldn't spill vauxparent when trying to allocate vaux

		'' This will regFree() the register
		irStoreVR( this_->vregTB(r), this_->vauxparent(r) )

		'' But remove it from the free list again, since we'll use it now
		regPopReg( this_, r )
	end if

	REG_SETUSED( this_->regctx.freeTB, r )
	this_->vregTB(r) = vreg
	this_->vauxparent(r) = vauxparent
	this_->regctx.nextTB(r) = irGetDistance( vreg )

	function = r

end function

'':::::
private function regAllocateReg _
	( _
		byval this_ as REGCLASS ptr, _
		byval r as integer, _
		byval vreg as IRVREG ptr, _
		byval vauxparent as IRVREG ptr _
	) as integer

	if( REG_ISFREE( this_->regctx.freeTB, r ) ) then
		regPopReg( this_, r )
		REG_SETUSED( this_->regctx.freeTB, r )
	end if

	this_->vregTB(r) = vreg
	this_->vauxparent(r) = vauxparent
	this_->regctx.nextTB(r) = irGetDistance( vreg )

	function = r

end function

'':::::
private function regEnsure _
	( _
		byval this_ as REGCLASS ptr, _
		byval vreg as IRVREG ptr, _
		byval vauxparent as IRVREG ptr, _
		byval size as uinteger _
	) as integer

	dim as integer r = any

	r = vreg->reg
	if( r = INVALID ) then
		r = regAllocate( this_, vreg, vauxparent, size )
		irLoadVR( r, vreg, vauxparent )
	end if

	function = r

end function

'':::::
private sub regSetOwner _
	( _
		byval this_ as REGCLASS ptr, _
		byval r as integer, _
		byval vreg as IRVREG ptr, _
		byval vauxparent as IRVREG ptr _
	)

	REG_SETUSED( this_->regctx.freeTB, r )
	this_->vregTB(r) = vreg
	this_->vauxparent(r) = vauxparent
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
		this_->vauxparent(r) = NULL
		this_->regctx.nextTB(r) = IR_INVALIDDIST
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
		byval r as integer, _
		byref vauxparent as IRVREG ptr _
	) as IRVREG ptr static

	function = this_->vregTB(r)
	vauxparent = this_->vauxparent(r)

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
	this_->dump = @regDump

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

	assert(false)
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

private function sregAllocate _
	( _
		byval this_ as REGCLASS ptr, _
		byval vreg as IRVREG ptr, _
		byval vauxparent as IRVREG ptr, _
		byval size as uinteger _                '' unused
	) as integer

	dim as integer r = any

	r = sregFindFreeReg( this_ )
	if( r = INVALID ) then
		'' No register free, find one to spill
		r = sregFindTOSReg( this_ )

		'' Spill it. This will also sregFree() the register,
		'' so it's marked as free again.
		irStoreVR( this_->vregTB(r), this_->vauxparent(r) )

		assert( sregFindFreeReg( this_ ) = r )
	end If

	'' Mark as used (no longer free)
	this_->stkctx.fregs -= 1
	for i as integer = 0 to this_->regs - 1
		if( this_->stkctx.regTB(i) <> INVALID ) then
			this_->stkctx.regTB(i) += 1
		end If
	next

	this_->vregTB(r) = vreg
	this_->vauxparent(r) = vauxparent
	this_->stkctx.regTB(r)  = 0

	function = r
end function

private function sregAllocateReg _
	( _
		byval this_ as REGCLASS ptr, _
		byval r as integer, _
		byval vreg as IRVREG ptr, _
		byval vauxparent as IRVREG ptr _
	) as integer

	'' assuming r will be always 0 (result, TOS)
	function = sregAllocate( this_, vreg, vauxparent, REG_SIZEMASK_64 )

end function

private function sregEnsure _
	( _
		byval this_ as REGCLASS ptr, _
		byval vreg as IRVREG ptr, _
		byval vauxparent as IRVREG ptr, _
		byval size as uinteger _                '' unused
	) as integer

	dim as integer r = any

	r = sregFindReg( this_, vreg )
	if( r = INVALID ) then
		r = sregAllocate( this_, vreg, vauxparent, REG_SIZEMASK_64 )
		irLoadVR( r, vreg, vauxparent )
	else
		assert( vreg->reg = r )
		if( this_->stkctx.regTB(r) <> 0 ) then
			sregXchg( this_, r )
		end if
	end if

	function = r
end function

private sub sregFree _
	( _
		byval this_ as REGCLASS ptr, _
		byval r as integer _
	)

	dim as integer i, realreg

	if( this_->stkctx.regTB(r) = INVALID ) then
		exit sub
	end if

	realreg = this_->stkctx.regTB(r)
	this_->stkctx.regTB(r) = INVALID
	this_->vregTB(r) = NULL
	this_->vauxparent(r) = NULL

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
		byval vreg as IRVREG ptr, _
		byval vauxparent as IRVREG ptr _
	)

	this_->vregTB(r) = vreg
	this_->vauxparent(r) = vauxparent

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
		byval r as integer, _
		byref vauxparent as IRVREG ptr _
	) as IRVREG ptr

	function = this_->vregTB(r)
	vauxparent = this_->vauxparent(r)

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
		reg->vauxparent(r) = NULL
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
	this_->_allocate    = @sregAllocate
	this_->allocateReg = @sregAllocateReg
	this_->free = @sregFree
	this_->isFree = @sregIsFree
	this_->setOwner = @sregSetOwner
	this_->getMaxRegs = @sregGetMaxRegs
	this_->getFirst = @sregGetFirst
	this_->getNext = @sregGetNext
	this_->getVreg = @sregGetVreg
	this_->getRealReg = @sregGetRealReg
	this_->clear = @sregClear
	this_->dump = @sregDump

end sub
