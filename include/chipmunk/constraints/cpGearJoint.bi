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
 
#ifndef __cpGearJoint_bi__
#define __cpGearJoint_bi__
extern cpGearJointClass alias "cpGearJointClass" as cpConstraintClass

type cpGearJoint
	constraint as cpConstraint
	phase as cpFloat
	ratio as cpFloat
	iSum as cpFloat
	bias as cpFloat
	jAcc as cpFloat
	jMax as cpFloat
end type


declare function cpGearJointAlloc cdecl alias "cpGearJointAlloc" () as cpGearJoint ptr
declare function cpGearJointInit cdecl alias "cpGearJointInit" (byval joint as cpGearJoint ptr, byval a as cpBody ptr, byval b as cpBody ptr, byval phase as cpFloat, byval ratio as cpFloat) as cpGearJoint ptr
declare function cpGearJointNew cdecl alias "cpGearJointNew" (byval a as cpBody ptr, byval b as cpBody ptr, byval phase as cpFloat, byval ratio as cpFloat) as cpConstraint ptr

#endif
