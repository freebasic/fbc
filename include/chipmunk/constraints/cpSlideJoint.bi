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
 
#ifndef __cpSlideJoint_bi__
#define __cpSlideJoint_bi__
extern cpSlideJointClass alias "cpSlideJointClass" as cpConstraintClass

type cpSlideJoint
	constraint as cpConstraint
	anchr1 as cpVect
	anchr2 as cpVect
	min as cpFloat
	max as cpFloat
	r1 as cpVect
	r2 as cpVect
	n as cpVect
	nMass as cpFloat
	jnAcc as cpFloat
	jnMax as cpFloat
	bias as cpFloat
end type


declare function cpSlideJointAlloc cdecl alias "cpSlideJointAlloc" () as cpSlideJoint ptr
declare function cpSlideJointInit cdecl alias "cpSlideJointInit" (byval joint as cpSlideJoint ptr, byval a as cpBody ptr, byval b as cpBody ptr, byval anchr1 as cpVect, byval anchr2 as cpVect, byval min as cpFloat, byval max as cpFloat) as cpSlideJoint ptr
declare function cpSlideJointNew cdecl alias "cpSlideJointNew" (byval a as cpBody ptr, byval b as cpBody ptr, byval anchr1 as cpVect, byval anchr2 as cpVect, byval min as cpFloat, byval max as cpFloat) as cpConstraint ptr

#endif
