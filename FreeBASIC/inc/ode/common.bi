''
''
'' common -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __common_bi__
#define __common_bi__

#include once "ode/config.bi"
#include once "ode/error.bi"

#define EFFICIENT_ALIGNMENT 16

type dReal as single
type dVector3 as dReal ptr
type dVector4 as dReal ptr
type dMatrix3 as dReal ptr
type dMatrix4 as dReal ptr
type dMatrix6 as dReal ptr
type dQuaternion as dReal ptr
type dWorldID as dxWorld ptr
type dSpaceID as dxSpace ptr
type dBodyID as dxBody ptr
type dGeomID as dxGeom ptr
type dJointID as dxJoint ptr
type dJointGroupID as dxJointGroup ptr

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
	dParamGroup = &h100
end enum

enum 
	dAMotorUser = 0
	dAMotorEuler = 1
end enum

type dJointFeedback
	f1 as dVector3
	t1 as dVector3
	f2 as dVector3
	t2 as dVector3
end type

declare sub dGeomMoved cdecl alias "dGeomMoved" (byval as dGeomID)
declare function dGeomGetBodyNext cdecl alias "dGeomGetBodyNext" (byval as dGeomID) as dGeomID

#endif
