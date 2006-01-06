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


'' local register allocation, based on bottom-up algorithm (both for stacked and normal sets)
''
'' obs: only works locally, can't be used between blocks
''
'' chng: sep/2004 written [v1ctor]
'' 		 jan/2005 much more modular using fake classes [v1ctor]

defint a-z
option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ir.bi"
#include once "inc\reg.bi"

'' internals

declare sub regInitClass		( byval reg as REGCLASS ptr )

declare sub sregInitClass		( byval reg as REGCLASS ptr )


'':::::
function regNewClass( byval class as integer, _
					  byval regs as integer, _
					  byval isstack as integer ) as REGCLASS ptr
    dim as REGCLASS ptr reg

	reg = callocate( len( REGCLASS ) )

	reg->class 	= class
	reg->regs 	= regs
	reg->isstack= isstack

	if( reg->isstack = FALSE ) then
		regInitClass( reg )
	else
		sregInitClass( reg )
	end if

	function = reg

end function

'':::::
function regDelClass( byval reg as REGCLASS ptr ) as integer

	function = FALSE

	if( reg = NULL ) then
		exit function
	end if

	deallocate( reg )

	function = TRUE

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' non-stack registers allocator
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub regPush( byval this_ as REGCLASS ptr, _
					 byval r as integer ) static
    dim as integer sp

	sp = this_->sp
	if( sp > 0 ) then
		sp -= 1
		this_->fstack(sp) = r
	end if
	this_->sp = sp

end sub

'':::::
private function regPop( byval this_ as REGCLASS ptr ) as integer static
    dim as integer sp

	sp = this_->sp
	if( sp < this_->regs ) then
		function = this_->fstack(sp)
		sp += 1
	else
		function = INVALID
	end if
	this_->sp = sp

end function

'':::::
private sub regPopReg( byval this_ as REGCLASS ptr, _
					   byval r as integer ) static
    dim as integer i, p

	p = this_->sp + 1

	for i = this_->sp to this_->regs - 1
		if( this_->fstack(i) = r ) then
			p = i
			exit for
		end if
	next i

	for i = p to this_->sp + 1 step -1
		this_->fstack(i) = this_->fstack(i - 1)
	next i

	this_->sp += 1

end sub

'':::::
private sub regClear( byval this_ as REGCLASS ptr ) static
    dim as integer r

	this_->sp 	  = this_->regs
	this_->freeTB = -1

	for r = 0 to this_->regs - 1
		this_->vregTB(r) = NULL
		this_->nextTB(r) = 0
		regPush( this_, r )
	next r

end sub

'':::::
private function regFindFarest( byval this_ as REGCLASS ptr ) as integer static
    dim as integer i, r
    dim as uinteger maxdist

    maxdist = 0
    r = INVALID
    for i = 0 to this_->regs - 1
    	if( this_->nextTB(i) > maxdist ) then
    		maxdist = this_->nextTB(i)
    		r = i
    	end if
    next i

	function = r

end function

'':::::
private function regAllocate( byval this_ as REGCLASS ptr, _
							  byval vreg as IRVREG ptr ) as integer static
    dim as integer r

	if( this_->sp < this_->regs ) then
		r = regPop( this_ )
	else
		r = regFindFarest( this_ )
	    irStoreVR( this_->vregTB(r), r )
	end if

	REG_SETUSED( this_->freeTB, r )
	this_->vregTB(r)	= vreg
	this_->nextTB(r)	= irGetDistance( vreg )

	function = r

end function

'':::::
private function regAllocateReg( byval this_ as REGCLASS ptr, _
								 byval r as integer, _
								 byval vreg as IRVREG ptr ) as integer static

	if( REG_ISFREE( this_->freeTB, r ) ) then
		regPopReg( this_, r )
		REG_SETUSED( this_->freeTB, r )
	end if

	this_->vregTB(r)	= vreg
	this_->nextTB(r)	= irGetDistance( vreg )

	function = r

end function

'':::::
private function regEnsure( byval this_ as REGCLASS ptr, _
							byval vreg as IRVREG ptr, _
							byval doload as integer ) as integer static
    dim as integer r

    r = vreg->reg
    if( r = INVALID ) then
    	r = regAllocate( this_, vreg )
    	irLoadVR( r, vreg, doload )
    end if

    function = r

end function

'':::::
private sub regSetOwner( byval this_ as REGCLASS ptr, _
						 byval r as integer, _
						 byval vreg as IRVREG ptr )

	REG_SETUSED( this_->freeTB, r )
	this_->vregTB(r) = vreg
	this_->nextTB(r) = irGetDistance( vreg )

end sub

'':::::
private sub regFree( byval this_ as REGCLASS ptr, _
					 byval r as integer ) static

	if( REG_ISUSED( this_->freeTB, r ) ) then
		REG_SETFREE( this_->freeTB, r )
		this_->vregTB(r) = NULL
		this_->nextTB(r) = 0
		regPush( this_, r )
	end if

end sub

'':::::
private function regIsFree( byval this_ as REGCLASS ptr, _
							byval r as integer ) as integer static

	function = REG_ISFREE( this_->freeTB, r )

end function

'':::::
private function regGetMaxRegs( byval this_ as REGCLASS ptr ) as integer static

    function = this_->regs

end function

'':::::
private function regGetFirst( byval this_ as REGCLASS ptr ) as integer static

	function = 0

end function

'':::::
private function regGetNext( byval this_ as REGCLASS ptr, _
							 byval r as integer ) as integer static

	function = INVALID

	if( r >= 0 ) then
		r += 1
		if( r < this_->regs ) then
			function = r
		end if
	end if

end function

'':::::
private function regGetVreg( byval this_ as REGCLASS ptr, _
							 byval r as integer ) as IRVREG ptr static

	function = this_->vregTB(r)

end function

'':::::
private function regGetRealReg( byval this_ as REGCLASS ptr, _
								byval r as integer ) as integer static

	function = r

end function

'':::::
private sub regDump( byval this_ as REGCLASS ptr )
#if 0
	dim as integer i, cnt

	cnt = 0
	for i = 0 to this_->regs - 1
		if( REG_ISUSED( this_->freeTB, i ) ) then
			print i;
			cnt += 1
		end If
	next

	if( cnt > 0 ) then print
#endif
end sub

'':::::
private sub regInitClass( byval reg as REGCLASS ptr )

	regClear( reg )

	reg->ensure 	= @regEnsure
	reg->allocate 	= @regAllocate
	reg->allocateReg= @regAllocateReg
	reg->free 		= @regFree
	reg->isFree 	= @regIsFree
	reg->setOwner 	= @regSetOwner
	reg->getMaxRegs	= @regGetMaxRegs
	reg->getFirst	= @regGetFirst
	reg->getNext	= @regGetNext
	reg->getVreg	= @regGetVreg
	reg->getRealReg	= @regGetRealReg
	reg->dump		= @regDump

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' stack registers allocator
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private function sregFindReg( byval this_ as REGCLASS ptr, _
							  byval vreg as IRVREG ptr ) as integer static
	dim as integer r

	function = INVALID

	if( this_->fregs = this_->regs ) then
		exit function
	end if

	for r = 0 to this_->regs - 1
		if( this_->regTB(r) <> INVALID ) then
			if( this_->vregTB(r) = vreg ) then
				return r
			end If
		end if
	next

end function

'':::::
private Sub sregXchg( byval this_ as REGCLASS ptr, _
					  byval r1 as integer ) Static
    dim as integer i, r2

	irXchgTOS( r1 )

	r2 = INVALID

	for i = 0 to this_->regs - 1
		if( this_->regTB(i) = 0 ) then
			r2 = i
			exit for
		end if
	next

	swap this_->regTB(r1), this_->regTB(r2)

End Sub

'':::::
private Function sregFindFreeReg( byval this_ as REGCLASS ptr ) as integer Static
	dim as integer r

    function = INVALID

    if( this_->fregs = 0 ) then
    	exit function
    end if

	for r = 0 to this_->regs - 1
		if( this_->regTB(r) = INVALID ) then
			return r
		end If
	next

end function

'':::::
private Function sregFindLowestReg( byval this_ as REGCLASS ptr ) as integer Static
	dim as integer r, i, lowest

	i = INVALID
	lowest = -32768

	for r = 0 to this_->regs - 1
		if( this_->regTB(r) <> INVALID ) then
			if( this_->regTB(r) > lowest ) then
				lowest = this_->regTB(r)
				i = r
			end if
		end If
	next

	function = i

end function

'':::::
private Function sregFindTOSReg( byval this_ as REGCLASS ptr ) as integer Static
	dim as integer r

	for r = 0 to this_->regs - 1
		if( this_->regTB(r) = 0 ) then
			return r
		end If
	next

	function = INVALID

end function

'':::::
private Function sregAllocate( byval this_ as REGCLASS ptr, _
							   byval vreg as IRVREG ptr ) as integer Static
	dim as integer r, i

	r = sregFindFreeReg( this_ )
	if( r = INVALID ) then

	    r = sregFindTOSReg( this_ )
	    irStoreVR( this_->vregTB(r), r )

	else
		this_->fregs -= 1

		For i = 0 to this_->regs - 1
			if( this_->regTB(i) <> INVALID ) then
				this_->regTB(i) += 1
			end If
		Next i
	end If

	this_->vregTB(r) = vreg
	this_->regTB(r)  = 0

	function = r

End Function

'':::::
private function sregAllocateReg( byval this_ as REGCLASS ptr, _
								  byval r as integer, _
								  byval vreg as IRVREG ptr ) as integer Static

	'' assuming r will be always 0 (result, TOS)
    function = sregAllocate( this_, vreg )

end function

'':::::
private Function sregEnsure( byval this_ as REGCLASS ptr, _
							 byval vreg as IRVREG ptr, _
							 byval doload as integer ) as integer Static
	dim as integer r

	r = sregFindReg( this_, vreg )
	if( r = INVALID ) then
		r = sregAllocate( this_, vreg )
		irLoadVR( r, vreg, doload )
	else
		assert( vreg->reg = r )
		if( this_->regTB(r) <> 0 ) then
			sregXchg( this_, r )
		end if
	end if

	function = r

End Function

'':::::
private sub sregFree( byval this_ as REGCLASS ptr, _
					  byval r as integer ) static
	dim as integer i, realreg

	if( this_->regTB(r) = INVALID ) then
		exit sub
	end if

	realreg = this_->regTB(r)
	this_->regTB(r) = INVALID
	this_->vregTB(r) = NULL

	for i = 0 to this_->regs - 1
		if( this_->regTB(i) <> INVALID ) then
			if( this_->regTB(i) > realreg ) then
				this_->regTB(i) -= 1
			end if
		end If
	next

	this_->fregs += 1

end sub

'':::::
private function sregIsFree( byval this_ as REGCLASS ptr, _
							 byval r as integer ) as integer static

	function = this_->regTB(r) = INVALID

end function

'':::::
private sub sregSetOwner( byval this_ as REGCLASS ptr, _
						  byval r as integer, _
						  byval vreg as IRVREG ptr ) static

	this_->vregTB(r) = vreg

end sub

'':::::
private function sregGetRealReg( byval this_ as REGCLASS ptr, _
								 byval r as integer ) as integer static

	function = this_->regTB(r)

end function

'':::::
private function sregGetMaxRegs( byval this_ as REGCLASS ptr ) as integer static

    function = this_->regs

end function

'':::::
private function sregGetFirst( byval this_ as REGCLASS ptr ) as integer static

	function = sregFindTOSReg( this_ )

end function

'':::::
private function sregGetNext( byval this_ as REGCLASS ptr, _
							  byval r as integer ) as integer static

	if( (r < 0) or (r >= this_->regs) ) then
		function = INVALID
	else
		function = sregFindTOSReg( this_ )
	end if

end function

'':::::
private function sregGetVreg( byval this_ as REGCLASS ptr, _
							  byval r as integer ) as IRVREG ptr static

	function = this_->vregTB(r)

end function

'':::::
private sub sregDump( byval this_ as REGCLASS ptr )
#if 0
	dim as integer i, cnt

	cnt = 0
	for i = 0 to this_->regs - 1
		if( this_->regTB(i) <> INVALID ) then
			print i;
			cnt += 1
		end If
	next

	if( cnt > 0 ) then print
#endif
end sub

'':::::
private sub sregInitClass( byval reg as REGCLASS ptr )
	dim as integer r

	reg->fregs = reg->regs

	for r = 0 to reg->regs - 1
		reg->regTB(r)	= INVALID
		reg->vregTB(r) 	= NULL
	Next r

	reg->ensure 	= @sregEnsure
	reg->allocate 	= @sregAllocate
	reg->allocateReg= @sregAllocateReg
	reg->free 		= @sregFree
	reg->isFree 	= @sregIsFree
	reg->setOwner 	= @sregSetOwner
	reg->getMaxRegs	= @sregGetMaxRegs
	reg->getFirst	= @sregGetFirst
	reg->getNext	= @sregGetNext
	reg->getVreg	= @sregGetVreg
	reg->getRealReg	= @sregGetRealReg
	reg->dump		= @sregDump

end sub


