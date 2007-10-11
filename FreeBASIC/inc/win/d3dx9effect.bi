''
''
'' d3dx9effect -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_d3dx9effect_bi__
#define __win_d3dx9effect_bi__

#include once "win/d3dx9.bi"

#define D3DXFX_DONOTSAVESTATE (1 shl 0)
#define D3DXFX_DONOTSAVESHADERSTATE (1 shl 1)
#define D3DXFX_DONOTSAVESAMPLERSTATE (1 shl 2)
#define D3DX_PARAMETER_SHARED (1 shl 0)
#define D3DX_PARAMETER_LITERAL (1 shl 1)
#define D3DX_PARAMETER_ANNOTATION (1 shl 2)

type D3DXEFFECT_DESC
	Creator as LPCSTR
	Parameters as UINT
	Techniques as UINT
	Functions as UINT
end type

type D3DXPARAMETER_DESC
	Name as LPCSTR
	Semantic as LPCSTR
	Class as D3DXPARAMETER_CLASS
	Type as D3DXPARAMETER_TYPE
	Rows as UINT
	Columns as UINT
	Elements as UINT
	Annotations as UINT
	StructMembers as UINT
	Flags as DWORD
	Bytes as UINT
end type

type D3DXTECHNIQUE_DESC
	Name as LPCSTR
	Passes as UINT
	Annotations as UINT
end type

type D3DXPASS_DESC
	Name as LPCSTR
	Annotations as UINT
	pVertexShaderFunction as DWORD ptr
	pPixelShaderFunction as DWORD ptr
end type

type D3DXFUNCTION_DESC
	Name as LPCSTR
	Annotations as UINT
end type

type LPD3DXEFFECTPOOL as ID3DXEffectPool ptr

extern IID_ID3DXEffectPool alias "IID_ID3DXEffectPool" as GUID

type ID3DXEffectPoolVtbl_ as ID3DXEffectPoolVtbl

type ID3DXEffectPool
	lpVtbl as ID3DXEffectPoolVtbl_ ptr
end type

type ID3DXEffectPoolVtbl
	QueryInterface as function(byval as ID3DXEffectPool ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as ID3DXEffectPool ptr) as ULONG
	Release as function(byval as ID3DXEffectPool ptr) as ULONG
end type

type LPD3DXBASEEFFECT as ID3DXBaseEffect ptr

extern IID_ID3DXBaseEffect alias "IID_ID3DXBaseEffect" as GUID

type ID3DXBaseEffectVtbl_ as ID3DXBaseEffectVtbl

type ID3DXBaseEffect
	lpVtbl as ID3DXBaseEffectVtbl_ ptr
end type

type ID3DXBaseEffectVtbl
	QueryInterface as function(byval as ID3DXBaseEffect ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as ID3DXBaseEffect ptr) as ULONG
	Release as function(byval as ID3DXBaseEffect ptr) as ULONG
	GetDesc as function(byval as ID3DXBaseEffect ptr, byval as D3DXEFFECT_DESC ptr) as HRESULT
	GetParameterDesc as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as D3DXPARAMETER_DESC ptr) as HRESULT
	GetTechniqueDesc as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as D3DXTECHNIQUE_DESC ptr) as HRESULT
	GetPassDesc as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as D3DXPASS_DESC ptr) as HRESULT
	GetFunctionDesc as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as D3DXFUNCTION_DESC ptr) as HRESULT
	GetParameter as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as UINT) as D3DXHANDLE
	GetParameterByName as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as LPCSTR) as D3DXHANDLE
	GetParameterBySemantic as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as LPCSTR) as D3DXHANDLE
	GetParameterElement as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as UINT) as D3DXHANDLE
	GetTechnique as function(byval as ID3DXBaseEffect ptr, byval as UINT) as D3DXHANDLE
	GetTechniqueByName as function(byval as ID3DXBaseEffect ptr, byval as LPCSTR) as D3DXHANDLE
	GetPass as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as UINT) as D3DXHANDLE
	GetPassByName as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as LPCSTR) as D3DXHANDLE
	GetFunction as function(byval as ID3DXBaseEffect ptr, byval as UINT) as D3DXHANDLE
	GetFunctionByName as function(byval as ID3DXBaseEffect ptr, byval as LPCSTR) as D3DXHANDLE
	GetAnnotation as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as UINT) as D3DXHANDLE
	GetAnnotationByName as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as LPCSTR) as D3DXHANDLE
	SetValue as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as LPCVOID, byval as UINT) as HRESULT
	GetValue as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as LPVOID, byval as UINT) as HRESULT
	SetBool as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as BOOL) as HRESULT
	GetBool as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as BOOL ptr) as HRESULT
	SetBoolArray as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as BOOL ptr, byval as UINT) as HRESULT
	GetBoolArray as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as BOOL ptr, byval as UINT) as HRESULT
	SetInt as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as INT_) as HRESULT
	GetInt as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as INT_ ptr) as HRESULT
	SetIntArray as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as INT_ ptr, byval as UINT) as HRESULT
	GetIntArray as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as INT_ ptr, byval as UINT) as HRESULT
	SetFloat as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as FLOAT) as HRESULT
	GetFloat as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as FLOAT ptr) as HRESULT
	SetFloatArray as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as FLOAT ptr, byval as UINT) as HRESULT
	GetFloatArray as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as FLOAT ptr, byval as UINT) as HRESULT
	SetVector as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as D3DXVECTOR4 ptr) as HRESULT
	GetVector as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as D3DXVECTOR4 ptr) as HRESULT
	SetVectorArray as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as D3DXVECTOR4 ptr, byval as UINT) as HRESULT
	GetVectorArray as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as D3DXVECTOR4 ptr, byval as UINT) as HRESULT
	SetMatrix as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr) as HRESULT
	GetMatrix as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr) as HRESULT
	SetMatrixArray as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr, byval as UINT) as HRESULT
	GetMatrixArray as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr, byval as UINT) as HRESULT
	SetMatrixPointerArray as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr ptr, byval as UINT) as HRESULT
	GetMatrixPointerArray as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr ptr, byval as UINT) as HRESULT
	SetMatrixTranspose as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr) as HRESULT
	GetMatrixTranspose as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr) as HRESULT
	SetMatrixTransposeArray as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr, byval as UINT) as HRESULT
	GetMatrixTransposeArray as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr, byval as UINT) as HRESULT
	SetMatrixTransposePointerArray as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr ptr, byval as UINT) as HRESULT
	GetMatrixTransposePointerArray as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr ptr, byval as UINT) as HRESULT
	SetString as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as LPCSTR) as HRESULT
	GetString as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as LPCSTR ptr) as HRESULT
	SetTexture as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as LPDIRECT3DBASETEXTURE9) as HRESULT
	GetTexture as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as LPDIRECT3DBASETEXTURE9 ptr) as HRESULT
	SetPixelShader as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as LPDIRECT3DPIXELSHADER9) as HRESULT
	GetPixelShader as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as LPDIRECT3DPIXELSHADER9 ptr) as HRESULT
	SetVertexShader as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as LPDIRECT3DVERTEXSHADER9) as HRESULT
	GetVertexShader as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as LPDIRECT3DVERTEXSHADER9 ptr) as HRESULT
	SetArrayRange as function(byval as ID3DXBaseEffect ptr, byval as D3DXHANDLE, byval as UINT, byval as UINT) as HRESULT
end type

type LPD3DXEFFECTSTATEMANAGER as ID3DXEffectStateManager ptr

extern IID_ID3DXEffectStateManager alias "IID_ID3DXEffectStateManager" as GUID

type ID3DXEffectStateManagerVtbl_ as ID3DXEffectStateManagerVtbl

type ID3DXEffectStateManager
	lpVtbl as ID3DXEffectStateManagerVtbl_ ptr
end type

type ID3DXEffectStateManagerVtbl
	QueryInterface as function(byval as ID3DXEffectStateManager ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as ID3DXEffectStateManager ptr) as ULONG
	Release as function(byval as ID3DXEffectStateManager ptr) as ULONG
	SetTransform as function(byval as ID3DXEffectStateManager ptr, byval as D3DTRANSFORMSTATETYPE, byval as D3DMATRIX ptr) as HRESULT
	SetMaterial as function(byval as ID3DXEffectStateManager ptr, byval as D3DMATERIAL9 ptr) as HRESULT
	SetLight as function(byval as ID3DXEffectStateManager ptr, byval as DWORD, byval as D3DLIGHT9 ptr) as HRESULT
	LightEnable as function(byval as ID3DXEffectStateManager ptr, byval as DWORD, byval as BOOL) as HRESULT
	SetRenderState as function(byval as ID3DXEffectStateManager ptr, byval as D3DRENDERSTATETYPE, byval as DWORD) as HRESULT
	SetTexture as function(byval as ID3DXEffectStateManager ptr, byval as DWORD, byval as LPDIRECT3DBASETEXTURE9) as HRESULT
	SetTextureStageState as function(byval as ID3DXEffectStateManager ptr, byval as DWORD, byval as D3DTEXTURESTAGESTATETYPE, byval as DWORD) as HRESULT
	SetSamplerState as function(byval as ID3DXEffectStateManager ptr, byval as DWORD, byval as D3DSAMPLERSTATETYPE, byval as DWORD) as HRESULT
	SetNPatchMode as function(byval as ID3DXEffectStateManager ptr, byval as FLOAT) as HRESULT
	SetFVF as function(byval as ID3DXEffectStateManager ptr, byval as DWORD) as HRESULT
	SetVertexShader as function(byval as ID3DXEffectStateManager ptr, byval as LPDIRECT3DVERTEXSHADER9) as HRESULT
	SetVertexShaderConstantF as function(byval as ID3DXEffectStateManager ptr, byval as UINT, byval as FLOAT ptr, byval as UINT) as HRESULT
	SetVertexShaderConstantI as function(byval as ID3DXEffectStateManager ptr, byval as UINT, byval as INT_ ptr, byval as UINT) as HRESULT
	SetVertexShaderConstantB as function(byval as ID3DXEffectStateManager ptr, byval as UINT, byval as BOOL ptr, byval as UINT) as HRESULT
	SetPixelShader as function(byval as ID3DXEffectStateManager ptr, byval as LPDIRECT3DPIXELSHADER9) as HRESULT
	SetPixelShaderConstantF as function(byval as ID3DXEffectStateManager ptr, byval as UINT, byval as FLOAT ptr, byval as UINT) as HRESULT
	SetPixelShaderConstantI as function(byval as ID3DXEffectStateManager ptr, byval as UINT, byval as INT_ ptr, byval as UINT) as HRESULT
	SetPixelShaderConstantB as function(byval as ID3DXEffectStateManager ptr, byval as UINT, byval as BOOL ptr, byval as UINT) as HRESULT
end type

type LPD3DXEFFECT as ID3DXEffect ptr

extern IID_ID3DXEffect alias "IID_ID3DXEffect" as GUID

type ID3DXEffectVtbl_ as ID3DXEffectVtbl

type ID3DXEffect
	lpVtbl as ID3DXEffectVtbl_ ptr
end type

type ID3DXEffectVtbl
	QueryInterface as function(byval as ID3DXEffect ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as ID3DXEffect ptr) as ULONG
	Release as function(byval as ID3DXEffect ptr) as ULONG
	GetDesc as function(byval as ID3DXEffect ptr, byval as D3DXEFFECT_DESC ptr) as HRESULT
	GetParameterDesc as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as D3DXPARAMETER_DESC ptr) as HRESULT
	GetTechniqueDesc as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as D3DXTECHNIQUE_DESC ptr) as HRESULT
	GetPassDesc as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as D3DXPASS_DESC ptr) as HRESULT
	GetFunctionDesc as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as D3DXFUNCTION_DESC ptr) as HRESULT
	GetParameter as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as UINT) as D3DXHANDLE
	GetParameterByName as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as LPCSTR) as D3DXHANDLE
	GetParameterBySemantic as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as LPCSTR) as D3DXHANDLE
	GetParameterElement as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as UINT) as D3DXHANDLE
	GetTechnique as function(byval as ID3DXEffect ptr, byval as UINT) as D3DXHANDLE
	GetTechniqueByName as function(byval as ID3DXEffect ptr, byval as LPCSTR) as D3DXHANDLE
	GetPass as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as UINT) as D3DXHANDLE
	GetPassByName as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as LPCSTR) as D3DXHANDLE
	GetFunction as function(byval as ID3DXEffect ptr, byval as UINT) as D3DXHANDLE
	GetFunctionByName as function(byval as ID3DXEffect ptr, byval as LPCSTR) as D3DXHANDLE
	GetAnnotation as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as UINT) as D3DXHANDLE
	GetAnnotationByName as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as LPCSTR) as D3DXHANDLE
	SetValue as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as LPCVOID, byval as UINT) as HRESULT
	GetValue as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as LPVOID, byval as UINT) as HRESULT
	SetBool as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as BOOL) as HRESULT
	GetBool as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as BOOL ptr) as HRESULT
	SetBoolArray as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as BOOL ptr, byval as UINT) as HRESULT
	GetBoolArray as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as BOOL ptr, byval as UINT) as HRESULT
	SetInt as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as INT_) as HRESULT
	GetInt as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as INT_ ptr) as HRESULT
	SetIntArray as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as INT_ ptr, byval as UINT) as HRESULT
	GetIntArray as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as INT_ ptr, byval as UINT) as HRESULT
	SetFloat as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as FLOAT) as HRESULT
	GetFloat as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as FLOAT ptr) as HRESULT
	SetFloatArray as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as FLOAT ptr, byval as UINT) as HRESULT
	GetFloatArray as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as FLOAT ptr, byval as UINT) as HRESULT
	SetVector as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as D3DXVECTOR4 ptr) as HRESULT
	GetVector as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as D3DXVECTOR4 ptr) as HRESULT
	SetVectorArray as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as D3DXVECTOR4 ptr, byval as UINT) as HRESULT
	GetVectorArray as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as D3DXVECTOR4 ptr, byval as UINT) as HRESULT
	SetMatrix as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr) as HRESULT
	GetMatrix as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr) as HRESULT
	SetMatrixArray as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr, byval as UINT) as HRESULT
	GetMatrixArray as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr, byval as UINT) as HRESULT
	SetMatrixPointerArray as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr ptr, byval as UINT) as HRESULT
	GetMatrixPointerArray as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr ptr, byval as UINT) as HRESULT
	SetMatrixTranspose as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr) as HRESULT
	GetMatrixTranspose as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr) as HRESULT
	SetMatrixTransposeArray as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr, byval as UINT) as HRESULT
	GetMatrixTransposeArray as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr, byval as UINT) as HRESULT
	SetMatrixTransposePointerArray as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr ptr, byval as UINT) as HRESULT
	GetMatrixTransposePointerArray as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr ptr, byval as UINT) as HRESULT
	SetString as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as LPCSTR) as HRESULT
	GetString as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as LPCSTR ptr) as HRESULT
	SetTexture as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as LPDIRECT3DBASETEXTURE9) as HRESULT
	GetTexture as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as LPDIRECT3DBASETEXTURE9 ptr) as HRESULT
	SetPixelShader as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as LPDIRECT3DPIXELSHADER9) as HRESULT
	GetPixelShader as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as LPDIRECT3DPIXELSHADER9 ptr) as HRESULT
	SetVertexShader as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as LPDIRECT3DVERTEXSHADER9) as HRESULT
	GetVertexShader as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as LPDIRECT3DVERTEXSHADER9 ptr) as HRESULT
	SetArrayRange as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as UINT, byval as UINT) as HRESULT
	GetPool as function(byval as ID3DXEffect ptr, byval as LPD3DXEFFECTPOOL ptr) as HRESULT
	SetTechnique as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE) as HRESULT
	GetCurrentTechnique as function(byval as ID3DXEffect ptr) as D3DXHANDLE
	ValidateTechnique as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE) as HRESULT
	FindNextValidTechnique as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as D3DXHANDLE ptr) as HRESULT
	IsParameterUsed as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE, byval as D3DXHANDLE) as BOOL
	Begin as function(byval as ID3DXEffect ptr, byval as UINT ptr, byval as DWORD) as HRESULT
	BeginPass as function(byval as ID3DXEffect ptr, byval as UINT) as HRESULT
	CommitChanges as function(byval as ID3DXEffect ptr) as HRESULT
	EndPass as function(byval as ID3DXEffect ptr) as HRESULT
	End as function(byval as ID3DXEffect ptr) as HRESULT
	GetDevice as function(byval as ID3DXEffect ptr, byval as LPDIRECT3DDEVICE9 ptr) as HRESULT
	OnLostDevice as function(byval as ID3DXEffect ptr) as HRESULT
	OnResetDevice as function(byval as ID3DXEffect ptr) as HRESULT
	SetStateManager as function(byval as ID3DXEffect ptr, byval as LPD3DXEFFECTSTATEMANAGER) as HRESULT
	GetStateManager as function(byval as ID3DXEffect ptr, byval as LPD3DXEFFECTSTATEMANAGER ptr) as HRESULT
	BeginParameterBlock as function(byval as ID3DXEffect ptr) as HRESULT
	EndParameterBlock as function(byval as ID3DXEffect ptr) as D3DXHANDLE
	ApplyParameterBlock as function(byval as ID3DXEffect ptr, byval as D3DXHANDLE) as HRESULT
	CloneEffect as function(byval as ID3DXEffect ptr, byval as LPDIRECT3DDEVICE9, byval as LPD3DXEFFECT ptr) as HRESULT
end type

type LPD3DXEFFECTCOMPILER as ID3DXEffectCompiler ptr

extern IID_ID3DXEffectCompiler alias "IID_ID3DXEffectCompiler" as GUID

type ID3DXEffectCompilerVtbl_ as ID3DXEffectCompilerVtbl

type ID3DXEffectCompiler
	lpVtbl as ID3DXEffectCompilerVtbl_ ptr
end type

type ID3DXEffectCompilerVtbl
	QueryInterface as function(byval as ID3DXEffectCompiler ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as ID3DXEffectCompiler ptr) as ULONG
	Release as function(byval as ID3DXEffectCompiler ptr) as ULONG
	GetDesc as function(byval as ID3DXEffectCompiler ptr, byval as D3DXEFFECT_DESC ptr) as HRESULT
	GetParameterDesc as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as D3DXPARAMETER_DESC ptr) as HRESULT
	GetTechniqueDesc as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as D3DXTECHNIQUE_DESC ptr) as HRESULT
	GetPassDesc as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as D3DXPASS_DESC ptr) as HRESULT
	GetFunctionDesc as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as D3DXFUNCTION_DESC ptr) as HRESULT
	GetParameter as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as UINT) as D3DXHANDLE
	GetParameterByName as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as LPCSTR) as D3DXHANDLE
	GetParameterBySemantic as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as LPCSTR) as D3DXHANDLE
	GetParameterElement as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as UINT) as D3DXHANDLE
	GetTechnique as function(byval as ID3DXEffectCompiler ptr, byval as UINT) as D3DXHANDLE
	GetTechniqueByName as function(byval as ID3DXEffectCompiler ptr, byval as LPCSTR) as D3DXHANDLE
	GetPass as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as UINT) as D3DXHANDLE
	GetPassByName as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as LPCSTR) as D3DXHANDLE
	GetFunction as function(byval as ID3DXEffectCompiler ptr, byval as UINT) as D3DXHANDLE
	GetFunctionByName as function(byval as ID3DXEffectCompiler ptr, byval as LPCSTR) as D3DXHANDLE
	GetAnnotation as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as UINT) as D3DXHANDLE
	GetAnnotationByName as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as LPCSTR) as D3DXHANDLE
	SetValue as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as LPCVOID, byval as UINT) as HRESULT
	GetValue as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as LPVOID, byval as UINT) as HRESULT
	SetBool as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as BOOL) as HRESULT
	GetBool as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as BOOL ptr) as HRESULT
	SetBoolArray as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as BOOL ptr, byval as UINT) as HRESULT
	GetBoolArray as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as BOOL ptr, byval as UINT) as HRESULT
	SetInt as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as INT_) as HRESULT
	GetInt as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as INT_ ptr) as HRESULT
	SetIntArray as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as INT_ ptr, byval as UINT) as HRESULT
	GetIntArray as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as INT_ ptr, byval as UINT) as HRESULT
	SetFloat as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as FLOAT) as HRESULT
	GetFloat as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as FLOAT ptr) as HRESULT
	SetFloatArray as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as FLOAT ptr, byval as UINT) as HRESULT
	GetFloatArray as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as FLOAT ptr, byval as UINT) as HRESULT
	SetVector as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as D3DXVECTOR4 ptr) as HRESULT
	GetVector as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as D3DXVECTOR4 ptr) as HRESULT
	SetVectorArray as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as D3DXVECTOR4 ptr, byval as UINT) as HRESULT
	GetVectorArray as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as D3DXVECTOR4 ptr, byval as UINT) as HRESULT
	SetMatrix as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr) as HRESULT
	GetMatrix as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr) as HRESULT
	SetMatrixArray as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr, byval as UINT) as HRESULT
	GetMatrixArray as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr, byval as UINT) as HRESULT
	SetMatrixPointerArray as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr ptr, byval as UINT) as HRESULT
	GetMatrixPointerArray as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr ptr, byval as UINT) as HRESULT
	SetMatrixTranspose as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr) as HRESULT
	GetMatrixTranspose as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr) as HRESULT
	SetMatrixTransposeArray as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr, byval as UINT) as HRESULT
	GetMatrixTransposeArray as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr, byval as UINT) as HRESULT
	SetMatrixTransposePointerArray as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr ptr, byval as UINT) as HRESULT
	GetMatrixTransposePointerArray as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr ptr, byval as UINT) as HRESULT
	SetString as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as LPCSTR) as HRESULT
	GetString as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as LPCSTR ptr) as HRESULT
	SetTexture as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as LPDIRECT3DBASETEXTURE9) as HRESULT
	GetTexture as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as LPDIRECT3DBASETEXTURE9 ptr) as HRESULT
	SetPixelShader as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as LPDIRECT3DPIXELSHADER9) as HRESULT
	GetPixelShader as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as LPDIRECT3DPIXELSHADER9 ptr) as HRESULT
	SetVertexShader as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as LPDIRECT3DVERTEXSHADER9) as HRESULT
	GetVertexShader as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as LPDIRECT3DVERTEXSHADER9 ptr) as HRESULT
	SetArrayRange as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as UINT, byval as UINT) as HRESULT
	SetLiteral as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as BOOL) as HRESULT
	GetLiteral as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as BOOL ptr) as HRESULT
	CompileEffect as function(byval as ID3DXEffectCompiler ptr, byval as DWORD, byval as LPD3DXBUFFER ptr, byval as LPD3DXBUFFER ptr) as HRESULT
	CompileShader as function(byval as ID3DXEffectCompiler ptr, byval as D3DXHANDLE, byval as LPCSTR, byval as DWORD, byval as LPD3DXBUFFER ptr, byval as LPD3DXBUFFER ptr, byval as LPD3DXCONSTANTTABLE ptr) as HRESULT
end type

declare function D3DXCreateEffectPool alias "D3DXCreateEffectPool" (byval ppPool as LPD3DXEFFECTPOOL ptr) as HRESULT
declare function D3DXCreateEffect alias "D3DXCreateEffect" (byval pDevice as LPDIRECT3DDEVICE9, byval pSrcData as LPCVOID, byval SrcDataLen as UINT, byval pDefines as D3DXMACRO ptr, byval pInclude as LPD3DXINCLUDE, byval Flags as DWORD, byval pPool as LPD3DXEFFECTPOOL, byval ppEffect as LPD3DXEFFECT ptr, byval ppCompilationErrors as LPD3DXBUFFER ptr) as HRESULT
declare function D3DXCreateEffectCompiler alias "D3DXCreateEffectCompiler" (byval pSrcData as LPCSTR, byval SrcDataLen as UINT, byval pDefines as D3DXMACRO ptr, byval pInclude as LPD3DXINCLUDE, byval Flags as DWORD, byval ppCompiler as LPD3DXEFFECTCOMPILER ptr, byval ppParseErrors as LPD3DXBUFFER ptr) as HRESULT
declare function D3DXDisassembleEffect alias "D3DXDisassembleEffect" (byval pEffect as LPD3DXEFFECT, byval EnableColorCode as BOOL, byval ppDisassembly as LPD3DXBUFFER ptr) as HRESULT

#ifdef UNICODE
declare function D3DXCreateEffectFromFile alias "D3DXCreateEffectFromFileW" (byval pDevice as LPDIRECT3DDEVICE9, byval pSrcFile as LPCWSTR, byval pDefines as D3DXMACRO ptr, byval pInclude as LPD3DXINCLUDE, byval Flags as DWORD, byval pPool as LPD3DXEFFECTPOOL, byval ppEffect as LPD3DXEFFECT ptr, byval ppCompilationErrors as LPD3DXBUFFER ptr) as HRESULT
declare function D3DXCreateEffectFromResource alias "D3DXCreateEffectFromResourceW" (byval pDevice as LPDIRECT3DDEVICE9, byval hSrcModule as HMODULE, byval pSrcResource as LPCWSTR, byval pDefines as D3DXMACRO ptr, byval pInclude as LPD3DXINCLUDE, byval Flags as DWORD, byval pPool as LPD3DXEFFECTPOOL, byval ppEffect as LPD3DXEFFECT ptr, byval ppCompilationErrors as LPD3DXBUFFER ptr) as HRESULT
declare function D3DXCreateEffectCompilerFromFile alias "D3DXCreateEffectCompilerFromFileW" (byval pSrcFile as LPCWSTR, byval pDefines as D3DXMACRO ptr, byval pInclude as LPD3DXINCLUDE, byval Flags as DWORD, byval ppCompiler as LPD3DXEFFECTCOMPILER ptr, byval ppParseErrors as LPD3DXBUFFER ptr) as HRESULT
declare function D3DXCreateEffectCompilerFromResource alias "D3DXCreateEffectCompilerFromResourceW" (byval hSrcModule as HMODULE, byval pSrcResource as LPCWSTR, byval pDefines as D3DXMACRO ptr, byval pInclude as LPD3DXINCLUDE, byval Flags as DWORD, byval ppCompiler as LPD3DXEFFECTCOMPILER ptr, byval ppParseErrors as LPD3DXBUFFER ptr) as HRESULT
#else
declare function D3DXCreateEffectFromFile alias "D3DXCreateEffectFromFileA" (byval pDevice as LPDIRECT3DDEVICE9, byval pSrcFile as LPCSTR, byval pDefines as D3DXMACRO ptr, byval pInclude as LPD3DXINCLUDE, byval Flags as DWORD, byval pPool as LPD3DXEFFECTPOOL, byval ppEffect as LPD3DXEFFECT ptr, byval ppCompilationErrors as LPD3DXBUFFER ptr) as HRESULT
declare function D3DXCreateEffectFromResource alias "D3DXCreateEffectFromResourceA" (byval pDevice as LPDIRECT3DDEVICE9, byval hSrcModule as HMODULE, byval pSrcResource as LPCSTR, byval pDefines as D3DXMACRO ptr, byval pInclude as LPD3DXINCLUDE, byval Flags as DWORD, byval pPool as LPD3DXEFFECTPOOL, byval ppEffect as LPD3DXEFFECT ptr, byval ppCompilationErrors as LPD3DXBUFFER ptr) as HRESULT
declare function D3DXCreateEffectCompilerFromFile alias "D3DXCreateEffectCompilerFromFileA" (byval pSrcFile as LPCSTR, byval pDefines as D3DXMACRO ptr, byval pInclude as LPD3DXINCLUDE, byval Flags as DWORD, byval ppCompiler as LPD3DXEFFECTCOMPILER ptr, byval ppParseErrors as LPD3DXBUFFER ptr) as HRESULT
declare function D3DXCreateEffectCompilerFromResource alias "D3DXCreateEffectCompilerFromResourceA" (byval hSrcModule as HMODULE, byval pSrcResource as LPCSTR, byval pDefines as D3DXMACRO ptr, byval pInclude as LPD3DXINCLUDE, byval Flags as DWORD, byval ppCompiler as LPD3DXEFFECTCOMPILER ptr, byval ppParseErrors as LPD3DXBUFFER ptr) as HRESULT
#endif

#endif
