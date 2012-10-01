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
 
#ifndef __cpSpace_bi__
#define __cpSpace_bi__
extern cp_contact_persistence alias "cp_contact_persistence" as integer

type cpCollFunc as function cdecl(byval as cpShape ptr, byval as cpShape ptr, byval as cpContact ptr, byval as integer, byval as cpFloat, byval as any ptr) as integer

type cpCollPairFunc
	a as uinteger
	b as uinteger
	func as cpCollFunc
	data as any ptr
end type


type cpSpace
	iterations as integer
	elasticIterations as integer
	gravity as cpVect
	damping as cpFloat
	stamp as integer
	staticShapes as cpSpaceHash ptr
	activeShapes as cpSpaceHash ptr
	bodies as cpArray ptr
	arbiters as cpArray ptr
	contactSet as cpHashSet ptr
	constraints as cpArray ptr
	collFuncSet as cpHashSet ptr
	defaultPairFunc as cpCollPairFunc
end type


declare function cpSpaceAlloc cdecl alias "cpSpaceAlloc" () as cpSpace ptr
declare function cpSpaceInit cdecl alias "cpSpaceInit" (byval space as cpSpace ptr) as cpSpace ptr
declare function cpSpaceNew cdecl alias "cpSpaceNew" () as cpSpace ptr
declare sub cpSpaceDestroy cdecl alias "cpSpaceDestroy" (byval space as cpSpace ptr)
declare sub cpSpaceFree cdecl alias "cpSpaceFree" (byval space as cpSpace ptr)
declare sub cpSpaceFreeChildren cdecl alias "cpSpaceFreeChildren" (byval space as cpSpace ptr)
declare sub cpSpaceAddCollisionPairFunc cdecl alias "cpSpaceAddCollisionPairFunc" (byval space as cpSpace ptr, byval a as uinteger, byval b as uinteger, byval func as cpCollFunc, byval data as any ptr)
declare sub cpSpaceRemoveCollisionPairFunc cdecl alias "cpSpaceRemoveCollisionPairFunc" (byval space as cpSpace ptr, byval a as uinteger, byval b as uinteger)
declare sub cpSpaceSetDefaultCollisionPairFunc cdecl alias "cpSpaceSetDefaultCollisionPairFunc" (byval space as cpSpace ptr, byval func as cpCollFunc, byval data as any ptr)
declare sub cpSpaceAddShape cdecl alias "cpSpaceAddShape" (byval space as cpSpace ptr, byval shape as cpShape ptr)
declare sub cpSpaceAddStaticShape cdecl alias "cpSpaceAddStaticShape" (byval space as cpSpace ptr, byval shape as cpShape ptr)
declare sub cpSpaceAddBody cdecl alias "cpSpaceAddBody" (byval space as cpSpace ptr, byval body as cpBody ptr)
declare sub cpSpaceAddConstraint cdecl alias "cpSpaceAddConstraint" (byval space as cpSpace ptr, byval constraint as cpConstraint ptr)
declare sub cpSpaceRemoveShape cdecl alias "cpSpaceRemoveShape" (byval space as cpSpace ptr, byval shape as cpShape ptr)
declare sub cpSpaceRemoveStaticShape cdecl alias "cpSpaceRemoveStaticShape" (byval space as cpSpace ptr, byval shape as cpShape ptr)
declare sub cpSpaceRemoveBody cdecl alias "cpSpaceRemoveBody" (byval space as cpSpace ptr, byval body as cpBody ptr)
declare sub cpSpaceRemoveConstraint cdecl alias "cpSpaceRemoveConstraint" (byval space as cpSpace ptr, byval constraint as cpConstraint ptr)

type cpSpacePointQueryFunc as sub cdecl(byval as cpShape ptr, byval as any ptr)

declare sub cpSpaceShapePointQuery cdecl alias "cpSpaceShapePointQuery" (byval space as cpSpace ptr, byval point as cpVect, byval func as cpSpacePointQueryFunc, byval data as any ptr)
declare sub cpSpaceStaticShapePointQuery cdecl alias "cpSpaceStaticShapePointQuery" (byval space as cpSpace ptr, byval point as cpVect, byval func as cpSpacePointQueryFunc, byval data as any ptr)

type cpSpaceBodyIterator as sub cdecl(byval as cpBody ptr, byval as any ptr)

declare sub cpSpaceEachBody cdecl alias "cpSpaceEachBody" (byval space as cpSpace ptr, byval func as cpSpaceBodyIterator, byval data as any ptr)
declare sub cpSpaceResizeStaticHash cdecl alias "cpSpaceResizeStaticHash" (byval space as cpSpace ptr, byval dim as cpFloat, byval count as integer)
declare sub cpSpaceResizeActiveHash cdecl alias "cpSpaceResizeActiveHash" (byval space as cpSpace ptr, byval dim as cpFloat, byval count as integer)
declare sub cpSpaceRehashStatic cdecl alias "cpSpaceRehashStatic" (byval space as cpSpace ptr)
declare sub cpSpaceStep cdecl alias "cpSpaceStep" (byval space as cpSpace ptr, byval dt as cpFloat)

#endif
