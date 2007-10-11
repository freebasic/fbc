''
''
'' d3d -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_d3d_bi__
#define __win_d3d_bi__

#inclib "dxguid"

#define COM_NO_WINDOWS_H 1
#include once "win/objbase.bi"

extern IID_IDirect3D alias "IID_IDirect3D" as GUID
extern IID_IDirect3D2 alias "IID_IDirect3D2" as GUID
extern IID_IDirect3D3 alias "IID_IDirect3D3" as GUID
extern IID_IDirect3D7 alias "IID_IDirect3D7" as GUID
extern IID_IDirect3DRampDevice alias "IID_IDirect3DRampDevice" as GUID
extern IID_IDirect3DRGBDevice alias "IID_IDirect3DRGBDevice" as GUID
extern IID_IDirect3DHALDevice alias "IID_IDirect3DHALDevice" as GUID
extern IID_IDirect3DMMXDevice alias "IID_IDirect3DMMXDevice" as GUID
extern IID_IDirect3DRefDevice alias "IID_IDirect3DRefDevice" as GUID
extern IID_IDirect3DNullDevice alias "IID_IDirect3DNullDevice" as GUID
extern IID_IDirect3DTnLHalDevice alias "IID_IDirect3DTnLHalDevice" as GUID
extern IID_IDirect3DDevice alias "IID_IDirect3DDevice" as GUID
extern IID_IDirect3DDevice2 alias "IID_IDirect3DDevice2" as GUID
extern IID_IDirect3DDevice3 alias "IID_IDirect3DDevice3" as GUID
extern IID_IDirect3DDevice7 alias "IID_IDirect3DDevice7" as GUID
extern IID_IDirect3DTexture alias "IID_IDirect3DTexture" as GUID
extern IID_IDirect3DTexture2 alias "IID_IDirect3DTexture2" as GUID
extern IID_IDirect3DLight alias "IID_IDirect3DLight" as GUID
extern IID_IDirect3DMaterial alias "IID_IDirect3DMaterial" as GUID
extern IID_IDirect3DMaterial2 alias "IID_IDirect3DMaterial2" as GUID
extern IID_IDirect3DMaterial3 alias "IID_IDirect3DMaterial3" as GUID
extern IID_IDirect3DExecuteBuffer alias "IID_IDirect3DExecuteBuffer" as GUID
extern IID_IDirect3DViewport alias "IID_IDirect3DViewport" as GUID
extern IID_IDirect3DViewport2 alias "IID_IDirect3DViewport2" as GUID
extern IID_IDirect3DViewport3 alias "IID_IDirect3DViewport3" as GUID
extern IID_IDirect3DVertexBuffer alias "IID_IDirect3DVertexBuffer" as GUID
extern IID_IDirect3DVertexBuffer7 alias "IID_IDirect3DVertexBuffer7" as GUID

type LPDIRECT3D as IDirect3D ptr
type LPDIRECT3DDEVICE as IDirect3DDevice ptr
type LPDIRECT3DEXECUTEBUFFER as IDirect3DExecuteBuffer ptr
type LPDIRECT3DLIGHT as IDirect3DLight ptr
type LPDIRECT3DMATERIAL as IDirect3DMaterial ptr
type LPDIRECT3DTEXTURE as IDirect3DTexture ptr
type LPDIRECT3DVIEWPORT as IDirect3DViewport ptr
type LPDIRECT3D2 as IDirect3D2 ptr
type LPDIRECT3DDEVICE2 as IDirect3DDevice2 ptr
type LPDIRECT3DMATERIAL2 as IDirect3DMaterial2 ptr
type LPDIRECT3DTEXTURE2 as IDirect3DTexture2 ptr
type LPDIRECT3DVIEWPORT2 as IDirect3DViewport2 ptr
type LPDIRECT3D3 as IDirect3D3 ptr
type LPDIRECT3DDEVICE3 as IDirect3DDevice3 ptr
type LPDIRECT3DMATERIAL3 as IDirect3DMaterial3 ptr
type LPDIRECT3DVIEWPORT3 as IDirect3DViewport3 ptr
type LPDIRECT3DVERTEXBUFFER as IDirect3DVertexBuffer ptr
type LPDIRECT3D7 as IDirect3D7 ptr
type LPDIRECT3DDEVICE7 as IDirect3DDevice7 ptr
type LPDIRECT3DVERTEXBUFFER7 as IDirect3DVertexBuffer7 ptr

#include once "win/d3dtypes.bi"
#include once "win/d3dcaps.bi"

type IDirect3DVtbl_ as IDirect3DVtbl

type IDirect3D
	lpVtbl as IDirect3DVtbl_ ptr
end type

type IDirect3DVtbl
	QueryInterface as function(byval as IDirect3D ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3D ptr) as ULONG
	Release as function(byval as IDirect3D ptr) as ULONG
	Initialize as function(byval as IDirect3D ptr, byval as CLSID ptr) as HRESULT
	EnumDevices as function(byval as IDirect3D ptr, byval as LPD3DENUMDEVICESCALLBACK, byval as LPVOID) as HRESULT
	CreateLight as function(byval as IDirect3D ptr, byval as LPDIRECT3DLIGHT ptr, byval as IUnknown ptr) as HRESULT
	CreateMaterial as function(byval as IDirect3D ptr, byval as LPDIRECT3DMATERIAL ptr, byval as IUnknown ptr) as HRESULT
	CreateViewport as function(byval as IDirect3D ptr, byval as LPDIRECT3DVIEWPORT ptr, byval as IUnknown ptr) as HRESULT
	FindDevice as function(byval as IDirect3D ptr, byval as LPD3DFINDDEVICESEARCH, byval as LPD3DFINDDEVICERESULT) as HRESULT
end type

#define IDirect3D_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3D_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3D_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3D_Initialize(p,a) (p)->lpVtbl->Initialize(p,a)
#define IDirect3D_EnumDevices(p,a,b) (p)->lpVtbl->EnumDevices(p,a,b)
#define IDirect3D_CreateLight(p,a,b) (p)->lpVtbl->CreateLight(p,a,b)
#define IDirect3D_CreateMaterial(p,a,b) (p)->lpVtbl->CreateMaterial(p,a,b)
#define IDirect3D_CreateViewport(p,a,b) (p)->lpVtbl->CreateViewport(p,a,b)
#define IDirect3D_FindDevice(p,a,b) (p)->lpVtbl->FindDevice(p,a,b)

type IDirect3D2Vtbl_ as IDirect3D2Vtbl

type IDirect3D2
	lpVtbl as IDirect3D2Vtbl_ ptr
end type

type IDirect3D2Vtbl
	QueryInterface as function(byval as IDirect3D2 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3D2 ptr) as ULONG
	Release as function(byval as IDirect3D2 ptr) as ULONG
	EnumDevices as function(byval as IDirect3D2 ptr, byval as LPD3DENUMDEVICESCALLBACK, byval as LPVOID) as HRESULT
	CreateLight as function(byval as IDirect3D2 ptr, byval as LPDIRECT3DLIGHT ptr, byval as IUnknown ptr) as HRESULT
	CreateMaterial as function(byval as IDirect3D2 ptr, byval as LPDIRECT3DMATERIAL2 ptr, byval as IUnknown ptr) as HRESULT
	CreateViewport as function(byval as IDirect3D2 ptr, byval as LPDIRECT3DVIEWPORT2 ptr, byval as IUnknown ptr) as HRESULT
	FindDevice as function(byval as IDirect3D2 ptr, byval as LPD3DFINDDEVICESEARCH, byval as LPD3DFINDDEVICERESULT) as HRESULT
	CreateDevice as function(byval as IDirect3D2 ptr, byval as CLSID ptr, byval as LPDIRECTDRAWSURFACE, byval as LPDIRECT3DDEVICE2 ptr) as HRESULT
end type

#define IDirect3D2_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3D2_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3D2_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3D2_EnumDevices(p,a,b) (p)->lpVtbl->EnumDevices(p,a,b)
#define IDirect3D2_CreateLight(p,a,b) (p)->lpVtbl->CreateLight(p,a,b)
#define IDirect3D2_CreateMaterial(p,a,b) (p)->lpVtbl->CreateMaterial(p,a,b)
#define IDirect3D2_CreateViewport(p,a,b) (p)->lpVtbl->CreateViewport(p,a,b)
#define IDirect3D2_FindDevice(p,a,b) (p)->lpVtbl->FindDevice(p,a,b)
#define IDirect3D2_CreateDevice(p,a,b,c) (p)->lpVtbl->CreateDevice(p,a,b,c)

type IDirect3D3Vtbl_ as IDirect3D3Vtbl

type IDirect3D3
	lpVtbl as IDirect3D3Vtbl_ ptr
end type

type IDirect3D3Vtbl
	QueryInterface as function(byval as IDirect3D3 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3D3 ptr) as ULONG
	Release as function(byval as IDirect3D3 ptr) as ULONG
	EnumDevices as function(byval as IDirect3D3 ptr, byval as LPD3DENUMDEVICESCALLBACK, byval as LPVOID) as HRESULT
	CreateLight as function(byval as IDirect3D3 ptr, byval as LPDIRECT3DLIGHT ptr, byval as LPUNKNOWN) as HRESULT
	CreateMaterial as function(byval as IDirect3D3 ptr, byval as LPDIRECT3DMATERIAL3 ptr, byval as LPUNKNOWN) as HRESULT
	CreateViewport as function(byval as IDirect3D3 ptr, byval as LPDIRECT3DVIEWPORT3 ptr, byval as LPUNKNOWN) as HRESULT
	FindDevice as function(byval as IDirect3D3 ptr, byval as LPD3DFINDDEVICESEARCH, byval as LPD3DFINDDEVICERESULT) as HRESULT
	CreateDevice as function(byval as IDirect3D3 ptr, byval as CLSID ptr, byval as LPDIRECTDRAWSURFACE4, byval as LPDIRECT3DDEVICE3 ptr, byval as LPUNKNOWN) as HRESULT
	CreateVertexBuffer as function(byval as IDirect3D3 ptr, byval as LPD3DVERTEXBUFFERDESC, byval as LPDIRECT3DVERTEXBUFFER ptr, byval as DWORD, byval as LPUNKNOWN) as HRESULT
	EnumZBufferFormats as function(byval as IDirect3D3 ptr, byval as CLSID ptr, byval as LPD3DENUMPIXELFORMATSCALLBACK, byval as LPVOID) as HRESULT
	EvictManagedTextures as function(byval as IDirect3D3 ptr) as HRESULT
end type

#define IDirect3D3_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3D3_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3D3_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3D3_EnumDevices(p,a,b) (p)->lpVtbl->EnumDevices(p,a,b)
#define IDirect3D3_CreateLight(p,a,b) (p)->lpVtbl->CreateLight(p,a,b)
#define IDirect3D3_CreateMaterial(p,a,b) (p)->lpVtbl->CreateMaterial(p,a,b)
#define IDirect3D3_CreateViewport(p,a,b) (p)->lpVtbl->CreateViewport(p,a,b)
#define IDirect3D3_FindDevice(p,a,b) (p)->lpVtbl->FindDevice(p,a,b)
#define IDirect3D3_CreateDevice(p,a,b,c,d) (p)->lpVtbl->CreateDevice(p,a,b,c,d)
#define IDirect3D3_CreateVertexBuffer(p,a,b,c,d) (p)->lpVtbl->CreateVertexBuffer(p,a,b,c,d)
#define IDirect3D3_EnumZBufferFormats(p,a,b,c) (p)->lpVtbl->EnumZBufferFormats(p,a,b,c)
#define IDirect3D3_EvictManagedTextures(p) (p)->lpVtbl->EvictManagedTextures(p)

type IDirect3D7Vtbl_ as IDirect3D7Vtbl

type IDirect3D7
	lpVtbl as IDirect3D7Vtbl_ ptr
end type

type IDirect3D7Vtbl
	QueryInterface as function(byval as IDirect3D7 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3D7 ptr) as ULONG
	Release as function(byval as IDirect3D7 ptr) as ULONG
	EnumDevices as function(byval as IDirect3D7 ptr, byval as LPD3DENUMDEVICESCALLBACK7, byval as LPVOID) as HRESULT
	CreateDevice as function(byval as IDirect3D7 ptr, byval as CLSID ptr, byval as LPDIRECTDRAWSURFACE7, byval as LPDIRECT3DDEVICE7 ptr) as HRESULT
	CreateVertexBuffer as function(byval as IDirect3D7 ptr, byval as LPD3DVERTEXBUFFERDESC, byval as LPDIRECT3DVERTEXBUFFER7 ptr, byval as DWORD) as HRESULT
	EnumZBufferFormats as function(byval as IDirect3D7 ptr, byval as CLSID ptr, byval as LPD3DENUMPIXELFORMATSCALLBACK, byval as LPVOID) as HRESULT
	EvictManagedTextures as function(byval as IDirect3D7 ptr) as HRESULT
end type

#define IDirect3D7_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3D7_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3D7_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3D7_EnumDevices(p,a,b) (p)->lpVtbl->EnumDevices(p,a,b)
#define IDirect3D7_CreateDevice(p,a,b,c) (p)->lpVtbl->CreateDevice(p,a,b,c)
#define IDirect3D7_CreateVertexBuffer(p,a,b,c) (p)->lpVtbl->CreateVertexBuffer(p,a,b,c)
#define IDirect3D7_EnumZBufferFormats(p,a,b,c) (p)->lpVtbl->EnumZBufferFormats(p,a,b,c)
#define IDirect3D7_EvictManagedTextures(p) (p)->lpVtbl->EvictManagedTextures(p)

type IDirect3DDeviceVtbl_ as IDirect3DDeviceVtbl

type IDirect3DDevice
	lpVtbl as IDirect3DDeviceVtbl_ ptr
end type

type IDirect3DDeviceVtbl
	QueryInterface as function(byval as IDirect3DDevice ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DDevice ptr) as ULONG
	Release as function(byval as IDirect3DDevice ptr) as ULONG
	Initialize as function(byval as IDirect3DDevice ptr, byval as LPDIRECT3D, byval as LPGUID, byval as LPD3DDEVICEDESC) as HRESULT
	GetCaps as function(byval as IDirect3DDevice ptr, byval as LPD3DDEVICEDESC, byval as LPD3DDEVICEDESC) as HRESULT
	SwapTextureHandles as function(byval as IDirect3DDevice ptr, byval as LPDIRECT3DTEXTURE, byval as LPDIRECT3DTEXTURE) as HRESULT
	CreateExecuteBuffer as function(byval as IDirect3DDevice ptr, byval as LPD3DEXECUTEBUFFERDESC, byval as LPDIRECT3DEXECUTEBUFFER ptr, byval as IUnknown ptr) as HRESULT
	GetStats as function(byval as IDirect3DDevice ptr, byval as LPD3DSTATS) as HRESULT
	Execute as function(byval as IDirect3DDevice ptr, byval as LPDIRECT3DEXECUTEBUFFER, byval as LPDIRECT3DVIEWPORT, byval as DWORD) as HRESULT
	AddViewport as function(byval as IDirect3DDevice ptr, byval as LPDIRECT3DVIEWPORT) as HRESULT
	DeleteViewport as function(byval as IDirect3DDevice ptr, byval as LPDIRECT3DVIEWPORT) as HRESULT
	NextViewport as function(byval as IDirect3DDevice ptr, byval as LPDIRECT3DVIEWPORT, byval as LPDIRECT3DVIEWPORT ptr, byval as DWORD) as HRESULT
	Pick as function(byval as IDirect3DDevice ptr, byval as LPDIRECT3DEXECUTEBUFFER, byval as LPDIRECT3DVIEWPORT, byval as DWORD, byval as LPD3DRECT) as HRESULT
	GetPickRecords as function(byval as IDirect3DDevice ptr, byval as LPDWORD, byval as LPD3DPICKRECORD) as HRESULT
	EnumTextureFormats as function(byval as IDirect3DDevice ptr, byval as LPD3DENUMTEXTUREFORMATSCALLBACK, byval as LPVOID) as HRESULT
	CreateMatrix as function(byval as IDirect3DDevice ptr, byval as LPD3DMATRIXHANDLE) as HRESULT
	SetMatrix as function(byval as IDirect3DDevice ptr, byval as D3DMATRIXHANDLE, byval as LPD3DMATRIX) as HRESULT
	GetMatrix as function(byval as IDirect3DDevice ptr, byval as D3DMATRIXHANDLE, byval as LPD3DMATRIX) as HRESULT
	DeleteMatrix as function(byval as IDirect3DDevice ptr, byval as D3DMATRIXHANDLE) as HRESULT
	BeginScene as function(byval as IDirect3DDevice ptr) as HRESULT
	EndScene as function(byval as IDirect3DDevice ptr) as HRESULT
	GetDirect3D as function(byval as IDirect3DDevice ptr, byval as LPDIRECT3D ptr) as HRESULT
end type

#define IDirect3DDevice_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3DDevice_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DDevice_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DDevice_Initialize(p,a,b,c) (p)->lpVtbl->Initialize(p,a,b,c)
#define IDirect3DDevice_GetCaps(p,a,b) (p)->lpVtbl->GetCaps(p,a,b)
#define IDirect3DDevice_SwapTextureHandles(p,a,b) (p)->lpVtbl->SwapTextureHandles(p,a,b)
#define IDirect3DDevice_CreateExecuteBuffer(p,a,b,c) (p)->lpVtbl->CreateExecuteBuffer(p,a,b,c)
#define IDirect3DDevice_GetStats(p,a) (p)->lpVtbl->GetStats(p,a)
#define IDirect3DDevice_Execute(p,a,b,c) (p)->lpVtbl->Execute(p,a,b,c)
#define IDirect3DDevice_AddViewport(p,a) (p)->lpVtbl->AddViewport(p,a)
#define IDirect3DDevice_DeleteViewport(p,a) (p)->lpVtbl->DeleteViewport(p,a)
#define IDirect3DDevice_NextViewport(p,a,b,c) (p)->lpVtbl->NextViewport(p,a,b,c)
#define IDirect3DDevice_Pick(p,a,b,c,d) (p)->lpVtbl->Pick(p,a,b,c,d)
#define IDirect3DDevice_GetPickRecords(p,a,b) (p)->lpVtbl->GetPickRecords(p,a,b)
#define IDirect3DDevice_EnumTextureFormats(p,a,b) (p)->lpVtbl->EnumTextureFormats(p,a,b)
#define IDirect3DDevice_CreateMatrix(p,a) (p)->lpVtbl->CreateMatrix(p,a)
#define IDirect3DDevice_SetMatrix(p,a,b) (p)->lpVtbl->SetMatrix(p,a,b)
#define IDirect3DDevice_GetMatrix(p,a,b) (p)->lpVtbl->GetMatrix(p,a,b)
#define IDirect3DDevice_DeleteMatrix(p,a) (p)->lpVtbl->DeleteMatrix(p,a)
#define IDirect3DDevice_BeginScene(p) (p)->lpVtbl->BeginScene(p)
#define IDirect3DDevice_EndScene(p) (p)->lpVtbl->EndScene(p)
#define IDirect3DDevice_GetDirect3D(p,a) (p)->lpVtbl->GetDirect3D(p,a)

type IDirect3DDevice2Vtbl_ as IDirect3DDevice2Vtbl

type IDirect3DDevice2
	lpVtbl as IDirect3DDevice2Vtbl_ ptr
end type

type IDirect3DDevice2Vtbl
	QueryInterface as function(byval as IDirect3DDevice2 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DDevice2 ptr) as ULONG
	Release as function(byval as IDirect3DDevice2 ptr) as ULONG
	GetCaps as function(byval as IDirect3DDevice2 ptr, byval as LPD3DDEVICEDESC, byval as LPD3DDEVICEDESC) as HRESULT
	SwapTextureHandles as function(byval as IDirect3DDevice2 ptr, byval as LPDIRECT3DTEXTURE2, byval as LPDIRECT3DTEXTURE2) as HRESULT
	GetStats as function(byval as IDirect3DDevice2 ptr, byval as LPD3DSTATS) as HRESULT
	AddViewport as function(byval as IDirect3DDevice2 ptr, byval as LPDIRECT3DVIEWPORT2) as HRESULT
	DeleteViewport as function(byval as IDirect3DDevice2 ptr, byval as LPDIRECT3DVIEWPORT2) as HRESULT
	NextViewport as function(byval as IDirect3DDevice2 ptr, byval as LPDIRECT3DVIEWPORT2, byval as LPDIRECT3DVIEWPORT2 ptr, byval as DWORD) as HRESULT
	EnumTextureFormats as function(byval as IDirect3DDevice2 ptr, byval as LPD3DENUMTEXTUREFORMATSCALLBACK, byval as LPVOID) as HRESULT
	BeginScene as function(byval as IDirect3DDevice2 ptr) as HRESULT
	EndScene as function(byval as IDirect3DDevice2 ptr) as HRESULT
	GetDirect3D as function(byval as IDirect3DDevice2 ptr, byval as LPDIRECT3D2 ptr) as HRESULT
	SetCurrentViewport as function(byval as IDirect3DDevice2 ptr, byval as LPDIRECT3DVIEWPORT2) as HRESULT
	GetCurrentViewport as function(byval as IDirect3DDevice2 ptr, byval as LPDIRECT3DVIEWPORT2 ptr) as HRESULT
	SetRenderTarget as function(byval as IDirect3DDevice2 ptr, byval as LPDIRECTDRAWSURFACE, byval as DWORD) as HRESULT
	GetRenderTarget as function(byval as IDirect3DDevice2 ptr, byval as LPDIRECTDRAWSURFACE ptr) as HRESULT
	Begin as function(byval as IDirect3DDevice2 ptr, byval as D3DPRIMITIVETYPE, byval as D3DVERTEXTYPE, byval as DWORD) as HRESULT
	BeginIndexed as function(byval as IDirect3DDevice2 ptr, byval as D3DPRIMITIVETYPE, byval as D3DVERTEXTYPE, byval as LPVOID, byval as DWORD, byval as DWORD) as HRESULT
	Vertex as function(byval as IDirect3DDevice2 ptr, byval as LPVOID) as HRESULT
	Index as function(byval as IDirect3DDevice2 ptr, byval as WORD) as HRESULT
	End as function(byval as IDirect3DDevice2 ptr, byval as DWORD) as HRESULT
	GetRenderState as function(byval as IDirect3DDevice2 ptr, byval as D3DRENDERSTATETYPE, byval as LPDWORD) as HRESULT
	SetRenderState as function(byval as IDirect3DDevice2 ptr, byval as D3DRENDERSTATETYPE, byval as DWORD) as HRESULT
	GetLightState as function(byval as IDirect3DDevice2 ptr, byval as D3DLIGHTSTATETYPE, byval as LPDWORD) as HRESULT
	SetLightState as function(byval as IDirect3DDevice2 ptr, byval as D3DLIGHTSTATETYPE, byval as DWORD) as HRESULT
	SetTransform as function(byval as IDirect3DDevice2 ptr, byval as D3DTRANSFORMSTATETYPE, byval as LPD3DMATRIX) as HRESULT
	GetTransform as function(byval as IDirect3DDevice2 ptr, byval as D3DTRANSFORMSTATETYPE, byval as LPD3DMATRIX) as HRESULT
	MultiplyTransform as function(byval as IDirect3DDevice2 ptr, byval as D3DTRANSFORMSTATETYPE, byval as LPD3DMATRIX) as HRESULT
	DrawPrimitive as function(byval as IDirect3DDevice2 ptr, byval as D3DPRIMITIVETYPE, byval as D3DVERTEXTYPE, byval as LPVOID, byval as DWORD, byval as DWORD) as HRESULT
	DrawIndexedPrimitive as function(byval as IDirect3DDevice2 ptr, byval as D3DPRIMITIVETYPE, byval as D3DVERTEXTYPE, byval as LPVOID, byval as DWORD, byval as LPWORD, byval as DWORD, byval as DWORD) as HRESULT
	SetClipStatus as function(byval as IDirect3DDevice2 ptr, byval as LPD3DCLIPSTATUS) as HRESULT
	GetClipStatus as function(byval as IDirect3DDevice2 ptr, byval as LPD3DCLIPSTATUS) as HRESULT
end type

#define IDirect3DDevice2_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3DDevice2_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DDevice2_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DDevice2_GetCaps(p,a,b) (p)->lpVtbl->GetCaps(p,a,b)
#define IDirect3DDevice2_SwapTextureHandles(p,a,b) (p)->lpVtbl->SwapTextureHandles(p,a,b)
#define IDirect3DDevice2_GetStats(p,a) (p)->lpVtbl->GetStats(p,a)
#define IDirect3DDevice2_AddViewport(p,a) (p)->lpVtbl->AddViewport(p,a)
#define IDirect3DDevice2_DeleteViewport(p,a) (p)->lpVtbl->DeleteViewport(p,a)
#define IDirect3DDevice2_NextViewport(p,a,b,c) (p)->lpVtbl->NextViewport(p,a,b,c)
#define IDirect3DDevice2_EnumTextureFormats(p,a,b) (p)->lpVtbl->EnumTextureFormats(p,a,b)
#define IDirect3DDevice2_BeginScene(p) (p)->lpVtbl->BeginScene(p)
#define IDirect3DDevice2_EndScene(p) (p)->lpVtbl->EndScene(p)
#define IDirect3DDevice2_GetDirect3D(p,a) (p)->lpVtbl->GetDirect3D(p,a)
#define IDirect3DDevice2_SetCurrentViewport(p,a) (p)->lpVtbl->SetCurrentViewport(p,a)
#define IDirect3DDevice2_GetCurrentViewport(p,a) (p)->lpVtbl->GetCurrentViewport(p,a)
#define IDirect3DDevice2_SetRenderTarget(p,a,b) (p)->lpVtbl->SetRenderTarget(p,a,b)
#define IDirect3DDevice2_GetRenderTarget(p,a) (p)->lpVtbl->GetRenderTarget(p,a)
#define IDirect3DDevice2_Begin(p,a,b,c) (p)->lpVtbl->Begin(p,a,b,c)
#define IDirect3DDevice2_BeginIndexed(p,a,b,c,d,e) (p)->lpVtbl->BeginIndexed(p,a,b,c,d,e)
#define IDirect3DDevice2_Vertex(p,a) (p)->lpVtbl->Vertex(p,a)
#define IDirect3DDevice2_Index(p,a) (p)->lpVtbl->Index(p,a)
#define IDirect3DDevice2_End(p,a) (p)->lpVtbl->End(p,a)
#define IDirect3DDevice2_GetRenderState(p,a,b) (p)->lpVtbl->GetRenderState(p,a,b)
#define IDirect3DDevice2_SetRenderState(p,a,b) (p)->lpVtbl->SetRenderState(p,a,b)
#define IDirect3DDevice2_GetLightState(p,a,b) (p)->lpVtbl->GetLightState(p,a,b)
#define IDirect3DDevice2_SetLightState(p,a,b) (p)->lpVtbl->SetLightState(p,a,b)
#define IDirect3DDevice2_SetTransform(p,a,b) (p)->lpVtbl->SetTransform(p,a,b)
#define IDirect3DDevice2_GetTransform(p,a,b) (p)->lpVtbl->GetTransform(p,a,b)
#define IDirect3DDevice2_MultiplyTransform(p,a,b) (p)->lpVtbl->MultiplyTransform(p,a,b)
#define IDirect3DDevice2_DrawPrimitive(p,a,b,c,d,e) (p)->lpVtbl->DrawPrimitive(p,a,b,c,d,e)
#define IDirect3DDevice2_DrawIndexedPrimitive(p,a,b,c,d,e,f,g) (p)->lpVtbl->DrawIndexedPrimitive(p,a,b,c,d,e,f,g)
#define IDirect3DDevice2_SetClipStatus(p,a) (p)->lpVtbl->SetClipStatus(p,a)
#define IDirect3DDevice2_GetClipStatus(p,a) (p)->lpVtbl->GetClipStatus(p,a)

type IDirect3DDevice3Vtbl_ as IDirect3DDevice3Vtbl

type IDirect3DDevice3
	lpVtbl as IDirect3DDevice3Vtbl_ ptr
end type

type IDirect3DDevice3Vtbl
	QueryInterface as function(byval as IDirect3DDevice3 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DDevice3 ptr) as ULONG
	Release as function(byval as IDirect3DDevice3 ptr) as ULONG
	GetCaps as function(byval as IDirect3DDevice3 ptr, byval as LPD3DDEVICEDESC, byval as LPD3DDEVICEDESC) as HRESULT
	GetStats as function(byval as IDirect3DDevice3 ptr, byval as LPD3DSTATS) as HRESULT
	AddViewport as function(byval as IDirect3DDevice3 ptr, byval as LPDIRECT3DVIEWPORT3) as HRESULT
	DeleteViewport as function(byval as IDirect3DDevice3 ptr, byval as LPDIRECT3DVIEWPORT3) as HRESULT
	NextViewport as function(byval as IDirect3DDevice3 ptr, byval as LPDIRECT3DVIEWPORT3, byval as LPDIRECT3DVIEWPORT3 ptr, byval as DWORD) as HRESULT
	EnumTextureFormats as function(byval as IDirect3DDevice3 ptr, byval as LPD3DENUMPIXELFORMATSCALLBACK, byval as LPVOID) as HRESULT
	BeginScene as function(byval as IDirect3DDevice3 ptr) as HRESULT
	EndScene as function(byval as IDirect3DDevice3 ptr) as HRESULT
	GetDirect3D as function(byval as IDirect3DDevice3 ptr, byval as LPDIRECT3D3 ptr) as HRESULT
	SetCurrentViewport as function(byval as IDirect3DDevice3 ptr, byval as LPDIRECT3DVIEWPORT3) as HRESULT
	GetCurrentViewport as function(byval as IDirect3DDevice3 ptr, byval as LPDIRECT3DVIEWPORT3 ptr) as HRESULT
	SetRenderTarget as function(byval as IDirect3DDevice3 ptr, byval as LPDIRECTDRAWSURFACE4, byval as DWORD) as HRESULT
	GetRenderTarget as function(byval as IDirect3DDevice3 ptr, byval as LPDIRECTDRAWSURFACE4 ptr) as HRESULT
	Begin as function(byval as IDirect3DDevice3 ptr, byval as D3DPRIMITIVETYPE, byval as DWORD, byval as DWORD) as HRESULT
	BeginIndexed as function(byval as IDirect3DDevice3 ptr, byval as D3DPRIMITIVETYPE, byval as DWORD, byval as LPVOID, byval as DWORD, byval as DWORD) as HRESULT
	Vertex as function(byval as IDirect3DDevice3 ptr, byval as LPVOID) as HRESULT
	Index as function(byval as IDirect3DDevice3 ptr, byval as WORD) as HRESULT
	End as function(byval as IDirect3DDevice3 ptr, byval as DWORD) as HRESULT
	GetRenderState as function(byval as IDirect3DDevice3 ptr, byval as D3DRENDERSTATETYPE, byval as LPDWORD) as HRESULT
	SetRenderState as function(byval as IDirect3DDevice3 ptr, byval as D3DRENDERSTATETYPE, byval as DWORD) as HRESULT
	GetLightState as function(byval as IDirect3DDevice3 ptr, byval as D3DLIGHTSTATETYPE, byval as LPDWORD) as HRESULT
	SetLightState as function(byval as IDirect3DDevice3 ptr, byval as D3DLIGHTSTATETYPE, byval as DWORD) as HRESULT
	SetTransform as function(byval as IDirect3DDevice3 ptr, byval as D3DTRANSFORMSTATETYPE, byval as LPD3DMATRIX) as HRESULT
	GetTransform as function(byval as IDirect3DDevice3 ptr, byval as D3DTRANSFORMSTATETYPE, byval as LPD3DMATRIX) as HRESULT
	MultiplyTransform as function(byval as IDirect3DDevice3 ptr, byval as D3DTRANSFORMSTATETYPE, byval as LPD3DMATRIX) as HRESULT
	DrawPrimitive as function(byval as IDirect3DDevice3 ptr, byval as D3DPRIMITIVETYPE, byval as DWORD, byval as LPVOID, byval as DWORD, byval as DWORD) as HRESULT
	DrawIndexedPrimitive as function(byval as IDirect3DDevice3 ptr, byval as D3DPRIMITIVETYPE, byval as DWORD, byval as LPVOID, byval as DWORD, byval as LPWORD, byval as DWORD, byval as DWORD) as HRESULT
	SetClipStatus as function(byval as IDirect3DDevice3 ptr, byval as LPD3DCLIPSTATUS) as HRESULT
	GetClipStatus as function(byval as IDirect3DDevice3 ptr, byval as LPD3DCLIPSTATUS) as HRESULT
	DrawPrimitiveStrided as function(byval as IDirect3DDevice3 ptr, byval as D3DPRIMITIVETYPE, byval as DWORD, byval as LPD3DDRAWPRIMITIVESTRIDEDDATA, byval as DWORD, byval as DWORD) as HRESULT
	DrawIndexedPrimitiveStrided as function(byval as IDirect3DDevice3 ptr, byval as D3DPRIMITIVETYPE, byval as DWORD, byval as LPD3DDRAWPRIMITIVESTRIDEDDATA, byval as DWORD, byval as LPWORD, byval as DWORD, byval as DWORD) as HRESULT
	DrawPrimitiveVB as function(byval as IDirect3DDevice3 ptr, byval as D3DPRIMITIVETYPE, byval as LPDIRECT3DVERTEXBUFFER, byval as DWORD, byval as DWORD, byval as DWORD) as HRESULT
	DrawIndexedPrimitiveVB as function(byval as IDirect3DDevice3 ptr, byval as D3DPRIMITIVETYPE, byval as LPDIRECT3DVERTEXBUFFER, byval as LPWORD, byval as DWORD, byval as DWORD) as HRESULT
	ComputeSphereVisibility as function(byval as IDirect3DDevice3 ptr, byval as LPD3DVECTOR, byval as LPD3DVALUE, byval as DWORD, byval as DWORD, byval as LPDWORD) as HRESULT
	GetTexture as function(byval as IDirect3DDevice3 ptr, byval as DWORD, byval as LPDIRECT3DTEXTURE2 ptr) as HRESULT
	SetTexture as function(byval as IDirect3DDevice3 ptr, byval as DWORD, byval as LPDIRECT3DTEXTURE2) as HRESULT
	GetTextureStageState as function(byval as IDirect3DDevice3 ptr, byval as DWORD, byval as D3DTEXTURESTAGESTATETYPE, byval as LPDWORD) as HRESULT
	SetTextureStageState as function(byval as IDirect3DDevice3 ptr, byval as DWORD, byval as D3DTEXTURESTAGESTATETYPE, byval as DWORD) as HRESULT
	ValidateDevice as function(byval as IDirect3DDevice3 ptr, byval as LPDWORD) as HRESULT
end type

#define IDirect3DDevice3_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3DDevice3_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DDevice3_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DDevice3_GetCaps(p,a,b) (p)->lpVtbl->GetCaps(p,a,b)
#define IDirect3DDevice3_GetStats(p,a) (p)->lpVtbl->GetStats(p,a)
#define IDirect3DDevice3_AddViewport(p,a) (p)->lpVtbl->AddViewport(p,a)
#define IDirect3DDevice3_DeleteViewport(p,a) (p)->lpVtbl->DeleteViewport(p,a)
#define IDirect3DDevice3_NextViewport(p,a,b,c) (p)->lpVtbl->NextViewport(p,a,b,c)
#define IDirect3DDevice3_EnumTextureFormats(p,a,b) (p)->lpVtbl->EnumTextureFormats(p,a,b)
#define IDirect3DDevice3_BeginScene(p) (p)->lpVtbl->BeginScene(p)
#define IDirect3DDevice3_EndScene(p) (p)->lpVtbl->EndScene(p)
#define IDirect3DDevice3_GetDirect3D(p,a) (p)->lpVtbl->GetDirect3D(p,a)
#define IDirect3DDevice3_SetCurrentViewport(p,a) (p)->lpVtbl->SetCurrentViewport(p,a)
#define IDirect3DDevice3_GetCurrentViewport(p,a) (p)->lpVtbl->GetCurrentViewport(p,a)
#define IDirect3DDevice3_SetRenderTarget(p,a,b) (p)->lpVtbl->SetRenderTarget(p,a,b)
#define IDirect3DDevice3_GetRenderTarget(p,a) (p)->lpVtbl->GetRenderTarget(p,a)
#define IDirect3DDevice3_Begin(p,a,b,c) (p)->lpVtbl->Begin(p,a,b,c)
#define IDirect3DDevice3_BeginIndexed(p,a,b,c,d,e) (p)->lpVtbl->BeginIndexed(p,a,b,c,d,e)
#define IDirect3DDevice3_Vertex(p,a) (p)->lpVtbl->Vertex(p,a)
#define IDirect3DDevice3_Index(p,a) (p)->lpVtbl->Index(p,a)
#define IDirect3DDevice3_End(p,a) (p)->lpVtbl->End(p,a)
#define IDirect3DDevice3_GetRenderState(p,a,b) (p)->lpVtbl->GetRenderState(p,a,b)
#define IDirect3DDevice3_SetRenderState(p,a,b) (p)->lpVtbl->SetRenderState(p,a,b)
#define IDirect3DDevice3_GetLightState(p,a,b) (p)->lpVtbl->GetLightState(p,a,b)
#define IDirect3DDevice3_SetLightState(p,a,b) (p)->lpVtbl->SetLightState(p,a,b)
#define IDirect3DDevice3_SetTransform(p,a,b) (p)->lpVtbl->SetTransform(p,a,b)
#define IDirect3DDevice3_GetTransform(p,a,b) (p)->lpVtbl->GetTransform(p,a,b)
#define IDirect3DDevice3_MultiplyTransform(p,a,b) (p)->lpVtbl->MultiplyTransform(p,a,b)
#define IDirect3DDevice3_DrawPrimitive(p,a,b,c,d,e) (p)->lpVtbl->DrawPrimitive(p,a,b,c,d,e)
#define IDirect3DDevice3_DrawIndexedPrimitive(p,a,b,c,d,e,f,g) (p)->lpVtbl->DrawIndexedPrimitive(p,a,b,c,d,e,f,g)
#define IDirect3DDevice3_SetClipStatus(p,a) (p)->lpVtbl->SetClipStatus(p,a)
#define IDirect3DDevice3_GetClipStatus(p,a) (p)->lpVtbl->GetClipStatus(p,a)
#define IDirect3DDevice3_DrawPrimitiveStrided(p,a,b,c,d,e) (p)->lpVtbl->DrawPrimitiveStrided(p,a,b,c,d,e)
#define IDirect3DDevice3_DrawIndexedPrimitiveStrided(p,a,b,c,d,e,f,g) (p)->lpVtbl->DrawIndexedPrimitiveStrided(p,a,b,c,d,e,f,g)
#define IDirect3DDevice3_DrawPrimitiveVB(p,a,b,c,d,e) (p)->lpVtbl->DrawPrimitiveVB(p,a,b,c,d,e)
#define IDirect3DDevice3_DrawIndexedPrimitiveVB(p,a,b,c,d,e) (p)->lpVtbl->DrawIndexedPrimitiveVB(p,a,b,c,d,e)
#define IDirect3DDevice3_ComputeSphereVisibility(p,a,b,c,d,e) (p)->lpVtbl->ComputeSphereVisibility(p,a,b,c,d,e)
#define IDirect3DDevice3_GetTexture(p,a,b) (p)->lpVtbl->GetTexture(p,a,b)
#define IDirect3DDevice3_SetTexture(p,a,b) (p)->lpVtbl->SetTexture(p,a,b)
#define IDirect3DDevice3_GetTextureStageState(p,a,b,c) (p)->lpVtbl->GetTextureStageState(p,a,b,c)
#define IDirect3DDevice3_SetTextureStageState(p,a,b,c) (p)->lpVtbl->SetTextureStageState(p,a,b,c)
#define IDirect3DDevice3_ValidateDevice(p,a) (p)->lpVtbl->ValidateDevice(p,a)

type IDirect3DDevice7Vtbl_ as IDirect3DDevice7Vtbl

type IDirect3DDevice7
	lpVtbl as IDirect3DDevice7Vtbl_ ptr
end type

type IDirect3DDevice7Vtbl
	QueryInterface as function(byval as IDirect3DDevice7 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DDevice7 ptr) as ULONG
	Release as function(byval as IDirect3DDevice7 ptr) as ULONG
	GetCaps as function(byval as IDirect3DDevice7 ptr, byval as LPD3DDEVICEDESC7) as HRESULT
	EnumTextureFormats as function(byval as IDirect3DDevice7 ptr, byval as LPD3DENUMPIXELFORMATSCALLBACK, byval as LPVOID) as HRESULT
	BeginScene as function(byval as IDirect3DDevice7 ptr) as HRESULT
	EndScene as function(byval as IDirect3DDevice7 ptr) as HRESULT
	GetDirect3D as function(byval as IDirect3DDevice7 ptr, byval as LPDIRECT3D7 ptr) as HRESULT
	SetRenderTarget as function(byval as IDirect3DDevice7 ptr, byval as LPDIRECTDRAWSURFACE7, byval as DWORD) as HRESULT
	GetRenderTarget as function(byval as IDirect3DDevice7 ptr, byval as LPDIRECTDRAWSURFACE7 ptr) as HRESULT
	Clear as function(byval as IDirect3DDevice7 ptr, byval as DWORD, byval as LPD3DRECT, byval as DWORD, byval as D3DCOLOR, byval as D3DVALUE, byval as DWORD) as HRESULT
	SetTransform as function(byval as IDirect3DDevice7 ptr, byval as D3DTRANSFORMSTATETYPE, byval as LPD3DMATRIX) as HRESULT
	GetTransform as function(byval as IDirect3DDevice7 ptr, byval as D3DTRANSFORMSTATETYPE, byval as LPD3DMATRIX) as HRESULT
	SetViewport as function(byval as IDirect3DDevice7 ptr, byval as LPD3DVIEWPORT7) as HRESULT
	MultiplyTransform as function(byval as IDirect3DDevice7 ptr, byval as D3DTRANSFORMSTATETYPE, byval as LPD3DMATRIX) as HRESULT
	GetViewport as function(byval as IDirect3DDevice7 ptr, byval as LPD3DVIEWPORT7) as HRESULT
	SetMaterial as function(byval as IDirect3DDevice7 ptr, byval as LPD3DMATERIAL7) as HRESULT
	GetMaterial as function(byval as IDirect3DDevice7 ptr, byval as LPD3DMATERIAL7) as HRESULT
	SetLight as function(byval as IDirect3DDevice7 ptr, byval as DWORD, byval as LPD3DLIGHT7) as HRESULT
	GetLight as function(byval as IDirect3DDevice7 ptr, byval as DWORD, byval as LPD3DLIGHT7) as HRESULT
	SetRenderState as function(byval as IDirect3DDevice7 ptr, byval as D3DRENDERSTATETYPE, byval as DWORD) as HRESULT
	GetRenderState as function(byval as IDirect3DDevice7 ptr, byval as D3DRENDERSTATETYPE, byval as LPDWORD) as HRESULT
	BeginStateBlock as function(byval as IDirect3DDevice7 ptr) as HRESULT
	EndStateBlock as function(byval as IDirect3DDevice7 ptr, byval as LPDWORD) as HRESULT
	PreLoad as function(byval as IDirect3DDevice7 ptr, byval as LPDIRECTDRAWSURFACE7) as HRESULT
	DrawPrimitive as function(byval as IDirect3DDevice7 ptr, byval as D3DPRIMITIVETYPE, byval as DWORD, byval as LPVOID, byval as DWORD, byval as DWORD) as HRESULT
	DrawIndexedPrimitive as function(byval as IDirect3DDevice7 ptr, byval as D3DPRIMITIVETYPE, byval as DWORD, byval as LPVOID, byval as DWORD, byval as LPWORD, byval as DWORD, byval as DWORD) as HRESULT
	SetClipStatus as function(byval as IDirect3DDevice7 ptr, byval as LPD3DCLIPSTATUS) as HRESULT
	GetClipStatus as function(byval as IDirect3DDevice7 ptr, byval as LPD3DCLIPSTATUS) as HRESULT
	DrawPrimitiveStrided as function(byval as IDirect3DDevice7 ptr, byval as D3DPRIMITIVETYPE, byval as DWORD, byval as LPD3DDRAWPRIMITIVESTRIDEDDATA, byval as DWORD, byval as DWORD) as HRESULT
	DrawIndexedPrimitiveStrided as function(byval as IDirect3DDevice7 ptr, byval as D3DPRIMITIVETYPE, byval as DWORD, byval as LPD3DDRAWPRIMITIVESTRIDEDDATA, byval as DWORD, byval as LPWORD, byval as DWORD, byval as DWORD) as HRESULT
	DrawPrimitiveVB as function(byval as IDirect3DDevice7 ptr, byval as D3DPRIMITIVETYPE, byval as LPDIRECT3DVERTEXBUFFER7, byval as DWORD, byval as DWORD, byval as DWORD) as HRESULT
	DrawIndexedPrimitiveVB as function(byval as IDirect3DDevice7 ptr, byval as D3DPRIMITIVETYPE, byval as LPDIRECT3DVERTEXBUFFER7, byval as DWORD, byval as DWORD, byval as LPWORD, byval as DWORD, byval as DWORD) as HRESULT
	ComputeSphereVisibility as function(byval as IDirect3DDevice7 ptr, byval as LPD3DVECTOR, byval as LPD3DVALUE, byval as DWORD, byval as DWORD, byval as LPDWORD) as HRESULT
	GetTexture as function(byval as IDirect3DDevice7 ptr, byval as DWORD, byval as LPDIRECTDRAWSURFACE7 ptr) as HRESULT
	SetTexture as function(byval as IDirect3DDevice7 ptr, byval as DWORD, byval as LPDIRECTDRAWSURFACE7) as HRESULT
	GetTextureStageState as function(byval as IDirect3DDevice7 ptr, byval as DWORD, byval as D3DTEXTURESTAGESTATETYPE, byval as LPDWORD) as HRESULT
	SetTextureStageState as function(byval as IDirect3DDevice7 ptr, byval as DWORD, byval as D3DTEXTURESTAGESTATETYPE, byval as DWORD) as HRESULT
	ValidateDevice as function(byval as IDirect3DDevice7 ptr, byval as LPDWORD) as HRESULT
	ApplyStateBlock as function(byval as IDirect3DDevice7 ptr, byval as DWORD) as HRESULT
	CaptureStateBlock as function(byval as IDirect3DDevice7 ptr, byval as DWORD) as HRESULT
	DeleteStateBlock as function(byval as IDirect3DDevice7 ptr, byval as DWORD) as HRESULT
	CreateStateBlock as function(byval as IDirect3DDevice7 ptr, byval as D3DSTATEBLOCKTYPE, byval as LPDWORD) as HRESULT
	Load as function(byval as IDirect3DDevice7 ptr, byval as LPDIRECTDRAWSURFACE7, byval as LPPOINT, byval as LPDIRECTDRAWSURFACE7, byval as LPRECT, byval as DWORD) as HRESULT
	LightEnable as function(byval as IDirect3DDevice7 ptr, byval as DWORD, byval as BOOL) as HRESULT
	GetLightEnable as function(byval as IDirect3DDevice7 ptr, byval as DWORD, byval as BOOL ptr) as HRESULT
	SetClipPlane as function(byval as IDirect3DDevice7 ptr, byval as DWORD, byval as D3DVALUE ptr) as HRESULT
	GetClipPlane as function(byval as IDirect3DDevice7 ptr, byval as DWORD, byval as D3DVALUE ptr) as HRESULT
	GetInfo as function(byval as IDirect3DDevice7 ptr, byval as DWORD, byval as LPVOID, byval as DWORD) as HRESULT
end type

#define IDirect3DDevice7_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3DDevice7_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DDevice7_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DDevice7_GetCaps(p,a) (p)->lpVtbl->GetCaps(p,a)
#define IDirect3DDevice7_EnumTextureFormats(p,a,b) (p)->lpVtbl->EnumTextureFormats(p,a,b)
#define IDirect3DDevice7_BeginScene(p) (p)->lpVtbl->BeginScene(p)
#define IDirect3DDevice7_EndScene(p) (p)->lpVtbl->EndScene(p)
#define IDirect3DDevice7_GetDirect3D(p,a) (p)->lpVtbl->GetDirect3D(p,a)
#define IDirect3DDevice7_SetRenderTarget(p,a,b) (p)->lpVtbl->SetRenderTarget(p,a,b)
#define IDirect3DDevice7_GetRenderTarget(p,a) (p)->lpVtbl->GetRenderTarget(p,a)
#define IDirect3DDevice7_Clear(p,a,b,c,d,e,f) (p)->lpVtbl->Clear(p,a,b,c,d,e,f)
#define IDirect3DDevice7_SetTransform(p,a,b) (p)->lpVtbl->SetTransform(p,a,b)
#define IDirect3DDevice7_GetTransform(p,a,b) (p)->lpVtbl->GetTransform(p,a,b)
#define IDirect3DDevice7_SetViewport(p,a) (p)->lpVtbl->SetViewport(p,a)
#define IDirect3DDevice7_MultiplyTransform(p,a,b) (p)->lpVtbl->MultiplyTransform(p,a,b)
#define IDirect3DDevice7_GetViewport(p,a) (p)->lpVtbl->GetViewport(p,a)
#define IDirect3DDevice7_SetMaterial(p,a) (p)->lpVtbl->SetMaterial(p,a)
#define IDirect3DDevice7_GetMaterial(p,a) (p)->lpVtbl->GetMaterial(p,a)
#define IDirect3DDevice7_SetLight(p,a,b) (p)->lpVtbl->SetLight(p,a,b)
#define IDirect3DDevice7_GetLight(p,a,b) (p)->lpVtbl->GetLight(p,a,b)
#define IDirect3DDevice7_SetRenderState(p,a,b) (p)->lpVtbl->SetRenderState(p,a,b)
#define IDirect3DDevice7_GetRenderState(p,a,b) (p)->lpVtbl->GetRenderState(p,a,b)
#define IDirect3DDevice7_BeginStateBlock(p) (p)->lpVtbl->BeginStateBlock(p)
#define IDirect3DDevice7_EndStateBlock(p,a) (p)->lpVtbl->EndStateBlock(p,a)
#define IDirect3DDevice7_PreLoad(p,a) (p)->lpVtbl->PreLoad(p,a)
#define IDirect3DDevice7_DrawPrimitive(p,a,b,c,d,e) (p)->lpVtbl->DrawPrimitive(p,a,b,c,d,e)
#define IDirect3DDevice7_DrawIndexedPrimitive(p,a,b,c,d,e,f,g) (p)->lpVtbl->DrawIndexedPrimitive(p,a,b,c,d,e,f,g)
#define IDirect3DDevice7_SetClipStatus(p,a) (p)->lpVtbl->SetClipStatus(p,a)
#define IDirect3DDevice7_GetClipStatus(p,a) (p)->lpVtbl->GetClipStatus(p,a)
#define IDirect3DDevice7_DrawPrimitiveStrided(p,a,b,c,d,e) (p)->lpVtbl->DrawPrimitiveStrided(p,a,b,c,d,e)
#define IDirect3DDevice7_DrawIndexedPrimitiveStrided(p,a,b,c,d,e,f,g) (p)->lpVtbl->DrawIndexedPrimitiveStrided(p,a,b,c,d,e,f,g)
#define IDirect3DDevice7_DrawPrimitiveVB(p,a,b,c,d,e) (p)->lpVtbl->DrawPrimitiveVB(p,a,b,c,d,e)
#define IDirect3DDevice7_DrawIndexedPrimitiveVB(p,a,b,c,d,e,f,g) (p)->lpVtbl->DrawIndexedPrimitiveVB(p,a,b,c,d,e,f,g)
#define IDirect3DDevice7_ComputeSphereVisibility(p,a,b,c,d,e) (p)->lpVtbl->ComputeSphereVisibility(p,a,b,c,d,e)
#define IDirect3DDevice7_GetTexture(p,a,b) (p)->lpVtbl->GetTexture(p,a,b)
#define IDirect3DDevice7_SetTexture(p,a,b) (p)->lpVtbl->SetTexture(p,a,b)
#define IDirect3DDevice7_GetTextureStageState(p,a,b,c) (p)->lpVtbl->GetTextureStageState(p,a,b,c)
#define IDirect3DDevice7_SetTextureStageState(p,a,b,c) (p)->lpVtbl->SetTextureStageState(p,a,b,c)
#define IDirect3DDevice7_ValidateDevice(p,a) (p)->lpVtbl->ValidateDevice(p,a)
#define IDirect3DDevice7_ApplyStateBlock(p,a) (p)->lpVtbl->ApplyStateBlock(p,a)
#define IDirect3DDevice7_CaptureStateBlock(p,a) (p)->lpVtbl->CaptureStateBlock(p,a)
#define IDirect3DDevice7_DeleteStateBlock(p,a) (p)->lpVtbl->DeleteStateBlock(p,a)
#define IDirect3DDevice7_CreateStateBlock(p,a,b) (p)->lpVtbl->CreateStateBlock(p,a,b)
#define IDirect3DDevice7_Load(p,a,b,c,d,e) (p)->lpVtbl->Load(p,a,b,c,d,e)
#define IDirect3DDevice7_LightEnable(p,a,b) (p)->lpVtbl->LightEnable(p,a,b)
#define IDirect3DDevice7_GetLightEnable(p,a,b) (p)->lpVtbl->GetLightEnable(p,a,b)
#define IDirect3DDevice7_SetClipPlane(p,a,b) (p)->lpVtbl->SetClipPlane(p,a,b)
#define IDirect3DDevice7_GetClipPlane(p,a,b) (p)->lpVtbl->GetClipPlane(p,a,b)
#define IDirect3DDevice7_GetInfo(p,a,b,c) (p)->lpVtbl->GetInfo(p,a,b,c)

type IDirect3DExecuteBufferVtbl_ as IDirect3DExecuteBufferVtbl

type IDirect3DExecuteBuffer
	lpVtbl as IDirect3DExecuteBufferVtbl_ ptr
end type

type IDirect3DExecuteBufferVtbl
	QueryInterface as function(byval as IDirect3DExecuteBuffer ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DExecuteBuffer ptr) as ULONG
	Release as function(byval as IDirect3DExecuteBuffer ptr) as ULONG
	Initialize as function(byval as IDirect3DExecuteBuffer ptr, byval as LPDIRECT3DDEVICE, byval as LPD3DEXECUTEBUFFERDESC) as HRESULT
	Lock as function(byval as IDirect3DExecuteBuffer ptr, byval as LPD3DEXECUTEBUFFERDESC) as HRESULT
	Unlock as function(byval as IDirect3DExecuteBuffer ptr) as HRESULT
	SetExecuteData as function(byval as IDirect3DExecuteBuffer ptr, byval as LPD3DEXECUTEDATA) as HRESULT
	GetExecuteData as function(byval as IDirect3DExecuteBuffer ptr, byval as LPD3DEXECUTEDATA) as HRESULT
	Validate as function(byval as IDirect3DExecuteBuffer ptr, byval as LPDWORD, byval as LPD3DVALIDATECALLBACK, byval as LPVOID, byval as DWORD) as HRESULT
	Optimize as function(byval as IDirect3DExecuteBuffer ptr, byval as DWORD) as HRESULT
end type

#define IDirect3DExecuteBuffer_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3DExecuteBuffer_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DExecuteBuffer_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DExecuteBuffer_Initialize(p,a,b) (p)->lpVtbl->Initialize(p,a,b)
#define IDirect3DExecuteBuffer_Lock(p,a) (p)->lpVtbl->Lock(p,a)
#define IDirect3DExecuteBuffer_Unlock(p) (p)->lpVtbl->Unlock(p)
#define IDirect3DExecuteBuffer_SetExecuteData(p,a) (p)->lpVtbl->SetExecuteData(p,a)
#define IDirect3DExecuteBuffer_GetExecuteData(p,a) (p)->lpVtbl->GetExecuteData(p,a)
#define IDirect3DExecuteBuffer_Validate(p,a,b,c,d) (p)->lpVtbl->Validate(p,a,b,c,d)
#define IDirect3DExecuteBuffer_Optimize(p,a) (p)->lpVtbl->Optimize(p,a)

type IDirect3DLightVtbl_ as IDirect3DLightVtbl

type IDirect3DLight
	lpVtbl as IDirect3DLightVtbl_ ptr
end type

type IDirect3DLightVtbl
	QueryInterface as function(byval as IDirect3DLight ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DLight ptr) as ULONG
	Release as function(byval as IDirect3DLight ptr) as ULONG
	Initialize as function(byval as IDirect3DLight ptr, byval as LPDIRECT3D) as HRESULT
	SetLight as function(byval as IDirect3DLight ptr, byval as LPD3DLIGHT) as HRESULT
	GetLight as function(byval as IDirect3DLight ptr, byval as LPD3DLIGHT) as HRESULT
end type

#define IDirect3DLight_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3DLight_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DLight_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DLight_Initialize(p,a) (p)->lpVtbl->Initialize(p,a)
#define IDirect3DLight_SetLight(p,a) (p)->lpVtbl->SetLight(p,a)
#define IDirect3DLight_GetLight(p,a) (p)->lpVtbl->GetLight(p,a)

type IDirect3DMaterialVtbl_ as IDirect3DMaterialVtbl

type IDirect3DMaterial
	lpVtbl as IDirect3DMaterialVtbl_ ptr
end type

type IDirect3DMaterialVtbl
	QueryInterface as function(byval as IDirect3DMaterial ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DMaterial ptr) as ULONG
	Release as function(byval as IDirect3DMaterial ptr) as ULONG
	Initialize as function(byval as IDirect3DMaterial ptr, byval as LPDIRECT3D) as HRESULT
	SetMaterial as function(byval as IDirect3DMaterial ptr, byval as LPD3DMATERIAL) as HRESULT
	GetMaterial as function(byval as IDirect3DMaterial ptr, byval as LPD3DMATERIAL) as HRESULT
	GetHandle as function(byval as IDirect3DMaterial ptr, byval as LPDIRECT3DDEVICE, byval as LPD3DMATERIALHANDLE) as HRESULT
	Reserve as function(byval as IDirect3DMaterial ptr) as HRESULT
	Unreserve as function(byval as IDirect3DMaterial ptr) as HRESULT
end type

#define IDirect3DMaterial_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3DMaterial_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DMaterial_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DMaterial_Initialize(p,a) (p)->lpVtbl->Initialize(p,a)
#define IDirect3DMaterial_SetMaterial(p,a) (p)->lpVtbl->SetMaterial(p,a)
#define IDirect3DMaterial_GetMaterial(p,a) (p)->lpVtbl->GetMaterial(p,a)
#define IDirect3DMaterial_GetHandle(p,a,b) (p)->lpVtbl->GetHandle(p,a,b)
#define IDirect3DMaterial_Reserve(p) (p)->lpVtbl->Reserve(p)
#define IDirect3DMaterial_Unreserve(p) (p)->lpVtbl->Unreserve(p)

type IDirect3DMaterial2Vtbl_ as IDirect3DMaterial2Vtbl

type IDirect3DMaterial2
	lpVtbl as IDirect3DMaterial2Vtbl_ ptr
end type

type IDirect3DMaterial2Vtbl
	QueryInterface as function(byval as IDirect3DMaterial2 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DMaterial2 ptr) as ULONG
	Release as function(byval as IDirect3DMaterial2 ptr) as ULONG
	SetMaterial as function(byval as IDirect3DMaterial2 ptr, byval as LPD3DMATERIAL) as HRESULT
	GetMaterial as function(byval as IDirect3DMaterial2 ptr, byval as LPD3DMATERIAL) as HRESULT
	GetHandle as function(byval as IDirect3DMaterial2 ptr, byval as LPDIRECT3DDEVICE2, byval as LPD3DMATERIALHANDLE) as HRESULT
end type

#define IDirect3DMaterial2_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3DMaterial2_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DMaterial2_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DMaterial2_SetMaterial(p,a) (p)->lpVtbl->SetMaterial(p,a)
#define IDirect3DMaterial2_GetMaterial(p,a) (p)->lpVtbl->GetMaterial(p,a)
#define IDirect3DMaterial2_GetHandle(p,a,b) (p)->lpVtbl->GetHandle(p,a,b)

type IDirect3DMaterial3Vtbl_ as IDirect3DMaterial3Vtbl

type IDirect3DMaterial3
	lpVtbl as IDirect3DMaterial3Vtbl_ ptr
end type

type IDirect3DMaterial3Vtbl
	QueryInterface as function(byval as IDirect3DMaterial3 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DMaterial3 ptr) as ULONG
	Release as function(byval as IDirect3DMaterial3 ptr) as ULONG
	SetMaterial as function(byval as IDirect3DMaterial3 ptr, byval as LPD3DMATERIAL) as HRESULT
	GetMaterial as function(byval as IDirect3DMaterial3 ptr, byval as LPD3DMATERIAL) as HRESULT
	GetHandle as function(byval as IDirect3DMaterial3 ptr, byval as LPDIRECT3DDEVICE3, byval as LPD3DMATERIALHANDLE) as HRESULT
end type

#define IDirect3DMaterial3_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3DMaterial3_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DMaterial3_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DMaterial3_SetMaterial(p,a) (p)->lpVtbl->SetMaterial(p,a)
#define IDirect3DMaterial3_GetMaterial(p,a) (p)->lpVtbl->GetMaterial(p,a)
#define IDirect3DMaterial3_GetHandle(p,a,b) (p)->lpVtbl->GetHandle(p,a,b)

type IDirect3DTextureVtbl_ as IDirect3DTextureVtbl

type IDirect3DTexture
	lpVtbl as IDirect3DTextureVtbl_ ptr
end type

type IDirect3DTextureVtbl
	QueryInterface as function(byval as IDirect3DTexture ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DTexture ptr) as ULONG
	Release as function(byval as IDirect3DTexture ptr) as ULONG
	Initialize as function(byval as IDirect3DTexture ptr, byval as LPDIRECT3DDEVICE, byval as LPDIRECTDRAWSURFACE) as HRESULT
	GetHandle as function(byval as IDirect3DTexture ptr, byval as LPDIRECT3DDEVICE, byval as LPD3DTEXTUREHANDLE) as HRESULT
	PaletteChanged as function(byval as IDirect3DTexture ptr, byval as DWORD, byval as DWORD) as HRESULT
	Load as function(byval as IDirect3DTexture ptr, byval as LPDIRECT3DTEXTURE) as HRESULT
	Unload as function(byval as IDirect3DTexture ptr) as HRESULT
end type

#define IDirect3DTexture_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3DTexture_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DTexture_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DTexture_Initialize(p,a,b) (p)->lpVtbl->Initialize(p,a,b)
#define IDirect3DTexture_GetHandle(p,a,b) (p)->lpVtbl->GetHandle(p,a,b)
#define IDirect3DTexture_PaletteChanged(p,a,b) (p)->lpVtbl->PaletteChanged(p,a,b)
#define IDirect3DTexture_Load(p,a) (p)->lpVtbl->Load(p,a)
#define IDirect3DTexture_Unload(p) (p)->lpVtbl->Unload(p)

type IDirect3DTexture2Vtbl_ as IDirect3DTexture2Vtbl

type IDirect3DTexture2
	lpVtbl as IDirect3DTexture2Vtbl_ ptr
end type

type IDirect3DTexture2Vtbl
	QueryInterface as function(byval as IDirect3DTexture2 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DTexture2 ptr) as ULONG
	Release as function(byval as IDirect3DTexture2 ptr) as ULONG
	GetHandle as function(byval as IDirect3DTexture2 ptr, byval as LPDIRECT3DDEVICE2, byval as LPD3DTEXTUREHANDLE) as HRESULT
	PaletteChanged as function(byval as IDirect3DTexture2 ptr, byval as DWORD, byval as DWORD) as HRESULT
	Load as function(byval as IDirect3DTexture2 ptr, byval as LPDIRECT3DTEXTURE2) as HRESULT
end type

#define IDirect3DTexture2_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3DTexture2_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DTexture2_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DTexture2_GetHandle(p,a,b) (p)->lpVtbl->GetHandle(p,a,b)
#define IDirect3DTexture2_PaletteChanged(p,a,b) (p)->lpVtbl->PaletteChanged(p,a,b)
#define IDirect3DTexture2_Load(p,a) (p)->lpVtbl->Load(p,a)

type IDirect3DViewportVtbl_ as IDirect3DViewportVtbl

type IDirect3DViewport
	lpVtbl as IDirect3DViewportVtbl_ ptr
end type

type IDirect3DViewportVtbl
	QueryInterface as function(byval as IDirect3DViewport ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DViewport ptr) as ULONG
	Release as function(byval as IDirect3DViewport ptr) as ULONG
	Initialize as function(byval as IDirect3DViewport ptr, byval as LPDIRECT3D) as HRESULT
	GetViewport as function(byval as IDirect3DViewport ptr, byval as LPD3DVIEWPORT) as HRESULT
	SetViewport as function(byval as IDirect3DViewport ptr, byval as LPD3DVIEWPORT) as HRESULT
	TransformVertices as function(byval as IDirect3DViewport ptr, byval as DWORD, byval as LPD3DTRANSFORMDATA, byval as DWORD, byval as LPDWORD) as HRESULT
	LightElements as function(byval as IDirect3DViewport ptr, byval as DWORD, byval as LPD3DLIGHTDATA) as HRESULT
	SetBackground as function(byval as IDirect3DViewport ptr, byval as D3DMATERIALHANDLE) as HRESULT
	GetBackground as function(byval as IDirect3DViewport ptr, byval as LPD3DMATERIALHANDLE, byval as LPBOOL) as HRESULT
	SetBackgroundDepth as function(byval as IDirect3DViewport ptr, byval as LPDIRECTDRAWSURFACE) as HRESULT
	GetBackgroundDepth as function(byval as IDirect3DViewport ptr, byval as LPDIRECTDRAWSURFACE ptr, byval as LPBOOL) as HRESULT
	Clear as function(byval as IDirect3DViewport ptr, byval as DWORD, byval as LPD3DRECT, byval as DWORD) as HRESULT
	AddLight as function(byval as IDirect3DViewport ptr, byval as LPDIRECT3DLIGHT) as HRESULT
	DeleteLight as function(byval as IDirect3DViewport ptr, byval as LPDIRECT3DLIGHT) as HRESULT
	NextLight as function(byval as IDirect3DViewport ptr, byval as LPDIRECT3DLIGHT, byval as LPDIRECT3DLIGHT ptr, byval as DWORD) as HRESULT
end type

#define IDirect3DViewport_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3DViewport_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DViewport_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DViewport_Initialize(p,a) (p)->lpVtbl->Initialize(p,a)
#define IDirect3DViewport_GetViewport(p,a) (p)->lpVtbl->GetViewport(p,a)
#define IDirect3DViewport_SetViewport(p,a) (p)->lpVtbl->SetViewport(p,a)
#define IDirect3DViewport_TransformVertices(p,a,b,c,d) (p)->lpVtbl->TransformVertices(p,a,b,c,d)
#define IDirect3DViewport_LightElements(p,a,b) (p)->lpVtbl->LightElements(p,a,b)
#define IDirect3DViewport_SetBackground(p,a) (p)->lpVtbl->SetBackground(p,a)
#define IDirect3DViewport_GetBackground(p,a,b) (p)->lpVtbl->GetBackground(p,a,b)
#define IDirect3DViewport_SetBackgroundDepth(p,a) (p)->lpVtbl->SetBackgroundDepth(p,a)
#define IDirect3DViewport_GetBackgroundDepth(p,a,b) (p)->lpVtbl->GetBackgroundDepth(p,a,b)
#define IDirect3DViewport_Clear(p,a,b,c) (p)->lpVtbl->Clear(p,a,b,c)
#define IDirect3DViewport_AddLight(p,a) (p)->lpVtbl->AddLight(p,a)
#define IDirect3DViewport_DeleteLight(p,a) (p)->lpVtbl->DeleteLight(p,a)
#define IDirect3DViewport_NextLight(p,a,b,c) (p)->lpVtbl->NextLight(p,a,b,c)

type IDirect3DViewport2Vtbl_ as IDirect3DViewport2Vtbl

type IDirect3DViewport2
	lpVtbl as IDirect3DViewport2Vtbl_ ptr
end type

type IDirect3DViewport2Vtbl
	QueryInterface as function(byval as IDirect3DViewport2 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DViewport2 ptr) as ULONG
	Release as function(byval as IDirect3DViewport2 ptr) as ULONG
	Initialize as function(byval as IDirect3DViewport2 ptr, byval as LPDIRECT3D) as HRESULT
	GetViewport as function(byval as IDirect3DViewport2 ptr, byval as LPD3DVIEWPORT) as HRESULT
	SetViewport as function(byval as IDirect3DViewport2 ptr, byval as LPD3DVIEWPORT) as HRESULT
	TransformVertices as function(byval as IDirect3DViewport2 ptr, byval as DWORD, byval as LPD3DTRANSFORMDATA, byval as DWORD, byval as LPDWORD) as HRESULT
	LightElements as function(byval as IDirect3DViewport2 ptr, byval as DWORD, byval as LPD3DLIGHTDATA) as HRESULT
	SetBackground as function(byval as IDirect3DViewport2 ptr, byval as D3DMATERIALHANDLE) as HRESULT
	GetBackground as function(byval as IDirect3DViewport2 ptr, byval as LPD3DMATERIALHANDLE, byval as LPBOOL) as HRESULT
	SetBackgroundDepth as function(byval as IDirect3DViewport2 ptr, byval as LPDIRECTDRAWSURFACE) as HRESULT
	GetBackgroundDepth as function(byval as IDirect3DViewport2 ptr, byval as LPDIRECTDRAWSURFACE ptr, byval as LPBOOL) as HRESULT
	Clear as function(byval as IDirect3DViewport2 ptr, byval as DWORD, byval as LPD3DRECT, byval as DWORD) as HRESULT
	AddLight as function(byval as IDirect3DViewport2 ptr, byval as LPDIRECT3DLIGHT) as HRESULT
	DeleteLight as function(byval as IDirect3DViewport2 ptr, byval as LPDIRECT3DLIGHT) as HRESULT
	NextLight as function(byval as IDirect3DViewport2 ptr, byval as LPDIRECT3DLIGHT, byval as LPDIRECT3DLIGHT ptr, byval as DWORD) as HRESULT
	GetViewport2 as function(byval as IDirect3DViewport2 ptr, byval as LPD3DVIEWPORT2) as HRESULT
	SetViewport2 as function(byval as IDirect3DViewport2 ptr, byval as LPD3DVIEWPORT2) as HRESULT
end type

#define IDirect3DViewport2_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3DViewport2_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DViewport2_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DViewport2_Initialize(p,a) (p)->lpVtbl->Initialize(p,a)
#define IDirect3DViewport2_GetViewport(p,a) (p)->lpVtbl->GetViewport(p,a)
#define IDirect3DViewport2_SetViewport(p,a) (p)->lpVtbl->SetViewport(p,a)
#define IDirect3DViewport2_TransformVertices(p,a,b,c,d) (p)->lpVtbl->TransformVertices(p,a,b,c,d)
#define IDirect3DViewport2_LightElements(p,a,b) (p)->lpVtbl->LightElements(p,a,b)
#define IDirect3DViewport2_SetBackground(p,a) (p)->lpVtbl->SetBackground(p,a)
#define IDirect3DViewport2_GetBackground(p,a,b) (p)->lpVtbl->GetBackground(p,a,b)
#define IDirect3DViewport2_SetBackgroundDepth(p,a) (p)->lpVtbl->SetBackgroundDepth(p,a)
#define IDirect3DViewport2_GetBackgroundDepth(p,a,b) (p)->lpVtbl->GetBackgroundDepth(p,a,b)
#define IDirect3DViewport2_Clear(p,a,b,c) (p)->lpVtbl->Clear(p,a,b,c)
#define IDirect3DViewport2_AddLight(p,a) (p)->lpVtbl->AddLight(p,a)
#define IDirect3DViewport2_DeleteLight(p,a) (p)->lpVtbl->DeleteLight(p,a)
#define IDirect3DViewport2_NextLight(p,a,b,c) (p)->lpVtbl->NextLight(p,a,b,c)
#define IDirect3DViewport2_GetViewport2(p,a) (p)->lpVtbl->GetViewport2(p,a)
#define IDirect3DViewport2_SetViewport2(p,a) (p)->lpVtbl->SetViewport2(p,a)

type IDirect3DViewport3Vtbl_ as IDirect3DViewport3Vtbl

type IDirect3DViewport3
	lpVtbl as IDirect3DViewport3Vtbl_ ptr
end type

type IDirect3DViewport3Vtbl
	QueryInterface as function(byval as IDirect3DViewport3 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DViewport3 ptr) as ULONG
	Release as function(byval as IDirect3DViewport3 ptr) as ULONG
	Initialize as function(byval as IDirect3DViewport3 ptr, byval as LPDIRECT3D) as HRESULT
	GetViewport as function(byval as IDirect3DViewport3 ptr, byval as LPD3DVIEWPORT) as HRESULT
	SetViewport as function(byval as IDirect3DViewport3 ptr, byval as LPD3DVIEWPORT) as HRESULT
	TransformVertices as function(byval as IDirect3DViewport3 ptr, byval as DWORD, byval as LPD3DTRANSFORMDATA, byval as DWORD, byval as LPDWORD) as HRESULT
	LightElements as function(byval as IDirect3DViewport3 ptr, byval as DWORD, byval as LPD3DLIGHTDATA) as HRESULT
	SetBackground as function(byval as IDirect3DViewport3 ptr, byval as D3DMATERIALHANDLE) as HRESULT
	GetBackground as function(byval as IDirect3DViewport3 ptr, byval as LPD3DMATERIALHANDLE, byval as LPBOOL) as HRESULT
	SetBackgroundDepth as function(byval as IDirect3DViewport3 ptr, byval as LPDIRECTDRAWSURFACE) as HRESULT
	GetBackgroundDepth as function(byval as IDirect3DViewport3 ptr, byval as LPDIRECTDRAWSURFACE ptr, byval as LPBOOL) as HRESULT
	Clear as function(byval as IDirect3DViewport3 ptr, byval as DWORD, byval as LPD3DRECT, byval as DWORD) as HRESULT
	AddLight as function(byval as IDirect3DViewport3 ptr, byval as LPDIRECT3DLIGHT) as HRESULT
	DeleteLight as function(byval as IDirect3DViewport3 ptr, byval as LPDIRECT3DLIGHT) as HRESULT
	NextLight as function(byval as IDirect3DViewport3 ptr, byval as LPDIRECT3DLIGHT, byval as LPDIRECT3DLIGHT ptr, byval as DWORD) as HRESULT
	GetViewport2 as function(byval as IDirect3DViewport3 ptr, byval as LPD3DVIEWPORT2) as HRESULT
	SetViewport2 as function(byval as IDirect3DViewport3 ptr, byval as LPD3DVIEWPORT2) as HRESULT
	SetBackgroundDepth2 as function(byval as IDirect3DViewport3 ptr, byval as LPDIRECTDRAWSURFACE4) as HRESULT
	GetBackgroundDepth2 as function(byval as IDirect3DViewport3 ptr, byval as LPDIRECTDRAWSURFACE4 ptr, byval as LPBOOL) as HRESULT
	Clear2 as function(byval as IDirect3DViewport3 ptr, byval as DWORD, byval as LPD3DRECT, byval as DWORD, byval as D3DCOLOR, byval as D3DVALUE, byval as DWORD) as HRESULT
end type

#define IDirect3DViewport3_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3DViewport3_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DViewport3_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DViewport3_Initialize(p,a) (p)->lpVtbl->Initialize(p,a)
#define IDirect3DViewport3_GetViewport(p,a) (p)->lpVtbl->GetViewport(p,a)
#define IDirect3DViewport3_SetViewport(p,a) (p)->lpVtbl->SetViewport(p,a)
#define IDirect3DViewport3_TransformVertices(p,a,b,c,d) (p)->lpVtbl->TransformVertices(p,a,b,c,d)
#define IDirect3DViewport3_LightElements(p,a,b) (p)->lpVtbl->LightElements(p,a,b)
#define IDirect3DViewport3_SetBackground(p,a) (p)->lpVtbl->SetBackground(p,a)
#define IDirect3DViewport3_GetBackground(p,a,b) (p)->lpVtbl->GetBackground(p,a,b)
#define IDirect3DViewport3_SetBackgroundDepth(p,a) (p)->lpVtbl->SetBackgroundDepth(p,a)
#define IDirect3DViewport3_GetBackgroundDepth(p,a,b) (p)->lpVtbl->GetBackgroundDepth(p,a,b)
#define IDirect3DViewport3_Clear(p,a,b,c) (p)->lpVtbl->Clear(p,a,b,c)
#define IDirect3DViewport3_AddLight(p,a) (p)->lpVtbl->AddLight(p,a)
#define IDirect3DViewport3_DeleteLight(p,a) (p)->lpVtbl->DeleteLight(p,a)
#define IDirect3DViewport3_NextLight(p,a,b,c) (p)->lpVtbl->NextLight(p,a,b,c)
#define IDirect3DViewport3_GetViewport2(p,a) (p)->lpVtbl->GetViewport2(p,a)
#define IDirect3DViewport3_SetViewport2(p,a) (p)->lpVtbl->SetViewport2(p,a)
#define IDirect3DViewport3_SetBackgroundDepth2(p,a) (p)->lpVtbl->SetBackgroundDepth2(p,a)
#define IDirect3DViewport3_GetBackgroundDepth2(p,a,b) (p)->lpVtbl->GetBackgroundDepth2(p,a,b)
#define IDirect3DViewport3_Clear2(p,a,b,c,d,e,f) (p)->lpVtbl->Clear2(p,a,b,c,d,e,f)

type IDirect3DVertexBufferVtbl_ as IDirect3DVertexBufferVtbl

type IDirect3DVertexBuffer
	lpVtbl as IDirect3DVertexBufferVtbl_ ptr
end type

type IDirect3DVertexBufferVtbl
	QueryInterface as function(byval as IDirect3DVertexBuffer ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DVertexBuffer ptr) as ULONG
	Release as function(byval as IDirect3DVertexBuffer ptr) as ULONG
	Lock as function(byval as IDirect3DVertexBuffer ptr, byval as DWORD, byval as LPVOID ptr, byval as LPDWORD) as HRESULT
	Unlock as function(byval as IDirect3DVertexBuffer ptr) as HRESULT
	ProcessVertices as function(byval as IDirect3DVertexBuffer ptr, byval as DWORD, byval as DWORD, byval as DWORD, byval as LPDIRECT3DVERTEXBUFFER, byval as DWORD, byval as LPDIRECT3DDEVICE3, byval as DWORD) as HRESULT
	GetVertexBufferDesc as function(byval as IDirect3DVertexBuffer ptr, byval as LPD3DVERTEXBUFFERDESC) as HRESULT
	Optimize as function(byval as IDirect3DVertexBuffer ptr, byval as LPDIRECT3DDEVICE3, byval as DWORD) as HRESULT
end type

#define IDirect3DVertexBuffer_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3DVertexBuffer_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DVertexBuffer_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DVertexBuffer_Lock(p,a,b,c) (p)->lpVtbl->Lock(p,a,b,c)
#define IDirect3DVertexBuffer_Unlock(p) (p)->lpVtbl->Unlock(p)
#define IDirect3DVertexBuffer_ProcessVertices(p,a,b,c,d,e,f,g) (p)->lpVtbl->ProcessVertices(p,a,b,c,d,e,f,g)
#define IDirect3DVertexBuffer_GetVertexBufferDesc(p,a) (p)->lpVtbl->GetVertexBufferDesc(p,a)
#define IDirect3DVertexBuffer_Optimize(p,a,b) (p)->lpVtbl->Optimize(p,a,b)

type IDirect3DVertexBuffer7Vtbl_ as IDirect3DVertexBuffer7Vtbl

type IDirect3DVertexBuffer7
	lpVtbl as IDirect3DVertexBuffer7Vtbl_ ptr
end type

type IDirect3DVertexBuffer7Vtbl
	QueryInterface as function(byval as IDirect3DVertexBuffer7 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DVertexBuffer7 ptr) as ULONG
	Release as function(byval as IDirect3DVertexBuffer7 ptr) as ULONG
	Lock as function(byval as IDirect3DVertexBuffer7 ptr, byval as DWORD, byval as LPVOID ptr, byval as LPDWORD) as HRESULT
	Unlock as function(byval as IDirect3DVertexBuffer7 ptr) as HRESULT
	ProcessVertices as function(byval as IDirect3DVertexBuffer7 ptr, byval as DWORD, byval as DWORD, byval as DWORD, byval as LPDIRECT3DVERTEXBUFFER7, byval as DWORD, byval as LPDIRECT3DDEVICE7, byval as DWORD) as HRESULT
	GetVertexBufferDesc as function(byval as IDirect3DVertexBuffer7 ptr, byval as LPD3DVERTEXBUFFERDESC) as HRESULT
	Optimize as function(byval as IDirect3DVertexBuffer7 ptr, byval as LPDIRECT3DDEVICE7, byval as DWORD) as HRESULT
	ProcessVerticesStrided as function(byval as IDirect3DVertexBuffer7 ptr, byval as DWORD, byval as DWORD, byval as DWORD, byval as LPD3DDRAWPRIMITIVESTRIDEDDATA, byval as DWORD, byval as LPDIRECT3DDEVICE7, byval as DWORD) as HRESULT
end type

#define IDirect3DVertexBuffer7_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirect3DVertexBuffer7_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DVertexBuffer7_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DVertexBuffer7_Lock(p,a,b,c) (p)->lpVtbl->Lock(p,a,b,c)
#define IDirect3DVertexBuffer7_Unlock(p) (p)->lpVtbl->Unlock(p)
#define IDirect3DVertexBuffer7_ProcessVertices(p,a,b,c,d,e,f,g) (p)->lpVtbl->ProcessVertices(p,a,b,c,d,e,f,g)
#define IDirect3DVertexBuffer7_GetVertexBufferDesc(p,a) (p)->lpVtbl->GetVertexBufferDesc(p,a)
#define IDirect3DVertexBuffer7_Optimize(p,a,b) (p)->lpVtbl->Optimize(p,a,b)
#define IDirect3DVertexBuffer7_ProcessVerticesStrided(p,a,b,c,d,e,f,g) (p)->lpVtbl->ProcessVerticesStrided(p,a,b,c,d,e,f,g)

#define D3DNEXT_NEXT &h00000001l
#define D3DNEXT_HEAD &h00000002l
#define D3DNEXT_TAIL &h00000004l
#define D3DDP_WAIT &h00000001l
#define D3DDP_DONOTCLIP &h00000004l
#define D3DDP_DONOTUPDATEEXTENTS &h00000008l
#define D3DDP_DONOTLIGHT &h00000010l

#define D3D_OK              DD_OK
#define D3DERR_BADMAJORVERSION      MAKE_DDHRESULT(700)
#define D3DERR_BADMINORVERSION      MAKE_DDHRESULT(701)
#define D3DERR_INVALID_DEVICE   MAKE_DDHRESULT(705)
#define D3DERR_INITFAILED       MAKE_DDHRESULT(706)
#define D3DERR_DEVICEAGGREGATED MAKE_DDHRESULT(707)
#define D3DERR_EXECUTE_CREATE_FAILED    MAKE_DDHRESULT(710)
#define D3DERR_EXECUTE_DESTROY_FAILED   MAKE_DDHRESULT(711)
#define D3DERR_EXECUTE_LOCK_FAILED  MAKE_DDHRESULT(712)
#define D3DERR_EXECUTE_UNLOCK_FAILED    MAKE_DDHRESULT(713)
#define D3DERR_EXECUTE_LOCKED       MAKE_DDHRESULT(714)
#define D3DERR_EXECUTE_NOT_LOCKED   MAKE_DDHRESULT(715)
#define D3DERR_EXECUTE_FAILED       MAKE_DDHRESULT(716)
#define D3DERR_EXECUTE_CLIPPED_FAILED   MAKE_DDHRESULT(717)
#define D3DERR_TEXTURE_NO_SUPPORT   MAKE_DDHRESULT(720)
#define D3DERR_TEXTURE_CREATE_FAILED    MAKE_DDHRESULT(721)
#define D3DERR_TEXTURE_DESTROY_FAILED   MAKE_DDHRESULT(722)
#define D3DERR_TEXTURE_LOCK_FAILED  MAKE_DDHRESULT(723)
#define D3DERR_TEXTURE_UNLOCK_FAILED    MAKE_DDHRESULT(724)
#define D3DERR_TEXTURE_LOAD_FAILED  MAKE_DDHRESULT(725)
#define D3DERR_TEXTURE_SWAP_FAILED  MAKE_DDHRESULT(726)
#define D3DERR_TEXTURE_LOCKED       MAKE_DDHRESULT(727)
#define D3DERR_TEXTURE_NOT_LOCKED   MAKE_DDHRESULT(728)
#define D3DERR_TEXTURE_GETSURF_FAILED   MAKE_DDHRESULT(729)
#define D3DERR_MATRIX_CREATE_FAILED MAKE_DDHRESULT(730)
#define D3DERR_MATRIX_DESTROY_FAILED    MAKE_DDHRESULT(731)
#define D3DERR_MATRIX_SETDATA_FAILED    MAKE_DDHRESULT(732)
#define D3DERR_MATRIX_GETDATA_FAILED    MAKE_DDHRESULT(733)
#define D3DERR_SETVIEWPORTDATA_FAILED   MAKE_DDHRESULT(734)
#define D3DERR_INVALIDCURRENTVIEWPORT   MAKE_DDHRESULT(735)
#define D3DERR_INVALIDPRIMITIVETYPE     MAKE_DDHRESULT(736)
#define D3DERR_INVALIDVERTEXTYPE        MAKE_DDHRESULT(737)
#define D3DERR_TEXTURE_BADSIZE          MAKE_DDHRESULT(738)
#define D3DERR_INVALIDRAMPTEXTURE       MAKE_DDHRESULT(739)
#define D3DERR_MATERIAL_CREATE_FAILED   MAKE_DDHRESULT(740)
#define D3DERR_MATERIAL_DESTROY_FAILED  MAKE_DDHRESULT(741)
#define D3DERR_MATERIAL_SETDATA_FAILED  MAKE_DDHRESULT(742)
#define D3DERR_MATERIAL_GETDATA_FAILED  MAKE_DDHRESULT(743)
#define D3DERR_INVALIDPALETTE           MAKE_DDHRESULT(744)
#define D3DERR_ZBUFF_NEEDS_SYSTEMMEMORY MAKE_DDHRESULT(745)
#define D3DERR_ZBUFF_NEEDS_VIDEOMEMORY  MAKE_DDHRESULT(746)
#define D3DERR_SURFACENOTINVIDMEM       MAKE_DDHRESULT(747)
#define D3DERR_LIGHT_SET_FAILED     MAKE_DDHRESULT(750)
#define D3DERR_LIGHTHASVIEWPORT     MAKE_DDHRESULT(751)
#define D3DERR_LIGHTNOTINTHISVIEWPORT           MAKE_DDHRESULT(752)
#define D3DERR_SCENE_IN_SCENE       MAKE_DDHRESULT(760)
#define D3DERR_SCENE_NOT_IN_SCENE   MAKE_DDHRESULT(761)
#define D3DERR_SCENE_BEGIN_FAILED   MAKE_DDHRESULT(762)
#define D3DERR_SCENE_END_FAILED     MAKE_DDHRESULT(763)
#define D3DERR_INBEGIN                  MAKE_DDHRESULT(770)
#define D3DERR_NOTINBEGIN               MAKE_DDHRESULT(771)
#define D3DERR_NOVIEWPORTS              MAKE_DDHRESULT(772)
#define D3DERR_VIEWPORTDATANOTSET       MAKE_DDHRESULT(773)
#define D3DERR_VIEWPORTHASNODEVICE      MAKE_DDHRESULT(774)
#define D3DERR_NOCURRENTVIEWPORT        MAKE_DDHRESULT(775)
#define D3DERR_INVALIDVERTEXFORMAT              MAKE_DDHRESULT(2048)
#define D3DERR_COLORKEYATTACHED                 MAKE_DDHRESULT(2050)
#define D3DERR_VERTEXBUFFEROPTIMIZED            MAKE_DDHRESULT(2060)
#define D3DERR_VBUF_CREATE_FAILED               MAKE_DDHRESULT(2061)
#define D3DERR_VERTEXBUFFERLOCKED               MAKE_DDHRESULT(2062)
#define D3DERR_VERTEXBUFFERUNLOCKFAILED         MAKE_DDHRESULT(2063)
#define D3DERR_ZBUFFER_NOTPRESENT               MAKE_DDHRESULT(2070)
#define D3DERR_STENCILBUFFER_NOTPRESENT         MAKE_DDHRESULT(2071)
#define D3DERR_WRONGTEXTUREFORMAT               MAKE_DDHRESULT(2072)
#define D3DERR_UNSUPPORTEDCOLOROPERATION        MAKE_DDHRESULT(2073)
#define D3DERR_UNSUPPORTEDCOLORARG              MAKE_DDHRESULT(2074)
#define D3DERR_UNSUPPORTEDALPHAOPERATION        MAKE_DDHRESULT(2075)
#define D3DERR_UNSUPPORTEDALPHAARG              MAKE_DDHRESULT(2076)
#define D3DERR_TOOMANYOPERATIONS                MAKE_DDHRESULT(2077)
#define D3DERR_CONFLICTINGTEXTUREFILTER         MAKE_DDHRESULT(2078)
#define D3DERR_UNSUPPORTEDFACTORVALUE           MAKE_DDHRESULT(2079)
#define D3DERR_CONFLICTINGRENDERSTATE           MAKE_DDHRESULT(2081)
#define D3DERR_UNSUPPORTEDTEXTUREFILTER         MAKE_DDHRESULT(2082)
#define D3DERR_TOOMANYPRIMITIVES                MAKE_DDHRESULT(2083)
#define D3DERR_INVALIDMATRIX                    MAKE_DDHRESULT(2084)
#define D3DERR_TOOMANYVERTICES                  MAKE_DDHRESULT(2085)
#define D3DERR_CONFLICTINGTEXTUREPALETTE        MAKE_DDHRESULT(2086)
#define D3DERR_INVALIDSTATEBLOCK        MAKE_DDHRESULT(2100)
#define D3DERR_INBEGINSTATEBLOCK        MAKE_DDHRESULT(2101)
#define D3DERR_NOTINBEGINSTATEBLOCK     MAKE_DDHRESULT(2102)

#endif
