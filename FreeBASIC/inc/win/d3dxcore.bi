''
''
'' d3dxcore -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_d3dxcore_bi__
#define __win_d3dxcore_bi__

#include once "win/d3d.bi"
#include once "win/d3dxerr.bi"

type LPD3DXCONTEXT as ID3DXContext ptr

extern IID_ID3DXContext alias "IID_ID3DXContext" as GUID

#define D3DX_SC_DEPTHBUFFER &h01
#define D3DX_SC_STENCILBUFFER &h02
#define D3DX_SC_COLORTEXTURE &h04
#define D3DX_SC_BUMPMAP &h08
#define D3DX_SC_LUMINANCEMAP &h10
#define D3DX_SC_COLORRENDERTGT &h20

enum D3DX_SURFACEFORMAT
	D3DX_SF_UNKNOWN = 0
	D3DX_SF_R8G8B8 = 1
	D3DX_SF_A8R8G8B8 = 2
	D3DX_SF_X8R8G8B8 = 3
	D3DX_SF_R5G6B5 = 4
	D3DX_SF_R5G5B5 = 5
	D3DX_SF_PALETTE4 = 6
	D3DX_SF_PALETTE8 = 7
	D3DX_SF_A1R5G5B5 = 8
	D3DX_SF_X4R4G4B4 = 9
	D3DX_SF_A4R4G4B4 = 10
	D3DX_SF_L8 = 11
	D3DX_SF_A8L8 = 12
	D3DX_SF_U8V8 = 13
	D3DX_SF_U5V5L6 = 14
	D3DX_SF_U8V8L8 = 15
	D3DX_SF_UYVY = 16
	D3DX_SF_YUY2 = 17
	D3DX_SF_DXT1 = 18
	D3DX_SF_DXT3 = 19
	D3DX_SF_DXT5 = 20
	D3DX_SF_R3G3B2 = 21
	D3DX_SF_A8 = 22
	D3DX_SF_TEXTUREMAX = 23
	D3DX_SF_Z16S0 = 256
	D3DX_SF_Z32S0 = 257
	D3DX_SF_Z15S1 = 258
	D3DX_SF_Z24S8 = 259
	D3DX_SF_S1Z15 = 260
	D3DX_SF_S8Z24 = 261
	D3DX_SF_DEPTHMAX = 262
	D3DX_SF_FORCEMAX = -1
end enum

enum D3DX_FILTERTYPE
	D3DX_FT_POINT = &h01
	D3DX_FT_LINEAR = &h02
	D3DX_FT_DEFAULT = -1
end enum

type D3DX_VIDMODEDESC
	width as DWORD
	height as DWORD
	bpp as DWORD
	refreshRate as DWORD
end type

#define D3DX_DRIVERDESC_LENGTH 256

type D3DX_DEVICEDESC
	deviceIndex as DWORD
	hwLevel as DWORD
	ddGuid as GUID
	d3dDeviceGuid as GUID
	ddDeviceID as GUID
	driverDesc as zstring * 256
	monitor as HMONITOR
	onPrimary as BOOL
end type

declare function D3DXInitialize alias "D3DXInitialize" () as HRESULT
declare function D3DXUninitialize alias "D3DXUninitialize" () as HRESULT
declare function D3DXGetDeviceCount alias "D3DXGetDeviceCount" () as DWORD
declare function D3DXGetDeviceDescription alias "D3DXGetDeviceDescription" (byval deviceIndex as DWORD, byval pd3dxDeviceDesc as D3DX_DEVICEDESC ptr) as HRESULT
declare function D3DXGetMaxNumVideoModes alias "D3DXGetMaxNumVideoModes" (byval deviceIndex as DWORD, byval flags as DWORD) as DWORD
declare function D3DXGetVideoMode alias "D3DXGetVideoMode" (byval deviceIndex as DWORD, byval flags as DWORD, byval modeIndex as DWORD, byval pModeDesc as D3DX_VIDMODEDESC ptr) as HRESULT

#define D3DX_GVM_REFRESHRATE &h00000001

declare function D3DXGetMaxSurfaceFormats alias "D3DXGetMaxSurfaceFormats" (byval deviceIndex as DWORD, byval pDesc as D3DX_VIDMODEDESC ptr, byval surfClassFlags as DWORD) as DWORD
declare function D3DXGetSurfaceFormat alias "D3DXGetSurfaceFormat" (byval deviceIndex as DWORD, byval pDesc as D3DX_VIDMODEDESC ptr, byval surfClassFlags as DWORD, byval surfaceIndex as DWORD, byval pFormat as D3DX_SURFACEFORMAT ptr) as HRESULT
declare function D3DXGetCurrentVideoMode alias "D3DXGetCurrentVideoMode" (byval deviceIndex as DWORD, byval pVidMode as D3DX_VIDMODEDESC ptr) as HRESULT
declare function D3DXGetDeviceCaps alias "D3DXGetDeviceCaps" (byval deviceIndex as DWORD, byval pVidMode as D3DX_VIDMODEDESC ptr, byval pD3DCaps as D3DDEVICEDESC7 ptr, byval pDDHALCaps as DDCAPS ptr, byval pDDHELCaps as DDCAPS ptr) as HRESULT
declare function D3DXCreateContext alias "D3DXCreateContext" (byval deviceIndex as DWORD, byval flags as DWORD, byval hwnd as HWND, byval width as DWORD, byval height as DWORD, byval ppCtx as LPD3DXCONTEXT ptr) as HRESULT
declare function D3DXCreateContextEx alias "D3DXCreateContextEx" (byval deviceIndex as DWORD, byval flags as DWORD, byval hwnd as HWND, byval hwndFocus as HWND, byval numColorBits as DWORD, byval numAlphaBits as DWORD, byval numDepthbits as DWORD, byval numStencilBits as DWORD, byval numBackBuffers as DWORD, byval width as DWORD, byval height as DWORD, byval refreshRate as DWORD, byval ppCtx as LPD3DXCONTEXT ptr) as HRESULT

#define D3DX_CONTEXT_FULLSCREEN &h00000001
#define D3DX_CONTEXT_OFFSCREEN &h00000002

declare sub D3DXGetErrorString alias "D3DXGetErrorString" (byval hr as HRESULT, byval strLength as DWORD, byval pStr as LPSTR)
declare function D3DXMakeDDPixelFormat alias "D3DXMakeDDPixelFormat" (byval d3dxFormat as D3DX_SURFACEFORMAT, byval pddpf as DDPIXELFORMAT ptr) as HRESULT
declare function D3DXMakeSurfaceFormat alias "D3DXMakeSurfaceFormat" (byval pddpf as DDPIXELFORMAT ptr) as D3DX_SURFACEFORMAT

type ID3DXContextVtbl_ as ID3DXContextVtbl

type ID3DXContext
	lpVtbl as ID3DXContextVtbl_ ptr
end type

type ID3DXContextVtbl
	QueryInterface as function(byval as IDirect3DVertexBuffer7 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DVertexBuffer7 ptr) as ULONG
	Release as function(byval as IDirect3DVertexBuffer7 ptr) as ULONG
	GetDD as function(byval as IDirect3DVertexBuffer7 ptr) as LPDIRECTDRAW7
	GetD3D as function(byval as IDirect3DVertexBuffer7 ptr) as LPDIRECT3D7
	GetD3DDevice as function(byval as IDirect3DVertexBuffer7 ptr) as LPDIRECT3DDEVICE7
	GetPrimary as function(byval as IDirect3DVertexBuffer7 ptr) as LPDIRECTDRAWSURFACE7
	GetZBuffer as function(byval as IDirect3DVertexBuffer7 ptr) as LPDIRECTDRAWSURFACE7
	GetBackBuffer as function(byval as IDirect3DVertexBuffer7 ptr, byval as DWORD) as LPDIRECTDRAWSURFACE7
	GetWindow as function(byval as IDirect3DVertexBuffer7 ptr) as HWND
	GetFocusWindow as function(byval as IDirect3DVertexBuffer7 ptr) as HWND
	GetDeviceIndex as function(byval as IDirect3DVertexBuffer7 ptr, byval as LPDWORD, byval as LPDWORD) as HRESULT
	GetNumBackBuffers as function(byval as IDirect3DVertexBuffer7 ptr) as DWORD
	GetNumBits as function(byval as IDirect3DVertexBuffer7 ptr, byval as LPDWORD, byval as LPDWORD, byval as LPDWORD, byval as LPDWORD) as HRESULT
	GetBufferSize as function(byval as IDirect3DVertexBuffer7 ptr, byval as LPDWORD, byval as LPDWORD) as HRESULT
	GetCreationFlags as function(byval as IDirect3DVertexBuffer7 ptr) as DWORD
	GetRefreshRate as function(byval as IDirect3DVertexBuffer7 ptr) as DWORD
	RestoreSurfaces as function(byval as IDirect3DVertexBuffer7 ptr) as HRESULT
	Resize as function(byval as IDirect3DVertexBuffer7 ptr, byval as DWORD, byval as DWORD) as HRESULT
	UpdateFrame as function(byval as IDirect3DVertexBuffer7 ptr, byval as DWORD) as HRESULT
	DrawDebugText as function(byval as IDirect3DVertexBuffer7 ptr, byval as single, byval as single, byval as D3DCOLOR, byval as LPSTR) as HRESULT
	Clear as function(byval as IDirect3DVertexBuffer7 ptr, byval as DWORD) as HRESULT
	SetClearColor as function(byval as IDirect3DVertexBuffer7 ptr, byval as D3DCOLOR) as HRESULT
	SetClearDepth as function(byval as IDirect3DVertexBuffer7 ptr, byval as single) as HRESULT
	SetClearStencil as function(byval as IDirect3DVertexBuffer7 ptr, byval as DWORD) as HRESULT
end type

#define D3DX_UPDATE_NOVSYNC (1 shl 0)

declare function D3DXCheckTextureRequirements alias "D3DXCheckTextureRequirements" (byval pd3dDevice as LPDIRECT3DDEVICE7, byval pFlags as LPDWORD, byval pWidth as LPDWORD, byval pHeight as LPDWORD, byval pPixelFormat as D3DX_SURFACEFORMAT ptr) as HRESULT
declare function D3DXCreateTexture alias "D3DXCreateTexture" (byval pd3dDevice as LPDIRECT3DDEVICE7, byval pFlags as LPDWORD, byval pWidth as LPDWORD, byval pHeight as LPDWORD, byval pPixelFormat as D3DX_SURFACEFORMAT ptr, byval pDDPal as LPDIRECTDRAWPALETTE, byval ppDDSurf as LPDIRECTDRAWSURFACE7 ptr, byval pNumMipMaps as LPDWORD) as HRESULT
declare function D3DXCreateCubeMapTexture alias "D3DXCreateCubeMapTexture" (byval pd3dDevice as LPDIRECT3DDEVICE7, byval pFlags as LPDWORD, byval cubefaces as DWORD, byval colorEmptyFaces as D3DCOLOR, byval pWidth as LPDWORD, byval pHeight as LPDWORD, byval pPixelFormat as D3DX_SURFACEFORMAT ptr, byval pDDPal as LPDIRECTDRAWPALETTE, byval ppDDSurf as LPDIRECTDRAWSURFACE7 ptr, byval pNumMipMaps as LPDWORD) as HRESULT
declare function D3DXCreateTextureFromFile alias "D3DXCreateTextureFromFile" (byval pd3dDevice as LPDIRECT3DDEVICE7, byval pFlags as LPDWORD, byval pWidth as LPDWORD, byval pHeight as LPDWORD, byval pPixelFormat as D3DX_SURFACEFORMAT ptr, byval pDDPal as LPDIRECTDRAWPALETTE, byval ppDDSurf as LPDIRECTDRAWSURFACE7 ptr, byval pNumMipMaps as LPDWORD, byval pSrcName as LPSTR, byval filterType as D3DX_FILTERTYPE) as HRESULT
declare function D3DXLoadTextureFromFile alias "D3DXLoadTextureFromFile" (byval pd3dDevice as LPDIRECT3DDEVICE7, byval pTexture as LPDIRECTDRAWSURFACE7, byval mipMapLevel as DWORD, byval pSrcName as LPSTR, byval pSrcRect as RECT ptr, byval pDestRect as RECT ptr, byval filterType as D3DX_FILTERTYPE) as HRESULT
declare function D3DXLoadTextureFromSurface alias "D3DXLoadTextureFromSurface" (byval pd3dDevice as LPDIRECT3DDEVICE7, byval pTexture as LPDIRECTDRAWSURFACE7, byval mipMapLevel as DWORD, byval pSurfaceSrc as LPDIRECTDRAWSURFACE7, byval pSrcRect as RECT ptr, byval pDestRect as RECT ptr, byval filterType as D3DX_FILTERTYPE) as HRESULT
declare function D3DXLoadTextureFromMemory alias "D3DXLoadTextureFromMemory" (byval pd3dDevice as LPDIRECT3DDEVICE7, byval pTexture as LPDIRECTDRAWSURFACE7, byval mipMapLevel as DWORD, byval pMemory as LPVOID, byval pDDPal as LPDIRECTDRAWPALETTE, byval srcPixelFormat as D3DX_SURFACEFORMAT, byval srcPitch as DWORD, byval pDestRect as RECT ptr, byval filterType as D3DX_FILTERTYPE) as HRESULT

#define D3DX_TEXTURE_NOMIPMAP (1 shl 8)
#define D3DX_TEXTURE_STAGE0 (0)
#define D3DX_TEXTURE_STAGE1 (1)
#define D3DX_TEXTURE_STAGE2 (2)
#define D3DX_TEXTURE_STAGE3 (3)
#define D3DX_TEXTURE_STAGE4 (4)
#define D3DX_TEXTURE_STAGE5 (5)
#define D3DX_TEXTURE_STAGE6 (6)
#define D3DX_TEXTURE_STAGE7 (7)
#define D3DX_TEXTURE_STAGE_MASK (&h7)

#endif
