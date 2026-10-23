#pragma once

#include once "crt/math.bi"

extern "C"

#define RAYMATH_H
const PI = 3.14159265358979323846
const EPSILON = 0.000001f
const DEG2RAD = PI / 180.0f
const RAD2DEG = 180.0f / PI
#define MatrixToFloat(mat) MatrixToFloatV(mat).v
#define Vector3ToFloat(vec) Vector3ToFloatV(vec).v

#ifndef Vector2
	type Vector2
		x as single
		y as single
	end type
#endif

#define RL_VECTOR2_TYPE

#ifndef Vector3
	type Vector3
		x as single
		y as single
		z as single
	end type
#endif

#define RL_VECTOR3_TYPE

#ifndef Vector4
	type Vector4
		x as single
		y as single
		z as single
		w as single
	end type
#endif

#define RL_VECTOR4_TYPE
#ifndef Quaternion
	type Quaternion as Vector4
#endif
#define RL_QUATERNION_TYPE

#ifndef Matrix
	type Matrix
		m0 as single
		m4 as single
		m8 as single
		m12 as single
		m1 as single
		m5 as single
		m9 as single
		m13 as single
		m2 as single
		m6 as single
		m10 as single
		m14 as single
		m3 as single
		m7 as single
		m11 as single
		m15 as single
	end type
#endif

#define RL_MATRIX_TYPE

type float3
	v(0 to 2) as single
end type

#define RL_FLOAT3_TYPE

type float16
	v(0 to 15) as single
end type

#define RL_FLOAT16_TYPE
declare function Clamp(byval value as single, byval min as single, byval max as single) as single
declare function Lerp(byval start as single, byval end_ as single, byval amount as single) as single
declare function Normalize(byval value as single, byval start as single, byval end_ as single) as single
declare function Remap(byval value as single, byval inputStart as single, byval inputEnd as single, byval outputStart as single, byval outputEnd as single) as single
declare function Wrap(byval value as single, byval min as single, byval max as single) as single
declare function FloatEquals(byval x as single, byval y as single) as long
declare function Vector2Zero() as Vector2
declare function Vector2One() as Vector2
declare function Vector2Add(byval v1 as Vector2, byval v2 as Vector2) as Vector2
declare function Vector2AddValue(byval v as Vector2, byval add as single) as Vector2
declare function Vector2Subtract(byval v1 as Vector2, byval v2 as Vector2) as Vector2
declare function Vector2SubtractValue(byval v as Vector2, byval sub_ as single) as Vector2
declare function Vector2Length(byval v as Vector2) as single
declare function Vector2LengthSqr(byval v as Vector2) as single
declare function Vector2DotProduct(byval v1 as Vector2, byval v2 as Vector2) as single
declare function Vector2CrossProduct(byval v1 as Vector2, byval v2 as Vector2) as single
declare function Vector2Distance(byval v1 as Vector2, byval v2 as Vector2) as single
declare function Vector2DistanceSqr(byval v1 as Vector2, byval v2 as Vector2) as single
declare function Vector2Angle(byval v1 as Vector2, byval v2 as Vector2) as single
declare function Vector2LineAngle(byval start as Vector2, byval end_ as Vector2) as single
declare function Vector2Scale(byval v as Vector2, byval scale as single) as Vector2
declare function Vector2Multiply(byval v1 as Vector2, byval v2 as Vector2) as Vector2
declare function Vector2Negate(byval v as Vector2) as Vector2
declare function Vector2Divide(byval v1 as Vector2, byval v2 as Vector2) as Vector2
declare function Vector2Normalize(byval v as Vector2) as Vector2
declare function Vector2Transform(byval v as Vector2, byval mat as Matrix) as Vector2
declare function Vector2Lerp(byval v1 as Vector2, byval v2 as Vector2, byval amount as single) as Vector2
declare function Vector2Reflect(byval v as Vector2, byval normal as Vector2) as Vector2
declare function Vector2Min(byval v1 as Vector2, byval v2 as Vector2) as Vector2
declare function Vector2Max(byval v1 as Vector2, byval v2 as Vector2) as Vector2
declare function Vector2Rotate(byval v as Vector2, byval angle as single) as Vector2
declare function Vector2MoveTowards(byval v as Vector2, byval target as Vector2, byval maxDistance as single) as Vector2
declare function Vector2Invert(byval v as Vector2) as Vector2
declare function Vector2Clamp(byval v as Vector2, byval min as Vector2, byval max as Vector2) as Vector2
declare function Vector2ClampValue(byval v as Vector2, byval min as single, byval max as single) as Vector2
declare function Vector2Equals(byval p as Vector2, byval q as Vector2) as long
declare function Vector2Refract(byval v as Vector2, byval n as Vector2, byval r as single) as Vector2
declare function Vector3Zero() as Vector3
declare function Vector3One() as Vector3
declare function Vector3Add(byval v1 as Vector3, byval v2 as Vector3) as Vector3
declare function Vector3AddValue(byval v as Vector3, byval add as single) as Vector3
declare function Vector3Subtract(byval v1 as Vector3, byval v2 as Vector3) as Vector3
declare function Vector3SubtractValue(byval v as Vector3, byval sub_ as single) as Vector3
declare function Vector3Scale(byval v as Vector3, byval scalar as single) as Vector3
declare function Vector3Multiply(byval v1 as Vector3, byval v2 as Vector3) as Vector3
declare function Vector3CrossProduct(byval v1 as Vector3, byval v2 as Vector3) as Vector3
declare function Vector3Perpendicular(byval v as Vector3) as Vector3
declare function Vector3Length(byval v as const Vector3) as single
declare function Vector3LengthSqr(byval v as const Vector3) as single
declare function Vector3DotProduct(byval v1 as Vector3, byval v2 as Vector3) as single
declare function Vector3Distance(byval v1 as Vector3, byval v2 as Vector3) as single
declare function Vector3DistanceSqr(byval v1 as Vector3, byval v2 as Vector3) as single
declare function Vector3Angle(byval v1 as Vector3, byval v2 as Vector3) as single
declare function Vector3Negate(byval v as Vector3) as Vector3
declare function Vector3Divide(byval v1 as Vector3, byval v2 as Vector3) as Vector3
declare function Vector3Normalize(byval v as Vector3) as Vector3
declare function Vector3Project(byval v1 as Vector3, byval v2 as Vector3) as Vector3
declare function Vector3Reject(byval v1 as Vector3, byval v2 as Vector3) as Vector3
declare sub Vector3OrthoNormalize(byval v1 as Vector3 ptr, byval v2 as Vector3 ptr)
declare function Vector3Transform(byval v as Vector3, byval mat as Matrix) as Vector3
declare function Vector3RotateByQuaternion(byval v as Vector3, byval q as Quaternion) as Vector3
declare function Vector3RotateByAxisAngle(byval v as Vector3, byval axis as Vector3, byval angle as single) as Vector3
declare function Vector3MoveTowards(byval v as Vector3, byval target as Vector3, byval maxDistance as single) as Vector3
declare function Vector3Lerp(byval v1 as Vector3, byval v2 as Vector3, byval amount as single) as Vector3
declare function Vector3CubicHermite(byval v1 as Vector3, byval tangent1 as Vector3, byval v2 as Vector3, byval tangent2 as Vector3, byval amount as single) as Vector3
declare function Vector3Reflect(byval v as Vector3, byval normal as Vector3) as Vector3
declare function Vector3Min(byval v1 as Vector3, byval v2 as Vector3) as Vector3
declare function Vector3Max(byval v1 as Vector3, byval v2 as Vector3) as Vector3
declare function Vector3Barycenter(byval p as Vector3, byval a as Vector3, byval b as Vector3, byval c as Vector3) as Vector3
declare function Vector3Unproject(byval source as Vector3, byval projection as Matrix, byval view as Matrix) as Vector3
declare function Vector3ToFloatV(byval v as Vector3) as float3
declare function Vector3Invert(byval v as Vector3) as Vector3
declare function Vector3Clamp(byval v as Vector3, byval min as Vector3, byval max as Vector3) as Vector3
declare function Vector3ClampValue(byval v as Vector3, byval min as single, byval max as single) as Vector3
declare function Vector3Equals(byval p as Vector3, byval q as Vector3) as long
declare function Vector3Refract(byval v as Vector3, byval n as Vector3, byval r as single) as Vector3
declare function Vector4Zero() as Vector4
declare function Vector4One() as Vector4
declare function Vector4Add(byval v1 as Vector4, byval v2 as Vector4) as Vector4
declare function Vector4AddValue(byval v as Vector4, byval add as single) as Vector4
declare function Vector4Subtract(byval v1 as Vector4, byval v2 as Vector4) as Vector4
declare function Vector4SubtractValue(byval v as Vector4, byval add as single) as Vector4
declare function Vector4Length(byval v as Vector4) as single
declare function Vector4LengthSqr(byval v as Vector4) as single
declare function Vector4DotProduct(byval v1 as Vector4, byval v2 as Vector4) as single
declare function Vector4Distance(byval v1 as Vector4, byval v2 as Vector4) as single
declare function Vector4DistanceSqr(byval v1 as Vector4, byval v2 as Vector4) as single
declare function Vector4Scale(byval v as Vector4, byval scale as single) as Vector4
declare function Vector4Multiply(byval v1 as Vector4, byval v2 as Vector4) as Vector4
declare function Vector4Negate(byval v as Vector4) as Vector4
declare function Vector4Divide(byval v1 as Vector4, byval v2 as Vector4) as Vector4
declare function Vector4Normalize(byval v as Vector4) as Vector4
declare function Vector4Min(byval v1 as Vector4, byval v2 as Vector4) as Vector4
declare function Vector4Max(byval v1 as Vector4, byval v2 as Vector4) as Vector4
declare function Vector4Lerp(byval v1 as Vector4, byval v2 as Vector4, byval amount as single) as Vector4
declare function Vector4MoveTowards(byval v as Vector4, byval target as Vector4, byval maxDistance as single) as Vector4
declare function Vector4Invert(byval v as Vector4) as Vector4
declare function Vector4Equals(byval p as Vector4, byval q as Vector4) as long
declare function MatrixDeterminant(byval mat as Matrix) as single
declare function MatrixTrace(byval mat as Matrix) as single
declare function MatrixTranspose(byval mat as Matrix) as Matrix
declare function MatrixInvert(byval mat as Matrix) as Matrix
declare function MatrixIdentity() as Matrix
declare function MatrixAdd(byval left_ as Matrix, byval right_ as Matrix) as Matrix
declare function MatrixSubtract(byval left_ as Matrix, byval right_ as Matrix) as Matrix
declare function MatrixMultiply(byval left_ as Matrix, byval right_ as Matrix) as Matrix
declare function MatrixMultiplyValue(byval left_ as Matrix, byval value as single) as Matrix
declare function MatrixTranslate(byval x as single, byval y as single, byval z as single) as Matrix
declare function MatrixRotate(byval axis as Vector3, byval angle as single) as Matrix
declare function MatrixRotateX(byval angle as single) as Matrix
declare function MatrixRotateY(byval angle as single) as Matrix
declare function MatrixRotateZ(byval angle as single) as Matrix
declare function MatrixRotateXYZ(byval angle as Vector3) as Matrix
declare function MatrixRotateZYX(byval angle as Vector3) as Matrix
declare function MatrixScale(byval x as single, byval y as single, byval z as single) as Matrix
declare function MatrixFrustum(byval left_ as double, byval right_ as double, byval bottom as double, byval top as double, byval nearPlane as double, byval farPlane as double) as Matrix
declare function MatrixPerspective(byval fovY as double, byval aspect as double, byval nearPlane as double, byval farPlane as double) as Matrix
declare function MatrixOrtho(byval left_ as double, byval right_ as double, byval bottom as double, byval top as double, byval nearPlane as double, byval farPlane as double) as Matrix
declare function MatrixLookAt(byval eye as Vector3, byval target as Vector3, byval up as Vector3) as Matrix
declare function MatrixToFloatV(byval mat as Matrix) as float16
declare function QuaternionAdd(byval q1 as Quaternion, byval q2 as Quaternion) as Quaternion
declare function QuaternionAddValue(byval q as Quaternion, byval add as single) as Quaternion
declare function QuaternionSubtract(byval q1 as Quaternion, byval q2 as Quaternion) as Quaternion
declare function QuaternionSubtractValue(byval q as Quaternion, byval sub_ as single) as Quaternion
declare function QuaternionIdentity() as Quaternion
declare function QuaternionLength(byval q as Quaternion) as single
declare function QuaternionNormalize(byval q as Quaternion) as Quaternion
declare function QuaternionInvert(byval q as Quaternion) as Quaternion
declare function QuaternionMultiply(byval q1 as Quaternion, byval q2 as Quaternion) as Quaternion
declare function QuaternionScale(byval q as Quaternion, byval mul as single) as Quaternion
declare function QuaternionDivide(byval q1 as Quaternion, byval q2 as Quaternion) as Quaternion
declare function QuaternionLerp(byval q1 as Quaternion, byval q2 as Quaternion, byval amount as single) as Quaternion
declare function QuaternionNlerp(byval q1 as Quaternion, byval q2 as Quaternion, byval amount as single) as Quaternion
declare function QuaternionSlerp(byval q1 as Quaternion, byval q2 as Quaternion, byval amount as single) as Quaternion
declare function QuaternionCubicHermiteSpline(byval q1 as Quaternion, byval outTangent1 as Quaternion, byval q2 as Quaternion, byval inTangent2 as Quaternion, byval t as single) as Quaternion
declare function QuaternionFromVector3ToVector3(byval from as Vector3, byval to_ as Vector3) as Quaternion
declare function QuaternionFromMatrix(byval mat as Matrix) as Quaternion
declare function QuaternionToMatrix(byval q as Quaternion) as Matrix
declare function QuaternionFromAxisAngle(byval axis as Vector3, byval angle as single) as Quaternion
declare sub QuaternionToAxisAngle(byval q as Quaternion, byval outAxis as Vector3 ptr, byval outAngle as single ptr)
declare function QuaternionFromEuler(byval pitch as single, byval yaw as single, byval roll as single) as Quaternion
declare function QuaternionToEuler(byval q as Quaternion) as Vector3
declare function QuaternionTransform(byval q as Quaternion, byval mat as Matrix) as Quaternion
declare function QuaternionEquals(byval p as Quaternion, byval q as Quaternion) as long
declare function MatrixCompose(byval translation as Vector3, byval rotation as Quaternion, byval scale as Vector3) as Matrix
declare sub MatrixDecompose(byval mat as Matrix, byval translation as Vector3 ptr, byval rotation as Quaternion ptr, byval scale as Vector3 ptr)

end extern
