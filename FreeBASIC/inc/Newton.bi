''
''
'' Newton -- Newton Game dynamics (header translated with help of SWIG FB wrapper)
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __Newton_bi__
#define __Newton_bi__

#inclib "Newton"

#ifdef _NEWTON_DOUBLE_PRECISION__
type dFloat as double
#else
type dFloat as single
#endif

type NewtonBody as any

type NewtonWorld as any

type NewtonJoint as any

type NewtonContact as any

type NewtonMaterial as any

type NewtonCollision as any

type NewtonRagDoll as any

type NewtonRagDollBone as any

type NewtonUserMeshCollisionCollideDescTag
	m_boxP0(0 to 4-1) as dFloat ptr
	m_boxP1(0 to 4-1) as dFloat ptr
	m_userData as any ptr
	m_faceCount as integer
	m_vertex as dFloat ptr
	m_vertexStrideInBytes as integer
	m_userAttribute as integer ptr
	m_faceIndexCount as integer ptr
	m_faceVertexIndex as integer ptr
	m_objBody as NewtonBody ptr
	m_polySoupBody as NewtonBody ptr
end type

type NewtonUserMeshCollisionCollideDesc as NewtonUserMeshCollisionCollideDescTag

type NewtonUserMeshCollisionRayHitDescTag
	m_p0(0 to 4-1) as dFloat ptr
	m_p1(0 to 4-1) as dFloat ptr
	m_normalOut(0 to 4-1) as dFloat ptr
	m_userIdOut as integer
	m_userData as any ptr
end type

type NewtonUserMeshCollisionRayHitDesc as NewtonUserMeshCollisionRayHitDescTag

type NewtonHingeSliderUpdateDescTag
	m_accel as dFloat
	m_minFriction as dFloat
	m_maxFriction as dFloat
	m_timestep as dFloat
end type

type NewtonHingeSliderUpdateDesc as NewtonHingeSliderUpdateDescTag
type NewtonAllocMemory as function stdcall(byval as integer) as any ptr
type NewtonFreeMemory as sub stdcall(byval as any ptr, byval as integer)
type NewtonSerialize as sub stdcall(byval as any ptr, byval as any ptr, byval as integer)
type NewtonDeserialize as sub stdcall(byval as any ptr, byval as any ptr, byval as integer)
type NewtonUserMeshCollisionCollideCallback as sub stdcall(byval as NewtonUserMeshCollisionCollideDesc ptr)
type NewtonUserMeshCollisionRayHitCallback as function stdcall(byval as NewtonUserMeshCollisionRayHitDesc ptr) as dFloat
type NewtonUserMeshCollisionDestroyCallback as sub stdcall(byval as any ptr)
type NewtonTreeCollisionCallback as sub stdcall(byval as NewtonBody ptr, byval as NewtonBody ptr, byval as dFloat ptr, byval as integer, byval as integer, byval as integer ptr)
type NewtonBodyDestructor as sub stdcall(byval as NewtonBody ptr)
type NewtonApplyForceAndTorque as sub stdcall(byval as NewtonBody ptr)
type NewtonBodyActivationState as sub stdcall(byval as NewtonBody ptr, byval as uinteger)
type NewtonSetTransform as sub stdcall(byval as NewtonBody ptr, byval as dFloat ptr)
type NewtonSetRagDollTransform as sub stdcall(byval as NewtonRagDollBone ptr)
type NewtonGetBuoyancyPlane as sub stdcall(byval as any ptr, byval as dFloat ptr, byval as dFloat ptr)
type NewtonVehicleTireUpdate as sub stdcall(byval as NewtonJoint ptr)
type NewtonWorldRayFilterCallback as function stdcall(byval as NewtonBody ptr, byval as dFloat ptr, byval as integer, byval as any ptr, byval as dFloat) as dFloat
type NewtonBodyLeaveWorld as sub stdcall(byval as NewtonBody ptr)
type NewtonContactBegin as function stdcall(byval as NewtonMaterial ptr, byval as NewtonBody ptr, byval as NewtonBody ptr) as integer
type NewtonContactProcess as function stdcall(byval as NewtonMaterial ptr, byval as NewtonContact ptr) as integer
type NewtonContactEnd as sub stdcall(byval as NewtonMaterial ptr)
type NewtonBodyIterator as sub stdcall(byval as NewtonBody ptr)
type NewtonCollisionIterator as sub stdcall(byval as NewtonBody ptr, byval as integer, byval as dFloat ptr, byval as integer)
type NewtonBallCallBack as sub stdcall(byval as NewtonJoint ptr)
type NewtonHingeCallBack as function stdcall(byval as NewtonJoint ptr, byval as NewtonHingeSliderUpdateDesc ptr) as uinteger
type NewtonSliderCallBack as function stdcall(byval as NewtonJoint ptr, byval as NewtonHingeSliderUpdateDesc ptr) as uinteger
type NewtonUniversalCallBack as function stdcall(byval as NewtonJoint ptr, byval as NewtonHingeSliderUpdateDesc ptr) as uinteger
type NewtonCorkscrewCallBack as function stdcall(byval as NewtonJoint ptr, byval as NewtonHingeSliderUpdateDesc ptr) as uinteger
type NewtonUserBilateralCallBack as sub stdcall(byval as NewtonJoint ptr)
type NewtonConstraintDestructor as sub stdcall(byval as NewtonJoint ptr)

declare function NewtonCreate stdcall alias "NewtonCreate" (byval malloc as NewtonAllocMemory, byval mfree as NewtonFreeMemory) as NewtonWorld ptr
declare sub NewtonDestroy stdcall alias "NewtonDestroy" (byval newtonWorld as NewtonWorld ptr)
declare sub NewtonDestroyAllBodies stdcall alias "NewtonDestroyAllBodies" (byval newtonWorld as NewtonWorld ptr)
declare sub NewtonUpdate stdcall alias "NewtonUpdate" (byval newtonWorld as NewtonWorld ptr, byval timestep as dFloat)
declare sub NewtonSetSolverModel stdcall alias "NewtonSetSolverModel" (byval newtonWorld as NewtonWorld ptr, byval model as integer)
declare sub NewtonSetFrictionModel stdcall alias "NewtonSetFrictionModel" (byval newtonWorld as NewtonWorld ptr, byval model as integer)
declare function NewtonGetTimeStep stdcall alias "NewtonGetTimeStep" (byval newtonWorld as NewtonWorld ptr) as dFloat
declare sub NewtonSetMinimumFrameRate stdcall alias "NewtonSetMinimumFrameRate" (byval newtonWorld as NewtonWorld ptr, byval frameRate as dFloat)
declare sub NewtonSetBodyLeaveWorldEvent stdcall alias "NewtonSetBodyLeaveWorldEvent" (byval newtonWorld as NewtonWorld ptr, byval callback as NewtonBodyLeaveWorld)
declare sub NewtonSetWorldSize stdcall alias "NewtonSetWorldSize" (byval newtonWorld as NewtonWorld ptr, byval minPoint as dFloat ptr, byval maxPoint as dFloat ptr)
declare sub NewtonWorldFreezeBody stdcall alias "NewtonWorldFreezeBody" (byval newtonWorld as NewtonWorld ptr, byval body as NewtonBody ptr)
declare sub NewtonWorldUnfreezeBody stdcall alias "NewtonWorldUnfreezeBody" (byval newtonWorld as NewtonWorld ptr, byval body as NewtonBody ptr)
declare sub NewtonWorldForEachBodyDo stdcall alias "NewtonWorldForEachBodyDo" (byval newtonWorld as NewtonWorld ptr, byval callback as NewtonBodyIterator)
declare sub NewtonWorldSetUserData stdcall alias "NewtonWorldSetUserData" (byval newtonWorld as NewtonWorld ptr, byval userData as any ptr)
declare function NewtonWorldGetUserData stdcall alias "NewtonWorldGetUserData" (byval newtonWorld as NewtonWorld ptr) as any ptr
declare function NewtonWorldGetVersion stdcall alias "NewtonWorldGetVersion" (byval newtonWorld as NewtonWorld ptr) as integer
declare sub NewtonWorldRayCast stdcall alias "NewtonWorldRayCast" (byval newtonWorld as NewtonWorld ptr, byval p0 as dFloat ptr, byval p1 as dFloat ptr, byval filter as NewtonWorldRayFilterCallback, byval userData as any ptr)
declare function NewtonWorldCollide stdcall alias "NewtonWorldCollide" (byval newtonWorld as NewtonWorld ptr, byval maxSize as integer, byval collsionA as NewtonCollision ptr, byval matrixA as dFloat ptr, byval collsionB as NewtonCollision ptr, byval matrixB as dFloat ptr, byval contacts as dFloat ptr, byval normals as dFloat ptr, byval penetration as dFloat ptr) as integer
declare function NewtonMaterialGetDefaultGroupID stdcall alias "NewtonMaterialGetDefaultGroupID" (byval newtonWorld as NewtonWorld ptr) as integer
declare function NewtonMaterialCreateGroupID stdcall alias "NewtonMaterialCreateGroupID" (byval newtonWorld as NewtonWorld ptr) as integer
declare sub NewtonMaterialDestroyAllGroupID stdcall alias "NewtonMaterialDestroyAllGroupID" (byval newtonWorld as NewtonWorld ptr)
declare sub NewtonMaterialSetDefaultSoftness stdcall alias "NewtonMaterialSetDefaultSoftness" (byval newtonWorld as NewtonWorld ptr, byval id0 as integer, byval id1 as integer, byval value as dFloat)
declare sub NewtonMaterialSetDefaultElasticity stdcall alias "NewtonMaterialSetDefaultElasticity" (byval newtonWorld as NewtonWorld ptr, byval id0 as integer, byval id1 as integer, byval elasticCoef as dFloat)
declare sub NewtonMaterialSetDefaultCollidable stdcall alias "NewtonMaterialSetDefaultCollidable" (byval newtonWorld as NewtonWorld ptr, byval id0 as integer, byval id1 as integer, byval state as integer)
declare sub NewtonMaterialSetDefaultFriction stdcall alias "NewtonMaterialSetDefaultFriction" (byval newtonWorld as NewtonWorld ptr, byval id0 as integer, byval id1 as integer, byval staticFriction as dFloat, byval kineticFriction as dFloat)
declare sub NewtonMaterialSetCollisionCallback stdcall alias "NewtonMaterialSetCollisionCallback" (byval newtonWorld as NewtonWorld ptr, byval id0 as integer, byval id1 as integer, byval userData as any ptr, byval begin as NewtonContactBegin, byval process as NewtonContactProcess, byval end as NewtonContactEnd)
declare function NewtonMaterialGetUserData stdcall alias "NewtonMaterialGetUserData" (byval newtonWorld as NewtonWorld ptr, byval id0 as integer, byval id1 as integer) as any ptr
declare sub NewtonMaterialDisableContact stdcall alias "NewtonMaterialDisableContact" (byval material as NewtonMaterial ptr)
declare function NewtonMaterialGetCurrentTimestep stdcall alias "NewtonMaterialGetCurrentTimestep" (byval material as NewtonMaterial ptr) as dFloat
declare function NewtonMaterialGetMaterialPairUserData stdcall alias "NewtonMaterialGetMaterialPairUserData" (byval material as NewtonMaterial ptr) as any ptr
declare function NewtonMaterialGetContactFaceAttribute stdcall alias "NewtonMaterialGetContactFaceAttribute" (byval material as NewtonMaterial ptr) as uinteger
declare function NewtonMaterialGetBodyCollisionID stdcall alias "NewtonMaterialGetBodyCollisionID" (byval material as NewtonMaterial ptr, byval body as NewtonBody ptr) as uinteger
declare function NewtonMaterialGetContactNormalSpeed stdcall alias "NewtonMaterialGetContactNormalSpeed" (byval material as NewtonMaterial ptr, byval contactlHandle as NewtonContact ptr) as dFloat
declare sub NewtonMaterialGetContactForce stdcall alias "NewtonMaterialGetContactForce" (byval material as NewtonMaterial ptr, byval force as dFloat ptr)
declare sub NewtonMaterialGetContactPositionAndNormal stdcall alias "NewtonMaterialGetContactPositionAndNormal" (byval material as NewtonMaterial ptr, byval posit as dFloat ptr, byval normal as dFloat ptr)
declare sub NewtonMaterialGetContactTangentDirections stdcall alias "NewtonMaterialGetContactTangentDirections" (byval material as NewtonMaterial ptr, byval dir0 as dFloat ptr, byval dir as dFloat ptr)
declare function NewtonMaterialGetContactTangentSpeed stdcall alias "NewtonMaterialGetContactTangentSpeed" (byval material as NewtonMaterial ptr, byval contactlHandle as NewtonContact ptr, byval index as integer) as dFloat
declare sub NewtonMaterialSetContactSoftness stdcall alias "NewtonMaterialSetContactSoftness" (byval material as NewtonMaterial ptr, byval softness as dFloat)
declare sub NewtonMaterialSetContactElasticity stdcall alias "NewtonMaterialSetContactElasticity" (byval material as NewtonMaterial ptr, byval restitution as dFloat)
declare sub NewtonMaterialSetContactFrictionState stdcall alias "NewtonMaterialSetContactFrictionState" (byval material as NewtonMaterial ptr, byval state as integer, byval index as integer)
declare sub NewtonMaterialSetContactStaticFrictionCoef stdcall alias "NewtonMaterialSetContactStaticFrictionCoef" (byval material as NewtonMaterial ptr, byval coef as dFloat, byval index as integer)
declare sub NewtonMaterialSetContactKineticFrictionCoef stdcall alias "NewtonMaterialSetContactKineticFrictionCoef" (byval material as NewtonMaterial ptr, byval coef as dFloat, byval index as integer)
declare sub NewtonMaterialSetContactTangentAcceleration stdcall alias "NewtonMaterialSetContactTangentAcceleration" (byval material as NewtonMaterial ptr, byval accel as dFloat, byval index as integer)
declare sub NewtonMaterialContactRotateTangentDirections stdcall alias "NewtonMaterialContactRotateTangentDirections" (byval material as NewtonMaterial ptr, byval directionVector as dFloat ptr)
declare function NewtonCreateNull stdcall alias "NewtonCreateNull" (byval newtonWorld as NewtonWorld ptr) as NewtonCollision ptr
declare function NewtonCreateSphere stdcall alias "NewtonCreateSphere" (byval newtonWorld as NewtonWorld ptr, byval radiusX as dFloat, byval radiusY as dFloat, byval radiusZ as dFloat, byval offsetMatrix as dFloat ptr) as NewtonCollision ptr
declare function NewtonCreateBox stdcall alias "NewtonCreateBox" (byval newtonWorld as NewtonWorld ptr, byval dx as dFloat, byval dy as dFloat, byval dz as dFloat, byval offsetMatrix as dFloat ptr) as NewtonCollision ptr
declare function NewtonCreateCone stdcall alias "NewtonCreateCone" (byval newtonWorld as NewtonWorld ptr, byval radius as dFloat, byval height as dFloat, byval offsetMatrix as dFloat ptr) as NewtonCollision ptr
declare function NewtonCreateCapsule stdcall alias "NewtonCreateCapsule" (byval newtonWorld as NewtonWorld ptr, byval radius as dFloat, byval height as dFloat, byval offsetMatrix as dFloat ptr) as NewtonCollision ptr
declare function NewtonCreateCylinder stdcall alias "NewtonCreateCylinder" (byval newtonWorld as NewtonWorld ptr, byval radius as dFloat, byval height as dFloat, byval offsetMatrix as dFloat ptr) as NewtonCollision ptr
declare function NewtonCreateChamferCylinder stdcall alias "NewtonCreateChamferCylinder" (byval newtonWorld as NewtonWorld ptr, byval radius as dFloat, byval height as dFloat, byval offsetMatrix as dFloat ptr) as NewtonCollision ptr
declare function NewtonCreateConvexHull stdcall alias "NewtonCreateConvexHull" (byval newtonWorld as NewtonWorld ptr, byval count as integer, byval vertexCloud as dFloat ptr, byval strideInBytes as integer, byval offsetMatrix as dFloat ptr) as NewtonCollision ptr
declare function NewtonCreateConvexHullModifier stdcall alias "NewtonCreateConvexHullModifier" (byval newtonWorld as NewtonWorld ptr, byval convexHullCollision as NewtonCollision ptr) as NewtonCollision ptr
declare sub NewtonConvexHullModifierGetMatrix stdcall alias "NewtonConvexHullModifierGetMatrix" (byval convexHullCollision as NewtonCollision ptr, byval matrix as dFloat ptr)
declare sub NewtonConvexHullModifierSetMatrix stdcall alias "NewtonConvexHullModifierSetMatrix" (byval convexHullCollision as NewtonCollision ptr, byval matrix as dFloat ptr)
declare sub NewtonConvexCollisionSetUserID stdcall alias "NewtonConvexCollisionSetUserID" (byval convexCollision as NewtonCollision ptr, byval id as uinteger)
declare function NewtonConvexCollisionGetUserID stdcall alias "NewtonConvexCollisionGetUserID" (byval convexCollision as NewtonCollision ptr) as uinteger
declare function NewtonCreateCompoundCollision stdcall alias "NewtonCreateCompoundCollision" (byval newtonWorld as NewtonWorld ptr, byval count as integer, byval collisionPrimitiveArray as NewtonCollision ptr ptr) as NewtonCollision ptr
declare function NewtonCreateUserMeshCollision stdcall alias "NewtonCreateUserMeshCollision" (byval newtonWorld as NewtonWorld ptr, byval minBox as dFloat ptr, byval maxBox as dFloat ptr, byval userData as any ptr, byval collideCallback as NewtonUserMeshCollisionCollideCallback, byval rayHitCallback as NewtonUserMeshCollisionRayHitCallback, byval destroyCallback as NewtonUserMeshCollisionDestroyCallback) as NewtonCollision ptr
declare function NewtonCreateTreeCollision stdcall alias "NewtonCreateTreeCollision" (byval newtonWorld as NewtonWorld ptr, byval userCallback as NewtonTreeCollisionCallback) as NewtonCollision ptr
declare sub NewtonTreeCollisionBeginBuild stdcall alias "NewtonTreeCollisionBeginBuild" (byval treeCollision as NewtonCollision ptr)
declare sub NewtonTreeCollisionAddFace stdcall alias "NewtonTreeCollisionAddFace" (byval treeCollision as NewtonCollision ptr, byval vertexCount as integer, byval vertexPtr as dFloat ptr, byval strideInBytes as integer, byval faceAttribute as integer)
declare sub NewtonTreeCollisionEndBuild stdcall alias "NewtonTreeCollisionEndBuild" (byval treeCollision as NewtonCollision ptr, byval optimize as integer)
declare sub NewtonTreeCollisionSerialize stdcall alias "NewtonTreeCollisionSerialize" (byval treeCollision as NewtonCollision ptr, byval serializeFunction as NewtonSerialize, byval serializeHandle as any ptr)
declare function NewtonCreateTreeCollisionFromSerialization stdcall alias "NewtonCreateTreeCollisionFromSerialization" (byval newtonWorld as NewtonWorld ptr, byval userCallback as NewtonTreeCollisionCallback, byval deserializeFunction as NewtonDeserialize, byval serializeHandle as any ptr) as NewtonCollision ptr
declare function NewtonTreeCollisionGetFaceAtribute stdcall alias "NewtonTreeCollisionGetFaceAtribute" (byval treeCollision as NewtonCollision ptr, byval faceIndexArray as integer ptr) as integer
declare sub NewtonTreeCollisionSetFaceAtribute stdcall alias "NewtonTreeCollisionSetFaceAtribute" (byval treeCollision as NewtonCollision ptr, byval faceIndexArray as integer ptr, byval attribute as integer)
declare sub NewtonReleaseCollision stdcall alias "NewtonReleaseCollision" (byval newtonWorld as NewtonWorld ptr, byval collision as NewtonCollision ptr)
declare sub NewtonCollisionCalculateAABB stdcall alias "NewtonCollisionCalculateAABB" (byval collision as NewtonCollision ptr, byval matrix as dFloat ptr, byval p0 as dFloat ptr, byval p1 as dFloat ptr)
declare function NewtonCollisionRayCast stdcall alias "NewtonCollisionRayCast" (byval collision as NewtonCollision ptr, byval p0 as dFloat ptr, byval p1 as dFloat ptr, byval normals as dFloat ptr, byval attribute as integer ptr) as dFloat
declare sub NewtonGetEulerAngle stdcall alias "NewtonGetEulerAngle" (byval matrix as dFloat ptr, byval eulersAngles as dFloat ptr)
declare sub NewtonSetEulerAngle stdcall alias "NewtonSetEulerAngle" (byval eulersAngles as dFloat ptr, byval matrix as dFloat ptr)
declare function NewtonCreateBody stdcall alias "NewtonCreateBody" (byval newtonWorld as NewtonWorld ptr, byval collision as NewtonCollision ptr) as NewtonBody ptr
declare sub NewtonDestroyBody stdcall alias "NewtonDestroyBody" (byval newtonWorld as NewtonWorld ptr, byval body as NewtonBody ptr)
declare sub NewtonBodyAddForce stdcall alias "NewtonBodyAddForce" (byval body as NewtonBody ptr, byval force as dFloat ptr)
declare sub NewtonBodyAddTorque stdcall alias "NewtonBodyAddTorque" (byval body as NewtonBody ptr, byval torque as dFloat ptr)
declare sub NewtonBodySetMatrix stdcall alias "NewtonBodySetMatrix" (byval body as NewtonBody ptr, byval matrix as dFloat ptr)
declare sub NewtonBodySetMatrixRecursive stdcall alias "NewtonBodySetMatrixRecursive" (byval body as NewtonBody ptr, byval matrix as dFloat ptr)
declare sub NewtonBodySetMassMatrix stdcall alias "NewtonBodySetMassMatrix" (byval body as NewtonBody ptr, byval mass as dFloat, byval Ixx as dFloat, byval Iyy as dFloat, byval Izz as dFloat)
declare sub NewtonBodySetMaterialGroupID stdcall alias "NewtonBodySetMaterialGroupID" (byval body as NewtonBody ptr, byval id as integer)
declare sub NewtonBodySetContinuousCollisionMode stdcall alias "NewtonBodySetContinuousCollisionMode" (byval body as NewtonBody ptr, byval state as uinteger)
declare sub NewtonBodySetJointRecursiveCollision stdcall alias "NewtonBodySetJointRecursiveCollision" (byval body as NewtonBody ptr, byval state as uinteger)
declare sub NewtonBodySetOmega stdcall alias "NewtonBodySetOmega" (byval body as NewtonBody ptr, byval omega as dFloat ptr)
declare sub NewtonBodySetVelocity stdcall alias "NewtonBodySetVelocity" (byval body as NewtonBody ptr, byval velocity as dFloat ptr)
declare sub NewtonBodySetForce stdcall alias "NewtonBodySetForce" (byval body as NewtonBody ptr, byval force as dFloat ptr)
declare sub NewtonBodySetTorque stdcall alias "NewtonBodySetTorque" (byval body as NewtonBody ptr, byval torque as dFloat ptr)
declare sub NewtonBodySetLinearDamping stdcall alias "NewtonBodySetLinearDamping" (byval body as NewtonBody ptr, byval linearDamp as dFloat)
declare sub NewtonBodySetAngularDamping stdcall alias "NewtonBodySetAngularDamping" (byval body as NewtonBody ptr, byval angularDamp as dFloat ptr)
declare sub NewtonBodySetUserData stdcall alias "NewtonBodySetUserData" (byval body as NewtonBody ptr, byval userData as any ptr)
declare sub NewtonBodyCoriolisForcesMode stdcall alias "NewtonBodyCoriolisForcesMode" (byval body as NewtonBody ptr, byval mode as integer)
declare sub NewtonBodySetCollision stdcall alias "NewtonBodySetCollision" (byval body as NewtonBody ptr, byval collision as NewtonCollision ptr)
declare sub NewtonBodySetAutoFreeze stdcall alias "NewtonBodySetAutoFreeze" (byval body as NewtonBody ptr, byval state as integer)
declare sub NewtonBodySetFreezeTreshold stdcall alias "NewtonBodySetFreezeTreshold" (byval body as NewtonBody ptr, byval freezeSpeed2 as dFloat, byval freezeOmega2 as dFloat, byval framesCount as integer)
declare sub NewtonBodySetTransformCallback stdcall alias "NewtonBodySetTransformCallback" (byval body as NewtonBody ptr, byval callback as NewtonSetTransform)
declare sub NewtonBodySetDestructorCallback stdcall alias "NewtonBodySetDestructorCallback" (byval body as NewtonBody ptr, byval callback as NewtonBodyDestructor)
declare sub NewtonBodySetAutoactiveCallback stdcall alias "NewtonBodySetAutoactiveCallback" (byval body as NewtonBody ptr, byval callback as NewtonBodyActivationState)
declare sub NewtonBodySetForceAndTorqueCallback stdcall alias "NewtonBodySetForceAndTorqueCallback" (byval body as NewtonBody ptr, byval callback as NewtonApplyForceAndTorque)
declare function NewtonBodyGetWorld stdcall alias "NewtonBodyGetWorld" (byval body as NewtonBody ptr) as NewtonWorld ptr
declare function NewtonBodyGetUserData stdcall alias "NewtonBodyGetUserData" (byval body as NewtonBody ptr) as any ptr
declare function NewtonBodyGetCollision stdcall alias "NewtonBodyGetCollision" (byval body as NewtonBody ptr) as NewtonCollision ptr
declare function NewtonBodyGetMaterialGroupID stdcall alias "NewtonBodyGetMaterialGroupID" (byval body as NewtonBody ptr) as integer
declare function NewtonBodyGetContinuousCollisionMode stdcall alias "NewtonBodyGetContinuousCollisionMode" (byval body as NewtonBody ptr) as integer
declare function NewtonBodyGetJointRecursiveCollision stdcall alias "NewtonBodyGetJointRecursiveCollision" (byval body as NewtonBody ptr) as integer
declare sub NewtonBodyGetMatrix stdcall alias "NewtonBodyGetMatrix" (byval body as NewtonBody ptr, byval matrix as dFloat ptr)
declare sub NewtonBodyGetMassMatrix stdcall alias "NewtonBodyGetMassMatrix" (byval body as NewtonBody ptr, byval mass as dFloat ptr, byval Ixx as dFloat ptr, byval Iyy as dFloat ptr, byval Izz as dFloat ptr)
declare sub NewtonBodyGetInvMass stdcall alias "NewtonBodyGetInvMass" (byval body as NewtonBody ptr, byval invMass as dFloat ptr, byval invIxx as dFloat ptr, byval invIyy as dFloat ptr, byval invIzz as dFloat ptr)
declare sub NewtonBodyGetOmega stdcall alias "NewtonBodyGetOmega" (byval body as NewtonBody ptr, byval vector as dFloat ptr)
declare sub NewtonBodyGetVelocity stdcall alias "NewtonBodyGetVelocity" (byval body as NewtonBody ptr, byval vector as dFloat ptr)
declare sub NewtonBodyGetForce stdcall alias "NewtonBodyGetForce" (byval body as NewtonBody ptr, byval vector as dFloat ptr)
declare sub NewtonBodyGetTorque stdcall alias "NewtonBodyGetTorque" (byval body as NewtonBody ptr, byval vector as dFloat ptr)
declare function NewtonBodyGetSleepingState stdcall alias "NewtonBodyGetSleepingState" (byval body as NewtonBody ptr) as integer
declare function NewtonBodyGetAutoFreeze stdcall alias "NewtonBodyGetAutoFreeze" (byval body as NewtonBody ptr) as integer
declare function NewtonBodyGetLinearDamping stdcall alias "NewtonBodyGetLinearDamping" (byval body as NewtonBody ptr) as dFloat
declare sub NewtonBodyGetAngularDamping stdcall alias "NewtonBodyGetAngularDamping" (byval body as NewtonBody ptr, byval vector as dFloat ptr)
declare sub NewtonBodyGetAABB stdcall alias "NewtonBodyGetAABB" (byval body as NewtonBody ptr, byval p0 as dFloat ptr, byval p1 as dFloat ptr)
declare sub NewtonBodyGetFreezeTreshold stdcall alias "NewtonBodyGetFreezeTreshold" (byval body as NewtonBody ptr, byval freezeSpeed2 as dFloat ptr, byval freezeOmega2 as dFloat ptr)
declare function NewtonBodyGetTotalVolume stdcall alias "NewtonBodyGetTotalVolume" (byval body as NewtonBody ptr) as dFloat
declare sub NewtonBodyAddBuoyancyForce stdcall alias "NewtonBodyAddBuoyancyForce" (byval body as NewtonBody ptr, byval fluidDensity as dFloat, byval fluidLinearViscosity as dFloat, byval fluidAngularViscosity as dFloat, byval gravityVector as dFloat ptr, byval buoyancyPlane as NewtonGetBuoyancyPlane, byval context as any ptr)
declare sub NewtonBodyForEachPolygonDo stdcall alias "NewtonBodyForEachPolygonDo" (byval body as NewtonBody ptr, byval callback as NewtonCollisionIterator)
declare sub NewtonAddBodyImpulse stdcall alias "NewtonAddBodyImpulse" (byval body as NewtonBody ptr, byval pointDeltaVeloc as dFloat ptr, byval pointPosit as dFloat ptr)
declare function NewtonJointGetUserData stdcall alias "NewtonJointGetUserData" (byval joint as NewtonJoint ptr) as any ptr
declare sub NewtonJointSetUserData stdcall alias "NewtonJointSetUserData" (byval joint as NewtonJoint ptr, byval userData as any ptr)
declare function NewtonJointGetCollisionState stdcall alias "NewtonJointGetCollisionState" (byval joint as NewtonJoint ptr) as integer
declare sub NewtonJointSetCollisionState stdcall alias "NewtonJointSetCollisionState" (byval joint as NewtonJoint ptr, byval state as integer)
declare function NewtonJointGetStiffness stdcall alias "NewtonJointGetStiffness" (byval joint as NewtonJoint ptr) as dFloat
declare sub NewtonJointSetStiffness stdcall alias "NewtonJointSetStiffness" (byval joint as NewtonJoint ptr, byval state as dFloat)
declare sub NewtonDestroyJoint stdcall alias "NewtonDestroyJoint" (byval newtonWorld as NewtonWorld ptr, byval joint as NewtonJoint ptr)
declare sub NewtonJointSetDestructor stdcall alias "NewtonJointSetDestructor" (byval joint as NewtonJoint ptr, byval destructor as NewtonConstraintDestructor)
declare function NewtonConstraintCreateBall stdcall alias "NewtonConstraintCreateBall" (byval newtonWorld as NewtonWorld ptr, byval pivotPoint as dFloat ptr, byval childBody as NewtonBody ptr, byval parentBody as NewtonBody ptr) as NewtonJoint ptr
declare sub NewtonBallSetUserCallback stdcall alias "NewtonBallSetUserCallback" (byval ball as NewtonJoint ptr, byval callback as NewtonBallCallBack)
declare sub NewtonBallGetJointAngle stdcall alias "NewtonBallGetJointAngle" (byval ball as NewtonJoint ptr, byval angle as dFloat ptr)
declare sub NewtonBallGetJointOmega stdcall alias "NewtonBallGetJointOmega" (byval ball as NewtonJoint ptr, byval omega as dFloat ptr)
declare sub NewtonBallGetJointForce stdcall alias "NewtonBallGetJointForce" (byval ball as NewtonJoint ptr, byval force as dFloat ptr)
declare sub NewtonBallSetConeLimits stdcall alias "NewtonBallSetConeLimits" (byval ball as NewtonJoint ptr, byval pin as dFloat ptr, byval maxConeAngle as dFloat, byval maxTwistAngle as dFloat)
declare function NewtonConstraintCreateHinge stdcall alias "NewtonConstraintCreateHinge" (byval newtonWorld as NewtonWorld ptr, byval pivotPoint as dFloat ptr, byval pinDir as dFloat ptr, byval childBody as NewtonBody ptr, byval parentBody as NewtonBody ptr) as NewtonJoint ptr
declare sub NewtonHingeSetUserCallback stdcall alias "NewtonHingeSetUserCallback" (byval hinge as NewtonJoint ptr, byval callback as NewtonHingeCallBack)
declare function NewtonHingeGetJointAngle stdcall alias "NewtonHingeGetJointAngle" (byval hinge as NewtonJoint ptr) as dFloat
declare function NewtonHingeGetJointOmega stdcall alias "NewtonHingeGetJointOmega" (byval hinge as NewtonJoint ptr) as dFloat
declare sub NewtonHingeGetJointForce stdcall alias "NewtonHingeGetJointForce" (byval hinge as NewtonJoint ptr, byval force as dFloat ptr)
declare function NewtonHingeCalculateStopAlpha stdcall alias "NewtonHingeCalculateStopAlpha" (byval hinge as NewtonJoint ptr, byval desc as NewtonHingeSliderUpdateDesc ptr, byval angle as dFloat) as dFloat
declare function NewtonConstraintCreateSlider stdcall alias "NewtonConstraintCreateSlider" (byval newtonWorld as NewtonWorld ptr, byval pivotPoint as dFloat ptr, byval pinDir as dFloat ptr, byval childBody as NewtonBody ptr, byval parentBody as NewtonBody ptr) as NewtonJoint ptr
declare sub NewtonSliderSetUserCallback stdcall alias "NewtonSliderSetUserCallback" (byval slider as NewtonJoint ptr, byval callback as NewtonSliderCallBack)
declare function NewtonSliderGetJointPosit stdcall alias "NewtonSliderGetJointPosit" (byval slider as NewtonJoint ptr) as dFloat
declare function NewtonSliderGetJointVeloc stdcall alias "NewtonSliderGetJointVeloc" (byval slider as NewtonJoint ptr) as dFloat
declare sub NewtonSliderGetJointForce stdcall alias "NewtonSliderGetJointForce" (byval slider as NewtonJoint ptr, byval force as dFloat ptr)
declare function NewtonSliderCalculateStopAccel stdcall alias "NewtonSliderCalculateStopAccel" (byval slider as NewtonJoint ptr, byval desc as NewtonHingeSliderUpdateDesc ptr, byval position as dFloat) as dFloat
declare function NewtonConstraintCreateCorkscrew stdcall alias "NewtonConstraintCreateCorkscrew" (byval newtonWorld as NewtonWorld ptr, byval pivotPoint as dFloat ptr, byval pinDir as dFloat ptr, byval childBody as NewtonBody ptr, byval parentBody as NewtonBody ptr) as NewtonJoint ptr
declare sub NewtonCorkscrewSetUserCallback stdcall alias "NewtonCorkscrewSetUserCallback" (byval corkscrew as NewtonJoint ptr, byval callback as NewtonCorkscrewCallBack)
declare function NewtonCorkscrewGetJointPosit stdcall alias "NewtonCorkscrewGetJointPosit" (byval corkscrew as NewtonJoint ptr) as dFloat
declare function NewtonCorkscrewGetJointAngle stdcall alias "NewtonCorkscrewGetJointAngle" (byval corkscrew as NewtonJoint ptr) as dFloat
declare function NewtonCorkscrewGetJointVeloc stdcall alias "NewtonCorkscrewGetJointVeloc" (byval corkscrew as NewtonJoint ptr) as dFloat
declare function NewtonCorkscrewGetJointOmega stdcall alias "NewtonCorkscrewGetJointOmega" (byval corkscrew as NewtonJoint ptr) as dFloat
declare sub NewtonCorkscrewGetJointForce stdcall alias "NewtonCorkscrewGetJointForce" (byval corkscrew as NewtonJoint ptr, byval force as dFloat ptr)
declare function NewtonCorkscrewCalculateStopAlpha stdcall alias "NewtonCorkscrewCalculateStopAlpha" (byval corkscrew as NewtonJoint ptr, byval desc as NewtonHingeSliderUpdateDesc ptr, byval angle as dFloat) as dFloat
declare function NewtonCorkscrewCalculateStopAccel stdcall alias "NewtonCorkscrewCalculateStopAccel" (byval corkscrew as NewtonJoint ptr, byval desc as NewtonHingeSliderUpdateDesc ptr, byval position as dFloat) as dFloat
declare function NewtonConstraintCreateUniversal stdcall alias "NewtonConstraintCreateUniversal" (byval newtonWorld as NewtonWorld ptr, byval pivotPoint as dFloat ptr, byval pinDir0 as dFloat ptr, byval pinDir1 as dFloat ptr, byval childBody as NewtonBody ptr, byval parentBody as NewtonBody ptr) as NewtonJoint ptr
declare sub NewtonUniversalSetUserCallback stdcall alias "NewtonUniversalSetUserCallback" (byval universal as NewtonJoint ptr, byval callback as NewtonUniversalCallBack)
declare function NewtonUniversalGetJointAngle0 stdcall alias "NewtonUniversalGetJointAngle0" (byval universal as NewtonJoint ptr) as dFloat
declare function NewtonUniversalGetJointAngle1 stdcall alias "NewtonUniversalGetJointAngle1" (byval universal as NewtonJoint ptr) as dFloat
declare function NewtonUniversalGetJointOmega0 stdcall alias "NewtonUniversalGetJointOmega0" (byval universal as NewtonJoint ptr) as dFloat
declare function NewtonUniversalGetJointOmega1 stdcall alias "NewtonUniversalGetJointOmega1" (byval universal as NewtonJoint ptr) as dFloat
declare sub NewtonUniversalGetJointForce stdcall alias "NewtonUniversalGetJointForce" (byval universal as NewtonJoint ptr, byval force as dFloat ptr)
declare function NewtonUniversalCalculateStopAlpha0 stdcall alias "NewtonUniversalCalculateStopAlpha0" (byval universal as NewtonJoint ptr, byval desc as NewtonHingeSliderUpdateDesc ptr, byval angle as dFloat) as dFloat
declare function NewtonUniversalCalculateStopAlpha1 stdcall alias "NewtonUniversalCalculateStopAlpha1" (byval universal as NewtonJoint ptr, byval desc as NewtonHingeSliderUpdateDesc ptr, byval angle as dFloat) as dFloat
declare function NewtonConstraintCreateUpVector stdcall alias "NewtonConstraintCreateUpVector" (byval newtonWorld as NewtonWorld ptr, byval pinDir as dFloat ptr, byval body as NewtonBody ptr) as NewtonJoint ptr
declare sub NewtonUpVectorGetPin stdcall alias "NewtonUpVectorGetPin" (byval upVector as NewtonJoint ptr, byval pin as dFloat ptr)
declare sub NewtonUpVectorSetPin stdcall alias "NewtonUpVectorSetPin" (byval upVector as NewtonJoint ptr, byval pin as dFloat ptr)
declare function NewtonConstraintCreateUserJoint stdcall alias "NewtonConstraintCreateUserJoint" (byval newtonWorld as NewtonWorld ptr, byval maxDOF as integer, byval callback as NewtonUserBilateralCallBack, byval childBody as NewtonBody ptr, byval parentBody as NewtonBody ptr) as NewtonJoint ptr
declare sub NewtonUserJointAddLinearRow stdcall alias "NewtonUserJointAddLinearRow" (byval joint as NewtonJoint ptr, byval pivot0 as dFloat ptr, byval pivot1 as dFloat ptr, byval dir as dFloat ptr)
declare sub NewtonUserJointAddAngularRow stdcall alias "NewtonUserJointAddAngularRow" (byval joint as NewtonJoint ptr, byval relativeAngle as dFloat, byval dir as dFloat ptr)
declare sub NewtonUserJointSetRowMinimunFriction stdcall alias "NewtonUserJointSetRowMinimunFriction" (byval joint as NewtonJoint ptr, byval friction as dFloat)
declare sub NewtonUserJointSetRowMaximunFriction stdcall alias "NewtonUserJointSetRowMaximunFriction" (byval joint as NewtonJoint ptr, byval friction as dFloat)
declare sub NewtonUserJointSetRowAcceleration stdcall alias "NewtonUserJointSetRowAcceleration" (byval joint as NewtonJoint ptr, byval acceleration as dFloat)
declare sub NewtonUserJointSetRowStiffness stdcall alias "NewtonUserJointSetRowStiffness" (byval joint as NewtonJoint ptr, byval stiffness as dFloat)
declare function NewtonUserJointGetRowForce stdcall alias "NewtonUserJointGetRowForce" (byval joint as NewtonJoint ptr, byval row as integer) as dFloat
declare function NewtonCreateRagDoll stdcall alias "NewtonCreateRagDoll" (byval newtonWorld as NewtonWorld ptr) as NewtonRagDoll ptr
declare sub NewtonDestroyRagDoll stdcall alias "NewtonDestroyRagDoll" (byval newtonWorld as NewtonWorld ptr, byval ragDoll as NewtonRagDoll ptr)
declare sub NewtonRagDollBegin stdcall alias "NewtonRagDollBegin" (byval ragDoll as NewtonRagDoll ptr)
declare sub NewtonRagDollEnd stdcall alias "NewtonRagDollEnd" (byval ragDoll as NewtonRagDoll ptr)
declare function NewtonRagDollFindBone stdcall alias "NewtonRagDollFindBone" (byval ragDoll as NewtonRagDoll ptr, byval id as integer) as NewtonRagDollBone ptr
declare function NewtonRagDollGetRootBone stdcall alias "NewtonRagDollGetRootBone" (byval ragDoll as NewtonRagDoll ptr) as NewtonRagDollBone ptr
declare sub NewtonRagDollSetForceAndTorqueCallback stdcall alias "NewtonRagDollSetForceAndTorqueCallback" (byval ragDoll as NewtonRagDoll ptr, byval callback as NewtonApplyForceAndTorque)
declare sub NewtonRagDollSetTransformCallback stdcall alias "NewtonRagDollSetTransformCallback" (byval ragDoll as NewtonRagDoll ptr, byval callback as NewtonSetRagDollTransform)
declare function NewtonRagDollAddBone stdcall alias "NewtonRagDollAddBone" (byval ragDoll as NewtonRagDoll ptr, byval parent as NewtonRagDollBone ptr, byval userData as any ptr, byval mass as dFloat, byval matrix as dFloat ptr, byval boneCollision as NewtonCollision ptr, byval size as dFloat ptr) as NewtonRagDollBone ptr
declare function NewtonRagDollBoneGetUserData stdcall alias "NewtonRagDollBoneGetUserData" (byval bone as NewtonRagDollBone ptr) as any ptr
declare function NewtonRagDollBoneGetBody stdcall alias "NewtonRagDollBoneGetBody" (byval bone as NewtonRagDollBone ptr) as NewtonBody ptr
declare sub NewtonRagDollBoneSetID stdcall alias "NewtonRagDollBoneSetID" (byval bone as NewtonRagDollBone ptr, byval id as integer)
declare sub NewtonRagDollBoneSetLimits stdcall alias "NewtonRagDollBoneSetLimits" (byval bone as NewtonRagDollBone ptr, byval coneDir as dFloat ptr, byval minConeAngle as dFloat, byval maxConeAngle as dFloat, byval maxTwistAngle as dFloat, byval bilateralConeDir as dFloat ptr, byval negativeBilateralConeAngle as dFloat, byval positiveBilateralConeAngle as dFloat)
declare sub NewtonRagDollBoneGetLocalMatrix stdcall alias "NewtonRagDollBoneGetLocalMatrix" (byval bone as NewtonRagDollBone ptr, byval matrix as dFloat ptr)
declare sub NewtonRagDollBoneGetGlobalMatrix stdcall alias "NewtonRagDollBoneGetGlobalMatrix" (byval bone as NewtonRagDollBone ptr, byval matrix as dFloat ptr)
declare function NewtonConstraintCreateVehicle stdcall alias "NewtonConstraintCreateVehicle" (byval newtonWorld as NewtonWorld ptr, byval upDir as dFloat ptr, byval body as NewtonBody ptr) as NewtonJoint ptr
declare sub NewtonVehicleReset stdcall alias "NewtonVehicleReset" (byval vehicle as NewtonJoint ptr)
declare sub NewtonVehicleSetTireCallback stdcall alias "NewtonVehicleSetTireCallback" (byval vehicle as NewtonJoint ptr, byval update as NewtonVehicleTireUpdate)
declare function NewtonVehicleAddTire stdcall alias "NewtonVehicleAddTire" (byval vehicle as NewtonJoint ptr, byval localMatrix as dFloat ptr, byval pin as dFloat ptr, byval mass as dFloat, byval width as dFloat, byval radius as dFloat, byval suspesionShock as dFloat, byval suspesionSpring as dFloat, byval suspesionLength as dFloat, byval userData as any ptr, byval collisionID as integer) as integer
declare sub NewtonVehicleRemoveTire stdcall alias "NewtonVehicleRemoveTire" (byval vehicle as NewtonJoint ptr, byval tireIndex as integer)
declare sub NewtonVehicleBalanceTires stdcall alias "NewtonVehicleBalanceTires" (byval vehicle as NewtonJoint ptr, byval gravityMag as dFloat)
declare function NewtonVehicleGetFirstTireID stdcall alias "NewtonVehicleGetFirstTireID" (byval vehicle as NewtonJoint ptr) as integer
declare function NewtonVehicleGetNextTireID stdcall alias "NewtonVehicleGetNextTireID" (byval vehicle as NewtonJoint ptr, byval tireId as integer) as integer
declare function NewtonVehicleTireIsAirBorne stdcall alias "NewtonVehicleTireIsAirBorne" (byval vehicle as NewtonJoint ptr, byval tireId as integer) as integer
declare function NewtonVehicleTireLostSideGrip stdcall alias "NewtonVehicleTireLostSideGrip" (byval vehicle as NewtonJoint ptr, byval tireId as integer) as integer
declare function NewtonVehicleTireLostTraction stdcall alias "NewtonVehicleTireLostTraction" (byval vehicle as NewtonJoint ptr, byval tireId as integer) as integer
declare function NewtonVehicleGetTireUserData stdcall alias "NewtonVehicleGetTireUserData" (byval vehicle as NewtonJoint ptr, byval tireId as integer) as any ptr
declare function NewtonVehicleGetTireOmega stdcall alias "NewtonVehicleGetTireOmega" (byval vehicle as NewtonJoint ptr, byval tireId as integer) as dFloat
declare function NewtonVehicleGetTireNormalLoad stdcall alias "NewtonVehicleGetTireNormalLoad" (byval vehicle as NewtonJoint ptr, byval tireId as integer) as dFloat
declare function NewtonVehicleGetTireSteerAngle stdcall alias "NewtonVehicleGetTireSteerAngle" (byval vehicle as NewtonJoint ptr, byval tireId as integer) as dFloat
declare function NewtonVehicleGetTireLateralSpeed stdcall alias "NewtonVehicleGetTireLateralSpeed" (byval vehicle as NewtonJoint ptr, byval tireId as integer) as dFloat
declare function NewtonVehicleGetTireLongitudinalSpeed stdcall alias "NewtonVehicleGetTireLongitudinalSpeed" (byval vehicle as NewtonJoint ptr, byval tireId as integer) as dFloat
declare sub NewtonVehicleGetTireMatrix stdcall alias "NewtonVehicleGetTireMatrix" (byval vehicle as NewtonJoint ptr, byval tireId as integer, byval matrix as dFloat ptr)
declare sub NewtonVehicleSetTireTorque stdcall alias "NewtonVehicleSetTireTorque" (byval vehicle as NewtonJoint ptr, byval tireId as integer, byval torque as dFloat)
declare sub NewtonVehicleSetTireSteerAngle stdcall alias "NewtonVehicleSetTireSteerAngle" (byval vehicle as NewtonJoint ptr, byval tireId as integer, byval angle as dFloat)
declare sub NewtonVehicleSetTireMaxSideSleepSpeed stdcall alias "NewtonVehicleSetTireMaxSideSleepSpeed" (byval vehicle as NewtonJoint ptr, byval tireId as integer, byval speed as dFloat)
declare sub NewtonVehicleSetTireSideSleepCoeficient stdcall alias "NewtonVehicleSetTireSideSleepCoeficient" (byval vehicle as NewtonJoint ptr, byval tireId as integer, byval coeficient as dFloat)
declare sub NewtonVehicleSetTireMaxLongitudinalSlideSpeed stdcall alias "NewtonVehicleSetTireMaxLongitudinalSlideSpeed" (byval vehicle as NewtonJoint ptr, byval tireId as integer, byval speed as dFloat)
declare sub NewtonVehicleSetTireLongitudinalSlideCoeficient stdcall alias "NewtonVehicleSetTireLongitudinalSlideCoeficient" (byval vehicle as NewtonJoint ptr, byval tireId as integer, byval coeficient as dFloat)
declare function NewtonVehicleTireCalculateMaxBrakeAcceleration stdcall alias "NewtonVehicleTireCalculateMaxBrakeAcceleration" (byval vehicle as NewtonJoint ptr, byval tireId as integer) as dFloat
declare sub NewtonVehicleTireSetBrakeAcceleration stdcall alias "NewtonVehicleTireSetBrakeAcceleration" (byval vehicle as NewtonJoint ptr, byval tireId as integer, byval accelaration as dFloat, byval torqueLimit as dFloat)

#endif
