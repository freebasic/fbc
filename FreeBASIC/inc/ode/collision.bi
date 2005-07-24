''
''
'' collision -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __collision_bi__
#define __collision_bi__

#include once "ode/common.bi"
#include once "ode/collision_space.bi"
#include once "ode/contact.bi"

declare sub dGeomDestroy cdecl alias "dGeomDestroy" (byval as dGeomID)
declare sub dGeomSetData cdecl alias "dGeomSetData" (byval as dGeomID, byval as any ptr)
declare function dGeomGetData cdecl alias "dGeomGetData" (byval as dGeomID) as any ptr
declare sub dGeomSetBody cdecl alias "dGeomSetBody" (byval as dGeomID, byval as dBodyID)
declare function dGeomGetBody cdecl alias "dGeomGetBody" (byval as dGeomID) as dBodyID
declare sub dGeomSetPosition cdecl alias "dGeomSetPosition" (byval as dGeomID, byval x as dReal, byval y as dReal, byval z as dReal)
declare sub dGeomSetRotation cdecl alias "dGeomSetRotation" (byval as dGeomID, byval R as dMatrix3)
declare sub dGeomSetQuaternion cdecl alias "dGeomSetQuaternion" (byval as dGeomID, byval as dQuaternion)
declare function dGeomGetPosition cdecl alias "dGeomGetPosition" (byval as dGeomID) as dReal ptr
declare function dGeomGetRotation cdecl alias "dGeomGetRotation" (byval as dGeomID) as dReal ptr
declare sub dGeomGetQuaternion cdecl alias "dGeomGetQuaternion" (byval as dGeomID, byval result as dQuaternion)
declare sub dGeomGetAABB cdecl alias "dGeomGetAABB" (byval as dGeomID, byval aabb as dReal ptr)
declare function dGeomIsSpace cdecl alias "dGeomIsSpace" (byval as dGeomID) as integer
declare function dGeomGetSpace cdecl alias "dGeomGetSpace" (byval as dGeomID) as dSpaceID
declare function dGeomGetClass cdecl alias "dGeomGetClass" (byval as dGeomID) as integer
declare sub dGeomSetCategoryBits cdecl alias "dGeomSetCategoryBits" (byval as dGeomID, byval bits as uinteger)
declare sub dGeomSetCollideBits cdecl alias "dGeomSetCollideBits" (byval as dGeomID, byval bits as uinteger)
declare function dGeomGetCategoryBits cdecl alias "dGeomGetCategoryBits" (byval as dGeomID) as uinteger
declare function dGeomGetCollideBits cdecl alias "dGeomGetCollideBits" (byval as dGeomID) as uinteger
declare sub dGeomEnable cdecl alias "dGeomEnable" (byval as dGeomID)
declare sub dGeomDisable cdecl alias "dGeomDisable" (byval as dGeomID)
declare function dGeomIsEnabled cdecl alias "dGeomIsEnabled" (byval as dGeomID) as integer
declare function dCollide cdecl alias "dCollide" (byval o1 as dGeomID, byval o2 as dGeomID, byval flags as integer, byval contact as dContactGeom ptr, byval skip as integer) as integer
declare sub dSpaceCollide cdecl alias "dSpaceCollide" (byval space as dSpaceID, byval data as any ptr, byval callback as dNearCallback ptr)
declare sub dSpaceCollide2 cdecl alias "dSpaceCollide2" (byval o1 as dGeomID, byval o2 as dGeomID, byval data as any ptr, byval callback as dNearCallback ptr)

enum 
	dMaxUserClasses = 4
end enum

enum 
	dSphereClass = 0
	dBoxClass
	dCCylinderClass
	dCylinderClass
	dPlaneClass
	dRayClass
	dGeomTransformClass
	dTriMeshClass
	dFirstSpaceClass
	dSimpleSpaceClass = dFirstSpaceClass
	dHashSpaceClass
	dQuadTreeSpaceClass
	dLastSpaceClass = dQuadTreeSpaceClass
	dFirstUserClass
	dLastUserClass = dFirstUserClass+dMaxUserClasses-1
	dGeomNumClasses
end enum

declare function dCreateSphere cdecl alias "dCreateSphere" (byval space as dSpaceID, byval radius as dReal) as dGeomID
declare sub dGeomSphereSetRadius cdecl alias "dGeomSphereSetRadius" (byval sphere as dGeomID, byval radius as dReal)
declare function dGeomSphereGetRadius cdecl alias "dGeomSphereGetRadius" (byval sphere as dGeomID) as dReal
declare function dGeomSpherePointDepth cdecl alias "dGeomSpherePointDepth" (byval sphere as dGeomID, byval x as dReal, byval y as dReal, byval z as dReal) as dReal
declare function dCreateBox cdecl alias "dCreateBox" (byval space as dSpaceID, byval lx as dReal, byval ly as dReal, byval lz as dReal) as dGeomID
declare sub dGeomBoxSetLengths cdecl alias "dGeomBoxSetLengths" (byval box as dGeomID, byval lx as dReal, byval ly as dReal, byval lz as dReal)
declare sub dGeomBoxGetLengths cdecl alias "dGeomBoxGetLengths" (byval box as dGeomID, byval result as dVector3)
declare function dGeomBoxPointDepth cdecl alias "dGeomBoxPointDepth" (byval box as dGeomID, byval x as dReal, byval y as dReal, byval z as dReal) as dReal
declare function dCreatePlane cdecl alias "dCreatePlane" (byval space as dSpaceID, byval a as dReal, byval b as dReal, byval c as dReal, byval d as dReal) as dGeomID
declare sub dGeomPlaneSetParams cdecl alias "dGeomPlaneSetParams" (byval plane as dGeomID, byval a as dReal, byval b as dReal, byval c as dReal, byval d as dReal)
declare sub dGeomPlaneGetParams cdecl alias "dGeomPlaneGetParams" (byval plane as dGeomID, byval result as dVector4)
declare function dGeomPlanePointDepth cdecl alias "dGeomPlanePointDepth" (byval plane as dGeomID, byval x as dReal, byval y as dReal, byval z as dReal) as dReal
declare function dCreateCCylinder cdecl alias "dCreateCCylinder" (byval space as dSpaceID, byval radius as dReal, byval length as dReal) as dGeomID
declare sub dGeomCCylinderSetParams cdecl alias "dGeomCCylinderSetParams" (byval ccylinder as dGeomID, byval radius as dReal, byval length as dReal)
declare sub dGeomCCylinderGetParams cdecl alias "dGeomCCylinderGetParams" (byval ccylinder as dGeomID, byval radius as dReal ptr, byval length as dReal ptr)
declare function dGeomCCylinderPointDepth cdecl alias "dGeomCCylinderPointDepth" (byval ccylinder as dGeomID, byval x as dReal, byval y as dReal, byval z as dReal) as dReal
declare function dCreateRay cdecl alias "dCreateRay" (byval space as dSpaceID, byval length as dReal) as dGeomID
declare sub dGeomRaySetLength cdecl alias "dGeomRaySetLength" (byval ray as dGeomID, byval length as dReal)
declare function dGeomRayGetLength cdecl alias "dGeomRayGetLength" (byval ray as dGeomID) as dReal
declare sub dGeomRaySet cdecl alias "dGeomRaySet" (byval ray as dGeomID, byval px as dReal, byval py as dReal, byval pz as dReal, byval dx as dReal, byval dy as dReal, byval dz as dReal)
declare sub dGeomRayGet cdecl alias "dGeomRayGet" (byval ray as dGeomID, byval start as dVector3, byval dir as dVector3)
declare sub dGeomRaySetParams cdecl alias "dGeomRaySetParams" (byval g as dGeomID, byval FirstContact as integer, byval BackfaceCull as integer)
declare sub dGeomRayGetParams cdecl alias "dGeomRayGetParams" (byval g as dGeomID, byval FirstContact as integer ptr, byval BackfaceCull as integer ptr)
declare sub dGeomRaySetClosestHit cdecl alias "dGeomRaySetClosestHit" (byval g as dGeomID, byval closestHit as integer)
declare function dGeomRayGetClosestHit cdecl alias "dGeomRayGetClosestHit" (byval g as dGeomID) as integer

#include once "ode/collision_trimesh.bi"

declare function dCreateGeomTransform cdecl alias "dCreateGeomTransform" (byval space as dSpaceID) as dGeomID
declare sub dGeomTransformSetGeom cdecl alias "dGeomTransformSetGeom" (byval g as dGeomID, byval obj as dGeomID)
declare function dGeomTransformGetGeom cdecl alias "dGeomTransformGetGeom" (byval g as dGeomID) as dGeomID
declare sub dGeomTransformSetCleanup cdecl alias "dGeomTransformSetCleanup" (byval g as dGeomID, byval mode as integer)
declare function dGeomTransformGetCleanup cdecl alias "dGeomTransformGetCleanup" (byval g as dGeomID) as integer
declare sub dGeomTransformSetInfo cdecl alias "dGeomTransformSetInfo" (byval g as dGeomID, byval mode as integer)
declare function dGeomTransformGetInfo cdecl alias "dGeomTransformGetInfo" (byval g as dGeomID) as integer
declare sub dClosestLineSegmentPoints cdecl alias "dClosestLineSegmentPoints" (byval a1 as dVector3, byval a2 as dVector3, byval b1 as dVector3, byval b2 as dVector3, byval cp1 as dVector3, byval cp2 as dVector3)
declare function dBoxTouchesBox cdecl alias "dBoxTouchesBox" (byval _p1 as dVector3, byval R1 as dMatrix3, byval side1 as dVector3, byval _p2 as dVector3, byval R2 as dMatrix3, byval side2 as dVector3) as integer
declare sub dInfiniteAABB cdecl alias "dInfiniteAABB" (byval geom as dGeomID, byval aabb as dReal ptr)
declare sub dCloseODE cdecl alias "dCloseODE" ()

type dGetAABBFn as any
type dColliderFn as integer
type dGetColliderFnFn as dColliderFn
type dGeomDtorFn as any
type dAABBTestFn as integer

type dGeomClass
	bytes as integer
	collider as dGetColliderFnFn ptr
	aabb as dGetAABBFn ptr
	aabb_test as dAABBTestFn ptr
	dtor as dGeomDtorFn ptr
end type

declare function dCreateGeomClass cdecl alias "dCreateGeomClass" (byval classptr as dGeomClass ptr) as integer
declare function dGeomGetClassData cdecl alias "dGeomGetClassData" (byval as dGeomID) as any ptr
declare function dCreateGeom cdecl alias "dCreateGeom" (byval classnum as integer) as dGeomID

#endif
