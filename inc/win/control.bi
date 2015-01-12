#pragma once

#include once "rpc.bi"
#include once "rpcndr.bi"
#include once "windows.bi"
#include once "ole2.bi"
#include once "oaidl.bi"

extern "Windows"

type IMediaControl as IMediaControl_
type IAMCollection as IAMCollection_
type IMediaEvent as IMediaEvent_
type IMediaEventEx as IMediaEventEx_
type IMediaPosition as IMediaPosition_
type IBasicAudio as IBasicAudio_
type IVideoWindow as IVideoWindow_
type IBasicVideo as IBasicVideo_
type IBasicVideo2 as IBasicVideo2_
type IDeferredCommand as IDeferredCommand_
type IQueueCommand as IQueueCommand_
type IFilterInfo as IFilterInfo_
type IRegFilterInfo as IRegFilterInfo_
type IMediaTypeInfo as IMediaTypeInfo_
type IPinInfo as IPinInfo_
type IAMStats as IAMStats_

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

declare function IAMCollection_get_Count_Proxy(byval This as IAMCollection ptr, byval plCount as LONG ptr) as HRESULT
declare sub IAMCollection_get_Count_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMCollection_Item_Proxy(byval This as IAMCollection ptr, byval lItem as long, byval ppUnk as IUnknown ptr ptr) as HRESULT
declare sub IAMCollection_Item_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMCollection_get__NewEnum_Proxy(byval This as IAMCollection ptr, byval ppUnk as IUnknown ptr ptr) as HRESULT
declare sub IAMCollection_get__NewEnum_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IMediaEvent_INTERFACE_DEFINED__

extern IID_IMediaEvent as const GUID

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

declare function IMediaEventEx_SetNotifyWindow_Proxy(byval This as IMediaEventEx ptr, byval hwnd as OAHWND, byval lMsg as long, byval lInstanceData as LONG_PTR) as HRESULT
declare sub IMediaEventEx_SetNotifyWindow_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaEventEx_SetNotifyFlags_Proxy(byval This as IMediaEventEx ptr, byval lNoNotifyFlags as long) as HRESULT
declare sub IMediaEventEx_SetNotifyFlags_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaEventEx_GetNotifyFlags_Proxy(byval This as IMediaEventEx ptr, byval lplNoNotifyFlags as long ptr) as HRESULT
declare sub IMediaEventEx_GetNotifyFlags_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IMediaPosition_INTERFACE_DEFINED__

extern IID_IMediaPosition as const GUID

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
	put_Left as function(byval This as IVideoWindow ptr, byval Left_ as long) as HRESULT
	get_Left as function(byval This as IVideoWindow ptr, byval pLeft as long ptr) as HRESULT
	put_Width as function(byval This as IVideoWindow ptr, byval Width_ as long) as HRESULT
	get_Width as function(byval This as IVideoWindow ptr, byval pWidth as long ptr) as HRESULT
	put_Top as function(byval This as IVideoWindow ptr, byval Top as long) as HRESULT
	get_Top as function(byval This as IVideoWindow ptr, byval pTop as long ptr) as HRESULT
	put_Height as function(byval This as IVideoWindow ptr, byval Height as long) as HRESULT
	get_Height as function(byval This as IVideoWindow ptr, byval pHeight as long ptr) as HRESULT
	put_Owner as function(byval This as IVideoWindow ptr, byval Owner as OAHWND) as HRESULT
	get_Owner as function(byval This as IVideoWindow ptr, byval Owner as OAHWND ptr) as HRESULT
	put_MessageDrain as function(byval This as IVideoWindow ptr, byval Drain as OAHWND) as HRESULT
	get_MessageDrain as function(byval This as IVideoWindow ptr, byval Drain as OAHWND ptr) as HRESULT
	get_BorderColor as function(byval This as IVideoWindow ptr, byval Color_ as long ptr) as HRESULT
	put_BorderColor as function(byval This as IVideoWindow ptr, byval Color_ as long) as HRESULT
	get_FullScreenMode as function(byval This as IVideoWindow ptr, byval FullScreenMode as long ptr) as HRESULT
	put_FullScreenMode as function(byval This as IVideoWindow ptr, byval FullScreenMode as long) as HRESULT
	SetWindowForeground as function(byval This as IVideoWindow ptr, byval Focus as long) as HRESULT
	NotifyOwnerMessage as function(byval This as IVideoWindow ptr, byval hwnd as OAHWND, byval uMsg as long, byval wParam as LONG_PTR, byval lParam as LONG_PTR) as HRESULT
	SetWindowPosition as function(byval This as IVideoWindow ptr, byval Left_ as long, byval Top as long, byval Width_ as long, byval Height as long) as HRESULT
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
declare function IVideoWindow_put_Left_Proxy(byval This as IVideoWindow ptr, byval Left_ as long) as HRESULT
declare sub IVideoWindow_put_Left_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_get_Left_Proxy(byval This as IVideoWindow ptr, byval pLeft as long ptr) as HRESULT
declare sub IVideoWindow_get_Left_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_put_Width_Proxy(byval This as IVideoWindow ptr, byval Width_ as long) as HRESULT
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
declare function IVideoWindow_get_BorderColor_Proxy(byval This as IVideoWindow ptr, byval Color_ as long ptr) as HRESULT
declare sub IVideoWindow_get_BorderColor_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_put_BorderColor_Proxy(byval This as IVideoWindow ptr, byval Color_ as long) as HRESULT
declare sub IVideoWindow_put_BorderColor_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_get_FullScreenMode_Proxy(byval This as IVideoWindow ptr, byval FullScreenMode as long ptr) as HRESULT
declare sub IVideoWindow_get_FullScreenMode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_put_FullScreenMode_Proxy(byval This as IVideoWindow ptr, byval FullScreenMode as long) as HRESULT
declare sub IVideoWindow_put_FullScreenMode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_SetWindowForeground_Proxy(byval This as IVideoWindow ptr, byval Focus as long) as HRESULT
declare sub IVideoWindow_SetWindowForeground_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_NotifyOwnerMessage_Proxy(byval This as IVideoWindow ptr, byval hwnd as OAHWND, byval uMsg as long, byval wParam as LONG_PTR, byval lParam as LONG_PTR) as HRESULT
declare sub IVideoWindow_NotifyOwnerMessage_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoWindow_SetWindowPosition_Proxy(byval This as IVideoWindow ptr, byval Left_ as long, byval Top as long, byval Width_ as long, byval Height as long) as HRESULT
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
	SetSourcePosition as function(byval This as IBasicVideo ptr, byval Left_ as long, byval Top as long, byval Width_ as long, byval Height as long) as HRESULT
	GetSourcePosition as function(byval This as IBasicVideo ptr, byval pLeft as long ptr, byval pTop as long ptr, byval pWidth as long ptr, byval pHeight as long ptr) as HRESULT
	SetDefaultSourcePosition as function(byval This as IBasicVideo ptr) as HRESULT
	SetDestinationPosition as function(byval This as IBasicVideo ptr, byval Left_ as long, byval Top as long, byval Width_ as long, byval Height as long) as HRESULT
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
declare function IBasicVideo_SetSourcePosition_Proxy(byval This as IBasicVideo ptr, byval Left_ as long, byval Top as long, byval Width_ as long, byval Height as long) as HRESULT
declare sub IBasicVideo_SetSourcePosition_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicVideo_GetSourcePosition_Proxy(byval This as IBasicVideo ptr, byval pLeft as long ptr, byval pTop as long ptr, byval pWidth as long ptr, byval pHeight as long ptr) as HRESULT
declare sub IBasicVideo_GetSourcePosition_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicVideo_SetDefaultSourcePosition_Proxy(byval This as IBasicVideo ptr) as HRESULT
declare sub IBasicVideo_SetDefaultSourcePosition_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBasicVideo_SetDestinationPosition_Proxy(byval This as IBasicVideo ptr, byval Left_ as long, byval Top as long, byval Width_ as long, byval Height as long) as HRESULT
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
	SetSourcePosition as function(byval This as IBasicVideo2 ptr, byval Left_ as long, byval Top as long, byval Width_ as long, byval Height as long) as HRESULT
	GetSourcePosition as function(byval This as IBasicVideo2 ptr, byval pLeft as long ptr, byval pTop as long ptr, byval pWidth as long ptr, byval pHeight as long ptr) as HRESULT
	SetDefaultSourcePosition as function(byval This as IBasicVideo2 ptr) as HRESULT
	SetDestinationPosition as function(byval This as IBasicVideo2 ptr, byval Left_ as long, byval Top as long, byval Width_ as long, byval Height as long) as HRESULT
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

declare function IBasicVideo2_GetPreferredAspectRatio_Proxy(byval This as IBasicVideo2 ptr, byval plAspectX as long ptr, byval plAspectY as long ptr) as HRESULT
declare sub IBasicVideo2_GetPreferredAspectRatio_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IDeferredCommand_INTERFACE_DEFINED__

extern IID_IDeferredCommand as const GUID

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

type IQueueCommandVtbl
	QueryInterface as function(byval This as IQueueCommand ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IQueueCommand ptr) as ULONG
	Release as function(byval This as IQueueCommand ptr) as ULONG
	InvokeAtStreamTime as function(byval This as IQueueCommand ptr, byval pCmd as IDeferredCommand ptr ptr, byval time_ as REFTIME, byval iid as GUID ptr, byval dispidMethod as long, byval wFlags as short, byval cArgs as long, byval pDispParams as VARIANT ptr, byval pvarResult as VARIANT ptr, byval puArgErr as short ptr) as HRESULT
	InvokeAtPresentationTime as function(byval This as IQueueCommand ptr, byval pCmd as IDeferredCommand ptr ptr, byval time_ as REFTIME, byval iid as GUID ptr, byval dispidMethod as long, byval wFlags as short, byval cArgs as long, byval pDispParams as VARIANT ptr, byval pvarResult as VARIANT ptr, byval puArgErr as short ptr) as HRESULT
end type

type IQueueCommand_
	lpVtbl as IQueueCommandVtbl ptr
end type

declare function IQueueCommand_InvokeAtStreamTime_Proxy(byval This as IQueueCommand ptr, byval pCmd as IDeferredCommand ptr ptr, byval time_ as REFTIME, byval iid as GUID ptr, byval dispidMethod as long, byval wFlags as short, byval cArgs as long, byval pDispParams as VARIANT ptr, byval pvarResult as VARIANT ptr, byval puArgErr as short ptr) as HRESULT
declare sub IQueueCommand_InvokeAtStreamTime_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IQueueCommand_InvokeAtPresentationTime_Proxy(byval This as IQueueCommand ptr, byval pCmd as IDeferredCommand ptr ptr, byval time_ as REFTIME, byval iid as GUID ptr, byval dispidMethod as long, byval wFlags as short, byval cArgs as long, byval pDispParams as VARIANT ptr, byval pvarResult as VARIANT ptr, byval puArgErr as short ptr) as HRESULT
declare sub IQueueCommand_InvokeAtPresentationTime_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

extern CLSID_FilgraphManager as const GUID

#define __IFilterInfo_INTERFACE_DEFINED__

extern IID_IFilterInfo as const GUID

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

declare function IRegFilterInfo_get_Name_Proxy(byval This as IRegFilterInfo ptr, byval strName as BSTR ptr) as HRESULT
declare sub IRegFilterInfo_get_Name_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IRegFilterInfo_Filter_Proxy(byval This as IRegFilterInfo ptr, byval ppUnk as IDispatch ptr ptr) as HRESULT
declare sub IRegFilterInfo_Filter_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IMediaTypeInfo_INTERFACE_DEFINED__

extern IID_IMediaTypeInfo as const GUID

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

declare function IMediaTypeInfo_get_Type_Proxy(byval This as IMediaTypeInfo ptr, byval strType as BSTR ptr) as HRESULT
declare sub IMediaTypeInfo_get_Type_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaTypeInfo_get_Subtype_Proxy(byval This as IMediaTypeInfo ptr, byval strType as BSTR ptr) as HRESULT
declare sub IMediaTypeInfo_get_Subtype_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IPinInfo_INTERFACE_DEFINED__

extern IID_IPinInfo as const GUID

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
