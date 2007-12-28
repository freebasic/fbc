/'************************************************************************
 *                                                                       *
 * Open Dynamics Engine, Copyright (C) 2001-2003 Russell L. Smith.       *
 * All rights reserved.  Email: russ@q12.org   Web: www.q12.org          *
 *                                                                       *
 * Ported to FreeBASIC by D.J.Peters (Joshy) http://fsr.sf.net/forum     *
 *                                                                       *
 * This library is free software; you can redistribute it and/or         *
 * modify it under the terms of EITHER:                                  *
 *   (1) The GNU Lesser General Public License as published by the Free  *
 *       Software Foundation; either version 2.1 of the License, or (at  *
 *       your option) any later version. The text of the GNU Lesser      *
 *       General Public License is included with this library in the     *
 *       file LICENSE.TXT.                                               *
 *   (2) The BSD-style license that is included with this library in     *
 *       the file LICENSE-BSD.TXT.                                       *
 *                                                                       *
 * This library is distributed in the hope that it will be useful,       *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the files    *
 * LICENSE.TXT and LICENSE-BSD.TXT for more details.                     *
 *                                                                       *
 ************************************************************************'/
#ifndef __ode_common_bi__
#define __ode_common_bi__

#include "config.bi"
#include "error.bi"

#define EFFICIENT_ALIGNMENT 16

#if defined(dSINGLE)
  type dReal as single
# define REAL(x) (x ## f)              ' form a constant
# define dRecip(x) ((float)(1.0f/(x))) ' reciprocal
# define dSqrt(x) (sqr(x))             ' square root
# define dRecipSqrt(x) ((1.0f/sqr(x))) ' reciprocal square root
# define dSin(x) (sin(x))              ' sine 
# define dCos(x) (cos(x))              ' cosine
# define dFabs(x) (abs(x))             ' absolute value
# define dAtan2(y,x) (atan2((y),(x)))  ' arc tangent with 2 args

#elseif defined(dDOUBLE)

  type dReal as double
# define REAL(x) (x)
# define dRecip(x) (1.0/(x))
# define dSqrt(x) sqr(x)
# define dRecipSqrt(x) (1.0/sqr(x))
# define dSin(x) sin(x)
# define dCos(x) cos(x)
# define dFabs(x) abs(x)
# define dAtan2(y,x) atan2((y),(x))

#else
  #error You must #define dSINGLE or dDOUBLE
#endif

type dVector3 
  as dReal v(4-1)
end type
type dVector4 as dVector3
type dMatrix3 
  as dReal m(3*4-1)
end type
type dMatrix4 
  as dReal m(4*4-1)
end type
type dMatrix6 
  as dReal m(6*8-1)
end type
type dQuaternion 
  as dReal q(4)
end type

type dWorldID as dxWorld ptr
type dSpaceID as dxSpace ptr
type dBodyID as dxBody ptr
type dGeomID as dxGeom ptr
type dJointID as dxJoint ptr
type dJointGroupID as dxJointGroup ptr
type dHeightfieldDataID as dxHeightfieldData ptr

enum 
  d_ERR_UNKNOWN = 0
  d_ERR_IASSERT
  d_ERR_UASSERT
  d_ERR_LCP
end enum

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
end enum

enum 
  dParamLoStop = 0
  dParamHiStop
  dParamVel
  dParamFMax
  dParamFudgeFactor
  dParamBounce
  dParamCFM
  dParamStopERP
  dParamStopCFM
  dParamSuspensionERP
  dParamSuspensionCFM
  dParamERP

  dParamLoStop2 = &h100
  dParamHiStop2
  dParamVel2
  dParamFMax2
  dParamFudgeFactor2
  dParamBounce2
  dParamCFM2
  dParamStopERP2
  dParamStopCFM2
  dParamSuspensionERP2
  dParamSuspensionCFM2
  dParamERP2

  dParamLoStop3 = &h200
  dParamHiStop3
  dParamVel3
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

' joint force feedback information
type dJointFeedback
  f1 as dVector3 ' force  applied to body 1
  t1 as dVector3 ' torque applied to body 1
  f2 as dVector3 ' force  applied to body 2
  t2 as dVector3 ' torque applied to body 2
end type

extern "C"
declare sub      dGeomMoved       (byval as dGeomID)
declare function dGeomGetBodyNext (byval as dGeomID) as dGeomID
end extern

#endif __ode_common_bi__
