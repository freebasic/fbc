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

'$include:'inc\fb.bi'
'$include:'inc\fbint.bi'
'$include:'inc\ir.bi'
'$include:'inc\reg.bi'

'' internals
declare sub regInitClass		( byval reg as REGCLASS ptr )
declare sub sregInitClass		( byval reg as REGCLASS ptr )


'':::::
function regNewClass( byval class as integer, byval regs as integer, byval isstack as integer ) as REGCLASS ptr
    dim reg as REGCLASS ptr

	reg = callocate( len( REGCLASS ) )

	reg->class 	= class
	reg->regs 	= regs
	reg->isstack= isstack

	if( not reg->isstack ) then
		regInitClass reg
	else
		sregInitClass reg
	end if

	regNewClass = reg

end function

'':::::
function regDelClass( byval reg as REGCLASS ptr ) as integer

	regDelClass = FALSE

	if( reg = NULL ) then
		exit function
	end if

	deallocate reg

	regDelClass = TRUE

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' non-stack registers allocator
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub regPush( byval this_ as REGCLASS ptr, byval r as integer ) static
    dim sp as integer

	sp = this_->sp
	if( sp > 0 ) then
		sp = sp - 1
		this_->fstack(sp) = r
	end if
	this_->sp = sp

end sub

'':::::
private function regPop( byval this_ as REGCLASS ptr ) as integer static
    dim sp as integer

	sp = this_->sp
	if( sp < this_->regs ) then
		regPop = this_->fstack(sp)
		sp = sp + 1
	else
		regPop = INVALID
	end if
	this_->sp = sp

end function

'':::::
private sub regPopReg( byval this_ as REGCLASS ptr, byval r as integer ) static
    dim i as integer, p as integer

	for i = this_->sp to this_->regs-1
		if( this_->fstack(i) = r ) then
			p = i
			exit for
		end if
	next i

	for i = p to this_->sp+1 step -1
		this_->fstack(i) = this_->fstack(i-1)
	next i

	this_->sp = this_->sp + 1

end sub

'':::::
private sub regClear( byval this_ as REGCLASS ptr ) static
    dim r as integer

	this_->sp		= this_->regs

	for r = 0 to this_->regs-1
		this_->freeTB(r)	= TRUE
		this_->vregTB(r)	= INVALID
		this_->nextTB(r)		= 0
		regPush this_, r
	next r

end sub

'':::::
private function regFindReg( byval this_ as REGCLASS ptr, byval vreg as integer ) as integer static
	dim r as integer

	for r = 0 to this_->regs-1
		if( this_->vregTB(r) = vreg ) then
			regFindReg = r
			exit function
		end if
	next r

	regFindReg = INVALID

end function

'':::::
private function regFindFarest( byval this_ as REGCLASS ptr ) as integer static
    dim i as integer, r as integer, maxdist as integer

    maxdist = -32768
    r 	= INVALID
    for i = 0 to this_->regs
    	if( this_->nextTB(i) > maxdist ) then
    		maxdist = this_->nextTB(i)
    		r = i
    	end if
    next i

	regFindFarest = r

end function

'':::::
private function regAllocate( byval this_ as REGCLASS ptr, byval vreg as integer ) as integer static
    dim r as integer

	if( this_->sp < this_->regs ) then
		r = regPop( this_ )
	else
		r = regFindFarest( this_ )
	    irStoreVR this_->vregTB(r), r
	end if

	this_->freeTB(r)	= FALSE
	this_->vregTB(r)	= vreg
	this_->nextTB(r)	= irGetDistance( vreg )

	regAllocate = r

end function

'':::::
private function regAllocateReg( byval this_ as REGCLASS ptr, byval r as integer, byval vreg as integer ) as integer static

	regPopReg this_, r

	this_->freeTB(r)	= FALSE
	this_->vregTB(r)	= vreg
	this_->nextTB(r)	= irGetDistance( vreg )

	regAllocateReg = r

end function

'':::::
private function regEnsure( byval this_ as REGCLASS ptr, byval vreg as integer ) as integer static
    dim r as integer

    r = regFindReg( this_, vreg )
    if( r = INVALID ) then
    	r = regAllocate( this_, vreg )
    	irLoadVR r, vreg
    else
    	'''''irSetVR r, vreg
    end if

    regEnsure = r

end function

'':::::
private sub regSetOwner( byval this_ as REGCLASS ptr, byval r as integer, byval vreg as integer )

	this_->freeTB(r)	= FALSE
	this_->vregTB(r)	= vreg
	this_->nextTB(r)	= irGetDistance( vreg )

end sub

'':::::
private sub regFree( byval this_ as REGCLASS ptr, byval r as integer ) static

	if( not this_->freeTB(r) ) then
		this_->freeTB(r) = TRUE
		this_->vregTB(r) = INVALID
		this_->nextTB(r) = 0
		regPush this_, r
	end if

end sub

'':::::
private function regIsFree( byval this_ as REGCLASS ptr, byval r as integer ) as integer static

	regIsFree = this_->freeTB(r)

end function

'':::::
private function regGetMaxRegs( byval this_ as REGCLASS ptr ) as integer static

    regGetMaxRegs = this_->regs

end function

'':::::
private function regGetFirst( byval this_ as REGCLASS ptr ) as integer static

	regGetFirst = 0

end function

'':::::
private function regGetNext( byval this_ as REGCLASS ptr, byval r as integer ) as integer static

	regGetNext = INVALID

	if( r >= 0 ) then
		r = r + 1
		if( r < this_->regs ) then
			regGetNext = r
		end if
	end if

end function

'':::::
private function regGetVreg( byval this_ as REGCLASS ptr, byval r as integer ) as integer static

	regGetVreg = this_->vregTB(r)

end function

'':::::
private function regGetRealReg( byval this_ as REGCLASS ptr, byval r as integer ) as integer static

	regGetRealReg = r

end function

'':::::
private sub regInitClass( byval reg as REGCLASS ptr )

	regClear reg

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

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' stack registers allocator
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private Function sregFindReg( byval this_ as REGCLASS ptr, byval vreg as integer ) as integer Static
	Dim r as integer

	sregFindReg = INVALID

	If( this_->fregs = this_->regs ) Then
		Exit Function
	End If

	For r = 0 to this_->regs-1
		if( this_->regTB(r) <> INVALID ) then
			If( this_->vregTB(r) = vreg ) Then
				sregFindReg = r
				Exit Function
			End If
		end if
	Next r

End Function

'':::::
private Sub sregXchg( byval this_ as REGCLASS ptr, byval r1 as integer ) Static
    dim i as integer, r2 as integer

	irXchgTOS r1

	r2 = INVALID

	For i = 0 to this_->regs-1
		if( this_->regTB(i) = 0 ) then
			r2 = i
			exit for
		end if
	next i

	swap this_->regTB(r1), this_->regTB(r2)

End Sub

'':::::
private Function sregFindFreeReg( byval this_ as REGCLASS ptr ) as integer Static
	Dim r as integer

    sregFindFreeReg = INVALID

    if( this_->fregs = 0 ) then
    	exit function
    end if

	For r = 0 to this_->regs-1
		if( this_->regTB(r) = INVALID ) then
			sregFindFreeReg = r
			exit function
		end If
	Next r

end function

'':::::
private Function sregFindLowestReg( byval this_ as REGCLASS ptr ) as integer Static
	Dim r as integer, i as integer, lowest as integer

	i = INVALID
	lowest = -32768

	For r = 0 to this_->regs-1
		if( this_->regTB(r) <> INVALID ) then
			if( this_->regTB(r) > lowest ) then
				lowest = this_->regTB(r)
				i = r
			end if
		end If
	Next r

	sregFindLowestReg = i

end function

'':::::
private Function sregFindTOSReg( byval this_ as REGCLASS ptr ) as integer Static
	Dim r as integer

	For r = 0 to this_->regs-1
		if( this_->regTB(r) = 0 ) then
			sregFindTOSReg = r
			exit function
		end If
	Next r

	sregFindTOSReg = INVALID

end function

'':::::
private Function sregAllocate( byval this_ as REGCLASS ptr, byval vreg as integer ) as integer Static
	Dim r as integer, i as integer

	r = sregFindFreeReg( this_ )
	if( r = INVALID ) Then

	    r = sregFindTOSReg( this_ )
	    irStoreVR this_->vregTB(r), r

	else
		this_->fregs = this_->fregs - 1

		For i = 0 to this_->regs-1
			if( this_->regTB(i) <> INVALID ) then
				this_->regTB(i) = this_->regTB(i) + 1
			end If
		Next i
	end If

	this_->vregTB(r) = vreg
	this_->regTB(r)  = 0

	sregAllocate = r

End Function

'':::::
private function sregAllocateReg( byval this_ as REGCLASS ptr, byval r as integer, byval vreg as integer ) as integer Static

	'' assuming r will be always 0 (result, TOS)
    sregAllocateReg = sregAllocate( this_, vreg )
    exit function

end function

'':::::
private Function sregEnsure( byval this_ as REGCLASS ptr, byval vreg as integer ) as integer Static
	Dim r as integer

	r = sregFindReg( this_, vreg )
	If( r = INVALID ) Then
		r = sregAllocate( this_, vreg )
		irLoadVR r, vreg
	Else
		If( this_->regTB(r) <> 0 ) Then
			sregXchg this_, r
		End If
		'''''irSetVR r, vreg
	End If

	sregEnsure = r

End Function

'':::::
private sub sregFree( byval this_ as REGCLASS ptr, byval r as integer ) static
	Dim i as integer, realreg as integer

	if( this_->regTB(r) = INVALID ) then
		exit sub
	end if

	realreg 	= this_->regTB(r)
	this_->regTB(r) = INVALID

	For i = 0 to this_->regs-1
		if( this_->regTB(i) <> INVALID ) then
			if( this_->regTB(i) > realreg ) then
				this_->regTB(i) = this_->regTB(i) - 1
			end if
		end If
	Next i

	this_->fregs = this_->fregs + 1

end sub

'':::::
private function sregIsFree( byval this_ as REGCLASS ptr, byval r as integer ) as integer static

	sregIsFree = this_->regTB(r) = INVALID

end function

'':::::
private sub sregSetOwner( byval this_ as REGCLASS ptr, byval r as integer, byval vreg as integer ) static

	this_->vregTB(r) = vreg

end sub

'':::::
private function sregGetRealReg( byval this_ as REGCLASS ptr, byval r as integer ) as integer static

	sregGetRealReg = this_->regTB(r)

end function

'':::::
private function sregGetMaxRegs( byval this_ as REGCLASS ptr ) as integer static

    sregGetMaxRegs = this_->regs

end function

'':::::
private function sregGetFirst( byval this_ as REGCLASS ptr ) as integer static

	sregGetFirst = sregFindTOSReg( this_ )

end function

'':::::
private function sregGetNext( byval this_ as REGCLASS ptr, byval r as integer ) as integer static

	if( r < 0 or r >= this_->regs ) then
		sregGetNext = INVALID
	else
		sregGetNext = sregFindTOSReg( this_ )
	end if

end function

'':::::
private function sregGetVreg( byval this_ as REGCLASS ptr, byval r as integer ) as integer static

	sregGetVreg = this_->vregTB(r)

end function

'':::::
private sub sregDump( byval this_ as REGCLASS ptr )
	dim i as integer, cnt as integer

	cnt = 0
	For i = 0 to this_->regs-1
		if( this_->regTB(i) <> INVALID ) then
			print i; "="; this_->regTB(i);
			cnt = cnt + 1
		end If
	Next i

	if( cnt > 0 ) then print

end sub

'':::::
private sub sregInitClass( byval reg as REGCLASS ptr )
	dim r as integer

	reg->fregs = reg->regs

	for r = 0 to reg->regs-1
		reg->regTB(r)	= INVALID
		reg->vregTB(r) 	= INVALID
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

end sub


