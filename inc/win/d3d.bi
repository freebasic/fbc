'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   Copyright (C) the Wine project
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

#include once "crt/stdlib.bi"
#include once "objbase.bi"
#include once "d3dtypes.bi"
#include once "d3dcaps.bi"

extern "Windows"

#define __WINE_D3D_H
extern IID_IDirect3D as const GUID
extern IID_IDirect3D2 as const GUID
extern IID_IDirect3D3 as const GUID
extern IID_IDirect3D7 as const GUID
extern IID_IDirect3DRampDevice as const GUID
extern IID_IDirect3DRGBDevice as const GUID
extern IID_IDirect3DHALDevice as const GUID
extern IID_IDirect3DMMXDevice as const GUID
extern IID_IDirect3DRefDevice as const GUID
extern IID_IDirect3DTnLHalDevice as const GUID
extern IID_IDirect3DNullDevice as const GUID
extern IID_IDirect3DDevice as const GUID
extern IID_IDirect3DDevice2 as const GUID
extern IID_IDirect3DDevice3 as const GUID
extern IID_IDirect3DDevice7 as const GUID
extern IID_IDirect3DTexture as const GUID
extern IID_IDirect3DTexture2 as const GUID
extern IID_IDirect3DLight as const GUID
extern IID_IDirect3DMaterial as const GUID
extern IID_IDirect3DMaterial2 as const GUID
extern IID_IDirect3DMaterial3 as const GUID
extern IID_IDirect3DExecuteBuffer as const GUID
extern IID_IDirect3DViewport as const GUID
extern IID_IDirect3DViewport2 as const GUID
extern IID_IDirect3DViewport3 as const GUID
extern IID_IDirect3DVertexBuffer as const GUID
extern IID_IDirect3DVertexBuffer7 as const GUID

type LPDIRECT3D as IDirect3D ptr
type LPDIRECT3D2 as IDirect3D2 ptr
type LPDIRECT3D3 as IDirect3D3 ptr
type LPDIRECT3D7 as IDirect3D7 ptr
type IDirect3DLight as IDirect3DLight_
type LPDIRECT3DLIGHT as IDirect3DLight ptr
type IDirect3DDevice as IDirect3DDevice_
type LPDIRECT3DDEVICE as IDirect3DDevice ptr
type IDirect3DDevice2 as IDirect3DDevice2_
type LPDIRECT3DDEVICE2 as IDirect3DDevice2 ptr
type IDirect3DDevice3 as IDirect3DDevice3_
type LPDIRECT3DDEVICE3 as IDirect3DDevice3 ptr
type IDirect3DDevice7 as IDirect3DDevice7_
type LPDIRECT3DDEVICE7 as IDirect3DDevice7 ptr
type IDirect3DViewport as IDirect3DViewport_
type LPDIRECT3DVIEWPORT as IDirect3DViewport ptr
type IDirect3DViewport2 as IDirect3DViewport2_
type LPDIRECT3DVIEWPORT2 as IDirect3DViewport2 ptr
type IDirect3DViewport3 as IDirect3DViewport3_
type LPDIRECT3DVIEWPORT3 as IDirect3DViewport3 ptr
type IDirect3DMaterial as IDirect3DMaterial_
type LPDIRECT3DMATERIAL as IDirect3DMaterial ptr
type IDirect3DMaterial2 as IDirect3DMaterial2_
type LPDIRECT3DMATERIAL2 as IDirect3DMaterial2 ptr
type IDirect3DMaterial3 as IDirect3DMaterial3_
type LPDIRECT3DMATERIAL3 as IDirect3DMaterial3 ptr
type LPDIRECT3DTEXTURE as IDirect3DTexture ptr
type LPDIRECT3DTEXTURE2 as IDirect3DTexture2 ptr
type LPDIRECT3DEXECUTEBUFFER as IDirect3DExecuteBuffer ptr
type IDirect3DVertexBuffer as IDirect3DVertexBuffer_
type LPDIRECT3DVERTEXBUFFER as IDirect3DVertexBuffer ptr
type IDirect3DVertexBuffer7 as IDirect3DVertexBuffer7_
type LPDIRECT3DVERTEXBUFFER7 as IDirect3DVertexBuffer7 ptr

const D3D_OK = DD_OK
#define D3DERR_BADMAJORVERSION MAKE_DDHRESULT(700)
#define D3DERR_BADMINORVERSION MAKE_DDHRESULT(701)
#define D3DERR_INVALID_DEVICE MAKE_DDHRESULT(705)
#define D3DERR_INITFAILED MAKE_DDHRESULT(706)
#define D3DERR_DEVICEAGGREGATED MAKE_DDHRESULT(707)
#define D3DERR_EXECUTE_CREATE_FAILED MAKE_DDHRESULT(710)
#define D3DERR_EXECUTE_DESTROY_FAILED MAKE_DDHRESULT(711)
#define D3DERR_EXECUTE_LOCK_FAILED MAKE_DDHRESULT(712)
#define D3DERR_EXECUTE_UNLOCK_FAILED MAKE_DDHRESULT(713)
#define D3DERR_EXECUTE_LOCKED MAKE_DDHRESULT(714)
#define D3DERR_EXECUTE_NOT_LOCKED MAKE_DDHRESULT(715)
#define D3DERR_EXECUTE_FAILED MAKE_DDHRESULT(716)
#define D3DERR_EXECUTE_CLIPPED_FAILED MAKE_DDHRESULT(717)
#define D3DERR_TEXTURE_NO_SUPPORT MAKE_DDHRESULT(720)
#define D3DERR_TEXTURE_CREATE_FAILED MAKE_DDHRESULT(721)
#define D3DERR_TEXTURE_DESTROY_FAILED MAKE_DDHRESULT(722)
#define D3DERR_TEXTURE_LOCK_FAILED MAKE_DDHRESULT(723)
#define D3DERR_TEXTURE_UNLOCK_FAILED MAKE_DDHRESULT(724)
#define D3DERR_TEXTURE_LOAD_FAILED MAKE_DDHRESULT(725)
#define D3DERR_TEXTURE_SWAP_FAILED MAKE_DDHRESULT(726)
#define D3DERR_TEXTURE_LOCKED MAKE_DDHRESULT(727)
#define D3DERR_TEXTURE_NOT_LOCKED MAKE_DDHRESULT(728)
#define D3DERR_TEXTURE_GETSURF_FAILED MAKE_DDHRESULT(729)
#define D3DERR_MATRIX_CREATE_FAILED MAKE_DDHRESULT(730)
#define D3DERR_MATRIX_DESTROY_FAILED MAKE_DDHRESULT(731)
#define D3DERR_MATRIX_SETDATA_FAILED MAKE_DDHRESULT(732)
#define D3DERR_MATRIX_GETDATA_FAILED MAKE_DDHRESULT(733)
#define D3DERR_SETVIEWPORTDATA_FAILED MAKE_DDHRESULT(734)
#define D3DERR_INVALIDCURRENTVIEWPORT MAKE_DDHRESULT(735)
#define D3DERR_INVALIDPRIMITIVETYPE MAKE_DDHRESULT(736)
#define D3DERR_INVALIDVERTEXTYPE MAKE_DDHRESULT(737)
#define D3DERR_TEXTURE_BADSIZE MAKE_DDHRESULT(738)
#define D3DERR_INVALIDRAMPTEXTURE MAKE_DDHRESULT(739)
#define D3DERR_MATERIAL_CREATE_FAILED MAKE_DDHRESULT(740)
#define D3DERR_MATERIAL_DESTROY_FAILED MAKE_DDHRESULT(741)
#define D3DERR_MATERIAL_SETDATA_FAILED MAKE_DDHRESULT(742)
#define D3DERR_MATERIAL_GETDATA_FAILED MAKE_DDHRESULT(743)
#define D3DERR_INVALIDPALETTE MAKE_DDHRESULT(744)
#define D3DERR_ZBUFF_NEEDS_SYSTEMMEMORY MAKE_DDHRESULT(745)
#define D3DERR_ZBUFF_NEEDS_VIDEOMEMORY MAKE_DDHRESULT(746)
#define D3DERR_SURFACENOTINVIDMEM MAKE_DDHRESULT(747)
#define D3DERR_LIGHT_SET_FAILED MAKE_DDHRESULT(750)
#define D3DERR_LIGHTHASVIEWPORT MAKE_DDHRESULT(751)
#define D3DERR_LIGHTNOTINTHISVIEWPORT MAKE_DDHRESULT(752)
#define D3DERR_SCENE_IN_SCENE MAKE_DDHRESULT(760)
#define D3DERR_SCENE_NOT_IN_SCENE MAKE_DDHRESULT(761)
#define D3DERR_SCENE_BEGIN_FAILED MAKE_DDHRESULT(762)
#define D3DERR_SCENE_END_FAILED MAKE_DDHRESULT(763)
#define D3DERR_INBEGIN MAKE_DDHRESULT(770)
#define D3DERR_NOTINBEGIN MAKE_DDHRESULT(771)
#define D3DERR_NOVIEWPORTS MAKE_DDHRESULT(772)
#define D3DERR_VIEWPORTDATANOTSET MAKE_DDHRESULT(773)
#define D3DERR_VIEWPORTHASNODEVICE MAKE_DDHRESULT(774)
#define D3DERR_NOCURRENTVIEWPORT MAKE_DDHRESULT(775)
#define D3DERR_INVALIDVERTEXFORMAT MAKE_DDHRESULT(2048)
#define D3DERR_COLORKEYATTACHED MAKE_DDHRESULT(2050)
#define D3DERR_VERTEXBUFFEROPTIMIZED MAKE_DDHRESULT(2060)
#define D3DERR_VBUF_CREATE_FAILED MAKE_DDHRESULT(2061)
#define D3DERR_VERTEXBUFFERLOCKED MAKE_DDHRESULT(2062)
#define D3DERR_VERTEXBUFFERUNLOCKFAILED MAKE_DDHRESULT(2063)
#define D3DERR_ZBUFFER_NOTPRESENT MAKE_DDHRESULT(2070)
#define D3DERR_STENCILBUFFER_NOTPRESENT MAKE_DDHRESULT(2071)
#define D3DERR_WRONGTEXTUREFORMAT MAKE_DDHRESULT(2072)
#define D3DERR_UNSUPPORTEDCOLOROPERATION MAKE_DDHRESULT(2073)
#define D3DERR_UNSUPPORTEDCOLORARG MAKE_DDHRESULT(2074)
#define D3DERR_UNSUPPORTEDALPHAOPERATION MAKE_DDHRESULT(2075)
#define D3DERR_UNSUPPORTEDALPHAARG MAKE_DDHRESULT(2076)
#define D3DERR_TOOMANYOPERATIONS MAKE_DDHRESULT(2077)
#define D3DERR_CONFLICTINGTEXTUREFILTER MAKE_DDHRESULT(2078)
#define D3DERR_UNSUPPORTEDFACTORVALUE MAKE_DDHRESULT(2079)
#define D3DERR_CONFLICTINGRENDERSTATE MAKE_DDHRESULT(2081)
#define D3DERR_UNSUPPORTEDTEXTUREFILTER MAKE_DDHRESULT(2082)
#define D3DERR_TOOMANYPRIMITIVES MAKE_DDHRESULT(2083)
#define D3DERR_INVALIDMATRIX MAKE_DDHRESULT(2084)
#define D3DERR_TOOMANYVERTICES MAKE_DDHRESULT(2085)
#define D3DERR_CONFLICTINGTEXTUREPALETTE MAKE_DDHRESULT(2086)
#define D3DERR_INVALIDSTATEBLOCK MAKE_DDHRESULT(2100)
#define D3DERR_INBEGINSTATEBLOCK MAKE_DDHRESULT(2101)
#define D3DERR_NOTINBEGINSTATEBLOCK MAKE_DDHRESULT(2102)
const D3DNEXT_NEXT = &h01
const D3DNEXT_HEAD = &h02
const D3DNEXT_TAIL = &h04
const D3DDP_WAIT = &h00000001
const D3DDP_OUTOFORDER = &h00000002
const D3DDP_DONOTCLIP = &h00000004
const D3DDP_DONOTUPDATEEXTENTS = &h00000008
const D3DDP_DONOTLIGHT = &h00000010

type D3DVIEWPORTHANDLE as DWORD
type LPD3DVIEWPORTHANDLE as DWORD ptr
type IDirect3DVtbl as IDirect3DVtbl_

type IDirect3D
	lpVtbl as IDirect3DVtbl ptr
end type

type IDirect3DVtbl_
	QueryInterface as function(byval This as IDirect3D ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3D ptr) as ULONG
	Release as function(byval This as IDirect3D ptr) as ULONG
	Initialize as function(byval This as IDirect3D ptr, byval riid as const IID const ptr) as HRESULT
	EnumDevices as function(byval This as IDirect3D ptr, byval cb as LPD3DENUMDEVICESCALLBACK, byval ctx as any ptr) as HRESULT
	CreateLight as function(byval This as IDirect3D ptr, byval light as IDirect3DLight ptr ptr, byval outer as IUnknown ptr) as HRESULT
	CreateMaterial as function(byval This as IDirect3D ptr, byval material as IDirect3DMaterial ptr ptr, byval outer as IUnknown ptr) as HRESULT
	CreateViewport as function(byval This as IDirect3D ptr, byval viewport as IDirect3DViewport ptr ptr, byval outer as IUnknown ptr) as HRESULT
	FindDevice as function(byval This as IDirect3D ptr, byval search as D3DFINDDEVICESEARCH ptr, byval result as D3DFINDDEVICERESULT ptr) as HRESULT
end type

#define IDirect3D_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3D_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3D_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3D_Initialize(p, a) (p)->lpVtbl->Initialize(p, a)
#define IDirect3D_EnumDevices(p, a, b) (p)->lpVtbl->EnumDevices(p, a, b)
#define IDirect3D_CreateLight(p, a, b) (p)->lpVtbl->CreateLight(p, a, b)
#define IDirect3D_CreateMaterial(p, a, b) (p)->lpVtbl->CreateMaterial(p, a, b)
#define IDirect3D_CreateViewport(p, a, b) (p)->lpVtbl->CreateViewport(p, a, b)
#define IDirect3D_FindDevice(p, a, b) (p)->lpVtbl->FindDevice(p, a, b)
type IDirect3D2Vtbl as IDirect3D2Vtbl_

type IDirect3D2
	lpVtbl as IDirect3D2Vtbl ptr
end type

type IDirect3D2Vtbl_
	QueryInterface as function(byval This as IDirect3D2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3D2 ptr) as ULONG
	Release as function(byval This as IDirect3D2 ptr) as ULONG
	EnumDevices as function(byval This as IDirect3D2 ptr, byval cb as LPD3DENUMDEVICESCALLBACK, byval ctx as any ptr) as HRESULT
	CreateLight as function(byval This as IDirect3D2 ptr, byval light as IDirect3DLight ptr ptr, byval outer as IUnknown ptr) as HRESULT
	CreateMaterial as function(byval This as IDirect3D2 ptr, byval material as IDirect3DMaterial2 ptr ptr, byval outer as IUnknown ptr) as HRESULT
	CreateViewport as function(byval This as IDirect3D2 ptr, byval viewport as IDirect3DViewport2 ptr ptr, byval outer as IUnknown ptr) as HRESULT
	FindDevice as function(byval This as IDirect3D2 ptr, byval search as D3DFINDDEVICESEARCH ptr, byval result as D3DFINDDEVICERESULT ptr) as HRESULT
	CreateDevice as function(byval This as IDirect3D2 ptr, byval rclsid as const IID const ptr, byval surface as IDirectDrawSurface ptr, byval device as IDirect3DDevice2 ptr ptr) as HRESULT
end type

#define IDirect3D2_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3D2_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3D2_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3D2_EnumDevices(p, a, b) (p)->lpVtbl->EnumDevices(p, a, b)
#define IDirect3D2_CreateLight(p, a, b) (p)->lpVtbl->CreateLight(p, a, b)
#define IDirect3D2_CreateMaterial(p, a, b) (p)->lpVtbl->CreateMaterial(p, a, b)
#define IDirect3D2_CreateViewport(p, a, b) (p)->lpVtbl->CreateViewport(p, a, b)
#define IDirect3D2_FindDevice(p, a, b) (p)->lpVtbl->FindDevice(p, a, b)
#define IDirect3D2_CreateDevice(p, a, b, c) (p)->lpVtbl->CreateDevice(p, a, b, c)
type IDirect3D3Vtbl as IDirect3D3Vtbl_

type IDirect3D3
	lpVtbl as IDirect3D3Vtbl ptr
end type

type IDirect3D3Vtbl_
	QueryInterface as function(byval This as IDirect3D3 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3D3 ptr) as ULONG
	Release as function(byval This as IDirect3D3 ptr) as ULONG
	EnumDevices as function(byval This as IDirect3D3 ptr, byval cb as LPD3DENUMDEVICESCALLBACK, byval ctx as any ptr) as HRESULT
	CreateLight as function(byval This as IDirect3D3 ptr, byval light as IDirect3DLight ptr ptr, byval outer as IUnknown ptr) as HRESULT
	CreateMaterial as function(byval This as IDirect3D3 ptr, byval material as IDirect3DMaterial3 ptr ptr, byval outer as IUnknown ptr) as HRESULT
	CreateViewport as function(byval This as IDirect3D3 ptr, byval viewport as IDirect3DViewport3 ptr ptr, byval outer as IUnknown ptr) as HRESULT
	FindDevice as function(byval This as IDirect3D3 ptr, byval search as D3DFINDDEVICESEARCH ptr, byval result as D3DFINDDEVICERESULT ptr) as HRESULT
	CreateDevice as function(byval This as IDirect3D3 ptr, byval rclsid as const IID const ptr, byval surface as IDirectDrawSurface4 ptr, byval device as IDirect3DDevice3 ptr ptr, byval outer as IUnknown ptr) as HRESULT
	CreateVertexBuffer as function(byval This as IDirect3D3 ptr, byval desc as D3DVERTEXBUFFERDESC ptr, byval buffer as IDirect3DVertexBuffer ptr ptr, byval flags as DWORD, byval outer as IUnknown ptr) as HRESULT
	EnumZBufferFormats as function(byval This as IDirect3D3 ptr, byval device_iid as const IID const ptr, byval cb as LPD3DENUMPIXELFORMATSCALLBACK, byval ctx as any ptr) as HRESULT
	EvictManagedTextures as function(byval This as IDirect3D3 ptr) as HRESULT
end type

#define IDirect3D3_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3D3_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3D3_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3D3_EnumDevices(p, a, b) (p)->lpVtbl->EnumDevices(p, a, b)
#define IDirect3D3_CreateLight(p, a, b) (p)->lpVtbl->CreateLight(p, a, b)
#define IDirect3D3_CreateMaterial(p, a, b) (p)->lpVtbl->CreateMaterial(p, a, b)
#define IDirect3D3_CreateViewport(p, a, b) (p)->lpVtbl->CreateViewport(p, a, b)
#define IDirect3D3_FindDevice(p, a, b) (p)->lpVtbl->FindDevice(p, a, b)
#define IDirect3D3_CreateDevice(p, a, b, c, d) (p)->lpVtbl->CreateDevice(p, a, b, c, d)
#define IDirect3D3_CreateVertexBuffer(p, a, b, c, d) (p)->lpVtbl->CreateVertexBuffer(p, a, b, c, d)
#define IDirect3D3_EnumZBufferFormats(p, a, b, c) (p)->lpVtbl->EnumZBufferFormats(p, a, b, c)
#define IDirect3D3_EvictManagedTextures(p) (p)->lpVtbl->EvictManagedTextures(p)
type IDirect3D7Vtbl as IDirect3D7Vtbl_

type IDirect3D7
	lpVtbl as IDirect3D7Vtbl ptr
end type

type IDirect3D7Vtbl_
	QueryInterface as function(byval This as IDirect3D7 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3D7 ptr) as ULONG
	Release as function(byval This as IDirect3D7 ptr) as ULONG
	EnumDevices as function(byval This as IDirect3D7 ptr, byval cb as LPD3DENUMDEVICESCALLBACK7, byval ctx as any ptr) as HRESULT
	CreateDevice as function(byval This as IDirect3D7 ptr, byval rclsid as const IID const ptr, byval surface as IDirectDrawSurface7 ptr, byval device as IDirect3DDevice7 ptr ptr) as HRESULT
	CreateVertexBuffer as function(byval This as IDirect3D7 ptr, byval desc as D3DVERTEXBUFFERDESC ptr, byval buffer as IDirect3DVertexBuffer7 ptr ptr, byval flags as DWORD) as HRESULT
	EnumZBufferFormats as function(byval This as IDirect3D7 ptr, byval device_iid as const IID const ptr, byval cb as LPD3DENUMPIXELFORMATSCALLBACK, byval ctx as any ptr) as HRESULT
	EvictManagedTextures as function(byval This as IDirect3D7 ptr) as HRESULT
end type

#define IDirect3D7_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3D7_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3D7_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3D7_EnumDevices(p, a, b) (p)->lpVtbl->EnumDevices(p, a, b)
#define IDirect3D7_CreateDevice(p, a, b, c) (p)->lpVtbl->CreateDevice(p, a, b, c)
#define IDirect3D7_CreateVertexBuffer(p, a, b, c) (p)->lpVtbl->CreateVertexBuffer(p, a, b, c)
#define IDirect3D7_EnumZBufferFormats(p, a, b, c) (p)->lpVtbl->EnumZBufferFormats(p, a, b, c)
#define IDirect3D7_EvictManagedTextures(p) (p)->lpVtbl->EvictManagedTextures(p)
type IDirect3DLightVtbl as IDirect3DLightVtbl_

type IDirect3DLight_
	lpVtbl as IDirect3DLightVtbl ptr
end type

type IDirect3DLightVtbl_
	QueryInterface as function(byval This as IDirect3DLight ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DLight ptr) as ULONG
	Release as function(byval This as IDirect3DLight ptr) as ULONG
	Initialize as function(byval This as IDirect3DLight ptr, byval d3d as IDirect3D ptr) as HRESULT
	SetLight as function(byval This as IDirect3DLight ptr, byval data as D3DLIGHT ptr) as HRESULT
	GetLight as function(byval This as IDirect3DLight ptr, byval data as D3DLIGHT ptr) as HRESULT
end type

#define IDirect3DLight_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DLight_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DLight_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DLight_Initialize(p, a) (p)->lpVtbl->Initialize(p, a)
#define IDirect3DLight_SetLight(p, a) (p)->lpVtbl->SetLight(p, a)
#define IDirect3DLight_GetLight(p, a) (p)->lpVtbl->GetLight(p, a)
type IDirect3DMaterialVtbl as IDirect3DMaterialVtbl_

type IDirect3DMaterial_
	lpVtbl as IDirect3DMaterialVtbl ptr
end type

type IDirect3DMaterialVtbl_
	QueryInterface as function(byval This as IDirect3DMaterial ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DMaterial ptr) as ULONG
	Release as function(byval This as IDirect3DMaterial ptr) as ULONG
	Initialize as function(byval This as IDirect3DMaterial ptr, byval d3d as IDirect3D ptr) as HRESULT
	SetMaterial as function(byval This as IDirect3DMaterial ptr, byval data as D3DMATERIAL ptr) as HRESULT
	GetMaterial as function(byval This as IDirect3DMaterial ptr, byval data as D3DMATERIAL ptr) as HRESULT
	GetHandle as function(byval This as IDirect3DMaterial ptr, byval device as IDirect3DDevice ptr, byval handle as D3DMATERIALHANDLE ptr) as HRESULT
	Reserve as function(byval This as IDirect3DMaterial ptr) as HRESULT
	Unreserve as function(byval This as IDirect3DMaterial ptr) as HRESULT
end type

#define IDirect3DMaterial_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DMaterial_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DMaterial_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DMaterial_Initialize(p, a) (p)->lpVtbl->Initialize(p, a)
#define IDirect3DMaterial_SetMaterial(p, a) (p)->lpVtbl->SetMaterial(p, a)
#define IDirect3DMaterial_GetMaterial(p, a) (p)->lpVtbl->GetMaterial(p, a)
#define IDirect3DMaterial_GetHandle(p, a, b) (p)->lpVtbl->GetHandle(p, a, b)
#define IDirect3DMaterial_Reserve(p) (p)->lpVtbl->Reserve(p)
#define IDirect3DMaterial_Unreserve(p) (p)->lpVtbl->Unreserve(p)
type IDirect3DMaterial2Vtbl as IDirect3DMaterial2Vtbl_

type IDirect3DMaterial2_
	lpVtbl as IDirect3DMaterial2Vtbl ptr
end type

type IDirect3DMaterial2Vtbl_
	QueryInterface as function(byval This as IDirect3DMaterial2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DMaterial2 ptr) as ULONG
	Release as function(byval This as IDirect3DMaterial2 ptr) as ULONG
	SetMaterial as function(byval This as IDirect3DMaterial2 ptr, byval data as D3DMATERIAL ptr) as HRESULT
	GetMaterial as function(byval This as IDirect3DMaterial2 ptr, byval data as D3DMATERIAL ptr) as HRESULT
	GetHandle as function(byval This as IDirect3DMaterial2 ptr, byval device as IDirect3DDevice2 ptr, byval handle as D3DMATERIALHANDLE ptr) as HRESULT
end type

#define IDirect3DMaterial2_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DMaterial2_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DMaterial2_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DMaterial2_SetMaterial(p, a) (p)->lpVtbl->SetMaterial(p, a)
#define IDirect3DMaterial2_GetMaterial(p, a) (p)->lpVtbl->GetMaterial(p, a)
#define IDirect3DMaterial2_GetHandle(p, a, b) (p)->lpVtbl->GetHandle(p, a, b)
type IDirect3DMaterial3Vtbl as IDirect3DMaterial3Vtbl_

type IDirect3DMaterial3_
	lpVtbl as IDirect3DMaterial3Vtbl ptr
end type

type IDirect3DMaterial3Vtbl_
	QueryInterface as function(byval This as IDirect3DMaterial3 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DMaterial3 ptr) as ULONG
	Release as function(byval This as IDirect3DMaterial3 ptr) as ULONG
	SetMaterial as function(byval This as IDirect3DMaterial3 ptr, byval data as D3DMATERIAL ptr) as HRESULT
	GetMaterial as function(byval This as IDirect3DMaterial3 ptr, byval data as D3DMATERIAL ptr) as HRESULT
	GetHandle as function(byval This as IDirect3DMaterial3 ptr, byval device as IDirect3DDevice3 ptr, byval handle as D3DMATERIALHANDLE ptr) as HRESULT
end type

#define IDirect3DMaterial3_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DMaterial3_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DMaterial3_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DMaterial3_SetMaterial(p, a) (p)->lpVtbl->SetMaterial(p, a)
#define IDirect3DMaterial3_GetMaterial(p, a) (p)->lpVtbl->GetMaterial(p, a)
#define IDirect3DMaterial3_GetHandle(p, a, b) (p)->lpVtbl->GetHandle(p, a, b)
type IDirect3DTextureVtbl as IDirect3DTextureVtbl_

type IDirect3DTexture
	lpVtbl as IDirect3DTextureVtbl ptr
end type

type IDirect3DTextureVtbl_
	QueryInterface as function(byval This as IDirect3DTexture ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DTexture ptr) as ULONG
	Release as function(byval This as IDirect3DTexture ptr) as ULONG
	Initialize as function(byval This as IDirect3DTexture ptr, byval device as IDirect3DDevice ptr, byval surface as IDirectDrawSurface ptr) as HRESULT
	GetHandle as function(byval This as IDirect3DTexture ptr, byval device as IDirect3DDevice ptr, byval handle as D3DTEXTUREHANDLE ptr) as HRESULT
	PaletteChanged as function(byval This as IDirect3DTexture ptr, byval dwStart as DWORD, byval dwCount as DWORD) as HRESULT
	Load as function(byval This as IDirect3DTexture ptr, byval texture as IDirect3DTexture ptr) as HRESULT
	Unload as function(byval This as IDirect3DTexture ptr) as HRESULT
end type

#define IDirect3DTexture_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DTexture_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DTexture_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DTexture_Initialize(p, a, b) (p)->lpVtbl->Initialize(p, a, b)
#define IDirect3DTexture_GetHandle(p, a, b) (p)->lpVtbl->GetHandle(p, a, b)
#define IDirect3DTexture_PaletteChanged(p, a, b) (p)->lpVtbl->PaletteChanged(p, a, b)
#define IDirect3DTexture_Load(p, a) (p)->lpVtbl->Load(p, a)
#define IDirect3DTexture_Unload(p) (p)->lpVtbl->Unload(p)
type IDirect3DTexture2Vtbl as IDirect3DTexture2Vtbl_

type IDirect3DTexture2
	lpVtbl as IDirect3DTexture2Vtbl ptr
end type

type IDirect3DTexture2Vtbl_
	QueryInterface as function(byval This as IDirect3DTexture2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DTexture2 ptr) as ULONG
	Release as function(byval This as IDirect3DTexture2 ptr) as ULONG
	GetHandle as function(byval This as IDirect3DTexture2 ptr, byval device as IDirect3DDevice2 ptr, byval handle as D3DTEXTUREHANDLE ptr) as HRESULT
	PaletteChanged as function(byval This as IDirect3DTexture2 ptr, byval dwStart as DWORD, byval dwCount as DWORD) as HRESULT
	Load as function(byval This as IDirect3DTexture2 ptr, byval texture as IDirect3DTexture2 ptr) as HRESULT
end type

#define IDirect3DTexture2_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DTexture2_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DTexture2_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DTexture2_GetHandle(p, a, b) (p)->lpVtbl->GetHandle(p, a, b)
#define IDirect3DTexture2_PaletteChanged(p, a, b) (p)->lpVtbl->PaletteChanged(p, a, b)
#define IDirect3DTexture2_Load(p, a) (p)->lpVtbl->Load(p, a)
type IDirect3DViewportVtbl as IDirect3DViewportVtbl_

type IDirect3DViewport_
	lpVtbl as IDirect3DViewportVtbl ptr
end type

type IDirect3DViewportVtbl_
	QueryInterface as function(byval This as IDirect3DViewport ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DViewport ptr) as ULONG
	Release as function(byval This as IDirect3DViewport ptr) as ULONG
	Initialize as function(byval This as IDirect3DViewport ptr, byval d3d as IDirect3D ptr) as HRESULT
	GetViewport as function(byval This as IDirect3DViewport ptr, byval data as D3DVIEWPORT ptr) as HRESULT
	SetViewport as function(byval This as IDirect3DViewport ptr, byval data as D3DVIEWPORT ptr) as HRESULT
	TransformVertices as function(byval This as IDirect3DViewport ptr, byval vertex_count as DWORD, byval data as D3DTRANSFORMDATA ptr, byval flags as DWORD, byval offscreen as DWORD ptr) as HRESULT
	LightElements as function(byval This as IDirect3DViewport ptr, byval element_count as DWORD, byval data as D3DLIGHTDATA ptr) as HRESULT
	SetBackground as function(byval This as IDirect3DViewport ptr, byval hMat as D3DMATERIALHANDLE) as HRESULT
	GetBackground as function(byval This as IDirect3DViewport ptr, byval material as D3DMATERIALHANDLE ptr, byval valid as WINBOOL ptr) as HRESULT
	SetBackgroundDepth as function(byval This as IDirect3DViewport ptr, byval surface as IDirectDrawSurface ptr) as HRESULT
	GetBackgroundDepth as function(byval This as IDirect3DViewport ptr, byval surface as IDirectDrawSurface ptr ptr, byval valid as WINBOOL ptr) as HRESULT
	Clear as function(byval This as IDirect3DViewport ptr, byval count as DWORD, byval rects as D3DRECT ptr, byval flags as DWORD) as HRESULT
	AddLight as function(byval This as IDirect3DViewport ptr, byval light as IDirect3DLight ptr) as HRESULT
	DeleteLight as function(byval This as IDirect3DViewport ptr, byval light as IDirect3DLight ptr) as HRESULT
	NextLight as function(byval This as IDirect3DViewport ptr, byval ref as IDirect3DLight ptr, byval light as IDirect3DLight ptr ptr, byval flags as DWORD) as HRESULT
end type

#define IDirect3DViewport_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DViewport_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DViewport_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DViewport_Initialize(p, a) (p)->lpVtbl->Initialize(p, a)
#define IDirect3DViewport_GetViewport(p, a) (p)->lpVtbl->GetViewport(p, a)
#define IDirect3DViewport_SetViewport(p, a) (p)->lpVtbl->SetViewport(p, a)
#define IDirect3DViewport_TransformVertices(p, a, b, c, d) (p)->lpVtbl->TransformVertices(p, a, b, c, d)
#define IDirect3DViewport_LightElements(p, a, b) (p)->lpVtbl->LightElements(p, a, b)
#define IDirect3DViewport_SetBackground(p, a) (p)->lpVtbl->SetBackground(p, a)
#define IDirect3DViewport_GetBackground(p, a, b) (p)->lpVtbl->GetBackground(p, a, b)
#define IDirect3DViewport_SetBackgroundDepth(p, a) (p)->lpVtbl->SetBackgroundDepth(p, a)
#define IDirect3DViewport_GetBackgroundDepth(p, a, b) (p)->lpVtbl->GetBackgroundDepth(p, a, b)
#define IDirect3DViewport_Clear(p, a, b, c) (p)->lpVtbl->Clear(p, a, b, c)
#define IDirect3DViewport_AddLight(p, a) (p)->lpVtbl->AddLight(p, a)
#define IDirect3DViewport_DeleteLight(p, a) (p)->lpVtbl->DeleteLight(p, a)
#define IDirect3DViewport_NextLight(p, a, b, c) (p)->lpVtbl->NextLight(p, a, b, c)
type IDirect3DViewport2Vtbl as IDirect3DViewport2Vtbl_

type IDirect3DViewport2_
	lpVtbl as IDirect3DViewport2Vtbl ptr
end type

type IDirect3DViewport2Vtbl_
	QueryInterface as function(byval This as IDirect3DViewport2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DViewport2 ptr) as ULONG
	Release as function(byval This as IDirect3DViewport2 ptr) as ULONG
	Initialize as function(byval This as IDirect3DViewport2 ptr, byval d3d as IDirect3D ptr) as HRESULT
	GetViewport as function(byval This as IDirect3DViewport2 ptr, byval data as D3DVIEWPORT ptr) as HRESULT
	SetViewport as function(byval This as IDirect3DViewport2 ptr, byval data as D3DVIEWPORT ptr) as HRESULT
	TransformVertices as function(byval This as IDirect3DViewport2 ptr, byval vertex_count as DWORD, byval data as D3DTRANSFORMDATA ptr, byval flags as DWORD, byval offscreen as DWORD ptr) as HRESULT
	LightElements as function(byval This as IDirect3DViewport2 ptr, byval element_count as DWORD, byval data as D3DLIGHTDATA ptr) as HRESULT
	SetBackground as function(byval This as IDirect3DViewport2 ptr, byval hMat as D3DMATERIALHANDLE) as HRESULT
	GetBackground as function(byval This as IDirect3DViewport2 ptr, byval material as D3DMATERIALHANDLE ptr, byval valid as WINBOOL ptr) as HRESULT
	SetBackgroundDepth as function(byval This as IDirect3DViewport2 ptr, byval surface as IDirectDrawSurface ptr) as HRESULT
	GetBackgroundDepth as function(byval This as IDirect3DViewport2 ptr, byval surface as IDirectDrawSurface ptr ptr, byval valid as WINBOOL ptr) as HRESULT
	Clear as function(byval This as IDirect3DViewport2 ptr, byval count as DWORD, byval rects as D3DRECT ptr, byval flags as DWORD) as HRESULT
	AddLight as function(byval This as IDirect3DViewport2 ptr, byval light as IDirect3DLight ptr) as HRESULT
	DeleteLight as function(byval This as IDirect3DViewport2 ptr, byval light as IDirect3DLight ptr) as HRESULT
	NextLight as function(byval This as IDirect3DViewport2 ptr, byval ref as IDirect3DLight ptr, byval light as IDirect3DLight ptr ptr, byval flags as DWORD) as HRESULT
	GetViewport2 as function(byval This as IDirect3DViewport2 ptr, byval data as D3DVIEWPORT2 ptr) as HRESULT
	SetViewport2 as function(byval This as IDirect3DViewport2 ptr, byval data as D3DVIEWPORT2 ptr) as HRESULT
end type

#define IDirect3DViewport2_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DViewport2_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DViewport2_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DViewport2_Initialize(p, a) (p)->lpVtbl->Initialize(p, a)
#define IDirect3DViewport2_GetViewport(p, a) (p)->lpVtbl->GetViewport(p, a)
#define IDirect3DViewport2_SetViewport(p, a) (p)->lpVtbl->SetViewport(p, a)
#define IDirect3DViewport2_TransformVertices(p, a, b, c, d) (p)->lpVtbl->TransformVertices(p, a, b, c, d)
#define IDirect3DViewport2_LightElements(p, a, b) (p)->lpVtbl->LightElements(p, a, b)
#define IDirect3DViewport2_SetBackground(p, a) (p)->lpVtbl->SetBackground(p, a)
#define IDirect3DViewport2_GetBackground(p, a, b) (p)->lpVtbl->GetBackground(p, a, b)
#define IDirect3DViewport2_SetBackgroundDepth(p, a) (p)->lpVtbl->SetBackgroundDepth(p, a)
#define IDirect3DViewport2_GetBackgroundDepth(p, a, b) (p)->lpVtbl->GetBackgroundDepth(p, a, b)
#define IDirect3DViewport2_Clear(p, a, b, c) (p)->lpVtbl->Clear(p, a, b, c)
#define IDirect3DViewport2_AddLight(p, a) (p)->lpVtbl->AddLight(p, a)
#define IDirect3DViewport2_DeleteLight(p, a) (p)->lpVtbl->DeleteLight(p, a)
#define IDirect3DViewport2_NextLight(p, a, b, c) (p)->lpVtbl->NextLight(p, a, b, c)
#define IDirect3DViewport2_GetViewport2(p, a) (p)->lpVtbl->GetViewport2(p, a)
#define IDirect3DViewport2_SetViewport2(p, a) (p)->lpVtbl->SetViewport2(p, a)
type IDirect3DViewport3Vtbl as IDirect3DViewport3Vtbl_

type IDirect3DViewport3_
	lpVtbl as IDirect3DViewport3Vtbl ptr
end type

type IDirect3DViewport3Vtbl_
	QueryInterface as function(byval This as IDirect3DViewport3 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DViewport3 ptr) as ULONG
	Release as function(byval This as IDirect3DViewport3 ptr) as ULONG
	Initialize as function(byval This as IDirect3DViewport3 ptr, byval d3d as IDirect3D ptr) as HRESULT
	GetViewport as function(byval This as IDirect3DViewport3 ptr, byval data as D3DVIEWPORT ptr) as HRESULT
	SetViewport as function(byval This as IDirect3DViewport3 ptr, byval data as D3DVIEWPORT ptr) as HRESULT
	TransformVertices as function(byval This as IDirect3DViewport3 ptr, byval vertex_count as DWORD, byval data as D3DTRANSFORMDATA ptr, byval flags as DWORD, byval offscreen as DWORD ptr) as HRESULT
	LightElements as function(byval This as IDirect3DViewport3 ptr, byval element_count as DWORD, byval data as D3DLIGHTDATA ptr) as HRESULT
	SetBackground as function(byval This as IDirect3DViewport3 ptr, byval hMat as D3DMATERIALHANDLE) as HRESULT
	GetBackground as function(byval This as IDirect3DViewport3 ptr, byval material as D3DMATERIALHANDLE ptr, byval valid as WINBOOL ptr) as HRESULT
	SetBackgroundDepth as function(byval This as IDirect3DViewport3 ptr, byval surface as IDirectDrawSurface ptr) as HRESULT
	GetBackgroundDepth as function(byval This as IDirect3DViewport3 ptr, byval surface as IDirectDrawSurface ptr ptr, byval valid as WINBOOL ptr) as HRESULT
	Clear as function(byval This as IDirect3DViewport3 ptr, byval count as DWORD, byval rects as D3DRECT ptr, byval flags as DWORD) as HRESULT
	AddLight as function(byval This as IDirect3DViewport3 ptr, byval light as IDirect3DLight ptr) as HRESULT
	DeleteLight as function(byval This as IDirect3DViewport3 ptr, byval light as IDirect3DLight ptr) as HRESULT
	NextLight as function(byval This as IDirect3DViewport3 ptr, byval ref as IDirect3DLight ptr, byval light as IDirect3DLight ptr ptr, byval flags as DWORD) as HRESULT
	GetViewport2 as function(byval This as IDirect3DViewport3 ptr, byval data as D3DVIEWPORT2 ptr) as HRESULT
	SetViewport2 as function(byval This as IDirect3DViewport3 ptr, byval data as D3DVIEWPORT2 ptr) as HRESULT
	SetBackgroundDepth2 as function(byval This as IDirect3DViewport3 ptr, byval surface as IDirectDrawSurface4 ptr) as HRESULT
	GetBackgroundDepth2 as function(byval This as IDirect3DViewport3 ptr, byval surface as IDirectDrawSurface4 ptr ptr, byval valid as WINBOOL ptr) as HRESULT
	Clear2 as function(byval This as IDirect3DViewport3 ptr, byval count as DWORD, byval rects as D3DRECT ptr, byval flags as DWORD, byval color as DWORD, byval z as D3DVALUE, byval stencil as DWORD) as HRESULT
end type

#define IDirect3DViewport3_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DViewport3_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DViewport3_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DViewport3_Initialize(p, a) (p)->lpVtbl->Initialize(p, a)
#define IDirect3DViewport3_GetViewport(p, a) (p)->lpVtbl->GetViewport(p, a)
#define IDirect3DViewport3_SetViewport(p, a) (p)->lpVtbl->SetViewport(p, a)
#define IDirect3DViewport3_TransformVertices(p, a, b, c, d) (p)->lpVtbl->TransformVertices(p, a, b, c, d)
#define IDirect3DViewport3_LightElements(p, a, b) (p)->lpVtbl->LightElements(p, a, b)
#define IDirect3DViewport3_SetBackground(p, a) (p)->lpVtbl->SetBackground(p, a)
#define IDirect3DViewport3_GetBackground(p, a, b) (p)->lpVtbl->GetBackground(p, a, b)
#define IDirect3DViewport3_SetBackgroundDepth(p, a) (p)->lpVtbl->SetBackgroundDepth(p, a)
#define IDirect3DViewport3_GetBackgroundDepth(p, a, b) (p)->lpVtbl->GetBackgroundDepth(p, a, b)
#define IDirect3DViewport3_Clear(p, a, b, c) (p)->lpVtbl->Clear(p, a, b, c)
#define IDirect3DViewport3_AddLight(p, a) (p)->lpVtbl->AddLight(p, a)
#define IDirect3DViewport3_DeleteLight(p, a) (p)->lpVtbl->DeleteLight(p, a)
#define IDirect3DViewport3_NextLight(p, a, b, c) (p)->lpVtbl->NextLight(p, a, b, c)
#define IDirect3DViewport3_GetViewport2(p, a) (p)->lpVtbl->GetViewport2(p, a)
#define IDirect3DViewport3_SetViewport2(p, a) (p)->lpVtbl->SetViewport2(p, a)
#define IDirect3DViewport3_SetBackgroundDepth2(p, a) (p)->lpVtbl->SetBackgroundDepth2(p, a)
#define IDirect3DViewport3_GetBackgroundDepth2(p, a, b) (p)->lpVtbl->GetBackgroundDepth2(p, a, b)
#define IDirect3DViewport3_Clear2(p, a, b, c, d, e, f) (p)->lpVtbl->Clear2(p, a, b, c, d, e, f)
type IDirect3DExecuteBufferVtbl as IDirect3DExecuteBufferVtbl_

type IDirect3DExecuteBuffer
	lpVtbl as IDirect3DExecuteBufferVtbl ptr
end type

type IDirect3DExecuteBufferVtbl_
	QueryInterface as function(byval This as IDirect3DExecuteBuffer ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DExecuteBuffer ptr) as ULONG
	Release as function(byval This as IDirect3DExecuteBuffer ptr) as ULONG
	Initialize as function(byval This as IDirect3DExecuteBuffer ptr, byval device as IDirect3DDevice ptr, byval desc as D3DEXECUTEBUFFERDESC ptr) as HRESULT
	Lock as function(byval This as IDirect3DExecuteBuffer ptr, byval desc as D3DEXECUTEBUFFERDESC ptr) as HRESULT
	Unlock as function(byval This as IDirect3DExecuteBuffer ptr) as HRESULT
	SetExecuteData as function(byval This as IDirect3DExecuteBuffer ptr, byval data as D3DEXECUTEDATA ptr) as HRESULT
	GetExecuteData as function(byval This as IDirect3DExecuteBuffer ptr, byval data as D3DEXECUTEDATA ptr) as HRESULT
	Validate as function(byval This as IDirect3DExecuteBuffer ptr, byval offset as DWORD ptr, byval cb as LPD3DVALIDATECALLBACK, byval ctx as any ptr, byval reserved as DWORD) as HRESULT
	Optimize as function(byval This as IDirect3DExecuteBuffer ptr, byval dwDummy as DWORD) as HRESULT
end type

#define IDirect3DExecuteBuffer_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DExecuteBuffer_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DExecuteBuffer_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DExecuteBuffer_Initialize(p, a, b) (p)->lpVtbl->Initialize(p, a, b)
#define IDirect3DExecuteBuffer_Lock(p, a) (p)->lpVtbl->Lock(p, a)
#define IDirect3DExecuteBuffer_Unlock(p) (p)->lpVtbl->Unlock(p)
#define IDirect3DExecuteBuffer_SetExecuteData(p, a) (p)->lpVtbl->SetExecuteData(p, a)
#define IDirect3DExecuteBuffer_GetExecuteData(p, a) (p)->lpVtbl->GetExecuteData(p, a)
#define IDirect3DExecuteBuffer_Validate(p, a, b, c, d) (p)->lpVtbl->Validate(p, a, b, c, d)
#define IDirect3DExecuteBuffer_Optimize(p, a) (p)->lpVtbl->Optimize(p, a)
type IDirect3DDeviceVtbl as IDirect3DDeviceVtbl_

type IDirect3DDevice_
	lpVtbl as IDirect3DDeviceVtbl ptr
end type

type IDirect3DDeviceVtbl_
	QueryInterface as function(byval This as IDirect3DDevice ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DDevice ptr) as ULONG
	Release as function(byval This as IDirect3DDevice ptr) as ULONG
	Initialize as function(byval This as IDirect3DDevice ptr, byval d3d as IDirect3D ptr, byval guid as GUID ptr, byval desc as D3DDEVICEDESC ptr) as HRESULT
	GetCaps as function(byval This as IDirect3DDevice ptr, byval hal_desc as D3DDEVICEDESC ptr, byval hel_desc as D3DDEVICEDESC ptr) as HRESULT
	SwapTextureHandles as function(byval This as IDirect3DDevice ptr, byval tex1 as IDirect3DTexture ptr, byval tex2 as IDirect3DTexture ptr) as HRESULT
	CreateExecuteBuffer as function(byval This as IDirect3DDevice ptr, byval desc as D3DEXECUTEBUFFERDESC ptr, byval buffer as IDirect3DExecuteBuffer ptr ptr, byval outer as IUnknown ptr) as HRESULT
	GetStats as function(byval This as IDirect3DDevice ptr, byval stats as D3DSTATS ptr) as HRESULT
	Execute as function(byval This as IDirect3DDevice ptr, byval buffer as IDirect3DExecuteBuffer ptr, byval viewport as IDirect3DViewport ptr, byval flags as DWORD) as HRESULT
	AddViewport as function(byval This as IDirect3DDevice ptr, byval viewport as IDirect3DViewport ptr) as HRESULT
	DeleteViewport as function(byval This as IDirect3DDevice ptr, byval viewport as IDirect3DViewport ptr) as HRESULT
	NextViewport as function(byval This as IDirect3DDevice ptr, byval ref as IDirect3DViewport ptr, byval viewport as IDirect3DViewport ptr ptr, byval flags as DWORD) as HRESULT
	Pick as function(byval This as IDirect3DDevice ptr, byval buffer as IDirect3DExecuteBuffer ptr, byval viewport as IDirect3DViewport ptr, byval flags as DWORD, byval rect as D3DRECT ptr) as HRESULT
	GetPickRecords as function(byval This as IDirect3DDevice ptr, byval count as DWORD ptr, byval records as D3DPICKRECORD ptr) as HRESULT
	EnumTextureFormats as function(byval This as IDirect3DDevice ptr, byval cb as LPD3DENUMTEXTUREFORMATSCALLBACK, byval ctx as any ptr) as HRESULT
	CreateMatrix as function(byval This as IDirect3DDevice ptr, byval matrix as D3DMATRIXHANDLE ptr) as HRESULT
	SetMatrix as function(byval This as IDirect3DDevice ptr, byval handle as D3DMATRIXHANDLE, byval matrix as D3DMATRIX ptr) as HRESULT
	GetMatrix as function(byval This as IDirect3DDevice ptr, byval handle as D3DMATRIXHANDLE, byval matrix as D3DMATRIX ptr) as HRESULT
	DeleteMatrix as function(byval This as IDirect3DDevice ptr, byval D3DMatHandle as D3DMATRIXHANDLE) as HRESULT
	BeginScene as function(byval This as IDirect3DDevice ptr) as HRESULT
	EndScene as function(byval This as IDirect3DDevice ptr) as HRESULT
	GetDirect3D as function(byval This as IDirect3DDevice ptr, byval d3d as IDirect3D ptr ptr) as HRESULT
end type

#define IDirect3DDevice_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DDevice_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DDevice_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DDevice_Initialize(p, a, b, c) (p)->lpVtbl->Initialize(p, a, b, c)
#define IDirect3DDevice_GetCaps(p, a, b) (p)->lpVtbl->GetCaps(p, a, b)
#define IDirect3DDevice_SwapTextureHandles(p, a, b) (p)->lpVtbl->SwapTextureHandles(p, a, b)
#define IDirect3DDevice_CreateExecuteBuffer(p, a, b, c) (p)->lpVtbl->CreateExecuteBuffer(p, a, b, c)
#define IDirect3DDevice_GetStats(p, a) (p)->lpVtbl->GetStats(p, a)
#define IDirect3DDevice_Execute(p, a, b, c) (p)->lpVtbl->Execute(p, a, b, c)
#define IDirect3DDevice_AddViewport(p, a) (p)->lpVtbl->AddViewport(p, a)
#define IDirect3DDevice_DeleteViewport(p, a) (p)->lpVtbl->DeleteViewport(p, a)
#define IDirect3DDevice_NextViewport(p, a, b, c) (p)->lpVtbl->NextViewport(p, a, b, c)
#define IDirect3DDevice_Pick(p, a, b, c, d) (p)->lpVtbl->Pick(p, a, b, c, d)
#define IDirect3DDevice_GetPickRecords(p, a, b) (p)->lpVtbl->GetPickRecords(p, a, b)
#define IDirect3DDevice_EnumTextureFormats(p, a, b) (p)->lpVtbl->EnumTextureFormats(p, a, b)
#define IDirect3DDevice_CreateMatrix(p, a) (p)->lpVtbl->CreateMatrix(p, a)
#define IDirect3DDevice_SetMatrix(p, a, b) (p)->lpVtbl->SetMatrix(p, a, b)
#define IDirect3DDevice_GetMatrix(p, a, b) (p)->lpVtbl->GetMatrix(p, a, b)
#define IDirect3DDevice_DeleteMatrix(p, a) (p)->lpVtbl->DeleteMatrix(p, a)
#define IDirect3DDevice_BeginScene(p) (p)->lpVtbl->BeginScene(p)
#define IDirect3DDevice_EndScene(p) (p)->lpVtbl->EndScene(p)
#define IDirect3DDevice_GetDirect3D(p, a) (p)->lpVtbl->GetDirect3D(p, a)
type IDirect3DDevice2Vtbl as IDirect3DDevice2Vtbl_

type IDirect3DDevice2_
	lpVtbl as IDirect3DDevice2Vtbl ptr
end type

type IDirect3DDevice2Vtbl_
	QueryInterface as function(byval This as IDirect3DDevice2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DDevice2 ptr) as ULONG
	Release as function(byval This as IDirect3DDevice2 ptr) as ULONG
	GetCaps as function(byval This as IDirect3DDevice2 ptr, byval hal_desc as D3DDEVICEDESC ptr, byval hel_desc as D3DDEVICEDESC ptr) as HRESULT
	SwapTextureHandles as function(byval This as IDirect3DDevice2 ptr, byval tex1 as IDirect3DTexture2 ptr, byval tex2 as IDirect3DTexture2 ptr) as HRESULT
	GetStats as function(byval This as IDirect3DDevice2 ptr, byval stats as D3DSTATS ptr) as HRESULT
	AddViewport as function(byval This as IDirect3DDevice2 ptr, byval viewport as IDirect3DViewport2 ptr) as HRESULT
	DeleteViewport as function(byval This as IDirect3DDevice2 ptr, byval viewport as IDirect3DViewport2 ptr) as HRESULT
	NextViewport as function(byval This as IDirect3DDevice2 ptr, byval ref as IDirect3DViewport2 ptr, byval viewport as IDirect3DViewport2 ptr ptr, byval flags as DWORD) as HRESULT
	EnumTextureFormats as function(byval This as IDirect3DDevice2 ptr, byval cb as LPD3DENUMTEXTUREFORMATSCALLBACK, byval ctx as any ptr) as HRESULT
	BeginScene as function(byval This as IDirect3DDevice2 ptr) as HRESULT
	EndScene as function(byval This as IDirect3DDevice2 ptr) as HRESULT
	GetDirect3D as function(byval This as IDirect3DDevice2 ptr, byval d3d as IDirect3D2 ptr ptr) as HRESULT
	SetCurrentViewport as function(byval This as IDirect3DDevice2 ptr, byval viewport as IDirect3DViewport2 ptr) as HRESULT
	GetCurrentViewport as function(byval This as IDirect3DDevice2 ptr, byval viewport as IDirect3DViewport2 ptr ptr) as HRESULT
	SetRenderTarget as function(byval This as IDirect3DDevice2 ptr, byval surface as IDirectDrawSurface ptr, byval flags as DWORD) as HRESULT
	GetRenderTarget as function(byval This as IDirect3DDevice2 ptr, byval surface as IDirectDrawSurface ptr ptr) as HRESULT
	Begin as function(byval This as IDirect3DDevice2 ptr, byval d3dpt as D3DPRIMITIVETYPE, byval dwVertexTypeDesc as D3DVERTEXTYPE, byval dwFlags as DWORD) as HRESULT
	BeginIndexed as function(byval This as IDirect3DDevice2 ptr, byval primitive_type as D3DPRIMITIVETYPE, byval vertex_type as D3DVERTEXTYPE, byval vertices as any ptr, byval vertex_count as DWORD, byval flags as DWORD) as HRESULT
	Vertex as function(byval This as IDirect3DDevice2 ptr, byval vertex as any ptr) as HRESULT
	Index as function(byval This as IDirect3DDevice2 ptr, byval wVertexIndex as WORD) as HRESULT
	as function(byval This as IDirect3DDevice2 ptr, byval dwFlags as DWORD) as HRESULT End
	GetRenderState as function(byval This as IDirect3DDevice2 ptr, byval dwRenderStateType as D3DRENDERSTATETYPE, byval lpdwRenderState as LPDWORD) as HRESULT
	SetRenderState as function(byval This as IDirect3DDevice2 ptr, byval dwRenderStateType as D3DRENDERSTATETYPE, byval dwRenderState as DWORD) as HRESULT
	GetLightState as function(byval This as IDirect3DDevice2 ptr, byval dwLightStateType as D3DLIGHTSTATETYPE, byval lpdwLightState as LPDWORD) as HRESULT
	SetLightState as function(byval This as IDirect3DDevice2 ptr, byval dwLightStateType as D3DLIGHTSTATETYPE, byval dwLightState as DWORD) as HRESULT
	SetTransform as function(byval This as IDirect3DDevice2 ptr, byval state as D3DTRANSFORMSTATETYPE, byval matrix as D3DMATRIX ptr) as HRESULT
	GetTransform as function(byval This as IDirect3DDevice2 ptr, byval state as D3DTRANSFORMSTATETYPE, byval matrix as D3DMATRIX ptr) as HRESULT
	MultiplyTransform as function(byval This as IDirect3DDevice2 ptr, byval state as D3DTRANSFORMSTATETYPE, byval matrix as D3DMATRIX ptr) as HRESULT
	DrawPrimitive as function(byval This as IDirect3DDevice2 ptr, byval primitive_type as D3DPRIMITIVETYPE, byval vertex_type as D3DVERTEXTYPE, byval vertices as any ptr, byval vertex_count as DWORD, byval flags as DWORD) as HRESULT
	DrawIndexedPrimitive as function(byval This as IDirect3DDevice2 ptr, byval primitive_type as D3DPRIMITIVETYPE, byval vertex_type as D3DVERTEXTYPE, byval vertices as any ptr, byval vertex_count as DWORD, byval indices as WORD ptr, byval index_count as DWORD, byval flags as DWORD) as HRESULT
	SetClipStatus as function(byval This as IDirect3DDevice2 ptr, byval clip_status as D3DCLIPSTATUS ptr) as HRESULT
	GetClipStatus as function(byval This as IDirect3DDevice2 ptr, byval clip_status as D3DCLIPSTATUS ptr) as HRESULT
end type

#define IDirect3DDevice2_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DDevice2_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DDevice2_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DDevice2_GetCaps(p, a, b) (p)->lpVtbl->GetCaps(p, a, b)
#define IDirect3DDevice2_SwapTextureHandles(p, a, b) (p)->lpVtbl->SwapTextureHandles(p, a, b)
#define IDirect3DDevice2_GetStats(p, a) (p)->lpVtbl->GetStats(p, a)
#define IDirect3DDevice2_AddViewport(p, a) (p)->lpVtbl->AddViewport(p, a)
#define IDirect3DDevice2_DeleteViewport(p, a) (p)->lpVtbl->DeleteViewport(p, a)
#define IDirect3DDevice2_NextViewport(p, a, b, c) (p)->lpVtbl->NextViewport(p, a, b, c)
#define IDirect3DDevice2_EnumTextureFormats(p, a, b) (p)->lpVtbl->EnumTextureFormats(p, a, b)
#define IDirect3DDevice2_BeginScene(p) (p)->lpVtbl->BeginScene(p)
#define IDirect3DDevice2_EndScene(p) (p)->lpVtbl->EndScene(p)
#define IDirect3DDevice2_GetDirect3D(p, a) (p)->lpVtbl->GetDirect3D(p, a)
#define IDirect3DDevice2_SetCurrentViewport(p, a) (p)->lpVtbl->SetCurrentViewport(p, a)
#define IDirect3DDevice2_GetCurrentViewport(p, a) (p)->lpVtbl->GetCurrentViewport(p, a)
#define IDirect3DDevice2_SetRenderTarget(p, a, b) (p)->lpVtbl->SetRenderTarget(p, a, b)
#define IDirect3DDevice2_GetRenderTarget(p, a) (p)->lpVtbl->GetRenderTarget(p, a)
#define IDirect3DDevice2_Begin(p, a, b, c) (p)->lpVtbl->Begin(p, a, b, c)
#define IDirect3DDevice2_BeginIndexed(p, a, b, c, d, e) (p)->lpVtbl->BeginIndexed(p, a, b, c, d, e)
#define IDirect3DDevice2_Vertex(p, a) (p)->lpVtbl->Vertex(p, a)
#define IDirect3DDevice2_Index(p, a) (p)->lpVtbl->Index(p, a)
#define IDirect3DDevice2_End(p, a) (p)->lpVtbl->End(p, a)
#define IDirect3DDevice2_GetRenderState(p, a, b) (p)->lpVtbl->GetRenderState(p, a, b)
#define IDirect3DDevice2_SetRenderState(p, a, b) (p)->lpVtbl->SetRenderState(p, a, b)
#define IDirect3DDevice2_GetLightState(p, a, b) (p)->lpVtbl->GetLightState(p, a, b)
#define IDirect3DDevice2_SetLightState(p, a, b) (p)->lpVtbl->SetLightState(p, a, b)
#define IDirect3DDevice2_SetTransform(p, a, b) (p)->lpVtbl->SetTransform(p, a, b)
#define IDirect3DDevice2_GetTransform(p, a, b) (p)->lpVtbl->GetTransform(p, a, b)
#define IDirect3DDevice2_MultiplyTransform(p, a, b) (p)->lpVtbl->MultiplyTransform(p, a, b)
#define IDirect3DDevice2_DrawPrimitive(p, a, b, c, d, e) (p)->lpVtbl->DrawPrimitive(p, a, b, c, d, e)
#define IDirect3DDevice2_DrawIndexedPrimitive(p, a, b, c, d, e, f, g) (p)->lpVtbl->DrawIndexedPrimitive(p, a, b, c, d, e, f, g)
#define IDirect3DDevice2_SetClipStatus(p, a) (p)->lpVtbl->SetClipStatus(p, a)
#define IDirect3DDevice2_GetClipStatus(p, a) (p)->lpVtbl->GetClipStatus(p, a)
type IDirect3DDevice3Vtbl as IDirect3DDevice3Vtbl_

type IDirect3DDevice3_
	lpVtbl as IDirect3DDevice3Vtbl ptr
end type

type IDirect3DDevice3Vtbl_
	QueryInterface as function(byval This as IDirect3DDevice3 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DDevice3 ptr) as ULONG
	Release as function(byval This as IDirect3DDevice3 ptr) as ULONG
	GetCaps as function(byval This as IDirect3DDevice3 ptr, byval hal_desc as D3DDEVICEDESC ptr, byval hel_desc as D3DDEVICEDESC ptr) as HRESULT
	GetStats as function(byval This as IDirect3DDevice3 ptr, byval stats as D3DSTATS ptr) as HRESULT
	AddViewport as function(byval This as IDirect3DDevice3 ptr, byval viewport as IDirect3DViewport3 ptr) as HRESULT
	DeleteViewport as function(byval This as IDirect3DDevice3 ptr, byval viewport as IDirect3DViewport3 ptr) as HRESULT
	NextViewport as function(byval This as IDirect3DDevice3 ptr, byval ref as IDirect3DViewport3 ptr, byval viewport as IDirect3DViewport3 ptr ptr, byval flags as DWORD) as HRESULT
	EnumTextureFormats as function(byval This as IDirect3DDevice3 ptr, byval cb as LPD3DENUMPIXELFORMATSCALLBACK, byval ctx as any ptr) as HRESULT
	BeginScene as function(byval This as IDirect3DDevice3 ptr) as HRESULT
	EndScene as function(byval This as IDirect3DDevice3 ptr) as HRESULT
	GetDirect3D as function(byval This as IDirect3DDevice3 ptr, byval d3d as IDirect3D3 ptr ptr) as HRESULT
	SetCurrentViewport as function(byval This as IDirect3DDevice3 ptr, byval viewport as IDirect3DViewport3 ptr) as HRESULT
	GetCurrentViewport as function(byval This as IDirect3DDevice3 ptr, byval viewport as IDirect3DViewport3 ptr ptr) as HRESULT
	SetRenderTarget as function(byval This as IDirect3DDevice3 ptr, byval surface as IDirectDrawSurface4 ptr, byval flags as DWORD) as HRESULT
	GetRenderTarget as function(byval This as IDirect3DDevice3 ptr, byval surface as IDirectDrawSurface4 ptr ptr) as HRESULT
	Begin as function(byval This as IDirect3DDevice3 ptr, byval d3dptPrimitiveType as D3DPRIMITIVETYPE, byval dwVertexTypeDesc as DWORD, byval dwFlags as DWORD) as HRESULT
	BeginIndexed as function(byval This as IDirect3DDevice3 ptr, byval primitive_type as D3DPRIMITIVETYPE, byval fvf as DWORD, byval vertices as any ptr, byval vertex_count as DWORD, byval flags as DWORD) as HRESULT
	Vertex as function(byval This as IDirect3DDevice3 ptr, byval vertex as any ptr) as HRESULT
	Index as function(byval This as IDirect3DDevice3 ptr, byval wVertexIndex as WORD) as HRESULT
	as function(byval This as IDirect3DDevice3 ptr, byval dwFlags as DWORD) as HRESULT End
	GetRenderState as function(byval This as IDirect3DDevice3 ptr, byval dwRenderStateType as D3DRENDERSTATETYPE, byval lpdwRenderState as LPDWORD) as HRESULT
	SetRenderState as function(byval This as IDirect3DDevice3 ptr, byval dwRenderStateType as D3DRENDERSTATETYPE, byval dwRenderState as DWORD) as HRESULT
	GetLightState as function(byval This as IDirect3DDevice3 ptr, byval dwLightStateType as D3DLIGHTSTATETYPE, byval lpdwLightState as LPDWORD) as HRESULT
	SetLightState as function(byval This as IDirect3DDevice3 ptr, byval dwLightStateType as D3DLIGHTSTATETYPE, byval dwLightState as DWORD) as HRESULT
	SetTransform as function(byval This as IDirect3DDevice3 ptr, byval state as D3DTRANSFORMSTATETYPE, byval matrix as D3DMATRIX ptr) as HRESULT
	GetTransform as function(byval This as IDirect3DDevice3 ptr, byval state as D3DTRANSFORMSTATETYPE, byval matrix as D3DMATRIX ptr) as HRESULT
	MultiplyTransform as function(byval This as IDirect3DDevice3 ptr, byval state as D3DTRANSFORMSTATETYPE, byval matrix as D3DMATRIX ptr) as HRESULT
	DrawPrimitive as function(byval This as IDirect3DDevice3 ptr, byval primitive_type as D3DPRIMITIVETYPE, byval vertex_type as DWORD, byval vertices as any ptr, byval vertex_count as DWORD, byval flags as DWORD) as HRESULT
	DrawIndexedPrimitive as function(byval This as IDirect3DDevice3 ptr, byval primitive_type as D3DPRIMITIVETYPE, byval fvf as DWORD, byval vertices as any ptr, byval vertex_count as DWORD, byval indices as WORD ptr, byval index_count as DWORD, byval flags as DWORD) as HRESULT
	SetClipStatus as function(byval This as IDirect3DDevice3 ptr, byval clip_status as D3DCLIPSTATUS ptr) as HRESULT
	GetClipStatus as function(byval This as IDirect3DDevice3 ptr, byval clip_status as D3DCLIPSTATUS ptr) as HRESULT
	DrawPrimitiveStrided as function(byval This as IDirect3DDevice3 ptr, byval primitive_type as D3DPRIMITIVETYPE, byval fvf as DWORD, byval strided_data as D3DDRAWPRIMITIVESTRIDEDDATA ptr, byval vertex_count as DWORD, byval flags as DWORD) as HRESULT
	DrawIndexedPrimitiveStrided as function(byval This as IDirect3DDevice3 ptr, byval primitive_type as D3DPRIMITIVETYPE, byval fvf as DWORD, byval strided_data as D3DDRAWPRIMITIVESTRIDEDDATA ptr, byval vertex_count as DWORD, byval indices as WORD ptr, byval index_count as DWORD, byval flags as DWORD) as HRESULT
	DrawPrimitiveVB as function(byval This as IDirect3DDevice3 ptr, byval primitive_type as D3DPRIMITIVETYPE, byval vb as IDirect3DVertexBuffer ptr, byval start_vertex as DWORD, byval vertex_count as DWORD, byval flags as DWORD) as HRESULT
	DrawIndexedPrimitiveVB as function(byval This as IDirect3DDevice3 ptr, byval primitive_type as D3DPRIMITIVETYPE, byval vb as IDirect3DVertexBuffer ptr, byval indices as WORD ptr, byval index_count as DWORD, byval flags as DWORD) as HRESULT
	ComputeSphereVisibility as function(byval This as IDirect3DDevice3 ptr, byval centers as D3DVECTOR ptr, byval radii as D3DVALUE ptr, byval sphere_count as DWORD, byval flags as DWORD, byval ret as DWORD ptr) as HRESULT
	GetTexture as function(byval This as IDirect3DDevice3 ptr, byval stage as DWORD, byval texture as IDirect3DTexture2 ptr ptr) as HRESULT
	SetTexture as function(byval This as IDirect3DDevice3 ptr, byval stage as DWORD, byval texture as IDirect3DTexture2 ptr) as HRESULT
	GetTextureStageState as function(byval This as IDirect3DDevice3 ptr, byval dwStage as DWORD, byval d3dTexStageStateType as D3DTEXTURESTAGESTATETYPE, byval lpdwState as LPDWORD) as HRESULT
	SetTextureStageState as function(byval This as IDirect3DDevice3 ptr, byval dwStage as DWORD, byval d3dTexStageStateType as D3DTEXTURESTAGESTATETYPE, byval dwState as DWORD) as HRESULT
	ValidateDevice as function(byval This as IDirect3DDevice3 ptr, byval lpdwPasses as LPDWORD) as HRESULT
end type

#define IDirect3DDevice3_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DDevice3_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DDevice3_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DDevice3_GetCaps(p, a, b) (p)->lpVtbl->GetCaps(p, a, b)
#define IDirect3DDevice3_GetStats(p, a) (p)->lpVtbl->GetStats(p, a)
#define IDirect3DDevice3_AddViewport(p, a) (p)->lpVtbl->AddViewport(p, a)
#define IDirect3DDevice3_DeleteViewport(p, a) (p)->lpVtbl->DeleteViewport(p, a)
#define IDirect3DDevice3_NextViewport(p, a, b, c) (p)->lpVtbl->NextViewport(p, a, b, c)
#define IDirect3DDevice3_EnumTextureFormats(p, a, b) (p)->lpVtbl->EnumTextureFormats(p, a, b)
#define IDirect3DDevice3_BeginScene(p) (p)->lpVtbl->BeginScene(p)
#define IDirect3DDevice3_EndScene(p) (p)->lpVtbl->EndScene(p)
#define IDirect3DDevice3_GetDirect3D(p, a) (p)->lpVtbl->GetDirect3D(p, a)
#define IDirect3DDevice3_SetCurrentViewport(p, a) (p)->lpVtbl->SetCurrentViewport(p, a)
#define IDirect3DDevice3_GetCurrentViewport(p, a) (p)->lpVtbl->GetCurrentViewport(p, a)
#define IDirect3DDevice3_SetRenderTarget(p, a, b) (p)->lpVtbl->SetRenderTarget(p, a, b)
#define IDirect3DDevice3_GetRenderTarget(p, a) (p)->lpVtbl->GetRenderTarget(p, a)
#define IDirect3DDevice3_Begin(p, a, b, c) (p)->lpVtbl->Begin(p, a, b, c)
#define IDirect3DDevice3_BeginIndexed(p, a, b, c, d, e) (p)->lpVtbl->BeginIndexed(p, a, b, c, d, e)
#define IDirect3DDevice3_Vertex(p, a) (p)->lpVtbl->Vertex(p, a)
#define IDirect3DDevice3_Index(p, a) (p)->lpVtbl->Index(p, a)
#define IDirect3DDevice3_End(p, a) (p)->lpVtbl->End(p, a)
#define IDirect3DDevice3_GetRenderState(p, a, b) (p)->lpVtbl->GetRenderState(p, a, b)
#define IDirect3DDevice3_SetRenderState(p, a, b) (p)->lpVtbl->SetRenderState(p, a, b)
#define IDirect3DDevice3_GetLightState(p, a, b) (p)->lpVtbl->GetLightState(p, a, b)
#define IDirect3DDevice3_SetLightState(p, a, b) (p)->lpVtbl->SetLightState(p, a, b)
#define IDirect3DDevice3_SetTransform(p, a, b) (p)->lpVtbl->SetTransform(p, a, b)
#define IDirect3DDevice3_GetTransform(p, a, b) (p)->lpVtbl->GetTransform(p, a, b)
#define IDirect3DDevice3_MultiplyTransform(p, a, b) (p)->lpVtbl->MultiplyTransform(p, a, b)
#define IDirect3DDevice3_DrawPrimitive(p, a, b, c, d, e) (p)->lpVtbl->DrawPrimitive(p, a, b, c, d, e)
#define IDirect3DDevice3_DrawIndexedPrimitive(p, a, b, c, d, e, f, g) (p)->lpVtbl->DrawIndexedPrimitive(p, a, b, c, d, e, f, g)
#define IDirect3DDevice3_SetClipStatus(p, a) (p)->lpVtbl->SetClipStatus(p, a)
#define IDirect3DDevice3_GetClipStatus(p, a) (p)->lpVtbl->GetClipStatus(p, a)
#define IDirect3DDevice3_DrawPrimitiveStrided(p, a, b, c, d, e) (p)->lpVtbl->DrawPrimitiveStrided(p, a, b, c, d, e)
#define IDirect3DDevice3_DrawIndexedPrimitiveStrided(p, a, b, c, d, e, f, g) (p)->lpVtbl->DrawIndexedPrimitiveStrided(p, a, b, c, d, e, f, g)
#define IDirect3DDevice3_DrawPrimitiveVB(p, a, b, c, d, e) (p)->lpVtbl->DrawPrimitiveVB(p, a, b, c, d, e)
#define IDirect3DDevice3_DrawIndexedPrimitiveVB(p, a, b, c, d, e) (p)->lpVtbl->DrawIndexedPrimitiveVB(p, a, b, c, d, e)
#define IDirect3DDevice3_ComputeSphereVisibility(p, a, b, c, d, e) (p)->lpVtbl->ComputeSphereVisibility(p, a, b, c, d, e)
#define IDirect3DDevice3_GetTexture(p, a, b) (p)->lpVtbl->GetTexture(p, a, b)
#define IDirect3DDevice3_SetTexture(p, a, b) (p)->lpVtbl->SetTexture(p, a, b)
#define IDirect3DDevice3_GetTextureStageState(p, a, b, c) (p)->lpVtbl->GetTextureStageState(p, a, b, c)
#define IDirect3DDevice3_SetTextureStageState(p, a, b, c) (p)->lpVtbl->SetTextureStageState(p, a, b, c)
#define IDirect3DDevice3_ValidateDevice(p, a) (p)->lpVtbl->ValidateDevice(p, a)
type IDirect3DDevice7Vtbl as IDirect3DDevice7Vtbl_

type IDirect3DDevice7_
	lpVtbl as IDirect3DDevice7Vtbl ptr
end type

type IDirect3DDevice7Vtbl_
	QueryInterface as function(byval This as IDirect3DDevice7 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DDevice7 ptr) as ULONG
	Release as function(byval This as IDirect3DDevice7 ptr) as ULONG
	GetCaps as function(byval This as IDirect3DDevice7 ptr, byval desc as D3DDEVICEDESC7 ptr) as HRESULT
	EnumTextureFormats as function(byval This as IDirect3DDevice7 ptr, byval cb as LPD3DENUMPIXELFORMATSCALLBACK, byval ctx as any ptr) as HRESULT
	BeginScene as function(byval This as IDirect3DDevice7 ptr) as HRESULT
	EndScene as function(byval This as IDirect3DDevice7 ptr) as HRESULT
	GetDirect3D as function(byval This as IDirect3DDevice7 ptr, byval d3d as IDirect3D7 ptr ptr) as HRESULT
	SetRenderTarget as function(byval This as IDirect3DDevice7 ptr, byval surface as IDirectDrawSurface7 ptr, byval flags as DWORD) as HRESULT
	GetRenderTarget as function(byval This as IDirect3DDevice7 ptr, byval surface as IDirectDrawSurface7 ptr ptr) as HRESULT
	Clear as function(byval This as IDirect3DDevice7 ptr, byval count as DWORD, byval rects as D3DRECT ptr, byval flags as DWORD, byval color as D3DCOLOR, byval z as D3DVALUE, byval stencil as DWORD) as HRESULT
	SetTransform as function(byval This as IDirect3DDevice7 ptr, byval state as D3DTRANSFORMSTATETYPE, byval matrix as D3DMATRIX ptr) as HRESULT
	GetTransform as function(byval This as IDirect3DDevice7 ptr, byval state as D3DTRANSFORMSTATETYPE, byval matrix as D3DMATRIX ptr) as HRESULT
	SetViewport as function(byval This as IDirect3DDevice7 ptr, byval data as D3DVIEWPORT7 ptr) as HRESULT
	MultiplyTransform as function(byval This as IDirect3DDevice7 ptr, byval state as D3DTRANSFORMSTATETYPE, byval matrix as D3DMATRIX ptr) as HRESULT
	GetViewport as function(byval This as IDirect3DDevice7 ptr, byval data as D3DVIEWPORT7 ptr) as HRESULT
	SetMaterial as function(byval This as IDirect3DDevice7 ptr, byval data as D3DMATERIAL7 ptr) as HRESULT
	GetMaterial as function(byval This as IDirect3DDevice7 ptr, byval data as D3DMATERIAL7 ptr) as HRESULT
	SetLight as function(byval This as IDirect3DDevice7 ptr, byval idx as DWORD, byval data as D3DLIGHT7 ptr) as HRESULT
	GetLight as function(byval This as IDirect3DDevice7 ptr, byval idx as DWORD, byval data as D3DLIGHT7 ptr) as HRESULT
	SetRenderState as function(byval This as IDirect3DDevice7 ptr, byval dwRenderStateType as D3DRENDERSTATETYPE, byval dwRenderState as DWORD) as HRESULT
	GetRenderState as function(byval This as IDirect3DDevice7 ptr, byval dwRenderStateType as D3DRENDERSTATETYPE, byval lpdwRenderState as LPDWORD) as HRESULT
	BeginStateBlock as function(byval This as IDirect3DDevice7 ptr) as HRESULT
	EndStateBlock as function(byval This as IDirect3DDevice7 ptr, byval lpdwBlockHandle as LPDWORD) as HRESULT
	PreLoad as function(byval This as IDirect3DDevice7 ptr, byval surface as IDirectDrawSurface7 ptr) as HRESULT
	DrawPrimitive as function(byval This as IDirect3DDevice7 ptr, byval primitive_type as D3DPRIMITIVETYPE, byval fvf as DWORD, byval vertices as any ptr, byval vertex_count as DWORD, byval flags as DWORD) as HRESULT
	DrawIndexedPrimitive as function(byval This as IDirect3DDevice7 ptr, byval primitive_type as D3DPRIMITIVETYPE, byval fvf as DWORD, byval vertices as any ptr, byval vertex_count as DWORD, byval indices as WORD ptr, byval index_count as DWORD, byval flags as DWORD) as HRESULT
	SetClipStatus as function(byval This as IDirect3DDevice7 ptr, byval clip_status as D3DCLIPSTATUS ptr) as HRESULT
	GetClipStatus as function(byval This as IDirect3DDevice7 ptr, byval clip_status as D3DCLIPSTATUS ptr) as HRESULT
	DrawPrimitiveStrided as function(byval This as IDirect3DDevice7 ptr, byval primitive_type as D3DPRIMITIVETYPE, byval fvf as DWORD, byval strided_data as D3DDRAWPRIMITIVESTRIDEDDATA ptr, byval vertex_count as DWORD, byval flags as DWORD) as HRESULT
	DrawIndexedPrimitiveStrided as function(byval This as IDirect3DDevice7 ptr, byval primitive_type as D3DPRIMITIVETYPE, byval fvf as DWORD, byval strided_data as D3DDRAWPRIMITIVESTRIDEDDATA ptr, byval vertex_count as DWORD, byval indices as WORD ptr, byval index_count as DWORD, byval flags as DWORD) as HRESULT
	DrawPrimitiveVB as function(byval This as IDirect3DDevice7 ptr, byval primitive_type as D3DPRIMITIVETYPE, byval vb as IDirect3DVertexBuffer7 ptr, byval start_vertex as DWORD, byval vertex_count as DWORD, byval flags as DWORD) as HRESULT
	DrawIndexedPrimitiveVB as function(byval This as IDirect3DDevice7 ptr, byval primitive_type as D3DPRIMITIVETYPE, byval vb as IDirect3DVertexBuffer7 ptr, byval start_vertex as DWORD, byval vertex_count as DWORD, byval indices as WORD ptr, byval index_count as DWORD, byval flags as DWORD) as HRESULT
	ComputeSphereVisibility as function(byval This as IDirect3DDevice7 ptr, byval centers as D3DVECTOR ptr, byval radii as D3DVALUE ptr, byval sphere_count as DWORD, byval flags as DWORD, byval ret as DWORD ptr) as HRESULT
	GetTexture as function(byval This as IDirect3DDevice7 ptr, byval stage as DWORD, byval surface as IDirectDrawSurface7 ptr ptr) as HRESULT
	SetTexture as function(byval This as IDirect3DDevice7 ptr, byval stage as DWORD, byval surface as IDirectDrawSurface7 ptr) as HRESULT
	GetTextureStageState as function(byval This as IDirect3DDevice7 ptr, byval dwStage as DWORD, byval d3dTexStageStateType as D3DTEXTURESTAGESTATETYPE, byval lpdwState as LPDWORD) as HRESULT
	SetTextureStageState as function(byval This as IDirect3DDevice7 ptr, byval dwStage as DWORD, byval d3dTexStageStateType as D3DTEXTURESTAGESTATETYPE, byval dwState as DWORD) as HRESULT
	ValidateDevice as function(byval This as IDirect3DDevice7 ptr, byval lpdwPasses as LPDWORD) as HRESULT
	ApplyStateBlock as function(byval This as IDirect3DDevice7 ptr, byval dwBlockHandle as DWORD) as HRESULT
	CaptureStateBlock as function(byval This as IDirect3DDevice7 ptr, byval dwBlockHandle as DWORD) as HRESULT
	DeleteStateBlock as function(byval This as IDirect3DDevice7 ptr, byval dwBlockHandle as DWORD) as HRESULT
	CreateStateBlock as function(byval This as IDirect3DDevice7 ptr, byval d3dsbType as D3DSTATEBLOCKTYPE, byval lpdwBlockHandle as LPDWORD) as HRESULT
	Load as function(byval This as IDirect3DDevice7 ptr, byval dst_surface as IDirectDrawSurface7 ptr, byval dst_point as POINT ptr, byval src_surface as IDirectDrawSurface7 ptr, byval src_rect as RECT ptr, byval flags as DWORD) as HRESULT
	LightEnable as function(byval This as IDirect3DDevice7 ptr, byval dwLightIndex as DWORD, byval bEnable as WINBOOL) as HRESULT
	GetLightEnable as function(byval This as IDirect3DDevice7 ptr, byval dwLightIndex as DWORD, byval pbEnable as WINBOOL ptr) as HRESULT
	SetClipPlane as function(byval This as IDirect3DDevice7 ptr, byval dwIndex as DWORD, byval pPlaneEquation as D3DVALUE ptr) as HRESULT
	GetClipPlane as function(byval This as IDirect3DDevice7 ptr, byval dwIndex as DWORD, byval pPlaneEquation as D3DVALUE ptr) as HRESULT
	GetInfo as function(byval This as IDirect3DDevice7 ptr, byval info_id as DWORD, byval info as any ptr, byval info_size as DWORD) as HRESULT
end type

#define IDirect3DDevice7_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DDevice7_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DDevice7_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DDevice7_GetCaps(p, a) (p)->lpVtbl->GetCaps(p, a)
#define IDirect3DDevice7_EnumTextureFormats(p, a, b) (p)->lpVtbl->EnumTextureFormats(p, a, b)
#define IDirect3DDevice7_BeginScene(p) (p)->lpVtbl->BeginScene(p)
#define IDirect3DDevice7_EndScene(p) (p)->lpVtbl->EndScene(p)
#define IDirect3DDevice7_GetDirect3D(p, a) (p)->lpVtbl->GetDirect3D(p, a)
#define IDirect3DDevice7_SetRenderTarget(p, a, b) (p)->lpVtbl->SetRenderTarget(p, a, b)
#define IDirect3DDevice7_GetRenderTarget(p, a) (p)->lpVtbl->GetRenderTarget(p, a)
#define IDirect3DDevice7_Clear(p, a, b, c, d, e, f) (p)->lpVtbl->Clear(p, a, b, c, d, e, f)
#define IDirect3DDevice7_SetTransform(p, a, b) (p)->lpVtbl->SetTransform(p, a, b)
#define IDirect3DDevice7_GetTransform(p, a, b) (p)->lpVtbl->GetTransform(p, a, b)
#define IDirect3DDevice7_SetViewport(p, a) (p)->lpVtbl->SetViewport(p, a)
#define IDirect3DDevice7_MultiplyTransform(p, a, b) (p)->lpVtbl->MultiplyTransform(p, a, b)
#define IDirect3DDevice7_GetViewport(p, a) (p)->lpVtbl->GetViewport(p, a)
#define IDirect3DDevice7_SetMaterial(p, a) (p)->lpVtbl->SetMaterial(p, a)
#define IDirect3DDevice7_GetMaterial(p, a) (p)->lpVtbl->GetMaterial(p, a)
#define IDirect3DDevice7_SetLight(p, a, b) (p)->lpVtbl->SetLight(p, a, b)
#define IDirect3DDevice7_GetLight(p, a, b) (p)->lpVtbl->GetLight(p, a, b)
#define IDirect3DDevice7_SetRenderState(p, a, b) (p)->lpVtbl->SetRenderState(p, a, b)
#define IDirect3DDevice7_GetRenderState(p, a, b) (p)->lpVtbl->GetRenderState(p, a, b)
#define IDirect3DDevice7_BeginStateBlock(p) (p)->lpVtbl->BeginStateBlock(p)
#define IDirect3DDevice7_EndStateBlock(p, a) (p)->lpVtbl->EndStateBlock(p, a)
#define IDirect3DDevice7_PreLoad(p, a) (p)->lpVtbl->PreLoad(p, a)
#define IDirect3DDevice7_DrawPrimitive(p, a, b, c, d, e) (p)->lpVtbl->DrawPrimitive(p, a, b, c, d, e)
#define IDirect3DDevice7_DrawIndexedPrimitive(p, a, b, c, d, e, f, g) (p)->lpVtbl->DrawIndexedPrimitive(p, a, b, c, d, e, f, g)
#define IDirect3DDevice7_SetClipStatus(p, a) (p)->lpVtbl->SetClipStatus(p, a)
#define IDirect3DDevice7_GetClipStatus(p, a) (p)->lpVtbl->GetClipStatus(p, a)
#define IDirect3DDevice7_DrawPrimitiveStrided(p, a, b, c, d, e) (p)->lpVtbl->DrawPrimitiveStrided(p, a, b, c, d, e)
#define IDirect3DDevice7_DrawIndexedPrimitiveStrided(p, a, b, c, d, e, f, g) (p)->lpVtbl->DrawIndexedPrimitiveStrided(p, a, b, c, d, e, f, g)
#define IDirect3DDevice7_DrawPrimitiveVB(p, a, b, c, d, e) (p)->lpVtbl->DrawPrimitiveVB(p, a, b, c, d, e)
#define IDirect3DDevice7_DrawIndexedPrimitiveVB(p, a, b, c, d, e, f, g) (p)->lpVtbl->DrawIndexedPrimitiveVB(p, a, b, c, d, e, f, g)
#define IDirect3DDevice7_ComputeSphereVisibility(p, a, b, c, d, e) (p)->lpVtbl->ComputeSphereVisibility(p, a, b, c, d, e)
#define IDirect3DDevice7_GetTexture(p, a, b) (p)->lpVtbl->GetTexture(p, a, b)
#define IDirect3DDevice7_SetTexture(p, a, b) (p)->lpVtbl->SetTexture(p, a, b)
#define IDirect3DDevice7_GetTextureStageState(p, a, b, c) (p)->lpVtbl->GetTextureStageState(p, a, b, c)
#define IDirect3DDevice7_SetTextureStageState(p, a, b, c) (p)->lpVtbl->SetTextureStageState(p, a, b, c)
#define IDirect3DDevice7_ValidateDevice(p, a) (p)->lpVtbl->ValidateDevice(p, a)
#define IDirect3DDevice7_ApplyStateBlock(p, a) (p)->lpVtbl->ApplyStateBlock(p, a)
#define IDirect3DDevice7_CaptureStateBlock(p, a) (p)->lpVtbl->CaptureStateBlock(p, a)
#define IDirect3DDevice7_DeleteStateBlock(p, a) (p)->lpVtbl->DeleteStateBlock(p, a)
#define IDirect3DDevice7_CreateStateBlock(p, a, b) (p)->lpVtbl->CreateStateBlock(p, a, b)
#define IDirect3DDevice7_Load(p, a, b, c, d, e) (p)->lpVtbl->Load(p, a, b, c, d, e)
#define IDirect3DDevice7_LightEnable(p, a, b) (p)->lpVtbl->LightEnable(p, a, b)
#define IDirect3DDevice7_GetLightEnable(p, a, b) (p)->lpVtbl->GetLightEnable(p, a, b)
#define IDirect3DDevice7_SetClipPlane(p, a, b) (p)->lpVtbl->SetClipPlane(p, a, b)
#define IDirect3DDevice7_GetClipPlane(p, a, b) (p)->lpVtbl->GetClipPlane(p, a, b)
#define IDirect3DDevice7_GetInfo(p, a, b, c) (p)->lpVtbl->GetInfo(p, a, b, c)
type IDirect3DVertexBufferVtbl as IDirect3DVertexBufferVtbl_

type IDirect3DVertexBuffer_
	lpVtbl as IDirect3DVertexBufferVtbl ptr
end type

type IDirect3DVertexBufferVtbl_
	QueryInterface as function(byval This as IDirect3DVertexBuffer ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DVertexBuffer ptr) as ULONG
	Release as function(byval This as IDirect3DVertexBuffer ptr) as ULONG
	Lock as function(byval This as IDirect3DVertexBuffer ptr, byval flags as DWORD, byval data as any ptr ptr, byval data_size as DWORD ptr) as HRESULT
	Unlock as function(byval This as IDirect3DVertexBuffer ptr) as HRESULT
	ProcessVertices as function(byval This as IDirect3DVertexBuffer ptr, byval vertex_op as DWORD, byval dst_idx as DWORD, byval count as DWORD, byval src_buffer as IDirect3DVertexBuffer ptr, byval src_idx as DWORD, byval device as IDirect3DDevice3 ptr, byval flags as DWORD) as HRESULT
	GetVertexBufferDesc as function(byval This as IDirect3DVertexBuffer ptr, byval desc as D3DVERTEXBUFFERDESC ptr) as HRESULT
	Optimize as function(byval This as IDirect3DVertexBuffer ptr, byval device as IDirect3DDevice3 ptr, byval flags as DWORD) as HRESULT
end type

#define IDirect3DVertexBuffer_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DVertexBuffer_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DVertexBuffer_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DVertexBuffer_Lock(p, a, b, c) (p)->lpVtbl->Lock(p, a, b, c)
#define IDirect3DVertexBuffer_Unlock(p) (p)->lpVtbl->Unlock(p)
#define IDirect3DVertexBuffer_ProcessVertices(p, a, b, c, d, e, f, g) (p)->lpVtbl->ProcessVertices(p, a, b, c, d, e, f, g)
#define IDirect3DVertexBuffer_GetVertexBufferDesc(p, a) (p)->lpVtbl->GetVertexBufferDesc(p, a)
#define IDirect3DVertexBuffer_Optimize(p, a, b) (p)->lpVtbl->Optimize(p, a, b)
type IDirect3DVertexBuffer7Vtbl as IDirect3DVertexBuffer7Vtbl_

type IDirect3DVertexBuffer7_
	lpVtbl as IDirect3DVertexBuffer7Vtbl ptr
end type

type IDirect3DVertexBuffer7Vtbl_
	QueryInterface as function(byval This as IDirect3DVertexBuffer7 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DVertexBuffer7 ptr) as ULONG
	Release as function(byval This as IDirect3DVertexBuffer7 ptr) as ULONG
	Lock as function(byval This as IDirect3DVertexBuffer7 ptr, byval flags as DWORD, byval data as any ptr ptr, byval data_size as DWORD ptr) as HRESULT
	Unlock as function(byval This as IDirect3DVertexBuffer7 ptr) as HRESULT
	ProcessVertices as function(byval This as IDirect3DVertexBuffer7 ptr, byval vertex_op as DWORD, byval dst_idx as DWORD, byval count as DWORD, byval src_buffer as IDirect3DVertexBuffer7 ptr, byval src_idx as DWORD, byval device as IDirect3DDevice7 ptr, byval flags as DWORD) as HRESULT
	GetVertexBufferDesc as function(byval This as IDirect3DVertexBuffer7 ptr, byval desc as D3DVERTEXBUFFERDESC ptr) as HRESULT
	Optimize as function(byval This as IDirect3DVertexBuffer7 ptr, byval device as IDirect3DDevice7 ptr, byval flags as DWORD) as HRESULT
	ProcessVerticesStrided as function(byval This as IDirect3DVertexBuffer7 ptr, byval vertex_op as DWORD, byval dst_idx as DWORD, byval count as DWORD, byval data as D3DDRAWPRIMITIVESTRIDEDDATA ptr, byval fvf as DWORD, byval device as IDirect3DDevice7 ptr, byval flags as DWORD) as HRESULT
end type

#define IDirect3DVertexBuffer7_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DVertexBuffer7_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DVertexBuffer7_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DVertexBuffer7_Lock(p, a, b, c) (p)->lpVtbl->Lock(p, a, b, c)
#define IDirect3DVertexBuffer7_Unlock(p) (p)->lpVtbl->Unlock(p)
#define IDirect3DVertexBuffer7_ProcessVertices(p, a, b, c, d, e, f, g) (p)->lpVtbl->ProcessVertices(p, a, b, c, d, e, f, g)
#define IDirect3DVertexBuffer7_GetVertexBufferDesc(p, a) (p)->lpVtbl->GetVertexBufferDesc(p, a)
#define IDirect3DVertexBuffer7_Optimize(p, a, b) (p)->lpVtbl->Optimize(p, a, b)
#define IDirect3DVertexBuffer7_ProcessVerticesStrided(p, a, b, c, d, e, f, g) (p)->lpVtbl->ProcessVerticesStrided(p, a, b, c, d, e, f, g)

end extern
