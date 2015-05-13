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
 
#ifndef __cpGrooveJoint_bi__
#define __cpGrooveJoint_bi__
extern cpGrooveJointClass alias "cpGrooveJointClass" as cpConstraintClass

type cpGrooveJoint
	constraint as cpConstraint
	grv_n as cpVect
	grv_a as cpVect
	grv_b as cpVect
	anchr2 as cpVect
	grv_tn as cpVect
	clamp as cpFloat
	r1 as cpVect
	r2 as cpVect
	k1 as cpVect
	k2 as cpVect
	jAcc as cpVect
	jMaxLen as cpFloat
	bias as cpVect
end type



declare function cpGrooveJointAlloc cdecl alias "cpGrooveJointAlloc" () as cpGrooveJoint ptr
declare function cpGrooveJointInit cdecl alias "cpGrooveJointInit" (byval joint as cpGrooveJoint ptr, byval a as cpBody ptr, byval b as cpBody ptr, byval groove_a as cpVect, byval groove_b as cpVect, byval anchr2 as cpVect) as cpGrooveJoint ptr
declare function cpGrooveJointNew cdecl alias "cpGrooveJointNew" (byval a as cpBody ptr, byval b as cpBody ptr, byval groove_a as cpVect, byval groove_b as cpVect, byval anchr2 as cpVect) as cpConstraint ptr

#endif
