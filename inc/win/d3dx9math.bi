'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   Copyright (C) 2007 David Adam
''   Copyright (C) 2007 Tony Wasserka
''
''   This library is free software; you can redistribute it and/or
''   modify it under the terms of the GNU Lesser General Public
''   License as published by the Free Software Foundation; either
''   version 2.1 of the License, or (at your option) any later version.
''
''   This library is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
''   Lesser General Public License for more details.
''
''   You should have received a copy of the GNU Lesser General Public
''   License along with this library; if not, write to the Free Software
''   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "d3dx9.bi"
#include once "crt/math.bi"
#include once "d3dx9math.bi"

extern "Windows"

#define __D3DX9MATH_H__
const D3DX_PI = cast(FLOAT, 3.141592654)
const D3DX_1BYPI = cast(FLOAT, 0.318309886)
const D3DXSH_MINORDER = 2
const D3DXSH_MAXORDER = 6
#define D3DXToRadian(degree) ((degree) * (D3DX_PI / 180.0f))
#define D3DXToDegree(radian) ((radian) * (180.0f / D3DX_PI))

type D3DXVECTOR2
	x as FLOAT
	y as FLOAT
end type

type LPD3DXVECTOR2 as D3DXVECTOR2 ptr
type D3DXVECTOR3 as _D3DVECTOR
type LPD3DXVECTOR3 as _D3DVECTOR ptr

type D3DXVECTOR4
	x as FLOAT
	y as FLOAT
	z as FLOAT
	w as FLOAT
end type

type LPD3DXVECTOR4 as D3DXVECTOR4 ptr
type D3DXMATRIX as _D3DMATRIX
type LPD3DXMATRIX as _D3DMATRIX ptr

type D3DXQUATERNION
	x as FLOAT
	y as FLOAT
	z as FLOAT
	w as FLOAT
end type

type LPD3DXQUATERNION as D3DXQUATERNION ptr

type D3DXPLANE
	a as FLOAT
	b as FLOAT
	c as FLOAT
	d as FLOAT
end type

type LPD3DXPLANE as D3DXPLANE ptr

type D3DXCOLOR
	r as FLOAT
	g as FLOAT
	b as FLOAT
	a as FLOAT
end type

type LPD3DXCOLOR as D3DXCOLOR ptr

type D3DXFLOAT16
	value as WORD
end type

type LPD3DXFLOAT16 as D3DXFLOAT16 ptr
declare function D3DXColorAdjustContrast(byval pout as D3DXCOLOR ptr, byval pc as const D3DXCOLOR ptr, byval s as FLOAT) as D3DXCOLOR ptr
declare function D3DXColorAdjustSaturation(byval pout as D3DXCOLOR ptr, byval pc as const D3DXCOLOR ptr, byval s as FLOAT) as D3DXCOLOR ptr
declare function D3DXFresnelTerm(byval costheta as FLOAT, byval refractionindex as FLOAT) as FLOAT
declare function D3DXMatrixAffineTransformation(byval pout as D3DXMATRIX ptr, byval scaling as FLOAT, byval rotationcenter as const D3DXVECTOR3 ptr, byval rotation as const D3DXQUATERNION ptr, byval translation as const D3DXVECTOR3 ptr) as D3DXMATRIX ptr
declare function D3DXMatrixAffineTransformation2D(byval pout as D3DXMATRIX ptr, byval scaling as FLOAT, byval protationcenter as const D3DXVECTOR2 ptr, byval rotation as FLOAT, byval ptranslation as const D3DXVECTOR2 ptr) as D3DXMATRIX ptr
declare function D3DXMatrixDecompose(byval poutscale as D3DXVECTOR3 ptr, byval poutrotation as D3DXQUATERNION ptr, byval pouttranslation as D3DXVECTOR3 ptr, byval pm as const D3DXMATRIX ptr) as HRESULT
declare function D3DXMatrixDeterminant(byval pm as const D3DXMATRIX ptr) as FLOAT
declare function D3DXMatrixInverse(byval pout as D3DXMATRIX ptr, byval pdeterminant as FLOAT ptr, byval pm as const D3DXMATRIX ptr) as D3DXMATRIX ptr
declare function D3DXMatrixLookAtLH(byval pout as D3DXMATRIX ptr, byval peye as const D3DXVECTOR3 ptr, byval pat as const D3DXVECTOR3 ptr, byval pup as const D3DXVECTOR3 ptr) as D3DXMATRIX ptr
declare function D3DXMatrixLookAtRH(byval pout as D3DXMATRIX ptr, byval peye as const D3DXVECTOR3 ptr, byval pat as const D3DXVECTOR3 ptr, byval pup as const D3DXVECTOR3 ptr) as D3DXMATRIX ptr
declare function D3DXMatrixMultiply(byval pout as D3DXMATRIX ptr, byval pm1 as const D3DXMATRIX ptr, byval pm2 as const D3DXMATRIX ptr) as D3DXMATRIX ptr
declare function D3DXMatrixMultiplyTranspose(byval pout as D3DXMATRIX ptr, byval pm1 as const D3DXMATRIX ptr, byval pm2 as const D3DXMATRIX ptr) as D3DXMATRIX ptr
declare function D3DXMatrixOrthoLH(byval pout as D3DXMATRIX ptr, byval w as FLOAT, byval h as FLOAT, byval zn as FLOAT, byval zf as FLOAT) as D3DXMATRIX ptr
declare function D3DXMatrixOrthoOffCenterLH(byval pout as D3DXMATRIX ptr, byval l as FLOAT, byval r as FLOAT, byval b as FLOAT, byval t as FLOAT, byval zn as FLOAT, byval zf as FLOAT) as D3DXMATRIX ptr
declare function D3DXMatrixOrthoOffCenterRH(byval pout as D3DXMATRIX ptr, byval l as FLOAT, byval r as FLOAT, byval b as FLOAT, byval t as FLOAT, byval zn as FLOAT, byval zf as FLOAT) as D3DXMATRIX ptr
declare function D3DXMatrixOrthoRH(byval pout as D3DXMATRIX ptr, byval w as FLOAT, byval h as FLOAT, byval zn as FLOAT, byval zf as FLOAT) as D3DXMATRIX ptr
declare function D3DXMatrixPerspectiveFovLH(byval pout as D3DXMATRIX ptr, byval fovy as FLOAT, byval aspect as FLOAT, byval zn as FLOAT, byval zf as FLOAT) as D3DXMATRIX ptr
declare function D3DXMatrixPerspectiveFovRH(byval pout as D3DXMATRIX ptr, byval fovy as FLOAT, byval aspect as FLOAT, byval zn as FLOAT, byval zf as FLOAT) as D3DXMATRIX ptr
declare function D3DXMatrixPerspectiveLH(byval pout as D3DXMATRIX ptr, byval w as FLOAT, byval h as FLOAT, byval zn as FLOAT, byval zf as FLOAT) as D3DXMATRIX ptr
declare function D3DXMatrixPerspectiveOffCenterLH(byval pout as D3DXMATRIX ptr, byval l as FLOAT, byval r as FLOAT, byval b as FLOAT, byval t as FLOAT, byval zn as FLOAT, byval zf as FLOAT) as D3DXMATRIX ptr
declare function D3DXMatrixPerspectiveOffCenterRH(byval pout as D3DXMATRIX ptr, byval l as FLOAT, byval r as FLOAT, byval b as FLOAT, byval t as FLOAT, byval zn as FLOAT, byval zf as FLOAT) as D3DXMATRIX ptr
declare function D3DXMatrixPerspectiveRH(byval pout as D3DXMATRIX ptr, byval w as FLOAT, byval h as FLOAT, byval zn as FLOAT, byval zf as FLOAT) as D3DXMATRIX ptr
declare function D3DXMatrixReflect(byval pout as D3DXMATRIX ptr, byval pplane as const D3DXPLANE ptr) as D3DXMATRIX ptr
declare function D3DXMatrixRotationAxis(byval pout as D3DXMATRIX ptr, byval pv as const D3DXVECTOR3 ptr, byval angle as FLOAT) as D3DXMATRIX ptr
declare function D3DXMatrixRotationQuaternion(byval pout as D3DXMATRIX ptr, byval pq as const D3DXQUATERNION ptr) as D3DXMATRIX ptr
declare function D3DXMatrixRotationX(byval pout as D3DXMATRIX ptr, byval angle as FLOAT) as D3DXMATRIX ptr
declare function D3DXMatrixRotationY(byval pout as D3DXMATRIX ptr, byval angle as FLOAT) as D3DXMATRIX ptr
declare function D3DXMatrixRotationYawPitchRoll(byval pout as D3DXMATRIX ptr, byval yaw as FLOAT, byval pitch as FLOAT, byval roll as FLOAT) as D3DXMATRIX ptr
declare function D3DXMatrixRotationZ(byval pout as D3DXMATRIX ptr, byval angle as FLOAT) as D3DXMATRIX ptr
declare function D3DXMatrixScaling(byval pout as D3DXMATRIX ptr, byval sx as FLOAT, byval sy as FLOAT, byval sz as FLOAT) as D3DXMATRIX ptr
declare function D3DXMatrixShadow(byval pout as D3DXMATRIX ptr, byval plight as const D3DXVECTOR4 ptr, byval pPlane as const D3DXPLANE ptr) as D3DXMATRIX ptr
declare function D3DXMatrixTransformation(byval pout as D3DXMATRIX ptr, byval pscalingcenter as const D3DXVECTOR3 ptr, byval pscalingrotation as const D3DXQUATERNION ptr, byval pscaling as const D3DXVECTOR3 ptr, byval protationcenter as const D3DXVECTOR3 ptr, byval protation as const D3DXQUATERNION ptr, byval ptranslation as const D3DXVECTOR3 ptr) as D3DXMATRIX ptr
declare function D3DXMatrixTransformation2D(byval pout as D3DXMATRIX ptr, byval pscalingcenter as const D3DXVECTOR2 ptr, byval scalingrotation as FLOAT, byval pscaling as const D3DXVECTOR2 ptr, byval protationcenter as const D3DXVECTOR2 ptr, byval rotation as FLOAT, byval ptranslation as const D3DXVECTOR2 ptr) as D3DXMATRIX ptr
declare function D3DXMatrixTranslation(byval pout as D3DXMATRIX ptr, byval x as FLOAT, byval y as FLOAT, byval z as FLOAT) as D3DXMATRIX ptr
declare function D3DXMatrixTranspose(byval pout as D3DXMATRIX ptr, byval pm as const D3DXMATRIX ptr) as D3DXMATRIX ptr
declare function D3DXPlaneFromPointNormal(byval pout as D3DXPLANE ptr, byval pvpoint as const D3DXVECTOR3 ptr, byval pvnormal as const D3DXVECTOR3 ptr) as D3DXPLANE ptr
declare function D3DXPlaneFromPoints(byval pout as D3DXPLANE ptr, byval pv1 as const D3DXVECTOR3 ptr, byval pv2 as const D3DXVECTOR3 ptr, byval pv3 as const D3DXVECTOR3 ptr) as D3DXPLANE ptr
declare function D3DXPlaneIntersectLine(byval pout as D3DXVECTOR3 ptr, byval pp as const D3DXPLANE ptr, byval pv1 as const D3DXVECTOR3 ptr, byval pv2 as const D3DXVECTOR3 ptr) as D3DXVECTOR3 ptr
declare function D3DXPlaneNormalize(byval pout as D3DXPLANE ptr, byval pp as const D3DXPLANE ptr) as D3DXPLANE ptr
declare function D3DXPlaneTransform(byval pout as D3DXPLANE ptr, byval pplane as const D3DXPLANE ptr, byval pm as const D3DXMATRIX ptr) as D3DXPLANE ptr
declare function D3DXPlaneTransformArray(byval pout as D3DXPLANE ptr, byval outstride as UINT, byval pplane as const D3DXPLANE ptr, byval pstride as UINT, byval pm as const D3DXMATRIX ptr, byval n as UINT) as D3DXPLANE ptr
declare function D3DXQuaternionBaryCentric(byval pout as D3DXQUATERNION ptr, byval pq1 as const D3DXQUATERNION ptr, byval pq2 as const D3DXQUATERNION ptr, byval pq3 as const D3DXQUATERNION ptr, byval f as FLOAT, byval g as FLOAT) as D3DXQUATERNION ptr
declare function D3DXQuaternionExp(byval pout as D3DXQUATERNION ptr, byval pq as const D3DXQUATERNION ptr) as D3DXQUATERNION ptr
declare function D3DXQuaternionInverse(byval pout as D3DXQUATERNION ptr, byval pq as const D3DXQUATERNION ptr) as D3DXQUATERNION ptr
declare function D3DXQuaternionLn(byval pout as D3DXQUATERNION ptr, byval pq as const D3DXQUATERNION ptr) as D3DXQUATERNION ptr
declare function D3DXQuaternionMultiply(byval pout as D3DXQUATERNION ptr, byval pq1 as const D3DXQUATERNION ptr, byval pq2 as const D3DXQUATERNION ptr) as D3DXQUATERNION ptr
declare function D3DXQuaternionNormalize(byval pout as D3DXQUATERNION ptr, byval pq as const D3DXQUATERNION ptr) as D3DXQUATERNION ptr
declare function D3DXQuaternionRotationAxis(byval pout as D3DXQUATERNION ptr, byval pv as const D3DXVECTOR3 ptr, byval angle as FLOAT) as D3DXQUATERNION ptr
declare function D3DXQuaternionRotationMatrix(byval pout as D3DXQUATERNION ptr, byval pm as const D3DXMATRIX ptr) as D3DXQUATERNION ptr
declare function D3DXQuaternionRotationYawPitchRoll(byval pout as D3DXQUATERNION ptr, byval yaw as FLOAT, byval pitch as FLOAT, byval roll as FLOAT) as D3DXQUATERNION ptr
declare function D3DXQuaternionSlerp(byval pout as D3DXQUATERNION ptr, byval pq1 as const D3DXQUATERNION ptr, byval pq2 as const D3DXQUATERNION ptr, byval t as FLOAT) as D3DXQUATERNION ptr
declare function D3DXQuaternionSquad(byval pout as D3DXQUATERNION ptr, byval pq1 as const D3DXQUATERNION ptr, byval pq2 as const D3DXQUATERNION ptr, byval pq3 as const D3DXQUATERNION ptr, byval pq4 as const D3DXQUATERNION ptr, byval t as FLOAT) as D3DXQUATERNION ptr
declare sub D3DXQuaternionSquadSetup(byval paout as D3DXQUATERNION ptr, byval pbout as D3DXQUATERNION ptr, byval pcout as D3DXQUATERNION ptr, byval pq0 as const D3DXQUATERNION ptr, byval pq1 as const D3DXQUATERNION ptr, byval pq2 as const D3DXQUATERNION ptr, byval pq3 as const D3DXQUATERNION ptr)
declare sub D3DXQuaternionToAxisAngle(byval pq as const D3DXQUATERNION ptr, byval paxis as D3DXVECTOR3 ptr, byval pangle as FLOAT ptr)
declare function D3DXVec2BaryCentric(byval pout as D3DXVECTOR2 ptr, byval pv1 as const D3DXVECTOR2 ptr, byval pv2 as const D3DXVECTOR2 ptr, byval pv3 as const D3DXVECTOR2 ptr, byval f as FLOAT, byval g as FLOAT) as D3DXVECTOR2 ptr
declare function D3DXVec2CatmullRom(byval pout as D3DXVECTOR2 ptr, byval pv0 as const D3DXVECTOR2 ptr, byval pv1 as const D3DXVECTOR2 ptr, byval pv2 as const D3DXVECTOR2 ptr, byval pv3 as const D3DXVECTOR2 ptr, byval s as FLOAT) as D3DXVECTOR2 ptr
declare function D3DXVec2Hermite(byval pout as D3DXVECTOR2 ptr, byval pv1 as const D3DXVECTOR2 ptr, byval pt1 as const D3DXVECTOR2 ptr, byval pv2 as const D3DXVECTOR2 ptr, byval pt2 as const D3DXVECTOR2 ptr, byval s as FLOAT) as D3DXVECTOR2 ptr
declare function D3DXVec2Normalize(byval pout as D3DXVECTOR2 ptr, byval pv as const D3DXVECTOR2 ptr) as D3DXVECTOR2 ptr
declare function D3DXVec2Transform(byval pout as D3DXVECTOR4 ptr, byval pv as const D3DXVECTOR2 ptr, byval pm as const D3DXMATRIX ptr) as D3DXVECTOR4 ptr
declare function D3DXVec2TransformArray(byval pout as D3DXVECTOR4 ptr, byval outstride as UINT, byval pv as const D3DXVECTOR2 ptr, byval vstride as UINT, byval pm as const D3DXMATRIX ptr, byval n as UINT) as D3DXVECTOR4 ptr
declare function D3DXVec2TransformCoord(byval pout as D3DXVECTOR2 ptr, byval pv as const D3DXVECTOR2 ptr, byval pm as const D3DXMATRIX ptr) as D3DXVECTOR2 ptr
declare function D3DXVec2TransformCoordArray(byval pout as D3DXVECTOR2 ptr, byval outstride as UINT, byval pv as const D3DXVECTOR2 ptr, byval vstride as UINT, byval pm as const D3DXMATRIX ptr, byval n as UINT) as D3DXVECTOR2 ptr
declare function D3DXVec2TransformNormal(byval pout as D3DXVECTOR2 ptr, byval pv as const D3DXVECTOR2 ptr, byval pm as const D3DXMATRIX ptr) as D3DXVECTOR2 ptr
declare function D3DXVec2TransformNormalArray(byval pout as D3DXVECTOR2 ptr, byval outstride as UINT, byval pv as const D3DXVECTOR2 ptr, byval vstride as UINT, byval pm as const D3DXMATRIX ptr, byval n as UINT) as D3DXVECTOR2 ptr
declare function D3DXVec3BaryCentric(byval pout as D3DXVECTOR3 ptr, byval pv1 as const D3DXVECTOR3 ptr, byval pv2 as const D3DXVECTOR3 ptr, byval pv3 as const D3DXVECTOR3 ptr, byval f as FLOAT, byval g as FLOAT) as D3DXVECTOR3 ptr
declare function D3DXVec3CatmullRom(byval pout as D3DXVECTOR3 ptr, byval pv0 as const D3DXVECTOR3 ptr, byval pv1 as const D3DXVECTOR3 ptr, byval pv2 as const D3DXVECTOR3 ptr, byval pv3 as const D3DXVECTOR3 ptr, byval s as FLOAT) as D3DXVECTOR3 ptr
declare function D3DXVec3Hermite(byval pout as D3DXVECTOR3 ptr, byval pv1 as const D3DXVECTOR3 ptr, byval pt1 as const D3DXVECTOR3 ptr, byval pv2 as const D3DXVECTOR3 ptr, byval pt2 as const D3DXVECTOR3 ptr, byval s as FLOAT) as D3DXVECTOR3 ptr
declare function D3DXVec3Normalize(byval pout as D3DXVECTOR3 ptr, byval pv as const D3DXVECTOR3 ptr) as D3DXVECTOR3 ptr
declare function D3DXVec3Project(byval pout as D3DXVECTOR3 ptr, byval pv as const D3DXVECTOR3 ptr, byval pviewport as const D3DVIEWPORT9 ptr, byval pprojection as const D3DXMATRIX ptr, byval pview as const D3DXMATRIX ptr, byval pworld as const D3DXMATRIX ptr) as D3DXVECTOR3 ptr
declare function D3DXVec3ProjectArray(byval pout as D3DXVECTOR3 ptr, byval outstride as UINT, byval pv as const D3DXVECTOR3 ptr, byval vstride as UINT, byval pviewport as const D3DVIEWPORT9 ptr, byval pprojection as const D3DXMATRIX ptr, byval pview as const D3DXMATRIX ptr, byval pworld as const D3DXMATRIX ptr, byval n as UINT) as D3DXVECTOR3 ptr
declare function D3DXVec3Transform(byval pout as D3DXVECTOR4 ptr, byval pv as const D3DXVECTOR3 ptr, byval pm as const D3DXMATRIX ptr) as D3DXVECTOR4 ptr
declare function D3DXVec3TransformArray(byval pout as D3DXVECTOR4 ptr, byval outstride as UINT, byval pv as const D3DXVECTOR3 ptr, byval vstride as UINT, byval pm as const D3DXMATRIX ptr, byval n as UINT) as D3DXVECTOR4 ptr
declare function D3DXVec3TransformCoord(byval pout as D3DXVECTOR3 ptr, byval pv as const D3DXVECTOR3 ptr, byval pm as const D3DXMATRIX ptr) as D3DXVECTOR3 ptr
declare function D3DXVec3TransformCoordArray(byval pout as D3DXVECTOR3 ptr, byval outstride as UINT, byval pv as const D3DXVECTOR3 ptr, byval vstride as UINT, byval pm as const D3DXMATRIX ptr, byval n as UINT) as D3DXVECTOR3 ptr
declare function D3DXVec3TransformNormal(byval pout as D3DXVECTOR3 ptr, byval pv as const D3DXVECTOR3 ptr, byval pm as const D3DXMATRIX ptr) as D3DXVECTOR3 ptr
declare function D3DXVec3TransformNormalArray(byval pout as D3DXVECTOR3 ptr, byval outstride as UINT, byval pv as const D3DXVECTOR3 ptr, byval vstride as UINT, byval pm as const D3DXMATRIX ptr, byval n as UINT) as D3DXVECTOR3 ptr
declare function D3DXVec3Unproject(byval pout as D3DXVECTOR3 ptr, byval pv as const D3DXVECTOR3 ptr, byval pviewport as const D3DVIEWPORT9 ptr, byval pprojection as const D3DXMATRIX ptr, byval pview as const D3DXMATRIX ptr, byval pworld as const D3DXMATRIX ptr) as D3DXVECTOR3 ptr
declare function D3DXVec3UnprojectArray(byval pout as D3DXVECTOR3 ptr, byval outstride as UINT, byval pv as const D3DXVECTOR3 ptr, byval vstride as UINT, byval pviewport as const D3DVIEWPORT9 ptr, byval pprojection as const D3DXMATRIX ptr, byval pview as const D3DXMATRIX ptr, byval pworld as const D3DXMATRIX ptr, byval n as UINT) as D3DXVECTOR3 ptr
declare function D3DXVec4BaryCentric(byval pout as D3DXVECTOR4 ptr, byval pv1 as const D3DXVECTOR4 ptr, byval pv2 as const D3DXVECTOR4 ptr, byval pv3 as const D3DXVECTOR4 ptr, byval f as FLOAT, byval g as FLOAT) as D3DXVECTOR4 ptr
declare function D3DXVec4CatmullRom(byval pout as D3DXVECTOR4 ptr, byval pv0 as const D3DXVECTOR4 ptr, byval pv1 as const D3DXVECTOR4 ptr, byval pv2 as const D3DXVECTOR4 ptr, byval pv3 as const D3DXVECTOR4 ptr, byval s as FLOAT) as D3DXVECTOR4 ptr
declare function D3DXVec4Cross(byval pout as D3DXVECTOR4 ptr, byval pv1 as const D3DXVECTOR4 ptr, byval pv2 as const D3DXVECTOR4 ptr, byval pv3 as const D3DXVECTOR4 ptr) as D3DXVECTOR4 ptr
declare function D3DXVec4Hermite(byval pout as D3DXVECTOR4 ptr, byval pv1 as const D3DXVECTOR4 ptr, byval pt1 as const D3DXVECTOR4 ptr, byval pv2 as const D3DXVECTOR4 ptr, byval pt2 as const D3DXVECTOR4 ptr, byval s as FLOAT) as D3DXVECTOR4 ptr
declare function D3DXVec4Normalize(byval pout as D3DXVECTOR4 ptr, byval pv as const D3DXVECTOR4 ptr) as D3DXVECTOR4 ptr
declare function D3DXVec4Transform(byval pout as D3DXVECTOR4 ptr, byval pv as const D3DXVECTOR4 ptr, byval pm as const D3DXMATRIX ptr) as D3DXVECTOR4 ptr
declare function D3DXVec4TransformArray(byval pout as D3DXVECTOR4 ptr, byval outstride as UINT, byval pv as const D3DXVECTOR4 ptr, byval vstride as UINT, byval pm as const D3DXMATRIX ptr, byval n as UINT) as D3DXVECTOR4 ptr
declare function D3DXFloat32To16Array(byval pout as D3DXFLOAT16 ptr, byval pin as const FLOAT ptr, byval n as UINT) as D3DXFLOAT16 ptr
declare function D3DXFloat16To32Array(byval pout as FLOAT ptr, byval pin as const D3DXFLOAT16 ptr, byval n as UINT) as FLOAT ptr
declare function D3DXSHAdd(byval out as FLOAT ptr, byval order as UINT, byval a as const FLOAT ptr, byval b as const FLOAT ptr) as FLOAT ptr
declare function D3DXSHDot(byval order as UINT, byval a as const FLOAT ptr, byval b as const FLOAT ptr) as FLOAT
declare function D3DXSHEvalConeLight(byval order as UINT, byval dir as const D3DXVECTOR3 ptr, byval radius as FLOAT, byval Rintensity as FLOAT, byval Gintensity as FLOAT, byval Bintensity as FLOAT, byval rout as FLOAT ptr, byval gout as FLOAT ptr, byval bout as FLOAT ptr) as HRESULT
declare function D3DXSHEvalDirection(byval out as FLOAT ptr, byval order as UINT, byval dir as const D3DXVECTOR3 ptr) as FLOAT ptr
declare function D3DXSHEvalDirectionalLight(byval order as UINT, byval dir as const D3DXVECTOR3 ptr, byval Rintensity as FLOAT, byval Gintensity as FLOAT, byval Bintensity as FLOAT, byval rout as FLOAT ptr, byval gout as FLOAT ptr, byval bout as FLOAT ptr) as HRESULT
declare function D3DXSHEvalHemisphereLight(byval order as UINT, byval dir as const D3DXVECTOR3 ptr, byval top as D3DXCOLOR, byval bottom as D3DXCOLOR, byval rout as FLOAT ptr, byval gout as FLOAT ptr, byval bout as FLOAT ptr) as HRESULT
declare function D3DXSHEvalSphericalLight(byval order as UINT, byval dir as const D3DXVECTOR3 ptr, byval radius as FLOAT, byval Rintensity as FLOAT, byval Gintensity as FLOAT, byval Bintensity as FLOAT, byval rout as FLOAT ptr, byval gout as FLOAT ptr, byval bout as FLOAT ptr) as HRESULT
declare function D3DXSHMultiply2(byval out as FLOAT ptr, byval a as const FLOAT ptr, byval b as const FLOAT ptr) as FLOAT ptr
declare function D3DXSHMultiply3(byval out as FLOAT ptr, byval a as const FLOAT ptr, byval b as const FLOAT ptr) as FLOAT ptr
declare function D3DXSHMultiply4(byval out as FLOAT ptr, byval a as const FLOAT ptr, byval b as const FLOAT ptr) as FLOAT ptr
declare function D3DXSHRotate(byval out as FLOAT ptr, byval order as UINT, byval matrix as const D3DXMATRIX ptr, byval in as const FLOAT ptr) as FLOAT ptr
declare function D3DXSHRotateZ(byval out as FLOAT ptr, byval order as UINT, byval angle as FLOAT, byval in as const FLOAT ptr) as FLOAT ptr
declare function D3DXSHScale(byval out as FLOAT ptr, byval order as UINT, byval a as const FLOAT ptr, byval scale as const FLOAT) as FLOAT ptr
type LPD3DXMATRIXSTACK as ID3DXMatrixStack ptr
extern IID_ID3DXMatrixStack as const GUID
type ID3DXMatrixStackVtbl as ID3DXMatrixStackVtbl_

type ID3DXMatrixStack
	lpVtbl as ID3DXMatrixStackVtbl ptr
end type

type ID3DXMatrixStackVtbl_
	QueryInterface as function(byval This as ID3DXMatrixStack ptr, byval riid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddRef as function(byval This as ID3DXMatrixStack ptr) as ULONG
	Release as function(byval This as ID3DXMatrixStack ptr) as ULONG
	Pop as function(byval This as ID3DXMatrixStack ptr) as HRESULT
	Push as function(byval This as ID3DXMatrixStack ptr) as HRESULT
	LoadIdentity as function(byval This as ID3DXMatrixStack ptr) as HRESULT
	LoadMatrix as function(byval This as ID3DXMatrixStack ptr, byval pM as const D3DXMATRIX ptr) as HRESULT
	MultMatrix as function(byval This as ID3DXMatrixStack ptr, byval pM as const D3DXMATRIX ptr) as HRESULT
	MultMatrixLocal as function(byval This as ID3DXMatrixStack ptr, byval pM as const D3DXMATRIX ptr) as HRESULT
	RotateAxis as function(byval This as ID3DXMatrixStack ptr, byval pV as const D3DXVECTOR3 ptr, byval Angle as FLOAT) as HRESULT
	RotateAxisLocal as function(byval This as ID3DXMatrixStack ptr, byval pV as const D3DXVECTOR3 ptr, byval Angle as FLOAT) as HRESULT
	RotateYawPitchRoll as function(byval This as ID3DXMatrixStack ptr, byval Yaw as FLOAT, byval Pitch as FLOAT, byval Roll as FLOAT) as HRESULT
	RotateYawPitchRollLocal as function(byval This as ID3DXMatrixStack ptr, byval Yaw as FLOAT, byval Pitch as FLOAT, byval Roll as FLOAT) as HRESULT
	Scale as function(byval This as ID3DXMatrixStack ptr, byval x as FLOAT, byval y as FLOAT, byval z as FLOAT) as HRESULT
	ScaleLocal as function(byval This as ID3DXMatrixStack ptr, byval x as FLOAT, byval y as FLOAT, byval z as FLOAT) as HRESULT
	Translate as function(byval This as ID3DXMatrixStack ptr, byval x as FLOAT, byval y as FLOAT, byval z as FLOAT) as HRESULT
	TranslateLocal as function(byval This as ID3DXMatrixStack ptr, byval x as FLOAT, byval y as FLOAT, byval z as FLOAT) as HRESULT
	GetTop as function(byval This as ID3DXMatrixStack ptr) as D3DXMATRIX ptr
end type

#define ID3DXMatrixStack_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define ID3DXMatrixStack_AddRef(p) (p)->lpVtbl->AddRef(p)
#define ID3DXMatrixStack_Release(p) (p)->lpVtbl->Release(p)
#define ID3DXMatrixStack_Pop(p) (p)->lpVtbl->Pop(p)
#define ID3DXMatrixStack_Push(p) (p)->lpVtbl->Push(p)
#define ID3DXMatrixStack_LoadIdentity(p) (p)->lpVtbl->LoadIdentity(p)
#define ID3DXMatrixStack_LoadMatrix(p, a) (p)->lpVtbl->LoadMatrix(p, a)
#define ID3DXMatrixStack_MultMatrix(p, a) (p)->lpVtbl->MultMatrix(p, a)
#define ID3DXMatrixStack_MultMatrixLocal(p, a) (p)->lpVtbl->MultMatrixLocal(p, a)
#define ID3DXMatrixStack_RotateAxis(p, a, b) (p)->lpVtbl->RotateAxis(p, a, b)
#define ID3DXMatrixStack_RotateAxisLocal(p, a, b) (p)->lpVtbl->RotateAxisLocal(p, a, b)
#define ID3DXMatrixStack_RotateYawPitchRoll(p, a, b, c) (p)->lpVtbl->RotateYawPitchRoll(p, a, b, c)
#define ID3DXMatrixStack_RotateYawPitchRollLocal(p, a, b, c) (p)->lpVtbl->RotateYawPitchRollLocal(p, a, b, c)
#define ID3DXMatrixStack_Scale(p, a, b, c) (p)->lpVtbl->Scale(p, a, b, c)
#define ID3DXMatrixStack_ScaleLocal(p, a, b, c) (p)->lpVtbl->ScaleLocal(p, a, b, c)
#define ID3DXMatrixStack_Translate(p, a, b, c) (p)->lpVtbl->Translate(p, a, b, c)
#define ID3DXMatrixStack_TranslateLocal(p, a, b, c) (p)->lpVtbl->TranslateLocal(p, a, b, c)
#define ID3DXMatrixStack_GetTop(p) (p)->lpVtbl->GetTop(p)
declare function D3DXCreateMatrixStack(byval flags as DWORD, byval stack as ID3DXMatrixStack ptr ptr) as HRESULT

end extern
