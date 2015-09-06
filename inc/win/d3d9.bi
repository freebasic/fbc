'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   Copyright (C) 2002-2003 Jason Edmeades
''                           Raphael Junqueira
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
#inclib "d3d9"

#include once "crt/stdlib.bi"
#include once "objbase.bi"
#include once "windows.bi"
#include once "d3d9types.bi"
#include once "d3d9caps.bi"

extern "Windows"

#define _D3D9_H_
const DIRECT3D_VERSION = &h0900
const D3DCREATE_FPU_PRESERVE = &h00000002
const D3DCREATE_MULTITHREADED = &h00000004
const D3DCREATE_PUREDEVICE = &h00000010
const D3DCREATE_SOFTWARE_VERTEXPROCESSING = &h00000020
const D3DCREATE_HARDWARE_VERTEXPROCESSING = &h00000040
const D3DCREATE_MIXED_VERTEXPROCESSING = &h00000080
const D3DCREATE_DISABLE_DRIVER_MANAGEMENT = &h00000100
const D3DCREATE_ADAPTERGROUP_DEVICE = &h00000200
const D3DCREATE_DISABLE_DRIVER_MANAGEMENT_EX = &h00000400
const D3DCREATE_NOWINDOWCHANGES = &h00000800
const D3DCREATE_DISABLE_PSGP_THREADING = &h00002000
const D3DCREATE_ENABLE_PRESENTSTATS = &h00004000
const D3DCREATE_DISABLE_PRINTSCREEN = &h00008000
const D3DCREATE_SCREENSAVER = &h10000000
const D3DSPD_IUNKNOWN = &h00000001
const D3D_SDK_VERSION = 32
const D3DADAPTER_DEFAULT = 0
const D3DENUM_NO_WHQL_LEVEL = &h00000002
const D3DPRESENT_DONOTWAIT = 1
const D3DPRESENT_LINEAR_CONTENT = 2
const D3DPRESENT_BACK_BUFFERS_MAX = 3
const D3DSGR_NO_CALIBRATION = &h00000000
const D3DSGR_CALIBRATE = &h00000001
const _FACD3D = &h876
#define MAKE_D3DHRESULT(code) MAKE_HRESULT(1, _FACD3D, code)
#define MAKE_D3DSTATUS(code) MAKE_HRESULT(0, _FACD3D, code)
const D3D_OK = S_OK
#define D3DERR_WRONGTEXTUREFORMAT MAKE_D3DHRESULT(2072)
#define D3DERR_UNSUPPORTEDCOLOROPERATION MAKE_D3DHRESULT(2073)
#define D3DERR_UNSUPPORTEDCOLORARG MAKE_D3DHRESULT(2074)
#define D3DERR_UNSUPPORTEDALPHAOPERATION MAKE_D3DHRESULT(2075)
#define D3DERR_UNSUPPORTEDALPHAARG MAKE_D3DHRESULT(2076)
#define D3DERR_TOOMANYOPERATIONS MAKE_D3DHRESULT(2077)
#define D3DERR_CONFLICTINGTEXTUREFILTER MAKE_D3DHRESULT(2078)
#define D3DERR_UNSUPPORTEDFACTORVALUE MAKE_D3DHRESULT(2079)
#define D3DERR_CONFLICTINGRENDERSTATE MAKE_D3DHRESULT(2081)
#define D3DERR_UNSUPPORTEDTEXTUREFILTER MAKE_D3DHRESULT(2082)
#define D3DERR_CONFLICTINGTEXTUREPALETTE MAKE_D3DHRESULT(2086)
#define D3DERR_DRIVERINTERNALERROR MAKE_D3DHRESULT(2087)
#define D3DERR_NOTFOUND MAKE_D3DHRESULT(2150)
#define D3DERR_MOREDATA MAKE_D3DHRESULT(2151)
#define D3DERR_DEVICELOST MAKE_D3DHRESULT(2152)
#define D3DERR_DEVICENOTRESET MAKE_D3DHRESULT(2153)
#define D3DERR_NOTAVAILABLE MAKE_D3DHRESULT(2154)
#define D3DERR_OUTOFVIDEOMEMORY MAKE_D3DHRESULT(380)
#define D3DERR_INVALIDDEVICE MAKE_D3DHRESULT(2155)
#define D3DERR_INVALIDCALL MAKE_D3DHRESULT(2156)
#define D3DERR_DRIVERINVALIDCALL MAKE_D3DHRESULT(2157)
#define D3DERR_WASSTILLDRAWING MAKE_D3DHRESULT(540)
#define D3DOK_NOAUTOGEN MAKE_D3DSTATUS(2159)
#define D3DERR_DEVICEREMOVED MAKE_D3DHRESULT(2160)
#define D3DERR_DEVICEHUNG MAKE_D3DHRESULT(2164)
#define S_NOT_RESIDENT MAKE_D3DSTATUS(2165)
#define S_RESIDENT_IN_SHARED_MEMORY MAKE_D3DSTATUS(2166)
#define S_PRESENT_MODE_CHANGED MAKE_D3DSTATUS(2167)
#define S_PRESENT_OCCLUDED MAKE_D3DSTATUS(2168)
#define D3DERR_UNSUPPORTEDOVERLAY MAKE_D3DHRESULT(2171)
#define D3DERR_UNSUPPORTEDOVERLAYFORMAT MAKE_D3DHRESULT(2172)
#define D3DERR_CANNOTPROTECTCONTENT MAKE_D3DHRESULT(2173)
#define D3DERR_UNSUPPORTEDCRYPTO MAKE_D3DHRESULT(2174)
#define D3DERR_PRESENT_STATISTICS_DISJOINT MAKE_D3DHRESULT(2180)
extern IID_IDirect3D9 as const GUID
type LPDIRECT3D9 as IDirect3D9 ptr
type PDIRECT3D9 as IDirect3D9 ptr
extern IID_IDirect3D9Ex as const GUID
type LPDIRECT3D9EX as IDirect3D9Ex ptr
type PDIRECT3D9EX as IDirect3D9Ex ptr
extern IID_IDirect3DDevice9 as const GUID
type IDirect3DDevice9 as IDirect3DDevice9_
type LPDIRECT3DDEVICE9 as IDirect3DDevice9 ptr
extern IID_IDirect3DDevice9Ex as const GUID

type IDirect3DDevice9Ex as IDirect3DDevice9Ex_
type LPDIRECT3DDEVICE9EX as IDirect3DDevice9Ex ptr
type PDIRECT3DDEVICE9EX as IDirect3DDevice9Ex ptr
extern IID_IDirect3DResource9 as const GUID
type LPDIRECT3DRESOURCE9 as IDirect3DResource9 ptr
type PDIRECT3DRESOURCE9 as IDirect3DResource9 ptr
extern IID_IDirect3DVertexBuffer9 as const GUID
type LPDIRECT3DVERTEXBUFFER9 as IDirect3DVertexBuffer9 ptr
type PDIRECT3DVERTEXBUFFER9 as IDirect3DVertexBuffer9 ptr
extern IID_IDirect3DVolume9 as const GUID
type LPDIRECT3DVOLUME9 as IDirect3DVolume9 ptr
type PDIRECT3DVOLUME9 as IDirect3DVolume9 ptr
extern IID_IDirect3DSwapChain9 as const GUID
type LPDIRECT3DSWAPCHAIN9 as IDirect3DSwapChain9 ptr
type PDIRECT3DSWAPCHAIN9 as IDirect3DSwapChain9 ptr
extern IID_IDirect3DSwapChain9Ex as const GUID
type LPDIRECT3DSWAPCHAIN9EX as IDirect3DSwapChain9Ex ptr
type PDIRECT3DSWAPCHAIN9EX as IDirect3DSwapChain9Ex ptr
extern IID_IDirect3DSurface9 as const GUID
type IDirect3DSurface9 as IDirect3DSurface9_
type LPDIRECT3DSURFACE9 as IDirect3DSurface9 ptr
type PDIRECT3DSURFACE9 as IDirect3DSurface9 ptr
extern IID_IDirect3DIndexBuffer9 as const GUID
type LPDIRECT3DINDEXBUFFER9 as IDirect3DIndexBuffer9 ptr
type PDIRECT3DINDEXBUFFER9 as IDirect3DIndexBuffer9 ptr
extern IID_IDirect3DBaseTexture9 as const GUID
type LPDIRECT3DBASETEXTURE9 as IDirect3DBaseTexture9 ptr
type PDIRECT3DBASETEXTURE9 as IDirect3DBaseTexture9 ptr
extern IID_IDirect3DTexture9 as const GUID
type LPDIRECT3DTEXTURE9 as IDirect3DTexture9 ptr
type PDIRECT3DTEXTURE9 as IDirect3DTexture9 ptr
extern IID_IDirect3DCubeTexture9 as const GUID
type LPDIRECT3DCUBETEXTURE9 as IDirect3DCubeTexture9 ptr
type PDIRECT3DCUBETEXTURE9 as IDirect3DCubeTexture9 ptr
extern IID_IDirect3DVolumeTexture9 as const GUID
type LPDIRECT3DVOLUMETEXTURE9 as IDirect3DVolumeTexture9 ptr
type PDIRECT3DVOLUMETEXTURE9 as IDirect3DVolumeTexture9 ptr
extern IID_IDirect3DVertexDeclaration9 as const GUID
type LPDIRECT3DVERTEXDECLARATION9 as IDirect3DVertexDeclaration9 ptr
extern IID_IDirect3DVertexShader9 as const GUID
type LPDIRECT3DVERTEXSHADER9 as IDirect3DVertexShader9 ptr
extern IID_IDirect3DPixelShader9 as const GUID
type LPDIRECT3DPIXELSHADER9 as IDirect3DPixelShader9 ptr
extern IID_IDirect3DStateBlock9 as const GUID
type LPDIRECT3DSTATEBLOCK9 as IDirect3DStateBlock9 ptr
extern IID_IDirect3DQuery9 as const GUID
type LPDIRECT3DQUERY9 as IDirect3DQuery9 ptr
type PDIRECT3DQUERY9 as IDirect3DQuery9 ptr
type IDirect3D9Vtbl as IDirect3D9Vtbl_

type IDirect3D9
	lpVtbl as IDirect3D9Vtbl ptr
end type

type IDirect3D9Vtbl_
	QueryInterface as function(byval This as IDirect3D9 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3D9 ptr) as ULONG
	Release as function(byval This as IDirect3D9 ptr) as ULONG
	RegisterSoftwareDevice as function(byval This as IDirect3D9 ptr, byval pInitializeFunction as any ptr) as HRESULT
	GetAdapterCount as function(byval This as IDirect3D9 ptr) as UINT
	GetAdapterIdentifier as function(byval This as IDirect3D9 ptr, byval Adapter as UINT, byval Flags as DWORD, byval pIdentifier as D3DADAPTER_IDENTIFIER9 ptr) as HRESULT
	GetAdapterModeCount as function(byval This as IDirect3D9 ptr, byval Adapter as UINT, byval Format as D3DFORMAT) as UINT
	EnumAdapterModes as function(byval This as IDirect3D9 ptr, byval Adapter as UINT, byval Format as D3DFORMAT, byval Mode as UINT, byval pMode as D3DDISPLAYMODE ptr) as HRESULT
	GetAdapterDisplayMode as function(byval This as IDirect3D9 ptr, byval Adapter as UINT, byval pMode as D3DDISPLAYMODE ptr) as HRESULT
	CheckDeviceType as function(byval This as IDirect3D9 ptr, byval iAdapter as UINT, byval DevType as D3DDEVTYPE, byval DisplayFormat as D3DFORMAT, byval BackBufferFormat as D3DFORMAT, byval bWindowed as WINBOOL) as HRESULT
	CheckDeviceFormat as function(byval This as IDirect3D9 ptr, byval Adapter as UINT, byval DeviceType as D3DDEVTYPE, byval AdapterFormat as D3DFORMAT, byval Usage as DWORD, byval RType as D3DRESOURCETYPE, byval CheckFormat as D3DFORMAT) as HRESULT
	CheckDeviceMultiSampleType as function(byval This as IDirect3D9 ptr, byval Adapter as UINT, byval DeviceType as D3DDEVTYPE, byval SurfaceFormat as D3DFORMAT, byval Windowed as WINBOOL, byval MultiSampleType as D3DMULTISAMPLE_TYPE, byval pQualityLevels as DWORD ptr) as HRESULT
	CheckDepthStencilMatch as function(byval This as IDirect3D9 ptr, byval Adapter as UINT, byval DeviceType as D3DDEVTYPE, byval AdapterFormat as D3DFORMAT, byval RenderTargetFormat as D3DFORMAT, byval DepthStencilFormat as D3DFORMAT) as HRESULT
	CheckDeviceFormatConversion as function(byval This as IDirect3D9 ptr, byval Adapter as UINT, byval DeviceType as D3DDEVTYPE, byval SourceFormat as D3DFORMAT, byval TargetFormat as D3DFORMAT) as HRESULT
	GetDeviceCaps as function(byval This as IDirect3D9 ptr, byval Adapter as UINT, byval DeviceType as D3DDEVTYPE, byval pCaps as D3DCAPS9 ptr) as HRESULT
	GetAdapterMonitor as function(byval This as IDirect3D9 ptr, byval Adapter as UINT) as HMONITOR
	CreateDevice as function(byval This as IDirect3D9 ptr, byval Adapter as UINT, byval DeviceType as D3DDEVTYPE, byval hFocusWindow as HWND, byval BehaviorFlags as DWORD, byval pPresentationParameters as D3DPRESENT_PARAMETERS ptr, byval ppReturnedDeviceInterface as IDirect3DDevice9 ptr ptr) as HRESULT
end type

#define IDirect3D9_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3D9_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3D9_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3D9_RegisterSoftwareDevice(p, a) (p)->lpVtbl->RegisterSoftwareDevice(p, a)
#define IDirect3D9_GetAdapterCount(p) (p)->lpVtbl->GetAdapterCount(p)
#define IDirect3D9_GetAdapterIdentifier(p, a, b, c) (p)->lpVtbl->GetAdapterIdentifier(p, a, b, c)
#define IDirect3D9_GetAdapterModeCount(p, a, b) (p)->lpVtbl->GetAdapterModeCount(p, a, b)
#define IDirect3D9_EnumAdapterModes(p, a, b, c, d) (p)->lpVtbl->EnumAdapterModes(p, a, b, c, d)
#define IDirect3D9_GetAdapterDisplayMode(p, a, b) (p)->lpVtbl->GetAdapterDisplayMode(p, a, b)
#define IDirect3D9_CheckDeviceType(p, a, b, c, d, e) (p)->lpVtbl->CheckDeviceType(p, a, b, c, d, e)
#define IDirect3D9_CheckDeviceFormat(p, a, b, c, d, e, f) (p)->lpVtbl->CheckDeviceFormat(p, a, b, c, d, e, f)
#define IDirect3D9_CheckDeviceMultiSampleType(p, a, b, c, d, e, f) (p)->lpVtbl->CheckDeviceMultiSampleType(p, a, b, c, d, e, f)
#define IDirect3D9_CheckDepthStencilMatch(p, a, b, c, d, e) (p)->lpVtbl->CheckDepthStencilMatch(p, a, b, c, d, e)
#define IDirect3D9_CheckDeviceFormatConversion(p, a, b, c, d) (p)->lpVtbl->CheckDeviceFormatConversion(p, a, b, c, d)
#define IDirect3D9_GetDeviceCaps(p, a, b, c) (p)->lpVtbl->GetDeviceCaps(p, a, b, c)
#define IDirect3D9_GetAdapterMonitor(p, a) (p)->lpVtbl->GetAdapterMonitor(p, a)
#define IDirect3D9_CreateDevice(p, a, b, c, d, e, f) (p)->lpVtbl->CreateDevice(p, a, b, c, d, e, f)
type IDirect3D9ExVtbl as IDirect3D9ExVtbl_

type IDirect3D9Ex
	lpVtbl as IDirect3D9ExVtbl ptr
end type

type IDirect3D9ExVtbl_
	QueryInterface as function(byval This as IDirect3D9Ex ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3D9Ex ptr) as ULONG
	Release as function(byval This as IDirect3D9Ex ptr) as ULONG
	RegisterSoftwareDevice as function(byval This as IDirect3D9Ex ptr, byval pInitializeFunction as any ptr) as HRESULT
	GetAdapterCount as function(byval This as IDirect3D9Ex ptr) as UINT
	GetAdapterIdentifier as function(byval This as IDirect3D9Ex ptr, byval Adapter as UINT, byval Flags as DWORD, byval pIdentifier as D3DADAPTER_IDENTIFIER9 ptr) as HRESULT
	GetAdapterModeCount as function(byval This as IDirect3D9Ex ptr, byval Adapter as UINT, byval Format as D3DFORMAT) as UINT
	EnumAdapterModes as function(byval This as IDirect3D9Ex ptr, byval Adapter as UINT, byval Format as D3DFORMAT, byval Mode as UINT, byval pMode as D3DDISPLAYMODE ptr) as HRESULT
	GetAdapterDisplayMode as function(byval This as IDirect3D9Ex ptr, byval Adapter as UINT, byval pMode as D3DDISPLAYMODE ptr) as HRESULT
	CheckDeviceType as function(byval This as IDirect3D9Ex ptr, byval iAdapter as UINT, byval DevType as D3DDEVTYPE, byval DisplayFormat as D3DFORMAT, byval BackBufferFormat as D3DFORMAT, byval bWindowed as WINBOOL) as HRESULT
	CheckDeviceFormat as function(byval This as IDirect3D9Ex ptr, byval Adapter as UINT, byval DeviceType as D3DDEVTYPE, byval AdapterFormat as D3DFORMAT, byval Usage as DWORD, byval RType as D3DRESOURCETYPE, byval CheckFormat as D3DFORMAT) as HRESULT
	CheckDeviceMultiSampleType as function(byval This as IDirect3D9Ex ptr, byval Adapter as UINT, byval DeviceType as D3DDEVTYPE, byval SurfaceFormat as D3DFORMAT, byval Windowed as WINBOOL, byval MultiSampleType as D3DMULTISAMPLE_TYPE, byval pQualityLevels as DWORD ptr) as HRESULT
	CheckDepthStencilMatch as function(byval This as IDirect3D9Ex ptr, byval Adapter as UINT, byval DeviceType as D3DDEVTYPE, byval AdapterFormat as D3DFORMAT, byval RenderTargetFormat as D3DFORMAT, byval DepthStencilFormat as D3DFORMAT) as HRESULT
	CheckDeviceFormatConversion as function(byval This as IDirect3D9Ex ptr, byval Adapter as UINT, byval DeviceType as D3DDEVTYPE, byval SourceFormat as D3DFORMAT, byval TargetFormat as D3DFORMAT) as HRESULT
	GetDeviceCaps as function(byval This as IDirect3D9Ex ptr, byval Adapter as UINT, byval DeviceType as D3DDEVTYPE, byval pCaps as D3DCAPS9 ptr) as HRESULT
	GetAdapterMonitor as function(byval This as IDirect3D9Ex ptr, byval Adapter as UINT) as HMONITOR
	CreateDevice as function(byval This as IDirect3D9Ex ptr, byval Adapter as UINT, byval DeviceType as D3DDEVTYPE, byval hFocusWindow as HWND, byval BehaviorFlags as DWORD, byval pPresentationParameters as D3DPRESENT_PARAMETERS ptr, byval ppReturnedDeviceInterface as IDirect3DDevice9 ptr ptr) as HRESULT
	GetAdapterModeCountEx as function(byval This as IDirect3D9Ex ptr, byval adapter_idx as UINT, byval filter as const D3DDISPLAYMODEFILTER ptr) as UINT
	EnumAdapterModesEx as function(byval This as IDirect3D9Ex ptr, byval adapter_idx as UINT, byval filter as const D3DDISPLAYMODEFILTER ptr, byval mode_idx as UINT, byval mode as D3DDISPLAYMODEEX ptr) as HRESULT
	GetAdapterDisplayModeEx as function(byval This as IDirect3D9Ex ptr, byval Adapter as UINT, byval pMode as D3DDISPLAYMODEEX ptr, byval pRotation as D3DDISPLAYROTATION ptr) as HRESULT
	CreateDeviceEx as function(byval This as IDirect3D9Ex ptr, byval Adapter as UINT, byval DeviceType as D3DDEVTYPE, byval hFocusWindow as HWND, byval BehaviorFlags as DWORD, byval pPresentationParameters as D3DPRESENT_PARAMETERS ptr, byval pFullscreenDisplayMode as D3DDISPLAYMODEEX ptr, byval ppReturnedDeviceInterface as IDirect3DDevice9Ex ptr ptr) as HRESULT
	GetAdapterLUID as function(byval This as IDirect3D9Ex ptr, byval Adatper as UINT, byval pLUID as LUID ptr) as HRESULT
end type

#define IDirect3D9Ex_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3D9Ex_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3D9Ex_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3D9Ex_RegisterSoftwareDevice(p, a) (p)->lpVtbl->RegisterSoftwareDevice(p, a)
#define IDirect3D9Ex_GetAdapterCount(p) (p)->lpVtbl->GetAdapterCount(p)
#define IDirect3D9Ex_GetAdapterIdentifier(p, a, b, c) (p)->lpVtbl->GetAdapterIdentifier(p, a, b, c)
#define IDirect3D9Ex_GetAdapterModeCount(p, a, b) (p)->lpVtbl->GetAdapterModeCount(p, a, b)
#define IDirect3D9Ex_EnumAdapterModes(p, a, b, c, d) (p)->lpVtbl->EnumAdapterModes(p, a, b, c, d)
#define IDirect3D9Ex_GetAdapterDisplayMode(p, a, b) (p)->lpVtbl->GetAdapterDisplayMode(p, a, b)
#define IDirect3D9Ex_CheckDeviceType(p, a, b, c, d, e) (p)->lpVtbl->CheckDeviceType(p, a, b, c, d, e)
#define IDirect3D9Ex_CheckDeviceFormat(p, a, b, c, d, e, f) (p)->lpVtbl->CheckDeviceFormat(p, a, b, c, d, e, f)
#define IDirect3D9Ex_CheckDeviceMultiSampleType(p, a, b, c, d, e, f) (p)->lpVtbl->CheckDeviceMultiSampleType(p, a, b, c, d, e, f)
#define IDirect3D9Ex_CheckDepthStencilMatch(p, a, b, c, d, e) (p)->lpVtbl->CheckDepthStencilMatch(p, a, b, c, d, e)
#define IDirect3D9Ex_CheckDeviceFormatConversion(p, a, b, c, d) (p)->lpVtbl->CheckDeviceFormatConversion(p, a, b, c, d)
#define IDirect3D9Ex_GetDeviceCaps(p, a, b, c) (p)->lpVtbl->GetDeviceCaps(p, a, b, c)
#define IDirect3D9Ex_GetAdapterMonitor(p, a) (p)->lpVtbl->GetAdapterMonitor(p, a)
#define IDirect3D9Ex_CreateDevice(p, a, b, c, d, e, f) (p)->lpVtbl->CreateDevice(p, a, b, c, d, e, f)
#define IDirect3D9Ex_GetAdapterModeCountEx(p, a, b) (p)->lpVtbl->GetAdapterModeCountEx(p, a, b)
#define IDirect3D9Ex_EnumAdapterModesEx(p, a, b, c, d) (p)->lpVtbl->EnumAdapterModesEx(p, a, b, c, d)
#define IDirect3D9Ex_GetAdapterDisplayModeEx(p, a, b, c) (p)->lpVtbl->GetAdapterDisplayModeEx(p, a, b, c)
#define IDirect3D9Ex_CreateDeviceEx(p, a, b, c, d, e, f, g) (p)->lpVtbl->CreateDeviceEx(p, a, b, c, d, e, f, g)
#define IDirect3D9Ex_GetAdapterLUID(p, a, b) (p)->lpVtbl->GetAdapterLUID(p, a, b)
type IDirect3DVolume9Vtbl as IDirect3DVolume9Vtbl_

type IDirect3DVolume9
	lpVtbl as IDirect3DVolume9Vtbl ptr
end type

type IDirect3DVolume9Vtbl_
	QueryInterface as function(byval This as IDirect3DVolume9 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DVolume9 ptr) as ULONG
	Release as function(byval This as IDirect3DVolume9 ptr) as ULONG
	GetDevice as function(byval This as IDirect3DVolume9 ptr, byval ppDevice as IDirect3DDevice9 ptr ptr) as HRESULT
	SetPrivateData as function(byval This as IDirect3DVolume9 ptr, byval guid as const GUID const ptr, byval data as const any ptr, byval data_size as DWORD, byval flags as DWORD) as HRESULT
	GetPrivateData as function(byval This as IDirect3DVolume9 ptr, byval refguid as const GUID const ptr, byval pData as any ptr, byval pSizeOfData as DWORD ptr) as HRESULT
	FreePrivateData as function(byval This as IDirect3DVolume9 ptr, byval refguid as const GUID const ptr) as HRESULT
	GetContainer as function(byval This as IDirect3DVolume9 ptr, byval riid as const IID const ptr, byval ppContainer as any ptr ptr) as HRESULT
	GetDesc as function(byval This as IDirect3DVolume9 ptr, byval pDesc as D3DVOLUME_DESC ptr) as HRESULT
	LockBox as function(byval This as IDirect3DVolume9 ptr, byval locked_box as D3DLOCKED_BOX ptr, byval box as const D3DBOX ptr, byval flags as DWORD) as HRESULT
	UnlockBox as function(byval This as IDirect3DVolume9 ptr) as HRESULT
end type

#define IDirect3DVolume9_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DVolume9_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DVolume9_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DVolume9_GetDevice(p, a) (p)->lpVtbl->GetDevice(p, a)
#define IDirect3DVolume9_SetPrivateData(p, a, b, c, d) (p)->lpVtbl->SetPrivateData(p, a, b, c, d)
#define IDirect3DVolume9_GetPrivateData(p, a, b, c) (p)->lpVtbl->GetPrivateData(p, a, b, c)
#define IDirect3DVolume9_FreePrivateData(p, a) (p)->lpVtbl->FreePrivateData(p, a)
#define IDirect3DVolume9_GetContainer(p, a, b) (p)->lpVtbl->GetContainer(p, a, b)
#define IDirect3DVolume9_GetDesc(p, a) (p)->lpVtbl->GetDesc(p, a)
#define IDirect3DVolume9_LockBox(p, a, b, c) (p)->lpVtbl->LockBox(p, a, b, c)
#define IDirect3DVolume9_UnlockBox(p) (p)->lpVtbl->UnlockBox(p)
type IDirect3DSwapChain9Vtbl as IDirect3DSwapChain9Vtbl_

type IDirect3DSwapChain9
	lpVtbl as IDirect3DSwapChain9Vtbl ptr
end type

type IDirect3DSwapChain9Vtbl_
	QueryInterface as function(byval This as IDirect3DSwapChain9 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DSwapChain9 ptr) as ULONG
	Release as function(byval This as IDirect3DSwapChain9 ptr) as ULONG
	Present as function(byval This as IDirect3DSwapChain9 ptr, byval src_rect as const RECT ptr, byval dst_rect as const RECT ptr, byval dst_window_override as HWND, byval dirty_region as const RGNDATA ptr, byval flags as DWORD) as HRESULT
	GetFrontBufferData as function(byval This as IDirect3DSwapChain9 ptr, byval pDestSurface as IDirect3DSurface9 ptr) as HRESULT
	GetBackBuffer as function(byval This as IDirect3DSwapChain9 ptr, byval iBackBuffer as UINT, byval Type as D3DBACKBUFFER_TYPE, byval ppBackBuffer as IDirect3DSurface9 ptr ptr) as HRESULT
	GetRasterStatus as function(byval This as IDirect3DSwapChain9 ptr, byval pRasterStatus as D3DRASTER_STATUS ptr) as HRESULT
	GetDisplayMode as function(byval This as IDirect3DSwapChain9 ptr, byval pMode as D3DDISPLAYMODE ptr) as HRESULT
	GetDevice as function(byval This as IDirect3DSwapChain9 ptr, byval ppDevice as IDirect3DDevice9 ptr ptr) as HRESULT
	GetPresentParameters as function(byval This as IDirect3DSwapChain9 ptr, byval pPresentationParameters as D3DPRESENT_PARAMETERS ptr) as HRESULT
end type

#define IDirect3DSwapChain9_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DSwapChain9_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DSwapChain9_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DSwapChain9_Present(p, a, b, c, d, e) (p)->lpVtbl->Present(p, a, b, c, d, e)
#define IDirect3DSwapChain9_GetFrontBufferData(p, a) (p)->lpVtbl->GetFrontBufferData(p, a)
#define IDirect3DSwapChain9_GetBackBuffer(p, a, b, c) (p)->lpVtbl->GetBackBuffer(p, a, b, c)
#define IDirect3DSwapChain9_GetRasterStatus(p, a) (p)->lpVtbl->GetRasterStatus(p, a)
#define IDirect3DSwapChain9_GetDisplayMode(p, a) (p)->lpVtbl->GetDisplayMode(p, a)
#define IDirect3DSwapChain9_GetDevice(p, a) (p)->lpVtbl->GetDevice(p, a)
#define IDirect3DSwapChain9_GetPresentParameters(p, a) (p)->lpVtbl->GetPresentParameters(p, a)
type IDirect3DSwapChain9ExVtbl as IDirect3DSwapChain9ExVtbl_

type IDirect3DSwapChain9Ex
	lpVtbl as IDirect3DSwapChain9ExVtbl ptr
end type

type IDirect3DSwapChain9ExVtbl_
	QueryInterface as function(byval This as IDirect3DSwapChain9Ex ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DSwapChain9Ex ptr) as ULONG
	Release as function(byval This as IDirect3DSwapChain9Ex ptr) as ULONG
	Present as function(byval This as IDirect3DSwapChain9Ex ptr, byval src_rect as const RECT ptr, byval dst_rect as const RECT ptr, byval dst_window_override as HWND, byval dirty_region as const RGNDATA ptr, byval flags as DWORD) as HRESULT
	GetFrontBufferData as function(byval This as IDirect3DSwapChain9Ex ptr, byval pDestSurface as IDirect3DSurface9 ptr) as HRESULT
	GetBackBuffer as function(byval This as IDirect3DSwapChain9Ex ptr, byval iBackBuffer as UINT, byval Type as D3DBACKBUFFER_TYPE, byval ppBackBuffer as IDirect3DSurface9 ptr ptr) as HRESULT
	GetRasterStatus as function(byval This as IDirect3DSwapChain9Ex ptr, byval pRasterStatus as D3DRASTER_STATUS ptr) as HRESULT
	GetDisplayMode as function(byval This as IDirect3DSwapChain9Ex ptr, byval pMode as D3DDISPLAYMODE ptr) as HRESULT
	GetDevice as function(byval This as IDirect3DSwapChain9Ex ptr, byval ppDevice as IDirect3DDevice9 ptr ptr) as HRESULT
	GetPresentParameters as function(byval This as IDirect3DSwapChain9Ex ptr, byval pPresentationParameters as D3DPRESENT_PARAMETERS ptr) as HRESULT
	GetLastPresentCount as function(byval This as IDirect3DSwapChain9Ex ptr, byval pLastPresentCount as UINT ptr) as HRESULT
	GetPresentStats as function(byval This as IDirect3DSwapChain9Ex ptr, byval pPresentationStatistics as D3DPRESENTSTATS ptr) as HRESULT
	GetDisplayModeEx as function(byval This as IDirect3DSwapChain9Ex ptr, byval pMode as D3DDISPLAYMODEEX ptr, byval pRotation as D3DDISPLAYROTATION ptr) as HRESULT
end type

#define IDirect3DSwapChain9Ex_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DSwapChain9Ex_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DSwapChain9Ex_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DSwapChain9Ex_Present(p, a, b, c, d, e) (p)->lpVtbl->Present(p, a, b, c, d, e)
#define IDirect3DSwapChain9Ex_GetFrontBufferData(p, a) (p)->lpVtbl->GetFrontBufferData(p, a)
#define IDirect3DSwapChain9EX_GetBackBuffer(p, a, b, c) (p)->lpVtbl->GetBackBuffer(p, a, b, c)
#define IDirect3DSwapChain9EX_GetRasterStatus(p, a) (p)->lpVtbl->GetRasterStatus(p, a)
#define IDirect3DSwapChain9Ex_GetDisplayMode(p, a) (p)->lpVtbl->GetDisplayMode(p, a)
#define IDirect3DSwapChain9Ex_GetDevice(p, a) (p)->lpVtbl->GetDevice(p, a)
#define IDirect3DSwapChain9Ex_GetPresentParameters(p, a) (p)->lpVtbl->GetPresentParameters(p, a)
#define IDirect3DSwapChain9Ex_GetLastPresentCount(p, a) (p)->lpVtbl->GetLastPresentCount(p, a)
#define IDirect3DSwapChain9Ex_GetPresentStats(p, a) (p)->lpVtbl->GetPresentStats(p, a)
#define IDirect3DSwapChain9Ex_GetDisplayModeEx(p, a, b) (p)->lpVtbl->GetDisplayModeEx(p, a, b)
type IDirect3DResource9Vtbl as IDirect3DResource9Vtbl_

type IDirect3DResource9
	lpVtbl as IDirect3DResource9Vtbl ptr
end type

type IDirect3DResource9Vtbl_
	QueryInterface as function(byval This as IDirect3DResource9 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DResource9 ptr) as ULONG
	Release as function(byval This as IDirect3DResource9 ptr) as ULONG
	GetDevice as function(byval This as IDirect3DResource9 ptr, byval ppDevice as IDirect3DDevice9 ptr ptr) as HRESULT
	SetPrivateData as function(byval This as IDirect3DResource9 ptr, byval guid as const GUID const ptr, byval data as const any ptr, byval data_size as DWORD, byval flags as DWORD) as HRESULT
	GetPrivateData as function(byval This as IDirect3DResource9 ptr, byval refguid as const GUID const ptr, byval pData as any ptr, byval pSizeOfData as DWORD ptr) as HRESULT
	FreePrivateData as function(byval This as IDirect3DResource9 ptr, byval refguid as const GUID const ptr) as HRESULT
	SetPriority as function(byval This as IDirect3DResource9 ptr, byval PriorityNew as DWORD) as DWORD
	GetPriority as function(byval This as IDirect3DResource9 ptr) as DWORD
	PreLoad as sub(byval This as IDirect3DResource9 ptr)
	GetType as function(byval This as IDirect3DResource9 ptr) as D3DRESOURCETYPE
end type

#define IDirect3DResource9_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DResource9_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DResource9_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DResource9_GetDevice(p, a) (p)->lpVtbl->GetDevice(p, a)
#define IDirect3DResource9_SetPrivateData(p, a, b, c, d) (p)->lpVtbl->SetPrivateData(p, a, b, c, d)
#define IDirect3DResource9_GetPrivateData(p, a, b, c) (p)->lpVtbl->GetPrivateData(p, a, b, c)
#define IDirect3DResource9_FreePrivateData(p, a) (p)->lpVtbl->FreePrivateData(p, a)
#define IDirect3DResource9_SetPriority(p, a) (p)->lpVtbl->SetPriority(p, a)
#define IDirect3DResource9_GetPriority(p) (p)->lpVtbl->GetPriority(p)
#define IDirect3DResource9_PreLoad(p) (p)->lpVtbl->PreLoad(p)
#define IDirect3DResource9_GetType(p) (p)->lpVtbl->GetType(p)
type IDirect3DSurface9Vtbl as IDirect3DSurface9Vtbl_

type IDirect3DSurface9_
	lpVtbl as IDirect3DSurface9Vtbl ptr
end type

type IDirect3DSurface9Vtbl_
	QueryInterface as function(byval This as IDirect3DSurface9 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DSurface9 ptr) as ULONG
	Release as function(byval This as IDirect3DSurface9 ptr) as ULONG
	GetDevice as function(byval This as IDirect3DSurface9 ptr, byval ppDevice as IDirect3DDevice9 ptr ptr) as HRESULT
	SetPrivateData as function(byval This as IDirect3DSurface9 ptr, byval guid as const GUID const ptr, byval data as const any ptr, byval data_size as DWORD, byval flags as DWORD) as HRESULT
	GetPrivateData as function(byval This as IDirect3DSurface9 ptr, byval refguid as const GUID const ptr, byval pData as any ptr, byval pSizeOfData as DWORD ptr) as HRESULT
	FreePrivateData as function(byval This as IDirect3DSurface9 ptr, byval refguid as const GUID const ptr) as HRESULT
	SetPriority as function(byval This as IDirect3DSurface9 ptr, byval PriorityNew as DWORD) as DWORD
	GetPriority as function(byval This as IDirect3DSurface9 ptr) as DWORD
	PreLoad as sub(byval This as IDirect3DSurface9 ptr)
	GetType as function(byval This as IDirect3DSurface9 ptr) as D3DRESOURCETYPE
	GetContainer as function(byval This as IDirect3DSurface9 ptr, byval riid as const IID const ptr, byval ppContainer as any ptr ptr) as HRESULT
	GetDesc as function(byval This as IDirect3DSurface9 ptr, byval pDesc as D3DSURFACE_DESC ptr) as HRESULT
	LockRect as function(byval This as IDirect3DSurface9 ptr, byval locked_rect as D3DLOCKED_RECT ptr, byval rect as const RECT ptr, byval flags as DWORD) as HRESULT
	UnlockRect as function(byval This as IDirect3DSurface9 ptr) as HRESULT
	GetDC as function(byval This as IDirect3DSurface9 ptr, byval phdc as HDC ptr) as HRESULT
	ReleaseDC as function(byval This as IDirect3DSurface9 ptr, byval hdc as HDC) as HRESULT
end type

#define IDirect3DSurface9_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DSurface9_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DSurface9_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DSurface9_GetDevice(p, a) (p)->lpVtbl->GetDevice(p, a)
#define IDirect3DSurface9_SetPrivateData(p, a, b, c, d) (p)->lpVtbl->SetPrivateData(p, a, b, c, d)
#define IDirect3DSurface9_GetPrivateData(p, a, b, c) (p)->lpVtbl->GetPrivateData(p, a, b, c)
#define IDirect3DSurface9_FreePrivateData(p, a) (p)->lpVtbl->FreePrivateData(p, a)
#define IDirect3DSurface9_SetPriority(p, a) (p)->lpVtbl->SetPriority(p, a)
#define IDirect3DSurface9_GetPriority(p) (p)->lpVtbl->GetPriority(p)
#define IDirect3DSurface9_PreLoad(p) (p)->lpVtbl->PreLoad(p)
#define IDirect3DSurface9_GetType(p) (p)->lpVtbl->GetType(p)
#define IDirect3DSurface9_GetContainer(p, a, b) (p)->lpVtbl->GetContainer(p, a, b)
#define IDirect3DSurface9_GetDesc(p, a) (p)->lpVtbl->GetDesc(p, a)
#define IDirect3DSurface9_LockRect(p, a, b, c) (p)->lpVtbl->LockRect(p, a, b, c)
#define IDirect3DSurface9_UnlockRect(p) (p)->lpVtbl->UnlockRect(p)
#define IDirect3DSurface9_GetDC(p, a) (p)->lpVtbl->GetDC(p, a)
#define IDirect3DSurface9_ReleaseDC(p, a) (p)->lpVtbl->ReleaseDC(p, a)
type IDirect3DVertexBuffer9Vtbl as IDirect3DVertexBuffer9Vtbl_

type IDirect3DVertexBuffer9
	lpVtbl as IDirect3DVertexBuffer9Vtbl ptr
end type

type IDirect3DVertexBuffer9Vtbl_
	QueryInterface as function(byval This as IDirect3DVertexBuffer9 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DVertexBuffer9 ptr) as ULONG
	Release as function(byval This as IDirect3DVertexBuffer9 ptr) as ULONG
	GetDevice as function(byval This as IDirect3DVertexBuffer9 ptr, byval ppDevice as IDirect3DDevice9 ptr ptr) as HRESULT
	SetPrivateData as function(byval This as IDirect3DVertexBuffer9 ptr, byval guid as const GUID const ptr, byval data as const any ptr, byval data_size as DWORD, byval flags as DWORD) as HRESULT
	GetPrivateData as function(byval This as IDirect3DVertexBuffer9 ptr, byval refguid as const GUID const ptr, byval pData as any ptr, byval pSizeOfData as DWORD ptr) as HRESULT
	FreePrivateData as function(byval This as IDirect3DVertexBuffer9 ptr, byval refguid as const GUID const ptr) as HRESULT
	SetPriority as function(byval This as IDirect3DVertexBuffer9 ptr, byval PriorityNew as DWORD) as DWORD
	GetPriority as function(byval This as IDirect3DVertexBuffer9 ptr) as DWORD
	PreLoad as sub(byval This as IDirect3DVertexBuffer9 ptr)
	GetType as function(byval This as IDirect3DVertexBuffer9 ptr) as D3DRESOURCETYPE
	Lock as function(byval This as IDirect3DVertexBuffer9 ptr, byval OffsetToLock as UINT, byval SizeToLock as UINT, byval ppbData as any ptr ptr, byval Flags as DWORD) as HRESULT
	Unlock as function(byval This as IDirect3DVertexBuffer9 ptr) as HRESULT
	GetDesc as function(byval This as IDirect3DVertexBuffer9 ptr, byval pDesc as D3DVERTEXBUFFER_DESC ptr) as HRESULT
end type

#define IDirect3DVertexBuffer9_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DVertexBuffer9_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DVertexBuffer9_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DVertexBuffer9_GetDevice(p, a) (p)->lpVtbl->GetDevice(p, a)
#define IDirect3DVertexBuffer9_SetPrivateData(p, a, b, c, d) (p)->lpVtbl->SetPrivateData(p, a, b, c, d)
#define IDirect3DVertexBuffer9_GetPrivateData(p, a, b, c) (p)->lpVtbl->GetPrivateData(p, a, b, c)
#define IDirect3DVertexBuffer9_FreePrivateData(p, a) (p)->lpVtbl->FreePrivateData(p, a)
#define IDirect3DVertexBuffer9_SetPriority(p, a) (p)->lpVtbl->SetPriority(p, a)
#define IDirect3DVertexBuffer9_GetPriority(p) (p)->lpVtbl->GetPriority(p)
#define IDirect3DVertexBuffer9_PreLoad(p) (p)->lpVtbl->PreLoad(p)
#define IDirect3DVertexBuffer9_GetType(p) (p)->lpVtbl->GetType(p)
#define IDirect3DVertexBuffer9_Lock(p, a, b, c, d) (p)->lpVtbl->Lock(p, a, b, c, d)
#define IDirect3DVertexBuffer9_Unlock(p) (p)->lpVtbl->Unlock(p)
#define IDirect3DVertexBuffer9_GetDesc(p, a) (p)->lpVtbl->GetDesc(p, a)
type IDirect3DIndexBuffer9Vtbl as IDirect3DIndexBuffer9Vtbl_

type IDirect3DIndexBuffer9
	lpVtbl as IDirect3DIndexBuffer9Vtbl ptr
end type

type IDirect3DIndexBuffer9Vtbl_
	QueryInterface as function(byval This as IDirect3DIndexBuffer9 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DIndexBuffer9 ptr) as ULONG
	Release as function(byval This as IDirect3DIndexBuffer9 ptr) as ULONG
	GetDevice as function(byval This as IDirect3DIndexBuffer9 ptr, byval ppDevice as IDirect3DDevice9 ptr ptr) as HRESULT
	SetPrivateData as function(byval This as IDirect3DIndexBuffer9 ptr, byval guid as const GUID const ptr, byval data as const any ptr, byval data_size as DWORD, byval flags as DWORD) as HRESULT
	GetPrivateData as function(byval This as IDirect3DIndexBuffer9 ptr, byval refguid as const GUID const ptr, byval pData as any ptr, byval pSizeOfData as DWORD ptr) as HRESULT
	FreePrivateData as function(byval This as IDirect3DIndexBuffer9 ptr, byval refguid as const GUID const ptr) as HRESULT
	SetPriority as function(byval This as IDirect3DIndexBuffer9 ptr, byval PriorityNew as DWORD) as DWORD
	GetPriority as function(byval This as IDirect3DIndexBuffer9 ptr) as DWORD
	PreLoad as sub(byval This as IDirect3DIndexBuffer9 ptr)
	GetType as function(byval This as IDirect3DIndexBuffer9 ptr) as D3DRESOURCETYPE
	Lock as function(byval This as IDirect3DIndexBuffer9 ptr, byval OffsetToLock as UINT, byval SizeToLock as UINT, byval ppbData as any ptr ptr, byval Flags as DWORD) as HRESULT
	Unlock as function(byval This as IDirect3DIndexBuffer9 ptr) as HRESULT
	GetDesc as function(byval This as IDirect3DIndexBuffer9 ptr, byval pDesc as D3DINDEXBUFFER_DESC ptr) as HRESULT
end type

#define IDirect3DIndexBuffer9_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DIndexBuffer9_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DIndexBuffer9_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DIndexBuffer9_GetDevice(p, a) (p)->lpVtbl->GetDevice(p, a)
#define IDirect3DIndexBuffer9_SetPrivateData(p, a, b, c, d) (p)->lpVtbl->SetPrivateData(p, a, b, c, d)
#define IDirect3DIndexBuffer9_GetPrivateData(p, a, b, c) (p)->lpVtbl->GetPrivateData(p, a, b, c)
#define IDirect3DIndexBuffer9_FreePrivateData(p, a) (p)->lpVtbl->FreePrivateData(p, a)
#define IDirect3DIndexBuffer9_SetPriority(p, a) (p)->lpVtbl->SetPriority(p, a)
#define IDirect3DIndexBuffer9_GetPriority(p) (p)->lpVtbl->GetPriority(p)
#define IDirect3DIndexBuffer9_PreLoad(p) (p)->lpVtbl->PreLoad(p)
#define IDirect3DIndexBuffer9_GetType(p) (p)->lpVtbl->GetType(p)
#define IDirect3DIndexBuffer9_Lock(p, a, b, c, d) (p)->lpVtbl->Lock(p, a, b, c, d)
#define IDirect3DIndexBuffer9_Unlock(p) (p)->lpVtbl->Unlock(p)
#define IDirect3DIndexBuffer9_GetDesc(p, a) (p)->lpVtbl->GetDesc(p, a)
type IDirect3DBaseTexture9Vtbl as IDirect3DBaseTexture9Vtbl_

type IDirect3DBaseTexture9
	lpVtbl as IDirect3DBaseTexture9Vtbl ptr
end type

type IDirect3DBaseTexture9Vtbl_
	QueryInterface as function(byval This as IDirect3DBaseTexture9 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DBaseTexture9 ptr) as ULONG
	Release as function(byval This as IDirect3DBaseTexture9 ptr) as ULONG
	GetDevice as function(byval This as IDirect3DBaseTexture9 ptr, byval ppDevice as IDirect3DDevice9 ptr ptr) as HRESULT
	SetPrivateData as function(byval This as IDirect3DBaseTexture9 ptr, byval guid as const GUID const ptr, byval data as const any ptr, byval data_size as DWORD, byval flags as DWORD) as HRESULT
	GetPrivateData as function(byval This as IDirect3DBaseTexture9 ptr, byval refguid as const GUID const ptr, byval pData as any ptr, byval pSizeOfData as DWORD ptr) as HRESULT
	FreePrivateData as function(byval This as IDirect3DBaseTexture9 ptr, byval refguid as const GUID const ptr) as HRESULT
	SetPriority as function(byval This as IDirect3DBaseTexture9 ptr, byval PriorityNew as DWORD) as DWORD
	GetPriority as function(byval This as IDirect3DBaseTexture9 ptr) as DWORD
	PreLoad as sub(byval This as IDirect3DBaseTexture9 ptr)
	GetType as function(byval This as IDirect3DBaseTexture9 ptr) as D3DRESOURCETYPE
	SetLOD as function(byval This as IDirect3DBaseTexture9 ptr, byval LODNew as DWORD) as DWORD
	GetLOD as function(byval This as IDirect3DBaseTexture9 ptr) as DWORD
	GetLevelCount as function(byval This as IDirect3DBaseTexture9 ptr) as DWORD
	SetAutoGenFilterType as function(byval This as IDirect3DBaseTexture9 ptr, byval FilterType as D3DTEXTUREFILTERTYPE) as HRESULT
	GetAutoGenFilterType as function(byval This as IDirect3DBaseTexture9 ptr) as D3DTEXTUREFILTERTYPE
	GenerateMipSubLevels as sub(byval This as IDirect3DBaseTexture9 ptr)
end type

#define IDirect3DBaseTexture9_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DBaseTexture9_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DBaseTexture9_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DBaseTexture9_GetDevice(p, a) (p)->lpVtbl->GetDevice(p, a)
#define IDirect3DBaseTexture9_SetPrivateData(p, a, b, c, d) (p)->lpVtbl->SetPrivateData(p, a, b, c, d)
#define IDirect3DBaseTexture9_GetPrivateData(p, a, b, c) (p)->lpVtbl->GetPrivateData(p, a, b, c)
#define IDirect3DBaseTexture9_FreePrivateData(p, a) (p)->lpVtbl->FreePrivateData(p, a)
#define IDirect3DBaseTexture9_SetPriority(p, a) (p)->lpVtbl->SetPriority(p, a)
#define IDirect3DBaseTexture9_GetPriority(p) (p)->lpVtbl->GetPriority(p)
#define IDirect3DBaseTexture9_PreLoad(p) (p)->lpVtbl->PreLoad(p)
#define IDirect3DBaseTexture9_GetType(p) (p)->lpVtbl->GetType(p)
#define IDirect3DBaseTexture9_SetLOD(p, a) (p)->lpVtbl->SetLOD(p, a)
#define IDirect3DBaseTexture9_GetLOD(p) (p)->lpVtbl->GetLOD(p)
#define IDirect3DBaseTexture9_GetLevelCount(p) (p)->lpVtbl->GetLevelCount(p)
#define IDirect3DBaseTexture9_SetAutoGenFilterType(p, a) (p)->lpVtbl->SetAutoGenFilterType(p, a)
#define IDirect3DBaseTexture9_GetAutoGenFilterType(p) (p)->lpVtbl->GetAutoGenFilterType(p)
#define IDirect3DBaseTexture9_GenerateMipSubLevels(p) (p)->lpVtbl->GenerateMipSubLevels(p)
type IDirect3DCubeTexture9Vtbl as IDirect3DCubeTexture9Vtbl_

type IDirect3DCubeTexture9
	lpVtbl as IDirect3DCubeTexture9Vtbl ptr
end type

type IDirect3DCubeTexture9Vtbl_
	QueryInterface as function(byval This as IDirect3DCubeTexture9 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DCubeTexture9 ptr) as ULONG
	Release as function(byval This as IDirect3DCubeTexture9 ptr) as ULONG
	GetDevice as function(byval This as IDirect3DCubeTexture9 ptr, byval ppDevice as IDirect3DDevice9 ptr ptr) as HRESULT
	SetPrivateData as function(byval This as IDirect3DCubeTexture9 ptr, byval guid as const GUID const ptr, byval data as const any ptr, byval data_size as DWORD, byval flags as DWORD) as HRESULT
	GetPrivateData as function(byval This as IDirect3DCubeTexture9 ptr, byval refguid as const GUID const ptr, byval pData as any ptr, byval pSizeOfData as DWORD ptr) as HRESULT
	FreePrivateData as function(byval This as IDirect3DCubeTexture9 ptr, byval refguid as const GUID const ptr) as HRESULT
	SetPriority as function(byval This as IDirect3DCubeTexture9 ptr, byval PriorityNew as DWORD) as DWORD
	GetPriority as function(byval This as IDirect3DCubeTexture9 ptr) as DWORD
	PreLoad as sub(byval This as IDirect3DCubeTexture9 ptr)
	GetType as function(byval This as IDirect3DCubeTexture9 ptr) as D3DRESOURCETYPE
	SetLOD as function(byval This as IDirect3DCubeTexture9 ptr, byval LODNew as DWORD) as DWORD
	GetLOD as function(byval This as IDirect3DCubeTexture9 ptr) as DWORD
	GetLevelCount as function(byval This as IDirect3DCubeTexture9 ptr) as DWORD
	SetAutoGenFilterType as function(byval This as IDirect3DCubeTexture9 ptr, byval FilterType as D3DTEXTUREFILTERTYPE) as HRESULT
	GetAutoGenFilterType as function(byval This as IDirect3DCubeTexture9 ptr) as D3DTEXTUREFILTERTYPE
	GenerateMipSubLevels as sub(byval This as IDirect3DCubeTexture9 ptr)
	GetLevelDesc as function(byval This as IDirect3DCubeTexture9 ptr, byval Level as UINT, byval pDesc as D3DSURFACE_DESC ptr) as HRESULT
	GetCubeMapSurface as function(byval This as IDirect3DCubeTexture9 ptr, byval FaceType as D3DCUBEMAP_FACES, byval Level as UINT, byval ppCubeMapSurface as IDirect3DSurface9 ptr ptr) as HRESULT
	LockRect as function(byval This as IDirect3DCubeTexture9 ptr, byval face as D3DCUBEMAP_FACES, byval level as UINT, byval locked_rect as D3DLOCKED_RECT ptr, byval rect as const RECT ptr, byval flags as DWORD) as HRESULT
	UnlockRect as function(byval This as IDirect3DCubeTexture9 ptr, byval FaceType as D3DCUBEMAP_FACES, byval Level as UINT) as HRESULT
	AddDirtyRect as function(byval This as IDirect3DCubeTexture9 ptr, byval face as D3DCUBEMAP_FACES, byval dirty_rect as const RECT ptr) as HRESULT
end type

#define IDirect3DCubeTexture9_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DCubeTexture9_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DCubeTexture9_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DCubeTexture9_GetDevice(p, a) (p)->lpVtbl->GetDevice(p, a)
#define IDirect3DCubeTexture9_SetPrivateData(p, a, b, c, d) (p)->lpVtbl->SetPrivateData(p, a, b, c, d)
#define IDirect3DCubeTexture9_GetPrivateData(p, a, b, c) (p)->lpVtbl->GetPrivateData(p, a, b, c)
#define IDirect3DCubeTexture9_FreePrivateData(p, a) (p)->lpVtbl->FreePrivateData(p, a)
#define IDirect3DCubeTexture9_SetPriority(p, a) (p)->lpVtbl->SetPriority(p, a)
#define IDirect3DCubeTexture9_GetPriority(p) (p)->lpVtbl->GetPriority(p)
#define IDirect3DCubeTexture9_PreLoad(p) (p)->lpVtbl->PreLoad(p)
#define IDirect3DCubeTexture9_GetType(p) (p)->lpVtbl->GetType(p)
#define IDirect3DCubeTexture9_SetLOD(p, a) (p)->lpVtbl->SetLOD(p, a)
#define IDirect3DCubeTexture9_GetLOD(p) (p)->lpVtbl->GetLOD(p)
#define IDirect3DCubeTexture9_GetLevelCount(p) (p)->lpVtbl->GetLevelCount(p)
#define IDirect3DCubeTexture9_SetAutoGenFilterType(p, a) (p)->lpVtbl->SetAutoGenFilterType(p, a)
#define IDirect3DCubeTexture9_GetAutoGenFilterType(p) (p)->lpVtbl->GetAutoGenFilterType(p)
#define IDirect3DCubeTexture9_GenerateMipSubLevels(p) (p)->lpVtbl->GenerateMipSubLevels(p)
#define IDirect3DCubeTexture9_GetLevelDesc(p, a, b) (p)->lpVtbl->GetLevelDesc(p, a, b)
#define IDirect3DCubeTexture9_GetCubeMapSurface(p, a, b, c) (p)->lpVtbl->GetCubeMapSurface(p, a, b, c)
#define IDirect3DCubeTexture9_LockRect(p, a, b, c, d, e) (p)->lpVtbl->LockRect(p, a, b, c, d, e)
#define IDirect3DCubeTexture9_UnlockRect(p, a, b) (p)->lpVtbl->UnlockRect(p, a, b)
#define IDirect3DCubeTexture9_AddDirtyRect(p, a, b) (p)->lpVtbl->AddDirtyRect(p, a, b)
type IDirect3DTexture9Vtbl as IDirect3DTexture9Vtbl_

type IDirect3DTexture9
	lpVtbl as IDirect3DTexture9Vtbl ptr
end type

type IDirect3DTexture9Vtbl_
	QueryInterface as function(byval This as IDirect3DTexture9 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DTexture9 ptr) as ULONG
	Release as function(byval This as IDirect3DTexture9 ptr) as ULONG
	GetDevice as function(byval This as IDirect3DTexture9 ptr, byval ppDevice as IDirect3DDevice9 ptr ptr) as HRESULT
	SetPrivateData as function(byval This as IDirect3DTexture9 ptr, byval guid as const GUID const ptr, byval data as const any ptr, byval data_size as DWORD, byval flags as DWORD) as HRESULT
	GetPrivateData as function(byval This as IDirect3DTexture9 ptr, byval refguid as const GUID const ptr, byval pData as any ptr, byval pSizeOfData as DWORD ptr) as HRESULT
	FreePrivateData as function(byval This as IDirect3DTexture9 ptr, byval refguid as const GUID const ptr) as HRESULT
	SetPriority as function(byval This as IDirect3DTexture9 ptr, byval PriorityNew as DWORD) as DWORD
	GetPriority as function(byval This as IDirect3DTexture9 ptr) as DWORD
	PreLoad as sub(byval This as IDirect3DTexture9 ptr)
	GetType as function(byval This as IDirect3DTexture9 ptr) as D3DRESOURCETYPE
	SetLOD as function(byval This as IDirect3DTexture9 ptr, byval LODNew as DWORD) as DWORD
	GetLOD as function(byval This as IDirect3DTexture9 ptr) as DWORD
	GetLevelCount as function(byval This as IDirect3DTexture9 ptr) as DWORD
	SetAutoGenFilterType as function(byval This as IDirect3DTexture9 ptr, byval FilterType as D3DTEXTUREFILTERTYPE) as HRESULT
	GetAutoGenFilterType as function(byval This as IDirect3DTexture9 ptr) as D3DTEXTUREFILTERTYPE
	GenerateMipSubLevels as sub(byval This as IDirect3DTexture9 ptr)
	GetLevelDesc as function(byval This as IDirect3DTexture9 ptr, byval Level as UINT, byval pDesc as D3DSURFACE_DESC ptr) as HRESULT
	GetSurfaceLevel as function(byval This as IDirect3DTexture9 ptr, byval Level as UINT, byval ppSurfaceLevel as IDirect3DSurface9 ptr ptr) as HRESULT
	LockRect as function(byval This as IDirect3DTexture9 ptr, byval level as UINT, byval locked_rect as D3DLOCKED_RECT ptr, byval rect as const RECT ptr, byval flags as DWORD) as HRESULT
	UnlockRect as function(byval This as IDirect3DTexture9 ptr, byval Level as UINT) as HRESULT
	AddDirtyRect as function(byval This as IDirect3DTexture9 ptr, byval dirty_rect as const RECT ptr) as HRESULT
end type

#define IDirect3DTexture9_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DTexture9_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DTexture9_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DTexture9_GetDevice(p, a) (p)->lpVtbl->GetDevice(p, a)
#define IDirect3DTexture9_SetPrivateData(p, a, b, c, d) (p)->lpVtbl->SetPrivateData(p, a, b, c, d)
#define IDirect3DTexture9_GetPrivateData(p, a, b, c) (p)->lpVtbl->GetPrivateData(p, a, b, c)
#define IDirect3DTexture9_FreePrivateData(p, a) (p)->lpVtbl->FreePrivateData(p, a)
#define IDirect3DTexture9_SetPriority(p, a) (p)->lpVtbl->SetPriority(p, a)
#define IDirect3DTexture9_GetPriority(p) (p)->lpVtbl->GetPriority(p)
#define IDirect3DTexture9_PreLoad(p) (p)->lpVtbl->PreLoad(p)
#define IDirect3DTexture9_GetType(p) (p)->lpVtbl->GetType(p)
#define IDirect3DTexture9_SetLOD(p, a) (p)->lpVtbl->SetLOD(p, a)
#define IDirect3DTexture9_GetLOD(p) (p)->lpVtbl->GetLOD(p)
#define IDirect3DTexture9_GetLevelCount(p) (p)->lpVtbl->GetLevelCount(p)
#define IDirect3DTexture9_SetAutoGenFilterType(p, a) (p)->lpVtbl->SetAutoGenFilterType(p, a)
#define IDirect3DTexture9_GetAutoGenFilterType(p) (p)->lpVtbl->GetAutoGenFilterType(p)
#define IDirect3DTexture9_GenerateMipSubLevels(p) (p)->lpVtbl->GenerateMipSubLevels(p)
#define IDirect3DTexture9_GetLevelDesc(p, a, b) (p)->lpVtbl->GetLevelDesc(p, a, b)
#define IDirect3DTexture9_GetSurfaceLevel(p, a, b) (p)->lpVtbl->GetSurfaceLevel(p, a, b)
#define IDirect3DTexture9_LockRect(p, a, b, c, d) (p)->lpVtbl->LockRect(p, a, b, c, d)
#define IDirect3DTexture9_UnlockRect(p, a) (p)->lpVtbl->UnlockRect(p, a)
#define IDirect3DTexture9_AddDirtyRect(p, a) (p)->lpVtbl->AddDirtyRect(p, a)
type IDirect3DVolumeTexture9Vtbl as IDirect3DVolumeTexture9Vtbl_

type IDirect3DVolumeTexture9
	lpVtbl as IDirect3DVolumeTexture9Vtbl ptr
end type

type IDirect3DVolumeTexture9Vtbl_
	QueryInterface as function(byval This as IDirect3DVolumeTexture9 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DVolumeTexture9 ptr) as ULONG
	Release as function(byval This as IDirect3DVolumeTexture9 ptr) as ULONG
	GetDevice as function(byval This as IDirect3DVolumeTexture9 ptr, byval ppDevice as IDirect3DDevice9 ptr ptr) as HRESULT
	SetPrivateData as function(byval This as IDirect3DVolumeTexture9 ptr, byval guid as const GUID const ptr, byval data as const any ptr, byval data_size as DWORD, byval flags as DWORD) as HRESULT
	GetPrivateData as function(byval This as IDirect3DVolumeTexture9 ptr, byval refguid as const GUID const ptr, byval pData as any ptr, byval pSizeOfData as DWORD ptr) as HRESULT
	FreePrivateData as function(byval This as IDirect3DVolumeTexture9 ptr, byval refguid as const GUID const ptr) as HRESULT
	SetPriority as function(byval This as IDirect3DVolumeTexture9 ptr, byval PriorityNew as DWORD) as DWORD
	GetPriority as function(byval This as IDirect3DVolumeTexture9 ptr) as DWORD
	PreLoad as sub(byval This as IDirect3DVolumeTexture9 ptr)
	GetType as function(byval This as IDirect3DVolumeTexture9 ptr) as D3DRESOURCETYPE
	SetLOD as function(byval This as IDirect3DVolumeTexture9 ptr, byval LODNew as DWORD) as DWORD
	GetLOD as function(byval This as IDirect3DVolumeTexture9 ptr) as DWORD
	GetLevelCount as function(byval This as IDirect3DVolumeTexture9 ptr) as DWORD
	SetAutoGenFilterType as function(byval This as IDirect3DVolumeTexture9 ptr, byval FilterType as D3DTEXTUREFILTERTYPE) as HRESULT
	GetAutoGenFilterType as function(byval This as IDirect3DVolumeTexture9 ptr) as D3DTEXTUREFILTERTYPE
	GenerateMipSubLevels as sub(byval This as IDirect3DVolumeTexture9 ptr)
	GetLevelDesc as function(byval This as IDirect3DVolumeTexture9 ptr, byval Level as UINT, byval pDesc as D3DVOLUME_DESC ptr) as HRESULT
	GetVolumeLevel as function(byval This as IDirect3DVolumeTexture9 ptr, byval Level as UINT, byval ppVolumeLevel as IDirect3DVolume9 ptr ptr) as HRESULT
	LockBox as function(byval This as IDirect3DVolumeTexture9 ptr, byval level as UINT, byval locked_box as D3DLOCKED_BOX ptr, byval box as const D3DBOX ptr, byval flags as DWORD) as HRESULT
	UnlockBox as function(byval This as IDirect3DVolumeTexture9 ptr, byval Level as UINT) as HRESULT
	AddDirtyBox as function(byval This as IDirect3DVolumeTexture9 ptr, byval dirty_box as const D3DBOX ptr) as HRESULT
end type

#define IDirect3DVolumeTexture9_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DVolumeTexture9_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DVolumeTexture9_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DVolumeTexture9_GetDevice(p, a) (p)->lpVtbl->GetDevice(p, a)
#define IDirect3DVolumeTexture9_SetPrivateData(p, a, b, c, d) (p)->lpVtbl->SetPrivateData(p, a, b, c, d)
#define IDirect3DVolumeTexture9_GetPrivateData(p, a, b, c) (p)->lpVtbl->GetPrivateData(p, a, b, c)
#define IDirect3DVolumeTexture9_FreePrivateData(p, a) (p)->lpVtbl->FreePrivateData(p, a)
#define IDirect3DVolumeTexture9_SetPriority(p, a) (p)->lpVtbl->SetPriority(p, a)
#define IDirect3DVolumeTexture9_GetPriority(p) (p)->lpVtbl->GetPriority(p)
#define IDirect3DVolumeTexture9_PreLoad(p) (p)->lpVtbl->PreLoad(p)
#define IDirect3DVolumeTexture9_GetType(p) (p)->lpVtbl->GetType(p)
#define IDirect3DVolumeTexture9_SetLOD(p, a) (p)->lpVtbl->SetLOD(p, a)
#define IDirect3DVolumeTexture9_GetLOD(p) (p)->lpVtbl->GetLOD(p)
#define IDirect3DVolumeTexture9_GetLevelCount(p) (p)->lpVtbl->GetLevelCount(p)
#define IDirect3DVolumeTexture9_SetAutoGenFilterType(p, a) (p)->lpVtbl->SetAutoGenFilterType(p, a)
#define IDirect3DVolumeTexture9_GetAutoGenFilterType(p) (p)->lpVtbl->GetAutoGenFilterType(p)
#define IDirect3DVolumeTexture9_GenerateMipSubLevels(p) (p)->lpVtbl->GenerateMipSubLevels(p)
#define IDirect3DVolumeTexture9_GetLevelDesc(p, a, b) (p)->lpVtbl->GetLevelDesc(p, a, b)
#define IDirect3DVolumeTexture9_GetVolumeLevel(p, a, b) (p)->lpVtbl->GetVolumeLevel(p, a, b)
#define IDirect3DVolumeTexture9_LockBox(p, a, b, c, d) (p)->lpVtbl->LockBox(p, a, b, c, d)
#define IDirect3DVolumeTexture9_UnlockBox(p, a) (p)->lpVtbl->UnlockBox(p, a)
#define IDirect3DVolumeTexture9_AddDirtyBox(p, a) (p)->lpVtbl->AddDirtyBox(p, a)
type IDirect3DVertexDeclaration9Vtbl as IDirect3DVertexDeclaration9Vtbl_

type IDirect3DVertexDeclaration9
	lpVtbl as IDirect3DVertexDeclaration9Vtbl ptr
end type

type IDirect3DVertexDeclaration9Vtbl_
	QueryInterface as function(byval This as IDirect3DVertexDeclaration9 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DVertexDeclaration9 ptr) as ULONG
	Release as function(byval This as IDirect3DVertexDeclaration9 ptr) as ULONG
	GetDevice as function(byval This as IDirect3DVertexDeclaration9 ptr, byval ppDevice as IDirect3DDevice9 ptr ptr) as HRESULT
	GetDeclaration as function(byval This as IDirect3DVertexDeclaration9 ptr, byval as D3DVERTEXELEMENT9 ptr, byval pNumElements as UINT ptr) as HRESULT
end type

#define IDirect3DVertexDeclaration9_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DVertexDeclaration9_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DVertexDeclaration9_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DVertexDeclaration9_GetDevice(p, a) (p)->lpVtbl->GetDevice(p, a)
#define IDirect3DVertexDeclaration9_GetDeclaration(p, a, b) (p)->lpVtbl->GetDeclaration(p, a, b)
type IDirect3DVertexShader9Vtbl as IDirect3DVertexShader9Vtbl_

type IDirect3DVertexShader9
	lpVtbl as IDirect3DVertexShader9Vtbl ptr
end type

type IDirect3DVertexShader9Vtbl_
	QueryInterface as function(byval This as IDirect3DVertexShader9 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DVertexShader9 ptr) as ULONG
	Release as function(byval This as IDirect3DVertexShader9 ptr) as ULONG
	GetDevice as function(byval This as IDirect3DVertexShader9 ptr, byval ppDevice as IDirect3DDevice9 ptr ptr) as HRESULT
	GetFunction as function(byval This as IDirect3DVertexShader9 ptr, byval as any ptr, byval pSizeOfData as UINT ptr) as HRESULT
end type

#define IDirect3DVertexShader9_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DVertexShader9_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DVertexShader9_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DVertexShader9_GetDevice(p, a) (p)->lpVtbl->GetDevice(p, a)
#define IDirect3DVertexShader9_GetFunction(p, a, b) (p)->lpVtbl->GetFunction(p, a, b)
type IDirect3DPixelShader9Vtbl as IDirect3DPixelShader9Vtbl_

type IDirect3DPixelShader9
	lpVtbl as IDirect3DPixelShader9Vtbl ptr
end type

type IDirect3DPixelShader9Vtbl_
	QueryInterface as function(byval This as IDirect3DPixelShader9 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DPixelShader9 ptr) as ULONG
	Release as function(byval This as IDirect3DPixelShader9 ptr) as ULONG
	GetDevice as function(byval This as IDirect3DPixelShader9 ptr, byval ppDevice as IDirect3DDevice9 ptr ptr) as HRESULT
	GetFunction as function(byval This as IDirect3DPixelShader9 ptr, byval as any ptr, byval pSizeOfData as UINT ptr) as HRESULT
end type

#define IDirect3DPixelShader9_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DPixelShader9_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DPixelShader9_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DPixelShader9_GetDevice(p, a) (p)->lpVtbl->GetDevice(p, a)
#define IDirect3DPixelShader9_GetFunction(p, a, b) (p)->lpVtbl->GetFunction(p, a, b)
type IDirect3DStateBlock9Vtbl as IDirect3DStateBlock9Vtbl_

type IDirect3DStateBlock9
	lpVtbl as IDirect3DStateBlock9Vtbl ptr
end type

type IDirect3DStateBlock9Vtbl_
	QueryInterface as function(byval This as IDirect3DStateBlock9 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DStateBlock9 ptr) as ULONG
	Release as function(byval This as IDirect3DStateBlock9 ptr) as ULONG
	GetDevice as function(byval This as IDirect3DStateBlock9 ptr, byval ppDevice as IDirect3DDevice9 ptr ptr) as HRESULT
	Capture as function(byval This as IDirect3DStateBlock9 ptr) as HRESULT
	Apply as function(byval This as IDirect3DStateBlock9 ptr) as HRESULT
end type

#define IDirect3DStateBlock9_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DStateBlock9_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DStateBlock9_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DStateBlock9_GetDevice(p, a) (p)->lpVtbl->GetDevice(p, a)
#define IDirect3DStateBlock9_Capture(p) (p)->lpVtbl->Capture(p)
#define IDirect3DStateBlock9_Apply(p) (p)->lpVtbl->Apply(p)
type IDirect3DQuery9Vtbl as IDirect3DQuery9Vtbl_

type IDirect3DQuery9
	lpVtbl as IDirect3DQuery9Vtbl ptr
end type

type IDirect3DQuery9Vtbl_
	QueryInterface as function(byval This as IDirect3DQuery9 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DQuery9 ptr) as ULONG
	Release as function(byval This as IDirect3DQuery9 ptr) as ULONG
	GetDevice as function(byval This as IDirect3DQuery9 ptr, byval ppDevice as IDirect3DDevice9 ptr ptr) as HRESULT
	GetType as function(byval This as IDirect3DQuery9 ptr) as D3DQUERYTYPE
	GetDataSize as function(byval This as IDirect3DQuery9 ptr) as DWORD
	Issue as function(byval This as IDirect3DQuery9 ptr, byval dwIssueFlags as DWORD) as HRESULT
	GetData as function(byval This as IDirect3DQuery9 ptr, byval pData as any ptr, byval dwSize as DWORD, byval dwGetDataFlags as DWORD) as HRESULT
end type

#define IDirect3DQuery9_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DQuery9_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DQuery9_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DQuery9_GetDevice(p, a) (p)->lpVtbl->GetDevice(p, a)
#define IDirect3DQuery9_GetType(p) (p)->lpVtbl->GetType(p)
#define IDirect3DQuery9_GetDataSize(p) (p)->lpVtbl->GetDataSize(p)
#define IDirect3DQuery9_Issue(p, a) (p)->lpVtbl->Issue(p, a)
#define IDirect3DQuery9_GetData(p, a, b, c) (p)->lpVtbl->GetData(p, a, b, c)
type IDirect3DDevice9Vtbl as IDirect3DDevice9Vtbl_

type IDirect3DDevice9_
	lpVtbl as IDirect3DDevice9Vtbl ptr
end type

type IDirect3DDevice9Vtbl_
	QueryInterface as function(byval This as IDirect3DDevice9 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DDevice9 ptr) as ULONG
	Release as function(byval This as IDirect3DDevice9 ptr) as ULONG
	TestCooperativeLevel as function(byval This as IDirect3DDevice9 ptr) as HRESULT
	GetAvailableTextureMem as function(byval This as IDirect3DDevice9 ptr) as UINT
	EvictManagedResources as function(byval This as IDirect3DDevice9 ptr) as HRESULT
	GetDirect3D as function(byval This as IDirect3DDevice9 ptr, byval ppD3D9 as IDirect3D9 ptr ptr) as HRESULT
	GetDeviceCaps as function(byval This as IDirect3DDevice9 ptr, byval pCaps as D3DCAPS9 ptr) as HRESULT
	GetDisplayMode as function(byval This as IDirect3DDevice9 ptr, byval iSwapChain as UINT, byval pMode as D3DDISPLAYMODE ptr) as HRESULT
	GetCreationParameters as function(byval This as IDirect3DDevice9 ptr, byval pParameters as D3DDEVICE_CREATION_PARAMETERS ptr) as HRESULT
	SetCursorProperties as function(byval This as IDirect3DDevice9 ptr, byval XHotSpot as UINT, byval YHotSpot as UINT, byval pCursorBitmap as IDirect3DSurface9 ptr) as HRESULT
	SetCursorPosition as sub(byval This as IDirect3DDevice9 ptr, byval X as long, byval Y as long, byval Flags as DWORD)
	ShowCursor as function(byval This as IDirect3DDevice9 ptr, byval bShow as WINBOOL) as WINBOOL
	CreateAdditionalSwapChain as function(byval This as IDirect3DDevice9 ptr, byval pPresentationParameters as D3DPRESENT_PARAMETERS ptr, byval pSwapChain as IDirect3DSwapChain9 ptr ptr) as HRESULT
	GetSwapChain as function(byval This as IDirect3DDevice9 ptr, byval iSwapChain as UINT, byval pSwapChain as IDirect3DSwapChain9 ptr ptr) as HRESULT
	GetNumberOfSwapChains as function(byval This as IDirect3DDevice9 ptr) as UINT
	Reset as function(byval This as IDirect3DDevice9 ptr, byval pPresentationParameters as D3DPRESENT_PARAMETERS ptr) as HRESULT
	Present as function(byval This as IDirect3DDevice9 ptr, byval src_rect as const RECT ptr, byval dst_rect as const RECT ptr, byval dst_window_override as HWND, byval dirty_region as const RGNDATA ptr) as HRESULT
	GetBackBuffer as function(byval This as IDirect3DDevice9 ptr, byval iSwapChain as UINT, byval iBackBuffer as UINT, byval Type as D3DBACKBUFFER_TYPE, byval ppBackBuffer as IDirect3DSurface9 ptr ptr) as HRESULT
	GetRasterStatus as function(byval This as IDirect3DDevice9 ptr, byval iSwapChain as UINT, byval pRasterStatus as D3DRASTER_STATUS ptr) as HRESULT
	SetDialogBoxMode as function(byval This as IDirect3DDevice9 ptr, byval bEnableDialogs as WINBOOL) as HRESULT
	SetGammaRamp as sub(byval This as IDirect3DDevice9 ptr, byval swapchain_idx as UINT, byval flags as DWORD, byval ramp as const D3DGAMMARAMP ptr)
	GetGammaRamp as sub(byval This as IDirect3DDevice9 ptr, byval iSwapChain as UINT, byval pRamp as D3DGAMMARAMP ptr)
	CreateTexture as function(byval This as IDirect3DDevice9 ptr, byval Width as UINT, byval Height as UINT, byval Levels as UINT, byval Usage as DWORD, byval Format as D3DFORMAT, byval Pool as D3DPOOL, byval ppTexture as IDirect3DTexture9 ptr ptr, byval pSharedHandle as HANDLE ptr) as HRESULT
	CreateVolumeTexture as function(byval This as IDirect3DDevice9 ptr, byval Width as UINT, byval Height as UINT, byval Depth as UINT, byval Levels as UINT, byval Usage as DWORD, byval Format as D3DFORMAT, byval Pool as D3DPOOL, byval ppVolumeTexture as IDirect3DVolumeTexture9 ptr ptr, byval pSharedHandle as HANDLE ptr) as HRESULT
	CreateCubeTexture as function(byval This as IDirect3DDevice9 ptr, byval EdgeLength as UINT, byval Levels as UINT, byval Usage as DWORD, byval Format as D3DFORMAT, byval Pool as D3DPOOL, byval ppCubeTexture as IDirect3DCubeTexture9 ptr ptr, byval pSharedHandle as HANDLE ptr) as HRESULT
	CreateVertexBuffer as function(byval This as IDirect3DDevice9 ptr, byval Length as UINT, byval Usage as DWORD, byval FVF as DWORD, byval Pool as D3DPOOL, byval ppVertexBuffer as IDirect3DVertexBuffer9 ptr ptr, byval pSharedHandle as HANDLE ptr) as HRESULT
	CreateIndexBuffer as function(byval This as IDirect3DDevice9 ptr, byval Length as UINT, byval Usage as DWORD, byval Format as D3DFORMAT, byval Pool as D3DPOOL, byval ppIndexBuffer as IDirect3DIndexBuffer9 ptr ptr, byval pSharedHandle as HANDLE ptr) as HRESULT
	CreateRenderTarget as function(byval This as IDirect3DDevice9 ptr, byval Width as UINT, byval Height as UINT, byval Format as D3DFORMAT, byval MultiSample as D3DMULTISAMPLE_TYPE, byval MultisampleQuality as DWORD, byval Lockable as WINBOOL, byval ppSurface as IDirect3DSurface9 ptr ptr, byval pSharedHandle as HANDLE ptr) as HRESULT
	CreateDepthStencilSurface as function(byval This as IDirect3DDevice9 ptr, byval Width as UINT, byval Height as UINT, byval Format as D3DFORMAT, byval MultiSample as D3DMULTISAMPLE_TYPE, byval MultisampleQuality as DWORD, byval Discard as WINBOOL, byval ppSurface as IDirect3DSurface9 ptr ptr, byval pSharedHandle as HANDLE ptr) as HRESULT
	UpdateSurface as function(byval This as IDirect3DDevice9 ptr, byval src_surface as IDirect3DSurface9 ptr, byval src_rect as const RECT ptr, byval dst_surface as IDirect3DSurface9 ptr, byval dst_point as const POINT ptr) as HRESULT
	UpdateTexture as function(byval This as IDirect3DDevice9 ptr, byval pSourceTexture as IDirect3DBaseTexture9 ptr, byval pDestinationTexture as IDirect3DBaseTexture9 ptr) as HRESULT
	GetRenderTargetData as function(byval This as IDirect3DDevice9 ptr, byval pRenderTarget as IDirect3DSurface9 ptr, byval pDestSurface as IDirect3DSurface9 ptr) as HRESULT
	GetFrontBufferData as function(byval This as IDirect3DDevice9 ptr, byval iSwapChain as UINT, byval pDestSurface as IDirect3DSurface9 ptr) as HRESULT
	StretchRect as function(byval This as IDirect3DDevice9 ptr, byval src_surface as IDirect3DSurface9 ptr, byval src_rect as const RECT ptr, byval dst_surface as IDirect3DSurface9 ptr, byval dst_rect as const RECT ptr, byval filter as D3DTEXTUREFILTERTYPE) as HRESULT
	ColorFill as function(byval This as IDirect3DDevice9 ptr, byval surface as IDirect3DSurface9 ptr, byval rect as const RECT ptr, byval color as D3DCOLOR) as HRESULT
	CreateOffscreenPlainSurface as function(byval This as IDirect3DDevice9 ptr, byval Width as UINT, byval Height as UINT, byval Format as D3DFORMAT, byval Pool as D3DPOOL, byval ppSurface as IDirect3DSurface9 ptr ptr, byval pSharedHandle as HANDLE ptr) as HRESULT
	SetRenderTarget as function(byval This as IDirect3DDevice9 ptr, byval RenderTargetIndex as DWORD, byval pRenderTarget as IDirect3DSurface9 ptr) as HRESULT
	GetRenderTarget as function(byval This as IDirect3DDevice9 ptr, byval RenderTargetIndex as DWORD, byval ppRenderTarget as IDirect3DSurface9 ptr ptr) as HRESULT
	SetDepthStencilSurface as function(byval This as IDirect3DDevice9 ptr, byval pNewZStencil as IDirect3DSurface9 ptr) as HRESULT
	GetDepthStencilSurface as function(byval This as IDirect3DDevice9 ptr, byval ppZStencilSurface as IDirect3DSurface9 ptr ptr) as HRESULT
	BeginScene as function(byval This as IDirect3DDevice9 ptr) as HRESULT
	EndScene as function(byval This as IDirect3DDevice9 ptr) as HRESULT
	Clear as function(byval This as IDirect3DDevice9 ptr, byval rect_count as DWORD, byval rects as const D3DRECT ptr, byval flags as DWORD, byval color as D3DCOLOR, byval z as single, byval stencil as DWORD) as HRESULT
	SetTransform as function(byval This as IDirect3DDevice9 ptr, byval state as D3DTRANSFORMSTATETYPE, byval matrix as const D3DMATRIX ptr) as HRESULT
	GetTransform as function(byval This as IDirect3DDevice9 ptr, byval State as D3DTRANSFORMSTATETYPE, byval pMatrix as D3DMATRIX ptr) as HRESULT
	MultiplyTransform as function(byval This as IDirect3DDevice9 ptr, byval state as D3DTRANSFORMSTATETYPE, byval matrix as const D3DMATRIX ptr) as HRESULT
	SetViewport as function(byval This as IDirect3DDevice9 ptr, byval viewport as const D3DVIEWPORT9 ptr) as HRESULT
	GetViewport as function(byval This as IDirect3DDevice9 ptr, byval pViewport as D3DVIEWPORT9 ptr) as HRESULT
	SetMaterial as function(byval This as IDirect3DDevice9 ptr, byval material as const D3DMATERIAL9 ptr) as HRESULT
	GetMaterial as function(byval This as IDirect3DDevice9 ptr, byval pMaterial as D3DMATERIAL9 ptr) as HRESULT
	SetLight as function(byval This as IDirect3DDevice9 ptr, byval index as DWORD, byval light as const D3DLIGHT9 ptr) as HRESULT
	GetLight as function(byval This as IDirect3DDevice9 ptr, byval Index as DWORD, byval as D3DLIGHT9 ptr) as HRESULT
	LightEnable as function(byval This as IDirect3DDevice9 ptr, byval Index as DWORD, byval Enable as WINBOOL) as HRESULT
	GetLightEnable as function(byval This as IDirect3DDevice9 ptr, byval Index as DWORD, byval pEnable as WINBOOL ptr) as HRESULT
	SetClipPlane as function(byval This as IDirect3DDevice9 ptr, byval index as DWORD, byval plane as const single ptr) as HRESULT
	GetClipPlane as function(byval This as IDirect3DDevice9 ptr, byval Index as DWORD, byval pPlane as single ptr) as HRESULT
	SetRenderState as function(byval This as IDirect3DDevice9 ptr, byval State as D3DRENDERSTATETYPE, byval Value as DWORD) as HRESULT
	GetRenderState as function(byval This as IDirect3DDevice9 ptr, byval State as D3DRENDERSTATETYPE, byval pValue as DWORD ptr) as HRESULT
	CreateStateBlock as function(byval This as IDirect3DDevice9 ptr, byval Type as D3DSTATEBLOCKTYPE, byval ppSB as IDirect3DStateBlock9 ptr ptr) as HRESULT
	BeginStateBlock as function(byval This as IDirect3DDevice9 ptr) as HRESULT
	EndStateBlock as function(byval This as IDirect3DDevice9 ptr, byval ppSB as IDirect3DStateBlock9 ptr ptr) as HRESULT
	SetClipStatus as function(byval This as IDirect3DDevice9 ptr, byval clip_status as const D3DCLIPSTATUS9 ptr) as HRESULT
	GetClipStatus as function(byval This as IDirect3DDevice9 ptr, byval pClipStatus as D3DCLIPSTATUS9 ptr) as HRESULT
	GetTexture as function(byval This as IDirect3DDevice9 ptr, byval Stage as DWORD, byval ppTexture as IDirect3DBaseTexture9 ptr ptr) as HRESULT
	SetTexture as function(byval This as IDirect3DDevice9 ptr, byval Stage as DWORD, byval pTexture as IDirect3DBaseTexture9 ptr) as HRESULT
	GetTextureStageState as function(byval This as IDirect3DDevice9 ptr, byval Stage as DWORD, byval Type as D3DTEXTURESTAGESTATETYPE, byval pValue as DWORD ptr) as HRESULT
	SetTextureStageState as function(byval This as IDirect3DDevice9 ptr, byval Stage as DWORD, byval Type as D3DTEXTURESTAGESTATETYPE, byval Value as DWORD) as HRESULT
	GetSamplerState as function(byval This as IDirect3DDevice9 ptr, byval Sampler as DWORD, byval Type as D3DSAMPLERSTATETYPE, byval pValue as DWORD ptr) as HRESULT
	SetSamplerState as function(byval This as IDirect3DDevice9 ptr, byval Sampler as DWORD, byval Type as D3DSAMPLERSTATETYPE, byval Value as DWORD) as HRESULT
	ValidateDevice as function(byval This as IDirect3DDevice9 ptr, byval pNumPasses as DWORD ptr) as HRESULT
	SetPaletteEntries as function(byval This as IDirect3DDevice9 ptr, byval palette_idx as UINT, byval entries as const PALETTEENTRY ptr) as HRESULT
	GetPaletteEntries as function(byval This as IDirect3DDevice9 ptr, byval PaletteNumber as UINT, byval pEntries as PALETTEENTRY ptr) as HRESULT
	SetCurrentTexturePalette as function(byval This as IDirect3DDevice9 ptr, byval PaletteNumber as UINT) as HRESULT
	GetCurrentTexturePalette as function(byval This as IDirect3DDevice9 ptr, byval PaletteNumber as UINT ptr) as HRESULT
	SetScissorRect as function(byval This as IDirect3DDevice9 ptr, byval rect as const RECT ptr) as HRESULT
	GetScissorRect as function(byval This as IDirect3DDevice9 ptr, byval pRect as RECT ptr) as HRESULT
	SetSoftwareVertexProcessing as function(byval This as IDirect3DDevice9 ptr, byval bSoftware as WINBOOL) as HRESULT
	GetSoftwareVertexProcessing as function(byval This as IDirect3DDevice9 ptr) as WINBOOL
	SetNPatchMode as function(byval This as IDirect3DDevice9 ptr, byval nSegments as single) as HRESULT
	GetNPatchMode as function(byval This as IDirect3DDevice9 ptr) as single
	DrawPrimitive as function(byval This as IDirect3DDevice9 ptr, byval PrimitiveType as D3DPRIMITIVETYPE, byval StartVertex as UINT, byval PrimitiveCount as UINT) as HRESULT
	DrawIndexedPrimitive as function(byval This as IDirect3DDevice9 ptr, byval as D3DPRIMITIVETYPE, byval BaseVertexIndex as INT_, byval MinVertexIndex as UINT, byval NumVertices as UINT, byval startIndex as UINT, byval primCount as UINT) as HRESULT
	DrawPrimitiveUP as function(byval This as IDirect3DDevice9 ptr, byval primitive_type as D3DPRIMITIVETYPE, byval primitive_count as UINT, byval data as const any ptr, byval stride as UINT) as HRESULT
	DrawIndexedPrimitiveUP as function(byval This as IDirect3DDevice9 ptr, byval primitive_type as D3DPRIMITIVETYPE, byval min_vertex_idx as UINT, byval vertex_count as UINT, byval primitive_count as UINT, byval index_data as const any ptr, byval index_format as D3DFORMAT, byval data as const any ptr, byval stride as UINT) as HRESULT
	ProcessVertices as function(byval This as IDirect3DDevice9 ptr, byval SrcStartIndex as UINT, byval DestIndex as UINT, byval VertexCount as UINT, byval pDestBuffer as IDirect3DVertexBuffer9 ptr, byval pVertexDecl as IDirect3DVertexDeclaration9 ptr, byval Flags as DWORD) as HRESULT
	CreateVertexDeclaration as function(byval This as IDirect3DDevice9 ptr, byval elements as const D3DVERTEXELEMENT9 ptr, byval declaration as IDirect3DVertexDeclaration9 ptr ptr) as HRESULT
	SetVertexDeclaration as function(byval This as IDirect3DDevice9 ptr, byval pDecl as IDirect3DVertexDeclaration9 ptr) as HRESULT
	GetVertexDeclaration as function(byval This as IDirect3DDevice9 ptr, byval ppDecl as IDirect3DVertexDeclaration9 ptr ptr) as HRESULT
	SetFVF as function(byval This as IDirect3DDevice9 ptr, byval FVF as DWORD) as HRESULT
	GetFVF as function(byval This as IDirect3DDevice9 ptr, byval pFVF as DWORD ptr) as HRESULT
	CreateVertexShader as function(byval This as IDirect3DDevice9 ptr, byval byte_code as const DWORD ptr, byval shader as IDirect3DVertexShader9 ptr ptr) as HRESULT
	SetVertexShader as function(byval This as IDirect3DDevice9 ptr, byval pShader as IDirect3DVertexShader9 ptr) as HRESULT
	GetVertexShader as function(byval This as IDirect3DDevice9 ptr, byval ppShader as IDirect3DVertexShader9 ptr ptr) as HRESULT
	SetVertexShaderConstantF as function(byval This as IDirect3DDevice9 ptr, byval reg_idx as UINT, byval data as const single ptr, byval count as UINT) as HRESULT
	GetVertexShaderConstantF as function(byval This as IDirect3DDevice9 ptr, byval StartRegister as UINT, byval pConstantData as single ptr, byval Vector4fCount as UINT) as HRESULT
	SetVertexShaderConstantI as function(byval This as IDirect3DDevice9 ptr, byval reg_idx as UINT, byval data as const long ptr, byval count as UINT) as HRESULT
	GetVertexShaderConstantI as function(byval This as IDirect3DDevice9 ptr, byval StartRegister as UINT, byval pConstantData as long ptr, byval Vector4iCount as UINT) as HRESULT
	SetVertexShaderConstantB as function(byval This as IDirect3DDevice9 ptr, byval reg_idx as UINT, byval data as const WINBOOL ptr, byval count as UINT) as HRESULT
	GetVertexShaderConstantB as function(byval This as IDirect3DDevice9 ptr, byval StartRegister as UINT, byval pConstantData as WINBOOL ptr, byval BoolCount as UINT) as HRESULT
	SetStreamSource as function(byval This as IDirect3DDevice9 ptr, byval StreamNumber as UINT, byval pStreamData as IDirect3DVertexBuffer9 ptr, byval OffsetInBytes as UINT, byval Stride as UINT) as HRESULT
	GetStreamSource as function(byval This as IDirect3DDevice9 ptr, byval StreamNumber as UINT, byval ppStreamData as IDirect3DVertexBuffer9 ptr ptr, byval OffsetInBytes as UINT ptr, byval pStride as UINT ptr) as HRESULT
	SetStreamSourceFreq as function(byval This as IDirect3DDevice9 ptr, byval StreamNumber as UINT, byval Divider as UINT) as HRESULT
	GetStreamSourceFreq as function(byval This as IDirect3DDevice9 ptr, byval StreamNumber as UINT, byval Divider as UINT ptr) as HRESULT
	SetIndices as function(byval This as IDirect3DDevice9 ptr, byval pIndexData as IDirect3DIndexBuffer9 ptr) as HRESULT
	GetIndices as function(byval This as IDirect3DDevice9 ptr, byval ppIndexData as IDirect3DIndexBuffer9 ptr ptr) as HRESULT
	CreatePixelShader as function(byval This as IDirect3DDevice9 ptr, byval byte_code as const DWORD ptr, byval shader as IDirect3DPixelShader9 ptr ptr) as HRESULT
	SetPixelShader as function(byval This as IDirect3DDevice9 ptr, byval pShader as IDirect3DPixelShader9 ptr) as HRESULT
	GetPixelShader as function(byval This as IDirect3DDevice9 ptr, byval ppShader as IDirect3DPixelShader9 ptr ptr) as HRESULT
	SetPixelShaderConstantF as function(byval This as IDirect3DDevice9 ptr, byval reg_idx as UINT, byval data as const single ptr, byval count as UINT) as HRESULT
	GetPixelShaderConstantF as function(byval This as IDirect3DDevice9 ptr, byval StartRegister as UINT, byval pConstantData as single ptr, byval Vector4fCount as UINT) as HRESULT
	SetPixelShaderConstantI as function(byval This as IDirect3DDevice9 ptr, byval reg_idx as UINT, byval data as const long ptr, byval count as UINT) as HRESULT
	GetPixelShaderConstantI as function(byval This as IDirect3DDevice9 ptr, byval StartRegister as UINT, byval pConstantData as long ptr, byval Vector4iCount as UINT) as HRESULT
	SetPixelShaderConstantB as function(byval This as IDirect3DDevice9 ptr, byval reg_idx as UINT, byval data as const WINBOOL ptr, byval count as UINT) as HRESULT
	GetPixelShaderConstantB as function(byval This as IDirect3DDevice9 ptr, byval StartRegister as UINT, byval pConstantData as WINBOOL ptr, byval BoolCount as UINT) as HRESULT
	DrawRectPatch as function(byval This as IDirect3DDevice9 ptr, byval handle as UINT, byval segment_count as const single ptr, byval patch_info as const D3DRECTPATCH_INFO ptr) as HRESULT
	DrawTriPatch as function(byval This as IDirect3DDevice9 ptr, byval handle as UINT, byval segment_count as const single ptr, byval patch_info as const D3DTRIPATCH_INFO ptr) as HRESULT
	DeletePatch as function(byval This as IDirect3DDevice9 ptr, byval Handle as UINT) as HRESULT
	CreateQuery as function(byval This as IDirect3DDevice9 ptr, byval Type as D3DQUERYTYPE, byval ppQuery as IDirect3DQuery9 ptr ptr) as HRESULT
end type

#define IDirect3DDevice9_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DDevice9_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DDevice9_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DDevice9_TestCooperativeLevel(p) (p)->lpVtbl->TestCooperativeLevel(p)
#define IDirect3DDevice9_GetAvailableTextureMem(p) (p)->lpVtbl->GetAvailableTextureMem(p)
#define IDirect3DDevice9_EvictManagedResources(p) (p)->lpVtbl->EvictManagedResources(p)
#define IDirect3DDevice9_GetDirect3D(p, a) (p)->lpVtbl->GetDirect3D(p, a)
#define IDirect3DDevice9_GetDeviceCaps(p, a) (p)->lpVtbl->GetDeviceCaps(p, a)
#define IDirect3DDevice9_GetDisplayMode(p, a, b) (p)->lpVtbl->GetDisplayMode(p, a, b)
#define IDirect3DDevice9_GetCreationParameters(p, a) (p)->lpVtbl->GetCreationParameters(p, a)
#define IDirect3DDevice9_SetCursorProperties(p, a, b, c) (p)->lpVtbl->SetCursorProperties(p, a, b, c)
#define IDirect3DDevice9_SetCursorPosition(p, a, b, c) (p)->lpVtbl->SetCursorPosition(p, a, b, c)
#define IDirect3DDevice9_ShowCursor(p, a) (p)->lpVtbl->ShowCursor(p, a)
#define IDirect3DDevice9_CreateAdditionalSwapChain(p, a, b) (p)->lpVtbl->CreateAdditionalSwapChain(p, a, b)
#define IDirect3DDevice9_GetSwapChain(p, a, b) (p)->lpVtbl->GetSwapChain(p, a, b)
#define IDirect3DDevice9_GetNumberOfSwapChains(p) (p)->lpVtbl->GetNumberOfSwapChains(p)
#define IDirect3DDevice9_Reset(p, a) (p)->lpVtbl->Reset(p, a)
#define IDirect3DDevice9_Present(p, a, b, c, d) (p)->lpVtbl->Present(p, a, b, c, d)
#define IDirect3DDevice9_GetBackBuffer(p, a, b, c, d) (p)->lpVtbl->GetBackBuffer(p, a, b, c, d)
#define IDirect3DDevice9_GetRasterStatus(p, a, b) (p)->lpVtbl->GetRasterStatus(p, a, b)
#define IDirect3DDevice9_SetDialogBoxMode(p, a) (p)->lpVtbl->SetDialogBoxMode(p, a)
#define IDirect3DDevice9_SetGammaRamp(p, a, b, c) (p)->lpVtbl->SetGammaRamp(p, a, b, c)
#define IDirect3DDevice9_GetGammaRamp(p, a, b) (p)->lpVtbl->GetGammaRamp(p, a, b)
#define IDirect3DDevice9_CreateTexture(p, a, b, c, d, e, f, g, h) (p)->lpVtbl->CreateTexture(p, a, b, c, d, e, f, g, h)
#define IDirect3DDevice9_CreateVolumeTexture(p, a, b, c, d, e, f, g, h, i) (p)->lpVtbl->CreateVolumeTexture(p, a, b, c, d, e, f, g, h, i)
#define IDirect3DDevice9_CreateCubeTexture(p, a, b, c, d, e, f, g) (p)->lpVtbl->CreateCubeTexture(p, a, b, c, d, e, f, g)
#define IDirect3DDevice9_CreateVertexBuffer(p, a, b, c, d, e, f) (p)->lpVtbl->CreateVertexBuffer(p, a, b, c, d, e, f)
#define IDirect3DDevice9_CreateIndexBuffer(p, a, b, c, d, e, f) (p)->lpVtbl->CreateIndexBuffer(p, a, b, c, d, e, f)
#define IDirect3DDevice9_CreateRenderTarget(p, a, b, c, d, e, f, g, h) (p)->lpVtbl->CreateRenderTarget(p, a, b, c, d, e, f, g, h)
#define IDirect3DDevice9_CreateDepthStencilSurface(p, a, b, c, d, e, f, g, h) (p)->lpVtbl->CreateDepthStencilSurface(p, a, b, c, d, e, f, g, h)
#define IDirect3DDevice9_UpdateSurface(p, a, b, c, d) (p)->lpVtbl->UpdateSurface(p, a, b, c, d)
#define IDirect3DDevice9_UpdateTexture(p, a, b) (p)->lpVtbl->UpdateTexture(p, a, b)
#define IDirect3DDevice9_GetRenderTargetData(p, a, b) (p)->lpVtbl->GetRenderTargetData(p, a, b)
#define IDirect3DDevice9_GetFrontBufferData(p, a, b) (p)->lpVtbl->GetFrontBufferData(p, a, b)
#define IDirect3DDevice9_StretchRect(p, a, b, c, d, e) (p)->lpVtbl->StretchRect(p, a, b, c, d, e)
#define IDirect3DDevice9_ColorFill(p, a, b, c) (p)->lpVtbl->ColorFill(p, a, b, c)
#define IDirect3DDevice9_CreateOffscreenPlainSurface(p, a, b, c, d, e, f) (p)->lpVtbl->CreateOffscreenPlainSurface(p, a, b, c, d, e, f)
#define IDirect3DDevice9_SetRenderTarget(p, a, b) (p)->lpVtbl->SetRenderTarget(p, a, b)
#define IDirect3DDevice9_GetRenderTarget(p, a, b) (p)->lpVtbl->GetRenderTarget(p, a, b)
#define IDirect3DDevice9_SetDepthStencilSurface(p, a) (p)->lpVtbl->SetDepthStencilSurface(p, a)
#define IDirect3DDevice9_GetDepthStencilSurface(p, a) (p)->lpVtbl->GetDepthStencilSurface(p, a)
#define IDirect3DDevice9_BeginScene(p) (p)->lpVtbl->BeginScene(p)
#define IDirect3DDevice9_EndScene(p) (p)->lpVtbl->EndScene(p)
#define IDirect3DDevice9_Clear(p, a, b, c, d, e, f) (p)->lpVtbl->Clear(p, a, b, c, d, e, f)
#define IDirect3DDevice9_SetTransform(p, a, b) (p)->lpVtbl->SetTransform(p, a, b)
#define IDirect3DDevice9_GetTransform(p, a, b) (p)->lpVtbl->GetTransform(p, a, b)
#define IDirect3DDevice9_MultiplyTransform(p, a, b) (p)->lpVtbl->MultiplyTransform(p, a, b)
#define IDirect3DDevice9_SetViewport(p, a) (p)->lpVtbl->SetViewport(p, a)
#define IDirect3DDevice9_GetViewport(p, a) (p)->lpVtbl->GetViewport(p, a)
#define IDirect3DDevice9_SetMaterial(p, a) (p)->lpVtbl->SetMaterial(p, a)
#define IDirect3DDevice9_GetMaterial(p, a) (p)->lpVtbl->GetMaterial(p, a)
#define IDirect3DDevice9_SetLight(p, a, b) (p)->lpVtbl->SetLight(p, a, b)
#define IDirect3DDevice9_GetLight(p, a, b) (p)->lpVtbl->GetLight(p, a, b)
#define IDirect3DDevice9_LightEnable(p, a, b) (p)->lpVtbl->LightEnable(p, a, b)
#define IDirect3DDevice9_GetLightEnable(p, a, b) (p)->lpVtbl->GetLightEnable(p, a, b)
#define IDirect3DDevice9_SetClipPlane(p, a, b) (p)->lpVtbl->SetClipPlane(p, a, b)
#define IDirect3DDevice9_GetClipPlane(p, a, b) (p)->lpVtbl->GetClipPlane(p, a, b)
#define IDirect3DDevice9_SetRenderState(p, a, b) (p)->lpVtbl->SetRenderState(p, a, b)
#define IDirect3DDevice9_GetRenderState(p, a, b) (p)->lpVtbl->GetRenderState(p, a, b)
#define IDirect3DDevice9_CreateStateBlock(p, a, b) (p)->lpVtbl->CreateStateBlock(p, a, b)
#define IDirect3DDevice9_BeginStateBlock(p) (p)->lpVtbl->BeginStateBlock(p)
#define IDirect3DDevice9_EndStateBlock(p, a) (p)->lpVtbl->EndStateBlock(p, a)
#define IDirect3DDevice9_SetClipStatus(p, a) (p)->lpVtbl->SetClipStatus(p, a)
#define IDirect3DDevice9_GetClipStatus(p, a) (p)->lpVtbl->GetClipStatus(p, a)
#define IDirect3DDevice9_GetTexture(p, a, b) (p)->lpVtbl->GetTexture(p, a, b)
#define IDirect3DDevice9_SetTexture(p, a, b) (p)->lpVtbl->SetTexture(p, a, b)
#define IDirect3DDevice9_GetTextureStageState(p, a, b, c) (p)->lpVtbl->GetTextureStageState(p, a, b, c)
#define IDirect3DDevice9_SetTextureStageState(p, a, b, c) (p)->lpVtbl->SetTextureStageState(p, a, b, c)
#define IDirect3DDevice9_GetSamplerState(p, a, b, c) (p)->lpVtbl->GetSamplerState(p, a, b, c)
#define IDirect3DDevice9_SetSamplerState(p, a, b, c) (p)->lpVtbl->SetSamplerState(p, a, b, c)
#define IDirect3DDevice9_ValidateDevice(p, a) (p)->lpVtbl->ValidateDevice(p, a)
#define IDirect3DDevice9_SetPaletteEntries(p, a, b) (p)->lpVtbl->SetPaletteEntries(p, a, b)
#define IDirect3DDevice9_GetPaletteEntries(p, a, b) (p)->lpVtbl->GetPaletteEntries(p, a, b)
#define IDirect3DDevice9_SetCurrentTexturePalette(p, a) (p)->lpVtbl->SetCurrentTexturePalette(p, a)
#define IDirect3DDevice9_GetCurrentTexturePalette(p, a) (p)->lpVtbl->GetCurrentTexturePalette(p, a)
#define IDirect3DDevice9_SetScissorRect(p, a) (p)->lpVtbl->SetScissorRect(p, a)
#define IDirect3DDevice9_GetScissorRect(p, a) (p)->lpVtbl->GetScissorRect(p, a)
#define IDirect3DDevice9_SetSoftwareVertexProcessing(p, a) (p)->lpVtbl->SetSoftwareVertexProcessing(p, a)
#define IDirect3DDevice9_GetSoftwareVertexProcessing(p) (p)->lpVtbl->GetSoftwareVertexProcessing(p)
#define IDirect3DDevice9_SetNPatchMode(p, a) (p)->lpVtbl->SetNPatchMode(p, a)
#define IDirect3DDevice9_GetNPatchMode(p) (p)->lpVtbl->GetNPatchMode(p)
#define IDirect3DDevice9_DrawPrimitive(p, a, b, c) (p)->lpVtbl->DrawPrimitive(p, a, b, c)
#define IDirect3DDevice9_DrawIndexedPrimitive(p, a, b, c, d, e, f) (p)->lpVtbl->DrawIndexedPrimitive(p, a, b, c, d, e, f)
#define IDirect3DDevice9_DrawPrimitiveUP(p, a, b, c, d) (p)->lpVtbl->DrawPrimitiveUP(p, a, b, c, d)
#define IDirect3DDevice9_DrawIndexedPrimitiveUP(p, a, b, c, d, e, f, g, h) (p)->lpVtbl->DrawIndexedPrimitiveUP(p, a, b, c, d, e, f, g, h)
#define IDirect3DDevice9_ProcessVertices(p, a, b, c, d, e, f) (p)->lpVtbl->ProcessVertices(p, a, b, c, d, e, f)
#define IDirect3DDevice9_CreateVertexDeclaration(p, a, b) (p)->lpVtbl->CreateVertexDeclaration(p, a, b)
#define IDirect3DDevice9_SetVertexDeclaration(p, a) (p)->lpVtbl->SetVertexDeclaration(p, a)
#define IDirect3DDevice9_GetVertexDeclaration(p, a) (p)->lpVtbl->GetVertexDeclaration(p, a)
#define IDirect3DDevice9_SetFVF(p, a) (p)->lpVtbl->SetFVF(p, a)
#define IDirect3DDevice9_GetFVF(p, a) (p)->lpVtbl->GetFVF(p, a)
#define IDirect3DDevice9_CreateVertexShader(p, a, b) (p)->lpVtbl->CreateVertexShader(p, a, b)
#define IDirect3DDevice9_SetVertexShader(p, a) (p)->lpVtbl->SetVertexShader(p, a)
#define IDirect3DDevice9_GetVertexShader(p, a) (p)->lpVtbl->GetVertexShader(p, a)
#define IDirect3DDevice9_SetVertexShaderConstantF(p, a, b, c) (p)->lpVtbl->SetVertexShaderConstantF(p, a, b, c)
#define IDirect3DDevice9_GetVertexShaderConstantF(p, a, b, c) (p)->lpVtbl->GetVertexShaderConstantF(p, a, b, c)
#define IDirect3DDevice9_SetVertexShaderConstantI(p, a, b, c) (p)->lpVtbl->SetVertexShaderConstantI(p, a, b, c)
#define IDirect3DDevice9_GetVertexShaderConstantI(p, a, b, c) (p)->lpVtbl->GetVertexShaderConstantI(p, a, b, c)
#define IDirect3DDevice9_SetVertexShaderConstantB(p, a, b, c) (p)->lpVtbl->SetVertexShaderConstantB(p, a, b, c)
#define IDirect3DDevice9_GetVertexShaderConstantB(p, a, b, c) (p)->lpVtbl->GetVertexShaderConstantB(p, a, b, c)
#define IDirect3DDevice9_SetStreamSource(p, a, b, c, d) (p)->lpVtbl->SetStreamSource(p, a, b, c, d)
#define IDirect3DDevice9_GetStreamSource(p, a, b, c, d) (p)->lpVtbl->GetStreamSource(p, a, b, c, d)
#define IDirect3DDevice9_SetStreamSourceFreq(p, a, b) (p)->lpVtbl->SetStreamSourceFreq(p, a, b)
#define IDirect3DDevice9_GetStreamSourceFreq(p, a, b) (p)->lpVtbl->GetStreamSourceFreq(p, a, b)
#define IDirect3DDevice9_SetIndices(p, a) (p)->lpVtbl->SetIndices(p, a)
#define IDirect3DDevice9_GetIndices(p, a) (p)->lpVtbl->GetIndices(p, a)
#define IDirect3DDevice9_CreatePixelShader(p, a, b) (p)->lpVtbl->CreatePixelShader(p, a, b)
#define IDirect3DDevice9_SetPixelShader(p, a) (p)->lpVtbl->SetPixelShader(p, a)
#define IDirect3DDevice9_GetPixelShader(p, a) (p)->lpVtbl->GetPixelShader(p, a)
#define IDirect3DDevice9_SetPixelShaderConstantF(p, a, b, c) (p)->lpVtbl->SetPixelShaderConstantF(p, a, b, c)
#define IDirect3DDevice9_GetPixelShaderConstantF(p, a, b, c) (p)->lpVtbl->GetPixelShaderConstantF(p, a, b, c)
#define IDirect3DDevice9_SetPixelShaderConstantI(p, a, b, c) (p)->lpVtbl->SetPixelShaderConstantI(p, a, b, c)
#define IDirect3DDevice9_GetPixelShaderConstantI(p, a, b, c) (p)->lpVtbl->GetPixelShaderConstantI(p, a, b, c)
#define IDirect3DDevice9_SetPixelShaderConstantB(p, a, b, c) (p)->lpVtbl->SetPixelShaderConstantB(p, a, b, c)
#define IDirect3DDevice9_GetPixelShaderConstantB(p, a, b, c) (p)->lpVtbl->GetPixelShaderConstantB(p, a, b, c)
#define IDirect3DDevice9_DrawRectPatch(p, a, b, c) (p)->lpVtbl->DrawRectPatch(p, a, b, c)
#define IDirect3DDevice9_DrawTriPatch(p, a, b, c) (p)->lpVtbl->DrawTriPatch(p, a, b, c)
#define IDirect3DDevice9_DeletePatch(p, a) (p)->lpVtbl->DeletePatch(p, a)
#define IDirect3DDevice9_CreateQuery(p, a, b) (p)->lpVtbl->CreateQuery(p, a, b)
type IDirect3DDevice9ExVtbl as IDirect3DDevice9ExVtbl_

type IDirect3DDevice9Ex_
	lpVtbl as IDirect3DDevice9ExVtbl ptr
end type

type IDirect3DDevice9ExVtbl_
	QueryInterface as function(byval This as IDirect3DDevice9Ex ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DDevice9Ex ptr) as ULONG
	Release as function(byval This as IDirect3DDevice9Ex ptr) as ULONG
	TestCooperativeLevel as function(byval This as IDirect3DDevice9Ex ptr) as HRESULT
	GetAvailableTextureMem as function(byval This as IDirect3DDevice9Ex ptr) as UINT
	EvictManagedResources as function(byval This as IDirect3DDevice9Ex ptr) as HRESULT
	GetDirect3D as function(byval This as IDirect3DDevice9Ex ptr, byval ppD3D9 as IDirect3D9 ptr ptr) as HRESULT
	GetDeviceCaps as function(byval This as IDirect3DDevice9Ex ptr, byval pCaps as D3DCAPS9 ptr) as HRESULT
	GetDisplayMode as function(byval This as IDirect3DDevice9Ex ptr, byval iSwapChain as UINT, byval pMode as D3DDISPLAYMODE ptr) as HRESULT
	GetCreationParameters as function(byval This as IDirect3DDevice9Ex ptr, byval pParameters as D3DDEVICE_CREATION_PARAMETERS ptr) as HRESULT
	SetCursorProperties as function(byval This as IDirect3DDevice9Ex ptr, byval XHotSpot as UINT, byval YHotSpot as UINT, byval pCursorBitmap as IDirect3DSurface9 ptr) as HRESULT
	SetCursorPosition as sub(byval This as IDirect3DDevice9Ex ptr, byval X as long, byval Y as long, byval Flags as DWORD)
	ShowCursor as function(byval This as IDirect3DDevice9Ex ptr, byval bShow as WINBOOL) as WINBOOL
	CreateAdditionalSwapChain as function(byval This as IDirect3DDevice9Ex ptr, byval pPresentationParameters as D3DPRESENT_PARAMETERS ptr, byval pSwapChain as IDirect3DSwapChain9 ptr ptr) as HRESULT
	GetSwapChain as function(byval This as IDirect3DDevice9Ex ptr, byval iSwapChain as UINT, byval pSwapChain as IDirect3DSwapChain9 ptr ptr) as HRESULT
	GetNumberOfSwapChains as function(byval This as IDirect3DDevice9Ex ptr) as UINT
	Reset as function(byval This as IDirect3DDevice9Ex ptr, byval pPresentationParameters as D3DPRESENT_PARAMETERS ptr) as HRESULT
	Present as function(byval This as IDirect3DDevice9Ex ptr, byval src_rect as const RECT ptr, byval dst_rect as const RECT ptr, byval dst_window_override as HWND, byval dirty_region as const RGNDATA ptr) as HRESULT
	GetBackBuffer as function(byval This as IDirect3DDevice9Ex ptr, byval iSwapChain as UINT, byval iBackBuffer as UINT, byval Type as D3DBACKBUFFER_TYPE, byval ppBackBuffer as IDirect3DSurface9 ptr ptr) as HRESULT
	GetRasterStatus as function(byval This as IDirect3DDevice9Ex ptr, byval iSwapChain as UINT, byval pRasterStatus as D3DRASTER_STATUS ptr) as HRESULT
	SetDialogBoxMode as function(byval This as IDirect3DDevice9Ex ptr, byval bEnableDialogs as WINBOOL) as HRESULT
	SetGammaRamp as sub(byval This as IDirect3DDevice9Ex ptr, byval swapchain_idx as UINT, byval flags as DWORD, byval ramp as const D3DGAMMARAMP ptr)
	GetGammaRamp as sub(byval This as IDirect3DDevice9Ex ptr, byval iSwapChain as UINT, byval pRamp as D3DGAMMARAMP ptr)
	CreateTexture as function(byval This as IDirect3DDevice9Ex ptr, byval Width as UINT, byval Height as UINT, byval Levels as UINT, byval Usage as DWORD, byval Format as D3DFORMAT, byval Pool as D3DPOOL, byval ppTexture as IDirect3DTexture9 ptr ptr, byval pSharedHandle as HANDLE ptr) as HRESULT
	CreateVolumeTexture as function(byval This as IDirect3DDevice9Ex ptr, byval Width as UINT, byval Height as UINT, byval Depth as UINT, byval Levels as UINT, byval Usage as DWORD, byval Format as D3DFORMAT, byval Pool as D3DPOOL, byval ppVolumeTexture as IDirect3DVolumeTexture9 ptr ptr, byval pSharedHandle as HANDLE ptr) as HRESULT
	CreateCubeTexture as function(byval This as IDirect3DDevice9Ex ptr, byval EdgeLength as UINT, byval Levels as UINT, byval Usage as DWORD, byval Format as D3DFORMAT, byval Pool as D3DPOOL, byval ppCubeTexture as IDirect3DCubeTexture9 ptr ptr, byval pSharedHandle as HANDLE ptr) as HRESULT
	CreateVertexBuffer as function(byval This as IDirect3DDevice9Ex ptr, byval Length as UINT, byval Usage as DWORD, byval FVF as DWORD, byval Pool as D3DPOOL, byval ppVertexBuffer as IDirect3DVertexBuffer9 ptr ptr, byval pSharedHandle as HANDLE ptr) as HRESULT
	CreateIndexBuffer as function(byval This as IDirect3DDevice9Ex ptr, byval Length as UINT, byval Usage as DWORD, byval Format as D3DFORMAT, byval Pool as D3DPOOL, byval ppIndexBuffer as IDirect3DIndexBuffer9 ptr ptr, byval pSharedHandle as HANDLE ptr) as HRESULT
	CreateRenderTarget as function(byval This as IDirect3DDevice9Ex ptr, byval Width as UINT, byval Height as UINT, byval Format as D3DFORMAT, byval MultiSample as D3DMULTISAMPLE_TYPE, byval MultisampleQuality as DWORD, byval Lockable as WINBOOL, byval ppSurface as IDirect3DSurface9 ptr ptr, byval pSharedHandle as HANDLE ptr) as HRESULT
	CreateDepthStencilSurface as function(byval This as IDirect3DDevice9Ex ptr, byval Width as UINT, byval Height as UINT, byval Format as D3DFORMAT, byval MultiSample as D3DMULTISAMPLE_TYPE, byval MultisampleQuality as DWORD, byval Discard as WINBOOL, byval ppSurface as IDirect3DSurface9 ptr ptr, byval pSharedHandle as HANDLE ptr) as HRESULT
	UpdateSurface as function(byval This as IDirect3DDevice9Ex ptr, byval src_surface as IDirect3DSurface9 ptr, byval src_rect as const RECT ptr, byval dst_surface as IDirect3DSurface9 ptr, byval dst_point as const POINT ptr) as HRESULT
	UpdateTexture as function(byval This as IDirect3DDevice9Ex ptr, byval pSourceTexture as IDirect3DBaseTexture9 ptr, byval pDestinationTexture as IDirect3DBaseTexture9 ptr) as HRESULT
	GetRenderTargetData as function(byval This as IDirect3DDevice9Ex ptr, byval pRenderTarget as IDirect3DSurface9 ptr, byval pDestSurface as IDirect3DSurface9 ptr) as HRESULT
	GetFrontBufferData as function(byval This as IDirect3DDevice9Ex ptr, byval iSwapChain as UINT, byval pDestSurface as IDirect3DSurface9 ptr) as HRESULT
	StretchRect as function(byval This as IDirect3DDevice9Ex ptr, byval src_surface as IDirect3DSurface9 ptr, byval src_rect as const RECT ptr, byval dst_surface as IDirect3DSurface9 ptr, byval dst_rect as const RECT ptr, byval filter as D3DTEXTUREFILTERTYPE) as HRESULT
	ColorFill as function(byval This as IDirect3DDevice9Ex ptr, byval surface as IDirect3DSurface9 ptr, byval rect as const RECT ptr, byval color as D3DCOLOR) as HRESULT
	CreateOffscreenPlainSurface as function(byval This as IDirect3DDevice9Ex ptr, byval Width as UINT, byval Height as UINT, byval Format as D3DFORMAT, byval Pool as D3DPOOL, byval ppSurface as IDirect3DSurface9 ptr ptr, byval pSharedHandle as HANDLE ptr) as HRESULT
	SetRenderTarget as function(byval This as IDirect3DDevice9Ex ptr, byval RenderTargetIndex as DWORD, byval pRenderTarget as IDirect3DSurface9 ptr) as HRESULT
	GetRenderTarget as function(byval This as IDirect3DDevice9Ex ptr, byval RenderTargetIndex as DWORD, byval ppRenderTarget as IDirect3DSurface9 ptr ptr) as HRESULT
	SetDepthStencilSurface as function(byval This as IDirect3DDevice9Ex ptr, byval pNewZStencil as IDirect3DSurface9 ptr) as HRESULT
	GetDepthStencilSurface as function(byval This as IDirect3DDevice9Ex ptr, byval ppZStencilSurface as IDirect3DSurface9 ptr ptr) as HRESULT
	BeginScene as function(byval This as IDirect3DDevice9Ex ptr) as HRESULT
	EndScene as function(byval This as IDirect3DDevice9Ex ptr) as HRESULT
	Clear as function(byval This as IDirect3DDevice9Ex ptr, byval rect_count as DWORD, byval rects as const D3DRECT ptr, byval flags as DWORD, byval color as D3DCOLOR, byval z as single, byval stencil as DWORD) as HRESULT
	SetTransform as function(byval This as IDirect3DDevice9Ex ptr, byval state as D3DTRANSFORMSTATETYPE, byval matrix as const D3DMATRIX ptr) as HRESULT
	GetTransform as function(byval This as IDirect3DDevice9Ex ptr, byval State as D3DTRANSFORMSTATETYPE, byval pMatrix as D3DMATRIX ptr) as HRESULT
	MultiplyTransform as function(byval This as IDirect3DDevice9Ex ptr, byval state as D3DTRANSFORMSTATETYPE, byval matrix as const D3DMATRIX ptr) as HRESULT
	SetViewport as function(byval This as IDirect3DDevice9Ex ptr, byval viewport as const D3DVIEWPORT9 ptr) as HRESULT
	GetViewport as function(byval This as IDirect3DDevice9Ex ptr, byval pViewport as D3DVIEWPORT9 ptr) as HRESULT
	SetMaterial as function(byval This as IDirect3DDevice9Ex ptr, byval material as const D3DMATERIAL9 ptr) as HRESULT
	GetMaterial as function(byval This as IDirect3DDevice9Ex ptr, byval pMaterial as D3DMATERIAL9 ptr) as HRESULT
	SetLight as function(byval This as IDirect3DDevice9Ex ptr, byval index as DWORD, byval light as const D3DLIGHT9 ptr) as HRESULT
	GetLight as function(byval This as IDirect3DDevice9Ex ptr, byval Index as DWORD, byval as D3DLIGHT9 ptr) as HRESULT
	LightEnable as function(byval This as IDirect3DDevice9Ex ptr, byval Index as DWORD, byval Enable as WINBOOL) as HRESULT
	GetLightEnable as function(byval This as IDirect3DDevice9Ex ptr, byval Index as DWORD, byval pEnable as WINBOOL ptr) as HRESULT
	SetClipPlane as function(byval This as IDirect3DDevice9Ex ptr, byval index as DWORD, byval plane as const single ptr) as HRESULT
	GetClipPlane as function(byval This as IDirect3DDevice9Ex ptr, byval Index as DWORD, byval pPlane as single ptr) as HRESULT
	SetRenderState as function(byval This as IDirect3DDevice9Ex ptr, byval State as D3DRENDERSTATETYPE, byval Value as DWORD) as HRESULT
	GetRenderState as function(byval This as IDirect3DDevice9Ex ptr, byval State as D3DRENDERSTATETYPE, byval pValue as DWORD ptr) as HRESULT
	CreateStateBlock as function(byval This as IDirect3DDevice9Ex ptr, byval Type as D3DSTATEBLOCKTYPE, byval ppSB as IDirect3DStateBlock9 ptr ptr) as HRESULT
	BeginStateBlock as function(byval This as IDirect3DDevice9Ex ptr) as HRESULT
	EndStateBlock as function(byval This as IDirect3DDevice9Ex ptr, byval ppSB as IDirect3DStateBlock9 ptr ptr) as HRESULT
	SetClipStatus as function(byval This as IDirect3DDevice9Ex ptr, byval clip_status as const D3DCLIPSTATUS9 ptr) as HRESULT
	GetClipStatus as function(byval This as IDirect3DDevice9Ex ptr, byval pClipStatus as D3DCLIPSTATUS9 ptr) as HRESULT
	GetTexture as function(byval This as IDirect3DDevice9Ex ptr, byval Stage as DWORD, byval ppTexture as IDirect3DBaseTexture9 ptr ptr) as HRESULT
	SetTexture as function(byval This as IDirect3DDevice9Ex ptr, byval Stage as DWORD, byval pTexture as IDirect3DBaseTexture9 ptr) as HRESULT
	GetTextureStageState as function(byval This as IDirect3DDevice9Ex ptr, byval Stage as DWORD, byval Type as D3DTEXTURESTAGESTATETYPE, byval pValue as DWORD ptr) as HRESULT
	SetTextureStageState as function(byval This as IDirect3DDevice9Ex ptr, byval Stage as DWORD, byval Type as D3DTEXTURESTAGESTATETYPE, byval Value as DWORD) as HRESULT
	GetSamplerState as function(byval This as IDirect3DDevice9Ex ptr, byval Sampler as DWORD, byval Type as D3DSAMPLERSTATETYPE, byval pValue as DWORD ptr) as HRESULT
	SetSamplerState as function(byval This as IDirect3DDevice9Ex ptr, byval Sampler as DWORD, byval Type as D3DSAMPLERSTATETYPE, byval Value as DWORD) as HRESULT
	ValidateDevice as function(byval This as IDirect3DDevice9Ex ptr, byval pNumPasses as DWORD ptr) as HRESULT
	SetPaletteEntries as function(byval This as IDirect3DDevice9Ex ptr, byval palette_idx as UINT, byval entries as const PALETTEENTRY ptr) as HRESULT
	GetPaletteEntries as function(byval This as IDirect3DDevice9Ex ptr, byval PaletteNumber as UINT, byval pEntries as PALETTEENTRY ptr) as HRESULT
	SetCurrentTexturePalette as function(byval This as IDirect3DDevice9Ex ptr, byval PaletteNumber as UINT) as HRESULT
	GetCurrentTexturePalette as function(byval This as IDirect3DDevice9Ex ptr, byval PaletteNumber as UINT ptr) as HRESULT
	SetScissorRect as function(byval This as IDirect3DDevice9Ex ptr, byval rect as const RECT ptr) as HRESULT
	GetScissorRect as function(byval This as IDirect3DDevice9Ex ptr, byval pRect as RECT ptr) as HRESULT
	SetSoftwareVertexProcessing as function(byval This as IDirect3DDevice9Ex ptr, byval bSoftware as WINBOOL) as HRESULT
	GetSoftwareVertexProcessing as function(byval This as IDirect3DDevice9Ex ptr) as WINBOOL
	SetNPatchMode as function(byval This as IDirect3DDevice9Ex ptr, byval nSegments as single) as HRESULT
	GetNPatchMode as function(byval This as IDirect3DDevice9Ex ptr) as single
	DrawPrimitive as function(byval This as IDirect3DDevice9Ex ptr, byval PrimitiveType as D3DPRIMITIVETYPE, byval StartVertex as UINT, byval PrimitiveCount as UINT) as HRESULT
	DrawIndexedPrimitive as function(byval This as IDirect3DDevice9Ex ptr, byval as D3DPRIMITIVETYPE, byval BaseVertexIndex as INT_, byval MinVertexIndex as UINT, byval NumVertices as UINT, byval startIndex as UINT, byval primCount as UINT) as HRESULT
	DrawPrimitiveUP as function(byval This as IDirect3DDevice9Ex ptr, byval primitive_type as D3DPRIMITIVETYPE, byval primitive_count as UINT, byval data as const any ptr, byval stride as UINT) as HRESULT
	DrawIndexedPrimitiveUP as function(byval This as IDirect3DDevice9Ex ptr, byval primitive_type as D3DPRIMITIVETYPE, byval min_vertex_idx as UINT, byval vertex_count as UINT, byval primitive_count as UINT, byval index_data as const any ptr, byval index_format as D3DFORMAT, byval data as const any ptr, byval stride as UINT) as HRESULT
	ProcessVertices as function(byval This as IDirect3DDevice9Ex ptr, byval SrcStartIndex as UINT, byval DestIndex as UINT, byval VertexCount as UINT, byval pDestBuffer as IDirect3DVertexBuffer9 ptr, byval pVertexDecl as IDirect3DVertexDeclaration9 ptr, byval Flags as DWORD) as HRESULT
	CreateVertexDeclaration as function(byval This as IDirect3DDevice9Ex ptr, byval elements as const D3DVERTEXELEMENT9 ptr, byval declaration as IDirect3DVertexDeclaration9 ptr ptr) as HRESULT
	SetVertexDeclaration as function(byval This as IDirect3DDevice9Ex ptr, byval pDecl as IDirect3DVertexDeclaration9 ptr) as HRESULT
	GetVertexDeclaration as function(byval This as IDirect3DDevice9Ex ptr, byval ppDecl as IDirect3DVertexDeclaration9 ptr ptr) as HRESULT
	SetFVF as function(byval This as IDirect3DDevice9Ex ptr, byval FVF as DWORD) as HRESULT
	GetFVF as function(byval This as IDirect3DDevice9Ex ptr, byval pFVF as DWORD ptr) as HRESULT
	CreateVertexShader as function(byval This as IDirect3DDevice9Ex ptr, byval byte_core as const DWORD ptr, byval shader as IDirect3DVertexShader9 ptr ptr) as HRESULT
	SetVertexShader as function(byval This as IDirect3DDevice9Ex ptr, byval pShader as IDirect3DVertexShader9 ptr) as HRESULT
	GetVertexShader as function(byval This as IDirect3DDevice9Ex ptr, byval ppShader as IDirect3DVertexShader9 ptr ptr) as HRESULT
	SetVertexShaderConstantF as function(byval This as IDirect3DDevice9Ex ptr, byval reg_idx as UINT, byval data as const single ptr, byval count as UINT) as HRESULT
	GetVertexShaderConstantF as function(byval This as IDirect3DDevice9Ex ptr, byval StartRegister as UINT, byval pConstantData as single ptr, byval Vector4fCount as UINT) as HRESULT
	SetVertexShaderConstantI as function(byval This as IDirect3DDevice9Ex ptr, byval reg_idx as UINT, byval data as const long ptr, byval count as UINT) as HRESULT
	GetVertexShaderConstantI as function(byval This as IDirect3DDevice9Ex ptr, byval StartRegister as UINT, byval pConstantData as long ptr, byval Vector4iCount as UINT) as HRESULT
	SetVertexShaderConstantB as function(byval This as IDirect3DDevice9Ex ptr, byval reg_idx as UINT, byval data as const WINBOOL ptr, byval count as UINT) as HRESULT
	GetVertexShaderConstantB as function(byval This as IDirect3DDevice9Ex ptr, byval StartRegister as UINT, byval pConstantData as WINBOOL ptr, byval BoolCount as UINT) as HRESULT
	SetStreamSource as function(byval This as IDirect3DDevice9Ex ptr, byval StreamNumber as UINT, byval pStreamData as IDirect3DVertexBuffer9 ptr, byval OffsetInBytes as UINT, byval Stride as UINT) as HRESULT
	GetStreamSource as function(byval This as IDirect3DDevice9Ex ptr, byval StreamNumber as UINT, byval ppStreamData as IDirect3DVertexBuffer9 ptr ptr, byval OffsetInBytes as UINT ptr, byval pStride as UINT ptr) as HRESULT
	SetStreamSourceFreq as function(byval This as IDirect3DDevice9Ex ptr, byval StreamNumber as UINT, byval Divider as UINT) as HRESULT
	GetStreamSourceFreq as function(byval This as IDirect3DDevice9Ex ptr, byval StreamNumber as UINT, byval Divider as UINT ptr) as HRESULT
	SetIndices as function(byval This as IDirect3DDevice9Ex ptr, byval pIndexData as IDirect3DIndexBuffer9 ptr) as HRESULT
	GetIndices as function(byval This as IDirect3DDevice9Ex ptr, byval ppIndexData as IDirect3DIndexBuffer9 ptr ptr) as HRESULT
	CreatePixelShader as function(byval This as IDirect3DDevice9Ex ptr, byval byte_code as const DWORD ptr, byval shader as IDirect3DPixelShader9 ptr ptr) as HRESULT
	SetPixelShader as function(byval This as IDirect3DDevice9Ex ptr, byval pShader as IDirect3DPixelShader9 ptr) as HRESULT
	GetPixelShader as function(byval This as IDirect3DDevice9Ex ptr, byval ppShader as IDirect3DPixelShader9 ptr ptr) as HRESULT
	SetPixelShaderConstantF as function(byval This as IDirect3DDevice9Ex ptr, byval reg_idx as UINT, byval data as const single ptr, byval count as UINT) as HRESULT
	GetPixelShaderConstantF as function(byval This as IDirect3DDevice9Ex ptr, byval StartRegister as UINT, byval pConstantData as single ptr, byval Vector4fCount as UINT) as HRESULT
	SetPixelShaderConstantI as function(byval This as IDirect3DDevice9Ex ptr, byval reg_idx as UINT, byval data as const long ptr, byval count as UINT) as HRESULT
	GetPixelShaderConstantI as function(byval This as IDirect3DDevice9Ex ptr, byval StartRegister as UINT, byval pConstantData as long ptr, byval Vector4iCount as UINT) as HRESULT
	SetPixelShaderConstantB as function(byval This as IDirect3DDevice9Ex ptr, byval reg_idx as UINT, byval data as const WINBOOL ptr, byval count as UINT) as HRESULT
	GetPixelShaderConstantB as function(byval This as IDirect3DDevice9Ex ptr, byval StartRegister as UINT, byval pConstantData as WINBOOL ptr, byval BoolCount as UINT) as HRESULT
	DrawRectPatch as function(byval This as IDirect3DDevice9Ex ptr, byval handle as UINT, byval segment_count as const single ptr, byval patch_info as const D3DRECTPATCH_INFO ptr) as HRESULT
	DrawTriPatch as function(byval This as IDirect3DDevice9Ex ptr, byval handle as UINT, byval segment_count as const single ptr, byval patch_info as const D3DTRIPATCH_INFO ptr) as HRESULT
	DeletePatch as function(byval This as IDirect3DDevice9Ex ptr, byval Handle as UINT) as HRESULT
	CreateQuery as function(byval This as IDirect3DDevice9Ex ptr, byval Type as D3DQUERYTYPE, byval ppQuery as IDirect3DQuery9 ptr ptr) as HRESULT
	SetConvolutionMonoKernel as function(byval This as IDirect3DDevice9Ex ptr, byval width as UINT, byval height as UINT, byval rows as single ptr, byval columns as single ptr) as HRESULT
	ComposeRects as function(byval This as IDirect3DDevice9Ex ptr, byval src_surface as IDirect3DSurface9 ptr, byval dst_surface as IDirect3DSurface9 ptr, byval src_descs as IDirect3DVertexBuffer9 ptr, byval rect_count as UINT, byval dst_descs as IDirect3DVertexBuffer9 ptr, byval operation as D3DCOMPOSERECTSOP, byval offset_x as INT_, byval offset_y as INT_) as HRESULT
	PresentEx as function(byval This as IDirect3DDevice9Ex ptr, byval src_rect as const RECT ptr, byval dst_rect as const RECT ptr, byval dst_window_override as HWND, byval dirty_region as const RGNDATA ptr, byval flags as DWORD) as HRESULT
	GetGPUThreadPriority as function(byval This as IDirect3DDevice9Ex ptr, byval pPriority as INT_ ptr) as HRESULT
	SetGPUThreadPriority as function(byval This as IDirect3DDevice9Ex ptr, byval Priority as INT_) as HRESULT
	WaitForVBlank as function(byval This as IDirect3DDevice9Ex ptr, byval iSwapChain as UINT) as HRESULT
	CheckResourceResidency as function(byval This as IDirect3DDevice9Ex ptr, byval resources as IDirect3DResource9 ptr ptr, byval resource_count as UINT32) as HRESULT
	SetMaximumFrameLatency as function(byval This as IDirect3DDevice9Ex ptr, byval MaxLatency as UINT) as HRESULT
	GetMaximumFrameLatency as function(byval This as IDirect3DDevice9Ex ptr, byval pMaxLatenxy as UINT ptr) as HRESULT
	CheckDeviceState as function(byval This as IDirect3DDevice9Ex ptr, byval dst_window as HWND) as HRESULT
	CreateRenderTargetEx as function(byval This as IDirect3DDevice9Ex ptr, byval Width as UINT, byval Height as UINT, byval Format as D3DFORMAT, byval MultiSample as D3DMULTISAMPLE_TYPE, byval MultiSampleQuality as DWORD, byval Lockable as WINBOOL, byval ppSurface as IDirect3DSurface9 ptr ptr, byval pSharedHandle as HANDLE ptr, byval Usage as DWORD) as HRESULT
	CreateOffscreenPlainSurfaceEx as function(byval This as IDirect3DDevice9Ex ptr, byval Width as UINT, byval Height as UINT, byval Format as D3DFORMAT, byval Pool as D3DPOOL, byval ppSurface as IDirect3DSurface9 ptr ptr, byval pSharedHandle as HANDLE ptr, byval Usage as DWORD) as HRESULT
	CreateDepthStencilSurfaceEx as function(byval This as IDirect3DDevice9Ex ptr, byval width as UINT, byval height as UINT, byval format as D3DFORMAT, byval multisample_type as D3DMULTISAMPLE_TYPE, byval multisample_quality as DWORD, byval discard as WINBOOL, byval surface as IDirect3DSurface9 ptr ptr, byval shared_handle as HANDLE ptr, byval usage as DWORD) as HRESULT
	ResetEx as function(byval This as IDirect3DDevice9Ex ptr, byval pPresentationParameters as D3DPRESENT_PARAMETERS ptr, byval pFullscreenDisplayMode as D3DDISPLAYMODEEX ptr) as HRESULT
	GetDisplayModeEx as function(byval This as IDirect3DDevice9Ex ptr, byval iSwapChain as UINT, byval pMode as D3DDISPLAYMODEEX ptr, byval pRotation as D3DDISPLAYROTATION ptr) as HRESULT
end type

#define IDirect3DDevice9Ex_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DDevice9Ex_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DDevice9Ex_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DDevice9Ex_TestCooperativeLevel(p) (p)->lpVtbl->TestCooperativeLevel(p)
#define IDirect3DDevice9Ex_GetAvailableTextureMem(p) (p)->lpVtbl->GetAvailableTextureMem(p)
#define IDirect3DDevice9Ex_EvictManagedResources(p) (p)->lpVtbl->EvictManagedResources(p)
#define IDirect3DDevice9Ex_GetDirect3D(p, a) (p)->lpVtbl->GetDirect3D(p, a)
#define IDirect3DDevice9Ex_GetDeviceCaps(p, a) (p)->lpVtbl->GetDeviceCaps(p, a)
#define IDirect3DDevice9Ex_GetDisplayMode(p, a, b) (p)->lpVtbl->GetDisplayMode(p, a, b)
#define IDirect3DDevice9Ex_GetCreationParameters(p, a) (p)->lpVtbl->GetCreationParameters(p, a)
#define IDirect3DDevice9Ex_SetCursorProperties(p, a, b, c) (p)->lpVtbl->SetCursorProperties(p, a, b, c)
#define IDirect3DDevice9Ex_SetCursorPosition(p, a, b, c) (p)->lpVtbl->SetCursorPosition(p, a, b, c)
#define IDirect3DDevice9Ex_ShowCursor(p, a) (p)->lpVtbl->ShowCursor(p, a)
#define IDirect3DDevice9Ex_CreateAdditionalSwapChain(p, a, b) (p)->lpVtbl->CreateAdditionalSwapChain(p, a, b)
#define IDirect3DDevice9Ex_GetSwapChain(p, a, b) (p)->lpVtbl->GetSwapChain(p, a, b)
#define IDirect3DDevice9Ex_GetNumberOfSwapChains(p) (p)->lpVtbl->GetNumberOfSwapChains(p)
#define IDirect3DDevice9Ex_Reset(p, a) (p)->lpVtbl->Reset(p, a)
#define IDirect3DDevice9Ex_Present(p, a, b, c, d) (p)->lpVtbl->Present(p, a, b, c, d)
#define IDirect3DDevice9Ex_GetBackBuffer(p, a, b, c, d) (p)->lpVtbl->GetBackBuffer(p, a, b, c, d)
#define IDirect3DDevice9Ex_GetRasterStatus(p, a, b) (p)->lpVtbl->GetRasterStatus(p, a, b)
#define IDirect3DDevice9Ex_SetDialogBoxMode(p, a) (p)->lpVtbl->SetDialogBoxMode(p, a)
#define IDirect3DDevice9Ex_SetGammaRamp(p, a, b, c) (p)->lpVtbl->SetGammaRamp(p, a, b, c)
#define IDirect3DDevice9Ex_GetGammaRamp(p, a, b) (p)->lpVtbl->GetGammaRamp(p, a, b)
#define IDirect3DDevice9Ex_CreateTexture(p, a, b, c, d, e, f, g, h) (p)->lpVtbl->CreateTexture(p, a, b, c, d, e, f, g, h)
#define IDirect3DDevice9Ex_CreateVolumeTexture(p, a, b, c, d, e, f, g, h, i) (p)->lpVtbl->CreateVolumeTexture(p, a, b, c, d, e, f, g, h, i)
#define IDirect3DDevice9Ex_CreateCubeTexture(p, a, b, c, d, e, f, g) (p)->lpVtbl->CreateCubeTexture(p, a, b, c, d, e, f, g)
#define IDirect3DDevice9Ex_CreateVertexBuffer(p, a, b, c, d, e, f) (p)->lpVtbl->CreateVertexBuffer(p, a, b, c, d, e, f)
#define IDirect3DDevice9Ex_CreateIndexBuffer(p, a, b, c, d, e, f) (p)->lpVtbl->CreateIndexBuffer(p, a, b, c, d, e, f)
#define IDirect3DDevice9Ex_CreateRenderTarget(p, a, b, c, d, e, f, g, h) (p)->lpVtbl->CreateRenderTarget(p, a, b, c, d, e, f, g, h)
#define IDirect3DDevice9Ex_CreateDepthStencilSurface(p, a, b, c, d, e, f, g, h) (p)->lpVtbl->CreateDepthStencilSurface(p, a, b, c, d, e, f, g, h)
#define IDirect3DDevice9Ex_UpdateSurface(p, a, b, c, d) (p)->lpVtbl->UpdateSurface(p, a, b, c, d)
#define IDirect3DDevice9Ex_UpdateTexture(p, a, b) (p)->lpVtbl->UpdateTexture(p, a, b)
#define IDirect3DDevice9Ex_GetRenderTargetData(p, a, b) (p)->lpVtbl->GetRenderTargetData(p, a, b)
#define IDirect3DDevice9Ex_GetFrontBufferData(p, a, b) (p)->lpVtbl->GetFrontBufferData(p, a, b)
#define IDirect3DDevice9Ex_StretchRect(p, a, b, c, d, e) (p)->lpVtbl->StretchRect(p, a, b, c, d, e)
#define IDirect3DDevice9Ex_ColorFill(p, a, b, c) (p)->lpVtbl->ColorFill(p, a, b, c)
#define IDirect3DDevice9Ex_CreateOffscreenPlainSurface(p, a, b, c, d, e, f) (p)->lpVtbl->CreateOffscreenPlainSurface(p, a, b, c, d, e, f)
#define IDirect3DDevice9Ex_SetRenderTarget(p, a, b) (p)->lpVtbl->SetRenderTarget(p, a, b)
#define IDirect3DDevice9Ex_GetRenderTarget(p, a, b) (p)->lpVtbl->GetRenderTarget(p, a, b)
#define IDirect3DDevice9Ex_SetDepthStencilSurface(p, a) (p)->lpVtbl->SetDepthStencilSurface(p, a)
#define IDirect3DDevice9Ex_GetDepthStencilSurface(p, a) (p)->lpVtbl->GetDepthStencilSurface(p, a)
#define IDirect3DDevice9Ex_BeginScene(p) (p)->lpVtbl->BeginScene(p)
#define IDirect3DDevice9Ex_EndScene(p) (p)->lpVtbl->EndScene(p)
#define IDirect3DDevice9Ex_Clear(p, a, b, c, d, e, f) (p)->lpVtbl->Clear(p, a, b, c, d, e, f)
#define IDirect3DDevice9Ex_SetTransform(p, a, b) (p)->lpVtbl->SetTransform(p, a, b)
#define IDirect3DDevice9Ex_GetTransform(p, a, b) (p)->lpVtbl->GetTransform(p, a, b)
#define IDirect3DDevice9Ex_MultiplyTransform(p, a, b) (p)->lpVtbl->MultiplyTransform(p, a, b)
#define IDirect3DDevice9Ex_SetViewport(p, a) (p)->lpVtbl->SetViewport(p, a)
#define IDirect3DDevice9Ex_GetViewport(p, a) (p)->lpVtbl->GetViewport(p, a)
#define IDirect3DDevice9Ex_SetMaterial(p, a) (p)->lpVtbl->SetMaterial(p, a)
#define IDirect3DDevice9Ex_GetMaterial(p, a) (p)->lpVtbl->GetMaterial(p, a)
#define IDirect3DDevice9Ex_SetLight(p, a, b) (p)->lpVtbl->SetLight(p, a, b)
#define IDirect3DDevice9Ex_GetLight(p, a, b) (p)->lpVtbl->GetLight(p, a, b)
#define IDirect3DDevice9Ex_LightEnable(p, a, b) (p)->lpVtbl->LightEnable(p, a, b)
#define IDirect3DDevice9Ex_GetLightEnable(p, a, b) (p)->lpVtbl->GetLightEnable(p, a, b)
#define IDirect3DDevice9Ex_SetClipPlane(p, a, b) (p)->lpVtbl->SetClipPlane(p, a, b)
#define IDirect3DDevice9Ex_GetClipPlane(p, a, b) (p)->lpVtbl->GetClipPlane(p, a, b)
#define IDirect3DDevice9Ex_SetRenderState(p, a, b) (p)->lpVtbl->SetRenderState(p, a, b)
#define IDirect3DDevice9Ex_GetRenderState(p, a, b) (p)->lpVtbl->GetRenderState(p, a, b)
#define IDirect3DDevice9Ex_CreateStateBlock(p, a, b) (p)->lpVtbl->CreateStateBlock(p, a, b)
#define IDirect3DDevice9Ex_BeginStateBlock(p) (p)->lpVtbl->BeginStateBlock(p)
#define IDirect3DDevice9Ex_EndStateBlock(p, a) (p)->lpVtbl->EndStateBlock(p, a)
#define IDirect3DDevice9Ex_SetClipStatus(p, a) (p)->lpVtbl->SetClipStatus(p, a)
#define IDirect3DDevice9Ex_GetClipStatus(p, a) (p)->lpVtbl->GetClipStatus(p, a)
#define IDirect3DDevice9Ex_GetTexture(p, a, b) (p)->lpVtbl->GetTexture(p, a, b)
#define IDirect3DDevice9Ex_SetTexture(p, a, b) (p)->lpVtbl->SetTexture(p, a, b)
#define IDirect3DDevice9Ex_GetTextureStageState(p, a, b, c) (p)->lpVtbl->GetTextureStageState(p, a, b, c)
#define IDirect3DDevice9Ex_SetTextureStageState(p, a, b, c) (p)->lpVtbl->SetTextureStageState(p, a, b, c)
#define IDirect3DDevice9Ex_GetSamplerState(p, a, b, c) (p)->lpVtbl->GetSamplerState(p, a, b, c)
#define IDirect3DDevice9Ex_SetSamplerState(p, a, b, c) (p)->lpVtbl->SetSamplerState(p, a, b, c)
#define IDirect3DDevice9Ex_ValidateDevice(p, a) (p)->lpVtbl->ValidateDevice(p, a)
#define IDirect3DDevice9Ex_SetPaletteEntries(p, a, b) (p)->lpVtbl->SetPaletteEntries(p, a, b)
#define IDirect3DDevice9Ex_GetPaletteEntries(p, a, b) (p)->lpVtbl->GetPaletteEntries(p, a, b)
#define IDirect3DDevice9Ex_SetCurrentTexturePalette(p, a) (p)->lpVtbl->SetCurrentTexturePalette(p, a)
#define IDirect3DDevice9Ex_GetCurrentTexturePalette(p, a) (p)->lpVtbl->GetCurrentTexturePalette(p, a)
#define IDirect3DDevice9Ex_SetScissorRect(p, a) (p)->lpVtbl->SetScissorRect(p, a)
#define IDirect3DDevice9Ex_GetScissorRect(p, a) (p)->lpVtbl->GetScissorRect(p, a)
#define IDirect3DDevice9Ex_SetSoftwareVertexProcessing(p, a) (p)->lpVtbl->SetSoftwareVertexProcessing(p, a)
#define IDirect3DDevice9Ex_GetSoftwareVertexProcessing(p) (p)->lpVtbl->GetSoftwareVertexProcessing(p)
#define IDirect3DDevice9Ex_SetNPatchMode(p, a) (p)->lpVtbl->SetNPatchMode(p, a)
#define IDirect3DDevice9Ex_GetNPatchMode(p) (p)->lpVtbl->GetNPatchMode(p)
#define IDirect3DDevice9Ex_DrawPrimitive(p, a, b, c) (p)->lpVtbl->DrawPrimitive(p, a, b, c)
#define IDirect3DDevice9Ex_DrawIndexedPrimitive(p, a, b, c, d, e, f) (p)->lpVtbl->DrawIndexedPrimitive(p, a, b, c, d, e, f)
#define IDirect3DDevice9Ex_DrawPrimitiveUP(p, a, b, c, d) (p)->lpVtbl->DrawPrimitiveUP(p, a, b, c, d)
#define IDirect3DDevice9Ex_DrawIndexedPrimitiveUP(p, a, b, c, d, e, f, g, h) (p)->lpVtbl->DrawIndexedPrimitiveUP(p, a, b, c, d, e, f, g, h)
#define IDirect3DDevice9Ex_ProcessVertices(p, a, b, c, d, e, f) (p)->lpVtbl->ProcessVertices(p, a, b, c, d, e, f)
#define IDirect3DDevice9Ex_CreateVertexDeclaration(p, a, b) (p)->lpVtbl->CreateVertexDeclaration(p, a, b)
#define IDirect3DDevice9Ex_SetVertexDeclaration(p, a) (p)->lpVtbl->SetVertexDeclaration(p, a)
#define IDirect3DDevice9Ex_GetVertexDeclaration(p, a) (p)->lpVtbl->GetVertexDeclaration(p, a)
#define IDirect3DDevice9Ex_SetFVF(p, a) (p)->lpVtbl->SetFVF(p, a)
#define IDirect3DDevice9Ex_GetFVF(p, a) (p)->lpVtbl->GetFVF(p, a)
#define IDirect3DDevice9Ex_CreateVertexShader(p, a, b) (p)->lpVtbl->CreateVertexShader(p, a, b)
#define IDirect3DDevice9Ex_SetVertexShader(p, a) (p)->lpVtbl->SetVertexShader(p, a)
#define IDirect3DDevice9Ex_GetVertexShader(p, a) (p)->lpVtbl->GetVertexShader(p, a)
#define IDirect3DDevice9Ex_SetVertexShaderConstantF(p, a, b, c) (p)->lpVtbl->SetVertexShaderConstantF(p, a, b, c)
#define IDirect3DDevice9Ex_GetVertexShaderConstantF(p, a, b, c) (p)->lpVtbl->GetVertexShaderConstantF(p, a, b, c)
#define IDirect3DDevice9Ex_SetVertexShaderConstantI(p, a, b, c) (p)->lpVtbl->SetVertexShaderConstantI(p, a, b, c)
#define IDirect3DDevice9Ex_GetVertexShaderConstantI(p, a, b, c) (p)->lpVtbl->GetVertexShaderConstantI(p, a, b, c)
#define IDirect3DDevice9Ex_SetVertexShaderConstantB(p, a, b, c) (p)->lpVtbl->SetVertexShaderConstantB(p, a, b, c)
#define IDirect3DDevice9Ex_GetVertexShaderConstantB(p, a, b, c) (p)->lpVtbl->GetVertexShaderConstantB(p, a, b, c)
#define IDirect3DDevice9Ex_SetStreamSource(p, a, b, c, d) (p)->lpVtbl->SetStreamSource(p, a, b, c, d)
#define IDirect3DDevice9Ex_GetStreamSource(p, a, b, c, d) (p)->lpVtbl->GetStreamSource(p, a, b, c, d)
#define IDirect3DDevice9Ex_SetStreamSourceFreq(p, a, b) (p)->lpVtbl->SetStreamSourceFreq(p, a, b)
#define IDirect3DDevice9Ex_GetStreamSourceFreq(p, a, b) (p)->lpVtbl->GetStreamSourceFreq(p, a, b)
#define IDirect3DDevice9Ex_SetIndices(p, a) (p)->lpVtbl->SetIndices(p, a)
#define IDirect3DDevice9Ex_GetIndices(p, a) (p)->lpVtbl->GetIndices(p, a)
#define IDirect3DDevice9Ex_CreatePixelShader(p, a, b) (p)->lpVtbl->CreatePixelShader(p, a, b)
#define IDirect3DDevice9Ex_SetPixelShader(p, a) (p)->lpVtbl->SetPixelShader(p, a)
#define IDirect3DDevice9Ex_GetPixelShader(p, a) (p)->lpVtbl->GetPixelShader(p, a)
#define IDirect3DDevice9Ex_SetPixelShaderConstantF(p, a, b, c) (p)->lpVtbl->SetPixelShaderConstantF(p, a, b, c)
#define IDirect3DDevice9Ex_GetPixelShaderConstantF(p, a, b, c) (p)->lpVtbl->GetPixelShaderConstantF(p, a, b, c)
#define IDirect3DDevice9Ex_SetPixelShaderConstantI(p, a, b, c) (p)->lpVtbl->SetPixelShaderConstantI(p, a, b, c)
#define IDirect3DDevice9Ex_GetPixelShaderConstantI(p, a, b, c) (p)->lpVtbl->GetPixelShaderConstantI(p, a, b, c)
#define IDirect3DDevice9Ex_SetPixelShaderConstantB(p, a, b, c) (p)->lpVtbl->SetPixelShaderConstantB(p, a, b, c)
#define IDirect3DDevice9Ex_GetPixelShaderConstantB(p, a, b, c) (p)->lpVtbl->GetPixelShaderConstantB(p, a, b, c)
#define IDirect3DDevice9Ex_DrawRectPatch(p, a, b, c) (p)->lpVtbl->DrawRectPatch(p, a, b, c)
#define IDirect3DDevice9Ex_DrawTriPatch(p, a, b, c) (p)->lpVtbl->DrawTriPatch(p, a, b, c)
#define IDirect3DDevice9Ex_DeletePatch(p, a) (p)->lpVtbl->DeletePatch(p, a)
#define IDirect3DDevice9Ex_CreateQuery(p, a, b) (p)->lpVtbl->CreateQuery(p, a, b)
#define IDirect3DDevice9Ex_SetConvolutionMonoKernel(p, a, b, c, d) (p)->lpVtbl->SetConvolutionMonoKernel(p, a, b, c, d)
#define IDirect3DDevice9Ex_ComposeRects(p, a, b, c, d, e, f, g, h) (p)->lpVtbl->ComposeRects(p, a, b, c, d, e, f, g, h)
#define IDirect3DDevice9Ex_PresentEx(p, a, b, c, d, e) (p)->lpVtbl->PresentEx(p, a, b, c, d, e)
#define IDirect3DDevice9Ex_GetGPUThreadPriority(p, a) (p)->lpVtbl->GetGPUThreadPriority(p, a)
#define IDirect3DDevice9Ex_SetGPUThreadPriority(p, a) (p)->lpVtbl->SetGPUThreadPriority(p, a)
#define IDirect3DDevice9Ex_WaitForVBlank(p, a) (p)->lpVtbl->WaitForVBlank(p, a)
#define IDirect3DDevice9Ex_CheckResourceResidency(p, a, b) (p)->lpVtbl->CheckResourceResidency(p, a, b)
#define IDirect3DDevice9Ex_SetMaximumFrameLatency(p, a) (p)->lpVtbl->SetMaximumFrameLatency(p, a)
#define IDirect3DDevice9Ex_GetMaximumFrameLatency(p, a) (p)->lpVtbl->GetMaximumFrameLatency(p, a)
#define IDirect3DDevice9Ex_CheckDeviceState(p, a) (p)->lpVtbl->CheckDeviceState(p, a)
#define IDirect3DDevice9Ex_CreateRenderTargetEx(p, a, b, c, d, e, f, g, h, i) (p)->lpVtbl->CreateRenderTargetEx(p, a, b, c, d, e, f, g, h, i)
#define IDirect3DDevice9Ex_CreateOffscreenPlainSurfaceEx(p, a, b, c, d, e, f, g) (p)->lpVtbl->CreateOffscreenPlainSurfaceEx(p, a, b, c, d, e, f, g)
#define IDirect3DDevice9Ex_CreateDepthStencilSurfaceEx(p, a, b, c, d, e, f, g, h, i) (p)->lpVtbl->CreateDepthStencilSurfaceEx(p, a, b, c, d, e, f, g, h, i)
#define IDirect3DDevice9Ex_ResetEx(p, a, b) (p)->lpVtbl->ResetEx(p, a, b)
#define IDirect3DDevice9Ex_GetDisplayModeEx(p, a, b, c) (p)->lpVtbl->GetDisplayModeEx(p, a, b, c)

declare function D3DPERF_BeginEvent(byval color as D3DCOLOR, byval name as const wstring ptr) as long
declare function D3DPERF_EndEvent() as long
declare function D3DPERF_GetStatus() as DWORD
declare function D3DPERF_QueryRepeatFrame() as WINBOOL
declare sub D3DPERF_SetMarker(byval color as D3DCOLOR, byval name as const wstring ptr)
declare sub D3DPERF_SetOptions(byval options as DWORD)
declare sub D3DPERF_SetRegion(byval color as D3DCOLOR, byval name as const wstring ptr)
declare function Direct3DCreate9(byval SDKVersion as UINT) as IDirect3D9 ptr
declare function Direct3DCreate9Ex(byval SDKVersion as UINT, byval as IDirect3D9Ex ptr ptr) as HRESULT

end extern
