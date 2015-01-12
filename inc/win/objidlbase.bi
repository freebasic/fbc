#pragma once

extern "Windows"

type IMarshal as IMarshal_
type INoMarshal as INoMarshal_
type IAgileObject as IAgileObject_
type IMarshal2 as IMarshal2_
type IMalloc as IMalloc_
type IStdMarshalInfo as IStdMarshalInfo_
type IExternalConnection as IExternalConnection_
type IMultiQI as IMultiQI_
type AsyncIMultiQI as AsyncIMultiQI_
type IInternalUnknown as IInternalUnknown_
type IEnumUnknown as IEnumUnknown_
type IEnumString as IEnumString_
type ISequentialStream as ISequentialStream_
type IStream as IStream_
type IRpcChannelBuffer as IRpcChannelBuffer_
type IRpcChannelBuffer2 as IRpcChannelBuffer2_
type IAsyncRpcChannelBuffer as IAsyncRpcChannelBuffer_
type IRpcChannelBuffer3 as IRpcChannelBuffer3_
type IRpcSyntaxNegotiate as IRpcSyntaxNegotiate_
type IRpcProxyBuffer as IRpcProxyBuffer_
type IRpcStubBuffer as IRpcStubBuffer_
type IPSFactoryBuffer as IPSFactoryBuffer_
type IChannelHook as IChannelHook_
type IClientSecurity as IClientSecurity_
type IServerSecurity as IServerSecurity_
type IRpcOptions as IRpcOptions_
type IGlobalOptions as IGlobalOptions_
type ISurrogate as ISurrogate_
type IGlobalInterfaceTable as IGlobalInterfaceTable_
type ISynchronize as ISynchronize_
type ISynchronizeHandle as ISynchronizeHandle_
type ISynchronizeEvent as ISynchronizeEvent_
type ISynchronizeContainer as ISynchronizeContainer_
type ISynchronizeMutex as ISynchronizeMutex_
type ICancelMethodCalls as ICancelMethodCalls_
type IAsyncManager as IAsyncManager_
type ICallFactory as ICallFactory_
type IRpcHelper as IRpcHelper_
type IReleaseMarshalBuffers as IReleaseMarshalBuffers_
type IWaitMultiple as IWaitMultiple_
type IAddrTrackingControl as IAddrTrackingControl_
type IAddrExclusionControl as IAddrExclusionControl_
type IPipeByte as IPipeByte_
type IPipeLong as IPipeLong_
type IPipeDouble as IPipeDouble_
type IComThreadingInfo as IComThreadingInfo_
type IProcessInitControl as IProcessInitControl_
type IFastRundown as IFastRundown_
type IMarshalingStream as IMarshalingStream_

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

type LPMARSHAL as IMarshal ptr

extern IID_IMarshal as const GUID

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

type INoMarshalVtbl
	QueryInterface as function(byval This as INoMarshal ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as INoMarshal ptr) as ULONG
	Release as function(byval This as INoMarshal ptr) as ULONG
end type

type INoMarshal_
	lpVtbl as INoMarshalVtbl ptr
end type

#define __IAgileObject_INTERFACE_DEFINED__

extern IID_IAgileObject as const GUID

type IAgileObjectVtbl
	QueryInterface as function(byval This as IAgileObject ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAgileObject ptr) as ULONG
	Release as function(byval This as IAgileObject ptr) as ULONG
end type

type IAgileObject_
	lpVtbl as IAgileObjectVtbl ptr
end type

#define __IMarshal2_INTERFACE_DEFINED__

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

#define __IMalloc_INTERFACE_DEFINED__

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

declare function IStdMarshalInfo_GetClassForHandler_Proxy(byval This as IStdMarshalInfo ptr, byval dwDestContext as DWORD, byval pvDestContext as any ptr, byval pClsid as CLSID ptr) as HRESULT
declare sub IStdMarshalInfo_GetClassForHandler_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IExternalConnection_INTERFACE_DEFINED__

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

declare function IExternalConnection_AddConnection_Proxy(byval This as IExternalConnection ptr, byval extconn as DWORD, byval reserved as DWORD) as DWORD
declare sub IExternalConnection_AddConnection_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IExternalConnection_ReleaseConnection_Proxy(byval This as IExternalConnection ptr, byval extconn as DWORD, byval reserved as DWORD, byval fLastReleaseCloses as WINBOOL) as DWORD
declare sub IExternalConnection_ReleaseConnection_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

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

declare function IMultiQI_QueryMultipleInterfaces_Proxy(byval This as IMultiQI ptr, byval cMQIs as ULONG, byval pMQIs as MULTI_QI ptr) as HRESULT
declare sub IMultiQI_QueryMultipleInterfaces_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __AsyncIMultiQI_INTERFACE_DEFINED__

extern IID_AsyncIMultiQI as const GUID

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

declare function AsyncIMultiQI_Begin_QueryMultipleInterfaces_Proxy(byval This as IMultiQI ptr, byval cMQIs as ULONG, byval pMQIs as MULTI_QI ptr) as HRESULT
declare sub AsyncIMultiQI_Begin_QueryMultipleInterfaces_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function AsyncIMultiQI_Finish_QueryMultipleInterfaces_Proxy(byval This as IMultiQI ptr, byval cMQIs as ULONG, byval pMQIs as MULTI_QI ptr) as HRESULT
declare sub AsyncIMultiQI_Finish_QueryMultipleInterfaces_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IInternalUnknown_INTERFACE_DEFINED__

extern IID_IInternalUnknown as const GUID

type IInternalUnknownVtbl
	QueryInterface as function(byval This as IInternalUnknown ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IInternalUnknown ptr) as ULONG
	Release as function(byval This as IInternalUnknown ptr) as ULONG
	QueryInternalInterface as function(byval This as IInternalUnknown ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
end type

type IInternalUnknown_
	lpVtbl as IInternalUnknownVtbl ptr
end type

declare function IInternalUnknown_QueryInternalInterface_Proxy(byval This as IInternalUnknown ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IInternalUnknown_QueryInternalInterface_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IEnumUnknown_INTERFACE_DEFINED__

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

declare function IRpcChannelBuffer2_GetProtocolVersion_Proxy(byval This as IRpcChannelBuffer2 ptr, byval pdwVersion as DWORD ptr) as HRESULT
declare sub IRpcChannelBuffer2_GetProtocolVersion_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IAsyncRpcChannelBuffer_INTERFACE_DEFINED__

extern IID_IAsyncRpcChannelBuffer as const GUID

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

declare function IAsyncRpcChannelBuffer_Send_Proxy(byval This as IAsyncRpcChannelBuffer ptr, byval pMsg as RPCOLEMESSAGE ptr, byval pSync as ISynchronize ptr, byval pulStatus as ULONG ptr) as HRESULT
declare sub IAsyncRpcChannelBuffer_Send_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAsyncRpcChannelBuffer_Receive_Proxy(byval This as IAsyncRpcChannelBuffer ptr, byval pMsg as RPCOLEMESSAGE ptr, byval pulStatus as ULONG ptr) as HRESULT
declare sub IAsyncRpcChannelBuffer_Receive_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAsyncRpcChannelBuffer_GetDestCtxEx_Proxy(byval This as IAsyncRpcChannelBuffer ptr, byval pMsg as RPCOLEMESSAGE ptr, byval pdwDestContext as DWORD ptr, byval ppvDestContext as any ptr ptr) as HRESULT
declare sub IAsyncRpcChannelBuffer_GetDestCtxEx_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IRpcChannelBuffer3_INTERFACE_DEFINED__

extern IID_IRpcChannelBuffer3 as const GUID

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

type IRpcSyntaxNegotiateVtbl
	QueryInterface as function(byval This as IRpcSyntaxNegotiate ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IRpcSyntaxNegotiate ptr) as ULONG
	Release as function(byval This as IRpcSyntaxNegotiate ptr) as ULONG
	NegotiateSyntax as function(byval This as IRpcSyntaxNegotiate ptr, byval pMsg as RPCOLEMESSAGE ptr) as HRESULT
end type

type IRpcSyntaxNegotiate_
	lpVtbl as IRpcSyntaxNegotiateVtbl ptr
end type

declare function IRpcSyntaxNegotiate_NegotiateSyntax_Proxy(byval This as IRpcSyntaxNegotiate ptr, byval pMsg as RPCOLEMESSAGE ptr) as HRESULT
declare sub IRpcSyntaxNegotiate_NegotiateSyntax_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IRpcProxyBuffer_INTERFACE_DEFINED__

extern IID_IRpcProxyBuffer as const GUID

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

#define COLE_DEFAULT_PRINCIPAL cptr(wstring ptr, cast(INT_PTR, -1))
#define COLE_DEFAULT_AUTHINFO cptr(any ptr, cast(INT_PTR, -1))

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

declare function IClientSecurity_QueryBlanket_Proxy(byval This as IClientSecurity ptr, byval pProxy as IUnknown ptr, byval pAuthnSvc as DWORD ptr, byval pAuthzSvc as DWORD ptr, byval pServerPrincName as wstring ptr ptr, byval pAuthnLevel as DWORD ptr, byval pImpLevel as DWORD ptr, byval pAuthInfo as any ptr ptr, byval pCapabilites as DWORD ptr) as HRESULT
declare sub IClientSecurity_QueryBlanket_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IClientSecurity_SetBlanket_Proxy(byval This as IClientSecurity ptr, byval pProxy as IUnknown ptr, byval dwAuthnSvc as DWORD, byval dwAuthzSvc as DWORD, byval pServerPrincName as wstring ptr, byval dwAuthnLevel as DWORD, byval dwImpLevel as DWORD, byval pAuthInfo as any ptr, byval dwCapabilities as DWORD) as HRESULT
declare sub IClientSecurity_SetBlanket_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IClientSecurity_CopyProxy_Proxy(byval This as IClientSecurity ptr, byval pProxy as IUnknown ptr, byval ppCopy as IUnknown ptr ptr) as HRESULT
declare sub IClientSecurity_CopyProxy_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IServerSecurity_INTERFACE_DEFINED__

extern IID_IServerSecurity as const GUID

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

declare function IGlobalOptions_Set_Proxy(byval This as IGlobalOptions ptr, byval dwProperty as GLOBALOPT_PROPERTIES, byval dwValue as ULONG_PTR) as HRESULT
declare sub IGlobalOptions_Set_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IGlobalOptions_Query_Proxy(byval This as IGlobalOptions ptr, byval dwProperty as GLOBALOPT_PROPERTIES, byval pdwValue as ULONG_PTR ptr) as HRESULT
declare sub IGlobalOptions_Query_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __ISurrogate_INTERFACE_DEFINED__

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

declare function ISurrogate_LoadDllServer_Proxy(byval This as ISurrogate ptr, byval Clsid as const IID const ptr) as HRESULT
declare sub ISurrogate_LoadDllServer_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ISurrogate_FreeSurrogate_Proxy(byval This as ISurrogate ptr) as HRESULT
declare sub ISurrogate_FreeSurrogate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IGlobalInterfaceTable_INTERFACE_DEFINED__

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

declare function ISynchronize_Wait_Proxy(byval This as ISynchronize ptr, byval dwFlags as DWORD, byval dwMilliseconds as DWORD) as HRESULT
declare sub ISynchronize_Wait_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ISynchronize_Signal_Proxy(byval This as ISynchronize ptr) as HRESULT
declare sub ISynchronize_Signal_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ISynchronize_Reset_Proxy(byval This as ISynchronize ptr) as HRESULT
declare sub ISynchronize_Reset_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __ISynchronizeHandle_INTERFACE_DEFINED__

extern IID_ISynchronizeHandle as const GUID

type ISynchronizeHandleVtbl
	QueryInterface as function(byval This as ISynchronizeHandle ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ISynchronizeHandle ptr) as ULONG
	Release as function(byval This as ISynchronizeHandle ptr) as ULONG
	GetHandle as function(byval This as ISynchronizeHandle ptr, byval ph as HANDLE ptr) as HRESULT
end type

type ISynchronizeHandle_
	lpVtbl as ISynchronizeHandleVtbl ptr
end type

declare function ISynchronizeHandle_GetHandle_Proxy(byval This as ISynchronizeHandle ptr, byval ph as HANDLE ptr) as HRESULT
declare sub ISynchronizeHandle_GetHandle_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __ISynchronizeEvent_INTERFACE_DEFINED__

extern IID_ISynchronizeEvent as const GUID

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

declare function ISynchronizeEvent_SetEventHandle_Proxy(byval This as ISynchronizeEvent ptr, byval ph as HANDLE ptr) as HRESULT
declare sub ISynchronizeEvent_SetEventHandle_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __ISynchronizeContainer_INTERFACE_DEFINED__

extern IID_ISynchronizeContainer as const GUID

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

declare function ISynchronizeContainer_AddSynchronize_Proxy(byval This as ISynchronizeContainer ptr, byval pSync as ISynchronize ptr) as HRESULT
declare sub ISynchronizeContainer_AddSynchronize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ISynchronizeContainer_WaitMultiple_Proxy(byval This as ISynchronizeContainer ptr, byval dwFlags as DWORD, byval dwTimeOut as DWORD, byval ppSync as ISynchronize ptr ptr) as HRESULT
declare sub ISynchronizeContainer_WaitMultiple_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __ISynchronizeMutex_INTERFACE_DEFINED__

extern IID_ISynchronizeMutex as const GUID

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

declare function ISynchronizeMutex_ReleaseMutex_Proxy(byval This as ISynchronizeMutex ptr) as HRESULT
declare sub ISynchronizeMutex_ReleaseMutex_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __ICancelMethodCalls_INTERFACE_DEFINED__

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

declare function IAsyncManager_CompleteCall_Proxy(byval This as IAsyncManager ptr, byval Result as HRESULT) as HRESULT
declare sub IAsyncManager_CompleteCall_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAsyncManager_GetCallContext_Proxy(byval This as IAsyncManager ptr, byval riid as const IID const ptr, byval pInterface as any ptr ptr) as HRESULT
declare sub IAsyncManager_GetCallContext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAsyncManager_GetState_Proxy(byval This as IAsyncManager ptr, byval pulStateFlags as ULONG ptr) as HRESULT
declare sub IAsyncManager_GetState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __ICallFactory_INTERFACE_DEFINED__

extern IID_ICallFactory as const GUID

type ICallFactoryVtbl
	QueryInterface as function(byval This as ICallFactory ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ICallFactory ptr) as ULONG
	Release as function(byval This as ICallFactory ptr) as ULONG
	CreateCall as function(byval This as ICallFactory ptr, byval riid as const IID const ptr, byval pCtrlUnk as IUnknown ptr, byval riid2 as const IID const ptr, byval ppv as IUnknown ptr ptr) as HRESULT
end type

type ICallFactory_
	lpVtbl as ICallFactoryVtbl ptr
end type

declare function ICallFactory_CreateCall_Proxy(byval This as ICallFactory ptr, byval riid as const IID const ptr, byval pCtrlUnk as IUnknown ptr, byval riid2 as const IID const ptr, byval ppv as IUnknown ptr ptr) as HRESULT
declare sub ICallFactory_CreateCall_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IRpcHelper_INTERFACE_DEFINED__

extern IID_IRpcHelper as const GUID

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

declare function IRpcHelper_GetDCOMProtocolVersion_Proxy(byval This as IRpcHelper ptr, byval pComVersion as DWORD ptr) as HRESULT
declare sub IRpcHelper_GetDCOMProtocolVersion_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRpcHelper_GetIIDFromOBJREF_Proxy(byval This as IRpcHelper ptr, byval pObjRef as any ptr, byval piid as IID ptr ptr) as HRESULT
declare sub IRpcHelper_GetIIDFromOBJREF_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IReleaseMarshalBuffers_INTERFACE_DEFINED__

extern IID_IReleaseMarshalBuffers as const GUID

type IReleaseMarshalBuffersVtbl
	QueryInterface as function(byval This as IReleaseMarshalBuffers ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IReleaseMarshalBuffers ptr) as ULONG
	Release as function(byval This as IReleaseMarshalBuffers ptr) as ULONG
	ReleaseMarshalBuffer as function(byval This as IReleaseMarshalBuffers ptr, byval pMsg as RPCOLEMESSAGE ptr, byval dwFlags as DWORD, byval pChnl as IUnknown ptr) as HRESULT
end type

type IReleaseMarshalBuffers_
	lpVtbl as IReleaseMarshalBuffersVtbl ptr
end type

declare function IReleaseMarshalBuffers_ReleaseMarshalBuffer_Proxy(byval This as IReleaseMarshalBuffers ptr, byval pMsg as RPCOLEMESSAGE ptr, byval dwFlags as DWORD, byval pChnl as IUnknown ptr) as HRESULT
declare sub IReleaseMarshalBuffers_ReleaseMarshalBuffer_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IWaitMultiple_INTERFACE_DEFINED__

extern IID_IWaitMultiple as const GUID

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

declare function IWaitMultiple_WaitMultiple_Proxy(byval This as IWaitMultiple ptr, byval timeout as DWORD, byval pSync as ISynchronize ptr ptr) as HRESULT
declare sub IWaitMultiple_WaitMultiple_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWaitMultiple_AddSynchronize_Proxy(byval This as IWaitMultiple ptr, byval pSync as ISynchronize ptr) as HRESULT
declare sub IWaitMultiple_AddSynchronize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IAddrTrackingControl_INTERFACE_DEFINED__

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

declare function IAddrTrackingControl_EnableCOMDynamicAddrTracking_Proxy(byval This as IAddrTrackingControl ptr) as HRESULT
declare sub IAddrTrackingControl_EnableCOMDynamicAddrTracking_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAddrTrackingControl_DisableCOMDynamicAddrTracking_Proxy(byval This as IAddrTrackingControl ptr) as HRESULT
declare sub IAddrTrackingControl_DisableCOMDynamicAddrTracking_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IAddrExclusionControl_INTERFACE_DEFINED__

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

declare function IAddrExclusionControl_GetCurrentAddrExclusionList_Proxy(byval This as IAddrExclusionControl ptr, byval riid as const IID const ptr, byval ppEnumerator as any ptr ptr) as HRESULT
declare sub IAddrExclusionControl_GetCurrentAddrExclusionList_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAddrExclusionControl_UpdateAddrExclusionList_Proxy(byval This as IAddrExclusionControl ptr, byval pEnumerator as IUnknown ptr) as HRESULT
declare sub IAddrExclusionControl_UpdateAddrExclusionList_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IPipeByte_INTERFACE_DEFINED__

extern IID_IPipeByte as const GUID

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

declare function IPipeByte_Pull_Proxy(byval This as IPipeByte ptr, byval buf as UBYTE ptr, byval cRequest as ULONG, byval pcReturned as ULONG ptr) as HRESULT
declare sub IPipeByte_Pull_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPipeByte_Push_Proxy(byval This as IPipeByte ptr, byval buf as UBYTE ptr, byval cSent as ULONG) as HRESULT
declare sub IPipeByte_Push_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IPipeLong_INTERFACE_DEFINED__

extern IID_IPipeLong as const GUID

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

declare function IPipeLong_Pull_Proxy(byval This as IPipeLong ptr, byval buf as LONG ptr, byval cRequest as ULONG, byval pcReturned as ULONG ptr) as HRESULT
declare sub IPipeLong_Pull_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPipeLong_Push_Proxy(byval This as IPipeLong ptr, byval buf as LONG ptr, byval cSent as ULONG) as HRESULT
declare sub IPipeLong_Push_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IPipeDouble_INTERFACE_DEFINED__

extern IID_IPipeDouble as const GUID

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

type IProcessInitControlVtbl
	QueryInterface as function(byval This as IProcessInitControl ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IProcessInitControl ptr) as ULONG
	Release as function(byval This as IProcessInitControl ptr) as ULONG
	ResetInitializerTimeout as function(byval This as IProcessInitControl ptr, byval dwSecondsRemaining as DWORD) as HRESULT
end type

type IProcessInitControl_
	lpVtbl as IProcessInitControlVtbl ptr
end type

declare function IProcessInitControl_ResetInitializerTimeout_Proxy(byval This as IProcessInitControl ptr, byval dwSecondsRemaining as DWORD) as HRESULT
declare sub IProcessInitControl_ResetInitializerTimeout_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IFastRundown_INTERFACE_DEFINED__

extern IID_IFastRundown as const GUID

type IFastRundownVtbl
	QueryInterface as function(byval This as IFastRundown ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IFastRundown ptr) as ULONG
	Release as function(byval This as IFastRundown ptr) as ULONG
end type

type IFastRundown_
	lpVtbl as IFastRundownVtbl ptr
end type

type CO_MARSHALING_CONTEXT_ATTRIBUTES as long
enum
	CO_MARSHALING_SOURCE_IS_APP_CONTAINER = 0
end enum

#define __IMarshalingStream_INTERFACE_DEFINED__

extern IID_IMarshalingStream as const GUID

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

declare function IMarshalingStream_GetMarshalingContextAttribute_Proxy(byval This as IMarshalingStream ptr, byval attribute as CO_MARSHALING_CONTEXT_ATTRIBUTES, byval pAttributeValue as ULONG_PTR ptr) as HRESULT
declare sub IMarshalingStream_GetMarshalingContextAttribute_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

extern IID_ICallbackWithNoReentrancyToApplicationSTA as const GUID

#define _OBJIDLBASE_

end extern
