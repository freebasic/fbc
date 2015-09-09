'' FreeBASIC binding for newton-3.13
''
'' based on the C header files:
''   Newton zlib license
''   Copyright (c) <2003-2011> 
''
''   This software is provided 'as-is', without any express or implied
''   warranty. In no event will the authors be held liable for any damages
''   arising from the use of this software.
''
''   Permission is granted to anyone to use this software for any purpose,
''   including commercial applications, and to alter it and redistribute it
''   freely, subject to the following restrictions:
''
''   1. The origin of this software must not be misrepresented; you must not
''   claim that you wrote the original software. If you use this software
''   in a product, an acknowledgment in the product documentation would be
''   appreciated but is not required.
''
''   2. Altered source versions must be plainly marked as such, and must not be
''   misrepresented as being the original software.
''
''   3. This notice may not be removed or altered from any source distribution.
''
''   Julio Jerez and Alain Suero
''   http://www.gzip.org/zlib/zlib_license.html
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "Newton"

extern "C"

#define __NEWTON_H__
const NEWTON_MAJOR_VERSION = 3
const NEWTON_MINOR_VERSION = 13
type dLong as longint

#ifdef __USE_DOUBLE_PRECISION__
	type dFloat as double
#else
	type dFloat as single
#endif

type dFloat64 as double
const NEWTON_BROADPHASE_DEFAULT = 0
const NEWTON_BROADPHASE_PERSINTENT = 1
const NEWTON_DYNAMIC_BODY = 0
const NEWTON_KINEMATIC_BODY = 1
const NEWTON_DEFORMABLE_BODY = 2
const SERIALIZE_ID_SPHERE = 0
const SERIALIZE_ID_CAPSULE = 1
const SERIALIZE_ID_CHAMFERCYLINDER = 2
const SERIALIZE_ID_TAPEREDCAPSULE = 3
const SERIALIZE_ID_CYLINDER = 4
const SERIALIZE_ID_TAPEREDCYLINDER = 5
const SERIALIZE_ID_BOX = 6
const SERIALIZE_ID_CONE = 7
const SERIALIZE_ID_CONVEXHULL = 8
const SERIALIZE_ID_NULL = 9
const SERIALIZE_ID_COMPOUND = 10
const SERIALIZE_ID_TREE = 11
const SERIALIZE_ID_HEIGHTFIELD = 12
const SERIALIZE_ID_CLOTH_PATCH = 13
const SERIALIZE_ID_DEFORMABLE_SOLID = 14
const SERIALIZE_ID_USERMESH = 15
const SERIALIZE_ID_SCENE = 16
const SERIALIZE_ID_FRACTURED_COMPOUND = 17

type NewtonBoxParam
	m_x as dFloat
	m_y as dFloat
	m_z as dFloat
end type

type NewtonSphereParam
	m_radio as dFloat
end type

type NewtonCylinderParam
	m_radio as dFloat
	m_height as dFloat
end type

type NewtonCapsuleParam
	m_radio as dFloat
	m_height as dFloat
end type

type NewtonConeParam
	m_radio as dFloat
	m_height as dFloat
end type

type NewtonTaperedCapsuleParam
	m_radio0 as dFloat
	m_radio1 as dFloat
	m_height as dFloat
end type

type NewtonTaperedCylinderParam
	m_radio0 as dFloat
	m_radio1 as dFloat
	m_height as dFloat
end type

type NewtonChamferCylinderParam
	m_radio as dFloat
	m_height as dFloat
end type

type NewtonConvexHullParam
	m_vertexCount as long
	m_vertexStrideInBytes as long
	m_faceCount as long
	m_vertex as dFloat ptr
end type

type NewtonCompoundCollisionParam
	m_chidrenCount as long
end type

type NewtonCollisionTreeParam
	m_vertexCount as long
	m_indexCount as long
end type

type NewtonDeformableMeshParam
	m_vertexCount as long
	m_triangleCount as long
	m_vrtexStrideInBytes as long
	m_indexList as ushort ptr
	m_vertexList as dFloat ptr
end type

type NewtonHeightFieldCollisionParam
	m_width as long
	m_height as long
	m_gridsDiagonals as long
	m_elevationDataType as long
	m_horizonalScale as dFloat
	m_verticalScale as dFloat
	m_elevation as any ptr
	m_atributes as zstring ptr
end type

type NewtonSceneCollisionParam
	m_childrenProxyCount as long
end type

type NewtonCollisionInfoRecord
	m_offsetMatrix(0 to 3, 0 to 3) as dFloat
	m_collisionType as long
	m_collisionUserID as long

	union
		m_box as NewtonBoxParam
		m_cone as NewtonConeParam
		m_sphere as NewtonSphereParam
		m_capsule as NewtonCapsuleParam
		m_cylinder as NewtonCylinderParam
		m_taperedCapsule as NewtonTaperedCapsuleParam
		m_taperedCylinder as NewtonTaperedCylinderParam
		m_chamferCylinder as NewtonChamferCylinderParam
		m_convexHull as NewtonConvexHullParam
		m_deformableMesh as NewtonDeformableMeshParam
		m_compoundCollision as NewtonCompoundCollisionParam
		m_collisionTree as NewtonCollisionTreeParam
		m_heightField as NewtonHeightFieldCollisionParam
		m_sceneCollision as NewtonSceneCollisionParam
		m_paramArray(0 to 63) as dFloat
	end union
end type

type NewtonBody as NewtonBody_

type NewtonJointRecord
	m_attachmenMatrix_0(0 to 3, 0 to 3) as dFloat
	m_attachmenMatrix_1(0 to 3, 0 to 3) as dFloat
	m_minLinearDof(0 to 2) as dFloat
	m_maxLinearDof(0 to 2) as dFloat
	m_minAngularDof(0 to 2) as dFloat
	m_maxAngularDof(0 to 2) as dFloat
	m_attachBody_0 as const NewtonBody ptr
	m_attachBody_1 as const NewtonBody ptr
	m_extraParameters(0 to 63) as dFloat
	m_bodiesCollisionOn as long
	m_descriptionType as zstring * 128
end type

type NewtonCollision as NewtonCollision_

type NewtonUserMeshCollisionCollideDesc
	m_boxP0(0 to 3) as dFloat
	m_boxP1(0 to 3) as dFloat
	m_boxDistanceTravel(0 to 3) as dFloat
	m_threadNumber as long
	m_faceCount as long
	m_vertexStrideInBytes as long
	m_skinThickness as dFloat
	m_userData as any ptr
	m_objBody as NewtonBody ptr
	m_polySoupBody as NewtonBody ptr
	m_objCollision as NewtonCollision ptr
	m_polySoupCollision as NewtonCollision ptr
	m_vertex as dFloat ptr
	m_faceIndexCount as long ptr
	m_faceVertexIndex as long ptr
end type

type NewtonWorldConvexCastReturnInfo
	m_point(0 to 3) as dFloat
	m_normal(0 to 3) as dFloat
	m_contactID as longint
	m_hitBody as const NewtonBody ptr
	m_penetration as dFloat
end type

type NewtonUserMeshCollisionRayHitDesc
	m_p0(0 to 3) as dFloat
	m_p1(0 to 3) as dFloat
	m_normalOut(0 to 3) as dFloat
	m_userIdOut as longint
	m_userData as any ptr
end type

type NewtonHingeSliderUpdateDesc
	m_accel as dFloat
	m_minFriction as dFloat
	m_maxFriction as dFloat
	m_timestep as dFloat
end type

type NewtonClothPatchMaterial
	m_damper as dFloat
	m_stiffness as dFloat
end type

type NewtonAllocMemory as function(byval sizeInBytes as long) as any ptr
type NewtonFreeMemory as sub(byval ptr as any const ptr, byval sizeInBytes as long)
type NewtonWorld as NewtonWorld_
type NewtonWorldDestructorCallback as sub(byval world as const NewtonWorld const ptr)
type NewtonWorldListenerBodyDestroyCallback as sub(byval world as const NewtonWorld const ptr, byval listenerUserData as any const ptr, byval body as NewtonBody const ptr)
type NewtonWorldUpdateListenerCallback as sub(byval world as const NewtonWorld const ptr, byval listenerUserData as any const ptr, byval timestep as dFloat)
type NewtonWorldDestroyListenerCallback as sub(byval world as const NewtonWorld const ptr, byval listenerUserData as any const ptr)
type NewtonGetTicksCountCallback as function() as ulong
type NewtonSerializeCallback as sub(byval serializeHandle as any const ptr, byval buffer as const any const ptr, byval size as long)
type NewtonDeserializeCallback as sub(byval serializeHandle as any const ptr, byval buffer as any const ptr, byval size as long)
type NewtonOnBodySerializationCallback as sub(byval body as NewtonBody const ptr, byval userData as any const ptr, byval function as NewtonSerializeCallback, byval serializeHandle as any const ptr)
type NewtonOnBodyDeserializationCallback as sub(byval body as NewtonBody const ptr, byval userData as any const ptr, byval function as NewtonDeserializeCallback, byval serializeHandle as any const ptr)
type NewtonJoint as NewtonJoint_
type NewtonOnJointSerializationCallback as sub(byval joint as const NewtonJoint const ptr, byval function as NewtonSerializeCallback, byval serializeHandle as any const ptr)
type NewtonOnJointDeserializationCallback as sub(byval body0 as NewtonBody const ptr, byval body1 as NewtonBody const ptr, byval function as NewtonDeserializeCallback, byval serializeHandle as any const ptr)
type NewtonOnUserCollisionSerializationCallback as sub(byval userData as any const ptr, byval function as NewtonSerializeCallback, byval serializeHandle as any const ptr)
type NewtonUserMeshCollisionDestroyCallback as sub(byval userData as any const ptr)
type NewtonUserMeshCollisionRayHitCallback as function(byval lineDescData as NewtonUserMeshCollisionRayHitDesc const ptr) as dFloat
type NewtonUserMeshCollisionGetCollisionInfo as sub(byval userData as any const ptr, byval infoRecord as NewtonCollisionInfoRecord const ptr)
type NewtonUserMeshCollisionAABBTest as function(byval userData as any const ptr, byval boxP0 as const dFloat const ptr, byval boxP1 as const dFloat const ptr) as long
type NewtonUserMeshCollisionGetFacesInAABB as function(byval userData as any const ptr, byval p0 as const dFloat const ptr, byval p1 as const dFloat const ptr, byval vertexArray as const dFloat ptr const ptr, byval vertexCount as long const ptr, byval vertexStrideInBytes as long const ptr, byval indexList as const long const ptr, byval maxIndexCount as long, byval userDataList as const long const ptr) as long
type NewtonUserMeshCollisionCollideCallback as sub(byval collideDescData as NewtonUserMeshCollisionCollideDesc const ptr, byval continueCollisionHandle as const any const ptr)
type NewtonTreeCollisionFaceCallback as function(byval context as any const ptr, byval polygon as const dFloat const ptr, byval strideInBytes as long, byval indexArray as const long const ptr, byval indexCount as long) as long
type NewtonCollisionTreeRayCastCallback as function(byval body as const NewtonBody const ptr, byval treeCollision as const NewtonCollision const ptr, byval intersection as dFloat, byval normal as dFloat const ptr, byval faceId as long, byval usedData as any const ptr) as dFloat
type NewtonHeightFieldRayCastCallback as function(byval body as const NewtonBody const ptr, byval heightFieldCollision as const NewtonCollision const ptr, byval intersection as dFloat, byval row as long, byval col as long, byval normal as dFloat const ptr, byval faceId as long, byval usedData as any const ptr) as dFloat
type NewtonCollisionCopyConstructionCallback as sub(byval newtonWorld as const NewtonWorld const ptr, byval collision as NewtonCollision const ptr, byval sourceCollision as const NewtonCollision const ptr)
type NewtonCollisionDestructorCallback as sub(byval newtonWorld as const NewtonWorld const ptr, byval collision as const NewtonCollision const ptr)
type NewtonTreeCollisionCallback as sub(byval bodyWithTreeCollision as const NewtonBody const ptr, byval body as const NewtonBody const ptr, byval faceID as long, byval vertexCount as long, byval vertex as const dFloat const ptr, byval vertexStrideInBytes as long)
type NewtonBodyDestructor as sub(byval body as const NewtonBody const ptr)
type NewtonApplyForceAndTorque as sub(byval body as const NewtonBody const ptr, byval timestep as dFloat, byval threadIndex as long)
type NewtonSetTransform as sub(byval body as const NewtonBody const ptr, byval matrix as const dFloat const ptr, byval threadIndex as long)
type NewtonIslandUpdate as function(byval newtonWorld as const NewtonWorld const ptr, byval islandHandle as const any ptr, byval bodyCount as long) as long
type NewtonFractureCompoundCollisionOnEmitCompoundFractured as sub(byval fracturedBody as NewtonBody const ptr)
type NewtonFracturedCompoundMeshPart as NewtonFracturedCompoundMeshPart_
type NewtonFractureCompoundCollisionOnEmitChunk as sub(byval chunkBody as NewtonBody const ptr, byval fracturexChunkMesh as NewtonFracturedCompoundMeshPart const ptr, byval fracturedCompountCollision as const NewtonCollision const ptr)
type NewtonFractureCompoundCollisionReconstructMainMeshCallBack as sub(byval body as NewtonBody const ptr, byval mainMesh as NewtonFracturedCompoundMeshPart const ptr, byval fracturedCompountCollision as const NewtonCollision const ptr)
type NewtonWorldRayPrefilterCallback as function(byval body as const NewtonBody const ptr, byval collision as const NewtonCollision const ptr, byval userData as any const ptr) as ulong
type NewtonWorldRayFilterCallback as function(byval body as const NewtonBody const ptr, byval shapeHit as const NewtonCollision const ptr, byval hitContact as const dFloat const ptr, byval hitNormal as const dFloat const ptr, byval collisionID as longint, byval userData as any const ptr, byval intersectParam as dFloat) as dFloat
type NewtonContactsProcess as sub(byval contact as const NewtonJoint const ptr, byval timestep as dFloat, byval threadIndex as long)
type NewtonMaterial as NewtonMaterial_
type NewtonOnAABBOverlap as function(byval material as const NewtonMaterial const ptr, byval body0 as const NewtonBody const ptr, byval body1 as const NewtonBody const ptr, byval threadIndex as long) as long
type NewtonOnCompoundSubCollisionAABBOverlap as function(byval material as const NewtonMaterial const ptr, byval body0 as const NewtonBody const ptr, byval collsionNode0 as const any const ptr, byval body1 as const NewtonBody const ptr, byval collsionNode1 as const any const ptr, byval threadIndex as long) as long
type NewtonBodyIterator as function(byval body as const NewtonBody const ptr, byval userData as any const ptr) as long
type NewtonJointIterator as sub(byval joint as const NewtonJoint const ptr, byval userData as any const ptr)
type NewtonCollisionIterator as sub(byval userData as any const ptr, byval vertexCount as long, byval faceArray as const dFloat const ptr, byval faceId as long)
type NewtonBallCallback as sub(byval ball as const NewtonJoint const ptr, byval timestep as dFloat)
type NewtonHingeCallback as function(byval hinge as const NewtonJoint const ptr, byval desc as NewtonHingeSliderUpdateDesc const ptr) as ulong
type NewtonSliderCallback as function(byval slider as const NewtonJoint const ptr, byval desc as NewtonHingeSliderUpdateDesc const ptr) as ulong
type NewtonUniversalCallback as function(byval universal as const NewtonJoint const ptr, byval desc as NewtonHingeSliderUpdateDesc const ptr) as ulong
type NewtonCorkscrewCallback as function(byval corkscrew as const NewtonJoint const ptr, byval desc as NewtonHingeSliderUpdateDesc const ptr) as ulong
type NewtonUserBilateralCallback as sub(byval userJoint as const NewtonJoint const ptr, byval timestep as dFloat, byval threadIndex as long)
type NewtonUserBilateralGetInfoCallback as sub(byval userJoint as const NewtonJoint const ptr, byval info as NewtonJointRecord const ptr)
type NewtonConstraintDestructor as sub(byval me as const NewtonJoint const ptr)
type NewtonJobTask as sub(byval world as NewtonWorld const ptr, byval userData as any const ptr, byval threadIndex as long)
type NewtonReportProgress as function(byval normalizedProgressPercent as dFloat, byval userData as any const ptr) as byte

declare function NewtonWorldGetVersion() as long
declare function NewtonWorldFloatSize() as long
declare function NewtonGetMemoryUsed() as long
declare sub NewtonSetMemorySystem(byval malloc as NewtonAllocMemory, byval free as NewtonFreeMemory)
declare function NewtonCreate() as NewtonWorld ptr
declare sub NewtonDestroy(byval newtonWorld as const NewtonWorld const ptr)
declare sub NewtonDestroyAllBodies(byval newtonWorld as const NewtonWorld const ptr)
declare function NewtonAlloc(byval sizeInBytes as long) as any ptr
declare sub NewtonFree(byval ptr as any const ptr)
declare function NewtonEnumrateDevices(byval newtonWorld as const NewtonWorld const ptr) as long
declare function NewtonGetCurrentDevice(byval newtonWorld as const NewtonWorld const ptr) as long
declare sub NewtonSetCurrentDevice(byval newtonWorld as const NewtonWorld const ptr, byval deviceIndex as long)
declare sub NewtonGetDeviceString(byval newtonWorld as const NewtonWorld const ptr, byval deviceIndex as long, byval vendorString as zstring const ptr, byval maxSize as long)
declare function NewtonGetContactMergeTolerance(byval newtonWorld as const NewtonWorld const ptr) as dFloat
declare sub NewtonSetContactMergeTolerance(byval newtonWorld as const NewtonWorld const ptr, byval tolerance as dFloat)
declare sub NewtonInvalidateCache(byval newtonWorld as const NewtonWorld const ptr)
declare sub NewtonSetSolverModel(byval newtonWorld as const NewtonWorld const ptr, byval model as long)
declare sub NewtonSetMultiThreadSolverOnSingleIsland(byval newtonWorld as const NewtonWorld const ptr, byval mode as long)
declare function NewtonGetMultiThreadSolverOnSingleIsland(byval newtonWorld as const NewtonWorld const ptr) as long
declare function NewtonGetBroadphaseAlgorithm(byval newtonWorld as const NewtonWorld const ptr) as long
declare sub NewtonSelectBroadphaseAlgorithm(byval newtonWorld as const NewtonWorld const ptr, byval algorithmType as long)
declare sub NewtonUpdate(byval newtonWorld as const NewtonWorld const ptr, byval timestep as dFloat)
declare sub NewtonUpdateAsync(byval newtonWorld as const NewtonWorld const ptr, byval timestep as dFloat)
declare sub NewtonWaitForUpdateToFinish(byval newtonWorld as const NewtonWorld const ptr)
declare sub NewtonSerializeToFile(byval newtonWorld as const NewtonWorld const ptr, byval filename as const zstring const ptr, byval bodyCallback as NewtonOnBodySerializationCallback, byval bodyUserData as any const ptr)
declare sub NewtonDeserializeFromFile(byval newtonWorld as const NewtonWorld const ptr, byval filename as const zstring const ptr, byval bodyCallback as NewtonOnBodyDeserializationCallback, byval bodyUserData as any const ptr)
declare sub NewtonSetJointSerializationCallbacks(byval newtonWorld as const NewtonWorld const ptr, byval serializeJoint as NewtonOnJointSerializationCallback, byval deserializeJoint as NewtonOnJointDeserializationCallback)
declare sub NewtonGetJointSerializationCallbacks(byval newtonWorld as const NewtonWorld const ptr, byval serializeJoint as NewtonOnJointSerializationCallback const ptr, byval deserializeJoint as NewtonOnJointDeserializationCallback const ptr)
declare sub NewtonWorldCriticalSectionLock(byval newtonWorld as const NewtonWorld const ptr, byval threadIndex as long)
declare sub NewtonWorldCriticalSectionUnlock(byval newtonWorld as const NewtonWorld const ptr)
declare sub NewtonSetThreadsCount(byval newtonWorld as const NewtonWorld const ptr, byval threads as long)
declare function NewtonGetThreadsCount(byval newtonWorld as const NewtonWorld const ptr) as long
declare function NewtonGetMaxThreadsCount(byval newtonWorld as const NewtonWorld const ptr) as long
declare sub NewtonDispachThreadJob(byval newtonWorld as const NewtonWorld const ptr, byval task as NewtonJobTask, byval usedData as any const ptr)
declare sub NewtonSyncThreadJobs(byval newtonWorld as const NewtonWorld const ptr)
declare function NewtonAtomicAdd(byval ptr as long const ptr, byval value as long) as long
declare function NewtonAtomicSwap(byval ptr as long const ptr, byval value as long) as long
declare sub NewtonYield()
declare sub NewtonSetFrictionModel(byval newtonWorld as const NewtonWorld const ptr, byval model as long)
declare sub NewtonSetMinimumFrameRate(byval newtonWorld as const NewtonWorld const ptr, byval frameRate as dFloat)
declare sub NewtonSetIslandUpdateEvent(byval newtonWorld as const NewtonWorld const ptr, byval islandUpdate as NewtonIslandUpdate)
declare sub NewtonWorldForEachJointDo(byval newtonWorld as const NewtonWorld const ptr, byval callback as NewtonJointIterator, byval userData as any const ptr)
declare sub NewtonWorldForEachBodyInAABBDo(byval newtonWorld as const NewtonWorld const ptr, byval p0 as const dFloat const ptr, byval p1 as const dFloat const ptr, byval callback as NewtonBodyIterator, byval userData as any const ptr)
declare sub NewtonWorldSetUserData(byval newtonWorld as const NewtonWorld const ptr, byval userData as any const ptr)
declare function NewtonWorldGetUserData(byval newtonWorld as const NewtonWorld const ptr) as any ptr
declare function NewtonWorldGetListenerUserData(byval newtonWorld as const NewtonWorld const ptr, byval listener as any const ptr) as any ptr
declare function NewtonWorldListenerGetBodyDestroyCallback(byval newtonWorld as const NewtonWorld const ptr, byval listener as any const ptr) as NewtonWorldListenerBodyDestroyCallback
declare sub NewtonWorldListenerSetBodyDestroyCallback(byval newtonWorld as const NewtonWorld const ptr, byval listener as any const ptr, byval bodyDestroyCallback as NewtonWorldListenerBodyDestroyCallback)
declare function NewtonWorldGetPreListener(byval newtonWorld as const NewtonWorld const ptr, byval nameId as const zstring const ptr) as any ptr
declare function NewtonWorldAddPreListener(byval newtonWorld as const NewtonWorld const ptr, byval nameId as const zstring const ptr, byval listenerUserData as any const ptr, byval update as NewtonWorldUpdateListenerCallback, byval destroy as NewtonWorldDestroyListenerCallback) as any ptr
declare function NewtonWorldGetPostListener(byval newtonWorld as const NewtonWorld const ptr, byval nameId as const zstring const ptr) as any ptr
declare function NewtonWorldAddPostListener(byval newtonWorld as const NewtonWorld const ptr, byval nameId as const zstring const ptr, byval listenerUserData as any const ptr, byval update as NewtonWorldUpdateListenerCallback, byval destroy as NewtonWorldDestroyListenerCallback) as any ptr
declare sub NewtonWorldSetDestructorCallback(byval newtonWorld as const NewtonWorld const ptr, byval destructor_ as NewtonWorldDestructorCallback)
declare function NewtonWorldGetDestructorCallback(byval newtonWorld as const NewtonWorld const ptr) as NewtonWorldDestructorCallback
declare sub NewtonWorldSetCollisionConstructorDestructorCallback(byval newtonWorld as const NewtonWorld const ptr, byval constructor_ as NewtonCollisionCopyConstructionCallback, byval destructor_ as NewtonCollisionDestructorCallback)

private sub NewtonWorldSetCollisionConstructorDestuctorCallback(byval newtonWorld as const NewtonWorld const ptr, byval constructor_ as NewtonCollisionCopyConstructionCallback, byval destructor_ as NewtonCollisionDestructorCallback)
	NewtonWorldSetCollisionConstructorDestructorCallback(newtonWorld, constructor_, destructor_)
end sub

declare sub NewtonWorldRayCast(byval newtonWorld as const NewtonWorld const ptr, byval p0 as const dFloat const ptr, byval p1 as const dFloat const ptr, byval filter as NewtonWorldRayFilterCallback, byval userData as any const ptr, byval prefilter as NewtonWorldRayPrefilterCallback, byval threadIndex as long)
declare sub NewtonWorldConvexRayCast(byval newtonWorld as const NewtonWorld const ptr, byval shape as const NewtonCollision const ptr, byval matrix as const dFloat const ptr, byval p1 as const dFloat const ptr, byval filter as NewtonWorldRayFilterCallback, byval userData as any const ptr, byval prefilter as NewtonWorldRayPrefilterCallback, byval threadIndex as long)
declare function NewtonWorldCollide(byval newtonWorld as const NewtonWorld const ptr, byval matrix as const dFloat const ptr, byval shape as const NewtonCollision const ptr, byval userData as any const ptr, byval prefilter as NewtonWorldRayPrefilterCallback, byval info as NewtonWorldConvexCastReturnInfo const ptr, byval maxContactsCount as long, byval threadIndex as long) as long
declare function NewtonWorldConvexCast(byval newtonWorld as const NewtonWorld const ptr, byval matrix as const dFloat const ptr, byval target as const dFloat const ptr, byval shape as const NewtonCollision const ptr, byval hitParam as dFloat const ptr, byval userData as any const ptr, byval prefilter as NewtonWorldRayPrefilterCallback, byval info as NewtonWorldConvexCastReturnInfo const ptr, byval maxContactsCount as long, byval threadIndex as long) as long
declare function NewtonWorldGetBodyCount(byval newtonWorld as const NewtonWorld const ptr) as long
declare function NewtonWorldGetConstraintCount(byval newtonWorld as const NewtonWorld const ptr) as long
declare function NewtonIslandGetBody(byval island as const any const ptr, byval bodyIndex as long) as NewtonBody ptr
declare sub NewtonIslandGetBodyAABB(byval island as const any const ptr, byval bodyIndex as long, byval p0 as dFloat const ptr, byval p1 as dFloat const ptr)
declare function NewtonMaterialCreateGroupID(byval newtonWorld as const NewtonWorld const ptr) as long
declare function NewtonMaterialGetDefaultGroupID(byval newtonWorld as const NewtonWorld const ptr) as long
declare sub NewtonMaterialDestroyAllGroupID(byval newtonWorld as const NewtonWorld const ptr)
declare function NewtonMaterialGetUserData(byval newtonWorld as const NewtonWorld const ptr, byval id0 as long, byval id1 as long) as any ptr
declare sub NewtonMaterialSetSurfaceThickness(byval newtonWorld as const NewtonWorld const ptr, byval id0 as long, byval id1 as long, byval thickness as dFloat)
declare sub NewtonMaterialSetCollisionCallback(byval newtonWorld as const NewtonWorld const ptr, byval id0 as long, byval id1 as long, byval userData as any const ptr, byval aabbOverlap as NewtonOnAABBOverlap, byval process as NewtonContactsProcess)
declare sub NewtonMaterialSetCompoundCollisionCallback(byval newtonWorld as const NewtonWorld const ptr, byval id0 as long, byval id1 as long, byval compoundAabbOverlap as NewtonOnCompoundSubCollisionAABBOverlap)
declare sub NewtonMaterialSetDefaultSoftness(byval newtonWorld as const NewtonWorld const ptr, byval id0 as long, byval id1 as long, byval value as dFloat)
declare sub NewtonMaterialSetDefaultElasticity(byval newtonWorld as const NewtonWorld const ptr, byval id0 as long, byval id1 as long, byval elasticCoef as dFloat)
declare sub NewtonMaterialSetDefaultCollidable(byval newtonWorld as const NewtonWorld const ptr, byval id0 as long, byval id1 as long, byval state as long)
declare sub NewtonMaterialSetDefaultFriction(byval newtonWorld as const NewtonWorld const ptr, byval id0 as long, byval id1 as long, byval staticFriction as dFloat, byval kineticFriction as dFloat)
declare function NewtonWorldGetFirstMaterial(byval newtonWorld as const NewtonWorld const ptr) as NewtonMaterial ptr
declare function NewtonWorldGetNextMaterial(byval newtonWorld as const NewtonWorld const ptr, byval material as const NewtonMaterial const ptr) as NewtonMaterial ptr
declare function NewtonWorldGetFirstBody(byval newtonWorld as const NewtonWorld const ptr) as NewtonBody ptr
declare function NewtonWorldGetNextBody(byval newtonWorld as const NewtonWorld const ptr, byval curBody as const NewtonBody const ptr) as NewtonBody ptr
declare function NewtonMaterialGetMaterialPairUserData(byval material as const NewtonMaterial const ptr) as any ptr
declare function NewtonMaterialGetContactFaceAttribute(byval material as const NewtonMaterial const ptr) as ulong
declare function NewtonMaterialGetBodyCollidingShape(byval material as const NewtonMaterial const ptr, byval body as const NewtonBody const ptr) as NewtonCollision ptr
declare function NewtonMaterialGetContactNormalSpeed(byval material as const NewtonMaterial const ptr) as dFloat
declare sub NewtonMaterialGetContactForce(byval material as const NewtonMaterial const ptr, byval body as const NewtonBody const ptr, byval force as dFloat const ptr)
declare sub NewtonMaterialGetContactPositionAndNormal(byval material as const NewtonMaterial const ptr, byval body as const NewtonBody const ptr, byval posit as dFloat const ptr, byval normal as dFloat const ptr)
declare sub NewtonMaterialGetContactTangentDirections(byval material as const NewtonMaterial const ptr, byval body as const NewtonBody const ptr, byval dir0 as dFloat const ptr, byval dir1 as dFloat const ptr)
declare function NewtonMaterialGetContactTangentSpeed(byval material as const NewtonMaterial const ptr, byval index as long) as dFloat
declare function NewtonMaterialGetContactMaxNormalImpact(byval material as const NewtonMaterial const ptr) as dFloat
declare function NewtonMaterialGetContactMaxTangentImpact(byval material as const NewtonMaterial const ptr, byval index as long) as dFloat
declare sub NewtonMaterialSetContactSoftness(byval material as const NewtonMaterial const ptr, byval softness as dFloat)
declare sub NewtonMaterialSetContactElasticity(byval material as const NewtonMaterial const ptr, byval restitution as dFloat)
declare sub NewtonMaterialSetContactFrictionState(byval material as const NewtonMaterial const ptr, byval state as long, byval index as long)
declare sub NewtonMaterialSetContactFrictionCoef(byval material as const NewtonMaterial const ptr, byval staticFrictionCoef as dFloat, byval kineticFrictionCoef as dFloat, byval index as long)
declare sub NewtonMaterialSetContactNormalAcceleration(byval material as const NewtonMaterial const ptr, byval accel as dFloat)
declare sub NewtonMaterialSetContactNormalDirection(byval material as const NewtonMaterial const ptr, byval directionVector as const dFloat const ptr)
declare sub NewtonMaterialSetContactTangentAcceleration(byval material as const NewtonMaterial const ptr, byval accel as dFloat, byval index as long)
declare sub NewtonMaterialContactRotateTangentDirections(byval material as const NewtonMaterial const ptr, byval directionVector as const dFloat const ptr)
declare function NewtonCreateNull(byval newtonWorld as const NewtonWorld const ptr) as NewtonCollision ptr
declare function NewtonCreateSphere(byval newtonWorld as const NewtonWorld const ptr, byval radius as dFloat, byval shapeID as long, byval offsetMatrix as const dFloat const ptr) as NewtonCollision ptr
declare function NewtonCreateBox(byval newtonWorld as const NewtonWorld const ptr, byval dx as dFloat, byval dy as dFloat, byval dz as dFloat, byval shapeID as long, byval offsetMatrix as const dFloat const ptr) as NewtonCollision ptr
declare function NewtonCreateCone(byval newtonWorld as const NewtonWorld const ptr, byval radius as dFloat, byval height as dFloat, byval shapeID as long, byval offsetMatrix as const dFloat const ptr) as NewtonCollision ptr
declare function NewtonCreateCapsule(byval newtonWorld as const NewtonWorld const ptr, byval radius as dFloat, byval height as dFloat, byval shapeID as long, byval offsetMatrix as const dFloat const ptr) as NewtonCollision ptr
declare function NewtonCreateCylinder(byval newtonWorld as const NewtonWorld const ptr, byval radius as dFloat, byval height as dFloat, byval shapeID as long, byval offsetMatrix as const dFloat const ptr) as NewtonCollision ptr
declare function NewtonCreateTaperedCapsule(byval newtonWorld as const NewtonWorld const ptr, byval radio0 as dFloat, byval radio1 as dFloat, byval height as dFloat, byval shapeID as long, byval offsetMatrix as const dFloat const ptr) as NewtonCollision ptr
declare function NewtonCreateTaperedCylinder(byval newtonWorld as const NewtonWorld const ptr, byval radio0 as dFloat, byval radio1 as dFloat, byval height as dFloat, byval shapeID as long, byval offsetMatrix as const dFloat const ptr) as NewtonCollision ptr
declare function NewtonCreateChamferCylinder(byval newtonWorld as const NewtonWorld const ptr, byval radius as dFloat, byval height as dFloat, byval shapeID as long, byval offsetMatrix as const dFloat const ptr) as NewtonCollision ptr
declare function NewtonCreateConvexHull(byval newtonWorld as const NewtonWorld const ptr, byval count as long, byval vertexCloud as const dFloat const ptr, byval strideInBytes as long, byval tolerance as dFloat, byval shapeID as long, byval offsetMatrix as const dFloat const ptr) as NewtonCollision ptr
type NewtonMesh as NewtonMesh_
declare function NewtonCreateConvexHullFromMesh(byval newtonWorld as const NewtonWorld const ptr, byval mesh as const NewtonMesh const ptr, byval tolerance as dFloat, byval shapeID as long) as NewtonCollision ptr
declare function NewtonCollisionGetMode(byval convexCollision as const NewtonCollision const ptr) as long
declare sub NewtonCollisionSetMode(byval convexCollision as const NewtonCollision const ptr, byval mode as long)
declare function NewtonConvexHullGetFaceIndices(byval convexHullCollision as const NewtonCollision const ptr, byval face as long, byval faceIndices as long const ptr) as long
declare function NewtonConvexHullGetVertexData(byval convexHullCollision as const NewtonCollision const ptr, byval vertexData as dFloat ptr const ptr, byval strideInBytes as long ptr) as long
#define NewtonConvexHullGetVetexData(convexHullCollision, vertexData, strideInBytes) clng(NewtonConvexHullGetVertexData((convexHullCollision), (vertexData), (strideInBytes)))
declare function NewtonConvexCollisionCalculateVolume(byval convexCollision as const NewtonCollision const ptr) as dFloat
declare sub NewtonConvexCollisionCalculateInertialMatrix(byval convexCollision as const NewtonCollision ptr, byval inertia as dFloat const ptr, byval origin as dFloat const ptr)
declare sub NewtonConvexCollisionCalculateBuoyancyAcceleration(byval convexCollision as const NewtonCollision const ptr, byval matrix as const dFloat const ptr, byval shapeOrigin as const dFloat const ptr, byval gravityVector as const dFloat const ptr, byval fluidPlane as const dFloat const ptr, byval fluidDensity as dFloat, byval fluidViscosity as dFloat, byval accel as dFloat const ptr, byval alpha as dFloat const ptr)
declare function NewtonCollisionDataPointer(byval convexCollision as const NewtonCollision const ptr) as const any ptr
declare function NewtonCreateCompoundCollision(byval newtonWorld as const NewtonWorld const ptr, byval shapeID as long) as NewtonCollision ptr
declare function NewtonCreateCompoundCollisionFromMesh(byval newtonWorld as const NewtonWorld const ptr, byval mesh as const NewtonMesh const ptr, byval hullTolerance as dFloat, byval shapeID as long, byval subShapeID as long) as NewtonCollision ptr
declare sub NewtonCompoundCollisionBeginAddRemove(byval compoundCollision as NewtonCollision const ptr)
declare function NewtonCompoundCollisionAddSubCollision(byval compoundCollision as NewtonCollision const ptr, byval convexCollision as const NewtonCollision const ptr) as any ptr
declare sub NewtonCompoundCollisionRemoveSubCollision(byval compoundCollision as NewtonCollision const ptr, byval collisionNode as const any const ptr)
declare sub NewtonCompoundCollisionRemoveSubCollisionByIndex(byval compoundCollision as NewtonCollision const ptr, byval nodeIndex as long)
declare sub NewtonCompoundCollisionSetSubCollisionMatrix(byval compoundCollision as NewtonCollision const ptr, byval collisionNode as const any const ptr, byval matrix as const dFloat const ptr)
declare sub NewtonCompoundCollisionEndAddRemove(byval compoundCollision as NewtonCollision const ptr)
declare function NewtonCompoundCollisionGetFirstNode(byval compoundCollision as NewtonCollision const ptr) as any ptr
declare function NewtonCompoundCollisionGetNextNode(byval compoundCollision as NewtonCollision const ptr, byval collisionNode as const any const ptr) as any ptr
declare function NewtonCompoundCollisionGetNodeByIndex(byval compoundCollision as NewtonCollision const ptr, byval index as long) as any ptr
declare function NewtonCompoundCollisionGetNodeIndex(byval compoundCollision as NewtonCollision const ptr, byval collisionNode as const any const ptr) as long
declare function NewtonCompoundCollisionGetCollisionFromNode(byval compoundCollision as NewtonCollision const ptr, byval collisionNode as const any const ptr) as NewtonCollision ptr
declare function NewtonCreateFracturedCompoundCollision(byval newtonWorld as const NewtonWorld const ptr, byval solidMesh as const NewtonMesh const ptr, byval shapeID as long, byval fracturePhysicsMaterialID as long, byval pointcloudCount as long, byval vertexCloud as const dFloat const ptr, byval strideInBytes as long, byval materialID as long, byval textureMatrix as const dFloat const ptr, byval regenerateMainMeshCallback as NewtonFractureCompoundCollisionReconstructMainMeshCallBack, byval emitFracturedCompound as NewtonFractureCompoundCollisionOnEmitCompoundFractured, byval emitFracfuredChunk as NewtonFractureCompoundCollisionOnEmitChunk) as NewtonCollision ptr
declare function NewtonFracturedCompoundPlaneClip(byval fracturedCompound as const NewtonCollision const ptr, byval plane as const dFloat const ptr) as NewtonCollision ptr
declare sub NewtonFracturedCompoundSetCallbacks(byval fracturedCompound as const NewtonCollision const ptr, byval regenerateMainMeshCallback as NewtonFractureCompoundCollisionReconstructMainMeshCallBack, byval emitFracturedCompound as NewtonFractureCompoundCollisionOnEmitCompoundFractured, byval emitFracfuredChunk as NewtonFractureCompoundCollisionOnEmitChunk)
declare function NewtonFracturedCompoundIsNodeFreeToDetach(byval fracturedCompound as const NewtonCollision const ptr, byval collisionNode as any const ptr) as long
declare function NewtonFracturedCompoundNeighborNodeList(byval fracturedCompound as const NewtonCollision const ptr, byval collisionNode as any const ptr, byval list as any ptr const ptr, byval maxCount as long) as long
declare function NewtonFracturedCompoundGetMainMesh(byval fracturedCompound as const NewtonCollision const ptr) as NewtonFracturedCompoundMeshPart ptr
declare function NewtonFracturedCompoundGetFirstSubMesh(byval fracturedCompound as const NewtonCollision const ptr) as NewtonFracturedCompoundMeshPart ptr
declare function NewtonFracturedCompoundGetNextSubMesh(byval fracturedCompound as const NewtonCollision const ptr, byval subMesh as NewtonFracturedCompoundMeshPart const ptr) as NewtonFracturedCompoundMeshPart ptr
declare function NewtonFracturedCompoundCollisionGetVertexCount(byval fracturedCompound as const NewtonCollision const ptr, byval meshOwner as const NewtonFracturedCompoundMeshPart const ptr) as long
declare function NewtonFracturedCompoundCollisionGetVertexPositions(byval fracturedCompound as const NewtonCollision const ptr, byval meshOwner as const NewtonFracturedCompoundMeshPart const ptr) as const dFloat ptr
declare function NewtonFracturedCompoundCollisionGetVertexNormals(byval fracturedCompound as const NewtonCollision const ptr, byval meshOwner as const NewtonFracturedCompoundMeshPart const ptr) as const dFloat ptr
declare function NewtonFracturedCompoundCollisionGetVertexUVs(byval fracturedCompound as const NewtonCollision const ptr, byval meshOwner as const NewtonFracturedCompoundMeshPart const ptr) as const dFloat ptr
declare function NewtonFracturedCompoundMeshPartGetIndexStream(byval fracturedCompound as const NewtonCollision const ptr, byval meshOwner as const NewtonFracturedCompoundMeshPart const ptr, byval segment as const any const ptr, byval index as long const ptr) as long
declare function NewtonFracturedCompoundMeshPartGetFirstSegment(byval fractureCompoundMeshPart as const NewtonFracturedCompoundMeshPart const ptr) as any ptr
declare function NewtonFracturedCompoundMeshPartGetNextSegment(byval fractureCompoundMeshSegment as const any const ptr) as any ptr
declare function NewtonFracturedCompoundMeshPartGetMaterial(byval fractureCompoundMeshSegment as const any const ptr) as long
declare function NewtonFracturedCompoundMeshPartGetIndexCount(byval fractureCompoundMeshSegment as const any const ptr) as long
declare function NewtonCreateSceneCollision(byval newtonWorld as const NewtonWorld const ptr, byval shapeID as long) as NewtonCollision ptr
declare sub NewtonSceneCollisionBeginAddRemove(byval sceneCollision as NewtonCollision const ptr)
declare function NewtonSceneCollisionAddSubCollision(byval sceneCollision as NewtonCollision const ptr, byval collision as const NewtonCollision const ptr) as any ptr
declare sub NewtonSceneCollisionRemoveSubCollision(byval compoundCollision as NewtonCollision const ptr, byval collisionNode as const any const ptr)
declare sub NewtonSceneCollisionRemoveSubCollisionByIndex(byval sceneCollision as NewtonCollision const ptr, byval nodeIndex as long)
declare sub NewtonSceneCollisionSetSubCollisionMatrix(byval sceneCollision as NewtonCollision const ptr, byval collisionNode as const any const ptr, byval matrix as const dFloat const ptr)
declare sub NewtonSceneCollisionEndAddRemove(byval sceneCollision as NewtonCollision const ptr)
declare function NewtonSceneCollisionGetFirstNode(byval sceneCollision as NewtonCollision const ptr) as any ptr
declare function NewtonSceneCollisionGetNextNode(byval sceneCollision as NewtonCollision const ptr, byval collisionNode as const any const ptr) as any ptr
declare function NewtonSceneCollisionGetNodeByIndex(byval sceneCollision as NewtonCollision const ptr, byval index as long) as any ptr
declare function NewtonSceneCollisionGetNodeIndex(byval sceneCollision as NewtonCollision const ptr, byval collisionNode as const any const ptr) as long
declare function NewtonSceneCollisionGetCollisionFromNode(byval sceneCollision as NewtonCollision const ptr, byval collisionNode as const any const ptr) as NewtonCollision ptr
declare function NewtonCreateUserMeshCollision(byval newtonWorld as const NewtonWorld const ptr, byval minBox as const dFloat const ptr, byval maxBox as const dFloat const ptr, byval userData as any const ptr, byval collideCallback as NewtonUserMeshCollisionCollideCallback, byval rayHitCallback as NewtonUserMeshCollisionRayHitCallback, byval destroyCallback as NewtonUserMeshCollisionDestroyCallback, byval getInfoCallback as NewtonUserMeshCollisionGetCollisionInfo, byval getLocalAABBCallback as NewtonUserMeshCollisionAABBTest, byval facesInAABBCallback as NewtonUserMeshCollisionGetFacesInAABB, byval serializeCallback as NewtonOnUserCollisionSerializationCallback, byval shapeID as long) as NewtonCollision ptr
declare function NewtonUserMeshCollisionContinuousOverlapTest(byval collideDescData as const NewtonUserMeshCollisionCollideDesc const ptr, byval continueCollisionHandle as const any const ptr, byval minAabb as const dFloat const ptr, byval maxAabb as const dFloat const ptr) as long
#define NewtonUserMeshCollisionContinueOveralapTest(collideDescData, continueCollisionHandle, minAabb, maxAabb) clng(NewtonUserMeshCollisionContinuousOverlapTest((collideDescData), (continueCollisionHandle), (minAabb), (maxAabb)))
declare function NewtonCreateCollisionFromSerialization(byval newtonWorld as const NewtonWorld const ptr, byval deserializeFunction as NewtonDeserializeCallback, byval serializeHandle as any const ptr) as NewtonCollision ptr
declare sub NewtonCollisionSerialize(byval newtonWorld as const NewtonWorld const ptr, byval collision as const NewtonCollision const ptr, byval serializeFunction as NewtonSerializeCallback, byval serializeHandle as any const ptr)
declare sub NewtonCollisionGetInfo(byval collision as const NewtonCollision const ptr, byval collisionInfo as NewtonCollisionInfoRecord const ptr)
declare function NewtonCreateHeightFieldCollision(byval newtonWorld as const NewtonWorld const ptr, byval width as long, byval height as long, byval gridsDiagonals as long, byval elevationdatType as long, byval elevationMap as const any const ptr, byval attributeMap as const zstring const ptr, byval verticalScale as dFloat, byval horizontalScale as dFloat, byval shapeID as long) as NewtonCollision ptr
declare sub NewtonHeightFieldSetUserRayCastCallback(byval heightfieldCollision as const NewtonCollision const ptr, byval rayHitCallback as NewtonHeightFieldRayCastCallback)
declare function NewtonCreateTreeCollision(byval newtonWorld as const NewtonWorld const ptr, byval shapeID as long) as NewtonCollision ptr
declare function NewtonCreateTreeCollisionFromMesh(byval newtonWorld as const NewtonWorld const ptr, byval mesh as const NewtonMesh const ptr, byval shapeID as long) as NewtonCollision ptr
declare sub NewtonTreeCollisionSetUserRayCastCallback(byval treeCollision as const NewtonCollision const ptr, byval rayHitCallback as NewtonCollisionTreeRayCastCallback)
declare sub NewtonTreeCollisionBeginBuild(byval treeCollision as const NewtonCollision const ptr)
declare sub NewtonTreeCollisionAddFace(byval treeCollision as const NewtonCollision const ptr, byval vertexCount as long, byval vertexPtr as const dFloat const ptr, byval strideInBytes as long, byval faceAttribute as long)
declare sub NewtonTreeCollisionEndBuild(byval treeCollision as const NewtonCollision const ptr, byval optimize as long)
declare function NewtonTreeCollisionGetFaceAttribute(byval treeCollision as const NewtonCollision const ptr, byval faceIndexArray as const long const ptr, byval indexCount as long) as long
declare sub NewtonTreeCollisionSetFaceAttribute(byval treeCollision as const NewtonCollision const ptr, byval faceIndexArray as const long const ptr, byval indexCount as long, byval attribute as long)
#define NewtonTreeCollisionGetFaceAtribute(treeCollision, faceIndexArray, indexCount) clng(NewtonTreeCollisionGetFaceAttribute((treeCollision), (faceIndexArray), (indexCount)))

private sub NewtonTreeCollisionSetFaceAtribute(byval treeCollision as const NewtonCollision const ptr, byval faceIndexArray as const long const ptr, byval indexCount as long, byval attribute as long)
	NewtonTreeCollisionSetFaceAttribute(treeCollision, faceIndexArray, indexCount, attribute)
end sub

declare sub NewtonTreeCollisionForEachFace(byval treeCollision as const NewtonCollision const ptr, byval forEachFaceCallback as NewtonTreeCollisionFaceCallback, byval context as any const ptr)
declare function NewtonTreeCollisionGetVertexListTriangleListInAABB(byval treeCollision as const NewtonCollision const ptr, byval p0 as const dFloat const ptr, byval p1 as const dFloat const ptr, byval vertexArray as const dFloat ptr const ptr, byval vertexCount as long const ptr, byval vertexStrideInBytes as long const ptr, byval indexList as const long const ptr, byval maxIndexCount as long, byval faceAttribute as const long const ptr) as long
declare sub NewtonStaticCollisionSetDebugCallback(byval staticCollision as const NewtonCollision const ptr, byval userCallback as NewtonTreeCollisionCallback)
declare function NewtonCollisionCreateInstance(byval collision as const NewtonCollision const ptr) as NewtonCollision ptr
declare function NewtonCollisionGetType(byval collision as const NewtonCollision const ptr) as long
declare sub NewtonCollisionSetUserData(byval collision as const NewtonCollision const ptr, byval userData as any const ptr)
declare function NewtonCollisionGetUserData(byval collision as const NewtonCollision const ptr) as any ptr
declare sub NewtonCollisionSetUserData1(byval collision as const NewtonCollision const ptr, byval userData as any const ptr)
declare function NewtonCollisionGetUserData1(byval collision as const NewtonCollision const ptr) as any ptr
declare sub NewtonCollisionSetUserID(byval collision as const NewtonCollision const ptr, byval id as ulong)
declare function NewtonCollisionGetUserID(byval collision as const NewtonCollision const ptr) as ulong
declare function NewtonCollisionGetSubCollisionHandle(byval collision as const NewtonCollision const ptr) as any ptr
declare function NewtonCollisionGetParentInstance(byval collision as const NewtonCollision const ptr) as NewtonCollision ptr
declare sub NewtonCollisionSetMatrix(byval collision as const NewtonCollision const ptr, byval matrix as const dFloat const ptr)
declare sub NewtonCollisionGetMatrix(byval collision as const NewtonCollision const ptr, byval matrix as dFloat const ptr)
declare sub NewtonCollisionSetScale(byval collision as const NewtonCollision const ptr, byval scaleX as dFloat, byval scaleY as dFloat, byval scaleZ as dFloat)
declare sub NewtonCollisionGetScale(byval collision as const NewtonCollision const ptr, byval scaleX as dFloat const ptr, byval scaleY as dFloat const ptr, byval scaleZ as dFloat const ptr)
declare sub NewtonDestroyCollision(byval collision as const NewtonCollision const ptr)
declare function NewtonCollisionGetSkinThickness(byval collision as const NewtonCollision const ptr) as dFloat
declare function NewtonCollisionIntersectionTest(byval newtonWorld as const NewtonWorld const ptr, byval collisionA as const NewtonCollision const ptr, byval matrixA as const dFloat const ptr, byval collisionB as const NewtonCollision const ptr, byval matrixB as const dFloat const ptr, byval threadIndex as long) as long
declare function NewtonCollisionPointDistance(byval newtonWorld as const NewtonWorld const ptr, byval point as const dFloat const ptr, byval collision as const NewtonCollision const ptr, byval matrix as const dFloat const ptr, byval contact as dFloat const ptr, byval normal as dFloat const ptr, byval threadIndex as long) as long
declare function NewtonCollisionClosestPoint(byval newtonWorld as const NewtonWorld const ptr, byval collisionA as const NewtonCollision const ptr, byval matrixA as const dFloat const ptr, byval collisionB as const NewtonCollision const ptr, byval matrixB as const dFloat const ptr, byval contactA as dFloat const ptr, byval contactB as dFloat const ptr, byval normalAB as dFloat const ptr, byval threadIndex as long) as long
declare function NewtonCollisionCollide(byval newtonWorld as const NewtonWorld const ptr, byval maxSize as long, byval collisionA as const NewtonCollision const ptr, byval matrixA as const dFloat const ptr, byval collisionB as const NewtonCollision const ptr, byval matrixB as const dFloat const ptr, byval contacts as dFloat const ptr, byval normals as dFloat const ptr, byval penetration as dFloat const ptr, byval attributeA as longint const ptr, byval attributeB as longint const ptr, byval threadIndex as long) as long
declare function NewtonCollisionCollideContinue(byval newtonWorld as const NewtonWorld const ptr, byval maxSize as long, byval timestep as dFloat, byval collisionA as const NewtonCollision const ptr, byval matrixA as const dFloat const ptr, byval velocA as const dFloat const ptr, byval omegaA as const dFloat ptr, byval collisionB as const NewtonCollision const ptr, byval matrixB as const dFloat const ptr, byval velocB as const dFloat const ptr, byval omegaB as const dFloat const ptr, byval timeOfImpact as dFloat const ptr, byval contacts as dFloat const ptr, byval normals as dFloat const ptr, byval penetration as dFloat const ptr, byval attributeA as longint const ptr, byval attributeB as longint const ptr, byval threadIndex as long) as long
declare sub NewtonCollisionSupportVertex(byval collision as const NewtonCollision const ptr, byval dir as const dFloat const ptr, byval vertex as dFloat const ptr)
declare function NewtonCollisionRayCast(byval collision as const NewtonCollision const ptr, byval p0 as const dFloat const ptr, byval p1 as const dFloat const ptr, byval normal as dFloat const ptr, byval attribute as longint const ptr) as dFloat
declare sub NewtonCollisionCalculateAABB(byval collision as const NewtonCollision const ptr, byval matrix as const dFloat const ptr, byval p0 as dFloat const ptr, byval p1 as dFloat const ptr)
declare sub NewtonCollisionForEachPolygonDo(byval collision as const NewtonCollision const ptr, byval matrix as const dFloat const ptr, byval callback as NewtonCollisionIterator, byval userData as any const ptr)
declare sub NewtonSetEulerAngle(byval eulersAngles as const dFloat const ptr, byval matrix as dFloat const ptr)
declare sub NewtonGetEulerAngle(byval matrix as const dFloat const ptr, byval eulersAngles0 as dFloat const ptr, byval eulersAngles1 as dFloat const ptr)
declare function NewtonCalculateSpringDamperAcceleration(byval dt as dFloat, byval ks as dFloat, byval x as dFloat, byval kd as dFloat, byval s as dFloat) as dFloat
declare function NewtonCreateDynamicBody(byval newtonWorld as const NewtonWorld const ptr, byval collision as const NewtonCollision const ptr, byval matrix as const dFloat const ptr) as NewtonBody ptr
declare function NewtonCreateKinematicBody(byval newtonWorld as const NewtonWorld const ptr, byval collision as const NewtonCollision const ptr, byval matrix as const dFloat const ptr) as NewtonBody ptr
declare function NewtonCreateDeformableBody(byval newtonWorld as const NewtonWorld const ptr, byval deformableMesh as const NewtonCollision const ptr, byval matrix as const dFloat const ptr) as NewtonBody ptr
declare sub NewtonDestroyBody(byval body as const NewtonBody const ptr)
declare sub NewtonBodyEnableSimulation(byval body as const NewtonBody const ptr)
declare sub NewtonBodyDisableSimulation(byval body as const NewtonBody const ptr)
declare function NewtonBodyGetSimulationState(byval body as const NewtonBody const ptr) as long
declare sub NewtonBodySetSimulationState(byval bodyPtr as const NewtonBody const ptr, byval state as const long)
declare function NewtonBodyGetType(byval body as const NewtonBody const ptr) as long
declare function NewtonBodyGetCollidable(byval body as const NewtonBody const ptr) as long
declare sub NewtonBodySetCollidable(byval body as const NewtonBody const ptr, byval collidableState as long)
declare sub NewtonBodyAddForce(byval body as const NewtonBody const ptr, byval force as const dFloat const ptr)
declare sub NewtonBodyAddTorque(byval body as const NewtonBody const ptr, byval torque as const dFloat const ptr)
declare sub NewtonBodyCalculateInverseDynamicsForce(byval body as const NewtonBody const ptr, byval timestep as dFloat, byval desiredVeloc as const dFloat const ptr, byval forceOut as dFloat const ptr)
declare sub NewtonBodySetCentreOfMass(byval body as const NewtonBody const ptr, byval com as const dFloat const ptr)
declare sub NewtonBodySetMassMatrix(byval body as const NewtonBody const ptr, byval mass as dFloat, byval Ixx as dFloat, byval Iyy as dFloat, byval Izz as dFloat)
declare sub NewtonBodySetMassProperties(byval body as const NewtonBody const ptr, byval mass as dFloat, byval collision as const NewtonCollision const ptr)
declare sub NewtonBodySetMatrix(byval body as const NewtonBody const ptr, byval matrix as const dFloat const ptr)
declare sub NewtonBodySetMatrixRecursive(byval body as const NewtonBody const ptr, byval matrix as const dFloat const ptr)
declare sub NewtonBodySetMaterialGroupID(byval body as const NewtonBody const ptr, byval id as long)
declare sub NewtonBodySetContinuousCollisionMode(byval body as const NewtonBody const ptr, byval state as ulong)
declare sub NewtonBodySetJointRecursiveCollision(byval body as const NewtonBody const ptr, byval state as ulong)
declare sub NewtonBodySetOmega(byval body as const NewtonBody const ptr, byval omega as const dFloat const ptr)
declare sub NewtonBodySetVelocity(byval body as const NewtonBody const ptr, byval velocity as const dFloat const ptr)
declare sub NewtonBodySetForce(byval body as const NewtonBody const ptr, byval force as const dFloat const ptr)
declare sub NewtonBodySetTorque(byval body as const NewtonBody const ptr, byval torque as const dFloat const ptr)
declare sub NewtonBodySetLinearDamping(byval body as const NewtonBody const ptr, byval linearDamp as dFloat)
declare sub NewtonBodySetAngularDamping(byval body as const NewtonBody const ptr, byval angularDamp as const dFloat const ptr)
declare sub NewtonBodySetCollision(byval body as const NewtonBody const ptr, byval collision as const NewtonCollision const ptr)
declare sub NewtonBodySetCollisionScale(byval body as const NewtonBody const ptr, byval scaleX as dFloat, byval scaleY as dFloat, byval scaleZ as dFloat)
declare function NewtonBodyGetSleepState(byval body as const NewtonBody const ptr) as long
declare sub NewtonBodySetSleepState(byval body as const NewtonBody const ptr, byval state as long)
declare function NewtonBodyGetAutoSleep(byval body as const NewtonBody const ptr) as long
declare sub NewtonBodySetAutoSleep(byval body as const NewtonBody const ptr, byval state as long)
declare function NewtonBodyGetFreezeState(byval body as const NewtonBody const ptr) as long
declare sub NewtonBodySetFreezeState(byval body as const NewtonBody const ptr, byval state as long)
declare sub NewtonBodySetDestructorCallback(byval body as const NewtonBody const ptr, byval callback as NewtonBodyDestructor)
declare function NewtonBodyGetDestructorCallback(byval body as const NewtonBody const ptr) as NewtonBodyDestructor
declare sub NewtonBodySetTransformCallback(byval body as const NewtonBody const ptr, byval callback as NewtonSetTransform)
declare function NewtonBodyGetTransformCallback(byval body as const NewtonBody const ptr) as NewtonSetTransform
declare sub NewtonBodySetForceAndTorqueCallback(byval body as const NewtonBody const ptr, byval callback as NewtonApplyForceAndTorque)
declare function NewtonBodyGetForceAndTorqueCallback(byval body as const NewtonBody const ptr) as NewtonApplyForceAndTorque
declare function NewtonBodyGetID(byval body as const NewtonBody const ptr) as long
declare sub NewtonBodySetUserData(byval body as const NewtonBody const ptr, byval userData as any const ptr)
declare function NewtonBodyGetUserData(byval body as const NewtonBody const ptr) as any ptr
declare function NewtonBodyGetWorld(byval body as const NewtonBody const ptr) as NewtonWorld ptr
declare function NewtonBodyGetCollision(byval body as const NewtonBody const ptr) as NewtonCollision ptr
declare function NewtonBodyGetMaterialGroupID(byval body as const NewtonBody const ptr) as long
declare function NewtonBodyGetContinuousCollisionMode(byval body as const NewtonBody const ptr) as long
declare function NewtonBodyGetJointRecursiveCollision(byval body as const NewtonBody const ptr) as long
declare sub NewtonBodyGetPosition(byval body as const NewtonBody const ptr, byval pos as dFloat const ptr)
declare sub NewtonBodyGetMatrix(byval body as const NewtonBody const ptr, byval matrix as dFloat const ptr)
declare sub NewtonBodyGetRotation(byval body as const NewtonBody const ptr, byval rotation as dFloat const ptr)
declare sub NewtonBodyGetMassMatrix(byval body as const NewtonBody const ptr, byval mass as dFloat ptr, byval Ixx as dFloat const ptr, byval Iyy as dFloat const ptr, byval Izz as dFloat const ptr)
declare sub NewtonBodyGetInvMass(byval body as const NewtonBody const ptr, byval invMass as dFloat const ptr, byval invIxx as dFloat const ptr, byval invIyy as dFloat const ptr, byval invIzz as dFloat const ptr)
declare sub NewtonBodyGetInertiaMatrix(byval body as const NewtonBody const ptr, byval inertiaMatrix as dFloat const ptr)
declare sub NewtonBodyGetInvInertiaMatrix(byval body as const NewtonBody const ptr, byval invInertiaMatrix as dFloat const ptr)
declare sub NewtonBodyGetOmega(byval body as const NewtonBody const ptr, byval vector as dFloat const ptr)
declare sub NewtonBodyGetVelocity(byval body as const NewtonBody const ptr, byval vector as dFloat const ptr)
declare sub NewtonBodyGetForce(byval body as const NewtonBody const ptr, byval vector as dFloat const ptr)
declare sub NewtonBodyGetTorque(byval body as const NewtonBody const ptr, byval vector as dFloat const ptr)
declare sub NewtonBodyGetForceAcc(byval body as const NewtonBody const ptr, byval vector as dFloat const ptr)
declare sub NewtonBodyGetTorqueAcc(byval body as const NewtonBody const ptr, byval vector as dFloat const ptr)
declare sub NewtonBodyGetCentreOfMass(byval body as const NewtonBody const ptr, byval com as dFloat const ptr)
declare sub NewtonBodyGetPointVelocity(byval body as const NewtonBody const ptr, byval point as const dFloat const ptr, byval velocOut as dFloat const ptr)
declare sub NewtonBodyAddImpulse(byval body as const NewtonBody const ptr, byval pointDeltaVeloc as const dFloat const ptr, byval pointPosit as const dFloat const ptr)
declare sub NewtonBodyApplyImpulseArray(byval body as const NewtonBody const ptr, byval impuleCount as long, byval strideInByte as long, byval impulseArray as const dFloat const ptr, byval pointArray as const dFloat const ptr)
declare sub NewtonBodyApplyImpulsePair(byval body as const NewtonBody const ptr, byval linearImpulse as dFloat const ptr, byval angularImpulse as dFloat const ptr)
declare sub NewtonBodyIntegrateVelocity(byval body as const NewtonBody const ptr, byval timestep as dFloat)
declare function NewtonBodyGetLinearDamping(byval body as const NewtonBody const ptr) as dFloat
declare sub NewtonBodyGetAngularDamping(byval body as const NewtonBody const ptr, byval vector as dFloat const ptr)
declare sub NewtonBodyGetAABB(byval body as const NewtonBody const ptr, byval p0 as dFloat const ptr, byval p1 as dFloat const ptr)
declare function NewtonBodyGetFirstJoint(byval body as const NewtonBody const ptr) as NewtonJoint ptr
declare function NewtonBodyGetNextJoint(byval body as const NewtonBody const ptr, byval joint as const NewtonJoint const ptr) as NewtonJoint ptr
declare function NewtonBodyGetFirstContactJoint(byval body as const NewtonBody const ptr) as NewtonJoint ptr
declare function NewtonBodyGetNextContactJoint(byval body as const NewtonBody const ptr, byval contactJoint as const NewtonJoint const ptr) as NewtonJoint ptr
declare function NewtonContactJointGetFirstContact(byval contactJoint as const NewtonJoint const ptr) as any ptr
declare function NewtonContactJointGetNextContact(byval contactJoint as const NewtonJoint const ptr, byval contact as any const ptr) as any ptr
declare function NewtonContactJointGetContactCount(byval contactJoint as const NewtonJoint const ptr) as long
declare sub NewtonContactJointRemoveContact(byval contactJoint as const NewtonJoint const ptr, byval contact as any const ptr)
declare function NewtonContactJointGetClosestDistance(byval contactJoint as const NewtonJoint const ptr) as dFloat
declare function NewtonContactGetMaterial(byval contact as const any const ptr) as NewtonMaterial ptr
declare function NewtonContactGetCollision0(byval contact as const any const ptr) as NewtonCollision ptr
declare function NewtonContactGetCollision1(byval contact as const any const ptr) as NewtonCollision ptr
declare function NewtonContactGetCollisionID0(byval contact as const any const ptr) as any ptr
declare function NewtonContactGetCollisionID1(byval contact as const any const ptr) as any ptr
declare function NewtonJointGetUserData(byval joint as const NewtonJoint const ptr) as any ptr
declare sub NewtonJointSetUserData(byval joint as const NewtonJoint const ptr, byval userData as any const ptr)
declare function NewtonJointGetBody0(byval joint as const NewtonJoint const ptr) as NewtonBody ptr
declare function NewtonJointGetBody1(byval joint as const NewtonJoint const ptr) as NewtonBody ptr
declare sub NewtonJointGetInfo(byval joint as const NewtonJoint const ptr, byval info as NewtonJointRecord const ptr)
declare function NewtonJointGetCollisionState(byval joint as const NewtonJoint const ptr) as long
declare sub NewtonJointSetCollisionState(byval joint as const NewtonJoint const ptr, byval state as long)
declare function NewtonJointGetStiffness(byval joint as const NewtonJoint const ptr) as dFloat
declare sub NewtonJointSetStiffness(byval joint as const NewtonJoint const ptr, byval state as dFloat)
declare sub NewtonDestroyJoint(byval newtonWorld as const NewtonWorld const ptr, byval joint as const NewtonJoint const ptr)
declare sub NewtonJointSetDestructor(byval joint as const NewtonJoint const ptr, byval destructor_ as NewtonConstraintDestructor)
declare function NewtonJointIsActive(byval joint as const NewtonJoint const ptr) as long
declare function NewtonCreateClothPatch(byval newtonWorld as const NewtonWorld const ptr, byval mesh as NewtonMesh const ptr, byval shapeID as long, byval structuralMaterial as NewtonClothPatchMaterial const ptr, byval bendMaterial as NewtonClothPatchMaterial const ptr) as NewtonCollision ptr
declare function NewtonCreateDeformableMesh(byval newtonWorld as const NewtonWorld const ptr, byval mesh as NewtonMesh const ptr, byval shapeID as long) as NewtonCollision ptr
declare sub NewtonDeformableMeshCreateClusters(byval deformableMesh as NewtonCollision const ptr, byval clusterCount as long, byval overlapingWidth as dFloat)
declare sub NewtonDeformableMeshSetDebugCallback(byval deformableMesh as NewtonCollision const ptr, byval callback as NewtonCollisionIterator)
declare function NewtonDeformableMeshGetParticleCount(byval deformableMesh as const NewtonCollision const ptr) as long
declare sub NewtonDeformableMeshGetParticlePosition(byval deformableMesh as NewtonCollision const ptr, byval particleIndex as long, byval posit as dFloat const ptr)
declare sub NewtonDeformableMeshBeginConfiguration(byval deformableMesh as const NewtonCollision const ptr)
declare sub NewtonDeformableMeshUnconstraintParticle(byval deformableMesh as NewtonCollision const ptr, byval particleIndex as long)
declare sub NewtonDeformableMeshConstraintParticle(byval deformableMesh as NewtonCollision const ptr, byval particleIndex as long, byval posit as const dFloat const ptr, byval body as const NewtonBody const ptr)
declare sub NewtonDeformableMeshEndConfiguration(byval deformableMesh as const NewtonCollision const ptr)
declare sub NewtonDeformableMeshSetSkinThickness(byval deformableMesh as NewtonCollision const ptr, byval skinThickness as dFloat)
declare sub NewtonDeformableMeshUpdateRenderNormals(byval deformableMesh as const NewtonCollision const ptr)
declare function NewtonDeformableMeshGetVertexCount(byval deformableMesh as const NewtonCollision const ptr) as long
declare sub NewtonDeformableMeshGetVertexStreams(byval deformableMesh as const NewtonCollision const ptr, byval vertexStrideInByte as long, byval vertex as dFloat const ptr, byval normalStrideInByte as long, byval normal as dFloat const ptr, byval uvStrideInByte0 as long, byval uv0 as dFloat const ptr)
type NewtonDeformableMeshSegment as NewtonDeformableMeshSegment_
declare function NewtonDeformableMeshGetFirstSegment(byval deformableMesh as const NewtonCollision const ptr) as NewtonDeformableMeshSegment ptr
declare function NewtonDeformableMeshGetNextSegment(byval deformableMesh as const NewtonCollision const ptr, byval segment as const NewtonDeformableMeshSegment const ptr) as NewtonDeformableMeshSegment ptr
declare function NewtonDeformableMeshSegmentGetMaterialID(byval deformableMesh as const NewtonCollision const ptr, byval segment as const NewtonDeformableMeshSegment const ptr) as long
declare function NewtonDeformableMeshSegmentGetIndexCount(byval deformableMesh as const NewtonCollision const ptr, byval segment as const NewtonDeformableMeshSegment const ptr) as long
declare function NewtonDeformableMeshSegmentGetIndexList(byval deformableMesh as const NewtonCollision const ptr, byval segment as const NewtonDeformableMeshSegment const ptr) as const long ptr
declare function NewtonConstraintCreateBall(byval newtonWorld as const NewtonWorld const ptr, byval pivotPoint as const dFloat ptr, byval childBody as const NewtonBody const ptr, byval parentBody as const NewtonBody const ptr) as NewtonJoint ptr
declare sub NewtonBallSetUserCallback(byval ball as const NewtonJoint const ptr, byval callback as NewtonBallCallback)
declare sub NewtonBallGetJointAngle(byval ball as const NewtonJoint const ptr, byval angle as dFloat ptr)
declare sub NewtonBallGetJointOmega(byval ball as const NewtonJoint const ptr, byval omega as dFloat ptr)
declare sub NewtonBallGetJointForce(byval ball as const NewtonJoint const ptr, byval force as dFloat const ptr)
declare sub NewtonBallSetConeLimits(byval ball as const NewtonJoint const ptr, byval pin as const dFloat ptr, byval maxConeAngle as dFloat, byval maxTwistAngle as dFloat)
declare function NewtonConstraintCreateHinge(byval newtonWorld as const NewtonWorld const ptr, byval pivotPoint as const dFloat ptr, byval pinDir as const dFloat ptr, byval childBody as const NewtonBody const ptr, byval parentBody as const NewtonBody const ptr) as NewtonJoint ptr
declare sub NewtonHingeSetUserCallback(byval hinge as const NewtonJoint const ptr, byval callback as NewtonHingeCallback)
declare function NewtonHingeGetJointAngle(byval hinge as const NewtonJoint const ptr) as dFloat
declare function NewtonHingeGetJointOmega(byval hinge as const NewtonJoint const ptr) as dFloat
declare sub NewtonHingeGetJointForce(byval hinge as const NewtonJoint const ptr, byval force as dFloat const ptr)
declare function NewtonHingeCalculateStopAlpha(byval hinge as const NewtonJoint const ptr, byval desc as const NewtonHingeSliderUpdateDesc const ptr, byval angle as dFloat) as dFloat
declare function NewtonConstraintCreateSlider(byval newtonWorld as const NewtonWorld const ptr, byval pivotPoint as const dFloat ptr, byval pinDir as const dFloat ptr, byval childBody as const NewtonBody const ptr, byval parentBody as const NewtonBody const ptr) as NewtonJoint ptr
declare sub NewtonSliderSetUserCallback(byval slider as const NewtonJoint const ptr, byval callback as NewtonSliderCallback)
declare function NewtonSliderGetJointPosit(byval slider as const NewtonJoint ptr) as dFloat
declare function NewtonSliderGetJointVeloc(byval slider as const NewtonJoint ptr) as dFloat
declare sub NewtonSliderGetJointForce(byval slider as const NewtonJoint const ptr, byval force as dFloat const ptr)
declare function NewtonSliderCalculateStopAccel(byval slider as const NewtonJoint const ptr, byval desc as const NewtonHingeSliderUpdateDesc const ptr, byval position as dFloat) as dFloat
declare function NewtonConstraintCreateCorkscrew(byval newtonWorld as const NewtonWorld const ptr, byval pivotPoint as const dFloat ptr, byval pinDir as const dFloat ptr, byval childBody as const NewtonBody const ptr, byval parentBody as const NewtonBody const ptr) as NewtonJoint ptr
declare sub NewtonCorkscrewSetUserCallback(byval corkscrew as const NewtonJoint const ptr, byval callback as NewtonCorkscrewCallback)
declare function NewtonCorkscrewGetJointPosit(byval corkscrew as const NewtonJoint const ptr) as dFloat
declare function NewtonCorkscrewGetJointAngle(byval corkscrew as const NewtonJoint const ptr) as dFloat
declare function NewtonCorkscrewGetJointVeloc(byval corkscrew as const NewtonJoint const ptr) as dFloat
declare function NewtonCorkscrewGetJointOmega(byval corkscrew as const NewtonJoint const ptr) as dFloat
declare sub NewtonCorkscrewGetJointForce(byval corkscrew as const NewtonJoint const ptr, byval force as dFloat const ptr)
declare function NewtonCorkscrewCalculateStopAlpha(byval corkscrew as const NewtonJoint const ptr, byval desc as const NewtonHingeSliderUpdateDesc const ptr, byval angle as dFloat) as dFloat
declare function NewtonCorkscrewCalculateStopAccel(byval corkscrew as const NewtonJoint const ptr, byval desc as const NewtonHingeSliderUpdateDesc const ptr, byval position as dFloat) as dFloat
declare function NewtonConstraintCreateUniversal(byval newtonWorld as const NewtonWorld const ptr, byval pivotPoint as const dFloat ptr, byval pinDir0 as const dFloat ptr, byval pinDir1 as const dFloat ptr, byval childBody as const NewtonBody const ptr, byval parentBody as const NewtonBody const ptr) as NewtonJoint ptr
declare sub NewtonUniversalSetUserCallback(byval universal as const NewtonJoint const ptr, byval callback as NewtonUniversalCallback)
declare function NewtonUniversalGetJointAngle0(byval universal as const NewtonJoint const ptr) as dFloat
declare function NewtonUniversalGetJointAngle1(byval universal as const NewtonJoint const ptr) as dFloat
declare function NewtonUniversalGetJointOmega0(byval universal as const NewtonJoint const ptr) as dFloat
declare function NewtonUniversalGetJointOmega1(byval universal as const NewtonJoint const ptr) as dFloat
declare sub NewtonUniversalGetJointForce(byval universal as const NewtonJoint const ptr, byval force as dFloat const ptr)
declare function NewtonUniversalCalculateStopAlpha0(byval universal as const NewtonJoint const ptr, byval desc as const NewtonHingeSliderUpdateDesc const ptr, byval angle as dFloat) as dFloat
declare function NewtonUniversalCalculateStopAlpha1(byval universal as const NewtonJoint const ptr, byval desc as const NewtonHingeSliderUpdateDesc const ptr, byval angle as dFloat) as dFloat
declare function NewtonConstraintCreateUpVector(byval newtonWorld as const NewtonWorld const ptr, byval pinDir as const dFloat ptr, byval body as const NewtonBody const ptr) as NewtonJoint ptr
declare sub NewtonUpVectorGetPin(byval upVector as const NewtonJoint const ptr, byval pin as dFloat ptr)
declare sub NewtonUpVectorSetPin(byval upVector as const NewtonJoint const ptr, byval pin as const dFloat ptr)
declare function NewtonConstraintCreateUserJoint(byval newtonWorld as const NewtonWorld const ptr, byval maxDOF as long, byval callback as NewtonUserBilateralCallback, byval getInfo as NewtonUserBilateralGetInfoCallback, byval childBody as const NewtonBody const ptr, byval parentBody as const NewtonBody const ptr) as NewtonJoint ptr
declare sub NewtonUserJointSetFeedbackCollectorCallback(byval joint as const NewtonJoint const ptr, byval getFeedback as NewtonUserBilateralCallback)
declare sub NewtonUserJointAddLinearRow(byval joint as const NewtonJoint const ptr, byval pivot0 as const dFloat const ptr, byval pivot1 as const dFloat const ptr, byval dir as const dFloat const ptr)
declare sub NewtonUserJointAddAngularRow(byval joint as const NewtonJoint const ptr, byval relativeAngle as dFloat, byval dir as const dFloat const ptr)
declare sub NewtonUserJointAddGeneralRow(byval joint as const NewtonJoint const ptr, byval jacobian0 as const dFloat const ptr, byval jacobian1 as const dFloat const ptr)
declare sub NewtonUserJointSetRowMinimumFriction(byval joint as const NewtonJoint const ptr, byval friction as dFloat)
declare sub NewtonUserJointSetRowMaximumFriction(byval joint as const NewtonJoint const ptr, byval friction as dFloat)
declare sub NewtonUserJointSetRowAcceleration(byval joint as const NewtonJoint const ptr, byval acceleration as dFloat)
declare sub NewtonUserJointSetRowSpringDamperAcceleration(byval joint as const NewtonJoint const ptr, byval springK as dFloat, byval springD as dFloat)
declare sub NewtonUserJointSetRowStiffness(byval joint as const NewtonJoint const ptr, byval stiffness as dFloat)
declare function NewtonUserJointGetRowForce(byval joint as const NewtonJoint const ptr, byval row as long) as dFloat
declare sub NewtonUserJointSetSolver(byval joint as const NewtonJoint const ptr, byval solver as long, byval maxContactJoints as long)
type NewtonAcyclicArticulation as NewtonAcyclicArticulation_
declare function NewtonAcyclicArticulationCreate(byval rootBone as NewtonBody const ptr) as NewtonAcyclicArticulation ptr
declare sub NewtonAcyclicArticulationDelete(byval articulation as NewtonAcyclicArticulation const ptr)
declare function NewtonAcyclicArticulationAttachBone(byval articulation as NewtonAcyclicArticulation const ptr, byval parentBone as NewtonBody const ptr, byval childBone as NewtonBody const ptr) as any ptr
declare sub NewtonAcyclicArticulationDetachBone(byval articulation as NewtonAcyclicArticulation const ptr, byval bone as any const ptr)
declare sub NewtonAcyclicArticulationAddJoint(byval articulation as NewtonAcyclicArticulation const ptr, byval joint as NewtonJoint const ptr)
declare function NewtonMeshCreate(byval newtonWorld as const NewtonWorld const ptr) as NewtonMesh ptr
declare function NewtonMeshCreateFromMesh(byval mesh as const NewtonMesh const ptr) as NewtonMesh ptr
declare function NewtonMeshCreateFromCollision(byval collision as const NewtonCollision const ptr) as NewtonMesh ptr
declare function NewtonMeshCreateConvexHull(byval newtonWorld as const NewtonWorld const ptr, byval pointCount as long, byval vertexCloud as const dFloat const ptr, byval strideInBytes as long, byval tolerance as dFloat) as NewtonMesh ptr
declare function NewtonMeshCreateDelaunayTetrahedralization(byval newtonWorld as const NewtonWorld const ptr, byval pointCount as long, byval vertexCloud as const dFloat const ptr, byval strideInBytes as long, byval materialID as long, byval textureMatrix as const dFloat const ptr) as NewtonMesh ptr
declare function NewtonMeshCreateVoronoiConvexDecomposition(byval newtonWorld as const NewtonWorld const ptr, byval pointCount as long, byval vertexCloud as const dFloat const ptr, byval strideInBytes as long, byval materialID as long, byval textureMatrix as const dFloat const ptr) as NewtonMesh ptr
declare function NewtonMeshCreateFromSerialization(byval newtonWorld as const NewtonWorld const ptr, byval deserializeFunction as NewtonDeserializeCallback, byval serializeHandle as any const ptr) as NewtonMesh ptr
declare sub NewtonMeshDestroy(byval mesh as const NewtonMesh const ptr)
declare sub NewtonMeshSerialize(byval mesh as const NewtonMesh const ptr, byval serializeFunction as NewtonSerializeCallback, byval serializeHandle as any const ptr)
declare sub NewtonMeshSaveOFF(byval mesh as const NewtonMesh const ptr, byval filename as const zstring const ptr)
declare function NewtonMeshLoadOFF(byval newtonWorld as const NewtonWorld const ptr, byval filename as const zstring const ptr) as NewtonMesh ptr
declare sub NewtonMeshApplyTransform(byval mesh as const NewtonMesh const ptr, byval matrix as const dFloat const ptr)
declare sub NewtonMeshCalculateOOBB(byval mesh as const NewtonMesh const ptr, byval matrix as dFloat const ptr, byval x as dFloat const ptr, byval y as dFloat const ptr, byval z as dFloat const ptr)
declare sub NewtonMeshCalculateVertexNormals(byval mesh as const NewtonMesh const ptr, byval angleInRadians as dFloat)
declare sub NewtonMeshApplySphericalMapping(byval mesh as const NewtonMesh const ptr, byval material as long)
declare sub NewtonMeshApplyCylindricalMapping(byval mesh as const NewtonMesh const ptr, byval cylinderMaterial as long, byval capMaterial as long)
declare sub NewtonMeshApplyBoxMapping(byval mesh as const NewtonMesh const ptr, byval frontMaterial as long, byval sideMaterial as long, byval topMaterial as long)
declare sub NewtonMeshApplyAngleBasedMapping(byval mesh as const NewtonMesh const ptr, byval material as long, byval reportPrograssCallback as NewtonReportProgress, byval reportPrgressUserData as any const ptr)
declare function NewtonMeshIsOpenMesh(byval mesh as const NewtonMesh const ptr) as long
declare sub NewtonMeshFixTJoints(byval mesh as const NewtonMesh const ptr)
declare sub NewtonMeshPolygonize(byval mesh as const NewtonMesh const ptr)
declare sub NewtonMeshTriangulate(byval mesh as const NewtonMesh const ptr)
declare function NewtonMeshUnion(byval mesh as const NewtonMesh const ptr, byval clipper as const NewtonMesh const ptr, byval clipperMatrix as const dFloat const ptr) as NewtonMesh ptr
declare function NewtonMeshDifference(byval mesh as const NewtonMesh const ptr, byval clipper as const NewtonMesh const ptr, byval clipperMatrix as const dFloat const ptr) as NewtonMesh ptr
declare function NewtonMeshIntersection(byval mesh as const NewtonMesh const ptr, byval clipper as const NewtonMesh const ptr, byval clipperMatrix as const dFloat const ptr) as NewtonMesh ptr
declare sub NewtonMeshClip(byval mesh as const NewtonMesh const ptr, byval clipper as const NewtonMesh const ptr, byval clipperMatrix as const dFloat const ptr, byval topMesh as NewtonMesh ptr const ptr, byval bottomMesh as NewtonMesh ptr const ptr)
declare function NewtonMeshConvexMeshIntersection(byval mesh as const NewtonMesh const ptr, byval convexMesh as const NewtonMesh const ptr) as NewtonMesh ptr
declare function NewtonMeshSimplify(byval mesh as const NewtonMesh const ptr, byval maxVertexCount as long, byval reportPrograssCallback as NewtonReportProgress, byval reportPrgressUserData as any const ptr) as NewtonMesh ptr
declare function NewtonMeshApproximateConvexDecomposition(byval mesh as const NewtonMesh const ptr, byval maxConcavity as dFloat, byval backFaceDistanceFactor as dFloat, byval maxCount as long, byval maxVertexPerHull as long, byval reportProgressCallback as NewtonReportProgress, byval reportProgressUserData as any const ptr) as NewtonMesh ptr
declare sub NewtonRemoveUnusedVertices(byval mesh as const NewtonMesh const ptr, byval vertexRemapTable as long const ptr)
declare sub NewtonMeshBeginFace(byval mesh as const NewtonMesh const ptr)
declare sub NewtonMeshAddFace(byval mesh as const NewtonMesh const ptr, byval vertexCount as long, byval vertex as const dFloat const ptr, byval strideInBytes as long, byval materialIndex as long)
declare sub NewtonMeshEndFace(byval mesh as const NewtonMesh const ptr)
declare sub NewtonMeshBuildFromVertexListIndexList(byval mesh as const NewtonMesh const ptr, byval faceCount as long, byval faceIndexCount as const long const ptr, byval faceMaterialIndex as const long const ptr, byval vertex as const dFloat const ptr, byval vertexStrideInBytes as long, byval vertexIndex as const long const ptr, byval normal as const dFloat const ptr, byval normalStrideInBytes as long, byval normalIndex as const long const ptr, byval uv0 as const dFloat const ptr, byval uv0StrideInBytes as long, byval uv0Index as const long const ptr, byval uv1 as const dFloat const ptr, byval uv1StrideInBytes as long, byval uv1Index as const long const ptr)
declare sub NewtonMeshGetVertexStreams(byval mesh as const NewtonMesh const ptr, byval vertexStrideInByte as long, byval vertex as dFloat const ptr, byval normalStrideInByte as long, byval normal as dFloat const ptr, byval uvStrideInByte0 as long, byval uv0 as dFloat const ptr, byval uvStrideInByte1 as long, byval uv1 as dFloat const ptr)
declare sub NewtonMeshGetIndirectVertexStreams(byval mesh as const NewtonMesh const ptr, byval vertexStrideInByte as long, byval vertex as dFloat const ptr, byval vertexIndices as long const ptr, byval vertexCount as long const ptr, byval normalStrideInByte as long, byval normal as dFloat const ptr, byval normalIndices as long const ptr, byval normalCount as long const ptr, byval uvStrideInByte0 as long, byval uv0 as dFloat const ptr, byval uvIndices0 as long const ptr, byval uvCount0 as long const ptr, byval uvStrideInByte1 as long, byval uv1 as dFloat const ptr, byval uvIndices1 as long const ptr, byval uvCount1 as long const ptr)
declare function NewtonMeshBeginHandle(byval mesh as const NewtonMesh const ptr) as any ptr
declare sub NewtonMeshEndHandle(byval mesh as const NewtonMesh const ptr, byval handle as any const ptr)
declare function NewtonMeshFirstMaterial(byval mesh as const NewtonMesh const ptr, byval handle as any const ptr) as long
declare function NewtonMeshNextMaterial(byval mesh as const NewtonMesh const ptr, byval handle as any const ptr, byval materialId as long) as long
declare function NewtonMeshMaterialGetMaterial(byval mesh as const NewtonMesh const ptr, byval handle as any const ptr, byval materialId as long) as long
declare function NewtonMeshMaterialGetIndexCount(byval mesh as const NewtonMesh const ptr, byval handle as any const ptr, byval materialId as long) as long
declare sub NewtonMeshMaterialGetIndexStream(byval mesh as const NewtonMesh const ptr, byval handle as any const ptr, byval materialId as long, byval index as long const ptr)
declare sub NewtonMeshMaterialGetIndexStreamShort(byval mesh as const NewtonMesh const ptr, byval handle as any const ptr, byval materialId as long, byval index as short const ptr)
declare function NewtonMeshCreateFirstSingleSegment(byval mesh as const NewtonMesh const ptr) as NewtonMesh ptr
declare function NewtonMeshCreateNextSingleSegment(byval mesh as const NewtonMesh const ptr, byval segment as const NewtonMesh const ptr) as NewtonMesh ptr
declare function NewtonMeshCreateFirstLayer(byval mesh as const NewtonMesh const ptr) as NewtonMesh ptr
declare function NewtonMeshCreateNextLayer(byval mesh as const NewtonMesh const ptr, byval segment as const NewtonMesh const ptr) as NewtonMesh ptr
declare function NewtonMeshGetTotalFaceCount(byval mesh as const NewtonMesh const ptr) as long
declare function NewtonMeshGetTotalIndexCount(byval mesh as const NewtonMesh const ptr) as long
declare sub NewtonMeshGetFaces(byval mesh as const NewtonMesh const ptr, byval faceIndexCount as long const ptr, byval faceMaterial as long const ptr, byval faceIndices as any ptr const ptr)
declare function NewtonMeshGetPointCount(byval mesh as const NewtonMesh const ptr) as long
declare function NewtonMeshGetPointStrideInByte(byval mesh as const NewtonMesh const ptr) as long
declare function NewtonMeshGetPointArray(byval mesh as const NewtonMesh const ptr) as double ptr
declare function NewtonMeshGetNormalArray(byval mesh as const NewtonMesh const ptr) as double ptr
declare function NewtonMeshGetUV0Array(byval mesh as const NewtonMesh const ptr) as double ptr
declare function NewtonMeshGetUV1Array(byval mesh as const NewtonMesh const ptr) as double ptr
declare function NewtonMeshGetVertexCount(byval mesh as const NewtonMesh const ptr) as long
declare function NewtonMeshGetVertexStrideInByte(byval mesh as const NewtonMesh const ptr) as long
declare function NewtonMeshGetVertexArray(byval mesh as const NewtonMesh const ptr) as double ptr
declare function NewtonMeshGetFirstVertex(byval mesh as const NewtonMesh const ptr) as any ptr
declare function NewtonMeshGetNextVertex(byval mesh as const NewtonMesh const ptr, byval vertex as const any const ptr) as any ptr
declare function NewtonMeshGetVertexIndex(byval mesh as const NewtonMesh const ptr, byval vertex as const any const ptr) as long
declare function NewtonMeshGetFirstPoint(byval mesh as const NewtonMesh const ptr) as any ptr
declare function NewtonMeshGetNextPoint(byval mesh as const NewtonMesh const ptr, byval point as const any const ptr) as any ptr
declare function NewtonMeshGetPointIndex(byval mesh as const NewtonMesh const ptr, byval point as const any const ptr) as long
declare function NewtonMeshGetVertexIndexFromPoint(byval mesh as const NewtonMesh const ptr, byval point as const any const ptr) as long
declare function NewtonMeshGetFirstEdge(byval mesh as const NewtonMesh const ptr) as any ptr
declare function NewtonMeshGetNextEdge(byval mesh as const NewtonMesh const ptr, byval edge as const any const ptr) as any ptr
declare sub NewtonMeshGetEdgeIndices(byval mesh as const NewtonMesh const ptr, byval edge as const any const ptr, byval v0 as long const ptr, byval v1 as long const ptr)
declare function NewtonMeshGetFirstFace(byval mesh as const NewtonMesh const ptr) as any ptr
declare function NewtonMeshGetNextFace(byval mesh as const NewtonMesh const ptr, byval face as const any const ptr) as any ptr
declare function NewtonMeshIsFaceOpen(byval mesh as const NewtonMesh const ptr, byval face as const any const ptr) as long
declare function NewtonMeshGetFaceMaterial(byval mesh as const NewtonMesh const ptr, byval face as const any const ptr) as long
declare function NewtonMeshGetFaceIndexCount(byval mesh as const NewtonMesh const ptr, byval face as const any const ptr) as long
declare sub NewtonMeshGetFaceIndices(byval mesh as const NewtonMesh const ptr, byval face as const any const ptr, byval indices as long const ptr)
declare sub NewtonMeshGetFacePointIndices(byval mesh as const NewtonMesh const ptr, byval face as const any const ptr, byval indices as long const ptr)
declare sub NewtonMeshCalculateFaceNormal(byval mesh as const NewtonMesh const ptr, byval face as const any const ptr, byval normal as double const ptr)
declare sub NewtonMeshSetFaceMaterial(byval mesh as const NewtonMesh const ptr, byval face as const any const ptr, byval matId as long)

end extern
