''
''
'' d3dxmath -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_d3dxmath_bi__
#define __win_d3dxmath_bi__

#include once "win/d3d.bi"
#include once "win/d3dxerr.bi"

type LPD3DXMATRIXSTACK as ID3DXMatrixStack ptr
extern IID_ID3DXMatrixStack alias "IID_ID3DXMatrixStack" as GUID

#define D3DX_PI    csng(3.141592654f)
#define D3DX_1BYPI csng(0.318309886f)

#define D3DXToRadian( degree ) ((degree) * (D3DX_PI / 180.0))
#define D3DXToDegree( radian ) ((radian) * (180.0 / D3DX_PI))

type D3DXVECTOR2
	x as single
	y as single
end type

type LPD3DXVECTOR2 as D3DXVECTOR2 ptr

type D3DXVECTOR3
	x as single
	y as single
	z as single
end type

type LPD3DXVECTOR3 as D3DXVECTOR3 ptr

type D3DXVECTOR4
	x as single
	y as single
	z as single
	w as single
end type

type LPD3DXVECTOR4 as D3DXVECTOR4 ptr

union D3DXMATRIX
	m(0 to 4-1, 0 to 4-1) as single
	type
		as single m00, m01, m02, m03
        as single m10, m11, m12, m13
        as single m20, m21, m22, m23
        as single m30, m31, m32, m33
	end type
end union

type LPD3DXMATRIX as D3DXMATRIX ptr

type D3DXQUATERNION
	x as single
	y as single
	z as single
	w as single
end type

type LPD3DXQUATERNION as D3DXQUATERNION ptr

type D3DXPLANE
	a as single
	b as single
	c as single
	d as single
end type

type LPD3DXPLANE as D3DXPLANE ptr

type D3DXCOLOR
	r as FLOAT
	g as FLOAT
	b as FLOAT
	a as FLOAT
end type

type LPD3DXCOLOR as D3DXCOLOR ptr

declare function D3DXVec2Length alias "D3DXVec2Length" (byval pV as D3DXVECTOR2 ptr) as single
declare function D3DXVec2LengthSq alias "D3DXVec2LengthSq" (byval pV as D3DXVECTOR2 ptr) as single
declare function D3DXVec2Dot alias "D3DXVec2Dot" (byval pV1 as D3DXVECTOR2 ptr, byval pV2 as D3DXVECTOR2 ptr) as single
declare function D3DXVec2CCW alias "D3DXVec2CCW" (byval pV1 as D3DXVECTOR2 ptr, byval pV2 as D3DXVECTOR2 ptr) as single
declare function D3DXVec2Add alias "D3DXVec2Add" (byval pOut as D3DXVECTOR2 ptr, byval pV1 as D3DXVECTOR2 ptr, byval pV2 as D3DXVECTOR2 ptr) as D3DXVECTOR2 ptr
declare function D3DXVec2Subtract alias "D3DXVec2Subtract" (byval pOut as D3DXVECTOR2 ptr, byval pV1 as D3DXVECTOR2 ptr, byval pV2 as D3DXVECTOR2 ptr) as D3DXVECTOR2 ptr
declare function D3DXVec2Minimize alias "D3DXVec2Minimize" (byval pOut as D3DXVECTOR2 ptr, byval pV1 as D3DXVECTOR2 ptr, byval pV2 as D3DXVECTOR2 ptr) as D3DXVECTOR2 ptr
declare function D3DXVec2Maximize alias "D3DXVec2Maximize" (byval pOut as D3DXVECTOR2 ptr, byval pV1 as D3DXVECTOR2 ptr, byval pV2 as D3DXVECTOR2 ptr) as D3DXVECTOR2 ptr
declare function D3DXVec2Scale alias "D3DXVec2Scale" (byval pOut as D3DXVECTOR2 ptr, byval pV as D3DXVECTOR2 ptr, byval s as single) as D3DXVECTOR2 ptr
declare function D3DXVec2Lerp alias "D3DXVec2Lerp" (byval pOut as D3DXVECTOR2 ptr, byval pV1 as D3DXVECTOR2 ptr, byval pV2 as D3DXVECTOR2 ptr, byval s as single) as D3DXVECTOR2 ptr
declare function D3DXVec2Normalize alias "D3DXVec2Normalize" (byval pOut as D3DXVECTOR2 ptr, byval pV as D3DXVECTOR2 ptr) as D3DXVECTOR2 ptr
declare function D3DXVec2Hermite alias "D3DXVec2Hermite" (byval pOut as D3DXVECTOR2 ptr, byval pV1 as D3DXVECTOR2 ptr, byval pT1 as D3DXVECTOR2 ptr, byval pV2 as D3DXVECTOR2 ptr, byval pT2 as D3DXVECTOR2 ptr, byval s as single) as D3DXVECTOR2 ptr
declare function D3DXVec2BaryCentric alias "D3DXVec2BaryCentric" (byval pOut as D3DXVECTOR2 ptr, byval pV1 as D3DXVECTOR2 ptr, byval pV2 as D3DXVECTOR2 ptr, byval pV3 as D3DXVECTOR2 ptr, byval f as single, byval g as single) as D3DXVECTOR2 ptr
declare function D3DXVec2Transform alias "D3DXVec2Transform" (byval pOut as D3DXVECTOR4 ptr, byval pV as D3DXVECTOR2 ptr, byval pM as D3DXMATRIX ptr) as D3DXVECTOR4 ptr
declare function D3DXVec2TransformCoord alias "D3DXVec2TransformCoord" (byval pOut as D3DXVECTOR2 ptr, byval pV as D3DXVECTOR2 ptr, byval pM as D3DXMATRIX ptr) as D3DXVECTOR2 ptr
declare function D3DXVec2TransformNormal alias "D3DXVec2TransformNormal" (byval pOut as D3DXVECTOR2 ptr, byval pV as D3DXVECTOR2 ptr, byval pM as D3DXMATRIX ptr) as D3DXVECTOR2 ptr
declare function D3DXVec3Length alias "D3DXVec3Length" (byval pV as D3DXVECTOR3 ptr) as single
declare function D3DXVec3LengthSq alias "D3DXVec3LengthSq" (byval pV as D3DXVECTOR3 ptr) as single
declare function D3DXVec3Dot alias "D3DXVec3Dot" (byval pV1 as D3DXVECTOR3 ptr, byval pV2 as D3DXVECTOR3 ptr) as single
declare function D3DXVec3Cross alias "D3DXVec3Cross" (byval pOut as D3DXVECTOR3 ptr, byval pV1 as D3DXVECTOR3 ptr, byval pV2 as D3DXVECTOR3 ptr) as D3DXVECTOR3 ptr
declare function D3DXVec3Add alias "D3DXVec3Add" (byval pOut as D3DXVECTOR3 ptr, byval pV1 as D3DXVECTOR3 ptr, byval pV2 as D3DXVECTOR3 ptr) as D3DXVECTOR3 ptr
declare function D3DXVec3Subtract alias "D3DXVec3Subtract" (byval pOut as D3DXVECTOR3 ptr, byval pV1 as D3DXVECTOR3 ptr, byval pV2 as D3DXVECTOR3 ptr) as D3DXVECTOR3 ptr
declare function D3DXVec3Minimize alias "D3DXVec3Minimize" (byval pOut as D3DXVECTOR3 ptr, byval pV1 as D3DXVECTOR3 ptr, byval pV2 as D3DXVECTOR3 ptr) as D3DXVECTOR3 ptr
declare function D3DXVec3Maximize alias "D3DXVec3Maximize" (byval pOut as D3DXVECTOR3 ptr, byval pV1 as D3DXVECTOR3 ptr, byval pV2 as D3DXVECTOR3 ptr) as D3DXVECTOR3 ptr
declare function D3DXVec3Scale alias "D3DXVec3Scale" (byval pOut as D3DXVECTOR3 ptr, byval pV as D3DXVECTOR3 ptr, byval s as single) as D3DXVECTOR3 ptr
declare function D3DXVec3Lerp alias "D3DXVec3Lerp" (byval pOut as D3DXVECTOR3 ptr, byval pV1 as D3DXVECTOR3 ptr, byval pV2 as D3DXVECTOR3 ptr, byval s as single) as D3DXVECTOR3 ptr
declare function D3DXVec3Normalize alias "D3DXVec3Normalize" (byval pOut as D3DXVECTOR3 ptr, byval pV as D3DXVECTOR3 ptr) as D3DXVECTOR3 ptr
declare function D3DXVec3Hermite alias "D3DXVec3Hermite" (byval pOut as D3DXVECTOR3 ptr, byval pV1 as D3DXVECTOR3 ptr, byval pT1 as D3DXVECTOR3 ptr, byval pV2 as D3DXVECTOR3 ptr, byval pT2 as D3DXVECTOR3 ptr, byval s as single) as D3DXVECTOR3 ptr
declare function D3DXVec3BaryCentric alias "D3DXVec3BaryCentric" (byval pOut as D3DXVECTOR3 ptr, byval pV1 as D3DXVECTOR3 ptr, byval pV2 as D3DXVECTOR3 ptr, byval pV3 as D3DXVECTOR3 ptr, byval f as single, byval g as single) as D3DXVECTOR3 ptr
declare function D3DXVec3Transform alias "D3DXVec3Transform" (byval pOut as D3DXVECTOR4 ptr, byval pV as D3DXVECTOR3 ptr, byval pM as D3DXMATRIX ptr) as D3DXVECTOR4 ptr
declare function D3DXVec3TransformCoord alias "D3DXVec3TransformCoord" (byval pOut as D3DXVECTOR3 ptr, byval pV as D3DXVECTOR3 ptr, byval pM as D3DXMATRIX ptr) as D3DXVECTOR3 ptr
declare function D3DXVec3TransformNormal alias "D3DXVec3TransformNormal" (byval pOut as D3DXVECTOR3 ptr, byval pV as D3DXVECTOR3 ptr, byval pM as D3DXMATRIX ptr) as D3DXVECTOR3 ptr
declare function D3DXVec4Length alias "D3DXVec4Length" (byval pV as D3DXVECTOR4 ptr) as single
declare function D3DXVec4LengthSq alias "D3DXVec4LengthSq" (byval pV as D3DXVECTOR4 ptr) as single
declare function D3DXVec4Dot alias "D3DXVec4Dot" (byval pV1 as D3DXVECTOR4 ptr, byval pV2 as D3DXVECTOR4 ptr) as single
declare function D3DXVec4Add alias "D3DXVec4Add" (byval pOut as D3DXVECTOR4 ptr, byval pV1 as D3DXVECTOR4 ptr, byval pV2 as D3DXVECTOR4 ptr) as D3DXVECTOR4 ptr
declare function D3DXVec4Subtract alias "D3DXVec4Subtract" (byval pOut as D3DXVECTOR4 ptr, byval pV1 as D3DXVECTOR4 ptr, byval pV2 as D3DXVECTOR4 ptr) as D3DXVECTOR4 ptr
declare function D3DXVec4Minimize alias "D3DXVec4Minimize" (byval pOut as D3DXVECTOR4 ptr, byval pV1 as D3DXVECTOR4 ptr, byval pV2 as D3DXVECTOR4 ptr) as D3DXVECTOR4 ptr
declare function D3DXVec4Maximize alias "D3DXVec4Maximize" (byval pOut as D3DXVECTOR4 ptr, byval pV1 as D3DXVECTOR4 ptr, byval pV2 as D3DXVECTOR4 ptr) as D3DXVECTOR4 ptr
declare function D3DXVec4Scale alias "D3DXVec4Scale" (byval pOut as D3DXVECTOR4 ptr, byval pV as D3DXVECTOR4 ptr, byval s as single) as D3DXVECTOR4 ptr
declare function D3DXVec4Lerp alias "D3DXVec4Lerp" (byval pOut as D3DXVECTOR4 ptr, byval pV1 as D3DXVECTOR4 ptr, byval pV2 as D3DXVECTOR4 ptr, byval s as single) as D3DXVECTOR4 ptr
declare function D3DXVec4Cross alias "D3DXVec4Cross" (byval pOut as D3DXVECTOR4 ptr, byval pV1 as D3DXVECTOR4 ptr, byval pV2 as D3DXVECTOR4 ptr, byval pV3 as D3DXVECTOR4 ptr) as D3DXVECTOR4 ptr
declare function D3DXVec4Normalize alias "D3DXVec4Normalize" (byval pOut as D3DXVECTOR4 ptr, byval pV as D3DXVECTOR4 ptr) as D3DXVECTOR4 ptr
declare function D3DXVec4Hermite alias "D3DXVec4Hermite" (byval pOut as D3DXVECTOR4 ptr, byval pV1 as D3DXVECTOR4 ptr, byval pT1 as D3DXVECTOR4 ptr, byval pV2 as D3DXVECTOR4 ptr, byval pT2 as D3DXVECTOR4 ptr, byval s as single) as D3DXVECTOR4 ptr
declare function D3DXVec4BaryCentric alias "D3DXVec4BaryCentric" (byval pOut as D3DXVECTOR4 ptr, byval pV1 as D3DXVECTOR4 ptr, byval pV2 as D3DXVECTOR4 ptr, byval pV3 as D3DXVECTOR4 ptr, byval f as single, byval g as single) as D3DXVECTOR4 ptr
declare function D3DXVec4Transform alias "D3DXVec4Transform" (byval pOut as D3DXVECTOR4 ptr, byval pV as D3DXVECTOR4 ptr, byval pM as D3DXMATRIX ptr) as D3DXVECTOR4 ptr
declare function D3DXMatrixIdentity alias "D3DXMatrixIdentity" (byval pOut as D3DXMATRIX ptr) as D3DXMATRIX ptr
declare function D3DXMatrixIsIdentity alias "D3DXMatrixIsIdentity" (byval pM as D3DXMATRIX ptr) as BOOL
declare function D3DXMatrixfDeterminant alias "D3DXMatrixfDeterminant" (byval pM as D3DXMATRIX ptr) as single
declare function D3DXMatrixMultiply alias "D3DXMatrixMultiply" (byval pOut as D3DXMATRIX ptr, byval pM1 as D3DXMATRIX ptr, byval pM2 as D3DXMATRIX ptr) as D3DXMATRIX ptr
declare function D3DXMatrixTranspose alias "D3DXMatrixTranspose" (byval pOut as D3DXMATRIX ptr, byval pM as D3DXMATRIX ptr) as D3DXMATRIX ptr
declare function D3DXMatrixInverse alias "D3DXMatrixInverse" (byval pOut as D3DXMATRIX ptr, byval pfDeterminant as single ptr, byval pM as D3DXMATRIX ptr) as D3DXMATRIX ptr
declare function D3DXMatrixScaling alias "D3DXMatrixScaling" (byval pOut as D3DXMATRIX ptr, byval sx as single, byval sy as single, byval sz as single) as D3DXMATRIX ptr
declare function D3DXMatrixTranslation alias "D3DXMatrixTranslation" (byval pOut as D3DXMATRIX ptr, byval x as single, byval y as single, byval z as single) as D3DXMATRIX ptr
declare function D3DXMatrixRotationX alias "D3DXMatrixRotationX" (byval pOut as D3DXMATRIX ptr, byval angle as single) as D3DXMATRIX ptr
declare function D3DXMatrixRotationY alias "D3DXMatrixRotationY" (byval pOut as D3DXMATRIX ptr, byval angle as single) as D3DXMATRIX ptr
declare function D3DXMatrixRotationZ alias "D3DXMatrixRotationZ" (byval pOut as D3DXMATRIX ptr, byval angle as single) as D3DXMATRIX ptr
declare function D3DXMatrixRotationAxis alias "D3DXMatrixRotationAxis" (byval pOut as D3DXMATRIX ptr, byval pV as D3DXVECTOR3 ptr, byval angle as single) as D3DXMATRIX ptr
declare function D3DXMatrixRotationQuaternion alias "D3DXMatrixRotationQuaternion" (byval pOut as D3DXMATRIX ptr, byval pQ as D3DXQUATERNION ptr) as D3DXMATRIX ptr
declare function D3DXMatrixRotationYawPitchRoll alias "D3DXMatrixRotationYawPitchRoll" (byval pOut as D3DXMATRIX ptr, byval yaw as single, byval pitch as single, byval roll as single) as D3DXMATRIX ptr
declare function D3DXMatrixTransformation alias "D3DXMatrixTransformation" (byval pOut as D3DXMATRIX ptr, byval pScalingCenter as D3DXVECTOR3 ptr, byval pScalingRotation as D3DXQUATERNION ptr, byval pScaling as D3DXVECTOR3 ptr, byval pRotationCenter as D3DXVECTOR3 ptr, byval pRotation as D3DXQUATERNION ptr, byval pTranslation as D3DXVECTOR3 ptr) as D3DXMATRIX ptr
declare function D3DXMatrixAffineTransformation alias "D3DXMatrixAffineTransformation" (byval pOut as D3DXMATRIX ptr, byval Scaling as single, byval pRotationCenter as D3DXVECTOR3 ptr, byval pRotation as D3DXQUATERNION ptr, byval pTranslation as D3DXVECTOR3 ptr) as D3DXMATRIX ptr
declare function D3DXMatrixLookAt alias "D3DXMatrixLookAt" (byval pOut as D3DXMATRIX ptr, byval pEye as D3DXVECTOR3 ptr, byval pAt as D3DXVECTOR3 ptr, byval pUp as D3DXVECTOR3 ptr) as D3DXMATRIX ptr
declare function D3DXMatrixLookAtLH alias "D3DXMatrixLookAtLH" (byval pOut as D3DXMATRIX ptr, byval pEye as D3DXVECTOR3 ptr, byval pAt as D3DXVECTOR3 ptr, byval pUp as D3DXVECTOR3 ptr) as D3DXMATRIX ptr
declare function D3DXMatrixPerspective alias "D3DXMatrixPerspective" (byval pOut as D3DXMATRIX ptr, byval w as single, byval h as single, byval zn as single, byval zf as single) as D3DXMATRIX ptr
declare function D3DXMatrixPerspectiveLH alias "D3DXMatrixPerspectiveLH" (byval pOut as D3DXMATRIX ptr, byval w as single, byval h as single, byval zn as single, byval zf as single) as D3DXMATRIX ptr
declare function D3DXMatrixPerspectiveFov alias "D3DXMatrixPerspectiveFov" (byval pOut as D3DXMATRIX ptr, byval fovy as single, byval aspect as single, byval zn as single, byval zf as single) as D3DXMATRIX ptr
declare function D3DXMatrixPerspectiveFovLH alias "D3DXMatrixPerspectiveFovLH" (byval pOut as D3DXMATRIX ptr, byval fovy as single, byval aspect as single, byval zn as single, byval zf as single) as D3DXMATRIX ptr
declare function D3DXMatrixPerspectiveOffCenter alias "D3DXMatrixPerspectiveOffCenter" (byval pOut as D3DXMATRIX ptr, byval l as single, byval r as single, byval b as single, byval t as single, byval zn as single, byval zf as single) as D3DXMATRIX ptr
declare function D3DXMatrixPerspectiveOffCenterLH alias "D3DXMatrixPerspectiveOffCenterLH" (byval pOut as D3DXMATRIX ptr, byval l as single, byval r as single, byval b as single, byval t as single, byval zn as single, byval zf as single) as D3DXMATRIX ptr
declare function D3DXMatrixOrtho alias "D3DXMatrixOrtho" (byval pOut as D3DXMATRIX ptr, byval w as single, byval h as single, byval zn as single, byval zf as single) as D3DXMATRIX ptr
declare function D3DXMatrixOrthoLH alias "D3DXMatrixOrthoLH" (byval pOut as D3DXMATRIX ptr, byval w as single, byval h as single, byval zn as single, byval zf as single) as D3DXMATRIX ptr
declare function D3DXMatrixOrthoOffCenter alias "D3DXMatrixOrthoOffCenter" (byval pOut as D3DXMATRIX ptr, byval l as single, byval r as single, byval b as single, byval t as single, byval zn as single, byval zf as single) as D3DXMATRIX ptr
declare function D3DXMatrixOrthoOffCenterLH alias "D3DXMatrixOrthoOffCenterLH" (byval pOut as D3DXMATRIX ptr, byval l as single, byval r as single, byval b as single, byval t as single, byval zn as single, byval zf as single) as D3DXMATRIX ptr
declare function D3DXMatrixShadow alias "D3DXMatrixShadow" (byval pOut as D3DXMATRIX ptr, byval pLight as D3DXVECTOR4 ptr, byval pPlane as D3DXPLANE ptr) as D3DXMATRIX ptr
declare function D3DXMatrixReflect alias "D3DXMatrixReflect" (byval pOut as D3DXMATRIX ptr, byval pPlane as D3DXPLANE ptr) as D3DXMATRIX ptr
declare function D3DXQuaternionLength alias "D3DXQuaternionLength" (byval pQ as D3DXQUATERNION ptr) as single
declare function D3DXQuaternionLengthSq alias "D3DXQuaternionLengthSq" (byval pQ as D3DXQUATERNION ptr) as single
declare function D3DXQuaternionDot alias "D3DXQuaternionDot" (byval pQ1 as D3DXQUATERNION ptr, byval pQ2 as D3DXQUATERNION ptr) as single
declare function D3DXQuaternionIdentity alias "D3DXQuaternionIdentity" (byval pOut as D3DXQUATERNION ptr) as D3DXQUATERNION ptr
declare function D3DXQuaternionIsIdentity alias "D3DXQuaternionIsIdentity" (byval pQ as D3DXQUATERNION ptr) as BOOL
declare function D3DXQuaternionConjugate alias "D3DXQuaternionConjugate" (byval pOut as D3DXQUATERNION ptr, byval pQ as D3DXQUATERNION ptr) as D3DXQUATERNION ptr
declare sub D3DXQuaternionToAxisAngle alias "D3DXQuaternionToAxisAngle" (byval pQ as D3DXQUATERNION ptr, byval pAxis as D3DXVECTOR3 ptr, byval pAngle as single ptr)
declare function D3DXQuaternionRotationMatrix alias "D3DXQuaternionRotationMatrix" (byval pOut as D3DXQUATERNION ptr, byval pM as D3DXMATRIX ptr) as D3DXQUATERNION ptr
declare function D3DXQuaternionRotationAxis alias "D3DXQuaternionRotationAxis" (byval pOut as D3DXQUATERNION ptr, byval pV as D3DXVECTOR3 ptr, byval angle as single) as D3DXQUATERNION ptr
declare function D3DXQuaternionRotationYawPitchRoll alias "D3DXQuaternionRotationYawPitchRoll" (byval pOut as D3DXQUATERNION ptr, byval yaw as single, byval pitch as single, byval roll as single) as D3DXQUATERNION ptr
declare function D3DXQuaternionMultiply alias "D3DXQuaternionMultiply" (byval pOut as D3DXQUATERNION ptr, byval pQ1 as D3DXQUATERNION ptr, byval pQ2 as D3DXQUATERNION ptr) as D3DXQUATERNION ptr
declare function D3DXQuaternionNormalize alias "D3DXQuaternionNormalize" (byval pOut as D3DXQUATERNION ptr, byval pQ as D3DXQUATERNION ptr) as D3DXQUATERNION ptr
declare function D3DXQuaternionInverse alias "D3DXQuaternionInverse" (byval pOut as D3DXQUATERNION ptr, byval pQ as D3DXQUATERNION ptr) as D3DXQUATERNION ptr
declare function D3DXQuaternionLn alias "D3DXQuaternionLn" (byval pOut as D3DXQUATERNION ptr, byval pQ as D3DXQUATERNION ptr) as D3DXQUATERNION ptr
declare function D3DXQuaternionExp alias "D3DXQuaternionExp" (byval pOut as D3DXQUATERNION ptr, byval pQ as D3DXQUATERNION ptr) as D3DXQUATERNION ptr
declare function D3DXQuaternionSlerp alias "D3DXQuaternionSlerp" (byval pOut as D3DXQUATERNION ptr, byval pQ1 as D3DXQUATERNION ptr, byval pQ2 as D3DXQUATERNION ptr, byval t as single) as D3DXQUATERNION ptr
declare function D3DXQuaternionSquad alias "D3DXQuaternionSquad" (byval pOut as D3DXQUATERNION ptr, byval pQ1 as D3DXQUATERNION ptr, byval pQ2 as D3DXQUATERNION ptr, byval pQ3 as D3DXQUATERNION ptr, byval pQ4 as D3DXQUATERNION ptr, byval t as single) as D3DXQUATERNION ptr
declare function D3DXQuaternionBaryCentric alias "D3DXQuaternionBaryCentric" (byval pOut as D3DXQUATERNION ptr, byval pQ1 as D3DXQUATERNION ptr, byval pQ2 as D3DXQUATERNION ptr, byval pQ3 as D3DXQUATERNION ptr, byval f as single, byval g as single) as D3DXQUATERNION ptr
declare function D3DXPlaneDot alias "D3DXPlaneDot" (byval pP as D3DXPLANE ptr, byval pV as D3DXVECTOR4 ptr) as single
declare function D3DXPlaneDotCoord alias "D3DXPlaneDotCoord" (byval pP as D3DXPLANE ptr, byval pV as D3DXVECTOR3 ptr) as single
declare function D3DXPlaneDotNormal alias "D3DXPlaneDotNormal" (byval pP as D3DXPLANE ptr, byval pV as D3DXVECTOR3 ptr) as single
declare function D3DXPlaneNormalize alias "D3DXPlaneNormalize" (byval pOut as D3DXPLANE ptr, byval pP as D3DXPLANE ptr) as D3DXPLANE ptr
declare function D3DXPlaneIntersectLine alias "D3DXPlaneIntersectLine" (byval pOut as D3DXVECTOR3 ptr, byval pP as D3DXPLANE ptr, byval pV1 as D3DXVECTOR3 ptr, byval pV2 as D3DXVECTOR3 ptr) as D3DXVECTOR3 ptr
declare function D3DXPlaneFromPointNormal alias "D3DXPlaneFromPointNormal" (byval pOut as D3DXPLANE ptr, byval pPoint as D3DXVECTOR3 ptr, byval pNormal as D3DXVECTOR3 ptr) as D3DXPLANE ptr
declare function D3DXPlaneFromPoints alias "D3DXPlaneFromPoints" (byval pOut as D3DXPLANE ptr, byval pV1 as D3DXVECTOR3 ptr, byval pV2 as D3DXVECTOR3 ptr, byval pV3 as D3DXVECTOR3 ptr) as D3DXPLANE ptr
declare function D3DXPlaneTransform alias "D3DXPlaneTransform" (byval pOut as D3DXPLANE ptr, byval pP as D3DXPLANE ptr, byval pM as D3DXMATRIX ptr) as D3DXPLANE ptr
declare function D3DXColorNegative alias "D3DXColorNegative" (byval pOut as D3DXCOLOR ptr, byval pC as D3DXCOLOR ptr) as D3DXCOLOR ptr
declare function D3DXColorAdd alias "D3DXColorAdd" (byval pOut as D3DXCOLOR ptr, byval pC1 as D3DXCOLOR ptr, byval pC2 as D3DXCOLOR ptr) as D3DXCOLOR ptr
declare function D3DXColorSubtract alias "D3DXColorSubtract" (byval pOut as D3DXCOLOR ptr, byval pC1 as D3DXCOLOR ptr, byval pC2 as D3DXCOLOR ptr) as D3DXCOLOR ptr
declare function D3DXColorScale alias "D3DXColorScale" (byval pOut as D3DXCOLOR ptr, byval pC as D3DXCOLOR ptr, byval s as single) as D3DXCOLOR ptr
declare function D3DXColorModulate alias "D3DXColorModulate" (byval pOut as D3DXCOLOR ptr, byval pC1 as D3DXCOLOR ptr, byval pC2 as D3DXCOLOR ptr) as D3DXCOLOR ptr
declare function D3DXColorLerp alias "D3DXColorLerp" (byval pOut as D3DXCOLOR ptr, byval pC1 as D3DXCOLOR ptr, byval pC2 as D3DXCOLOR ptr, byval s as single) as D3DXCOLOR ptr
declare function D3DXColorAdjustSaturation alias "D3DXColorAdjustSaturation" (byval pOut as D3DXCOLOR ptr, byval pC as D3DXCOLOR ptr, byval s as single) as D3DXCOLOR ptr
declare function D3DXColorAdjustContrast alias "D3DXColorAdjustContrast" (byval pOut as D3DXCOLOR ptr, byval pC as D3DXCOLOR ptr, byval c as single) as D3DXCOLOR ptr

type ID3DXMatrixStackVtbl_ as ID3DXMatrixStackVtbl

type ID3DXMatrixStack
	lpVtbl as ID3DXMatrixStackVtbl_ ptr
end type

type ID3DXMatrixStackVtbl
	QueryInterface as function(byval as IDirect3DVertexBuffer7 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DVertexBuffer7 ptr) as ULONG
	Release as function(byval as IDirect3DVertexBuffer7 ptr) as ULONG
	Pop as function(byval as IDirect3DVertexBuffer7 ptr) as HRESULT
	Push as function(byval as IDirect3DVertexBuffer7 ptr) as HRESULT
	LoadIdentity as function(byval as IDirect3DVertexBuffer7 ptr) as HRESULT
	LoadMatrix as function(byval as IDirect3DVertexBuffer7 ptr, byval as D3DXMATRIX ptr) as HRESULT
	MultMatrix as function(byval as IDirect3DVertexBuffer7 ptr, byval as D3DXMATRIX ptr) as HRESULT
	MultMatrixLocal as function(byval as IDirect3DVertexBuffer7 ptr, byval as D3DXMATRIX ptr) as HRESULT
	RotateAxis as function(byval as IDirect3DVertexBuffer7 ptr, byval as D3DXVECTOR3 ptr, byval as single) as HRESULT
	RotateAxisLocal as function(byval as IDirect3DVertexBuffer7 ptr, byval as D3DXVECTOR3 ptr, byval as single) as HRESULT
	RotateYawPitchRoll as function(byval as IDirect3DVertexBuffer7 ptr, byval as single, byval as single, byval as single) as HRESULT
	RotateYawPitchRollLocal as function(byval as IDirect3DVertexBuffer7 ptr, byval as single, byval as single, byval as single) as HRESULT
	Scale as function(byval as IDirect3DVertexBuffer7 ptr, byval as single, byval as single, byval as single) as HRESULT
	ScaleLocal as function(byval as IDirect3DVertexBuffer7 ptr, byval as single, byval as single, byval as single) as HRESULT
	Translate as function(byval as IDirect3DVertexBuffer7 ptr, byval as single, byval as single, byval as single) as HRESULT
	TranslateLocal as function(byval as IDirect3DVertexBuffer7 ptr, byval as single, byval as single, byval as single) as HRESULT
	GetTop as function(byval as IDirect3DVertexBuffer7 ptr) as D3DXMATRIX ptr
end type

declare function D3DXCreateMatrixStack alias "D3DXCreateMatrixStack" (byval flags as DWORD, byval ppStack as LPD3DXMATRIXSTACK ptr) as HRESULT

#endif
