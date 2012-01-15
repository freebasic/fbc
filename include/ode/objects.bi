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
#ifndef __ode_objects_bi__
#define __ode_objects_bi__

#include once "common.bi"
#include once "mass.bi"
#include once "contact.bi"

extern "C"

'
' world
' 
declare function dWorldCreate        () as dWorldID
declare sub      dWorldDestroy       (byval w as dWorldID)
' world global propertys
declare sub      dWorldImpulseToForce(byval w as dWorldID, byval stepsize as dReal, byval ix as dReal, byval iy as dReal, byval iz as dReal, byval force as dVector3)

declare sub      dWorldSetGravity    (byval w as dWorldID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dWorldGetGravity    (byval w as dWorldID, byval gravity as dVector3 ptr)

declare sub      dWorldSetERP        (byval w as dWorldID, byval erp as dReal)
declare function dWorldGetERP        (byval w as dWorldID) as dReal

declare sub      dWorldSetCFM        (byval w as dWorldID, byval cfm as dReal)
declare function dWorldGetCFM        (byval w as dWorldID) as dReal

' world simulation steps
declare sub      dWorldStep                           (byval w as dWorldID, byval stepsize as dReal)
declare sub      dWorldStepFast1                      (byval w as dWorldID, byval stepsize as dReal, byval maxiterations as integer)

declare sub      dWorldQuickStep                      (byval w as dWorldID, byval stepsize as dReal)

declare sub      dWorldSetQuickStepNumIterations      (byval w as dWorldID, byval num as integer)
declare function dWorldGetQuickStepNumIterations      (byval w as dWorldID) as integer

declare sub      dWorldSetQuickStepW                  (byval w as dWorldID, byval param as dReal)
declare function dWorldGetQuickStepW                  (byval w as dWorldID) as dReal

' contacs in wolrd space
declare sub      dWorldSetContactMaxCorrectingVel     (byval w as dWorldID, byval vel as dReal)
declare function dWorldGetContactMaxCorrectingVel     (byval w as dWorldID) as dReal
declare sub      dWorldSetContactSurfaceLayer         (byval w as dWorldID, byval depth as dReal)
declare function dWorldGetContactSurfaceLayer         (byval w as dWorldID) as dReal

declare sub      dWorldSetAutoEnableDepthSF1          (byval w as dWorldID, byval autoEnableDepth as integer)
declare function dWorldGetAutoEnableDepthSF1          (byval w as dWorldID) as integer
declare function dWorldGetAutoDisableLinearThreshold  (byval w as dWorldID) as dReal
declare sub      dWorldSetAutoDisableLinearThreshold  (byval w as dWorldID, byval linear_threshold as dReal)
declare function dWorldGetAutoDisableAngularThreshold (byval w as dWorldID) as dReal
declare sub      dWorldSetAutoDisableAngularThreshold (byval w as dWorldID, byval angular_threshold as dReal)
declare function dWorldGetAutoDisableSteps            (byval w as dWorldID) as integer
declare sub      dWorldSetAutoDisableSteps            (byval w as dWorldID, byval steps as integer)
declare function dWorldGetAutoDisableTime             (byval w as dWorldID) as dReal
declare sub      dWorldSetAutoDisableTime             (byval w as dWorldID, byval time as dReal)
declare function dWorldGetAutoDisableFlag             (byval w as dWorldID) as integer
declare sub      dWorldSetAutoDisableFlag             (byval w as dWorldID, byval do_auto_disable as integer)

'
' body
'
declare function dBodyCreate     (byval w as dWorldID) as dBodyID
declare sub      dBodyDestroy    (byval b as dBodyID)

declare sub      dBodyEnable     (byval b as dBodyID)
declare sub      dBodyDisable    (byval b as dBodyID)
declare function dBodyIsEnabled  (byval b as dBodyID) as integer

declare function dBodyGetAutoDisableLinearThreshold  (byval b as dBodyID) as dReal
declare sub      dBodySetAutoDisableLinearThreshold  (byval b as dBodyID, byval linear_threshold as dReal)

declare function dBodyGetAutoDisableAngularThreshold (byval b as dBodyID) as dReal
declare sub      dBodySetAutoDisableAngularThreshold (byval b as dBodyID, byval angular_threshold as dReal)

declare function dBodyGetAutoDisableSteps   (byval as dBodyID) as integer
declare sub      dBodySetAutoDisableSteps   (byval as dBodyID, byval steps as integer)

declare function dBodyGetAutoDisableTime    (byval as dBodyID) as dReal
declare sub      dBodySetAutoDisableTime    (byval as dBodyID, byval time as dReal)

declare function dBodyGetAutoDisableFlag    (byval b as dBodyID) as integer
declare sub      dBodySetAutoDisableFlag    (byval b as dBodyID, byval do_auto_disable as integer)

declare sub      dBodySetAutoDisableDefaults(byval b as dBodyID)

declare sub      dBodySetData               (byval b as dBodyID, byval data as any ptr)
declare function dBodyGetData               (byval b as dBodyID) as any ptr

declare sub      dBodySetPosition           (byval b as dBodyID, byval x as dReal, byval y as dReal, byval z as dReal)
declare function dBodyGetPosition           (byval b as dBodyID) as dReal ptr
declare sub      dBodyCopyPosition          (byval b as dBodyID,byref pos as dVector3)

declare sub      dBodySetRotation           (byval b as dBodyID, byref R as dMatrix3)
declare function dBodyGetRotation           (byval b as dBodyID) as dReal ptr

declare sub      dBodySetQuaternion         (byval b as dBodyID, byref q as dQuaternion)
declare function dBodyGetQuaternion         (byval b as dBodyID) as dReal ptr

declare sub      dBodySetLinearVel          (byval b as dBodyID, byval x as dReal, byval y as dReal, byval z as dReal)
declare function dBodyGetLinearVel          (byval b as dBodyID) as dReal ptr

declare sub      dBodySetAngularVel         (byval b as dBodyID, byval x as dReal, byval y as dReal, byval z as dReal)
declare function dBodyGetAngularVel         (byval b as dBodyID) as dReal ptr

declare sub      dBodySetMass               (byval b as dBodyID, byval mass as dMass ptr)
declare sub      dBodyGetMass               (byval b as dBodyID, byval mass as dMass ptr)

declare sub      dBodyAddForce              (byval b as dBodyID, byval fx as dReal, byval fy as dReal, byval fz as dReal)
declare sub      dBodyAddTorque             (byval b as dBodyID, byval fx as dReal, byval fy as dReal, byval fz as dReal)

declare sub      dBodyAddRelForce           (byval b as dBodyID, byval fx as dReal, byval fy as dReal, byval fz as dReal)
declare sub      dBodyAddRelTorque          (byval b as dBodyID, byval fx as dReal, byval fy as dReal, byval fz as dReal)

declare sub      dBodyAddForceAtPos         (byval b as dBodyID, byval fx as dReal, byval fy as dReal, byval fz as dReal, byval px as dReal, byval py as dReal, byval pz as dReal)
declare sub      dBodyAddForceAtRelPos      (byval b as dBodyID, byval fx as dReal, byval fy as dReal, byval fz as dReal, byval px as dReal, byval py as dReal, byval pz as dReal)

declare sub      dBodyAddRelForceAtPos      (byval b as dBodyID, byval fx as dReal, byval fy as dReal, byval fz as dReal, byval px as dReal, byval py as dReal, byval pz as dReal)
declare sub      dBodyAddRelForceAtRelPos   (byval b as dBodyID, byval fx as dReal, byval fy as dReal, byval fz as dReal, byval px as dReal, byval py as dReal, byval pz as dReal)

declare sub      dBodySetForce              (byval b as dBodyID, byval x as dReal, byval y as dReal, byval z as dReal)
declare function dBodyGetForce              (byval b as dBodyID) as dReal ptr

declare sub      dBodySetTorque             (byval b as dBodyID, byval x as dReal, byval y as dReal, byval z as dReal)
declare function dBodyGetTorque             (byval b as dBodyID) as dReal ptr

declare sub      dBodyGetRelPointPos        (byval b as dBodyID, byval px as dReal, byval py as dReal, byval pz as dReal, byval result as dVector3)
declare sub      dBodyGetRelPointVel        (byval b as dBodyID, byval px as dReal, byval py as dReal, byval pz as dReal, byval result as dVector3)

declare sub      dBodyGetPointVel           (byval b as dBodyID, byval px as dReal, byval py as dReal, byval pz as dReal, byval result as dVector3)
declare sub      dBodyGetPosRelPoint        (byval b as dBodyID, byval px as dReal, byval py as dReal, byval pz as dReal, byval result as dVector3)

declare sub      dBodyVectorToWorld         (byval b as dBodyID, byval px as dReal, byval py as dReal, byval pz as dReal, byval result as dVector3)
declare sub      dBodyVectorFromWorld       (byval b as dBodyID, byval px as dReal, byval py as dReal, byval pz as dReal, byval result as dVector3)

declare sub      dBodySetFiniteRotationMode (byval b as dBodyID, byval mode as integer)
declare function dBodyGetFiniteRotationMode (byval b as dBodyID) as integer

declare sub      dBodySetFiniteRotationAxis (byval b as dBodyID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dBodyGetFiniteRotationAxis (byval b as dBodyID, byval result as dVector3)

declare function dBodyGetNumJoints          (byval b as dBodyID) as integer
declare function dBodyGetJoint              (byval b as dBodyID, byval index as integer) as dJointID

declare sub      dBodySetGravityMode        (byval b as dBodyID, byval mode as integer)
declare function dBodyGetGravityMode        (byval b as dBodyID) as integer

'
' joints 
'
declare function dJointCreateBall             (byval w as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreateHinge            (byval w as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreateSlider           (byval w as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreateContact          (byval w as dWorldID, byval as dJointGroupID, byval as dContact ptr) as dJointID
declare function dJointCreateHinge2           (byval w as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreateUniversal        (byval w as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreateFixed            (byval w as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreateNull             (byval w as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreateAMotor           (byval w as dWorldID, byval as dJointGroupID) as dJointID
declare sub      dJointDestroy                (byval j as dJointID)
declare function dJointGroupCreate            (byval max_size as integer) as dJointGroupID
declare sub      dJointGroupDestroy           (byval jg as dJointGroupID)
declare sub      dJointGroupEmpty             (byval jg as dJointGroupID)
declare sub      dJointAttach                 (byval j as dJointID, byval body1 as dBodyID, byval body2 as dBodyID)

declare sub      dJointSetData                (byval j as dJointID, byval data as any ptr)
declare function dJointGetData                (byval j as dJointID) as any ptr

declare function dJointGetType                (byval j as dJointID) as integer
declare function dJointGetBody                (byval j as dJointID, byval index as integer) as dBodyID

declare sub      dJointSetFeedback            (byval j as dJointID, byval as dJointFeedback ptr)
declare function dJointGetFeedback            (byval j as dJointID) as dJointFeedback ptr

declare sub      dJointSetBallAnchor          (byval j as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dJointSetHingeAnchor         (byval j as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dJointSetHingeAxis           (byval j as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dJointSetHingeParam          (byval j as dJointID, byval parameter as integer, byval value as dReal)
declare sub      dJointAddHingeTorque         (byval j as dJointID, byval torque as dReal)
declare sub      dJointSetSliderAxis          (byval j as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dJointSetSliderParam         (byval j as dJointID, byval parameter as integer, byval value as dReal)
declare sub      dJointAddSliderForce         (byval j as dJointID, byval force as dReal)
declare sub      dJointSetHinge2Anchor        (byval j as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dJointSetHinge2Axis1         (byval j as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dJointSetHinge2Axis2         (byval j as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dJointSetHinge2Param         (byval j as dJointID, byval parameter as integer, byval value as dReal)
declare sub      dJointAddHinge2Torques       (byval j as dJointID, byval torque1 as dReal, byval torque2 as dReal)
declare sub      dJointSetUniversalAnchor     (byval j as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dJointSetUniversalAxis1      (byval j as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dJointSetUniversalAxis2      (byval j as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dJointSetUniversalParam      (byval j as dJointID, byval parameter as integer, byval value as dReal)
declare sub      dJointAddUniversalTorques    (byval j as dJointID, byval torque1 as dReal, byval torque2 as dReal)
declare sub      dJointSetFixed               (byval j as dJointID)
declare sub      dJointSetAMotorNumAxes       (byval j as dJointID, byval num as integer)
declare sub      dJointSetAMotorAxis          (byval j as dJointID, byval anum as integer, byval rel as integer, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dJointSetAMotorAngle         (byval j as dJointID, byval anum as integer, byval angle as dReal)
declare sub      dJointSetAMotorParam         (byval j as dJointID, byval parameter as integer, byval value as dReal)
declare sub      dJointSetAMotorMode          (byval j as dJointID, byval mode as integer)
declare sub      dJointAddAMotorTorques       (byval j as dJointID, byval torque1 as dReal, byval torque2 as dReal, byval torque3 as dReal)
declare sub      dJointGetBallAnchor          (byval j as dJointID, byval result as dVector3)
declare sub      dJointGetBallAnchor2         (byval j as dJointID, byval result as dVector3)
declare sub      dJointGetHingeAnchor         (byval j as dJointID, byval result as dVector3)
declare sub      dJointGetHingeAnchor2        (byval j as dJointID, byval result as dVector3)
declare sub      dJointGetHingeAxis           (byval j as dJointID, byval result as dVector3)
declare function dJointGetHingeParam          (byval j as dJointID, byval parameter as integer) as dReal
declare function dJointGetHingeAngle          (byval j as dJointID) as dReal
declare function dJointGetHingeAngleRate      (byval j as dJointID) as dReal
declare function dJointGetSliderPosition      (byval j as dJointID) as dReal
declare function dJointGetSliderPositionRate  (byval j as dJointID) as dReal
declare sub      dJointGetSliderAxis          (byval j as dJointID, byval result as dVector3)
declare function dJointGetSliderParam         (byval j as dJointID, byval parameter as integer) as dReal
declare sub      dJointGetHinge2Anchor        (byval j as dJointID, byval result as dVector3)
declare sub      dJointGetHinge2Anchor2       (byval j as dJointID, byval result as dVector3)
declare sub      dJointGetHinge2Axis1         (byval j as dJointID, byval result as dVector3)
declare sub      dJointGetHinge2Axis2         (byval j as dJointID, byval result as dVector3)
declare function dJointGetHinge2Param         (byval j as dJointID, byval parameter as integer) as dReal
declare function dJointGetHinge2Angle1        (byval j as dJointID) as dReal
declare function dJointGetHinge2Angle1Rate    (byval j as dJointID) as dReal
declare function dJointGetHinge2Angle2Rate    (byval j as dJointID) as dReal
declare sub      dJointGetUniversalAnchor     (byval j as dJointID, byval result as dVector3)
declare sub      dJointGetUniversalAnchor2    (byval j as dJointID, byval result as dVector3)
declare sub      dJointGetUniversalAxis1      (byval j as dJointID, byval result as dVector3)
declare sub      dJointGetUniversalAxis2      (byval j as dJointID, byval result as dVector3)
declare function dJointGetUniversalParam      (byval j as dJointID, byval parameter as integer) as dReal
declare function dJointGetUniversalAngle1     (byval j as dJointID) as dReal
declare function dJointGetUniversalAngle2     (byval j as dJointID) as dReal
declare function dJointGetUniversalAngle1Rate (byval j as dJointID) as dReal
declare function dJointGetUniversalAngle2Rate (byval j as dJointID) as dReal
declare function dJointGetAMotorNumAxes       (byval j as dJointID) as integer
declare sub      dJointGetAMotorAxis          (byval j as dJointID, byval anum as integer, byval result as dVector3)
declare function dJointGetAMotorAxisRel       (byval j as dJointID, byval anum as integer) as integer
declare function dJointGetAMotorAngle         (byval j as dJointID, byval anum as integer) as dReal
declare function dJointGetAMotorAngleRate     (byval j as dJointID, byval anum as integer) as dReal
declare function dJointGetAMotorParam         (byval j as dJointID, byval parameter as integer) as dReal
declare function dJointGetAMotorMode          (byval j as dJointID) as integer

' helpers
declare function dAreConnected (byval b1 as dBodyID, byval b2 as dBodyID) as integer
declare function dAreConnectedExcluding(byval b1 as dBodyID, byval b2 as dBodyID, byval joint_type as integer) as integer

end extern
#endif
