/'************************************************************************
 *                                                                       *
 * Open Dynamics Engine, Copyright (C) 2001,2002 Russell L. Smith.       *
 * All rights reserved.  Email: russ@q12.org   Web: www.q12.org          *
 *                                                                       *
 * Ported to FreeBASIC by D.J.Peters (Joshy)                             *
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

'
' world
' 
declare function dWorldCreate cdecl alias "dWorldCreate" () as dWorldID
declare sub      dWorldDestroy cdecl alias "dWorldDestroy" (byval as dWorldID)
' world global propertys
declare sub      dWorldImpulseToForce cdecl alias "dWorldImpulseToForce" (byval as dWorldID, byval stepsize as dReal, byval ix as dReal, byval iy as dReal, byval iz as dReal, byval force as dVector3)

declare sub      dWorldSetGravity cdecl alias "dWorldSetGravity" (byval as dWorldID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dWorldGetGravity cdecl alias "dWorldGetGravity" (byval as dWorldID, byval gravity as dVector3 ptr)

declare sub      dWorldSetERP cdecl alias "dWorldSetERP" (byval as dWorldID, byval erp as dReal)
declare function dWorldGetERP cdecl alias "dWorldGetERP" (byval as dWorldID) as dReal

declare sub      dWorldSetCFM cdecl alias "dWorldSetCFM" (byval as dWorldID, byval cfm as dReal)
declare function dWorldGetCFM cdecl alias "dWorldGetCFM" (byval as dWorldID) as dReal

' world simulation steps
declare sub      dWorldStep cdecl alias "dWorldStep" (byval as dWorldID, byval stepsize as dReal)
declare sub      dWorldStepFast1 cdecl alias "dWorldStepFast1" (byval as dWorldID, byval stepsize as dReal, byval maxiterations as integer)
declare sub      dWorldQuickStep cdecl alias "dWorldQuickStep" (byval w as dWorldID, byval stepsize as dReal)

declare sub      dWorldSetQuickStepNumIterations cdecl alias "dWorldSetQuickStepNumIterations" (byval as dWorldID, byval num as integer)
declare function dWorldGetQuickStepNumIterations cdecl alias "dWorldGetQuickStepNumIterations" (byval as dWorldID) as integer

declare sub      dWorldSetQuickStepW cdecl alias "dWorldSetQuickStepW" (byval as dWorldID, byval param as dReal)
declare function dWorldGetQuickStepW cdecl alias "dWorldGetQuickStepW" (byval as dWorldID) as dReal

' contacs in wolrd space
declare sub      dWorldSetContactMaxCorrectingVel cdecl alias "dWorldSetContactMaxCorrectingVel" (byval as dWorldID, byval vel as dReal)
declare function dWorldGetContactMaxCorrectingVel cdecl alias "dWorldGetContactMaxCorrectingVel" (byval as dWorldID) as dReal

declare sub      dWorldSetContactSurfaceLayer cdecl alias "dWorldSetContactSurfaceLayer" (byval as dWorldID, byval depth as dReal)
declare function dWorldGetContactSurfaceLayer cdecl alias "dWorldGetContactSurfaceLayer" (byval as dWorldID) as dReal

declare sub      dWorldSetAutoEnableDepthSF1 cdecl alias "dWorldSetAutoEnableDepthSF1" (byval as dWorldID, byval autoEnableDepth as integer)
declare function dWorldGetAutoEnableDepthSF1 cdecl alias "dWorldGetAutoEnableDepthSF1" (byval as dWorldID) as integer

declare sub      dWorldSetAutoDisableLinearThreshold cdecl alias "dWorldSetAutoDisableLinearThreshold" (byval as dWorldID, byval linear_threshold as dReal)
declare function dWorldGetAutoDisableLinearThreshold cdecl alias "dWorldGetAutoDisableLinearThreshold" (byval as dWorldID) as dReal

declare sub      dWorldSetAutoDisableAngularThreshold cdecl alias "dWorldSetAutoDisableAngularThreshold" (byval as dWorldID, byval angular_threshold as dReal)
declare function dWorldGetAutoDisableAngularThreshold cdecl alias "dWorldGetAutoDisableAngularThreshold" (byval as dWorldID) as dReal

declare sub      dWorldSetAutoDisableLinearAverageThreshold cdecl alias "dWorldSetAutoDisableLinearAverageThreshold" (byval as dWorldID, byval linear_average_threshold as dReal)
declare function dWorldGetAutoDisableLinearAverageThreshold cdecl alias "dWorldGetAutoDisableLinearAverageThreshold" (byval as dWorldID) as dReal

declare sub      dWorldSetAutoDisableAngularAverageThreshold cdecl alias "dWorldSetAutoDisableAngularAverageThreshold" (byval as dWorldID,byval angular_average_threshold as dReal)
declare function dWorldGetAutoDisableAngularAverageThreshold cdecl alias "dWorldGetAutoDisableAngularAverageThreshold" (byval as dWorldID) as dReal

declare sub      dWorldSetAutoDisableAverageSamplesCount cdecl alias "dWorldSetAutoDisableAverageSamplesCount" (byval as dWorldID,byval average_samples_count as integer)
declare function dWorldGetAutoDisableAverageSamplesCount cdecl alias "dWorldGetAutoDisableAverageSamplesCount" (byval as dWorldID) as integer

declare sub      dWorldSetAutoDisableSteps cdecl alias "dWorldSetAutoDisableSteps" (byval as dWorldID, byval steps as integer)
declare function dWorldGetAutoDisableSteps cdecl alias "dWorldGetAutoDisableSteps" (byval as dWorldID) as integer

declare sub      dWorldSetAutoDisableTime cdecl alias "dWorldSetAutoDisableTime" (byval as dWorldID, byval time as dReal)
declare function dWorldGetAutoDisableTime cdecl alias "dWorldGetAutoDisableTime" (byval as dWorldID) as dReal

declare sub      dWorldSetAutoDisableFlag cdecl alias "dWorldSetAutoDisableFlag" (byval as dWorldID, byval do_auto_disable as integer)
declare function dWorldGetAutoDisableFlag cdecl alias "dWorldGetAutoDisableFlag" (byval as dWorldID) as integer

declare sub      dWorldSetLinearDampingThreshold cdecl alias "dWorldSetLinearDampingThreshold" (byval as dWorldID,byval threshold as dReal)
declare function dWorldGetLinearDampingThreshold cdecl alias "dWorldGetLinearDampingThreshold" (byval as dWorldID) as dReal

declare sub      dWorldSetAngularDampingThreshold cdecl alias "dWorldSetAngularDampingThreshold" (byval as dWorldID,byval threshold as dReal)
declare function dWorldGetAngularDampingThreshold cdecl alias "dWorldGetAngularDampingThreshold" (byval as dWorldID) as dReal

declare sub      dWorldSetLinearDamping cdecl alias "dWorldSetLinearDamping" (byval as dWorldID,byval scale as dReal)
declare function dWorldGetLinearDamping cdecl alias "dWorldGetLinearDamping" (byval as dWorldID) as dReal

declare sub      dWorldSetAngularDamping cdecl alias "dWorldSetAngularDamping" (byval as dWorldID,byval scale as dReal)
declare function dWorldGetAngularDamping cdecl alias "dWorldGetAngularDamping" (byval as dWorldID) as dReal

declare sub      dWorldSetDamping cdecl alias "dWorldSetDamping" (byval as dWorldID,byval linear_scale as dReal,byval angular_scale as dReal)

declare sub      dWorldSetMaxAngularSpeed cdecl alias "dWorldSetMaxAngularSpeed" (byval as dWorldID,byval max_speed as dReal)
declare function dWorldGetMaxAngularSpeed cdecl alias "dWorldGetMaxAngularSpeed" (byval as dWorldID) as dReal

'
' body
'

declare function dBodyCreate    cdecl alias "dBodyCreate"    (byval as dWorldID) as dBodyID
declare sub      dBodyDestroy   cdecl alias "dBodyDestroy"   (byval as dBodyID)

declare function dBodyGetWorld  cdecl alias "dBodyGetWorld" (byval as dBodyID) as dWorldID

declare sub      dBodyEnable    cdecl alias "dBodyEnable"    (byval as dBodyID)
declare sub      dBodyDisable   cdecl alias "dBodyDisable"   (byval as dBodyID)
declare function dBodyIsEnabled cdecl alias "dBodyIsEnabled" (byval as dBodyID) as integer

declare sub      dBodySetAutoDisableLinearThreshold cdecl alias "dBodySetAutoDisableLinearThreshold" (byval as dBodyID, byval linear_threshold as dReal)
declare function dBodyGetAutoDisableLinearThreshold cdecl alias "dBodyGetAutoDisableLinearThreshold" (byval as dBodyID) as dReal

declare sub      dBodySetAutoDisableAngularThreshold cdecl alias "dBodySetAutoDisableAngularThreshold" (byval as dBodyID, byval angular_threshold as dReal)
declare function dBodyGetAutoDisableAngularThreshold cdecl alias "dBodyGetAutoDisableAngularThreshold" (byval as dBodyID) as dReal

declare sub      dBodySetAutoDisableAverageSamplesCount cdecl alias "dBodySetAutoDisableAverageSamplesCount" (byval as dBodyID,byval average_samples_count as integer)
declare function dBodyGetAutoDisableAverageSamplesCount cdecl alias "dBodyGetAutoDisableAverageSamplesCount" (byval as dBodyID) as integer

declare sub      dBodySetAutoDisableSteps     cdecl alias "dBodySetAutoDisableSteps" (byval as dBodyID, byval steps as integer)
declare function dBodyGetAutoDisableSteps     cdecl alias "dBodyGetAutoDisableSteps" (byval as dBodyID) as integer

declare sub      dBodySetAutoDisableTime      cdecl alias "dBodySetAutoDisableTime" (byval as dBodyID,byval as dReal)
declare function dBodyGetAutoDisableTime      cdecl alias "dBodyGetAutoDisableTime" (byval as dBodyID) as dReal

declare function dBodyGetAutoDisableFlag      cdecl alias "dBodyGetAutoDisableFlag" (byval as dBodyID) as integer
declare sub      dBodySetAutoDisableFlag      cdecl alias "dBodySetAutoDisableFlag" (byval as dBodyID, byval do_auto_disable as integer)

declare sub      dBodySetAutoDisableDefaults  cdecl alias "dBodySetAutoDisableDefaults" (byval as dBodyID)

declare sub      dBodySetData                 cdecl alias "dBodySetData" (byval as dBodyID, byval data as any ptr)
declare function dBodyGetData                 cdecl alias "dBodyGetData" (byval as dBodyID) as any ptr

declare sub      dBodySetPosition             cdecl alias "dBodySetPosition" (byval as dBodyID, byval x as dReal, byval y as dReal, byval z as dReal)
declare function dBodyGetPosition             cdecl alias "dBodyGetPosition" (byval as dBodyID) as dReal ptr
declare sub      dBodyCopyPosition            cdecl alias "dBodyCopyPosition"(byval as dBodyID,byref pos as dVector3)

declare sub      dBodySetRotation             cdecl alias "dBodySetRotation" (byval as dBodyID, byref R as dMatrix3)
declare function dBodyGetRotation             cdecl alias "dBodyGetRotation" (byval as dBodyID) as dReal ptr
declare sub      dBodyCopyRotation            cdecl alias "dBodyCopyRotation" (byval as dBodyID, byref r as dMatrix3)

declare sub      dBodySetQuaternion           cdecl alias "dBodySetQuaternion" (byval as dBodyID, byref q as dQuaternion)
declare function dBodyGetQuaternion           cdecl alias "dBodyGetQuaternion" (byval as dBodyID) as dReal ptr
declare sub      dBodyCopyQuaternion          cdecl alias "dBodyCopyQuaternion" (byval as dBodyID, byref q as dQuaternion)

declare sub      dBodySetLinearVel            cdecl alias "dBodySetLinearVel" (byval as dBodyID, byval x as dReal, byval y as dReal, byval z as dReal)
declare function dBodyGetLinearVel            cdecl alias "dBodyGetLinearVel" (byval as dBodyID) as dReal ptr

declare sub      dBodySetAngularVel           cdecl alias "dBodySetAngularVel" (byval as dBodyID, byval x as dReal, byval y as dReal, byval z as dReal)
declare function dBodyGetAngularVel           cdecl alias "dBodyGetAngularVel" (byval as dBodyID) as dReal ptr

declare sub      dBodySetMass                 cdecl alias "dBodySetMass" (byval as dBodyID, byval mass as dMass ptr)
declare sub      dBodyGetMass                 cdecl alias "dBodyGetMass" (byval as dBodyID, byval mass as dMass ptr)

declare sub      dBodySetForce                cdecl alias "dBodySetForce" (byval b as dBodyID, byval x as dReal, byval y as dReal, byval z as dReal)
declare function dBodyGetForce                cdecl alias "dBodyGetForce" (byval as dBodyID) as dReal ptr
declare sub      dBodyAddForce                cdecl alias "dBodyAddForce" (byval as dBodyID, byval fx as dReal, byval fy as dReal, byval fz as dReal)

declare sub      dBodySetTorque               cdecl alias "dBodySetTorque" (byval b as dBodyID, byval x as dReal, byval y as dReal, byval z as dReal)
declare function dBodyGetTorque               cdecl alias "dBodyGetTorque" (byval as dBodyID) as dReal ptr
declare sub      dBodyAddTorque               cdecl alias "dBodyAddTorque" (byval as dBodyID, byval fx as dReal, byval fy as dReal, byval fz as dReal)

declare sub      dBodyAddRelForce             cdecl alias "dBodyAddRelForce" (byval as dBodyID, byval fx as dReal, byval fy as dReal, byval fz as dReal)
declare sub      dBodyAddRelTorque            cdecl alias "dBodyAddRelTorque" (byval as dBodyID, byval fx as dReal, byval fy as dReal, byval fz as dReal)

declare sub      dBodyAddForceAtPos           cdecl alias "dBodyAddForceAtPos" (byval as dBodyID, byval fx as dReal, byval fy as dReal, byval fz as dReal, byval px as dReal, byval py as dReal, byval pz as dReal)
declare sub      dBodyAddForceAtRelPos        cdecl alias "dBodyAddForceAtRelPos" (byval as dBodyID, byval fx as dReal, byval fy as dReal, byval fz as dReal, byval px as dReal, byval py as dReal, byval pz as dReal)

declare sub      dBodyAddRelForceAtPos        cdecl alias "dBodyAddRelForceAtPos" (byval as dBodyID, byval fx as dReal, byval fy as dReal, byval fz as dReal, byval px as dReal, byval py as dReal, byval pz as dReal)
declare sub      dBodyAddRelForceAtRelPos     cdecl alias "dBodyAddRelForceAtRelPos" (byval as dBodyID, byval fx as dReal, byval fy as dReal, byval fz as dReal, byval px as dReal, byval py as dReal, byval pz as dReal)


declare sub      dBodyGetRelPointPos          cdecl alias "dBodyGetRelPointPos" (byval as dBodyID, byval px as dReal, byval py as dReal, byval pz as dReal, byref result as dVector3)
declare sub      dBodyGetRelPointVel          cdecl alias "dBodyGetRelPointVel" (byval as dBodyID, byval px as dReal, byval py as dReal, byval pz as dReal, byref result as dVector3)

declare sub      dBodyGetPointVel             cdecl alias "dBodyGetPointVel" (byval as dBodyID, byval px as dReal, byval py as dReal, byval pz as dReal, byref result as dVector3)
declare sub      dBodyGetPosRelPoint          cdecl alias "dBodyGetPosRelPoint" (byval as dBodyID, byval px as dReal, byval py as dReal, byval pz as dReal, byref result as dVector3)

declare sub      dBodyVectorToWorld           cdecl alias "dBodyVectorToWorld" (byval as dBodyID, byval px as dReal, byval py as dReal, byval pz as dReal, byref result as dVector3)
declare sub      dBodyVectorFromWorld         cdecl alias "dBodyVectorFromWorld" (byval as dBodyID, byval px as dReal, byval py as dReal, byval pz as dReal, byref result as dVector3)

declare sub      dBodySetFiniteRotationMode   cdecl alias "dBodySetFiniteRotationMode" (byval as dBodyID, byval mode as integer)
declare function dBodyGetFiniteRotationMode   cdecl alias "dBodyGetFiniteRotationMode" (byval as dBodyID) as integer

declare sub      dBodySetFiniteRotationAxis   cdecl alias "dBodySetFiniteRotationAxis" (byval as dBodyID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dBodyGetFiniteRotationAxis   cdecl alias "dBodyGetFiniteRotationAxis" (byval as dBodyID, byval result as dVector3)

declare function dBodyGetNumJoints            cdecl alias "dBodyGetNumJoints" (byval b as dBodyID) as integer
declare function dBodyGetJoint                cdecl alias "dBodyGetJoint" (byval as dBodyID, byval index as integer) as dJointID

declare sub      dBodySetGravityMode          cdecl alias "dBodySetGravityMode" (byval b as dBodyID, byval mode as integer)
declare function dBodyGetGravityMode          cdecl alias "dBodyGetGravityMode" (byval b as dBodyID) as integer

declare sub      dBodySetDynamic              cdecl alias "dBodySetDynamic" (byval body as dBodyID)
declare sub      dBodySetKinematic            cdecl alias "dBodySetKinematic" (byval body as dBodyID)
declare function dBodyIsKinematic             cdecl alias "dBodyIsKinematic" (byval body as dBodyID) as integer

declare function dBodyGetFirstGeom            cdecl alias "dBodyGetFirstGeom" (byval body as dBodyID) as dGeomID
declare function dBodyGetNextGeom             cdecl alias "dBodyGetNextGeom" (byval as dGeomID) as dGeomID

declare sub      dBodySetDampingDefaults      cdecl alias "dBodySetDampingDefaults" (byval body as dBodyID)
declare sub      dBodySetDamping              cdecl alias "dBodySetDamping" (byval body as dBodyID,byval linear_scale as dReal,byval angular_scale as dReal)

declare sub      dBodySetLinearDamping        cdecl alias "dBodySetLinearDamping" (byval body as dBodyID,byval scale as dReal)
declare function dBodyGetLinearDamping        cdecl alias "dBodyGetLinearDamping" (byval body as dBodyID) as dReal

declare sub      dBodySetAngularDamping       cdecl alias "dBodySetAngularDamping" (byval body as dBodyID,byval scale as dReal)
declare function dBodyGetAngularDamping       cdecl alias "dBodyGetAngularDamping" (byval body as dBodyID) as dReal
 
declare sub      dBodySetLinearDampingThreshold cdecl alias "dBodySetLinearDampingThreshold" (byval body as dBodyID,byval threshold as dReal)
declare function dBodyGetLinearDampingThreshold cdecl alias "dBodyGetLinearDampingThreshold" (byval body as dBodyID) as dReal

declare sub      dBodySetAngularDampingThreshold cdecl alias "dBodySetAngularDampingThreshold" (byval body as dBodyID,byval threshold as dReal)
declare function dBodyGetAngularDampingThreshold cdecl alias "dBodyGetAngularDampingThreshold" (byval body as dBodyID) as dReal

declare sub      dBodySetMaxAngularSpeed      cdecl alias "dBodySetMaxAngularSpeed" (byval body as dBodyID,byval max_speed as integer)
declare function dBodyGetMaxAngularSpeed      cdecl alias "dBodyGetMaxAngularSpeed" (byval body as dBodyID) as dReal

declare sub      dBodySetGyroscopicMode       cdecl alias "dBodySetGyroscopicMode" (byval body as dBodyID,byval enabled as integer)
declare function dBodyGetGyroscopicMode       cdecl alias "dBodyGetGyroscopicMode" (byval body as dBodyID) as integer

#ifndef BODYCALLBACK
  type BODYCALLBACK as sub cdecl (byval body as dBodyID)
#endif

declare sub      dBodySetMovedCallback        cdecl alias "dBodySetMovedCallback" (byval body as dBodyID, byval callback as BODYCALLBACK ptr)


'
' joints 
'
declare function dJointCreateBall             cdecl alias "dJointCreateBall"      (byval as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreateHinge            cdecl alias "dJointCreateHinge"     (byval as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreateSlider           cdecl alias "dJointCreateSlider"    (byval as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreateContact          cdecl alias "dJointCreateContact"   (byval as dWorldID, byval as dJointGroupID, byval as dContact ptr) as dJointID
declare function dJointCreateHinge2           cdecl alias "dJointCreateHinge2"    (byval as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreateUniversal        cdecl alias "dJointCreateUniversal" (byval as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreatePR               cdecl alias "dJointCreatePR"        (byval as dWorldID,byval as dJointGroupID) as dJointID
declare function dJointCreatePU               cdecl alias "dJointCreatePU"        (byval as dWorldID,byval as dJointGroupID) as dJointID
declare function dJointCreatePiston           cdecl alias "dJointCreatePiston"    (byval as dWorldID,byval as dJointGroupID) as dJointID
declare function dJointCreateFixed            cdecl alias "dJointCreateFixed"     (byval as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreateNull             cdecl alias "dJointCreateNull"      (byval as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreateAMotor           cdecl alias "dJointCreateAMotor"    (byval as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreateLMotor           cdecl alias "dJointCreateLMotor"    (byval as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreatePlane2D          cdecl alias "dJointCreatePlane2D"   (byval as dWorldID,byval as dJointGroupID) as dJointID 

declare sub      dJointDestroy                cdecl alias "dJointDestroy"         (byval as dJointID)


declare function dJointGroupCreate            cdecl alias "dJointGroupCreate" (byval max_size as integer) as dJointGroupID
declare sub      dJointGroupDestroy           cdecl alias "dJointGroupDestroy" (byval as dJointGroupID)
declare sub      dJointGroupEmpty             cdecl alias "dJointGroupEmpty" (byval as dJointGroupID)
declare function dJointGetNumBodies           cdecl alias "dJointGetNumBodies" (byval as dJointID) as integer
declare sub      dJointAttach                 cdecl alias "dJointAttach" (byval as dJointID, byval body1 as dBodyID, byval body2 as dBodyID)

declare sub      dJointEnable                 cdecl alias "dJointEnable" (byval as dJointID)
declare sub      dJointDisable                cdecl alias "dJointDisable" (byval as dJointID)
declare function dJointIsEnabled              cdecl alias "dJointIsEnabled" (byval as dJointID) as integer

declare sub      dJointSetData                cdecl alias "dJointSetData" (byval as dJointID, byval data as any ptr)
declare function dJointGetData                cdecl alias "dJointGetData" (byval as dJointID) as any ptr

declare function dJointGetType                cdecl alias "dJointGetType" (byval as dJointID) as dJointType
declare function dJointGetBody                cdecl alias "dJointGetBody" (byval as dJointID, byval index as integer) as dBodyID

declare sub      dJointSetFeedback            cdecl alias "dJointSetFeedback" (byval as dJointID, byval as dJointFeedback ptr)
declare function dJointGetFeedback            cdecl alias "dJointGetFeedback" (byval as dJointID) as dJointFeedback ptr
declare sub      dJointSetFixed               cdecl alias "dJointSetFixed" (byval as dJointID)

' ball
declare sub      dJointSetBallAnchor          cdecl alias "dJointSetBallAnchor"  (byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dJointGetBallAnchor          cdecl alias "dJointGetBallAnchor"  (byval as dJointID, byref result as dVector3)

declare sub      dJointSetBallAnchor2         cdecl alias "dJointSetBallAnchor2" (byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dJointGetBallAnchor2         cdecl alias "dJointGetBallAnchor2" (byval as dJointID, byref result as dVector3)

declare sub      dJointSetBallParam cdecl alias "dJointSetBallParam" (byval as dJointID,byval parameter as integer,byval value as dReal)
declare function dJointGetBallParam cdecl alias "dJointGetBallParam" (byval as dJointID,byval parameter as integer) as dReal

' hing
declare sub      dJointSetHingeAnchor         cdecl alias "dJointSetHingeAnchor" (byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dJointGetHingeAnchor         cdecl alias "dJointGetHingeAnchor" (byval as dJointID, byref result as dVector3)
declare sub      dJointGetHingeAnchor2        cdecl alias "dJointGetHingeAnchor2" (byval as dJointID, byref result as dVector3)

declare sub      dJointSetHingeAxis           cdecl alias "dJointSetHingeAxis" (byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dJointGetHingeAxis           cdecl alias "dJointGetHingeAxis" (byval as dJointID, byref result as dVector3)
declare sub      dJointSetHingeAxisOffset     cdecl alias "dJointSetHingeAxisOffset" (byval jpint as dJointID,byval x as dReal, byval y as dReal, byval z as dReal,byval angle as dReal)

declare sub      dJointSetHingeParam          cdecl alias "dJointSetHingeParam" (byval as dJointID, byval parameter as integer, byval value as dReal)
declare function dJointGetHingeParam          cdecl alias "dJointGetHingeParam" (byval as dJointID, byval parameter as integer) as dReal

declare function dJointGetHingeAngle          cdecl alias "dJointGetHingeAngle" (byval as dJointID) as dReal
declare function dJointGetHingeAngleRate      cdecl alias "dJointGetHingeAngleRate" (byval as dJointID) as dReal
declare sub      dJointAddHingeTorque         cdecl alias "dJointAddHingeTorque" (byval joint as dJointID, byval torque as dReal)

' hinge2
declare sub      dJointSetHinge2Anchor        cdecl alias "dJointSetHinge2Anchor" (byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dJointGetHinge2Anchor        cdecl alias "dJointGetHinge2Anchor" (byval as dJointID, byref result as dVector3)

declare sub      dJointSetHinge2Axis1         cdecl alias "dJointSetHinge2Axis1" (byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dJointGetHinge2Axis1         cdecl alias "dJointGetHinge2Axis1" (byval as dJointID, byref result as dVector3)

declare sub      dJointSetHinge2Axis2         cdecl alias "dJointSetHinge2Axis2" (byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dJointGetHinge2Axis2         cdecl alias "dJointGetHinge2Axis2" (byval as dJointID, byref result as dVector3)

declare sub      dJointSetHinge2Param         cdecl alias "dJointSetHinge2Param" (byval as dJointID, byval parameter as integer, byval value as dReal)
declare function dJointGetHinge2Param         cdecl alias "dJointGetHinge2Param" (byval as dJointID, byval parameter as integer) as dReal

declare sub      dJointGetHinge2Anchor2       cdecl alias "dJointGetHinge2Anchor2" (byval as dJointID, byval result as dVector3)
declare function dJointGetHinge2Angle1        cdecl alias "dJointGetHinge2Angle1" (byval as dJointID) as dReal
declare function dJointGetHinge2Angle1Rate    cdecl alias "dJointGetHinge2Angle1Rate" (byval as dJointID) as dReal
declare function dJointGetHinge2Angle2Rate    cdecl alias "dJointGetHinge2Angle2Rate" (byval as dJointID) as dReal
declare sub      dJointAddHinge2Torques       cdecl alias "dJointAddHinge2Torques" (byval joint as dJointID, byval torque1 as dReal, byval torque2 as dReal)


' slider
declare sub      dJointSetSliderAxis          cdecl alias "dJointSetSliderAxis" (byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dJointGetSliderAxis          cdecl alias "dJointGetSliderAxis" (byval as dJointID, byref result as dVector3)
declare sub      dJointSetSliderAxisDelta     cdecl alias "dJointSetSliderAxisDelta" (byval as dJointID,byval x as dReal, byval y as dReal,byval z as dReal,byval ax as dReal,byval ay as dReal,byval az as dReal)

declare sub      dJointSetSliderParam         cdecl alias "dJointSetSliderParam" (byval as dJointID, byval parameter as integer, byval value as dReal)
declare function dJointGetSliderParam         cdecl alias "dJointGetSliderParam" (byval as dJointID, byval parameter as integer) as dReal

declare sub      dJointAddSliderForce         cdecl alias "dJointAddSliderForce" (byval joint as dJointID, byval force as dReal)
declare function dJointGetSliderPosition      cdecl alias "dJointGetSliderPosition" (byval as dJointID) as dReal
declare function dJointGetSliderPositionRate  cdecl alias "dJointGetSliderPositionRate" (byval as dJointID) as dReal

' universal
declare sub      dJointSetUniversalAnchor     cdecl alias "dJointSetUniversalAnchor" (byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dJointGetUniversalAnchor     cdecl alias "dJointGetUniversalAnchor" (byval as dJointID, byref result as dVector3)
declare sub      dJointGetUniversalAnchor2    cdecl alias "dJointGetUniversalAnchor2" (byval as dJointID, byref result as dVector3)

declare sub      dJointSetUniversalAxis1      cdecl alias "dJointSetUniversalAxis1" (byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dJointGetUniversalAxis1      cdecl alias "dJointGetUniversalAxis1" (byval as dJointID, byref result as dVector3)

declare sub      dJointSetUniversalAxis2      cdecl alias "dJointSetUniversalAxis2" (byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dJointGetUniversalAxis2      cdecl alias "dJointGetUniversalAxis2" (byval as dJointID, byref result as dVector3)

declare sub      dJointSetUniversalParam      cdecl alias "dJointSetUniversalParam" (byval as dJointID, byval parameter as integer, byval value as dReal)
declare function dJointGetUniversalParam      cdecl alias "dJointGetUniversalParam" (byval as dJointID, byval parameter as integer) as dReal

declare sub      dJointAddUniversalTorques    cdecl alias "dJointAddUniversalTorques" (byval joint as dJointID, byval torque1 as dReal, byval torque2 as dReal)

declare function dJointGetUniversalAngle1     cdecl alias "dJointGetUniversalAngle1" (byval as dJointID) as dReal
declare function dJointGetUniversalAngle2     cdecl alias "dJointGetUniversalAngle2" (byval as dJointID) as dReal
declare function dJointGetUniversalAngle1Rate cdecl alias "dJointGetUniversalAngle1Rate" (byval as dJointID) as dReal
declare function dJointGetUniversalAngle2Rate cdecl alias "dJointGetUniversalAngle2Rate" (byval as dJointID) as dReal

declare sub      dJointSetUniversalAxis1Offset cdecl alias "dJointSetUniversalAxis1Offset" (byval as dJointID,byval x as dReal, byval y as dReal, byval z as dReal, byval offset1 as dReal,byval offset2 as dReal)
declare sub      dJointSetUniversalAxis2Offset cdecl alias "dJointSetUniversalAxis2Offset" (byval as dJointID,byval x as dReal, byval y as dReal, byval z as dReal, byval offset1 as dReal,byval offset2 as dReal)

' a motor
declare sub      dJointSetAMotorNumAxes       cdecl alias "dJointSetAMotorNumAxes" (byval as dJointID, byval num as integer)
declare function dJointGetAMotorNumAxes       cdecl alias "dJointGetAMotorNumAxes" (byval as dJointID) as integer

declare sub      dJointSetAMotorAxis          cdecl alias "dJointSetAMotorAxis" (byval as dJointID, byval anum as integer, byval rel as integer, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dJointGetAMotorAxis          cdecl alias "dJointGetAMotorAxis" (byval as dJointID, byval anum as integer, byref result as dVector3)

declare sub      dJointSetAMotorAngle         cdecl alias "dJointSetAMotorAngle" (byval as dJointID, byval anum as integer, byval angle as dReal)
declare function dJointGetAMotorAngle         cdecl alias "dJointGetAMotorAngle" (byval as dJointID, byval anum as integer) as dReal

declare sub      dJointSetAMotorParam         cdecl alias "dJointSetAMotorParam" (byval as dJointID, byval parameter as integer, byval value as dReal)
declare function dJointGetAMotorParam         cdecl alias "dJointGetAMotorParam" (byval as dJointID, byval parameter as integer) as dReal

declare sub      dJointSetAMotorMode          cdecl alias "dJointSetAMotorMode" (byval as dJointID, byval mode as integer)
declare function dJointGetAMotorMode          cdecl alias "dJointGetAMotorMode" (byval as dJointID) as integer

declare function dJointGetAMotorAxisRel       cdecl alias "dJointGetAMotorAxisRel" (byval as dJointID, byval anum as integer) as integer
declare function dJointGetAMotorAngleRate     cdecl alias "dJointGetAMotorAngleRate" (byval as dJointID, byval anum as integer) as dReal

declare sub      dJointAddAMotorTorques       cdecl alias "dJointAddAMotorTorques" (byval as dJointID, byval torque1 as dReal, byval torque2 as dReal, byval torque3 as dReal)


' lmotor
declare sub      dJointSetLMotorNumAxes       cdecl alias "dJointSetLMotorNumAxes" (byval as dJointID,byval num as integer)
declare sub      dJointSetLMotorAxis          cdecl alias "dJointSetLMotorAxis" (byval as dJointID,byval x as dReal, byval y as dReal,byval z as dReal)
declare sub      dJointSetLMotorParam         cdecl alias "dJointSetLMotorParam" (byval as dJointID,byval parameter as integer,byval value as dReal)

' plane2d
declare sub      dJointSetPlane2DXParam       cdecl alias "dJointSetPlane2DXParam" (byval as dJointID,byval parameter as integer,byval value as dReal)
declare sub      dJointSetPlane2DYParam       cdecl alias "dJointSetPlane2DYParam" (byval as dJointID,byval parameter as integer,byval value as dReal)
declare sub      dJointSetPlane2DAngleParam   cdecl alias "dJointSetPlane2DAngleParam" (byval as dJointID,byval parameter as integer,byval value as dReal)

' pr
declare sub      dJointSetPRAnchor            cdecl alias "dJointSetPRAnchor" (byval as dJointID,byval x as dReal, byval y as dReal,byval z as dReal)
declare sub      dJointGetPRAnchor            cdecl alias "dJointGetPRAnchor" (byval as dJointID,byref result as dVector3)

declare sub      dJointSetPRAxis1             cdecl alias "dJointSetPRAxis1" (byval as dJointID,byval x as dReal, byval y as dReal,byval z as dReal)
declare sub      dJointGetPRAxis1             cdecl alias "dJointGetPRAxis1" (byval as dJointID,byref result as dVector3)

declare sub      dJointSetPRAxis2             cdecl alias "dJointSetPRAxis2" (byval as dJointID,byval x as dReal, byval y as dReal,byval z as dReal)
declare sub      dJointGetPRAxis2             cdecl alias "dJointGetPRAxis2" (byval as dJointID,byref result as dVector3)

declare sub      dJointSetPRParam             cdecl alias "dJointSetPRParam" (byval as dJointID,byval parameter as integer,byval value as dReal)
declare function dJointGetPRParam             cdecl alias "dJointGetPRParam" (byval as dJointID,byval parameter as integer) as dReal

declare sub      dJointAddPRTorque            cdecl alias "dJointAddPRTorque" (byval as dJointID,byval torque as dReal)

declare function dJointGetPRPosition          cdecl alias "dJointGetPRPosition" (byval as dJointID) as dReal
declare function dJointGetPRPositionRate      cdecl alias "dJointGetPRPositionRate" (byval as dJointID) as dReal
declare function dJointGetPRAngle             cdecl alias "dJointGetPRAngle"       (byval as dJointID) as dReal
declare function dJointGetPRAngleRate         cdecl alias "dJointGetPRAngleRate"   (byval as dJointID) as dReal

' pu
declare sub      dJointSetPUAnchor            cdecl alias "dJointSetPUAnchor" (byval as dJointID,byval x as dReal, byval y as dReal,byval z as dReal)
declare sub      dJointGetPUAnchor            cdecl alias "dJointGetPUAnchor" (byval as dJointID,byref result as dVector3)
declare sub      dJointSetPUAnchorOffset      cdecl alias "dJointSetPUAnchorOffset" (byval as dJointID,byval x as dReal, byval y as dReal,byval z as dReal, byval ax as dReal,byval ay as dReal,byval az as dReal)

declare sub      dJointSetPUAxis1             cdecl alias "dJointSetPUAxis1" (byval as dJointID,byval x as dReal, byval y as dReal,byval z as dReal)
declare sub      dJointGetPUAxis1             cdecl alias "dJointGetPUAxis1" (byval as dJointID,byref result as dVector3)

declare sub      dJointSetPUAxis2             cdecl alias "dJointSetPUAxis2" (byval as dJointID,byval x as dReal, byval y as dReal,byval z as dReal)
declare sub      dJointGetPUAxis2             cdecl alias "dJointGetPUAxis2" (byval as dJointID,byref result as dVector3)

declare sub      dJointSetPUAxis3             cdecl alias "dJointSetPUAxis3" (byval as dJointID,byval x as dReal, byval y as dReal,byval z as dReal)
declare sub      dJointGetPUAxis3             cdecl alias "dJointGetPUAxis3" (byval as dJointID,byref result as dVector3)

declare sub      dJointSetPUParam             cdecl alias "dJointSetPUParam" (byval as dJointID,byval parameter as integer,byval value as dReal)
declare function dJointGetPUParam             cdecl alias "dJointGetPUParam" (byval as dJointID,byval parameter as integer) as dReal

declare sub      dJointSetPUAxisP             cdecl alias "dJointSetPUAxisP" (byval as dJointID,byval x as dReal, byval y as dReal,byval z as dReal)
declare sub      dJointGetPUAxisP             cdecl alias "dJointGetPUAxisP" (byval as dJointID,byref result as dVector3)

declare sub      dJointAddPUTorque            cdecl alias "dJointAddPUTorque"      (byval as dJointID,byval torque as dReal)
declare function dJointGetPUPosition          cdecl alias "dJointGetPUPosition"    (byval as dJointID) as dReal
declare function dJointGetPUPositionRate      cdecl alias "dJointGetPUPositionRate" (byval as dJointID) as dReal
declare sub      dJointGetPUAngles            cdecl alias "dJointGetPUAngles"      (byval as dJointID,byval angle1 as dReal ptr,byval angle2 as dReal ptr)
declare function dJointGetPUAngle1            cdecl alias "dJointGetPUAngle1"      (byval as dJointID) as dReal
declare function dJointGetPUAngle1Rate        cdecl alias "dJointGetPUAngle1Rate"  (byval as dJointID) as dReal
declare function dJointGetPUAngle2            cdecl alias "dJointGetPUAngle2"      (byval as dJointID) as dReal
declare function dJointGetPUAngle2Rate        cdecl alias "dJointGetPUAngle2Rate"  (byval as dJointID) as dReal

' piston
declare sub      dJointSetPistonAxis          cdecl alias "dJointSetPistonAxis" (byval as dJointID,byval x as dReal, byval y as dReal,byval z as dReal)
declare sub      dJointGetPistonAxis          cdecl alias "dJointGetPistonAxis" (byval as dJointID,byref result as dVector3)

declare sub      dJointSetPistonParam         cdecl alias "dJointSetPistonParam" (byval as dJointID,byval parameter as integer,byval value as dReal)
declare function dJointGetPistonParam         cdecl alias "dJointGetPistonParam" (byval as dJointID,byval parameter as integer) as dReal

declare function dJointGetPistonPosition      cdecl alias "dJointGetPistonPosition"     (byval as dJointID) as dReal
declare function dJointGetPistonPositionRate  cdecl alias "dJointGetPistonPositionRate" (byval as dJointID) as dReal

declare function dJointGetPistonAngle         cdecl alias "dJointGetPistonAngle"     (byval as dJointID) as dReal
declare function dJointGetPistonAngleRate     cdecl alias "dJointGetPistonAngleRate" (byval as dJointID) as dReal

declare sub      dJointGetPistonAnchor        cdecl alias "dJointGetPistonAnchor"       (byval as dJointID,byref result as dVector3)
declare sub      dJointGetPistonAnchor2       cdecl alias "dJointGetPistonAnchor2"      (byval as dJointID,byref result as dVector3)
declare sub      dJointSetPistonAnchorOffset  cdecl alias "dJointSetPistonAnchorOffset" (byval as dJointID,byval x as dReal, byval y as dReal,byval z as dReal,byval ax as dReal,byval ay as dReal,byval az as dReal)

declare sub      dJointAddPistonForce         cdecl alias "dJointAddPistonForce" (byval as dJointID,byval force as dReal)





' helpers
declare function dAreConnected                cdecl alias "dAreConnected" (byval as dBodyID, byval as dBodyID) as integer
declare function dAreConnectedExcluding       cdecl alias "dAreConnectedExcluding" (byval as dBodyID, byval as dBodyID, byval joint_type as integer) as integer

#endif
