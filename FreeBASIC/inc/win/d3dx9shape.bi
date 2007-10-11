''
''
'' d3dx9shape -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_d3dx9shape_bi__
#define __win_d3dx9shape_bi__

#include once "win/d3dx9.bi"

declare function D3DXCreatePolygon alias "D3DXCreatePolygon" (byval pDevice as LPDIRECT3DDEVICE9, byval Length as FLOAT, byval Sides as UINT, byval ppMesh as LPD3DXMESH ptr, byval ppAdjacency as LPD3DXBUFFER ptr) as HRESULT
declare function D3DXCreateBox alias "D3DXCreateBox" (byval pDevice as LPDIRECT3DDEVICE9, byval Width as FLOAT, byval Height as FLOAT, byval Depth as FLOAT, byval ppMesh as LPD3DXMESH ptr, byval ppAdjacency as LPD3DXBUFFER ptr) as HRESULT
declare function D3DXCreateCylinder alias "D3DXCreateCylinder" (byval pDevice as LPDIRECT3DDEVICE9, byval Radius1 as FLOAT, byval Radius2 as FLOAT, byval Length as FLOAT, byval Slices as UINT, byval Stacks as UINT, byval ppMesh as LPD3DXMESH ptr, byval ppAdjacency as LPD3DXBUFFER ptr) as HRESULT
declare function D3DXCreateSphere alias "D3DXCreateSphere" (byval pDevice as LPDIRECT3DDEVICE9, byval Radius as FLOAT, byval Slices as UINT, byval Stacks as UINT, byval ppMesh as LPD3DXMESH ptr, byval ppAdjacency as LPD3DXBUFFER ptr) as HRESULT
declare function D3DXCreateTorus alias "D3DXCreateTorus" (byval pDevice as LPDIRECT3DDEVICE9, byval InnerRadius as FLOAT, byval OuterRadius as FLOAT, byval Sides as UINT, byval Rings as UINT, byval ppMesh as LPD3DXMESH ptr, byval ppAdjacency as LPD3DXBUFFER ptr) as HRESULT
declare function D3DXCreateTeapot alias "D3DXCreateTeapot" (byval pDevice as LPDIRECT3DDEVICE9, byval ppMesh as LPD3DXMESH ptr, byval ppAdjacency as LPD3DXBUFFER ptr) as HRESULT

#ifdef UNICODE
declare function D3DXCreateText alias "D3DXCreateTextW" (byval pDevice as LPDIRECT3DDEVICE9, byval hDC as HDC, byval pText as LPCWSTR, byval Deviation as FLOAT, byval Extrusion as FLOAT, byval ppMesh as LPD3DXMESH ptr, byval ppAdjacency as LPD3DXBUFFER ptr, byval pGlyphMetrics as LPGLYPHMETRICSFLOAT) as HRESULT
#else
declare function D3DXCreateText alias "D3DXCreateTextA" (byval pDevice as LPDIRECT3DDEVICE9, byval hDC as HDC, byval pText as LPCSTR, byval Deviation as FLOAT, byval Extrusion as FLOAT, byval ppMesh as LPD3DXMESH ptr, byval ppAdjacency as LPD3DXBUFFER ptr, byval pGlyphMetrics as LPGLYPHMETRICSFLOAT) as HRESULT
#endif

#endif
