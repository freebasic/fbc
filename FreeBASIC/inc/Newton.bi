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
type NewtonAllocMemory as function cdecl(byval as integer) as any ptr
type NewtonFreeMemory as sub cdecl(byval as any ptr, byval as integer)
type NewtonSerialize as sub cdecl(byval as any ptr, byval as any ptr, byval as integer)
type NewtonDeserialize as sub cdecl(byval as any ptr, byval as any ptr, byval as integer)
type NewtonUserMeshCollisionCollideCallback as sub cdecl(byval as NewtonUserMeshCollisionCollideDesc ptr)
type NewtonUserMeshCollisionRayHitCallback as function cdecl(byval as NewtonUserMeshCollisionRayHitDesc ptr) as dFloat
type NewtonUserMeshCollisionDestroyCallback as sub cdecl(byval as any ptr)
type NewtonTreeCollisionCallback as sub cdecl(byval as NewtonBody ptr, byval as NewtonBody ptr, byval as dFloat ptr, byval as integer, byval as integer, byval as integer ptr)
type NewtonBodyDestructor as sub cdecl(byval as NewtonBody ptr)
type NewtonApplyForceAndTorque as sub cdecl(byval as NewtonBody ptr)
type NewtonBodyActivationState as sub cdecl(byval as NewtonBody ptr, byval as uinteger)
type NewtonSetTransform as sub cdecl(byval as NewtonBody ptr, byval as dFloat ptr)
type NewtonSetRagDollTransform as sub cdecl(byval as NewtonRagDollBone ptr)
type NewtonGetBuoyancyPlane as sub cdecl(byval as any ptr, byval as dFloat ptr, byval as dFloat ptr)
type NewtonVehicleTireUpdate as sub cdecl(byval as NewtonJoint ptr)
type NewtonWorldRayFilterCallback as function cdecl(byval as NewtonBody ptr, byval as dFloat ptr, byval as integer, byval as any ptr, byval as dFloat) as dFloat
type NewtonBodyLeaveWorld as sub cdecl(byval as NewtonBody ptr)
type NewtonContactBegin as function cdecl(byval as NewtonMaterial ptr, byval as NewtonBody ptr, byval as NewtonBody ptr) as integer
type NewtonContactProcess as function cdecl(byval as NewtonMaterial ptr, byval as NewtonContact ptr) as integer
type NewtonContactEnd as sub cdecl(byval as NewtonMaterial ptr)
type NewtonBodyIterator as sub cdecl(byval as NewtonBody ptr)
type NewtonCollisionIterator as sub cdecl(byval as NewtonBody ptr, byval as integer, byval as dFloat ptr, byval as integer)
type NewtonBallCallBack as sub cdecl(byval as NewtonJoint ptr)
type NewtonHingeCallBack as function cdecl(byval as NewtonJoint ptr, byval as NewtonHingeSliderUpdateDesc ptr) as uinteger
type NewtonSliderCallBack as function cdecl(byval as NewtonJoint ptr, byval as NewtonHingeSliderUpdateDesc ptr) as uinteger
type NewtonUniversalCallBack as function cdecl(byval as NewtonJoint ptr, byval as NewtonHingeSliderUpdateDesc ptr) as uinteger
type NewtonCorkscrewCallBack as function cdecl(byval as NewtonJoint ptr, byval as NewtonHingeSliderUpdateDesc ptr) as uinteger
type NewtonUserBilateralCallBack as sub cdecl(byval as NewtonJoint ptr)
type NewtonConstraintDestructor as sub cdecl(byval as NewtonJoint ptr)

declare function NewtonCreate cdecl alias "NewtonCreate" (byval malloc as NewtonAllocMemory, byval mfree as NewtonFreeMemory) as NewtonWorld ptr
declare sub NewtonDestroy cdecl alias "NewtonDestroy" (byval newtonWorld as NewtonWorld ptr)
declare sub NewtonDestroyAllBodies cdecl alias "NewtonDestroyAllBodies" (byval newtonWorld as NewtonWorld ptr)
declare sub NewtonUpdate cdecl alias "NewtonUpdate" (byval newtonWorld as NewtonWorld ptr, byval timestep as dFloat)
declare sub NewtonSetSolverModel cdecl alias "NewtonSetSolverModel" (byval newtonWorld as NewtonWorld ptr, byval model as integer)
declare sub NewtonSetFrictionModel cdecl alias "NewtonSetFrictionModel" (byval newtonWorld as NewtonWorld ptr, byval model as integer)
declare function NewtonGetTimeStep cdecl alias "NewtonGetTimeStep" (byval newtonWorld as NewtonWorld ptr) as dFloat
declare sub NewtonSetMinimumFrameRate cdecl alias "NewtonSetMinimumFrameRate" (byval newtonWorld as NewtonWorld ptr, byval frameRate as dFloat)
declare sub NewtonSetBodyLeaveWorldEvent cdecl alias "NewtonSetBodyLeaveWorldEvent" (byval newtonWorld as NewtonWorld ptr, byval callback as NewtonBodyLeaveWorld)
declare sub NewtonSetWorldSize cdecl alias "NewtonSetWorldSize" (byval newtonWorld as NewtonWorld ptr, byval minPoint as dFloat ptr, byval maxPoint as dFloat ptr)
declare sub NewtonWorldFreezeBody cdecl alias "NewtonWorldFreezeBody" (byval newtonWorld as NewtonWorld ptr, byval body as NewtonBody ptr)
declare sub NewtonWorldUnfreezeBody cdecl alias "NewtonWorldUnfreezeBody" (byval newtonWorld as NewtonWorld ptr, byval body as NewtonBody ptr)
declare sub NewtonWorldForEachBodyDo cdecl alias "NewtonWorldForEachBodyDo" (byval newtonWorld as NewtonWorld ptr, byval callback as NewtonBodyIterator)
declare sub NewtonWorldSetUserData cdecl alias "NewtonWorldSetUserData" (byval newtonWorld as NewtonWorld ptr, byval userData as any ptr)
declare function NewtonWorldGetUserData cdecl alias "NewtonWorldGetUserData" (byval newtonWorld as NewtonWorld ptr) as any ptr
declare function NewtonWorldGetVersion cdecl alias "NewtonWorldGetVersion" (byval newtonWorld as NewtonWorld ptr) as integer
declare sub NewtonWorldRayCast cdecl alias "NewtonWorldRayCast" (byval newtonWorld as NewtonWorld ptr, byval p0 as dFloat ptr, byval p1 as dFloat ptr, byval filter as NewtonWorldRayFilterCallback, byval userData as any ptr)
declare function NewtonWorldCollide cdecl alias "NewtonWorldCollide" (byval newtonWorld as NewtonWorld ptr, byval maxSize as integer, byval collsionA as NewtonCollision ptr, byval matrixA as dFloat ptr, byval collsionB as NewtonCollision ptr, byval matrixB as dFloat ptr, byval contacts as dFloat ptr, byval normals as dFloat ptr, byval penetration as dFloat ptr) as integer
declare function NewtonMaterialGetDefaultGroupID cdecl alias "NewtonMaterialGetDefaultGroupID" (byval newtonWorld as NewtonWorld ptr) as integer
declare function NewtonMaterialCreateGroupID cdecl alias "NewtonMaterialCreateGroupID" (byval newtonWorld as NewtonWorld ptr) as integer
declare sub NewtonMaterialDestroyAllGroupID cdecl alias "NewtonMaterialDestroyAllGroupID" (byval newtonWorld as NewtonWorld ptr)
declare sub NewtonMaterialSetDefaultSoftness cdecl alias "NewtonMaterialSetDefaultSoftness" (byval newtonWorld as NewtonWorld ptr, byval id0 as integer, byval id1 as integer, byval value as dFloat)
declare sub NewtonMaterialSetDefaultElasticity cdecl alias "NewtonMaterialSetDefaultElasticity" (byval newtonWorld as NewtonWorld ptr, byval id0 as integer, byval id1 as integer, byval elasticCoef as dFloat)
declare sub NewtonMaterialSetDefaultCollidable cdecl alias "NewtonMaterialSetDefaultCollidable" (byval newtonWorld as NewtonWorld ptr, byval id0 as integer, byval id1 as integer, byval state as integer)
declare sub NewtonMaterialSetDefaultFriction cdecl alias "NewtonMaterialSetDefaultFriction" (byval newtonWorld as NewtonWorld ptr, byval id0 as integer, byval id1 as integer, byval staticFriction as dFloat, byval kineticFriction as dFloat)
declare sub NewtonMaterialSetCollisionCallback cdecl alias "NewtonMaterialSetCollisionCallback" (byval newtonWorld as NewtonWorld ptr, byval id0 as integer, byval id1 as integer, byval userData as any ptr, byval begin as NewtonContactBegin, byval process as NewtonContactProcess, byval end as NewtonContactEnd)
declare function NewtonMaterialGetUserData cdecl alias "NewtonMaterialGetUserData" (byval newtonWorld as NewtonWorld ptr, byval id0 as integer, byval id1 as integer) as any ptr
declare sub NewtonMaterialDisableContact cdecl alias "NewtonMaterialDisableContact" (byval material as NewtonMaterial ptr)
declare function NewtonMaterialGetCurrentTimestep cdecl alias "NewtonMaterialGetCurrentTimestep" (byval material as NewtonMaterial ptr) as dFloat
declare function NewtonMaterialGetMaterialPairUserData cdecl alias "NewtonMaterialGetMaterialPairUserData" (byval material as NewtonMaterial ptr) as any ptr
declare function NewtonMaterialGetContactFaceAttribute cdecl alias "NewtonMaterialGetContactFaceAttribute" (byval material as NewtonMaterial ptr) as uinteger
declare function NewtonMaterialGetBodyCollisionID cdecl alias "NewtonMaterialGetBodyCollisionID" (byval material as NewtonMaterial ptr, byval body as NewtonBody ptr) as uinteger
declare function NewtonMaterialGetContactNormalSpeed cdecl alias "NewtonMaterialGetContactNormalSpeed" (byval material as NewtonMaterial ptr, byval contactlHandle as NewtonContact ptr) as dFloat
declare sub NewtonMaterialGetContactForce cdecl alias "NewtonMaterialGetContactForce" (byval material as NewtonMaterial ptr, byval force as dFloat ptr)
declare sub NewtonMaterialGetContactPositionAndNormal cdecl alias "NewtonMaterialGetContactPositionAndNormal" (byval material as NewtonMaterial ptr, byval posit as dFloat ptr, byval normal as dFloat ptr)
declare sub NewtonMaterialGetContactTangentDirections cdecl alias "NewtonMaterialGetContactTangentDirections" (byval material as NewtonMaterial ptr, byval dir0 as dFloat ptr, byval dir as dFloat ptr)
declare function NewtonMaterialGetContactTangentSpeed cdecl alias "NewtonMaterialGetContactTangentSpeed" (byval material as NewtonMaterial ptr, byval contactlHandle as NewtonContact ptr, byval index as integer) as dFloat
declare sub NewtonMaterialSetContactSoftness cdecl alias "NewtonMaterialSetContactSoftness" (byval material as NewtonMaterial ptr, byval softness as dFloat)
declare sub NewtonMaterialSetContactElasticity cdecl alias "NewtonMaterialSetContactElasticity" (byval material as NewtonMaterial ptr, byval restitution as dFloat)
declare sub NewtonMaterialSetContactFrictionState cdecl alias "NewtonMaterialSetContactFrictionState" (byval material as NewtonMaterial ptr, byval state as integer, byval index as integer)
declare sub NewtonMaterialSetContactStaticFrictionCoef cdecl alias "NewtonMaterialSetContactStaticFrictionCoef" (byval material as NewtonMaterial ptr, byval coef as dFloat, byval index as integer)
declare sub NewtonMaterialSetContactKineticFrictionCoef cdecl alias "NewtonMaterialSetContactKineticFrictionCoef" (byval material as NewtonMaterial ptr, byval coef as dFloat, byval index as integer)
declare sub NewtonMaterialSetContactTangentAcceleration cdecl alias "NewtonMaterialSetContactTangentAcceleration" (byval material as NewtonMaterial ptr, byval accel as dFloat, byval index as integer)
declare sub NewtonMaterialContactRotateTangentDirections cdecl alias "NewtonMaterialContactRotateTangentDirections" (byval material as NewtonMaterial ptr, byval directionVector as dFloat ptr)
declare function NewtonCreateNull cdecl alias "NewtonCreateNull" (byval newtonWorld as NewtonWorld ptr) as NewtonCollision ptr
declare function NewtonCreateSphere cdecl alias "NewtonCreateSphere" (byval newtonWorld as NewtonWorld ptr, byval radiusX as dFloat, byval radiusY as dFloat, byval radiusZ as dFloat, byval offsetMatrix as dFloat ptr) as NewtonCollision ptr
declare function NewtonCreateBox cdecl alias "NewtonCreateBox" (byval newtonWorld as NewtonWorld ptr, byval dx as dFloat, byval dy as dFloat, byval dz as dFloat, byval offsetMatrix as dFloat ptr) as NewtonCollision ptr
declare function NewtonCreateCone cdecl alias "NewtonCreateCone" (byval newtonWorld as NewtonWorld ptr, byval radius as dFloat, byval height as dFloat, byval offsetMatrix as dFloat ptr) as NewtonCollision ptr
declare function NewtonCreateCapsule cdecl alias "NewtonCreateCapsule" (byval newtonWorld as NewtonWorld ptr, byval radius as dFloat, byval height as dFloat, byval offsetMatrix as dFloat ptr) as NewtonCollision ptr
declare function NewtonCreateCylinder cdecl alias "NewtonCreateCylinder" (byval newtonWorld as NewtonWorld ptr, byval radius as dFloat, byval height as dFloat, byval offsetMatrix as dFloat ptr) as NewtonCollision ptr
declare function NewtonCreateChamferCylinder cdecl alias "NewtonCreateChamferCylinder" (byval newtonWorld as NewtonWorld ptr, byval radius as dFloat, byval height as dFloat, byval offsetMatrix as dFloat ptr) as NewtonCollision ptr
declare function NewtonCreateConvexHull cdecl alias "NewtonCreateConvexHull" (byval newtonWorld as NewtonWorld ptr, byval count as integer, byval vertexCloud as dFloat ptr, byval strideInBytes as integer, byval offsetMatrix as dFloat ptr) as NewtonCollision ptr
declare function NewtonCreateConvexHullModifier cdecl alias "NewtonCreateConvexHullModifier" (byval newtonWorld as NewtonWorld ptr, byval convexHullCollision as NewtonCollision ptr) as NewtonCollision ptr
declare sub NewtonConvexHullModifierGetMatrix cdecl alias "NewtonConvexHullModifierGetMatrix" (byval convexHullCollision as NewtonCollision ptr, byval matrix as dFloat ptr)
declare sub NewtonConvexHullModifierSetMatrix cdecl alias "NewtonConvexHullModifierSetMatrix" (byval convexHullCollision as NewtonCollision ptr, byval matrix as dFloat ptr)
declare sub NewtonConvexCollisionSetUserID cdecl alias "NewtonConvexCollisionSetUserID" (byval convexCollision as NewtonCollision ptr, byval id as uinteger)
declare function NewtonConvexCollisionGetUserID cdecl alias "NewtonConvexCollisionGetUserID" (byval convexCollision as NewtonCollision ptr) as uinteger
declare function NewtonCreateCompoundCollision cdecl alias "NewtonCreateCompoundCollision" (byval newtonWorld as NewtonWorld ptr, byval count as integer, byval collisionPrimitiveArray as NewtonCollision ptr ptr) as NewtonCollision ptr
declare function NewtonCreateUserMeshCollision cdecl alias "NewtonCreateUserMeshCollision" (byval newtonWorld as NewtonWorld ptr, byval minBox as dFloat ptr, byval maxBox as dFloat ptr, byval userData as any ptr, byval collideCallback as NewtonUserMeshCollisionCollideCallback, byval rayHitCallback as NewtonUserMeshCollisionRayHitCallback, byval destroyCallback as NewtonUserMeshCollisionDestroyCallback) as NewtonCollision ptr
declare function NewtonCreateTreeCollision cdecl alias "NewtonCreateTreeCollision" (byval newtonWorld as NewtonWorld ptr, byval userCallback as NewtonTreeCollisionCallback) as NewtonCollision ptr
declare sub NewtonTreeCollisionBeginBuild cdecl alias "NewtonTreeCollisionBeginBuild" (byval treeCollision as NewtonCollision ptr)
declare sub NewtonTreeCollisionAddFace cdecl alias "NewtonTreeCollisionAddFace" (byval treeCollision as NewtonCollision ptr, byval vertexCount as integer, byval vertexPtr as dFloat ptr, byval strideInBytes as integer, byval faceAttribute as integer)
declare sub NewtonTreeCollisionEndBuild cdecl alias "NewtonTreeCollisionEndBuild" (byval treeCollision as NewtonCollision ptr, byval optimize as integer)
declare sub NewtonTreeCollisionSerialize cdecl alias "NewtonTreeCollisionSerialize" (byval treeCollision as NewtonCollision ptr, byval serializeFunction as NewtonSerialize, byval serializeHandle as any ptr)
declare function NewtonCreateTreeCollisionFromSerialization cdecl alias "NewtonCreateTreeCollisionFromSerialization" (byval newtonWorld as NewtonWorld ptr, byval userCallback as NewtonTreeCollisionCallback, byval deserializeFunction as NewtonDeserialize, byval serializeHandle as any ptr) as NewtonCollision ptr
declare function NewtonTreeCollisionGetFaceAtribute cdecl alias "NewtonTreeCollisionGetFaceAtribute" (byval treeCollision as NewtonCollision ptr, byval faceIndexArray as integer ptr) as integer
declare sub NewtonTreeCollisionSetFaceAtribute cdecl alias "NewtonTreeCollisionSetFaceAtribute" (byval treeCollision as NewtonCollision ptr, byval faceIndexArray as integer ptr, byval attribute as integer)
declare sub NewtonReleaseCollision cdecl alias "NewtonReleaseCollision" (byval newtonWorld as NewtonWorld ptr, byval collision as NewtonCollision ptr)
declare sub NewtonCollisionCalculateAABB cdecl alias "NewtonCollisionCalculateAABB" (byval collision as NewtonCollision ptr, byval matrix as dFloat ptr, byval p0 as dFloat ptr, byval p1 as dFloat ptr)
declare function NewtonCollisionRayCast cdecl alias "NewtonCollisionRayCast" (byval collision as NewtonCollision ptr, byval p0 as dFloat ptr, byval p1 as dFloat ptr, byval normals as dFloat ptr, byval attribute as integer ptr) as dFloat
declare sub NewtonGetEulerAngle cdecl alias "NewtonGetEulerAngle" (byval matrix as dFloat ptr, byval eulersAngles as dFloat ptr)
declare sub NewtonSetEulerAngle cdecl alias "NewtonSetEulerAngle" (byval eulersAngles as dFloat ptr, byval matrix as dFloat ptr)
declare function NewtonCreateBody cdecl alias "NewtonCreateBody" (byval newtonWorld as NewtonWorld ptr, byval collision as NewtonCollision ptr) as NewtonBody ptr
declare sub NewtonDestroyBody cdecl alias "NewtonDestroyBody" (byval newtonWorld as NewtonWorld ptr, byval body as NewtonBody ptr)
declare sub NewtonBodyAddForce cdecl alias "NewtonBodyAddForce" (byval body as NewtonBody ptr, byval force as dFloat ptr)
declare sub NewtonBodyAddTorque cdecl alias "NewtonBodyAddTorque" (byval body as NewtonBody ptr, byval torque as dFloat ptr)
declare sub NewtonBodySetMatrix cdecl alias "NewtonBodySetMatrix" (byval body as NewtonBody ptr, byval matrix as dFloat ptr)
declare sub NewtonBodySetMatrixRecursive cdecl alias "NewtonBodySetMatrixRecursive" (byval body as NewtonBody ptr, byval matrix as dFloat ptr)
declare sub NewtonBodySetMassMatrix cdecl alias "NewtonBodySetMassMatrix" (byval body as NewtonBody ptr, byval mass as dFloat, byval Ixx as dFloat, byval Iyy as dFloat, byval Izz as dFloat)
declare sub NewtonBodySetMaterialGroupID cdecl alias "NewtonBodySetMaterialGroupID" (byval body as NewtonBody ptr, byval id as integer)
declare sub NewtonBodySetContinuousCollisionMode cdecl alias "NewtonBodySetContinuousCollisionMode" (byval body as NewtonBody ptr, byval state as uinteger)
declare sub NewtonBodySetJointRecursiveCollision cdecl alias "NewtonBodySetJointRecursiveCollision" (byval body as NewtonBody ptr, byval state as uinteger)
declare sub NewtonBodySetOmega cdecl alias "NewtonBodySetOmega" (byval body as NewtonBody ptr, byval omega as dFloat ptr)
declare sub NewtonBodySetVelocity cdecl alias "NewtonBodySetVelocity" (byval body as NewtonBody ptr, byval velocity as dFloat ptr)
declare sub NewtonBodySetForce cdecl alias "NewtonBodySetForce" (byval body as NewtonBody ptr, byval force as dFloat ptr)
declare sub NewtonBodySetTorque cdecl alias "NewtonBodySetTorque" (byval body as NewtonBody ptr, byval torque as dFloat ptr)
declare sub NewtonBodySetLinearDamping cdecl alias "NewtonBodySetLinearDamping" (byval body as NewtonBody ptr, byval linearDamp as dFloat)
declare sub NewtonBodySetAngularDamping cdecl alias "NewtonBodySetAngularDamping" (byval body as NewtonBody ptr, byval angularDamp as dFloat ptr)
declare sub NewtonBodySetUserData cdecl alias "NewtonBodySetUserData" (byval body as NewtonBody ptr, byval userData as any ptr)
declare sub NewtonBodyCoriolisForcesMode cdecl alias "NewtonBodyCoriolisForcesMode" (byval body as NewtonBody ptr, byval mode as integer)
declare sub NewtonBodySetCollision cdecl alias "NewtonBodySetCollision" (byval body as NewtonBody ptr, byval collision as NewtonCollision ptr)
declare sub NewtonBodySetAutoFreeze cdecl alias "NewtonBodySetAutoFreeze" (byval body as NewtonBody ptr, byval state as integer)
declare sub NewtonBodySetFreezeTreshold cdecl alias "NewtonBodySetFreezeTreshold" (byval body as NewtonBody ptr, byval freezeSpeed2 as dFloat, byval freezeOmega2 as dFloat, byval framesCount as integer)
declare sub NewtonBodySetTransformCallback cdecl alias "NewtonBodySetTransformCallback" (byval body as NewtonBody ptr, byval callback as NewtonSetTransform)
declare sub NewtonBodySetDestructorCallback cdecl alias "NewtonBodySetDestructorCallback" (byval body as NewtonBody ptr, byval callback as NewtonBodyDestructor)
declare sub NewtonBodySetAutoactiveCallback cdecl alias "NewtonBodySetAutoactiveCallback" (byval body as NewtonBody ptr, byval callback as NewtonBodyActivationState)
declare sub NewtonBodySetForceAndTorqueCallback cdecl alias "NewtonBodySetForceAndTorqueCallback" (byval body as NewtonBody ptr, byval callback as NewtonApplyForceAndTorque)
declare function NewtonBodyGetWorld cdecl alias "NewtonBodyGetWorld" (byval body as NewtonBody ptr) as NewtonWorld ptr
declare function NewtonBodyGetUserData cdecl alias "NewtonBodyGetUserData" (byval body as NewtonBody ptr) as any ptr
declare function NewtonBodyGetCollision cdecl alias "NewtonBodyGetCollision" (byval body as NewtonBody ptr) as NewtonCollision ptr
declare function NewtonBodyGetMaterialGroupID cdecl alias "NewtonBodyGetMaterialGroupID" (byval body as NewtonBody ptr) as integer
declare function NewtonBodyGetContinuousCollisionMode cdecl alias "NewtonBodyGetContinuousCollisionMode" (byval body as NewtonBody ptr) as integer
declare function NewtonBodyGetJointRecursiveCollision cdecl alias "NewtonBodyGetJointRecursiveCollision" (byval body as NewtonBody ptr) as integer
declare sub NewtonBodyGetMatrix cdecl alias "NewtonBodyGetMatrix" (byval body as NewtonBody ptr, byval matrix as dFloat ptr)
declare sub NewtonBodyGetMassMatrix cdecl alias "NewtonBodyGetMassMatrix" (byval body as NewtonBody ptr, byval mass as dFloat ptr, byval Ixx as dFloat ptr, byval Iyy as dFloat ptr, byval Izz as dFloat ptr)
declare sub NewtonBodyGetInvMass cdecl alias "NewtonBodyGetInvMass" (byval body as NewtonBody ptr, byval invMass as dFloat ptr, byval invIxx as dFloat ptr, byval invIyy as dFloat ptr, byval invIzz as dFloat ptr)
declare sub NewtonBodyGetOmega cdecl alias "NewtonBodyGetOmega" (byval body as NewtonBody ptr, byval vector as dFloat ptr)
declare sub NewtonBodyGetVelocity cdecl alias "NewtonBodyGetVelocity" (byval body as NewtonBody ptr, byval vector as dFloat ptr)
declare sub NewtonBodyGetForce cdecl alias "NewtonBodyGetForce" (byval body as NewtonBody ptr, byval vector as dFloat ptr)
declare sub NewtonBodyGetTorque cdecl alias "NewtonBodyGetTorque" (byval body as NewtonBody ptr, byval vector as dFloat ptr)
declare function NewtonBodyGetSleepingState cdecl alias "NewtonBodyGetSleepingState" (byval body as NewtonBody ptr) as integer
declare function NewtonBodyGetAutoFreeze cdecl alias "NewtonBodyGetAutoFreeze" (byval body as NewtonBody ptr) as integer
declare function NewtonBodyGetLinearDamping cdecl alias "NewtonBodyGetLinearDamping" (byval body as NewtonBody ptr) as dFloat
declare sub NewtonBodyGetAngularDamping cdecl alias "NewtonBodyGetAngularDamping" (byval body as NewtonBody ptr, byval vector as dFloat ptr)
declare sub NewtonBodyGetAABB cdecl alias "NewtonBodyGetAABB" (byval body as NewtonBody ptr, byval p0 as dFloat ptr, byval p1 as dFloat ptr)
declare sub NewtonBodyGetFreezeTreshold cdecl alias "NewtonBodyGetFreezeTreshold" (byval body as NewtonBody ptr, byval freezeSpeed2 as dFloat ptr, byval freezeOmega2 as dFloat ptr)
declare function NewtonBodyGetTotalVolume cdecl alias "NewtonBodyGetTotalVolume" (byval body as NewtonBody ptr) as dFloat
declare sub NewtonBodyAddBuoyancyForce cdecl alias "NewtonBodyAddBuoyancyForce" (byval body as NewtonBody ptr, byval fluidDensity as dFloat, byval fluidLinearViscosity as dFloat, byval fluidAngularViscosity as dFloat, byval gravityVector as dFloat ptr, byval buoyancyPlane as NewtonGetBuoyancyPlane, byval context as any ptr)
declare sub NewtonBodyForEachPolygonDo cdecl alias "NewtonBodyForEachPolygonDo" (byval body as NewtonBody ptr, byval callback as NewtonCollisionIterator)
declare sub NewtonAddBodyImpulse cdecl alias "NewtonAddBodyImpulse" (byval body as NewtonBody ptr, byval pointDeltaVeloc as dFloat ptr, byval pointPosit as dFloat ptr)
declare function NewtonJointGetUserData cdecl alias "NewtonJointGetUserData" (byval joint as NewtonJoint ptr) as any ptr
declare sub NewtonJointSetUserData cdecl alias "NewtonJointSetUserData" (byval joint as NewtonJoint ptr, byval userData as any ptr)
declare function NewtonJointGetCollisionState cdecl alias "NewtonJointGetCollisionState" (byval joint as NewtonJoint ptr) as integer
declare sub NewtonJointSetCollisionState cdecl alias "NewtonJointSetCollisionState" (byval joint as NewtonJoint ptr, byval state as integer)
declare function NewtonJointGetStiffness cdecl alias "NewtonJointGetStiffness" (byval joint as NewtonJoint ptr) as dFloat
declare sub NewtonJointSetStiffness cdecl alias "NewtonJointSetStiffness" (byval joint as NewtonJoint ptr, byval state as dFloat)
declare sub NewtonDestroyJoint cdecl alias "NewtonDestroyJoint" (byval newtonWorld as NewtonWorld ptr, byval joint as NewtonJoint ptr)
declare sub NewtonJointSetDestructor cdecl alias "NewtonJointSetDestructor" (byval joint as NewtonJoint ptr, byval destructor as NewtonConstraintDestructor)
declare function NewtonConstraintCreateBall cdecl alias "NewtonConstraintCreateBall" (byval newtonWorld as NewtonWorld ptr, byval pivotPoint as dFloat ptr, byval childBody as NewtonBody ptr, byval parentBody as NewtonBody ptr) as NewtonJoint ptr
declare sub NewtonBallSetUserCallback cdecl alias "NewtonBallSetUserCallback" (byval ball as NewtonJoint ptr, byval callback as NewtonBallCallBack)
declare sub NewtonBallGetJointAngle cdecl alias "NewtonBallGetJointAngle" (byval ball as NewtonJoint ptr, byval angle as dFloat ptr)
declare sub NewtonBallGetJointOmega cdecl alias "NewtonBallGetJointOmega" (byval ball as NewtonJoint ptr, byval omega as dFloat ptr)
declare sub NewtonBallGetJointForce cdecl alias "NewtonBallGetJointForce" (byval ball as NewtonJoint ptr, byval force as dFloat ptr)
declare sub NewtonBallSetConeLimits cdecl alias "NewtonBallSetConeLimits" (byval ball as NewtonJoint ptr, byval pin as dFloat ptr, byval maxConeAngle as dFloat, byval maxTwistAngle as dFloat)
declare function NewtonConstraintCreateHinge cdecl alias "NewtonConstraintCreateHinge" (byval newtonWorld as NewtonWorld ptr, byval pivotPoint as dFloat ptr, byval pinDir as dFloat ptr, byval childBody as NewtonBody ptr, byval parentBody as NewtonBody ptr) as NewtonJoint ptr
declare sub NewtonHingeSetUserCallback cdecl alias "NewtonHingeSetUserCallback" (byval hinge as NewtonJoint ptr, byval callback as NewtonHingeCallBack)
declare function NewtonHingeGetJointAngle cdecl alias "NewtonHingeGetJointAngle" (byval hinge as NewtonJoint ptr) as dFloat
declare function NewtonHingeGetJointOmega cdecl alias "NewtonHingeGetJointOmega" (byval hinge as NewtonJoint ptr) as dFloat
declare sub NewtonHingeGetJointForce cdecl alias "NewtonHingeGetJointForce" (byval hinge as NewtonJoint ptr, byval force as dFloat ptr)
declare function NewtonHingeCalculateStopAlpha cdecl alias "NewtonHingeCalculateStopAlpha" (byval hinge as NewtonJoint ptr, byval desc as NewtonHingeSliderUpdateDesc ptr, byval angle as dFloat) as dFloat
declare function NewtonConstraintCreateSlider cdecl alias "NewtonConstraintCreateSlider" (byval newtonWorld as NewtonWorld ptr, byval pivotPoint as dFloat ptr, byval pinDir as dFloat ptr, byval childBody as NewtonBody ptr, byval parentBody as NewtonBody ptr) as NewtonJoint ptr
declare sub NewtonSliderSetUserCallback cdecl alias "NewtonSliderSetUserCallback" (byval slider as NewtonJoint ptr, byval callback as NewtonSliderCallBack)
declare function NewtonSliderGetJointPosit cdecl alias "NewtonSliderGetJointPosit" (byval slider as NewtonJoint ptr) as dFloat
declare function NewtonSliderGetJointVeloc cdecl alias "NewtonSliderGetJointVeloc" (byval slider as NewtonJoint ptr) as dFloat
declare sub NewtonSliderGetJointForce cdecl alias "NewtonSliderGetJointForce" (byval slider as NewtonJoint ptr, byval force as dFloat ptr)
declare function NewtonSliderCalculateStopAccel cdecl alias "NewtonSliderCalculateStopAccel" (byval slider as NewtonJoint ptr, byval desc as NewtonHingeSliderUpdateDesc ptr, byval position as dFloat) as dFloat
declare function NewtonConstraintCreateCorkscrew cdecl alias "NewtonConstraintCreateCorkscrew" (byval newtonWorld as NewtonWorld ptr, byval pivotPoint as dFloat ptr, byval pinDir as dFloat ptr, byval childBody as NewtonBody ptr, byval parentBody as NewtonBody ptr) as NewtonJoint ptr
declare sub NewtonCorkscrewSetUserCallback cdecl alias "NewtonCorkscrewSetUserCallback" (byval corkscrew as NewtonJoint ptr, byval callback as NewtonCorkscrewCallBack)
declare function NewtonCorkscrewGetJointPosit cdecl alias "NewtonCorkscrewGetJointPosit" (byval corkscrew as NewtonJoint ptr) as dFloat
declare function NewtonCorkscrewGetJointAngle cdecl alias "NewtonCorkscrewGetJointAngle" (byval corkscrew as NewtonJoint ptr) as dFloat
declare function NewtonCorkscrewGetJointVeloc cdecl alias "NewtonCorkscrewGetJointVeloc" (byval corkscrew as NewtonJoint ptr) as dFloat
declare function NewtonCorkscrewGetJointOmega cdecl alias "NewtonCorkscrewGetJointOmega" (byval corkscrew as NewtonJoint ptr) as dFloat
declare sub NewtonCorkscrewGetJointForce cdecl alias "NewtonCorkscrewGetJointForce" (byval corkscrew as NewtonJoint ptr, byval force as dFloat ptr)
declare function NewtonCorkscrewCalculateStopAlpha cdecl alias "NewtonCorkscrewCalculateStopAlpha" (byval corkscrew as NewtonJoint ptr, byval desc as NewtonHingeSliderUpdateDesc ptr, byval angle as dFloat) as dFloat
declare function NewtonCorkscrewCalculateStopAccel cdecl alias "NewtonCorkscrewCalculateStopAccel" (byval corkscrew as NewtonJoint ptr, byval desc as NewtonHingeSliderUpdateDesc ptr, byval position as dFloat) as dFloat
declare function NewtonConstraintCreateUniversal cdecl alias "NewtonConstraintCreateUniversal" (byval newtonWorld as NewtonWorld ptr, byval pivotPoint as dFloat ptr, byval pinDir0 as dFloat ptr, byval pinDir1 as dFloat ptr, byval childBody as NewtonBody ptr, byval parentBody as NewtonBody ptr) as NewtonJoint ptr
declare sub NewtonUniversalSetUserCallback cdecl alias "NewtonUniversalSetUserCallback" (byval universal as NewtonJoint ptr, byval callback as NewtonUniversalCallBack)
declare function NewtonUniversalGetJointAngle0 cdecl alias "NewtonUniversalGetJointAngle0" (byval universal as NewtonJoint ptr) as dFloat
declare function NewtonUniversalGetJointAngle1 cdecl alias "NewtonUniversalGetJointAngle1" (byval universal as NewtonJoint ptr) as dFloat
declare function NewtonUniversalGetJointOmega0 cdecl alias "NewtonUniversalGetJointOmega0" (byval universal as NewtonJoint ptr) as dFloat
declare function NewtonUniversalGetJointOmega1 cdecl alias "NewtonUniversalGetJointOmega1" (byval universal as NewtonJoint ptr) as dFloat
declare sub NewtonUniversalGetJointForce cdecl alias "NewtonUniversalGetJointForce" (byval universal as NewtonJoint ptr, byval force as dFloat ptr)
declare function NewtonUniversalCalculateStopAlpha0 cdecl alias "NewtonUniversalCalculateStopAlpha0" (byval universal as NewtonJoint ptr, byval desc as NewtonHingeSliderUpdateDesc ptr, byval angle as dFloat) as dFloat
declare function NewtonUniversalCalculateStopAlpha1 cdecl alias "NewtonUniversalCalculateStopAlpha1" (byval universal as NewtonJoint ptr, byval desc as NewtonHingeSliderUpdateDesc ptr, byval angle as dFloat) as dFloat
declare function NewtonConstraintCreateUpVector cdecl alias "NewtonConstraintCreateUpVector" (byval newtonWorld as NewtonWorld ptr, byval pinDir as dFloat ptr, byval body as NewtonBody ptr) as NewtonJoint ptr
declare sub NewtonUpVectorGetPin cdecl alias "NewtonUpVectorGetPin" (byval upVector as NewtonJoint ptr, byval pin as dFloat ptr)
declare sub NewtonUpVectorSetPin cdecl alias "NewtonUpVectorSetPin" (byval upVector as NewtonJoint ptr, byval pin as dFloat ptr)
declare function NewtonConstraintCreateUserJoint cdecl alias "NewtonConstraintCreateUserJoint" (byval newtonWorld as NewtonWorld ptr, byval maxDOF as integer, byval callback as NewtonUserBilateralCallBack, byval childBody as NewtonBody ptr, byval parentBody as NewtonBody ptr) as NewtonJoint ptr
declare sub NewtonUserJointAddLinearRow cdecl alias "NewtonUserJointAddLinearRow" (byval joint as NewtonJoint ptr, byval pivot0 as dFloat ptr, byval pivot1 as dFloat ptr, byval dir as dFloat ptr)
declare sub NewtonUserJointAddAngularRow cdecl alias "NewtonUserJointAddAngularRow" (byval joint as NewtonJoint ptr, byval relativeAngle as dFloat, byval dir as dFloat ptr)
declare sub NewtonUserJointSetRowMinimunFriction cdecl alias "NewtonUserJointSetRowMinimunFriction" (byval joint as NewtonJoint ptr, byval friction as dFloat)
declare sub NewtonUserJointSetRowMaximunFriction cdecl alias "NewtonUserJointSetRowMaximunFriction" (byval joint as NewtonJoint ptr, byval friction as dFloat)
declare sub NewtonUserJointSetRowAcceleration cdecl alias "NewtonUserJointSetRowAcceleration" (byval joint as NewtonJoint ptr, byval acceleration as dFloat)
declare sub NewtonUserJointSetRowStiffness cdecl alias "NewtonUserJointSetRowStiffness" (byval joint as NewtonJoint ptr, byval stiffness as dFloat)
declare function NewtonUserJointGetRowForce cdecl alias "NewtonUserJointGetRowForce" (byval joint as NewtonJoint ptr, byval row as integer) as dFloat
declare function NewtonCreateRagDoll cdecl alias "NewtonCreateRagDoll" (byval newtonWorld as NewtonWorld ptr) as NewtonRagDoll ptr
declare sub NewtonDestroyRagDoll cdecl alias "NewtonDestroyRagDoll" (byval newtonWorld as NewtonWorld ptr, byval ragDoll as NewtonRagDoll ptr)
declare sub NewtonRagDollBegin cdecl alias "NewtonRagDollBegin" (byval ragDoll as NewtonRagDoll ptr)
declare sub NewtonRagDollEnd cdecl alias "NewtonRagDollEnd" (byval ragDoll as NewtonRagDoll ptr)
declare function NewtonRagDollFindBone cdecl alias "NewtonRagDollFindBone" (byval ragDoll as NewtonRagDoll ptr, byval id as integer) as NewtonRagDollBone ptr
declare function NewtonRagDollGetRootBone cdecl alias "NewtonRagDollGetRootBone" (byval ragDoll as NewtonRagDoll ptr) as NewtonRagDollBone ptr
declare sub NewtonRagDollSetForceAndTorqueCallback cdecl alias "NewtonRagDollSetForceAndTorqueCallback" (byval ragDoll as NewtonRagDoll ptr, byval callback as NewtonApplyForceAndTorque)
declare sub NewtonRagDollSetTransformCallback cdecl alias "NewtonRagDollSetTransformCallback" (byval ragDoll as NewtonRagDoll ptr, byval callback as NewtonSetRagDollTransform)
declare function NewtonRagDollAddBone cdecl alias "NewtonRagDollAddBone" (byval ragDoll as NewtonRagDoll ptr, byval parent as NewtonRagDollBone ptr, byval userData as any ptr, byval mass as dFloat, byval matrix as dFloat ptr, byval boneCollision as NewtonCollision ptr, byval size as dFloat ptr) as NewtonRagDollBone ptr
declare function NewtonRagDollBoneGetUserData cdecl alias "NewtonRagDollBoneGetUserData" (byval bone as NewtonRagDollBone ptr) as any ptr
declare function NewtonRagDollBoneGetBody cdecl alias "NewtonRagDollBoneGetBody" (byval bone as NewtonRagDollBone ptr) as NewtonBody ptr
declare sub NewtonRagDollBoneSetID cdecl alias "NewtonRagDollBoneSetID" (byval bone as NewtonRagDollBone ptr, byval id as integer)
declare sub NewtonRagDollBoneSetLimits cdecl alias "NewtonRagDollBoneSetLimits" (byval bone as NewtonRagDollBone ptr, byval coneDir as dFloat ptr, byval minConeAngle as dFloat, byval maxConeAngle as dFloat, byval maxTwistAngle as dFloat, byval bilateralConeDir as dFloat ptr, byval negativeBilateralConeAngle as dFloat, byval positiveBilateralConeAngle as dFloat)
declare sub NewtonRagDollBoneGetLocalMatrix cdecl alias "NewtonRagDollBoneGetLocalMatrix" (byval bone as NewtonRagDollBone ptr, byval matrix as dFloat ptr)
declare sub NewtonRagDollBoneGetGlobalMatrix cdecl alias "NewtonRagDollBoneGetGlobalMatrix" (byval bone as NewtonRagDollBone ptr, byval matrix as dFloat ptr)
declare function NewtonConstraintCreateVehicle cdecl alias "NewtonConstraintCreateVehicle" (byval newtonWorld as NewtonWorld ptr, byval upDir as dFloat ptr, byval body as NewtonBody ptr) as NewtonJoint ptr
declare sub NewtonVehicleReset cdecl alias "NewtonVehicleReset" (byval vehicle as NewtonJoint ptr)
declare sub NewtonVehicleSetTireCallback cdecl alias "NewtonVehicleSetTireCallback" (byval vehicle as NewtonJoint ptr, byval update as NewtonVehicleTireUpdate)
declare function NewtonVehicleAddTire cdecl alias "NewtonVehicleAddTire" (byval vehicle as NewtonJoint ptr, byval localMatrix as dFloat ptr, byval pin as dFloat ptr, byval mass as dFloat, byval width as dFloat, byval radius as dFloat, byval suspesionShock as dFloat, byval suspesionSpring as dFloat, byval suspesionLength as dFloat, byval userData as any ptr, byval collisionID as integer) as integer
declare sub NewtonVehicleRemoveTire cdecl alias "NewtonVehicleRemoveTire" (byval vehicle as NewtonJoint ptr, byval tireIndex as integer)
declare sub NewtonVehicleBalanceTires cdecl alias "NewtonVehicleBalanceTires" (byval vehicle as NewtonJoint ptr, byval gravityMag as dFloat)
declare function NewtonVehicleGetFirstTireID cdecl alias "NewtonVehicleGetFirstTireID" (byval vehicle as NewtonJoint ptr) as integer
declare function NewtonVehicleGetNextTireID cdecl alias "NewtonVehicleGetNextTireID" (byval vehicle as NewtonJoint ptr, byval tireId as integer) as integer
declare function NewtonVehicleTireIsAirBorne cdecl alias "NewtonVehicleTireIsAirBorne" (byval vehicle as NewtonJoint ptr, byval tireId as integer) as integer
declare function NewtonVehicleTireLostSideGrip cdecl alias "NewtonVehicleTireLostSideGrip" (byval vehicle as NewtonJoint ptr, byval tireId as integer) as integer
declare function NewtonVehicleTireLostTraction cdecl alias "NewtonVehicleTireLostTraction" (byval vehicle as NewtonJoint ptr, byval tireId as integer) as integer
declare function NewtonVehicleGetTireUserData cdecl alias "NewtonVehicleGetTireUserData" (byval vehicle as NewtonJoint ptr, byval tireId as integer) as any ptr
declare function NewtonVehicleGetTireOmega cdecl alias "NewtonVehicleGetTireOmega" (byval vehicle as NewtonJoint ptr, byval tireId as integer) as dFloat
declare function NewtonVehicleGetTireNormalLoad cdecl alias "NewtonVehicleGetTireNormalLoad" (byval vehicle as NewtonJoint ptr, byval tireId as integer) as dFloat
declare function NewtonVehicleGetTireSteerAngle cdecl alias "NewtonVehicleGetTireSteerAngle" (byval vehicle as NewtonJoint ptr, byval tireId as integer) as dFloat
declare function NewtonVehicleGetTireLateralSpeed cdecl alias "NewtonVehicleGetTireLateralSpeed" (byval vehicle as NewtonJoint ptr, byval tireId as integer) as dFloat
declare function NewtonVehicleGetTireLongitudinalSpeed cdecl alias "NewtonVehicleGetTireLongitudinalSpeed" (byval vehicle as NewtonJoint ptr, byval tireId as integer) as dFloat
declare sub NewtonVehicleGetTireMatrix cdecl alias "NewtonVehicleGetTireMatrix" (byval vehicle as NewtonJoint ptr, byval tireId as integer, byval matrix as dFloat ptr)
declare sub NewtonVehicleSetTireTorque cdecl alias "NewtonVehicleSetTireTorque" (byval vehicle as NewtonJoint ptr, byval tireId as integer, byval torque as dFloat)
declare sub NewtonVehicleSetTireSteerAngle cdecl alias "NewtonVehicleSetTireSteerAngle" (byval vehicle as NewtonJoint ptr, byval tireId as integer, byval angle as dFloat)
declare sub NewtonVehicleSetTireMaxSideSleepSpeed cdecl alias "NewtonVehicleSetTireMaxSideSleepSpeed" (byval vehicle as NewtonJoint ptr, byval tireId as integer, byval speed as dFloat)
declare sub NewtonVehicleSetTireSideSleepCoeficient cdecl alias "NewtonVehicleSetTireSideSleepCoeficient" (byval vehicle as NewtonJoint ptr, byval tireId as integer, byval coeficient as dFloat)
declare sub NewtonVehicleSetTireMaxLongitudinalSlideSpeed cdecl alias "NewtonVehicleSetTireMaxLongitudinalSlideSpeed" (byval vehicle as NewtonJoint ptr, byval tireId as integer, byval speed as dFloat)
declare sub NewtonVehicleSetTireLongitudinalSlideCoeficient cdecl alias "NewtonVehicleSetTireLongitudinalSlideCoeficient" (byval vehicle as NewtonJoint ptr, byval tireId as integer, byval coeficient as dFloat)
declare function NewtonVehicleTireCalculateMaxBrakeAcceleration cdecl alias "NewtonVehicleTireCalculateMaxBrakeAcceleration" (byval vehicle as NewtonJoint ptr, byval tireId as integer) as dFloat
declare sub NewtonVehicleTireSetBrakeAcceleration cdecl alias "NewtonVehicleTireSetBrakeAcceleration" (byval vehicle as NewtonJoint ptr, byval tireId as integer, byval accelaration as dFloat, byval torqueLimit as dFloat)

#endif
