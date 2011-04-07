''
''
'' d3dx9math -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_d3dx9math_bi__
#define __win_d3dx9math_bi__

#include once "win/d3dx9.bi"

#define D3DX_PI csng(3.141592654f)
#define D3DX_1BYPI csng(0.318309886f)

#define D3DXToRadian(degree) ((degree) * (D3DX_PI / 180.0))
#define D3DXToDegree(radian) ((radian) * (180.0 / D3DX_PI))

#define D3DX_16F_DIG 3
#define D3DX_16F_EPSILON 4.8875809e-4f
#define D3DX_16F_MANT_DIG 11
#define D3DX_16F_MAX 6.550400e+004
#define D3DX_16F_MAX_10_EXP 4
#define D3DX_16F_MAX_EXP 15
#define D3DX_16F_MIN 6.1035156e-5f
#define D3DX_16F_MIN_10_EXP (-4)
#define D3DX_16F_MIN_EXP (-12)
#define D3DX_16F_RADIX 2
#define D3DX_16F_ROUNDS 1

type D3DXFLOAT16
	value as WORD
end type

type LPD3DXFLOAT16 as D3DXFLOAT16 ptr

type D3DXVECTOR2
	x as FLOAT
	y as FLOAT
end type

type LPD3DXVECTOR2 as D3DXVECTOR2 ptr

type D3DXVECTOR2_16F
	x as D3DXFLOAT16
	y as D3DXFLOAT16
end type

type LPD3DXVECTOR2_16F as D3DXVECTOR2_16F ptr

type D3DXVECTOR3 as D3DVECTOR
type LPD3DXVECTOR3 as D3DVECTOR ptr

type D3DXVECTOR3_16F
	x as D3DXFLOAT16
	y as D3DXFLOAT16
	z as D3DXFLOAT16
end type

type LPD3DXVECTOR3_16F as D3DXVECTOR3_16F ptr

type D3DXVECTOR4
	x as FLOAT
	y as FLOAT
	z as FLOAT
	w as FLOAT
end type

type LPD3DXVECTOR4 as D3DXVECTOR4 ptr

type D3DXVECTOR4_16F
	x as D3DXFLOAT16
	y as D3DXFLOAT16
	z as D3DXFLOAT16
	w as D3DXFLOAT16
end type

type LPD3DXVECTOR4_16F as D3DXVECTOR4_16F ptr

type D3DXMATRIX as D3DMATRIX
type LPD3DXMATRIX as D3DMATRIX ptr
type D3DXMATRIXA16 as D3DXMATRIX
type LPD3DXMATRIXA16 as D3DXMATRIXA16 ptr

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

declare function D3DXFloat32To16Array alias "D3DXFloat32To16Array" (byval pOut as D3DXFLOAT16 ptr, byval pIn as FLOAT ptr, byval n as UINT) as D3DXFLOAT16 ptr
declare function D3DXFloat16To32Array alias "D3DXFloat16To32Array" (byval pOut as FLOAT ptr, byval pIn as D3DXFLOAT16 ptr, byval n as UINT) as FLOAT ptr
declare function D3DXVec2Length alias "D3DXVec2Length" (byval pV as D3DXVECTOR2 ptr) as FLOAT
declare function D3DXVec2LengthSq alias "D3DXVec2LengthSq" (byval pV as D3DXVECTOR2 ptr) as FLOAT
declare function D3DXVec2Dot alias "D3DXVec2Dot" (byval pV1 as D3DXVECTOR2 ptr, byval pV2 as D3DXVECTOR2 ptr) as FLOAT
declare function D3DXVec2CCW alias "D3DXVec2CCW" (byval pV1 as D3DXVECTOR2 ptr, byval pV2 as D3DXVECTOR2 ptr) as FLOAT
declare function D3DXVec2Add alias "D3DXVec2Add" (byval pOut as D3DXVECTOR2 ptr, byval pV1 as D3DXVECTOR2 ptr, byval pV2 as D3DXVECTOR2 ptr) as D3DXVECTOR2 ptr
declare function D3DXVec2Subtract alias "D3DXVec2Subtract" (byval pOut as D3DXVECTOR2 ptr, byval pV1 as D3DXVECTOR2 ptr, byval pV2 as D3DXVECTOR2 ptr) as D3DXVECTOR2 ptr
declare function D3DXVec2Minimize alias "D3DXVec2Minimize" (byval pOut as D3DXVECTOR2 ptr, byval pV1 as D3DXVECTOR2 ptr, byval pV2 as D3DXVECTOR2 ptr) as D3DXVECTOR2 ptr
declare function D3DXVec2Maximize alias "D3DXVec2Maximize" (byval pOut as D3DXVECTOR2 ptr, byval pV1 as D3DXVECTOR2 ptr, byval pV2 as D3DXVECTOR2 ptr) as D3DXVECTOR2 ptr
declare function D3DXVec2Scale alias "D3DXVec2Scale" (byval pOut as D3DXVECTOR2 ptr, byval pV as D3DXVECTOR2 ptr, byval s as FLOAT) as D3DXVECTOR2 ptr
declare function D3DXVec2Lerp alias "D3DXVec2Lerp" (byval pOut as D3DXVECTOR2 ptr, byval pV1 as D3DXVECTOR2 ptr, byval pV2 as D3DXVECTOR2 ptr, byval s as FLOAT) as D3DXVECTOR2 ptr
declare function D3DXVec2Normalize alias "D3DXVec2Normalize" (byval pOut as D3DXVECTOR2 ptr, byval pV as D3DXVECTOR2 ptr) as D3DXVECTOR2 ptr
declare function D3DXVec2Hermite alias "D3DXVec2Hermite" (byval pOut as D3DXVECTOR2 ptr, byval pV1 as D3DXVECTOR2 ptr, byval pT1 as D3DXVECTOR2 ptr, byval pV2 as D3DXVECTOR2 ptr, byval pT2 as D3DXVECTOR2 ptr, byval s as FLOAT) as D3DXVECTOR2 ptr
declare function D3DXVec2CatmullRom alias "D3DXVec2CatmullRom" (byval pOut as D3DXVECTOR2 ptr, byval pV0 as D3DXVECTOR2 ptr, byval pV1 as D3DXVECTOR2 ptr, byval pV2 as D3DXVECTOR2 ptr, byval pV3 as D3DXVECTOR2 ptr, byval s as FLOAT) as D3DXVECTOR2 ptr
declare function D3DXVec2BaryCentric alias "D3DXVec2BaryCentric" (byval pOut as D3DXVECTOR2 ptr, byval pV1 as D3DXVECTOR2 ptr, byval pV2 as D3DXVECTOR2 ptr, byval pV3 as D3DXVECTOR2 ptr, byval f as FLOAT, byval g as FLOAT) as D3DXVECTOR2 ptr
declare function D3DXVec2Transform alias "D3DXVec2Transform" (byval pOut as D3DXVECTOR4 ptr, byval pV as D3DXVECTOR2 ptr, byval pM as D3DXMATRIX ptr) as D3DXVECTOR4 ptr
declare function D3DXVec2TransformCoord alias "D3DXVec2TransformCoord" (byval pOut as D3DXVECTOR2 ptr, byval pV as D3DXVECTOR2 ptr, byval pM as D3DXMATRIX ptr) as D3DXVECTOR2 ptr
declare function D3DXVec2TransformNormal alias "D3DXVec2TransformNormal" (byval pOut as D3DXVECTOR2 ptr, byval pV as D3DXVECTOR2 ptr, byval pM as D3DXMATRIX ptr) as D3DXVECTOR2 ptr
declare function D3DXVec2TransformArray alias "D3DXVec2TransformArray" (byval pOut as D3DXVECTOR4 ptr, byval OutStride as UINT, byval pV as D3DXVECTOR2 ptr, byval VStride as UINT, byval pM as D3DXMATRIX ptr, byval n as UINT) as D3DXVECTOR4 ptr
declare function D3DXVec2TransformCoordArray alias "D3DXVec2TransformCoordArray" (byval pOut as D3DXVECTOR2 ptr, byval OutStride as UINT, byval pV as D3DXVECTOR2 ptr, byval VStride as UINT, byval pM as D3DXMATRIX ptr, byval n as UINT) as D3DXVECTOR2 ptr
declare function D3DXVec2TransformNormalArray alias "D3DXVec2TransformNormalArray" (byval pOut as D3DXVECTOR2 ptr, byval OutStride as UINT, byval pV as D3DXVECTOR2 ptr, byval VStride as UINT, byval pM as D3DXMATRIX ptr, byval n as UINT) as D3DXVECTOR2 ptr
declare function D3DXVec3Length alias "D3DXVec3Length" (byval pV as D3DXVECTOR3 ptr) as FLOAT
declare function D3DXVec3LengthSq alias "D3DXVec3LengthSq" (byval pV as D3DXVECTOR3 ptr) as FLOAT
declare function D3DXVec3Dot alias "D3DXVec3Dot" (byval pV1 as D3DXVECTOR3 ptr, byval pV2 as D3DXVECTOR3 ptr) as FLOAT
declare function D3DXVec3Cross alias "D3DXVec3Cross" (byval pOut as D3DXVECTOR3 ptr, byval pV1 as D3DXVECTOR3 ptr, byval pV2 as D3DXVECTOR3 ptr) as D3DXVECTOR3 ptr
declare function D3DXVec3Add alias "D3DXVec3Add" (byval pOut as D3DXVECTOR3 ptr, byval pV1 as D3DXVECTOR3 ptr, byval pV2 as D3DXVECTOR3 ptr) as D3DXVECTOR3 ptr
declare function D3DXVec3Subtract alias "D3DXVec3Subtract" (byval pOut as D3DXVECTOR3 ptr, byval pV1 as D3DXVECTOR3 ptr, byval pV2 as D3DXVECTOR3 ptr) as D3DXVECTOR3 ptr
declare function D3DXVec3Minimize alias "D3DXVec3Minimize" (byval pOut as D3DXVECTOR3 ptr, byval pV1 as D3DXVECTOR3 ptr, byval pV2 as D3DXVECTOR3 ptr) as D3DXVECTOR3 ptr
declare function D3DXVec3Maximize alias "D3DXVec3Maximize" (byval pOut as D3DXVECTOR3 ptr, byval pV1 as D3DXVECTOR3 ptr, byval pV2 as D3DXVECTOR3 ptr) as D3DXVECTOR3 ptr
declare function D3DXVec3Scale alias "D3DXVec3Scale" (byval pOut as D3DXVECTOR3 ptr, byval pV as D3DXVECTOR3 ptr, byval s as FLOAT) as D3DXVECTOR3 ptr
declare function D3DXVec3Lerp alias "D3DXVec3Lerp" (byval pOut as D3DXVECTOR3 ptr, byval pV1 as D3DXVECTOR3 ptr, byval pV2 as D3DXVECTOR3 ptr, byval s as FLOAT) as D3DXVECTOR3 ptr
declare function D3DXVec3Normalize alias "D3DXVec3Normalize" (byval pOut as D3DXVECTOR3 ptr, byval pV as D3DXVECTOR3 ptr) as D3DXVECTOR3 ptr
declare function D3DXVec3Hermite alias "D3DXVec3Hermite" (byval pOut as D3DXVECTOR3 ptr, byval pV1 as D3DXVECTOR3 ptr, byval pT1 as D3DXVECTOR3 ptr, byval pV2 as D3DXVECTOR3 ptr, byval pT2 as D3DXVECTOR3 ptr, byval s as FLOAT) as D3DXVECTOR3 ptr
declare function D3DXVec3CatmullRom alias "D3DXVec3CatmullRom" (byval pOut as D3DXVECTOR3 ptr, byval pV0 as D3DXVECTOR3 ptr, byval pV1 as D3DXVECTOR3 ptr, byval pV2 as D3DXVECTOR3 ptr, byval pV3 as D3DXVECTOR3 ptr, byval s as FLOAT) as D3DXVECTOR3 ptr
declare function D3DXVec3BaryCentric alias "D3DXVec3BaryCentric" (byval pOut as D3DXVECTOR3 ptr, byval pV1 as D3DXVECTOR3 ptr, byval pV2 as D3DXVECTOR3 ptr, byval pV3 as D3DXVECTOR3 ptr, byval f as FLOAT, byval g as FLOAT) as D3DXVECTOR3 ptr
declare function D3DXVec3Transform alias "D3DXVec3Transform" (byval pOut as D3DXVECTOR4 ptr, byval pV as D3DXVECTOR3 ptr, byval pM as D3DXMATRIX ptr) as D3DXVECTOR4 ptr
declare function D3DXVec3TransformCoord alias "D3DXVec3TransformCoord" (byval pOut as D3DXVECTOR3 ptr, byval pV as D3DXVECTOR3 ptr, byval pM as D3DXMATRIX ptr) as D3DXVECTOR3 ptr
declare function D3DXVec3TransformNormal alias "D3DXVec3TransformNormal" (byval pOut as D3DXVECTOR3 ptr, byval pV as D3DXVECTOR3 ptr, byval pM as D3DXMATRIX ptr) as D3DXVECTOR3 ptr
declare function D3DXVec3TransformArray alias "D3DXVec3TransformArray" (byval pOut as D3DXVECTOR4 ptr, byval OutStride as UINT, byval pV as D3DXVECTOR3 ptr, byval VStride as UINT, byval pM as D3DXMATRIX ptr, byval n as UINT) as D3DXVECTOR4 ptr
declare function D3DXVec3TransformCoordArray alias "D3DXVec3TransformCoordArray" (byval pOut as D3DXVECTOR3 ptr, byval OutStride as UINT, byval pV as D3DXVECTOR3 ptr, byval VStride as UINT, byval pM as D3DXMATRIX ptr, byval n as UINT) as D3DXVECTOR3 ptr
declare function D3DXVec3TransformNormalArray alias "D3DXVec3TransformNormalArray" (byval pOut as D3DXVECTOR3 ptr, byval OutStride as UINT, byval pV as D3DXVECTOR3 ptr, byval VStride as UINT, byval pM as D3DXMATRIX ptr, byval n as UINT) as D3DXVECTOR3 ptr
declare function D3DXVec3Project alias "D3DXVec3Project" (byval pOut as D3DXVECTOR3 ptr, byval pV as D3DXVECTOR3 ptr, byval pViewport as D3DVIEWPORT9 ptr, byval pProjection as D3DXMATRIX ptr, byval pView as D3DXMATRIX ptr, byval pWorld as D3DXMATRIX ptr) as D3DXVECTOR3 ptr
declare function D3DXVec3Unproject alias "D3DXVec3Unproject" (byval pOut as D3DXVECTOR3 ptr, byval pV as D3DXVECTOR3 ptr, byval pViewport as D3DVIEWPORT9 ptr, byval pProjection as D3DXMATRIX ptr, byval pView as D3DXMATRIX ptr, byval pWorld as D3DXMATRIX ptr) as D3DXVECTOR3 ptr
declare function D3DXVec3ProjectArray alias "D3DXVec3ProjectArray" (byval pOut as D3DXVECTOR3 ptr, byval OutStride as UINT, byval pV as D3DXVECTOR3 ptr, byval VStride as UINT, byval pViewport as D3DVIEWPORT9 ptr, byval pProjection as D3DXMATRIX ptr, byval pView as D3DXMATRIX ptr, byval pWorld as D3DXMATRIX ptr, byval n as UINT) as D3DXVECTOR3 ptr
declare function D3DXVec3UnprojectArray alias "D3DXVec3UnprojectArray" (byval pOut as D3DXVECTOR3 ptr, byval OutStride as UINT, byval pV as D3DXVECTOR3 ptr, byval VStride as UINT, byval pViewport as D3DVIEWPORT9 ptr, byval pProjection as D3DXMATRIX ptr, byval pView as D3DXMATRIX ptr, byval pWorld as D3DXMATRIX ptr, byval n as UINT) as D3DXVECTOR3 ptr
declare function D3DXVec4Length alias "D3DXVec4Length" (byval pV as D3DXVECTOR4 ptr) as FLOAT
declare function D3DXVec4LengthSq alias "D3DXVec4LengthSq" (byval pV as D3DXVECTOR4 ptr) as FLOAT
declare function D3DXVec4Dot alias "D3DXVec4Dot" (byval pV1 as D3DXVECTOR4 ptr, byval pV2 as D3DXVECTOR4 ptr) as FLOAT
declare function D3DXVec4Add alias "D3DXVec4Add" (byval pOut as D3DXVECTOR4 ptr, byval pV1 as D3DXVECTOR4 ptr, byval pV2 as D3DXVECTOR4 ptr) as D3DXVECTOR4 ptr
declare function D3DXVec4Subtract alias "D3DXVec4Subtract" (byval pOut as D3DXVECTOR4 ptr, byval pV1 as D3DXVECTOR4 ptr, byval pV2 as D3DXVECTOR4 ptr) as D3DXVECTOR4 ptr
declare function D3DXVec4Minimize alias "D3DXVec4Minimize" (byval pOut as D3DXVECTOR4 ptr, byval pV1 as D3DXVECTOR4 ptr, byval pV2 as D3DXVECTOR4 ptr) as D3DXVECTOR4 ptr
declare function D3DXVec4Maximize alias "D3DXVec4Maximize" (byval pOut as D3DXVECTOR4 ptr, byval pV1 as D3DXVECTOR4 ptr, byval pV2 as D3DXVECTOR4 ptr) as D3DXVECTOR4 ptr
declare function D3DXVec4Scale alias "D3DXVec4Scale" (byval pOut as D3DXVECTOR4 ptr, byval pV as D3DXVECTOR4 ptr, byval s as FLOAT) as D3DXVECTOR4 ptr
declare function D3DXVec4Lerp alias "D3DXVec4Lerp" (byval pOut as D3DXVECTOR4 ptr, byval pV1 as D3DXVECTOR4 ptr, byval pV2 as D3DXVECTOR4 ptr, byval s as FLOAT) as D3DXVECTOR4 ptr
declare function D3DXVec4Cross alias "D3DXVec4Cross" (byval pOut as D3DXVECTOR4 ptr, byval pV1 as D3DXVECTOR4 ptr, byval pV2 as D3DXVECTOR4 ptr, byval pV3 as D3DXVECTOR4 ptr) as D3DXVECTOR4 ptr
declare function D3DXVec4Normalize alias "D3DXVec4Normalize" (byval pOut as D3DXVECTOR4 ptr, byval pV as D3DXVECTOR4 ptr) as D3DXVECTOR4 ptr
declare function D3DXVec4Hermite alias "D3DXVec4Hermite" (byval pOut as D3DXVECTOR4 ptr, byval pV1 as D3DXVECTOR4 ptr, byval pT1 as D3DXVECTOR4 ptr, byval pV2 as D3DXVECTOR4 ptr, byval pT2 as D3DXVECTOR4 ptr, byval s as FLOAT) as D3DXVECTOR4 ptr
declare function D3DXVec4CatmullRom alias "D3DXVec4CatmullRom" (byval pOut as D3DXVECTOR4 ptr, byval pV0 as D3DXVECTOR4 ptr, byval pV1 as D3DXVECTOR4 ptr, byval pV2 as D3DXVECTOR4 ptr, byval pV3 as D3DXVECTOR4 ptr, byval s as FLOAT) as D3DXVECTOR4 ptr
declare function D3DXVec4BaryCentric alias "D3DXVec4BaryCentric" (byval pOut as D3DXVECTOR4 ptr, byval pV1 as D3DXVECTOR4 ptr, byval pV2 as D3DXVECTOR4 ptr, byval pV3 as D3DXVECTOR4 ptr, byval f as FLOAT, byval g as FLOAT) as D3DXVECTOR4 ptr
declare function D3DXVec4Transform alias "D3DXVec4Transform" (byval pOut as D3DXVECTOR4 ptr, byval pV as D3DXVECTOR4 ptr, byval pM as D3DXMATRIX ptr) as D3DXVECTOR4 ptr
declare function D3DXVec4TransformArray alias "D3DXVec4TransformArray" (byval pOut as D3DXVECTOR4 ptr, byval OutStride as UINT, byval pV as D3DXVECTOR4 ptr, byval VStride as UINT, byval pM as D3DXMATRIX ptr, byval n as UINT) as D3DXVECTOR4 ptr
declare function D3DXMatrixIdentity alias "D3DXMatrixIdentity" (byval pOut as D3DXMATRIX ptr) as D3DXMATRIX ptr
declare function D3DXMatrixIsIdentity alias "D3DXMatrixIsIdentity" (byval pM as D3DXMATRIX ptr) as BOOL
declare function D3DXMatrixDeterminant alias "D3DXMatrixDeterminant" (byval pM as D3DXMATRIX ptr) as FLOAT
declare function D3DXMatrixDecompose alias "D3DXMatrixDecompose" (byval pOutScale as D3DXVECTOR3 ptr, byval pOutRotation as D3DXQUATERNION ptr, byval pOutTranslation as D3DXVECTOR3 ptr, byval pM as D3DXMATRIX ptr) as HRESULT
declare function D3DXMatrixTranspose alias "D3DXMatrixTranspose" (byval pOut as D3DXMATRIX ptr, byval pM as D3DXMATRIX ptr) as D3DXMATRIX ptr
declare function D3DXMatrixMultiply alias "D3DXMatrixMultiply" (byval pOut as D3DXMATRIX ptr, byval pM1 as D3DXMATRIX ptr, byval pM2 as D3DXMATRIX ptr) as D3DXMATRIX ptr
declare function D3DXMatrixMultiplyTranspose alias "D3DXMatrixMultiplyTranspose" (byval pOut as D3DXMATRIX ptr, byval pM1 as D3DXMATRIX ptr, byval pM2 as D3DXMATRIX ptr) as D3DXMATRIX ptr
declare function D3DXMatrixInverse alias "D3DXMatrixInverse" (byval pOut as D3DXMATRIX ptr, byval pDeterminant as FLOAT ptr, byval pM as D3DXMATRIX ptr) as D3DXMATRIX ptr
declare function D3DXMatrixScaling alias "D3DXMatrixScaling" (byval pOut as D3DXMATRIX ptr, byval sx as FLOAT, byval sy as FLOAT, byval sz as FLOAT) as D3DXMATRIX ptr
declare function D3DXMatrixTranslation alias "D3DXMatrixTranslation" (byval pOut as D3DXMATRIX ptr, byval x as FLOAT, byval y as FLOAT, byval z as FLOAT) as D3DXMATRIX ptr
declare function D3DXMatrixRotationX alias "D3DXMatrixRotationX" (byval pOut as D3DXMATRIX ptr, byval Angle as FLOAT) as D3DXMATRIX ptr
declare function D3DXMatrixRotationY alias "D3DXMatrixRotationY" (byval pOut as D3DXMATRIX ptr, byval Angle as FLOAT) as D3DXMATRIX ptr
declare function D3DXMatrixRotationZ alias "D3DXMatrixRotationZ" (byval pOut as D3DXMATRIX ptr, byval Angle as FLOAT) as D3DXMATRIX ptr
declare function D3DXMatrixRotationAxis alias "D3DXMatrixRotationAxis" (byval pOut as D3DXMATRIX ptr, byval pV as D3DXVECTOR3 ptr, byval Angle as FLOAT) as D3DXMATRIX ptr
declare function D3DXMatrixRotationQuaternion alias "D3DXMatrixRotationQuaternion" (byval pOut as D3DXMATRIX ptr, byval pQ as D3DXQUATERNION ptr) as D3DXMATRIX ptr
declare function D3DXMatrixRotationYawPitchRoll alias "D3DXMatrixRotationYawPitchRoll" (byval pOut as D3DXMATRIX ptr, byval Yaw as FLOAT, byval Pitch as FLOAT, byval Roll as FLOAT) as D3DXMATRIX ptr
declare function D3DXMatrixTransformation alias "D3DXMatrixTransformation" (byval pOut as D3DXMATRIX ptr, byval pScalingCenter as D3DXVECTOR3 ptr, byval pScalingRotation as D3DXQUATERNION ptr, byval pScaling as D3DXVECTOR3 ptr, byval pRotationCenter as D3DXVECTOR3 ptr, byval pRotation as D3DXQUATERNION ptr, byval pTranslation as D3DXVECTOR3 ptr) as D3DXMATRIX ptr
declare function D3DXMatrixTransformation2D alias "D3DXMatrixTransformation2D" (byval pOut as D3DXMATRIX ptr, byval pScalingCenter as D3DXVECTOR2 ptr, byval ScalingRotation as FLOAT, byval pScaling as D3DXVECTOR2 ptr, byval pRotationCenter as D3DXVECTOR2 ptr, byval Rotation as FLOAT, byval pTranslation as D3DXVECTOR2 ptr) as D3DXMATRIX ptr
declare function D3DXMatrixAffineTransformation alias "D3DXMatrixAffineTransformation" (byval pOut as D3DXMATRIX ptr, byval Scaling as FLOAT, byval pRotationCenter as D3DXVECTOR3 ptr, byval pRotation as D3DXQUATERNION ptr, byval pTranslation as D3DXVECTOR3 ptr) as D3DXMATRIX ptr
declare function D3DXMatrixAffineTransformation2D alias "D3DXMatrixAffineTransformation2D" (byval pOut as D3DXMATRIX ptr, byval Scaling as FLOAT, byval pRotationCenter as D3DXVECTOR2 ptr, byval Rotation as FLOAT, byval pTranslation as D3DXVECTOR2 ptr) as D3DXMATRIX ptr
declare function D3DXMatrixLookAtRH alias "D3DXMatrixLookAtRH" (byval pOut as D3DXMATRIX ptr, byval pEye as D3DXVECTOR3 ptr, byval pAt as D3DXVECTOR3 ptr, byval pUp as D3DXVECTOR3 ptr) as D3DXMATRIX ptr
declare function D3DXMatrixLookAtLH alias "D3DXMatrixLookAtLH" (byval pOut as D3DXMATRIX ptr, byval pEye as D3DXVECTOR3 ptr, byval pAt as D3DXVECTOR3 ptr, byval pUp as D3DXVECTOR3 ptr) as D3DXMATRIX ptr
declare function D3DXMatrixPerspectiveRH alias "D3DXMatrixPerspectiveRH" (byval pOut as D3DXMATRIX ptr, byval w as FLOAT, byval h as FLOAT, byval zn as FLOAT, byval zf as FLOAT) as D3DXMATRIX ptr
declare function D3DXMatrixPerspectiveLH alias "D3DXMatrixPerspectiveLH" (byval pOut as D3DXMATRIX ptr, byval w as FLOAT, byval h as FLOAT, byval zn as FLOAT, byval zf as FLOAT) as D3DXMATRIX ptr
declare function D3DXMatrixPerspectiveFovRH alias "D3DXMatrixPerspectiveFovRH" (byval pOut as D3DXMATRIX ptr, byval fovy as FLOAT, byval Aspect as FLOAT, byval zn as FLOAT, byval zf as FLOAT) as D3DXMATRIX ptr
declare function D3DXMatrixPerspectiveFovLH alias "D3DXMatrixPerspectiveFovLH" (byval pOut as D3DXMATRIX ptr, byval fovy as FLOAT, byval Aspect as FLOAT, byval zn as FLOAT, byval zf as FLOAT) as D3DXMATRIX ptr
declare function D3DXMatrixPerspectiveOffCenterRH alias "D3DXMatrixPerspectiveOffCenterRH" (byval pOut as D3DXMATRIX ptr, byval l as FLOAT, byval r as FLOAT, byval b as FLOAT, byval t as FLOAT, byval zn as FLOAT, byval zf as FLOAT) as D3DXMATRIX ptr
declare function D3DXMatrixPerspectiveOffCenterLH alias "D3DXMatrixPerspectiveOffCenterLH" (byval pOut as D3DXMATRIX ptr, byval l as FLOAT, byval r as FLOAT, byval b as FLOAT, byval t as FLOAT, byval zn as FLOAT, byval zf as FLOAT) as D3DXMATRIX ptr
declare function D3DXMatrixOrthoRH alias "D3DXMatrixOrthoRH" (byval pOut as D3DXMATRIX ptr, byval w as FLOAT, byval h as FLOAT, byval zn as FLOAT, byval zf as FLOAT) as D3DXMATRIX ptr
declare function D3DXMatrixOrthoLH alias "D3DXMatrixOrthoLH" (byval pOut as D3DXMATRIX ptr, byval w as FLOAT, byval h as FLOAT, byval zn as FLOAT, byval zf as FLOAT) as D3DXMATRIX ptr
declare function D3DXMatrixOrthoOffCenterRH alias "D3DXMatrixOrthoOffCenterRH" (byval pOut as D3DXMATRIX ptr, byval l as FLOAT, byval r as FLOAT, byval b as FLOAT, byval t as FLOAT, byval zn as FLOAT, byval zf as FLOAT) as D3DXMATRIX ptr
declare function D3DXMatrixOrthoOffCenterLH alias "D3DXMatrixOrthoOffCenterLH" (byval pOut as D3DXMATRIX ptr, byval l as FLOAT, byval r as FLOAT, byval b as FLOAT, byval t as FLOAT, byval zn as FLOAT, byval zf as FLOAT) as D3DXMATRIX ptr
declare function D3DXMatrixShadow alias "D3DXMatrixShadow" (byval pOut as D3DXMATRIX ptr, byval pLight as D3DXVECTOR4 ptr, byval pPlane as D3DXPLANE ptr) as D3DXMATRIX ptr
declare function D3DXMatrixReflect alias "D3DXMatrixReflect" (byval pOut as D3DXMATRIX ptr, byval pPlane as D3DXPLANE ptr) as D3DXMATRIX ptr
declare function D3DXQuaternionLength alias "D3DXQuaternionLength" (byval pQ as D3DXQUATERNION ptr) as FLOAT
declare function D3DXQuaternionLengthSq alias "D3DXQuaternionLengthSq" (byval pQ as D3DXQUATERNION ptr) as FLOAT
declare function D3DXQuaternionDot alias "D3DXQuaternionDot" (byval pQ1 as D3DXQUATERNION ptr, byval pQ2 as D3DXQUATERNION ptr) as FLOAT
declare function D3DXQuaternionIdentity alias "D3DXQuaternionIdentity" (byval pOut as D3DXQUATERNION ptr) as D3DXQUATERNION ptr
declare function D3DXQuaternionIsIdentity alias "D3DXQuaternionIsIdentity" (byval pQ as D3DXQUATERNION ptr) as BOOL
declare function D3DXQuaternionConjugate alias "D3DXQuaternionConjugate" (byval pOut as D3DXQUATERNION ptr, byval pQ as D3DXQUATERNION ptr) as D3DXQUATERNION ptr
declare sub D3DXQuaternionToAxisAngle alias "D3DXQuaternionToAxisAngle" (byval pQ as D3DXQUATERNION ptr, byval pAxis as D3DXVECTOR3 ptr, byval pAngle as FLOAT ptr)
declare function D3DXQuaternionRotationMatrix alias "D3DXQuaternionRotationMatrix" (byval pOut as D3DXQUATERNION ptr, byval pM as D3DXMATRIX ptr) as D3DXQUATERNION ptr
declare function D3DXQuaternionRotationAxis alias "D3DXQuaternionRotationAxis" (byval pOut as D3DXQUATERNION ptr, byval pV as D3DXVECTOR3 ptr, byval Angle as FLOAT) as D3DXQUATERNION ptr
declare function D3DXQuaternionRotationYawPitchRoll alias "D3DXQuaternionRotationYawPitchRoll" (byval pOut as D3DXQUATERNION ptr, byval Yaw as FLOAT, byval Pitch as FLOAT, byval Roll as FLOAT) as D3DXQUATERNION ptr
declare function D3DXQuaternionMultiply alias "D3DXQuaternionMultiply" (byval pOut as D3DXQUATERNION ptr, byval pQ1 as D3DXQUATERNION ptr, byval pQ2 as D3DXQUATERNION ptr) as D3DXQUATERNION ptr
declare function D3DXQuaternionNormalize alias "D3DXQuaternionNormalize" (byval pOut as D3DXQUATERNION ptr, byval pQ as D3DXQUATERNION ptr) as D3DXQUATERNION ptr
declare function D3DXQuaternionInverse alias "D3DXQuaternionInverse" (byval pOut as D3DXQUATERNION ptr, byval pQ as D3DXQUATERNION ptr) as D3DXQUATERNION ptr
declare function D3DXQuaternionLn alias "D3DXQuaternionLn" (byval pOut as D3DXQUATERNION ptr, byval pQ as D3DXQUATERNION ptr) as D3DXQUATERNION ptr
declare function D3DXQuaternionExp alias "D3DXQuaternionExp" (byval pOut as D3DXQUATERNION ptr, byval pQ as D3DXQUATERNION ptr) as D3DXQUATERNION ptr
declare function D3DXQuaternionSlerp alias "D3DXQuaternionSlerp" (byval pOut as D3DXQUATERNION ptr, byval pQ1 as D3DXQUATERNION ptr, byval pQ2 as D3DXQUATERNION ptr, byval t as FLOAT) as D3DXQUATERNION ptr
declare function D3DXQuaternionSquad alias "D3DXQuaternionSquad" (byval pOut as D3DXQUATERNION ptr, byval pQ1 as D3DXQUATERNION ptr, byval pA as D3DXQUATERNION ptr, byval pB as D3DXQUATERNION ptr, byval pC as D3DXQUATERNION ptr, byval t as FLOAT) as D3DXQUATERNION ptr
declare sub D3DXQuaternionSquadSetup alias "D3DXQuaternionSquadSetup" (byval pAOut as D3DXQUATERNION ptr, byval pBOut as D3DXQUATERNION ptr, byval pCOut as D3DXQUATERNION ptr, byval pQ0 as D3DXQUATERNION ptr, byval pQ1 as D3DXQUATERNION ptr, byval pQ2 as D3DXQUATERNION ptr, byval pQ3 as D3DXQUATERNION ptr)
declare function D3DXQuaternionBaryCentric alias "D3DXQuaternionBaryCentric" (byval pOut as D3DXQUATERNION ptr, byval pQ1 as D3DXQUATERNION ptr, byval pQ2 as D3DXQUATERNION ptr, byval pQ3 as D3DXQUATERNION ptr, byval f as FLOAT, byval g as FLOAT) as D3DXQUATERNION ptr
declare function D3DXPlaneDot alias "D3DXPlaneDot" (byval pP as D3DXPLANE ptr, byval pV as D3DXVECTOR4 ptr) as FLOAT
declare function D3DXPlaneDotCoord alias "D3DXPlaneDotCoord" (byval pP as D3DXPLANE ptr, byval pV as D3DXVECTOR3 ptr) as FLOAT
declare function D3DXPlaneDotNormal alias "D3DXPlaneDotNormal" (byval pP as D3DXPLANE ptr, byval pV as D3DXVECTOR3 ptr) as FLOAT
declare function D3DXPlaneScale alias "D3DXPlaneScale" (byval pOut as D3DXPLANE ptr, byval pP as D3DXPLANE ptr, byval s as FLOAT) as D3DXPLANE ptr
declare function D3DXPlaneNormalize alias "D3DXPlaneNormalize" (byval pOut as D3DXPLANE ptr, byval pP as D3DXPLANE ptr) as D3DXPLANE ptr
declare function D3DXPlaneIntersectLine alias "D3DXPlaneIntersectLine" (byval pOut as D3DXVECTOR3 ptr, byval pP as D3DXPLANE ptr, byval pV1 as D3DXVECTOR3 ptr, byval pV2 as D3DXVECTOR3 ptr) as D3DXVECTOR3 ptr
declare function D3DXPlaneFromPointNormal alias "D3DXPlaneFromPointNormal" (byval pOut as D3DXPLANE ptr, byval pPoint as D3DXVECTOR3 ptr, byval pNormal as D3DXVECTOR3 ptr) as D3DXPLANE ptr
declare function D3DXPlaneFromPoints alias "D3DXPlaneFromPoints" (byval pOut as D3DXPLANE ptr, byval pV1 as D3DXVECTOR3 ptr, byval pV2 as D3DXVECTOR3 ptr, byval pV3 as D3DXVECTOR3 ptr) as D3DXPLANE ptr
declare function D3DXPlaneTransform alias "D3DXPlaneTransform" (byval pOut as D3DXPLANE ptr, byval pP as D3DXPLANE ptr, byval pM as D3DXMATRIX ptr) as D3DXPLANE ptr
declare function D3DXPlaneTransformArray alias "D3DXPlaneTransformArray" (byval pOut as D3DXPLANE ptr, byval OutStride as UINT, byval pP as D3DXPLANE ptr, byval PStride as UINT, byval pM as D3DXMATRIX ptr, byval n as UINT) as D3DXPLANE ptr
declare function D3DXColorNegative alias "D3DXColorNegative" (byval pOut as D3DXCOLOR ptr, byval pC as D3DXCOLOR ptr) as D3DXCOLOR ptr
declare function D3DXColorAdd alias "D3DXColorAdd" (byval pOut as D3DXCOLOR ptr, byval pC1 as D3DXCOLOR ptr, byval pC2 as D3DXCOLOR ptr) as D3DXCOLOR ptr
declare function D3DXColorSubtract alias "D3DXColorSubtract" (byval pOut as D3DXCOLOR ptr, byval pC1 as D3DXCOLOR ptr, byval pC2 as D3DXCOLOR ptr) as D3DXCOLOR ptr
declare function D3DXColorScale alias "D3DXColorScale" (byval pOut as D3DXCOLOR ptr, byval pC as D3DXCOLOR ptr, byval s as FLOAT) as D3DXCOLOR ptr
declare function D3DXColorModulate alias "D3DXColorModulate" (byval pOut as D3DXCOLOR ptr, byval pC1 as D3DXCOLOR ptr, byval pC2 as D3DXCOLOR ptr) as D3DXCOLOR ptr
declare function D3DXColorLerp alias "D3DXColorLerp" (byval pOut as D3DXCOLOR ptr, byval pC1 as D3DXCOLOR ptr, byval pC2 as D3DXCOLOR ptr, byval s as FLOAT) as D3DXCOLOR ptr
declare function D3DXColorAdjustSaturation alias "D3DXColorAdjustSaturation" (byval pOut as D3DXCOLOR ptr, byval pC as D3DXCOLOR ptr, byval s as FLOAT) as D3DXCOLOR ptr
declare function D3DXColorAdjustContrast alias "D3DXColorAdjustContrast" (byval pOut as D3DXCOLOR ptr, byval pC as D3DXCOLOR ptr, byval c as FLOAT) as D3DXCOLOR ptr
declare function D3DXFresnelTerm alias "D3DXFresnelTerm" (byval CosTheta as FLOAT, byval RefractionIndex as FLOAT) as FLOAT

type LPD3DXMATRIXSTACK as ID3DXMatrixStack ptr

extern IID_ID3DXMatrixStack alias "IID_ID3DXMatrixStack" as GUID

type ID3DXMatrixStackVtbl_ as ID3DXMatrixStackVtbl

type ID3DXMatrixStack
	lpVtbl as ID3DXMatrixStackVtbl_ ptr
end type

type ID3DXMatrixStackVtbl
	QueryInterface as function(byval as ID3DXMatrixStack ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as ID3DXMatrixStack ptr) as ULONG
	Release as function(byval as ID3DXMatrixStack ptr) as ULONG
	Pop as function(byval as ID3DXMatrixStack ptr) as HRESULT
	Push as function(byval as ID3DXMatrixStack ptr) as HRESULT
	LoadIdentity as function(byval as ID3DXMatrixStack ptr) as HRESULT
	LoadMatrix as function(byval as ID3DXMatrixStack ptr, byval as D3DXMATRIX ptr) as HRESULT
	MultMatrix as function(byval as ID3DXMatrixStack ptr, byval as D3DXMATRIX ptr) as HRESULT
	MultMatrixLocal as function(byval as ID3DXMatrixStack ptr, byval as D3DXMATRIX ptr) as HRESULT
	RotateAxis as function(byval as ID3DXMatrixStack ptr, byval as D3DXVECTOR3 ptr, byval as FLOAT) as HRESULT
	RotateAxisLocal as function(byval as ID3DXMatrixStack ptr, byval as D3DXVECTOR3 ptr, byval as FLOAT) as HRESULT
	RotateYawPitchRoll as function(byval as ID3DXMatrixStack ptr, byval as FLOAT, byval as FLOAT, byval as FLOAT) as HRESULT
	RotateYawPitchRollLocal as function(byval as ID3DXMatrixStack ptr, byval as FLOAT, byval as FLOAT, byval as FLOAT) as HRESULT
	Scale as function(byval as ID3DXMatrixStack ptr, byval as FLOAT, byval as FLOAT, byval as FLOAT) as HRESULT
	ScaleLocal as function(byval as ID3DXMatrixStack ptr, byval as FLOAT, byval as FLOAT, byval as FLOAT) as HRESULT
	Translate as function(byval as ID3DXMatrixStack ptr, byval as FLOAT, byval as FLOAT, byval as FLOAT) as HRESULT
	TranslateLocal as function(byval as ID3DXMatrixStack ptr, byval as FLOAT, byval as FLOAT, byval as FLOAT) as HRESULT
	GetTop as function(byval as ID3DXMatrixStack ptr) as D3DXMATRIX ptr
end type

declare function D3DXCreateMatrixStack alias "D3DXCreateMatrixStack" (byval Flags as DWORD, byval ppStack as LPD3DXMATRIXSTACK ptr) as HRESULT

#define D3DXSH_MINORDER 2
#define D3DXSH_MAXORDER 6

declare function D3DXSHEvalDirection alias "D3DXSHEvalDirection" (byval pOut as FLOAT ptr, byval Order as UINT, byval pDir as D3DXVECTOR3 ptr) as FLOAT ptr
declare function D3DXSHRotate alias "D3DXSHRotate" (byval pOut as FLOAT ptr, byval Order as UINT, byval pMatrix as D3DXMATRIX ptr, byval pIn as FLOAT ptr) as FLOAT ptr
declare function D3DXSHRotateZ alias "D3DXSHRotateZ" (byval pOut as FLOAT ptr, byval Order as UINT, byval Angle as FLOAT, byval pIn as FLOAT ptr) as FLOAT ptr
declare function D3DXSHAdd alias "D3DXSHAdd" (byval pOut as FLOAT ptr, byval Order as UINT, byval pA as FLOAT ptr, byval pB as FLOAT ptr) as FLOAT ptr
declare function D3DXSHScale alias "D3DXSHScale" (byval pOut as FLOAT ptr, byval Order as UINT, byval pIn as FLOAT ptr, byval Scale as FLOAT) as FLOAT ptr
declare function D3DXSHDot alias "D3DXSHDot" (byval Order as UINT, byval pA as FLOAT ptr, byval pB as FLOAT ptr) as FLOAT
declare function D3DXSHEvalDirectionalLight alias "D3DXSHEvalDirectionalLight" (byval Order as UINT, byval pDir as D3DXVECTOR3 ptr, byval RIntensity as FLOAT, byval GIntensity as FLOAT, byval BIntensity as FLOAT, byval pROut as FLOAT ptr, byval pGOut as FLOAT ptr, byval pBOut as FLOAT ptr) as HRESULT
declare function D3DXSHEvalSphericalLight alias "D3DXSHEvalSphericalLight" (byval Order as UINT, byval pPos as D3DXVECTOR3 ptr, byval Radius as FLOAT, byval RIntensity as FLOAT, byval GIntensity as FLOAT, byval BIntensity as FLOAT, byval pROut as FLOAT ptr, byval pGOut as FLOAT ptr, byval pBOut as FLOAT ptr) as HRESULT
declare function D3DXSHEvalConeLight alias "D3DXSHEvalConeLight" (byval Order as UINT, byval pDir as D3DXVECTOR3 ptr, byval Radius as FLOAT, byval RIntensity as FLOAT, byval GIntensity as FLOAT, byval BIntensity as FLOAT, byval pROut as FLOAT ptr, byval pGOut as FLOAT ptr, byval pBOut as FLOAT ptr) as HRESULT
declare function D3DXSHEvalHemisphereLight alias "D3DXSHEvalHemisphereLight" (byval Order as UINT, byval pDir as D3DXVECTOR3 ptr, byval Top as D3DXCOLOR, byval Bottom as D3DXCOLOR, byval pROut as FLOAT ptr, byval pGOut as FLOAT ptr, byval pBOut as FLOAT ptr) as HRESULT
declare function D3DXSHProjectCubeMap alias "D3DXSHProjectCubeMap" (byval uOrder as UINT, byval pCubeMap as LPDIRECT3DCUBETEXTURE9, byval pROut as FLOAT ptr, byval pGOut as FLOAT ptr, byval pBOut as FLOAT ptr) as HRESULT

#endif
