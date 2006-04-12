''
''
'' d3d9 -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_d3d9_bi__
#define __win_d3d9_bi__

#inclib "dxguid"
#inclib "d3d9"

#ifndef DIRECT3D_VERSION
#define DIRECT3D_VERSION &h0900
#endif

#include once "win/objbase.bi"
#include once "win/d3d9types.bi"
#include once "win/d3d9caps.bi"

#define D3D_SDK_VERSION 31
#define D3DCREATE_FPU_PRESERVE &h02
#define D3DCREATE_MULTITHREADED &h04
#define D3DCREATE_PUREDEVICE &h10
#define D3DCREATE_SOFTWARE_VERTEXPROCESSING &h20
#define D3DCREATE_HARDWARE_VERTEXPROCESSING &h40
#define D3DCREATE_MIXED_VERTEXPROCESSING &h80
#define D3DSPD_IUNKNOWN 1
#define D3DSGR_NO_CALIBRATION 0
#define D3DSGR_CALIBRATE 1
#define MAKE_D3DHRESULT(code) MAKE_HRESULT(1,&h876,code)
#define MAKE_D3DSTATUS(code) MAKE_HRESULT(0,&h876,code)
#define D3D_OK 0
#define D3DOK_NOAUTOGEN	MAKE_D3DSTATUS(2159)
#define D3DERR_WRONGTEXTUREFORMAT	MAKE_D3DHRESULT(2072)
#define D3DERR_UNSUPPORTEDCOLOROPERATION	MAKE_D3DHRESULT(2073)
#define D3DERR_UNSUPPORTEDCOLORARG	MAKE_D3DHRESULT(2074)
#define D3DERR_UNSUPPORTEDALPHAOPERATION	MAKE_D3DHRESULT(2075)
#define D3DERR_UNSUPPORTEDALPHAARG	MAKE_D3DHRESULT(2076)
#define D3DERR_TOOMANYOPERATIONS	MAKE_D3DHRESULT(2077)
#define D3DERR_CONFLICTINGTEXTUREFILTER	MAKE_D3DHRESULT(2078)
#define D3DERR_UNSUPPORTEDFACTORVALUE	MAKE_D3DHRESULT(2079)
#define D3DERR_CONFLICTINGRENDERSTATE	MAKE_D3DHRESULT(2081)
#define D3DERR_UNSUPPORTEDTEXTUREFILTER	MAKE_D3DHRESULT(2082)
#define D3DERR_CONFLICTINGTEXTUREPALETTE	MAKE_D3DHRESULT(2086)
#define D3DERR_DRIVERINTERNALERROR	MAKE_D3DHRESULT(2087)
#define D3DERR_NOTFOUND	MAKE_D3DHRESULT(2150)
#define D3DERR_MOREDATA	MAKE_D3DHRESULT(2151)
#define D3DERR_DEVICELOST	MAKE_D3DHRESULT(2152)
#define D3DERR_DEVICENOTRESET	MAKE_D3DHRESULT(2153)
#define D3DERR_NOTAVAILABLE	MAKE_D3DHRESULT(2154)
#define D3DERR_OUTOFVIDEOMEMORY	MAKE_D3DHRESULT(380)
#define D3DERR_INVALIDDEVICE	MAKE_D3DHRESULT(2155)
#define D3DERR_INVALIDCALL	MAKE_D3DHRESULT(2156)
#define D3DERR_DRIVERINVALIDCALL	MAKE_D3DHRESULT(2157)
#define D3DERR_WASSTILLDRAWING	MAKE_D3DHRESULT(540)
#define D3DADAPTER_DEFAULT 0
#define D3DCURSOR_IMMEDIATE_UPDATE 1
#define D3DENUM_HOST_ADAPTER 1
#define D3DENUM_NO_WHQL_LEVEL 2
#define D3DPRESENT_BACK_BUFFERS_MAX 3
#define VALID_D3DENUM_FLAGS 3
#define D3DMAXNUMPRIMITIVES &hFFFF
#define D3DMAXNUMVERTICES &hFFFF
#define D3DCURRENT_DISPLAY_MODE &hEFFFFF

extern IID_IDirect3D9 alias "IID_IDirect3D9" as GUID
extern IID_IDirect3DDevice9 alias "IID_IDirect3DDevice9" as GUID
extern IID_IDirect3DVolume9 alias "IID_IDirect3DVolume9" as GUID
extern IID_IDirect3DSwapChain9 alias "IID_IDirect3DSwapChain9" as GUID
extern IID_IDirect3DResource9 alias "IID_IDirect3DResource9" as GUID
extern IID_IDirect3DSurface9 alias "IID_IDirect3DSurface9" as GUID
extern IID_IDirect3DVertexBuffer9 alias "IID_IDirect3DVertexBuffer9" as GUID
extern IID_IDirect3DIndexBuffer9 alias "IID_IDirect3DIndexBuffer9" as GUID
extern IID_IDirect3DBaseTexture9 alias "IID_IDirect3DBaseTexture9" as GUID
extern IID_IDirect3DCubeTexture9 alias "IID_IDirect3DCubeTexture9" as GUID
extern IID_IDirect3DTexture9 alias "IID_IDirect3DTexture9" as GUID
extern IID_IDirect3DVolumeTexture9 alias "IID_IDirect3DVolumeTexture9" as GUID
extern IID_IDirect3DVertexDeclaration9 alias "IID_IDirect3DVertexDeclaration9" as GUID
extern IID_IDirect3DVertexShader9 alias "IID_IDirect3DVertexShader9" as GUID
extern IID_IDirect3DPixelShader9 alias "IID_IDirect3DPixelShader9" as GUID
extern IID_IDirect3DStateBlock9 alias "IID_IDirect3DStateBlock9" as GUID
extern IID_IDirect3DQuery9 alias "IID_IDirect3DQuery9" as GUID

type IDirect3D9_ as IDirect3D9
type IDirect3DDevice9_ as IDirect3DDevice9
type IDirect3DVolume9_ as IDirect3DVolume9
type IDirect3DSwapChain9_ as IDirect3DSwapChain9
type IDirect3DResource9_ as IDirect3DResource9
type IDirect3DSurface9_ as IDirect3DSurface9
type IDirect3DVertexBuffer9_ as IDirect3DVertexBuffer9
type IDirect3DIndexBuffer9_ as IDirect3DIndexBuffer9
type IDirect3DBaseTexture9_ as IDirect3DBaseTexture9
type IDirect3DCubeTexture9_ as IDirect3DCubeTexture9
type IDirect3DTexture9_ as IDirect3DTexture9
type IDirect3DVolumeTexture9_ as IDirect3DVolumeTexture9
type IDirect3DVertexDeclaration9_ as IDirect3DVertexDeclaration9
type IDirect3DVertexShader9_ as IDirect3DVertexShader9
type IDirect3DPixelShader9_ as IDirect3DPixelShader9
type IDirect3DStateBlock9_ as IDirect3DStateBlock9
type IDirect3DQuery9_ as IDirect3DQuery9

type IDirect3D9Vtbl_ as IDirect3D9Vtbl

type IDirect3D9
	lpVtbl as IDirect3D9Vtbl_ ptr
end type

type IDirect3D9Vtbl
	QueryInterface as function(byval as IDirect3D9 ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3D9 ptr) as ULONG
	Release as function(byval as IDirect3D9 ptr) as ULONG
	RegisterSoftwareDevice as function(byval as IDirect3D9 ptr, byval as any ptr) as HRESULT
	GetAdapterCount as function(byval as IDirect3D9 ptr) as UINT
	GetAdapterIdentifier as function(byval as IDirect3D9 ptr, byval as UINT, byval as DWORD, byval as D3DADAPTER_IDENTIFIER9 ptr) as HRESULT
	GetAdapterModeCount as function(byval as IDirect3D9 ptr, byval as UINT, byval as D3DFORMAT) as UINT
	EnumAdapterModes as function(byval as IDirect3D9 ptr, byval as UINT, byval as D3DFORMAT, byval as UINT, byval as D3DDISPLAYMODE ptr) as HRESULT
	GetAdapterDisplayMode as function(byval as IDirect3D9 ptr, byval as UINT, byval as D3DDISPLAYMODE ptr) as HRESULT
	CheckDeviceType as function(byval as IDirect3D9 ptr, byval as UINT, byval as D3DDEVTYPE, byval as D3DFORMAT, byval as D3DFORMAT, byval as BOOL) as HRESULT
	CheckDeviceFormat as function(byval as IDirect3D9 ptr, byval as UINT, byval as D3DDEVTYPE, byval as D3DFORMAT, byval as DWORD, byval as D3DRESOURCETYPE, byval as D3DFORMAT) as HRESULT
	CheckDeviceMultiSampleType as function(byval as IDirect3D9 ptr, byval as UINT, byval as D3DDEVTYPE, byval as D3DFORMAT, byval as BOOL, byval as D3DMULTISAMPLE_TYPE, byval as DWORD ptr) as HRESULT
	CheckDepthStencilMatch as function(byval as IDirect3D9 ptr, byval as UINT, byval as D3DDEVTYPE, byval as D3DFORMAT, byval as D3DFORMAT, byval as D3DFORMAT) as HRESULT
	CheckDeviceFormatConversion as function(byval as IDirect3D9 ptr, byval as UINT, byval as D3DDEVTYPE, byval as D3DFORMAT, byval as D3DFORMAT) as HRESULT
	GetDeviceCaps as function(byval as IDirect3D9 ptr, byval as UINT, byval as D3DDEVTYPE, byval as D3DCAPS9 ptr) as HRESULT
	GetAdapterMonitor as function(byval as IDirect3D9 ptr, byval as UINT) as HMONITOR
	CreateDevice as function(byval as IDirect3D9 ptr, byval as UINT, byval as D3DDEVTYPE, byval as HWND, byval as DWORD, byval as D3DPRESENT_PARAMETERS ptr, byval as IDirect3DDevice9_ ptr ptr) as HRESULT
end type

type LPDIRECT3D9 as IDirect3D9 ptr
type PDIRECT3D9 as IDirect3D9 ptr

#define IDirect3D9_QueryInterface(p,a,b)	(p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3D9_AddRef(p)	(p)->lpVtbl->AddRef(p)
#define IDirect3D9_Release(p)	(p)->lpVtbl->Release(p)
#define IDirect3D9_RegisterSoftwareDevice(p,a)	(p)->lpVtbl->RegisterSoftwareDevice(p,a)
#define IDirect3D9_GetAdapterCount(p)	(p)->lpVtbl->GetAdapterCount(p)
#define IDirect3D9_GetAdapterIdentifier(p,a,b,c)	(p)->lpVtbl->GetAdapterIdentifier(p,a,b,c)
#define IDirect3D9_GetAdapterModeCount(p,a,b)	(p)->lpVtbl->GetAdapterModeCount(p,a,b)
#define IDirect3D9_EnumAdapterModes(p,a,b,c,d)	(p)->lpVtbl->EnumAdapterModes(p,a,b,c,d)
#define IDirect3D9_GetAdapterDisplayMode(p,a,b)	(p)->lpVtbl->GetAdapterDisplayMode(p,a,b)
#define IDirect3D9_CheckDeviceType(p,a,b,c,d,e)	(p)->lpVtbl->CheckDeviceType(p,a,b,c,d,e)
#define IDirect3D9_CheckDeviceFormat(p,a,b,c,d,e,f)	(p)->lpVtbl->CheckDeviceFormat(p,a,b,c,d,e,f)
#define IDirect3D9_CheckDeviceMultiSampleType(p,a,b,c,d,e,f)	(p)->lpVtbl->CheckDeviceMultiSampleType(p,a,b,c,d,e,f)
#define IDirect3D9_CheckDepthStencilMatch(p,a,b,c,d,e)	(p)->lpVtbl->CheckDepthStencilMatch(p,a,b,c,d,e)
#define IDirect3D9_CheckDeviceFormatConversion(p,a,b,c,d)	(p)->lpVtbl->CheckDeviceFormatConversion(p,a,b,c,d)
#define IDirect3D9_GetDeviceCaps(p,a,b,c)	(p)->lpVtbl->GetDeviceCaps(p,a,b,c)
#define IDirect3D9_GetAdapterMonitor(p,a)	(p)->lpVtbl->GetAdapterMonitor(p,a)
#define IDirect3D9_CreateDevice(p,a,b,c,d,e,f)	(p)->lpVtbl->CreateDevice(p,a,b,c,d,e,f)

type IDirect3DDevice9Vtbl_ as IDirect3DDevice9Vtbl

type IDirect3DDevice9
	lpVtbl as IDirect3DDevice9Vtbl_ ptr
end type

type IDirect3DDevice9Vtbl
	QueryInterface as function(byval as IDirect3DDevice9 ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DDevice9 ptr) as ULONG
	Release as function(byval as IDirect3DDevice9 ptr) as ULONG
	TestCooperativeLevel as function(byval as IDirect3DDevice9 ptr) as HRESULT
	GetAvailableTextureMem as function(byval as IDirect3DDevice9 ptr) as UINT
	EvictManagedResources as function(byval as IDirect3DDevice9 ptr) as HRESULT
	GetDirect3D as function(byval as IDirect3DDevice9 ptr, byval as IDirect3D9 ptr ptr) as HRESULT
	GetDeviceCaps as function(byval as IDirect3DDevice9 ptr, byval as D3DCAPS9 ptr) as HRESULT
	GetDisplayMode as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as D3DDISPLAYMODE ptr) as HRESULT
	GetCreationParameters as function(byval as IDirect3DDevice9 ptr, byval as D3DDEVICE_CREATION_PARAMETERS ptr) as HRESULT
	SetCursorProperties as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as UINT, byval as IDirect3DSurface9_ ptr) as HRESULT
	SetCursorPosition as sub(byval as IDirect3DDevice9 ptr, byval as integer, byval as integer, byval as DWORD)
	ShowCursor as function(byval as IDirect3DDevice9 ptr, byval as BOOL) as BOOL
	CreateAdditionalSwapChain as function(byval as IDirect3DDevice9 ptr, byval as D3DPRESENT_PARAMETERS ptr, byval as IDirect3DSwapChain9_ ptr ptr) as HRESULT
	GetSwapChain as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as IDirect3DSwapChain9_ ptr ptr) as HRESULT
	GetNumberOfSwapChains as function(byval as IDirect3DDevice9 ptr) as UINT
	Reset as function(byval as IDirect3DDevice9 ptr, byval as D3DPRESENT_PARAMETERS ptr) as HRESULT
	Present as function(byval as IDirect3DDevice9 ptr, byval as RECT ptr, byval as RECT ptr, byval as HWND, byval as RGNDATA ptr) as HRESULT
	GetBackBuffer as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as UINT, byval as D3DBACKBUFFER_TYPE, byval as IDirect3DSurface9_ ptr ptr) as HRESULT
	GetRasterStatus as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as D3DRASTER_STATUS ptr) as HRESULT
	SetDialogBoxMode as function(byval as IDirect3DDevice9 ptr, byval as BOOL) as HRESULT
	SetGammaRamp as sub(byval as IDirect3DDevice9 ptr, byval as UINT, byval as DWORD, byval as D3DGAMMARAMP ptr)
	GetGammaRamp as sub(byval as IDirect3DDevice9 ptr, byval as UINT, byval as D3DGAMMARAMP ptr)
	CreateTexture as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as UINT, byval as UINT, byval as DWORD, byval as D3DFORMAT, byval as D3DPOOL, byval as IDirect3DTexture9_ ptr ptr, byval as HANDLE ptr) as HRESULT
	CreateVolumeTexture as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as UINT, byval as UINT, byval as UINT, byval as DWORD, byval as D3DFORMAT, byval as D3DPOOL, byval as IDirect3DVolumeTexture9_ ptr ptr, byval as HANDLE ptr) as HRESULT
	CreateCubeTexture as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as UINT, byval as DWORD, byval as D3DFORMAT, byval as D3DPOOL, byval as IDirect3DCubeTexture9_ ptr ptr, byval as HANDLE ptr) as HRESULT
	CreateVertexBuffer as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as DWORD, byval as DWORD, byval as D3DPOOL, byval as IDirect3DVertexBuffer9_ ptr ptr, byval as HANDLE ptr) as HRESULT
	CreateIndexBuffer as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as DWORD, byval as D3DFORMAT, byval as D3DPOOL, byval as IDirect3DIndexBuffer9_ ptr ptr, byval as HANDLE ptr) as HRESULT
	CreateRenderTarget as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as UINT, byval as D3DFORMAT, byval as D3DMULTISAMPLE_TYPE, byval as DWORD, byval as BOOL, byval as IDirect3DSurface9_ ptr ptr, byval as HANDLE ptr) as HRESULT
	CreateDepthStencilSurface as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as UINT, byval as D3DFORMAT, byval as D3DMULTISAMPLE_TYPE, byval as DWORD, byval as BOOL, byval as IDirect3DSurface9_ ptr ptr, byval as HANDLE ptr) as HRESULT
	UpdateSurface as function(byval as IDirect3DDevice9 ptr, byval as IDirect3DSurface9_ ptr, byval as RECT ptr, byval as IDirect3DSurface9_ ptr, byval as POINT ptr) as HRESULT
	UpdateTexture as function(byval as IDirect3DDevice9 ptr, byval as IDirect3DBaseTexture9_ ptr, byval as IDirect3DBaseTexture9_ ptr) as HRESULT
	GetRenderTargetData as function(byval as IDirect3DDevice9 ptr, byval as IDirect3DSurface9_ ptr, byval as IDirect3DSurface9_ ptr) as HRESULT
	GetFrontBufferData as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as IDirect3DSurface9_ ptr) as HRESULT
	StretchRect as function(byval as IDirect3DDevice9 ptr, byval as IDirect3DSurface9_ ptr, byval as RECT ptr, byval as IDirect3DSurface9_ ptr, byval as RECT ptr, byval as D3DTEXTUREFILTERTYPE) as HRESULT
	ColorFill as function(byval as IDirect3DDevice9 ptr, byval as IDirect3DSurface9_ ptr, byval as RECT ptr, byval as D3DCOLOR) as HRESULT
	CreateOffscreenPlainSurface as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as UINT, byval as D3DFORMAT, byval as D3DPOOL, byval as IDirect3DSurface9_ ptr ptr, byval as HANDLE ptr) as HRESULT
	SetRenderTarget as function(byval as IDirect3DDevice9 ptr, byval as DWORD, byval as IDirect3DSurface9_ ptr) as HRESULT
	GetRenderTarget as function(byval as IDirect3DDevice9 ptr, byval as DWORD, byval as IDirect3DSurface9_ ptr ptr) as HRESULT
	SetDepthStencilSurface as function(byval as IDirect3DDevice9 ptr, byval as IDirect3DSurface9_ ptr) as HRESULT
	GetDepthStencilSurface as function(byval as IDirect3DDevice9 ptr, byval as IDirect3DSurface9_ ptr ptr) as HRESULT
	BeginScene as function(byval as IDirect3DDevice9 ptr) as HRESULT
	EndScene as function(byval as IDirect3DDevice9 ptr) as HRESULT
	Clear as function(byval as IDirect3DDevice9 ptr, byval as DWORD, byval as D3DRECT ptr, byval as DWORD, byval as D3DCOLOR, byval as single, byval as DWORD) as HRESULT
	SetTransform as function(byval as IDirect3DDevice9 ptr, byval as D3DTRANSFORMSTATETYPE, byval as D3DMATRIX ptr) as HRESULT
	GetTransform as function(byval as IDirect3DDevice9 ptr, byval as D3DTRANSFORMSTATETYPE, byval as D3DMATRIX ptr) as HRESULT
	MultiplyTransform as function(byval as IDirect3DDevice9 ptr, byval as D3DTRANSFORMSTATETYPE, byval as D3DMATRIX ptr) as HRESULT
	SetViewport as function(byval as IDirect3DDevice9 ptr, byval as D3DVIEWPORT9 ptr) as HRESULT
	GetViewport as function(byval as IDirect3DDevice9 ptr, byval as D3DVIEWPORT9 ptr) as HRESULT
	SetMaterial as function(byval as IDirect3DDevice9 ptr, byval as D3DMATERIAL9 ptr) as HRESULT
	GetMaterial as function(byval as IDirect3DDevice9 ptr, byval as D3DMATERIAL9 ptr) as HRESULT
	SetLight as function(byval as IDirect3DDevice9 ptr, byval as DWORD, byval as D3DLIGHT9 ptr) as HRESULT
	GetLight as function(byval as IDirect3DDevice9 ptr, byval as DWORD, byval as D3DLIGHT9 ptr) as HRESULT
	LightEnable as function(byval as IDirect3DDevice9 ptr, byval as DWORD, byval as BOOL) as HRESULT
	GetLightEnable as function(byval as IDirect3DDevice9 ptr, byval as DWORD, byval as BOOL ptr) as HRESULT
	SetClipPlane as function(byval as IDirect3DDevice9 ptr, byval as DWORD, byval as single ptr) as HRESULT
	GetClipPlane as function(byval as IDirect3DDevice9 ptr, byval as DWORD, byval as single ptr) as HRESULT
	SetRenderState as function(byval as IDirect3DDevice9 ptr, byval as D3DRENDERSTATETYPE, byval as DWORD) as HRESULT
	GetRenderState as function(byval as IDirect3DDevice9 ptr, byval as D3DRENDERSTATETYPE, byval as DWORD ptr) as HRESULT
	CreateStateBlock as function(byval as IDirect3DDevice9 ptr, byval as D3DSTATEBLOCKTYPE, byval as IDirect3DStateBlock9_ ptr ptr) as HRESULT
	BeginStateBlock as function(byval as IDirect3DDevice9 ptr) as HRESULT
	EndStateBlock as function(byval as IDirect3DDevice9 ptr, byval as IDirect3DStateBlock9_ ptr ptr) as HRESULT
	SetClipStatus as function(byval as IDirect3DDevice9 ptr, byval as D3DCLIPSTATUS9 ptr) as HRESULT
	GetClipStatus as function(byval as IDirect3DDevice9 ptr, byval as D3DCLIPSTATUS9 ptr) as HRESULT
	GetTexture as function(byval as IDirect3DDevice9 ptr, byval as DWORD, byval as IDirect3DBaseTexture9_ ptr ptr) as HRESULT
	SetTexture as function(byval as IDirect3DDevice9 ptr, byval as DWORD, byval as IDirect3DBaseTexture9_ ptr) as HRESULT
	GetTextureStageState as function(byval as IDirect3DDevice9 ptr, byval as DWORD, byval as D3DTEXTURESTAGESTATETYPE, byval as DWORD ptr) as HRESULT
	SetTextureStageState as function(byval as IDirect3DDevice9 ptr, byval as DWORD, byval as D3DTEXTURESTAGESTATETYPE, byval as DWORD) as HRESULT
	GetSamplerState as function(byval as IDirect3DDevice9 ptr, byval as DWORD, byval as D3DSAMPLERSTATETYPE, byval as DWORD ptr) as HRESULT
	SetSamplerState as function(byval as IDirect3DDevice9 ptr, byval as DWORD, byval as D3DSAMPLERSTATETYPE, byval as DWORD) as HRESULT
	ValidateDevice as function(byval as IDirect3DDevice9 ptr, byval as DWORD ptr) as HRESULT
	SetPaletteEntries as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as PALETTEENTRY ptr) as HRESULT
	GetPaletteEntries as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as PALETTEENTRY ptr) as HRESULT
	SetCurrentTexturePalette as function(byval as IDirect3DDevice9 ptr, byval as UINT) as HRESULT
	GetCurrentTexturePalette as function(byval as IDirect3DDevice9 ptr, byval as UINT ptr) as HRESULT
	SetScissorRect as function(byval as IDirect3DDevice9 ptr, byval as RECT ptr) as HRESULT
	GetScissorRect as function(byval as IDirect3DDevice9 ptr, byval as RECT ptr) as HRESULT
	SetSoftwareVertexProcessing as function(byval as IDirect3DDevice9 ptr, byval as BOOL) as HRESULT
	GetSoftwareVertexProcessing as function(byval as IDirect3DDevice9 ptr) as BOOL
	SetNPatchMode as function(byval as IDirect3DDevice9 ptr, byval as single) as HRESULT
	GetNPatchMode as function(byval as IDirect3DDevice9 ptr) as single
	DrawPrimitive as function(byval as IDirect3DDevice9 ptr, byval as D3DPRIMITIVETYPE, byval as UINT, byval as UINT) as HRESULT
	DrawIndexedPrimitive as function(byval as IDirect3DDevice9 ptr, byval as D3DPRIMITIVETYPE, byval as INT_, byval as UINT, byval as UINT, byval as UINT, byval as UINT) as HRESULT
	DrawPrimitiveUP as function(byval as IDirect3DDevice9 ptr, byval as D3DPRIMITIVETYPE, byval as UINT, byval as any ptr, byval as UINT) as HRESULT
	DrawIndexedPrimitiveUP as function(byval as IDirect3DDevice9 ptr, byval as D3DPRIMITIVETYPE, byval as UINT, byval as UINT, byval as UINT, byval as any ptr, byval as D3DFORMAT, byval as any ptr, byval as UINT) as HRESULT
	ProcessVertices as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as UINT, byval as UINT, byval as IDirect3DVertexBuffer9_ ptr, byval as IDirect3DVertexDeclaration9_ ptr, byval as DWORD) as HRESULT
	CreateVertexDeclaration as function(byval as IDirect3DDevice9 ptr, byval as D3DVERTEXELEMENT9 ptr, byval as IDirect3DVertexDeclaration9_ ptr ptr) as HRESULT
	SetVertexDeclaration as function(byval as IDirect3DDevice9 ptr, byval as IDirect3DVertexDeclaration9_ ptr) as HRESULT
	GetVertexDeclaration as function(byval as IDirect3DDevice9 ptr, byval as IDirect3DVertexDeclaration9_ ptr ptr) as HRESULT
	SetFVF as function(byval as IDirect3DDevice9 ptr, byval as DWORD) as HRESULT
	GetFVF as function(byval as IDirect3DDevice9 ptr, byval as DWORD ptr) as HRESULT
	CreateVertexShader as function(byval as IDirect3DDevice9 ptr, byval as DWORD ptr, byval as IDirect3DVertexShader9_ ptr ptr) as HRESULT
	SetVertexShader as function(byval as IDirect3DDevice9 ptr, byval as IDirect3DVertexShader9_ ptr) as HRESULT
	GetVertexShader as function(byval as IDirect3DDevice9 ptr, byval as IDirect3DVertexShader9_ ptr ptr) as HRESULT
	SetVertexShaderConstantF as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as single ptr, byval as UINT) as HRESULT
	GetVertexShaderConstantF as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as single ptr, byval as UINT) as HRESULT
	SetVertexShaderConstantI as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as integer ptr, byval as UINT) as HRESULT
	GetVertexShaderConstantI as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as integer ptr, byval as UINT) as HRESULT
	SetVertexShaderConstantB as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as BOOL ptr, byval as UINT) as HRESULT
	GetVertexShaderConstantB as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as BOOL ptr, byval as UINT) as HRESULT
	SetStreamSource as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as IDirect3DVertexBuffer9_ ptr, byval as UINT, byval as UINT) as HRESULT
	GetStreamSource as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as IDirect3DVertexBuffer9_ ptr ptr, byval as UINT ptr, byval as UINT ptr) as HRESULT
	SetStreamSourceFreq as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as UINT) as HRESULT
	GetStreamSourceFreq as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as UINT ptr) as HRESULT
	SetIndices as function(byval as IDirect3DDevice9 ptr, byval as IDirect3DIndexBuffer9_ ptr) as HRESULT
	GetIndices as function(byval as IDirect3DDevice9 ptr, byval as IDirect3DIndexBuffer9_ ptr ptr) as HRESULT
	CreatePixelShader as function(byval as IDirect3DDevice9 ptr, byval as DWORD ptr, byval as IDirect3DPixelShader9_ ptr ptr) as HRESULT
	SetPixelShader as function(byval as IDirect3DDevice9 ptr, byval as IDirect3DPixelShader9_ ptr) as HRESULT
	GetPixelShader as function(byval as IDirect3DDevice9 ptr, byval as IDirect3DPixelShader9_ ptr ptr) as HRESULT
	SetPixelShaderConstantF as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as single ptr, byval as UINT) as HRESULT
	GetPixelShaderConstantF as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as single ptr, byval as UINT) as HRESULT
	SetPixelShaderConstantI as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as integer ptr, byval as UINT) as HRESULT
	GetPixelShaderConstantI as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as integer ptr, byval as UINT) as HRESULT
	SetPixelShaderConstantB as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as BOOL ptr, byval as UINT) as HRESULT
	GetPixelShaderConstantB as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as BOOL ptr, byval as UINT) as HRESULT
	DrawRectPatch as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as single ptr, byval as D3DRECTPATCH_INFO ptr) as HRESULT
	DrawTriPatch as function(byval as IDirect3DDevice9 ptr, byval as UINT, byval as single ptr, byval as D3DTRIPATCH_INFO ptr) as HRESULT
	DeletePatch as function(byval as IDirect3DDevice9 ptr, byval as UINT) as HRESULT
	CreateQuery as function(byval as IDirect3DDevice9 ptr, byval as D3DQUERYTYPE, byval as IDirect3DQuery9_ ptr ptr) as HRESULT
end type

type LPDIRECT3DDEVICE9 as IDirect3DDevice9 ptr
type PDIRECT3DDEVICE9 as IDirect3DDevice9 ptr

#define IDirect3DDevice9_QueryInterface(p,a,b)	(p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3DDevice9_AddRef(p)	(p)->lpVtbl->AddRef(p)
#define IDirect3DDevice9_Release(p)	(p)->lpVtbl->Release(p)
#define IDirect3DDevice9_TestCooperativeLevel(p)	(p)->lpVtbl->TestCooperativeLevel(p)
#define IDirect3DDevice9_GetAvailableTextureMem(p)	(p)->lpVtbl->GetAvailableTextureMem(p)
#define IDirect3DDevice9_EvictManagedResources(p)	(p)->lpVtbl->EvictManagedResources(p)
#define IDirect3DDevice9_GetDirect3D(p,a)	(p)->lpVtbl->GetDirect3D(p,a)
#define IDirect3DDevice9_GetDeviceCaps(p,a)	(p)->lpVtbl->GetDeviceCaps(p,a)
#define IDirect3DDevice9_GetDisplayMode(p,a,b)	(p)->lpVtbl->GetDisplayMode(p,a,b)
#define IDirect3DDevice9_GetCreationParameters(p,a)	(p)->lpVtbl->GetCreationParameters(p,a)
#define IDirect3DDevice9_SetCursorProperties(p,a,b,c)	(p)->lpVtbl->SetCursorProperties(p,a,b,c)
#define IDirect3DDevice9_SetCursorPosition(p,a,b,c)	(p)->lpVtbl->SetCursorPosition(p,a,b,c)
#define IDirect3DDevice9_ShowCursor(p,a)	(p)->lpVtbl->ShowCursor(p,a)
#define IDirect3DDevice9_CreateAdditionalSwapChain(p,a,b)	(p)->lpVtbl->CreateAdditionalSwapChain(p,a,b)
#define IDirect3DDevice9_GetSwapChain(p,a,b)	(p)->lpVtbl->GetSwapChain(p,a,b)
#define IDirect3DDevice9_GetNumberOfSwapChains(p)	(p)->lpVtbl->GetNumberOfSwapChains(p)
#define IDirect3DDevice9_Reset(p,a)	(p)->lpVtbl->Reset(p,a)
#define IDirect3DDevice9_Present(p,a,b,c,d)	(p)->lpVtbl->Present(p,a,b,c,d)
#define IDirect3DDevice9_GetBackBuffer(p,a,b,c,d)	(p)->lpVtbl->GetBackBuffer(p,a,b,c,d)
#define IDirect3DDevice9_GetRasterStatus(p,a,b)	(p)->lpVtbl->GetRasterStatus(p,a,b)
#define IDirect3DDevice9_SetDialogBoxMode(p,a)	(p)->lpVtbl->SetDialogBoxMode(p,a)
#define IDirect3DDevice9_SetGammaRamp(p,a,b,c)	(p)->lpVtbl->SetGammaRamp(p,a,b,c)
#define IDirect3DDevice9_GetGammaRamp(p,a,b)	(p)->lpVtbl->GetGammaRamp(p,a,b)
#define IDirect3DDevice9_CreateTexture(p,a,b,c,d,e,f,g,h)	(p)->lpVtbl->CreateTexture(p,a,b,c,d,e,f,g,h)
#define IDirect3DDevice9_CreateVolumeTexture(p,a,b,c,d,e,f,g,h,i)	(p)->lpVtbl->CreateVolumeTexture(p,a,b,c,d,e,f,g,h,i)
#define IDirect3DDevice9_CreateCubeTexture(p,a,b,c,d,e,f,g)	(p)->lpVtbl->CreateCubeTexture(p,a,b,c,d,e,f,g)
#define IDirect3DDevice9_CreateVertexBuffer(p,a,b,c,d,e,f)	(p)->lpVtbl->CreateVertexBuffer(p,a,b,c,d,e,f)
#define IDirect3DDevice9_CreateIndexBuffer(p,a,b,c,d,e,f)	(p)->lpVtbl->CreateIndexBuffer(p,a,b,c,d,e,f)
#define IDirect3DDevice9_CreateRenderTarget(p,a,b,c,d,e,f,g,h)	(p)->lpVtbl->CreateRenderTarget(p,a,b,c,d,e,f,g,h)
#define IDirect3DDevice9_CreateDepthStencilSurface(p,a,b,c,d,e,f,g,h)	(p)->lpVtbl->CreateDepthStencilSurface(p,a,b,c,d,e,f,g,h)
#define IDirect3DDevice9_UpdateSurface(p,a,b,c,d)	(p)->lpVtbl->UpdateSurface(p,a,b,c,d)
#define IDirect3DDevice9_UpdateTexture(p,a,b)	(p)->lpVtbl->UpdateTexture(p,a,b)
#define IDirect3DDevice9_GetRenderTargetData(p,a,b)	(p)->lpVtbl->GetRenderTargetData(p,a,b)
#define IDirect3DDevice9_GetFrontBufferData(p,a,b)	(p)->lpVtbl->GetFrontBufferData(p,a,b)
#define IDirect3DDevice9_StretchRect(p,a,b,c,d,e)	(p)->lpVtbl->StretchRect(p,a,b,c,d,e)
#define IDirect3DDevice9_ColorFill(p,a,b,c)	(p)->lpVtbl->ColorFill(p,a,b,c)
#define IDirect3DDevice9_CreateOffscreenPlainSurface(p,a,b,c,d,e,f)	(p)->lpVtbl->CreateOffscreenPlainSurface(p,a,b,c,d,e,f)
#define IDirect3DDevice9_SetRenderTarget(p,a,b)	(p)->lpVtbl->SetRenderTarget(p,a,b)
#define IDirect3DDevice9_GetRenderTarget(p,a,b)	(p)->lpVtbl->GetRenderTarget(p,a,b)
#define IDirect3DDevice9_SetDepthStencilSurface(p,a)	(p)->lpVtbl->SetDepthStencilSurface(p,a)
#define IDirect3DDevice9_GetDepthStencilSurface(p,a)	(p)->lpVtbl->GetDepthStencilSurface(p,a)
#define IDirect3DDevice9_BeginScene(p)	(p)->lpVtbl->BeginScene(p)
#define IDirect3DDevice9_EndScene(p)	(p)->lpVtbl->EndScene(p)
#define IDirect3DDevice9_Clear(p,a,b,c,d,e,f)	(p)->lpVtbl->Clear(p,a,b,c,d,e,f)
#define IDirect3DDevice9_SetTransform(p,a,b)	(p)->lpVtbl->SetTransform(p,a,b)
#define IDirect3DDevice9_GetTransform(p,a,b)	(p)->lpVtbl->GetTransform(p,a,b)
#define IDirect3DDevice9_MultiplyTransform(p,a,b)	(p)->lpVtbl->MultiplyTransform(p,a,b)
#define IDirect3DDevice9_SetViewport(p,a)	(p)->lpVtbl->SetViewport(p,a)
#define IDirect3DDevice9_GetViewport(p,a)	(p)->lpVtbl->GetViewport(p,a)
#define IDirect3DDevice9_SetMaterial(p,a)	(p)->lpVtbl->SetMaterial(p,a)
#define IDirect3DDevice9_GetMaterial(p,a)	(p)->lpVtbl->GetMaterial(p,a)
#define IDirect3DDevice9_SetLight(p,a,b)	(p)->lpVtbl->SetLight(p,a,b)
#define IDirect3DDevice9_GetLight(p,a,b)	(p)->lpVtbl->GetLight(p,a,b)
#define IDirect3DDevice9_LightEnable(p,a,b)	(p)->lpVtbl->LightEnable(p,a,b)
#define IDirect3DDevice9_GetLightEnable(p,a,b)	(p)->lpVtbl->GetLightEnable(p,a,b)
#define IDirect3DDevice9_SetClipPlane(p,a,b)	(p)->lpVtbl->SetClipPlane(p,a,b)
#define IDirect3DDevice9_GetClipPlane(p,a,b)	(p)->lpVtbl->GetClipPlane(p,a,b)
#define IDirect3DDevice9_SetRenderState(p,a,b)	(p)->lpVtbl->SetRenderState(p,a,b)
#define IDirect3DDevice9_GetRenderState(p,a,b)	(p)->lpVtbl->GetRenderState(p,a,b)
#define IDirect3DDevice9_CreateStateBlock(p,a,b)	(p)->lpVtbl->CreateStateBlock(p,a,b)
#define IDirect3DDevice9_BeginStateBlock(p)	(p)->lpVtbl->BeginStateBlock(p)
#define IDirect3DDevice9_EndStateBlock(p,a)	(p)->lpVtbl->EndStateBlock(p,a)
#define IDirect3DDevice9_SetClipStatus(p,a)	(p)->lpVtbl->SetClipStatus(p,a)
#define IDirect3DDevice9_GetClipStatus(p,a)	(p)->lpVtbl->GetClipStatus(p,a)
#define IDirect3DDevice9_GetTexture(p,a,b)	(p)->lpVtbl->GetTexture(p,a,b)
#define IDirect3DDevice9_SetTexture(p,a,b)	(p)->lpVtbl->SetTexture(p,a,b)
#define IDirect3DDevice9_GetTextureStageState(p,a,b,c)	(p)->lpVtbl->GetTextureStageState(p,a,b,c)
#define IDirect3DDevice9_SetTextureStageState(p,a,b,c)	(p)->lpVtbl->SetTextureStageState(p,a,b,c)
#define IDirect3DDevice9_GetSamplerState(p,a,b,c)	(p)->lpVtbl->GetSamplerState(p,a,b,c)
#define IDirect3DDevice9_SetSamplerState(p,a,b,c)	(p)->lpVtbl->SetSamplerState(p,a,b,c)
#define IDirect3DDevice9_ValidateDevice(p,a)	(p)->lpVtbl->ValidateDevice(p,a)
#define IDirect3DDevice9_SetPaletteEntries(p,a,b)	(p)->lpVtbl->SetPaletteEntries(p,a,b)
#define IDirect3DDevice9_GetPaletteEntries(p,a,b)	(p)->lpVtbl->GetPaletteEntries(p,a,b)
#define IDirect3DDevice9_SetCurrentTexturePalette(p,a)	(p)->lpVtbl->SetCurrentTexturePalette(p,a)
#define IDirect3DDevice9_GetCurrentTexturePalette(p,a)	(p)->lpVtbl->GetCurrentTexturePalette(p,a)
#define IDirect3DDevice9_SetScissorRect(p,a)	(p)->lpVtbl->SetScissorRect(p,a)
#define IDirect3DDevice9_GetScissorRect(p,a)	(p)->lpVtbl->GetScissorRect(p,a)
#define IDirect3DDevice9_SetSoftwareVertexProcessing(p,a)	(p)->lpVtbl->SetSoftwareVertexProcessing(p,a)
#define IDirect3DDevice9_GetSoftwareVertexProcessing(p)	(p)->lpVtbl->GetSoftwareVertexProcessing(p)
#define IDirect3DDevice9_SetNPatchMode(p,a)	(p)->lpVtbl->SetNPatchMode(p,a)
#define IDirect3DDevice9_GetNPatchMode(p)	(p)->lpVtbl->GetNPatchMode(p)
#define IDirect3DDevice9_DrawPrimitive(p,a,b,c)	(p)->lpVtbl->DrawPrimitive(p,a,b,c)
#define IDirect3DDevice9_DrawIndexedPrimitive(p,a,b,c,d,e,f)	(p)->lpVtbl->DrawIndexedPrimitive(p,a,b,c,d,e,f)
#define IDirect3DDevice9_DrawPrimitiveUP(p,a,b,c,d)	(p)->lpVtbl->DrawPrimitiveUP(p,a,b,c,d)
#define IDirect3DDevice9_DrawIndexedPrimitiveUP(p,a,b,c,d,e,f,g,h)	(p)->lpVtbl->DrawIndexedPrimitiveUP(p,a,b,c,d,e,f,g,h)
#define IDirect3DDevice9_ProcessVertices(p,a,b,c,d,e,f)	(p)->lpVtbl->ProcessVertices(p,a,b,c,d,e,f)
#define IDirect3DDevice9_CreateVertexDeclaration(p,a,b)	(p)->lpVtbl->CreateVertexDeclaration(p,a,b)
#define IDirect3DDevice9_SetVertexDeclaration(p,a)	(p)->lpVtbl->SetVertexDeclaration(p,a)
#define IDirect3DDevice9_GetVertexDeclaration(p,a)	(p)->lpVtbl->GetVertexDeclaration(p,a)
#define IDirect3DDevice9_SetFVF(p,a)	(p)->lpVtbl->SetFVF(p,a)
#define IDirect3DDevice9_GetFVF(p,a)	(p)->lpVtbl->GetFVF(p,a)
#define IDirect3DDevice9_CreateVertexShader(p,a,b)	(p)->lpVtbl->CreateVertexShader(p,a,b)
#define IDirect3DDevice9_SetVertexShader(p,a)	(p)->lpVtbl->SetVertexShader(p,a)
#define IDirect3DDevice9_GetVertexShader(p,a)	(p)->lpVtbl->GetVertexShader(p,a)
#define IDirect3DDevice9_SetVertexShaderConstantF(p,a,b,c)	(p)->lpVtbl->SetVertexShaderConstantF(p,a,b,c)
#define IDirect3DDevice9_GetVertexShaderConstantF(p,a,b,c)	(p)->lpVtbl->GetVertexShaderConstantF(p,a,b,c)
#define IDirect3DDevice9_SetVertexShaderConstantI(p,a,b,c)	(p)->lpVtbl->SetVertexShaderConstantI(p,a,b,c)
#define IDirect3DDevice9_GetVertexShaderConstantI(p,a,b,c)	(p)->lpVtbl->GetVertexShaderConstantI(p,a,b,c)
#define IDirect3DDevice9_SetVertexShaderConstantB(p,a,b,c)	(p)->lpVtbl->SetVertexShaderConstantB(p,a,b,c)
#define IDirect3DDevice9_GetVertexShaderConstantB(p,a,b,c)	(p)->lpVtbl->GetVertexShaderConstantB(p,a,b,c)
#define IDirect3DDevice9_SetStreamSource(p,a,b,c,d)	(p)->lpVtbl->SetStreamSource(p,a,b,c,d)
#define IDirect3DDevice9_GetStreamSource(p,a,b,c,d)	(p)->lpVtbl->GetStreamSource(p,a,b,c,d)
#define IDirect3DDevice9_SetStreamSourceFreq(p,a,b)	(p)->lpVtbl->SetStreamSourceFreq(p,a,b)
#define IDirect3DDevice9_GetStreamSourceFreq(p,a,b)	(p)->lpVtbl->GetStreamSourceFreq(p,a,b)
#define IDirect3DDevice9_SetIndices(p,a)	(p)->lpVtbl->SetIndices(p,a)
#define IDirect3DDevice9_GetIndices(p,a)	(p)->lpVtbl->GetIndices(p,a)
#define IDirect3DDevice9_CreatePixelShader(p,a,b)	(p)->lpVtbl->CreatePixelShader(p,a,b)
#define IDirect3DDevice9_SetPixelShader(p,a)	(p)->lpVtbl->SetPixelShader(p,a)
#define IDirect3DDevice9_GetPixelShader(p,a)	(p)->lpVtbl->GetPixelShader(p,a)
#define IDirect3DDevice9_SetPixelShaderConstantF(p,a,b,c)	(p)->lpVtbl->SetPixelShaderConstantF(p,a,b,c)
#define IDirect3DDevice9_GetPixelShaderConstantF(p,a,b,c)	(p)->lpVtbl->GetPixelShaderConstantF(p,a,b,c)
#define IDirect3DDevice9_SetPixelShaderConstantI(p,a,b,c)	(p)->lpVtbl->SetPixelShaderConstantI(p,a,b,c)
#define IDirect3DDevice9_GetPixelShaderConstantI(p,a,b,c)	(p)->lpVtbl->GetPixelShaderConstantI(p,a,b,c)
#define IDirect3DDevice9_SetPixelShaderConstantB(p,a,b,c)	(p)->lpVtbl->SetPixelShaderConstantB(p,a,b,c)
#define IDirect3DDevice9_GetPixelShaderConstantB(p,a,b,c)	(p)->lpVtbl->GetPixelShaderConstantB(p,a,b,c)
#define IDirect3DDevice9_DrawRectPatch(p,a,b,c)	(p)->lpVtbl->DrawRectPatch(p,a,b,c)
#define IDirect3DDevice9_DrawTriPatch(p,a,b,c)	(p)->lpVtbl->DrawTriPatch(p,a,b,c)
#define IDirect3DDevice9_DeletePatch(p,a)	(p)->lpVtbl->DeletePatch(p,a)
#define IDirect3DDevice9_CreateQuery(p,a,b)	(p)->lpVtbl->CreateQuery(p,a,b)

type IDirect3DVolume9Vtbl_ as IDirect3DVolume9Vtbl

type IDirect3DVolume9
	lpVtbl as IDirect3DVolume9Vtbl_ ptr
end type

type IDirect3DVolume9Vtbl
	QueryInterface as function(byval as IDirect3DVolume9 ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DVolume9 ptr) as ULONG
	Release as function(byval as IDirect3DVolume9 ptr) as ULONG
	GetDevice as function(byval as IDirect3DVolume9 ptr, byval as IDirect3DDevice9 ptr ptr) as HRESULT
	SetPrivateData as function(byval as IDirect3DVolume9 ptr, byval as GUID ptr, byval as any ptr, byval as DWORD, byval as DWORD) as HRESULT
	GetPrivateData as function(byval as IDirect3DVolume9 ptr, byval as GUID ptr, byval as any ptr, byval as DWORD ptr) as HRESULT
	FreePrivateData as function(byval as IDirect3DVolume9 ptr, byval as GUID ptr) as HRESULT
	GetContainer as function(byval as IDirect3DVolume9 ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	GetDesc as function(byval as IDirect3DVolume9 ptr, byval as D3DVOLUME_DESC ptr) as HRESULT
	LockBox as function(byval as IDirect3DVolume9 ptr, byval as D3DLOCKED_BOX ptr, byval as D3DBOX ptr, byval as DWORD) as HRESULT
	UnlockBox as function(byval as IDirect3DVolume9 ptr) as HRESULT
end type

type LPDIRECT3DVOLUME9 as IDirect3DVolume9 ptr
type PDIRECT3DVOLUME9 as IDirect3DVolume9 ptr

#define IDirect3DVolume9_QueryInterface(p,a,b)	(p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3DVolume9_AddRef(p)	(p)->lpVtbl->AddRef(p)
#define IDirect3DVolume9_Release(p)	(p)->lpVtbl->Release(p)
#define IDirect3DVolume9_GetDevice(p,a)	(p)->lpVtbl->GetDevice(p,a)
#define IDirect3DVolume9_SetPrivateData(p,a,b,c,d)	(p)->lpVtbl->SetPrivateData(p,a,b,c,d)
#define IDirect3DVolume9_GetPrivateData(p,a,b,c)	(p)->lpVtbl->GetPrivateData(p,a,b,c)
#define IDirect3DVolume9_FreePrivateData(p,a)	(p)->lpVtbl->FreePrivateData(p,a)
#define IDirect3DVolume9_GetContainer(p,a,b)	(p)->lpVtbl->GetContainer(p,a,b)
#define IDirect3DVolume9_GetDesc(p,a)	(p)->lpVtbl->GetDesc(p,a)
#define IDirect3DVolume9_LockBox(p,a,b,c)	(p)->lpVtbl->LockBox(p,a,b,c)
#define IDirect3DVolume9_UnlockBox(p)	(p)->lpVtbl->UnlockBox(p)

type IDirect3DSwapChain9Vtbl_ as IDirect3DSwapChain9Vtbl

type IDirect3DSwapChain9
	lpVtbl as IDirect3DSwapChain9Vtbl_ ptr
end type

type IDirect3DSwapChain9Vtbl
	QueryInterface as function(byval as IDirect3DSwapChain9 ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DSwapChain9 ptr) as ULONG
	Release as function(byval as IDirect3DSwapChain9 ptr) as ULONG
	Present as function(byval as IDirect3DSwapChain9 ptr, byval as RECT ptr, byval as RECT ptr, byval as HWND, byval as RGNDATA ptr, byval as DWORD) as HRESULT
	GetFrontBufferData as function(byval as IDirect3DSwapChain9 ptr, byval as IDirect3DSurface9_ ptr) as HRESULT
	GetBackBuffer as function(byval as IDirect3DSwapChain9 ptr, byval as UINT, byval as D3DBACKBUFFER_TYPE, byval as IDirect3DSurface9_ ptr ptr) as HRESULT
	GetRasterStatus as function(byval as IDirect3DSwapChain9 ptr, byval as D3DRASTER_STATUS ptr) as HRESULT
	GetDisplayMode as function(byval as IDirect3DSwapChain9 ptr, byval as D3DDISPLAYMODE ptr) as HRESULT
	GetDevice as function(byval as IDirect3DSwapChain9 ptr, byval as IDirect3DDevice9 ptr ptr) as HRESULT
	GetPresentParameters as function(byval as IDirect3DSwapChain9 ptr, byval as D3DPRESENT_PARAMETERS ptr) as HRESULT
end type

type LPDIRECT3DSWAPCHAIN9 as IDirect3DSwapChain9 ptr
type PDIRECT3DSWAPCHAIN9 as IDirect3DSwapChain9 ptr

#define IDirect3DSwapChain9_QueryInterface(p,a,b)	(p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3DSwapChain9_AddRef(p)	(p)->lpVtbl->AddRef(p)
#define IDirect3DSwapChain9_Release(p)	(p)->lpVtbl->Release(p)
#define IDirect3DSwapChain9_Present(p,a,b,c,d,e)	(p)->lpVtbl->Present(p,a,b,c,d,e)
#define IDirect3DSwapChain9_GetFrontBufferData(p,a)	(p)->lpVtbl->GetFrontBufferData(p,a)
#define IDirect3DSwapChain9_GetBackBuffer(p,a,b,c)	(p)->lpVtbl->GetBackBuffer(p,a,b,c)
#define IDirect3DSwapChain9_GetRasterStatus(p,a)	(p)->lpVtbl->GetRasterStatus(p,a)
#define IDirect3DSwapChain9_GetDisplayMode(p,a)	(p)->lpVtbl->GetDisplayMode(p,a)
#define IDirect3DSwapChain9_GetDevice(p,a)	(p)->lpVtbl->GetDevice(p,a)
#define IDirect3DSwapChain9_GetPresentParameters(p,a)	(p)->lpVtbl->GetPresentParameters(p,a)

type IDirect3DResource9Vtbl_ as IDirect3DResource9Vtbl

type IDirect3DResource9
	lpVtbl as IDirect3DResource9Vtbl_ ptr
end type

type IDirect3DResource9Vtbl
	QueryInterface as function(byval as IDirect3DResource9 ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DResource9 ptr) as ULONG
	Release as function(byval as IDirect3DResource9 ptr) as ULONG
	GetDevice as function(byval as IDirect3DResource9 ptr, byval as IDirect3DDevice9 ptr ptr) as HRESULT
	SetPrivateData as function(byval as IDirect3DResource9 ptr, byval as GUID ptr, byval as any ptr, byval as DWORD, byval as DWORD) as HRESULT
	GetPrivateData as function(byval as IDirect3DResource9 ptr, byval as GUID ptr, byval as any ptr, byval as DWORD ptr) as HRESULT
	FreePrivateData as function(byval as IDirect3DResource9 ptr, byval as GUID ptr) as HRESULT
	SetPriority as function(byval as IDirect3DResource9 ptr, byval as DWORD) as DWORD
	GetPriority as function(byval as IDirect3DResource9 ptr) as DWORD
	PreLoad as sub(byval as IDirect3DResource9 ptr)
	GetType as function(byval as IDirect3DResource9 ptr) as D3DRESOURCETYPE
end type

type LPDIRECT3DRESOURCE9 as IDirect3DResource9 ptr
type PDIRECT3DRESOURCE9 as IDirect3DResource9 ptr

#define IDirect3DResource9_QueryInterface(p,a,b)	(p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3DResource9_AddRef(p)	(p)->lpVtbl->AddRef(p)
#define IDirect3DResource9_Release(p)	(p)->lpVtbl->Release(p)
#define IDirect3DResource9_GetDevice(p,a)	(p)->lpVtbl->GetDevice(p,a)
#define IDirect3DResource9_SetPrivateData(p,a,b,c,d)	(p)->lpVtbl->SetPrivateData(p,a,b,c,d)
#define IDirect3DResource9_GetPrivateData(p,a,b,c)	(p)->lpVtbl->GetPrivateData(p,a,b,c)
#define IDirect3DResource9_FreePrivateData(p,a)	(p)->lpVtbl->FreePrivateData(p,a)
#define IDirect3DResource9_SetPriority(p,a)	(p)->lpVtbl->SetPriority(p,a)
#define IDirect3DResource9_GetPriority(p)	(p)->lpVtbl->GetPriority(p)
#define IDirect3DResource9_PreLoad(p)	(p)->lpVtbl->PreLoad(p)
#define IDirect3DResource9_GetType(p)	(p)->lpVtbl->GetType(p)

type IDirect3DSurface9Vtbl_ as IDirect3DSurface9Vtbl

type IDirect3DSurface9
	lpVtbl as IDirect3DSurface9Vtbl_ ptr
end type

type IDirect3DSurface9Vtbl
	QueryInterface as function(byval as IDirect3DSurface9_ ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DSurface9_ ptr) as ULONG
	Release as function(byval as IDirect3DSurface9_ ptr) as ULONG
	GetDevice as function(byval as IDirect3DSurface9_ ptr, byval as IDirect3DDevice9 ptr ptr) as HRESULT
	SetPrivateData as function(byval as IDirect3DSurface9_ ptr, byval as GUID ptr, byval as any ptr, byval as DWORD, byval as DWORD) as HRESULT
	GetPrivateData as function(byval as IDirect3DSurface9_ ptr, byval as GUID ptr, byval as any ptr, byval as DWORD ptr) as HRESULT
	FreePrivateData as function(byval as IDirect3DSurface9_ ptr, byval as GUID ptr) as HRESULT
	SetPriority as function(byval as IDirect3DSurface9_ ptr, byval as DWORD) as DWORD
	GetPriority as function(byval as IDirect3DSurface9_ ptr) as DWORD
	PreLoad as sub(byval as IDirect3DSurface9_ ptr)
	GetType as function(byval as IDirect3DSurface9_ ptr) as D3DRESOURCETYPE
	GetContainer as function(byval as IDirect3DSurface9_ ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	GetDesc as function(byval as IDirect3DSurface9_ ptr, byval as D3DSURFACE_DESC ptr) as HRESULT
	LockRect as function(byval as IDirect3DSurface9_ ptr, byval as D3DLOCKED_RECT ptr, byval as RECT ptr, byval as DWORD) as HRESULT
	UnlockRect as function(byval as IDirect3DSurface9_ ptr) as HRESULT
	GetDC as function(byval as IDirect3DSurface9_ ptr, byval as HDC ptr) as HRESULT
	ReleaseDC as function(byval as IDirect3DSurface9_ ptr, byval as HDC) as HRESULT
end type

type LPDIRECT3DSURFACE9 as IDirect3DSurface9_ ptr
type PDIRECT3DSURFACE9 as IDirect3DSurface9_ ptr

#define IDirect3DSurface9_QueryInterface(p,a,b)	(p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3DSurface9_AddRef(p)	(p)->lpVtbl->AddRef(p)
#define IDirect3DSurface9_Release(p)	(p)->lpVtbl->Release(p)
#define IDirect3DSurface9_GetDevice(p,a)	(p)->lpVtbl->GetDevice(p,a)
#define IDirect3DSurface9_SetPrivateData(p,a,b,c,d)	(p)->lpVtbl->SetPrivateData(p,a,b,c,d)
#define IDirect3DSurface9_GetPrivateData(p,a,b,c)	(p)->lpVtbl->GetPrivateData(p,a,b,c)
#define IDirect3DSurface9_FreePrivateData(p,a)	(p)->lpVtbl->FreePrivateData(p,a)
#define IDirect3DSurface9_SetPriority(p,a)	(p)->lpVtbl->SetPriority(p,a)
#define IDirect3DSurface9_GetPriority(p)	(p)->lpVtbl->GetPriority(p)
#define IDirect3DSurface9_PreLoad(p)	(p)->lpVtbl->PreLoad(p)
#define IDirect3DSurface9_GetType(p)	(p)->lpVtbl->GetType(p)
#define IDirect3DSurface9_GetContainer(p,a,b)	(p)->lpVtbl->GetContainer(p,a,b)
#define IDirect3DSurface9_GetDesc(p,a)	(p)->lpVtbl->GetDesc(p,a)
#define IDirect3DSurface9_LockRect(p,a,b,c)	(p)->lpVtbl->LockRect(p,a,b,c)
#define IDirect3DSurface9_UnlockRect(p)	(p)->lpVtbl->UnlockRect(p)
#define IDirect3DSurface9_GetDC(p,a)	(p)->lpVtbl->GetDC(p,a)
#define IDirect3DSurface9_ReleaseDC(p,a)	(p)->lpVtbl->ReleaseDC(p,a)

type IDirect3DVertexBuffer9Vtbl_ as IDirect3DVertexBuffer9Vtbl

type IDirect3DVertexBuffer9
	lpVtbl as IDirect3DVertexBuffer9Vtbl_ ptr
end type

type IDirect3DVertexBuffer9Vtbl
	QueryInterface as function(byval as IDirect3DVertexBuffer9_ ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DVertexBuffer9_ ptr) as ULONG
	Release as function(byval as IDirect3DVertexBuffer9_ ptr) as ULONG
	GetDevice as function(byval as IDirect3DVertexBuffer9_ ptr, byval as IDirect3DDevice9 ptr ptr) as HRESULT
	SetPrivateData as function(byval as IDirect3DVertexBuffer9_ ptr, byval as GUID ptr, byval as any ptr, byval as DWORD, byval as DWORD) as HRESULT
	GetPrivateData as function(byval as IDirect3DVertexBuffer9_ ptr, byval as GUID ptr, byval as any ptr, byval as DWORD ptr) as HRESULT
	FreePrivateData as function(byval as IDirect3DVertexBuffer9_ ptr, byval as GUID ptr) as HRESULT
	SetPriority as function(byval as IDirect3DVertexBuffer9_ ptr, byval as DWORD) as DWORD
	GetPriority as function(byval as IDirect3DVertexBuffer9_ ptr) as DWORD
	PreLoad as sub(byval as IDirect3DVertexBuffer9_ ptr)
	GetType as function(byval as IDirect3DVertexBuffer9_ ptr) as D3DRESOURCETYPE
	Lock as function(byval as IDirect3DVertexBuffer9_ ptr, byval as UINT, byval as UINT, byval as any ptr ptr, byval as DWORD) as HRESULT
	Unlock as function(byval as IDirect3DVertexBuffer9_ ptr) as HRESULT
	GetDesc as function(byval as IDirect3DVertexBuffer9_ ptr, byval as D3DVERTEXBUFFER_DESC ptr) as HRESULT
end type

type LPDIRECT3DVERTEXBUFFER9 as IDirect3DVertexBuffer9_ ptr
type PDIRECT3DVERTEXBUFFER9 as IDirect3DVertexBuffer9_ ptr

#define IDirect3DVertexBuffer9_QueryInterface(p,a,b)	(p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3DVertexBuffer9_AddRef(p)	(p)->lpVtbl->AddRef(p)
#define IDirect3DVertexBuffer9_Release(p)	(p)->lpVtbl->Release(p)
#define IDirect3DVertexBuffer9_GetDevice(p,a)	(p)->lpVtbl->GetDevice(p,a)
#define IDirect3DVertexBuffer9_SetPrivateData(p,a,b,c,d)	(p)->lpVtbl->SetPrivateData(p,a,b,c,d)
#define IDirect3DVertexBuffer9_GetPrivateData(p,a,b,c)	(p)->lpVtbl->GetPrivateData(p,a,b,c)
#define IDirect3DVertexBuffer9_FreePrivateData(p,a)	(p)->lpVtbl->FreePrivateData(p,a)
#define IDirect3DVertexBuffer9_SetPriority(p,a)	(p)->lpVtbl->SetPriority(p,a)
#define IDirect3DVertexBuffer9_GetPriority(p)	(p)->lpVtbl->GetPriority(p)
#define IDirect3DVertexBuffer9_PreLoad(p)	(p)->lpVtbl->PreLoad(p)
#define IDirect3DVertexBuffer9_GetType(p)	(p)->lpVtbl->GetType(p)
#define IDirect3DVertexBuffer9_Lock(p,a,b,c,d)	(p)->lpVtbl->Lock(p,a,b,c,d)
#define IDirect3DVertexBuffer9_Unlock(p)	(p)->lpVtbl->Unlock(p)
#define IDirect3DVertexBuffer9_GetDesc(p,a)	(p)->lpVtbl->GetDesc(p,a)

type IDirect3DIndexBuffer9Vtbl_ as IDirect3DIndexBuffer9Vtbl

type IDirect3DIndexBuffer9
	lpVtbl as IDirect3DIndexBuffer9Vtbl_ ptr
end type

type IDirect3DIndexBuffer9Vtbl
	QueryInterface as function(byval as IDirect3DIndexBuffer9_ ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DIndexBuffer9_ ptr) as ULONG
	Release as function(byval as IDirect3DIndexBuffer9_ ptr) as ULONG
	GetDevice as function(byval as IDirect3DIndexBuffer9_ ptr, byval as IDirect3DDevice9 ptr ptr) as HRESULT
	SetPrivateData as function(byval as IDirect3DIndexBuffer9_ ptr, byval as GUID ptr, byval as any ptr, byval as DWORD, byval as DWORD) as HRESULT
	GetPrivateData as function(byval as IDirect3DIndexBuffer9_ ptr, byval as GUID ptr, byval as any ptr, byval as DWORD ptr) as HRESULT
	FreePrivateData as function(byval as IDirect3DIndexBuffer9_ ptr, byval as GUID ptr) as HRESULT
	SetPriority as function(byval as IDirect3DIndexBuffer9_ ptr, byval as DWORD) as DWORD
	GetPriority as function(byval as IDirect3DIndexBuffer9_ ptr) as DWORD
	PreLoad as sub(byval as IDirect3DIndexBuffer9_ ptr)
	GetType as function(byval as IDirect3DIndexBuffer9_ ptr) as D3DRESOURCETYPE
	Lock as function(byval as IDirect3DIndexBuffer9_ ptr, byval as UINT, byval as UINT, byval as any ptr ptr, byval as DWORD) as HRESULT
	Unlock as function(byval as IDirect3DIndexBuffer9_ ptr) as HRESULT
	GetDesc as function(byval as IDirect3DIndexBuffer9_ ptr, byval as D3DINDEXBUFFER_DESC ptr) as HRESULT
end type

type LPDIRECT3DINDEXBUFFER9 as IDirect3DIndexBuffer9_ ptr
type PDIRECT3DINDEXBUFFER9 as IDirect3DIndexBuffer9_ ptr

#define IDirect3DIndexBuffer9_QueryInterface(p,a,b)	(p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3DIndexBuffer9_AddRef(p)	(p)->lpVtbl->AddRef(p)
#define IDirect3DIndexBuffer9_Release(p)	(p)->lpVtbl->Release(p)
#define IDirect3DIndexBuffer9_GetDevice(p,a)	(p)->lpVtbl->GetDevice(p,a)
#define IDirect3DIndexBuffer9_SetPrivateData(p,a,b,c,d)	(p)->lpVtbl->SetPrivateData(p,a,b,c,d)
#define IDirect3DIndexBuffer9_GetPrivateData(p,a,b,c)	(p)->lpVtbl->GetPrivateData(p,a,b,c)
#define IDirect3DIndexBuffer9_FreePrivateData(p,a)	(p)->lpVtbl->FreePrivateData(p,a)
#define IDirect3DIndexBuffer9_SetPriority(p,a)	(p)->lpVtbl->SetPriority(p,a)
#define IDirect3DIndexBuffer9_GetPriority(p)	(p)->lpVtbl->GetPriority(p)
#define IDirect3DIndexBuffer9_PreLoad(p)	(p)->lpVtbl->PreLoad(p)
#define IDirect3DIndexBuffer9_GetType(p)	(p)->lpVtbl->GetType(p)
#define IDirect3DIndexBuffer9_Lock(p,a,b,c,d)	(p)->lpVtbl->Lock(p,a,b,c,d)
#define IDirect3DIndexBuffer9_Unlock(p)	(p)->lpVtbl->Unlock(p)
#define IDirect3DIndexBuffer9_GetDesc(p,a)	(p)->lpVtbl->GetDesc(p,a)

type IDirect3DBaseTexture9Vtbl_ as IDirect3DBaseTexture9Vtbl

type IDirect3DBaseTexture9
	lpVtbl as IDirect3DBaseTexture9Vtbl_ ptr
end type

type IDirect3DBaseTexture9Vtbl
	QueryInterface as function(byval as IDirect3DBaseTexture9_ ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DBaseTexture9_ ptr) as ULONG
	Release as function(byval as IDirect3DBaseTexture9_ ptr) as ULONG
	GetDevice as function(byval as IDirect3DBaseTexture9_ ptr, byval as IDirect3DDevice9 ptr ptr) as HRESULT
	SetPrivateData as function(byval as IDirect3DBaseTexture9_ ptr, byval as GUID ptr, byval as any ptr, byval as DWORD, byval as DWORD) as HRESULT
	GetPrivateData as function(byval as IDirect3DBaseTexture9_ ptr, byval as GUID ptr, byval as any ptr, byval as DWORD ptr) as HRESULT
	FreePrivateData as function(byval as IDirect3DBaseTexture9_ ptr, byval as GUID ptr) as HRESULT
	SetPriority as function(byval as IDirect3DBaseTexture9_ ptr, byval as DWORD) as DWORD
	GetPriority as function(byval as IDirect3DBaseTexture9_ ptr) as DWORD
	PreLoad as sub(byval as IDirect3DBaseTexture9_ ptr)
	GetType as function(byval as IDirect3DBaseTexture9_ ptr) as D3DRESOURCETYPE
	SetLOD as function(byval as IDirect3DBaseTexture9_ ptr, byval as DWORD) as DWORD
	GetLOD as function(byval as IDirect3DBaseTexture9_ ptr) as DWORD
	GetLevelCount as function(byval as IDirect3DBaseTexture9_ ptr) as DWORD
	SetAutoGenFilterType as function(byval as IDirect3DBaseTexture9_ ptr, byval as D3DTEXTUREFILTERTYPE) as HRESULT
	GetAutoGenFilterType as function(byval as IDirect3DBaseTexture9_ ptr) as D3DTEXTUREFILTERTYPE
	GenerateMipSubLevels as sub(byval as IDirect3DBaseTexture9_ ptr)
end type

type LPDIRECT3DBASETEXTURE9 as IDirect3DBaseTexture9_ ptr
type PDIRECT3DBASETEXTURE9 as IDirect3DBaseTexture9_ ptr

#define IDirect3DBaseTexture9_QueryInterface(p,a,b)	(p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3DBaseTexture9_AddRef(p)	(p)->lpVtbl->AddRef(p)
#define IDirect3DBaseTexture9_Release(p)	(p)->lpVtbl->Release(p)
#define IDirect3DBaseTexture9_GetDevice(p,a)	(p)->lpVtbl->GetDevice(p,a)
#define IDirect3DBaseTexture9_SetPrivateData(p,a,b,c,d)	(p)->lpVtbl->SetPrivateData(p,a,b,c,d)
#define IDirect3DBaseTexture9_GetPrivateData(p,a,b,c)	(p)->lpVtbl->GetPrivateData(p,a,b,c)
#define IDirect3DBaseTexture9_FreePrivateData(p,a)	(p)->lpVtbl->FreePrivateData(p,a)
#define IDirect3DBaseTexture9_SetPriority(p,a)	(p)->lpVtbl->SetPriority(p,a)
#define IDirect3DBaseTexture9_GetPriority(p)	(p)->lpVtbl->GetPriority(p)
#define IDirect3DBaseTexture9_PreLoad(p)	(p)->lpVtbl->PreLoad(p)
#define IDirect3DBaseTexture9_GetType(p)	(p)->lpVtbl->GetType(p)
#define IDirect3DBaseTexture9_SetLOD(p,a)	(p)->lpVtbl->SetLOD(p,a)
#define IDirect3DBaseTexture9_GetLOD(p)	(p)->lpVtbl->GetLOD(p)
#define IDirect3DBaseTexture9_GetLevelCount(p)	(p)->lpVtbl->GetLevelCount(p)
#define IDirect3DBaseTexture9_SetAutoGenFilterType(p,a)	(p)->lpVtbl->SetAutoGenFilterType(p,a)
#define IDirect3DBaseTexture9_GetAutoGenFilterType(p)	(p)->lpVtbl->GetAutoGenFilterType(p)
#define IDirect3DBaseTexture9_GenerateMipSubLevels(p)	(p)->lpVtbl->GenerateMipSubLevels(p)

type IDirect3DCubeTexture9Vtbl_ as IDirect3DCubeTexture9Vtbl

type IDirect3DCubeTexture9
	lpVtbl as IDirect3DCubeTexture9Vtbl_ ptr
end type

type IDirect3DCubeTexture9Vtbl
	QueryInterface as function(byval as IDirect3DCubeTexture9 ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DCubeTexture9 ptr) as ULONG
	Release as function(byval as IDirect3DCubeTexture9 ptr) as ULONG
	GetDevice as function(byval as IDirect3DCubeTexture9 ptr, byval as IDirect3DDevice9 ptr ptr) as HRESULT
	SetPrivateData as function(byval as IDirect3DCubeTexture9 ptr, byval as GUID ptr, byval as any ptr, byval as DWORD, byval as DWORD) as HRESULT
	GetPrivateData as function(byval as IDirect3DCubeTexture9 ptr, byval as GUID ptr, byval as any ptr, byval as DWORD ptr) as HRESULT
	FreePrivateData as function(byval as IDirect3DCubeTexture9 ptr, byval as GUID ptr) as HRESULT
	SetPriority as function(byval as IDirect3DCubeTexture9 ptr, byval as DWORD) as DWORD
	GetPriority as function(byval as IDirect3DCubeTexture9 ptr) as DWORD
	PreLoad as sub(byval as IDirect3DCubeTexture9 ptr)
	GetType as function(byval as IDirect3DCubeTexture9 ptr) as D3DRESOURCETYPE
	SetLOD as function(byval as IDirect3DCubeTexture9 ptr, byval as DWORD) as DWORD
	GetLOD as function(byval as IDirect3DCubeTexture9 ptr) as DWORD
	GetLevelCount as function(byval as IDirect3DCubeTexture9 ptr) as DWORD
	SetAutoGenFilterType as function(byval as IDirect3DCubeTexture9 ptr, byval as D3DTEXTUREFILTERTYPE) as HRESULT
	GetAutoGenFilterType as function(byval as IDirect3DCubeTexture9 ptr) as D3DTEXTUREFILTERTYPE
	GenerateMipSubLevels as sub(byval as IDirect3DCubeTexture9 ptr)
	GetLevelDesc as function(byval as IDirect3DCubeTexture9 ptr, byval as UINT, byval as D3DSURFACE_DESC ptr) as HRESULT
	GetCubeMapSurface as function(byval as IDirect3DCubeTexture9 ptr, byval as D3DCUBEMAP_FACES, byval as UINT, byval as IDirect3DSurface9_ ptr ptr) as HRESULT
	LockRect as function(byval as IDirect3DCubeTexture9 ptr, byval as D3DCUBEMAP_FACES, byval as UINT, byval as D3DLOCKED_RECT ptr, byval as RECT ptr, byval as DWORD) as HRESULT
	UnlockRect as function(byval as IDirect3DCubeTexture9 ptr, byval as D3DCUBEMAP_FACES, byval as UINT) as HRESULT
	AddDirtyRect as function(byval as IDirect3DCubeTexture9 ptr, byval as D3DCUBEMAP_FACES, byval as RECT ptr) as HRESULT
end type

type LPDIRECT3DCUBETEXTURE9 as IDirect3DCubeTexture9 ptr
type PDIRECT3DCUBETEXTURE9 as IDirect3DCubeTexture9 ptr

#define IDirect3DCubeTexture9_QueryInterface(p,a,b)	(p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3DCubeTexture9_AddRef(p)	(p)->lpVtbl->AddRef(p)
#define IDirect3DCubeTexture9_Release(p)	(p)->lpVtbl->Release(p)
#define IDirect3DCubeTexture9_GetDevice(p,a)	(p)->lpVtbl->GetDevice(p,a)
#define IDirect3DCubeTexture9_SetPrivateData(p,a,b,c,d)	(p)->lpVtbl->SetPrivateData(p,a,b,c,d)
#define IDirect3DCubeTexture9_GetPrivateData(p,a,b,c)	(p)->lpVtbl->GetPrivateData(p,a,b,c)
#define IDirect3DCubeTexture9_FreePrivateData(p,a)	(p)->lpVtbl->FreePrivateData(p,a)
#define IDirect3DCubeTexture9_SetPriority(p,a)	(p)->lpVtbl->SetPriority(p,a)
#define IDirect3DCubeTexture9_GetPriority(p)	(p)->lpVtbl->GetPriority(p)
#define IDirect3DCubeTexture9_PreLoad(p)	(p)->lpVtbl->PreLoad(p)
#define IDirect3DCubeTexture9_GetType(p)	(p)->lpVtbl->GetType(p)
#define IDirect3DCubeTexture9_SetLOD(p,a)	(p)->lpVtbl->SetLOD(p,a)
#define IDirect3DCubeTexture9_GetLOD(p)	(p)->lpVtbl->GetLOD(p)
#define IDirect3DCubeTexture9_GetLevelCount(p)	(p)->lpVtbl->GetLevelCount(p)
#define IDirect3DCubeTexture9_SetAutoGenFilterType(p,a)	(p)->lpVtbl->SetAutoGenFilterType(p,a)
#define IDirect3DCubeTexture9_GetAutoGenFilterType(p)	(p)->lpVtbl->GetAutoGenFilterType(p)
#define IDirect3DCubeTexture9_GenerateMipSubLevels(p)	(p)->lpVtbl->GenerateMipSubLevels(p)
#define IDirect3DCubeTexture9_GetLevelDesc(p,a,b)	(p)->lpVtbl->GetLevelDesc(p,a,b)
#define IDirect3DCubeTexture9_GetCubeMapSurface(p,a,b,c)	(p)->lpVtbl->GetCubeMapSurface(p,a,b,c)
#define IDirect3DCubeTexture9_LockRect(p,a,b,c,d,e)	(p)->lpVtbl->LockRect(p,a,b,c,d,e)
#define IDirect3DCubeTexture9_UnlockRect(p,a,b)	(p)->lpVtbl->UnlockRect(p,a,b)
#define IDirect3DCubeTexture9_AddDirtyRect(p,a,b)	(p)->lpVtbl->AddDirtyRect(p,a,b)

type IDirect3DTexture9Vtbl_ as IDirect3DTexture9Vtbl

type IDirect3DTexture9
	lpVtbl as IDirect3DTexture9Vtbl_ ptr
end type

type IDirect3DTexture9Vtbl
	QueryInterface as function(byval as IDirect3DTexture9 ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DTexture9 ptr) as ULONG
	Release as function(byval as IDirect3DTexture9 ptr) as ULONG
	GetDevice as function(byval as IDirect3DTexture9 ptr, byval as IDirect3DDevice9 ptr ptr) as HRESULT
	SetPrivateData as function(byval as IDirect3DTexture9 ptr, byval as GUID ptr, byval as any ptr, byval as DWORD, byval as DWORD) as HRESULT
	GetPrivateData as function(byval as IDirect3DTexture9 ptr, byval as GUID ptr, byval as any ptr, byval as DWORD ptr) as HRESULT
	FreePrivateData as function(byval as IDirect3DTexture9 ptr, byval as GUID ptr) as HRESULT
	SetPriority as function(byval as IDirect3DTexture9 ptr, byval as DWORD) as DWORD
	GetPriority as function(byval as IDirect3DTexture9 ptr) as DWORD
	PreLoad as sub(byval as IDirect3DTexture9 ptr)
	GetType as function(byval as IDirect3DTexture9 ptr) as D3DRESOURCETYPE
	SetLOD as function(byval as IDirect3DTexture9 ptr, byval as DWORD) as DWORD
	GetLOD as function(byval as IDirect3DTexture9 ptr) as DWORD
	GetLevelCount as function(byval as IDirect3DTexture9 ptr) as DWORD
	SetAutoGenFilterType as function(byval as IDirect3DTexture9 ptr, byval as D3DTEXTUREFILTERTYPE) as HRESULT
	GetAutoGenFilterType as function(byval as IDirect3DTexture9 ptr) as D3DTEXTUREFILTERTYPE
	GenerateMipSubLevels as sub(byval as IDirect3DTexture9 ptr)
	GetLevelDesc as function(byval as IDirect3DTexture9 ptr, byval as UINT, byval as D3DSURFACE_DESC ptr) as HRESULT
	GetSurfaceLevel as function(byval as IDirect3DTexture9 ptr, byval as UINT, byval as IDirect3DSurface9_ ptr ptr) as HRESULT
	LockRect as function(byval as IDirect3DTexture9 ptr, byval as UINT, byval as D3DLOCKED_RECT ptr, byval as RECT ptr, byval as DWORD) as HRESULT
	UnlockRect as function(byval as IDirect3DTexture9 ptr, byval as UINT) as HRESULT
	AddDirtyRect as function(byval as IDirect3DTexture9 ptr, byval as RECT ptr) as HRESULT
end type

type LPDIRECT3DTEXTURE9 as IDirect3DTexture9 ptr
type PDIRECT3DTEXTURE9 as IDirect3DTexture9 ptr

#define IDirect3DTexture9_QueryInterface(p,a,b)	(p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3DTexture9_AddRef(p)	(p)->lpVtbl->AddRef(p)
#define IDirect3DTexture9_Release(p)	(p)->lpVtbl->Release(p)
#define IDirect3DTexture9_GetDevice(p,a)	(p)->lpVtbl->GetDevice(p,a)
#define IDirect3DTexture9_SetPrivateData(p,a,b,c,d)	(p)->lpVtbl->SetPrivateData(p,a,b,c,d)
#define IDirect3DTexture9_GetPrivateData(p,a,b,c)	(p)->lpVtbl->GetPrivateData(p,a,b,c)
#define IDirect3DTexture9_FreePrivateData(p,a)	(p)->lpVtbl->FreePrivateData(p,a)
#define IDirect3DTexture9_SetPriority(p,a)	(p)->lpVtbl->SetPriority(p,a)
#define IDirect3DTexture9_GetPriority(p)	(p)->lpVtbl->GetPriority(p)
#define IDirect3DTexture9_PreLoad(p)	(p)->lpVtbl->PreLoad(p)
#define IDirect3DTexture9_GetType(p)	(p)->lpVtbl->GetType(p)
#define IDirect3DTexture9_SetLOD(p,a)	(p)->lpVtbl->SetLOD(p,a)
#define IDirect3DTexture9_GetLOD(p)	(p)->lpVtbl->GetLOD(p)
#define IDirect3DTexture9_GetLevelCount(p)	(p)->lpVtbl->GetLevelCount(p)
#define IDirect3DTexture9_SetAutoGenFilterType(p,a)	(p)->lpVtbl->SetAutoGenFilterType(p,a)
#define IDirect3DTexture9_GetAutoGenFilterType(p)	(p)->lpVtbl->GetAutoGenFilterType(p)
#define IDirect3DTexture9_GenerateMipSubLevels(p)	(p)->lpVtbl->GenerateMipSubLevels(p)
#define IDirect3DTexture9_GetLevelDesc(p,a,b)	(p)->lpVtbl->GetLevelDesc(p,a,b)
#define IDirect3DTexture9_GetSurfaceLevel(p,a,b)	(p)->lpVtbl->GetSurfaceLevel(p,a,b)
#define IDirect3DTexture9_LockRect(p,a,b,c,d)	(p)->lpVtbl->LockRect(p,a,b,c,d)
#define IDirect3DTexture9_UnlockRect(p,a)	(p)->lpVtbl->UnlockRect(p,a)
#define IDirect3DTexture9_AddDirtyRect(p,a)	(p)->lpVtbl->AddDirtyRect(p,a)

type IDirect3DVolumeTexture9Vtbl_ as IDirect3DVolumeTexture9Vtbl

type IDirect3DVolumeTexture9
	lpVtbl as IDirect3DVolumeTexture9Vtbl_ ptr
end type

type IDirect3DVolumeTexture9Vtbl
	QueryInterface as function(byval as IDirect3DVolumeTexture9 ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DVolumeTexture9 ptr) as ULONG
	Release as function(byval as IDirect3DVolumeTexture9 ptr) as ULONG
	GetDevice as function(byval as IDirect3DVolumeTexture9 ptr, byval as IDirect3DDevice9 ptr ptr) as HRESULT
	SetPrivateData as function(byval as IDirect3DVolumeTexture9 ptr, byval as GUID ptr, byval as any ptr, byval as DWORD, byval as DWORD) as HRESULT
	GetPrivateData as function(byval as IDirect3DVolumeTexture9 ptr, byval as GUID ptr, byval as any ptr, byval as DWORD ptr) as HRESULT
	FreePrivateData as function(byval as IDirect3DVolumeTexture9 ptr, byval as GUID ptr) as HRESULT
	SetPriority as function(byval as IDirect3DVolumeTexture9 ptr, byval as DWORD) as DWORD
	GetPriority as function(byval as IDirect3DVolumeTexture9 ptr) as DWORD
	PreLoad as sub(byval as IDirect3DVolumeTexture9 ptr)
	GetType as function(byval as IDirect3DVolumeTexture9 ptr) as D3DRESOURCETYPE
	SetLOD as function(byval as IDirect3DVolumeTexture9 ptr, byval as DWORD) as DWORD
	GetLOD as function(byval as IDirect3DVolumeTexture9 ptr) as DWORD
	GetLevelCount as function(byval as IDirect3DVolumeTexture9 ptr) as DWORD
	SetAutoGenFilterType as function(byval as IDirect3DVolumeTexture9 ptr, byval as D3DTEXTUREFILTERTYPE) as HRESULT
	GetAutoGenFilterType as function(byval as IDirect3DVolumeTexture9 ptr) as D3DTEXTUREFILTERTYPE
	GenerateMipSubLevels as sub(byval as IDirect3DVolumeTexture9 ptr)
	GetLevelDesc as function(byval as IDirect3DVolumeTexture9 ptr, byval as UINT, byval as D3DVOLUME_DESC ptr) as HRESULT
	GetVolumeLevel as function(byval as IDirect3DVolumeTexture9 ptr, byval as UINT, byval as IDirect3DVolume9 ptr ptr) as HRESULT
	LockBox as function(byval as IDirect3DVolumeTexture9 ptr, byval as UINT, byval as D3DLOCKED_BOX ptr, byval as D3DBOX ptr, byval as DWORD) as HRESULT
	UnlockBox as function(byval as IDirect3DVolumeTexture9 ptr, byval as UINT) as HRESULT
	AddDirtyBox as function(byval as IDirect3DVolumeTexture9 ptr, byval as D3DBOX ptr) as HRESULT
end type

type LPDIRECT3DVOLUMETEXTURE9 as IDirect3DVolumeTexture9 ptr
type PDIRECT3DVOLUMETEXTURE9 as IDirect3DVolumeTexture9 ptr

#define IDirect3DVolumeTexture9_QueryInterface(p,a,b)	(p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3DVolumeTexture9_AddRef(p)	(p)->lpVtbl->AddRef(p)
#define IDirect3DVolumeTexture9_Release(p)	(p)->lpVtbl->Release(p)
#define IDirect3DVolumeTexture9_GetDevice(p,a)	(p)->lpVtbl->GetDevice(p,a)
#define IDirect3DVolumeTexture9_SetPrivateData(p,a,b,c,d)	(p)->lpVtbl->SetPrivateData(p,a,b,c,d)
#define IDirect3DVolumeTexture9_GetPrivateData(p,a,b,c)	(p)->lpVtbl->GetPrivateData(p,a,b,c)
#define IDirect3DVolumeTexture9_FreePrivateData(p,a)	(p)->lpVtbl->FreePrivateData(p,a)
#define IDirect3DVolumeTexture9_SetPriority(p,a)	(p)->lpVtbl->SetPriority(p,a)
#define IDirect3DVolumeTexture9_GetPriority(p)	(p)->lpVtbl->GetPriority(p)
#define IDirect3DVolumeTexture9_PreLoad(p)	(p)->lpVtbl->PreLoad(p)
#define IDirect3DVolumeTexture9_GetType(p)	(p)->lpVtbl->GetType(p)
#define IDirect3DVolumeTexture9_SetLOD(p,a)	(p)->lpVtbl->SetLOD(p,a)
#define IDirect3DVolumeTexture9_GetLOD(p)	(p)->lpVtbl->GetLOD(p)
#define IDirect3DVolumeTexture9_GetLevelCount(p)	(p)->lpVtbl->GetLevelCount(p)
#define IDirect3DVolumeTexture9_SetAutoGenFilterType(p,a)	(p)->lpVtbl->SetAutoGenFilterType(p,a)
#define IDirect3DVolumeTexture9_GetAutoGenFilterType(p)	(p)->lpVtbl->GetAutoGenFilterType(p)
#define IDirect3DVolumeTexture9_GenerateMipSubLevels(p)	(p)->lpVtbl->GenerateMipSubLevels(p)
#define IDirect3DVolumeTexture9_GetLevelDesc(p,a,b)	(p)->lpVtbl->GetLevelDesc(p,a,b)
#define IDirect3DVolumeTexture9_GetVolumeLevel(p,a,b)	(p)->lpVtbl->GetVolumeLevel(p,a,b)
#define IDirect3DVolumeTexture9_LockBox(p,a,b,c,d)	(p)->lpVtbl->LockBox(p,a,b,c,d)
#define IDirect3DVolumeTexture9_UnlockBox(p,a)	(p)->lpVtbl->UnlockBox(p,a)
#define IDirect3DVolumeTexture9_AddDirtyBox(p,a)	(p)->lpVtbl->AddDirtyBox(p,a)

type IDirect3DVertexDeclaration9Vtbl_ as IDirect3DVertexDeclaration9Vtbl

type IDirect3DVertexDeclaration9
	lpVtbl as IDirect3DVertexDeclaration9Vtbl_ ptr
end type

type IDirect3DVertexDeclaration9Vtbl
	QueryInterface as function(byval as IDirect3DVertexDeclaration9_ ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DVertexDeclaration9_ ptr) as ULONG
	Release as function(byval as IDirect3DVertexDeclaration9_ ptr) as ULONG
	GetDevice as function(byval as IDirect3DVertexDeclaration9_ ptr, byval as IDirect3DDevice9 ptr ptr) as HRESULT
	GetDeclaration as function(byval as IDirect3DVertexDeclaration9_ ptr, byval as D3DVERTEXELEMENT9 ptr, byval as UINT ptr) as HRESULT
end type

type LPDIRECT3DVERTEXDECLARATION9 as IDirect3DVertexDeclaration9_ ptr
type PDIRECT3DVERTEXDECLARATION9 as IDirect3DVertexDeclaration9_ ptr

#define IDirect3DVertexDeclaration9_QueryInterface(p,a,b)	(p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3DVertexDeclaration9_AddRef(p)	(p)->lpVtbl->AddRef(p)
#define IDirect3DVertexDeclaration9_Release(p)	(p)->lpVtbl->Release(p)
#define IDirect3DVertexDeclaration9_GetDevice(p,a)	(p)->lpVtbl->GetDevice(p,a)
#define IDirect3DVertexDeclaration9_GetDeclaration(p,a,b)	(p)->lpVtbl->GetDeclaration(p,a,b)

type IDirect3DVertexShader9Vtbl_ as IDirect3DVertexShader9Vtbl

type IDirect3DVertexShader9
	lpVtbl as IDirect3DVertexShader9Vtbl_ ptr
end type

type IDirect3DVertexShader9Vtbl
	QueryInterface as function(byval as IDirect3DVertexShader9_ ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DVertexShader9_ ptr) as ULONG
	Release as function(byval as IDirect3DVertexShader9_ ptr) as ULONG
	GetDevice as function(byval as IDirect3DVertexShader9_ ptr, byval as IDirect3DDevice9 ptr ptr) as HRESULT
	GetFunction as function(byval as IDirect3DVertexShader9_ ptr, byval as any ptr, byval as UINT ptr) as HRESULT
end type

type LPDIRECT3DVERTEXSHADER9 as IDirect3DVertexShader9_ ptr
type PDIRECT3DVERTEXSHADER9 as IDirect3DVertexShader9_ ptr

#define IDirect3DVertexShader9_QueryInterface(p,a,b)	(p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3DVertexShader9_AddRef(p)	(p)->lpVtbl->AddRef(p)
#define IDirect3DVertexShader9_Release(p)	(p)->lpVtbl->Release(p)
#define IDirect3DVertexShader9_GetDevice(p,a)	(p)->lpVtbl->GetDevice(p,a)
#define IDirect3DVertexShader9_GetFunction(p,a,b)	(p)->lpVtbl->GetFunction(p,a,b)

type IDirect3DPixelShader9Vtbl_ as IDirect3DPixelShader9Vtbl

type IDirect3DPixelShader9
	lpVtbl as IDirect3DPixelShader9Vtbl_ ptr
end type

type IDirect3DPixelShader9Vtbl
	QueryInterface as function(byval as IDirect3DPixelShader9_ ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DPixelShader9_ ptr) as ULONG
	Release as function(byval as IDirect3DPixelShader9_ ptr) as ULONG
	GetDevice as function(byval as IDirect3DPixelShader9_ ptr, byval as IDirect3DDevice9 ptr ptr) as HRESULT
	GetFunction as function(byval as IDirect3DPixelShader9_ ptr, byval as any ptr, byval as UINT ptr) as HRESULT
end type

type LPDIRECT3DPIXELSHADER9 as IDirect3DPixelShader9_ ptr
type PDIRECT3DPIXELSHADER9 as IDirect3DPixelShader9_ ptr

#define IDirect3DPixelShader9_QueryInterface(p,a,b)	(p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3DPixelShader9_AddRef(p)	(p)->lpVtbl->AddRef(p)
#define IDirect3DPixelShader9_Release(p)	(p)->lpVtbl->Release(p)
#define IDirect3DPixelShader9_GetDevice(p,a)	(p)->lpVtbl->GetDevice(p,a)
#define IDirect3DPixelShader9_GetFunction(p,a,b)	(p)->lpVtbl->GetFunction(p,a,b)

type IDirect3DStateBlock9Vtbl_ as IDirect3DStateBlock9Vtbl

type IDirect3DStateBlock9
	lpVtbl as IDirect3DStateBlock9Vtbl_ ptr
end type

type IDirect3DStateBlock9Vtbl
	QueryInterface as function(byval as IDirect3DStateBlock9_ ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DStateBlock9_ ptr) as ULONG
	Release as function(byval as IDirect3DStateBlock9_ ptr) as ULONG
	GetDevice as function(byval as IDirect3DStateBlock9_ ptr, byval as IDirect3DDevice9 ptr ptr) as HRESULT
	Capture as function(byval as IDirect3DStateBlock9_ ptr) as HRESULT
	Apply as function(byval as IDirect3DStateBlock9_ ptr) as HRESULT
end type

type LPDIRECT3DSTATEBLOCK9 as IDirect3DStateBlock9_ ptr
type PDIRECT3DSTATEBLOCK9 as IDirect3DStateBlock9_ ptr

#define IDirect3DStateBlock9_QueryInterface(p,a,b)	(p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3DStateBlock9_AddRef(p)	(p)->lpVtbl->AddRef(p)
#define IDirect3DStateBlock9_Release(p)	(p)->lpVtbl->Release(p)
#define IDirect3DStateBlock9_GetDevice(p,a)	(p)->lpVtbl->GetDevice(p,a)
#define IDirect3DStateBlock9_Capture(p)	(p)->lpVtbl->Capture(p)
#define IDirect3DStateBlock9_Apply(p)	(p)->lpVtbl->Apply(p)

type IDirect3DQuery9Vtbl_ as IDirect3DQuery9Vtbl

type IDirect3DQuery9
	lpVtbl as IDirect3DQuery9Vtbl_ ptr
end type

type IDirect3DQuery9Vtbl
	QueryInterface as function(byval as IDirect3DQuery9_ ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DQuery9_ ptr) as ULONG
	Release as function(byval as IDirect3DQuery9_ ptr) as ULONG
	GetDevice as function(byval as IDirect3DQuery9_ ptr, byval as IDirect3DDevice9 ptr ptr) as HRESULT
	GetType as function(byval as IDirect3DQuery9_ ptr) as D3DQUERYTYPE
	GetDataSize as function(byval as IDirect3DQuery9_ ptr) as DWORD
	Issue as function(byval as IDirect3DQuery9_ ptr, byval as DWORD) as HRESULT
	GetData as function(byval as IDirect3DQuery9_ ptr, byval as any ptr, byval as DWORD, byval as DWORD) as HRESULT
end type

type LPDIRECT3DQUERY9 as IDirect3DQuery9_ ptr
type PDIRECT3DQUERY9 as IDirect3DQuery9_ ptr

#define IDirect3DQuery9_QueryInterface(p,a,b)	(p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3DQuery9_AddRef(p)	(p)->lpVtbl->AddRef(p)
#define IDirect3DQuery9_Release(p)	(p)->lpVtbl->Release(p)
#define IDirect3DQuery9_GetDevice(p,a)	(p)->lpVtbl->GetDevice(p,a)
#define IDirect3DQuery9_GetType(p)	(p)->lpVtbl->GetType(p)
#define IDirect3DQuery9_GetDataSize(p)	(p)->lpVtbl->GetDataSize(p)
#define IDirect3DQuery9_Issue(p,a)	(p)->lpVtbl->Issue(p,a)
#define IDirect3DQuery9_GetData(p,a,b,c)	(p)->lpVtbl->GetData(p,a,b,c)

declare function Direct3DCreate9 alias "Direct3DCreate9" (byval SDKVersion as UINT) as IDirect3D9 ptr

#endif
