'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   Copyright (C) 2005 Peter Berg Larsen
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

#inclib "d3drm"

#include once "ddraw.bi"

extern "Windows"

#define __D3DRM_H__
type IDirect3DRM as IDirect3DRM_
type LPDIRECT3DRM as IDirect3DRM ptr
type LPLPDIRECT3DRM as IDirect3DRM ptr ptr

end extern

#include once "d3drmobj.bi"

extern "Windows"

extern CLSID_CDirect3DRM as const GUID
extern IID_IDirect3DRM as const GUID
extern IID_IDirect3DRM2 as const GUID
extern IID_IDirect3DRM3 as const GUID

type LPDIRECT3DRM2 as IDirect3DRM2 ptr
type LPLPDIRECT3DRM2 as IDirect3DRM2 ptr ptr
type LPDIRECT3DRM3 as IDirect3DRM3 ptr
type LPLPDIRECT3DRM3 as IDirect3DRM3 ptr ptr
declare function Direct3DRMCreate(byval d3drm as IDirect3DRM ptr ptr) as HRESULT
type IDirect3DRMVtbl as IDirect3DRMVtbl_

type IDirect3DRM_
	lpVtbl as IDirect3DRMVtbl ptr
end type

type IDirect3DRMVtbl_
	QueryInterface as function(byval This as IDirect3DRM ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRM ptr) as ULONG
	Release as function(byval This as IDirect3DRM ptr) as ULONG
	CreateObject as function(byval This as IDirect3DRM ptr, byval clsid as const IID const ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	CreateFrame as function(byval This as IDirect3DRM ptr, byval parent as IDirect3DRMFrame ptr, byval frame as IDirect3DRMFrame ptr ptr) as HRESULT
	CreateMesh as function(byval This as IDirect3DRM ptr, byval mesh as IDirect3DRMMesh ptr ptr) as HRESULT
	CreateMeshBuilder as function(byval This as IDirect3DRM ptr, byval mesh_builder as IDirect3DRMMeshBuilder ptr ptr) as HRESULT
	CreateFace as function(byval This as IDirect3DRM ptr, byval face as IDirect3DRMFace ptr ptr) as HRESULT
	CreateAnimation as function(byval This as IDirect3DRM ptr, byval animation as IDirect3DRMAnimation ptr ptr) as HRESULT
	CreateAnimationSet as function(byval This as IDirect3DRM ptr, byval set as IDirect3DRMAnimationSet ptr ptr) as HRESULT
	CreateTexture as function(byval This as IDirect3DRM ptr, byval image as D3DRMIMAGE ptr, byval texture as IDirect3DRMTexture ptr ptr) as HRESULT
	CreateLight as function(byval This as IDirect3DRM ptr, byval type as D3DRMLIGHTTYPE, byval color as D3DCOLOR, byval light as IDirect3DRMLight ptr ptr) as HRESULT
	CreateLightRGB as function(byval This as IDirect3DRM ptr, byval type as D3DRMLIGHTTYPE, byval r as D3DVALUE, byval g as D3DVALUE, byval b as D3DVALUE, byval light as IDirect3DRMLight ptr ptr) as HRESULT
	CreateMaterial as function(byval This as IDirect3DRM ptr, byval power as D3DVALUE, byval material as IDirect3DRMMaterial ptr ptr) as HRESULT
	CreateDevice as function(byval This as IDirect3DRM ptr, byval width as DWORD, byval height as DWORD, byval device as IDirect3DRMDevice ptr ptr) as HRESULT
	CreateDeviceFromSurface as function(byval This as IDirect3DRM ptr, byval guid as GUID ptr, byval ddraw as IDirectDraw ptr, byval surface as IDirectDrawSurface ptr, byval device as IDirect3DRMDevice ptr ptr) as HRESULT
	CreateDeviceFromD3D as function(byval This as IDirect3DRM ptr, byval d3d as IDirect3D ptr, byval d3d_device as IDirect3DDevice ptr, byval device as IDirect3DRMDevice ptr ptr) as HRESULT
	CreateDeviceFromClipper as function(byval This as IDirect3DRM ptr, byval clipper as IDirectDrawClipper ptr, byval guid as GUID ptr, byval width as long, byval height as long, byval device as IDirect3DRMDevice ptr ptr) as HRESULT
	CreateTextureFromSurface as function(byval This as IDirect3DRM ptr, byval surface as IDirectDrawSurface ptr, byval texture as IDirect3DRMTexture ptr ptr) as HRESULT
	CreateShadow as function(byval This as IDirect3DRM ptr, byval visual as IDirect3DRMVisual ptr, byval light as IDirect3DRMLight ptr, byval px as D3DVALUE, byval py as D3DVALUE, byval pz as D3DVALUE, byval nx as D3DVALUE, byval ny as D3DVALUE, byval nz as D3DVALUE, byval shadow as IDirect3DRMVisual ptr ptr) as HRESULT
	CreateViewport as function(byval This as IDirect3DRM ptr, byval device as IDirect3DRMDevice ptr, byval camera as IDirect3DRMFrame ptr, byval x as DWORD, byval y as DWORD, byval width as DWORD, byval height as DWORD, byval viewport as IDirect3DRMViewport ptr ptr) as HRESULT
	CreateWrap as function(byval This as IDirect3DRM ptr, byval type as D3DRMWRAPTYPE, byval reference as IDirect3DRMFrame ptr, byval ox as D3DVALUE, byval oy as D3DVALUE, byval oz as D3DVALUE, byval dx as D3DVALUE, byval dy as D3DVALUE, byval dz as D3DVALUE, byval ux as D3DVALUE, byval uy as D3DVALUE, byval uz as D3DVALUE, byval ou as D3DVALUE, byval ov as D3DVALUE, byval su as D3DVALUE, byval sv as D3DVALUE, byval wrap as IDirect3DRMWrap ptr ptr) as HRESULT
	CreateUserVisual as function(byval This as IDirect3DRM ptr, byval cb as D3DRMUSERVISUALCALLBACK, byval ctx as any ptr, byval visual as IDirect3DRMUserVisual ptr ptr) as HRESULT
	LoadTexture as function(byval This as IDirect3DRM ptr, byval filename as const zstring ptr, byval texture as IDirect3DRMTexture ptr ptr) as HRESULT
	LoadTextureFromResource as function(byval This as IDirect3DRM ptr, byval resource as HRSRC, byval texture as IDirect3DRMTexture ptr ptr) as HRESULT
	SetSearchPath as function(byval This as IDirect3DRM ptr, byval path as const zstring ptr) as HRESULT
	AddSearchPath as function(byval This as IDirect3DRM ptr, byval path as const zstring ptr) as HRESULT
	GetSearchPath as function(byval This as IDirect3DRM ptr, byval size as DWORD ptr, byval path as zstring ptr) as HRESULT
	SetDefaultTextureColors as function(byval This as IDirect3DRM ptr, byval as DWORD) as HRESULT
	SetDefaultTextureShades as function(byval This as IDirect3DRM ptr, byval as DWORD) as HRESULT
	GetDevices as function(byval This as IDirect3DRM ptr, byval array as IDirect3DRMDeviceArray ptr ptr) as HRESULT
	GetNamedObject as function(byval This as IDirect3DRM ptr, byval name as const zstring ptr, byval object as IDirect3DRMObject ptr ptr) as HRESULT
	EnumerateObjects as function(byval This as IDirect3DRM ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	Load as function(byval This as IDirect3DRM ptr, byval source as any ptr, byval object_id as any ptr, byval iids as IID ptr ptr, byval iid_count as DWORD, byval flags as D3DRMLOADOPTIONS, byval load_cb as D3DRMLOADCALLBACK, byval load_ctx as any ptr, byval load_tex_cb as D3DRMLOADTEXTURECALLBACK, byval load_tex_ctx as any ptr, byval parent_frame as IDirect3DRMFrame ptr) as HRESULT
	Tick as function(byval This as IDirect3DRM ptr, byval as D3DVALUE) as HRESULT
end type

#define IDirect3DRM_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRM_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRM_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRM_CreateObject(p, a, b, c, d) (p)->lpVtbl->CreateObject(p, a, b, d)
#define IDirect3DRM_CreateFrame(p, a, b) (p)->lpVtbl->CreateFrame(p, a, b)
#define IDirect3DRM_CreateMesh(p, a) (p)->lpVtbl->CreateMesh(p, a)
#define IDirect3DRM_CreateMeshBuilder(p, a) (p)->lpVtbl->CreateMeshBuilder(p, a)
#define IDirect3DRM_CreateFace(p, a) (p)->lpVtbl->CreateFace(p, a)
#define IDirect3DRM_CreateAnimation(p, a) (p)->lpVtbl->CreateAnimation(p, a)
#define IDirect3DRM_CreateAnimationSet(p, a) (p)->lpVtbl->CreateAnimationSet(p, a)
#define IDirect3DRM_CreateTexture(p, a, b) (p)->lpVtbl->CreateTexture(p, a, b)
#define IDirect3DRM_CreateLight(p, a, b, c) (p)->lpVtbl->CreateLight(p, a, b, c)
#define IDirect3DRM_CreateLightRGB(p, a, b, c, d, e) (p)->lpVtbl->CreateLightRGB(p, a, b, c, d, e)
#define IDirect3DRM_CreateMaterial(p, a, b) (p)->lpVtbl->CreateMaterial(p, a, b)
#define IDirect3DRM_CreateDevice(p, a, b, c) (p)->lpVtbl->CreateDevice(p, a, b, c)
#define IDirect3DRM_CreateDeviceFromSurface(p, a, b, c, d) (p)->lpVtbl->CreateDeviceFromSurface(p, a, b, c, d)
#define IDirect3DRM_CreateDeviceFromD3D(p, a, b, c) (p)->lpVtbl->CreateDeviceFromD3D(p, a, b, c)
#define IDirect3DRM_CreateDeviceFromClipper(p, a, b, c, d, e) (p)->lpVtbl->CreateDeviceFromClipper(p, a, b, c, d, e)
#define IDirect3DRM_CreateTextureFromSurface(p, a, b) (p)->lpVtbl->CreateTextureFromSurface(p, a, b)
#define IDirect3DRM_CreateShadow(p, a, b, c, d, e, f, g, h, i) (p)->lpVtbl->CreateShadow(p, a, b, c, d, e, f, g, h, i)
#define IDirect3DRM_CreateViewport(p, a, b, c, d, e, f, g) (p)->lpVtbl->CreateViewport(p, a, b, c, d, e, f, g)
#define IDirect3DRM_CreateWrap(p, a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, q) (p)->lpVtbl->CreateWrap(p, a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, q)
#define IDirect3DRM_CreateUserVisual(p, a, b, c) (p)->lpVtbl->CreateUserVisual(p, a, b, c)
#define IDirect3DRM_LoadTexture(p, a, b) (p)->lpVtbl->LoadTexture(p, a, b)
#define IDirect3DRM_LoadTextureFromResource(p, a, b) (p)->lpVtbl->LoadTextureFromResource(p, a, b)
#define IDirect3DRM_SetSearchPath(p, a) (p)->lpVtbl->SetSearchPath(p, a)
#define IDirect3DRM_AddSearchPath(p, a) (p)->lpVtbl->AddSearchPath(p, a)
#define IDirect3DRM_GetSearchPath(p, a, b) (p)->lpVtbl->GetSearchPath(p, a, b)
#define IDirect3DRM_SetDefaultTextureColors(p, a) (p)->lpVtbl->SetDefaultTextureColors(p, a)
#define IDirect3DRM_SetDefaultTextureShades(p, a) (p)->lpVtbl->SetDefaultTextureShades(p, a)
#define IDirect3DRM_GetDevices(p, a) (p)->lpVtbl->GetDevices(p, a)
#define IDirect3DRM_GetNamedObject(p, a, b) (p)->lpVtbl->GetNamedObject(p, a, b)
#define IDirect3DRM_EnumerateObjects(p, a, b) (p)->lpVtbl->EnumerateObjects(p, a, b)
#define IDirect3DRM_Load(p, a, b, c, d, e, f, g, h, i, j) (p)->lpVtbl->Load(p, a, b, c, d, e, f, g, h, i, j)
#define IDirect3DRM_Tick(p, a) (p)->lpVtbl->Tick(p, a)
type IDirect3DRM2Vtbl as IDirect3DRM2Vtbl_

type IDirect3DRM2
	lpVtbl as IDirect3DRM2Vtbl ptr
end type

type IDirect3DRM2Vtbl_
	QueryInterface as function(byval This as IDirect3DRM2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRM2 ptr) as ULONG
	Release as function(byval This as IDirect3DRM2 ptr) as ULONG
	CreateObject as function(byval This as IDirect3DRM2 ptr, byval clsid as const IID const ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	CreateFrame as function(byval This as IDirect3DRM2 ptr, byval parent as IDirect3DRMFrame ptr, byval frame as IDirect3DRMFrame2 ptr ptr) as HRESULT
	CreateMesh as function(byval This as IDirect3DRM2 ptr, byval mesh as IDirect3DRMMesh ptr ptr) as HRESULT
	CreateMeshBuilder as function(byval This as IDirect3DRM2 ptr, byval mesh_builder as IDirect3DRMMeshBuilder2 ptr ptr) as HRESULT
	CreateFace as function(byval This as IDirect3DRM2 ptr, byval face as IDirect3DRMFace ptr ptr) as HRESULT
	CreateAnimation as function(byval This as IDirect3DRM2 ptr, byval animation as IDirect3DRMAnimation ptr ptr) as HRESULT
	CreateAnimationSet as function(byval This as IDirect3DRM2 ptr, byval set as IDirect3DRMAnimationSet ptr ptr) as HRESULT
	CreateTexture as function(byval This as IDirect3DRM2 ptr, byval image as D3DRMIMAGE ptr, byval texture as IDirect3DRMTexture2 ptr ptr) as HRESULT
	CreateLight as function(byval This as IDirect3DRM2 ptr, byval type as D3DRMLIGHTTYPE, byval color as D3DCOLOR, byval light as IDirect3DRMLight ptr ptr) as HRESULT
	CreateLightRGB as function(byval This as IDirect3DRM2 ptr, byval type as D3DRMLIGHTTYPE, byval r as D3DVALUE, byval g as D3DVALUE, byval b as D3DVALUE, byval light as IDirect3DRMLight ptr ptr) as HRESULT
	CreateMaterial as function(byval This as IDirect3DRM2 ptr, byval power as D3DVALUE, byval material as IDirect3DRMMaterial ptr ptr) as HRESULT
	CreateDevice as function(byval This as IDirect3DRM2 ptr, byval width as DWORD, byval height as DWORD, byval device as IDirect3DRMDevice2 ptr ptr) as HRESULT
	CreateDeviceFromSurface as function(byval This as IDirect3DRM2 ptr, byval guid as GUID ptr, byval ddraw as IDirectDraw ptr, byval surface as IDirectDrawSurface ptr, byval device as IDirect3DRMDevice2 ptr ptr) as HRESULT
	CreateDeviceFromD3D as function(byval This as IDirect3DRM2 ptr, byval d3d as IDirect3D2 ptr, byval d3d_device as IDirect3DDevice2 ptr, byval device as IDirect3DRMDevice2 ptr ptr) as HRESULT
	CreateDeviceFromClipper as function(byval This as IDirect3DRM2 ptr, byval clipper as IDirectDrawClipper ptr, byval guid as GUID ptr, byval width as long, byval height as long, byval device as IDirect3DRMDevice2 ptr ptr) as HRESULT
	CreateTextureFromSurface as function(byval This as IDirect3DRM2 ptr, byval surface as IDirectDrawSurface ptr, byval texture as IDirect3DRMTexture2 ptr ptr) as HRESULT
	CreateShadow as function(byval This as IDirect3DRM2 ptr, byval visual as IDirect3DRMVisual ptr, byval light as IDirect3DRMLight ptr, byval px as D3DVALUE, byval py as D3DVALUE, byval pz as D3DVALUE, byval nx as D3DVALUE, byval ny as D3DVALUE, byval nz as D3DVALUE, byval shadow as IDirect3DRMVisual ptr ptr) as HRESULT
	CreateViewport as function(byval This as IDirect3DRM2 ptr, byval device as IDirect3DRMDevice ptr, byval camera as IDirect3DRMFrame ptr, byval x as DWORD, byval y as DWORD, byval width as DWORD, byval height as DWORD, byval viewport as IDirect3DRMViewport ptr ptr) as HRESULT
	CreateWrap as function(byval This as IDirect3DRM2 ptr, byval type as D3DRMWRAPTYPE, byval reference as IDirect3DRMFrame ptr, byval ox as D3DVALUE, byval oy as D3DVALUE, byval oz as D3DVALUE, byval dx as D3DVALUE, byval dy as D3DVALUE, byval dz as D3DVALUE, byval ux as D3DVALUE, byval uy as D3DVALUE, byval uz as D3DVALUE, byval ou as D3DVALUE, byval ov as D3DVALUE, byval su as D3DVALUE, byval sv as D3DVALUE, byval wrap as IDirect3DRMWrap ptr ptr) as HRESULT
	CreateUserVisual as function(byval This as IDirect3DRM2 ptr, byval cb as D3DRMUSERVISUALCALLBACK, byval ctx as any ptr, byval visual as IDirect3DRMUserVisual ptr ptr) as HRESULT
	LoadTexture as function(byval This as IDirect3DRM2 ptr, byval filename as const zstring ptr, byval texture as IDirect3DRMTexture2 ptr ptr) as HRESULT
	LoadTextureFromResource as function(byval This as IDirect3DRM2 ptr, byval module as HMODULE, byval resource_name as const zstring ptr, byval resource_type as const zstring ptr, byval texture as IDirect3DRMTexture2 ptr ptr) as HRESULT
	SetSearchPath as function(byval This as IDirect3DRM2 ptr, byval path as const zstring ptr) as HRESULT
	AddSearchPath as function(byval This as IDirect3DRM2 ptr, byval path as const zstring ptr) as HRESULT
	GetSearchPath as function(byval This as IDirect3DRM2 ptr, byval size as DWORD ptr, byval path as zstring ptr) as HRESULT
	SetDefaultTextureColors as function(byval This as IDirect3DRM2 ptr, byval as DWORD) as HRESULT
	SetDefaultTextureShades as function(byval This as IDirect3DRM2 ptr, byval as DWORD) as HRESULT
	GetDevices as function(byval This as IDirect3DRM2 ptr, byval array as IDirect3DRMDeviceArray ptr ptr) as HRESULT
	GetNamedObject as function(byval This as IDirect3DRM2 ptr, byval name as const zstring ptr, byval object as IDirect3DRMObject ptr ptr) as HRESULT
	EnumerateObjects as function(byval This as IDirect3DRM2 ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	Load as function(byval This as IDirect3DRM2 ptr, byval source as any ptr, byval object_id as any ptr, byval iids as IID ptr ptr, byval iid_count as DWORD, byval flags as D3DRMLOADOPTIONS, byval load_cb as D3DRMLOADCALLBACK, byval load_ctx as any ptr, byval load_tex_cb as D3DRMLOADTEXTURECALLBACK, byval load_tex_ctx as any ptr, byval parent_frame as IDirect3DRMFrame ptr) as HRESULT
	Tick as function(byval This as IDirect3DRM2 ptr, byval as D3DVALUE) as HRESULT
	CreateProgressiveMesh as function(byval This as IDirect3DRM2 ptr, byval mesh as IDirect3DRMProgressiveMesh ptr ptr) as HRESULT
end type

#define IDirect3DRM2_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRM2_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRM2_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRM2_CreateObject(p, a, b, c, d) (p)->lpVtbl->CreateObject(p, a, b, d)
#define IDirect3DRM2_CreateFrame(p, a, b) (p)->lpVtbl->CreateFrame(p, a, b)
#define IDirect3DRM2_CreateMesh(p, a) (p)->lpVtbl->CreateMesh(p, a)
#define IDirect3DRM2_CreateMeshBuilder(p, a) (p)->lpVtbl->CreateMeshBuilder(p, a)
#define IDirect3DRM2_CreateFace(p, a) (p)->lpVtbl->CreateFace(p, a)
#define IDirect3DRM2_CreateAnimation(p, a) (p)->lpVtbl->CreateAnimation(p, a)
#define IDirect3DRM2_CreateAnimationSet(p, a) (p)->lpVtbl->CreateAnimationSet(p, a)
#define IDirect3DRM2_CreateTexture(p, a, b) (p)->lpVtbl->CreateTexture(p, a, b)
#define IDirect3DRM2_CreateLight(p, a, b, c) (p)->lpVtbl->CreateLight(p, a, b, c)
#define IDirect3DRM2_CreateLightRGB(p, a, b, c, d, e) (p)->lpVtbl->CreateLightRGB(p, a, b, c, d, e)
#define IDirect3DRM2_CreateMaterial(p, a, b) (p)->lpVtbl->CreateMaterial(p, a, b)
#define IDirect3DRM2_CreateDevice(p, a, b, c) (p)->lpVtbl->CreateDevice(p, a, b, c)
#define IDirect3DRM2_CreateDeviceFromSurface(p, a, b, c, d) (p)->lpVtbl->CreateDeviceFromSurface(p, a, b, c, d)
#define IDirect3DRM2_CreateDeviceFromD3D(p, a, b, c) (p)->lpVtbl->CreateDeviceFromD3D(p, a, b, c)
#define IDirect3DRM2_CreateDeviceFromClipper(p, a, b, c, d, e) (p)->lpVtbl->CreateDeviceFromClipper(p, a, b, c, d, e)
#define IDirect3DRM2_CreateTextureFromSurface(p, a, b) (p)->lpVtbl->CreateTextureFromSurface(p, a, b)
#define IDirect3DRM2_CreateShadow(p, a, b, c, d, e, f, g, h, i) (p)->lpVtbl->CreateShadow(p, a, b, c, d, e, f, g, h, i)
#define IDirect3DRM2_CreateViewport(p, a, b, c, d, e, f, g) (p)->lpVtbl->CreateViewport(p, a, b, c, d, e, f, g)
#define IDirect3DRM2_CreateWrap(p, a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, q) (p)->lpVtbl->CreateWrap(p, a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, q)
#define IDirect3DRM2_CreateUserVisual(p, a, b, c) (p)->lpVtbl->CreateUserVisual(p, a, b, c)
#define IDirect3DRM2_LoadTexture(p, a, b) (p)->lpVtbl->LoadTexture(p, a, b)
#define IDirect3DRM2_LoadTextureFromResource(p, a, b, c, d) (p)->lpVtbl->LoadTextureFromResource(p, a, b, c, d)
#define IDirect3DRM2_SetSearchPath(p, a) (p)->lpVtbl->SetSearchPath(p, a)
#define IDirect3DRM2_AddSearchPath(p, a) (p)->lpVtbl->AddSearchPath(p, a)
#define IDirect3DRM2_GetSearchPath(p, a, b) (p)->lpVtbl->GetSearchPath(p, a, b)
#define IDirect3DRM2_SetDefaultTextureColors(p, a) (p)->lpVtbl->SetDefaultTextureColors(p, a)
#define IDirect3DRM2_SetDefaultTextureShades(p, a) (p)->lpVtbl->SetDefaultTextureShades(p, a)
#define IDirect3DRM2_GetDevices(p, a) (p)->lpVtbl->GetDevices(p, a)
#define IDirect3DRM2_GetNamedObject(p, a, b) (p)->lpVtbl->GetNamedObject(p, a, b)
#define IDirect3DRM2_EnumerateObjects(p, a, b) (p)->lpVtbl->EnumerateObjects(p, a, b)
#define IDirect3DRM2_Load(p, a, b, c, d, e, f, g, h, i, j) (p)->lpVtbl->Load(p, a, b, c, d, e, f, g, h, i, j)
#define IDirect3DRM2_Tick(p, a) (p)->lpVtbl->Tick(p, a)
#define IDirect3DRM2_CreateProgressiveMesh(p, a) (p)->lpVtbl->CreateProgressiveMesh(p, a)
type IDirect3DRM3Vtbl as IDirect3DRM3Vtbl_

type IDirect3DRM3
	lpVtbl as IDirect3DRM3Vtbl ptr
end type

type IDirect3DRM3Vtbl_
	QueryInterface as function(byval This as IDirect3DRM3 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirect3DRM3 ptr) as ULONG
	Release as function(byval This as IDirect3DRM3 ptr) as ULONG
	CreateObject as function(byval This as IDirect3DRM3 ptr, byval clsid as const IID const ptr, byval outer as IUnknown ptr, byval iid as const IID const ptr, byval out as any ptr ptr) as HRESULT
	CreateFrame as function(byval This as IDirect3DRM3 ptr, byval parent as IDirect3DRMFrame3 ptr, byval frame as IDirect3DRMFrame3 ptr ptr) as HRESULT
	CreateMesh as function(byval This as IDirect3DRM3 ptr, byval mesh as IDirect3DRMMesh ptr ptr) as HRESULT
	CreateMeshBuilder as function(byval This as IDirect3DRM3 ptr, byval mesh_builder as IDirect3DRMMeshBuilder3 ptr ptr) as HRESULT
	CreateFace as function(byval This as IDirect3DRM3 ptr, byval face as IDirect3DRMFace2 ptr ptr) as HRESULT
	CreateAnimation as function(byval This as IDirect3DRM3 ptr, byval animation as IDirect3DRMAnimation2 ptr ptr) as HRESULT
	CreateAnimationSet as function(byval This as IDirect3DRM3 ptr, byval set as IDirect3DRMAnimationSet2 ptr ptr) as HRESULT
	CreateTexture as function(byval This as IDirect3DRM3 ptr, byval image as D3DRMIMAGE ptr, byval texture as IDirect3DRMTexture3 ptr ptr) as HRESULT
	CreateLight as function(byval This as IDirect3DRM3 ptr, byval type as D3DRMLIGHTTYPE, byval color as D3DCOLOR, byval light as IDirect3DRMLight ptr ptr) as HRESULT
	CreateLightRGB as function(byval This as IDirect3DRM3 ptr, byval type as D3DRMLIGHTTYPE, byval r as D3DVALUE, byval g as D3DVALUE, byval b as D3DVALUE, byval light as IDirect3DRMLight ptr ptr) as HRESULT
	CreateMaterial as function(byval This as IDirect3DRM3 ptr, byval as D3DVALUE, byval material as IDirect3DRMMaterial2 ptr ptr) as HRESULT
	CreateDevice as function(byval This as IDirect3DRM3 ptr, byval width as DWORD, byval height as DWORD, byval device as IDirect3DRMDevice3 ptr ptr) as HRESULT
	CreateDeviceFromSurface as function(byval This as IDirect3DRM3 ptr, byval guid as GUID ptr, byval ddraw as IDirectDraw ptr, byval surface as IDirectDrawSurface ptr, byval device as IDirect3DRMDevice3 ptr ptr) as HRESULT
	CreateDeviceFromD3D as function(byval This as IDirect3DRM3 ptr, byval d3d as IDirect3D2 ptr, byval d3d_device as IDirect3DDevice2 ptr, byval device as IDirect3DRMDevice3 ptr ptr) as HRESULT
	CreateDeviceFromClipper as function(byval This as IDirect3DRM3 ptr, byval clipper as IDirectDrawClipper ptr, byval guid as GUID ptr, byval width as long, byval height as long, byval device as IDirect3DRMDevice3 ptr ptr) as HRESULT
	CreateTextureFromSurface as function(byval This as IDirect3DRM3 ptr, byval surface as IDirectDrawSurface ptr, byval texture as IDirect3DRMTexture3 ptr ptr) as HRESULT
	CreateShadow as function(byval This as IDirect3DRM3 ptr, byval object as IUnknown ptr, byval light as IDirect3DRMLight ptr, byval px as D3DVALUE, byval py as D3DVALUE, byval pz as D3DVALUE, byval nx as D3DVALUE, byval ny as D3DVALUE, byval nz as D3DVALUE, byval shadow as IDirect3DRMShadow2 ptr ptr) as HRESULT
	CreateViewport as function(byval This as IDirect3DRM3 ptr, byval device as IDirect3DRMDevice3 ptr, byval camera as IDirect3DRMFrame3 ptr, byval x as DWORD, byval y as DWORD, byval width as DWORD, byval height as DWORD, byval viewport as IDirect3DRMViewport2 ptr ptr) as HRESULT
	CreateWrap as function(byval This as IDirect3DRM3 ptr, byval type as D3DRMWRAPTYPE, byval reference as IDirect3DRMFrame3 ptr, byval ox as D3DVALUE, byval oy as D3DVALUE, byval oz as D3DVALUE, byval dx as D3DVALUE, byval dy as D3DVALUE, byval dz as D3DVALUE, byval ux as D3DVALUE, byval uy as D3DVALUE, byval uz as D3DVALUE, byval ou as D3DVALUE, byval ov as D3DVALUE, byval su as D3DVALUE, byval sv as D3DVALUE, byval wrap as IDirect3DRMWrap ptr ptr) as HRESULT
	CreateUserVisual as function(byval This as IDirect3DRM3 ptr, byval cb as D3DRMUSERVISUALCALLBACK, byval ctx as any ptr, byval visual as IDirect3DRMUserVisual ptr ptr) as HRESULT
	LoadTexture as function(byval This as IDirect3DRM3 ptr, byval filename as const zstring ptr, byval texture as IDirect3DRMTexture3 ptr ptr) as HRESULT
	LoadTextureFromResource as function(byval This as IDirect3DRM3 ptr, byval module as HMODULE, byval resource_name as const zstring ptr, byval resource_type as const zstring ptr, byval texture as IDirect3DRMTexture3 ptr ptr) as HRESULT
	SetSearchPath as function(byval This as IDirect3DRM3 ptr, byval path as const zstring ptr) as HRESULT
	AddSearchPath as function(byval This as IDirect3DRM3 ptr, byval path as const zstring ptr) as HRESULT
	GetSearchPath as function(byval This as IDirect3DRM3 ptr, byval size as DWORD ptr, byval path as zstring ptr) as HRESULT
	SetDefaultTextureColors as function(byval This as IDirect3DRM3 ptr, byval as DWORD) as HRESULT
	SetDefaultTextureShades as function(byval This as IDirect3DRM3 ptr, byval as DWORD) as HRESULT
	GetDevices as function(byval This as IDirect3DRM3 ptr, byval array as IDirect3DRMDeviceArray ptr ptr) as HRESULT
	GetNamedObject as function(byval This as IDirect3DRM3 ptr, byval name as const zstring ptr, byval object as IDirect3DRMObject ptr ptr) as HRESULT
	EnumerateObjects as function(byval This as IDirect3DRM3 ptr, byval cb as D3DRMOBJECTCALLBACK, byval ctx as any ptr) as HRESULT
	Load as function(byval This as IDirect3DRM3 ptr, byval source as any ptr, byval object_id as any ptr, byval iids as IID ptr ptr, byval iid_count as DWORD, byval flags as D3DRMLOADOPTIONS, byval load_cb as D3DRMLOADCALLBACK, byval load_ctx as any ptr, byval load_tex_cb as D3DRMLOADTEXTURECALLBACK, byval load_tex_ctx as any ptr, byval parent_frame as IDirect3DRMFrame3 ptr) as HRESULT
	Tick as function(byval This as IDirect3DRM3 ptr, byval as D3DVALUE) as HRESULT
	CreateProgressiveMesh as function(byval This as IDirect3DRM3 ptr, byval mesh as IDirect3DRMProgressiveMesh ptr ptr) as HRESULT
	RegisterClient as function(byval This as IDirect3DRM3 ptr, byval guid as const GUID const ptr, byval id as DWORD ptr) as HRESULT
	UnregisterClient as function(byval This as IDirect3DRM3 ptr, byval rguid as const GUID const ptr) as HRESULT
	CreateClippedVisual as function(byval This as IDirect3DRM3 ptr, byval visual as IDirect3DRMVisual ptr, byval clipped_visual as IDirect3DRMClippedVisual ptr ptr) as HRESULT
	SetOptions as function(byval This as IDirect3DRM3 ptr, byval as DWORD) as HRESULT
	GetOptions as function(byval This as IDirect3DRM3 ptr, byval flags as DWORD ptr) as HRESULT
end type

#define IDirect3DRM3_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirect3DRM3_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirect3DRM3_Release(p) (p)->lpVtbl->Release(p)
#define IDirect3DRM3_CreateObject(p, a, b, c, d) (p)->lpVtbl->CreateObject(p, a, b, d)
#define IDirect3DRM3_CreateFrame(p, a, b) (p)->lpVtbl->CreateFrame(p, a, b)
#define IDirect3DRM3_CreateMesh(p, a) (p)->lpVtbl->CreateMesh(p, a)
#define IDirect3DRM3_CreateMeshBuilder(p, a) (p)->lpVtbl->CreateMeshBuilder(p, a)
#define IDirect3DRM3_CreateFace(p, a) (p)->lpVtbl->CreateFace(p, a)
#define IDirect3DRM3_CreateAnimation(p, a) (p)->lpVtbl->CreateAnimation(p, a)
#define IDirect3DRM3_CreateAnimationSet(p, a) (p)->lpVtbl->CreateAnimationSet(p, a)
#define IDirect3DRM3_CreateTexture(p, a, b) (p)->lpVtbl->CreateTexture(p, a, b)
#define IDirect3DRM3_CreateLight(p, a, b, c) (p)->lpVtbl->CreateLight(p, a, b, c)
#define IDirect3DRM3_CreateLightRGB(p, a, b, c, d, e) (p)->lpVtbl->CreateLightRGB(p, a, b, c, d, e)
#define IDirect3DRM3_CreateMaterial(p, a, b) (p)->lpVtbl->CreateMaterial(p, a, b)
#define IDirect3DRM3_CreateDevice(p, a, b, c) (p)->lpVtbl->CreateDevice(p, a, b, c)
#define IDirect3DRM3_CreateDeviceFromSurface(p, a, b, c, d) (p)->lpVtbl->CreateDeviceFromSurface(p, a, b, c, d)
#define IDirect3DRM3_CreateDeviceFromD3D(p, a, b, c) (p)->lpVtbl->CreateDeviceFromD3D(p, a, b, c)
#define IDirect3DRM3_CreateDeviceFromClipper(p, a, b, c, d, e) (p)->lpVtbl->CreateDeviceFromClipper(p, a, b, c, d, e)
#define IDirect3DRM3_CreateTextureFromSurface(p, a, b) (p)->lpVtbl->CreateTextureFromSurface(p, a, b)
#define IDirect3DRM3_CreateShadow(p, a, b, c, d, e, f, g, h, i) (p)->lpVtbl->CreateShadow(p, a, b, c, d, e, f, g, h, i)
#define IDirect3DRM3_CreateViewport(p, a, b, c, d, e, f, g) (p)->lpVtbl->CreateViewport(p, a, b, c, d, e, f, g)
#define IDirect3DRM3_CreateWrap(p, a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, q) (p)->lpVtbl->CreateWrap(p, a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, q)
#define IDirect3DRM3_CreateUserVisual(p, a, b, c) (p)->lpVtbl->CreateUserVisual(p, a, b, c)
#define IDirect3DRM3_LoadTexture(p, a, b) (p)->lpVtbl->LoadTexture(p, a, b)
#define IDirect3DRM3_LoadTextureFromResource(p, a, b, c, d) (p)->lpVtbl->LoadTextureFromResource(p, a, b, c, d)
#define IDirect3DRM3_SetSearchPath(p, a) (p)->lpVtbl->SetSearchPath(p, a)
#define IDirect3DRM3_AddSearchPath(p, a) (p)->lpVtbl->AddSearchPath(p, a)
#define IDirect3DRM3_GetSearchPath(p, a, b) (p)->lpVtbl->GetSearchPath(p, a, b)
#define IDirect3DRM3_SetDefaultTextureColors(p, a) (p)->lpVtbl->SetDefaultTextureColors(p, a)
#define IDirect3DRM3_SetDefaultTextureShades(p, a) (p)->lpVtbl->SetDefaultTextureShades(p, a)
#define IDirect3DRM3_GetDevices(p, a) (p)->lpVtbl->GetDevices(p, a)
#define IDirect3DRM3_GetNamedObject(p, a, b) (p)->lpVtbl->GetNamedObject(p, a, b)
#define IDirect3DRM3_EnumerateObjects(p, a, b) (p)->lpVtbl->EnumerateObjects(p, a, b)
#define IDirect3DRM3_Load(p, a, b, c, d, e, f, g, h, i, j) (p)->lpVtbl->Load(p, a, b, c, d, e, f, g, h, i, j)
#define IDirect3DRM3_Tick(p, a) (p)->lpVtbl->Tick(p, a)
#define IDirect3DRM3_CreateProgressiveMesh(p, a) (p)->lpVtbl->CreateProgressiveMesh(p, a)
#define IDirect3DRM3_RegisterClient(p, a, b) (p)->lpVtbl->RegisterClient(p, a, b)
#define IDirect3DRM3_UnregisterClient(p, a) (p)->lpVtbl->UnregisterClient(p, a)
#define IDirect3DRM3_CreateClippedVisual(p, ab) (p)->lpVtbl->CreateClippedVisual(p, a, b)
#define IDirect3DRM3_SetOptions(p, a) (p)->lpVtbl->SetOptions(p, a)
#define IDirect3DRM3_GetOptions(p, a) (p)->lpVtbl->GetOptions(p, a)
const D3DRM_OK = DD_OK
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

end extern
