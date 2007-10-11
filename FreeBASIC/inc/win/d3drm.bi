''
''
'' d3drm -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_d3drm_bi__
#define __win_d3drm_bi__

#inclib "d3drm"

#include once "win/ddraw.bi"

type LPDIRECT3DRM as IDirect3DRM ptr
type LPLPDIRECT3DRM as IDirect3DRM ptr ptr
type LPDIRECT3DRM2 as IDirect3DRM2 ptr
type LPLPDIRECT3DRM2 as IDirect3DRM2 ptr ptr
type LPDIRECT3DRM3 as IDirect3DRM3 ptr
type LPLPDIRECT3DRM3 as IDirect3DRM3 ptr ptr

#include once "win/d3drmobj.bi"

extern IID_IDirect3DRM alias "IID_IDirect3DRM" as GUID
extern IID_IDirect3DRM2 alias "IID_IDirect3DRM2" as GUID
extern IID_IDirect3DRM3 alias "IID_IDirect3DRM3" as GUID

extern CLSID_CDirect3DRM alias "CLSID_CDirect3DRM" as GUID

declare function Direct3DRMCreate alias "Direct3DRMCreate" (byval lplpDirect3DRM as LPDIRECT3DRM ptr) as HRESULT

type IDirect3DRMVtbl_ as IDirect3DRMVtbl

type IDirect3DRM
	lpVtbl as IDirect3DRMVtbl_ ptr
end type

type IDirect3DRMVtbl
	QueryInterface as function(byval as IDirect3DRM ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRM ptr) as ULONG
	Release as function(byval as IDirect3DRM ptr) as ULONG
	CreateObject as function(byval as IDirect3DRM ptr, byval as CLSID ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	CreateFrame as function(byval as IDirect3DRM ptr, byval as LPDIRECT3DRMFRAME, byval as LPDIRECT3DRMFRAME ptr) as HRESULT
	CreateMesh as function(byval as IDirect3DRM ptr, byval as LPDIRECT3DRMMESH ptr) as HRESULT
	CreateMeshBuilder as function(byval as IDirect3DRM ptr, byval as LPDIRECT3DRMMESHBUILDER ptr) as HRESULT
	CreateFace as function(byval as IDirect3DRM ptr, byval as LPDIRECT3DRMFACE ptr) as HRESULT
	CreateAnimation as function(byval as IDirect3DRM ptr, byval as LPDIRECT3DRMANIMATION ptr) as HRESULT
	CreateAnimationSet as function(byval as IDirect3DRM ptr, byval as LPDIRECT3DRMANIMATIONSET ptr) as HRESULT
	CreateTexture as function(byval as IDirect3DRM ptr, byval as LPD3DRMIMAGE, byval as LPDIRECT3DRMTEXTURE ptr) as HRESULT
	CreateLight as function(byval as IDirect3DRM ptr, byval as D3DRMLIGHTTYPE, byval as D3DCOLOR, byval as LPDIRECT3DRMLIGHT ptr) as HRESULT
	CreateLightRGB as function(byval as IDirect3DRM ptr, byval as D3DRMLIGHTTYPE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as LPDIRECT3DRMLIGHT ptr) as HRESULT
	CreateMaterial as function(byval as IDirect3DRM ptr, byval as D3DVALUE, byval as LPDIRECT3DRMMATERIAL ptr) as HRESULT
	CreateDevice as function(byval as IDirect3DRM ptr, byval as DWORD, byval as DWORD, byval as LPDIRECT3DRMDEVICE ptr) as HRESULT
	CreateDeviceFromSurface as function(byval as IDirect3DRM ptr, byval as LPGUID, byval as LPDIRECTDRAW, byval as LPDIRECTDRAWSURFACE, byval as LPDIRECT3DRMDEVICE ptr) as HRESULT
	CreateDeviceFromD3D as function(byval as IDirect3DRM ptr, byval as LPDIRECT3D, byval as LPDIRECT3DDEVICE, byval as LPDIRECT3DRMDEVICE ptr) as HRESULT
	CreateDeviceFromClipper as function(byval as IDirect3DRM ptr, byval as LPDIRECTDRAWCLIPPER, byval as LPGUID, byval as integer, byval as integer, byval as LPDIRECT3DRMDEVICE ptr) as HRESULT
	CreateTextureFromSurface as function(byval as IDirect3DRM ptr, byval as LPDIRECTDRAWSURFACE, byval as LPDIRECT3DRMTEXTURE ptr) as HRESULT
	CreateShadow as function(byval as IDirect3DRM ptr, byval as LPDIRECT3DRMVISUAL, byval as LPDIRECT3DRMLIGHT, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as LPDIRECT3DRMVISUAL ptr) as HRESULT
	CreateViewport as function(byval as IDirect3DRM ptr, byval as LPDIRECT3DRMDEVICE, byval as LPDIRECT3DRMFRAME, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD, byval as LPDIRECT3DRMVIEWPORT ptr) as HRESULT
	CreateWrap as function(byval as IDirect3DRM ptr, byval as D3DRMWRAPTYPE, byval as LPDIRECT3DRMFRAME, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as LPDIRECT3DRMWRAP ptr) as HRESULT
	CreateUserVisual as function(byval as IDirect3DRM ptr, byval as D3DRMUSERVISUALCALLBACK, byval as LPVOID, byval as LPDIRECT3DRMUSERVISUAL ptr) as HRESULT
	LoadTexture as function(byval as IDirect3DRM ptr, byval as zstring ptr, byval as LPDIRECT3DRMTEXTURE ptr) as HRESULT
	LoadTextureFromResource as function(byval as IDirect3DRM ptr, byval as HRSRC, byval as LPDIRECT3DRMTEXTURE ptr) as HRESULT
	SetSearchPath as function(byval as IDirect3DRM ptr, byval as LPCSTR) as HRESULT
	AddSearchPath as function(byval as IDirect3DRM ptr, byval as LPCSTR) as HRESULT
	GetSearchPath as function(byval as IDirect3DRM ptr, byval as DWORD ptr, byval as LPSTR) as HRESULT
	SetDefaultTextureColors as function(byval as IDirect3DRM ptr, byval as DWORD) as HRESULT
	SetDefaultTextureShades as function(byval as IDirect3DRM ptr, byval as DWORD) as HRESULT
	GetDevices as function(byval as IDirect3DRM ptr, byval as LPDIRECT3DRMDEVICEARRAY ptr) as HRESULT
	GetNamedObject as function(byval as IDirect3DRM ptr, byval as zstring ptr, byval as LPDIRECT3DRMOBJECT ptr) as HRESULT
	EnumerateObjects as function(byval as IDirect3DRM ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	Load as function(byval as IDirect3DRM ptr, byval as LPVOID, byval as LPVOID, byval as LPIID ptr, byval as DWORD, byval as D3DRMLOADOPTIONS, byval as D3DRMLOADCALLBACK, byval as LPVOID, byval as D3DRMLOADTEXTURECALLBACK, byval as LPVOID, byval as LPDIRECT3DRMFRAME) as HRESULT
	Tick as function(byval as IDirect3DRM ptr, byval as D3DVALUE) as HRESULT
end type

type IDirect3DRM2Vtbl_ as IDirect3DRM2Vtbl

type IDirect3DRM2
	lpVtbl as IDirect3DRM2Vtbl_ ptr
end type

type IDirect3DRM2Vtbl
	QueryInterface as function(byval as IDirect3DRM2 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRM2 ptr) as ULONG
	Release as function(byval as IDirect3DRM2 ptr) as ULONG
	CreateObject as function(byval as IDirect3DRM2 ptr, byval as CLSID ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	CreateFrame as function(byval as IDirect3DRM2 ptr, byval as LPDIRECT3DRMFRAME, byval as LPDIRECT3DRMFRAME2 ptr) as HRESULT
	CreateMesh as function(byval as IDirect3DRM2 ptr, byval as LPDIRECT3DRMMESH ptr) as HRESULT
	CreateMeshBuilder as function(byval as IDirect3DRM2 ptr, byval as LPDIRECT3DRMMESHBUILDER2 ptr) as HRESULT
	CreateFace as function(byval as IDirect3DRM2 ptr, byval as LPDIRECT3DRMFACE ptr) as HRESULT
	CreateAnimation as function(byval as IDirect3DRM2 ptr, byval as LPDIRECT3DRMANIMATION ptr) as HRESULT
	CreateAnimationSet as function(byval as IDirect3DRM2 ptr, byval as LPDIRECT3DRMANIMATIONSET ptr) as HRESULT
	CreateTexture as function(byval as IDirect3DRM2 ptr, byval as LPD3DRMIMAGE, byval as LPDIRECT3DRMTEXTURE2 ptr) as HRESULT
	CreateLight as function(byval as IDirect3DRM2 ptr, byval as D3DRMLIGHTTYPE, byval as D3DCOLOR, byval as LPDIRECT3DRMLIGHT ptr) as HRESULT
	CreateLightRGB as function(byval as IDirect3DRM2 ptr, byval as D3DRMLIGHTTYPE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as LPDIRECT3DRMLIGHT ptr) as HRESULT
	CreateMaterial as function(byval as IDirect3DRM2 ptr, byval as D3DVALUE, byval as LPDIRECT3DRMMATERIAL ptr) as HRESULT
	CreateDevice as function(byval as IDirect3DRM2 ptr, byval as DWORD, byval as DWORD, byval as LPDIRECT3DRMDEVICE2 ptr) as HRESULT
	CreateDeviceFromSurface as function(byval as IDirect3DRM2 ptr, byval as LPGUID, byval as LPDIRECTDRAW, byval as LPDIRECTDRAWSURFACE, byval as LPDIRECT3DRMDEVICE2 ptr) as HRESULT
	CreateDeviceFromD3D as function(byval as IDirect3DRM2 ptr, byval as LPDIRECT3D2, byval as LPDIRECT3DDEVICE2, byval as LPDIRECT3DRMDEVICE2 ptr) as HRESULT
	CreateDeviceFromClipper as function(byval as IDirect3DRM2 ptr, byval as LPDIRECTDRAWCLIPPER, byval as LPGUID, byval as integer, byval as integer, byval as LPDIRECT3DRMDEVICE2 ptr) as HRESULT
	CreateTextureFromSurface as function(byval as IDirect3DRM2 ptr, byval as LPDIRECTDRAWSURFACE, byval as LPDIRECT3DRMTEXTURE2 ptr) as HRESULT
	CreateShadow as function(byval as IDirect3DRM2 ptr, byval as LPDIRECT3DRMVISUAL, byval as LPDIRECT3DRMLIGHT, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as LPDIRECT3DRMVISUAL ptr) as HRESULT
	CreateViewport as function(byval as IDirect3DRM2 ptr, byval as LPDIRECT3DRMDEVICE, byval as LPDIRECT3DRMFRAME, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD, byval as LPDIRECT3DRMVIEWPORT ptr) as HRESULT
	CreateWrap as function(byval as IDirect3DRM2 ptr, byval as D3DRMWRAPTYPE, byval as LPDIRECT3DRMFRAME, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as LPDIRECT3DRMWRAP ptr) as HRESULT
	CreateUserVisual as function(byval as IDirect3DRM2 ptr, byval as D3DRMUSERVISUALCALLBACK, byval as LPVOID, byval as LPDIRECT3DRMUSERVISUAL ptr) as HRESULT
	LoadTexture as function(byval as IDirect3DRM2 ptr, byval as zstring ptr, byval as LPDIRECT3DRMTEXTURE2 ptr) as HRESULT
	LoadTextureFromResource as function(byval as IDirect3DRM2 ptr, byval as HMODULE, byval as LPCTSTR, byval as LPCTSTR, byval as LPDIRECT3DRMTEXTURE2 ptr) as HRESULT
	SetSearchPath as function(byval as IDirect3DRM2 ptr, byval as LPCSTR) as HRESULT
	AddSearchPath as function(byval as IDirect3DRM2 ptr, byval as LPCSTR) as HRESULT
	GetSearchPath as function(byval as IDirect3DRM2 ptr, byval as DWORD ptr, byval as LPSTR) as HRESULT
	SetDefaultTextureColors as function(byval as IDirect3DRM2 ptr, byval as DWORD) as HRESULT
	SetDefaultTextureShades as function(byval as IDirect3DRM2 ptr, byval as DWORD) as HRESULT
	GetDevices as function(byval as IDirect3DRM2 ptr, byval as LPDIRECT3DRMDEVICEARRAY ptr) as HRESULT
	GetNamedObject as function(byval as IDirect3DRM2 ptr, byval as zstring ptr, byval as LPDIRECT3DRMOBJECT ptr) as HRESULT
	EnumerateObjects as function(byval as IDirect3DRM2 ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	Load as function(byval as IDirect3DRM2 ptr, byval as LPVOID, byval as LPVOID, byval as LPIID ptr, byval as DWORD, byval as D3DRMLOADOPTIONS, byval as D3DRMLOADCALLBACK, byval as LPVOID, byval as D3DRMLOADTEXTURECALLBACK, byval as LPVOID, byval as LPDIRECT3DRMFRAME) as HRESULT
	Tick as function(byval as IDirect3DRM2 ptr, byval as D3DVALUE) as HRESULT
	CreateProgressiveMesh as function(byval as IDirect3DRM2 ptr, byval as LPDIRECT3DRMPROGRESSIVEMESH ptr) as HRESULT
end type

type IDirect3DRM3Vtbl_ as IDirect3DRM3Vtbl

type IDirect3DRM3
	lpVtbl as IDirect3DRM3Vtbl_ ptr
end type

type IDirect3DRM3Vtbl
	QueryInterface as function(byval as IDirect3DRM3 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRM3 ptr) as ULONG
	Release as function(byval as IDirect3DRM3 ptr) as ULONG
	CreateObject as function(byval as IDirect3DRM3 ptr, byval as CLSID ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	CreateFrame as function(byval as IDirect3DRM3 ptr, byval as LPDIRECT3DRMFRAME3, byval as LPDIRECT3DRMFRAME3 ptr) as HRESULT
	CreateMesh as function(byval as IDirect3DRM3 ptr, byval as LPDIRECT3DRMMESH ptr) as HRESULT
	CreateMeshBuilder as function(byval as IDirect3DRM3 ptr, byval as LPDIRECT3DRMMESHBUILDER3 ptr) as HRESULT
	CreateFace as function(byval as IDirect3DRM3 ptr, byval as LPDIRECT3DRMFACE2 ptr) as HRESULT
	CreateAnimation as function(byval as IDirect3DRM3 ptr, byval as LPDIRECT3DRMANIMATION2 ptr) as HRESULT
	CreateAnimationSet as function(byval as IDirect3DRM3 ptr, byval as LPDIRECT3DRMANIMATIONSET2 ptr) as HRESULT
	CreateTexture as function(byval as IDirect3DRM3 ptr, byval as LPD3DRMIMAGE, byval as LPDIRECT3DRMTEXTURE3 ptr) as HRESULT
	CreateLight as function(byval as IDirect3DRM3 ptr, byval as D3DRMLIGHTTYPE, byval as D3DCOLOR, byval as LPDIRECT3DRMLIGHT ptr) as HRESULT
	CreateLightRGB as function(byval as IDirect3DRM3 ptr, byval as D3DRMLIGHTTYPE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as LPDIRECT3DRMLIGHT ptr) as HRESULT
	CreateMaterial as function(byval as IDirect3DRM3 ptr, byval as D3DVALUE, byval as LPDIRECT3DRMMATERIAL2 ptr) as HRESULT
	CreateDevice as function(byval as IDirect3DRM3 ptr, byval as DWORD, byval as DWORD, byval as LPDIRECT3DRMDEVICE3 ptr) as HRESULT
	CreateDeviceFromSurface as function(byval as IDirect3DRM3 ptr, byval as LPGUID, byval as LPDIRECTDRAW, byval as LPDIRECTDRAWSURFACE, byval as DWORD, byval as LPDIRECT3DRMDEVICE3 ptr) as HRESULT
	CreateDeviceFromD3D as function(byval as IDirect3DRM3 ptr, byval as LPDIRECT3D2, byval as LPDIRECT3DDEVICE2, byval as LPDIRECT3DRMDEVICE3 ptr) as HRESULT
	CreateDeviceFromClipper as function(byval as IDirect3DRM3 ptr, byval as LPDIRECTDRAWCLIPPER, byval as LPGUID, byval as integer, byval as integer, byval as LPDIRECT3DRMDEVICE3 ptr) as HRESULT
	CreateTextureFromSurface as function(byval as IDirect3DRM3 ptr, byval as LPDIRECTDRAWSURFACE, byval as LPDIRECT3DRMTEXTURE3 ptr) as HRESULT
	CreateShadow as function(byval as IDirect3DRM3 ptr, byval as LPUNKNOWN, byval as LPDIRECT3DRMLIGHT, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as LPDIRECT3DRMSHADOW2 ptr) as HRESULT
	CreateViewport as function(byval as IDirect3DRM3 ptr, byval as LPDIRECT3DRMDEVICE3, byval as LPDIRECT3DRMFRAME3, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD, byval as LPDIRECT3DRMVIEWPORT2 ptr) as HRESULT
	CreateWrap as function(byval as IDirect3DRM3 ptr, byval as D3DRMWRAPTYPE, byval as LPDIRECT3DRMFRAME3, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as LPDIRECT3DRMWRAP ptr) as HRESULT
	CreateUserVisual as function(byval as IDirect3DRM3 ptr, byval as D3DRMUSERVISUALCALLBACK, byval as LPVOID, byval as LPDIRECT3DRMUSERVISUAL ptr) as HRESULT
	LoadTexture as function(byval as IDirect3DRM3 ptr, byval as zstring ptr, byval as LPDIRECT3DRMTEXTURE3 ptr) as HRESULT
	LoadTextureFromResource as function(byval as IDirect3DRM3 ptr, byval as HMODULE, byval as LPCTSTR, byval as LPCTSTR, byval as LPDIRECT3DRMTEXTURE3 ptr) as HRESULT
	SetSearchPath as function(byval as IDirect3DRM3 ptr, byval as LPCSTR) as HRESULT
	AddSearchPath as function(byval as IDirect3DRM3 ptr, byval as LPCSTR) as HRESULT
	GetSearchPath as function(byval as IDirect3DRM3 ptr, byval as DWORD ptr, byval as LPSTR) as HRESULT
	SetDefaultTextureColors as function(byval as IDirect3DRM3 ptr, byval as DWORD) as HRESULT
	SetDefaultTextureShades as function(byval as IDirect3DRM3 ptr, byval as DWORD) as HRESULT
	GetDevices as function(byval as IDirect3DRM3 ptr, byval as LPDIRECT3DRMDEVICEARRAY ptr) as HRESULT
	GetNamedObject as function(byval as IDirect3DRM3 ptr, byval as zstring ptr, byval as LPDIRECT3DRMOBJECT ptr) as HRESULT
	EnumerateObjects as function(byval as IDirect3DRM3 ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	Load as function(byval as IDirect3DRM3 ptr, byval as LPVOID, byval as LPVOID, byval as LPIID ptr, byval as DWORD, byval as D3DRMLOADOPTIONS, byval as D3DRMLOADCALLBACK, byval as LPVOID, byval as D3DRMLOADTEXTURE3CALLBACK, byval as LPVOID, byval as LPDIRECT3DRMFRAME3) as HRESULT
	Tick as function(byval as IDirect3DRM3 ptr, byval as D3DVALUE) as HRESULT
	CreateProgressiveMesh as function(byval as IDirect3DRM3 ptr, byval as LPDIRECT3DRMPROGRESSIVEMESH ptr) as HRESULT
	RegisterClient as function(byval as IDirect3DRM3 ptr, byval as GUID ptr, byval as LPDWORD) as HRESULT
	UnregisterClient as function(byval as IDirect3DRM3 ptr, byval as GUID ptr) as HRESULT
	CreateClippedVisual as function(byval as IDirect3DRM3 ptr, byval as LPDIRECT3DRMVISUAL, byval as LPDIRECT3DRMCLIPPEDVISUAL ptr) as HRESULT
	SetOptions as function(byval as IDirect3DRM3 ptr, byval as DWORD) as HRESULT
	GetOptions as function(byval as IDirect3DRM3 ptr, byval as LPDWORD) as HRESULT
end type

#define D3DRM_OK DD_OK
#define D3DRMERR_BADOBJECT MAKE_DDHRESULT(781)
#define D3DRMERR_BADTYPE MAKE_DDHRESULT(782)
#define D3DRMERR_BADALLOC MAKE_DDHRESULT(783)
#define D3DRMERR_FACEUSED MAKE_DDHRESULT(784)
#define D3DRMERR_NOTFOUND MAKE_DDHRESULT(785)
#define D3DRMERR_NOTDONEYET MAKE_DDHRESULT(786)
#define D3DRMERR_FILENOTFOUND MAKE_DDHRESULT(787)
#define D3DRMERR_BADFILE MAKE_DDHRESULT(788)
#define D3DRMERR_BADDEVICE MAKE_DDHRESULT(789)
#define D3DRMERR_BADVALUE MAKE_DDHRESULT(790)
#define D3DRMERR_BADMAJORVERSION MAKE_DDHRESULT(791)
#define D3DRMERR_BADMINORVERSION MAKE_DDHRESULT(792)
#define D3DRMERR_UNABLETOEXECUTE MAKE_DDHRESULT(793)
#define D3DRMERR_LIBRARYNOTFOUND MAKE_DDHRESULT(794)
#define D3DRMERR_INVALIDLIBRARY MAKE_DDHRESULT(795)
#define D3DRMERR_PENDING MAKE_DDHRESULT(796)
#define D3DRMERR_NOTENOUGHDATA MAKE_DDHRESULT(797)
#define D3DRMERR_REQUESTTOOLARGE MAKE_DDHRESULT(798)
#define D3DRMERR_REQUESTTOOSMALL MAKE_DDHRESULT(799)
#define D3DRMERR_CONNECTIONLOST MAKE_DDHRESULT(800)
#define D3DRMERR_LOADABORTED MAKE_DDHRESULT(801)
#define D3DRMERR_NOINTERNET MAKE_DDHRESULT(802)
#define D3DRMERR_BADCACHEFILE MAKE_DDHRESULT(803)
#define D3DRMERR_BOXNOTSET MAKE_DDHRESULT(804)
#define D3DRMERR_BADPMDATA MAKE_DDHRESULT(805)
#define D3DRMERR_CLIENTNOTREGISTERED MAKE_DDHRESULT(806)
#define D3DRMERR_NOTCREATEDFROMDDS MAKE_DDHRESULT(807)
#define D3DRMERR_NOSUCHKEY MAKE_DDHRESULT(808)
#define D3DRMERR_INCOMPATABLEKEY MAKE_DDHRESULT(809)
#define D3DRMERR_ELEMENTINUSE MAKE_DDHRESULT(810)
#define D3DRMERR_TEXTUREFORMATNOTFOUND MAKE_DDHRESULT(811)
#define D3DRMERR_NOTAGGREGATED MAKE_DDHRESULT(812)

#endif
