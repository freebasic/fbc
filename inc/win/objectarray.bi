'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   Copyright 2011 Jacek Caban for CodeWeavers
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

#include once "rpc.bi"
#include once "rpcndr.bi"
#include once "windows.bi"
#include once "ole2.bi"
#include once "oaidl.bi"
#include once "ocidl.bi"

extern "Windows"

#define __objectarray_h__
#define __IObjectArray_FWD_DEFINED__
#define __IObjectCollection_FWD_DEFINED__
#define __IObjectArray_INTERFACE_DEFINED__
extern IID_IObjectArray as const GUID
type IObjectArray as IObjectArray_

type IObjectArrayVtbl
	QueryInterface as function(byval This as IObjectArray ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IObjectArray ptr) as ULONG
	Release as function(byval This as IObjectArray ptr) as ULONG
	GetCount as function(byval This as IObjectArray ptr, byval pcObjects as UINT ptr) as HRESULT
	GetAt as function(byval This as IObjectArray ptr, byval uiIndex as UINT, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
end type

type IObjectArray_
	lpVtbl as IObjectArrayVtbl ptr
end type

#define IObjectArray_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IObjectArray_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IObjectArray_Release(This) (This)->lpVtbl->Release(This)
#define IObjectArray_GetCount(This, pcObjects) (This)->lpVtbl->GetCount(This, pcObjects)
#define IObjectArray_GetAt(This, uiIndex, riid, ppv) (This)->lpVtbl->GetAt(This, uiIndex, riid, ppv)

declare function IObjectArray_GetCount_Proxy(byval This as IObjectArray ptr, byval pcObjects as UINT ptr) as HRESULT
declare sub IObjectArray_GetCount_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IObjectArray_GetAt_Proxy(byval This as IObjectArray ptr, byval uiIndex as UINT, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IObjectArray_GetAt_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IObjectCollection_INTERFACE_DEFINED__
extern IID_IObjectCollection as const GUID
type IObjectCollection as IObjectCollection_

type IObjectCollectionVtbl
	QueryInterface as function(byval This as IObjectCollection ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IObjectCollection ptr) as ULONG
	Release as function(byval This as IObjectCollection ptr) as ULONG
	GetCount as function(byval This as IObjectCollection ptr, byval pcObjects as UINT ptr) as HRESULT
	GetAt as function(byval This as IObjectCollection ptr, byval uiIndex as UINT, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddObject as function(byval This as IObjectCollection ptr, byval punk as IUnknown ptr) as HRESULT
	AddFromArray as function(byval This as IObjectCollection ptr, byval poaSource as IObjectArray ptr) as HRESULT
	RemoveObjectAt as function(byval This as IObjectCollection ptr, byval uiIndex as UINT) as HRESULT
	Clear as function(byval This as IObjectCollection ptr) as HRESULT
end type

type IObjectCollection_
	lpVtbl as IObjectCollectionVtbl ptr
end type

#define IObjectCollection_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IObjectCollection_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IObjectCollection_Release(This) (This)->lpVtbl->Release(This)
#define IObjectCollection_GetCount(This, pcObjects) (This)->lpVtbl->GetCount(This, pcObjects)
#define IObjectCollection_GetAt(This, uiIndex, riid, ppv) (This)->lpVtbl->GetAt(This, uiIndex, riid, ppv)
#define IObjectCollection_AddObject(This, punk) (This)->lpVtbl->AddObject(This, punk)
#define IObjectCollection_AddFromArray(This, poaSource) (This)->lpVtbl->AddFromArray(This, poaSource)
#define IObjectCollection_RemoveObjectAt(This, uiIndex) (This)->lpVtbl->RemoveObjectAt(This, uiIndex)
#define IObjectCollection_Clear(This) (This)->lpVtbl->Clear(This)

declare function IObjectCollection_AddObject_Proxy(byval This as IObjectCollection ptr, byval punk as IUnknown ptr) as HRESULT
declare sub IObjectCollection_AddObject_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IObjectCollection_AddFromArray_Proxy(byval This as IObjectCollection ptr, byval poaSource as IObjectArray ptr) as HRESULT
declare sub IObjectCollection_AddFromArray_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IObjectCollection_RemoveObjectAt_Proxy(byval This as IObjectCollection ptr, byval uiIndex as UINT) as HRESULT
declare sub IObjectCollection_RemoveObjectAt_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IObjectCollection_Clear_Proxy(byval This as IObjectCollection ptr) as HRESULT
declare sub IObjectCollection_Clear_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

end extern
