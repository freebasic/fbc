#pragma once

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

#inclib "dxguid"
#inclib "d3dx9d"

#define __D3DX9_H__
#define D3DX_DEFAULT cast(UINT, -1)
#define D3DX_DEFAULT_NONPOW2 cast(UINT, -2)
#define D3DX_DEFAULT_FLOAT FLT_MAX
#define D3DX_FROM_FILE cast(UINT, -3)
#define D3DFMT_FROM_FILE cast(D3DFORMAT, -3)
#define _FACDD &h876
#define MAKE_DDHRESULT(code) MAKE_HRESULT(1, _FACDD, code)

type _D3DXERR as long
enum
	D3DXERR_CANNOTMODIFYINDEXBUFFER = cast(HRESULT, ((culng(1) shl 31) or (culng(&h876) shl 16)) or culng(2900))
	D3DXERR_INVALIDMESH = cast(HRESULT, ((culng(1) shl 31) or (culng(&h876) shl 16)) or culng(2901))
	D3DXERR_CANNOTATTRSORT = cast(HRESULT, ((culng(1) shl 31) or (culng(&h876) shl 16)) or culng(2902))
	D3DXERR_SKINNINGNOTSUPPORTED = cast(HRESULT, ((culng(1) shl 31) or (culng(&h876) shl 16)) or culng(2903))
	D3DXERR_TOOMANYINFLUENCES = cast(HRESULT, ((culng(1) shl 31) or (culng(&h876) shl 16)) or culng(2904))
	D3DXERR_INVALIDDATA = cast(HRESULT, ((culng(1) shl 31) or (culng(&h876) shl 16)) or culng(2905))
	D3DXERR_LOADEDMESHASNODATA = cast(HRESULT, ((culng(1) shl 31) or (culng(&h876) shl 16)) or culng(2906))
	D3DXERR_DUPLICATENAMEDFRAGMENT = cast(HRESULT, ((culng(1) shl 31) or (culng(&h876) shl 16)) or culng(2907))
	D3DXERR_CANNOTREMOVELASTITEM = cast(HRESULT, ((culng(1) shl 31) or (culng(&h876) shl 16)) or culng(2908))
end enum
