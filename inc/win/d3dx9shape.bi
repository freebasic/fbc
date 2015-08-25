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

#define __D3DX9SHAPE_H__
declare function D3DXCreateBox(byval device as IDirect3DDevice9 ptr, byval width as single, byval height as single, byval depth as single, byval mesh as ID3DXMesh ptr ptr, byval adjacency as ID3DXBuffer ptr ptr) as HRESULT
declare function D3DXCreateCylinder(byval device as IDirect3DDevice9 ptr, byval radius1 as single, byval radius2 as single, byval length as single, byval slices as UINT, byval stacks as UINT, byval mesh as ID3DXMesh ptr ptr, byval adjacency as ID3DXBuffer ptr ptr) as HRESULT
declare function D3DXCreatePolygon(byval device as IDirect3DDevice9 ptr, byval length as single, byval sides as UINT, byval mesh as ID3DXMesh ptr ptr, byval adjacency as ID3DXBuffer ptr ptr) as HRESULT
declare function D3DXCreateSphere(byval device as IDirect3DDevice9 ptr, byval radius as single, byval slices as UINT, byval stacks as UINT, byval mesh as ID3DXMesh ptr ptr, byval adjacency as ID3DXBuffer ptr ptr) as HRESULT
declare function D3DXCreateTeapot(byval device as IDirect3DDevice9 ptr, byval mesh as ID3DXMesh ptr ptr, byval adjacency as ID3DXBuffer ptr ptr) as HRESULT
declare function D3DXCreateTextA(byval device as IDirect3DDevice9 ptr, byval hdc as HDC, byval text as const zstring ptr, byval deviation as single, byval extrusion as single, byval mesh as ID3DXMesh ptr ptr, byval adjacency as ID3DXBuffer ptr ptr, byval glyphmetrics as GLYPHMETRICSFLOAT ptr) as HRESULT
declare function D3DXCreateTextW(byval device as IDirect3DDevice9 ptr, byval hdc as HDC, byval text as const wstring ptr, byval deviation as single, byval extrusion as FLOAT, byval mesh as ID3DXMesh ptr ptr, byval adjacency as ID3DXBuffer ptr ptr, byval glyphmetrics as GLYPHMETRICSFLOAT ptr) as HRESULT
declare function D3DXCreateTorus(byval device as IDirect3DDevice9 ptr, byval innerradius as single, byval outerradius as single, byval sides as UINT, byval rings as UINT, byval mesh as ID3DXMesh ptr ptr, byval adjacency as ID3DXBuffer ptr ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXCreateText alias "D3DXCreateTextW"(byval device as IDirect3DDevice9 ptr, byval hdc as HDC, byval text as const wstring ptr, byval deviation as single, byval extrusion as FLOAT, byval mesh as ID3DXMesh ptr ptr, byval adjacency as ID3DXBuffer ptr ptr, byval glyphmetrics as GLYPHMETRICSFLOAT ptr) as HRESULT
#else
	declare function D3DXCreateText alias "D3DXCreateTextA"(byval device as IDirect3DDevice9 ptr, byval hdc as HDC, byval text as const zstring ptr, byval deviation as single, byval extrusion as single, byval mesh as ID3DXMesh ptr ptr, byval adjacency as ID3DXBuffer ptr ptr, byval glyphmetrics as GLYPHMETRICSFLOAT ptr) as HRESULT
#endif

end extern
