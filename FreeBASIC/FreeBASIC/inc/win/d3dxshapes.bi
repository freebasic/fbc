''
''
'' d3dxshapes -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_d3dxshapes_bi__
#define __win_d3dxshapes_bi__

#include once "win/d3d.bi"
#include once "win/d3dxerr.bi"

type LPD3DXSIMPLESHAPE as ID3DXSimpleShape ptr
extern IID_ID3DXSimpleShape alias "IID_ID3DXSimpleShape" as GUID

type ID3DXSimpleShapeVtbl_ as ID3DXSimpleShapeVtbl

type ID3DXSimpleShape
	lpVtbl as ID3DXSimpleShapeVtbl_ ptr
end type

type ID3DXSimpleShapeVtbl
	QueryInterface as function(byval as IDirect3DVertexBuffer7 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DVertexBuffer7 ptr) as ULONG
	Release as function(byval as IDirect3DVertexBuffer7 ptr) as ULONG
	GetVB as function(byval as IDirect3DVertexBuffer7 ptr) as LPDIRECT3DVERTEXBUFFER7
	GetIndices as function(byval as IDirect3DVertexBuffer7 ptr, byval as LPWORD ptr) as DWORD
	Draw as function(byval as IDirect3DVertexBuffer7 ptr) as HRESULT
end type

declare function D3DXCreatePolygon alias "D3DXCreatePolygon" (byval pDevice as LPDIRECT3DDEVICE7, byval sideSize as single, byval numSides as DWORD, byval numTexCoords as DWORD, byval ppShape as LPD3DXSIMPLESHAPE ptr) as HRESULT
declare function D3DXCreateBox alias "D3DXCreateBox" (byval pDevice as LPDIRECT3DDEVICE7, byval width as single, byval height as single, byval depth as single, byval numTexCoords as DWORD, byval ppShape as LPD3DXSIMPLESHAPE ptr) as HRESULT
declare function D3DXCreateCylinder alias "D3DXCreateCylinder" (byval pDevice as LPDIRECT3DDEVICE7, byval baseRadius as single, byval topRadius as single, byval height as single, byval numSlices as DWORD, byval numStacks as DWORD, byval numTexCoords as DWORD, byval ppShape as LPD3DXSIMPLESHAPE ptr) as HRESULT
declare function D3DXCreateTorus alias "D3DXCreateTorus" (byval pDevice as LPDIRECT3DDEVICE7, byval innerRadius as single, byval outerRadius as single, byval numSides as DWORD, byval numRings as DWORD, byval numTexCoords as DWORD, byval ppShape as LPD3DXSIMPLESHAPE ptr) as HRESULT
declare function D3DXCreateTeapot alias "D3DXCreateTeapot" (byval pDevice as LPDIRECT3DDEVICE7, byval numTexCoords as DWORD, byval ppShape as LPD3DXSIMPLESHAPE ptr) as HRESULT
declare function D3DXCreateSphere alias "D3DXCreateSphere" (byval pDevice as LPDIRECT3DDEVICE7, byval radius as single, byval numSlices as DWORD, byval numStacks as DWORD, byval numTexCoords as DWORD, byval ppShape as LPD3DXSIMPLESHAPE ptr) as HRESULT

#endif
