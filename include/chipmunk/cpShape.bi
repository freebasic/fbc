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
 
#ifndef __cpShape_bi__
#define __cpShape_bi__

declare sub cpResetShapeIdCounter cdecl alias "cpResetShapeIdCounter" ()

enum cpShapeType
	CP_CIRCLE_SHAPE
	CP_SEGMENT_SHAPE
	CP_POLY_SHAPE
	CP_NUM_SHAPES
end enum


type cpShapeClass
	type as cpShapeType
	cacheData as function cdecl(byval as cpShape ptr, byval as cpVect, byval as cpVect) as cpBB
	destroy as sub cdecl(byval as cpShape ptr)
	pointQuery as function cdecl(byval as cpShape ptr, byval as cpVect) as integer
end type


type cpShape
	klass as cpShapeClass ptr
	body as cpBody ptr
	bb as cpBB
	e as cpFloat
	u as cpFloat
	surface_v as cpVect
	data as any ptr
	collision_type as uinteger
	group as uinteger
	layers as uinteger
	id as uinteger
end type


declare function cpShapeInit cdecl alias "cpShapeInit" (byval shape as cpShape ptr, byval klass as cpShapeClass ptr, byval body as cpBody ptr) as cpShape ptr
declare sub cpShapeDestroy cdecl alias "cpShapeDestroy" (byval shape as cpShape ptr)
declare sub cpShapeFree cdecl alias "cpShapeFree" (byval shape as cpShape ptr)
declare function cpShapeCacheBB cdecl alias "cpShapeCacheBB" (byval shape as cpShape ptr) as cpBB
declare function cpShapePointQuery cdecl alias "cpShapePointQuery" (byval shape as cpShape ptr, byval p as cpVect) as integer

type cpCircleShape
	shape as cpShape
	c as cpVect
	r as cpFloat
	tc as cpVect
end type


declare function cpCircleShapeAlloc cdecl alias "cpCircleShapeAlloc" () as cpCircleShape ptr
declare function cpCircleShapeInit cdecl alias "cpCircleShapeInit" (byval circle as cpCircleShape ptr, byval body as cpBody ptr, byval radius as cpFloat, byval offset as cpVect) as cpCircleShape ptr
declare function cpCircleShapeNew cdecl alias "cpCircleShapeNew" (byval body as cpBody ptr, byval radius as cpFloat, byval offset as cpVect) as cpShape ptr

type cpSegmentShape
	shape as cpShape
	a as cpVect
	b as cpVect
	n as cpVect
	r as cpFloat
	ta as cpVect
	tb as cpVect
	tn as cpVect
end type


declare function cpSegmentShapeAlloc cdecl alias "cpSegmentShapeAlloc" () as cpSegmentShape ptr
declare function cpSegmentShapeInit cdecl alias "cpSegmentShapeInit" (byval seg as cpSegmentShape ptr, byval body as cpBody ptr, byval a as cpVect, byval b as cpVect, byval radius as cpFloat) as cpSegmentShape ptr
declare function cpSegmentShapeNew cdecl alias "cpSegmentShapeNew" (byval body as cpBody ptr, byval a as cpVect, byval b as cpVect, byval radius as cpFloat) as cpShape ptr

#endif
