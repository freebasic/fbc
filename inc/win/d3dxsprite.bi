''
''
'' d3dxsprite -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_d3dxsprite_bi__
#define __win_d3dxsprite_bi__

#include once "win/d3d.bi"
#include once "win/d3dxerr.bi"

declare function D3DXPrepareDeviceForSprite alias "D3DXPrepareDeviceForSprite" (byval pd3dDevice as LPDIRECT3DDEVICE7, byval ZEnable as BOOL) as HRESULT
declare function D3DXDrawSpriteSimple alias "D3DXDrawSpriteSimple" (byval pd3dTexture as LPDIRECTDRAWSURFACE7, byval pd3dDevice as LPDIRECT3DDEVICE7, byval ppointDest as D3DXVECTOR3 ptr, byval alpha as single, byval scale as single, byval angleRad as single, byval pOffset as D3DXVECTOR2 ptr, byval pSourceRect as RECT ptr) as HRESULT
declare function D3DXDrawSpriteTransform alias "D3DXDrawSpriteTransform" (byval pd3dTexture as LPDIRECTDRAWSURFACE7, byval pd3dDevice as LPDIRECT3DDEVICE7, byval pMatrixTransform as D3DXMATRIX ptr, byval alpha as single, byval pSourceRect as RECT ptr) as HRESULT
declare sub D3DXBuildSpriteTransform alias "D3DXBuildSpriteTransform" (byval pMatrix as D3DXMATRIX ptr, byval prectDest as RECT ptr, byval angleRad as single, byval pOffset as D3DXVECTOR2 ptr)
declare function D3DXDrawSprite3D alias "D3DXDrawSprite3D" (byval pd3dTexture as LPDIRECTDRAWSURFACE7, byval pd3dDevice as LPDIRECT3DDEVICE7, byval quad as D3DXVECTOR4 ptr, byval alpha as single, byval pSourceRect as RECT ptr) as HRESULT

#endif
