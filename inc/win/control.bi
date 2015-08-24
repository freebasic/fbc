'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DISCLAIMER
''   This file has no copyright assigned and is placed in the Public Domain.
''   This file is part of the mingw-w64 runtime package.
''
''   The mingw-w64 runtime package and its code is distributed in the hope that it 
''   will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR 
''   IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to 
''   warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "rpc.bi"
#include once "rpcndr.bi"
#include once "windows.bi"
#include once "ole2.bi"
#include once "oaidl.bi"

extern "Windows"

#define __control_h__
#define __IMediaControl_FWD_DEFINED__
#define __IAMCollection_FWD_DEFINED__
#define __IMediaEvent_FWD_DEFINED__
#define __IMediaEventEx_FWD_DEFINED__
#define __IMediaPosition_FWD_DEFINED__
#define __IBasicAudio_FWD_DEFINED__
#define __IVideoWindow_FWD_DEFINED__
#define __IBasicVideo_FWD_DEFINED__
#define __IBasicVideo2_FWD_DEFINED__
#define __IDeferredCommand_FWD_DEFINED__
#define __IQueueCommand_FWD_DEFINED__
#define __FilgraphManager_FWD_DEFINED__
#define __IFilterInfo_FWD_DEFINED__
#define __IRegFilterInfo_FWD_DEFINED__
#define __IMediaTypeInfo_FWD_DEFINED__
#define __IPinInfo_FWD_DEFINED__
#define __IAMStats_FWD_DEFINED__
extern LIBID_QuartzTypeLib as const GUID

type OAFilterState as LONG
type OAHWND as LONG_PTR
type OAEVENT as LONG_PTR
#define REFTIME_DEFINED
type REFTIME as DOUBLE
#define __IMediaControl_INTERFACE_DEFINED__
extern IID_IMediaControl as const GUID
type IMediaControl as IMediaControl_

type IMediaControlVtbl
	QueryInterface as function(byval This as IMediaControl ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IMediaControl ptr) as ULONG
	Release as function(byval This as IMediaControl ptr) as ULONG
	GetTypeInfoCount as function(byval This as IMediaControl ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IMediaControl ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IMediaControl ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IMediaControl ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	Run as function(byval This as IMediaControl ptr) as HRESULT
	Pause as function(byval This as IMediaControl ptr) as HRESULT
	Stop as function(byval This as IMediaControl ptr) as HRESULT
	GetState as function(byval This as IMediaControl ptr, byval msTimeout as LONG, byval pfs as OAFilterState ptr) as HRESULT
	RenderFile as function(byval This as IMediaControl ptr, byval strFilename as BSTR) as HRESULT
	AddSourceFilter as function(byval This as IMediaControl ptr, byval strFilename as BSTR, byval ppUnk as IDispatch ptr ptr) as HRESULT
	get_FilterCollection as function(byval This as IMediaControl ptr, byval ppUnk as IDispatch ptr ptr) as HRESULT
	get_RegFilterCollection as function(byval This as IMediaControl ptr, byval ppUnk as IDispatch ptr ptr) as HRESULT
	StopWhenReady as function(byval This as IMediaControl ptr) as HRESULT
end type

type IMediaControl_
	lpVtbl as IMediaControlVtbl ptr
end type

#define IMediaControl_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IMediaControl_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IMediaControl_Release(This) (This)->lpVtbl->Release(This)
#define IMediaControl_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IMediaControl_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IMediaControl_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IMediaControl_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IMediaControl_Run(This) (This)->lpVtbl->Run(This)
#define IMediaControl_Pause(This) (This)->lpVtbl->Pause(This)
#define IMediaControl_Stop(This) (This)->lpVtbl->Stop(This)
#define IMediaControl_GetState(This, msTimeout, pfs) (This)->lpVtbl->GetState(This, msTimeout, pfs)
#define IMediaControl_RenderFile(This, strFilename) (This)->lpVtbl->RenderFile(This, strFilename)
#define IMediaControl_AddSourceFilter(This, strFilename, ppUnk) (This)->lpVtbl->AddSourceFilter(This, strFilename, ppUnk)
#define IMediaControl_get_FilterCollection(This, ppUnk) (This)->lpVtbl->get_FilterCollection(This, ppUnk)
#define IMediaControl_get_RegFilterCollection(This, ppUnk) (This)->lpVtbl->get_RegFilterCollection(This, ppUnk)
#define IMediaControl_StopWhenReady(This) (This)->lpVtbl->StopWhenReady(This)

declare function IMediaControl_Run_Proxy(byval This as IMediaControl ptr) as HRESULT
declare sub IMediaControl_Run_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaControl_Pause_Proxy(byval This as IMediaControl ptr) as HRESULT
declare sub IMediaControl_Pause_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaControl_Stop_Proxy(byval This as IMediaControl ptr) as HRESULT
declare sub IMediaControl_Stop_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaControl_GetState_Proxy(byval This as IMediaControl ptr, byval msTimeout as LONG, byval pfs as OAFilterState ptr) as HRESULT
declare sub IMediaControl_GetState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaControl_RenderFile_Proxy(byval This as IMediaControl ptr, byval strFilename as BSTR) as HRESULT
declare sub IMediaControl_RenderFile_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaControl_AddSourceFilter_Proxy(byval This as IMediaControl ptr, byval strFilename as BSTR, byval ppUnk as IDispatch ptr ptr) as HRESULT
declare sub IMediaControl_AddSourceFilter_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaControl_get_FilterCollection_Proxy(byval This as IMediaControl ptr, byval ppUnk as IDispatch ptr ptr) as HRESULT
declare sub IMediaControl_get_FilterCollection_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaControl_get_RegFilterCollection_Proxy(byval This as IMediaControl ptr, byval ppUnk as IDispatch ptr ptr) as HRESULT
declare sub IMediaControl_get_RegFilterCollection_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaControl_StopWhenReady_Proxy(byval This as IMediaControl ptr) as HRESULT
declare sub IMediaControl_StopWhenReady_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IAMCollection_INTERFACE_DEFINED__
extern IID_IAMCollection as const GUID
type IAMCollection as IAMCollection_

type IAMCollectionVtbl
	QueryInterface as function(byval This as IAMCollection ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMCollection ptr) as ULONG
	Release as function(byval This as IAMCollection ptr) as ULONG
	GetTypeInfoCount as function(byval This as IAMCollection ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IAMCollection ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IAMCollection ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IAMCollection ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_Count as function(byval This as IAMCollection ptr, byval plCount as LONG ptr) as HRESULT
	Item as function(byval This as IAMCollection ptr, byval lItem as long, byval ppUnk as IUnknown ptr ptr) as HRESULT
	get__NewEnum as function(byval This as IAMCollection ptr, byval ppUnk as IUnknown ptr ptr) as HRESULT
end type

type IAMCollection_
	lpVtbl as IAMCollectionVtbl ptr
end type

#define IAMCollection_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IAMCollection_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IAMCollection_Release(This) (This)->lpVtbl->Release(This)
#define IAMCollection_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IAMCollection_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IAMCollection_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IAMCollection_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IAMCollection_get_Count(This, plCount) (This)->lpVtbl->get_Count(This, plCount)
#define IAMCollection_Item(This, lItem, ppUnk) (This)->lpVtbl->Item(This, lItem, ppUnk)
#define IAMCollection_get__NewEnum(This, ppUnk) (This)->lpVtbl->get__NewEnum(This, ppUnk)

declare function IAMCollection_get_Count_Proxy(byval This as IAMCollection ptr, byval plCount as LONG ptr) as HRESULT
declare sub IAMCollection_get_Count_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMCollection_Item_Proxy(byval This as IAMCollection ptr, byval lItem as long, byval ppUnk as IUnknown ptr ptr) as HRESULT
declare sub IAMCollection_Item_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMCollection_get__NewEnum_Proxy(byval This as IAMCollection ptr, byval ppUnk as IUnknown ptr ptr) as HRESULT
declare sub IAMCollection_get__NewEnum_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IMediaEvent_INTERFACE_DEFINED__
extern IID_IMediaEvent as const GUID
type IMediaEvent as IMediaEvent_

type IMediaEventVtbl
	QueryInterface as function(byval This as IMediaEvent ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IMediaEvent ptr) as ULONG
	Release as function(byval This as IMediaEvent ptr) as ULONG
	GetTypeInfoCount as function(byval This as IMediaEvent ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IMediaEvent ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IMediaEvent ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IMediaEvent ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	GetEventHandle as function(byval This as IMediaEvent ptr, byval hEvent as OAEVENT ptr) as HRESULT
	GetEvent as function(byval This as IMediaEvent ptr, byval lEventCode as long ptr, byval lParam1 as LONG_PTR ptr, byval lParam2 as LONG_PTR ptr, byval msTimeout as long) as HRESULT
	WaitForCompletion as function(byval This as IMediaEvent ptr, byval msTimeout as long, byval pEvCode as long ptr) as HRESULT
	CancelDefaultHandling as function(byval This as IMediaEvent ptr, byval lEvCode as long) as HRESULT
	RestoreDefaultHandling as function(byval This as IMediaEvent ptr, byval lEvCode as long) as HRESULT
	FreeEventParams as function(byval This as IMediaEvent ptr, byval lEvCode as long, byval lParam1 as LONG_PTR, byval lParam2 as LONG_PTR) as HRESULT
end type

type IMediaEvent_
	lpVtbl as IMediaEventVtbl ptr
end type

#define IMediaEvent_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IMediaEvent_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IMediaEvent_Release(This) (This)->lpVtbl->Release(This)
#define IMediaEvent_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IMediaEvent_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IMediaEvent_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IMediaEvent_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IMediaEvent_GetEventHandle(This, hEvent) (This)->lpVtbl->GetEventHandle(This, hEvent)
#define IMediaEvent_GetEvent(This, lEventCode, lParam1, lParam2, msTimeout) (This)->lpVtbl->GetEvent(This, lEventCode, lParam1, lParam2, msTimeout)
#define IMediaEvent_WaitForCompletion(This, msTimeout, pEvCode) (This)->lpVtbl->WaitForCompletion(This, msTimeout, pEvCode)
#define IMediaEvent_CancelDefaultHandling(This, lEvCode) (This)->lpVtbl->CancelDefaultHandling(This, lEvCode)
#define IMediaEvent_RestoreDefaultHandling(This, lEvCode) (This)->lpVtbl->RestoreDefaultHandling(This, lEvCode)
#define IMediaEvent_FreeEventParams(This, lEvCode, lParam1, lParam2) (This)->lpVtbl->FreeEventParams(This, lEvCode, lParam1, lParam2)

declare function IMediaEvent_GetEventHandle_Proxy(byval This as IMediaEvent ptr, byval hEvent as OAEVENT ptr) as HRESULT
declare sub IMediaEvent_GetEventHandle_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaEvent_GetEvent_Proxy(byval This as IMediaEvent ptr, byval lEventCode as long ptr, byval lParam1 as LONG_PTR ptr, byval lParam2 as LONG_PTR ptr, byval msTimeout as long) as HRESULT
declare sub IMediaEvent_GetEvent_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaEvent_WaitForCompletion_Proxy(byval This as IMediaEvent ptr, byval msTimeout as long, byval pEvCode as long ptr) as HRESULT
declare sub IMediaEvent_WaitForCompletion_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaEvent_CancelDefaultHandling_Proxy(byval This as IMediaEvent ptr, byval lEvCode as long) as HRESULT
declare sub IMediaEvent_CancelDefaultHandling_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaEvent_RestoreDefaultHandling_Proxy(byval This as IMediaEvent ptr, byval lEvCode as long) as HRESULT
declare sub IMediaEvent_RestoreDefaultHandling_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaEvent_FreeEventParams_Proxy(byval This as IMediaEvent ptr, byval lEvCode as long, byval lParam1 as LONG_PTR, byval lParam2 as LONG_PTR) as HRESULT
declare sub IMediaEvent_FreeEventParams_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IMediaEventEx_INTERFACE_DEFINED__
extern IID_IMediaEventEx as const GUID
type IMediaEventEx as IMediaEventEx_

type IMediaEventExVtbl
	QueryInterface as function(byval This as IMediaEventEx ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IMediaEventEx ptr) as ULONG
	Release as function(byval This as IMediaEventEx ptr) as ULONG
	GetTypeInfoCount as function(byval This as IMediaEventEx ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IMediaEventEx ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IMediaEventEx ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IMediaEventEx ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	GetEventHandle as function(byval This as IMediaEventEx ptr, byval hEvent as OAEVENT ptr) as HRESULT
	GetEvent as function(byval This as IMediaEventEx ptr, byval lEventCode as long ptr, byval lParam1 as LONG_PTR ptr, byval lParam2 as LONG_PTR ptr, byval msTimeout as long) as HRESULT
	WaitForCompletion as function(byval This as IMediaEventEx ptr, byval msTimeout as long, byval pEvCode as long ptr) as HRESULT
	CancelDefaultHandling as function(byval This as IMediaEventEx ptr, byval lEvCode as long) as HRESULT
	RestoreDefaultHandling as function(byval This as IMediaEventEx ptr, byval lEvCode as long) as HRESULT
	FreeEventParams as function(byval This as IMediaEventEx ptr, byval lEvCode as long, byval lParam1 as LONG_PTR, byval lParam2 as LONG_PTR) as HRESULT
	SetNotifyWindow as function(byval This as IMediaEventEx ptr, byval hwnd as OAHWND, byval lMsg as long, byval lInstanceData as LONG_PTR) as HRESULT
	SetNotifyFlags as function(byval This as IMediaEventEx ptr, byval lNoNotifyFlags as long) as HRESULT
	GetNotifyFlags as function(byval This as IMediaEventEx ptr, byval lplNoNotifyFlags as long ptr) as HRESULT
end type

type IMediaEventEx_
	lpVtbl as IMediaEventExVtbl ptr
end type

#define IMediaEventEx_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IMediaEventEx_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IMediaEventEx_Release(This) (This)->lpVtbl->Release(This)
#define IMediaEventEx_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IMediaEventEx_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IMediaEventEx_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IMediaEventEx_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IMediaEventEx_GetEventHandle(This, hEvent) (This)->lpVtbl->GetEventHandle(This, hEvent)
#define IMediaEventEx_GetEvent(This, lEventCode, lParam1, lParam2, msTimeout) (This)->lpVtbl->GetEvent(This, lEventCode, lParam1, lParam2, msTimeout)
#define IMediaEventEx_WaitForCompletion(This, msTimeout, pEvCode) (This)->lpVtbl->WaitForCompletion(This, msTimeout, pEvCode)
#define IMediaEventEx_CancelDefaultHandling(This, lEvCode) (This)->lpVtbl->CancelDefaultHandling(This, lEvCode)
#define IMediaEventEx_RestoreDefaultHandling(This, lEvCode) (This)->lpVtbl->RestoreDefaultHandling(This, lEvCode)
#define IMediaEventEx_FreeEventParams(This, lEvCode, lParam1, lParam2) (This)->lpVtbl->FreeEventParams(This, lEvCode, lParam1, lParam2)
#define IMediaEventEx_SetNotifyWindow(This, hwnd, lMsg, lInstanceData) (This)->lpVtbl->SetNotifyWindow(This, hwnd, lMsg, lInstanceData)
#define IMediaEventEx_SetNotifyFlags(This, lNoNotifyFlags) (This)->lpVtbl->SetNotifyFlags(This, lNoNotifyFlags)
#define IMediaEventEx_GetNotifyFlags(This, lplNoNotifyFlags) (This)->lpVtbl->GetNotifyFlags(This, lplNoNotifyFlags)

declare function IMediaEventEx_SetNotifyWindow_Proxy(byval This as IMediaEventEx ptr, byval hwnd as OAHWND, byval lMsg as long, byval lInstanceData as LONG_PTR) as HRESULT
declare sub IMediaEventEx_SetNotifyWindow_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaEventEx_SetNotifyFlags_Proxy(byval This as IMediaEventEx ptr, byval lNoNotifyFlags as long) as HRESULT
declare sub IMediaEventEx_SetNotifyFlags_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaEventEx_GetNotifyFlags_Proxy(byval This as IMediaEventEx ptr, byval lplNoNotifyFlags as long ptr) as HRESULT
declare sub IMediaEventEx_GetNotifyFlags_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IMediaPosition_INTERFACE_DEFINED__
extern IID_IMediaPosition as const GUID
type IMediaPosition as IMediaPosition_

type IMediaPositionVtbl
	QueryInterface as function(byval This as IMediaPosition ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IMediaPosition ptr) as ULONG
	Release as function(byval This as IMediaPosition ptr) as ULONG
	GetTypeInfoCount as function(byval This as IMediaPosition ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IMediaPosition ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IMediaPosition ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IMediaPosition ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_Duration as function(byval This as IMediaPosition ptr, byval plength as REFTIME ptr) as HRESULT
	put_CurrentPosition as function(byval This as IMediaPosition ptr, byval llTime as REFTIME) as HRESULT
	get_CurrentPosition as function(byval This as IMediaPosition ptr, byval pllTime as REFTIME ptr) as HRESULT
	get_StopTime as function(byval This as IMediaPosition ptr, byval pllTime as REFTIME ptr) as HRESULT
	put_StopTime as function(byval This as IMediaPosition ptr, byval llTime as REFTIME) as HRESULT
	get_PrerollTime as function(byval This as IMediaPosition ptr, byval pllTime as REFTIME ptr) as HRESULT
	put_PrerollTime as function(byval This as IMediaPosition ptr, byval llTime as REFTIME) as HRESULT
	put_Rate as function(byval This as IMediaPosition ptr, byval dRate as double) as HRESULT
	get_Rate as function(byval This as IMediaPosition ptr, byval pdRate as double ptr) as HRESULT
	CanSeekForward as function(byval This as IMediaPosition ptr, byval pCanSeekForward as LONG ptr) as HRESULT
	CanSeekBackward as function(byval This as IMediaPosition ptr, byval pCanSeekBackward as LONG ptr) as HRESULT
end type

type IMediaPosition_
	lpVtbl as IMediaPositionVtbl ptr
end type

#define IMediaPosition_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IMediaPosition_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IMediaPosition_Release(This) (This)->lpVtbl->Release(This)
#define IMediaPosition_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IMediaPosition_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IMediaPosition_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IMediaPosition_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IMediaPosition_get_Duration(This, plength) (This)->lpVtbl->get_Duration(This, plength)
#define IMediaPosition_put_CurrentPosition(This, llTime) (This)->lpVtbl->put_CurrentPosition(This, llTime)
#define IMediaPosition_get_CurrentPosition(This, pllTime) (This)->lpVtbl->get_CurrentPosition(This, pllTime)
#define IMediaPosition_get_StopTime(This, pllTime) (This)->lpVtbl->get_StopTime(This, pllTime)
#define IMediaPosition_put_StopTime(This, llTime) (This)->lpVtbl->put_StopTime(This, llTime)
#define IMediaPosition_get_PrerollTime(This, pllTime) (This)->lpVtbl->get_PrerollTime(This, pllTime)
#define IMediaPosition_put_PrerollTime(This, llTime) (This)->lpVtbl->put_PrerollTime(This, llTime)
#define IMediaPosition_put_Rate(This, dRate) (This)->lpVtbl->put_Rate(This, dRate)
#define IMediaPosition_get_Rate(This, pdRate) (This)->lpVtbl->get_Rate(This, pdRate)
#define IMediaPosition_CanSeekForward(This, pCanSeekForward) (This)->lpVtbl->CanSeekForward(This, pCanSeekForward)
#define IMediaPosition_CanSeekBackward(This, pCanSeekBackward) (This)->lpVtbl->CanSeekBackward(This, pCanSeekBackward)

declare function IMediaPosition_get_Duration_Proxy(byval This as IMediaPosition ptr, byval plength as REFTIME ptr) as HRESULT
declare sub IMediaPosition_get_Duration_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaPosition_put_CurrentPosition_Proxy(byval This as IMediaPosition ptr, byval llTime as REFTIME) as HRESULT
declare sub IMediaPosition_put_CurrentPosition_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaPosition_get_CurrentPosition_Proxy(byval This as IMediaPosition ptr, byval pllTime as REFTIME ptr) as HRESULT
declare sub IMediaPosition_get_CurrentPosition_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaPosition_get_StopTime_Proxy(byval This as IMediaPosition ptr, byval pllTime as REFTIME ptr) as HRESULT
declare sub IMediaPosition_get_StopTime_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaPosition_put_StopTime_Proxy(byval This as IMediaPosition ptr, byval llTime as REFTIME) as HRESULT
declare sub IMediaPosition_put_StopTime_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaPosition_get_PrerollTime_Proxy(byval This as IMediaPosition ptr, byval pllTime as REFTIME ptr) as HRESULT
declare sub IMediaPosition_get_PrerollTime_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaPosition_put_PrerollTime_Proxy(byval This as IMediaPosition ptr, byval llTime as REFTIME) as HRESULT
declare sub IMediaPosition_put_PrerollTime_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaPosition_put_Rate_Proxy(byval This as IMediaPosition ptr, byval dRate as double) as HRESULT
declare sub IMediaPosition_put_Rate_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaPosition_get_Rate_Proxy(byval This as IMediaPosition ptr, byval pdRate as double ptr) as HRESULT
declare sub IMediaPosition_get_Rate_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaPosition_CanSeekForward_Proxy(byval This as IMediaPosition ptr, byval pCanSeekForward as LONG ptr) as HRESULT
declare sub IMediaPosition_CanSeekForward_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaPosition_CanSeekBackward_Proxy(byval This as IMediaPosition ptr, byval pCanSeekBackward as LONG ptr) as HRESULT
declare sub IMediaPosition_CanSeekBackward_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IBasicAudio_INTERFACE_DEFINED__
extern IID_IBasicAudio as const GUID
type IBasicAudio as IBasicAudio_

type IBasicAudioVtbl
	QueryInterface as function(byval This as IBasicAudio ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IBasicAudio ptr) as ULONG
	Release as function(byval This as IBasicAudio ptr) as ULONG
	GetTypeInfoCount as function(byval This as IBasicAudio ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IBasicAudio ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IBasicAudio ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IBasicAudio ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	put_Volume as function(byval This as IBasicAudio ptr, byval lVolume as long) as HRESULT
	get_Volume as function(byval This as IBasicAudio ptr, byval plVolume as long ptr) as HRESULT
	put_Balance as function(byval This as IBasicAudio ptr, byval lBalance as long) as HRESULT
	get_Balance as function(byval This as IBasicAudio ptr, byval plBalance as long ptr) as HRESULT
end type

type IBasicAudio_
	lpVtbl as IBasicAudioVtbl ptr
end type

#define IBasicAudio_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IBasicAudio_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IBasicAudio_Release(This) (This)->lpVtbl->Release(This)
#define IBasicAudio_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IBasicAudio_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IBasicAudio_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IBasicAudio_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IBasicAudio_put_Volume(This, lVolume) (This)->lpVtbl->put_Volume(This, lVolume)
#define IBasicAudio_get_Volume(This, plVolume) (This)->lpVtbl->get_Volume(This, plVolume)
#define IBasicAudio_put_Balance(This, lBalance) (This)->lpVtbl->put_Balance(This, lBalance)
#define IBasicAudio_get_Balance(This, plBalance) (This)->lpVtbl->get_Balance(This, plBalance)

declare function IBasicAudio_put_Volume_Proxy(byval This as IBasicAudio ptr, byval lVolume as long) as HRESULT
declare sub IBasicAudio_put_Volume_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicAudio_get_Volume_Proxy(byval This as IBasicAudio ptr, byval plVolume as long ptr) as HRESULT
declare sub IBasicAudio_get_Volume_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicAudio_put_Balance_Proxy(byval This as IBasicAudio ptr, byval lBalance as long) as HRESULT
declare sub IBasicAudio_put_Balance_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicAudio_get_Balance_Proxy(byval This as IBasicAudio ptr, byval plBalance as long ptr) as HRESULT
declare sub IBasicAudio_get_Balance_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IVideoWindow_INTERFACE_DEFINED__
extern IID_IVideoWindow as const GUID
type IVideoWindow as IVideoWindow_

type IVideoWindowVtbl
	QueryInterface as function(byval This as IVideoWindow ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IVideoWindow ptr) as ULONG
	Release as function(byval This as IVideoWindow ptr) as ULONG
	GetTypeInfoCount as function(byval This as IVideoWindow ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IVideoWindow ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IVideoWindow ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IVideoWindow ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	put_Caption as function(byval This as IVideoWindow ptr, byval strCaption as BSTR) as HRESULT
	get_Caption as function(byval This as IVideoWindow ptr, byval strCaption as BSTR ptr) as HRESULT
	put_WindowStyle as function(byval This as IVideoWindow ptr, byval WindowStyle as long) as HRESULT
	get_WindowStyle as function(byval This as IVideoWindow ptr, byval WindowStyle as long ptr) as HRESULT
	put_WindowStyleEx as function(byval This as IVideoWindow ptr, byval WindowStyleEx as long) as HRESULT
	get_WindowStyleEx as function(byval This as IVideoWindow ptr, byval WindowStyleEx as long ptr) as HRESULT
	put_AutoShow as function(byval This as IVideoWindow ptr, byval AutoShow as long) as HRESULT
	get_AutoShow as function(byval This as IVideoWindow ptr, byval AutoShow as long ptr) as HRESULT
	put_WindowState as function(byval This as IVideoWindow ptr, byval WindowState as long) as HRESULT
	get_WindowState as function(byval This as IVideoWindow ptr, byval WindowState as long ptr) as HRESULT
	put_BackgroundPalette as function(byval This as IVideoWindow ptr, byval BackgroundPalette as long) as HRESULT
	get_BackgroundPalette as function(byval This as IVideoWindow ptr, byval pBackgroundPalette as long ptr) as HRESULT
	put_Visible as function(byval This as IVideoWindow ptr, byval Visible as long) as HRESULT
	get_Visible as function(byval This as IVideoWindow ptr, byval pVisible as long ptr) as HRESULT
	put_Left as function(byval This as IVideoWindow ptr, byval Left as long) as HRESULT
	get_Left as function(byval This as IVideoWindow ptr, byval pLeft as long ptr) as HRESULT
	put_Width as function(byval This as IVideoWindow ptr, byval Width as long) as HRESULT
	get_Width as function(byval This as IVideoWindow ptr, byval pWidth as long ptr) as HRESULT
	put_Top as function(byval This as IVideoWindow ptr, byval Top as long) as HRESULT
	get_Top as function(byval This as IVideoWindow ptr, byval pTop as long ptr) as HRESULT
	put_Height as function(byval This as IVideoWindow ptr, byval Height as long) as HRESULT
	get_Height as function(byval This as IVideoWindow ptr, byval pHeight as long ptr) as HRESULT
	put_Owner as function(byval This as IVideoWindow ptr, byval Owner as OAHWND) as HRESULT
	get_Owner as function(byval This as IVideoWindow ptr, byval Owner as OAHWND ptr) as HRESULT
	put_MessageDrain as function(byval This as IVideoWindow ptr, byval Drain as OAHWND) as HRESULT
	get_MessageDrain as function(byval This as IVideoWindow ptr, byval Drain as OAHWND ptr) as HRESULT
	get_BorderColor as function(byval This as IVideoWindow ptr, byval Color as long ptr) as HRESULT
	put_BorderColor as function(byval This as IVideoWindow ptr, byval Color as long) as HRESULT
	get_FullScreenMode as function(byval This as IVideoWindow ptr, byval FullScreenMode as long ptr) as HRESULT
	put_FullScreenMode as function(byval This as IVideoWindow ptr, byval FullScreenMode as long) as HRESULT
	SetWindowForeground as function(byval This as IVideoWindow ptr, byval Focus as long) as HRESULT
	NotifyOwnerMessage as function(byval This as IVideoWindow ptr, byval hwnd as OAHWND, byval uMsg as long, byval wParam as LONG_PTR, byval lParam as LONG_PTR) as HRESULT
	SetWindowPosition as function(byval This as IVideoWindow ptr, byval Left as long, byval Top as long, byval Width as long, byval Height as long) as HRESULT
	GetWindowPosition as function(byval This as IVideoWindow ptr, byval pLeft as long ptr, byval pTop as long ptr, byval pWidth as long ptr, byval pHeight as long ptr) as HRESULT
	GetMinIdealImageSize as function(byval This as IVideoWindow ptr, byval pWidth as long ptr, byval pHeight as long ptr) as HRESULT
	GetMaxIdealImageSize as function(byval This as IVideoWindow ptr, byval pWidth as long ptr, byval pHeight as long ptr) as HRESULT
	GetRestorePosition as function(byval This as IVideoWindow ptr, byval pLeft as long ptr, byval pTop as long ptr, byval pWidth as long ptr, byval pHeight as long ptr) as HRESULT
	HideCursor as function(byval This as IVideoWindow ptr, byval HideCursor as long) as HRESULT
	IsCursorHidden as function(byval This as IVideoWindow ptr, byval CursorHidden as long ptr) as HRESULT
end type

type IVideoWindow_
	lpVtbl as IVideoWindowVtbl ptr
end type

#define IVideoWindow_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IVideoWindow_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IVideoWindow_Release(This) (This)->lpVtbl->Release(This)
#define IVideoWindow_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IVideoWindow_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IVideoWindow_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IVideoWindow_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IVideoWindow_put_Caption(This, strCaption) (This)->lpVtbl->put_Caption(This, strCaption)
#define IVideoWindow_get_Caption(This, strCaption) (This)->lpVtbl->get_Caption(This, strCaption)
#define IVideoWindow_put_WindowStyle(This, WindowStyle) (This)->lpVtbl->put_WindowStyle(This, WindowStyle)
#define IVideoWindow_get_WindowStyle(This, WindowStyle) (This)->lpVtbl->get_WindowStyle(This, WindowStyle)
#define IVideoWindow_put_WindowStyleEx(This, WindowStyleEx) (This)->lpVtbl->put_WindowStyleEx(This, WindowStyleEx)
#define IVideoWindow_get_WindowStyleEx(This, WindowStyleEx) (This)->lpVtbl->get_WindowStyleEx(This, WindowStyleEx)
#define IVideoWindow_put_AutoShow(This, AutoShow) (This)->lpVtbl->put_AutoShow(This, AutoShow)
#define IVideoWindow_get_AutoShow(This, AutoShow) (This)->lpVtbl->get_AutoShow(This, AutoShow)
#define IVideoWindow_put_WindowState(This, WindowState) (This)->lpVtbl->put_WindowState(This, WindowState)
#define IVideoWindow_get_WindowState(This, WindowState) (This)->lpVtbl->get_WindowState(This, WindowState)
#define IVideoWindow_put_BackgroundPalette(This, BackgroundPalette) (This)->lpVtbl->put_BackgroundPalette(This, BackgroundPalette)
#define IVideoWindow_get_BackgroundPalette(This, pBackgroundPalette) (This)->lpVtbl->get_BackgroundPalette(This, pBackgroundPalette)
#define IVideoWindow_put_Visible(This, Visible) (This)->lpVtbl->put_Visible(This, Visible)
#define IVideoWindow_get_Visible(This, pVisible) (This)->lpVtbl->get_Visible(This, pVisible)
#define IVideoWindow_put_Left(This, Left) (This)->lpVtbl->put_Left(This, Left)
#define IVideoWindow_get_Left(This, pLeft) (This)->lpVtbl->get_Left(This, pLeft)
#define IVideoWindow_put_Width(This, Width) (This)->lpVtbl->put_Width(This, Width)
#define IVideoWindow_get_Width(This, pWidth) (This)->lpVtbl->get_Width(This, pWidth)
#define IVideoWindow_put_Top(This, Top) (This)->lpVtbl->put_Top(This, Top)
#define IVideoWindow_get_Top(This, pTop) (This)->lpVtbl->get_Top(This, pTop)
#define IVideoWindow_put_Height(This, Height) (This)->lpVtbl->put_Height(This, Height)
#define IVideoWindow_get_Height(This, pHeight) (This)->lpVtbl->get_Height(This, pHeight)
#define IVideoWindow_put_Owner(This, Owner) (This)->lpVtbl->put_Owner(This, Owner)
#define IVideoWindow_get_Owner(This, Owner) (This)->lpVtbl->get_Owner(This, Owner)
#define IVideoWindow_put_MessageDrain(This, Drain) (This)->lpVtbl->put_MessageDrain(This, Drain)
#define IVideoWindow_get_MessageDrain(This, Drain) (This)->lpVtbl->get_MessageDrain(This, Drain)
#define IVideoWindow_get_BorderColor(This, Color) (This)->lpVtbl->get_BorderColor(This, Color)
#define IVideoWindow_put_BorderColor(This, Color) (This)->lpVtbl->put_BorderColor(This, Color)
#define IVideoWindow_get_FullScreenMode(This, FullScreenMode) (This)->lpVtbl->get_FullScreenMode(This, FullScreenMode)
#define IVideoWindow_put_FullScreenMode(This, FullScreenMode) (This)->lpVtbl->put_FullScreenMode(This, FullScreenMode)
#define IVideoWindow_SetWindowForeground(This, Focus) (This)->lpVtbl->SetWindowForeground(This, Focus)
#define IVideoWindow_NotifyOwnerMessage(This, hwnd, uMsg, wParam, lParam) (This)->lpVtbl->NotifyOwnerMessage(This, hwnd, uMsg, wParam, lParam)
#define IVideoWindow_SetWindowPosition(This, Left, Top, Width, Height) (This)->lpVtbl->SetWindowPosition(This, Left, Top, Width, Height)
#define IVideoWindow_GetWindowPosition(This, pLeft, pTop, pWidth, pHeight) (This)->lpVtbl->GetWindowPosition(This, pLeft, pTop, pWidth, pHeight)
#define IVideoWindow_GetMinIdealImageSize(This, pWidth, pHeight) (This)->lpVtbl->GetMinIdealImageSize(This, pWidth, pHeight)
#define IVideoWindow_GetMaxIdealImageSize(This, pWidth, pHeight) (This)->lpVtbl->GetMaxIdealImageSize(This, pWidth, pHeight)
#define IVideoWindow_GetRestorePosition(This, pLeft, pTop, pWidth, pHeight) (This)->lpVtbl->GetRestorePosition(This, pLeft, pTop, pWidth, pHeight)
#define IVideoWindow_HideCursor(This, HideCursor) (This)->lpVtbl->HideCursor(This, HideCursor)
#define IVideoWindow_IsCursorHidden(This, CursorHidden) (This)->lpVtbl->IsCursorHidden(This, CursorHidden)

declare function IVideoWindow_put_Caption_Proxy(byval This as IVideoWindow ptr, byval strCaption as BSTR) as HRESULT
declare sub IVideoWindow_put_Caption_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_get_Caption_Proxy(byval This as IVideoWindow ptr, byval strCaption as BSTR ptr) as HRESULT
declare sub IVideoWindow_get_Caption_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_put_WindowStyle_Proxy(byval This as IVideoWindow ptr, byval WindowStyle as long) as HRESULT
declare sub IVideoWindow_put_WindowStyle_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_get_WindowStyle_Proxy(byval This as IVideoWindow ptr, byval WindowStyle as long ptr) as HRESULT
declare sub IVideoWindow_get_WindowStyle_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_put_WindowStyleEx_Proxy(byval This as IVideoWindow ptr, byval WindowStyleEx as long) as HRESULT
declare sub IVideoWindow_put_WindowStyleEx_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_get_WindowStyleEx_Proxy(byval This as IVideoWindow ptr, byval WindowStyleEx as long ptr) as HRESULT
declare sub IVideoWindow_get_WindowStyleEx_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_put_AutoShow_Proxy(byval This as IVideoWindow ptr, byval AutoShow as long) as HRESULT
declare sub IVideoWindow_put_AutoShow_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_get_AutoShow_Proxy(byval This as IVideoWindow ptr, byval AutoShow as long ptr) as HRESULT
declare sub IVideoWindow_get_AutoShow_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_put_WindowState_Proxy(byval This as IVideoWindow ptr, byval WindowState as long) as HRESULT
declare sub IVideoWindow_put_WindowState_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_get_WindowState_Proxy(byval This as IVideoWindow ptr, byval WindowState as long ptr) as HRESULT
declare sub IVideoWindow_get_WindowState_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_put_BackgroundPalette_Proxy(byval This as IVideoWindow ptr, byval BackgroundPalette as long) as HRESULT
declare sub IVideoWindow_put_BackgroundPalette_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_get_BackgroundPalette_Proxy(byval This as IVideoWindow ptr, byval pBackgroundPalette as long ptr) as HRESULT
declare sub IVideoWindow_get_BackgroundPalette_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_put_Visible_Proxy(byval This as IVideoWindow ptr, byval Visible as long) as HRESULT
declare sub IVideoWindow_put_Visible_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_get_Visible_Proxy(byval This as IVideoWindow ptr, byval pVisible as long ptr) as HRESULT
declare sub IVideoWindow_get_Visible_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_put_Left_Proxy(byval This as IVideoWindow ptr, byval Left as long) as HRESULT
declare sub IVideoWindow_put_Left_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_get_Left_Proxy(byval This as IVideoWindow ptr, byval pLeft as long ptr) as HRESULT
declare sub IVideoWindow_get_Left_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_put_Width_Proxy(byval This as IVideoWindow ptr, byval Width as long) as HRESULT
declare sub IVideoWindow_put_Width_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_get_Width_Proxy(byval This as IVideoWindow ptr, byval pWidth as long ptr) as HRESULT
declare sub IVideoWindow_get_Width_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_put_Top_Proxy(byval This as IVideoWindow ptr, byval Top as long) as HRESULT
declare sub IVideoWindow_put_Top_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_get_Top_Proxy(byval This as IVideoWindow ptr, byval pTop as long ptr) as HRESULT
declare sub IVideoWindow_get_Top_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_put_Height_Proxy(byval This as IVideoWindow ptr, byval Height as long) as HRESULT
declare sub IVideoWindow_put_Height_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_get_Height_Proxy(byval This as IVideoWindow ptr, byval pHeight as long ptr) as HRESULT
declare sub IVideoWindow_get_Height_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_put_Owner_Proxy(byval This as IVideoWindow ptr, byval Owner as OAHWND) as HRESULT
declare sub IVideoWindow_put_Owner_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_get_Owner_Proxy(byval This as IVideoWindow ptr, byval Owner as OAHWND ptr) as HRESULT
declare sub IVideoWindow_get_Owner_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_put_MessageDrain_Proxy(byval This as IVideoWindow ptr, byval Drain as OAHWND) as HRESULT
declare sub IVideoWindow_put_MessageDrain_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_get_MessageDrain_Proxy(byval This as IVideoWindow ptr, byval Drain as OAHWND ptr) as HRESULT
declare sub IVideoWindow_get_MessageDrain_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_get_BorderColor_Proxy(byval This as IVideoWindow ptr, byval Color as long ptr) as HRESULT
declare sub IVideoWindow_get_BorderColor_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_put_BorderColor_Proxy(byval This as IVideoWindow ptr, byval Color as long) as HRESULT
declare sub IVideoWindow_put_BorderColor_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_get_FullScreenMode_Proxy(byval This as IVideoWindow ptr, byval FullScreenMode as long ptr) as HRESULT
declare sub IVideoWindow_get_FullScreenMode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_put_FullScreenMode_Proxy(byval This as IVideoWindow ptr, byval FullScreenMode as long) as HRESULT
declare sub IVideoWindow_put_FullScreenMode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_SetWindowForeground_Proxy(byval This as IVideoWindow ptr, byval Focus as long) as HRESULT
declare sub IVideoWindow_SetWindowForeground_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_NotifyOwnerMessage_Proxy(byval This as IVideoWindow ptr, byval hwnd as OAHWND, byval uMsg as long, byval wParam as LONG_PTR, byval lParam as LONG_PTR) as HRESULT
declare sub IVideoWindow_NotifyOwnerMessage_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_SetWindowPosition_Proxy(byval This as IVideoWindow ptr, byval Left as long, byval Top as long, byval Width as long, byval Height as long) as HRESULT
declare sub IVideoWindow_SetWindowPosition_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_GetWindowPosition_Proxy(byval This as IVideoWindow ptr, byval pLeft as long ptr, byval pTop as long ptr, byval pWidth as long ptr, byval pHeight as long ptr) as HRESULT
declare sub IVideoWindow_GetWindowPosition_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_GetMinIdealImageSize_Proxy(byval This as IVideoWindow ptr, byval pWidth as long ptr, byval pHeight as long ptr) as HRESULT
declare sub IVideoWindow_GetMinIdealImageSize_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_GetMaxIdealImageSize_Proxy(byval This as IVideoWindow ptr, byval pWidth as long ptr, byval pHeight as long ptr) as HRESULT
declare sub IVideoWindow_GetMaxIdealImageSize_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_GetRestorePosition_Proxy(byval This as IVideoWindow ptr, byval pLeft as long ptr, byval pTop as long ptr, byval pWidth as long ptr, byval pHeight as long ptr) as HRESULT
declare sub IVideoWindow_GetRestorePosition_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_HideCursor_Proxy(byval This as IVideoWindow ptr, byval HideCursor as long) as HRESULT
declare sub IVideoWindow_HideCursor_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_IsCursorHidden_Proxy(byval This as IVideoWindow ptr, byval CursorHidden as long ptr) as HRESULT
declare sub IVideoWindow_IsCursorHidden_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IBasicVideo_INTERFACE_DEFINED__
extern IID_IBasicVideo as const GUID
type IBasicVideo as IBasicVideo_

type IBasicVideoVtbl
	QueryInterface as function(byval This as IBasicVideo ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IBasicVideo ptr) as ULONG
	Release as function(byval This as IBasicVideo ptr) as ULONG
	GetTypeInfoCount as function(byval This as IBasicVideo ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IBasicVideo ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IBasicVideo ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IBasicVideo ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_AvgTimePerFrame as function(byval This as IBasicVideo ptr, byval pAvgTimePerFrame as REFTIME ptr) as HRESULT
	get_BitRate as function(byval This as IBasicVideo ptr, byval pBitRate as long ptr) as HRESULT
	get_BitErrorRate as function(byval This as IBasicVideo ptr, byval pBitErrorRate as long ptr) as HRESULT
	get_VideoWidth as function(byval This as IBasicVideo ptr, byval pVideoWidth as long ptr) as HRESULT
	get_VideoHeight as function(byval This as IBasicVideo ptr, byval pVideoHeight as long ptr) as HRESULT
	put_SourceLeft as function(byval This as IBasicVideo ptr, byval SourceLeft as long) as HRESULT
	get_SourceLeft as function(byval This as IBasicVideo ptr, byval pSourceLeft as long ptr) as HRESULT
	put_SourceWidth as function(byval This as IBasicVideo ptr, byval SourceWidth as long) as HRESULT
	get_SourceWidth as function(byval This as IBasicVideo ptr, byval pSourceWidth as long ptr) as HRESULT
	put_SourceTop as function(byval This as IBasicVideo ptr, byval SourceTop as long) as HRESULT
	get_SourceTop as function(byval This as IBasicVideo ptr, byval pSourceTop as long ptr) as HRESULT
	put_SourceHeight as function(byval This as IBasicVideo ptr, byval SourceHeight as long) as HRESULT
	get_SourceHeight as function(byval This as IBasicVideo ptr, byval pSourceHeight as long ptr) as HRESULT
	put_DestinationLeft as function(byval This as IBasicVideo ptr, byval DestinationLeft as long) as HRESULT
	get_DestinationLeft as function(byval This as IBasicVideo ptr, byval pDestinationLeft as long ptr) as HRESULT
	put_DestinationWidth as function(byval This as IBasicVideo ptr, byval DestinationWidth as long) as HRESULT
	get_DestinationWidth as function(byval This as IBasicVideo ptr, byval pDestinationWidth as long ptr) as HRESULT
	put_DestinationTop as function(byval This as IBasicVideo ptr, byval DestinationTop as long) as HRESULT
	get_DestinationTop as function(byval This as IBasicVideo ptr, byval pDestinationTop as long ptr) as HRESULT
	put_DestinationHeight as function(byval This as IBasicVideo ptr, byval DestinationHeight as long) as HRESULT
	get_DestinationHeight as function(byval This as IBasicVideo ptr, byval pDestinationHeight as long ptr) as HRESULT
	SetSourcePosition as function(byval This as IBasicVideo ptr, byval Left as long, byval Top as long, byval Width as long, byval Height as long) as HRESULT
	GetSourcePosition as function(byval This as IBasicVideo ptr, byval pLeft as long ptr, byval pTop as long ptr, byval pWidth as long ptr, byval pHeight as long ptr) as HRESULT
	SetDefaultSourcePosition as function(byval This as IBasicVideo ptr) as HRESULT
	SetDestinationPosition as function(byval This as IBasicVideo ptr, byval Left as long, byval Top as long, byval Width as long, byval Height as long) as HRESULT
	GetDestinationPosition as function(byval This as IBasicVideo ptr, byval pLeft as long ptr, byval pTop as long ptr, byval pWidth as long ptr, byval pHeight as long ptr) as HRESULT
	SetDefaultDestinationPosition as function(byval This as IBasicVideo ptr) as HRESULT
	GetVideoSize as function(byval This as IBasicVideo ptr, byval pWidth as long ptr, byval pHeight as long ptr) as HRESULT
	GetVideoPaletteEntries as function(byval This as IBasicVideo ptr, byval StartIndex as long, byval Entries as long, byval pRetrieved as long ptr, byval pPalette as long ptr) as HRESULT
	GetCurrentImage as function(byval This as IBasicVideo ptr, byval pBufferSize as long ptr, byval pDIBImage as long ptr) as HRESULT
	IsUsingDefaultSource as function(byval This as IBasicVideo ptr) as HRESULT
	IsUsingDefaultDestination as function(byval This as IBasicVideo ptr) as HRESULT
end type

type IBasicVideo_
	lpVtbl as IBasicVideoVtbl ptr
end type

#define IBasicVideo_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IBasicVideo_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IBasicVideo_Release(This) (This)->lpVtbl->Release(This)
#define IBasicVideo_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IBasicVideo_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IBasicVideo_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IBasicVideo_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IBasicVideo_get_AvgTimePerFrame(This, pAvgTimePerFrame) (This)->lpVtbl->get_AvgTimePerFrame(This, pAvgTimePerFrame)
#define IBasicVideo_get_BitRate(This, pBitRate) (This)->lpVtbl->get_BitRate(This, pBitRate)
#define IBasicVideo_get_BitErrorRate(This, pBitErrorRate) (This)->lpVtbl->get_BitErrorRate(This, pBitErrorRate)
#define IBasicVideo_get_VideoWidth(This, pVideoWidth) (This)->lpVtbl->get_VideoWidth(This, pVideoWidth)
#define IBasicVideo_get_VideoHeight(This, pVideoHeight) (This)->lpVtbl->get_VideoHeight(This, pVideoHeight)
#define IBasicVideo_put_SourceLeft(This, SourceLeft) (This)->lpVtbl->put_SourceLeft(This, SourceLeft)
#define IBasicVideo_get_SourceLeft(This, pSourceLeft) (This)->lpVtbl->get_SourceLeft(This, pSourceLeft)
#define IBasicVideo_put_SourceWidth(This, SourceWidth) (This)->lpVtbl->put_SourceWidth(This, SourceWidth)
#define IBasicVideo_get_SourceWidth(This, pSourceWidth) (This)->lpVtbl->get_SourceWidth(This, pSourceWidth)
#define IBasicVideo_put_SourceTop(This, SourceTop) (This)->lpVtbl->put_SourceTop(This, SourceTop)
#define IBasicVideo_get_SourceTop(This, pSourceTop) (This)->lpVtbl->get_SourceTop(This, pSourceTop)
#define IBasicVideo_put_SourceHeight(This, SourceHeight) (This)->lpVtbl->put_SourceHeight(This, SourceHeight)
#define IBasicVideo_get_SourceHeight(This, pSourceHeight) (This)->lpVtbl->get_SourceHeight(This, pSourceHeight)
#define IBasicVideo_put_DestinationLeft(This, DestinationLeft) (This)->lpVtbl->put_DestinationLeft(This, DestinationLeft)
#define IBasicVideo_get_DestinationLeft(This, pDestinationLeft) (This)->lpVtbl->get_DestinationLeft(This, pDestinationLeft)
#define IBasicVideo_put_DestinationWidth(This, DestinationWidth) (This)->lpVtbl->put_DestinationWidth(This, DestinationWidth)
#define IBasicVideo_get_DestinationWidth(This, pDestinationWidth) (This)->lpVtbl->get_DestinationWidth(This, pDestinationWidth)
#define IBasicVideo_put_DestinationTop(This, DestinationTop) (This)->lpVtbl->put_DestinationTop(This, DestinationTop)
#define IBasicVideo_get_DestinationTop(This, pDestinationTop) (This)->lpVtbl->get_DestinationTop(This, pDestinationTop)
#define IBasicVideo_put_DestinationHeight(This, DestinationHeight) (This)->lpVtbl->put_DestinationHeight(This, DestinationHeight)
#define IBasicVideo_get_DestinationHeight(This, pDestinationHeight) (This)->lpVtbl->get_DestinationHeight(This, pDestinationHeight)
#define IBasicVideo_SetSourcePosition(This, Left, Top, Width, Height) (This)->lpVtbl->SetSourcePosition(This, Left, Top, Width, Height)
#define IBasicVideo_GetSourcePosition(This, pLeft, pTop, pWidth, pHeight) (This)->lpVtbl->GetSourcePosition(This, pLeft, pTop, pWidth, pHeight)
#define IBasicVideo_SetDefaultSourcePosition(This) (This)->lpVtbl->SetDefaultSourcePosition(This)
#define IBasicVideo_SetDestinationPosition(This, Left, Top, Width, Height) (This)->lpVtbl->SetDestinationPosition(This, Left, Top, Width, Height)
#define IBasicVideo_GetDestinationPosition(This, pLeft, pTop, pWidth, pHeight) (This)->lpVtbl->GetDestinationPosition(This, pLeft, pTop, pWidth, pHeight)
#define IBasicVideo_SetDefaultDestinationPosition(This) (This)->lpVtbl->SetDefaultDestinationPosition(This)
#define IBasicVideo_GetVideoSize(This, pWidth, pHeight) (This)->lpVtbl->GetVideoSize(This, pWidth, pHeight)
#define IBasicVideo_GetVideoPaletteEntries(This, StartIndex, Entries, pRetrieved, pPalette) (This)->lpVtbl->GetVideoPaletteEntries(This, StartIndex, Entries, pRetrieved, pPalette)
#define IBasicVideo_GetCurrentImage(This, pBufferSize, pDIBImage) (This)->lpVtbl->GetCurrentImage(This, pBufferSize, pDIBImage)
#define IBasicVideo_IsUsingDefaultSource(This) (This)->lpVtbl->IsUsingDefaultSource(This)
#define IBasicVideo_IsUsingDefaultDestination(This) (This)->lpVtbl->IsUsingDefaultDestination(This)

declare function IBasicVideo_get_AvgTimePerFrame_Proxy(byval This as IBasicVideo ptr, byval pAvgTimePerFrame as REFTIME ptr) as HRESULT
declare sub IBasicVideo_get_AvgTimePerFrame_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicVideo_get_BitRate_Proxy(byval This as IBasicVideo ptr, byval pBitRate as long ptr) as HRESULT
declare sub IBasicVideo_get_BitRate_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicVideo_get_BitErrorRate_Proxy(byval This as IBasicVideo ptr, byval pBitErrorRate as long ptr) as HRESULT
declare sub IBasicVideo_get_BitErrorRate_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicVideo_get_VideoWidth_Proxy(byval This as IBasicVideo ptr, byval pVideoWidth as long ptr) as HRESULT
declare sub IBasicVideo_get_VideoWidth_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicVideo_get_VideoHeight_Proxy(byval This as IBasicVideo ptr, byval pVideoHeight as long ptr) as HRESULT
declare sub IBasicVideo_get_VideoHeight_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicVideo_put_SourceLeft_Proxy(byval This as IBasicVideo ptr, byval SourceLeft as long) as HRESULT
declare sub IBasicVideo_put_SourceLeft_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicVideo_get_SourceLeft_Proxy(byval This as IBasicVideo ptr, byval pSourceLeft as long ptr) as HRESULT
declare sub IBasicVideo_get_SourceLeft_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicVideo_put_SourceWidth_Proxy(byval This as IBasicVideo ptr, byval SourceWidth as long) as HRESULT
declare sub IBasicVideo_put_SourceWidth_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicVideo_get_SourceWidth_Proxy(byval This as IBasicVideo ptr, byval pSourceWidth as long ptr) as HRESULT
declare sub IBasicVideo_get_SourceWidth_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicVideo_put_SourceTop_Proxy(byval This as IBasicVideo ptr, byval SourceTop as long) as HRESULT
declare sub IBasicVideo_put_SourceTop_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicVideo_get_SourceTop_Proxy(byval This as IBasicVideo ptr, byval pSourceTop as long ptr) as HRESULT
declare sub IBasicVideo_get_SourceTop_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicVideo_put_SourceHeight_Proxy(byval This as IBasicVideo ptr, byval SourceHeight as long) as HRESULT
declare sub IBasicVideo_put_SourceHeight_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicVideo_get_SourceHeight_Proxy(byval This as IBasicVideo ptr, byval pSourceHeight as long ptr) as HRESULT
declare sub IBasicVideo_get_SourceHeight_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicVideo_put_DestinationLeft_Proxy(byval This as IBasicVideo ptr, byval DestinationLeft as long) as HRESULT
declare sub IBasicVideo_put_DestinationLeft_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicVideo_get_DestinationLeft_Proxy(byval This as IBasicVideo ptr, byval pDestinationLeft as long ptr) as HRESULT
declare sub IBasicVideo_get_DestinationLeft_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicVideo_put_DestinationWidth_Proxy(byval This as IBasicVideo ptr, byval DestinationWidth as long) as HRESULT
declare sub IBasicVideo_put_DestinationWidth_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicVideo_get_DestinationWidth_Proxy(byval This as IBasicVideo ptr, byval pDestinationWidth as long ptr) as HRESULT
declare sub IBasicVideo_get_DestinationWidth_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicVideo_put_DestinationTop_Proxy(byval This as IBasicVideo ptr, byval DestinationTop as long) as HRESULT
declare sub IBasicVideo_put_DestinationTop_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicVideo_get_DestinationTop_Proxy(byval This as IBasicVideo ptr, byval pDestinationTop as long ptr) as HRESULT
declare sub IBasicVideo_get_DestinationTop_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicVideo_put_DestinationHeight_Proxy(byval This as IBasicVideo ptr, byval DestinationHeight as long) as HRESULT
declare sub IBasicVideo_put_DestinationHeight_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicVideo_get_DestinationHeight_Proxy(byval This as IBasicVideo ptr, byval pDestinationHeight as long ptr) as HRESULT
declare sub IBasicVideo_get_DestinationHeight_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicVideo_SetSourcePosition_Proxy(byval This as IBasicVideo ptr, byval Left as long, byval Top as long, byval Width as long, byval Height as long) as HRESULT
declare sub IBasicVideo_SetSourcePosition_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicVideo_GetSourcePosition_Proxy(byval This as IBasicVideo ptr, byval pLeft as long ptr, byval pTop as long ptr, byval pWidth as long ptr, byval pHeight as long ptr) as HRESULT
declare sub IBasicVideo_GetSourcePosition_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicVideo_SetDefaultSourcePosition_Proxy(byval This as IBasicVideo ptr) as HRESULT
declare sub IBasicVideo_SetDefaultSourcePosition_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicVideo_SetDestinationPosition_Proxy(byval This as IBasicVideo ptr, byval Left as long, byval Top as long, byval Width as long, byval Height as long) as HRESULT
declare sub IBasicVideo_SetDestinationPosition_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicVideo_GetDestinationPosition_Proxy(byval This as IBasicVideo ptr, byval pLeft as long ptr, byval pTop as long ptr, byval pWidth as long ptr, byval pHeight as long ptr) as HRESULT
declare sub IBasicVideo_GetDestinationPosition_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicVideo_SetDefaultDestinationPosition_Proxy(byval This as IBasicVideo ptr) as HRESULT
declare sub IBasicVideo_SetDefaultDestinationPosition_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicVideo_GetVideoSize_Proxy(byval This as IBasicVideo ptr, byval pWidth as long ptr, byval pHeight as long ptr) as HRESULT
declare sub IBasicVideo_GetVideoSize_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicVideo_GetVideoPaletteEntries_Proxy(byval This as IBasicVideo ptr, byval StartIndex as long, byval Entries as long, byval pRetrieved as long ptr, byval pPalette as long ptr) as HRESULT
declare sub IBasicVideo_GetVideoPaletteEntries_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicVideo_GetCurrentImage_Proxy(byval This as IBasicVideo ptr, byval pBufferSize as long ptr, byval pDIBImage as long ptr) as HRESULT
declare sub IBasicVideo_GetCurrentImage_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicVideo_IsUsingDefaultSource_Proxy(byval This as IBasicVideo ptr) as HRESULT
declare sub IBasicVideo_IsUsingDefaultSource_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicVideo_IsUsingDefaultDestination_Proxy(byval This as IBasicVideo ptr) as HRESULT
declare sub IBasicVideo_IsUsingDefaultDestination_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IBasicVideo2_INTERFACE_DEFINED__
extern IID_IBasicVideo2 as const GUID
type IBasicVideo2 as IBasicVideo2_

type IBasicVideo2Vtbl
	QueryInterface as function(byval This as IBasicVideo2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IBasicVideo2 ptr) as ULONG
	Release as function(byval This as IBasicVideo2 ptr) as ULONG
	GetTypeInfoCount as function(byval This as IBasicVideo2 ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IBasicVideo2 ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IBasicVideo2 ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IBasicVideo2 ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_AvgTimePerFrame as function(byval This as IBasicVideo2 ptr, byval pAvgTimePerFrame as REFTIME ptr) as HRESULT
	get_BitRate as function(byval This as IBasicVideo2 ptr, byval pBitRate as long ptr) as HRESULT
	get_BitErrorRate as function(byval This as IBasicVideo2 ptr, byval pBitErrorRate as long ptr) as HRESULT
	get_VideoWidth as function(byval This as IBasicVideo2 ptr, byval pVideoWidth as long ptr) as HRESULT
	get_VideoHeight as function(byval This as IBasicVideo2 ptr, byval pVideoHeight as long ptr) as HRESULT
	put_SourceLeft as function(byval This as IBasicVideo2 ptr, byval SourceLeft as long) as HRESULT
	get_SourceLeft as function(byval This as IBasicVideo2 ptr, byval pSourceLeft as long ptr) as HRESULT
	put_SourceWidth as function(byval This as IBasicVideo2 ptr, byval SourceWidth as long) as HRESULT
	get_SourceWidth as function(byval This as IBasicVideo2 ptr, byval pSourceWidth as long ptr) as HRESULT
	put_SourceTop as function(byval This as IBasicVideo2 ptr, byval SourceTop as long) as HRESULT
	get_SourceTop as function(byval This as IBasicVideo2 ptr, byval pSourceTop as long ptr) as HRESULT
	put_SourceHeight as function(byval This as IBasicVideo2 ptr, byval SourceHeight as long) as HRESULT
	get_SourceHeight as function(byval This as IBasicVideo2 ptr, byval pSourceHeight as long ptr) as HRESULT
	put_DestinationLeft as function(byval This as IBasicVideo2 ptr, byval DestinationLeft as long) as HRESULT
	get_DestinationLeft as function(byval This as IBasicVideo2 ptr, byval pDestinationLeft as long ptr) as HRESULT
	put_DestinationWidth as function(byval This as IBasicVideo2 ptr, byval DestinationWidth as long) as HRESULT
	get_DestinationWidth as function(byval This as IBasicVideo2 ptr, byval pDestinationWidth as long ptr) as HRESULT
	put_DestinationTop as function(byval This as IBasicVideo2 ptr, byval DestinationTop as long) as HRESULT
	get_DestinationTop as function(byval This as IBasicVideo2 ptr, byval pDestinationTop as long ptr) as HRESULT
	put_DestinationHeight as function(byval This as IBasicVideo2 ptr, byval DestinationHeight as long) as HRESULT
	get_DestinationHeight as function(byval This as IBasicVideo2 ptr, byval pDestinationHeight as long ptr) as HRESULT
	SetSourcePosition as function(byval This as IBasicVideo2 ptr, byval Left as long, byval Top as long, byval Width as long, byval Height as long) as HRESULT
	GetSourcePosition as function(byval This as IBasicVideo2 ptr, byval pLeft as long ptr, byval pTop as long ptr, byval pWidth as long ptr, byval pHeight as long ptr) as HRESULT
	SetDefaultSourcePosition as function(byval This as IBasicVideo2 ptr) as HRESULT
	SetDestinationPosition as function(byval This as IBasicVideo2 ptr, byval Left as long, byval Top as long, byval Width as long, byval Height as long) as HRESULT
	GetDestinationPosition as function(byval This as IBasicVideo2 ptr, byval pLeft as long ptr, byval pTop as long ptr, byval pWidth as long ptr, byval pHeight as long ptr) as HRESULT
	SetDefaultDestinationPosition as function(byval This as IBasicVideo2 ptr) as HRESULT
	GetVideoSize as function(byval This as IBasicVideo2 ptr, byval pWidth as long ptr, byval pHeight as long ptr) as HRESULT
	GetVideoPaletteEntries as function(byval This as IBasicVideo2 ptr, byval StartIndex as long, byval Entries as long, byval pRetrieved as long ptr, byval pPalette as long ptr) as HRESULT
	GetCurrentImage as function(byval This as IBasicVideo2 ptr, byval pBufferSize as long ptr, byval pDIBImage as long ptr) as HRESULT
	IsUsingDefaultSource as function(byval This as IBasicVideo2 ptr) as HRESULT
	IsUsingDefaultDestination as function(byval This as IBasicVideo2 ptr) as HRESULT
	GetPreferredAspectRatio as function(byval This as IBasicVideo2 ptr, byval plAspectX as long ptr, byval plAspectY as long ptr) as HRESULT
end type

type IBasicVideo2_
	lpVtbl as IBasicVideo2Vtbl ptr
end type

#define IBasicVideo2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IBasicVideo2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IBasicVideo2_Release(This) (This)->lpVtbl->Release(This)
#define IBasicVideo2_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IBasicVideo2_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IBasicVideo2_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IBasicVideo2_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IBasicVideo2_get_AvgTimePerFrame(This, pAvgTimePerFrame) (This)->lpVtbl->get_AvgTimePerFrame(This, pAvgTimePerFrame)
#define IBasicVideo2_get_BitRate(This, pBitRate) (This)->lpVtbl->get_BitRate(This, pBitRate)
#define IBasicVideo2_get_BitErrorRate(This, pBitErrorRate) (This)->lpVtbl->get_BitErrorRate(This, pBitErrorRate)
#define IBasicVideo2_get_VideoWidth(This, pVideoWidth) (This)->lpVtbl->get_VideoWidth(This, pVideoWidth)
#define IBasicVideo2_get_VideoHeight(This, pVideoHeight) (This)->lpVtbl->get_VideoHeight(This, pVideoHeight)
#define IBasicVideo2_put_SourceLeft(This, SourceLeft) (This)->lpVtbl->put_SourceLeft(This, SourceLeft)
#define IBasicVideo2_get_SourceLeft(This, pSourceLeft) (This)->lpVtbl->get_SourceLeft(This, pSourceLeft)
#define IBasicVideo2_put_SourceWidth(This, SourceWidth) (This)->lpVtbl->put_SourceWidth(This, SourceWidth)
#define IBasicVideo2_get_SourceWidth(This, pSourceWidth) (This)->lpVtbl->get_SourceWidth(This, pSourceWidth)
#define IBasicVideo2_put_SourceTop(This, SourceTop) (This)->lpVtbl->put_SourceTop(This, SourceTop)
#define IBasicVideo2_get_SourceTop(This, pSourceTop) (This)->lpVtbl->get_SourceTop(This, pSourceTop)
#define IBasicVideo2_put_SourceHeight(This, SourceHeight) (This)->lpVtbl->put_SourceHeight(This, SourceHeight)
#define IBasicVideo2_get_SourceHeight(This, pSourceHeight) (This)->lpVtbl->get_SourceHeight(This, pSourceHeight)
#define IBasicVideo2_put_DestinationLeft(This, DestinationLeft) (This)->lpVtbl->put_DestinationLeft(This, DestinationLeft)
#define IBasicVideo2_get_DestinationLeft(This, pDestinationLeft) (This)->lpVtbl->get_DestinationLeft(This, pDestinationLeft)
#define IBasicVideo2_put_DestinationWidth(This, DestinationWidth) (This)->lpVtbl->put_DestinationWidth(This, DestinationWidth)
#define IBasicVideo2_get_DestinationWidth(This, pDestinationWidth) (This)->lpVtbl->get_DestinationWidth(This, pDestinationWidth)
#define IBasicVideo2_put_DestinationTop(This, DestinationTop) (This)->lpVtbl->put_DestinationTop(This, DestinationTop)
#define IBasicVideo2_get_DestinationTop(This, pDestinationTop) (This)->lpVtbl->get_DestinationTop(This, pDestinationTop)
#define IBasicVideo2_put_DestinationHeight(This, DestinationHeight) (This)->lpVtbl->put_DestinationHeight(This, DestinationHeight)
#define IBasicVideo2_get_DestinationHeight(This, pDestinationHeight) (This)->lpVtbl->get_DestinationHeight(This, pDestinationHeight)
#define IBasicVideo2_SetSourcePosition(This, Left, Top, Width, Height) (This)->lpVtbl->SetSourcePosition(This, Left, Top, Width, Height)
#define IBasicVideo2_GetSourcePosition(This, pLeft, pTop, pWidth, pHeight) (This)->lpVtbl->GetSourcePosition(This, pLeft, pTop, pWidth, pHeight)
#define IBasicVideo2_SetDefaultSourcePosition(This) (This)->lpVtbl->SetDefaultSourcePosition(This)
#define IBasicVideo2_SetDestinationPosition(This, Left, Top, Width, Height) (This)->lpVtbl->SetDestinationPosition(This, Left, Top, Width, Height)
#define IBasicVideo2_GetDestinationPosition(This, pLeft, pTop, pWidth, pHeight) (This)->lpVtbl->GetDestinationPosition(This, pLeft, pTop, pWidth, pHeight)
#define IBasicVideo2_SetDefaultDestinationPosition(This) (This)->lpVtbl->SetDefaultDestinationPosition(This)
#define IBasicVideo2_GetVideoSize(This, pWidth, pHeight) (This)->lpVtbl->GetVideoSize(This, pWidth, pHeight)
#define IBasicVideo2_GetVideoPaletteEntries(This, StartIndex, Entries, pRetrieved, pPalette) (This)->lpVtbl->GetVideoPaletteEntries(This, StartIndex, Entries, pRetrieved, pPalette)
#define IBasicVideo2_GetCurrentImage(This, pBufferSize, pDIBImage) (This)->lpVtbl->GetCurrentImage(This, pBufferSize, pDIBImage)
#define IBasicVideo2_IsUsingDefaultSource(This) (This)->lpVtbl->IsUsingDefaultSource(This)
#define IBasicVideo2_IsUsingDefaultDestination(This) (This)->lpVtbl->IsUsingDefaultDestination(This)
#define IBasicVideo2_GetPreferredAspectRatio(This, plAspectX, plAspectY) (This)->lpVtbl->GetPreferredAspectRatio(This, plAspectX, plAspectY)
declare function IBasicVideo2_GetPreferredAspectRatio_Proxy(byval This as IBasicVideo2 ptr, byval plAspectX as long ptr, byval plAspectY as long ptr) as HRESULT
declare sub IBasicVideo2_GetPreferredAspectRatio_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IDeferredCommand_INTERFACE_DEFINED__
extern IID_IDeferredCommand as const GUID
type IDeferredCommand as IDeferredCommand_

type IDeferredCommandVtbl
	QueryInterface as function(byval This as IDeferredCommand ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDeferredCommand ptr) as ULONG
	Release as function(byval This as IDeferredCommand ptr) as ULONG
	Cancel as function(byval This as IDeferredCommand ptr) as HRESULT
	Confidence as function(byval This as IDeferredCommand ptr, byval pConfidence as LONG ptr) as HRESULT
	Postpone as function(byval This as IDeferredCommand ptr, byval newtime as REFTIME) as HRESULT
	GetHResult as function(byval This as IDeferredCommand ptr, byval phrResult as HRESULT ptr) as HRESULT
end type

type IDeferredCommand_
	lpVtbl as IDeferredCommandVtbl ptr
end type

#define IDeferredCommand_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IDeferredCommand_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IDeferredCommand_Release(This) (This)->lpVtbl->Release(This)
#define IDeferredCommand_Cancel(This) (This)->lpVtbl->Cancel(This)
#define IDeferredCommand_Confidence(This, pConfidence) (This)->lpVtbl->Confidence(This, pConfidence)
#define IDeferredCommand_Postpone(This, newtime) (This)->lpVtbl->Postpone(This, newtime)
#define IDeferredCommand_GetHResult(This, phrResult) (This)->lpVtbl->GetHResult(This, phrResult)

declare function IDeferredCommand_Cancel_Proxy(byval This as IDeferredCommand ptr) as HRESULT
declare sub IDeferredCommand_Cancel_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDeferredCommand_Confidence_Proxy(byval This as IDeferredCommand ptr, byval pConfidence as LONG ptr) as HRESULT
declare sub IDeferredCommand_Confidence_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDeferredCommand_Postpone_Proxy(byval This as IDeferredCommand ptr, byval newtime as REFTIME) as HRESULT
declare sub IDeferredCommand_Postpone_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDeferredCommand_GetHResult_Proxy(byval This as IDeferredCommand ptr, byval phrResult as HRESULT ptr) as HRESULT
declare sub IDeferredCommand_GetHResult_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IQueueCommand_INTERFACE_DEFINED__
extern IID_IQueueCommand as const GUID
type IQueueCommand as IQueueCommand_

type IQueueCommandVtbl
	QueryInterface as function(byval This as IQueueCommand ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IQueueCommand ptr) as ULONG
	Release as function(byval This as IQueueCommand ptr) as ULONG
	InvokeAtStreamTime as function(byval This as IQueueCommand ptr, byval pCmd as IDeferredCommand ptr ptr, byval time as REFTIME, byval iid as GUID ptr, byval dispidMethod as long, byval wFlags as short, byval cArgs as long, byval pDispParams as VARIANT ptr, byval pvarResult as VARIANT ptr, byval puArgErr as short ptr) as HRESULT
	InvokeAtPresentationTime as function(byval This as IQueueCommand ptr, byval pCmd as IDeferredCommand ptr ptr, byval time as REFTIME, byval iid as GUID ptr, byval dispidMethod as long, byval wFlags as short, byval cArgs as long, byval pDispParams as VARIANT ptr, byval pvarResult as VARIANT ptr, byval puArgErr as short ptr) as HRESULT
end type

type IQueueCommand_
	lpVtbl as IQueueCommandVtbl ptr
end type

#define IQueueCommand_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IQueueCommand_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IQueueCommand_Release(This) (This)->lpVtbl->Release(This)
#define IQueueCommand_InvokeAtStreamTime(This, pCmd, time, iid, dispidMethod, wFlags, cArgs, pDispParams, pvarResult, puArgErr) (This)->lpVtbl->InvokeAtStreamTime(This, pCmd, time, iid, dispidMethod, wFlags, cArgs, pDispParams, pvarResult, puArgErr)
#define IQueueCommand_InvokeAtPresentationTime(This, pCmd, time, iid, dispidMethod, wFlags, cArgs, pDispParams, pvarResult, puArgErr) (This)->lpVtbl->InvokeAtPresentationTime(This, pCmd, time, iid, dispidMethod, wFlags, cArgs, pDispParams, pvarResult, puArgErr)

declare function IQueueCommand_InvokeAtStreamTime_Proxy(byval This as IQueueCommand ptr, byval pCmd as IDeferredCommand ptr ptr, byval time as REFTIME, byval iid as GUID ptr, byval dispidMethod as long, byval wFlags as short, byval cArgs as long, byval pDispParams as VARIANT ptr, byval pvarResult as VARIANT ptr, byval puArgErr as short ptr) as HRESULT
declare sub IQueueCommand_InvokeAtStreamTime_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IQueueCommand_InvokeAtPresentationTime_Proxy(byval This as IQueueCommand ptr, byval pCmd as IDeferredCommand ptr ptr, byval time as REFTIME, byval iid as GUID ptr, byval dispidMethod as long, byval wFlags as short, byval cArgs as long, byval pDispParams as VARIANT ptr, byval pvarResult as VARIANT ptr, byval puArgErr as short ptr) as HRESULT
declare sub IQueueCommand_InvokeAtPresentationTime_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
extern CLSID_FilgraphManager as const GUID
#define __IFilterInfo_INTERFACE_DEFINED__
extern IID_IFilterInfo as const GUID
type IFilterInfo as IFilterInfo_

type IFilterInfoVtbl
	QueryInterface as function(byval This as IFilterInfo ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IFilterInfo ptr) as ULONG
	Release as function(byval This as IFilterInfo ptr) as ULONG
	GetTypeInfoCount as function(byval This as IFilterInfo ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IFilterInfo ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IFilterInfo ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IFilterInfo ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	FindPin as function(byval This as IFilterInfo ptr, byval strPinID as BSTR, byval ppUnk as IDispatch ptr ptr) as HRESULT
	get_Name as function(byval This as IFilterInfo ptr, byval strName as BSTR ptr) as HRESULT
	get_VendorInfo as function(byval This as IFilterInfo ptr, byval strVendorInfo as BSTR ptr) as HRESULT
	get_Filter as function(byval This as IFilterInfo ptr, byval ppUnk as IUnknown ptr ptr) as HRESULT
	get_Pins as function(byval This as IFilterInfo ptr, byval ppUnk as IDispatch ptr ptr) as HRESULT
	get_IsFileSource as function(byval This as IFilterInfo ptr, byval pbIsSource as LONG ptr) as HRESULT
	get_Filename as function(byval This as IFilterInfo ptr, byval pstrFilename as BSTR ptr) as HRESULT
	put_Filename as function(byval This as IFilterInfo ptr, byval strFilename as BSTR) as HRESULT
end type

type IFilterInfo_
	lpVtbl as IFilterInfoVtbl ptr
end type

#define IFilterInfo_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IFilterInfo_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IFilterInfo_Release(This) (This)->lpVtbl->Release(This)
#define IFilterInfo_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IFilterInfo_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IFilterInfo_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IFilterInfo_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IFilterInfo_FindPin(This, strPinID, ppUnk) (This)->lpVtbl->FindPin(This, strPinID, ppUnk)
#define IFilterInfo_get_Name(This, strName) (This)->lpVtbl->get_Name(This, strName)
#define IFilterInfo_get_VendorInfo(This, strVendorInfo) (This)->lpVtbl->get_VendorInfo(This, strVendorInfo)
#define IFilterInfo_get_Filter(This, ppUnk) (This)->lpVtbl->get_Filter(This, ppUnk)
#define IFilterInfo_get_Pins(This, ppUnk) (This)->lpVtbl->get_Pins(This, ppUnk)
#define IFilterInfo_get_IsFileSource(This, pbIsSource) (This)->lpVtbl->get_IsFileSource(This, pbIsSource)
#define IFilterInfo_get_Filename(This, pstrFilename) (This)->lpVtbl->get_Filename(This, pstrFilename)
#define IFilterInfo_put_Filename(This, strFilename) (This)->lpVtbl->put_Filename(This, strFilename)

declare function IFilterInfo_FindPin_Proxy(byval This as IFilterInfo ptr, byval strPinID as BSTR, byval ppUnk as IDispatch ptr ptr) as HRESULT
declare sub IFilterInfo_FindPin_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFilterInfo_get_Name_Proxy(byval This as IFilterInfo ptr, byval strName as BSTR ptr) as HRESULT
declare sub IFilterInfo_get_Name_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFilterInfo_get_VendorInfo_Proxy(byval This as IFilterInfo ptr, byval strVendorInfo as BSTR ptr) as HRESULT
declare sub IFilterInfo_get_VendorInfo_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFilterInfo_get_Filter_Proxy(byval This as IFilterInfo ptr, byval ppUnk as IUnknown ptr ptr) as HRESULT
declare sub IFilterInfo_get_Filter_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFilterInfo_get_Pins_Proxy(byval This as IFilterInfo ptr, byval ppUnk as IDispatch ptr ptr) as HRESULT
declare sub IFilterInfo_get_Pins_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFilterInfo_get_IsFileSource_Proxy(byval This as IFilterInfo ptr, byval pbIsSource as LONG ptr) as HRESULT
declare sub IFilterInfo_get_IsFileSource_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFilterInfo_get_Filename_Proxy(byval This as IFilterInfo ptr, byval pstrFilename as BSTR ptr) as HRESULT
declare sub IFilterInfo_get_Filename_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFilterInfo_put_Filename_Proxy(byval This as IFilterInfo ptr, byval strFilename as BSTR) as HRESULT
declare sub IFilterInfo_put_Filename_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IRegFilterInfo_INTERFACE_DEFINED__
extern IID_IRegFilterInfo as const GUID
type IRegFilterInfo as IRegFilterInfo_

type IRegFilterInfoVtbl
	QueryInterface as function(byval This as IRegFilterInfo ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IRegFilterInfo ptr) as ULONG
	Release as function(byval This as IRegFilterInfo ptr) as ULONG
	GetTypeInfoCount as function(byval This as IRegFilterInfo ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IRegFilterInfo ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IRegFilterInfo ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IRegFilterInfo ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_Name as function(byval This as IRegFilterInfo ptr, byval strName as BSTR ptr) as HRESULT
	Filter as function(byval This as IRegFilterInfo ptr, byval ppUnk as IDispatch ptr ptr) as HRESULT
end type

type IRegFilterInfo_
	lpVtbl as IRegFilterInfoVtbl ptr
end type

#define IRegFilterInfo_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IRegFilterInfo_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IRegFilterInfo_Release(This) (This)->lpVtbl->Release(This)
#define IRegFilterInfo_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IRegFilterInfo_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IRegFilterInfo_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IRegFilterInfo_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IRegFilterInfo_get_Name(This, strName) (This)->lpVtbl->get_Name(This, strName)
#define IRegFilterInfo_Filter(This, ppUnk) (This)->lpVtbl->Filter(This, ppUnk)

declare function IRegFilterInfo_get_Name_Proxy(byval This as IRegFilterInfo ptr, byval strName as BSTR ptr) as HRESULT
declare sub IRegFilterInfo_get_Name_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IRegFilterInfo_Filter_Proxy(byval This as IRegFilterInfo ptr, byval ppUnk as IDispatch ptr ptr) as HRESULT
declare sub IRegFilterInfo_Filter_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IMediaTypeInfo_INTERFACE_DEFINED__
extern IID_IMediaTypeInfo as const GUID
type IMediaTypeInfo as IMediaTypeInfo_

type IMediaTypeInfoVtbl
	QueryInterface as function(byval This as IMediaTypeInfo ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IMediaTypeInfo ptr) as ULONG
	Release as function(byval This as IMediaTypeInfo ptr) as ULONG
	GetTypeInfoCount as function(byval This as IMediaTypeInfo ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IMediaTypeInfo ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IMediaTypeInfo ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IMediaTypeInfo ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_Type as function(byval This as IMediaTypeInfo ptr, byval strType as BSTR ptr) as HRESULT
	get_Subtype as function(byval This as IMediaTypeInfo ptr, byval strType as BSTR ptr) as HRESULT
end type

type IMediaTypeInfo_
	lpVtbl as IMediaTypeInfoVtbl ptr
end type

#define IMediaTypeInfo_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IMediaTypeInfo_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IMediaTypeInfo_Release(This) (This)->lpVtbl->Release(This)
#define IMediaTypeInfo_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IMediaTypeInfo_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IMediaTypeInfo_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IMediaTypeInfo_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IMediaTypeInfo_get_Type(This, strType) (This)->lpVtbl->get_Type(This, strType)
#define IMediaTypeInfo_get_Subtype(This, strType) (This)->lpVtbl->get_Subtype(This, strType)

declare function IMediaTypeInfo_get_Type_Proxy(byval This as IMediaTypeInfo ptr, byval strType as BSTR ptr) as HRESULT
declare sub IMediaTypeInfo_get_Type_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaTypeInfo_get_Subtype_Proxy(byval This as IMediaTypeInfo ptr, byval strType as BSTR ptr) as HRESULT
declare sub IMediaTypeInfo_get_Subtype_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IPinInfo_INTERFACE_DEFINED__
extern IID_IPinInfo as const GUID
type IPinInfo as IPinInfo_

type IPinInfoVtbl
	QueryInterface as function(byval This as IPinInfo ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPinInfo ptr) as ULONG
	Release as function(byval This as IPinInfo ptr) as ULONG
	GetTypeInfoCount as function(byval This as IPinInfo ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IPinInfo ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IPinInfo ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IPinInfo ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_Pin as function(byval This as IPinInfo ptr, byval ppUnk as IUnknown ptr ptr) as HRESULT
	get_ConnectedTo as function(byval This as IPinInfo ptr, byval ppUnk as IDispatch ptr ptr) as HRESULT
	get_ConnectionMediaType as function(byval This as IPinInfo ptr, byval ppUnk as IDispatch ptr ptr) as HRESULT
	get_FilterInfo as function(byval This as IPinInfo ptr, byval ppUnk as IDispatch ptr ptr) as HRESULT
	get_Name as function(byval This as IPinInfo ptr, byval ppUnk as BSTR ptr) as HRESULT
	get_Direction as function(byval This as IPinInfo ptr, byval ppDirection as LONG ptr) as HRESULT
	get_PinID as function(byval This as IPinInfo ptr, byval strPinID as BSTR ptr) as HRESULT
	get_MediaTypes as function(byval This as IPinInfo ptr, byval ppUnk as IDispatch ptr ptr) as HRESULT
	Connect as function(byval This as IPinInfo ptr, byval pPin as IUnknown ptr) as HRESULT
	ConnectDirect as function(byval This as IPinInfo ptr, byval pPin as IUnknown ptr) as HRESULT
	ConnectWithType as function(byval This as IPinInfo ptr, byval pPin as IUnknown ptr, byval pMediaType as IDispatch ptr) as HRESULT
	Disconnect as function(byval This as IPinInfo ptr) as HRESULT
	Render as function(byval This as IPinInfo ptr) as HRESULT
end type

type IPinInfo_
	lpVtbl as IPinInfoVtbl ptr
end type

#define IPinInfo_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPinInfo_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPinInfo_Release(This) (This)->lpVtbl->Release(This)
#define IPinInfo_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IPinInfo_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IPinInfo_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IPinInfo_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IPinInfo_get_Pin(This, ppUnk) (This)->lpVtbl->get_Pin(This, ppUnk)
#define IPinInfo_get_ConnectedTo(This, ppUnk) (This)->lpVtbl->get_ConnectedTo(This, ppUnk)
#define IPinInfo_get_ConnectionMediaType(This, ppUnk) (This)->lpVtbl->get_ConnectionMediaType(This, ppUnk)
#define IPinInfo_get_FilterInfo(This, ppUnk) (This)->lpVtbl->get_FilterInfo(This, ppUnk)
#define IPinInfo_get_Name(This, ppUnk) (This)->lpVtbl->get_Name(This, ppUnk)
#define IPinInfo_get_Direction(This, ppDirection) (This)->lpVtbl->get_Direction(This, ppDirection)
#define IPinInfo_get_PinID(This, strPinID) (This)->lpVtbl->get_PinID(This, strPinID)
#define IPinInfo_get_MediaTypes(This, ppUnk) (This)->lpVtbl->get_MediaTypes(This, ppUnk)
#define IPinInfo_Connect(This, pPin) (This)->lpVtbl->Connect(This, pPin)
#define IPinInfo_ConnectDirect(This, pPin) (This)->lpVtbl->ConnectDirect(This, pPin)
#define IPinInfo_ConnectWithType(This, pPin, pMediaType) (This)->lpVtbl->ConnectWithType(This, pPin, pMediaType)
#define IPinInfo_Disconnect(This) (This)->lpVtbl->Disconnect(This)
#define IPinInfo_Render(This) (This)->lpVtbl->Render(This)

declare function IPinInfo_get_Pin_Proxy(byval This as IPinInfo ptr, byval ppUnk as IUnknown ptr ptr) as HRESULT
declare sub IPinInfo_get_Pin_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPinInfo_get_ConnectedTo_Proxy(byval This as IPinInfo ptr, byval ppUnk as IDispatch ptr ptr) as HRESULT
declare sub IPinInfo_get_ConnectedTo_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPinInfo_get_ConnectionMediaType_Proxy(byval This as IPinInfo ptr, byval ppUnk as IDispatch ptr ptr) as HRESULT
declare sub IPinInfo_get_ConnectionMediaType_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPinInfo_get_FilterInfo_Proxy(byval This as IPinInfo ptr, byval ppUnk as IDispatch ptr ptr) as HRESULT
declare sub IPinInfo_get_FilterInfo_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPinInfo_get_Name_Proxy(byval This as IPinInfo ptr, byval ppUnk as BSTR ptr) as HRESULT
declare sub IPinInfo_get_Name_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPinInfo_get_Direction_Proxy(byval This as IPinInfo ptr, byval ppDirection as LONG ptr) as HRESULT
declare sub IPinInfo_get_Direction_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPinInfo_get_PinID_Proxy(byval This as IPinInfo ptr, byval strPinID as BSTR ptr) as HRESULT
declare sub IPinInfo_get_PinID_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPinInfo_get_MediaTypes_Proxy(byval This as IPinInfo ptr, byval ppUnk as IDispatch ptr ptr) as HRESULT
declare sub IPinInfo_get_MediaTypes_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPinInfo_Connect_Proxy(byval This as IPinInfo ptr, byval pPin as IUnknown ptr) as HRESULT
declare sub IPinInfo_Connect_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPinInfo_ConnectDirect_Proxy(byval This as IPinInfo ptr, byval pPin as IUnknown ptr) as HRESULT
declare sub IPinInfo_ConnectDirect_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPinInfo_ConnectWithType_Proxy(byval This as IPinInfo ptr, byval pPin as IUnknown ptr, byval pMediaType as IDispatch ptr) as HRESULT
declare sub IPinInfo_ConnectWithType_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPinInfo_Disconnect_Proxy(byval This as IPinInfo ptr) as HRESULT
declare sub IPinInfo_Disconnect_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPinInfo_Render_Proxy(byval This as IPinInfo ptr) as HRESULT
declare sub IPinInfo_Render_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IAMStats_INTERFACE_DEFINED__
extern IID_IAMStats as const GUID
type IAMStats as IAMStats_

type IAMStatsVtbl
	QueryInterface as function(byval This as IAMStats ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMStats ptr) as ULONG
	Release as function(byval This as IAMStats ptr) as ULONG
	GetTypeInfoCount as function(byval This as IAMStats ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IAMStats ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IAMStats ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IAMStats ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	Reset as function(byval This as IAMStats ptr) as HRESULT
	get_Count as function(byval This as IAMStats ptr, byval plCount as LONG ptr) as HRESULT
	GetValueByIndex as function(byval This as IAMStats ptr, byval lIndex as long, byval szName as BSTR ptr, byval lCount as long ptr, byval dLast as double ptr, byval dAverage as double ptr, byval dStdDev as double ptr, byval dMin as double ptr, byval dMax as double ptr) as HRESULT
	GetValueByName as function(byval This as IAMStats ptr, byval szName as BSTR, byval lIndex as long ptr, byval lCount as long ptr, byval dLast as double ptr, byval dAverage as double ptr, byval dStdDev as double ptr, byval dMin as double ptr, byval dMax as double ptr) as HRESULT
	GetIndex as function(byval This as IAMStats ptr, byval szName as BSTR, byval lCreate as long, byval plIndex as long ptr) as HRESULT
	AddValue as function(byval This as IAMStats ptr, byval lIndex as long, byval dValue as double) as HRESULT
end type

type IAMStats_
	lpVtbl as IAMStatsVtbl ptr
end type

#define IAMStats_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IAMStats_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IAMStats_Release(This) (This)->lpVtbl->Release(This)
#define IAMStats_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IAMStats_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IAMStats_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IAMStats_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IAMStats_Reset(This) (This)->lpVtbl->Reset(This)
#define IAMStats_get_Count(This, plCount) (This)->lpVtbl->get_Count(This, plCount)
#define IAMStats_GetValueByIndex(This, lIndex, szName, lCount, dLast, dAverage, dStdDev, dMin, dMax) (This)->lpVtbl->GetValueByIndex(This, lIndex, szName, lCount, dLast, dAverage, dStdDev, dMin, dMax)
#define IAMStats_GetValueByName(This, szName, lIndex, lCount, dLast, dAverage, dStdDev, dMin, dMax) (This)->lpVtbl->GetValueByName(This, szName, lIndex, lCount, dLast, dAverage, dStdDev, dMin, dMax)
#define IAMStats_GetIndex(This, szName, lCreate, plIndex) (This)->lpVtbl->GetIndex(This, szName, lCreate, plIndex)
#define IAMStats_AddValue(This, lIndex, dValue) (This)->lpVtbl->AddValue(This, lIndex, dValue)

declare function IAMStats_Reset_Proxy(byval This as IAMStats ptr) as HRESULT
declare sub IAMStats_Reset_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMStats_get_Count_Proxy(byval This as IAMStats ptr, byval plCount as LONG ptr) as HRESULT
declare sub IAMStats_get_Count_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMStats_GetValueByIndex_Proxy(byval This as IAMStats ptr, byval lIndex as long, byval szName as BSTR ptr, byval lCount as long ptr, byval dLast as double ptr, byval dAverage as double ptr, byval dStdDev as double ptr, byval dMin as double ptr, byval dMax as double ptr) as HRESULT
declare sub IAMStats_GetValueByIndex_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMStats_GetValueByName_Proxy(byval This as IAMStats ptr, byval szName as BSTR, byval lIndex as long ptr, byval lCount as long ptr, byval dLast as double ptr, byval dAverage as double ptr, byval dStdDev as double ptr, byval dMin as double ptr, byval dMax as double ptr) as HRESULT
declare sub IAMStats_GetValueByName_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMStats_GetIndex_Proxy(byval This as IAMStats ptr, byval szName as BSTR, byval lCreate as long, byval plIndex as long ptr) as HRESULT
declare sub IAMStats_GetIndex_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMStats_AddValue_Proxy(byval This as IAMStats ptr, byval lIndex as long, byval dValue as double) as HRESULT
declare sub IAMStats_AddValue_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

end extern

#include once "ole-common.bi"
