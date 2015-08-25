'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   Copyright (C) 2007, 2008 Tony Wasserka
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

#define __WINE_D3DX9CORE_H
const D3DX_VERSION = &h0902
const D3DX_SDK_VERSION = 36
const D3DXSPRITE_DONOTSAVESTATE = &h00000001
const D3DXSPRITE_DONOTMODIFY_RENDERSTATE = &h00000002
const D3DXSPRITE_OBJECTSPACE = &h00000004
const D3DXSPRITE_BILLBOARD = &h00000008
const D3DXSPRITE_ALPHABLEND = &h00000010
const D3DXSPRITE_SORT_TEXTURE = &h00000020
const D3DXSPRITE_SORT_DEPTH_FRONTTOBACK = &h00000040
const D3DXSPRITE_SORT_DEPTH_BACKTOFRONT = &h00000080
const D3DXSPRITE_DO_NOT_ADDREF_TEXTURE = &h00000100

extern IID_ID3DXBuffer as const GUID
extern IID_ID3DXFont as const GUID
extern IID_ID3DXLine as const GUID
extern IID_ID3DXRenderToEnvMap as const GUID
extern IID_ID3DXRenderToSurface as const GUID
extern IID_ID3DXSprite as const GUID

type LPD3DXBUFFER as ID3DXBuffer ptr
type LPD3DXFONT as ID3DXFont ptr
type LPD3DXLINE as ID3DXLine ptr
type LPD3DXRenderToEnvMap as ID3DXRenderToEnvMap ptr
type LPD3DXRENDERTOSURFACE as ID3DXRenderToSurface ptr
type ID3DXSprite as ID3DXSprite_
type LPD3DXSPRITE as ID3DXSprite ptr
type ID3DXBufferVtbl as ID3DXBufferVtbl_

type ID3DXBuffer
	lpVtbl as ID3DXBufferVtbl ptr
end type

type ID3DXBufferVtbl_
	QueryInterface as function(byval This as ID3DXBuffer ptr, byval riid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddRef as function(byval This as ID3DXBuffer ptr) as ULONG
	Release as function(byval This as ID3DXBuffer ptr) as ULONG
	GetBufferPointer as function(byval This as ID3DXBuffer ptr) as any ptr
	GetBufferSize as function(byval This as ID3DXBuffer ptr) as DWORD
end type

#define ID3DXBuffer_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define ID3DXBuffer_AddRef(p) (p)->lpVtbl->AddRef(p)
#define ID3DXBuffer_Release(p) (p)->lpVtbl->Release(p)
#define ID3DXBuffer_GetBufferPointer(p) (p)->lpVtbl->GetBufferPointer(p)
#define ID3DXBuffer_GetBufferSize(p) (p)->lpVtbl->GetBufferSize(p)

type _D3DXFONT_DESCA
	Height as INT_
	Width as UINT
	Weight as UINT
	MipLevels as UINT
	Italic as WINBOOL
	CharSet as UBYTE
	OutputPrecision as UBYTE
	Quality as UBYTE
	PitchAndFamily as UBYTE
	FaceName as zstring * 32
end type

type D3DXFONT_DESCA as _D3DXFONT_DESCA
type LPD3DXFONT_DESCA as _D3DXFONT_DESCA ptr

type _D3DXFONT_DESCW
	Height as INT_
	Width as UINT
	Weight as UINT
	MipLevels as UINT
	Italic as WINBOOL
	CharSet as UBYTE
	OutputPrecision as UBYTE
	Quality as UBYTE
	PitchAndFamily as UBYTE
	FaceName as wstring * 32
end type

type D3DXFONT_DESCW as _D3DXFONT_DESCW
type LPD3DXFONT_DESCW as _D3DXFONT_DESCW ptr

#ifdef UNICODE
	type D3DXFONT_DESC as D3DXFONT_DESCW
	type LPD3DXFONT_DESC as LPD3DXFONT_DESCW
#else
	type D3DXFONT_DESC as D3DXFONT_DESCA
	type LPD3DXFONT_DESC as LPD3DXFONT_DESCA
#endif

type ID3DXFontVtbl as ID3DXFontVtbl_

type ID3DXFont
	lpVtbl as ID3DXFontVtbl ptr
end type

type ID3DXFontVtbl_
	QueryInterface as function(byval This as ID3DXFont ptr, byval riid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddRef as function(byval This as ID3DXFont ptr) as ULONG
	Release as function(byval This as ID3DXFont ptr) as ULONG
	GetDevice as function(byval This as ID3DXFont ptr, byval device as IDirect3DDevice9 ptr ptr) as HRESULT
	GetDescA as function(byval This as ID3DXFont ptr, byval desc as D3DXFONT_DESCA ptr) as HRESULT
	GetDescW as function(byval This as ID3DXFont ptr, byval desc as D3DXFONT_DESCW ptr) as HRESULT
	GetTextMetricsA as function(byval This as ID3DXFont ptr, byval metrics as TEXTMETRICA ptr) as WINBOOL
	GetTextMetricsW as function(byval This as ID3DXFont ptr, byval metrics as TEXTMETRICW ptr) as WINBOOL
	GetDC as function(byval This as ID3DXFont ptr) as HDC
	GetGlyphData as function(byval This as ID3DXFont ptr, byval glyph as UINT, byval texture as IDirect3DTexture9 ptr ptr, byval blackbox as RECT ptr, byval cellinc as POINT ptr) as HRESULT
	PreloadCharacters as function(byval This as ID3DXFont ptr, byval first as UINT, byval last as UINT) as HRESULT
	PreloadGlyphs as function(byval This as ID3DXFont ptr, byval first as UINT, byval last as UINT) as HRESULT
	PreloadTextA as function(byval This as ID3DXFont ptr, byval string as const zstring ptr, byval count as INT_) as HRESULT
	PreloadTextW as function(byval This as ID3DXFont ptr, byval string as const wstring ptr, byval count as INT_) as HRESULT
	DrawTextA as function(byval This as ID3DXFont ptr, byval sprite as ID3DXSprite ptr, byval string as const zstring ptr, byval count as INT_, byval rect as RECT ptr, byval format as DWORD, byval color as D3DCOLOR) as INT_
	DrawTextW as function(byval This as ID3DXFont ptr, byval sprite as ID3DXSprite ptr, byval string as const wstring ptr, byval count as INT_, byval rect as RECT ptr, byval format as DWORD, byval color as D3DCOLOR) as INT_
	OnLostDevice as function(byval This as ID3DXFont ptr) as HRESULT
	OnResetDevice as function(byval This as ID3DXFont ptr) as HRESULT
end type

#define ID3DXFont_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define ID3DXFont_AddRef(p) (p)->lpVtbl->AddRef(p)
#define ID3DXFont_Release(p) (p)->lpVtbl->Release(p)
#define ID3DXFont_GetDevice(p, a) (p)->lpVtbl->GetDevice(p, a)
#define ID3DXFont_GetDescA(p, a) (p)->lpVtbl->GetDescA(p, a)
#define ID3DXFont_GetDescW(p, a) (p)->lpVtbl->GetDescW(p, a)
#define ID3DXFont_GetTextMetricsA(p, a) (p)->lpVtbl->GetTextMetricsA(p, a)
#define ID3DXFont_GetTextMetricsW(p, a) (p)->lpVtbl->GetTextMetricsW(p, a)
#define ID3DXFont_GetDC(p) (p)->lpVtbl->GetDC(p)
#define ID3DXFont_GetGlyphData(p, a, b, c, d) (p)->lpVtbl->GetGlyphData(p, a, b, c, d)
#define ID3DXFont_PreloadCharacters(p, a, b) (p)->lpVtbl->PreloadCharacters(p, a, b)
#define ID3DXFont_PreloadGlyphs(p, a, b) (p)->lpVtbl->PreloadGlyphs(p, a, b)
#define ID3DXFont_PreloadTextA(p, a, b) (p)->lpVtbl->PreloadTextA(p, a, b)
#define ID3DXFont_PreloadTextW(p, a, b) (p)->lpVtbl->PreloadTextW(p, a, b)
#define ID3DXFont_DrawTextA(p, a, b, c, d, e, f) (p)->lpVtbl->DrawTextA(p, a, b, c, d, e, f)
#define ID3DXFont_DrawTextW(p, a, b, c, d, e, f) (p)->lpVtbl->DrawTextW(p, a, b, c, d, e, f)
#define ID3DXFont_OnLostDevice(p) (p)->lpVtbl->OnLostDevice(p)
#define ID3DXFont_OnResetDevice(p) (p)->lpVtbl->OnResetDevice(p)

#ifdef UNICODE
	#define ID3DXFont_DrawText ID3DXFont_DrawTextW
	#define ID3DXFont_GetDesc ID3DXFont_GetDescW
	#define ID3DXFont_GetTextMetrics ID3DXFont_GetTextMetricsW
	#define ID3DXFont_PreloadText ID3DXFont_PreloadTextW
#else
	#define ID3DXFont_DrawText ID3DXFont_DrawTextA
	#define ID3DXFont_GetDesc ID3DXFont_GetDescA
	#define ID3DXFont_GetTextMetrics ID3DXFont_GetTextMetricsA
	#define ID3DXFont_PreloadText ID3DXFont_PreloadTextA
#endif

type ID3DXLineVtbl as ID3DXLineVtbl_

type ID3DXLine
	lpVtbl as ID3DXLineVtbl ptr
end type

type ID3DXLineVtbl_
	QueryInterface as function(byval This as ID3DXLine ptr, byval riid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddRef as function(byval This as ID3DXLine ptr) as ULONG
	Release as function(byval This as ID3DXLine ptr) as ULONG
	GetDevice as function(byval This as ID3DXLine ptr, byval device as IDirect3DDevice9 ptr ptr) as HRESULT
	Begin as function(byval This as ID3DXLine ptr) as HRESULT
	Draw as function(byval This as ID3DXLine ptr, byval vertexlist as const D3DXVECTOR2 ptr, byval vertexlistcount as DWORD, byval color as D3DCOLOR) as HRESULT
	DrawTransform as function(byval This as ID3DXLine ptr, byval vertexlist as const D3DXVECTOR3 ptr, byval vertexlistcount as DWORD, byval transform as const D3DXMATRIX ptr, byval color as D3DCOLOR) as HRESULT
	SetPattern as function(byval This as ID3DXLine ptr, byval pattern as DWORD) as HRESULT
	GetPattern as function(byval This as ID3DXLine ptr) as DWORD
	SetPatternScale as function(byval This as ID3DXLine ptr, byval scale as FLOAT) as HRESULT
	GetPatternScale as function(byval This as ID3DXLine ptr) as FLOAT
	SetWidth as function(byval This as ID3DXLine ptr, byval width as FLOAT) as HRESULT
	GetWidth as function(byval This as ID3DXLine ptr) as FLOAT
	SetAntialias as function(byval This as ID3DXLine ptr, byval antialias as WINBOOL) as HRESULT
	GetAntialias as function(byval This as ID3DXLine ptr) as WINBOOL
	SetGLLines as function(byval This as ID3DXLine ptr, byval gl_lines as WINBOOL) as HRESULT
	GetGLLines as function(byval This as ID3DXLine ptr) as WINBOOL
	as function(byval This as ID3DXLine ptr) as HRESULT End
	OnLostDevice as function(byval This as ID3DXLine ptr) as HRESULT
	OnResetDevice as function(byval This as ID3DXLine ptr) as HRESULT
end type

#define ID3DXLine_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define ID3DXLine_AddRef(p) (p)->lpVtbl->AddRef(p)
#define ID3DXLine_Release(p) (p)->lpVtbl->Release(p)
#define ID3DXLine_GetDevice(p, a) (p)->lpVtbl->GetDevice(p, a)
#define ID3DXLine_Begin(p) (p)->lpVtbl->Begin(p)
#define ID3DXLine_Draw(p, a, b, c) (p)->lpVtbl->Draw(p, a, b, c)
#define ID3DXLine_DrawTransform(p, a, b, c, d) (p)->lpVtbl->DrawTransform(p, a, b, c, d)
#define ID3DXLine_SetPattern(p, a) (p)->lpVtbl->SetPattern(p, a)
#define ID3DXLine_GetPattern(p) (p)->lpVtbl->GetPattern(p)
#define ID3DXLine_SetPatternScale(p, a) (p)->lpVtbl->SetPatternScale(p, a)
#define ID3DXLine_GetPatternScale(p) (p)->lpVtbl->GetPatternScale(p)
#define ID3DXLine_SetWidth(p, a) (p)->lpVtbl->SetWidth(p, a)
#define ID3DXLine_GetWidth(p) (p)->lpVtbl->GetWidth(p)
#define ID3DXLine_SetAntialias(p, a) (p)->lpVtbl->SetAntialias(p, a)
#define ID3DXLine_GetAntialias(p) (p)->lpVtbl->GetAntialias(p)
#define ID3DXLine_SetGLLines(p, a) (p)->lpVtbl->SetGLLines(p, a)
#define ID3DXLine_GetGLLines(p) (p)->lpVtbl->GetGLLines(p)
#define ID3DXLine_End(p) (p)->lpVtbl->End(p)
#define ID3DXLine_OnLostDevice(p) (p)->lpVtbl->OnLostDevice(p)
#define ID3DXLine_OnResetDevice(p) (p)->lpVtbl->OnResetDevice(p)

type _D3DXRTE_DESC
	Size as UINT
	MipLevels as UINT
	Format as D3DFORMAT
	DepthStencil as WINBOOL
	DepthStencilFormat as D3DFORMAT
end type

type D3DXRTE_DESC as _D3DXRTE_DESC
type ID3DXRenderToEnvMapVtbl as ID3DXRenderToEnvMapVtbl_

type ID3DXRenderToEnvMap
	lpVtbl as ID3DXRenderToEnvMapVtbl ptr
end type

type ID3DXRenderToEnvMapVtbl_
	QueryInterface as function(byval This as ID3DXRenderToEnvMap ptr, byval riid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddRef as function(byval This as ID3DXRenderToEnvMap ptr) as ULONG
	Release as function(byval This as ID3DXRenderToEnvMap ptr) as ULONG
	GetDevice as function(byval This as ID3DXRenderToEnvMap ptr, byval device as IDirect3DDevice9 ptr ptr) as HRESULT
	GetDesc as function(byval This as ID3DXRenderToEnvMap ptr, byval desc as D3DXRTE_DESC ptr) as HRESULT
	BeginCube as function(byval This as ID3DXRenderToEnvMap ptr, byval cubetex as IDirect3DCubeTexture9 ptr) as HRESULT
	BeginSphere as function(byval This as ID3DXRenderToEnvMap ptr, byval tex as IDirect3DTexture9 ptr) as HRESULT
	BeginHemisphere as function(byval This as ID3DXRenderToEnvMap ptr, byval texzpos as IDirect3DTexture9 ptr, byval texzneg as IDirect3DTexture9 ptr) as HRESULT
	BeginParabolic as function(byval This as ID3DXRenderToEnvMap ptr, byval texzpos as IDirect3DTexture9 ptr, byval texzneg as IDirect3DTexture9 ptr) as HRESULT
	Face as function(byval This as ID3DXRenderToEnvMap ptr, byval face as D3DCUBEMAP_FACES, byval mipfilter as DWORD) as HRESULT
	as function(byval This as ID3DXRenderToEnvMap ptr, byval mipfilter as DWORD) as HRESULT End
	OnLostDevice as function(byval This as ID3DXRenderToEnvMap ptr) as HRESULT
	OnResetDevice as function(byval This as ID3DXRenderToEnvMap ptr) as HRESULT
end type

#define ID3DXRenderToEnvMap_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define ID3DXRenderToEnvMap_AddRef(p) (p)->lpVtbl->AddRef(p)
#define ID3DXRenderToEnvMap_Release(p) (p)->lpVtbl->Release(p)
#define ID3DXRenderToEnvMap_GetDevice(p, a) (p)->lpVtbl->GetDevice(p, a)
#define ID3DXRenderToEnvMap_GetDesc(p, a) (p)->lpVtbl->GetDesc(p, a)
#define ID3DXRenderToEnvMap_BeginCube(p, a) (p)->lpVtbl->BeginCube(p, a)
#define ID3DXRenderToEnvMap_BeginSphere(p, a) (p)->lpVtbl->BeginSphere(p, a)
#define ID3DXRenderToEnvMap_BeginHemisphere(p, a, b) (p)->lpVtbl->BeginHemisphere(p, a, b)
#define ID3DXRenderToEnvMap_BeginParabolic(p, a, b) (p)->lpVtbl->BeginParabolic(p, a, b)
#define ID3DXRenderToEnvMap_Face(p, a, b) (p)->lpVtbl->Face(p, a, b)
#define ID3DXRenderToEnvMap_End(p, a) (p)->lpVtbl->End(p, a)
#define ID3DXRenderToEnvMap_OnLostDevice(p) (p)->lpVtbl->OnLostDevice(p)

type _D3DXRTS_DESC
	Width as UINT
	Height as UINT
	Format as D3DFORMAT
	DepthStencil as WINBOOL
	DepthStencilFormat as D3DFORMAT
end type

type D3DXRTS_DESC as _D3DXRTS_DESC
type ID3DXRenderToSurfaceVtbl as ID3DXRenderToSurfaceVtbl_

type ID3DXRenderToSurface
	lpVtbl as ID3DXRenderToSurfaceVtbl ptr
end type

type ID3DXRenderToSurfaceVtbl_
	QueryInterface as function(byval This as ID3DXRenderToSurface ptr, byval riid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddRef as function(byval This as ID3DXRenderToSurface ptr) as ULONG
	Release as function(byval This as ID3DXRenderToSurface ptr) as ULONG
	GetDevice as function(byval This as ID3DXRenderToSurface ptr, byval device as IDirect3DDevice9 ptr ptr) as HRESULT
	GetDesc as function(byval This as ID3DXRenderToSurface ptr, byval desc as D3DXRTS_DESC ptr) as HRESULT
	BeginScene as function(byval This as ID3DXRenderToSurface ptr, byval surface as IDirect3DSurface9 ptr, byval viewport as const D3DVIEWPORT9 ptr) as HRESULT
	EndScene as function(byval This as ID3DXRenderToSurface ptr, byval mipfilter as DWORD) as HRESULT
	OnLostDevice as function(byval This as ID3DXRenderToSurface ptr) as HRESULT
	OnResetDevice as function(byval This as ID3DXRenderToSurface ptr) as HRESULT
end type

#define ID3DXRenderToSurface_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define ID3DXRenderToSurface_AddRef(p) (p)->lpVtbl->AddRef(p)
#define ID3DXRenderToSurface_Release(p) (p)->lpVtbl->Release(p)
#define ID3DXRenderToSurface_GetDevice(p, a) (p)->lpVtbl->GetDevice(p, a)
#define ID3DXRenderToSurface_GetDesc(p, a) (p)->lpVtbl->GetDesc(p, a)
#define ID3DXRenderToSurface_BeginScene(p, a, b) (p)->lpVtbl->BeginScene(p, a, b)
#define ID3DXRenderToSurface_EndScene(p, a) (p)->lpVtbl->EndScene(p, a)
#define ID3DXRenderToSurface_OnLostDevice(p) (p)->lpVtbl->OnLostDevice(p)
#define ID3DXRenderToSurface_OnResetDevice(p) (p)->lpVtbl->OnResetDevice(p)
type ID3DXSpriteVtbl as ID3DXSpriteVtbl_

type ID3DXSprite_
	lpVtbl as ID3DXSpriteVtbl ptr
end type

type ID3DXSpriteVtbl_
	QueryInterface as function(byval This as ID3DXSprite ptr, byval riid as const IID const ptr, byval object as any ptr ptr) as HRESULT
	AddRef as function(byval This as ID3DXSprite ptr) as ULONG
	Release as function(byval This as ID3DXSprite ptr) as ULONG
	GetDevice as function(byval This as ID3DXSprite ptr, byval device as IDirect3DDevice9 ptr ptr) as HRESULT
	GetTransform as function(byval This as ID3DXSprite ptr, byval transform as D3DXMATRIX ptr) as HRESULT
	SetTransform as function(byval This as ID3DXSprite ptr, byval transform as const D3DXMATRIX ptr) as HRESULT
	SetWorldViewRH as function(byval This as ID3DXSprite ptr, byval world as const D3DXMATRIX ptr, byval view as const D3DXMATRIX ptr) as HRESULT
	SetWorldViewLH as function(byval This as ID3DXSprite ptr, byval world as const D3DXMATRIX ptr, byval view as const D3DXMATRIX ptr) as HRESULT
	Begin as function(byval This as ID3DXSprite ptr, byval flags as DWORD) as HRESULT
	Draw as function(byval This as ID3DXSprite ptr, byval texture as IDirect3DTexture9 ptr, byval rect as const RECT ptr, byval center as const D3DXVECTOR3 ptr, byval position as const D3DXVECTOR3 ptr, byval color as D3DCOLOR) as HRESULT
	Flush as function(byval This as ID3DXSprite ptr) as HRESULT
	as function(byval This as ID3DXSprite ptr) as HRESULT End
	OnLostDevice as function(byval This as ID3DXSprite ptr) as HRESULT
	OnResetDevice as function(byval This as ID3DXSprite ptr) as HRESULT
end type

#define ID3DXSprite_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define ID3DXSprite_AddRef(p) (p)->lpVtbl->AddRef(p)
#define ID3DXSprite_Release(p) (p)->lpVtbl->Release(p)
#define ID3DXSprite_GetDevice(p, a) (p)->lpVtbl->GetDevice(p, a)
#define ID3DXSprite_GetTransform(p, a) (p)->lpVtbl->GetTransform(p, a)
#define ID3DXSprite_SetTransform(p, a) (p)->lpVtbl->SetTransform(p, a)
#define ID3DXSprite_SetWorldViewRH(p, a, b) (p)->lpVtbl->SetWorldViewRH(p, a, b)
#define ID3DXSprite_SetWorldViewLH(p, a, b) (p)->lpVtbl->SetWorldViewLH(p, a, b)
#define ID3DXSprite_Begin(p, a) (p)->lpVtbl->Begin(p, a)
#define ID3DXSprite_Draw(p, a, b, c, d, e) (p)->lpVtbl->Draw(p, a, b, c, d, e)
#define ID3DXSprite_Flush(p) (p)->lpVtbl->Flush(p)
#define ID3DXSprite_End(p) (p)->lpVtbl->End(p)
#define ID3DXSprite_OnLostDevice(p) (p)->lpVtbl->OnLostDevice(p)
#define ID3DXSprite_OnResetDevice(p) (p)->lpVtbl->OnResetDevice(p)

declare function D3DXCheckVersion(byval d3dsdkvers as UINT, byval d3dxsdkvers as UINT) as WINBOOL
declare function D3DXCreateFontA(byval device as IDirect3DDevice9 ptr, byval height as INT_, byval width as UINT, byval weight as UINT, byval miplevels as UINT, byval italic as WINBOOL, byval charset as DWORD, byval precision as DWORD, byval quality as DWORD, byval pitchandfamily as DWORD, byval facename as const zstring ptr, byval font as ID3DXFont ptr ptr) as HRESULT
declare function D3DXCreateFontW(byval device as IDirect3DDevice9 ptr, byval height as INT_, byval width as UINT, byval weight as UINT, byval miplevels as UINT, byval italic as WINBOOL, byval charset as DWORD, byval precision as DWORD, byval quality as DWORD, byval pitchandfamily as DWORD, byval facename as const wstring ptr, byval font as ID3DXFont ptr ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXCreateFont alias "D3DXCreateFontW"(byval device as IDirect3DDevice9 ptr, byval height as INT_, byval width as UINT, byval weight as UINT, byval miplevels as UINT, byval italic as WINBOOL, byval charset as DWORD, byval precision as DWORD, byval quality as DWORD, byval pitchandfamily as DWORD, byval facename as const wstring ptr, byval font as ID3DXFont ptr ptr) as HRESULT
#else
	declare function D3DXCreateFont alias "D3DXCreateFontA"(byval device as IDirect3DDevice9 ptr, byval height as INT_, byval width as UINT, byval weight as UINT, byval miplevels as UINT, byval italic as WINBOOL, byval charset as DWORD, byval precision as DWORD, byval quality as DWORD, byval pitchandfamily as DWORD, byval facename as const zstring ptr, byval font as ID3DXFont ptr ptr) as HRESULT
#endif

declare function D3DXCreateFontIndirectA(byval device as IDirect3DDevice9 ptr, byval desc as const D3DXFONT_DESCA ptr, byval font as ID3DXFont ptr ptr) as HRESULT
declare function D3DXCreateFontIndirectW(byval device as IDirect3DDevice9 ptr, byval desc as const D3DXFONT_DESCW ptr, byval font as ID3DXFont ptr ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXCreateFontIndirect alias "D3DXCreateFontIndirectW"(byval device as IDirect3DDevice9 ptr, byval desc as const D3DXFONT_DESCW ptr, byval font as ID3DXFont ptr ptr) as HRESULT
#else
	declare function D3DXCreateFontIndirect alias "D3DXCreateFontIndirectA"(byval device as IDirect3DDevice9 ptr, byval desc as const D3DXFONT_DESCA ptr, byval font as ID3DXFont ptr ptr) as HRESULT
#endif

declare function D3DXCreateLine(byval device as IDirect3DDevice9 ptr, byval line as ID3DXLine ptr ptr) as HRESULT
declare function D3DXCreateRenderToEnvMap(byval device as IDirect3DDevice9 ptr, byval size as UINT, byval miplevels as UINT, byval format as D3DFORMAT, byval stencil as WINBOOL, byval stencil_format as D3DFORMAT, byval rtem as ID3DXRenderToEnvMap ptr ptr) as HRESULT
declare function D3DXCreateRenderToSurface(byval device as IDirect3DDevice9 ptr, byval width as UINT, byval height as UINT, byval format as D3DFORMAT, byval stencil as WINBOOL, byval stencil_format as D3DFORMAT, byval rts as ID3DXRenderToSurface ptr ptr) as HRESULT
declare function D3DXCreateSprite(byval device as IDirect3DDevice9 ptr, byval sprite as ID3DXSprite ptr ptr) as HRESULT
declare function D3DXDebugMute(byval mute as WINBOOL) as WINBOOL
declare function D3DXGetDriverLevel(byval device as IDirect3DDevice9 ptr) as UINT

end extern
