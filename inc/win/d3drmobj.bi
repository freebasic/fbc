'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   Copyright (C) 2008 Vijay Kiran Kamuju
''   Copyright (C) 2010 Christian Costa
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

#include once "objbase.bi"
#include once "d3drmdef.bi"
#include once "d3d.bi"

extern "Windows"

#define __D3DRMOBJ_H__
extern CLSID_CDirect3DRMDevice as const GUID
extern CLSID_CDirect3DRMViewport as const GUID
extern CLSID_CDirect3DRMFrame as const GUID
extern CLSID_CDirect3DRMMesh as const GUID
extern CLSID_CDirect3DRMMeshBuilder as const GUID
extern CLSID_CDirect3DRMFace as const GUID
extern CLSID_CDirect3DRMLight as const GUID
extern CLSID_CDirect3DRMTexture as const GUID
extern CLSID_CDirect3DRMWrap as const GUID
extern CLSID_CDirect3DRMMaterial as const GUID
extern CLSID_CDirect3DRMAnimation as const GUID
extern CLSID_CDirect3DRMAnimationSet as const GUID
extern CLSID_CDirect3DRMUserVisual as const GUID
extern CLSID_CDirect3DRMShadow as const GUID
extern CLSID_CDirect3DRMViewportInterpolator as const GUID
extern CLSID_CDirect3DRMFrameInterpolator as const GUID
extern CLSID_CDirect3DRMMeshInterpolator as const GUID
extern CLSID_CDirect3DRMLightInterpolator as const GUID
extern CLSID_CDirect3DRMMaterialInterpolator as const GUID
extern CLSID_CDirect3DRMTextureInterpolator as const GUID
extern CLSID_CDirect3DRMProgressiveMesh as const GUID
extern CLSID_CDirect3DRMClippedVisual as const GUID
extern IID_IDirect3DRMObject as const GUID
extern IID_IDirect3DRMObject2 as const GUID
extern IID_IDirect3DRMDevice as const GUID
extern IID_IDirect3DRMDevice2 as const GUID
extern IID_IDirect3DRMDevice3 as const GUID
extern IID_IDirect3DRMViewport as const GUID
extern IID_IDirect3DRMViewport2 as const GUID
extern IID_IDirect3DRMFrame as const GUID
extern IID_IDirect3DRMFrame2 as const GUID
extern IID_IDirect3DRMFrame3 as const GUID
extern IID_IDirect3DRMVisual as const GUID
extern IID_IDirect3DRMMesh as const GUID
extern IID_IDirect3DRMMeshBuilder as const GUID
extern IID_IDirect3DRMMeshBuilder2 as const GUID
extern IID_IDirect3DRMMeshBuilder3 as const GUID
extern IID_IDirect3DRMFace as const GUID
extern IID_IDirect3DRMFace2 as const GUID
extern IID_IDirect3DRMLight as const GUID
extern IID_IDirect3DRMTexture as const GUID
extern IID_IDirect3DRMTexture2 as const GUID
extern IID_IDirect3DRMTexture3 as const GUID
extern IID_IDirect3DRMWrap as const GUID
extern IID_IDirect3DRMMaterial as const GUID
extern IID_IDirect3DRMMaterial2 as const GUID
extern IID_IDirect3DRMAnimation as const GUID
extern IID_IDirect3DRMAnimation2 as const GUID
extern IID_IDirect3DRMAnimationSet as const GUID
extern IID_IDirect3DRMAnimationSet2 as const GUID
extern IID_IDirect3DRMObjectArray as const GUID
extern IID_IDirect3DRMDeviceArray as const GUID
extern IID_IDirect3DRMViewportArray as const GUID
extern IID_IDirect3DRMFrameArray as const GUID
extern IID_IDirect3DRMVisualArray as const GUID
extern IID_IDirect3DRMLightArray as const GUID
extern IID_IDirect3DRMPickedArray as const GUID
extern IID_IDirect3DRMFaceArray as const GUID
extern IID_IDirect3DRMAnimationArray as const GUID
extern IID_IDirect3DRMUserVisual as const GUID
extern IID_IDirect3DRMShadow as const GUID
extern IID_IDirect3DRMShadow2 as const GUID
extern IID_IDirect3DRMInterpolator as const GUID
extern IID_IDirect3DRMProgressiveMesh as const GUID
extern IID_IDirect3DRMPicked2Array as const GUID
extern IID_IDirect3DRMClippedVisual as const GUID

type IDirect3DRMObject as IDirect3DRMObject_
type LPDIRECT3DRMOBJECT as IDirect3DRMObject ptr
type LPLPDIRECT3DRMOBJECT as IDirect3DRMObject ptr ptr
type LPDIRECT3DRMOBJECT2 as IDirect3DRMObject2 ptr
type LPLPDIRECT3DRMOBJECT2 as IDirect3DRMObject2 ptr ptr
type IDirect3DRMDevice as IDirect3DRMDevice_
type LPDIRECT3DRMDEVICE as IDirect3DRMDevice ptr
type LPLPDIRECT3DRMDEVICE as IDirect3DRMDevice ptr ptr
type LPDIRECT3DRMDEVICE2 as IDirect3DRMDevice2 ptr
type LPLPDIRECT3DRMDEVICE2 as IDirect3DRMDevice2 ptr ptr
type IDirect3DRMDevice3 as IDirect3DRMDevice3_
type LPDIRECT3DRMDEVICE3 as IDirect3DRMDevice3 ptr
type LPLPDIRECT3DRMDEVICE3 as IDirect3DRMDevice3 ptr ptr
type IDirect3DRMViewport as IDirect3DRMViewport_
type LPDIRECT3DRMVIEWPORT as IDirect3DRMViewport ptr
type LPLPDIRECT3DRMVIEWPORT as IDirect3DRMViewport ptr ptr
type LPDIRECT3DRMVIEWPORT2 as IDirect3DRMViewport2 ptr
type LPLPDIRECT3DRMVIEWPORT2 as IDirect3DRMViewport2 ptr ptr
type IDirect3DRMFrame as IDirect3DRMFrame_
type LPDIRECT3DRMFRAME as IDirect3DRMFrame ptr
type LPLPDIRECT3DRMFRAME as IDirect3DRMFrame ptr ptr
type LPDIRECT3DRMFRAME2 as IDirect3DRMFrame2 ptr
type LPLPDIRECT3DRMFRAME2 as IDirect3DRMFrame2 ptr ptr
type IDirect3DRMFrame3 as IDirect3DRMFrame3_
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
type IDirect3DRMLight as IDirect3DRMLight_
type LPDIRECT3DRMLIGHT as IDirect3DRMLight ptr
type LPLPDIRECT3DRMLIGHT as IDirect3DRMLight ptr ptr
type IDirect3DRMTexture as IDirect3DRMTexture_
type LPDIRECT3DRMTEXTURE as IDirect3DRMTexture ptr
type LPLPDIRECT3DRMTEXTURE as IDirect3DRMTexture ptr ptr
type LPDIRECT3DRMTEXTURE2 as IDirect3DRMTexture2 ptr
type LPLPDIRECT3DRMTEXTURE2 as IDirect3DRMTexture2 ptr ptr
type IDirect3DRMTexture3 as IDirect3DRMTexture3_
type LPDIRECT3DRMTEXTURE3 as IDirect3DRMTexture3 ptr
type LPLPDIRECT3DRMTEXTURE3 as IDirect3DRMTexture3 ptr ptr
type LPDIRECT3DRMWRAP as IDirect3DRMWrap ptr
type LPLPDIRECT3DRMWRAP as IDirect3DRMWrap ptr ptr
type IDirect3DRMMaterial as IDirect3DRMMaterial_
type LPDIRECT3DRMMATERIAL as IDirect3DRMMaterial ptr
type LPLPDIRECT3DRMMATERIAL as IDirect3DRMMaterial ptr ptr
type IDirect3DRMMaterial2 as IDirect3DRMMaterial2_
type LPDIRECT3DRMMATERIAL2 as IDirect3DRMMaterial2 ptr
type LPLPDIRECT3DRMMATERIAL2 as IDirect3DRMMaterial2 ptr ptr
type LPDIRECT3DRMANIMATION as IDirect3DRMAnimation ptr
type LPLPDIRECT3DRMANIMATION as IDirect3DRMAnimation ptr ptr
type LPDIRECT3DRMANIMATION2 as IDirect3DRMAnimation2 ptr
type LPLPDIRECT3DRMANIMATION2 as IDirect3DRMAnimation2 ptr ptr
type LPDIRECT3DRMANIMATIONSET as IDirect3DRMAnimationSet ptr
type LPLPDIRECT3DRMANIMATIONSET as IDirect3DRMAnimationSet ptr ptr
type LPDIRECT3DRMANIMATIONSET2 as IDirect3DRMAnimationSet2 ptr
type LPLPDIRECT3DRMANIMATIONSET2 as IDirect3DRMAnimationSet2 ptr ptr
type IDirect3DRMUserVisual as IDirect3DRMUserVisual_
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
type IDirect3DRMFaceArray as IDirect3DRMFaceArray_
type LPDIRECT3DRMFACEARRAY as IDirect3DRMFaceArray ptr
type LPLPDIRECT3DRMFACEARRAY as IDirect3DRMFaceArray ptr ptr
type IDirect3DRMViewportArray as IDirect3DRMViewportArray_
type LPDIRECT3DRMVIEWPORTARRAY as IDirect3DRMViewportArray ptr
type LPLPDIRECT3DRMVIEWPORTARRAY as IDirect3DRMViewportArray ptr ptr
type IDirect3DRMFrameArray as IDirect3DRMFrameArray_
type LPDIRECT3DRMFRAMEARRAY as IDirect3DRMFrameArray ptr
type LPLPDIRECT3DRMFRAMEARRAY as IDirect3DRMFrameArray ptr ptr
type IDirect3DRMAnimationArray as IDirect3DRMAnimationArray_
type LPDIRECT3DRMANIMATIONARRAY as IDirect3DRMAnimationArray ptr
type LPLPDIRECT3DRMANIMATIONARRAY as IDirect3DRMAnimationArray ptr ptr
type IDirect3DRMVisualArray as IDirect3DRMVisualArray_
type LPDIRECT3DRMVISUALARRAY as IDirect3DRMVisualArray ptr
type LPLPDIRECT3DRMVISUALARRAY as IDirect3DRMVisualArray ptr ptr
type IDirect3DRMPickedArray as IDirect3DRMPickedArray_
type LPDIRECT3DRMPICKEDARRAY as IDirect3DRMPickedArray ptr
type LPLPDIRECT3DRMPICKEDARRAY as IDirect3DRMPickedArray ptr ptr
type IDirect3DRMPicked2Array as IDirect3DRMPicked2Array_
type LPDIRECT3DRMPICKED2ARRAY as IDirect3DRMPicked2Array ptr
type LPLPDIRECT3DRMPICKED2ARRAY as IDirect3DRMPicked2Array ptr ptr
type IDirect3DRMLightArray as IDirect3DRMLightArray_
type LPDIRECT3DRMLIGHTARRAY as IDirect3DRMLightArray ptr
type LPLPDIRECT3DRMLIGHTARRAY as IDirect3DRMLightArray ptr ptr
type LPDIRECT3DRMPROGRESSIVEMESH as IDirect3DRMProgressiveMesh ptr
type LPLPDIRECT3DRMPROGRESSIVEMESH as IDirect3DRMProgressiveMesh ptr ptr
type LPDIRECT3DRMCLIPPEDVISUAL as IDirect3DRMClippedVisual ptr
type LPLPDIRECT3DRMCLIPPEDVISUAL as IDirect3DRMClippedVisual ptr ptr
type D3DRMOBJECTCALLBACK as sub cdecl(byval obj as IDirect3DRMObject ptr, byval arg as any ptr)
type D3DRMFRAMEMOVECALLBACK as sub cdecl(byval frame as IDirect3DRMFrame ptr, byval ctx as any ptr, byval delta as D3DVALUE)
type D3DRMFRAME3MOVECALLBACK as sub cdecl(byval frame as IDirect3DRMFrame3 ptr, byval ctx as any ptr, byval delta as D3DVALUE)
type D3DRMUPDATECALLBACK as sub cdecl(byval device as IDirect3DRMDevice ptr, byval ctx as any ptr, byval count as long, byval rects as D3DRECT ptr)
type D3DRMDEVICE3UPDATECALLBACK as sub cdecl(byval device as IDirect3DRMDevice3 ptr, byval ctx as any ptr, byval count as long, byval rects as D3DRECT ptr)
type D3DRMUSERVISUALCALLBACK as function cdecl(byval visual as IDirect3DRMUserVisual ptr, byval ctx as any ptr, byval reason as D3DRMUSERVISUALREASON, byval device as IDirect3DRMDevice ptr, byval viewport as IDirect3DRMViewport ptr) as long
type D3DRMLOADTEXTURECALLBACK as function cdecl(byval tex_name as zstring ptr, byval arg as any ptr, byval texture as IDirect3DRMTexture ptr ptr) as HRESULT
type D3DRMLOADTEXTURE3CALLBACK as function cdecl(byval tex_name as zstring ptr, byval arg as any ptr, byval texture as IDirect3DRMTexture3 ptr ptr) as HRESULT
type D3DRMLOADCALLBACK as sub cdecl(byval object as IDirect3DRMObject ptr, byval objectguid as const IID const ptr, byval arg as any ptr)
type D3DRMDOWNSAMPLECALLBACK as function cdecl(byval texture as IDirect3DRMTexture3 ptr, byval ctx as any ptr, byval src_surface as IDirectDrawSurface ptr, byval dst_surface as IDirectDrawSurface ptr) as HRESULT
type D3DRMVALIDATIONCALLBACK as function cdecl(byval texture as IDirect3DRMTexture3 ptr, byval ctx as any ptr, byval flags as DWORD, byval rect_count as DWORD, byval rects as RECT ptr) as HRESULT

type _D3DRMPICKDESC
	ulFaceIdx as ULONG
	lGroupIdx as LONG
	vPosition as D3DVECTOR
end type

type D3DRMPICKDESC as _D3DRMPICKDESC
type LPD3DRMPICKDESC as _D3DRMPICKDESC ptr

type _D3DRMPICKDESC2
	ulFaceIdx as ULONG
	lGroupIdx as LONG
	vPosition as D3DVECTOR
	tu as D3DVALUE
	tv as D3DVALUE
	dvNormal as D3DVECTOR
	dcColor as D3DCOLOR
end type

type D3DRMPICKDESC2 as _D3DRMPICKDESC2
type LPD3DRMPICKDESC2 as _D3DRMPICKDESC2 ptr
type IDirect3DRMObjectVtbl as IDirect3DRMObjectVtbl_

type IDirect3DRMObject_
	lpVtbl as IDirect3DRMObjectVtbl ptr
end type

type IDirect3DRMObjectVtbl_
	QueryInterface as function(byval This as IDirect3DRMObject ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMObject ptr) as ULONG
	Release as function(byval This as IDirect3DRMObject ptr) as ULONG
	Clone as function(byval This as IDirect3DRMObject ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddDestroyCallback as function(byval This as IDirect3DRMObject ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	DeleteDestroyCallback as function(byval This as IDirect3DRMObject ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	SetAppData as function(byval This as IDirect3DRMObject ptr, byval data as DWORD) as HRESULT
	GetAppData as function(byval This as IDirect3DRMObject ptr) as DWORD
	SetName as function(byval This as IDirect3DRMObject ptr, byval name as const zstring ptr) as HRESULT
	GetName as function(byval This as IDirect3DRMObject ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	GetClassName as function(byval This as IDirect3DRMObject ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
end type

#define IDirect3DRMObject_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMObject_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMObject_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMObject_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirect3DRMObject_AddDestroyCallback(p, a, b) (p)->lpVtbl->AddDestroyCallback(p, a, b)
#define IDirect3DRMObject_DeleteDestroyCallback(p, a, b) (p)->lpVtbl->DeleteDestroyCallback(p, a, b)
#define IDirect3DRMObject_SetAppData(p, a) (p)->lpVtbl->SetAppData(p, a)
#define IDirect3DRMObject_GetAppData(p) (p)->lpVtbl->GetAppData(p)
#define IDirect3DRMObject_SetName(p, a) (p)->lpVtbl->SetName(p, a)
#define IDirect3DRMObject_GetName(p, a, b) (p)->lpVtbl->GetName(p, a, b)
#define IDirect3DRMObject_GetClassName(p, a, b) (p)->lpVtbl->GetClassName(p, a, b)
type IDirect3DRMObject2Vtbl as IDirect3DRMObject2Vtbl_

type IDirect3DRMObject2
	lpVtbl as IDirect3DRMObject2Vtbl ptr
end type

type IDirect3DRMObject2Vtbl_
	QueryInterface as function(byval This as IDirect3DRMObject2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMObject2 ptr) as ULONG
	Release as function(byval This as IDirect3DRMObject2 ptr) as ULONG
	AddDestroyCallback as function(byval This as IDirect3DRMObject2 ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	Clone as function(byval This as IDirect3DRMObject2 ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	DeleteDestroyCallback as function(byval This as IDirect3DRMObject2 ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	GetClientData as function(byval This as IDirect3DRMObject2 ptr, byval id as DWORD, byval data as any ptr ptr) as HRESULT
	GetDirect3DRM as function(byval This as IDirect3DRMObject2 ptr, byval d3drm as IDirect3DRM ptr ptr) as HRESULT
	GetName as function(byval This as IDirect3DRMObject2 ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	SetClientData as function(byval This as IDirect3DRMObject2 ptr, byval id as DWORD, byval data as any ptr, byval flags as DWORD) as HRESULT
	SetName as function(byval This as IDirect3DRMObject2 ptr, byval name as const zstring ptr) as HRESULT
	GetAge as function(byval This as IDirect3DRMObject2 ptr, byval flags as DWORD, byval age as DWORD ptr) as HRESULT
end type

#define IDirect3DRMObject2_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMObject2_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMObject2_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMObject2_AddDestroyCallback(p, a, b) (p)->lpVtbl->AddDestroyCallback(p, a, b)
#define IDirect3DRMObject2_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirect3DRMObject2_DeleteDestroyCallback(p, a, b) (p)->lpVtbl->DeleteDestroyCallback(p, a, b)
#define IDirect3DRMObject2_GetClientData(p, a, b) (p)->lpVtbl->SetClientData(p, a, b)
#define IDirect3DRMObject2_GetDirect3DRM(p, a) (p)->lpVtbl->GetDirect3DRM(p, a)
#define IDirect3DRMObject2_GetName(p, a, b) (p)->lpVtbl->GetName(p, a, b)
#define IDirect3DRMObject2_SetClientData(p, a, b, c) (p)->lpVtbl->SetClientData(p, a, b, c)
#define IDirect3DRMObject2_SetName(p, a) (p)->lpVtbl->SetName(p, a)
#define IDirect3DRMObject2_GetAge(p, a, b) (p)->lpVtbl->GetAge(p, a, b)
type IDirect3DRMVisualVtbl as IDirect3DRMVisualVtbl_

type IDirect3DRMVisual
	lpVtbl as IDirect3DRMVisualVtbl ptr
end type

type IDirect3DRMVisualVtbl_
	QueryInterface as function(byval This as IDirect3DRMVisual ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMVisual ptr) as ULONG
	Release as function(byval This as IDirect3DRMVisual ptr) as ULONG
	Clone as function(byval This as IDirect3DRMVisual ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddDestroyCallback as function(byval This as IDirect3DRMVisual ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	DeleteDestroyCallback as function(byval This as IDirect3DRMVisual ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	SetAppData as function(byval This as IDirect3DRMVisual ptr, byval data as DWORD) as HRESULT
	GetAppData as function(byval This as IDirect3DRMVisual ptr) as DWORD
	SetName as function(byval This as IDirect3DRMVisual ptr, byval name as const zstring ptr) as HRESULT
	GetName as function(byval This as IDirect3DRMVisual ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	GetClassName as function(byval This as IDirect3DRMVisual ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
end type

#define IDirect3DRMVisual_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMVisual_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMVisual_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMVisual_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirect3DRMVisual_AddDestroyCallback(p, a, b) (p)->lpVtbl->AddDestroyCallback(p, a, b)
#define IDirect3DRMVisual_DeleteDestroyCallback(p, a, b) (p)->lpVtbl->DeleteDestroyCallback(p, a, b)
#define IDirect3DRMVisual_SetAppData(p, a) (p)->lpVtbl->SetAppData(p, a)
#define IDirect3DRMVisual_GetAppData(p) (p)->lpVtbl->GetAppData(p)
#define IDirect3DRMVisual_SetName(p, a) (p)->lpVtbl->SetName(p, a)
#define IDirect3DRMVisual_GetName(p, a, b) (p)->lpVtbl->GetName(p, a, b)
#define IDirect3DRMVisual_GetClassName(p, a, b) (p)->lpVtbl->GetClassName(p, a, b)
type IDirect3DRMDeviceVtbl as IDirect3DRMDeviceVtbl_

type IDirect3DRMDevice_
	lpVtbl as IDirect3DRMDeviceVtbl ptr
end type

type IDirect3DRMDeviceVtbl_
	QueryInterface as function(byval This as IDirect3DRMDevice ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMDevice ptr) as ULONG
	Release as function(byval This as IDirect3DRMDevice ptr) as ULONG
	Clone as function(byval This as IDirect3DRMDevice ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddDestroyCallback as function(byval This as IDirect3DRMDevice ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	DeleteDestroyCallback as function(byval This as IDirect3DRMDevice ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	SetAppData as function(byval This as IDirect3DRMDevice ptr, byval data as DWORD) as HRESULT
	GetAppData as function(byval This as IDirect3DRMDevice ptr) as DWORD
	SetName as function(byval This as IDirect3DRMDevice ptr, byval name as const zstring ptr) as HRESULT
	GetName as function(byval This as IDirect3DRMDevice ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	GetClassName as function(byval This as IDirect3DRMDevice ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	Init as function(byval This as IDirect3DRMDevice ptr, byval width as ULONG, byval height as ULONG) as HRESULT
	InitFromD3D as function(byval This as IDirect3DRMDevice ptr, byval d3d as IDirect3D ptr, byval d3d_device as IDirect3DDevice ptr) as HRESULT
	InitFromClipper as function(byval This as IDirect3DRMDevice ptr, byval clipper as IDirectDrawClipper ptr, byval guid as GUID ptr, byval width as long, byval height as long) as HRESULT
	Update as function(byval This as IDirect3DRMDevice ptr) as HRESULT
	AddUpdateCallback as function(byval This as IDirect3DRMDevice ptr, byval cb as D3DRMUPDATECALLBACK, byval ctx as any ptr) as HRESULT
	DeleteUpdateCallback as function(byval This as IDirect3DRMDevice ptr, byval cb as D3DRMUPDATECALLBACK, byval ctx as any ptr) as HRESULT
	SetBufferCount as function(byval This as IDirect3DRMDevice ptr, byval as DWORD) as HRESULT
	GetBufferCount as function(byval This as IDirect3DRMDevice ptr) as DWORD
	SetDither as function(byval This as IDirect3DRMDevice ptr, byval as WINBOOL) as HRESULT
	SetShades as function(byval This as IDirect3DRMDevice ptr, byval as DWORD) as HRESULT
	SetQuality as function(byval This as IDirect3DRMDevice ptr, byval as D3DRMRENDERQUALITY) as HRESULT
	SetTextureQuality as function(byval This as IDirect3DRMDevice ptr, byval as D3DRMTEXTUREQUALITY) as HRESULT
	GetViewports as function(byval This as IDirect3DRMDevice ptr, byval array as IDirect3DRMViewportArray ptr ptr) as HRESULT
	GetDither as function(byval This as IDirect3DRMDevice ptr) as WINBOOL
	GetShades as function(byval This as IDirect3DRMDevice ptr) as DWORD
	GetHeight as function(byval This as IDirect3DRMDevice ptr) as DWORD
	GetWidth as function(byval This as IDirect3DRMDevice ptr) as DWORD
	GetTrianglesDrawn as function(byval This as IDirect3DRMDevice ptr) as DWORD
	GetWireframeOptions as function(byval This as IDirect3DRMDevice ptr) as DWORD
	GetQuality as function(byval This as IDirect3DRMDevice ptr) as D3DRMRENDERQUALITY
	GetColorModel as function(byval This as IDirect3DRMDevice ptr) as D3DCOLORMODEL
	GetTextureQuality as function(byval This as IDirect3DRMDevice ptr) as D3DRMTEXTUREQUALITY
	GetDirect3DDevice as function(byval This as IDirect3DRMDevice ptr, byval d3d_device as IDirect3DDevice ptr ptr) as HRESULT
end type

#define IDirect3DRMDevice_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMDevice_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMDevice_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMDevice_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirect3DRMDevice_AddDestroyCallback(p, a, b) (p)->lpVtbl->AddDestroyCallback(p, a, b)
#define IDirect3DRMDevice_DeleteDestroyCallback(p, a, b) (p)->lpVtbl->DeleteDestroyCallback(p, a, b)
#define IDirect3DRMDevice_SetAppData(p, a) (p)->lpVtbl->SetAppData(p, a)
#define IDirect3DRMDevice_GetAppData(p) (p)->lpVtbl->GetAppData(p)
#define IDirect3DRMDevice_SetName(p, a) (p)->lpVtbl->SetName(p, a)
#define IDirect3DRMDevice_GetName(p, a, b) (p)->lpVtbl->GetName(p, a, b)
#define IDirect3DRMDevice_GetClassName(p, a, b) (p)->lpVtbl->GetClassName(p, a, b)
#define IDirect3DRMDevice_Init(p, a, b) (p)->lpVtbl->Init(p, a, b)
#define IDirect3DRMDevice_InitFromD3D(p, a, b) (p)->lpVtbl->InitFromD3D(p, a, b)
#define IDirect3DRMDevice_InitFromClipper(p, a, b, c, d) (p)->lpVtbl->InitFromClipper(p, a, b, c, d)
#define IDirect3DRMDevice_Update(p) (p)->lpVtbl->Update(p)
#define IDirect3DRMDevice_AddUpdateCallback(p, a, b) (p)->lpVtbl->AddUpdateCallback(p, a, b)
#define IDirect3DRMDevice_DeleteUpdateCallback(p, a, b) (p)->lpVtbl->DeleteUpdateCallback(p, a, b)
#define IDirect3DRMDevice_SetBufferCount(p, a) (p)->lpVtbl->SetBufferCount(p, a)
#define IDirect3DRMDevice_GetBufferCount(p) (p)->lpVtbl->GetBufferCount(p)
#define IDirect3DRMDevice_SetDither(p, a) (p)->lpVtbl->SetDither(p, a)
#define IDirect3DRMDevice_SetShades(p, a) (p)->lpVtbl->SetShades(p, a)
#define IDirect3DRMDevice_SetQuality(p, a) (p)->lpVtbl->SetQuality(p, a)
#define IDirect3DRMDevice_SetTextureQuality(p, a) (p)->lpVtbl->SetTextureQuality(p, a)
#define IDirect3DRMDevice_GetViewports(p, a) (p)->lpVtbl->GetViewports(p, a)
#define IDirect3DRMDevice_GetDither(p) (p)->lpVtbl->GetDither(p)
#define IDirect3DRMDevice_GetShades(p) (p)->lpVtbl->GetShades(p)
#define IDirect3DRMDevice_GetHeight(p) (p)->lpVtbl->GetHeight(p)
#define IDirect3DRMDevice_GetWidth(p) (p)->lpVtbl->GetWidth(p)
#define IDirect3DRMDevice_GetTrianglesDrawn(p) (p)->lpVtbl->GetTrianglesDrawn(p)
#define IDirect3DRMDevice_GetWireframeOptions(p) (p)->lpVtbl->GetWireframeOptions(p)
#define IDirect3DRMDevice_GetQuality(p) (p)->lpVtbl->GetQuality(p)
#define IDirect3DRMDevice_GetColorModel(p) (p)->lpVtbl->GetColorModel(p)
#define IDirect3DRMDevice_GetTextureQuality(p) (p)->lpVtbl->GetTextureQuality(p)
#define IDirect3DRMDevice_GetDirect3DDevice(p, a) (p)->lpVtbl->GetDirect3DDevice(p, a)
type IDirect3DRMDevice2Vtbl as IDirect3DRMDevice2Vtbl_

type IDirect3DRMDevice2
	lpVtbl as IDirect3DRMDevice2Vtbl ptr
end type

type IDirect3DRMDevice2Vtbl_
	QueryInterface as function(byval This as IDirect3DRMDevice2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMDevice2 ptr) as ULONG
	Release as function(byval This as IDirect3DRMDevice2 ptr) as ULONG
	Clone as function(byval This as IDirect3DRMDevice2 ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddDestroyCallback as function(byval This as IDirect3DRMDevice2 ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	DeleteDestroyCallback as function(byval This as IDirect3DRMDevice2 ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	SetAppData as function(byval This as IDirect3DRMDevice2 ptr, byval data as DWORD) as HRESULT
	GetAppData as function(byval This as IDirect3DRMDevice2 ptr) as DWORD
	SetName as function(byval This as IDirect3DRMDevice2 ptr, byval name as const zstring ptr) as HRESULT
	GetName as function(byval This as IDirect3DRMDevice2 ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	GetClassName as function(byval This as IDirect3DRMDevice2 ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	Init as function(byval This as IDirect3DRMDevice2 ptr, byval width as ULONG, byval height as ULONG) as HRESULT
	InitFromD3D as function(byval This as IDirect3DRMDevice2 ptr, byval d3d as IDirect3D ptr, byval d3d_device as IDirect3DDevice ptr) as HRESULT
	InitFromClipper as function(byval This as IDirect3DRMDevice2 ptr, byval clipper as IDirectDrawClipper ptr, byval guid as GUID ptr, byval width as long, byval height as long) as HRESULT
	Update as function(byval This as IDirect3DRMDevice2 ptr) as HRESULT
	AddUpdateCallback as function(byval This as IDirect3DRMDevice2 ptr, byval cb as D3DRMUPDATECALLBACK, byval ctx as any ptr) as HRESULT
	DeleteUpdateCallback as function(byval This as IDirect3DRMDevice2 ptr, byval cb as D3DRMUPDATECALLBACK, byval ctx as any ptr) as HRESULT
	SetBufferCount as function(byval This as IDirect3DRMDevice2 ptr, byval as DWORD) as HRESULT
	GetBufferCount as function(byval This as IDirect3DRMDevice2 ptr) as DWORD
	SetDither as function(byval This as IDirect3DRMDevice2 ptr, byval as WINBOOL) as HRESULT
	SetShades as function(byval This as IDirect3DRMDevice2 ptr, byval as DWORD) as HRESULT
	SetQuality as function(byval This as IDirect3DRMDevice2 ptr, byval as D3DRMRENDERQUALITY) as HRESULT
	SetTextureQuality as function(byval This as IDirect3DRMDevice2 ptr, byval as D3DRMTEXTUREQUALITY) as HRESULT
	GetViewports as function(byval This as IDirect3DRMDevice2 ptr, byval array as IDirect3DRMViewportArray ptr ptr) as HRESULT
	GetDither as function(byval This as IDirect3DRMDevice2 ptr) as WINBOOL
	GetShades as function(byval This as IDirect3DRMDevice2 ptr) as DWORD
	GetHeight as function(byval This as IDirect3DRMDevice2 ptr) as DWORD
	GetWidth as function(byval This as IDirect3DRMDevice2 ptr) as DWORD
	GetTrianglesDrawn as function(byval This as IDirect3DRMDevice2 ptr) as DWORD
	GetWireframeOptions as function(byval This as IDirect3DRMDevice2 ptr) as DWORD
	GetQuality as function(byval This as IDirect3DRMDevice2 ptr) as D3DRMRENDERQUALITY
	GetColorModel as function(byval This as IDirect3DRMDevice2 ptr) as D3DCOLORMODEL
	GetTextureQuality as function(byval This as IDirect3DRMDevice2 ptr) as D3DRMTEXTUREQUALITY
	GetDirect3DDevice as function(byval This as IDirect3DRMDevice2 ptr, byval d3d_device as IDirect3DDevice ptr ptr) as HRESULT
	InitFromD3D2 as function(byval This as IDirect3DRMDevice2 ptr, byval d3d as IDirect3D2 ptr, byval device as IDirect3DDevice2 ptr) as HRESULT
	InitFromSurface as function(byval This as IDirect3DRMDevice2 ptr, byval guid as GUID ptr, byval ddraw as IDirectDraw ptr, byval surface as IDirectDrawSurface ptr) as HRESULT
	SetRenderMode as function(byval This as IDirect3DRMDevice2 ptr, byval flags as DWORD) as HRESULT
	GetRenderMode as function(byval This as IDirect3DRMDevice2 ptr) as DWORD
	GetDirect3DDevice2 as function(byval This as IDirect3DRMDevice2 ptr, byval device as IDirect3DDevice2 ptr ptr) as HRESULT
end type

#define IDirect3DRMDevice2_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMDevice2_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMDevice2_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMDevice2_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirect3DRMDevice2_AddDestroyCallback(p, a, b) (p)->lpVtbl->AddDestroyCallback(p, a, b)
#define IDirect3DRMDevice2_DeleteDestroyCallback(p, a, b) (p)->lpVtbl->DeleteDestroyCallback(p, a, b)
#define IDirect3DRMDevice2_SetAppData(p, a) (p)->lpVtbl->SetAppData(p, a)
#define IDirect3DRMDevice2_GetAppData(p) (p)->lpVtbl->GetAppData(p)
#define IDirect3DRMDevice2_SetName(p, a) (p)->lpVtbl->SetName(p, a)
#define IDirect3DRMDevice2_GetName(p, a, b) (p)->lpVtbl->GetName(p, a, b)
#define IDirect3DRMDevice2_GetClassName(p, a, b) (p)->lpVtbl->GetClassName(p, a, b)
#define IDirect3DRMDevice2_Init(p, a, b) (p)->lpVtbl->Init(p, a, b)
#define IDirect3DRMDevice2_InitFromD3D(p, a, b) (p)->lpVtbl->InitFromD3D(p, a, b)
#define IDirect3DRMDevice2_InitFromClipper(p, a, b, c, d) (p)->lpVtbl->InitFromClipper(p, a, b, c, d)
#define IDirect3DRMDevice2_Update(p) (p)->lpVtbl->Update(p)
#define IDirect3DRMDevice2_AddUpdateCallback(p, a, b) (p)->lpVtbl->AddUpdateCallback(p, a, b)
#define IDirect3DRMDevice2_DeleteUpdateCallback(p, a, b) (p)->lpVtbl->DeleteUpdateCallback(p, a, b)
#define IDirect3DRMDevice2_SetBufferCount(p, a) (p)->lpVtbl->SetBufferCount(p, a)
#define IDirect3DRMDevice2_GetBufferCount(p) (p)->lpVtbl->GetBufferCount(p)
#define IDirect3DRMDevice2_SetDither(p, a) (p)->lpVtbl->SetDither(p, a)
#define IDirect3DRMDevice2_SetShades(p, a) (p)->lpVtbl->SetShades(p, a)
#define IDirect3DRMDevice2_SetQuality(p, a) (p)->lpVtbl->SetQuality(p, a)
#define IDirect3DRMDevice2_SetTextureQuality(p, a) (p)->lpVtbl->SetTextureQuality(p, a)
#define IDirect3DRMDevice2_GetViewports(p, a) (p)->lpVtbl->GetViewports(p, a)
#define IDirect3DRMDevice2_GetDither(p) (p)->lpVtbl->GetDither(p)
#define IDirect3DRMDevice2_GetShades(p) (p)->lpVtbl->GetShades(p)
#define IDirect3DRMDevice2_GetHeight(p) (p)->lpVtbl->GetHeight(p)
#define IDirect3DRMDevice2_GetWidth(p) (p)->lpVtbl->GetWidth(p)
#define IDirect3DRMDevice2_GetTrianglesDrawn(p) (p)->lpVtbl->GetTrianglesDrawn(p)
#define IDirect3DRMDevice2_GetWireframeOptions(p) (p)->lpVtbl->GetWireframeOptions(p)
#define IDirect3DRMDevice2_GetQuality(p) (p)->lpVtbl->GetQuality(p)
#define IDirect3DRMDevice2_GetColorModel(p) (p)->lpVtbl->GetColorModel(p)
#define IDirect3DRMDevice2_GetTextureQuality(p) (p)->lpVtbl->GetTextureQuality(p)
#define IDirect3DRMDevice2_GetDirect3DDevice(p, a) (p)->lpVtbl->GetDirect3DDevice(p, a)
#define IDirect3DRMDevice2_InitFromD3D2(p, a, b) (p)->lpVtbl->InitFromD3D2(p, a, b)
#define IDirect3DRMDevice2_InitFromSurface(p, a, b, c) (p)->lpVtbl->InitFromSurface(p, a, b, c)
#define IDirect3DRMDevice2_SetRenderMode(p, a) (p)->lpVtbl->SetRenderMode(p, a)
#define IDirect3DRMDevice2_GetRenderMode(p) (p)->lpVtbl->GetRenderMode(p)
#define IDirect3DRMDevice2_GetDirect3DDevice2(p, a) (p)->lpVtbl->GetDirect3DDevice2(p, a)
type IDirect3DRMDevice3Vtbl as IDirect3DRMDevice3Vtbl_

type IDirect3DRMDevice3_
	lpVtbl as IDirect3DRMDevice3Vtbl ptr
end type

type IDirect3DRMDevice3Vtbl_
	QueryInterface as function(byval This as IDirect3DRMDevice3 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMDevice3 ptr) as ULONG
	Release as function(byval This as IDirect3DRMDevice3 ptr) as ULONG
	Clone as function(byval This as IDirect3DRMDevice3 ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddDestroyCallback as function(byval This as IDirect3DRMDevice3 ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	DeleteDestroyCallback as function(byval This as IDirect3DRMDevice3 ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	SetAppData as function(byval This as IDirect3DRMDevice3 ptr, byval data as DWORD) as HRESULT
	GetAppData as function(byval This as IDirect3DRMDevice3 ptr) as DWORD
	SetName as function(byval This as IDirect3DRMDevice3 ptr, byval name as const zstring ptr) as HRESULT
	GetName as function(byval This as IDirect3DRMDevice3 ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	GetClassName as function(byval This as IDirect3DRMDevice3 ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	Init as function(byval This as IDirect3DRMDevice3 ptr, byval width as ULONG, byval height as ULONG) as HRESULT
	InitFromD3D as function(byval This as IDirect3DRMDevice3 ptr, byval d3d as IDirect3D ptr, byval d3d_device as IDirect3DDevice ptr) as HRESULT
	InitFromClipper as function(byval This as IDirect3DRMDevice3 ptr, byval clipper as IDirectDrawClipper ptr, byval guid as GUID ptr, byval width as long, byval height as long) as HRESULT
	Update as function(byval This as IDirect3DRMDevice3 ptr) as HRESULT
	AddUpdateCallback as function(byval This as IDirect3DRMDevice3 ptr, byval cb as D3DRMUPDATECALLBACK, byval ctx as any ptr) as HRESULT
	DeleteUpdateCallback as function(byval This as IDirect3DRMDevice3 ptr, byval cb as D3DRMUPDATECALLBACK, byval ctx as any ptr) as HRESULT
	SetBufferCount as function(byval This as IDirect3DRMDevice3 ptr, byval as DWORD) as HRESULT
	GetBufferCount as function(byval This as IDirect3DRMDevice3 ptr) as DWORD
	SetDither as function(byval This as IDirect3DRMDevice3 ptr, byval as WINBOOL) as HRESULT
	SetShades as function(byval This as IDirect3DRMDevice3 ptr, byval as DWORD) as HRESULT
	SetQuality as function(byval This as IDirect3DRMDevice3 ptr, byval as D3DRMRENDERQUALITY) as HRESULT
	SetTextureQuality as function(byval This as IDirect3DRMDevice3 ptr, byval as D3DRMTEXTUREQUALITY) as HRESULT
	GetViewports as function(byval This as IDirect3DRMDevice3 ptr, byval array as IDirect3DRMViewportArray ptr ptr) as HRESULT
	GetDither as function(byval This as IDirect3DRMDevice3 ptr) as WINBOOL
	GetShades as function(byval This as IDirect3DRMDevice3 ptr) as DWORD
	GetHeight as function(byval This as IDirect3DRMDevice3 ptr) as DWORD
	GetWidth as function(byval This as IDirect3DRMDevice3 ptr) as DWORD
	GetTrianglesDrawn as function(byval This as IDirect3DRMDevice3 ptr) as DWORD
	GetWireframeOptions as function(byval This as IDirect3DRMDevice3 ptr) as DWORD
	GetQuality as function(byval This as IDirect3DRMDevice3 ptr) as D3DRMRENDERQUALITY
	GetColorModel as function(byval This as IDirect3DRMDevice3 ptr) as D3DCOLORMODEL
	GetTextureQuality as function(byval This as IDirect3DRMDevice3 ptr) as D3DRMTEXTUREQUALITY
	GetDirect3DDevice as function(byval This as IDirect3DRMDevice3 ptr, byval d3d_device as IDirect3DDevice ptr ptr) as HRESULT
	InitFromD3D2 as function(byval This as IDirect3DRMDevice3 ptr, byval d3d as IDirect3D2 ptr, byval device as IDirect3DDevice2 ptr) as HRESULT
	InitFromSurface as function(byval This as IDirect3DRMDevice3 ptr, byval guid as GUID ptr, byval ddraw as IDirectDraw ptr, byval surface as IDirectDrawSurface ptr) as HRESULT
	SetRenderMode as function(byval This as IDirect3DRMDevice3 ptr, byval flags as DWORD) as HRESULT
	GetRenderMode as function(byval This as IDirect3DRMDevice3 ptr) as DWORD
	GetDirect3DDevice2 as function(byval This as IDirect3DRMDevice3 ptr, byval device as IDirect3DDevice2 ptr ptr) as HRESULT
	FindPreferredTextureFormat as function(byval This as IDirect3DRMDevice3 ptr, byval BitDepths as DWORD, byval flags as DWORD, byval format as DDPIXELFORMAT ptr) as HRESULT
	RenderStateChange as function(byval This as IDirect3DRMDevice3 ptr, byval drsType as D3DRENDERSTATETYPE, byval val as DWORD, byval flags as DWORD) as HRESULT
	LightStateChange as function(byval This as IDirect3DRMDevice3 ptr, byval drsType as D3DLIGHTSTATETYPE, byval val as DWORD, byval flags as DWORD) as HRESULT
	GetStateChangeOptions as function(byval This as IDirect3DRMDevice3 ptr, byval state_class as DWORD, byval state_idx as DWORD, byval flags as DWORD ptr) as HRESULT
	SetStateChangeOptions as function(byval This as IDirect3DRMDevice3 ptr, byval StateClass as DWORD, byval StateNum as DWORD, byval flags as DWORD) as HRESULT
end type

#define IDirect3DRMDevice3_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMDevice3_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMDevice3_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMDevice3_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirect3DRMDevice3_AddDestroyCallback(p, a, b) (p)->lpVtbl->AddDestroyCallback(p, a, b)
#define IDirect3DRMDevice3_DeleteDestroyCallback(p, a, b) (p)->lpVtbl->DeleteDestroyCallback(p, a, b)
#define IDirect3DRMDevice3_SetAppData(p, a) (p)->lpVtbl->SetAppData(p, a)
#define IDirect3DRMDevice3_GetAppData(p) (p)->lpVtbl->GetAppData(p)
#define IDirect3DRMDevice3_SetName(p, a) (p)->lpVtbl->SetName(p, a)
#define IDirect3DRMDevice3_GetName(p, a, b) (p)->lpVtbl->GetName(p, a, b)
#define IDirect3DRMDevice3_GetClassName(p, a, b) (p)->lpVtbl->GetClassName(p, a, b)
#define IDirect3DRMDevice3_Init(p, a, b) (p)->lpVtbl->Init(p, a, b)
#define IDirect3DRMDevice3_InitFromD3D(p, a, b) (p)->lpVtbl->InitFromD3D(p, a, b)
#define IDirect3DRMDevice3_InitFromClipper(p, a, b, c, d) (p)->lpVtbl->InitFromClipper(p, a, b, c, d)
#define IDirect3DRMDevice3_Update(p) (p)->lpVtbl->Update(p)
#define IDirect3DRMDevice3_AddUpdateCallback(p, a, b) (p)->lpVtbl->AddUpdateCallback(p, a, b)
#define IDirect3DRMDevice3_DeleteUpdateCallback(p, a, b) (p)->lpVtbl->DeleteUpdateCallback(p, a, b)
#define IDirect3DRMDevice3_SetBufferCount(p, a) (p)->lpVtbl->SetBufferCount(p, a)
#define IDirect3DRMDevice3_GetBufferCount(p) (p)->lpVtbl->GetBufferCount(p)
#define IDirect3DRMDevice3_SetDither(p, a) (p)->lpVtbl->SetDither(p, a)
#define IDirect3DRMDevice3_SetShades(p, a) (p)->lpVtbl->SetShades(p, a)
#define IDirect3DRMDevice3_SetQuality(p, a) (p)->lpVtbl->SetQuality(p, a)
#define IDirect3DRMDevice3_SetTextureQuality(p, a) (p)->lpVtbl->SetTextureQuality(p, a)
#define IDirect3DRMDevice3_GetViewports(p, a) (p)->lpVtbl->GetViewports(p, a)
#define IDirect3DRMDevice3_GetDither(p) (p)->lpVtbl->GetDither(p)
#define IDirect3DRMDevice3_GetShades(p) (p)->lpVtbl->GetShades(p)
#define IDirect3DRMDevice3_GetHeight(p) (p)->lpVtbl->GetHeight(p)
#define IDirect3DRMDevice3_GetWidth(p) (p)->lpVtbl->GetWidth(p)
#define IDirect3DRMDevice3_GetTrianglesDrawn(p) (p)->lpVtbl->GetTrianglesDrawn(p)
#define IDirect3DRMDevice3_GetWireframeOptions(p) (p)->lpVtbl->GetWireframeOptions(p)
#define IDirect3DRMDevice3_GetQuality(p) (p)->lpVtbl->GetQuality(p)
#define IDirect3DRMDevice3_GetColorModel(p) (p)->lpVtbl->GetColorModel(p)
#define IDirect3DRMDevice3_GetTextureQuality(p) (p)->lpVtbl->GetTextureQuality(p)
#define IDirect3DRMDevice3_GetDirect3DDevice(p, a) (p)->lpVtbl->GetDirect3DDevice(p, a)
#define IDirect3DRMDevice3_InitFromD3D2(p, a, b) (p)->lpVtbl->InitFromD3D2(p, a, b)
#define IDirect3DRMDevice3_InitFromSurface(p, a, b, c) (p)->lpVtbl->InitFromSurface(p, a, b, c)
#define IDirect3DRMDevice3_SetRenderMode(p, a) (p)->lpVtbl->SetRenderMode(p, a)
#define IDirect3DRMDevice3_GetRenderMode(p) (p)->lpVtbl->GetRenderMode(p)
#define IDirect3DRMDevice3_GetDirect3DDevice2(p, a) (p)->lpVtbl->GetDirect3DDevice2(p, a)
#define IDirect3DRMDevice3_FindPreferredTextureFormat(p, a, b, c) (p)->lpVtbl->FindPreferredTextureFormat(p, a, b, c)
#define IDirect3DRMDevice3_RenderStateChange(p, a, b, c) (p)->lpVtbl->RenderStateChange(p, a, b, c)
#define IDirect3DRMDevice3_LightStateChange(p, a, b, c) (p)->lpVtbl->LightStateChange(p, a, b, c)
#define IDirect3DRMDevice3_GetStateChangeOptions(p, a, b, c) (p)->lpVtbl->GetStateChangeOptions(p, a, b, c)
#define IDirect3DRMDevice3_SetStateChangeOptions(p, a, b, c) (p)->lpVtbl->SetStateChangeOptions(p, a, b, c)
type IDirect3DRMViewportVtbl as IDirect3DRMViewportVtbl_

type IDirect3DRMViewport_
	lpVtbl as IDirect3DRMViewportVtbl ptr
end type

type IDirect3DRMViewportVtbl_
	QueryInterface as function(byval This as IDirect3DRMViewport ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMViewport ptr) as ULONG
	Release as function(byval This as IDirect3DRMViewport ptr) as ULONG
	Clone as function(byval This as IDirect3DRMViewport ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddDestroyCallback as function(byval This as IDirect3DRMViewport ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	DeleteDestroyCallback as function(byval This as IDirect3DRMViewport ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	SetAppData as function(byval This as IDirect3DRMViewport ptr, byval data as DWORD) as HRESULT
	GetAppData as function(byval This as IDirect3DRMViewport ptr) as DWORD
	SetName as function(byval This as IDirect3DRMViewport ptr, byval name as const zstring ptr) as HRESULT
	GetName as function(byval This as IDirect3DRMViewport ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	GetClassName as function(byval This as IDirect3DRMViewport ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	Init as function(byval This as IDirect3DRMViewport ptr, byval device as IDirect3DRMDevice ptr, byval camera as IDirect3DRMFrame ptr, byval x as DWORD, byval y as DWORD, byval width as DWORD, byval height as DWORD) as HRESULT
	Clear as function(byval This as IDirect3DRMViewport ptr) as HRESULT
	Render as function(byval This as IDirect3DRMViewport ptr, byval frame as IDirect3DRMFrame ptr) as HRESULT
	SetFront as function(byval This as IDirect3DRMViewport ptr, byval as D3DVALUE) as HRESULT
	SetBack as function(byval This as IDirect3DRMViewport ptr, byval as D3DVALUE) as HRESULT
	SetField as function(byval This as IDirect3DRMViewport ptr, byval as D3DVALUE) as HRESULT
	SetUniformScaling as function(byval This as IDirect3DRMViewport ptr, byval as WINBOOL) as HRESULT
	SetCamera as function(byval This as IDirect3DRMViewport ptr, byval camera as IDirect3DRMFrame ptr) as HRESULT
	SetProjection as function(byval This as IDirect3DRMViewport ptr, byval as D3DRMPROJECTIONTYPE) as HRESULT
	Transform as function(byval This as IDirect3DRMViewport ptr, byval d as D3DRMVECTOR4D ptr, byval s as D3DVECTOR ptr) as HRESULT
	InverseTransform as function(byval This as IDirect3DRMViewport ptr, byval d as D3DVECTOR ptr, byval s as D3DRMVECTOR4D ptr) as HRESULT
	Configure as function(byval This as IDirect3DRMViewport ptr, byval x as LONG, byval y as LONG, byval width as DWORD, byval height as DWORD) as HRESULT
	ForceUpdate as function(byval This as IDirect3DRMViewport ptr, byval x1 as DWORD, byval y1 as DWORD, byval x2 as DWORD, byval y2 as DWORD) as HRESULT
	SetPlane as function(byval This as IDirect3DRMViewport ptr, byval left as D3DVALUE, byval right as D3DVALUE, byval bottom as D3DVALUE, byval top as D3DVALUE) as HRESULT
	GetCamera as function(byval This as IDirect3DRMViewport ptr, byval camera as IDirect3DRMFrame ptr ptr) as HRESULT
	GetDevice as function(byval This as IDirect3DRMViewport ptr, byval device as IDirect3DRMDevice ptr ptr) as HRESULT
	GetPlane as function(byval This as IDirect3DRMViewport ptr, byval left as D3DVALUE ptr, byval right as D3DVALUE ptr, byval bottom as D3DVALUE ptr, byval top as D3DVALUE ptr) as HRESULT
	Pick as function(byval This as IDirect3DRMViewport ptr, byval x as LONG, byval y as LONG, byval visuals as IDirect3DRMPickedArray ptr ptr) as HRESULT
	GetUniformScaling as function(byval This as IDirect3DRMViewport ptr) as WINBOOL
	GetX as function(byval This as IDirect3DRMViewport ptr) as LONG
	GetY as function(byval This as IDirect3DRMViewport ptr) as LONG
	GetWidth as function(byval This as IDirect3DRMViewport ptr) as DWORD
	GetHeight as function(byval This as IDirect3DRMViewport ptr) as DWORD
	GetField as function(byval This as IDirect3DRMViewport ptr) as D3DVALUE
	GetBack as function(byval This as IDirect3DRMViewport ptr) as D3DVALUE
	GetFront as function(byval This as IDirect3DRMViewport ptr) as D3DVALUE
	GetProjection as function(byval This as IDirect3DRMViewport ptr) as D3DRMPROJECTIONTYPE
	GetDirect3DViewport as function(byval This as IDirect3DRMViewport ptr, byval viewport as IDirect3DViewport ptr ptr) as HRESULT
end type

#define IDirect3DRMViewport_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMViewport_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMViewport_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMViewport_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirect3DRMViewport_AddDestroyCallback(p, a, b) (p)->lpVtbl->AddDestroyCallback(p, a, b)
#define IDirect3DRMViewport_DeleteDestroyCallback(p, a, b) (p)->lpVtbl->DeleteDestroyCallback(p, a, b)
#define IDirect3DRMViewport_SetAppData(p, a) (p)->lpVtbl->SetAppData(p, a)
#define IDirect3DRMViewport_GetAppData(p) (p)->lpVtbl->GetAppData(p)
#define IDirect3DRMViewport_SetName(p, a) (p)->lpVtbl->SetName(p, a)
#define IDirect3DRMViewport_GetName(p, a, b) (p)->lpVtbl->GetName(p, a, b)
#define IDirect3DRMViewport_GetClassName(p, a, b) (p)->lpVtbl->GetClassName(p, a, b)
#define IDirect3DRMViewport_Init(p, a, b, c, d) (p)->lpVtbl->Init(p, a, b, c, d)
#define IDirect3DRMViewport_Clear(p) (p)->lpVtbl->Clear(p)
#define IDirect3DRMViewport_Render(p, a) (p)->lpVtbl->Render(p, a)
#define IDirect3DRMViewport_SetFront(p, a) (p)->lpVtbl->SetFront(p, a)
#define IDirect3DRMViewport_SetBack(p, a) (p)->lpVtbl->SetBack(p, a)
#define IDirect3DRMViewport_SetField(p, a) (p)->lpVtbl->SetField(p, a)
#define IDirect3DRMViewport_SetUniformScaling(p, a) (p)->lpVtbl->SetUniformScaling(p, a)
#define IDirect3DRMViewport_SetCamera(p, a) (p)->lpVtbl->SetCamera(p, a)
#define IDirect3DRMViewport_SetProjection(p, a) (p)->lpVtbl->SetProjection(p, a)
#define IDirect3DRMViewport_Transform(p, a, b) (p)->lpVtbl->Transform(p, a, b)
#define IDirect3DRMViewport_InverseTransform(p, a, b) (p)->lpVtbl->InverseTransform(p, a, b)
#define IDirect3DRMViewport_Configure(p, a, b, c, d) (p)->lpVtbl->Configure(p, a, b, c, d)
#define IDirect3DRMViewport_ForceUpdate(p, a, b, c, d) (p)->lpVtbl->ForceUpdate(p, a, b, c, d)
#define IDirect3DRMViewport_SetPlane(p, a, b, c, d) (p)->lpVtbl->SetPlane(p, a, b, c, d)
#define IDirect3DRMViewport_GetCamera(p, a) (p)->lpVtbl->GetCamera(p, a)
#define IDirect3DRMViewport_GetDevice(p, a) (p)->lpVtbl->GetDevice(p, a)
#define IDirect3DRMViewport_GetPlane(p, a, b, c, d) (p)->lpVtbl->GetPlane(p, a, b, c, d)
#define IDirect3DRMViewport_Pick(p, a, b, c) (p)->lpVtbl->Pick(p, a, b, c)
#define IDirect3DRMViewport_GetUniformScaling(p) (p)->lpVtbl->GetUniformScaling(p)
#define IDirect3DRMViewport_GetX(p) (p)->lpVtbl->GetX(p)
#define IDirect3DRMViewport_GetY(p) (p)->lpVtbl->GetY(p)
#define IDirect3DRMViewport_GetWidth(p) (p)->lpVtbl->GetWidth(p)
#define IDirect3DRMViewport_GetHeight(p) (p)->lpVtbl->GetHeight(p)
#define IDirect3DRMViewport_GetField(p) (p)->lpVtbl->GetField(p)
#define IDirect3DRMViewport_GetBack(p) (p)->lpVtbl->GetBack(p)
#define IDirect3DRMViewport_GetFront(p) (p)->lpVtbl->GetFront(p)
#define IDirect3DRMViewport_GetProjection(p) (p)->lpVtbl->GetProjection(p)
#define IDirect3DRMViewport_GetDirect3DViewport(p, a) (p)->lpVtbl->GetDirect3DViewport(p, a)
type IDirect3DRMViewport2Vtbl as IDirect3DRMViewport2Vtbl_

type IDirect3DRMViewport2
	lpVtbl as IDirect3DRMViewport2Vtbl ptr
end type

type IDirect3DRMViewport2Vtbl_
	QueryInterface as function(byval This as IDirect3DRMViewport2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMViewport2 ptr) as ULONG
	Release as function(byval This as IDirect3DRMViewport2 ptr) as ULONG
	Clone as function(byval This as IDirect3DRMViewport2 ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddDestroyCallback as function(byval This as IDirect3DRMViewport2 ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	DeleteDestroyCallback as function(byval This as IDirect3DRMViewport2 ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	SetAppData as function(byval This as IDirect3DRMViewport2 ptr, byval data as DWORD) as HRESULT
	GetAppData as function(byval This as IDirect3DRMViewport2 ptr) as DWORD
	SetName as function(byval This as IDirect3DRMViewport2 ptr, byval name as const zstring ptr) as HRESULT
	GetName as function(byval This as IDirect3DRMViewport2 ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	GetClassName as function(byval This as IDirect3DRMViewport2 ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	Init as function(byval This as IDirect3DRMViewport2 ptr, byval device as IDirect3DRMDevice3 ptr, byval camera as IDirect3DRMFrame3 ptr, byval x as DWORD, byval y as DWORD, byval width as DWORD, byval height as DWORD) as HRESULT
	Clear as function(byval This as IDirect3DRMViewport2 ptr, byval flags as DWORD) as HRESULT
	Render as function(byval This as IDirect3DRMViewport2 ptr, byval frame as IDirect3DRMFrame3 ptr) as HRESULT
	SetFront as function(byval This as IDirect3DRMViewport2 ptr, byval as D3DVALUE) as HRESULT
	SetBack as function(byval This as IDirect3DRMViewport2 ptr, byval as D3DVALUE) as HRESULT
	SetField as function(byval This as IDirect3DRMViewport2 ptr, byval as D3DVALUE) as HRESULT
	SetUniformScaling as function(byval This as IDirect3DRMViewport2 ptr, byval as WINBOOL) as HRESULT
	SetCamera as function(byval This as IDirect3DRMViewport2 ptr, byval camera as IDirect3DRMFrame3 ptr) as HRESULT
	SetProjection as function(byval This as IDirect3DRMViewport2 ptr, byval as D3DRMPROJECTIONTYPE) as HRESULT
	Transform as function(byval This as IDirect3DRMViewport2 ptr, byval d as D3DRMVECTOR4D ptr, byval s as D3DVECTOR ptr) as HRESULT
	InverseTransform as function(byval This as IDirect3DRMViewport2 ptr, byval d as D3DVECTOR ptr, byval s as D3DRMVECTOR4D ptr) as HRESULT
	Configure as function(byval This as IDirect3DRMViewport2 ptr, byval x as LONG, byval y as LONG, byval width as DWORD, byval height as DWORD) as HRESULT
	ForceUpdate as function(byval This as IDirect3DRMViewport2 ptr, byval x1 as DWORD, byval y1 as DWORD, byval x2 as DWORD, byval y2 as DWORD) as HRESULT
	SetPlane as function(byval This as IDirect3DRMViewport2 ptr, byval left as D3DVALUE, byval right as D3DVALUE, byval bottom as D3DVALUE, byval top as D3DVALUE) as HRESULT
	GetCamera as function(byval This as IDirect3DRMViewport2 ptr, byval camera as IDirect3DRMFrame3 ptr ptr) as HRESULT
	GetDevice as function(byval This as IDirect3DRMViewport2 ptr, byval device as IDirect3DRMDevice3 ptr ptr) as HRESULT
	GetPlane as function(byval This as IDirect3DRMViewport2 ptr, byval left as D3DVALUE ptr, byval right as D3DVALUE ptr, byval bottom as D3DVALUE ptr, byval top as D3DVALUE ptr) as HRESULT
	Pick as function(byval This as IDirect3DRMViewport2 ptr, byval x as LONG, byval y as LONG, byval visuals as IDirect3DRMPickedArray ptr ptr) as HRESULT
	GetUniformScaling as function(byval This as IDirect3DRMViewport2 ptr) as WINBOOL
	GetX as function(byval This as IDirect3DRMViewport2 ptr) as LONG
	GetY as function(byval This as IDirect3DRMViewport2 ptr) as LONG
	GetWidth as function(byval This as IDirect3DRMViewport2 ptr) as DWORD
	GetHeight as function(byval This as IDirect3DRMViewport2 ptr) as DWORD
	GetField as function(byval This as IDirect3DRMViewport2 ptr) as D3DVALUE
	GetBack as function(byval This as IDirect3DRMViewport2 ptr) as D3DVALUE
	GetFront as function(byval This as IDirect3DRMViewport2 ptr) as D3DVALUE
	GetProjection as function(byval This as IDirect3DRMViewport2 ptr) as D3DRMPROJECTIONTYPE
	GetDirect3DViewport as function(byval This as IDirect3DRMViewport2 ptr, byval viewport as IDirect3DViewport ptr ptr) as HRESULT
	TransformVectors as function(byval This as IDirect3DRMViewport2 ptr, byval vector_count as DWORD, byval dst_vectors as D3DRMVECTOR4D ptr, byval src_vectors as D3DVECTOR ptr) as HRESULT
	InverseTransformVectors as function(byval This as IDirect3DRMViewport2 ptr, byval vector_count as DWORD, byval dst_vectors as D3DVECTOR ptr, byval src_vectors as D3DRMVECTOR4D ptr) as HRESULT
end type

#define IDirect3DRMViewport2_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMViewport2_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMViewport2_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMViewport_2Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirect3DRMViewport2_AddDestroyCallback(p, a, b) (p)->lpVtbl->AddDestroyCallback(p, a, b)
#define IDirect3DRMViewport2_DeleteDestroyCallback(p, a, b) (p)->lpVtbl->DeleteDestroyCallback(p, a, b)
#define IDirect3DRMViewport2_SetAppData(p, a) (p)->lpVtbl->SetAppData(p, a)
#define IDirect3DRMViewport2_GetAppData(p) (p)->lpVtbl->GetAppData(p)
#define IDirect3DRMViewport2_SetName(p, a) (p)->lpVtbl->SetName(p, a)
#define IDirect3DRMViewport2_GetName(p, a, b) (p)->lpVtbl->GetName(p, a, b)
#define IDirect3DRMViewport2_GetClassName(p, a, b) (p)->lpVtbl->GetClassName(p, a, b)
#define IDirect3DRMViewport2_Init(p, a, b, c, d, e, f) (p)->lpVtbl->Init(p, a, b, c, d, e, f)
#define IDirect3DRMViewport2_Clear(p, a) (p)->lpVtbl->Clear(p, a)
#define IDirect3DRMViewport2_Render(p, a) (p)->lpVtbl->Render(p, a)
#define IDirect3DRMViewport2_SetFront(p, a) (p)->lpVtbl->SetFront(p, a)
#define IDirect3DRMViewport2_SetBack(p, a) (p)->lpVtbl->SetBack(p, a)
#define IDirect3DRMViewport2_SetField(p, a) (p)->lpVtbl->SetField(p, a)
#define IDirect3DRMViewport2_SetUniformScaling(p, a) (p)->lpVtbl->SetUniformScaling(p, a)
#define IDirect3DRMViewport2_SetCamera(p, a) (p)->lpVtbl->SetCamera(p, a)
#define IDirect3DRMViewport2_SetProjection(p, a) (p)->lpVtbl->SetProjection(p, a)
#define IDirect3DRMViewport2_Transform(p, a, b) (p)->lpVtbl->Transform(p, a, b)
#define IDirect3DRMViewport2_InverseTransform(p, a, b) (p)->lpVtbl->InverseTransform(p, a, b)
#define IDirect3DRMViewport2_Configure(p, a, b, c, d) (p)->lpVtbl->Configure(p, a, b, c, d)
#define IDirect3DRMViewport2_ForceUpdate(p, a, b, c, d) (p)->lpVtbl->ForceUpdate(p, a, b, c, d)
#define IDirect3DRMViewport2_SetPlane(p, a, b, c, d) (p)->lpVtbl->SetPlane(p, a, b, c, d)
#define IDirect3DRMViewport2_GetCamera(p, a) (p)->lpVtbl->GetCamera(p, a)
#define IDirect3DRMViewport2_GetDevice(p, a) (p)->lpVtbl->GetDevice(p, a)
#define IDirect3DRMViewport2_GetPlane(p, a, b, c, d) (p)->lpVtbl->GetPlane(p, a, b, c, d)
#define IDirect3DRMViewport2_Pick(p, a, b, c) (p)->lpVtbl->Pick(p, a, b, c)
#define IDirect3DRMViewport2_GetUniformScaling(p) (p)->lpVtbl->GetUniformScaling(p)
#define IDirect3DRMViewport2_GetX(p) (p)->lpVtbl->GetX(p)
#define IDirect3DRMViewport2_GetY(p) (p)->lpVtbl->GetY(p)
#define IDirect3DRMViewport2_GetWidth(p) (p)->lpVtbl->GetWidth(p)
#define IDirect3DRMViewport2_GetHeight(p) (p)->lpVtbl->GetHeight(p)
#define IDirect3DRMViewport2_GetField(p) (p)->lpVtbl->GetField(p)
#define IDirect3DRMViewport2_GetBack(p) (p)->lpVtbl->GetBack(p)
#define IDirect3DRMViewport2_GetFront(p) (p)->lpVtbl->GetFront(p)
#define IDirect3DRMViewport2_GetProjection(p) (p)->lpVtbl->GetProjection(p)
#define IDirect3DRMViewport2_GetDirect3DViewport(p, a) (p)->lpVtbl->GetDirect3DViewport(p, a)
#define IDirect3DRMViewport2_TransformVectors(p, a, b, c) (p)->lpVtbl->TransformVectors(p, a, b, c)
#define IDirect3DRMViewport2_InverseTransformVectors(p, a, b, c) (p)->lpVtbl->InverseTransformVectors(p, a, b, c)
type IDirect3DRMFrameVtbl as IDirect3DRMFrameVtbl_

type IDirect3DRMFrame_
	lpVtbl as IDirect3DRMFrameVtbl ptr
end type

type IDirect3DRMFrameVtbl_
	QueryInterface as function(byval This as IDirect3DRMFrame ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMFrame ptr) as ULONG
	Release as function(byval This as IDirect3DRMFrame ptr) as ULONG
	Clone as function(byval This as IDirect3DRMFrame ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddDestroyCallback as function(byval This as IDirect3DRMFrame ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	DeleteDestroyCallback as function(byval This as IDirect3DRMFrame ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	SetAppData as function(byval This as IDirect3DRMFrame ptr, byval data as DWORD) as HRESULT
	GetAppData as function(byval This as IDirect3DRMFrame ptr) as DWORD
	SetName as function(byval This as IDirect3DRMFrame ptr, byval name as const zstring ptr) as HRESULT
	GetName as function(byval This as IDirect3DRMFrame ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	GetClassName as function(byval This as IDirect3DRMFrame ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	AddChild as function(byval This as IDirect3DRMFrame ptr, byval child as IDirect3DRMFrame ptr) as HRESULT
	AddLight as function(byval This as IDirect3DRMFrame ptr, byval light as IDirect3DRMLight ptr) as HRESULT
	AddMoveCallback as function(byval This as IDirect3DRMFrame ptr, byval cb as D3DRMFRAMEMOVECALLBACK, byval ctx as any ptr) as HRESULT
	AddTransform as function(byval This as IDirect3DRMFrame ptr, byval as D3DRMCOMBINETYPE, byval as D3DVALUE ptr) as HRESULT
	AddTranslation as function(byval This as IDirect3DRMFrame ptr, byval as D3DRMCOMBINETYPE, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE) as HRESULT
	AddScale as function(byval This as IDirect3DRMFrame ptr, byval as D3DRMCOMBINETYPE, byval sx as D3DVALUE, byval sy as D3DVALUE, byval sz as D3DVALUE) as HRESULT
	AddRotation as function(byval This as IDirect3DRMFrame ptr, byval as D3DRMCOMBINETYPE, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE, byval theta as D3DVALUE) as HRESULT
	AddVisual as function(byval This as IDirect3DRMFrame ptr, byval visual as IDirect3DRMVisual ptr) as HRESULT
	GetChildren as function(byval This as IDirect3DRMFrame ptr, byval children as IDirect3DRMFrameArray ptr ptr) as HRESULT
	GetColor as function(byval This as IDirect3DRMFrame ptr) as D3DCOLOR
	GetLights as function(byval This as IDirect3DRMFrame ptr, byval lights as IDirect3DRMLightArray ptr ptr) as HRESULT
	GetMaterialMode as function(byval This as IDirect3DRMFrame ptr) as D3DRMMATERIALMODE
	GetParent as function(byval This as IDirect3DRMFrame ptr, byval parent as IDirect3DRMFrame ptr ptr) as HRESULT
	GetPosition as function(byval This as IDirect3DRMFrame ptr, byval reference as IDirect3DRMFrame ptr, byval return_position as D3DVECTOR ptr) as HRESULT
	GetRotation as function(byval This as IDirect3DRMFrame ptr, byval reference as IDirect3DRMFrame ptr, byval axis as D3DVECTOR ptr, byval return_theta as D3DVALUE ptr) as HRESULT
	GetScene as function(byval This as IDirect3DRMFrame ptr, byval scene as IDirect3DRMFrame ptr ptr) as HRESULT
	GetSortMode as function(byval This as IDirect3DRMFrame ptr) as D3DRMSORTMODE
	GetTexture as function(byval This as IDirect3DRMFrame ptr, byval texture as IDirect3DRMTexture ptr ptr) as HRESULT
	GetTransform as function(byval This as IDirect3DRMFrame ptr, byval return_matrix as D3DVALUE ptr) as HRESULT
	GetVelocity as function(byval This as IDirect3DRMFrame ptr, byval reference as IDirect3DRMFrame ptr, byval return_velocity as D3DVECTOR ptr, byval with_rotation as WINBOOL) as HRESULT
	GetOrientation as function(byval This as IDirect3DRMFrame ptr, byval reference as IDirect3DRMFrame ptr, byval dir as D3DVECTOR ptr, byval up as D3DVECTOR ptr) as HRESULT
	GetVisuals as function(byval This as IDirect3DRMFrame ptr, byval visuals as IDirect3DRMVisualArray ptr ptr) as HRESULT
	GetTextureTopology as function(byval This as IDirect3DRMFrame ptr, byval wrap_u as WINBOOL ptr, byval wrap_v as WINBOOL ptr) as HRESULT
	InverseTransform as function(byval This as IDirect3DRMFrame ptr, byval d as D3DVECTOR ptr, byval s as D3DVECTOR ptr) as HRESULT
	Load as function(byval This as IDirect3DRMFrame ptr, byval filename as any ptr, byval name as any ptr, byval flags as D3DRMLOADOPTIONS, byval cb as D3DRMLOADTEXTURECALLBACK, byval ctx as any ptr) as HRESULT
	LookAt as function(byval This as IDirect3DRMFrame ptr, byval target as IDirect3DRMFrame ptr, byval reference as IDirect3DRMFrame ptr, byval constraint as D3DRMFRAMECONSTRAINT) as HRESULT
	Move as function(byval This as IDirect3DRMFrame ptr, byval delta as D3DVALUE) as HRESULT
	DeleteChild as function(byval This as IDirect3DRMFrame ptr, byval child as IDirect3DRMFrame ptr) as HRESULT
	DeleteLight as function(byval This as IDirect3DRMFrame ptr, byval light as IDirect3DRMLight ptr) as HRESULT
	DeleteMoveCallback as function(byval This as IDirect3DRMFrame ptr, byval cb as D3DRMFRAMEMOVECALLBACK, byval ctx as any ptr) as HRESULT
	DeleteVisual as function(byval This as IDirect3DRMFrame ptr, byval visual as IDirect3DRMVisual ptr) as HRESULT
	GetSceneBackground as function(byval This as IDirect3DRMFrame ptr) as D3DCOLOR
	GetSceneBackgroundDepth as function(byval This as IDirect3DRMFrame ptr, byval surface as IDirectDrawSurface ptr ptr) as HRESULT
	GetSceneFogColor as function(byval This as IDirect3DRMFrame ptr) as D3DCOLOR
	GetSceneFogEnable as function(byval This as IDirect3DRMFrame ptr) as WINBOOL
	GetSceneFogMode as function(byval This as IDirect3DRMFrame ptr) as D3DRMFOGMODE
	GetSceneFogParams as function(byval This as IDirect3DRMFrame ptr, byval return_start as D3DVALUE ptr, byval return_end as D3DVALUE ptr, byval return_density as D3DVALUE ptr) as HRESULT
	SetSceneBackground as function(byval This as IDirect3DRMFrame ptr, byval as D3DCOLOR) as HRESULT
	SetSceneBackgroundRGB as function(byval This as IDirect3DRMFrame ptr, byval red as D3DVALUE, byval green as D3DVALUE, byval blue as D3DVALUE) as HRESULT
	SetSceneBackgroundDepth as function(byval This as IDirect3DRMFrame ptr, byval surface as IDirectDrawSurface ptr) as HRESULT
	SetSceneBackgroundImage as function(byval This as IDirect3DRMFrame ptr, byval texture as IDirect3DRMTexture ptr) as HRESULT
	SetSceneFogEnable as function(byval This as IDirect3DRMFrame ptr, byval as WINBOOL) as HRESULT
	SetSceneFogColor as function(byval This as IDirect3DRMFrame ptr, byval as D3DCOLOR) as HRESULT
	SetSceneFogMode as function(byval This as IDirect3DRMFrame ptr, byval as D3DRMFOGMODE) as HRESULT
	SetSceneFogParams as function(byval This as IDirect3DRMFrame ptr, byval start as D3DVALUE, byval end as D3DVALUE, byval density as D3DVALUE) as HRESULT
	SetColor as function(byval This as IDirect3DRMFrame ptr, byval as D3DCOLOR) as HRESULT
	SetColorRGB as function(byval This as IDirect3DRMFrame ptr, byval red as D3DVALUE, byval green as D3DVALUE, byval blue as D3DVALUE) as HRESULT
	GetZbufferMode as function(byval This as IDirect3DRMFrame ptr) as D3DRMZBUFFERMODE
	SetMaterialMode as function(byval This as IDirect3DRMFrame ptr, byval as D3DRMMATERIALMODE) as HRESULT
	SetOrientation as function(byval This as IDirect3DRMFrame ptr, byval reference as IDirect3DRMFrame ptr, byval dx as D3DVALUE, byval dy as D3DVALUE, byval dz as D3DVALUE, byval ux as D3DVALUE, byval uy as D3DVALUE, byval uz as D3DVALUE) as HRESULT
	SetPosition as function(byval This as IDirect3DRMFrame ptr, byval reference as IDirect3DRMFrame ptr, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE) as HRESULT
	SetRotation as function(byval This as IDirect3DRMFrame ptr, byval reference as IDirect3DRMFrame ptr, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE, byval theta as D3DVALUE) as HRESULT
	SetSortMode as function(byval This as IDirect3DRMFrame ptr, byval as D3DRMSORTMODE) as HRESULT
	SetTexture as function(byval This as IDirect3DRMFrame ptr, byval texture as IDirect3DRMTexture ptr) as HRESULT
	SetTextureTopology as function(byval This as IDirect3DRMFrame ptr, byval wrap_u as WINBOOL, byval wrap_v as WINBOOL) as HRESULT
	SetVelocity as function(byval This as IDirect3DRMFrame ptr, byval reference as IDirect3DRMFrame ptr, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE, byval with_rotation as WINBOOL) as HRESULT
	SetZbufferMode as function(byval This as IDirect3DRMFrame ptr, byval as D3DRMZBUFFERMODE) as HRESULT
	Transform as function(byval This as IDirect3DRMFrame ptr, byval d as D3DVECTOR ptr, byval s as D3DVECTOR ptr) as HRESULT
end type

#define IDirect3DRMFrame_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMFrame_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMFrame_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMFrame_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirect3DRMFrame_AddDestroyCallback(p, a, b) (p)->lpVtbl->AddDestroyCallback(p, a, b)
#define IDirect3DRMFrame_DeleteDestroyCallback(p, a, b) (p)->lpVtbl->DeleteDestroyCallback(p, a, b)
#define IDirect3DRMFrame_SetAppData(p, a) (p)->lpVtbl->SetAppData(p, a)
#define IDirect3DRMFrame_GetAppData(p) (p)->lpVtbl->GetAppData(p)
#define IDirect3DRMFrame_SetName(p, a) (p)->lpVtbl->SetName(p, a)
#define IDirect3DRMFrame_GetName(p, a, b) (p)->lpVtbl->GetName(p, a, b)
#define IDirect3DRMFrame_GetClassName(p, a, b) (p)->lpVtbl->GetClassName(p, a, b)
#define IDirect3DRMFrame_AddChild(p, a) (p)->lpVtbl->AddChild(p, a)
#define IDirect3DRMFrame_AddLight(p, a) (p)->lpVtbl->AddLight(p, a)
#define IDirect3DRMFrame_AddMoveCallback(p, a, b) (p)->lpVtbl->AddMoveCallback(p, a, b)
#define IDirect3DRMFrame_AddTransform(p, a, b) (p)->lpVtbl->AddTransform(p, a, b)
#define IDirect3DRMFrame_AddTranslation(p, a, b, c, d) (p)->lpVtbl->AddTranslation(p, a, b, c, d)
#define IDirect3DRMFrame_AddScale(p, a, b, c, d) (p)->lpVtbl->AddScale(p, a, b, c, d)
#define IDirect3DRMFrame_AddRotation(p, a, b, c, d, e) (p)->lpVtbl->AddRotation(p, a, b, c, d, e)
#define IDirect3DRMFrame_AddVisual(p, a) (p)->lpVtbl->AddVisual(p, a)
#define IDirect3DRMFrame_GetChildren(p, a) (p)->lpVtbl->GetChildren(p, a)
#define IDirect3DRMFrame_GetColor(p) (p)->lpVtbl->GetColor(p)
#define IDirect3DRMFrame_GetLights(p, a) (p)->lpVtbl->GetLights(p, a)
#define IDirect3DRMFrame_GetMaterialMode(p) (p)->lpVtbl->GetMaterialMode(p)
#define IDirect3DRMFrame_GetParent(p, a) (p)->lpVtbl->GetParent(p, a)
#define IDirect3DRMFrame_GetPosition(p, a, b) (p)->lpVtbl->GetPosition(p, a, b)
#define IDirect3DRMFrame_GetRotation(p, a, b, c) (p)->lpVtbl->GetRotation(p, a, b, c)
#define IDirect3DRMFrame_GetScene(p, a) (p)->lpVtbl->GetScene(p, a)
#define IDirect3DRMFrame_GetSortMode(p) (p)->lpVtbl->GetSortMode(p)
#define IDirect3DRMFrame_GetTexture(p, a) (p)->lpVtbl->GetTexture(p, a)
#define IDirect3DRMFrame_GetTransform(p, a) (p)->lpVtbl->GetTransform(p, a)
#define IDirect3DRMFrame_GetVelocity(p, a, b, c) (p)->lpVtbl->GetVelocity(p, a, b, c)
#define IDirect3DRMFrame_GetOrientation(p, a, b, c) (p)->lpVtbl->GetOrientation(p, a, b, c)
#define IDirect3DRMFrame_GetVisuals(p, a) (p)->lpVtbl->GetVisuals(p, a)
#define IDirect3DRMFrame_GetTextureTopology(p, a, b) (p)->lpVtbl->GetTextureTopology(p, a, b)
#define IDirect3DRMFrame_InverseTransform(p, a, b) (p)->lpVtbl->InverseTransform(p, a, b)
#define IDirect3DRMFrame_Load(p, a, b, c, d, e) (p)->lpVtbl->Load(p, a, b, c, d, e)
#define IDirect3DRMFrame_LookAt(p, a, b, c) (p)->lpVtbl->LookAt(p, a, b, c)
#define IDirect3DRMFrame_Move(p, a) (p)->lpVtbl->Move(p, a)
#define IDirect3DRMFrame_DeleteChild(p, a) (p)->lpVtbl->DeleteChild(p, a)
#define IDirect3DRMFrame_DeleteLight(p, a) (p)->lpVtbl->DeleteLight(p, a)
#define IDirect3DRMFrame_DeleteMoveCallback(p, a, b) (p)->lpVtbl->DeleteMoveCallback(p, a, b)
#define IDirect3DRMFrame_DeleteVisual(p, a) (p)->lpVtbl->DeleteVisual(p, a)
#define IDirect3DRMFrame_GetSceneBackground(p) (p)->lpVtbl->GetSceneBackground(p)
#define IDirect3DRMFrame_GetSceneBackgroundDepth(p, a) (p)->lpVtbl->GetSceneBackgroundDepth(p, a)
#define IDirect3DRMFrame_GetSceneFogColor(p) (p)->lpVtbl->GetSceneFogColor(p)
#define IDirect3DRMFrame_GetSceneFogEnable(p) (p)->lpVtbl->GetSceneFogEnable(p)
#define IDirect3DRMFrame_GetSceneFogMode(p) (p)->lpVtbl->GetSceneFogMode(p)
#define IDirect3DRMFrame_GetSceneFogParams(p, a, b, c) (p)->lpVtbl->GetSceneFogParams(p, a, b, c)
#define IDirect3DRMFrame_SetSceneBackground(p, a) (p)->lpVtbl->SetSceneBackground(p, a)
#define IDirect3DRMFrame_SetSceneBackgroundRGB(p, a, b, c) (p)->lpVtbl->SetSceneBackgroundRGB(p, a, b, c)
#define IDirect3DRMFrame_SetSceneBackgroundDepth(p, a) (p)->lpVtbl->SetSceneBackgroundDepth(p, a)
#define IDirect3DRMFrame_SetSceneBackgroundImage(p, a) (p)->lpVtbl->SetSceneBackgroundImage(p, a)
#define IDirect3DRMFrame_SetSceneFogEnable(p, a) (p)->lpVtbl->SetSceneFogEnable(p, a)
#define IDirect3DRMFrame_SetSceneFogColor(p, a) (p)->lpVtbl->SetSceneFogColor(p, a)
#define IDirect3DRMFrame_SetSceneFogMode(p, a) (p)->lpVtbl->SetSceneFogMode(p, a)
#define IDirect3DRMFrame_SetSceneFogParams(p, a, b, c) (p)->lpVtbl->SetSceneFogParams(p, a, b, c)
#define IDirect3DRMFrame_SetColor(p, a) (p)->lpVtbl->SetColor(p, a)
#define IDirect3DRMFrame_SetColorRGB(p, a, b, c) (p)->lpVtbl->SetColorRGB(p, a, b, c)
#define IDirect3DRMFrame_GetZbufferMode(p) (p)->lpVtbl->GetZbufferMode(p)
#define IDirect3DRMFrame_SetMaterialMode(p, a) (p)->lpVtbl->SetMaterialMode(p, a)
#define IDirect3DRMFrame_SetOrientation(p, a, b, c, d, e, f, g) (p)->lpVtbl->SetOrientation(p, a, b, c, d, e, f, g)
#define IDirect3DRMFrame_SetPosition(p, a, b, c, d) (p)->lpVtbl->SetPosition(p, a, b, c, d)
#define IDirect3DRMFrame_SetRotation(p, a, b, c, d, e) (p)->lpVtbl->SetRotation(p, a, b, c, d, e)
#define IDirect3DRMFrame_SetSortMode(p, a) (p)->lpVtbl->SetSortMode(p, a)
#define IDirect3DRMFrame_SetTexture(p, a) (p)->lpVtbl->SetTexture(p, a)
#define IDirect3DRMFrame_SetTextureTopology(p, a, b) (p)->lpVtbl->SetTextureTopology(p, a, b)
#define IDirect3DRMFrame_SetVelocity(p, a, b, c, d, e) (p)->lpVtbl->SetVelocity(p, a, b, c, d, e)
#define IDirect3DRMFrame_SetZbufferMode(p, a) (p)->lpVtbl->SetZbufferMode(p, a)
#define IDirect3DRMFrame_Transform(p, a, b) (p)->lpVtbl->Transform(p, a, b)
type IDirect3DRMFrame2Vtbl as IDirect3DRMFrame2Vtbl_

type IDirect3DRMFrame2
	lpVtbl as IDirect3DRMFrame2Vtbl ptr
end type

type IDirect3DRMFrame2Vtbl_
	QueryInterface as function(byval This as IDirect3DRMFrame2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMFrame2 ptr) as ULONG
	Release as function(byval This as IDirect3DRMFrame2 ptr) as ULONG
	Clone as function(byval This as IDirect3DRMFrame2 ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddDestroyCallback as function(byval This as IDirect3DRMFrame2 ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	DeleteDestroyCallback as function(byval This as IDirect3DRMFrame2 ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	SetAppData as function(byval This as IDirect3DRMFrame2 ptr, byval data as DWORD) as HRESULT
	GetAppData as function(byval This as IDirect3DRMFrame2 ptr) as DWORD
	SetName as function(byval This as IDirect3DRMFrame2 ptr, byval name as const zstring ptr) as HRESULT
	GetName as function(byval This as IDirect3DRMFrame2 ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	GetClassName as function(byval This as IDirect3DRMFrame2 ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	AddChild as function(byval This as IDirect3DRMFrame2 ptr, byval child as IDirect3DRMFrame ptr) as HRESULT
	AddLight as function(byval This as IDirect3DRMFrame2 ptr, byval light as IDirect3DRMLight ptr) as HRESULT
	AddMoveCallback as function(byval This as IDirect3DRMFrame2 ptr, byval cb as D3DRMFRAMEMOVECALLBACK, byval ctx as any ptr) as HRESULT
	AddTransform as function(byval This as IDirect3DRMFrame2 ptr, byval as D3DRMCOMBINETYPE, byval as D3DVALUE ptr) as HRESULT
	AddTranslation as function(byval This as IDirect3DRMFrame2 ptr, byval as D3DRMCOMBINETYPE, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE) as HRESULT
	AddScale as function(byval This as IDirect3DRMFrame2 ptr, byval as D3DRMCOMBINETYPE, byval sx as D3DVALUE, byval sy as D3DVALUE, byval sz as D3DVALUE) as HRESULT
	AddRotation as function(byval This as IDirect3DRMFrame2 ptr, byval as D3DRMCOMBINETYPE, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE, byval theta as D3DVALUE) as HRESULT
	AddVisual as function(byval This as IDirect3DRMFrame2 ptr, byval visual as IDirect3DRMVisual ptr) as HRESULT
	GetChildren as function(byval This as IDirect3DRMFrame2 ptr, byval children as IDirect3DRMFrameArray ptr ptr) as HRESULT
	GetColor as function(byval This as IDirect3DRMFrame2 ptr) as D3DCOLOR
	GetLights as function(byval This as IDirect3DRMFrame2 ptr, byval lights as IDirect3DRMLightArray ptr ptr) as HRESULT
	GetMaterialMode as function(byval This as IDirect3DRMFrame2 ptr) as D3DRMMATERIALMODE
	GetParent as function(byval This as IDirect3DRMFrame2 ptr, byval parent as IDirect3DRMFrame ptr ptr) as HRESULT
	GetPosition as function(byval This as IDirect3DRMFrame2 ptr, byval reference as IDirect3DRMFrame ptr, byval return_position as D3DVECTOR ptr) as HRESULT
	GetRotation as function(byval This as IDirect3DRMFrame2 ptr, byval reference as IDirect3DRMFrame ptr, byval axis as D3DVECTOR ptr, byval return_theta as D3DVALUE ptr) as HRESULT
	GetScene as function(byval This as IDirect3DRMFrame2 ptr, byval scene as IDirect3DRMFrame ptr ptr) as HRESULT
	GetSortMode as function(byval This as IDirect3DRMFrame2 ptr) as D3DRMSORTMODE
	GetTexture as function(byval This as IDirect3DRMFrame2 ptr, byval texture as IDirect3DRMTexture ptr ptr) as HRESULT
	GetTransform as function(byval This as IDirect3DRMFrame2 ptr, byval return_matrix as D3DVALUE ptr) as HRESULT
	GetVelocity as function(byval This as IDirect3DRMFrame2 ptr, byval reference as IDirect3DRMFrame ptr, byval return_velocity as D3DVECTOR ptr, byval with_rotation as WINBOOL) as HRESULT
	GetOrientation as function(byval This as IDirect3DRMFrame2 ptr, byval reference as IDirect3DRMFrame ptr, byval dir as D3DVECTOR ptr, byval up as D3DVECTOR ptr) as HRESULT
	GetVisuals as function(byval This as IDirect3DRMFrame2 ptr, byval visuals as IDirect3DRMVisualArray ptr ptr) as HRESULT
	GetTextureTopology as function(byval This as IDirect3DRMFrame2 ptr, byval wrap_u as WINBOOL ptr, byval wrap_v as WINBOOL ptr) as HRESULT
	InverseTransform as function(byval This as IDirect3DRMFrame2 ptr, byval d as D3DVECTOR ptr, byval s as D3DVECTOR ptr) as HRESULT
	Load as function(byval This as IDirect3DRMFrame2 ptr, byval filename as any ptr, byval name as any ptr, byval flags as D3DRMLOADOPTIONS, byval cb as D3DRMLOADTEXTURECALLBACK, byval ctx as any ptr) as HRESULT
	LookAt as function(byval This as IDirect3DRMFrame2 ptr, byval target as IDirect3DRMFrame ptr, byval reference as IDirect3DRMFrame ptr, byval constraint as D3DRMFRAMECONSTRAINT) as HRESULT
	Move as function(byval This as IDirect3DRMFrame2 ptr, byval delta as D3DVALUE) as HRESULT
	DeleteChild as function(byval This as IDirect3DRMFrame2 ptr, byval child as IDirect3DRMFrame ptr) as HRESULT
	DeleteLight as function(byval This as IDirect3DRMFrame2 ptr, byval light as IDirect3DRMLight ptr) as HRESULT
	DeleteMoveCallback as function(byval This as IDirect3DRMFrame2 ptr, byval cb as D3DRMFRAMEMOVECALLBACK, byval ctx as any ptr) as HRESULT
	DeleteVisual as function(byval This as IDirect3DRMFrame2 ptr, byval visual as IDirect3DRMVisual ptr) as HRESULT
	GetSceneBackground as function(byval This as IDirect3DRMFrame2 ptr) as D3DCOLOR
	GetSceneBackgroundDepth as function(byval This as IDirect3DRMFrame2 ptr, byval surface as IDirectDrawSurface ptr ptr) as HRESULT
	GetSceneFogColor as function(byval This as IDirect3DRMFrame2 ptr) as D3DCOLOR
	GetSceneFogEnable as function(byval This as IDirect3DRMFrame2 ptr) as WINBOOL
	GetSceneFogMode as function(byval This as IDirect3DRMFrame2 ptr) as D3DRMFOGMODE
	GetSceneFogParams as function(byval This as IDirect3DRMFrame2 ptr, byval return_start as D3DVALUE ptr, byval return_end as D3DVALUE ptr, byval return_density as D3DVALUE ptr) as HRESULT
	SetSceneBackground as function(byval This as IDirect3DRMFrame2 ptr, byval as D3DCOLOR) as HRESULT
	SetSceneBackgroundRGB as function(byval This as IDirect3DRMFrame2 ptr, byval red as D3DVALUE, byval green as D3DVALUE, byval blue as D3DVALUE) as HRESULT
	SetSceneBackgroundDepth as function(byval This as IDirect3DRMFrame2 ptr, byval surface as IDirectDrawSurface ptr) as HRESULT
	SetSceneBackgroundImage as function(byval This as IDirect3DRMFrame2 ptr, byval texture as IDirect3DRMTexture ptr) as HRESULT
	SetSceneFogEnable as function(byval This as IDirect3DRMFrame2 ptr, byval as WINBOOL) as HRESULT
	SetSceneFogColor as function(byval This as IDirect3DRMFrame2 ptr, byval as D3DCOLOR) as HRESULT
	SetSceneFogMode as function(byval This as IDirect3DRMFrame2 ptr, byval as D3DRMFOGMODE) as HRESULT
	SetSceneFogParams as function(byval This as IDirect3DRMFrame2 ptr, byval start as D3DVALUE, byval end as D3DVALUE, byval density as D3DVALUE) as HRESULT
	SetColor as function(byval This as IDirect3DRMFrame2 ptr, byval as D3DCOLOR) as HRESULT
	SetColorRGB as function(byval This as IDirect3DRMFrame2 ptr, byval red as D3DVALUE, byval green as D3DVALUE, byval blue as D3DVALUE) as HRESULT
	GetZbufferMode as function(byval This as IDirect3DRMFrame2 ptr) as D3DRMZBUFFERMODE
	SetMaterialMode as function(byval This as IDirect3DRMFrame2 ptr, byval as D3DRMMATERIALMODE) as HRESULT
	SetOrientation as function(byval This as IDirect3DRMFrame2 ptr, byval reference as IDirect3DRMFrame ptr, byval dx as D3DVALUE, byval dy as D3DVALUE, byval dz as D3DVALUE, byval ux as D3DVALUE, byval uy as D3DVALUE, byval uz as D3DVALUE) as HRESULT
	SetPosition as function(byval This as IDirect3DRMFrame2 ptr, byval reference as IDirect3DRMFrame ptr, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE) as HRESULT
	SetRotation as function(byval This as IDirect3DRMFrame2 ptr, byval reference as IDirect3DRMFrame ptr, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE, byval theta as D3DVALUE) as HRESULT
	SetSortMode as function(byval This as IDirect3DRMFrame2 ptr, byval as D3DRMSORTMODE) as HRESULT
	SetTexture as function(byval This as IDirect3DRMFrame2 ptr, byval texture as IDirect3DRMTexture ptr) as HRESULT
	SetTextureTopology as function(byval This as IDirect3DRMFrame2 ptr, byval wrap_u as WINBOOL, byval wrap_v as WINBOOL) as HRESULT
	SetVelocity as function(byval This as IDirect3DRMFrame2 ptr, byval reference as IDirect3DRMFrame ptr, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE, byval with_rotation as WINBOOL) as HRESULT
	SetZbufferMode as function(byval This as IDirect3DRMFrame2 ptr, byval as D3DRMZBUFFERMODE) as HRESULT
	Transform as function(byval This as IDirect3DRMFrame2 ptr, byval d as D3DVECTOR ptr, byval s as D3DVECTOR ptr) as HRESULT
	AddMoveCallback2 as function(byval This as IDirect3DRMFrame2 ptr, byval cb as D3DRMFRAMEMOVECALLBACK, byval ctx as any ptr, byval flags as DWORD) as HRESULT
	GetBox as function(byval This as IDirect3DRMFrame2 ptr, byval box as D3DRMBOX ptr) as HRESULT
	GetBoxEnable as function(byval This as IDirect3DRMFrame2 ptr) as WINBOOL
	GetAxes as function(byval This as IDirect3DRMFrame2 ptr, byval dir as D3DVECTOR ptr, byval up as D3DVECTOR ptr) as HRESULT
	GetMaterial as function(byval This as IDirect3DRMFrame2 ptr, byval material as IDirect3DRMMaterial ptr ptr) as HRESULT
	GetInheritAxes as function(byval This as IDirect3DRMFrame2 ptr) as WINBOOL
	GetHierarchyBox as function(byval This as IDirect3DRMFrame2 ptr, byval box as D3DRMBOX ptr) as HRESULT
	SetBox as function(byval This as IDirect3DRMFrame2 ptr, byval box as D3DRMBOX ptr) as HRESULT
	SetBoxEnable as function(byval This as IDirect3DRMFrame2 ptr, byval as WINBOOL) as HRESULT
	SetAxes as function(byval This as IDirect3DRMFrame2 ptr, byval dx as D3DVALUE, byval dy as D3DVALUE, byval dz as D3DVALUE, byval ux as D3DVALUE, byval uy as D3DVALUE, byval uz as D3DVALUE) as HRESULT
	SetInheritAxes as function(byval This as IDirect3DRMFrame2 ptr, byval inherit_from_parent as WINBOOL) as HRESULT
	SetMaterial as function(byval This as IDirect3DRMFrame2 ptr, byval material as IDirect3DRMMaterial ptr) as HRESULT
	SetQuaternion as function(byval This as IDirect3DRMFrame2 ptr, byval reference as IDirect3DRMFrame ptr, byval q as D3DRMQUATERNION ptr) as HRESULT
	RayPick as function(byval This as IDirect3DRMFrame2 ptr, byval reference as IDirect3DRMFrame ptr, byval ray as D3DRMRAY ptr, byval flags as DWORD, byval return_visuals as IDirect3DRMPicked2Array ptr ptr) as HRESULT
	Save as function(byval This as IDirect3DRMFrame2 ptr, byval filename as const zstring ptr, byval format as D3DRMXOFFORMAT, byval flags as D3DRMSAVEOPTIONS) as HRESULT
end type

#define IDirect3DRMFrame2_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMFrame2_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMFrame2_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMFrame2_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirect3DRMFrame2_AddDestroyCallback(p, a, b) (p)->lpVtbl->AddDestroyCallback(p, a, b)
#define IDirect3DRMFrame2_DeleteDestroyCallback(p, a, b) (p)->lpVtbl->DeleteDestroyCallback(p, a, b)
#define IDirect3DRMFrame2_SetAppData(p, a) (p)->lpVtbl->SetAppData(p, a)
#define IDirect3DRMFrame2_GetAppData(p) (p)->lpVtbl->GetAppData(p)
#define IDirect3DRMFrame2_SetName(p, a) (p)->lpVtbl->SetName(p, a)
#define IDirect3DRMFrame2_GetName(p, a, b) (p)->lpVtbl->GetName(p, a, b)
#define IDirect3DRMFrame2_GetClassName(p, a, b) (p)->lpVtbl->GetClassName(p, a, b)
#define IDirect3DRMFrame2_AddChild(p, a) (p)->lpVtbl->AddChild(p, a)
#define IDirect3DRMFrame2_AddLight(p, a) (p)->lpVtbl->AddLight(p, a)
#define IDirect3DRMFrame2_AddMoveCallback(p, a, b) (p)->lpVtbl->AddMoveCallback(p, a, b)
#define IDirect3DRMFrame2_AddTransform(p, a, b) (p)->lpVtbl->AddTransform(p, a, b)
#define IDirect3DRMFrame2_AddTranslation(p, a, b, c, d) (p)->lpVtbl->AddTranslation(p, a, b, c, d)
#define IDirect3DRMFrame2_AddScale(p, a, b, c, d) (p)->lpVtbl->AddScale(p, a, b, c, d)
#define IDirect3DRMFrame2_AddRotation(p, a, b, c, d, e) (p)->lpVtbl->AddRotation(p, a, b, c, d, e)
#define IDirect3DRMFrame2_AddVisual(p, a) (p)->lpVtbl->AddVisual(p, a)
#define IDirect3DRMFrame2_GetChildren(p, a) (p)->lpVtbl->GetChildren(p, a)
#define IDirect3DRMFrame2_GetColor(p) (p)->lpVtbl->GetColor(p)
#define IDirect3DRMFrame2_GetLights(p, a) (p)->lpVtbl->GetLights(p, a)
#define IDirect3DRMFrame2_GetMaterialMode(p) (p)->lpVtbl->GetMaterialMode(p)
#define IDirect3DRMFrame2_GetParent(p, a) (p)->lpVtbl->GetParent(p, a)
#define IDirect3DRMFrame2_GetPosition(p, a, b) (p)->lpVtbl->GetPosition(p, a, b)
#define IDirect3DRMFrame2_GetRotation(p, a, b, c) (p)->lpVtbl->GetRotation(p, a, b, c)
#define IDirect3DRMFrame2_GetScene(p, a) (p)->lpVtbl->GetScene(p, a)
#define IDirect3DRMFrame2_GetSortMode(p) (p)->lpVtbl->GetSortMode(p)
#define IDirect3DRMFrame2_GetTexture(p, a) (p)->lpVtbl->GetTexture(p, a)
#define IDirect3DRMFrame2_GetTransform(p, a) (p)->lpVtbl->GetTransform(p, a)
#define IDirect3DRMFrame2_GetVelocity(p, a, b, c) (p)->lpVtbl->GetVelocity(p, a, b, c)
#define IDirect3DRMFrame2_GetOrientation(p, a, b, c) (p)->lpVtbl->GetOrientation(p, a, b, c)
#define IDirect3DRMFrame2_GetVisuals(p, a) (p)->lpVtbl->GetVisuals(p, a)
#define IDirect3DRMFrame2_GetTextureTopology(p, a, b) (p)->lpVtbl->GetTextureTopology(p, a, b)
#define IDirect3DRMFrame2_InverseTransform(p, a, b) (p)->lpVtbl->InverseTransform(p, a, b)
#define IDirect3DRMFrame2_Load(p, a, b, c, d, e) (p)->lpVtbl->Load(p, a, b, c, d, e)
#define IDirect3DRMFrame2_LookAt(p, a, b, c) (p)->lpVtbl->LookAt(p, a, b, c)
#define IDirect3DRMFrame2_Move(p, a) (p)->lpVtbl->Move(p, a)
#define IDirect3DRMFrame2_DeleteChild(p, a) (p)->lpVtbl->DeleteChild(p, a)
#define IDirect3DRMFrame2_DeleteLight(p, a) (p)->lpVtbl->DeleteLight(p, a)
#define IDirect3DRMFrame2_DeleteMoveCallback(p, a, b) (p)->lpVtbl->DeleteMoveCallback(p, a, b)
#define IDirect3DRMFrame2_DeleteVisual(p, a) (p)->lpVtbl->DeleteVisual(p, a)
#define IDirect3DRMFrame2_GetSceneBackground(p) (p)->lpVtbl->GetSceneBackground(p)
#define IDirect3DRMFrame2_GetSceneBackgroundDepth(p, a) (p)->lpVtbl->GetSceneBackgroundDepth(p, a)
#define IDirect3DRMFrame2_GetSceneFogColor(p) (p)->lpVtbl->GetSceneFogColor(p)
#define IDirect3DRMFrame2_GetSceneFogEnable(p) (p)->lpVtbl->GetSceneFogEnable(p)
#define IDirect3DRMFrame2_GetSceneFogMode(p) (p)->lpVtbl->GetSceneFogMode(p)
#define IDirect3DRMFrame2_GetSceneFogParams(p, a, b, c) (p)->lpVtbl->GetSceneFogParams(p, a, b, c)
#define IDirect3DRMFrame2_SetSceneBackground(p, a) (p)->lpVtbl->SetSceneBackground(p, a)
#define IDirect3DRMFrame2_SetSceneBackgroundRGB(p, a, b, c) (p)->lpVtbl->SetSceneBackgroundRGB(p, a, b, c)
#define IDirect3DRMFrame2_SetSceneBackgroundDepth(p, a) (p)->lpVtbl->SetSceneBackgroundDepth(p, a)
#define IDirect3DRMFrame2_SetSceneBackgroundImage(p, a) (p)->lpVtbl->SetSceneBackgroundImage(p, a)
#define IDirect3DRMFrame2_SetSceneFogEnable(p, a) (p)->lpVtbl->SetSceneFogEnable(p, a)
#define IDirect3DRMFrame2_SetSceneFogColor(p, a) (p)->lpVtbl->SetSceneFogColor(p, a)
#define IDirect3DRMFrame2_SetSceneFogMode(p, a) (p)->lpVtbl->SetSceneFogMode(p, a)
#define IDirect3DRMFrame2_SetSceneFogParams(p, a, b, c) (p)->lpVtbl->SetSceneFogParams(p, a, b, c)
#define IDirect3DRMFrame2_SetColor(p, a) (p)->lpVtbl->SetColor(p, a)
#define IDirect3DRMFrame2_SetColorRGB(p, a, b, c) (p)->lpVtbl->SetColorRGB(p, a, b, c)
#define IDirect3DRMFrame2_GetZbufferMode(p) (p)->lpVtbl->GetZbufferMode(p)
#define IDirect3DRMFrame2_SetMaterialMode(p, a) (p)->lpVtbl->SetMaterialMode(p, a)
#define IDirect3DRMFrame2_SetOrientation(p, a, b, c, d, e, f, g) (p)->lpVtbl->SetOrientation(p, a, b, c, d, e, f, g)
#define IDirect3DRMFrame2_SetPosition(p, a, b, c, d) (p)->lpVtbl->SetPosition(p, a, b, c, d)
#define IDirect3DRMFrame2_SetRotation(p, a, b, c, d, e) (p)->lpVtbl->SetRotation(p, a, b, c, d, e)
#define IDirect3DRMFrame2_SetSortMode(p, a) (p)->lpVtbl->SetSortMode(p, a)
#define IDirect3DRMFrame2_SetTexture(p, a) (p)->lpVtbl->SetTexture(p, a)
#define IDirect3DRMFrame2_SetTextureTopology(p, a, b) (p)->lpVtbl->SetTextureTopology(p, a, b)
#define IDirect3DRMFrame2_SetVelocity(p, a, b, c, d, e) (p)->lpVtbl->SetVelocity(p, a, b, c, d, e)
#define IDirect3DRMFrame2_SetZbufferMode(p, a) (p)->lpVtbl->SetZbufferMode(p, a)
#define IDirect3DRMFrame2_Transform(p, a, b) (p)->lpVtbl->Transform(p, a, b)
#define IDirect3DRMFrame2_AddMoveCallback2(p, a, b, c) (p)->lpVtbl->AddMoveCallback2(p, a, b, c)
#define IDirect3DRMFrame2_GetBox(p, a) (p)->lpVtbl->GetBox(p, a)
#define IDirect3DRMFrame2_GetBoxEnable(p) (p)->lpVtbl->GetBoxEnable(p)
#define IDirect3DRMFrame2_GetAxes(p, a, b) (p)->lpVtbl->GetAxes(p, a, b)
#define IDirect3DRMFrame2_GetMaterial(p, a) (p)->lpVtbl->GetMaterial(p, a)
#define IDirect3DRMFrame2_GetInheritAxes(p, a, b) (p)->lpVtbl->GetInheritAxes(p, a, b)
#define IDirect3DRMFrame2_GetHierarchyBox(p, a) (p)->lpVtbl->GetHierarchyBox(p, a)
#define IDirect3DRMFrame2_SetBox(p, a) (p)->lpVtbl->SetBox(p, a)
#define IDirect3DRMFrame2_SetBoxEnable(p, a) (p)->lpVtbl->SetBoxEnable(p, a)
#define IDirect3DRMFrame2_SetAxes(p, a, b, c, d, e, f) (p)->lpVtbl->SetAxes(p, a, b, c, d, e, f)
#define IDirect3DRMFrame2_SetInheritAxes(p, a) (p)->lpVtbl->SetInheritAxes(p, a)
#define IDirect3DRMFrame2_SetMaterial(p, a) (p)->lpVtbl->SetMaterial(p, a)
#define IDirect3DRMFrame2_SetQuaternion(p, a, b) (p)->lpVtbl->SetQuaternion(p, a, b)
#define IDirect3DRMFrame2_RayPick(p, a, b, c, d) (p)->lpVtbl->RayPick(p, a, b, c, d)
#define IDirect3DRMFrame2_Save(p, a, b, c) (p)->lpVtbl->Save(p, a, b, c)
type IDirect3DRMFrame3Vtbl as IDirect3DRMFrame3Vtbl_

type IDirect3DRMFrame3_
	lpVtbl as IDirect3DRMFrame3Vtbl ptr
end type

type IDirect3DRMFrame3Vtbl_
	QueryInterface as function(byval This as IDirect3DRMFrame3 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMFrame3 ptr) as ULONG
	Release as function(byval This as IDirect3DRMFrame3 ptr) as ULONG
	Clone as function(byval This as IDirect3DRMFrame3 ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddDestroyCallback as function(byval This as IDirect3DRMFrame3 ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	DeleteDestroyCallback as function(byval This as IDirect3DRMFrame3 ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	SetAppData as function(byval This as IDirect3DRMFrame3 ptr, byval data as DWORD) as HRESULT
	GetAppData as function(byval This as IDirect3DRMFrame3 ptr) as DWORD
	SetName as function(byval This as IDirect3DRMFrame3 ptr, byval name as const zstring ptr) as HRESULT
	GetName as function(byval This as IDirect3DRMFrame3 ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	GetClassName as function(byval This as IDirect3DRMFrame3 ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	AddChild as function(byval This as IDirect3DRMFrame3 ptr, byval child as IDirect3DRMFrame3 ptr) as HRESULT
	AddLight as function(byval This as IDirect3DRMFrame3 ptr, byval light as IDirect3DRMLight ptr) as HRESULT
	AddMoveCallback as function(byval This as IDirect3DRMFrame3 ptr, byval cb as D3DRMFRAME3MOVECALLBACK, byval ctx as any ptr, byval flags as DWORD) as HRESULT
	AddTransform as function(byval This as IDirect3DRMFrame3 ptr, byval as D3DRMCOMBINETYPE, byval as D3DVALUE ptr) as HRESULT
	AddTranslation as function(byval This as IDirect3DRMFrame3 ptr, byval as D3DRMCOMBINETYPE, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE) as HRESULT
	AddScale as function(byval This as IDirect3DRMFrame3 ptr, byval as D3DRMCOMBINETYPE, byval sx as D3DVALUE, byval sy as D3DVALUE, byval sz as D3DVALUE) as HRESULT
	AddRotation as function(byval This as IDirect3DRMFrame3 ptr, byval as D3DRMCOMBINETYPE, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE, byval theta as D3DVALUE) as HRESULT
	AddVisual as function(byval This as IDirect3DRMFrame3 ptr, byval visual as IUnknown ptr) as HRESULT
	GetChildren as function(byval This as IDirect3DRMFrame3 ptr, byval children as IDirect3DRMFrameArray ptr ptr) as HRESULT
	GetColor as function(byval This as IDirect3DRMFrame3 ptr) as D3DCOLOR
	GetLights as function(byval This as IDirect3DRMFrame3 ptr, byval lights as IDirect3DRMLightArray ptr ptr) as HRESULT
	GetMaterialMode as function(byval This as IDirect3DRMFrame3 ptr) as D3DRMMATERIALMODE
	GetParent as function(byval This as IDirect3DRMFrame3 ptr, byval parent as IDirect3DRMFrame3 ptr ptr) as HRESULT
	GetPosition as function(byval This as IDirect3DRMFrame3 ptr, byval reference as IDirect3DRMFrame3 ptr, byval return_position as D3DVECTOR ptr) as HRESULT
	GetRotation as function(byval This as IDirect3DRMFrame3 ptr, byval reference as IDirect3DRMFrame3 ptr, byval axis as D3DVECTOR ptr, byval return_theta as D3DVALUE ptr) as HRESULT
	GetScene as function(byval This as IDirect3DRMFrame3 ptr, byval scene as IDirect3DRMFrame3 ptr ptr) as HRESULT
	GetSortMode as function(byval This as IDirect3DRMFrame3 ptr) as D3DRMSORTMODE
	GetTexture as function(byval This as IDirect3DRMFrame3 ptr, byval texture as IDirect3DRMTexture3 ptr ptr) as HRESULT
	GetTransform as function(byval This as IDirect3DRMFrame3 ptr, byval reference as IDirect3DRMFrame3 ptr, byval matrix as D3DVALUE ptr) as HRESULT
	GetVelocity as function(byval This as IDirect3DRMFrame3 ptr, byval reference as IDirect3DRMFrame3 ptr, byval return_velocity as D3DVECTOR ptr, byval with_rotation as WINBOOL) as HRESULT
	GetOrientation as function(byval This as IDirect3DRMFrame3 ptr, byval reference as IDirect3DRMFrame3 ptr, byval dir as D3DVECTOR ptr, byval up as D3DVECTOR ptr) as HRESULT
	GetVisuals as function(byval This as IDirect3DRMFrame3 ptr, byval count as DWORD ptr, byval visuals as IUnknown ptr ptr) as HRESULT
	InverseTransform as function(byval This as IDirect3DRMFrame3 ptr, byval d as D3DVECTOR ptr, byval s as D3DVECTOR ptr) as HRESULT
	Load as function(byval This as IDirect3DRMFrame3 ptr, byval filename as any ptr, byval name as any ptr, byval flags as D3DRMLOADOPTIONS, byval cb as D3DRMLOADTEXTURE3CALLBACK, byval ctx as any ptr) as HRESULT
	LookAt as function(byval This as IDirect3DRMFrame3 ptr, byval target as IDirect3DRMFrame3 ptr, byval reference as IDirect3DRMFrame3 ptr, byval constraint as D3DRMFRAMECONSTRAINT) as HRESULT
	Move as function(byval This as IDirect3DRMFrame3 ptr, byval delta as D3DVALUE) as HRESULT
	DeleteChild as function(byval This as IDirect3DRMFrame3 ptr, byval child as IDirect3DRMFrame3 ptr) as HRESULT
	DeleteLight as function(byval This as IDirect3DRMFrame3 ptr, byval light as IDirect3DRMLight ptr) as HRESULT
	DeleteMoveCallback as function(byval This as IDirect3DRMFrame3 ptr, byval cb as D3DRMFRAME3MOVECALLBACK, byval ctx as any ptr) as HRESULT
	DeleteVisual as function(byval This as IDirect3DRMFrame3 ptr, byval visual as IUnknown ptr) as HRESULT
	GetSceneBackground as function(byval This as IDirect3DRMFrame3 ptr) as D3DCOLOR
	GetSceneBackgroundDepth as function(byval This as IDirect3DRMFrame3 ptr, byval surface as IDirectDrawSurface ptr ptr) as HRESULT
	GetSceneFogColor as function(byval This as IDirect3DRMFrame3 ptr) as D3DCOLOR
	GetSceneFogEnable as function(byval This as IDirect3DRMFrame3 ptr) as WINBOOL
	GetSceneFogMode as function(byval This as IDirect3DRMFrame3 ptr) as D3DRMFOGMODE
	GetSceneFogParams as function(byval This as IDirect3DRMFrame3 ptr, byval return_start as D3DVALUE ptr, byval return_end as D3DVALUE ptr, byval return_density as D3DVALUE ptr) as HRESULT
	SetSceneBackground as function(byval This as IDirect3DRMFrame3 ptr, byval as D3DCOLOR) as HRESULT
	SetSceneBackgroundRGB as function(byval This as IDirect3DRMFrame3 ptr, byval red as D3DVALUE, byval green as D3DVALUE, byval blue as D3DVALUE) as HRESULT
	SetSceneBackgroundDepth as function(byval This as IDirect3DRMFrame3 ptr, byval surface as IDirectDrawSurface ptr) as HRESULT
	SetSceneBackgroundImage as function(byval This as IDirect3DRMFrame3 ptr, byval texture as IDirect3DRMTexture3 ptr) as HRESULT
	SetSceneFogEnable as function(byval This as IDirect3DRMFrame3 ptr, byval as WINBOOL) as HRESULT
	SetSceneFogColor as function(byval This as IDirect3DRMFrame3 ptr, byval as D3DCOLOR) as HRESULT
	SetSceneFogMode as function(byval This as IDirect3DRMFrame3 ptr, byval as D3DRMFOGMODE) as HRESULT
	SetSceneFogParams as function(byval This as IDirect3DRMFrame3 ptr, byval start as D3DVALUE, byval end as D3DVALUE, byval density as D3DVALUE) as HRESULT
	SetColor as function(byval This as IDirect3DRMFrame3 ptr, byval as D3DCOLOR) as HRESULT
	SetColorRGB as function(byval This as IDirect3DRMFrame3 ptr, byval red as D3DVALUE, byval green as D3DVALUE, byval blue as D3DVALUE) as HRESULT
	GetZbufferMode as function(byval This as IDirect3DRMFrame3 ptr) as D3DRMZBUFFERMODE
	SetMaterialMode as function(byval This as IDirect3DRMFrame3 ptr, byval as D3DRMMATERIALMODE) as HRESULT
	SetOrientation as function(byval This as IDirect3DRMFrame3 ptr, byval reference as IDirect3DRMFrame3 ptr, byval dx as D3DVALUE, byval dy as D3DVALUE, byval dz as D3DVALUE, byval ux as D3DVALUE, byval uy as D3DVALUE, byval uz as D3DVALUE) as HRESULT
	SetPosition as function(byval This as IDirect3DRMFrame3 ptr, byval reference as IDirect3DRMFrame3 ptr, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE) as HRESULT
	SetRotation as function(byval This as IDirect3DRMFrame3 ptr, byval reference as IDirect3DRMFrame3 ptr, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE, byval theta as D3DVALUE) as HRESULT
	SetSortMode as function(byval This as IDirect3DRMFrame3 ptr, byval as D3DRMSORTMODE) as HRESULT
	SetTexture as function(byval This as IDirect3DRMFrame3 ptr, byval texture as IDirect3DRMTexture3 ptr) as HRESULT
	SetVelocity as function(byval This as IDirect3DRMFrame3 ptr, byval reference as IDirect3DRMFrame3 ptr, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE, byval with_rotation as WINBOOL) as HRESULT
	SetZbufferMode as function(byval This as IDirect3DRMFrame3 ptr, byval as D3DRMZBUFFERMODE) as HRESULT
	Transform as function(byval This as IDirect3DRMFrame3 ptr, byval d as D3DVECTOR ptr, byval s as D3DVECTOR ptr) as HRESULT
	GetBox as function(byval This as IDirect3DRMFrame3 ptr, byval box as D3DRMBOX ptr) as HRESULT
	GetBoxEnable as function(byval This as IDirect3DRMFrame3 ptr) as WINBOOL
	GetAxes as function(byval This as IDirect3DRMFrame3 ptr, byval dir as D3DVECTOR ptr, byval up as D3DVECTOR ptr) as HRESULT
	GetMaterial as function(byval This as IDirect3DRMFrame3 ptr, byval material as IDirect3DRMMaterial2 ptr ptr) as HRESULT
	GetInheritAxes as function(byval This as IDirect3DRMFrame3 ptr) as WINBOOL
	GetHierarchyBox as function(byval This as IDirect3DRMFrame3 ptr, byval box as D3DRMBOX ptr) as HRESULT
	SetBox as function(byval This as IDirect3DRMFrame3 ptr, byval box as D3DRMBOX ptr) as HRESULT
	SetBoxEnable as function(byval This as IDirect3DRMFrame3 ptr, byval as WINBOOL) as HRESULT
	SetAxes as function(byval This as IDirect3DRMFrame3 ptr, byval dx as D3DVALUE, byval dy as D3DVALUE, byval dz as D3DVALUE, byval ux as D3DVALUE, byval uy as D3DVALUE, byval uz as D3DVALUE) as HRESULT
	SetInheritAxes as function(byval This as IDirect3DRMFrame3 ptr, byval inherit_from_parent as WINBOOL) as HRESULT
	SetMaterial as function(byval This as IDirect3DRMFrame3 ptr, byval material as IDirect3DRMMaterial2 ptr) as HRESULT
	SetQuaternion as function(byval This as IDirect3DRMFrame3 ptr, byval reference as IDirect3DRMFrame3 ptr, byval q as D3DRMQUATERNION ptr) as HRESULT
	RayPick as function(byval This as IDirect3DRMFrame3 ptr, byval reference as IDirect3DRMFrame3 ptr, byval ray as D3DRMRAY ptr, byval flags as DWORD, byval return_visuals as IDirect3DRMPicked2Array ptr ptr) as HRESULT
	Save as function(byval This as IDirect3DRMFrame3 ptr, byval filename as const zstring ptr, byval format as D3DRMXOFFORMAT, byval flags as D3DRMSAVEOPTIONS) as HRESULT
	TransformVectors as function(byval This as IDirect3DRMFrame3 ptr, byval reference as IDirect3DRMFrame3 ptr, byval vector_count as DWORD, byval dst_vectors as D3DVECTOR ptr, byval src_vectors as D3DVECTOR ptr) as HRESULT
	InverseTransformVectors as function(byval This as IDirect3DRMFrame3 ptr, byval reference as IDirect3DRMFrame3 ptr, byval vector_count as DWORD, byval dst_vectors as D3DVECTOR ptr, byval src_vectors as D3DVECTOR ptr) as HRESULT
	SetTraversalOptions as function(byval This as IDirect3DRMFrame3 ptr, byval flags as DWORD) as HRESULT
	GetTraversalOptions as function(byval This as IDirect3DRMFrame3 ptr, byval flags as DWORD ptr) as HRESULT
	SetSceneFogMethod as function(byval This as IDirect3DRMFrame3 ptr, byval flags as DWORD) as HRESULT
	GetSceneFogMethod as function(byval This as IDirect3DRMFrame3 ptr, byval fog_mode as DWORD ptr) as HRESULT
	SetMaterialOverride as function(byval This as IDirect3DRMFrame3 ptr, byval override as D3DRMMATERIALOVERRIDE ptr) as HRESULT
	GetMaterialOverride as function(byval This as IDirect3DRMFrame3 ptr, byval override as D3DRMMATERIALOVERRIDE ptr) as HRESULT
end type

#define IDirect3DRMFrame3_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMFrame3_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMFrame3_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMFrame3_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirect3DRMFrame3_AddDestroyCallback(p, a, b) (p)->lpVtbl->AddDestroyCallback(p, a, b)
#define IDirect3DRMFrame3_DeleteDestroyCallback(p, a, b) (p)->lpVtbl->DeleteDestroyCallback(p, a, b)
#define IDirect3DRMFrame3_SetAppData(p, a) (p)->lpVtbl->SetAppData(p, a)
#define IDirect3DRMFrame3_GetAppData(p) (p)->lpVtbl->GetAppData(p)
#define IDirect3DRMFrame3_SetName(p, a) (p)->lpVtbl->SetName(p, a)
#define IDirect3DRMFrame3_GetName(p, a, b) (p)->lpVtbl->GetName(p, a, b)
#define IDirect3DRMFrame3_GetClassName(p, a, b) (p)->lpVtbl->GetClassName(p, a, b)
#define IDirect3DRMFrame3_AddChild(p, a) (p)->lpVtbl->AddChild(p, a)
#define IDirect3DRMFrame3_AddLight(p, a) (p)->lpVtbl->AddLight(p, a)
#define IDirect3DRMFrame3_AddMoveCallback(p, a, b, c) (p)->lpVtbl->AddMoveCallback(p, a, b, c)
#define IDirect3DRMFrame3_AddTransform(p, a, b) (p)->lpVtbl->AddTransform(p, a, b)
#define IDirect3DRMFrame3_AddTranslation(p, a, b, c, d) (p)->lpVtbl->AddTranslation(p, a, b, c, d)
#define IDirect3DRMFrame3_AddScale(p, a, b, c, d) (p)->lpVtbl->AddScale(p, a, b, c, d)
#define IDirect3DRMFrame3_AddRotation(p, a, b, c, d, e) (p)->lpVtbl->AddRotation(p, a, b, c, d, e)
#define IDirect3DRMFrame3_AddVisual(p, a) (p)->lpVtbl->AddVisual(p, a)
#define IDirect3DRMFrame3_GetChildren(p, a) (p)->lpVtbl->GetChildren(p, a)
#define IDirect3DRMFrame3_GetColor(p) (p)->lpVtbl->GetColor(p)
#define IDirect3DRMFrame3_GetLights(p, a) (p)->lpVtbl->GetLights(p, a)
#define IDirect3DRMFrame3_GetMaterialMode(p) (p)->lpVtbl->GetMaterialMode(p)
#define IDirect3DRMFrame3_GetParent(p, a) (p)->lpVtbl->GetParent(p, a)
#define IDirect3DRMFrame3_GetPosition(p, a, b) (p)->lpVtbl->GetPosition(p, a, b)
#define IDirect3DRMFrame3_GetRotation(p, a, b, c) (p)->lpVtbl->GetRotation(p, a, b, c)
#define IDirect3DRMFrame3_GetScene(p, a) (p)->lpVtbl->GetScene(p, a)
#define IDirect3DRMFrame3_GetSortMode(p) (p)->lpVtbl->GetSortMode(p)
#define IDirect3DRMFrame3_GetTexture(p, a) (p)->lpVtbl->GetTexture(p, a)
#define IDirect3DRMFrame3_GetTransform(p, a, b) (p)->lpVtbl->GetTransform(p, a, b)
#define IDirect3DRMFrame3_GetVelocity(p, a, b, c) (p)->lpVtbl->GetVelocity(p, a, b, c)
#define IDirect3DRMFrame3_GetOrientation(p, a, b, c) (p)->lpVtbl->GetOrientation(p, a, b, c)
#define IDirect3DRMFrame3_GetVisuals(p, a, b) (p)->lpVtbl->GetVisuals(p, a, b)
#define IDirect3DRMFrame3_InverseTransform(p, a, b) (p)->lpVtbl->InverseTransform(p, a, b)
#define IDirect3DRMFrame3_Load(p, a, b, c, d, e) (p)->lpVtbl->Load(p, a, b, c, d, e)
#define IDirect3DRMFrame3_LookAt(p, a, b, c) (p)->lpVtbl->LookAt(p, a, b, c)
#define IDirect3DRMFrame3_Move(p, a) (p)->lpVtbl->Move(p, a)
#define IDirect3DRMFrame3_DeleteChild(p, a) (p)->lpVtbl->DeleteChild(p, a)
#define IDirect3DRMFrame3_DeleteLight(p, a) (p)->lpVtbl->DeleteLight(p, a)
#define IDirect3DRMFrame3_DeleteMoveCallback(p, a, b) (p)->lpVtbl->DeleteMoveCallback(p, a, b)
#define IDirect3DRMFrame3_DeleteVisual(p, a) (p)->lpVtbl->DeleteVisual(p, a)
#define IDirect3DRMFrame3_GetSceneBackground(p) (p)->lpVtbl->GetSceneBackground(p)
#define IDirect3DRMFrame3_GetSceneBackgroundDepth(p, a) (p)->lpVtbl->GetSceneBackgroundDepth(p, a)
#define IDirect3DRMFrame3_GetSceneFogColor(p) (p)->lpVtbl->GetSceneFogColor(p)
#define IDirect3DRMFrame3_GetSceneFogEnable(p) (p)->lpVtbl->GetSceneFogEnable(p)
#define IDirect3DRMFrame3_GetSceneFogMode(p) (p)->lpVtbl->GetSceneFogMode(p)
#define IDirect3DRMFrame3_GetSceneFogParams(p, a, b, c) (p)->lpVtbl->GetSceneFogParams(p, a, b, c)
#define IDirect3DRMFrame3_SetSceneBackground(p, a) (p)->lpVtbl->SetSceneBackground(p, a)
#define IDirect3DRMFrame3_SetSceneBackgroundRGB(p, a, b, c) (p)->lpVtbl->SetSceneBackgroundRGB(p, a, b, c)
#define IDirect3DRMFrame3_SetSceneBackgroundDepth(p, a) (p)->lpVtbl->SetSceneBackgroundDepth(p, a)
#define IDirect3DRMFrame3_SetSceneBackgroundImage(p, a) (p)->lpVtbl->SetSceneBackgroundImage(p, a)
#define IDirect3DRMFrame3_SetSceneFogEnable(p, a) (p)->lpVtbl->SetSceneFogEnable(p, a)
#define IDirect3DRMFrame3_SetSceneFogColor(p, a) (p)->lpVtbl->SetSceneFogColor(p, a)
#define IDirect3DRMFrame3_SetSceneFogMode(p, a) (p)->lpVtbl->SetSceneFogMode(p, a)
#define IDirect3DRMFrame3_SetSceneFogParams(p, a, b, c) (p)->lpVtbl->SetSceneFogParams(p, a, b, c)
#define IDirect3DRMFrame3_SetColor(p, a) (p)->lpVtbl->SetColor(p, a)
#define IDirect3DRMFrame3_SetColorRGB(p, a, b, c) (p)->lpVtbl->SetColorRGB(p, a, b, c)
#define IDirect3DRMFrame3_GetZbufferMode(p) (p)->lpVtbl->GetZbufferMode(p)
#define IDirect3DRMFrame3_SetMaterialMode(p, a) (p)->lpVtbl->SetMaterialMode(p, a)
#define IDirect3DRMFrame3_SetOrientation(p, a, b, c, d, e, f, g) (p)->lpVtbl->SetOrientation(p, a, b, c, d, e, f, g)
#define IDirect3DRMFrame3_SetPosition(p, a, b, c, d) (p)->lpVtbl->SetPosition(p, a, b, c, d)
#define IDirect3DRMFrame3_SetRotation(p, a, b, c, d, e) (p)->lpVtbl->SetRotation(p, a, b, c, d, e)
#define IDirect3DRMFrame3_SetSortMode(p, a) (p)->lpVtbl->SetSortMode(p, a)
#define IDirect3DRMFrame3_SetTexture(p, a) (p)->lpVtbl->SetTexture(p, a)
#define IDirect3DRMFrame3_SetVelocity(p, a, b, c, d, e) (p)->lpVtbl->SetVelocity(p, a, b, c, d, e)
#define IDirect3DRMFrame3_SetZbufferMode(p, a) (p)->lpVtbl->SetZbufferMode(p, a)
#define IDirect3DRMFrame3_Transform(p, a, b) (p)->lpVtbl->Transform(p, a, b)
#define IDirect3DRMFrame3_GetBox(p, a) (p)->lpVtbl->GetBox(p, a)
#define IDirect3DRMFrame3_GetBoxEnable(p) (p)->lpVtbl->GetBoxEnable(p)
#define IDirect3DRMFrame3_GetAxes(p, a, b) (p)->lpVtbl->GetAxes(p, a, b)
#define IDirect3DRMFrame3_GetMaterial(p, a) (p)->lpVtbl->GetMaterial(p, a)
#define IDirect3DRMFrame3_GetInheritAxes(p) (p)->lpVtbl->GetInheritAxes(p)
#define IDirect3DRMFrame3_GetHierarchyBox(p, a) (p)->lpVtbl->GetHierarchyBox(p, a)
#define IDirect3DRMFrame3_SetBox(p, a) (p)->lpVtbl->SetBox(p, a)
#define IDirect3DRMFrame3_SetBoxEnable(p, a) (p)->lpVtbl->SetBoxEnable(p, a)
#define IDirect3DRMFrame3_SetAxes(p, a, b, c, d, e, f) (p)->lpVtbl->SetAxes(p, a, b, c, d, e, f)
#define IDirect3DRMFrame3_SetInheritAxes(p, a) (p)->lpVtbl->SetInheritAxes(p, a)
#define IDirect3DRMFrame3_SetMaterial(p, a) (p)->lpVtbl->SetMaterial(p, a)
#define IDirect3DRMFrame3_SetQuaternion(p, a, b) (p)->lpVtbl->SetQuaternion(p, a, b)
#define IDirect3DRMFrame3_RayPick(p, a, b, c, d) (p)->lpVtbl->RayPick(p, a, b, c, d)
#define IDirect3DRMFrame3_Save(p, a, b, c) (p)->lpVtbl->Save(p, a, b, c)
#define IDirect3DRMFrame3_TransformVectors(p, a, b, c, d) (p)->lpVtbl->TransformVectors(p, a, b, c, d)
#define IDirect3DRMFrame3_InverseTransformVectors(p, a, b, c, d) (p)->lpVtbl->InverseTransformVectors(p, a, b, c, d)
#define IDirect3DRMFrame3_SetTraversalOptions(p, a) (p)->lpVtbl->SetTraversalOptions(p, a)
#define IDirect3DRMFrame3_GetTraversalOptions(p, a) (p)->lpVtbl->GetTraversalOptions(p, a)
#define IDirect3DRMFrame3_SetSceneFogMethod(p, a) (p)->lpVtbl->SetSceneFogMethod(p, a)
#define IDirect3DRMFrame3_GetSceneFogMethod(p, a) (p)->lpVtbl->GetSceneFogMethod(p, a)
#define IDirect3DRMFrame3_SetMaterialOverride(p, a) (p)->lpVtbl->SetMaterialOverride(p, a)
#define IDirect3DRMFrame3_GetMaterialOverride(p, a) (p)->lpVtbl->GetMaterialOverride(p, a)
type IDirect3DRMMeshVtbl as IDirect3DRMMeshVtbl_

type IDirect3DRMMesh
	lpVtbl as IDirect3DRMMeshVtbl ptr
end type

type IDirect3DRMMeshVtbl_
	QueryInterface as function(byval This as IDirect3DRMMesh ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMMesh ptr) as ULONG
	Release as function(byval This as IDirect3DRMMesh ptr) as ULONG
	Clone as function(byval This as IDirect3DRMMesh ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddDestroyCallback as function(byval This as IDirect3DRMMesh ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	DeleteDestroyCallback as function(byval This as IDirect3DRMMesh ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	SetAppData as function(byval This as IDirect3DRMMesh ptr, byval data as DWORD) as HRESULT
	GetAppData as function(byval This as IDirect3DRMMesh ptr) as DWORD
	SetName as function(byval This as IDirect3DRMMesh ptr, byval name as const zstring ptr) as HRESULT
	GetName as function(byval This as IDirect3DRMMesh ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	GetClassName as function(byval This as IDirect3DRMMesh ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	Scale as function(byval This as IDirect3DRMMesh ptr, byval sx as D3DVALUE, byval sy as D3DVALUE, byval sz as D3DVALUE) as HRESULT
	Translate as function(byval This as IDirect3DRMMesh ptr, byval tx as D3DVALUE, byval ty as D3DVALUE, byval tz as D3DVALUE) as HRESULT
	GetBox as function(byval This as IDirect3DRMMesh ptr, byval as D3DRMBOX ptr) as HRESULT
	AddGroup as function(byval This as IDirect3DRMMesh ptr, byval vCount as ulong, byval fCount as ulong, byval vPerFace as ulong, byval fData as ulong ptr, byval returnId as D3DRMGROUPINDEX ptr) as HRESULT
	SetVertices as function(byval This as IDirect3DRMMesh ptr, byval id as D3DRMGROUPINDEX, byval index as ulong, byval count as ulong, byval values as D3DRMVERTEX ptr) as HRESULT
	SetGroupColor as function(byval This as IDirect3DRMMesh ptr, byval id as D3DRMGROUPINDEX, byval value as D3DCOLOR) as HRESULT
	SetGroupColorRGB as function(byval This as IDirect3DRMMesh ptr, byval id as D3DRMGROUPINDEX, byval red as D3DVALUE, byval green as D3DVALUE, byval blue as D3DVALUE) as HRESULT
	SetGroupMapping as function(byval This as IDirect3DRMMesh ptr, byval id as D3DRMGROUPINDEX, byval value as D3DRMMAPPING) as HRESULT
	SetGroupQuality as function(byval This as IDirect3DRMMesh ptr, byval id as D3DRMGROUPINDEX, byval value as D3DRMRENDERQUALITY) as HRESULT
	SetGroupMaterial as function(byval This as IDirect3DRMMesh ptr, byval id as D3DRMGROUPINDEX, byval material as IDirect3DRMMaterial ptr) as HRESULT
	SetGroupTexture as function(byval This as IDirect3DRMMesh ptr, byval id as D3DRMGROUPINDEX, byval texture as IDirect3DRMTexture ptr) as HRESULT
	GetGroupCount as function(byval This as IDirect3DRMMesh ptr) as ulong
	GetGroup as function(byval This as IDirect3DRMMesh ptr, byval id as D3DRMGROUPINDEX, byval vCount as ulong ptr, byval fCount as ulong ptr, byval vPerFace as ulong ptr, byval fDataSize as DWORD ptr, byval fData as ulong ptr) as HRESULT
	GetVertices as function(byval This as IDirect3DRMMesh ptr, byval id as D3DRMGROUPINDEX, byval index as DWORD, byval count as DWORD, byval returnPtr as D3DRMVERTEX ptr) as HRESULT
	GetGroupColor as function(byval This as IDirect3DRMMesh ptr, byval id as D3DRMGROUPINDEX) as D3DCOLOR
	GetGroupMapping as function(byval This as IDirect3DRMMesh ptr, byval id as D3DRMGROUPINDEX) as D3DRMMAPPING
	GetGroupQuality as function(byval This as IDirect3DRMMesh ptr, byval id as D3DRMGROUPINDEX) as D3DRMRENDERQUALITY
	GetGroupMaterial as function(byval This as IDirect3DRMMesh ptr, byval id as D3DRMGROUPINDEX, byval material as IDirect3DRMMaterial ptr ptr) as HRESULT
	GetGroupTexture as function(byval This as IDirect3DRMMesh ptr, byval id as D3DRMGROUPINDEX, byval texture as IDirect3DRMTexture ptr ptr) as HRESULT
end type

#define IDirect3DRMMesh_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMMesh_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMMesh_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMMesh_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirect3DRMMesh_AddDestroyCallback(p, a, b) (p)->lpVtbl->AddDestroyCallback(p, a, b)
#define IDirect3DRMMesh_DeleteDestroyCallback(p, a, b) (p)->lpVtbl->DeleteDestroyCallback(p, a, b)
#define IDirect3DRMMesh_SetAppData(p, a) (p)->lpVtbl->SetAppData(p, a)
#define IDirect3DRMMesh_GetAppData(p) (p)->lpVtbl->GetAppData(p)
#define IDirect3DRMMesh_SetName(p, a) (p)->lpVtbl->SetName(p, a)
#define IDirect3DRMMesh_GetName(p, a, b) (p)->lpVtbl->GetName(p, a, b)
#define IDirect3DRMMesh_GetClassName(p, a, b) (p)->lpVtbl->GetClassName(p, a, b)
#define IDirect3DRMMesh_Scale(p, a, b, c) (p)->lpVtbl->Scale(p, a, b, c)
#define IDirect3DRMMesh_Translate(p, a, b, c) (p)->lpVtbl->Translate(p, a, b, c)
#define IDirect3DRMMesh_GetBox(p, a) (p)->lpVtbl->GetBox(p, a)
#define IDirect3DRMMesh_AddGroup(p, a, b, c, d, e) (p)->lpVtbl->AddGroup(p, a, b, c, d, e)
#define IDirect3DRMMesh_SetVertices(p, a, b, c, d) (p)->lpVtbl->SetVertices(p, a, b, c, d)
#define IDirect3DRMMesh_SetGroupColor(p, a, b) (p)->lpVtbl->SetGroupColor(p, a, b)
#define IDirect3DRMMesh_SetGroupColorRGB(p, a, b, c, d) (p)->lpVtbl->SetGroupColorRGB(p, a, b, c, d)
#define IDirect3DRMMesh_SetGroupMapping(p, a, b) (p)->lpVtbl->SetGroupMapping(p, a, b)
#define IDirect3DRMMesh_SetGroupQuality(p, a, b) (p)->lpVtbl->SetGroupQuality(p, a, b)
#define IDirect3DRMMesh_SetGroupMaterial(p, a, b) (p)->lpVtbl->SetGroupMaterial(p, a, b)
#define IDirect3DRMMesh_SetGroupTexture(p, a, b) (p)->lpVtbl->SetGroupTexture(p, a, b)
#define IDirect3DRMMesh_GetGroupCount(p) (p)->lpVtbl->GetGroupCount(p)
#define IDirect3DRMMesh_GetGroup(p, a, b, c, d, e, f) (p)->lpVtbl->GetGroup(p, a, b, c, d, e, f)
#define IDirect3DRMMesh_GetVertices(p, a, b, c, d) (p)->lpVtbl->GetVertices(p, a, b, c, d)
#define IDirect3DRMMesh_GetGroupColor(p, a) (p)->lpVtbl->GetGroupColor(p, a)
#define IDirect3DRMMesh_GetGroupMapping(p, a) (p)->lpVtbl->GetGroupMapping(p, a)
#define IDirect3DRMMesh_GetGroupQuality(p, a) (p)->lpVtbl->GetGroupQuality(p, a)
#define IDirect3DRMMesh_GetGroupMaterial(p, a, b) (p)->lpVtbl->GetGroupMaterial(p, a, b)
#define IDirect3DRMMesh_GetGroupTexture(p, a, b) (p)->lpVtbl->GetGroupTexture(p, a, b)
type IDirect3DRMProgressiveMeshVtbl as IDirect3DRMProgressiveMeshVtbl_

type IDirect3DRMProgressiveMesh
	lpVtbl as IDirect3DRMProgressiveMeshVtbl ptr
end type

type IDirect3DRMProgressiveMeshVtbl_
	QueryInterface as function(byval This as IDirect3DRMProgressiveMesh ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMProgressiveMesh ptr) as ULONG
	Release as function(byval This as IDirect3DRMProgressiveMesh ptr) as ULONG
	Clone as function(byval This as IDirect3DRMProgressiveMesh ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddDestroyCallback as function(byval This as IDirect3DRMProgressiveMesh ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	DeleteDestroyCallback as function(byval This as IDirect3DRMProgressiveMesh ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	SetAppData as function(byval This as IDirect3DRMProgressiveMesh ptr, byval data as DWORD) as HRESULT
	GetAppData as function(byval This as IDirect3DRMProgressiveMesh ptr) as DWORD
	SetName as function(byval This as IDirect3DRMProgressiveMesh ptr, byval name as const zstring ptr) as HRESULT
	GetName as function(byval This as IDirect3DRMProgressiveMesh ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	GetClassName as function(byval This as IDirect3DRMProgressiveMesh ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	Load as function(byval This as IDirect3DRMProgressiveMesh ptr, byval filename as any ptr, byval name as any ptr, byval flags as D3DRMLOADOPTIONS, byval cb as D3DRMLOADTEXTURECALLBACK, byval ctx as any ptr) as HRESULT
	GetLoadStatus as function(byval This as IDirect3DRMProgressiveMesh ptr, byval status as D3DRMPMESHLOADSTATUS ptr) as HRESULT
	SetMinRenderDetail as function(byval This as IDirect3DRMProgressiveMesh ptr, byval d3dVal as D3DVALUE) as HRESULT
	Abort as function(byval This as IDirect3DRMProgressiveMesh ptr, byval flags as DWORD) as HRESULT
	GetFaceDetail as function(byval This as IDirect3DRMProgressiveMesh ptr, byval count as DWORD ptr) as HRESULT
	GetVertexDetail as function(byval This as IDirect3DRMProgressiveMesh ptr, byval count as DWORD ptr) as HRESULT
	SetFaceDetail as function(byval This as IDirect3DRMProgressiveMesh ptr, byval count as DWORD) as HRESULT
	SetVertexDetail as function(byval This as IDirect3DRMProgressiveMesh ptr, byval count as DWORD) as HRESULT
	GetFaceDetailRange as function(byval This as IDirect3DRMProgressiveMesh ptr, byval min_detail as DWORD ptr, byval max_detail as DWORD ptr) as HRESULT
	GetVertexDetailRange as function(byval This as IDirect3DRMProgressiveMesh ptr, byval min_detail as DWORD ptr, byval max_detail as DWORD ptr) as HRESULT
	GetDetail as function(byval This as IDirect3DRMProgressiveMesh ptr, byval pdvVal as D3DVALUE ptr) as HRESULT
	SetDetail as function(byval This as IDirect3DRMProgressiveMesh ptr, byval d3dVal as D3DVALUE) as HRESULT
	RegisterEvents as function(byval This as IDirect3DRMProgressiveMesh ptr, byval event as HANDLE, byval flags as DWORD, byval reserved as DWORD) as HRESULT
	CreateMesh as function(byval This as IDirect3DRMProgressiveMesh ptr, byval mesh as IDirect3DRMMesh ptr ptr) as HRESULT
	Duplicate as function(byval This as IDirect3DRMProgressiveMesh ptr, byval mesh as IDirect3DRMProgressiveMesh ptr ptr) as HRESULT
	GetBox as function(byval This as IDirect3DRMProgressiveMesh ptr, byval box as D3DRMBOX ptr) as HRESULT
	SetQuality as function(byval This as IDirect3DRMProgressiveMesh ptr, byval quality as D3DRMRENDERQUALITY) as HRESULT
	GetQuality as function(byval This as IDirect3DRMProgressiveMesh ptr, byval quality as D3DRMRENDERQUALITY ptr) as HRESULT
end type

#define IDirect3DRMProgressiveMesh_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMProgressiveMesh_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMProgressiveMesh_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMProgressiveMesh_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirect3DRMProgressiveMesh_AddDestroyCallback(p, a, b) (p)->lpVtbl->AddDestroyCallback(p, a, b)
#define IDirect3DRMProgressiveMesh_DeleteDestroyCallback(p, a, b) (p)->lpVtbl->DeleteDestroyCallback(p, a, b)
#define IDirect3DRMProgressiveMesh_SetAppData(p, a) (p)->lpVtbl->SetAppData(p, a)
#define IDirect3DRMProgressiveMesh_GetAppData(p) (p)->lpVtbl->GetAppData(p)
#define IDirect3DRMProgressiveMesh_SetName(p, a) (p)->lpVtbl->SetName(p, a)
#define IDirect3DRMProgressiveMesh_GetName(p, a, b) (p)->lpVtbl->GetName(p, a, b)
#define IDirect3DRMProgressiveMesh_GetClassName(p, a, b) (p)->lpVtbl->GetClassName(p, a, b)
#define IDirect3DRMProgressiveMesh_Load(p, a, b, c, d, e) (p)->lpVtbl->Load(p, a, b, c, d, e)
#define IDirect3DRMProgressiveMesh_GetLoadStatus(p, a) (p)->lpVtbl->GetLoadStatus(p, a)
#define IDirect3DRMProgressiveMesh_SetMinRenderDetail(p, a) (p)->lpVtbl->SetMinRenderDetail(p, a)
#define IDirect3DRMProgressiveMesh_Abort(p, a) (p)->lpVtbl->Abort(p, a)
#define IDirect3DRMProgressiveMesh_GetFaceDetail(p, a) (p)->lpVtbl->GetFaceDetail(p, a)
#define IDirect3DRMProgressiveMesh_GetVertexDetail(p, a) (p)->lpVtbl->GetVertexDetail(p, a)
#define IDirect3DRMProgressiveMesh_SetFaceDetail(p, a) (p)->lpVtbl->SetFaceDetail(p, a)
#define IDirect3DRMProgressiveMesh_SetVertexDetail(p, a) (p)->lpVtbl->SetVertexDetail(p, a)
#define IDirect3DRMProgressiveMesh_GetFaceDetailRange(p, a, b) (p)->lpVtbl->GetFaceDetailRange(p, a, b)
#define IDirect3DRMProgressiveMesh_GetVertexDetailRange(p, a, b) (p)->lpVtbl->GetVertexDetailRange(p, a, b)
#define IDirect3DRMProgressiveMesh_GetDetail(p, a) (p)->lpVtbl->GetDetail(p, a)
#define IDirect3DRMProgressiveMesh_SetDetail(p, a) (p)->lpVtbl->SetDetail(p, a)
#define IDirect3DRMProgressiveMesh_RegisterEvents(p, a, b, c) (p)->lpVtbl->RegisterEvents(p, a, b, c)
#define IDirect3DRMProgressiveMesh_CreateMesh(p, a) (p)->lpVtbl->CreateMesh(p, a)
#define IDirect3DRMProgressiveMesh_Duplicate(p, a) (p)->lpVtbl->Duplicate(p, a)
#define IDirect3DRMProgressiveMesh_GetBox(p, a) (p)->lpVtbl->GetBox(p, a)
#define IDirect3DRMProgressiveMesh_SetQuality(p, a) (p)->lpVtbl->SetQuality(p, a)
#define IDirect3DRMProgressiveMesh_GetQuality(p, a) (p)->lpVtbl->GetQuality(p, a)
type IDirect3DRMShadowVtbl as IDirect3DRMShadowVtbl_

type IDirect3DRMShadow
	lpVtbl as IDirect3DRMShadowVtbl ptr
end type

type IDirect3DRMShadowVtbl_
	QueryInterface as function(byval This as IDirect3DRMShadow ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMShadow ptr) as ULONG
	Release as function(byval This as IDirect3DRMShadow ptr) as ULONG
	Clone as function(byval This as IDirect3DRMShadow ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddDestroyCallback as function(byval This as IDirect3DRMShadow ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	DeleteDestroyCallback as function(byval This as IDirect3DRMShadow ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	SetAppData as function(byval This as IDirect3DRMShadow ptr, byval data as DWORD) as HRESULT
	GetAppData as function(byval This as IDirect3DRMShadow ptr) as DWORD
	SetName as function(byval This as IDirect3DRMShadow ptr, byval name as const zstring ptr) as HRESULT
	GetName as function(byval This as IDirect3DRMShadow ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	GetClassName as function(byval This as IDirect3DRMShadow ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	Init as function(byval This as IDirect3DRMShadow ptr, byval visual as IDirect3DRMVisual ptr, byval light as IDirect3DRMLight ptr, byval px as D3DVALUE, byval py as D3DVALUE, byval pz as D3DVALUE, byval nx as D3DVALUE, byval ny as D3DVALUE, byval nz as D3DVALUE) as HRESULT
end type

#define IDirect3DRMShadow_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMShadow_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMShadow_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMShadow_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirect3DRMShadow_AddDestroyCallback(p, a, b) (p)->lpVtbl->AddDestroyCallback(p, a, b)
#define IDirect3DRMShadow_DeleteDestroyCallback(p, a, b) (p)->lpVtbl->DeleteDestroyCallback(p, a, b)
#define IDirect3DRMShadow_SetAppData(p, a) (p)->lpVtbl->SetAppData(p, a)
#define IDirect3DRMShadow_GetAppData(p) (p)->lpVtbl->GetAppData(p)
#define IDirect3DRMShadow_SetName(p, a) (p)->lpVtbl->SetName(p, a)
#define IDirect3DRMShadow_GetName(p, a, b) (p)->lpVtbl->GetName(p, a, b)
#define IDirect3DRMShadow_GetClassName(p, a, b) (p)->lpVtbl->GetClassName(p, a, b)
#define IDirect3DRMShadow_Init(p, a, b, c, d, e, f, g) (p)->lpVtbl->Load(p, a, b, c, d, e, f, g)
type IDirect3DRMShadow2Vtbl as IDirect3DRMShadow2Vtbl_

type IDirect3DRMShadow2
	lpVtbl as IDirect3DRMShadow2Vtbl ptr
end type

type IDirect3DRMShadow2Vtbl_
	QueryInterface as function(byval This as IDirect3DRMShadow2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMShadow2 ptr) as ULONG
	Release as function(byval This as IDirect3DRMShadow2 ptr) as ULONG
	Clone as function(byval This as IDirect3DRMShadow2 ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddDestroyCallback as function(byval This as IDirect3DRMShadow2 ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	DeleteDestroyCallback as function(byval This as IDirect3DRMShadow2 ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	SetAppData as function(byval This as IDirect3DRMShadow2 ptr, byval data as DWORD) as HRESULT
	GetAppData as function(byval This as IDirect3DRMShadow2 ptr) as DWORD
	SetName as function(byval This as IDirect3DRMShadow2 ptr, byval name as const zstring ptr) as HRESULT
	GetName as function(byval This as IDirect3DRMShadow2 ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	GetClassName as function(byval This as IDirect3DRMShadow2 ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	Init as function(byval This as IDirect3DRMShadow2 ptr, byval object as IUnknown ptr, byval light as IDirect3DRMLight ptr, byval px as D3DVALUE, byval py as D3DVALUE, byval pz as D3DVALUE, byval nx as D3DVALUE, byval ny as D3DVALUE, byval nz as D3DVALUE) as HRESULT
	GetVisual as function(byval This as IDirect3DRMShadow2 ptr, byval visual as IDirect3DRMVisual ptr ptr) as HRESULT
	SetVisual as function(byval This as IDirect3DRMShadow2 ptr, byval visual as IUnknown ptr, byval flags as DWORD) as HRESULT
	GetLight as function(byval This as IDirect3DRMShadow2 ptr, byval light as IDirect3DRMLight ptr ptr) as HRESULT
	SetLight as function(byval This as IDirect3DRMShadow2 ptr, byval light as IDirect3DRMLight ptr, byval flags as DWORD) as HRESULT
	GetPlane as function(byval This as IDirect3DRMShadow2 ptr, byval px as D3DVALUE ptr, byval py as D3DVALUE ptr, byval pz as D3DVALUE ptr, byval nx as D3DVALUE ptr, byval ny as D3DVALUE ptr, byval nz as D3DVALUE ptr) as HRESULT
	SetPlane as function(byval This as IDirect3DRMShadow2 ptr, byval px as D3DVALUE, byval py as D3DVALUE, byval pz as D3DVALUE, byval nx as D3DVALUE, byval ny as D3DVALUE, byval nz as D3DVALUE, byval as DWORD) as HRESULT
	GetOptions as function(byval This as IDirect3DRMShadow2 ptr, byval flags as DWORD ptr) as HRESULT
	SetOptions as function(byval This as IDirect3DRMShadow2 ptr, byval as DWORD) as HRESULT
end type

#define IDirect3DRMShadow2_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMShadow2_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMShadow2_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMShadow2_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirect3DRMShadow2_AddDestroyCallback(p, a, b) (p)->lpVtbl->AddDestroyCallback(p, a, b)
#define IDirect3DRMShadow2_DeleteDestroyCallback(p, a, b) (p)->lpVtbl->DeleteDestroyCallback(p, a, b)
#define IDirect3DRMShadow2_SetAppData(p, a) (p)->lpVtbl->SetAppData(p, a)
#define IDirect3DRMShadow2_GetAppData(p) (p)->lpVtbl->GetAppData(p)
#define IDirect3DRMShadow2_SetName(p, a) (p)->lpVtbl->SetName(p, a)
#define IDirect3DRMShadow2_GetName(p, a, b) (p)->lpVtbl->GetName(p, a, b)
#define IDirect3DRMShadow2_GetClassName(p, a, b) (p)->lpVtbl->GetClassName(p, a, b)
#define IDirect3DRMShadow2_Init(p, a, b, c, d, e, f, g) (p)->lpVtbl->Init(p, a, b, c, d, e, f, g)
#define IDirect3DRMShadow2_GetVisual(p, a) (p)->lpVtbl->GetVisual(p, a)
#define IDirect3DRMShadow2_SetVisual(p, a, b) (p)->lpVtbl->SetVisual(p, a, b)
#define IDirect3DRMShadow2_GetLight(p, a) (p)->lpVtbl->GetLight(p, a)
#define IDirect3DRMShadow2_SetLight(p, a, b) (p)->lpVtbl->SetLight(p, a, b)
#define IDirect3DRMShadow2_GetPlane(p, a, b, c, d, e, f) (p)->lpVtbl->GetPlane(p, a, b, c, d, e, f)
#define IDirect3DRMShadow2_SetPlane(p, a, b, c, d, e, f) (p)->lpVtbl->SetPlane(p, a, b, c, d, e, f)
#define IDirect3DRMShadow2_GetOptions(p, a) (p)->lpVtbl->GetOptions(p, a)
#define IDirect3DRMShadow2_SetOptions(p, a) (p)->lpVtbl->SetOptions(p, a)
type IDirect3DRMFaceVtbl as IDirect3DRMFaceVtbl_

type IDirect3DRMFace
	lpVtbl as IDirect3DRMFaceVtbl ptr
end type

type IDirect3DRMFaceVtbl_
	QueryInterface as function(byval This as IDirect3DRMFace ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMFace ptr) as ULONG
	Release as function(byval This as IDirect3DRMFace ptr) as ULONG
	Clone as function(byval This as IDirect3DRMFace ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddDestroyCallback as function(byval This as IDirect3DRMFace ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	DeleteDestroyCallback as function(byval This as IDirect3DRMFace ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	SetAppData as function(byval This as IDirect3DRMFace ptr, byval data as DWORD) as HRESULT
	GetAppData as function(byval This as IDirect3DRMFace ptr) as DWORD
	SetName as function(byval This as IDirect3DRMFace ptr, byval name as const zstring ptr) as HRESULT
	GetName as function(byval This as IDirect3DRMFace ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	GetClassName as function(byval This as IDirect3DRMFace ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	AddVertex as function(byval This as IDirect3DRMFace ptr, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE) as HRESULT
	AddVertexAndNormalIndexed as function(byval This as IDirect3DRMFace ptr, byval vertex as DWORD, byval normal as DWORD) as HRESULT
	SetColorRGB as function(byval This as IDirect3DRMFace ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetColor as function(byval This as IDirect3DRMFace ptr, byval as D3DCOLOR) as HRESULT
	SetTexture as function(byval This as IDirect3DRMFace ptr, byval texture as IDirect3DRMTexture ptr) as HRESULT
	SetTextureCoordinates as function(byval This as IDirect3DRMFace ptr, byval vertex as DWORD, byval u as D3DVALUE, byval v as D3DVALUE) as HRESULT
	SetMaterial as function(byval This as IDirect3DRMFace ptr, byval material as IDirect3DRMMaterial ptr) as HRESULT
	SetTextureTopology as function(byval This as IDirect3DRMFace ptr, byval wrap_u as WINBOOL, byval wrap_v as WINBOOL) as HRESULT
	GetVertex as function(byval This as IDirect3DRMFace ptr, byval index as DWORD, byval vertex as D3DVECTOR ptr, byval normal as D3DVECTOR ptr) as HRESULT
	GetVertices as function(byval This as IDirect3DRMFace ptr, byval vertex_count as DWORD ptr, byval coords as D3DVECTOR ptr, byval normals as D3DVECTOR ptr) as HRESULT
	GetTextureCoordinates as function(byval This as IDirect3DRMFace ptr, byval vertex as DWORD, byval u as D3DVALUE ptr, byval v as D3DVALUE ptr) as HRESULT
	GetTextureTopology as function(byval This as IDirect3DRMFace ptr, byval wrap_u as WINBOOL ptr, byval wrap_v as WINBOOL ptr) as HRESULT
	GetNormal as function(byval This as IDirect3DRMFace ptr, byval as D3DVECTOR ptr) as HRESULT
	GetTexture as function(byval This as IDirect3DRMFace ptr, byval texture as IDirect3DRMTexture ptr ptr) as HRESULT
	GetMaterial as function(byval This as IDirect3DRMFace ptr, byval material as IDirect3DRMMaterial ptr ptr) as HRESULT
	GetVertexCount as function(byval This as IDirect3DRMFace ptr) as long
	GetVertexIndex as function(byval This as IDirect3DRMFace ptr, byval which as DWORD) as long
	GetTextureCoordinateIndex as function(byval This as IDirect3DRMFace ptr, byval which as DWORD) as long
	GetColor as function(byval This as IDirect3DRMFace ptr) as D3DCOLOR
end type

#define IDirect3DRMFace_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMFace_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMFace_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMFace_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirect3DRMFace_AddDestroyCallback(p, a, b) (p)->lpVtbl->AddDestroyCallback(p, a, b)
#define IDirect3DRMFace_DeleteDestroyCallback(p, a, b) (p)->lpVtbl->DeleteDestroyCallback(p, a, b)
#define IDirect3DRMFace_SetAppData(p, a) (p)->lpVtbl->SetAppData(p, a)
#define IDirect3DRMFace_GetAppData(p) (p)->lpVtbl->GetAppData(p)
#define IDirect3DRMFace_SetName(p, a) (p)->lpVtbl->SetName(p, a)
#define IDirect3DRMFace_GetName(p, a, b) (p)->lpVtbl->GetName(p, a, b)
#define IDirect3DRMFace_GetClassName(p, a, b) (p)->lpVtbl->GetClassName(p, a, b)
#define IDirect3DRMFace_AddVertex(p, a, b, c) (p)->lpVtbl->AddVertex(p, a, b, c)
#define IDirect3DRMFace_AddVertexAndNormalIndexed(p, a, b) (p)->lpVtbl->AddVertexAndNormalIndexed(p, a, b)
#define IDirect3DRMFace_SetColorRGB(p, a, b, c) (p)->lpVtbl->SetColorRGB(p, a, b, c)
#define IDirect3DRMFace_SetColor(p, a) (p)->lpVtbl->SetColor(p, a)
#define IDirect3DRMFace_SetTexture(p, a) (p)->lpVtbl->SetTexture(p, a)
#define IDirect3DRMFace_SetTextureCoordinates(p, a, b, c) (p)->lpVtbl->SetTextureCoordinates(p, a, b, c)
#define IDirect3DRMFace_SetMaterial(p, a) (p)->lpVtbl->SetMaterial(p, a)
#define IDirect3DRMFace_SetTextureTopology(p, a, b) (p)->lpVtbl->SetTextureTopology(p, a, b)
#define IDirect3DRMFace_GetVertex(p, a, b, c) (p)->lpVtbl->GetVertex(p, a, b, c)
#define IDirect3DRMFace_GetVertices(p, a, b, c) (p)->lpVtbl->GetVertices(p, a, b, c)
#define IDirect3DRMFace_GetTextureCoordinates(p, a, b, c) (p)->lpVtbl->GetTextureCoordinates(p, a, b, c)
#define IDirect3DRMFace_GetTextureTopology(p, a, b) (p)->lpVtbl->GetTextureTopology(p, a, b)
#define IDirect3DRMFace_GetNormal(p, a) (p)->lpVtbl->GetNormal(p, a)
#define IDirect3DRMFace_GetTexture(p, a) (p)->lpVtbl->GetTexture(p, a)
#define IDirect3DRMFace_GetVertexCount(p) (p)->lpVtbl->GetVertexCount(p)
#define IDirect3DRMFace_GetVertexIndex(p, a) (p)->lpVtbl->GetVertexIndex(p, a)
#define IDirect3DRMFace_GetTextureCoordinateIndex(p, a) (p)->lpVtbl->GetTextureCoordinateIndex(p, a)
#define IDirect3DRMFace_GetColor(p, a) (p)->lpVtbl->GetColor(p, a)
type IDirect3DRMFace2Vtbl as IDirect3DRMFace2Vtbl_

type IDirect3DRMFace2
	lpVtbl as IDirect3DRMFace2Vtbl ptr
end type

type IDirect3DRMFace2Vtbl_
	QueryInterface as function(byval This as IDirect3DRMFace2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMFace2 ptr) as ULONG
	Release as function(byval This as IDirect3DRMFace2 ptr) as ULONG
	Clone as function(byval This as IDirect3DRMFace2 ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddDestroyCallback as function(byval This as IDirect3DRMFace2 ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	DeleteDestroyCallback as function(byval This as IDirect3DRMFace2 ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	SetAppData as function(byval This as IDirect3DRMFace2 ptr, byval data as DWORD) as HRESULT
	GetAppData as function(byval This as IDirect3DRMFace2 ptr) as DWORD
	SetName as function(byval This as IDirect3DRMFace2 ptr, byval name as const zstring ptr) as HRESULT
	GetName as function(byval This as IDirect3DRMFace2 ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	GetClassName as function(byval This as IDirect3DRMFace2 ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	AddVertex as function(byval This as IDirect3DRMFace2 ptr, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE) as HRESULT
	AddVertexAndNormalIndexed as function(byval This as IDirect3DRMFace2 ptr, byval vertex as DWORD, byval normal as DWORD) as HRESULT
	SetColorRGB as function(byval This as IDirect3DRMFace2 ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE) as HRESULT
	SetColor as function(byval This as IDirect3DRMFace2 ptr, byval as D3DCOLOR) as HRESULT
	SetTexture as function(byval This as IDirect3DRMFace2 ptr, byval texture as IDirect3DRMTexture3 ptr) as HRESULT
	SetTextureCoordinates as function(byval This as IDirect3DRMFace2 ptr, byval vertex as DWORD, byval u as D3DVALUE, byval v as D3DVALUE) as HRESULT
	SetMaterial as function(byval This as IDirect3DRMFace2 ptr, byval material as IDirect3DRMMaterial2 ptr) as HRESULT
	SetTextureTopology as function(byval This as IDirect3DRMFace2 ptr, byval wrap_u as WINBOOL, byval wrap_v as WINBOOL) as HRESULT
	GetVertex as function(byval This as IDirect3DRMFace2 ptr, byval index as DWORD, byval vertex as D3DVECTOR ptr, byval normal as D3DVECTOR ptr) as HRESULT
	GetVertices as function(byval This as IDirect3DRMFace2 ptr, byval vertex_count as DWORD ptr, byval coords as D3DVECTOR ptr, byval normals as D3DVECTOR ptr) as HRESULT
	GetTextureCoordinates as function(byval This as IDirect3DRMFace2 ptr, byval vertex as DWORD, byval u as D3DVALUE ptr, byval v as D3DVALUE ptr) as HRESULT
	GetTextureTopology as function(byval This as IDirect3DRMFace2 ptr, byval wrap_u as WINBOOL ptr, byval wrap_v as WINBOOL ptr) as HRESULT
	GetNormal as function(byval This as IDirect3DRMFace2 ptr, byval as D3DVECTOR ptr) as HRESULT
	GetTexture as function(byval This as IDirect3DRMFace2 ptr, byval texture as IDirect3DRMTexture3 ptr ptr) as HRESULT
	GetMaterial as function(byval This as IDirect3DRMFace2 ptr, byval material as IDirect3DRMMaterial2 ptr ptr) as HRESULT
	GetVertexCount as function(byval This as IDirect3DRMFace2 ptr) as long
	GetVertexIndex as function(byval This as IDirect3DRMFace2 ptr, byval which as DWORD) as long
	GetTextureCoordinateIndex as function(byval This as IDirect3DRMFace2 ptr, byval which as DWORD) as long
	GetColor as function(byval This as IDirect3DRMFace2 ptr) as D3DCOLOR
end type

#define IDirect3DRMFace2_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMFace2_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMFace2_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMFace2_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirect3DRMFace2_AddDestroyCallback(p, a, b) (p)->lpVtbl->AddDestroyCallback(p, a, b)
#define IDirect3DRMFace2_DeleteDestroyCallback(p, a, b) (p)->lpVtbl->DeleteDestroyCallback(p, a, b)
#define IDirect3DRMFace2_SetAppData(p, a) (p)->lpVtbl->SetAppData(p, a)
#define IDirect3DRMFace2_GetAppData(p) (p)->lpVtbl->GetAppData(p)
#define IDirect3DRMFace2_SetName(p, a) (p)->lpVtbl->SetName(p, a)
#define IDirect3DRMFace2_GetName(p, a, b) (p)->lpVtbl->GetName(p, a, b)
#define IDirect3DRMFace2_GetClassName(p, a, b) (p)->lpVtbl->GetClassName(p, a, b)
#define IDirect3DRMFace2_AddVertex(p, a, b, c) (p)->lpVtbl->AddVertex(p, a, b, c)
#define IDirect3DRMFace2_AddVertexAndNormalIndexed(p, a, b) (p)->lpVtbl->AddVertexAndNormalIndexed(p, a, b)
#define IDirect3DRMFace2_SetColorRGB(p, a, b, c) (p)->lpVtbl->SetColorRGB(p, a, b, c)
#define IDirect3DRMFace2_SetColor(p, a) (p)->lpVtbl->SetColor(p, a)
#define IDirect3DRMFace2_SetTexture(p, a) (p)->lpVtbl->SetTexture(p, a)
#define IDirect3DRMFace2_SetTextureCoordinates(p, a, b, c) (p)->lpVtbl->SetTextureCoordinates(p, a, b, c)
#define IDirect3DRMFace2_SetMaterial(p, a) (p)->lpVtbl->SetMaterial(p, a)
#define IDirect3DRMFace2_SetTextureTopology(p, a, b) (p)->lpVtbl->SetTextureTopology(p, a, b)
#define IDirect3DRMFace2_GetVertex(p, a, b, c) (p)->lpVtbl->GetVertex(p, a, b, c)
#define IDirect3DRMFace2_GetVertices(p, a, b, c) (p)->lpVtbl->GetVertices(p, a, b, c)
#define IDirect3DRMFace2_GetTextureCoordinates(p, a, b, c) (p)->lpVtbl->GetTextureCoordinates(p, a, b, c)
#define IDirect3DRMFace2_GetTextureTopology(p, a, b) (p)->lpVtbl->GetTextureTopology(p, a, b)
#define IDirect3DRMFace2_GetNormal(p, a) (p)->lpVtbl->GetNormal(p, a)
#define IDirect3DRMFace2_GetTexture(p, a) (p)->lpVtbl->GetTexture(p, a)
#define IDirect3DRMFace2_GetVertexCount(p) (p)->lpVtbl->GetVertexCount(p)
#define IDirect3DRMFace2_GetVertexIndex(p, a) (p)->lpVtbl->GetVertexIndex(p, a)
#define IDirect3DRMFace2_GetTextureCoordinateIndex(p, a) (p)->lpVtbl->GetTextureCoordinateIndex(p, a)
#define IDirect3DRMFace2_GetColor(p, a) (p)->lpVtbl->GetColor(p, a)
type IDirect3DRMMeshBuilderVtbl as IDirect3DRMMeshBuilderVtbl_

type IDirect3DRMMeshBuilder
	lpVtbl as IDirect3DRMMeshBuilderVtbl ptr
end type

type IDirect3DRMMeshBuilderVtbl_
	QueryInterface as function(byval This as IDirect3DRMMeshBuilder ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMMeshBuilder ptr) as ULONG
	Release as function(byval This as IDirect3DRMMeshBuilder ptr) as ULONG
	Clone as function(byval This as IDirect3DRMMeshBuilder ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddDestroyCallback as function(byval This as IDirect3DRMMeshBuilder ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	DeleteDestroyCallback as function(byval This as IDirect3DRMMeshBuilder ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	SetAppData as function(byval This as IDirect3DRMMeshBuilder ptr, byval data as DWORD) as HRESULT
	GetAppData as function(byval This as IDirect3DRMMeshBuilder ptr) as DWORD
	SetName as function(byval This as IDirect3DRMMeshBuilder ptr, byval name as const zstring ptr) as HRESULT
	GetName as function(byval This as IDirect3DRMMeshBuilder ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	GetClassName as function(byval This as IDirect3DRMMeshBuilder ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	Load as function(byval This as IDirect3DRMMeshBuilder ptr, byval filename as any ptr, byval name as any ptr, byval flags as D3DRMLOADOPTIONS, byval cb as D3DRMLOADTEXTURECALLBACK, byval ctx as any ptr) as HRESULT
	Save as function(byval This as IDirect3DRMMeshBuilder ptr, byval filename as const zstring ptr, byval as D3DRMXOFFORMAT, byval save as D3DRMSAVEOPTIONS) as HRESULT
	Scale as function(byval This as IDirect3DRMMeshBuilder ptr, byval sx as D3DVALUE, byval sy as D3DVALUE, byval sz as D3DVALUE) as HRESULT
	Translate as function(byval This as IDirect3DRMMeshBuilder ptr, byval tx as D3DVALUE, byval ty as D3DVALUE, byval tz as D3DVALUE) as HRESULT
	SetColorSource as function(byval This as IDirect3DRMMeshBuilder ptr, byval as D3DRMCOLORSOURCE) as HRESULT
	GetBox as function(byval This as IDirect3DRMMeshBuilder ptr, byval as D3DRMBOX ptr) as HRESULT
	GenerateNormals as function(byval This as IDirect3DRMMeshBuilder ptr) as HRESULT
	GetColorSource as function(byval This as IDirect3DRMMeshBuilder ptr) as D3DRMCOLORSOURCE
	AddMesh as function(byval This as IDirect3DRMMeshBuilder ptr, byval mesh as IDirect3DRMMesh ptr) as HRESULT
	AddMeshBuilder as function(byval This as IDirect3DRMMeshBuilder ptr, byval mesh_builder as IDirect3DRMMeshBuilder ptr) as HRESULT
	AddFrame as function(byval This as IDirect3DRMMeshBuilder ptr, byval frame as IDirect3DRMFrame ptr) as HRESULT
	AddFace as function(byval This as IDirect3DRMMeshBuilder ptr, byval face as IDirect3DRMFace ptr) as HRESULT
	AddFaces as function(byval This as IDirect3DRMMeshBuilder ptr, byval vertex_count as DWORD, byval vertices as D3DVECTOR ptr, byval normal_count as DWORD, byval normals as D3DVECTOR ptr, byval face_data as DWORD ptr, byval array as IDirect3DRMFaceArray ptr ptr) as HRESULT
	ReserveSpace as function(byval This as IDirect3DRMMeshBuilder ptr, byval vertex_Count as DWORD, byval normal_count as DWORD, byval face_count as DWORD) as HRESULT
	SetColorRGB as function(byval This as IDirect3DRMMeshBuilder ptr, byval red as D3DVALUE, byval green as D3DVALUE, byval blue as D3DVALUE) as HRESULT
	SetColor as function(byval This as IDirect3DRMMeshBuilder ptr, byval as D3DCOLOR) as HRESULT
	SetTexture as function(byval This as IDirect3DRMMeshBuilder ptr, byval texture as IDirect3DRMTexture ptr) as HRESULT
	SetMaterial as function(byval This as IDirect3DRMMeshBuilder ptr, byval material as IDirect3DRMMaterial ptr) as HRESULT
	SetTextureTopology as function(byval This as IDirect3DRMMeshBuilder ptr, byval wrap_u as WINBOOL, byval wrap_v as WINBOOL) as HRESULT
	SetQuality as function(byval This as IDirect3DRMMeshBuilder ptr, byval as D3DRMRENDERQUALITY) as HRESULT
	SetPerspective as function(byval This as IDirect3DRMMeshBuilder ptr, byval as WINBOOL) as HRESULT
	SetVertex as function(byval This as IDirect3DRMMeshBuilder ptr, byval index as DWORD, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE) as HRESULT
	SetNormal as function(byval This as IDirect3DRMMeshBuilder ptr, byval index as DWORD, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE) as HRESULT
	SetTextureCoordinates as function(byval This as IDirect3DRMMeshBuilder ptr, byval index as DWORD, byval u as D3DVALUE, byval v as D3DVALUE) as HRESULT
	SetVertexColor as function(byval This as IDirect3DRMMeshBuilder ptr, byval index as DWORD, byval as D3DCOLOR) as HRESULT
	SetVertexColorRGB as function(byval This as IDirect3DRMMeshBuilder ptr, byval index as DWORD, byval red as D3DVALUE, byval green as D3DVALUE, byval blue as D3DVALUE) as HRESULT
	GetFaces as function(byval This as IDirect3DRMMeshBuilder ptr, byval array as IDirect3DRMFaceArray ptr ptr) as HRESULT
	GetVertices as function(byval This as IDirect3DRMMeshBuilder ptr, byval vcount as DWORD ptr, byval vertices as D3DVECTOR ptr, byval ncount as DWORD ptr, byval normals as D3DVECTOR ptr, byval face_data_size as DWORD ptr, byval face_data as DWORD ptr) as HRESULT
	GetTextureCoordinates as function(byval This as IDirect3DRMMeshBuilder ptr, byval index as DWORD, byval u as D3DVALUE ptr, byval v as D3DVALUE ptr) as HRESULT
	AddVertex as function(byval This as IDirect3DRMMeshBuilder ptr, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE) as long
	AddNormal as function(byval This as IDirect3DRMMeshBuilder ptr, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE) as long
	CreateFace as function(byval This as IDirect3DRMMeshBuilder ptr, byval face as IDirect3DRMFace ptr ptr) as HRESULT
	GetQuality as function(byval This as IDirect3DRMMeshBuilder ptr) as D3DRMRENDERQUALITY
	GetPerspective as function(byval This as IDirect3DRMMeshBuilder ptr) as WINBOOL
	GetFaceCount as function(byval This as IDirect3DRMMeshBuilder ptr) as long
	GetVertexCount as function(byval This as IDirect3DRMMeshBuilder ptr) as long
	GetVertexColor as function(byval This as IDirect3DRMMeshBuilder ptr, byval index as DWORD) as D3DCOLOR
	CreateMesh as function(byval This as IDirect3DRMMeshBuilder ptr, byval mesh as IDirect3DRMMesh ptr ptr) as HRESULT
end type

#define IDirect3DRMMeshBuilder_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMMeshBuilder_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMMeshBuilder_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMMeshBuilder_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirect3DRMMeshBuilder_AddDestroyCallback(p, a, b) (p)->lpVtbl->AddDestroyCallback(p, a, b)
#define IDirect3DRMMeshBuilder_DeleteDestroyCallback(p, a, b) (p)->lpVtbl->DeleteDestroyCallback(p, a, b)
#define IDirect3DRMMeshBuilder_SetAppData(p, a) (p)->lpVtbl->SetAppData(p, a)
#define IDirect3DRMMeshBuilder_GetAppData(p) (p)->lpVtbl->GetAppData(p)
#define IDirect3DRMMeshBuilder_SetName(p, a) (p)->lpVtbl->SetName(p, a)
#define IDirect3DRMMeshBuilder_GetName(p, a, b) (p)->lpVtbl->GetName(p, a, b)
#define IDirect3DRMMeshBuilder_GetClassName(p, a, b) (p)->lpVtbl->GetClassName(p, a, b)
#define IDirect3DRMMeshBuilder_Load(p, a, b, c, d, e) (p)->lpVtbl->Load(p, a, b, c, d, e)
#define IDirect3DRMMeshBuilder_Save(p, a, b, c) (p)->lpVtbl->Save(p, a, b, c)
#define IDirect3DRMMeshBuilder_Scale(p, a, b, c) (p)->lpVtbl->Scale(p, a, b, c)
#define IDirect3DRMMeshBuilder_Translate(p, a, b, c) (p)->lpVtbl->Translate(p, a)
#define IDirect3DRMMeshBuilder_SetColorSource(p, a) (p)->lpVtbl->SetColorSource(p, a, b, c)
#define IDirect3DRMMeshBuilder_GetBox(p, a) (p)->lpVtbl->GetBox(p, a)
#define IDirect3DRMMeshBuilder_GenerateNormals(p) (p)->lpVtbl->GenerateNormals(p)
#define IDirect3DRMMeshBuilder_GetColorSource(p) (p)->lpVtbl->GetColorSource(p)
#define IDirect3DRMMeshBuilder_AddMesh(p, a) (p)->lpVtbl->AddMesh(p, a)
#define IDirect3DRMMeshBuilder_AddMeshBuilder(p, a) (p)->lpVtbl->AddMeshBuilder(p, a)
#define IDirect3DRMMeshBuilder_AddFrame(p, a) (p)->lpVtbl->AddFrame(p, a)
#define IDirect3DRMMeshBuilder_AddFace(p, a) (p)->lpVtbl->AddFace(p, a)
#define IDirect3DRMMeshBuilder_AddFaces(p, a, b, c, d, e, f) (p)->lpVtbl->AddFaces(p, a, b, c, d, e, f)
#define IDirect3DRMMeshBuilder_ReserveSpace(p, a, b, c) (p)->lpVtbl->ReserveSpace(p, a, b, c)
#define IDirect3DRMMeshBuilder_SetColorRGB(p, a, b, c) (p)->lpVtbl->SetColorRGB(p, a, b, c)
#define IDirect3DRMMeshBuilder_SetColor(p, a) (p)->lpVtbl->SetColor(p, a)
#define IDirect3DRMMeshBuilder_SetTexture(p, a) (p)->lpVtbl->SetTexture(p, a)
#define IDirect3DRMMeshBuilder_SetMaterial(p, a) (p)->lpVtbl->SetMaterial(p, a)
#define IDirect3DRMMeshBuilder_SetTextureTopology(p, a, b) (p)->lpVtbl->SetTextureTopology(p, a, b)
#define IDirect3DRMMeshBuilder_SetQuality(p, a) (p)->lpVtbl->SetQuality(p, a)
#define IDirect3DRMMeshBuilder_SetPerspective(p, a) (p)->lpVtbl->SetPerspective(p, a)
#define IDirect3DRMMeshBuilder_SetVertex(p, a, b, c, d) (p)->lpVtbl->SetVertex(p, a, b, c, d)
#define IDirect3DRMMeshBuilder_SetNormal(p, a, b, c, d) (p)->lpVtbl->SetNormal(p, a, b, c, d)
#define IDirect3DRMMeshBuilder_SetTextureCoordinates(p, a, b, c) (p)->lpVtbl->SetTextureCoordinates(p, a, b, c)
#define IDirect3DRMMeshBuilder_SetVertexColor(p, a, b) (p)->lpVtbl->SetVertexColor(p, a, b)
#define IDirect3DRMMeshBuilder_SetVertexColorRGB(p, a, b, c, d) (p)->lpVtbl->SetVertexColorRGB(p, a, b, c, d)
#define IDirect3DRMMeshBuilder_GetFaces(p, a) (p)->lpVtbl->GetFaces(p, a)
#define IDirect3DRMMeshBuilder_GetVertices(p, a, b, c, d, e, f) (p)->lpVtbl->GetVertices(p, a, b, c, d, e, f)
#define IDirect3DRMMeshBuilder_GetTextureCoordinates(p, a, b, c) (p)->lpVtbl->GetTextureCoordinates(p, a, b, c)
#define IDirect3DRMMeshBuilder_AddVertex(p, a, b, c) (p)->lpVtbl->AddVertex(p, a, b, c)
#define IDirect3DRMMeshBuilder_AddNormal(p, a, b, c) (p)->lpVtbl->AddNormal(p, a, b, c)
#define IDirect3DRMMeshBuilder_CreateFace(p, a) (p)->lpVtbl->CreateFace(p, a)
#define IDirect3DRMMeshBuilder_GetQuality(p) (p)->lpVtbl->GetQuality(p)
#define IDirect3DRMMeshBuilder_GetPerspective(p) (p)->lpVtbl->GetPerspective(p)
#define IDirect3DRMMeshBuilder_GetFaceCount(p) (p)->lpVtbl->GetFaceCount(p)
#define IDirect3DRMMeshBuilder_GetVertexCount(p) (p)->lpVtbl->GetVertexCount(p)
#define IDirect3DRMMeshBuilder_GetVertexColor(p, a) (p)->lpVtbl->GetVertexColor(p, a)
#define IDirect3DRMMeshBuilder_CreateMesh(p, a) (p)->lpVtbl->CreateMesh(p, a)
type IDirect3DRMMeshBuilder2Vtbl as IDirect3DRMMeshBuilder2Vtbl_

type IDirect3DRMMeshBuilder2
	lpVtbl as IDirect3DRMMeshBuilder2Vtbl ptr
end type

type IDirect3DRMMeshBuilder2Vtbl_
	QueryInterface as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMMeshBuilder2 ptr) as ULONG
	Release as function(byval This as IDirect3DRMMeshBuilder2 ptr) as ULONG
	Clone as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddDestroyCallback as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	DeleteDestroyCallback as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	SetAppData as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval data as DWORD) as HRESULT
	GetAppData as function(byval This as IDirect3DRMMeshBuilder2 ptr) as DWORD
	SetName as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval name as const zstring ptr) as HRESULT
	GetName as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	GetClassName as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	Load as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval filename as any ptr, byval name as any ptr, byval flags as D3DRMLOADOPTIONS, byval cb as D3DRMLOADTEXTURECALLBACK, byval ctx as any ptr) as HRESULT
	Save as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval filename as const zstring ptr, byval as D3DRMXOFFORMAT, byval save as D3DRMSAVEOPTIONS) as HRESULT
	Scale as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval sx as D3DVALUE, byval sy as D3DVALUE, byval sz as D3DVALUE) as HRESULT
	Translate as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval tx as D3DVALUE, byval ty as D3DVALUE, byval tz as D3DVALUE) as HRESULT
	SetColorSource as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval as D3DRMCOLORSOURCE) as HRESULT
	GetBox as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval as D3DRMBOX ptr) as HRESULT
	GenerateNormals as function(byval This as IDirect3DRMMeshBuilder2 ptr) as HRESULT
	GetColorSource as function(byval This as IDirect3DRMMeshBuilder2 ptr) as D3DRMCOLORSOURCE
	AddMesh as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval mesh as IDirect3DRMMesh ptr) as HRESULT
	AddMeshBuilder as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval mesh_builder as IDirect3DRMMeshBuilder ptr) as HRESULT
	AddFrame as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval frame as IDirect3DRMFrame ptr) as HRESULT
	AddFace as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval face as IDirect3DRMFace ptr) as HRESULT
	AddFaces as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval vertex_count as DWORD, byval vertices as D3DVECTOR ptr, byval normal_count as DWORD, byval normals as D3DVECTOR ptr, byval face_data as DWORD ptr, byval array as IDirect3DRMFaceArray ptr ptr) as HRESULT
	ReserveSpace as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval vertex_Count as DWORD, byval normal_count as DWORD, byval face_count as DWORD) as HRESULT
	SetColorRGB as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval red as D3DVALUE, byval green as D3DVALUE, byval blue as D3DVALUE) as HRESULT
	SetColor as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval as D3DCOLOR) as HRESULT
	SetTexture as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval texture as IDirect3DRMTexture ptr) as HRESULT
	SetMaterial as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval material as IDirect3DRMMaterial ptr) as HRESULT
	SetTextureTopology as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval wrap_u as WINBOOL, byval wrap_v as WINBOOL) as HRESULT
	SetQuality as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval as D3DRMRENDERQUALITY) as HRESULT
	SetPerspective as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval as WINBOOL) as HRESULT
	SetVertex as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval index as DWORD, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE) as HRESULT
	SetNormal as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval index as DWORD, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE) as HRESULT
	SetTextureCoordinates as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval index as DWORD, byval u as D3DVALUE, byval v as D3DVALUE) as HRESULT
	SetVertexColor as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval index as DWORD, byval as D3DCOLOR) as HRESULT
	SetVertexColorRGB as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval index as DWORD, byval red as D3DVALUE, byval green as D3DVALUE, byval blue as D3DVALUE) as HRESULT
	GetFaces as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval array as IDirect3DRMFaceArray ptr ptr) as HRESULT
	GetVertices as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval vcount as DWORD ptr, byval vertices as D3DVECTOR ptr, byval ncount as DWORD ptr, byval normals as D3DVECTOR ptr, byval face_data_size as DWORD ptr, byval face_data as DWORD ptr) as HRESULT
	GetTextureCoordinates as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval index as DWORD, byval u as D3DVALUE ptr, byval v as D3DVALUE ptr) as HRESULT
	AddVertex as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE) as long
	AddNormal as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE) as long
	CreateFace as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval face as IDirect3DRMFace ptr ptr) as HRESULT
	GetQuality as function(byval This as IDirect3DRMMeshBuilder2 ptr) as D3DRMRENDERQUALITY
	GetPerspective as function(byval This as IDirect3DRMMeshBuilder2 ptr) as WINBOOL
	GetFaceCount as function(byval This as IDirect3DRMMeshBuilder2 ptr) as long
	GetVertexCount as function(byval This as IDirect3DRMMeshBuilder2 ptr) as long
	GetVertexColor as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval index as DWORD) as D3DCOLOR
	CreateMesh as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval mesh as IDirect3DRMMesh ptr ptr) as HRESULT
	GenerateNormals2 as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval crease as D3DVALUE, byval flags as DWORD) as HRESULT
	GetFace as function(byval This as IDirect3DRMMeshBuilder2 ptr, byval index as DWORD, byval face as IDirect3DRMFace ptr ptr) as HRESULT
end type

#define IDirect3DRMMeshBuilder2_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMMeshBuilder2_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMMeshBuilder2_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMMeshBuilder2_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirect3DRMMeshBuilder2_AddDestroyCallback(p, a, b) (p)->lpVtbl->AddDestroyCallback(p, a, b)
#define IDirect3DRMMeshBuilder2_DeleteDestroyCallback(p, a, b) (p)->lpVtbl->DeleteDestroyCallback(p, a, b)
#define IDirect3DRMMeshBuilder2_SetAppData(p, a) (p)->lpVtbl->SetAppData(p, a)
#define IDirect3DRMMeshBuilder2_GetAppData(p) (p)->lpVtbl->GetAppData(p)
#define IDirect3DRMMeshBuilder2_SetName(p, a) (p)->lpVtbl->SetName(p, a)
#define IDirect3DRMMeshBuilder2_GetName(p, a, b) (p)->lpVtbl->GetName(p, a, b)
#define IDirect3DRMMeshBuilder2_GetClassName(p, a, b) (p)->lpVtbl->GetClassName(p, a, b)
#define IDirect3DRMMeshBuilder2_Load(p, a, b, c, d, e) (p)->lpVtbl->Load(p, a, b, c, d, e)
#define IDirect3DRMMeshBuilder2_Save(p, a, b, c) (p)->lpVtbl->Save(p, a, b, c)
#define IDirect3DRMMeshBuilder2_Scale(p, a, b, c) (p)->lpVtbl->Scale(p, a, b, c)
#define IDirect3DRMMeshBuilder2_Translate(p, a, b, c) (p)->lpVtbl->Translate(p, a)
#define IDirect3DRMMeshBuilder2_SetColorSource(p, a) (p)->lpVtbl->SetColorSource(p, a, b, c)
#define IDirect3DRMMeshBuilder2_GetBox(p, a) (p)->lpVtbl->GetBox(p, a)
#define IDirect3DRMMeshBuilder2_GenerateNormals(p) (p)->lpVtbl->GenerateNormals(p)
#define IDirect3DRMMeshBuilder2_GetColorSource(p) (p)->lpVtbl->GetColorSource(p)
#define IDirect3DRMMeshBuilder2_AddMesh(p, a) (p)->lpVtbl->AddMesh(p, a)
#define IDirect3DRMMeshBuilder2_AddMeshBuilder(p, a) (p)->lpVtbl->AddMeshBuilder(p, a)
#define IDirect3DRMMeshBuilder2_AddFrame(p, a) (p)->lpVtbl->AddFrame(p, a)
#define IDirect3DRMMeshBuilder2_AddFace(p, a) (p)->lpVtbl->AddFace(p, a)
#define IDirect3DRMMeshBuilder2_AddFaces(p, a, b, c, d, e, f) (p)->lpVtbl->AddFaces(p, a, b, c, d, e, f)
#define IDirect3DRMMeshBuilder2_ReserveSpace(p, a, b, c) (p)->lpVtbl->ReserveSpace(p, a, b, c)
#define IDirect3DRMMeshBuilder2_SetColorRGB(p, a, b, c) (p)->lpVtbl->SetColorRGB(p, a, b, c)
#define IDirect3DRMMeshBuilder2_SetColor(p, a) (p)->lpVtbl->SetColor(p, a)
#define IDirect3DRMMeshBuilder2_SetTexture(p, a) (p)->lpVtbl->SetTexture(p, a)
#define IDirect3DRMMeshBuilder2_SetMaterial(p, a) (p)->lpVtbl->SetMaterial(p, a)
#define IDirect3DRMMeshBuilder2_SetTextureTopology(p, a, b) (p)->lpVtbl->SetTextureTopology(p, a, b)
#define IDirect3DRMMeshBuilder2_SetQuality(p, a) (p)->lpVtbl->SetQuality(p, a)
#define IDirect3DRMMeshBuilder2_SetPerspective(p, a) (p)->lpVtbl->SetPerspective(p, a)
#define IDirect3DRMMeshBuilder2_SetVertex(p, a, b, c, d) (p)->lpVtbl->SetVertex(p, a, b, c, d)
#define IDirect3DRMMeshBuilder2_SetNormal(p, a, b, c, d) (p)->lpVtbl->SetNormal(p, a, b, c, d)
#define IDirect3DRMMeshBuilder2_SetTextureCoordinates(p, a, b, c) (p)->lpVtbl->SetTextureCoordinates(p, a, b, c)
#define IDirect3DRMMeshBuilder2_SetVertexColor(p, a, b) (p)->lpVtbl->SetVertexColor(p, a, b)
#define IDirect3DRMMeshBuilder2_SetVertexColorRGB(p, a, b, c, d) (p)->lpVtbl->SetVertexColorRGB(p, a, b, c, d)
#define IDirect3DRMMeshBuilder2_GetFaces(p, a) (p)->lpVtbl->GetFaces(p, a)
#define IDirect3DRMMeshBuilder2_GetVertices(p, a, b, c, d, e, f) (p)->lpVtbl->GetVertices(p, a, b, c, d, e, f)
#define IDirect3DRMMeshBuilder2_GetTextureCoordinates(p, a, b, c) (p)->lpVtbl->GetTextureCoordinates(p, a, b, c)
#define IDirect3DRMMeshBuilder2_AddVertex(p, a, b, c) (p)->lpVtbl->AddVertex(p, a, b, c)
#define IDirect3DRMMeshBuilder2_AddNormal(p, a, b, c) (p)->lpVtbl->AddNormal(p, a, b, c)
#define IDirect3DRMMeshBuilder2_CreateFace(p, a) (p)->lpVtbl->CreateFace(p, a)
#define IDirect3DRMMeshBuilder2_GetQuality(p) (p)->lpVtbl->GetQuality(p)
#define IDirect3DRMMeshBuilder2_GetPerspective(p) (p)->lpVtbl->GetPerspective(p)
#define IDirect3DRMMeshBuilder2_GetFaceCount(p) (p)->lpVtbl->GetFaceCount(p)
#define IDirect3DRMMeshBuilder2_GetVertexCount(p) (p)->lpVtbl->GetVertexCount(p)
#define IDirect3DRMMeshBuilder2_GetVertexColor(p, a) (p)->lpVtbl->GetVertexColor(p, a)
#define IDirect3DRMMeshBuilder2_CreateMesh(p, a) (p)->lpVtbl->CreateMesh(p, a)
#define IDirect3DRMMeshBuilder2_GenerateNormals2(p, a, b) (p)->lpVtbl->GenerateNormals2(p, a, b)
#define IDirect3DRMMeshBuilder2_GetFace(p, a, b) (p)->lpVtbl->GetFace(p, a, b)
type IDirect3DRMMeshBuilder3Vtbl as IDirect3DRMMeshBuilder3Vtbl_

type IDirect3DRMMeshBuilder3
	lpVtbl as IDirect3DRMMeshBuilder3Vtbl ptr
end type

type IDirect3DRMMeshBuilder3Vtbl_
	QueryInterface as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMMeshBuilder3 ptr) as ULONG
	Release as function(byval This as IDirect3DRMMeshBuilder3 ptr) as ULONG
	Clone as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddDestroyCallback as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	DeleteDestroyCallback as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	SetAppData as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval data as DWORD) as HRESULT
	GetAppData as function(byval This as IDirect3DRMMeshBuilder3 ptr) as DWORD
	SetName as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval name as const zstring ptr) as HRESULT
	GetName as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	GetClassName as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	Load as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval filename as any ptr, byval name as any ptr, byval flags as D3DRMLOADOPTIONS, byval cb as D3DRMLOADTEXTURE3CALLBACK, byval ctx as any ptr) as HRESULT
	Save as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval filename as const zstring ptr, byval as D3DRMXOFFORMAT, byval save as D3DRMSAVEOPTIONS) as HRESULT
	Scale as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval sx as D3DVALUE, byval sy as D3DVALUE, byval sz as D3DVALUE) as HRESULT
	Translate as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval tx as D3DVALUE, byval ty as D3DVALUE, byval tz as D3DVALUE) as HRESULT
	SetColorSource as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval as D3DRMCOLORSOURCE) as HRESULT
	GetBox as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval as D3DRMBOX ptr) as HRESULT
	GenerateNormals as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval crease as D3DVALUE, byval flags as DWORD) as HRESULT
	GetColorSource as function(byval This as IDirect3DRMMeshBuilder3 ptr) as D3DRMCOLORSOURCE
	AddMesh as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval mesh as IDirect3DRMMesh ptr) as HRESULT
	AddMeshBuilder as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval mesh_builder as IDirect3DRMMeshBuilder3 ptr, byval flags as DWORD) as HRESULT
	AddFrame as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval frame as IDirect3DRMFrame3 ptr) as HRESULT
	AddFace as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval face as IDirect3DRMFace2 ptr) as HRESULT
	AddFaces as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval vertex_count as DWORD, byval vertices as D3DVECTOR ptr, byval normal_count as DWORD, byval normals as D3DVECTOR ptr, byval face_data as DWORD ptr, byval array as IDirect3DRMFaceArray ptr ptr) as HRESULT
	ReserveSpace as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval vertex_Count as DWORD, byval normal_count as DWORD, byval face_count as DWORD) as HRESULT
	SetColorRGB as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval red as D3DVALUE, byval green as D3DVALUE, byval blue as D3DVALUE) as HRESULT
	SetColor as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval as D3DCOLOR) as HRESULT
	SetTexture as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval texture as IDirect3DRMTexture3 ptr) as HRESULT
	SetMaterial as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval material as IDirect3DRMMaterial2 ptr) as HRESULT
	SetTextureTopology as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval wrap_u as WINBOOL, byval wrap_v as WINBOOL) as HRESULT
	SetQuality as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval as D3DRMRENDERQUALITY) as HRESULT
	SetPerspective as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval as WINBOOL) as HRESULT
	SetVertex as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval index as DWORD, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE) as HRESULT
	SetNormal as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval index as DWORD, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE) as HRESULT
	SetTextureCoordinates as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval index as DWORD, byval u as D3DVALUE, byval v as D3DVALUE) as HRESULT
	SetVertexColor as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval index as DWORD, byval as D3DCOLOR) as HRESULT
	SetVertexColorRGB as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval index as DWORD, byval red as D3DVALUE, byval green as D3DVALUE, byval blue as D3DVALUE) as HRESULT
	GetFaces as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval array as IDirect3DRMFaceArray ptr ptr) as HRESULT
	GetGeometry as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval vcount as DWORD ptr, byval vertices as D3DVECTOR ptr, byval ncount as DWORD ptr, byval normals as D3DVECTOR ptr, byval face_data_size as DWORD ptr, byval face_data as DWORD ptr) as HRESULT
	GetTextureCoordinates as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval index as DWORD, byval u as D3DVALUE ptr, byval v as D3DVALUE ptr) as HRESULT
	AddVertex as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE) as long
	AddNormal as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE) as long
	CreateFace as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval face as IDirect3DRMFace2 ptr ptr) as HRESULT
	GetQuality as function(byval This as IDirect3DRMMeshBuilder3 ptr) as D3DRMRENDERQUALITY
	GetPerspective as function(byval This as IDirect3DRMMeshBuilder3 ptr) as WINBOOL
	GetFaceCount as function(byval This as IDirect3DRMMeshBuilder3 ptr) as long
	GetVertexCount as function(byval This as IDirect3DRMMeshBuilder3 ptr) as long
	GetVertexColor as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval index as DWORD) as D3DCOLOR
	CreateMesh as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval mesh as IDirect3DRMMesh ptr ptr) as HRESULT
	GetFace as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval index as DWORD, byval face as IDirect3DRMFace2 ptr ptr) as HRESULT
	GetVertex as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval index as DWORD, byval vector as D3DVECTOR ptr) as HRESULT
	GetNormal as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval index as DWORD, byval vector as D3DVECTOR ptr) as HRESULT
	DeleteVertices as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval IndexFirst as DWORD, byval count as DWORD) as HRESULT
	DeleteNormals as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval IndexFirst as DWORD, byval count as DWORD) as HRESULT
	DeleteFace as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval face as IDirect3DRMFace2 ptr) as HRESULT
	Empty as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval flags as DWORD) as HRESULT
	Optimize as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval flags as DWORD) as HRESULT
	AddFacesIndexed as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval flags as DWORD, byval pvIndices as DWORD ptr, byval pIndexFirst as DWORD ptr, byval pCount as DWORD ptr) as HRESULT
	CreateSubMesh as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval mesh as IUnknown ptr ptr) as HRESULT
	GetParentMesh as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval flags as DWORD, byval parent as IUnknown ptr ptr) as HRESULT
	GetSubMeshes as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval count as DWORD ptr, byval meshes as IUnknown ptr ptr) as HRESULT
	DeleteSubMesh as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval mesh as IUnknown ptr) as HRESULT
	Enable as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval as DWORD) as HRESULT
	GetEnable as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval as DWORD ptr) as HRESULT
	AddTriangles as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval flags as DWORD, byval format as DWORD, byval vertex_count as DWORD, byval data as any ptr) as HRESULT
	SetVertices as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval start_idx as DWORD, byval count as DWORD, byval v as D3DVECTOR ptr) as HRESULT
	GetVertices as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval start_idx as DWORD, byval count as DWORD ptr, byval v as D3DVECTOR ptr) as HRESULT
	SetNormals as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval start_idx as DWORD, byval count as DWORD, byval v as D3DVECTOR ptr) as HRESULT
	GetNormals as function(byval This as IDirect3DRMMeshBuilder3 ptr, byval start_idx as DWORD, byval count as DWORD ptr, byval v as D3DVECTOR ptr) as HRESULT
	GetNormalCount as function(byval This as IDirect3DRMMeshBuilder3 ptr) as long
end type

#define IDirect3DRMMeshBuilder3_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMMeshBuilder3_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMMeshBuilder3_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMMeshBuilder3_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirect3DRMMeshBuilder3_AddDestroyCallback(p, a, b) (p)->lpVtbl->AddDestroyCallback(p, a, b)
#define IDirect3DRMMeshBuilder3_DeleteDestroyCallback(p, a, b) (p)->lpVtbl->DeleteDestroyCallback(p, a, b)
#define IDirect3DRMMeshBuilder3_SetAppData(p, a) (p)->lpVtbl->SetAppData(p, a)
#define IDirect3DRMMeshBuilder3_GetAppData(p) (p)->lpVtbl->GetAppData(p)
#define IDirect3DRMMeshBuilder3_SetName(p, a) (p)->lpVtbl->SetName(p, a)
#define IDirect3DRMMeshBuilder3_GetName(p, a, b) (p)->lpVtbl->GetName(p, a, b)
#define IDirect3DRMMeshBuilder3_GetClassName(p, a, b) (p)->lpVtbl->GetClassName(p, a, b)
#define IDirect3DRMMeshBuilder3_Load(p, a, b, c, d, e) (p)->lpVtbl->Load(p, a, b, c, d, e)
#define IDirect3DRMMeshBuilder3_Save(p, a, b, c) (p)->lpVtbl->Save(p, a, b, c)
#define IDirect3DRMMeshBuilder3_Scale(p, a, b, c) (p)->lpVtbl->Scale(p, a, b, c)
#define IDirect3DRMMeshBuilder3_Translate(p, a, b, c) (p)->lpVtbl->Translate(p, a)
#define IDirect3DRMMeshBuilder3_SetColorSource(p, a) (p)->lpVtbl->SetColorSource(p, a, b, c)
#define IDirect3DRMMeshBuilder3_GetBox(p, a) (p)->lpVtbl->GetBox(p, a)
#define IDirect3DRMMeshBuilder3_GenerateNormals(p, a, b) (p)->lpVtbl->GenerateNormals(p, a, b)
#define IDirect3DRMMeshBuilder3_GetColorSource(p) (p)->lpVtbl->GetColorSource(p)
#define IDirect3DRMMeshBuilder3_AddMesh(p, a) (p)->lpVtbl->AddMesh(p, a)
#define IDirect3DRMMeshBuilder3_AddMeshBuilder(p, a) (p)->lpVtbl->AddMeshBuilder(p, a)
#define IDirect3DRMMeshBuilder3_AddFrame(p, a) (p)->lpVtbl->AddFrame(p, a)
#define IDirect3DRMMeshBuilder3_AddFace(p, a) (p)->lpVtbl->AddFace(p, a)
#define IDirect3DRMMeshBuilder3_AddFaces(p, a, b, c, d, e, f) (p)->lpVtbl->AddFaces(p, a, b, c, d, e, f)
#define IDirect3DRMMeshBuilder3_ReserveSpace(p, a, b, c) (p)->lpVtbl->ReserveSpace(p, a, b, c)
#define IDirect3DRMMeshBuilder3_SetColorRGB(p, a, b, c) (p)->lpVtbl->SetColorRGB(p, a, b, c)
#define IDirect3DRMMeshBuilder3_SetColor(p, a) (p)->lpVtbl->SetColor(p, a)
#define IDirect3DRMMeshBuilder3_SetTexture(p, a) (p)->lpVtbl->SetTexture(p, a)
#define IDirect3DRMMeshBuilder3_SetMaterial(p, a) (p)->lpVtbl->SetMaterial(p, a)
#define IDirect3DRMMeshBuilder3_SetTextureTopology(p, a, b) (p)->lpVtbl->SetTextureTopology(p, a, b)
#define IDirect3DRMMeshBuilder3_SetQuality(p, a) (p)->lpVtbl->SetQuality(p, a)
#define IDirect3DRMMeshBuilder3_SetPerspective(p, a) (p)->lpVtbl->SetPerspective(p, a)
#define IDirect3DRMMeshBuilder3_SetVertex(p, a, b, c, d) (p)->lpVtbl->SetVertex(p, a, b, c, d)
#define IDirect3DRMMeshBuilder3_SetNormal(p, a, b, c, d) (p)->lpVtbl->SetNormal(p, a, b, c, d)
#define IDirect3DRMMeshBuilder3_SetTextureCoordinates(p, a, b, c) (p)->lpVtbl->SetTextureCoordinates(p, a, b, c)
#define IDirect3DRMMeshBuilder3_SetVertexColor(p, a, b) (p)->lpVtbl->SetVertexColor(p, a, b)
#define IDirect3DRMMeshBuilder3_SetVertexColorRGB(p, a, b, c, d) (p)->lpVtbl->SetVertexColorRGB(p, a, b, c, d)
#define IDirect3DRMMeshBuilder3_GetFaces(p, a) (p)->lpVtbl->GetFaces(p, a)
#define IDirect3DRMMeshBuilder3_GetGeometry(p, a, b, c, d, e, f) (p)->lpVtbl->GetGeometry(p, a, b, c, d, e, f)
#define IDirect3DRMMeshBuilder3_GetTextureCoordinates(p, a, b, c) (p)->lpVtbl->GetTextureCoordinates(p, a, b, c)
#define IDirect3DRMMeshBuilder3_AddVertex(p, a, b, c) (p)->lpVtbl->AddVertex(p, a, b, c)
#define IDirect3DRMMeshBuilder3_AddNormal(p, a, b, c) (p)->lpVtbl->AddNormal(p, a, b, c)
#define IDirect3DRMMeshBuilder3_CreateFace(p, a) (p)->lpVtbl->CreateFace(p, a)
#define IDirect3DRMMeshBuilder3_GetQuality(p) (p)->lpVtbl->GetQuality(p)
#define IDirect3DRMMeshBuilder3_GetPerspective(p) (p)->lpVtbl->GetPerspective(p)
#define IDirect3DRMMeshBuilder3_GetFaceCount(p) (p)->lpVtbl->GetFaceCount(p)
#define IDirect3DRMMeshBuilder3_GetVertexCount(p) (p)->lpVtbl->GetVertexCount(p)
#define IDirect3DRMMeshBuilder3_GetVertexColor(p, a) (p)->lpVtbl->GetVertexColor(p, a)
#define IDirect3DRMMeshBuilder3_CreateMesh(p, a) (p)->lpVtbl->CreateMesh(p, a)
#define IDirect3DRMMeshBuilder3_GetFace(p, a, b) (p)->lpVtbl->GetFace(p, a, b)
#define IDirect3DRMMeshBuilder3_GetVertex(p, a, b) (p)->lpVtbl->GetVertex(p, a, b)
#define IDirect3DRMMeshBuilder3_GetNormal(p, a, b) (p)->lpVtbl->GetNormal(p, a, b)
#define IDirect3DRMMeshBuilder3_DeleteVertices(p, a, b) (p)->lpVtbl->DeleteVertices(p, a, b)
#define IDirect3DRMMeshBuilder3_DeleteNormals(p, a, b) (p)->lpVtbl->DeleteNormals(p, a, b)
#define IDirect3DRMMeshBuilder3_DeleteFace(p, a) (p)->lpVtbl->DeleteFace(p, a)
#define IDirect3DRMMeshBuilder3_Empty(p, a) (p)->lpVtbl->Empty(p, a)
#define IDirect3DRMMeshBuilder3_Optimize(p, a) (p)->lpVtbl->Optimize(p, a)
#define IDirect3DRMMeshBuilder3_AddFacesIndexed(p, a, b, c, d) (p)->lpVtbl->AddFacesIndexed(p, a, b, c, d)
#define IDirect3DRMMeshBuilder3_CreateSubMesh(p, a) (p)->lpVtbl->CreateSubMesh(p, a)
#define IDirect3DRMMeshBuilder3_GetParentMesh(p, a, b) (p)->lpVtbl->GetParentMesh(p, a, b)
#define IDirect3DRMMeshBuilder3_GetSubMeshes(p, a, b) (p)->lpVtbl->GetSubMeshes(p, a, b)
#define IDirect3DRMMeshBuilder3_DeleteSubMesh(p, a) (p)->lpVtbl->DeleteSubMesh(p, a)
#define IDirect3DRMMeshBuilder3_Enable(p, a) (p)->lpVtbl->Enable(p, a)
#define IDirect3DRMMeshBuilder3_AddTriangles(p, a, b, c, d) (p)->lpVtbl->AddTriangles(p, a, b, c, d)
#define IDirect3DRMMeshBuilder3_SetVertices(p, a, b, c) (p)->lpVtbl->SetVertices(p, a, b, c)
#define IDirect3DRMMeshBuilder3_GetVertices(p, a, b, c) (p)->lpVtbl->GetVertices(p, a, b, c)
#define IDirect3DRMMeshBuilder3_SetNormals(p, a, b, c) (p)->lpVtbl->SetNormals(p, a, b, c)
#define IDirect3DRMMeshBuilder3_GetNormals(p, a, b, c) (p)->lpVtbl->GetNormals(p, a, b, c)
#define IDirect3DRMMeshBuilder3_GetNormalCount(p) (p)->lpVtbl->GetNormalCount(p)
type IDirect3DRMLightVtbl as IDirect3DRMLightVtbl_

type IDirect3DRMLight_
	lpVtbl as IDirect3DRMLightVtbl ptr
end type

type IDirect3DRMLightVtbl_
	QueryInterface as function(byval This as IDirect3DRMLight ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMLight ptr) as ULONG
	Release as function(byval This as IDirect3DRMLight ptr) as ULONG
	Clone as function(byval This as IDirect3DRMLight ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddDestroyCallback as function(byval This as IDirect3DRMLight ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	DeleteDestroyCallback as function(byval This as IDirect3DRMLight ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	SetAppData as function(byval This as IDirect3DRMLight ptr, byval data as DWORD) as HRESULT
	GetAppData as function(byval This as IDirect3DRMLight ptr) as DWORD
	SetName as function(byval This as IDirect3DRMLight ptr, byval name as const zstring ptr) as HRESULT
	GetName as function(byval This as IDirect3DRMLight ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	GetClassName as function(byval This as IDirect3DRMLight ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	SetType as function(byval This as IDirect3DRMLight ptr, byval as D3DRMLIGHTTYPE) as HRESULT
	SetColor as function(byval This as IDirect3DRMLight ptr, byval as D3DCOLOR) as HRESULT
	SetColorRGB as function(byval This as IDirect3DRMLight ptr, byval red as D3DVALUE, byval green as D3DVALUE, byval blue as D3DVALUE) as HRESULT
	SetRange as function(byval This as IDirect3DRMLight ptr, byval as D3DVALUE) as HRESULT
	SetUmbra as function(byval This as IDirect3DRMLight ptr, byval as D3DVALUE) as HRESULT
	SetPenumbra as function(byval This as IDirect3DRMLight ptr, byval as D3DVALUE) as HRESULT
	SetConstantAttenuation as function(byval This as IDirect3DRMLight ptr, byval as D3DVALUE) as HRESULT
	SetLinearAttenuation as function(byval This as IDirect3DRMLight ptr, byval as D3DVALUE) as HRESULT
	SetQuadraticAttenuation as function(byval This as IDirect3DRMLight ptr, byval as D3DVALUE) as HRESULT
	GetRange as function(byval This as IDirect3DRMLight ptr) as D3DVALUE
	GetUmbra as function(byval This as IDirect3DRMLight ptr) as D3DVALUE
	GetPenumbra as function(byval This as IDirect3DRMLight ptr) as D3DVALUE
	GetConstantAttenuation as function(byval This as IDirect3DRMLight ptr) as D3DVALUE
	GetLinearAttenuation as function(byval This as IDirect3DRMLight ptr) as D3DVALUE
	GetQuadraticAttenuation as function(byval This as IDirect3DRMLight ptr) as D3DVALUE
	GetColor as function(byval This as IDirect3DRMLight ptr) as D3DCOLOR
	GetType as function(byval This as IDirect3DRMLight ptr) as D3DRMLIGHTTYPE
	SetEnableFrame as function(byval This as IDirect3DRMLight ptr, byval frame as IDirect3DRMFrame ptr) as HRESULT
	GetEnableFrame as function(byval This as IDirect3DRMLight ptr, byval frame as IDirect3DRMFrame ptr ptr) as HRESULT
end type

#define IDirect3DRMLight_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMLight_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMLight_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMLight_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirect3DRMLight_AddDestroyCallback(p, a, b) (p)->lpVtbl->AddDestroyCallback(p, a, b)
#define IDirect3DRMLight_DeleteDestroyCallback(p, a, b) (p)->lpVtbl->DeleteDestroyCallback(p, a, b)
#define IDirect3DRMLight_SetAppData(p, a) (p)->lpVtbl->SetAppData(p, a)
#define IDirect3DRMLight_GetAppData(p) (p)->lpVtbl->GetAppData(p)
#define IDirect3DRMLight_SetName(p, a) (p)->lpVtbl->SetName(p, a)
#define IDirect3DRMLight_GetName(p, a, b) (p)->lpVtbl->GetName(p, a, b)
#define IDirect3DRMLight_GetClassName(p, a, b) (p)->lpVtbl->GetClassName(p, a, b)
#define IDirect3DRMLight_SetType(p, a) (p)->lpVtbl->SetType(p, a)
#define IDirect3DRMLight_SetColor(p, a) (p)->lpVtbl->SetColor(p, a)
#define IDirect3DRMLight_SetColorRGB(p, a, b, c) (p)->lpVtbl->SetColorRGB(p, a, b, c)
#define IDirect3DRMLight_SetRange(p, a) (p)->lpVtbl->SetRange(p, a)
#define IDirect3DRMLight_SetUmbra(p, a) (p)->lpVtbl->SetUmbra(p, a)
#define IDirect3DRMLight_SetPenumbra(p, a) (p)->lpVtbl->SetPenumbra(p, a)
#define IDirect3DRMLight_SetConstantAttenuation(p, a) (p)->lpVtbl->SetConstantAttenuation(p, a)
#define IDirect3DRMLight_SetLinearAttenuation(p, a) (p)->lpVtbl->SetLinearAttenuation(p, a)
#define IDirect3DRMLight_SetQuadraticAttenuation(p, a) (p)->lpVtbl->SetQuadraticAttenuation(p, a)
#define IDirect3DRMLight_GetRange(p) (p)->lpVtbl->GetRange(p)
#define IDirect3DRMLight_GetUmbra(p) (p)->lpVtbl->GetUmbra(p)
#define IDirect3DRMLight_GetPenumbra(p) (p)->lpVtbl->GetPenumbra(p)
#define IDirect3DRMLight_GetConstantAttenuation(p) (p)->lpVtbl->GetConstantAttenuation(p)
#define IDirect3DRMLight_GetLinearAttenuation(p) (p)->lpVtbl->GetLinearAttenuation(p)
#define IDirect3DRMLight_GetQuadraticAttenuation(p) (p)->lpVtbl->GetQuadraticAttenuation(p)
#define IDirect3DRMLight_GetColor(p) (p)->lpVtbl->GetColor(p)
#define IDirect3DRMLight_GetType(p) (p)->lpVtbl->GetType(p)
#define IDirect3DRMLight_SetEnableFrame(p, a) (p)->lpVtbl->SetEnableFrame(p, a)
#define IDirect3DRMLight_GetEnableFrame(p, a) (p)->lpVtbl->GetEnableFrame(p, a)
type IDirect3DRMTextureVtbl as IDirect3DRMTextureVtbl_

type IDirect3DRMTexture_
	lpVtbl as IDirect3DRMTextureVtbl ptr
end type

type IDirect3DRMTextureVtbl_
	QueryInterface as function(byval This as IDirect3DRMTexture ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMTexture ptr) as ULONG
	Release as function(byval This as IDirect3DRMTexture ptr) as ULONG
	Clone as function(byval This as IDirect3DRMTexture ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddDestroyCallback as function(byval This as IDirect3DRMTexture ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	DeleteDestroyCallback as function(byval This as IDirect3DRMTexture ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	SetAppData as function(byval This as IDirect3DRMTexture ptr, byval data as DWORD) as HRESULT
	GetAppData as function(byval This as IDirect3DRMTexture ptr) as DWORD
	SetName as function(byval This as IDirect3DRMTexture ptr, byval name as const zstring ptr) as HRESULT
	GetName as function(byval This as IDirect3DRMTexture ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	GetClassName as function(byval This as IDirect3DRMTexture ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	InitFromFile as function(byval This as IDirect3DRMTexture ptr, byval filename as const zstring ptr) as HRESULT
	InitFromSurface as function(byval This as IDirect3DRMTexture ptr, byval surface as IDirectDrawSurface ptr) as HRESULT
	InitFromResource as function(byval This as IDirect3DRMTexture ptr, byval as HRSRC) as HRESULT
	Changed as function(byval This as IDirect3DRMTexture ptr, byval pixels as WINBOOL, byval palette as WINBOOL) as HRESULT
	SetColors as function(byval This as IDirect3DRMTexture ptr, byval as DWORD) as HRESULT
	SetShades as function(byval This as IDirect3DRMTexture ptr, byval as DWORD) as HRESULT
	SetDecalSize as function(byval This as IDirect3DRMTexture ptr, byval width as D3DVALUE, byval height as D3DVALUE) as HRESULT
	SetDecalOrigin as function(byval This as IDirect3DRMTexture ptr, byval x as LONG, byval y as LONG) as HRESULT
	SetDecalScale as function(byval This as IDirect3DRMTexture ptr, byval as DWORD) as HRESULT
	SetDecalTransparency as function(byval This as IDirect3DRMTexture ptr, byval as WINBOOL) as HRESULT
	SetDecalTransparentColor as function(byval This as IDirect3DRMTexture ptr, byval as D3DCOLOR) as HRESULT
	GetDecalSize as function(byval This as IDirect3DRMTexture ptr, byval width_return as D3DVALUE ptr, byval height_return as D3DVALUE ptr) as HRESULT
	GetDecalOrigin as function(byval This as IDirect3DRMTexture ptr, byval x_return as LONG ptr, byval y_return as LONG ptr) as HRESULT
	GetImage as function(byval This as IDirect3DRMTexture ptr) as D3DRMIMAGE ptr
	GetShades as function(byval This as IDirect3DRMTexture ptr) as DWORD
	GetColors as function(byval This as IDirect3DRMTexture ptr) as DWORD
	GetDecalScale as function(byval This as IDirect3DRMTexture ptr) as DWORD
	GetDecalTransparency as function(byval This as IDirect3DRMTexture ptr) as WINBOOL
	GetDecalTransparentColor as function(byval This as IDirect3DRMTexture ptr) as D3DCOLOR
end type

#define IDirect3DRMTexture_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMTexture_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMTexture_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMTexture_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirect3DRMTexture_AddDestroyCallback(p, a, b) (p)->lpVtbl->AddDestroyCallback(p, a, b)
#define IDirect3DRMTexture_DeleteDestroyCallback(p, a, b) (p)->lpVtbl->DeleteDestroyCallback(p, a, b)
#define IDirect3DRMTexture_SetAppData(p, a) (p)->lpVtbl->SetAppData(p, a)
#define IDirect3DRMTexture_GetAppData(p) (p)->lpVtbl->GetAppData(p)
#define IDirect3DRMTexture_SetName(p, a) (p)->lpVtbl->SetName(p, a)
#define IDirect3DRMTexture_GetName(p, a, b) (p)->lpVtbl->GetName(p, a, b)
#define IDirect3DRMTexture_GetClassName(p, a, b) (p)->lpVtbl->GetClassName(p, a, b)
#define IDirect3DRMTexture_InitFromFile(p, a) (p)->lpVtbl->InitFromFile(p, a)
#define IDirect3DRMTexture_InitFromSurface(p, a) (p)->lpVtbl->InitFromSurface(p, a)
#define IDirect3DRMTexture_InitFromResource(p, a) (p)->lpVtbl->InitFromResource(p, a)
#define IDirect3DRMTexture_Changed(p, a, b) (p)->lpVtbl->Changed(p, a, b)
#define IDirect3DRMTexture_SetColors(p, a) (p)->lpVtbl->SetColors(p, a)
#define IDirect3DRMTexture_SetShades(p, a) (p)->lpVtbl->SetShades(p, a)
#define IDirect3DRMTexture_SetDecalSize(p, a, b) (p)->lpVtbl->SetDecalSize(p, a, b)
#define IDirect3DRMTexture_SetDecalOrigin(p, a, b) (p)->lpVtbl->SetDecalOrigin(p, a, b)
#define IDirect3DRMTexture_SetDecalScale(p, a) (p)->lpVtbl->SetDecalScale(p, a)
#define IDirect3DRMTexture_SetDecalTransparency(p, a) (p)->lpVtbl->SetDecalTransparency(p, a)
#define IDirect3DRMTexture_SetDecalTransparencyColor(p, a) (p)->lpVtbl->SetDecalTransparentColor(p, a)
#define IDirect3DRMTexture_GetDecalSize(p, a, b) (p)->lpVtbl->GetDecalSize(p, a, b)
#define IDirect3DRMTexture_GetDecalOrigin(p, a, b) (p)->lpVtbl->GetDecalOrigin(p, a, b)
#define IDirect3DRMTexture_GetImage(p) (p)->lpVtbl->GetImage(p)
#define IDirect3DRMTexture_GetShades(p) (p)->lpVtbl->GetShades(p)
#define IDirect3DRMTexture_GetColors(p) (p)->lpVtbl->GetColors(p)
#define IDirect3DRMTexture_GetDecalScale(p) (p)->lpVtbl->GetDecalScale(p)
#define IDirect3DRMTexture_GetDecalTransparency(p) (p)->lpVtbl->GetDecalTransparency(p)
#define IDirect3DRMTexture_GetDecalTransparencyColor(p) (p)->lpVtbl->GetDecalTransparencyColor(p)
type IDirect3DRMTexture2Vtbl as IDirect3DRMTexture2Vtbl_

type IDirect3DRMTexture2
	lpVtbl as IDirect3DRMTexture2Vtbl ptr
end type

type IDirect3DRMTexture2Vtbl_
	QueryInterface as function(byval This as IDirect3DRMTexture2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMTexture2 ptr) as ULONG
	Release as function(byval This as IDirect3DRMTexture2 ptr) as ULONG
	Clone as function(byval This as IDirect3DRMTexture2 ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddDestroyCallback as function(byval This as IDirect3DRMTexture2 ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	DeleteDestroyCallback as function(byval This as IDirect3DRMTexture2 ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	SetAppData as function(byval This as IDirect3DRMTexture2 ptr, byval data as DWORD) as HRESULT
	GetAppData as function(byval This as IDirect3DRMTexture2 ptr) as DWORD
	SetName as function(byval This as IDirect3DRMTexture2 ptr, byval name as const zstring ptr) as HRESULT
	GetName as function(byval This as IDirect3DRMTexture2 ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	GetClassName as function(byval This as IDirect3DRMTexture2 ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	InitFromFile as function(byval This as IDirect3DRMTexture2 ptr, byval filename as const zstring ptr) as HRESULT
	InitFromSurface as function(byval This as IDirect3DRMTexture2 ptr, byval surface as IDirectDrawSurface ptr) as HRESULT
	InitFromResource as function(byval This as IDirect3DRMTexture2 ptr, byval as HRSRC) as HRESULT
	Changed as function(byval This as IDirect3DRMTexture2 ptr, byval pixels as WINBOOL, byval palette as WINBOOL) as HRESULT
	SetColors as function(byval This as IDirect3DRMTexture2 ptr, byval as DWORD) as HRESULT
	SetShades as function(byval This as IDirect3DRMTexture2 ptr, byval as DWORD) as HRESULT
	SetDecalSize as function(byval This as IDirect3DRMTexture2 ptr, byval width as D3DVALUE, byval height as D3DVALUE) as HRESULT
	SetDecalOrigin as function(byval This as IDirect3DRMTexture2 ptr, byval x as LONG, byval y as LONG) as HRESULT
	SetDecalScale as function(byval This as IDirect3DRMTexture2 ptr, byval as DWORD) as HRESULT
	SetDecalTransparency as function(byval This as IDirect3DRMTexture2 ptr, byval as WINBOOL) as HRESULT
	SetDecalTransparentColor as function(byval This as IDirect3DRMTexture2 ptr, byval as D3DCOLOR) as HRESULT
	GetDecalSize as function(byval This as IDirect3DRMTexture2 ptr, byval width_return as D3DVALUE ptr, byval height_return as D3DVALUE ptr) as HRESULT
	GetDecalOrigin as function(byval This as IDirect3DRMTexture2 ptr, byval x_return as LONG ptr, byval y_return as LONG ptr) as HRESULT
	GetImage as function(byval This as IDirect3DRMTexture2 ptr) as D3DRMIMAGE ptr
	GetShades as function(byval This as IDirect3DRMTexture2 ptr) as DWORD
	GetColors as function(byval This as IDirect3DRMTexture2 ptr) as DWORD
	GetDecalScale as function(byval This as IDirect3DRMTexture2 ptr) as DWORD
	GetDecalTransparency as function(byval This as IDirect3DRMTexture2 ptr) as WINBOOL
	GetDecalTransparentColor as function(byval This as IDirect3DRMTexture2 ptr) as D3DCOLOR
	InitFromImage as function(byval This as IDirect3DRMTexture2 ptr, byval image as D3DRMIMAGE ptr) as HRESULT
	InitFromResource2 as function(byval This as IDirect3DRMTexture2 ptr, byval module as HMODULE, byval name as const zstring ptr, byval type as const zstring ptr) as HRESULT
	GenerateMIPMap as function(byval This as IDirect3DRMTexture2 ptr, byval as DWORD) as HRESULT
end type

#define IDirect3DRMTexture2_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMTexture2_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMTexture2_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMTexture2_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirect3DRMTexture2_AddDestroyCallback(p, a, b) (p)->lpVtbl->AddDestroyCallback(p, a, b)
#define IDirect3DRMTexture2_DeleteDestroyCallback(p, a, b) (p)->lpVtbl->DeleteDestroyCallback(p, a, b)
#define IDirect3DRMTexture2_SetAppData(p, a) (p)->lpVtbl->SetAppData(p, a)
#define IDirect3DRMTexture2_GetAppData(p) (p)->lpVtbl->GetAppData(p)
#define IDirect3DRMTexture2_SetName(p, a) (p)->lpVtbl->SetName(p, a)
#define IDirect3DRMTexture2_GetName(p, a, b) (p)->lpVtbl->GetName(p, a, b)
#define IDirect3DRMTexture2_GetClassName(p, a, b) (p)->lpVtbl->GetClassName(p, a, b)
#define IDirect3DRMTexture2_InitFromFile(p, a) (p)->lpVtbl->InitFromFile(p, a)
#define IDirect3DRMTexture2_InitFromSurface(p, a) (p)->lpVtbl->InitFromSurface(p, a)
#define IDirect3DRMTexture2_InitFromResource(p, a) (p)->lpVtbl->InitFromResource(p, a)
#define IDirect3DRMTexture2_Changed(p, a, b) (p)->lpVtbl->Changed(p, a, b)
#define IDirect3DRMTexture2_SetColors(p, a) (p)->lpVtbl->SetColors(p, a)
#define IDirect3DRMTexture2_SetShades(p, a) (p)->lpVtbl->SetShades(p, a)
#define IDirect3DRMTexture2_SetDecalSize(p, a, b) (p)->lpVtbl->SetDecalSize(p, a, b)
#define IDirect3DRMTexture2_SetDecalOrigin(p, a, b) (p)->lpVtbl->SetDecalOrigin(p, a, b)
#define IDirect3DRMTexture2_SetDecalScale(p, a) (p)->lpVtbl->SetDecalScale(p, a)
#define IDirect3DRMTexture2_SetDecalTransparency(p, a) (p)->lpVtbl->SetDecalTransparency(p, a)
#define IDirect3DRMTexture2_SetDecalTransparencyColor(p, a) (p)->lpVtbl->SetDecalTransparentColor(p, a)
#define IDirect3DRMTexture2_GetDecalSize(p, a, b) (p)->lpVtbl->GetDecalSize(p, a, b)
#define IDirect3DRMTexture2_GetDecalOrigin(p, a, b) (p)->lpVtbl->GetDecalOrigin(p, a, b)
#define IDirect3DRMTexture2_GetImage(p) (p)->lpVtbl->GetImage(p)
#define IDirect3DRMTexture2_GetShades(p) (p)->lpVtbl->GetShades(p)
#define IDirect3DRMTexture2_GetColors(p) (p)->lpVtbl->GetColors(p)
#define IDirect3DRMTexture2_GetDecalScale(p) (p)->lpVtbl->GetDecalScale(p)
#define IDirect3DRMTexture2_GetDecalTransparency(p) (p)->lpVtbl->GetDecalTransparency(p)
#define IDirect3DRMTexture2_GetDecalTransparencyColor(p) (p)->lpVtbl->GetDecalTransparencyColor(p)
#define IDirect3DRMTexture2_InitFromImage(p, a) (p)->lpVtbl->InitFromImage(p, a)
#define IDirect3DRMTexture2_InitFromResource2(p, a, b, c) (p)->lpVtbl->InitFromResource2(p, a, b, c)
#define IDirect3DRMTexture2_GenerateMIPMap(p, a) (p)->lpVtbl->GenerateMIPMap(p, a)
type IDirect3DRMTexture3Vtbl as IDirect3DRMTexture3Vtbl_

type IDirect3DRMTexture3_
	lpVtbl as IDirect3DRMTexture3Vtbl ptr
end type

type IDirect3DRMTexture3Vtbl_
	QueryInterface as function(byval This as IDirect3DRMTexture3 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMTexture3 ptr) as ULONG
	Release as function(byval This as IDirect3DRMTexture3 ptr) as ULONG
	Clone as function(byval This as IDirect3DRMTexture3 ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddDestroyCallback as function(byval This as IDirect3DRMTexture3 ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	DeleteDestroyCallback as function(byval This as IDirect3DRMTexture3 ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	SetAppData as function(byval This as IDirect3DRMTexture3 ptr, byval data as DWORD) as HRESULT
	GetAppData as function(byval This as IDirect3DRMTexture3 ptr) as DWORD
	SetName as function(byval This as IDirect3DRMTexture3 ptr, byval name as const zstring ptr) as HRESULT
	GetName as function(byval This as IDirect3DRMTexture3 ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	GetClassName as function(byval This as IDirect3DRMTexture3 ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	InitFromFile as function(byval This as IDirect3DRMTexture3 ptr, byval filename as const zstring ptr) as HRESULT
	InitFromSurface as function(byval This as IDirect3DRMTexture3 ptr, byval surface as IDirectDrawSurface ptr) as HRESULT
	InitFromResource as function(byval This as IDirect3DRMTexture3 ptr, byval as HRSRC) as HRESULT
	Changed as function(byval This as IDirect3DRMTexture3 ptr, byval flags as DWORD, byval rect_count as DWORD, byval rects as RECT ptr) as HRESULT
	SetColors as function(byval This as IDirect3DRMTexture3 ptr, byval as DWORD) as HRESULT
	SetShades as function(byval This as IDirect3DRMTexture3 ptr, byval as DWORD) as HRESULT
	SetDecalSize as function(byval This as IDirect3DRMTexture3 ptr, byval width as D3DVALUE, byval height as D3DVALUE) as HRESULT
	SetDecalOrigin as function(byval This as IDirect3DRMTexture3 ptr, byval x as LONG, byval y as LONG) as HRESULT
	SetDecalScale as function(byval This as IDirect3DRMTexture3 ptr, byval as DWORD) as HRESULT
	SetDecalTransparency as function(byval This as IDirect3DRMTexture3 ptr, byval as WINBOOL) as HRESULT
	SetDecalTransparentColor as function(byval This as IDirect3DRMTexture3 ptr, byval as D3DCOLOR) as HRESULT
	GetDecalSize as function(byval This as IDirect3DRMTexture3 ptr, byval width_return as D3DVALUE ptr, byval height_return as D3DVALUE ptr) as HRESULT
	GetDecalOrigin as function(byval This as IDirect3DRMTexture3 ptr, byval x_return as LONG ptr, byval y_return as LONG ptr) as HRESULT
	GetImage as function(byval This as IDirect3DRMTexture3 ptr) as D3DRMIMAGE ptr
	GetShades as function(byval This as IDirect3DRMTexture3 ptr) as DWORD
	GetColors as function(byval This as IDirect3DRMTexture3 ptr) as DWORD
	GetDecalScale as function(byval This as IDirect3DRMTexture3 ptr) as DWORD
	GetDecalTransparency as function(byval This as IDirect3DRMTexture3 ptr) as WINBOOL
	GetDecalTransparentColor as function(byval This as IDirect3DRMTexture3 ptr) as D3DCOLOR
	InitFromImage as function(byval This as IDirect3DRMTexture3 ptr, byval image as D3DRMIMAGE ptr) as HRESULT
	InitFromResource2 as function(byval This as IDirect3DRMTexture3 ptr, byval module as HMODULE, byval name as const zstring ptr, byval type as const zstring ptr) as HRESULT
	GenerateMIPMap as function(byval This as IDirect3DRMTexture3 ptr, byval as DWORD) as HRESULT
	GetSurface as function(byval This as IDirect3DRMTexture3 ptr, byval flags as DWORD, byval surface as IDirectDrawSurface ptr ptr) as HRESULT
	SetCacheOptions as function(byval This as IDirect3DRMTexture3 ptr, byval lImportance as LONG, byval dwFlags as DWORD) as HRESULT
	GetCacheOptions as function(byval This as IDirect3DRMTexture3 ptr, byval importance as LONG ptr, byval flags as DWORD ptr) as HRESULT
	SetDownsampleCallback as function(byval This as IDirect3DRMTexture3 ptr, byval cb as D3DRMDOWNSAMPLECALLBACK, byval ctx as any ptr) as HRESULT
	SetValidationCallback as function(byval This as IDirect3DRMTexture3 ptr, byval cb as D3DRMVALIDATIONCALLBACK, byval ctx as any ptr) as HRESULT
end type

#define IDirect3DRMTexture3_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMTexture3_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMTexture3_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMTexture3_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirect3DRMTexture3_AddDestroyCallback(p, a, b) (p)->lpVtbl->AddDestroyCallback(p, a, b)
#define IDirect3DRMTexture3_DeleteDestroyCallback(p, a, b) (p)->lpVtbl->DeleteDestroyCallback(p, a, b)
#define IDirect3DRMTexture3_SetAppData(p, a) (p)->lpVtbl->SetAppData(p, a)
#define IDirect3DRMTexture3_GetAppData(p) (p)->lpVtbl->GetAppData(p)
#define IDirect3DRMTexture3_SetName(p, a) (p)->lpVtbl->SetName(p, a)
#define IDirect3DRMTexture3_GetName(p, a, b) (p)->lpVtbl->GetName(p, a, b)
#define IDirect3DRMTexture3_GetClassName(p, a, b) (p)->lpVtbl->GetClassName(p, a, b)
#define IDirect3DRMTexture3_InitFromFile(p, a) (p)->lpVtbl->InitFromFile(p, a)
#define IDirect3DRMTexture3_InitFromSurface(p, a) (p)->lpVtbl->InitFromSurface(p, a)
#define IDirect3DRMTexture3_InitFromResource(p, a) (p)->lpVtbl->InitFromResource(p, a)
#define IDirect3DRMTexture3_Changed(p, a, b, c) (p)->lpVtbl->Changed(p, a, b, c)
#define IDirect3DRMTexture3_SetColors(p, a) (p)->lpVtbl->SetColors(p, a)
#define IDirect3DRMTexture3_SetShades(p, a) (p)->lpVtbl->SetShades(p, a)
#define IDirect3DRMTexture3_SetDecalSize(p, a, b) (p)->lpVtbl->SetDecalSize(p, a, b)
#define IDirect3DRMTexture3_SetDecalOrigin(p, a, b) (p)->lpVtbl->SetDecalOrigin(p, a, b)
#define IDirect3DRMTexture3_SetDecalScale(p, a) (p)->lpVtbl->SetDecalScale(p, a)
#define IDirect3DRMTexture3_SetDecalTransparency(p, a) (p)->lpVtbl->SetDecalTransparency(p, a)
#define IDirect3DRMTexture3_SetDecalTransparencyColor(p, a) (p)->lpVtbl->SetDecalTransparentColor(p, a)
#define IDirect3DRMTexture3_GetDecalSize(p, a, b) (p)->lpVtbl->GetDecalSize(p, a, b)
#define IDirect3DRMTexture3_GetDecalOrigin(p, a, b) (p)->lpVtbl->GetDecalOrigin(p, a, b)
#define IDirect3DRMTexture3_GetImage(p) (p)->lpVtbl->GetImage(p)
#define IDirect3DRMTexture3_GetShades(p) (p)->lpVtbl->GetShades(p)
#define IDirect3DRMTexture3_GetColors(p) (p)->lpVtbl->GetColors(p)
#define IDirect3DRMTexture3_GetDecalScale(p) (p)->lpVtbl->GetDecalScale(p)
#define IDirect3DRMTexture3_GetDecalTransparency(p) (p)->lpVtbl->GetDecalTransparency(p)
#define IDirect3DRMTexture3_GetDecalTransparencyColor(p) (p)->lpVtbl->GetDecalTransparencyColor(p)
#define IDirect3DRMTexture3_InitFromImage(p, a) (p)->lpVtbl->InitFromImage(p, a)
#define IDirect3DRMTexture3_InitFromResource2(p, a, b, c) (p)->lpVtbl->InitFromResource2(p, a, b, c)
#define IDirect3DRMTexture3_GenerateMIPMap(p, a) (p)->lpVtbl->GenerateMIPMap(p, a)
#define IDirect3DRMTexture3_GetSurface(p, a, b) (p)->lpVtbl->GetSurface(p, a, b)
#define IDirect3DRMTexture3_SetCacheOptions(p, a, b) (p)->lpVtbl->SetCacheOptions(p, a, b)
#define IDirect3DRMTexture3_GetCacheOptions(p, a, b) (p)->lpVtbl->GetCacheOptions(p, a, b)
#define IDirect3DRMTexture3_SetDownsampleCallback(p, a, b) (p)->lpVtbl->SetDownsampleCallback(p, a, b)
#define IDirect3DRMTexture3_SetValidationCallback(p, a, b) (p)->lpVtbl->SetValidationCallback(p, a, b)
type IDirect3DRMWrapVtbl as IDirect3DRMWrapVtbl_

type IDirect3DRMWrap
	lpVtbl as IDirect3DRMWrapVtbl ptr
end type

type IDirect3DRMWrapVtbl_
	QueryInterface as function(byval This as IDirect3DRMWrap ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMWrap ptr) as ULONG
	Release as function(byval This as IDirect3DRMWrap ptr) as ULONG
	Clone as function(byval This as IDirect3DRMWrap ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddDestroyCallback as function(byval This as IDirect3DRMWrap ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	DeleteDestroyCallback as function(byval This as IDirect3DRMWrap ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	SetAppData as function(byval This as IDirect3DRMWrap ptr, byval data as DWORD) as HRESULT
	GetAppData as function(byval This as IDirect3DRMWrap ptr) as DWORD
	SetName as function(byval This as IDirect3DRMWrap ptr, byval name as const zstring ptr) as HRESULT
	GetName as function(byval This as IDirect3DRMWrap ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	GetClassName as function(byval This as IDirect3DRMWrap ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	Init as function(byval This as IDirect3DRMWrap ptr, byval type as D3DRMWRAPTYPE, byval reference as IDirect3DRMFrame ptr, byval ox as D3DVALUE, byval oy as D3DVALUE, byval oz as D3DVALUE, byval dx as D3DVALUE, byval dy as D3DVALUE, byval dz as D3DVALUE, byval ux as D3DVALUE, byval uy as D3DVALUE, byval uz as D3DVALUE, byval ou as D3DVALUE, byval ov as D3DVALUE, byval su as D3DVALUE, byval sv as D3DVALUE) as HRESULT
	Apply as function(byval This as IDirect3DRMWrap ptr, byval object as IDirect3DRMObject ptr) as HRESULT
	ApplyRelative as function(byval This as IDirect3DRMWrap ptr, byval frame as IDirect3DRMFrame ptr, byval object as IDirect3DRMObject ptr) as HRESULT
end type

#define IDirect3DRMWrap_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMWrap_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMWrap_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMWrap_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirect3DRMWrap_AddDestroyCallback(p, a, b) (p)->lpVtbl->AddDestroyCallback(p, a, b)
#define IDirect3DRMWrap_DeleteDestroyCallback(p, a, b) (p)->lpVtbl->DeleteDestroyCallback(p, a, b)
#define IDirect3DRMWrap_SetAppData(p, a) (p)->lpVtbl->SetAppData(p, a)
#define IDirect3DRMWrap_GetAppData(p) (p)->lpVtbl->GetAppData(p)
#define IDirect3DRMWrap_SetName(p, a) (p)->lpVtbl->SetName(p, a)
#define IDirect3DRMWrap_GetName(p, a, b) (p)->lpVtbl->GetName(p, a, b)
#define IDirect3DRMWrap_GetClassName(p, a, b) (p)->lpVtbl->GetClassName(p, a, b)
#define IDirect3DRMWrap_Init(p, a, b, c, d, e, f, g, h, i, j, k, l, m, n, o) (p)->lpVtbl->Init(p, a, b, c, d, e, f, g, h, i, j, k, l, m, n, o)
#define IDirect3DRMWrap_Apply(p, a) (p)->lpVtbl->Apply(p, a)
#define IDirect3DRMWrap_ApplyRelative(p, a, b) (p)->lpVtbl->ApplyRelative(p, a, b)
type IDirect3DRMMaterialVtbl as IDirect3DRMMaterialVtbl_

type IDirect3DRMMaterial_
	lpVtbl as IDirect3DRMMaterialVtbl ptr
end type

type IDirect3DRMMaterialVtbl_
	QueryInterface as function(byval This as IDirect3DRMMaterial ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMMaterial ptr) as ULONG
	Release as function(byval This as IDirect3DRMMaterial ptr) as ULONG
	Clone as function(byval This as IDirect3DRMMaterial ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddDestroyCallback as function(byval This as IDirect3DRMMaterial ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	DeleteDestroyCallback as function(byval This as IDirect3DRMMaterial ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	SetAppData as function(byval This as IDirect3DRMMaterial ptr, byval data as DWORD) as HRESULT
	GetAppData as function(byval This as IDirect3DRMMaterial ptr) as DWORD
	SetName as function(byval This as IDirect3DRMMaterial ptr, byval name as const zstring ptr) as HRESULT
	GetName as function(byval This as IDirect3DRMMaterial ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	GetClassName as function(byval This as IDirect3DRMMaterial ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	SetPower as function(byval This as IDirect3DRMMaterial ptr, byval power as D3DVALUE) as HRESULT
	SetSpecular as function(byval This as IDirect3DRMMaterial ptr, byval r as D3DVALUE, byval g as D3DVALUE, byval b as D3DVALUE) as HRESULT
	SetEmissive as function(byval This as IDirect3DRMMaterial ptr, byval r as D3DVALUE, byval g as D3DVALUE, byval b as D3DVALUE) as HRESULT
	GetPower as function(byval This as IDirect3DRMMaterial ptr) as D3DVALUE
	GetSpecular as function(byval This as IDirect3DRMMaterial ptr, byval r as D3DVALUE ptr, byval g as D3DVALUE ptr, byval b as D3DVALUE ptr) as HRESULT
	GetEmissive as function(byval This as IDirect3DRMMaterial ptr, byval r as D3DVALUE ptr, byval g as D3DVALUE ptr, byval b as D3DVALUE ptr) as HRESULT
end type

#define IDirect3DRMMaterial_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMMaterial_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMMaterial_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMMaterial_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirect3DRMMaterial_AddDestroyCallback(p, a, b) (p)->lpVtbl->AddDestroyCallback(p, a, b)
#define IDirect3DRMMaterial_DeleteDestroyCallback(p, a, b) (p)->lpVtbl->DeleteDestroyCallback(p, a, b)
#define IDirect3DRMMaterial_SetAppData(p, a) (p)->lpVtbl->SetAppData(p, a)
#define IDirect3DRMMaterial_GetAppData(p) (p)->lpVtbl->GetAppData(p)
#define IDirect3DRMMaterial_SetName(p, a) (p)->lpVtbl->SetName(p, a)
#define IDirect3DRMMaterial_GetName(p, a, b) (p)->lpVtbl->GetName(p, a, b)
#define IDirect3DRMMaterial_GetClassName(p, a, b) (p)->lpVtbl->GetClassName(p, a, b)
#define IDirect3DRMMaterial_SetPower(p, a) (p)->lpVtbl->SetPower(p, a)
#define IDirect3DRMMaterial_SetSpecular(p, a, b, c) (p)->lpVtbl->SetSpecular(p, a, b, c)
#define IDirect3DRMMaterial_SetEmissive(p, a, b, c) (p)->lpVtbl->SetEmissive(p, a, b, c)
#define IDirect3DRMMaterial_GetPower(p) (p)->lpVtbl->GetPower(p)
#define IDirect3DRMMaterial_GetSpecular(p, a, b, c) (p)->lpVtbl->GetSpecular(p, a, b, c)
#define IDirect3DRMMaterial_GetEmissive(p, a, b, c) (p)->lpVtbl->GetEmissive(p, a, b, c)
type IDirect3DRMMaterial2Vtbl as IDirect3DRMMaterial2Vtbl_

type IDirect3DRMMaterial2_
	lpVtbl as IDirect3DRMMaterial2Vtbl ptr
end type

type IDirect3DRMMaterial2Vtbl_
	QueryInterface as function(byval This as IDirect3DRMMaterial2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMMaterial2 ptr) as ULONG
	Release as function(byval This as IDirect3DRMMaterial2 ptr) as ULONG
	Clone as function(byval This as IDirect3DRMMaterial2 ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddDestroyCallback as function(byval This as IDirect3DRMMaterial2 ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	DeleteDestroyCallback as function(byval This as IDirect3DRMMaterial2 ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	SetAppData as function(byval This as IDirect3DRMMaterial2 ptr, byval data as DWORD) as HRESULT
	GetAppData as function(byval This as IDirect3DRMMaterial2 ptr) as DWORD
	SetName as function(byval This as IDirect3DRMMaterial2 ptr, byval name as const zstring ptr) as HRESULT
	GetName as function(byval This as IDirect3DRMMaterial2 ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	GetClassName as function(byval This as IDirect3DRMMaterial2 ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	SetPower as function(byval This as IDirect3DRMMaterial2 ptr, byval power as D3DVALUE) as HRESULT
	SetSpecular as function(byval This as IDirect3DRMMaterial2 ptr, byval r as D3DVALUE, byval g as D3DVALUE, byval b as D3DVALUE) as HRESULT
	SetEmissive as function(byval This as IDirect3DRMMaterial2 ptr, byval r as D3DVALUE, byval g as D3DVALUE, byval b as D3DVALUE) as HRESULT
	GetPower as function(byval This as IDirect3DRMMaterial2 ptr) as D3DVALUE
	GetSpecular as function(byval This as IDirect3DRMMaterial2 ptr, byval r as D3DVALUE ptr, byval g as D3DVALUE ptr, byval b as D3DVALUE ptr) as HRESULT
	GetEmissive as function(byval This as IDirect3DRMMaterial2 ptr, byval r as D3DVALUE ptr, byval g as D3DVALUE ptr, byval b as D3DVALUE ptr) as HRESULT
	GetAmbient as function(byval This as IDirect3DRMMaterial2 ptr, byval r as D3DVALUE ptr, byval g as D3DVALUE ptr, byval b as D3DVALUE ptr) as HRESULT
	SetAmbient as function(byval This as IDirect3DRMMaterial2 ptr, byval r as D3DVALUE, byval g as D3DVALUE, byval b as D3DVALUE) as HRESULT
end type

#define IDirect3DRMMaterial2_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMMaterial2_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMMaterial2_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMMaterial2_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirect3DRMMaterial2_AddDestroyCallback(p, a, b) (p)->lpVtbl->AddDestroyCallback(p, a, b)
#define IDirect3DRMMaterial2_DeleteDestroyCallback(p, a, b) (p)->lpVtbl->DeleteDestroyCallback(p, a, b)
#define IDirect3DRMMaterial2_SetAppData(p, a) (p)->lpVtbl->SetAppData(p, a)
#define IDirect3DRMMaterial2_GetAppData(p) (p)->lpVtbl->GetAppData(p)
#define IDirect3DRMMaterial2_SetName(p, a) (p)->lpVtbl->SetName(p, a)
#define IDirect3DRMMaterial2_GetName(p, a, b) (p)->lpVtbl->GetName(p, a, b)
#define IDirect3DRMMaterial2_GetClassName(p, a, b) (p)->lpVtbl->GetClassName(p, a, b)
#define IDirect3DRMMaterial2_SetPower(p, a) (p)->lpVtbl->SetPower(p, a)
#define IDirect3DRMMaterial2_SetSpecular(p, a, b, c) (p)->lpVtbl->SetSpecular(p, a, b, c)
#define IDirect3DRMMaterial2_SetEmissive(p, a, b, c) (p)->lpVtbl->SetEmissive(p, a, b, c)
#define IDirect3DRMMaterial2_GetPower(p) (p)->lpVtbl->GetPower(p)
#define IDirect3DRMMaterial2_GetSpecular(p, a, b, c) (p)->lpVtbl->GetSpecular(p, a, b, c)
#define IDirect3DRMMaterial2_GetEmissive(p, a, b, c) (p)->lpVtbl->GetEmissive(p, a, b, c)
#define IDirect3DRMMaterial2_SetAmbient(p, a, b, c) (p)->lpVtbl->SetAmbient(p, a, b, c)
#define IDirect3DRMMaterial2_GetAmbient(p, a, b, c) (p)->lpVtbl->GetAmbient(p, a, b, c)
type IDirect3DRMAnimationVtbl as IDirect3DRMAnimationVtbl_

type IDirect3DRMAnimation
	lpVtbl as IDirect3DRMAnimationVtbl ptr
end type

type IDirect3DRMAnimationVtbl_
	QueryInterface as function(byval This as IDirect3DRMAnimation ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMAnimation ptr) as ULONG
	Release as function(byval This as IDirect3DRMAnimation ptr) as ULONG
	Clone as function(byval This as IDirect3DRMAnimation ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddDestroyCallback as function(byval This as IDirect3DRMAnimation ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	DeleteDestroyCallback as function(byval This as IDirect3DRMAnimation ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	SetAppData as function(byval This as IDirect3DRMAnimation ptr, byval data as DWORD) as HRESULT
	GetAppData as function(byval This as IDirect3DRMAnimation ptr) as DWORD
	SetName as function(byval This as IDirect3DRMAnimation ptr, byval name as const zstring ptr) as HRESULT
	GetName as function(byval This as IDirect3DRMAnimation ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	GetClassName as function(byval This as IDirect3DRMAnimation ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	SetOptions as function(byval This as IDirect3DRMAnimation ptr, byval flags as D3DRMANIMATIONOPTIONS) as HRESULT
	AddRotateKey as function(byval This as IDirect3DRMAnimation ptr, byval time as D3DVALUE, byval q as D3DRMQUATERNION ptr) as HRESULT
	AddPositionKey as function(byval This as IDirect3DRMAnimation ptr, byval time as D3DVALUE, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE) as HRESULT
	AddScaleKey as function(byval This as IDirect3DRMAnimation ptr, byval time as D3DVALUE, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE) as HRESULT
	DeleteKey as function(byval This as IDirect3DRMAnimation ptr, byval time as D3DVALUE) as HRESULT
	SetFrame as function(byval This as IDirect3DRMAnimation ptr, byval frame as IDirect3DRMFrame ptr) as HRESULT
	SetTime as function(byval This as IDirect3DRMAnimation ptr, byval time as D3DVALUE) as HRESULT
	GetOptions as function(byval This as IDirect3DRMAnimation ptr) as D3DRMANIMATIONOPTIONS
end type

#define IDirect3DRMAnimation_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMAnimation_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMAnimation_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMAnimation_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirect3DRMAnimation_AddDestroyCallback(p, a, b) (p)->lpVtbl->AddDestroyCallback(p, a, b)
#define IDirect3DRMAnimation_DeleteDestroyCallback(p, a, b) (p)->lpVtbl->DeleteDestroyCallback(p, a, b)
#define IDirect3DRMAnimation_SetAppData(p, a) (p)->lpVtbl->SetAppData(p, a)
#define IDirect3DRMAnimation_GetAppData(p) (p)->lpVtbl->GetAppData(p)
#define IDirect3DRMAnimation_SetName(p, a) (p)->lpVtbl->SetName(p, a)
#define IDirect3DRMAnimation_GetName(p, a, b) (p)->lpVtbl->GetName(p, a, b)
#define IDirect3DRMAnimation_GetClassName(p, a, b) (p)->lpVtbl->GetClassName(p, a, b)
#define IDirect3DRMAnimation_SetOptions(p, a) (p)->lpVtbl->SetOptions(p, a)
#define IDirect3DRMAnimation_AddRotateKey(p, a, b) (p)->lpVtbl->AddRotateKey(p, a, b)
#define IDirect3DRMAnimation_AddPositionKey(p, a, b, c, d) (p)->lpVtbl->AddPositionKey(p, a, b, c, d)
#define IDirect3DRMAnimation_AddScaleKey(p, a, b, c, d) (p)->lpVtbl->AddScaleKey(p, a, b, c, d)
#define IDirect3DRMAnimation_DeleteKey(p, a) (p)->lpVtbl->DeleteKey(p, a)
#define IDirect3DRMAnimation_SetFrame(p, a) (p)->lpVtbl->SetFrame(p, a)
#define IDirect3DRMAnimation_SetTime(p, a) (p)->lpVtbl->SetTime(p, a)
#define IDirect3DRMAnimation_GetOptions(p) (p)->lpVtbl->GetOptions(p)
type IDirect3DRMAnimation2Vtbl as IDirect3DRMAnimation2Vtbl_

type IDirect3DRMAnimation2
	lpVtbl as IDirect3DRMAnimation2Vtbl ptr
end type

type IDirect3DRMAnimation2Vtbl_
	QueryInterface as function(byval This as IDirect3DRMAnimation2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMAnimation2 ptr) as ULONG
	Release as function(byval This as IDirect3DRMAnimation2 ptr) as ULONG
	Clone as function(byval This as IDirect3DRMAnimation2 ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddDestroyCallback as function(byval This as IDirect3DRMAnimation2 ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	DeleteDestroyCallback as function(byval This as IDirect3DRMAnimation2 ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	SetAppData as function(byval This as IDirect3DRMAnimation2 ptr, byval data as DWORD) as HRESULT
	GetAppData as function(byval This as IDirect3DRMAnimation2 ptr) as DWORD
	SetName as function(byval This as IDirect3DRMAnimation2 ptr, byval name as const zstring ptr) as HRESULT
	GetName as function(byval This as IDirect3DRMAnimation2 ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	GetClassName as function(byval This as IDirect3DRMAnimation2 ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	SetOptions as function(byval This as IDirect3DRMAnimation2 ptr, byval flags as D3DRMANIMATIONOPTIONS) as HRESULT
	AddRotateKey as function(byval This as IDirect3DRMAnimation2 ptr, byval time as D3DVALUE, byval q as D3DRMQUATERNION ptr) as HRESULT
	AddPositionKey as function(byval This as IDirect3DRMAnimation2 ptr, byval time as D3DVALUE, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE) as HRESULT
	AddScaleKey as function(byval This as IDirect3DRMAnimation2 ptr, byval time as D3DVALUE, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE) as HRESULT
	DeleteKey as function(byval This as IDirect3DRMAnimation2 ptr, byval time as D3DVALUE) as HRESULT
	SetFrame as function(byval This as IDirect3DRMAnimation2 ptr, byval frame as IDirect3DRMFrame3 ptr) as HRESULT
	SetTime as function(byval This as IDirect3DRMAnimation2 ptr, byval time as D3DVALUE) as HRESULT
	GetOptions as function(byval This as IDirect3DRMAnimation2 ptr) as D3DRMANIMATIONOPTIONS
	GetFrame as function(byval This as IDirect3DRMAnimation2 ptr, byval frame as IDirect3DRMFrame3 ptr ptr) as HRESULT
	DeleteKeyByID as function(byval This as IDirect3DRMAnimation2 ptr, byval dwID as DWORD) as HRESULT
	AddKey as function(byval This as IDirect3DRMAnimation2 ptr, byval key as D3DRMANIMATIONKEY ptr) as HRESULT
	ModifyKey as function(byval This as IDirect3DRMAnimation2 ptr, byval key as D3DRMANIMATIONKEY ptr) as HRESULT
	GetKeys as function(byval This as IDirect3DRMAnimation2 ptr, byval time_min as D3DVALUE, byval time_max as D3DVALUE, byval key_count as DWORD ptr, byval keys as D3DRMANIMATIONKEY ptr) as HRESULT
end type

#define IDirect3DRMAnimation2_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMAnimation2_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMAnimation2_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMAnimation2_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirect3DRMAnimation2_AddDestroyCallback(p, a, b) (p)->lpVtbl->AddDestroyCallback(p, a, b)
#define IDirect3DRMAnimation2_DeleteDestroyCallback(p, a, b) (p)->lpVtbl->DeleteDestroyCallback(p, a, b)
#define IDirect3DRMAnimation2_SetAppData(p, a) (p)->lpVtbl->SetAppData(p, a)
#define IDirect3DRMAnimation2_GetAppData(p) (p)->lpVtbl->GetAppData(p)
#define IDirect3DRMAnimation2_SetName(p, a) (p)->lpVtbl->SetName(p, a)
#define IDirect3DRMAnimation2_GetName(p, a, b) (p)->lpVtbl->GetName(p, a, b)
#define IDirect3DRMAnimation2_GetClassName(p, a, b) (p)->lpVtbl->GetClassName(p, a, b)
#define IDirect3DRMAnimation2_SetOptions(p, a) (p)->lpVtbl->SetOptions(p, a)
#define IDirect3DRMAnimation2_AddRotateKey(p, a, b) (p)->lpVtbl->AddRotateKey(p, a, b)
#define IDirect3DRMAnimation2_AddPositionKey(p, a, b, c, d) (p)->lpVtbl->AddPositionKey(p, a, b, c, d)
#define IDirect3DRMAnimation2_AddScaleKey(p, a, b, c, d) (p)->lpVtbl->AddScaleKey(p, a, b, c, d)
#define IDirect3DRMAnimation2_DeleteKey(p, a) (p)->lpVtbl->DeleteKey(p, a)
#define IDirect3DRMAnimation2_SetFrame(p, a) (p)->lpVtbl->SetFrame(p, a)
#define IDirect3DRMAnimation2_SetTime(p, a) (p)->lpVtbl->SetTime(p, a)
#define IDirect3DRMAnimation2_GetOptions(p) (p)->lpVtbl->GetOptions(p)
#define IDirect3DRMAnimation2_GetFrame(p, a) (p)->lpVtbl->GetFrame(p, a)
#define IDirect3DRMAnimation2_DeleteKeyByID(p, a) (p)->lpVtbl->DeleteKeyByID(p, a)
#define IDirect3DRMAnimation2_AddKey(p, a) (p)->lpVtbl->AddKey(p, a)
#define IDirect3DRMAnimation2_ModifyKey(p, a) (p)->lpVtbl->ModifyKey(p, a)
#define IDirect3DRMAnimation2_GetKeys(p, a, b, c, d) (p)->lpVtbl->GetKeys(p, a, b, c, d)
type IDirect3DRMAnimationSetVtbl as IDirect3DRMAnimationSetVtbl_

type IDirect3DRMAnimationSet
	lpVtbl as IDirect3DRMAnimationSetVtbl ptr
end type

type IDirect3DRMAnimationSetVtbl_
	QueryInterface as function(byval This as IDirect3DRMAnimationSet ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMAnimationSet ptr) as ULONG
	Release as function(byval This as IDirect3DRMAnimationSet ptr) as ULONG
	Clone as function(byval This as IDirect3DRMAnimationSet ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddDestroyCallback as function(byval This as IDirect3DRMAnimationSet ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	DeleteDestroyCallback as function(byval This as IDirect3DRMAnimationSet ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	SetAppData as function(byval This as IDirect3DRMAnimationSet ptr, byval data as DWORD) as HRESULT
	GetAppData as function(byval This as IDirect3DRMAnimationSet ptr) as DWORD
	SetName as function(byval This as IDirect3DRMAnimationSet ptr, byval name as const zstring ptr) as HRESULT
	GetName as function(byval This as IDirect3DRMAnimationSet ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	GetClassName as function(byval This as IDirect3DRMAnimationSet ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	AddAnimation as function(byval This as IDirect3DRMAnimationSet ptr, byval animation as IDirect3DRMAnimation ptr) as HRESULT
	Load as function(byval This as IDirect3DRMAnimationSet ptr, byval filename as any ptr, byval name as any ptr, byval flags as D3DRMLOADOPTIONS, byval cb as D3DRMLOADTEXTURECALLBACK, byval ctx as any ptr, byval parent as IDirect3DRMFrame ptr) as HRESULT
	DeleteAnimation as function(byval This as IDirect3DRMAnimationSet ptr, byval animation as IDirect3DRMAnimation ptr) as HRESULT
	SetTime as function(byval This as IDirect3DRMAnimationSet ptr, byval time as D3DVALUE) as HRESULT
end type

#define IDirect3DRMAnimationSet_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMAnimationSet_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMAnimationSet_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMAnimationSet_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirect3DRMAnimationSet_AddDestroyCallback(p, a, b) (p)->lpVtbl->AddDestroyCallback(p, a, b)
#define IDirect3DRMAnimationSet_DeleteDestroyCallback(p, a, b) (p)->lpVtbl->DeleteDestroyCallback(p, a, b)
#define IDirect3DRMAnimationSet_SetAppData(p, a) (p)->lpVtbl->SetAppData(p, a)
#define IDirect3DRMAnimationSet_GetAppData(p) (p)->lpVtbl->GetAppData(p)
#define IDirect3DRMAnimationSet_SetName(p, a) (p)->lpVtbl->SetName(p, a)
#define IDirect3DRMAnimationSet_GetName(p, a, b) (p)->lpVtbl->GetName(p, a, b)
#define IDirect3DRMAnimationSet_GetClassName(p, a, b) (p)->lpVtbl->GetClassName(p, a, b)
#define IDirect3DRMAnimationSet_AddAnimation(p, a) (p)->lpVtbl->AddAnimation(p, a)
#define IDirect3DRMAnimationSet_Load(p, a, b, c, d, e, f) (p)->lpVtbl->Load(p, a, b, c, d, e, f)
#define IDirect3DRMAnimationSet_DeleteAnimation(p, a) (p)->lpVtbl->DeleteAnimation(p, a)
#define IDirect3DRMAnimationSet_SetTime(p, a) (p)->lpVtbl->SetTime(p, a)
type IDirect3DRMAnimationSet2Vtbl as IDirect3DRMAnimationSet2Vtbl_

type IDirect3DRMAnimationSet2
	lpVtbl as IDirect3DRMAnimationSet2Vtbl ptr
end type

type IDirect3DRMAnimationSet2Vtbl_
	QueryInterface as function(byval This as IDirect3DRMAnimationSet2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMAnimationSet2 ptr) as ULONG
	Release as function(byval This as IDirect3DRMAnimationSet2 ptr) as ULONG
	Clone as function(byval This as IDirect3DRMAnimationSet2 ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddDestroyCallback as function(byval This as IDirect3DRMAnimationSet2 ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	DeleteDestroyCallback as function(byval This as IDirect3DRMAnimationSet2 ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	SetAppData as function(byval This as IDirect3DRMAnimationSet2 ptr, byval data as DWORD) as HRESULT
	GetAppData as function(byval This as IDirect3DRMAnimationSet2 ptr) as DWORD
	SetName as function(byval This as IDirect3DRMAnimationSet2 ptr, byval name as const zstring ptr) as HRESULT
	GetName as function(byval This as IDirect3DRMAnimationSet2 ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	GetClassName as function(byval This as IDirect3DRMAnimationSet2 ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	AddAnimation as function(byval This as IDirect3DRMAnimationSet2 ptr, byval animation as IDirect3DRMAnimation2 ptr) as HRESULT
	Load as function(byval This as IDirect3DRMAnimationSet2 ptr, byval source as any ptr, byval object_id as any ptr, byval flags as D3DRMLOADOPTIONS, byval cb as D3DRMLOADTEXTURE3CALLBACK, byval ctx as any ptr, byval parent_frame as IDirect3DRMFrame3 ptr) as HRESULT
	DeleteAnimation as function(byval This as IDirect3DRMAnimationSet2 ptr, byval animation as IDirect3DRMAnimation2 ptr) as HRESULT
	SetTime as function(byval This as IDirect3DRMAnimationSet2 ptr, byval time as D3DVALUE) as HRESULT
	GetAnimations as function(byval This as IDirect3DRMAnimationSet2 ptr, byval array as IDirect3DRMAnimationArray ptr ptr) as HRESULT
end type

#define IDirect3DRMAnimationSet2_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMAnimationSet2_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMAnimationSet2_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMAnimationSet2_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirect3DRMAnimationSet2_AddDestroyCallback(p, a, b) (p)->lpVtbl->AddDestroyCallback(p, a, b)
#define IDirect3DRMAnimationSet2_DeleteDestroyCallback(p, a, b) (p)->lpVtbl->DeleteDestroyCallback(p, a, b)
#define IDirect3DRMAnimationSet2_SetAppData(p, a) (p)->lpVtbl->SetAppData(p, a)
#define IDirect3DRMAnimationSet2_GetAppData(p) (p)->lpVtbl->GetAppData(p)
#define IDirect3DRMAnimationSet2_SetName(p, a) (p)->lpVtbl->SetName(p, a)
#define IDirect3DRMAnimationSet2_GetName(p, a, b) (p)->lpVtbl->GetName(p, a, b)
#define IDirect3DRMAnimationSet2_GetClassName(p, a, b) (p)->lpVtbl->GetClassName(p, a, b)
#define IDirect3DRMAnimationSet2_AddAnimation(p, a) (p)->lpVtbl->AddAnimation(p, a)
#define IDirect3DRMAnimationSet2_Load(p, a, b, c, d, e, f) (p)->lpVtbl->Load(p, a, b, c, d, e, f)
#define IDirect3DRMAnimationSet2_DeleteAnimation(p, a) (p)->lpVtbl->DeleteAnimation(p, a)
#define IDirect3DRMAnimationSet2_SetTime(p, a) (p)->lpVtbl->SetTime(p, a)
#define IDirect3DRMAnimationSet2_GetAnimations(p, a) (p)->lpVtbl->GetAnimations(p, a)
type IDirect3DRMUserVisualVtbl as IDirect3DRMUserVisualVtbl_

type IDirect3DRMUserVisual_
	lpVtbl as IDirect3DRMUserVisualVtbl ptr
end type

type IDirect3DRMUserVisualVtbl_
	QueryInterface as function(byval This as IDirect3DRMUserVisual ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMUserVisual ptr) as ULONG
	Release as function(byval This as IDirect3DRMUserVisual ptr) as ULONG
	Clone as function(byval This as IDirect3DRMUserVisual ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddDestroyCallback as function(byval This as IDirect3DRMUserVisual ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	DeleteDestroyCallback as function(byval This as IDirect3DRMUserVisual ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	SetAppData as function(byval This as IDirect3DRMUserVisual ptr, byval data as DWORD) as HRESULT
	GetAppData as function(byval This as IDirect3DRMUserVisual ptr) as DWORD
	SetName as function(byval This as IDirect3DRMUserVisual ptr, byval name as const zstring ptr) as HRESULT
	GetName as function(byval This as IDirect3DRMUserVisual ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	GetClassName as function(byval This as IDirect3DRMUserVisual ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	Init as function(byval This as IDirect3DRMUserVisual ptr, byval fn as D3DRMUSERVISUALCALLBACK, byval arg as any ptr) as HRESULT
end type

#define IDirect3DRMUserVisual_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMUserVisual_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMUserVisual_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMUserVisual_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirect3DRMUserVisual_AddDestroyCallback(p, a, b) (p)->lpVtbl->AddDestroyCallback(p, a, b)
#define IDirect3DRMUserVisual_DeleteDestroyCallback(p, a, b) (p)->lpVtbl->DeleteDestroyCallback(p, a, b)
#define IDirect3DRMUserVisual_SetAppData(p, a) (p)->lpVtbl->SetAppData(p, a)
#define IDirect3DRMUserVisual_GetAppData(p) (p)->lpVtbl->GetAppData(p)
#define IDirect3DRMUserVisual_SetName(p, a) (p)->lpVtbl->SetName(p, a)
#define IDirect3DRMUserVisual_GetName(p, a, b) (p)->lpVtbl->GetName(p, a, b)
#define IDirect3DRMUserVisual_GetClassName(p, a, b) (p)->lpVtbl->GetClassName(p, a, b)
#define IDirect3DRMUserVisual_Init(p, a, b) (p)->lpVtbl->Init(p, a, b)
type IDirect3DRMArrayVtbl as IDirect3DRMArrayVtbl_

type IDirect3DRMArray
	lpVtbl as IDirect3DRMArrayVtbl ptr
end type

type IDirect3DRMArrayVtbl_
	QueryInterface as function(byval This as IDirect3DRMArray ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMArray ptr) as ULONG
	Release as function(byval This as IDirect3DRMArray ptr) as ULONG
	GetSize as function(byval This as IDirect3DRMArray ptr) as DWORD
end type

#define IDirect3DRMArray_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMArray_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMArray_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMArray_GetSize(p) (p)->lpVtbl->GetSize(p)
type IDirect3DRMObjectArrayVtbl as IDirect3DRMObjectArrayVtbl_

type IDirect3DRMObjectArray
	lpVtbl as IDirect3DRMObjectArrayVtbl ptr
end type

type IDirect3DRMObjectArrayVtbl_
	QueryInterface as function(byval This as IDirect3DRMObjectArray ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMObjectArray ptr) as ULONG
	Release as function(byval This as IDirect3DRMObjectArray ptr) as ULONG
	GetSize as function(byval This as IDirect3DRMObjectArray ptr) as DWORD
	GetElement as function(byval This as IDirect3DRMObjectArray ptr, byval index as DWORD, byval element as IDirect3DRMObject ptr ptr) as HRESULT
end type

#define IDirect3DRMObjectArray_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMObjectArray_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMObjectArray_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMObjectArray_GetSize(p) (p)->lpVtbl->GetSize(p)
#define IDirect3DRMObjectArray_GetElement(p, a, b) (p)->lpVtbl->GetElement(p, a, b)
type IDirect3DRMDeviceArrayVtbl as IDirect3DRMDeviceArrayVtbl_

type IDirect3DRMDeviceArray
	lpVtbl as IDirect3DRMDeviceArrayVtbl ptr
end type

type IDirect3DRMDeviceArrayVtbl_
	QueryInterface as function(byval This as IDirect3DRMDeviceArray ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMDeviceArray ptr) as ULONG
	Release as function(byval This as IDirect3DRMDeviceArray ptr) as ULONG
	GetSize as function(byval This as IDirect3DRMDeviceArray ptr) as DWORD
	GetElement as function(byval This as IDirect3DRMDeviceArray ptr, byval index as DWORD, byval element as IDirect3DRMDevice ptr ptr) as HRESULT
end type

#define IDirect3DRMDeviceArray_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMDeviceArray_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMDeviceArray_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMDeviceArray_GetSize(p) (p)->lpVtbl->GetSize(p)
#define IDirect3DRMDeviceArray_GetElement(p, a, b) (p)->lpVtbl->GetElement(p, a, b)
type IDirect3DRMFrameArrayVtbl as IDirect3DRMFrameArrayVtbl_

type IDirect3DRMFrameArray_
	lpVtbl as IDirect3DRMFrameArrayVtbl ptr
end type

type IDirect3DRMFrameArrayVtbl_
	QueryInterface as function(byval This as IDirect3DRMFrameArray ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMFrameArray ptr) as ULONG
	Release as function(byval This as IDirect3DRMFrameArray ptr) as ULONG
	GetSize as function(byval This as IDirect3DRMFrameArray ptr) as DWORD
	GetElement as function(byval This as IDirect3DRMFrameArray ptr, byval index as DWORD, byval element as IDirect3DRMFrame ptr ptr) as HRESULT
end type

#define IDirect3DRMFrameArray_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMFrameArray_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMFrameArray_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMFrameArray_GetSize(p) (p)->lpVtbl->GetSize(p)
#define IDirect3DRMFrameArray_GetElement(p, a, b) (p)->lpVtbl->GetElement(p, a, b)
type IDirect3DRMViewportArrayVtbl as IDirect3DRMViewportArrayVtbl_

type IDirect3DRMViewportArray_
	lpVtbl as IDirect3DRMViewportArrayVtbl ptr
end type

type IDirect3DRMViewportArrayVtbl_
	QueryInterface as function(byval This as IDirect3DRMViewportArray ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMViewportArray ptr) as ULONG
	Release as function(byval This as IDirect3DRMViewportArray ptr) as ULONG
	GetSize as function(byval This as IDirect3DRMViewportArray ptr) as DWORD
	GetElement as function(byval This as IDirect3DRMViewportArray ptr, byval index as DWORD, byval element as IDirect3DRMViewport ptr ptr) as HRESULT
end type

#define IDirect3DRMViewportArray_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMViewportArray_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMViewportArray_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMViewportArray_GetSize(p) (p)->lpVtbl->GetSize(p)
#define IDirect3DRMViewportArray_GetElement(p, a, b) (p)->lpVtbl->GetElement(p, a, b)
type IDirect3DRMVisualArrayVtbl as IDirect3DRMVisualArrayVtbl_

type IDirect3DRMVisualArray_
	lpVtbl as IDirect3DRMVisualArrayVtbl ptr
end type

type IDirect3DRMVisualArrayVtbl_
	QueryInterface as function(byval This as IDirect3DRMVisualArray ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMVisualArray ptr) as ULONG
	Release as function(byval This as IDirect3DRMVisualArray ptr) as ULONG
	GetSize as function(byval This as IDirect3DRMVisualArray ptr) as DWORD
	GetElement as function(byval This as IDirect3DRMVisualArray ptr, byval index as DWORD, byval element as IDirect3DRMVisual ptr ptr) as HRESULT
end type

#define IDirect3DRMVisualArray_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMVisualArray_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMVisualArray_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMVisualArray_GetSize(p) (p)->lpVtbl->GetSize(p)
#define IDirect3DRMVisualArray_GetElement(p, a, b) (p)->lpVtbl->GetElement(p, a, b)
type IDirect3DRMAnimationArrayVtbl as IDirect3DRMAnimationArrayVtbl_

type IDirect3DRMAnimationArray_
	lpVtbl as IDirect3DRMAnimationArrayVtbl ptr
end type

type IDirect3DRMAnimationArrayVtbl_
	QueryInterface as function(byval This as IDirect3DRMAnimationArray ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMAnimationArray ptr) as ULONG
	Release as function(byval This as IDirect3DRMAnimationArray ptr) as ULONG
	GetSize as function(byval This as IDirect3DRMAnimationArray ptr) as DWORD
	GetElement as function(byval This as IDirect3DRMAnimationArray ptr, byval index as DWORD, byval element as IDirect3DRMAnimation2 ptr ptr) as HRESULT
end type

#define IDirect3DRMAnimationArray_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMAnimationArray_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMAnimationArray_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMAnimationArray_GetSize(p) (p)->lpVtbl->GetSize(p)
#define IDirect3DRMAnimationArray_GetElement(p, a, b) (p)->lpVtbl->GetElement(p, a, b)
type IDirect3DRMPickedArrayVtbl as IDirect3DRMPickedArrayVtbl_

type IDirect3DRMPickedArray_
	lpVtbl as IDirect3DRMPickedArrayVtbl ptr
end type

type IDirect3DRMPickedArrayVtbl_
	QueryInterface as function(byval This as IDirect3DRMPickedArray ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMPickedArray ptr) as ULONG
	Release as function(byval This as IDirect3DRMPickedArray ptr) as ULONG
	GetSize as function(byval This as IDirect3DRMPickedArray ptr) as DWORD
	GetPick as function(byval This as IDirect3DRMPickedArray ptr, byval index as DWORD, byval visual as IDirect3DRMVisual ptr ptr, byval frame_array as IDirect3DRMFrameArray ptr ptr, byval pick_desc as D3DRMPICKDESC ptr) as HRESULT
end type

#define IDirect3DRMPickedArray_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMPickedArray_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMPickedArray_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMPickedArray_GetSize(p) (p)->lpVtbl->GetSize(p)
#define IDirect3DRMPickedArray_GetPick(p, a, b, c, d) (p)->lpVtbl->GetPick(p, a, b, c, d)
type IDirect3DRMLightArrayVtbl as IDirect3DRMLightArrayVtbl_

type IDirect3DRMLightArray_
	lpVtbl as IDirect3DRMLightArrayVtbl ptr
end type

type IDirect3DRMLightArrayVtbl_
	QueryInterface as function(byval This as IDirect3DRMLightArray ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMLightArray ptr) as ULONG
	Release as function(byval This as IDirect3DRMLightArray ptr) as ULONG
	GetSize as function(byval This as IDirect3DRMLightArray ptr) as DWORD
	GetElement as function(byval This as IDirect3DRMLightArray ptr, byval index as DWORD, byval element as IDirect3DRMLight ptr ptr) as HRESULT
end type

#define IDirect3DRMLightArray_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMLightArray_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMLightArray_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMLightArray_GetSize(p) (p)->lpVtbl->GetSize(p)
#define IDirect3DRMLightArray_GetElement(p, a, b) (p)->lpVtbl->GetElement(p, a, b)
type IDirect3DRMFaceArrayVtbl as IDirect3DRMFaceArrayVtbl_

type IDirect3DRMFaceArray_
	lpVtbl as IDirect3DRMFaceArrayVtbl ptr
end type

type IDirect3DRMFaceArrayVtbl_
	QueryInterface as function(byval This as IDirect3DRMFaceArray ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMFaceArray ptr) as ULONG
	Release as function(byval This as IDirect3DRMFaceArray ptr) as ULONG
	GetSize as function(byval This as IDirect3DRMFaceArray ptr) as DWORD
	GetElement as function(byval This as IDirect3DRMFaceArray ptr, byval index as DWORD, byval element as IDirect3DRMFace ptr ptr) as HRESULT
end type

#define IDirect3DRMFaceArray_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMFaceArray_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMFaceArray_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMFaceArray_GetSize(p) (p)->lpVtbl->GetSize(p)
#define IDirect3DRMFaceArray_GetElement(p, a, b) (p)->lpVtbl->GetElement(p, a, b)
type IDirect3DRMPicked2ArrayVtbl as IDirect3DRMPicked2ArrayVtbl_

type IDirect3DRMPicked2Array_
	lpVtbl as IDirect3DRMPicked2ArrayVtbl ptr
end type

type IDirect3DRMPicked2ArrayVtbl_
	QueryInterface as function(byval This as IDirect3DRMPicked2Array ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMPicked2Array ptr) as ULONG
	Release as function(byval This as IDirect3DRMPicked2Array ptr) as ULONG
	GetSize as function(byval This as IDirect3DRMPicked2Array ptr) as DWORD
	GetPick as function(byval This as IDirect3DRMPicked2Array ptr, byval index as DWORD, byval visual as IDirect3DRMVisual ptr ptr, byval frame_array as IDirect3DRMFrameArray ptr ptr, byval pick_desc as D3DRMPICKDESC2 ptr) as HRESULT
end type

#define IDirect3DRMPicked2Array_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMPicked2Array_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMPicked2Array_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMPicked2Array_GetSize(p) (p)->lpVtbl->GetSize(p)
#define IDirect3DRMPicked2Array_GetPick(p, a, b, c, d) (p)->lpVtbl->GetPick(p, a, b, c, d)
type IDirect3DRMInterpolatorVtbl as IDirect3DRMInterpolatorVtbl_

type IDirect3DRMInterpolator
	lpVtbl as IDirect3DRMInterpolatorVtbl ptr
end type

type IDirect3DRMInterpolatorVtbl_
	QueryInterface as function(byval This as IDirect3DRMInterpolator ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMInterpolator ptr) as ULONG
	Release as function(byval This as IDirect3DRMInterpolator ptr) as ULONG
	Clone as function(byval This as IDirect3DRMInterpolator ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddDestroyCallback as function(byval This as IDirect3DRMInterpolator ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	DeleteDestroyCallback as function(byval This as IDirect3DRMInterpolator ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	SetAppData as function(byval This as IDirect3DRMInterpolator ptr, byval data as DWORD) as HRESULT
	GetAppData as function(byval This as IDirect3DRMInterpolator ptr) as DWORD
	SetName as function(byval This as IDirect3DRMInterpolator ptr, byval name as const zstring ptr) as HRESULT
	GetName as function(byval This as IDirect3DRMInterpolator ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	GetClassName as function(byval This as IDirect3DRMInterpolator ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	AttachObject as function(byval This as IDirect3DRMInterpolator ptr, byval object as IDirect3DRMObject ptr) as HRESULT
	GetAttachedObjects as function(byval This as IDirect3DRMInterpolator ptr, byval array as IDirect3DRMObjectArray ptr ptr) as HRESULT
	DetachObject as function(byval This as IDirect3DRMInterpolator ptr, byval object as IDirect3DRMObject ptr) as HRESULT
	SetIndex as function(byval This as IDirect3DRMInterpolator ptr, byval as D3DVALUE) as HRESULT
	GetIndex as function(byval This as IDirect3DRMInterpolator ptr) as D3DVALUE
	Interpolate as function(byval This as IDirect3DRMInterpolator ptr, byval index as D3DVALUE, byval object as IDirect3DRMObject ptr, byval flags as D3DRMINTERPOLATIONOPTIONS) as HRESULT
end type

#define IDirect3DRMInterpolator_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMInterpolator_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMInterpolator_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMInterpolator_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirect3DRMInterpolator_AddDestroyCallback(p, a, b) (p)->lpVtbl->AddDestroyCallback(p, a, b)
#define IDirect3DRMInterpolator_DeleteDestroyCallback(p, a, b) (p)->lpVtbl->DeleteDestroyCallback(p, a, b)
#define IDirect3DRMInterpolator_SetAppData(p, a) (p)->lpVtbl->SetAppData(p, a)
#define IDirect3DRMInterpolator_GetAppData(p) (p)->lpVtbl->GetAppData(p)
#define IDirect3DRMInterpolator_SetName(p, a) (p)->lpVtbl->SetName(p, a)
#define IDirect3DRMInterpolator_GetName(p, a, b) (p)->lpVtbl->GetName(p, a, b)
#define IDirect3DRMInterpolator_GetClassName(p, a, b) (p)->lpVtbl->GetClassName(p, a, b)
#define IDirect3DRMInterpolator_AttachObject(p, a) (p)->lpVtbl->AttachObject(p, a)
#define IDirect3DRMInterpolator_GetAttachedObjects(p, a) (p)->lpVtbl->GetAttachedObjects(p, a)
#define IDirect3DRMInterpolator_DetachObject(p, a) (p)->lpVtbl->DetachObject(p, a)
#define IDirect3DRMInterpolator_SetIndex(p, a) (p)->lpVtbl->SetIndex(p, a)
#define IDirect3DRMInterpolator_GetIndex(p) (p)->lpVtbl->GetIndex(p)
#define IDirect3DRMInterpolator_Interpolate(p, a, b, c) (p)->lpVtbl->Interpolate(p, a, b, c)
type IDirect3DRMClippedVisualVtbl as IDirect3DRMClippedVisualVtbl_

type IDirect3DRMClippedVisual
	lpVtbl as IDirect3DRMClippedVisualVtbl ptr
end type

type IDirect3DRMClippedVisualVtbl_
	QueryInterface as function(byval This as IDirect3DRMClippedVisual ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRMClippedVisual ptr) as ULONG
	Release as function(byval This as IDirect3DRMClippedVisual ptr) as ULONG
	Clone as function(byval This as IDirect3DRMClippedVisual ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	AddDestroyCallback as function(byval This as IDirect3DRMClippedVisual ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	DeleteDestroyCallback as function(byval This as IDirect3DRMClippedVisual ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	SetAppData as function(byval This as IDirect3DRMClippedVisual ptr, byval data as DWORD) as HRESULT
	GetAppData as function(byval This as IDirect3DRMClippedVisual ptr) as DWORD
	SetName as function(byval This as IDirect3DRMClippedVisual ptr, byval name as const zstring ptr) as HRESULT
	GetName as function(byval This as IDirect3DRMClippedVisual ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	GetClassName as function(byval This as IDirect3DRMClippedVisual ptr, byval size as DWORD ptr, byval name as zstring ptr) as HRESULT
	Init as function(byval This as IDirect3DRMClippedVisual ptr, byval visual as IDirect3DRMVisual ptr) as HRESULT
	AddPlane as function(byval This as IDirect3DRMClippedVisual ptr, byval reference as IDirect3DRMFrame3 ptr, byval point as D3DVECTOR ptr, byval normal as D3DVECTOR ptr, byval flags as DWORD, byval id as DWORD ptr) as HRESULT
	DeletePlane as function(byval This as IDirect3DRMClippedVisual ptr, byval as DWORD, byval as DWORD) as HRESULT
	GetPlaneIDs as function(byval This as IDirect3DRMClippedVisual ptr, byval count as DWORD ptr, byval id as DWORD ptr, byval flags as DWORD) as HRESULT
	GetPlane as function(byval This as IDirect3DRMClippedVisual ptr, byval id as DWORD, byval reference as IDirect3DRMFrame3 ptr, byval point as D3DVECTOR ptr, byval normal as D3DVECTOR ptr, byval flags as DWORD) as HRESULT
	SetPlane as function(byval This as IDirect3DRMClippedVisual ptr, byval id as DWORD, byval reference as IDirect3DRMFrame3 ptr, byval point as D3DVECTOR ptr, byval normal as D3DVECTOR ptr, byval flags as DWORD) as HRESULT
end type

#define IDirect3DRMClippedVisual_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRMClippedVisual_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRMClippedVisual_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRMClippedVisual_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirect3DRMClippedVisual_AddDestroyCallback(p, a, b) (p)->lpVtbl->AddDestroyCallback(p, a, b)
#define IDirect3DRMClippedVisual_DeleteDestroyCallback(p, a, b) (p)->lpVtbl->DeleteDestroyCallback(p, a, b)
#define IDirect3DRMClippedVisual_SetAppData(p, a) (p)->lpVtbl->SetAppData(p, a)
#define IDirect3DRMClippedVisual_GetAppData(p) (p)->lpVtbl->GetAppData(p)
#define IDirect3DRMClippedVisual_SetName(p, a) (p)->lpVtbl->SetName(p, a)
#define IDirect3DRMClippedVisual_GetName(p, a, b) (p)->lpVtbl->GetName(p, a, b)
#define IDirect3DRMClippedVisual_GetClassName(p, a, b) (p)->lpVtbl->GetClassName(p, a, b)
#define IDirect3DRMClippedVisual_Init(p, a) (p)->lpVtbl->Init(p, a)
#define IDirect3DRMClippedVisual_AddPlane(p, a, b, c, d, e) (p)->lpVtbl->AddPlane(p, a, b, c, d, e)
#define IDirect3DRMClippedVisual_DeletePlane(p, a, b) (p)->lpVtbl->DeletePlane(p, a, b)
#define IDirect3DRMClippedVisual_GetPlaneIDs(p, a, b, c) (p)->lpVtbl->GetPlaneIDs(p, a, b, c)
#define IDirect3DRMClippedVisual_GetPlane(p, a, b, c, d, e) (p)->lpVtbl->GetPlane(p, a, b, c, d, e)
#define IDirect3DRMClippedVisual_SetPlane(p, a, b, c, d, e) (p)->lpVtbl->SetPlane(p, a, b, c, d, e)

end extern
