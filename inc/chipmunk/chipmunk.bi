'' FreeBASIC binding for Chipmunk-7.0.3
''
'' based on the C header files:
''   Copyright (c) 2007-2015 Scott Lembcke and Howling Moon Software
''
''   Permission is hereby granted, free of charge, to any person obtaining a copy
''   of this software and associated documentation files (the "Software"), to deal
''   in the Software without restriction, including without limitation the rights
''   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
''   copies of the Software, and to permit persons to whom the Software is
''   furnished to do so, subject to the following conditions:
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
''   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
''   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
''   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
''   SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2021 FreeBASIC development team

#pragma once

#inclib "chipmunk"

#include once "crt/stdlib.bi"
#include once "crt/math.bi"
#include once "crt/stdint.bi"
#include once "crt/limits.bi"

extern "C"

#define CHIPMUNK_H
declare sub cpMessage(byval condition as const zstring ptr, byval file as const zstring ptr, byval line as long, byval isError as long, byval isHardError as long, byval message as const zstring ptr, ...)
#macro cpAssertSoft(__condition__, __VA_ARGS__...)
	if (__condition__) = 0 then
		cpMessage(#__condition__, __FILE__, __LINE__, 1, 0, __VA_ARGS__)
		abort()
	end if
#endmacro
#macro cpAssertWarn(__condition__, __VA_ARGS__...)
	if (__condition__) = 0 then
		cpMessage(#__condition__, __FILE__, __LINE__, 0, 0, __VA_ARGS__)
	end if
#endmacro
#macro cpAssertHard(__condition__, __VA_ARGS__...)
	if (__condition__) = 0 then
		cpMessage(#__condition__, __FILE__, __LINE__, 1, 1, __VA_ARGS__)
		abort()
	end if
#endmacro
#define CHIPMUNK_TYPES_H
const CP_USE_DOUBLES = 1
type cpFloat as double
#define cpfsqrt sqrt
#define cpfsin sin
#define cpfcos cos
#define cpfacos acos
#define cpfatan2 atan2
#define cpfmod fmod
#define cpfexp exp
#define cpfpow pow
#define cpffloor floor
#define cpfceil ceil
#define CPFLOAT_MIN DBL_MIN
const CP_PI = cast(cpFloat, 3.14159265358979323846264338327950288)

private function cpfmax(byval a as cpFloat, byval b as cpFloat) as cpFloat
	return iif(a > b, a, b)
end function

private function cpfmin(byval a as cpFloat, byval b as cpFloat) as cpFloat
	return iif(a < b, a, b)
end function

private function cpfabs(byval f_ as cpFloat) as cpFloat
	return iif(f_ < 0, -f_, f_)
end function

#define cpfclamp(f_, min, max) cast(cpFloat, cpfmin(cpfmax((f_), (min)), (max)))
#define cpfclamp01(f_) cast(cpFloat, cpfmax(0.0f, cpfmin((f_), 1.0f)))

private function cpflerp(byval f1 as cpFloat, byval f2 as cpFloat, byval t as cpFloat) as cpFloat
	return (f1 * (1.0f - t)) + (f2 * t)
end function

private function cpflerpconst(byval f1 as cpFloat, byval f2 as cpFloat, byval d as cpFloat) as cpFloat
	return f1 + cpfclamp(f2 - f1, -d, d)
end function

type cpHashValue as uinteger
type cpCollisionID as ulong
type cpBool as ubyte
const cpTrue = 1
const cpFalse = 0
type cpDataPointer as any ptr
type cpCollisionType as uinteger
type cpGroup as uinteger
type cpBitmask as ulong
type cpTimestamp as ulong

const CP_NO_GROUP = cast(cpGroup, 0)
const CP_ALL_CATEGORIES = not cast(cpBitmask, 0)
const CP_WILDCARD_COLLISION_TYPE = not cast(cpCollisionType, 0)

type cpVect
	x as cpFloat
	y as cpFloat
end type

type cpTransform
	a as cpFloat
	b as cpFloat
	c as cpFloat
	d as cpFloat
	tx as cpFloat
	ty as cpFloat
end type

type cpMat2x2
	a as cpFloat
	b as cpFloat
	c as cpFloat
	d as cpFloat
end type

const CP_BUFFER_BYTES = 32 * 1024
#define cpcalloc calloc
#define cprealloc realloc
#define cpfree free
#define CHIPMUNK_VECT_H
dim shared cpvzero as const cpVect = (0.0f, 0.0f)

private function cpv(byval x as const cpFloat, byval y as const cpFloat) as cpVect
	dim v as cpVect = (x, y)
	return v
end function

private function cpveql(byval v1 as const cpVect, byval v2 as const cpVect) as cpBool
	return -((v1.x = v2.x) andalso (v1.y = v2.y))
end function

private function cpvadd(byval v1 as const cpVect, byval v2 as const cpVect) as cpVect
	return cpv(v1.x + v2.x, v1.y + v2.y)
end function

private function cpvsub(byval v1 as const cpVect, byval v2 as const cpVect) as cpVect
	return cpv(v1.x - v2.x, v1.y - v2.y)
end function

private function cpvneg(byval v as const cpVect) as cpVect
	return cpv(-v.x, -v.y)
end function

private function cpvmult(byval v as const cpVect, byval s as const cpFloat) as cpVect
	return cpv(v.x * s, v.y * s)
end function

private function cpvdot(byval v1 as const cpVect, byval v2 as const cpVect) as cpFloat
	return (v1.x * v2.x) + (v1.y * v2.y)
end function

private function cpvcross(byval v1 as const cpVect, byval v2 as const cpVect) as cpFloat
	return (v1.x * v2.y) - (v1.y * v2.x)
end function

private function cpvperp(byval v as const cpVect) as cpVect
	return cpv(-v.y, v.x)
end function

private function cpvrperp(byval v as const cpVect) as cpVect
	return cpv(v.y, -v.x)
end function

private function cpvproject(byval v1 as const cpVect, byval v2 as const cpVect) as cpVect
	return cpvmult(v2, cpvdot(v1, v2) / cpvdot(v2, v2))
end function

private function cpvforangle(byval a as const cpFloat) as cpVect
	return cpv(cos(a), sin(a))
end function

private function cpvtoangle(byval v as const cpVect) as cpFloat
	return atan2(v.y, v.x)
end function

private function cpvrotate(byval v1 as const cpVect, byval v2 as const cpVect) as cpVect
	return cpv((v1.x * v2.x) - (v1.y * v2.y), (v1.x * v2.y) + (v1.y * v2.x))
end function

private function cpvunrotate(byval v1 as const cpVect, byval v2 as const cpVect) as cpVect
	return cpv((v1.x * v2.x) + (v1.y * v2.y), (v1.y * v2.x) - (v1.x * v2.y))
end function

private function cpvlengthsq(byval v as const cpVect) as cpFloat
	return cpvdot(v, v)
end function

private function cpvlength(byval v as const cpVect) as cpFloat
	return sqrt(cpvdot(v, v))
end function

private function cpvlerp(byval v1 as const cpVect, byval v2 as const cpVect, byval t as const cpFloat) as cpVect
	return cpvadd(cpvmult(v1, 1.0f - t), cpvmult(v2, t))
end function

private function cpvnormalize(byval v as const cpVect) as cpVect
	return cpvmult(v, 1.0f / (cpvlength(v) + DBL_MIN))
end function

private function cpvslerp(byval v1 as const cpVect, byval v2 as const cpVect, byval t as const cpFloat) as cpVect
	dim dot as cpFloat = cpvdot(cpvnormalize(v1), cpvnormalize(v2))
	dim omega as cpFloat = acos(cpfclamp(dot, -1.0f, 1.0f))
	if omega < 1e-3 then
		return cpvlerp(v1, v2, t)
	else
		dim denom as cpFloat = 1.0f / sin(omega)
		return cpvadd(cpvmult(v1, sin((1.0f - t) * omega) * denom), cpvmult(v2, sin(t * omega) * denom))
	end if
end function

private function cpvslerpconst(byval v1 as const cpVect, byval v2 as const cpVect, byval a as const cpFloat) as cpVect
	dim dot as cpFloat = cpvdot(cpvnormalize(v1), cpvnormalize(v2))
	dim omega as cpFloat = acos(cpfclamp(dot, -1.0f, 1.0f))
	return cpvslerp(v1, v2, cpfmin(a, omega) / omega)
end function

private function cpvclamp(byval v as const cpVect, byval len_ as const cpFloat) as cpVect
	return iif(cpvdot(v, v) > (len_ * len_), cpvmult(cpvnormalize(v), len_), v)
end function

private function cpvlerpconst(byval v1 as cpVect, byval v2 as cpVect, byval d as cpFloat) as cpVect
	return cpvadd(v1, cpvclamp(cpvsub(v2, v1), d))
end function

#define cpvdist(v1, v2) cast(cpFloat, cpvlength(cpvsub((v1), (v2))))
#define cpvdistsq(v1, v2) cast(cpFloat, cpvlengthsq(cpvsub((v1), (v2))))

private function cpvnear(byval v1 as const cpVect, byval v2 as const cpVect, byval dist as const cpFloat) as cpBool
	return -(cpvdistsq(v1, v2) < (dist * dist))
end function

private function cpMat2x2New(byval a as cpFloat, byval b as cpFloat, byval c as cpFloat, byval d as cpFloat) as cpMat2x2
	dim m as cpMat2x2 = (a, b, c, d)
	return m
end function

private function cpMat2x2Transform(byval m as cpMat2x2, byval v as cpVect) as cpVect
	return cpv((v.x * m.a) + (v.y * m.b), (v.x * m.c) + (v.y * m.d))
end function

#define CHIPMUNK_BB_H

type cpBB
	l as cpFloat
	b as cpFloat
	r as cpFloat
	t as cpFloat
end type

#define cpBBNew(l, b, r, t) type<cpBB>(l, b, r, t)
#define cpBBNewForExtents(c, hw, hh) cast(cpBB, cpBBNew((c).x - (hw), (c).y - (hh), (c).x + (hw), (c).y + (hh)))
#define cpBBNewForCircle(p, r) cast(cpBB, cpBBNewForExtents((p), (r), (r)))
#define cpBBIntersects(a, b) cast(cpBool, -(((((a).l <= (b).r) andalso ((b).l <= (a).r)) andalso ((a).(b) <= (b).t)) andalso ((b).(b) <= (a).t)))
#define cpBBContainsBB(bb, other) cast(cpBool, -(((((bb).l <= (other).l) andalso ((bb).r >= (other).r)) andalso ((bb).b <= (other).b)) andalso ((bb).t >= (other).t)))
#define cpBBContainsVect(bb, v) cast(cpBool, -(((((bb).l <= (v).x) andalso ((bb).r >= (v).x)) andalso ((bb).b <= (v).y)) andalso ((bb).t >= (v).y)))
#define cpBBMerge(a, b) cast(cpBB, cpBBNew(cpfmin((a).l, (b).l), cpfmin((a).(b), (b).(b)), cpfmax((a).r, (b).r), cpfmax((a).t, (b).t)))
#define cpBBExpand(bb, v) cast(cpBB, cpBBNew(cpfmin((bb).l, (v).x), cpfmin((bb).b, (v).y), cpfmax((bb).r, (v).x), cpfmax((bb).t, (v).y)))
#define cpBBCenter(bb) cast(cpVect, cpvlerp(cpv((bb).l, (bb).b), cpv((bb).r, (bb).t), 0.5f))
#define cpBBArea(bb) cast(cpFloat, ((bb).r - (bb).l) * ((bb).t - (bb).b))
#define cpBBMergedArea(a, b) cast(cpFloat, (cpfmax((a).r, (b).r) - cpfmin((a).l, (b).l)) * (cpfmax((a).t, (b).t) - cpfmin((a).(b), (b).(b))))

private function cpBBSegmentQuery(byval bb as cpBB, byval a as cpVect, byval b as cpVect) as cpFloat
	dim delta as cpVect = cpvsub(b, a)
	dim tmin as cpFloat = -INFINITY
	dim tmax as cpFloat = INFINITY
	if delta.x = 0.0f then
		if (a.x < bb.l) orelse (bb.r < a.x) then
			return INFINITY
		end if
	else
		dim t1 as cpFloat = (bb.l - a.x) / delta.x
		dim t2 as cpFloat = (bb.r - a.x) / delta.x
		tmin = cpfmax(tmin, cpfmin(t1, t2))
		tmax = cpfmin(tmax, cpfmax(t1, t2))
	end if
	if delta.y = 0.0f then
		if (a.y < bb.b) orelse (bb.t < a.y) then
			return INFINITY
		end if
	else
		dim t1 as cpFloat = (bb.b - a.y) / delta.y
		dim t2 as cpFloat = (bb.t - a.y) / delta.y
		tmin = cpfmax(tmin, cpfmin(t1, t2))
		tmax = cpfmin(tmax, cpfmax(t1, t2))
	end if
	if ((tmin <= tmax) andalso (0.0f <= tmax)) andalso (tmin <= 1.0f) then
		return cpfmax(tmin, 0.0f)
	else
		return INFINITY
	end if
end function

#define cpBBIntersectsSegment(bb, a, b) cast(cpBool, -(cpBBSegmentQuery((bb), (a), (b)) <> INFINITY))
#define cpBBClampVect(bb, v) cast(cpVect, cpv(cpfclamp((v).x, (bb).l, (bb).r), cpfclamp((v).y, (bb).b, (bb).t)))

private function cpBBWrapVect(byval bb as const cpBB, byval v as const cpVect) as cpVect
	dim dx as cpFloat = cpfabs(bb.r - bb.l)
	dim modx as cpFloat = fmod(v.x - bb.l, dx)
	dim x as cpFloat = iif(modx > 0.0f, modx, modx + dx)
	dim dy as cpFloat = cpfabs(bb.t - bb.b)
	dim mody as cpFloat = fmod(v.y - bb.b, dy)
	dim y as cpFloat = iif(mody > 0.0f, mody, mody + dy)
	return cpv(x + bb.l, y + bb.b)
end function

#define cpBBOffset(bb, v) cast(cpBB, cpBBNew((bb).l + (v).x, (bb).b + (v).y, (bb).r + (v).x, (bb).t + (v).y))
#define CHIPMUNK_TRANSFORM_H
dim shared cpTransformIdentity as const cpTransform = (1.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f)
#define cpTransformNew(a, b, c, d, tx, ty) type<cpTransform>(a, b, c, d, tx, ty)
#define cpTransformNewTranspose(a, c, tx, b, d, ty) type<cpTransform>(a, b, c, d, tx, ty)

private function cpTransformInverse(byval t as cpTransform) as cpTransform
	dim inv_det as cpFloat = 1.0 / ((t.a * t.d) - (t.c * t.b))
	return cpTransformNewTranspose(t.d * inv_det, (-t.c) * inv_det, ((t.c * t.ty) - (t.tx * t.d)) * inv_det, (-t.b) * inv_det, t.a * inv_det, ((t.tx * t.b) - (t.a * t.ty)) * inv_det)
end function

private function cpTransformMult(byval t1 as cpTransform, byval t2 as cpTransform) as cpTransform
	return cpTransformNewTranspose((t1.a * t2.a) + (t1.c * t2.b), (t1.a * t2.c) + (t1.c * t2.d), ((t1.a * t2.tx) + (t1.c * t2.ty)) + t1.tx, (t1.b * t2.a) + (t1.d * t2.b), (t1.b * t2.c) + (t1.d * t2.d), ((t1.b * t2.tx) + (t1.d * t2.ty)) + t1.ty)
end function

private function cpTransformPoint(byval t as cpTransform, byval p as cpVect) as cpVect
	return cpv(((t.a * p.x) + (t.c * p.y)) + t.tx, ((t.b * p.x) + (t.d * p.y)) + t.ty)
end function

private function cpTransformVect(byval t as cpTransform, byval v as cpVect) as cpVect
	return cpv((t.a * v.x) + (t.c * v.y), (t.b * v.x) + (t.d * v.y))
end function

private function cpTransformbBB(byval t as cpTransform, byval bb as cpBB) as cpBB
	dim center as cpVect = cpBBCenter(bb)
	dim hw as cpFloat = (bb.r - bb.l) * 0.5
	dim hh as cpFloat = (bb.t - bb.b) * 0.5
	dim a as cpFloat = t.a * hw
	dim b as cpFloat = t.c * hh
	dim d as cpFloat = t.b * hw
	dim e as cpFloat = t.d * hh
	dim hw_max as cpFloat = cpfmax(cpfabs(a + b), cpfabs(a - b))
	dim hh_max as cpFloat = cpfmax(cpfabs(d + e), cpfabs(d - e))
	return cpBBNewForExtents(cpTransformPoint(t, center), hw_max, hh_max)
end function

private function cpTransformTranslate(byval translate as cpVect) as cpTransform
	return cpTransformNewTranspose(1.0, 0.0, translate.x, 0.0, 1.0, translate.y)
end function

#define cpTransformScale(scaleX, scaleY) cast(cpTransform, cpTransformNewTranspose((scaleX), 0.0, 0.0, 0.0, (scaleY), 0.0))

private function cpTransformRotate(byval radians as cpFloat) as cpTransform
	dim rot as cpVect = cpvforangle(radians)
	return cpTransformNewTranspose(rot.x, -rot.y, 0.0, rot.y, rot.x, 0.0)
end function

private function cpTransformRigid(byval translate as cpVect, byval radians as cpFloat) as cpTransform
	dim rot as cpVect = cpvforangle(radians)
	return cpTransformNewTranspose(rot.x, -rot.y, translate.x, rot.y, rot.x, translate.y)
end function

private function cpTransformRigidInverse(byval t as cpTransform) as cpTransform
	return cpTransformNewTranspose(t.d, -t.c, (t.c * t.ty) - (t.tx * t.d), -t.b, t.a, (t.tx * t.b) - (t.a * t.ty))
end function

private function cpTransformWrap(byval outer as cpTransform, byval inner as cpTransform) as cpTransform
	return cpTransformMult(cpTransformInverse(outer), cpTransformMult(inner, outer))
end function

private function cpTransformWrapInverse(byval outer as cpTransform, byval inner as cpTransform) as cpTransform
	return cpTransformMult(outer, cpTransformMult(inner, cpTransformInverse(outer)))
end function

private function cpTransformOrtho(byval bb as cpBB) as cpTransform
	return cpTransformNewTranspose(2.0 / (bb.r - bb.l), 0.0, (-(bb.r + bb.l)) / (bb.r - bb.l), 0.0, 2.0 / (bb.t - bb.b), (-(bb.t + bb.b)) / (bb.t - bb.b))
end function

private function cpTransformBoneScale(byval v0 as cpVect, byval v1 as cpVect) as cpTransform
	dim d as cpVect = cpvsub(v1, v0)
	return cpTransformNewTranspose(d.x, -d.y, v0.x, d.y, d.x, v0.y)
end function

private function cpTransformAxialScale(byval axis as cpVect, byval pivot as cpVect, byval scale as cpFloat) as cpTransform
	dim A as cpFloat = (axis.x * axis.y) * (scale - 1.0)
	dim B as cpFloat = cpvdot(axis, pivot) * (1.0 - scale)
	return cpTransformNewTranspose(((scale * axis.x) * axis.x) + (axis.y * axis.y), A, axis.x * B, A, (axis.x * axis.x) + ((scale * axis.y) * axis.y), axis.y * B)
end function

type cpSpatialIndexBBFunc as function(byval obj as any ptr) as cpBB
type cpSpatialIndexIteratorFunc as sub(byval obj as any ptr, byval data_ as any ptr)
type cpSpatialIndexQueryFunc as function(byval obj1 as any ptr, byval obj2 as any ptr, byval id as cpCollisionID, byval data_ as any ptr) as cpCollisionID
type cpSpatialIndexSegmentQueryFunc as function(byval obj1 as any ptr, byval obj2 as any ptr, byval data_ as any ptr) as cpFloat
type cpSpatialIndexClass as cpSpatialIndexClass_

type cpSpatialIndex
	klass as cpSpatialIndexClass ptr
	bbfunc as cpSpatialIndexBBFunc
	staticIndex as cpSpatialIndex ptr
	dynamicIndex as cpSpatialIndex ptr
end type

type cpSpaceHash as cpSpaceHash_
declare function cpSpaceHashAlloc() as cpSpaceHash ptr
declare function cpSpaceHashInit(byval hash as cpSpaceHash ptr, byval celldim as cpFloat, byval numcells as long, byval bbfunc as cpSpatialIndexBBFunc, byval staticIndex as cpSpatialIndex ptr) as cpSpatialIndex ptr
declare function cpSpaceHashNew(byval celldim as cpFloat, byval cells as long, byval bbfunc as cpSpatialIndexBBFunc, byval staticIndex as cpSpatialIndex ptr) as cpSpatialIndex ptr
declare sub cpSpaceHashResize(byval hash as cpSpaceHash ptr, byval celldim as cpFloat, byval numcells as long)
type cpBBTree as cpBBTree_
declare function cpBBTreeAlloc() as cpBBTree ptr
declare function cpBBTreeInit(byval tree as cpBBTree ptr, byval bbfunc as cpSpatialIndexBBFunc, byval staticIndex as cpSpatialIndex ptr) as cpSpatialIndex ptr
declare function cpBBTreeNew(byval bbfunc as cpSpatialIndexBBFunc, byval staticIndex as cpSpatialIndex ptr) as cpSpatialIndex ptr
declare sub cpBBTreeOptimize(byval index as cpSpatialIndex ptr)
type cpBBTreeVelocityFunc as function(byval obj as any ptr) as cpVect
declare sub cpBBTreeSetVelocityFunc(byval index as cpSpatialIndex ptr, byval func as cpBBTreeVelocityFunc)
type cpSweep1D as cpSweep1D_
declare function cpSweep1DAlloc() as cpSweep1D ptr
declare function cpSweep1DInit(byval sweep as cpSweep1D ptr, byval bbfunc as cpSpatialIndexBBFunc, byval staticIndex as cpSpatialIndex ptr) as cpSpatialIndex ptr
declare function cpSweep1DNew(byval bbfunc as cpSpatialIndexBBFunc, byval staticIndex as cpSpatialIndex ptr) as cpSpatialIndex ptr

type cpSpatialIndexDestroyImpl as sub(byval index as cpSpatialIndex ptr)
type cpSpatialIndexCountImpl as function(byval index as cpSpatialIndex ptr) as long
type cpSpatialIndexEachImpl as sub(byval index as cpSpatialIndex ptr, byval func as cpSpatialIndexIteratorFunc, byval data_ as any ptr)
type cpSpatialIndexContainsImpl as function(byval index as cpSpatialIndex ptr, byval obj as any ptr, byval hashid as cpHashValue) as cpBool
type cpSpatialIndexInsertImpl as sub(byval index as cpSpatialIndex ptr, byval obj as any ptr, byval hashid as cpHashValue)
type cpSpatialIndexRemoveImpl as sub(byval index as cpSpatialIndex ptr, byval obj as any ptr, byval hashid as cpHashValue)
type cpSpatialIndexReindexImpl as sub(byval index as cpSpatialIndex ptr)
type cpSpatialIndexReindexObjectImpl as sub(byval index as cpSpatialIndex ptr, byval obj as any ptr, byval hashid as cpHashValue)
type cpSpatialIndexReindexQueryImpl as sub(byval index as cpSpatialIndex ptr, byval func as cpSpatialIndexQueryFunc, byval data_ as any ptr)
type cpSpatialIndexQueryImpl as sub(byval index as cpSpatialIndex ptr, byval obj as any ptr, byval bb as cpBB, byval func as cpSpatialIndexQueryFunc, byval data_ as any ptr)
type cpSpatialIndexSegmentQueryImpl as sub(byval index as cpSpatialIndex ptr, byval obj as any ptr, byval a as cpVect, byval b as cpVect, byval t_exit as cpFloat, byval func as cpSpatialIndexSegmentQueryFunc, byval data_ as any ptr)

type cpSpatialIndexClass_
	destroy as cpSpatialIndexDestroyImpl
	count as cpSpatialIndexCountImpl
	each as cpSpatialIndexEachImpl
	contains as cpSpatialIndexContainsImpl
	insert as cpSpatialIndexInsertImpl
	remove as cpSpatialIndexRemoveImpl
	reindex as cpSpatialIndexReindexImpl
	reindexObject as cpSpatialIndexReindexObjectImpl
	reindexQuery as cpSpatialIndexReindexQueryImpl
	query as cpSpatialIndexQueryImpl
	segmentQuery as cpSpatialIndexSegmentQueryImpl
end type

declare sub cpSpatialIndexFree(byval index as cpSpatialIndex ptr)
declare sub cpSpatialIndexCollideStatic(byval dynamicIndex as cpSpatialIndex ptr, byval staticIndex as cpSpatialIndex ptr, byval func as cpSpatialIndexQueryFunc, byval data_ as any ptr)

private sub cpSpatialIndexDestroy(byval index as cpSpatialIndex ptr)
	if index->klass then
		index->klass->destroy(index)
	end if
end sub

private function cpSpatialIndexCount(byval index as cpSpatialIndex ptr) as long
	return index->klass->count(index)
end function

private sub cpSpatialIndexEach(byval index as cpSpatialIndex ptr, byval func as cpSpatialIndexIteratorFunc, byval data_ as any ptr)
	index->klass->each(index, func, data_)
end sub

private function cpSpatialIndexContains(byval index as cpSpatialIndex ptr, byval obj as any ptr, byval hashid as cpHashValue) as cpBool
	return index->klass->contains(index, obj, hashid)
end function

private sub cpSpatialIndexInsert(byval index as cpSpatialIndex ptr, byval obj as any ptr, byval hashid as cpHashValue)
	index->klass->insert(index, obj, hashid)
end sub

private sub cpSpatialIndexRemove(byval index as cpSpatialIndex ptr, byval obj as any ptr, byval hashid as cpHashValue)
	index->klass->remove(index, obj, hashid)
end sub

private sub cpSpatialIndexReindex(byval index as cpSpatialIndex ptr)
	index->klass->reindex(index)
end sub

private sub cpSpatialIndexReindexObject(byval index as cpSpatialIndex ptr, byval obj as any ptr, byval hashid as cpHashValue)
	index->klass->reindexObject(index, obj, hashid)
end sub

private sub cpSpatialIndexQuery(byval index as cpSpatialIndex ptr, byval obj as any ptr, byval bb as cpBB, byval func as cpSpatialIndexQueryFunc, byval data_ as any ptr)
	index->klass->query(index, obj, bb, func, data_)
end sub

private sub cpSpatialIndexSegmentQuery(byval index as cpSpatialIndex ptr, byval obj as any ptr, byval a as cpVect, byval b as cpVect, byval t_exit as cpFloat, byval func as cpSpatialIndexSegmentQueryFunc, byval data_ as any ptr)
	index->klass->segmentQuery(index, obj, a, b, t_exit, func, data_)
end sub

private sub cpSpatialIndexReindexQuery(byval index as cpSpatialIndex ptr, byval func as cpSpatialIndexQueryFunc, byval data_ as any ptr)
	index->klass->reindexQuery(index, func, data_)
end sub

const CP_MAX_CONTACTS_PER_ARBITER = 2
type cpArbiter as cpArbiter_
declare function cpArbiterGetRestitution(byval arb as const cpArbiter ptr) as cpFloat
declare sub cpArbiterSetRestitution(byval arb as cpArbiter ptr, byval restitution as cpFloat)
declare function cpArbiterGetFriction(byval arb as const cpArbiter ptr) as cpFloat
declare sub cpArbiterSetFriction(byval arb as cpArbiter ptr, byval friction as cpFloat)
declare function cpArbiterGetSurfaceVelocity(byval arb as cpArbiter ptr) as cpVect
declare sub cpArbiterSetSurfaceVelocity(byval arb as cpArbiter ptr, byval vr as cpVect)
declare function cpArbiterGetUserData(byval arb as const cpArbiter ptr) as cpDataPointer
declare sub cpArbiterSetUserData(byval arb as cpArbiter ptr, byval userData as cpDataPointer)
declare function cpArbiterTotalImpulse(byval arb as const cpArbiter ptr) as cpVect
declare function cpArbiterTotalKE(byval arb as const cpArbiter ptr) as cpFloat
declare function cpArbiterIgnore(byval arb as cpArbiter ptr) as cpBool
type cpShape as cpShape_
declare sub cpArbiterGetShapes(byval arb as const cpArbiter ptr, byval a as cpShape ptr ptr, byval b as cpShape ptr ptr)
#define CP_ARBITER_GET_SHAPES(__arb__, __a__, __b__) dim as cpShape ptr __a__, __b__ : cpArbiterGetShapes(__arb__, @__a__, @__b__)
type cpBody as cpBody_
declare sub cpArbiterGetBodies(byval arb as const cpArbiter ptr, byval a as cpBody ptr ptr, byval b as cpBody ptr ptr)
#define CP_ARBITER_GET_BODIES(__arb__, __a__, __b__) dim as cpBody ptr __a__, __b__ : cpArbiterGetBodies(__arb__, @__a__, @__b__)

type cpContactPointSet_points
	pointA as cpVect
	pointB as cpVect
	distance as cpFloat
end type

type cpContactPointSet
	count as long
	normal as cpVect
	points(0 to 1) as cpContactPointSet_points
end type

declare function cpArbiterGetContactPointSet(byval arb as const cpArbiter ptr) as cpContactPointSet
declare sub cpArbiterSetContactPointSet(byval arb as cpArbiter ptr, byval set as cpContactPointSet ptr)
declare function cpArbiterIsFirstContact(byval arb as const cpArbiter ptr) as cpBool
declare function cpArbiterIsRemoval(byval arb as const cpArbiter ptr) as cpBool
declare function cpArbiterGetCount(byval arb as const cpArbiter ptr) as long
declare function cpArbiterGetNormal(byval arb as const cpArbiter ptr) as cpVect
declare function cpArbiterGetPointA(byval arb as const cpArbiter ptr, byval i as long) as cpVect
declare function cpArbiterGetPointB(byval arb as const cpArbiter ptr, byval i as long) as cpVect
declare function cpArbiterGetDepth(byval arb as const cpArbiter ptr, byval i as long) as cpFloat
type cpSpace as cpSpace_
declare function cpArbiterCallWildcardBeginA(byval arb as cpArbiter ptr, byval space as cpSpace ptr) as cpBool
declare function cpArbiterCallWildcardBeginB(byval arb as cpArbiter ptr, byval space as cpSpace ptr) as cpBool
declare function cpArbiterCallWildcardPreSolveA(byval arb as cpArbiter ptr, byval space as cpSpace ptr) as cpBool
declare function cpArbiterCallWildcardPreSolveB(byval arb as cpArbiter ptr, byval space as cpSpace ptr) as cpBool
declare sub cpArbiterCallWildcardPostSolveA(byval arb as cpArbiter ptr, byval space as cpSpace ptr)
declare sub cpArbiterCallWildcardPostSolveB(byval arb as cpArbiter ptr, byval space as cpSpace ptr)
declare sub cpArbiterCallWildcardSeparateA(byval arb as cpArbiter ptr, byval space as cpSpace ptr)
declare sub cpArbiterCallWildcardSeparateB(byval arb as cpArbiter ptr, byval space as cpSpace ptr)

type cpBodyType as long
enum
	CP_BODY_TYPE_DYNAMIC
	CP_BODY_TYPE_KINEMATIC
	CP_BODY_TYPE_STATIC
end enum

type cpBodyVelocityFunc as sub(byval body as cpBody ptr, byval gravity as cpVect, byval damping as cpFloat, byval dt as cpFloat)
type cpBodyPositionFunc as sub(byval body as cpBody ptr, byval dt as cpFloat)
declare function cpBodyAlloc() as cpBody ptr
declare function cpBodyInit(byval body as cpBody ptr, byval mass as cpFloat, byval moment as cpFloat) as cpBody ptr
declare function cpBodyNew(byval mass as cpFloat, byval moment as cpFloat) as cpBody ptr
declare function cpBodyNewKinematic() as cpBody ptr
declare function cpBodyNewStatic() as cpBody ptr
declare sub cpBodyDestroy(byval body as cpBody ptr)
declare sub cpBodyFree(byval body as cpBody ptr)
declare sub cpBodyActivate(byval body as cpBody ptr)
declare sub cpBodyActivateStatic(byval body as cpBody ptr, byval filter as cpShape ptr)
declare sub cpBodySleep(byval body as cpBody ptr)
declare sub cpBodySleepWithGroup(byval body as cpBody ptr, byval group as cpBody ptr)
declare function cpBodyIsSleeping(byval body as const cpBody ptr) as cpBool
declare function cpBodyGetType(byval body as cpBody ptr) as cpBodyType
declare sub cpBodySetType(byval body as cpBody ptr, byval type as cpBodyType)
declare function cpBodyGetSpace(byval body as const cpBody ptr) as cpSpace ptr
declare function cpBodyGetMass(byval body as const cpBody ptr) as cpFloat
declare sub cpBodySetMass(byval body as cpBody ptr, byval m as cpFloat)
declare function cpBodyGetMoment(byval body as const cpBody ptr) as cpFloat
declare sub cpBodySetMoment(byval body as cpBody ptr, byval i as cpFloat)
declare function cpBodyGetPosition(byval body as const cpBody ptr) as cpVect
declare sub cpBodySetPosition(byval body as cpBody ptr, byval pos as cpVect)
declare function cpBodyGetCenterOfGravity(byval body as const cpBody ptr) as cpVect
declare sub cpBodySetCenterOfGravity(byval body as cpBody ptr, byval cog as cpVect)
declare function cpBodyGetVelocity(byval body as const cpBody ptr) as cpVect
declare sub cpBodySetVelocity(byval body as cpBody ptr, byval velocity as cpVect)
declare function cpBodyGetForce(byval body as const cpBody ptr) as cpVect
declare sub cpBodySetForce(byval body as cpBody ptr, byval force as cpVect)
declare function cpBodyGetAngle(byval body as const cpBody ptr) as cpFloat
declare sub cpBodySetAngle(byval body as cpBody ptr, byval a as cpFloat)
declare function cpBodyGetAngularVelocity(byval body as const cpBody ptr) as cpFloat
declare sub cpBodySetAngularVelocity(byval body as cpBody ptr, byval angularVelocity as cpFloat)
declare function cpBodyGetTorque(byval body as const cpBody ptr) as cpFloat
declare sub cpBodySetTorque(byval body as cpBody ptr, byval torque as cpFloat)
declare function cpBodyGetRotation(byval body as const cpBody ptr) as cpVect
declare function cpBodyGetUserData(byval body as const cpBody ptr) as cpDataPointer
declare sub cpBodySetUserData(byval body as cpBody ptr, byval userData as cpDataPointer)
declare sub cpBodySetVelocityUpdateFunc(byval body as cpBody ptr, byval velocityFunc as cpBodyVelocityFunc)
declare sub cpBodySetPositionUpdateFunc(byval body as cpBody ptr, byval positionFunc as cpBodyPositionFunc)
declare sub cpBodyUpdateVelocity(byval body as cpBody ptr, byval gravity as cpVect, byval damping as cpFloat, byval dt as cpFloat)
declare sub cpBodyUpdatePosition(byval body as cpBody ptr, byval dt as cpFloat)
declare function cpBodyLocalToWorld(byval body as const cpBody ptr, byval point as const cpVect) as cpVect
declare function cpBodyWorldToLocal(byval body as const cpBody ptr, byval point as const cpVect) as cpVect
declare sub cpBodyApplyForceAtWorldPoint(byval body as cpBody ptr, byval force as cpVect, byval point as cpVect)
declare sub cpBodyApplyForceAtLocalPoint(byval body as cpBody ptr, byval force as cpVect, byval point as cpVect)
declare sub cpBodyApplyImpulseAtWorldPoint(byval body as cpBody ptr, byval impulse as cpVect, byval point as cpVect)
declare sub cpBodyApplyImpulseAtLocalPoint(byval body as cpBody ptr, byval impulse as cpVect, byval point as cpVect)
declare function cpBodyGetVelocityAtWorldPoint(byval body as const cpBody ptr, byval point as cpVect) as cpVect
declare function cpBodyGetVelocityAtLocalPoint(byval body as const cpBody ptr, byval point as cpVect) as cpVect
declare function cpBodyKineticEnergy(byval body as const cpBody ptr) as cpFloat
type cpBodyShapeIteratorFunc as sub(byval body as cpBody ptr, byval shape as cpShape ptr, byval data_ as any ptr)
declare sub cpBodyEachShape(byval body as cpBody ptr, byval func as cpBodyShapeIteratorFunc, byval data_ as any ptr)
type cpConstraint as cpConstraint_
type cpBodyConstraintIteratorFunc as sub(byval body as cpBody ptr, byval constraint as cpConstraint ptr, byval data_ as any ptr)
declare sub cpBodyEachConstraint(byval body as cpBody ptr, byval func as cpBodyConstraintIteratorFunc, byval data_ as any ptr)
type cpBodyArbiterIteratorFunc as sub(byval body as cpBody ptr, byval arbiter as cpArbiter ptr, byval data_ as any ptr)
declare sub cpBodyEachArbiter(byval body as cpBody ptr, byval func as cpBodyArbiterIteratorFunc, byval data_ as any ptr)

type cpPointQueryInfo
	shape as const cpShape ptr
	point as cpVect
	distance as cpFloat
	gradient as cpVect
end type

type cpSegmentQueryInfo
	shape as const cpShape ptr
	point as cpVect
	normal as cpVect
	alpha as cpFloat
end type

type cpShapeFilter
	group as cpGroup
	categories as cpBitmask
	mask as cpBitmask
end type

dim shared CP_SHAPE_FILTER_ALL as const cpShapeFilter = (cast(cpGroup, 0), not cast(cpBitmask, 0), not cast(cpBitmask, 0))
dim shared CP_SHAPE_FILTER_NONE as const cpShapeFilter = (cast(cpGroup, 0), not (not cast(cpBitmask, 0)), not (not cast(cpBitmask, 0)))

private function cpShapeFilterNew(byval group as cpGroup, byval categories as cpBitmask, byval mask as cpBitmask) as cpShapeFilter
	dim filter as cpShapeFilter = (group, categories, mask)
	return filter
end function

declare sub cpShapeDestroy(byval shape as cpShape ptr)
declare sub cpShapeFree(byval shape as cpShape ptr)
declare function cpShapeCacheBB(byval shape as cpShape ptr) as cpBB
declare function cpShapeUpdate(byval shape as cpShape ptr, byval transform as cpTransform) as cpBB
declare function cpShapePointQuery(byval shape as const cpShape ptr, byval p as cpVect, byval out as cpPointQueryInfo ptr) as cpFloat
declare function cpShapeSegmentQuery(byval shape as const cpShape ptr, byval a as cpVect, byval b as cpVect, byval radius as cpFloat, byval info as cpSegmentQueryInfo ptr) as cpBool
declare function cpShapesCollide(byval a as const cpShape ptr, byval b as const cpShape ptr) as cpContactPointSet
declare function cpShapeGetSpace(byval shape as const cpShape ptr) as cpSpace ptr
declare function cpShapeGetBody(byval shape as const cpShape ptr) as cpBody ptr
declare sub cpShapeSetBody(byval shape as cpShape ptr, byval body as cpBody ptr)
declare function cpShapeGetMass(byval shape as cpShape ptr) as cpFloat
declare sub cpShapeSetMass(byval shape as cpShape ptr, byval mass as cpFloat)
declare function cpShapeGetDensity(byval shape as cpShape ptr) as cpFloat
declare sub cpShapeSetDensity(byval shape as cpShape ptr, byval density as cpFloat)
declare function cpShapeGetMoment(byval shape as cpShape ptr) as cpFloat
declare function cpShapeGetArea(byval shape as cpShape ptr) as cpFloat
declare function cpShapeGetCenterOfGravity(byval shape as cpShape ptr) as cpVect
declare function cpShapeGetBB(byval shape as const cpShape ptr) as cpBB
declare function cpShapeGetSensor(byval shape as const cpShape ptr) as cpBool
declare sub cpShapeSetSensor(byval shape as cpShape ptr, byval sensor as cpBool)
declare function cpShapeGetElasticity(byval shape as const cpShape ptr) as cpFloat
declare sub cpShapeSetElasticity(byval shape as cpShape ptr, byval elasticity as cpFloat)
declare function cpShapeGetFriction(byval shape as const cpShape ptr) as cpFloat
declare sub cpShapeSetFriction(byval shape as cpShape ptr, byval friction as cpFloat)
declare function cpShapeGetSurfaceVelocity(byval shape as const cpShape ptr) as cpVect
declare sub cpShapeSetSurfaceVelocity(byval shape as cpShape ptr, byval surfaceVelocity as cpVect)
declare function cpShapeGetUserData(byval shape as const cpShape ptr) as cpDataPointer
declare sub cpShapeSetUserData(byval shape as cpShape ptr, byval userData as cpDataPointer)
declare function cpShapeGetCollisionType(byval shape as const cpShape ptr) as cpCollisionType
declare sub cpShapeSetCollisionType(byval shape as cpShape ptr, byval collisionType as cpCollisionType)
declare function cpShapeGetFilter(byval shape as const cpShape ptr) as cpShapeFilter
declare sub cpShapeSetFilter(byval shape as cpShape ptr, byval filter as cpShapeFilter)
type cpCircleShape as cpCircleShape_
declare function cpCircleShapeAlloc() as cpCircleShape ptr
declare function cpCircleShapeInit(byval circle as cpCircleShape ptr, byval body as cpBody ptr, byval radius as cpFloat, byval offset as cpVect) as cpCircleShape ptr
declare function cpCircleShapeNew(byval body as cpBody ptr, byval radius as cpFloat, byval offset as cpVect) as cpShape ptr
declare function cpCircleShapeGetOffset(byval shape as const cpShape ptr) as cpVect
declare function cpCircleShapeGetRadius(byval shape as const cpShape ptr) as cpFloat
type cpSegmentShape as cpSegmentShape_
declare function cpSegmentShapeAlloc() as cpSegmentShape ptr
declare function cpSegmentShapeInit(byval seg as cpSegmentShape ptr, byval body as cpBody ptr, byval a as cpVect, byval b as cpVect, byval radius as cpFloat) as cpSegmentShape ptr
declare function cpSegmentShapeNew(byval body as cpBody ptr, byval a as cpVect, byval b as cpVect, byval radius as cpFloat) as cpShape ptr
declare sub cpSegmentShapeSetNeighbors(byval shape as cpShape ptr, byval prev as cpVect, byval next as cpVect)
declare function cpSegmentShapeGetA(byval shape as const cpShape ptr) as cpVect
declare function cpSegmentShapeGetB(byval shape as const cpShape ptr) as cpVect
declare function cpSegmentShapeGetNormal(byval shape as const cpShape ptr) as cpVect
declare function cpSegmentShapeGetRadius(byval shape as const cpShape ptr) as cpFloat
type cpPolyShape as cpPolyShape_
declare function cpPolyShapeAlloc() as cpPolyShape ptr
declare function cpPolyShapeInit(byval poly as cpPolyShape ptr, byval body as cpBody ptr, byval count as long, byval verts as const cpVect ptr, byval transform as cpTransform, byval radius as cpFloat) as cpPolyShape ptr
declare function cpPolyShapeInitRaw(byval poly as cpPolyShape ptr, byval body as cpBody ptr, byval count as long, byval verts as const cpVect ptr, byval radius as cpFloat) as cpPolyShape ptr
declare function cpPolyShapeNew(byval body as cpBody ptr, byval count as long, byval verts as const cpVect ptr, byval transform as cpTransform, byval radius as cpFloat) as cpShape ptr
declare function cpPolyShapeNewRaw(byval body as cpBody ptr, byval count as long, byval verts as const cpVect ptr, byval radius as cpFloat) as cpShape ptr
declare function cpBoxShapeInit(byval poly as cpPolyShape ptr, byval body as cpBody ptr, byval width as cpFloat, byval height as cpFloat, byval radius as cpFloat) as cpPolyShape ptr
declare function cpBoxShapeInit2(byval poly as cpPolyShape ptr, byval body as cpBody ptr, byval box as cpBB, byval radius as cpFloat) as cpPolyShape ptr
declare function cpBoxShapeNew(byval body as cpBody ptr, byval width as cpFloat, byval height as cpFloat, byval radius as cpFloat) as cpShape ptr
declare function cpBoxShapeNew2(byval body as cpBody ptr, byval box as cpBB, byval radius as cpFloat) as cpShape ptr
declare function cpPolyShapeGetCount(byval shape as const cpShape ptr) as long
declare function cpPolyShapeGetVert(byval shape as const cpShape ptr, byval index as long) as cpVect
declare function cpPolyShapeGetRadius(byval shape as const cpShape ptr) as cpFloat
type cpConstraintPreSolveFunc as sub(byval constraint as cpConstraint ptr, byval space as cpSpace ptr)
type cpConstraintPostSolveFunc as sub(byval constraint as cpConstraint ptr, byval space as cpSpace ptr)
declare sub cpConstraintDestroy(byval constraint as cpConstraint ptr)
declare sub cpConstraintFree(byval constraint as cpConstraint ptr)
declare function cpConstraintGetSpace(byval constraint as const cpConstraint ptr) as cpSpace ptr
declare function cpConstraintGetBodyA(byval constraint as const cpConstraint ptr) as cpBody ptr
declare function cpConstraintGetBodyB(byval constraint as const cpConstraint ptr) as cpBody ptr
declare function cpConstraintGetMaxForce(byval constraint as const cpConstraint ptr) as cpFloat
declare sub cpConstraintSetMaxForce(byval constraint as cpConstraint ptr, byval maxForce as cpFloat)
declare function cpConstraintGetErrorBias(byval constraint as const cpConstraint ptr) as cpFloat
declare sub cpConstraintSetErrorBias(byval constraint as cpConstraint ptr, byval errorBias as cpFloat)
declare function cpConstraintGetMaxBias(byval constraint as const cpConstraint ptr) as cpFloat
declare sub cpConstraintSetMaxBias(byval constraint as cpConstraint ptr, byval maxBias as cpFloat)
declare function cpConstraintGetCollideBodies(byval constraint as const cpConstraint ptr) as cpBool
declare sub cpConstraintSetCollideBodies(byval constraint as cpConstraint ptr, byval collideBodies as cpBool)
declare function cpConstraintGetPreSolveFunc(byval constraint as const cpConstraint ptr) as cpConstraintPreSolveFunc
declare sub cpConstraintSetPreSolveFunc(byval constraint as cpConstraint ptr, byval preSolveFunc as cpConstraintPreSolveFunc)
declare function cpConstraintGetPostSolveFunc(byval constraint as const cpConstraint ptr) as cpConstraintPostSolveFunc
declare sub cpConstraintSetPostSolveFunc(byval constraint as cpConstraint ptr, byval postSolveFunc as cpConstraintPostSolveFunc)
declare function cpConstraintGetUserData(byval constraint as const cpConstraint ptr) as cpDataPointer
declare sub cpConstraintSetUserData(byval constraint as cpConstraint ptr, byval userData as cpDataPointer)
declare function cpConstraintGetImpulse(byval constraint as cpConstraint ptr) as cpFloat
declare function cpConstraintIsPinJoint(byval constraint as const cpConstraint ptr) as cpBool
type cpPinJoint as cpPinJoint_
declare function cpPinJointAlloc() as cpPinJoint ptr
declare function cpPinJointInit(byval joint as cpPinJoint ptr, byval a as cpBody ptr, byval b as cpBody ptr, byval anchorA as cpVect, byval anchorB as cpVect) as cpPinJoint ptr
declare function cpPinJointNew(byval a as cpBody ptr, byval b as cpBody ptr, byval anchorA as cpVect, byval anchorB as cpVect) as cpConstraint ptr
declare function cpPinJointGetAnchorA(byval constraint as const cpConstraint ptr) as cpVect
declare sub cpPinJointSetAnchorA(byval constraint as cpConstraint ptr, byval anchorA as cpVect)
declare function cpPinJointGetAnchorB(byval constraint as const cpConstraint ptr) as cpVect
declare sub cpPinJointSetAnchorB(byval constraint as cpConstraint ptr, byval anchorB as cpVect)
declare function cpPinJointGetDist(byval constraint as const cpConstraint ptr) as cpFloat
declare sub cpPinJointSetDist(byval constraint as cpConstraint ptr, byval dist as cpFloat)
declare function cpConstraintIsSlideJoint(byval constraint as const cpConstraint ptr) as cpBool
type cpSlideJoint as cpSlideJoint_
declare function cpSlideJointAlloc() as cpSlideJoint ptr
declare function cpSlideJointInit(byval joint as cpSlideJoint ptr, byval a as cpBody ptr, byval b as cpBody ptr, byval anchorA as cpVect, byval anchorB as cpVect, byval min as cpFloat, byval max as cpFloat) as cpSlideJoint ptr
declare function cpSlideJointNew(byval a as cpBody ptr, byval b as cpBody ptr, byval anchorA as cpVect, byval anchorB as cpVect, byval min as cpFloat, byval max as cpFloat) as cpConstraint ptr
declare function cpSlideJointGetAnchorA(byval constraint as const cpConstraint ptr) as cpVect
declare sub cpSlideJointSetAnchorA(byval constraint as cpConstraint ptr, byval anchorA as cpVect)
declare function cpSlideJointGetAnchorB(byval constraint as const cpConstraint ptr) as cpVect
declare sub cpSlideJointSetAnchorB(byval constraint as cpConstraint ptr, byval anchorB as cpVect)
declare function cpSlideJointGetMin(byval constraint as const cpConstraint ptr) as cpFloat
declare sub cpSlideJointSetMin(byval constraint as cpConstraint ptr, byval min as cpFloat)
declare function cpSlideJointGetMax(byval constraint as const cpConstraint ptr) as cpFloat
declare sub cpSlideJointSetMax(byval constraint as cpConstraint ptr, byval max as cpFloat)
declare function cpConstraintIsPivotJoint(byval constraint as const cpConstraint ptr) as cpBool
type cpPivotJoint as cpPivotJoint_
declare function cpPivotJointAlloc() as cpPivotJoint ptr
declare function cpPivotJointInit(byval joint as cpPivotJoint ptr, byval a as cpBody ptr, byval b as cpBody ptr, byval anchorA as cpVect, byval anchorB as cpVect) as cpPivotJoint ptr
declare function cpPivotJointNew(byval a as cpBody ptr, byval b as cpBody ptr, byval pivot as cpVect) as cpConstraint ptr
declare function cpPivotJointNew2(byval a as cpBody ptr, byval b as cpBody ptr, byval anchorA as cpVect, byval anchorB as cpVect) as cpConstraint ptr
declare function cpPivotJointGetAnchorA(byval constraint as const cpConstraint ptr) as cpVect
declare sub cpPivotJointSetAnchorA(byval constraint as cpConstraint ptr, byval anchorA as cpVect)
declare function cpPivotJointGetAnchorB(byval constraint as const cpConstraint ptr) as cpVect
declare sub cpPivotJointSetAnchorB(byval constraint as cpConstraint ptr, byval anchorB as cpVect)
declare function cpConstraintIsGrooveJoint(byval constraint as const cpConstraint ptr) as cpBool
type cpGrooveJoint as cpGrooveJoint_
declare function cpGrooveJointAlloc() as cpGrooveJoint ptr
declare function cpGrooveJointInit(byval joint as cpGrooveJoint ptr, byval a as cpBody ptr, byval b as cpBody ptr, byval groove_a as cpVect, byval groove_b as cpVect, byval anchorB as cpVect) as cpGrooveJoint ptr
declare function cpGrooveJointNew(byval a as cpBody ptr, byval b as cpBody ptr, byval groove_a as cpVect, byval groove_b as cpVect, byval anchorB as cpVect) as cpConstraint ptr
declare function cpGrooveJointGetGrooveA(byval constraint as const cpConstraint ptr) as cpVect
declare sub cpGrooveJointSetGrooveA(byval constraint as cpConstraint ptr, byval grooveA as cpVect)
declare function cpGrooveJointGetGrooveB(byval constraint as const cpConstraint ptr) as cpVect
declare sub cpGrooveJointSetGrooveB(byval constraint as cpConstraint ptr, byval grooveB as cpVect)
declare function cpGrooveJointGetAnchorB(byval constraint as const cpConstraint ptr) as cpVect
declare sub cpGrooveJointSetAnchorB(byval constraint as cpConstraint ptr, byval anchorB as cpVect)
declare function cpConstraintIsDampedSpring(byval constraint as const cpConstraint ptr) as cpBool
type cpDampedSpringForceFunc as function(byval spring as cpConstraint ptr, byval dist as cpFloat) as cpFloat
type cpDampedSpring as cpDampedSpring_
declare function cpDampedSpringAlloc() as cpDampedSpring ptr
declare function cpDampedSpringInit(byval joint as cpDampedSpring ptr, byval a as cpBody ptr, byval b as cpBody ptr, byval anchorA as cpVect, byval anchorB as cpVect, byval restLength as cpFloat, byval stiffness as cpFloat, byval damping as cpFloat) as cpDampedSpring ptr
declare function cpDampedSpringNew(byval a as cpBody ptr, byval b as cpBody ptr, byval anchorA as cpVect, byval anchorB as cpVect, byval restLength as cpFloat, byval stiffness as cpFloat, byval damping as cpFloat) as cpConstraint ptr
declare function cpDampedSpringGetAnchorA(byval constraint as const cpConstraint ptr) as cpVect
declare sub cpDampedSpringSetAnchorA(byval constraint as cpConstraint ptr, byval anchorA as cpVect)
declare function cpDampedSpringGetAnchorB(byval constraint as const cpConstraint ptr) as cpVect
declare sub cpDampedSpringSetAnchorB(byval constraint as cpConstraint ptr, byval anchorB as cpVect)
declare function cpDampedSpringGetRestLength(byval constraint as const cpConstraint ptr) as cpFloat
declare sub cpDampedSpringSetRestLength(byval constraint as cpConstraint ptr, byval restLength as cpFloat)
declare function cpDampedSpringGetStiffness(byval constraint as const cpConstraint ptr) as cpFloat
declare sub cpDampedSpringSetStiffness(byval constraint as cpConstraint ptr, byval stiffness as cpFloat)
declare function cpDampedSpringGetDamping(byval constraint as const cpConstraint ptr) as cpFloat
declare sub cpDampedSpringSetDamping(byval constraint as cpConstraint ptr, byval damping as cpFloat)
declare function cpDampedSpringGetSpringForceFunc(byval constraint as const cpConstraint ptr) as cpDampedSpringForceFunc
declare sub cpDampedSpringSetSpringForceFunc(byval constraint as cpConstraint ptr, byval springForceFunc as cpDampedSpringForceFunc)
declare function cpConstraintIsDampedRotarySpring(byval constraint as const cpConstraint ptr) as cpBool
type cpDampedRotarySpringTorqueFunc as function(byval spring as cpConstraint ptr, byval relativeAngle as cpFloat) as cpFloat
type cpDampedRotarySpring as cpDampedRotarySpring_
declare function cpDampedRotarySpringAlloc() as cpDampedRotarySpring ptr
declare function cpDampedRotarySpringInit(byval joint as cpDampedRotarySpring ptr, byval a as cpBody ptr, byval b as cpBody ptr, byval restAngle as cpFloat, byval stiffness as cpFloat, byval damping as cpFloat) as cpDampedRotarySpring ptr
declare function cpDampedRotarySpringNew(byval a as cpBody ptr, byval b as cpBody ptr, byval restAngle as cpFloat, byval stiffness as cpFloat, byval damping as cpFloat) as cpConstraint ptr
declare function cpDampedRotarySpringGetRestAngle(byval constraint as const cpConstraint ptr) as cpFloat
declare sub cpDampedRotarySpringSetRestAngle(byval constraint as cpConstraint ptr, byval restAngle as cpFloat)
declare function cpDampedRotarySpringGetStiffness(byval constraint as const cpConstraint ptr) as cpFloat
declare sub cpDampedRotarySpringSetStiffness(byval constraint as cpConstraint ptr, byval stiffness as cpFloat)
declare function cpDampedRotarySpringGetDamping(byval constraint as const cpConstraint ptr) as cpFloat
declare sub cpDampedRotarySpringSetDamping(byval constraint as cpConstraint ptr, byval damping as cpFloat)
declare function cpDampedRotarySpringGetSpringTorqueFunc(byval constraint as const cpConstraint ptr) as cpDampedRotarySpringTorqueFunc
declare sub cpDampedRotarySpringSetSpringTorqueFunc(byval constraint as cpConstraint ptr, byval springTorqueFunc as cpDampedRotarySpringTorqueFunc)
declare function cpConstraintIsRotaryLimitJoint(byval constraint as const cpConstraint ptr) as cpBool
type cpRotaryLimitJoint as cpRotaryLimitJoint_
declare function cpRotaryLimitJointAlloc() as cpRotaryLimitJoint ptr
declare function cpRotaryLimitJointInit(byval joint as cpRotaryLimitJoint ptr, byval a as cpBody ptr, byval b as cpBody ptr, byval min as cpFloat, byval max as cpFloat) as cpRotaryLimitJoint ptr
declare function cpRotaryLimitJointNew(byval a as cpBody ptr, byval b as cpBody ptr, byval min as cpFloat, byval max as cpFloat) as cpConstraint ptr
declare function cpRotaryLimitJointGetMin(byval constraint as const cpConstraint ptr) as cpFloat
declare sub cpRotaryLimitJointSetMin(byval constraint as cpConstraint ptr, byval min as cpFloat)
declare function cpRotaryLimitJointGetMax(byval constraint as const cpConstraint ptr) as cpFloat
declare sub cpRotaryLimitJointSetMax(byval constraint as cpConstraint ptr, byval max as cpFloat)
declare function cpConstraintIsRatchetJoint(byval constraint as const cpConstraint ptr) as cpBool
type cpRatchetJoint as cpRatchetJoint_
declare function cpRatchetJointAlloc() as cpRatchetJoint ptr
declare function cpRatchetJointInit(byval joint as cpRatchetJoint ptr, byval a as cpBody ptr, byval b as cpBody ptr, byval phase as cpFloat, byval ratchet as cpFloat) as cpRatchetJoint ptr
declare function cpRatchetJointNew(byval a as cpBody ptr, byval b as cpBody ptr, byval phase as cpFloat, byval ratchet as cpFloat) as cpConstraint ptr
declare function cpRatchetJointGetAngle(byval constraint as const cpConstraint ptr) as cpFloat
declare sub cpRatchetJointSetAngle(byval constraint as cpConstraint ptr, byval angle as cpFloat)
declare function cpRatchetJointGetPhase(byval constraint as const cpConstraint ptr) as cpFloat
declare sub cpRatchetJointSetPhase(byval constraint as cpConstraint ptr, byval phase as cpFloat)
declare function cpRatchetJointGetRatchet(byval constraint as const cpConstraint ptr) as cpFloat
declare sub cpRatchetJointSetRatchet(byval constraint as cpConstraint ptr, byval ratchet as cpFloat)
declare function cpConstraintIsGearJoint(byval constraint as const cpConstraint ptr) as cpBool
type cpGearJoint as cpGearJoint_
declare function cpGearJointAlloc() as cpGearJoint ptr
declare function cpGearJointInit(byval joint as cpGearJoint ptr, byval a as cpBody ptr, byval b as cpBody ptr, byval phase as cpFloat, byval ratio as cpFloat) as cpGearJoint ptr
declare function cpGearJointNew(byval a as cpBody ptr, byval b as cpBody ptr, byval phase as cpFloat, byval ratio as cpFloat) as cpConstraint ptr
declare function cpGearJointGetPhase(byval constraint as const cpConstraint ptr) as cpFloat
declare sub cpGearJointSetPhase(byval constraint as cpConstraint ptr, byval phase as cpFloat)
declare function cpGearJointGetRatio(byval constraint as const cpConstraint ptr) as cpFloat
declare sub cpGearJointSetRatio(byval constraint as cpConstraint ptr, byval ratio as cpFloat)
declare function cpConstraintIsSimpleMotor(byval constraint as const cpConstraint ptr) as cpBool
type cpSimpleMotor as cpSimpleMotor_
declare function cpSimpleMotorAlloc() as cpSimpleMotor ptr
declare function cpSimpleMotorInit(byval joint as cpSimpleMotor ptr, byval a as cpBody ptr, byval b as cpBody ptr, byval rate as cpFloat) as cpSimpleMotor ptr
declare function cpSimpleMotorNew(byval a as cpBody ptr, byval b as cpBody ptr, byval rate as cpFloat) as cpConstraint ptr
declare function cpSimpleMotorGetRate(byval constraint as const cpConstraint ptr) as cpFloat
declare sub cpSimpleMotorSetRate(byval constraint as cpConstraint ptr, byval rate as cpFloat)

type cpCollisionBeginFunc as function(byval arb as cpArbiter ptr, byval space as cpSpace ptr, byval userData as cpDataPointer) as cpBool
type cpCollisionPreSolveFunc as function(byval arb as cpArbiter ptr, byval space as cpSpace ptr, byval userData as cpDataPointer) as cpBool
type cpCollisionPostSolveFunc as sub(byval arb as cpArbiter ptr, byval space as cpSpace ptr, byval userData as cpDataPointer)
type cpCollisionSeparateFunc as sub(byval arb as cpArbiter ptr, byval space as cpSpace ptr, byval userData as cpDataPointer)

type cpCollisionHandler
	typeA as const cpCollisionType
	typeB as const cpCollisionType
	beginFunc as cpCollisionBeginFunc
	preSolveFunc as cpCollisionPreSolveFunc
	postSolveFunc as cpCollisionPostSolveFunc
	separateFunc as cpCollisionSeparateFunc
	userData as cpDataPointer
end type

declare function cpSpaceAlloc() as cpSpace ptr
declare function cpSpaceInit(byval space as cpSpace ptr) as cpSpace ptr
declare function cpSpaceNew() as cpSpace ptr
declare sub cpSpaceDestroy(byval space as cpSpace ptr)
declare sub cpSpaceFree(byval space as cpSpace ptr)
declare function cpSpaceGetIterations(byval space as const cpSpace ptr) as long
declare sub cpSpaceSetIterations(byval space as cpSpace ptr, byval iterations as long)
declare function cpSpaceGetGravity(byval space as const cpSpace ptr) as cpVect
declare sub cpSpaceSetGravity(byval space as cpSpace ptr, byval gravity as cpVect)
declare function cpSpaceGetDamping(byval space as const cpSpace ptr) as cpFloat
declare sub cpSpaceSetDamping(byval space as cpSpace ptr, byval damping as cpFloat)
declare function cpSpaceGetIdleSpeedThreshold(byval space as const cpSpace ptr) as cpFloat
declare sub cpSpaceSetIdleSpeedThreshold(byval space as cpSpace ptr, byval idleSpeedThreshold as cpFloat)
declare function cpSpaceGetSleepTimeThreshold(byval space as const cpSpace ptr) as cpFloat
declare sub cpSpaceSetSleepTimeThreshold(byval space as cpSpace ptr, byval sleepTimeThreshold as cpFloat)
declare function cpSpaceGetCollisionSlop(byval space as const cpSpace ptr) as cpFloat
declare sub cpSpaceSetCollisionSlop(byval space as cpSpace ptr, byval collisionSlop as cpFloat)
declare function cpSpaceGetCollisionBias(byval space as const cpSpace ptr) as cpFloat
declare sub cpSpaceSetCollisionBias(byval space as cpSpace ptr, byval collisionBias as cpFloat)
declare function cpSpaceGetCollisionPersistence(byval space as const cpSpace ptr) as cpTimestamp
declare sub cpSpaceSetCollisionPersistence(byval space as cpSpace ptr, byval collisionPersistence as cpTimestamp)
declare function cpSpaceGetUserData(byval space as const cpSpace ptr) as cpDataPointer
declare sub cpSpaceSetUserData(byval space as cpSpace ptr, byval userData as cpDataPointer)
declare function cpSpaceGetStaticBody(byval space as const cpSpace ptr) as cpBody ptr
declare function cpSpaceGetCurrentTimeStep(byval space as const cpSpace ptr) as cpFloat
declare function cpSpaceIsLocked(byval space as cpSpace ptr) as cpBool
declare function cpSpaceAddDefaultCollisionHandler(byval space as cpSpace ptr) as cpCollisionHandler ptr
declare function cpSpaceAddCollisionHandler(byval space as cpSpace ptr, byval a as cpCollisionType, byval b as cpCollisionType) as cpCollisionHandler ptr
declare function cpSpaceAddWildcardHandler(byval space as cpSpace ptr, byval type as cpCollisionType) as cpCollisionHandler ptr
declare function cpSpaceAddShape(byval space as cpSpace ptr, byval shape as cpShape ptr) as cpShape ptr
declare function cpSpaceAddBody(byval space as cpSpace ptr, byval body as cpBody ptr) as cpBody ptr
declare function cpSpaceAddConstraint(byval space as cpSpace ptr, byval constraint as cpConstraint ptr) as cpConstraint ptr
declare sub cpSpaceRemoveShape(byval space as cpSpace ptr, byval shape as cpShape ptr)
declare sub cpSpaceRemoveBody(byval space as cpSpace ptr, byval body as cpBody ptr)
declare sub cpSpaceRemoveConstraint(byval space as cpSpace ptr, byval constraint as cpConstraint ptr)
declare function cpSpaceContainsShape(byval space as cpSpace ptr, byval shape as cpShape ptr) as cpBool
declare function cpSpaceContainsBody(byval space as cpSpace ptr, byval body as cpBody ptr) as cpBool
declare function cpSpaceContainsConstraint(byval space as cpSpace ptr, byval constraint as cpConstraint ptr) as cpBool
type cpPostStepFunc as sub(byval space as cpSpace ptr, byval key as any ptr, byval data_ as any ptr)
declare function cpSpaceAddPostStepCallback(byval space as cpSpace ptr, byval func as cpPostStepFunc, byval key as any ptr, byval data_ as any ptr) as cpBool
type cpSpacePointQueryFunc as sub(byval shape as cpShape ptr, byval point as cpVect, byval distance as cpFloat, byval gradient as cpVect, byval data_ as any ptr)
declare sub cpSpacePointQuery(byval space as cpSpace ptr, byval point as cpVect, byval maxDistance as cpFloat, byval filter as cpShapeFilter, byval func as cpSpacePointQueryFunc, byval data_ as any ptr)
declare function cpSpacePointQueryNearest(byval space as cpSpace ptr, byval point as cpVect, byval maxDistance as cpFloat, byval filter as cpShapeFilter, byval out as cpPointQueryInfo ptr) as cpShape ptr
type cpSpaceSegmentQueryFunc as sub(byval shape as cpShape ptr, byval point as cpVect, byval normal as cpVect, byval alpha as cpFloat, byval data_ as any ptr)
declare sub cpSpaceSegmentQuery(byval space as cpSpace ptr, byval start as cpVect, byval end as cpVect, byval radius as cpFloat, byval filter as cpShapeFilter, byval func as cpSpaceSegmentQueryFunc, byval data_ as any ptr)
declare function cpSpaceSegmentQueryFirst(byval space as cpSpace ptr, byval start as cpVect, byval end as cpVect, byval radius as cpFloat, byval filter as cpShapeFilter, byval out as cpSegmentQueryInfo ptr) as cpShape ptr
type cpSpaceBBQueryFunc as sub(byval shape as cpShape ptr, byval data_ as any ptr)
declare sub cpSpaceBBQuery(byval space as cpSpace ptr, byval bb as cpBB, byval filter as cpShapeFilter, byval func as cpSpaceBBQueryFunc, byval data_ as any ptr)
type cpSpaceShapeQueryFunc as sub(byval shape as cpShape ptr, byval points as cpContactPointSet ptr, byval data_ as any ptr)
declare function cpSpaceShapeQuery(byval space as cpSpace ptr, byval shape as cpShape ptr, byval func as cpSpaceShapeQueryFunc, byval data_ as any ptr) as cpBool
type cpSpaceBodyIteratorFunc as sub(byval body as cpBody ptr, byval data_ as any ptr)
declare sub cpSpaceEachBody(byval space as cpSpace ptr, byval func as cpSpaceBodyIteratorFunc, byval data_ as any ptr)
type cpSpaceShapeIteratorFunc as sub(byval shape as cpShape ptr, byval data_ as any ptr)
declare sub cpSpaceEachShape(byval space as cpSpace ptr, byval func as cpSpaceShapeIteratorFunc, byval data_ as any ptr)
type cpSpaceConstraintIteratorFunc as sub(byval constraint as cpConstraint ptr, byval data_ as any ptr)
declare sub cpSpaceEachConstraint(byval space as cpSpace ptr, byval func as cpSpaceConstraintIteratorFunc, byval data_ as any ptr)
declare sub cpSpaceReindexStatic(byval space as cpSpace ptr)
declare sub cpSpaceReindexShape(byval space as cpSpace ptr, byval shape as cpShape ptr)
declare sub cpSpaceReindexShapesForBody(byval space as cpSpace ptr, byval body as cpBody ptr)
declare sub cpSpaceUseSpatialHash(byval space as cpSpace ptr, byval dim as cpFloat, byval count as long)
declare sub cpSpaceStep(byval space as cpSpace ptr, byval dt as cpFloat)

type cpSpaceDebugColor
	r as single
	g as single
	b as single
	a as single
end type

type cpSpaceDebugDrawCircleImpl as sub(byval pos as cpVect, byval angle as cpFloat, byval radius as cpFloat, byval outlineColor as cpSpaceDebugColor, byval fillColor as cpSpaceDebugColor, byval data_ as cpDataPointer)
type cpSpaceDebugDrawSegmentImpl as sub(byval a as cpVect, byval b as cpVect, byval color as cpSpaceDebugColor, byval data_ as cpDataPointer)
type cpSpaceDebugDrawFatSegmentImpl as sub(byval a as cpVect, byval b as cpVect, byval radius as cpFloat, byval outlineColor as cpSpaceDebugColor, byval fillColor as cpSpaceDebugColor, byval data_ as cpDataPointer)
type cpSpaceDebugDrawPolygonImpl as sub(byval count as long, byval verts as const cpVect ptr, byval radius as cpFloat, byval outlineColor as cpSpaceDebugColor, byval fillColor as cpSpaceDebugColor, byval data_ as cpDataPointer)
type cpSpaceDebugDrawDotImpl as sub(byval size as cpFloat, byval pos as cpVect, byval color as cpSpaceDebugColor, byval data_ as cpDataPointer)
type cpSpaceDebugDrawColorForShapeImpl as function(byval shape as cpShape ptr, byval data_ as cpDataPointer) as cpSpaceDebugColor

type cpSpaceDebugDrawFlags as long
enum
	CP_SPACE_DEBUG_DRAW_SHAPES = 1 shl 0
	CP_SPACE_DEBUG_DRAW_CONSTRAINTS = 1 shl 1
	CP_SPACE_DEBUG_DRAW_COLLISION_POINTS = 1 shl 2
end enum

type cpSpaceDebugDrawOptions
	drawCircle as cpSpaceDebugDrawCircleImpl
	drawSegment as cpSpaceDebugDrawSegmentImpl
	drawFatSegment as cpSpaceDebugDrawFatSegmentImpl
	drawPolygon as cpSpaceDebugDrawPolygonImpl
	drawDot as cpSpaceDebugDrawDotImpl
	flags as cpSpaceDebugDrawFlags
	shapeOutlineColor as cpSpaceDebugColor
	colorForShape as cpSpaceDebugDrawColorForShapeImpl
	constraintColor as cpSpaceDebugColor
	collisionPointColor as cpSpaceDebugColor
	data_ as cpDataPointer
end type

declare sub cpSpaceDebugDraw(byval space as cpSpace ptr, byval options as cpSpaceDebugDrawOptions ptr)
const CP_VERSION_MAJOR = 7
const CP_VERSION_MINOR = 0
const CP_VERSION_RELEASE = 3
extern cpVersionString as const zstring ptr

declare function cpMomentForCircle(byval m as cpFloat, byval r1 as cpFloat, byval r2 as cpFloat, byval offset as cpVect) as cpFloat
declare function cpAreaForCircle(byval r1 as cpFloat, byval r2 as cpFloat) as cpFloat
declare function cpMomentForSegment(byval m as cpFloat, byval a as cpVect, byval b as cpVect, byval radius as cpFloat) as cpFloat
declare function cpAreaForSegment(byval a as cpVect, byval b as cpVect, byval radius as cpFloat) as cpFloat
declare function cpMomentForPoly(byval m as cpFloat, byval count as long, byval verts as const cpVect ptr, byval offset as cpVect, byval radius as cpFloat) as cpFloat
declare function cpAreaForPoly(byval count as const long, byval verts as const cpVect ptr, byval radius as cpFloat) as cpFloat
declare function cpCentroidForPoly(byval count as const long, byval verts as const cpVect ptr) as cpVect
declare function cpMomentForBox(byval m as cpFloat, byval width as cpFloat, byval height as cpFloat) as cpFloat
declare function cpMomentForBox2(byval m as cpFloat, byval box as cpBB) as cpFloat
declare function cpConvexHull(byval count as long, byval verts as const cpVect ptr, byval result as cpVect ptr, byval first as long ptr, byval tol as cpFloat) as long
#macro CP_CONVEX_HULL(__count__, __verts__, __count_var__, __verts_var__)
	dim as cpVect ptr __verts_var__ = cptr(cpVect ptr, alloca(__count__ * sizeof(cpVect)))
	dim as long __count_var__ = cpConvexHull(__count__, __verts__, __verts_var__, NULL, 0.0)
#endmacro

private function cpClosetPointOnSegment(byval p as const cpVect, byval a as const cpVect, byval b as const cpVect) as cpVect
	dim delta as cpVect = cpvsub(a, b)
	dim t as cpFloat = cpfclamp01(cpvdot(delta, cpvsub(p, b)) / cpvlengthsq(delta))
	return cpvadd(b, cpvmult(delta, t))
end function

end extern
