#pragma once

#include once "rpc.bi"
#include once "rpcndr.bi"
#include once "windows.bi"
#include once "ole2.bi"
#include once "unknwn.bi"
#include once "objidl.bi"
#include once "oaidl.bi"
#include once "ocidl.bi"
#include once "ddraw.bi"

#inclib "strmiids"

extern "Windows"

#define __strmif_h__
#define __ICreateDevEnum_FWD_DEFINED__
#define __IPin_FWD_DEFINED__
#define __IEnumPins_FWD_DEFINED__
#define __IEnumMediaTypes_FWD_DEFINED__
#define __IFilterGraph_FWD_DEFINED__
#define __IEnumFilters_FWD_DEFINED__
#define __IMediaFilter_FWD_DEFINED__
#define __IBaseFilter_FWD_DEFINED__
#define __IReferenceClock_FWD_DEFINED__
#define __IMediaSample_FWD_DEFINED__
#define __IMediaSample2_FWD_DEFINED__
#define __IMemAllocator_FWD_DEFINED__
#define __IMemAllocatorCallbackTemp_FWD_DEFINED__
#define __IMemAllocatorNotifyCallbackTemp_FWD_DEFINED__
#define __IMemInputPin_FWD_DEFINED__
#define __IAMovieSetup_FWD_DEFINED__
#define __IMediaSeeking_FWD_DEFINED__
#define __IEnumRegFilters_FWD_DEFINED__
#define __IFilterMapper_FWD_DEFINED__
#define __IFilterMapper2_FWD_DEFINED__
#define __IFilterMapper3_FWD_DEFINED__
#define __IQualityControl_FWD_DEFINED__
#define __IOverlayNotify_FWD_DEFINED__
#define __IOverlayNotify2_FWD_DEFINED__
#define __IOverlay_FWD_DEFINED__
#define __IMediaEventSink_FWD_DEFINED__
#define __IFileSourceFilter_FWD_DEFINED__
#define __IFileSinkFilter_FWD_DEFINED__
#define __IFileSinkFilter2_FWD_DEFINED__
#define __IGraphBuilder_FWD_DEFINED__
#define __ICaptureGraphBuilder_FWD_DEFINED__
#define __IAMCopyCaptureFileProgress_FWD_DEFINED__
#define __ICaptureGraphBuilder2_FWD_DEFINED__
#define __IFilterGraph2_FWD_DEFINED__
#define __IStreamBuilder_FWD_DEFINED__
#define __IAMStreamConfig_FWD_DEFINED__
#define __IAMVideoProcAmp_FWD_DEFINED__
#define __IAsyncReader_FWD_DEFINED__
#define __IGraphVersion_FWD_DEFINED__
#define __IResourceConsumer_FWD_DEFINED__
#define __IResourceManager_FWD_DEFINED__
#define __IKsPropertySet_FWD_DEFINED__
#define __ISeekingPassThru_FWD_DEFINED__
#define __IAMFilterMiscFlags_FWD_DEFINED__
#define __IAMGraphBuilderCallback_FWD_DEFINED__
#define CDEF_CLASS_DEFAULT &h0001
#define CDEF_BYPASS_CLASS_MANAGER &h0002
#define CDEF_MERIT_ABOVE_DO_NOT_USE &h0008
#define CDEF_DEVMON_CMGR_DEVICE &h0010
#define CDEF_DEVMON_DMO &h0020
#define CDEF_DEVMON_PNP_DEVICE &h0040
#define CDEF_DEVMON_FILTER &h0080
#define CDEF_DEVMON_SELECTIVE_MASK &h00f0
#define __ICreateDevEnum_INTERFACE_DEFINED__

extern IID_ICreateDevEnum as const GUID

type ICreateDevEnum as ICreateDevEnum_

type ICreateDevEnumVtbl
	QueryInterface as function(byval This as ICreateDevEnum ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ICreateDevEnum ptr) as ULONG
	Release as function(byval This as ICreateDevEnum ptr) as ULONG
	CreateClassEnumerator as function(byval This as ICreateDevEnum ptr, byval clsidDeviceClass as const IID const ptr, byval ppEnumMoniker as IEnumMoniker ptr ptr, byval dwFlags as DWORD) as HRESULT
end type

type ICreateDevEnum_
	lpVtbl as ICreateDevEnumVtbl ptr
end type

declare function ICreateDevEnum_CreateClassEnumerator_Proxy(byval This as ICreateDevEnum ptr, byval clsidDeviceClass as const IID const ptr, byval ppEnumMoniker as IEnumMoniker ptr ptr, byval dwFlags as DWORD) as HRESULT
declare sub ICreateDevEnum_CreateClassEnumerator_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define CHARS_IN_GUID 39

type _AMMediaType
	majortype as GUID
	subtype as GUID
	bFixedSizeSamples as WINBOOL
	bTemporalCompression as WINBOOL
	lSampleSize as ULONG
	formattype as GUID
	pUnk as IUnknown ptr
	cbFormat as ULONG
	pbFormat as UBYTE ptr
end type

type AM_MEDIA_TYPE as _AMMediaType

type _PinDirection as long
enum
	PINDIR_INPUT = 0
	PINDIR_OUTPUT = 1
end enum

type PIN_DIRECTION as _PinDirection

#define MAX_PIN_NAME 128
#define MAX_FILTER_NAME 128
#define REFERENCE_TIME_DEFINED

type REFERENCE_TIME as LONGLONG
type HSEMAPHORE as DWORD_PTR
type HEVENT as DWORD_PTR

type _AllocatorProperties
	cBuffers as LONG
	cbBuffer as LONG
	cbAlign as LONG
	cbPrefix as LONG
end type

type ALLOCATOR_PROPERTIES as _AllocatorProperties

#define __IPin_INTERFACE_DEFINED__

type IBaseFilter as IBaseFilter_

type _PinInfo
	pFilter as IBaseFilter ptr
	dir as PIN_DIRECTION
	achName as wstring * 128
end type

type PIN_INFO as _PinInfo

extern IID_IPin as const GUID

type IEnumMediaTypes as IEnumMediaTypes_
type IPin as IPin_

type IPinVtbl
	QueryInterface as function(byval This as IPin ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPin ptr) as ULONG
	Release as function(byval This as IPin ptr) as ULONG
	Connect as function(byval This as IPin ptr, byval pReceivePin as IPin ptr, byval pmt as const AM_MEDIA_TYPE ptr) as HRESULT
	ReceiveConnection as function(byval This as IPin ptr, byval pConnector as IPin ptr, byval pmt as const AM_MEDIA_TYPE ptr) as HRESULT
	Disconnect as function(byval This as IPin ptr) as HRESULT
	ConnectedTo as function(byval This as IPin ptr, byval pPin as IPin ptr ptr) as HRESULT
	ConnectionMediaType as function(byval This as IPin ptr, byval pmt as AM_MEDIA_TYPE ptr) as HRESULT
	QueryPinInfo as function(byval This as IPin ptr, byval pInfo as PIN_INFO ptr) as HRESULT
	QueryDirection as function(byval This as IPin ptr, byval pPinDir as PIN_DIRECTION ptr) as HRESULT
	QueryId as function(byval This as IPin ptr, byval Id as LPWSTR ptr) as HRESULT
	QueryAccept as function(byval This as IPin ptr, byval pmt as const AM_MEDIA_TYPE ptr) as HRESULT
	EnumMediaTypes as function(byval This as IPin ptr, byval ppEnum as IEnumMediaTypes ptr ptr) as HRESULT
	QueryInternalConnections as function(byval This as IPin ptr, byval apPin as IPin ptr ptr, byval nPin as ULONG ptr) as HRESULT
	EndOfStream as function(byval This as IPin ptr) as HRESULT
	BeginFlush as function(byval This as IPin ptr) as HRESULT
	EndFlush as function(byval This as IPin ptr) as HRESULT
	NewSegment as function(byval This as IPin ptr, byval tStart as REFERENCE_TIME, byval tStop as REFERENCE_TIME, byval dRate as double) as HRESULT
end type

type IPin_
	lpVtbl as IPinVtbl ptr
end type

declare function IPin_Connect_Proxy(byval This as IPin ptr, byval pReceivePin as IPin ptr, byval pmt as const AM_MEDIA_TYPE ptr) as HRESULT
declare sub IPin_Connect_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPin_ReceiveConnection_Proxy(byval This as IPin ptr, byval pConnector as IPin ptr, byval pmt as const AM_MEDIA_TYPE ptr) as HRESULT
declare sub IPin_ReceiveConnection_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPin_Disconnect_Proxy(byval This as IPin ptr) as HRESULT
declare sub IPin_Disconnect_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPin_ConnectedTo_Proxy(byval This as IPin ptr, byval pPin as IPin ptr ptr) as HRESULT
declare sub IPin_ConnectedTo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPin_ConnectionMediaType_Proxy(byval This as IPin ptr, byval pmt as AM_MEDIA_TYPE ptr) as HRESULT
declare sub IPin_ConnectionMediaType_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPin_QueryPinInfo_Proxy(byval This as IPin ptr, byval pInfo as PIN_INFO ptr) as HRESULT
declare sub IPin_QueryPinInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPin_QueryDirection_Proxy(byval This as IPin ptr, byval pPinDir as PIN_DIRECTION ptr) as HRESULT
declare sub IPin_QueryDirection_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPin_QueryId_Proxy(byval This as IPin ptr, byval Id as LPWSTR ptr) as HRESULT
declare sub IPin_QueryId_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPin_QueryAccept_Proxy(byval This as IPin ptr, byval pmt as const AM_MEDIA_TYPE ptr) as HRESULT
declare sub IPin_QueryAccept_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPin_EnumMediaTypes_Proxy(byval This as IPin ptr, byval ppEnum as IEnumMediaTypes ptr ptr) as HRESULT
declare sub IPin_EnumMediaTypes_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPin_QueryInternalConnections_Proxy(byval This as IPin ptr, byval apPin as IPin ptr ptr, byval nPin as ULONG ptr) as HRESULT
declare sub IPin_QueryInternalConnections_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPin_EndOfStream_Proxy(byval This as IPin ptr) as HRESULT
declare sub IPin_EndOfStream_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPin_BeginFlush_Proxy(byval This as IPin ptr) as HRESULT
declare sub IPin_BeginFlush_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPin_EndFlush_Proxy(byval This as IPin ptr) as HRESULT
declare sub IPin_EndFlush_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPin_NewSegment_Proxy(byval This as IPin ptr, byval tStart as REFERENCE_TIME, byval tStop as REFERENCE_TIME, byval dRate as double) as HRESULT
declare sub IPin_NewSegment_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type PPIN as IPin ptr

#define __IEnumPins_INTERFACE_DEFINED__

extern IID_IEnumPins as const GUID

type IEnumPins as IEnumPins_

type IEnumPinsVtbl
	QueryInterface as function(byval This as IEnumPins ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEnumPins ptr) as ULONG
	Release as function(byval This as IEnumPins ptr) as ULONG
	Next as function(byval This as IEnumPins ptr, byval cPins as ULONG, byval ppPins as IPin ptr ptr, byval pcFetched as ULONG ptr) as HRESULT
	Skip as function(byval This as IEnumPins ptr, byval cPins as ULONG) as HRESULT
	Reset as function(byval This as IEnumPins ptr) as HRESULT
	Clone as function(byval This as IEnumPins ptr, byval ppEnum as IEnumPins ptr ptr) as HRESULT
end type

type IEnumPins_
	lpVtbl as IEnumPinsVtbl ptr
end type

declare function IEnumPins_Next_Proxy(byval This as IEnumPins ptr, byval cPins as ULONG, byval ppPins as IPin ptr ptr, byval pcFetched as ULONG ptr) as HRESULT
declare sub IEnumPins_Next_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumPins_Skip_Proxy(byval This as IEnumPins ptr, byval cPins as ULONG) as HRESULT
declare sub IEnumPins_Skip_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumPins_Reset_Proxy(byval This as IEnumPins ptr) as HRESULT
declare sub IEnumPins_Reset_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumPins_Clone_Proxy(byval This as IEnumPins ptr, byval ppEnum as IEnumPins ptr ptr) as HRESULT
declare sub IEnumPins_Clone_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type PENUMPINS as IEnumPins ptr

#define __IEnumMediaTypes_INTERFACE_DEFINED__

extern IID_IEnumMediaTypes as const GUID

type IEnumMediaTypesVtbl
	QueryInterface as function(byval This as IEnumMediaTypes ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEnumMediaTypes ptr) as ULONG
	Release as function(byval This as IEnumMediaTypes ptr) as ULONG
	Next as function(byval This as IEnumMediaTypes ptr, byval cMediaTypes as ULONG, byval ppMediaTypes as AM_MEDIA_TYPE ptr ptr, byval pcFetched as ULONG ptr) as HRESULT
	Skip as function(byval This as IEnumMediaTypes ptr, byval cMediaTypes as ULONG) as HRESULT
	Reset as function(byval This as IEnumMediaTypes ptr) as HRESULT
	Clone as function(byval This as IEnumMediaTypes ptr, byval ppEnum as IEnumMediaTypes ptr ptr) as HRESULT
end type

type IEnumMediaTypes_
	lpVtbl as IEnumMediaTypesVtbl ptr
end type

declare function IEnumMediaTypes_Next_Proxy(byval This as IEnumMediaTypes ptr, byval cMediaTypes as ULONG, byval ppMediaTypes as AM_MEDIA_TYPE ptr ptr, byval pcFetched as ULONG ptr) as HRESULT
declare sub IEnumMediaTypes_Next_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumMediaTypes_Skip_Proxy(byval This as IEnumMediaTypes ptr, byval cMediaTypes as ULONG) as HRESULT
declare sub IEnumMediaTypes_Skip_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumMediaTypes_Reset_Proxy(byval This as IEnumMediaTypes ptr) as HRESULT
declare sub IEnumMediaTypes_Reset_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumMediaTypes_Clone_Proxy(byval This as IEnumMediaTypes ptr, byval ppEnum as IEnumMediaTypes ptr ptr) as HRESULT
declare sub IEnumMediaTypes_Clone_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type PENUMMEDIATYPES as IEnumMediaTypes ptr

#define __IFilterGraph_INTERFACE_DEFINED__

extern IID_IFilterGraph as const GUID

type IEnumFilters as IEnumFilters_
type IFilterGraph as IFilterGraph_

type IFilterGraphVtbl
	QueryInterface as function(byval This as IFilterGraph ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IFilterGraph ptr) as ULONG
	Release as function(byval This as IFilterGraph ptr) as ULONG
	AddFilter as function(byval This as IFilterGraph ptr, byval pFilter as IBaseFilter ptr, byval pName as LPCWSTR) as HRESULT
	RemoveFilter as function(byval This as IFilterGraph ptr, byval pFilter as IBaseFilter ptr) as HRESULT
	EnumFilters as function(byval This as IFilterGraph ptr, byval ppEnum as IEnumFilters ptr ptr) as HRESULT
	FindFilterByName as function(byval This as IFilterGraph ptr, byval pName as LPCWSTR, byval ppFilter as IBaseFilter ptr ptr) as HRESULT
	ConnectDirect as function(byval This as IFilterGraph ptr, byval ppinOut as IPin ptr, byval ppinIn as IPin ptr, byval pmt as const AM_MEDIA_TYPE ptr) as HRESULT
	Reconnect as function(byval This as IFilterGraph ptr, byval ppin as IPin ptr) as HRESULT
	Disconnect as function(byval This as IFilterGraph ptr, byval ppin as IPin ptr) as HRESULT
	SetDefaultSyncSource as function(byval This as IFilterGraph ptr) as HRESULT
end type

type IFilterGraph_
	lpVtbl as IFilterGraphVtbl ptr
end type

declare function IFilterGraph_AddFilter_Proxy(byval This as IFilterGraph ptr, byval pFilter as IBaseFilter ptr, byval pName as LPCWSTR) as HRESULT
declare sub IFilterGraph_AddFilter_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFilterGraph_RemoveFilter_Proxy(byval This as IFilterGraph ptr, byval pFilter as IBaseFilter ptr) as HRESULT
declare sub IFilterGraph_RemoveFilter_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFilterGraph_EnumFilters_Proxy(byval This as IFilterGraph ptr, byval ppEnum as IEnumFilters ptr ptr) as HRESULT
declare sub IFilterGraph_EnumFilters_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFilterGraph_FindFilterByName_Proxy(byval This as IFilterGraph ptr, byval pName as LPCWSTR, byval ppFilter as IBaseFilter ptr ptr) as HRESULT
declare sub IFilterGraph_FindFilterByName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFilterGraph_ConnectDirect_Proxy(byval This as IFilterGraph ptr, byval ppinOut as IPin ptr, byval ppinIn as IPin ptr, byval pmt as const AM_MEDIA_TYPE ptr) as HRESULT
declare sub IFilterGraph_ConnectDirect_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFilterGraph_Reconnect_Proxy(byval This as IFilterGraph ptr, byval ppin as IPin ptr) as HRESULT
declare sub IFilterGraph_Reconnect_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFilterGraph_Disconnect_Proxy(byval This as IFilterGraph ptr, byval ppin as IPin ptr) as HRESULT
declare sub IFilterGraph_Disconnect_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFilterGraph_SetDefaultSyncSource_Proxy(byval This as IFilterGraph ptr) as HRESULT
declare sub IFilterGraph_SetDefaultSyncSource_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type PFILTERGRAPH as IFilterGraph ptr

#define __IEnumFilters_INTERFACE_DEFINED__

extern IID_IEnumFilters as const GUID

type IEnumFiltersVtbl
	QueryInterface as function(byval This as IEnumFilters ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEnumFilters ptr) as ULONG
	Release as function(byval This as IEnumFilters ptr) as ULONG
	Next as function(byval This as IEnumFilters ptr, byval cFilters as ULONG, byval ppFilter as IBaseFilter ptr ptr, byval pcFetched as ULONG ptr) as HRESULT
	Skip as function(byval This as IEnumFilters ptr, byval cFilters as ULONG) as HRESULT
	Reset as function(byval This as IEnumFilters ptr) as HRESULT
	Clone as function(byval This as IEnumFilters ptr, byval ppEnum as IEnumFilters ptr ptr) as HRESULT
end type

type IEnumFilters_
	lpVtbl as IEnumFiltersVtbl ptr
end type

declare function IEnumFilters_Next_Proxy(byval This as IEnumFilters ptr, byval cFilters as ULONG, byval ppFilter as IBaseFilter ptr ptr, byval pcFetched as ULONG ptr) as HRESULT
declare sub IEnumFilters_Next_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumFilters_Skip_Proxy(byval This as IEnumFilters ptr, byval cFilters as ULONG) as HRESULT
declare sub IEnumFilters_Skip_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumFilters_Reset_Proxy(byval This as IEnumFilters ptr) as HRESULT
declare sub IEnumFilters_Reset_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumFilters_Clone_Proxy(byval This as IEnumFilters ptr, byval ppEnum as IEnumFilters ptr ptr) as HRESULT
declare sub IEnumFilters_Clone_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type PENUMFILTERS as IEnumFilters ptr

#define __IMediaFilter_INTERFACE_DEFINED__

type _FilterState as long
enum
	State_Stopped = 0
	State_Paused = 1
	State_Running = 2
end enum

type FILTER_STATE as _FilterState

extern IID_IMediaFilter as const GUID

type IReferenceClock as IReferenceClock_
type IMediaFilter as IMediaFilter_

type IMediaFilterVtbl
	QueryInterface as function(byval This as IMediaFilter ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IMediaFilter ptr) as ULONG
	Release as function(byval This as IMediaFilter ptr) as ULONG
	GetClassID as function(byval This as IMediaFilter ptr, byval pClassID as CLSID ptr) as HRESULT
	Stop as function(byval This as IMediaFilter ptr) as HRESULT
	Pause as function(byval This as IMediaFilter ptr) as HRESULT
	Run as function(byval This as IMediaFilter ptr, byval tStart as REFERENCE_TIME) as HRESULT
	GetState as function(byval This as IMediaFilter ptr, byval dwMilliSecsTimeout as DWORD, byval State as FILTER_STATE ptr) as HRESULT
	SetSyncSource as function(byval This as IMediaFilter ptr, byval pClock as IReferenceClock ptr) as HRESULT
	GetSyncSource as function(byval This as IMediaFilter ptr, byval pClock as IReferenceClock ptr ptr) as HRESULT
end type

type IMediaFilter_
	lpVtbl as IMediaFilterVtbl ptr
end type

declare function IMediaFilter_Stop_Proxy(byval This as IMediaFilter ptr) as HRESULT
declare sub IMediaFilter_Stop_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaFilter_Pause_Proxy(byval This as IMediaFilter ptr) as HRESULT
declare sub IMediaFilter_Pause_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaFilter_Run_Proxy(byval This as IMediaFilter ptr, byval tStart as REFERENCE_TIME) as HRESULT
declare sub IMediaFilter_Run_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaFilter_GetState_Proxy(byval This as IMediaFilter ptr, byval dwMilliSecsTimeout as DWORD, byval State as FILTER_STATE ptr) as HRESULT
declare sub IMediaFilter_GetState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaFilter_SetSyncSource_Proxy(byval This as IMediaFilter ptr, byval pClock as IReferenceClock ptr) as HRESULT
declare sub IMediaFilter_SetSyncSource_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaFilter_GetSyncSource_Proxy(byval This as IMediaFilter ptr, byval pClock as IReferenceClock ptr ptr) as HRESULT
declare sub IMediaFilter_GetSyncSource_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type PMEDIAFILTER as IMediaFilter ptr

#define __IBaseFilter_INTERFACE_DEFINED__

type _FilterInfo
	achName as wstring * 128
	pGraph as IFilterGraph ptr
end type

type FILTER_INFO as _FilterInfo

extern IID_IBaseFilter as const GUID

type IBaseFilterVtbl
	QueryInterface as function(byval This as IBaseFilter ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IBaseFilter ptr) as ULONG
	Release as function(byval This as IBaseFilter ptr) as ULONG
	GetClassID as function(byval This as IBaseFilter ptr, byval pClassID as CLSID ptr) as HRESULT
	Stop as function(byval This as IBaseFilter ptr) as HRESULT
	Pause as function(byval This as IBaseFilter ptr) as HRESULT
	Run as function(byval This as IBaseFilter ptr, byval tStart as REFERENCE_TIME) as HRESULT
	GetState as function(byval This as IBaseFilter ptr, byval dwMilliSecsTimeout as DWORD, byval State as FILTER_STATE ptr) as HRESULT
	SetSyncSource as function(byval This as IBaseFilter ptr, byval pClock as IReferenceClock ptr) as HRESULT
	GetSyncSource as function(byval This as IBaseFilter ptr, byval pClock as IReferenceClock ptr ptr) as HRESULT
	EnumPins as function(byval This as IBaseFilter ptr, byval ppEnum as IEnumPins ptr ptr) as HRESULT
	FindPin as function(byval This as IBaseFilter ptr, byval Id as LPCWSTR, byval ppPin as IPin ptr ptr) as HRESULT
	QueryFilterInfo as function(byval This as IBaseFilter ptr, byval pInfo as FILTER_INFO ptr) as HRESULT
	JoinFilterGraph as function(byval This as IBaseFilter ptr, byval pGraph as IFilterGraph ptr, byval pName as LPCWSTR) as HRESULT
	QueryVendorInfo as function(byval This as IBaseFilter ptr, byval pVendorInfo as LPWSTR ptr) as HRESULT
end type

type IBaseFilter_
	lpVtbl as IBaseFilterVtbl ptr
end type

declare function IBaseFilter_EnumPins_Proxy(byval This as IBaseFilter ptr, byval ppEnum as IEnumPins ptr ptr) as HRESULT
declare sub IBaseFilter_EnumPins_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBaseFilter_FindPin_Proxy(byval This as IBaseFilter ptr, byval Id as LPCWSTR, byval ppPin as IPin ptr ptr) as HRESULT
declare sub IBaseFilter_FindPin_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBaseFilter_QueryFilterInfo_Proxy(byval This as IBaseFilter ptr, byval pInfo as FILTER_INFO ptr) as HRESULT
declare sub IBaseFilter_QueryFilterInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBaseFilter_JoinFilterGraph_Proxy(byval This as IBaseFilter ptr, byval pGraph as IFilterGraph ptr, byval pName as LPCWSTR) as HRESULT
declare sub IBaseFilter_JoinFilterGraph_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBaseFilter_QueryVendorInfo_Proxy(byval This as IBaseFilter ptr, byval pVendorInfo as LPWSTR ptr) as HRESULT
declare sub IBaseFilter_QueryVendorInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type PFILTER as IBaseFilter ptr

#define __IReferenceClock_INTERFACE_DEFINED__

extern IID_IReferenceClock as const GUID

type IReferenceClockVtbl
	QueryInterface as function(byval This as IReferenceClock ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IReferenceClock ptr) as ULONG
	Release as function(byval This as IReferenceClock ptr) as ULONG
	GetTime as function(byval This as IReferenceClock ptr, byval pTime as REFERENCE_TIME ptr) as HRESULT
	AdviseTime as function(byval This as IReferenceClock ptr, byval baseTime as REFERENCE_TIME, byval streamTime as REFERENCE_TIME, byval hEvent as HEVENT, byval pdwAdviseCookie as DWORD_PTR ptr) as HRESULT
	AdvisePeriodic as function(byval This as IReferenceClock ptr, byval startTime as REFERENCE_TIME, byval periodTime as REFERENCE_TIME, byval hSemaphore as HSEMAPHORE, byval pdwAdviseCookie as DWORD_PTR ptr) as HRESULT
	Unadvise as function(byval This as IReferenceClock ptr, byval dwAdviseCookie as DWORD_PTR) as HRESULT
end type

type IReferenceClock_
	lpVtbl as IReferenceClockVtbl ptr
end type

declare function IReferenceClock_GetTime_Proxy(byval This as IReferenceClock ptr, byval pTime as REFERENCE_TIME ptr) as HRESULT
declare sub IReferenceClock_GetTime_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IReferenceClock_AdviseTime_Proxy(byval This as IReferenceClock ptr, byval baseTime as REFERENCE_TIME, byval streamTime as REFERENCE_TIME, byval hEvent as HEVENT, byval pdwAdviseCookie as DWORD_PTR ptr) as HRESULT
declare sub IReferenceClock_AdviseTime_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IReferenceClock_AdvisePeriodic_Proxy(byval This as IReferenceClock ptr, byval startTime as REFERENCE_TIME, byval periodTime as REFERENCE_TIME, byval hSemaphore as HSEMAPHORE, byval pdwAdviseCookie as DWORD_PTR ptr) as HRESULT
declare sub IReferenceClock_AdvisePeriodic_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IReferenceClock_Unadvise_Proxy(byval This as IReferenceClock ptr, byval dwAdviseCookie as DWORD_PTR) as HRESULT
declare sub IReferenceClock_Unadvise_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type PREFERENCECLOCK as IReferenceClock ptr

#define __IMediaSample_INTERFACE_DEFINED__

extern IID_IMediaSample as const GUID

type IMediaSample as IMediaSample_

type IMediaSampleVtbl
	QueryInterface as function(byval This as IMediaSample ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IMediaSample ptr) as ULONG
	Release as function(byval This as IMediaSample ptr) as ULONG
	GetPointer as function(byval This as IMediaSample ptr, byval ppBuffer as UBYTE ptr ptr) as HRESULT
	GetSize as function(byval This as IMediaSample ptr) as LONG
	GetTime as function(byval This as IMediaSample ptr, byval pTimeStart as REFERENCE_TIME ptr, byval pTimeEnd as REFERENCE_TIME ptr) as HRESULT
	SetTime as function(byval This as IMediaSample ptr, byval pTimeStart as REFERENCE_TIME ptr, byval pTimeEnd as REFERENCE_TIME ptr) as HRESULT
	IsSyncPoint as function(byval This as IMediaSample ptr) as HRESULT
	SetSyncPoint as function(byval This as IMediaSample ptr, byval bIsSyncPoint as WINBOOL) as HRESULT
	IsPreroll as function(byval This as IMediaSample ptr) as HRESULT
	SetPreroll as function(byval This as IMediaSample ptr, byval bIsPreroll as WINBOOL) as HRESULT
	GetActualDataLength as function(byval This as IMediaSample ptr) as LONG
	SetActualDataLength as function(byval This as IMediaSample ptr, byval length as LONG) as HRESULT
	GetMediaType as function(byval This as IMediaSample ptr, byval ppMediaType as AM_MEDIA_TYPE ptr ptr) as HRESULT
	SetMediaType as function(byval This as IMediaSample ptr, byval pMediaType as AM_MEDIA_TYPE ptr) as HRESULT
	IsDiscontinuity as function(byval This as IMediaSample ptr) as HRESULT
	SetDiscontinuity as function(byval This as IMediaSample ptr, byval bDiscontinuity as WINBOOL) as HRESULT
	GetMediaTime as function(byval This as IMediaSample ptr, byval pTimeStart as LONGLONG ptr, byval pTimeEnd as LONGLONG ptr) as HRESULT
	SetMediaTime as function(byval This as IMediaSample ptr, byval pTimeStart as LONGLONG ptr, byval pTimeEnd as LONGLONG ptr) as HRESULT
end type

type IMediaSample_
	lpVtbl as IMediaSampleVtbl ptr
end type

declare function IMediaSample_GetPointer_Proxy(byval This as IMediaSample ptr, byval ppBuffer as UBYTE ptr ptr) as HRESULT
declare sub IMediaSample_GetPointer_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaSample_GetSize_Proxy(byval This as IMediaSample ptr) as LONG
declare sub IMediaSample_GetSize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaSample_GetTime_Proxy(byval This as IMediaSample ptr, byval pTimeStart as REFERENCE_TIME ptr, byval pTimeEnd as REFERENCE_TIME ptr) as HRESULT
declare sub IMediaSample_GetTime_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaSample_SetTime_Proxy(byval This as IMediaSample ptr, byval pTimeStart as REFERENCE_TIME ptr, byval pTimeEnd as REFERENCE_TIME ptr) as HRESULT
declare sub IMediaSample_SetTime_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaSample_IsSyncPoint_Proxy(byval This as IMediaSample ptr) as HRESULT
declare sub IMediaSample_IsSyncPoint_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaSample_SetSyncPoint_Proxy(byval This as IMediaSample ptr, byval bIsSyncPoint as WINBOOL) as HRESULT
declare sub IMediaSample_SetSyncPoint_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaSample_IsPreroll_Proxy(byval This as IMediaSample ptr) as HRESULT
declare sub IMediaSample_IsPreroll_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaSample_SetPreroll_Proxy(byval This as IMediaSample ptr, byval bIsPreroll as WINBOOL) as HRESULT
declare sub IMediaSample_SetPreroll_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaSample_GetActualDataLength_Proxy(byval This as IMediaSample ptr) as LONG
declare sub IMediaSample_GetActualDataLength_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaSample_SetActualDataLength_Proxy(byval This as IMediaSample ptr, byval length as LONG) as HRESULT
declare sub IMediaSample_SetActualDataLength_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaSample_GetMediaType_Proxy(byval This as IMediaSample ptr, byval ppMediaType as AM_MEDIA_TYPE ptr ptr) as HRESULT
declare sub IMediaSample_GetMediaType_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaSample_SetMediaType_Proxy(byval This as IMediaSample ptr, byval pMediaType as AM_MEDIA_TYPE ptr) as HRESULT
declare sub IMediaSample_SetMediaType_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaSample_IsDiscontinuity_Proxy(byval This as IMediaSample ptr) as HRESULT
declare sub IMediaSample_IsDiscontinuity_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaSample_SetDiscontinuity_Proxy(byval This as IMediaSample ptr, byval bDiscontinuity as WINBOOL) as HRESULT
declare sub IMediaSample_SetDiscontinuity_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaSample_GetMediaTime_Proxy(byval This as IMediaSample ptr, byval pTimeStart as LONGLONG ptr, byval pTimeEnd as LONGLONG ptr) as HRESULT
declare sub IMediaSample_GetMediaTime_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaSample_SetMediaTime_Proxy(byval This as IMediaSample ptr, byval pTimeStart as LONGLONG ptr, byval pTimeEnd as LONGLONG ptr) as HRESULT
declare sub IMediaSample_SetMediaTime_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type PMEDIASAMPLE as IMediaSample ptr

type tagAM_SAMPLE_PROPERTY_FLAGS as long
enum
	AM_SAMPLE_SPLICEPOINT = &h1
	AM_SAMPLE_PREROLL = &h2
	AM_SAMPLE_DATADISCONTINUITY = &h4
	AM_SAMPLE_TYPECHANGED = &h8
	AM_SAMPLE_TIMEVALID = &h10
	AM_SAMPLE_TIMEDISCONTINUITY = &h40
	AM_SAMPLE_FLUSH_ON_PAUSE = &h80
	AM_SAMPLE_STOPVALID = &h100
	AM_SAMPLE_ENDOFSTREAM = &h200
	AM_STREAM_MEDIA = 0
	AM_STREAM_CONTROL = 1
end enum

type tagAM_SAMPLE2_PROPERTIES
	cbData as DWORD
	dwTypeSpecificFlags as DWORD
	dwSampleFlags as DWORD
	lActual as LONG
	tStart as REFERENCE_TIME
	tStop as REFERENCE_TIME
	dwStreamId as DWORD
	pMediaType as AM_MEDIA_TYPE ptr
	pbBuffer as UBYTE ptr
	cbBuffer as LONG
end type

type AM_SAMPLE2_PROPERTIES as tagAM_SAMPLE2_PROPERTIES

#define __IMediaSample2_INTERFACE_DEFINED__

extern IID_IMediaSample2 as const GUID

type IMediaSample2 as IMediaSample2_

type IMediaSample2Vtbl
	QueryInterface as function(byval This as IMediaSample2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IMediaSample2 ptr) as ULONG
	Release as function(byval This as IMediaSample2 ptr) as ULONG
	GetPointer as function(byval This as IMediaSample2 ptr, byval ppBuffer as UBYTE ptr ptr) as HRESULT
	GetSize as function(byval This as IMediaSample2 ptr) as LONG
	GetTime as function(byval This as IMediaSample2 ptr, byval pTimeStart as REFERENCE_TIME ptr, byval pTimeEnd as REFERENCE_TIME ptr) as HRESULT
	SetTime as function(byval This as IMediaSample2 ptr, byval pTimeStart as REFERENCE_TIME ptr, byval pTimeEnd as REFERENCE_TIME ptr) as HRESULT
	IsSyncPoint as function(byval This as IMediaSample2 ptr) as HRESULT
	SetSyncPoint as function(byval This as IMediaSample2 ptr, byval bIsSyncPoint as WINBOOL) as HRESULT
	IsPreroll as function(byval This as IMediaSample2 ptr) as HRESULT
	SetPreroll as function(byval This as IMediaSample2 ptr, byval bIsPreroll as WINBOOL) as HRESULT
	GetActualDataLength as function(byval This as IMediaSample2 ptr) as LONG
	SetActualDataLength as function(byval This as IMediaSample2 ptr, byval length as LONG) as HRESULT
	GetMediaType as function(byval This as IMediaSample2 ptr, byval ppMediaType as AM_MEDIA_TYPE ptr ptr) as HRESULT
	SetMediaType as function(byval This as IMediaSample2 ptr, byval pMediaType as AM_MEDIA_TYPE ptr) as HRESULT
	IsDiscontinuity as function(byval This as IMediaSample2 ptr) as HRESULT
	SetDiscontinuity as function(byval This as IMediaSample2 ptr, byval bDiscontinuity as WINBOOL) as HRESULT
	GetMediaTime as function(byval This as IMediaSample2 ptr, byval pTimeStart as LONGLONG ptr, byval pTimeEnd as LONGLONG ptr) as HRESULT
	SetMediaTime as function(byval This as IMediaSample2 ptr, byval pTimeStart as LONGLONG ptr, byval pTimeEnd as LONGLONG ptr) as HRESULT
	GetProperties as function(byval This as IMediaSample2 ptr, byval cbProperties as DWORD, byval pbProperties as UBYTE ptr) as HRESULT
	SetProperties as function(byval This as IMediaSample2 ptr, byval cbProperties as DWORD, byval pbProperties as const UBYTE ptr) as HRESULT
end type

type IMediaSample2_
	lpVtbl as IMediaSample2Vtbl ptr
end type

declare function IMediaSample2_GetProperties_Proxy(byval This as IMediaSample2 ptr, byval cbProperties as DWORD, byval pbProperties as UBYTE ptr) as HRESULT
declare sub IMediaSample2_GetProperties_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaSample2_SetProperties_Proxy(byval This as IMediaSample2 ptr, byval cbProperties as DWORD, byval pbProperties as const UBYTE ptr) as HRESULT
declare sub IMediaSample2_SetProperties_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type PMEDIASAMPLE2 as IMediaSample2 ptr

#define AM_GBF_PREVFRAMESKIPPED 1
#define AM_GBF_NOTASYNCPOINT 2
#define AM_GBF_NOWAIT 4
#define AM_GBF_NODDSURFACELOCK 8
#define __IMemAllocator_INTERFACE_DEFINED__

extern IID_IMemAllocator as const GUID

type IMemAllocator as IMemAllocator_

type IMemAllocatorVtbl
	QueryInterface as function(byval This as IMemAllocator ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IMemAllocator ptr) as ULONG
	Release as function(byval This as IMemAllocator ptr) as ULONG
	SetProperties as function(byval This as IMemAllocator ptr, byval pRequest as ALLOCATOR_PROPERTIES ptr, byval pActual as ALLOCATOR_PROPERTIES ptr) as HRESULT
	GetProperties as function(byval This as IMemAllocator ptr, byval pProps as ALLOCATOR_PROPERTIES ptr) as HRESULT
	Commit as function(byval This as IMemAllocator ptr) as HRESULT
	Decommit as function(byval This as IMemAllocator ptr) as HRESULT
	GetBuffer as function(byval This as IMemAllocator ptr, byval ppBuffer as IMediaSample ptr ptr, byval pStartTime as REFERENCE_TIME ptr, byval pEndTime as REFERENCE_TIME ptr, byval dwFlags as DWORD) as HRESULT
	ReleaseBuffer as function(byval This as IMemAllocator ptr, byval pBuffer as IMediaSample ptr) as HRESULT
end type

type IMemAllocator_
	lpVtbl as IMemAllocatorVtbl ptr
end type

declare function IMemAllocator_SetProperties_Proxy(byval This as IMemAllocator ptr, byval pRequest as ALLOCATOR_PROPERTIES ptr, byval pActual as ALLOCATOR_PROPERTIES ptr) as HRESULT
declare sub IMemAllocator_SetProperties_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMemAllocator_GetProperties_Proxy(byval This as IMemAllocator ptr, byval pProps as ALLOCATOR_PROPERTIES ptr) as HRESULT
declare sub IMemAllocator_GetProperties_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMemAllocator_Commit_Proxy(byval This as IMemAllocator ptr) as HRESULT
declare sub IMemAllocator_Commit_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMemAllocator_Decommit_Proxy(byval This as IMemAllocator ptr) as HRESULT
declare sub IMemAllocator_Decommit_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMemAllocator_GetBuffer_Proxy(byval This as IMemAllocator ptr, byval ppBuffer as IMediaSample ptr ptr, byval pStartTime as REFERENCE_TIME ptr, byval pEndTime as REFERENCE_TIME ptr, byval dwFlags as DWORD) as HRESULT
declare sub IMemAllocator_GetBuffer_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMemAllocator_ReleaseBuffer_Proxy(byval This as IMemAllocator ptr, byval pBuffer as IMediaSample ptr) as HRESULT
declare sub IMemAllocator_ReleaseBuffer_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type PMEMALLOCATOR as IMemAllocator ptr

#define __IMemAllocatorCallbackTemp_INTERFACE_DEFINED__

extern IID_IMemAllocatorCallbackTemp as const GUID

type IMemAllocatorNotifyCallbackTemp as IMemAllocatorNotifyCallbackTemp_
type IMemAllocatorCallbackTemp as IMemAllocatorCallbackTemp_

type IMemAllocatorCallbackTempVtbl
	QueryInterface as function(byval This as IMemAllocatorCallbackTemp ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IMemAllocatorCallbackTemp ptr) as ULONG
	Release as function(byval This as IMemAllocatorCallbackTemp ptr) as ULONG
	SetProperties as function(byval This as IMemAllocatorCallbackTemp ptr, byval pRequest as ALLOCATOR_PROPERTIES ptr, byval pActual as ALLOCATOR_PROPERTIES ptr) as HRESULT
	GetProperties as function(byval This as IMemAllocatorCallbackTemp ptr, byval pProps as ALLOCATOR_PROPERTIES ptr) as HRESULT
	Commit as function(byval This as IMemAllocatorCallbackTemp ptr) as HRESULT
	Decommit as function(byval This as IMemAllocatorCallbackTemp ptr) as HRESULT
	GetBuffer as function(byval This as IMemAllocatorCallbackTemp ptr, byval ppBuffer as IMediaSample ptr ptr, byval pStartTime as REFERENCE_TIME ptr, byval pEndTime as REFERENCE_TIME ptr, byval dwFlags as DWORD) as HRESULT
	ReleaseBuffer as function(byval This as IMemAllocatorCallbackTemp ptr, byval pBuffer as IMediaSample ptr) as HRESULT
	SetNotify as function(byval This as IMemAllocatorCallbackTemp ptr, byval pNotify as IMemAllocatorNotifyCallbackTemp ptr) as HRESULT
	GetFreeCount as function(byval This as IMemAllocatorCallbackTemp ptr, byval plBuffersFree as LONG ptr) as HRESULT
end type

type IMemAllocatorCallbackTemp_
	lpVtbl as IMemAllocatorCallbackTempVtbl ptr
end type

declare function IMemAllocatorCallbackTemp_SetNotify_Proxy(byval This as IMemAllocatorCallbackTemp ptr, byval pNotify as IMemAllocatorNotifyCallbackTemp ptr) as HRESULT
declare sub IMemAllocatorCallbackTemp_SetNotify_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMemAllocatorCallbackTemp_GetFreeCount_Proxy(byval This as IMemAllocatorCallbackTemp ptr, byval plBuffersFree as LONG ptr) as HRESULT
declare sub IMemAllocatorCallbackTemp_GetFreeCount_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IMemAllocatorNotifyCallbackTemp_INTERFACE_DEFINED__

extern IID_IMemAllocatorNotifyCallbackTemp as const GUID

type IMemAllocatorNotifyCallbackTempVtbl
	QueryInterface as function(byval This as IMemAllocatorNotifyCallbackTemp ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IMemAllocatorNotifyCallbackTemp ptr) as ULONG
	Release as function(byval This as IMemAllocatorNotifyCallbackTemp ptr) as ULONG
	NotifyRelease as function(byval This as IMemAllocatorNotifyCallbackTemp ptr) as HRESULT
end type

type IMemAllocatorNotifyCallbackTemp_
	lpVtbl as IMemAllocatorNotifyCallbackTempVtbl ptr
end type

declare function IMemAllocatorNotifyCallbackTemp_NotifyRelease_Proxy(byval This as IMemAllocatorNotifyCallbackTemp ptr) as HRESULT
declare sub IMemAllocatorNotifyCallbackTemp_NotifyRelease_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IMemInputPin_INTERFACE_DEFINED__

extern IID_IMemInputPin as const GUID

type IMemInputPin as IMemInputPin_

type IMemInputPinVtbl
	QueryInterface as function(byval This as IMemInputPin ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IMemInputPin ptr) as ULONG
	Release as function(byval This as IMemInputPin ptr) as ULONG
	GetAllocator as function(byval This as IMemInputPin ptr, byval ppAllocator as IMemAllocator ptr ptr) as HRESULT
	NotifyAllocator as function(byval This as IMemInputPin ptr, byval pAllocator as IMemAllocator ptr, byval bReadOnly as WINBOOL) as HRESULT
	GetAllocatorRequirements as function(byval This as IMemInputPin ptr, byval pProps as ALLOCATOR_PROPERTIES ptr) as HRESULT
	Receive as function(byval This as IMemInputPin ptr, byval pSample as IMediaSample ptr) as HRESULT
	ReceiveMultiple as function(byval This as IMemInputPin ptr, byval pSamples as IMediaSample ptr ptr, byval nSamples as LONG, byval nSamplesProcessed as LONG ptr) as HRESULT
	ReceiveCanBlock as function(byval This as IMemInputPin ptr) as HRESULT
end type

type IMemInputPin_
	lpVtbl as IMemInputPinVtbl ptr
end type

declare function IMemInputPin_GetAllocator_Proxy(byval This as IMemInputPin ptr, byval ppAllocator as IMemAllocator ptr ptr) as HRESULT
declare sub IMemInputPin_GetAllocator_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMemInputPin_NotifyAllocator_Proxy(byval This as IMemInputPin ptr, byval pAllocator as IMemAllocator ptr, byval bReadOnly as WINBOOL) as HRESULT
declare sub IMemInputPin_NotifyAllocator_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMemInputPin_GetAllocatorRequirements_Proxy(byval This as IMemInputPin ptr, byval pProps as ALLOCATOR_PROPERTIES ptr) as HRESULT
declare sub IMemInputPin_GetAllocatorRequirements_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMemInputPin_Receive_Proxy(byval This as IMemInputPin ptr, byval pSample as IMediaSample ptr) as HRESULT
declare sub IMemInputPin_Receive_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMemInputPin_ReceiveMultiple_Proxy(byval This as IMemInputPin ptr, byval pSamples as IMediaSample ptr ptr, byval nSamples as LONG, byval nSamplesProcessed as LONG ptr) as HRESULT
declare sub IMemInputPin_ReceiveMultiple_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMemInputPin_ReceiveCanBlock_Proxy(byval This as IMemInputPin ptr) as HRESULT
declare sub IMemInputPin_ReceiveCanBlock_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type PMEMINPUTPIN as IMemInputPin ptr

#define __IAMovieSetup_INTERFACE_DEFINED__

extern IID_IAMovieSetup as const GUID

type IAMovieSetup as IAMovieSetup_

type IAMovieSetupVtbl
	QueryInterface as function(byval This as IAMovieSetup ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMovieSetup ptr) as ULONG
	Release as function(byval This as IAMovieSetup ptr) as ULONG
	Register as function(byval This as IAMovieSetup ptr) as HRESULT
	Unregister as function(byval This as IAMovieSetup ptr) as HRESULT
end type

type IAMovieSetup_
	lpVtbl as IAMovieSetupVtbl ptr
end type

declare function IAMovieSetup_Register_Proxy(byval This as IAMovieSetup ptr) as HRESULT
declare sub IAMovieSetup_Register_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAMovieSetup_Unregister_Proxy(byval This as IAMovieSetup ptr) as HRESULT
declare sub IAMovieSetup_Unregister_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type PAMOVIESETUP as IAMovieSetup ptr

type AM_SEEKING_SeekingFlags as long
enum
	AM_SEEKING_NoPositioning = &h0
	AM_SEEKING_AbsolutePositioning = &h1
	AM_SEEKING_RelativePositioning = &h2
	AM_SEEKING_IncrementalPositioning = &h3
	AM_SEEKING_PositioningBitsMask = &h3
	AM_SEEKING_SeekToKeyFrame = &h4
	AM_SEEKING_ReturnTime = &h8
	AM_SEEKING_Segment = &h10
	AM_SEEKING_NoFlush = &h20
end enum

type AM_SEEKING_SEEKING_FLAGS as AM_SEEKING_SeekingFlags

type AM_SEEKING_SeekingCapabilities as long
enum
	AM_SEEKING_CanSeekAbsolute = &h1
	AM_SEEKING_CanSeekForwards = &h2
	AM_SEEKING_CanSeekBackwards = &h4
	AM_SEEKING_CanGetCurrentPos = &h8
	AM_SEEKING_CanGetStopPos = &h10
	AM_SEEKING_CanGetDuration = &h20
	AM_SEEKING_CanPlayBackwards = &h40
	AM_SEEKING_CanDoSegments = &h80
	AM_SEEKING_Source = &h100
end enum

type AM_SEEKING_SEEKING_CAPABILITIES as AM_SEEKING_SeekingCapabilities

#define __IMediaSeeking_INTERFACE_DEFINED__

extern IID_IMediaSeeking as const GUID

type IMediaSeeking as IMediaSeeking_

type IMediaSeekingVtbl
	QueryInterface as function(byval This as IMediaSeeking ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IMediaSeeking ptr) as ULONG
	Release as function(byval This as IMediaSeeking ptr) as ULONG
	GetCapabilities as function(byval This as IMediaSeeking ptr, byval pCapabilities as DWORD ptr) as HRESULT
	CheckCapabilities as function(byval This as IMediaSeeking ptr, byval pCapabilities as DWORD ptr) as HRESULT
	IsFormatSupported as function(byval This as IMediaSeeking ptr, byval pFormat as const GUID ptr) as HRESULT
	QueryPreferredFormat as function(byval This as IMediaSeeking ptr, byval pFormat as GUID ptr) as HRESULT
	GetTimeFormat as function(byval This as IMediaSeeking ptr, byval pFormat as GUID ptr) as HRESULT
	IsUsingTimeFormat as function(byval This as IMediaSeeking ptr, byval pFormat as const GUID ptr) as HRESULT
	SetTimeFormat as function(byval This as IMediaSeeking ptr, byval pFormat as const GUID ptr) as HRESULT
	GetDuration as function(byval This as IMediaSeeking ptr, byval pDuration as LONGLONG ptr) as HRESULT
	GetStopPosition as function(byval This as IMediaSeeking ptr, byval pStop as LONGLONG ptr) as HRESULT
	GetCurrentPosition as function(byval This as IMediaSeeking ptr, byval pCurrent as LONGLONG ptr) as HRESULT
	ConvertTimeFormat as function(byval This as IMediaSeeking ptr, byval pTarget as LONGLONG ptr, byval pTargetFormat as const GUID ptr, byval Source as LONGLONG, byval pSourceFormat as const GUID ptr) as HRESULT
	SetPositions as function(byval This as IMediaSeeking ptr, byval pCurrent as LONGLONG ptr, byval dwCurrentFlags as DWORD, byval pStop as LONGLONG ptr, byval dwStopFlags as DWORD) as HRESULT
	GetPositions as function(byval This as IMediaSeeking ptr, byval pCurrent as LONGLONG ptr, byval pStop as LONGLONG ptr) as HRESULT
	GetAvailable as function(byval This as IMediaSeeking ptr, byval pEarliest as LONGLONG ptr, byval pLatest as LONGLONG ptr) as HRESULT
	SetRate as function(byval This as IMediaSeeking ptr, byval dRate as double) as HRESULT
	GetRate as function(byval This as IMediaSeeking ptr, byval pdRate as double ptr) as HRESULT
	GetPreroll as function(byval This as IMediaSeeking ptr, byval pllPreroll as LONGLONG ptr) as HRESULT
end type

type IMediaSeeking_
	lpVtbl as IMediaSeekingVtbl ptr
end type

declare function IMediaSeeking_GetCapabilities_Proxy(byval This as IMediaSeeking ptr, byval pCapabilities as DWORD ptr) as HRESULT
declare sub IMediaSeeking_GetCapabilities_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaSeeking_CheckCapabilities_Proxy(byval This as IMediaSeeking ptr, byval pCapabilities as DWORD ptr) as HRESULT
declare sub IMediaSeeking_CheckCapabilities_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaSeeking_IsFormatSupported_Proxy(byval This as IMediaSeeking ptr, byval pFormat as const GUID ptr) as HRESULT
declare sub IMediaSeeking_IsFormatSupported_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaSeeking_QueryPreferredFormat_Proxy(byval This as IMediaSeeking ptr, byval pFormat as GUID ptr) as HRESULT
declare sub IMediaSeeking_QueryPreferredFormat_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaSeeking_GetTimeFormat_Proxy(byval This as IMediaSeeking ptr, byval pFormat as GUID ptr) as HRESULT
declare sub IMediaSeeking_GetTimeFormat_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaSeeking_IsUsingTimeFormat_Proxy(byval This as IMediaSeeking ptr, byval pFormat as const GUID ptr) as HRESULT
declare sub IMediaSeeking_IsUsingTimeFormat_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaSeeking_SetTimeFormat_Proxy(byval This as IMediaSeeking ptr, byval pFormat as const GUID ptr) as HRESULT
declare sub IMediaSeeking_SetTimeFormat_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaSeeking_GetDuration_Proxy(byval This as IMediaSeeking ptr, byval pDuration as LONGLONG ptr) as HRESULT
declare sub IMediaSeeking_GetDuration_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaSeeking_GetStopPosition_Proxy(byval This as IMediaSeeking ptr, byval pStop as LONGLONG ptr) as HRESULT
declare sub IMediaSeeking_GetStopPosition_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaSeeking_GetCurrentPosition_Proxy(byval This as IMediaSeeking ptr, byval pCurrent as LONGLONG ptr) as HRESULT
declare sub IMediaSeeking_GetCurrentPosition_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaSeeking_ConvertTimeFormat_Proxy(byval This as IMediaSeeking ptr, byval pTarget as LONGLONG ptr, byval pTargetFormat as const GUID ptr, byval Source as LONGLONG, byval pSourceFormat as const GUID ptr) as HRESULT
declare sub IMediaSeeking_ConvertTimeFormat_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaSeeking_SetPositions_Proxy(byval This as IMediaSeeking ptr, byval pCurrent as LONGLONG ptr, byval dwCurrentFlags as DWORD, byval pStop as LONGLONG ptr, byval dwStopFlags as DWORD) as HRESULT
declare sub IMediaSeeking_SetPositions_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaSeeking_GetPositions_Proxy(byval This as IMediaSeeking ptr, byval pCurrent as LONGLONG ptr, byval pStop as LONGLONG ptr) as HRESULT
declare sub IMediaSeeking_GetPositions_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaSeeking_GetAvailable_Proxy(byval This as IMediaSeeking ptr, byval pEarliest as LONGLONG ptr, byval pLatest as LONGLONG ptr) as HRESULT
declare sub IMediaSeeking_GetAvailable_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaSeeking_SetRate_Proxy(byval This as IMediaSeeking ptr, byval dRate as double) as HRESULT
declare sub IMediaSeeking_SetRate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaSeeking_GetRate_Proxy(byval This as IMediaSeeking ptr, byval pdRate as double ptr) as HRESULT
declare sub IMediaSeeking_GetRate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMediaSeeking_GetPreroll_Proxy(byval This as IMediaSeeking ptr, byval pllPreroll as LONGLONG ptr) as HRESULT
declare sub IMediaSeeking_GetPreroll_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type PMEDIASEEKING as IMediaSeeking ptr

type tagAM_MEDIAEVENT_FLAGS as long
enum
	AM_MEDIAEVENT_NONOTIFY = &h1
end enum

#define __IAMAnalogVideoDecoder_FWD_DEFINED__
#define __IAMAnalogVideoEncoder_FWD_DEFINED__
#define __IAMAudioInputMixer_FWD_DEFINED__
#define __IAMAudioRendererStats_FWD_DEFINED__
#define __IAMBufferNegotiation_FWD_DEFINED__
#define __IAMCameraControl_FWD_DEFINED__
#define __IAMCrossbar_FWD_DEFINED__
#define __IAMDevMemoryAllocator_FWD_DEFINED__
#define __IAMDevMemoryControl_FWD_DEFINED__
#define __IAMDroppedFrames_FWD_DEFINED__
#define __IAMExtDevice_FWD_DEFINED__
#define __IAMExtTransport_FWD_DEFINED__
#define __IAMGraphStreams_FWD_DEFINED__
#define __IAMLatency_FWD_DEFINED__
#define __IAMOpenProgress_FWD_DEFINED__
#define __IAMOverlayFX_FWD_DEFINED__
#define __IAMPhysicalPinInfo_FWD_DEFINED__
#define __IAMPushSource_FWD_DEFINED__
#define __IAMTimecodeDisplay_FWD_DEFINED__
#define __IAMTimecodeGenerator_FWD_DEFINED__
#define __IAMTimecodeReader_FWD_DEFINED__
#define __IAMTVTuner_FWD_DEFINED__
#define __IAMVfwCaptureDialogs_FWD_DEFINED__
#define __IAMVfwCompressDialogs_FWD_DEFINED__
#define __IAMVideoCompression_FWD_DEFINED__
#define __IAMVideoDecimationProperties_FWD_DEFINED__
#define __IConfigAviMux_FWD_DEFINED__
#define __IConfigInterleaving_FWD_DEFINED__
#define __IDecimateVideoImage_FWD_DEFINED__
#define __IDrawVideoImage_FWD_DEFINED__
#define __IEnumStreamIdMap_FWD_DEFINED__
#define __IMpeg2Demultiplexer_FWD_DEFINED__
#define __IMPEG2StreamIdMap_FWD_DEFINED__

type __WIDL_axextend_generated_name_00000000
	Clsid as CLSID
	Name as LPWSTR
end type

type REGFILTER as __WIDL_axextend_generated_name_00000000

#define __IEnumRegFilters_INTERFACE_DEFINED__

extern IID_IEnumRegFilters as const GUID

type IEnumRegFilters as IEnumRegFilters_

type IEnumRegFiltersVtbl
	QueryInterface as function(byval This as IEnumRegFilters ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEnumRegFilters ptr) as ULONG
	Release as function(byval This as IEnumRegFilters ptr) as ULONG
	Next as function(byval This as IEnumRegFilters ptr, byval cFilters as ULONG, byval apRegFilter as REGFILTER ptr ptr, byval pcFetched as ULONG ptr) as HRESULT
	Skip as function(byval This as IEnumRegFilters ptr, byval cFilters as ULONG) as HRESULT
	Reset as function(byval This as IEnumRegFilters ptr) as HRESULT
	Clone as function(byval This as IEnumRegFilters ptr, byval ppEnum as IEnumRegFilters ptr ptr) as HRESULT
end type

type IEnumRegFilters_
	lpVtbl as IEnumRegFiltersVtbl ptr
end type

declare function IEnumRegFilters_Next_Proxy(byval This as IEnumRegFilters ptr, byval cFilters as ULONG, byval apRegFilter as REGFILTER ptr ptr, byval pcFetched as ULONG ptr) as HRESULT
declare sub IEnumRegFilters_Next_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumRegFilters_Skip_Proxy(byval This as IEnumRegFilters ptr, byval cFilters as ULONG) as HRESULT
declare sub IEnumRegFilters_Skip_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumRegFilters_Reset_Proxy(byval This as IEnumRegFilters ptr) as HRESULT
declare sub IEnumRegFilters_Reset_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumRegFilters_Clone_Proxy(byval This as IEnumRegFilters ptr, byval ppEnum as IEnumRegFilters ptr ptr) as HRESULT
declare sub IEnumRegFilters_Clone_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type PENUMREGFILTERS as IEnumRegFilters ptr

#define __IFilterMapper_INTERFACE_DEFINED__

enum
	MERIT_PREFERRED = &h800000
	MERIT_NORMAL = &h600000
	MERIT_UNLIKELY = &h400000
	MERIT_DO_NOT_USE = &h200000
	MERIT_SW_COMPRESSOR = &h100000
	MERIT_HW_COMPRESSOR = &h100050
end enum

extern IID_IFilterMapper as const GUID

type IFilterMapper as IFilterMapper_

type IFilterMapperVtbl
	QueryInterface as function(byval This as IFilterMapper ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IFilterMapper ptr) as ULONG
	Release as function(byval This as IFilterMapper ptr) as ULONG
	RegisterFilter as function(byval This as IFilterMapper ptr, byval clsid as CLSID, byval Name as LPCWSTR, byval dwMerit as DWORD) as HRESULT
	RegisterFilterInstance as function(byval This as IFilterMapper ptr, byval clsid as CLSID, byval Name as LPCWSTR, byval MRId as CLSID ptr) as HRESULT
	RegisterPin as function(byval This as IFilterMapper ptr, byval Filter as CLSID, byval Name as LPCWSTR, byval bRendered as WINBOOL, byval bOutput as WINBOOL, byval bZero as WINBOOL, byval bMany as WINBOOL, byval ConnectsToFilter as CLSID, byval ConnectsToPin as LPCWSTR) as HRESULT
	RegisterPinType as function(byval This as IFilterMapper ptr, byval clsFilter as CLSID, byval strName as LPCWSTR, byval clsMajorType as CLSID, byval clsSubType as CLSID) as HRESULT
	UnregisterFilter as function(byval This as IFilterMapper ptr, byval Filter as CLSID) as HRESULT
	UnregisterFilterInstance as function(byval This as IFilterMapper ptr, byval MRId as CLSID) as HRESULT
	UnregisterPin as function(byval This as IFilterMapper ptr, byval Filter as CLSID, byval Name as LPCWSTR) as HRESULT
	EnumMatchingFilters as function(byval This as IFilterMapper ptr, byval ppEnum as IEnumRegFilters ptr ptr, byval dwMerit as DWORD, byval bInputNeeded as WINBOOL, byval clsInMaj as CLSID, byval clsInSub as CLSID, byval bRender as WINBOOL, byval bOututNeeded as WINBOOL, byval clsOutMaj as CLSID, byval clsOutSub as CLSID) as HRESULT
end type

type IFilterMapper_
	lpVtbl as IFilterMapperVtbl ptr
end type

declare function IFilterMapper_RegisterFilter_Proxy(byval This as IFilterMapper ptr, byval clsid as CLSID, byval Name as LPCWSTR, byval dwMerit as DWORD) as HRESULT
declare sub IFilterMapper_RegisterFilter_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFilterMapper_RegisterFilterInstance_Proxy(byval This as IFilterMapper ptr, byval clsid as CLSID, byval Name as LPCWSTR, byval MRId as CLSID ptr) as HRESULT
declare sub IFilterMapper_RegisterFilterInstance_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFilterMapper_RegisterPin_Proxy(byval This as IFilterMapper ptr, byval Filter as CLSID, byval Name as LPCWSTR, byval bRendered as WINBOOL, byval bOutput as WINBOOL, byval bZero as WINBOOL, byval bMany as WINBOOL, byval ConnectsToFilter as CLSID, byval ConnectsToPin as LPCWSTR) as HRESULT
declare sub IFilterMapper_RegisterPin_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFilterMapper_RegisterPinType_Proxy(byval This as IFilterMapper ptr, byval clsFilter as CLSID, byval strName as LPCWSTR, byval clsMajorType as CLSID, byval clsSubType as CLSID) as HRESULT
declare sub IFilterMapper_RegisterPinType_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFilterMapper_UnregisterFilter_Proxy(byval This as IFilterMapper ptr, byval Filter as CLSID) as HRESULT
declare sub IFilterMapper_UnregisterFilter_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFilterMapper_UnregisterFilterInstance_Proxy(byval This as IFilterMapper ptr, byval MRId as CLSID) as HRESULT
declare sub IFilterMapper_UnregisterFilterInstance_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFilterMapper_UnregisterPin_Proxy(byval This as IFilterMapper ptr, byval Filter as CLSID, byval Name as LPCWSTR) as HRESULT
declare sub IFilterMapper_UnregisterPin_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFilterMapper_EnumMatchingFilters_Proxy(byval This as IFilterMapper ptr, byval ppEnum as IEnumRegFilters ptr ptr, byval dwMerit as DWORD, byval bInputNeeded as WINBOOL, byval clsInMaj as CLSID, byval clsInSub as CLSID, byval bRender as WINBOOL, byval bOututNeeded as WINBOOL, byval clsOutMaj as CLSID, byval clsOutSub as CLSID) as HRESULT
declare sub IFilterMapper_EnumMatchingFilters_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type __WIDL_axextend_generated_name_00000001
	clsMajorType as const CLSID ptr
	clsMinorType as const CLSID ptr
end type

type REGPINTYPES as __WIDL_axextend_generated_name_00000001

type __WIDL_axextend_generated_name_00000002
	strName as LPWSTR
	bRendered as WINBOOL
	bOutput as WINBOOL
	bZero as WINBOOL
	bMany as WINBOOL
	clsConnectsToFilter as const CLSID ptr
	strConnectsToPin as const wstring ptr
	nMediaTypes as UINT
	lpMediaType as const REGPINTYPES ptr
end type

type REGFILTERPINS as __WIDL_axextend_generated_name_00000002

type __WIDL_axextend_generated_name_00000003
	clsMedium as CLSID
	dw1 as DWORD
	dw2 as DWORD
end type

type REGPINMEDIUM as __WIDL_axextend_generated_name_00000003

enum
	REG_PINFLAG_B_ZERO = &h1
	REG_PINFLAG_B_RENDERER = &h2
	REG_PINFLAG_B_MANY = &h4
	REG_PINFLAG_B_OUTPUT = &h8
end enum

type __WIDL_axextend_generated_name_00000004
	dwFlags as DWORD
	cInstances as UINT
	nMediaTypes as UINT
	lpMediaType as const REGPINTYPES ptr
	nMediums as UINT
	lpMedium as const REGPINMEDIUM ptr
	clsPinCategory as const CLSID ptr
end type

type REGFILTERPINS2 as __WIDL_axextend_generated_name_00000004

type __WIDL_axextend_generated_name_00000005
	dwVersion as DWORD
	dwMerit as DWORD

	union
		type
			cPins as ULONG
			rgPins as const REGFILTERPINS ptr
		end type

		type
			cPins2 as ULONG
			rgPins2 as const REGFILTERPINS2 ptr
		end type
	end union
end type

type REGFILTER2 as __WIDL_axextend_generated_name_00000005

#define __IFilterMapper2_INTERFACE_DEFINED__

extern IID_IFilterMapper2 as const GUID

type IFilterMapper2 as IFilterMapper2_

type IFilterMapper2Vtbl
	QueryInterface as function(byval This as IFilterMapper2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IFilterMapper2 ptr) as ULONG
	Release as function(byval This as IFilterMapper2 ptr) as ULONG
	CreateCategory as function(byval This as IFilterMapper2 ptr, byval clsidCategory as const IID const ptr, byval dwCategoryMerit as DWORD, byval Description as LPCWSTR) as HRESULT
	UnregisterFilter as function(byval This as IFilterMapper2 ptr, byval pclsidCategory as const CLSID ptr, byval szInstance as LPCOLESTR, byval Filter as const IID const ptr) as HRESULT
	RegisterFilter as function(byval This as IFilterMapper2 ptr, byval clsidFilter as const IID const ptr, byval Name as LPCWSTR, byval ppMoniker as IMoniker ptr ptr, byval pclsidCategory as const CLSID ptr, byval szInstance as LPCOLESTR, byval prf2 as const REGFILTER2 ptr) as HRESULT
	EnumMatchingFilters as function(byval This as IFilterMapper2 ptr, byval ppEnum as IEnumMoniker ptr ptr, byval dwFlags as DWORD, byval bExactMatch as WINBOOL, byval dwMerit as DWORD, byval bInputNeeded as WINBOOL, byval cInputTypes as DWORD, byval pInputTypes as const GUID ptr, byval pMedIn as const REGPINMEDIUM ptr, byval pPinCategoryIn as const CLSID ptr, byval bRender as WINBOOL, byval bOutputNeeded as WINBOOL, byval cOutputTypes as DWORD, byval pOutputTypes as const GUID ptr, byval pMedOut as const REGPINMEDIUM ptr, byval pPinCategoryOut as const CLSID ptr) as HRESULT
end type

type IFilterMapper2_
	lpVtbl as IFilterMapper2Vtbl ptr
end type

declare function IFilterMapper2_CreateCategory_Proxy(byval This as IFilterMapper2 ptr, byval clsidCategory as const IID const ptr, byval dwCategoryMerit as DWORD, byval Description as LPCWSTR) as HRESULT
declare sub IFilterMapper2_CreateCategory_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFilterMapper2_UnregisterFilter_Proxy(byval This as IFilterMapper2 ptr, byval pclsidCategory as const CLSID ptr, byval szInstance as LPCOLESTR, byval Filter as const IID const ptr) as HRESULT
declare sub IFilterMapper2_UnregisterFilter_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFilterMapper2_RegisterFilter_Proxy(byval This as IFilterMapper2 ptr, byval clsidFilter as const IID const ptr, byval Name as LPCWSTR, byval ppMoniker as IMoniker ptr ptr, byval pclsidCategory as const CLSID ptr, byval szInstance as LPCOLESTR, byval prf2 as const REGFILTER2 ptr) as HRESULT
declare sub IFilterMapper2_RegisterFilter_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFilterMapper2_EnumMatchingFilters_Proxy(byval This as IFilterMapper2 ptr, byval ppEnum as IEnumMoniker ptr ptr, byval dwFlags as DWORD, byval bExactMatch as WINBOOL, byval dwMerit as DWORD, byval bInputNeeded as WINBOOL, byval cInputTypes as DWORD, byval pInputTypes as const GUID ptr, byval pMedIn as const REGPINMEDIUM ptr, byval pPinCategoryIn as const CLSID ptr, byval bRender as WINBOOL, byval bOutputNeeded as WINBOOL, byval cOutputTypes as DWORD, byval pOutputTypes as const GUID ptr, byval pMedOut as const REGPINMEDIUM ptr, byval pPinCategoryOut as const CLSID ptr) as HRESULT
declare sub IFilterMapper2_EnumMatchingFilters_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IFilterMapper3_INTERFACE_DEFINED__

extern IID_IFilterMapper3 as const GUID

type IFilterMapper3 as IFilterMapper3_

type IFilterMapper3Vtbl
	QueryInterface as function(byval This as IFilterMapper3 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IFilterMapper3 ptr) as ULONG
	Release as function(byval This as IFilterMapper3 ptr) as ULONG
	CreateCategory as function(byval This as IFilterMapper3 ptr, byval clsidCategory as const IID const ptr, byval dwCategoryMerit as DWORD, byval Description as LPCWSTR) as HRESULT
	UnregisterFilter as function(byval This as IFilterMapper3 ptr, byval pclsidCategory as const CLSID ptr, byval szInstance as LPCOLESTR, byval Filter as const IID const ptr) as HRESULT
	RegisterFilter as function(byval This as IFilterMapper3 ptr, byval clsidFilter as const IID const ptr, byval Name as LPCWSTR, byval ppMoniker as IMoniker ptr ptr, byval pclsidCategory as const CLSID ptr, byval szInstance as LPCOLESTR, byval prf2 as const REGFILTER2 ptr) as HRESULT
	EnumMatchingFilters as function(byval This as IFilterMapper3 ptr, byval ppEnum as IEnumMoniker ptr ptr, byval dwFlags as DWORD, byval bExactMatch as WINBOOL, byval dwMerit as DWORD, byval bInputNeeded as WINBOOL, byval cInputTypes as DWORD, byval pInputTypes as const GUID ptr, byval pMedIn as const REGPINMEDIUM ptr, byval pPinCategoryIn as const CLSID ptr, byval bRender as WINBOOL, byval bOutputNeeded as WINBOOL, byval cOutputTypes as DWORD, byval pOutputTypes as const GUID ptr, byval pMedOut as const REGPINMEDIUM ptr, byval pPinCategoryOut as const CLSID ptr) as HRESULT
	GetICreateDevEnum as function(byval This as IFilterMapper3 ptr, byval ppEnum as ICreateDevEnum ptr ptr) as HRESULT
end type

type IFilterMapper3_
	lpVtbl as IFilterMapper3Vtbl ptr
end type

declare function IFilterMapper3_GetICreateDevEnum_Proxy(byval This as IFilterMapper3 ptr, byval ppEnum as ICreateDevEnum ptr ptr) as HRESULT
declare sub IFilterMapper3_GetICreateDevEnum_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type tagQualityMessageType as long
enum
	Famine = 0
	Flood = 1
end enum

type QualityMessageType as tagQualityMessageType

type tagQuality
	as QualityMessageType Type
	Proportion as LONG
	Late as REFERENCE_TIME
	TimeStamp as REFERENCE_TIME
end type

type Quality as tagQuality

type IQualityControl as IQualityControl_

type PQUALITYCONTROL as IQualityControl ptr

#define __IQualityControl_INTERFACE_DEFINED__

extern IID_IQualityControl as const GUID

type IQualityControlVtbl
	QueryInterface as function(byval This as IQualityControl ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IQualityControl ptr) as ULONG
	Release as function(byval This as IQualityControl ptr) as ULONG
	Notify as function(byval This as IQualityControl ptr, byval pSelf as IBaseFilter ptr, byval q as Quality) as HRESULT
	SetSink as function(byval This as IQualityControl ptr, byval piqc as IQualityControl ptr) as HRESULT
end type

type IQualityControl_
	lpVtbl as IQualityControlVtbl ptr
end type

declare function IQualityControl_Notify_Proxy(byval This as IQualityControl ptr, byval pSelf as IBaseFilter ptr, byval q as Quality) as HRESULT
declare sub IQualityControl_Notify_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IQualityControl_SetSink_Proxy(byval This as IQualityControl ptr, byval piqc as IQualityControl ptr) as HRESULT
declare sub IQualityControl_SetSink_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

enum
	CK_NOCOLORKEY = &h0
	CK_INDEX = &h1
	CK_RGB = &h2
end enum

type tagCOLORKEY
	KeyType as DWORD
	PaletteIndex as DWORD
	LowColorValue as COLORREF
	HighColorValue as COLORREF
end type

type COLORKEY as tagCOLORKEY

enum
	ADVISE_NONE = &h0
	ADVISE_CLIPPING = &h1
	ADVISE_PALETTE = &h2
	ADVISE_COLORKEY = &h4
	ADVISE_POSITION = &h8
	ADVISE_DISPLAY_CHANGE = &h10
end enum

#define ADVISE_ALL (((ADVISE_CLIPPING or ADVISE_PALETTE) or ADVISE_COLORKEY) or ADVISE_POSITION)
#define ADVISE_ALL2 (ADVISE_ALL or ADVISE_DISPLAY_CHANGE)
#define __IOverlayNotify_INTERFACE_DEFINED__

extern IID_IOverlayNotify as const GUID

type IOverlayNotify as IOverlayNotify_

type IOverlayNotifyVtbl
	QueryInterface as function(byval This as IOverlayNotify ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IOverlayNotify ptr) as ULONG
	Release as function(byval This as IOverlayNotify ptr) as ULONG
	OnPaletteChange as function(byval This as IOverlayNotify ptr, byval dwColors as DWORD, byval pPalette as const PALETTEENTRY ptr) as HRESULT
	OnClipChange as function(byval This as IOverlayNotify ptr, byval pSourceRect as const RECT ptr, byval pDestinationRect as const RECT ptr, byval pRgnData as const RGNDATA ptr) as HRESULT
	OnColorKeyChange as function(byval This as IOverlayNotify ptr, byval pColorKey as const COLORKEY ptr) as HRESULT
	OnPositionChange as function(byval This as IOverlayNotify ptr, byval pSourceRect as const RECT ptr, byval pDestinationRect as const RECT ptr) as HRESULT
end type

type IOverlayNotify_
	lpVtbl as IOverlayNotifyVtbl ptr
end type

declare function IOverlayNotify_OnPaletteChange_Proxy(byval This as IOverlayNotify ptr, byval dwColors as DWORD, byval pPalette as const PALETTEENTRY ptr) as HRESULT
declare sub IOverlayNotify_OnPaletteChange_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOverlayNotify_OnClipChange_Proxy(byval This as IOverlayNotify ptr, byval pSourceRect as const RECT ptr, byval pDestinationRect as const RECT ptr, byval pRgnData as const RGNDATA ptr) as HRESULT
declare sub IOverlayNotify_OnClipChange_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOverlayNotify_OnColorKeyChange_Proxy(byval This as IOverlayNotify ptr, byval pColorKey as const COLORKEY ptr) as HRESULT
declare sub IOverlayNotify_OnColorKeyChange_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOverlayNotify_OnPositionChange_Proxy(byval This as IOverlayNotify ptr, byval pSourceRect as const RECT ptr, byval pDestinationRect as const RECT ptr) as HRESULT
declare sub IOverlayNotify_OnPositionChange_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type POVERLAYNOTIFY as IOverlayNotify ptr

#define __IOverlayNotify2_INTERFACE_DEFINED__

extern IID_IOverlayNotify2 as const GUID

type IOverlayNotify2 as IOverlayNotify2_

type IOverlayNotify2Vtbl
	QueryInterface as function(byval This as IOverlayNotify2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IOverlayNotify2 ptr) as ULONG
	Release as function(byval This as IOverlayNotify2 ptr) as ULONG
	OnPaletteChange as function(byval This as IOverlayNotify2 ptr, byval dwColors as DWORD, byval pPalette as const PALETTEENTRY ptr) as HRESULT
	OnClipChange as function(byval This as IOverlayNotify2 ptr, byval pSourceRect as const RECT ptr, byval pDestinationRect as const RECT ptr, byval pRgnData as const RGNDATA ptr) as HRESULT
	OnColorKeyChange as function(byval This as IOverlayNotify2 ptr, byval pColorKey as const COLORKEY ptr) as HRESULT
	OnPositionChange as function(byval This as IOverlayNotify2 ptr, byval pSourceRect as const RECT ptr, byval pDestinationRect as const RECT ptr) as HRESULT
	OnDisplayChange as function(byval This as IOverlayNotify2 ptr, byval hMonitor as HMONITOR) as HRESULT
end type

type IOverlayNotify2_
	lpVtbl as IOverlayNotify2Vtbl ptr
end type

declare function IOverlayNotify2_OnDisplayChange_Proxy(byval This as IOverlayNotify2 ptr, byval hMonitor as HMONITOR) as HRESULT
declare sub IOverlayNotify2_OnDisplayChange_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type POVERLAYNOTIFY2 as IOverlayNotify2 ptr

#define __IOverlay_INTERFACE_DEFINED__

extern IID_IOverlay as const GUID

type IOverlay as IOverlay_

type IOverlayVtbl
	QueryInterface as function(byval This as IOverlay ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IOverlay ptr) as ULONG
	Release as function(byval This as IOverlay ptr) as ULONG
	GetPalette as function(byval This as IOverlay ptr, byval pdwColors as DWORD ptr, byval ppPalette as PALETTEENTRY ptr ptr) as HRESULT
	SetPalette as function(byval This as IOverlay ptr, byval dwColors as DWORD, byval pPalette as PALETTEENTRY ptr) as HRESULT
	GetDefaultColorKey as function(byval This as IOverlay ptr, byval pColorKey as COLORKEY ptr) as HRESULT
	GetColorKey as function(byval This as IOverlay ptr, byval pColorKey as COLORKEY ptr) as HRESULT
	SetColorKey as function(byval This as IOverlay ptr, byval pColorKey as COLORKEY ptr) as HRESULT
	GetWindowHandle as function(byval This as IOverlay ptr, byval pHwnd as HWND ptr) as HRESULT
	GetClipList as function(byval This as IOverlay ptr, byval pSourceRect as RECT ptr, byval pDestinationRect as RECT ptr, byval ppRgnData as RGNDATA ptr ptr) as HRESULT
	GetVideoPosition as function(byval This as IOverlay ptr, byval pSourceRect as RECT ptr, byval pDestinationRect as RECT ptr) as HRESULT
	Advise as function(byval This as IOverlay ptr, byval pOverlayNotify as IOverlayNotify ptr, byval dwInterests as DWORD) as HRESULT
	Unadvise as function(byval This as IOverlay ptr) as HRESULT
end type

type IOverlay_
	lpVtbl as IOverlayVtbl ptr
end type

declare function IOverlay_GetPalette_Proxy(byval This as IOverlay ptr, byval pdwColors as DWORD ptr, byval ppPalette as PALETTEENTRY ptr ptr) as HRESULT
declare sub IOverlay_GetPalette_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOverlay_SetPalette_Proxy(byval This as IOverlay ptr, byval dwColors as DWORD, byval pPalette as PALETTEENTRY ptr) as HRESULT
declare sub IOverlay_SetPalette_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOverlay_GetDefaultColorKey_Proxy(byval This as IOverlay ptr, byval pColorKey as COLORKEY ptr) as HRESULT
declare sub IOverlay_GetDefaultColorKey_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOverlay_GetColorKey_Proxy(byval This as IOverlay ptr, byval pColorKey as COLORKEY ptr) as HRESULT
declare sub IOverlay_GetColorKey_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOverlay_SetColorKey_Proxy(byval This as IOverlay ptr, byval pColorKey as COLORKEY ptr) as HRESULT
declare sub IOverlay_SetColorKey_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOverlay_GetWindowHandle_Proxy(byval This as IOverlay ptr, byval pHwnd as HWND ptr) as HRESULT
declare sub IOverlay_GetWindowHandle_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOverlay_GetClipList_Proxy(byval This as IOverlay ptr, byval pSourceRect as RECT ptr, byval pDestinationRect as RECT ptr, byval ppRgnData as RGNDATA ptr ptr) as HRESULT
declare sub IOverlay_GetClipList_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOverlay_GetVideoPosition_Proxy(byval This as IOverlay ptr, byval pSourceRect as RECT ptr, byval pDestinationRect as RECT ptr) as HRESULT
declare sub IOverlay_GetVideoPosition_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOverlay_Advise_Proxy(byval This as IOverlay ptr, byval pOverlayNotify as IOverlayNotify ptr, byval dwInterests as DWORD) as HRESULT
declare sub IOverlay_Advise_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOverlay_Unadvise_Proxy(byval This as IOverlay ptr) as HRESULT
declare sub IOverlay_Unadvise_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type POVERLAY as IOverlay ptr

#define __IMediaEventSink_INTERFACE_DEFINED__

extern IID_IMediaEventSink as const GUID

type IMediaEventSink as IMediaEventSink_

type IMediaEventSinkVtbl
	QueryInterface as function(byval This as IMediaEventSink ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IMediaEventSink ptr) as ULONG
	Release as function(byval This as IMediaEventSink ptr) as ULONG
	Notify as function(byval This as IMediaEventSink ptr, byval EventCode as LONG, byval EventParam1 as LONG_PTR, byval EventParam2 as LONG_PTR) as HRESULT
end type

type IMediaEventSink_
	lpVtbl as IMediaEventSinkVtbl ptr
end type

declare function IMediaEventSink_Notify_Proxy(byval This as IMediaEventSink ptr, byval EventCode as LONG, byval EventParam1 as LONG_PTR, byval EventParam2 as LONG_PTR) as HRESULT
declare sub IMediaEventSink_Notify_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type PMEDIAEVENTSINK as IMediaEventSink ptr

#define __IFileSourceFilter_INTERFACE_DEFINED__

extern IID_IFileSourceFilter as const GUID

type IFileSourceFilter as IFileSourceFilter_

type IFileSourceFilterVtbl
	QueryInterface as function(byval This as IFileSourceFilter ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IFileSourceFilter ptr) as ULONG
	Release as function(byval This as IFileSourceFilter ptr) as ULONG
	Load as function(byval This as IFileSourceFilter ptr, byval pszFileName as LPCOLESTR, byval pmt as const AM_MEDIA_TYPE ptr) as HRESULT
	GetCurFile as function(byval This as IFileSourceFilter ptr, byval ppszFileName as LPOLESTR ptr, byval pmt as AM_MEDIA_TYPE ptr) as HRESULT
end type

type IFileSourceFilter_
	lpVtbl as IFileSourceFilterVtbl ptr
end type

declare function IFileSourceFilter_Load_Proxy(byval This as IFileSourceFilter ptr, byval pszFileName as LPCOLESTR, byval pmt as const AM_MEDIA_TYPE ptr) as HRESULT
declare sub IFileSourceFilter_Load_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFileSourceFilter_GetCurFile_Proxy(byval This as IFileSourceFilter ptr, byval ppszFileName as LPOLESTR ptr, byval pmt as AM_MEDIA_TYPE ptr) as HRESULT
declare sub IFileSourceFilter_GetCurFile_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type PFILTERFILESOURCE as IFileSourceFilter ptr

#define __IFileSinkFilter_INTERFACE_DEFINED__

extern IID_IFileSinkFilter as const GUID

type IFileSinkFilter as IFileSinkFilter_

type IFileSinkFilterVtbl
	QueryInterface as function(byval This as IFileSinkFilter ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IFileSinkFilter ptr) as ULONG
	Release as function(byval This as IFileSinkFilter ptr) as ULONG
	SetFileName as function(byval This as IFileSinkFilter ptr, byval pszFileName as LPCOLESTR, byval pmt as const AM_MEDIA_TYPE ptr) as HRESULT
	GetCurFile as function(byval This as IFileSinkFilter ptr, byval ppszFileName as LPOLESTR ptr, byval pmt as AM_MEDIA_TYPE ptr) as HRESULT
end type

type IFileSinkFilter_
	lpVtbl as IFileSinkFilterVtbl ptr
end type

declare function IFileSinkFilter_SetFileName_Proxy(byval This as IFileSinkFilter ptr, byval pszFileName as LPCOLESTR, byval pmt as const AM_MEDIA_TYPE ptr) as HRESULT
declare sub IFileSinkFilter_SetFileName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFileSinkFilter_GetCurFile_Proxy(byval This as IFileSinkFilter ptr, byval ppszFileName as LPOLESTR ptr, byval pmt as AM_MEDIA_TYPE ptr) as HRESULT
declare sub IFileSinkFilter_GetCurFile_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type PFILTERFILESINK as IFileSinkFilter ptr

#define __IFileSinkFilter2_INTERFACE_DEFINED__

extern IID_IFileSinkFilter2 as const GUID

type IFileSinkFilter2 as IFileSinkFilter2_

type IFileSinkFilter2Vtbl
	QueryInterface as function(byval This as IFileSinkFilter2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IFileSinkFilter2 ptr) as ULONG
	Release as function(byval This as IFileSinkFilter2 ptr) as ULONG
	SetFileName as function(byval This as IFileSinkFilter2 ptr, byval pszFileName as LPCOLESTR, byval pmt as const AM_MEDIA_TYPE ptr) as HRESULT
	GetCurFile as function(byval This as IFileSinkFilter2 ptr, byval ppszFileName as LPOLESTR ptr, byval pmt as AM_MEDIA_TYPE ptr) as HRESULT
	SetMode as function(byval This as IFileSinkFilter2 ptr, byval dwFlags as DWORD) as HRESULT
	GetMode as function(byval This as IFileSinkFilter2 ptr, byval pdwFlags as DWORD ptr) as HRESULT
end type

type IFileSinkFilter2_
	lpVtbl as IFileSinkFilter2Vtbl ptr
end type

declare function IFileSinkFilter2_SetMode_Proxy(byval This as IFileSinkFilter2 ptr, byval dwFlags as DWORD) as HRESULT
declare sub IFileSinkFilter2_SetMode_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFileSinkFilter2_GetMode_Proxy(byval This as IFileSinkFilter2 ptr, byval pdwFlags as DWORD ptr) as HRESULT
declare sub IFileSinkFilter2_GetMode_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type PFILESINKFILTER2 as IFileSinkFilter2 ptr

type __WIDL_axextend_generated_name_00000006 as long
enum
	AM_FILE_OVERWRITE = &h1
end enum

type AM_FILESINK_FLAGS as __WIDL_axextend_generated_name_00000006

#define __IGraphBuilder_INTERFACE_DEFINED__

extern IID_IGraphBuilder as const GUID

type IGraphBuilder as IGraphBuilder_

type IGraphBuilderVtbl
	QueryInterface as function(byval This as IGraphBuilder ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IGraphBuilder ptr) as ULONG
	Release as function(byval This as IGraphBuilder ptr) as ULONG
	AddFilter as function(byval This as IGraphBuilder ptr, byval pFilter as IBaseFilter ptr, byval pName as LPCWSTR) as HRESULT
	RemoveFilter as function(byval This as IGraphBuilder ptr, byval pFilter as IBaseFilter ptr) as HRESULT
	EnumFilters as function(byval This as IGraphBuilder ptr, byval ppEnum as IEnumFilters ptr ptr) as HRESULT
	FindFilterByName as function(byval This as IGraphBuilder ptr, byval pName as LPCWSTR, byval ppFilter as IBaseFilter ptr ptr) as HRESULT
	ConnectDirect as function(byval This as IGraphBuilder ptr, byval ppinOut as IPin ptr, byval ppinIn as IPin ptr, byval pmt as const AM_MEDIA_TYPE ptr) as HRESULT
	Reconnect as function(byval This as IGraphBuilder ptr, byval ppin as IPin ptr) as HRESULT
	Disconnect as function(byval This as IGraphBuilder ptr, byval ppin as IPin ptr) as HRESULT
	SetDefaultSyncSource as function(byval This as IGraphBuilder ptr) as HRESULT
	Connect as function(byval This as IGraphBuilder ptr, byval ppinOut as IPin ptr, byval ppinIn as IPin ptr) as HRESULT
	Render as function(byval This as IGraphBuilder ptr, byval ppinOut as IPin ptr) as HRESULT
	RenderFile as function(byval This as IGraphBuilder ptr, byval lpcwstrFile as LPCWSTR, byval lpcwstrPlayList as LPCWSTR) as HRESULT
	AddSourceFilter as function(byval This as IGraphBuilder ptr, byval lpcwstrFileName as LPCWSTR, byval lpcwstrFilterName as LPCWSTR, byval ppFilter as IBaseFilter ptr ptr) as HRESULT
	SetLogFile as function(byval This as IGraphBuilder ptr, byval hFile as DWORD_PTR) as HRESULT
	Abort as function(byval This as IGraphBuilder ptr) as HRESULT
	ShouldOperationContinue as function(byval This as IGraphBuilder ptr) as HRESULT
end type

type IGraphBuilder_
	lpVtbl as IGraphBuilderVtbl ptr
end type

declare function IGraphBuilder_Connect_Proxy(byval This as IGraphBuilder ptr, byval ppinOut as IPin ptr, byval ppinIn as IPin ptr) as HRESULT
declare sub IGraphBuilder_Connect_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IGraphBuilder_Render_Proxy(byval This as IGraphBuilder ptr, byval ppinOut as IPin ptr) as HRESULT
declare sub IGraphBuilder_Render_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IGraphBuilder_RenderFile_Proxy(byval This as IGraphBuilder ptr, byval lpcwstrFile as LPCWSTR, byval lpcwstrPlayList as LPCWSTR) as HRESULT
declare sub IGraphBuilder_RenderFile_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IGraphBuilder_AddSourceFilter_Proxy(byval This as IGraphBuilder ptr, byval lpcwstrFileName as LPCWSTR, byval lpcwstrFilterName as LPCWSTR, byval ppFilter as IBaseFilter ptr ptr) as HRESULT
declare sub IGraphBuilder_AddSourceFilter_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IGraphBuilder_SetLogFile_Proxy(byval This as IGraphBuilder ptr, byval hFile as DWORD_PTR) as HRESULT
declare sub IGraphBuilder_SetLogFile_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IGraphBuilder_Abort_Proxy(byval This as IGraphBuilder ptr) as HRESULT
declare sub IGraphBuilder_Abort_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IGraphBuilder_ShouldOperationContinue_Proxy(byval This as IGraphBuilder ptr) as HRESULT
declare sub IGraphBuilder_ShouldOperationContinue_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __ICaptureGraphBuilder_INTERFACE_DEFINED__

extern IID_ICaptureGraphBuilder as const GUID

type IAMCopyCaptureFileProgress as IAMCopyCaptureFileProgress_
type ICaptureGraphBuilder as ICaptureGraphBuilder_

type ICaptureGraphBuilderVtbl
	QueryInterface as function(byval This as ICaptureGraphBuilder ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ICaptureGraphBuilder ptr) as ULONG
	Release as function(byval This as ICaptureGraphBuilder ptr) as ULONG
	SetFiltergraph as function(byval This as ICaptureGraphBuilder ptr, byval pfg as IGraphBuilder ptr) as HRESULT
	GetFiltergraph as function(byval This as ICaptureGraphBuilder ptr, byval ppfg as IGraphBuilder ptr ptr) as HRESULT
	SetOutputFileName as function(byval This as ICaptureGraphBuilder ptr, byval pType as const GUID ptr, byval lpstrFile as LPCOLESTR, byval ppf as IBaseFilter ptr ptr, byval ppSink as IFileSinkFilter ptr ptr) as HRESULT
	FindInterface as function(byval This as ICaptureGraphBuilder ptr, byval pCategory as const GUID ptr, byval pf as IBaseFilter ptr, byval riid as const IID const ptr, byval ppint as any ptr ptr) as HRESULT
	RenderStream as function(byval This as ICaptureGraphBuilder ptr, byval pCategory as const GUID ptr, byval pSource as IUnknown ptr, byval pfCompressor as IBaseFilter ptr, byval pfRenderer as IBaseFilter ptr) as HRESULT
	ControlStream as function(byval This as ICaptureGraphBuilder ptr, byval pCategory as const GUID ptr, byval pFilter as IBaseFilter ptr, byval pstart as REFERENCE_TIME ptr, byval pstop as REFERENCE_TIME ptr, byval wStartCookie as WORD, byval wStopCookie as WORD) as HRESULT
	AllocCapFile as function(byval This as ICaptureGraphBuilder ptr, byval lpstr as LPCOLESTR, byval dwlSize as DWORDLONG) as HRESULT
	CopyCaptureFile as function(byval This as ICaptureGraphBuilder ptr, byval lpwstrOld as LPOLESTR, byval lpwstrNew as LPOLESTR, byval fAllowEscAbort as long, byval pCallback as IAMCopyCaptureFileProgress ptr) as HRESULT
end type

type ICaptureGraphBuilder_
	lpVtbl as ICaptureGraphBuilderVtbl ptr
end type

declare function ICaptureGraphBuilder_SetFiltergraph_Proxy(byval This as ICaptureGraphBuilder ptr, byval pfg as IGraphBuilder ptr) as HRESULT
declare sub ICaptureGraphBuilder_SetFiltergraph_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICaptureGraphBuilder_GetFiltergraph_Proxy(byval This as ICaptureGraphBuilder ptr, byval ppfg as IGraphBuilder ptr ptr) as HRESULT
declare sub ICaptureGraphBuilder_GetFiltergraph_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICaptureGraphBuilder_SetOutputFileName_Proxy(byval This as ICaptureGraphBuilder ptr, byval pType as const GUID ptr, byval lpstrFile as LPCOLESTR, byval ppf as IBaseFilter ptr ptr, byval ppSink as IFileSinkFilter ptr ptr) as HRESULT
declare sub ICaptureGraphBuilder_SetOutputFileName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICaptureGraphBuilder_RemoteFindInterface_Proxy(byval This as ICaptureGraphBuilder ptr, byval pCategory as const GUID ptr, byval pf as IBaseFilter ptr, byval riid as const IID const ptr, byval ppint as IUnknown ptr ptr) as HRESULT
declare sub ICaptureGraphBuilder_RemoteFindInterface_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICaptureGraphBuilder_RenderStream_Proxy(byval This as ICaptureGraphBuilder ptr, byval pCategory as const GUID ptr, byval pSource as IUnknown ptr, byval pfCompressor as IBaseFilter ptr, byval pfRenderer as IBaseFilter ptr) as HRESULT
declare sub ICaptureGraphBuilder_RenderStream_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICaptureGraphBuilder_ControlStream_Proxy(byval This as ICaptureGraphBuilder ptr, byval pCategory as const GUID ptr, byval pFilter as IBaseFilter ptr, byval pstart as REFERENCE_TIME ptr, byval pstop as REFERENCE_TIME ptr, byval wStartCookie as WORD, byval wStopCookie as WORD) as HRESULT
declare sub ICaptureGraphBuilder_ControlStream_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICaptureGraphBuilder_AllocCapFile_Proxy(byval This as ICaptureGraphBuilder ptr, byval lpstr as LPCOLESTR, byval dwlSize as DWORDLONG) as HRESULT
declare sub ICaptureGraphBuilder_AllocCapFile_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICaptureGraphBuilder_CopyCaptureFile_Proxy(byval This as ICaptureGraphBuilder ptr, byval lpwstrOld as LPOLESTR, byval lpwstrNew as LPOLESTR, byval fAllowEscAbort as long, byval pCallback as IAMCopyCaptureFileProgress ptr) as HRESULT
declare sub ICaptureGraphBuilder_CopyCaptureFile_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICaptureGraphBuilder_FindInterface_Proxy(byval This as ICaptureGraphBuilder ptr, byval pCategory as const GUID ptr, byval pf as IBaseFilter ptr, byval riid as const IID const ptr, byval ppint as any ptr ptr) as HRESULT
declare function ICaptureGraphBuilder_FindInterface_Stub(byval This as ICaptureGraphBuilder ptr, byval pCategory as const GUID ptr, byval pf as IBaseFilter ptr, byval riid as const IID const ptr, byval ppint as IUnknown ptr ptr) as HRESULT

#define __IAMCopyCaptureFileProgress_INTERFACE_DEFINED__

extern IID_IAMCopyCaptureFileProgress as const GUID

type IAMCopyCaptureFileProgressVtbl
	QueryInterface as function(byval This as IAMCopyCaptureFileProgress ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMCopyCaptureFileProgress ptr) as ULONG
	Release as function(byval This as IAMCopyCaptureFileProgress ptr) as ULONG
	Progress as function(byval This as IAMCopyCaptureFileProgress ptr, byval iProgress as long) as HRESULT
end type

type IAMCopyCaptureFileProgress_
	lpVtbl as IAMCopyCaptureFileProgressVtbl ptr
end type

declare function IAMCopyCaptureFileProgress_Progress_Proxy(byval This as IAMCopyCaptureFileProgress ptr, byval iProgress as long) as HRESULT
declare sub IAMCopyCaptureFileProgress_Progress_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __ICaptureGraphBuilder2_INTERFACE_DEFINED__

extern IID_ICaptureGraphBuilder2 as const GUID

type ICaptureGraphBuilder2 as ICaptureGraphBuilder2_

type ICaptureGraphBuilder2Vtbl
	QueryInterface as function(byval This as ICaptureGraphBuilder2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ICaptureGraphBuilder2 ptr) as ULONG
	Release as function(byval This as ICaptureGraphBuilder2 ptr) as ULONG
	SetFiltergraph as function(byval This as ICaptureGraphBuilder2 ptr, byval pfg as IGraphBuilder ptr) as HRESULT
	GetFiltergraph as function(byval This as ICaptureGraphBuilder2 ptr, byval ppfg as IGraphBuilder ptr ptr) as HRESULT
	SetOutputFileName as function(byval This as ICaptureGraphBuilder2 ptr, byval pType as const GUID ptr, byval lpstrFile as LPCOLESTR, byval ppf as IBaseFilter ptr ptr, byval ppSink as IFileSinkFilter ptr ptr) as HRESULT
	FindInterface as function(byval This as ICaptureGraphBuilder2 ptr, byval pCategory as const GUID ptr, byval pType as const GUID ptr, byval pf as IBaseFilter ptr, byval riid as const IID const ptr, byval ppint as any ptr ptr) as HRESULT
	RenderStream as function(byval This as ICaptureGraphBuilder2 ptr, byval pCategory as const GUID ptr, byval pType as const GUID ptr, byval pSource as IUnknown ptr, byval pfCompressor as IBaseFilter ptr, byval pfRenderer as IBaseFilter ptr) as HRESULT
	ControlStream as function(byval This as ICaptureGraphBuilder2 ptr, byval pCategory as const GUID ptr, byval pType as const GUID ptr, byval pFilter as IBaseFilter ptr, byval pstart as REFERENCE_TIME ptr, byval pstop as REFERENCE_TIME ptr, byval wStartCookie as WORD, byval wStopCookie as WORD) as HRESULT
	AllocCapFile as function(byval This as ICaptureGraphBuilder2 ptr, byval lpstr as LPCOLESTR, byval dwlSize as DWORDLONG) as HRESULT
	CopyCaptureFile as function(byval This as ICaptureGraphBuilder2 ptr, byval lpwstrOld as LPOLESTR, byval lpwstrNew as LPOLESTR, byval fAllowEscAbort as long, byval pCallback as IAMCopyCaptureFileProgress ptr) as HRESULT
	FindPin as function(byval This as ICaptureGraphBuilder2 ptr, byval pSource as IUnknown ptr, byval pindir as PIN_DIRECTION, byval pCategory as const GUID ptr, byval pType as const GUID ptr, byval fUnconnected as WINBOOL, byval num as long, byval ppPin as IPin ptr ptr) as HRESULT
end type

type ICaptureGraphBuilder2_
	lpVtbl as ICaptureGraphBuilder2Vtbl ptr
end type

declare function ICaptureGraphBuilder2_SetFiltergraph_Proxy(byval This as ICaptureGraphBuilder2 ptr, byval pfg as IGraphBuilder ptr) as HRESULT
declare sub ICaptureGraphBuilder2_SetFiltergraph_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICaptureGraphBuilder2_GetFiltergraph_Proxy(byval This as ICaptureGraphBuilder2 ptr, byval ppfg as IGraphBuilder ptr ptr) as HRESULT
declare sub ICaptureGraphBuilder2_GetFiltergraph_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICaptureGraphBuilder2_SetOutputFileName_Proxy(byval This as ICaptureGraphBuilder2 ptr, byval pType as const GUID ptr, byval lpstrFile as LPCOLESTR, byval ppf as IBaseFilter ptr ptr, byval ppSink as IFileSinkFilter ptr ptr) as HRESULT
declare sub ICaptureGraphBuilder2_SetOutputFileName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICaptureGraphBuilder2_RemoteFindInterface_Proxy(byval This as ICaptureGraphBuilder2 ptr, byval pCategory as const GUID ptr, byval pType as const GUID ptr, byval pf as IBaseFilter ptr, byval riid as const IID const ptr, byval ppint as IUnknown ptr ptr) as HRESULT
declare sub ICaptureGraphBuilder2_RemoteFindInterface_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICaptureGraphBuilder2_RenderStream_Proxy(byval This as ICaptureGraphBuilder2 ptr, byval pCategory as const GUID ptr, byval pType as const GUID ptr, byval pSource as IUnknown ptr, byval pfCompressor as IBaseFilter ptr, byval pfRenderer as IBaseFilter ptr) as HRESULT
declare sub ICaptureGraphBuilder2_RenderStream_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICaptureGraphBuilder2_ControlStream_Proxy(byval This as ICaptureGraphBuilder2 ptr, byval pCategory as const GUID ptr, byval pType as const GUID ptr, byval pFilter as IBaseFilter ptr, byval pstart as REFERENCE_TIME ptr, byval pstop as REFERENCE_TIME ptr, byval wStartCookie as WORD, byval wStopCookie as WORD) as HRESULT
declare sub ICaptureGraphBuilder2_ControlStream_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICaptureGraphBuilder2_AllocCapFile_Proxy(byval This as ICaptureGraphBuilder2 ptr, byval lpstr as LPCOLESTR, byval dwlSize as DWORDLONG) as HRESULT
declare sub ICaptureGraphBuilder2_AllocCapFile_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICaptureGraphBuilder2_CopyCaptureFile_Proxy(byval This as ICaptureGraphBuilder2 ptr, byval lpwstrOld as LPOLESTR, byval lpwstrNew as LPOLESTR, byval fAllowEscAbort as long, byval pCallback as IAMCopyCaptureFileProgress ptr) as HRESULT
declare sub ICaptureGraphBuilder2_CopyCaptureFile_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICaptureGraphBuilder2_FindPin_Proxy(byval This as ICaptureGraphBuilder2 ptr, byval pSource as IUnknown ptr, byval pindir as PIN_DIRECTION, byval pCategory as const GUID ptr, byval pType as const GUID ptr, byval fUnconnected as WINBOOL, byval num as long, byval ppPin as IPin ptr ptr) as HRESULT
declare sub ICaptureGraphBuilder2_FindPin_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICaptureGraphBuilder2_FindInterface_Proxy(byval This as ICaptureGraphBuilder2 ptr, byval pCategory as const GUID ptr, byval pType as const GUID ptr, byval pf as IBaseFilter ptr, byval riid as const IID const ptr, byval ppint as any ptr ptr) as HRESULT
declare function ICaptureGraphBuilder2_FindInterface_Stub(byval This as ICaptureGraphBuilder2 ptr, byval pCategory as const GUID ptr, byval pType as const GUID ptr, byval pf as IBaseFilter ptr, byval riid as const IID const ptr, byval ppint as IUnknown ptr ptr) as HRESULT

type _AM_RENSDEREXFLAGS as long
enum
	AM_RENDEREX_RENDERTOEXISTINGRENDERERS = &h1
end enum

#define __IFilterGraph2_INTERFACE_DEFINED__

extern IID_IFilterGraph2 as const GUID

type IFilterGraph2 as IFilterGraph2_

type IFilterGraph2Vtbl
	QueryInterface as function(byval This as IFilterGraph2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IFilterGraph2 ptr) as ULONG
	Release as function(byval This as IFilterGraph2 ptr) as ULONG
	AddFilter as function(byval This as IFilterGraph2 ptr, byval pFilter as IBaseFilter ptr, byval pName as LPCWSTR) as HRESULT
	RemoveFilter as function(byval This as IFilterGraph2 ptr, byval pFilter as IBaseFilter ptr) as HRESULT
	EnumFilters as function(byval This as IFilterGraph2 ptr, byval ppEnum as IEnumFilters ptr ptr) as HRESULT
	FindFilterByName as function(byval This as IFilterGraph2 ptr, byval pName as LPCWSTR, byval ppFilter as IBaseFilter ptr ptr) as HRESULT
	ConnectDirect as function(byval This as IFilterGraph2 ptr, byval ppinOut as IPin ptr, byval ppinIn as IPin ptr, byval pmt as const AM_MEDIA_TYPE ptr) as HRESULT
	Reconnect as function(byval This as IFilterGraph2 ptr, byval ppin as IPin ptr) as HRESULT
	Disconnect as function(byval This as IFilterGraph2 ptr, byval ppin as IPin ptr) as HRESULT
	SetDefaultSyncSource as function(byval This as IFilterGraph2 ptr) as HRESULT
	Connect as function(byval This as IFilterGraph2 ptr, byval ppinOut as IPin ptr, byval ppinIn as IPin ptr) as HRESULT
	Render as function(byval This as IFilterGraph2 ptr, byval ppinOut as IPin ptr) as HRESULT
	RenderFile as function(byval This as IFilterGraph2 ptr, byval lpcwstrFile as LPCWSTR, byval lpcwstrPlayList as LPCWSTR) as HRESULT
	AddSourceFilter as function(byval This as IFilterGraph2 ptr, byval lpcwstrFileName as LPCWSTR, byval lpcwstrFilterName as LPCWSTR, byval ppFilter as IBaseFilter ptr ptr) as HRESULT
	SetLogFile as function(byval This as IFilterGraph2 ptr, byval hFile as DWORD_PTR) as HRESULT
	Abort as function(byval This as IFilterGraph2 ptr) as HRESULT
	ShouldOperationContinue as function(byval This as IFilterGraph2 ptr) as HRESULT
	AddSourceFilterForMoniker as function(byval This as IFilterGraph2 ptr, byval pMoniker as IMoniker ptr, byval pCtx as IBindCtx ptr, byval lpcwstrFilterName as LPCWSTR, byval ppFilter as IBaseFilter ptr ptr) as HRESULT
	ReconnectEx as function(byval This as IFilterGraph2 ptr, byval ppin as IPin ptr, byval pmt as const AM_MEDIA_TYPE ptr) as HRESULT
	RenderEx as function(byval This as IFilterGraph2 ptr, byval pPinOut as IPin ptr, byval dwFlags as DWORD, byval pvContext as DWORD ptr) as HRESULT
end type

type IFilterGraph2_
	lpVtbl as IFilterGraph2Vtbl ptr
end type

declare function IFilterGraph2_AddSourceFilterForMoniker_Proxy(byval This as IFilterGraph2 ptr, byval pMoniker as IMoniker ptr, byval pCtx as IBindCtx ptr, byval lpcwstrFilterName as LPCWSTR, byval ppFilter as IBaseFilter ptr ptr) as HRESULT
declare sub IFilterGraph2_AddSourceFilterForMoniker_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFilterGraph2_ReconnectEx_Proxy(byval This as IFilterGraph2 ptr, byval ppin as IPin ptr, byval pmt as const AM_MEDIA_TYPE ptr) as HRESULT
declare sub IFilterGraph2_ReconnectEx_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFilterGraph2_RenderEx_Proxy(byval This as IFilterGraph2 ptr, byval pPinOut as IPin ptr, byval dwFlags as DWORD, byval pvContext as DWORD ptr) as HRESULT
declare sub IFilterGraph2_RenderEx_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IStreamBuilder_INTERFACE_DEFINED__

extern IID_IStreamBuilder as const GUID

type IStreamBuilder as IStreamBuilder_

type IStreamBuilderVtbl
	QueryInterface as function(byval This as IStreamBuilder ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IStreamBuilder ptr) as ULONG
	Release as function(byval This as IStreamBuilder ptr) as ULONG
	Render as function(byval This as IStreamBuilder ptr, byval ppinOut as IPin ptr, byval pGraph as IGraphBuilder ptr) as HRESULT
	Backout as function(byval This as IStreamBuilder ptr, byval ppinOut as IPin ptr, byval pGraph as IGraphBuilder ptr) as HRESULT
end type

type IStreamBuilder_
	lpVtbl as IStreamBuilderVtbl ptr
end type

declare function IStreamBuilder_Render_Proxy(byval This as IStreamBuilder ptr, byval ppinOut as IPin ptr, byval pGraph as IGraphBuilder ptr) as HRESULT
declare sub IStreamBuilder_Render_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IStreamBuilder_Backout_Proxy(byval This as IStreamBuilder ptr, byval ppinOut as IPin ptr, byval pGraph as IGraphBuilder ptr) as HRESULT
declare sub IStreamBuilder_Backout_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IAMStreamConfig_INTERFACE_DEFINED__

type _VIDEO_STREAM_CONFIG_CAPS
	guid as GUID
	VideoStandard as ULONG
	InputSize as SIZE
	MinCroppingSize as SIZE
	MaxCroppingSize as SIZE
	CropGranularityX as long
	CropGranularityY as long
	CropAlignX as long
	CropAlignY as long
	MinOutputSize as SIZE
	MaxOutputSize as SIZE
	OutputGranularityX as long
	OutputGranularityY as long
	StretchTapsX as long
	StretchTapsY as long
	ShrinkTapsX as long
	ShrinkTapsY as long
	MinFrameInterval as LONGLONG
	MaxFrameInterval as LONGLONG
	MinBitsPerSecond as LONG
	MaxBitsPerSecond as LONG
end type

type VIDEO_STREAM_CONFIG_CAPS as _VIDEO_STREAM_CONFIG_CAPS

type _AUDIO_STREAM_CONFIG_CAPS
	guid as GUID
	MinimumChannels as ULONG
	MaximumChannels as ULONG
	ChannelsGranularity as ULONG
	MinimumBitsPerSample as ULONG
	MaximumBitsPerSample as ULONG
	BitsPerSampleGranularity as ULONG
	MinimumSampleFrequency as ULONG
	MaximumSampleFrequency as ULONG
	SampleFrequencyGranularity as ULONG
end type

type AUDIO_STREAM_CONFIG_CAPS as _AUDIO_STREAM_CONFIG_CAPS

extern IID_IAMStreamConfig as const GUID

type IAMStreamConfig as IAMStreamConfig_

type IAMStreamConfigVtbl
	QueryInterface as function(byval This as IAMStreamConfig ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMStreamConfig ptr) as ULONG
	Release as function(byval This as IAMStreamConfig ptr) as ULONG
	SetFormat as function(byval This as IAMStreamConfig ptr, byval pmt as AM_MEDIA_TYPE ptr) as HRESULT
	GetFormat as function(byval This as IAMStreamConfig ptr, byval pmt as AM_MEDIA_TYPE ptr ptr) as HRESULT
	GetNumberOfCapabilities as function(byval This as IAMStreamConfig ptr, byval piCount as long ptr, byval piSize as long ptr) as HRESULT
	GetStreamCaps as function(byval This as IAMStreamConfig ptr, byval iIndex as long, byval pmt as AM_MEDIA_TYPE ptr ptr, byval pSCC as UBYTE ptr) as HRESULT
end type

type IAMStreamConfig_
	lpVtbl as IAMStreamConfigVtbl ptr
end type

declare function IAMStreamConfig_SetFormat_Proxy(byval This as IAMStreamConfig ptr, byval pmt as AM_MEDIA_TYPE ptr) as HRESULT
declare sub IAMStreamConfig_SetFormat_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAMStreamConfig_GetFormat_Proxy(byval This as IAMStreamConfig ptr, byval pmt as AM_MEDIA_TYPE ptr ptr) as HRESULT
declare sub IAMStreamConfig_GetFormat_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAMStreamConfig_GetNumberOfCapabilities_Proxy(byval This as IAMStreamConfig ptr, byval piCount as long ptr, byval piSize as long ptr) as HRESULT
declare sub IAMStreamConfig_GetNumberOfCapabilities_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAMStreamConfig_GetStreamCaps_Proxy(byval This as IAMStreamConfig ptr, byval iIndex as long, byval pmt as AM_MEDIA_TYPE ptr ptr, byval pSCC as UBYTE ptr) as HRESULT
declare sub IAMStreamConfig_GetStreamCaps_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type tagVideoProcAmpProperty as long
enum
	VideoProcAmp_Brightness = 0
	VideoProcAmp_Contrast = 1
	VideoProcAmp_Hue = 2
	VideoProcAmp_Saturation = 3
	VideoProcAmp_Sharpness = 4
	VideoProcAmp_Gamma = 5
	VideoProcAmp_ColorEnable = 6
	VideoProcAmp_WhiteBalance = 7
	VideoProcAmp_BacklightCompensation = 8
	VideoProcAmp_Gain = 9
end enum

type VideoProcAmpProperty as tagVideoProcAmpProperty

type tagVideoProcAmpFlags as long
enum
	VideoProcAmp_Flags_Auto = &h1
	VideoProcAmp_Flags_Manual = &h2
end enum

type VideoProcAmpFlags as tagVideoProcAmpFlags

#define __IAMVideoProcAmp_INTERFACE_DEFINED__

extern IID_IAMVideoProcAmp as const GUID

type IAMVideoProcAmp as IAMVideoProcAmp_

type IAMVideoProcAmpVtbl
	QueryInterface as function(byval This as IAMVideoProcAmp ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMVideoProcAmp ptr) as ULONG
	Release as function(byval This as IAMVideoProcAmp ptr) as ULONG
	GetRange as function(byval This as IAMVideoProcAmp ptr, byval Property as LONG, byval pMin as LONG ptr, byval pMax as LONG ptr, byval pSteppingDelta as LONG ptr, byval pDefault as LONG ptr, byval pCapsFlags as LONG ptr) as HRESULT
	Set as function(byval This as IAMVideoProcAmp ptr, byval Property as LONG, byval lValue as LONG, byval Flags as LONG) as HRESULT
	Get as function(byval This as IAMVideoProcAmp ptr, byval Property as LONG, byval lValue as LONG ptr, byval Flags as LONG ptr) as HRESULT
end type

type IAMVideoProcAmp_
	lpVtbl as IAMVideoProcAmpVtbl ptr
end type

declare function IAMVideoProcAmp_GetRange_Proxy(byval This as IAMVideoProcAmp ptr, byval Property as LONG, byval pMin as LONG ptr, byval pMax as LONG ptr, byval pSteppingDelta as LONG ptr, byval pDefault as LONG ptr, byval pCapsFlags as LONG ptr) as HRESULT
declare sub IAMVideoProcAmp_GetRange_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAMVideoProcAmp_Set_Proxy(byval This as IAMVideoProcAmp ptr, byval Property as LONG, byval lValue as LONG, byval Flags as LONG) as HRESULT
declare sub IAMVideoProcAmp_Set_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAMVideoProcAmp_Get_Proxy(byval This as IAMVideoProcAmp ptr, byval Property as LONG, byval lValue as LONG ptr, byval Flags as LONG ptr) as HRESULT
declare sub IAMVideoProcAmp_Get_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IAsyncReader_INTERFACE_DEFINED__

extern IID_IAsyncReader as const GUID

type IAsyncReader as IAsyncReader_

type IAsyncReaderVtbl
	QueryInterface as function(byval This as IAsyncReader ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAsyncReader ptr) as ULONG
	Release as function(byval This as IAsyncReader ptr) as ULONG
	RequestAllocator as function(byval This as IAsyncReader ptr, byval pPreferred as IMemAllocator ptr, byval pProps as ALLOCATOR_PROPERTIES ptr, byval ppActual as IMemAllocator ptr ptr) as HRESULT
	Request as function(byval This as IAsyncReader ptr, byval pSample as IMediaSample ptr, byval dwUser as DWORD_PTR) as HRESULT
	WaitForNext as function(byval This as IAsyncReader ptr, byval dwTimeout as DWORD, byval ppSample as IMediaSample ptr ptr, byval pdwUser as DWORD_PTR ptr) as HRESULT
	SyncReadAligned as function(byval This as IAsyncReader ptr, byval pSample as IMediaSample ptr) as HRESULT
	SyncRead as function(byval This as IAsyncReader ptr, byval llPosition as LONGLONG, byval lLength as LONG, byval pBuffer as UBYTE ptr) as HRESULT
	Length as function(byval This as IAsyncReader ptr, byval pTotal as LONGLONG ptr, byval pAvailable as LONGLONG ptr) as HRESULT
	BeginFlush as function(byval This as IAsyncReader ptr) as HRESULT
	EndFlush as function(byval This as IAsyncReader ptr) as HRESULT
end type

type IAsyncReader_
	lpVtbl as IAsyncReaderVtbl ptr
end type

declare function IAsyncReader_RequestAllocator_Proxy(byval This as IAsyncReader ptr, byval pPreferred as IMemAllocator ptr, byval pProps as ALLOCATOR_PROPERTIES ptr, byval ppActual as IMemAllocator ptr ptr) as HRESULT
declare sub IAsyncReader_RequestAllocator_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAsyncReader_Request_Proxy(byval This as IAsyncReader ptr, byval pSample as IMediaSample ptr, byval dwUser as DWORD_PTR) as HRESULT
declare sub IAsyncReader_Request_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAsyncReader_WaitForNext_Proxy(byval This as IAsyncReader ptr, byval dwTimeout as DWORD, byval ppSample as IMediaSample ptr ptr, byval pdwUser as DWORD_PTR ptr) as HRESULT
declare sub IAsyncReader_WaitForNext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAsyncReader_SyncReadAligned_Proxy(byval This as IAsyncReader ptr, byval pSample as IMediaSample ptr) as HRESULT
declare sub IAsyncReader_SyncReadAligned_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAsyncReader_SyncRead_Proxy(byval This as IAsyncReader ptr, byval llPosition as LONGLONG, byval lLength as LONG, byval pBuffer as UBYTE ptr) as HRESULT
declare sub IAsyncReader_SyncRead_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAsyncReader_Length_Proxy(byval This as IAsyncReader ptr, byval pTotal as LONGLONG ptr, byval pAvailable as LONGLONG ptr) as HRESULT
declare sub IAsyncReader_Length_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAsyncReader_BeginFlush_Proxy(byval This as IAsyncReader ptr) as HRESULT
declare sub IAsyncReader_BeginFlush_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAsyncReader_EndFlush_Proxy(byval This as IAsyncReader ptr) as HRESULT
declare sub IAsyncReader_EndFlush_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IGraphVersion_INTERFACE_DEFINED__

extern IID_IGraphVersion as const GUID

type IGraphVersion as IGraphVersion_

type IGraphVersionVtbl
	QueryInterface as function(byval This as IGraphVersion ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IGraphVersion ptr) as ULONG
	Release as function(byval This as IGraphVersion ptr) as ULONG
	QueryVersion as function(byval This as IGraphVersion ptr, byval pVersion as LONG ptr) as HRESULT
end type

type IGraphVersion_
	lpVtbl as IGraphVersionVtbl ptr
end type

declare function IGraphVersion_QueryVersion_Proxy(byval This as IGraphVersion ptr, byval pVersion as LONG ptr) as HRESULT
declare sub IGraphVersion_QueryVersion_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IResourceConsumer_INTERFACE_DEFINED__

extern IID_IResourceConsumer as const GUID

type IResourceConsumer as IResourceConsumer_

type IResourceConsumerVtbl
	QueryInterface as function(byval This as IResourceConsumer ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IResourceConsumer ptr) as ULONG
	Release as function(byval This as IResourceConsumer ptr) as ULONG
	AcquireResource as function(byval This as IResourceConsumer ptr, byval idResource as LONG) as HRESULT
	ReleaseResource as function(byval This as IResourceConsumer ptr, byval idResource as LONG) as HRESULT
end type

type IResourceConsumer_
	lpVtbl as IResourceConsumerVtbl ptr
end type

declare function IResourceConsumer_AcquireResource_Proxy(byval This as IResourceConsumer ptr, byval idResource as LONG) as HRESULT
declare sub IResourceConsumer_AcquireResource_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IResourceConsumer_ReleaseResource_Proxy(byval This as IResourceConsumer ptr, byval idResource as LONG) as HRESULT
declare sub IResourceConsumer_ReleaseResource_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IResourceManager_INTERFACE_DEFINED__

extern IID_IResourceManager as const GUID

type IResourceManager as IResourceManager_

type IResourceManagerVtbl
	QueryInterface as function(byval This as IResourceManager ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IResourceManager ptr) as ULONG
	Release as function(byval This as IResourceManager ptr) as ULONG
	Register as function(byval This as IResourceManager ptr, byval pName as LPCWSTR, byval cResource as LONG, byval plToken as LONG ptr) as HRESULT
	RegisterGroup as function(byval This as IResourceManager ptr, byval pName as LPCWSTR, byval cResource as LONG, byval palTokens as LONG ptr, byval plToken as LONG ptr) as HRESULT
	RequestResource as function(byval This as IResourceManager ptr, byval idResource as LONG, byval pFocusObject as IUnknown ptr, byval pConsumer as IResourceConsumer ptr) as HRESULT
	NotifyAcquire as function(byval This as IResourceManager ptr, byval idResource as LONG, byval pConsumer as IResourceConsumer ptr, byval hr as HRESULT) as HRESULT
	NotifyRelease as function(byval This as IResourceManager ptr, byval idResource as LONG, byval pConsumer as IResourceConsumer ptr, byval bStillWant as WINBOOL) as HRESULT
	CancelRequest as function(byval This as IResourceManager ptr, byval idResource as LONG, byval pConsumer as IResourceConsumer ptr) as HRESULT
	SetFocus as function(byval This as IResourceManager ptr, byval pFocusObject as IUnknown ptr) as HRESULT
	ReleaseFocus as function(byval This as IResourceManager ptr, byval pFocusObject as IUnknown ptr) as HRESULT
end type

type IResourceManager_
	lpVtbl as IResourceManagerVtbl ptr
end type

declare function IResourceManager_Register_Proxy(byval This as IResourceManager ptr, byval pName as LPCWSTR, byval cResource as LONG, byval plToken as LONG ptr) as HRESULT
declare sub IResourceManager_Register_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IResourceManager_RegisterGroup_Proxy(byval This as IResourceManager ptr, byval pName as LPCWSTR, byval cResource as LONG, byval palTokens as LONG ptr, byval plToken as LONG ptr) as HRESULT
declare sub IResourceManager_RegisterGroup_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IResourceManager_RequestResource_Proxy(byval This as IResourceManager ptr, byval idResource as LONG, byval pFocusObject as IUnknown ptr, byval pConsumer as IResourceConsumer ptr) as HRESULT
declare sub IResourceManager_RequestResource_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IResourceManager_NotifyAcquire_Proxy(byval This as IResourceManager ptr, byval idResource as LONG, byval pConsumer as IResourceConsumer ptr, byval hr as HRESULT) as HRESULT
declare sub IResourceManager_NotifyAcquire_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IResourceManager_NotifyRelease_Proxy(byval This as IResourceManager ptr, byval idResource as LONG, byval pConsumer as IResourceConsumer ptr, byval bStillWant as WINBOOL) as HRESULT
declare sub IResourceManager_NotifyRelease_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IResourceManager_CancelRequest_Proxy(byval This as IResourceManager ptr, byval idResource as LONG, byval pConsumer as IResourceConsumer ptr) as HRESULT
declare sub IResourceManager_CancelRequest_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IResourceManager_SetFocus_Proxy(byval This as IResourceManager ptr, byval pFocusObject as IUnknown ptr) as HRESULT
declare sub IResourceManager_SetFocus_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IResourceManager_ReleaseFocus_Proxy(byval This as IResourceManager ptr, byval pFocusObject as IUnknown ptr) as HRESULT
declare sub IResourceManager_ReleaseFocus_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define _IKsPropertySet_
#define KSPROPERTY_SUPPORT_GET 1
#define KSPROPERTY_SUPPORT_SET 2
#define __IKsPropertySet_INTERFACE_DEFINED__

extern IID_IKsPropertySet as const GUID

type IKsPropertySet as IKsPropertySet_

type IKsPropertySetVtbl
	QueryInterface as function(byval This as IKsPropertySet ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IKsPropertySet ptr) as ULONG
	Release as function(byval This as IKsPropertySet ptr) as ULONG
	Set as function(byval This as IKsPropertySet ptr, byval guidPropSet as const GUID const ptr, byval dwPropID as DWORD, byval pInstanceData as LPVOID, byval cbInstanceData as DWORD, byval pPropData as LPVOID, byval cbPropData as DWORD) as HRESULT
	Get as function(byval This as IKsPropertySet ptr, byval guidPropSet as const GUID const ptr, byval dwPropID as DWORD, byval pInstanceData as LPVOID, byval cbInstanceData as DWORD, byval pPropData as LPVOID, byval cbPropData as DWORD, byval pcbReturned as DWORD ptr) as HRESULT
	QuerySupported as function(byval This as IKsPropertySet ptr, byval guidPropSet as const GUID const ptr, byval dwPropID as DWORD, byval pTypeSupport as DWORD ptr) as HRESULT
end type

type IKsPropertySet_
	lpVtbl as IKsPropertySetVtbl ptr
end type

declare function IKsPropertySet_Set_Proxy(byval This as IKsPropertySet ptr, byval guidPropSet as const GUID const ptr, byval dwPropID as DWORD, byval pInstanceData as LPVOID, byval cbInstanceData as DWORD, byval pPropData as LPVOID, byval cbPropData as DWORD) as HRESULT
declare sub IKsPropertySet_Set_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IKsPropertySet_Get_Proxy(byval This as IKsPropertySet ptr, byval guidPropSet as const GUID const ptr, byval dwPropID as DWORD, byval pInstanceData as LPVOID, byval cbInstanceData as DWORD, byval pPropData as LPVOID, byval cbPropData as DWORD, byval pcbReturned as DWORD ptr) as HRESULT
declare sub IKsPropertySet_Get_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IKsPropertySet_QuerySupported_Proxy(byval This as IKsPropertySet ptr, byval guidPropSet as const GUID const ptr, byval dwPropID as DWORD, byval pTypeSupport as DWORD ptr) as HRESULT
declare sub IKsPropertySet_QuerySupported_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __ISeekingPassThru_INTERFACE_DEFINED__

extern IID_ISeekingPassThru as const GUID

type ISeekingPassThru as ISeekingPassThru_

type ISeekingPassThruVtbl
	QueryInterface as function(byval This as ISeekingPassThru ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ISeekingPassThru ptr) as ULONG
	Release as function(byval This as ISeekingPassThru ptr) as ULONG
	Init as function(byval This as ISeekingPassThru ptr, byval bSupportRendering as WINBOOL, byval pPin as IPin ptr) as HRESULT
end type

type ISeekingPassThru_
	lpVtbl as ISeekingPassThruVtbl ptr
end type

declare function ISeekingPassThru_Init_Proxy(byval This as ISeekingPassThru ptr, byval bSupportRendering as WINBOOL, byval pPin as IPin ptr) as HRESULT
declare sub ISeekingPassThru_Init_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type _AM_FILTER_MISC_FLAGS as long
enum
	AM_FILTER_MISC_FLAGS_IS_RENDERER = &h1
	AM_FILTER_MISC_FLAGS_IS_SOURCE = &h2
end enum

#define __IAMFilterMiscFlags_INTERFACE_DEFINED__

extern IID_IAMFilterMiscFlags as const GUID

type IAMFilterMiscFlags as IAMFilterMiscFlags_

type IAMFilterMiscFlagsVtbl
	QueryInterface as function(byval This as IAMFilterMiscFlags ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMFilterMiscFlags ptr) as ULONG
	Release as function(byval This as IAMFilterMiscFlags ptr) as ULONG
	GetMiscFlags as function(byval This as IAMFilterMiscFlags ptr) as ULONG
end type

type IAMFilterMiscFlags_
	lpVtbl as IAMFilterMiscFlagsVtbl ptr
end type

declare function IAMFilterMiscFlags_GetMiscFlags_Proxy(byval This as IAMFilterMiscFlags ptr) as ULONG
declare sub IAMFilterMiscFlags_GetMiscFlags_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IAMGraphBuilderCallback_INTERFACE_DEFINED__

extern IID_IAMGraphBuilderCallback as const GUID

type IAMGraphBuilderCallback as IAMGraphBuilderCallback_

type IAMGraphBuilderCallbackVtbl
	QueryInterface as function(byval This as IAMGraphBuilderCallback ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMGraphBuilderCallback ptr) as ULONG
	Release as function(byval This as IAMGraphBuilderCallback ptr) as ULONG
	SelectedFilter as function(byval This as IAMGraphBuilderCallback ptr, byval pMon as IMoniker ptr) as HRESULT
	CreatedFilter as function(byval This as IAMGraphBuilderCallback ptr, byval pFil as IBaseFilter ptr) as HRESULT
end type

type IAMGraphBuilderCallback_
	lpVtbl as IAMGraphBuilderCallbackVtbl ptr
end type

declare function IAMGraphBuilderCallback_SelectedFilter_Proxy(byval This as IAMGraphBuilderCallback ptr, byval pMon as IMoniker ptr) as HRESULT
declare sub IAMGraphBuilderCallback_SelectedFilter_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAMGraphBuilderCallback_CreatedFilter_Proxy(byval This as IAMGraphBuilderCallback ptr, byval pFil as IBaseFilter ptr) as HRESULT
declare sub IAMGraphBuilderCallback_CreatedFilter_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IReferenceClock2_FWD_DEFINED__
#define __IDistributorNotify_FWD_DEFINED__
#define __IAMStreamControl_FWD_DEFINED__
#define __IAMVideoControl_FWD_DEFINED__
#define __IAMTuner_FWD_DEFINED__
#define __IAMTunerNotification_FWD_DEFINED__
#define __IBPCSatelliteTuner_FWD_DEFINED__
#define __IAMTVAudio_FWD_DEFINED__
#define __IAMTVAudioNotification_FWD_DEFINED__
#define __IMediaPropertyBag_FWD_DEFINED__
#define __IPersistMediaPropertyBag_FWD_DEFINED__
#define __IAMStreamSelect_FWD_DEFINED__
#define __IAMResourceControl_FWD_DEFINED__
#define __IAMClockAdjust_FWD_DEFINED__
#define __IVideoFrameStep_FWD_DEFINED__
#define __IAMDeviceRemoval_FWD_DEFINED__
#define __IDVEnc_FWD_DEFINED__
#define __IIPDVDec_FWD_DEFINED__
#define __IDVRGB219_FWD_DEFINED__
#define __IDVSplitter_FWD_DEFINED__
#define __IRegisterServiceProvider_FWD_DEFINED__
#define __IAMClockSlave_FWD_DEFINED__
#define __ICodecAPI_FWD_DEFINED__
#define __IGetCapabilitiesKey_FWD_DEFINED__
#define __IEncoderAPI_FWD_DEFINED__
#define __IVideoEncoder_FWD_DEFINED__
#define __IAMDecoderCaps_FWD_DEFINED__
#define __IAMCertifiedOutputProtection_FWD_DEFINED__
#define __IDvdControl_FWD_DEFINED__
#define __IDvdInfo_FWD_DEFINED__
#define __IDvdCmd_FWD_DEFINED__
#define __IDvdState_FWD_DEFINED__
#define __IDvdControl2_FWD_DEFINED__
#define __IDvdInfo2_FWD_DEFINED__
#define __IDvdGraphBuilder_FWD_DEFINED__
#define __IDDrawExclModeVideo_FWD_DEFINED__
#define __IDDrawExclModeVideoCallback_FWD_DEFINED__
#define __IPinConnection_FWD_DEFINED__
#define __IPinFlowControl_FWD_DEFINED__
#define __IGraphConfig_FWD_DEFINED__
#define __IGraphConfigCallback_FWD_DEFINED__
#define __IFilterChain_FWD_DEFINED__
#define __IVMRImagePresenter_FWD_DEFINED__
#define __IVMRSurfaceAllocator_FWD_DEFINED__
#define __IVMRSurfaceAllocatorNotify_FWD_DEFINED__
#define __IVMRWindowlessControl_FWD_DEFINED__
#define __IVMRMixerControl_FWD_DEFINED__
#define __IVMRMonitorConfig_FWD_DEFINED__
#define __IVMRFilterConfig_FWD_DEFINED__
#define __IVMRAspectRatioControl_FWD_DEFINED__
#define __IVMRDeinterlaceControl_FWD_DEFINED__
#define __IVMRMixerBitmap_FWD_DEFINED__
#define __IVMRImageCompositor_FWD_DEFINED__
#define __IVMRVideoStreamControl_FWD_DEFINED__
#define __IVMRSurface_FWD_DEFINED__
#define __IVMRImagePresenterConfig_FWD_DEFINED__
#define __IVMRImagePresenterExclModeConfig_FWD_DEFINED__
#define __IVPManager_FWD_DEFINED__
#define __IAMAsyncReaderTimestampScaling_FWD_DEFINED__
#define __IAMPluginControl_FWD_DEFINED__

extern __MIDL_itf_strmif_0125_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0125_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IReferenceClock2_INTERFACE_DEFINED__

extern IID_IReferenceClock2 as const IID

type IReferenceClock2 as IReferenceClock2_

type IReferenceClock2Vtbl
	QueryInterface as function(byval This as IReferenceClock2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IReferenceClock2 ptr) as ULONG
	Release as function(byval This as IReferenceClock2 ptr) as ULONG
	GetTime as function(byval This as IReferenceClock2 ptr, byval pTime as REFERENCE_TIME ptr) as HRESULT
	AdviseTime as function(byval This as IReferenceClock2 ptr, byval baseTime as REFERENCE_TIME, byval streamTime as REFERENCE_TIME, byval hEvent as HEVENT, byval pdwAdviseCookie as DWORD_PTR ptr) as HRESULT
	AdvisePeriodic as function(byval This as IReferenceClock2 ptr, byval startTime as REFERENCE_TIME, byval periodTime as REFERENCE_TIME, byval hSemaphore as HSEMAPHORE, byval pdwAdviseCookie as DWORD_PTR ptr) as HRESULT
	Unadvise as function(byval This as IReferenceClock2 ptr, byval dwAdviseCookie as DWORD_PTR) as HRESULT
end type

type IReferenceClock2_
	lpVtbl as IReferenceClock2Vtbl ptr
end type

type PREFERENCECLOCK2 as IReferenceClock2 ptr

#define __IDistributorNotify_INTERFACE_DEFINED__

extern IID_IDistributorNotify as const IID

type IDistributorNotify as IDistributorNotify_

type IDistributorNotifyVtbl
	QueryInterface as function(byval This as IDistributorNotify ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDistributorNotify ptr) as ULONG
	Release as function(byval This as IDistributorNotify ptr) as ULONG
	Stop as function(byval This as IDistributorNotify ptr) as HRESULT
	Pause as function(byval This as IDistributorNotify ptr) as HRESULT
	Run as function(byval This as IDistributorNotify ptr, byval tStart as REFERENCE_TIME) as HRESULT
	SetSyncSource as function(byval This as IDistributorNotify ptr, byval pClock as IReferenceClock ptr) as HRESULT
	NotifyGraphChange as function(byval This as IDistributorNotify ptr) as HRESULT
end type

type IDistributorNotify_
	lpVtbl as IDistributorNotifyVtbl ptr
end type

declare function IDistributorNotify_Stop_Proxy(byval This as IDistributorNotify ptr) as HRESULT
declare sub IDistributorNotify_Stop_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDistributorNotify_Pause_Proxy(byval This as IDistributorNotify ptr) as HRESULT
declare sub IDistributorNotify_Pause_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDistributorNotify_Run_Proxy(byval This as IDistributorNotify ptr, byval tStart as REFERENCE_TIME) as HRESULT
declare sub IDistributorNotify_Run_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDistributorNotify_SetSyncSource_Proxy(byval This as IDistributorNotify ptr, byval pClock as IReferenceClock ptr) as HRESULT
declare sub IDistributorNotify_SetSyncSource_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDistributorNotify_NotifyGraphChange_Proxy(byval This as IDistributorNotify ptr) as HRESULT
declare sub IDistributorNotify_NotifyGraphChange_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type __MIDL___MIDL_itf_strmif_0160_0001 as long
enum
	AM_STREAM_INFO_START_DEFINED = &h1
	AM_STREAM_INFO_STOP_DEFINED = &h2
	AM_STREAM_INFO_DISCARDING = &h4
	AM_STREAM_INFO_STOP_SEND_EXTRA = &h10
end enum

type AM_STREAM_INFO_FLAGS as __MIDL___MIDL_itf_strmif_0160_0001

type __MIDL___MIDL_itf_strmif_0160_0002
	tStart as REFERENCE_TIME
	tStop as REFERENCE_TIME
	dwStartCookie as DWORD
	dwStopCookie as DWORD
	dwFlags as DWORD
end type

type AM_STREAM_INFO as __MIDL___MIDL_itf_strmif_0160_0002

extern __MIDL_itf_strmif_0160_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0160_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IAMStreamControl_INTERFACE_DEFINED__

extern IID_IAMStreamControl as const IID

type IAMStreamControl as IAMStreamControl_

type IAMStreamControlVtbl
	QueryInterface as function(byval This as IAMStreamControl ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMStreamControl ptr) as ULONG
	Release as function(byval This as IAMStreamControl ptr) as ULONG
	StartAt as function(byval This as IAMStreamControl ptr, byval ptStart as const REFERENCE_TIME ptr, byval dwCookie as DWORD) as HRESULT
	StopAt as function(byval This as IAMStreamControl ptr, byval ptStop as const REFERENCE_TIME ptr, byval bSendExtra as WINBOOL, byval dwCookie as DWORD) as HRESULT
	GetInfo as function(byval This as IAMStreamControl ptr, byval pInfo as AM_STREAM_INFO ptr) as HRESULT
end type

type IAMStreamControl_
	lpVtbl as IAMStreamControlVtbl ptr
end type

declare function IAMStreamControl_StartAt_Proxy(byval This as IAMStreamControl ptr, byval ptStart as const REFERENCE_TIME ptr, byval dwCookie as DWORD) as HRESULT
declare sub IAMStreamControl_StartAt_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMStreamControl_StopAt_Proxy(byval This as IAMStreamControl ptr, byval ptStop as const REFERENCE_TIME ptr, byval bSendExtra as WINBOOL, byval dwCookie as DWORD) as HRESULT
declare sub IAMStreamControl_StopAt_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMStreamControl_GetInfo_Proxy(byval This as IAMStreamControl ptr, byval pInfo as AM_STREAM_INFO ptr) as HRESULT
declare sub IAMStreamControl_GetInfo_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IConfigInterleaving_INTERFACE_DEFINED__

type __MIDL_IConfigInterleaving_0001 as long
enum
	INTERLEAVE_NONE = 0
	INTERLEAVE_CAPTURE
	INTERLEAVE_FULL
	INTERLEAVE_NONE_BUFFERED
end enum

type InterleavingMode as __MIDL_IConfigInterleaving_0001

extern IID_IConfigInterleaving as const IID

type IConfigInterleaving as IConfigInterleaving_

type IConfigInterleavingVtbl
	QueryInterface as function(byval This as IConfigInterleaving ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IConfigInterleaving ptr) as ULONG
	Release as function(byval This as IConfigInterleaving ptr) as ULONG
	put_Mode as function(byval This as IConfigInterleaving ptr, byval mode as InterleavingMode) as HRESULT
	get_Mode as function(byval This as IConfigInterleaving ptr, byval pMode as InterleavingMode ptr) as HRESULT
	put_Interleaving as function(byval This as IConfigInterleaving ptr, byval prtInterleave as const REFERENCE_TIME ptr, byval prtPreroll as const REFERENCE_TIME ptr) as HRESULT
	get_Interleaving as function(byval This as IConfigInterleaving ptr, byval prtInterleave as REFERENCE_TIME ptr, byval prtPreroll as REFERENCE_TIME ptr) as HRESULT
end type

type IConfigInterleaving_
	lpVtbl as IConfigInterleavingVtbl ptr
end type

declare function IConfigInterleaving_put_Mode_Proxy(byval This as IConfigInterleaving ptr, byval mode as InterleavingMode) as HRESULT
declare sub IConfigInterleaving_put_Mode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IConfigInterleaving_get_Mode_Proxy(byval This as IConfigInterleaving ptr, byval pMode as InterleavingMode ptr) as HRESULT
declare sub IConfigInterleaving_get_Mode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IConfigInterleaving_put_Interleaving_Proxy(byval This as IConfigInterleaving ptr, byval prtInterleave as const REFERENCE_TIME ptr, byval prtPreroll as const REFERENCE_TIME ptr) as HRESULT
declare sub IConfigInterleaving_put_Interleaving_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IConfigInterleaving_get_Interleaving_Proxy(byval This as IConfigInterleaving ptr, byval prtInterleave as REFERENCE_TIME ptr, byval prtPreroll as REFERENCE_TIME ptr) as HRESULT
declare sub IConfigInterleaving_get_Interleaving_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IConfigAviMux_INTERFACE_DEFINED__

extern IID_IConfigAviMux as const IID

type IConfigAviMux as IConfigAviMux_

type IConfigAviMuxVtbl
	QueryInterface as function(byval This as IConfigAviMux ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IConfigAviMux ptr) as ULONG
	Release as function(byval This as IConfigAviMux ptr) as ULONG
	SetMasterStream as function(byval This as IConfigAviMux ptr, byval iStream as LONG) as HRESULT
	GetMasterStream as function(byval This as IConfigAviMux ptr, byval pStream as LONG ptr) as HRESULT
	SetOutputCompatibilityIndex as function(byval This as IConfigAviMux ptr, byval fOldIndex as WINBOOL) as HRESULT
	GetOutputCompatibilityIndex as function(byval This as IConfigAviMux ptr, byval pfOldIndex as WINBOOL ptr) as HRESULT
end type

type IConfigAviMux_
	lpVtbl as IConfigAviMuxVtbl ptr
end type

declare function IConfigAviMux_SetMasterStream_Proxy(byval This as IConfigAviMux ptr, byval iStream as LONG) as HRESULT
declare sub IConfigAviMux_SetMasterStream_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IConfigAviMux_GetMasterStream_Proxy(byval This as IConfigAviMux ptr, byval pStream as LONG ptr) as HRESULT
declare sub IConfigAviMux_GetMasterStream_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IConfigAviMux_SetOutputCompatibilityIndex_Proxy(byval This as IConfigAviMux ptr, byval fOldIndex as WINBOOL) as HRESULT
declare sub IConfigAviMux_SetOutputCompatibilityIndex_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IConfigAviMux_GetOutputCompatibilityIndex_Proxy(byval This as IConfigAviMux ptr, byval pfOldIndex as WINBOOL ptr) as HRESULT
declare sub IConfigAviMux_GetOutputCompatibilityIndex_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type __MIDL___MIDL_itf_strmif_0167_0001 as long
enum
	CompressionCaps_CanQuality = &h1
	CompressionCaps_CanCrunch = &h2
	CompressionCaps_CanKeyFrame = &h4
	CompressionCaps_CanBFrame = &h8
	CompressionCaps_CanWindow = &h10
end enum

type CompressionCaps as __MIDL___MIDL_itf_strmif_0167_0001

extern __MIDL_itf_strmif_0167_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0167_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IAMVideoCompression_INTERFACE_DEFINED__

extern IID_IAMVideoCompression as const IID

type IAMVideoCompression as IAMVideoCompression_

type IAMVideoCompressionVtbl
	QueryInterface as function(byval This as IAMVideoCompression ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMVideoCompression ptr) as ULONG
	Release as function(byval This as IAMVideoCompression ptr) as ULONG
	put_KeyFrameRate as function(byval This as IAMVideoCompression ptr, byval KeyFrameRate as LONG) as HRESULT
	get_KeyFrameRate as function(byval This as IAMVideoCompression ptr, byval pKeyFrameRate as LONG ptr) as HRESULT
	put_PFramesPerKeyFrame as function(byval This as IAMVideoCompression ptr, byval PFramesPerKeyFrame as LONG) as HRESULT
	get_PFramesPerKeyFrame as function(byval This as IAMVideoCompression ptr, byval pPFramesPerKeyFrame as LONG ptr) as HRESULT
	put_Quality as function(byval This as IAMVideoCompression ptr, byval Quality as double) as HRESULT
	get_Quality as function(byval This as IAMVideoCompression ptr, byval pQuality as double ptr) as HRESULT
	put_WindowSize as function(byval This as IAMVideoCompression ptr, byval WindowSize as DWORDLONG) as HRESULT
	get_WindowSize as function(byval This as IAMVideoCompression ptr, byval pWindowSize as DWORDLONG ptr) as HRESULT
	GetInfo as function(byval This as IAMVideoCompression ptr, byval pszVersion as wstring ptr, byval pcbVersion as long ptr, byval pszDescription as LPWSTR, byval pcbDescription as long ptr, byval pDefaultKeyFrameRate as LONG ptr, byval pDefaultPFramesPerKey as LONG ptr, byval pDefaultQuality as double ptr, byval pCapabilities as LONG ptr) as HRESULT
	OverrideKeyFrame as function(byval This as IAMVideoCompression ptr, byval FrameNumber as LONG) as HRESULT
	OverrideFrameSize as function(byval This as IAMVideoCompression ptr, byval FrameNumber as LONG, byval Size as LONG) as HRESULT
end type

type IAMVideoCompression_
	lpVtbl as IAMVideoCompressionVtbl ptr
end type

declare function IAMVideoCompression_put_KeyFrameRate_Proxy(byval This as IAMVideoCompression ptr, byval KeyFrameRate as LONG) as HRESULT
declare sub IAMVideoCompression_put_KeyFrameRate_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVideoCompression_get_KeyFrameRate_Proxy(byval This as IAMVideoCompression ptr, byval pKeyFrameRate as LONG ptr) as HRESULT
declare sub IAMVideoCompression_get_KeyFrameRate_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVideoCompression_put_PFramesPerKeyFrame_Proxy(byval This as IAMVideoCompression ptr, byval PFramesPerKeyFrame as LONG) as HRESULT
declare sub IAMVideoCompression_put_PFramesPerKeyFrame_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVideoCompression_get_PFramesPerKeyFrame_Proxy(byval This as IAMVideoCompression ptr, byval pPFramesPerKeyFrame as LONG ptr) as HRESULT
declare sub IAMVideoCompression_get_PFramesPerKeyFrame_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVideoCompression_put_Quality_Proxy(byval This as IAMVideoCompression ptr, byval Quality as double) as HRESULT
declare sub IAMVideoCompression_put_Quality_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVideoCompression_get_Quality_Proxy(byval This as IAMVideoCompression ptr, byval pQuality as double ptr) as HRESULT
declare sub IAMVideoCompression_get_Quality_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVideoCompression_put_WindowSize_Proxy(byval This as IAMVideoCompression ptr, byval WindowSize as DWORDLONG) as HRESULT
declare sub IAMVideoCompression_put_WindowSize_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVideoCompression_get_WindowSize_Proxy(byval This as IAMVideoCompression ptr, byval pWindowSize as DWORDLONG ptr) as HRESULT
declare sub IAMVideoCompression_get_WindowSize_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVideoCompression_GetInfo_Proxy(byval This as IAMVideoCompression ptr, byval pszVersion as wstring ptr, byval pcbVersion as long ptr, byval pszDescription as LPWSTR, byval pcbDescription as long ptr, byval pDefaultKeyFrameRate as LONG ptr, byval pDefaultPFramesPerKey as LONG ptr, byval pDefaultQuality as double ptr, byval pCapabilities as LONG ptr) as HRESULT
declare sub IAMVideoCompression_GetInfo_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVideoCompression_OverrideKeyFrame_Proxy(byval This as IAMVideoCompression ptr, byval FrameNumber as LONG) as HRESULT
declare sub IAMVideoCompression_OverrideKeyFrame_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVideoCompression_OverrideFrameSize_Proxy(byval This as IAMVideoCompression ptr, byval FrameNumber as LONG, byval Size as LONG) as HRESULT
declare sub IAMVideoCompression_OverrideFrameSize_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type __MIDL___MIDL_itf_strmif_0168_0001 as long
enum
	VfwCaptureDialog_Source = &h1
	VfwCaptureDialog_Format = &h2
	VfwCaptureDialog_Display = &h4
end enum

type VfwCaptureDialogs as __MIDL___MIDL_itf_strmif_0168_0001

type __MIDL___MIDL_itf_strmif_0168_0002 as long
enum
	VfwCompressDialog_Config = &h1
	VfwCompressDialog_About = &h2
	VfwCompressDialog_QueryConfig = &h4
	VfwCompressDialog_QueryAbout = &h8
end enum

type VfwCompressDialogs as __MIDL___MIDL_itf_strmif_0168_0002

extern __MIDL_itf_strmif_0168_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0168_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IAMVfwCaptureDialogs_INTERFACE_DEFINED__

extern IID_IAMVfwCaptureDialogs as const IID

type IAMVfwCaptureDialogs as IAMVfwCaptureDialogs_

type IAMVfwCaptureDialogsVtbl
	QueryInterface as function(byval This as IAMVfwCaptureDialogs ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMVfwCaptureDialogs ptr) as ULONG
	Release as function(byval This as IAMVfwCaptureDialogs ptr) as ULONG
	HasDialog as function(byval This as IAMVfwCaptureDialogs ptr, byval iDialog as long) as HRESULT
	ShowDialog as function(byval This as IAMVfwCaptureDialogs ptr, byval iDialog as long, byval hwnd as HWND) as HRESULT
	SendDriverMessage as function(byval This as IAMVfwCaptureDialogs ptr, byval iDialog as long, byval uMsg as long, byval dw1 as LONG, byval dw2 as LONG) as HRESULT
end type

type IAMVfwCaptureDialogs_
	lpVtbl as IAMVfwCaptureDialogsVtbl ptr
end type

declare function IAMVfwCaptureDialogs_HasDialog_Proxy(byval This as IAMVfwCaptureDialogs ptr, byval iDialog as long) as HRESULT
declare sub IAMVfwCaptureDialogs_HasDialog_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVfwCaptureDialogs_ShowDialog_Proxy(byval This as IAMVfwCaptureDialogs ptr, byval iDialog as long, byval hwnd as HWND) as HRESULT
declare sub IAMVfwCaptureDialogs_ShowDialog_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVfwCaptureDialogs_SendDriverMessage_Proxy(byval This as IAMVfwCaptureDialogs ptr, byval iDialog as long, byval uMsg as long, byval dw1 as LONG, byval dw2 as LONG) as HRESULT
declare sub IAMVfwCaptureDialogs_SendDriverMessage_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IAMVfwCompressDialogs_INTERFACE_DEFINED__

extern IID_IAMVfwCompressDialogs as const IID

type IAMVfwCompressDialogs as IAMVfwCompressDialogs_

type IAMVfwCompressDialogsVtbl
	QueryInterface as function(byval This as IAMVfwCompressDialogs ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMVfwCompressDialogs ptr) as ULONG
	Release as function(byval This as IAMVfwCompressDialogs ptr) as ULONG
	ShowDialog as function(byval This as IAMVfwCompressDialogs ptr, byval iDialog as long, byval hwnd as HWND) as HRESULT
	GetState as function(byval This as IAMVfwCompressDialogs ptr, byval pState as LPVOID, byval pcbState as long ptr) as HRESULT
	SetState as function(byval This as IAMVfwCompressDialogs ptr, byval pState as LPVOID, byval cbState as long) as HRESULT
	SendDriverMessage as function(byval This as IAMVfwCompressDialogs ptr, byval uMsg as long, byval dw1 as LONG, byval dw2 as LONG) as HRESULT
end type

type IAMVfwCompressDialogs_
	lpVtbl as IAMVfwCompressDialogsVtbl ptr
end type

declare function IAMVfwCompressDialogs_ShowDialog_Proxy(byval This as IAMVfwCompressDialogs ptr, byval iDialog as long, byval hwnd as HWND) as HRESULT
declare sub IAMVfwCompressDialogs_ShowDialog_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVfwCompressDialogs_GetState_Proxy(byval This as IAMVfwCompressDialogs ptr, byval pState as LPVOID, byval pcbState as long ptr) as HRESULT
declare sub IAMVfwCompressDialogs_GetState_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVfwCompressDialogs_SetState_Proxy(byval This as IAMVfwCompressDialogs ptr, byval pState as LPVOID, byval cbState as long) as HRESULT
declare sub IAMVfwCompressDialogs_SetState_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVfwCompressDialogs_SendDriverMessage_Proxy(byval This as IAMVfwCompressDialogs ptr, byval uMsg as long, byval dw1 as LONG, byval dw2 as LONG) as HRESULT
declare sub IAMVfwCompressDialogs_SendDriverMessage_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IAMDroppedFrames_INTERFACE_DEFINED__

extern IID_IAMDroppedFrames as const IID

type IAMDroppedFrames as IAMDroppedFrames_

type IAMDroppedFramesVtbl
	QueryInterface as function(byval This as IAMDroppedFrames ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMDroppedFrames ptr) as ULONG
	Release as function(byval This as IAMDroppedFrames ptr) as ULONG
	GetNumDropped as function(byval This as IAMDroppedFrames ptr, byval plDropped as LONG ptr) as HRESULT
	GetNumNotDropped as function(byval This as IAMDroppedFrames ptr, byval plNotDropped as LONG ptr) as HRESULT
	GetDroppedInfo as function(byval This as IAMDroppedFrames ptr, byval lSize as LONG, byval plArray as LONG ptr, byval plNumCopied as LONG ptr) as HRESULT
	GetAverageFrameSize as function(byval This as IAMDroppedFrames ptr, byval plAverageSize as LONG ptr) as HRESULT
end type

type IAMDroppedFrames_
	lpVtbl as IAMDroppedFramesVtbl ptr
end type

declare function IAMDroppedFrames_GetNumDropped_Proxy(byval This as IAMDroppedFrames ptr, byval plDropped as LONG ptr) as HRESULT
declare sub IAMDroppedFrames_GetNumDropped_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMDroppedFrames_GetNumNotDropped_Proxy(byval This as IAMDroppedFrames ptr, byval plNotDropped as LONG ptr) as HRESULT
declare sub IAMDroppedFrames_GetNumNotDropped_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMDroppedFrames_GetDroppedInfo_Proxy(byval This as IAMDroppedFrames ptr, byval lSize as LONG, byval plArray as LONG ptr, byval plNumCopied as LONG ptr) as HRESULT
declare sub IAMDroppedFrames_GetDroppedInfo_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMDroppedFrames_GetAverageFrameSize_Proxy(byval This as IAMDroppedFrames ptr, byval plAverageSize as LONG ptr) as HRESULT
declare sub IAMDroppedFrames_GetAverageFrameSize_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define AMF_AUTOMATICGAIN (-1.0)

extern __MIDL_itf_strmif_0171_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0171_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IAMAudioInputMixer_INTERFACE_DEFINED__

extern IID_IAMAudioInputMixer as const IID

type IAMAudioInputMixer as IAMAudioInputMixer_

type IAMAudioInputMixerVtbl
	QueryInterface as function(byval This as IAMAudioInputMixer ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMAudioInputMixer ptr) as ULONG
	Release as function(byval This as IAMAudioInputMixer ptr) as ULONG
	put_Enable as function(byval This as IAMAudioInputMixer ptr, byval fEnable as WINBOOL) as HRESULT
	get_Enable as function(byval This as IAMAudioInputMixer ptr, byval pfEnable as WINBOOL ptr) as HRESULT
	put_Mono as function(byval This as IAMAudioInputMixer ptr, byval fMono as WINBOOL) as HRESULT
	get_Mono as function(byval This as IAMAudioInputMixer ptr, byval pfMono as WINBOOL ptr) as HRESULT
	put_MixLevel as function(byval This as IAMAudioInputMixer ptr, byval Level as double) as HRESULT
	get_MixLevel as function(byval This as IAMAudioInputMixer ptr, byval pLevel as double ptr) as HRESULT
	put_Pan as function(byval This as IAMAudioInputMixer ptr, byval Pan as double) as HRESULT
	get_Pan as function(byval This as IAMAudioInputMixer ptr, byval pPan as double ptr) as HRESULT
	put_Loudness as function(byval This as IAMAudioInputMixer ptr, byval fLoudness as WINBOOL) as HRESULT
	get_Loudness as function(byval This as IAMAudioInputMixer ptr, byval pfLoudness as WINBOOL ptr) as HRESULT
	put_Treble as function(byval This as IAMAudioInputMixer ptr, byval Treble as double) as HRESULT
	get_Treble as function(byval This as IAMAudioInputMixer ptr, byval pTreble as double ptr) as HRESULT
	get_TrebleRange as function(byval This as IAMAudioInputMixer ptr, byval pRange as double ptr) as HRESULT
	put_Bass as function(byval This as IAMAudioInputMixer ptr, byval Bass as double) as HRESULT
	get_Bass as function(byval This as IAMAudioInputMixer ptr, byval pBass as double ptr) as HRESULT
	get_BassRange as function(byval This as IAMAudioInputMixer ptr, byval pRange as double ptr) as HRESULT
end type

type IAMAudioInputMixer_
	lpVtbl as IAMAudioInputMixerVtbl ptr
end type

declare function IAMAudioInputMixer_put_Enable_Proxy(byval This as IAMAudioInputMixer ptr, byval fEnable as WINBOOL) as HRESULT
declare sub IAMAudioInputMixer_put_Enable_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAudioInputMixer_get_Enable_Proxy(byval This as IAMAudioInputMixer ptr, byval pfEnable as WINBOOL ptr) as HRESULT
declare sub IAMAudioInputMixer_get_Enable_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAudioInputMixer_put_Mono_Proxy(byval This as IAMAudioInputMixer ptr, byval fMono as WINBOOL) as HRESULT
declare sub IAMAudioInputMixer_put_Mono_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAudioInputMixer_get_Mono_Proxy(byval This as IAMAudioInputMixer ptr, byval pfMono as WINBOOL ptr) as HRESULT
declare sub IAMAudioInputMixer_get_Mono_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAudioInputMixer_put_MixLevel_Proxy(byval This as IAMAudioInputMixer ptr, byval Level as double) as HRESULT
declare sub IAMAudioInputMixer_put_MixLevel_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAudioInputMixer_get_MixLevel_Proxy(byval This as IAMAudioInputMixer ptr, byval pLevel as double ptr) as HRESULT
declare sub IAMAudioInputMixer_get_MixLevel_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAudioInputMixer_put_Pan_Proxy(byval This as IAMAudioInputMixer ptr, byval Pan as double) as HRESULT
declare sub IAMAudioInputMixer_put_Pan_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAudioInputMixer_get_Pan_Proxy(byval This as IAMAudioInputMixer ptr, byval pPan as double ptr) as HRESULT
declare sub IAMAudioInputMixer_get_Pan_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAudioInputMixer_put_Loudness_Proxy(byval This as IAMAudioInputMixer ptr, byval fLoudness as WINBOOL) as HRESULT
declare sub IAMAudioInputMixer_put_Loudness_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAudioInputMixer_get_Loudness_Proxy(byval This as IAMAudioInputMixer ptr, byval pfLoudness as WINBOOL ptr) as HRESULT
declare sub IAMAudioInputMixer_get_Loudness_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAudioInputMixer_put_Treble_Proxy(byval This as IAMAudioInputMixer ptr, byval Treble as double) as HRESULT
declare sub IAMAudioInputMixer_put_Treble_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAudioInputMixer_get_Treble_Proxy(byval This as IAMAudioInputMixer ptr, byval pTreble as double ptr) as HRESULT
declare sub IAMAudioInputMixer_get_Treble_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAudioInputMixer_get_TrebleRange_Proxy(byval This as IAMAudioInputMixer ptr, byval pRange as double ptr) as HRESULT
declare sub IAMAudioInputMixer_get_TrebleRange_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAudioInputMixer_put_Bass_Proxy(byval This as IAMAudioInputMixer ptr, byval Bass as double) as HRESULT
declare sub IAMAudioInputMixer_put_Bass_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAudioInputMixer_get_Bass_Proxy(byval This as IAMAudioInputMixer ptr, byval pBass as double ptr) as HRESULT
declare sub IAMAudioInputMixer_get_Bass_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAudioInputMixer_get_BassRange_Proxy(byval This as IAMAudioInputMixer ptr, byval pRange as double ptr) as HRESULT
declare sub IAMAudioInputMixer_get_BassRange_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IAMBufferNegotiation_INTERFACE_DEFINED__

extern IID_IAMBufferNegotiation as const IID

type IAMBufferNegotiation as IAMBufferNegotiation_

type IAMBufferNegotiationVtbl
	QueryInterface as function(byval This as IAMBufferNegotiation ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMBufferNegotiation ptr) as ULONG
	Release as function(byval This as IAMBufferNegotiation ptr) as ULONG
	SuggestAllocatorProperties as function(byval This as IAMBufferNegotiation ptr, byval pprop as const ALLOCATOR_PROPERTIES ptr) as HRESULT
	GetAllocatorProperties as function(byval This as IAMBufferNegotiation ptr, byval pprop as ALLOCATOR_PROPERTIES ptr) as HRESULT
end type

type IAMBufferNegotiation_
	lpVtbl as IAMBufferNegotiationVtbl ptr
end type

declare function IAMBufferNegotiation_SuggestAllocatorProperties_Proxy(byval This as IAMBufferNegotiation ptr, byval pprop as const ALLOCATOR_PROPERTIES ptr) as HRESULT
declare sub IAMBufferNegotiation_SuggestAllocatorProperties_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMBufferNegotiation_GetAllocatorProperties_Proxy(byval This as IAMBufferNegotiation ptr, byval pprop as ALLOCATOR_PROPERTIES ptr) as HRESULT
declare sub IAMBufferNegotiation_GetAllocatorProperties_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type tagAnalogVideoStandard as long
enum
	AnalogVideo_None = 0
	AnalogVideo_NTSC_M = &h1
	AnalogVideo_NTSC_M_J = &h2
	AnalogVideo_NTSC_433 = &h4
	AnalogVideo_PAL_B = &h10
	AnalogVideo_PAL_D = &h20
	AnalogVideo_PAL_G = &h40
	AnalogVideo_PAL_H = &h80
	AnalogVideo_PAL_I = &h100
	AnalogVideo_PAL_M = &h200
	AnalogVideo_PAL_N = &h400
	AnalogVideo_PAL_60 = &h800
	AnalogVideo_SECAM_B = &h1000
	AnalogVideo_SECAM_D = &h2000
	AnalogVideo_SECAM_G = &h4000
	AnalogVideo_SECAM_H = &h8000
	AnalogVideo_SECAM_K = &h10000
	AnalogVideo_SECAM_K1 = &h20000
	AnalogVideo_SECAM_L = &h40000
	AnalogVideo_SECAM_L1 = &h80000
	AnalogVideo_PAL_N_COMBO = &h100000
	AnalogVideoMask_MCE_NTSC = (((((AnalogVideo_NTSC_M or AnalogVideo_NTSC_M_J) or AnalogVideo_NTSC_433) or AnalogVideo_PAL_M) or AnalogVideo_PAL_N) or AnalogVideo_PAL_60) or AnalogVideo_PAL_N_COMBO
	AnalogVideoMask_MCE_PAL = (((AnalogVideo_PAL_B or AnalogVideo_PAL_D) or AnalogVideo_PAL_G) or AnalogVideo_PAL_H) or AnalogVideo_PAL_I
	AnalogVideoMask_MCE_SECAM = ((((((AnalogVideo_SECAM_B or AnalogVideo_SECAM_D) or AnalogVideo_SECAM_G) or AnalogVideo_SECAM_H) or AnalogVideo_SECAM_K) or AnalogVideo_SECAM_K1) or AnalogVideo_SECAM_L) or AnalogVideo_SECAM_L1
end enum

type AnalogVideoStandard as tagAnalogVideoStandard

type tagTunerInputType as long
enum
	TunerInputCable = 0
	TunerInputAntenna = TunerInputCable + 1
end enum

type TunerInputType as tagTunerInputType

#define AnalogVideo_NTSC_Mask &h00000007
#define AnalogVideo_PAL_Mask &h00100FF0
#define AnalogVideo_SECAM_Mask &h000FF000

type __MIDL___MIDL_itf_strmif_0173_0001 as long
enum
	VideoCopyProtectionMacrovisionBasic = 0
	VideoCopyProtectionMacrovisionCBI = VideoCopyProtectionMacrovisionBasic + 1
end enum

type VideoCopyProtectionType as __MIDL___MIDL_itf_strmif_0173_0001

type tagPhysicalConnectorType as long
enum
	PhysConn_Video_Tuner = 1
	PhysConn_Video_Composite
	PhysConn_Video_SVideo
	PhysConn_Video_RGB
	PhysConn_Video_YRYBY
	PhysConn_Video_SerialDigital
	PhysConn_Video_ParallelDigital
	PhysConn_Video_SCSI
	PhysConn_Video_AUX
	PhysConn_Video_1394
	PhysConn_Video_USB
	PhysConn_Video_VideoDecoder
	PhysConn_Video_VideoEncoder
	PhysConn_Video_SCART
	PhysConn_Video_Black
	PhysConn_Audio_Tuner = &h1000
	PhysConn_Audio_Line = &h1001
	PhysConn_Audio_Mic = &h1002
	PhysConn_Audio_AESDigital = &h1003
	PhysConn_Audio_SPDIFDigital = &h1004
	PhysConn_Audio_SCSI = &h1005
	PhysConn_Audio_AUX = &h1006
	PhysConn_Audio_1394 = &h1007
	PhysConn_Audio_USB = &h1008
	PhysConn_Audio_AudioDecoder = &h1009
end enum

type PhysicalConnectorType as tagPhysicalConnectorType

extern __MIDL_itf_strmif_0173_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0173_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IAMAnalogVideoDecoder_INTERFACE_DEFINED__

extern IID_IAMAnalogVideoDecoder as const IID

type IAMAnalogVideoDecoder as IAMAnalogVideoDecoder_

type IAMAnalogVideoDecoderVtbl
	QueryInterface as function(byval This as IAMAnalogVideoDecoder ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMAnalogVideoDecoder ptr) as ULONG
	Release as function(byval This as IAMAnalogVideoDecoder ptr) as ULONG
	get_AvailableTVFormats as function(byval This as IAMAnalogVideoDecoder ptr, byval lAnalogVideoStandard as LONG ptr) as HRESULT
	put_TVFormat as function(byval This as IAMAnalogVideoDecoder ptr, byval lAnalogVideoStandard as LONG) as HRESULT
	get_TVFormat as function(byval This as IAMAnalogVideoDecoder ptr, byval plAnalogVideoStandard as LONG ptr) as HRESULT
	get_HorizontalLocked as function(byval This as IAMAnalogVideoDecoder ptr, byval plLocked as LONG ptr) as HRESULT
	put_VCRHorizontalLocking as function(byval This as IAMAnalogVideoDecoder ptr, byval lVCRHorizontalLocking as LONG) as HRESULT
	get_VCRHorizontalLocking as function(byval This as IAMAnalogVideoDecoder ptr, byval plVCRHorizontalLocking as LONG ptr) as HRESULT
	get_NumberOfLines as function(byval This as IAMAnalogVideoDecoder ptr, byval plNumberOfLines as LONG ptr) as HRESULT
	put_OutputEnable as function(byval This as IAMAnalogVideoDecoder ptr, byval lOutputEnable as LONG) as HRESULT
	get_OutputEnable as function(byval This as IAMAnalogVideoDecoder ptr, byval plOutputEnable as LONG ptr) as HRESULT
end type

type IAMAnalogVideoDecoder_
	lpVtbl as IAMAnalogVideoDecoderVtbl ptr
end type

declare function IAMAnalogVideoDecoder_get_AvailableTVFormats_Proxy(byval This as IAMAnalogVideoDecoder ptr, byval lAnalogVideoStandard as LONG ptr) as HRESULT
declare sub IAMAnalogVideoDecoder_get_AvailableTVFormats_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAnalogVideoDecoder_put_TVFormat_Proxy(byval This as IAMAnalogVideoDecoder ptr, byval lAnalogVideoStandard as LONG) as HRESULT
declare sub IAMAnalogVideoDecoder_put_TVFormat_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAnalogVideoDecoder_get_TVFormat_Proxy(byval This as IAMAnalogVideoDecoder ptr, byval plAnalogVideoStandard as LONG ptr) as HRESULT
declare sub IAMAnalogVideoDecoder_get_TVFormat_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAnalogVideoDecoder_get_HorizontalLocked_Proxy(byval This as IAMAnalogVideoDecoder ptr, byval plLocked as LONG ptr) as HRESULT
declare sub IAMAnalogVideoDecoder_get_HorizontalLocked_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAnalogVideoDecoder_put_VCRHorizontalLocking_Proxy(byval This as IAMAnalogVideoDecoder ptr, byval lVCRHorizontalLocking as LONG) as HRESULT
declare sub IAMAnalogVideoDecoder_put_VCRHorizontalLocking_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAnalogVideoDecoder_get_VCRHorizontalLocking_Proxy(byval This as IAMAnalogVideoDecoder ptr, byval plVCRHorizontalLocking as LONG ptr) as HRESULT
declare sub IAMAnalogVideoDecoder_get_VCRHorizontalLocking_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAnalogVideoDecoder_get_NumberOfLines_Proxy(byval This as IAMAnalogVideoDecoder ptr, byval plNumberOfLines as LONG ptr) as HRESULT
declare sub IAMAnalogVideoDecoder_get_NumberOfLines_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAnalogVideoDecoder_put_OutputEnable_Proxy(byval This as IAMAnalogVideoDecoder ptr, byval lOutputEnable as LONG) as HRESULT
declare sub IAMAnalogVideoDecoder_put_OutputEnable_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAnalogVideoDecoder_get_OutputEnable_Proxy(byval This as IAMAnalogVideoDecoder ptr, byval plOutputEnable as LONG ptr) as HRESULT
declare sub IAMAnalogVideoDecoder_get_OutputEnable_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type tagCameraControlProperty as long
enum
	CameraControl_Pan = 0
	CameraControl_Tilt
	CameraControl_Roll
	CameraControl_Zoom
	CameraControl_Exposure
	CameraControl_Iris
	CameraControl_Focus
end enum

type CameraControlProperty as tagCameraControlProperty

type tagCameraControlFlags as long
enum
	CameraControl_Flags_Auto = &h1
	CameraControl_Flags_Manual = &h2
end enum

type CameraControlFlags as tagCameraControlFlags

extern __MIDL_itf_strmif_0175_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0175_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IAMCameraControl_INTERFACE_DEFINED__

extern IID_IAMCameraControl as const IID

type IAMCameraControl as IAMCameraControl_

type IAMCameraControlVtbl
	QueryInterface as function(byval This as IAMCameraControl ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMCameraControl ptr) as ULONG
	Release as function(byval This as IAMCameraControl ptr) as ULONG
	GetRange as function(byval This as IAMCameraControl ptr, byval Property as LONG, byval pMin as LONG ptr, byval pMax as LONG ptr, byval pSteppingDelta as LONG ptr, byval pDefault as LONG ptr, byval pCapsFlags as LONG ptr) as HRESULT
	Set as function(byval This as IAMCameraControl ptr, byval Property as LONG, byval lValue as LONG, byval Flags as LONG) as HRESULT
	Get as function(byval This as IAMCameraControl ptr, byval Property as LONG, byval lValue as LONG ptr, byval Flags as LONG ptr) as HRESULT
end type

type IAMCameraControl_
	lpVtbl as IAMCameraControlVtbl ptr
end type

declare function IAMCameraControl_GetRange_Proxy(byval This as IAMCameraControl ptr, byval Property as LONG, byval pMin as LONG ptr, byval pMax as LONG ptr, byval pSteppingDelta as LONG ptr, byval pDefault as LONG ptr, byval pCapsFlags as LONG ptr) as HRESULT
declare sub IAMCameraControl_GetRange_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMCameraControl_Set_Proxy(byval This as IAMCameraControl ptr, byval Property as LONG, byval lValue as LONG, byval Flags as LONG) as HRESULT
declare sub IAMCameraControl_Set_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMCameraControl_Get_Proxy(byval This as IAMCameraControl ptr, byval Property as LONG, byval lValue as LONG ptr, byval Flags as LONG ptr) as HRESULT
declare sub IAMCameraControl_Get_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type tagVideoControlFlags as long
enum
	VideoControlFlag_FlipHorizontal = &h1
	VideoControlFlag_FlipVertical = &h2
	VideoControlFlag_ExternalTriggerEnable = &h4
	VideoControlFlag_Trigger = &h8
end enum

type VideoControlFlags as tagVideoControlFlags

extern __MIDL_itf_strmif_0176_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0176_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IAMVideoControl_INTERFACE_DEFINED__

extern IID_IAMVideoControl as const IID

type IAMVideoControl as IAMVideoControl_

type IAMVideoControlVtbl
	QueryInterface as function(byval This as IAMVideoControl ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMVideoControl ptr) as ULONG
	Release as function(byval This as IAMVideoControl ptr) as ULONG
	GetCaps as function(byval This as IAMVideoControl ptr, byval pPin as IPin ptr, byval pCapsFlags as LONG ptr) as HRESULT
	SetMode as function(byval This as IAMVideoControl ptr, byval pPin as IPin ptr, byval Mode as LONG) as HRESULT
	GetMode as function(byval This as IAMVideoControl ptr, byval pPin as IPin ptr, byval Mode as LONG ptr) as HRESULT
	GetCurrentActualFrameRate as function(byval This as IAMVideoControl ptr, byval pPin as IPin ptr, byval ActualFrameRate as LONGLONG ptr) as HRESULT
	GetMaxAvailableFrameRate as function(byval This as IAMVideoControl ptr, byval pPin as IPin ptr, byval iIndex as LONG, byval Dimensions as SIZE, byval MaxAvailableFrameRate as LONGLONG ptr) as HRESULT
	GetFrameRateList as function(byval This as IAMVideoControl ptr, byval pPin as IPin ptr, byval iIndex as LONG, byval Dimensions as SIZE, byval ListSize as LONG ptr, byval FrameRates as LONGLONG ptr ptr) as HRESULT
end type

type IAMVideoControl_
	lpVtbl as IAMVideoControlVtbl ptr
end type

declare function IAMVideoControl_GetCaps_Proxy(byval This as IAMVideoControl ptr, byval pPin as IPin ptr, byval pCapsFlags as LONG ptr) as HRESULT
declare sub IAMVideoControl_GetCaps_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVideoControl_SetMode_Proxy(byval This as IAMVideoControl ptr, byval pPin as IPin ptr, byval Mode as LONG) as HRESULT
declare sub IAMVideoControl_SetMode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVideoControl_GetMode_Proxy(byval This as IAMVideoControl ptr, byval pPin as IPin ptr, byval Mode as LONG ptr) as HRESULT
declare sub IAMVideoControl_GetMode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVideoControl_GetCurrentActualFrameRate_Proxy(byval This as IAMVideoControl ptr, byval pPin as IPin ptr, byval ActualFrameRate as LONGLONG ptr) as HRESULT
declare sub IAMVideoControl_GetCurrentActualFrameRate_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVideoControl_GetMaxAvailableFrameRate_Proxy(byval This as IAMVideoControl ptr, byval pPin as IPin ptr, byval iIndex as LONG, byval Dimensions as SIZE, byval MaxAvailableFrameRate as LONGLONG ptr) as HRESULT
declare sub IAMVideoControl_GetMaxAvailableFrameRate_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVideoControl_GetFrameRateList_Proxy(byval This as IAMVideoControl ptr, byval pPin as IPin ptr, byval iIndex as LONG, byval Dimensions as SIZE, byval ListSize as LONG ptr, byval FrameRates as LONGLONG ptr ptr) as HRESULT
declare sub IAMVideoControl_GetFrameRateList_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IAMCrossbar_INTERFACE_DEFINED__

extern IID_IAMCrossbar as const IID

type IAMCrossbar as IAMCrossbar_

type IAMCrossbarVtbl
	QueryInterface as function(byval This as IAMCrossbar ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMCrossbar ptr) as ULONG
	Release as function(byval This as IAMCrossbar ptr) as ULONG
	get_PinCounts as function(byval This as IAMCrossbar ptr, byval OutputPinCount as LONG ptr, byval InputPinCount as LONG ptr) as HRESULT
	CanRoute as function(byval This as IAMCrossbar ptr, byval OutputPinIndex as LONG, byval InputPinIndex as LONG) as HRESULT
	Route as function(byval This as IAMCrossbar ptr, byval OutputPinIndex as LONG, byval InputPinIndex as LONG) as HRESULT
	get_IsRoutedTo as function(byval This as IAMCrossbar ptr, byval OutputPinIndex as LONG, byval InputPinIndex as LONG ptr) as HRESULT
	get_CrossbarPinInfo as function(byval This as IAMCrossbar ptr, byval IsInputPin as WINBOOL, byval PinIndex as LONG, byval PinIndexRelated as LONG ptr, byval PhysicalType as LONG ptr) as HRESULT
end type

type IAMCrossbar_
	lpVtbl as IAMCrossbarVtbl ptr
end type

declare function IAMCrossbar_get_PinCounts_Proxy(byval This as IAMCrossbar ptr, byval OutputPinCount as LONG ptr, byval InputPinCount as LONG ptr) as HRESULT
declare sub IAMCrossbar_get_PinCounts_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMCrossbar_CanRoute_Proxy(byval This as IAMCrossbar ptr, byval OutputPinIndex as LONG, byval InputPinIndex as LONG) as HRESULT
declare sub IAMCrossbar_CanRoute_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMCrossbar_Route_Proxy(byval This as IAMCrossbar ptr, byval OutputPinIndex as LONG, byval InputPinIndex as LONG) as HRESULT
declare sub IAMCrossbar_Route_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMCrossbar_get_IsRoutedTo_Proxy(byval This as IAMCrossbar ptr, byval OutputPinIndex as LONG, byval InputPinIndex as LONG ptr) as HRESULT
declare sub IAMCrossbar_get_IsRoutedTo_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMCrossbar_get_CrossbarPinInfo_Proxy(byval This as IAMCrossbar ptr, byval IsInputPin as WINBOOL, byval PinIndex as LONG, byval PinIndexRelated as LONG ptr, byval PhysicalType as LONG ptr) as HRESULT
declare sub IAMCrossbar_get_CrossbarPinInfo_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type tagAMTunerSubChannel as long
enum
	AMTUNER_SUBCHAN_NO_TUNE = -2
	AMTUNER_SUBCHAN_DEFAULT = -1
end enum

type AMTunerSubChannel as tagAMTunerSubChannel

type tagAMTunerSignalStrength as long
enum
	AMTUNER_HASNOSIGNALSTRENGTH = -1
	AMTUNER_NOSIGNAL = 0
	AMTUNER_SIGNALPRESENT = 1
end enum

type AMTunerSignalStrength as tagAMTunerSignalStrength

type tagAMTunerModeType as long
enum
	AMTUNER_MODE_DEFAULT = 0
	AMTUNER_MODE_TV = &h1
	AMTUNER_MODE_FM_RADIO = &h2
	AMTUNER_MODE_AM_RADIO = &h4
	AMTUNER_MODE_DSS = &h8
end enum

type AMTunerModeType as tagAMTunerModeType

type tagAMTunerEventType as long
enum
	AMTUNER_EVENT_CHANGED = &h1
end enum

type AMTunerEventType as tagAMTunerEventType

extern __MIDL_itf_strmif_0178_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0178_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IAMTuner_INTERFACE_DEFINED__

extern IID_IAMTuner as const IID

type IAMTunerNotification as IAMTunerNotification_
type IAMTuner as IAMTuner_

type IAMTunerVtbl
	QueryInterface as function(byval This as IAMTuner ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMTuner ptr) as ULONG
	Release as function(byval This as IAMTuner ptr) as ULONG
	put_Channel as function(byval This as IAMTuner ptr, byval lChannel as LONG, byval lVideoSubChannel as LONG, byval lAudioSubChannel as LONG) as HRESULT
	get_Channel as function(byval This as IAMTuner ptr, byval plChannel as LONG ptr, byval plVideoSubChannel as LONG ptr, byval plAudioSubChannel as LONG ptr) as HRESULT
	ChannelMinMax as function(byval This as IAMTuner ptr, byval lChannelMin as LONG ptr, byval lChannelMax as LONG ptr) as HRESULT
	put_CountryCode as function(byval This as IAMTuner ptr, byval lCountryCode as LONG) as HRESULT
	get_CountryCode as function(byval This as IAMTuner ptr, byval plCountryCode as LONG ptr) as HRESULT
	put_TuningSpace as function(byval This as IAMTuner ptr, byval lTuningSpace as LONG) as HRESULT
	get_TuningSpace as function(byval This as IAMTuner ptr, byval plTuningSpace as LONG ptr) as HRESULT
	Logon as function(byval This as IAMTuner ptr, byval hCurrentUser as HANDLE) as HRESULT
	Logout as function(byval This as IAMTuner ptr) as HRESULT
	SignalPresent as function(byval This as IAMTuner ptr, byval plSignalStrength as LONG ptr) as HRESULT
	put_Mode as function(byval This as IAMTuner ptr, byval lMode as AMTunerModeType) as HRESULT
	get_Mode as function(byval This as IAMTuner ptr, byval plMode as AMTunerModeType ptr) as HRESULT
	GetAvailableModes as function(byval This as IAMTuner ptr, byval plModes as LONG ptr) as HRESULT
	RegisterNotificationCallBack as function(byval This as IAMTuner ptr, byval pNotify as IAMTunerNotification ptr, byval lEvents as LONG) as HRESULT
	UnRegisterNotificationCallBack as function(byval This as IAMTuner ptr, byval pNotify as IAMTunerNotification ptr) as HRESULT
end type

type IAMTuner_
	lpVtbl as IAMTunerVtbl ptr
end type

declare function IAMTuner_put_Channel_Proxy(byval This as IAMTuner ptr, byval lChannel as LONG, byval lVideoSubChannel as LONG, byval lAudioSubChannel as LONG) as HRESULT
declare sub IAMTuner_put_Channel_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTuner_get_Channel_Proxy(byval This as IAMTuner ptr, byval plChannel as LONG ptr, byval plVideoSubChannel as LONG ptr, byval plAudioSubChannel as LONG ptr) as HRESULT
declare sub IAMTuner_get_Channel_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTuner_ChannelMinMax_Proxy(byval This as IAMTuner ptr, byval lChannelMin as LONG ptr, byval lChannelMax as LONG ptr) as HRESULT
declare sub IAMTuner_ChannelMinMax_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTuner_put_CountryCode_Proxy(byval This as IAMTuner ptr, byval lCountryCode as LONG) as HRESULT
declare sub IAMTuner_put_CountryCode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTuner_get_CountryCode_Proxy(byval This as IAMTuner ptr, byval plCountryCode as LONG ptr) as HRESULT
declare sub IAMTuner_get_CountryCode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTuner_put_TuningSpace_Proxy(byval This as IAMTuner ptr, byval lTuningSpace as LONG) as HRESULT
declare sub IAMTuner_put_TuningSpace_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTuner_get_TuningSpace_Proxy(byval This as IAMTuner ptr, byval plTuningSpace as LONG ptr) as HRESULT
declare sub IAMTuner_get_TuningSpace_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTuner_Logon_Proxy(byval This as IAMTuner ptr, byval hCurrentUser as HANDLE) as HRESULT
declare sub IAMTuner_Logon_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTuner_Logout_Proxy(byval This as IAMTuner ptr) as HRESULT
declare sub IAMTuner_Logout_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTuner_SignalPresent_Proxy(byval This as IAMTuner ptr, byval plSignalStrength as LONG ptr) as HRESULT
declare sub IAMTuner_SignalPresent_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTuner_put_Mode_Proxy(byval This as IAMTuner ptr, byval lMode as AMTunerModeType) as HRESULT
declare sub IAMTuner_put_Mode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTuner_get_Mode_Proxy(byval This as IAMTuner ptr, byval plMode as AMTunerModeType ptr) as HRESULT
declare sub IAMTuner_get_Mode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTuner_GetAvailableModes_Proxy(byval This as IAMTuner ptr, byval plModes as LONG ptr) as HRESULT
declare sub IAMTuner_GetAvailableModes_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTuner_RegisterNotificationCallBack_Proxy(byval This as IAMTuner ptr, byval pNotify as IAMTunerNotification ptr, byval lEvents as LONG) as HRESULT
declare sub IAMTuner_RegisterNotificationCallBack_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTuner_UnRegisterNotificationCallBack_Proxy(byval This as IAMTuner ptr, byval pNotify as IAMTunerNotification ptr) as HRESULT
declare sub IAMTuner_UnRegisterNotificationCallBack_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IAMTunerNotification_INTERFACE_DEFINED__

extern IID_IAMTunerNotification as const IID

type IAMTunerNotificationVtbl
	QueryInterface as function(byval This as IAMTunerNotification ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMTunerNotification ptr) as ULONG
	Release as function(byval This as IAMTunerNotification ptr) as ULONG
	OnEvent as function(byval This as IAMTunerNotification ptr, byval Event as AMTunerEventType) as HRESULT
end type

type IAMTunerNotification_
	lpVtbl as IAMTunerNotificationVtbl ptr
end type

declare function IAMTunerNotification_OnEvent_Proxy(byval This as IAMTunerNotification ptr, byval Event as AMTunerEventType) as HRESULT
declare sub IAMTunerNotification_OnEvent_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IAMTVTuner_INTERFACE_DEFINED__

extern IID_IAMTVTuner as const IID

type IAMTVTuner as IAMTVTuner_

type IAMTVTunerVtbl
	QueryInterface as function(byval This as IAMTVTuner ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMTVTuner ptr) as ULONG
	Release as function(byval This as IAMTVTuner ptr) as ULONG
	put_Channel as function(byval This as IAMTVTuner ptr, byval lChannel as LONG, byval lVideoSubChannel as LONG, byval lAudioSubChannel as LONG) as HRESULT
	get_Channel as function(byval This as IAMTVTuner ptr, byval plChannel as LONG ptr, byval plVideoSubChannel as LONG ptr, byval plAudioSubChannel as LONG ptr) as HRESULT
	ChannelMinMax as function(byval This as IAMTVTuner ptr, byval lChannelMin as LONG ptr, byval lChannelMax as LONG ptr) as HRESULT
	put_CountryCode as function(byval This as IAMTVTuner ptr, byval lCountryCode as LONG) as HRESULT
	get_CountryCode as function(byval This as IAMTVTuner ptr, byval plCountryCode as LONG ptr) as HRESULT
	put_TuningSpace as function(byval This as IAMTVTuner ptr, byval lTuningSpace as LONG) as HRESULT
	get_TuningSpace as function(byval This as IAMTVTuner ptr, byval plTuningSpace as LONG ptr) as HRESULT
	Logon as function(byval This as IAMTVTuner ptr, byval hCurrentUser as HANDLE) as HRESULT
	Logout as function(byval This as IAMTVTuner ptr) as HRESULT
	SignalPresent as function(byval This as IAMTVTuner ptr, byval plSignalStrength as LONG ptr) as HRESULT
	put_Mode as function(byval This as IAMTVTuner ptr, byval lMode as AMTunerModeType) as HRESULT
	get_Mode as function(byval This as IAMTVTuner ptr, byval plMode as AMTunerModeType ptr) as HRESULT
	GetAvailableModes as function(byval This as IAMTVTuner ptr, byval plModes as LONG ptr) as HRESULT
	RegisterNotificationCallBack as function(byval This as IAMTVTuner ptr, byval pNotify as IAMTunerNotification ptr, byval lEvents as LONG) as HRESULT
	UnRegisterNotificationCallBack as function(byval This as IAMTVTuner ptr, byval pNotify as IAMTunerNotification ptr) as HRESULT
	get_AvailableTVFormats as function(byval This as IAMTVTuner ptr, byval lAnalogVideoStandard as LONG ptr) as HRESULT
	get_TVFormat as function(byval This as IAMTVTuner ptr, byval plAnalogVideoStandard as LONG ptr) as HRESULT
	AutoTune as function(byval This as IAMTVTuner ptr, byval lChannel as LONG, byval plFoundSignal as LONG ptr) as HRESULT
	StoreAutoTune as function(byval This as IAMTVTuner ptr) as HRESULT
	get_NumInputConnections as function(byval This as IAMTVTuner ptr, byval plNumInputConnections as LONG ptr) as HRESULT
	put_InputType as function(byval This as IAMTVTuner ptr, byval lIndex as LONG, byval InputType as TunerInputType) as HRESULT
	get_InputType as function(byval This as IAMTVTuner ptr, byval lIndex as LONG, byval pInputType as TunerInputType ptr) as HRESULT
	put_ConnectInput as function(byval This as IAMTVTuner ptr, byval lIndex as LONG) as HRESULT
	get_ConnectInput as function(byval This as IAMTVTuner ptr, byval plIndex as LONG ptr) as HRESULT
	get_VideoFrequency as function(byval This as IAMTVTuner ptr, byval lFreq as LONG ptr) as HRESULT
	get_AudioFrequency as function(byval This as IAMTVTuner ptr, byval lFreq as LONG ptr) as HRESULT
end type

type IAMTVTuner_
	lpVtbl as IAMTVTunerVtbl ptr
end type

declare function IAMTVTuner_get_AvailableTVFormats_Proxy(byval This as IAMTVTuner ptr, byval lAnalogVideoStandard as LONG ptr) as HRESULT
declare sub IAMTVTuner_get_AvailableTVFormats_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTVTuner_get_TVFormat_Proxy(byval This as IAMTVTuner ptr, byval plAnalogVideoStandard as LONG ptr) as HRESULT
declare sub IAMTVTuner_get_TVFormat_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTVTuner_AutoTune_Proxy(byval This as IAMTVTuner ptr, byval lChannel as LONG, byval plFoundSignal as LONG ptr) as HRESULT
declare sub IAMTVTuner_AutoTune_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTVTuner_StoreAutoTune_Proxy(byval This as IAMTVTuner ptr) as HRESULT
declare sub IAMTVTuner_StoreAutoTune_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTVTuner_get_NumInputConnections_Proxy(byval This as IAMTVTuner ptr, byval plNumInputConnections as LONG ptr) as HRESULT
declare sub IAMTVTuner_get_NumInputConnections_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTVTuner_put_InputType_Proxy(byval This as IAMTVTuner ptr, byval lIndex as LONG, byval InputType as TunerInputType) as HRESULT
declare sub IAMTVTuner_put_InputType_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTVTuner_get_InputType_Proxy(byval This as IAMTVTuner ptr, byval lIndex as LONG, byval pInputType as TunerInputType ptr) as HRESULT
declare sub IAMTVTuner_get_InputType_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTVTuner_put_ConnectInput_Proxy(byval This as IAMTVTuner ptr, byval lIndex as LONG) as HRESULT
declare sub IAMTVTuner_put_ConnectInput_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTVTuner_get_ConnectInput_Proxy(byval This as IAMTVTuner ptr, byval plIndex as LONG ptr) as HRESULT
declare sub IAMTVTuner_get_ConnectInput_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTVTuner_get_VideoFrequency_Proxy(byval This as IAMTVTuner ptr, byval lFreq as LONG ptr) as HRESULT
declare sub IAMTVTuner_get_VideoFrequency_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTVTuner_get_AudioFrequency_Proxy(byval This as IAMTVTuner ptr, byval lFreq as LONG ptr) as HRESULT
declare sub IAMTVTuner_get_AudioFrequency_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IBPCSatelliteTuner_INTERFACE_DEFINED__

extern IID_IBPCSatelliteTuner as const IID

type IBPCSatelliteTuner as IBPCSatelliteTuner_

type IBPCSatelliteTunerVtbl
	QueryInterface as function(byval This as IBPCSatelliteTuner ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IBPCSatelliteTuner ptr) as ULONG
	Release as function(byval This as IBPCSatelliteTuner ptr) as ULONG
	put_Channel as function(byval This as IBPCSatelliteTuner ptr, byval lChannel as LONG, byval lVideoSubChannel as LONG, byval lAudioSubChannel as LONG) as HRESULT
	get_Channel as function(byval This as IBPCSatelliteTuner ptr, byval plChannel as LONG ptr, byval plVideoSubChannel as LONG ptr, byval plAudioSubChannel as LONG ptr) as HRESULT
	ChannelMinMax as function(byval This as IBPCSatelliteTuner ptr, byval lChannelMin as LONG ptr, byval lChannelMax as LONG ptr) as HRESULT
	put_CountryCode as function(byval This as IBPCSatelliteTuner ptr, byval lCountryCode as LONG) as HRESULT
	get_CountryCode as function(byval This as IBPCSatelliteTuner ptr, byval plCountryCode as LONG ptr) as HRESULT
	put_TuningSpace as function(byval This as IBPCSatelliteTuner ptr, byval lTuningSpace as LONG) as HRESULT
	get_TuningSpace as function(byval This as IBPCSatelliteTuner ptr, byval plTuningSpace as LONG ptr) as HRESULT
	Logon as function(byval This as IBPCSatelliteTuner ptr, byval hCurrentUser as HANDLE) as HRESULT
	Logout as function(byval This as IBPCSatelliteTuner ptr) as HRESULT
	SignalPresent as function(byval This as IBPCSatelliteTuner ptr, byval plSignalStrength as LONG ptr) as HRESULT
	put_Mode as function(byval This as IBPCSatelliteTuner ptr, byval lMode as AMTunerModeType) as HRESULT
	get_Mode as function(byval This as IBPCSatelliteTuner ptr, byval plMode as AMTunerModeType ptr) as HRESULT
	GetAvailableModes as function(byval This as IBPCSatelliteTuner ptr, byval plModes as LONG ptr) as HRESULT
	RegisterNotificationCallBack as function(byval This as IBPCSatelliteTuner ptr, byval pNotify as IAMTunerNotification ptr, byval lEvents as LONG) as HRESULT
	UnRegisterNotificationCallBack as function(byval This as IBPCSatelliteTuner ptr, byval pNotify as IAMTunerNotification ptr) as HRESULT
	get_DefaultSubChannelTypes as function(byval This as IBPCSatelliteTuner ptr, byval plDefaultVideoType as LONG ptr, byval plDefaultAudioType as LONG ptr) as HRESULT
	put_DefaultSubChannelTypes as function(byval This as IBPCSatelliteTuner ptr, byval lDefaultVideoType as LONG, byval lDefaultAudioType as LONG) as HRESULT
	IsTapingPermitted as function(byval This as IBPCSatelliteTuner ptr) as HRESULT
end type

type IBPCSatelliteTuner_
	lpVtbl as IBPCSatelliteTunerVtbl ptr
end type

declare function IBPCSatelliteTuner_get_DefaultSubChannelTypes_Proxy(byval This as IBPCSatelliteTuner ptr, byval plDefaultVideoType as LONG ptr, byval plDefaultAudioType as LONG ptr) as HRESULT
declare sub IBPCSatelliteTuner_get_DefaultSubChannelTypes_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBPCSatelliteTuner_put_DefaultSubChannelTypes_Proxy(byval This as IBPCSatelliteTuner ptr, byval lDefaultVideoType as LONG, byval lDefaultAudioType as LONG) as HRESULT
declare sub IBPCSatelliteTuner_put_DefaultSubChannelTypes_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBPCSatelliteTuner_IsTapingPermitted_Proxy(byval This as IBPCSatelliteTuner ptr) as HRESULT
declare sub IBPCSatelliteTuner_IsTapingPermitted_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type tagTVAudioMode as long
enum
	AMTVAUDIO_MODE_MONO = &h1
	AMTVAUDIO_MODE_STEREO = &h2
	AMTVAUDIO_MODE_LANG_A = &h10
	AMTVAUDIO_MODE_LANG_B = &h20
	AMTVAUDIO_MODE_LANG_C = &h40
end enum

type TVAudioMode as tagTVAudioMode

type tagAMTVAudioEventType as long
enum
	AMTVAUDIO_EVENT_CHANGED = &h1
end enum

type AMTVAudioEventType as tagAMTVAudioEventType

extern __MIDL_itf_strmif_0182_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0182_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IAMTVAudio_INTERFACE_DEFINED__

extern IID_IAMTVAudio as const IID

type IAMTVAudio as IAMTVAudio_

type IAMTVAudioVtbl
	QueryInterface as function(byval This as IAMTVAudio ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMTVAudio ptr) as ULONG
	Release as function(byval This as IAMTVAudio ptr) as ULONG
	GetHardwareSupportedTVAudioModes as function(byval This as IAMTVAudio ptr, byval plModes as LONG ptr) as HRESULT
	GetAvailableTVAudioModes as function(byval This as IAMTVAudio ptr, byval plModes as LONG ptr) as HRESULT
	get_TVAudioMode as function(byval This as IAMTVAudio ptr, byval plMode as LONG ptr) as HRESULT
	put_TVAudioMode as function(byval This as IAMTVAudio ptr, byval lMode as LONG) as HRESULT
	RegisterNotificationCallBack as function(byval This as IAMTVAudio ptr, byval pNotify as IAMTunerNotification ptr, byval lEvents as LONG) as HRESULT
	UnRegisterNotificationCallBack as function(byval This as IAMTVAudio ptr, byval pNotify as IAMTunerNotification ptr) as HRESULT
end type

type IAMTVAudio_
	lpVtbl as IAMTVAudioVtbl ptr
end type

declare function IAMTVAudio_GetHardwareSupportedTVAudioModes_Proxy(byval This as IAMTVAudio ptr, byval plModes as LONG ptr) as HRESULT
declare sub IAMTVAudio_GetHardwareSupportedTVAudioModes_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTVAudio_GetAvailableTVAudioModes_Proxy(byval This as IAMTVAudio ptr, byval plModes as LONG ptr) as HRESULT
declare sub IAMTVAudio_GetAvailableTVAudioModes_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTVAudio_get_TVAudioMode_Proxy(byval This as IAMTVAudio ptr, byval plMode as LONG ptr) as HRESULT
declare sub IAMTVAudio_get_TVAudioMode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTVAudio_put_TVAudioMode_Proxy(byval This as IAMTVAudio ptr, byval lMode as LONG) as HRESULT
declare sub IAMTVAudio_put_TVAudioMode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTVAudio_RegisterNotificationCallBack_Proxy(byval This as IAMTVAudio ptr, byval pNotify as IAMTunerNotification ptr, byval lEvents as LONG) as HRESULT
declare sub IAMTVAudio_RegisterNotificationCallBack_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTVAudio_UnRegisterNotificationCallBack_Proxy(byval This as IAMTVAudio ptr, byval pNotify as IAMTunerNotification ptr) as HRESULT
declare sub IAMTVAudio_UnRegisterNotificationCallBack_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IAMTVAudioNotification_INTERFACE_DEFINED__

extern IID_IAMTVAudioNotification as const IID

type IAMTVAudioNotification as IAMTVAudioNotification_

type IAMTVAudioNotificationVtbl
	QueryInterface as function(byval This as IAMTVAudioNotification ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMTVAudioNotification ptr) as ULONG
	Release as function(byval This as IAMTVAudioNotification ptr) as ULONG
	OnEvent as function(byval This as IAMTVAudioNotification ptr, byval Event as AMTVAudioEventType) as HRESULT
end type

type IAMTVAudioNotification_
	lpVtbl as IAMTVAudioNotificationVtbl ptr
end type

declare function IAMTVAudioNotification_OnEvent_Proxy(byval This as IAMTVAudioNotification ptr, byval Event as AMTVAudioEventType) as HRESULT
declare sub IAMTVAudioNotification_OnEvent_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IAMAnalogVideoEncoder_INTERFACE_DEFINED__

extern IID_IAMAnalogVideoEncoder as const IID

type IAMAnalogVideoEncoder as IAMAnalogVideoEncoder_

type IAMAnalogVideoEncoderVtbl
	QueryInterface as function(byval This as IAMAnalogVideoEncoder ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMAnalogVideoEncoder ptr) as ULONG
	Release as function(byval This as IAMAnalogVideoEncoder ptr) as ULONG
	get_AvailableTVFormats as function(byval This as IAMAnalogVideoEncoder ptr, byval lAnalogVideoStandard as LONG ptr) as HRESULT
	put_TVFormat as function(byval This as IAMAnalogVideoEncoder ptr, byval lAnalogVideoStandard as LONG) as HRESULT
	get_TVFormat as function(byval This as IAMAnalogVideoEncoder ptr, byval plAnalogVideoStandard as LONG ptr) as HRESULT
	put_CopyProtection as function(byval This as IAMAnalogVideoEncoder ptr, byval lVideoCopyProtection as LONG) as HRESULT
	get_CopyProtection as function(byval This as IAMAnalogVideoEncoder ptr, byval lVideoCopyProtection as LONG ptr) as HRESULT
	put_CCEnable as function(byval This as IAMAnalogVideoEncoder ptr, byval lCCEnable as LONG) as HRESULT
	get_CCEnable as function(byval This as IAMAnalogVideoEncoder ptr, byval lCCEnable as LONG ptr) as HRESULT
end type

type IAMAnalogVideoEncoder_
	lpVtbl as IAMAnalogVideoEncoderVtbl ptr
end type

declare function IAMAnalogVideoEncoder_get_AvailableTVFormats_Proxy(byval This as IAMAnalogVideoEncoder ptr, byval lAnalogVideoStandard as LONG ptr) as HRESULT
declare sub IAMAnalogVideoEncoder_get_AvailableTVFormats_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAnalogVideoEncoder_put_TVFormat_Proxy(byval This as IAMAnalogVideoEncoder ptr, byval lAnalogVideoStandard as LONG) as HRESULT
declare sub IAMAnalogVideoEncoder_put_TVFormat_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAnalogVideoEncoder_get_TVFormat_Proxy(byval This as IAMAnalogVideoEncoder ptr, byval plAnalogVideoStandard as LONG ptr) as HRESULT
declare sub IAMAnalogVideoEncoder_get_TVFormat_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAnalogVideoEncoder_put_CopyProtection_Proxy(byval This as IAMAnalogVideoEncoder ptr, byval lVideoCopyProtection as LONG) as HRESULT
declare sub IAMAnalogVideoEncoder_put_CopyProtection_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAnalogVideoEncoder_get_CopyProtection_Proxy(byval This as IAMAnalogVideoEncoder ptr, byval lVideoCopyProtection as LONG ptr) as HRESULT
declare sub IAMAnalogVideoEncoder_get_CopyProtection_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAnalogVideoEncoder_put_CCEnable_Proxy(byval This as IAMAnalogVideoEncoder ptr, byval lCCEnable as LONG) as HRESULT
declare sub IAMAnalogVideoEncoder_put_CCEnable_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAnalogVideoEncoder_get_CCEnable_Proxy(byval This as IAMAnalogVideoEncoder ptr, byval lCCEnable as LONG ptr) as HRESULT
declare sub IAMAnalogVideoEncoder_get_CCEnable_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type __MIDL___MIDL_itf_strmif_0185_0001 as long
enum
	AMPROPERTY_PIN_CATEGORY = 0
	AMPROPERTY_PIN_MEDIUM = AMPROPERTY_PIN_CATEGORY + 1
end enum

type AMPROPERTY_PIN as __MIDL___MIDL_itf_strmif_0185_0001

extern __MIDL_itf_strmif_0186_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0186_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IMediaPropertyBag_INTERFACE_DEFINED__

type IMediaPropertyBag as IMediaPropertyBag_

type LPMEDIAPROPERTYBAG as IMediaPropertyBag ptr

extern IID_IMediaPropertyBag as const IID

type IMediaPropertyBagVtbl
	QueryInterface as function(byval This as IMediaPropertyBag ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IMediaPropertyBag ptr) as ULONG
	Release as function(byval This as IMediaPropertyBag ptr) as ULONG
	Read as function(byval This as IMediaPropertyBag ptr, byval pszPropName as LPCOLESTR, byval pVar as VARIANT ptr, byval pErrorLog as IErrorLog ptr) as HRESULT
	Write as function(byval This as IMediaPropertyBag ptr, byval pszPropName as LPCOLESTR, byval pVar as VARIANT ptr) as HRESULT
	EnumProperty as function(byval This as IMediaPropertyBag ptr, byval iProperty as ULONG, byval pvarPropertyName as VARIANT ptr, byval pvarPropertyValue as VARIANT ptr) as HRESULT
end type

type IMediaPropertyBag_
	lpVtbl as IMediaPropertyBagVtbl ptr
end type

declare function IMediaPropertyBag_EnumProperty_Proxy(byval This as IMediaPropertyBag ptr, byval iProperty as ULONG, byval pvarPropertyName as VARIANT ptr, byval pvarPropertyValue as VARIANT ptr) as HRESULT
declare sub IMediaPropertyBag_EnumProperty_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IPersistMediaPropertyBag_INTERFACE_DEFINED__

type IPersistMediaPropertyBag as IPersistMediaPropertyBag_

type LPPERSISTMEDIAPROPERTYBAG as IPersistMediaPropertyBag ptr

extern IID_IPersistMediaPropertyBag as const IID

type IPersistMediaPropertyBagVtbl
	QueryInterface as function(byval This as IPersistMediaPropertyBag ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPersistMediaPropertyBag ptr) as ULONG
	Release as function(byval This as IPersistMediaPropertyBag ptr) as ULONG
	GetClassID as function(byval This as IPersistMediaPropertyBag ptr, byval pClassID as CLSID ptr) as HRESULT
	InitNew as function(byval This as IPersistMediaPropertyBag ptr) as HRESULT
	Load as function(byval This as IPersistMediaPropertyBag ptr, byval pPropBag as IMediaPropertyBag ptr, byval pErrorLog as IErrorLog ptr) as HRESULT
	Save as function(byval This as IPersistMediaPropertyBag ptr, byval pPropBag as IMediaPropertyBag ptr, byval fClearDirty as WINBOOL, byval fSaveAllProperties as WINBOOL) as HRESULT
end type

type IPersistMediaPropertyBag_
	lpVtbl as IPersistMediaPropertyBagVtbl ptr
end type

declare function IPersistMediaPropertyBag_InitNew_Proxy(byval This as IPersistMediaPropertyBag ptr) as HRESULT
declare sub IPersistMediaPropertyBag_InitNew_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPersistMediaPropertyBag_Load_Proxy(byval This as IPersistMediaPropertyBag ptr, byval pPropBag as IMediaPropertyBag ptr, byval pErrorLog as IErrorLog ptr) as HRESULT
declare sub IPersistMediaPropertyBag_Load_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPersistMediaPropertyBag_Save_Proxy(byval This as IPersistMediaPropertyBag ptr, byval pPropBag as IMediaPropertyBag ptr, byval fClearDirty as WINBOOL, byval fSaveAllProperties as WINBOOL) as HRESULT
declare sub IPersistMediaPropertyBag_Save_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IAMPhysicalPinInfo_INTERFACE_DEFINED__

extern IID_IAMPhysicalPinInfo as const IID

type IAMPhysicalPinInfo as IAMPhysicalPinInfo_

type IAMPhysicalPinInfoVtbl
	QueryInterface as function(byval This as IAMPhysicalPinInfo ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMPhysicalPinInfo ptr) as ULONG
	Release as function(byval This as IAMPhysicalPinInfo ptr) as ULONG
	GetPhysicalType as function(byval This as IAMPhysicalPinInfo ptr, byval pType as LONG ptr, byval ppszType as LPOLESTR ptr) as HRESULT
end type

type IAMPhysicalPinInfo_
	lpVtbl as IAMPhysicalPinInfoVtbl ptr
end type

declare function IAMPhysicalPinInfo_GetPhysicalType_Proxy(byval This as IAMPhysicalPinInfo ptr, byval pType as LONG ptr, byval ppszType as LPOLESTR ptr) as HRESULT
declare sub IAMPhysicalPinInfo_GetPhysicalType_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type PAMPHYSICALPININFO as IAMPhysicalPinInfo ptr

extern __MIDL_itf_strmif_0338_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0338_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IAMExtDevice_INTERFACE_DEFINED__

extern IID_IAMExtDevice as const IID

type IAMExtDevice as IAMExtDevice_

type IAMExtDeviceVtbl
	QueryInterface as function(byval This as IAMExtDevice ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMExtDevice ptr) as ULONG
	Release as function(byval This as IAMExtDevice ptr) as ULONG
	GetCapability as function(byval This as IAMExtDevice ptr, byval Capability as LONG, byval pValue as LONG ptr, byval pdblValue as double ptr) as HRESULT
	get_ExternalDeviceID as function(byval This as IAMExtDevice ptr, byval ppszData as LPOLESTR ptr) as HRESULT
	get_ExternalDeviceVersion as function(byval This as IAMExtDevice ptr, byval ppszData as LPOLESTR ptr) as HRESULT
	put_DevicePower as function(byval This as IAMExtDevice ptr, byval PowerMode as LONG) as HRESULT
	get_DevicePower as function(byval This as IAMExtDevice ptr, byval pPowerMode as LONG ptr) as HRESULT
	Calibrate as function(byval This as IAMExtDevice ptr, byval hEvent as HEVENT, byval Mode as LONG, byval pStatus as LONG ptr) as HRESULT
	put_DevicePort as function(byval This as IAMExtDevice ptr, byval DevicePort as LONG) as HRESULT
	get_DevicePort as function(byval This as IAMExtDevice ptr, byval pDevicePort as LONG ptr) as HRESULT
end type

type IAMExtDevice_
	lpVtbl as IAMExtDeviceVtbl ptr
end type

declare function IAMExtDevice_GetCapability_Proxy(byval This as IAMExtDevice ptr, byval Capability as LONG, byval pValue as LONG ptr, byval pdblValue as double ptr) as HRESULT
declare sub IAMExtDevice_GetCapability_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtDevice_get_ExternalDeviceID_Proxy(byval This as IAMExtDevice ptr, byval ppszData as LPOLESTR ptr) as HRESULT
declare sub IAMExtDevice_get_ExternalDeviceID_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtDevice_get_ExternalDeviceVersion_Proxy(byval This as IAMExtDevice ptr, byval ppszData as LPOLESTR ptr) as HRESULT
declare sub IAMExtDevice_get_ExternalDeviceVersion_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtDevice_put_DevicePower_Proxy(byval This as IAMExtDevice ptr, byval PowerMode as LONG) as HRESULT
declare sub IAMExtDevice_put_DevicePower_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtDevice_get_DevicePower_Proxy(byval This as IAMExtDevice ptr, byval pPowerMode as LONG ptr) as HRESULT
declare sub IAMExtDevice_get_DevicePower_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtDevice_Calibrate_Proxy(byval This as IAMExtDevice ptr, byval hEvent as HEVENT, byval Mode as LONG, byval pStatus as LONG ptr) as HRESULT
declare sub IAMExtDevice_Calibrate_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtDevice_put_DevicePort_Proxy(byval This as IAMExtDevice ptr, byval DevicePort as LONG) as HRESULT
declare sub IAMExtDevice_put_DevicePort_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtDevice_get_DevicePort_Proxy(byval This as IAMExtDevice ptr, byval pDevicePort as LONG ptr) as HRESULT
declare sub IAMExtDevice_get_DevicePort_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type PEXTDEVICE as IAMExtDevice ptr

extern __MIDL_itf_strmif_0339_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0339_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IAMExtTransport_INTERFACE_DEFINED__

extern IID_IAMExtTransport as const IID

type IAMExtTransport as IAMExtTransport_

type IAMExtTransportVtbl
	QueryInterface as function(byval This as IAMExtTransport ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMExtTransport ptr) as ULONG
	Release as function(byval This as IAMExtTransport ptr) as ULONG
	GetCapability as function(byval This as IAMExtTransport ptr, byval Capability as LONG, byval pValue as LONG ptr, byval pdblValue as double ptr) as HRESULT
	put_MediaState as function(byval This as IAMExtTransport ptr, byval State as LONG) as HRESULT
	get_MediaState as function(byval This as IAMExtTransport ptr, byval pState as LONG ptr) as HRESULT
	put_LocalControl as function(byval This as IAMExtTransport ptr, byval State as LONG) as HRESULT
	get_LocalControl as function(byval This as IAMExtTransport ptr, byval pState as LONG ptr) as HRESULT
	GetStatus as function(byval This as IAMExtTransport ptr, byval StatusItem as LONG, byval pValue as LONG ptr) as HRESULT
	GetTransportBasicParameters as function(byval This as IAMExtTransport ptr, byval Param as LONG, byval pValue as LONG ptr, byval ppszData as LPOLESTR ptr) as HRESULT
	SetTransportBasicParameters as function(byval This as IAMExtTransport ptr, byval Param as LONG, byval Value as LONG, byval pszData as LPCOLESTR) as HRESULT
	GetTransportVideoParameters as function(byval This as IAMExtTransport ptr, byval Param as LONG, byval pValue as LONG ptr) as HRESULT
	SetTransportVideoParameters as function(byval This as IAMExtTransport ptr, byval Param as LONG, byval Value as LONG) as HRESULT
	GetTransportAudioParameters as function(byval This as IAMExtTransport ptr, byval Param as LONG, byval pValue as LONG ptr) as HRESULT
	SetTransportAudioParameters as function(byval This as IAMExtTransport ptr, byval Param as LONG, byval Value as LONG) as HRESULT
	put_Mode as function(byval This as IAMExtTransport ptr, byval Mode as LONG) as HRESULT
	get_Mode as function(byval This as IAMExtTransport ptr, byval pMode as LONG ptr) as HRESULT
	put_Rate as function(byval This as IAMExtTransport ptr, byval dblRate as double) as HRESULT
	get_Rate as function(byval This as IAMExtTransport ptr, byval pdblRate as double ptr) as HRESULT
	GetChase as function(byval This as IAMExtTransport ptr, byval pEnabled as LONG ptr, byval pOffset as LONG ptr, byval phEvent as HEVENT ptr) as HRESULT
	SetChase as function(byval This as IAMExtTransport ptr, byval Enable as LONG, byval Offset as LONG, byval hEvent as HEVENT) as HRESULT
	GetBump as function(byval This as IAMExtTransport ptr, byval pSpeed as LONG ptr, byval pDuration as LONG ptr) as HRESULT
	SetBump as function(byval This as IAMExtTransport ptr, byval Speed as LONG, byval Duration as LONG) as HRESULT
	get_AntiClogControl as function(byval This as IAMExtTransport ptr, byval pEnabled as LONG ptr) as HRESULT
	put_AntiClogControl as function(byval This as IAMExtTransport ptr, byval Enable as LONG) as HRESULT
	GetEditPropertySet as function(byval This as IAMExtTransport ptr, byval EditID as LONG, byval pState as LONG ptr) as HRESULT
	SetEditPropertySet as function(byval This as IAMExtTransport ptr, byval pEditID as LONG ptr, byval State as LONG) as HRESULT
	GetEditProperty as function(byval This as IAMExtTransport ptr, byval EditID as LONG, byval Param as LONG, byval pValue as LONG ptr) as HRESULT
	SetEditProperty as function(byval This as IAMExtTransport ptr, byval EditID as LONG, byval Param as LONG, byval Value as LONG) as HRESULT
	get_EditStart as function(byval This as IAMExtTransport ptr, byval pValue as LONG ptr) as HRESULT
	put_EditStart as function(byval This as IAMExtTransport ptr, byval Value as LONG) as HRESULT
end type

type IAMExtTransport_
	lpVtbl as IAMExtTransportVtbl ptr
end type

declare function IAMExtTransport_GetCapability_Proxy(byval This as IAMExtTransport ptr, byval Capability as LONG, byval pValue as LONG ptr, byval pdblValue as double ptr) as HRESULT
declare sub IAMExtTransport_GetCapability_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_put_MediaState_Proxy(byval This as IAMExtTransport ptr, byval State as LONG) as HRESULT
declare sub IAMExtTransport_put_MediaState_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_get_MediaState_Proxy(byval This as IAMExtTransport ptr, byval pState as LONG ptr) as HRESULT
declare sub IAMExtTransport_get_MediaState_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_put_LocalControl_Proxy(byval This as IAMExtTransport ptr, byval State as LONG) as HRESULT
declare sub IAMExtTransport_put_LocalControl_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_get_LocalControl_Proxy(byval This as IAMExtTransport ptr, byval pState as LONG ptr) as HRESULT
declare sub IAMExtTransport_get_LocalControl_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_GetStatus_Proxy(byval This as IAMExtTransport ptr, byval StatusItem as LONG, byval pValue as LONG ptr) as HRESULT
declare sub IAMExtTransport_GetStatus_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_GetTransportBasicParameters_Proxy(byval This as IAMExtTransport ptr, byval Param as LONG, byval pValue as LONG ptr, byval ppszData as LPOLESTR ptr) as HRESULT
declare sub IAMExtTransport_GetTransportBasicParameters_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_SetTransportBasicParameters_Proxy(byval This as IAMExtTransport ptr, byval Param as LONG, byval Value as LONG, byval pszData as LPCOLESTR) as HRESULT
declare sub IAMExtTransport_SetTransportBasicParameters_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_GetTransportVideoParameters_Proxy(byval This as IAMExtTransport ptr, byval Param as LONG, byval pValue as LONG ptr) as HRESULT
declare sub IAMExtTransport_GetTransportVideoParameters_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_SetTransportVideoParameters_Proxy(byval This as IAMExtTransport ptr, byval Param as LONG, byval Value as LONG) as HRESULT
declare sub IAMExtTransport_SetTransportVideoParameters_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_GetTransportAudioParameters_Proxy(byval This as IAMExtTransport ptr, byval Param as LONG, byval pValue as LONG ptr) as HRESULT
declare sub IAMExtTransport_GetTransportAudioParameters_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_SetTransportAudioParameters_Proxy(byval This as IAMExtTransport ptr, byval Param as LONG, byval Value as LONG) as HRESULT
declare sub IAMExtTransport_SetTransportAudioParameters_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_put_Mode_Proxy(byval This as IAMExtTransport ptr, byval Mode as LONG) as HRESULT
declare sub IAMExtTransport_put_Mode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_get_Mode_Proxy(byval This as IAMExtTransport ptr, byval pMode as LONG ptr) as HRESULT
declare sub IAMExtTransport_get_Mode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_put_Rate_Proxy(byval This as IAMExtTransport ptr, byval dblRate as double) as HRESULT
declare sub IAMExtTransport_put_Rate_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_get_Rate_Proxy(byval This as IAMExtTransport ptr, byval pdblRate as double ptr) as HRESULT
declare sub IAMExtTransport_get_Rate_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_GetChase_Proxy(byval This as IAMExtTransport ptr, byval pEnabled as LONG ptr, byval pOffset as LONG ptr, byval phEvent as HEVENT ptr) as HRESULT
declare sub IAMExtTransport_GetChase_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_SetChase_Proxy(byval This as IAMExtTransport ptr, byval Enable as LONG, byval Offset as LONG, byval hEvent as HEVENT) as HRESULT
declare sub IAMExtTransport_SetChase_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_GetBump_Proxy(byval This as IAMExtTransport ptr, byval pSpeed as LONG ptr, byval pDuration as LONG ptr) as HRESULT
declare sub IAMExtTransport_GetBump_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_SetBump_Proxy(byval This as IAMExtTransport ptr, byval Speed as LONG, byval Duration as LONG) as HRESULT
declare sub IAMExtTransport_SetBump_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_get_AntiClogControl_Proxy(byval This as IAMExtTransport ptr, byval pEnabled as LONG ptr) as HRESULT
declare sub IAMExtTransport_get_AntiClogControl_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_put_AntiClogControl_Proxy(byval This as IAMExtTransport ptr, byval Enable as LONG) as HRESULT
declare sub IAMExtTransport_put_AntiClogControl_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_GetEditPropertySet_Proxy(byval This as IAMExtTransport ptr, byval EditID as LONG, byval pState as LONG ptr) as HRESULT
declare sub IAMExtTransport_GetEditPropertySet_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_SetEditPropertySet_Proxy(byval This as IAMExtTransport ptr, byval pEditID as LONG ptr, byval State as LONG) as HRESULT
declare sub IAMExtTransport_SetEditPropertySet_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_GetEditProperty_Proxy(byval This as IAMExtTransport ptr, byval EditID as LONG, byval Param as LONG, byval pValue as LONG ptr) as HRESULT
declare sub IAMExtTransport_GetEditProperty_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_SetEditProperty_Proxy(byval This as IAMExtTransport ptr, byval EditID as LONG, byval Param as LONG, byval Value as LONG) as HRESULT
declare sub IAMExtTransport_SetEditProperty_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_get_EditStart_Proxy(byval This as IAMExtTransport ptr, byval pValue as LONG ptr) as HRESULT
declare sub IAMExtTransport_get_EditStart_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_put_EditStart_Proxy(byval This as IAMExtTransport ptr, byval Value as LONG) as HRESULT
declare sub IAMExtTransport_put_EditStart_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type PIAMEXTTRANSPORT as IAMExtTransport ptr

#define TIMECODE_DEFINED

union _timecode
	type
		wFrameRate as WORD
		wFrameFract as WORD
		dwFrames as DWORD
	end type

	qw as DWORDLONG
end union

type TIMECODE as _timecode
type PTIMECODE as TIMECODE ptr

type tagTIMECODE_SAMPLE
	qwTick as LONGLONG
	timecode as TIMECODE
	dwUser as DWORD
	dwFlags as DWORD
end type

type TIMECODE_SAMPLE as tagTIMECODE_SAMPLE
type PTIMECODE_SAMPLE as TIMECODE_SAMPLE ptr

extern __MIDL_itf_strmif_0340_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0340_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IAMTimecodeReader_INTERFACE_DEFINED__

extern IID_IAMTimecodeReader as const IID

type IAMTimecodeReader as IAMTimecodeReader_

type IAMTimecodeReaderVtbl
	QueryInterface as function(byval This as IAMTimecodeReader ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMTimecodeReader ptr) as ULONG
	Release as function(byval This as IAMTimecodeReader ptr) as ULONG
	GetTCRMode as function(byval This as IAMTimecodeReader ptr, byval Param as LONG, byval pValue as LONG ptr) as HRESULT
	SetTCRMode as function(byval This as IAMTimecodeReader ptr, byval Param as LONG, byval Value as LONG) as HRESULT
	put_VITCLine as function(byval This as IAMTimecodeReader ptr, byval Line as LONG) as HRESULT
	get_VITCLine as function(byval This as IAMTimecodeReader ptr, byval pLine as LONG ptr) as HRESULT
	GetTimecode as function(byval This as IAMTimecodeReader ptr, byval pTimecodeSample as PTIMECODE_SAMPLE) as HRESULT
end type

type IAMTimecodeReader_
	lpVtbl as IAMTimecodeReaderVtbl ptr
end type

declare function IAMTimecodeReader_GetTCRMode_Proxy(byval This as IAMTimecodeReader ptr, byval Param as LONG, byval pValue as LONG ptr) as HRESULT
declare sub IAMTimecodeReader_GetTCRMode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTimecodeReader_SetTCRMode_Proxy(byval This as IAMTimecodeReader ptr, byval Param as LONG, byval Value as LONG) as HRESULT
declare sub IAMTimecodeReader_SetTCRMode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTimecodeReader_put_VITCLine_Proxy(byval This as IAMTimecodeReader ptr, byval Line as LONG) as HRESULT
declare sub IAMTimecodeReader_put_VITCLine_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTimecodeReader_get_VITCLine_Proxy(byval This as IAMTimecodeReader ptr, byval pLine as LONG ptr) as HRESULT
declare sub IAMTimecodeReader_get_VITCLine_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTimecodeReader_GetTimecode_Proxy(byval This as IAMTimecodeReader ptr, byval pTimecodeSample as PTIMECODE_SAMPLE) as HRESULT
declare sub IAMTimecodeReader_GetTimecode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type PIAMTIMECODEREADER as IAMTimecodeReader ptr

extern __MIDL_itf_strmif_0341_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0341_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IAMTimecodeGenerator_INTERFACE_DEFINED__

extern IID_IAMTimecodeGenerator as const IID

type IAMTimecodeGenerator as IAMTimecodeGenerator_

type IAMTimecodeGeneratorVtbl
	QueryInterface as function(byval This as IAMTimecodeGenerator ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMTimecodeGenerator ptr) as ULONG
	Release as function(byval This as IAMTimecodeGenerator ptr) as ULONG
	GetTCGMode as function(byval This as IAMTimecodeGenerator ptr, byval Param as LONG, byval pValue as LONG ptr) as HRESULT
	SetTCGMode as function(byval This as IAMTimecodeGenerator ptr, byval Param as LONG, byval Value as LONG) as HRESULT
	put_VITCLine as function(byval This as IAMTimecodeGenerator ptr, byval Line as LONG) as HRESULT
	get_VITCLine as function(byval This as IAMTimecodeGenerator ptr, byval pLine as LONG ptr) as HRESULT
	SetTimecode as function(byval This as IAMTimecodeGenerator ptr, byval pTimecodeSample as PTIMECODE_SAMPLE) as HRESULT
	GetTimecode as function(byval This as IAMTimecodeGenerator ptr, byval pTimecodeSample as PTIMECODE_SAMPLE) as HRESULT
end type

type IAMTimecodeGenerator_
	lpVtbl as IAMTimecodeGeneratorVtbl ptr
end type

declare function IAMTimecodeGenerator_GetTCGMode_Proxy(byval This as IAMTimecodeGenerator ptr, byval Param as LONG, byval pValue as LONG ptr) as HRESULT
declare sub IAMTimecodeGenerator_GetTCGMode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTimecodeGenerator_SetTCGMode_Proxy(byval This as IAMTimecodeGenerator ptr, byval Param as LONG, byval Value as LONG) as HRESULT
declare sub IAMTimecodeGenerator_SetTCGMode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTimecodeGenerator_put_VITCLine_Proxy(byval This as IAMTimecodeGenerator ptr, byval Line as LONG) as HRESULT
declare sub IAMTimecodeGenerator_put_VITCLine_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTimecodeGenerator_get_VITCLine_Proxy(byval This as IAMTimecodeGenerator ptr, byval pLine as LONG ptr) as HRESULT
declare sub IAMTimecodeGenerator_get_VITCLine_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTimecodeGenerator_SetTimecode_Proxy(byval This as IAMTimecodeGenerator ptr, byval pTimecodeSample as PTIMECODE_SAMPLE) as HRESULT
declare sub IAMTimecodeGenerator_SetTimecode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTimecodeGenerator_GetTimecode_Proxy(byval This as IAMTimecodeGenerator ptr, byval pTimecodeSample as PTIMECODE_SAMPLE) as HRESULT
declare sub IAMTimecodeGenerator_GetTimecode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type PIAMTIMECODEGENERATOR as IAMTimecodeGenerator ptr

extern __MIDL_itf_strmif_0342_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0342_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IAMTimecodeDisplay_INTERFACE_DEFINED__

extern IID_IAMTimecodeDisplay as const IID

type IAMTimecodeDisplay as IAMTimecodeDisplay_

type IAMTimecodeDisplayVtbl
	QueryInterface as function(byval This as IAMTimecodeDisplay ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMTimecodeDisplay ptr) as ULONG
	Release as function(byval This as IAMTimecodeDisplay ptr) as ULONG
	GetTCDisplayEnable as function(byval This as IAMTimecodeDisplay ptr, byval pState as LONG ptr) as HRESULT
	SetTCDisplayEnable as function(byval This as IAMTimecodeDisplay ptr, byval State as LONG) as HRESULT
	GetTCDisplay as function(byval This as IAMTimecodeDisplay ptr, byval Param as LONG, byval pValue as LONG ptr) as HRESULT
	SetTCDisplay as function(byval This as IAMTimecodeDisplay ptr, byval Param as LONG, byval Value as LONG) as HRESULT
end type

type IAMTimecodeDisplay_
	lpVtbl as IAMTimecodeDisplayVtbl ptr
end type

declare function IAMTimecodeDisplay_GetTCDisplayEnable_Proxy(byval This as IAMTimecodeDisplay ptr, byval pState as LONG ptr) as HRESULT
declare sub IAMTimecodeDisplay_GetTCDisplayEnable_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTimecodeDisplay_SetTCDisplayEnable_Proxy(byval This as IAMTimecodeDisplay ptr, byval State as LONG) as HRESULT
declare sub IAMTimecodeDisplay_SetTCDisplayEnable_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTimecodeDisplay_GetTCDisplay_Proxy(byval This as IAMTimecodeDisplay ptr, byval Param as LONG, byval pValue as LONG ptr) as HRESULT
declare sub IAMTimecodeDisplay_GetTCDisplay_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTimecodeDisplay_SetTCDisplay_Proxy(byval This as IAMTimecodeDisplay ptr, byval Param as LONG, byval Value as LONG) as HRESULT
declare sub IAMTimecodeDisplay_SetTCDisplay_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type PIAMTIMECODEDISPLAY as IAMTimecodeDisplay ptr

extern __MIDL_itf_strmif_0343_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0343_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IAMDevMemoryAllocator_INTERFACE_DEFINED__

extern IID_IAMDevMemoryAllocator as const IID

type IAMDevMemoryAllocator as IAMDevMemoryAllocator_

type IAMDevMemoryAllocatorVtbl
	QueryInterface as function(byval This as IAMDevMemoryAllocator ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMDevMemoryAllocator ptr) as ULONG
	Release as function(byval This as IAMDevMemoryAllocator ptr) as ULONG
	GetInfo as function(byval This as IAMDevMemoryAllocator ptr, byval pdwcbTotalFree as DWORD ptr, byval pdwcbLargestFree as DWORD ptr, byval pdwcbTotalMemory as DWORD ptr, byval pdwcbMinimumChunk as DWORD ptr) as HRESULT
	CheckMemory as function(byval This as IAMDevMemoryAllocator ptr, byval pBuffer as const UBYTE ptr) as HRESULT
	Alloc as function(byval This as IAMDevMemoryAllocator ptr, byval ppBuffer as UBYTE ptr ptr, byval pdwcbBuffer as DWORD ptr) as HRESULT
	Free as function(byval This as IAMDevMemoryAllocator ptr, byval pBuffer as UBYTE ptr) as HRESULT
	GetDevMemoryObject as function(byval This as IAMDevMemoryAllocator ptr, byval ppUnkInnner as IUnknown ptr ptr, byval pUnkOuter as IUnknown ptr) as HRESULT
end type

type IAMDevMemoryAllocator_
	lpVtbl as IAMDevMemoryAllocatorVtbl ptr
end type

declare function IAMDevMemoryAllocator_GetInfo_Proxy(byval This as IAMDevMemoryAllocator ptr, byval pdwcbTotalFree as DWORD ptr, byval pdwcbLargestFree as DWORD ptr, byval pdwcbTotalMemory as DWORD ptr, byval pdwcbMinimumChunk as DWORD ptr) as HRESULT
declare sub IAMDevMemoryAllocator_GetInfo_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMDevMemoryAllocator_CheckMemory_Proxy(byval This as IAMDevMemoryAllocator ptr, byval pBuffer as const UBYTE ptr) as HRESULT
declare sub IAMDevMemoryAllocator_CheckMemory_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMDevMemoryAllocator_Alloc_Proxy(byval This as IAMDevMemoryAllocator ptr, byval ppBuffer as UBYTE ptr ptr, byval pdwcbBuffer as DWORD ptr) as HRESULT
declare sub IAMDevMemoryAllocator_Alloc_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMDevMemoryAllocator_Free_Proxy(byval This as IAMDevMemoryAllocator ptr, byval pBuffer as UBYTE ptr) as HRESULT
declare sub IAMDevMemoryAllocator_Free_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMDevMemoryAllocator_GetDevMemoryObject_Proxy(byval This as IAMDevMemoryAllocator ptr, byval ppUnkInnner as IUnknown ptr ptr, byval pUnkOuter as IUnknown ptr) as HRESULT
declare sub IAMDevMemoryAllocator_GetDevMemoryObject_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type PAMDEVMEMORYALLOCATOR as IAMDevMemoryAllocator ptr

extern __MIDL_itf_strmif_0344_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0344_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IAMDevMemoryControl_INTERFACE_DEFINED__

extern IID_IAMDevMemoryControl as const IID

type IAMDevMemoryControl as IAMDevMemoryControl_

type IAMDevMemoryControlVtbl
	QueryInterface as function(byval This as IAMDevMemoryControl ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMDevMemoryControl ptr) as ULONG
	Release as function(byval This as IAMDevMemoryControl ptr) as ULONG
	QueryWriteSync as function(byval This as IAMDevMemoryControl ptr) as HRESULT
	WriteSync as function(byval This as IAMDevMemoryControl ptr) as HRESULT
	GetDevId as function(byval This as IAMDevMemoryControl ptr, byval pdwDevId as DWORD ptr) as HRESULT
end type

type IAMDevMemoryControl_
	lpVtbl as IAMDevMemoryControlVtbl ptr
end type

declare function IAMDevMemoryControl_QueryWriteSync_Proxy(byval This as IAMDevMemoryControl ptr) as HRESULT
declare sub IAMDevMemoryControl_QueryWriteSync_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMDevMemoryControl_WriteSync_Proxy(byval This as IAMDevMemoryControl ptr) as HRESULT
declare sub IAMDevMemoryControl_WriteSync_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMDevMemoryControl_GetDevId_Proxy(byval This as IAMDevMemoryControl ptr, byval pdwDevId as DWORD ptr) as HRESULT
declare sub IAMDevMemoryControl_GetDevId_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type PAMDEVMEMORYCONTROL as IAMDevMemoryControl ptr

type _AMSTREAMSELECTINFOFLAGS as long
enum
	AMSTREAMSELECTINFO_ENABLED = &h1
	AMSTREAMSELECTINFO_EXCLUSIVE = &h2
end enum

type _AMSTREAMSELECTENABLEFLAGS as long
enum
	AMSTREAMSELECTENABLE_ENABLE = &h1
	AMSTREAMSELECTENABLE_ENABLEALL = &h2
end enum

extern __MIDL_itf_strmif_0345_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0345_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IAMStreamSelect_INTERFACE_DEFINED__

extern IID_IAMStreamSelect as const IID

type IAMStreamSelect as IAMStreamSelect_

type IAMStreamSelectVtbl
	QueryInterface as function(byval This as IAMStreamSelect ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMStreamSelect ptr) as ULONG
	Release as function(byval This as IAMStreamSelect ptr) as ULONG
	Count as function(byval This as IAMStreamSelect ptr, byval pcStreams as DWORD ptr) as HRESULT
	Info as function(byval This as IAMStreamSelect ptr, byval lIndex as LONG, byval ppmt as AM_MEDIA_TYPE ptr ptr, byval pdwFlags as DWORD ptr, byval plcid as LCID ptr, byval pdwGroup as DWORD ptr, byval ppszName as wstring ptr ptr, byval ppObject as IUnknown ptr ptr, byval ppUnk as IUnknown ptr ptr) as HRESULT
	Enable as function(byval This as IAMStreamSelect ptr, byval lIndex as LONG, byval dwFlags as DWORD) as HRESULT
end type

type IAMStreamSelect_
	lpVtbl as IAMStreamSelectVtbl ptr
end type

declare function IAMStreamSelect_Count_Proxy(byval This as IAMStreamSelect ptr, byval pcStreams as DWORD ptr) as HRESULT
declare sub IAMStreamSelect_Count_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMStreamSelect_Info_Proxy(byval This as IAMStreamSelect ptr, byval lIndex as LONG, byval ppmt as AM_MEDIA_TYPE ptr ptr, byval pdwFlags as DWORD ptr, byval plcid as LCID ptr, byval pdwGroup as DWORD ptr, byval ppszName as wstring ptr ptr, byval ppObject as IUnknown ptr ptr, byval ppUnk as IUnknown ptr ptr) as HRESULT
declare sub IAMStreamSelect_Info_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMStreamSelect_Enable_Proxy(byval This as IAMStreamSelect ptr, byval lIndex as LONG, byval dwFlags as DWORD) as HRESULT
declare sub IAMStreamSelect_Enable_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type PAMSTREAMSELECT as IAMStreamSelect ptr

type _AMRESCTL_RESERVEFLAGS as long
enum
	AMRESCTL_RESERVEFLAGS_RESERVE = 0
	AMRESCTL_RESERVEFLAGS_UNRESERVE = &h1
end enum

extern __MIDL_itf_strmif_0346_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0346_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IAMResourceControl_INTERFACE_DEFINED__

extern IID_IAMResourceControl as const IID

type IAMResourceControl as IAMResourceControl_

type IAMResourceControlVtbl
	QueryInterface as function(byval This as IAMResourceControl ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMResourceControl ptr) as ULONG
	Release as function(byval This as IAMResourceControl ptr) as ULONG
	Reserve as function(byval This as IAMResourceControl ptr, byval dwFlags as DWORD, byval pvReserved as PVOID) as HRESULT
end type

type IAMResourceControl_
	lpVtbl as IAMResourceControlVtbl ptr
end type

declare function IAMResourceControl_Reserve_Proxy(byval This as IAMResourceControl ptr, byval dwFlags as DWORD, byval pvReserved as PVOID) as HRESULT
declare sub IAMResourceControl_Reserve_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IAMClockAdjust_INTERFACE_DEFINED__

extern IID_IAMClockAdjust as const IID

type IAMClockAdjust as IAMClockAdjust_

type IAMClockAdjustVtbl
	QueryInterface as function(byval This as IAMClockAdjust ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMClockAdjust ptr) as ULONG
	Release as function(byval This as IAMClockAdjust ptr) as ULONG
	SetClockDelta as function(byval This as IAMClockAdjust ptr, byval rtDelta as REFERENCE_TIME) as HRESULT
end type

type IAMClockAdjust_
	lpVtbl as IAMClockAdjustVtbl ptr
end type

declare function IAMClockAdjust_SetClockDelta_Proxy(byval This as IAMClockAdjust ptr, byval rtDelta as REFERENCE_TIME) as HRESULT
declare sub IAMClockAdjust_SetClockDelta_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IDrawVideoImage_INTERFACE_DEFINED__

extern IID_IDrawVideoImage as const IID

type IDrawVideoImage as IDrawVideoImage_

type IDrawVideoImageVtbl
	QueryInterface as function(byval This as IDrawVideoImage ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDrawVideoImage ptr) as ULONG
	Release as function(byval This as IDrawVideoImage ptr) as ULONG
	DrawVideoImageBegin as function(byval This as IDrawVideoImage ptr) as HRESULT
	DrawVideoImageEnd as function(byval This as IDrawVideoImage ptr) as HRESULT
	DrawVideoImageDraw as function(byval This as IDrawVideoImage ptr, byval hdc as HDC, byval lprcSrc as LPRECT, byval lprcDst as LPRECT) as HRESULT
end type

type IDrawVideoImage_
	lpVtbl as IDrawVideoImageVtbl ptr
end type

declare function IDrawVideoImage_DrawVideoImageBegin_Proxy(byval This as IDrawVideoImage ptr) as HRESULT
declare sub IDrawVideoImage_DrawVideoImageBegin_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDrawVideoImage_DrawVideoImageEnd_Proxy(byval This as IDrawVideoImage ptr) as HRESULT
declare sub IDrawVideoImage_DrawVideoImageEnd_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDrawVideoImage_DrawVideoImageDraw_Proxy(byval This as IDrawVideoImage ptr, byval hdc as HDC, byval lprcSrc as LPRECT, byval lprcDst as LPRECT) as HRESULT
declare sub IDrawVideoImage_DrawVideoImageDraw_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IDecimateVideoImage_INTERFACE_DEFINED__

extern IID_IDecimateVideoImage as const IID

type IDecimateVideoImage as IDecimateVideoImage_

type IDecimateVideoImageVtbl
	QueryInterface as function(byval This as IDecimateVideoImage ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDecimateVideoImage ptr) as ULONG
	Release as function(byval This as IDecimateVideoImage ptr) as ULONG
	SetDecimationImageSize as function(byval This as IDecimateVideoImage ptr, byval lWidth as LONG, byval lHeight as LONG) as HRESULT
	ResetDecimationImageSize as function(byval This as IDecimateVideoImage ptr) as HRESULT
end type

type IDecimateVideoImage_
	lpVtbl as IDecimateVideoImageVtbl ptr
end type

declare function IDecimateVideoImage_SetDecimationImageSize_Proxy(byval This as IDecimateVideoImage ptr, byval lWidth as LONG, byval lHeight as LONG) as HRESULT
declare sub IDecimateVideoImage_SetDecimationImageSize_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDecimateVideoImage_ResetDecimationImageSize_Proxy(byval This as IDecimateVideoImage ptr) as HRESULT
declare sub IDecimateVideoImage_ResetDecimationImageSize_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type _DECIMATION_USAGE as long
enum
	DECIMATION_LEGACY = 0
	DECIMATION_USE_DECODER_ONLY
	DECIMATION_USE_VIDEOPORT_ONLY
	DECIMATION_USE_OVERLAY_ONLY
	DECIMATION_DEFAULT
end enum

type DECIMATION_USAGE as _DECIMATION_USAGE

extern __MIDL_itf_strmif_0351_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0351_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IAMVideoDecimationProperties_INTERFACE_DEFINED__

extern IID_IAMVideoDecimationProperties as const IID

type IAMVideoDecimationProperties as IAMVideoDecimationProperties_

type IAMVideoDecimationPropertiesVtbl
	QueryInterface as function(byval This as IAMVideoDecimationProperties ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMVideoDecimationProperties ptr) as ULONG
	Release as function(byval This as IAMVideoDecimationProperties ptr) as ULONG
	QueryDecimationUsage as function(byval This as IAMVideoDecimationProperties ptr, byval lpUsage as DECIMATION_USAGE ptr) as HRESULT
	SetDecimationUsage as function(byval This as IAMVideoDecimationProperties ptr, byval Usage as DECIMATION_USAGE) as HRESULT
end type

type IAMVideoDecimationProperties_
	lpVtbl as IAMVideoDecimationPropertiesVtbl ptr
end type

declare function IAMVideoDecimationProperties_QueryDecimationUsage_Proxy(byval This as IAMVideoDecimationProperties ptr, byval lpUsage as DECIMATION_USAGE ptr) as HRESULT
declare sub IAMVideoDecimationProperties_QueryDecimationUsage_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVideoDecimationProperties_SetDecimationUsage_Proxy(byval This as IAMVideoDecimationProperties ptr, byval Usage as DECIMATION_USAGE) as HRESULT
declare sub IAMVideoDecimationProperties_SetDecimationUsage_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IVideoFrameStep_INTERFACE_DEFINED__

extern IID_IVideoFrameStep as const IID

type IVideoFrameStep as IVideoFrameStep_

type IVideoFrameStepVtbl
	QueryInterface as function(byval This as IVideoFrameStep ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IVideoFrameStep ptr) as ULONG
	Release as function(byval This as IVideoFrameStep ptr) as ULONG
	Step as function(byval This as IVideoFrameStep ptr, byval dwFrames as DWORD, byval pStepObject as IUnknown ptr) as HRESULT
	CanStep as function(byval This as IVideoFrameStep ptr, byval bMultiple as LONG, byval pStepObject as IUnknown ptr) as HRESULT
	CancelStep as function(byval This as IVideoFrameStep ptr) as HRESULT
end type

type IVideoFrameStep_
	lpVtbl as IVideoFrameStepVtbl ptr
end type

declare function IVideoFrameStep_Step_Proxy(byval This as IVideoFrameStep ptr, byval dwFrames as DWORD, byval pStepObject as IUnknown ptr) as HRESULT
declare sub IVideoFrameStep_Step_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoFrameStep_CanStep_Proxy(byval This as IVideoFrameStep ptr, byval bMultiple as LONG, byval pStepObject as IUnknown ptr) as HRESULT
declare sub IVideoFrameStep_CanStep_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoFrameStep_CancelStep_Proxy(byval This as IVideoFrameStep ptr) as HRESULT
declare sub IVideoFrameStep_CancelStep_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type _AM_PUSHSOURCE_FLAGS as long
enum
	AM_PUSHSOURCECAPS_INTERNAL_RM = &h1
	AM_PUSHSOURCECAPS_NOT_LIVE = &h2
	AM_PUSHSOURCECAPS_PRIVATE_CLOCK = &h4
	AM_PUSHSOURCEREQS_USE_STREAM_CLOCK = &h10000
	AM_PUSHSOURCEREQS_USE_CLOCK_CHAIN = &h20000
end enum

extern __MIDL_itf_strmif_0353_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0353_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IAMLatency_INTERFACE_DEFINED__

extern IID_IAMLatency as const IID

type IAMLatency as IAMLatency_

type IAMLatencyVtbl
	QueryInterface as function(byval This as IAMLatency ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMLatency ptr) as ULONG
	Release as function(byval This as IAMLatency ptr) as ULONG
	GetLatency as function(byval This as IAMLatency ptr, byval prtLatency as REFERENCE_TIME ptr) as HRESULT
end type

type IAMLatency_
	lpVtbl as IAMLatencyVtbl ptr
end type

declare function IAMLatency_GetLatency_Proxy(byval This as IAMLatency ptr, byval prtLatency as REFERENCE_TIME ptr) as HRESULT
declare sub IAMLatency_GetLatency_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IAMPushSource_INTERFACE_DEFINED__

extern IID_IAMPushSource as const IID

type IAMPushSource as IAMPushSource_

type IAMPushSourceVtbl
	QueryInterface as function(byval This as IAMPushSource ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMPushSource ptr) as ULONG
	Release as function(byval This as IAMPushSource ptr) as ULONG
	GetLatency as function(byval This as IAMPushSource ptr, byval prtLatency as REFERENCE_TIME ptr) as HRESULT
	GetPushSourceFlags as function(byval This as IAMPushSource ptr, byval pFlags as ULONG ptr) as HRESULT
	SetPushSourceFlags as function(byval This as IAMPushSource ptr, byval Flags as ULONG) as HRESULT
	SetStreamOffset as function(byval This as IAMPushSource ptr, byval rtOffset as REFERENCE_TIME) as HRESULT
	GetStreamOffset as function(byval This as IAMPushSource ptr, byval prtOffset as REFERENCE_TIME ptr) as HRESULT
	GetMaxStreamOffset as function(byval This as IAMPushSource ptr, byval prtMaxOffset as REFERENCE_TIME ptr) as HRESULT
	SetMaxStreamOffset as function(byval This as IAMPushSource ptr, byval rtMaxOffset as REFERENCE_TIME) as HRESULT
end type

type IAMPushSource_
	lpVtbl as IAMPushSourceVtbl ptr
end type

declare function IAMPushSource_GetPushSourceFlags_Proxy(byval This as IAMPushSource ptr, byval pFlags as ULONG ptr) as HRESULT
declare sub IAMPushSource_GetPushSourceFlags_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMPushSource_SetPushSourceFlags_Proxy(byval This as IAMPushSource ptr, byval Flags as ULONG) as HRESULT
declare sub IAMPushSource_SetPushSourceFlags_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMPushSource_SetStreamOffset_Proxy(byval This as IAMPushSource ptr, byval rtOffset as REFERENCE_TIME) as HRESULT
declare sub IAMPushSource_SetStreamOffset_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMPushSource_GetStreamOffset_Proxy(byval This as IAMPushSource ptr, byval prtOffset as REFERENCE_TIME ptr) as HRESULT
declare sub IAMPushSource_GetStreamOffset_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMPushSource_GetMaxStreamOffset_Proxy(byval This as IAMPushSource ptr, byval prtMaxOffset as REFERENCE_TIME ptr) as HRESULT
declare sub IAMPushSource_GetMaxStreamOffset_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMPushSource_SetMaxStreamOffset_Proxy(byval This as IAMPushSource ptr, byval rtMaxOffset as REFERENCE_TIME) as HRESULT
declare sub IAMPushSource_SetMaxStreamOffset_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IAMDeviceRemoval_INTERFACE_DEFINED__

extern IID_IAMDeviceRemoval as const IID

type IAMDeviceRemoval as IAMDeviceRemoval_

type IAMDeviceRemovalVtbl
	QueryInterface as function(byval This as IAMDeviceRemoval ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMDeviceRemoval ptr) as ULONG
	Release as function(byval This as IAMDeviceRemoval ptr) as ULONG
	DeviceInfo as function(byval This as IAMDeviceRemoval ptr, byval pclsidInterfaceClass as CLSID ptr, byval pwszSymbolicLink as wstring ptr ptr) as HRESULT
	Reassociate as function(byval This as IAMDeviceRemoval ptr) as HRESULT
	Disassociate as function(byval This as IAMDeviceRemoval ptr) as HRESULT
end type

type IAMDeviceRemoval_
	lpVtbl as IAMDeviceRemovalVtbl ptr
end type

declare function IAMDeviceRemoval_DeviceInfo_Proxy(byval This as IAMDeviceRemoval ptr, byval pclsidInterfaceClass as CLSID ptr, byval pwszSymbolicLink as wstring ptr ptr) as HRESULT
declare sub IAMDeviceRemoval_DeviceInfo_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMDeviceRemoval_Reassociate_Proxy(byval This as IAMDeviceRemoval ptr) as HRESULT
declare sub IAMDeviceRemoval_Reassociate_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMDeviceRemoval_Disassociate_Proxy(byval This as IAMDeviceRemoval ptr) as HRESULT
declare sub IAMDeviceRemoval_Disassociate_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type __MIDL___MIDL_itf_strmif_0355_0001
	dwDVAAuxSrc as DWORD
	dwDVAAuxCtl as DWORD
	dwDVAAuxSrc1 as DWORD
	dwDVAAuxCtl1 as DWORD
	dwDVVAuxSrc as DWORD
	dwDVVAuxCtl as DWORD
	dwDVReserved(0 to 1) as DWORD
end type

type DVINFO as __MIDL___MIDL_itf_strmif_0355_0001
type PDVINFO as __MIDL___MIDL_itf_strmif_0355_0001 ptr

type _DVENCODERRESOLUTION as long
enum
	DVENCODERRESOLUTION_720x480 = 2012
	DVENCODERRESOLUTION_360x240 = 2013
	DVENCODERRESOLUTION_180x120 = 2014
	DVENCODERRESOLUTION_88x60 = 2015
end enum

type _DVENCODERVIDEOFORMAT as long
enum
	DVENCODERVIDEOFORMAT_NTSC = 2000
	DVENCODERVIDEOFORMAT_PAL = 2001
end enum

type _DVENCODERFORMAT as long
enum
	DVENCODERFORMAT_DVSD = 2007
	DVENCODERFORMAT_DVHD = 2008
	DVENCODERFORMAT_DVSL = 2009
end enum

extern __MIDL_itf_strmif_0355_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0355_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IDVEnc_INTERFACE_DEFINED__

extern IID_IDVEnc as const IID

type IDVEnc as IDVEnc_

type IDVEncVtbl
	QueryInterface as function(byval This as IDVEnc ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDVEnc ptr) as ULONG
	Release as function(byval This as IDVEnc ptr) as ULONG
	get_IFormatResolution as function(byval This as IDVEnc ptr, byval VideoFormat as long ptr, byval DVFormat as long ptr, byval Resolution as long ptr, byval fDVInfo as UBYTE, byval sDVInfo as DVINFO ptr) as HRESULT
	put_IFormatResolution as function(byval This as IDVEnc ptr, byval VideoFormat as long, byval DVFormat as long, byval Resolution as long, byval fDVInfo as UBYTE, byval sDVInfo as DVINFO ptr) as HRESULT
end type

type IDVEnc_
	lpVtbl as IDVEncVtbl ptr
end type

declare function IDVEnc_get_IFormatResolution_Proxy(byval This as IDVEnc ptr, byval VideoFormat as long ptr, byval DVFormat as long ptr, byval Resolution as long ptr, byval fDVInfo as UBYTE, byval sDVInfo as DVINFO ptr) as HRESULT
declare sub IDVEnc_get_IFormatResolution_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDVEnc_put_IFormatResolution_Proxy(byval This as IDVEnc ptr, byval VideoFormat as long, byval DVFormat as long, byval Resolution as long, byval fDVInfo as UBYTE, byval sDVInfo as DVINFO ptr) as HRESULT
declare sub IDVEnc_put_IFormatResolution_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type _DVDECODERRESOLUTION as long
enum
	DVDECODERRESOLUTION_720x480 = 1000
	DVDECODERRESOLUTION_360x240 = 1001
	DVDECODERRESOLUTION_180x120 = 1002
	DVDECODERRESOLUTION_88x60 = 1003
end enum

type _DVRESOLUTION as long
enum
	DVRESOLUTION_FULL = 1000
	DVRESOLUTION_HALF = 1001
	DVRESOLUTION_QUARTER = 1002
	DVRESOLUTION_DC = 1003
end enum

extern __MIDL_itf_strmif_0356_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0356_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IIPDVDec_INTERFACE_DEFINED__

extern IID_IIPDVDec as const IID

type IIPDVDec as IIPDVDec_

type IIPDVDecVtbl
	QueryInterface as function(byval This as IIPDVDec ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IIPDVDec ptr) as ULONG
	Release as function(byval This as IIPDVDec ptr) as ULONG
	get_IPDisplay as function(byval This as IIPDVDec ptr, byval displayPix as long ptr) as HRESULT
	put_IPDisplay as function(byval This as IIPDVDec ptr, byval displayPix as long) as HRESULT
end type

type IIPDVDec_
	lpVtbl as IIPDVDecVtbl ptr
end type

declare function IIPDVDec_get_IPDisplay_Proxy(byval This as IIPDVDec ptr, byval displayPix as long ptr) as HRESULT
declare sub IIPDVDec_get_IPDisplay_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IIPDVDec_put_IPDisplay_Proxy(byval This as IIPDVDec ptr, byval displayPix as long) as HRESULT
declare sub IIPDVDec_put_IPDisplay_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IDVRGB219_INTERFACE_DEFINED__

extern IID_IDVRGB219 as const IID

type IDVRGB219 as IDVRGB219_

type IDVRGB219Vtbl
	QueryInterface as function(byval This as IDVRGB219 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDVRGB219 ptr) as ULONG
	Release as function(byval This as IDVRGB219 ptr) as ULONG
	SetRGB219 as function(byval This as IDVRGB219 ptr, byval bState as WINBOOL) as HRESULT
end type

type IDVRGB219_
	lpVtbl as IDVRGB219Vtbl ptr
end type

declare function IDVRGB219_SetRGB219_Proxy(byval This as IDVRGB219 ptr, byval bState as WINBOOL) as HRESULT
declare sub IDVRGB219_SetRGB219_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IDVSplitter_INTERFACE_DEFINED__

extern IID_IDVSplitter as const IID

type IDVSplitter as IDVSplitter_

type IDVSplitterVtbl
	QueryInterface as function(byval This as IDVSplitter ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDVSplitter ptr) as ULONG
	Release as function(byval This as IDVSplitter ptr) as ULONG
	DiscardAlternateVideoFrames as function(byval This as IDVSplitter ptr, byval nDiscard as long) as HRESULT
end type

type IDVSplitter_
	lpVtbl as IDVSplitterVtbl ptr
end type

declare function IDVSplitter_DiscardAlternateVideoFrames_Proxy(byval This as IDVSplitter ptr, byval nDiscard as long) as HRESULT
declare sub IDVSplitter_DiscardAlternateVideoFrames_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type _AM_AUDIO_RENDERER_STAT_PARAM as long
enum
	AM_AUDREND_STAT_PARAM_BREAK_COUNT = 1
	AM_AUDREND_STAT_PARAM_SLAVE_MODE
	AM_AUDREND_STAT_PARAM_SILENCE_DUR
	AM_AUDREND_STAT_PARAM_LAST_BUFFER_DUR
	AM_AUDREND_STAT_PARAM_DISCONTINUITIES
	AM_AUDREND_STAT_PARAM_SLAVE_RATE
	AM_AUDREND_STAT_PARAM_SLAVE_DROPWRITE_DUR
	AM_AUDREND_STAT_PARAM_SLAVE_HIGHLOWERROR
	AM_AUDREND_STAT_PARAM_SLAVE_LASTHIGHLOWERROR
	AM_AUDREND_STAT_PARAM_SLAVE_ACCUMERROR
	AM_AUDREND_STAT_PARAM_BUFFERFULLNESS
	AM_AUDREND_STAT_PARAM_JITTER
end enum

extern __MIDL_itf_strmif_0359_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0359_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IAMAudioRendererStats_INTERFACE_DEFINED__

extern IID_IAMAudioRendererStats as const IID

type IAMAudioRendererStats as IAMAudioRendererStats_

type IAMAudioRendererStatsVtbl
	QueryInterface as function(byval This as IAMAudioRendererStats ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMAudioRendererStats ptr) as ULONG
	Release as function(byval This as IAMAudioRendererStats ptr) as ULONG
	GetStatParam as function(byval This as IAMAudioRendererStats ptr, byval dwParam as DWORD, byval pdwParam1 as DWORD ptr, byval pdwParam2 as DWORD ptr) as HRESULT
end type

type IAMAudioRendererStats_
	lpVtbl as IAMAudioRendererStatsVtbl ptr
end type

declare function IAMAudioRendererStats_GetStatParam_Proxy(byval This as IAMAudioRendererStats ptr, byval dwParam as DWORD, byval pdwParam1 as DWORD ptr, byval pdwParam2 as DWORD ptr) as HRESULT
declare sub IAMAudioRendererStats_GetStatParam_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type _AM_INTF_SEARCH_FLAGS as long
enum
	AM_INTF_SEARCH_INPUT_PIN = &h1
	AM_INTF_SEARCH_OUTPUT_PIN = &h2
	AM_INTF_SEARCH_FILTER = &h4
end enum

extern __MIDL_itf_strmif_0361_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0361_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IAMGraphStreams_INTERFACE_DEFINED__

extern IID_IAMGraphStreams as const IID

type IAMGraphStreams as IAMGraphStreams_

type IAMGraphStreamsVtbl
	QueryInterface as function(byval This as IAMGraphStreams ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMGraphStreams ptr) as ULONG
	Release as function(byval This as IAMGraphStreams ptr) as ULONG
	FindUpstreamInterface as function(byval This as IAMGraphStreams ptr, byval pPin as IPin ptr, byval riid as const IID const ptr, byval ppvInterface as any ptr ptr, byval dwFlags as DWORD) as HRESULT
	SyncUsingStreamOffset as function(byval This as IAMGraphStreams ptr, byval bUseStreamOffset as WINBOOL) as HRESULT
	SetMaxGraphLatency as function(byval This as IAMGraphStreams ptr, byval rtMaxGraphLatency as REFERENCE_TIME) as HRESULT
end type

type IAMGraphStreams_
	lpVtbl as IAMGraphStreamsVtbl ptr
end type

declare function IAMGraphStreams_FindUpstreamInterface_Proxy(byval This as IAMGraphStreams ptr, byval pPin as IPin ptr, byval riid as const IID const ptr, byval ppvInterface as any ptr ptr, byval dwFlags as DWORD) as HRESULT
declare sub IAMGraphStreams_FindUpstreamInterface_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMGraphStreams_SyncUsingStreamOffset_Proxy(byval This as IAMGraphStreams ptr, byval bUseStreamOffset as WINBOOL) as HRESULT
declare sub IAMGraphStreams_SyncUsingStreamOffset_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMGraphStreams_SetMaxGraphLatency_Proxy(byval This as IAMGraphStreams ptr, byval rtMaxGraphLatency as REFERENCE_TIME) as HRESULT
declare sub IAMGraphStreams_SetMaxGraphLatency_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type AMOVERLAYFX as long
enum
	AMOVERFX_NOFX = 0
	AMOVERFX_MIRRORLEFTRIGHT = &h2
	AMOVERFX_MIRRORUPDOWN = &h4
	AMOVERFX_DEINTERLACE = &h8
end enum

extern __MIDL_itf_strmif_0362_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0362_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IAMOverlayFX_INTERFACE_DEFINED__

extern IID_IAMOverlayFX as const IID

type IAMOverlayFX as IAMOverlayFX_

type IAMOverlayFXVtbl
	QueryInterface as function(byval This as IAMOverlayFX ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMOverlayFX ptr) as ULONG
	Release as function(byval This as IAMOverlayFX ptr) as ULONG
	QueryOverlayFXCaps as function(byval This as IAMOverlayFX ptr, byval lpdwOverlayFXCaps as DWORD ptr) as HRESULT
	SetOverlayFX as function(byval This as IAMOverlayFX ptr, byval dwOverlayFX as DWORD) as HRESULT
	GetOverlayFX as function(byval This as IAMOverlayFX ptr, byval lpdwOverlayFX as DWORD ptr) as HRESULT
end type

type IAMOverlayFX_
	lpVtbl as IAMOverlayFXVtbl ptr
end type

declare function IAMOverlayFX_QueryOverlayFXCaps_Proxy(byval This as IAMOverlayFX ptr, byval lpdwOverlayFXCaps as DWORD ptr) as HRESULT
declare sub IAMOverlayFX_QueryOverlayFXCaps_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMOverlayFX_SetOverlayFX_Proxy(byval This as IAMOverlayFX ptr, byval dwOverlayFX as DWORD) as HRESULT
declare sub IAMOverlayFX_SetOverlayFX_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMOverlayFX_GetOverlayFX_Proxy(byval This as IAMOverlayFX ptr, byval lpdwOverlayFX as DWORD ptr) as HRESULT
declare sub IAMOverlayFX_GetOverlayFX_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IAMOpenProgress_INTERFACE_DEFINED__

extern IID_IAMOpenProgress as const IID

type IAMOpenProgress as IAMOpenProgress_

type IAMOpenProgressVtbl
	QueryInterface as function(byval This as IAMOpenProgress ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMOpenProgress ptr) as ULONG
	Release as function(byval This as IAMOpenProgress ptr) as ULONG
	QueryProgress as function(byval This as IAMOpenProgress ptr, byval pllTotal as LONGLONG ptr, byval pllCurrent as LONGLONG ptr) as HRESULT
	AbortOperation as function(byval This as IAMOpenProgress ptr) as HRESULT
end type

type IAMOpenProgress_
	lpVtbl as IAMOpenProgressVtbl ptr
end type

declare function IAMOpenProgress_QueryProgress_Proxy(byval This as IAMOpenProgress ptr, byval pllTotal as LONGLONG ptr, byval pllCurrent as LONGLONG ptr) as HRESULT
declare sub IAMOpenProgress_QueryProgress_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMOpenProgress_AbortOperation_Proxy(byval This as IAMOpenProgress ptr) as HRESULT
declare sub IAMOpenProgress_AbortOperation_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IMpeg2Demultiplexer_INTERFACE_DEFINED__

extern IID_IMpeg2Demultiplexer as const IID

type IMpeg2Demultiplexer as IMpeg2Demultiplexer_

type IMpeg2DemultiplexerVtbl
	QueryInterface as function(byval This as IMpeg2Demultiplexer ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IMpeg2Demultiplexer ptr) as ULONG
	Release as function(byval This as IMpeg2Demultiplexer ptr) as ULONG
	CreateOutputPin as function(byval This as IMpeg2Demultiplexer ptr, byval pMediaType as AM_MEDIA_TYPE ptr, byval pszPinName as LPWSTR, byval ppIPin as IPin ptr ptr) as HRESULT
	SetOutputPinMediaType as function(byval This as IMpeg2Demultiplexer ptr, byval pszPinName as LPWSTR, byval pMediaType as AM_MEDIA_TYPE ptr) as HRESULT
	DeleteOutputPin as function(byval This as IMpeg2Demultiplexer ptr, byval pszPinName as LPWSTR) as HRESULT
end type

type IMpeg2Demultiplexer_
	lpVtbl as IMpeg2DemultiplexerVtbl ptr
end type

declare function IMpeg2Demultiplexer_CreateOutputPin_Proxy(byval This as IMpeg2Demultiplexer ptr, byval pMediaType as AM_MEDIA_TYPE ptr, byval pszPinName as LPWSTR, byval ppIPin as IPin ptr ptr) as HRESULT
declare sub IMpeg2Demultiplexer_CreateOutputPin_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMpeg2Demultiplexer_SetOutputPinMediaType_Proxy(byval This as IMpeg2Demultiplexer ptr, byval pszPinName as LPWSTR, byval pMediaType as AM_MEDIA_TYPE ptr) as HRESULT
declare sub IMpeg2Demultiplexer_SetOutputPinMediaType_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMpeg2Demultiplexer_DeleteOutputPin_Proxy(byval This as IMpeg2Demultiplexer ptr, byval pszPinName as LPWSTR) as HRESULT
declare sub IMpeg2Demultiplexer_DeleteOutputPin_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define MPEG2_PROGRAM_STREAM_MAP &h00000000
#define MPEG2_PROGRAM_ELEMENTARY_STREAM &h00000001
#define MPEG2_PROGRAM_DIRECTORY_PES_PACKET &h00000002
#define MPEG2_PROGRAM_PACK_HEADER &h00000003
#define MPEG2_PROGRAM_PES_STREAM &h00000004
#define MPEG2_PROGRAM_SYSTEM_HEADER &h00000005
#define SUBSTREAM_FILTER_VAL_NONE &h10000000

type __MIDL___MIDL_itf_strmif_0365_0001
	stream_id as ULONG
	dwMediaSampleContent as DWORD
	ulSubstreamFilterValue as ULONG
	iDataOffset as long
end type

type STREAM_ID_MAP as __MIDL___MIDL_itf_strmif_0365_0001

extern __MIDL_itf_strmif_0365_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0365_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IEnumStreamIdMap_INTERFACE_DEFINED__

extern IID_IEnumStreamIdMap as const IID

type IEnumStreamIdMap as IEnumStreamIdMap_

type IEnumStreamIdMapVtbl
	QueryInterface as function(byval This as IEnumStreamIdMap ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEnumStreamIdMap ptr) as ULONG
	Release as function(byval This as IEnumStreamIdMap ptr) as ULONG
	Next as function(byval This as IEnumStreamIdMap ptr, byval cRequest as ULONG, byval pStreamIdMap as STREAM_ID_MAP ptr, byval pcReceived as ULONG ptr) as HRESULT
	Skip as function(byval This as IEnumStreamIdMap ptr, byval cRecords as ULONG) as HRESULT
	Reset as function(byval This as IEnumStreamIdMap ptr) as HRESULT
	Clone as function(byval This as IEnumStreamIdMap ptr, byval ppIEnumStreamIdMap as IEnumStreamIdMap ptr ptr) as HRESULT
end type

type IEnumStreamIdMap_
	lpVtbl as IEnumStreamIdMapVtbl ptr
end type

declare function IEnumStreamIdMap_Next_Proxy(byval This as IEnumStreamIdMap ptr, byval cRequest as ULONG, byval pStreamIdMap as STREAM_ID_MAP ptr, byval pcReceived as ULONG ptr) as HRESULT
declare sub IEnumStreamIdMap_Next_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEnumStreamIdMap_Skip_Proxy(byval This as IEnumStreamIdMap ptr, byval cRecords as ULONG) as HRESULT
declare sub IEnumStreamIdMap_Skip_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEnumStreamIdMap_Reset_Proxy(byval This as IEnumStreamIdMap ptr) as HRESULT
declare sub IEnumStreamIdMap_Reset_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEnumStreamIdMap_Clone_Proxy(byval This as IEnumStreamIdMap ptr, byval ppIEnumStreamIdMap as IEnumStreamIdMap ptr ptr) as HRESULT
declare sub IEnumStreamIdMap_Clone_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IMPEG2StreamIdMap_INTERFACE_DEFINED__

extern IID_IMPEG2StreamIdMap as const IID

type IMPEG2StreamIdMap as IMPEG2StreamIdMap_

type IMPEG2StreamIdMapVtbl
	QueryInterface as function(byval This as IMPEG2StreamIdMap ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IMPEG2StreamIdMap ptr) as ULONG
	Release as function(byval This as IMPEG2StreamIdMap ptr) as ULONG
	MapStreamId as function(byval This as IMPEG2StreamIdMap ptr, byval ulStreamId as ULONG, byval MediaSampleContent as DWORD, byval ulSubstreamFilterValue as ULONG, byval iDataOffset as long) as HRESULT
	UnmapStreamId as function(byval This as IMPEG2StreamIdMap ptr, byval culStreamId as ULONG, byval pulStreamId as ULONG ptr) as HRESULT
	EnumStreamIdMap as function(byval This as IMPEG2StreamIdMap ptr, byval ppIEnumStreamIdMap as IEnumStreamIdMap ptr ptr) as HRESULT
end type

type IMPEG2StreamIdMap_
	lpVtbl as IMPEG2StreamIdMapVtbl ptr
end type

declare function IMPEG2StreamIdMap_MapStreamId_Proxy(byval This as IMPEG2StreamIdMap ptr, byval ulStreamId as ULONG, byval MediaSampleContent as DWORD, byval ulSubstreamFilterValue as ULONG, byval iDataOffset as long) as HRESULT
declare sub IMPEG2StreamIdMap_MapStreamId_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMPEG2StreamIdMap_UnmapStreamId_Proxy(byval This as IMPEG2StreamIdMap ptr, byval culStreamId as ULONG, byval pulStreamId as ULONG ptr) as HRESULT
declare sub IMPEG2StreamIdMap_UnmapStreamId_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMPEG2StreamIdMap_EnumStreamIdMap_Proxy(byval This as IMPEG2StreamIdMap ptr, byval ppIEnumStreamIdMap as IEnumStreamIdMap ptr ptr) as HRESULT
declare sub IMPEG2StreamIdMap_EnumStreamIdMap_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IRegisterServiceProvider_INTERFACE_DEFINED__

extern IID_IRegisterServiceProvider as const IID

type IRegisterServiceProvider as IRegisterServiceProvider_

type IRegisterServiceProviderVtbl
	QueryInterface as function(byval This as IRegisterServiceProvider ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IRegisterServiceProvider ptr) as ULONG
	Release as function(byval This as IRegisterServiceProvider ptr) as ULONG
	RegisterService as function(byval This as IRegisterServiceProvider ptr, byval guidService as const GUID const ptr, byval pUnkObject as IUnknown ptr) as HRESULT
end type

type IRegisterServiceProvider_
	lpVtbl as IRegisterServiceProviderVtbl ptr
end type

declare function IRegisterServiceProvider_RegisterService_Proxy(byval This as IRegisterServiceProvider ptr, byval guidService as const GUID const ptr, byval pUnkObject as IUnknown ptr) as HRESULT
declare sub IRegisterServiceProvider_RegisterService_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IAMClockSlave_INTERFACE_DEFINED__

extern IID_IAMClockSlave as const IID

type IAMClockSlave as IAMClockSlave_

type IAMClockSlaveVtbl
	QueryInterface as function(byval This as IAMClockSlave ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMClockSlave ptr) as ULONG
	Release as function(byval This as IAMClockSlave ptr) as ULONG
	SetErrorTolerance as function(byval This as IAMClockSlave ptr, byval dwTolerance as DWORD) as HRESULT
	GetErrorTolerance as function(byval This as IAMClockSlave ptr, byval pdwTolerance as DWORD ptr) as HRESULT
end type

type IAMClockSlave_
	lpVtbl as IAMClockSlaveVtbl ptr
end type

declare function IAMClockSlave_SetErrorTolerance_Proxy(byval This as IAMClockSlave ptr, byval dwTolerance as DWORD) as HRESULT
declare sub IAMClockSlave_SetErrorTolerance_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMClockSlave_GetErrorTolerance_Proxy(byval This as IAMClockSlave ptr, byval pdwTolerance as DWORD ptr) as HRESULT
declare sub IAMClockSlave_GetErrorTolerance_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type CodecAPIEventData
	guid as GUID
	dataLength as DWORD
	reserved(0 to 2) as DWORD
end type

extern __MIDL_itf_strmif_0370_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0370_v0_0_s_ifspec as RPC_IF_HANDLE

#define __ICodecAPI_INTERFACE_DEFINED__

extern IID_ICodecAPI as const IID

type ICodecAPI as ICodecAPI_

type ICodecAPIVtbl
	QueryInterface as function(byval This as ICodecAPI ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ICodecAPI ptr) as ULONG
	Release as function(byval This as ICodecAPI ptr) as ULONG
	IsSupported as function(byval This as ICodecAPI ptr, byval Api as const GUID ptr) as HRESULT
	IsModifiable as function(byval This as ICodecAPI ptr, byval Api as const GUID ptr) as HRESULT
	GetParameterRange as function(byval This as ICodecAPI ptr, byval Api as const GUID ptr, byval ValueMin as VARIANT ptr, byval ValueMax as VARIANT ptr, byval SteppingDelta as VARIANT ptr) as HRESULT
	GetParameterValues as function(byval This as ICodecAPI ptr, byval Api as const GUID ptr, byval Values as VARIANT ptr ptr, byval ValuesCount as ULONG ptr) as HRESULT
	GetDefaultValue as function(byval This as ICodecAPI ptr, byval Api as const GUID ptr, byval Value as VARIANT ptr) as HRESULT
	GetValue as function(byval This as ICodecAPI ptr, byval Api as const GUID ptr, byval Value as VARIANT ptr) as HRESULT
	SetValue as function(byval This as ICodecAPI ptr, byval Api as const GUID ptr, byval Value as VARIANT ptr) as HRESULT
	RegisterForEvent as function(byval This as ICodecAPI ptr, byval Api as const GUID ptr, byval userData as LONG_PTR) as HRESULT
	UnregisterForEvent as function(byval This as ICodecAPI ptr, byval Api as const GUID ptr) as HRESULT
	SetAllDefaults as function(byval This as ICodecAPI ptr) as HRESULT
	SetValueWithNotify as function(byval This as ICodecAPI ptr, byval Api as const GUID ptr, byval Value as VARIANT ptr, byval ChangedParam as GUID ptr ptr, byval ChangedParamCount as ULONG ptr) as HRESULT
	SetAllDefaultsWithNotify as function(byval This as ICodecAPI ptr, byval ChangedParam as GUID ptr ptr, byval ChangedParamCount as ULONG ptr) as HRESULT
	GetAllSettings as function(byval This as ICodecAPI ptr, byval __MIDL_0016 as IStream ptr) as HRESULT
	SetAllSettings as function(byval This as ICodecAPI ptr, byval __MIDL_0017 as IStream ptr) as HRESULT
	SetAllSettingsWithNotify as function(byval This as ICodecAPI ptr, byval __MIDL_0018 as IStream ptr, byval ChangedParam as GUID ptr ptr, byval ChangedParamCount as ULONG ptr) as HRESULT
end type

type ICodecAPI_
	lpVtbl as ICodecAPIVtbl ptr
end type

declare function ICodecAPI_IsSupported_Proxy(byval This as ICodecAPI ptr, byval Api as const GUID ptr) as HRESULT
declare sub ICodecAPI_IsSupported_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICodecAPI_IsModifiable_Proxy(byval This as ICodecAPI ptr, byval Api as const GUID ptr) as HRESULT
declare sub ICodecAPI_IsModifiable_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICodecAPI_GetParameterRange_Proxy(byval This as ICodecAPI ptr, byval Api as const GUID ptr, byval ValueMin as VARIANT ptr, byval ValueMax as VARIANT ptr, byval SteppingDelta as VARIANT ptr) as HRESULT
declare sub ICodecAPI_GetParameterRange_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICodecAPI_GetParameterValues_Proxy(byval This as ICodecAPI ptr, byval Api as const GUID ptr, byval Values as VARIANT ptr ptr, byval ValuesCount as ULONG ptr) as HRESULT
declare sub ICodecAPI_GetParameterValues_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICodecAPI_GetDefaultValue_Proxy(byval This as ICodecAPI ptr, byval Api as const GUID ptr, byval Value as VARIANT ptr) as HRESULT
declare sub ICodecAPI_GetDefaultValue_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICodecAPI_GetValue_Proxy(byval This as ICodecAPI ptr, byval Api as const GUID ptr, byval Value as VARIANT ptr) as HRESULT
declare sub ICodecAPI_GetValue_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICodecAPI_SetValue_Proxy(byval This as ICodecAPI ptr, byval Api as const GUID ptr, byval Value as VARIANT ptr) as HRESULT
declare sub ICodecAPI_SetValue_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICodecAPI_RegisterForEvent_Proxy(byval This as ICodecAPI ptr, byval Api as const GUID ptr, byval userData as LONG_PTR) as HRESULT
declare sub ICodecAPI_RegisterForEvent_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICodecAPI_UnregisterForEvent_Proxy(byval This as ICodecAPI ptr, byval Api as const GUID ptr) as HRESULT
declare sub ICodecAPI_UnregisterForEvent_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICodecAPI_SetAllDefaults_Proxy(byval This as ICodecAPI ptr) as HRESULT
declare sub ICodecAPI_SetAllDefaults_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICodecAPI_SetValueWithNotify_Proxy(byval This as ICodecAPI ptr, byval Api as const GUID ptr, byval Value as VARIANT ptr, byval ChangedParam as GUID ptr ptr, byval ChangedParamCount as ULONG ptr) as HRESULT
declare sub ICodecAPI_SetValueWithNotify_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICodecAPI_SetAllDefaultsWithNotify_Proxy(byval This as ICodecAPI ptr, byval ChangedParam as GUID ptr ptr, byval ChangedParamCount as ULONG ptr) as HRESULT
declare sub ICodecAPI_SetAllDefaultsWithNotify_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICodecAPI_GetAllSettings_Proxy(byval This as ICodecAPI ptr, byval __MIDL_0016 as IStream ptr) as HRESULT
declare sub ICodecAPI_GetAllSettings_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICodecAPI_SetAllSettings_Proxy(byval This as ICodecAPI ptr, byval __MIDL_0017 as IStream ptr) as HRESULT
declare sub ICodecAPI_SetAllSettings_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICodecAPI_SetAllSettingsWithNotify_Proxy(byval This as ICodecAPI ptr, byval __MIDL_0018 as IStream ptr, byval ChangedParam as GUID ptr ptr, byval ChangedParamCount as ULONG ptr) as HRESULT
declare sub ICodecAPI_SetAllSettingsWithNotify_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IGetCapabilitiesKey_INTERFACE_DEFINED__

extern IID_IGetCapabilitiesKey as const IID

type IGetCapabilitiesKey as IGetCapabilitiesKey_

type IGetCapabilitiesKeyVtbl
	QueryInterface as function(byval This as IGetCapabilitiesKey ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IGetCapabilitiesKey ptr) as ULONG
	Release as function(byval This as IGetCapabilitiesKey ptr) as ULONG
	GetCapabilitiesKey as function(byval This as IGetCapabilitiesKey ptr, byval pHKey as HKEY ptr) as HRESULT
end type

type IGetCapabilitiesKey_
	lpVtbl as IGetCapabilitiesKeyVtbl ptr
end type

declare function IGetCapabilitiesKey_GetCapabilitiesKey_Proxy(byval This as IGetCapabilitiesKey ptr, byval pHKey as HKEY ptr) as HRESULT
declare sub IGetCapabilitiesKey_GetCapabilitiesKey_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IEncoderAPI_INTERFACE_DEFINED__

extern IID_IEncoderAPI as const IID

type IEncoderAPI as IEncoderAPI_

type IEncoderAPIVtbl
	QueryInterface as function(byval This as IEncoderAPI ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEncoderAPI ptr) as ULONG
	Release as function(byval This as IEncoderAPI ptr) as ULONG
	IsSupported as function(byval This as IEncoderAPI ptr, byval Api as const GUID ptr) as HRESULT
	IsAvailable as function(byval This as IEncoderAPI ptr, byval Api as const GUID ptr) as HRESULT
	GetParameterRange as function(byval This as IEncoderAPI ptr, byval Api as const GUID ptr, byval ValueMin as VARIANT ptr, byval ValueMax as VARIANT ptr, byval SteppingDelta as VARIANT ptr) as HRESULT
	GetParameterValues as function(byval This as IEncoderAPI ptr, byval Api as const GUID ptr, byval Values as VARIANT ptr ptr, byval ValuesCount as ULONG ptr) as HRESULT
	GetDefaultValue as function(byval This as IEncoderAPI ptr, byval Api as const GUID ptr, byval Value as VARIANT ptr) as HRESULT
	GetValue as function(byval This as IEncoderAPI ptr, byval Api as const GUID ptr, byval Value as VARIANT ptr) as HRESULT
	SetValue as function(byval This as IEncoderAPI ptr, byval Api as const GUID ptr, byval Value as VARIANT ptr) as HRESULT
end type

type IEncoderAPI_
	lpVtbl as IEncoderAPIVtbl ptr
end type

declare function IEncoderAPI_IsSupported_Proxy(byval This as IEncoderAPI ptr, byval Api as const GUID ptr) as HRESULT
declare sub IEncoderAPI_IsSupported_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEncoderAPI_IsAvailable_Proxy(byval This as IEncoderAPI ptr, byval Api as const GUID ptr) as HRESULT
declare sub IEncoderAPI_IsAvailable_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEncoderAPI_GetParameterRange_Proxy(byval This as IEncoderAPI ptr, byval Api as const GUID ptr, byval ValueMin as VARIANT ptr, byval ValueMax as VARIANT ptr, byval SteppingDelta as VARIANT ptr) as HRESULT
declare sub IEncoderAPI_GetParameterRange_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEncoderAPI_GetParameterValues_Proxy(byval This as IEncoderAPI ptr, byval Api as const GUID ptr, byval Values as VARIANT ptr ptr, byval ValuesCount as ULONG ptr) as HRESULT
declare sub IEncoderAPI_GetParameterValues_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEncoderAPI_GetDefaultValue_Proxy(byval This as IEncoderAPI ptr, byval Api as const GUID ptr, byval Value as VARIANT ptr) as HRESULT
declare sub IEncoderAPI_GetDefaultValue_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEncoderAPI_GetValue_Proxy(byval This as IEncoderAPI ptr, byval Api as const GUID ptr, byval Value as VARIANT ptr) as HRESULT
declare sub IEncoderAPI_GetValue_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEncoderAPI_SetValue_Proxy(byval This as IEncoderAPI ptr, byval Api as const GUID ptr, byval Value as VARIANT ptr) as HRESULT
declare sub IEncoderAPI_SetValue_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IVideoEncoder_INTERFACE_DEFINED__

extern IID_IVideoEncoder as const IID

type IVideoEncoder as IVideoEncoder_

type IVideoEncoderVtbl
	QueryInterface as function(byval This as IVideoEncoder ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IVideoEncoder ptr) as ULONG
	Release as function(byval This as IVideoEncoder ptr) as ULONG
	IsSupported as function(byval This as IVideoEncoder ptr, byval Api as const GUID ptr) as HRESULT
	IsAvailable as function(byval This as IVideoEncoder ptr, byval Api as const GUID ptr) as HRESULT
	GetParameterRange as function(byval This as IVideoEncoder ptr, byval Api as const GUID ptr, byval ValueMin as VARIANT ptr, byval ValueMax as VARIANT ptr, byval SteppingDelta as VARIANT ptr) as HRESULT
	GetParameterValues as function(byval This as IVideoEncoder ptr, byval Api as const GUID ptr, byval Values as VARIANT ptr ptr, byval ValuesCount as ULONG ptr) as HRESULT
	GetDefaultValue as function(byval This as IVideoEncoder ptr, byval Api as const GUID ptr, byval Value as VARIANT ptr) as HRESULT
	GetValue as function(byval This as IVideoEncoder ptr, byval Api as const GUID ptr, byval Value as VARIANT ptr) as HRESULT
	SetValue as function(byval This as IVideoEncoder ptr, byval Api as const GUID ptr, byval Value as VARIANT ptr) as HRESULT
end type

type IVideoEncoder_
	lpVtbl as IVideoEncoderVtbl ptr
end type

#define __ENCODER_API_DEFINES__

type __MIDL___MIDL_itf_strmif_0374_0001 as long
enum
	ConstantBitRate = 0
	VariableBitRateAverage
	VariableBitRatePeak
end enum

type VIDEOENCODER_BITRATE_MODE as __MIDL___MIDL_itf_strmif_0374_0001

#define AM_GETDECODERCAP_QUERY_VMR_SUPPORT &h00000001
#define VMR_NOTSUPPORTED &h00000000
#define VMR_SUPPORTED &h00000001
#define AM_QUERY_DECODER_VMR_SUPPORT &h00000001
#define AM_QUERY_DECODER_DXVA_1_SUPPORT &h00000002
#define AM_QUERY_DECODER_DVD_SUPPORT &h00000003
#define AM_QUERY_DECODER_ATSC_SD_SUPPORT &h00000004
#define AM_QUERY_DECODER_ATSC_HD_SUPPORT &h00000005
#define AM_GETDECODERCAP_QUERY_VMR9_SUPPORT &h00000006
#define DECODER_CAP_NOTSUPPORTED &h00000000
#define DECODER_CAP_SUPPORTED &h00000001

extern __MIDL_itf_strmif_0374_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0374_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IAMDecoderCaps_INTERFACE_DEFINED__

extern IID_IAMDecoderCaps as const IID

type IAMDecoderCaps as IAMDecoderCaps_

type IAMDecoderCapsVtbl
	QueryInterface as function(byval This as IAMDecoderCaps ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMDecoderCaps ptr) as ULONG
	Release as function(byval This as IAMDecoderCaps ptr) as ULONG
	GetDecoderCaps as function(byval This as IAMDecoderCaps ptr, byval dwCapIndex as DWORD, byval lpdwCap as DWORD ptr) as HRESULT
end type

type IAMDecoderCaps_
	lpVtbl as IAMDecoderCapsVtbl ptr
end type

declare function IAMDecoderCaps_GetDecoderCaps_Proxy(byval This as IAMDecoderCaps ptr, byval dwCapIndex as DWORD, byval lpdwCap as DWORD ptr) as HRESULT
declare sub IAMDecoderCaps_GetDecoderCaps_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type _AMCOPPSignature
	Signature(0 to 255) as UBYTE
end type

type AMCOPPSignature as _AMCOPPSignature

type _AMCOPPCommand
	macKDI as GUID
	guidCommandID as GUID
	dwSequence as DWORD
	cbSizeData as DWORD
	CommandData(0 to 4055) as UBYTE
end type

type AMCOPPCommand as _AMCOPPCommand
type LPAMCOPPCommand as _AMCOPPCommand ptr

type _AMCOPPStatusInput
	rApp as GUID
	guidStatusRequestID as GUID
	dwSequence as DWORD
	cbSizeData as DWORD
	StatusData(0 to 4055) as UBYTE
end type

type AMCOPPStatusInput as _AMCOPPStatusInput
type LPAMCOPPStatusInput as _AMCOPPStatusInput ptr

type _AMCOPPStatusOutput
	macKDI as GUID
	cbSizeData as DWORD
	COPPStatus(0 to 4075) as UBYTE
end type

type AMCOPPStatusOutput as _AMCOPPStatusOutput
type LPAMCOPPStatusOutput as _AMCOPPStatusOutput ptr

extern __MIDL_itf_strmif_0375_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0375_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IAMCertifiedOutputProtection_INTERFACE_DEFINED__

extern IID_IAMCertifiedOutputProtection as const IID

type IAMCertifiedOutputProtection as IAMCertifiedOutputProtection_

type IAMCertifiedOutputProtectionVtbl
	QueryInterface as function(byval This as IAMCertifiedOutputProtection ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMCertifiedOutputProtection ptr) as ULONG
	Release as function(byval This as IAMCertifiedOutputProtection ptr) as ULONG
	KeyExchange as function(byval This as IAMCertifiedOutputProtection ptr, byval pRandom as GUID ptr, byval VarLenCertGH as UBYTE ptr ptr, byval pdwLengthCertGH as DWORD ptr) as HRESULT
	SessionSequenceStart as function(byval This as IAMCertifiedOutputProtection ptr, byval pSig as AMCOPPSignature ptr) as HRESULT
	ProtectionCommand as function(byval This as IAMCertifiedOutputProtection ptr, byval cmd as const AMCOPPCommand ptr) as HRESULT
	ProtectionStatus as function(byval This as IAMCertifiedOutputProtection ptr, byval pStatusInput as const AMCOPPStatusInput ptr, byval pStatusOutput as AMCOPPStatusOutput ptr) as HRESULT
end type

type IAMCertifiedOutputProtection_
	lpVtbl as IAMCertifiedOutputProtectionVtbl ptr
end type

declare function IAMCertifiedOutputProtection_KeyExchange_Proxy(byval This as IAMCertifiedOutputProtection ptr, byval pRandom as GUID ptr, byval VarLenCertGH as UBYTE ptr ptr, byval pdwLengthCertGH as DWORD ptr) as HRESULT
declare sub IAMCertifiedOutputProtection_KeyExchange_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMCertifiedOutputProtection_SessionSequenceStart_Proxy(byval This as IAMCertifiedOutputProtection ptr, byval pSig as AMCOPPSignature ptr) as HRESULT
declare sub IAMCertifiedOutputProtection_SessionSequenceStart_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMCertifiedOutputProtection_ProtectionCommand_Proxy(byval This as IAMCertifiedOutputProtection ptr, byval cmd as const AMCOPPCommand ptr) as HRESULT
declare sub IAMCertifiedOutputProtection_ProtectionCommand_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMCertifiedOutputProtection_ProtectionStatus_Proxy(byval This as IAMCertifiedOutputProtection ptr, byval pStatusInput as const AMCOPPStatusInput ptr, byval pStatusOutput as AMCOPPStatusOutput ptr) as HRESULT
declare sub IAMCertifiedOutputProtection_ProtectionStatus_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type tagDVD_DOMAIN as long
enum
	DVD_DOMAIN_FirstPlay = 1
	DVD_DOMAIN_VideoManagerMenu
	DVD_DOMAIN_VideoTitleSetMenu
	DVD_DOMAIN_Title
	DVD_DOMAIN_Stop
end enum

type DVD_DOMAIN as tagDVD_DOMAIN

type tagDVD_MENU_ID as long
enum
	DVD_MENU_Title = 2
	DVD_MENU_Root = 3
	DVD_MENU_Subpicture = 4
	DVD_MENU_Audio = 5
	DVD_MENU_Angle = 6
	DVD_MENU_Chapter = 7
end enum

type DVD_MENU_ID as tagDVD_MENU_ID

type tagDVD_DISC_SIDE as long
enum
	DVD_SIDE_A = 1
	DVD_SIDE_B = 2
end enum

type DVD_DISC_SIDE as tagDVD_DISC_SIDE

type tagDVD_PREFERRED_DISPLAY_MODE as long
enum
	DISPLAY_CONTENT_DEFAULT = 0
	DISPLAY_16x9 = 1
	DISPLAY_4x3_PANSCAN_PREFERRED = 2
	DISPLAY_4x3_LETTERBOX_PREFERRED = 3
end enum

type DVD_PREFERRED_DISPLAY_MODE as tagDVD_PREFERRED_DISPLAY_MODE
type DVD_REGISTER as WORD

type tagDVD_ATR
	ulCAT as ULONG
	pbATRI(0 to 767) as UBYTE
end type

type DVD_ATR as tagDVD_ATR

type tagDVD_FRAMERATE as long
enum
	DVD_FPS_25 = 1
	DVD_FPS_30NonDrop = 3
end enum

type DVD_FRAMERATE as tagDVD_FRAMERATE

type tagDVD_TIMECODE
	Hours1 : 4 as ULONG
	Hours10 : 4 as ULONG
	Minutes1 : 4 as ULONG
	Minutes10 : 4 as ULONG
	Seconds1 : 4 as ULONG
	Seconds10 : 4 as ULONG
	Frames1 : 4 as ULONG
	Frames10 : 2 as ULONG
	FrameRateCode : 2 as ULONG
end type

type DVD_TIMECODE as tagDVD_TIMECODE

type tagDVD_TIMECODE_FLAGS as long
enum
	DVD_TC_FLAG_25fps = &h1
	DVD_TC_FLAG_30fps = &h2
	DVD_TC_FLAG_DropFrame = &h4
	DVD_TC_FLAG_Interpolated = &h8
end enum

type DVD_TIMECODE_FLAGS as tagDVD_TIMECODE_FLAGS

type tagDVD_HMSF_TIMECODE
	bHours as UBYTE
	bMinutes as UBYTE
	bSeconds as UBYTE
	bFrames as UBYTE
end type

type DVD_HMSF_TIMECODE as tagDVD_HMSF_TIMECODE

type tagDVD_PLAYBACK_LOCATION2
	TitleNum as ULONG
	ChapterNum as ULONG
	TimeCode as DVD_HMSF_TIMECODE
	TimeCodeFlags as ULONG
end type

type DVD_PLAYBACK_LOCATION2 as tagDVD_PLAYBACK_LOCATION2

type tagDVD_PLAYBACK_LOCATION
	TitleNum as ULONG
	ChapterNum as ULONG
	TimeCode as ULONG
end type

type DVD_PLAYBACK_LOCATION as tagDVD_PLAYBACK_LOCATION
type VALID_UOP_SOMTHING_OR_OTHER as DWORD

type __MIDL___MIDL_itf_strmif_0376_0001 as long
enum
	UOP_FLAG_Play_Title_Or_AtTime = &h1
	UOP_FLAG_Play_Chapter = &h2
	UOP_FLAG_Play_Title = &h4
	UOP_FLAG_Stop = &h8
	UOP_FLAG_ReturnFromSubMenu = &h10
	UOP_FLAG_Play_Chapter_Or_AtTime = &h20
	UOP_FLAG_PlayPrev_Or_Replay_Chapter = &h40
	UOP_FLAG_PlayNext_Chapter = &h80
	UOP_FLAG_Play_Forwards = &h100
	UOP_FLAG_Play_Backwards = &h200
	UOP_FLAG_ShowMenu_Title = &h400
	UOP_FLAG_ShowMenu_Root = &h800
	UOP_FLAG_ShowMenu_SubPic = &h1000
	UOP_FLAG_ShowMenu_Audio = &h2000
	UOP_FLAG_ShowMenu_Angle = &h4000
	UOP_FLAG_ShowMenu_Chapter = &h8000
	UOP_FLAG_Resume = &h10000
	UOP_FLAG_Select_Or_Activate_Button = &h20000
	UOP_FLAG_Still_Off = &h40000
	UOP_FLAG_Pause_On = &h80000
	UOP_FLAG_Select_Audio_Stream = &h100000
	UOP_FLAG_Select_SubPic_Stream = &h200000
	UOP_FLAG_Select_Angle = &h400000
	UOP_FLAG_Select_Karaoke_Audio_Presentation_Mode = &h800000
	UOP_FLAG_Select_Video_Mode_Preference = &h1000000
end enum

type VALID_UOP_FLAG as __MIDL___MIDL_itf_strmif_0376_0001

type __MIDL___MIDL_itf_strmif_0376_0002 as long
enum
	DVD_CMD_FLAG_None = 0
	DVD_CMD_FLAG_Flush = &h1
	DVD_CMD_FLAG_SendEvents = &h2
	DVD_CMD_FLAG_Block = &h4
	DVD_CMD_FLAG_StartWhenRendered = &h8
	DVD_CMD_FLAG_EndAfterRendered = &h10
end enum

type DVD_CMD_FLAGS as __MIDL___MIDL_itf_strmif_0376_0002

type __MIDL___MIDL_itf_strmif_0376_0003 as long
enum
	DVD_ResetOnStop = 1
	DVD_NotifyParentalLevelChange = 2
	DVD_HMSF_TimeCodeEvents = 3
	DVD_AudioDuringFFwdRew = 4
end enum

type DVD_OPTION_FLAG as __MIDL___MIDL_itf_strmif_0376_0003

type __MIDL___MIDL_itf_strmif_0376_0004 as long
enum
	DVD_Relative_Upper = 1
	DVD_Relative_Lower = 2
	DVD_Relative_Left = 3
	DVD_Relative_Right = 4
end enum

type DVD_RELATIVE_BUTTON as __MIDL___MIDL_itf_strmif_0376_0004

type tagDVD_PARENTAL_LEVEL as long
enum
	DVD_PARENTAL_LEVEL_8 = &h8000
	DVD_PARENTAL_LEVEL_7 = &h4000
	DVD_PARENTAL_LEVEL_6 = &h2000
	DVD_PARENTAL_LEVEL_5 = &h1000
	DVD_PARENTAL_LEVEL_4 = &h800
	DVD_PARENTAL_LEVEL_3 = &h400
	DVD_PARENTAL_LEVEL_2 = &h200
	DVD_PARENTAL_LEVEL_1 = &h100
end enum

type DVD_PARENTAL_LEVEL as tagDVD_PARENTAL_LEVEL

type tagDVD_AUDIO_LANG_EXT as long
enum
	DVD_AUD_EXT_NotSpecified = 0
	DVD_AUD_EXT_Captions = 1
	DVD_AUD_EXT_VisuallyImpaired = 2
	DVD_AUD_EXT_DirectorComments1 = 3
	DVD_AUD_EXT_DirectorComments2 = 4
end enum

type DVD_AUDIO_LANG_EXT as tagDVD_AUDIO_LANG_EXT

type tagDVD_SUBPICTURE_LANG_EXT as long
enum
	DVD_SP_EXT_NotSpecified = 0
	DVD_SP_EXT_Caption_Normal = 1
	DVD_SP_EXT_Caption_Big = 2
	DVD_SP_EXT_Caption_Children = 3
	DVD_SP_EXT_CC_Normal = 5
	DVD_SP_EXT_CC_Big = 6
	DVD_SP_EXT_CC_Children = 7
	DVD_SP_EXT_Forced = 9
	DVD_SP_EXT_DirectorComments_Normal = 13
	DVD_SP_EXT_DirectorComments_Big = 14
	DVD_SP_EXT_DirectorComments_Children = 15
end enum

type DVD_SUBPICTURE_LANG_EXT as tagDVD_SUBPICTURE_LANG_EXT

type tagDVD_AUDIO_APPMODE as long
enum
	DVD_AudioMode_None = 0
	DVD_AudioMode_Karaoke = 1
	DVD_AudioMode_Surround = 2
	DVD_AudioMode_Other = 3
end enum

type DVD_AUDIO_APPMODE as tagDVD_AUDIO_APPMODE

type tagDVD_AUDIO_FORMAT as long
enum
	DVD_AudioFormat_AC3 = 0
	DVD_AudioFormat_MPEG1 = 1
	DVD_AudioFormat_MPEG1_DRC = 2
	DVD_AudioFormat_MPEG2 = 3
	DVD_AudioFormat_MPEG2_DRC = 4
	DVD_AudioFormat_LPCM = 5
	DVD_AudioFormat_DTS = 6
	DVD_AudioFormat_SDDS = 7
	DVD_AudioFormat_Other = 8
end enum

type DVD_AUDIO_FORMAT as tagDVD_AUDIO_FORMAT

type tagDVD_KARAOKE_DOWNMIX as long
enum
	DVD_Mix_0to0 = &h1
	DVD_Mix_1to0 = &h2
	DVD_Mix_2to0 = &h4
	DVD_Mix_3to0 = &h8
	DVD_Mix_4to0 = &h10
	DVD_Mix_Lto0 = &h20
	DVD_Mix_Rto0 = &h40
	DVD_Mix_0to1 = &h100
	DVD_Mix_1to1 = &h200
	DVD_Mix_2to1 = &h400
	DVD_Mix_3to1 = &h800
	DVD_Mix_4to1 = &h1000
	DVD_Mix_Lto1 = &h2000
	DVD_Mix_Rto1 = &h4000
end enum

type DVD_KARAOKE_DOWNMIX as tagDVD_KARAOKE_DOWNMIX

type tagDVD_AudioAttributes
	AppMode as DVD_AUDIO_APPMODE
	AppModeData as UBYTE
	AudioFormat as DVD_AUDIO_FORMAT
	Language as LCID
	LanguageExtension as DVD_AUDIO_LANG_EXT
	fHasMultichannelInfo as WINBOOL
	dwFrequency as DWORD
	bQuantization as UBYTE
	bNumberOfChannels as UBYTE
	dwReserved(0 to 1) as DWORD
end type

type DVD_AudioAttributes as tagDVD_AudioAttributes

type tagDVD_MUA_MixingInfo
	fMixTo0 as WINBOOL
	fMixTo1 as WINBOOL
	fMix0InPhase as WINBOOL
	fMix1InPhase as WINBOOL
	dwSpeakerPosition as DWORD
end type

type DVD_MUA_MixingInfo as tagDVD_MUA_MixingInfo

type tagDVD_MUA_Coeff
	log2_alpha as double
	log2_beta as double
end type

type DVD_MUA_Coeff as tagDVD_MUA_Coeff

type tagDVD_MultichannelAudioAttributes
	Info(0 to 7) as DVD_MUA_MixingInfo
	Coeff(0 to 7) as DVD_MUA_Coeff
end type

type DVD_MultichannelAudioAttributes as tagDVD_MultichannelAudioAttributes

type tagDVD_KARAOKE_CONTENTS as long
enum
	DVD_Karaoke_GuideVocal1 = &h1
	DVD_Karaoke_GuideVocal2 = &h2
	DVD_Karaoke_GuideMelody1 = &h4
	DVD_Karaoke_GuideMelody2 = &h8
	DVD_Karaoke_GuideMelodyA = &h10
	DVD_Karaoke_GuideMelodyB = &h20
	DVD_Karaoke_SoundEffectA = &h40
	DVD_Karaoke_SoundEffectB = &h80
end enum

type DVD_KARAOKE_CONTENTS as tagDVD_KARAOKE_CONTENTS

type tagDVD_KARAOKE_ASSIGNMENT as long
enum
	DVD_Assignment_reserved0 = 0
	DVD_Assignment_reserved1 = 1
	DVD_Assignment_LR = 2
	DVD_Assignment_LRM = 3
	DVD_Assignment_LR1 = 4
	DVD_Assignment_LRM1 = 5
	DVD_Assignment_LR12 = 6
	DVD_Assignment_LRM12 = 7
end enum

type DVD_KARAOKE_ASSIGNMENT as tagDVD_KARAOKE_ASSIGNMENT

type tagDVD_KaraokeAttributes
	bVersion as UBYTE
	fMasterOfCeremoniesInGuideVocal1 as WINBOOL
	fDuet as WINBOOL
	ChannelAssignment as DVD_KARAOKE_ASSIGNMENT
	wChannelContents(0 to 7) as WORD
end type

type DVD_KaraokeAttributes as tagDVD_KaraokeAttributes

type tagDVD_VIDEO_COMPRESSION as long
enum
	DVD_VideoCompression_Other = 0
	DVD_VideoCompression_MPEG1 = 1
	DVD_VideoCompression_MPEG2 = 2
end enum

type DVD_VIDEO_COMPRESSION as tagDVD_VIDEO_COMPRESSION

type tagDVD_VideoAttributes
	fPanscanPermitted as WINBOOL
	fLetterboxPermitted as WINBOOL
	ulAspectX as ULONG
	ulAspectY as ULONG
	ulFrameRate as ULONG
	ulFrameHeight as ULONG
	Compression as DVD_VIDEO_COMPRESSION
	fLine21Field1InGOP as WINBOOL
	fLine21Field2InGOP as WINBOOL
	ulSourceResolutionX as ULONG
	ulSourceResolutionY as ULONG
	fIsSourceLetterboxed as WINBOOL
	fIsFilmMode as WINBOOL
end type

type DVD_VideoAttributes as tagDVD_VideoAttributes

type tagDVD_SUBPICTURE_TYPE as long
enum
	DVD_SPType_NotSpecified = 0
	DVD_SPType_Language = 1
	DVD_SPType_Other = 2
end enum

type DVD_SUBPICTURE_TYPE as tagDVD_SUBPICTURE_TYPE

type tagDVD_SUBPICTURE_CODING as long
enum
	DVD_SPCoding_RunLength = 0
	DVD_SPCoding_Extended = 1
	DVD_SPCoding_Other = 2
end enum

type DVD_SUBPICTURE_CODING as tagDVD_SUBPICTURE_CODING

type tagDVD_SubpictureAttributes
	as DVD_SUBPICTURE_TYPE Type
	CodingMode as DVD_SUBPICTURE_CODING
	Language as LCID
	LanguageExtension as DVD_SUBPICTURE_LANG_EXT
end type

type DVD_SubpictureAttributes as tagDVD_SubpictureAttributes

type tagDVD_TITLE_APPMODE as long
enum
	DVD_AppMode_Not_Specified = 0
	DVD_AppMode_Karaoke = 1
	DVD_AppMode_Other = 3
end enum

type DVD_TITLE_APPMODE as tagDVD_TITLE_APPMODE

type tagDVD_TitleMainAttributes
	AppMode as DVD_TITLE_APPMODE
	VideoAttributes as DVD_VideoAttributes
	ulNumberOfAudioStreams as ULONG
	AudioAttributes(0 to 7) as DVD_AudioAttributes
	MultichannelAudioAttributes(0 to 7) as DVD_MultichannelAudioAttributes
	ulNumberOfSubpictureStreams as ULONG
	SubpictureAttributes(0 to 31) as DVD_SubpictureAttributes
end type

type DVD_TitleAttributes as tagDVD_TitleMainAttributes

type tagDVD_MenuAttributes
	fCompatibleRegion(0 to 7) as WINBOOL
	VideoAttributes as DVD_VideoAttributes
	fAudioPresent as WINBOOL
	AudioAttributes as DVD_AudioAttributes
	fSubpicturePresent as WINBOOL
	SubpictureAttributes as DVD_SubpictureAttributes
end type

type DVD_MenuAttributes as tagDVD_MenuAttributes

extern __MIDL_itf_strmif_0376_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0376_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IDvdControl_INTERFACE_DEFINED__

extern IID_IDvdControl as const IID

type IDvdControl as IDvdControl_

type IDvdControlVtbl
	QueryInterface as function(byval This as IDvdControl ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDvdControl ptr) as ULONG
	Release as function(byval This as IDvdControl ptr) as ULONG
	TitlePlay as function(byval This as IDvdControl ptr, byval ulTitle as ULONG) as HRESULT
	ChapterPlay as function(byval This as IDvdControl ptr, byval ulTitle as ULONG, byval ulChapter as ULONG) as HRESULT
	TimePlay as function(byval This as IDvdControl ptr, byval ulTitle as ULONG, byval bcdTime as ULONG) as HRESULT
	StopForResume as function(byval This as IDvdControl ptr) as HRESULT
	GoUp as function(byval This as IDvdControl ptr) as HRESULT
	TimeSearch as function(byval This as IDvdControl ptr, byval bcdTime as ULONG) as HRESULT
	ChapterSearch as function(byval This as IDvdControl ptr, byval ulChapter as ULONG) as HRESULT
	PrevPGSearch as function(byval This as IDvdControl ptr) as HRESULT
	TopPGSearch as function(byval This as IDvdControl ptr) as HRESULT
	NextPGSearch as function(byval This as IDvdControl ptr) as HRESULT
	ForwardScan as function(byval This as IDvdControl ptr, byval dwSpeed as double) as HRESULT
	BackwardScan as function(byval This as IDvdControl ptr, byval dwSpeed as double) as HRESULT
	MenuCall as function(byval This as IDvdControl ptr, byval MenuID as DVD_MENU_ID) as HRESULT
	Resume as function(byval This as IDvdControl ptr) as HRESULT
	UpperButtonSelect as function(byval This as IDvdControl ptr) as HRESULT
	LowerButtonSelect as function(byval This as IDvdControl ptr) as HRESULT
	LeftButtonSelect as function(byval This as IDvdControl ptr) as HRESULT
	RightButtonSelect as function(byval This as IDvdControl ptr) as HRESULT
	ButtonActivate as function(byval This as IDvdControl ptr) as HRESULT
	ButtonSelectAndActivate as function(byval This as IDvdControl ptr, byval ulButton as ULONG) as HRESULT
	StillOff as function(byval This as IDvdControl ptr) as HRESULT
	PauseOn as function(byval This as IDvdControl ptr) as HRESULT
	PauseOff as function(byval This as IDvdControl ptr) as HRESULT
	MenuLanguageSelect as function(byval This as IDvdControl ptr, byval Language as LCID) as HRESULT
	AudioStreamChange as function(byval This as IDvdControl ptr, byval ulAudio as ULONG) as HRESULT
	SubpictureStreamChange as function(byval This as IDvdControl ptr, byval ulSubPicture as ULONG, byval bDisplay as WINBOOL) as HRESULT
	AngleChange as function(byval This as IDvdControl ptr, byval ulAngle as ULONG) as HRESULT
	ParentalLevelSelect as function(byval This as IDvdControl ptr, byval ulParentalLevel as ULONG) as HRESULT
	ParentalCountrySelect as function(byval This as IDvdControl ptr, byval wCountry as WORD) as HRESULT
	KaraokeAudioPresentationModeChange as function(byval This as IDvdControl ptr, byval ulMode as ULONG) as HRESULT
	VideoModePreferrence as function(byval This as IDvdControl ptr, byval ulPreferredDisplayMode as ULONG) as HRESULT
	SetRoot as function(byval This as IDvdControl ptr, byval pszPath as LPCWSTR) as HRESULT
	MouseActivate as function(byval This as IDvdControl ptr, byval point as POINT) as HRESULT
	MouseSelect as function(byval This as IDvdControl ptr, byval point as POINT) as HRESULT
	ChapterPlayAutoStop as function(byval This as IDvdControl ptr, byval ulTitle as ULONG, byval ulChapter as ULONG, byval ulChaptersToPlay as ULONG) as HRESULT
end type

type IDvdControl_
	lpVtbl as IDvdControlVtbl ptr
end type

declare function IDvdControl_TitlePlay_Proxy(byval This as IDvdControl ptr, byval ulTitle as ULONG) as HRESULT
declare sub IDvdControl_TitlePlay_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_ChapterPlay_Proxy(byval This as IDvdControl ptr, byval ulTitle as ULONG, byval ulChapter as ULONG) as HRESULT
declare sub IDvdControl_ChapterPlay_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_TimePlay_Proxy(byval This as IDvdControl ptr, byval ulTitle as ULONG, byval bcdTime as ULONG) as HRESULT
declare sub IDvdControl_TimePlay_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_StopForResume_Proxy(byval This as IDvdControl ptr) as HRESULT
declare sub IDvdControl_StopForResume_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_GoUp_Proxy(byval This as IDvdControl ptr) as HRESULT
declare sub IDvdControl_GoUp_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_TimeSearch_Proxy(byval This as IDvdControl ptr, byval bcdTime as ULONG) as HRESULT
declare sub IDvdControl_TimeSearch_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_ChapterSearch_Proxy(byval This as IDvdControl ptr, byval ulChapter as ULONG) as HRESULT
declare sub IDvdControl_ChapterSearch_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_PrevPGSearch_Proxy(byval This as IDvdControl ptr) as HRESULT
declare sub IDvdControl_PrevPGSearch_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_TopPGSearch_Proxy(byval This as IDvdControl ptr) as HRESULT
declare sub IDvdControl_TopPGSearch_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_NextPGSearch_Proxy(byval This as IDvdControl ptr) as HRESULT
declare sub IDvdControl_NextPGSearch_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_ForwardScan_Proxy(byval This as IDvdControl ptr, byval dwSpeed as double) as HRESULT
declare sub IDvdControl_ForwardScan_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_BackwardScan_Proxy(byval This as IDvdControl ptr, byval dwSpeed as double) as HRESULT
declare sub IDvdControl_BackwardScan_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_MenuCall_Proxy(byval This as IDvdControl ptr, byval MenuID as DVD_MENU_ID) as HRESULT
declare sub IDvdControl_MenuCall_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_Resume_Proxy(byval This as IDvdControl ptr) as HRESULT
declare sub IDvdControl_Resume_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_UpperButtonSelect_Proxy(byval This as IDvdControl ptr) as HRESULT
declare sub IDvdControl_UpperButtonSelect_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_LowerButtonSelect_Proxy(byval This as IDvdControl ptr) as HRESULT
declare sub IDvdControl_LowerButtonSelect_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_LeftButtonSelect_Proxy(byval This as IDvdControl ptr) as HRESULT
declare sub IDvdControl_LeftButtonSelect_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_RightButtonSelect_Proxy(byval This as IDvdControl ptr) as HRESULT
declare sub IDvdControl_RightButtonSelect_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_ButtonActivate_Proxy(byval This as IDvdControl ptr) as HRESULT
declare sub IDvdControl_ButtonActivate_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_ButtonSelectAndActivate_Proxy(byval This as IDvdControl ptr, byval ulButton as ULONG) as HRESULT
declare sub IDvdControl_ButtonSelectAndActivate_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_StillOff_Proxy(byval This as IDvdControl ptr) as HRESULT
declare sub IDvdControl_StillOff_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_PauseOn_Proxy(byval This as IDvdControl ptr) as HRESULT
declare sub IDvdControl_PauseOn_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_PauseOff_Proxy(byval This as IDvdControl ptr) as HRESULT
declare sub IDvdControl_PauseOff_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_MenuLanguageSelect_Proxy(byval This as IDvdControl ptr, byval Language as LCID) as HRESULT
declare sub IDvdControl_MenuLanguageSelect_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_AudioStreamChange_Proxy(byval This as IDvdControl ptr, byval ulAudio as ULONG) as HRESULT
declare sub IDvdControl_AudioStreamChange_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_SubpictureStreamChange_Proxy(byval This as IDvdControl ptr, byval ulSubPicture as ULONG, byval bDisplay as WINBOOL) as HRESULT
declare sub IDvdControl_SubpictureStreamChange_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_AngleChange_Proxy(byval This as IDvdControl ptr, byval ulAngle as ULONG) as HRESULT
declare sub IDvdControl_AngleChange_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_ParentalLevelSelect_Proxy(byval This as IDvdControl ptr, byval ulParentalLevel as ULONG) as HRESULT
declare sub IDvdControl_ParentalLevelSelect_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_ParentalCountrySelect_Proxy(byval This as IDvdControl ptr, byval wCountry as WORD) as HRESULT
declare sub IDvdControl_ParentalCountrySelect_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_KaraokeAudioPresentationModeChange_Proxy(byval This as IDvdControl ptr, byval ulMode as ULONG) as HRESULT
declare sub IDvdControl_KaraokeAudioPresentationModeChange_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_VideoModePreferrence_Proxy(byval This as IDvdControl ptr, byval ulPreferredDisplayMode as ULONG) as HRESULT
declare sub IDvdControl_VideoModePreferrence_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_SetRoot_Proxy(byval This as IDvdControl ptr, byval pszPath as LPCWSTR) as HRESULT
declare sub IDvdControl_SetRoot_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_MouseActivate_Proxy(byval This as IDvdControl ptr, byval point as POINT) as HRESULT
declare sub IDvdControl_MouseActivate_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_MouseSelect_Proxy(byval This as IDvdControl ptr, byval point as POINT) as HRESULT
declare sub IDvdControl_MouseSelect_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_ChapterPlayAutoStop_Proxy(byval This as IDvdControl ptr, byval ulTitle as ULONG, byval ulChapter as ULONG, byval ulChaptersToPlay as ULONG) as HRESULT
declare sub IDvdControl_ChapterPlayAutoStop_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IDvdInfo_INTERFACE_DEFINED__

extern IID_IDvdInfo as const IID

type IDvdInfo as IDvdInfo_

type IDvdInfoVtbl
	QueryInterface as function(byval This as IDvdInfo ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDvdInfo ptr) as ULONG
	Release as function(byval This as IDvdInfo ptr) as ULONG
	GetCurrentDomain as function(byval This as IDvdInfo ptr, byval pDomain as DVD_DOMAIN ptr) as HRESULT
	GetCurrentLocation as function(byval This as IDvdInfo ptr, byval pLocation as DVD_PLAYBACK_LOCATION ptr) as HRESULT
	GetTotalTitleTime as function(byval This as IDvdInfo ptr, byval pulTotalTime as ULONG ptr) as HRESULT
	GetCurrentButton as function(byval This as IDvdInfo ptr, byval pulButtonsAvailable as ULONG ptr, byval pulCurrentButton as ULONG ptr) as HRESULT
	GetCurrentAngle as function(byval This as IDvdInfo ptr, byval pulAnglesAvailable as ULONG ptr, byval pulCurrentAngle as ULONG ptr) as HRESULT
	GetCurrentAudio as function(byval This as IDvdInfo ptr, byval pulStreamsAvailable as ULONG ptr, byval pulCurrentStream as ULONG ptr) as HRESULT
	GetCurrentSubpicture as function(byval This as IDvdInfo ptr, byval pulStreamsAvailable as ULONG ptr, byval pulCurrentStream as ULONG ptr, byval pIsDisabled as WINBOOL ptr) as HRESULT
	GetCurrentUOPS as function(byval This as IDvdInfo ptr, byval pUOP as VALID_UOP_SOMTHING_OR_OTHER ptr) as HRESULT
	GetAllSPRMs as function(byval This as IDvdInfo ptr, byval pRegisterArray as DVD_REGISTER ptr) as HRESULT
	GetAllGPRMs as function(byval This as IDvdInfo ptr, byval pRegisterArray as DVD_REGISTER ptr) as HRESULT
	GetAudioLanguage as function(byval This as IDvdInfo ptr, byval ulStream as ULONG, byval pLanguage as LCID ptr) as HRESULT
	GetSubpictureLanguage as function(byval This as IDvdInfo ptr, byval ulStream as ULONG, byval pLanguage as LCID ptr) as HRESULT
	GetTitleAttributes as function(byval This as IDvdInfo ptr, byval ulTitle as ULONG, byval pATR as DVD_ATR ptr) as HRESULT
	GetVMGAttributes as function(byval This as IDvdInfo ptr, byval pATR as DVD_ATR ptr) as HRESULT
	GetCurrentVideoAttributes as function(byval This as IDvdInfo ptr, byval pATR as UBYTE ptr) as HRESULT
	GetCurrentAudioAttributes as function(byval This as IDvdInfo ptr, byval pATR as UBYTE ptr) as HRESULT
	GetCurrentSubpictureAttributes as function(byval This as IDvdInfo ptr, byval pATR as UBYTE ptr) as HRESULT
	GetCurrentVolumeInfo as function(byval This as IDvdInfo ptr, byval pulNumOfVol as ULONG ptr, byval pulThisVolNum as ULONG ptr, byval pSide as DVD_DISC_SIDE ptr, byval pulNumOfTitles as ULONG ptr) as HRESULT
	GetDVDTextInfo as function(byval This as IDvdInfo ptr, byval pTextManager as UBYTE ptr, byval ulBufSize as ULONG, byval pulActualSize as ULONG ptr) as HRESULT
	GetPlayerParentalLevel as function(byval This as IDvdInfo ptr, byval pulParentalLevel as ULONG ptr, byval pulCountryCode as ULONG ptr) as HRESULT
	GetNumberOfChapters as function(byval This as IDvdInfo ptr, byval ulTitle as ULONG, byval pulNumberOfChapters as ULONG ptr) as HRESULT
	GetTitleParentalLevels as function(byval This as IDvdInfo ptr, byval ulTitle as ULONG, byval pulParentalLevels as ULONG ptr) as HRESULT
	GetRoot as function(byval This as IDvdInfo ptr, byval pRoot as LPSTR, byval ulBufSize as ULONG, byval pulActualSize as ULONG ptr) as HRESULT
end type

type IDvdInfo_
	lpVtbl as IDvdInfoVtbl ptr
end type

declare function IDvdInfo_GetCurrentDomain_Proxy(byval This as IDvdInfo ptr, byval pDomain as DVD_DOMAIN ptr) as HRESULT
declare sub IDvdInfo_GetCurrentDomain_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetCurrentLocation_Proxy(byval This as IDvdInfo ptr, byval pLocation as DVD_PLAYBACK_LOCATION ptr) as HRESULT
declare sub IDvdInfo_GetCurrentLocation_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetTotalTitleTime_Proxy(byval This as IDvdInfo ptr, byval pulTotalTime as ULONG ptr) as HRESULT
declare sub IDvdInfo_GetTotalTitleTime_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetCurrentButton_Proxy(byval This as IDvdInfo ptr, byval pulButtonsAvailable as ULONG ptr, byval pulCurrentButton as ULONG ptr) as HRESULT
declare sub IDvdInfo_GetCurrentButton_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetCurrentAngle_Proxy(byval This as IDvdInfo ptr, byval pulAnglesAvailable as ULONG ptr, byval pulCurrentAngle as ULONG ptr) as HRESULT
declare sub IDvdInfo_GetCurrentAngle_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetCurrentAudio_Proxy(byval This as IDvdInfo ptr, byval pulStreamsAvailable as ULONG ptr, byval pulCurrentStream as ULONG ptr) as HRESULT
declare sub IDvdInfo_GetCurrentAudio_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetCurrentSubpicture_Proxy(byval This as IDvdInfo ptr, byval pulStreamsAvailable as ULONG ptr, byval pulCurrentStream as ULONG ptr, byval pIsDisabled as WINBOOL ptr) as HRESULT
declare sub IDvdInfo_GetCurrentSubpicture_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetCurrentUOPS_Proxy(byval This as IDvdInfo ptr, byval pUOP as VALID_UOP_SOMTHING_OR_OTHER ptr) as HRESULT
declare sub IDvdInfo_GetCurrentUOPS_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetAllSPRMs_Proxy(byval This as IDvdInfo ptr, byval pRegisterArray as DVD_REGISTER ptr) as HRESULT
declare sub IDvdInfo_GetAllSPRMs_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetAllGPRMs_Proxy(byval This as IDvdInfo ptr, byval pRegisterArray as DVD_REGISTER ptr) as HRESULT
declare sub IDvdInfo_GetAllGPRMs_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetAudioLanguage_Proxy(byval This as IDvdInfo ptr, byval ulStream as ULONG, byval pLanguage as LCID ptr) as HRESULT
declare sub IDvdInfo_GetAudioLanguage_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetSubpictureLanguage_Proxy(byval This as IDvdInfo ptr, byval ulStream as ULONG, byval pLanguage as LCID ptr) as HRESULT
declare sub IDvdInfo_GetSubpictureLanguage_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetTitleAttributes_Proxy(byval This as IDvdInfo ptr, byval ulTitle as ULONG, byval pATR as DVD_ATR ptr) as HRESULT
declare sub IDvdInfo_GetTitleAttributes_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetVMGAttributes_Proxy(byval This as IDvdInfo ptr, byval pATR as DVD_ATR ptr) as HRESULT
declare sub IDvdInfo_GetVMGAttributes_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetCurrentVideoAttributes_Proxy(byval This as IDvdInfo ptr, byval pATR as UBYTE ptr) as HRESULT
declare sub IDvdInfo_GetCurrentVideoAttributes_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetCurrentAudioAttributes_Proxy(byval This as IDvdInfo ptr, byval pATR as UBYTE ptr) as HRESULT
declare sub IDvdInfo_GetCurrentAudioAttributes_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetCurrentSubpictureAttributes_Proxy(byval This as IDvdInfo ptr, byval pATR as UBYTE ptr) as HRESULT
declare sub IDvdInfo_GetCurrentSubpictureAttributes_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetCurrentVolumeInfo_Proxy(byval This as IDvdInfo ptr, byval pulNumOfVol as ULONG ptr, byval pulThisVolNum as ULONG ptr, byval pSide as DVD_DISC_SIDE ptr, byval pulNumOfTitles as ULONG ptr) as HRESULT
declare sub IDvdInfo_GetCurrentVolumeInfo_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetDVDTextInfo_Proxy(byval This as IDvdInfo ptr, byval pTextManager as UBYTE ptr, byval ulBufSize as ULONG, byval pulActualSize as ULONG ptr) as HRESULT
declare sub IDvdInfo_GetDVDTextInfo_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetPlayerParentalLevel_Proxy(byval This as IDvdInfo ptr, byval pulParentalLevel as ULONG ptr, byval pulCountryCode as ULONG ptr) as HRESULT
declare sub IDvdInfo_GetPlayerParentalLevel_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetNumberOfChapters_Proxy(byval This as IDvdInfo ptr, byval ulTitle as ULONG, byval pulNumberOfChapters as ULONG ptr) as HRESULT
declare sub IDvdInfo_GetNumberOfChapters_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetTitleParentalLevels_Proxy(byval This as IDvdInfo ptr, byval ulTitle as ULONG, byval pulParentalLevels as ULONG ptr) as HRESULT
declare sub IDvdInfo_GetTitleParentalLevels_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetRoot_Proxy(byval This as IDvdInfo ptr, byval pRoot as LPSTR, byval ulBufSize as ULONG, byval pulActualSize as ULONG ptr) as HRESULT
declare sub IDvdInfo_GetRoot_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IDvdCmd_INTERFACE_DEFINED__

extern IID_IDvdCmd as const IID

type IDvdCmd as IDvdCmd_

type IDvdCmdVtbl
	QueryInterface as function(byval This as IDvdCmd ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDvdCmd ptr) as ULONG
	Release as function(byval This as IDvdCmd ptr) as ULONG
	WaitForStart as function(byval This as IDvdCmd ptr) as HRESULT
	WaitForEnd as function(byval This as IDvdCmd ptr) as HRESULT
end type

type IDvdCmd_
	lpVtbl as IDvdCmdVtbl ptr
end type

declare function IDvdCmd_WaitForStart_Proxy(byval This as IDvdCmd ptr) as HRESULT
declare sub IDvdCmd_WaitForStart_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdCmd_WaitForEnd_Proxy(byval This as IDvdCmd ptr) as HRESULT
declare sub IDvdCmd_WaitForEnd_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IDvdState_INTERFACE_DEFINED__

extern IID_IDvdState as const IID

type IDvdState as IDvdState_

type IDvdStateVtbl
	QueryInterface as function(byval This as IDvdState ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDvdState ptr) as ULONG
	Release as function(byval This as IDvdState ptr) as ULONG
	GetDiscID as function(byval This as IDvdState ptr, byval pullUniqueID as ULONGLONG ptr) as HRESULT
	GetParentalLevel as function(byval This as IDvdState ptr, byval pulParentalLevel as ULONG ptr) as HRESULT
end type

type IDvdState_
	lpVtbl as IDvdStateVtbl ptr
end type

declare function IDvdState_GetDiscID_Proxy(byval This as IDvdState ptr, byval pullUniqueID as ULONGLONG ptr) as HRESULT
declare sub IDvdState_GetDiscID_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdState_GetParentalLevel_Proxy(byval This as IDvdState ptr, byval pulParentalLevel as ULONG ptr) as HRESULT
declare sub IDvdState_GetParentalLevel_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IDvdControl2_INTERFACE_DEFINED__

extern IID_IDvdControl2 as const IID

type IDvdControl2 as IDvdControl2_

type IDvdControl2Vtbl
	QueryInterface as function(byval This as IDvdControl2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDvdControl2 ptr) as ULONG
	Release as function(byval This as IDvdControl2 ptr) as ULONG
	PlayTitle as function(byval This as IDvdControl2 ptr, byval ulTitle as ULONG, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
	PlayChapterInTitle as function(byval This as IDvdControl2 ptr, byval ulTitle as ULONG, byval ulChapter as ULONG, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
	PlayAtTimeInTitle as function(byval This as IDvdControl2 ptr, byval ulTitle as ULONG, byval pStartTime as DVD_HMSF_TIMECODE ptr, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
	Stop as function(byval This as IDvdControl2 ptr) as HRESULT
	ReturnFromSubmenu as function(byval This as IDvdControl2 ptr, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
	PlayAtTime as function(byval This as IDvdControl2 ptr, byval pTime as DVD_HMSF_TIMECODE ptr, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
	PlayChapter as function(byval This as IDvdControl2 ptr, byval ulChapter as ULONG, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
	PlayPrevChapter as function(byval This as IDvdControl2 ptr, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
	ReplayChapter as function(byval This as IDvdControl2 ptr, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
	PlayNextChapter as function(byval This as IDvdControl2 ptr, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
	PlayForwards as function(byval This as IDvdControl2 ptr, byval dSpeed as double, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
	PlayBackwards as function(byval This as IDvdControl2 ptr, byval dSpeed as double, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
	ShowMenu as function(byval This as IDvdControl2 ptr, byval MenuID as DVD_MENU_ID, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
	Resume as function(byval This as IDvdControl2 ptr, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
	SelectRelativeButton as function(byval This as IDvdControl2 ptr, byval buttonDir as DVD_RELATIVE_BUTTON) as HRESULT
	ActivateButton as function(byval This as IDvdControl2 ptr) as HRESULT
	SelectButton as function(byval This as IDvdControl2 ptr, byval ulButton as ULONG) as HRESULT
	SelectAndActivateButton as function(byval This as IDvdControl2 ptr, byval ulButton as ULONG) as HRESULT
	StillOff as function(byval This as IDvdControl2 ptr) as HRESULT
	Pause as function(byval This as IDvdControl2 ptr, byval bState as WINBOOL) as HRESULT
	SelectAudioStream as function(byval This as IDvdControl2 ptr, byval ulAudio as ULONG, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
	SelectSubpictureStream as function(byval This as IDvdControl2 ptr, byval ulSubPicture as ULONG, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
	SetSubpictureState as function(byval This as IDvdControl2 ptr, byval bState as WINBOOL, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
	SelectAngle as function(byval This as IDvdControl2 ptr, byval ulAngle as ULONG, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
	SelectParentalLevel as function(byval This as IDvdControl2 ptr, byval ulParentalLevel as ULONG) as HRESULT
	SelectParentalCountry as function(byval This as IDvdControl2 ptr, byval bCountry as UBYTE ptr) as HRESULT
	SelectKaraokeAudioPresentationMode as function(byval This as IDvdControl2 ptr, byval ulMode as ULONG) as HRESULT
	SelectVideoModePreference as function(byval This as IDvdControl2 ptr, byval ulPreferredDisplayMode as ULONG) as HRESULT
	SetDVDDirectory as function(byval This as IDvdControl2 ptr, byval pszwPath as LPCWSTR) as HRESULT
	ActivateAtPosition as function(byval This as IDvdControl2 ptr, byval point as POINT) as HRESULT
	SelectAtPosition as function(byval This as IDvdControl2 ptr, byval point as POINT) as HRESULT
	PlayChaptersAutoStop as function(byval This as IDvdControl2 ptr, byval ulTitle as ULONG, byval ulChapter as ULONG, byval ulChaptersToPlay as ULONG, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
	AcceptParentalLevelChange as function(byval This as IDvdControl2 ptr, byval bAccept as WINBOOL) as HRESULT
	SetOption as function(byval This as IDvdControl2 ptr, byval flag as DVD_OPTION_FLAG, byval fState as WINBOOL) as HRESULT
	SetState as function(byval This as IDvdControl2 ptr, byval pState as IDvdState ptr, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
	PlayPeriodInTitleAutoStop as function(byval This as IDvdControl2 ptr, byval ulTitle as ULONG, byval pStartTime as DVD_HMSF_TIMECODE ptr, byval pEndTime as DVD_HMSF_TIMECODE ptr, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
	SetGPRM as function(byval This as IDvdControl2 ptr, byval ulIndex as ULONG, byval wValue as WORD, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
	SelectDefaultMenuLanguage as function(byval This as IDvdControl2 ptr, byval Language as LCID) as HRESULT
	SelectDefaultAudioLanguage as function(byval This as IDvdControl2 ptr, byval Language as LCID, byval audioExtension as DVD_AUDIO_LANG_EXT) as HRESULT
	SelectDefaultSubpictureLanguage as function(byval This as IDvdControl2 ptr, byval Language as LCID, byval subpictureExtension as DVD_SUBPICTURE_LANG_EXT) as HRESULT
end type

type IDvdControl2_
	lpVtbl as IDvdControl2Vtbl ptr
end type

declare function IDvdControl2_PlayTitle_Proxy(byval This as IDvdControl2 ptr, byval ulTitle as ULONG, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_PlayTitle_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_PlayChapterInTitle_Proxy(byval This as IDvdControl2 ptr, byval ulTitle as ULONG, byval ulChapter as ULONG, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_PlayChapterInTitle_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_PlayAtTimeInTitle_Proxy(byval This as IDvdControl2 ptr, byval ulTitle as ULONG, byval pStartTime as DVD_HMSF_TIMECODE ptr, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_PlayAtTimeInTitle_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_Stop_Proxy(byval This as IDvdControl2 ptr) as HRESULT
declare sub IDvdControl2_Stop_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_ReturnFromSubmenu_Proxy(byval This as IDvdControl2 ptr, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_ReturnFromSubmenu_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_PlayAtTime_Proxy(byval This as IDvdControl2 ptr, byval pTime as DVD_HMSF_TIMECODE ptr, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_PlayAtTime_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_PlayChapter_Proxy(byval This as IDvdControl2 ptr, byval ulChapter as ULONG, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_PlayChapter_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_PlayPrevChapter_Proxy(byval This as IDvdControl2 ptr, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_PlayPrevChapter_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_ReplayChapter_Proxy(byval This as IDvdControl2 ptr, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_ReplayChapter_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_PlayNextChapter_Proxy(byval This as IDvdControl2 ptr, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_PlayNextChapter_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_PlayForwards_Proxy(byval This as IDvdControl2 ptr, byval dSpeed as double, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_PlayForwards_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_PlayBackwards_Proxy(byval This as IDvdControl2 ptr, byval dSpeed as double, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_PlayBackwards_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_ShowMenu_Proxy(byval This as IDvdControl2 ptr, byval MenuID as DVD_MENU_ID, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_ShowMenu_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_Resume_Proxy(byval This as IDvdControl2 ptr, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_Resume_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SelectRelativeButton_Proxy(byval This as IDvdControl2 ptr, byval buttonDir as DVD_RELATIVE_BUTTON) as HRESULT
declare sub IDvdControl2_SelectRelativeButton_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_ActivateButton_Proxy(byval This as IDvdControl2 ptr) as HRESULT
declare sub IDvdControl2_ActivateButton_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SelectButton_Proxy(byval This as IDvdControl2 ptr, byval ulButton as ULONG) as HRESULT
declare sub IDvdControl2_SelectButton_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SelectAndActivateButton_Proxy(byval This as IDvdControl2 ptr, byval ulButton as ULONG) as HRESULT
declare sub IDvdControl2_SelectAndActivateButton_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_StillOff_Proxy(byval This as IDvdControl2 ptr) as HRESULT
declare sub IDvdControl2_StillOff_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_Pause_Proxy(byval This as IDvdControl2 ptr, byval bState as WINBOOL) as HRESULT
declare sub IDvdControl2_Pause_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SelectAudioStream_Proxy(byval This as IDvdControl2 ptr, byval ulAudio as ULONG, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_SelectAudioStream_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SelectSubpictureStream_Proxy(byval This as IDvdControl2 ptr, byval ulSubPicture as ULONG, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_SelectSubpictureStream_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SetSubpictureState_Proxy(byval This as IDvdControl2 ptr, byval bState as WINBOOL, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_SetSubpictureState_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SelectAngle_Proxy(byval This as IDvdControl2 ptr, byval ulAngle as ULONG, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_SelectAngle_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SelectParentalLevel_Proxy(byval This as IDvdControl2 ptr, byval ulParentalLevel as ULONG) as HRESULT
declare sub IDvdControl2_SelectParentalLevel_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SelectParentalCountry_Proxy(byval This as IDvdControl2 ptr, byval bCountry as UBYTE ptr) as HRESULT
declare sub IDvdControl2_SelectParentalCountry_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SelectKaraokeAudioPresentationMode_Proxy(byval This as IDvdControl2 ptr, byval ulMode as ULONG) as HRESULT
declare sub IDvdControl2_SelectKaraokeAudioPresentationMode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SelectVideoModePreference_Proxy(byval This as IDvdControl2 ptr, byval ulPreferredDisplayMode as ULONG) as HRESULT
declare sub IDvdControl2_SelectVideoModePreference_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SetDVDDirectory_Proxy(byval This as IDvdControl2 ptr, byval pszwPath as LPCWSTR) as HRESULT
declare sub IDvdControl2_SetDVDDirectory_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_ActivateAtPosition_Proxy(byval This as IDvdControl2 ptr, byval point as POINT) as HRESULT
declare sub IDvdControl2_ActivateAtPosition_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SelectAtPosition_Proxy(byval This as IDvdControl2 ptr, byval point as POINT) as HRESULT
declare sub IDvdControl2_SelectAtPosition_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_PlayChaptersAutoStop_Proxy(byval This as IDvdControl2 ptr, byval ulTitle as ULONG, byval ulChapter as ULONG, byval ulChaptersToPlay as ULONG, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_PlayChaptersAutoStop_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_AcceptParentalLevelChange_Proxy(byval This as IDvdControl2 ptr, byval bAccept as WINBOOL) as HRESULT
declare sub IDvdControl2_AcceptParentalLevelChange_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SetOption_Proxy(byval This as IDvdControl2 ptr, byval flag as DVD_OPTION_FLAG, byval fState as WINBOOL) as HRESULT
declare sub IDvdControl2_SetOption_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SetState_Proxy(byval This as IDvdControl2 ptr, byval pState as IDvdState ptr, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_SetState_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_PlayPeriodInTitleAutoStop_Proxy(byval This as IDvdControl2 ptr, byval ulTitle as ULONG, byval pStartTime as DVD_HMSF_TIMECODE ptr, byval pEndTime as DVD_HMSF_TIMECODE ptr, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_PlayPeriodInTitleAutoStop_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SetGPRM_Proxy(byval This as IDvdControl2 ptr, byval ulIndex as ULONG, byval wValue as WORD, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_SetGPRM_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SelectDefaultMenuLanguage_Proxy(byval This as IDvdControl2 ptr, byval Language as LCID) as HRESULT
declare sub IDvdControl2_SelectDefaultMenuLanguage_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SelectDefaultAudioLanguage_Proxy(byval This as IDvdControl2 ptr, byval Language as LCID, byval audioExtension as DVD_AUDIO_LANG_EXT) as HRESULT
declare sub IDvdControl2_SelectDefaultAudioLanguage_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SelectDefaultSubpictureLanguage_Proxy(byval This as IDvdControl2 ptr, byval Language as LCID, byval subpictureExtension as DVD_SUBPICTURE_LANG_EXT) as HRESULT
declare sub IDvdControl2_SelectDefaultSubpictureLanguage_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type DVD_TextStringType as long
enum
	DVD_Struct_Volume = &h1
	DVD_Struct_Title = &h2
	DVD_Struct_ParentalID = &h3
	DVD_Struct_PartOfTitle = &h4
	DVD_Struct_Cell = &h5
	DVD_Stream_Audio = &h10
	DVD_Stream_Subpicture = &h11
	DVD_Stream_Angle = &h12
	DVD_Channel_Audio = &h20
	DVD_General_Name = &h30
	DVD_General_Comments = &h31
	DVD_Title_Series = &h38
	DVD_Title_Movie = &h39
	DVD_Title_Video = &h3a
	DVD_Title_Album = &h3b
	DVD_Title_Song = &h3c
	DVD_Title_Other = &h3f
	DVD_Title_Sub_Series = &h40
	DVD_Title_Sub_Movie = &h41
	DVD_Title_Sub_Video = &h42
	DVD_Title_Sub_Album = &h43
	DVD_Title_Sub_Song = &h44
	DVD_Title_Sub_Other = &h47
	DVD_Title_Orig_Series = &h48
	DVD_Title_Orig_Movie = &h49
	DVD_Title_Orig_Video = &h4a
	DVD_Title_Orig_Album = &h4b
	DVD_Title_Orig_Song = &h4c
	DVD_Title_Orig_Other = &h4f
	DVD_Other_Scene = &h50
	DVD_Other_Cut = &h51
	DVD_Other_Take = &h52
end enum

type DVD_TextCharSet as long
enum
	DVD_CharSet_Unicode = 0
	DVD_CharSet_ISO646 = 1
	DVD_CharSet_JIS_Roman_Kanji = 2
	DVD_CharSet_ISO8859_1 = 3
	DVD_CharSet_ShiftJIS_Kanji_Roman_Katakana = 4
end enum

#define DVD_TITLE_MENU &h000
#define DVD_STREAM_DATA_CURRENT &h800
#define DVD_STREAM_DATA_VMGM &h400
#define DVD_STREAM_DATA_VTSM &h401
#define DVD_DEFAULT_AUDIO_STREAM &h0f

type tagDVD_DECODER_CAPS
	dwSize as DWORD
	dwAudioCaps as DWORD
	dFwdMaxRateVideo as double
	dFwdMaxRateAudio as double
	dFwdMaxRateSP as double
	dBwdMaxRateVideo as double
	dBwdMaxRateAudio as double
	dBwdMaxRateSP as double
	dwRes1 as DWORD
	dwRes2 as DWORD
	dwRes3 as DWORD
	dwRes4 as DWORD
end type

type DVD_DECODER_CAPS as tagDVD_DECODER_CAPS

#define DVD_AUDIO_CAPS_AC3 &h00000001
#define DVD_AUDIO_CAPS_MPEG2 &h00000002
#define DVD_AUDIO_CAPS_LPCM &h00000004
#define DVD_AUDIO_CAPS_DTS &h00000008
#define DVD_AUDIO_CAPS_SDDS &h00000010

extern __MIDL_itf_strmif_0387_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0387_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IDvdInfo2_INTERFACE_DEFINED__

extern IID_IDvdInfo2 as const IID

type IDvdInfo2 as IDvdInfo2_

type IDvdInfo2Vtbl
	QueryInterface as function(byval This as IDvdInfo2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDvdInfo2 ptr) as ULONG
	Release as function(byval This as IDvdInfo2 ptr) as ULONG
	GetCurrentDomain as function(byval This as IDvdInfo2 ptr, byval pDomain as DVD_DOMAIN ptr) as HRESULT
	GetCurrentLocation as function(byval This as IDvdInfo2 ptr, byval pLocation as DVD_PLAYBACK_LOCATION2 ptr) as HRESULT
	GetTotalTitleTime as function(byval This as IDvdInfo2 ptr, byval pTotalTime as DVD_HMSF_TIMECODE ptr, byval ulTimeCodeFlags as ULONG ptr) as HRESULT
	GetCurrentButton as function(byval This as IDvdInfo2 ptr, byval pulButtonsAvailable as ULONG ptr, byval pulCurrentButton as ULONG ptr) as HRESULT
	GetCurrentAngle as function(byval This as IDvdInfo2 ptr, byval pulAnglesAvailable as ULONG ptr, byval pulCurrentAngle as ULONG ptr) as HRESULT
	GetCurrentAudio as function(byval This as IDvdInfo2 ptr, byval pulStreamsAvailable as ULONG ptr, byval pulCurrentStream as ULONG ptr) as HRESULT
	GetCurrentSubpicture as function(byval This as IDvdInfo2 ptr, byval pulStreamsAvailable as ULONG ptr, byval pulCurrentStream as ULONG ptr, byval pbIsDisabled as WINBOOL ptr) as HRESULT
	GetCurrentUOPS as function(byval This as IDvdInfo2 ptr, byval pulUOPs as ULONG ptr) as HRESULT
	GetAllSPRMs as function(byval This as IDvdInfo2 ptr, byval pRegisterArray as DVD_REGISTER ptr) as HRESULT
	GetAllGPRMs as function(byval This as IDvdInfo2 ptr, byval pRegisterArray as DVD_REGISTER ptr) as HRESULT
	GetAudioLanguage as function(byval This as IDvdInfo2 ptr, byval ulStream as ULONG, byval pLanguage as LCID ptr) as HRESULT
	GetSubpictureLanguage as function(byval This as IDvdInfo2 ptr, byval ulStream as ULONG, byval pLanguage as LCID ptr) as HRESULT
	GetTitleAttributes as function(byval This as IDvdInfo2 ptr, byval ulTitle as ULONG, byval pMenu as DVD_MenuAttributes ptr, byval pTitle as DVD_TitleAttributes ptr) as HRESULT
	GetVMGAttributes as function(byval This as IDvdInfo2 ptr, byval pATR as DVD_MenuAttributes ptr) as HRESULT
	GetCurrentVideoAttributes as function(byval This as IDvdInfo2 ptr, byval pATR as DVD_VideoAttributes ptr) as HRESULT
	GetAudioAttributes as function(byval This as IDvdInfo2 ptr, byval ulStream as ULONG, byval pATR as DVD_AudioAttributes ptr) as HRESULT
	GetKaraokeAttributes as function(byval This as IDvdInfo2 ptr, byval ulStream as ULONG, byval pAttributes as DVD_KaraokeAttributes ptr) as HRESULT
	GetSubpictureAttributes as function(byval This as IDvdInfo2 ptr, byval ulStream as ULONG, byval pATR as DVD_SubpictureAttributes ptr) as HRESULT
	GetDVDVolumeInfo as function(byval This as IDvdInfo2 ptr, byval pulNumOfVolumes as ULONG ptr, byval pulVolume as ULONG ptr, byval pSide as DVD_DISC_SIDE ptr, byval pulNumOfTitles as ULONG ptr) as HRESULT
	GetDVDTextNumberOfLanguages as function(byval This as IDvdInfo2 ptr, byval pulNumOfLangs as ULONG ptr) as HRESULT
	GetDVDTextLanguageInfo as function(byval This as IDvdInfo2 ptr, byval ulLangIndex as ULONG, byval pulNumOfStrings as ULONG ptr, byval pLangCode as LCID ptr, byval pbCharacterSet as DVD_TextCharSet ptr) as HRESULT
	GetDVDTextStringAsNative as function(byval This as IDvdInfo2 ptr, byval ulLangIndex as ULONG, byval ulStringIndex as ULONG, byval pbBuffer as UBYTE ptr, byval ulMaxBufferSize as ULONG, byval pulActualSize as ULONG ptr, byval pType as DVD_TextStringType ptr) as HRESULT
	GetDVDTextStringAsUnicode as function(byval This as IDvdInfo2 ptr, byval ulLangIndex as ULONG, byval ulStringIndex as ULONG, byval pchwBuffer as wstring ptr, byval ulMaxBufferSize as ULONG, byval pulActualSize as ULONG ptr, byval pType as DVD_TextStringType ptr) as HRESULT
	GetPlayerParentalLevel as function(byval This as IDvdInfo2 ptr, byval pulParentalLevel as ULONG ptr, byval pbCountryCode as UBYTE ptr) as HRESULT
	GetNumberOfChapters as function(byval This as IDvdInfo2 ptr, byval ulTitle as ULONG, byval pulNumOfChapters as ULONG ptr) as HRESULT
	GetTitleParentalLevels as function(byval This as IDvdInfo2 ptr, byval ulTitle as ULONG, byval pulParentalLevels as ULONG ptr) as HRESULT
	GetDVDDirectory as function(byval This as IDvdInfo2 ptr, byval pszwPath as LPWSTR, byval ulMaxSize as ULONG, byval pulActualSize as ULONG ptr) as HRESULT
	IsAudioStreamEnabled as function(byval This as IDvdInfo2 ptr, byval ulStreamNum as ULONG, byval pbEnabled as WINBOOL ptr) as HRESULT
	GetDiscID as function(byval This as IDvdInfo2 ptr, byval pszwPath as LPCWSTR, byval pullDiscID as ULONGLONG ptr) as HRESULT
	GetState as function(byval This as IDvdInfo2 ptr, byval pStateData as IDvdState ptr ptr) as HRESULT
	GetMenuLanguages as function(byval This as IDvdInfo2 ptr, byval pLanguages as LCID ptr, byval ulMaxLanguages as ULONG, byval pulActualLanguages as ULONG ptr) as HRESULT
	GetButtonAtPosition as function(byval This as IDvdInfo2 ptr, byval point as POINT, byval pulButtonIndex as ULONG ptr) as HRESULT
	GetCmdFromEvent as function(byval This as IDvdInfo2 ptr, byval lParam1 as LONG_PTR, byval pCmdObj as IDvdCmd ptr ptr) as HRESULT
	GetDefaultMenuLanguage as function(byval This as IDvdInfo2 ptr, byval pLanguage as LCID ptr) as HRESULT
	GetDefaultAudioLanguage as function(byval This as IDvdInfo2 ptr, byval pLanguage as LCID ptr, byval pAudioExtension as DVD_AUDIO_LANG_EXT ptr) as HRESULT
	GetDefaultSubpictureLanguage as function(byval This as IDvdInfo2 ptr, byval pLanguage as LCID ptr, byval pSubpictureExtension as DVD_SUBPICTURE_LANG_EXT ptr) as HRESULT
	GetDecoderCaps as function(byval This as IDvdInfo2 ptr, byval pCaps as DVD_DECODER_CAPS ptr) as HRESULT
	GetButtonRect as function(byval This as IDvdInfo2 ptr, byval ulButton as ULONG, byval pRect as RECT ptr) as HRESULT
	IsSubpictureStreamEnabled as function(byval This as IDvdInfo2 ptr, byval ulStreamNum as ULONG, byval pbEnabled as WINBOOL ptr) as HRESULT
end type

type IDvdInfo2_
	lpVtbl as IDvdInfo2Vtbl ptr
end type

declare function IDvdInfo2_GetCurrentDomain_Proxy(byval This as IDvdInfo2 ptr, byval pDomain as DVD_DOMAIN ptr) as HRESULT
declare sub IDvdInfo2_GetCurrentDomain_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetCurrentLocation_Proxy(byval This as IDvdInfo2 ptr, byval pLocation as DVD_PLAYBACK_LOCATION2 ptr) as HRESULT
declare sub IDvdInfo2_GetCurrentLocation_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetTotalTitleTime_Proxy(byval This as IDvdInfo2 ptr, byval pTotalTime as DVD_HMSF_TIMECODE ptr, byval ulTimeCodeFlags as ULONG ptr) as HRESULT
declare sub IDvdInfo2_GetTotalTitleTime_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetCurrentButton_Proxy(byval This as IDvdInfo2 ptr, byval pulButtonsAvailable as ULONG ptr, byval pulCurrentButton as ULONG ptr) as HRESULT
declare sub IDvdInfo2_GetCurrentButton_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetCurrentAngle_Proxy(byval This as IDvdInfo2 ptr, byval pulAnglesAvailable as ULONG ptr, byval pulCurrentAngle as ULONG ptr) as HRESULT
declare sub IDvdInfo2_GetCurrentAngle_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetCurrentAudio_Proxy(byval This as IDvdInfo2 ptr, byval pulStreamsAvailable as ULONG ptr, byval pulCurrentStream as ULONG ptr) as HRESULT
declare sub IDvdInfo2_GetCurrentAudio_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetCurrentSubpicture_Proxy(byval This as IDvdInfo2 ptr, byval pulStreamsAvailable as ULONG ptr, byval pulCurrentStream as ULONG ptr, byval pbIsDisabled as WINBOOL ptr) as HRESULT
declare sub IDvdInfo2_GetCurrentSubpicture_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetCurrentUOPS_Proxy(byval This as IDvdInfo2 ptr, byval pulUOPs as ULONG ptr) as HRESULT
declare sub IDvdInfo2_GetCurrentUOPS_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetAllSPRMs_Proxy(byval This as IDvdInfo2 ptr, byval pRegisterArray as DVD_REGISTER ptr) as HRESULT
declare sub IDvdInfo2_GetAllSPRMs_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetAllGPRMs_Proxy(byval This as IDvdInfo2 ptr, byval pRegisterArray as DVD_REGISTER ptr) as HRESULT
declare sub IDvdInfo2_GetAllGPRMs_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetAudioLanguage_Proxy(byval This as IDvdInfo2 ptr, byval ulStream as ULONG, byval pLanguage as LCID ptr) as HRESULT
declare sub IDvdInfo2_GetAudioLanguage_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetSubpictureLanguage_Proxy(byval This as IDvdInfo2 ptr, byval ulStream as ULONG, byval pLanguage as LCID ptr) as HRESULT
declare sub IDvdInfo2_GetSubpictureLanguage_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetTitleAttributes_Proxy(byval This as IDvdInfo2 ptr, byval ulTitle as ULONG, byval pMenu as DVD_MenuAttributes ptr, byval pTitle as DVD_TitleAttributes ptr) as HRESULT
declare sub IDvdInfo2_GetTitleAttributes_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetVMGAttributes_Proxy(byval This as IDvdInfo2 ptr, byval pATR as DVD_MenuAttributes ptr) as HRESULT
declare sub IDvdInfo2_GetVMGAttributes_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetCurrentVideoAttributes_Proxy(byval This as IDvdInfo2 ptr, byval pATR as DVD_VideoAttributes ptr) as HRESULT
declare sub IDvdInfo2_GetCurrentVideoAttributes_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetAudioAttributes_Proxy(byval This as IDvdInfo2 ptr, byval ulStream as ULONG, byval pATR as DVD_AudioAttributes ptr) as HRESULT
declare sub IDvdInfo2_GetAudioAttributes_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetKaraokeAttributes_Proxy(byval This as IDvdInfo2 ptr, byval ulStream as ULONG, byval pAttributes as DVD_KaraokeAttributes ptr) as HRESULT
declare sub IDvdInfo2_GetKaraokeAttributes_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetSubpictureAttributes_Proxy(byval This as IDvdInfo2 ptr, byval ulStream as ULONG, byval pATR as DVD_SubpictureAttributes ptr) as HRESULT
declare sub IDvdInfo2_GetSubpictureAttributes_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetDVDVolumeInfo_Proxy(byval This as IDvdInfo2 ptr, byval pulNumOfVolumes as ULONG ptr, byval pulVolume as ULONG ptr, byval pSide as DVD_DISC_SIDE ptr, byval pulNumOfTitles as ULONG ptr) as HRESULT
declare sub IDvdInfo2_GetDVDVolumeInfo_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetDVDTextNumberOfLanguages_Proxy(byval This as IDvdInfo2 ptr, byval pulNumOfLangs as ULONG ptr) as HRESULT
declare sub IDvdInfo2_GetDVDTextNumberOfLanguages_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetDVDTextLanguageInfo_Proxy(byval This as IDvdInfo2 ptr, byval ulLangIndex as ULONG, byval pulNumOfStrings as ULONG ptr, byval pLangCode as LCID ptr, byval pbCharacterSet as DVD_TextCharSet ptr) as HRESULT
declare sub IDvdInfo2_GetDVDTextLanguageInfo_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetDVDTextStringAsNative_Proxy(byval This as IDvdInfo2 ptr, byval ulLangIndex as ULONG, byval ulStringIndex as ULONG, byval pbBuffer as UBYTE ptr, byval ulMaxBufferSize as ULONG, byval pulActualSize as ULONG ptr, byval pType as DVD_TextStringType ptr) as HRESULT
declare sub IDvdInfo2_GetDVDTextStringAsNative_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetDVDTextStringAsUnicode_Proxy(byval This as IDvdInfo2 ptr, byval ulLangIndex as ULONG, byval ulStringIndex as ULONG, byval pchwBuffer as wstring ptr, byval ulMaxBufferSize as ULONG, byval pulActualSize as ULONG ptr, byval pType as DVD_TextStringType ptr) as HRESULT
declare sub IDvdInfo2_GetDVDTextStringAsUnicode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetPlayerParentalLevel_Proxy(byval This as IDvdInfo2 ptr, byval pulParentalLevel as ULONG ptr, byval pbCountryCode as UBYTE ptr) as HRESULT
declare sub IDvdInfo2_GetPlayerParentalLevel_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetNumberOfChapters_Proxy(byval This as IDvdInfo2 ptr, byval ulTitle as ULONG, byval pulNumOfChapters as ULONG ptr) as HRESULT
declare sub IDvdInfo2_GetNumberOfChapters_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetTitleParentalLevels_Proxy(byval This as IDvdInfo2 ptr, byval ulTitle as ULONG, byval pulParentalLevels as ULONG ptr) as HRESULT
declare sub IDvdInfo2_GetTitleParentalLevels_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetDVDDirectory_Proxy(byval This as IDvdInfo2 ptr, byval pszwPath as LPWSTR, byval ulMaxSize as ULONG, byval pulActualSize as ULONG ptr) as HRESULT
declare sub IDvdInfo2_GetDVDDirectory_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_IsAudioStreamEnabled_Proxy(byval This as IDvdInfo2 ptr, byval ulStreamNum as ULONG, byval pbEnabled as WINBOOL ptr) as HRESULT
declare sub IDvdInfo2_IsAudioStreamEnabled_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetDiscID_Proxy(byval This as IDvdInfo2 ptr, byval pszwPath as LPCWSTR, byval pullDiscID as ULONGLONG ptr) as HRESULT
declare sub IDvdInfo2_GetDiscID_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetState_Proxy(byval This as IDvdInfo2 ptr, byval pStateData as IDvdState ptr ptr) as HRESULT
declare sub IDvdInfo2_GetState_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetMenuLanguages_Proxy(byval This as IDvdInfo2 ptr, byval pLanguages as LCID ptr, byval ulMaxLanguages as ULONG, byval pulActualLanguages as ULONG ptr) as HRESULT
declare sub IDvdInfo2_GetMenuLanguages_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetButtonAtPosition_Proxy(byval This as IDvdInfo2 ptr, byval point as POINT, byval pulButtonIndex as ULONG ptr) as HRESULT
declare sub IDvdInfo2_GetButtonAtPosition_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetCmdFromEvent_Proxy(byval This as IDvdInfo2 ptr, byval lParam1 as LONG_PTR, byval pCmdObj as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdInfo2_GetCmdFromEvent_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetDefaultMenuLanguage_Proxy(byval This as IDvdInfo2 ptr, byval pLanguage as LCID ptr) as HRESULT
declare sub IDvdInfo2_GetDefaultMenuLanguage_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetDefaultAudioLanguage_Proxy(byval This as IDvdInfo2 ptr, byval pLanguage as LCID ptr, byval pAudioExtension as DVD_AUDIO_LANG_EXT ptr) as HRESULT
declare sub IDvdInfo2_GetDefaultAudioLanguage_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetDefaultSubpictureLanguage_Proxy(byval This as IDvdInfo2 ptr, byval pLanguage as LCID ptr, byval pSubpictureExtension as DVD_SUBPICTURE_LANG_EXT ptr) as HRESULT
declare sub IDvdInfo2_GetDefaultSubpictureLanguage_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetDecoderCaps_Proxy(byval This as IDvdInfo2 ptr, byval pCaps as DVD_DECODER_CAPS ptr) as HRESULT
declare sub IDvdInfo2_GetDecoderCaps_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetButtonRect_Proxy(byval This as IDvdInfo2 ptr, byval ulButton as ULONG, byval pRect as RECT ptr) as HRESULT
declare sub IDvdInfo2_GetButtonRect_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_IsSubpictureStreamEnabled_Proxy(byval This as IDvdInfo2 ptr, byval ulStreamNum as ULONG, byval pbEnabled as WINBOOL ptr) as HRESULT
declare sub IDvdInfo2_IsSubpictureStreamEnabled_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type _AM_DVD_GRAPH_FLAGS as long
enum
	AM_DVD_HWDEC_PREFER = &h1
	AM_DVD_HWDEC_ONLY = &h2
	AM_DVD_SWDEC_PREFER = &h4
	AM_DVD_SWDEC_ONLY = &h8
	AM_DVD_NOVPE = &h100
	AM_DVD_VMR9_ONLY = &h800
end enum

type AM_DVD_GRAPH_FLAGS as _AM_DVD_GRAPH_FLAGS

type _AM_DVD_STREAM_FLAGS as long
enum
	AM_DVD_STREAM_VIDEO = &h1
	AM_DVD_STREAM_AUDIO = &h2
	AM_DVD_STREAM_SUBPIC = &h4
end enum

type AM_DVD_STREAM_FLAGS as _AM_DVD_STREAM_FLAGS

type __MIDL___MIDL_itf_strmif_0389_0001
	hrVPEStatus as HRESULT
	bDvdVolInvalid as WINBOOL
	bDvdVolUnknown as WINBOOL
	bNoLine21In as WINBOOL
	bNoLine21Out as WINBOOL
	iNumStreams as long
	iNumStreamsFailed as long
	dwFailedStreamsFlag as DWORD
end type

type AM_DVD_RENDERSTATUS as __MIDL___MIDL_itf_strmif_0389_0001

extern __MIDL_itf_strmif_0389_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0389_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IDvdGraphBuilder_INTERFACE_DEFINED__

extern IID_IDvdGraphBuilder as const IID

type IDvdGraphBuilder as IDvdGraphBuilder_

type IDvdGraphBuilderVtbl
	QueryInterface as function(byval This as IDvdGraphBuilder ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDvdGraphBuilder ptr) as ULONG
	Release as function(byval This as IDvdGraphBuilder ptr) as ULONG
	GetFiltergraph as function(byval This as IDvdGraphBuilder ptr, byval ppGB as IGraphBuilder ptr ptr) as HRESULT
	GetDvdInterface as function(byval This as IDvdGraphBuilder ptr, byval riid as const IID const ptr, byval ppvIF as any ptr ptr) as HRESULT
	RenderDvdVideoVolume as function(byval This as IDvdGraphBuilder ptr, byval lpcwszPathName as LPCWSTR, byval dwFlags as DWORD, byval pStatus as AM_DVD_RENDERSTATUS ptr) as HRESULT
end type

type IDvdGraphBuilder_
	lpVtbl as IDvdGraphBuilderVtbl ptr
end type

declare function IDvdGraphBuilder_GetFiltergraph_Proxy(byval This as IDvdGraphBuilder ptr, byval ppGB as IGraphBuilder ptr ptr) as HRESULT
declare sub IDvdGraphBuilder_GetFiltergraph_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdGraphBuilder_GetDvdInterface_Proxy(byval This as IDvdGraphBuilder ptr, byval riid as const IID const ptr, byval ppvIF as any ptr ptr) as HRESULT
declare sub IDvdGraphBuilder_GetDvdInterface_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdGraphBuilder_RenderDvdVideoVolume_Proxy(byval This as IDvdGraphBuilder ptr, byval lpcwszPathName as LPCWSTR, byval dwFlags as DWORD, byval pStatus as AM_DVD_RENDERSTATUS ptr) as HRESULT
declare sub IDvdGraphBuilder_RenderDvdVideoVolume_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IDDrawExclModeVideo_INTERFACE_DEFINED__

extern IID_IDDrawExclModeVideo as const IID

type IDDrawExclModeVideoCallback as IDDrawExclModeVideoCallback_
type IDDrawExclModeVideo as IDDrawExclModeVideo_

type IDDrawExclModeVideoVtbl
	QueryInterface as function(byval This as IDDrawExclModeVideo ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDDrawExclModeVideo ptr) as ULONG
	Release as function(byval This as IDDrawExclModeVideo ptr) as ULONG
	SetDDrawObject as function(byval This as IDDrawExclModeVideo ptr, byval pDDrawObject as IDirectDraw ptr) as HRESULT
	GetDDrawObject as function(byval This as IDDrawExclModeVideo ptr, byval ppDDrawObject as IDirectDraw ptr ptr, byval pbUsingExternal as WINBOOL ptr) as HRESULT
	SetDDrawSurface as function(byval This as IDDrawExclModeVideo ptr, byval pDDrawSurface as IDirectDrawSurface ptr) as HRESULT
	GetDDrawSurface as function(byval This as IDDrawExclModeVideo ptr, byval ppDDrawSurface as IDirectDrawSurface ptr ptr, byval pbUsingExternal as WINBOOL ptr) as HRESULT
	SetDrawParameters as function(byval This as IDDrawExclModeVideo ptr, byval prcSource as const RECT ptr, byval prcTarget as const RECT ptr) as HRESULT
	GetNativeVideoProps as function(byval This as IDDrawExclModeVideo ptr, byval pdwVideoWidth as DWORD ptr, byval pdwVideoHeight as DWORD ptr, byval pdwPictAspectRatioX as DWORD ptr, byval pdwPictAspectRatioY as DWORD ptr) as HRESULT
	SetCallbackInterface as function(byval This as IDDrawExclModeVideo ptr, byval pCallback as IDDrawExclModeVideoCallback ptr, byval dwFlags as DWORD) as HRESULT
end type

type IDDrawExclModeVideo_
	lpVtbl as IDDrawExclModeVideoVtbl ptr
end type

declare function IDDrawExclModeVideo_SetDDrawObject_Proxy(byval This as IDDrawExclModeVideo ptr, byval pDDrawObject as IDirectDraw ptr) as HRESULT
declare sub IDDrawExclModeVideo_SetDDrawObject_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDDrawExclModeVideo_GetDDrawObject_Proxy(byval This as IDDrawExclModeVideo ptr, byval ppDDrawObject as IDirectDraw ptr ptr, byval pbUsingExternal as WINBOOL ptr) as HRESULT
declare sub IDDrawExclModeVideo_GetDDrawObject_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDDrawExclModeVideo_SetDDrawSurface_Proxy(byval This as IDDrawExclModeVideo ptr, byval pDDrawSurface as IDirectDrawSurface ptr) as HRESULT
declare sub IDDrawExclModeVideo_SetDDrawSurface_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDDrawExclModeVideo_GetDDrawSurface_Proxy(byval This as IDDrawExclModeVideo ptr, byval ppDDrawSurface as IDirectDrawSurface ptr ptr, byval pbUsingExternal as WINBOOL ptr) as HRESULT
declare sub IDDrawExclModeVideo_GetDDrawSurface_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDDrawExclModeVideo_SetDrawParameters_Proxy(byval This as IDDrawExclModeVideo ptr, byval prcSource as const RECT ptr, byval prcTarget as const RECT ptr) as HRESULT
declare sub IDDrawExclModeVideo_SetDrawParameters_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDDrawExclModeVideo_GetNativeVideoProps_Proxy(byval This as IDDrawExclModeVideo ptr, byval pdwVideoWidth as DWORD ptr, byval pdwVideoHeight as DWORD ptr, byval pdwPictAspectRatioX as DWORD ptr, byval pdwPictAspectRatioY as DWORD ptr) as HRESULT
declare sub IDDrawExclModeVideo_GetNativeVideoProps_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDDrawExclModeVideo_SetCallbackInterface_Proxy(byval This as IDDrawExclModeVideo ptr, byval pCallback as IDDrawExclModeVideoCallback ptr, byval dwFlags as DWORD) as HRESULT
declare sub IDDrawExclModeVideo_SetCallbackInterface_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type _AM_OVERLAY_NOTIFY_FLAGS as long
enum
	AM_OVERLAY_NOTIFY_VISIBLE_CHANGE = &h1
	AM_OVERLAY_NOTIFY_SOURCE_CHANGE = &h2
	AM_OVERLAY_NOTIFY_DEST_CHANGE = &h4
end enum

extern __MIDL_itf_strmif_0391_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0391_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IDDrawExclModeVideoCallback_INTERFACE_DEFINED__

extern IID_IDDrawExclModeVideoCallback as const IID

type IDDrawExclModeVideoCallbackVtbl
	QueryInterface as function(byval This as IDDrawExclModeVideoCallback ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDDrawExclModeVideoCallback ptr) as ULONG
	Release as function(byval This as IDDrawExclModeVideoCallback ptr) as ULONG
	OnUpdateOverlay as function(byval This as IDDrawExclModeVideoCallback ptr, byval bBefore as WINBOOL, byval dwFlags as DWORD, byval bOldVisible as WINBOOL, byval prcOldSrc as const RECT ptr, byval prcOldDest as const RECT ptr, byval bNewVisible as WINBOOL, byval prcNewSrc as const RECT ptr, byval prcNewDest as const RECT ptr) as HRESULT
	OnUpdateColorKey as function(byval This as IDDrawExclModeVideoCallback ptr, byval pKey as const COLORKEY ptr, byval dwColor as DWORD) as HRESULT
	OnUpdateSize as function(byval This as IDDrawExclModeVideoCallback ptr, byval dwWidth as DWORD, byval dwHeight as DWORD, byval dwARWidth as DWORD, byval dwARHeight as DWORD) as HRESULT
end type

type IDDrawExclModeVideoCallback_
	lpVtbl as IDDrawExclModeVideoCallbackVtbl ptr
end type

declare function IDDrawExclModeVideoCallback_OnUpdateOverlay_Proxy(byval This as IDDrawExclModeVideoCallback ptr, byval bBefore as WINBOOL, byval dwFlags as DWORD, byval bOldVisible as WINBOOL, byval prcOldSrc as const RECT ptr, byval prcOldDest as const RECT ptr, byval bNewVisible as WINBOOL, byval prcNewSrc as const RECT ptr, byval prcNewDest as const RECT ptr) as HRESULT
declare sub IDDrawExclModeVideoCallback_OnUpdateOverlay_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDDrawExclModeVideoCallback_OnUpdateColorKey_Proxy(byval This as IDDrawExclModeVideoCallback ptr, byval pKey as const COLORKEY ptr, byval dwColor as DWORD) as HRESULT
declare sub IDDrawExclModeVideoCallback_OnUpdateColorKey_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDDrawExclModeVideoCallback_OnUpdateSize_Proxy(byval This as IDDrawExclModeVideoCallback ptr, byval dwWidth as DWORD, byval dwHeight as DWORD, byval dwARWidth as DWORD, byval dwARHeight as DWORD) as HRESULT
declare sub IDDrawExclModeVideoCallback_OnUpdateSize_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

extern __MIDL_itf_strmif_0392_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0392_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IPinConnection_INTERFACE_DEFINED__

extern IID_IPinConnection as const IID

type IPinConnection as IPinConnection_

type IPinConnectionVtbl
	QueryInterface as function(byval This as IPinConnection ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPinConnection ptr) as ULONG
	Release as function(byval This as IPinConnection ptr) as ULONG
	DynamicQueryAccept as function(byval This as IPinConnection ptr, byval pmt as const AM_MEDIA_TYPE ptr) as HRESULT
	NotifyEndOfStream as function(byval This as IPinConnection ptr, byval hNotifyEvent as HANDLE) as HRESULT
	IsEndPin as function(byval This as IPinConnection ptr) as HRESULT
	DynamicDisconnect as function(byval This as IPinConnection ptr) as HRESULT
end type

type IPinConnection_
	lpVtbl as IPinConnectionVtbl ptr
end type

declare function IPinConnection_DynamicQueryAccept_Proxy(byval This as IPinConnection ptr, byval pmt as const AM_MEDIA_TYPE ptr) as HRESULT
declare sub IPinConnection_DynamicQueryAccept_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPinConnection_NotifyEndOfStream_Proxy(byval This as IPinConnection ptr, byval hNotifyEvent as HANDLE) as HRESULT
declare sub IPinConnection_NotifyEndOfStream_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPinConnection_IsEndPin_Proxy(byval This as IPinConnection ptr) as HRESULT
declare sub IPinConnection_IsEndPin_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPinConnection_DynamicDisconnect_Proxy(byval This as IPinConnection ptr) as HRESULT
declare sub IPinConnection_DynamicDisconnect_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IPinFlowControl_INTERFACE_DEFINED__

extern IID_IPinFlowControl as const IID

type IPinFlowControl as IPinFlowControl_

type IPinFlowControlVtbl
	QueryInterface as function(byval This as IPinFlowControl ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPinFlowControl ptr) as ULONG
	Release as function(byval This as IPinFlowControl ptr) as ULONG
	Block as function(byval This as IPinFlowControl ptr, byval dwBlockFlags as DWORD, byval hEvent as HANDLE) as HRESULT
end type

type IPinFlowControl_
	lpVtbl as IPinFlowControlVtbl ptr
end type

declare function IPinFlowControl_Block_Proxy(byval This as IPinFlowControl ptr, byval dwBlockFlags as DWORD, byval hEvent as HANDLE) as HRESULT
declare sub IPinFlowControl_Block_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type _AM_PIN_FLOW_CONTROL_BLOCK_FLAGS as long
enum
	AM_PIN_FLOW_CONTROL_BLOCK = &h1
end enum

type _AM_GRAPH_CONFIG_RECONNECT_FLAGS as long
enum
	AM_GRAPH_CONFIG_RECONNECT_DIRECTCONNECT = &h1
	AM_GRAPH_CONFIG_RECONNECT_CACHE_REMOVED_FILTERS = &h2
	AM_GRAPH_CONFIG_RECONNECT_USE_ONLY_CACHED_FILTERS = &h4
end enum

type AM_GRAPH_CONFIG_RECONNECT_FLAGS as _AM_GRAPH_CONFIG_RECONNECT_FLAGS

type _REM_FILTER_FLAGS as long
enum
	REMFILTERF_LEAVECONNECTED = &h1
end enum

type _AM_FILTER_FLAGS as long
enum
	AM_FILTER_FLAGS_REMOVABLE = &h1
end enum

type AM_FILTER_FLAGS as _AM_FILTER_FLAGS

extern __MIDL_itf_strmif_0394_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0394_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IGraphConfig_INTERFACE_DEFINED__

extern IID_IGraphConfig as const IID

type IGraphConfigCallback as IGraphConfigCallback_
type IGraphConfig as IGraphConfig_

type IGraphConfigVtbl
	QueryInterface as function(byval This as IGraphConfig ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IGraphConfig ptr) as ULONG
	Release as function(byval This as IGraphConfig ptr) as ULONG
	Reconnect as function(byval This as IGraphConfig ptr, byval pOutputPin as IPin ptr, byval pInputPin as IPin ptr, byval pmtFirstConnection as const AM_MEDIA_TYPE ptr, byval pUsingFilter as IBaseFilter ptr, byval hAbortEvent as HANDLE, byval dwFlags as DWORD) as HRESULT
	Reconfigure as function(byval This as IGraphConfig ptr, byval pCallback as IGraphConfigCallback ptr, byval pvContext as PVOID, byval dwFlags as DWORD, byval hAbortEvent as HANDLE) as HRESULT
	AddFilterToCache as function(byval This as IGraphConfig ptr, byval pFilter as IBaseFilter ptr) as HRESULT
	EnumCacheFilter as function(byval This as IGraphConfig ptr, byval pEnum as IEnumFilters ptr ptr) as HRESULT
	RemoveFilterFromCache as function(byval This as IGraphConfig ptr, byval pFilter as IBaseFilter ptr) as HRESULT
	GetStartTime as function(byval This as IGraphConfig ptr, byval prtStart as REFERENCE_TIME ptr) as HRESULT
	PushThroughData as function(byval This as IGraphConfig ptr, byval pOutputPin as IPin ptr, byval pConnection as IPinConnection ptr, byval hEventAbort as HANDLE) as HRESULT
	SetFilterFlags as function(byval This as IGraphConfig ptr, byval pFilter as IBaseFilter ptr, byval dwFlags as DWORD) as HRESULT
	GetFilterFlags as function(byval This as IGraphConfig ptr, byval pFilter as IBaseFilter ptr, byval pdwFlags as DWORD ptr) as HRESULT
	RemoveFilterEx as function(byval This as IGraphConfig ptr, byval pFilter as IBaseFilter ptr, byval Flags as DWORD) as HRESULT
end type

type IGraphConfig_
	lpVtbl as IGraphConfigVtbl ptr
end type

declare function IGraphConfig_Reconnect_Proxy(byval This as IGraphConfig ptr, byval pOutputPin as IPin ptr, byval pInputPin as IPin ptr, byval pmtFirstConnection as const AM_MEDIA_TYPE ptr, byval pUsingFilter as IBaseFilter ptr, byval hAbortEvent as HANDLE, byval dwFlags as DWORD) as HRESULT
declare sub IGraphConfig_Reconnect_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IGraphConfig_Reconfigure_Proxy(byval This as IGraphConfig ptr, byval pCallback as IGraphConfigCallback ptr, byval pvContext as PVOID, byval dwFlags as DWORD, byval hAbortEvent as HANDLE) as HRESULT
declare sub IGraphConfig_Reconfigure_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IGraphConfig_AddFilterToCache_Proxy(byval This as IGraphConfig ptr, byval pFilter as IBaseFilter ptr) as HRESULT
declare sub IGraphConfig_AddFilterToCache_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IGraphConfig_EnumCacheFilter_Proxy(byval This as IGraphConfig ptr, byval pEnum as IEnumFilters ptr ptr) as HRESULT
declare sub IGraphConfig_EnumCacheFilter_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IGraphConfig_RemoveFilterFromCache_Proxy(byval This as IGraphConfig ptr, byval pFilter as IBaseFilter ptr) as HRESULT
declare sub IGraphConfig_RemoveFilterFromCache_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IGraphConfig_GetStartTime_Proxy(byval This as IGraphConfig ptr, byval prtStart as REFERENCE_TIME ptr) as HRESULT
declare sub IGraphConfig_GetStartTime_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IGraphConfig_PushThroughData_Proxy(byval This as IGraphConfig ptr, byval pOutputPin as IPin ptr, byval pConnection as IPinConnection ptr, byval hEventAbort as HANDLE) as HRESULT
declare sub IGraphConfig_PushThroughData_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IGraphConfig_SetFilterFlags_Proxy(byval This as IGraphConfig ptr, byval pFilter as IBaseFilter ptr, byval dwFlags as DWORD) as HRESULT
declare sub IGraphConfig_SetFilterFlags_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IGraphConfig_GetFilterFlags_Proxy(byval This as IGraphConfig ptr, byval pFilter as IBaseFilter ptr, byval pdwFlags as DWORD ptr) as HRESULT
declare sub IGraphConfig_GetFilterFlags_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IGraphConfig_RemoveFilterEx_Proxy(byval This as IGraphConfig ptr, byval pFilter as IBaseFilter ptr, byval Flags as DWORD) as HRESULT
declare sub IGraphConfig_RemoveFilterEx_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IGraphConfigCallback_INTERFACE_DEFINED__

extern IID_IGraphConfigCallback as const IID

type IGraphConfigCallbackVtbl
	QueryInterface as function(byval This as IGraphConfigCallback ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IGraphConfigCallback ptr) as ULONG
	Release as function(byval This as IGraphConfigCallback ptr) as ULONG
	Reconfigure as function(byval This as IGraphConfigCallback ptr, byval pvContext as PVOID, byval dwFlags as DWORD) as HRESULT
end type

type IGraphConfigCallback_
	lpVtbl as IGraphConfigCallbackVtbl ptr
end type

declare function IGraphConfigCallback_Reconfigure_Proxy(byval This as IGraphConfigCallback ptr, byval pvContext as PVOID, byval dwFlags as DWORD) as HRESULT
declare sub IGraphConfigCallback_Reconfigure_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IFilterChain_INTERFACE_DEFINED__

extern IID_IFilterChain as const IID

type IFilterChain as IFilterChain_

type IFilterChainVtbl
	QueryInterface as function(byval This as IFilterChain ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IFilterChain ptr) as ULONG
	Release as function(byval This as IFilterChain ptr) as ULONG
	StartChain as function(byval This as IFilterChain ptr, byval pStartFilter as IBaseFilter ptr, byval pEndFilter as IBaseFilter ptr) as HRESULT
	PauseChain as function(byval This as IFilterChain ptr, byval pStartFilter as IBaseFilter ptr, byval pEndFilter as IBaseFilter ptr) as HRESULT
	StopChain as function(byval This as IFilterChain ptr, byval pStartFilter as IBaseFilter ptr, byval pEndFilter as IBaseFilter ptr) as HRESULT
	RemoveChain as function(byval This as IFilterChain ptr, byval pStartFilter as IBaseFilter ptr, byval pEndFilter as IBaseFilter ptr) as HRESULT
end type

type IFilterChain_
	lpVtbl as IFilterChainVtbl ptr
end type

declare function IFilterChain_StartChain_Proxy(byval This as IFilterChain ptr, byval pStartFilter as IBaseFilter ptr, byval pEndFilter as IBaseFilter ptr) as HRESULT
declare sub IFilterChain_StartChain_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFilterChain_PauseChain_Proxy(byval This as IFilterChain ptr, byval pStartFilter as IBaseFilter ptr, byval pEndFilter as IBaseFilter ptr) as HRESULT
declare sub IFilterChain_PauseChain_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFilterChain_StopChain_Proxy(byval This as IFilterChain ptr, byval pStartFilter as IBaseFilter ptr, byval pEndFilter as IBaseFilter ptr) as HRESULT
declare sub IFilterChain_StopChain_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFilterChain_RemoveChain_Proxy(byval This as IFilterChain ptr, byval pStartFilter as IBaseFilter ptr, byval pEndFilter as IBaseFilter ptr) as HRESULT
declare sub IFilterChain_RemoveChain_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type __MIDL___MIDL_itf_strmif_0397_0002 as long
enum
	VMRSample_SyncPoint = &h1
	VMRSample_Preroll = &h2
	VMRSample_Discontinuity = &h4
	VMRSample_TimeValid = &h8
	VMRSample_SrcDstRectsValid = &h10
end enum

type VMRPresentationFlags as __MIDL___MIDL_itf_strmif_0397_0002

type tagVMRPRESENTATIONINFO
	dwFlags as DWORD
	lpSurf as LPDIRECTDRAWSURFACE7
	rtStart as REFERENCE_TIME
	rtEnd as REFERENCE_TIME
	szAspectRatio as SIZE
	rcSrc as RECT
	rcDst as RECT
	dwTypeSpecificFlags as DWORD
	dwInterlaceFlags as DWORD
end type

type VMRPRESENTATIONINFO as tagVMRPRESENTATIONINFO

extern __MIDL_itf_strmif_0397_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0397_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IVMRImagePresenter_INTERFACE_DEFINED__

extern IID_IVMRImagePresenter as const IID

type IVMRImagePresenter as IVMRImagePresenter_

type IVMRImagePresenterVtbl
	QueryInterface as function(byval This as IVMRImagePresenter ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IVMRImagePresenter ptr) as ULONG
	Release as function(byval This as IVMRImagePresenter ptr) as ULONG
	StartPresenting as function(byval This as IVMRImagePresenter ptr, byval dwUserID as DWORD_PTR) as HRESULT
	StopPresenting as function(byval This as IVMRImagePresenter ptr, byval dwUserID as DWORD_PTR) as HRESULT
	PresentImage as function(byval This as IVMRImagePresenter ptr, byval dwUserID as DWORD_PTR, byval lpPresInfo as VMRPRESENTATIONINFO ptr) as HRESULT
end type

type IVMRImagePresenter_
	lpVtbl as IVMRImagePresenterVtbl ptr
end type

declare function IVMRImagePresenter_StartPresenting_Proxy(byval This as IVMRImagePresenter ptr, byval dwUserID as DWORD_PTR) as HRESULT
declare sub IVMRImagePresenter_StartPresenting_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRImagePresenter_StopPresenting_Proxy(byval This as IVMRImagePresenter ptr, byval dwUserID as DWORD_PTR) as HRESULT
declare sub IVMRImagePresenter_StopPresenting_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRImagePresenter_PresentImage_Proxy(byval This as IVMRImagePresenter ptr, byval dwUserID as DWORD_PTR, byval lpPresInfo as VMRPRESENTATIONINFO ptr) as HRESULT
declare sub IVMRImagePresenter_PresentImage_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type __MIDL___MIDL_itf_strmif_0398_0001 as long
enum
	AMAP_PIXELFORMAT_VALID = &h1
	AMAP_3D_TARGET = &h2
	AMAP_ALLOW_SYSMEM = &h4
	AMAP_FORCE_SYSMEM = &h8
	AMAP_DIRECTED_FLIP = &h10
	AMAP_DXVA_TARGET = &h20
end enum

type VMRSurfaceAllocationFlags as __MIDL___MIDL_itf_strmif_0398_0001

type tagVMRALLOCATIONINFO
	dwFlags as DWORD
	lpHdr as LPBITMAPINFOHEADER
	lpPixFmt as LPDDPIXELFORMAT
	szAspectRatio as SIZE
	dwMinBuffers as DWORD
	dwMaxBuffers as DWORD
	dwInterlaceFlags as DWORD
	szNativeSize as SIZE
end type

type VMRALLOCATIONINFO as tagVMRALLOCATIONINFO

extern __MIDL_itf_strmif_0398_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0398_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IVMRSurfaceAllocator_INTERFACE_DEFINED__

extern IID_IVMRSurfaceAllocator as const IID

type IVMRSurfaceAllocatorNotify as IVMRSurfaceAllocatorNotify_
type IVMRSurfaceAllocator as IVMRSurfaceAllocator_

type IVMRSurfaceAllocatorVtbl
	QueryInterface as function(byval This as IVMRSurfaceAllocator ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IVMRSurfaceAllocator ptr) as ULONG
	Release as function(byval This as IVMRSurfaceAllocator ptr) as ULONG
	AllocateSurface as function(byval This as IVMRSurfaceAllocator ptr, byval dwUserID as DWORD_PTR, byval lpAllocInfo as VMRALLOCATIONINFO ptr, byval lpdwActualBuffers as DWORD ptr, byval lplpSurface as LPDIRECTDRAWSURFACE7 ptr) as HRESULT
	FreeSurface as function(byval This as IVMRSurfaceAllocator ptr, byval dwID as DWORD_PTR) as HRESULT
	PrepareSurface as function(byval This as IVMRSurfaceAllocator ptr, byval dwUserID as DWORD_PTR, byval lpSurface as LPDIRECTDRAWSURFACE7, byval dwSurfaceFlags as DWORD) as HRESULT
	AdviseNotify as function(byval This as IVMRSurfaceAllocator ptr, byval lpIVMRSurfAllocNotify as IVMRSurfaceAllocatorNotify ptr) as HRESULT
end type

type IVMRSurfaceAllocator_
	lpVtbl as IVMRSurfaceAllocatorVtbl ptr
end type

declare function IVMRSurfaceAllocator_AllocateSurface_Proxy(byval This as IVMRSurfaceAllocator ptr, byval dwUserID as DWORD_PTR, byval lpAllocInfo as VMRALLOCATIONINFO ptr, byval lpdwActualBuffers as DWORD ptr, byval lplpSurface as LPDIRECTDRAWSURFACE7 ptr) as HRESULT
declare sub IVMRSurfaceAllocator_AllocateSurface_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRSurfaceAllocator_FreeSurface_Proxy(byval This as IVMRSurfaceAllocator ptr, byval dwID as DWORD_PTR) as HRESULT
declare sub IVMRSurfaceAllocator_FreeSurface_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRSurfaceAllocator_PrepareSurface_Proxy(byval This as IVMRSurfaceAllocator ptr, byval dwUserID as DWORD_PTR, byval lpSurface as LPDIRECTDRAWSURFACE7, byval dwSurfaceFlags as DWORD) as HRESULT
declare sub IVMRSurfaceAllocator_PrepareSurface_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRSurfaceAllocator_AdviseNotify_Proxy(byval This as IVMRSurfaceAllocator ptr, byval lpIVMRSurfAllocNotify as IVMRSurfaceAllocatorNotify ptr) as HRESULT
declare sub IVMRSurfaceAllocator_AdviseNotify_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IVMRSurfaceAllocatorNotify_INTERFACE_DEFINED__

extern IID_IVMRSurfaceAllocatorNotify as const IID

type IVMRSurfaceAllocatorNotifyVtbl
	QueryInterface as function(byval This as IVMRSurfaceAllocatorNotify ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IVMRSurfaceAllocatorNotify ptr) as ULONG
	Release as function(byval This as IVMRSurfaceAllocatorNotify ptr) as ULONG
	AdviseSurfaceAllocator as function(byval This as IVMRSurfaceAllocatorNotify ptr, byval dwUserID as DWORD_PTR, byval lpIVRMSurfaceAllocator as IVMRSurfaceAllocator ptr) as HRESULT
	SetDDrawDevice as function(byval This as IVMRSurfaceAllocatorNotify ptr, byval lpDDrawDevice as LPDIRECTDRAW7, byval hMonitor as HMONITOR) as HRESULT
	ChangeDDrawDevice as function(byval This as IVMRSurfaceAllocatorNotify ptr, byval lpDDrawDevice as LPDIRECTDRAW7, byval hMonitor as HMONITOR) as HRESULT
	RestoreDDrawSurfaces as function(byval This as IVMRSurfaceAllocatorNotify ptr) as HRESULT
	NotifyEvent as function(byval This as IVMRSurfaceAllocatorNotify ptr, byval EventCode as LONG, byval Param1 as LONG_PTR, byval Param2 as LONG_PTR) as HRESULT
	SetBorderColor as function(byval This as IVMRSurfaceAllocatorNotify ptr, byval clrBorder as COLORREF) as HRESULT
end type

type IVMRSurfaceAllocatorNotify_
	lpVtbl as IVMRSurfaceAllocatorNotifyVtbl ptr
end type

declare function IVMRSurfaceAllocatorNotify_AdviseSurfaceAllocator_Proxy(byval This as IVMRSurfaceAllocatorNotify ptr, byval dwUserID as DWORD_PTR, byval lpIVRMSurfaceAllocator as IVMRSurfaceAllocator ptr) as HRESULT
declare sub IVMRSurfaceAllocatorNotify_AdviseSurfaceAllocator_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRSurfaceAllocatorNotify_SetDDrawDevice_Proxy(byval This as IVMRSurfaceAllocatorNotify ptr, byval lpDDrawDevice as LPDIRECTDRAW7, byval hMonitor as HMONITOR) as HRESULT
declare sub IVMRSurfaceAllocatorNotify_SetDDrawDevice_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRSurfaceAllocatorNotify_ChangeDDrawDevice_Proxy(byval This as IVMRSurfaceAllocatorNotify ptr, byval lpDDrawDevice as LPDIRECTDRAW7, byval hMonitor as HMONITOR) as HRESULT
declare sub IVMRSurfaceAllocatorNotify_ChangeDDrawDevice_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRSurfaceAllocatorNotify_RestoreDDrawSurfaces_Proxy(byval This as IVMRSurfaceAllocatorNotify ptr) as HRESULT
declare sub IVMRSurfaceAllocatorNotify_RestoreDDrawSurfaces_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRSurfaceAllocatorNotify_NotifyEvent_Proxy(byval This as IVMRSurfaceAllocatorNotify ptr, byval EventCode as LONG, byval Param1 as LONG_PTR, byval Param2 as LONG_PTR) as HRESULT
declare sub IVMRSurfaceAllocatorNotify_NotifyEvent_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRSurfaceAllocatorNotify_SetBorderColor_Proxy(byval This as IVMRSurfaceAllocatorNotify ptr, byval clrBorder as COLORREF) as HRESULT
declare sub IVMRSurfaceAllocatorNotify_SetBorderColor_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type __MIDL___MIDL_itf_strmif_0400_0001 as long
enum
	VMR_ARMODE_NONE = 0
	VMR_ARMODE_LETTER_BOX = VMR_ARMODE_NONE + 1
end enum

type VMR_ASPECT_RATIO_MODE as __MIDL___MIDL_itf_strmif_0400_0001

extern __MIDL_itf_strmif_0400_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0400_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IVMRWindowlessControl_INTERFACE_DEFINED__

extern IID_IVMRWindowlessControl as const IID

type IVMRWindowlessControl as IVMRWindowlessControl_

type IVMRWindowlessControlVtbl
	QueryInterface as function(byval This as IVMRWindowlessControl ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IVMRWindowlessControl ptr) as ULONG
	Release as function(byval This as IVMRWindowlessControl ptr) as ULONG
	GetNativeVideoSize as function(byval This as IVMRWindowlessControl ptr, byval lpWidth as LONG ptr, byval lpHeight as LONG ptr, byval lpARWidth as LONG ptr, byval lpARHeight as LONG ptr) as HRESULT
	GetMinIdealVideoSize as function(byval This as IVMRWindowlessControl ptr, byval lpWidth as LONG ptr, byval lpHeight as LONG ptr) as HRESULT
	GetMaxIdealVideoSize as function(byval This as IVMRWindowlessControl ptr, byval lpWidth as LONG ptr, byval lpHeight as LONG ptr) as HRESULT
	SetVideoPosition as function(byval This as IVMRWindowlessControl ptr, byval lpSRCRect as const LPRECT, byval lpDSTRect as const LPRECT) as HRESULT
	GetVideoPosition as function(byval This as IVMRWindowlessControl ptr, byval lpSRCRect as LPRECT, byval lpDSTRect as LPRECT) as HRESULT
	GetAspectRatioMode as function(byval This as IVMRWindowlessControl ptr, byval lpAspectRatioMode as DWORD ptr) as HRESULT
	SetAspectRatioMode as function(byval This as IVMRWindowlessControl ptr, byval AspectRatioMode as DWORD) as HRESULT
	SetVideoClippingWindow as function(byval This as IVMRWindowlessControl ptr, byval hwnd as HWND) as HRESULT
	RepaintVideo as function(byval This as IVMRWindowlessControl ptr, byval hwnd as HWND, byval hdc as HDC) as HRESULT
	DisplayModeChanged as function(byval This as IVMRWindowlessControl ptr) as HRESULT
	GetCurrentImage as function(byval This as IVMRWindowlessControl ptr, byval lpDib as UBYTE ptr ptr) as HRESULT
	SetBorderColor as function(byval This as IVMRWindowlessControl ptr, byval Clr as COLORREF) as HRESULT
	GetBorderColor as function(byval This as IVMRWindowlessControl ptr, byval lpClr as COLORREF ptr) as HRESULT
	SetColorKey as function(byval This as IVMRWindowlessControl ptr, byval Clr as COLORREF) as HRESULT
	GetColorKey as function(byval This as IVMRWindowlessControl ptr, byval lpClr as COLORREF ptr) as HRESULT
end type

type IVMRWindowlessControl_
	lpVtbl as IVMRWindowlessControlVtbl ptr
end type

declare function IVMRWindowlessControl_GetNativeVideoSize_Proxy(byval This as IVMRWindowlessControl ptr, byval lpWidth as LONG ptr, byval lpHeight as LONG ptr, byval lpARWidth as LONG ptr, byval lpARHeight as LONG ptr) as HRESULT
declare sub IVMRWindowlessControl_GetNativeVideoSize_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRWindowlessControl_GetMinIdealVideoSize_Proxy(byval This as IVMRWindowlessControl ptr, byval lpWidth as LONG ptr, byval lpHeight as LONG ptr) as HRESULT
declare sub IVMRWindowlessControl_GetMinIdealVideoSize_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRWindowlessControl_GetMaxIdealVideoSize_Proxy(byval This as IVMRWindowlessControl ptr, byval lpWidth as LONG ptr, byval lpHeight as LONG ptr) as HRESULT
declare sub IVMRWindowlessControl_GetMaxIdealVideoSize_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRWindowlessControl_SetVideoPosition_Proxy(byval This as IVMRWindowlessControl ptr, byval lpSRCRect as const LPRECT, byval lpDSTRect as const LPRECT) as HRESULT
declare sub IVMRWindowlessControl_SetVideoPosition_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRWindowlessControl_GetVideoPosition_Proxy(byval This as IVMRWindowlessControl ptr, byval lpSRCRect as LPRECT, byval lpDSTRect as LPRECT) as HRESULT
declare sub IVMRWindowlessControl_GetVideoPosition_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRWindowlessControl_GetAspectRatioMode_Proxy(byval This as IVMRWindowlessControl ptr, byval lpAspectRatioMode as DWORD ptr) as HRESULT
declare sub IVMRWindowlessControl_GetAspectRatioMode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRWindowlessControl_SetAspectRatioMode_Proxy(byval This as IVMRWindowlessControl ptr, byval AspectRatioMode as DWORD) as HRESULT
declare sub IVMRWindowlessControl_SetAspectRatioMode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRWindowlessControl_SetVideoClippingWindow_Proxy(byval This as IVMRWindowlessControl ptr, byval hwnd as HWND) as HRESULT
declare sub IVMRWindowlessControl_SetVideoClippingWindow_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRWindowlessControl_RepaintVideo_Proxy(byval This as IVMRWindowlessControl ptr, byval hwnd as HWND, byval hdc as HDC) as HRESULT
declare sub IVMRWindowlessControl_RepaintVideo_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRWindowlessControl_DisplayModeChanged_Proxy(byval This as IVMRWindowlessControl ptr) as HRESULT
declare sub IVMRWindowlessControl_DisplayModeChanged_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRWindowlessControl_GetCurrentImage_Proxy(byval This as IVMRWindowlessControl ptr, byval lpDib as UBYTE ptr ptr) as HRESULT
declare sub IVMRWindowlessControl_GetCurrentImage_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRWindowlessControl_SetBorderColor_Proxy(byval This as IVMRWindowlessControl ptr, byval Clr as COLORREF) as HRESULT
declare sub IVMRWindowlessControl_SetBorderColor_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRWindowlessControl_GetBorderColor_Proxy(byval This as IVMRWindowlessControl ptr, byval lpClr as COLORREF ptr) as HRESULT
declare sub IVMRWindowlessControl_GetBorderColor_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRWindowlessControl_SetColorKey_Proxy(byval This as IVMRWindowlessControl ptr, byval Clr as COLORREF) as HRESULT
declare sub IVMRWindowlessControl_SetColorKey_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRWindowlessControl_GetColorKey_Proxy(byval This as IVMRWindowlessControl ptr, byval lpClr as COLORREF ptr) as HRESULT
declare sub IVMRWindowlessControl_GetColorKey_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type __MIDL___MIDL_itf_strmif_0401_0001 as long
enum
	MixerPref_NoDecimation = &h1
	MixerPref_DecimateOutput = &h2
	MixerPref_ARAdjustXorY = &h4
	MixerPref_DecimationReserved = &h8
	MixerPref_DecimateMask = &hf
	MixerPref_BiLinearFiltering = &h10
	MixerPref_PointFiltering = &h20
	MixerPref_FilteringMask = &hf0
	MixerPref_RenderTargetRGB = &h100
	MixerPref_RenderTargetYUV = &h1000
	MixerPref_RenderTargetYUV420 = &h200
	MixerPref_RenderTargetYUV422 = &h400
	MixerPref_RenderTargetYUV444 = &h800
	MixerPref_RenderTargetReserved = &he000
	MixerPref_RenderTargetMask = &hff00
	MixerPref_DynamicSwitchToBOB = &h10000
	MixerPref_DynamicDecimateBy2 = &h20000
	MixerPref_DynamicReserved = &hc0000
	MixerPref_DynamicMask = &hf0000
end enum

type VMRMixerPrefs as __MIDL___MIDL_itf_strmif_0401_0001

type _NORMALIZEDRECT
	left as single
	top as single
	right as single
	bottom as single
end type

type NORMALIZEDRECT as _NORMALIZEDRECT
type PNORMALIZEDRECT as _NORMALIZEDRECT ptr

extern __MIDL_itf_strmif_0401_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0401_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IVMRMixerControl_INTERFACE_DEFINED__

extern IID_IVMRMixerControl as const IID

type IVMRMixerControl as IVMRMixerControl_

type IVMRMixerControlVtbl
	QueryInterface as function(byval This as IVMRMixerControl ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IVMRMixerControl ptr) as ULONG
	Release as function(byval This as IVMRMixerControl ptr) as ULONG
	SetAlpha as function(byval This as IVMRMixerControl ptr, byval dwStreamID as DWORD, byval Alpha as single) as HRESULT
	GetAlpha as function(byval This as IVMRMixerControl ptr, byval dwStreamID as DWORD, byval pAlpha as single ptr) as HRESULT
	SetZOrder as function(byval This as IVMRMixerControl ptr, byval dwStreamID as DWORD, byval dwZ as DWORD) as HRESULT
	GetZOrder as function(byval This as IVMRMixerControl ptr, byval dwStreamID as DWORD, byval pZ as DWORD ptr) as HRESULT
	SetOutputRect as function(byval This as IVMRMixerControl ptr, byval dwStreamID as DWORD, byval pRect as const NORMALIZEDRECT ptr) as HRESULT
	GetOutputRect as function(byval This as IVMRMixerControl ptr, byval dwStreamID as DWORD, byval pRect as NORMALIZEDRECT ptr) as HRESULT
	SetBackgroundClr as function(byval This as IVMRMixerControl ptr, byval ClrBkg as COLORREF) as HRESULT
	GetBackgroundClr as function(byval This as IVMRMixerControl ptr, byval lpClrBkg as COLORREF ptr) as HRESULT
	SetMixingPrefs as function(byval This as IVMRMixerControl ptr, byval dwMixerPrefs as DWORD) as HRESULT
	GetMixingPrefs as function(byval This as IVMRMixerControl ptr, byval pdwMixerPrefs as DWORD ptr) as HRESULT
end type

type IVMRMixerControl_
	lpVtbl as IVMRMixerControlVtbl ptr
end type

declare function IVMRMixerControl_SetAlpha_Proxy(byval This as IVMRMixerControl ptr, byval dwStreamID as DWORD, byval Alpha as single) as HRESULT
declare sub IVMRMixerControl_SetAlpha_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRMixerControl_GetAlpha_Proxy(byval This as IVMRMixerControl ptr, byval dwStreamID as DWORD, byval pAlpha as single ptr) as HRESULT
declare sub IVMRMixerControl_GetAlpha_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRMixerControl_SetZOrder_Proxy(byval This as IVMRMixerControl ptr, byval dwStreamID as DWORD, byval dwZ as DWORD) as HRESULT
declare sub IVMRMixerControl_SetZOrder_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRMixerControl_GetZOrder_Proxy(byval This as IVMRMixerControl ptr, byval dwStreamID as DWORD, byval pZ as DWORD ptr) as HRESULT
declare sub IVMRMixerControl_GetZOrder_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRMixerControl_SetOutputRect_Proxy(byval This as IVMRMixerControl ptr, byval dwStreamID as DWORD, byval pRect as const NORMALIZEDRECT ptr) as HRESULT
declare sub IVMRMixerControl_SetOutputRect_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRMixerControl_GetOutputRect_Proxy(byval This as IVMRMixerControl ptr, byval dwStreamID as DWORD, byval pRect as NORMALIZEDRECT ptr) as HRESULT
declare sub IVMRMixerControl_GetOutputRect_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRMixerControl_SetBackgroundClr_Proxy(byval This as IVMRMixerControl ptr, byval ClrBkg as COLORREF) as HRESULT
declare sub IVMRMixerControl_SetBackgroundClr_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRMixerControl_GetBackgroundClr_Proxy(byval This as IVMRMixerControl ptr, byval lpClrBkg as COLORREF ptr) as HRESULT
declare sub IVMRMixerControl_GetBackgroundClr_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRMixerControl_SetMixingPrefs_Proxy(byval This as IVMRMixerControl ptr, byval dwMixerPrefs as DWORD) as HRESULT
declare sub IVMRMixerControl_SetMixingPrefs_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRMixerControl_GetMixingPrefs_Proxy(byval This as IVMRMixerControl ptr, byval pdwMixerPrefs as DWORD ptr) as HRESULT
declare sub IVMRMixerControl_GetMixingPrefs_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type tagVMRGUID
	pGUID as GUID ptr
	GUID as GUID
end type

type VMRGUID as tagVMRGUID

type tagVMRMONITORINFO
	guid as VMRGUID
	rcMonitor as RECT
	hMon as HMONITOR
	dwFlags as DWORD
	szDevice as wstring * 32
	szDescription as wstring * 256
	liDriverVersion as LARGE_INTEGER
	dwVendorId as DWORD
	dwDeviceId as DWORD
	dwSubSysId as DWORD
	dwRevision as DWORD
end type

type VMRMONITORINFO as tagVMRMONITORINFO

extern __MIDL_itf_strmif_0402_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0402_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IVMRMonitorConfig_INTERFACE_DEFINED__

extern IID_IVMRMonitorConfig as const IID

type IVMRMonitorConfig as IVMRMonitorConfig_

type IVMRMonitorConfigVtbl
	QueryInterface as function(byval This as IVMRMonitorConfig ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IVMRMonitorConfig ptr) as ULONG
	Release as function(byval This as IVMRMonitorConfig ptr) as ULONG
	SetMonitor as function(byval This as IVMRMonitorConfig ptr, byval pGUID as const VMRGUID ptr) as HRESULT
	GetMonitor as function(byval This as IVMRMonitorConfig ptr, byval pGUID as VMRGUID ptr) as HRESULT
	SetDefaultMonitor as function(byval This as IVMRMonitorConfig ptr, byval pGUID as const VMRGUID ptr) as HRESULT
	GetDefaultMonitor as function(byval This as IVMRMonitorConfig ptr, byval pGUID as VMRGUID ptr) as HRESULT
	GetAvailableMonitors as function(byval This as IVMRMonitorConfig ptr, byval pInfo as VMRMONITORINFO ptr, byval dwMaxInfoArraySize as DWORD, byval pdwNumDevices as DWORD ptr) as HRESULT
end type

type IVMRMonitorConfig_
	lpVtbl as IVMRMonitorConfigVtbl ptr
end type

declare function IVMRMonitorConfig_SetMonitor_Proxy(byval This as IVMRMonitorConfig ptr, byval pGUID as const VMRGUID ptr) as HRESULT
declare sub IVMRMonitorConfig_SetMonitor_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRMonitorConfig_GetMonitor_Proxy(byval This as IVMRMonitorConfig ptr, byval pGUID as VMRGUID ptr) as HRESULT
declare sub IVMRMonitorConfig_GetMonitor_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRMonitorConfig_SetDefaultMonitor_Proxy(byval This as IVMRMonitorConfig ptr, byval pGUID as const VMRGUID ptr) as HRESULT
declare sub IVMRMonitorConfig_SetDefaultMonitor_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRMonitorConfig_GetDefaultMonitor_Proxy(byval This as IVMRMonitorConfig ptr, byval pGUID as VMRGUID ptr) as HRESULT
declare sub IVMRMonitorConfig_GetDefaultMonitor_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRMonitorConfig_GetAvailableMonitors_Proxy(byval This as IVMRMonitorConfig ptr, byval pInfo as VMRMONITORINFO ptr, byval dwMaxInfoArraySize as DWORD, byval pdwNumDevices as DWORD ptr) as HRESULT
declare sub IVMRMonitorConfig_GetAvailableMonitors_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type __MIDL___MIDL_itf_strmif_0403_0001 as long
enum
	RenderPrefs_RestrictToInitialMonitor = 0
	RenderPrefs_ForceOffscreen = &h1
	RenderPrefs_ForceOverlays = &h2
	RenderPrefs_AllowOverlays = 0
	RenderPrefs_AllowOffscreen = 0
	RenderPrefs_DoNotRenderColorKeyAndBorder = &h8
	RenderPrefs_Reserved = &h10
	RenderPrefs_PreferAGPMemWhenMixing = &h20
	RenderPrefs_Mask = &h3f
end enum

type VMRRenderPrefs as __MIDL___MIDL_itf_strmif_0403_0001

type __MIDL___MIDL_itf_strmif_0403_0002 as long
enum
	VMRMode_Windowed = &h1
	VMRMode_Windowless = &h2
	VMRMode_Renderless = &h4
	VMRMode_Mask = &h7
end enum

type VMRMode as __MIDL___MIDL_itf_strmif_0403_0002

type __MIDL___MIDL_itf_strmif_0403_0003 as long
enum
	MAX_NUMBER_OF_STREAMS = 16
end enum

extern __MIDL_itf_strmif_0403_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0403_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IVMRFilterConfig_INTERFACE_DEFINED__

extern IID_IVMRFilterConfig as const IID

type IVMRImageCompositor as IVMRImageCompositor_
type IVMRFilterConfig as IVMRFilterConfig_

type IVMRFilterConfigVtbl
	QueryInterface as function(byval This as IVMRFilterConfig ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IVMRFilterConfig ptr) as ULONG
	Release as function(byval This as IVMRFilterConfig ptr) as ULONG
	SetImageCompositor as function(byval This as IVMRFilterConfig ptr, byval lpVMRImgCompositor as IVMRImageCompositor ptr) as HRESULT
	SetNumberOfStreams as function(byval This as IVMRFilterConfig ptr, byval dwMaxStreams as DWORD) as HRESULT
	GetNumberOfStreams as function(byval This as IVMRFilterConfig ptr, byval pdwMaxStreams as DWORD ptr) as HRESULT
	SetRenderingPrefs as function(byval This as IVMRFilterConfig ptr, byval dwRenderFlags as DWORD) as HRESULT
	GetRenderingPrefs as function(byval This as IVMRFilterConfig ptr, byval pdwRenderFlags as DWORD ptr) as HRESULT
	SetRenderingMode as function(byval This as IVMRFilterConfig ptr, byval Mode as DWORD) as HRESULT
	GetRenderingMode as function(byval This as IVMRFilterConfig ptr, byval pMode as DWORD ptr) as HRESULT
end type

type IVMRFilterConfig_
	lpVtbl as IVMRFilterConfigVtbl ptr
end type

declare function IVMRFilterConfig_SetImageCompositor_Proxy(byval This as IVMRFilterConfig ptr, byval lpVMRImgCompositor as IVMRImageCompositor ptr) as HRESULT
declare sub IVMRFilterConfig_SetImageCompositor_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRFilterConfig_SetNumberOfStreams_Proxy(byval This as IVMRFilterConfig ptr, byval dwMaxStreams as DWORD) as HRESULT
declare sub IVMRFilterConfig_SetNumberOfStreams_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRFilterConfig_GetNumberOfStreams_Proxy(byval This as IVMRFilterConfig ptr, byval pdwMaxStreams as DWORD ptr) as HRESULT
declare sub IVMRFilterConfig_GetNumberOfStreams_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRFilterConfig_SetRenderingPrefs_Proxy(byval This as IVMRFilterConfig ptr, byval dwRenderFlags as DWORD) as HRESULT
declare sub IVMRFilterConfig_SetRenderingPrefs_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRFilterConfig_GetRenderingPrefs_Proxy(byval This as IVMRFilterConfig ptr, byval pdwRenderFlags as DWORD ptr) as HRESULT
declare sub IVMRFilterConfig_GetRenderingPrefs_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRFilterConfig_SetRenderingMode_Proxy(byval This as IVMRFilterConfig ptr, byval Mode as DWORD) as HRESULT
declare sub IVMRFilterConfig_SetRenderingMode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRFilterConfig_GetRenderingMode_Proxy(byval This as IVMRFilterConfig ptr, byval pMode as DWORD ptr) as HRESULT
declare sub IVMRFilterConfig_GetRenderingMode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IVMRAspectRatioControl_INTERFACE_DEFINED__

extern IID_IVMRAspectRatioControl as const IID

type IVMRAspectRatioControl as IVMRAspectRatioControl_

type IVMRAspectRatioControlVtbl
	QueryInterface as function(byval This as IVMRAspectRatioControl ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IVMRAspectRatioControl ptr) as ULONG
	Release as function(byval This as IVMRAspectRatioControl ptr) as ULONG
	GetAspectRatioMode as function(byval This as IVMRAspectRatioControl ptr, byval lpdwARMode as LPDWORD) as HRESULT
	SetAspectRatioMode as function(byval This as IVMRAspectRatioControl ptr, byval dwARMode as DWORD) as HRESULT
end type

type IVMRAspectRatioControl_
	lpVtbl as IVMRAspectRatioControlVtbl ptr
end type

declare function IVMRAspectRatioControl_GetAspectRatioMode_Proxy(byval This as IVMRAspectRatioControl ptr, byval lpdwARMode as LPDWORD) as HRESULT
declare sub IVMRAspectRatioControl_GetAspectRatioMode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRAspectRatioControl_SetAspectRatioMode_Proxy(byval This as IVMRAspectRatioControl ptr, byval dwARMode as DWORD) as HRESULT
declare sub IVMRAspectRatioControl_SetAspectRatioMode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type __MIDL___MIDL_itf_strmif_0405_0001 as long
enum
	DeinterlacePref_NextBest = &h1
	DeinterlacePref_BOB = &h2
	DeinterlacePref_Weave = &h4
	DeinterlacePref_Mask = &h7
end enum

type VMRDeinterlacePrefs as __MIDL___MIDL_itf_strmif_0405_0001

type __MIDL___MIDL_itf_strmif_0405_0002 as long
enum
	DeinterlaceTech_Unknown = 0
	DeinterlaceTech_BOBLineReplicate = &h1
	DeinterlaceTech_BOBVerticalStretch = &h2
	DeinterlaceTech_MedianFiltering = &h4
	DeinterlaceTech_EdgeFiltering = &h10
	DeinterlaceTech_FieldAdaptive = &h20
	DeinterlaceTech_PixelAdaptive = &h40
	DeinterlaceTech_MotionVectorSteered = &h80
end enum

type VMRDeinterlaceTech as __MIDL___MIDL_itf_strmif_0405_0002

type _VMRFrequency
	dwNumerator as DWORD
	dwDenominator as DWORD
end type

type VMRFrequency as _VMRFrequency

type _VMRVideoDesc
	dwSize as DWORD
	dwSampleWidth as DWORD
	dwSampleHeight as DWORD
	SingleFieldPerSample as WINBOOL
	dwFourCC as DWORD
	InputSampleFreq as VMRFrequency
	OutputFrameFreq as VMRFrequency
end type

type VMRVideoDesc as _VMRVideoDesc

type _VMRDeinterlaceCaps
	dwSize as DWORD
	dwNumPreviousOutputFrames as DWORD
	dwNumForwardRefSamples as DWORD
	dwNumBackwardRefSamples as DWORD
	DeinterlaceTechnology as VMRDeinterlaceTech
end type

type VMRDeinterlaceCaps as _VMRDeinterlaceCaps

extern __MIDL_itf_strmif_0405_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0405_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IVMRDeinterlaceControl_INTERFACE_DEFINED__

extern IID_IVMRDeinterlaceControl as const IID

type IVMRDeinterlaceControl as IVMRDeinterlaceControl_

type IVMRDeinterlaceControlVtbl
	QueryInterface as function(byval This as IVMRDeinterlaceControl ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IVMRDeinterlaceControl ptr) as ULONG
	Release as function(byval This as IVMRDeinterlaceControl ptr) as ULONG
	GetNumberOfDeinterlaceModes as function(byval This as IVMRDeinterlaceControl ptr, byval lpVideoDescription as VMRVideoDesc ptr, byval lpdwNumDeinterlaceModes as LPDWORD, byval lpDeinterlaceModes as LPGUID) as HRESULT
	GetDeinterlaceModeCaps as function(byval This as IVMRDeinterlaceControl ptr, byval lpDeinterlaceMode as LPGUID, byval lpVideoDescription as VMRVideoDesc ptr, byval lpDeinterlaceCaps as VMRDeinterlaceCaps ptr) as HRESULT
	GetDeinterlaceMode as function(byval This as IVMRDeinterlaceControl ptr, byval dwStreamID as DWORD, byval lpDeinterlaceMode as LPGUID) as HRESULT
	SetDeinterlaceMode as function(byval This as IVMRDeinterlaceControl ptr, byval dwStreamID as DWORD, byval lpDeinterlaceMode as LPGUID) as HRESULT
	GetDeinterlacePrefs as function(byval This as IVMRDeinterlaceControl ptr, byval lpdwDeinterlacePrefs as LPDWORD) as HRESULT
	SetDeinterlacePrefs as function(byval This as IVMRDeinterlaceControl ptr, byval dwDeinterlacePrefs as DWORD) as HRESULT
	GetActualDeinterlaceMode as function(byval This as IVMRDeinterlaceControl ptr, byval dwStreamID as DWORD, byval lpDeinterlaceMode as LPGUID) as HRESULT
end type

type IVMRDeinterlaceControl_
	lpVtbl as IVMRDeinterlaceControlVtbl ptr
end type

declare function IVMRDeinterlaceControl_GetNumberOfDeinterlaceModes_Proxy(byval This as IVMRDeinterlaceControl ptr, byval lpVideoDescription as VMRVideoDesc ptr, byval lpdwNumDeinterlaceModes as LPDWORD, byval lpDeinterlaceModes as LPGUID) as HRESULT
declare sub IVMRDeinterlaceControl_GetNumberOfDeinterlaceModes_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRDeinterlaceControl_GetDeinterlaceModeCaps_Proxy(byval This as IVMRDeinterlaceControl ptr, byval lpDeinterlaceMode as LPGUID, byval lpVideoDescription as VMRVideoDesc ptr, byval lpDeinterlaceCaps as VMRDeinterlaceCaps ptr) as HRESULT
declare sub IVMRDeinterlaceControl_GetDeinterlaceModeCaps_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRDeinterlaceControl_GetDeinterlaceMode_Proxy(byval This as IVMRDeinterlaceControl ptr, byval dwStreamID as DWORD, byval lpDeinterlaceMode as LPGUID) as HRESULT
declare sub IVMRDeinterlaceControl_GetDeinterlaceMode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRDeinterlaceControl_SetDeinterlaceMode_Proxy(byval This as IVMRDeinterlaceControl ptr, byval dwStreamID as DWORD, byval lpDeinterlaceMode as LPGUID) as HRESULT
declare sub IVMRDeinterlaceControl_SetDeinterlaceMode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRDeinterlaceControl_GetDeinterlacePrefs_Proxy(byval This as IVMRDeinterlaceControl ptr, byval lpdwDeinterlacePrefs as LPDWORD) as HRESULT
declare sub IVMRDeinterlaceControl_GetDeinterlacePrefs_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRDeinterlaceControl_SetDeinterlacePrefs_Proxy(byval This as IVMRDeinterlaceControl ptr, byval dwDeinterlacePrefs as DWORD) as HRESULT
declare sub IVMRDeinterlaceControl_SetDeinterlacePrefs_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRDeinterlaceControl_GetActualDeinterlaceMode_Proxy(byval This as IVMRDeinterlaceControl ptr, byval dwStreamID as DWORD, byval lpDeinterlaceMode as LPGUID) as HRESULT
declare sub IVMRDeinterlaceControl_GetActualDeinterlaceMode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type _VMRALPHABITMAP
	dwFlags as DWORD
	hdc as HDC
	pDDS as LPDIRECTDRAWSURFACE7
	rSrc as RECT
	rDest as NORMALIZEDRECT
	fAlpha as FLOAT
	clrSrcKey as COLORREF
end type

type VMRALPHABITMAP as _VMRALPHABITMAP
type PVMRALPHABITMAP as _VMRALPHABITMAP ptr

#define VMRBITMAP_DISABLE &h00000001
#define VMRBITMAP_HDC &h00000002
#define VMRBITMAP_ENTIREDDS &h00000004
#define VMRBITMAP_SRCCOLORKEY &h00000008
#define VMRBITMAP_SRCRECT &h00000010

extern __MIDL_itf_strmif_0406_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0406_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IVMRMixerBitmap_INTERFACE_DEFINED__

extern IID_IVMRMixerBitmap as const IID

type IVMRMixerBitmap as IVMRMixerBitmap_

type IVMRMixerBitmapVtbl
	QueryInterface as function(byval This as IVMRMixerBitmap ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IVMRMixerBitmap ptr) as ULONG
	Release as function(byval This as IVMRMixerBitmap ptr) as ULONG
	SetAlphaBitmap as function(byval This as IVMRMixerBitmap ptr, byval pBmpParms as const VMRALPHABITMAP ptr) as HRESULT
	UpdateAlphaBitmapParameters as function(byval This as IVMRMixerBitmap ptr, byval pBmpParms as PVMRALPHABITMAP) as HRESULT
	GetAlphaBitmapParameters as function(byval This as IVMRMixerBitmap ptr, byval pBmpParms as PVMRALPHABITMAP) as HRESULT
end type

type IVMRMixerBitmap_
	lpVtbl as IVMRMixerBitmapVtbl ptr
end type

declare function IVMRMixerBitmap_SetAlphaBitmap_Proxy(byval This as IVMRMixerBitmap ptr, byval pBmpParms as const VMRALPHABITMAP ptr) as HRESULT
declare sub IVMRMixerBitmap_SetAlphaBitmap_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRMixerBitmap_UpdateAlphaBitmapParameters_Proxy(byval This as IVMRMixerBitmap ptr, byval pBmpParms as PVMRALPHABITMAP) as HRESULT
declare sub IVMRMixerBitmap_UpdateAlphaBitmapParameters_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRMixerBitmap_GetAlphaBitmapParameters_Proxy(byval This as IVMRMixerBitmap ptr, byval pBmpParms as PVMRALPHABITMAP) as HRESULT
declare sub IVMRMixerBitmap_GetAlphaBitmapParameters_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type _VMRVIDEOSTREAMINFO
	pddsVideoSurface as LPDIRECTDRAWSURFACE7
	dwWidth as DWORD
	dwHeight as DWORD
	dwStrmID as DWORD
	fAlpha as FLOAT
	ddClrKey as DDCOLORKEY
	rNormal as NORMALIZEDRECT
end type

type VMRVIDEOSTREAMINFO as _VMRVIDEOSTREAMINFO

extern __MIDL_itf_strmif_0407_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0407_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IVMRImageCompositor_INTERFACE_DEFINED__

extern IID_IVMRImageCompositor as const IID

type IVMRImageCompositorVtbl
	QueryInterface as function(byval This as IVMRImageCompositor ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IVMRImageCompositor ptr) as ULONG
	Release as function(byval This as IVMRImageCompositor ptr) as ULONG
	InitCompositionTarget as function(byval This as IVMRImageCompositor ptr, byval pD3DDevice as IUnknown ptr, byval pddsRenderTarget as LPDIRECTDRAWSURFACE7) as HRESULT
	TermCompositionTarget as function(byval This as IVMRImageCompositor ptr, byval pD3DDevice as IUnknown ptr, byval pddsRenderTarget as LPDIRECTDRAWSURFACE7) as HRESULT
	SetStreamMediaType as function(byval This as IVMRImageCompositor ptr, byval dwStrmID as DWORD, byval pmt as AM_MEDIA_TYPE ptr, byval fTexture as WINBOOL) as HRESULT
	CompositeImage as function(byval This as IVMRImageCompositor ptr, byval pD3DDevice as IUnknown ptr, byval pddsRenderTarget as LPDIRECTDRAWSURFACE7, byval pmtRenderTarget as AM_MEDIA_TYPE ptr, byval rtStart as REFERENCE_TIME, byval rtEnd as REFERENCE_TIME, byval dwClrBkGnd as DWORD, byval pVideoStreamInfo as VMRVIDEOSTREAMINFO ptr, byval cStreams as UINT) as HRESULT
end type

type IVMRImageCompositor_
	lpVtbl as IVMRImageCompositorVtbl ptr
end type

declare function IVMRImageCompositor_InitCompositionTarget_Proxy(byval This as IVMRImageCompositor ptr, byval pD3DDevice as IUnknown ptr, byval pddsRenderTarget as LPDIRECTDRAWSURFACE7) as HRESULT
declare sub IVMRImageCompositor_InitCompositionTarget_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRImageCompositor_TermCompositionTarget_Proxy(byval This as IVMRImageCompositor ptr, byval pD3DDevice as IUnknown ptr, byval pddsRenderTarget as LPDIRECTDRAWSURFACE7) as HRESULT
declare sub IVMRImageCompositor_TermCompositionTarget_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRImageCompositor_SetStreamMediaType_Proxy(byval This as IVMRImageCompositor ptr, byval dwStrmID as DWORD, byval pmt as AM_MEDIA_TYPE ptr, byval fTexture as WINBOOL) as HRESULT
declare sub IVMRImageCompositor_SetStreamMediaType_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRImageCompositor_CompositeImage_Proxy(byval This as IVMRImageCompositor ptr, byval pD3DDevice as IUnknown ptr, byval pddsRenderTarget as LPDIRECTDRAWSURFACE7, byval pmtRenderTarget as AM_MEDIA_TYPE ptr, byval rtStart as REFERENCE_TIME, byval rtEnd as REFERENCE_TIME, byval dwClrBkGnd as DWORD, byval pVideoStreamInfo as VMRVIDEOSTREAMINFO ptr, byval cStreams as UINT) as HRESULT
declare sub IVMRImageCompositor_CompositeImage_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IVMRVideoStreamControl_INTERFACE_DEFINED__

extern IID_IVMRVideoStreamControl as const IID

type IVMRVideoStreamControl as IVMRVideoStreamControl_

type IVMRVideoStreamControlVtbl
	QueryInterface as function(byval This as IVMRVideoStreamControl ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IVMRVideoStreamControl ptr) as ULONG
	Release as function(byval This as IVMRVideoStreamControl ptr) as ULONG
	SetColorKey as function(byval This as IVMRVideoStreamControl ptr, byval lpClrKey as LPDDCOLORKEY) as HRESULT
	GetColorKey as function(byval This as IVMRVideoStreamControl ptr, byval lpClrKey as LPDDCOLORKEY) as HRESULT
	SetStreamActiveState as function(byval This as IVMRVideoStreamControl ptr, byval fActive as WINBOOL) as HRESULT
	GetStreamActiveState as function(byval This as IVMRVideoStreamControl ptr, byval lpfActive as WINBOOL ptr) as HRESULT
end type

type IVMRVideoStreamControl_
	lpVtbl as IVMRVideoStreamControlVtbl ptr
end type

declare function IVMRVideoStreamControl_SetColorKey_Proxy(byval This as IVMRVideoStreamControl ptr, byval lpClrKey as LPDDCOLORKEY) as HRESULT
declare sub IVMRVideoStreamControl_SetColorKey_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRVideoStreamControl_GetColorKey_Proxy(byval This as IVMRVideoStreamControl ptr, byval lpClrKey as LPDDCOLORKEY) as HRESULT
declare sub IVMRVideoStreamControl_GetColorKey_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRVideoStreamControl_SetStreamActiveState_Proxy(byval This as IVMRVideoStreamControl ptr, byval fActive as WINBOOL) as HRESULT
declare sub IVMRVideoStreamControl_SetStreamActiveState_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRVideoStreamControl_GetStreamActiveState_Proxy(byval This as IVMRVideoStreamControl ptr, byval lpfActive as WINBOOL ptr) as HRESULT
declare sub IVMRVideoStreamControl_GetStreamActiveState_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IVMRSurface_INTERFACE_DEFINED__

extern IID_IVMRSurface as const IID

type IVMRSurface as IVMRSurface_

type IVMRSurfaceVtbl
	QueryInterface as function(byval This as IVMRSurface ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IVMRSurface ptr) as ULONG
	Release as function(byval This as IVMRSurface ptr) as ULONG
	IsSurfaceLocked as function(byval This as IVMRSurface ptr) as HRESULT
	LockSurface as function(byval This as IVMRSurface ptr, byval lpSurface as UBYTE ptr ptr) as HRESULT
	UnlockSurface as function(byval This as IVMRSurface ptr) as HRESULT
	GetSurface as function(byval This as IVMRSurface ptr, byval lplpSurface as LPDIRECTDRAWSURFACE7 ptr) as HRESULT
end type

type IVMRSurface_
	lpVtbl as IVMRSurfaceVtbl ptr
end type

declare function IVMRSurface_IsSurfaceLocked_Proxy(byval This as IVMRSurface ptr) as HRESULT
declare sub IVMRSurface_IsSurfaceLocked_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRSurface_LockSurface_Proxy(byval This as IVMRSurface ptr, byval lpSurface as UBYTE ptr ptr) as HRESULT
declare sub IVMRSurface_LockSurface_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRSurface_UnlockSurface_Proxy(byval This as IVMRSurface ptr) as HRESULT
declare sub IVMRSurface_UnlockSurface_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRSurface_GetSurface_Proxy(byval This as IVMRSurface ptr, byval lplpSurface as LPDIRECTDRAWSURFACE7 ptr) as HRESULT
declare sub IVMRSurface_GetSurface_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IVMRImagePresenterConfig_INTERFACE_DEFINED__

extern IID_IVMRImagePresenterConfig as const IID

type IVMRImagePresenterConfig as IVMRImagePresenterConfig_

type IVMRImagePresenterConfigVtbl
	QueryInterface as function(byval This as IVMRImagePresenterConfig ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IVMRImagePresenterConfig ptr) as ULONG
	Release as function(byval This as IVMRImagePresenterConfig ptr) as ULONG
	SetRenderingPrefs as function(byval This as IVMRImagePresenterConfig ptr, byval dwRenderFlags as DWORD) as HRESULT
	GetRenderingPrefs as function(byval This as IVMRImagePresenterConfig ptr, byval dwRenderFlags as DWORD ptr) as HRESULT
end type

type IVMRImagePresenterConfig_
	lpVtbl as IVMRImagePresenterConfigVtbl ptr
end type

declare function IVMRImagePresenterConfig_SetRenderingPrefs_Proxy(byval This as IVMRImagePresenterConfig ptr, byval dwRenderFlags as DWORD) as HRESULT
declare sub IVMRImagePresenterConfig_SetRenderingPrefs_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRImagePresenterConfig_GetRenderingPrefs_Proxy(byval This as IVMRImagePresenterConfig ptr, byval dwRenderFlags as DWORD ptr) as HRESULT
declare sub IVMRImagePresenterConfig_GetRenderingPrefs_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IVMRImagePresenterExclModeConfig_INTERFACE_DEFINED__

extern IID_IVMRImagePresenterExclModeConfig as const IID

type IVMRImagePresenterExclModeConfig as IVMRImagePresenterExclModeConfig_

type IVMRImagePresenterExclModeConfigVtbl
	QueryInterface as function(byval This as IVMRImagePresenterExclModeConfig ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IVMRImagePresenterExclModeConfig ptr) as ULONG
	Release as function(byval This as IVMRImagePresenterExclModeConfig ptr) as ULONG
	SetRenderingPrefs as function(byval This as IVMRImagePresenterExclModeConfig ptr, byval dwRenderFlags as DWORD) as HRESULT
	GetRenderingPrefs as function(byval This as IVMRImagePresenterExclModeConfig ptr, byval dwRenderFlags as DWORD ptr) as HRESULT
	SetXlcModeDDObjAndPrimarySurface as function(byval This as IVMRImagePresenterExclModeConfig ptr, byval lpDDObj as LPDIRECTDRAW7, byval lpPrimarySurf as LPDIRECTDRAWSURFACE7) as HRESULT
	GetXlcModeDDObjAndPrimarySurface as function(byval This as IVMRImagePresenterExclModeConfig ptr, byval lpDDObj as LPDIRECTDRAW7 ptr, byval lpPrimarySurf as LPDIRECTDRAWSURFACE7 ptr) as HRESULT
end type

type IVMRImagePresenterExclModeConfig_
	lpVtbl as IVMRImagePresenterExclModeConfigVtbl ptr
end type

declare function IVMRImagePresenterExclModeConfig_SetXlcModeDDObjAndPrimarySurface_Proxy(byval This as IVMRImagePresenterExclModeConfig ptr, byval lpDDObj as LPDIRECTDRAW7, byval lpPrimarySurf as LPDIRECTDRAWSURFACE7) as HRESULT
declare sub IVMRImagePresenterExclModeConfig_SetXlcModeDDObjAndPrimarySurface_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRImagePresenterExclModeConfig_GetXlcModeDDObjAndPrimarySurface_Proxy(byval This as IVMRImagePresenterExclModeConfig ptr, byval lpDDObj as LPDIRECTDRAW7 ptr, byval lpPrimarySurf as LPDIRECTDRAWSURFACE7 ptr) as HRESULT
declare sub IVMRImagePresenterExclModeConfig_GetXlcModeDDObjAndPrimarySurface_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IVPManager_INTERFACE_DEFINED__

extern IID_IVPManager as const IID

type IVPManager as IVPManager_

type IVPManagerVtbl
	QueryInterface as function(byval This as IVPManager ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IVPManager ptr) as ULONG
	Release as function(byval This as IVPManager ptr) as ULONG
	SetVideoPortIndex as function(byval This as IVPManager ptr, byval dwVideoPortIndex as DWORD) as HRESULT
	GetVideoPortIndex as function(byval This as IVPManager ptr, byval pdwVideoPortIndex as DWORD ptr) as HRESULT
end type

type IVPManager_
	lpVtbl as IVPManagerVtbl ptr
end type

declare function IVPManager_SetVideoPortIndex_Proxy(byval This as IVPManager ptr, byval dwVideoPortIndex as DWORD) as HRESULT
declare sub IVPManager_SetVideoPortIndex_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVPManager_GetVideoPortIndex_Proxy(byval This as IVPManager ptr, byval pdwVideoPortIndex as DWORD ptr) as HRESULT
declare sub IVPManager_GetVideoPortIndex_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#if _WIN32_WINNT = &h0602
	type IAMAsyncReaderTimestampScalingVtbl as IAMAsyncReaderTimestampScalingVtbl_

	type IAMAsyncReaderTimestampScaling
		lpVtbl as IAMAsyncReaderTimestampScalingVtbl ptr
	end type

	type IAMAsyncReaderTimestampScalingVtbl_
		QueryInterface as function(byval This as IAMAsyncReaderTimestampScaling ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IAMAsyncReaderTimestampScaling ptr) as ULONG
		Release as function(byval This as IAMAsyncReaderTimestampScaling ptr) as ULONG
		GetTimestampMode as function(byval This as IAMAsyncReaderTimestampScaling ptr, byval pfRaw as WINBOOL ptr) as HRESULT
		SetTimestampMode as function(byval This as IAMAsyncReaderTimestampScaling ptr, byval fRaw as WINBOOL) as HRESULT
	end type

	type IAMPluginControlVtbl as IAMPluginControlVtbl_

	type IAMPluginControl
		lpVtbl as IAMPluginControlVtbl ptr
	end type

	type IAMPluginControlVtbl_
		QueryInterface as function(byval This as IAMPluginControl ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IAMPluginControl ptr) as ULONG
		Release as function(byval This as IAMPluginControl ptr) as ULONG
		GetDisabledByIndex as function(byval This as IAMPluginControl ptr, byval index as DWORD, byval clsid as CLSID ptr) as HRESULT
		GetPreferredClsid as function(byval This as IAMPluginControl ptr, byval subType as const GUID const ptr, byval clsid as CLSID ptr) as HRESULT
		GetPreferredClsidByIndex as function(byval This as IAMPluginControl ptr, byval index as DWORD, byval subType as GUID ptr, byval clsid as CLSID ptr) as HRESULT
		IsDisabled as function(byval This as IAMPluginControl ptr, byval clsid as const IID const ptr) as HRESULT
		IsLegacyDisabled as function(byval This as IAMPluginControl ptr, byval dllName as LPCWSTR) as HRESULT
		SetDisabled as function(byval This as IAMPluginControl ptr, byval clsid as const IID const ptr, byval disabled as BOOL) as HRESULT
		SetPreferredClsid as function(byval This as IAMPluginControl ptr, byval subType as const GUID const ptr, byval clsid as const CLSID ptr) as HRESULT
	end type
#endif

extern __MIDL_itf_strmif_0413_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_strmif_0413_v0_0_s_ifspec as RPC_IF_HANDLE

end extern
