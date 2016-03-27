'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   Copyright (C) 2007 David Adam
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

#inclib "dxguid"

#include once "crt/limits.bi"
#include once "d3d9.bi"
#include once "d3dx9math.bi"
#include once "d3dx9core.bi"
#include once "d3dx9xof.bi"
#include once "d3dx9mesh.bi"
#include once "d3dx9shader.bi"
#include once "d3dx9effect.bi"
#include once "d3dx9shape.bi"
#include once "d3dx9anim.bi"
#include once "d3dx9tex.bi"

#define __D3DX9_H__
const D3DX_DEFAULT = cast(UINT, -1)
const D3DX_DEFAULT_NONPOW2 = cast(UINT, -2)
#define D3DX_DEFAULT_FLOAT FLT_MAX
const D3DX_FROM_FILE = cast(UINT, -3)
const D3DFMT_FROM_FILE = cast(D3DFORMAT, -3)
const _FACDD = &h876
#define MAKE_DDHRESULT(code) MAKE_HRESULT(1, _FACDD, code)

type _D3DXERR as long
enum
	D3DXERR_CANNOTMODIFYINDEXBUFFER = cast(HRESULT, culng(culng(culng(culng(1) shl 31) or culng(culng(&h876) shl 16)) or culng(2900)))
	D3DXERR_INVALIDMESH = cast(HRESULT, culng(culng(culng(culng(1) shl 31) or culng(culng(&h876) shl 16)) or culng(2901)))
	D3DXERR_CANNOTATTRSORT = cast(HRESULT, culng(culng(culng(culng(1) shl 31) or culng(culng(&h876) shl 16)) or culng(2902)))
	D3DXERR_SKINNINGNOTSUPPORTED = cast(HRESULT, culng(culng(culng(culng(1) shl 31) or culng(culng(&h876) shl 16)) or culng(2903)))
	D3DXERR_TOOMANYINFLUENCES = cast(HRESULT, culng(culng(culng(culng(1) shl 31) or culng(culng(&h876) shl 16)) or culng(2904)))
	D3DXERR_INVALIDDATA = cast(HRESULT, culng(culng(culng(culng(1) shl 31) or culng(culng(&h876) shl 16)) or culng(2905)))
	D3DXERR_LOADEDMESHASNODATA = cast(HRESULT, culng(culng(culng(culng(1) shl 31) or culng(culng(&h876) shl 16)) or culng(2906)))
	D3DXERR_DUPLICATENAMEDFRAGMENT = cast(HRESULT, culng(culng(culng(culng(1) shl 31) or culng(culng(&h876) shl 16)) or culng(2907)))
	D3DXERR_CANNOTREMOVELASTITEM = cast(HRESULT, culng(culng(culng(culng(1) shl 31) or culng(culng(&h876) shl 16)) or culng(2908)))
end enum
