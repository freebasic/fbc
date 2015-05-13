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
 
#ifndef __cpDampedSpring_bi__
#define __cpDampedSpring_bi__
extern cpDampedSpringClass alias "cpDampedSpringClass" as cpConstraintClass

type cpDampedSpring
	constraint as cpConstraint
	anchr1 as cpVect
	anchr2 as cpVect
	restLength as cpFloat
	stiffness as cpFloat
	damping as cpFloat
	dt as cpFloat
	target_vrn as cpFloat
	r1 as cpVect
	r2 as cpVect
	nMass as cpFloat
	n as cpVect
end type


declare function cpDampedSpringAlloc cdecl alias "cpDampedSpringAlloc" () as cpDampedSpring ptr
declare function cpDampedSpringInit cdecl alias "cpDampedSpringInit" (byval joint as cpDampedSpring ptr, byval a as cpBody ptr, byval b as cpBody ptr, byval anchr1 as cpVect, byval anchr2 as cpVect, byval restLength as cpFloat, byval stiffness as cpFloat, byval damping as cpFloat) as cpDampedSpring ptr
declare function cpDampedSpringNew cdecl alias "cpDampedSpringNew" (byval a as cpBody ptr, byval b as cpBody ptr, byval anchr1 as cpVect, byval anchr2 as cpVect, byval restLength as cpFloat, byval stiffness as cpFloat, byval damping as cpFloat) as cpConstraint ptr

#endif
