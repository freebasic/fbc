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

defint a-z
option explicit

'$include:'inc\fb.bi'
'$include:'inc\fbint.bi'
'$include:'inc\ir.bi'
'$include:'inc\reg.bi'

'' internals
declare function 	regFindFarest	( byval c as integer ) as integer
declare function 	regFindReg		( byval c as integer, byval vreg as integer ) as integer
declare sub 		regPush			( byval c as integer, byval reg as integer )
declare function 	regPop			( byval c as integer ) as integer

declare sub 		sregInit		( byval classes as integer )
declare sub 		sregInitClass	( byval c as integer, byval regs as integer )
declare function 	sregFindReg		( byval vreg as integer ) as integer
declare sub 		sregXchg		( byval t as integer, byval c as integer, byval r as integer )
declare function 	sregEnsure		( byval t as integer, byval c as integer, byval vreg as integer ) as integer
declare function 	sregAllocate	( byval t as integer, byval c as integer, byval vreg as integer ) as integer
declare sub 		sregFree		( byval t as integer, byval c as integer, byval r as integer )
declare function 	sregIsFree		( byval t as integer, byval c as integer, byval r as integer ) as integer
declare sub 		sregSetOwner	( byval t as integer, byval c as integer, byval r as integer, byval vreg as integer )
declare function 	sregGetFirst	( byval class as integer ) as integer
declare function 	sregGetNext		( byval class as integer, byval r as integer ) as integer
declare function 	sregGetVreg		( byval class as integer, byval r as integer ) as integer


'' globals
	dim shared reg as REGCLASS
	dim shared sreg as SREGCLASS


'':::::
sub regPush( byval c as integer, byval r as integer ) static
    dim sp as integer

	sp = reg.sp
	if( sp > 0 ) then
		sp = sp - 1
		reg.fstack(sp) = r
	end if
	reg.sp = sp

end sub

'':::::
function regPop( byval c as integer ) as integer static
    dim sp as integer

	sp = reg.sp
	if( sp < reg.regs ) then
		regPop = reg.fstack(sp)
		sp = sp + 1
	else
		regPop = INVALID
	end if
	reg.sp = sp

end function

'':::::
sub regPopReg( byval c as integer, byval r as integer ) static
    dim i as integer, p as integer

	for i = reg.sp to reg.regs-1
		if( reg.fstack(i) = r ) then
			p = i
			exit for
		end if
	next i

	for i = p to reg.sp+1 step -1
		reg.fstack(i) = reg.fstack(i-1)
	next i

	reg.sp = reg.sp + 1

end sub

'':::::
sub regInit( byval classes as integer ) static

    'if( class = IR.DATACLASS.FPOINT ) then
    	sregInit classes
    '	exit sub
    'end if

	'' do nothing, reg is not reallocable

end sub

'':::::
sub regInitClass( byval c as integer, byval regs as integer ) static

    if( c = IR.DATACLASS.FPOINT ) then
    	sregInitClass c, regs
    	exit sub
    end if

	reg.regs = regs

	regClear c

end sub

'':::::
sub regClear( byval c as integer ) static
    dim r as integer

	reg.sp		= reg.regs

	for r = 0 to reg.regs-1
		reg.free(r)	= TRUE
		reg.vreg(r) = INVALID
		reg.nxt(r)	= 0
		regPush c, r
	next r

end sub

'':::::
function regFindReg( byval c as integer, byval vreg as integer ) as integer static
	dim r as integer

	for r = 0 to reg.regs-1
		if( reg.vreg(r) = vreg ) then
			regFindReg = r
			exit function
		end if
	next r

	regFindReg = INVALID

end function

'':::::
function regEnsure( byval t as integer, byval c as integer, byval vreg as integer ) as integer static
    dim r as integer

    if( c = IR.DATACLASS.FPOINT ) then
    	regEnsure = sregEnsure( t, c, vreg )
    	exit function
    end if

    r = regFindReg( c, vreg )
    if( r = INVALID ) then
    	r = regAllocate( t, c, vreg )
    	irLoadVR t, c, r, vreg
    else
    	'''''irSetVR t, c, r, vreg
    end if

    regEnsure = r

end function

'':::::
function regFindFarest( byval c as integer ) as integer static
    dim i as integer, r as integer, maxdist as integer

    maxdist = -32768
    r 	= INVALID
    for i = 0 to reg.regs
    	if( reg.nxt(i) > maxdist ) then
    		maxdist = reg.nxt(i)
    		r = i
    	end if
    next i

	regFindFarest = r

end function

'':::::
function regAllocate( byval t as integer, byval c as integer, byval vreg as integer ) as integer static
    dim r as integer

    if( c = IR.DATACLASS.FPOINT ) then
    	regAllocate = sregAllocate( t, c, vreg )
    	exit function
    end if

	if( reg.sp < reg.regs ) then
		r = regPop( c )
	else
		r = regFindFarest( c )
	    irStoreVR t, c, reg.vreg(r), r
	end if

	reg.free(r)	= FALSE
	reg.vreg(r)	= vreg
	reg.nxt(r)	= irGetDistance( vreg )

	regAllocate = r

end function

'':::::
function regAllocateReg( byval t as integer, byval c as integer, byval r as integer, byval vreg as integer ) as integer static

    if( c = IR.DATACLASS.FPOINT ) then
    	'' assuming r will be always 0 (result, TOS)
    	regAllocateReg = sregAllocate( t, c, vreg )
    	exit function
    end if

	regPopReg c, r

	reg.free(r)	= FALSE
	reg.vreg(r)	= vreg
	reg.nxt(r)	= irGetDistance( vreg )

	regAllocateReg = r

end function

'':::::
sub regSetOwner( byval t as integer, byval c as integer, byval r as integer, byval vreg as integer )

    if( c = IR.DATACLASS.FPOINT ) then
    	sregSetOwner t, c, r, vreg
    	exit sub
    end if

	reg.free(r)	= FALSE
	reg.vreg(r)	= vreg
	reg.nxt(r)	= irGetDistance( vreg )

end sub

'':::::
sub regFree( byval t as integer, byval c as integer, byval r as integer ) static

    if( c = IR.DATACLASS.FPOINT ) then
    	sregFree t, c, r
    	exit sub
    end if

	if( not reg.free(r) ) then
		reg.free(r) = TRUE
		reg.vreg(r) = INVALID
		reg.nxt(r)  = 0
		regPush c, r
	end if

end sub

'':::::
function regIsFree( byval typ as integer, byval class as integer, byval r as integer ) as integer static

    if( class = IR.DATACLASS.FPOINT ) then
    	regIsFree = sregIsFree( typ, class, r )
    	exit function
    end if

	regIsFree = reg.free(r)

end function

'':::::
function regGetMaxRegs( byval c as integer ) as integer static

    if( c = IR.DATACLASS.FPOINT ) then
    	regGetMaxRegs = sreg.regs
    else
    	regGetMaxRegs = reg.regs
    end if

end function

'':::::
function regGetFirst( byval class as integer ) as integer static

    if( class = IR.DATACLASS.FPOINT ) then
    	regGetFirst = sregGetFirst( class )
    	exit function
    end if

	regGetFirst = 0

end function

'':::::
function regGetNext( byval class as integer, byval r as integer ) as integer static

    if( class = IR.DATACLASS.FPOINT ) then
    	regGetNext = sregGetNext( class, r )
    	exit function
    end if

	regGetNext = INVALID

	if( r >= 0 ) then
		r = r + 1
		if( r < reg.regs ) then
			regGetNext = r
		end if
	end if

end function

'':::::
function regGetVreg( byval class as integer, byval r as integer ) as integer static

    if( class = IR.DATACLASS.FPOINT ) then
    	regGetVreg = sregGetVreg( class, r )
    	exit function
    end if

	regGetVreg = reg.vreg(r)

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' stack register allocator
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub sregInit( byval classes as integer ) Static

	'' do nothing, sreg is not reallocable

End Sub

'':::::
sub sregInitClass( byval c as integer, byval regs as integer ) Static
	Dim r as integer

	sreg.regs  = regs
	sreg.fregs = regs

	for r = 0 to sreg.regs-1
		sreg.reg(r)	 = INVALID
		sreg.vreg(r) = INVALID
	Next r

End Sub

'':::::
Function sregFindReg( byval vreg as integer ) as integer Static
	Dim r as integer

	sregFindReg = INVALID

	If( sreg.fregs = sreg.regs ) Then
		Exit Function
	End If

	For r = 0 to sreg.regs-1
		if( sreg.reg(r) <> INVALID ) then
			If( sreg.vreg(r) = vreg ) Then
				sregFindReg = r
				Exit Function
			End If
		end if
	Next r

End Function

'':::::
Sub sregXchg( byval t as integer, byval c as integer, byval r1 as integer ) Static
    dim i as integer, r2 as integer

	irXchgTOS t, c, r1

	r2 = INVALID

	For i = 0 to sreg.regs-1
		if( sreg.reg(i) = 0 ) then
			r2 = i
			exit for
		end if
	next i

	swap sreg.reg(r1), sreg.reg(r2)

End Sub

'':::::
Function sregEnsure( byval t as integer, byval c as integer, byval vreg as integer ) as integer Static
	Dim r as integer

	r = sregFindReg( vreg )
	If( r = INVALID ) Then
		r = sregAllocate( t, c, vreg )
		irLoadVR t, c, r, vreg
	Else
		If( sreg.reg(r) <> 0 ) Then
			sregXchg t, c, r
		End If
		'''''irSetVR t, c, r, vreg
	End If

	sregEnsure = r

End Function

'':::::
Function sregFindFreeReg as integer Static
	Dim r as integer

    sregFindFreeReg = INVALID

    if( sreg.fregs = 0 ) then
    	exit function
    end if

	For r = 0 to sreg.regs-1
		if( sreg.reg(r) = INVALID ) then
			sregFindFreeReg = r
			exit function
		end If
	Next r

end function

'':::::
Function sregFindLowestReg as integer Static
	Dim r as integer, i as integer, lowest as integer

	i = INVALID
	lowest = -32768

	For r = 0 to sreg.regs-1
		if( sreg.reg(r) <> INVALID ) then
			if( sreg.reg(r) > lowest ) then
				lowest = sreg.reg(r)
				i = r
			end if
		end If
	Next r

	sregFindLowestReg = i

end function

'':::::
Function sregFindTOSReg as integer Static
	Dim r as integer

	For r = 0 to sreg.regs-1
		if( sreg.reg(r) = 0 ) then
			sregFindTOSReg = r
			exit function
		end If
	Next r

	sregFindTOSReg = INVALID

end function

'':::::
Function sregAllocate( byval t as integer, byval c as integer, byval vreg as integer ) as integer Static
	Dim r as integer, i as integer

	r = sregFindFreeReg
	if( r = INVALID ) Then

	    r = sregFindTOSReg
	    irStoreVR t, c, sreg.vreg(r), r

	else
		sreg.fregs = sreg.fregs - 1

		For i = 0 to sreg.regs-1
			if( sreg.reg(i) <> INVALID ) then
				sreg.reg(i) = sreg.reg(i) + 1
			end If
		Next i
	end If

	sreg.vreg(r) = vreg
	sreg.reg(r)  = 0

	'print "alc: ";
	'sregDump

	sregAllocate = r

End Function

'':::::
sub sregFree( byval t as integer, byval c as integer, byval r as integer ) static
	Dim i as integer, realreg as integer

	if( sreg.reg(r) = INVALID ) then
		exit sub
	end if

	realreg 	= sreg.reg(r)
	sreg.reg(r) = INVALID

	For i = 0 to sreg.regs-1
		if( sreg.reg(i) <> INVALID ) then
			if( sreg.reg(i) > realreg ) then
				sreg.reg(i) = sreg.reg(i) - 1
			end if
		end If
	Next i

	'print "dlc: ";
	'sregDump

	sreg.fregs = sreg.fregs + 1

end sub

'':::::
function sregIsFree( byval t as integer, byval c as integer, byval r as integer ) as integer static

	sregIsFree = sreg.reg(r) = INVALID

end function

'':::::
sub sregSetOwner( byval t as integer, byval c as integer, byval r as integer, byval vreg as integer ) static

	sreg.vreg(r) = vreg

end sub

'':::::
function sregGetRealReg( byval r as integer ) as integer static

	sregGetRealReg = sreg.reg(r)

end function

'':::::
function sregGetFirst( byval class as integer ) as integer static

	sregGetFirst = sregFindTOSReg

end function

'':::::
function sregGetNext( byval class as integer, byval r as integer ) as integer static

	if( r < 0 or r >= sreg.regs ) then
		sregGetNext = INVALID
	else
		sregGetNext = sregFindTOSReg
	end if

end function

'':::::
function sregGetVreg( byval class as integer, byval r as integer ) as integer static

	sregGetVreg = sreg.vreg(r)

end function


'':::::
sub sregDump
	dim i as integer, cnt as integer

	cnt = 0
	For i = 0 to sreg.regs-1
		if( sreg.reg(i) <> INVALID ) then
			print i; "="; sreg.reg(i);
			cnt = cnt + 1
		end If
	Next i

	if( cnt > 0 ) then print

end sub

