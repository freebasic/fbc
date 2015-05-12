''
''
'' d3drmobj -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_d3drmobj_bi__
#define __win_d3drmobj_bi__

#include once "win/objbase.bi"
#include once "win/d3drmdef.bi"
#include once "win/d3d.bi"

type LPDIRECT3DRMOBJECT as IDirect3DRMObject ptr
type LPLPDIRECT3DRMOBJECT as IDirect3DRMObject ptr ptr
type LPDIRECT3DRMOBJECT2 as IDirect3DRMObject2 ptr
type LPLPDIRECT3DRMOBJECT2 as IDirect3DRMObject2 ptr ptr
type LPDIRECT3DRMDEVICE as IDirect3DRMDevice ptr
type LPLPDIRECT3DRMDEVICE as IDirect3DRMDevice ptr ptr
type LPDIRECT3DRMDEVICE2 as IDirect3DRMDevice2 ptr
type LPLPDIRECT3DRMDEVICE2 as IDirect3DRMDevice2 ptr ptr
type LPDIRECT3DRMDEVICE3 as IDirect3DRMDevice3 ptr
type LPLPDIRECT3DRMDEVICE3 as IDirect3DRMDevice3 ptr ptr
type LPDIRECT3DRMVIEWPORT as IDirect3DRMViewport ptr
type LPLPDIRECT3DRMVIEWPORT as IDirect3DRMViewport ptr ptr
type LPDIRECT3DRMVIEWPORT2 as IDirect3DRMViewport2 ptr
type LPLPDIRECT3DRMVIEWPORT2 as IDirect3DRMViewport2 ptr ptr
type LPDIRECT3DRMFRAME as IDirect3DRMFrame ptr
type LPLPDIRECT3DRMFRAME as IDirect3DRMFrame ptr ptr
type LPDIRECT3DRMFRAME2 as IDirect3DRMFrame2 ptr
type LPLPDIRECT3DRMFRAME2 as IDirect3DRMFrame2 ptr ptr
type LPDIRECT3DRMFRAME3 as IDirect3DRMFrame3 ptr
type LPLPDIRECT3DRMFRAME3 as IDirect3DRMFrame3 ptr ptr
type LPDIRECT3DRMVISUAL as IDirect3DRMVisual ptr
type LPLPDIRECT3DRMVISUAL as IDirect3DRMVisual ptr ptr
type LPDIRECT3DRMMESH as IDirect3DRMMesh ptr
type LPLPDIRECT3DRMMESH as IDirect3DRMMesh ptr ptr
type LPDIRECT3DRMMESHBUILDER as IDirect3DRMMeshBuilder ptr
type LPLPDIRECT3DRMMESHBUILDER as IDirect3DRMMeshBuilder ptr ptr
type LPDIRECT3DRMMESHBUILDER2 as IDirect3DRMMeshBuilder2 ptr
type LPLPDIRECT3DRMMESHBUILDER2 as IDirect3DRMMeshBuilder2 ptr ptr
type LPDIRECT3DRMMESHBUILDER3 as IDirect3DRMMeshBuilder3 ptr
type LPLPDIRECT3DRMMESHBUILDER3 as IDirect3DRMMeshBuilder3 ptr ptr
type LPDIRECT3DRMFACE as IDirect3DRMFace ptr
type LPLPDIRECT3DRMFACE as IDirect3DRMFace ptr ptr
type LPDIRECT3DRMFACE2 as IDirect3DRMFace2 ptr
type LPLPDIRECT3DRMFACE2 as IDirect3DRMFace2 ptr ptr
type LPDIRECT3DRMLIGHT as IDirect3DRMLight ptr
type LPLPDIRECT3DRMLIGHT as IDirect3DRMLight ptr ptr
type LPDIRECT3DRMTEXTURE as IDirect3DRMTexture ptr
type LPLPDIRECT3DRMTEXTURE as IDirect3DRMTexture ptr ptr
type LPDIRECT3DRMTEXTURE2 as IDirect3DRMTexture2 ptr
type LPLPDIRECT3DRMTEXTURE2 as IDirect3DRMTexture2 ptr ptr
type LPDIRECT3DRMTEXTURE3 as IDirect3DRMTexture3 ptr
type LPLPDIRECT3DRMTEXTURE3 as IDirect3DRMTexture3 ptr ptr
type LPDIRECT3DRMWRAP as IDirect3DRMWrap ptr
type LPLPDIRECT3DRMWRAP as IDirect3DRMWrap ptr ptr
type LPDIRECT3DRMMATERIAL as IDirect3DRMMaterial ptr
type LPLPDIRECT3DRMMATERIAL as IDirect3DRMMaterial ptr ptr
type LPDIRECT3DRMMATERIAL2 as IDirect3DRMMaterial2 ptr
type LPLPDIRECT3DRMMATERIAL2 as IDirect3DRMMaterial2 ptr ptr
type LPDIRECT3DRMINTERPOLATOR as IDirect3DRMInterpolator ptr
type LPLPDIRECT3DRMINTERPOLATOR as IDirect3DRMInterpolator ptr ptr
type LPDIRECT3DRMANIMATION as IDirect3DRMAnimation ptr
type LPLPDIRECT3DRMANIMATION as IDirect3DRMAnimation ptr ptr
type LPDIRECT3DRMANIMATION2 as IDirect3DRMAnimation2 ptr
type LPLPDIRECT3DRMANIMATION2 as IDirect3DRMAnimation2 ptr ptr
type LPDIRECT3DRMANIMATIONSET as IDirect3DRMAnimationSet ptr
type LPLPDIRECT3DRMANIMATIONSET as IDirect3DRMAnimationSet ptr ptr
type LPDIRECT3DRMANIMATIONSET2 as IDirect3DRMAnimationSet2 ptr
type LPLPDIRECT3DRMANIMATIONSET2 as IDirect3DRMAnimationSet2 ptr ptr
type LPDIRECT3DRMUSERVISUAL as IDirect3DRMUserVisual ptr
type LPLPDIRECT3DRMUSERVISUAL as IDirect3DRMUserVisual ptr ptr
type LPDIRECT3DRMSHADOW as IDirect3DRMShadow ptr
type LPLPDIRECT3DRMSHADOW as IDirect3DRMShadow ptr ptr
type LPDIRECT3DRMSHADOW2 as IDirect3DRMShadow2 ptr
type LPLPDIRECT3DRMSHADOW2 as IDirect3DRMShadow2 ptr ptr
type LPDIRECT3DRMARRAY as IDirect3DRMArray ptr
type LPLPDIRECT3DRMARRAY as IDirect3DRMArray ptr ptr
type LPDIRECT3DRMOBJECTARRAY as IDirect3DRMObjectArray ptr
type LPLPDIRECT3DRMOBJECTARRAY as IDirect3DRMObjectArray ptr ptr
type LPDIRECT3DRMDEVICEARRAY as IDirect3DRMDeviceArray ptr
type LPLPDIRECT3DRMDEVICEARRAY as IDirect3DRMDeviceArray ptr ptr
type LPDIRECT3DRMFACEARRAY as IDirect3DRMFaceArray ptr
type LPLPDIRECT3DRMFACEARRAY as IDirect3DRMFaceArray ptr ptr
type LPDIRECT3DRMVIEWPORTARRAY as IDirect3DRMViewportArray ptr
type LPLPDIRECT3DRMVIEWPORTARRAY as IDirect3DRMViewportArray ptr ptr
type LPDIRECT3DRMFRAMEARRAY as IDirect3DRMFrameArray ptr
type LPLPDIRECT3DRMFRAMEARRAY as IDirect3DRMFrameArray ptr ptr
type LPDIRECT3DRMANIMATIONARRAY as IDirect3DRMAnimationArray ptr
type LPLPDIRECT3DRMANIMATIONARRAY as IDirect3DRMAnimationArray ptr ptr
type LPDIRECT3DRMVISUALARRAY as IDirect3DRMVisualArray ptr
type LPLPDIRECT3DRMVISUALARRAY as IDirect3DRMVisualArray ptr ptr
type LPDIRECT3DRMPICKEDARRAY as IDirect3DRMPickedArray ptr
type LPLPDIRECT3DRMPICKEDARRAY as IDirect3DRMPickedArray ptr ptr
type LPDIRECT3DRMPICKED2ARRAY as IDirect3DRMPicked2Array ptr
type LPLPDIRECT3DRMPICKED2ARRAY as IDirect3DRMPicked2Array ptr ptr
type LPDIRECT3DRMLIGHTARRAY as IDirect3DRMLightArray ptr
type LPLPDIRECT3DRMLIGHTARRAY as IDirect3DRMLightArray ptr ptr
type LPDIRECT3DRMPROGRESSIVEMESH as IDirect3DRMProgressiveMesh ptr
type LPLPDIRECT3DRMPROGRESSIVEMESH as IDirect3DRMProgressiveMesh ptr ptr
type LPDIRECT3DRMCLIPPEDVISUAL as IDirect3DRMClippedVisual ptr
type LPLPDIRECT3DRMCLIPPEDVISUAL as IDirect3DRMClippedVisual ptr ptr

extern CLSID_CDirect3DRMDevice alias "CLSID_CDirect3DRMDevice" as GUID
extern CLSID_CDirect3DRMViewport alias "CLSID_CDirect3DRMViewport" as GUID
extern CLSID_CDirect3DRMFrame alias "CLSID_CDirect3DRMFrame" as GUID
extern CLSID_CDirect3DRMMesh alias "CLSID_CDirect3DRMMesh" as GUID
extern CLSID_CDirect3DRMMeshBuilder alias "CLSID_CDirect3DRMMeshBuilder" as GUID
extern CLSID_CDirect3DRMFace alias "CLSID_CDirect3DRMFace" as GUID
extern CLSID_CDirect3DRMLight alias "CLSID_CDirect3DRMLight" as GUID
extern CLSID_CDirect3DRMTexture alias "CLSID_CDirect3DRMTexture" as GUID
extern CLSID_CDirect3DRMWrap alias "CLSID_CDirect3DRMWrap" as GUID
extern CLSID_CDirect3DRMMaterial alias "CLSID_CDirect3DRMMaterial" as GUID
extern CLSID_CDirect3DRMAnimation alias "CLSID_CDirect3DRMAnimation" as GUID
extern CLSID_CDirect3DRMAnimationSet alias "CLSID_CDirect3DRMAnimationSet" as GUID
extern CLSID_CDirect3DRMUserVisual alias "CLSID_CDirect3DRMUserVisual" as GUID
extern CLSID_CDirect3DRMShadow alias "CLSID_CDirect3DRMShadow" as GUID
extern CLSID_CDirect3DRMViewportInterpolator alias "CLSID_CDirect3DRMViewportInterpolator" as GUID
extern CLSID_CDirect3DRMFrameInterpolator alias "CLSID_CDirect3DRMFrameInterpolator" as GUID
extern CLSID_CDirect3DRMMeshInterpolator alias "CLSID_CDirect3DRMMeshInterpolator" as GUID
extern CLSID_CDirect3DRMLightInterpolator alias "CLSID_CDirect3DRMLightInterpolator" as GUID
extern CLSID_CDirect3DRMMaterialInterpolator alias "CLSID_CDirect3DRMMaterialInterpolator" as GUID
extern CLSID_CDirect3DRMTextureInterpolator alias "CLSID_CDirect3DRMTextureInterpolator" as GUID
extern CLSID_CDirect3DRMProgressiveMesh alias "CLSID_CDirect3DRMProgressiveMesh" as GUID
extern CLSID_CDirect3DRMClippedVisual alias "CLSID_CDirect3DRMClippedVisual" as GUID
extern IID_IDirect3DRMObject alias "IID_IDirect3DRMObject" as GUID
extern IID_IDirect3DRMObject2 alias "IID_IDirect3DRMObject2" as GUID
extern IID_IDirect3DRMDevice alias "IID_IDirect3DRMDevice" as GUID
extern IID_IDirect3DRMDevice2 alias "IID_IDirect3DRMDevice2" as GUID
extern IID_IDirect3DRMDevice3 alias "IID_IDirect3DRMDevice3" as GUID
extern IID_IDirect3DRMViewport alias "IID_IDirect3DRMViewport" as GUID
extern IID_IDirect3DRMViewport2 alias "IID_IDirect3DRMViewport2" as GUID
extern IID_IDirect3DRMFrame alias "IID_IDirect3DRMFrame" as GUID
extern IID_IDirect3DRMFrame2 alias "IID_IDirect3DRMFrame2" as GUID
extern IID_IDirect3DRMFrame3 alias "IID_IDirect3DRMFrame3" as GUID
extern IID_IDirect3DRMVisual alias "IID_IDirect3DRMVisual" as GUID
extern IID_IDirect3DRMMesh alias "IID_IDirect3DRMMesh" as GUID
extern IID_IDirect3DRMMeshBuilder alias "IID_IDirect3DRMMeshBuilder" as GUID
extern IID_IDirect3DRMMeshBuilder2 alias "IID_IDirect3DRMMeshBuilder2" as GUID
extern IID_IDirect3DRMMeshBuilder3 alias "IID_IDirect3DRMMeshBuilder3" as GUID
extern IID_IDirect3DRMFace alias "IID_IDirect3DRMFace" as GUID
extern IID_IDirect3DRMFace2 alias "IID_IDirect3DRMFace2" as GUID
extern IID_IDirect3DRMLight alias "IID_IDirect3DRMLight" as GUID
extern IID_IDirect3DRMTexture alias "IID_IDirect3DRMTexture" as GUID
extern IID_IDirect3DRMTexture2 alias "IID_IDirect3DRMTexture2" as GUID
extern IID_IDirect3DRMTexture3 alias "IID_IDirect3DRMTexture3" as GUID
extern IID_IDirect3DRMWrap alias "IID_IDirect3DRMWrap" as GUID
extern IID_IDirect3DRMMaterial alias "IID_IDirect3DRMMaterial" as GUID
extern IID_IDirect3DRMMaterial2 alias "IID_IDirect3DRMMaterial2" as GUID
extern IID_IDirect3DRMAnimation alias "IID_IDirect3DRMAnimation" as GUID
extern IID_IDirect3DRMAnimation2 alias "IID_IDirect3DRMAnimation2" as GUID
extern IID_IDirect3DRMAnimationSet alias "IID_IDirect3DRMAnimationSet" as GUID
extern IID_IDirect3DRMAnimationSet2 alias "IID_IDirect3DRMAnimationSet2" as GUID
extern IID_IDirect3DRMObjectArray alias "IID_IDirect3DRMObjectArray" as GUID
extern IID_IDirect3DRMDeviceArray alias "IID_IDirect3DRMDeviceArray" as GUID
extern IID_IDirect3DRMViewportArray alias "IID_IDirect3DRMViewportArray" as GUID
extern IID_IDirect3DRMFrameArray alias "IID_IDirect3DRMFrameArray" as GUID
extern IID_IDirect3DRMVisualArray alias "IID_IDirect3DRMVisualArray" as GUID
extern IID_IDirect3DRMLightArray alias "IID_IDirect3DRMLightArray" as GUID
extern IID_IDirect3DRMPickedArray alias "IID_IDirect3DRMPickedArray" as GUID
extern IID_IDirect3DRMFaceArray alias "IID_IDirect3DRMFaceArray" as GUID
extern IID_IDirect3DRMAnimationArray alias "IID_IDirect3DRMAnimationArray" as GUID
extern IID_IDirect3DRMUserVisual alias "IID_IDirect3DRMUserVisual" as GUID
extern IID_IDirect3DRMShadow alias "IID_IDirect3DRMShadow" as GUID
extern IID_IDirect3DRMShadow2 alias "IID_IDirect3DRMShadow2" as GUID
extern IID_IDirect3DRMInterpolator alias "IID_IDirect3DRMInterpolator" as GUID
extern IID_IDirect3DRMProgressiveMesh alias "IID_IDirect3DRMProgressiveMesh" as GUID
extern IID_IDirect3DRMPicked2Array alias "IID_IDirect3DRMPicked2Array" as GUID
extern IID_IDirect3DRMClippedVisual alias "IID_IDirect3DRMClippedVisual" as GUID

type D3DRMOBJECTCALLBACK as sub(byval as LPDIRECT3DRMOBJECT, byval as LPVOID)
type D3DRMFRAMEMOVECALLBACK as sub(byval as LPDIRECT3DRMFRAME, byval as LPVOID, byval as D3DVALUE)
type D3DRMFRAME3MOVECALLBACK as sub(byval as LPDIRECT3DRMFRAME3, byval as LPVOID, byval as D3DVALUE)
type D3DRMUPDATECALLBACK as sub(byval as LPDIRECT3DRMDEVICE, byval as LPVOID, byval as integer, byval as LPD3DRECT)
type D3DRMDEVICE3UPDATECALLBACK as sub(byval as LPDIRECT3DRMDEVICE3, byval as LPVOID, byval as integer, byval as LPD3DRECT)
type D3DRMUSERVISUALCALLBACK as function(byval as LPDIRECT3DRMUSERVISUAL, byval as LPVOID, byval as D3DRMUSERVISUALREASON, byval as LPDIRECT3DRMDEVICE, byval as LPDIRECT3DRMVIEWPORT) as integer
type D3DRMLOADTEXTURECALLBACK as function(byval as zstring ptr, byval as any ptr, byval as LPDIRECT3DRMTEXTURE ptr) as HRESULT
type D3DRMLOADTEXTURE3CALLBACK as function(byval as zstring ptr, byval as any ptr, byval as LPDIRECT3DRMTEXTURE3 ptr) as HRESULT
type D3DRMLOADCALLBACK as sub(byval as LPDIRECT3DRMOBJECT, byval as IID ptr, byval as LPVOID)
type D3DRMDOWNSAMPLECALLBACK as function(byval as LPDIRECT3DRMTEXTURE3, byval as LPVOID, byval as LPDIRECTDRAWSURFACE, byval as LPDIRECTDRAWSURFACE) as HRESULT
type D3DRMVALIDATIONCALLBACK as function(byval as LPDIRECT3DRMTEXTURE3, byval as LPVOID, byval as DWORD, byval as DWORD, byval as LPRECT) as HRESULT

type D3DRMPICKDESC
	ulFaceIdx as ULONG
	lGroupIdx as LONG
	vPosition as D3DVECTOR
end type

type LPD3DRMPICKDESC as D3DRMPICKDESC ptr

type D3DRMPICKDESC2
	ulFaceIdx as ULONG
	lGroupIdx as LONG
	dvPosition as D3DVECTOR
	tu as D3DVALUE
	tv as D3DVALUE
	dvNormal as D3DVECTOR
	dcColor as D3DCOLOR
end type

type LPD3DRMPICKDESC2 as D3DRMPICKDESC2 ptr

type IDirect3DRMObjectVtbl_ as IDirect3DRMObjectVtbl

type IDirect3DRMObject
	lpVtbl as IDirect3DRMObjectVtbl_ ptr
end type

type IDirect3DRMObjectVtbl
	QueryInterface as function(byval as IDirect3DRMObject ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMObject ptr) as ULONG
	Release as function(byval as IDirect3DRMObject ptr) as ULONG
	Clone as function(byval as IDirect3DRMObject ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddDestroyCallback as function(byval as IDirect3DRMObject ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMObject ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	SetAppData as function(byval as IDirect3DRMObject ptr, byval as DWORD) as HRESULT
	GetAppData as function(byval as IDirect3DRMObject ptr) as DWORD
	SetName as function(byval as IDirect3DRMObject ptr, byval as LPCSTR) as HRESULT
	GetName as function(byval as IDirect3DRMObject ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	GetClassNameA as function(byval as IDirect3DRMObject ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
end type

type IDirect3DRMObject2Vtbl_ as IDirect3DRMObject2Vtbl

type IDirect3DRMObject2
	lpVtbl as IDirect3DRMObject2Vtbl_ ptr
end type

type IDirect3DRMObject2Vtbl
	QueryInterface as function(byval as IDirect3DRMObject2 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMObject2 ptr) as ULONG
	Release as function(byval as IDirect3DRMObject2 ptr) as ULONG
	AddDestroyCallback as function(byval as IDirect3DRMObject2 ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	Clone as function(byval as IDirect3DRMObject2 ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMObject2 ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	GetClientData as function(byval as IDirect3DRMObject2 ptr, byval as DWORD, byval as LPVOID ptr) as HRESULT
	GetDirect3DRM as function(byval as IDirect3DRMObject2 ptr, byval as LPDIRECT3DRM ptr) as HRESULT
	GetName as function(byval as IDirect3DRMObject2 ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	SetClientData as function(byval as IDirect3DRMObject2 ptr, byval as DWORD, byval as LPVOID, byval as DWORD) as HRESULT
	SetName as function(byval as IDirect3DRMObject2 ptr, byval as LPCSTR) as HRESULT
	GetAge as function(byval as IDirect3DRMObject2 ptr, byval as DWORD, byval as LPDWORD) as HRESULT
end type

type IDirect3DRMVisualVtbl_ as IDirect3DRMVisualVtbl

type IDirect3DRMVisual
	lpVtbl as IDirect3DRMVisualVtbl_ ptr
end type

type IDirect3DRMVisualVtbl
	QueryInterface as function(byval as IDirect3DRMVisual ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMVisual ptr) as ULONG
	Release as function(byval as IDirect3DRMVisual ptr) as ULONG
	Clone as function(byval as IDirect3DRMVisual ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddDestroyCallback as function(byval as IDirect3DRMVisual ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMVisual ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	SetAppData as function(byval as IDirect3DRMVisual ptr, byval as DWORD) as HRESULT
	GetAppData as function(byval as IDirect3DRMVisual ptr) as DWORD
	SetName as function(byval as IDirect3DRMVisual ptr, byval as LPCSTR) as HRESULT
	GetName as function(byval as IDirect3DRMVisual ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	GetClassNameA as function(byval as IDirect3DRMVisual ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
end type

type IDirect3DRMDeviceVtbl_ as IDirect3DRMDeviceVtbl

type IDirect3DRMDevice
	lpVtbl as IDirect3DRMDeviceVtbl_ ptr
end type

type IDirect3DRMDeviceVtbl
	QueryInterface as function(byval as IDirect3DRMDevice ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMDevice ptr) as ULONG
	Release as function(byval as IDirect3DRMDevice ptr) as ULONG
	Clone as function(byval as IDirect3DRMDevice ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddDestroyCallback as function(byval as IDirect3DRMDevice ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMDevice ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	SetAppData as function(byval as IDirect3DRMDevice ptr, byval as DWORD) as HRESULT
	GetAppData as function(byval as IDirect3DRMDevice ptr) as DWORD
	SetName as function(byval as IDirect3DRMDevice ptr, byval as LPCSTR) as HRESULT
	GetName as function(byval as IDirect3DRMDevice ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	GetClassNameA as function(byval as IDirect3DRMDevice ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	Init as function(byval as IDirect3DRMDevice ptr, byval as ULONG, byval as ULONG) as HRESULT
	InitFromD3D as function(byval as IDirect3DRMDevice ptr, byval as LPDIRECT3D, byval as LPDIRECT3DDEVICE) as HRESULT
	InitFromClipper as function(byval as IDirect3DRMDevice ptr, byval as LPDIRECTDRAWCLIPPER, byval as LPGUID, byval as integer, byval as integer) as HRESULT
	Update as function(byval as IDirect3DRMDevice ptr) as HRESULT
	AddUpdateCallback as function(byval as IDirect3DRMDevice ptr, byval as D3DRMUPDATECALLBACK, byval as LPVOID) as HRESULT
	DeleteUpdateCallback as function(byval as IDirect3DRMDevice ptr, byval as D3DRMUPDATECALLBACK, byval as LPVOID) as HRESULT
	SetBufferCount as function(byval as IDirect3DRMDevice ptr, byval as DWORD) as HRESULT
	GetBufferCount as function(byval as IDirect3DRMDevice ptr) as DWORD
	SetDither as function(byval as IDirect3DRMDevice ptr, byval as BOOL) as HRESULT
	SetShades as function(byval as IDirect3DRMDevice ptr, byval as DWORD) as HRESULT
	SetQuality as function(byval as IDirect3DRMDevice ptr, byval as D3DRMRENDERQUALITY) as HRESULT
	SetTextureQuality as function(byval as IDirect3DRMDevice ptr, byval as D3DRMTEXTUREQUALITY) as HRESULT
	GetViewports as function(byval as IDirect3DRMDevice ptr, byval as LPDIRECT3DRMVIEWPORTARRAY ptr) as HRESULT
	GetDither as function(byval as IDirect3DRMDevice ptr) as BOOL
	GetShades as function(byval as IDirect3DRMDevice ptr) as DWORD
	GetHeight as function(byval as IDirect3DRMDevice ptr) as DWORD
	GetWidth as function(byval as IDirect3DRMDevice ptr) as DWORD
	GetTrianglesDrawn as function(byval as IDirect3DRMDevice ptr) as DWORD
	GetWireframeOptions as function(byval as IDirect3DRMDevice ptr) as DWORD
	GetQuality as function(byval as IDirect3DRMDevice ptr) as D3DRMRENDERQUALITY
	GetColorModel as function(byval as IDirect3DRMDevice ptr) as D3DCOLORMODEL
	GetTextureQuality as function(byval as IDirect3DRMDevice ptr) as D3DRMTEXTUREQUALITY
	GetDirect3DDevice as function(byval as IDirect3DRMDevice ptr, byval as LPDIRECT3DDEVICE ptr) as HRESULT
end type

type IDirect3DRMDevice2Vtbl_ as IDirect3DRMDevice2Vtbl

type IDirect3DRMDevice2
	lpVtbl as IDirect3DRMDevice2Vtbl_ ptr
end type

type IDirect3DRMDevice2Vtbl
	QueryInterface as function(byval as IDirect3DRMDevice2 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMDevice2 ptr) as ULONG
	Release as function(byval as IDirect3DRMDevice2 ptr) as ULONG
	Clone as function(byval as IDirect3DRMDevice2 ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddDestroyCallback as function(byval as IDirect3DRMDevice2 ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMDevice2 ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	SetAppData as function(byval as IDirect3DRMDevice2 ptr, byval as DWORD) as HRESULT
	GetAppData as function(byval as IDirect3DRMDevice2 ptr) as DWORD
	SetName as function(byval as IDirect3DRMDevice2 ptr, byval as LPCSTR) as HRESULT
	GetName as function(byval as IDirect3DRMDevice2 ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	GetClassNameA as function(byval as IDirect3DRMDevice2 ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	Init as function(byval as IDirect3DRMDevice2 ptr, byval as ULONG, byval as ULONG) as HRESULT
	InitFromD3D as function(byval as IDirect3DRMDevice2 ptr, byval as LPDIRECT3D, byval as LPDIRECT3DDEVICE) as HRESULT
	InitFromClipper as function(byval as IDirect3DRMDevice2 ptr, byval as LPDIRECTDRAWCLIPPER, byval as LPGUID, byval as integer, byval as integer) as HRESULT
	Update as function(byval as IDirect3DRMDevice2 ptr) as HRESULT
	AddUpdateCallback as function(byval as IDirect3DRMDevice2 ptr, byval as D3DRMUPDATECALLBACK, byval as LPVOID) as HRESULT
	DeleteUpdateCallback as function(byval as IDirect3DRMDevice2 ptr, byval as D3DRMUPDATECALLBACK, byval as LPVOID) as HRESULT
	SetBufferCount as function(byval as IDirect3DRMDevice2 ptr, byval as DWORD) as HRESULT
	GetBufferCount as function(byval as IDirect3DRMDevice2 ptr) as DWORD
	SetDither as function(byval as IDirect3DRMDevice2 ptr, byval as BOOL) as HRESULT
	SetShades as function(byval as IDirect3DRMDevice2 ptr, byval as DWORD) as HRESULT
	SetQuality as function(byval as IDirect3DRMDevice2 ptr, byval as D3DRMRENDERQUALITY) as HRESULT
	SetTextureQuality as function(byval as IDirect3DRMDevice2 ptr, byval as D3DRMTEXTUREQUALITY) as HRESULT
	GetViewports as function(byval as IDirect3DRMDevice2 ptr, byval as LPDIRECT3DRMVIEWPORTARRAY ptr) as HRESULT
	GetDither as function(byval as IDirect3DRMDevice2 ptr) as BOOL
	GetShades as function(byval as IDirect3DRMDevice2 ptr) as DWORD
	GetHeight as function(byval as IDirect3DRMDevice2 ptr) as DWORD
	GetWidth as function(byval as IDirect3DRMDevice2 ptr) as DWORD
	GetTrianglesDrawn as function(byval as IDirect3DRMDevice2 ptr) as DWORD
	GetWireframeOptions as function(byval as IDirect3DRMDevice2 ptr) as DWORD
	GetQuality as function(byval as IDirect3DRMDevice2 ptr) as D3DRMRENDERQUALITY
	GetColorModel as function(byval as IDirect3DRMDevice2 ptr) as D3DCOLORMODEL
	GetTextureQuality as function(byval as IDirect3DRMDevice2 ptr) as D3DRMTEXTUREQUALITY
	GetDirect3DDevice as function(byval as IDirect3DRMDevice2 ptr, byval as LPDIRECT3DDEVICE ptr) as HRESULT
	InitFromD3D2 as function(byval as IDirect3DRMDevice2 ptr, byval as LPDIRECT3D2, byval as LPDIRECT3DDEVICE2) as HRESULT
	InitFromSurface as function(byval as IDirect3DRMDevice2 ptr, byval as LPGUID, byval as LPDIRECTDRAW, byval as LPDIRECTDRAWSURFACE) as HRESULT
	SetRenderMode as function(byval as IDirect3DRMDevice2 ptr, byval as DWORD) as HRESULT
	GetRenderMode as function(byval as IDirect3DRMDevice2 ptr) as DWORD
	GetDirect3DDevice2 as function(byval as IDirect3DRMDevice2 ptr, byval as LPDIRECT3DDEVICE2 ptr) as HRESULT
end type

type IDirect3DRMDevice3Vtbl_ as IDirect3DRMDevice3Vtbl

type IDirect3DRMDevice3
	lpVtbl as IDirect3DRMDevice3Vtbl_ ptr
end type

type IDirect3DRMDevice3Vtbl
	QueryInterface as function(byval as IDirect3DRMDevice3 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMDevice3 ptr) as ULONG
	Release as function(byval as IDirect3DRMDevice3 ptr) as ULONG
	Clone as function(byval as IDirect3DRMDevice3 ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddDestroyCallback as function(byval as IDirect3DRMDevice3 ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMDevice3 ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	SetAppData as function(byval as IDirect3DRMDevice3 ptr, byval as DWORD) as HRESULT
	GetAppData as function(byval as IDirect3DRMDevice3 ptr) as DWORD
	SetName as function(byval as IDirect3DRMDevice3 ptr, byval as LPCSTR) as HRESULT
	GetName as function(byval as IDirect3DRMDevice3 ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	GetClassNameA as function(byval as IDirect3DRMDevice3 ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	Init as function(byval as IDirect3DRMDevice3 ptr, byval as ULONG, byval as ULONG) as HRESULT
	InitFromD3D as function(byval as IDirect3DRMDevice3 ptr, byval as LPDIRECT3D, byval as LPDIRECT3DDEVICE) as HRESULT
	InitFromClipper as function(byval as IDirect3DRMDevice3 ptr, byval as LPDIRECTDRAWCLIPPER, byval as LPGUID, byval as integer, byval as integer) as HRESULT
	Update as function(byval as IDirect3DRMDevice3 ptr) as HRESULT
	AddUpdateCallback as function(byval as IDirect3DRMDevice3 ptr, byval as D3DRMDEVICE3UPDATECALLBACK, byval as LPVOID) as HRESULT
	DeleteUpdateCallback as function(byval as IDirect3DRMDevice3 ptr, byval as D3DRMDEVICE3UPDATECALLBACK, byval as LPVOID) as HRESULT
	SetBufferCount as function(byval as IDirect3DRMDevice3 ptr, byval as DWORD) as HRESULT
	GetBufferCount as function(byval as IDirect3DRMDevice3 ptr) as DWORD
	SetDither as function(byval as IDirect3DRMDevice3 ptr, byval as BOOL) as HRESULT
	SetShades as function(byval as IDirect3DRMDevice3 ptr, byval as DWORD) as HRESULT
	SetQuality as function(byval as IDirect3DRMDevice3 ptr, byval as D3DRMRENDERQUALITY) as HRESULT
	SetTextureQuality as function(byval as IDirect3DRMDevice3 ptr, byval as D3DRMTEXTUREQUALITY) as HRESULT
	GetViewports as function(byval as IDirect3DRMDevice3 ptr, byval as LPDIRECT3DRMVIEWPORTARRAY ptr) as HRESULT
	GetDither as function(byval as IDirect3DRMDevice3 ptr) as BOOL
	GetShades as function(byval as IDirect3DRMDevice3 ptr) as DWORD
	GetHeight as function(byval as IDirect3DRMDevice3 ptr) as DWORD
	GetWidth as function(byval as IDirect3DRMDevice3 ptr) as DWORD
	GetTrianglesDrawn as function(byval as IDirect3DRMDevice3 ptr) as DWORD
	GetWireframeOptions as function(byval as IDirect3DRMDevice3 ptr) as DWORD
	GetQuality as function(byval as IDirect3DRMDevice3 ptr) as D3DRMRENDERQUALITY
	GetColorModel as function(byval as IDirect3DRMDevice3 ptr) as D3DCOLORMODEL
	GetTextureQuality as function(byval as IDirect3DRMDevice3 ptr) as D3DRMTEXTUREQUALITY
	GetDirect3DDevice as function(byval as IDirect3DRMDevice3 ptr, byval as LPDIRECT3DDEVICE ptr) as HRESULT
	InitFromD3D2 as function(byval as IDirect3DRMDevice3 ptr, byval as LPDIRECT3D2, byval as LPDIRECT3DDEVICE2) as HRESULT
	InitFromSurface as function(byval as IDirect3DRMDevice3 ptr, byval as LPGUID, byval as LPDIRECTDRAW, byval as LPDIRECTDRAWSURFACE, byval as DWORD) as HRESULT
	SetRenderMode as function(byval as IDirect3DRMDevice3 ptr, byval as DWORD) as HRESULT
	GetRenderMode as function(byval as IDirect3DRMDevice3 ptr) as DWORD
	GetDirect3DDevice2 as function(byval as IDirect3DRMDevice3 ptr, byval as LPDIRECT3DDEVICE2 ptr) as HRESULT
	FindPreferredTextureFormat as function(byval as IDirect3DRMDevice3 ptr, byval as DWORD, byval as DWORD, byval as LPDDPIXELFORMAT) as HRESULT
	RenderStateChange as function(byval as IDirect3DRMDevice3 ptr, byval as D3DRENDERSTATETYPE, byval as DWORD, byval as DWORD) as HRESULT
	LightStateChange as function(byval as IDirect3DRMDevice3 ptr, byval as D3DLIGHTSTATETYPE, byval as DWORD, byval as DWORD) as HRESULT
	GetStateChangeOptions as function(byval as IDirect3DRMDevice3 ptr, byval as DWORD, byval as DWORD, byval as LPDWORD) as HRESULT
	SetStateChangeOptions as function(byval as IDirect3DRMDevice3 ptr, byval as DWORD, byval as DWORD, byval as DWORD) as HRESULT
end type

type IDirect3DRMViewportVtbl_ as IDirect3DRMViewportVtbl

type IDirect3DRMViewport
	lpVtbl as IDirect3DRMViewportVtbl_ ptr
end type

type IDirect3DRMViewportVtbl
	QueryInterface as function(byval as IDirect3DRMViewport ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMViewport ptr) as ULONG
	Release as function(byval as IDirect3DRMViewport ptr) as ULONG
	Clone as function(byval as IDirect3DRMViewport ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddDestroyCallback as function(byval as IDirect3DRMViewport ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMViewport ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	SetAppData as function(byval as IDirect3DRMViewport ptr, byval as DWORD) as HRESULT
	GetAppData as function(byval as IDirect3DRMViewport ptr) as DWORD
	SetName as function(byval as IDirect3DRMViewport ptr, byval as LPCSTR) as HRESULT
	GetName as function(byval as IDirect3DRMViewport ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	GetClassNameA as function(byval as IDirect3DRMViewport ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	Init as function(byval as IDirect3DRMViewport ptr, byval as LPDIRECT3DRMDEVICE, byval as LPDIRECT3DRMFRAME, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD) as HRESULT
	Clear as function(byval as IDirect3DRMViewport ptr) as HRESULT
	Render as function(byval as IDirect3DRMViewport ptr, byval as LPDIRECT3DRMFRAME) as HRESULT
	SetFront as function(byval as IDirect3DRMViewport ptr, byval as D3DVALUE) as HRESULT
	SetBack as function(byval as IDirect3DRMViewport ptr, byval as D3DVALUE) as HRESULT
	SetField as function(byval as IDirect3DRMViewport ptr, byval as D3DVALUE) as HRESULT
	SetUniformScaling as function(byval as IDirect3DRMViewport ptr, byval as BOOL) as HRESULT
	SetCamera as function(byval as IDirect3DRMViewport ptr, byval as LPDIRECT3DRMFRAME) as HRESULT
	SetProjection as function(byval as IDirect3DRMViewport ptr, byval as D3DRMPROJECTIONTYPE) as HRESULT
	Transform as function(byval as IDirect3DRMViewport ptr, byval as D3DRMVECTOR4D ptr, byval as D3DVECTOR ptr) as HRESULT
	InverseTransform as function(byval as IDirect3DRMViewport ptr, byval as D3DVECTOR ptr, byval as D3DRMVECTOR4D ptr) as HRESULT
	Configure as function(byval as IDirect3DRMViewport ptr, byval as LONG, byval as LONG, byval as DWORD, byval as DWORD) as HRESULT
	ForceUpdate as function(byval as IDirect3DRMViewport ptr, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD) as HRESULT
	SetPlane as function(byval as IDirect3DRMViewport ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	GetCamera as function(byval as IDirect3DRMViewport ptr, byval as LPDIRECT3DRMFRAME ptr) as HRESULT
	GetDevice as function(byval as IDirect3DRMViewport ptr, byval as LPDIRECT3DRMDEVICE ptr) as HRESULT
	GetPlane as function(byval as IDirect3DRMViewport ptr, byval as D3DVALUE ptr, byval as D3DVALUE ptr, byval as D3DVALUE ptr, byval as D3DVALUE ptr) as HRESULT
	Pick as function(byval as IDirect3DRMViewport ptr, byval as LONG, byval as LONG, byval as LPDIRECT3DRMPICKEDARRAY ptr) as HRESULT
	GetUniformScaling as function(byval as IDirect3DRMViewport ptr) as BOOL
	GetX as function(byval as IDirect3DRMViewport ptr) as LONG
	GetY as function(byval as IDirect3DRMViewport ptr) as LONG
	GetWidth as function(byval as IDirect3DRMViewport ptr) as DWORD
	GetHeight as function(byval as IDirect3DRMViewport ptr) as DWORD
	GetField as function(byval as IDirect3DRMViewport ptr) as D3DVALUE
	GetBack as function(byval as IDirect3DRMViewport ptr) as D3DVALUE
	GetFront as function(byval as IDirect3DRMViewport ptr) as D3DVALUE
	GetProjection as function(byval as IDirect3DRMViewport ptr) as D3DRMPROJECTIONTYPE
	GetDirect3DViewport as function(byval as IDirect3DRMViewport ptr, byval as LPDIRECT3DVIEWPORT ptr) as HRESULT
end type

type IDirect3DRMViewport2Vtbl_ as IDirect3DRMViewport2Vtbl

type IDirect3DRMViewport2
	lpVtbl as IDirect3DRMViewport2Vtbl_ ptr
end type

type IDirect3DRMViewport2Vtbl
	QueryInterface as function(byval as IDirect3DRMViewport2 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMViewport2 ptr) as ULONG
	Release as function(byval as IDirect3DRMViewport2 ptr) as ULONG
	Clone as function(byval as IDirect3DRMViewport2 ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddDestroyCallback as function(byval as IDirect3DRMViewport2 ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMViewport2 ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	SetAppData as function(byval as IDirect3DRMViewport2 ptr, byval as DWORD) as HRESULT
	GetAppData as function(byval as IDirect3DRMViewport2 ptr) as DWORD
	SetName as function(byval as IDirect3DRMViewport2 ptr, byval as LPCSTR) as HRESULT
	GetName as function(byval as IDirect3DRMViewport2 ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	GetClassNameA as function(byval as IDirect3DRMViewport2 ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	Init as function(byval as IDirect3DRMViewport2 ptr, byval as LPDIRECT3DRMDEVICE3, byval as LPDIRECT3DRMFRAME3, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD) as HRESULT
	Clear as function(byval as IDirect3DRMViewport2 ptr, byval as DWORD) as HRESULT
	Render as function(byval as IDirect3DRMViewport2 ptr, byval as LPDIRECT3DRMFRAME3) as HRESULT
	SetFront as function(byval as IDirect3DRMViewport2 ptr, byval as D3DVALUE) as HRESULT
	SetBack as function(byval as IDirect3DRMViewport2 ptr, byval as D3DVALUE) as HRESULT
	SetField as function(byval as IDirect3DRMViewport2 ptr, byval as D3DVALUE) as HRESULT
	SetUniformScaling as function(byval as IDirect3DRMViewport2 ptr, byval as BOOL) as HRESULT
	SetCamera as function(byval as IDirect3DRMViewport2 ptr, byval as LPDIRECT3DRMFRAME3) as HRESULT
	SetProjection as function(byval as IDirect3DRMViewport2 ptr, byval as D3DRMPROJECTIONTYPE) as HRESULT
	Transform as function(byval as IDirect3DRMViewport2 ptr, byval as D3DRMVECTOR4D ptr, byval as D3DVECTOR ptr) as HRESULT
	InverseTransform as function(byval as IDirect3DRMViewport2 ptr, byval as D3DVECTOR ptr, byval as D3DRMVECTOR4D ptr) as HRESULT
	Configure as function(byval as IDirect3DRMViewport2 ptr, byval as LONG, byval as LONG, byval as DWORD, byval as DWORD) as HRESULT
	ForceUpdate as function(byval as IDirect3DRMViewport2 ptr, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD) as HRESULT
	SetPlane as function(byval as IDirect3DRMViewport2 ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	GetCamera as function(byval as IDirect3DRMViewport2 ptr, byval as LPDIRECT3DRMFRAME3 ptr) as HRESULT
	GetDevice as function(byval as IDirect3DRMViewport2 ptr, byval as LPDIRECT3DRMDEVICE3 ptr) as HRESULT
	GetPlane as function(byval as IDirect3DRMViewport2 ptr, byval as D3DVALUE ptr, byval as D3DVALUE ptr, byval as D3DVALUE ptr, byval as D3DVALUE ptr) as HRESULT
	Pick as function(byval as IDirect3DRMViewport2 ptr, byval as LONG, byval as LONG, byval as LPDIRECT3DRMPICKEDARRAY ptr) as HRESULT
	GetUniformScaling as function(byval as IDirect3DRMViewport2 ptr) as BOOL
	GetX as function(byval as IDirect3DRMViewport2 ptr) as LONG
	GetY as function(byval as IDirect3DRMViewport2 ptr) as LONG
	GetWidth as function(byval as IDirect3DRMViewport2 ptr) as DWORD
	GetHeight as function(byval as IDirect3DRMViewport2 ptr) as DWORD
	GetField as function(byval as IDirect3DRMViewport2 ptr) as D3DVALUE
	GetBack as function(byval as IDirect3DRMViewport2 ptr) as D3DVALUE
	GetFront as function(byval as IDirect3DRMViewport2 ptr) as D3DVALUE
	GetProjection as function(byval as IDirect3DRMViewport2 ptr) as D3DRMPROJECTIONTYPE
	GetDirect3DViewport as function(byval as IDirect3DRMViewport2 ptr, byval as LPDIRECT3DVIEWPORT ptr) as HRESULT
	TransformVectors as function(byval as IDirect3DRMViewport2 ptr, byval as DWORD, byval as LPD3DRMVECTOR4D, byval as LPD3DVECTOR) as HRESULT
	InverseTransformVectors as function(byval as IDirect3DRMViewport2 ptr, byval as DWORD, byval as LPD3DVECTOR, byval as LPD3DRMVECTOR4D) as HRESULT
end type

type IDirect3DRMFrameVtbl_ as IDirect3DRMFrameVtbl

type IDirect3DRMFrame
	lpVtbl as IDirect3DRMFrameVtbl_ ptr
end type

type IDirect3DRMFrameVtbl
	QueryInterface as function(byval as IDirect3DRMFrame ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMFrame ptr) as ULONG
	Release as function(byval as IDirect3DRMFrame ptr) as ULONG
	Clone as function(byval as IDirect3DRMFrame ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddDestroyCallback as function(byval as IDirect3DRMFrame ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMFrame ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	SetAppData as function(byval as IDirect3DRMFrame ptr, byval as DWORD) as HRESULT
	GetAppData as function(byval as IDirect3DRMFrame ptr) as DWORD
	SetName as function(byval as IDirect3DRMFrame ptr, byval as LPCSTR) as HRESULT
	GetName as function(byval as IDirect3DRMFrame ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	GetClassNameA as function(byval as IDirect3DRMFrame ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	AddChild as function(byval as IDirect3DRMFrame ptr, byval as LPDIRECT3DRMFRAME) as HRESULT
	AddLight as function(byval as IDirect3DRMFrame ptr, byval as LPDIRECT3DRMLIGHT) as HRESULT
	AddMoveCallback as function(byval as IDirect3DRMFrame ptr, byval as D3DRMFRAMEMOVECALLBACK, byval as any ptr) as HRESULT
	AddTransform as function(byval as IDirect3DRMFrame ptr, byval as D3DRMCOMBINETYPE, byval as D3DRMMATRIX4D) as HRESULT
	AddTranslation as function(byval as IDirect3DRMFrame ptr, byval as D3DRMCOMBINETYPE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	AddScale as function(byval as IDirect3DRMFrame ptr, byval as D3DRMCOMBINETYPE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	AddRotation as function(byval as IDirect3DRMFrame ptr, byval as D3DRMCOMBINETYPE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	AddVisual as function(byval as IDirect3DRMFrame ptr, byval as LPDIRECT3DRMVISUAL) as HRESULT
	GetChildren as function(byval as IDirect3DRMFrame ptr, byval as LPDIRECT3DRMFRAMEARRAY ptr) as HRESULT
	GetColor as function(byval as IDirect3DRMFrame ptr) as D3DCOLOR
	GetLights as function(byval as IDirect3DRMFrame ptr, byval as LPDIRECT3DRMLIGHTARRAY ptr) as HRESULT
	GetMaterialMode as function(byval as IDirect3DRMFrame ptr) as D3DRMMATERIALMODE
	GetParent as function(byval as IDirect3DRMFrame ptr, byval as LPDIRECT3DRMFRAME ptr) as HRESULT
	GetPosition as function(byval as IDirect3DRMFrame ptr, byval as LPDIRECT3DRMFRAME, byval as LPD3DVECTOR) as HRESULT
	GetRotation as function(byval as IDirect3DRMFrame ptr, byval as LPDIRECT3DRMFRAME, byval as LPD3DVECTOR, byval as LPD3DVALUE) as HRESULT
	GetScene as function(byval as IDirect3DRMFrame ptr, byval as LPDIRECT3DRMFRAME ptr) as HRESULT
	GetSortMode as function(byval as IDirect3DRMFrame ptr) as D3DRMSORTMODE
	GetTexture as function(byval as IDirect3DRMFrame ptr, byval as LPDIRECT3DRMTEXTURE ptr) as HRESULT
	GetTransform as function(byval as IDirect3DRMFrame ptr, byval as D3DRMMATRIX4D) as HRESULT
	GetVelocity as function(byval as IDirect3DRMFrame ptr, byval as LPDIRECT3DRMFRAME, byval as LPD3DVECTOR, byval as BOOL) as HRESULT
	GetOrientation as function(byval as IDirect3DRMFrame ptr, byval as LPDIRECT3DRMFRAME, byval as LPD3DVECTOR, byval as LPD3DVECTOR) as HRESULT
	GetVisuals as function(byval as IDirect3DRMFrame ptr, byval as LPDIRECT3DRMVISUALARRAY ptr) as HRESULT
	GetTextureTopology as function(byval as IDirect3DRMFrame ptr, byval as BOOL ptr, byval as BOOL ptr) as HRESULT
	InverseTransform as function(byval as IDirect3DRMFrame ptr, byval as D3DVECTOR ptr, byval as D3DVECTOR ptr) as HRESULT
	Load as function(byval as IDirect3DRMFrame ptr, byval as LPVOID, byval as LPVOID, byval as D3DRMLOADOPTIONS, byval as D3DRMLOADTEXTURECALLBACK, byval as LPVOID) as HRESULT
	LookAt as function(byval as IDirect3DRMFrame ptr, byval as LPDIRECT3DRMFRAME, byval as LPDIRECT3DRMFRAME, byval as D3DRMFRAMECONSTRAINT) as HRESULT
	Move as function(byval as IDirect3DRMFrame ptr, byval as D3DVALUE) as HRESULT
	DeleteChild as function(byval as IDirect3DRMFrame ptr, byval as LPDIRECT3DRMFRAME) as HRESULT
	DeleteLight as function(byval as IDirect3DRMFrame ptr, byval as LPDIRECT3DRMLIGHT) as HRESULT
	DeleteMoveCallback as function(byval as IDirect3DRMFrame ptr, byval as D3DRMFRAMEMOVECALLBACK, byval as any ptr) as HRESULT
	DeleteVisual as function(byval as IDirect3DRMFrame ptr, byval as LPDIRECT3DRMVISUAL) as HRESULT
	GetSceneBackground as function(byval as IDirect3DRMFrame ptr) as D3DCOLOR
	GetSceneBackgroundDepth as function(byval as IDirect3DRMFrame ptr, byval as LPDIRECTDRAWSURFACE ptr) as HRESULT
	GetSceneFogColor as function(byval as IDirect3DRMFrame ptr) as D3DCOLOR
	GetSceneFogEnable as function(byval as IDirect3DRMFrame ptr) as BOOL
	GetSceneFogMode as function(byval as IDirect3DRMFrame ptr) as D3DRMFOGMODE
	GetSceneFogParams as function(byval as IDirect3DRMFrame ptr, byval as D3DVALUE ptr, byval as D3DVALUE ptr, byval as D3DVALUE ptr) as HRESULT
	SetSceneBackground as function(byval as IDirect3DRMFrame ptr, byval as D3DCOLOR) as HRESULT
	SetSceneBackgroundRGB as function(byval as IDirect3DRMFrame ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetSceneBackgroundDepth as function(byval as IDirect3DRMFrame ptr, byval as LPDIRECTDRAWSURFACE) as HRESULT
	SetSceneBackgroundImage as function(byval as IDirect3DRMFrame ptr, byval as LPDIRECT3DRMTEXTURE) as HRESULT
	SetSceneFogEnable as function(byval as IDirect3DRMFrame ptr, byval as BOOL) as HRESULT
	SetSceneFogColor as function(byval as IDirect3DRMFrame ptr, byval as D3DCOLOR) as HRESULT
	SetSceneFogMode as function(byval as IDirect3DRMFrame ptr, byval as D3DRMFOGMODE) as HRESULT
	SetSceneFogParams as function(byval as IDirect3DRMFrame ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetColor as function(byval as IDirect3DRMFrame ptr, byval as D3DCOLOR) as HRESULT
	SetColorRGB as function(byval as IDirect3DRMFrame ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	GetZbufferMode as function(byval as IDirect3DRMFrame ptr) as D3DRMZBUFFERMODE
	SetMaterialMode as function(byval as IDirect3DRMFrame ptr, byval as D3DRMMATERIALMODE) as HRESULT
	SetOrientation as function(byval as IDirect3DRMFrame ptr, byval as LPDIRECT3DRMFRAME, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetPosition as function(byval as IDirect3DRMFrame ptr, byval as LPDIRECT3DRMFRAME, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetRotation as function(byval as IDirect3DRMFrame ptr, byval as LPDIRECT3DRMFRAME, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetSortMode as function(byval as IDirect3DRMFrame ptr, byval as D3DRMSORTMODE) as HRESULT
	SetTexture as function(byval as IDirect3DRMFrame ptr, byval as LPDIRECT3DRMTEXTURE) as HRESULT
	SetTextureTopology as function(byval as IDirect3DRMFrame ptr, byval as BOOL, byval as BOOL) as HRESULT
	SetVelocity as function(byval as IDirect3DRMFrame ptr, byval as LPDIRECT3DRMFRAME, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as BOOL) as HRESULT
	SetZbufferMode as function(byval as IDirect3DRMFrame ptr, byval as D3DRMZBUFFERMODE) as HRESULT
	Transform as function(byval as IDirect3DRMFrame ptr, byval as D3DVECTOR ptr, byval as D3DVECTOR ptr) as HRESULT
end type

type IDirect3DRMFrame2Vtbl_ as IDirect3DRMFrame2Vtbl

type IDirect3DRMFrame2
	lpVtbl as IDirect3DRMFrame2Vtbl_ ptr
end type

type IDirect3DRMFrame2Vtbl
	QueryInterface as function(byval as IDirect3DRMFrame2 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMFrame2 ptr) as ULONG
	Release as function(byval as IDirect3DRMFrame2 ptr) as ULONG
	Clone as function(byval as IDirect3DRMFrame2 ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddDestroyCallback as function(byval as IDirect3DRMFrame2 ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMFrame2 ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	SetAppData as function(byval as IDirect3DRMFrame2 ptr, byval as DWORD) as HRESULT
	GetAppData as function(byval as IDirect3DRMFrame2 ptr) as DWORD
	SetName as function(byval as IDirect3DRMFrame2 ptr, byval as LPCSTR) as HRESULT
	GetName as function(byval as IDirect3DRMFrame2 ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	GetClassNameA as function(byval as IDirect3DRMFrame2 ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	AddChild as function(byval as IDirect3DRMFrame2 ptr, byval as LPDIRECT3DRMFRAME) as HRESULT
	AddLight as function(byval as IDirect3DRMFrame2 ptr, byval as LPDIRECT3DRMLIGHT) as HRESULT
	AddMoveCallback as function(byval as IDirect3DRMFrame2 ptr, byval as D3DRMFRAMEMOVECALLBACK, byval as any ptr) as HRESULT
	AddTransform as function(byval as IDirect3DRMFrame2 ptr, byval as D3DRMCOMBINETYPE, byval as D3DRMMATRIX4D) as HRESULT
	AddTranslation as function(byval as IDirect3DRMFrame2 ptr, byval as D3DRMCOMBINETYPE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	AddScale as function(byval as IDirect3DRMFrame2 ptr, byval as D3DRMCOMBINETYPE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	AddRotation as function(byval as IDirect3DRMFrame2 ptr, byval as D3DRMCOMBINETYPE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	AddVisual as function(byval as IDirect3DRMFrame2 ptr, byval as LPDIRECT3DRMVISUAL) as HRESULT
	GetChildren as function(byval as IDirect3DRMFrame2 ptr, byval as LPDIRECT3DRMFRAMEARRAY ptr) as HRESULT
	GetColor as function(byval as IDirect3DRMFrame2 ptr) as D3DCOLOR
	GetLights as function(byval as IDirect3DRMFrame2 ptr, byval as LPDIRECT3DRMLIGHTARRAY ptr) as HRESULT
	GetMaterialMode as function(byval as IDirect3DRMFrame2 ptr) as D3DRMMATERIALMODE
	GetParent as function(byval as IDirect3DRMFrame2 ptr, byval as LPDIRECT3DRMFRAME ptr) as HRESULT
	GetPosition as function(byval as IDirect3DRMFrame2 ptr, byval as LPDIRECT3DRMFRAME, byval as LPD3DVECTOR) as HRESULT
	GetRotation as function(byval as IDirect3DRMFrame2 ptr, byval as LPDIRECT3DRMFRAME, byval as LPD3DVECTOR, byval as LPD3DVALUE) as HRESULT
	GetScene as function(byval as IDirect3DRMFrame2 ptr, byval as LPDIRECT3DRMFRAME ptr) as HRESULT
	GetSortMode as function(byval as IDirect3DRMFrame2 ptr) as D3DRMSORTMODE
	GetTexture as function(byval as IDirect3DRMFrame2 ptr, byval as LPDIRECT3DRMTEXTURE ptr) as HRESULT
	GetTransform as function(byval as IDirect3DRMFrame2 ptr, byval as D3DRMMATRIX4D) as HRESULT
	GetVelocity as function(byval as IDirect3DRMFrame2 ptr, byval as LPDIRECT3DRMFRAME, byval as LPD3DVECTOR, byval as BOOL) as HRESULT
	GetOrientation as function(byval as IDirect3DRMFrame2 ptr, byval as LPDIRECT3DRMFRAME, byval as LPD3DVECTOR, byval as LPD3DVECTOR) as HRESULT
	GetVisuals as function(byval as IDirect3DRMFrame2 ptr, byval as LPDIRECT3DRMVISUALARRAY ptr) as HRESULT
	GetTextureTopology as function(byval as IDirect3DRMFrame2 ptr, byval as BOOL ptr, byval as BOOL ptr) as HRESULT
	InverseTransform as function(byval as IDirect3DRMFrame2 ptr, byval as D3DVECTOR ptr, byval as D3DVECTOR ptr) as HRESULT
	Load as function(byval as IDirect3DRMFrame2 ptr, byval as LPVOID, byval as LPVOID, byval as D3DRMLOADOPTIONS, byval as D3DRMLOADTEXTURECALLBACK, byval as LPVOID) as HRESULT
	LookAt as function(byval as IDirect3DRMFrame2 ptr, byval as LPDIRECT3DRMFRAME, byval as LPDIRECT3DRMFRAME, byval as D3DRMFRAMECONSTRAINT) as HRESULT
	Move as function(byval as IDirect3DRMFrame2 ptr, byval as D3DVALUE) as HRESULT
	DeleteChild as function(byval as IDirect3DRMFrame2 ptr, byval as LPDIRECT3DRMFRAME) as HRESULT
	DeleteLight as function(byval as IDirect3DRMFrame2 ptr, byval as LPDIRECT3DRMLIGHT) as HRESULT
	DeleteMoveCallback as function(byval as IDirect3DRMFrame2 ptr, byval as D3DRMFRAMEMOVECALLBACK, byval as any ptr) as HRESULT
	DeleteVisual as function(byval as IDirect3DRMFrame2 ptr, byval as LPDIRECT3DRMVISUAL) as HRESULT
	GetSceneBackground as function(byval as IDirect3DRMFrame2 ptr) as D3DCOLOR
	GetSceneBackgroundDepth as function(byval as IDirect3DRMFrame2 ptr, byval as LPDIRECTDRAWSURFACE ptr) as HRESULT
	GetSceneFogColor as function(byval as IDirect3DRMFrame2 ptr) as D3DCOLOR
	GetSceneFogEnable as function(byval as IDirect3DRMFrame2 ptr) as BOOL
	GetSceneFogMode as function(byval as IDirect3DRMFrame2 ptr) as D3DRMFOGMODE
	GetSceneFogParams as function(byval as IDirect3DRMFrame2 ptr, byval as D3DVALUE ptr, byval as D3DVALUE ptr, byval as D3DVALUE ptr) as HRESULT
	SetSceneBackground as function(byval as IDirect3DRMFrame2 ptr, byval as D3DCOLOR) as HRESULT
	SetSceneBackgroundRGB as function(byval as IDirect3DRMFrame2 ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetSceneBackgroundDepth as function(byval as IDirect3DRMFrame2 ptr, byval as LPDIRECTDRAWSURFACE) as HRESULT
	SetSceneBackgroundImage as function(byval as IDirect3DRMFrame2 ptr, byval as LPDIRECT3DRMTEXTURE) as HRESULT
	SetSceneFogEnable as function(byval as IDirect3DRMFrame2 ptr, byval as BOOL) as HRESULT
	SetSceneFogColor as function(byval as IDirect3DRMFrame2 ptr, byval as D3DCOLOR) as HRESULT
	SetSceneFogMode as function(byval as IDirect3DRMFrame2 ptr, byval as D3DRMFOGMODE) as HRESULT
	SetSceneFogParams as function(byval as IDirect3DRMFrame2 ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetColor as function(byval as IDirect3DRMFrame2 ptr, byval as D3DCOLOR) as HRESULT
	SetColorRGB as function(byval as IDirect3DRMFrame2 ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	GetZbufferMode as function(byval as IDirect3DRMFrame2 ptr) as D3DRMZBUFFERMODE
	SetMaterialMode as function(byval as IDirect3DRMFrame2 ptr, byval as D3DRMMATERIALMODE) as HRESULT
	SetOrientation as function(byval as IDirect3DRMFrame2 ptr, byval as LPDIRECT3DRMFRAME, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetPosition as function(byval as IDirect3DRMFrame2 ptr, byval as LPDIRECT3DRMFRAME, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetRotation as function(byval as IDirect3DRMFrame2 ptr, byval as LPDIRECT3DRMFRAME, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetSortMode as function(byval as IDirect3DRMFrame2 ptr, byval as D3DRMSORTMODE) as HRESULT
	SetTexture as function(byval as IDirect3DRMFrame2 ptr, byval as LPDIRECT3DRMTEXTURE) as HRESULT
	SetTextureTopology as function(byval as IDirect3DRMFrame2 ptr, byval as BOOL, byval as BOOL) as HRESULT
	SetVelocity as function(byval as IDirect3DRMFrame2 ptr, byval as LPDIRECT3DRMFRAME, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as BOOL) as HRESULT
	SetZbufferMode as function(byval as IDirect3DRMFrame2 ptr, byval as D3DRMZBUFFERMODE) as HRESULT
	Transform as function(byval as IDirect3DRMFrame2 ptr, byval as D3DVECTOR ptr, byval as D3DVECTOR ptr) as HRESULT
	AddMoveCallback2 as function(byval as IDirect3DRMFrame2 ptr, byval as D3DRMFRAMEMOVECALLBACK, byval as any ptr, byval as DWORD) as HRESULT
	GetBox as function(byval as IDirect3DRMFrame2 ptr, byval as LPD3DRMBOX) as HRESULT
	GetBoxEnable as function(byval as IDirect3DRMFrame2 ptr) as BOOL
	GetAxes as function(byval as IDirect3DRMFrame2 ptr, byval as LPD3DVECTOR, byval as LPD3DVECTOR) as HRESULT
	GetMaterial as function(byval as IDirect3DRMFrame2 ptr, byval as LPDIRECT3DRMMATERIAL ptr) as HRESULT
	GetInheritAxes as function(byval as IDirect3DRMFrame2 ptr) as BOOL
	GetHierarchyBox as function(byval as IDirect3DRMFrame2 ptr, byval as LPD3DRMBOX) as HRESULT
	SetBox as function(byval as IDirect3DRMFrame2 ptr, byval as LPD3DRMBOX) as HRESULT
	SetBoxEnable as function(byval as IDirect3DRMFrame2 ptr, byval as BOOL) as HRESULT
	SetAxes as function(byval as IDirect3DRMFrame2 ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetInheritAxes as function(byval as IDirect3DRMFrame2 ptr, byval as BOOL) as HRESULT
	SetMaterial as function(byval as IDirect3DRMFrame2 ptr, byval as LPDIRECT3DRMMATERIAL) as HRESULT
	SetQuaternion as function(byval as IDirect3DRMFrame2 ptr, byval as LPDIRECT3DRMFRAME, byval as D3DRMQUATERNION ptr) as HRESULT
	RayPick as function(byval as IDirect3DRMFrame2 ptr, byval as LPDIRECT3DRMFRAME, byval as LPD3DRMRAY, byval as DWORD, byval as LPDIRECT3DRMPICKED2ARRAY ptr) as HRESULT
	Save as function(byval as IDirect3DRMFrame2 ptr, byval as LPCSTR, byval as D3DRMXOFFORMAT, byval as D3DRMSAVEOPTIONS) as HRESULT
end type

type IDirect3DRMFrame3Vtbl_ as IDirect3DRMFrame3Vtbl

type IDirect3DRMFrame3
	lpVtbl as IDirect3DRMFrame3Vtbl_ ptr
end type

type IDirect3DRMFrame3Vtbl
	QueryInterface as function(byval as IDirect3DRMFrame3 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMFrame3 ptr) as ULONG
	Release as function(byval as IDirect3DRMFrame3 ptr) as ULONG
	Clone as function(byval as IDirect3DRMFrame3 ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddDestroyCallback as function(byval as IDirect3DRMFrame3 ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMFrame3 ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	SetAppData as function(byval as IDirect3DRMFrame3 ptr, byval as DWORD) as HRESULT
	GetAppData as function(byval as IDirect3DRMFrame3 ptr) as DWORD
	SetName as function(byval as IDirect3DRMFrame3 ptr, byval as LPCSTR) as HRESULT
	GetName as function(byval as IDirect3DRMFrame3 ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	GetClassNameA as function(byval as IDirect3DRMFrame3 ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	AddChild as function(byval as IDirect3DRMFrame3 ptr, byval as LPDIRECT3DRMFRAME3) as HRESULT
	AddLight as function(byval as IDirect3DRMFrame3 ptr, byval as LPDIRECT3DRMLIGHT) as HRESULT
	AddMoveCallback as function(byval as IDirect3DRMFrame3 ptr, byval as D3DRMFRAME3MOVECALLBACK, byval as any ptr, byval as DWORD) as HRESULT
	AddTransform as function(byval as IDirect3DRMFrame3 ptr, byval as D3DRMCOMBINETYPE, byval as D3DRMMATRIX4D) as HRESULT
	AddTranslation as function(byval as IDirect3DRMFrame3 ptr, byval as D3DRMCOMBINETYPE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	AddScale as function(byval as IDirect3DRMFrame3 ptr, byval as D3DRMCOMBINETYPE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	AddRotation as function(byval as IDirect3DRMFrame3 ptr, byval as D3DRMCOMBINETYPE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	AddVisual as function(byval as IDirect3DRMFrame3 ptr, byval as LPUNKNOWN) as HRESULT
	GetChildren as function(byval as IDirect3DRMFrame3 ptr, byval as LPDIRECT3DRMFRAMEARRAY ptr) as HRESULT
	GetColor as function(byval as IDirect3DRMFrame3 ptr) as D3DCOLOR
	GetLights as function(byval as IDirect3DRMFrame3 ptr, byval as LPDIRECT3DRMLIGHTARRAY ptr) as HRESULT
	GetMaterialMode as function(byval as IDirect3DRMFrame3 ptr) as D3DRMMATERIALMODE
	GetParent as function(byval as IDirect3DRMFrame3 ptr, byval as LPDIRECT3DRMFRAME3 ptr) as HRESULT
	GetPosition as function(byval as IDirect3DRMFrame3 ptr, byval as LPDIRECT3DRMFRAME3, byval as LPD3DVECTOR) as HRESULT
	GetRotation as function(byval as IDirect3DRMFrame3 ptr, byval as LPDIRECT3DRMFRAME3, byval as LPD3DVECTOR, byval as LPD3DVALUE) as HRESULT
	GetScene as function(byval as IDirect3DRMFrame3 ptr, byval as LPDIRECT3DRMFRAME3 ptr) as HRESULT
	GetSortMode as function(byval as IDirect3DRMFrame3 ptr) as D3DRMSORTMODE
	GetTexture as function(byval as IDirect3DRMFrame3 ptr, byval as LPDIRECT3DRMTEXTURE3 ptr) as HRESULT
	GetTransform as function(byval as IDirect3DRMFrame3 ptr, byval as LPDIRECT3DRMFRAME3, byval as D3DRMMATRIX4D) as HRESULT
	GetVelocity as function(byval as IDirect3DRMFrame3 ptr, byval as LPDIRECT3DRMFRAME3, byval as LPD3DVECTOR, byval as BOOL) as HRESULT
	GetOrientation as function(byval as IDirect3DRMFrame3 ptr, byval as LPDIRECT3DRMFRAME3, byval as LPD3DVECTOR, byval as LPD3DVECTOR) as HRESULT
	GetVisuals as function(byval as IDirect3DRMFrame3 ptr, byval as LPDWORD, byval as LPUNKNOWN ptr) as HRESULT
	InverseTransform as function(byval as IDirect3DRMFrame3 ptr, byval as D3DVECTOR ptr, byval as D3DVECTOR ptr) as HRESULT
	Load as function(byval as IDirect3DRMFrame3 ptr, byval as LPVOID, byval as LPVOID, byval as D3DRMLOADOPTIONS, byval as D3DRMLOADTEXTURE3CALLBACK, byval as LPVOID) as HRESULT
	LookAt as function(byval as IDirect3DRMFrame3 ptr, byval as LPDIRECT3DRMFRAME3, byval as LPDIRECT3DRMFRAME3, byval as D3DRMFRAMECONSTRAINT) as HRESULT
	Move as function(byval as IDirect3DRMFrame3 ptr, byval as D3DVALUE) as HRESULT
	DeleteChild as function(byval as IDirect3DRMFrame3 ptr, byval as LPDIRECT3DRMFRAME3) as HRESULT
	DeleteLight as function(byval as IDirect3DRMFrame3 ptr, byval as LPDIRECT3DRMLIGHT) as HRESULT
	DeleteMoveCallback as function(byval as IDirect3DRMFrame3 ptr, byval as D3DRMFRAME3MOVECALLBACK, byval as any ptr) as HRESULT
	DeleteVisual as function(byval as IDirect3DRMFrame3 ptr, byval as LPUNKNOWN) as HRESULT
	GetSceneBackground as function(byval as IDirect3DRMFrame3 ptr) as D3DCOLOR
	GetSceneBackgroundDepth as function(byval as IDirect3DRMFrame3 ptr, byval as LPDIRECTDRAWSURFACE ptr) as HRESULT
	GetSceneFogColor as function(byval as IDirect3DRMFrame3 ptr) as D3DCOLOR
	GetSceneFogEnable as function(byval as IDirect3DRMFrame3 ptr) as BOOL
	GetSceneFogMode as function(byval as IDirect3DRMFrame3 ptr) as D3DRMFOGMODE
	GetSceneFogParams as function(byval as IDirect3DRMFrame3 ptr, byval as D3DVALUE ptr, byval as D3DVALUE ptr, byval as D3DVALUE ptr) as HRESULT
	SetSceneBackground as function(byval as IDirect3DRMFrame3 ptr, byval as D3DCOLOR) as HRESULT
	SetSceneBackgroundRGB as function(byval as IDirect3DRMFrame3 ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetSceneBackgroundDepth as function(byval as IDirect3DRMFrame3 ptr, byval as LPDIRECTDRAWSURFACE) as HRESULT
	SetSceneBackgroundImage as function(byval as IDirect3DRMFrame3 ptr, byval as LPDIRECT3DRMTEXTURE3) as HRESULT
	SetSceneFogEnable as function(byval as IDirect3DRMFrame3 ptr, byval as BOOL) as HRESULT
	SetSceneFogColor as function(byval as IDirect3DRMFrame3 ptr, byval as D3DCOLOR) as HRESULT
	SetSceneFogMode as function(byval as IDirect3DRMFrame3 ptr, byval as D3DRMFOGMODE) as HRESULT
	SetSceneFogParams as function(byval as IDirect3DRMFrame3 ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetColor as function(byval as IDirect3DRMFrame3 ptr, byval as D3DCOLOR) as HRESULT
	SetColorRGB as function(byval as IDirect3DRMFrame3 ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	GetZbufferMode as function(byval as IDirect3DRMFrame3 ptr) as D3DRMZBUFFERMODE
	SetMaterialMode as function(byval as IDirect3DRMFrame3 ptr, byval as D3DRMMATERIALMODE) as HRESULT
	SetOrientation as function(byval as IDirect3DRMFrame3 ptr, byval as LPDIRECT3DRMFRAME3, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetPosition as function(byval as IDirect3DRMFrame3 ptr, byval as LPDIRECT3DRMFRAME3, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetRotation as function(byval as IDirect3DRMFrame3 ptr, byval as LPDIRECT3DRMFRAME3, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetSortMode as function(byval as IDirect3DRMFrame3 ptr, byval as D3DRMSORTMODE) as HRESULT
	SetTexture as function(byval as IDirect3DRMFrame3 ptr, byval as LPDIRECT3DRMTEXTURE3) as HRESULT
	SetVelocity as function(byval as IDirect3DRMFrame3 ptr, byval as LPDIRECT3DRMFRAME3, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as BOOL) as HRESULT
	SetZbufferMode as function(byval as IDirect3DRMFrame3 ptr, byval as D3DRMZBUFFERMODE) as HRESULT
	Transform as function(byval as IDirect3DRMFrame3 ptr, byval as D3DVECTOR ptr, byval as D3DVECTOR ptr) as HRESULT
	GetBox as function(byval as IDirect3DRMFrame3 ptr, byval as LPD3DRMBOX) as HRESULT
	GetBoxEnable as function(byval as IDirect3DRMFrame3 ptr) as BOOL
	GetAxes as function(byval as IDirect3DRMFrame3 ptr, byval as LPD3DVECTOR, byval as LPD3DVECTOR) as HRESULT
	GetMaterial as function(byval as IDirect3DRMFrame3 ptr, byval as LPDIRECT3DRMMATERIAL2 ptr) as HRESULT
	GetInheritAxes as function(byval as IDirect3DRMFrame3 ptr) as BOOL
	GetHierarchyBox as function(byval as IDirect3DRMFrame3 ptr, byval as LPD3DRMBOX) as HRESULT
	SetBox as function(byval as IDirect3DRMFrame3 ptr, byval as LPD3DRMBOX) as HRESULT
	SetBoxEnable as function(byval as IDirect3DRMFrame3 ptr, byval as BOOL) as HRESULT
	SetAxes as function(byval as IDirect3DRMFrame3 ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetInheritAxes as function(byval as IDirect3DRMFrame3 ptr, byval as BOOL) as HRESULT
	SetMaterial as function(byval as IDirect3DRMFrame3 ptr, byval as LPDIRECT3DRMMATERIAL2) as HRESULT
	SetQuaternion as function(byval as IDirect3DRMFrame3 ptr, byval as LPDIRECT3DRMFRAME3, byval as D3DRMQUATERNION ptr) as HRESULT
	RayPick as function(byval as IDirect3DRMFrame3 ptr, byval as LPDIRECT3DRMFRAME3, byval as LPD3DRMRAY, byval as DWORD, byval as LPDIRECT3DRMPICKED2ARRAY ptr) as HRESULT
	Save as function(byval as IDirect3DRMFrame3 ptr, byval as LPCSTR, byval as D3DRMXOFFORMAT, byval as D3DRMSAVEOPTIONS) as HRESULT
	TransformVectors as function(byval as IDirect3DRMFrame3 ptr, byval as LPDIRECT3DRMFRAME3, byval as DWORD, byval as LPD3DVECTOR, byval as LPD3DVECTOR) as HRESULT
	InverseTransformVectors as function(byval as IDirect3DRMFrame3 ptr, byval as LPDIRECT3DRMFRAME3, byval as DWORD, byval as LPD3DVECTOR, byval as LPD3DVECTOR) as HRESULT
	SetTraversalOptions as function(byval as IDirect3DRMFrame3 ptr, byval as DWORD) as HRESULT
	GetTraversalOptions as function(byval as IDirect3DRMFrame3 ptr, byval as LPDWORD) as HRESULT
	SetSceneFogMethod as function(byval as IDirect3DRMFrame3 ptr, byval as DWORD) as HRESULT
	GetSceneFogMethod as function(byval as IDirect3DRMFrame3 ptr, byval as LPDWORD) as HRESULT
	SetMaterialOverride as function(byval as IDirect3DRMFrame3 ptr, byval as LPD3DRMMATERIALOVERRIDE) as HRESULT
	GetMaterialOverride as function(byval as IDirect3DRMFrame3 ptr, byval as LPD3DRMMATERIALOVERRIDE) as HRESULT
end type

type IDirect3DRMMeshVtbl_ as IDirect3DRMMeshVtbl

type IDirect3DRMMesh
	lpVtbl as IDirect3DRMMeshVtbl_ ptr
end type

type IDirect3DRMMeshVtbl
	QueryInterface as function(byval as IDirect3DRMMesh ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMMesh ptr) as ULONG
	Release as function(byval as IDirect3DRMMesh ptr) as ULONG
	Clone as function(byval as IDirect3DRMMesh ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddDestroyCallback as function(byval as IDirect3DRMMesh ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMMesh ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	SetAppData as function(byval as IDirect3DRMMesh ptr, byval as DWORD) as HRESULT
	GetAppData as function(byval as IDirect3DRMMesh ptr) as DWORD
	SetName as function(byval as IDirect3DRMMesh ptr, byval as LPCSTR) as HRESULT
	GetName as function(byval as IDirect3DRMMesh ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	GetClassNameA as function(byval as IDirect3DRMMesh ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	Scale as function(byval as IDirect3DRMMesh ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	Translate as function(byval as IDirect3DRMMesh ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	GetBox as function(byval as IDirect3DRMMesh ptr, byval as D3DRMBOX ptr) as HRESULT
	AddGroup as function(byval as IDirect3DRMMesh ptr, byval as uinteger, byval as uinteger, byval as uinteger, byval as uinteger ptr, byval as D3DRMGROUPINDEX ptr) as HRESULT
	SetVertices as function(byval as IDirect3DRMMesh ptr, byval as D3DRMGROUPINDEX, byval as uinteger, byval as uinteger, byval as D3DRMVERTEX ptr) as HRESULT
	SetGroupColor as function(byval as IDirect3DRMMesh ptr, byval as D3DRMGROUPINDEX, byval as D3DCOLOR) as HRESULT
	SetGroupColorRGB as function(byval as IDirect3DRMMesh ptr, byval as D3DRMGROUPINDEX, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetGroupMapping as function(byval as IDirect3DRMMesh ptr, byval as D3DRMGROUPINDEX, byval as D3DRMMAPPING) as HRESULT
	SetGroupQuality as function(byval as IDirect3DRMMesh ptr, byval as D3DRMGROUPINDEX, byval as D3DRMRENDERQUALITY) as HRESULT
	SetGroupMaterial as function(byval as IDirect3DRMMesh ptr, byval as D3DRMGROUPINDEX, byval as LPDIRECT3DRMMATERIAL) as HRESULT
	SetGroupTexture as function(byval as IDirect3DRMMesh ptr, byval as D3DRMGROUPINDEX, byval as LPDIRECT3DRMTEXTURE) as HRESULT
	GetGroupCount as function(byval as IDirect3DRMMesh ptr) as uinteger
	GetGroup as function(byval as IDirect3DRMMesh ptr, byval as D3DRMGROUPINDEX, byval as uinteger ptr, byval as uinteger ptr, byval as uinteger ptr, byval as DWORD ptr, byval as uinteger ptr) as HRESULT
	GetVertices as function(byval as IDirect3DRMMesh ptr, byval as D3DRMGROUPINDEX, byval as DWORD, byval as DWORD, byval as D3DRMVERTEX ptr) as HRESULT
	GetGroupColor as function(byval as IDirect3DRMMesh ptr, byval as D3DRMGROUPINDEX) as D3DCOLOR
	GetGroupMapping as function(byval as IDirect3DRMMesh ptr, byval as D3DRMGROUPINDEX) as D3DRMMAPPING
	GetGroupQuality as function(byval as IDirect3DRMMesh ptr, byval as D3DRMGROUPINDEX) as D3DRMRENDERQUALITY
	GetGroupMaterial as function(byval as IDirect3DRMMesh ptr, byval as D3DRMGROUPINDEX, byval as LPDIRECT3DRMMATERIAL ptr) as HRESULT
	GetGroupTexture as function(byval as IDirect3DRMMesh ptr, byval as D3DRMGROUPINDEX, byval as LPDIRECT3DRMTEXTURE ptr) as HRESULT
end type

type IDirect3DRMProgressiveMeshVtbl_ as IDirect3DRMProgressiveMeshVtbl

type IDirect3DRMProgressiveMesh
	lpVtbl as IDirect3DRMProgressiveMeshVtbl_ ptr
end type

type IDirect3DRMProgressiveMeshVtbl
	QueryInterface as function(byval as IDirect3DRMProgressiveMesh ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMProgressiveMesh ptr) as ULONG
	Release as function(byval as IDirect3DRMProgressiveMesh ptr) as ULONG
	Clone as function(byval as IDirect3DRMProgressiveMesh ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddDestroyCallback as function(byval as IDirect3DRMProgressiveMesh ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMProgressiveMesh ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	SetAppData as function(byval as IDirect3DRMProgressiveMesh ptr, byval as DWORD) as HRESULT
	GetAppData as function(byval as IDirect3DRMProgressiveMesh ptr) as DWORD
	SetName as function(byval as IDirect3DRMProgressiveMesh ptr, byval as LPCSTR) as HRESULT
	GetName as function(byval as IDirect3DRMProgressiveMesh ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	GetClassNameA as function(byval as IDirect3DRMProgressiveMesh ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	Load as function(byval as IDirect3DRMProgressiveMesh ptr, byval as LPVOID, byval as LPVOID, byval as D3DRMLOADOPTIONS, byval as D3DRMLOADTEXTURECALLBACK, byval as LPVOID) as HRESULT
	GetLoadStatus as function(byval as IDirect3DRMProgressiveMesh ptr, byval as LPD3DRMPMESHLOADSTATUS) as HRESULT
	SetMinRenderDetail as function(byval as IDirect3DRMProgressiveMesh ptr, byval as D3DVALUE) as HRESULT
	Abort as function(byval as IDirect3DRMProgressiveMesh ptr, byval as DWORD) as HRESULT
	GetFaceDetail as function(byval as IDirect3DRMProgressiveMesh ptr, byval as LPDWORD) as HRESULT
	GetVertexDetail as function(byval as IDirect3DRMProgressiveMesh ptr, byval as LPDWORD) as HRESULT
	SetFaceDetail as function(byval as IDirect3DRMProgressiveMesh ptr, byval as DWORD) as HRESULT
	SetVertexDetail as function(byval as IDirect3DRMProgressiveMesh ptr, byval as DWORD) as HRESULT
	GetFaceDetailRange as function(byval as IDirect3DRMProgressiveMesh ptr, byval as LPDWORD, byval as LPDWORD) as HRESULT
	GetVertexDetailRange as function(byval as IDirect3DRMProgressiveMesh ptr, byval as LPDWORD, byval as LPDWORD) as HRESULT
	GetDetail as function(byval as IDirect3DRMProgressiveMesh ptr, byval as D3DVALUE ptr) as HRESULT
	SetDetail as function(byval as IDirect3DRMProgressiveMesh ptr, byval as D3DVALUE) as HRESULT
	RegisterEvents as function(byval as IDirect3DRMProgressiveMesh ptr, byval as HANDLE, byval as DWORD, byval as DWORD) as HRESULT
	CreateMesh as function(byval as IDirect3DRMProgressiveMesh ptr, byval as LPDIRECT3DRMMESH ptr) as HRESULT
	Duplicate as function(byval as IDirect3DRMProgressiveMesh ptr, byval as LPDIRECT3DRMPROGRESSIVEMESH ptr) as HRESULT
	GetBox as function(byval as IDirect3DRMProgressiveMesh ptr, byval as LPD3DRMBOX) as HRESULT
	SetQuality as function(byval as IDirect3DRMProgressiveMesh ptr, byval as D3DRMRENDERQUALITY) as HRESULT
	GetQuality as function(byval as IDirect3DRMProgressiveMesh ptr, byval as LPD3DRMRENDERQUALITY) as HRESULT
end type

type IDirect3DRMShadowVtbl_ as IDirect3DRMShadowVtbl

type IDirect3DRMShadow
	lpVtbl as IDirect3DRMShadowVtbl_ ptr
end type

type IDirect3DRMShadowVtbl
	QueryInterface as function(byval as IDirect3DRMShadow ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMShadow ptr) as ULONG
	Release as function(byval as IDirect3DRMShadow ptr) as ULONG
	Clone as function(byval as IDirect3DRMShadow ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddDestroyCallback as function(byval as IDirect3DRMShadow ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMShadow ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	SetAppData as function(byval as IDirect3DRMShadow ptr, byval as DWORD) as HRESULT
	GetAppData as function(byval as IDirect3DRMShadow ptr) as DWORD
	SetName as function(byval as IDirect3DRMShadow ptr, byval as LPCSTR) as HRESULT
	GetName as function(byval as IDirect3DRMShadow ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	GetClassNameA as function(byval as IDirect3DRMShadow ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	Init as function(byval as IDirect3DRMShadow ptr, byval as LPDIRECT3DRMVISUAL, byval as LPDIRECT3DRMLIGHT, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
end type

type IDirect3DRMShadow2Vtbl_ as IDirect3DRMShadow2Vtbl

type IDirect3DRMShadow2
	lpVtbl as IDirect3DRMShadow2Vtbl_ ptr
end type

type IDirect3DRMShadow2Vtbl
	QueryInterface as function(byval as IDirect3DRMShadow2 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMShadow2 ptr) as ULONG
	Release as function(byval as IDirect3DRMShadow2 ptr) as ULONG
	Clone as function(byval as IDirect3DRMShadow2 ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddDestroyCallback as function(byval as IDirect3DRMShadow2 ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMShadow2 ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	SetAppData as function(byval as IDirect3DRMShadow2 ptr, byval as DWORD) as HRESULT
	GetAppData as function(byval as IDirect3DRMShadow2 ptr) as DWORD
	SetName as function(byval as IDirect3DRMShadow2 ptr, byval as LPCSTR) as HRESULT
	GetName as function(byval as IDirect3DRMShadow2 ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	GetClassNameA as function(byval as IDirect3DRMShadow2 ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	Init as function(byval as IDirect3DRMShadow2 ptr, byval as LPUNKNOWN, byval as LPDIRECT3DRMLIGHT, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	GetVisual as function(byval as IDirect3DRMShadow2 ptr, byval as LPDIRECT3DRMVISUAL ptr) as HRESULT
	SetVisual as function(byval as IDirect3DRMShadow2 ptr, byval as LPUNKNOWN, byval as DWORD) as HRESULT
	GetLight as function(byval as IDirect3DRMShadow2 ptr, byval as LPDIRECT3DRMLIGHT ptr) as HRESULT
	SetLight as function(byval as IDirect3DRMShadow2 ptr, byval as LPDIRECT3DRMLIGHT, byval as DWORD) as HRESULT
	GetPlane as function(byval as IDirect3DRMShadow2 ptr, byval as LPD3DVALUE, byval as LPD3DVALUE, byval as LPD3DVALUE, byval as LPD3DVALUE, byval as LPD3DVALUE, byval as LPD3DVALUE) as HRESULT
	SetPlane as function(byval as IDirect3DRMShadow2 ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as DWORD) as HRESULT
	GetOptions as function(byval as IDirect3DRMShadow2 ptr, byval as LPDWORD) as HRESULT
	SetOptions as function(byval as IDirect3DRMShadow2 ptr, byval as DWORD) as HRESULT
end type

type IDirect3DRMFaceVtbl_ as IDirect3DRMFaceVtbl

type IDirect3DRMFace
	lpVtbl as IDirect3DRMFaceVtbl_ ptr
end type

type IDirect3DRMFaceVtbl
	QueryInterface as function(byval as IDirect3DRMFace ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMFace ptr) as ULONG
	Release as function(byval as IDirect3DRMFace ptr) as ULONG
	Clone as function(byval as IDirect3DRMFace ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddDestroyCallback as function(byval as IDirect3DRMFace ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMFace ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	SetAppData as function(byval as IDirect3DRMFace ptr, byval as DWORD) as HRESULT
	GetAppData as function(byval as IDirect3DRMFace ptr) as DWORD
	SetName as function(byval as IDirect3DRMFace ptr, byval as LPCSTR) as HRESULT
	GetName as function(byval as IDirect3DRMFace ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	GetClassNameA as function(byval as IDirect3DRMFace ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	AddVertex as function(byval as IDirect3DRMFace ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	AddVertexAndNormalIndexed as function(byval as IDirect3DRMFace ptr, byval as DWORD, byval as DWORD) as HRESULT
	SetColorRGB as function(byval as IDirect3DRMFace ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetColor as function(byval as IDirect3DRMFace ptr, byval as D3DCOLOR) as HRESULT
	SetTexture as function(byval as IDirect3DRMFace ptr, byval as LPDIRECT3DRMTEXTURE) as HRESULT
	SetTextureCoordinates as function(byval as IDirect3DRMFace ptr, byval as DWORD, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetMaterial as function(byval as IDirect3DRMFace ptr, byval as LPDIRECT3DRMMATERIAL) as HRESULT
	SetTextureTopology as function(byval as IDirect3DRMFace ptr, byval as BOOL, byval as BOOL) as HRESULT
	GetVertex as function(byval as IDirect3DRMFace ptr, byval as DWORD, byval as D3DVECTOR ptr, byval as D3DVECTOR ptr) as HRESULT
	GetVertices as function(byval as IDirect3DRMFace ptr, byval as DWORD ptr, byval as D3DVECTOR ptr, byval as D3DVECTOR ptr) as HRESULT
	GetTextureCoordinates as function(byval as IDirect3DRMFace ptr, byval as DWORD, byval as D3DVALUE ptr, byval as D3DVALUE ptr) as HRESULT
	GetTextureTopology as function(byval as IDirect3DRMFace ptr, byval as BOOL ptr, byval as BOOL ptr) as HRESULT
	GetNormal as function(byval as IDirect3DRMFace ptr, byval as D3DVECTOR ptr) as HRESULT
	GetTexture as function(byval as IDirect3DRMFace ptr, byval as LPDIRECT3DRMTEXTURE ptr) as HRESULT
	GetMaterial as function(byval as IDirect3DRMFace ptr, byval as LPDIRECT3DRMMATERIAL ptr) as HRESULT
	GetVertexCount as function(byval as IDirect3DRMFace ptr) as integer
	GetVertexIndex as function(byval as IDirect3DRMFace ptr, byval as DWORD) as integer
	GetTextureCoordinateIndex as function(byval as IDirect3DRMFace ptr, byval as DWORD) as integer
	GetColor as function(byval as IDirect3DRMFace ptr) as D3DCOLOR
end type

type IDirect3DRMFace2Vtbl_ as IDirect3DRMFace2Vtbl

type IDirect3DRMFace2
	lpVtbl as IDirect3DRMFace2Vtbl_ ptr
end type

type IDirect3DRMFace2Vtbl
	QueryInterface as function(byval as IDirect3DRMFace2 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMFace2 ptr) as ULONG
	Release as function(byval as IDirect3DRMFace2 ptr) as ULONG
	Clone as function(byval as IDirect3DRMFace2 ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddDestroyCallback as function(byval as IDirect3DRMFace2 ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMFace2 ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	SetAppData as function(byval as IDirect3DRMFace2 ptr, byval as DWORD) as HRESULT
	GetAppData as function(byval as IDirect3DRMFace2 ptr) as DWORD
	SetName as function(byval as IDirect3DRMFace2 ptr, byval as LPCSTR) as HRESULT
	GetName as function(byval as IDirect3DRMFace2 ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	GetClassNameA as function(byval as IDirect3DRMFace2 ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	AddVertex as function(byval as IDirect3DRMFace2 ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	AddVertexAndNormalIndexed as function(byval as IDirect3DRMFace2 ptr, byval as DWORD, byval as DWORD) as HRESULT
	SetColorRGB as function(byval as IDirect3DRMFace2 ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetColor as function(byval as IDirect3DRMFace2 ptr, byval as D3DCOLOR) as HRESULT
	SetTexture as function(byval as IDirect3DRMFace2 ptr, byval as LPDIRECT3DRMTEXTURE3) as HRESULT
	SetTextureCoordinates as function(byval as IDirect3DRMFace2 ptr, byval as DWORD, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetMaterial as function(byval as IDirect3DRMFace2 ptr, byval as LPDIRECT3DRMMATERIAL2) as HRESULT
	SetTextureTopology as function(byval as IDirect3DRMFace2 ptr, byval as BOOL, byval as BOOL) as HRESULT
	GetVertex as function(byval as IDirect3DRMFace2 ptr, byval as DWORD, byval as D3DVECTOR ptr, byval as D3DVECTOR ptr) as HRESULT
	GetVertices as function(byval as IDirect3DRMFace2 ptr, byval as DWORD ptr, byval as D3DVECTOR ptr, byval as D3DVECTOR ptr) as HRESULT
	GetTextureCoordinates as function(byval as IDirect3DRMFace2 ptr, byval as DWORD, byval as D3DVALUE ptr, byval as D3DVALUE ptr) as HRESULT
	GetTextureTopology as function(byval as IDirect3DRMFace2 ptr, byval as BOOL ptr, byval as BOOL ptr) as HRESULT
	GetNormal as function(byval as IDirect3DRMFace2 ptr, byval as D3DVECTOR ptr) as HRESULT
	GetTexture as function(byval as IDirect3DRMFace2 ptr, byval as LPDIRECT3DRMTEXTURE3 ptr) as HRESULT
	GetMaterial as function(byval as IDirect3DRMFace2 ptr, byval as LPDIRECT3DRMMATERIAL2 ptr) as HRESULT
	GetVertexCount as function(byval as IDirect3DRMFace2 ptr) as integer
	GetVertexIndex as function(byval as IDirect3DRMFace2 ptr, byval as DWORD) as integer
	GetTextureCoordinateIndex as function(byval as IDirect3DRMFace2 ptr, byval as DWORD) as integer
	GetColor as function(byval as IDirect3DRMFace2 ptr) as D3DCOLOR
end type

type IDirect3DRMMeshBuilderVtbl_ as IDirect3DRMMeshBuilderVtbl

type IDirect3DRMMeshBuilder
	lpVtbl as IDirect3DRMMeshBuilderVtbl_ ptr
end type

type IDirect3DRMMeshBuilderVtbl
	QueryInterface as function(byval as IDirect3DRMMeshBuilder ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMMeshBuilder ptr) as ULONG
	Release as function(byval as IDirect3DRMMeshBuilder ptr) as ULONG
	Clone as function(byval as IDirect3DRMMeshBuilder ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddDestroyCallback as function(byval as IDirect3DRMMeshBuilder ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMMeshBuilder ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	SetAppData as function(byval as IDirect3DRMMeshBuilder ptr, byval as DWORD) as HRESULT
	GetAppData as function(byval as IDirect3DRMMeshBuilder ptr) as DWORD
	SetName as function(byval as IDirect3DRMMeshBuilder ptr, byval as LPCSTR) as HRESULT
	GetName as function(byval as IDirect3DRMMeshBuilder ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	GetClassNameA as function(byval as IDirect3DRMMeshBuilder ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	Load as function(byval as IDirect3DRMMeshBuilder ptr, byval as LPVOID, byval as LPVOID, byval as D3DRMLOADOPTIONS, byval as D3DRMLOADTEXTURECALLBACK, byval as LPVOID) as HRESULT
	Save as function(byval as IDirect3DRMMeshBuilder ptr, byval as zstring ptr, byval as D3DRMXOFFORMAT, byval as D3DRMSAVEOPTIONS) as HRESULT
	Scale as function(byval as IDirect3DRMMeshBuilder ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	Translate as function(byval as IDirect3DRMMeshBuilder ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetColorSource as function(byval as IDirect3DRMMeshBuilder ptr, byval as D3DRMCOLORSOURCE) as HRESULT
	GetBox as function(byval as IDirect3DRMMeshBuilder ptr, byval as D3DRMBOX ptr) as HRESULT
	GenerateNormals as function(byval as IDirect3DRMMeshBuilder ptr) as HRESULT
	GetColorSource as function(byval as IDirect3DRMMeshBuilder ptr) as D3DRMCOLORSOURCE
	AddMesh as function(byval as IDirect3DRMMeshBuilder ptr, byval as LPDIRECT3DRMMESH) as HRESULT
	AddMeshBuilder as function(byval as IDirect3DRMMeshBuilder ptr, byval as LPDIRECT3DRMMESHBUILDER) as HRESULT
	AddFrame as function(byval as IDirect3DRMMeshBuilder ptr, byval as LPDIRECT3DRMFRAME) as HRESULT
	AddFace as function(byval as IDirect3DRMMeshBuilder ptr, byval as LPDIRECT3DRMFACE) as HRESULT
	AddFaces as function(byval as IDirect3DRMMeshBuilder ptr, byval as DWORD, byval as D3DVECTOR ptr, byval as DWORD, byval as D3DVECTOR ptr, byval as DWORD ptr, byval as LPDIRECT3DRMFACEARRAY ptr) as HRESULT
	ReserveSpace as function(byval as IDirect3DRMMeshBuilder ptr, byval as DWORD, byval as DWORD, byval as DWORD) as HRESULT
	SetColorRGB as function(byval as IDirect3DRMMeshBuilder ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetColor as function(byval as IDirect3DRMMeshBuilder ptr, byval as D3DCOLOR) as HRESULT
	SetTexture as function(byval as IDirect3DRMMeshBuilder ptr, byval as LPDIRECT3DRMTEXTURE) as HRESULT
	SetMaterial as function(byval as IDirect3DRMMeshBuilder ptr, byval as LPDIRECT3DRMMATERIAL) as HRESULT
	SetTextureTopology as function(byval as IDirect3DRMMeshBuilder ptr, byval as BOOL, byval as BOOL) as HRESULT
	SetQuality as function(byval as IDirect3DRMMeshBuilder ptr, byval as D3DRMRENDERQUALITY) as HRESULT
	SetPerspective as function(byval as IDirect3DRMMeshBuilder ptr, byval as BOOL) as HRESULT
	SetVertex as function(byval as IDirect3DRMMeshBuilder ptr, byval as DWORD, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetNormal as function(byval as IDirect3DRMMeshBuilder ptr, byval as DWORD, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetTextureCoordinates as function(byval as IDirect3DRMMeshBuilder ptr, byval as DWORD, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetVertexColor as function(byval as IDirect3DRMMeshBuilder ptr, byval as DWORD, byval as D3DCOLOR) as HRESULT
	SetVertexColorRGB as function(byval as IDirect3DRMMeshBuilder ptr, byval as DWORD, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	GetFaces as function(byval as IDirect3DRMMeshBuilder ptr, byval as LPDIRECT3DRMFACEARRAY ptr) as HRESULT
	GetVertices as function(byval as IDirect3DRMMeshBuilder ptr, byval as DWORD ptr, byval as D3DVECTOR ptr, byval as DWORD ptr, byval as D3DVECTOR ptr, byval as DWORD ptr, byval as DWORD ptr) as HRESULT
	GetTextureCoordinates as function(byval as IDirect3DRMMeshBuilder ptr, byval as DWORD, byval as D3DVALUE ptr, byval as D3DVALUE ptr) as HRESULT
	AddVertex as function(byval as IDirect3DRMMeshBuilder ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as integer
	AddNormal as function(byval as IDirect3DRMMeshBuilder ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as integer
	CreateFace as function(byval as IDirect3DRMMeshBuilder ptr, byval as LPDIRECT3DRMFACE ptr) as HRESULT
	GetQuality as function(byval as IDirect3DRMMeshBuilder ptr) as D3DRMRENDERQUALITY
	GetPerspective as function(byval as IDirect3DRMMeshBuilder ptr) as BOOL
	GetFaceCount as function(byval as IDirect3DRMMeshBuilder ptr) as integer
	GetVertexCount as function(byval as IDirect3DRMMeshBuilder ptr) as integer
	GetVertexColor as function(byval as IDirect3DRMMeshBuilder ptr, byval as DWORD) as D3DCOLOR
	CreateMesh as function(byval as IDirect3DRMMeshBuilder ptr, byval as LPDIRECT3DRMMESH ptr) as HRESULT
end type

type IDirect3DRMMeshBuilder2Vtbl_ as IDirect3DRMMeshBuilder2Vtbl

type IDirect3DRMMeshBuilder2
	lpVtbl as IDirect3DRMMeshBuilder2Vtbl_ ptr
end type

type IDirect3DRMMeshBuilder2Vtbl
	QueryInterface as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMMeshBuilder2 ptr) as ULONG
	Release as function(byval as IDirect3DRMMeshBuilder2 ptr) as ULONG
	Clone as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddDestroyCallback as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	SetAppData as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as DWORD) as HRESULT
	GetAppData as function(byval as IDirect3DRMMeshBuilder2 ptr) as DWORD
	SetName as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as LPCSTR) as HRESULT
	GetName as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	GetClassNameA as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	Load as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as LPVOID, byval as LPVOID, byval as D3DRMLOADOPTIONS, byval as D3DRMLOADTEXTURECALLBACK, byval as LPVOID) as HRESULT
	Save as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as zstring ptr, byval as D3DRMXOFFORMAT, byval as D3DRMSAVEOPTIONS) as HRESULT
	Scale as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	Translate as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetColorSource as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as D3DRMCOLORSOURCE) as HRESULT
	GetBox as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as D3DRMBOX ptr) as HRESULT
	GenerateNormals as function(byval as IDirect3DRMMeshBuilder2 ptr) as HRESULT
	GetColorSource as function(byval as IDirect3DRMMeshBuilder2 ptr) as D3DRMCOLORSOURCE
	AddMesh as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as LPDIRECT3DRMMESH) as HRESULT
	AddMeshBuilder as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as LPDIRECT3DRMMESHBUILDER) as HRESULT
	AddFrame as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as LPDIRECT3DRMFRAME) as HRESULT
	AddFace as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as LPDIRECT3DRMFACE) as HRESULT
	AddFaces as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as DWORD, byval as D3DVECTOR ptr, byval as DWORD, byval as D3DVECTOR ptr, byval as DWORD ptr, byval as LPDIRECT3DRMFACEARRAY ptr) as HRESULT
	ReserveSpace as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as DWORD, byval as DWORD, byval as DWORD) as HRESULT
	SetColorRGB as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetColor as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as D3DCOLOR) as HRESULT
	SetTexture as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as LPDIRECT3DRMTEXTURE) as HRESULT
	SetMaterial as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as LPDIRECT3DRMMATERIAL) as HRESULT
	SetTextureTopology as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as BOOL, byval as BOOL) as HRESULT
	SetQuality as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as D3DRMRENDERQUALITY) as HRESULT
	SetPerspective as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as BOOL) as HRESULT
	SetVertex as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as DWORD, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetNormal as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as DWORD, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetTextureCoordinates as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as DWORD, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetVertexColor as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as DWORD, byval as D3DCOLOR) as HRESULT
	SetVertexColorRGB as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as DWORD, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	GetFaces as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as LPDIRECT3DRMFACEARRAY ptr) as HRESULT
	GetVertices as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as DWORD ptr, byval as D3DVECTOR ptr, byval as DWORD ptr, byval as D3DVECTOR ptr, byval as DWORD ptr, byval as DWORD ptr) as HRESULT
	GetTextureCoordinates as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as DWORD, byval as D3DVALUE ptr, byval as D3DVALUE ptr) as HRESULT
	AddVertex as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as integer
	AddNormal as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as integer
	CreateFace as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as LPDIRECT3DRMFACE ptr) as HRESULT
	GetQuality as function(byval as IDirect3DRMMeshBuilder2 ptr) as D3DRMRENDERQUALITY
	GetPerspective as function(byval as IDirect3DRMMeshBuilder2 ptr) as BOOL
	GetFaceCount as function(byval as IDirect3DRMMeshBuilder2 ptr) as integer
	GetVertexCount as function(byval as IDirect3DRMMeshBuilder2 ptr) as integer
	GetVertexColor as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as DWORD) as D3DCOLOR
	CreateMesh as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as LPDIRECT3DRMMESH ptr) as HRESULT
	GenerateNormals2 as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as D3DVALUE, byval as DWORD) as HRESULT
	GetFace as function(byval as IDirect3DRMMeshBuilder2 ptr, byval as DWORD, byval as LPDIRECT3DRMFACE ptr) as HRESULT
end type

type IDirect3DRMMeshBuilder3Vtbl_ as IDirect3DRMMeshBuilder3Vtbl

type IDirect3DRMMeshBuilder3
	lpVtbl as IDirect3DRMMeshBuilder3Vtbl_ ptr
end type

type IDirect3DRMMeshBuilder3Vtbl
	QueryInterface as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMMeshBuilder3 ptr) as ULONG
	Release as function(byval as IDirect3DRMMeshBuilder3 ptr) as ULONG
	Clone as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddDestroyCallback as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	SetAppData as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as DWORD) as HRESULT
	GetAppData as function(byval as IDirect3DRMMeshBuilder3 ptr) as DWORD
	SetName as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as LPCSTR) as HRESULT
	GetName as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	GetClassNameA as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	Load as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as LPVOID, byval as LPVOID, byval as D3DRMLOADOPTIONS, byval as D3DRMLOADTEXTURE3CALLBACK, byval as LPVOID) as HRESULT
	Save as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as zstring ptr, byval as D3DRMXOFFORMAT, byval as D3DRMSAVEOPTIONS) as HRESULT
	Scale as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	Translate as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetColorSource as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as D3DRMCOLORSOURCE) as HRESULT
	GetBox as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as D3DRMBOX ptr) as HRESULT
	GenerateNormals as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as D3DVALUE, byval as DWORD) as HRESULT
	GetColorSource as function(byval as IDirect3DRMMeshBuilder3 ptr) as D3DRMCOLORSOURCE
	AddMesh as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as LPDIRECT3DRMMESH) as HRESULT
	AddMeshBuilder as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as LPDIRECT3DRMMESHBUILDER3, byval as DWORD) as HRESULT
	AddFrame as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as LPDIRECT3DRMFRAME3) as HRESULT
	AddFace as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as LPDIRECT3DRMFACE2) as HRESULT
	AddFaces as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as DWORD, byval as D3DVECTOR ptr, byval as DWORD, byval as D3DVECTOR ptr, byval as DWORD ptr, byval as LPDIRECT3DRMFACEARRAY ptr) as HRESULT
	ReserveSpace as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as DWORD, byval as DWORD, byval as DWORD) as HRESULT
	SetColorRGB as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetColor as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as D3DCOLOR) as HRESULT
	SetTexture as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as LPDIRECT3DRMTEXTURE3) as HRESULT
	SetMaterial as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as LPDIRECT3DRMMATERIAL2) as HRESULT
	SetTextureTopology as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as BOOL, byval as BOOL) as HRESULT
	SetQuality as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as D3DRMRENDERQUALITY) as HRESULT
	SetPerspective as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as BOOL) as HRESULT
	SetVertex as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as DWORD, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetNormal as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as DWORD, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetTextureCoordinates as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as DWORD, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetVertexColor as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as DWORD, byval as D3DCOLOR) as HRESULT
	SetVertexColorRGB as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as DWORD, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	GetFaces as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as LPDIRECT3DRMFACEARRAY ptr) as HRESULT
	GetGeometry as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as DWORD ptr, byval as D3DVECTOR ptr, byval as DWORD ptr, byval as D3DVECTOR ptr, byval as DWORD ptr, byval as DWORD ptr) as HRESULT
	GetTextureCoordinates as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as DWORD, byval as D3DVALUE ptr, byval as D3DVALUE ptr) as HRESULT
	AddVertex as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as integer
	AddNormal as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as integer
	CreateFace as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as LPDIRECT3DRMFACE2 ptr) as HRESULT
	GetQuality as function(byval as IDirect3DRMMeshBuilder3 ptr) as D3DRMRENDERQUALITY
	GetPerspective as function(byval as IDirect3DRMMeshBuilder3 ptr) as BOOL
	GetFaceCount as function(byval as IDirect3DRMMeshBuilder3 ptr) as integer
	GetVertexCount as function(byval as IDirect3DRMMeshBuilder3 ptr) as integer
	GetVertexColor as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as DWORD) as D3DCOLOR
	CreateMesh as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as LPDIRECT3DRMMESH ptr) as HRESULT
	GetFace as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as DWORD, byval as LPDIRECT3DRMFACE2 ptr) as HRESULT
	GetVertex as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as DWORD, byval as LPD3DVECTOR) as HRESULT
	GetNormal as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as DWORD, byval as LPD3DVECTOR) as HRESULT
	DeleteVertices as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as DWORD, byval as DWORD) as HRESULT
	DeleteNormals as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as DWORD, byval as DWORD) as HRESULT
	DeleteFace as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as LPDIRECT3DRMFACE2) as HRESULT
	Empty as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as DWORD) as HRESULT
	Optimize as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as DWORD) as HRESULT
	AddFacesIndexed as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as DWORD, byval as DWORD ptr, byval as DWORD ptr, byval as DWORD ptr) as HRESULT
	CreateSubMesh as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as LPUNKNOWN ptr) as HRESULT
	GetParentMesh as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as DWORD, byval as LPUNKNOWN ptr) as HRESULT
	GetSubMeshes as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as LPDWORD, byval as LPUNKNOWN ptr) as HRESULT
	DeleteSubMesh as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as LPUNKNOWN) as HRESULT
	Enable as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as DWORD) as HRESULT
	GetEnable as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as DWORD ptr) as HRESULT
	AddTriangles as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as DWORD, byval as DWORD, byval as DWORD, byval as LPVOID) as HRESULT
	SetVertices as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as DWORD, byval as DWORD, byval as LPD3DVECTOR) as HRESULT
	GetVertices as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as DWORD, byval as LPDWORD, byval as LPD3DVECTOR) as HRESULT
	SetNormals as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as DWORD, byval as DWORD, byval as LPD3DVECTOR) as HRESULT
	GetNormals as function(byval as IDirect3DRMMeshBuilder3 ptr, byval as DWORD, byval as LPDWORD, byval as LPD3DVECTOR) as HRESULT
	GetNormalCount as function(byval as IDirect3DRMMeshBuilder3 ptr) as integer
end type

type IDirect3DRMLightVtbl_ as IDirect3DRMLightVtbl

type IDirect3DRMLight
	lpVtbl as IDirect3DRMLightVtbl_ ptr
end type

type IDirect3DRMLightVtbl
	QueryInterface as function(byval as IDirect3DRMLight ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMLight ptr) as ULONG
	Release as function(byval as IDirect3DRMLight ptr) as ULONG
	Clone as function(byval as IDirect3DRMLight ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddDestroyCallback as function(byval as IDirect3DRMLight ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMLight ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	SetAppData as function(byval as IDirect3DRMLight ptr, byval as DWORD) as HRESULT
	GetAppData as function(byval as IDirect3DRMLight ptr) as DWORD
	SetName as function(byval as IDirect3DRMLight ptr, byval as LPCSTR) as HRESULT
	GetName as function(byval as IDirect3DRMLight ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	GetClassNameA as function(byval as IDirect3DRMLight ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	SetType as function(byval as IDirect3DRMLight ptr, byval as D3DRMLIGHTTYPE) as HRESULT
	SetColor as function(byval as IDirect3DRMLight ptr, byval as D3DCOLOR) as HRESULT
	SetColorRGB as function(byval as IDirect3DRMLight ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetRange as function(byval as IDirect3DRMLight ptr, byval as D3DVALUE) as HRESULT
	SetUmbra as function(byval as IDirect3DRMLight ptr, byval as D3DVALUE) as HRESULT
	SetPenumbra as function(byval as IDirect3DRMLight ptr, byval as D3DVALUE) as HRESULT
	SetConstantAttenuation as function(byval as IDirect3DRMLight ptr, byval as D3DVALUE) as HRESULT
	SetLinearAttenuation as function(byval as IDirect3DRMLight ptr, byval as D3DVALUE) as HRESULT
	SetQuadraticAttenuation as function(byval as IDirect3DRMLight ptr, byval as D3DVALUE) as HRESULT
	GetRange as function(byval as IDirect3DRMLight ptr) as D3DVALUE
	GetUmbra as function(byval as IDirect3DRMLight ptr) as D3DVALUE
	GetPenumbra as function(byval as IDirect3DRMLight ptr) as D3DVALUE
	GetConstantAttenuation as function(byval as IDirect3DRMLight ptr) as D3DVALUE
	GetLinearAttenuation as function(byval as IDirect3DRMLight ptr) as D3DVALUE
	GetQuadraticAttenuation as function(byval as IDirect3DRMLight ptr) as D3DVALUE
	GetColor as function(byval as IDirect3DRMLight ptr) as D3DCOLOR
	GetType as function(byval as IDirect3DRMLight ptr) as D3DRMLIGHTTYPE
	SetEnableFrame as function(byval as IDirect3DRMLight ptr, byval as LPDIRECT3DRMFRAME) as HRESULT
	GetEnableFrame as function(byval as IDirect3DRMLight ptr, byval as LPDIRECT3DRMFRAME ptr) as HRESULT
end type

type IDirect3DRMTextureVtbl_ as IDirect3DRMTextureVtbl

type IDirect3DRMTexture
	lpVtbl as IDirect3DRMTextureVtbl_ ptr
end type

type IDirect3DRMTextureVtbl
	QueryInterface as function(byval as IDirect3DRMTexture ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMTexture ptr) as ULONG
	Release as function(byval as IDirect3DRMTexture ptr) as ULONG
	Clone as function(byval as IDirect3DRMTexture ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddDestroyCallback as function(byval as IDirect3DRMTexture ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMTexture ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	SetAppData as function(byval as IDirect3DRMTexture ptr, byval as DWORD) as HRESULT
	GetAppData as function(byval as IDirect3DRMTexture ptr) as DWORD
	SetName as function(byval as IDirect3DRMTexture ptr, byval as LPCSTR) as HRESULT
	GetName as function(byval as IDirect3DRMTexture ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	GetClassNameA as function(byval as IDirect3DRMTexture ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	InitFromFile as function(byval as IDirect3DRMTexture ptr, byval as zstring ptr) as HRESULT
	InitFromSurface as function(byval as IDirect3DRMTexture ptr, byval as LPDIRECTDRAWSURFACE) as HRESULT
	InitFromResource as function(byval as IDirect3DRMTexture ptr, byval as HRSRC) as HRESULT
	Changed as function(byval as IDirect3DRMTexture ptr, byval as BOOL, byval as BOOL) as HRESULT
	SetColors as function(byval as IDirect3DRMTexture ptr, byval as DWORD) as HRESULT
	SetShades as function(byval as IDirect3DRMTexture ptr, byval as DWORD) as HRESULT
	SetDecalSize as function(byval as IDirect3DRMTexture ptr, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetDecalOrigin as function(byval as IDirect3DRMTexture ptr, byval as LONG, byval as LONG) as HRESULT
	SetDecalScale as function(byval as IDirect3DRMTexture ptr, byval as DWORD) as HRESULT
	SetDecalTransparency as function(byval as IDirect3DRMTexture ptr, byval as BOOL) as HRESULT
	SetDecalTransparentColor as function(byval as IDirect3DRMTexture ptr, byval as D3DCOLOR) as HRESULT
	GetDecalSize as function(byval as IDirect3DRMTexture ptr, byval as D3DVALUE ptr, byval as D3DVALUE ptr) as HRESULT
	GetDecalOrigin as function(byval as IDirect3DRMTexture ptr, byval as LONG ptr, byval as LONG ptr) as HRESULT
	GetImage as function(byval as IDirect3DRMTexture ptr) as D3DRMIMAGE ptr
	GetShades as function(byval as IDirect3DRMTexture ptr) as DWORD
	GetColors as function(byval as IDirect3DRMTexture ptr) as DWORD
	GetDecalScale as function(byval as IDirect3DRMTexture ptr) as DWORD
	GetDecalTransparency as function(byval as IDirect3DRMTexture ptr) as BOOL
	GetDecalTransparentColor as function(byval as IDirect3DRMTexture ptr) as D3DCOLOR
end type

type IDirect3DRMTexture2Vtbl_ as IDirect3DRMTexture2Vtbl

type IDirect3DRMTexture2
	lpVtbl as IDirect3DRMTexture2Vtbl_ ptr
end type

type IDirect3DRMTexture2Vtbl
	QueryInterface as function(byval as IDirect3DRMTexture2 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMTexture2 ptr) as ULONG
	Release as function(byval as IDirect3DRMTexture2 ptr) as ULONG
	Clone as function(byval as IDirect3DRMTexture2 ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddDestroyCallback as function(byval as IDirect3DRMTexture2 ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMTexture2 ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	SetAppData as function(byval as IDirect3DRMTexture2 ptr, byval as DWORD) as HRESULT
	GetAppData as function(byval as IDirect3DRMTexture2 ptr) as DWORD
	SetName as function(byval as IDirect3DRMTexture2 ptr, byval as LPCSTR) as HRESULT
	GetName as function(byval as IDirect3DRMTexture2 ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	GetClassNameA as function(byval as IDirect3DRMTexture2 ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	InitFromFile as function(byval as IDirect3DRMTexture2 ptr, byval as zstring ptr) as HRESULT
	InitFromSurface as function(byval as IDirect3DRMTexture2 ptr, byval as LPDIRECTDRAWSURFACE) as HRESULT
	InitFromResource as function(byval as IDirect3DRMTexture2 ptr, byval as HRSRC) as HRESULT
	Changed as function(byval as IDirect3DRMTexture2 ptr, byval as BOOL, byval as BOOL) as HRESULT
	SetColors as function(byval as IDirect3DRMTexture2 ptr, byval as DWORD) as HRESULT
	SetShades as function(byval as IDirect3DRMTexture2 ptr, byval as DWORD) as HRESULT
	SetDecalSize as function(byval as IDirect3DRMTexture2 ptr, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetDecalOrigin as function(byval as IDirect3DRMTexture2 ptr, byval as LONG, byval as LONG) as HRESULT
	SetDecalScale as function(byval as IDirect3DRMTexture2 ptr, byval as DWORD) as HRESULT
	SetDecalTransparency as function(byval as IDirect3DRMTexture2 ptr, byval as BOOL) as HRESULT
	SetDecalTransparentColor as function(byval as IDirect3DRMTexture2 ptr, byval as D3DCOLOR) as HRESULT
	GetDecalSize as function(byval as IDirect3DRMTexture2 ptr, byval as D3DVALUE ptr, byval as D3DVALUE ptr) as HRESULT
	GetDecalOrigin as function(byval as IDirect3DRMTexture2 ptr, byval as LONG ptr, byval as LONG ptr) as HRESULT
	GetImage as function(byval as IDirect3DRMTexture2 ptr) as D3DRMIMAGE ptr
	GetShades as function(byval as IDirect3DRMTexture2 ptr) as DWORD
	GetColors as function(byval as IDirect3DRMTexture2 ptr) as DWORD
	GetDecalScale as function(byval as IDirect3DRMTexture2 ptr) as DWORD
	GetDecalTransparency as function(byval as IDirect3DRMTexture2 ptr) as BOOL
	GetDecalTransparentColor as function(byval as IDirect3DRMTexture2 ptr) as D3DCOLOR
	InitFromImage as function(byval as IDirect3DRMTexture2 ptr, byval as LPD3DRMIMAGE) as HRESULT
	InitFromResource2 as function(byval as IDirect3DRMTexture2 ptr, byval as HMODULE, byval as LPCTSTR, byval as LPCTSTR) as HRESULT
	GenerateMIPMap as function(byval as IDirect3DRMTexture2 ptr, byval as DWORD) as HRESULT
end type

type IDirect3DRMTexture3Vtbl_ as IDirect3DRMTexture3Vtbl

type IDirect3DRMTexture3
	lpVtbl as IDirect3DRMTexture3Vtbl_ ptr
end type

type IDirect3DRMTexture3Vtbl
	QueryInterface as function(byval as IDirect3DRMTexture3 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMTexture3 ptr) as ULONG
	Release as function(byval as IDirect3DRMTexture3 ptr) as ULONG
	Clone as function(byval as IDirect3DRMTexture3 ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddDestroyCallback as function(byval as IDirect3DRMTexture3 ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMTexture3 ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	SetAppData as function(byval as IDirect3DRMTexture3 ptr, byval as DWORD) as HRESULT
	GetAppData as function(byval as IDirect3DRMTexture3 ptr) as DWORD
	SetName as function(byval as IDirect3DRMTexture3 ptr, byval as LPCSTR) as HRESULT
	GetName as function(byval as IDirect3DRMTexture3 ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	GetClassNameA as function(byval as IDirect3DRMTexture3 ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	InitFromFile as function(byval as IDirect3DRMTexture3 ptr, byval as zstring ptr) as HRESULT
	InitFromSurface as function(byval as IDirect3DRMTexture3 ptr, byval as LPDIRECTDRAWSURFACE) as HRESULT
	InitFromResource as function(byval as IDirect3DRMTexture3 ptr, byval as HRSRC) as HRESULT
	Changed as function(byval as IDirect3DRMTexture3 ptr, byval as DWORD, byval as DWORD, byval as LPRECT) as HRESULT
	SetColors as function(byval as IDirect3DRMTexture3 ptr, byval as DWORD) as HRESULT
	SetShades as function(byval as IDirect3DRMTexture3 ptr, byval as DWORD) as HRESULT
	SetDecalSize as function(byval as IDirect3DRMTexture3 ptr, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetDecalOrigin as function(byval as IDirect3DRMTexture3 ptr, byval as LONG, byval as LONG) as HRESULT
	SetDecalScale as function(byval as IDirect3DRMTexture3 ptr, byval as DWORD) as HRESULT
	SetDecalTransparency as function(byval as IDirect3DRMTexture3 ptr, byval as BOOL) as HRESULT
	SetDecalTransparentColor as function(byval as IDirect3DRMTexture3 ptr, byval as D3DCOLOR) as HRESULT
	GetDecalSize as function(byval as IDirect3DRMTexture3 ptr, byval as D3DVALUE ptr, byval as D3DVALUE ptr) as HRESULT
	GetDecalOrigin as function(byval as IDirect3DRMTexture3 ptr, byval as LONG ptr, byval as LONG ptr) as HRESULT
	GetImage as function(byval as IDirect3DRMTexture3 ptr) as D3DRMIMAGE ptr
	GetShades as function(byval as IDirect3DRMTexture3 ptr) as DWORD
	GetColors as function(byval as IDirect3DRMTexture3 ptr) as DWORD
	GetDecalScale as function(byval as IDirect3DRMTexture3 ptr) as DWORD
	GetDecalTransparency as function(byval as IDirect3DRMTexture3 ptr) as BOOL
	GetDecalTransparentColor as function(byval as IDirect3DRMTexture3 ptr) as D3DCOLOR
	InitFromImage as function(byval as IDirect3DRMTexture3 ptr, byval as LPD3DRMIMAGE) as HRESULT
	InitFromResource2 as function(byval as IDirect3DRMTexture3 ptr, byval as HMODULE, byval as LPCTSTR, byval as LPCTSTR) as HRESULT
	GenerateMIPMap as function(byval as IDirect3DRMTexture3 ptr, byval as DWORD) as HRESULT
	GetSurface as function(byval as IDirect3DRMTexture3 ptr, byval as DWORD, byval as LPDIRECTDRAWSURFACE ptr) as HRESULT
	SetCacheOptions as function(byval as IDirect3DRMTexture3 ptr, byval as LONG, byval as DWORD) as HRESULT
	GetCacheOptions as function(byval as IDirect3DRMTexture3 ptr, byval as LPLONG, byval as LPDWORD) as HRESULT
	SetDownsampleCallback as function(byval as IDirect3DRMTexture3 ptr, byval as D3DRMDOWNSAMPLECALLBACK, byval as LPVOID) as HRESULT
	SetValidationCallback as function(byval as IDirect3DRMTexture3 ptr, byval as D3DRMVALIDATIONCALLBACK, byval as LPVOID) as HRESULT
end type

type IDirect3DRMWrapVtbl_ as IDirect3DRMWrapVtbl

type IDirect3DRMWrap
	lpVtbl as IDirect3DRMWrapVtbl_ ptr
end type

type IDirect3DRMWrapVtbl
	QueryInterface as function(byval as IDirect3DRMWrap ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMWrap ptr) as ULONG
	Release as function(byval as IDirect3DRMWrap ptr) as ULONG
	Clone as function(byval as IDirect3DRMWrap ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddDestroyCallback as function(byval as IDirect3DRMWrap ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMWrap ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	SetAppData as function(byval as IDirect3DRMWrap ptr, byval as DWORD) as HRESULT
	GetAppData as function(byval as IDirect3DRMWrap ptr) as DWORD
	SetName as function(byval as IDirect3DRMWrap ptr, byval as LPCSTR) as HRESULT
	GetName as function(byval as IDirect3DRMWrap ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	GetClassNameA as function(byval as IDirect3DRMWrap ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	Init as function(byval as IDirect3DRMWrap ptr, byval as D3DRMWRAPTYPE, byval as LPDIRECT3DRMFRAME, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	Apply as function(byval as IDirect3DRMWrap ptr, byval as LPDIRECT3DRMOBJECT) as HRESULT
	ApplyRelative as function(byval as IDirect3DRMWrap ptr, byval as LPDIRECT3DRMFRAME, byval as LPDIRECT3DRMOBJECT) as HRESULT
end type

type IDirect3DRMMaterialVtbl_ as IDirect3DRMMaterialVtbl

type IDirect3DRMMaterial
	lpVtbl as IDirect3DRMMaterialVtbl_ ptr
end type

type IDirect3DRMMaterialVtbl
	QueryInterface as function(byval as IDirect3DRMMaterial ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMMaterial ptr) as ULONG
	Release as function(byval as IDirect3DRMMaterial ptr) as ULONG
	Clone as function(byval as IDirect3DRMMaterial ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddDestroyCallback as function(byval as IDirect3DRMMaterial ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMMaterial ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	SetAppData as function(byval as IDirect3DRMMaterial ptr, byval as DWORD) as HRESULT
	GetAppData as function(byval as IDirect3DRMMaterial ptr) as DWORD
	SetName as function(byval as IDirect3DRMMaterial ptr, byval as LPCSTR) as HRESULT
	GetName as function(byval as IDirect3DRMMaterial ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	GetClassNameA as function(byval as IDirect3DRMMaterial ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	SetPower as function(byval as IDirect3DRMMaterial ptr, byval as D3DVALUE) as HRESULT
	SetSpecular as function(byval as IDirect3DRMMaterial ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetEmissive as function(byval as IDirect3DRMMaterial ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	GetPower as function(byval as IDirect3DRMMaterial ptr) as D3DVALUE
	GetSpecular as function(byval as IDirect3DRMMaterial ptr, byval as D3DVALUE ptr, byval as D3DVALUE ptr, byval as D3DVALUE ptr) as HRESULT
	GetEmissive as function(byval as IDirect3DRMMaterial ptr, byval as D3DVALUE ptr, byval as D3DVALUE ptr, byval as D3DVALUE ptr) as HRESULT
end type

type IDirect3DRMMaterial2Vtbl_ as IDirect3DRMMaterial2Vtbl

type IDirect3DRMMaterial2
	lpVtbl as IDirect3DRMMaterial2Vtbl_ ptr
end type

type IDirect3DRMMaterial2Vtbl
	QueryInterface as function(byval as IDirect3DRMMaterial2 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMMaterial2 ptr) as ULONG
	Release as function(byval as IDirect3DRMMaterial2 ptr) as ULONG
	Clone as function(byval as IDirect3DRMMaterial2 ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddDestroyCallback as function(byval as IDirect3DRMMaterial2 ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMMaterial2 ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	SetAppData as function(byval as IDirect3DRMMaterial2 ptr, byval as DWORD) as HRESULT
	GetAppData as function(byval as IDirect3DRMMaterial2 ptr) as DWORD
	SetName as function(byval as IDirect3DRMMaterial2 ptr, byval as LPCSTR) as HRESULT
	GetName as function(byval as IDirect3DRMMaterial2 ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	GetClassNameA as function(byval as IDirect3DRMMaterial2 ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	SetPower as function(byval as IDirect3DRMMaterial2 ptr, byval as D3DVALUE) as HRESULT
	SetSpecular as function(byval as IDirect3DRMMaterial2 ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetEmissive as function(byval as IDirect3DRMMaterial2 ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	GetPower as function(byval as IDirect3DRMMaterial2 ptr) as D3DVALUE
	GetSpecular as function(byval as IDirect3DRMMaterial2 ptr, byval as D3DVALUE ptr, byval as D3DVALUE ptr, byval as D3DVALUE ptr) as HRESULT
	GetEmissive as function(byval as IDirect3DRMMaterial2 ptr, byval as D3DVALUE ptr, byval as D3DVALUE ptr, byval as D3DVALUE ptr) as HRESULT
	GetAmbient as function(byval as IDirect3DRMMaterial2 ptr, byval as D3DVALUE ptr, byval as D3DVALUE ptr, byval as D3DVALUE ptr) as HRESULT
	SetAmbient as function(byval as IDirect3DRMMaterial2 ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
end type

type IDirect3DRMAnimationVtbl_ as IDirect3DRMAnimationVtbl

type IDirect3DRMAnimation
	lpVtbl as IDirect3DRMAnimationVtbl_ ptr
end type

type IDirect3DRMAnimationVtbl
	QueryInterface as function(byval as IDirect3DRMAnimation ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMAnimation ptr) as ULONG
	Release as function(byval as IDirect3DRMAnimation ptr) as ULONG
	Clone as function(byval as IDirect3DRMAnimation ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddDestroyCallback as function(byval as IDirect3DRMAnimation ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMAnimation ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	SetAppData as function(byval as IDirect3DRMAnimation ptr, byval as DWORD) as HRESULT
	GetAppData as function(byval as IDirect3DRMAnimation ptr) as DWORD
	SetName as function(byval as IDirect3DRMAnimation ptr, byval as LPCSTR) as HRESULT
	GetName as function(byval as IDirect3DRMAnimation ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	GetClassNameA as function(byval as IDirect3DRMAnimation ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	SetOptions as function(byval as IDirect3DRMAnimation ptr, byval as D3DRMANIMATIONOPTIONS) as HRESULT
	AddRotateKey as function(byval as IDirect3DRMAnimation ptr, byval as D3DVALUE, byval as D3DRMQUATERNION ptr) as HRESULT
	AddPositionKey as function(byval as IDirect3DRMAnimation ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	AddScaleKey as function(byval as IDirect3DRMAnimation ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	DeleteKey as function(byval as IDirect3DRMAnimation ptr, byval as D3DVALUE) as HRESULT
	SetFrame as function(byval as IDirect3DRMAnimation ptr, byval as LPDIRECT3DRMFRAME) as HRESULT
	SetTime as function(byval as IDirect3DRMAnimation ptr, byval as D3DVALUE) as HRESULT
	GetOptions as function(byval as IDirect3DRMAnimation ptr) as D3DRMANIMATIONOPTIONS
end type

type IDirect3DRMAnimation2Vtbl_ as IDirect3DRMAnimation2Vtbl

type IDirect3DRMAnimation2
	lpVtbl as IDirect3DRMAnimation2Vtbl_ ptr
end type

type IDirect3DRMAnimation2Vtbl
	QueryInterface as function(byval as IDirect3DRMAnimation2 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMAnimation2 ptr) as ULONG
	Release as function(byval as IDirect3DRMAnimation2 ptr) as ULONG
	Clone as function(byval as IDirect3DRMAnimation2 ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddDestroyCallback as function(byval as IDirect3DRMAnimation2 ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMAnimation2 ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	SetAppData as function(byval as IDirect3DRMAnimation2 ptr, byval as DWORD) as HRESULT
	GetAppData as function(byval as IDirect3DRMAnimation2 ptr) as DWORD
	SetName as function(byval as IDirect3DRMAnimation2 ptr, byval as LPCSTR) as HRESULT
	GetName as function(byval as IDirect3DRMAnimation2 ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	GetClassNameA as function(byval as IDirect3DRMAnimation2 ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	SetOptions as function(byval as IDirect3DRMAnimation2 ptr, byval as D3DRMANIMATIONOPTIONS) as HRESULT
	AddRotateKey as function(byval as IDirect3DRMAnimation2 ptr, byval as D3DVALUE, byval as D3DRMQUATERNION ptr) as HRESULT
	AddPositionKey as function(byval as IDirect3DRMAnimation2 ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	AddScaleKey as function(byval as IDirect3DRMAnimation2 ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	DeleteKey as function(byval as IDirect3DRMAnimation2 ptr, byval as D3DVALUE) as HRESULT
	SetFrame as function(byval as IDirect3DRMAnimation2 ptr, byval as LPDIRECT3DRMFRAME3) as HRESULT
	SetTime as function(byval as IDirect3DRMAnimation2 ptr, byval as D3DVALUE) as HRESULT
	GetOptions as function(byval as IDirect3DRMAnimation2 ptr) as D3DRMANIMATIONOPTIONS
	GetFrame as function(byval as IDirect3DRMAnimation2 ptr, byval as LPDIRECT3DRMFRAME3 ptr) as HRESULT
	DeleteKeyByID as function(byval as IDirect3DRMAnimation2 ptr, byval as DWORD) as HRESULT
	AddKey as function(byval as IDirect3DRMAnimation2 ptr, byval as LPD3DRMANIMATIONKEY) as HRESULT
	ModifyKey as function(byval as IDirect3DRMAnimation2 ptr, byval as LPD3DRMANIMATIONKEY) as HRESULT
	GetKeys as function(byval as IDirect3DRMAnimation2 ptr, byval as D3DVALUE, byval as D3DVALUE, byval as LPDWORD, byval as LPD3DRMANIMATIONKEY) as HRESULT
end type

type IDirect3DRMAnimationSetVtbl_ as IDirect3DRMAnimationSetVtbl

type IDirect3DRMAnimationSet
	lpVtbl as IDirect3DRMAnimationSetVtbl_ ptr
end type

type IDirect3DRMAnimationSetVtbl
	QueryInterface as function(byval as IDirect3DRMAnimationSet ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMAnimationSet ptr) as ULONG
	Release as function(byval as IDirect3DRMAnimationSet ptr) as ULONG
	Clone as function(byval as IDirect3DRMAnimationSet ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddDestroyCallback as function(byval as IDirect3DRMAnimationSet ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMAnimationSet ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	SetAppData as function(byval as IDirect3DRMAnimationSet ptr, byval as DWORD) as HRESULT
	GetAppData as function(byval as IDirect3DRMAnimationSet ptr) as DWORD
	SetName as function(byval as IDirect3DRMAnimationSet ptr, byval as LPCSTR) as HRESULT
	GetName as function(byval as IDirect3DRMAnimationSet ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	GetClassNameA as function(byval as IDirect3DRMAnimationSet ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	AddAnimation as function(byval as IDirect3DRMAnimationSet ptr, byval as LPDIRECT3DRMANIMATION) as HRESULT
	Load as function(byval as IDirect3DRMAnimationSet ptr, byval as LPVOID, byval as LPVOID, byval as D3DRMLOADOPTIONS, byval as D3DRMLOADTEXTURECALLBACK, byval as LPVOID, byval as LPDIRECT3DRMFRAME) as HRESULT
	DeleteAnimation as function(byval as IDirect3DRMAnimationSet ptr, byval as LPDIRECT3DRMANIMATION) as HRESULT
	SetTime as function(byval as IDirect3DRMAnimationSet ptr, byval as D3DVALUE) as HRESULT
end type

type IDirect3DRMAnimationSet2Vtbl_ as IDirect3DRMAnimationSet2Vtbl

type IDirect3DRMAnimationSet2
	lpVtbl as IDirect3DRMAnimationSet2Vtbl_ ptr
end type

type IDirect3DRMAnimationSet2Vtbl
	QueryInterface as function(byval as IDirect3DRMAnimationSet2 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMAnimationSet2 ptr) as ULONG
	Release as function(byval as IDirect3DRMAnimationSet2 ptr) as ULONG
	Clone as function(byval as IDirect3DRMAnimationSet2 ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddDestroyCallback as function(byval as IDirect3DRMAnimationSet2 ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMAnimationSet2 ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	SetAppData as function(byval as IDirect3DRMAnimationSet2 ptr, byval as DWORD) as HRESULT
	GetAppData as function(byval as IDirect3DRMAnimationSet2 ptr) as DWORD
	SetName as function(byval as IDirect3DRMAnimationSet2 ptr, byval as LPCSTR) as HRESULT
	GetName as function(byval as IDirect3DRMAnimationSet2 ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	GetClassNameA as function(byval as IDirect3DRMAnimationSet2 ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	AddAnimation as function(byval as IDirect3DRMAnimationSet2 ptr, byval as LPDIRECT3DRMANIMATION2) as HRESULT
	Load as function(byval as IDirect3DRMAnimationSet2 ptr, byval as LPVOID, byval as LPVOID, byval as D3DRMLOADOPTIONS, byval as D3DRMLOADTEXTURE3CALLBACK, byval as LPVOID, byval as LPDIRECT3DRMFRAME3) as HRESULT
	DeleteAnimation as function(byval as IDirect3DRMAnimationSet2 ptr, byval as LPDIRECT3DRMANIMATION2) as HRESULT
	SetTime as function(byval as IDirect3DRMAnimationSet2 ptr, byval as D3DVALUE) as HRESULT
	GetAnimations as function(byval as IDirect3DRMAnimationSet2 ptr, byval as LPDIRECT3DRMANIMATIONARRAY ptr) as HRESULT
end type

type IDirect3DRMUserVisualVtbl_ as IDirect3DRMUserVisualVtbl

type IDirect3DRMUserVisual
	lpVtbl as IDirect3DRMUserVisualVtbl_ ptr
end type

type IDirect3DRMUserVisualVtbl
	QueryInterface as function(byval as IDirect3DRMUserVisual ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMUserVisual ptr) as ULONG
	Release as function(byval as IDirect3DRMUserVisual ptr) as ULONG
	Clone as function(byval as IDirect3DRMUserVisual ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddDestroyCallback as function(byval as IDirect3DRMUserVisual ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMUserVisual ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	SetAppData as function(byval as IDirect3DRMUserVisual ptr, byval as DWORD) as HRESULT
	GetAppData as function(byval as IDirect3DRMUserVisual ptr) as DWORD
	SetName as function(byval as IDirect3DRMUserVisual ptr, byval as LPCSTR) as HRESULT
	GetName as function(byval as IDirect3DRMUserVisual ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	GetClassNameA as function(byval as IDirect3DRMUserVisual ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	Init as function(byval as IDirect3DRMUserVisual ptr, byval as D3DRMUSERVISUALCALLBACK, byval as any ptr) as HRESULT
end type

type IDirect3DRMArrayVtbl_ as IDirect3DRMArrayVtbl

type IDirect3DRMArray
	lpVtbl as IDirect3DRMArrayVtbl_ ptr
end type

type IDirect3DRMArrayVtbl
	QueryInterface as function(byval as IDirect3DRMArray ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMArray ptr) as ULONG
	Release as function(byval as IDirect3DRMArray ptr) as ULONG
	GetSize as function(byval as IDirect3DRMArray ptr) as DWORD
end type

type IDirect3DRMObjectArrayVtbl_ as IDirect3DRMObjectArrayVtbl

type IDirect3DRMObjectArray
	lpVtbl as IDirect3DRMObjectArrayVtbl_ ptr
end type

type IDirect3DRMObjectArrayVtbl
	QueryInterface as function(byval as IDirect3DRMObjectArray ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMObjectArray ptr) as ULONG
	Release as function(byval as IDirect3DRMObjectArray ptr) as ULONG
	GetSize as function(byval as IDirect3DRMObjectArray ptr) as DWORD
	GetElement as function(byval as IDirect3DRMObjectArray ptr, byval as DWORD, byval as LPDIRECT3DRMOBJECT ptr) as HRESULT
end type

type IDirect3DRMDeviceArrayVtbl_ as IDirect3DRMDeviceArrayVtbl

type IDirect3DRMDeviceArray
	lpVtbl as IDirect3DRMDeviceArrayVtbl_ ptr
end type

type IDirect3DRMDeviceArrayVtbl
	QueryInterface as function(byval as IDirect3DRMDeviceArray ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMDeviceArray ptr) as ULONG
	Release as function(byval as IDirect3DRMDeviceArray ptr) as ULONG
	GetSize as function(byval as IDirect3DRMDeviceArray ptr) as DWORD
	GetElement as function(byval as IDirect3DRMDeviceArray ptr, byval as DWORD, byval as LPDIRECT3DRMDEVICE ptr) as HRESULT
end type

type IDirect3DRMFrameArrayVtbl_ as IDirect3DRMFrameArrayVtbl

type IDirect3DRMFrameArray
	lpVtbl as IDirect3DRMFrameArrayVtbl_ ptr
end type

type IDirect3DRMFrameArrayVtbl
	QueryInterface as function(byval as IDirect3DRMFrameArray ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMFrameArray ptr) as ULONG
	Release as function(byval as IDirect3DRMFrameArray ptr) as ULONG
	GetSize as function(byval as IDirect3DRMFrameArray ptr) as DWORD
	GetElement as function(byval as IDirect3DRMFrameArray ptr, byval as DWORD, byval as LPDIRECT3DRMFRAME ptr) as HRESULT
end type

type IDirect3DRMViewportArrayVtbl_ as IDirect3DRMViewportArrayVtbl

type IDirect3DRMViewportArray
	lpVtbl as IDirect3DRMViewportArrayVtbl_ ptr
end type

type IDirect3DRMViewportArrayVtbl
	QueryInterface as function(byval as IDirect3DRMViewportArray ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMViewportArray ptr) as ULONG
	Release as function(byval as IDirect3DRMViewportArray ptr) as ULONG
	GetSize as function(byval as IDirect3DRMViewportArray ptr) as DWORD
	GetElement as function(byval as IDirect3DRMViewportArray ptr, byval as DWORD, byval as LPDIRECT3DRMVIEWPORT ptr) as HRESULT
end type

type IDirect3DRMVisualArrayVtbl_ as IDirect3DRMVisualArrayVtbl

type IDirect3DRMVisualArray
	lpVtbl as IDirect3DRMVisualArrayVtbl_ ptr
end type

type IDirect3DRMVisualArrayVtbl
	QueryInterface as function(byval as IDirect3DRMVisualArray ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMVisualArray ptr) as ULONG
	Release as function(byval as IDirect3DRMVisualArray ptr) as ULONG
	GetSize as function(byval as IDirect3DRMVisualArray ptr) as DWORD
	GetElement as function(byval as IDirect3DRMVisualArray ptr, byval as DWORD, byval as LPDIRECT3DRMVISUAL ptr) as HRESULT
end type

type IDirect3DRMAnimationArrayVtbl_ as IDirect3DRMAnimationArrayVtbl

type IDirect3DRMAnimationArray
	lpVtbl as IDirect3DRMAnimationArrayVtbl_ ptr
end type

type IDirect3DRMAnimationArrayVtbl
	QueryInterface as function(byval as IDirect3DRMAnimationArray ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMAnimationArray ptr) as ULONG
	Release as function(byval as IDirect3DRMAnimationArray ptr) as ULONG
	GetSize as function(byval as IDirect3DRMAnimationArray ptr) as DWORD
	GetElement as function(byval as IDirect3DRMAnimationArray ptr, byval as DWORD, byval as LPDIRECT3DRMANIMATION2 ptr) as HRESULT
end type

type IDirect3DRMPickedArrayVtbl_ as IDirect3DRMPickedArrayVtbl

type IDirect3DRMPickedArray
	lpVtbl as IDirect3DRMPickedArrayVtbl_ ptr
end type

type IDirect3DRMPickedArrayVtbl
	QueryInterface as function(byval as IDirect3DRMPickedArray ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMPickedArray ptr) as ULONG
	Release as function(byval as IDirect3DRMPickedArray ptr) as ULONG
	GetSize as function(byval as IDirect3DRMPickedArray ptr) as DWORD
	GetPick as function(byval as IDirect3DRMPickedArray ptr, byval as DWORD, byval as LPDIRECT3DRMVISUAL ptr, byval as LPDIRECT3DRMFRAMEARRAY ptr, byval as LPD3DRMPICKDESC) as HRESULT
end type

type IDirect3DRMLightArrayVtbl_ as IDirect3DRMLightArrayVtbl

type IDirect3DRMLightArray
	lpVtbl as IDirect3DRMLightArrayVtbl_ ptr
end type

type IDirect3DRMLightArrayVtbl
	QueryInterface as function(byval as IDirect3DRMLightArray ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMLightArray ptr) as ULONG
	Release as function(byval as IDirect3DRMLightArray ptr) as ULONG
	GetSize as function(byval as IDirect3DRMLightArray ptr) as DWORD
	GetElement as function(byval as IDirect3DRMLightArray ptr, byval as DWORD, byval as LPDIRECT3DRMLIGHT ptr) as HRESULT
end type

type IDirect3DRMFaceArrayVtbl_ as IDirect3DRMFaceArrayVtbl

type IDirect3DRMFaceArray
	lpVtbl as IDirect3DRMFaceArrayVtbl_ ptr
end type

type IDirect3DRMFaceArrayVtbl
	QueryInterface as function(byval as IDirect3DRMFaceArray ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMFaceArray ptr) as ULONG
	Release as function(byval as IDirect3DRMFaceArray ptr) as ULONG
	GetSize as function(byval as IDirect3DRMFaceArray ptr) as DWORD
	GetElement as function(byval as IDirect3DRMFaceArray ptr, byval as DWORD, byval as LPDIRECT3DRMFACE ptr) as HRESULT
end type

type IDirect3DRMPicked2ArrayVtbl_ as IDirect3DRMPicked2ArrayVtbl

type IDirect3DRMPicked2Array
	lpVtbl as IDirect3DRMPicked2ArrayVtbl_ ptr
end type

type IDirect3DRMPicked2ArrayVtbl
	QueryInterface as function(byval as IDirect3DRMPicked2Array ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMPicked2Array ptr) as ULONG
	Release as function(byval as IDirect3DRMPicked2Array ptr) as ULONG
	GetSize as function(byval as IDirect3DRMPicked2Array ptr) as DWORD
	GetPick as function(byval as IDirect3DRMPicked2Array ptr, byval as DWORD, byval as LPDIRECT3DRMVISUAL ptr, byval as LPDIRECT3DRMFRAMEARRAY ptr, byval as LPD3DRMPICKDESC2) as HRESULT
end type

type IDirect3DRMInterpolatorVtbl_ as IDirect3DRMInterpolatorVtbl

type IDirect3DRMInterpolator
	lpVtbl as IDirect3DRMInterpolatorVtbl_ ptr
end type

type IDirect3DRMInterpolatorVtbl
	QueryInterface as function(byval as IDirect3DRMInterpolator ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMInterpolator ptr) as ULONG
	Release as function(byval as IDirect3DRMInterpolator ptr) as ULONG
	Clone as function(byval as IDirect3DRMInterpolator ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddDestroyCallback as function(byval as IDirect3DRMInterpolator ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMInterpolator ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	SetAppData as function(byval as IDirect3DRMInterpolator ptr, byval as DWORD) as HRESULT
	GetAppData as function(byval as IDirect3DRMInterpolator ptr) as DWORD
	SetName as function(byval as IDirect3DRMInterpolator ptr, byval as LPCSTR) as HRESULT
	GetName as function(byval as IDirect3DRMInterpolator ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	GetClassNameA as function(byval as IDirect3DRMInterpolator ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	AttachObject as function(byval as IDirect3DRMInterpolator ptr, byval as LPDIRECT3DRMOBJECT) as HRESULT
	GetAttachedObjects as function(byval as IDirect3DRMInterpolator ptr, byval as LPDIRECT3DRMOBJECTARRAY ptr) as HRESULT
	DetachObject as function(byval as IDirect3DRMInterpolator ptr, byval as LPDIRECT3DRMOBJECT) as HRESULT
	SetIndex as function(byval as IDirect3DRMInterpolator ptr, byval as D3DVALUE) as HRESULT
	GetIndex as function(byval as IDirect3DRMInterpolator ptr) as D3DVALUE
	Interpolate as function(byval as IDirect3DRMInterpolator ptr, byval as D3DVALUE, byval as LPDIRECT3DRMOBJECT, byval as D3DRMINTERPOLATIONOPTIONS) as HRESULT
end type

type IDirect3DRMClippedVisualVtbl_ as IDirect3DRMClippedVisualVtbl

type IDirect3DRMClippedVisual
	lpVtbl as IDirect3DRMClippedVisualVtbl_ ptr
end type

type IDirect3DRMClippedVisualVtbl
	QueryInterface as function(byval as IDirect3DRMClippedVisual ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMClippedVisual ptr) as ULONG
	Release as function(byval as IDirect3DRMClippedVisual ptr) as ULONG
	Clone as function(byval as IDirect3DRMClippedVisual ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddDestroyCallback as function(byval as IDirect3DRMClippedVisual ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMClippedVisual ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	SetAppData as function(byval as IDirect3DRMClippedVisual ptr, byval as DWORD) as HRESULT
	GetAppData as function(byval as IDirect3DRMClippedVisual ptr) as DWORD
	SetName as function(byval as IDirect3DRMClippedVisual ptr, byval as LPCSTR) as HRESULT
	GetName as function(byval as IDirect3DRMClippedVisual ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	GetClassNameA as function(byval as IDirect3DRMClippedVisual ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	Init as function(byval as IDirect3DRMClippedVisual ptr, byval as LPDIRECT3DRMVISUAL) as HRESULT
	AddPlane as function(byval as IDirect3DRMClippedVisual ptr, byval as LPDIRECT3DRMFRAME3, byval as LPD3DVECTOR, byval as LPD3DVECTOR, byval as DWORD, byval as LPDWORD) as HRESULT
	DeletePlane as function(byval as IDirect3DRMClippedVisual ptr, byval as DWORD, byval as DWORD) as HRESULT
	GetPlaneIDs as function(byval as IDirect3DRMClippedVisual ptr, byval as LPDWORD, byval as LPDWORD, byval as DWORD) as HRESULT
	GetPlane as function(byval as IDirect3DRMClippedVisual ptr, byval as DWORD, byval as LPDIRECT3DRMFRAME3, byval as LPD3DVECTOR, byval as LPD3DVECTOR, byval as DWORD) as HRESULT
	SetPlane as function(byval as IDirect3DRMClippedVisual ptr, byval as DWORD, byval as LPDIRECT3DRMFRAME3, byval as LPD3DVECTOR, byval as LPD3DVECTOR, byval as DWORD) as HRESULT
end type

#endif
