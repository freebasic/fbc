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

extern "Windows"

#define __objidlbase_h__
#define __IMarshal_FWD_DEFINED__
#define __INoMarshal_FWD_DEFINED__
#define __IAgileObject_FWD_DEFINED__
#define __IMarshal2_FWD_DEFINED__
#define __IMalloc_FWD_DEFINED__
#define __IStdMarshalInfo_FWD_DEFINED__
#define __IExternalConnection_FWD_DEFINED__
#define __IMultiQI_FWD_DEFINED__
#define __AsyncIMultiQI_FWD_DEFINED__
#define __IInternalUnknown_FWD_DEFINED__
#define __IEnumUnknown_FWD_DEFINED__
#define __IEnumString_FWD_DEFINED__
#define __ISequentialStream_FWD_DEFINED__
#define __IStream_FWD_DEFINED__
#define __IRpcChannelBuffer_FWD_DEFINED__
#define __IRpcChannelBuffer2_FWD_DEFINED__
#define __IAsyncRpcChannelBuffer_FWD_DEFINED__
#define __IRpcChannelBuffer3_FWD_DEFINED__
#define __IRpcSyntaxNegotiate_FWD_DEFINED__
#define __IRpcProxyBuffer_FWD_DEFINED__
#define __IRpcStubBuffer_FWD_DEFINED__
#define __IPSFactoryBuffer_FWD_DEFINED__
#define __IChannelHook_FWD_DEFINED__
#define __IClientSecurity_FWD_DEFINED__
#define __IServerSecurity_FWD_DEFINED__
#define __IRpcOptions_FWD_DEFINED__
#define __IGlobalOptions_FWD_DEFINED__
#define __ISurrogate_FWD_DEFINED__
#define __IGlobalInterfaceTable_FWD_DEFINED__
#define __ISynchronize_FWD_DEFINED__
#define __ISynchronizeHandle_FWD_DEFINED__
#define __ISynchronizeEvent_FWD_DEFINED__
#define __ISynchronizeContainer_FWD_DEFINED__
#define __ISynchronizeMutex_FWD_DEFINED__
#define __ICancelMethodCalls_FWD_DEFINED__
#define __IAsyncManager_FWD_DEFINED__
#define __ICallFactory_FWD_DEFINED__
#define __IRpcHelper_FWD_DEFINED__
#define __IReleaseMarshalBuffers_FWD_DEFINED__
#define __IWaitMultiple_FWD_DEFINED__
#define __IAddrTrackingControl_FWD_DEFINED__
#define __IAddrExclusionControl_FWD_DEFINED__
#define __IPipeByte_FWD_DEFINED__
#define __IPipeLong_FWD_DEFINED__
#define __IPipeDouble_FWD_DEFINED__
#define __IEnumContextProps_FWD_DEFINED__
#define __IContext_FWD_DEFINED__
#define __IComThreadingInfo_FWD_DEFINED__
#define __IProcessInitControl_FWD_DEFINED__
#define __IFastRundown_FWD_DEFINED__
#define __IMarshalingStream_FWD_DEFINED__

type _COSERVERINFO
	dwReserved1 as DWORD
	pwszName as LPWSTR
	pAuthInfo as COAUTHINFO ptr
	dwReserved2 as DWORD
end type

type COSERVERINFO as _COSERVERINFO
#define __IMarshal_INTERFACE_DEFINED__
type IMarshal as IMarshal_
type LPMARSHAL as IMarshal ptr
extern IID_IMarshal as const GUID
type IStream as IStream_

type IMarshalVtbl
	QueryInterface as function(byval This as IMarshal ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IMarshal ptr) as ULONG
	Release as function(byval This as IMarshal ptr) as ULONG
	GetUnmarshalClass as function(byval This as IMarshal ptr, byval riid as const IID const ptr, byval pv as any ptr, byval dwDestContext as DWORD, byval pvDestContext as any ptr, byval mshlflags as DWORD, byval pCid as CLSID ptr) as HRESULT
	GetMarshalSizeMax as function(byval This as IMarshal ptr, byval riid as const IID const ptr, byval pv as any ptr, byval dwDestContext as DWORD, byval pvDestContext as any ptr, byval mshlflags as DWORD, byval pSize as DWORD ptr) as HRESULT
	MarshalInterface as function(byval This as IMarshal ptr, byval pStm as IStream ptr, byval riid as const IID const ptr, byval pv as any ptr, byval dwDestContext as DWORD, byval pvDestContext as any ptr, byval mshlflags as DWORD) as HRESULT
	UnmarshalInterface as function(byval This as IMarshal ptr, byval pStm as IStream ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	ReleaseMarshalData as function(byval This as IMarshal ptr, byval pStm as IStream ptr) as HRESULT
	DisconnectObject as function(byval This as IMarshal ptr, byval dwReserved as DWORD) as HRESULT
end type

type IMarshal_
	lpVtbl as IMarshalVtbl ptr
end type

#define IMarshal_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IMarshal_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IMarshal_Release(This) (This)->lpVtbl->Release(This)
#define IMarshal_GetUnmarshalClass(This, riid, pv, dwDestContext, pvDestContext, mshlflags, pCid) (This)->lpVtbl->GetUnmarshalClass(This, riid, pv, dwDestContext, pvDestContext, mshlflags, pCid)
#define IMarshal_GetMarshalSizeMax(This, riid, pv, dwDestContext, pvDestContext, mshlflags, pSize) (This)->lpVtbl->GetMarshalSizeMax(This, riid, pv, dwDestContext, pvDestContext, mshlflags, pSize)
#define IMarshal_MarshalInterface(This, pStm, riid, pv, dwDestContext, pvDestContext, mshlflags) (This)->lpVtbl->MarshalInterface(This, pStm, riid, pv, dwDestContext, pvDestContext, mshlflags)
#define IMarshal_UnmarshalInterface(This, pStm, riid, ppv) (This)->lpVtbl->UnmarshalInterface(This, pStm, riid, ppv)
#define IMarshal_ReleaseMarshalData(This, pStm) (This)->lpVtbl->ReleaseMarshalData(This, pStm)
#define IMarshal_DisconnectObject(This, dwReserved) (This)->lpVtbl->DisconnectObject(This, dwReserved)

declare function IMarshal_GetUnmarshalClass_Proxy(byval This as IMarshal ptr, byval riid as const IID const ptr, byval pv as any ptr, byval dwDestContext as DWORD, byval pvDestContext as any ptr, byval mshlflags as DWORD, byval pCid as CLSID ptr) as HRESULT
declare sub IMarshal_GetUnmarshalClass_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMarshal_GetMarshalSizeMax_Proxy(byval This as IMarshal ptr, byval riid as const IID const ptr, byval pv as any ptr, byval dwDestContext as DWORD, byval pvDestContext as any ptr, byval mshlflags as DWORD, byval pSize as DWORD ptr) as HRESULT
declare sub IMarshal_GetMarshalSizeMax_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMarshal_MarshalInterface_Proxy(byval This as IMarshal ptr, byval pStm as IStream ptr, byval riid as const IID const ptr, byval pv as any ptr, byval dwDestContext as DWORD, byval pvDestContext as any ptr, byval mshlflags as DWORD) as HRESULT
declare sub IMarshal_MarshalInterface_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMarshal_UnmarshalInterface_Proxy(byval This as IMarshal ptr, byval pStm as IStream ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IMarshal_UnmarshalInterface_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMarshal_ReleaseMarshalData_Proxy(byval This as IMarshal ptr, byval pStm as IStream ptr) as HRESULT
declare sub IMarshal_ReleaseMarshalData_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMarshal_DisconnectObject_Proxy(byval This as IMarshal ptr, byval dwReserved as DWORD) as HRESULT
declare sub IMarshal_DisconnectObject_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __INoMarshal_INTERFACE_DEFINED__
extern IID_INoMarshal as const GUID
type INoMarshal as INoMarshal_

type INoMarshalVtbl
	QueryInterface as function(byval This as INoMarshal ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as INoMarshal ptr) as ULONG
	Release as function(byval This as INoMarshal ptr) as ULONG
end type

type INoMarshal_
	lpVtbl as INoMarshalVtbl ptr
end type

#define INoMarshal_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define INoMarshal_AddRef(This) (This)->lpVtbl->AddRef(This)
#define INoMarshal_Release(This) (This)->lpVtbl->Release(This)
#define __IAgileObject_INTERFACE_DEFINED__
extern IID_IAgileObject as const GUID
type IAgileObject as IAgileObject_

type IAgileObjectVtbl
	QueryInterface as function(byval This as IAgileObject ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAgileObject ptr) as ULONG
	Release as function(byval This as IAgileObject ptr) as ULONG
end type

type IAgileObject_
	lpVtbl as IAgileObjectVtbl ptr
end type

#define IAgileObject_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IAgileObject_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IAgileObject_Release(This) (This)->lpVtbl->Release(This)
#define __IMarshal2_INTERFACE_DEFINED__
type IMarshal2 as IMarshal2_
type LPMARSHAL2 as IMarshal2 ptr
extern IID_IMarshal2 as const GUID

type IMarshal2Vtbl
	QueryInterface as function(byval This as IMarshal2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IMarshal2 ptr) as ULONG
	Release as function(byval This as IMarshal2 ptr) as ULONG
	GetUnmarshalClass as function(byval This as IMarshal2 ptr, byval riid as const IID const ptr, byval pv as any ptr, byval dwDestContext as DWORD, byval pvDestContext as any ptr, byval mshlflags as DWORD, byval pCid as CLSID ptr) as HRESULT
	GetMarshalSizeMax as function(byval This as IMarshal2 ptr, byval riid as const IID const ptr, byval pv as any ptr, byval dwDestContext as DWORD, byval pvDestContext as any ptr, byval mshlflags as DWORD, byval pSize as DWORD ptr) as HRESULT
	MarshalInterface as function(byval This as IMarshal2 ptr, byval pStm as IStream ptr, byval riid as const IID const ptr, byval pv as any ptr, byval dwDestContext as DWORD, byval pvDestContext as any ptr, byval mshlflags as DWORD) as HRESULT
	UnmarshalInterface as function(byval This as IMarshal2 ptr, byval pStm as IStream ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	ReleaseMarshalData as function(byval This as IMarshal2 ptr, byval pStm as IStream ptr) as HRESULT
	DisconnectObject as function(byval This as IMarshal2 ptr, byval dwReserved as DWORD) as HRESULT
end type

type IMarshal2_
	lpVtbl as IMarshal2Vtbl ptr
end type

#define IMarshal2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IMarshal2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IMarshal2_Release(This) (This)->lpVtbl->Release(This)
#define IMarshal2_GetUnmarshalClass(This, riid, pv, dwDestContext, pvDestContext, mshlflags, pCid) (This)->lpVtbl->GetUnmarshalClass(This, riid, pv, dwDestContext, pvDestContext, mshlflags, pCid)
#define IMarshal2_GetMarshalSizeMax(This, riid, pv, dwDestContext, pvDestContext, mshlflags, pSize) (This)->lpVtbl->GetMarshalSizeMax(This, riid, pv, dwDestContext, pvDestContext, mshlflags, pSize)
#define IMarshal2_MarshalInterface(This, pStm, riid, pv, dwDestContext, pvDestContext, mshlflags) (This)->lpVtbl->MarshalInterface(This, pStm, riid, pv, dwDestContext, pvDestContext, mshlflags)
#define IMarshal2_UnmarshalInterface(This, pStm, riid, ppv) (This)->lpVtbl->UnmarshalInterface(This, pStm, riid, ppv)
#define IMarshal2_ReleaseMarshalData(This, pStm) (This)->lpVtbl->ReleaseMarshalData(This, pStm)
#define IMarshal2_DisconnectObject(This, dwReserved) (This)->lpVtbl->DisconnectObject(This, dwReserved)
#define __IMalloc_INTERFACE_DEFINED__
type IMalloc as IMalloc_
type LPMALLOC as IMalloc ptr
extern IID_IMalloc as const GUID

type IMallocVtbl
	QueryInterface as function(byval This as IMalloc ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IMalloc ptr) as ULONG
	Release as function(byval This as IMalloc ptr) as ULONG
	Alloc as function(byval This as IMalloc ptr, byval cb as SIZE_T_) as any ptr
	Realloc as function(byval This as IMalloc ptr, byval pv as any ptr, byval cb as SIZE_T_) as any ptr
	Free as sub(byval This as IMalloc ptr, byval pv as any ptr)
	GetSize as function(byval This as IMalloc ptr, byval pv as any ptr) as SIZE_T_
	DidAlloc as function(byval This as IMalloc ptr, byval pv as any ptr) as long
	HeapMinimize as sub(byval This as IMalloc ptr)
end type

type IMalloc_
	lpVtbl as IMallocVtbl ptr
end type

#define IMalloc_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IMalloc_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IMalloc_Release(This) (This)->lpVtbl->Release(This)
#define IMalloc_Alloc(This, cb) (This)->lpVtbl->Alloc(This, cb)
#define IMalloc_Realloc(This, pv, cb) (This)->lpVtbl->Realloc(This, pv, cb)
#define IMalloc_Free(This, pv) (This)->lpVtbl->Free(This, pv)
#define IMalloc_GetSize(This, pv) (This)->lpVtbl->GetSize(This, pv)
#define IMalloc_DidAlloc(This, pv) (This)->lpVtbl->DidAlloc(This, pv)
#define IMalloc_HeapMinimize(This) (This)->lpVtbl->HeapMinimize(This)

declare function IMalloc_Alloc_Proxy(byval This as IMalloc ptr, byval cb as SIZE_T_) as any ptr
declare sub IMalloc_Alloc_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMalloc_Realloc_Proxy(byval This as IMalloc ptr, byval pv as any ptr, byval cb as SIZE_T_) as any ptr
declare sub IMalloc_Realloc_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare sub IMalloc_Free_Proxy(byval This as IMalloc ptr, byval pv as any ptr)
declare sub IMalloc_Free_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMalloc_GetSize_Proxy(byval This as IMalloc ptr, byval pv as any ptr) as SIZE_T_
declare sub IMalloc_GetSize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMalloc_DidAlloc_Proxy(byval This as IMalloc ptr, byval pv as any ptr) as long
declare sub IMalloc_DidAlloc_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare sub IMalloc_HeapMinimize_Proxy(byval This as IMalloc ptr)
declare sub IMalloc_HeapMinimize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IStdMarshalInfo_INTERFACE_DEFINED__
type IStdMarshalInfo as IStdMarshalInfo_
type LPSTDMARSHALINFO as IStdMarshalInfo ptr
extern IID_IStdMarshalInfo as const GUID

type IStdMarshalInfoVtbl
	QueryInterface as function(byval This as IStdMarshalInfo ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IStdMarshalInfo ptr) as ULONG
	Release as function(byval This as IStdMarshalInfo ptr) as ULONG
	GetClassForHandler as function(byval This as IStdMarshalInfo ptr, byval dwDestContext as DWORD, byval pvDestContext as any ptr, byval pClsid as CLSID ptr) as HRESULT
end type

type IStdMarshalInfo_
	lpVtbl as IStdMarshalInfoVtbl ptr
end type

#define IStdMarshalInfo_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IStdMarshalInfo_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IStdMarshalInfo_Release(This) (This)->lpVtbl->Release(This)
#define IStdMarshalInfo_GetClassForHandler(This, dwDestContext, pvDestContext, pClsid) (This)->lpVtbl->GetClassForHandler(This, dwDestContext, pvDestContext, pClsid)
declare function IStdMarshalInfo_GetClassForHandler_Proxy(byval This as IStdMarshalInfo ptr, byval dwDestContext as DWORD, byval pvDestContext as any ptr, byval pClsid as CLSID ptr) as HRESULT
declare sub IStdMarshalInfo_GetClassForHandler_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IExternalConnection_INTERFACE_DEFINED__
type IExternalConnection as IExternalConnection_
type LPEXTERNALCONNECTION as IExternalConnection ptr

type tagEXTCONN as long
enum
	EXTCONN_STRONG = &h1
	EXTCONN_WEAK = &h2
	EXTCONN_CALLABLE = &h4
end enum

type EXTCONN as tagEXTCONN
extern IID_IExternalConnection as const GUID

type IExternalConnectionVtbl
	QueryInterface as function(byval This as IExternalConnection ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IExternalConnection ptr) as ULONG
	Release as function(byval This as IExternalConnection ptr) as ULONG
	AddConnection as function(byval This as IExternalConnection ptr, byval extconn as DWORD, byval reserved as DWORD) as DWORD
	ReleaseConnection as function(byval This as IExternalConnection ptr, byval extconn as DWORD, byval reserved as DWORD, byval fLastReleaseCloses as WINBOOL) as DWORD
end type

type IExternalConnection_
	lpVtbl as IExternalConnectionVtbl ptr
end type

#define IExternalConnection_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IExternalConnection_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IExternalConnection_Release(This) (This)->lpVtbl->Release(This)
#define IExternalConnection_AddConnection(This, extconn, reserved) (This)->lpVtbl->AddConnection(This, extconn, reserved)
#define IExternalConnection_ReleaseConnection(This, extconn, reserved, fLastReleaseCloses) (This)->lpVtbl->ReleaseConnection(This, extconn, reserved, fLastReleaseCloses)

declare function IExternalConnection_AddConnection_Proxy(byval This as IExternalConnection ptr, byval extconn as DWORD, byval reserved as DWORD) as DWORD
declare sub IExternalConnection_AddConnection_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IExternalConnection_ReleaseConnection_Proxy(byval This as IExternalConnection ptr, byval extconn as DWORD, byval reserved as DWORD, byval fLastReleaseCloses as WINBOOL) as DWORD
declare sub IExternalConnection_ReleaseConnection_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
type IMultiQI as IMultiQI_
type LPMULTIQI as IMultiQI ptr

type tagMULTI_QI
	pIID as const IID ptr
	pItf as IUnknown ptr
	hr as HRESULT
end type

type MULTI_QI as tagMULTI_QI
#define __IMultiQI_INTERFACE_DEFINED__
extern IID_IMultiQI as const GUID

type IMultiQIVtbl
	QueryInterface as function(byval This as IMultiQI ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IMultiQI ptr) as ULONG
	Release as function(byval This as IMultiQI ptr) as ULONG
	QueryMultipleInterfaces as function(byval This as IMultiQI ptr, byval cMQIs as ULONG, byval pMQIs as MULTI_QI ptr) as HRESULT
end type

type IMultiQI_
	lpVtbl as IMultiQIVtbl ptr
end type

#define IMultiQI_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IMultiQI_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IMultiQI_Release(This) (This)->lpVtbl->Release(This)
#define IMultiQI_QueryMultipleInterfaces(This, cMQIs, pMQIs) (This)->lpVtbl->QueryMultipleInterfaces(This, cMQIs, pMQIs)
declare function IMultiQI_QueryMultipleInterfaces_Proxy(byval This as IMultiQI ptr, byval cMQIs as ULONG, byval pMQIs as MULTI_QI ptr) as HRESULT
declare sub IMultiQI_QueryMultipleInterfaces_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __AsyncIMultiQI_INTERFACE_DEFINED__
extern IID_AsyncIMultiQI as const GUID
type AsyncIMultiQI as AsyncIMultiQI_

type AsyncIMultiQIVtbl
	QueryInterface as function(byval This as AsyncIMultiQI ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as AsyncIMultiQI ptr) as ULONG
	Release as function(byval This as AsyncIMultiQI ptr) as ULONG
	Begin_QueryMultipleInterfaces as sub(byval This as AsyncIMultiQI ptr, byval cMQIs as ULONG, byval pMQIs as MULTI_QI ptr)
	Finish_QueryMultipleInterfaces as function(byval This as AsyncIMultiQI ptr, byval pMQIs as MULTI_QI ptr) as HRESULT
end type

type AsyncIMultiQI_
	lpVtbl as AsyncIMultiQIVtbl ptr
end type

#define AsyncIMultiQI_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define AsyncIMultiQI_AddRef(This) (This)->lpVtbl->AddRef(This)
#define AsyncIMultiQI_Release(This) (This)->lpVtbl->Release(This)
#define AsyncIMultiQI_Begin_QueryMultipleInterfaces(This, cMQIs, pMQIs) (This)->lpVtbl->Begin_QueryMultipleInterfaces(This, cMQIs, pMQIs)
#define AsyncIMultiQI_Finish_QueryMultipleInterfaces(This, pMQIs) (This)->lpVtbl->Finish_QueryMultipleInterfaces(This, pMQIs)

declare function AsyncIMultiQI_Begin_QueryMultipleInterfaces_Proxy(byval This as IMultiQI ptr, byval cMQIs as ULONG, byval pMQIs as MULTI_QI ptr) as HRESULT
declare sub AsyncIMultiQI_Begin_QueryMultipleInterfaces_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function AsyncIMultiQI_Finish_QueryMultipleInterfaces_Proxy(byval This as IMultiQI ptr, byval cMQIs as ULONG, byval pMQIs as MULTI_QI ptr) as HRESULT
declare sub AsyncIMultiQI_Finish_QueryMultipleInterfaces_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IInternalUnknown_INTERFACE_DEFINED__
extern IID_IInternalUnknown as const GUID
type IInternalUnknown as IInternalUnknown_

type IInternalUnknownVtbl
	QueryInterface as function(byval This as IInternalUnknown ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IInternalUnknown ptr) as ULONG
	Release as function(byval This as IInternalUnknown ptr) as ULONG
	QueryInternalInterface as function(byval This as IInternalUnknown ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
end type

type IInternalUnknown_
	lpVtbl as IInternalUnknownVtbl ptr
end type

#define IInternalUnknown_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IInternalUnknown_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IInternalUnknown_Release(This) (This)->lpVtbl->Release(This)
#define IInternalUnknown_QueryInternalInterface(This, riid, ppv) (This)->lpVtbl->QueryInternalInterface(This, riid, ppv)
declare function IInternalUnknown_QueryInternalInterface_Proxy(byval This as IInternalUnknown ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IInternalUnknown_QueryInternalInterface_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IEnumUnknown_INTERFACE_DEFINED__
type IEnumUnknown as IEnumUnknown_
type LPENUMUNKNOWN as IEnumUnknown ptr
extern IID_IEnumUnknown as const GUID

type IEnumUnknownVtbl
	QueryInterface as function(byval This as IEnumUnknown ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEnumUnknown ptr) as ULONG
	Release as function(byval This as IEnumUnknown ptr) as ULONG
	Next as function(byval This as IEnumUnknown ptr, byval celt as ULONG, byval rgelt as IUnknown ptr ptr, byval pceltFetched as ULONG ptr) as HRESULT
	Skip as function(byval This as IEnumUnknown ptr, byval celt as ULONG) as HRESULT
	Reset as function(byval This as IEnumUnknown ptr) as HRESULT
	Clone as function(byval This as IEnumUnknown ptr, byval ppenum as IEnumUnknown ptr ptr) as HRESULT
end type

type IEnumUnknown_
	lpVtbl as IEnumUnknownVtbl ptr
end type

#define IEnumUnknown_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IEnumUnknown_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IEnumUnknown_Release(This) (This)->lpVtbl->Release(This)
#define IEnumUnknown_Next(This, celt, rgelt, pceltFetched) (This)->lpVtbl->Next(This, celt, rgelt, pceltFetched)
#define IEnumUnknown_Skip(This, celt) (This)->lpVtbl->Skip(This, celt)
#define IEnumUnknown_Reset(This) (This)->lpVtbl->Reset(This)
#define IEnumUnknown_Clone(This, ppenum) (This)->lpVtbl->Clone(This, ppenum)

declare function IEnumUnknown_RemoteNext_Proxy(byval This as IEnumUnknown ptr, byval celt as ULONG, byval rgelt as IUnknown ptr ptr, byval pceltFetched as ULONG ptr) as HRESULT
declare sub IEnumUnknown_RemoteNext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumUnknown_Skip_Proxy(byval This as IEnumUnknown ptr, byval celt as ULONG) as HRESULT
declare sub IEnumUnknown_Skip_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumUnknown_Reset_Proxy(byval This as IEnumUnknown ptr) as HRESULT
declare sub IEnumUnknown_Reset_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumUnknown_Clone_Proxy(byval This as IEnumUnknown ptr, byval ppenum as IEnumUnknown ptr ptr) as HRESULT
declare sub IEnumUnknown_Clone_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumUnknown_Next_Proxy(byval This as IEnumUnknown ptr, byval celt as ULONG, byval rgelt as IUnknown ptr ptr, byval pceltFetched as ULONG ptr) as HRESULT
declare function IEnumUnknown_Next_Stub(byval This as IEnumUnknown ptr, byval celt as ULONG, byval rgelt as IUnknown ptr ptr, byval pceltFetched as ULONG ptr) as HRESULT
#define __IEnumString_INTERFACE_DEFINED__
type IEnumString as IEnumString_
type LPENUMSTRING as IEnumString ptr
extern IID_IEnumString as const GUID

type IEnumStringVtbl
	QueryInterface as function(byval This as IEnumString ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEnumString ptr) as ULONG
	Release as function(byval This as IEnumString ptr) as ULONG
	Next as function(byval This as IEnumString ptr, byval celt as ULONG, byval rgelt as LPOLESTR ptr, byval pceltFetched as ULONG ptr) as HRESULT
	Skip as function(byval This as IEnumString ptr, byval celt as ULONG) as HRESULT
	Reset as function(byval This as IEnumString ptr) as HRESULT
	Clone as function(byval This as IEnumString ptr, byval ppenum as IEnumString ptr ptr) as HRESULT
end type

type IEnumString_
	lpVtbl as IEnumStringVtbl ptr
end type

#define IEnumString_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IEnumString_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IEnumString_Release(This) (This)->lpVtbl->Release(This)
#define IEnumString_Next(This, celt, rgelt, pceltFetched) (This)->lpVtbl->Next(This, celt, rgelt, pceltFetched)
#define IEnumString_Skip(This, celt) (This)->lpVtbl->Skip(This, celt)
#define IEnumString_Reset(This) (This)->lpVtbl->Reset(This)
#define IEnumString_Clone(This, ppenum) (This)->lpVtbl->Clone(This, ppenum)

declare function IEnumString_RemoteNext_Proxy(byval This as IEnumString ptr, byval celt as ULONG, byval rgelt as LPOLESTR ptr, byval pceltFetched as ULONG ptr) as HRESULT
declare sub IEnumString_RemoteNext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumString_Skip_Proxy(byval This as IEnumString ptr, byval celt as ULONG) as HRESULT
declare sub IEnumString_Skip_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumString_Reset_Proxy(byval This as IEnumString ptr) as HRESULT
declare sub IEnumString_Reset_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumString_Clone_Proxy(byval This as IEnumString ptr, byval ppenum as IEnumString ptr ptr) as HRESULT
declare sub IEnumString_Clone_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumString_Next_Proxy(byval This as IEnumString ptr, byval celt as ULONG, byval rgelt as LPOLESTR ptr, byval pceltFetched as ULONG ptr) as HRESULT
declare function IEnumString_Next_Stub(byval This as IEnumString ptr, byval celt as ULONG, byval rgelt as LPOLESTR ptr, byval pceltFetched as ULONG ptr) as HRESULT
#define __ISequentialStream_INTERFACE_DEFINED__
extern IID_ISequentialStream as const GUID
type ISequentialStream as ISequentialStream_

type ISequentialStreamVtbl
	QueryInterface as function(byval This as ISequentialStream ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ISequentialStream ptr) as ULONG
	Release as function(byval This as ISequentialStream ptr) as ULONG
	Read as function(byval This as ISequentialStream ptr, byval pv as any ptr, byval cb as ULONG, byval pcbRead as ULONG ptr) as HRESULT
	Write as function(byval This as ISequentialStream ptr, byval pv as const any ptr, byval cb as ULONG, byval pcbWritten as ULONG ptr) as HRESULT
end type

type ISequentialStream_
	lpVtbl as ISequentialStreamVtbl ptr
end type

#define ISequentialStream_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define ISequentialStream_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ISequentialStream_Release(This) (This)->lpVtbl->Release(This)
#define ISequentialStream_Read(This, pv, cb, pcbRead) (This)->lpVtbl->Read(This, pv, cb, pcbRead)
#define ISequentialStream_Write(This, pv, cb, pcbWritten) (This)->lpVtbl->Write(This, pv, cb, pcbWritten)

declare function ISequentialStream_RemoteRead_Proxy(byval This as ISequentialStream ptr, byval pv as ubyte ptr, byval cb as ULONG, byval pcbRead as ULONG ptr) as HRESULT
declare sub ISequentialStream_RemoteRead_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ISequentialStream_RemoteWrite_Proxy(byval This as ISequentialStream ptr, byval pv as const ubyte ptr, byval cb as ULONG, byval pcbWritten as ULONG ptr) as HRESULT
declare sub ISequentialStream_RemoteWrite_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ISequentialStream_Read_Proxy(byval This as ISequentialStream ptr, byval pv as any ptr, byval cb as ULONG, byval pcbRead as ULONG ptr) as HRESULT
declare function ISequentialStream_Read_Stub(byval This as ISequentialStream ptr, byval pv as ubyte ptr, byval cb as ULONG, byval pcbRead as ULONG ptr) as HRESULT
declare function ISequentialStream_Write_Proxy(byval This as ISequentialStream ptr, byval pv as const any ptr, byval cb as ULONG, byval pcbWritten as ULONG ptr) as HRESULT
declare function ISequentialStream_Write_Stub(byval This as ISequentialStream ptr, byval pv as const ubyte ptr, byval cb as ULONG, byval pcbWritten as ULONG ptr) as HRESULT
#define __IStream_INTERFACE_DEFINED__
type LPSTREAM as IStream ptr

type tagSTATSTG
	pwcsName as LPOLESTR
	as DWORD type
	cbSize as ULARGE_INTEGER
	mtime as FILETIME
	ctime as FILETIME
	atime as FILETIME
	grfMode as DWORD
	grfLocksSupported as DWORD
	clsid as CLSID
	grfStateBits as DWORD
	reserved as DWORD
end type

type STATSTG as tagSTATSTG

type tagSTGTY as long
enum
	STGTY_STORAGE = 1
	STGTY_STREAM = 2
	STGTY_LOCKBYTES = 3
	STGTY_PROPERTY = 4
end enum

type STGTY as tagSTGTY

type tagSTREAM_SEEK as long
enum
	STREAM_SEEK_SET = 0
	STREAM_SEEK_CUR = 1
	STREAM_SEEK_END = 2
end enum

type STREAM_SEEK as tagSTREAM_SEEK

type tagLOCKTYPE as long
enum
	LOCK_WRITE = 1
	LOCK_EXCLUSIVE = 2
	LOCK_ONLYONCE = 4
end enum

type LOCKTYPE as tagLOCKTYPE
extern IID_IStream as const GUID

type IStreamVtbl
	QueryInterface as function(byval This as IStream ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IStream ptr) as ULONG
	Release as function(byval This as IStream ptr) as ULONG
	Read as function(byval This as IStream ptr, byval pv as any ptr, byval cb as ULONG, byval pcbRead as ULONG ptr) as HRESULT
	Write as function(byval This as IStream ptr, byval pv as const any ptr, byval cb as ULONG, byval pcbWritten as ULONG ptr) as HRESULT
	Seek as function(byval This as IStream ptr, byval dlibMove as LARGE_INTEGER, byval dwOrigin as DWORD, byval plibNewPosition as ULARGE_INTEGER ptr) as HRESULT
	SetSize as function(byval This as IStream ptr, byval libNewSize as ULARGE_INTEGER) as HRESULT
	CopyTo as function(byval This as IStream ptr, byval pstm as IStream ptr, byval cb as ULARGE_INTEGER, byval pcbRead as ULARGE_INTEGER ptr, byval pcbWritten as ULARGE_INTEGER ptr) as HRESULT
	Commit as function(byval This as IStream ptr, byval grfCommitFlags as DWORD) as HRESULT
	Revert as function(byval This as IStream ptr) as HRESULT
	LockRegion as function(byval This as IStream ptr, byval libOffset as ULARGE_INTEGER, byval cb as ULARGE_INTEGER, byval dwLockType as DWORD) as HRESULT
	UnlockRegion as function(byval This as IStream ptr, byval libOffset as ULARGE_INTEGER, byval cb as ULARGE_INTEGER, byval dwLockType as DWORD) as HRESULT
	Stat as function(byval This as IStream ptr, byval pstatstg as STATSTG ptr, byval grfStatFlag as DWORD) as HRESULT
	Clone as function(byval This as IStream ptr, byval ppstm as IStream ptr ptr) as HRESULT
end type

type IStream_
	lpVtbl as IStreamVtbl ptr
end type

#define IStream_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IStream_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IStream_Release(This) (This)->lpVtbl->Release(This)
#define IStream_Read(This, pv, cb, pcbRead) (This)->lpVtbl->Read(This, pv, cb, pcbRead)
#define IStream_Write(This, pv, cb, pcbWritten) (This)->lpVtbl->Write(This, pv, cb, pcbWritten)
#define IStream_Seek(This, dlibMove, dwOrigin, plibNewPosition) (This)->lpVtbl->Seek(This, dlibMove, dwOrigin, plibNewPosition)
#define IStream_SetSize(This, libNewSize) (This)->lpVtbl->SetSize(This, libNewSize)
#define IStream_CopyTo(This, pstm, cb, pcbRead, pcbWritten) (This)->lpVtbl->CopyTo(This, pstm, cb, pcbRead, pcbWritten)
#define IStream_Commit(This, grfCommitFlags) (This)->lpVtbl->Commit(This, grfCommitFlags)
#define IStream_Revert(This) (This)->lpVtbl->Revert(This)
#define IStream_LockRegion(This, libOffset, cb, dwLockType) (This)->lpVtbl->LockRegion(This, libOffset, cb, dwLockType)
#define IStream_UnlockRegion(This, libOffset, cb, dwLockType) (This)->lpVtbl->UnlockRegion(This, libOffset, cb, dwLockType)
#define IStream_Stat(This, pstatstg, grfStatFlag) (This)->lpVtbl->Stat(This, pstatstg, grfStatFlag)
#define IStream_Clone(This, ppstm) (This)->lpVtbl->Clone(This, ppstm)

declare function IStream_RemoteSeek_Proxy(byval This as IStream ptr, byval dlibMove as LARGE_INTEGER, byval dwOrigin as DWORD, byval plibNewPosition as ULARGE_INTEGER ptr) as HRESULT
declare sub IStream_RemoteSeek_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IStream_SetSize_Proxy(byval This as IStream ptr, byval libNewSize as ULARGE_INTEGER) as HRESULT
declare sub IStream_SetSize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IStream_RemoteCopyTo_Proxy(byval This as IStream ptr, byval pstm as IStream ptr, byval cb as ULARGE_INTEGER, byval pcbRead as ULARGE_INTEGER ptr, byval pcbWritten as ULARGE_INTEGER ptr) as HRESULT
declare sub IStream_RemoteCopyTo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IStream_Commit_Proxy(byval This as IStream ptr, byval grfCommitFlags as DWORD) as HRESULT
declare sub IStream_Commit_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IStream_Revert_Proxy(byval This as IStream ptr) as HRESULT
declare sub IStream_Revert_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IStream_LockRegion_Proxy(byval This as IStream ptr, byval libOffset as ULARGE_INTEGER, byval cb as ULARGE_INTEGER, byval dwLockType as DWORD) as HRESULT
declare sub IStream_LockRegion_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IStream_UnlockRegion_Proxy(byval This as IStream ptr, byval libOffset as ULARGE_INTEGER, byval cb as ULARGE_INTEGER, byval dwLockType as DWORD) as HRESULT
declare sub IStream_UnlockRegion_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IStream_Stat_Proxy(byval This as IStream ptr, byval pstatstg as STATSTG ptr, byval grfStatFlag as DWORD) as HRESULT
declare sub IStream_Stat_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IStream_Clone_Proxy(byval This as IStream ptr, byval ppstm as IStream ptr ptr) as HRESULT
declare sub IStream_Clone_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IStream_Seek_Proxy(byval This as IStream ptr, byval dlibMove as LARGE_INTEGER, byval dwOrigin as DWORD, byval plibNewPosition as ULARGE_INTEGER ptr) as HRESULT
declare function IStream_Seek_Stub(byval This as IStream ptr, byval dlibMove as LARGE_INTEGER, byval dwOrigin as DWORD, byval plibNewPosition as ULARGE_INTEGER ptr) as HRESULT
declare function IStream_CopyTo_Proxy(byval This as IStream ptr, byval pstm as IStream ptr, byval cb as ULARGE_INTEGER, byval pcbRead as ULARGE_INTEGER ptr, byval pcbWritten as ULARGE_INTEGER ptr) as HRESULT
declare function IStream_CopyTo_Stub(byval This as IStream ptr, byval pstm as IStream ptr, byval cb as ULARGE_INTEGER, byval pcbRead as ULARGE_INTEGER ptr, byval pcbWritten as ULARGE_INTEGER ptr) as HRESULT
#define __IRpcChannelBuffer_INTERFACE_DEFINED__
type RPCOLEDATAREP as ULONG

type tagRPCOLEMESSAGE
	reserved1 as any ptr
	dataRepresentation as RPCOLEDATAREP
	Buffer as any ptr
	cbBuffer as ULONG
	iMethod as ULONG
	reserved2(0 to 4) as any ptr
	rpcFlags as ULONG
end type

type RPCOLEMESSAGE as tagRPCOLEMESSAGE
type PRPCOLEMESSAGE as RPCOLEMESSAGE ptr
extern IID_IRpcChannelBuffer as const GUID

type IRpcChannelBufferVtbl
	QueryInterface as function(byval This as IRpcChannelBuffer ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IRpcChannelBuffer ptr) as ULONG
	Release as function(byval This as IRpcChannelBuffer ptr) as ULONG
	GetBuffer as function(byval This as IRpcChannelBuffer ptr, byval pMessage as RPCOLEMESSAGE ptr, byval riid as const IID const ptr) as HRESULT
	SendReceive as function(byval This as IRpcChannelBuffer ptr, byval pMessage as RPCOLEMESSAGE ptr, byval pStatus as ULONG ptr) as HRESULT
	FreeBuffer as function(byval This as IRpcChannelBuffer ptr, byval pMessage as RPCOLEMESSAGE ptr) as HRESULT
	GetDestCtx as function(byval This as IRpcChannelBuffer ptr, byval pdwDestContext as DWORD ptr, byval ppvDestContext as any ptr ptr) as HRESULT
	IsConnected as function(byval This as IRpcChannelBuffer ptr) as HRESULT
end type

type IRpcChannelBuffer_
	lpVtbl as IRpcChannelBufferVtbl ptr
end type

#define IRpcChannelBuffer_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IRpcChannelBuffer_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IRpcChannelBuffer_Release(This) (This)->lpVtbl->Release(This)
#define IRpcChannelBuffer_GetBuffer(This, pMessage, riid) (This)->lpVtbl->GetBuffer(This, pMessage, riid)
#define IRpcChannelBuffer_SendReceive(This, pMessage, pStatus) (This)->lpVtbl->SendReceive(This, pMessage, pStatus)
#define IRpcChannelBuffer_FreeBuffer(This, pMessage) (This)->lpVtbl->FreeBuffer(This, pMessage)
#define IRpcChannelBuffer_GetDestCtx(This, pdwDestContext, ppvDestContext) (This)->lpVtbl->GetDestCtx(This, pdwDestContext, ppvDestContext)
#define IRpcChannelBuffer_IsConnected(This) (This)->lpVtbl->IsConnected(This)

declare function IRpcChannelBuffer_GetBuffer_Proxy(byval This as IRpcChannelBuffer ptr, byval pMessage as RPCOLEMESSAGE ptr, byval riid as const IID const ptr) as HRESULT
declare sub IRpcChannelBuffer_GetBuffer_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRpcChannelBuffer_SendReceive_Proxy(byval This as IRpcChannelBuffer ptr, byval pMessage as RPCOLEMESSAGE ptr, byval pStatus as ULONG ptr) as HRESULT
declare sub IRpcChannelBuffer_SendReceive_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRpcChannelBuffer_FreeBuffer_Proxy(byval This as IRpcChannelBuffer ptr, byval pMessage as RPCOLEMESSAGE ptr) as HRESULT
declare sub IRpcChannelBuffer_FreeBuffer_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRpcChannelBuffer_GetDestCtx_Proxy(byval This as IRpcChannelBuffer ptr, byval pdwDestContext as DWORD ptr, byval ppvDestContext as any ptr ptr) as HRESULT
declare sub IRpcChannelBuffer_GetDestCtx_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRpcChannelBuffer_IsConnected_Proxy(byval This as IRpcChannelBuffer ptr) as HRESULT
declare sub IRpcChannelBuffer_IsConnected_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IRpcChannelBuffer2_INTERFACE_DEFINED__
extern IID_IRpcChannelBuffer2 as const GUID
type IRpcChannelBuffer2 as IRpcChannelBuffer2_

type IRpcChannelBuffer2Vtbl
	QueryInterface as function(byval This as IRpcChannelBuffer2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IRpcChannelBuffer2 ptr) as ULONG
	Release as function(byval This as IRpcChannelBuffer2 ptr) as ULONG
	GetBuffer as function(byval This as IRpcChannelBuffer2 ptr, byval pMessage as RPCOLEMESSAGE ptr, byval riid as const IID const ptr) as HRESULT
	SendReceive as function(byval This as IRpcChannelBuffer2 ptr, byval pMessage as RPCOLEMESSAGE ptr, byval pStatus as ULONG ptr) as HRESULT
	FreeBuffer as function(byval This as IRpcChannelBuffer2 ptr, byval pMessage as RPCOLEMESSAGE ptr) as HRESULT
	GetDestCtx as function(byval This as IRpcChannelBuffer2 ptr, byval pdwDestContext as DWORD ptr, byval ppvDestContext as any ptr ptr) as HRESULT
	IsConnected as function(byval This as IRpcChannelBuffer2 ptr) as HRESULT
	GetProtocolVersion as function(byval This as IRpcChannelBuffer2 ptr, byval pdwVersion as DWORD ptr) as HRESULT
end type

type IRpcChannelBuffer2_
	lpVtbl as IRpcChannelBuffer2Vtbl ptr
end type

#define IRpcChannelBuffer2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IRpcChannelBuffer2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IRpcChannelBuffer2_Release(This) (This)->lpVtbl->Release(This)
#define IRpcChannelBuffer2_GetBuffer(This, pMessage, riid) (This)->lpVtbl->GetBuffer(This, pMessage, riid)
#define IRpcChannelBuffer2_SendReceive(This, pMessage, pStatus) (This)->lpVtbl->SendReceive(This, pMessage, pStatus)
#define IRpcChannelBuffer2_FreeBuffer(This, pMessage) (This)->lpVtbl->FreeBuffer(This, pMessage)
#define IRpcChannelBuffer2_GetDestCtx(This, pdwDestContext, ppvDestContext) (This)->lpVtbl->GetDestCtx(This, pdwDestContext, ppvDestContext)
#define IRpcChannelBuffer2_IsConnected(This) (This)->lpVtbl->IsConnected(This)
#define IRpcChannelBuffer2_GetProtocolVersion(This, pdwVersion) (This)->lpVtbl->GetProtocolVersion(This, pdwVersion)
declare function IRpcChannelBuffer2_GetProtocolVersion_Proxy(byval This as IRpcChannelBuffer2 ptr, byval pdwVersion as DWORD ptr) as HRESULT
declare sub IRpcChannelBuffer2_GetProtocolVersion_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IAsyncRpcChannelBuffer_INTERFACE_DEFINED__
extern IID_IAsyncRpcChannelBuffer as const GUID
type IAsyncRpcChannelBuffer as IAsyncRpcChannelBuffer_
type ISynchronize as ISynchronize_

type IAsyncRpcChannelBufferVtbl
	QueryInterface as function(byval This as IAsyncRpcChannelBuffer ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAsyncRpcChannelBuffer ptr) as ULONG
	Release as function(byval This as IAsyncRpcChannelBuffer ptr) as ULONG
	GetBuffer as function(byval This as IAsyncRpcChannelBuffer ptr, byval pMessage as RPCOLEMESSAGE ptr, byval riid as const IID const ptr) as HRESULT
	SendReceive as function(byval This as IAsyncRpcChannelBuffer ptr, byval pMessage as RPCOLEMESSAGE ptr, byval pStatus as ULONG ptr) as HRESULT
	FreeBuffer as function(byval This as IAsyncRpcChannelBuffer ptr, byval pMessage as RPCOLEMESSAGE ptr) as HRESULT
	GetDestCtx as function(byval This as IAsyncRpcChannelBuffer ptr, byval pdwDestContext as DWORD ptr, byval ppvDestContext as any ptr ptr) as HRESULT
	IsConnected as function(byval This as IAsyncRpcChannelBuffer ptr) as HRESULT
	GetProtocolVersion as function(byval This as IAsyncRpcChannelBuffer ptr, byval pdwVersion as DWORD ptr) as HRESULT
	Send as function(byval This as IAsyncRpcChannelBuffer ptr, byval pMsg as RPCOLEMESSAGE ptr, byval pSync as ISynchronize ptr, byval pulStatus as ULONG ptr) as HRESULT
	Receive as function(byval This as IAsyncRpcChannelBuffer ptr, byval pMsg as RPCOLEMESSAGE ptr, byval pulStatus as ULONG ptr) as HRESULT
	GetDestCtxEx as function(byval This as IAsyncRpcChannelBuffer ptr, byval pMsg as RPCOLEMESSAGE ptr, byval pdwDestContext as DWORD ptr, byval ppvDestContext as any ptr ptr) as HRESULT
end type

type IAsyncRpcChannelBuffer_
	lpVtbl as IAsyncRpcChannelBufferVtbl ptr
end type

#define IAsyncRpcChannelBuffer_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IAsyncRpcChannelBuffer_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IAsyncRpcChannelBuffer_Release(This) (This)->lpVtbl->Release(This)
#define IAsyncRpcChannelBuffer_GetBuffer(This, pMessage, riid) (This)->lpVtbl->GetBuffer(This, pMessage, riid)
#define IAsyncRpcChannelBuffer_SendReceive(This, pMessage, pStatus) (This)->lpVtbl->SendReceive(This, pMessage, pStatus)
#define IAsyncRpcChannelBuffer_FreeBuffer(This, pMessage) (This)->lpVtbl->FreeBuffer(This, pMessage)
#define IAsyncRpcChannelBuffer_GetDestCtx(This, pdwDestContext, ppvDestContext) (This)->lpVtbl->GetDestCtx(This, pdwDestContext, ppvDestContext)
#define IAsyncRpcChannelBuffer_IsConnected(This) (This)->lpVtbl->IsConnected(This)
#define IAsyncRpcChannelBuffer_GetProtocolVersion(This, pdwVersion) (This)->lpVtbl->GetProtocolVersion(This, pdwVersion)
#define IAsyncRpcChannelBuffer_Send(This, pMsg, pSync, pulStatus) (This)->lpVtbl->Send(This, pMsg, pSync, pulStatus)
#define IAsyncRpcChannelBuffer_Receive(This, pMsg, pulStatus) (This)->lpVtbl->Receive(This, pMsg, pulStatus)
#define IAsyncRpcChannelBuffer_GetDestCtxEx(This, pMsg, pdwDestContext, ppvDestContext) (This)->lpVtbl->GetDestCtxEx(This, pMsg, pdwDestContext, ppvDestContext)

declare function IAsyncRpcChannelBuffer_Send_Proxy(byval This as IAsyncRpcChannelBuffer ptr, byval pMsg as RPCOLEMESSAGE ptr, byval pSync as ISynchronize ptr, byval pulStatus as ULONG ptr) as HRESULT
declare sub IAsyncRpcChannelBuffer_Send_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAsyncRpcChannelBuffer_Receive_Proxy(byval This as IAsyncRpcChannelBuffer ptr, byval pMsg as RPCOLEMESSAGE ptr, byval pulStatus as ULONG ptr) as HRESULT
declare sub IAsyncRpcChannelBuffer_Receive_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAsyncRpcChannelBuffer_GetDestCtxEx_Proxy(byval This as IAsyncRpcChannelBuffer ptr, byval pMsg as RPCOLEMESSAGE ptr, byval pdwDestContext as DWORD ptr, byval ppvDestContext as any ptr ptr) as HRESULT
declare sub IAsyncRpcChannelBuffer_GetDestCtxEx_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IRpcChannelBuffer3_INTERFACE_DEFINED__
extern IID_IRpcChannelBuffer3 as const GUID
type IRpcChannelBuffer3 as IRpcChannelBuffer3_
type IAsyncManager as IAsyncManager_

type IRpcChannelBuffer3Vtbl
	QueryInterface as function(byval This as IRpcChannelBuffer3 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IRpcChannelBuffer3 ptr) as ULONG
	Release as function(byval This as IRpcChannelBuffer3 ptr) as ULONG
	GetBuffer as function(byval This as IRpcChannelBuffer3 ptr, byval pMessage as RPCOLEMESSAGE ptr, byval riid as const IID const ptr) as HRESULT
	SendReceive as function(byval This as IRpcChannelBuffer3 ptr, byval pMessage as RPCOLEMESSAGE ptr, byval pStatus as ULONG ptr) as HRESULT
	FreeBuffer as function(byval This as IRpcChannelBuffer3 ptr, byval pMessage as RPCOLEMESSAGE ptr) as HRESULT
	GetDestCtx as function(byval This as IRpcChannelBuffer3 ptr, byval pdwDestContext as DWORD ptr, byval ppvDestContext as any ptr ptr) as HRESULT
	IsConnected as function(byval This as IRpcChannelBuffer3 ptr) as HRESULT
	GetProtocolVersion as function(byval This as IRpcChannelBuffer3 ptr, byval pdwVersion as DWORD ptr) as HRESULT
	Send as function(byval This as IRpcChannelBuffer3 ptr, byval pMsg as RPCOLEMESSAGE ptr, byval pulStatus as ULONG ptr) as HRESULT
	Receive as function(byval This as IRpcChannelBuffer3 ptr, byval pMsg as RPCOLEMESSAGE ptr, byval ulSize as ULONG, byval pulStatus as ULONG ptr) as HRESULT
	Cancel as function(byval This as IRpcChannelBuffer3 ptr, byval pMsg as RPCOLEMESSAGE ptr) as HRESULT
	GetCallContext as function(byval This as IRpcChannelBuffer3 ptr, byval pMsg as RPCOLEMESSAGE ptr, byval riid as const IID const ptr, byval pInterface as any ptr ptr) as HRESULT
	GetDestCtxEx as function(byval This as IRpcChannelBuffer3 ptr, byval pMsg as RPCOLEMESSAGE ptr, byval pdwDestContext as DWORD ptr, byval ppvDestContext as any ptr ptr) as HRESULT
	GetState as function(byval This as IRpcChannelBuffer3 ptr, byval pMsg as RPCOLEMESSAGE ptr, byval pState as DWORD ptr) as HRESULT
	RegisterAsync as function(byval This as IRpcChannelBuffer3 ptr, byval pMsg as RPCOLEMESSAGE ptr, byval pAsyncMgr as IAsyncManager ptr) as HRESULT
end type

type IRpcChannelBuffer3_
	lpVtbl as IRpcChannelBuffer3Vtbl ptr
end type

#define IRpcChannelBuffer3_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IRpcChannelBuffer3_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IRpcChannelBuffer3_Release(This) (This)->lpVtbl->Release(This)
#define IRpcChannelBuffer3_GetBuffer(This, pMessage, riid) (This)->lpVtbl->GetBuffer(This, pMessage, riid)
#define IRpcChannelBuffer3_SendReceive(This, pMessage, pStatus) (This)->lpVtbl->SendReceive(This, pMessage, pStatus)
#define IRpcChannelBuffer3_FreeBuffer(This, pMessage) (This)->lpVtbl->FreeBuffer(This, pMessage)
#define IRpcChannelBuffer3_GetDestCtx(This, pdwDestContext, ppvDestContext) (This)->lpVtbl->GetDestCtx(This, pdwDestContext, ppvDestContext)
#define IRpcChannelBuffer3_IsConnected(This) (This)->lpVtbl->IsConnected(This)
#define IRpcChannelBuffer3_GetProtocolVersion(This, pdwVersion) (This)->lpVtbl->GetProtocolVersion(This, pdwVersion)
#define IRpcChannelBuffer3_Send(This, pMsg, pulStatus) (This)->lpVtbl->Send(This, pMsg, pulStatus)
#define IRpcChannelBuffer3_Receive(This, pMsg, ulSize, pulStatus) (This)->lpVtbl->Receive(This, pMsg, ulSize, pulStatus)
#define IRpcChannelBuffer3_Cancel(This, pMsg) (This)->lpVtbl->Cancel(This, pMsg)
#define IRpcChannelBuffer3_GetCallContext(This, pMsg, riid, pInterface) (This)->lpVtbl->GetCallContext(This, pMsg, riid, pInterface)
#define IRpcChannelBuffer3_GetDestCtxEx(This, pMsg, pdwDestContext, ppvDestContext) (This)->lpVtbl->GetDestCtxEx(This, pMsg, pdwDestContext, ppvDestContext)
#define IRpcChannelBuffer3_GetState(This, pMsg, pState) (This)->lpVtbl->GetState(This, pMsg, pState)
#define IRpcChannelBuffer3_RegisterAsync(This, pMsg, pAsyncMgr) (This)->lpVtbl->RegisterAsync(This, pMsg, pAsyncMgr)

declare function IRpcChannelBuffer3_Send_Proxy(byval This as IRpcChannelBuffer3 ptr, byval pMsg as RPCOLEMESSAGE ptr, byval pulStatus as ULONG ptr) as HRESULT
declare sub IRpcChannelBuffer3_Send_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRpcChannelBuffer3_Receive_Proxy(byval This as IRpcChannelBuffer3 ptr, byval pMsg as RPCOLEMESSAGE ptr, byval ulSize as ULONG, byval pulStatus as ULONG ptr) as HRESULT
declare sub IRpcChannelBuffer3_Receive_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRpcChannelBuffer3_Cancel_Proxy(byval This as IRpcChannelBuffer3 ptr, byval pMsg as RPCOLEMESSAGE ptr) as HRESULT
declare sub IRpcChannelBuffer3_Cancel_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRpcChannelBuffer3_GetCallContext_Proxy(byval This as IRpcChannelBuffer3 ptr, byval pMsg as RPCOLEMESSAGE ptr, byval riid as const IID const ptr, byval pInterface as any ptr ptr) as HRESULT
declare sub IRpcChannelBuffer3_GetCallContext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRpcChannelBuffer3_GetDestCtxEx_Proxy(byval This as IRpcChannelBuffer3 ptr, byval pMsg as RPCOLEMESSAGE ptr, byval pdwDestContext as DWORD ptr, byval ppvDestContext as any ptr ptr) as HRESULT
declare sub IRpcChannelBuffer3_GetDestCtxEx_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRpcChannelBuffer3_GetState_Proxy(byval This as IRpcChannelBuffer3 ptr, byval pMsg as RPCOLEMESSAGE ptr, byval pState as DWORD ptr) as HRESULT
declare sub IRpcChannelBuffer3_GetState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRpcChannelBuffer3_RegisterAsync_Proxy(byval This as IRpcChannelBuffer3 ptr, byval pMsg as RPCOLEMESSAGE ptr, byval pAsyncMgr as IAsyncManager ptr) as HRESULT
declare sub IRpcChannelBuffer3_RegisterAsync_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IRpcSyntaxNegotiate_INTERFACE_DEFINED__
extern IID_IRpcSyntaxNegotiate as const GUID
type IRpcSyntaxNegotiate as IRpcSyntaxNegotiate_

type IRpcSyntaxNegotiateVtbl
	QueryInterface as function(byval This as IRpcSyntaxNegotiate ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IRpcSyntaxNegotiate ptr) as ULONG
	Release as function(byval This as IRpcSyntaxNegotiate ptr) as ULONG
	NegotiateSyntax as function(byval This as IRpcSyntaxNegotiate ptr, byval pMsg as RPCOLEMESSAGE ptr) as HRESULT
end type

type IRpcSyntaxNegotiate_
	lpVtbl as IRpcSyntaxNegotiateVtbl ptr
end type

#define IRpcSyntaxNegotiate_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IRpcSyntaxNegotiate_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IRpcSyntaxNegotiate_Release(This) (This)->lpVtbl->Release(This)
#define IRpcSyntaxNegotiate_NegotiateSyntax(This, pMsg) (This)->lpVtbl->NegotiateSyntax(This, pMsg)
declare function IRpcSyntaxNegotiate_NegotiateSyntax_Proxy(byval This as IRpcSyntaxNegotiate ptr, byval pMsg as RPCOLEMESSAGE ptr) as HRESULT
declare sub IRpcSyntaxNegotiate_NegotiateSyntax_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IRpcProxyBuffer_INTERFACE_DEFINED__
extern IID_IRpcProxyBuffer as const GUID
type IRpcProxyBuffer as IRpcProxyBuffer_

type IRpcProxyBufferVtbl
	QueryInterface as function(byval This as IRpcProxyBuffer ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IRpcProxyBuffer ptr) as ULONG
	Release as function(byval This as IRpcProxyBuffer ptr) as ULONG
	Connect as function(byval This as IRpcProxyBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr) as HRESULT
	Disconnect as sub(byval This as IRpcProxyBuffer ptr)
end type

type IRpcProxyBuffer_
	lpVtbl as IRpcProxyBufferVtbl ptr
end type

#define IRpcProxyBuffer_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IRpcProxyBuffer_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IRpcProxyBuffer_Release(This) (This)->lpVtbl->Release(This)
#define IRpcProxyBuffer_Connect(This, pRpcChannelBuffer) (This)->lpVtbl->Connect(This, pRpcChannelBuffer)
#define IRpcProxyBuffer_Disconnect(This) (This)->lpVtbl->Disconnect(This)

declare function IRpcProxyBuffer_Connect_Proxy(byval This as IRpcProxyBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr) as HRESULT
declare sub IRpcProxyBuffer_Connect_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare sub IRpcProxyBuffer_Disconnect_Proxy(byval This as IRpcProxyBuffer ptr)
declare sub IRpcProxyBuffer_Disconnect_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IRpcStubBuffer_INTERFACE_DEFINED__
extern IID_IRpcStubBuffer as const GUID

type IRpcStubBufferVtbl
	QueryInterface as function(byval This as IRpcStubBuffer ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IRpcStubBuffer ptr) as ULONG
	Release as function(byval This as IRpcStubBuffer ptr) as ULONG
	Connect as function(byval This as IRpcStubBuffer ptr, byval pUnkServer as IUnknown ptr) as HRESULT
	Disconnect as sub(byval This as IRpcStubBuffer ptr)
	Invoke as function(byval This as IRpcStubBuffer ptr, byval _prpcmsg as RPCOLEMESSAGE ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr) as HRESULT
	IsIIDSupported as function(byval This as IRpcStubBuffer ptr, byval riid as const IID const ptr) as IRpcStubBuffer ptr
	CountRefs as function(byval This as IRpcStubBuffer ptr) as ULONG
	DebugServerQueryInterface as function(byval This as IRpcStubBuffer ptr, byval ppv as any ptr ptr) as HRESULT
	DebugServerRelease as sub(byval This as IRpcStubBuffer ptr, byval pv as any ptr)
end type

type IRpcStubBuffer_
	lpVtbl as IRpcStubBufferVtbl ptr
end type

#define IRpcStubBuffer_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IRpcStubBuffer_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IRpcStubBuffer_Release(This) (This)->lpVtbl->Release(This)
#define IRpcStubBuffer_Connect(This, pUnkServer) (This)->lpVtbl->Connect(This, pUnkServer)
#define IRpcStubBuffer_Disconnect(This) (This)->lpVtbl->Disconnect(This)
#define IRpcStubBuffer_Invoke(This, _prpcmsg, _pRpcChannelBuffer) (This)->lpVtbl->Invoke(This, _prpcmsg, _pRpcChannelBuffer)
#define IRpcStubBuffer_IsIIDSupported(This, riid) (This)->lpVtbl->IsIIDSupported(This, riid)
#define IRpcStubBuffer_CountRefs(This) (This)->lpVtbl->CountRefs(This)
#define IRpcStubBuffer_DebugServerQueryInterface(This, ppv) (This)->lpVtbl->DebugServerQueryInterface(This, ppv)
#define IRpcStubBuffer_DebugServerRelease(This, pv) (This)->lpVtbl->DebugServerRelease(This, pv)

declare function IRpcStubBuffer_Connect_Proxy(byval This as IRpcStubBuffer ptr, byval pUnkServer as IUnknown ptr) as HRESULT
declare sub IRpcStubBuffer_Connect_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare sub IRpcStubBuffer_Disconnect_Proxy(byval This as IRpcStubBuffer ptr)
declare sub IRpcStubBuffer_Disconnect_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRpcStubBuffer_Invoke_Proxy(byval This as IRpcStubBuffer ptr, byval _prpcmsg as RPCOLEMESSAGE ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr) as HRESULT
declare sub IRpcStubBuffer_Invoke_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRpcStubBuffer_IsIIDSupported_Proxy(byval This as IRpcStubBuffer ptr, byval riid as const IID const ptr) as IRpcStubBuffer ptr
declare sub IRpcStubBuffer_IsIIDSupported_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRpcStubBuffer_CountRefs_Proxy(byval This as IRpcStubBuffer ptr) as ULONG
declare sub IRpcStubBuffer_CountRefs_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRpcStubBuffer_DebugServerQueryInterface_Proxy(byval This as IRpcStubBuffer ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IRpcStubBuffer_DebugServerQueryInterface_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare sub IRpcStubBuffer_DebugServerRelease_Proxy(byval This as IRpcStubBuffer ptr, byval pv as any ptr)
declare sub IRpcStubBuffer_DebugServerRelease_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPSFactoryBuffer_INTERFACE_DEFINED__
extern IID_IPSFactoryBuffer as const GUID
type IPSFactoryBuffer as IPSFactoryBuffer_

type IPSFactoryBufferVtbl
	QueryInterface as function(byval This as IPSFactoryBuffer ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPSFactoryBuffer ptr) as ULONG
	Release as function(byval This as IPSFactoryBuffer ptr) as ULONG
	CreateProxy as function(byval This as IPSFactoryBuffer ptr, byval pUnkOuter as IUnknown ptr, byval riid as const IID const ptr, byval ppProxy as IRpcProxyBuffer ptr ptr, byval ppv as any ptr ptr) as HRESULT
	CreateStub as function(byval This as IPSFactoryBuffer ptr, byval riid as const IID const ptr, byval pUnkServer as IUnknown ptr, byval ppStub as IRpcStubBuffer ptr ptr) as HRESULT
end type

type IPSFactoryBuffer_
	lpVtbl as IPSFactoryBufferVtbl ptr
end type

#define IPSFactoryBuffer_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPSFactoryBuffer_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPSFactoryBuffer_Release(This) (This)->lpVtbl->Release(This)
#define IPSFactoryBuffer_CreateProxy(This, pUnkOuter, riid, ppProxy, ppv) (This)->lpVtbl->CreateProxy(This, pUnkOuter, riid, ppProxy, ppv)
#define IPSFactoryBuffer_CreateStub(This, riid, pUnkServer, ppStub) (This)->lpVtbl->CreateStub(This, riid, pUnkServer, ppStub)

declare function IPSFactoryBuffer_CreateProxy_Proxy(byval This as IPSFactoryBuffer ptr, byval pUnkOuter as IUnknown ptr, byval riid as const IID const ptr, byval ppProxy as IRpcProxyBuffer ptr ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IPSFactoryBuffer_CreateProxy_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPSFactoryBuffer_CreateStub_Proxy(byval This as IPSFactoryBuffer ptr, byval riid as const IID const ptr, byval pUnkServer as IUnknown ptr, byval ppStub as IRpcStubBuffer ptr ptr) as HRESULT
declare sub IPSFactoryBuffer_CreateStub_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type SChannelHookCallInfo
	iid as IID
	cbSize as DWORD
	uCausality as GUID
	dwServerPid as DWORD
	iMethod as DWORD
	pObject as any ptr
end type

#define __IChannelHook_INTERFACE_DEFINED__
extern IID_IChannelHook as const GUID
type IChannelHook as IChannelHook_

type IChannelHookVtbl
	QueryInterface as function(byval This as IChannelHook ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IChannelHook ptr) as ULONG
	Release as function(byval This as IChannelHook ptr) as ULONG
	ClientGetSize as sub(byval This as IChannelHook ptr, byval uExtent as const GUID const ptr, byval riid as const IID const ptr, byval pDataSize as ULONG ptr)
	ClientFillBuffer as sub(byval This as IChannelHook ptr, byval uExtent as const GUID const ptr, byval riid as const IID const ptr, byval pDataSize as ULONG ptr, byval pDataBuffer as any ptr)
	ClientNotify as sub(byval This as IChannelHook ptr, byval uExtent as const GUID const ptr, byval riid as const IID const ptr, byval cbDataSize as ULONG, byval pDataBuffer as any ptr, byval lDataRep as DWORD, byval hrFault as HRESULT)
	ServerNotify as sub(byval This as IChannelHook ptr, byval uExtent as const GUID const ptr, byval riid as const IID const ptr, byval cbDataSize as ULONG, byval pDataBuffer as any ptr, byval lDataRep as DWORD)
	ServerGetSize as sub(byval This as IChannelHook ptr, byval uExtent as const GUID const ptr, byval riid as const IID const ptr, byval hrFault as HRESULT, byval pDataSize as ULONG ptr)
	ServerFillBuffer as sub(byval This as IChannelHook ptr, byval uExtent as const GUID const ptr, byval riid as const IID const ptr, byval pDataSize as ULONG ptr, byval pDataBuffer as any ptr, byval hrFault as HRESULT)
end type

type IChannelHook_
	lpVtbl as IChannelHookVtbl ptr
end type

#define IChannelHook_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IChannelHook_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IChannelHook_Release(This) (This)->lpVtbl->Release(This)
#define IChannelHook_ClientGetSize(This, uExtent, riid, pDataSize) (This)->lpVtbl->ClientGetSize(This, uExtent, riid, pDataSize)
#define IChannelHook_ClientFillBuffer(This, uExtent, riid, pDataSize, pDataBuffer) (This)->lpVtbl->ClientFillBuffer(This, uExtent, riid, pDataSize, pDataBuffer)
#define IChannelHook_ClientNotify(This, uExtent, riid, cbDataSize, pDataBuffer, lDataRep, hrFault) (This)->lpVtbl->ClientNotify(This, uExtent, riid, cbDataSize, pDataBuffer, lDataRep, hrFault)
#define IChannelHook_ServerNotify(This, uExtent, riid, cbDataSize, pDataBuffer, lDataRep) (This)->lpVtbl->ServerNotify(This, uExtent, riid, cbDataSize, pDataBuffer, lDataRep)
#define IChannelHook_ServerGetSize(This, uExtent, riid, hrFault, pDataSize) (This)->lpVtbl->ServerGetSize(This, uExtent, riid, hrFault, pDataSize)
#define IChannelHook_ServerFillBuffer(This, uExtent, riid, pDataSize, pDataBuffer, hrFault) (This)->lpVtbl->ServerFillBuffer(This, uExtent, riid, pDataSize, pDataBuffer, hrFault)

declare sub IChannelHook_ClientGetSize_Proxy(byval This as IChannelHook ptr, byval uExtent as const GUID const ptr, byval riid as const IID const ptr, byval pDataSize as ULONG ptr)
declare sub IChannelHook_ClientGetSize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare sub IChannelHook_ClientFillBuffer_Proxy(byval This as IChannelHook ptr, byval uExtent as const GUID const ptr, byval riid as const IID const ptr, byval pDataSize as ULONG ptr, byval pDataBuffer as any ptr)
declare sub IChannelHook_ClientFillBuffer_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare sub IChannelHook_ClientNotify_Proxy(byval This as IChannelHook ptr, byval uExtent as const GUID const ptr, byval riid as const IID const ptr, byval cbDataSize as ULONG, byval pDataBuffer as any ptr, byval lDataRep as DWORD, byval hrFault as HRESULT)
declare sub IChannelHook_ClientNotify_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare sub IChannelHook_ServerNotify_Proxy(byval This as IChannelHook ptr, byval uExtent as const GUID const ptr, byval riid as const IID const ptr, byval cbDataSize as ULONG, byval pDataBuffer as any ptr, byval lDataRep as DWORD)
declare sub IChannelHook_ServerNotify_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare sub IChannelHook_ServerGetSize_Proxy(byval This as IChannelHook ptr, byval uExtent as const GUID const ptr, byval riid as const IID const ptr, byval hrFault as HRESULT, byval pDataSize as ULONG ptr)
declare sub IChannelHook_ServerGetSize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare sub IChannelHook_ServerFillBuffer_Proxy(byval This as IChannelHook ptr, byval uExtent as const GUID const ptr, byval riid as const IID const ptr, byval pDataSize as ULONG ptr, byval pDataBuffer as any ptr, byval hrFault as HRESULT)
declare sub IChannelHook_ServerFillBuffer_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IClientSecurity_INTERFACE_DEFINED__

type tagSOLE_AUTHENTICATION_SERVICE
	dwAuthnSvc as DWORD
	dwAuthzSvc as DWORD
	pPrincipalName as wstring ptr
	hr as HRESULT
end type

type SOLE_AUTHENTICATION_SERVICE as tagSOLE_AUTHENTICATION_SERVICE
type PSOLE_AUTHENTICATION_SERVICE as SOLE_AUTHENTICATION_SERVICE ptr

type tagEOLE_AUTHENTICATION_CAPABILITIES as long
enum
	EOAC_NONE = &h0
	EOAC_MUTUAL_AUTH = &h1
	EOAC_STATIC_CLOAKING = &h20
	EOAC_DYNAMIC_CLOAKING = &h40
	EOAC_ANY_AUTHORITY = &h80
	EOAC_MAKE_FULLSIC = &h100
	EOAC_DEFAULT = &h800
	EOAC_SECURE_REFS = &h2
	EOAC_ACCESS_CONTROL = &h4
	EOAC_APPID = &h8
	EOAC_DYNAMIC = &h10
	EOAC_REQUIRE_FULLSIC = &h200
	EOAC_AUTO_IMPERSONATE = &h400
	EOAC_NO_CUSTOM_MARSHAL = &h2000
	EOAC_DISABLE_AAA = &h1000
end enum

type EOLE_AUTHENTICATION_CAPABILITIES as tagEOLE_AUTHENTICATION_CAPABILITIES
const COLE_DEFAULT_PRINCIPAL = cptr(OLECHAR ptr, cast(INT_PTR, -1))
const COLE_DEFAULT_AUTHINFO = cptr(any ptr, cast(INT_PTR, -1))

type tagSOLE_AUTHENTICATION_INFO
	dwAuthnSvc as DWORD
	dwAuthzSvc as DWORD
	pAuthInfo as any ptr
end type

type SOLE_AUTHENTICATION_INFO as tagSOLE_AUTHENTICATION_INFO
type PSOLE_AUTHENTICATION_INFO as tagSOLE_AUTHENTICATION_INFO ptr

type tagSOLE_AUTHENTICATION_LIST
	cAuthInfo as DWORD
	aAuthInfo as SOLE_AUTHENTICATION_INFO ptr
end type

type SOLE_AUTHENTICATION_LIST as tagSOLE_AUTHENTICATION_LIST
type PSOLE_AUTHENTICATION_LIST as tagSOLE_AUTHENTICATION_LIST ptr
extern IID_IClientSecurity as const GUID
type IClientSecurity as IClientSecurity_

type IClientSecurityVtbl
	QueryInterface as function(byval This as IClientSecurity ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IClientSecurity ptr) as ULONG
	Release as function(byval This as IClientSecurity ptr) as ULONG
	QueryBlanket as function(byval This as IClientSecurity ptr, byval pProxy as IUnknown ptr, byval pAuthnSvc as DWORD ptr, byval pAuthzSvc as DWORD ptr, byval pServerPrincName as wstring ptr ptr, byval pAuthnLevel as DWORD ptr, byval pImpLevel as DWORD ptr, byval pAuthInfo as any ptr ptr, byval pCapabilites as DWORD ptr) as HRESULT
	SetBlanket as function(byval This as IClientSecurity ptr, byval pProxy as IUnknown ptr, byval dwAuthnSvc as DWORD, byval dwAuthzSvc as DWORD, byval pServerPrincName as wstring ptr, byval dwAuthnLevel as DWORD, byval dwImpLevel as DWORD, byval pAuthInfo as any ptr, byval dwCapabilities as DWORD) as HRESULT
	CopyProxy as function(byval This as IClientSecurity ptr, byval pProxy as IUnknown ptr, byval ppCopy as IUnknown ptr ptr) as HRESULT
end type

type IClientSecurity_
	lpVtbl as IClientSecurityVtbl ptr
end type

#define IClientSecurity_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IClientSecurity_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IClientSecurity_Release(This) (This)->lpVtbl->Release(This)
#define IClientSecurity_QueryBlanket(This, pProxy, pAuthnSvc, pAuthzSvc, pServerPrincName, pAuthnLevel, pImpLevel, pAuthInfo, pCapabilites) (This)->lpVtbl->QueryBlanket(This, pProxy, pAuthnSvc, pAuthzSvc, pServerPrincName, pAuthnLevel, pImpLevel, pAuthInfo, pCapabilites)
#define IClientSecurity_SetBlanket(This, pProxy, dwAuthnSvc, dwAuthzSvc, pServerPrincName, dwAuthnLevel, dwImpLevel, pAuthInfo, dwCapabilities) (This)->lpVtbl->SetBlanket(This, pProxy, dwAuthnSvc, dwAuthzSvc, pServerPrincName, dwAuthnLevel, dwImpLevel, pAuthInfo, dwCapabilities)
#define IClientSecurity_CopyProxy(This, pProxy, ppCopy) (This)->lpVtbl->CopyProxy(This, pProxy, ppCopy)

declare function IClientSecurity_QueryBlanket_Proxy(byval This as IClientSecurity ptr, byval pProxy as IUnknown ptr, byval pAuthnSvc as DWORD ptr, byval pAuthzSvc as DWORD ptr, byval pServerPrincName as wstring ptr ptr, byval pAuthnLevel as DWORD ptr, byval pImpLevel as DWORD ptr, byval pAuthInfo as any ptr ptr, byval pCapabilites as DWORD ptr) as HRESULT
declare sub IClientSecurity_QueryBlanket_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IClientSecurity_SetBlanket_Proxy(byval This as IClientSecurity ptr, byval pProxy as IUnknown ptr, byval dwAuthnSvc as DWORD, byval dwAuthzSvc as DWORD, byval pServerPrincName as wstring ptr, byval dwAuthnLevel as DWORD, byval dwImpLevel as DWORD, byval pAuthInfo as any ptr, byval dwCapabilities as DWORD) as HRESULT
declare sub IClientSecurity_SetBlanket_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IClientSecurity_CopyProxy_Proxy(byval This as IClientSecurity ptr, byval pProxy as IUnknown ptr, byval ppCopy as IUnknown ptr ptr) as HRESULT
declare sub IClientSecurity_CopyProxy_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IServerSecurity_INTERFACE_DEFINED__
extern IID_IServerSecurity as const GUID
type IServerSecurity as IServerSecurity_

type IServerSecurityVtbl
	QueryInterface as function(byval This as IServerSecurity ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IServerSecurity ptr) as ULONG
	Release as function(byval This as IServerSecurity ptr) as ULONG
	QueryBlanket as function(byval This as IServerSecurity ptr, byval pAuthnSvc as DWORD ptr, byval pAuthzSvc as DWORD ptr, byval pServerPrincName as wstring ptr ptr, byval pAuthnLevel as DWORD ptr, byval pImpLevel as DWORD ptr, byval pPrivs as any ptr ptr, byval pCapabilities as DWORD ptr) as HRESULT
	ImpersonateClient as function(byval This as IServerSecurity ptr) as HRESULT
	RevertToSelf as function(byval This as IServerSecurity ptr) as HRESULT
	IsImpersonating as function(byval This as IServerSecurity ptr) as WINBOOL
end type

type IServerSecurity_
	lpVtbl as IServerSecurityVtbl ptr
end type

#define IServerSecurity_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IServerSecurity_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IServerSecurity_Release(This) (This)->lpVtbl->Release(This)
#define IServerSecurity_QueryBlanket(This, pAuthnSvc, pAuthzSvc, pServerPrincName, pAuthnLevel, pImpLevel, pPrivs, pCapabilities) (This)->lpVtbl->QueryBlanket(This, pAuthnSvc, pAuthzSvc, pServerPrincName, pAuthnLevel, pImpLevel, pPrivs, pCapabilities)
#define IServerSecurity_ImpersonateClient(This) (This)->lpVtbl->ImpersonateClient(This)
#define IServerSecurity_RevertToSelf(This) (This)->lpVtbl->RevertToSelf(This)
#define IServerSecurity_IsImpersonating(This) (This)->lpVtbl->IsImpersonating(This)

declare function IServerSecurity_QueryBlanket_Proxy(byval This as IServerSecurity ptr, byval pAuthnSvc as DWORD ptr, byval pAuthzSvc as DWORD ptr, byval pServerPrincName as wstring ptr ptr, byval pAuthnLevel as DWORD ptr, byval pImpLevel as DWORD ptr, byval pPrivs as any ptr ptr, byval pCapabilities as DWORD ptr) as HRESULT
declare sub IServerSecurity_QueryBlanket_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IServerSecurity_ImpersonateClient_Proxy(byval This as IServerSecurity ptr) as HRESULT
declare sub IServerSecurity_ImpersonateClient_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IServerSecurity_RevertToSelf_Proxy(byval This as IServerSecurity ptr) as HRESULT
declare sub IServerSecurity_RevertToSelf_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IServerSecurity_IsImpersonating_Proxy(byval This as IServerSecurity ptr) as WINBOOL
declare sub IServerSecurity_IsImpersonating_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type tagRPCOPT_PROPERTIES as long
enum
	COMBND_RPCTIMEOUT = &h1
	COMBND_SERVER_LOCALITY = &h2
	COMBND_RESERVED1 = &h4
end enum

type RPCOPT_PROPERTIES as tagRPCOPT_PROPERTIES

type tagRPCOPT_SERVER_LOCALITY_VALUES as long
enum
	SERVER_LOCALITY_PROCESS_LOCAL = 0
	SERVER_LOCALITY_MACHINE_LOCAL = 1
	SERVER_LOCALITY_REMOTE = 2
end enum

type RPCOPT_SERVER_LOCALITY_VALUES as tagRPCOPT_SERVER_LOCALITY_VALUES
#define __IRpcOptions_INTERFACE_DEFINED__
extern IID_IRpcOptions as const GUID
type IRpcOptions as IRpcOptions_

type IRpcOptionsVtbl
	QueryInterface as function(byval This as IRpcOptions ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IRpcOptions ptr) as ULONG
	Release as function(byval This as IRpcOptions ptr) as ULONG
	Set as function(byval This as IRpcOptions ptr, byval pPrx as IUnknown ptr, byval dwProperty as RPCOPT_PROPERTIES, byval dwValue as ULONG_PTR) as HRESULT
	Query as function(byval This as IRpcOptions ptr, byval pPrx as IUnknown ptr, byval dwProperty as RPCOPT_PROPERTIES, byval pdwValue as ULONG_PTR ptr) as HRESULT
end type

type IRpcOptions_
	lpVtbl as IRpcOptionsVtbl ptr
end type

#define IRpcOptions_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IRpcOptions_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IRpcOptions_Release(This) (This)->lpVtbl->Release(This)
#define IRpcOptions_Set(This, pPrx, dwProperty, dwValue) (This)->lpVtbl->Set(This, pPrx, dwProperty, dwValue)
#define IRpcOptions_Query(This, pPrx, dwProperty, pdwValue) (This)->lpVtbl->Query(This, pPrx, dwProperty, pdwValue)

declare function IRpcOptions_Set_Proxy(byval This as IRpcOptions ptr, byval pPrx as IUnknown ptr, byval dwProperty as RPCOPT_PROPERTIES, byval dwValue as ULONG_PTR) as HRESULT
declare sub IRpcOptions_Set_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRpcOptions_Query_Proxy(byval This as IRpcOptions ptr, byval pPrx as IUnknown ptr, byval dwProperty as RPCOPT_PROPERTIES, byval pdwValue as ULONG_PTR ptr) as HRESULT
declare sub IRpcOptions_Query_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type tagGLOBALOPT_PROPERTIES as long
enum
	COMGLB_EXCEPTION_HANDLING = 1
	COMGLB_APPID = 2
	COMGLB_RPC_THREADPOOL_SETTING = 3
	COMGLB_RO_SETTINGS = 4
	COMGLB_UNMARSHALING_POLICY = 5
end enum

type GLOBALOPT_PROPERTIES as tagGLOBALOPT_PROPERTIES

type tagGLOBALOPT_EH_VALUES as long
enum
	COMGLB_EXCEPTION_HANDLE = 0
	COMGLB_EXCEPTION_DONOT_HANDLE_FATAL = 1
	COMGLB_EXCEPTION_DONOT_HANDLE = COMGLB_EXCEPTION_DONOT_HANDLE_FATAL
	COMGLB_EXCEPTION_DONOT_HANDLE_ANY = 2
end enum

type GLOBALOPT_EH_VALUES as tagGLOBALOPT_EH_VALUES

type tagGLOBALOPT_RPCTP_VALUES as long
enum
	COMGLB_RPC_THREADPOOL_SETTING_DEFAULT_POOL = 0
	COMGLB_RPC_THREADPOOL_SETTING_PRIVATE_POOL = 1
end enum

type GLOBALOPT_RPCTP_VALUES as tagGLOBALOPT_RPCTP_VALUES

type tagGLOBALOPT_RO_FLAGS as long
enum
	COMGLB_STA_MODALLOOP_REMOVE_TOUCH_MESSAGES = &h1
	COMGLB_STA_MODALLOOP_SHARED_QUEUE_REMOVE_INPUT_MESSAGES = &h2
	COMGLB_STA_MODALLOOP_SHARED_QUEUE_DONOT_REMOVE_INPUT_MESSAGES = &h4
	COMGLB_FAST_RUNDOWN = &h8
	COMGLB_RESERVED1 = &h10
	COMGLB_RESERVED2 = &h20
	COMGLB_RESERVED3 = &h40
	COMGLB_STA_MODALLOOP_SHARED_QUEUE_REORDER_POINTER_MESSAGES = &h80
end enum

type GLOBALOPT_RO_FLAGS as tagGLOBALOPT_RO_FLAGS

type tagGLOBALOPT_UNMARSHALING_POLICY_VALUES as long
enum
	COMGLB_UNMARSHALING_POLICY_NORMAL = 0
	COMGLB_UNMARSHALING_POLICY_STRONG = 1
	COMGLB_UNMARSHALING_POLICY_HYBRID = 2
end enum

type GLOBALOPT_UNMARSHALING_POLICY_VALUES as tagGLOBALOPT_UNMARSHALING_POLICY_VALUES
#define __IGlobalOptions_INTERFACE_DEFINED__
extern IID_IGlobalOptions as const GUID
type IGlobalOptions as IGlobalOptions_

type IGlobalOptionsVtbl
	QueryInterface as function(byval This as IGlobalOptions ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IGlobalOptions ptr) as ULONG
	Release as function(byval This as IGlobalOptions ptr) as ULONG
	Set as function(byval This as IGlobalOptions ptr, byval dwProperty as GLOBALOPT_PROPERTIES, byval dwValue as ULONG_PTR) as HRESULT
	Query as function(byval This as IGlobalOptions ptr, byval dwProperty as GLOBALOPT_PROPERTIES, byval pdwValue as ULONG_PTR ptr) as HRESULT
end type

type IGlobalOptions_
	lpVtbl as IGlobalOptionsVtbl ptr
end type

#define IGlobalOptions_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IGlobalOptions_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IGlobalOptions_Release(This) (This)->lpVtbl->Release(This)
#define IGlobalOptions_Set(This, dwProperty, dwValue) (This)->lpVtbl->Set(This, dwProperty, dwValue)
#define IGlobalOptions_Query(This, dwProperty, pdwValue) (This)->lpVtbl->Query(This, dwProperty, pdwValue)

declare function IGlobalOptions_Set_Proxy(byval This as IGlobalOptions ptr, byval dwProperty as GLOBALOPT_PROPERTIES, byval dwValue as ULONG_PTR) as HRESULT
declare sub IGlobalOptions_Set_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IGlobalOptions_Query_Proxy(byval This as IGlobalOptions ptr, byval dwProperty as GLOBALOPT_PROPERTIES, byval pdwValue as ULONG_PTR ptr) as HRESULT
declare sub IGlobalOptions_Query_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __ISurrogate_INTERFACE_DEFINED__
type ISurrogate as ISurrogate_
type LPSURROGATE as ISurrogate ptr
extern IID_ISurrogate as const GUID

type ISurrogateVtbl
	QueryInterface as function(byval This as ISurrogate ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ISurrogate ptr) as ULONG
	Release as function(byval This as ISurrogate ptr) as ULONG
	LoadDllServer as function(byval This as ISurrogate ptr, byval Clsid as const IID const ptr) as HRESULT
	FreeSurrogate as function(byval This as ISurrogate ptr) as HRESULT
end type

type ISurrogate_
	lpVtbl as ISurrogateVtbl ptr
end type

#define ISurrogate_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define ISurrogate_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ISurrogate_Release(This) (This)->lpVtbl->Release(This)
#define ISurrogate_LoadDllServer(This, Clsid) (This)->lpVtbl->LoadDllServer(This, Clsid)
#define ISurrogate_FreeSurrogate(This) (This)->lpVtbl->FreeSurrogate(This)

declare function ISurrogate_LoadDllServer_Proxy(byval This as ISurrogate ptr, byval Clsid as const IID const ptr) as HRESULT
declare sub ISurrogate_LoadDllServer_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ISurrogate_FreeSurrogate_Proxy(byval This as ISurrogate ptr) as HRESULT
declare sub ISurrogate_FreeSurrogate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IGlobalInterfaceTable_INTERFACE_DEFINED__
type IGlobalInterfaceTable as IGlobalInterfaceTable_
type LPGLOBALINTERFACETABLE as IGlobalInterfaceTable ptr
extern IID_IGlobalInterfaceTable as const GUID

type IGlobalInterfaceTableVtbl
	QueryInterface as function(byval This as IGlobalInterfaceTable ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IGlobalInterfaceTable ptr) as ULONG
	Release as function(byval This as IGlobalInterfaceTable ptr) as ULONG
	RegisterInterfaceInGlobal as function(byval This as IGlobalInterfaceTable ptr, byval pUnk as IUnknown ptr, byval riid as const IID const ptr, byval pdwCookie as DWORD ptr) as HRESULT
	RevokeInterfaceFromGlobal as function(byval This as IGlobalInterfaceTable ptr, byval dwCookie as DWORD) as HRESULT
	GetInterfaceFromGlobal as function(byval This as IGlobalInterfaceTable ptr, byval dwCookie as DWORD, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
end type

type IGlobalInterfaceTable_
	lpVtbl as IGlobalInterfaceTableVtbl ptr
end type

#define IGlobalInterfaceTable_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IGlobalInterfaceTable_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IGlobalInterfaceTable_Release(This) (This)->lpVtbl->Release(This)
#define IGlobalInterfaceTable_RegisterInterfaceInGlobal(This, pUnk, riid, pdwCookie) (This)->lpVtbl->RegisterInterfaceInGlobal(This, pUnk, riid, pdwCookie)
#define IGlobalInterfaceTable_RevokeInterfaceFromGlobal(This, dwCookie) (This)->lpVtbl->RevokeInterfaceFromGlobal(This, dwCookie)
#define IGlobalInterfaceTable_GetInterfaceFromGlobal(This, dwCookie, riid, ppv) (This)->lpVtbl->GetInterfaceFromGlobal(This, dwCookie, riid, ppv)

declare function IGlobalInterfaceTable_RegisterInterfaceInGlobal_Proxy(byval This as IGlobalInterfaceTable ptr, byval pUnk as IUnknown ptr, byval riid as const IID const ptr, byval pdwCookie as DWORD ptr) as HRESULT
declare sub IGlobalInterfaceTable_RegisterInterfaceInGlobal_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IGlobalInterfaceTable_RevokeInterfaceFromGlobal_Proxy(byval This as IGlobalInterfaceTable ptr, byval dwCookie as DWORD) as HRESULT
declare sub IGlobalInterfaceTable_RevokeInterfaceFromGlobal_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IGlobalInterfaceTable_GetInterfaceFromGlobal_Proxy(byval This as IGlobalInterfaceTable ptr, byval dwCookie as DWORD, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IGlobalInterfaceTable_GetInterfaceFromGlobal_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __ISynchronize_INTERFACE_DEFINED__
extern IID_ISynchronize as const GUID

type ISynchronizeVtbl
	QueryInterface as function(byval This as ISynchronize ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ISynchronize ptr) as ULONG
	Release as function(byval This as ISynchronize ptr) as ULONG
	Wait as function(byval This as ISynchronize ptr, byval dwFlags as DWORD, byval dwMilliseconds as DWORD) as HRESULT
	Signal as function(byval This as ISynchronize ptr) as HRESULT
	Reset as function(byval This as ISynchronize ptr) as HRESULT
end type

type ISynchronize_
	lpVtbl as ISynchronizeVtbl ptr
end type

#define ISynchronize_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define ISynchronize_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ISynchronize_Release(This) (This)->lpVtbl->Release(This)
#define ISynchronize_Wait(This, dwFlags, dwMilliseconds) (This)->lpVtbl->Wait(This, dwFlags, dwMilliseconds)
#define ISynchronize_Signal(This) (This)->lpVtbl->Signal(This)
#define ISynchronize_Reset(This) (This)->lpVtbl->Reset(This)

declare function ISynchronize_Wait_Proxy(byval This as ISynchronize ptr, byval dwFlags as DWORD, byval dwMilliseconds as DWORD) as HRESULT
declare sub ISynchronize_Wait_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ISynchronize_Signal_Proxy(byval This as ISynchronize ptr) as HRESULT
declare sub ISynchronize_Signal_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ISynchronize_Reset_Proxy(byval This as ISynchronize ptr) as HRESULT
declare sub ISynchronize_Reset_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __ISynchronizeHandle_INTERFACE_DEFINED__
extern IID_ISynchronizeHandle as const GUID
type ISynchronizeHandle as ISynchronizeHandle_

type ISynchronizeHandleVtbl
	QueryInterface as function(byval This as ISynchronizeHandle ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ISynchronizeHandle ptr) as ULONG
	Release as function(byval This as ISynchronizeHandle ptr) as ULONG
	GetHandle as function(byval This as ISynchronizeHandle ptr, byval ph as HANDLE ptr) as HRESULT
end type

type ISynchronizeHandle_
	lpVtbl as ISynchronizeHandleVtbl ptr
end type

#define ISynchronizeHandle_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define ISynchronizeHandle_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ISynchronizeHandle_Release(This) (This)->lpVtbl->Release(This)
#define ISynchronizeHandle_GetHandle(This, ph) (This)->lpVtbl->GetHandle(This, ph)
declare function ISynchronizeHandle_GetHandle_Proxy(byval This as ISynchronizeHandle ptr, byval ph as HANDLE ptr) as HRESULT
declare sub ISynchronizeHandle_GetHandle_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __ISynchronizeEvent_INTERFACE_DEFINED__
extern IID_ISynchronizeEvent as const GUID
type ISynchronizeEvent as ISynchronizeEvent_

type ISynchronizeEventVtbl
	QueryInterface as function(byval This as ISynchronizeEvent ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ISynchronizeEvent ptr) as ULONG
	Release as function(byval This as ISynchronizeEvent ptr) as ULONG
	GetHandle as function(byval This as ISynchronizeEvent ptr, byval ph as HANDLE ptr) as HRESULT
	SetEventHandle as function(byval This as ISynchronizeEvent ptr, byval ph as HANDLE ptr) as HRESULT
end type

type ISynchronizeEvent_
	lpVtbl as ISynchronizeEventVtbl ptr
end type

#define ISynchronizeEvent_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define ISynchronizeEvent_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ISynchronizeEvent_Release(This) (This)->lpVtbl->Release(This)
#define ISynchronizeEvent_GetHandle(This, ph) (This)->lpVtbl->GetHandle(This, ph)
#define ISynchronizeEvent_SetEventHandle(This, ph) (This)->lpVtbl->SetEventHandle(This, ph)
declare function ISynchronizeEvent_SetEventHandle_Proxy(byval This as ISynchronizeEvent ptr, byval ph as HANDLE ptr) as HRESULT
declare sub ISynchronizeEvent_SetEventHandle_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __ISynchronizeContainer_INTERFACE_DEFINED__
extern IID_ISynchronizeContainer as const GUID
type ISynchronizeContainer as ISynchronizeContainer_

type ISynchronizeContainerVtbl
	QueryInterface as function(byval This as ISynchronizeContainer ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ISynchronizeContainer ptr) as ULONG
	Release as function(byval This as ISynchronizeContainer ptr) as ULONG
	AddSynchronize as function(byval This as ISynchronizeContainer ptr, byval pSync as ISynchronize ptr) as HRESULT
	WaitMultiple as function(byval This as ISynchronizeContainer ptr, byval dwFlags as DWORD, byval dwTimeOut as DWORD, byval ppSync as ISynchronize ptr ptr) as HRESULT
end type

type ISynchronizeContainer_
	lpVtbl as ISynchronizeContainerVtbl ptr
end type

#define ISynchronizeContainer_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define ISynchronizeContainer_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ISynchronizeContainer_Release(This) (This)->lpVtbl->Release(This)
#define ISynchronizeContainer_AddSynchronize(This, pSync) (This)->lpVtbl->AddSynchronize(This, pSync)
#define ISynchronizeContainer_WaitMultiple(This, dwFlags, dwTimeOut, ppSync) (This)->lpVtbl->WaitMultiple(This, dwFlags, dwTimeOut, ppSync)

declare function ISynchronizeContainer_AddSynchronize_Proxy(byval This as ISynchronizeContainer ptr, byval pSync as ISynchronize ptr) as HRESULT
declare sub ISynchronizeContainer_AddSynchronize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ISynchronizeContainer_WaitMultiple_Proxy(byval This as ISynchronizeContainer ptr, byval dwFlags as DWORD, byval dwTimeOut as DWORD, byval ppSync as ISynchronize ptr ptr) as HRESULT
declare sub ISynchronizeContainer_WaitMultiple_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __ISynchronizeMutex_INTERFACE_DEFINED__
extern IID_ISynchronizeMutex as const GUID
type ISynchronizeMutex as ISynchronizeMutex_

type ISynchronizeMutexVtbl
	QueryInterface as function(byval This as ISynchronizeMutex ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ISynchronizeMutex ptr) as ULONG
	Release as function(byval This as ISynchronizeMutex ptr) as ULONG
	Wait as function(byval This as ISynchronizeMutex ptr, byval dwFlags as DWORD, byval dwMilliseconds as DWORD) as HRESULT
	Signal as function(byval This as ISynchronizeMutex ptr) as HRESULT
	Reset as function(byval This as ISynchronizeMutex ptr) as HRESULT
	ReleaseMutex as function(byval This as ISynchronizeMutex ptr) as HRESULT
end type

type ISynchronizeMutex_
	lpVtbl as ISynchronizeMutexVtbl ptr
end type

#define ISynchronizeMutex_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define ISynchronizeMutex_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ISynchronizeMutex_Release(This) (This)->lpVtbl->Release(This)
#define ISynchronizeMutex_Wait(This, dwFlags, dwMilliseconds) (This)->lpVtbl->Wait(This, dwFlags, dwMilliseconds)
#define ISynchronizeMutex_Signal(This) (This)->lpVtbl->Signal(This)
#define ISynchronizeMutex_Reset(This) (This)->lpVtbl->Reset(This)
#define ISynchronizeMutex_ReleaseMutex(This) (This)->lpVtbl->ReleaseMutex(This)
declare function ISynchronizeMutex_ReleaseMutex_Proxy(byval This as ISynchronizeMutex ptr) as HRESULT
declare sub ISynchronizeMutex_ReleaseMutex_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __ICancelMethodCalls_INTERFACE_DEFINED__
type ICancelMethodCalls as ICancelMethodCalls_
type LPCANCELMETHODCALLS as ICancelMethodCalls ptr
extern IID_ICancelMethodCalls as const GUID

type ICancelMethodCallsVtbl
	QueryInterface as function(byval This as ICancelMethodCalls ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ICancelMethodCalls ptr) as ULONG
	Release as function(byval This as ICancelMethodCalls ptr) as ULONG
	Cancel as function(byval This as ICancelMethodCalls ptr, byval ulSeconds as ULONG) as HRESULT
	TestCancel as function(byval This as ICancelMethodCalls ptr) as HRESULT
end type

type ICancelMethodCalls_
	lpVtbl as ICancelMethodCallsVtbl ptr
end type

#define ICancelMethodCalls_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define ICancelMethodCalls_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ICancelMethodCalls_Release(This) (This)->lpVtbl->Release(This)
#define ICancelMethodCalls_Cancel(This, ulSeconds) (This)->lpVtbl->Cancel(This, ulSeconds)
#define ICancelMethodCalls_TestCancel(This) (This)->lpVtbl->TestCancel(This)

declare function ICancelMethodCalls_Cancel_Proxy(byval This as ICancelMethodCalls ptr, byval ulSeconds as ULONG) as HRESULT
declare sub ICancelMethodCalls_Cancel_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICancelMethodCalls_TestCancel_Proxy(byval This as ICancelMethodCalls ptr) as HRESULT
declare sub ICancelMethodCalls_TestCancel_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IAsyncManager_INTERFACE_DEFINED__

type tagDCOM_CALL_STATE as long
enum
	DCOM_NONE = &h0
	DCOM_CALL_COMPLETE = &h1
	DCOM_CALL_CANCELED = &h2
end enum

type DCOM_CALL_STATE as tagDCOM_CALL_STATE
extern IID_IAsyncManager as const GUID

type IAsyncManagerVtbl
	QueryInterface as function(byval This as IAsyncManager ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAsyncManager ptr) as ULONG
	Release as function(byval This as IAsyncManager ptr) as ULONG
	CompleteCall as function(byval This as IAsyncManager ptr, byval Result as HRESULT) as HRESULT
	GetCallContext as function(byval This as IAsyncManager ptr, byval riid as const IID const ptr, byval pInterface as any ptr ptr) as HRESULT
	GetState as function(byval This as IAsyncManager ptr, byval pulStateFlags as ULONG ptr) as HRESULT
end type

type IAsyncManager_
	lpVtbl as IAsyncManagerVtbl ptr
end type

#define IAsyncManager_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IAsyncManager_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IAsyncManager_Release(This) (This)->lpVtbl->Release(This)
#define IAsyncManager_CompleteCall(This, Result) (This)->lpVtbl->CompleteCall(This, Result)
#define IAsyncManager_GetCallContext(This, riid, pInterface) (This)->lpVtbl->GetCallContext(This, riid, pInterface)
#define IAsyncManager_GetState(This, pulStateFlags) (This)->lpVtbl->GetState(This, pulStateFlags)

declare function IAsyncManager_CompleteCall_Proxy(byval This as IAsyncManager ptr, byval Result as HRESULT) as HRESULT
declare sub IAsyncManager_CompleteCall_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAsyncManager_GetCallContext_Proxy(byval This as IAsyncManager ptr, byval riid as const IID const ptr, byval pInterface as any ptr ptr) as HRESULT
declare sub IAsyncManager_GetCallContext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAsyncManager_GetState_Proxy(byval This as IAsyncManager ptr, byval pulStateFlags as ULONG ptr) as HRESULT
declare sub IAsyncManager_GetState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __ICallFactory_INTERFACE_DEFINED__
extern IID_ICallFactory as const GUID
type ICallFactory as ICallFactory_

type ICallFactoryVtbl
	QueryInterface as function(byval This as ICallFactory ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ICallFactory ptr) as ULONG
	Release as function(byval This as ICallFactory ptr) as ULONG
	CreateCall as function(byval This as ICallFactory ptr, byval riid as const IID const ptr, byval pCtrlUnk as IUnknown ptr, byval riid2 as const IID const ptr, byval ppv as IUnknown ptr ptr) as HRESULT
end type

type ICallFactory_
	lpVtbl as ICallFactoryVtbl ptr
end type

#define ICallFactory_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define ICallFactory_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ICallFactory_Release(This) (This)->lpVtbl->Release(This)
#define ICallFactory_CreateCall(This, riid, pCtrlUnk, riid2, ppv) (This)->lpVtbl->CreateCall(This, riid, pCtrlUnk, riid2, ppv)
declare function ICallFactory_CreateCall_Proxy(byval This as ICallFactory ptr, byval riid as const IID const ptr, byval pCtrlUnk as IUnknown ptr, byval riid2 as const IID const ptr, byval ppv as IUnknown ptr ptr) as HRESULT
declare sub ICallFactory_CreateCall_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IRpcHelper_INTERFACE_DEFINED__
extern IID_IRpcHelper as const GUID
type IRpcHelper as IRpcHelper_

type IRpcHelperVtbl
	QueryInterface as function(byval This as IRpcHelper ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IRpcHelper ptr) as ULONG
	Release as function(byval This as IRpcHelper ptr) as ULONG
	GetDCOMProtocolVersion as function(byval This as IRpcHelper ptr, byval pComVersion as DWORD ptr) as HRESULT
	GetIIDFromOBJREF as function(byval This as IRpcHelper ptr, byval pObjRef as any ptr, byval piid as IID ptr ptr) as HRESULT
end type

type IRpcHelper_
	lpVtbl as IRpcHelperVtbl ptr
end type

#define IRpcHelper_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IRpcHelper_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IRpcHelper_Release(This) (This)->lpVtbl->Release(This)
#define IRpcHelper_GetDCOMProtocolVersion(This, pComVersion) (This)->lpVtbl->GetDCOMProtocolVersion(This, pComVersion)
#define IRpcHelper_GetIIDFromOBJREF(This, pObjRef, piid) (This)->lpVtbl->GetIIDFromOBJREF(This, pObjRef, piid)

declare function IRpcHelper_GetDCOMProtocolVersion_Proxy(byval This as IRpcHelper ptr, byval pComVersion as DWORD ptr) as HRESULT
declare sub IRpcHelper_GetDCOMProtocolVersion_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRpcHelper_GetIIDFromOBJREF_Proxy(byval This as IRpcHelper ptr, byval pObjRef as any ptr, byval piid as IID ptr ptr) as HRESULT
declare sub IRpcHelper_GetIIDFromOBJREF_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IReleaseMarshalBuffers_INTERFACE_DEFINED__
extern IID_IReleaseMarshalBuffers as const GUID
type IReleaseMarshalBuffers as IReleaseMarshalBuffers_

type IReleaseMarshalBuffersVtbl
	QueryInterface as function(byval This as IReleaseMarshalBuffers ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IReleaseMarshalBuffers ptr) as ULONG
	Release as function(byval This as IReleaseMarshalBuffers ptr) as ULONG
	ReleaseMarshalBuffer as function(byval This as IReleaseMarshalBuffers ptr, byval pMsg as RPCOLEMESSAGE ptr, byval dwFlags as DWORD, byval pChnl as IUnknown ptr) as HRESULT
end type

type IReleaseMarshalBuffers_
	lpVtbl as IReleaseMarshalBuffersVtbl ptr
end type

#define IReleaseMarshalBuffers_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IReleaseMarshalBuffers_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IReleaseMarshalBuffers_Release(This) (This)->lpVtbl->Release(This)
#define IReleaseMarshalBuffers_ReleaseMarshalBuffer(This, pMsg, dwFlags, pChnl) (This)->lpVtbl->ReleaseMarshalBuffer(This, pMsg, dwFlags, pChnl)
declare function IReleaseMarshalBuffers_ReleaseMarshalBuffer_Proxy(byval This as IReleaseMarshalBuffers ptr, byval pMsg as RPCOLEMESSAGE ptr, byval dwFlags as DWORD, byval pChnl as IUnknown ptr) as HRESULT
declare sub IReleaseMarshalBuffers_ReleaseMarshalBuffer_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IWaitMultiple_INTERFACE_DEFINED__
extern IID_IWaitMultiple as const GUID
type IWaitMultiple as IWaitMultiple_

type IWaitMultipleVtbl
	QueryInterface as function(byval This as IWaitMultiple ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWaitMultiple ptr) as ULONG
	Release as function(byval This as IWaitMultiple ptr) as ULONG
	WaitMultiple as function(byval This as IWaitMultiple ptr, byval timeout as DWORD, byval pSync as ISynchronize ptr ptr) as HRESULT
	AddSynchronize as function(byval This as IWaitMultiple ptr, byval pSync as ISynchronize ptr) as HRESULT
end type

type IWaitMultiple_
	lpVtbl as IWaitMultipleVtbl ptr
end type

#define IWaitMultiple_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IWaitMultiple_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IWaitMultiple_Release(This) (This)->lpVtbl->Release(This)
#define IWaitMultiple_WaitMultiple(This, timeout, pSync) (This)->lpVtbl->WaitMultiple(This, timeout, pSync)
#define IWaitMultiple_AddSynchronize(This, pSync) (This)->lpVtbl->AddSynchronize(This, pSync)

declare function IWaitMultiple_WaitMultiple_Proxy(byval This as IWaitMultiple ptr, byval timeout as DWORD, byval pSync as ISynchronize ptr ptr) as HRESULT
declare sub IWaitMultiple_WaitMultiple_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWaitMultiple_AddSynchronize_Proxy(byval This as IWaitMultiple ptr, byval pSync as ISynchronize ptr) as HRESULT
declare sub IWaitMultiple_AddSynchronize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IAddrTrackingControl_INTERFACE_DEFINED__
type IAddrTrackingControl as IAddrTrackingControl_
type LPADDRTRACKINGCONTROL as IAddrTrackingControl ptr
extern IID_IAddrTrackingControl as const GUID

type IAddrTrackingControlVtbl
	QueryInterface as function(byval This as IAddrTrackingControl ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAddrTrackingControl ptr) as ULONG
	Release as function(byval This as IAddrTrackingControl ptr) as ULONG
	EnableCOMDynamicAddrTracking as function(byval This as IAddrTrackingControl ptr) as HRESULT
	DisableCOMDynamicAddrTracking as function(byval This as IAddrTrackingControl ptr) as HRESULT
end type

type IAddrTrackingControl_
	lpVtbl as IAddrTrackingControlVtbl ptr
end type

#define IAddrTrackingControl_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IAddrTrackingControl_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IAddrTrackingControl_Release(This) (This)->lpVtbl->Release(This)
#define IAddrTrackingControl_EnableCOMDynamicAddrTracking(This) (This)->lpVtbl->EnableCOMDynamicAddrTracking(This)
#define IAddrTrackingControl_DisableCOMDynamicAddrTracking(This) (This)->lpVtbl->DisableCOMDynamicAddrTracking(This)

declare function IAddrTrackingControl_EnableCOMDynamicAddrTracking_Proxy(byval This as IAddrTrackingControl ptr) as HRESULT
declare sub IAddrTrackingControl_EnableCOMDynamicAddrTracking_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAddrTrackingControl_DisableCOMDynamicAddrTracking_Proxy(byval This as IAddrTrackingControl ptr) as HRESULT
declare sub IAddrTrackingControl_DisableCOMDynamicAddrTracking_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IAddrExclusionControl_INTERFACE_DEFINED__
type IAddrExclusionControl as IAddrExclusionControl_
type LPADDREXCLUSIONCONTROL as IAddrExclusionControl ptr
extern IID_IAddrExclusionControl as const GUID

type IAddrExclusionControlVtbl
	QueryInterface as function(byval This as IAddrExclusionControl ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAddrExclusionControl ptr) as ULONG
	Release as function(byval This as IAddrExclusionControl ptr) as ULONG
	GetCurrentAddrExclusionList as function(byval This as IAddrExclusionControl ptr, byval riid as const IID const ptr, byval ppEnumerator as any ptr ptr) as HRESULT
	UpdateAddrExclusionList as function(byval This as IAddrExclusionControl ptr, byval pEnumerator as IUnknown ptr) as HRESULT
end type

type IAddrExclusionControl_
	lpVtbl as IAddrExclusionControlVtbl ptr
end type

#define IAddrExclusionControl_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IAddrExclusionControl_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IAddrExclusionControl_Release(This) (This)->lpVtbl->Release(This)
#define IAddrExclusionControl_GetCurrentAddrExclusionList(This, riid, ppEnumerator) (This)->lpVtbl->GetCurrentAddrExclusionList(This, riid, ppEnumerator)
#define IAddrExclusionControl_UpdateAddrExclusionList(This, pEnumerator) (This)->lpVtbl->UpdateAddrExclusionList(This, pEnumerator)

declare function IAddrExclusionControl_GetCurrentAddrExclusionList_Proxy(byval This as IAddrExclusionControl ptr, byval riid as const IID const ptr, byval ppEnumerator as any ptr ptr) as HRESULT
declare sub IAddrExclusionControl_GetCurrentAddrExclusionList_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAddrExclusionControl_UpdateAddrExclusionList_Proxy(byval This as IAddrExclusionControl ptr, byval pEnumerator as IUnknown ptr) as HRESULT
declare sub IAddrExclusionControl_UpdateAddrExclusionList_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPipeByte_INTERFACE_DEFINED__
extern IID_IPipeByte as const GUID
type IPipeByte as IPipeByte_

type IPipeByteVtbl
	QueryInterface as function(byval This as IPipeByte ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPipeByte ptr) as ULONG
	Release as function(byval This as IPipeByte ptr) as ULONG
	Pull as function(byval This as IPipeByte ptr, byval buf as UBYTE ptr, byval cRequest as ULONG, byval pcReturned as ULONG ptr) as HRESULT
	Push as function(byval This as IPipeByte ptr, byval buf as UBYTE ptr, byval cSent as ULONG) as HRESULT
end type

type IPipeByte_
	lpVtbl as IPipeByteVtbl ptr
end type

#define IPipeByte_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPipeByte_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPipeByte_Release(This) (This)->lpVtbl->Release(This)
#define IPipeByte_Pull(This, buf, cRequest, pcReturned) (This)->lpVtbl->Pull(This, buf, cRequest, pcReturned)
#define IPipeByte_Push(This, buf, cSent) (This)->lpVtbl->Push(This, buf, cSent)

declare function IPipeByte_Pull_Proxy(byval This as IPipeByte ptr, byval buf as UBYTE ptr, byval cRequest as ULONG, byval pcReturned as ULONG ptr) as HRESULT
declare sub IPipeByte_Pull_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPipeByte_Push_Proxy(byval This as IPipeByte ptr, byval buf as UBYTE ptr, byval cSent as ULONG) as HRESULT
declare sub IPipeByte_Push_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPipeLong_INTERFACE_DEFINED__
extern IID_IPipeLong as const GUID
type IPipeLong as IPipeLong_

type IPipeLongVtbl
	QueryInterface as function(byval This as IPipeLong ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPipeLong ptr) as ULONG
	Release as function(byval This as IPipeLong ptr) as ULONG
	Pull as function(byval This as IPipeLong ptr, byval buf as LONG ptr, byval cRequest as ULONG, byval pcReturned as ULONG ptr) as HRESULT
	Push as function(byval This as IPipeLong ptr, byval buf as LONG ptr, byval cSent as ULONG) as HRESULT
end type

type IPipeLong_
	lpVtbl as IPipeLongVtbl ptr
end type

#define IPipeLong_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPipeLong_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPipeLong_Release(This) (This)->lpVtbl->Release(This)
#define IPipeLong_Pull(This, buf, cRequest, pcReturned) (This)->lpVtbl->Pull(This, buf, cRequest, pcReturned)
#define IPipeLong_Push(This, buf, cSent) (This)->lpVtbl->Push(This, buf, cSent)

declare function IPipeLong_Pull_Proxy(byval This as IPipeLong ptr, byval buf as LONG ptr, byval cRequest as ULONG, byval pcReturned as ULONG ptr) as HRESULT
declare sub IPipeLong_Pull_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPipeLong_Push_Proxy(byval This as IPipeLong ptr, byval buf as LONG ptr, byval cSent as ULONG) as HRESULT
declare sub IPipeLong_Push_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPipeDouble_INTERFACE_DEFINED__
extern IID_IPipeDouble as const GUID
type IPipeDouble as IPipeDouble_

type IPipeDoubleVtbl
	QueryInterface as function(byval This as IPipeDouble ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPipeDouble ptr) as ULONG
	Release as function(byval This as IPipeDouble ptr) as ULONG
	Pull as function(byval This as IPipeDouble ptr, byval buf as DOUBLE ptr, byval cRequest as ULONG, byval pcReturned as ULONG ptr) as HRESULT
	Push as function(byval This as IPipeDouble ptr, byval buf as DOUBLE ptr, byval cSent as ULONG) as HRESULT
end type

type IPipeDouble_
	lpVtbl as IPipeDoubleVtbl ptr
end type

#define IPipeDouble_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPipeDouble_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPipeDouble_Release(This) (This)->lpVtbl->Release(This)
#define IPipeDouble_Pull(This, buf, cRequest, pcReturned) (This)->lpVtbl->Pull(This, buf, cRequest, pcReturned)
#define IPipeDouble_Push(This, buf, cSent) (This)->lpVtbl->Push(This, buf, cSent)

declare function IPipeDouble_Pull_Proxy(byval This as IPipeDouble ptr, byval buf as DOUBLE ptr, byval cRequest as ULONG, byval pcReturned as ULONG ptr) as HRESULT
declare sub IPipeDouble_Pull_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPipeDouble_Push_Proxy(byval This as IPipeDouble ptr, byval buf as DOUBLE ptr, byval cSent as ULONG) as HRESULT
declare sub IPipeDouble_Push_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type _APTTYPEQUALIFIER as long
enum
	APTTYPEQUALIFIER_NONE = 0
	APTTYPEQUALIFIER_IMPLICIT_MTA = 1
	APTTYPEQUALIFIER_NA_ON_MTA = 2
	APTTYPEQUALIFIER_NA_ON_STA = 3
	APTTYPEQUALIFIER_NA_ON_IMPLICIT_MTA = 4
	APTTYPEQUALIFIER_NA_ON_MAINSTA = 5
	APTTYPEQUALIFIER_APPLICATION_STA = 6
end enum

type APTTYPEQUALIFIER as _APTTYPEQUALIFIER

type _APTTYPE as long
enum
	APTTYPE_CURRENT = -1
	APTTYPE_STA = 0
	APTTYPE_MTA = 1
	APTTYPE_NA = 2
	APTTYPE_MAINSTA = 3
end enum

type APTTYPE as _APTTYPE

type _THDTYPE as long
enum
	THDTYPE_BLOCKMESSAGES = 0
	THDTYPE_PROCESSMESSAGES = 1
end enum

type THDTYPE as _THDTYPE
type APARTMENTID as DWORD
#define __IComThreadingInfo_INTERFACE_DEFINED__
extern IID_IComThreadingInfo as const GUID
type IComThreadingInfo as IComThreadingInfo_

type IComThreadingInfoVtbl
	QueryInterface as function(byval This as IComThreadingInfo ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IComThreadingInfo ptr) as ULONG
	Release as function(byval This as IComThreadingInfo ptr) as ULONG
	GetCurrentApartmentType as function(byval This as IComThreadingInfo ptr, byval pAptType as APTTYPE ptr) as HRESULT
	GetCurrentThreadType as function(byval This as IComThreadingInfo ptr, byval pThreadType as THDTYPE ptr) as HRESULT
	GetCurrentLogicalThreadId as function(byval This as IComThreadingInfo ptr, byval pguidLogicalThreadId as GUID ptr) as HRESULT
	SetCurrentLogicalThreadId as function(byval This as IComThreadingInfo ptr, byval rguid as const GUID const ptr) as HRESULT
end type

type IComThreadingInfo_
	lpVtbl as IComThreadingInfoVtbl ptr
end type

#define IComThreadingInfo_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IComThreadingInfo_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IComThreadingInfo_Release(This) (This)->lpVtbl->Release(This)
#define IComThreadingInfo_GetCurrentApartmentType(This, pAptType) (This)->lpVtbl->GetCurrentApartmentType(This, pAptType)
#define IComThreadingInfo_GetCurrentThreadType(This, pThreadType) (This)->lpVtbl->GetCurrentThreadType(This, pThreadType)
#define IComThreadingInfo_GetCurrentLogicalThreadId(This, pguidLogicalThreadId) (This)->lpVtbl->GetCurrentLogicalThreadId(This, pguidLogicalThreadId)
#define IComThreadingInfo_SetCurrentLogicalThreadId(This, rguid) (This)->lpVtbl->SetCurrentLogicalThreadId(This, rguid)

declare function IComThreadingInfo_GetCurrentApartmentType_Proxy(byval This as IComThreadingInfo ptr, byval pAptType as APTTYPE ptr) as HRESULT
declare sub IComThreadingInfo_GetCurrentApartmentType_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IComThreadingInfo_GetCurrentThreadType_Proxy(byval This as IComThreadingInfo ptr, byval pThreadType as THDTYPE ptr) as HRESULT
declare sub IComThreadingInfo_GetCurrentThreadType_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IComThreadingInfo_GetCurrentLogicalThreadId_Proxy(byval This as IComThreadingInfo ptr, byval pguidLogicalThreadId as GUID ptr) as HRESULT
declare sub IComThreadingInfo_GetCurrentLogicalThreadId_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IComThreadingInfo_SetCurrentLogicalThreadId_Proxy(byval This as IComThreadingInfo ptr, byval rguid as const GUID const ptr) as HRESULT
declare sub IComThreadingInfo_SetCurrentLogicalThreadId_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IProcessInitControl_INTERFACE_DEFINED__
extern IID_IProcessInitControl as const GUID
type IProcessInitControl as IProcessInitControl_

type IProcessInitControlVtbl
	QueryInterface as function(byval This as IProcessInitControl ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IProcessInitControl ptr) as ULONG
	Release as function(byval This as IProcessInitControl ptr) as ULONG
	ResetInitializerTimeout as function(byval This as IProcessInitControl ptr, byval dwSecondsRemaining as DWORD) as HRESULT
end type

type IProcessInitControl_
	lpVtbl as IProcessInitControlVtbl ptr
end type

#define IProcessInitControl_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IProcessInitControl_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IProcessInitControl_Release(This) (This)->lpVtbl->Release(This)
#define IProcessInitControl_ResetInitializerTimeout(This, dwSecondsRemaining) (This)->lpVtbl->ResetInitializerTimeout(This, dwSecondsRemaining)
declare function IProcessInitControl_ResetInitializerTimeout_Proxy(byval This as IProcessInitControl ptr, byval dwSecondsRemaining as DWORD) as HRESULT
declare sub IProcessInitControl_ResetInitializerTimeout_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IFastRundown_INTERFACE_DEFINED__
extern IID_IFastRundown as const GUID
type IFastRundown as IFastRundown_

type IFastRundownVtbl
	QueryInterface as function(byval This as IFastRundown ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IFastRundown ptr) as ULONG
	Release as function(byval This as IFastRundown ptr) as ULONG
end type

type IFastRundown_
	lpVtbl as IFastRundownVtbl ptr
end type

#define IFastRundown_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IFastRundown_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IFastRundown_Release(This) (This)->lpVtbl->Release(This)

type CO_MARSHALING_CONTEXT_ATTRIBUTES as long
enum
	CO_MARSHALING_SOURCE_IS_APP_CONTAINER = 0
end enum

#define __IMarshalingStream_INTERFACE_DEFINED__
extern IID_IMarshalingStream as const GUID
type IMarshalingStream as IMarshalingStream_

type IMarshalingStreamVtbl
	QueryInterface as function(byval This as IMarshalingStream ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IMarshalingStream ptr) as ULONG
	Release as function(byval This as IMarshalingStream ptr) as ULONG
	Read as function(byval This as IMarshalingStream ptr, byval pv as any ptr, byval cb as ULONG, byval pcbRead as ULONG ptr) as HRESULT
	Write as function(byval This as IMarshalingStream ptr, byval pv as const any ptr, byval cb as ULONG, byval pcbWritten as ULONG ptr) as HRESULT
	Seek as function(byval This as IMarshalingStream ptr, byval dlibMove as LARGE_INTEGER, byval dwOrigin as DWORD, byval plibNewPosition as ULARGE_INTEGER ptr) as HRESULT
	SetSize as function(byval This as IMarshalingStream ptr, byval libNewSize as ULARGE_INTEGER) as HRESULT
	CopyTo as function(byval This as IMarshalingStream ptr, byval pstm as IStream ptr, byval cb as ULARGE_INTEGER, byval pcbRead as ULARGE_INTEGER ptr, byval pcbWritten as ULARGE_INTEGER ptr) as HRESULT
	Commit as function(byval This as IMarshalingStream ptr, byval grfCommitFlags as DWORD) as HRESULT
	Revert as function(byval This as IMarshalingStream ptr) as HRESULT
	LockRegion as function(byval This as IMarshalingStream ptr, byval libOffset as ULARGE_INTEGER, byval cb as ULARGE_INTEGER, byval dwLockType as DWORD) as HRESULT
	UnlockRegion as function(byval This as IMarshalingStream ptr, byval libOffset as ULARGE_INTEGER, byval cb as ULARGE_INTEGER, byval dwLockType as DWORD) as HRESULT
	Stat as function(byval This as IMarshalingStream ptr, byval pstatstg as STATSTG ptr, byval grfStatFlag as DWORD) as HRESULT
	Clone as function(byval This as IMarshalingStream ptr, byval ppstm as IStream ptr ptr) as HRESULT
	GetMarshalingContextAttribute as function(byval This as IMarshalingStream ptr, byval attribute as CO_MARSHALING_CONTEXT_ATTRIBUTES, byval pAttributeValue as ULONG_PTR ptr) as HRESULT
end type

type IMarshalingStream_
	lpVtbl as IMarshalingStreamVtbl ptr
end type

#define IMarshalingStream_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IMarshalingStream_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IMarshalingStream_Release(This) (This)->lpVtbl->Release(This)
#define IMarshalingStream_Read(This, pv, cb, pcbRead) (This)->lpVtbl->Read(This, pv, cb, pcbRead)
#define IMarshalingStream_Write(This, pv, cb, pcbWritten) (This)->lpVtbl->Write(This, pv, cb, pcbWritten)
#define IMarshalingStream_Seek(This, dlibMove, dwOrigin, plibNewPosition) (This)->lpVtbl->Seek(This, dlibMove, dwOrigin, plibNewPosition)
#define IMarshalingStream_SetSize(This, libNewSize) (This)->lpVtbl->SetSize(This, libNewSize)
#define IMarshalingStream_CopyTo(This, pstm, cb, pcbRead, pcbWritten) (This)->lpVtbl->CopyTo(This, pstm, cb, pcbRead, pcbWritten)
#define IMarshalingStream_Commit(This, grfCommitFlags) (This)->lpVtbl->Commit(This, grfCommitFlags)
#define IMarshalingStream_Revert(This) (This)->lpVtbl->Revert(This)
#define IMarshalingStream_LockRegion(This, libOffset, cb, dwLockType) (This)->lpVtbl->LockRegion(This, libOffset, cb, dwLockType)
#define IMarshalingStream_UnlockRegion(This, libOffset, cb, dwLockType) (This)->lpVtbl->UnlockRegion(This, libOffset, cb, dwLockType)
#define IMarshalingStream_Stat(This, pstatstg, grfStatFlag) (This)->lpVtbl->Stat(This, pstatstg, grfStatFlag)
#define IMarshalingStream_Clone(This, ppstm) (This)->lpVtbl->Clone(This, ppstm)
#define IMarshalingStream_GetMarshalingContextAttribute(This, attribute, pAttributeValue) (This)->lpVtbl->GetMarshalingContextAttribute(This, attribute, pAttributeValue)
declare function IMarshalingStream_GetMarshalingContextAttribute_Proxy(byval This as IMarshalingStream ptr, byval attribute as CO_MARSHALING_CONTEXT_ATTRIBUTES, byval pAttributeValue as ULONG_PTR ptr) as HRESULT
declare sub IMarshalingStream_GetMarshalingContextAttribute_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
extern IID_ICallbackWithNoReentrancyToApplicationSTA as const GUID
#define _OBJIDLBASE_

end extern
