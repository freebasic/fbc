''
''
'' d3dx9 -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_d3dx9_bi__
#define __win_d3dx9_bi__

#inclib "dxguid"
#inclib "d3dx9d"

#define D3DX_DEFAULT cuint(-1)
#define D3DX_DEFAULT_NONPOW2 cuint(-2)
#define D3DX_DEFAULT_FLOAT FLT_MAX
#define D3DX_FROM_FILE cuint(-3)
#define D3DFMT_FROM_FILE cast(D3DFORMAT,-3)

#include once "win/d3d9.bi"
#include once "win/d3dx9math.bi"
#include once "win/d3dx9core.bi"
#include once "win/d3dx9xof.bi"
#include once "win/d3dx9mesh.bi"
#include once "win/d3dx9shader.bi"
#include once "win/d3dx9effect.bi"
#include once "win/d3dx9tex.bi"
#include once "win/d3dx9shape.bi"
#include once "win/d3dx9anim.bi"

#define _FACDD &h876
#define MAKE_DDHRESULT( code ) MAKE_HRESULT( 1, _FACDD, code )

enum _D3DXERR
    D3DXERR_CANNOTMODIFYINDEXBUFFER = MAKE_DDHRESULT(2900)
    D3DXERR_INVALIDMESH = MAKE_DDHRESULT(2901)
    D3DXERR_CANNOTATTRSORT = MAKE_DDHRESULT(2902)
    D3DXERR_SKINNINGNOTSUPPORTED = MAKE_DDHRESULT(2903)
    D3DXERR_TOOMANYINFLUENCES = MAKE_DDHRESULT(2904)
    D3DXERR_INVALIDDATA = MAKE_DDHRESULT(2905)
    D3DXERR_LOADEDMESHASNODATA = MAKE_DDHRESULT(2906)
    D3DXERR_DUPLICATENAMEDFRAGMENT = MAKE_DDHRESULT(2907)
    D3DXERR_CANNOTREMOVELASTITEM = MAKE_DDHRESULT(2908)
end enum

#endif
