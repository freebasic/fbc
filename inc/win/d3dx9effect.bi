'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   Copyright 2010 Christian Costa
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

#include once "_mingw_unicode.bi"
#include once "d3dx9.bi"

extern "Windows"

#define __D3DX9EFFECT_H__
const D3DXFX_DONOTSAVESTATE = 1 shl 0
const D3DXFX_DONOTSAVESHADERSTATE = 1 shl 1
const D3DXFX_DONOTSAVESAMPLERSTATE = 1 shl 2
const D3DXFX_NOT_CLONEABLE = 1 shl 11
const D3DXFX_LARGEADDRESSAWARE = 1 shl 17
const D3DX_PARAMETER_SHARED = 1
const D3DX_PARAMETER_LITERAL = 2
const D3DX_PARAMETER_ANNOTATION = 4

type _D3DXEFFECT_DESC
	Creator as const zstring ptr
	Parameters as UINT
	Techniques as UINT
	Functions as UINT
end type

type D3DXEFFECT_DESC as _D3DXEFFECT_DESC

type _D3DXPARAMETER_DESC
	Name as const zstring ptr
	Semantic as const zstring ptr
	Class as D3DXPARAMETER_CLASS
	as D3DXPARAMETER_TYPE Type
	Rows as UINT
	Columns as UINT
	Elements as UINT
	Annotations as UINT
	StructMembers as UINT
	Flags as DWORD
	Bytes as UINT
end type

type D3DXPARAMETER_DESC as _D3DXPARAMETER_DESC

type _D3DXTECHNIQUE_DESC
	Name as const zstring ptr
	Passes as UINT
	Annotations as UINT
end type

type D3DXTECHNIQUE_DESC as _D3DXTECHNIQUE_DESC

type _D3DXPASS_DESC
	Name as const zstring ptr
	Annotations as UINT
	pVertexShaderFunction as const DWORD ptr
	pPixelShaderFunction as const DWORD ptr
end type

type D3DXPASS_DESC as _D3DXPASS_DESC

type _D3DXFUNCTION_DESC
	Name as const zstring ptr
	Annotations as UINT
end type

type D3DXFUNCTION_DESC as _D3DXFUNCTION_DESC
type LPD3DXEFFECTPOOL as ID3DXEffectPool ptr
extern IID_ID3DXEffectPool as const GUID
type ID3DXEffectPoolVtbl as ID3DXEffectPoolVtbl_

type ID3DXEffectPool
	lpVtbl as ID3DXEffectPoolVtbl ptr
end type

type ID3DXEffectPoolVtbl_
	QueryInterface as function(byval This as ID3DXEffectPool ptr, byval riid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddRef as function(byval This as ID3DXEffectPool ptr) as ULONG
	Release as function(byval This as ID3DXEffectPool ptr) as ULONG
end type

type LPD3DXBASEEFFECT as ID3DXBaseEffect ptr
extern IID_ID3DXBaseEffect as const GUID
type ID3DXBaseEffectVtbl as ID3DXBaseEffectVtbl_

type ID3DXBaseEffect
	lpVtbl as ID3DXBaseEffectVtbl ptr
end type

type ID3DXBaseEffectVtbl_
	QueryInterface as function(byval This as ID3DXBaseEffect ptr, byval riid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddRef as function(byval This as ID3DXBaseEffect ptr) as ULONG
	Release as function(byval This as ID3DXBaseEffect ptr) as ULONG
	GetDesc as function(byval This as ID3DXBaseEffect ptr, byval desc as D3DXEFFECT_DESC ptr) as HRESULT
	GetParameterDesc as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval desc as D3DXPARAMETER_DESC ptr) as HRESULT
	GetTechniqueDesc as function(byval This as ID3DXBaseEffect ptr, byval technique as D3DXHANDLE, byval desc as D3DXTECHNIQUE_DESC ptr) as HRESULT
	GetPassDesc as function(byval This as ID3DXBaseEffect ptr, byval pass as D3DXHANDLE, byval desc as D3DXPASS_DESC ptr) as HRESULT
	GetFunctionDesc as function(byval This as ID3DXBaseEffect ptr, byval shader as D3DXHANDLE, byval desc as D3DXFUNCTION_DESC ptr) as HRESULT
	GetParameter as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval index as UINT) as D3DXHANDLE
	GetParameterByName as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval name as const zstring ptr) as D3DXHANDLE
	GetParameterBySemantic as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval semantic as const zstring ptr) as D3DXHANDLE
	GetParameterElement as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval index as UINT) as D3DXHANDLE
	GetTechnique as function(byval This as ID3DXBaseEffect ptr, byval index as UINT) as D3DXHANDLE
	GetTechniqueByName as function(byval This as ID3DXBaseEffect ptr, byval name as const zstring ptr) as D3DXHANDLE
	GetPass as function(byval This as ID3DXBaseEffect ptr, byval technique as D3DXHANDLE, byval index as UINT) as D3DXHANDLE
	GetPassByName as function(byval This as ID3DXBaseEffect ptr, byval technique as D3DXHANDLE, byval name as const zstring ptr) as D3DXHANDLE
	GetFunction as function(byval This as ID3DXBaseEffect ptr, byval index as UINT) as D3DXHANDLE
	GetFunctionByName as function(byval This as ID3DXBaseEffect ptr, byval name as const zstring ptr) as D3DXHANDLE
	GetAnnotation as function(byval This as ID3DXBaseEffect ptr, byval object as D3DXHANDLE, byval index as UINT) as D3DXHANDLE
	GetAnnotationByName as function(byval This as ID3DXBaseEffect ptr, byval object as D3DXHANDLE, byval name as const zstring ptr) as D3DXHANDLE
	SetValue as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval data as const any ptr, byval bytes as UINT) as HRESULT
	GetValue as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval data as any ptr, byval bytes as UINT) as HRESULT
	SetBool as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval b as WINBOOL) as HRESULT
	GetBool as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval b as WINBOOL ptr) as HRESULT
	SetBoolArray as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval b as const WINBOOL ptr, byval count as UINT) as HRESULT
	GetBoolArray as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval b as WINBOOL ptr, byval count as UINT) as HRESULT
	SetInt as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval n as INT_) as HRESULT
	GetInt as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval n as INT_ ptr) as HRESULT
	SetIntArray as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval n as const INT_ ptr, byval count as UINT) as HRESULT
	GetIntArray as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval n as INT_ ptr, byval count as UINT) as HRESULT
	SetFloat as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval f as FLOAT) as HRESULT
	GetFloat as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval f as FLOAT ptr) as HRESULT
	SetFloatArray as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval f as const FLOAT ptr, byval count as UINT) as HRESULT
	GetFloatArray as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval f as FLOAT ptr, byval count as UINT) as HRESULT
	SetVector as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval vector as const D3DXVECTOR4 ptr) as HRESULT
	GetVector as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval vector as D3DXVECTOR4 ptr) as HRESULT
	SetVectorArray as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval vector as const D3DXVECTOR4 ptr, byval count as UINT) as HRESULT
	GetVectorArray as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval vector as D3DXVECTOR4 ptr, byval count as UINT) as HRESULT
	SetMatrix as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval matrix as const D3DXMATRIX ptr) as HRESULT
	GetMatrix as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval matrix as D3DXMATRIX ptr) as HRESULT
	SetMatrixArray as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval matrix as const D3DXMATRIX ptr, byval count as UINT) as HRESULT
	GetMatrixArray as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval matrix as D3DXMATRIX ptr, byval count as UINT) as HRESULT
	SetMatrixPointerArray as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval matrix as const D3DXMATRIX ptr ptr, byval count as UINT) as HRESULT
	GetMatrixPointerArray as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval matrix as D3DXMATRIX ptr ptr, byval count as UINT) as HRESULT
	SetMatrixTranspose as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval matrix as const D3DXMATRIX ptr) as HRESULT
	GetMatrixTranspose as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval matrix as D3DXMATRIX ptr) as HRESULT
	SetMatrixTransposeArray as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval matrix as const D3DXMATRIX ptr, byval count as UINT) as HRESULT
	GetMatrixTransposeArray as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval matrix as D3DXMATRIX ptr, byval count as UINT) as HRESULT
	SetMatrixTransposePointerArray as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval matrix as const D3DXMATRIX ptr ptr, byval count as UINT) as HRESULT
	GetMatrixTransposePointerArray as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval matrix as D3DXMATRIX ptr ptr, byval count as UINT) as HRESULT
	SetString as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval string as const zstring ptr) as HRESULT
	GetString as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval string as const zstring ptr ptr) as HRESULT
	SetTexture as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval texture as IDirect3DBaseTexture9 ptr) as HRESULT
	GetTexture as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval texture as IDirect3DBaseTexture9 ptr ptr) as HRESULT
	GetPixelShader as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval shader as IDirect3DPixelShader9 ptr ptr) as HRESULT
	GetVertexShader as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval shader as IDirect3DVertexShader9 ptr ptr) as HRESULT
	SetArrayRange as function(byval This as ID3DXBaseEffect ptr, byval parameter as D3DXHANDLE, byval start as UINT, byval end as UINT) as HRESULT
end type

type LPD3DXEFFECTSTATEMANAGER as ID3DXEffectStateManager ptr
extern IID_ID3DXEffectStateManager as const GUID
type ID3DXEffectStateManagerVtbl as ID3DXEffectStateManagerVtbl_

type ID3DXEffectStateManager
	lpVtbl as ID3DXEffectStateManagerVtbl ptr
end type

type ID3DXEffectStateManagerVtbl_
	QueryInterface as function(byval This as ID3DXEffectStateManager ptr, byval riid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddRef as function(byval This as ID3DXEffectStateManager ptr) as ULONG
	Release as function(byval This as ID3DXEffectStateManager ptr) as ULONG
	SetTransform as function(byval This as ID3DXEffectStateManager ptr, byval state as D3DTRANSFORMSTATETYPE, byval matrix as const D3DMATRIX ptr) as HRESULT
	SetMaterial as function(byval This as ID3DXEffectStateManager ptr, byval material as const D3DMATERIAL9 ptr) as HRESULT
	SetLight as function(byval This as ID3DXEffectStateManager ptr, byval index as DWORD, byval light as const D3DLIGHT9 ptr) as HRESULT
	LightEnable as function(byval This as ID3DXEffectStateManager ptr, byval index as DWORD, byval enable as WINBOOL) as HRESULT
	SetRenderState as function(byval This as ID3DXEffectStateManager ptr, byval state as D3DRENDERSTATETYPE, byval value as DWORD) as HRESULT
	SetTexture as function(byval This as ID3DXEffectStateManager ptr, byval stage as DWORD, byval texture as IDirect3DBaseTexture9 ptr) as HRESULT
	SetTextureStageState as function(byval This as ID3DXEffectStateManager ptr, byval stage as DWORD, byval type as D3DTEXTURESTAGESTATETYPE, byval value as DWORD) as HRESULT
	SetSamplerState as function(byval This as ID3DXEffectStateManager ptr, byval sampler as DWORD, byval type as D3DSAMPLERSTATETYPE, byval value as DWORD) as HRESULT
	SetNPatchMode as function(byval This as ID3DXEffectStateManager ptr, byval num_segments as FLOAT) as HRESULT
	SetFVF as function(byval This as ID3DXEffectStateManager ptr, byval format as DWORD) as HRESULT
	SetVertexShader as function(byval This as ID3DXEffectStateManager ptr, byval shader as IDirect3DVertexShader9 ptr) as HRESULT
	SetVertexShaderConstantF as function(byval This as ID3DXEffectStateManager ptr, byval register_index as UINT, byval constant_data as const FLOAT ptr, byval register_count as UINT) as HRESULT
	SetVertexShaderConstantI as function(byval This as ID3DXEffectStateManager ptr, byval register_index as UINT, byval constant_data as const INT_ ptr, byval register_count as UINT) as HRESULT
	SetVertexShaderConstantB as function(byval This as ID3DXEffectStateManager ptr, byval register_index as UINT, byval constant_data as const WINBOOL ptr, byval register_count as UINT) as HRESULT
	SetPixelShader as function(byval This as ID3DXEffectStateManager ptr, byval shader as IDirect3DPixelShader9 ptr) as HRESULT
	SetPixelShaderConstantF as function(byval This as ID3DXEffectStateManager ptr, byval register_index as UINT, byval constant_data as const FLOAT ptr, byval register_count as UINT) as HRESULT
	SetPixelShaderConstantI as function(byval This as ID3DXEffectStateManager ptr, byval register_index as UINT, byval constant_data as const INT_ ptr, byval register_count as UINT) as HRESULT
	SetPixelShaderConstantB as function(byval This as ID3DXEffectStateManager ptr, byval register_index as UINT, byval constant_data as const WINBOOL ptr, byval register_count as UINT) as HRESULT
end type

type LPD3DXEFFECT as ID3DXEffect ptr
extern IID_ID3DXEffect as const GUID
type ID3DXEffectVtbl as ID3DXEffectVtbl_

type ID3DXEffect
	lpVtbl as ID3DXEffectVtbl ptr
end type

type ID3DXEffectVtbl_
	QueryInterface as function(byval This as ID3DXEffect ptr, byval riid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddRef as function(byval This as ID3DXEffect ptr) as ULONG
	Release as function(byval This as ID3DXEffect ptr) as ULONG
	GetDesc as function(byval This as ID3DXEffect ptr, byval desc as D3DXEFFECT_DESC ptr) as HRESULT
	GetParameterDesc as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval desc as D3DXPARAMETER_DESC ptr) as HRESULT
	GetTechniqueDesc as function(byval This as ID3DXEffect ptr, byval technique as D3DXHANDLE, byval desc as D3DXTECHNIQUE_DESC ptr) as HRESULT
	GetPassDesc as function(byval This as ID3DXEffect ptr, byval pass as D3DXHANDLE, byval desc as D3DXPASS_DESC ptr) as HRESULT
	GetFunctionDesc as function(byval This as ID3DXEffect ptr, byval shader as D3DXHANDLE, byval desc as D3DXFUNCTION_DESC ptr) as HRESULT
	GetParameter as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval index as UINT) as D3DXHANDLE
	GetParameterByName as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval name as const zstring ptr) as D3DXHANDLE
	GetParameterBySemantic as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval semantic as const zstring ptr) as D3DXHANDLE
	GetParameterElement as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval index as UINT) as D3DXHANDLE
	GetTechnique as function(byval This as ID3DXEffect ptr, byval index as UINT) as D3DXHANDLE
	GetTechniqueByName as function(byval This as ID3DXEffect ptr, byval name as const zstring ptr) as D3DXHANDLE
	GetPass as function(byval This as ID3DXEffect ptr, byval technique as D3DXHANDLE, byval index as UINT) as D3DXHANDLE
	GetPassByName as function(byval This as ID3DXEffect ptr, byval technique as D3DXHANDLE, byval name as const zstring ptr) as D3DXHANDLE
	GetFunction as function(byval This as ID3DXEffect ptr, byval index as UINT) as D3DXHANDLE
	GetFunctionByName as function(byval This as ID3DXEffect ptr, byval name as const zstring ptr) as D3DXHANDLE
	GetAnnotation as function(byval This as ID3DXEffect ptr, byval object as D3DXHANDLE, byval index as UINT) as D3DXHANDLE
	GetAnnotationByName as function(byval This as ID3DXEffect ptr, byval object as D3DXHANDLE, byval name as const zstring ptr) as D3DXHANDLE
	SetValue as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval data as const any ptr, byval bytes as UINT) as HRESULT
	GetValue as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval data as any ptr, byval bytes as UINT) as HRESULT
	SetBool as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval b as WINBOOL) as HRESULT
	GetBool as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval b as WINBOOL ptr) as HRESULT
	SetBoolArray as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval b as const WINBOOL ptr, byval count as UINT) as HRESULT
	GetBoolArray as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval b as WINBOOL ptr, byval count as UINT) as HRESULT
	SetInt as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval n as INT_) as HRESULT
	GetInt as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval n as INT_ ptr) as HRESULT
	SetIntArray as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval n as const INT_ ptr, byval count as UINT) as HRESULT
	GetIntArray as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval n as INT_ ptr, byval count as UINT) as HRESULT
	SetFloat as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval f as FLOAT) as HRESULT
	GetFloat as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval f as FLOAT ptr) as HRESULT
	SetFloatArray as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval f as const FLOAT ptr, byval count as UINT) as HRESULT
	GetFloatArray as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval f as FLOAT ptr, byval count as UINT) as HRESULT
	SetVector as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval vector as const D3DXVECTOR4 ptr) as HRESULT
	GetVector as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval vector as D3DXVECTOR4 ptr) as HRESULT
	SetVectorArray as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval vector as const D3DXVECTOR4 ptr, byval count as UINT) as HRESULT
	GetVectorArray as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval vector as D3DXVECTOR4 ptr, byval count as UINT) as HRESULT
	SetMatrix as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval matrix as const D3DXMATRIX ptr) as HRESULT
	GetMatrix as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval matrix as D3DXMATRIX ptr) as HRESULT
	SetMatrixArray as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval matrix as const D3DXMATRIX ptr, byval count as UINT) as HRESULT
	GetMatrixArray as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval matrix as D3DXMATRIX ptr, byval count as UINT) as HRESULT
	SetMatrixPointerArray as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval matrix as const D3DXMATRIX ptr ptr, byval count as UINT) as HRESULT
	GetMatrixPointerArray as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval matrix as D3DXMATRIX ptr ptr, byval count as UINT) as HRESULT
	SetMatrixTranspose as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval matrix as const D3DXMATRIX ptr) as HRESULT
	GetMatrixTranspose as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval matrix as D3DXMATRIX ptr) as HRESULT
	SetMatrixTransposeArray as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval matrix as const D3DXMATRIX ptr, byval count as UINT) as HRESULT
	GetMatrixTransposeArray as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval matrix as D3DXMATRIX ptr, byval count as UINT) as HRESULT
	SetMatrixTransposePointerArray as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval matrix as const D3DXMATRIX ptr ptr, byval count as UINT) as HRESULT
	GetMatrixTransposePointerArray as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval matrix as D3DXMATRIX ptr ptr, byval count as UINT) as HRESULT
	SetString as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval string as const zstring ptr) as HRESULT
	GetString as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval string as const zstring ptr ptr) as HRESULT
	SetTexture as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval texture as IDirect3DBaseTexture9 ptr) as HRESULT
	GetTexture as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval texture as IDirect3DBaseTexture9 ptr ptr) as HRESULT
	GetPixelShader as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval shader as IDirect3DPixelShader9 ptr ptr) as HRESULT
	GetVertexShader as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval shader as IDirect3DVertexShader9 ptr ptr) as HRESULT
	SetArrayRange as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval start as UINT, byval end as UINT) as HRESULT
	GetPool as function(byval This as ID3DXEffect ptr, byval pool as ID3DXEffectPool ptr ptr) as HRESULT
	SetTechnique as function(byval This as ID3DXEffect ptr, byval technique as D3DXHANDLE) as HRESULT
	GetCurrentTechnique as function(byval This as ID3DXEffect ptr) as D3DXHANDLE
	ValidateTechnique as function(byval This as ID3DXEffect ptr, byval technique as D3DXHANDLE) as HRESULT
	FindNextValidTechnique as function(byval This as ID3DXEffect ptr, byval technique as D3DXHANDLE, byval next_technique as D3DXHANDLE ptr) as HRESULT
	IsParameterUsed as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval technique as D3DXHANDLE) as WINBOOL
	Begin as function(byval This as ID3DXEffect ptr, byval passes as UINT ptr, byval flags as DWORD) as HRESULT
	BeginPass as function(byval This as ID3DXEffect ptr, byval pass as UINT) as HRESULT
	CommitChanges as function(byval This as ID3DXEffect ptr) as HRESULT
	EndPass as function(byval This as ID3DXEffect ptr) as HRESULT
	as function(byval This as ID3DXEffect ptr) as HRESULT End
	GetDevice as function(byval This as ID3DXEffect ptr, byval device as IDirect3DDevice9 ptr ptr) as HRESULT
	OnLostDevice as function(byval This as ID3DXEffect ptr) as HRESULT
	OnResetDevice as function(byval This as ID3DXEffect ptr) as HRESULT
	SetStateManager as function(byval This as ID3DXEffect ptr, byval manager as ID3DXEffectStateManager ptr) as HRESULT
	GetStateManager as function(byval This as ID3DXEffect ptr, byval manager as ID3DXEffectStateManager ptr ptr) as HRESULT
	BeginParameterBlock as function(byval This as ID3DXEffect ptr) as HRESULT
	EndParameterBlock as function(byval This as ID3DXEffect ptr) as D3DXHANDLE
	ApplyParameterBlock as function(byval This as ID3DXEffect ptr, byval parameter_block as D3DXHANDLE) as HRESULT
	DeleteParameterBlock as function(byval This as ID3DXEffect ptr, byval parameter_block as D3DXHANDLE) as HRESULT
	CloneEffect as function(byval This as ID3DXEffect ptr, byval device as IDirect3DDevice9 ptr, byval effect as ID3DXEffect ptr ptr) as HRESULT
	SetRawValue as function(byval This as ID3DXEffect ptr, byval parameter as D3DXHANDLE, byval data as const any ptr, byval byte_offset as UINT, byval bytes as UINT) as HRESULT
end type

type LPD3DXEFFECTCOMPILER as ID3DXEffectCompiler ptr
extern IID_ID3DXEffectCompiler as const GUID
type ID3DXEffectCompilerVtbl as ID3DXEffectCompilerVtbl_

type ID3DXEffectCompiler
	lpVtbl as ID3DXEffectCompilerVtbl ptr
end type

type ID3DXEffectCompilerVtbl_
	QueryInterface as function(byval This as ID3DXEffectCompiler ptr, byval riid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddRef as function(byval This as ID3DXEffectCompiler ptr) as ULONG
	Release as function(byval This as ID3DXEffectCompiler ptr) as ULONG
	GetDesc as function(byval This as ID3DXEffectCompiler ptr, byval desc as D3DXEFFECT_DESC ptr) as HRESULT
	GetParameterDesc as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval desc as D3DXPARAMETER_DESC ptr) as HRESULT
	GetTechniqueDesc as function(byval This as ID3DXEffectCompiler ptr, byval technique as D3DXHANDLE, byval desc as D3DXTECHNIQUE_DESC ptr) as HRESULT
	GetPassDesc as function(byval This as ID3DXEffectCompiler ptr, byval pass as D3DXHANDLE, byval desc as D3DXPASS_DESC ptr) as HRESULT
	GetFunctionDesc as function(byval This as ID3DXEffectCompiler ptr, byval shader as D3DXHANDLE, byval desc as D3DXFUNCTION_DESC ptr) as HRESULT
	GetParameter as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval index as UINT) as D3DXHANDLE
	GetParameterByName as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval name as const zstring ptr) as D3DXHANDLE
	GetParameterBySemantic as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval semantic as const zstring ptr) as D3DXHANDLE
	GetParameterElement as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval index as UINT) as D3DXHANDLE
	GetTechnique as function(byval This as ID3DXEffectCompiler ptr, byval index as UINT) as D3DXHANDLE
	GetTechniqueByName as function(byval This as ID3DXEffectCompiler ptr, byval name as const zstring ptr) as D3DXHANDLE
	GetPass as function(byval This as ID3DXEffectCompiler ptr, byval technique as D3DXHANDLE, byval index as UINT) as D3DXHANDLE
	GetPassByName as function(byval This as ID3DXEffectCompiler ptr, byval technique as D3DXHANDLE, byval name as const zstring ptr) as D3DXHANDLE
	GetFunction as function(byval This as ID3DXEffectCompiler ptr, byval index as UINT) as D3DXHANDLE
	GetFunctionByName as function(byval This as ID3DXEffectCompiler ptr, byval name as const zstring ptr) as D3DXHANDLE
	GetAnnotation as function(byval This as ID3DXEffectCompiler ptr, byval object as D3DXHANDLE, byval index as UINT) as D3DXHANDLE
	GetAnnotationByName as function(byval This as ID3DXEffectCompiler ptr, byval object as D3DXHANDLE, byval name as const zstring ptr) as D3DXHANDLE
	SetValue as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval data as const any ptr, byval bytes as UINT) as HRESULT
	GetValue as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval data as any ptr, byval bytes as UINT) as HRESULT
	SetBool as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval b as WINBOOL) as HRESULT
	GetBool as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval b as WINBOOL ptr) as HRESULT
	SetBoolArray as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval b as const WINBOOL ptr, byval count as UINT) as HRESULT
	GetBoolArray as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval b as WINBOOL ptr, byval count as UINT) as HRESULT
	SetInt as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval n as INT_) as HRESULT
	GetInt as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval n as INT_ ptr) as HRESULT
	SetIntArray as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval n as const INT_ ptr, byval count as UINT) as HRESULT
	GetIntArray as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval n as INT_ ptr, byval count as UINT) as HRESULT
	SetFloat as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval f as FLOAT) as HRESULT
	GetFloat as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval f as FLOAT ptr) as HRESULT
	SetFloatArray as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval f as const FLOAT ptr, byval count as UINT) as HRESULT
	GetFloatArray as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval f as FLOAT ptr, byval count as UINT) as HRESULT
	SetVector as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval vector as const D3DXVECTOR4 ptr) as HRESULT
	GetVector as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval vector as D3DXVECTOR4 ptr) as HRESULT
	SetVectorArray as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval vector as const D3DXVECTOR4 ptr, byval count as UINT) as HRESULT
	GetVectorArray as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval vector as D3DXVECTOR4 ptr, byval count as UINT) as HRESULT
	SetMatrix as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval matrix as const D3DXMATRIX ptr) as HRESULT
	GetMatrix as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval matrix as D3DXMATRIX ptr) as HRESULT
	SetMatrixArray as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval matrix as const D3DXMATRIX ptr, byval count as UINT) as HRESULT
	GetMatrixArray as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval matrix as D3DXMATRIX ptr, byval count as UINT) as HRESULT
	SetMatrixPointerArray as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval matrix as const D3DXMATRIX ptr ptr, byval count as UINT) as HRESULT
	GetMatrixPointerArray as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval matrix as D3DXMATRIX ptr ptr, byval count as UINT) as HRESULT
	SetMatrixTranspose as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval matrix as const D3DXMATRIX ptr) as HRESULT
	GetMatrixTranspose as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval matrix as D3DXMATRIX ptr) as HRESULT
	SetMatrixTransposeArray as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval matrix as const D3DXMATRIX ptr, byval count as UINT) as HRESULT
	GetMatrixTransposeArray as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval matrix as D3DXMATRIX ptr, byval count as UINT) as HRESULT
	SetMatrixTransposePointerArray as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval matrix as const D3DXMATRIX ptr ptr, byval count as UINT) as HRESULT
	GetMatrixTransposePointerArray as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval matrix as D3DXMATRIX ptr ptr, byval count as UINT) as HRESULT
	SetString as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval string as const zstring ptr) as HRESULT
	GetString as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval string as const zstring ptr ptr) as HRESULT
	SetTexture as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval texture as IDirect3DBaseTexture9 ptr) as HRESULT
	GetTexture as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval texture as IDirect3DBaseTexture9 ptr ptr) as HRESULT
	GetPixelShader as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval shader as IDirect3DPixelShader9 ptr ptr) as HRESULT
	GetVertexShader as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval shader as IDirect3DVertexShader9 ptr ptr) as HRESULT
	SetArrayRange as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval start as UINT, byval end as UINT) as HRESULT
	SetLiteral as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval literal as WINBOOL) as HRESULT
	GetLiteral as function(byval This as ID3DXEffectCompiler ptr, byval parameter as D3DXHANDLE, byval literal as WINBOOL ptr) as HRESULT
	CompileEffect as function(byval This as ID3DXEffectCompiler ptr, byval flags as DWORD, byval effect as ID3DXBuffer ptr ptr, byval error_msgs as ID3DXBuffer ptr ptr) as HRESULT
	CompileShader as function(byval This as ID3DXEffectCompiler ptr, byval function as D3DXHANDLE, byval target as const zstring ptr, byval flags as DWORD, byval shader as ID3DXBuffer ptr ptr, byval error_msgs as ID3DXBuffer ptr ptr, byval constant_table as ID3DXConstantTable ptr ptr) as HRESULT
end type

declare function D3DXCreateEffectPool(byval pool as ID3DXEffectPool ptr ptr) as HRESULT
declare function D3DXCreateEffect(byval device as IDirect3DDevice9 ptr, byval srcdata as const any ptr, byval srcdatalen as UINT, byval defines as const D3DXMACRO ptr, byval include as ID3DXInclude ptr, byval flags as DWORD, byval pool as ID3DXEffectPool ptr, byval effect as ID3DXEffect ptr ptr, byval compilation_errors as ID3DXBuffer ptr ptr) as HRESULT
declare function D3DXCreateEffectEx(byval device as IDirect3DDevice9 ptr, byval srcdata as const any ptr, byval srcdatalen as UINT, byval defines as const D3DXMACRO ptr, byval include as ID3DXInclude ptr, byval skip_constants as const zstring ptr, byval flags as DWORD, byval pool as ID3DXEffectPool ptr, byval effect as ID3DXEffect ptr ptr, byval compilation_errors as ID3DXBuffer ptr ptr) as HRESULT
declare function D3DXCreateEffectCompiler(byval srcdata as const zstring ptr, byval srcdatalen as UINT, byval defines as const D3DXMACRO ptr, byval include as ID3DXInclude ptr, byval flags as DWORD, byval compiler as ID3DXEffectCompiler ptr ptr, byval parse_errors as ID3DXBuffer ptr ptr) as HRESULT
declare function D3DXCreateEffectFromFileExA(byval device as IDirect3DDevice9 ptr, byval srcfile as const zstring ptr, byval defines as const D3DXMACRO ptr, byval include as ID3DXInclude ptr, byval skip_constants as const zstring ptr, byval flags as DWORD, byval pool as ID3DXEffectPool ptr, byval effect as ID3DXEffect ptr ptr, byval compilation_errors as ID3DXBuffer ptr ptr) as HRESULT
declare function D3DXCreateEffectFromFileExW(byval device as IDirect3DDevice9 ptr, byval srcfile as const wstring ptr, byval defines as const D3DXMACRO ptr, byval include as ID3DXInclude ptr, byval skip_constants as const zstring ptr, byval flags as DWORD, byval pool as ID3DXEffectPool ptr, byval effect as ID3DXEffect ptr ptr, byval compilation_errors as ID3DXBuffer ptr ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXCreateEffectFromFileEx alias "D3DXCreateEffectFromFileExW"(byval device as IDirect3DDevice9 ptr, byval srcfile as const wstring ptr, byval defines as const D3DXMACRO ptr, byval include as ID3DXInclude ptr, byval skip_constants as const zstring ptr, byval flags as DWORD, byval pool as ID3DXEffectPool ptr, byval effect as ID3DXEffect ptr ptr, byval compilation_errors as ID3DXBuffer ptr ptr) as HRESULT
#else
	declare function D3DXCreateEffectFromFileEx alias "D3DXCreateEffectFromFileExA"(byval device as IDirect3DDevice9 ptr, byval srcfile as const zstring ptr, byval defines as const D3DXMACRO ptr, byval include as ID3DXInclude ptr, byval skip_constants as const zstring ptr, byval flags as DWORD, byval pool as ID3DXEffectPool ptr, byval effect as ID3DXEffect ptr ptr, byval compilation_errors as ID3DXBuffer ptr ptr) as HRESULT
#endif

declare function D3DXCreateEffectFromFileA(byval device as IDirect3DDevice9 ptr, byval srcfile as const zstring ptr, byval defines as const D3DXMACRO ptr, byval include as ID3DXInclude ptr, byval flags as DWORD, byval pool as ID3DXEffectPool ptr, byval effect as ID3DXEffect ptr ptr, byval compilation_errors as ID3DXBuffer ptr ptr) as HRESULT
declare function D3DXCreateEffectFromFileW(byval device as IDirect3DDevice9 ptr, byval srcfile as const wstring ptr, byval defines as const D3DXMACRO ptr, byval include as ID3DXInclude ptr, byval flags as DWORD, byval pool as ID3DXEffectPool ptr, byval effect as ID3DXEffect ptr ptr, byval compilation_errors as ID3DXBuffer ptr ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXCreateEffectFromFile alias "D3DXCreateEffectFromFileW"(byval device as IDirect3DDevice9 ptr, byval srcfile as const wstring ptr, byval defines as const D3DXMACRO ptr, byval include as ID3DXInclude ptr, byval flags as DWORD, byval pool as ID3DXEffectPool ptr, byval effect as ID3DXEffect ptr ptr, byval compilation_errors as ID3DXBuffer ptr ptr) as HRESULT
#else
	declare function D3DXCreateEffectFromFile alias "D3DXCreateEffectFromFileA"(byval device as IDirect3DDevice9 ptr, byval srcfile as const zstring ptr, byval defines as const D3DXMACRO ptr, byval include as ID3DXInclude ptr, byval flags as DWORD, byval pool as ID3DXEffectPool ptr, byval effect as ID3DXEffect ptr ptr, byval compilation_errors as ID3DXBuffer ptr ptr) as HRESULT
#endif

declare function D3DXCreateEffectFromResourceExA(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval srcresource as const zstring ptr, byval defines as const D3DXMACRO ptr, byval include as ID3DXInclude ptr, byval skip_constants as const zstring ptr, byval flags as DWORD, byval pool as ID3DXEffectPool ptr, byval effect as ID3DXEffect ptr ptr, byval compilation_errors as ID3DXBuffer ptr ptr) as HRESULT
declare function D3DXCreateEffectFromResourceExW(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval srcresource as const wstring ptr, byval defines as const D3DXMACRO ptr, byval include as ID3DXInclude ptr, byval skip_constants as const zstring ptr, byval flags as DWORD, byval pool as ID3DXEffectPool ptr, byval effect as ID3DXEffect ptr ptr, byval compilation_errors as ID3DXBuffer ptr ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXCreateEffectFromResourceEx alias "D3DXCreateEffectFromResourceExW"(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval srcresource as const wstring ptr, byval defines as const D3DXMACRO ptr, byval include as ID3DXInclude ptr, byval skip_constants as const zstring ptr, byval flags as DWORD, byval pool as ID3DXEffectPool ptr, byval effect as ID3DXEffect ptr ptr, byval compilation_errors as ID3DXBuffer ptr ptr) as HRESULT
#else
	declare function D3DXCreateEffectFromResourceEx alias "D3DXCreateEffectFromResourceExA"(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval srcresource as const zstring ptr, byval defines as const D3DXMACRO ptr, byval include as ID3DXInclude ptr, byval skip_constants as const zstring ptr, byval flags as DWORD, byval pool as ID3DXEffectPool ptr, byval effect as ID3DXEffect ptr ptr, byval compilation_errors as ID3DXBuffer ptr ptr) as HRESULT
#endif

declare function D3DXCreateEffectFromResourceA(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval srcresource as const zstring ptr, byval defines as const D3DXMACRO ptr, byval include as ID3DXInclude ptr, byval flags as DWORD, byval pool as ID3DXEffectPool ptr, byval effect as ID3DXEffect ptr ptr, byval compilation_errors as ID3DXBuffer ptr ptr) as HRESULT
declare function D3DXCreateEffectFromResourceW(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval srcresource as const wstring ptr, byval defines as const D3DXMACRO ptr, byval include as ID3DXInclude ptr, byval flags as DWORD, byval pool as ID3DXEffectPool ptr, byval effect as ID3DXEffect ptr ptr, byval compilation_errors as ID3DXBuffer ptr ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXCreateEffectFromResource alias "D3DXCreateEffectFromResourceW"(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval srcresource as const wstring ptr, byval defines as const D3DXMACRO ptr, byval include as ID3DXInclude ptr, byval flags as DWORD, byval pool as ID3DXEffectPool ptr, byval effect as ID3DXEffect ptr ptr, byval compilation_errors as ID3DXBuffer ptr ptr) as HRESULT
#else
	declare function D3DXCreateEffectFromResource alias "D3DXCreateEffectFromResourceA"(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval srcresource as const zstring ptr, byval defines as const D3DXMACRO ptr, byval include as ID3DXInclude ptr, byval flags as DWORD, byval pool as ID3DXEffectPool ptr, byval effect as ID3DXEffect ptr ptr, byval compilation_errors as ID3DXBuffer ptr ptr) as HRESULT
#endif

declare function D3DXCreateEffectCompilerFromFileA(byval srcfile as const zstring ptr, byval defines as const D3DXMACRO ptr, byval include as ID3DXInclude ptr, byval flags as DWORD, byval effectcompiler as ID3DXEffectCompiler ptr ptr, byval parseerrors as ID3DXBuffer ptr ptr) as HRESULT
declare function D3DXCreateEffectCompilerFromFileW(byval srcfile as const wstring ptr, byval defines as const D3DXMACRO ptr, byval include as ID3DXInclude ptr, byval flags as DWORD, byval effectcompiler as ID3DXEffectCompiler ptr ptr, byval parseerrors as ID3DXBuffer ptr ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXCreateEffectCompilerFromFile alias "D3DXCreateEffectCompilerFromFileW"(byval srcfile as const wstring ptr, byval defines as const D3DXMACRO ptr, byval include as ID3DXInclude ptr, byval flags as DWORD, byval effectcompiler as ID3DXEffectCompiler ptr ptr, byval parseerrors as ID3DXBuffer ptr ptr) as HRESULT
#else
	declare function D3DXCreateEffectCompilerFromFile alias "D3DXCreateEffectCompilerFromFileA"(byval srcfile as const zstring ptr, byval defines as const D3DXMACRO ptr, byval include as ID3DXInclude ptr, byval flags as DWORD, byval effectcompiler as ID3DXEffectCompiler ptr ptr, byval parseerrors as ID3DXBuffer ptr ptr) as HRESULT
#endif

declare function D3DXCreateEffectCompilerFromResourceA(byval srcmodule as HMODULE, byval srcresource as const zstring ptr, byval defines as const D3DXMACRO ptr, byval include as ID3DXInclude ptr, byval flags as DWORD, byval effectcompiler as ID3DXEffectCompiler ptr ptr, byval parseerrors as ID3DXBuffer ptr ptr) as HRESULT
declare function D3DXCreateEffectCompilerFromResourceW(byval srcmodule as HMODULE, byval srcresource as const wstring ptr, byval defines as const D3DXMACRO ptr, byval include as ID3DXInclude ptr, byval flags as DWORD, byval effectcompiler as ID3DXEffectCompiler ptr ptr, byval parseerrors as ID3DXBuffer ptr ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXCreateEffectCompilerFromResource alias "D3DXCreateEffectCompilerFromResourceW"(byval srcmodule as HMODULE, byval srcresource as const wstring ptr, byval defines as const D3DXMACRO ptr, byval include as ID3DXInclude ptr, byval flags as DWORD, byval effectcompiler as ID3DXEffectCompiler ptr ptr, byval parseerrors as ID3DXBuffer ptr ptr) as HRESULT
#else
	declare function D3DXCreateEffectCompilerFromResource alias "D3DXCreateEffectCompilerFromResourceA"(byval srcmodule as HMODULE, byval srcresource as const zstring ptr, byval defines as const D3DXMACRO ptr, byval include as ID3DXInclude ptr, byval flags as DWORD, byval effectcompiler as ID3DXEffectCompiler ptr ptr, byval parseerrors as ID3DXBuffer ptr ptr) as HRESULT
#endif

end extern
