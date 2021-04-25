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

#include once "chipmunk/chipmunk.bi"

extern "C"

#define CHIPMUNK_STRUCTS_H

type cpArray
	num as long
	max as long
	arr as any ptr ptr
end type

type cpBody_sleeping
	root as cpBody ptr
	next as cpBody ptr
	idleTime as cpFloat
end type

type cpBody_
	velocity_func as cpBodyVelocityFunc
	position_func as cpBodyPositionFunc
	m as cpFloat
	m_inv as cpFloat
	i as cpFloat
	i_inv as cpFloat
	cog as cpVect
	p as cpVect
	v as cpVect
	f_ as cpVect
	a as cpFloat
	w as cpFloat
	t as cpFloat
	transform as cpTransform
	userData as cpDataPointer
	v_bias as cpVect
	w_bias as cpFloat
	space as cpSpace ptr
	shapeList as cpShape ptr
	arbiterList as cpArbiter ptr
	constraintList as cpConstraint ptr
	sleeping as cpBody_sleeping
end type

type cpArbiterState as long
enum
	CP_ARBITER_STATE_FIRST_COLLISION
	CP_ARBITER_STATE_NORMAL
	CP_ARBITER_STATE_IGNORE
	CP_ARBITER_STATE_CACHED
	CP_ARBITER_STATE_INVALIDATED
end enum

type cpArbiterThread
	next as cpArbiter ptr
	prev as cpArbiter ptr
end type

type cpContact
	r1 as cpVect
	r2 as cpVect
	nMass as cpFloat
	tMass as cpFloat
	bounce as cpFloat
	jnAcc as cpFloat
	jtAcc as cpFloat
	jBias as cpFloat
	bias as cpFloat
	hash as cpHashValue
end type

type cpCollisionInfo
	a as const cpShape ptr
	b as const cpShape ptr
	id as cpCollisionID
	n as cpVect
	count as long
	arr as cpContact ptr
end type

type cpArbiter_
	e as cpFloat
	u as cpFloat
	surface_vr as cpVect
	data_ as cpDataPointer
	a as const cpShape ptr
	b as const cpShape ptr
	body_a as cpBody ptr
	body_b as cpBody ptr
	thread_a as cpArbiterThread
	thread_b as cpArbiterThread
	count as long
	contacts as cpContact ptr
	n as cpVect
	handler as cpCollisionHandler ptr
	handlerA as cpCollisionHandler ptr
	handlerB as cpCollisionHandler ptr
	swapped as cpBool
	stamp as cpTimestamp
	state as cpArbiterState
end type

type cpShapeMassInfo
	m as cpFloat
	i as cpFloat
	cog as cpVect
	area as cpFloat
end type

type cpShapeType as long
enum
	CP_CIRCLE_SHAPE
	CP_SEGMENT_SHAPE
	CP_POLY_SHAPE
	CP_NUM_SHAPES
end enum

type cpShapeCacheDataImpl as function(byval shape as cpShape ptr, byval transform as cpTransform) as cpBB
type cpShapeDestroyImpl as sub(byval shape as cpShape ptr)
type cpShapePointQueryImpl as sub(byval shape as const cpShape ptr, byval p as cpVect, byval info as cpPointQueryInfo ptr)
type cpShapeSegmentQueryImpl as sub(byval shape as const cpShape ptr, byval a as cpVect, byval b as cpVect, byval radius as cpFloat, byval info as cpSegmentQueryInfo ptr)

type cpShapeClass
	as cpShapeType type
	cacheData as cpShapeCacheDataImpl
	destroy as cpShapeDestroyImpl
	pointQuery as cpShapePointQueryImpl
	segmentQuery as cpShapeSegmentQueryImpl
end type

type cpShape_
	klass as const cpShapeClass ptr
	space as cpSpace ptr
	body as cpBody ptr
	massInfo as cpShapeMassInfo
	bb as cpBB
	sensor as cpBool
	e as cpFloat
	u as cpFloat
	surfaceV as cpVect
	userData as cpDataPointer
	as cpCollisionType type
	filter as cpShapeFilter
	next as cpShape ptr
	prev as cpShape ptr
	hashid as cpHashValue
end type

type cpCircleShape_
	shape as cpShape
	c as cpVect
	tc as cpVect
	r as cpFloat
end type

type cpSegmentShape_
	shape as cpShape
	a as cpVect
	b as cpVect
	n as cpVect
	ta as cpVect
	tb as cpVect
	tn as cpVect
	r as cpFloat
	a_tangent as cpVect
	b_tangent as cpVect
end type

type cpSplittingPlane
	v0 as cpVect
	n as cpVect
end type

const CP_POLY_SHAPE_INLINE_ALLOC = 6

type cpPolyShape_
	shape as cpShape
	r as cpFloat
	count as long
	planes as cpSplittingPlane ptr
	_planes(0 to (2 * 6) - 1) as cpSplittingPlane
end type

type cpConstraintPreStepImpl as sub(byval constraint as cpConstraint ptr, byval dt as cpFloat)
type cpConstraintApplyCachedImpulseImpl as sub(byval constraint as cpConstraint ptr, byval dt_coef as cpFloat)
type cpConstraintApplyImpulseImpl as sub(byval constraint as cpConstraint ptr, byval dt as cpFloat)
type cpConstraintGetImpulseImpl as function(byval constraint as cpConstraint ptr) as cpFloat

type cpConstraintClass
	preStep as cpConstraintPreStepImpl
	applyCachedImpulse as cpConstraintApplyCachedImpulseImpl
	applyImpulse as cpConstraintApplyImpulseImpl
	getImpulse as cpConstraintGetImpulseImpl
end type

type cpConstraint_
	klass as const cpConstraintClass ptr
	space as cpSpace ptr
	a as cpBody ptr
	b as cpBody ptr
	next_a as cpConstraint ptr
	next_b as cpConstraint ptr
	maxForce as cpFloat
	errorBias as cpFloat
	maxBias as cpFloat
	collideBodies as cpBool
	preSolve as cpConstraintPreSolveFunc
	postSolve as cpConstraintPostSolveFunc
	userData as cpDataPointer
end type

type cpPinJoint_
	constraint as cpConstraint
	anchorA as cpVect
	anchorB as cpVect
	dist as cpFloat
	r1 as cpVect
	r2 as cpVect
	n as cpVect
	nMass as cpFloat
	jnAcc as cpFloat
	bias as cpFloat
end type

type cpSlideJoint_
	constraint as cpConstraint
	anchorA as cpVect
	anchorB as cpVect
	min as cpFloat
	max as cpFloat
	r1 as cpVect
	r2 as cpVect
	n as cpVect
	nMass as cpFloat
	jnAcc as cpFloat
	bias as cpFloat
end type

type cpPivotJoint_
	constraint as cpConstraint
	anchorA as cpVect
	anchorB as cpVect
	r1 as cpVect
	r2 as cpVect
	k as cpMat2x2
	jAcc as cpVect
	bias as cpVect
end type

type cpGrooveJoint_
	constraint as cpConstraint
	grv_n as cpVect
	grv_a as cpVect
	grv_b as cpVect
	anchorB as cpVect
	grv_tn as cpVect
	clamp as cpFloat
	r1 as cpVect
	r2 as cpVect
	k as cpMat2x2
	jAcc as cpVect
	bias as cpVect
end type

type cpDampedSpring_
	constraint as cpConstraint
	anchorA as cpVect
	anchorB as cpVect
	restLength as cpFloat
	stiffness as cpFloat
	damping as cpFloat
	springForceFunc as cpDampedSpringForceFunc
	target_vrn as cpFloat
	v_coef as cpFloat
	r1 as cpVect
	r2 as cpVect
	nMass as cpFloat
	n as cpVect
	jAcc as cpFloat
end type

type cpDampedRotarySpring_
	constraint as cpConstraint
	restAngle as cpFloat
	stiffness as cpFloat
	damping as cpFloat
	springTorqueFunc as cpDampedRotarySpringTorqueFunc
	target_wrn as cpFloat
	w_coef as cpFloat
	iSum as cpFloat
	jAcc as cpFloat
end type

type cpRotaryLimitJoint_
	constraint as cpConstraint
	min as cpFloat
	max as cpFloat
	iSum as cpFloat
	bias as cpFloat
	jAcc as cpFloat
end type

type cpRatchetJoint_
	constraint as cpConstraint
	angle as cpFloat
	phase as cpFloat
	ratchet as cpFloat
	iSum as cpFloat
	bias as cpFloat
	jAcc as cpFloat
end type

type cpGearJoint_
	constraint as cpConstraint
	phase as cpFloat
	ratio as cpFloat
	ratio_inv as cpFloat
	iSum as cpFloat
	bias as cpFloat
	jAcc as cpFloat
end type

type cpSimpleMotor_
	constraint as cpConstraint
	rate as cpFloat
	iSum as cpFloat
	jAcc as cpFloat
end type

type cpSpaceArbiterApplyImpulseFunc as sub(byval arb as cpArbiter ptr)
type cpContactBufferHeader as cpContactBufferHeader_
type cpHashSet as cpHashSet_

type cpSpace_
	iterations as long
	gravity as cpVect
	damping as cpFloat
	idleSpeedThreshold as cpFloat
	sleepTimeThreshold as cpFloat
	collisionSlop as cpFloat
	collisionBias as cpFloat
	collisionPersistence as cpTimestamp
	userData as cpDataPointer
	stamp as cpTimestamp
	curr_dt as cpFloat
	dynamicBodies as cpArray ptr
	staticBodies as cpArray ptr
	rousedBodies as cpArray ptr
	sleepingComponents as cpArray ptr
	shapeIDCounter as cpHashValue
	staticShapes as cpSpatialIndex ptr
	dynamicShapes as cpSpatialIndex ptr
	constraints as cpArray ptr
	arbiters as cpArray ptr
	contactBuffersHead as cpContactBufferHeader ptr
	cachedArbiters as cpHashSet ptr
	pooledArbiters as cpArray ptr
	allocatedBuffers as cpArray ptr
	locked as ulong
	usesWildcards as cpBool
	collisionHandlers as cpHashSet ptr
	defaultHandler as cpCollisionHandler
	skipPostStep as cpBool
	postStepCallbacks as cpArray ptr
	staticBody as cpBody ptr
	_staticBody as cpBody
end type

type cpPostStepCallback
	func as cpPostStepFunc
	key as any ptr
	data_ as any ptr
end type

end extern
