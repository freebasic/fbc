'' FreeBASIC binding for mingw-w64-v3.3.0

#pragma once

#include once "_mingw_unicode.bi"
#include once "d3dx9.bi"

extern "Windows"

#define __D3DX9SHAPE_H__
declare function D3DXCreateBox(byval device as IDirect3DDevice9 ptr, byval width as single, byval height as single, byval depth as single, byval mesh as ID3DXMesh ptr ptr, byval adjacency as ID3DXBuffer ptr ptr) as HRESULT
declare function D3DXCreateCylinder(byval device as IDirect3DDevice9 ptr, byval radius1 as single, byval radius2 as single, byval length as single, byval slices as UINT, byval stacks as UINT, byval mesh as ID3DXMesh ptr ptr, byval adjacency as ID3DXBuffer ptr ptr) as HRESULT
declare function D3DXCreateSphere(byval device as IDirect3DDevice9 ptr, byval radius as single, byval slices as UINT, byval stacks as UINT, byval mesh as ID3DXMesh ptr ptr, byval adjacency as ID3DXBuffer ptr ptr) as HRESULT
declare function D3DXCreateTeapot(byval device as IDirect3DDevice9 ptr, byval mesh as ID3DXMesh ptr ptr, byval adjacency as ID3DXBuffer ptr ptr) as HRESULT
declare function D3DXCreateTextA(byval device as IDirect3DDevice9 ptr, byval hdc as HDC, byval text as const zstring ptr, byval deviation as single, byval extrusion as single, byval mesh as ID3DXMesh ptr ptr, byval adjacency as ID3DXBuffer ptr ptr, byval glyphmetrics as GLYPHMETRICSFLOAT ptr) as HRESULT
declare function D3DXCreateTextW(byval device as IDirect3DDevice9 ptr, byval hdc as HDC, byval text as const wstring ptr, byval deviation as single, byval extrusion as FLOAT, byval mesh as ID3DXMesh ptr ptr, byval adjacency as ID3DXBuffer ptr ptr, byval glyphmetrics as GLYPHMETRICSFLOAT ptr) as HRESULT

#ifdef UNICODE
	#define D3DXCreateText D3DXCreateTextW
#else
	#define D3DXCreateText D3DXCreateTextA
#endif

end extern
