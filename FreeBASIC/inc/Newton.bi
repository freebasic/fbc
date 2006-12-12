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

#ifdef __USE_DOUBLE_PRECISION__
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
	m_boxP0(0 to 4-1) as dFloat
	m_boxP1(0 to 4-1) as dFloat
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
	m_p0(0 to 4-1) as dFloat
	m_p1(0 to 4-1) as dFloat
	m_normalOut(0 to 4-1) as dFloat
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
type NewtonAllocMemory as sub cdecl(byval as integer)
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
type NewtonGetBuoyancyPlane as function cdecl(byval as integer, byval as any ptr, byval as dFloat ptr, byval as dFloat ptr) as integer
type NewtonVehicleTireUpdate as sub cdecl(byval as NewtonJoint ptr)
type NewtonWorldRayPrefilterCallback as function cdecl(byval as NewtonBody ptr, byval as NewtonCollision ptr, byval as any ptr) as uinteger
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

extern "c"
declare function NewtonCreate (byval malloc as NewtonAllocMemory, byval mfree as NewtonFreeMemory) as NewtonWorld ptr
declare sub NewtonDestroy (byval newtonWorld as NewtonWorld ptr)
declare sub NewtonDestroyAllBodies (byval newtonWorld as NewtonWorld ptr)
declare sub NewtonUpdate (byval newtonWorld as NewtonWorld ptr, byval timestep as dFloat)
declare sub NewtonSetPlatformArchitecture (byval newtonWorld as NewtonWorld ptr, byval mode as integer)
declare sub NewtonSetSolverModel (byval newtonWorld as NewtonWorld ptr, byval model as integer)
declare sub NewtonSetFrictionModel (byval newtonWorld as NewtonWorld ptr, byval model as integer)
declare function NewtonGetTimeStep (byval newtonWorld as NewtonWorld ptr) as dFloat
declare sub NewtonSetMinimumFrameRate (byval newtonWorld as NewtonWorld ptr, byval frameRate as dFloat)
declare sub NewtonSetBodyLeaveWorldEvent (byval newtonWorld as NewtonWorld ptr, byval callback as NewtonBodyLeaveWorld)
declare sub NewtonSetWorldSize (byval newtonWorld as NewtonWorld ptr, byval minPoint as dFloat ptr, byval maxPoint as dFloat ptr)
declare sub NewtonWorldFreezeBody (byval newtonWorld as NewtonWorld ptr, byval body as NewtonBody ptr)
declare sub NewtonWorldUnfreezeBody (byval newtonWorld as NewtonWorld ptr, byval body as NewtonBody ptr)
declare sub NewtonWorldForEachBodyDo (byval newtonWorld as NewtonWorld ptr, byval callback as NewtonBodyIterator)
declare sub NewtonWorldForEachBodyInAABBDo (byval newtonWorld as NewtonWorld ptr, byval p0 as dFloat ptr, byval p1 as dFloat ptr, byval callback as NewtonBodyIterator)
declare sub NewtonWorldSetUserData (byval newtonWorld as NewtonWorld ptr, byval userData as any ptr)
declare function NewtonWorldGetUserData (byval newtonWorld as NewtonWorld ptr) as any ptr
declare function NewtonWorldGetVersion (byval newtonWorld as NewtonWorld ptr) as integer
declare sub NewtonWorldRayCast (byval newtonWorld as NewtonWorld ptr, byval p0 as dFloat ptr, byval p1 as dFloat ptr, byval filter as NewtonWorldRayFilterCallback, byval userData as any ptr, byval prefilter as NewtonWorldRayPrefilterCallback)
declare function NewtonMaterialGetDefaultGroupID (byval newtonWorld as NewtonWorld ptr) as integer
declare function NewtonMaterialCreateGroupID (byval newtonWorld as NewtonWorld ptr) as integer
declare sub NewtonMaterialDestroyAllGroupID (byval newtonWorld as NewtonWorld ptr)
declare sub NewtonMaterialSetDefaultSoftness (byval newtonWorld as NewtonWorld ptr, byval id0 as integer, byval id1 as integer, byval value as dFloat)
declare sub NewtonMaterialSetDefaultElasticity (byval newtonWorld as NewtonWorld ptr, byval id0 as integer, byval id1 as integer, byval elasticCoef as dFloat)
declare sub NewtonMaterialSetDefaultCollidable (byval newtonWorld as NewtonWorld ptr, byval id0 as integer, byval id1 as integer, byval state as integer)
declare sub NewtonMaterialSetContinuousCollisionMode (byval newtonWorld as NewtonWorld ptr, byval id0 as integer, byval id1 as integer, byval state as integer)
declare sub NewtonMaterialSetDefaultFriction (byval newtonWorld as NewtonWorld ptr, byval id0 as integer, byval id1 as integer, byval staticFriction as dFloat, byval kineticFriction as dFloat)
declare sub NewtonMaterialSetCollisionCallback (byval newtonWorld as NewtonWorld ptr, byval id0 as integer, byval id1 as integer, byval userData as any ptr, byval begin as NewtonContactBegin, byval process as NewtonContactProcess, byval end as NewtonContactEnd)
declare function NewtonMaterialGetUserData (byval newtonWorld as NewtonWorld ptr, byval id0 as integer, byval id1 as integer) as any ptr
declare sub NewtonMaterialDisableContact (byval material as NewtonMaterial ptr)
declare function NewtonMaterialGetCurrentTimestep (byval material as NewtonMaterial ptr) as dFloat
declare function NewtonMaterialGetMaterialPairUserData (byval material as NewtonMaterial ptr) as any ptr
declare function NewtonMaterialGetContactFaceAttribute (byval material as NewtonMaterial ptr) as uinteger
declare function NewtonMaterialGetBodyCollisionID (byval material as NewtonMaterial ptr, byval body as NewtonBody ptr) as uinteger
declare function NewtonMaterialGetContactNormalSpeed (byval material as NewtonMaterial ptr, byval contactlHandle as NewtonContact ptr) as dFloat
declare sub NewtonMaterialGetContactForce (byval material as NewtonMaterial ptr, byval force as dFloat ptr)
declare sub NewtonMaterialGetContactPositionAndNormal (byval material as NewtonMaterial ptr, byval posit as dFloat ptr, byval normal as dFloat ptr)
declare sub NewtonMaterialGetContactTangentDirections (byval material as NewtonMaterial ptr, byval dir0 as dFloat ptr, byval dir as dFloat ptr)
declare function NewtonMaterialGetContactTangentSpeed (byval material as NewtonMaterial ptr, byval contactlHandle as NewtonContact ptr, byval index as integer) as dFloat
declare sub NewtonMaterialSetContactSoftness (byval material as NewtonMaterial ptr, byval softness as dFloat)
declare sub NewtonMaterialSetContactElasticity (byval material as NewtonMaterial ptr, byval restitution as dFloat)
declare sub NewtonMaterialSetContactFrictionState (byval material as NewtonMaterial ptr, byval state as integer, byval index as integer)
declare sub NewtonMaterialSetContactStaticFrictionCoef (byval material as NewtonMaterial ptr, byval coef as dFloat, byval index as integer)
declare sub NewtonMaterialSetContactKineticFrictionCoef (byval material as NewtonMaterial ptr, byval coef as dFloat, byval index as integer)
declare sub NewtonMaterialSetContactNormalAcceleration (byval material as NewtonMaterial ptr, byval accel as dFloat)
declare sub NewtonMaterialSetContactNormalDirection (byval material as NewtonMaterial ptr, byval directionVector as dFloat ptr)
declare sub NewtonMaterialSetContactTangentAcceleration (byval material as NewtonMaterial ptr, byval accel as dFloat, byval index as integer)
declare sub NewtonMaterialContactRotateTangentDirections (byval material as NewtonMaterial ptr, byval directionVector as dFloat ptr)
declare function NewtonCreateNull (byval newtonWorld as NewtonWorld ptr) as NewtonCollision ptr
declare function NewtonCreateSphere (byval newtonWorld as NewtonWorld ptr, byval radiusX as dFloat, byval radiusY as dFloat, byval radiusZ as dFloat, byval offsetMatrix as dFloat ptr) as NewtonCollision ptr
declare function NewtonCreateBox (byval newtonWorld as NewtonWorld ptr, byval dx as dFloat, byval dy as dFloat, byval dz as dFloat, byval offsetMatrix as dFloat ptr) as NewtonCollision ptr
declare function NewtonCreateCone (byval newtonWorld as NewtonWorld ptr, byval radius as dFloat, byval height as dFloat, byval offsetMatrix as dFloat ptr) as NewtonCollision ptr
declare function NewtonCreateCapsule (byval newtonWorld as NewtonWorld ptr, byval radius as dFloat, byval height as dFloat, byval offsetMatrix as dFloat ptr) as NewtonCollision ptr
declare function NewtonCreateCylinder (byval newtonWorld as NewtonWorld ptr, byval radius as dFloat, byval height as dFloat, byval offsetMatrix as dFloat ptr) as NewtonCollision ptr
declare function NewtonCreateChamferCylinder (byval newtonWorld as NewtonWorld ptr, byval radius as dFloat, byval height as dFloat, byval offsetMatrix as dFloat ptr) as NewtonCollision ptr
declare function NewtonCreateConvexHull (byval newtonWorld as NewtonWorld ptr, byval count as integer, byval vertexCloud as dFloat ptr, byval strideInBytes as integer, byval offsetMatrix as dFloat ptr) as NewtonCollision ptr
declare function NewtonCreateConvexHullModifier (byval newtonWorld as NewtonWorld ptr, byval convexHullCollision as NewtonCollision ptr) as NewtonCollision ptr
declare sub NewtonConvexHullModifierGetMatrix (byval convexHullCollision as NewtonCollision ptr, byval matrix as dFloat ptr)
declare sub NewtonConvexHullModifierSetMatrix (byval convexHullCollision as NewtonCollision ptr, byval matrix as dFloat ptr)
declare sub NewtonConvexCollisionSetUserID (byval convexCollision as NewtonCollision ptr, byval id as uinteger)
declare function NewtonConvexCollisionGetUserID (byval convexCollision as NewtonCollision ptr) as uinteger
declare function NewtonConvexCollisionCalculateVolume (byval convexCollision as NewtonCollision ptr) as dFloat
declare sub NewtonConvexCollisionCalculateInertialMatrix (byval convexCollision as NewtonCollision ptr, byval inertia as dFloat ptr, byval origin as dFloat ptr)
declare sub NewtonCollisionMakeUnique (byval newtonWorld as NewtonWorld ptr, byval collision as NewtonCollision ptr)
declare sub NewtonReleaseCollision (byval newtonWorld as NewtonWorld ptr, byval collision as NewtonCollision ptr)
declare function NewtonCreateCompoundCollision (byval newtonWorld as NewtonWorld ptr, byval count as integer, byval collisionPrimitiveArray as NewtonCollision ptr ptr) as NewtonCollision ptr
declare function NewtonCreateUserMeshCollision (byval newtonWorld as NewtonWorld ptr, byval minBox as dFloat ptr, byval maxBox as dFloat ptr, byval userData as any ptr, byval collideCallback as NewtonUserMeshCollisionCollideCallback, byval rayHitCallback as NewtonUserMeshCollisionRayHitCallback, byval destroyCallback as NewtonUserMeshCollisionDestroyCallback) as NewtonCollision ptr
declare function NewtonCreateTreeCollision (byval newtonWorld as NewtonWorld ptr, byval userCallback as NewtonTreeCollisionCallback) as NewtonCollision ptr
declare sub NewtonTreeCollisionBeginBuild (byval treeCollision as NewtonCollision ptr)
declare sub NewtonTreeCollisionAddFace (byval treeCollision as NewtonCollision ptr, byval vertexCount as integer, byval vertexPtr as dFloat ptr, byval strideInBytes as integer, byval faceAttribute as integer)
declare sub NewtonTreeCollisionEndBuild (byval treeCollision as NewtonCollision ptr, byval optimize as integer)
declare sub NewtonTreeCollisionSerialize (byval treeCollision as NewtonCollision ptr, byval serializeFunction as NewtonSerialize, byval serializeHandle as any ptr)
declare function NewtonCreateTreeCollisionFromSerialization (byval newtonWorld as NewtonWorld ptr, byval userCallback as NewtonTreeCollisionCallback, byval deserializeFunction as NewtonDeserialize, byval serializeHandle as any ptr) as NewtonCollision ptr
declare function NewtonTreeCollisionGetFaceAtribute (byval treeCollision as NewtonCollision ptr, byval faceIndexArray as integer ptr) as integer
declare sub NewtonTreeCollisionSetFaceAtribute (byval treeCollision as NewtonCollision ptr, byval faceIndexArray as integer ptr, byval attribute as integer)
declare function NewtonCollisionPointDistance (byval newtonWorld as NewtonWorld ptr, byval point as dFloat ptr, byval collsion as NewtonCollision ptr, byval matrix as dFloat ptr, byval contact as dFloat ptr, byval normal as dFloat ptr) as integer
declare function NewtonCollisionClosestPoint (byval newtonWorld as NewtonWorld ptr, byval collsionA as NewtonCollision ptr, byval matrixA as dFloat ptr, byval collsionB as NewtonCollision ptr, byval matrixB as dFloat ptr, byval contactA as dFloat ptr, byval contactB as dFloat ptr, byval normalAB as dFloat ptr) as integer
declare function NewtonCollisionCollide (byval newtonWorld as NewtonWorld ptr, byval maxSize as integer, byval collsionA as NewtonCollision ptr, byval matrixA as dFloat ptr, byval collsionB as NewtonCollision ptr, byval matrixB as dFloat ptr, byval contacts as dFloat ptr, byval normals as dFloat ptr, byval penetration as dFloat ptr) as integer
declare function NewtonCollisionCollideContinue (byval newtonWorld as NewtonWorld ptr, byval maxSize as integer, byval timestap as dFloat, byval collsionA as NewtonCollision ptr, byval matrixA as dFloat ptr, byval velocA as dFloat ptr, byval omegaA as dFloat ptr, byval collsionB as NewtonCollision ptr, byval matrixB as dFloat ptr, byval velocB as dFloat ptr, byval omegaB as dFloat ptr, byval timeOfImpact as dFloat ptr, byval contacts as dFloat ptr, byval normals as dFloat ptr, byval penetration as dFloat ptr) as integer
declare function NewtonCollisionRayCast (byval collision as NewtonCollision ptr, byval p0 as dFloat ptr, byval p1 as dFloat ptr, byval normals as dFloat ptr, byval attribute as integer ptr) as dFloat
declare sub NewtonCollisionCalculateAABB (byval collision as NewtonCollision ptr, byval matrix as dFloat ptr, byval p0 as dFloat ptr, byval p1 as dFloat ptr)
declare sub NewtonGetEulerAngle (byval matrix as dFloat ptr, byval eulersAngles as dFloat ptr)
declare sub NewtonSetEulerAngle (byval eulersAngles as dFloat ptr, byval matrix as dFloat ptr)
declare function NewtonCreateBody (byval newtonWorld as NewtonWorld ptr, byval collision as NewtonCollision ptr) as NewtonBody ptr
declare sub NewtonDestroyBody (byval newtonWorld as NewtonWorld ptr, byval body as NewtonBody ptr)
declare sub NewtonBodyAddForce (byval body as NewtonBody ptr, byval force as dFloat ptr)
declare sub NewtonBodyAddTorque (byval body as NewtonBody ptr, byval torque as dFloat ptr)
declare sub NewtonBodySetMatrix (byval body as NewtonBody ptr, byval matrix as dFloat ptr)
declare sub NewtonBodySetMatrixRecursive (byval body as NewtonBody ptr, byval matrix as dFloat ptr)
declare sub NewtonBodySetMassMatrix (byval body as NewtonBody ptr, byval mass as dFloat, byval Ixx as dFloat, byval Iyy as dFloat, byval Izz as dFloat)
declare sub NewtonBodySetMaterialGroupID (byval body as NewtonBody ptr, byval id as integer)
declare sub NewtonBodySetContinuousCollisionMode (byval body as NewtonBody ptr, byval state as uinteger)
declare sub NewtonBodySetJointRecursiveCollision (byval body as NewtonBody ptr, byval state as uinteger)
declare sub NewtonBodySetOmega (byval body as NewtonBody ptr, byval omega as dFloat ptr)
declare sub NewtonBodySetVelocity (byval body as NewtonBody ptr, byval velocity as dFloat ptr)
declare sub NewtonBodySetForce (byval body as NewtonBody ptr, byval force as dFloat ptr)
declare sub NewtonBodySetTorque (byval body as NewtonBody ptr, byval torque as dFloat ptr)
declare sub NewtonBodySetCentreOfMass (byval body as NewtonBody ptr, byval com as dFloat ptr)
declare sub NewtonBodySetLinearDamping (byval body as NewtonBody ptr, byval linearDamp as dFloat)
declare sub NewtonBodySetAngularDamping (byval body as NewtonBody ptr, byval angularDamp as dFloat ptr)
declare sub NewtonBodySetUserData (byval body as NewtonBody ptr, byval userData as any ptr)
declare sub NewtonBodyCoriolisForcesMode (byval body as NewtonBody ptr, byval mode as integer)
declare sub NewtonBodySetCollision (byval body as NewtonBody ptr, byval collision as NewtonCollision ptr)
declare sub NewtonBodySetAutoFreeze (byval body as NewtonBody ptr, byval state as integer)
declare sub NewtonBodySetFreezeTreshold (byval body as NewtonBody ptr, byval freezeSpeed2 as dFloat, byval freezeOmega2 as dFloat, byval framesCount as integer)
declare sub NewtonBodySetTransformCallback (byval body as NewtonBody ptr, byval callback as NewtonSetTransform)
declare sub NewtonBodySetDestructorCallback (byval body as NewtonBody ptr, byval callback as NewtonBodyDestructor)
declare sub NewtonBodySetAutoactiveCallback (byval body as NewtonBody ptr, byval callback as NewtonBodyActivationState)
declare sub NewtonBodySetForceAndTorqueCallback (byval body as NewtonBody ptr, byval callback as NewtonApplyForceAndTorque)
declare function NewtonBodyGetForceAndTorqueCallback (byval body as NewtonBody ptr) as NewtonApplyForceAndTorque
declare function NewtonBodyGetUserData (byval body as NewtonBody ptr) as any ptr
declare function NewtonBodyGetWorld (byval body as NewtonBody ptr) as NewtonWorld ptr
declare function NewtonBodyGetCollision (byval body as NewtonBody ptr) as NewtonCollision ptr
declare function NewtonBodyGetMaterialGroupID (byval body as NewtonBody ptr) as integer
declare function NewtonBodyGetContinuousCollisionMode (byval body as NewtonBody ptr) as integer
declare function NewtonBodyGetJointRecursiveCollision (byval body as NewtonBody ptr) as integer
declare sub NewtonBodyGetMatrix (byval body as NewtonBody ptr, byval matrix as dFloat ptr)
declare sub NewtonBodyGetMassMatrix (byval body as NewtonBody ptr, byval mass as dFloat ptr, byval Ixx as dFloat ptr, byval Iyy as dFloat ptr, byval Izz as dFloat ptr)
declare sub NewtonBodyGetInvMass (byval body as NewtonBody ptr, byval invMass as dFloat ptr, byval invIxx as dFloat ptr, byval invIyy as dFloat ptr, byval invIzz as dFloat ptr)
declare sub NewtonBodyGetOmega (byval body as NewtonBody ptr, byval vector as dFloat ptr)
declare sub NewtonBodyGetVelocity (byval body as NewtonBody ptr, byval vector as dFloat ptr)
declare sub NewtonBodyGetForce (byval body as NewtonBody ptr, byval vector as dFloat ptr)
declare sub NewtonBodyGetTorque (byval body as NewtonBody ptr, byval vector as dFloat ptr)
declare sub NewtonBodyGetCentreOfMass (byval body as NewtonBody ptr, byval com as dFloat ptr)
declare function NewtonBodyGetSleepingState (byval body as NewtonBody ptr) as integer
declare function NewtonBodyGetAutoFreeze (byval body as NewtonBody ptr) as integer
declare function NewtonBodyGetLinearDamping (byval body as NewtonBody ptr) as dFloat
declare sub NewtonBodyGetAngularDamping (byval body as NewtonBody ptr, byval vector as dFloat ptr)
declare sub NewtonBodyGetAABB (byval body as NewtonBody ptr, byval p0 as dFloat ptr, byval p1 as dFloat ptr)
declare sub NewtonBodyGetFreezeTreshold (byval body as NewtonBody ptr, byval freezeSpeed2 as dFloat ptr, byval freezeOmega2 as dFloat ptr)
declare sub NewtonBodyAddBuoyancyForce (byval body as NewtonBody ptr, byval fluidDensity as dFloat, byval fluidLinearViscosity as dFloat, byval fluidAngularViscosity as dFloat, byval gravityVector as dFloat ptr, byval buoyancyPlane as NewtonGetBuoyancyPlane, byval context as any ptr)
declare sub NewtonBodyForEachPolygonDo (byval body as NewtonBody ptr, byval callback as NewtonCollisionIterator)
declare sub NewtonAddBodyImpulse (byval body as NewtonBody ptr, byval pointDeltaVeloc as dFloat ptr, byval pointPosit as dFloat ptr)
declare function NewtonJointGetUserData (byval joint as NewtonJoint ptr) as any ptr
declare sub NewtonJointSetUserData (byval joint as NewtonJoint ptr, byval userData as any ptr)
declare function NewtonJointGetCollisionState (byval joint as NewtonJoint ptr) as integer
declare sub NewtonJointSetCollisionState (byval joint as NewtonJoint ptr, byval state as integer)
declare function NewtonJointGetStiffness (byval joint as NewtonJoint ptr) as dFloat
declare sub NewtonJointSetStiffness (byval joint as NewtonJoint ptr, byval state as dFloat)
declare sub NewtonDestroyJoint (byval newtonWorld as NewtonWorld ptr, byval joint as NewtonJoint ptr)
declare sub NewtonJointSetDestructor (byval joint as NewtonJoint ptr, byval destructor as NewtonConstraintDestructor)
declare function NewtonConstraintCreateBall (byval newtonWorld as NewtonWorld ptr, byval pivotPoint as dFloat ptr, byval childBody as NewtonBody ptr, byval parentBody as NewtonBody ptr) as NewtonJoint ptr
declare sub NewtonBallSetUserCallback (byval ball as NewtonJoint ptr, byval callback as NewtonBallCallBack)
declare sub NewtonBallGetJointAngle (byval ball as NewtonJoint ptr, byval angle as dFloat ptr)
declare sub NewtonBallGetJointOmega (byval ball as NewtonJoint ptr, byval omega as dFloat ptr)
declare sub NewtonBallGetJointForce (byval ball as NewtonJoint ptr, byval force as dFloat ptr)
declare sub NewtonBallSetConeLimits (byval ball as NewtonJoint ptr, byval pin as dFloat ptr, byval maxConeAngle as dFloat, byval maxTwistAngle as dFloat)
declare function NewtonConstraintCreateHinge (byval newtonWorld as NewtonWorld ptr, byval pivotPoint as dFloat ptr, byval pinDir as dFloat ptr, byval childBody as NewtonBody ptr, byval parentBody as NewtonBody ptr) as NewtonJoint ptr
declare sub NewtonHingeSetUserCallback (byval hinge as NewtonJoint ptr, byval callback as NewtonHingeCallBack)
declare function NewtonHingeGetJointAngle (byval hinge as NewtonJoint ptr) as dFloat
declare function NewtonHingeGetJointOmega (byval hinge as NewtonJoint ptr) as dFloat
declare sub NewtonHingeGetJointForce (byval hinge as NewtonJoint ptr, byval force as dFloat ptr)
declare function NewtonHingeCalculateStopAlpha (byval hinge as NewtonJoint ptr, byval desc as NewtonHingeSliderUpdateDesc ptr, byval angle as dFloat) as dFloat
declare function NewtonConstraintCreateSlider (byval newtonWorld as NewtonWorld ptr, byval pivotPoint as dFloat ptr, byval pinDir as dFloat ptr, byval childBody as NewtonBody ptr, byval parentBody as NewtonBody ptr) as NewtonJoint ptr
declare sub NewtonSliderSetUserCallback (byval slider as NewtonJoint ptr, byval callback as NewtonSliderCallBack)
declare function NewtonSliderGetJointPosit (byval slider as NewtonJoint ptr) as dFloat
declare function NewtonSliderGetJointVeloc (byval slider as NewtonJoint ptr) as dFloat
declare sub NewtonSliderGetJointForce (byval slider as NewtonJoint ptr, byval force as dFloat ptr)
declare function NewtonSliderCalculateStopAccel (byval slider as NewtonJoint ptr, byval desc as NewtonHingeSliderUpdateDesc ptr, byval position as dFloat) as dFloat
declare function NewtonConstraintCreateCorkscrew (byval newtonWorld as NewtonWorld ptr, byval pivotPoint as dFloat ptr, byval pinDir as dFloat ptr, byval childBody as NewtonBody ptr, byval parentBody as NewtonBody ptr) as NewtonJoint ptr
declare sub NewtonCorkscrewSetUserCallback (byval corkscrew as NewtonJoint ptr, byval callback as NewtonCorkscrewCallBack)
declare function NewtonCorkscrewGetJointPosit (byval corkscrew as NewtonJoint ptr) as dFloat
declare function NewtonCorkscrewGetJointAngle (byval corkscrew as NewtonJoint ptr) as dFloat
declare function NewtonCorkscrewGetJointVeloc (byval corkscrew as NewtonJoint ptr) as dFloat
declare function NewtonCorkscrewGetJointOmega (byval corkscrew as NewtonJoint ptr) as dFloat
declare sub NewtonCorkscrewGetJointForce (byval corkscrew as NewtonJoint ptr, byval force as dFloat ptr)
declare function NewtonCorkscrewCalculateStopAlpha (byval corkscrew as NewtonJoint ptr, byval desc as NewtonHingeSliderUpdateDesc ptr, byval angle as dFloat) as dFloat
declare function NewtonCorkscrewCalculateStopAccel (byval corkscrew as NewtonJoint ptr, byval desc as NewtonHingeSliderUpdateDesc ptr, byval position as dFloat) as dFloat
declare function NewtonConstraintCreateUniversal (byval newtonWorld as NewtonWorld ptr, byval pivotPoint as dFloat ptr, byval pinDir0 as dFloat ptr, byval pinDir1 as dFloat ptr, byval childBody as NewtonBody ptr, byval parentBody as NewtonBody ptr) as NewtonJoint ptr
declare sub NewtonUniversalSetUserCallback (byval universal as NewtonJoint ptr, byval callback as NewtonUniversalCallBack)
declare function NewtonUniversalGetJointAngle0 (byval universal as NewtonJoint ptr) as dFloat
declare function NewtonUniversalGetJointAngle1 (byval universal as NewtonJoint ptr) as dFloat
declare function NewtonUniversalGetJointOmega0 (byval universal as NewtonJoint ptr) as dFloat
declare function NewtonUniversalGetJointOmega1 (byval universal as NewtonJoint ptr) as dFloat
declare sub NewtonUniversalGetJointForce (byval universal as NewtonJoint ptr, byval force as dFloat ptr)
declare function NewtonUniversalCalculateStopAlpha0 (byval universal as NewtonJoint ptr, byval desc as NewtonHingeSliderUpdateDesc ptr, byval angle as dFloat) as dFloat
declare function NewtonUniversalCalculateStopAlpha1 (byval universal as NewtonJoint ptr, byval desc as NewtonHingeSliderUpdateDesc ptr, byval angle as dFloat) as dFloat
declare function NewtonConstraintCreateUpVector (byval newtonWorld as NewtonWorld ptr, byval pinDir as dFloat ptr, byval body as NewtonBody ptr) as NewtonJoint ptr
declare sub NewtonUpVectorGetPin (byval upVector as NewtonJoint ptr, byval pin as dFloat ptr)
declare sub NewtonUpVectorSetPin (byval upVector as NewtonJoint ptr, byval pin as dFloat ptr)
declare function NewtonConstraintCreateUserJoint (byval newtonWorld as NewtonWorld ptr, byval maxDOF as integer, byval callback as NewtonUserBilateralCallBack, byval childBody as NewtonBody ptr, byval parentBody as NewtonBody ptr) as NewtonJoint ptr
declare sub NewtonUserJointAddLinearRow (byval joint as NewtonJoint ptr, byval pivot0 as dFloat ptr, byval pivot1 as dFloat ptr, byval dir as dFloat ptr)
declare sub NewtonUserJointAddAngularRow (byval joint as NewtonJoint ptr, byval relativeAngle as dFloat, byval dir as dFloat ptr)
declare sub NewtonUserJointAddGeneralRow (byval joint as NewtonJoint ptr, byval jacobian0 as dFloat ptr, byval jacobian1 as dFloat ptr)
declare sub NewtonUserJointSetRowMinimumFriction (byval joint as NewtonJoint ptr, byval friction as dFloat)
declare sub NewtonUserJointSetRowMaximumFriction (byval joint as NewtonJoint ptr, byval friction as dFloat)
declare sub NewtonUserJointSetRowAcceleration (byval joint as NewtonJoint ptr, byval acceleration as dFloat)
declare sub NewtonUserJointSetRowSpringDamperAcceleration (byval joint as NewtonJoint ptr, byval springK as dFloat, byval springD as dFloat)
declare sub NewtonUserJointSetRowStiffness (byval joint as NewtonJoint ptr, byval stiffness as dFloat)
declare function NewtonUserJointGetRowForce (byval joint as NewtonJoint ptr, byval row as integer) as dFloat
declare function NewtonCreateRagDoll (byval newtonWorld as NewtonWorld ptr) as NewtonRagDoll ptr
declare sub NewtonDestroyRagDoll (byval newtonWorld as NewtonWorld ptr, byval ragDoll as NewtonRagDoll ptr)
declare sub NewtonRagDollBegin (byval ragDoll as NewtonRagDoll ptr)
declare sub NewtonRagDollEnd (byval ragDoll as NewtonRagDoll ptr)
declare function NewtonRagDollFindBone (byval ragDoll as NewtonRagDoll ptr, byval id as integer) as NewtonRagDollBone ptr
declare sub NewtonRagDollSetForceAndTorqueCallback (byval ragDoll as NewtonRagDoll ptr, byval callback as NewtonApplyForceAndTorque)
declare sub NewtonRagDollSetTransformCallback (byval ragDoll as NewtonRagDoll ptr, byval callback as NewtonSetRagDollTransform)
declare function NewtonRagDollAddBone (byval ragDoll as NewtonRagDoll ptr, byval parent as NewtonRagDollBone ptr, byval userData as any ptr, byval mass as dFloat, byval matrix as dFloat ptr, byval boneCollision as NewtonCollision ptr, byval size as dFloat ptr) as NewtonRagDollBone ptr
declare function NewtonRagDollBoneGetUserData (byval bone as NewtonRagDollBone ptr) as any ptr
declare function NewtonRagDollBoneGetBody (byval bone as NewtonRagDollBone ptr) as NewtonBody ptr
declare sub NewtonRagDollBoneSetID (byval bone as NewtonRagDollBone ptr, byval id as integer)
declare sub NewtonRagDollBoneSetLimits (byval bone as NewtonRagDollBone ptr, byval coneDir as dFloat ptr, byval minConeAngle as dFloat, byval maxConeAngle as dFloat, byval maxTwistAngle as dFloat, byval bilateralConeDir as dFloat ptr, byval negativeBilateralConeAngle as dFloat, byval positiveBilateralConeAngle as dFloat)
declare sub NewtonRagDollBoneGetLocalMatrix (byval bone as NewtonRagDollBone ptr, byval matrix as dFloat ptr)
declare sub NewtonRagDollBoneGetGlobalMatrix (byval bone as NewtonRagDollBone ptr, byval matrix as dFloat ptr)
declare function NewtonConstraintCreateVehicle (byval newtonWorld as NewtonWorld ptr, byval upDir as dFloat ptr, byval body as NewtonBody ptr) as NewtonJoint ptr
declare sub NewtonVehicleReset (byval vehicle as NewtonJoint ptr)
declare sub NewtonVehicleSetTireCallback (byval vehicle as NewtonJoint ptr, byval update as NewtonVehicleTireUpdate)
declare function NewtonVehicleAddTire (byval vehicle as NewtonJoint ptr, byval localMatrix as dFloat ptr, byval pin as dFloat ptr, byval mass as dFloat, byval width as dFloat, byval radius as dFloat, byval suspesionShock as dFloat, byval suspesionSpring as dFloat, byval suspesionLength as dFloat, byval userData as any ptr, byval collisionID as integer) as any ptr
declare sub NewtonVehicleRemoveTire (byval vehicle as NewtonJoint ptr, byval tireId as any ptr)
declare function NewtonVehicleGetFirstTireID (byval vehicle as NewtonJoint ptr) as any ptr
declare function NewtonVehicleGetNextTireID (byval vehicle as NewtonJoint ptr, byval tireId as any ptr) as any ptr
declare function NewtonVehicleTireIsAirBorne (byval vehicle as NewtonJoint ptr, byval tireId as any ptr) as integer
declare function NewtonVehicleTireLostSideGrip (byval vehicle as NewtonJoint ptr, byval tireId as any ptr) as integer
declare function NewtonVehicleTireLostTraction (byval vehicle as NewtonJoint ptr, byval tireId as any ptr) as integer
declare function NewtonVehicleGetTireUserData (byval vehicle as NewtonJoint ptr, byval tireId as any ptr) as any ptr
declare function NewtonVehicleGetTireOmega (byval vehicle as NewtonJoint ptr, byval tireId as any ptr) as dFloat
declare function NewtonVehicleGetTireNormalLoad (byval vehicle as NewtonJoint ptr, byval tireId as any ptr) as dFloat
declare function NewtonVehicleGetTireSteerAngle (byval vehicle as NewtonJoint ptr, byval tireId as any ptr) as dFloat
declare function NewtonVehicleGetTireLateralSpeed (byval vehicle as NewtonJoint ptr, byval tireId as any ptr) as dFloat
declare function NewtonVehicleGetTireLongitudinalSpeed (byval vehicle as NewtonJoint ptr, byval tireId as any ptr) as dFloat
declare sub NewtonVehicleGetTireMatrix (byval vehicle as NewtonJoint ptr, byval tireId as any ptr, byval matrix as dFloat ptr)
declare sub NewtonVehicleSetTireTorque (byval vehicle as NewtonJoint ptr, byval tireId as any ptr, byval torque as dFloat)
declare sub NewtonVehicleSetTireSteerAngle (byval vehicle as NewtonJoint ptr, byval tireId as any ptr, byval angle as dFloat)
declare sub NewtonVehicleSetTireMaxSideSleepSpeed (byval vehicle as NewtonJoint ptr, byval tireId as any ptr, byval speed as dFloat)
declare sub NewtonVehicleSetTireSideSleepCoeficient (byval vehicle as NewtonJoint ptr, byval tireId as any ptr, byval coeficient as dFloat)
declare sub NewtonVehicleSetTireMaxLongitudinalSlideSpeed (byval vehicle as NewtonJoint ptr, byval tireId as any ptr, byval speed as dFloat)
declare sub NewtonVehicleSetTireLongitudinalSlideCoeficient (byval vehicle as NewtonJoint ptr, byval tireId as any ptr, byval coeficient as dFloat)
declare function NewtonVehicleTireCalculateMaxBrakeAcceleration (byval vehicle as NewtonJoint ptr, byval tireId as any ptr) as dFloat
declare sub NewtonVehicleTireSetBrakeAcceleration (byval vehicle as NewtonJoint ptr, byval tireId as any ptr, byval accelaration as dFloat, byval torqueLimit as dFloat)
end extern

#endif
