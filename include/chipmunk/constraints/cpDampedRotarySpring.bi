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
 
#ifndef __cpDampedRotarySpring_bi__
#define __cpDampedRotarySpring_bi__
extern cpDampedRotarySpringClass alias "cpDampedRotarySpringClass" as cpConstraintClass

type cpDampedRotarySpring
	constraint as cpConstraint
	restAngle as cpFloat
	stiffness as cpFloat
	damping as cpFloat
	dt as cpFloat
	target_wrn as cpFloat
	iSum as cpFloat
end type


declare function cpDampedRotarySpringAlloc cdecl alias "cpDampedRotarySpringAlloc" () as cpDampedRotarySpring ptr
declare function cpDampedRotarySpringInit cdecl alias "cpDampedRotarySpringInit" (byval joint as cpDampedRotarySpring ptr, byval a as cpBody ptr, byval b as cpBody ptr, byval restAngle as cpFloat, byval stiffness as cpFloat, byval damping as cpFloat) as cpDampedRotarySpring ptr
declare function cpDampedRotarySpringNew cdecl alias "cpDampedRotarySpringNew" (byval a as cpBody ptr, byval b as cpBody ptr, byval restAngle as cpFloat, byval stiffness as cpFloat, byval damping as cpFloat) as cpConstraint ptr

#endif
