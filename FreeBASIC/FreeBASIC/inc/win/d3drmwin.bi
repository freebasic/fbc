''
''
'' d3drmwin -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_d3drmwin_bi__
#define __win_d3drmwin_bi__

#include once "win/d3drm.bi"
#include once "win/ddraw.bi"
#include once "win/d3d.bi"

extern IID_IDirect3DRMWinDevice alias "IID_IDirect3DRMWinDevice" as GUID

type LPDIRECT3DRMWINDEVICE as IDirect3DRMWinDevice ptr
type LPLPDIRECT3DRMWINDEVICE as IDirect3DRMWinDevice ptr ptr

type IDirect3DRMWinDeviceVtbl_ as IDirect3DRMWinDeviceVtbl

type IDirect3DRMWinDevice
	lpVtbl as IDirect3DRMWinDeviceVtbl_ ptr
end type

type IDirect3DRMWinDeviceVtbl
	QueryInterface as function(byval as IDirect3DRMWinDevice ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirect3DRMWinDevice ptr) as ULONG
	Release as function(byval as IDirect3DRMWinDevice ptr) as ULONG
	Clone as function(byval as IDirect3DRMWinDevice ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddDestroyCallback as function(byval as IDirect3DRMWinDevice ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	DeleteDestroyCallback as function(byval as IDirect3DRMWinDevice ptr, byval as D3DRMOBJECTCALLBACK, byval as LPVOID) as HRESULT
	SetAppData as function(byval as IDirect3DRMWinDevice ptr, byval as DWORD) as HRESULT
	GetAppData as function(byval as IDirect3DRMWinDevice ptr) as DWORD
	SetName as function(byval as IDirect3DRMWinDevice ptr, byval as LPCSTR) as HRESULT
	GetName as function(byval as IDirect3DRMWinDevice ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	GetClassNameA as function(byval as IDirect3DRMWinDevice ptr, byval as LPDWORD, byval as LPSTR) as HRESULT
	HandlePaint as function(byval as IDirect3DRMWinDevice ptr, byval as HDC) as HRESULT
	HandleActivate as function(byval as IDirect3DRMWinDevice ptr, byval as WORD) as HRESULT
end type

#endif
