'' FreeBASIC binding for ode-0.13.1
''
'' based on the C header files:
''   **********************************************************************
''                                                                          *
''    Open Dynamics Engine, Copyright (C) 2001,2002 Russell L. Smith.       *
''    All rights reserved.  Email: russ@q12.org   Web: www.q12.org          *
''                                                                          *
''    This library is free software; you can redistribute it and/or         *
''    modify it under the terms of EITHER:                                  *
''      (1) The GNU Lesser General Public License as published by the Free  *
''          Software Foundation; either version 2.1 of the License, or (at  *
''          your option) any later version. The text of the GNU Lesser      *
''          General Public License is included with this library in the     *
''          file LICENSE.TXT.                                               *
''      (2) The BSD-style license that is included with this library in     *
''          the file LICENSE-BSD.TXT.                                       *
''                                                                          *
''    This library is distributed in the hope that it will be useful,       *
''    but WITHOUT ANY WARRANTY; without even the implied warranty of        *
''    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the files    *
''    LICENSE.TXT and LICENSE-BSD.TXT for more details.                     *
''                                                                          *
''   ***********************************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#if defined(__FB_DOS__) or defined(__FB_UNIX__)
	#inclib "ode"
#elseif defined(__FB_WIN32__) and defined(dDOUBLE)
	#inclib "ode_double"
#else
	#inclib "ode_single"
#endif

#include once "crt/long.bi"
#include once "crt/stddef.bi"
#include once "crt/limits.bi"
#include once "crt/stdio.bi"
#include once "crt/stdlib.bi"
#include once "crt/stdarg.bi"
#include once "crt/math.bi"
#include once "crt/string.bi"
#include once "crt/time.bi"

'' The following symbols have been renamed:
''     procedure dDot => dDot_

extern "C"

#define _ODE_ODE_H_
#define _ODE_ODECONFIG_H_

#if defined(__FB_64BIT__) and (((not defined(__FB_ARM__)) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))) or defined(__FB_DARWIN__) or defined(__FB_CYGWIN__) or defined(__FB_WIN32__))
	const X86_64_SYSTEM = 1
#endif

type dint64 as longint
type duint64 as ulongint
type dint32 as long
type duint32 as ulong
type dint16 as short
type duint16 as ushort
type dint8 as byte
type duint8 as ubyte

#ifdef dDOUBLE
	const dInfinity = 1.0 / 0.0
	const dNaN = dInfinity - dInfinity
#else
	const dInfinity = csng(1.0 / 0.0)
	const dNaN = csng(dInfinity - dInfinity)
#endif

#define _ode_copysignf(x, y) copysignf(x, y)
#define _ode_copysign(x, y) copysign(x, y)
#define _ode_nextafterf(x, y) nextafterf(x, y)
#define _ode_nextafter(x, y) nextafter(x, y)
#define _ODE_COMPATIBILITY_H_
#define dQtoR(q, R) dRfromQ((R), (q))
#define dRtoQ(R, q) dQfromR((q), (R))
#define dWtoDQ(w, q, dq) dDQfromW((dq), (w), (q))
#define _ODE_COMMON_H_
#define _ODE_ERROR_H_

declare sub dSetErrorHandler(byval fn as sub(byval errnum as long, byval msg as const zstring ptr, byval ap as va_list))
declare sub dSetDebugHandler(byval fn as sub(byval errnum as long, byval msg as const zstring ptr, byval ap as va_list))
declare sub dSetMessageHandler(byval fn as sub(byval errnum as long, byval msg as const zstring ptr, byval ap as va_list))
declare function dGetErrorHandler() as sub(byval errnum as long, byval msg as const zstring ptr, byval ap as va_list)
declare function dGetDebugHandler() as sub(byval errnum as long, byval msg as const zstring ptr, byval ap as va_list)
declare function dGetMessageHandler() as sub(byval errnum as long, byval msg as const zstring ptr, byval ap as va_list)
declare sub dError(byval num as long, byval msg as const zstring ptr, ...)
declare sub dDebug(byval num as long, byval msg as const zstring ptr, ...)
declare sub dMessage(byval num as long, byval msg as const zstring ptr, ...)

#ifndef M_PI
	#define M_PI REAL(3.1415926535897932384626433832795029)
#endif
#ifndef M_PI_2
	#define M_PI_2 REAL(1.5707963267948966192313216916398)
#endif
#ifndef M_SQRT1_2
	#define M_SQRT1_2 REAL(0.7071067811865475244008443621048490)
#endif

#ifdef dDOUBLE
	type dReal as double
#else
	type dReal as single
#endif

type dTriIndex as duint32
#define dPAD(a) iif((a) > 1, (((a) - 1) or 3) + 1, (a))

#ifdef dDOUBLE
	#define REAL(x) (x)
	#define dRecip(x) (1.0 / (x))
	#define dSqrt(x) sqrt(x)
	#define dRecipSqrt(x) (1.0 / sqrt(x))
	#define dSin(x) sin(x)
	#define dCos(x) cos(x)
	#define dFabs(x) fabs(x)
	#define dAtan2(y, x) atan2((y), (x))
	#define dAcos(x) acos(x)
	#define dFMod(a, b) fmod((a), (b))
	#define dFloor(x) floor(x)
	#define dCeil(x) ceil(x)
	#define dCopySign(a, b) _ode_copysign(a, b)
	#define dNextAfter(x, y) _ode_nextafter(x, y)
#else
	#define REAL(x) x##f
	#define dRecip(x) (1.0f / (x))
	#define dSqrt(x) sqrtf(x)
	#define dRecipSqrt(x) (1.0f / sqrtf(x))
	#define dSin(x) sinf(x)
	#define dCos(x) cosf(x)
	#define dFabs(x) fabsf(x)
	#define dAtan2(y, x) atan2f(y, x)
	#define dAcos(x) acosf(x)
	#define dFMod(a, b) fmodf(a, b)
	#define dFloor(x) floorf(x)
	#define dCeil(x) ceilf(x)
	#define dCopySign(a, b) _ode_copysignf(a, b)
	#define dNextAfter(x, y) _ode_nextafterf(x, y)
#endif

#define dIsNan(x) _isnan(x)
type dWorldID as dxWorld ptr
type dSpaceID as dxSpace ptr
type dBodyID as dxBody ptr
type dGeomID as dxGeom ptr
type dJointID as dxJoint ptr
type dJointGroupID as dxJointGroup ptr
type dWorldStepThreadingManagerID as dxWorldProcessThreadingManager ptr

enum
	d_ERR_UNKNOWN = 0
	d_ERR_IASSERT
	d_ERR_UASSERT
	d_ERR_LCP
end enum

type dJointType as long
enum
	dJointTypeNone = 0
	dJointTypeBall
	dJointTypeHinge
	dJointTypeSlider
	dJointTypeContact
	dJointTypeUniversal
	dJointTypeHinge2
	dJointTypeFixed
	dJointTypeNull
	dJointTypeAMotor
	dJointTypeLMotor
	dJointTypePlane2D
	dJointTypePR
	dJointTypePU
	dJointTypePiston
	dJointTypeDBall
	dJointTypeDHinge
	dJointTypeTransmission
end enum

enum
	dParamLoStop = 0
	dParamHiStop
	dParamVel
	dParamLoVel
	dParamHiVel
	dParamFMax
	dParamFudgeFactor
	dParamBounce
	dParamCFM
	dParamStopERP
	dParamStopCFM
	dParamSuspensionERP
	dParamSuspensionCFM
	dParamERP
	dParamsInGroup
	dParamGroup1 = &h000
	dParamLoStop1 = &h000
	dParamHiStop1
	dParamVel1
	dParamLoVel1
	dParamHiVel1
	dParamFMax1
	dParamFudgeFactor1
	dParamBounce1
	dParamCFM1
	dParamStopERP1
	dParamStopCFM1
	dParamSuspensionERP1
	dParamSuspensionCFM1
	dParamERP1
	dParamGroup2 = &h100
	dParamLoStop2 = &h100
	dParamHiStop2
	dParamVel2
	dParamLoVel2
	dParamHiVel2
	dParamFMax2
	dParamFudgeFactor2
	dParamBounce2
	dParamCFM2
	dParamStopERP2
	dParamStopCFM2
	dParamSuspensionERP2
	dParamSuspensionCFM2
	dParamERP2
	dParamGroup3 = &h200
	dParamLoStop3 = &h200
	dParamHiStop3
	dParamVel3
	dParamLoVel3
	dParamHiVel3
	dParamFMax3
	dParamFudgeFactor3
	dParamBounce3
	dParamCFM3
	dParamStopERP3
	dParamStopCFM3
	dParamSuspensionERP3
	dParamSuspensionCFM3
	dParamERP3
	dParamGroup = &h100
end enum

enum
	dAMotorUser = 0
	dAMotorEuler = 1
end enum

enum
	dTransmissionParallelAxes = 0
	dTransmissionIntersectingAxes = 1
	dTransmissionChainDrive = 2
end enum

type dJointFeedback
	f1(0 to 3) as dReal
	t1(0 to 3) as dReal
	f2(0 to 3) as dReal
	t2(0 to 3) as dReal
end type

declare sub dGeomMoved(byval as dGeomID)
declare function dGeomGetBodyNext(byval as dGeomID) as dGeomID
declare function dGetConfiguration() as const zstring ptr
declare function dCheckConfiguration(byval token as const zstring ptr) as long
#define _ODE_ODEINIT_H_

type dInitODEFlags as long
enum
	dInitFlagManualThreadCleanup = &h00000001
end enum

declare sub dInitODE()
declare function dInitODE2(byval uiInitFlags as ulong) as long

type dAllocateODEDataFlags as long
enum
	dAllocateFlagBasicData = 0
	dAllocateFlagCollisionData = &h00000001
	dAllocateMaskAll = not 0
end enum

declare function dAllocateODEDataForThread(byval uiAllocateFlags as ulong) as long
declare sub dCleanupODEAllDataForThread()
declare sub dCloseODE()
#define _ODE_CONTACT_H_

enum
	dContactMu2 = &h001
	dContactAxisDep = &h001
	dContactFDir1 = &h002
	dContactBounce = &h004
	dContactSoftERP = &h008
	dContactSoftCFM = &h010
	dContactMotion1 = &h020
	dContactMotion2 = &h040
	dContactMotionN = &h080
	dContactSlip1 = &h100
	dContactSlip2 = &h200
	dContactRolling = &h400
	dContactApprox0 = &h0000
	dContactApprox1_1 = &h1000
	dContactApprox1_2 = &h2000
	dContactApprox1_N = &h4000
	dContactApprox1 = &h7000
end enum

type dSurfaceParameters
	mode as long
	mu as dReal
	mu2 as dReal
	rho as dReal
	rho2 as dReal
	rhoN as dReal
	bounce as dReal
	bounce_vel as dReal
	soft_erp as dReal
	soft_cfm as dReal
	motion1 as dReal
	motion2 as dReal
	motionN as dReal
	slip1 as dReal
	slip2 as dReal
end type

type dContactGeom
	pos(0 to 3) as dReal
	normal(0 to 3) as dReal
	depth as dReal
	g1 as dGeomID
	g2 as dGeomID
	side1 as long
	side2 as long
end type

type dContact
	surface as dSurfaceParameters
	geom as dContactGeom
	fdir1(0 to 3) as dReal
end type

#define _ODE_MEMORY_H_
declare sub dSetAllocHandler(byval fn as function(byval size as uinteger) as any ptr)
declare sub dSetReallocHandler(byval fn as function(byval ptr as any ptr, byval oldsize as uinteger, byval newsize as uinteger) as any ptr)
declare sub dSetFreeHandler(byval fn as sub(byval ptr as any ptr, byval size as uinteger))
declare function dGetAllocHandler() as function(byval size as uinteger) as any ptr
declare function dGetReallocHandler() as function(byval ptr as any ptr, byval oldsize as uinteger, byval newsize as uinteger) as any ptr
declare function dGetFreeHandler() as sub(byval ptr as any ptr, byval size as uinteger)
declare function dAlloc(byval size as uinteger) as any ptr
declare function dRealloc(byval ptr as any ptr, byval oldsize as uinteger, byval newsize as uinteger) as any ptr
declare sub dFree(byval ptr as any ptr, byval size as uinteger)

#define _ODE_ODEMATH_H_
#define dACCESS33(A, i, j) (A)[(((i) * 4) + (j))]
#define dVALIDVEC3(v) (((dIsNan(v[0]) orelse dIsNan(v[1])) orelse dIsNan(v[2])) = 0)
#define dVALIDVEC4(v) ((((dIsNan(v[0]) orelse dIsNan(v[1])) orelse dIsNan(v[2])) orelse dIsNan(v[3])) = 0)
#define dVALIDMAT3(m) ((((((((((((dIsNan(m[0]) orelse dIsNan(m[1])) orelse dIsNan(m[2])) orelse dIsNan(m[3])) orelse dIsNan(m[4])) orelse dIsNan(m[5])) orelse dIsNan(m[6])) orelse dIsNan(m[7])) orelse dIsNan(m[8])) orelse dIsNan(m[9])) orelse dIsNan(m[10])) orelse dIsNan(m[11])) = 0)
#define dVALIDMAT4(m) ((((((((((((((((dIsNan(m[0]) orelse dIsNan(m[1])) orelse dIsNan(m[2])) orelse dIsNan(m[3])) orelse dIsNan(m[4])) orelse dIsNan(m[5])) orelse dIsNan(m[6])) orelse dIsNan(m[7])) orelse dIsNan(m[8])) orelse dIsNan(m[9])) orelse dIsNan(m[10])) orelse dIsNan(m[11])) orelse dIsNan(m[12])) orelse dIsNan(m[13])) orelse dIsNan(m[14])) orelse dIsNan(m[15])) = 0)

private sub dAddVectors3(byval res as dReal ptr, byval a as const dReal ptr, byval b as const dReal ptr)
	dim res_0 as const dReal = a[0] + b[0]
	dim res_1 as const dReal = a[1] + b[1]
	dim res_2 as const dReal = a[2] + b[2]
	res[0] = res_0
	res[1] = res_1
	res[2] = res_2
end sub

private sub dSubtractVectors3(byval res as dReal ptr, byval a as const dReal ptr, byval b as const dReal ptr)
	dim res_0 as const dReal = a[0] - b[0]
	dim res_1 as const dReal = a[1] - b[1]
	dim res_2 as const dReal = a[2] - b[2]
	res[0] = res_0
	res[1] = res_1
	res[2] = res_2
end sub

private sub dAddScaledVectors3(byval res as dReal ptr, byval a as const dReal ptr, byval b as const dReal ptr, byval a_scale as dReal, byval b_scale as dReal)
	dim res_0 as const dReal = (a_scale * a[0]) + (b_scale * b[0])
	dim res_1 as const dReal = (a_scale * a[1]) + (b_scale * b[1])
	dim res_2 as const dReal = (a_scale * a[2]) + (b_scale * b[2])
	res[0] = res_0
	res[1] = res_1
	res[2] = res_2
end sub

private sub dScaleVector3(byval res as dReal ptr, byval nScale as dReal)
	res[0] *= nScale
	res[1] *= nScale
	res[2] *= nScale
end sub

private sub dNegateVector3(byval res as dReal ptr)
	res[0] = -res[0]
	res[1] = -res[1]
	res[2] = -res[2]
end sub

private sub dCopyVector3(byval res as dReal ptr, byval a as const dReal ptr)
	dim res_0 as const dReal = a[0]
	dim res_1 as const dReal = a[1]
	dim res_2 as const dReal = a[2]
	res[0] = res_0
	res[1] = res_1
	res[2] = res_2
end sub

private sub dCopyScaledVector3(byval res as dReal ptr, byval a as const dReal ptr, byval nScale as dReal)
	dim res_0 as const dReal = a[0] * nScale
	dim res_1 as const dReal = a[1] * nScale
	dim res_2 as const dReal = a[2] * nScale
	res[0] = res_0
	res[1] = res_1
	res[2] = res_2
end sub

private sub dCopyNegatedVector3(byval res as dReal ptr, byval a as const dReal ptr)
	dim res_0 as const dReal = -a[0]
	dim res_1 as const dReal = -a[1]
	dim res_2 as const dReal = -a[2]
	res[0] = res_0
	res[1] = res_1
	res[2] = res_2
end sub

private sub dCopyVector4(byval res as dReal ptr, byval a as const dReal ptr)
	dim res_0 as const dReal = a[0]
	dim res_1 as const dReal = a[1]
	dim res_2 as const dReal = a[2]
	dim res_3 as const dReal = a[3]
	res[0] = res_0
	res[1] = res_1
	res[2] = res_2
	res[3] = res_3
end sub

private sub dCopyMatrix4x4(byval res as dReal ptr, byval a as const dReal ptr)
	dCopyVector4(res + 0, a + 0)
	dCopyVector4(res + 4, a + 4)
	dCopyVector4(res + 8, a + 8)
end sub

private sub dCopyMatrix4x3(byval res as dReal ptr, byval a as const dReal ptr)
	dCopyVector3(res + 0, a + 0)
	dCopyVector3(res + 4, a + 4)
	dCopyVector3(res + 8, a + 8)
end sub

private sub dGetMatrixColumn3(byval res as dReal ptr, byval a as const dReal ptr, byval n as ulong)
	dim res_0 as const dReal = a[(n + 0)]
	dim res_1 as const dReal = a[(n + 4)]
	dim res_2 as const dReal = a[(n + 8)]
	res[0] = res_0
	res[1] = res_1
	res[2] = res_2
end sub

#ifdef dDOUBLE
	private function dCalcVectorLength3(byval a as const dReal ptr) as dReal
		return sqrt(((a[0] * a[0]) + (a[1] * a[1])) + (a[2] * a[2]))
	end function
#else
	private function dCalcVectorLength3(byval a as const dReal ptr) as dReal
		return sqrtf(((a[0] * a[0]) + (a[1] * a[1])) + (a[2] * a[2]))
	end function
#endif

private function dCalcVectorLengthSquare3(byval a as const dReal ptr) as dReal
	return ((a[0] * a[0]) + (a[1] * a[1])) + (a[2] * a[2])
end function

private function dCalcPointDepth3(byval test_p as const dReal ptr, byval plane_p as const dReal ptr, byval plane_n as const dReal ptr) as dReal
	return (((plane_p[0] - test_p[0]) * plane_n[0]) + ((plane_p[1] - test_p[1]) * plane_n[1])) + ((plane_p[2] - test_p[2]) * plane_n[2])
end function

private function _dCalcVectorDot3(byval a as const dReal ptr, byval b as const dReal ptr, byval step_a as ulong, byval step_b as ulong) as dReal
	return ((a[0] * b[0]) + (a[step_a] * b[step_b])) + (a[(2 * step_a)] * b[(2 * step_b)])
end function

#define dCalcVectorDot3(a, b) cast(dReal, _dCalcVectorDot3((a), (b), 1, 1))
#define dCalcVectorDot3_13(a, b) cast(dReal, _dCalcVectorDot3((a), (b), 1, 3))
#define dCalcVectorDot3_31(a, b) cast(dReal, _dCalcVectorDot3((a), (b), 3, 1))
#define dCalcVectorDot3_33(a, b) cast(dReal, _dCalcVectorDot3((a), (b), 3, 3))
#define dCalcVectorDot3_14(a, b) cast(dReal, _dCalcVectorDot3((a), (b), 1, 4))
#define dCalcVectorDot3_41(a, b) cast(dReal, _dCalcVectorDot3((a), (b), 4, 1))
#define dCalcVectorDot3_44(a, b) cast(dReal, _dCalcVectorDot3((a), (b), 4, 4))

private sub _dCalcVectorCross3(byval res as dReal ptr, byval a as const dReal ptr, byval b as const dReal ptr, byval step_res as ulong, byval step_a as ulong, byval step_b as ulong)
	dim res_0 as const dReal = (a[step_a] * b[(2 * step_b)]) - (a[(2 * step_a)] * b[step_b])
	dim res_1 as const dReal = (a[(2 * step_a)] * b[0]) - (a[0] * b[(2 * step_b)])
	dim res_2 as const dReal = (a[0] * b[step_b]) - (a[step_a] * b[0])
	res[0] = res_0
	res[step_res] = res_1
	res[(2 * step_res)] = res_2
end sub

private sub dCalcVectorCross3(byval res as dReal ptr, byval a as const dReal ptr, byval b as const dReal ptr)
	_dCalcVectorCross3(res, a, b, 1, 1, 1)
end sub

private sub dCalcVectorCross3_114(byval res as dReal ptr, byval a as const dReal ptr, byval b as const dReal ptr)
	_dCalcVectorCross3(res, a, b, 1, 1, 4)
end sub

private sub dCalcVectorCross3_141(byval res as dReal ptr, byval a as const dReal ptr, byval b as const dReal ptr)
	_dCalcVectorCross3(res, a, b, 1, 4, 1)
end sub

private sub dCalcVectorCross3_144(byval res as dReal ptr, byval a as const dReal ptr, byval b as const dReal ptr)
	_dCalcVectorCross3(res, a, b, 1, 4, 4)
end sub

private sub dCalcVectorCross3_411(byval res as dReal ptr, byval a as const dReal ptr, byval b as const dReal ptr)
	_dCalcVectorCross3(res, a, b, 4, 1, 1)
end sub

private sub dCalcVectorCross3_414(byval res as dReal ptr, byval a as const dReal ptr, byval b as const dReal ptr)
	_dCalcVectorCross3(res, a, b, 4, 1, 4)
end sub

private sub dCalcVectorCross3_441(byval res as dReal ptr, byval a as const dReal ptr, byval b as const dReal ptr)
	_dCalcVectorCross3(res, a, b, 4, 4, 1)
end sub

private sub dCalcVectorCross3_444(byval res as dReal ptr, byval a as const dReal ptr, byval b as const dReal ptr)
	_dCalcVectorCross3(res, a, b, 4, 4, 4)
end sub

private sub dAddVectorCross3(byval res as dReal ptr, byval a as const dReal ptr, byval b as const dReal ptr)
	dim tmp(0 to 2) as dReal
	dCalcVectorCross3(@tmp(0), a, b)
	dAddVectors3(res, res, @tmp(0))
end sub

private sub dSubtractVectorCross3(byval res as dReal ptr, byval a as const dReal ptr, byval b as const dReal ptr)
	dim tmp(0 to 2) as dReal
	dCalcVectorCross3(@tmp(0), a, b)
	dSubtractVectors3(res, res, @tmp(0))
end sub

private sub dSetCrossMatrixPlus(byval res as dReal ptr, byval a as const dReal ptr, byval skip as ulong)
	dim a_0 as const dReal = a[0]
	dim a_1 as const dReal = a[1]
	dim a_2 as const dReal = a[2]
	res[1] = -a_2
	res[2] = +a_1
	res[(skip + 0)] = +a_2
	res[(skip + 2)] = -a_0
	res[((2 * skip) + 0)] = -a_1
	res[((2 * skip) + 1)] = +a_0
end sub

private sub dSetCrossMatrixMinus(byval res as dReal ptr, byval a as const dReal ptr, byval skip as ulong)
	dim a_0 as const dReal = a[0]
	dim a_1 as const dReal = a[1]
	dim a_2 as const dReal = a[2]
	res[1] = +a_2
	res[2] = -a_1
	res[(skip + 0)] = -a_2
	res[(skip + 2)] = +a_0
	res[((2 * skip) + 0)] = +a_1
	res[((2 * skip) + 1)] = -a_0
end sub

private function dCalcPointsDistance3(byval a as const dReal ptr, byval b as const dReal ptr) as dReal
	dim res as dReal
	dim tmp(0 to 2) as dReal
	dSubtractVectors3(@tmp(0), a, b)
	res = dCalcVectorLength3(@tmp(0))
	return res
end function

private sub dMultiplyHelper0_331(byval res as dReal ptr, byval a as const dReal ptr, byval b as const dReal ptr)
	dim res_0 as const dReal = dCalcVectorDot3(a, b)
	dim res_1 as const dReal = dCalcVectorDot3(a + 4, b)
	dim res_2 as const dReal = dCalcVectorDot3(a + 8, b)
	res[0] = res_0
	res[1] = res_1
	res[2] = res_2
end sub

private sub dMultiplyHelper1_331(byval res as dReal ptr, byval a as const dReal ptr, byval b as const dReal ptr)
	dim res_0 as const dReal = dCalcVectorDot3_41(a, b)
	dim res_1 as const dReal = dCalcVectorDot3_41(a + 1, b)
	dim res_2 as const dReal = dCalcVectorDot3_41(a + 2, b)
	res[0] = res_0
	res[1] = res_1
	res[2] = res_2
end sub

private sub dMultiplyHelper0_133(byval res as dReal ptr, byval a as const dReal ptr, byval b as const dReal ptr)
	dMultiplyHelper1_331(res, b, a)
end sub

private sub dMultiplyHelper1_133(byval res as dReal ptr, byval a as const dReal ptr, byval b as const dReal ptr)
	dim res_0 as const dReal = dCalcVectorDot3_44(a, b)
	dim res_1 as const dReal = dCalcVectorDot3_44(a + 1, b)
	dim res_2 as const dReal = dCalcVectorDot3_44(a + 2, b)
	res[0] = res_0
	res[1] = res_1
	res[2] = res_2
end sub

private sub dMultiply0_331(byval res as dReal ptr, byval a as const dReal ptr, byval b as const dReal ptr)
	dMultiplyHelper0_331(res, a, b)
end sub

private sub dMultiply1_331(byval res as dReal ptr, byval a as const dReal ptr, byval b as const dReal ptr)
	dMultiplyHelper1_331(res, a, b)
end sub

private sub dMultiply0_133(byval res as dReal ptr, byval a as const dReal ptr, byval b as const dReal ptr)
	dMultiplyHelper0_133(res, a, b)
end sub

private sub dMultiply0_333(byval res as dReal ptr, byval a as const dReal ptr, byval b as const dReal ptr)
	dMultiplyHelper0_133(res + 0, a + 0, b)
	dMultiplyHelper0_133(res + 4, a + 4, b)
	dMultiplyHelper0_133(res + 8, a + 8, b)
end sub

private sub dMultiply1_333(byval res as dReal ptr, byval a as const dReal ptr, byval b as const dReal ptr)
	dMultiplyHelper1_133(res + 0, b, a + 0)
	dMultiplyHelper1_133(res + 4, b, a + 1)
	dMultiplyHelper1_133(res + 8, b, a + 2)
end sub

private sub dMultiply2_333(byval res as dReal ptr, byval a as const dReal ptr, byval b as const dReal ptr)
	dMultiplyHelper0_331(res + 0, b, a + 0)
	dMultiplyHelper0_331(res + 4, b, a + 4)
	dMultiplyHelper0_331(res + 8, b, a + 8)
end sub

private sub dMultiplyAdd0_331(byval res as dReal ptr, byval a as const dReal ptr, byval b as const dReal ptr)
	dim tmp(0 to 2) as dReal
	dMultiplyHelper0_331(@tmp(0), a, b)
	dAddVectors3(res, res, @tmp(0))
end sub

private sub dMultiplyAdd1_331(byval res as dReal ptr, byval a as const dReal ptr, byval b as const dReal ptr)
	dim tmp(0 to 2) as dReal
	dMultiplyHelper1_331(@tmp(0), a, b)
	dAddVectors3(res, res, @tmp(0))
end sub

private sub dMultiplyAdd0_133(byval res as dReal ptr, byval a as const dReal ptr, byval b as const dReal ptr)
	dim tmp(0 to 2) as dReal
	dMultiplyHelper0_133(@tmp(0), a, b)
	dAddVectors3(res, res, @tmp(0))
end sub

private sub dMultiplyAdd0_333(byval res as dReal ptr, byval a as const dReal ptr, byval b as const dReal ptr)
	dim tmp(0 to 2) as dReal
	dMultiplyHelper0_133(@tmp(0), a + 0, b)
	dAddVectors3(res + 0, res + 0, @tmp(0))
	dMultiplyHelper0_133(@tmp(0), a + 4, b)
	dAddVectors3(res + 4, res + 4, @tmp(0))
	dMultiplyHelper0_133(@tmp(0), a + 8, b)
	dAddVectors3(res + 8, res + 8, @tmp(0))
end sub

private sub dMultiplyAdd1_333(byval res as dReal ptr, byval a as const dReal ptr, byval b as const dReal ptr)
	dim tmp(0 to 2) as dReal
	dMultiplyHelper1_133(@tmp(0), b, a + 0)
	dAddVectors3(res + 0, res + 0, @tmp(0))
	dMultiplyHelper1_133(@tmp(0), b, a + 1)
	dAddVectors3(res + 4, res + 4, @tmp(0))
	dMultiplyHelper1_133(@tmp(0), b, a + 2)
	dAddVectors3(res + 8, res + 8, @tmp(0))
end sub

private sub dMultiplyAdd2_333(byval res as dReal ptr, byval a as const dReal ptr, byval b as const dReal ptr)
	dim tmp(0 to 2) as dReal
	dMultiplyHelper0_331(@tmp(0), b, a + 0)
	dAddVectors3(res + 0, res + 0, @tmp(0))
	dMultiplyHelper0_331(@tmp(0), b, a + 4)
	dAddVectors3(res + 4, res + 4, @tmp(0))
	dMultiplyHelper0_331(@tmp(0), b, a + 8)
	dAddVectors3(res + 8, res + 8, @tmp(0))
end sub

private function dCalcMatrix3Det(byval mat as const dReal ptr) as dReal
	dim det as dReal
	det = ((mat[0] * ((mat[5] * mat[10]) - (mat[9] * mat[6]))) - (mat[1] * ((mat[4] * mat[10]) - (mat[8] * mat[6])))) + (mat[2] * ((mat[4] * mat[9]) - (mat[8] * mat[5])))
	return det
end function

#ifdef dDOUBLE
	private function dInvertMatrix3(byval dst as dReal ptr, byval ma as const dReal ptr) as dReal
		dim det as dReal
		dim detRecip as dReal
		det = dCalcMatrix3Det(ma)
		if det = 0 then
			return 0
		end if
		detRecip = 1.0 / det
		dst[0] = ((ma[5] * ma[10]) - (ma[6] * ma[9])) * detRecip
		dst[1] = ((ma[9] * ma[2]) - (ma[1] * ma[10])) * detRecip
		dst[2] = ((ma[1] * ma[6]) - (ma[5] * ma[2])) * detRecip
		dst[4] = ((ma[6] * ma[8]) - (ma[4] * ma[10])) * detRecip
		dst[5] = ((ma[0] * ma[10]) - (ma[8] * ma[2])) * detRecip
		dst[6] = ((ma[4] * ma[2]) - (ma[0] * ma[6])) * detRecip
		dst[8] = ((ma[4] * ma[9]) - (ma[8] * ma[5])) * detRecip
		dst[9] = ((ma[8] * ma[1]) - (ma[0] * ma[9])) * detRecip
		dst[10] = ((ma[0] * ma[5]) - (ma[1] * ma[4])) * detRecip
		return det
	end function
#else
	private function dInvertMatrix3(byval dst as dReal ptr, byval ma as const dReal ptr) as dReal
		dim det as dReal
		dim detRecip as dReal
		det = dCalcMatrix3Det(ma)
		if det = 0 then
			return 0
		end if
		detRecip = 1.0f / det
		dst[0] = ((ma[5] * ma[10]) - (ma[6] * ma[9])) * detRecip
		dst[1] = ((ma[9] * ma[2]) - (ma[1] * ma[10])) * detRecip
		dst[2] = ((ma[1] * ma[6]) - (ma[5] * ma[2])) * detRecip
		dst[4] = ((ma[6] * ma[8]) - (ma[4] * ma[10])) * detRecip
		dst[5] = ((ma[0] * ma[10]) - (ma[8] * ma[2])) * detRecip
		dst[6] = ((ma[4] * ma[2]) - (ma[0] * ma[6])) * detRecip
		dst[8] = ((ma[4] * ma[9]) - (ma[8] * ma[5])) * detRecip
		dst[9] = ((ma[8] * ma[1]) - (ma[0] * ma[9])) * detRecip
		dst[10] = ((ma[0] * ma[5]) - (ma[1] * ma[4])) * detRecip
		return det
	end function
#endif

#define _ODE_ODEMATH_LEGACY_H_
#macro dOP(a, op, b, c)
	scope
		(a)[0] = ((b)[0]) op ((c)[0])
		(a)[1] = ((b)[1]) op ((c)[1])
		(a)[2] = ((b)[2]) op ((c)[2])
	end scope
#endmacro
#macro dOPC(a, op, b, c)
	scope
		(a)[0] = ((b)[0]) op (c)
		(a)[1] = ((b)[1]) op (c)
		(a)[2] = ((b)[2]) op (c)
	end scope
#endmacro
#macro dOPE(a, op, b)
	scope
		(a)[0] op ((b)[0])
		(a)[1] op ((b)[1])
		(a)[2] op ((b)[2])
	end scope
#endmacro
#macro dOPEC(a, op, c)
	scope
		(a)[0] op (c)
		(a)[1] op (c)
		(a)[2] op (c)
	end scope
#endmacro
#macro dOPE2(a, op1, b, op2, c)
	scope
		(a)[0] op1 ((b)[0]) op2 ((c)[0])
		(a)[1] op1 ((b)[1]) op2 ((c)[1])
		(a)[2] op1 ((b)[2]) op2 ((c)[2])
	end scope
#endmacro
#define dLENGTHSQUARED(a) dCalcVectorLengthSquare3(a)
#define dLENGTH(a) dCalcVectorLength3(a)
#define dDISTANCE(a, b) dCalcPointsDistance3(a, b)
#define dDOT(a, b) dCalcVectorDot3(a, b)
#define dDOT13(a, b) dCalcVectorDot3_13(a, b)
#define dDOT31(a, b) dCalcVectorDot3_31(a, b)
#define dDOT33(a, b) dCalcVectorDot3_33(a, b)
#define dDOT14(a, b) dCalcVectorDot3_14(a, b)
#define dDOT41(a, b) dCalcVectorDot3_41(a, b)
#define dDOT44(a, b) dCalcVectorDot3_44(a, b)
#macro dCROSS(a, op, b, c)
	scope
		(a)[0] op ((b)[1]*(c)[2] - (b)[2]*(c)[1])
		(a)[1] op ((b)[2]*(c)[0] - (b)[0]*(c)[2])
		(a)[2] op ((b)[0]*(c)[1] - (b)[1]*(c)[0])
	end scope
#endmacro
#macro dCROSSpqr(a, op, b, c, p, q, r)
	scope
		(a)[  0] op ((b)[  q]*(c)[2*r] - (b)[2*q]*(c)[  r])
		(a)[  p] op ((b)[2*q]*(c)[  0] - (b)[  0]*(c)[2*r])
		(a)[2*p] op ((b)[  0]*(c)[  r] - (b)[  q]*(c)[  0])
	end scope
#endmacro
#define dCROSS114(a, op, b, c) dCROSSpqr(a, op, b, c, 1, 1, 4)
#define dCROSS141(a, op, b, c) dCROSSpqr(a, op, b, c, 1, 4, 1)
#define dCROSS144(a, op, b, c) dCROSSpqr(a, op, b, c, 1, 4, 4)
#define dCROSS411(a, op, b, c) dCROSSpqr(a, op, b, c, 4, 1, 1)
#define dCROSS414(a, op, b, c) dCROSSpqr(a, op, b, c, 4, 1, 4)
#define dCROSS441(a, op, b, c) dCROSSpqr(a, op, b, c, 4, 4, 1)
#define dCROSS444(a, op, b, c) dCROSSpqr(a, op, b, c, 4, 4, 4)
#macro dCROSSMAT(A, a_, skip, plus, minus)
	scope
		(A)[1] = minus (a_)[2]
		(A)[2] = plus (a_)[1]
		(A)[(skip)+0] = plus (a_)[2]
		(A)[(skip)+2] = minus (a_)[0]
		(A)[2*(skip)+0] = minus (a_)[1]
		(A)[2*(skip)+1] = plus (a_)[0]
	end scope
#endmacro

declare function dSafeNormalize3(byval a as dReal ptr) as long
declare function dSafeNormalize4(byval a as dReal ptr) as long
declare sub dNormalize3(byval a as dReal ptr)
declare sub dNormalize4(byval a as dReal ptr)
declare sub dPlaneSpace(byval n as const dReal ptr, byval p as dReal ptr, byval q as dReal ptr)
declare sub dOrthogonalizeR(byval m as dReal ptr)
#define _ODE_MATRIX_H_
declare sub dSetZero(byval a as dReal ptr, byval n as long)
declare sub dSetValue(byval a as dReal ptr, byval n as long, byval value as dReal)
declare function dDot_ alias "dDot"(byval a as const dReal ptr, byval b as const dReal ptr, byval n as long) as dReal
declare sub dMultiply0(byval A as dReal ptr, byval B as const dReal ptr, byval C as const dReal ptr, byval p as long, byval q as long, byval r as long)
declare sub dMultiply1(byval A as dReal ptr, byval B as const dReal ptr, byval C as const dReal ptr, byval p as long, byval q as long, byval r as long)
declare sub dMultiply2(byval A as dReal ptr, byval B as const dReal ptr, byval C as const dReal ptr, byval p as long, byval q as long, byval r as long)
declare function dFactorCholesky(byval A as dReal ptr, byval n as long) as long
declare sub dSolveCholesky(byval L as const dReal ptr, byval b as dReal ptr, byval n as long)
declare function dInvertPDMatrix(byval A as const dReal ptr, byval Ainv as dReal ptr, byval n as long) as long
declare function dIsPositiveDefinite(byval A as const dReal ptr, byval n as long) as long
declare sub dFactorLDLT(byval A as dReal ptr, byval d as dReal ptr, byval n as long, byval nskip as long)
declare sub dSolveL1(byval L as const dReal ptr, byval b as dReal ptr, byval n as long, byval nskip as long)
declare sub dSolveL1T(byval L as const dReal ptr, byval b as dReal ptr, byval n as long, byval nskip as long)
declare sub dVectorScale(byval a as dReal ptr, byval d as const dReal ptr, byval n as long)
declare sub dSolveLDLT(byval L as const dReal ptr, byval d as const dReal ptr, byval b as dReal ptr, byval n as long, byval nskip as long)
declare sub dLDLTAddTL(byval L as dReal ptr, byval d as dReal ptr, byval a as const dReal ptr, byval n as long, byval nskip as long)
declare sub dLDLTRemove(byval A as dReal ptr ptr, byval p as const long ptr, byval L as dReal ptr, byval d as dReal ptr, byval n1 as long, byval n2 as long, byval r as long, byval nskip as long)
declare sub dRemoveRowCol(byval A as dReal ptr, byval n as long, byval nskip as long, byval r as long)
#define _ODE_TIMER_H_

type dStopwatch
	time as double
	cc(0 to 1) as culong
end type

declare sub dStopwatchReset(byval as dStopwatch ptr)
declare sub dStopwatchStart(byval as dStopwatch ptr)
declare sub dStopwatchStop(byval as dStopwatch ptr)
declare function dStopwatchTime(byval as dStopwatch ptr) as double
declare sub dTimerStart(byval description as const zstring ptr)
declare sub dTimerNow(byval description as const zstring ptr)
declare sub dTimerEnd()
declare sub dTimerReport(byval fout as FILE ptr, byval average as long)
declare function dTimerTicksPerSecond() as double
declare function dTimerResolution() as double
#define _ODE_ROTATION_H_
declare sub dRSetIdentity(byval R as dReal ptr)
declare sub dRFromAxisAndAngle(byval R as dReal ptr, byval ax as dReal, byval ay as dReal, byval az as dReal, byval angle as dReal)
declare sub dRFromEulerAngles(byval R as dReal ptr, byval phi as dReal, byval theta as dReal, byval psi as dReal)
declare sub dRFrom2Axes(byval R as dReal ptr, byval ax as dReal, byval ay as dReal, byval az as dReal, byval bx as dReal, byval by as dReal, byval bz as dReal)
declare sub dRFromZAxis(byval R as dReal ptr, byval ax as dReal, byval ay as dReal, byval az as dReal)
declare sub dQSetIdentity(byval q as dReal ptr)
declare sub dQFromAxisAndAngle(byval q as dReal ptr, byval ax as dReal, byval ay as dReal, byval az as dReal, byval angle as dReal)
declare sub dQMultiply0(byval qa as dReal ptr, byval qb as const dReal ptr, byval qc as const dReal ptr)
declare sub dQMultiply1(byval qa as dReal ptr, byval qb as const dReal ptr, byval qc as const dReal ptr)
declare sub dQMultiply2(byval qa as dReal ptr, byval qb as const dReal ptr, byval qc as const dReal ptr)
declare sub dQMultiply3(byval qa as dReal ptr, byval qb as const dReal ptr, byval qc as const dReal ptr)
declare sub dRfromQ(byval R as dReal ptr, byval q as const dReal ptr)
declare sub dQfromR(byval q as dReal ptr, byval R as const dReal ptr)
declare sub dDQfromW(byval dq as dReal ptr, byval w as const dReal ptr, byval q as const dReal ptr)
#define _ODE_MASS_H_
type dMass as dMass_
declare function dMassCheck(byval m as const dMass ptr) as long
declare sub dMassSetZero(byval as dMass ptr)
declare sub dMassSetParameters(byval as dMass ptr, byval themass as dReal, byval cgx as dReal, byval cgy as dReal, byval cgz as dReal, byval I11 as dReal, byval I22 as dReal, byval I33 as dReal, byval I12 as dReal, byval I13 as dReal, byval I23 as dReal)
declare sub dMassSetSphere(byval as dMass ptr, byval density as dReal, byval radius as dReal)
declare sub dMassSetSphereTotal(byval as dMass ptr, byval total_mass as dReal, byval radius as dReal)
declare sub dMassSetCapsule(byval as dMass ptr, byval density as dReal, byval direction as long, byval radius as dReal, byval length as dReal)
declare sub dMassSetCapsuleTotal(byval as dMass ptr, byval total_mass as dReal, byval direction as long, byval radius as dReal, byval length as dReal)
declare sub dMassSetCylinder(byval as dMass ptr, byval density as dReal, byval direction as long, byval radius as dReal, byval length as dReal)
declare sub dMassSetCylinderTotal(byval as dMass ptr, byval total_mass as dReal, byval direction as long, byval radius as dReal, byval length as dReal)
declare sub dMassSetBox(byval as dMass ptr, byval density as dReal, byval lx as dReal, byval ly as dReal, byval lz as dReal)
declare sub dMassSetBoxTotal(byval as dMass ptr, byval total_mass as dReal, byval lx as dReal, byval ly as dReal, byval lz as dReal)
declare sub dMassSetTrimesh(byval as dMass ptr, byval density as dReal, byval g as dGeomID)
declare sub dMassSetTrimeshTotal(byval m as dMass ptr, byval total_mass as dReal, byval g as dGeomID)
declare sub dMassAdjust(byval as dMass ptr, byval newmass as dReal)
declare sub dMassTranslate(byval as dMass ptr, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dMassRotate(byval as dMass ptr, byval R as const dReal ptr)
declare sub dMassAdd(byval a as dMass ptr, byval b as const dMass ptr)
declare sub dMassSetCappedCylinder(byval a as dMass ptr, byval b as dReal, byval c as long, byval d as dReal, byval e as dReal)
declare sub dMassSetCappedCylinderTotal(byval a as dMass ptr, byval b as dReal, byval c as long, byval d as dReal, byval e as dReal)

type dMass_
	mass as dReal
	c(0 to 3) as dReal
	I(0 to (4 * 3) - 1) as dReal
end type

#define _ODE_MISC_H_
declare function dTestRand() as long
declare function dRand() as culong
declare function dRandGetSeed() as culong
declare sub dRandSetSeed(byval s as culong)
declare function dRandInt(byval n as long) as long
declare function dRandReal() as dReal
declare sub dPrintMatrix(byval A as const dReal ptr, byval n as long, byval m as long, byval fmt as const zstring ptr, byval f as FILE ptr)
declare sub dMakeRandomVector(byval A as dReal ptr, byval n as long, byval range as dReal)
declare sub dMakeRandomMatrix(byval A as dReal ptr, byval n as long, byval m as long, byval range as dReal)
declare sub dClearUpperTriangle(byval A as dReal ptr, byval n as long)
declare function dMaxDifference(byval A as const dReal ptr, byval B as const dReal ptr, byval n as long, byval m as long) as dReal
declare function dMaxDifferenceLowerTriangle(byval A as const dReal ptr, byval B as const dReal ptr, byval n as long) as dReal
#define _ODE_OBJECTS_H_
#define _ODE_THREADING_H_

type dThreadingImplementationID as dxThreadingImplementation ptr
type dmutexindex_t as ulong
type dMutexGroupID as dxMutexGroup ptr
type dCallReleaseeID as dxCallReleasee ptr
type dCallWaitID as dxCallWait ptr
type ddependencycount_t as uinteger
type ddependencychange_t as integer
type dcallindex_t as uinteger

type dxThreadedWaitTime
	wait_sec as time_t
	wait_nsec as culong
end type

type dThreadedWaitTime as dxThreadedWaitTime

type dxThreadingFunctionsInfo
	struct_size as ulong
	alloc_mutex_group as function(byval impl as dThreadingImplementationID, byval Mutex_count as dmutexindex_t, byval Mutex_names_ptr as const zstring const ptr ptr) as dMutexGroupID
	free_mutex_group as sub(byval impl as dThreadingImplementationID, byval mutex_group as dMutexGroupID)
	lock_group_mutex as sub(byval impl as dThreadingImplementationID, byval mutex_group as dMutexGroupID, byval mutex_index as dmutexindex_t)
	unlock_group_mutex as sub(byval impl as dThreadingImplementationID, byval mutex_group as dMutexGroupID, byval mutex_index as dmutexindex_t)
	alloc_call_wait as function(byval impl as dThreadingImplementationID) as dCallWaitID
	reset_call_wait as sub(byval impl as dThreadingImplementationID, byval call_wait as dCallWaitID)
	free_call_wait as sub(byval impl as dThreadingImplementationID, byval call_wait as dCallWaitID)
	post_call as sub(byval impl as dThreadingImplementationID, byval out_summary_fault as long ptr, byval out_post_releasee as dCallReleaseeID ptr, byval dependencies_count as ddependencycount_t, byval dependent_releasee as dCallReleaseeID, byval call_wait as dCallWaitID, byval call_func as function(byval call_context as any ptr, byval instance_index as dcallindex_t, byval this_releasee as dCallReleaseeID) as long, byval call_context as any ptr, byval instance_index as dcallindex_t, byval call_name as const zstring ptr)
	alter_call_dependencies_count as sub(byval impl as dThreadingImplementationID, byval target_releasee as dCallReleaseeID, byval dependencies_count_change as ddependencychange_t)
	wait_call as sub(byval impl as dThreadingImplementationID, byval out_wait_status as long ptr, byval call_wait as dCallWaitID, byval timeout_time_ptr as const dThreadedWaitTime ptr, byval wait_name as const zstring ptr)
	retrieve_thread_count as function(byval impl as dThreadingImplementationID) as ulong
	preallocate_resources_for_calls as function(byval impl as dThreadingImplementationID, byval max_simultaneous_calls_estimate as ddependencycount_t) as long
end type

type dThreadingFunctionsInfo as dxThreadingFunctionsInfo
declare function dWorldCreate() as dWorldID
declare sub dWorldDestroy(byval world as dWorldID)
declare sub dWorldSetData(byval world as dWorldID, byval data as any ptr)
declare function dWorldGetData(byval world as dWorldID) as any ptr
declare sub dWorldSetGravity(byval as dWorldID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dWorldGetGravity(byval as dWorldID, byval gravity as dReal ptr)
declare sub dWorldSetERP(byval as dWorldID, byval erp as dReal)
declare function dWorldGetERP(byval as dWorldID) as dReal
declare sub dWorldSetCFM(byval as dWorldID, byval cfm as dReal)
declare function dWorldGetCFM(byval as dWorldID) as dReal
const dWORLDSTEP_THREADCOUNT_UNLIMITED = 0u
declare sub dWorldSetStepIslandsProcessingMaxThreadCount(byval w as dWorldID, byval count as ulong)
declare function dWorldGetStepIslandsProcessingMaxThreadCount(byval w as dWorldID) as ulong
declare function dWorldUseSharedWorkingMemory(byval w as dWorldID, byval from_world as dWorldID) as long
declare sub dWorldCleanupWorkingMemory(byval w as dWorldID)
const dWORLDSTEP_RESERVEFACTOR_DEFAULT = 1.2f
const dWORLDSTEP_RESERVESIZE_DEFAULT = 65536u

type dWorldStepReserveInfo
	struct_size as ulong
	reserve_factor as single
	reserve_minimum as ulong
end type

declare function dWorldSetStepMemoryReservationPolicy(byval w as dWorldID, byval policyinfo as const dWorldStepReserveInfo ptr) as long

type dWorldStepMemoryFunctionsInfo
	struct_size as ulong
	alloc_block as function(byval block_size as uinteger) as any ptr
	shrink_block as function(byval block_pointer as any ptr, byval block_current_size as uinteger, byval block_smaller_size as uinteger) as any ptr
	free_block as sub(byval block_pointer as any ptr, byval block_current_size as uinteger)
end type

declare function dWorldSetStepMemoryManager(byval w as dWorldID, byval memfuncs as const dWorldStepMemoryFunctionsInfo ptr) as long
declare sub dWorldSetStepThreadingImplementation(byval w as dWorldID, byval functions_info as const dThreadingFunctionsInfo ptr, byval threading_impl as dThreadingImplementationID)
declare function dWorldStep(byval w as dWorldID, byval stepsize as dReal) as long
declare function dWorldQuickStep(byval w as dWorldID, byval stepsize as dReal) as long
declare sub dWorldImpulseToForce(byval as dWorldID, byval stepsize as dReal, byval ix as dReal, byval iy as dReal, byval iz as dReal, byval force as dReal ptr)
declare sub dWorldSetQuickStepNumIterations(byval as dWorldID, byval num as long)
declare function dWorldGetQuickStepNumIterations(byval as dWorldID) as long
declare sub dWorldSetQuickStepW(byval as dWorldID, byval over_relaxation as dReal)
declare function dWorldGetQuickStepW(byval as dWorldID) as dReal
declare sub dWorldSetContactMaxCorrectingVel(byval as dWorldID, byval vel as dReal)
declare function dWorldGetContactMaxCorrectingVel(byval as dWorldID) as dReal
declare sub dWorldSetContactSurfaceLayer(byval as dWorldID, byval depth as dReal)
declare function dWorldGetContactSurfaceLayer(byval as dWorldID) as dReal
declare function dWorldGetAutoDisableLinearThreshold(byval as dWorldID) as dReal
declare sub dWorldSetAutoDisableLinearThreshold(byval as dWorldID, byval linear_threshold as dReal)
declare function dWorldGetAutoDisableAngularThreshold(byval as dWorldID) as dReal
declare sub dWorldSetAutoDisableAngularThreshold(byval as dWorldID, byval angular_threshold as dReal)
declare function dWorldGetAutoDisableLinearAverageThreshold(byval as dWorldID) as dReal
declare sub dWorldSetAutoDisableLinearAverageThreshold(byval as dWorldID, byval linear_average_threshold as dReal)
declare function dWorldGetAutoDisableAngularAverageThreshold(byval as dWorldID) as dReal
declare sub dWorldSetAutoDisableAngularAverageThreshold(byval as dWorldID, byval angular_average_threshold as dReal)
declare function dWorldGetAutoDisableAverageSamplesCount(byval as dWorldID) as long
declare sub dWorldSetAutoDisableAverageSamplesCount(byval as dWorldID, byval average_samples_count as ulong)
declare function dWorldGetAutoDisableSteps(byval as dWorldID) as long
declare sub dWorldSetAutoDisableSteps(byval as dWorldID, byval steps as long)
declare function dWorldGetAutoDisableTime(byval as dWorldID) as dReal
declare sub dWorldSetAutoDisableTime(byval as dWorldID, byval time as dReal)
declare function dWorldGetAutoDisableFlag(byval as dWorldID) as long
declare sub dWorldSetAutoDisableFlag(byval as dWorldID, byval do_auto_disable as long)
declare function dWorldGetLinearDampingThreshold(byval w as dWorldID) as dReal
declare sub dWorldSetLinearDampingThreshold(byval w as dWorldID, byval threshold as dReal)
declare function dWorldGetAngularDampingThreshold(byval w as dWorldID) as dReal
declare sub dWorldSetAngularDampingThreshold(byval w as dWorldID, byval threshold as dReal)
declare function dWorldGetLinearDamping(byval w as dWorldID) as dReal
declare sub dWorldSetLinearDamping(byval w as dWorldID, byval scale as dReal)
declare function dWorldGetAngularDamping(byval w as dWorldID) as dReal
declare sub dWorldSetAngularDamping(byval w as dWorldID, byval scale as dReal)
declare sub dWorldSetDamping(byval w as dWorldID, byval linear_scale as dReal, byval angular_scale as dReal)
declare function dWorldGetMaxAngularSpeed(byval w as dWorldID) as dReal
declare sub dWorldSetMaxAngularSpeed(byval w as dWorldID, byval max_speed as dReal)
declare function dBodyGetAutoDisableLinearThreshold(byval as dBodyID) as dReal
declare sub dBodySetAutoDisableLinearThreshold(byval as dBodyID, byval linear_average_threshold as dReal)
declare function dBodyGetAutoDisableAngularThreshold(byval as dBodyID) as dReal
declare sub dBodySetAutoDisableAngularThreshold(byval as dBodyID, byval angular_average_threshold as dReal)
declare function dBodyGetAutoDisableAverageSamplesCount(byval as dBodyID) as long
declare sub dBodySetAutoDisableAverageSamplesCount(byval as dBodyID, byval average_samples_count as ulong)
declare function dBodyGetAutoDisableSteps(byval as dBodyID) as long
declare sub dBodySetAutoDisableSteps(byval as dBodyID, byval steps as long)
declare function dBodyGetAutoDisableTime(byval as dBodyID) as dReal
declare sub dBodySetAutoDisableTime(byval as dBodyID, byval time as dReal)
declare function dBodyGetAutoDisableFlag(byval as dBodyID) as long
declare sub dBodySetAutoDisableFlag(byval as dBodyID, byval do_auto_disable as long)
declare sub dBodySetAutoDisableDefaults(byval as dBodyID)
declare function dBodyGetWorld(byval as dBodyID) as dWorldID
declare function dBodyCreate(byval as dWorldID) as dBodyID
declare sub dBodyDestroy(byval as dBodyID)
declare sub dBodySetData(byval as dBodyID, byval data as any ptr)
declare function dBodyGetData(byval as dBodyID) as any ptr
declare sub dBodySetPosition(byval as dBodyID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dBodySetRotation(byval as dBodyID, byval R as const dReal ptr)
declare sub dBodySetQuaternion(byval as dBodyID, byval q as const dReal ptr)
declare sub dBodySetLinearVel(byval as dBodyID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dBodySetAngularVel(byval as dBodyID, byval x as dReal, byval y as dReal, byval z as dReal)
declare function dBodyGetPosition(byval as dBodyID) as const dReal ptr
declare sub dBodyCopyPosition(byval body as dBodyID, byval pos as dReal ptr)
declare function dBodyGetRotation(byval as dBodyID) as const dReal ptr
declare sub dBodyCopyRotation(byval as dBodyID, byval R as dReal ptr)
declare function dBodyGetQuaternion(byval as dBodyID) as const dReal ptr
declare sub dBodyCopyQuaternion(byval body as dBodyID, byval quat as dReal ptr)
declare function dBodyGetLinearVel(byval as dBodyID) as const dReal ptr
declare function dBodyGetAngularVel(byval as dBodyID) as const dReal ptr
declare sub dBodySetMass(byval as dBodyID, byval mass as const dMass ptr)
declare sub dBodyGetMass(byval as dBodyID, byval mass as dMass ptr)
declare sub dBodyAddForce(byval as dBodyID, byval fx as dReal, byval fy as dReal, byval fz as dReal)
declare sub dBodyAddTorque(byval as dBodyID, byval fx as dReal, byval fy as dReal, byval fz as dReal)
declare sub dBodyAddRelForce(byval as dBodyID, byval fx as dReal, byval fy as dReal, byval fz as dReal)
declare sub dBodyAddRelTorque(byval as dBodyID, byval fx as dReal, byval fy as dReal, byval fz as dReal)
declare sub dBodyAddForceAtPos(byval as dBodyID, byval fx as dReal, byval fy as dReal, byval fz as dReal, byval px as dReal, byval py as dReal, byval pz as dReal)
declare sub dBodyAddForceAtRelPos(byval as dBodyID, byval fx as dReal, byval fy as dReal, byval fz as dReal, byval px as dReal, byval py as dReal, byval pz as dReal)
declare sub dBodyAddRelForceAtPos(byval as dBodyID, byval fx as dReal, byval fy as dReal, byval fz as dReal, byval px as dReal, byval py as dReal, byval pz as dReal)
declare sub dBodyAddRelForceAtRelPos(byval as dBodyID, byval fx as dReal, byval fy as dReal, byval fz as dReal, byval px as dReal, byval py as dReal, byval pz as dReal)
declare function dBodyGetForce(byval as dBodyID) as const dReal ptr
declare function dBodyGetTorque(byval as dBodyID) as const dReal ptr
declare sub dBodySetForce(byval b as dBodyID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dBodySetTorque(byval b as dBodyID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dBodyGetRelPointPos(byval as dBodyID, byval px as dReal, byval py as dReal, byval pz as dReal, byval result as dReal ptr)
declare sub dBodyGetRelPointVel(byval as dBodyID, byval px as dReal, byval py as dReal, byval pz as dReal, byval result as dReal ptr)
declare sub dBodyGetPointVel(byval as dBodyID, byval px as dReal, byval py as dReal, byval pz as dReal, byval result as dReal ptr)
declare sub dBodyGetPosRelPoint(byval as dBodyID, byval px as dReal, byval py as dReal, byval pz as dReal, byval result as dReal ptr)
declare sub dBodyVectorToWorld(byval as dBodyID, byval px as dReal, byval py as dReal, byval pz as dReal, byval result as dReal ptr)
declare sub dBodyVectorFromWorld(byval as dBodyID, byval px as dReal, byval py as dReal, byval pz as dReal, byval result as dReal ptr)
declare sub dBodySetFiniteRotationMode(byval as dBodyID, byval mode as long)
declare sub dBodySetFiniteRotationAxis(byval as dBodyID, byval x as dReal, byval y as dReal, byval z as dReal)
declare function dBodyGetFiniteRotationMode(byval as dBodyID) as long
declare sub dBodyGetFiniteRotationAxis(byval as dBodyID, byval result as dReal ptr)
declare function dBodyGetNumJoints(byval b as dBodyID) as long
declare function dBodyGetJoint(byval as dBodyID, byval index as long) as dJointID
declare sub dBodySetDynamic(byval as dBodyID)
declare sub dBodySetKinematic(byval as dBodyID)
declare function dBodyIsKinematic(byval as dBodyID) as long
declare sub dBodyEnable(byval as dBodyID)
declare sub dBodyDisable(byval as dBodyID)
declare function dBodyIsEnabled(byval as dBodyID) as long
declare sub dBodySetGravityMode(byval b as dBodyID, byval mode as long)
declare function dBodyGetGravityMode(byval b as dBodyID) as long
declare sub dBodySetMovedCallback(byval b as dBodyID, byval callback as sub(byval as dBodyID))
declare function dBodyGetFirstGeom(byval b as dBodyID) as dGeomID
declare function dBodyGetNextGeom(byval g as dGeomID) as dGeomID
declare sub dBodySetDampingDefaults(byval b as dBodyID)
declare function dBodyGetLinearDamping(byval b as dBodyID) as dReal
declare sub dBodySetLinearDamping(byval b as dBodyID, byval scale as dReal)
declare function dBodyGetAngularDamping(byval b as dBodyID) as dReal
declare sub dBodySetAngularDamping(byval b as dBodyID, byval scale as dReal)
declare sub dBodySetDamping(byval b as dBodyID, byval linear_scale as dReal, byval angular_scale as dReal)
declare function dBodyGetLinearDampingThreshold(byval b as dBodyID) as dReal
declare sub dBodySetLinearDampingThreshold(byval b as dBodyID, byval threshold as dReal)
declare function dBodyGetAngularDampingThreshold(byval b as dBodyID) as dReal
declare sub dBodySetAngularDampingThreshold(byval b as dBodyID, byval threshold as dReal)
declare function dBodyGetMaxAngularSpeed(byval b as dBodyID) as dReal
declare sub dBodySetMaxAngularSpeed(byval b as dBodyID, byval max_speed as dReal)
declare function dBodyGetGyroscopicMode(byval b as dBodyID) as long
declare sub dBodySetGyroscopicMode(byval b as dBodyID, byval enabled as long)
declare function dJointCreateBall(byval as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreateHinge(byval as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreateSlider(byval as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreateContact(byval as dWorldID, byval as dJointGroupID, byval as const dContact ptr) as dJointID
declare function dJointCreateHinge2(byval as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreateUniversal(byval as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreatePR(byval as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreatePU(byval as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreatePiston(byval as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreateFixed(byval as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreateNull(byval as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreateAMotor(byval as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreateLMotor(byval as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreatePlane2D(byval as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreateDBall(byval as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreateDHinge(byval as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreateTransmission(byval as dWorldID, byval as dJointGroupID) as dJointID
declare sub dJointDestroy(byval as dJointID)
declare function dJointGroupCreate(byval max_size as long) as dJointGroupID
declare sub dJointGroupDestroy(byval as dJointGroupID)
declare sub dJointGroupEmpty(byval as dJointGroupID)
declare function dJointGetNumBodies(byval as dJointID) as long
declare sub dJointAttach(byval as dJointID, byval body1 as dBodyID, byval body2 as dBodyID)
declare sub dJointEnable(byval as dJointID)
declare sub dJointDisable(byval as dJointID)
declare function dJointIsEnabled(byval as dJointID) as long
declare sub dJointSetData(byval as dJointID, byval data as any ptr)
declare function dJointGetData(byval as dJointID) as any ptr
declare function dJointGetType(byval as dJointID) as dJointType
declare function dJointGetBody(byval as dJointID, byval index as long) as dBodyID
declare sub dJointSetFeedback(byval as dJointID, byval as dJointFeedback ptr)
declare function dJointGetFeedback(byval as dJointID) as dJointFeedback ptr
declare sub dJointSetBallAnchor(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dJointSetBallAnchor2(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dJointSetBallParam(byval as dJointID, byval parameter as long, byval value as dReal)
declare sub dJointSetHingeAnchor(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dJointSetHingeAnchorDelta(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal, byval ax as dReal, byval ay as dReal, byval az as dReal)
declare sub dJointSetHingeAxis(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dJointSetHingeAxisOffset(byval j as dJointID, byval x as dReal, byval y as dReal, byval z as dReal, byval angle as dReal)
declare sub dJointSetHingeParam(byval as dJointID, byval parameter as long, byval value as dReal)
declare sub dJointAddHingeTorque(byval joint as dJointID, byval torque as dReal)
declare sub dJointSetSliderAxis(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dJointSetSliderAxisDelta(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal, byval ax as dReal, byval ay as dReal, byval az as dReal)
declare sub dJointSetSliderParam(byval as dJointID, byval parameter as long, byval value as dReal)
declare sub dJointAddSliderForce(byval joint as dJointID, byval force as dReal)
declare sub dJointSetHinge2Anchor(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dJointSetHinge2Axis1(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dJointSetHinge2Axis2(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dJointSetHinge2Param(byval as dJointID, byval parameter as long, byval value as dReal)
declare sub dJointAddHinge2Torques(byval joint as dJointID, byval torque1 as dReal, byval torque2 as dReal)
declare sub dJointSetUniversalAnchor(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dJointSetUniversalAxis1(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dJointSetUniversalAxis1Offset(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal, byval offset1 as dReal, byval offset2 as dReal)
declare sub dJointSetUniversalAxis2(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dJointSetUniversalAxis2Offset(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal, byval offset1 as dReal, byval offset2 as dReal)
declare sub dJointSetUniversalParam(byval as dJointID, byval parameter as long, byval value as dReal)
declare sub dJointAddUniversalTorques(byval joint as dJointID, byval torque1 as dReal, byval torque2 as dReal)
declare sub dJointSetPRAnchor(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dJointSetPRAxis1(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dJointSetPRAxis2(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dJointSetPRParam(byval as dJointID, byval parameter as long, byval value as dReal)
declare sub dJointAddPRTorque(byval j as dJointID, byval torque as dReal)
declare sub dJointSetPUAnchor(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dJointSetPUAnchorDelta(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal, byval dx as dReal, byval dy as dReal, byval dz as dReal)
declare sub dJointSetPUAnchorOffset(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal, byval dx as dReal, byval dy as dReal, byval dz as dReal)
declare sub dJointSetPUAxis1(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dJointSetPUAxis2(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dJointSetPUAxis3(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dJointSetPUAxisP(byval id as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dJointSetPUParam(byval as dJointID, byval parameter as long, byval value as dReal)
declare sub dJointAddPUTorque(byval j as dJointID, byval torque as dReal)
declare sub dJointSetPistonAnchor(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dJointSetPistonAnchorOffset(byval j as dJointID, byval x as dReal, byval y as dReal, byval z as dReal, byval dx as dReal, byval dy as dReal, byval dz as dReal)
declare sub dJointSetPistonAxis(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dJointSetPistonAxisDelta(byval j as dJointID, byval x as dReal, byval y as dReal, byval z as dReal, byval ax as dReal, byval ay as dReal, byval az as dReal)
declare sub dJointSetPistonParam(byval as dJointID, byval parameter as long, byval value as dReal)
declare sub dJointAddPistonForce(byval joint as dJointID, byval force as dReal)
declare sub dJointSetFixed(byval as dJointID)
declare sub dJointSetFixedParam(byval as dJointID, byval parameter as long, byval value as dReal)
declare sub dJointSetAMotorNumAxes(byval as dJointID, byval num as long)
declare sub dJointSetAMotorAxis(byval as dJointID, byval anum as long, byval rel as long, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dJointSetAMotorAngle(byval as dJointID, byval anum as long, byval angle as dReal)
declare sub dJointSetAMotorParam(byval as dJointID, byval parameter as long, byval value as dReal)
declare sub dJointSetAMotorMode(byval as dJointID, byval mode as long)
declare sub dJointAddAMotorTorques(byval as dJointID, byval torque1 as dReal, byval torque2 as dReal, byval torque3 as dReal)
declare sub dJointSetLMotorNumAxes(byval as dJointID, byval num as long)
declare sub dJointSetLMotorAxis(byval as dJointID, byval anum as long, byval rel as long, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dJointSetLMotorParam(byval as dJointID, byval parameter as long, byval value as dReal)
declare sub dJointSetPlane2DXParam(byval as dJointID, byval parameter as long, byval value as dReal)
declare sub dJointSetPlane2DYParam(byval as dJointID, byval parameter as long, byval value as dReal)
declare sub dJointSetPlane2DAngleParam(byval as dJointID, byval parameter as long, byval value as dReal)
declare sub dJointGetBallAnchor(byval as dJointID, byval result as dReal ptr)
declare sub dJointGetBallAnchor2(byval as dJointID, byval result as dReal ptr)
declare function dJointGetBallParam(byval as dJointID, byval parameter as long) as dReal
declare sub dJointGetHingeAnchor(byval as dJointID, byval result as dReal ptr)
declare sub dJointGetHingeAnchor2(byval as dJointID, byval result as dReal ptr)
declare sub dJointGetHingeAxis(byval as dJointID, byval result as dReal ptr)
declare function dJointGetHingeParam(byval as dJointID, byval parameter as long) as dReal
declare function dJointGetHingeAngle(byval as dJointID) as dReal
declare function dJointGetHingeAngleRate(byval as dJointID) as dReal
declare function dJointGetSliderPosition(byval as dJointID) as dReal
declare function dJointGetSliderPositionRate(byval as dJointID) as dReal
declare sub dJointGetSliderAxis(byval as dJointID, byval result as dReal ptr)
declare function dJointGetSliderParam(byval as dJointID, byval parameter as long) as dReal
declare sub dJointGetHinge2Anchor(byval as dJointID, byval result as dReal ptr)
declare sub dJointGetHinge2Anchor2(byval as dJointID, byval result as dReal ptr)
declare sub dJointGetHinge2Axis1(byval as dJointID, byval result as dReal ptr)
declare sub dJointGetHinge2Axis2(byval as dJointID, byval result as dReal ptr)
declare function dJointGetHinge2Param(byval as dJointID, byval parameter as long) as dReal
declare function dJointGetHinge2Angle1(byval as dJointID) as dReal
declare function dJointGetHinge2Angle2(byval as dJointID) as dReal
declare function dJointGetHinge2Angle1Rate(byval as dJointID) as dReal
declare function dJointGetHinge2Angle2Rate(byval as dJointID) as dReal
declare sub dJointGetUniversalAnchor(byval as dJointID, byval result as dReal ptr)
declare sub dJointGetUniversalAnchor2(byval as dJointID, byval result as dReal ptr)
declare sub dJointGetUniversalAxis1(byval as dJointID, byval result as dReal ptr)
declare sub dJointGetUniversalAxis2(byval as dJointID, byval result as dReal ptr)
declare function dJointGetUniversalParam(byval as dJointID, byval parameter as long) as dReal
declare sub dJointGetUniversalAngles(byval as dJointID, byval angle1 as dReal ptr, byval angle2 as dReal ptr)
declare function dJointGetUniversalAngle1(byval as dJointID) as dReal
declare function dJointGetUniversalAngle2(byval as dJointID) as dReal
declare function dJointGetUniversalAngle1Rate(byval as dJointID) as dReal
declare function dJointGetUniversalAngle2Rate(byval as dJointID) as dReal
declare sub dJointGetPRAnchor(byval as dJointID, byval result as dReal ptr)
declare function dJointGetPRPosition(byval as dJointID) as dReal
declare function dJointGetPRPositionRate(byval as dJointID) as dReal
declare function dJointGetPRAngle(byval as dJointID) as dReal
declare function dJointGetPRAngleRate(byval as dJointID) as dReal
declare sub dJointGetPRAxis1(byval as dJointID, byval result as dReal ptr)
declare sub dJointGetPRAxis2(byval as dJointID, byval result as dReal ptr)
declare function dJointGetPRParam(byval as dJointID, byval parameter as long) as dReal
declare sub dJointGetPUAnchor(byval as dJointID, byval result as dReal ptr)
declare function dJointGetPUPosition(byval as dJointID) as dReal
declare function dJointGetPUPositionRate(byval as dJointID) as dReal
declare sub dJointGetPUAxis1(byval as dJointID, byval result as dReal ptr)
declare sub dJointGetPUAxis2(byval as dJointID, byval result as dReal ptr)
declare sub dJointGetPUAxis3(byval as dJointID, byval result as dReal ptr)
declare sub dJointGetPUAxisP(byval id as dJointID, byval result as dReal ptr)
declare sub dJointGetPUAngles(byval as dJointID, byval angle1 as dReal ptr, byval angle2 as dReal ptr)
declare function dJointGetPUAngle1(byval as dJointID) as dReal
declare function dJointGetPUAngle1Rate(byval as dJointID) as dReal
declare function dJointGetPUAngle2(byval as dJointID) as dReal
declare function dJointGetPUAngle2Rate(byval as dJointID) as dReal
declare function dJointGetPUParam(byval as dJointID, byval parameter as long) as dReal
declare function dJointGetPistonPosition(byval as dJointID) as dReal
declare function dJointGetPistonPositionRate(byval as dJointID) as dReal
declare function dJointGetPistonAngle(byval as dJointID) as dReal
declare function dJointGetPistonAngleRate(byval as dJointID) as dReal
declare sub dJointGetPistonAnchor(byval as dJointID, byval result as dReal ptr)
declare sub dJointGetPistonAnchor2(byval as dJointID, byval result as dReal ptr)
declare sub dJointGetPistonAxis(byval as dJointID, byval result as dReal ptr)
declare function dJointGetPistonParam(byval as dJointID, byval parameter as long) as dReal
declare function dJointGetAMotorNumAxes(byval as dJointID) as long
declare sub dJointGetAMotorAxis(byval as dJointID, byval anum as long, byval result as dReal ptr)
declare function dJointGetAMotorAxisRel(byval as dJointID, byval anum as long) as long
declare function dJointGetAMotorAngle(byval as dJointID, byval anum as long) as dReal
declare function dJointGetAMotorAngleRate(byval as dJointID, byval anum as long) as dReal
declare function dJointGetAMotorParam(byval as dJointID, byval parameter as long) as dReal
declare function dJointGetAMotorMode(byval as dJointID) as long
declare function dJointGetLMotorNumAxes(byval as dJointID) as long
declare sub dJointGetLMotorAxis(byval as dJointID, byval anum as long, byval result as dReal ptr)
declare function dJointGetLMotorParam(byval as dJointID, byval parameter as long) as dReal
declare function dJointGetFixedParam(byval as dJointID, byval parameter as long) as dReal
declare sub dJointGetTransmissionContactPoint1(byval as dJointID, byval result as dReal ptr)
declare sub dJointGetTransmissionContactPoint2(byval as dJointID, byval result as dReal ptr)
declare sub dJointSetTransmissionAxis1(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dJointGetTransmissionAxis1(byval as dJointID, byval result as dReal ptr)
declare sub dJointSetTransmissionAxis2(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dJointGetTransmissionAxis2(byval as dJointID, byval result as dReal ptr)
declare sub dJointSetTransmissionAnchor1(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dJointGetTransmissionAnchor1(byval as dJointID, byval result as dReal ptr)
declare sub dJointSetTransmissionAnchor2(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dJointGetTransmissionAnchor2(byval as dJointID, byval result as dReal ptr)
declare sub dJointSetTransmissionParam(byval as dJointID, byval parameter as long, byval value as dReal)
declare function dJointGetTransmissionParam(byval as dJointID, byval parameter as long) as dReal
declare sub dJointSetTransmissionMode(byval j as dJointID, byval mode as long)
declare function dJointGetTransmissionMode(byval j as dJointID) as long
declare sub dJointSetTransmissionRatio(byval j as dJointID, byval ratio as dReal)
declare function dJointGetTransmissionRatio(byval j as dJointID) as dReal
declare sub dJointSetTransmissionAxis(byval j as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dJointGetTransmissionAxis(byval j as dJointID, byval result as dReal ptr)
declare function dJointGetTransmissionAngle1(byval j as dJointID) as dReal
declare function dJointGetTransmissionAngle2(byval j as dJointID) as dReal
declare function dJointGetTransmissionRadius1(byval j as dJointID) as dReal
declare function dJointGetTransmissionRadius2(byval j as dJointID) as dReal
declare sub dJointSetTransmissionRadius1(byval j as dJointID, byval radius as dReal)
declare sub dJointSetTransmissionRadius2(byval j as dJointID, byval radius as dReal)
declare function dJointGetTransmissionBacklash(byval j as dJointID) as dReal
declare sub dJointSetTransmissionBacklash(byval j as dJointID, byval backlash as dReal)
declare sub dJointSetDBallAnchor1(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dJointSetDBallAnchor2(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dJointGetDBallAnchor1(byval as dJointID, byval result as dReal ptr)
declare sub dJointGetDBallAnchor2(byval as dJointID, byval result as dReal ptr)
declare function dJointGetDBallDistance(byval as dJointID) as dReal
declare sub dJointSetDBallParam(byval as dJointID, byval parameter as long, byval value as dReal)
declare function dJointGetDBallParam(byval as dJointID, byval parameter as long) as dReal
declare sub dJointSetDHingeAxis(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dJointGetDHingeAxis(byval as dJointID, byval result as dReal ptr)
declare sub dJointSetDHingeAnchor1(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dJointSetDHingeAnchor2(byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dJointGetDHingeAnchor1(byval as dJointID, byval result as dReal ptr)
declare sub dJointGetDHingeAnchor2(byval as dJointID, byval result as dReal ptr)
declare function dJointGetDHingeDistance(byval as dJointID) as dReal
declare sub dJointSetDHingeParam(byval as dJointID, byval parameter as long, byval value as dReal)
declare function dJointGetDHingeParam(byval as dJointID, byval parameter as long) as dReal
declare function dConnectingJoint(byval as dBodyID, byval as dBodyID) as dJointID
declare function dConnectingJointList(byval as dBodyID, byval as dBodyID, byval as dJointID ptr) as long
declare function dAreConnected(byval as dBodyID, byval as dBodyID) as long
declare function dAreConnectedExcluding(byval body1 as dBodyID, byval body2 as dBodyID, byval joint_type as long) as long
#define _ODE_COLLISION_SPACE_H_
declare function dSimpleSpaceCreate(byval space as dSpaceID) as dSpaceID
declare function dHashSpaceCreate(byval space as dSpaceID) as dSpaceID
declare function dQuadTreeSpaceCreate(byval space as dSpaceID, byval Center as const dReal ptr, byval Extents as const dReal ptr, byval Depth as long) as dSpaceID

const dSAP_AXES_XYZ = (0 or (1 shl 2)) or (2 shl 4)
const dSAP_AXES_XZY = (0 or (2 shl 2)) or (1 shl 4)
const dSAP_AXES_YXZ = (1 or (0 shl 2)) or (2 shl 4)
const dSAP_AXES_YZX = (1 or (2 shl 2)) or (0 shl 4)
const dSAP_AXES_ZXY = (2 or (0 shl 2)) or (1 shl 4)
const dSAP_AXES_ZYX = (2 or (1 shl 2)) or (0 shl 4)

declare function dSweepAndPruneSpaceCreate(byval space as dSpaceID, byval axisorder as long) as dSpaceID
declare sub dSpaceDestroy(byval as dSpaceID)
declare sub dHashSpaceSetLevels(byval space as dSpaceID, byval minlevel as long, byval maxlevel as long)
declare sub dHashSpaceGetLevels(byval space as dSpaceID, byval minlevel as long ptr, byval maxlevel as long ptr)
declare sub dSpaceSetCleanup(byval space as dSpaceID, byval mode as long)
declare function dSpaceGetCleanup(byval space as dSpaceID) as long
declare sub dSpaceSetSublevel(byval space as dSpaceID, byval sublevel as long)
declare function dSpaceGetSublevel(byval space as dSpaceID) as long
declare sub dSpaceSetManualCleanup(byval space as dSpaceID, byval mode as long)
declare function dSpaceGetManualCleanup(byval space as dSpaceID) as long
declare sub dSpaceAdd(byval as dSpaceID, byval as dGeomID)
declare sub dSpaceRemove(byval as dSpaceID, byval as dGeomID)
declare function dSpaceQuery(byval as dSpaceID, byval as dGeomID) as long
declare sub dSpaceClean(byval as dSpaceID)
declare function dSpaceGetNumGeoms(byval as dSpaceID) as long
declare function dSpaceGetGeom(byval as dSpaceID, byval i as long) as dGeomID
declare function dSpaceGetClass(byval space as dSpaceID) as long
#define _ODE_COLLISION_H_
declare sub dGeomDestroy(byval geom as dGeomID)
declare sub dGeomSetData(byval geom as dGeomID, byval data as any ptr)
declare function dGeomGetData(byval geom as dGeomID) as any ptr
declare sub dGeomSetBody(byval geom as dGeomID, byval body as dBodyID)
declare function dGeomGetBody(byval geom as dGeomID) as dBodyID
declare sub dGeomSetPosition(byval geom as dGeomID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dGeomSetRotation(byval geom as dGeomID, byval R as const dReal ptr)
declare sub dGeomSetQuaternion(byval geom as dGeomID, byval Q as const dReal ptr)
declare function dGeomGetPosition(byval geom as dGeomID) as const dReal ptr
declare sub dGeomCopyPosition(byval geom as dGeomID, byval pos as dReal ptr)
declare function dGeomGetRotation(byval geom as dGeomID) as const dReal ptr
declare sub dGeomCopyRotation(byval geom as dGeomID, byval R as dReal ptr)
declare sub dGeomGetQuaternion(byval geom as dGeomID, byval result as dReal ptr)
declare sub dGeomGetAABB(byval geom as dGeomID, byval aabb as dReal ptr)
declare function dGeomIsSpace(byval geom as dGeomID) as long
declare function dGeomGetSpace(byval as dGeomID) as dSpaceID
declare function dGeomGetClass(byval geom as dGeomID) as long
declare sub dGeomSetCategoryBits(byval geom as dGeomID, byval bits as culong)
declare sub dGeomSetCollideBits(byval geom as dGeomID, byval bits as culong)
declare function dGeomGetCategoryBits(byval as dGeomID) as culong
declare function dGeomGetCollideBits(byval as dGeomID) as culong
declare sub dGeomEnable(byval geom as dGeomID)
declare sub dGeomDisable(byval geom as dGeomID)
declare function dGeomIsEnabled(byval geom as dGeomID) as long

enum
	dGeomCommonControlClass = 0
	dGeomColliderControlClass = 1
end enum

enum
	dGeomCommonAnyControlCode = 0
	dGeomColliderSetMergeSphereContactsControlCode = 1
	dGeomColliderGetMergeSphereContactsControlCode = 2
end enum

enum
	dGeomColliderMergeContactsValue__Default = 0
	dGeomColliderMergeContactsValue_None = 1
	dGeomColliderMergeContactsValue_Normals = 2
	dGeomColliderMergeContactsValue_Full = 3
end enum

declare function dGeomLowLevelControl(byval geom as dGeomID, byval controlClass as long, byval controlCode as long, byval dataValue as any ptr, byval dataSize as long ptr) as long
declare sub dGeomGetRelPointPos(byval geom as dGeomID, byval px as dReal, byval py as dReal, byval pz as dReal, byval result as dReal ptr)
declare sub dGeomGetPosRelPoint(byval geom as dGeomID, byval px as dReal, byval py as dReal, byval pz as dReal, byval result as dReal ptr)
declare sub dGeomVectorToWorld(byval geom as dGeomID, byval px as dReal, byval py as dReal, byval pz as dReal, byval result as dReal ptr)
declare sub dGeomVectorFromWorld(byval geom as dGeomID, byval px as dReal, byval py as dReal, byval pz as dReal, byval result as dReal ptr)
declare sub dGeomSetOffsetPosition(byval geom as dGeomID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dGeomSetOffsetRotation(byval geom as dGeomID, byval R as const dReal ptr)
declare sub dGeomSetOffsetQuaternion(byval geom as dGeomID, byval Q as const dReal ptr)
declare sub dGeomSetOffsetWorldPosition(byval geom as dGeomID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dGeomSetOffsetWorldRotation(byval geom as dGeomID, byval R as const dReal ptr)
declare sub dGeomSetOffsetWorldQuaternion(byval geom as dGeomID, byval as const dReal ptr)
declare sub dGeomClearOffset(byval geom as dGeomID)
declare function dGeomIsOffset(byval geom as dGeomID) as long
declare function dGeomGetOffsetPosition(byval geom as dGeomID) as const dReal ptr
declare sub dGeomCopyOffsetPosition(byval geom as dGeomID, byval pos as dReal ptr)
declare function dGeomGetOffsetRotation(byval geom as dGeomID) as const dReal ptr
declare sub dGeomCopyOffsetRotation(byval geom as dGeomID, byval R as dReal ptr)
declare sub dGeomGetOffsetQuaternion(byval geom as dGeomID, byval result as dReal ptr)
const CONTACTS_UNIMPORTANT = &h80000000
declare function dCollide(byval o1 as dGeomID, byval o2 as dGeomID, byval flags as long, byval contact as dContactGeom ptr, byval skip as long) as long
declare sub dSpaceCollide(byval space as dSpaceID, byval data as any ptr, byval callback as sub(byval data as any ptr, byval o1 as dGeomID, byval o2 as dGeomID))
declare sub dSpaceCollide2(byval space1 as dGeomID, byval space2 as dGeomID, byval data as any ptr, byval callback as sub(byval data as any ptr, byval o1 as dGeomID, byval o2 as dGeomID))

enum
	dMaxUserClasses = 4
end enum

enum
	dSphereClass = 0
	dBoxClass
	dCapsuleClass
	dCylinderClass
	dPlaneClass
	dRayClass
	dConvexClass
	dGeomTransformClass
	dTriMeshClass
	dHeightfieldClass
	dFirstSpaceClass
	dSimpleSpaceClass = dFirstSpaceClass
	dHashSpaceClass
	dSweepAndPruneSpaceClass
	dQuadTreeSpaceClass
	dLastSpaceClass = dQuadTreeSpaceClass
	dFirstUserClass
	dLastUserClass = (dFirstUserClass + dMaxUserClasses) - 1
	dGeomNumClasses
end enum

declare function dCreateSphere(byval space as dSpaceID, byval radius as dReal) as dGeomID
declare sub dGeomSphereSetRadius(byval sphere as dGeomID, byval radius as dReal)
declare function dGeomSphereGetRadius(byval sphere as dGeomID) as dReal
declare function dGeomSpherePointDepth(byval sphere as dGeomID, byval x as dReal, byval y as dReal, byval z as dReal) as dReal
declare function dCreateConvex(byval space as dSpaceID, byval _planes as dReal ptr, byval _planecount as ulong, byval _points as dReal ptr, byval _pointcount as ulong, byval _polygons as ulong ptr) as dGeomID
declare sub dGeomSetConvex(byval g as dGeomID, byval _planes as dReal ptr, byval _count as ulong, byval _points as dReal ptr, byval _pointcount as ulong, byval _polygons as ulong ptr)
declare function dCreateBox(byval space as dSpaceID, byval lx as dReal, byval ly as dReal, byval lz as dReal) as dGeomID
declare sub dGeomBoxSetLengths(byval box as dGeomID, byval lx as dReal, byval ly as dReal, byval lz as dReal)
declare sub dGeomBoxGetLengths(byval box as dGeomID, byval result as dReal ptr)
declare function dGeomBoxPointDepth(byval box as dGeomID, byval x as dReal, byval y as dReal, byval z as dReal) as dReal
declare function dCreatePlane(byval space as dSpaceID, byval a as dReal, byval b as dReal, byval c as dReal, byval d as dReal) as dGeomID
declare sub dGeomPlaneSetParams(byval plane as dGeomID, byval a as dReal, byval b as dReal, byval c as dReal, byval d as dReal)
declare sub dGeomPlaneGetParams(byval plane as dGeomID, byval result as dReal ptr)
declare function dGeomPlanePointDepth(byval plane as dGeomID, byval x as dReal, byval y as dReal, byval z as dReal) as dReal
declare function dCreateCapsule(byval space as dSpaceID, byval radius as dReal, byval length as dReal) as dGeomID
declare sub dGeomCapsuleSetParams(byval ccylinder as dGeomID, byval radius as dReal, byval length as dReal)
declare sub dGeomCapsuleGetParams(byval ccylinder as dGeomID, byval radius as dReal ptr, byval length as dReal ptr)
declare function dGeomCapsulePointDepth(byval ccylinder as dGeomID, byval x as dReal, byval y as dReal, byval z as dReal) as dReal
declare function dCreateCCylinder alias "dCreateCapsule"(byval space as dSpaceID, byval radius as dReal, byval length as dReal) as dGeomID
declare sub dGeomCCylinderSetParams alias "dGeomCapsuleSetParams"(byval ccylinder as dGeomID, byval radius as dReal, byval length as dReal)
declare sub dGeomCCylinderGetParams alias "dGeomCapsuleGetParams"(byval ccylinder as dGeomID, byval radius as dReal ptr, byval length as dReal ptr)
declare function dGeomCCylinderPointDepth alias "dGeomCapsulePointDepth"(byval ccylinder as dGeomID, byval x as dReal, byval y as dReal, byval z as dReal) as dReal
const dCCylinderClass = dCapsuleClass
declare function dCreateCylinder(byval space as dSpaceID, byval radius as dReal, byval length as dReal) as dGeomID
declare sub dGeomCylinderSetParams(byval cylinder as dGeomID, byval radius as dReal, byval length as dReal)
declare sub dGeomCylinderGetParams(byval cylinder as dGeomID, byval radius as dReal ptr, byval length as dReal ptr)
declare function dCreateRay(byval space as dSpaceID, byval length as dReal) as dGeomID
declare sub dGeomRaySetLength(byval ray as dGeomID, byval length as dReal)
declare function dGeomRayGetLength(byval ray as dGeomID) as dReal
declare sub dGeomRaySet(byval ray as dGeomID, byval px as dReal, byval py as dReal, byval pz as dReal, byval dx as dReal, byval dy as dReal, byval dz as dReal)
declare sub dGeomRayGet(byval ray as dGeomID, byval start as dReal ptr, byval dir as dReal ptr)
declare sub dGeomRaySetParams(byval g as dGeomID, byval FirstContact as long, byval BackfaceCull as long)
declare sub dGeomRayGetParams(byval g as dGeomID, byval FirstContact as long ptr, byval BackfaceCull as long ptr)
declare sub dGeomRaySetFirstContact(byval g as dGeomID, byval firstContact as long)
declare function dGeomRayGetFirstContact(byval g as dGeomID) as long
declare sub dGeomRaySetBackfaceCull(byval g as dGeomID, byval backfaceCull as long)
declare function dGeomRayGetBackfaceCull(byval g as dGeomID) as long
declare sub dGeomRaySetClosestHit(byval g as dGeomID, byval closestHit as long)
declare function dGeomRayGetClosestHit(byval g as dGeomID) as long
#define _ODE_COLLISION_TRIMESH_H_
type dTriMeshDataID as dxTriMeshData ptr
declare function dGeomTriMeshDataCreate() as dTriMeshDataID
declare sub dGeomTriMeshDataDestroy(byval g as dTriMeshDataID)

enum
	TRIMESH_FACE_NORMALS
end enum

declare sub dGeomTriMeshDataSet(byval g as dTriMeshDataID, byval data_id as long, byval in_data as any ptr)
declare function dGeomTriMeshDataGet(byval g as dTriMeshDataID, byval data_id as long) as any ptr
declare sub dGeomTriMeshSetLastTransform(byval g as dGeomID, byval last_trans as dReal ptr)
declare function dGeomTriMeshGetLastTransform(byval g as dGeomID) as dReal ptr
declare sub dGeomTriMeshDataBuildSingle(byval g as dTriMeshDataID, byval Vertices as const any ptr, byval VertexStride as long, byval VertexCount as long, byval Indices as const any ptr, byval IndexCount as long, byval TriStride as long)
declare sub dGeomTriMeshDataBuildSingle1(byval g as dTriMeshDataID, byval Vertices as const any ptr, byval VertexStride as long, byval VertexCount as long, byval Indices as const any ptr, byval IndexCount as long, byval TriStride as long, byval Normals as const any ptr)
declare sub dGeomTriMeshDataBuildDouble(byval g as dTriMeshDataID, byval Vertices as const any ptr, byval VertexStride as long, byval VertexCount as long, byval Indices as const any ptr, byval IndexCount as long, byval TriStride as long)
declare sub dGeomTriMeshDataBuildDouble1(byval g as dTriMeshDataID, byval Vertices as const any ptr, byval VertexStride as long, byval VertexCount as long, byval Indices as const any ptr, byval IndexCount as long, byval TriStride as long, byval Normals as const any ptr)
declare sub dGeomTriMeshDataBuildSimple(byval g as dTriMeshDataID, byval Vertices as const dReal ptr, byval VertexCount as long, byval Indices as const dTriIndex ptr, byval IndexCount as long)
declare sub dGeomTriMeshDataBuildSimple1(byval g as dTriMeshDataID, byval Vertices as const dReal ptr, byval VertexCount as long, byval Indices as const dTriIndex ptr, byval IndexCount as long, byval Normals as const long ptr)
declare sub dGeomTriMeshDataPreprocess(byval g as dTriMeshDataID)
declare sub dGeomTriMeshDataGetBuffer(byval g as dTriMeshDataID, byval buf as ubyte ptr ptr, byval bufLen as long ptr)
declare sub dGeomTriMeshDataSetBuffer(byval g as dTriMeshDataID, byval buf as ubyte ptr)
declare sub dGeomTriMeshSetCallback(byval g as dGeomID, byval Callback as function(byval TriMesh as dGeomID, byval RefObject as dGeomID, byval TriangleIndex as long) as long)
declare function dGeomTriMeshGetCallback(byval g as dGeomID) as function(byval TriMesh as dGeomID, byval RefObject as dGeomID, byval TriangleIndex as long) as long
declare sub dGeomTriMeshSetArrayCallback(byval g as dGeomID, byval ArrayCallback as sub(byval TriMesh as dGeomID, byval RefObject as dGeomID, byval TriIndices as const long ptr, byval TriCount as long))
declare function dGeomTriMeshGetArrayCallback(byval g as dGeomID) as sub(byval TriMesh as dGeomID, byval RefObject as dGeomID, byval TriIndices as const long ptr, byval TriCount as long)
declare sub dGeomTriMeshSetRayCallback(byval g as dGeomID, byval Callback as function(byval TriMesh as dGeomID, byval Ray as dGeomID, byval TriangleIndex as long, byval u as dReal, byval v as dReal) as long)
declare function dGeomTriMeshGetRayCallback(byval g as dGeomID) as function(byval TriMesh as dGeomID, byval Ray as dGeomID, byval TriangleIndex as long, byval u as dReal, byval v as dReal) as long
declare sub dGeomTriMeshSetTriMergeCallback(byval g as dGeomID, byval Callback as function(byval TriMesh as dGeomID, byval FirstTriangleIndex as long, byval SecondTriangleIndex as long) as long)
declare function dGeomTriMeshGetTriMergeCallback(byval g as dGeomID) as function(byval TriMesh as dGeomID, byval FirstTriangleIndex as long, byval SecondTriangleIndex as long) as long
declare function dCreateTriMesh(byval space as dSpaceID, byval Data as dTriMeshDataID, byval Callback as function(byval TriMesh as dGeomID, byval RefObject as dGeomID, byval TriangleIndex as long) as long, byval ArrayCallback as sub(byval TriMesh as dGeomID, byval RefObject as dGeomID, byval TriIndices as const long ptr, byval TriCount as long), byval RayCallback as function(byval TriMesh as dGeomID, byval Ray as dGeomID, byval TriangleIndex as long, byval u as dReal, byval v as dReal) as long) as dGeomID
declare sub dGeomTriMeshSetData(byval g as dGeomID, byval Data as dTriMeshDataID)
declare function dGeomTriMeshGetData(byval g as dGeomID) as dTriMeshDataID
declare sub dGeomTriMeshEnableTC(byval g as dGeomID, byval geomClass as long, byval enable as long)
declare function dGeomTriMeshIsTCEnabled(byval g as dGeomID, byval geomClass as long) as long
declare sub dGeomTriMeshClearTCCache(byval g as dGeomID)
declare function dGeomTriMeshGetTriMeshDataID(byval g as dGeomID) as dTriMeshDataID
declare sub dGeomTriMeshGetTriangle(byval g as dGeomID, byval Index as long, byval v0 as dReal ptr, byval v1 as dReal ptr, byval v2 as dReal ptr)
declare sub dGeomTriMeshGetPoint(byval g as dGeomID, byval Index as long, byval u as dReal, byval v as dReal, byval Out as dReal ptr)
declare function dGeomTriMeshGetTriangleCount(byval g as dGeomID) as long
declare sub dGeomTriMeshDataUpdate(byval g as dTriMeshDataID)
declare function dCreateGeomTransform(byval space as dSpaceID) as dGeomID
declare sub dGeomTransformSetGeom(byval g as dGeomID, byval obj as dGeomID)
declare function dGeomTransformGetGeom(byval g as dGeomID) as dGeomID
declare sub dGeomTransformSetCleanup(byval g as dGeomID, byval mode as long)
declare function dGeomTransformGetCleanup(byval g as dGeomID) as long
declare sub dGeomTransformSetInfo(byval g as dGeomID, byval mode as long)
declare function dGeomTransformGetInfo(byval g as dGeomID) as long
type dHeightfieldDataID as dxHeightfieldData ptr
declare function dCreateHeightfield(byval space as dSpaceID, byval data as dHeightfieldDataID, byval bPlaceable as long) as dGeomID
declare function dGeomHeightfieldDataCreate() as dHeightfieldDataID
declare sub dGeomHeightfieldDataDestroy(byval d as dHeightfieldDataID)
declare sub dGeomHeightfieldDataBuildCallback(byval d as dHeightfieldDataID, byval pUserData as any ptr, byval pCallback as function(byval p_user_data as any ptr, byval x as long, byval z as long) as dReal, byval width as dReal, byval depth as dReal, byval widthSamples as long, byval depthSamples as long, byval scale as dReal, byval offset as dReal, byval thickness as dReal, byval bWrap as long)
declare sub dGeomHeightfieldDataBuildByte(byval d as dHeightfieldDataID, byval pHeightData as const ubyte ptr, byval bCopyHeightData as long, byval width as dReal, byval depth as dReal, byval widthSamples as long, byval depthSamples as long, byval scale as dReal, byval offset as dReal, byval thickness as dReal, byval bWrap as long)
declare sub dGeomHeightfieldDataBuildShort(byval d as dHeightfieldDataID, byval pHeightData as const short ptr, byval bCopyHeightData as long, byval width as dReal, byval depth as dReal, byval widthSamples as long, byval depthSamples as long, byval scale as dReal, byval offset as dReal, byval thickness as dReal, byval bWrap as long)
declare sub dGeomHeightfieldDataBuildSingle(byval d as dHeightfieldDataID, byval pHeightData as const single ptr, byval bCopyHeightData as long, byval width as dReal, byval depth as dReal, byval widthSamples as long, byval depthSamples as long, byval scale as dReal, byval offset as dReal, byval thickness as dReal, byval bWrap as long)
declare sub dGeomHeightfieldDataBuildDouble(byval d as dHeightfieldDataID, byval pHeightData as const double ptr, byval bCopyHeightData as long, byval width as dReal, byval depth as dReal, byval widthSamples as long, byval depthSamples as long, byval scale as dReal, byval offset as dReal, byval thickness as dReal, byval bWrap as long)
declare sub dGeomHeightfieldDataSetBounds(byval d as dHeightfieldDataID, byval minHeight as dReal, byval maxHeight as dReal)
declare sub dGeomHeightfieldSetHeightfieldData(byval g as dGeomID, byval d as dHeightfieldDataID)
declare function dGeomHeightfieldGetHeightfieldData(byval g as dGeomID) as dHeightfieldDataID
declare sub dClosestLineSegmentPoints(byval a1 as const dReal ptr, byval a2 as const dReal ptr, byval b1 as const dReal ptr, byval b2 as const dReal ptr, byval cp1 as dReal ptr, byval cp2 as dReal ptr)
declare function dBoxTouchesBox(byval _p1 as const dReal ptr, byval R1 as const dReal ptr, byval side1 as const dReal ptr, byval _p2 as const dReal ptr, byval R2 as const dReal ptr, byval side2 as const dReal ptr) as long
declare function dBoxBox(byval p1 as const dReal ptr, byval R1 as const dReal ptr, byval side1 as const dReal ptr, byval p2 as const dReal ptr, byval R2 as const dReal ptr, byval side2 as const dReal ptr, byval normal as dReal ptr, byval depth as dReal ptr, byval return_code as long ptr, byval flags as long, byval contact as dContactGeom ptr, byval skip as long) as long
declare sub dInfiniteAABB(byval geom as dGeomID, byval aabb as dReal ptr)

type dGeomClass
	bytes as long
	collider as function(byval num as long) as function(byval o1 as dGeomID, byval o2 as dGeomID, byval flags as long, byval contact as dContactGeom ptr, byval skip as long) as long
	aabb as sub(byval as dGeomID, byval aabb as dReal ptr)
	aabb_test as function(byval o1 as dGeomID, byval o2 as dGeomID, byval aabb as dReal ptr) as long
	dtor as sub(byval o as dGeomID)
end type

declare function dCreateGeomClass(byval classptr as const dGeomClass ptr) as long
declare function dGeomGetClassData(byval as dGeomID) as any ptr
declare function dCreateGeom(byval classnum as long) as dGeomID
declare sub dSetColliderOverride(byval i as long, byval j as long, byval fn as function(byval o1 as dGeomID, byval o2 as dGeomID, byval flags as long, byval contact as dContactGeom ptr, byval skip as long) as long)
#define _ODE_THREADING_IMPL_H_
type dThreadingThreadPoolID as dxThreadingThreadPool ptr
declare function dThreadingAllocateMultiThreadedImplementation() as dThreadingImplementationID
declare function dThreadingImplementationGetFunctions(byval impl as dThreadingImplementationID) as const dThreadingFunctionsInfo ptr
declare sub dThreadingImplementationShutdownProcessing(byval impl as dThreadingImplementationID)
declare sub dThreadingImplementationCleanupForRestart(byval impl as dThreadingImplementationID)
declare sub dThreadingFreeImplementation(byval impl as dThreadingImplementationID)
declare sub dExternalThreadingServeMultiThreadedImplementation(byval impl as dThreadingImplementationID, byval readiness_callback as sub(byval callback_context as any ptr), byval callback_context as any ptr)
declare function dThreadingAllocateThreadPool(byval thread_count as ulong, byval stack_size as uinteger, byval ode_data_allocate_flags as ulong, byval reserved as any ptr) as dThreadingThreadPoolID
declare sub dThreadingThreadPoolServeMultiThreadedImplementation(byval pool as dThreadingThreadPoolID, byval impl as dThreadingImplementationID)
declare sub dThreadingThreadPoolWaitIdleState(byval pool as dThreadingThreadPoolID)
declare sub dThreadingFreeThreadPool(byval pool as dThreadingThreadPoolID)
#define _ODE_EXPORT_DIF_
declare sub dWorldExportDIF(byval w as dWorldID, byval file as FILE ptr, byval world_name as const zstring ptr)
#define _ODE_VERSION_H_
#define dODE_VERSION "0.13.1"

end extern
