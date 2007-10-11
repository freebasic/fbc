''
''
'' d3dx9core -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_d3dx9core_bi__
#define __win_d3dx9core_bi__

#include once "win/d3dx9.bi"

#define D3DX_VERSION &h0902
#define D3DX_SDK_VERSION 22

declare function D3DXCheckVersion alias "D3DXCheckVersion" (byval D3DSdkVersion as UINT, byval D3DXSdkVersion as UINT) as BOOL
declare function D3DXGetDriverLevel alias "D3DXGetDriverLevel" (byval pDevice as LPDIRECT3DDEVICE9) as UINT

type LPD3DXBUFFER as ID3DXBuffer ptr

extern IID_ID3DXBuffer alias "IID_ID3DXBuffer" as GUID

type ID3DXBufferVtbl_ as ID3DXBufferVtbl

type ID3DXBuffer
	lpVtbl as ID3DXBufferVtbl_ ptr
end type

type ID3DXBufferVtbl
	QueryInterface as function(byval as ID3DXBuffer ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as ID3DXBuffer ptr) as ULONG
	Release as function(byval as ID3DXBuffer ptr) as ULONG
	GetBufferPointer as function(byval as ID3DXBuffer ptr) as LPVOID
	GetBufferSize as function(byval as ID3DXBuffer ptr) as DWORD
end type

#define D3DXSPRITE_DONOTSAVESTATE (1 shl 0)
#define D3DXSPRITE_DONOTMODIFY_RENDERSTATE (1 shl 1)
#define D3DXSPRITE_OBJECTSPACE (1 shl 2)
#define D3DXSPRITE_BILLBOARD (1 shl 3)
#define D3DXSPRITE_ALPHABLEND (1 shl 4)
#define D3DXSPRITE_SORT_TEXTURE (1 shl 5)
#define D3DXSPRITE_SORT_DEPTH_FRONTTOBACK (1 shl 6)
#define D3DXSPRITE_SORT_DEPTH_BACKTOFRONT (1 shl 7)

type LPD3DXSPRITE as ID3DXSprite ptr
extern IID_ID3DXSprite alias "IID_ID3DXSprite" as GUID

type ID3DXSpriteVtbl_ as ID3DXSpriteVtbl

type ID3DXSprite
	lpVtbl as ID3DXSpriteVtbl_ ptr
end type

type ID3DXSpriteVtbl
	QueryInterface as function(byval as ID3DXSprite ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as ID3DXSprite ptr) as ULONG
	Release as function(byval as ID3DXSprite ptr) as ULONG
	GetDevice as function(byval as ID3DXSprite ptr, byval as LPDIRECT3DDEVICE9 ptr) as HRESULT
	GetTransform as function(byval as ID3DXSprite ptr, byval as D3DXMATRIX ptr) as HRESULT
	SetTransform as function(byval as ID3DXSprite ptr, byval as D3DXMATRIX ptr) as HRESULT
	SetWorldViewRH as function(byval as ID3DXSprite ptr, byval as D3DXMATRIX ptr, byval as D3DXMATRIX ptr) as HRESULT
	SetWorldViewLH as function(byval as ID3DXSprite ptr, byval as D3DXMATRIX ptr, byval as D3DXMATRIX ptr) as HRESULT
	Begin as function(byval as ID3DXSprite ptr, byval as DWORD) as HRESULT
	Draw as function(byval as ID3DXSprite ptr, byval as LPDIRECT3DTEXTURE9, byval as RECT ptr, byval as D3DXVECTOR3 ptr, byval as D3DXVECTOR3 ptr, byval as D3DCOLOR) as HRESULT
	Flush as function(byval as ID3DXSprite ptr) as HRESULT
	End as function(byval as ID3DXSprite ptr) as HRESULT
	OnLostDevice as function(byval as ID3DXSprite ptr) as HRESULT
	OnResetDevice as function(byval as ID3DXSprite ptr) as HRESULT
end type

declare function D3DXCreateSprite alias "D3DXCreateSprite" (byval pDevice as LPDIRECT3DDEVICE9, byval ppSprite as LPD3DXSPRITE ptr) as HRESULT

type D3DXFONT_DESCA
	Height as INT_
	Width as UINT
	Weight as UINT
	MipLevels as UINT
	Italic as BOOL
	CharSet as UBYTE
	OutputPrecision as UBYTE
	Quality as UBYTE
	PitchAndFamily as UBYTE
	FaceName as zstring * 32
end type

type LPD3DXFONT_DESCA as D3DXFONT_DESCA ptr
type D3DXFONT_DESCW
	Height as INT_
	Width as UINT
	Weight as UINT
	MipLevels as UINT
	Italic as BOOL
	CharSet as UBYTE
	OutputPrecision as UBYTE
	Quality as UBYTE
	PitchAndFamily as UBYTE
	FaceName as wstring * 32
end type

type LPD3DXFONT_DESCW as D3DXFONT_DESCW ptr

#ifndef UNICODE
type D3DXFONT_DESC as D3DXFONT_DESCA
type LPD3DXFONT_DESC as LPD3DXFONT_DESCA
type TEXTMETRICW as any
#else
type D3DXFONT_DESC as D3DXFONT_DESCW
type LPD3DXFONT_DESC as LPD3DXFONT_DESCW
type TEXTMETRICA as any
#endif

type LPD3DXFONT as ID3DXFont ptr
extern IID_ID3DXFont alias "IID_ID3DXFont" as GUID

type ID3DXFontVtbl_ as ID3DXFontVtbl

type ID3DXFont
	lpVtbl as ID3DXFontVtbl_ ptr
end type

type ID3DXFontVtbl
	QueryInterface as function(byval as ID3DXFont ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as ID3DXFont ptr) as ULONG
	Release as function(byval as ID3DXFont ptr) as ULONG
	GetDevice as function(byval as ID3DXFont ptr, byval as LPDIRECT3DDEVICE9 ptr) as HRESULT
	GetDescA as function(byval as ID3DXFont ptr, byval as D3DXFONT_DESCA ptr) as HRESULT
	GetDescW as function(byval as ID3DXFont ptr, byval as D3DXFONT_DESCW ptr) as HRESULT
	GetTextMetricsA as function(byval as ID3DXFont ptr, byval as TEXTMETRICA ptr) as BOOL
	GetTextMetricsW as function(byval as ID3DXFont ptr, byval as TEXTMETRICW ptr) as BOOL
	GetDC as function(byval as ID3DXFont ptr) as HDC
	GetGlyphData as function(byval as ID3DXFont ptr, byval as UINT, byval as LPDIRECT3DTEXTURE9 ptr, byval as RECT ptr, byval as POINT ptr) as HRESULT
	PreloadCharacters as function(byval as ID3DXFont ptr, byval as UINT, byval as UINT) as HRESULT
	PreloadGlyphs as function(byval as ID3DXFont ptr, byval as UINT, byval as UINT) as HRESULT
	PreloadTextA as function(byval as ID3DXFont ptr, byval as LPCSTR, byval as INT_) as HRESULT
	PreloadTextW as function(byval as ID3DXFont ptr, byval as LPCWSTR, byval as INT_) as HRESULT
	DrawTextA as function(byval as ID3DXFont ptr, byval as LPD3DXSPRITE, byval as LPCSTR, byval as INT_, byval as LPRECT, byval as DWORD, byval as D3DCOLOR) as INT_
	DrawTextW as function(byval as ID3DXFont ptr, byval as LPD3DXSPRITE, byval as LPCWSTR, byval as INT_, byval as LPRECT, byval as DWORD, byval as D3DCOLOR) as INT_
	OnLostDevice as function(byval as ID3DXFont ptr) as HRESULT
	OnResetDevice as function(byval as ID3DXFont ptr) as HRESULT
end type

#ifdef UNICODE
declare function D3DXCreateFont alias "D3DXCreateFontW" (byval pDevice as LPDIRECT3DDEVICE9, byval Height as INT_, byval Width as UINT, byval Weight as UINT, byval MipLevels as UINT, byval Italic as BOOL, byval CharSet as DWORD, byval OutputPrecision as DWORD, byval Quality as DWORD, byval PitchAndFamily as DWORD, byval pFaceName as LPCWSTR, byval ppFont as LPD3DXFONT ptr) as HRESULT
declare function D3DXCreateFontIndirect alias "D3DXCreateFontIndirectW" (byval pDevice as LPDIRECT3DDEVICE9, byval pDesc as D3DXFONT_DESCW ptr, byval ppFont as LPD3DXFONT ptr) as HRESULT
#else
declare function D3DXCreateFont alias "D3DXCreateFontA" (byval pDevice as LPDIRECT3DDEVICE9, byval Height as INT_, byval Width as UINT, byval Weight as UINT, byval MipLevels as UINT, byval Italic as BOOL, byval CharSet as DWORD, byval OutputPrecision as DWORD, byval Quality as DWORD, byval PitchAndFamily as DWORD, byval pFaceName as LPCSTR, byval ppFont as LPD3DXFONT ptr) as HRESULT
declare function D3DXCreateFontIndirect alias "D3DXCreateFontIndirectA" (byval pDevice as LPDIRECT3DDEVICE9, byval pDesc as D3DXFONT_DESCA ptr, byval ppFont as LPD3DXFONT ptr) as HRESULT
#endif

type D3DXRTS_DESC
	Width as UINT
	Height as UINT
	Format as D3DFORMAT
	DepthStencil as BOOL
	DepthStencilFormat as D3DFORMAT
end type

type LPD3DXRTS_DESC as D3DXRTS_DESC ptr
type LPD3DXRENDERTOSURFACE as ID3DXRenderToSurface ptr

extern IID_ID3DXRenderToSurface alias "IID_ID3DXRenderToSurface" as GUID

type ID3DXRenderToSurfaceVtbl_ as ID3DXRenderToSurfaceVtbl

type ID3DXRenderToSurface
	lpVtbl as ID3DXRenderToSurfaceVtbl_ ptr
end type

type ID3DXRenderToSurfaceVtbl
	QueryInterface as function(byval as ID3DXRenderToSurface ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as ID3DXRenderToSurface ptr) as ULONG
	Release as function(byval as ID3DXRenderToSurface ptr) as ULONG
	GetDevice as function(byval as ID3DXRenderToSurface ptr, byval as LPDIRECT3DDEVICE9 ptr) as HRESULT
	GetDesc as function(byval as ID3DXRenderToSurface ptr, byval as D3DXRTS_DESC ptr) as HRESULT
	BeginScene as function(byval as ID3DXRenderToSurface ptr, byval as LPDIRECT3DSURFACE9, byval as D3DVIEWPORT9 ptr) as HRESULT
	EndScene as function(byval as ID3DXRenderToSurface ptr, byval as DWORD) as HRESULT
	OnLostDevice as function(byval as ID3DXRenderToSurface ptr) as HRESULT
	OnResetDevice as function(byval as ID3DXRenderToSurface ptr) as HRESULT
end type

declare function D3DXCreateRenderToSurface alias "D3DXCreateRenderToSurface" (byval pDevice as LPDIRECT3DDEVICE9, byval Width as UINT, byval Height as UINT, byval Format as D3DFORMAT, byval DepthStencil as BOOL, byval DepthStencilFormat as D3DFORMAT, byval ppRenderToSurface as LPD3DXRENDERTOSURFACE ptr) as HRESULT

type D3DXRTE_DESC
	Size as UINT
	MipLevels as UINT
	Format as D3DFORMAT
	DepthStencil as BOOL
	DepthStencilFormat as D3DFORMAT
end type

type LPD3DXRTE_DESC as D3DXRTE_DESC ptr
type LPD3DXRenderToEnvMap as ID3DXRenderToEnvMap ptr

extern IID_ID3DXRenderToEnvMap alias "IID_ID3DXRenderToEnvMap" as GUID

type ID3DXRenderToEnvMapVtbl_ as ID3DXRenderToEnvMapVtbl

type ID3DXRenderToEnvMap
	lpVtbl as ID3DXRenderToEnvMapVtbl_ ptr
end type

type ID3DXRenderToEnvMapVtbl
	QueryInterface as function(byval as ID3DXRenderToEnvMap ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as ID3DXRenderToEnvMap ptr) as ULONG
	Release as function(byval as ID3DXRenderToEnvMap ptr) as ULONG
	GetDevice as function(byval as ID3DXRenderToEnvMap ptr, byval as LPDIRECT3DDEVICE9 ptr) as HRESULT
	GetDesc as function(byval as ID3DXRenderToEnvMap ptr, byval as D3DXRTE_DESC ptr) as HRESULT
	BeginCube as function(byval as ID3DXRenderToEnvMap ptr, byval as LPDIRECT3DCUBETEXTURE9) as HRESULT
	BeginSphere as function(byval as ID3DXRenderToEnvMap ptr, byval as LPDIRECT3DTEXTURE9) as HRESULT
	BeginHemisphere as function(byval as ID3DXRenderToEnvMap ptr, byval as LPDIRECT3DTEXTURE9, byval as LPDIRECT3DTEXTURE9) as HRESULT
	BeginParabolic as function(byval as ID3DXRenderToEnvMap ptr, byval as LPDIRECT3DTEXTURE9, byval as LPDIRECT3DTEXTURE9) as HRESULT
	Face as function(byval as ID3DXRenderToEnvMap ptr, byval as D3DCUBEMAP_FACES, byval as DWORD) as HRESULT
	End as function(byval as ID3DXRenderToEnvMap ptr, byval as DWORD) as HRESULT
	OnLostDevice as function(byval as ID3DXRenderToEnvMap ptr) as HRESULT
	OnResetDevice as function(byval as ID3DXRenderToEnvMap ptr) as HRESULT
end type

declare function D3DXCreateRenderToEnvMap alias "D3DXCreateRenderToEnvMap" (byval pDevice as LPDIRECT3DDEVICE9, byval Size as UINT, byval MipLevels as UINT, byval Format as D3DFORMAT, byval DepthStencil as BOOL, byval DepthStencilFormat as D3DFORMAT, byval ppRenderToEnvMap as LPD3DXRenderToEnvMap ptr) as HRESULT

type LPD3DXLINE as ID3DXLine ptr

extern IID_ID3DXLine alias "IID_ID3DXLine" as GUID

type ID3DXLineVtbl_ as ID3DXLineVtbl

type ID3DXLine
	lpVtbl as ID3DXLineVtbl_ ptr
end type

type ID3DXLineVtbl
	QueryInterface as function(byval as ID3DXLine ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as ID3DXLine ptr) as ULONG
	Release as function(byval as ID3DXLine ptr) as ULONG
	GetDevice as function(byval as ID3DXLine ptr, byval as LPDIRECT3DDEVICE9 ptr) as HRESULT
	Begin as function(byval as ID3DXLine ptr) as HRESULT
	Draw as function(byval as ID3DXLine ptr, byval as D3DXVECTOR2 ptr, byval as DWORD, byval as D3DCOLOR) as HRESULT
	DrawTransform as function(byval as ID3DXLine ptr, byval as D3DXVECTOR3 ptr, byval as DWORD, byval as D3DXMATRIX ptr, byval as D3DCOLOR) as HRESULT
	SetPattern as function(byval as ID3DXLine ptr, byval as DWORD) as HRESULT
	GetPattern as function(byval as ID3DXLine ptr) as DWORD
	SetPatternScale as function(byval as ID3DXLine ptr, byval as FLOAT) as HRESULT
	GetPatternScale as function(byval as ID3DXLine ptr) as FLOAT
	SetWidth as function(byval as ID3DXLine ptr, byval as FLOAT) as HRESULT
	GetWidth as function(byval as ID3DXLine ptr) as FLOAT
	SetAntialias as function(byval as ID3DXLine ptr, byval as BOOL) as HRESULT
	GetAntialias as function(byval as ID3DXLine ptr) as BOOL
	SetGLLines as function(byval as ID3DXLine ptr, byval as BOOL) as HRESULT
	GetGLLines as function(byval as ID3DXLine ptr) as BOOL
	End as function(byval as ID3DXLine ptr) as HRESULT
	OnLostDevice as function(byval as ID3DXLine ptr) as HRESULT
	OnResetDevice as function(byval as ID3DXLine ptr) as HRESULT
end type

declare function D3DXCreateLine alias "D3DXCreateLine" (byval pDevice as LPDIRECT3DDEVICE9, byval ppLine as LPD3DXLINE ptr) as HRESULT

#endif
