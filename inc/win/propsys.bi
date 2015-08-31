'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   This Software is provided under the Zope Public License (ZPL) Version 2.1.
''
''   Copyright (c) 2009, 2010 by the mingw-w64 project
''
''   See the AUTHORS file for the list of contributors to the mingw-w64 project.
''
''   This license has been certified as open source. It has also been designated
''   as GPL compatible by the Free Software Foundation (FSF).
''
''   Redistribution and use in source and binary forms, with or without
''   modification, are permitted provided that the following conditions are met:
''
''     1. Redistributions in source code must retain the accompanying copyright
''        notice, this list of conditions, and the following disclaimer.
''     2. Redistributions in binary form must reproduce the accompanying
''        copyright notice, this list of conditions, and the following disclaimer
''        in the documentation and/or other materials provided with the
''        distribution.
''     3. Names of the copyright holders must not be used to endorse or promote
''        products derived from this software without prior written permission
''        from the copyright holders.
''     4. The right to distribute this software or to use it for any purpose does
''        not give you the right to use Servicemarks (sm) or Trademarks (tm) of
''        the copyright holders.  Use of them is covered by separate agreement
''        with the copyright holders.
''     5. If any files are modified, you must cause the modified files to carry
''        prominent notices stating that you changed the files and the date of
''        any change.
''
''   Disclaimer
''
''   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY EXPRESSED
''   OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
''   OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
''   EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY DIRECT, INDIRECT,
''   INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
''   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
''   OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
''   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
''   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
''   EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "rpc.bi"
#include once "rpcndr.bi"
#include once "windows.bi"
#include once "ole2.bi"
#include once "objidl.bi"
#include once "oleidl.bi"
#include once "ocidl.bi"
#include once "shtypes.bi"
#include once "structuredquerycondition.bi"
#include once "winapifamily.bi"
#include once "propkeydef.bi"

extern "Windows"

#define __propsys_h__
#define __IInitializeWithFile_FWD_DEFINED__
#define __IInitializeWithStream_FWD_DEFINED__
#define __IPropertyStore_FWD_DEFINED__
#define __INamedPropertyStore_FWD_DEFINED__
#define __IObjectWithPropertyKey_FWD_DEFINED__
#define __IPropertyChange_FWD_DEFINED__
#define __IPropertyChangeArray_FWD_DEFINED__
#define __IPropertyStoreCapabilities_FWD_DEFINED__
#define __IPropertyStoreCache_FWD_DEFINED__
#define __IPropertyEnumType_FWD_DEFINED__
#define __IPropertyEnumType2_FWD_DEFINED__
#define __IPropertyEnumTypeList_FWD_DEFINED__
#define __IPropertyDescription_FWD_DEFINED__
#define __IPropertyDescription2_FWD_DEFINED__
#define __IPropertyDescriptionAliasInfo_FWD_DEFINED__
#define __IPropertyDescriptionSearchInfo_FWD_DEFINED__
#define __IPropertyDescriptionRelatedPropertyInfo_FWD_DEFINED__
#define __IPropertySystem_FWD_DEFINED__
#define __IPropertyDescriptionList_FWD_DEFINED__
#define __IPropertyStoreFactory_FWD_DEFINED__
#define __IDelayedPropertyStoreFactory_FWD_DEFINED__
#define __IPersistSerializedPropStorage_FWD_DEFINED__
#define __IPersistSerializedPropStorage2_FWD_DEFINED__
#define __IPropertySystemChangeNotify_FWD_DEFINED__
#define __ICreateObject_FWD_DEFINED__
#define __InMemoryPropertyStore_FWD_DEFINED__
#define __PropertySystem_FWD_DEFINED__
#define __IInitializeWithFile_INTERFACE_DEFINED__
extern IID_IInitializeWithFile as const GUID
type IInitializeWithFile as IInitializeWithFile_

type IInitializeWithFileVtbl
	QueryInterface as function(byval This as IInitializeWithFile ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IInitializeWithFile ptr) as ULONG
	Release as function(byval This as IInitializeWithFile ptr) as ULONG
	Initialize as function(byval This as IInitializeWithFile ptr, byval pszFilePath as LPCWSTR, byval grfMode as DWORD) as HRESULT
end type

type IInitializeWithFile_
	lpVtbl as IInitializeWithFileVtbl ptr
end type

#define IInitializeWithFile_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IInitializeWithFile_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IInitializeWithFile_Release(This) (This)->lpVtbl->Release(This)
#define IInitializeWithFile_Initialize(This, pszFilePath, grfMode) (This)->lpVtbl->Initialize(This, pszFilePath, grfMode)
declare function IInitializeWithFile_Initialize_Proxy(byval This as IInitializeWithFile ptr, byval pszFilePath as LPCWSTR, byval grfMode as DWORD) as HRESULT
declare sub IInitializeWithFile_Initialize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IInitializeWithStream_INTERFACE_DEFINED__
extern IID_IInitializeWithStream as const GUID
type IInitializeWithStream as IInitializeWithStream_

type IInitializeWithStreamVtbl
	QueryInterface as function(byval This as IInitializeWithStream ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IInitializeWithStream ptr) as ULONG
	Release as function(byval This as IInitializeWithStream ptr) as ULONG
	Initialize as function(byval This as IInitializeWithStream ptr, byval pstream as IStream ptr, byval grfMode as DWORD) as HRESULT
end type

type IInitializeWithStream_
	lpVtbl as IInitializeWithStreamVtbl ptr
end type

#define IInitializeWithStream_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IInitializeWithStream_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IInitializeWithStream_Release(This) (This)->lpVtbl->Release(This)
#define IInitializeWithStream_Initialize(This, pstream, grfMode) (This)->lpVtbl->Initialize(This, pstream, grfMode)

declare function IInitializeWithStream_RemoteInitialize_Proxy(byval This as IInitializeWithStream ptr, byval pstream as IStream ptr, byval grfMode as DWORD) as HRESULT
declare sub IInitializeWithStream_RemoteInitialize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInitializeWithStream_Initialize_Proxy(byval This as IInitializeWithStream ptr, byval pstream as IStream ptr, byval grfMode as DWORD) as HRESULT
declare function IInitializeWithStream_Initialize_Stub(byval This as IInitializeWithStream ptr, byval pstream as IStream ptr, byval grfMode as DWORD) as HRESULT
#define __IPropertyStore_INTERFACE_DEFINED__
extern IID_IPropertyStore as const GUID
type IPropertyStore as IPropertyStore_

type IPropertyStoreVtbl
	QueryInterface as function(byval This as IPropertyStore ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPropertyStore ptr) as ULONG
	Release as function(byval This as IPropertyStore ptr) as ULONG
	GetCount as function(byval This as IPropertyStore ptr, byval cProps as DWORD ptr) as HRESULT
	GetAt as function(byval This as IPropertyStore ptr, byval iProp as DWORD, byval pkey as PROPERTYKEY ptr) as HRESULT
	GetValue as function(byval This as IPropertyStore ptr, byval key as const PROPERTYKEY const ptr, byval pv as PROPVARIANT ptr) as HRESULT
	SetValue as function(byval This as IPropertyStore ptr, byval key as const PROPERTYKEY const ptr, byval propvar as const PROPVARIANT const ptr) as HRESULT
	Commit as function(byval This as IPropertyStore ptr) as HRESULT
end type

type IPropertyStore_
	lpVtbl as IPropertyStoreVtbl ptr
end type

#define IPropertyStore_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPropertyStore_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPropertyStore_Release(This) (This)->lpVtbl->Release(This)
#define IPropertyStore_GetCount(This, cProps) (This)->lpVtbl->GetCount(This, cProps)
#define IPropertyStore_GetAt(This, iProp, pkey) (This)->lpVtbl->GetAt(This, iProp, pkey)
#define IPropertyStore_GetValue(This, key, pv) (This)->lpVtbl->GetValue(This, key, pv)
#define IPropertyStore_SetValue(This, key, propvar) (This)->lpVtbl->SetValue(This, key, propvar)
#define IPropertyStore_Commit(This) (This)->lpVtbl->Commit(This)

declare function IPropertyStore_GetCount_Proxy(byval This as IPropertyStore ptr, byval cProps as DWORD ptr) as HRESULT
declare sub IPropertyStore_GetCount_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyStore_GetAt_Proxy(byval This as IPropertyStore ptr, byval iProp as DWORD, byval pkey as PROPERTYKEY ptr) as HRESULT
declare sub IPropertyStore_GetAt_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyStore_GetValue_Proxy(byval This as IPropertyStore ptr, byval key as const PROPERTYKEY const ptr, byval pv as PROPVARIANT ptr) as HRESULT
declare sub IPropertyStore_GetValue_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyStore_SetValue_Proxy(byval This as IPropertyStore ptr, byval key as const PROPERTYKEY const ptr, byval propvar as const PROPVARIANT const ptr) as HRESULT
declare sub IPropertyStore_SetValue_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyStore_Commit_Proxy(byval This as IPropertyStore ptr) as HRESULT
declare sub IPropertyStore_Commit_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
type LPPROPERTYSTORE as IPropertyStore ptr
#define __INamedPropertyStore_INTERFACE_DEFINED__
extern IID_INamedPropertyStore as const GUID
type INamedPropertyStore as INamedPropertyStore_

type INamedPropertyStoreVtbl
	QueryInterface as function(byval This as INamedPropertyStore ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as INamedPropertyStore ptr) as ULONG
	Release as function(byval This as INamedPropertyStore ptr) as ULONG
	GetNamedValue as function(byval This as INamedPropertyStore ptr, byval pszName as LPCWSTR, byval ppropvar as PROPVARIANT ptr) as HRESULT
	SetNamedValue as function(byval This as INamedPropertyStore ptr, byval pszName as LPCWSTR, byval propvar as const PROPVARIANT const ptr) as HRESULT
	GetNameCount as function(byval This as INamedPropertyStore ptr, byval pdwCount as DWORD ptr) as HRESULT
	GetNameAt as function(byval This as INamedPropertyStore ptr, byval iProp as DWORD, byval pbstrName as BSTR ptr) as HRESULT
end type

type INamedPropertyStore_
	lpVtbl as INamedPropertyStoreVtbl ptr
end type

#define INamedPropertyStore_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define INamedPropertyStore_AddRef(This) (This)->lpVtbl->AddRef(This)
#define INamedPropertyStore_Release(This) (This)->lpVtbl->Release(This)
#define INamedPropertyStore_GetNamedValue(This, pszName, ppropvar) (This)->lpVtbl->GetNamedValue(This, pszName, ppropvar)
#define INamedPropertyStore_SetNamedValue(This, pszName, propvar) (This)->lpVtbl->SetNamedValue(This, pszName, propvar)
#define INamedPropertyStore_GetNameCount(This, pdwCount) (This)->lpVtbl->GetNameCount(This, pdwCount)
#define INamedPropertyStore_GetNameAt(This, iProp, pbstrName) (This)->lpVtbl->GetNameAt(This, iProp, pbstrName)

declare function INamedPropertyStore_GetNamedValue_Proxy(byval This as INamedPropertyStore ptr, byval pszName as LPCWSTR, byval ppropvar as PROPVARIANT ptr) as HRESULT
declare sub INamedPropertyStore_GetNamedValue_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INamedPropertyStore_SetNamedValue_Proxy(byval This as INamedPropertyStore ptr, byval pszName as LPCWSTR, byval propvar as const PROPVARIANT const ptr) as HRESULT
declare sub INamedPropertyStore_SetNamedValue_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INamedPropertyStore_GetNameCount_Proxy(byval This as INamedPropertyStore ptr, byval pdwCount as DWORD ptr) as HRESULT
declare sub INamedPropertyStore_GetNameCount_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INamedPropertyStore_GetNameAt_Proxy(byval This as INamedPropertyStore ptr, byval iProp as DWORD, byval pbstrName as BSTR ptr) as HRESULT
declare sub INamedPropertyStore_GetNameAt_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type GETPROPERTYSTOREFLAGS as long
enum
	GPS_DEFAULT = &h0
	GPS_HANDLERPROPERTIESONLY = &h1
	GPS_READWRITE = &h2
	GPS_TEMPORARY = &h4
	GPS_FASTPROPERTIESONLY = &h8
	GPS_OPENSLOWITEM = &h10
	GPS_DELAYCREATION = &h20
	GPS_BESTEFFORT = &h40
	GPS_NO_OPLOCK = &h80
	GPS_PREFERQUERYPROPERTIES = &h100
	GPS_MASK_VALID = &h1ff
end enum

#define __IObjectWithPropertyKey_INTERFACE_DEFINED__
extern IID_IObjectWithPropertyKey as const GUID
type IObjectWithPropertyKey as IObjectWithPropertyKey_

type IObjectWithPropertyKeyVtbl
	QueryInterface as function(byval This as IObjectWithPropertyKey ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IObjectWithPropertyKey ptr) as ULONG
	Release as function(byval This as IObjectWithPropertyKey ptr) as ULONG
	SetPropertyKey as function(byval This as IObjectWithPropertyKey ptr, byval key as const PROPERTYKEY const ptr) as HRESULT
	GetPropertyKey as function(byval This as IObjectWithPropertyKey ptr, byval pkey as PROPERTYKEY ptr) as HRESULT
end type

type IObjectWithPropertyKey_
	lpVtbl as IObjectWithPropertyKeyVtbl ptr
end type

#define IObjectWithPropertyKey_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IObjectWithPropertyKey_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IObjectWithPropertyKey_Release(This) (This)->lpVtbl->Release(This)
#define IObjectWithPropertyKey_SetPropertyKey(This, key) (This)->lpVtbl->SetPropertyKey(This, key)
#define IObjectWithPropertyKey_GetPropertyKey(This, pkey) (This)->lpVtbl->GetPropertyKey(This, pkey)

declare function IObjectWithPropertyKey_SetPropertyKey_Proxy(byval This as IObjectWithPropertyKey ptr, byval key as const PROPERTYKEY const ptr) as HRESULT
declare sub IObjectWithPropertyKey_SetPropertyKey_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IObjectWithPropertyKey_GetPropertyKey_Proxy(byval This as IObjectWithPropertyKey ptr, byval pkey as PROPERTYKEY ptr) as HRESULT
declare sub IObjectWithPropertyKey_GetPropertyKey_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type PKA_FLAGS as long
enum
	PKA_SET = 0
	PKA_APPEND = 1
	PKA_DELETE = 2
end enum

#define __IPropertyChange_INTERFACE_DEFINED__
extern IID_IPropertyChange as const GUID
type IPropertyChange as IPropertyChange_

type IPropertyChangeVtbl
	QueryInterface as function(byval This as IPropertyChange ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPropertyChange ptr) as ULONG
	Release as function(byval This as IPropertyChange ptr) as ULONG
	SetPropertyKey as function(byval This as IPropertyChange ptr, byval key as const PROPERTYKEY const ptr) as HRESULT
	GetPropertyKey as function(byval This as IPropertyChange ptr, byval pkey as PROPERTYKEY ptr) as HRESULT
	ApplyToPropVariant as function(byval This as IPropertyChange ptr, byval propvarIn as const PROPVARIANT const ptr, byval ppropvarOut as PROPVARIANT ptr) as HRESULT
end type

type IPropertyChange_
	lpVtbl as IPropertyChangeVtbl ptr
end type

#define IPropertyChange_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPropertyChange_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPropertyChange_Release(This) (This)->lpVtbl->Release(This)
#define IPropertyChange_SetPropertyKey(This, key) (This)->lpVtbl->SetPropertyKey(This, key)
#define IPropertyChange_GetPropertyKey(This, pkey) (This)->lpVtbl->GetPropertyKey(This, pkey)
#define IPropertyChange_ApplyToPropVariant(This, propvarIn, ppropvarOut) (This)->lpVtbl->ApplyToPropVariant(This, propvarIn, ppropvarOut)
declare function IPropertyChange_ApplyToPropVariant_Proxy(byval This as IPropertyChange ptr, byval propvarIn as const PROPVARIANT const ptr, byval ppropvarOut as PROPVARIANT ptr) as HRESULT
declare sub IPropertyChange_ApplyToPropVariant_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPropertyChangeArray_INTERFACE_DEFINED__
extern IID_IPropertyChangeArray as const GUID
type IPropertyChangeArray as IPropertyChangeArray_

type IPropertyChangeArrayVtbl
	QueryInterface as function(byval This as IPropertyChangeArray ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPropertyChangeArray ptr) as ULONG
	Release as function(byval This as IPropertyChangeArray ptr) as ULONG
	GetCount as function(byval This as IPropertyChangeArray ptr, byval pcOperations as UINT ptr) as HRESULT
	GetAt as function(byval This as IPropertyChangeArray ptr, byval iIndex as UINT, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	InsertAt as function(byval This as IPropertyChangeArray ptr, byval iIndex as UINT, byval ppropChange as IPropertyChange ptr) as HRESULT
	Append as function(byval This as IPropertyChangeArray ptr, byval ppropChange as IPropertyChange ptr) as HRESULT
	AppendOrReplace as function(byval This as IPropertyChangeArray ptr, byval ppropChange as IPropertyChange ptr) as HRESULT
	RemoveAt as function(byval This as IPropertyChangeArray ptr, byval iIndex as UINT) as HRESULT
	IsKeyInArray as function(byval This as IPropertyChangeArray ptr, byval key as const PROPERTYKEY const ptr) as HRESULT
end type

type IPropertyChangeArray_
	lpVtbl as IPropertyChangeArrayVtbl ptr
end type

#define IPropertyChangeArray_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPropertyChangeArray_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPropertyChangeArray_Release(This) (This)->lpVtbl->Release(This)
#define IPropertyChangeArray_GetCount(This, pcOperations) (This)->lpVtbl->GetCount(This, pcOperations)
#define IPropertyChangeArray_GetAt(This, iIndex, riid, ppv) (This)->lpVtbl->GetAt(This, iIndex, riid, ppv)
#define IPropertyChangeArray_InsertAt(This, iIndex, ppropChange) (This)->lpVtbl->InsertAt(This, iIndex, ppropChange)
#define IPropertyChangeArray_Append(This, ppropChange) (This)->lpVtbl->Append(This, ppropChange)
#define IPropertyChangeArray_AppendOrReplace(This, ppropChange) (This)->lpVtbl->AppendOrReplace(This, ppropChange)
#define IPropertyChangeArray_RemoveAt(This, iIndex) (This)->lpVtbl->RemoveAt(This, iIndex)
#define IPropertyChangeArray_IsKeyInArray(This, key) (This)->lpVtbl->IsKeyInArray(This, key)

declare function IPropertyChangeArray_GetCount_Proxy(byval This as IPropertyChangeArray ptr, byval pcOperations as UINT ptr) as HRESULT
declare sub IPropertyChangeArray_GetCount_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyChangeArray_GetAt_Proxy(byval This as IPropertyChangeArray ptr, byval iIndex as UINT, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IPropertyChangeArray_GetAt_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyChangeArray_InsertAt_Proxy(byval This as IPropertyChangeArray ptr, byval iIndex as UINT, byval ppropChange as IPropertyChange ptr) as HRESULT
declare sub IPropertyChangeArray_InsertAt_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyChangeArray_Append_Proxy(byval This as IPropertyChangeArray ptr, byval ppropChange as IPropertyChange ptr) as HRESULT
declare sub IPropertyChangeArray_Append_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyChangeArray_AppendOrReplace_Proxy(byval This as IPropertyChangeArray ptr, byval ppropChange as IPropertyChange ptr) as HRESULT
declare sub IPropertyChangeArray_AppendOrReplace_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyChangeArray_RemoveAt_Proxy(byval This as IPropertyChangeArray ptr, byval iIndex as UINT) as HRESULT
declare sub IPropertyChangeArray_RemoveAt_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyChangeArray_IsKeyInArray_Proxy(byval This as IPropertyChangeArray ptr, byval key as const PROPERTYKEY const ptr) as HRESULT
declare sub IPropertyChangeArray_IsKeyInArray_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPropertyStoreCapabilities_INTERFACE_DEFINED__
extern IID_IPropertyStoreCapabilities as const GUID
type IPropertyStoreCapabilities as IPropertyStoreCapabilities_

type IPropertyStoreCapabilitiesVtbl
	QueryInterface as function(byval This as IPropertyStoreCapabilities ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPropertyStoreCapabilities ptr) as ULONG
	Release as function(byval This as IPropertyStoreCapabilities ptr) as ULONG
	IsPropertyWritable as function(byval This as IPropertyStoreCapabilities ptr, byval key as const PROPERTYKEY const ptr) as HRESULT
end type

type IPropertyStoreCapabilities_
	lpVtbl as IPropertyStoreCapabilitiesVtbl ptr
end type

#define IPropertyStoreCapabilities_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPropertyStoreCapabilities_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPropertyStoreCapabilities_Release(This) (This)->lpVtbl->Release(This)
#define IPropertyStoreCapabilities_IsPropertyWritable(This, key) (This)->lpVtbl->IsPropertyWritable(This, key)
declare function IPropertyStoreCapabilities_IsPropertyWritable_Proxy(byval This as IPropertyStoreCapabilities ptr, byval key as const PROPERTYKEY const ptr) as HRESULT
declare sub IPropertyStoreCapabilities_IsPropertyWritable_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPropertyStoreCache_INTERFACE_DEFINED__

type PSC_STATE as long
enum
	PSC_NORMAL = 0
	PSC_NOTINSOURCE = 1
	PSC_DIRTY = 2
	PSC_READONLY = 3
end enum

extern IID_IPropertyStoreCache as const GUID
type IPropertyStoreCache as IPropertyStoreCache_

type IPropertyStoreCacheVtbl
	QueryInterface as function(byval This as IPropertyStoreCache ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPropertyStoreCache ptr) as ULONG
	Release as function(byval This as IPropertyStoreCache ptr) as ULONG
	GetCount as function(byval This as IPropertyStoreCache ptr, byval cProps as DWORD ptr) as HRESULT
	GetAt as function(byval This as IPropertyStoreCache ptr, byval iProp as DWORD, byval pkey as PROPERTYKEY ptr) as HRESULT
	GetValue as function(byval This as IPropertyStoreCache ptr, byval key as const PROPERTYKEY const ptr, byval pv as PROPVARIANT ptr) as HRESULT
	SetValue as function(byval This as IPropertyStoreCache ptr, byval key as const PROPERTYKEY const ptr, byval propvar as const PROPVARIANT const ptr) as HRESULT
	Commit as function(byval This as IPropertyStoreCache ptr) as HRESULT
	GetState as function(byval This as IPropertyStoreCache ptr, byval key as const PROPERTYKEY const ptr, byval pstate as PSC_STATE ptr) as HRESULT
	GetValueAndState as function(byval This as IPropertyStoreCache ptr, byval key as const PROPERTYKEY const ptr, byval ppropvar as PROPVARIANT ptr, byval pstate as PSC_STATE ptr) as HRESULT
	SetState as function(byval This as IPropertyStoreCache ptr, byval key as const PROPERTYKEY const ptr, byval state as PSC_STATE) as HRESULT
	SetValueAndState as function(byval This as IPropertyStoreCache ptr, byval key as const PROPERTYKEY const ptr, byval ppropvar as const PROPVARIANT ptr, byval state as PSC_STATE) as HRESULT
end type

type IPropertyStoreCache_
	lpVtbl as IPropertyStoreCacheVtbl ptr
end type

#define IPropertyStoreCache_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPropertyStoreCache_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPropertyStoreCache_Release(This) (This)->lpVtbl->Release(This)
#define IPropertyStoreCache_GetCount(This, cProps) (This)->lpVtbl->GetCount(This, cProps)
#define IPropertyStoreCache_GetAt(This, iProp, pkey) (This)->lpVtbl->GetAt(This, iProp, pkey)
#define IPropertyStoreCache_GetValue(This, key, pv) (This)->lpVtbl->GetValue(This, key, pv)
#define IPropertyStoreCache_SetValue(This, key, propvar) (This)->lpVtbl->SetValue(This, key, propvar)
#define IPropertyStoreCache_Commit(This) (This)->lpVtbl->Commit(This)
#define IPropertyStoreCache_GetState(This, key, pstate) (This)->lpVtbl->GetState(This, key, pstate)
#define IPropertyStoreCache_GetValueAndState(This, key, ppropvar, pstate) (This)->lpVtbl->GetValueAndState(This, key, ppropvar, pstate)
#define IPropertyStoreCache_SetState(This, key, state) (This)->lpVtbl->SetState(This, key, state)
#define IPropertyStoreCache_SetValueAndState(This, key, ppropvar, state) (This)->lpVtbl->SetValueAndState(This, key, ppropvar, state)

declare function IPropertyStoreCache_GetState_Proxy(byval This as IPropertyStoreCache ptr, byval key as const PROPERTYKEY const ptr, byval pstate as PSC_STATE ptr) as HRESULT
declare sub IPropertyStoreCache_GetState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyStoreCache_GetValueAndState_Proxy(byval This as IPropertyStoreCache ptr, byval key as const PROPERTYKEY const ptr, byval ppropvar as PROPVARIANT ptr, byval pstate as PSC_STATE ptr) as HRESULT
declare sub IPropertyStoreCache_GetValueAndState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyStoreCache_SetState_Proxy(byval This as IPropertyStoreCache ptr, byval key as const PROPERTYKEY const ptr, byval state as PSC_STATE) as HRESULT
declare sub IPropertyStoreCache_SetState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyStoreCache_SetValueAndState_Proxy(byval This as IPropertyStoreCache ptr, byval key as const PROPERTYKEY const ptr, byval ppropvar as const PROPVARIANT ptr, byval state as PSC_STATE) as HRESULT
declare sub IPropertyStoreCache_SetValueAndState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPropertyEnumType_INTERFACE_DEFINED__

type PROPENUMTYPE as long
enum
	PET_DISCRETEVALUE = 0
	PET_RANGEDVALUE = 1
	PET_DEFAULTVALUE = 2
	PET_ENDRANGE = 3
end enum

extern IID_IPropertyEnumType as const GUID
type IPropertyEnumType as IPropertyEnumType_

type IPropertyEnumTypeVtbl
	QueryInterface as function(byval This as IPropertyEnumType ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPropertyEnumType ptr) as ULONG
	Release as function(byval This as IPropertyEnumType ptr) as ULONG
	GetEnumType as function(byval This as IPropertyEnumType ptr, byval penumtype as PROPENUMTYPE ptr) as HRESULT
	GetValue as function(byval This as IPropertyEnumType ptr, byval ppropvar as PROPVARIANT ptr) as HRESULT
	GetRangeMinValue as function(byval This as IPropertyEnumType ptr, byval ppropvarMin as PROPVARIANT ptr) as HRESULT
	GetRangeSetValue as function(byval This as IPropertyEnumType ptr, byval ppropvarSet as PROPVARIANT ptr) as HRESULT
	GetDisplayText as function(byval This as IPropertyEnumType ptr, byval ppszDisplay as LPWSTR ptr) as HRESULT
end type

type IPropertyEnumType_
	lpVtbl as IPropertyEnumTypeVtbl ptr
end type

#define IPropertyEnumType_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPropertyEnumType_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPropertyEnumType_Release(This) (This)->lpVtbl->Release(This)
#define IPropertyEnumType_GetEnumType(This, penumtype) (This)->lpVtbl->GetEnumType(This, penumtype)
#define IPropertyEnumType_GetValue(This, ppropvar) (This)->lpVtbl->GetValue(This, ppropvar)
#define IPropertyEnumType_GetRangeMinValue(This, ppropvarMin) (This)->lpVtbl->GetRangeMinValue(This, ppropvarMin)
#define IPropertyEnumType_GetRangeSetValue(This, ppropvarSet) (This)->lpVtbl->GetRangeSetValue(This, ppropvarSet)
#define IPropertyEnumType_GetDisplayText(This, ppszDisplay) (This)->lpVtbl->GetDisplayText(This, ppszDisplay)

declare function IPropertyEnumType_GetEnumType_Proxy(byval This as IPropertyEnumType ptr, byval penumtype as PROPENUMTYPE ptr) as HRESULT
declare sub IPropertyEnumType_GetEnumType_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyEnumType_GetValue_Proxy(byval This as IPropertyEnumType ptr, byval ppropvar as PROPVARIANT ptr) as HRESULT
declare sub IPropertyEnumType_GetValue_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyEnumType_GetRangeMinValue_Proxy(byval This as IPropertyEnumType ptr, byval ppropvarMin as PROPVARIANT ptr) as HRESULT
declare sub IPropertyEnumType_GetRangeMinValue_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyEnumType_GetRangeSetValue_Proxy(byval This as IPropertyEnumType ptr, byval ppropvarSet as PROPVARIANT ptr) as HRESULT
declare sub IPropertyEnumType_GetRangeSetValue_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyEnumType_GetDisplayText_Proxy(byval This as IPropertyEnumType ptr, byval ppszDisplay as LPWSTR ptr) as HRESULT
declare sub IPropertyEnumType_GetDisplayText_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPropertyEnumType2_INTERFACE_DEFINED__
extern IID_IPropertyEnumType2 as const GUID
type IPropertyEnumType2 as IPropertyEnumType2_

type IPropertyEnumType2Vtbl
	QueryInterface as function(byval This as IPropertyEnumType2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPropertyEnumType2 ptr) as ULONG
	Release as function(byval This as IPropertyEnumType2 ptr) as ULONG
	GetEnumType as function(byval This as IPropertyEnumType2 ptr, byval penumtype as PROPENUMTYPE ptr) as HRESULT
	GetValue as function(byval This as IPropertyEnumType2 ptr, byval ppropvar as PROPVARIANT ptr) as HRESULT
	GetRangeMinValue as function(byval This as IPropertyEnumType2 ptr, byval ppropvarMin as PROPVARIANT ptr) as HRESULT
	GetRangeSetValue as function(byval This as IPropertyEnumType2 ptr, byval ppropvarSet as PROPVARIANT ptr) as HRESULT
	GetDisplayText as function(byval This as IPropertyEnumType2 ptr, byval ppszDisplay as LPWSTR ptr) as HRESULT
	GetImageReference as function(byval This as IPropertyEnumType2 ptr, byval ppszImageRes as LPWSTR ptr) as HRESULT
end type

type IPropertyEnumType2_
	lpVtbl as IPropertyEnumType2Vtbl ptr
end type

#define IPropertyEnumType2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPropertyEnumType2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPropertyEnumType2_Release(This) (This)->lpVtbl->Release(This)
#define IPropertyEnumType2_GetEnumType(This, penumtype) (This)->lpVtbl->GetEnumType(This, penumtype)
#define IPropertyEnumType2_GetValue(This, ppropvar) (This)->lpVtbl->GetValue(This, ppropvar)
#define IPropertyEnumType2_GetRangeMinValue(This, ppropvarMin) (This)->lpVtbl->GetRangeMinValue(This, ppropvarMin)
#define IPropertyEnumType2_GetRangeSetValue(This, ppropvarSet) (This)->lpVtbl->GetRangeSetValue(This, ppropvarSet)
#define IPropertyEnumType2_GetDisplayText(This, ppszDisplay) (This)->lpVtbl->GetDisplayText(This, ppszDisplay)
#define IPropertyEnumType2_GetImageReference(This, ppszImageRes) (This)->lpVtbl->GetImageReference(This, ppszImageRes)
declare function IPropertyEnumType2_GetImageReference_Proxy(byval This as IPropertyEnumType2 ptr, byval ppszImageRes as LPWSTR ptr) as HRESULT
declare sub IPropertyEnumType2_GetImageReference_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPropertyEnumTypeList_INTERFACE_DEFINED__
extern IID_IPropertyEnumTypeList as const GUID
type IPropertyEnumTypeList as IPropertyEnumTypeList_

type IPropertyEnumTypeListVtbl
	QueryInterface as function(byval This as IPropertyEnumTypeList ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPropertyEnumTypeList ptr) as ULONG
	Release as function(byval This as IPropertyEnumTypeList ptr) as ULONG
	GetCount as function(byval This as IPropertyEnumTypeList ptr, byval pctypes as UINT ptr) as HRESULT
	GetAt as function(byval This as IPropertyEnumTypeList ptr, byval itype as UINT, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	GetConditionAt as function(byval This as IPropertyEnumTypeList ptr, byval nIndex as UINT, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	FindMatchingIndex as function(byval This as IPropertyEnumTypeList ptr, byval propvarCmp as const PROPVARIANT const ptr, byval pnIndex as UINT ptr) as HRESULT
end type

type IPropertyEnumTypeList_
	lpVtbl as IPropertyEnumTypeListVtbl ptr
end type

#define IPropertyEnumTypeList_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPropertyEnumTypeList_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPropertyEnumTypeList_Release(This) (This)->lpVtbl->Release(This)
#define IPropertyEnumTypeList_GetCount(This, pctypes) (This)->lpVtbl->GetCount(This, pctypes)
#define IPropertyEnumTypeList_GetAt(This, itype, riid, ppv) (This)->lpVtbl->GetAt(This, itype, riid, ppv)
#define IPropertyEnumTypeList_GetConditionAt(This, nIndex, riid, ppv) (This)->lpVtbl->GetConditionAt(This, nIndex, riid, ppv)
#define IPropertyEnumTypeList_FindMatchingIndex(This, propvarCmp, pnIndex) (This)->lpVtbl->FindMatchingIndex(This, propvarCmp, pnIndex)

declare function IPropertyEnumTypeList_GetCount_Proxy(byval This as IPropertyEnumTypeList ptr, byval pctypes as UINT ptr) as HRESULT
declare sub IPropertyEnumTypeList_GetCount_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyEnumTypeList_GetAt_Proxy(byval This as IPropertyEnumTypeList ptr, byval itype as UINT, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IPropertyEnumTypeList_GetAt_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyEnumTypeList_GetConditionAt_Proxy(byval This as IPropertyEnumTypeList ptr, byval nIndex as UINT, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IPropertyEnumTypeList_GetConditionAt_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyEnumTypeList_FindMatchingIndex_Proxy(byval This as IPropertyEnumTypeList ptr, byval propvarCmp as const PROPVARIANT const ptr, byval pnIndex as UINT ptr) as HRESULT
declare sub IPropertyEnumTypeList_FindMatchingIndex_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPropertyDescription_INTERFACE_DEFINED__

type PROPDESC_TYPE_FLAGS as long
enum
	PDTF_DEFAULT = &h0
	PDTF_MULTIPLEVALUES = &h1
	PDTF_ISINNATE = &h2
	PDTF_ISGROUP = &h4
	PDTF_CANGROUPBY = &h8
	PDTF_CANSTACKBY = &h10
	PDTF_ISTREEPROPERTY = &h20
	PDTF_INCLUDEINFULLTEXTQUERY = &h40
	PDTF_ISVIEWABLE = &h80
	PDTF_ISQUERYABLE = &h100
	PDTF_CANBEPURGED = &h200
	PDTF_SEARCHRAWVALUE = &h400
	PDTF_ISSYSTEMPROPERTY = &h80000000
	PDTF_MASK_ALL = &h800007ff
end enum

type PROPDESC_VIEW_FLAGS as long
enum
	PDVF_DEFAULT = &h0
	PDVF_CENTERALIGN = &h1
	PDVF_RIGHTALIGN = &h2
	PDVF_BEGINNEWGROUP = &h4
	PDVF_FILLAREA = &h8
	PDVF_SORTDESCENDING = &h10
	PDVF_SHOWONLYIFPRESENT = &h20
	PDVF_SHOWBYDEFAULT = &h40
	PDVF_SHOWINPRIMARYLIST = &h80
	PDVF_SHOWINSECONDARYLIST = &h100
	PDVF_HIDELABEL = &h200
	PDVF_HIDDEN = &h800
	PDVF_CANWRAP = &h1000
	PDVF_MASK_ALL = &h1bff
end enum

type PROPDESC_DISPLAYTYPE as long
enum
	PDDT_STRING = 0
	PDDT_NUMBER = 1
	PDDT_BOOLEAN = 2
	PDDT_DATETIME = 3
	PDDT_ENUMERATED = 4
end enum

type PROPDESC_GROUPING_RANGE as long
enum
	PDGR_DISCRETE = 0
	PDGR_ALPHANUMERIC = 1
	PDGR_SIZE = 2
	PDGR_DYNAMIC = 3
	PDGR_DATE = 4
	PDGR_PERCENT = 5
	PDGR_ENUMERATED = 6
end enum

type PROPDESC_FORMAT_FLAGS as long
enum
	PDFF_DEFAULT = &h0
	PDFF_PREFIXNAME = &h1
	PDFF_FILENAME = &h2
	PDFF_ALWAYSKB = &h4
	PDFF_RESERVED_RIGHTTOLEFT = &h8
	PDFF_SHORTTIME = &h10
	PDFF_LONGTIME = &h20
	PDFF_HIDETIME = &h40
	PDFF_SHORTDATE = &h80
	PDFF_LONGDATE = &h100
	PDFF_HIDEDATE = &h200
	PDFF_RELATIVEDATE = &h400
	PDFF_USEEDITINVITATION = &h800
	PDFF_READONLY = &h1000
	PDFF_NOAUTOREADINGORDER = &h2000
end enum

type PROPDESC_SORTDESCRIPTION as long
enum
	PDSD_GENERAL = 0
	PDSD_A_Z = 1
	PDSD_LOWEST_HIGHEST = 2
	PDSD_SMALLEST_BIGGEST = 3
	PDSD_OLDEST_NEWEST = 4
end enum

type PROPDESC_RELATIVEDESCRIPTION_TYPE as long
enum
	PDRDT_GENERAL = 0
	PDRDT_DATE = 1
	PDRDT_SIZE = 2
	PDRDT_COUNT = 3
	PDRDT_REVISION = 4
	PDRDT_LENGTH = 5
	PDRDT_DURATION = 6
	PDRDT_SPEED = 7
	PDRDT_RATE = 8
	PDRDT_RATING = 9
	PDRDT_PRIORITY = 10
end enum

type PROPDESC_AGGREGATION_TYPE as long
enum
	PDAT_DEFAULT = 0
	PDAT_FIRST = 1
	PDAT_SUM = 2
	PDAT_AVERAGE = 3
	PDAT_DATERANGE = 4
	PDAT_UNION = 5
	PDAT_MAX = 6
	PDAT_MIN = 7
end enum

type PROPDESC_CONDITION_TYPE as long
enum
	PDCOT_NONE = 0
	PDCOT_STRING = 1
	PDCOT_SIZE = 2
	PDCOT_DATETIME = 3
	PDCOT_BOOLEAN = 4
	PDCOT_NUMBER = 5
end enum

extern IID_IPropertyDescription as const GUID
type IPropertyDescription as IPropertyDescription_

type IPropertyDescriptionVtbl
	QueryInterface as function(byval This as IPropertyDescription ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPropertyDescription ptr) as ULONG
	Release as function(byval This as IPropertyDescription ptr) as ULONG
	GetPropertyKey as function(byval This as IPropertyDescription ptr, byval pkey as PROPERTYKEY ptr) as HRESULT
	GetCanonicalName as function(byval This as IPropertyDescription ptr, byval ppszName as LPWSTR ptr) as HRESULT
	GetPropertyType as function(byval This as IPropertyDescription ptr, byval pvartype as VARTYPE ptr) as HRESULT
	GetDisplayName as function(byval This as IPropertyDescription ptr, byval ppszName as LPWSTR ptr) as HRESULT
	GetEditInvitation as function(byval This as IPropertyDescription ptr, byval ppszInvite as LPWSTR ptr) as HRESULT
	GetTypeFlags as function(byval This as IPropertyDescription ptr, byval mask as PROPDESC_TYPE_FLAGS, byval ppdtFlags as PROPDESC_TYPE_FLAGS ptr) as HRESULT
	GetViewFlags as function(byval This as IPropertyDescription ptr, byval ppdvFlags as PROPDESC_VIEW_FLAGS ptr) as HRESULT
	GetDefaultColumnWidth as function(byval This as IPropertyDescription ptr, byval pcxChars as UINT ptr) as HRESULT
	GetDisplayType as function(byval This as IPropertyDescription ptr, byval pdisplaytype as PROPDESC_DISPLAYTYPE ptr) as HRESULT
	GetColumnState as function(byval This as IPropertyDescription ptr, byval pcsFlags as SHCOLSTATEF ptr) as HRESULT
	GetGroupingRange as function(byval This as IPropertyDescription ptr, byval pgr as PROPDESC_GROUPING_RANGE ptr) as HRESULT
	GetRelativeDescriptionType as function(byval This as IPropertyDescription ptr, byval prdt as PROPDESC_RELATIVEDESCRIPTION_TYPE ptr) as HRESULT
	GetRelativeDescription as function(byval This as IPropertyDescription ptr, byval propvar1 as const PROPVARIANT const ptr, byval propvar2 as const PROPVARIANT const ptr, byval ppszDesc1 as LPWSTR ptr, byval ppszDesc2 as LPWSTR ptr) as HRESULT
	GetSortDescription as function(byval This as IPropertyDescription ptr, byval psd as PROPDESC_SORTDESCRIPTION ptr) as HRESULT
	GetSortDescriptionLabel as function(byval This as IPropertyDescription ptr, byval fDescending as WINBOOL, byval ppszDescription as LPWSTR ptr) as HRESULT
	GetAggregationType as function(byval This as IPropertyDescription ptr, byval paggtype as PROPDESC_AGGREGATION_TYPE ptr) as HRESULT
	GetConditionType as function(byval This as IPropertyDescription ptr, byval pcontype as PROPDESC_CONDITION_TYPE ptr, byval popDefault as CONDITION_OPERATION ptr) as HRESULT
	GetEnumTypeList as function(byval This as IPropertyDescription ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	CoerceToCanonicalValue as function(byval This as IPropertyDescription ptr, byval ppropvar as PROPVARIANT ptr) as HRESULT
	FormatForDisplay as function(byval This as IPropertyDescription ptr, byval propvar as const PROPVARIANT const ptr, byval pdfFlags as PROPDESC_FORMAT_FLAGS, byval ppszDisplay as LPWSTR ptr) as HRESULT
	IsValueCanonical as function(byval This as IPropertyDescription ptr, byval propvar as const PROPVARIANT const ptr) as HRESULT
end type

type IPropertyDescription_
	lpVtbl as IPropertyDescriptionVtbl ptr
end type

#define IPropertyDescription_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPropertyDescription_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPropertyDescription_Release(This) (This)->lpVtbl->Release(This)
#define IPropertyDescription_GetPropertyKey(This, pkey) (This)->lpVtbl->GetPropertyKey(This, pkey)
#define IPropertyDescription_GetCanonicalName(This, ppszName) (This)->lpVtbl->GetCanonicalName(This, ppszName)
#define IPropertyDescription_GetPropertyType(This, pvartype) (This)->lpVtbl->GetPropertyType(This, pvartype)
#define IPropertyDescription_GetDisplayName(This, ppszName) (This)->lpVtbl->GetDisplayName(This, ppszName)
#define IPropertyDescription_GetEditInvitation(This, ppszInvite) (This)->lpVtbl->GetEditInvitation(This, ppszInvite)
#define IPropertyDescription_GetTypeFlags(This, mask, ppdtFlags) (This)->lpVtbl->GetTypeFlags(This, mask, ppdtFlags)
#define IPropertyDescription_GetViewFlags(This, ppdvFlags) (This)->lpVtbl->GetViewFlags(This, ppdvFlags)
#define IPropertyDescription_GetDefaultColumnWidth(This, pcxChars) (This)->lpVtbl->GetDefaultColumnWidth(This, pcxChars)
#define IPropertyDescription_GetDisplayType(This, pdisplaytype) (This)->lpVtbl->GetDisplayType(This, pdisplaytype)
#define IPropertyDescription_GetColumnState(This, pcsFlags) (This)->lpVtbl->GetColumnState(This, pcsFlags)
#define IPropertyDescription_GetGroupingRange(This, pgr) (This)->lpVtbl->GetGroupingRange(This, pgr)
#define IPropertyDescription_GetRelativeDescriptionType(This, prdt) (This)->lpVtbl->GetRelativeDescriptionType(This, prdt)
#define IPropertyDescription_GetRelativeDescription(This, propvar1, propvar2, ppszDesc1, ppszDesc2) (This)->lpVtbl->GetRelativeDescription(This, propvar1, propvar2, ppszDesc1, ppszDesc2)
#define IPropertyDescription_GetSortDescription(This, psd) (This)->lpVtbl->GetSortDescription(This, psd)
#define IPropertyDescription_GetSortDescriptionLabel(This, fDescending, ppszDescription) (This)->lpVtbl->GetSortDescriptionLabel(This, fDescending, ppszDescription)
#define IPropertyDescription_GetAggregationType(This, paggtype) (This)->lpVtbl->GetAggregationType(This, paggtype)
#define IPropertyDescription_GetConditionType(This, pcontype, popDefault) (This)->lpVtbl->GetConditionType(This, pcontype, popDefault)
#define IPropertyDescription_GetEnumTypeList(This, riid, ppv) (This)->lpVtbl->GetEnumTypeList(This, riid, ppv)
#define IPropertyDescription_CoerceToCanonicalValue(This, ppropvar) (This)->lpVtbl->CoerceToCanonicalValue(This, ppropvar)
#define IPropertyDescription_FormatForDisplay(This, propvar, pdfFlags, ppszDisplay) (This)->lpVtbl->FormatForDisplay(This, propvar, pdfFlags, ppszDisplay)
#define IPropertyDescription_IsValueCanonical(This, propvar) (This)->lpVtbl->IsValueCanonical(This, propvar)

declare function IPropertyDescription_GetPropertyKey_Proxy(byval This as IPropertyDescription ptr, byval pkey as PROPERTYKEY ptr) as HRESULT
declare sub IPropertyDescription_GetPropertyKey_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyDescription_GetCanonicalName_Proxy(byval This as IPropertyDescription ptr, byval ppszName as LPWSTR ptr) as HRESULT
declare sub IPropertyDescription_GetCanonicalName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyDescription_GetPropertyType_Proxy(byval This as IPropertyDescription ptr, byval pvartype as VARTYPE ptr) as HRESULT
declare sub IPropertyDescription_GetPropertyType_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyDescription_GetDisplayName_Proxy(byval This as IPropertyDescription ptr, byval ppszName as LPWSTR ptr) as HRESULT
declare sub IPropertyDescription_GetDisplayName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyDescription_GetEditInvitation_Proxy(byval This as IPropertyDescription ptr, byval ppszInvite as LPWSTR ptr) as HRESULT
declare sub IPropertyDescription_GetEditInvitation_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyDescription_GetTypeFlags_Proxy(byval This as IPropertyDescription ptr, byval mask as PROPDESC_TYPE_FLAGS, byval ppdtFlags as PROPDESC_TYPE_FLAGS ptr) as HRESULT
declare sub IPropertyDescription_GetTypeFlags_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyDescription_GetViewFlags_Proxy(byval This as IPropertyDescription ptr, byval ppdvFlags as PROPDESC_VIEW_FLAGS ptr) as HRESULT
declare sub IPropertyDescription_GetViewFlags_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyDescription_GetDefaultColumnWidth_Proxy(byval This as IPropertyDescription ptr, byval pcxChars as UINT ptr) as HRESULT
declare sub IPropertyDescription_GetDefaultColumnWidth_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyDescription_GetDisplayType_Proxy(byval This as IPropertyDescription ptr, byval pdisplaytype as PROPDESC_DISPLAYTYPE ptr) as HRESULT
declare sub IPropertyDescription_GetDisplayType_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyDescription_GetColumnState_Proxy(byval This as IPropertyDescription ptr, byval pcsFlags as SHCOLSTATEF ptr) as HRESULT
declare sub IPropertyDescription_GetColumnState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyDescription_GetGroupingRange_Proxy(byval This as IPropertyDescription ptr, byval pgr as PROPDESC_GROUPING_RANGE ptr) as HRESULT
declare sub IPropertyDescription_GetGroupingRange_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyDescription_GetRelativeDescriptionType_Proxy(byval This as IPropertyDescription ptr, byval prdt as PROPDESC_RELATIVEDESCRIPTION_TYPE ptr) as HRESULT
declare sub IPropertyDescription_GetRelativeDescriptionType_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyDescription_GetRelativeDescription_Proxy(byval This as IPropertyDescription ptr, byval propvar1 as const PROPVARIANT const ptr, byval propvar2 as const PROPVARIANT const ptr, byval ppszDesc1 as LPWSTR ptr, byval ppszDesc2 as LPWSTR ptr) as HRESULT
declare sub IPropertyDescription_GetRelativeDescription_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyDescription_GetSortDescription_Proxy(byval This as IPropertyDescription ptr, byval psd as PROPDESC_SORTDESCRIPTION ptr) as HRESULT
declare sub IPropertyDescription_GetSortDescription_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyDescription_GetSortDescriptionLabel_Proxy(byval This as IPropertyDescription ptr, byval fDescending as WINBOOL, byval ppszDescription as LPWSTR ptr) as HRESULT
declare sub IPropertyDescription_GetSortDescriptionLabel_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyDescription_GetAggregationType_Proxy(byval This as IPropertyDescription ptr, byval paggtype as PROPDESC_AGGREGATION_TYPE ptr) as HRESULT
declare sub IPropertyDescription_GetAggregationType_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyDescription_GetConditionType_Proxy(byval This as IPropertyDescription ptr, byval pcontype as PROPDESC_CONDITION_TYPE ptr, byval popDefault as CONDITION_OPERATION ptr) as HRESULT
declare sub IPropertyDescription_GetConditionType_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyDescription_GetEnumTypeList_Proxy(byval This as IPropertyDescription ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IPropertyDescription_GetEnumTypeList_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyDescription_RemoteCoerceToCanonicalValue_Proxy(byval This as IPropertyDescription ptr, byval propvar as const PROPVARIANT const ptr, byval ppropvar as PROPVARIANT ptr) as HRESULT
declare sub IPropertyDescription_RemoteCoerceToCanonicalValue_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyDescription_FormatForDisplay_Proxy(byval This as IPropertyDescription ptr, byval propvar as const PROPVARIANT const ptr, byval pdfFlags as PROPDESC_FORMAT_FLAGS, byval ppszDisplay as LPWSTR ptr) as HRESULT
declare sub IPropertyDescription_FormatForDisplay_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyDescription_IsValueCanonical_Proxy(byval This as IPropertyDescription ptr, byval propvar as const PROPVARIANT const ptr) as HRESULT
declare sub IPropertyDescription_IsValueCanonical_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyDescription_CoerceToCanonicalValue_Proxy(byval This as IPropertyDescription ptr, byval ppropvar as PROPVARIANT ptr) as HRESULT
declare function IPropertyDescription_CoerceToCanonicalValue_Stub(byval This as IPropertyDescription ptr, byval propvar as const PROPVARIANT const ptr, byval ppropvar as PROPVARIANT ptr) as HRESULT
#define __IPropertyDescription2_INTERFACE_DEFINED__
extern IID_IPropertyDescription2 as const GUID
type IPropertyDescription2 as IPropertyDescription2_

type IPropertyDescription2Vtbl
	QueryInterface as function(byval This as IPropertyDescription2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPropertyDescription2 ptr) as ULONG
	Release as function(byval This as IPropertyDescription2 ptr) as ULONG
	GetPropertyKey as function(byval This as IPropertyDescription2 ptr, byval pkey as PROPERTYKEY ptr) as HRESULT
	GetCanonicalName as function(byval This as IPropertyDescription2 ptr, byval ppszName as LPWSTR ptr) as HRESULT
	GetPropertyType as function(byval This as IPropertyDescription2 ptr, byval pvartype as VARTYPE ptr) as HRESULT
	GetDisplayName as function(byval This as IPropertyDescription2 ptr, byval ppszName as LPWSTR ptr) as HRESULT
	GetEditInvitation as function(byval This as IPropertyDescription2 ptr, byval ppszInvite as LPWSTR ptr) as HRESULT
	GetTypeFlags as function(byval This as IPropertyDescription2 ptr, byval mask as PROPDESC_TYPE_FLAGS, byval ppdtFlags as PROPDESC_TYPE_FLAGS ptr) as HRESULT
	GetViewFlags as function(byval This as IPropertyDescription2 ptr, byval ppdvFlags as PROPDESC_VIEW_FLAGS ptr) as HRESULT
	GetDefaultColumnWidth as function(byval This as IPropertyDescription2 ptr, byval pcxChars as UINT ptr) as HRESULT
	GetDisplayType as function(byval This as IPropertyDescription2 ptr, byval pdisplaytype as PROPDESC_DISPLAYTYPE ptr) as HRESULT
	GetColumnState as function(byval This as IPropertyDescription2 ptr, byval pcsFlags as SHCOLSTATEF ptr) as HRESULT
	GetGroupingRange as function(byval This as IPropertyDescription2 ptr, byval pgr as PROPDESC_GROUPING_RANGE ptr) as HRESULT
	GetRelativeDescriptionType as function(byval This as IPropertyDescription2 ptr, byval prdt as PROPDESC_RELATIVEDESCRIPTION_TYPE ptr) as HRESULT
	GetRelativeDescription as function(byval This as IPropertyDescription2 ptr, byval propvar1 as const PROPVARIANT const ptr, byval propvar2 as const PROPVARIANT const ptr, byval ppszDesc1 as LPWSTR ptr, byval ppszDesc2 as LPWSTR ptr) as HRESULT
	GetSortDescription as function(byval This as IPropertyDescription2 ptr, byval psd as PROPDESC_SORTDESCRIPTION ptr) as HRESULT
	GetSortDescriptionLabel as function(byval This as IPropertyDescription2 ptr, byval fDescending as WINBOOL, byval ppszDescription as LPWSTR ptr) as HRESULT
	GetAggregationType as function(byval This as IPropertyDescription2 ptr, byval paggtype as PROPDESC_AGGREGATION_TYPE ptr) as HRESULT
	GetConditionType as function(byval This as IPropertyDescription2 ptr, byval pcontype as PROPDESC_CONDITION_TYPE ptr, byval popDefault as CONDITION_OPERATION ptr) as HRESULT
	GetEnumTypeList as function(byval This as IPropertyDescription2 ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	CoerceToCanonicalValue as function(byval This as IPropertyDescription2 ptr, byval ppropvar as PROPVARIANT ptr) as HRESULT
	FormatForDisplay as function(byval This as IPropertyDescription2 ptr, byval propvar as const PROPVARIANT const ptr, byval pdfFlags as PROPDESC_FORMAT_FLAGS, byval ppszDisplay as LPWSTR ptr) as HRESULT
	IsValueCanonical as function(byval This as IPropertyDescription2 ptr, byval propvar as const PROPVARIANT const ptr) as HRESULT
	GetImageReferenceForValue as function(byval This as IPropertyDescription2 ptr, byval propvar as const PROPVARIANT const ptr, byval ppszImageRes as LPWSTR ptr) as HRESULT
end type

type IPropertyDescription2_
	lpVtbl as IPropertyDescription2Vtbl ptr
end type

#define IPropertyDescription2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPropertyDescription2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPropertyDescription2_Release(This) (This)->lpVtbl->Release(This)
#define IPropertyDescription2_GetPropertyKey(This, pkey) (This)->lpVtbl->GetPropertyKey(This, pkey)
#define IPropertyDescription2_GetCanonicalName(This, ppszName) (This)->lpVtbl->GetCanonicalName(This, ppszName)
#define IPropertyDescription2_GetPropertyType(This, pvartype) (This)->lpVtbl->GetPropertyType(This, pvartype)
#define IPropertyDescription2_GetDisplayName(This, ppszName) (This)->lpVtbl->GetDisplayName(This, ppszName)
#define IPropertyDescription2_GetEditInvitation(This, ppszInvite) (This)->lpVtbl->GetEditInvitation(This, ppszInvite)
#define IPropertyDescription2_GetTypeFlags(This, mask, ppdtFlags) (This)->lpVtbl->GetTypeFlags(This, mask, ppdtFlags)
#define IPropertyDescription2_GetViewFlags(This, ppdvFlags) (This)->lpVtbl->GetViewFlags(This, ppdvFlags)
#define IPropertyDescription2_GetDefaultColumnWidth(This, pcxChars) (This)->lpVtbl->GetDefaultColumnWidth(This, pcxChars)
#define IPropertyDescription2_GetDisplayType(This, pdisplaytype) (This)->lpVtbl->GetDisplayType(This, pdisplaytype)
#define IPropertyDescription2_GetColumnState(This, pcsFlags) (This)->lpVtbl->GetColumnState(This, pcsFlags)
#define IPropertyDescription2_GetGroupingRange(This, pgr) (This)->lpVtbl->GetGroupingRange(This, pgr)
#define IPropertyDescription2_GetRelativeDescriptionType(This, prdt) (This)->lpVtbl->GetRelativeDescriptionType(This, prdt)
#define IPropertyDescription2_GetRelativeDescription(This, propvar1, propvar2, ppszDesc1, ppszDesc2) (This)->lpVtbl->GetRelativeDescription(This, propvar1, propvar2, ppszDesc1, ppszDesc2)
#define IPropertyDescription2_GetSortDescription(This, psd) (This)->lpVtbl->GetSortDescription(This, psd)
#define IPropertyDescription2_GetSortDescriptionLabel(This, fDescending, ppszDescription) (This)->lpVtbl->GetSortDescriptionLabel(This, fDescending, ppszDescription)
#define IPropertyDescription2_GetAggregationType(This, paggtype) (This)->lpVtbl->GetAggregationType(This, paggtype)
#define IPropertyDescription2_GetConditionType(This, pcontype, popDefault) (This)->lpVtbl->GetConditionType(This, pcontype, popDefault)
#define IPropertyDescription2_GetEnumTypeList(This, riid, ppv) (This)->lpVtbl->GetEnumTypeList(This, riid, ppv)
#define IPropertyDescription2_CoerceToCanonicalValue(This, ppropvar) (This)->lpVtbl->CoerceToCanonicalValue(This, ppropvar)
#define IPropertyDescription2_FormatForDisplay(This, propvar, pdfFlags, ppszDisplay) (This)->lpVtbl->FormatForDisplay(This, propvar, pdfFlags, ppszDisplay)
#define IPropertyDescription2_IsValueCanonical(This, propvar) (This)->lpVtbl->IsValueCanonical(This, propvar)
#define IPropertyDescription2_GetImageReferenceForValue(This, propvar, ppszImageRes) (This)->lpVtbl->GetImageReferenceForValue(This, propvar, ppszImageRes)
declare function IPropertyDescription2_GetImageReferenceForValue_Proxy(byval This as IPropertyDescription2 ptr, byval propvar as const PROPVARIANT const ptr, byval ppszImageRes as LPWSTR ptr) as HRESULT
declare sub IPropertyDescription2_GetImageReferenceForValue_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPropertyDescriptionAliasInfo_INTERFACE_DEFINED__
extern IID_IPropertyDescriptionAliasInfo as const GUID
type IPropertyDescriptionAliasInfo as IPropertyDescriptionAliasInfo_

type IPropertyDescriptionAliasInfoVtbl
	QueryInterface as function(byval This as IPropertyDescriptionAliasInfo ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPropertyDescriptionAliasInfo ptr) as ULONG
	Release as function(byval This as IPropertyDescriptionAliasInfo ptr) as ULONG
	GetPropertyKey as function(byval This as IPropertyDescriptionAliasInfo ptr, byval pkey as PROPERTYKEY ptr) as HRESULT
	GetCanonicalName as function(byval This as IPropertyDescriptionAliasInfo ptr, byval ppszName as LPWSTR ptr) as HRESULT
	GetPropertyType as function(byval This as IPropertyDescriptionAliasInfo ptr, byval pvartype as VARTYPE ptr) as HRESULT
	GetDisplayName as function(byval This as IPropertyDescriptionAliasInfo ptr, byval ppszName as LPWSTR ptr) as HRESULT
	GetEditInvitation as function(byval This as IPropertyDescriptionAliasInfo ptr, byval ppszInvite as LPWSTR ptr) as HRESULT
	GetTypeFlags as function(byval This as IPropertyDescriptionAliasInfo ptr, byval mask as PROPDESC_TYPE_FLAGS, byval ppdtFlags as PROPDESC_TYPE_FLAGS ptr) as HRESULT
	GetViewFlags as function(byval This as IPropertyDescriptionAliasInfo ptr, byval ppdvFlags as PROPDESC_VIEW_FLAGS ptr) as HRESULT
	GetDefaultColumnWidth as function(byval This as IPropertyDescriptionAliasInfo ptr, byval pcxChars as UINT ptr) as HRESULT
	GetDisplayType as function(byval This as IPropertyDescriptionAliasInfo ptr, byval pdisplaytype as PROPDESC_DISPLAYTYPE ptr) as HRESULT
	GetColumnState as function(byval This as IPropertyDescriptionAliasInfo ptr, byval pcsFlags as SHCOLSTATEF ptr) as HRESULT
	GetGroupingRange as function(byval This as IPropertyDescriptionAliasInfo ptr, byval pgr as PROPDESC_GROUPING_RANGE ptr) as HRESULT
	GetRelativeDescriptionType as function(byval This as IPropertyDescriptionAliasInfo ptr, byval prdt as PROPDESC_RELATIVEDESCRIPTION_TYPE ptr) as HRESULT
	GetRelativeDescription as function(byval This as IPropertyDescriptionAliasInfo ptr, byval propvar1 as const PROPVARIANT const ptr, byval propvar2 as const PROPVARIANT const ptr, byval ppszDesc1 as LPWSTR ptr, byval ppszDesc2 as LPWSTR ptr) as HRESULT
	GetSortDescription as function(byval This as IPropertyDescriptionAliasInfo ptr, byval psd as PROPDESC_SORTDESCRIPTION ptr) as HRESULT
	GetSortDescriptionLabel as function(byval This as IPropertyDescriptionAliasInfo ptr, byval fDescending as WINBOOL, byval ppszDescription as LPWSTR ptr) as HRESULT
	GetAggregationType as function(byval This as IPropertyDescriptionAliasInfo ptr, byval paggtype as PROPDESC_AGGREGATION_TYPE ptr) as HRESULT
	GetConditionType as function(byval This as IPropertyDescriptionAliasInfo ptr, byval pcontype as PROPDESC_CONDITION_TYPE ptr, byval popDefault as CONDITION_OPERATION ptr) as HRESULT
	GetEnumTypeList as function(byval This as IPropertyDescriptionAliasInfo ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	CoerceToCanonicalValue as function(byval This as IPropertyDescriptionAliasInfo ptr, byval ppropvar as PROPVARIANT ptr) as HRESULT
	FormatForDisplay as function(byval This as IPropertyDescriptionAliasInfo ptr, byval propvar as const PROPVARIANT const ptr, byval pdfFlags as PROPDESC_FORMAT_FLAGS, byval ppszDisplay as LPWSTR ptr) as HRESULT
	IsValueCanonical as function(byval This as IPropertyDescriptionAliasInfo ptr, byval propvar as const PROPVARIANT const ptr) as HRESULT
	GetSortByAlias as function(byval This as IPropertyDescriptionAliasInfo ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	GetAdditionalSortByAliases as function(byval This as IPropertyDescriptionAliasInfo ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
end type

type IPropertyDescriptionAliasInfo_
	lpVtbl as IPropertyDescriptionAliasInfoVtbl ptr
end type

#define IPropertyDescriptionAliasInfo_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPropertyDescriptionAliasInfo_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPropertyDescriptionAliasInfo_Release(This) (This)->lpVtbl->Release(This)
#define IPropertyDescriptionAliasInfo_GetPropertyKey(This, pkey) (This)->lpVtbl->GetPropertyKey(This, pkey)
#define IPropertyDescriptionAliasInfo_GetCanonicalName(This, ppszName) (This)->lpVtbl->GetCanonicalName(This, ppszName)
#define IPropertyDescriptionAliasInfo_GetPropertyType(This, pvartype) (This)->lpVtbl->GetPropertyType(This, pvartype)
#define IPropertyDescriptionAliasInfo_GetDisplayName(This, ppszName) (This)->lpVtbl->GetDisplayName(This, ppszName)
#define IPropertyDescriptionAliasInfo_GetEditInvitation(This, ppszInvite) (This)->lpVtbl->GetEditInvitation(This, ppszInvite)
#define IPropertyDescriptionAliasInfo_GetTypeFlags(This, mask, ppdtFlags) (This)->lpVtbl->GetTypeFlags(This, mask, ppdtFlags)
#define IPropertyDescriptionAliasInfo_GetViewFlags(This, ppdvFlags) (This)->lpVtbl->GetViewFlags(This, ppdvFlags)
#define IPropertyDescriptionAliasInfo_GetDefaultColumnWidth(This, pcxChars) (This)->lpVtbl->GetDefaultColumnWidth(This, pcxChars)
#define IPropertyDescriptionAliasInfo_GetDisplayType(This, pdisplaytype) (This)->lpVtbl->GetDisplayType(This, pdisplaytype)
#define IPropertyDescriptionAliasInfo_GetColumnState(This, pcsFlags) (This)->lpVtbl->GetColumnState(This, pcsFlags)
#define IPropertyDescriptionAliasInfo_GetGroupingRange(This, pgr) (This)->lpVtbl->GetGroupingRange(This, pgr)
#define IPropertyDescriptionAliasInfo_GetRelativeDescriptionType(This, prdt) (This)->lpVtbl->GetRelativeDescriptionType(This, prdt)
#define IPropertyDescriptionAliasInfo_GetRelativeDescription(This, propvar1, propvar2, ppszDesc1, ppszDesc2) (This)->lpVtbl->GetRelativeDescription(This, propvar1, propvar2, ppszDesc1, ppszDesc2)
#define IPropertyDescriptionAliasInfo_GetSortDescription(This, psd) (This)->lpVtbl->GetSortDescription(This, psd)
#define IPropertyDescriptionAliasInfo_GetSortDescriptionLabel(This, fDescending, ppszDescription) (This)->lpVtbl->GetSortDescriptionLabel(This, fDescending, ppszDescription)
#define IPropertyDescriptionAliasInfo_GetAggregationType(This, paggtype) (This)->lpVtbl->GetAggregationType(This, paggtype)
#define IPropertyDescriptionAliasInfo_GetConditionType(This, pcontype, popDefault) (This)->lpVtbl->GetConditionType(This, pcontype, popDefault)
#define IPropertyDescriptionAliasInfo_GetEnumTypeList(This, riid, ppv) (This)->lpVtbl->GetEnumTypeList(This, riid, ppv)
#define IPropertyDescriptionAliasInfo_CoerceToCanonicalValue(This, ppropvar) (This)->lpVtbl->CoerceToCanonicalValue(This, ppropvar)
#define IPropertyDescriptionAliasInfo_FormatForDisplay(This, propvar, pdfFlags, ppszDisplay) (This)->lpVtbl->FormatForDisplay(This, propvar, pdfFlags, ppszDisplay)
#define IPropertyDescriptionAliasInfo_IsValueCanonical(This, propvar) (This)->lpVtbl->IsValueCanonical(This, propvar)
#define IPropertyDescriptionAliasInfo_GetSortByAlias(This, riid, ppv) (This)->lpVtbl->GetSortByAlias(This, riid, ppv)
#define IPropertyDescriptionAliasInfo_GetAdditionalSortByAliases(This, riid, ppv) (This)->lpVtbl->GetAdditionalSortByAliases(This, riid, ppv)

declare function IPropertyDescriptionAliasInfo_GetSortByAlias_Proxy(byval This as IPropertyDescriptionAliasInfo ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IPropertyDescriptionAliasInfo_GetSortByAlias_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyDescriptionAliasInfo_GetAdditionalSortByAliases_Proxy(byval This as IPropertyDescriptionAliasInfo ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IPropertyDescriptionAliasInfo_GetAdditionalSortByAliases_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPropertyDescriptionSearchInfo_INTERFACE_DEFINED__

type PROPDESC_SEARCHINFO_FLAGS as long
enum
	PDSIF_DEFAULT = &h0
	PDSIF_ININVERTEDINDEX = &h1
	PDSIF_ISCOLUMN = &h2
	PDSIF_ISCOLUMNSPARSE = &h4
	PDSIF_ALWAYSINCLUDE = &h8
	PDSIF_USEFORTYPEAHEAD = &h10
end enum

type PROPDESC_COLUMNINDEX_TYPE as long
enum
	PDCIT_NONE = 0
	PDCIT_ONDISK = 1
	PDCIT_INMEMORY = 2
	PDCIT_ONDEMAND = 3
	PDCIT_ONDISKALL = 4
	PDCIT_ONDISKVECTOR = 5
end enum

extern IID_IPropertyDescriptionSearchInfo as const GUID
type IPropertyDescriptionSearchInfo as IPropertyDescriptionSearchInfo_

type IPropertyDescriptionSearchInfoVtbl
	QueryInterface as function(byval This as IPropertyDescriptionSearchInfo ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPropertyDescriptionSearchInfo ptr) as ULONG
	Release as function(byval This as IPropertyDescriptionSearchInfo ptr) as ULONG
	GetPropertyKey as function(byval This as IPropertyDescriptionSearchInfo ptr, byval pkey as PROPERTYKEY ptr) as HRESULT
	GetCanonicalName as function(byval This as IPropertyDescriptionSearchInfo ptr, byval ppszName as LPWSTR ptr) as HRESULT
	GetPropertyType as function(byval This as IPropertyDescriptionSearchInfo ptr, byval pvartype as VARTYPE ptr) as HRESULT
	GetDisplayName as function(byval This as IPropertyDescriptionSearchInfo ptr, byval ppszName as LPWSTR ptr) as HRESULT
	GetEditInvitation as function(byval This as IPropertyDescriptionSearchInfo ptr, byval ppszInvite as LPWSTR ptr) as HRESULT
	GetTypeFlags as function(byval This as IPropertyDescriptionSearchInfo ptr, byval mask as PROPDESC_TYPE_FLAGS, byval ppdtFlags as PROPDESC_TYPE_FLAGS ptr) as HRESULT
	GetViewFlags as function(byval This as IPropertyDescriptionSearchInfo ptr, byval ppdvFlags as PROPDESC_VIEW_FLAGS ptr) as HRESULT
	GetDefaultColumnWidth as function(byval This as IPropertyDescriptionSearchInfo ptr, byval pcxChars as UINT ptr) as HRESULT
	GetDisplayType as function(byval This as IPropertyDescriptionSearchInfo ptr, byval pdisplaytype as PROPDESC_DISPLAYTYPE ptr) as HRESULT
	GetColumnState as function(byval This as IPropertyDescriptionSearchInfo ptr, byval pcsFlags as SHCOLSTATEF ptr) as HRESULT
	GetGroupingRange as function(byval This as IPropertyDescriptionSearchInfo ptr, byval pgr as PROPDESC_GROUPING_RANGE ptr) as HRESULT
	GetRelativeDescriptionType as function(byval This as IPropertyDescriptionSearchInfo ptr, byval prdt as PROPDESC_RELATIVEDESCRIPTION_TYPE ptr) as HRESULT
	GetRelativeDescription as function(byval This as IPropertyDescriptionSearchInfo ptr, byval propvar1 as const PROPVARIANT const ptr, byval propvar2 as const PROPVARIANT const ptr, byval ppszDesc1 as LPWSTR ptr, byval ppszDesc2 as LPWSTR ptr) as HRESULT
	GetSortDescription as function(byval This as IPropertyDescriptionSearchInfo ptr, byval psd as PROPDESC_SORTDESCRIPTION ptr) as HRESULT
	GetSortDescriptionLabel as function(byval This as IPropertyDescriptionSearchInfo ptr, byval fDescending as WINBOOL, byval ppszDescription as LPWSTR ptr) as HRESULT
	GetAggregationType as function(byval This as IPropertyDescriptionSearchInfo ptr, byval paggtype as PROPDESC_AGGREGATION_TYPE ptr) as HRESULT
	GetConditionType as function(byval This as IPropertyDescriptionSearchInfo ptr, byval pcontype as PROPDESC_CONDITION_TYPE ptr, byval popDefault as CONDITION_OPERATION ptr) as HRESULT
	GetEnumTypeList as function(byval This as IPropertyDescriptionSearchInfo ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	CoerceToCanonicalValue as function(byval This as IPropertyDescriptionSearchInfo ptr, byval ppropvar as PROPVARIANT ptr) as HRESULT
	FormatForDisplay as function(byval This as IPropertyDescriptionSearchInfo ptr, byval propvar as const PROPVARIANT const ptr, byval pdfFlags as PROPDESC_FORMAT_FLAGS, byval ppszDisplay as LPWSTR ptr) as HRESULT
	IsValueCanonical as function(byval This as IPropertyDescriptionSearchInfo ptr, byval propvar as const PROPVARIANT const ptr) as HRESULT
	GetSearchInfoFlags as function(byval This as IPropertyDescriptionSearchInfo ptr, byval ppdsiFlags as PROPDESC_SEARCHINFO_FLAGS ptr) as HRESULT
	GetColumnIndexType as function(byval This as IPropertyDescriptionSearchInfo ptr, byval ppdciType as PROPDESC_COLUMNINDEX_TYPE ptr) as HRESULT
	GetProjectionString as function(byval This as IPropertyDescriptionSearchInfo ptr, byval ppszProjection as LPWSTR ptr) as HRESULT
	GetMaxSize as function(byval This as IPropertyDescriptionSearchInfo ptr, byval pcbMaxSize as UINT ptr) as HRESULT
end type

type IPropertyDescriptionSearchInfo_
	lpVtbl as IPropertyDescriptionSearchInfoVtbl ptr
end type

#define IPropertyDescriptionSearchInfo_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPropertyDescriptionSearchInfo_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPropertyDescriptionSearchInfo_Release(This) (This)->lpVtbl->Release(This)
#define IPropertyDescriptionSearchInfo_GetPropertyKey(This, pkey) (This)->lpVtbl->GetPropertyKey(This, pkey)
#define IPropertyDescriptionSearchInfo_GetCanonicalName(This, ppszName) (This)->lpVtbl->GetCanonicalName(This, ppszName)
#define IPropertyDescriptionSearchInfo_GetPropertyType(This, pvartype) (This)->lpVtbl->GetPropertyType(This, pvartype)
#define IPropertyDescriptionSearchInfo_GetDisplayName(This, ppszName) (This)->lpVtbl->GetDisplayName(This, ppszName)
#define IPropertyDescriptionSearchInfo_GetEditInvitation(This, ppszInvite) (This)->lpVtbl->GetEditInvitation(This, ppszInvite)
#define IPropertyDescriptionSearchInfo_GetTypeFlags(This, mask, ppdtFlags) (This)->lpVtbl->GetTypeFlags(This, mask, ppdtFlags)
#define IPropertyDescriptionSearchInfo_GetViewFlags(This, ppdvFlags) (This)->lpVtbl->GetViewFlags(This, ppdvFlags)
#define IPropertyDescriptionSearchInfo_GetDefaultColumnWidth(This, pcxChars) (This)->lpVtbl->GetDefaultColumnWidth(This, pcxChars)
#define IPropertyDescriptionSearchInfo_GetDisplayType(This, pdisplaytype) (This)->lpVtbl->GetDisplayType(This, pdisplaytype)
#define IPropertyDescriptionSearchInfo_GetColumnState(This, pcsFlags) (This)->lpVtbl->GetColumnState(This, pcsFlags)
#define IPropertyDescriptionSearchInfo_GetGroupingRange(This, pgr) (This)->lpVtbl->GetGroupingRange(This, pgr)
#define IPropertyDescriptionSearchInfo_GetRelativeDescriptionType(This, prdt) (This)->lpVtbl->GetRelativeDescriptionType(This, prdt)
#define IPropertyDescriptionSearchInfo_GetRelativeDescription(This, propvar1, propvar2, ppszDesc1, ppszDesc2) (This)->lpVtbl->GetRelativeDescription(This, propvar1, propvar2, ppszDesc1, ppszDesc2)
#define IPropertyDescriptionSearchInfo_GetSortDescription(This, psd) (This)->lpVtbl->GetSortDescription(This, psd)
#define IPropertyDescriptionSearchInfo_GetSortDescriptionLabel(This, fDescending, ppszDescription) (This)->lpVtbl->GetSortDescriptionLabel(This, fDescending, ppszDescription)
#define IPropertyDescriptionSearchInfo_GetAggregationType(This, paggtype) (This)->lpVtbl->GetAggregationType(This, paggtype)
#define IPropertyDescriptionSearchInfo_GetConditionType(This, pcontype, popDefault) (This)->lpVtbl->GetConditionType(This, pcontype, popDefault)
#define IPropertyDescriptionSearchInfo_GetEnumTypeList(This, riid, ppv) (This)->lpVtbl->GetEnumTypeList(This, riid, ppv)
#define IPropertyDescriptionSearchInfo_CoerceToCanonicalValue(This, ppropvar) (This)->lpVtbl->CoerceToCanonicalValue(This, ppropvar)
#define IPropertyDescriptionSearchInfo_FormatForDisplay(This, propvar, pdfFlags, ppszDisplay) (This)->lpVtbl->FormatForDisplay(This, propvar, pdfFlags, ppszDisplay)
#define IPropertyDescriptionSearchInfo_IsValueCanonical(This, propvar) (This)->lpVtbl->IsValueCanonical(This, propvar)
#define IPropertyDescriptionSearchInfo_GetSearchInfoFlags(This, ppdsiFlags) (This)->lpVtbl->GetSearchInfoFlags(This, ppdsiFlags)
#define IPropertyDescriptionSearchInfo_GetColumnIndexType(This, ppdciType) (This)->lpVtbl->GetColumnIndexType(This, ppdciType)
#define IPropertyDescriptionSearchInfo_GetProjectionString(This, ppszProjection) (This)->lpVtbl->GetProjectionString(This, ppszProjection)
#define IPropertyDescriptionSearchInfo_GetMaxSize(This, pcbMaxSize) (This)->lpVtbl->GetMaxSize(This, pcbMaxSize)

declare function IPropertyDescriptionSearchInfo_GetSearchInfoFlags_Proxy(byval This as IPropertyDescriptionSearchInfo ptr, byval ppdsiFlags as PROPDESC_SEARCHINFO_FLAGS ptr) as HRESULT
declare sub IPropertyDescriptionSearchInfo_GetSearchInfoFlags_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyDescriptionSearchInfo_GetColumnIndexType_Proxy(byval This as IPropertyDescriptionSearchInfo ptr, byval ppdciType as PROPDESC_COLUMNINDEX_TYPE ptr) as HRESULT
declare sub IPropertyDescriptionSearchInfo_GetColumnIndexType_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyDescriptionSearchInfo_GetProjectionString_Proxy(byval This as IPropertyDescriptionSearchInfo ptr, byval ppszProjection as LPWSTR ptr) as HRESULT
declare sub IPropertyDescriptionSearchInfo_GetProjectionString_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyDescriptionSearchInfo_GetMaxSize_Proxy(byval This as IPropertyDescriptionSearchInfo ptr, byval pcbMaxSize as UINT ptr) as HRESULT
declare sub IPropertyDescriptionSearchInfo_GetMaxSize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPropertyDescriptionRelatedPropertyInfo_INTERFACE_DEFINED__
extern IID_IPropertyDescriptionRelatedPropertyInfo as const GUID
type IPropertyDescriptionRelatedPropertyInfo as IPropertyDescriptionRelatedPropertyInfo_

type IPropertyDescriptionRelatedPropertyInfoVtbl
	QueryInterface as function(byval This as IPropertyDescriptionRelatedPropertyInfo ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPropertyDescriptionRelatedPropertyInfo ptr) as ULONG
	Release as function(byval This as IPropertyDescriptionRelatedPropertyInfo ptr) as ULONG
	GetPropertyKey as function(byval This as IPropertyDescriptionRelatedPropertyInfo ptr, byval pkey as PROPERTYKEY ptr) as HRESULT
	GetCanonicalName as function(byval This as IPropertyDescriptionRelatedPropertyInfo ptr, byval ppszName as LPWSTR ptr) as HRESULT
	GetPropertyType as function(byval This as IPropertyDescriptionRelatedPropertyInfo ptr, byval pvartype as VARTYPE ptr) as HRESULT
	GetDisplayName as function(byval This as IPropertyDescriptionRelatedPropertyInfo ptr, byval ppszName as LPWSTR ptr) as HRESULT
	GetEditInvitation as function(byval This as IPropertyDescriptionRelatedPropertyInfo ptr, byval ppszInvite as LPWSTR ptr) as HRESULT
	GetTypeFlags as function(byval This as IPropertyDescriptionRelatedPropertyInfo ptr, byval mask as PROPDESC_TYPE_FLAGS, byval ppdtFlags as PROPDESC_TYPE_FLAGS ptr) as HRESULT
	GetViewFlags as function(byval This as IPropertyDescriptionRelatedPropertyInfo ptr, byval ppdvFlags as PROPDESC_VIEW_FLAGS ptr) as HRESULT
	GetDefaultColumnWidth as function(byval This as IPropertyDescriptionRelatedPropertyInfo ptr, byval pcxChars as UINT ptr) as HRESULT
	GetDisplayType as function(byval This as IPropertyDescriptionRelatedPropertyInfo ptr, byval pdisplaytype as PROPDESC_DISPLAYTYPE ptr) as HRESULT
	GetColumnState as function(byval This as IPropertyDescriptionRelatedPropertyInfo ptr, byval pcsFlags as SHCOLSTATEF ptr) as HRESULT
	GetGroupingRange as function(byval This as IPropertyDescriptionRelatedPropertyInfo ptr, byval pgr as PROPDESC_GROUPING_RANGE ptr) as HRESULT
	GetRelativeDescriptionType as function(byval This as IPropertyDescriptionRelatedPropertyInfo ptr, byval prdt as PROPDESC_RELATIVEDESCRIPTION_TYPE ptr) as HRESULT
	GetRelativeDescription as function(byval This as IPropertyDescriptionRelatedPropertyInfo ptr, byval propvar1 as const PROPVARIANT const ptr, byval propvar2 as const PROPVARIANT const ptr, byval ppszDesc1 as LPWSTR ptr, byval ppszDesc2 as LPWSTR ptr) as HRESULT
	GetSortDescription as function(byval This as IPropertyDescriptionRelatedPropertyInfo ptr, byval psd as PROPDESC_SORTDESCRIPTION ptr) as HRESULT
	GetSortDescriptionLabel as function(byval This as IPropertyDescriptionRelatedPropertyInfo ptr, byval fDescending as WINBOOL, byval ppszDescription as LPWSTR ptr) as HRESULT
	GetAggregationType as function(byval This as IPropertyDescriptionRelatedPropertyInfo ptr, byval paggtype as PROPDESC_AGGREGATION_TYPE ptr) as HRESULT
	GetConditionType as function(byval This as IPropertyDescriptionRelatedPropertyInfo ptr, byval pcontype as PROPDESC_CONDITION_TYPE ptr, byval popDefault as CONDITION_OPERATION ptr) as HRESULT
	GetEnumTypeList as function(byval This as IPropertyDescriptionRelatedPropertyInfo ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	CoerceToCanonicalValue as function(byval This as IPropertyDescriptionRelatedPropertyInfo ptr, byval ppropvar as PROPVARIANT ptr) as HRESULT
	FormatForDisplay as function(byval This as IPropertyDescriptionRelatedPropertyInfo ptr, byval propvar as const PROPVARIANT const ptr, byval pdfFlags as PROPDESC_FORMAT_FLAGS, byval ppszDisplay as LPWSTR ptr) as HRESULT
	IsValueCanonical as function(byval This as IPropertyDescriptionRelatedPropertyInfo ptr, byval propvar as const PROPVARIANT const ptr) as HRESULT
	GetRelatedProperty as function(byval This as IPropertyDescriptionRelatedPropertyInfo ptr, byval pszRelationshipName as LPCWSTR, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
end type

type IPropertyDescriptionRelatedPropertyInfo_
	lpVtbl as IPropertyDescriptionRelatedPropertyInfoVtbl ptr
end type

#define IPropertyDescriptionRelatedPropertyInfo_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPropertyDescriptionRelatedPropertyInfo_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPropertyDescriptionRelatedPropertyInfo_Release(This) (This)->lpVtbl->Release(This)
#define IPropertyDescriptionRelatedPropertyInfo_GetPropertyKey(This, pkey) (This)->lpVtbl->GetPropertyKey(This, pkey)
#define IPropertyDescriptionRelatedPropertyInfo_GetCanonicalName(This, ppszName) (This)->lpVtbl->GetCanonicalName(This, ppszName)
#define IPropertyDescriptionRelatedPropertyInfo_GetPropertyType(This, pvartype) (This)->lpVtbl->GetPropertyType(This, pvartype)
#define IPropertyDescriptionRelatedPropertyInfo_GetDisplayName(This, ppszName) (This)->lpVtbl->GetDisplayName(This, ppszName)
#define IPropertyDescriptionRelatedPropertyInfo_GetEditInvitation(This, ppszInvite) (This)->lpVtbl->GetEditInvitation(This, ppszInvite)
#define IPropertyDescriptionRelatedPropertyInfo_GetTypeFlags(This, mask, ppdtFlags) (This)->lpVtbl->GetTypeFlags(This, mask, ppdtFlags)
#define IPropertyDescriptionRelatedPropertyInfo_GetViewFlags(This, ppdvFlags) (This)->lpVtbl->GetViewFlags(This, ppdvFlags)
#define IPropertyDescriptionRelatedPropertyInfo_GetDefaultColumnWidth(This, pcxChars) (This)->lpVtbl->GetDefaultColumnWidth(This, pcxChars)
#define IPropertyDescriptionRelatedPropertyInfo_GetDisplayType(This, pdisplaytype) (This)->lpVtbl->GetDisplayType(This, pdisplaytype)
#define IPropertyDescriptionRelatedPropertyInfo_GetColumnState(This, pcsFlags) (This)->lpVtbl->GetColumnState(This, pcsFlags)
#define IPropertyDescriptionRelatedPropertyInfo_GetGroupingRange(This, pgr) (This)->lpVtbl->GetGroupingRange(This, pgr)
#define IPropertyDescriptionRelatedPropertyInfo_GetRelativeDescriptionType(This, prdt) (This)->lpVtbl->GetRelativeDescriptionType(This, prdt)
#define IPropertyDescriptionRelatedPropertyInfo_GetRelativeDescription(This, propvar1, propvar2, ppszDesc1, ppszDesc2) (This)->lpVtbl->GetRelativeDescription(This, propvar1, propvar2, ppszDesc1, ppszDesc2)
#define IPropertyDescriptionRelatedPropertyInfo_GetSortDescription(This, psd) (This)->lpVtbl->GetSortDescription(This, psd)
#define IPropertyDescriptionRelatedPropertyInfo_GetSortDescriptionLabel(This, fDescending, ppszDescription) (This)->lpVtbl->GetSortDescriptionLabel(This, fDescending, ppszDescription)
#define IPropertyDescriptionRelatedPropertyInfo_GetAggregationType(This, paggtype) (This)->lpVtbl->GetAggregationType(This, paggtype)
#define IPropertyDescriptionRelatedPropertyInfo_GetConditionType(This, pcontype, popDefault) (This)->lpVtbl->GetConditionType(This, pcontype, popDefault)
#define IPropertyDescriptionRelatedPropertyInfo_GetEnumTypeList(This, riid, ppv) (This)->lpVtbl->GetEnumTypeList(This, riid, ppv)
#define IPropertyDescriptionRelatedPropertyInfo_CoerceToCanonicalValue(This, ppropvar) (This)->lpVtbl->CoerceToCanonicalValue(This, ppropvar)
#define IPropertyDescriptionRelatedPropertyInfo_FormatForDisplay(This, propvar, pdfFlags, ppszDisplay) (This)->lpVtbl->FormatForDisplay(This, propvar, pdfFlags, ppszDisplay)
#define IPropertyDescriptionRelatedPropertyInfo_IsValueCanonical(This, propvar) (This)->lpVtbl->IsValueCanonical(This, propvar)
#define IPropertyDescriptionRelatedPropertyInfo_GetRelatedProperty(This, pszRelationshipName, riid, ppv) (This)->lpVtbl->GetRelatedProperty(This, pszRelationshipName, riid, ppv)
declare function IPropertyDescriptionRelatedPropertyInfo_GetRelatedProperty_Proxy(byval This as IPropertyDescriptionRelatedPropertyInfo ptr, byval pszRelationshipName as LPCWSTR, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IPropertyDescriptionRelatedPropertyInfo_GetRelatedProperty_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type PROPDESC_ENUMFILTER as long
enum
	PDEF_ALL = 0
	PDEF_SYSTEM = 1
	PDEF_NONSYSTEM = 2
	PDEF_VIEWABLE = 3
	PDEF_QUERYABLE = 4
	PDEF_INFULLTEXTQUERY = 5
	PDEF_COLUMN = 6
end enum

#define __IPropertySystem_INTERFACE_DEFINED__
extern IID_IPropertySystem as const GUID
type IPropertySystem as IPropertySystem_

type IPropertySystemVtbl
	QueryInterface as function(byval This as IPropertySystem ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPropertySystem ptr) as ULONG
	Release as function(byval This as IPropertySystem ptr) as ULONG
	GetPropertyDescription as function(byval This as IPropertySystem ptr, byval propkey as const PROPERTYKEY const ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	GetPropertyDescriptionByName as function(byval This as IPropertySystem ptr, byval pszCanonicalName as LPCWSTR, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	GetPropertyDescriptionListFromString as function(byval This as IPropertySystem ptr, byval pszPropList as LPCWSTR, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	EnumeratePropertyDescriptions as function(byval This as IPropertySystem ptr, byval filterOn as PROPDESC_ENUMFILTER, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	FormatForDisplay as function(byval This as IPropertySystem ptr, byval key as const PROPERTYKEY const ptr, byval propvar as const PROPVARIANT const ptr, byval pdff as PROPDESC_FORMAT_FLAGS, byval pszText as LPWSTR, byval cchText as DWORD) as HRESULT
	FormatForDisplayAlloc as function(byval This as IPropertySystem ptr, byval key as const PROPERTYKEY const ptr, byval propvar as const PROPVARIANT const ptr, byval pdff as PROPDESC_FORMAT_FLAGS, byval ppszDisplay as LPWSTR ptr) as HRESULT
	RegisterPropertySchema as function(byval This as IPropertySystem ptr, byval pszPath as LPCWSTR) as HRESULT
	UnregisterPropertySchema as function(byval This as IPropertySystem ptr, byval pszPath as LPCWSTR) as HRESULT
	RefreshPropertySchema as function(byval This as IPropertySystem ptr) as HRESULT
end type

type IPropertySystem_
	lpVtbl as IPropertySystemVtbl ptr
end type

#define IPropertySystem_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPropertySystem_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPropertySystem_Release(This) (This)->lpVtbl->Release(This)
#define IPropertySystem_GetPropertyDescription(This, propkey, riid, ppv) (This)->lpVtbl->GetPropertyDescription(This, propkey, riid, ppv)
#define IPropertySystem_GetPropertyDescriptionByName(This, pszCanonicalName, riid, ppv) (This)->lpVtbl->GetPropertyDescriptionByName(This, pszCanonicalName, riid, ppv)
#define IPropertySystem_GetPropertyDescriptionListFromString(This, pszPropList, riid, ppv) (This)->lpVtbl->GetPropertyDescriptionListFromString(This, pszPropList, riid, ppv)
#define IPropertySystem_EnumeratePropertyDescriptions(This, filterOn, riid, ppv) (This)->lpVtbl->EnumeratePropertyDescriptions(This, filterOn, riid, ppv)
#define IPropertySystem_FormatForDisplay(This, key, propvar, pdff, pszText, cchText) (This)->lpVtbl->FormatForDisplay(This, key, propvar, pdff, pszText, cchText)
#define IPropertySystem_FormatForDisplayAlloc(This, key, propvar, pdff, ppszDisplay) (This)->lpVtbl->FormatForDisplayAlloc(This, key, propvar, pdff, ppszDisplay)
#define IPropertySystem_RegisterPropertySchema(This, pszPath) (This)->lpVtbl->RegisterPropertySchema(This, pszPath)
#define IPropertySystem_UnregisterPropertySchema(This, pszPath) (This)->lpVtbl->UnregisterPropertySchema(This, pszPath)
#define IPropertySystem_RefreshPropertySchema(This) (This)->lpVtbl->RefreshPropertySchema(This)

declare function IPropertySystem_GetPropertyDescription_Proxy(byval This as IPropertySystem ptr, byval propkey as const PROPERTYKEY const ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IPropertySystem_GetPropertyDescription_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertySystem_GetPropertyDescriptionByName_Proxy(byval This as IPropertySystem ptr, byval pszCanonicalName as LPCWSTR, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IPropertySystem_GetPropertyDescriptionByName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertySystem_GetPropertyDescriptionListFromString_Proxy(byval This as IPropertySystem ptr, byval pszPropList as LPCWSTR, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IPropertySystem_GetPropertyDescriptionListFromString_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertySystem_EnumeratePropertyDescriptions_Proxy(byval This as IPropertySystem ptr, byval filterOn as PROPDESC_ENUMFILTER, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IPropertySystem_EnumeratePropertyDescriptions_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertySystem_FormatForDisplay_Proxy(byval This as IPropertySystem ptr, byval key as const PROPERTYKEY const ptr, byval propvar as const PROPVARIANT const ptr, byval pdff as PROPDESC_FORMAT_FLAGS, byval pszText as LPWSTR, byval cchText as DWORD) as HRESULT
declare sub IPropertySystem_FormatForDisplay_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertySystem_FormatForDisplayAlloc_Proxy(byval This as IPropertySystem ptr, byval key as const PROPERTYKEY const ptr, byval propvar as const PROPVARIANT const ptr, byval pdff as PROPDESC_FORMAT_FLAGS, byval ppszDisplay as LPWSTR ptr) as HRESULT
declare sub IPropertySystem_FormatForDisplayAlloc_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertySystem_RegisterPropertySchema_Proxy(byval This as IPropertySystem ptr, byval pszPath as LPCWSTR) as HRESULT
declare sub IPropertySystem_RegisterPropertySchema_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertySystem_UnregisterPropertySchema_Proxy(byval This as IPropertySystem ptr, byval pszPath as LPCWSTR) as HRESULT
declare sub IPropertySystem_UnregisterPropertySchema_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertySystem_RefreshPropertySchema_Proxy(byval This as IPropertySystem ptr) as HRESULT
declare sub IPropertySystem_RefreshPropertySchema_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPropertyDescriptionList_INTERFACE_DEFINED__
extern IID_IPropertyDescriptionList as const GUID
type IPropertyDescriptionList as IPropertyDescriptionList_

type IPropertyDescriptionListVtbl
	QueryInterface as function(byval This as IPropertyDescriptionList ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPropertyDescriptionList ptr) as ULONG
	Release as function(byval This as IPropertyDescriptionList ptr) as ULONG
	GetCount as function(byval This as IPropertyDescriptionList ptr, byval pcElem as UINT ptr) as HRESULT
	GetAt as function(byval This as IPropertyDescriptionList ptr, byval iElem as UINT, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
end type

type IPropertyDescriptionList_
	lpVtbl as IPropertyDescriptionListVtbl ptr
end type

#define IPropertyDescriptionList_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPropertyDescriptionList_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPropertyDescriptionList_Release(This) (This)->lpVtbl->Release(This)
#define IPropertyDescriptionList_GetCount(This, pcElem) (This)->lpVtbl->GetCount(This, pcElem)
#define IPropertyDescriptionList_GetAt(This, iElem, riid, ppv) (This)->lpVtbl->GetAt(This, iElem, riid, ppv)

declare function IPropertyDescriptionList_GetCount_Proxy(byval This as IPropertyDescriptionList ptr, byval pcElem as UINT ptr) as HRESULT
declare sub IPropertyDescriptionList_GetCount_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyDescriptionList_GetAt_Proxy(byval This as IPropertyDescriptionList ptr, byval iElem as UINT, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IPropertyDescriptionList_GetAt_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPropertyStoreFactory_INTERFACE_DEFINED__
extern IID_IPropertyStoreFactory as const GUID
type IPropertyStoreFactory as IPropertyStoreFactory_

type IPropertyStoreFactoryVtbl
	QueryInterface as function(byval This as IPropertyStoreFactory ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPropertyStoreFactory ptr) as ULONG
	Release as function(byval This as IPropertyStoreFactory ptr) as ULONG
	GetPropertyStore as function(byval This as IPropertyStoreFactory ptr, byval flags as GETPROPERTYSTOREFLAGS, byval pUnkFactory as IUnknown ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	GetPropertyStoreForKeys as function(byval This as IPropertyStoreFactory ptr, byval rgKeys as const PROPERTYKEY ptr, byval cKeys as UINT, byval flags as GETPROPERTYSTOREFLAGS, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
end type

type IPropertyStoreFactory_
	lpVtbl as IPropertyStoreFactoryVtbl ptr
end type

#define IPropertyStoreFactory_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPropertyStoreFactory_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPropertyStoreFactory_Release(This) (This)->lpVtbl->Release(This)
#define IPropertyStoreFactory_GetPropertyStore(This, flags, pUnkFactory, riid, ppv) (This)->lpVtbl->GetPropertyStore(This, flags, pUnkFactory, riid, ppv)
#define IPropertyStoreFactory_GetPropertyStoreForKeys(This, rgKeys, cKeys, flags, riid, ppv) (This)->lpVtbl->GetPropertyStoreForKeys(This, rgKeys, cKeys, flags, riid, ppv)

declare function IPropertyStoreFactory_GetPropertyStore_Proxy(byval This as IPropertyStoreFactory ptr, byval flags as GETPROPERTYSTOREFLAGS, byval pUnkFactory as IUnknown ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IPropertyStoreFactory_GetPropertyStore_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyStoreFactory_GetPropertyStoreForKeys_Proxy(byval This as IPropertyStoreFactory ptr, byval rgKeys as const PROPERTYKEY ptr, byval cKeys as UINT, byval flags as GETPROPERTYSTOREFLAGS, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IPropertyStoreFactory_GetPropertyStoreForKeys_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IDelayedPropertyStoreFactory_INTERFACE_DEFINED__
extern IID_IDelayedPropertyStoreFactory as const GUID
type IDelayedPropertyStoreFactory as IDelayedPropertyStoreFactory_

type IDelayedPropertyStoreFactoryVtbl
	QueryInterface as function(byval This as IDelayedPropertyStoreFactory ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDelayedPropertyStoreFactory ptr) as ULONG
	Release as function(byval This as IDelayedPropertyStoreFactory ptr) as ULONG
	GetPropertyStore as function(byval This as IDelayedPropertyStoreFactory ptr, byval flags as GETPROPERTYSTOREFLAGS, byval pUnkFactory as IUnknown ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	GetPropertyStoreForKeys as function(byval This as IDelayedPropertyStoreFactory ptr, byval rgKeys as const PROPERTYKEY ptr, byval cKeys as UINT, byval flags as GETPROPERTYSTOREFLAGS, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	GetDelayedPropertyStore as function(byval This as IDelayedPropertyStoreFactory ptr, byval flags as GETPROPERTYSTOREFLAGS, byval dwStoreId as DWORD, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
end type

type IDelayedPropertyStoreFactory_
	lpVtbl as IDelayedPropertyStoreFactoryVtbl ptr
end type

#define IDelayedPropertyStoreFactory_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IDelayedPropertyStoreFactory_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IDelayedPropertyStoreFactory_Release(This) (This)->lpVtbl->Release(This)
#define IDelayedPropertyStoreFactory_GetPropertyStore(This, flags, pUnkFactory, riid, ppv) (This)->lpVtbl->GetPropertyStore(This, flags, pUnkFactory, riid, ppv)
#define IDelayedPropertyStoreFactory_GetPropertyStoreForKeys(This, rgKeys, cKeys, flags, riid, ppv) (This)->lpVtbl->GetPropertyStoreForKeys(This, rgKeys, cKeys, flags, riid, ppv)
#define IDelayedPropertyStoreFactory_GetDelayedPropertyStore(This, flags, dwStoreId, riid, ppv) (This)->lpVtbl->GetDelayedPropertyStore(This, flags, dwStoreId, riid, ppv)
declare function IDelayedPropertyStoreFactory_GetDelayedPropertyStore_Proxy(byval This as IDelayedPropertyStoreFactory ptr, byval flags as GETPROPERTYSTOREFLAGS, byval dwStoreId as DWORD, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IDelayedPropertyStoreFactory_GetDelayedPropertyStore_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type _PERSIST_SPROPSTORE_FLAGS as long
enum
	FPSPS_DEFAULT = &h0
	FPSPS_READONLY = &h1
	FPSPS_TREAT_NEW_VALUES_AS_DIRTY = &h2
end enum

type PERSIST_SPROPSTORE_FLAGS as long
type SERIALIZEDPROPSTORAGE as tagSERIALIZEDPROPSTORAGE
type PUSERIALIZEDPROPSTORAGE as SERIALIZEDPROPSTORAGE ptr
type PCUSERIALIZEDPROPSTORAGE as const SERIALIZEDPROPSTORAGE ptr
#define __IPersistSerializedPropStorage_INTERFACE_DEFINED__
extern IID_IPersistSerializedPropStorage as const GUID
type IPersistSerializedPropStorage as IPersistSerializedPropStorage_

type IPersistSerializedPropStorageVtbl
	QueryInterface as function(byval This as IPersistSerializedPropStorage ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPersistSerializedPropStorage ptr) as ULONG
	Release as function(byval This as IPersistSerializedPropStorage ptr) as ULONG
	SetFlags as function(byval This as IPersistSerializedPropStorage ptr, byval flags as PERSIST_SPROPSTORE_FLAGS) as HRESULT
	SetPropertyStorage as function(byval This as IPersistSerializedPropStorage ptr, byval psps as PCUSERIALIZEDPROPSTORAGE, byval cb as DWORD) as HRESULT
	GetPropertyStorage as function(byval This as IPersistSerializedPropStorage ptr, byval ppsps as SERIALIZEDPROPSTORAGE ptr ptr, byval pcb as DWORD ptr) as HRESULT
end type

type IPersistSerializedPropStorage_
	lpVtbl as IPersistSerializedPropStorageVtbl ptr
end type

#define IPersistSerializedPropStorage_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPersistSerializedPropStorage_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPersistSerializedPropStorage_Release(This) (This)->lpVtbl->Release(This)
#define IPersistSerializedPropStorage_SetFlags(This, flags) (This)->lpVtbl->SetFlags(This, flags)
#define IPersistSerializedPropStorage_SetPropertyStorage(This, psps, cb) (This)->lpVtbl->SetPropertyStorage(This, psps, cb)
#define IPersistSerializedPropStorage_GetPropertyStorage(This, ppsps, pcb) (This)->lpVtbl->GetPropertyStorage(This, ppsps, pcb)

declare function IPersistSerializedPropStorage_SetFlags_Proxy(byval This as IPersistSerializedPropStorage ptr, byval flags as PERSIST_SPROPSTORE_FLAGS) as HRESULT
declare sub IPersistSerializedPropStorage_SetFlags_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPersistSerializedPropStorage_SetPropertyStorage_Proxy(byval This as IPersistSerializedPropStorage ptr, byval psps as PCUSERIALIZEDPROPSTORAGE, byval cb as DWORD) as HRESULT
declare sub IPersistSerializedPropStorage_SetPropertyStorage_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPersistSerializedPropStorage_GetPropertyStorage_Proxy(byval This as IPersistSerializedPropStorage ptr, byval ppsps as SERIALIZEDPROPSTORAGE ptr ptr, byval pcb as DWORD ptr) as HRESULT
declare sub IPersistSerializedPropStorage_GetPropertyStorage_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPersistSerializedPropStorage2_INTERFACE_DEFINED__
extern IID_IPersistSerializedPropStorage2 as const GUID
type IPersistSerializedPropStorage2 as IPersistSerializedPropStorage2_

type IPersistSerializedPropStorage2Vtbl
	QueryInterface as function(byval This as IPersistSerializedPropStorage2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPersistSerializedPropStorage2 ptr) as ULONG
	Release as function(byval This as IPersistSerializedPropStorage2 ptr) as ULONG
	SetFlags as function(byval This as IPersistSerializedPropStorage2 ptr, byval flags as PERSIST_SPROPSTORE_FLAGS) as HRESULT
	SetPropertyStorage as function(byval This as IPersistSerializedPropStorage2 ptr, byval psps as PCUSERIALIZEDPROPSTORAGE, byval cb as DWORD) as HRESULT
	GetPropertyStorage as function(byval This as IPersistSerializedPropStorage2 ptr, byval ppsps as SERIALIZEDPROPSTORAGE ptr ptr, byval pcb as DWORD ptr) as HRESULT
	GetPropertyStorageSize as function(byval This as IPersistSerializedPropStorage2 ptr, byval pcb as DWORD ptr) as HRESULT
	GetPropertyStorageBuffer as function(byval This as IPersistSerializedPropStorage2 ptr, byval psps as SERIALIZEDPROPSTORAGE ptr, byval cb as DWORD, byval pcbWritten as DWORD ptr) as HRESULT
end type

type IPersistSerializedPropStorage2_
	lpVtbl as IPersistSerializedPropStorage2Vtbl ptr
end type

#define IPersistSerializedPropStorage2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPersistSerializedPropStorage2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPersistSerializedPropStorage2_Release(This) (This)->lpVtbl->Release(This)
#define IPersistSerializedPropStorage2_SetFlags(This, flags) (This)->lpVtbl->SetFlags(This, flags)
#define IPersistSerializedPropStorage2_SetPropertyStorage(This, psps, cb) (This)->lpVtbl->SetPropertyStorage(This, psps, cb)
#define IPersistSerializedPropStorage2_GetPropertyStorage(This, ppsps, pcb) (This)->lpVtbl->GetPropertyStorage(This, ppsps, pcb)
#define IPersistSerializedPropStorage2_GetPropertyStorageSize(This, pcb) (This)->lpVtbl->GetPropertyStorageSize(This, pcb)
#define IPersistSerializedPropStorage2_GetPropertyStorageBuffer(This, psps, cb, pcbWritten) (This)->lpVtbl->GetPropertyStorageBuffer(This, psps, cb, pcbWritten)

declare function IPersistSerializedPropStorage2_GetPropertyStorageSize_Proxy(byval This as IPersistSerializedPropStorage2 ptr, byval pcb as DWORD ptr) as HRESULT
declare sub IPersistSerializedPropStorage2_GetPropertyStorageSize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPersistSerializedPropStorage2_GetPropertyStorageBuffer_Proxy(byval This as IPersistSerializedPropStorage2 ptr, byval psps as SERIALIZEDPROPSTORAGE ptr, byval cb as DWORD, byval pcbWritten as DWORD ptr) as HRESULT
declare sub IPersistSerializedPropStorage2_GetPropertyStorageBuffer_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPropertySystemChangeNotify_INTERFACE_DEFINED__
extern IID_IPropertySystemChangeNotify as const GUID
type IPropertySystemChangeNotify as IPropertySystemChangeNotify_

type IPropertySystemChangeNotifyVtbl
	QueryInterface as function(byval This as IPropertySystemChangeNotify ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPropertySystemChangeNotify ptr) as ULONG
	Release as function(byval This as IPropertySystemChangeNotify ptr) as ULONG
	SchemaRefreshed as function(byval This as IPropertySystemChangeNotify ptr) as HRESULT
end type

type IPropertySystemChangeNotify_
	lpVtbl as IPropertySystemChangeNotifyVtbl ptr
end type

#define IPropertySystemChangeNotify_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPropertySystemChangeNotify_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPropertySystemChangeNotify_Release(This) (This)->lpVtbl->Release(This)
#define IPropertySystemChangeNotify_SchemaRefreshed(This) (This)->lpVtbl->SchemaRefreshed(This)
declare function IPropertySystemChangeNotify_SchemaRefreshed_Proxy(byval This as IPropertySystemChangeNotify ptr) as HRESULT
declare sub IPropertySystemChangeNotify_SchemaRefreshed_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __ICreateObject_INTERFACE_DEFINED__
extern IID_ICreateObject as const GUID
type ICreateObject as ICreateObject_

type ICreateObjectVtbl
	QueryInterface as function(byval This as ICreateObject ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ICreateObject ptr) as ULONG
	Release as function(byval This as ICreateObject ptr) as ULONG
	CreateObject as function(byval This as ICreateObject ptr, byval clsid as const IID const ptr, byval pUnkOuter as IUnknown ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
end type

type ICreateObject_
	lpVtbl as ICreateObjectVtbl ptr
end type

#define ICreateObject_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define ICreateObject_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ICreateObject_Release(This) (This)->lpVtbl->Release(This)
#define ICreateObject_CreateObject(This, clsid, pUnkOuter, riid, ppv) (This)->lpVtbl->CreateObject(This, clsid, pUnkOuter, riid, ppv)
declare function ICreateObject_CreateObject_Proxy(byval This as ICreateObject ptr, byval clsid as const IID const ptr, byval pUnkOuter as IUnknown ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub ICreateObject_CreateObject_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
const PKEY_PIDSTR_MAX = 10
const GUIDSTRING_MAX = 39
const PKEYSTR_MAX = (GUIDSTRING_MAX + 1) + PKEY_PIDSTR_MAX

declare function PSCoerceToCanonicalValue(byval key as const PROPERTYKEY const ptr, byval ppropvar as PROPVARIANT ptr) as HRESULT
declare function PSCreateAdapterFromPropertyStore(byval pps as IPropertyStore ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare function PSCreateDelayedMultiplexPropertyStore(byval flags as GETPROPERTYSTOREFLAGS, byval pdpsf as IDelayedPropertyStoreFactory ptr, byval rgStoreIds as const DWORD ptr, byval cStores as DWORD, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare function PSCreateMemoryPropertyStore(byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare function PSCreateMultiplexPropertyStore(byval prgpunkStores as IUnknown ptr ptr, byval cStores as DWORD, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare function PSCreatePropertyChangeArray(byval rgpropkey as const PROPERTYKEY ptr, byval rgflags as const PKA_FLAGS ptr, byval rgpropvar as const PROPVARIANT ptr, byval cChanges as UINT, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare function PSCreatePropertyStoreFromObject(byval punk as IUnknown ptr, byval grfMode as DWORD, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare function PSCreatePropertyStoreFromPropertySetStorage(byval ppss as IPropertySetStorage ptr, byval grfMode as DWORD, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare function PSCreateSimplePropertyChange(byval flags as PKA_FLAGS, byval key as const PROPERTYKEY const ptr, byval propvar as const PROPVARIANT const ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare function PSEnumeratePropertyDescriptions(byval filterOn as PROPDESC_ENUMFILTER, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare function PSFormatForDisplay(byval propkey as const PROPERTYKEY const ptr, byval propvar as const PROPVARIANT const ptr, byval pdfFlags as PROPDESC_FORMAT_FLAGS, byval pwszText as LPWSTR, byval cchText as DWORD) as HRESULT
declare function PSFormatForDisplayAlloc(byval key as const PROPERTYKEY const ptr, byval propvar as const PROPVARIANT const ptr, byval pdff as PROPDESC_FORMAT_FLAGS, byval ppszDisplay as PWSTR ptr) as HRESULT
declare function PSFormatPropertyValue(byval pps as IPropertyStore ptr, byval ppd as IPropertyDescription ptr, byval pdff as PROPDESC_FORMAT_FLAGS, byval ppszDisplay as LPWSTR ptr) as HRESULT
declare function PSGetImageReferenceForValue(byval propkey as const PROPERTYKEY const ptr, byval propvar as const PROPVARIANT const ptr, byval ppszImageRes as PWSTR ptr) as HRESULT
declare function PSGetItemPropertyHandler(byval punkItem as IUnknown ptr, byval fReadWrite as BOOL, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare function PSGetItemPropertyHandlerWithCreateObject(byval punkItem as IUnknown ptr, byval fReadWrite as BOOL, byval punkCreateObject as IUnknown ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare function PSGetNamedPropertyFromPropertyStorage(byval psps as PCUSERIALIZEDPROPSTORAGE, byval cb as DWORD, byval pszName as LPCWSTR, byval ppropvar as PROPVARIANT ptr) as HRESULT
declare function PSGetNameFromPropertyKey(byval propkey as const PROPERTYKEY const ptr, byval ppszCanonicalName as PWSTR ptr) as HRESULT
declare function PSGetPropertyDescription(byval propkey as const PROPERTYKEY const ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare function PSGetPropertyDescriptionByName(byval pszCanonicalName as LPCWSTR, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare function PSGetPropertyDescriptionListFromString(byval pszPropList as LPCWSTR, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare function PSGetPropertyFromPropertyStorage(byval psps as PCUSERIALIZEDPROPSTORAGE, byval cb as DWORD, byval rpkey as const PROPERTYKEY const ptr, byval ppropvar as PROPVARIANT ptr) as HRESULT
declare function PSGetPropertyKeyFromName(byval pszName as PCWSTR, byval ppropkey as PROPERTYKEY ptr) as HRESULT
declare function PSGetPropertySystem(byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare function PSGetPropertyValue(byval pps as IPropertyStore ptr, byval ppd as IPropertyDescription ptr, byval ppropvar as PROPVARIANT ptr) as HRESULT
declare function PSLookupPropertyHandlerCLSID(byval pszFilePath as PCWSTR, byval pclsid as CLSID ptr) as HRESULT
declare function PSPropertyBag_Delete(byval propBag as IPropertyBag ptr, byval propName as LPCWSTR) as HRESULT
declare function PSPropertyBag_ReadBOOL(byval propBag as IPropertyBag ptr, byval propName as LPCWSTR, byval value as BOOL ptr) as HRESULT
declare function PSPropertyBag_ReadBSTR(byval propBag as IPropertyBag ptr, byval propName as LPCWSTR, byval value as BSTR ptr) as HRESULT
declare function PSPropertyBag_ReadDWORD(byval propBag as IPropertyBag ptr, byval propName as LPCWSTR, byval value as DWORD ptr) as HRESULT
declare function PSPropertyBag_ReadGUID(byval propBag as IPropertyBag ptr, byval propName as LPCWSTR, byval value as GUID ptr) as HRESULT
declare function PSPropertyBag_ReadInt(byval propBag as IPropertyBag ptr, byval propName as LPCWSTR, byval value as INT_ ptr) as HRESULT
declare function PSPropertyBag_ReadLONG(byval propBag as IPropertyBag ptr, byval propName as LPCWSTR, byval value as LONG ptr) as HRESULT
declare function PSPropertyBag_ReadPOINTL(byval propBag as IPropertyBag ptr, byval propName as LPCWSTR, byval value as POINTL ptr) as HRESULT
declare function PSPropertyBag_ReadPOINTS(byval propBag as IPropertyBag ptr, byval propName as LPCWSTR, byval value as POINTS ptr) as HRESULT
declare function PSPropertyBag_ReadPropertyKey(byval propBag as IPropertyBag ptr, byval propName as LPCWSTR, byval value as PROPERTYKEY ptr) as HRESULT
declare function PSPropertyBag_ReadRECTL(byval propBag as IPropertyBag ptr, byval propName as LPCWSTR, byval value as RECTL ptr) as HRESULT
declare function PSPropertyBag_ReadSHORT(byval propBag as IPropertyBag ptr, byval propName as LPCWSTR, byval value as SHORT ptr) as HRESULT
declare function PSPropertyBag_ReadStr(byval propBag as IPropertyBag ptr, byval propName as LPCWSTR, byval value as LPWSTR, byval characterCount as long) as HRESULT
declare function PSPropertyBag_ReadStrAlloc(byval propBag as IPropertyBag ptr, byval propName as LPCWSTR, byval value as PWSTR ptr) as HRESULT
declare function PSPropertyBag_ReadStream(byval propBag as IPropertyBag ptr, byval propName as LPCWSTR, byval value as IStream ptr ptr) as HRESULT
declare function PSPropertyBag_ReadType(byval propBag as IPropertyBag ptr, byval propName as LPCWSTR, byval var as VARIANT ptr, byval type as VARTYPE) as HRESULT
declare function PSPropertyBag_ReadULONGLONG(byval propBag as IPropertyBag ptr, byval propName as LPCWSTR, byval value as ULONGLONG ptr) as HRESULT
declare function PSPropertyBag_ReadUnknown(byval propBag as IPropertyBag ptr, byval propName as LPCWSTR, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare function PSPropertyBag_WriteBOOL(byval propBag as IPropertyBag ptr, byval propName as LPCWSTR, byval value as BOOL) as HRESULT
declare function PSPropertyBag_WriteBSTR(byval propBag as IPropertyBag ptr, byval propName as LPCWSTR, byval value as BSTR) as HRESULT
declare function PSPropertyBag_WriteDWORD(byval propBag as IPropertyBag ptr, byval propName as LPCWSTR, byval value as DWORD) as HRESULT
declare function PSPropertyBag_WriteGUID(byval propBag as IPropertyBag ptr, byval propName as LPCWSTR, byval value as const GUID ptr) as HRESULT
declare function PSPropertyBag_WriteInt(byval propBag as IPropertyBag ptr, byval propName as LPCWSTR, byval value as INT_) as HRESULT
declare function PSPropertyBag_WriteLONG(byval propBag as IPropertyBag ptr, byval propName as LPCWSTR, byval value as LONG) as HRESULT
declare function PSPropertyBag_WritePOINTL(byval propBag as IPropertyBag ptr, byval propName as LPCWSTR, byval value as const POINTL ptr) as HRESULT
declare function PSPropertyBag_WritePOINTS(byval propBag as IPropertyBag ptr, byval propName as LPCWSTR, byval value as const POINTS ptr) as HRESULT
declare function PSPropertyBag_WritePropertyKey(byval propBag as IPropertyBag ptr, byval propName as LPCWSTR, byval value as const PROPERTYKEY const ptr) as HRESULT
declare function PSPropertyBag_WriteRECTL(byval propBag as IPropertyBag ptr, byval propName as LPCWSTR, byval value as const RECTL ptr) as HRESULT
declare function PSPropertyBag_WriteSHORT(byval propBag as IPropertyBag ptr, byval propName as LPCWSTR, byval value as SHORT) as HRESULT
declare function PSPropertyBag_WriteStr(byval propBag as IPropertyBag ptr, byval propName as LPCWSTR, byval value as LPCWSTR) as HRESULT
declare function PSPropertyBag_WriteStream(byval propBag as IPropertyBag ptr, byval propName as LPCWSTR, byval value as IStream ptr) as HRESULT
declare function PSPropertyBag_WriteULONGLONG(byval propBag as IPropertyBag ptr, byval propName as LPCWSTR, byval value as ULONGLONG) as HRESULT
declare function PSPropertyBag_WriteUnknown(byval propBag as IPropertyBag ptr, byval propName as LPCWSTR, byval punk as IUnknown ptr) as HRESULT
declare function PSPropertyKeyFromString(byval pszString as LPCWSTR, byval pkey as PROPERTYKEY ptr) as HRESULT
declare function PSRefreshPropertySchema() as HRESULT
declare function PSRegisterPropertySchema(byval pszPath as PCWSTR) as HRESULT
declare function PSSetPropertyValue(byval pps as IPropertyStore ptr, byval ppd as IPropertyDescription ptr, byval propvar as const PROPVARIANT const ptr) as HRESULT
declare function PSStringFromPropertyKey(byval pkey as const PROPERTYKEY const ptr, byval psz as LPWSTR, byval cch as UINT) as HRESULT
declare function PSUnregisterPropertySchema(byval pszPath as PCWSTR) as HRESULT

extern LIBID_PropSysObjects as const GUID
extern CLSID_InMemoryPropertyStore as const GUID
extern CLSID_PropertySystem as const GUID

end extern

#include once "ole-common.bi"
