/' Copyright (c) 2007 Scott Lembcke
 ' 
 ' Permission is hereby granted, free of charge, to any person obtaining a copy
 ' of this software and associated documentation files (the "Software"), to deal
 ' in the Software without restriction, including without limitation the rights
 ' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 ' copies of the Software, and to permit persons to whom the Software is
 ' furnished to do so, subject to the following conditions:
 ' 
 ' The above copyright notice and this permission notice shall be included in
 ' all copies or substantial portions of the Software.
 ' 
 ' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 ' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 ' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 ' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 ' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 ' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 ' SOFTWARE.
 '/
 
#ifndef __cpArbiter_bi__
#define __cpArbiter_bi__
extern cp_bias_coef alias "cp_bias_coef" as cpFloat
extern cp_collision_slop alias "cp_collision_slop" as cpFloat

type cpContact
	p as cpVect
	n as cpVect
	dist as cpFloat
	r1 as cpVect
	r2 as cpVect
	nMass as cpFloat
	tMass as cpFloat
	bounce as cpFloat
	jnAcc as cpFloat
	jtAcc as cpFloat
	jBias as cpFloat
	bias as cpFloat
	hash as uinteger
end type

declare function cpContactInit cdecl alias "cpContactInit" (byval con as cpContact ptr, byval p as cpVect, byval n as cpVect, byval dist as cpFloat, byval hash as uinteger) as cpContact ptr
declare function cpContactsSumImpulses cdecl alias "cpContactsSumImpulses" (byval contacts as cpContact ptr, byval numContacts as integer) as cpVect
declare function cpContactsSumImpulsesWithFriction cdecl alias "cpContactsSumImpulsesWithFriction" (byval contacts as cpContact ptr, byval numContacts as integer) as cpVect

type cpArbiter
	numContacts as integer
	contacts as cpContact ptr
	a as cpShape ptr
	b as cpShape ptr
	u as cpFloat
	target_v as cpVect
	stamp as integer
end type


declare function cpArbiterAlloc cdecl alias "cpArbiterAlloc" () as cpArbiter ptr
declare function cpArbiterInit cdecl alias "cpArbiterInit" (byval arb as cpArbiter ptr, byval a as cpShape ptr, byval b as cpShape ptr, byval stamp as integer) as cpArbiter ptr
declare function cpArbiterNew cdecl alias "cpArbiterNew" (byval a as cpShape ptr, byval b as cpShape ptr, byval stamp as integer) as cpArbiter ptr
declare sub cpArbiterDestroy cdecl alias "cpArbiterDestroy" (byval arb as cpArbiter ptr)
declare sub cpArbiterFree cdecl alias "cpArbiterFree" (byval arb as cpArbiter ptr)
declare sub cpArbiterInject cdecl alias "cpArbiterInject" (byval arb as cpArbiter ptr, byval contacts as cpContact ptr, byval numContacts as integer)
declare sub cpArbiterPreStep cdecl alias "cpArbiterPreStep" (byval arb as cpArbiter ptr, byval dt_inv as cpFloat)
declare sub cpArbiterApplyCachedImpulse cdecl alias "cpArbiterApplyCachedImpulse" (byval arb as cpArbiter ptr)
declare sub cpArbiterApplyImpulse cdecl alias "cpArbiterApplyImpulse" (byval arb as cpArbiter ptr, byval eCoef as cpFloat)

#endif
