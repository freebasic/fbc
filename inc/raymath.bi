'' FreeBASIC binding for raymath from raylib-3.0.0
''
'' based on the C header files:
''    raymath v1.2 - Math functions to work with Vector3, Matrix and Quaternions
''
''    LICENSE: zlib/libpng
''
''    Copyright (c) 2015-2020 Ramon Santamaria (@raysan5)
''
''    This software is provided "as-is", without any express or implied warranty. In no event
''    will the authors be held liable for any damages arising from the use of this software.
''
''    Permission is granted to anyone to use this software for any purpose, including commercial
''    applications, and to alter it and redistribute it freely, subject to the following restrictions:
''
''      1. The origin of this software must not be misrepresented; you must not claim that you
''      wrote the original software. If you use this software in a product, an acknowledgment
''      in the product documentation would be appreciated but is not required.
''
''      2. Altered source versions must be plainly marked as such, and must not be misrepresented
''      as being the original software.
''
''      3. This notice may not be removed or altered from any source distribution.
''
'' translated to FreeBASIC by:
''   Copyright © 2021 FreeBASIC development team

#pragma once

#include once "crt/math.bi"

extern "C"

#define RAYMATH_H
const PI = 3.14159265358979323846
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

#ifndef Vector3
	type Vector3
		x as single
		y as single
		z as single
	end type
#endif

#ifndef Quaternion
	type Quaternion
		x as single
		y as single
		z as single
		w as single
	end type
#endif

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

type float3
	v(0 to 2) as single
end type

type float16
	v(0 to 15) as single
end type

#if (not defined(RAYMATH_HEADER_ONLY)) and defined(RAYLIB_H)
	declare function Clamp(byval value as single, byval min as single, byval max as single) as single
	declare function Lerp(byval start as single, byval end_ as single, byval amount as single) as single
	declare function Vector2Zero() as Vector2
	declare function Vector2One() as Vector2
	declare function Vector2Add(byval v1 as Vector2, byval v2 as Vector2) as Vector2
	declare function Vector2Subtract(byval v1 as Vector2, byval v2 as Vector2) as Vector2
	declare function Vector2Length(byval v as Vector2) as single
	declare function Vector2DotProduct(byval v1 as Vector2, byval v2 as Vector2) as single
	declare function Vector2Distance(byval v1 as Vector2, byval v2 as Vector2) as single
	declare function Vector2Angle(byval v1 as Vector2, byval v2 as Vector2) as single
	declare function Vector2Scale(byval v as Vector2, byval scale as single) as Vector2
	declare function Vector2MultiplyV(byval v1 as Vector2, byval v2 as Vector2) as Vector2
	declare function Vector2Negate(byval v as Vector2) as Vector2
	declare function Vector2Divide(byval v as Vector2, byval div as single) as Vector2
	declare function Vector2DivideV(byval v1 as Vector2, byval v2 as Vector2) as Vector2
	declare function Vector2Normalize(byval v as Vector2) as Vector2
	declare function Vector2Lerp(byval v1 as Vector2, byval v2 as Vector2, byval amount as single) as Vector2
	declare function Vector2Rotate(byval v as Vector2, byval degs as single) as Vector2
	declare function Vector3Zero() as Vector3
	declare function Vector3One() as Vector3
	declare function Vector3Add(byval v1 as Vector3, byval v2 as Vector3) as Vector3
	declare function Vector3Subtract(byval v1 as Vector3, byval v2 as Vector3) as Vector3
	declare function Vector3Scale(byval v as Vector3, byval scalar as single) as Vector3
	declare function Vector3Multiply(byval v1 as Vector3, byval v2 as Vector3) as Vector3
	declare function Vector3CrossProduct(byval v1 as Vector3, byval v2 as Vector3) as Vector3
	declare function Vector3Perpendicular(byval v as Vector3) as Vector3
	declare function Vector3Length(byval v as const Vector3) as single
	declare function Vector3DotProduct(byval v1 as Vector3, byval v2 as Vector3) as single
	declare function Vector3Distance(byval v1 as Vector3, byval v2 as Vector3) as single
	declare function Vector3Negate(byval v as Vector3) as Vector3
	declare function Vector3Divide(byval v as Vector3, byval div as single) as Vector3
	declare function Vector3DivideV(byval v1 as Vector3, byval v2 as Vector3) as Vector3
	declare function Vector3Normalize(byval v as Vector3) as Vector3
	declare sub Vector3OrthoNormalize(byval v1 as Vector3 ptr, byval v2 as Vector3 ptr)
	declare function Vector3Transform(byval v as Vector3, byval mat as Matrix) as Vector3
	declare function Vector3RotateByQuaternion(byval v as Vector3, byval q as Quaternion) as Vector3
	declare function Vector3Lerp(byval v1 as Vector3, byval v2 as Vector3, byval amount as single) as Vector3
	declare function Vector3Reflect(byval v as Vector3, byval normal as Vector3) as Vector3
	declare function Vector3Min(byval v1 as Vector3, byval v2 as Vector3) as Vector3
	declare function Vector3Max(byval v1 as Vector3, byval v2 as Vector3) as Vector3
	declare function Vector3Barycenter(byval p as Vector3, byval a as Vector3, byval b as Vector3, byval c as Vector3) as Vector3
	declare function Vector3ToFloatV(byval v as Vector3) as float3
	declare function MatrixDeterminant(byval mat as Matrix) as single
	declare function MatrixTrace(byval mat as Matrix) as single
	declare function MatrixTranspose(byval mat as Matrix) as Matrix
	declare function MatrixInvert(byval mat as Matrix) as Matrix
	declare function MatrixNormalize(byval mat as Matrix) as Matrix
	declare function MatrixIdentity() as Matrix
	declare function MatrixAdd(byval left_ as Matrix, byval right_ as Matrix) as Matrix
	declare function MatrixSubtract(byval left_ as Matrix, byval right_ as Matrix) as Matrix
	declare function MatrixTranslate(byval x as single, byval y as single, byval z as single) as Matrix
	declare function MatrixRotate(byval axis as Vector3, byval angle as single) as Matrix
	declare function MatrixRotateXYZ(byval ang as Vector3) as Matrix
	declare function MatrixRotateX(byval angle as single) as Matrix
	declare function MatrixRotateY(byval angle as single) as Matrix
	declare function MatrixRotateZ(byval angle as single) as Matrix
	declare function MatrixScale(byval x as single, byval y as single, byval z as single) as Matrix
	declare function MatrixMultiply(byval left_ as Matrix, byval right_ as Matrix) as Matrix
	declare function MatrixFrustum(byval left_ as double, byval right_ as double, byval bottom as double, byval top as double, byval near as double, byval far as double) as Matrix
	declare function MatrixPerspective(byval fovy as double, byval aspect as double, byval near as double, byval far as double) as Matrix
	declare function MatrixOrtho(byval left_ as double, byval right_ as double, byval bottom as double, byval top as double, byval near as double, byval far as double) as Matrix
	declare function MatrixLookAt(byval eye as Vector3, byval target as Vector3, byval up as Vector3) as Matrix
	declare function MatrixToFloatV(byval mat as Matrix) as float16
	declare function QuaternionIdentity() as Quaternion
	declare function QuaternionLength(byval q as Quaternion) as single
	declare function QuaternionNormalize(byval q as Quaternion) as Quaternion
	declare function QuaternionInvert(byval q as Quaternion) as Quaternion
	declare function QuaternionMultiply(byval q1 as Quaternion, byval q2 as Quaternion) as Quaternion
	declare function QuaternionLerp(byval q1 as Quaternion, byval q2 as Quaternion, byval amount as single) as Quaternion
	declare function QuaternionNlerp(byval q1 as Quaternion, byval q2 as Quaternion, byval amount as single) as Quaternion
	declare function QuaternionSlerp(byval q1 as Quaternion, byval q2 as Quaternion, byval amount as single) as Quaternion
	declare function QuaternionFromVector3ToVector3(byval from as Vector3, byval to_ as Vector3) as Quaternion
	declare function QuaternionFromMatrix(byval mat as Matrix) as Quaternion
	declare function QuaternionToMatrix(byval q as Quaternion) as Matrix
	declare function QuaternionFromAxisAngle(byval axis as Vector3, byval angle as single) as Quaternion
	declare sub QuaternionToAxisAngle(byval q as Quaternion, byval outAxis as Vector3 ptr, byval outAngle as single ptr)
	declare function QuaternionFromEuler(byval roll as single, byval pitch as single, byval yaw as single) as Quaternion
	declare function QuaternionToEuler(byval q as Quaternion) as Vector3
	declare function QuaternionTransform(byval q as Quaternion, byval mat as Matrix) as Quaternion
#else
	private function Clamp(byval value as single, byval min as single, byval max as single) as single
		dim res as const single = iif(value < min, min, value)
		return iif(res > max, max, res)
	end function

	private function Lerp(byval start as single, byval end_ as single, byval amount as single) as single
		return start + (amount * (end_ - start))
	end function

	private function Vector2Zero() as Vector2
		dim result as Vector2 = (0.0f, 0.0f)
		return result
	end function

	private function Vector2One() as Vector2
		dim result as Vector2 = (1.0f, 1.0f)
		return result
	end function

	private function Vector2Add(byval v1 as Vector2, byval v2 as Vector2) as Vector2
		dim result as Vector2 = (v1.x + v2.x, v1.y + v2.y)
		return result
	end function

	private function Vector2Subtract(byval v1 as Vector2, byval v2 as Vector2) as Vector2
		dim result as Vector2 = (v1.x - v2.x, v1.y - v2.y)
		return result
	end function

	private function Vector2Length(byval v as Vector2) as single
		dim result as single = sqrtf((v.x * v.x) + (v.y * v.y))
		return result
	end function

	private function Vector2DotProduct(byval v1 as Vector2, byval v2 as Vector2) as single
		dim result as single = (v1.x * v2.x) + (v1.y * v2.y)
		return result
	end function

	private function Vector2Distance(byval v1 as Vector2, byval v2 as Vector2) as single
		dim result as single = sqrtf(((v1.x - v2.x) * (v1.x - v2.x)) + ((v1.y - v2.y) * (v1.y - v2.y)))
		return result
	end function

	private function Vector2Angle(byval v1 as Vector2, byval v2 as Vector2) as single
		dim result as single = atan2f(v2.y - v1.y, v2.x - v1.x) * (180.0f / PI)
		if result < 0 then
			result += 360.0f
		end if
		return result
	end function

	private function Vector2Scale(byval v as Vector2, byval scale as single) as Vector2
		dim result as Vector2 = (v.x * scale, v.y * scale)
		return result
	end function

	private function Vector2MultiplyV(byval v1 as Vector2, byval v2 as Vector2) as Vector2
		dim result as Vector2 = (v1.x * v2.x, v1.y * v2.y)
		return result
	end function

	private function Vector2Negate(byval v as Vector2) as Vector2
		dim result as Vector2 = (-v.x, -v.y)
		return result
	end function

	private function Vector2Divide(byval v as Vector2, byval div as single) as Vector2
		dim result as Vector2 = (v.x / div, v.y / div)
		return result
	end function

	private function Vector2DivideV(byval v1 as Vector2, byval v2 as Vector2) as Vector2
		dim result as Vector2 = (v1.x / v2.x, v1.y / v2.y)
		return result
	end function

	private function Vector2Normalize(byval v as Vector2) as Vector2
		dim result as Vector2 = Vector2Divide(v, Vector2Length(v))
		return result
	end function

	private function Vector2Lerp(byval v1 as Vector2, byval v2 as Vector2, byval amount as single) as Vector2
		dim result as Vector2
		result.x = v1.x + (amount * (v2.x - v1.x))
		result.y = v1.y + (amount * (v2.y - v1.y))
		return result
	end function

	private function Vector2Rotate(byval v as Vector2, byval degs as single) as Vector2
		dim rads as single = degs * DEG2RAD
		dim result as Vector2 = ((v.x * cosf(rads)) - (v.y * sinf(rads)), (v.x * sinf(rads)) + (v.y * cosf(rads)))
		return result
	end function

	private function Vector3Zero() as Vector3
		dim result as Vector3 = (0.0f, 0.0f, 0.0f)
		return result
	end function

	private function Vector3One() as Vector3
		dim result as Vector3 = (1.0f, 1.0f, 1.0f)
		return result
	end function

	private function Vector3Add(byval v1 as Vector3, byval v2 as Vector3) as Vector3
		dim result as Vector3 = (v1.x + v2.x, v1.y + v2.y, v1.z + v2.z)
		return result
	end function

	private function Vector3Subtract(byval v1 as Vector3, byval v2 as Vector3) as Vector3
		dim result as Vector3 = (v1.x - v2.x, v1.y - v2.y, v1.z - v2.z)
		return result
	end function

	private function Vector3Scale(byval v as Vector3, byval scalar as single) as Vector3
		dim result as Vector3 = (v.x * scalar, v.y * scalar, v.z * scalar)
		return result
	end function

	private function Vector3Multiply(byval v1 as Vector3, byval v2 as Vector3) as Vector3
		dim result as Vector3 = (v1.x * v2.x, v1.y * v2.y, v1.z * v2.z)
		return result
	end function

	private function Vector3CrossProduct(byval v1 as Vector3, byval v2 as Vector3) as Vector3
		dim result as Vector3 = ((v1.y * v2.z) - (v1.z * v2.y), (v1.z * v2.x) - (v1.x * v2.z), (v1.x * v2.y) - (v1.y * v2.x))
		return result
	end function

	private function Vector3Perpendicular(byval v as Vector3) as Vector3
		dim result as Vector3
		dim min as single = csng(fabs(v.x))
		dim cardinalAxis as Vector3 = (1.0f, 0.0f, 0.0f)
		if fabs(v.y) < min then
			min = csng(fabs(v.y))
			dim tmp as Vector3 = (0.0f, 1.0f, 0.0f)
			cardinalAxis = tmp
		end if
		if fabs(v.z) < min then
			dim tmp as Vector3 = (0.0f, 0.0f, 1.0f)
			cardinalAxis = tmp
		end if
		result = Vector3CrossProduct(v, cardinalAxis)
		return result
	end function

	private function Vector3Length(byval v as const Vector3) as single
		dim result as single = sqrtf(((v.x * v.x) + (v.y * v.y)) + (v.z * v.z))
		return result
	end function

	private function Vector3DotProduct(byval v1 as Vector3, byval v2 as Vector3) as single
		dim result as single = ((v1.x * v2.x) + (v1.y * v2.y)) + (v1.z * v2.z)
		return result
	end function

	private function Vector3Distance(byval v1 as Vector3, byval v2 as Vector3) as single
		dim dx as single = v2.x - v1.x
		dim dy as single = v2.y - v1.y
		dim dz as single = v2.z - v1.z
		dim result as single = sqrtf(((dx * dx) + (dy * dy)) + (dz * dz))
		return result
	end function

	private function Vector3Negate(byval v as Vector3) as Vector3
		dim result as Vector3 = (-v.x, -v.y, -v.z)
		return result
	end function

	private function Vector3Divide(byval v as Vector3, byval div as single) as Vector3
		dim result as Vector3 = (v.x / div, v.y / div, v.z / div)
		return result
	end function

	private function Vector3DivideV(byval v1 as Vector3, byval v2 as Vector3) as Vector3
		dim result as Vector3 = (v1.x / v2.x, v1.y / v2.y, v1.z / v2.z)
		return result
	end function

	private function Vector3Normalize(byval v as Vector3) as Vector3
		dim result as Vector3 = v
		dim length as single
		dim ilength as single
		length = Vector3Length(v)
		if length = 0.0f then
			length = 1.0f
		end if
		ilength = 1.0f / length
		result.x *= ilength
		result.y *= ilength
		result.z *= ilength
		return result
	end function

	private sub Vector3OrthoNormalize(byval v1 as Vector3 ptr, byval v2 as Vector3 ptr)
		(*v1) = Vector3Normalize(*v1)
		dim vn as Vector3 = Vector3CrossProduct(*v1, *v2)
		vn = Vector3Normalize(vn)
		(*v2) = Vector3CrossProduct(vn, *v1)
	end sub

	private function Vector3Transform(byval v as Vector3, byval mat as Matrix) as Vector3
		dim result as Vector3
		dim x as single = v.x
		dim y as single = v.y
		dim z as single = v.z
		result.x = (((mat.m0 * x) + (mat.m4 * y)) + (mat.m8 * z)) + mat.m12
		result.y = (((mat.m1 * x) + (mat.m5 * y)) + (mat.m9 * z)) + mat.m13
		result.z = (((mat.m2 * x) + (mat.m6 * y)) + (mat.m10 * z)) + mat.m14
		return result
	end function

	private function Vector3RotateByQuaternion(byval v as Vector3, byval q as Quaternion) as Vector3
		dim result as Vector3
		result.x = ((v.x * ((((q.x * q.x) + (q.w * q.w)) - (q.y * q.y)) - (q.z * q.z))) + (v.y * (((2 * q.x) * q.y) - ((2 * q.w) * q.z)))) + (v.z * (((2 * q.x) * q.z) + ((2 * q.w) * q.y)))
		result.y = ((v.x * (((2 * q.w) * q.z) + ((2 * q.x) * q.y))) + (v.y * ((((q.w * q.w) - (q.x * q.x)) + (q.y * q.y)) - (q.z * q.z)))) + (v.z * ((((-2) * q.w) * q.x) + ((2 * q.y) * q.z)))
		result.z = ((v.x * ((((-2) * q.w) * q.y) + ((2 * q.x) * q.z))) + (v.y * (((2 * q.w) * q.x) + ((2 * q.y) * q.z)))) + (v.z * ((((q.w * q.w) - (q.x * q.x)) - (q.y * q.y)) + (q.z * q.z)))
		return result
	end function

	private function Vector3Lerp(byval v1 as Vector3, byval v2 as Vector3, byval amount as single) as Vector3
		dim result as Vector3
		result.x = v1.x + (amount * (v2.x - v1.x))
		result.y = v1.y + (amount * (v2.y - v1.y))
		result.z = v1.z + (amount * (v2.z - v1.z))
		return result
	end function

	private function Vector3Reflect(byval v as Vector3, byval normal as Vector3) as Vector3
		dim result as Vector3
		dim dotProduct as single = Vector3DotProduct(v, normal)
		result.x = v.x - ((2.0f * normal.x) * dotProduct)
		result.y = v.y - ((2.0f * normal.y) * dotProduct)
		result.z = v.z - ((2.0f * normal.z) * dotProduct)
		return result
	end function

	private function Vector3Min(byval v1 as Vector3, byval v2 as Vector3) as Vector3
		dim result as Vector3
		result.x = fminf(v1.x, v2.x)
		result.y = fminf(v1.y, v2.y)
		result.z = fminf(v1.z, v2.z)
		return result
	end function

	private function Vector3Max(byval v1 as Vector3, byval v2 as Vector3) as Vector3
		dim result as Vector3
		result.x = fmaxf(v1.x, v2.x)
		result.y = fmaxf(v1.y, v2.y)
		result.z = fmaxf(v1.z, v2.z)
		return result
	end function

	private function Vector3Barycenter(byval p as Vector3, byval a as Vector3, byval b as Vector3, byval c as Vector3) as Vector3
		dim v0 as Vector3 = Vector3Subtract(b, a)
		dim v1 as Vector3 = Vector3Subtract(c, a)
		dim v2 as Vector3 = Vector3Subtract(p, a)
		dim d00 as single = Vector3DotProduct(v0, v0)
		dim d01 as single = Vector3DotProduct(v0, v1)
		dim d11 as single = Vector3DotProduct(v1, v1)
		dim d20 as single = Vector3DotProduct(v2, v0)
		dim d21 as single = Vector3DotProduct(v2, v1)
		dim denom as single = (d00 * d11) - (d01 * d01)
		dim result as Vector3
		result.y = ((d11 * d20) - (d01 * d21)) / denom
		result.z = ((d00 * d21) - (d01 * d20)) / denom
		result.x = 1.0f - (result.z + result.y)
		return result
	end function

	private function Vector3ToFloatV(byval v as Vector3) as float3
		dim buffer as float3
		buffer.v(0) = v.x
		buffer.v(1) = v.y
		buffer.v(2) = v.z
		return buffer
	end function

	private function MatrixDeterminant(byval mat as Matrix) as single
		dim a00 as single = mat.m0
		dim a01 as single = mat.m1
		dim a02 as single = mat.m2
		dim a03 as single = mat.m3
		dim a10 as single = mat.m4
		dim a11 as single = mat.m5
		dim a12 as single = mat.m6
		dim a13 as single = mat.m7
		dim a20 as single = mat.m8
		dim a21 as single = mat.m9
		dim a22 as single = mat.m10
		dim a23 as single = mat.m11
		dim a30 as single = mat.m12
		dim a31 as single = mat.m13
		dim a32 as single = mat.m14
		dim a33 as single = mat.m15
		dim result as single = (((((((((((((((((((((((((a30 * a21) * a12) * a03) - (((a20 * a31) * a12) * a03)) - (((a30 * a11) * a22) * a03)) + (((a10 * a31) * a22) * a03)) + (((a20 * a11) * a32) * a03)) - (((a10 * a21) * a32) * a03)) - (((a30 * a21) * a02) * a13)) + (((a20 * a31) * a02) * a13)) + (((a30 * a01) * a22) * a13)) - (((a00 * a31) * a22) * a13)) - (((a20 * a01) * a32) * a13)) + (((a00 * a21) * a32) * a13)) + (((a30 * a11) * a02) * a23)) - (((a10 * a31) * a02) * a23)) - (((a30 * a01) * a12) * a23)) + (((a00 * a31) * a12) * a23)) + (((a10 * a01) * a32) * a23)) - (((a00 * a11) * a32) * a23)) - (((a20 * a11) * a02) * a33)) + (((a10 * a21) * a02) * a33)) + (((a20 * a01) * a12) * a33)) - (((a00 * a21) * a12) * a33)) - (((a10 * a01) * a22) * a33)) + (((a00 * a11) * a22) * a33)
		return result
	end function

	private function MatrixTrace(byval mat as Matrix) as single
		dim result as single = ((mat.m0 + mat.m5) + mat.m10) + mat.m15
		return result
	end function

	private function MatrixTranspose(byval mat as Matrix) as Matrix
		dim result as Matrix
		result.m0 = mat.m0
		result.m1 = mat.m4
		result.m2 = mat.m8
		result.m3 = mat.m12
		result.m4 = mat.m1
		result.m5 = mat.m5
		result.m6 = mat.m9
		result.m7 = mat.m13
		result.m8 = mat.m2
		result.m9 = mat.m6
		result.m10 = mat.m10
		result.m11 = mat.m14
		result.m12 = mat.m3
		result.m13 = mat.m7
		result.m14 = mat.m11
		result.m15 = mat.m15
		return result
	end function

	private function MatrixInvert(byval mat as Matrix) as Matrix
		dim result as Matrix
		dim a00 as single = mat.m0
		dim a01 as single = mat.m1
		dim a02 as single = mat.m2
		dim a03 as single = mat.m3
		dim a10 as single = mat.m4
		dim a11 as single = mat.m5
		dim a12 as single = mat.m6
		dim a13 as single = mat.m7
		dim a20 as single = mat.m8
		dim a21 as single = mat.m9
		dim a22 as single = mat.m10
		dim a23 as single = mat.m11
		dim a30 as single = mat.m12
		dim a31 as single = mat.m13
		dim a32 as single = mat.m14
		dim a33 as single = mat.m15
		dim b00 as single = (a00 * a11) - (a01 * a10)
		dim b01 as single = (a00 * a12) - (a02 * a10)
		dim b02 as single = (a00 * a13) - (a03 * a10)
		dim b03 as single = (a01 * a12) - (a02 * a11)
		dim b04 as single = (a01 * a13) - (a03 * a11)
		dim b05 as single = (a02 * a13) - (a03 * a12)
		dim b06 as single = (a20 * a31) - (a21 * a30)
		dim b07 as single = (a20 * a32) - (a22 * a30)
		dim b08 as single = (a20 * a33) - (a23 * a30)
		dim b09 as single = (a21 * a32) - (a22 * a31)
		dim b10 as single = (a21 * a33) - (a23 * a31)
		dim b11 as single = (a22 * a33) - (a23 * a32)
		dim invDet as single = 1.0f / ((((((b00 * b11) - (b01 * b10)) + (b02 * b09)) + (b03 * b08)) - (b04 * b07)) + (b05 * b06))
		result.m0 = (((a11 * b11) - (a12 * b10)) + (a13 * b09)) * invDet
		result.m1 = ((((-a01) * b11) + (a02 * b10)) - (a03 * b09)) * invDet
		result.m2 = (((a31 * b05) - (a32 * b04)) + (a33 * b03)) * invDet
		result.m3 = ((((-a21) * b05) + (a22 * b04)) - (a23 * b03)) * invDet
		result.m4 = ((((-a10) * b11) + (a12 * b08)) - (a13 * b07)) * invDet
		result.m5 = (((a00 * b11) - (a02 * b08)) + (a03 * b07)) * invDet
		result.m6 = ((((-a30) * b05) + (a32 * b02)) - (a33 * b01)) * invDet
		result.m7 = (((a20 * b05) - (a22 * b02)) + (a23 * b01)) * invDet
		result.m8 = (((a10 * b10) - (a11 * b08)) + (a13 * b06)) * invDet
		result.m9 = ((((-a00) * b10) + (a01 * b08)) - (a03 * b06)) * invDet
		result.m10 = (((a30 * b04) - (a31 * b02)) + (a33 * b00)) * invDet
		result.m11 = ((((-a20) * b04) + (a21 * b02)) - (a23 * b00)) * invDet
		result.m12 = ((((-a10) * b09) + (a11 * b07)) - (a12 * b06)) * invDet
		result.m13 = (((a00 * b09) - (a01 * b07)) + (a02 * b06)) * invDet
		result.m14 = ((((-a30) * b03) + (a31 * b01)) - (a32 * b00)) * invDet
		result.m15 = (((a20 * b03) - (a21 * b01)) + (a22 * b00)) * invDet
		return result
	end function

	private function MatrixNormalize(byval mat as Matrix) as Matrix
		dim result as Matrix
		dim det as single = MatrixDeterminant(mat)
		result.m0 = mat.m0 / det
		result.m1 = mat.m1 / det
		result.m2 = mat.m2 / det
		result.m3 = mat.m3 / det
		result.m4 = mat.m4 / det
		result.m5 = mat.m5 / det
		result.m6 = mat.m6 / det
		result.m7 = mat.m7 / det
		result.m8 = mat.m8 / det
		result.m9 = mat.m9 / det
		result.m10 = mat.m10 / det
		result.m11 = mat.m11 / det
		result.m12 = mat.m12 / det
		result.m13 = mat.m13 / det
		result.m14 = mat.m14 / det
		result.m15 = mat.m15 / det
		return result
	end function

	private function MatrixIdentity() as Matrix
		dim result as Matrix = (1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f)
		return result
	end function

	private function MatrixAdd(byval left_ as Matrix, byval right_ as Matrix) as Matrix
		dim result as Matrix = MatrixIdentity()
		result.m0 = left_.m0 + right_.m0
		result.m1 = left_.m1 + right_.m1
		result.m2 = left_.m2 + right_.m2
		result.m3 = left_.m3 + right_.m3
		result.m4 = left_.m4 + right_.m4
		result.m5 = left_.m5 + right_.m5
		result.m6 = left_.m6 + right_.m6
		result.m7 = left_.m7 + right_.m7
		result.m8 = left_.m8 + right_.m8
		result.m9 = left_.m9 + right_.m9
		result.m10 = left_.m10 + right_.m10
		result.m11 = left_.m11 + right_.m11
		result.m12 = left_.m12 + right_.m12
		result.m13 = left_.m13 + right_.m13
		result.m14 = left_.m14 + right_.m14
		result.m15 = left_.m15 + right_.m15
		return result
	end function

	private function MatrixSubtract(byval left_ as Matrix, byval right_ as Matrix) as Matrix
		dim result as Matrix = MatrixIdentity()
		result.m0 = left_.m0 - right_.m0
		result.m1 = left_.m1 - right_.m1
		result.m2 = left_.m2 - right_.m2
		result.m3 = left_.m3 - right_.m3
		result.m4 = left_.m4 - right_.m4
		result.m5 = left_.m5 - right_.m5
		result.m6 = left_.m6 - right_.m6
		result.m7 = left_.m7 - right_.m7
		result.m8 = left_.m8 - right_.m8
		result.m9 = left_.m9 - right_.m9
		result.m10 = left_.m10 - right_.m10
		result.m11 = left_.m11 - right_.m11
		result.m12 = left_.m12 - right_.m12
		result.m13 = left_.m13 - right_.m13
		result.m14 = left_.m14 - right_.m14
		result.m15 = left_.m15 - right_.m15
		return result
	end function

	private function MatrixTranslate(byval x as single, byval y as single, byval z as single) as Matrix
		dim result as Matrix = (1.0f, 0.0f, 0.0f, x, 0.0f, 1.0f, 0.0f, y, 0.0f, 0.0f, 1.0f, z, 0.0f, 0.0f, 0.0f, 1.0f)
		return result
	end function

	private function MatrixRotate(byval axis as Vector3, byval angle as single) as Matrix
		dim result as Matrix
		dim x as single = axis.x
		dim y as single = axis.y
		dim z as single = axis.z
		dim length as single = sqrtf(((x * x) + (y * y)) + (z * z))
		if (length <> 1.0f) andalso (length <> 0.0f) then
			length = 1.0f / length
			x *= length
			y *= length
			z *= length
		end if
		dim sinres as single = sinf(angle)
		dim cosres as single = cosf(angle)
		dim t as single = 1.0f - cosres
		result.m0 = ((x * x) * t) + cosres
		result.m1 = ((y * x) * t) + (z * sinres)
		result.m2 = ((z * x) * t) - (y * sinres)
		result.m3 = 0.0f
		result.m4 = ((x * y) * t) - (z * sinres)
		result.m5 = ((y * y) * t) + cosres
		result.m6 = ((z * y) * t) + (x * sinres)
		result.m7 = 0.0f
		result.m8 = ((x * z) * t) + (y * sinres)
		result.m9 = ((y * z) * t) - (x * sinres)
		result.m10 = ((z * z) * t) + cosres
		result.m11 = 0.0f
		result.m12 = 0.0f
		result.m13 = 0.0f
		result.m14 = 0.0f
		result.m15 = 1.0f
		return result
	end function

	private function MatrixRotateXYZ(byval ang as Vector3) as Matrix
		dim result as Matrix = MatrixIdentity()
		dim cosz as single = cosf(-ang.z)
		dim sinz as single = sinf(-ang.z)
		dim cosy as single = cosf(-ang.y)
		dim siny as single = sinf(-ang.y)
		dim cosx as single = cosf(-ang.x)
		dim sinx as single = sinf(-ang.x)
		result.m0 = cosz * cosy
		result.m4 = ((cosz * siny) * sinx) - (sinz * cosx)
		result.m8 = ((cosz * siny) * cosx) + (sinz * sinx)
		result.m1 = sinz * cosy
		result.m5 = ((sinz * siny) * sinx) + (cosz * cosx)
		result.m9 = ((sinz * siny) * cosx) - (cosz * sinx)
		result.m2 = -siny
		result.m6 = cosy * sinx
		result.m10 = cosy * cosx
		return result
	end function

	private function MatrixRotateX(byval angle as single) as Matrix
		dim result as Matrix = MatrixIdentity()
		dim cosres as single = cosf(angle)
		dim sinres as single = sinf(angle)
		result.m5 = cosres
		result.m6 = -sinres
		result.m9 = sinres
		result.m10 = cosres
		return result
	end function

	private function MatrixRotateY(byval angle as single) as Matrix
		dim result as Matrix = MatrixIdentity()
		dim cosres as single = cosf(angle)
		dim sinres as single = sinf(angle)
		result.m0 = cosres
		result.m2 = sinres
		result.m8 = -sinres
		result.m10 = cosres
		return result
	end function

	private function MatrixRotateZ(byval angle as single) as Matrix
		dim result as Matrix = MatrixIdentity()
		dim cosres as single = cosf(angle)
		dim sinres as single = sinf(angle)
		result.m0 = cosres
		result.m1 = -sinres
		result.m4 = sinres
		result.m5 = cosres
		return result
	end function

	private function MatrixScale(byval x as single, byval y as single, byval z as single) as Matrix
		dim result as Matrix = (x, 0.0f, 0.0f, 0.0f, 0.0f, y, 0.0f, 0.0f, 0.0f, 0.0f, z, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f)
		return result
	end function

	private function MatrixMultiply(byval left_ as Matrix, byval right_ as Matrix) as Matrix
		dim result as Matrix
		result.m0 = (((left_.m0 * right_.m0) + (left_.m1 * right_.m4)) + (left_.m2 * right_.m8)) + (left_.m3 * right_.m12)
		result.m1 = (((left_.m0 * right_.m1) + (left_.m1 * right_.m5)) + (left_.m2 * right_.m9)) + (left_.m3 * right_.m13)
		result.m2 = (((left_.m0 * right_.m2) + (left_.m1 * right_.m6)) + (left_.m2 * right_.m10)) + (left_.m3 * right_.m14)
		result.m3 = (((left_.m0 * right_.m3) + (left_.m1 * right_.m7)) + (left_.m2 * right_.m11)) + (left_.m3 * right_.m15)
		result.m4 = (((left_.m4 * right_.m0) + (left_.m5 * right_.m4)) + (left_.m6 * right_.m8)) + (left_.m7 * right_.m12)
		result.m5 = (((left_.m4 * right_.m1) + (left_.m5 * right_.m5)) + (left_.m6 * right_.m9)) + (left_.m7 * right_.m13)
		result.m6 = (((left_.m4 * right_.m2) + (left_.m5 * right_.m6)) + (left_.m6 * right_.m10)) + (left_.m7 * right_.m14)
		result.m7 = (((left_.m4 * right_.m3) + (left_.m5 * right_.m7)) + (left_.m6 * right_.m11)) + (left_.m7 * right_.m15)
		result.m8 = (((left_.m8 * right_.m0) + (left_.m9 * right_.m4)) + (left_.m10 * right_.m8)) + (left_.m11 * right_.m12)
		result.m9 = (((left_.m8 * right_.m1) + (left_.m9 * right_.m5)) + (left_.m10 * right_.m9)) + (left_.m11 * right_.m13)
		result.m10 = (((left_.m8 * right_.m2) + (left_.m9 * right_.m6)) + (left_.m10 * right_.m10)) + (left_.m11 * right_.m14)
		result.m11 = (((left_.m8 * right_.m3) + (left_.m9 * right_.m7)) + (left_.m10 * right_.m11)) + (left_.m11 * right_.m15)
		result.m12 = (((left_.m12 * right_.m0) + (left_.m13 * right_.m4)) + (left_.m14 * right_.m8)) + (left_.m15 * right_.m12)
		result.m13 = (((left_.m12 * right_.m1) + (left_.m13 * right_.m5)) + (left_.m14 * right_.m9)) + (left_.m15 * right_.m13)
		result.m14 = (((left_.m12 * right_.m2) + (left_.m13 * right_.m6)) + (left_.m14 * right_.m10)) + (left_.m15 * right_.m14)
		result.m15 = (((left_.m12 * right_.m3) + (left_.m13 * right_.m7)) + (left_.m14 * right_.m11)) + (left_.m15 * right_.m15)
		return result
	end function

	private function MatrixFrustum(byval left_ as double, byval right_ as double, byval bottom as double, byval top as double, byval near as double, byval far as double) as Matrix
		dim result as Matrix
		dim rl as single = csng(right_ - left_)
		dim tb as single = csng(top - bottom)
		dim fn as single = csng(far - near)
		result.m0 = (csng(near) * 2.0f) / rl
		result.m1 = 0.0f
		result.m2 = 0.0f
		result.m3 = 0.0f
		result.m4 = 0.0f
		result.m5 = (csng(near) * 2.0f) / tb
		result.m6 = 0.0f
		result.m7 = 0.0f
		result.m8 = (csng(right_) + csng(left_)) / rl
		result.m9 = (csng(top) + csng(bottom)) / tb
		result.m10 = (-(csng(far) + csng(near))) / fn
		result.m11 = -1.0f
		result.m12 = 0.0f
		result.m13 = 0.0f
		result.m14 = (-((csng(far) * csng(near)) * 2.0f)) / fn
		result.m15 = 0.0f
		return result
	end function

	private function MatrixPerspective(byval fovy as double, byval aspect as double, byval near as double, byval far as double) as Matrix
		dim top as double = near * tan(fovy * 0.5)
		dim right_ as double = top * aspect
		dim result as Matrix = MatrixFrustum(-right_, right_, -top, top, near, far)
		return result
	end function

	private function MatrixOrtho(byval left_ as double, byval right_ as double, byval bottom as double, byval top as double, byval near as double, byval far as double) as Matrix
		dim result as Matrix
		dim rl as single = csng(right_ - left_)
		dim tb as single = csng(top - bottom)
		dim fn as single = csng(far - near)
		result.m0 = 2.0f / rl
		result.m1 = 0.0f
		result.m2 = 0.0f
		result.m3 = 0.0f
		result.m4 = 0.0f
		result.m5 = 2.0f / tb
		result.m6 = 0.0f
		result.m7 = 0.0f
		result.m8 = 0.0f
		result.m9 = 0.0f
		result.m10 = (-2.0f) / fn
		result.m11 = 0.0f
		result.m12 = (-(csng(left_) + csng(right_))) / rl
		result.m13 = (-(csng(top) + csng(bottom))) / tb
		result.m14 = (-(csng(far) + csng(near))) / fn
		result.m15 = 1.0f
		return result
	end function

	private function MatrixLookAt(byval eye as Vector3, byval target as Vector3, byval up as Vector3) as Matrix
		dim result as Matrix
		dim z as Vector3 = Vector3Subtract(eye, target)
		z = Vector3Normalize(z)
		dim x as Vector3 = Vector3CrossProduct(up, z)
		x = Vector3Normalize(x)
		dim y as Vector3 = Vector3CrossProduct(z, x)
		y = Vector3Normalize(y)
		result.m0 = x.x
		result.m1 = x.y
		result.m2 = x.z
		result.m3 = 0.0f
		result.m4 = y.x
		result.m5 = y.y
		result.m6 = y.z
		result.m7 = 0.0f
		result.m8 = z.x
		result.m9 = z.y
		result.m10 = z.z
		result.m11 = 0.0f
		result.m12 = eye.x
		result.m13 = eye.y
		result.m14 = eye.z
		result.m15 = 1.0f
		result = MatrixInvert(result)
		return result
	end function

	private function MatrixToFloatV(byval mat as Matrix) as float16
		dim buffer as float16
		buffer.v(0) = mat.m0
		buffer.v(1) = mat.m1
		buffer.v(2) = mat.m2
		buffer.v(3) = mat.m3
		buffer.v(4) = mat.m4
		buffer.v(5) = mat.m5
		buffer.v(6) = mat.m6
		buffer.v(7) = mat.m7
		buffer.v(8) = mat.m8
		buffer.v(9) = mat.m9
		buffer.v(10) = mat.m10
		buffer.v(11) = mat.m11
		buffer.v(12) = mat.m12
		buffer.v(13) = mat.m13
		buffer.v(14) = mat.m14
		buffer.v(15) = mat.m15
		return buffer
	end function

	private function QuaternionIdentity() as Quaternion
		dim result as Quaternion = (0.0f, 0.0f, 0.0f, 1.0f)
		return result
	end function

	private function QuaternionLength(byval q as Quaternion) as single
		dim result as single = csng(sqrt((((q.x * q.x) + (q.y * q.y)) + (q.z * q.z)) + (q.w * q.w)))
		return result
	end function

	private function QuaternionNormalize(byval q as Quaternion) as Quaternion
		dim result as Quaternion
		dim length as single
		dim ilength as single
		length = QuaternionLength(q)
		if length = 0.0f then
			length = 1.0f
		end if
		ilength = 1.0f / length
		result.x = q.x * ilength
		result.y = q.y * ilength
		result.z = q.z * ilength
		result.w = q.w * ilength
		return result
	end function

	private function QuaternionInvert(byval q as Quaternion) as Quaternion
		dim result as Quaternion = q
		dim length as single = QuaternionLength(q)
		dim lengthSq as single = length * length
		if lengthSq <> 0.0 then
			dim i as single = 1.0f / lengthSq
			result.x *= -i
			result.y *= -i
			result.z *= -i
			result.w *= i
		end if
		return result
	end function

	private function QuaternionMultiply(byval q1 as Quaternion, byval q2 as Quaternion) as Quaternion
		dim result as Quaternion
		dim qax as single = q1.x
		dim qay as single = q1.y
		dim qaz as single = q1.z
		dim qaw as single = q1.w
		dim qbx as single = q2.x
		dim qby as single = q2.y
		dim qbz as single = q2.z
		dim qbw as single = q2.w
		result.x = (((qax * qbw) + (qaw * qbx)) + (qay * qbz)) - (qaz * qby)
		result.y = (((qay * qbw) + (qaw * qby)) + (qaz * qbx)) - (qax * qbz)
		result.z = (((qaz * qbw) + (qaw * qbz)) + (qax * qby)) - (qay * qbx)
		result.w = (((qaw * qbw) - (qax * qbx)) - (qay * qby)) - (qaz * qbz)
		return result
	end function

	private function QuaternionLerp(byval q1 as Quaternion, byval q2 as Quaternion, byval amount as single) as Quaternion
		dim result as Quaternion
		result.x = q1.x + (amount * (q2.x - q1.x))
		result.y = q1.y + (amount * (q2.y - q1.y))
		result.z = q1.z + (amount * (q2.z - q1.z))
		result.w = q1.w + (amount * (q2.w - q1.w))
		return result
	end function

	private function QuaternionNlerp(byval q1 as Quaternion, byval q2 as Quaternion, byval amount as single) as Quaternion
		dim result as Quaternion = QuaternionLerp(q1, q2, amount)
		result = QuaternionNormalize(result)
		return result
	end function

	private function QuaternionSlerp(byval q1 as Quaternion, byval q2 as Quaternion, byval amount as single) as Quaternion
		dim result as Quaternion
		dim cosHalfTheta as single = (((q1.x * q2.x) + (q1.y * q2.y)) + (q1.z * q2.z)) + (q1.w * q2.w)
		if fabs(cosHalfTheta) >= 1.0f then
			result = q1
		elseif cosHalfTheta > 0.95f then
			result = QuaternionNlerp(q1, q2, amount)
		else
			dim halfTheta as single = acosf(cosHalfTheta)
			dim sinHalfTheta as single = sqrtf(1.0f - (cosHalfTheta * cosHalfTheta))
			if fabs(sinHalfTheta) < 0.001f then
				result.x = (q1.x * 0.5f) + (q2.x * 0.5f)
				result.y = (q1.y * 0.5f) + (q2.y * 0.5f)
				result.z = (q1.z * 0.5f) + (q2.z * 0.5f)
				result.w = (q1.w * 0.5f) + (q2.w * 0.5f)
			else
				dim ratioA as single = sinf((1 - amount) * halfTheta) / sinHalfTheta
				dim ratioB as single = sinf(amount * halfTheta) / sinHalfTheta
				result.x = (q1.x * ratioA) + (q2.x * ratioB)
				result.y = (q1.y * ratioA) + (q2.y * ratioB)
				result.z = (q1.z * ratioA) + (q2.z * ratioB)
				result.w = (q1.w * ratioA) + (q2.w * ratioB)
			end if
		end if
		return result
	end function

	private function QuaternionFromVector3ToVector3(byval from as Vector3, byval to_ as Vector3) as Quaternion
		dim result as Quaternion
		dim cos2Theta as single = Vector3DotProduct(from, to_)
		dim cross as Vector3 = Vector3CrossProduct(from, to_)
		result.x = cross.x
		result.y = cross.y
		result.z = cross.y
		result.w = 1.0f + cos2Theta
		result = QuaternionNormalize(result)
		return result
	end function

	private function QuaternionFromMatrix(byval mat as Matrix) as Quaternion
		dim result as Quaternion
		dim trace as single = MatrixTrace(mat)
		if trace > 0.0f then
			dim s as single = sqrtf(trace + 1) * 2.0f
			dim invS as single = 1.0f / s
			result.w = s * 0.25f
			result.x = (mat.m6 - mat.m9) * invS
			result.y = (mat.m8 - mat.m2) * invS
			result.z = (mat.m1 - mat.m4) * invS
		else
			dim m00 as single = mat.m0
			dim m11 as single = mat.m5
			dim m22 as single = mat.m10
			if (m00 > m11) andalso (m00 > m22) then
				dim s as single = csng(sqrt(((1.0f + m00) - m11) - m22)) * 2.0f
				dim invS as single = 1.0f / s
				result.w = (mat.m6 - mat.m9) * invS
				result.x = s * 0.25f
				result.y = (mat.m4 + mat.m1) * invS
				result.z = (mat.m8 + mat.m2) * invS
			elseif m11 > m22 then
				dim s as single = sqrtf(((1.0f + m11) - m00) - m22) * 2.0f
				dim invS as single = 1.0f / s
				result.w = (mat.m8 - mat.m2) * invS
				result.x = (mat.m4 + mat.m1) * invS
				result.y = s * 0.25f
				result.z = (mat.m9 + mat.m6) * invS
			else
				dim s as single = sqrtf(((1.0f + m22) - m00) - m11) * 2.0f
				dim invS as single = 1.0f / s
				result.w = (mat.m1 - mat.m4) * invS
				result.x = (mat.m8 + mat.m2) * invS
				result.y = (mat.m9 + mat.m6) * invS
				result.z = s * 0.25f
			end if
		end if
		return result
	end function

	private function QuaternionToMatrix(byval q as Quaternion) as Matrix
		dim result as Matrix
		dim x as single = q.x
		dim y as single = q.y
		dim z as single = q.z
		dim w as single = q.w
		dim x2 as single = x + x
		dim y2 as single = y + y
		dim z2 as single = z + z
		dim length as single = QuaternionLength(q)
		dim lengthSquared as single = length * length
		dim xx as single = (x * x2) / lengthSquared
		dim xy as single = (x * y2) / lengthSquared
		dim xz as single = (x * z2) / lengthSquared
		dim yy as single = (y * y2) / lengthSquared
		dim yz as single = (y * z2) / lengthSquared
		dim zz as single = (z * z2) / lengthSquared
		dim wx as single = (w * x2) / lengthSquared
		dim wy as single = (w * y2) / lengthSquared
		dim wz as single = (w * z2) / lengthSquared
		result.m0 = 1.0f - (yy + zz)
		result.m1 = xy - wz
		result.m2 = xz + wy
		result.m3 = 0.0f
		result.m4 = xy + wz
		result.m5 = 1.0f - (xx + zz)
		result.m6 = yz - wx
		result.m7 = 0.0f
		result.m8 = xz - wy
		result.m9 = yz + wx
		result.m10 = 1.0f - (xx + yy)
		result.m11 = 0.0f
		result.m12 = 0.0f
		result.m13 = 0.0f
		result.m14 = 0.0f
		result.m15 = 1.0f
		return result
	end function

	private function QuaternionFromAxisAngle(byval axis as Vector3, byval angle as single) as Quaternion
		dim result as Quaternion = (0.0f, 0.0f, 0.0f, 1.0f)
		if Vector3Length(axis) <> 0.0f then
			angle *= 0.5f
		end if
		axis = Vector3Normalize(axis)
		dim sinres as single = sinf(angle)
		dim cosres as single = cosf(angle)
		result.x = axis.x * sinres
		result.y = axis.y * sinres
		result.z = axis.z * sinres
		result.w = cosres
		result = QuaternionNormalize(result)
		return result
	end function

	private sub QuaternionToAxisAngle(byval q as Quaternion, byval outAxis as Vector3 ptr, byval outAngle as single ptr)
		if fabs(q.w) > 1.0f then
			q = QuaternionNormalize(q)
		end if
		dim resAxis as Vector3 = (0.0f, 0.0f, 0.0f)
		dim resAngle as single = 2.0f * acosf(q.w)
		dim den as single = sqrtf(1.0f - (q.w * q.w))
		if den > 0.0001f then
			resAxis.x = q.x / den
			resAxis.y = q.y / den
			resAxis.z = q.z / den
		else
			resAxis.x = 1.0f
		end if
		(*outAxis) = resAxis
		(*outAngle) = resAngle
	end sub

	private function QuaternionFromEuler(byval roll as single, byval pitch as single, byval yaw as single) as Quaternion
		dim q as Quaternion
		dim x0 as single = cosf(roll * 0.5f)
		dim x1 as single = sinf(roll * 0.5f)
		dim y0 as single = cosf(pitch * 0.5f)
		dim y1 as single = sinf(pitch * 0.5f)
		dim z0 as single = cosf(yaw * 0.5f)
		dim z1 as single = sinf(yaw * 0.5f)
		q.x = ((x1 * y0) * z0) - ((x0 * y1) * z1)
		q.y = ((x0 * y1) * z0) + ((x1 * y0) * z1)
		q.z = ((x0 * y0) * z1) - ((x1 * y1) * z0)
		q.w = ((x0 * y0) * z0) + ((x1 * y1) * z1)
		return q
	end function

	private function QuaternionToEuler(byval q as Quaternion) as Vector3
		dim result as Vector3
		dim x0 as single = 2.0f * ((q.w * q.x) + (q.y * q.z))
		dim x1 as single = 1.0f - (2.0f * ((q.x * q.x) + (q.y * q.y)))
		result.x = atan2f(x0, x1) * RAD2DEG
		dim y0 as single = 2.0f * ((q.w * q.y) - (q.z * q.x))
		y0 = iif(y0 > 1.0f, 1.0f, y0)
		y0 = iif(y0 < (-1.0f), -1.0f, y0)
		result.y = asinf(y0) * RAD2DEG
		dim z0 as single = 2.0f * ((q.w * q.z) + (q.x * q.y))
		dim z1 as single = 1.0f - (2.0f * ((q.y * q.y) + (q.z * q.z)))
		result.z = atan2f(z0, z1) * RAD2DEG
		return result
	end function

	private function QuaternionTransform(byval q as Quaternion, byval mat as Matrix) as Quaternion
		dim result as Quaternion
		result.x = (((mat.m0 * q.x) + (mat.m4 * q.y)) + (mat.m8 * q.z)) + (mat.m12 * q.w)
		result.y = (((mat.m1 * q.x) + (mat.m5 * q.y)) + (mat.m9 * q.z)) + (mat.m13 * q.w)
		result.z = (((mat.m2 * q.x) + (mat.m6 * q.y)) + (mat.m10 * q.z)) + (mat.m14 * q.w)
		result.w = (((mat.m3 * q.x) + (mat.m7 * q.y)) + (mat.m11 * q.z)) + (mat.m15 * q.w)
		return result
	end function
#endif

end extern
