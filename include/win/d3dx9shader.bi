''
''
'' d3dx9shader -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_d3dx9shader_bi__
#define __win_d3dx9shader_bi__

#include once "win/d3dx9.bi"

#define D3DXTX_VERSION(_Major,_Minor) ((asc("T") shl 24) or (asc("X") shl 16) or ((_Major) shl 8) or (_Minor))

#define D3DXSHADER_DEBUG (1 shl 0)
#define D3DXSHADER_SKIPVALIDATION (1 shl 1)
#define D3DXSHADER_SKIPOPTIMIZATION (1 shl 2)
#define D3DXSHADER_PACKMATRIX_ROWMAJOR (1 shl 3)
#define D3DXSHADER_PACKMATRIX_COLUMNMAJOR (1 shl 4)
#define D3DXSHADER_PARTIALPRECISION (1 shl 5)
#define D3DXSHADER_FORCE_VS_SOFTWARE_NOOPT (1 shl 6)
#define D3DXSHADER_FORCE_PS_SOFTWARE_NOOPT (1 shl 7)
#define D3DXSHADER_NO_PRESHADER (1 shl 8)
#define D3DXSHADER_AVOID_FLOW_CONTROL (1 shl 9)
#define D3DXSHADER_PREFER_FLOW_CONTROL (1 shl 10)

type D3DXHANDLE as LPCSTR
type LPD3DXHANDLE as D3DXHANDLE ptr

type D3DXMACRO
	Name as LPCSTR
	Definition as LPCSTR
end type

type LPD3DXMACRO as D3DXMACRO ptr

type D3DXSEMANTIC
	Usage as UINT
	UsageIndex as UINT
end type

type LPD3DXSEMANTIC as D3DXSEMANTIC ptr

type D3DXFRAGMENT_DESC
	Name as LPCSTR
	Target as DWORD
end type

type LPD3DXFRAGMENT_DESC as D3DXFRAGMENT_DESC ptr

enum D3DXREGISTER_SET
	D3DXRS_BOOL
	D3DXRS_INT4
	D3DXRS_FLOAT4
	D3DXRS_SAMPLER
	D3DXRS_FORCE_DWORD = &h7fffffff
end enum

type LPD3DXREGISTER_SET as D3DXREGISTER_SET

enum D3DXPARAMETER_CLASS
	D3DXPC_SCALAR
	D3DXPC_VECTOR
	D3DXPC_MATRIX_ROWS
	D3DXPC_MATRIX_COLUMNS
	D3DXPC_OBJECT
	D3DXPC_STRUCT
	D3DXPC_FORCE_DWORD = &h7fffffff
end enum

type LPD3DXPARAMETER_CLASS as D3DXPARAMETER_CLASS

enum D3DXPARAMETER_TYPE
	D3DXPT_VOID
	D3DXPT_BOOL
	D3DXPT_INT
	D3DXPT_FLOAT
	D3DXPT_STRING
	D3DXPT_TEXTURE
	D3DXPT_TEXTURE1D
	D3DXPT_TEXTURE2D
	D3DXPT_TEXTURE3D
	D3DXPT_TEXTURECUBE
	D3DXPT_SAMPLER
	D3DXPT_SAMPLER1D
	D3DXPT_SAMPLER2D
	D3DXPT_SAMPLER3D
	D3DXPT_SAMPLERCUBE
	D3DXPT_PIXELSHADER
	D3DXPT_VERTEXSHADER
	D3DXPT_PIXELFRAGMENT
	D3DXPT_VERTEXFRAGMENT
	D3DXPT_FORCE_DWORD = &h7fffffff
end enum

type LPD3DXPARAMETER_TYPE as D3DXPARAMETER_TYPE

type D3DXCONSTANTTABLE_DESC
	Creator as LPCSTR
	Version as DWORD
	Constants as UINT
end type

type LPD3DXCONSTANTTABLE_DESC as D3DXCONSTANTTABLE_DESC ptr

type D3DXCONSTANT_DESC
	Name as LPCSTR
	RegisterSet as D3DXREGISTER_SET
	RegisterIndex as UINT
	RegisterCount as UINT
	Class as D3DXPARAMETER_CLASS
	Type as D3DXPARAMETER_TYPE
	Rows as UINT
	Columns as UINT
	Elements as UINT
	StructMembers as UINT
	Bytes as UINT
	DefaultValue as LPCVOID
end type

type LPD3DXCONSTANT_DESC as D3DXCONSTANT_DESC ptr
type LPD3DXCONSTANTTABLE as ID3DXConstantTable ptr

extern IID_ID3DXConstantTable alias "IID_ID3DXConstantTable" as GUID

type ID3DXConstantTableVtbl_ as ID3DXConstantTableVtbl

type ID3DXConstantTable
	lpVtbl as ID3DXConstantTableVtbl_ ptr
end type

type ID3DXConstantTableVtbl
	QueryInterface as function(byval as ID3DXConstantTable ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as ID3DXConstantTable ptr) as ULONG
	Release as function(byval as ID3DXConstantTable ptr) as ULONG
	GetBufferPointer as function(byval as ID3DXConstantTable ptr) as LPVOID
	GetBufferSize as function(byval as ID3DXConstantTable ptr) as DWORD
	GetDesc as function(byval as ID3DXConstantTable ptr, byval as D3DXCONSTANTTABLE_DESC ptr) as HRESULT
	GetConstantDesc as function(byval as ID3DXConstantTable ptr, byval as D3DXHANDLE, byval as D3DXCONSTANT_DESC ptr, byval as UINT ptr) as HRESULT
	GetSamplerIndex as function(byval as ID3DXConstantTable ptr, byval as D3DXHANDLE) as UINT
	GetConstant as function(byval as ID3DXConstantTable ptr, byval as D3DXHANDLE, byval as UINT) as D3DXHANDLE
	GetConstantByName as function(byval as ID3DXConstantTable ptr, byval as D3DXHANDLE, byval as LPCSTR) as D3DXHANDLE
	GetConstantElement as function(byval as ID3DXConstantTable ptr, byval as D3DXHANDLE, byval as UINT) as D3DXHANDLE
	SetDefaults as function(byval as ID3DXConstantTable ptr, byval as LPDIRECT3DDEVICE9) as HRESULT
	SetValue as function(byval as ID3DXConstantTable ptr, byval as LPDIRECT3DDEVICE9, byval as D3DXHANDLE, byval as LPCVOID, byval as UINT) as HRESULT
	SetBool as function(byval as ID3DXConstantTable ptr, byval as LPDIRECT3DDEVICE9, byval as D3DXHANDLE, byval as BOOL) as HRESULT
	SetBoolArray as function(byval as ID3DXConstantTable ptr, byval as LPDIRECT3DDEVICE9, byval as D3DXHANDLE, byval as BOOL ptr, byval as UINT) as HRESULT
	SetInt as function(byval as ID3DXConstantTable ptr, byval as LPDIRECT3DDEVICE9, byval as D3DXHANDLE, byval as INT_) as HRESULT
	SetIntArray as function(byval as ID3DXConstantTable ptr, byval as LPDIRECT3DDEVICE9, byval as D3DXHANDLE, byval as INT_ ptr, byval as UINT) as HRESULT
	SetFloat as function(byval as ID3DXConstantTable ptr, byval as LPDIRECT3DDEVICE9, byval as D3DXHANDLE, byval as FLOAT) as HRESULT
	SetFloatArray as function(byval as ID3DXConstantTable ptr, byval as LPDIRECT3DDEVICE9, byval as D3DXHANDLE, byval as FLOAT ptr, byval as UINT) as HRESULT
	SetVector as function(byval as ID3DXConstantTable ptr, byval as LPDIRECT3DDEVICE9, byval as D3DXHANDLE, byval as D3DXVECTOR4 ptr) as HRESULT
	SetVectorArray as function(byval as ID3DXConstantTable ptr, byval as LPDIRECT3DDEVICE9, byval as D3DXHANDLE, byval as D3DXVECTOR4 ptr, byval as UINT) as HRESULT
	SetMatrix as function(byval as ID3DXConstantTable ptr, byval as LPDIRECT3DDEVICE9, byval as D3DXHANDLE, byval as D3DXMATRIX ptr) as HRESULT
	SetMatrixArray as function(byval as ID3DXConstantTable ptr, byval as LPDIRECT3DDEVICE9, byval as D3DXHANDLE, byval as D3DXMATRIX ptr, byval as UINT) as HRESULT
	SetMatrixPointerArray as function(byval as ID3DXConstantTable ptr, byval as LPDIRECT3DDEVICE9, byval as D3DXHANDLE, byval as D3DXMATRIX ptr ptr, byval as UINT) as HRESULT
	SetMatrixTranspose as function(byval as ID3DXConstantTable ptr, byval as LPDIRECT3DDEVICE9, byval as D3DXHANDLE, byval as D3DXMATRIX ptr) as HRESULT
	SetMatrixTransposeArray as function(byval as ID3DXConstantTable ptr, byval as LPDIRECT3DDEVICE9, byval as D3DXHANDLE, byval as D3DXMATRIX ptr, byval as UINT) as HRESULT
	SetMatrixTransposePointerArray as function(byval as ID3DXConstantTable ptr, byval as LPDIRECT3DDEVICE9, byval as D3DXHANDLE, byval as D3DXMATRIX ptr ptr, byval as UINT) as HRESULT
end type

type LPD3DXTEXTURESHADER as ID3DXTextureShader ptr

extern IID_ID3DXTextureShader alias "IID_ID3DXTextureShader" as GUID

type ID3DXTextureShaderVtbl_ as ID3DXTextureShaderVtbl

type ID3DXTextureShader
	lpVtbl as ID3DXTextureShaderVtbl_ ptr
end type

type ID3DXTextureShaderVtbl
	QueryInterface as function(byval as ID3DXTextureShader ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as ID3DXTextureShader ptr) as ULONG
	Release as function(byval as ID3DXTextureShader ptr) as ULONG
	GetFunction as function(byval as ID3DXTextureShader ptr, byval as LPD3DXBUFFER ptr) as HRESULT
	GetConstantBuffer as function(byval as ID3DXTextureShader ptr, byval as LPD3DXBUFFER ptr) as HRESULT
	GetDesc as function(byval as ID3DXTextureShader ptr, byval as D3DXCONSTANTTABLE_DESC ptr) as HRESULT
	GetConstantDesc as function(byval as ID3DXTextureShader ptr, byval as D3DXHANDLE, byval as D3DXCONSTANT_DESC ptr, byval as UINT ptr) as HRESULT
	GetConstant as function(byval as ID3DXTextureShader ptr, byval as D3DXHANDLE, byval as UINT) as D3DXHANDLE
	GetConstantByName as function(byval as ID3DXTextureShader ptr, byval as D3DXHANDLE, byval as LPCSTR) as D3DXHANDLE
	GetConstantElement as function(byval as ID3DXTextureShader ptr, byval as D3DXHANDLE, byval as UINT) as D3DXHANDLE
	SetDefaults as function(byval as ID3DXTextureShader ptr) as HRESULT
	SetValue as function(byval as ID3DXTextureShader ptr, byval as D3DXHANDLE, byval as LPCVOID, byval as UINT) as HRESULT
	SetBool as function(byval as ID3DXTextureShader ptr, byval as D3DXHANDLE, byval as BOOL) as HRESULT
	SetBoolArray as function(byval as ID3DXTextureShader ptr, byval as D3DXHANDLE, byval as BOOL ptr, byval as UINT) as HRESULT
	SetInt as function(byval as ID3DXTextureShader ptr, byval as D3DXHANDLE, byval as INT_) as HRESULT
	SetIntArray as function(byval as ID3DXTextureShader ptr, byval as D3DXHANDLE, byval as INT_ ptr, byval as UINT) as HRESULT
	SetFloat as function(byval as ID3DXTextureShader ptr, byval as D3DXHANDLE, byval as FLOAT) as HRESULT
	SetFloatArray as function(byval as ID3DXTextureShader ptr, byval as D3DXHANDLE, byval as FLOAT ptr, byval as UINT) as HRESULT
	SetVector as function(byval as ID3DXTextureShader ptr, byval as D3DXHANDLE, byval as D3DXVECTOR4 ptr) as HRESULT
	SetVectorArray as function(byval as ID3DXTextureShader ptr, byval as D3DXHANDLE, byval as D3DXVECTOR4 ptr, byval as UINT) as HRESULT
	SetMatrix as function(byval as ID3DXTextureShader ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr) as HRESULT
	SetMatrixArray as function(byval as ID3DXTextureShader ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr, byval as UINT) as HRESULT
	SetMatrixPointerArray as function(byval as ID3DXTextureShader ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr ptr, byval as UINT) as HRESULT
	SetMatrixTranspose as function(byval as ID3DXTextureShader ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr) as HRESULT
	SetMatrixTransposeArray as function(byval as ID3DXTextureShader ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr, byval as UINT) as HRESULT
	SetMatrixTransposePointerArray as function(byval as ID3DXTextureShader ptr, byval as D3DXHANDLE, byval as D3DXMATRIX ptr ptr, byval as UINT) as HRESULT
end type

type LPD3DXFRAGMENTLINKER as ID3DXFragmentLinker ptr

extern IID_ID3DXFragmentLinker alias "IID_ID3DXFragmentLinker" as GUID

type ID3DXFragmentLinkerVtbl_ as ID3DXFragmentLinkerVtbl

type ID3DXFragmentLinker
	lpVtbl as ID3DXFragmentLinkerVtbl_ ptr
end type

type ID3DXFragmentLinkerVtbl
	QueryInterface as function(byval as ID3DXFragmentLinker ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as ID3DXFragmentLinker ptr) as ULONG
	Release as function(byval as ID3DXFragmentLinker ptr) as ULONG
	GetDevice as function(byval as ID3DXFragmentLinker ptr, byval as LPDIRECT3DDEVICE9 ptr) as HRESULT
	GetNumberOfFragments as function(byval as ID3DXFragmentLinker ptr) as UINT
	GetFragmentHandleByIndex as function(byval as ID3DXFragmentLinker ptr, byval as UINT) as D3DXHANDLE
	GetFragmentHandleByName as function(byval as ID3DXFragmentLinker ptr, byval as LPCSTR) as D3DXHANDLE
	GetFragmentDesc as function(byval as ID3DXFragmentLinker ptr, byval as D3DXHANDLE, byval as LPD3DXFRAGMENT_DESC) as HRESULT
	AddFragments as function(byval as ID3DXFragmentLinker ptr, byval as DWORD ptr) as HRESULT
	GetAllFragments as function(byval as ID3DXFragmentLinker ptr, byval as LPD3DXBUFFER ptr) as HRESULT
	GetFragment as function(byval as ID3DXFragmentLinker ptr, byval as D3DXHANDLE, byval as LPD3DXBUFFER ptr) as HRESULT
	LinkShader as function(byval as ID3DXFragmentLinker ptr, byval as LPCSTR, byval as DWORD, byval as D3DXHANDLE ptr, byval as UINT, byval as LPD3DXBUFFER ptr, byval as LPD3DXBUFFER ptr) as HRESULT
	LinkVertexShader as function(byval as ID3DXFragmentLinker ptr, byval as LPCSTR, byval as DWORD, byval as D3DXHANDLE ptr, byval as UINT, byval as LPDIRECT3DVERTEXSHADER9 ptr, byval as LPD3DXBUFFER ptr) as HRESULT
	LinkPixelShader as function(byval as ID3DXFragmentLinker ptr, byval as LPCSTR, byval as DWORD, byval as D3DXHANDLE ptr, byval as UINT, byval as LPDIRECT3DPIXELSHADER9 ptr, byval as LPD3DXBUFFER ptr) as HRESULT
	ClearCache as function(byval as ID3DXFragmentLinker ptr) as HRESULT
end type

enum D3DXINCLUDE_TYPE
	D3DXINC_LOCAL
	D3DXINC_SYSTEM
	D3DXINC_FORCE_DWORD = &h7fffffff
end enum

type LPD3DXINCLUDE_TYPE as D3DXINCLUDE_TYPE
type LPD3DXINCLUDE as ID3DXInclude ptr

type ID3DXIncludeVtbl_ as ID3DXIncludeVtbl

type ID3DXInclude
	lpVtbl as ID3DXIncludeVtbl_ ptr
end type

type ID3DXIncludeVtbl
	Open as function(byval as ID3DXInclude ptr, byval as D3DXINCLUDE_TYPE, byval as LPCSTR, byval as LPCVOID, byval as LPCVOID ptr, byval as UINT ptr) as HRESULT
	Close as function(byval as ID3DXInclude ptr, byval as LPCVOID) as HRESULT
end type

declare function D3DXAssembleShader alias "D3DXAssembleShader" (byval pSrcData as LPCSTR, byval SrcDataLen as UINT, byval pDefines as D3DXMACRO ptr, byval pInclude as LPD3DXINCLUDE, byval Flags as DWORD, byval ppShader as LPD3DXBUFFER ptr, byval ppErrorMsgs as LPD3DXBUFFER ptr) as HRESULT
declare function D3DXCompileShader alias "D3DXCompileShader" (byval pSrcData as LPCSTR, byval SrcDataLen as UINT, byval pDefines as D3DXMACRO ptr, byval pInclude as LPD3DXINCLUDE, byval pFunctionName as LPCSTR, byval pProfile as LPCSTR, byval Flags as DWORD, byval ppShader as LPD3DXBUFFER ptr, byval ppErrorMsgs as LPD3DXBUFFER ptr, byval ppConstantTable as LPD3DXCONSTANTTABLE ptr) as HRESULT
declare function D3DXDisassembleShader alias "D3DXDisassembleShader" (byval pShader as DWORD ptr, byval EnableColorCode as BOOL, byval pComments as LPCSTR, byval ppDisassembly as LPD3DXBUFFER ptr) as HRESULT
declare function D3DXGetPixelShaderProfile alias "D3DXGetPixelShaderProfile" (byval pDevice as LPDIRECT3DDEVICE9) as LPCSTR
declare function D3DXGetVertexShaderProfile alias "D3DXGetVertexShaderProfile" (byval pDevice as LPDIRECT3DDEVICE9) as LPCSTR
declare function D3DXFindShaderComment alias "D3DXFindShaderComment" (byval pFunction as DWORD ptr, byval FourCC as DWORD, byval ppData as LPCVOID ptr, byval pSizeInBytes as UINT ptr) as HRESULT
declare function D3DXGetShaderSize alias "D3DXGetShaderSize" (byval pFunction as DWORD ptr) as UINT
declare function D3DXGetShaderVersion alias "D3DXGetShaderVersion" (byval pFunction as DWORD ptr) as DWORD
declare function D3DXGetShaderInputSemantics alias "D3DXGetShaderInputSemantics" (byval pFunction as DWORD ptr, byval pSemantics as D3DXSEMANTIC ptr, byval pCount as UINT ptr) as HRESULT
declare function D3DXGetShaderOutputSemantics alias "D3DXGetShaderOutputSemantics" (byval pFunction as DWORD ptr, byval pSemantics as D3DXSEMANTIC ptr, byval pCount as UINT ptr) as HRESULT
declare function D3DXGetShaderSamplers alias "D3DXGetShaderSamplers" (byval pFunction as DWORD ptr, byval pSamplers as LPCSTR ptr, byval pCount as UINT ptr) as HRESULT
declare function D3DXGetShaderConstantTable alias "D3DXGetShaderConstantTable" (byval pFunction as DWORD ptr, byval ppConstantTable as LPD3DXCONSTANTTABLE ptr) as HRESULT
declare function D3DXCreateTextureShader alias "D3DXCreateTextureShader" (byval pFunction as DWORD ptr, byval ppTextureShader as LPD3DXTEXTURESHADER ptr) as HRESULT
declare function D3DXGatherFragments alias "D3DXGatherFragments" (byval pSrcData as LPCSTR, byval SrcDataLen as UINT, byval pDefines as D3DXMACRO ptr, byval pInclude as LPD3DXINCLUDE, byval Flags as DWORD, byval ppShader as LPD3DXBUFFER ptr, byval ppErrorMsgs as LPD3DXBUFFER ptr) as HRESULT
declare function D3DXCreateFragmentLinker alias "D3DXCreateFragmentLinker" (byval pDevice as LPDIRECT3DDEVICE9, byval ShaderCacheSize as UINT, byval ppFragmentLinker as LPD3DXFRAGMENTLINKER ptr) as HRESULT

#ifdef UNICODE
declare function D3DXAssembleShaderFromFile alias "D3DXAssembleShaderFromFileW" (byval pSrcFile as LPCWSTR, byval pDefines as D3DXMACRO ptr, byval pInclude as LPD3DXINCLUDE, byval Flags as DWORD, byval ppShader as LPD3DXBUFFER ptr, byval ppErrorMsgs as LPD3DXBUFFER ptr) as HRESULT
declare function D3DXAssembleShaderFromResource alias "D3DXAssembleShaderFromResourceW" (byval hSrcModule as HMODULE, byval pSrcResource as LPCWSTR, byval pDefines as D3DXMACRO ptr, byval pInclude as LPD3DXINCLUDE, byval Flags as DWORD, byval ppShader as LPD3DXBUFFER ptr, byval ppErrorMsgs as LPD3DXBUFFER ptr) as HRESULT
declare function D3DXCompileShaderFromFile alias "D3DXCompileShaderFromFileW" (byval pSrcFile as LPCWSTR, byval pDefines as D3DXMACRO ptr, byval pInclude as LPD3DXINCLUDE, byval pFunctionName as LPCSTR, byval pProfile as LPCSTR, byval Flags as DWORD, byval ppShader as LPD3DXBUFFER ptr, byval ppErrorMsgs as LPD3DXBUFFER ptr, byval ppConstantTable as LPD3DXCONSTANTTABLE ptr) as HRESULT
declare function D3DXCompileShaderFromResource alias "D3DXCompileShaderFromResourceW" (byval hSrcModule as HMODULE, byval pSrcResource as LPCWSTR, byval pDefines as D3DXMACRO ptr, byval pInclude as LPD3DXINCLUDE, byval pFunctionName as LPCSTR, byval pProfile as LPCSTR, byval Flags as DWORD, byval ppShader as LPD3DXBUFFER ptr, byval ppErrorMsgs as LPD3DXBUFFER ptr, byval ppConstantTable as LPD3DXCONSTANTTABLE ptr) as HRESULT
declare function D3DXGatherFragmentsFromFile alias "D3DXGatherFragmentsFromFileW" (byval pSrcFile as LPCWSTR, byval pDefines as D3DXMACRO ptr, byval pInclude as LPD3DXINCLUDE, byval Flags as DWORD, byval ppShader as LPD3DXBUFFER ptr, byval ppErrorMsgs as LPD3DXBUFFER ptr) as HRESULT
declare function D3DXGatherFragmentsFromResource alias "D3DXGatherFragmentsFromResourceW" (byval hSrcModule as HMODULE, byval pSrcResource as LPCWSTR, byval pDefines as D3DXMACRO ptr, byval pInclude as LPD3DXINCLUDE, byval Flags as DWORD, byval ppShader as LPD3DXBUFFER ptr, byval ppErrorMsgs as LPD3DXBUFFER ptr) as HRESULT
#else
declare function D3DXAssembleShaderFromFile alias "D3DXAssembleShaderFromFileA" (byval pSrcFile as LPCSTR, byval pDefines as D3DXMACRO ptr, byval pInclude as LPD3DXINCLUDE, byval Flags as DWORD, byval ppShader as LPD3DXBUFFER ptr, byval ppErrorMsgs as LPD3DXBUFFER ptr) as HRESULT
declare function D3DXAssembleShaderFromResource alias "D3DXAssembleShaderFromResourceA" (byval hSrcModule as HMODULE, byval pSrcResource as LPCSTR, byval pDefines as D3DXMACRO ptr, byval pInclude as LPD3DXINCLUDE, byval Flags as DWORD, byval ppShader as LPD3DXBUFFER ptr, byval ppErrorMsgs as LPD3DXBUFFER ptr) as HRESULT
declare function D3DXCompileShaderFromFile alias "D3DXCompileShaderFromFileA" (byval pSrcFile as LPCSTR, byval pDefines as D3DXMACRO ptr, byval pInclude as LPD3DXINCLUDE, byval pFunctionName as LPCSTR, byval pProfile as LPCSTR, byval Flags as DWORD, byval ppShader as LPD3DXBUFFER ptr, byval ppErrorMsgs as LPD3DXBUFFER ptr, byval ppConstantTable as LPD3DXCONSTANTTABLE ptr) as HRESULT
declare function D3DXCompileShaderFromResource alias "D3DXCompileShaderFromResourceA" (byval hSrcModule as HMODULE, byval pSrcResource as LPCSTR, byval pDefines as D3DXMACRO ptr, byval pInclude as LPD3DXINCLUDE, byval pFunctionName as LPCSTR, byval pProfile as LPCSTR, byval Flags as DWORD, byval ppShader as LPD3DXBUFFER ptr, byval ppErrorMsgs as LPD3DXBUFFER ptr, byval ppConstantTable as LPD3DXCONSTANTTABLE ptr) as HRESULT
declare function D3DXGatherFragmentsFromFile alias "D3DXGatherFragmentsFromFileA" (byval pSrcFile as LPCSTR, byval pDefines as D3DXMACRO ptr, byval pInclude as LPD3DXINCLUDE, byval Flags as DWORD, byval ppShader as LPD3DXBUFFER ptr, byval ppErrorMsgs as LPD3DXBUFFER ptr) as HRESULT
declare function D3DXGatherFragmentsFromResource alias "D3DXGatherFragmentsFromResourceA" (byval hSrcModule as HMODULE, byval pSrcResource as LPCSTR, byval pDefines as D3DXMACRO ptr, byval pInclude as LPD3DXINCLUDE, byval Flags as DWORD, byval ppShader as LPD3DXBUFFER ptr, byval ppErrorMsgs as LPD3DXBUFFER ptr) as HRESULT
#endif

type D3DXSHADER_CONSTANTTABLE
	Size as DWORD
	Creator as DWORD
	Version as DWORD
	Constants as DWORD
	ConstantInfo as DWORD
	Flags as DWORD
	Target as DWORD
end type

type LPD3DXSHADER_CONSTANTTABLE as D3DXSHADER_CONSTANTTABLE ptr

type D3DXSHADER_CONSTANTINFO
	Name as DWORD
	RegisterSet as WORD
	RegisterIndex as WORD
	RegisterCount as WORD
	Reserved as WORD
	TypeInfo as DWORD
	DefaultValue as DWORD
end type

type LPD3DXSHADER_CONSTANTINFO as D3DXSHADER_CONSTANTINFO ptr

type D3DXSHADER_TYPEINFO
	Class as WORD
	Type as WORD
	Rows as WORD
	Columns as WORD
	Elements as WORD
	StructMembers as WORD
	StructMemberInfo as DWORD
end type

type LPD3DXSHADER_TYPEINFO as D3DXSHADER_TYPEINFO ptr

type D3DXSHADER_STRUCTMEMBERINFO
	Name as DWORD
	TypeInfo as DWORD
end type

type LPD3DXSHADER_STRUCTMEMBERINFO as D3DXSHADER_STRUCTMEMBERINFO ptr

#endif
