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
declare function dWorldGetAutoDisableLinearThreshold cdecl alias "dWorldGetAutoDisableLinearThreshold" (byval as dWorldID) as dReal
declare sub      dWorldSetAutoDisableLinearThreshold cdecl alias "dWorldSetAutoDisableLinearThreshold" (byval as dWorldID, byval linear_threshold as dReal)
declare function dWorldGetAutoDisableAngularThreshold cdecl alias "dWorldGetAutoDisableAngularThreshold" (byval as dWorldID) as dReal
declare sub      dWorldSetAutoDisableAngularThreshold cdecl alias "dWorldSetAutoDisableAngularThreshold" (byval as dWorldID, byval angular_threshold as dReal)
declare function dWorldGetAutoDisableSteps cdecl alias "dWorldGetAutoDisableSteps" (byval as dWorldID) as integer
declare sub      dWorldSetAutoDisableSteps cdecl alias "dWorldSetAutoDisableSteps" (byval as dWorldID, byval steps as integer)
declare function dWorldGetAutoDisableTime cdecl alias "dWorldGetAutoDisableTime" (byval as dWorldID) as dReal
declare sub      dWorldSetAutoDisableTime cdecl alias "dWorldSetAutoDisableTime" (byval as dWorldID, byval time as dReal)
declare function dWorldGetAutoDisableFlag cdecl alias "dWorldGetAutoDisableFlag" (byval as dWorldID) as integer
declare sub      dWorldSetAutoDisableFlag cdecl alias "dWorldSetAutoDisableFlag" (byval as dWorldID, byval do_auto_disable as integer)

'
' body
'
declare function dBodyCreate    cdecl alias "dBodyCreate"    (byval as dWorldID) as dBodyID
declare sub      dBodyDestroy   cdecl alias "dBodyDestroy"   (byval as dBodyID)

declare sub      dBodyEnable    cdecl alias "dBodyEnable"    (byval as dBodyID)
declare sub      dBodyDisable   cdecl alias "dBodyDisable"   (byval as dBodyID)
declare function dBodyIsEnabled cdecl alias "dBodyIsEnabled" (byval as dBodyID) as integer

declare function dBodyGetAutoDisableLinearThreshold cdecl alias "dBodyGetAutoDisableLinearThreshold" (byval as dBodyID) as dReal
declare sub      dBodySetAutoDisableLinearThreshold cdecl alias "dBodySetAutoDisableLinearThreshold" (byval as dBodyID, byval linear_threshold as dReal)

declare function dBodyGetAutoDisableAngularThreshold cdecl alias "dBodyGetAutoDisableAngularThreshold" (byval as dBodyID) as dReal
declare sub      dBodySetAutoDisableAngularThreshold cdecl alias "dBodySetAutoDisableAngularThreshold" (byval as dBodyID, byval angular_threshold as dReal)

declare function dBodyGetAutoDisableSteps cdecl alias "dBodyGetAutoDisableSteps" (byval as dBodyID) as integer
declare sub      dBodySetAutoDisableSteps cdecl alias "dBodySetAutoDisableSteps" (byval as dBodyID, byval steps as integer)

declare function dBodyGetAutoDisableTime cdecl alias "dBodyGetAutoDisableTime" (byval as dBodyID) as dReal
declare sub      dBodySetAutoDisableTime cdecl alias "dBodySetAutoDisableTime" (byval as dBodyID, byval time as dReal)

declare function dBodyGetAutoDisableFlag cdecl alias "dBodyGetAutoDisableFlag" (byval as dBodyID) as integer
declare sub      dBodySetAutoDisableFlag cdecl alias "dBodySetAutoDisableFlag" (byval as dBodyID, byval do_auto_disable as integer)

declare sub      dBodySetAutoDisableDefaults cdecl alias "dBodySetAutoDisableDefaults" (byval as dBodyID)

declare sub      dBodySetData cdecl alias "dBodySetData" (byval as dBodyID, byval data as any ptr)
declare function dBodyGetData cdecl alias "dBodyGetData" (byval as dBodyID) as any ptr

declare sub      dBodySetPosition cdecl alias "dBodySetPosition" (byval as dBodyID, byval x as dReal, byval y as dReal, byval z as dReal)
declare function dBodyGetPosition cdecl alias "dBodyGetPosition" (byval as dBodyID) as dReal ptr

declare sub      dBodySetRotation cdecl alias "dBodySetRotation" (byval as dBodyID, byref R as dMatrix3)
declare function dBodyGetRotation cdecl alias "dBodyGetRotation" (byval as dBodyID) as dReal ptr

declare sub      dBodySetQuaternion cdecl alias "dBodySetQuaternion" (byval as dBodyID, byref q as dQuaternion)
declare function dBodyGetQuaternion cdecl alias "dBodyGetQuaternion" (byval as dBodyID) as dReal ptr

declare sub      dBodySetLinearVel cdecl alias "dBodySetLinearVel" (byval as dBodyID, byval x as dReal, byval y as dReal, byval z as dReal)
declare function dBodyGetLinearVel cdecl alias "dBodyGetLinearVel" (byval as dBodyID) as dReal ptr

declare sub      dBodySetAngularVel cdecl alias "dBodySetAngularVel" (byval as dBodyID, byval x as dReal, byval y as dReal, byval z as dReal)
declare function dBodyGetAngularVel cdecl alias "dBodyGetAngularVel" (byval as dBodyID) as dReal ptr

declare sub      dBodySetMass cdecl alias "dBodySetMass" (byval as dBodyID, byval mass as dMass ptr)
declare sub      dBodyGetMass cdecl alias "dBodyGetMass" (byval as dBodyID, byval mass as dMass ptr)

declare sub      dBodyAddForce cdecl alias "dBodyAddForce" (byval as dBodyID, byval fx as dReal, byval fy as dReal, byval fz as dReal)
declare sub      dBodyAddTorque cdecl alias "dBodyAddTorque" (byval as dBodyID, byval fx as dReal, byval fy as dReal, byval fz as dReal)

declare sub      dBodyAddRelForce cdecl alias "dBodyAddRelForce" (byval as dBodyID, byval fx as dReal, byval fy as dReal, byval fz as dReal)
declare sub      dBodyAddRelTorque cdecl alias "dBodyAddRelTorque" (byval as dBodyID, byval fx as dReal, byval fy as dReal, byval fz as dReal)

declare sub      dBodyAddForceAtPos cdecl alias "dBodyAddForceAtPos" (byval as dBodyID, byval fx as dReal, byval fy as dReal, byval fz as dReal, byval px as dReal, byval py as dReal, byval pz as dReal)
declare sub      dBodyAddForceAtRelPos cdecl alias "dBodyAddForceAtRelPos" (byval as dBodyID, byval fx as dReal, byval fy as dReal, byval fz as dReal, byval px as dReal, byval py as dReal, byval pz as dReal)

declare sub      dBodyAddRelForceAtPos cdecl alias "dBodyAddRelForceAtPos" (byval as dBodyID, byval fx as dReal, byval fy as dReal, byval fz as dReal, byval px as dReal, byval py as dReal, byval pz as dReal)
declare sub      dBodyAddRelForceAtRelPos cdecl alias "dBodyAddRelForceAtRelPos" (byval as dBodyID, byval fx as dReal, byval fy as dReal, byval fz as dReal, byval px as dReal, byval py as dReal, byval pz as dReal)

declare sub      dBodySetForce cdecl alias "dBodySetForce" (byval b as dBodyID, byval x as dReal, byval y as dReal, byval z as dReal)
declare function dBodyGetForce cdecl alias "dBodyGetForce" (byval as dBodyID) as dReal ptr

declare sub      dBodySetTorque cdecl alias "dBodySetTorque" (byval b as dBodyID, byval x as dReal, byval y as dReal, byval z as dReal)
declare function dBodyGetTorque cdecl alias "dBodyGetTorque" (byval as dBodyID) as dReal ptr

declare sub      dBodyGetRelPointPos cdecl alias "dBodyGetRelPointPos" (byval as dBodyID, byval px as dReal, byval py as dReal, byval pz as dReal, byval result as dVector3)
declare sub      dBodyGetRelPointVel cdecl alias "dBodyGetRelPointVel" (byval as dBodyID, byval px as dReal, byval py as dReal, byval pz as dReal, byval result as dVector3)

declare sub      dBodyGetPointVel cdecl alias "dBodyGetPointVel" (byval as dBodyID, byval px as dReal, byval py as dReal, byval pz as dReal, byval result as dVector3)
declare sub      dBodyGetPosRelPoint cdecl alias "dBodyGetPosRelPoint" (byval as dBodyID, byval px as dReal, byval py as dReal, byval pz as dReal, byval result as dVector3)

declare sub      dBodyVectorToWorld cdecl alias "dBodyVectorToWorld" (byval as dBodyID, byval px as dReal, byval py as dReal, byval pz as dReal, byval result as dVector3)
declare sub      dBodyVectorFromWorld cdecl alias "dBodyVectorFromWorld" (byval as dBodyID, byval px as dReal, byval py as dReal, byval pz as dReal, byval result as dVector3)

declare sub      dBodySetFiniteRotationMode cdecl alias "dBodySetFiniteRotationMode" (byval as dBodyID, byval mode as integer)
declare function dBodyGetFiniteRotationMode cdecl alias "dBodyGetFiniteRotationMode" (byval as dBodyID) as integer

declare sub      dBodySetFiniteRotationAxis cdecl alias "dBodySetFiniteRotationAxis" (byval as dBodyID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dBodyGetFiniteRotationAxis cdecl alias "dBodyGetFiniteRotationAxis" (byval as dBodyID, byval result as dVector3)

declare function dBodyGetNumJoints cdecl alias "dBodyGetNumJoints" (byval b as dBodyID) as integer
declare function dBodyGetJoint cdecl alias "dBodyGetJoint" (byval as dBodyID, byval index as integer) as dJointID

declare sub      dBodySetGravityMode cdecl alias "dBodySetGravityMode" (byval b as dBodyID, byval mode as integer)
declare function dBodyGetGravityMode cdecl alias "dBodyGetGravityMode" (byval b as dBodyID) as integer

'
' joints 
'
declare function dJointCreateBall cdecl alias "dJointCreateBall" (byval as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreateHinge cdecl alias "dJointCreateHinge" (byval as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreateSlider cdecl alias "dJointCreateSlider" (byval as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreateContact cdecl alias "dJointCreateContact" (byval as dWorldID, byval as dJointGroupID, byval as dContact ptr) as dJointID
declare function dJointCreateHinge2 cdecl alias "dJointCreateHinge2" (byval as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreateUniversal cdecl alias "dJointCreateUniversal" (byval as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreateFixed cdecl alias "dJointCreateFixed" (byval as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreateNull cdecl alias "dJointCreateNull" (byval as dWorldID, byval as dJointGroupID) as dJointID
declare function dJointCreateAMotor cdecl alias "dJointCreateAMotor" (byval as dWorldID, byval as dJointGroupID) as dJointID
declare sub      dJointDestroy cdecl alias "dJointDestroy" (byval as dJointID)
declare function dJointGroupCreate cdecl alias "dJointGroupCreate" (byval max_size as integer) as dJointGroupID
declare sub      dJointGroupDestroy cdecl alias "dJointGroupDestroy" (byval as dJointGroupID)
declare sub      dJointGroupEmpty cdecl alias "dJointGroupEmpty" (byval as dJointGroupID)
declare sub      dJointAttach cdecl alias "dJointAttach" (byval as dJointID, byval body1 as dBodyID, byval body2 as dBodyID)

declare sub      dJointSetData cdecl alias "dJointSetData" (byval as dJointID, byval data as any ptr)
declare function dJointGetData cdecl alias "dJointGetData" (byval as dJointID) as any ptr

declare function dJointGetType cdecl alias "dJointGetType" (byval as dJointID) as integer
declare function dJointGetBody cdecl alias "dJointGetBody" (byval as dJointID, byval index as integer) as dBodyID

declare sub      dJointSetFeedback cdecl alias "dJointSetFeedback" (byval as dJointID, byval as dJointFeedback ptr)
declare function dJointGetFeedback cdecl alias "dJointGetFeedback" (byval as dJointID) as dJointFeedback ptr

declare sub      dJointSetBallAnchor cdecl alias "dJointSetBallAnchor" (byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dJointSetHingeAnchor cdecl alias "dJointSetHingeAnchor" (byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dJointSetHingeAxis cdecl alias "dJointSetHingeAxis" (byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dJointSetHingeParam cdecl alias "dJointSetHingeParam" (byval as dJointID, byval parameter as integer, byval value as dReal)
declare sub      dJointAddHingeTorque cdecl alias "dJointAddHingeTorque" (byval joint as dJointID, byval torque as dReal)
declare sub      dJointSetSliderAxis cdecl alias "dJointSetSliderAxis" (byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dJointSetSliderParam cdecl alias "dJointSetSliderParam" (byval as dJointID, byval parameter as integer, byval value as dReal)
declare sub      dJointAddSliderForce cdecl alias "dJointAddSliderForce" (byval joint as dJointID, byval force as dReal)
declare sub      dJointSetHinge2Anchor cdecl alias "dJointSetHinge2Anchor" (byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dJointSetHinge2Axis1 cdecl alias "dJointSetHinge2Axis1" (byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dJointSetHinge2Axis2 cdecl alias "dJointSetHinge2Axis2" (byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dJointSetHinge2Param cdecl alias "dJointSetHinge2Param" (byval as dJointID, byval parameter as integer, byval value as dReal)
declare sub      dJointAddHinge2Torques cdecl alias "dJointAddHinge2Torques" (byval joint as dJointID, byval torque1 as dReal, byval torque2 as dReal)
declare sub      dJointSetUniversalAnchor cdecl alias "dJointSetUniversalAnchor" (byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dJointSetUniversalAxis1 cdecl alias "dJointSetUniversalAxis1" (byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dJointSetUniversalAxis2 cdecl alias "dJointSetUniversalAxis2" (byval as dJointID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dJointSetUniversalParam cdecl alias "dJointSetUniversalParam" (byval as dJointID, byval parameter as integer, byval value as dReal)
declare sub      dJointAddUniversalTorques cdecl alias "dJointAddUniversalTorques" (byval joint as dJointID, byval torque1 as dReal, byval torque2 as dReal)
declare sub      dJointSetFixed cdecl alias "dJointSetFixed" (byval as dJointID)
declare sub      dJointSetAMotorNumAxes cdecl alias "dJointSetAMotorNumAxes" (byval as dJointID, byval num as integer)
declare sub      dJointSetAMotorAxis cdecl alias "dJointSetAMotorAxis" (byval as dJointID, byval anum as integer, byval rel as integer, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub      dJointSetAMotorAngle cdecl alias "dJointSetAMotorAngle" (byval as dJointID, byval anum as integer, byval angle as dReal)
declare sub      dJointSetAMotorParam cdecl alias "dJointSetAMotorParam" (byval as dJointID, byval parameter as integer, byval value as dReal)
declare sub      dJointSetAMotorMode cdecl alias "dJointSetAMotorMode" (byval as dJointID, byval mode as integer)
declare sub      dJointAddAMotorTorques cdecl alias "dJointAddAMotorTorques" (byval as dJointID, byval torque1 as dReal, byval torque2 as dReal, byval torque3 as dReal)
declare sub      dJointGetBallAnchor cdecl alias "dJointGetBallAnchor" (byval as dJointID, byval result as dVector3)
declare sub      dJointGetBallAnchor2 cdecl alias "dJointGetBallAnchor2" (byval as dJointID, byval result as dVector3)
declare sub      dJointGetHingeAnchor cdecl alias "dJointGetHingeAnchor" (byval as dJointID, byval result as dVector3)
declare sub      dJointGetHingeAnchor2 cdecl alias "dJointGetHingeAnchor2" (byval as dJointID, byval result as dVector3)
declare sub      dJointGetHingeAxis cdecl alias "dJointGetHingeAxis" (byval as dJointID, byval result as dVector3)
declare function dJointGetHingeParam cdecl alias "dJointGetHingeParam" (byval as dJointID, byval parameter as integer) as dReal
declare function dJointGetHingeAngle cdecl alias "dJointGetHingeAngle" (byval as dJointID) as dReal
declare function dJointGetHingeAngleRate cdecl alias "dJointGetHingeAngleRate" (byval as dJointID) as dReal
declare function dJointGetSliderPosition cdecl alias "dJointGetSliderPosition" (byval as dJointID) as dReal
declare function dJointGetSliderPositionRate cdecl alias "dJointGetSliderPositionRate" (byval as dJointID) as dReal
declare sub      dJointGetSliderAxis cdecl alias "dJointGetSliderAxis" (byval as dJointID, byval result as dVector3)
declare function dJointGetSliderParam cdecl alias "dJointGetSliderParam" (byval as dJointID, byval parameter as integer) as dReal
declare sub      dJointGetHinge2Anchor cdecl alias "dJointGetHinge2Anchor" (byval as dJointID, byval result as dVector3)
declare sub      dJointGetHinge2Anchor2 cdecl alias "dJointGetHinge2Anchor2" (byval as dJointID, byval result as dVector3)
declare sub      dJointGetHinge2Axis1 cdecl alias "dJointGetHinge2Axis1" (byval as dJointID, byval result as dVector3)
declare sub      dJointGetHinge2Axis2 cdecl alias "dJointGetHinge2Axis2" (byval as dJointID, byval result as dVector3)
declare function dJointGetHinge2Param cdecl alias "dJointGetHinge2Param" (byval as dJointID, byval parameter as integer) as dReal
declare function dJointGetHinge2Angle1 cdecl alias "dJointGetHinge2Angle1" (byval as dJointID) as dReal
declare function dJointGetHinge2Angle1Rate cdecl alias "dJointGetHinge2Angle1Rate" (byval as dJointID) as dReal
declare function dJointGetHinge2Angle2Rate cdecl alias "dJointGetHinge2Angle2Rate" (byval as dJointID) as dReal
declare sub      dJointGetUniversalAnchor cdecl alias "dJointGetUniversalAnchor" (byval as dJointID, byval result as dVector3)
declare sub      dJointGetUniversalAnchor2 cdecl alias "dJointGetUniversalAnchor2" (byval as dJointID, byval result as dVector3)
declare sub      dJointGetUniversalAxis1 cdecl alias "dJointGetUniversalAxis1" (byval as dJointID, byval result as dVector3)
declare sub      dJointGetUniversalAxis2 cdecl alias "dJointGetUniversalAxis2" (byval as dJointID, byval result as dVector3)
declare function dJointGetUniversalParam cdecl alias "dJointGetUniversalParam" (byval as dJointID, byval parameter as integer) as dReal
declare function dJointGetUniversalAngle1 cdecl alias "dJointGetUniversalAngle1" (byval as dJointID) as dReal
declare function dJointGetUniversalAngle2 cdecl alias "dJointGetUniversalAngle2" (byval as dJointID) as dReal
declare function dJointGetUniversalAngle1Rate cdecl alias "dJointGetUniversalAngle1Rate" (byval as dJointID) as dReal
declare function dJointGetUniversalAngle2Rate cdecl alias "dJointGetUniversalAngle2Rate" (byval as dJointID) as dReal
declare function dJointGetAMotorNumAxes cdecl alias "dJointGetAMotorNumAxes" (byval as dJointID) as integer
declare sub      dJointGetAMotorAxis cdecl alias "dJointGetAMotorAxis" (byval as dJointID, byval anum as integer, byval result as dVector3)
declare function dJointGetAMotorAxisRel cdecl alias "dJointGetAMotorAxisRel" (byval as dJointID, byval anum as integer) as integer
declare function dJointGetAMotorAngle cdecl alias "dJointGetAMotorAngle" (byval as dJointID, byval anum as integer) as dReal
declare function dJointGetAMotorAngleRate cdecl alias "dJointGetAMotorAngleRate" (byval as dJointID, byval anum as integer) as dReal
declare function dJointGetAMotorParam cdecl alias "dJointGetAMotorParam" (byval as dJointID, byval parameter as integer) as dReal
declare function dJointGetAMotorMode cdecl alias "dJointGetAMotorMode" (byval as dJointID) as integer
' helpers
declare function dAreConnected cdecl alias "dAreConnected" (byval as dBodyID, byval as dBodyID) as integer
declare function dAreConnectedExcluding cdecl alias "dAreConnectedExcluding" (byval as dBodyID, byval as dBodyID, byval joint_type as integer) as integer

#endif
