''
''
'' strmif -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_strmif_bi__
#define __win_strmif_bi__

#include once "win/rpc.bi"
#include once "win/rpcndr.bi"

#ifndef COM_NO_WINDOWS_H
#include "windows.h"
#include "win/ole2.h"
#endif

type ICreateDevEnum_ as ICreateDevEnum
type IPin_ as IPin
type IEnumPins_ as IEnumPins
type IEnumMediaTypes_ as IEnumMediaTypes
type IFilterGraph_ as IFilterGraph
type IEnumFilters_ as IEnumFilters
type IMediaFilter_ as IMediaFilter
type IBaseFilter_ as IBaseFilter
type IReferenceClock_ as IReferenceClock
type IReferenceClock2_ as IReferenceClock2
type IMediaSample_ as IMediaSample
type IMediaSample2_ as IMediaSample2
type IMemAllocator_ as IMemAllocator
type IMemAllocatorCallbackTemp_ as IMemAllocatorCallbackTemp
type IMemAllocatorNotifyCallbackTemp_ as IMemAllocatorNotifyCallbackTemp
type IMemInputPin_ as IMemInputPin
type IAMovieSetup_ as IAMovieSetup
type IMediaSeeking_ as IMediaSeeking
type IEnumRegFilters_ as IEnumRegFilters
type IFilterMapper_ as IFilterMapper
type IFilterMapper2_ as IFilterMapper2
type IFilterMapper3_ as IFilterMapper3
type IQualityControl_ as IQualityControl
type IOverlayNotify_ as IOverlayNotify
type IOverlayNotify2_ as IOverlayNotify2
type IOverlay_ as IOverlay
type IMediaEventSink_ as IMediaEventSink
type IFileSourceFilter_ as IFileSourceFilter
type IFileSinkFilter_ as IFileSinkFilter
type IFileSinkFilter2_ as IFileSinkFilter2
type IGraphBuilder_ as IGraphBuilder
type ICaptureGraphBuilder_ as ICaptureGraphBuilder
type IAMCopyCaptureFileProgress_ as IAMCopyCaptureFileProgress
type ICaptureGraphBuilder2_ as ICaptureGraphBuilder2
type IFilterGraph2_ as IFilterGraph2
type IStreamBuilder_ as IStreamBuilder
type IAsyncReader_ as IAsyncReader
type IGraphVersion_ as IGraphVersion
type IResourceConsumer_ as IResourceConsumer
type IResourceManager_ as IResourceManager
type IDistributorNotify_ as IDistributorNotify
type IAMStreamControl_ as IAMStreamControl
type ISeekingPassThru_ as ISeekingPassThru
type IAMStreamConfig_ as IAMStreamConfig
type IConfigInterleaving_ as IConfigInterleaving
type IConfigAviMux_ as IConfigAviMux
type IAMVideoCompression_ as IAMVideoCompression
type IAMVfwCaptureDialogs_ as IAMVfwCaptureDialogs
type IAMVfwCompressDialogs_ as IAMVfwCompressDialogs
type IAMDroppedFrames_ as IAMDroppedFrames
type IAMAudioInputMixer_ as IAMAudioInputMixer
type IAMBufferNegotiation_ as IAMBufferNegotiation
type IAMAnalogVideoDecoder_ as IAMAnalogVideoDecoder
type IAMVideoProcAmp_ as IAMVideoProcAmp
type IAMCameraControl_ as IAMCameraControl
type IAMVideoControl_ as IAMVideoControl
type IAMCrossbar_ as IAMCrossbar
type IAMTuner_ as IAMTuner
type IAMTunerNotification_ as IAMTunerNotification
type IAMTVTuner_ as IAMTVTuner
type IBPCSatelliteTuner_ as IBPCSatelliteTuner
type IAMTVAudio_ as IAMTVAudio
type IAMTVAudioNotification_ as IAMTVAudioNotification
type IAMAnalogVideoEncoder_ as IAMAnalogVideoEncoder
type IKsPropertySet_ as IKsPropertySet
type IMediaPropertyBag_ as IMediaPropertyBag
type IPersistMediaPropertyBag_ as IPersistMediaPropertyBag
type IAMPhysicalPinInfo_ as IAMPhysicalPinInfo
type IAMExtDevice_ as IAMExtDevice
type IAMExtTransport_ as IAMExtTransport
type IAMTimecodeReader_ as IAMTimecodeReader
type IAMTimecodeGenerator_ as IAMTimecodeGenerator
type IAMTimecodeDisplay_ as IAMTimecodeDisplay
type IAMDevMemoryAllocator_ as IAMDevMemoryAllocator
type IAMDevMemoryControl_ as IAMDevMemoryControl
type IAMStreamSelect_ as IAMStreamSelect
type IAMResourceControl_ as IAMResourceControl
type IAMClockAdjust_ as IAMClockAdjust
type IAMFilterMiscFlags_ as IAMFilterMiscFlags
type IDrawVideoImage_ as IDrawVideoImage
type IDecimateVideoImage_ as IDecimateVideoImage
type IAMVideoDecimationProperties_ as IAMVideoDecimationProperties
type IVideoFrameStep_ as IVideoFrameStep
type IAMLatency_ as IAMLatency
type IAMPushSource_ as IAMPushSource
type IAMDeviceRemoval_ as IAMDeviceRemoval
type IDVEnc_ as IDVEnc
type IIPDVDec_ as IIPDVDec
type IDVRGB219_ as IDVRGB219
type IDVSplitter_ as IDVSplitter
type IAMAudioRendererStats_ as IAMAudioRendererStats
type IAMGraphStreams_ as IAMGraphStreams
type IAMOverlayFX_ as IAMOverlayFX
type IAMOpenProgress_ as IAMOpenProgress
type IMpeg2Demultiplexer_ as IMpeg2Demultiplexer
type IEnumStreamIdMap_ as IEnumStreamIdMap
type IMPEG2StreamIdMap_ as IMPEG2StreamIdMap
type IRegisterServiceProvider_ as IRegisterServiceProvider
type IAMClockSlave_ as IAMClockSlave
type IAMGraphBuilderCallback_ as IAMGraphBuilderCallback
type ICodecAPI_ as ICodecAPI
type IGetCapabilitiesKey_ as IGetCapabilitiesKey
type IEncoderAPI_ as IEncoderAPI
type IVideoEncoder_ as IVideoEncoder
type IAMDecoderCaps_ as IAMDecoderCaps
type IDvdControl_ as IDvdControl
type IDvdInfo_ as IDvdInfo
type IDvdCmd_ as IDvdCmd
type IDvdState_ as IDvdState
type IDvdControl2_ as IDvdControl2
type IDvdInfo2_ as IDvdInfo2
type IDvdGraphBuilder_ as IDvdGraphBuilder
type IDDrawExclModeVideo_ as IDDrawExclModeVideo
type IDDrawExclModeVideoCallback_ as IDDrawExclModeVideoCallback
type IPinConnection_ as IPinConnection
type IPinFlowControl_ as IPinFlowControl
type IGraphConfig_ as IGraphConfig
type IGraphConfigCallback_ as IGraphConfigCallback
type IFilterChain_ as IFilterChain
type IVMRImagePresenter_ as IVMRImagePresenter
type IVMRSurfaceAllocator_ as IVMRSurfaceAllocator
type IVMRSurfaceAllocatorNotify_ as IVMRSurfaceAllocatorNotify
type IVMRWindowlessControl_ as IVMRWindowlessControl
type IVMRMixerControl_ as IVMRMixerControl
type IVMRMonitorConfig_ as IVMRMonitorConfig
type IVMRFilterConfig_ as IVMRFilterConfig
type IVMRAspectRatioControl_ as IVMRAspectRatioControl
type IVMRDeinterlaceControl_ as IVMRDeinterlaceControl
type IVMRMixerBitmap_ as IVMRMixerBitmap
type IVMRImageCompositor_ as IVMRImageCompositor
type IVMRVideoStreamControl_ as IVMRVideoStreamControl
type IVMRSurface_ as IVMRSurface
type IVMRImagePresenterConfig_ as IVMRImagePresenterConfig
type IVMRImagePresenterExclModeConfig_ as IVMRImagePresenterExclModeConfig
type IVPManager_ as IVPManager

#include once "win/unknwn.bi"
#include once "win/objidl.bi"
#include once "win/oaidl.bi"
#include once "win/ocidl.bi"

#define CDEF_CLASS_DEFAULT &h0001
#define CDEF_BYPASS_CLASS_MANAGER &h0002
#define CDEF_MERIT_ABOVE_DO_NOT_USE &h0008
#define CDEF_DEVMON_CMGR_DEVICE &h0010
#define CDEF_DEVMON_DMO &h0020
#define CDEF_DEVMON_PNP_DEVICE &h0040
#define CDEF_DEVMON_FILTER &h0080
#define CDEF_DEVMON_SELECTIVE_MASK &h00f0

extern IID_ICreateDevEnum alias "IID_ICreateDevEnum" as IID

type ICreateDevEnumVtbl_ as ICreateDevEnumVtbl

type ICreateDevEnum
	lpVtbl as ICreateDevEnumVtbl_ ptr
end type

type ICreateDevEnumVtbl
	QueryInterface as function(byval as ICreateDevEnum ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as ICreateDevEnum ptr) as ULONG
	Release as function(byval as ICreateDevEnum ptr) as ULONG
	CreateClassEnumerator as function(byval as ICreateDevEnum ptr, byval as CLSID ptr, byval as IEnumMoniker ptr ptr, byval as DWORD) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function ICreateDevEnum_CreateClassEnumerator_Proxy alias "ICreateDevEnum_CreateClassEnumerator_Proxy" (byval This as ICreateDevEnum ptr, byval clsidDeviceClass as CLSID ptr, byval ppEnumMoniker as IEnumMoniker ptr ptr, byval dwFlags as DWORD) as HRESULT
declare sub ICreateDevEnum_CreateClassEnumerator_Stub alias "ICreateDevEnum_CreateClassEnumerator_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

#define CHARS_IN_GUID 39

type AM_MEDIA_TYPE
	majortype as GUID
	subtype as GUID
	bFixedSizeSamples as BOOL
	bTemporalCompression as BOOL
	lSampleSize as ULONG
	formattype as GUID
	pUnk as IUnknown ptr
	cbFormat as ULONG
	pbFormat as BYTE ptr
end type

enum PIN_DIRECTION
	PINDIR_INPUT = 0
	PINDIR_OUTPUT = PINDIR_INPUT+1
end enum

#define MAX_PIN_NAME 128
#define MAX_FILTER_NAME 128

type REFERENCE_TIME as LONGLONG
type REFTIME as double
type HSEMAPHORE as DWORD_PTR
type HEVENT as DWORD_PTR

type ALLOCATOR_PROPERTIES
	cBuffers as integer
	cbBuffer as integer
	cbAlign as integer
	cbPrefix as integer
end type

type PIN_INFO
	pFilter as IBaseFilter_ ptr
	dir as PIN_DIRECTION
	achName(0 to 128-1) as WCHAR
end type

extern IID_IPin alias "IID_IPin" as IID

type IPinVtbl_ as IPinVtbl

type IPin
	lpVtbl as IPinVtbl_ ptr
end type

type IPinVtbl
	QueryInterface as function(byval as IPin ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IPin ptr) as ULONG
	Release as function(byval as IPin ptr) as ULONG
	Connect as function(byval as IPin ptr, byval as IPin ptr, byval as AM_MEDIA_TYPE ptr) as HRESULT
	ReceiveConnection as function(byval as IPin ptr, byval as IPin ptr, byval as AM_MEDIA_TYPE ptr) as HRESULT
	Disconnect as function(byval as IPin ptr) as HRESULT
	ConnectedTo as function(byval as IPin ptr, byval as IPin ptr ptr) as HRESULT
	ConnectionMediaType as function(byval as IPin ptr, byval as AM_MEDIA_TYPE ptr) as HRESULT
	QueryPinInfo as function(byval as IPin ptr, byval as PIN_INFO ptr) as HRESULT
	QueryDirection as function(byval as IPin ptr, byval as PIN_DIRECTION ptr) as HRESULT
	QueryId as function(byval as IPin ptr, byval as LPWSTR ptr) as HRESULT
	QueryAccept as function(byval as IPin ptr, byval as AM_MEDIA_TYPE ptr) as HRESULT
	EnumMediaTypes as function(byval as IPin ptr, byval as IEnumMediaTypes_ ptr ptr) as HRESULT
	QueryInternalConnections as function(byval as IPin ptr, byval as IPin ptr ptr, byval as ULONG ptr) as HRESULT
	EndOfStream as function(byval as IPin ptr) as HRESULT
	BeginFlush as function(byval as IPin ptr) as HRESULT
	EndFlush as function(byval as IPin ptr) as HRESULT
	NewSegment as function(byval as IPin ptr, byval as REFERENCE_TIME, byval as REFERENCE_TIME, byval as double) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IPin_Connect_Proxy alias "IPin_Connect_Proxy" (byval This as IPin ptr, byval pReceivePin as IPin ptr, byval pmt as AM_MEDIA_TYPE ptr) as HRESULT
declare sub IPin_Connect_Stub alias "IPin_Connect_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPin_ReceiveConnection_Proxy alias "IPin_ReceiveConnection_Proxy" (byval This as IPin ptr, byval pConnector as IPin ptr, byval pmt as AM_MEDIA_TYPE ptr) as HRESULT
declare sub IPin_ReceiveConnection_Stub alias "IPin_ReceiveConnection_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPin_Disconnect_Proxy alias "IPin_Disconnect_Proxy" (byval This as IPin ptr) as HRESULT
declare sub IPin_Disconnect_Stub alias "IPin_Disconnect_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPin_ConnectedTo_Proxy alias "IPin_ConnectedTo_Proxy" (byval This as IPin ptr, byval pPin as IPin ptr ptr) as HRESULT
declare sub IPin_ConnectedTo_Stub alias "IPin_ConnectedTo_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPin_ConnectionMediaType_Proxy alias "IPin_ConnectionMediaType_Proxy" (byval This as IPin ptr, byval pmt as AM_MEDIA_TYPE ptr) as HRESULT
declare sub IPin_ConnectionMediaType_Stub alias "IPin_ConnectionMediaType_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPin_QueryPinInfo_Proxy alias "IPin_QueryPinInfo_Proxy" (byval This as IPin ptr, byval pInfo as PIN_INFO ptr) as HRESULT
declare sub IPin_QueryPinInfo_Stub alias "IPin_QueryPinInfo_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPin_QueryDirection_Proxy alias "IPin_QueryDirection_Proxy" (byval This as IPin ptr, byval pPinDir as PIN_DIRECTION ptr) as HRESULT
declare sub IPin_QueryDirection_Stub alias "IPin_QueryDirection_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPin_QueryId_Proxy alias "IPin_QueryId_Proxy" (byval This as IPin ptr, byval Id as LPWSTR ptr) as HRESULT
declare sub IPin_QueryId_Stub alias "IPin_QueryId_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPin_QueryAccept_Proxy alias "IPin_QueryAccept_Proxy" (byval This as IPin ptr, byval pmt as AM_MEDIA_TYPE ptr) as HRESULT
declare sub IPin_QueryAccept_Stub alias "IPin_QueryAccept_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPin_EnumMediaTypes_Proxy alias "IPin_EnumMediaTypes_Proxy" (byval This as IPin ptr, byval ppEnum as IEnumMediaTypes ptr ptr) as HRESULT
declare sub IPin_EnumMediaTypes_Stub alias "IPin_EnumMediaTypes_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPin_QueryInternalConnections_Proxy alias "IPin_QueryInternalConnections_Proxy" (byval This as IPin ptr, byval apPin as IPin ptr ptr, byval nPin as ULONG ptr) as HRESULT
declare sub IPin_QueryInternalConnections_Stub alias "IPin_QueryInternalConnections_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPin_EndOfStream_Proxy alias "IPin_EndOfStream_Proxy" (byval This as IPin ptr) as HRESULT
declare sub IPin_EndOfStream_Stub alias "IPin_EndOfStream_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPin_BeginFlush_Proxy alias "IPin_BeginFlush_Proxy" (byval This as IPin ptr) as HRESULT
declare sub IPin_BeginFlush_Stub alias "IPin_BeginFlush_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPin_EndFlush_Proxy alias "IPin_EndFlush_Proxy" (byval This as IPin ptr) as HRESULT
declare sub IPin_EndFlush_Stub alias "IPin_EndFlush_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPin_NewSegment_Proxy alias "IPin_NewSegment_Proxy" (byval This as IPin ptr, byval tStart as REFERENCE_TIME, byval tStop as REFERENCE_TIME, byval dRate as double) as HRESULT
declare sub IPin_NewSegment_Stub alias "IPin_NewSegment_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type PPIN as IPin ptr

extern IID_IEnumPins alias "IID_IEnumPins" as IID

type IEnumPinsVtbl_ as IEnumPinsVtbl

type IEnumPins
	lpVtbl as IEnumPinsVtbl_ ptr
end type

type IEnumPinsVtbl
	QueryInterface as function(byval as IEnumPins ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IEnumPins ptr) as ULONG
	Release as function(byval as IEnumPins ptr) as ULONG
	Next as function(byval as IEnumPins ptr, byval as ULONG, byval as IPin ptr ptr, byval as ULONG ptr) as HRESULT
	Skip as function(byval as IEnumPins ptr, byval as ULONG) as HRESULT
	Reset as function(byval as IEnumPins ptr) as HRESULT
	Clone as function(byval as IEnumPins ptr, byval as IEnumPins ptr ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IEnumPins_Next_Proxy alias "IEnumPins_Next_Proxy" (byval This as IEnumPins ptr, byval cPins as ULONG, byval ppPins as IPin ptr ptr, byval pcFetched as ULONG ptr) as HRESULT
declare sub IEnumPins_Next_Stub alias "IEnumPins_Next_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEnumPins_Skip_Proxy alias "IEnumPins_Skip_Proxy" (byval This as IEnumPins ptr, byval cPins as ULONG) as HRESULT
declare sub IEnumPins_Skip_Stub alias "IEnumPins_Skip_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEnumPins_Reset_Proxy alias "IEnumPins_Reset_Proxy" (byval This as IEnumPins ptr) as HRESULT
declare sub IEnumPins_Reset_Stub alias "IEnumPins_Reset_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEnumPins_Clone_Proxy alias "IEnumPins_Clone_Proxy" (byval This as IEnumPins ptr, byval ppEnum as IEnumPins ptr ptr) as HRESULT
declare sub IEnumPins_Clone_Stub alias "IEnumPins_Clone_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type PENUMPINS as IEnumPins ptr

extern IID_IEnumMediaTypes alias "IID_IEnumMediaTypes" as IID

type IEnumMediaTypesVtbl_ as IEnumMediaTypesVtbl

type IEnumMediaTypes
	lpVtbl as IEnumMediaTypesVtbl_ ptr
end type

type IEnumMediaTypesVtbl
	QueryInterface as function(byval as IEnumMediaTypes ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IEnumMediaTypes ptr) as ULONG
	Release as function(byval as IEnumMediaTypes ptr) as ULONG
	Next as function(byval as IEnumMediaTypes ptr, byval as ULONG, byval as AM_MEDIA_TYPE ptr ptr, byval as ULONG ptr) as HRESULT
	Skip as function(byval as IEnumMediaTypes ptr, byval as ULONG) as HRESULT
	Reset as function(byval as IEnumMediaTypes ptr) as HRESULT
	Clone as function(byval as IEnumMediaTypes ptr, byval as IEnumMediaTypes ptr ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IEnumMediaTypes_Next_Proxy alias "IEnumMediaTypes_Next_Proxy" (byval This as IEnumMediaTypes ptr, byval cMediaTypes as ULONG, byval ppMediaTypes as AM_MEDIA_TYPE ptr ptr, byval pcFetched as ULONG ptr) as HRESULT
declare sub IEnumMediaTypes_Next_Stub alias "IEnumMediaTypes_Next_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEnumMediaTypes_Skip_Proxy alias "IEnumMediaTypes_Skip_Proxy" (byval This as IEnumMediaTypes ptr, byval cMediaTypes as ULONG) as HRESULT
declare sub IEnumMediaTypes_Skip_Stub alias "IEnumMediaTypes_Skip_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEnumMediaTypes_Reset_Proxy alias "IEnumMediaTypes_Reset_Proxy" (byval This as IEnumMediaTypes ptr) as HRESULT
declare sub IEnumMediaTypes_Reset_Stub alias "IEnumMediaTypes_Reset_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEnumMediaTypes_Clone_Proxy alias "IEnumMediaTypes_Clone_Proxy" (byval This as IEnumMediaTypes ptr, byval ppEnum as IEnumMediaTypes ptr ptr) as HRESULT
declare sub IEnumMediaTypes_Clone_Stub alias "IEnumMediaTypes_Clone_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type PENUMMEDIATYPES as IEnumMediaTypes ptr

extern IID_IFilterGraph alias "IID_IFilterGraph" as IID

type IFilterGraphVtbl_ as IFilterGraphVtbl

type IFilterGraph
	lpVtbl as IFilterGraphVtbl_ ptr
end type

type IFilterGraphVtbl
	QueryInterface as function(byval as IFilterGraph ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IFilterGraph ptr) as ULONG
	Release as function(byval as IFilterGraph ptr) as ULONG
	AddFilter as function(byval as IFilterGraph ptr, byval as IBaseFilter_ ptr, byval as LPCWSTR) as HRESULT
	RemoveFilter as function(byval as IFilterGraph ptr, byval as IBaseFilter_ ptr) as HRESULT
	EnumFilters as function(byval as IFilterGraph ptr, byval as IEnumFilters_ ptr ptr) as HRESULT
	FindFilterByName as function(byval as IFilterGraph ptr, byval as LPCWSTR, byval as IBaseFilter_ ptr ptr) as HRESULT
	ConnectDirect as function(byval as IFilterGraph ptr, byval as IPin ptr, byval as IPin ptr, byval as AM_MEDIA_TYPE ptr) as HRESULT
	Reconnect as function(byval as IFilterGraph ptr, byval as IPin ptr) as HRESULT
	Disconnect as function(byval as IFilterGraph ptr, byval as IPin ptr) as HRESULT
	SetDefaultSyncSource as function(byval as IFilterGraph ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IFilterGraph_AddFilter_Proxy alias "IFilterGraph_AddFilter_Proxy" (byval This as IFilterGraph ptr, byval pFilter as IBaseFilter ptr, byval pName as LPCWSTR) as HRESULT
declare sub IFilterGraph_AddFilter_Stub alias "IFilterGraph_AddFilter_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFilterGraph_RemoveFilter_Proxy alias "IFilterGraph_RemoveFilter_Proxy" (byval This as IFilterGraph ptr, byval pFilter as IBaseFilter ptr) as HRESULT
declare sub IFilterGraph_RemoveFilter_Stub alias "IFilterGraph_RemoveFilter_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFilterGraph_EnumFilters_Proxy alias "IFilterGraph_EnumFilters_Proxy" (byval This as IFilterGraph ptr, byval ppEnum as IEnumFilters ptr ptr) as HRESULT
declare sub IFilterGraph_EnumFilters_Stub alias "IFilterGraph_EnumFilters_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFilterGraph_FindFilterByName_Proxy alias "IFilterGraph_FindFilterByName_Proxy" (byval This as IFilterGraph ptr, byval pName as LPCWSTR, byval ppFilter as IBaseFilter ptr ptr) as HRESULT
declare sub IFilterGraph_FindFilterByName_Stub alias "IFilterGraph_FindFilterByName_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFilterGraph_ConnectDirect_Proxy alias "IFilterGraph_ConnectDirect_Proxy" (byval This as IFilterGraph ptr, byval ppinOut as IPin ptr, byval ppinIn as IPin ptr, byval pmt as AM_MEDIA_TYPE ptr) as HRESULT
declare sub IFilterGraph_ConnectDirect_Stub alias "IFilterGraph_ConnectDirect_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFilterGraph_Reconnect_Proxy alias "IFilterGraph_Reconnect_Proxy" (byval This as IFilterGraph ptr, byval ppin as IPin ptr) as HRESULT
declare sub IFilterGraph_Reconnect_Stub alias "IFilterGraph_Reconnect_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFilterGraph_Disconnect_Proxy alias "IFilterGraph_Disconnect_Proxy" (byval This as IFilterGraph ptr, byval ppin as IPin ptr) as HRESULT
declare sub IFilterGraph_Disconnect_Stub alias "IFilterGraph_Disconnect_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFilterGraph_SetDefaultSyncSource_Proxy alias "IFilterGraph_SetDefaultSyncSource_Proxy" (byval This as IFilterGraph ptr) as HRESULT
declare sub IFilterGraph_SetDefaultSyncSource_Stub alias "IFilterGraph_SetDefaultSyncSource_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type PFILTERGRAPH as IFilterGraph ptr

extern IID_IEnumFilters alias "IID_IEnumFilters" as IID

type IEnumFiltersVtbl_ as IEnumFiltersVtbl

type IEnumFilters
	lpVtbl as IEnumFiltersVtbl_ ptr
end type

type IEnumFiltersVtbl
	QueryInterface as function(byval as IEnumFilters ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IEnumFilters ptr) as ULONG
	Release as function(byval as IEnumFilters ptr) as ULONG
	Next as function(byval as IEnumFilters ptr, byval as ULONG, byval as IBaseFilter_ ptr ptr, byval as ULONG ptr) as HRESULT
	Skip as function(byval as IEnumFilters ptr, byval as ULONG) as HRESULT
	Reset as function(byval as IEnumFilters ptr) as HRESULT
	Clone as function(byval as IEnumFilters ptr, byval as IEnumFilters ptr ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IEnumFilters_Next_Proxy alias "IEnumFilters_Next_Proxy" (byval This as IEnumFilters ptr, byval cFilters as ULONG, byval ppFilter as IBaseFilter ptr ptr, byval pcFetched as ULONG ptr) as HRESULT
declare sub IEnumFilters_Next_Stub alias "IEnumFilters_Next_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEnumFilters_Skip_Proxy alias "IEnumFilters_Skip_Proxy" (byval This as IEnumFilters ptr, byval cFilters as ULONG) as HRESULT
declare sub IEnumFilters_Skip_Stub alias "IEnumFilters_Skip_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEnumFilters_Reset_Proxy alias "IEnumFilters_Reset_Proxy" (byval This as IEnumFilters ptr) as HRESULT
declare sub IEnumFilters_Reset_Stub alias "IEnumFilters_Reset_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEnumFilters_Clone_Proxy alias "IEnumFilters_Clone_Proxy" (byval This as IEnumFilters ptr, byval ppEnum as IEnumFilters ptr ptr) as HRESULT
declare sub IEnumFilters_Clone_Stub alias "IEnumFilters_Clone_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type PENUMFILTERS as IEnumFilters ptr

enum FILTER_STATE
	State_Stopped = 0
	State_Paused = State_Stopped+1
	State_Running = State_Paused+1
end enum

extern IID_IMediaFilter alias "IID_IMediaFilter" as IID

type IMediaFilterVtbl_ as IMediaFilterVtbl

type IMediaFilter
	lpVtbl as IMediaFilterVtbl_ ptr
end type

type IMediaFilterVtbl
	QueryInterface as function(byval as IMediaFilter ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IMediaFilter ptr) as ULONG
	Release as function(byval as IMediaFilter ptr) as ULONG
	GetClassID as function(byval as IMediaFilter ptr, byval as CLSID ptr) as HRESULT
	Stop as function(byval as IMediaFilter ptr) as HRESULT
	Pause as function(byval as IMediaFilter ptr) as HRESULT
	Run as function(byval as IMediaFilter ptr, byval as REFERENCE_TIME) as HRESULT
	GetState as function(byval as IMediaFilter ptr, byval as DWORD, byval as FILTER_STATE ptr) as HRESULT
	SetSyncSource as function(byval as IMediaFilter ptr, byval as IReferenceClock_ ptr) as HRESULT
	GetSyncSource as function(byval as IMediaFilter ptr, byval as IReferenceClock_ ptr ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IMediaFilter_Stop_Proxy alias "IMediaFilter_Stop_Proxy" (byval This as IMediaFilter ptr) as HRESULT
declare sub IMediaFilter_Stop_Stub alias "IMediaFilter_Stop_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaFilter_Pause_Proxy alias "IMediaFilter_Pause_Proxy" (byval This as IMediaFilter ptr) as HRESULT
declare sub IMediaFilter_Pause_Stub alias "IMediaFilter_Pause_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaFilter_Run_Proxy alias "IMediaFilter_Run_Proxy" (byval This as IMediaFilter ptr, byval tStart as REFERENCE_TIME) as HRESULT
declare sub IMediaFilter_Run_Stub alias "IMediaFilter_Run_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaFilter_GetState_Proxy alias "IMediaFilter_GetState_Proxy" (byval This as IMediaFilter ptr, byval dwMilliSecsTimeout as DWORD, byval State as FILTER_STATE ptr) as HRESULT
declare sub IMediaFilter_GetState_Stub alias "IMediaFilter_GetState_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaFilter_SetSyncSource_Proxy alias "IMediaFilter_SetSyncSource_Proxy" (byval This as IMediaFilter ptr, byval pClock as IReferenceClock ptr) as HRESULT
declare sub IMediaFilter_SetSyncSource_Stub alias "IMediaFilter_SetSyncSource_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaFilter_GetSyncSource_Proxy alias "IMediaFilter_GetSyncSource_Proxy" (byval This as IMediaFilter ptr, byval pClock as IReferenceClock ptr ptr) as HRESULT
declare sub IMediaFilter_GetSyncSource_Stub alias "IMediaFilter_GetSyncSource_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type PMEDIAFILTER as IMediaFilter ptr

type FILTER_INFO
	achName(0 to 128-1) as WCHAR
	pGraph as IFilterGraph ptr
end type

extern IID_IBaseFilter alias "IID_IBaseFilter" as IID

type IBaseFilterVtbl_ as IBaseFilterVtbl

type IBaseFilter
	lpVtbl as IBaseFilterVtbl_ ptr
end type

type IBaseFilterVtbl
	QueryInterface as function(byval as IBaseFilter ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IBaseFilter ptr) as ULONG
	Release as function(byval as IBaseFilter ptr) as ULONG
	GetClassID as function(byval as IBaseFilter ptr, byval as CLSID ptr) as HRESULT
	Stop as function(byval as IBaseFilter ptr) as HRESULT
	Pause as function(byval as IBaseFilter ptr) as HRESULT
	Run as function(byval as IBaseFilter ptr, byval as REFERENCE_TIME) as HRESULT
	GetState as function(byval as IBaseFilter ptr, byval as DWORD, byval as FILTER_STATE ptr) as HRESULT
	SetSyncSource as function(byval as IBaseFilter ptr, byval as IReferenceClock_ ptr) as HRESULT
	GetSyncSource as function(byval as IBaseFilter ptr, byval as IReferenceClock_ ptr ptr) as HRESULT
	EnumPins as function(byval as IBaseFilter ptr, byval as IEnumPins ptr ptr) as HRESULT
	FindPin as function(byval as IBaseFilter ptr, byval as LPCWSTR, byval as IPin ptr ptr) as HRESULT
	QueryFilterInfo as function(byval as IBaseFilter ptr, byval as FILTER_INFO ptr) as HRESULT
	JoinFilterGraph as function(byval as IBaseFilter ptr, byval as IFilterGraph ptr, byval as LPCWSTR) as HRESULT
	QueryVendorInfo as function(byval as IBaseFilter ptr, byval as LPWSTR ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IBaseFilter_EnumPins_Proxy alias "IBaseFilter_EnumPins_Proxy" (byval This as IBaseFilter ptr, byval ppEnum as IEnumPins ptr ptr) as HRESULT
declare sub IBaseFilter_EnumPins_Stub alias "IBaseFilter_EnumPins_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBaseFilter_FindPin_Proxy alias "IBaseFilter_FindPin_Proxy" (byval This as IBaseFilter ptr, byval Id as LPCWSTR, byval ppPin as IPin ptr ptr) as HRESULT
declare sub IBaseFilter_FindPin_Stub alias "IBaseFilter_FindPin_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBaseFilter_QueryFilterInfo_Proxy alias "IBaseFilter_QueryFilterInfo_Proxy" (byval This as IBaseFilter ptr, byval pInfo as FILTER_INFO ptr) as HRESULT
declare sub IBaseFilter_QueryFilterInfo_Stub alias "IBaseFilter_QueryFilterInfo_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBaseFilter_JoinFilterGraph_Proxy alias "IBaseFilter_JoinFilterGraph_Proxy" (byval This as IBaseFilter ptr, byval pGraph as IFilterGraph ptr, byval pName as LPCWSTR) as HRESULT
declare sub IBaseFilter_JoinFilterGraph_Stub alias "IBaseFilter_JoinFilterGraph_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBaseFilter_QueryVendorInfo_Proxy alias "IBaseFilter_QueryVendorInfo_Proxy" (byval This as IBaseFilter ptr, byval pVendorInfo as LPWSTR ptr) as HRESULT
declare sub IBaseFilter_QueryVendorInfo_Stub alias "IBaseFilter_QueryVendorInfo_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type PFILTER as IBaseFilter ptr

#ifndef __win_dsound_bi__
extern IID_IReferenceClock alias "IID_IReferenceClock" as IID

type IReferenceClockVtbl_ as IReferenceClockVtbl

type IReferenceClock
	lpVtbl as IReferenceClockVtbl_ ptr
end type

type IReferenceClockVtbl
	QueryInterface as function(byval as IReferenceClock ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IReferenceClock ptr) as ULONG
	Release as function(byval as IReferenceClock ptr) as ULONG
	GetTime as function(byval as IReferenceClock ptr, byval as REFERENCE_TIME ptr) as HRESULT
	AdviseTime as function(byval as IReferenceClock ptr, byval as REFERENCE_TIME, byval as REFERENCE_TIME, byval as HEVENT, byval as DWORD_PTR ptr) as HRESULT
	AdvisePeriodic as function(byval as IReferenceClock ptr, byval as REFERENCE_TIME, byval as REFERENCE_TIME, byval as HSEMAPHORE, byval as DWORD_PTR ptr) as HRESULT
	Unadvise as function(byval as IReferenceClock ptr, byval as DWORD_PTR) as HRESULT
end type
#endif

#ifdef WIN_INCLUDEPROXY
declare function IReferenceClock_GetTime_Proxy alias "IReferenceClock_GetTime_Proxy" (byval This as IReferenceClock ptr, byval pTime as REFERENCE_TIME ptr) as HRESULT
declare sub IReferenceClock_GetTime_Stub alias "IReferenceClock_GetTime_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IReferenceClock_AdviseTime_Proxy alias "IReferenceClock_AdviseTime_Proxy" (byval This as IReferenceClock ptr, byval baseTime as REFERENCE_TIME, byval streamTime as REFERENCE_TIME, byval hEvent as HEVENT, byval pdwAdviseCookie as DWORD_PTR ptr) as HRESULT
declare sub IReferenceClock_AdviseTime_Stub alias "IReferenceClock_AdviseTime_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IReferenceClock_AdvisePeriodic_Proxy alias "IReferenceClock_AdvisePeriodic_Proxy" (byval This as IReferenceClock ptr, byval startTime as REFERENCE_TIME, byval periodTime as REFERENCE_TIME, byval hSemaphore as HSEMAPHORE, byval pdwAdviseCookie as DWORD_PTR ptr) as HRESULT
declare sub IReferenceClock_AdvisePeriodic_Stub alias "IReferenceClock_AdvisePeriodic_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IReferenceClock_Unadvise_Proxy alias "IReferenceClock_Unadvise_Proxy" (byval This as IReferenceClock ptr, byval dwAdviseCookie as DWORD_PTR) as HRESULT
declare sub IReferenceClock_Unadvise_Stub alias "IReferenceClock_Unadvise_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type PREFERENCECLOCK as IReferenceClock ptr

extern IID_IReferenceClock2 alias "IID_IReferenceClock2" as IID

type IReferenceClock2Vtbl_ as IReferenceClock2Vtbl

type IReferenceClock2
	lpVtbl as IReferenceClock2Vtbl_ ptr
end type

type IReferenceClock2Vtbl
	QueryInterface as function(byval as IReferenceClock2 ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IReferenceClock2 ptr) as ULONG
	Release as function(byval as IReferenceClock2 ptr) as ULONG
	GetTime as function(byval as IReferenceClock2 ptr, byval as REFERENCE_TIME ptr) as HRESULT
	AdviseTime as function(byval as IReferenceClock2 ptr, byval as REFERENCE_TIME, byval as REFERENCE_TIME, byval as HEVENT, byval as DWORD_PTR ptr) as HRESULT
	AdvisePeriodic as function(byval as IReferenceClock2 ptr, byval as REFERENCE_TIME, byval as REFERENCE_TIME, byval as HSEMAPHORE, byval as DWORD_PTR ptr) as HRESULT
	Unadvise as function(byval as IReferenceClock2 ptr, byval as DWORD_PTR) as HRESULT
end type

type PREFERENCECLOCK2 as IReferenceClock2 ptr

extern IID_IMediaSample alias "IID_IMediaSample" as IID

type IMediaSampleVtbl_ as IMediaSampleVtbl

type IMediaSample
	lpVtbl as IMediaSampleVtbl_ ptr
end type

type IMediaSampleVtbl
	QueryInterface as function(byval as IMediaSample ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IMediaSample ptr) as ULONG
	Release as function(byval as IMediaSample ptr) as ULONG
	GetPointer as function(byval as IMediaSample ptr, byval as BYTE ptr ptr) as HRESULT
	GetSize as function(byval as IMediaSample ptr) as integer
	GetTime as function(byval as IMediaSample ptr, byval as REFERENCE_TIME ptr, byval as REFERENCE_TIME ptr) as HRESULT
	SetTime as function(byval as IMediaSample ptr, byval as REFERENCE_TIME ptr, byval as REFERENCE_TIME ptr) as HRESULT
	IsSyncPoint as function(byval as IMediaSample ptr) as HRESULT
	SetSyncPoint as function(byval as IMediaSample ptr, byval as BOOL) as HRESULT
	IsPreroll as function(byval as IMediaSample ptr) as HRESULT
	SetPreroll as function(byval as IMediaSample ptr, byval as BOOL) as HRESULT
	GetActualDataLength as function(byval as IMediaSample ptr) as integer
	SetActualDataLength as function(byval as IMediaSample ptr, byval as integer) as HRESULT
	GetMediaType as function(byval as IMediaSample ptr, byval as AM_MEDIA_TYPE ptr ptr) as HRESULT
	SetMediaType as function(byval as IMediaSample ptr, byval as AM_MEDIA_TYPE ptr) as HRESULT
	IsDiscontinuity as function(byval as IMediaSample ptr) as HRESULT
	SetDiscontinuity as function(byval as IMediaSample ptr, byval as BOOL) as HRESULT
	GetMediaTime as function(byval as IMediaSample ptr, byval as LONGLONG ptr, byval as LONGLONG ptr) as HRESULT
	SetMediaTime as function(byval as IMediaSample ptr, byval as LONGLONG ptr, byval as LONGLONG ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IMediaSample_GetPointer_Proxy alias "IMediaSample_GetPointer_Proxy" (byval This as IMediaSample ptr, byval ppBuffer as BYTE ptr ptr) as HRESULT
declare sub IMediaSample_GetPointer_Stub alias "IMediaSample_GetPointer_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaSample_GetSize_Proxy alias "IMediaSample_GetSize_Proxy" (byval This as IMediaSample ptr) as integer
declare sub IMediaSample_GetSize_Stub alias "IMediaSample_GetSize_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaSample_GetTime_Proxy alias "IMediaSample_GetTime_Proxy" (byval This as IMediaSample ptr, byval pTimeStart as REFERENCE_TIME ptr, byval pTimeEnd as REFERENCE_TIME ptr) as HRESULT
declare sub IMediaSample_GetTime_Stub alias "IMediaSample_GetTime_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaSample_SetTime_Proxy alias "IMediaSample_SetTime_Proxy" (byval This as IMediaSample ptr, byval pTimeStart as REFERENCE_TIME ptr, byval pTimeEnd as REFERENCE_TIME ptr) as HRESULT
declare sub IMediaSample_SetTime_Stub alias "IMediaSample_SetTime_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaSample_IsSyncPoint_Proxy alias "IMediaSample_IsSyncPoint_Proxy" (byval This as IMediaSample ptr) as HRESULT
declare sub IMediaSample_IsSyncPoint_Stub alias "IMediaSample_IsSyncPoint_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaSample_SetSyncPoint_Proxy alias "IMediaSample_SetSyncPoint_Proxy" (byval This as IMediaSample ptr, byval bIsSyncPoint as BOOL) as HRESULT
declare sub IMediaSample_SetSyncPoint_Stub alias "IMediaSample_SetSyncPoint_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaSample_IsPreroll_Proxy alias "IMediaSample_IsPreroll_Proxy" (byval This as IMediaSample ptr) as HRESULT
declare sub IMediaSample_IsPreroll_Stub alias "IMediaSample_IsPreroll_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaSample_SetPreroll_Proxy alias "IMediaSample_SetPreroll_Proxy" (byval This as IMediaSample ptr, byval bIsPreroll as BOOL) as HRESULT
declare sub IMediaSample_SetPreroll_Stub alias "IMediaSample_SetPreroll_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaSample_GetActualDataLength_Proxy alias "IMediaSample_GetActualDataLength_Proxy" (byval This as IMediaSample ptr) as integer
declare sub IMediaSample_GetActualDataLength_Stub alias "IMediaSample_GetActualDataLength_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaSample_SetActualDataLength_Proxy alias "IMediaSample_SetActualDataLength_Proxy" (byval This as IMediaSample ptr, byval __MIDL_0010 as integer) as HRESULT
declare sub IMediaSample_SetActualDataLength_Stub alias "IMediaSample_SetActualDataLength_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaSample_GetMediaType_Proxy alias "IMediaSample_GetMediaType_Proxy" (byval This as IMediaSample ptr, byval ppMediaType as AM_MEDIA_TYPE ptr ptr) as HRESULT
declare sub IMediaSample_GetMediaType_Stub alias "IMediaSample_GetMediaType_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaSample_SetMediaType_Proxy alias "IMediaSample_SetMediaType_Proxy" (byval This as IMediaSample ptr, byval pMediaType as AM_MEDIA_TYPE ptr) as HRESULT
declare sub IMediaSample_SetMediaType_Stub alias "IMediaSample_SetMediaType_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaSample_IsDiscontinuity_Proxy alias "IMediaSample_IsDiscontinuity_Proxy" (byval This as IMediaSample ptr) as HRESULT
declare sub IMediaSample_IsDiscontinuity_Stub alias "IMediaSample_IsDiscontinuity_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaSample_SetDiscontinuity_Proxy alias "IMediaSample_SetDiscontinuity_Proxy" (byval This as IMediaSample ptr, byval bDiscontinuity as BOOL) as HRESULT
declare sub IMediaSample_SetDiscontinuity_Stub alias "IMediaSample_SetDiscontinuity_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaSample_GetMediaTime_Proxy alias "IMediaSample_GetMediaTime_Proxy" (byval This as IMediaSample ptr, byval pTimeStart as LONGLONG ptr, byval pTimeEnd as LONGLONG ptr) as HRESULT
declare sub IMediaSample_GetMediaTime_Stub alias "IMediaSample_GetMediaTime_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaSample_SetMediaTime_Proxy alias "IMediaSample_SetMediaTime_Proxy" (byval This as IMediaSample ptr, byval pTimeStart as LONGLONG ptr, byval pTimeEnd as LONGLONG ptr) as HRESULT
declare sub IMediaSample_SetMediaTime_Stub alias "IMediaSample_SetMediaTime_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type PMEDIASAMPLE as IMediaSample ptr

enum AM_SAMPLE_PROPERTY_FLAGS
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

type AM_SAMPLE2_PROPERTIES
	cbData as DWORD
	dwTypeSpecificFlags as DWORD
	dwSampleFlags as DWORD
	lActual as LONG
	tStart as REFERENCE_TIME
	tStop as REFERENCE_TIME
	dwStreamId as DWORD
	pMediaType as AM_MEDIA_TYPE ptr
	pbBuffer as BYTE ptr
	cbBuffer as LONG
end type

extern IID_IMediaSample2 alias "IID_IMediaSample2" as IID

type IMediaSample2Vtbl_ as IMediaSample2Vtbl

type IMediaSample2
	lpVtbl as IMediaSample2Vtbl_ ptr
end type

type IMediaSample2Vtbl
	QueryInterface as function(byval as IMediaSample2 ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IMediaSample2 ptr) as ULONG
	Release as function(byval as IMediaSample2 ptr) as ULONG
	GetPointer as function(byval as IMediaSample2 ptr, byval as BYTE ptr ptr) as HRESULT
	GetSize as function(byval as IMediaSample2 ptr) as integer
	GetTime as function(byval as IMediaSample2 ptr, byval as REFERENCE_TIME ptr, byval as REFERENCE_TIME ptr) as HRESULT
	SetTime as function(byval as IMediaSample2 ptr, byval as REFERENCE_TIME ptr, byval as REFERENCE_TIME ptr) as HRESULT
	IsSyncPoint as function(byval as IMediaSample2 ptr) as HRESULT
	SetSyncPoint as function(byval as IMediaSample2 ptr, byval as BOOL) as HRESULT
	IsPreroll as function(byval as IMediaSample2 ptr) as HRESULT
	SetPreroll as function(byval as IMediaSample2 ptr, byval as BOOL) as HRESULT
	GetActualDataLength as function(byval as IMediaSample2 ptr) as integer
	SetActualDataLength as function(byval as IMediaSample2 ptr, byval as integer) as HRESULT
	GetMediaType as function(byval as IMediaSample2 ptr, byval as AM_MEDIA_TYPE ptr ptr) as HRESULT
	SetMediaType as function(byval as IMediaSample2 ptr, byval as AM_MEDIA_TYPE ptr) as HRESULT
	IsDiscontinuity as function(byval as IMediaSample2 ptr) as HRESULT
	SetDiscontinuity as function(byval as IMediaSample2 ptr, byval as BOOL) as HRESULT
	GetMediaTime as function(byval as IMediaSample2 ptr, byval as LONGLONG ptr, byval as LONGLONG ptr) as HRESULT
	SetMediaTime as function(byval as IMediaSample2 ptr, byval as LONGLONG ptr, byval as LONGLONG ptr) as HRESULT
	GetProperties as function(byval as IMediaSample2 ptr, byval as DWORD, byval as BYTE ptr) as HRESULT
	SetProperties as function(byval as IMediaSample2 ptr, byval as DWORD, byval as BYTE ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IMediaSample2_GetProperties_Proxy alias "IMediaSample2_GetProperties_Proxy" (byval This as IMediaSample2 ptr, byval cbProperties as DWORD, byval pbProperties as BYTE ptr) as HRESULT
declare sub IMediaSample2_GetProperties_Stub alias "IMediaSample2_GetProperties_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaSample2_SetProperties_Proxy alias "IMediaSample2_SetProperties_Proxy" (byval This as IMediaSample2 ptr, byval cbProperties as DWORD, byval pbProperties as BYTE ptr) as HRESULT
declare sub IMediaSample2_SetProperties_Stub alias "IMediaSample2_SetProperties_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type PMEDIASAMPLE2 as IMediaSample2 ptr

#define AM_GBF_PREVFRAMESKIPPED 1
#define AM_GBF_NOTASYNCPOINT 2
#define AM_GBF_NOWAIT 4
#define AM_GBF_NODDSURFACELOCK 8
extern IID_IMemAllocator alias "IID_IMemAllocator" as IID

type IMemAllocatorVtbl_ as IMemAllocatorVtbl

type IMemAllocator
	lpVtbl as IMemAllocatorVtbl_ ptr
end type

type IMemAllocatorVtbl
	QueryInterface as function(byval as IMemAllocator ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IMemAllocator ptr) as ULONG
	Release as function(byval as IMemAllocator ptr) as ULONG
	SetProperties as function(byval as IMemAllocator ptr, byval as ALLOCATOR_PROPERTIES ptr, byval as ALLOCATOR_PROPERTIES ptr) as HRESULT
	GetProperties as function(byval as IMemAllocator ptr, byval as ALLOCATOR_PROPERTIES ptr) as HRESULT
	Commit as function(byval as IMemAllocator ptr) as HRESULT
	Decommit as function(byval as IMemAllocator ptr) as HRESULT
	GetBuffer as function(byval as IMemAllocator ptr, byval as IMediaSample ptr ptr, byval as REFERENCE_TIME ptr, byval as REFERENCE_TIME ptr, byval as DWORD) as HRESULT
	ReleaseBuffer as function(byval as IMemAllocator ptr, byval as IMediaSample ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IMemAllocator_SetProperties_Proxy alias "IMemAllocator_SetProperties_Proxy" (byval This as IMemAllocator ptr, byval pRequest as ALLOCATOR_PROPERTIES ptr, byval pActual as ALLOCATOR_PROPERTIES ptr) as HRESULT
declare sub IMemAllocator_SetProperties_Stub alias "IMemAllocator_SetProperties_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMemAllocator_GetProperties_Proxy alias "IMemAllocator_GetProperties_Proxy" (byval This as IMemAllocator ptr, byval pProps as ALLOCATOR_PROPERTIES ptr) as HRESULT
declare sub IMemAllocator_GetProperties_Stub alias "IMemAllocator_GetProperties_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMemAllocator_Commit_Proxy alias "IMemAllocator_Commit_Proxy" (byval This as IMemAllocator ptr) as HRESULT
declare sub IMemAllocator_Commit_Stub alias "IMemAllocator_Commit_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMemAllocator_Decommit_Proxy alias "IMemAllocator_Decommit_Proxy" (byval This as IMemAllocator ptr) as HRESULT
declare sub IMemAllocator_Decommit_Stub alias "IMemAllocator_Decommit_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMemAllocator_GetBuffer_Proxy alias "IMemAllocator_GetBuffer_Proxy" (byval This as IMemAllocator ptr, byval ppBuffer as IMediaSample ptr ptr, byval pStartTime as REFERENCE_TIME ptr, byval pEndTime as REFERENCE_TIME ptr, byval dwFlags as DWORD) as HRESULT
declare sub IMemAllocator_GetBuffer_Stub alias "IMemAllocator_GetBuffer_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMemAllocator_ReleaseBuffer_Proxy alias "IMemAllocator_ReleaseBuffer_Proxy" (byval This as IMemAllocator ptr, byval pBuffer as IMediaSample ptr) as HRESULT
declare sub IMemAllocator_ReleaseBuffer_Stub alias "IMemAllocator_ReleaseBuffer_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type PMEMALLOCATOR as IMemAllocator ptr
extern IID_IMemAllocatorCallbackTemp alias "IID_IMemAllocatorCallbackTemp" as IID

type IMemAllocatorCallbackTempVtbl_ as IMemAllocatorCallbackTempVtbl

type IMemAllocatorCallbackTemp
	lpVtbl as IMemAllocatorCallbackTempVtbl_ ptr
end type

type IMemAllocatorCallbackTempVtbl
	QueryInterface as function(byval as IMemAllocatorCallbackTemp ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IMemAllocatorCallbackTemp ptr) as ULONG
	Release as function(byval as IMemAllocatorCallbackTemp ptr) as ULONG
	SetProperties as function(byval as IMemAllocatorCallbackTemp ptr, byval as ALLOCATOR_PROPERTIES ptr, byval as ALLOCATOR_PROPERTIES ptr) as HRESULT
	GetProperties as function(byval as IMemAllocatorCallbackTemp ptr, byval as ALLOCATOR_PROPERTIES ptr) as HRESULT
	Commit as function(byval as IMemAllocatorCallbackTemp ptr) as HRESULT
	Decommit as function(byval as IMemAllocatorCallbackTemp ptr) as HRESULT
	GetBuffer as function(byval as IMemAllocatorCallbackTemp ptr, byval as IMediaSample ptr ptr, byval as REFERENCE_TIME ptr, byval as REFERENCE_TIME ptr, byval as DWORD) as HRESULT
	ReleaseBuffer as function(byval as IMemAllocatorCallbackTemp ptr, byval as IMediaSample ptr) as HRESULT
	SetNotify as function(byval as IMemAllocatorCallbackTemp ptr, byval as IMemAllocatorNotifyCallbackTemp_ ptr) as HRESULT
	GetFreeCount as function(byval as IMemAllocatorCallbackTemp ptr, byval as LONG ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IMemAllocatorCallbackTemp_SetNotify_Proxy alias "IMemAllocatorCallbackTemp_SetNotify_Proxy" (byval This as IMemAllocatorCallbackTemp ptr, byval pNotify as IMemAllocatorNotifyCallbackTemp ptr) as HRESULT
declare sub IMemAllocatorCallbackTemp_SetNotify_Stub alias "IMemAllocatorCallbackTemp_SetNotify_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMemAllocatorCallbackTemp_GetFreeCount_Proxy alias "IMemAllocatorCallbackTemp_GetFreeCount_Proxy" (byval This as IMemAllocatorCallbackTemp ptr, byval plBuffersFree as LONG ptr) as HRESULT
declare sub IMemAllocatorCallbackTemp_GetFreeCount_Stub alias "IMemAllocatorCallbackTemp_GetFreeCount_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

extern IID_IMemAllocatorNotifyCallbackTemp alias "IID_IMemAllocatorNotifyCallbackTemp" as IID

type IMemAllocatorNotifyCallbackTempVtbl_ as IMemAllocatorNotifyCallbackTempVtbl

type IMemAllocatorNotifyCallbackTemp
	lpVtbl as IMemAllocatorNotifyCallbackTempVtbl_ ptr
end type

type IMemAllocatorNotifyCallbackTempVtbl
	QueryInterface as function(byval as IMemAllocatorNotifyCallbackTemp ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IMemAllocatorNotifyCallbackTemp ptr) as ULONG
	Release as function(byval as IMemAllocatorNotifyCallbackTemp ptr) as ULONG
	NotifyRelease as function(byval as IMemAllocatorNotifyCallbackTemp ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IMemAllocatorNotifyCallbackTemp_NotifyRelease_Proxy alias "IMemAllocatorNotifyCallbackTemp_NotifyRelease_Proxy" (byval This as IMemAllocatorNotifyCallbackTemp ptr) as HRESULT
declare sub IMemAllocatorNotifyCallbackTemp_NotifyRelease_Stub alias "IMemAllocatorNotifyCallbackTemp_NotifyRelease_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

extern IID_IMemInputPin alias "IID_IMemInputPin" as IID

type IMemInputPinVtbl_ as IMemInputPinVtbl

type IMemInputPin
	lpVtbl as IMemInputPinVtbl_ ptr
end type

type IMemInputPinVtbl
	QueryInterface as function(byval as IMemInputPin ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IMemInputPin ptr) as ULONG
	Release as function(byval as IMemInputPin ptr) as ULONG
	GetAllocator as function(byval as IMemInputPin ptr, byval as IMemAllocator ptr ptr) as HRESULT
	NotifyAllocator as function(byval as IMemInputPin ptr, byval as IMemAllocator ptr, byval as BOOL) as HRESULT
	GetAllocatorRequirements as function(byval as IMemInputPin ptr, byval as ALLOCATOR_PROPERTIES ptr) as HRESULT
	Receive as function(byval as IMemInputPin ptr, byval as IMediaSample ptr) as HRESULT
	ReceiveMultiple as function(byval as IMemInputPin ptr, byval as IMediaSample ptr ptr, byval as integer, byval as integer ptr) as HRESULT
	ReceiveCanBlock as function(byval as IMemInputPin ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IMemInputPin_GetAllocator_Proxy alias "IMemInputPin_GetAllocator_Proxy" (byval This as IMemInputPin ptr, byval ppAllocator as IMemAllocator ptr ptr) as HRESULT
declare sub IMemInputPin_GetAllocator_Stub alias "IMemInputPin_GetAllocator_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMemInputPin_NotifyAllocator_Proxy alias "IMemInputPin_NotifyAllocator_Proxy" (byval This as IMemInputPin ptr, byval pAllocator as IMemAllocator ptr, byval bReadOnly as BOOL) as HRESULT
declare sub IMemInputPin_NotifyAllocator_Stub alias "IMemInputPin_NotifyAllocator_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMemInputPin_GetAllocatorRequirements_Proxy alias "IMemInputPin_GetAllocatorRequirements_Proxy" (byval This as IMemInputPin ptr, byval pProps as ALLOCATOR_PROPERTIES ptr) as HRESULT
declare sub IMemInputPin_GetAllocatorRequirements_Stub alias "IMemInputPin_GetAllocatorRequirements_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMemInputPin_Receive_Proxy alias "IMemInputPin_Receive_Proxy" (byval This as IMemInputPin ptr, byval pSample as IMediaSample ptr) as HRESULT
declare sub IMemInputPin_Receive_Stub alias "IMemInputPin_Receive_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMemInputPin_ReceiveMultiple_Proxy alias "IMemInputPin_ReceiveMultiple_Proxy" (byval This as IMemInputPin ptr, byval pSamples as IMediaSample ptr ptr, byval nSamples as integer, byval nSamplesProcessed as integer ptr) as HRESULT
declare sub IMemInputPin_ReceiveMultiple_Stub alias "IMemInputPin_ReceiveMultiple_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMemInputPin_ReceiveCanBlock_Proxy alias "IMemInputPin_ReceiveCanBlock_Proxy" (byval This as IMemInputPin ptr) as HRESULT
declare sub IMemInputPin_ReceiveCanBlock_Stub alias "IMemInputPin_ReceiveCanBlock_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type PMEMINPUTPIN as IMemInputPin ptr
extern IID_IAMovieSetup alias "IID_IAMovieSetup" as IID

type IAMovieSetupVtbl_ as IAMovieSetupVtbl

type IAMovieSetup
	lpVtbl as IAMovieSetupVtbl_ ptr
end type

type IAMovieSetupVtbl
	QueryInterface as function(byval as IAMovieSetup ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMovieSetup ptr) as ULONG
	Release as function(byval as IAMovieSetup ptr) as ULONG
	Register as function(byval as IAMovieSetup ptr) as HRESULT
	Unregister as function(byval as IAMovieSetup ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMovieSetup_Register_Proxy alias "IAMovieSetup_Register_Proxy" (byval This as IAMovieSetup ptr) as HRESULT
declare sub IAMovieSetup_Register_Stub alias "IAMovieSetup_Register_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMovieSetup_Unregister_Proxy alias "IAMovieSetup_Unregister_Proxy" (byval This as IAMovieSetup ptr) as HRESULT
declare sub IAMovieSetup_Unregister_Stub alias "IAMovieSetup_Unregister_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type PAMOVIESETUP as IAMovieSetup ptr

enum AM_SEEKING_SEEKING_FLAGS
	AM_SEEKING_NoPositioning = 0
	AM_SEEKING_AbsolutePositioning = &h1
	AM_SEEKING_RelativePositioning = &h2
	AM_SEEKING_IncrementalPositioning = &h3
	AM_SEEKING_PositioningBitsMask = &h3
	AM_SEEKING_SeekToKeyFrame = &h4
	AM_SEEKING_ReturnTime = &h8
	AM_SEEKING_Segment = &h10
	AM_SEEKING_NoFlush = &h20
end enum

enum AM_SEEKING_SEEKING_CAPABILITIES
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

extern IID_IMediaSeeking alias "IID_IMediaSeeking" as IID

type IMediaSeekingVtbl_ as IMediaSeekingVtbl

type IMediaSeeking
	lpVtbl as IMediaSeekingVtbl_ ptr
end type

type IMediaSeekingVtbl
	QueryInterface as function(byval as IMediaSeeking ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IMediaSeeking ptr) as ULONG
	Release as function(byval as IMediaSeeking ptr) as ULONG
	GetCapabilities as function(byval as IMediaSeeking ptr, byval as DWORD ptr) as HRESULT
	CheckCapabilities as function(byval as IMediaSeeking ptr, byval as DWORD ptr) as HRESULT
	IsFormatSupported as function(byval as IMediaSeeking ptr, byval as GUID ptr) as HRESULT
	QueryPreferredFormat as function(byval as IMediaSeeking ptr, byval as GUID ptr) as HRESULT
	GetTimeFormatA as function(byval as IMediaSeeking ptr, byval as GUID ptr) as HRESULT
	IsUsingTimeFormat as function(byval as IMediaSeeking ptr, byval as GUID ptr) as HRESULT
	SetTimeFormat as function(byval as IMediaSeeking ptr, byval as GUID ptr) as HRESULT
	GetDuration as function(byval as IMediaSeeking ptr, byval as LONGLONG ptr) as HRESULT
	GetStopPosition as function(byval as IMediaSeeking ptr, byval as LONGLONG ptr) as HRESULT
	GetCurrentPosition as function(byval as IMediaSeeking ptr, byval as LONGLONG ptr) as HRESULT
	ConvertTimeFormat as function(byval as IMediaSeeking ptr, byval as LONGLONG ptr, byval as GUID ptr, byval as LONGLONG, byval as GUID ptr) as HRESULT
	SetPositions as function(byval as IMediaSeeking ptr, byval as LONGLONG ptr, byval as DWORD, byval as LONGLONG ptr, byval as DWORD) as HRESULT
	GetPositions as function(byval as IMediaSeeking ptr, byval as LONGLONG ptr, byval as LONGLONG ptr) as HRESULT
	GetAvailable as function(byval as IMediaSeeking ptr, byval as LONGLONG ptr, byval as LONGLONG ptr) as HRESULT
	SetRate as function(byval as IMediaSeeking ptr, byval as double) as HRESULT
	GetRate as function(byval as IMediaSeeking ptr, byval as double ptr) as HRESULT
	GetPreroll as function(byval as IMediaSeeking ptr, byval as LONGLONG ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IMediaSeeking_GetCapabilities_Proxy alias "IMediaSeeking_GetCapabilities_Proxy" (byval This as IMediaSeeking ptr, byval pCapabilities as DWORD ptr) as HRESULT
declare sub IMediaSeeking_GetCapabilities_Stub alias "IMediaSeeking_GetCapabilities_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaSeeking_CheckCapabilities_Proxy alias "IMediaSeeking_CheckCapabilities_Proxy" (byval This as IMediaSeeking ptr, byval pCapabilities as DWORD ptr) as HRESULT
declare sub IMediaSeeking_CheckCapabilities_Stub alias "IMediaSeeking_CheckCapabilities_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaSeeking_IsFormatSupported_Proxy alias "IMediaSeeking_IsFormatSupported_Proxy" (byval This as IMediaSeeking ptr, byval pFormat as GUID ptr) as HRESULT
declare sub IMediaSeeking_IsFormatSupported_Stub alias "IMediaSeeking_IsFormatSupported_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaSeeking_QueryPreferredFormat_Proxy alias "IMediaSeeking_QueryPreferredFormat_Proxy" (byval This as IMediaSeeking ptr, byval pFormat as GUID ptr) as HRESULT
declare sub IMediaSeeking_QueryPreferredFormat_Stub alias "IMediaSeeking_QueryPreferredFormat_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaSeeking_GetTimeFormat_Proxy alias "IMediaSeeking_GetTimeFormat_Proxy" (byval This as IMediaSeeking ptr, byval pFormat as GUID ptr) as HRESULT
declare sub IMediaSeeking_GetTimeFormat_Stub alias "IMediaSeeking_GetTimeFormat_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaSeeking_IsUsingTimeFormat_Proxy alias "IMediaSeeking_IsUsingTimeFormat_Proxy" (byval This as IMediaSeeking ptr, byval pFormat as GUID ptr) as HRESULT
declare sub IMediaSeeking_IsUsingTimeFormat_Stub alias "IMediaSeeking_IsUsingTimeFormat_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaSeeking_SetTimeFormat_Proxy alias "IMediaSeeking_SetTimeFormat_Proxy" (byval This as IMediaSeeking ptr, byval pFormat as GUID ptr) as HRESULT
declare sub IMediaSeeking_SetTimeFormat_Stub alias "IMediaSeeking_SetTimeFormat_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaSeeking_GetDuration_Proxy alias "IMediaSeeking_GetDuration_Proxy" (byval This as IMediaSeeking ptr, byval pDuration as LONGLONG ptr) as HRESULT
declare sub IMediaSeeking_GetDuration_Stub alias "IMediaSeeking_GetDuration_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaSeeking_GetStopPosition_Proxy alias "IMediaSeeking_GetStopPosition_Proxy" (byval This as IMediaSeeking ptr, byval pStop as LONGLONG ptr) as HRESULT
declare sub IMediaSeeking_GetStopPosition_Stub alias "IMediaSeeking_GetStopPosition_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaSeeking_GetCurrentPosition_Proxy alias "IMediaSeeking_GetCurrentPosition_Proxy" (byval This as IMediaSeeking ptr, byval pCurrent as LONGLONG ptr) as HRESULT
declare sub IMediaSeeking_GetCurrentPosition_Stub alias "IMediaSeeking_GetCurrentPosition_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaSeeking_ConvertTimeFormat_Proxy alias "IMediaSeeking_ConvertTimeFormat_Proxy" (byval This as IMediaSeeking ptr, byval pTarget as LONGLONG ptr, byval pTargetFormat as GUID ptr, byval Source as LONGLONG, byval pSourceFormat as GUID ptr) as HRESULT
declare sub IMediaSeeking_ConvertTimeFormat_Stub alias "IMediaSeeking_ConvertTimeFormat_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaSeeking_SetPositions_Proxy alias "IMediaSeeking_SetPositions_Proxy" (byval This as IMediaSeeking ptr, byval pCurrent as LONGLONG ptr, byval dwCurrentFlags as DWORD, byval pStop as LONGLONG ptr, byval dwStopFlags as DWORD) as HRESULT
declare sub IMediaSeeking_SetPositions_Stub alias "IMediaSeeking_SetPositions_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaSeeking_GetPositions_Proxy alias "IMediaSeeking_GetPositions_Proxy" (byval This as IMediaSeeking ptr, byval pCurrent as LONGLONG ptr, byval pStop as LONGLONG ptr) as HRESULT
declare sub IMediaSeeking_GetPositions_Stub alias "IMediaSeeking_GetPositions_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaSeeking_GetAvailable_Proxy alias "IMediaSeeking_GetAvailable_Proxy" (byval This as IMediaSeeking ptr, byval pEarliest as LONGLONG ptr, byval pLatest as LONGLONG ptr) as HRESULT
declare sub IMediaSeeking_GetAvailable_Stub alias "IMediaSeeking_GetAvailable_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaSeeking_SetRate_Proxy alias "IMediaSeeking_SetRate_Proxy" (byval This as IMediaSeeking ptr, byval dRate as double) as HRESULT
declare sub IMediaSeeking_SetRate_Stub alias "IMediaSeeking_SetRate_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaSeeking_GetRate_Proxy alias "IMediaSeeking_GetRate_Proxy" (byval This as IMediaSeeking ptr, byval pdRate as double ptr) as HRESULT
declare sub IMediaSeeking_GetRate_Stub alias "IMediaSeeking_GetRate_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMediaSeeking_GetPreroll_Proxy alias "IMediaSeeking_GetPreroll_Proxy" (byval This as IMediaSeeking ptr, byval pllPreroll as LONGLONG ptr) as HRESULT
declare sub IMediaSeeking_GetPreroll_Stub alias "IMediaSeeking_GetPreroll_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type PMEDIASEEKING as IMediaSeeking ptr

enum tagAM_MEDIAEVENT_FLAGS
	AM_MEDIAEVENT_NONOTIFY = &h01
end enum

type REGFILTER
	Clsid as CLSID
	Name as LPWSTR
end type

extern IID_IEnumRegFilters alias "IID_IEnumRegFilters" as IID

type IEnumRegFiltersVtbl_ as IEnumRegFiltersVtbl

type IEnumRegFilters
	lpVtbl as IEnumRegFiltersVtbl_ ptr
end type

type IEnumRegFiltersVtbl
	QueryInterface as function(byval as IEnumRegFilters ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IEnumRegFilters ptr) as ULONG
	Release as function(byval as IEnumRegFilters ptr) as ULONG
	Next as function(byval as IEnumRegFilters ptr, byval as ULONG, byval as REGFILTER ptr ptr, byval as ULONG ptr) as HRESULT
	Skip as function(byval as IEnumRegFilters ptr, byval as ULONG) as HRESULT
	Reset as function(byval as IEnumRegFilters ptr) as HRESULT
	Clone as function(byval as IEnumRegFilters ptr, byval as IEnumRegFilters ptr ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IEnumRegFilters_Next_Proxy alias "IEnumRegFilters_Next_Proxy" (byval This as IEnumRegFilters ptr, byval cFilters as ULONG, byval apRegFilter as REGFILTER ptr ptr, byval pcFetched as ULONG ptr) as HRESULT
declare sub IEnumRegFilters_Next_Stub alias "IEnumRegFilters_Next_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEnumRegFilters_Skip_Proxy alias "IEnumRegFilters_Skip_Proxy" (byval This as IEnumRegFilters ptr, byval cFilters as ULONG) as HRESULT
declare sub IEnumRegFilters_Skip_Stub alias "IEnumRegFilters_Skip_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEnumRegFilters_Reset_Proxy alias "IEnumRegFilters_Reset_Proxy" (byval This as IEnumRegFilters ptr) as HRESULT
declare sub IEnumRegFilters_Reset_Stub alias "IEnumRegFilters_Reset_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEnumRegFilters_Clone_Proxy alias "IEnumRegFilters_Clone_Proxy" (byval This as IEnumRegFilters ptr, byval ppEnum as IEnumRegFilters ptr ptr) as HRESULT
declare sub IEnumRegFilters_Clone_Stub alias "IEnumRegFilters_Clone_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
type PENUMREGFILTERS as IEnumRegFilters ptr

enum IFilterMapper_0001
	MERIT_PREFERRED = &h800000
	MERIT_NORMAL = &h600000
	MERIT_UNLIKELY = &h400000
	MERIT_DO_NOT_USE = &h200000
	MERIT_SW_COMPRESSOR = &h100000
	MERIT_HW_COMPRESSOR = &h100050
end enum

extern IID_IFilterMapper alias "IID_IFilterMapper" as IID

type IFilterMapperVtbl_ as IFilterMapperVtbl

type IFilterMapper
	lpVtbl as IFilterMapperVtbl_ ptr
end type

type IFilterMapperVtbl
	QueryInterface as function(byval as IFilterMapper ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IFilterMapper ptr) as ULONG
	Release as function(byval as IFilterMapper ptr) as ULONG
	RegisterFilter as function(byval as IFilterMapper ptr, byval as CLSID, byval as LPCWSTR, byval as DWORD) as HRESULT
	RegisterFilterInstance as function(byval as IFilterMapper ptr, byval as CLSID, byval as LPCWSTR, byval as CLSID ptr) as HRESULT
	RegisterPin as function(byval as IFilterMapper ptr, byval as CLSID, byval as LPCWSTR, byval as BOOL, byval as BOOL, byval as BOOL, byval as BOOL, byval as CLSID, byval as LPCWSTR) as HRESULT
	RegisterPinType as function(byval as IFilterMapper ptr, byval as CLSID, byval as LPCWSTR, byval as CLSID, byval as CLSID) as HRESULT
	UnregisterFilter as function(byval as IFilterMapper ptr, byval as CLSID) as HRESULT
	UnregisterFilterInstance as function(byval as IFilterMapper ptr, byval as CLSID) as HRESULT
	UnregisterPin as function(byval as IFilterMapper ptr, byval as CLSID, byval as LPCWSTR) as HRESULT
	EnumMatchingFilters as function(byval as IFilterMapper ptr, byval as IEnumRegFilters ptr ptr, byval as DWORD, byval as BOOL, byval as CLSID, byval as CLSID, byval as BOOL, byval as BOOL, byval as CLSID, byval as CLSID) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IFilterMapper_RegisterFilter_Proxy alias "IFilterMapper_RegisterFilter_Proxy" (byval This as IFilterMapper ptr, byval clsid as CLSID, byval Name as LPCWSTR, byval dwMerit as DWORD) as HRESULT
declare sub IFilterMapper_RegisterFilter_Stub alias "IFilterMapper_RegisterFilter_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFilterMapper_RegisterFilterInstance_Proxy alias "IFilterMapper_RegisterFilterInstance_Proxy" (byval This as IFilterMapper ptr, byval clsid as CLSID, byval Name as LPCWSTR, byval MRId as CLSID ptr) as HRESULT
declare sub IFilterMapper_RegisterFilterInstance_Stub alias "IFilterMapper_RegisterFilterInstance_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFilterMapper_RegisterPin_Proxy alias "IFilterMapper_RegisterPin_Proxy" (byval This as IFilterMapper ptr, byval Filter as CLSID, byval Name as LPCWSTR, byval bRendered as BOOL, byval bOutput as BOOL, byval bZero as BOOL, byval bMany as BOOL, byval ConnectsToFilter as CLSID, byval ConnectsToPin as LPCWSTR) as HRESULT
declare sub IFilterMapper_RegisterPin_Stub alias "IFilterMapper_RegisterPin_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFilterMapper_RegisterPinType_Proxy alias "IFilterMapper_RegisterPinType_Proxy" (byval This as IFilterMapper ptr, byval clsFilter as CLSID, byval strName as LPCWSTR, byval clsMajorType as CLSID, byval clsSubType as CLSID) as HRESULT
declare sub IFilterMapper_RegisterPinType_Stub alias "IFilterMapper_RegisterPinType_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFilterMapper_UnregisterFilter_Proxy alias "IFilterMapper_UnregisterFilter_Proxy" (byval This as IFilterMapper ptr, byval Filter as CLSID) as HRESULT
declare sub IFilterMapper_UnregisterFilter_Stub alias "IFilterMapper_UnregisterFilter_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFilterMapper_UnregisterFilterInstance_Proxy alias "IFilterMapper_UnregisterFilterInstance_Proxy" (byval This as IFilterMapper ptr, byval MRId as CLSID) as HRESULT
declare sub IFilterMapper_UnregisterFilterInstance_Stub alias "IFilterMapper_UnregisterFilterInstance_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFilterMapper_UnregisterPin_Proxy alias "IFilterMapper_UnregisterPin_Proxy" (byval This as IFilterMapper ptr, byval Filter as CLSID, byval Name as LPCWSTR) as HRESULT
declare sub IFilterMapper_UnregisterPin_Stub alias "IFilterMapper_UnregisterPin_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFilterMapper_EnumMatchingFilters_Proxy alias "IFilterMapper_EnumMatchingFilters_Proxy" (byval This as IFilterMapper ptr, byval ppEnum as IEnumRegFilters ptr ptr, byval dwMerit as DWORD, byval bInputNeeded as BOOL, byval clsInMaj as CLSID, byval clsInSub as CLSID, byval bRender as BOOL, byval bOututNeeded as BOOL, byval clsOutMaj as CLSID, byval clsOutSub as CLSID) as HRESULT
declare sub IFilterMapper_EnumMatchingFilters_Stub alias "IFilterMapper_EnumMatchingFilters_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type REGPINTYPES
	clsMajorType as CLSID ptr
	clsMinorType as CLSID ptr
end type

type REGFILTERPINS
	strName as LPWSTR
	bRendered as BOOL
	bOutput as BOOL
	bZero as BOOL
	bMany as BOOL
	clsConnectsToFilter as CLSID ptr
	strConnectsToPin as WCHAR ptr
	nMediaTypes as UINT
	lpMediaType as REGPINTYPES ptr
end type

type REGPINMEDIUM
	clsMedium as CLSID
	dw1 as DWORD
	dw2 as DWORD
end type

enum REG_PINFLAG_FLAGS
	REG_PINFLAG_B_ZERO = &h1
	REG_PINFLAG_B_RENDERER = &h2
	REG_PINFLAG_B_MANY = &h4
	REG_PINFLAG_B_OUTPUT = &h8
end enum

type REGFILTERPINS2
	dwFlags as DWORD
	cInstances as UINT
	nMediaTypes as UINT
	lpMediaType as REGPINTYPES ptr
	nMediums as UINT
	lpMedium as REGPINMEDIUM ptr
	clsPinCategory as CLSID ptr
end type

type REGFILTER2
	dwVersion as DWORD
	dwMerit as DWORD
end type

extern IID_IFilterMapper2 alias "IID_IFilterMapper2" as IID

type IFilterMapper2Vtbl_ as IFilterMapper2Vtbl

type IFilterMapper2
	lpVtbl as IFilterMapper2Vtbl_ ptr
end type

type IFilterMapper2Vtbl
	QueryInterface as function(byval as IFilterMapper2 ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IFilterMapper2 ptr) as ULONG
	Release as function(byval as IFilterMapper2 ptr) as ULONG
	CreateCategory as function(byval as IFilterMapper2 ptr, byval as CLSID ptr, byval as DWORD, byval as LPCWSTR) as HRESULT
	UnregisterFilter as function(byval as IFilterMapper2 ptr, byval as CLSID ptr, byval as OLECHAR ptr, byval as CLSID ptr) as HRESULT
	RegisterFilter as function(byval as IFilterMapper2 ptr, byval as CLSID ptr, byval as LPCWSTR, byval as IMoniker ptr ptr, byval as CLSID ptr, byval as OLECHAR ptr, byval as REGFILTER2 ptr) as HRESULT
	EnumMatchingFilters as function(byval as IFilterMapper2 ptr, byval as IEnumMoniker ptr ptr, byval as DWORD, byval as BOOL, byval as DWORD, byval as BOOL, byval as DWORD, byval as GUID ptr, byval as REGPINMEDIUM ptr, byval as CLSID ptr, byval as BOOL, byval as BOOL, byval as DWORD, byval as GUID ptr, byval as REGPINMEDIUM ptr, byval as CLSID ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IFilterMapper2_CreateCategory_Proxy alias "IFilterMapper2_CreateCategory_Proxy" (byval This as IFilterMapper2 ptr, byval clsidCategory as CLSID ptr, byval dwCategoryMerit as DWORD, byval Description as LPCWSTR) as HRESULT
declare sub IFilterMapper2_CreateCategory_Stub alias "IFilterMapper2_CreateCategory_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFilterMapper2_UnregisterFilter_Proxy alias "IFilterMapper2_UnregisterFilter_Proxy" (byval This as IFilterMapper2 ptr, byval pclsidCategory as CLSID ptr, byval szInstance as OLECHAR ptr, byval Filter as CLSID ptr) as HRESULT
declare sub IFilterMapper2_UnregisterFilter_Stub alias "IFilterMapper2_UnregisterFilter_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFilterMapper2_RegisterFilter_Proxy alias "IFilterMapper2_RegisterFilter_Proxy" (byval This as IFilterMapper2 ptr, byval clsidFilter as CLSID ptr, byval Name as LPCWSTR, byval ppMoniker as IMoniker ptr ptr, byval pclsidCategory as CLSID ptr, byval szInstance as OLECHAR ptr, byval prf2 as REGFILTER2 ptr) as HRESULT
declare sub IFilterMapper2_RegisterFilter_Stub alias "IFilterMapper2_RegisterFilter_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFilterMapper2_EnumMatchingFilters_Proxy alias "IFilterMapper2_EnumMatchingFilters_Proxy" (byval This as IFilterMapper2 ptr, byval ppEnum as IEnumMoniker ptr ptr, byval dwFlags as DWORD, byval bExactMatch as BOOL, byval dwMerit as DWORD, byval bInputNeeded as BOOL, byval cInputTypes as DWORD, byval pInputTypes as GUID ptr, byval pMedIn as REGPINMEDIUM ptr, byval pPinCategoryIn as CLSID ptr, byval bRender as BOOL, byval bOutputNeeded as BOOL, byval cOutputTypes as DWORD, byval pOutputTypes as GUID ptr, byval pMedOut as REGPINMEDIUM ptr, byval pPinCategoryOut as CLSID ptr) as HRESULT
declare sub IFilterMapper2_EnumMatchingFilters_Stub alias "IFilterMapper2_EnumMatchingFilters_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IFilterMapper3 alias "IID_IFilterMapper3" as IID

type IFilterMapper3Vtbl_ as IFilterMapper3Vtbl

type IFilterMapper3
	lpVtbl as IFilterMapper3Vtbl_ ptr
end type

type IFilterMapper3Vtbl
	QueryInterface as function(byval as IFilterMapper3 ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IFilterMapper3 ptr) as ULONG
	Release as function(byval as IFilterMapper3 ptr) as ULONG
	CreateCategory as function(byval as IFilterMapper3 ptr, byval as CLSID ptr, byval as DWORD, byval as LPCWSTR) as HRESULT
	UnregisterFilter as function(byval as IFilterMapper3 ptr, byval as CLSID ptr, byval as OLECHAR ptr, byval as CLSID ptr) as HRESULT
	RegisterFilter as function(byval as IFilterMapper3 ptr, byval as CLSID ptr, byval as LPCWSTR, byval as IMoniker ptr ptr, byval as CLSID ptr, byval as OLECHAR ptr, byval as REGFILTER2 ptr) as HRESULT
	EnumMatchingFilters as function(byval as IFilterMapper3 ptr, byval as IEnumMoniker ptr ptr, byval as DWORD, byval as BOOL, byval as DWORD, byval as BOOL, byval as DWORD, byval as GUID ptr, byval as REGPINMEDIUM ptr, byval as CLSID ptr, byval as BOOL, byval as BOOL, byval as DWORD, byval as GUID ptr, byval as REGPINMEDIUM ptr, byval as CLSID ptr) as HRESULT
	GetICreateDevEnum as function(byval as IFilterMapper3 ptr, byval as ICreateDevEnum ptr ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IFilterMapper3_GetICreateDevEnum_Proxy alias "IFilterMapper3_GetICreateDevEnum_Proxy" (byval This as IFilterMapper3 ptr, byval ppEnum as ICreateDevEnum ptr ptr) as HRESULT
declare sub IFilterMapper3_GetICreateDevEnum_Stub alias "IFilterMapper3_GetICreateDevEnum_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

enum QualityMessageType
	Famine = 0
	Flood = Famine+1
end enum

type Quality
	Type as QualityMessageType
	Proportion as integer
	Late as REFERENCE_TIME
	TimeStamp as REFERENCE_TIME
end type

type PQUALITYCONTROL as IQualityControl ptr
extern IID_IQualityControl alias "IID_IQualityControl" as IID

type IQualityControlVtbl_ as IQualityControlVtbl

type IQualityControl
	lpVtbl as IQualityControlVtbl_ ptr
end type

type IQualityControlVtbl
	QueryInterface as function(byval as IQualityControl ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IQualityControl ptr) as ULONG
	Release as function(byval as IQualityControl ptr) as ULONG
	Notify as function(byval as IQualityControl ptr, byval as IBaseFilter ptr, byval as Quality) as HRESULT
	SetSink as function(byval as IQualityControl ptr, byval as IQualityControl ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IQualityControl_Notify_Proxy alias "IQualityControl_Notify_Proxy" (byval This as IQualityControl ptr, byval pSelf as IBaseFilter ptr, byval q as Quality) as HRESULT
declare sub IQualityControl_Notify_Stub alias "IQualityControl_Notify_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IQualityControl_SetSink_Proxy alias "IQualityControl_SetSink_Proxy" (byval This as IQualityControl ptr, byval piqc as IQualityControl ptr) as HRESULT
declare sub IQualityControl_SetSink_Stub alias "IQualityControl_SetSink_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

enum CK_ENUM
	CK_NOCOLORKEY = 0
	CK_INDEX = &h1
	CK_RGB = &h2
end enum

type COLORKEY
	KeyType as DWORD
	PaletteIndex as DWORD
	LowColorValue as COLORREF
	HighColorValue as COLORREF
end type

enum ADVISE_FLAGS
	ADVISE_NONE = 0
	ADVISE_CLIPPING = &h1
	ADVISE_PALETTE = &h2
	ADVISE_COLORKEY = &h4
	ADVISE_POSITION = &h8
	ADVISE_DISPLAY_CHANGE = &h10
end enum

extern IID_IOverlayNotify alias "IID_IOverlayNotify" as IID

type IOverlayNotifyVtbl_ as IOverlayNotifyVtbl

type IOverlayNotify
	lpVtbl as IOverlayNotifyVtbl_ ptr
end type

type IOverlayNotifyVtbl
	QueryInterface as function(byval as IOverlayNotify ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IOverlayNotify ptr) as ULONG
	Release as function(byval as IOverlayNotify ptr) as ULONG
	OnPaletteChange as function(byval as IOverlayNotify ptr, byval as DWORD, byval as PALETTEENTRY ptr) as HRESULT
	OnClipChange as function(byval as IOverlayNotify ptr, byval as RECT ptr, byval as RECT ptr, byval as RGNDATA ptr) as HRESULT
	OnColorKeyChange as function(byval as IOverlayNotify ptr, byval as COLORKEY ptr) as HRESULT
	OnPositionChange as function(byval as IOverlayNotify ptr, byval as RECT ptr, byval as RECT ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IOverlayNotify_OnPaletteChange_Proxy alias "IOverlayNotify_OnPaletteChange_Proxy" (byval This as IOverlayNotify ptr, byval dwColors as DWORD, byval pPalette as PALETTEENTRY ptr) as HRESULT
declare sub IOverlayNotify_OnPaletteChange_Stub alias "IOverlayNotify_OnPaletteChange_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IOverlayNotify_OnClipChange_Proxy alias "IOverlayNotify_OnClipChange_Proxy" (byval This as IOverlayNotify ptr, byval pSourceRect as RECT ptr, byval pDestinationRect as RECT ptr, byval pRgnData as RGNDATA ptr) as HRESULT
declare sub IOverlayNotify_OnClipChange_Stub alias "IOverlayNotify_OnClipChange_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IOverlayNotify_OnColorKeyChange_Proxy alias "IOverlayNotify_OnColorKeyChange_Proxy" (byval This as IOverlayNotify ptr, byval pColorKey as COLORKEY ptr) as HRESULT
declare sub IOverlayNotify_OnColorKeyChange_Stub alias "IOverlayNotify_OnColorKeyChange_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IOverlayNotify_OnPositionChange_Proxy alias "IOverlayNotify_OnPositionChange_Proxy" (byval This as IOverlayNotify ptr, byval pSourceRect as RECT ptr, byval pDestinationRect as RECT ptr) as HRESULT
declare sub IOverlayNotify_OnPositionChange_Stub alias "IOverlayNotify_OnPositionChange_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
type POVERLAYNOTIFY as IOverlayNotify ptr
extern IID_IOverlayNotify2 alias "IID_IOverlayNotify2" as IID

type IOverlayNotify2Vtbl_ as IOverlayNotify2Vtbl

type IOverlayNotify2
	lpVtbl as IOverlayNotify2Vtbl_ ptr
end type

type IOverlayNotify2Vtbl
	QueryInterface as function(byval as IOverlayNotify2 ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IOverlayNotify2 ptr) as ULONG
	Release as function(byval as IOverlayNotify2 ptr) as ULONG
	OnPaletteChange as function(byval as IOverlayNotify2 ptr, byval as DWORD, byval as PALETTEENTRY ptr) as HRESULT
	OnClipChange as function(byval as IOverlayNotify2 ptr, byval as RECT ptr, byval as RECT ptr, byval as RGNDATA ptr) as HRESULT
	OnColorKeyChange as function(byval as IOverlayNotify2 ptr, byval as COLORKEY ptr) as HRESULT
	OnPositionChange as function(byval as IOverlayNotify2 ptr, byval as RECT ptr, byval as RECT ptr) as HRESULT
	OnDisplayChange as function(byval as IOverlayNotify2 ptr, byval as HMONITOR) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IOverlayNotify2_OnDisplayChange_Proxy alias "IOverlayNotify2_OnDisplayChange_Proxy" (byval This as IOverlayNotify2 ptr, byval hMonitor as HMONITOR) as HRESULT
declare sub IOverlayNotify2_OnDisplayChange_Stub alias "IOverlayNotify2_OnDisplayChange_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
type POVERLAYNOTIFY2 as IOverlayNotify2 ptr
extern IID_IOverlay alias "IID_IOverlay" as IID

type IOverlayVtbl_ as IOverlayVtbl

type IOverlay
	lpVtbl as IOverlayVtbl_ ptr
end type

type IOverlayVtbl
	QueryInterface as function(byval as IOverlay ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IOverlay ptr) as ULONG
	Release as function(byval as IOverlay ptr) as ULONG
	GetPalette as function(byval as IOverlay ptr, byval as DWORD ptr, byval as PALETTEENTRY ptr ptr) as HRESULT
	SetPalette as function(byval as IOverlay ptr, byval as DWORD, byval as PALETTEENTRY ptr) as HRESULT
	GetDefaultColorKey as function(byval as IOverlay ptr, byval as COLORKEY ptr) as HRESULT
	GetColorKey as function(byval as IOverlay ptr, byval as COLORKEY ptr) as HRESULT
	SetColorKey as function(byval as IOverlay ptr, byval as COLORKEY ptr) as HRESULT
	GetWindowHandle as function(byval as IOverlay ptr, byval as HWND ptr) as HRESULT
	GetClipList as function(byval as IOverlay ptr, byval as RECT ptr, byval as RECT ptr, byval as RGNDATA ptr ptr) as HRESULT
	GetVideoPosition as function(byval as IOverlay ptr, byval as RECT ptr, byval as RECT ptr) as HRESULT
	Advise as function(byval as IOverlay ptr, byval as IOverlayNotify ptr, byval as DWORD) as HRESULT
	Unadvise as function(byval as IOverlay ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IOverlay_GetPalette_Proxy alias "IOverlay_GetPalette_Proxy" (byval This as IOverlay ptr, byval pdwColors as DWORD ptr, byval ppPalette as PALETTEENTRY ptr ptr) as HRESULT
declare sub IOverlay_GetPalette_Stub alias "IOverlay_GetPalette_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IOverlay_SetPalette_Proxy alias "IOverlay_SetPalette_Proxy" (byval This as IOverlay ptr, byval dwColors as DWORD, byval pPalette as PALETTEENTRY ptr) as HRESULT
declare sub IOverlay_SetPalette_Stub alias "IOverlay_SetPalette_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IOverlay_GetDefaultColorKey_Proxy alias "IOverlay_GetDefaultColorKey_Proxy" (byval This as IOverlay ptr, byval pColorKey as COLORKEY ptr) as HRESULT
declare sub IOverlay_GetDefaultColorKey_Stub alias "IOverlay_GetDefaultColorKey_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IOverlay_GetColorKey_Proxy alias "IOverlay_GetColorKey_Proxy" (byval This as IOverlay ptr, byval pColorKey as COLORKEY ptr) as HRESULT
declare sub IOverlay_GetColorKey_Stub alias "IOverlay_GetColorKey_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IOverlay_SetColorKey_Proxy alias "IOverlay_SetColorKey_Proxy" (byval This as IOverlay ptr, byval pColorKey as COLORKEY ptr) as HRESULT
declare sub IOverlay_SetColorKey_Stub alias "IOverlay_SetColorKey_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IOverlay_GetWindowHandle_Proxy alias "IOverlay_GetWindowHandle_Proxy" (byval This as IOverlay ptr, byval pHwnd as HWND ptr) as HRESULT
declare sub IOverlay_GetWindowHandle_Stub alias "IOverlay_GetWindowHandle_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IOverlay_GetClipList_Proxy alias "IOverlay_GetClipList_Proxy" (byval This as IOverlay ptr, byval pSourceRect as RECT ptr, byval pDestinationRect as RECT ptr, byval ppRgnData as RGNDATA ptr ptr) as HRESULT
declare sub IOverlay_GetClipList_Stub alias "IOverlay_GetClipList_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IOverlay_GetVideoPosition_Proxy alias "IOverlay_GetVideoPosition_Proxy" (byval This as IOverlay ptr, byval pSourceRect as RECT ptr, byval pDestinationRect as RECT ptr) as HRESULT
declare sub IOverlay_GetVideoPosition_Stub alias "IOverlay_GetVideoPosition_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IOverlay_Advise_Proxy alias "IOverlay_Advise_Proxy" (byval This as IOverlay ptr, byval pOverlayNotify as IOverlayNotify ptr, byval dwInterests as DWORD) as HRESULT
declare sub IOverlay_Advise_Stub alias "IOverlay_Advise_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IOverlay_Unadvise_Proxy alias "IOverlay_Unadvise_Proxy" (byval This as IOverlay ptr) as HRESULT
declare sub IOverlay_Unadvise_Stub alias "IOverlay_Unadvise_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
type POVERLAY as IOverlay ptr
extern IID_IMediaEventSink alias "IID_IMediaEventSink" as IID

type IMediaEventSinkVtbl_ as IMediaEventSinkVtbl

type IMediaEventSink
	lpVtbl as IMediaEventSinkVtbl_ ptr
end type

type IMediaEventSinkVtbl
	QueryInterface as function(byval as IMediaEventSink ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IMediaEventSink ptr) as ULONG
	Release as function(byval as IMediaEventSink ptr) as ULONG
	Notify as function(byval as IMediaEventSink ptr, byval as integer, byval as LONG_PTR, byval as LONG_PTR) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IMediaEventSink_Notify_Proxy alias "IMediaEventSink_Notify_Proxy" (byval This as IMediaEventSink ptr, byval EventCode as integer, byval EventParam1 as LONG_PTR, byval EventParam2 as LONG_PTR) as HRESULT
declare sub IMediaEventSink_Notify_Stub alias "IMediaEventSink_Notify_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type PMEDIAEVENTSINK as IMediaEventSink ptr
extern IID_IFileSourceFilter alias "IID_IFileSourceFilter" as IID

type IFileSourceFilterVtbl_ as IFileSourceFilterVtbl

type IFileSourceFilter
	lpVtbl as IFileSourceFilterVtbl_ ptr
end type

type IFileSourceFilterVtbl
	QueryInterface as function(byval as IFileSourceFilter ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IFileSourceFilter ptr) as ULONG
	Release as function(byval as IFileSourceFilter ptr) as ULONG
	Load as function(byval as IFileSourceFilter ptr, byval as LPCOLESTR, byval as AM_MEDIA_TYPE ptr) as HRESULT
	GetCurFile as function(byval as IFileSourceFilter ptr, byval as LPOLESTR ptr, byval as AM_MEDIA_TYPE ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IFileSourceFilter_Load_Proxy alias "IFileSourceFilter_Load_Proxy" (byval This as IFileSourceFilter ptr, byval pszFileName as LPCOLESTR, byval pmt as AM_MEDIA_TYPE ptr) as HRESULT
declare sub IFileSourceFilter_Load_Stub alias "IFileSourceFilter_Load_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFileSourceFilter_GetCurFile_Proxy alias "IFileSourceFilter_GetCurFile_Proxy" (byval This as IFileSourceFilter ptr, byval ppszFileName as LPOLESTR ptr, byval pmt as AM_MEDIA_TYPE ptr) as HRESULT
declare sub IFileSourceFilter_GetCurFile_Stub alias "IFileSourceFilter_GetCurFile_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type PFILTERFILESOURCE as IFileSourceFilter ptr
extern IID_IFileSinkFilter alias "IID_IFileSinkFilter" as IID

type IFileSinkFilterVtbl_ as IFileSinkFilterVtbl

type IFileSinkFilter
	lpVtbl as IFileSinkFilterVtbl_ ptr
end type

type IFileSinkFilterVtbl
	QueryInterface as function(byval as IFileSinkFilter ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IFileSinkFilter ptr) as ULONG
	Release as function(byval as IFileSinkFilter ptr) as ULONG
	SetFileName as function(byval as IFileSinkFilter ptr, byval as LPCOLESTR, byval as AM_MEDIA_TYPE ptr) as HRESULT
	GetCurFile as function(byval as IFileSinkFilter ptr, byval as LPOLESTR ptr, byval as AM_MEDIA_TYPE ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IFileSinkFilter_SetFileName_Proxy alias "IFileSinkFilter_SetFileName_Proxy" (byval This as IFileSinkFilter ptr, byval pszFileName as LPCOLESTR, byval pmt as AM_MEDIA_TYPE ptr) as HRESULT
declare sub IFileSinkFilter_SetFileName_Stub alias "IFileSinkFilter_SetFileName_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFileSinkFilter_GetCurFile_Proxy alias "IFileSinkFilter_GetCurFile_Proxy" (byval This as IFileSinkFilter ptr, byval ppszFileName as LPOLESTR ptr, byval pmt as AM_MEDIA_TYPE ptr) as HRESULT
declare sub IFileSinkFilter_GetCurFile_Stub alias "IFileSinkFilter_GetCurFile_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type PFILTERFILESINK as IFileSinkFilter ptr
extern IID_IFileSinkFilter2 alias "IID_IFileSinkFilter2" as IID

type IFileSinkFilter2Vtbl_ as IFileSinkFilter2Vtbl

type IFileSinkFilter2
	lpVtbl as IFileSinkFilter2Vtbl_ ptr
end type

type IFileSinkFilter2Vtbl
	QueryInterface as function(byval as IFileSinkFilter2 ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IFileSinkFilter2 ptr) as ULONG
	Release as function(byval as IFileSinkFilter2 ptr) as ULONG
	SetFileName as function(byval as IFileSinkFilter2 ptr, byval as LPCOLESTR, byval as AM_MEDIA_TYPE ptr) as HRESULT
	GetCurFile as function(byval as IFileSinkFilter2 ptr, byval as LPOLESTR ptr, byval as AM_MEDIA_TYPE ptr) as HRESULT
	SetMode as function(byval as IFileSinkFilter2 ptr, byval as DWORD) as HRESULT
	GetMode as function(byval as IFileSinkFilter2 ptr, byval as DWORD ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IFileSinkFilter2_SetMode_Proxy alias "IFileSinkFilter2_SetMode_Proxy" (byval This as IFileSinkFilter2 ptr, byval dwFlags as DWORD) as HRESULT
declare sub IFileSinkFilter2_SetMode_Stub alias "IFileSinkFilter2_SetMode_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFileSinkFilter2_GetMode_Proxy alias "IFileSinkFilter2_GetMode_Proxy" (byval This as IFileSinkFilter2 ptr, byval pdwFlags as DWORD ptr) as HRESULT
declare sub IFileSinkFilter2_GetMode_Stub alias "IFileSinkFilter2_GetMode_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type PFILESINKFILTER2 as IFileSinkFilter2 ptr

enum AM_FILESINK_FLAGS
	AM_FILE_OVERWRITE = &h1
end enum

extern IID_IGraphBuilder alias "IID_IGraphBuilder" as IID

type IGraphBuilderVtbl_ as IGraphBuilderVtbl

type IGraphBuilder
	lpVtbl as IGraphBuilderVtbl_ ptr
end type

type IGraphBuilderVtbl
	QueryInterface as function(byval as IGraphBuilder ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IGraphBuilder ptr) as ULONG
	Release as function(byval as IGraphBuilder ptr) as ULONG
	AddFilter as function(byval as IGraphBuilder ptr, byval as IBaseFilter ptr, byval as LPCWSTR) as HRESULT
	RemoveFilter as function(byval as IGraphBuilder ptr, byval as IBaseFilter ptr) as HRESULT
	EnumFilters as function(byval as IGraphBuilder ptr, byval as IEnumFilters ptr ptr) as HRESULT
	FindFilterByName as function(byval as IGraphBuilder ptr, byval as LPCWSTR, byval as IBaseFilter ptr ptr) as HRESULT
	ConnectDirect as function(byval as IGraphBuilder ptr, byval as IPin ptr, byval as IPin ptr, byval as AM_MEDIA_TYPE ptr) as HRESULT
	Reconnect as function(byval as IGraphBuilder ptr, byval as IPin ptr) as HRESULT
	Disconnect as function(byval as IGraphBuilder ptr, byval as IPin ptr) as HRESULT
	SetDefaultSyncSource as function(byval as IGraphBuilder ptr) as HRESULT
	Connect as function(byval as IGraphBuilder ptr, byval as IPin ptr, byval as IPin ptr) as HRESULT
	Render as function(byval as IGraphBuilder ptr, byval as IPin ptr) as HRESULT
	RenderFile as function(byval as IGraphBuilder ptr, byval as LPCWSTR, byval as LPCWSTR) as HRESULT
	AddSourceFilter as function(byval as IGraphBuilder ptr, byval as LPCWSTR, byval as LPCWSTR, byval as IBaseFilter ptr ptr) as HRESULT
	SetLogFile as function(byval as IGraphBuilder ptr, byval as DWORD_PTR) as HRESULT
	Abort as function(byval as IGraphBuilder ptr) as HRESULT
	ShouldOperationContinue as function(byval as IGraphBuilder ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IGraphBuilder_Connect_Proxy alias "IGraphBuilder_Connect_Proxy" (byval This as IGraphBuilder ptr, byval ppinOut as IPin ptr, byval ppinIn as IPin ptr) as HRESULT
declare sub IGraphBuilder_Connect_Stub alias "IGraphBuilder_Connect_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IGraphBuilder_Render_Proxy alias "IGraphBuilder_Render_Proxy" (byval This as IGraphBuilder ptr, byval ppinOut as IPin ptr) as HRESULT
declare sub IGraphBuilder_Render_Stub alias "IGraphBuilder_Render_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IGraphBuilder_RenderFile_Proxy alias "IGraphBuilder_RenderFile_Proxy" (byval This as IGraphBuilder ptr, byval lpcwstrFile as LPCWSTR, byval lpcwstrPlayList as LPCWSTR) as HRESULT
declare sub IGraphBuilder_RenderFile_Stub alias "IGraphBuilder_RenderFile_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IGraphBuilder_AddSourceFilter_Proxy alias "IGraphBuilder_AddSourceFilter_Proxy" (byval This as IGraphBuilder ptr, byval lpcwstrFileName as LPCWSTR, byval lpcwstrFilterName as LPCWSTR, byval ppFilter as IBaseFilter ptr ptr) as HRESULT
declare sub IGraphBuilder_AddSourceFilter_Stub alias "IGraphBuilder_AddSourceFilter_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IGraphBuilder_SetLogFile_Proxy alias "IGraphBuilder_SetLogFile_Proxy" (byval This as IGraphBuilder ptr, byval hFile as DWORD_PTR) as HRESULT
declare sub IGraphBuilder_SetLogFile_Stub alias "IGraphBuilder_SetLogFile_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IGraphBuilder_Abort_Proxy alias "IGraphBuilder_Abort_Proxy" (byval This as IGraphBuilder ptr) as HRESULT
declare sub IGraphBuilder_Abort_Stub alias "IGraphBuilder_Abort_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IGraphBuilder_ShouldOperationContinue_Proxy alias "IGraphBuilder_ShouldOperationContinue_Proxy" (byval This as IGraphBuilder ptr) as HRESULT
declare sub IGraphBuilder_ShouldOperationContinue_Stub alias "IGraphBuilder_ShouldOperationContinue_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_ICaptureGraphBuilder alias "IID_ICaptureGraphBuilder" as IID

type ICaptureGraphBuilderVtbl_ as ICaptureGraphBuilderVtbl

type ICaptureGraphBuilder
	lpVtbl as ICaptureGraphBuilderVtbl_ ptr
end type

type ICaptureGraphBuilderVtbl
	QueryInterface as function(byval as ICaptureGraphBuilder ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as ICaptureGraphBuilder ptr) as ULONG
	Release as function(byval as ICaptureGraphBuilder ptr) as ULONG
	SetFiltergraph as function(byval as ICaptureGraphBuilder ptr, byval as IGraphBuilder ptr) as HRESULT
	GetFiltergraph as function(byval as ICaptureGraphBuilder ptr, byval as IGraphBuilder ptr ptr) as HRESULT
	SetOutputFileName as function(byval as ICaptureGraphBuilder ptr, byval as GUID ptr, byval as LPCOLESTR, byval as IBaseFilter ptr ptr, byval as IFileSinkFilter ptr ptr) as HRESULT
	FindInterface as function(byval as ICaptureGraphBuilder ptr, byval as GUID ptr, byval as IBaseFilter ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	RenderStream as function(byval as ICaptureGraphBuilder ptr, byval as GUID ptr, byval as IUnknown ptr, byval as IBaseFilter ptr, byval as IBaseFilter ptr) as HRESULT
	ControlStream as function(byval as ICaptureGraphBuilder ptr, byval as GUID ptr, byval as IBaseFilter ptr, byval as REFERENCE_TIME ptr, byval as REFERENCE_TIME ptr, byval as WORD, byval as WORD) as HRESULT
	AllocCapFile as function(byval as ICaptureGraphBuilder ptr, byval as LPCOLESTR, byval as DWORDLONG) as HRESULT
	CopyCaptureFile as function(byval as ICaptureGraphBuilder ptr, byval as LPOLESTR, byval as LPOLESTR, byval as integer, byval as IAMCopyCaptureFileProgress_ ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function ICaptureGraphBuilder_SetFiltergraph_Proxy alias "ICaptureGraphBuilder_SetFiltergraph_Proxy" (byval This as ICaptureGraphBuilder ptr, byval pfg as IGraphBuilder ptr) as HRESULT
declare sub ICaptureGraphBuilder_SetFiltergraph_Stub alias "ICaptureGraphBuilder_SetFiltergraph_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICaptureGraphBuilder_GetFiltergraph_Proxy alias "ICaptureGraphBuilder_GetFiltergraph_Proxy" (byval This as ICaptureGraphBuilder ptr, byval ppfg as IGraphBuilder ptr ptr) as HRESULT
declare sub ICaptureGraphBuilder_GetFiltergraph_Stub alias "ICaptureGraphBuilder_GetFiltergraph_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICaptureGraphBuilder_SetOutputFileName_Proxy alias "ICaptureGraphBuilder_SetOutputFileName_Proxy" (byval This as ICaptureGraphBuilder ptr, byval pType as GUID ptr, byval lpstrFile as LPCOLESTR, byval ppf as IBaseFilter ptr ptr, byval ppSink as IFileSinkFilter ptr ptr) as HRESULT
declare sub ICaptureGraphBuilder_SetOutputFileName_Stub alias "ICaptureGraphBuilder_SetOutputFileName_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICaptureGraphBuilder_RemoteFindInterface_Proxy alias "ICaptureGraphBuilder_RemoteFindInterface_Proxy" (byval This as ICaptureGraphBuilder ptr, byval pCategory as GUID ptr, byval pf as IBaseFilter ptr, byval riid as IID ptr, byval ppint as IUnknown ptr ptr) as HRESULT
declare sub ICaptureGraphBuilder_RemoteFindInterface_Stub alias "ICaptureGraphBuilder_RemoteFindInterface_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICaptureGraphBuilder_RenderStream_Proxy alias "ICaptureGraphBuilder_RenderStream_Proxy" (byval This as ICaptureGraphBuilder ptr, byval pCategory as GUID ptr, byval pSource as IUnknown ptr, byval pfCompressor as IBaseFilter ptr, byval pfRenderer as IBaseFilter ptr) as HRESULT
declare sub ICaptureGraphBuilder_RenderStream_Stub alias "ICaptureGraphBuilder_RenderStream_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICaptureGraphBuilder_ControlStream_Proxy alias "ICaptureGraphBuilder_ControlStream_Proxy" (byval This as ICaptureGraphBuilder ptr, byval pCategory as GUID ptr, byval pFilter as IBaseFilter ptr, byval pstart as REFERENCE_TIME ptr, byval pstop as REFERENCE_TIME ptr, byval wStartCookie as WORD, byval wStopCookie as WORD) as HRESULT
declare sub ICaptureGraphBuilder_ControlStream_Stub alias "ICaptureGraphBuilder_ControlStream_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICaptureGraphBuilder_AllocCapFile_Proxy alias "ICaptureGraphBuilder_AllocCapFile_Proxy" (byval This as ICaptureGraphBuilder ptr, byval lpstr as LPCOLESTR, byval dwlSize as DWORDLONG) as HRESULT
declare sub ICaptureGraphBuilder_AllocCapFile_Stub alias "ICaptureGraphBuilder_AllocCapFile_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICaptureGraphBuilder_CopyCaptureFile_Proxy alias "ICaptureGraphBuilder_CopyCaptureFile_Proxy" (byval This as ICaptureGraphBuilder ptr, byval lpwstrOld as LPOLESTR, byval lpwstrNew as LPOLESTR, byval fAllowEscAbort as integer, byval pCallback as IAMCopyCaptureFileProgress ptr) as HRESULT
declare sub ICaptureGraphBuilder_CopyCaptureFile_Stub alias "ICaptureGraphBuilder_CopyCaptureFile_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IAMCopyCaptureFileProgress alias "IID_IAMCopyCaptureFileProgress" as IID

type IAMCopyCaptureFileProgressVtbl_ as IAMCopyCaptureFileProgressVtbl

type IAMCopyCaptureFileProgress
	lpVtbl as IAMCopyCaptureFileProgressVtbl_ ptr
end type

type IAMCopyCaptureFileProgressVtbl
	QueryInterface as function(byval as IAMCopyCaptureFileProgress ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMCopyCaptureFileProgress ptr) as ULONG
	Release as function(byval as IAMCopyCaptureFileProgress ptr) as ULONG
	Progress as function(byval as IAMCopyCaptureFileProgress ptr, byval as integer) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMCopyCaptureFileProgress_Progress_Proxy alias "IAMCopyCaptureFileProgress_Progress_Proxy" (byval This as IAMCopyCaptureFileProgress ptr, byval iProgress as integer) as HRESULT
declare sub IAMCopyCaptureFileProgress_Progress_Stub alias "IAMCopyCaptureFileProgress_Progress_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_ICaptureGraphBuilder2 alias "IID_ICaptureGraphBuilder2" as IID

type ICaptureGraphBuilder2Vtbl_ as ICaptureGraphBuilder2Vtbl

type ICaptureGraphBuilder2
	lpVtbl as ICaptureGraphBuilder2Vtbl_ ptr
end type

type ICaptureGraphBuilder2Vtbl
	QueryInterface as function(byval as ICaptureGraphBuilder2 ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as ICaptureGraphBuilder2 ptr) as ULONG
	Release as function(byval as ICaptureGraphBuilder2 ptr) as ULONG
	SetFiltergraph as function(byval as ICaptureGraphBuilder2 ptr, byval as IGraphBuilder ptr) as HRESULT
	GetFiltergraph as function(byval as ICaptureGraphBuilder2 ptr, byval as IGraphBuilder ptr ptr) as HRESULT
	SetOutputFileName as function(byval as ICaptureGraphBuilder2 ptr, byval as GUID ptr, byval as LPCOLESTR, byval as IBaseFilter ptr ptr, byval as IFileSinkFilter ptr ptr) as HRESULT
	FindInterface as function(byval as ICaptureGraphBuilder2 ptr, byval as GUID ptr, byval as GUID ptr, byval as IBaseFilter ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	RenderStream as function(byval as ICaptureGraphBuilder2 ptr, byval as GUID ptr, byval as GUID ptr, byval as IUnknown ptr, byval as IBaseFilter ptr, byval as IBaseFilter ptr) as HRESULT
	ControlStream as function(byval as ICaptureGraphBuilder2 ptr, byval as GUID ptr, byval as GUID ptr, byval as IBaseFilter ptr, byval as REFERENCE_TIME ptr, byval as REFERENCE_TIME ptr, byval as WORD, byval as WORD) as HRESULT
	AllocCapFile as function(byval as ICaptureGraphBuilder2 ptr, byval as LPCOLESTR, byval as DWORDLONG) as HRESULT
	CopyCaptureFile as function(byval as ICaptureGraphBuilder2 ptr, byval as LPOLESTR, byval as LPOLESTR, byval as integer, byval as IAMCopyCaptureFileProgress ptr) as HRESULT
	FindPin as function(byval as ICaptureGraphBuilder2 ptr, byval as IUnknown ptr, byval as PIN_DIRECTION, byval as GUID ptr, byval as GUID ptr, byval as BOOL, byval as integer, byval as IPin ptr ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function ICaptureGraphBuilder2_SetFiltergraph_Proxy alias "ICaptureGraphBuilder2_SetFiltergraph_Proxy" (byval This as ICaptureGraphBuilder2 ptr, byval pfg as IGraphBuilder ptr) as HRESULT
declare sub ICaptureGraphBuilder2_SetFiltergraph_Stub alias "ICaptureGraphBuilder2_SetFiltergraph_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICaptureGraphBuilder2_GetFiltergraph_Proxy alias "ICaptureGraphBuilder2_GetFiltergraph_Proxy" (byval This as ICaptureGraphBuilder2 ptr, byval ppfg as IGraphBuilder ptr ptr) as HRESULT
declare sub ICaptureGraphBuilder2_GetFiltergraph_Stub alias "ICaptureGraphBuilder2_GetFiltergraph_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICaptureGraphBuilder2_SetOutputFileName_Proxy alias "ICaptureGraphBuilder2_SetOutputFileName_Proxy" (byval This as ICaptureGraphBuilder2 ptr, byval pType as GUID ptr, byval lpstrFile as LPCOLESTR, byval ppf as IBaseFilter ptr ptr, byval ppSink as IFileSinkFilter ptr ptr) as HRESULT
declare sub ICaptureGraphBuilder2_SetOutputFileName_Stub alias "ICaptureGraphBuilder2_SetOutputFileName_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICaptureGraphBuilder2_RemoteFindInterface_Proxy alias "ICaptureGraphBuilder2_RemoteFindInterface_Proxy" (byval This as ICaptureGraphBuilder2 ptr, byval pCategory as GUID ptr, byval pType as GUID ptr, byval pf as IBaseFilter ptr, byval riid as IID ptr, byval ppint as IUnknown ptr ptr) as HRESULT
declare sub ICaptureGraphBuilder2_RemoteFindInterface_Stub alias "ICaptureGraphBuilder2_RemoteFindInterface_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICaptureGraphBuilder2_RenderStream_Proxy alias "ICaptureGraphBuilder2_RenderStream_Proxy" (byval This as ICaptureGraphBuilder2 ptr, byval pCategory as GUID ptr, byval pType as GUID ptr, byval pSource as IUnknown ptr, byval pfCompressor as IBaseFilter ptr, byval pfRenderer as IBaseFilter ptr) as HRESULT
declare sub ICaptureGraphBuilder2_RenderStream_Stub alias "ICaptureGraphBuilder2_RenderStream_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICaptureGraphBuilder2_ControlStream_Proxy alias "ICaptureGraphBuilder2_ControlStream_Proxy" (byval This as ICaptureGraphBuilder2 ptr, byval pCategory as GUID ptr, byval pType as GUID ptr, byval pFilter as IBaseFilter ptr, byval pstart as REFERENCE_TIME ptr, byval pstop as REFERENCE_TIME ptr, byval wStartCookie as WORD, byval wStopCookie as WORD) as HRESULT
declare sub ICaptureGraphBuilder2_ControlStream_Stub alias "ICaptureGraphBuilder2_ControlStream_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICaptureGraphBuilder2_AllocCapFile_Proxy alias "ICaptureGraphBuilder2_AllocCapFile_Proxy" (byval This as ICaptureGraphBuilder2 ptr, byval lpstr as LPCOLESTR, byval dwlSize as DWORDLONG) as HRESULT
declare sub ICaptureGraphBuilder2_AllocCapFile_Stub alias "ICaptureGraphBuilder2_AllocCapFile_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICaptureGraphBuilder2_CopyCaptureFile_Proxy alias "ICaptureGraphBuilder2_CopyCaptureFile_Proxy" (byval This as ICaptureGraphBuilder2 ptr, byval lpwstrOld as LPOLESTR, byval lpwstrNew as LPOLESTR, byval fAllowEscAbort as integer, byval pCallback as IAMCopyCaptureFileProgress ptr) as HRESULT
declare sub ICaptureGraphBuilder2_CopyCaptureFile_Stub alias "ICaptureGraphBuilder2_CopyCaptureFile_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICaptureGraphBuilder2_FindPin_Proxy alias "ICaptureGraphBuilder2_FindPin_Proxy" (byval This as ICaptureGraphBuilder2 ptr, byval pSource as IUnknown ptr, byval pindir as PIN_DIRECTION, byval pCategory as GUID ptr, byval pType as GUID ptr, byval fUnconnected as BOOL, byval num as integer, byval ppPin as IPin ptr ptr) as HRESULT
declare sub ICaptureGraphBuilder2_FindPin_Stub alias "ICaptureGraphBuilder2_FindPin_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

enum AM_RENSDEREXFLAGS
	AM_RENDEREX_RENDERTOEXISTINGRENDERERS = &h1
end enum

extern IID_IFilterGraph2 alias "IID_IFilterGraph2" as IID

type IFilterGraph2Vtbl_ as IFilterGraph2Vtbl

type IFilterGraph2
	lpVtbl as IFilterGraph2Vtbl_ ptr
end type

type IFilterGraph2Vtbl
	QueryInterface as function(byval as IFilterGraph2 ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IFilterGraph2 ptr) as ULONG
	Release as function(byval as IFilterGraph2 ptr) as ULONG
	AddFilter as function(byval as IFilterGraph2 ptr, byval as IBaseFilter ptr, byval as LPCWSTR) as HRESULT
	RemoveFilter as function(byval as IFilterGraph2 ptr, byval as IBaseFilter ptr) as HRESULT
	EnumFilters as function(byval as IFilterGraph2 ptr, byval as IEnumFilters ptr ptr) as HRESULT
	FindFilterByName as function(byval as IFilterGraph2 ptr, byval as LPCWSTR, byval as IBaseFilter ptr ptr) as HRESULT
	ConnectDirect as function(byval as IFilterGraph2 ptr, byval as IPin ptr, byval as IPin ptr, byval as AM_MEDIA_TYPE ptr) as HRESULT
	Reconnect as function(byval as IFilterGraph2 ptr, byval as IPin ptr) as HRESULT
	Disconnect as function(byval as IFilterGraph2 ptr, byval as IPin ptr) as HRESULT
	SetDefaultSyncSource as function(byval as IFilterGraph2 ptr) as HRESULT
	Connect as function(byval as IFilterGraph2 ptr, byval as IPin ptr, byval as IPin ptr) as HRESULT
	Render as function(byval as IFilterGraph2 ptr, byval as IPin ptr) as HRESULT
	RenderFile as function(byval as IFilterGraph2 ptr, byval as LPCWSTR, byval as LPCWSTR) as HRESULT
	AddSourceFilter as function(byval as IFilterGraph2 ptr, byval as LPCWSTR, byval as LPCWSTR, byval as IBaseFilter ptr ptr) as HRESULT
	SetLogFile as function(byval as IFilterGraph2 ptr, byval as DWORD_PTR) as HRESULT
	Abort as function(byval as IFilterGraph2 ptr) as HRESULT
	ShouldOperationContinue as function(byval as IFilterGraph2 ptr) as HRESULT
	AddSourceFilterForMoniker as function(byval as IFilterGraph2 ptr, byval as IMoniker ptr, byval as IBindCtx ptr, byval as LPCWSTR, byval as IBaseFilter ptr ptr) as HRESULT
	ReconnectEx as function(byval as IFilterGraph2 ptr, byval as IPin ptr, byval as AM_MEDIA_TYPE ptr) as HRESULT
	RenderEx as function(byval as IFilterGraph2 ptr, byval as IPin ptr, byval as DWORD, byval as DWORD ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IFilterGraph2_AddSourceFilterForMoniker_Proxy alias "IFilterGraph2_AddSourceFilterForMoniker_Proxy" (byval This as IFilterGraph2 ptr, byval pMoniker as IMoniker ptr, byval pCtx as IBindCtx ptr, byval lpcwstrFilterName as LPCWSTR, byval ppFilter as IBaseFilter ptr ptr) as HRESULT
declare sub IFilterGraph2_AddSourceFilterForMoniker_Stub alias "IFilterGraph2_AddSourceFilterForMoniker_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFilterGraph2_ReconnectEx_Proxy alias "IFilterGraph2_ReconnectEx_Proxy" (byval This as IFilterGraph2 ptr, byval ppin as IPin ptr, byval pmt as AM_MEDIA_TYPE ptr) as HRESULT
declare sub IFilterGraph2_ReconnectEx_Stub alias "IFilterGraph2_ReconnectEx_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFilterGraph2_RenderEx_Proxy alias "IFilterGraph2_RenderEx_Proxy" (byval This as IFilterGraph2 ptr, byval pPinOut as IPin ptr, byval dwFlags as DWORD, byval pvContext as DWORD ptr) as HRESULT
declare sub IFilterGraph2_RenderEx_Stub alias "IFilterGraph2_RenderEx_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IStreamBuilder alias "IID_IStreamBuilder" as IID

type IStreamBuilderVtbl_ as IStreamBuilderVtbl

type IStreamBuilder
	lpVtbl as IStreamBuilderVtbl_ ptr
end type

type IStreamBuilderVtbl
	QueryInterface as function(byval as IStreamBuilder ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IStreamBuilder ptr) as ULONG
	Release as function(byval as IStreamBuilder ptr) as ULONG
	Render as function(byval as IStreamBuilder ptr, byval as IPin ptr, byval as IGraphBuilder ptr) as HRESULT
	Backout as function(byval as IStreamBuilder ptr, byval as IPin ptr, byval as IGraphBuilder ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IStreamBuilder_Render_Proxy alias "IStreamBuilder_Render_Proxy" (byval This as IStreamBuilder ptr, byval ppinOut as IPin ptr, byval pGraph as IGraphBuilder ptr) as HRESULT
declare sub IStreamBuilder_Render_Stub alias "IStreamBuilder_Render_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IStreamBuilder_Backout_Proxy alias "IStreamBuilder_Backout_Proxy" (byval This as IStreamBuilder ptr, byval ppinOut as IPin ptr, byval pGraph as IGraphBuilder ptr) as HRESULT
declare sub IStreamBuilder_Backout_Stub alias "IStreamBuilder_Backout_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IAsyncReader alias "IID_IAsyncReader" as IID

type IAsyncReaderVtbl_ as IAsyncReaderVtbl

type IAsyncReader
	lpVtbl as IAsyncReaderVtbl_ ptr
end type

type IAsyncReaderVtbl
	QueryInterface as function(byval as IAsyncReader ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAsyncReader ptr) as ULONG
	Release as function(byval as IAsyncReader ptr) as ULONG
	RequestAllocator as function(byval as IAsyncReader ptr, byval as IMemAllocator ptr, byval as ALLOCATOR_PROPERTIES ptr, byval as IMemAllocator ptr ptr) as HRESULT
	Request as function(byval as IAsyncReader ptr, byval as IMediaSample ptr, byval as DWORD_PTR) as HRESULT
	WaitForNext as function(byval as IAsyncReader ptr, byval as DWORD, byval as IMediaSample ptr ptr, byval as DWORD_PTR ptr) as HRESULT
	SyncReadAligned as function(byval as IAsyncReader ptr, byval as IMediaSample ptr) as HRESULT
	SyncRead as function(byval as IAsyncReader ptr, byval as LONGLONG, byval as LONG, byval as BYTE ptr) as HRESULT
	Length as function(byval as IAsyncReader ptr, byval as LONGLONG ptr, byval as LONGLONG ptr) as HRESULT
	BeginFlush as function(byval as IAsyncReader ptr) as HRESULT
	EndFlush as function(byval as IAsyncReader ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAsyncReader_RequestAllocator_Proxy alias "IAsyncReader_RequestAllocator_Proxy" (byval This as IAsyncReader ptr, byval pPreferred as IMemAllocator ptr, byval pProps as ALLOCATOR_PROPERTIES ptr, byval ppActual as IMemAllocator ptr ptr) as HRESULT
declare sub IAsyncReader_RequestAllocator_Stub alias "IAsyncReader_RequestAllocator_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAsyncReader_Request_Proxy alias "IAsyncReader_Request_Proxy" (byval This as IAsyncReader ptr, byval pSample as IMediaSample ptr, byval dwUser as DWORD_PTR) as HRESULT
declare sub IAsyncReader_Request_Stub alias "IAsyncReader_Request_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAsyncReader_WaitForNext_Proxy alias "IAsyncReader_WaitForNext_Proxy" (byval This as IAsyncReader ptr, byval dwTimeout as DWORD, byval ppSample as IMediaSample ptr ptr, byval pdwUser as DWORD_PTR ptr) as HRESULT
declare sub IAsyncReader_WaitForNext_Stub alias "IAsyncReader_WaitForNext_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAsyncReader_SyncReadAligned_Proxy alias "IAsyncReader_SyncReadAligned_Proxy" (byval This as IAsyncReader ptr, byval pSample as IMediaSample ptr) as HRESULT
declare sub IAsyncReader_SyncReadAligned_Stub alias "IAsyncReader_SyncReadAligned_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAsyncReader_SyncRead_Proxy alias "IAsyncReader_SyncRead_Proxy" (byval This as IAsyncReader ptr, byval llPosition as LONGLONG, byval lLength as LONG, byval pBuffer as BYTE ptr) as HRESULT
declare sub IAsyncReader_SyncRead_Stub alias "IAsyncReader_SyncRead_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAsyncReader_Length_Proxy alias "IAsyncReader_Length_Proxy" (byval This as IAsyncReader ptr, byval pTotal as LONGLONG ptr, byval pAvailable as LONGLONG ptr) as HRESULT
declare sub IAsyncReader_Length_Stub alias "IAsyncReader_Length_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAsyncReader_BeginFlush_Proxy alias "IAsyncReader_BeginFlush_Proxy" (byval This as IAsyncReader ptr) as HRESULT
declare sub IAsyncReader_BeginFlush_Stub alias "IAsyncReader_BeginFlush_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAsyncReader_EndFlush_Proxy alias "IAsyncReader_EndFlush_Proxy" (byval This as IAsyncReader ptr) as HRESULT
declare sub IAsyncReader_EndFlush_Stub alias "IAsyncReader_EndFlush_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IGraphVersion alias "IID_IGraphVersion" as IID

type IGraphVersionVtbl_ as IGraphVersionVtbl

type IGraphVersion
	lpVtbl as IGraphVersionVtbl_ ptr
end type

type IGraphVersionVtbl
	QueryInterface as function(byval as IGraphVersion ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IGraphVersion ptr) as ULONG
	Release as function(byval as IGraphVersion ptr) as ULONG
	QueryVersion as function(byval as IGraphVersion ptr, byval as LONG ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IGraphVersion_QueryVersion_Proxy alias "IGraphVersion_QueryVersion_Proxy" (byval This as IGraphVersion ptr, byval pVersion as LONG ptr) as HRESULT
declare sub IGraphVersion_QueryVersion_Stub alias "IGraphVersion_QueryVersion_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IResourceConsumer alias "IID_IResourceConsumer" as IID

type IResourceConsumerVtbl_ as IResourceConsumerVtbl

type IResourceConsumer
	lpVtbl as IResourceConsumerVtbl_ ptr
end type

type IResourceConsumerVtbl
	QueryInterface as function(byval as IResourceConsumer ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IResourceConsumer ptr) as ULONG
	Release as function(byval as IResourceConsumer ptr) as ULONG
	AcquireResource as function(byval as IResourceConsumer ptr, byval as LONG) as HRESULT
	ReleaseResource as function(byval as IResourceConsumer ptr, byval as LONG) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IResourceConsumer_AcquireResource_Proxy alias "IResourceConsumer_AcquireResource_Proxy" (byval This as IResourceConsumer ptr, byval idResource as LONG) as HRESULT
declare sub IResourceConsumer_AcquireResource_Stub alias "IResourceConsumer_AcquireResource_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IResourceConsumer_ReleaseResource_Proxy alias "IResourceConsumer_ReleaseResource_Proxy" (byval This as IResourceConsumer ptr, byval idResource as LONG) as HRESULT
declare sub IResourceConsumer_ReleaseResource_Stub alias "IResourceConsumer_ReleaseResource_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IResourceManager alias "IID_IResourceManager" as IID

type IResourceManagerVtbl_ as IResourceManagerVtbl

type IResourceManager
	lpVtbl as IResourceManagerVtbl_ ptr
end type

type IResourceManagerVtbl
	QueryInterface as function(byval as IResourceManager ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IResourceManager ptr) as ULONG
	Release as function(byval as IResourceManager ptr) as ULONG
	Register as function(byval as IResourceManager ptr, byval as LPCWSTR, byval as LONG, byval as LONG ptr) as HRESULT
	RegisterGroup as function(byval as IResourceManager ptr, byval as LPCWSTR, byval as LONG, byval as LONG ptr, byval as LONG ptr) as HRESULT
	RequestResource as function(byval as IResourceManager ptr, byval as LONG, byval as IUnknown ptr, byval as IResourceConsumer ptr) as HRESULT
	NotifyAcquire as function(byval as IResourceManager ptr, byval as LONG, byval as IResourceConsumer ptr, byval as HRESULT) as HRESULT
	NotifyRelease as function(byval as IResourceManager ptr, byval as LONG, byval as IResourceConsumer ptr, byval as BOOL) as HRESULT
	CancelRequest as function(byval as IResourceManager ptr, byval as LONG, byval as IResourceConsumer ptr) as HRESULT
	SetFocus as function(byval as IResourceManager ptr, byval as IUnknown ptr) as HRESULT
	ReleaseFocus as function(byval as IResourceManager ptr, byval as IUnknown ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IResourceManager_Register_Proxy alias "IResourceManager_Register_Proxy" (byval This as IResourceManager ptr, byval pName as LPCWSTR, byval cResource as LONG, byval plToken as LONG ptr) as HRESULT
declare sub IResourceManager_Register_Stub alias "IResourceManager_Register_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IResourceManager_RegisterGroup_Proxy alias "IResourceManager_RegisterGroup_Proxy" (byval This as IResourceManager ptr, byval pName as LPCWSTR, byval cResource as LONG, byval palTokens as LONG ptr, byval plToken as LONG ptr) as HRESULT
declare sub IResourceManager_RegisterGroup_Stub alias "IResourceManager_RegisterGroup_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IResourceManager_RequestResource_Proxy alias "IResourceManager_RequestResource_Proxy" (byval This as IResourceManager ptr, byval idResource as LONG, byval pFocusObject as IUnknown ptr, byval pConsumer as IResourceConsumer ptr) as HRESULT
declare sub IResourceManager_RequestResource_Stub alias "IResourceManager_RequestResource_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IResourceManager_NotifyAcquire_Proxy alias "IResourceManager_NotifyAcquire_Proxy" (byval This as IResourceManager ptr, byval idResource as LONG, byval pConsumer as IResourceConsumer ptr, byval hr as HRESULT) as HRESULT
declare sub IResourceManager_NotifyAcquire_Stub alias "IResourceManager_NotifyAcquire_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IResourceManager_NotifyRelease_Proxy alias "IResourceManager_NotifyRelease_Proxy" (byval This as IResourceManager ptr, byval idResource as LONG, byval pConsumer as IResourceConsumer ptr, byval bStillWant as BOOL) as HRESULT
declare sub IResourceManager_NotifyRelease_Stub alias "IResourceManager_NotifyRelease_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IResourceManager_CancelRequest_Proxy alias "IResourceManager_CancelRequest_Proxy" (byval This as IResourceManager ptr, byval idResource as LONG, byval pConsumer as IResourceConsumer ptr) as HRESULT
declare sub IResourceManager_CancelRequest_Stub alias "IResourceManager_CancelRequest_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IResourceManager_SetFocus_Proxy alias "IResourceManager_SetFocus_Proxy" (byval This as IResourceManager ptr, byval pFocusObject as IUnknown ptr) as HRESULT
declare sub IResourceManager_SetFocus_Stub alias "IResourceManager_SetFocus_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IResourceManager_ReleaseFocus_Proxy alias "IResourceManager_ReleaseFocus_Proxy" (byval This as IResourceManager ptr, byval pFocusObject as IUnknown ptr) as HRESULT
declare sub IResourceManager_ReleaseFocus_Stub alias "IResourceManager_ReleaseFocus_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IDistributorNotify alias "IID_IDistributorNotify" as IID

type IDistributorNotifyVtbl_ as IDistributorNotifyVtbl

type IDistributorNotify
	lpVtbl as IDistributorNotifyVtbl_ ptr
end type

type IDistributorNotifyVtbl
	QueryInterface as function(byval as IDistributorNotify ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IDistributorNotify ptr) as ULONG
	Release as function(byval as IDistributorNotify ptr) as ULONG
	Stop as function(byval as IDistributorNotify ptr) as HRESULT
	Pause as function(byval as IDistributorNotify ptr) as HRESULT
	Run as function(byval as IDistributorNotify ptr, byval as REFERENCE_TIME) as HRESULT
	SetSyncSource as function(byval as IDistributorNotify ptr, byval as IReferenceClock ptr) as HRESULT
	NotifyGraphChange as function(byval as IDistributorNotify ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IDistributorNotify_Stop_Proxy alias "IDistributorNotify_Stop_Proxy" (byval This as IDistributorNotify ptr) as HRESULT
declare sub IDistributorNotify_Stop_Stub alias "IDistributorNotify_Stop_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDistributorNotify_Pause_Proxy alias "IDistributorNotify_Pause_Proxy" (byval This as IDistributorNotify ptr) as HRESULT
declare sub IDistributorNotify_Pause_Stub alias "IDistributorNotify_Pause_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDistributorNotify_Run_Proxy alias "IDistributorNotify_Run_Proxy" (byval This as IDistributorNotify ptr, byval tStart as REFERENCE_TIME) as HRESULT
declare sub IDistributorNotify_Run_Stub alias "IDistributorNotify_Run_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDistributorNotify_SetSyncSource_Proxy alias "IDistributorNotify_SetSyncSource_Proxy" (byval This as IDistributorNotify ptr, byval pClock as IReferenceClock ptr) as HRESULT
declare sub IDistributorNotify_SetSyncSource_Stub alias "IDistributorNotify_SetSyncSource_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDistributorNotify_NotifyGraphChange_Proxy alias "IDistributorNotify_NotifyGraphChange_Proxy" (byval This as IDistributorNotify ptr) as HRESULT
declare sub IDistributorNotify_NotifyGraphChange_Stub alias "IDistributorNotify_NotifyGraphChange_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

enum AM_STREAM_INFO_FLAGS
	AM_STREAM_INFO_START_DEFINED = &h1
	AM_STREAM_INFO_STOP_DEFINED = &h2
	AM_STREAM_INFO_DISCARDING = &h4
	AM_STREAM_INFO_STOP_SEND_EXTRA = &h10
end enum

type AM_STREAM_INFO
	tStart as REFERENCE_TIME
	tStop as REFERENCE_TIME
	dwStartCookie as DWORD
	dwStopCookie as DWORD
	dwFlags as DWORD
end type

extern IID_IAMStreamControl alias "IID_IAMStreamControl" as IID

type IAMStreamControlVtbl_ as IAMStreamControlVtbl

type IAMStreamControl
	lpVtbl as IAMStreamControlVtbl_ ptr
end type

type IAMStreamControlVtbl
	QueryInterface as function(byval as IAMStreamControl ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMStreamControl ptr) as ULONG
	Release as function(byval as IAMStreamControl ptr) as ULONG
	StartAt as function(byval as IAMStreamControl ptr, byval as REFERENCE_TIME ptr, byval as DWORD) as HRESULT
	StopAt as function(byval as IAMStreamControl ptr, byval as REFERENCE_TIME ptr, byval as BOOL, byval as DWORD) as HRESULT
	GetInfo as function(byval as IAMStreamControl ptr, byval as AM_STREAM_INFO ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMStreamControl_StartAt_Proxy alias "IAMStreamControl_StartAt_Proxy" (byval This as IAMStreamControl ptr, byval ptStart as REFERENCE_TIME ptr, byval dwCookie as DWORD) as HRESULT
declare sub IAMStreamControl_StartAt_Stub alias "IAMStreamControl_StartAt_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMStreamControl_StopAt_Proxy alias "IAMStreamControl_StopAt_Proxy" (byval This as IAMStreamControl ptr, byval ptStop as REFERENCE_TIME ptr, byval bSendExtra as BOOL, byval dwCookie as DWORD) as HRESULT
declare sub IAMStreamControl_StopAt_Stub alias "IAMStreamControl_StopAt_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMStreamControl_GetInfo_Proxy alias "IAMStreamControl_GetInfo_Proxy" (byval This as IAMStreamControl ptr, byval pInfo as AM_STREAM_INFO ptr) as HRESULT
declare sub IAMStreamControl_GetInfo_Stub alias "IAMStreamControl_GetInfo_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_ISeekingPassThru alias "IID_ISeekingPassThru" as IID

type ISeekingPassThruVtbl_ as ISeekingPassThruVtbl

type ISeekingPassThru
	lpVtbl as ISeekingPassThruVtbl_ ptr
end type

type ISeekingPassThruVtbl
	QueryInterface as function(byval as ISeekingPassThru ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as ISeekingPassThru ptr) as ULONG
	Release as function(byval as ISeekingPassThru ptr) as ULONG
	Init as function(byval as ISeekingPassThru ptr, byval as BOOL, byval as IPin ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function ISeekingPassThru_Init_Proxy alias "ISeekingPassThru_Init_Proxy" (byval This as ISeekingPassThru ptr, byval bSupportRendering as BOOL, byval pPin as IPin ptr) as HRESULT
declare sub ISeekingPassThru_Init_Stub alias "ISeekingPassThru_Init_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type VIDEO_STREAM_CONFIG_CAPS
	guid as GUID
	VideoStandard as ULONG
	InputSize as SIZE
	MinCroppingSize as SIZE
	MaxCroppingSize as SIZE
	CropGranularityX as integer
	CropGranularityY as integer
	CropAlignX as integer
	CropAlignY as integer
	MinOutputSize as SIZE
	MaxOutputSize as SIZE
	OutputGranularityX as integer
	OutputGranularityY as integer
	StretchTapsX as integer
	StretchTapsY as integer
	ShrinkTapsX as integer
	ShrinkTapsY as integer
	MinFrameInterval as LONGLONG
	MaxFrameInterval as LONGLONG
	MinBitsPerSecond as LONG
	MaxBitsPerSecond as LONG
end type

type AUDIO_STREAM_CONFIG_CAPS
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

extern IID_IAMStreamConfig alias "IID_IAMStreamConfig" as IID

type IAMStreamConfigVtbl_ as IAMStreamConfigVtbl

type IAMStreamConfig
	lpVtbl as IAMStreamConfigVtbl_ ptr
end type

type IAMStreamConfigVtbl
	QueryInterface as function(byval as IAMStreamConfig ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMStreamConfig ptr) as ULONG
	Release as function(byval as IAMStreamConfig ptr) as ULONG
	SetFormat as function(byval as IAMStreamConfig ptr, byval as AM_MEDIA_TYPE ptr) as HRESULT
	GetFormat as function(byval as IAMStreamConfig ptr, byval as AM_MEDIA_TYPE ptr ptr) as HRESULT
	GetNumberOfCapabilities as function(byval as IAMStreamConfig ptr, byval as integer ptr, byval as integer ptr) as HRESULT
	GetStreamCaps as function(byval as IAMStreamConfig ptr, byval as integer, byval as AM_MEDIA_TYPE ptr ptr, byval as BYTE ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMStreamConfig_SetFormat_Proxy alias "IAMStreamConfig_SetFormat_Proxy" (byval This as IAMStreamConfig ptr, byval pmt as AM_MEDIA_TYPE ptr) as HRESULT
declare sub IAMStreamConfig_SetFormat_Stub alias "IAMStreamConfig_SetFormat_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMStreamConfig_GetFormat_Proxy alias "IAMStreamConfig_GetFormat_Proxy" (byval This as IAMStreamConfig ptr, byval ppmt as AM_MEDIA_TYPE ptr ptr) as HRESULT
declare sub IAMStreamConfig_GetFormat_Stub alias "IAMStreamConfig_GetFormat_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMStreamConfig_GetNumberOfCapabilities_Proxy alias "IAMStreamConfig_GetNumberOfCapabilities_Proxy" (byval This as IAMStreamConfig ptr, byval piCount as integer ptr, byval piSize as integer ptr) as HRESULT
declare sub IAMStreamConfig_GetNumberOfCapabilities_Stub alias "IAMStreamConfig_GetNumberOfCapabilities_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMStreamConfig_GetStreamCaps_Proxy alias "IAMStreamConfig_GetStreamCaps_Proxy" (byval This as IAMStreamConfig ptr, byval iIndex as integer, byval ppmt as AM_MEDIA_TYPE ptr ptr, byval pSCC as BYTE ptr) as HRESULT
declare sub IAMStreamConfig_GetStreamCaps_Stub alias "IAMStreamConfig_GetStreamCaps_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

enum InterleavingMode
	INTERLEAVE_NONE = 0
	INTERLEAVE_CAPTURE = INTERLEAVE_NONE+1
	INTERLEAVE_FULL = INTERLEAVE_CAPTURE+1
	INTERLEAVE_NONE_BUFFERED = INTERLEAVE_FULL+1
end enum

extern IID_IConfigInterleaving alias "IID_IConfigInterleaving" as IID

type IConfigInterleavingVtbl_ as IConfigInterleavingVtbl

type IConfigInterleaving
	lpVtbl as IConfigInterleavingVtbl_ ptr
end type

type IConfigInterleavingVtbl
	QueryInterface as function(byval as IConfigInterleaving ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IConfigInterleaving ptr) as ULONG
	Release as function(byval as IConfigInterleaving ptr) as ULONG
	put_Mode as function(byval as IConfigInterleaving ptr, byval as InterleavingMode) as HRESULT
	get_Mode as function(byval as IConfigInterleaving ptr, byval as InterleavingMode ptr) as HRESULT
	put_Interleaving as function(byval as IConfigInterleaving ptr, byval as REFERENCE_TIME ptr, byval as REFERENCE_TIME ptr) as HRESULT
	get_Interleaving as function(byval as IConfigInterleaving ptr, byval as REFERENCE_TIME ptr, byval as REFERENCE_TIME ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IConfigInterleaving_put_Mode_Proxy alias "IConfigInterleaving_put_Mode_Proxy" (byval This as IConfigInterleaving ptr, byval mode as InterleavingMode) as HRESULT
declare sub IConfigInterleaving_put_Mode_Stub alias "IConfigInterleaving_put_Mode_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IConfigInterleaving_get_Mode_Proxy alias "IConfigInterleaving_get_Mode_Proxy" (byval This as IConfigInterleaving ptr, byval pMode as InterleavingMode ptr) as HRESULT
declare sub IConfigInterleaving_get_Mode_Stub alias "IConfigInterleaving_get_Mode_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IConfigInterleaving_put_Interleaving_Proxy alias "IConfigInterleaving_put_Interleaving_Proxy" (byval This as IConfigInterleaving ptr, byval prtInterleave as REFERENCE_TIME ptr, byval prtPreroll as REFERENCE_TIME ptr) as HRESULT
declare sub IConfigInterleaving_put_Interleaving_Stub alias "IConfigInterleaving_put_Interleaving_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IConfigInterleaving_get_Interleaving_Proxy alias "IConfigInterleaving_get_Interleaving_Proxy" (byval This as IConfigInterleaving ptr, byval prtInterleave as REFERENCE_TIME ptr, byval prtPreroll as REFERENCE_TIME ptr) as HRESULT
declare sub IConfigInterleaving_get_Interleaving_Stub alias "IConfigInterleaving_get_Interleaving_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IConfigAviMux alias "IID_IConfigAviMux" as IID

type IConfigAviMuxVtbl_ as IConfigAviMuxVtbl

type IConfigAviMux
	lpVtbl as IConfigAviMuxVtbl_ ptr
end type

type IConfigAviMuxVtbl
	QueryInterface as function(byval as IConfigAviMux ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IConfigAviMux ptr) as ULONG
	Release as function(byval as IConfigAviMux ptr) as ULONG
	SetMasterStream as function(byval as IConfigAviMux ptr, byval as LONG) as HRESULT
	GetMasterStream as function(byval as IConfigAviMux ptr, byval as LONG ptr) as HRESULT
	SetOutputCompatibilityIndex as function(byval as IConfigAviMux ptr, byval as BOOL) as HRESULT
	GetOutputCompatibilityIndex as function(byval as IConfigAviMux ptr, byval as BOOL ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IConfigAviMux_SetMasterStream_Proxy alias "IConfigAviMux_SetMasterStream_Proxy" (byval This as IConfigAviMux ptr, byval iStream as LONG) as HRESULT
declare sub IConfigAviMux_SetMasterStream_Stub alias "IConfigAviMux_SetMasterStream_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IConfigAviMux_GetMasterStream_Proxy alias "IConfigAviMux_GetMasterStream_Proxy" (byval This as IConfigAviMux ptr, byval pStream as LONG ptr) as HRESULT
declare sub IConfigAviMux_GetMasterStream_Stub alias "IConfigAviMux_GetMasterStream_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IConfigAviMux_SetOutputCompatibilityIndex_Proxy alias "IConfigAviMux_SetOutputCompatibilityIndex_Proxy" (byval This as IConfigAviMux ptr, byval fOldIndex as BOOL) as HRESULT
declare sub IConfigAviMux_SetOutputCompatibilityIndex_Stub alias "IConfigAviMux_SetOutputCompatibilityIndex_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IConfigAviMux_GetOutputCompatibilityIndex_Proxy alias "IConfigAviMux_GetOutputCompatibilityIndex_Proxy" (byval This as IConfigAviMux ptr, byval pfOldIndex as BOOL ptr) as HRESULT
declare sub IConfigAviMux_GetOutputCompatibilityIndex_Stub alias "IConfigAviMux_GetOutputCompatibilityIndex_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

enum CompressionCaps
	CompressionCaps_CanQuality = &h1
	CompressionCaps_CanCrunch = &h2
	CompressionCaps_CanKeyFrame = &h4
	CompressionCaps_CanBFrame = &h8
	CompressionCaps_CanWindow = &h10
end enum

extern IID_IAMVideoCompression alias "IID_IAMVideoCompression" as IID

type IAMVideoCompressionVtbl_ as IAMVideoCompressionVtbl

type IAMVideoCompression
	lpVtbl as IAMVideoCompressionVtbl_ ptr
end type

type IAMVideoCompressionVtbl
	QueryInterface as function(byval as IAMVideoCompression ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMVideoCompression ptr) as ULONG
	Release as function(byval as IAMVideoCompression ptr) as ULONG
	put_KeyFrameRate as function(byval as IAMVideoCompression ptr, byval as integer) as HRESULT
	get_KeyFrameRate as function(byval as IAMVideoCompression ptr, byval as integer ptr) as HRESULT
	put_PFramesPerKeyFrame as function(byval as IAMVideoCompression ptr, byval as integer) as HRESULT
	get_PFramesPerKeyFrame as function(byval as IAMVideoCompression ptr, byval as integer ptr) as HRESULT
	put_Quality as function(byval as IAMVideoCompression ptr, byval as double) as HRESULT
	get_Quality as function(byval as IAMVideoCompression ptr, byval as double ptr) as HRESULT
	put_WindowSize as function(byval as IAMVideoCompression ptr, byval as DWORDLONG) as HRESULT
	get_WindowSize as function(byval as IAMVideoCompression ptr, byval as DWORDLONG ptr) as HRESULT
	GetInfo as function(byval as IAMVideoCompression ptr, byval as WCHAR ptr, byval as integer ptr, byval as LPWSTR, byval as integer ptr, byval as integer ptr, byval as integer ptr, byval as double ptr, byval as integer ptr) as HRESULT
	OverrideKeyFrame as function(byval as IAMVideoCompression ptr, byval as integer) as HRESULT
	OverrideFrameSize as function(byval as IAMVideoCompression ptr, byval as integer, byval as integer) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMVideoCompression_put_KeyFrameRate_Proxy alias "IAMVideoCompression_put_KeyFrameRate_Proxy" (byval This as IAMVideoCompression ptr, byval KeyFrameRate as integer) as HRESULT
declare sub IAMVideoCompression_put_KeyFrameRate_Stub alias "IAMVideoCompression_put_KeyFrameRate_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVideoCompression_get_KeyFrameRate_Proxy alias "IAMVideoCompression_get_KeyFrameRate_Proxy" (byval This as IAMVideoCompression ptr, byval pKeyFrameRate as integer ptr) as HRESULT
declare sub IAMVideoCompression_get_KeyFrameRate_Stub alias "IAMVideoCompression_get_KeyFrameRate_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVideoCompression_put_PFramesPerKeyFrame_Proxy alias "IAMVideoCompression_put_PFramesPerKeyFrame_Proxy" (byval This as IAMVideoCompression ptr, byval PFramesPerKeyFrame as integer) as HRESULT
declare sub IAMVideoCompression_put_PFramesPerKeyFrame_Stub alias "IAMVideoCompression_put_PFramesPerKeyFrame_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVideoCompression_get_PFramesPerKeyFrame_Proxy alias "IAMVideoCompression_get_PFramesPerKeyFrame_Proxy" (byval This as IAMVideoCompression ptr, byval pPFramesPerKeyFrame as integer ptr) as HRESULT
declare sub IAMVideoCompression_get_PFramesPerKeyFrame_Stub alias "IAMVideoCompression_get_PFramesPerKeyFrame_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVideoCompression_put_Quality_Proxy alias "IAMVideoCompression_put_Quality_Proxy" (byval This as IAMVideoCompression ptr, byval Quality as double) as HRESULT
declare sub IAMVideoCompression_put_Quality_Stub alias "IAMVideoCompression_put_Quality_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVideoCompression_get_Quality_Proxy alias "IAMVideoCompression_get_Quality_Proxy" (byval This as IAMVideoCompression ptr, byval pQuality as double ptr) as HRESULT
declare sub IAMVideoCompression_get_Quality_Stub alias "IAMVideoCompression_get_Quality_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVideoCompression_put_WindowSize_Proxy alias "IAMVideoCompression_put_WindowSize_Proxy" (byval This as IAMVideoCompression ptr, byval WindowSize as DWORDLONG) as HRESULT
declare sub IAMVideoCompression_put_WindowSize_Stub alias "IAMVideoCompression_put_WindowSize_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVideoCompression_get_WindowSize_Proxy alias "IAMVideoCompression_get_WindowSize_Proxy" (byval This as IAMVideoCompression ptr, byval pWindowSize as DWORDLONG ptr) as HRESULT
declare sub IAMVideoCompression_get_WindowSize_Stub alias "IAMVideoCompression_get_WindowSize_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVideoCompression_GetInfo_Proxy alias "IAMVideoCompression_GetInfo_Proxy" (byval This as IAMVideoCompression ptr, byval pszVersion as WCHAR ptr, byval pcbVersion as integer ptr, byval pszDescription as LPWSTR, byval pcbDescription as integer ptr, byval pDefaultKeyFrameRate as integer ptr, byval pDefaultPFramesPerKey as integer ptr, byval pDefaultQuality as double ptr, byval pCapabilities as integer ptr) as HRESULT
declare sub IAMVideoCompression_GetInfo_Stub alias "IAMVideoCompression_GetInfo_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVideoCompression_OverrideKeyFrame_Proxy alias "IAMVideoCompression_OverrideKeyFrame_Proxy" (byval This as IAMVideoCompression ptr, byval FrameNumber as integer) as HRESULT
declare sub IAMVideoCompression_OverrideKeyFrame_Stub alias "IAMVideoCompression_OverrideKeyFrame_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVideoCompression_OverrideFrameSize_Proxy alias "IAMVideoCompression_OverrideFrameSize_Proxy" (byval This as IAMVideoCompression ptr, byval FrameNumber as integer, byval Size as integer) as HRESULT
declare sub IAMVideoCompression_OverrideFrameSize_Stub alias "IAMVideoCompression_OverrideFrameSize_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

enum VfwCaptureDialogs
	VfwCaptureDialog_Source = &h1
	VfwCaptureDialog_Format = &h2
	VfwCaptureDialog_Display = &h4
end enum

enum VfwCompressDialogs
	VfwCompressDialog_Config = &h1
	VfwCompressDialog_About = &h2
	VfwCompressDialog_QueryConfig = &h4
	VfwCompressDialog_QueryAbout = &h8
end enum

extern IID_IAMVfwCaptureDialogs alias "IID_IAMVfwCaptureDialogs" as IID

type IAMVfwCaptureDialogsVtbl_ as IAMVfwCaptureDialogsVtbl

type IAMVfwCaptureDialogs
	lpVtbl as IAMVfwCaptureDialogsVtbl_ ptr
end type

type IAMVfwCaptureDialogsVtbl
	QueryInterface as function(byval as IAMVfwCaptureDialogs ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMVfwCaptureDialogs ptr) as ULONG
	Release as function(byval as IAMVfwCaptureDialogs ptr) as ULONG
	HasDialog as function(byval as IAMVfwCaptureDialogs ptr, byval as integer) as HRESULT
	ShowDialog as function(byval as IAMVfwCaptureDialogs ptr, byval as integer, byval as HWND) as HRESULT
	SendDriverMessage as function(byval as IAMVfwCaptureDialogs ptr, byval as integer, byval as integer, byval as integer, byval as integer) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMVfwCaptureDialogs_HasDialog_Proxy alias "IAMVfwCaptureDialogs_HasDialog_Proxy" (byval This as IAMVfwCaptureDialogs ptr, byval iDialog as integer) as HRESULT
declare sub IAMVfwCaptureDialogs_HasDialog_Stub alias "IAMVfwCaptureDialogs_HasDialog_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVfwCaptureDialogs_ShowDialog_Proxy alias "IAMVfwCaptureDialogs_ShowDialog_Proxy" (byval This as IAMVfwCaptureDialogs ptr, byval iDialog as integer, byval hwnd as HWND) as HRESULT
declare sub IAMVfwCaptureDialogs_ShowDialog_Stub alias "IAMVfwCaptureDialogs_ShowDialog_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVfwCaptureDialogs_SendDriverMessage_Proxy alias "IAMVfwCaptureDialogs_SendDriverMessage_Proxy" (byval This as IAMVfwCaptureDialogs ptr, byval iDialog as integer, byval uMsg as integer, byval dw1 as integer, byval dw2 as integer) as HRESULT
declare sub IAMVfwCaptureDialogs_SendDriverMessage_Stub alias "IAMVfwCaptureDialogs_SendDriverMessage_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IAMVfwCompressDialogs alias "IID_IAMVfwCompressDialogs" as IID

type IAMVfwCompressDialogsVtbl_ as IAMVfwCompressDialogsVtbl

type IAMVfwCompressDialogs
	lpVtbl as IAMVfwCompressDialogsVtbl_ ptr
end type

type IAMVfwCompressDialogsVtbl
	QueryInterface as function(byval as IAMVfwCompressDialogs ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMVfwCompressDialogs ptr) as ULONG
	Release as function(byval as IAMVfwCompressDialogs ptr) as ULONG
	ShowDialog as function(byval as IAMVfwCompressDialogs ptr, byval as integer, byval as HWND) as HRESULT
	GetState as function(byval as IAMVfwCompressDialogs ptr, byval as LPVOID, byval as integer ptr) as HRESULT
	SetState as function(byval as IAMVfwCompressDialogs ptr, byval as LPVOID, byval as integer) as HRESULT
	SendDriverMessage as function(byval as IAMVfwCompressDialogs ptr, byval as integer, byval as integer, byval as integer) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMVfwCompressDialogs_ShowDialog_Proxy alias "IAMVfwCompressDialogs_ShowDialog_Proxy" (byval This as IAMVfwCompressDialogs ptr, byval iDialog as integer, byval hwnd as HWND) as HRESULT
declare sub IAMVfwCompressDialogs_ShowDialog_Stub alias "IAMVfwCompressDialogs_ShowDialog_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVfwCompressDialogs_GetState_Proxy alias "IAMVfwCompressDialogs_GetState_Proxy" (byval This as IAMVfwCompressDialogs ptr, byval pState as LPVOID, byval pcbState as integer ptr) as HRESULT
declare sub IAMVfwCompressDialogs_GetState_Stub alias "IAMVfwCompressDialogs_GetState_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVfwCompressDialogs_SetState_Proxy alias "IAMVfwCompressDialogs_SetState_Proxy" (byval This as IAMVfwCompressDialogs ptr, byval pState as LPVOID, byval cbState as integer) as HRESULT
declare sub IAMVfwCompressDialogs_SetState_Stub alias "IAMVfwCompressDialogs_SetState_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVfwCompressDialogs_SendDriverMessage_Proxy alias "IAMVfwCompressDialogs_SendDriverMessage_Proxy" (byval This as IAMVfwCompressDialogs ptr, byval uMsg as integer, byval dw1 as integer, byval dw2 as integer) as HRESULT
declare sub IAMVfwCompressDialogs_SendDriverMessage_Stub alias "IAMVfwCompressDialogs_SendDriverMessage_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IAMDroppedFrames alias "IID_IAMDroppedFrames" as IID

type IAMDroppedFramesVtbl_ as IAMDroppedFramesVtbl

type IAMDroppedFrames
	lpVtbl as IAMDroppedFramesVtbl_ ptr
end type

type IAMDroppedFramesVtbl
	QueryInterface as function(byval as IAMDroppedFrames ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMDroppedFrames ptr) as ULONG
	Release as function(byval as IAMDroppedFrames ptr) as ULONG
	GetNumDropped as function(byval as IAMDroppedFrames ptr, byval as integer ptr) as HRESULT
	GetNumNotDropped as function(byval as IAMDroppedFrames ptr, byval as integer ptr) as HRESULT
	GetDroppedInfo as function(byval as IAMDroppedFrames ptr, byval as integer, byval as integer ptr, byval as integer ptr) as HRESULT
	GetAverageFrameSize as function(byval as IAMDroppedFrames ptr, byval as integer ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMDroppedFrames_GetNumDropped_Proxy alias "IAMDroppedFrames_GetNumDropped_Proxy" (byval This as IAMDroppedFrames ptr, byval plDropped as integer ptr) as HRESULT
declare sub IAMDroppedFrames_GetNumDropped_Stub alias "IAMDroppedFrames_GetNumDropped_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMDroppedFrames_GetNumNotDropped_Proxy alias "IAMDroppedFrames_GetNumNotDropped_Proxy" (byval This as IAMDroppedFrames ptr, byval plNotDropped as integer ptr) as HRESULT
declare sub IAMDroppedFrames_GetNumNotDropped_Stub alias "IAMDroppedFrames_GetNumNotDropped_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMDroppedFrames_GetDroppedInfo_Proxy alias "IAMDroppedFrames_GetDroppedInfo_Proxy" (byval This as IAMDroppedFrames ptr, byval lSize as integer, byval plArray as integer ptr, byval plNumCopied as integer ptr) as HRESULT
declare sub IAMDroppedFrames_GetDroppedInfo_Stub alias "IAMDroppedFrames_GetDroppedInfo_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMDroppedFrames_GetAverageFrameSize_Proxy alias "IAMDroppedFrames_GetAverageFrameSize_Proxy" (byval This as IAMDroppedFrames ptr, byval plAverageSize as integer ptr) as HRESULT
declare sub IAMDroppedFrames_GetAverageFrameSize_Stub alias "IAMDroppedFrames_GetAverageFrameSize_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

#define AMF_AUTOMATICGAIN -1.0
extern IID_IAMAudioInputMixer alias "IID_IAMAudioInputMixer" as IID

type IAMAudioInputMixerVtbl_ as IAMAudioInputMixerVtbl

type IAMAudioInputMixer
	lpVtbl as IAMAudioInputMixerVtbl_ ptr
end type

type IAMAudioInputMixerVtbl
	QueryInterface as function(byval as IAMAudioInputMixer ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMAudioInputMixer ptr) as ULONG
	Release as function(byval as IAMAudioInputMixer ptr) as ULONG
	put_Enable as function(byval as IAMAudioInputMixer ptr, byval as BOOL) as HRESULT
	get_Enable as function(byval as IAMAudioInputMixer ptr, byval as BOOL ptr) as HRESULT
	put_Mono as function(byval as IAMAudioInputMixer ptr, byval as BOOL) as HRESULT
	get_Mono as function(byval as IAMAudioInputMixer ptr, byval as BOOL ptr) as HRESULT
	put_MixLevel as function(byval as IAMAudioInputMixer ptr, byval as double) as HRESULT
	get_MixLevel as function(byval as IAMAudioInputMixer ptr, byval as double ptr) as HRESULT
	put_Pan as function(byval as IAMAudioInputMixer ptr, byval as double) as HRESULT
	get_Pan as function(byval as IAMAudioInputMixer ptr, byval as double ptr) as HRESULT
	put_Loudness as function(byval as IAMAudioInputMixer ptr, byval as BOOL) as HRESULT
	get_Loudness as function(byval as IAMAudioInputMixer ptr, byval as BOOL ptr) as HRESULT
	put_Treble as function(byval as IAMAudioInputMixer ptr, byval as double) as HRESULT
	get_Treble as function(byval as IAMAudioInputMixer ptr, byval as double ptr) as HRESULT
	get_TrebleRange as function(byval as IAMAudioInputMixer ptr, byval as double ptr) as HRESULT
	put_Bass as function(byval as IAMAudioInputMixer ptr, byval as double) as HRESULT
	get_Bass as function(byval as IAMAudioInputMixer ptr, byval as double ptr) as HRESULT
	get_BassRange as function(byval as IAMAudioInputMixer ptr, byval as double ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMAudioInputMixer_put_Enable_Proxy alias "IAMAudioInputMixer_put_Enable_Proxy" (byval This as IAMAudioInputMixer ptr, byval fEnable as BOOL) as HRESULT
declare sub IAMAudioInputMixer_put_Enable_Stub alias "IAMAudioInputMixer_put_Enable_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAudioInputMixer_get_Enable_Proxy alias "IAMAudioInputMixer_get_Enable_Proxy" (byval This as IAMAudioInputMixer ptr, byval pfEnable as BOOL ptr) as HRESULT
declare sub IAMAudioInputMixer_get_Enable_Stub alias "IAMAudioInputMixer_get_Enable_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAudioInputMixer_put_Mono_Proxy alias "IAMAudioInputMixer_put_Mono_Proxy" (byval This as IAMAudioInputMixer ptr, byval fMono as BOOL) as HRESULT
declare sub IAMAudioInputMixer_put_Mono_Stub alias "IAMAudioInputMixer_put_Mono_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAudioInputMixer_get_Mono_Proxy alias "IAMAudioInputMixer_get_Mono_Proxy" (byval This as IAMAudioInputMixer ptr, byval pfMono as BOOL ptr) as HRESULT
declare sub IAMAudioInputMixer_get_Mono_Stub alias "IAMAudioInputMixer_get_Mono_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAudioInputMixer_put_MixLevel_Proxy alias "IAMAudioInputMixer_put_MixLevel_Proxy" (byval This as IAMAudioInputMixer ptr, byval Level as double) as HRESULT
declare sub IAMAudioInputMixer_put_MixLevel_Stub alias "IAMAudioInputMixer_put_MixLevel_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAudioInputMixer_get_MixLevel_Proxy alias "IAMAudioInputMixer_get_MixLevel_Proxy" (byval This as IAMAudioInputMixer ptr, byval pLevel as double ptr) as HRESULT
declare sub IAMAudioInputMixer_get_MixLevel_Stub alias "IAMAudioInputMixer_get_MixLevel_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAudioInputMixer_put_Pan_Proxy alias "IAMAudioInputMixer_put_Pan_Proxy" (byval This as IAMAudioInputMixer ptr, byval Pan as double) as HRESULT
declare sub IAMAudioInputMixer_put_Pan_Stub alias "IAMAudioInputMixer_put_Pan_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAudioInputMixer_get_Pan_Proxy alias "IAMAudioInputMixer_get_Pan_Proxy" (byval This as IAMAudioInputMixer ptr, byval pPan as double ptr) as HRESULT
declare sub IAMAudioInputMixer_get_Pan_Stub alias "IAMAudioInputMixer_get_Pan_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAudioInputMixer_put_Loudness_Proxy alias "IAMAudioInputMixer_put_Loudness_Proxy" (byval This as IAMAudioInputMixer ptr, byval fLoudness as BOOL) as HRESULT
declare sub IAMAudioInputMixer_put_Loudness_Stub alias "IAMAudioInputMixer_put_Loudness_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAudioInputMixer_get_Loudness_Proxy alias "IAMAudioInputMixer_get_Loudness_Proxy" (byval This as IAMAudioInputMixer ptr, byval pfLoudness as BOOL ptr) as HRESULT
declare sub IAMAudioInputMixer_get_Loudness_Stub alias "IAMAudioInputMixer_get_Loudness_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAudioInputMixer_put_Treble_Proxy alias "IAMAudioInputMixer_put_Treble_Proxy" (byval This as IAMAudioInputMixer ptr, byval Treble as double) as HRESULT
declare sub IAMAudioInputMixer_put_Treble_Stub alias "IAMAudioInputMixer_put_Treble_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAudioInputMixer_get_Treble_Proxy alias "IAMAudioInputMixer_get_Treble_Proxy" (byval This as IAMAudioInputMixer ptr, byval pTreble as double ptr) as HRESULT
declare sub IAMAudioInputMixer_get_Treble_Stub alias "IAMAudioInputMixer_get_Treble_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAudioInputMixer_get_TrebleRange_Proxy alias "IAMAudioInputMixer_get_TrebleRange_Proxy" (byval This as IAMAudioInputMixer ptr, byval pRange as double ptr) as HRESULT
declare sub IAMAudioInputMixer_get_TrebleRange_Stub alias "IAMAudioInputMixer_get_TrebleRange_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAudioInputMixer_put_Bass_Proxy alias "IAMAudioInputMixer_put_Bass_Proxy" (byval This as IAMAudioInputMixer ptr, byval Bass as double) as HRESULT
declare sub IAMAudioInputMixer_put_Bass_Stub alias "IAMAudioInputMixer_put_Bass_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAudioInputMixer_get_Bass_Proxy alias "IAMAudioInputMixer_get_Bass_Proxy" (byval This as IAMAudioInputMixer ptr, byval pBass as double ptr) as HRESULT
declare sub IAMAudioInputMixer_get_Bass_Stub alias "IAMAudioInputMixer_get_Bass_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAudioInputMixer_get_BassRange_Proxy alias "IAMAudioInputMixer_get_BassRange_Proxy" (byval This as IAMAudioInputMixer ptr, byval pRange as double ptr) as HRESULT
declare sub IAMAudioInputMixer_get_BassRange_Stub alias "IAMAudioInputMixer_get_BassRange_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IAMBufferNegotiation alias "IID_IAMBufferNegotiation" as IID

type IAMBufferNegotiationVtbl_ as IAMBufferNegotiationVtbl

type IAMBufferNegotiation
	lpVtbl as IAMBufferNegotiationVtbl_ ptr
end type

type IAMBufferNegotiationVtbl
	QueryInterface as function(byval as IAMBufferNegotiation ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMBufferNegotiation ptr) as ULONG
	Release as function(byval as IAMBufferNegotiation ptr) as ULONG
	SuggestAllocatorProperties as function(byval as IAMBufferNegotiation ptr, byval as ALLOCATOR_PROPERTIES ptr) as HRESULT
	GetAllocatorProperties as function(byval as IAMBufferNegotiation ptr, byval as ALLOCATOR_PROPERTIES ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMBufferNegotiation_SuggestAllocatorProperties_Proxy alias "IAMBufferNegotiation_SuggestAllocatorProperties_Proxy" (byval This as IAMBufferNegotiation ptr, byval pprop as ALLOCATOR_PROPERTIES ptr) as HRESULT
declare sub IAMBufferNegotiation_SuggestAllocatorProperties_Stub alias "IAMBufferNegotiation_SuggestAllocatorProperties_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMBufferNegotiation_GetAllocatorProperties_Proxy alias "IAMBufferNegotiation_GetAllocatorProperties_Proxy" (byval This as IAMBufferNegotiation ptr, byval pprop as ALLOCATOR_PROPERTIES ptr) as HRESULT
declare sub IAMBufferNegotiation_GetAllocatorProperties_Stub alias "IAMBufferNegotiation_GetAllocatorProperties_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

enum AnalogVideoStandard
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
end enum

#define AnalogVideo_NTSC_Mask &h00000007
#define AnalogVideo_PAL_Mask &h00100FF0
#define AnalogVideo_SECAM_Mask &h000FF000

enum TunerInputType
	TunerInputCable = 0
	TunerInputAntenna = TunerInputCable+1
end enum

enum VideoCopyProtectionType
	VideoCopyProtectionMacrovisionBasic = 0
	VideoCopyProtectionMacrovisionCBI = VideoCopyProtectionMacrovisionBasic+1
end enum

enum PhysicalConnectorType
	PhysConn_Video_Tuner = 1
	PhysConn_Video_Composite = PhysConn_Video_Tuner+1
	PhysConn_Video_SVideo = PhysConn_Video_Composite+1
	PhysConn_Video_RGB = PhysConn_Video_SVideo+1
	PhysConn_Video_YRYBY = PhysConn_Video_RGB+1
	PhysConn_Video_SerialDigital = PhysConn_Video_YRYBY+1
	PhysConn_Video_ParallelDigital = PhysConn_Video_SerialDigital+1
	PhysConn_Video_SCSI = PhysConn_Video_ParallelDigital+1
	PhysConn_Video_AUX = PhysConn_Video_SCSI+1
	PhysConn_Video_1394 = PhysConn_Video_AUX+1
	PhysConn_Video_USB = PhysConn_Video_1394+1
	PhysConn_Video_VideoDecoder = PhysConn_Video_USB+1
	PhysConn_Video_VideoEncoder = PhysConn_Video_VideoDecoder+1
	PhysConn_Video_SCART = PhysConn_Video_VideoEncoder+1
	PhysConn_Video_Black = PhysConn_Video_SCART+1
	PhysConn_Audio_Tuner = &h1000
	PhysConn_Audio_Line = PhysConn_Audio_Tuner+1
	PhysConn_Audio_Mic = PhysConn_Audio_Line+1
	PhysConn_Audio_AESDigital = PhysConn_Audio_Mic+1
	PhysConn_Audio_SPDIFDigital = PhysConn_Audio_AESDigital+1
	PhysConn_Audio_SCSI = PhysConn_Audio_SPDIFDigital+1
	PhysConn_Audio_AUX = PhysConn_Audio_SCSI+1
	PhysConn_Audio_1394 = PhysConn_Audio_AUX+1
	PhysConn_Audio_USB = PhysConn_Audio_1394+1
	PhysConn_Audio_AudioDecoder = PhysConn_Audio_USB+1
end enum

extern IID_IAMAnalogVideoDecoder alias "IID_IAMAnalogVideoDecoder" as IID

type IAMAnalogVideoDecoderVtbl_ as IAMAnalogVideoDecoderVtbl

type IAMAnalogVideoDecoder
	lpVtbl as IAMAnalogVideoDecoderVtbl_ ptr
end type

type IAMAnalogVideoDecoderVtbl
	QueryInterface as function(byval as IAMAnalogVideoDecoder ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMAnalogVideoDecoder ptr) as ULONG
	Release as function(byval as IAMAnalogVideoDecoder ptr) as ULONG
	get_AvailableTVFormats as function(byval as IAMAnalogVideoDecoder ptr, byval as integer ptr) as HRESULT
	put_TVFormat as function(byval as IAMAnalogVideoDecoder ptr, byval as integer) as HRESULT
	get_TVFormat as function(byval as IAMAnalogVideoDecoder ptr, byval as integer ptr) as HRESULT
	get_HorizontalLocked as function(byval as IAMAnalogVideoDecoder ptr, byval as integer ptr) as HRESULT
	put_VCRHorizontalLocking as function(byval as IAMAnalogVideoDecoder ptr, byval as integer) as HRESULT
	get_VCRHorizontalLocking as function(byval as IAMAnalogVideoDecoder ptr, byval as integer ptr) as HRESULT
	get_NumberOfLines as function(byval as IAMAnalogVideoDecoder ptr, byval as integer ptr) as HRESULT
	put_OutputEnable as function(byval as IAMAnalogVideoDecoder ptr, byval as integer) as HRESULT
	get_OutputEnable as function(byval as IAMAnalogVideoDecoder ptr, byval as integer ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMAnalogVideoDecoder_get_AvailableTVFormats_Proxy alias "IAMAnalogVideoDecoder_get_AvailableTVFormats_Proxy" (byval This as IAMAnalogVideoDecoder ptr, byval lAnalogVideoStandard as integer ptr) as HRESULT
declare sub IAMAnalogVideoDecoder_get_AvailableTVFormats_Stub alias "IAMAnalogVideoDecoder_get_AvailableTVFormats_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAnalogVideoDecoder_put_TVFormat_Proxy alias "IAMAnalogVideoDecoder_put_TVFormat_Proxy" (byval This as IAMAnalogVideoDecoder ptr, byval lAnalogVideoStandard as integer) as HRESULT
declare sub IAMAnalogVideoDecoder_put_TVFormat_Stub alias "IAMAnalogVideoDecoder_put_TVFormat_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAnalogVideoDecoder_get_TVFormat_Proxy alias "IAMAnalogVideoDecoder_get_TVFormat_Proxy" (byval This as IAMAnalogVideoDecoder ptr, byval plAnalogVideoStandard as integer ptr) as HRESULT
declare sub IAMAnalogVideoDecoder_get_TVFormat_Stub alias "IAMAnalogVideoDecoder_get_TVFormat_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAnalogVideoDecoder_get_HorizontalLocked_Proxy alias "IAMAnalogVideoDecoder_get_HorizontalLocked_Proxy" (byval This as IAMAnalogVideoDecoder ptr, byval plLocked as integer ptr) as HRESULT
declare sub IAMAnalogVideoDecoder_get_HorizontalLocked_Stub alias "IAMAnalogVideoDecoder_get_HorizontalLocked_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAnalogVideoDecoder_put_VCRHorizontalLocking_Proxy alias "IAMAnalogVideoDecoder_put_VCRHorizontalLocking_Proxy" (byval This as IAMAnalogVideoDecoder ptr, byval lVCRHorizontalLocking as integer) as HRESULT
declare sub IAMAnalogVideoDecoder_put_VCRHorizontalLocking_Stub alias "IAMAnalogVideoDecoder_put_VCRHorizontalLocking_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAnalogVideoDecoder_get_VCRHorizontalLocking_Proxy alias "IAMAnalogVideoDecoder_get_VCRHorizontalLocking_Proxy" (byval This as IAMAnalogVideoDecoder ptr, byval plVCRHorizontalLocking as integer ptr) as HRESULT
declare sub IAMAnalogVideoDecoder_get_VCRHorizontalLocking_Stub alias "IAMAnalogVideoDecoder_get_VCRHorizontalLocking_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAnalogVideoDecoder_get_NumberOfLines_Proxy alias "IAMAnalogVideoDecoder_get_NumberOfLines_Proxy" (byval This as IAMAnalogVideoDecoder ptr, byval plNumberOfLines as integer ptr) as HRESULT
declare sub IAMAnalogVideoDecoder_get_NumberOfLines_Stub alias "IAMAnalogVideoDecoder_get_NumberOfLines_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAnalogVideoDecoder_put_OutputEnable_Proxy alias "IAMAnalogVideoDecoder_put_OutputEnable_Proxy" (byval This as IAMAnalogVideoDecoder ptr, byval lOutputEnable as integer) as HRESULT
declare sub IAMAnalogVideoDecoder_put_OutputEnable_Stub alias "IAMAnalogVideoDecoder_put_OutputEnable_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAnalogVideoDecoder_get_OutputEnable_Proxy alias "IAMAnalogVideoDecoder_get_OutputEnable_Proxy" (byval This as IAMAnalogVideoDecoder ptr, byval plOutputEnable as integer ptr) as HRESULT
declare sub IAMAnalogVideoDecoder_get_OutputEnable_Stub alias "IAMAnalogVideoDecoder_get_OutputEnable_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

enum VideoProcAmpProperty
	VideoProcAmp_Brightness = 0
	VideoProcAmp_Contrast = VideoProcAmp_Brightness+1
	VideoProcAmp_Hue = VideoProcAmp_Contrast+1
	VideoProcAmp_Saturation = VideoProcAmp_Hue+1
	VideoProcAmp_Sharpness = VideoProcAmp_Saturation+1
	VideoProcAmp_Gamma = VideoProcAmp_Sharpness+1
	VideoProcAmp_ColorEnable = VideoProcAmp_Gamma+1
	VideoProcAmp_WhiteBalance = VideoProcAmp_ColorEnable+1
	VideoProcAmp_BacklightCompensation = VideoProcAmp_WhiteBalance+1
	VideoProcAmp_Gain = VideoProcAmp_BacklightCompensation+1
end enum

enum VideoProcAmpFlags
	VideoProcAmp_Flags_Auto = &h1
	VideoProcAmp_Flags_Manual = &h2
end enum

extern IID_IAMVideoProcAmp alias "IID_IAMVideoProcAmp" as IID

type IAMVideoProcAmpVtbl_ as IAMVideoProcAmpVtbl

type IAMVideoProcAmp
	lpVtbl as IAMVideoProcAmpVtbl_ ptr
end type

type IAMVideoProcAmpVtbl
	QueryInterface as function(byval as IAMVideoProcAmp ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMVideoProcAmp ptr) as ULONG
	Release as function(byval as IAMVideoProcAmp ptr) as ULONG
	GetRange as function(byval as IAMVideoProcAmp ptr, byval as integer, byval as integer ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr) as HRESULT
	Set as function(byval as IAMVideoProcAmp ptr, byval as integer, byval as integer, byval as integer) as HRESULT
	Get as function(byval as IAMVideoProcAmp ptr, byval as integer, byval as integer ptr, byval as integer ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMVideoProcAmp_GetRange_Proxy alias "IAMVideoProcAmp_GetRange_Proxy" (byval This as IAMVideoProcAmp ptr, byval Property as integer, byval pMin as integer ptr, byval pMax as integer ptr, byval pSteppingDelta as integer ptr, byval pDefault as integer ptr, byval pCapsFlags as integer ptr) as HRESULT
declare sub IAMVideoProcAmp_GetRange_Stub alias "IAMVideoProcAmp_GetRange_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVideoProcAmp_Set_Proxy alias "IAMVideoProcAmp_Set_Proxy" (byval This as IAMVideoProcAmp ptr, byval Property as integer, byval lValue as integer, byval Flags as integer) as HRESULT
declare sub IAMVideoProcAmp_Set_Stub alias "IAMVideoProcAmp_Set_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVideoProcAmp_Get_Proxy alias "IAMVideoProcAmp_Get_Proxy" (byval This as IAMVideoProcAmp ptr, byval Property as integer, byval lValue as integer ptr, byval Flags as integer ptr) as HRESULT
declare sub IAMVideoProcAmp_Get_Stub alias "IAMVideoProcAmp_Get_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

enum CameraControlProperty
	CameraControl_Pan = 0
	CameraControl_Tilt = CameraControl_Pan+1
	CameraControl_Roll = CameraControl_Tilt+1
	CameraControl_Zoom = CameraControl_Roll+1
	CameraControl_Exposure = CameraControl_Zoom+1
	CameraControl_Iris = CameraControl_Exposure+1
	CameraControl_Focus = CameraControl_Iris+1
end enum

enum CameraControlFlags
	CameraControl_Flags_Auto = &h1
	CameraControl_Flags_Manual = &h2
end enum

extern IID_IAMCameraControl alias "IID_IAMCameraControl" as IID

type IAMCameraControlVtbl_ as IAMCameraControlVtbl

type IAMCameraControl
	lpVtbl as IAMCameraControlVtbl_ ptr
end type

type IAMCameraControlVtbl
	QueryInterface as function(byval as IAMCameraControl ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMCameraControl ptr) as ULONG
	Release as function(byval as IAMCameraControl ptr) as ULONG
	GetRange as function(byval as IAMCameraControl ptr, byval as integer, byval as integer ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr) as HRESULT
	Set as function(byval as IAMCameraControl ptr, byval as integer, byval as integer, byval as integer) as HRESULT
	Get as function(byval as IAMCameraControl ptr, byval as integer, byval as integer ptr, byval as integer ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMCameraControl_GetRange_Proxy alias "IAMCameraControl_GetRange_Proxy" (byval This as IAMCameraControl ptr, byval Property as integer, byval pMin as integer ptr, byval pMax as integer ptr, byval pSteppingDelta as integer ptr, byval pDefault as integer ptr, byval pCapsFlags as integer ptr) as HRESULT
declare sub IAMCameraControl_GetRange_Stub alias "IAMCameraControl_GetRange_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMCameraControl_Set_Proxy alias "IAMCameraControl_Set_Proxy" (byval This as IAMCameraControl ptr, byval Property as integer, byval lValue as integer, byval Flags as integer) as HRESULT
declare sub IAMCameraControl_Set_Stub alias "IAMCameraControl_Set_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMCameraControl_Get_Proxy alias "IAMCameraControl_Get_Proxy" (byval This as IAMCameraControl ptr, byval Property as integer, byval lValue as integer ptr, byval Flags as integer ptr) as HRESULT
declare sub IAMCameraControl_Get_Stub alias "IAMCameraControl_Get_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

enum VideoControlFlags
	VideoControlFlag_FlipHorizontal = &h1
	VideoControlFlag_FlipVertical = &h2
	VideoControlFlag_ExternalTriggerEnable = &h4
	VideoControlFlag_Trigger = &h8
end enum

extern IID_IAMVideoControl alias "IID_IAMVideoControl" as IID

type IAMVideoControlVtbl_ as IAMVideoControlVtbl

type IAMVideoControl
	lpVtbl as IAMVideoControlVtbl_ ptr
end type

type IAMVideoControlVtbl
	QueryInterface as function(byval as IAMVideoControl ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMVideoControl ptr) as ULONG
	Release as function(byval as IAMVideoControl ptr) as ULONG
	GetCaps as function(byval as IAMVideoControl ptr, byval as IPin ptr, byval as integer ptr) as HRESULT
	SetMode as function(byval as IAMVideoControl ptr, byval as IPin ptr, byval as integer) as HRESULT
	GetMode as function(byval as IAMVideoControl ptr, byval as IPin ptr, byval as integer ptr) as HRESULT
	GetCurrentActualFrameRate as function(byval as IAMVideoControl ptr, byval as IPin ptr, byval as LONGLONG ptr) as HRESULT
	GetMaxAvailableFrameRate as function(byval as IAMVideoControl ptr, byval as IPin ptr, byval as integer, byval as SIZE, byval as LONGLONG ptr) as HRESULT
	GetFrameRateList as function(byval as IAMVideoControl ptr, byval as IPin ptr, byval as integer, byval as SIZE, byval as integer ptr, byval as LONGLONG ptr ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMVideoControl_GetCaps_Proxy alias "IAMVideoControl_GetCaps_Proxy" (byval This as IAMVideoControl ptr, byval pPin as IPin ptr, byval pCapsFlags as integer ptr) as HRESULT
declare sub IAMVideoControl_GetCaps_Stub alias "IAMVideoControl_GetCaps_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVideoControl_SetMode_Proxy alias "IAMVideoControl_SetMode_Proxy" (byval This as IAMVideoControl ptr, byval pPin as IPin ptr, byval Mode as integer) as HRESULT
declare sub IAMVideoControl_SetMode_Stub alias "IAMVideoControl_SetMode_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVideoControl_GetMode_Proxy alias "IAMVideoControl_GetMode_Proxy" (byval This as IAMVideoControl ptr, byval pPin as IPin ptr, byval Mode as integer ptr) as HRESULT
declare sub IAMVideoControl_GetMode_Stub alias "IAMVideoControl_GetMode_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVideoControl_GetCurrentActualFrameRate_Proxy alias "IAMVideoControl_GetCurrentActualFrameRate_Proxy" (byval This as IAMVideoControl ptr, byval pPin as IPin ptr, byval ActualFrameRate as LONGLONG ptr) as HRESULT
declare sub IAMVideoControl_GetCurrentActualFrameRate_Stub alias "IAMVideoControl_GetCurrentActualFrameRate_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVideoControl_GetMaxAvailableFrameRate_Proxy alias "IAMVideoControl_GetMaxAvailableFrameRate_Proxy" (byval This as IAMVideoControl ptr, byval pPin as IPin ptr, byval iIndex as integer, byval Dimensions as SIZE, byval MaxAvailableFrameRate as LONGLONG ptr) as HRESULT
declare sub IAMVideoControl_GetMaxAvailableFrameRate_Stub alias "IAMVideoControl_GetMaxAvailableFrameRate_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVideoControl_GetFrameRateList_Proxy alias "IAMVideoControl_GetFrameRateList_Proxy" (byval This as IAMVideoControl ptr, byval pPin as IPin ptr, byval iIndex as integer, byval Dimensions as SIZE, byval ListSize as integer ptr, byval FrameRates as LONGLONG ptr ptr) as HRESULT
declare sub IAMVideoControl_GetFrameRateList_Stub alias "IAMVideoControl_GetFrameRateList_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IAMCrossbar alias "IID_IAMCrossbar" as IID

type IAMCrossbarVtbl_ as IAMCrossbarVtbl

type IAMCrossbar
	lpVtbl as IAMCrossbarVtbl_ ptr
end type

type IAMCrossbarVtbl
	QueryInterface as function(byval as IAMCrossbar ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMCrossbar ptr) as ULONG
	Release as function(byval as IAMCrossbar ptr) as ULONG
	get_PinCounts as function(byval as IAMCrossbar ptr, byval as integer ptr, byval as integer ptr) as HRESULT
	CanRoute as function(byval as IAMCrossbar ptr, byval as integer, byval as integer) as HRESULT
	Route as function(byval as IAMCrossbar ptr, byval as integer, byval as integer) as HRESULT
	get_IsRoutedTo as function(byval as IAMCrossbar ptr, byval as integer, byval as integer ptr) as HRESULT
	get_CrossbarPinInfo as function(byval as IAMCrossbar ptr, byval as BOOL, byval as integer, byval as integer ptr, byval as integer ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMCrossbar_get_PinCounts_Proxy alias "IAMCrossbar_get_PinCounts_Proxy" (byval This as IAMCrossbar ptr, byval OutputPinCount as integer ptr, byval InputPinCount as integer ptr) as HRESULT
declare sub IAMCrossbar_get_PinCounts_Stub alias "IAMCrossbar_get_PinCounts_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMCrossbar_CanRoute_Proxy alias "IAMCrossbar_CanRoute_Proxy" (byval This as IAMCrossbar ptr, byval OutputPinIndex as integer, byval InputPinIndex as integer) as HRESULT
declare sub IAMCrossbar_CanRoute_Stub alias "IAMCrossbar_CanRoute_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMCrossbar_Route_Proxy alias "IAMCrossbar_Route_Proxy" (byval This as IAMCrossbar ptr, byval OutputPinIndex as integer, byval InputPinIndex as integer) as HRESULT
declare sub IAMCrossbar_Route_Stub alias "IAMCrossbar_Route_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMCrossbar_get_IsRoutedTo_Proxy alias "IAMCrossbar_get_IsRoutedTo_Proxy" (byval This as IAMCrossbar ptr, byval OutputPinIndex as integer, byval InputPinIndex as integer ptr) as HRESULT
declare sub IAMCrossbar_get_IsRoutedTo_Stub alias "IAMCrossbar_get_IsRoutedTo_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMCrossbar_get_CrossbarPinInfo_Proxy alias "IAMCrossbar_get_CrossbarPinInfo_Proxy" (byval This as IAMCrossbar ptr, byval IsInputPin as BOOL, byval PinIndex as integer, byval PinIndexRelated as integer ptr, byval PhysicalType as integer ptr) as HRESULT
declare sub IAMCrossbar_get_CrossbarPinInfo_Stub alias "IAMCrossbar_get_CrossbarPinInfo_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

enum AMTunerSubChannel
	AMTUNER_SUBCHAN_NO_TUNE = -2
	AMTUNER_SUBCHAN_DEFAULT = -1
end enum

enum AMTunerSignalStrength
	AMTUNER_HASNOSIGNALSTRENGTH = -1
	AMTUNER_NOSIGNAL = 0
	AMTUNER_SIGNALPRESENT = 1
end enum

enum AMTunerModeType
	AMTUNER_MODE_DEFAULT = 0
	AMTUNER_MODE_TV = &h1
	AMTUNER_MODE_FM_RADIO = &h2
	AMTUNER_MODE_AM_RADIO = &h4
	AMTUNER_MODE_DSS = &h8
end enum

enum AMTunerEventType
	AMTUNER_EVENT_CHANGED = &h1
end enum

extern IID_IAMTuner alias "IID_IAMTuner" as IID

type IAMTunerVtbl_ as IAMTunerVtbl

type IAMTuner
	lpVtbl as IAMTunerVtbl_ ptr
end type

type IAMTunerVtbl
	QueryInterface as function(byval as IAMTuner ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMTuner ptr) as ULONG
	Release as function(byval as IAMTuner ptr) as ULONG
	put_Channel as function(byval as IAMTuner ptr, byval as integer, byval as integer, byval as integer) as HRESULT
	get_Channel as function(byval as IAMTuner ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr) as HRESULT
	ChannelMinMax as function(byval as IAMTuner ptr, byval as integer ptr, byval as integer ptr) as HRESULT
	put_CountryCode as function(byval as IAMTuner ptr, byval as integer) as HRESULT
	get_CountryCode as function(byval as IAMTuner ptr, byval as integer ptr) as HRESULT
	put_TuningSpace as function(byval as IAMTuner ptr, byval as integer) as HRESULT
	get_TuningSpace as function(byval as IAMTuner ptr, byval as integer ptr) as HRESULT
	Logon as function(byval as IAMTuner ptr, byval as HANDLE) as HRESULT
	Logout as function(byval as IAMTuner ptr) as HRESULT
	SignalPresent as function(byval as IAMTuner ptr, byval as integer ptr) as HRESULT
	put_Mode as function(byval as IAMTuner ptr, byval as AMTunerModeType) as HRESULT
	get_Mode as function(byval as IAMTuner ptr, byval as AMTunerModeType ptr) as HRESULT
	GetAvailableModes as function(byval as IAMTuner ptr, byval as integer ptr) as HRESULT
	RegisterNotificationCallBack as function(byval as IAMTuner ptr, byval as IAMTunerNotification_ ptr, byval as integer) as HRESULT
	UnRegisterNotificationCallBack as function(byval as IAMTuner ptr, byval as IAMTunerNotification_ ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMTuner_put_Channel_Proxy alias "IAMTuner_put_Channel_Proxy" (byval This as IAMTuner ptr, byval lChannel as integer, byval lVideoSubChannel as integer, byval lAudioSubChannel as integer) as HRESULT
declare sub IAMTuner_put_Channel_Stub alias "IAMTuner_put_Channel_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTuner_get_Channel_Proxy alias "IAMTuner_get_Channel_Proxy" (byval This as IAMTuner ptr, byval plChannel as integer ptr, byval plVideoSubChannel as integer ptr, byval plAudioSubChannel as integer ptr) as HRESULT
declare sub IAMTuner_get_Channel_Stub alias "IAMTuner_get_Channel_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTuner_ChannelMinMax_Proxy alias "IAMTuner_ChannelMinMax_Proxy" (byval This as IAMTuner ptr, byval lChannelMin as integer ptr, byval lChannelMax as integer ptr) as HRESULT
declare sub IAMTuner_ChannelMinMax_Stub alias "IAMTuner_ChannelMinMax_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTuner_put_CountryCode_Proxy alias "IAMTuner_put_CountryCode_Proxy" (byval This as IAMTuner ptr, byval lCountryCode as integer) as HRESULT
declare sub IAMTuner_put_CountryCode_Stub alias "IAMTuner_put_CountryCode_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTuner_get_CountryCode_Proxy alias "IAMTuner_get_CountryCode_Proxy" (byval This as IAMTuner ptr, byval plCountryCode as integer ptr) as HRESULT
declare sub IAMTuner_get_CountryCode_Stub alias "IAMTuner_get_CountryCode_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTuner_put_TuningSpace_Proxy alias "IAMTuner_put_TuningSpace_Proxy" (byval This as IAMTuner ptr, byval lTuningSpace as integer) as HRESULT
declare sub IAMTuner_put_TuningSpace_Stub alias "IAMTuner_put_TuningSpace_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTuner_get_TuningSpace_Proxy alias "IAMTuner_get_TuningSpace_Proxy" (byval This as IAMTuner ptr, byval plTuningSpace as integer ptr) as HRESULT
declare sub IAMTuner_get_TuningSpace_Stub alias "IAMTuner_get_TuningSpace_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTuner_Logon_Proxy alias "IAMTuner_Logon_Proxy" (byval This as IAMTuner ptr, byval hCurrentUser as HANDLE) as HRESULT
declare sub IAMTuner_Logon_Stub alias "IAMTuner_Logon_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTuner_Logout_Proxy alias "IAMTuner_Logout_Proxy" (byval This as IAMTuner ptr) as HRESULT
declare sub IAMTuner_Logout_Stub alias "IAMTuner_Logout_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTuner_SignalPresent_Proxy alias "IAMTuner_SignalPresent_Proxy" (byval This as IAMTuner ptr, byval plSignalStrength as integer ptr) as HRESULT
declare sub IAMTuner_SignalPresent_Stub alias "IAMTuner_SignalPresent_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTuner_put_Mode_Proxy alias "IAMTuner_put_Mode_Proxy" (byval This as IAMTuner ptr, byval lMode as AMTunerModeType) as HRESULT
declare sub IAMTuner_put_Mode_Stub alias "IAMTuner_put_Mode_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTuner_get_Mode_Proxy alias "IAMTuner_get_Mode_Proxy" (byval This as IAMTuner ptr, byval plMode as AMTunerModeType ptr) as HRESULT
declare sub IAMTuner_get_Mode_Stub alias "IAMTuner_get_Mode_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTuner_GetAvailableModes_Proxy alias "IAMTuner_GetAvailableModes_Proxy" (byval This as IAMTuner ptr, byval plModes as integer ptr) as HRESULT
declare sub IAMTuner_GetAvailableModes_Stub alias "IAMTuner_GetAvailableModes_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTuner_RegisterNotificationCallBack_Proxy alias "IAMTuner_RegisterNotificationCallBack_Proxy" (byval This as IAMTuner ptr, byval pNotify as IAMTunerNotification ptr, byval lEvents as integer) as HRESULT
declare sub IAMTuner_RegisterNotificationCallBack_Stub alias "IAMTuner_RegisterNotificationCallBack_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTuner_UnRegisterNotificationCallBack_Proxy alias "IAMTuner_UnRegisterNotificationCallBack_Proxy" (byval This as IAMTuner ptr, byval pNotify as IAMTunerNotification ptr) as HRESULT
declare sub IAMTuner_UnRegisterNotificationCallBack_Stub alias "IAMTuner_UnRegisterNotificationCallBack_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IAMTunerNotification alias "IID_IAMTunerNotification" as IID

type IAMTunerNotificationVtbl_ as IAMTunerNotificationVtbl

type IAMTunerNotification
	lpVtbl as IAMTunerNotificationVtbl_ ptr
end type

type IAMTunerNotificationVtbl
	QueryInterface as function(byval as IAMTunerNotification ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMTunerNotification ptr) as ULONG
	Release as function(byval as IAMTunerNotification ptr) as ULONG
	OnEvent as function(byval as IAMTunerNotification ptr, byval as AMTunerEventType) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMTunerNotification_OnEvent_Proxy alias "IAMTunerNotification_OnEvent_Proxy" (byval This as IAMTunerNotification ptr, byval Event as AMTunerEventType) as HRESULT
declare sub IAMTunerNotification_OnEvent_Stub alias "IAMTunerNotification_OnEvent_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IAMTVTuner alias "IID_IAMTVTuner" as IID

type IAMTVTunerVtbl_ as IAMTVTunerVtbl

type IAMTVTuner
	lpVtbl as IAMTVTunerVtbl_ ptr
end type

type IAMTVTunerVtbl
	QueryInterface as function(byval as IAMTVTuner ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMTVTuner ptr) as ULONG
	Release as function(byval as IAMTVTuner ptr) as ULONG
	put_Channel as function(byval as IAMTVTuner ptr, byval as integer, byval as integer, byval as integer) as HRESULT
	get_Channel as function(byval as IAMTVTuner ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr) as HRESULT
	ChannelMinMax as function(byval as IAMTVTuner ptr, byval as integer ptr, byval as integer ptr) as HRESULT
	put_CountryCode as function(byval as IAMTVTuner ptr, byval as integer) as HRESULT
	get_CountryCode as function(byval as IAMTVTuner ptr, byval as integer ptr) as HRESULT
	put_TuningSpace as function(byval as IAMTVTuner ptr, byval as integer) as HRESULT
	get_TuningSpace as function(byval as IAMTVTuner ptr, byval as integer ptr) as HRESULT
	Logon as function(byval as IAMTVTuner ptr, byval as HANDLE) as HRESULT
	Logout as function(byval as IAMTVTuner ptr) as HRESULT
	SignalPresent as function(byval as IAMTVTuner ptr, byval as integer ptr) as HRESULT
	put_Mode as function(byval as IAMTVTuner ptr, byval as AMTunerModeType) as HRESULT
	get_Mode as function(byval as IAMTVTuner ptr, byval as AMTunerModeType ptr) as HRESULT
	GetAvailableModes as function(byval as IAMTVTuner ptr, byval as integer ptr) as HRESULT
	RegisterNotificationCallBack as function(byval as IAMTVTuner ptr, byval as IAMTunerNotification ptr, byval as integer) as HRESULT
	UnRegisterNotificationCallBack as function(byval as IAMTVTuner ptr, byval as IAMTunerNotification ptr) as HRESULT
	get_AvailableTVFormats as function(byval as IAMTVTuner ptr, byval as integer ptr) as HRESULT
	get_TVFormat as function(byval as IAMTVTuner ptr, byval as integer ptr) as HRESULT
	AutoTune as function(byval as IAMTVTuner ptr, byval as integer, byval as integer ptr) as HRESULT
	StoreAutoTune as function(byval as IAMTVTuner ptr) as HRESULT
	get_NumInputConnections as function(byval as IAMTVTuner ptr, byval as integer ptr) as HRESULT
	put_InputType as function(byval as IAMTVTuner ptr, byval as integer, byval as TunerInputType) as HRESULT
	get_InputType as function(byval as IAMTVTuner ptr, byval as integer, byval as TunerInputType ptr) as HRESULT
	put_ConnectInput as function(byval as IAMTVTuner ptr, byval as integer) as HRESULT
	get_ConnectInput as function(byval as IAMTVTuner ptr, byval as integer ptr) as HRESULT
	get_VideoFrequency as function(byval as IAMTVTuner ptr, byval as integer ptr) as HRESULT
	get_AudioFrequency as function(byval as IAMTVTuner ptr, byval as integer ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMTVTuner_get_AvailableTVFormats_Proxy alias "IAMTVTuner_get_AvailableTVFormats_Proxy" (byval This as IAMTVTuner ptr, byval lAnalogVideoStandard as integer ptr) as HRESULT
declare sub IAMTVTuner_get_AvailableTVFormats_Stub alias "IAMTVTuner_get_AvailableTVFormats_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTVTuner_get_TVFormat_Proxy alias "IAMTVTuner_get_TVFormat_Proxy" (byval This as IAMTVTuner ptr, byval plAnalogVideoStandard as integer ptr) as HRESULT
declare sub IAMTVTuner_get_TVFormat_Stub alias "IAMTVTuner_get_TVFormat_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTVTuner_AutoTune_Proxy alias "IAMTVTuner_AutoTune_Proxy" (byval This as IAMTVTuner ptr, byval lChannel as integer, byval plFoundSignal as integer ptr) as HRESULT
declare sub IAMTVTuner_AutoTune_Stub alias "IAMTVTuner_AutoTune_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTVTuner_StoreAutoTune_Proxy alias "IAMTVTuner_StoreAutoTune_Proxy" (byval This as IAMTVTuner ptr) as HRESULT
declare sub IAMTVTuner_StoreAutoTune_Stub alias "IAMTVTuner_StoreAutoTune_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTVTuner_get_NumInputConnections_Proxy alias "IAMTVTuner_get_NumInputConnections_Proxy" (byval This as IAMTVTuner ptr, byval plNumInputConnections as integer ptr) as HRESULT
declare sub IAMTVTuner_get_NumInputConnections_Stub alias "IAMTVTuner_get_NumInputConnections_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTVTuner_put_InputType_Proxy alias "IAMTVTuner_put_InputType_Proxy" (byval This as IAMTVTuner ptr, byval lIndex as integer, byval InputType as TunerInputType) as HRESULT
declare sub IAMTVTuner_put_InputType_Stub alias "IAMTVTuner_put_InputType_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTVTuner_get_InputType_Proxy alias "IAMTVTuner_get_InputType_Proxy" (byval This as IAMTVTuner ptr, byval lIndex as integer, byval pInputType as TunerInputType ptr) as HRESULT
declare sub IAMTVTuner_get_InputType_Stub alias "IAMTVTuner_get_InputType_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTVTuner_put_ConnectInput_Proxy alias "IAMTVTuner_put_ConnectInput_Proxy" (byval This as IAMTVTuner ptr, byval lIndex as integer) as HRESULT
declare sub IAMTVTuner_put_ConnectInput_Stub alias "IAMTVTuner_put_ConnectInput_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTVTuner_get_ConnectInput_Proxy alias "IAMTVTuner_get_ConnectInput_Proxy" (byval This as IAMTVTuner ptr, byval plIndex as integer ptr) as HRESULT
declare sub IAMTVTuner_get_ConnectInput_Stub alias "IAMTVTuner_get_ConnectInput_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTVTuner_get_VideoFrequency_Proxy alias "IAMTVTuner_get_VideoFrequency_Proxy" (byval This as IAMTVTuner ptr, byval lFreq as integer ptr) as HRESULT
declare sub IAMTVTuner_get_VideoFrequency_Stub alias "IAMTVTuner_get_VideoFrequency_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTVTuner_get_AudioFrequency_Proxy alias "IAMTVTuner_get_AudioFrequency_Proxy" (byval This as IAMTVTuner ptr, byval lFreq as integer ptr) as HRESULT
declare sub IAMTVTuner_get_AudioFrequency_Stub alias "IAMTVTuner_get_AudioFrequency_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IBPCSatelliteTuner alias "IID_IBPCSatelliteTuner" as IID

type IBPCSatelliteTunerVtbl_ as IBPCSatelliteTunerVtbl

type IBPCSatelliteTuner
	lpVtbl as IBPCSatelliteTunerVtbl_ ptr
end type

type IBPCSatelliteTunerVtbl
	QueryInterface as function(byval as IBPCSatelliteTuner ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IBPCSatelliteTuner ptr) as ULONG
	Release as function(byval as IBPCSatelliteTuner ptr) as ULONG
	put_Channel as function(byval as IBPCSatelliteTuner ptr, byval as integer, byval as integer, byval as integer) as HRESULT
	get_Channel as function(byval as IBPCSatelliteTuner ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr) as HRESULT
	ChannelMinMax as function(byval as IBPCSatelliteTuner ptr, byval as integer ptr, byval as integer ptr) as HRESULT
	put_CountryCode as function(byval as IBPCSatelliteTuner ptr, byval as integer) as HRESULT
	get_CountryCode as function(byval as IBPCSatelliteTuner ptr, byval as integer ptr) as HRESULT
	put_TuningSpace as function(byval as IBPCSatelliteTuner ptr, byval as integer) as HRESULT
	get_TuningSpace as function(byval as IBPCSatelliteTuner ptr, byval as integer ptr) as HRESULT
	Logon as function(byval as IBPCSatelliteTuner ptr, byval as HANDLE) as HRESULT
	Logout as function(byval as IBPCSatelliteTuner ptr) as HRESULT
	SignalPresent as function(byval as IBPCSatelliteTuner ptr, byval as integer ptr) as HRESULT
	put_Mode as function(byval as IBPCSatelliteTuner ptr, byval as AMTunerModeType) as HRESULT
	get_Mode as function(byval as IBPCSatelliteTuner ptr, byval as AMTunerModeType ptr) as HRESULT
	GetAvailableModes as function(byval as IBPCSatelliteTuner ptr, byval as integer ptr) as HRESULT
	RegisterNotificationCallBack as function(byval as IBPCSatelliteTuner ptr, byval as IAMTunerNotification ptr, byval as integer) as HRESULT
	UnRegisterNotificationCallBack as function(byval as IBPCSatelliteTuner ptr, byval as IAMTunerNotification ptr) as HRESULT
	get_DefaultSubChannelTypes as function(byval as IBPCSatelliteTuner ptr, byval as integer ptr, byval as integer ptr) as HRESULT
	put_DefaultSubChannelTypes as function(byval as IBPCSatelliteTuner ptr, byval as integer, byval as integer) as HRESULT
	IsTapingPermitted as function(byval as IBPCSatelliteTuner ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IBPCSatelliteTuner_get_DefaultSubChannelTypes_Proxy alias "IBPCSatelliteTuner_get_DefaultSubChannelTypes_Proxy" (byval This as IBPCSatelliteTuner ptr, byval plDefaultVideoType as integer ptr, byval plDefaultAudioType as integer ptr) as HRESULT
declare sub IBPCSatelliteTuner_get_DefaultSubChannelTypes_Stub alias "IBPCSatelliteTuner_get_DefaultSubChannelTypes_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBPCSatelliteTuner_put_DefaultSubChannelTypes_Proxy alias "IBPCSatelliteTuner_put_DefaultSubChannelTypes_Proxy" (byval This as IBPCSatelliteTuner ptr, byval lDefaultVideoType as integer, byval lDefaultAudioType as integer) as HRESULT
declare sub IBPCSatelliteTuner_put_DefaultSubChannelTypes_Stub alias "IBPCSatelliteTuner_put_DefaultSubChannelTypes_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IBPCSatelliteTuner_IsTapingPermitted_Proxy alias "IBPCSatelliteTuner_IsTapingPermitted_Proxy" (byval This as IBPCSatelliteTuner ptr) as HRESULT
declare sub IBPCSatelliteTuner_IsTapingPermitted_Stub alias "IBPCSatelliteTuner_IsTapingPermitted_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

enum TVAudioMode
	AMTVAUDIO_MODE_MONO = &h1
	AMTVAUDIO_MODE_STEREO = &h2
	AMTVAUDIO_MODE_LANG_A = &h10
	AMTVAUDIO_MODE_LANG_B = &h20
	AMTVAUDIO_MODE_LANG_C = &h40
end enum

enum AMTVAudioEventType
	AMTVAUDIO_EVENT_CHANGED = &h1
end enum

extern IID_IAMTVAudio alias "IID_IAMTVAudio" as IID

type IAMTVAudioVtbl_ as IAMTVAudioVtbl

type IAMTVAudio
	lpVtbl as IAMTVAudioVtbl_ ptr
end type

type IAMTVAudioVtbl
	QueryInterface as function(byval as IAMTVAudio ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMTVAudio ptr) as ULONG
	Release as function(byval as IAMTVAudio ptr) as ULONG
	GetHardwareSupportedTVAudioModes as function(byval as IAMTVAudio ptr, byval as integer ptr) as HRESULT
	GetAvailableTVAudioModes as function(byval as IAMTVAudio ptr, byval as integer ptr) as HRESULT
	get_TVAudioMode as function(byval as IAMTVAudio ptr, byval as integer ptr) as HRESULT
	put_TVAudioMode as function(byval as IAMTVAudio ptr, byval as integer) as HRESULT
	RegisterNotificationCallBack as function(byval as IAMTVAudio ptr, byval as IAMTunerNotification ptr, byval as integer) as HRESULT
	UnRegisterNotificationCallBack as function(byval as IAMTVAudio ptr, byval as IAMTunerNotification ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMTVAudio_GetHardwareSupportedTVAudioModes_Proxy alias "IAMTVAudio_GetHardwareSupportedTVAudioModes_Proxy" (byval This as IAMTVAudio ptr, byval plModes as integer ptr) as HRESULT
declare sub IAMTVAudio_GetHardwareSupportedTVAudioModes_Stub alias "IAMTVAudio_GetHardwareSupportedTVAudioModes_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTVAudio_GetAvailableTVAudioModes_Proxy alias "IAMTVAudio_GetAvailableTVAudioModes_Proxy" (byval This as IAMTVAudio ptr, byval plModes as integer ptr) as HRESULT
declare sub IAMTVAudio_GetAvailableTVAudioModes_Stub alias "IAMTVAudio_GetAvailableTVAudioModes_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTVAudio_get_TVAudioMode_Proxy alias "IAMTVAudio_get_TVAudioMode_Proxy" (byval This as IAMTVAudio ptr, byval plMode as integer ptr) as HRESULT
declare sub IAMTVAudio_get_TVAudioMode_Stub alias "IAMTVAudio_get_TVAudioMode_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTVAudio_put_TVAudioMode_Proxy alias "IAMTVAudio_put_TVAudioMode_Proxy" (byval This as IAMTVAudio ptr, byval lMode as integer) as HRESULT
declare sub IAMTVAudio_put_TVAudioMode_Stub alias "IAMTVAudio_put_TVAudioMode_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTVAudio_RegisterNotificationCallBack_Proxy alias "IAMTVAudio_RegisterNotificationCallBack_Proxy" (byval This as IAMTVAudio ptr, byval pNotify as IAMTunerNotification ptr, byval lEvents as integer) as HRESULT
declare sub IAMTVAudio_RegisterNotificationCallBack_Stub alias "IAMTVAudio_RegisterNotificationCallBack_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTVAudio_UnRegisterNotificationCallBack_Proxy alias "IAMTVAudio_UnRegisterNotificationCallBack_Proxy" (byval This as IAMTVAudio ptr, byval pNotify as IAMTunerNotification ptr) as HRESULT
declare sub IAMTVAudio_UnRegisterNotificationCallBack_Stub alias "IAMTVAudio_UnRegisterNotificationCallBack_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IAMTVAudioNotification alias "IID_IAMTVAudioNotification" as IID

type IAMTVAudioNotificationVtbl_ as IAMTVAudioNotificationVtbl

type IAMTVAudioNotification
	lpVtbl as IAMTVAudioNotificationVtbl_ ptr
end type

type IAMTVAudioNotificationVtbl
	QueryInterface as function(byval as IAMTVAudioNotification ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMTVAudioNotification ptr) as ULONG
	Release as function(byval as IAMTVAudioNotification ptr) as ULONG
	OnEvent as function(byval as IAMTVAudioNotification ptr, byval as AMTVAudioEventType) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMTVAudioNotification_OnEvent_Proxy alias "IAMTVAudioNotification_OnEvent_Proxy" (byval This as IAMTVAudioNotification ptr, byval Event as AMTVAudioEventType) as HRESULT
declare sub IAMTVAudioNotification_OnEvent_Stub alias "IAMTVAudioNotification_OnEvent_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IAMAnalogVideoEncoder alias "IID_IAMAnalogVideoEncoder" as IID

type IAMAnalogVideoEncoderVtbl_ as IAMAnalogVideoEncoderVtbl

type IAMAnalogVideoEncoder
	lpVtbl as IAMAnalogVideoEncoderVtbl_ ptr
end type

type IAMAnalogVideoEncoderVtbl
	QueryInterface as function(byval as IAMAnalogVideoEncoder ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMAnalogVideoEncoder ptr) as ULONG
	Release as function(byval as IAMAnalogVideoEncoder ptr) as ULONG
	get_AvailableTVFormats as function(byval as IAMAnalogVideoEncoder ptr, byval as integer ptr) as HRESULT
	put_TVFormat as function(byval as IAMAnalogVideoEncoder ptr, byval as integer) as HRESULT
	get_TVFormat as function(byval as IAMAnalogVideoEncoder ptr, byval as integer ptr) as HRESULT
	put_CopyProtection as function(byval as IAMAnalogVideoEncoder ptr, byval as integer) as HRESULT
	get_CopyProtection as function(byval as IAMAnalogVideoEncoder ptr, byval as integer ptr) as HRESULT
	put_CCEnable as function(byval as IAMAnalogVideoEncoder ptr, byval as integer) as HRESULT
	get_CCEnable as function(byval as IAMAnalogVideoEncoder ptr, byval as integer ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMAnalogVideoEncoder_get_AvailableTVFormats_Proxy alias "IAMAnalogVideoEncoder_get_AvailableTVFormats_Proxy" (byval This as IAMAnalogVideoEncoder ptr, byval lAnalogVideoStandard as integer ptr) as HRESULT
declare sub IAMAnalogVideoEncoder_get_AvailableTVFormats_Stub alias "IAMAnalogVideoEncoder_get_AvailableTVFormats_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAnalogVideoEncoder_put_TVFormat_Proxy alias "IAMAnalogVideoEncoder_put_TVFormat_Proxy" (byval This as IAMAnalogVideoEncoder ptr, byval lAnalogVideoStandard as integer) as HRESULT
declare sub IAMAnalogVideoEncoder_put_TVFormat_Stub alias "IAMAnalogVideoEncoder_put_TVFormat_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAnalogVideoEncoder_get_TVFormat_Proxy alias "IAMAnalogVideoEncoder_get_TVFormat_Proxy" (byval This as IAMAnalogVideoEncoder ptr, byval plAnalogVideoStandard as integer ptr) as HRESULT
declare sub IAMAnalogVideoEncoder_get_TVFormat_Stub alias "IAMAnalogVideoEncoder_get_TVFormat_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAnalogVideoEncoder_put_CopyProtection_Proxy alias "IAMAnalogVideoEncoder_put_CopyProtection_Proxy" (byval This as IAMAnalogVideoEncoder ptr, byval lVideoCopyProtection as integer) as HRESULT
declare sub IAMAnalogVideoEncoder_put_CopyProtection_Stub alias "IAMAnalogVideoEncoder_put_CopyProtection_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAnalogVideoEncoder_get_CopyProtection_Proxy alias "IAMAnalogVideoEncoder_get_CopyProtection_Proxy" (byval This as IAMAnalogVideoEncoder ptr, byval lVideoCopyProtection as integer ptr) as HRESULT
declare sub IAMAnalogVideoEncoder_get_CopyProtection_Stub alias "IAMAnalogVideoEncoder_get_CopyProtection_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAnalogVideoEncoder_put_CCEnable_Proxy alias "IAMAnalogVideoEncoder_put_CCEnable_Proxy" (byval This as IAMAnalogVideoEncoder ptr, byval lCCEnable as integer) as HRESULT
declare sub IAMAnalogVideoEncoder_put_CCEnable_Stub alias "IAMAnalogVideoEncoder_put_CCEnable_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMAnalogVideoEncoder_get_CCEnable_Proxy alias "IAMAnalogVideoEncoder_get_CCEnable_Proxy" (byval This as IAMAnalogVideoEncoder ptr, byval lCCEnable as integer ptr) as HRESULT
declare sub IAMAnalogVideoEncoder_get_CCEnable_Stub alias "IAMAnalogVideoEncoder_get_CCEnable_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

enum AMPROPERTY_PIN
	AMPROPERTY_PIN_CATEGORY = 0
	AMPROPERTY_PIN_MEDIUM = AMPROPERTY_PIN_CATEGORY+1
end enum

#define KSPROPERTY_SUPPORT_GET 1
#define KSPROPERTY_SUPPORT_SET 2
extern IID_IKsPropertySet alias "IID_IKsPropertySet" as IID

type IKsPropertySetVtbl_ as IKsPropertySetVtbl

type IKsPropertySet
	lpVtbl as IKsPropertySetVtbl_ ptr
end type

type IKsPropertySetVtbl
	QueryInterface as function(byval as IKsPropertySet ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IKsPropertySet ptr) as ULONG
	Release as function(byval as IKsPropertySet ptr) as ULONG
	Set as function(byval as IKsPropertySet ptr, byval as GUID ptr, byval as DWORD, byval as LPVOID, byval as DWORD, byval as LPVOID, byval as DWORD) as HRESULT
	Get as function(byval as IKsPropertySet ptr, byval as GUID ptr, byval as DWORD, byval as LPVOID, byval as DWORD, byval as LPVOID, byval as DWORD, byval as DWORD ptr) as HRESULT
	QuerySupported as function(byval as IKsPropertySet ptr, byval as GUID ptr, byval as DWORD, byval as DWORD ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IKsPropertySet_RemoteSet_Proxy alias "IKsPropertySet_RemoteSet_Proxy" (byval This as IKsPropertySet ptr, byval guidPropSet as GUID ptr, byval dwPropID as DWORD, byval pInstanceData as byte ptr, byval cbInstanceData as DWORD, byval pPropData as byte ptr, byval cbPropData as DWORD) as HRESULT
declare sub IKsPropertySet_RemoteSet_Stub alias "IKsPropertySet_RemoteSet_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IKsPropertySet_RemoteGet_Proxy alias "IKsPropertySet_RemoteGet_Proxy" (byval This as IKsPropertySet ptr, byval guidPropSet as GUID ptr, byval dwPropID as DWORD, byval pInstanceData as byte ptr, byval cbInstanceData as DWORD, byval pPropData as byte ptr, byval cbPropData as DWORD, byval pcbReturned as DWORD ptr) as HRESULT
declare sub IKsPropertySet_RemoteGet_Stub alias "IKsPropertySet_RemoteGet_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IKsPropertySet_QuerySupported_Proxy alias "IKsPropertySet_QuerySupported_Proxy" (byval This as IKsPropertySet ptr, byval guidPropSet as GUID ptr, byval dwPropID as DWORD, byval pTypeSupport as DWORD ptr) as HRESULT
declare sub IKsPropertySet_QuerySupported_Stub alias "IKsPropertySet_QuerySupported_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type LPMEDIAPROPERTYBAG as IMediaPropertyBag ptr
extern IID_IMediaPropertyBag alias "IID_IMediaPropertyBag" as IID

type IMediaPropertyBagVtbl_ as IMediaPropertyBagVtbl

type IMediaPropertyBag
	lpVtbl as IMediaPropertyBagVtbl_ ptr
end type

type IMediaPropertyBagVtbl
	QueryInterface as function(byval as IMediaPropertyBag ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IMediaPropertyBag ptr) as ULONG
	Release as function(byval as IMediaPropertyBag ptr) as ULONG
	Read as function(byval as IMediaPropertyBag ptr, byval as LPCOLESTR, byval as VARIANT ptr, byval as IErrorLog ptr) as HRESULT
	Write as function(byval as IMediaPropertyBag ptr, byval as LPCOLESTR, byval as VARIANT ptr) as HRESULT
	EnumProperty as function(byval as IMediaPropertyBag ptr, byval as ULONG, byval as VARIANT ptr, byval as VARIANT ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IMediaPropertyBag_EnumProperty_Proxy alias "IMediaPropertyBag_EnumProperty_Proxy" (byval This as IMediaPropertyBag ptr, byval iProperty as ULONG, byval pvarPropertyName as VARIANT ptr, byval pvarPropertyValue as VARIANT ptr) as HRESULT
declare sub IMediaPropertyBag_EnumProperty_Stub alias "IMediaPropertyBag_EnumProperty_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type LPPERSISTMEDIAPROPERTYBAG as IPersistMediaPropertyBag ptr
extern IID_IPersistMediaPropertyBag alias "IID_IPersistMediaPropertyBag" as IID

type IPersistMediaPropertyBagVtbl_ as IPersistMediaPropertyBagVtbl

type IPersistMediaPropertyBag
	lpVtbl as IPersistMediaPropertyBagVtbl_ ptr
end type

type IPersistMediaPropertyBagVtbl
	QueryInterface as function(byval as IPersistMediaPropertyBag ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IPersistMediaPropertyBag ptr) as ULONG
	Release as function(byval as IPersistMediaPropertyBag ptr) as ULONG
	GetClassID as function(byval as IPersistMediaPropertyBag ptr, byval as CLSID ptr) as HRESULT
	InitNew as function(byval as IPersistMediaPropertyBag ptr) as HRESULT
	Load as function(byval as IPersistMediaPropertyBag ptr, byval as IMediaPropertyBag ptr, byval as IErrorLog ptr) as HRESULT
	Save as function(byval as IPersistMediaPropertyBag ptr, byval as IMediaPropertyBag ptr, byval as BOOL, byval as BOOL) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IPersistMediaPropertyBag_InitNew_Proxy alias "IPersistMediaPropertyBag_InitNew_Proxy" (byval This as IPersistMediaPropertyBag ptr) as HRESULT
declare sub IPersistMediaPropertyBag_InitNew_Stub alias "IPersistMediaPropertyBag_InitNew_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPersistMediaPropertyBag_Load_Proxy alias "IPersistMediaPropertyBag_Load_Proxy" (byval This as IPersistMediaPropertyBag ptr, byval pPropBag as IMediaPropertyBag ptr, byval pErrorLog as IErrorLog ptr) as HRESULT
declare sub IPersistMediaPropertyBag_Load_Stub alias "IPersistMediaPropertyBag_Load_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPersistMediaPropertyBag_Save_Proxy alias "IPersistMediaPropertyBag_Save_Proxy" (byval This as IPersistMediaPropertyBag ptr, byval pPropBag as IMediaPropertyBag ptr, byval fClearDirty as BOOL, byval fSaveAllProperties as BOOL) as HRESULT
declare sub IPersistMediaPropertyBag_Save_Stub alias "IPersistMediaPropertyBag_Save_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IAMPhysicalPinInfo alias "IID_IAMPhysicalPinInfo" as IID

type IAMPhysicalPinInfoVtbl_ as IAMPhysicalPinInfoVtbl

type IAMPhysicalPinInfo
	lpVtbl as IAMPhysicalPinInfoVtbl_ ptr
end type

type IAMPhysicalPinInfoVtbl
	QueryInterface as function(byval as IAMPhysicalPinInfo ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMPhysicalPinInfo ptr) as ULONG
	Release as function(byval as IAMPhysicalPinInfo ptr) as ULONG
	GetPhysicalType as function(byval as IAMPhysicalPinInfo ptr, byval as integer ptr, byval as LPOLESTR ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMPhysicalPinInfo_GetPhysicalType_Proxy alias "IAMPhysicalPinInfo_GetPhysicalType_Proxy" (byval This as IAMPhysicalPinInfo ptr, byval pType as integer ptr, byval ppszType as LPOLESTR ptr) as HRESULT
declare sub IAMPhysicalPinInfo_GetPhysicalType_Stub alias "IAMPhysicalPinInfo_GetPhysicalType_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type PAMPHYSICALPININFO as IAMPhysicalPinInfo ptr
extern IID_IAMExtDevice alias "IID_IAMExtDevice" as IID

type IAMExtDeviceVtbl_ as IAMExtDeviceVtbl

type IAMExtDevice
	lpVtbl as IAMExtDeviceVtbl_ ptr
end type

type IAMExtDeviceVtbl
	QueryInterface as function(byval as IAMExtDevice ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMExtDevice ptr) as ULONG
	Release as function(byval as IAMExtDevice ptr) as ULONG
	GetCapability as function(byval as IAMExtDevice ptr, byval as integer, byval as integer ptr, byval as double ptr) as HRESULT
	get_ExternalDeviceID as function(byval as IAMExtDevice ptr, byval as LPOLESTR ptr) as HRESULT
	get_ExternalDeviceVersion as function(byval as IAMExtDevice ptr, byval as LPOLESTR ptr) as HRESULT
	put_DevicePower as function(byval as IAMExtDevice ptr, byval as integer) as HRESULT
	get_DevicePower as function(byval as IAMExtDevice ptr, byval as integer ptr) as HRESULT
	Calibrate as function(byval as IAMExtDevice ptr, byval as HEVENT, byval as integer, byval as integer ptr) as HRESULT
	put_DevicePort as function(byval as IAMExtDevice ptr, byval as integer) as HRESULT
	get_DevicePort as function(byval as IAMExtDevice ptr, byval as integer ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMExtDevice_GetCapability_Proxy alias "IAMExtDevice_GetCapability_Proxy" (byval This as IAMExtDevice ptr, byval Capability as integer, byval pValue as integer ptr, byval pdblValue as double ptr) as HRESULT
declare sub IAMExtDevice_GetCapability_Stub alias "IAMExtDevice_GetCapability_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtDevice_get_ExternalDeviceID_Proxy alias "IAMExtDevice_get_ExternalDeviceID_Proxy" (byval This as IAMExtDevice ptr, byval ppszData as LPOLESTR ptr) as HRESULT
declare sub IAMExtDevice_get_ExternalDeviceID_Stub alias "IAMExtDevice_get_ExternalDeviceID_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtDevice_get_ExternalDeviceVersion_Proxy alias "IAMExtDevice_get_ExternalDeviceVersion_Proxy" (byval This as IAMExtDevice ptr, byval ppszData as LPOLESTR ptr) as HRESULT
declare sub IAMExtDevice_get_ExternalDeviceVersion_Stub alias "IAMExtDevice_get_ExternalDeviceVersion_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtDevice_put_DevicePower_Proxy alias "IAMExtDevice_put_DevicePower_Proxy" (byval This as IAMExtDevice ptr, byval PowerMode as integer) as HRESULT
declare sub IAMExtDevice_put_DevicePower_Stub alias "IAMExtDevice_put_DevicePower_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtDevice_get_DevicePower_Proxy alias "IAMExtDevice_get_DevicePower_Proxy" (byval This as IAMExtDevice ptr, byval pPowerMode as integer ptr) as HRESULT
declare sub IAMExtDevice_get_DevicePower_Stub alias "IAMExtDevice_get_DevicePower_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtDevice_Calibrate_Proxy alias "IAMExtDevice_Calibrate_Proxy" (byval This as IAMExtDevice ptr, byval hEvent as HEVENT, byval Mode as integer, byval pStatus as integer ptr) as HRESULT
declare sub IAMExtDevice_Calibrate_Stub alias "IAMExtDevice_Calibrate_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtDevice_put_DevicePort_Proxy alias "IAMExtDevice_put_DevicePort_Proxy" (byval This as IAMExtDevice ptr, byval DevicePort as integer) as HRESULT
declare sub IAMExtDevice_put_DevicePort_Stub alias "IAMExtDevice_put_DevicePort_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtDevice_get_DevicePort_Proxy alias "IAMExtDevice_get_DevicePort_Proxy" (byval This as IAMExtDevice ptr, byval pDevicePort as integer ptr) as HRESULT
declare sub IAMExtDevice_get_DevicePort_Stub alias "IAMExtDevice_get_DevicePort_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type PEXTDEVICE as IAMExtDevice ptr
extern IID_IAMExtTransport alias "IID_IAMExtTransport" as IID

type IAMExtTransportVtbl_ as IAMExtTransportVtbl

type IAMExtTransport
	lpVtbl as IAMExtTransportVtbl_ ptr
end type

type IAMExtTransportVtbl
	QueryInterface as function(byval as IAMExtTransport ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMExtTransport ptr) as ULONG
	Release as function(byval as IAMExtTransport ptr) as ULONG
	GetCapability as function(byval as IAMExtTransport ptr, byval as integer, byval as integer ptr, byval as double ptr) as HRESULT
	put_MediaState as function(byval as IAMExtTransport ptr, byval as integer) as HRESULT
	get_MediaState as function(byval as IAMExtTransport ptr, byval as integer ptr) as HRESULT
	put_LocalControl as function(byval as IAMExtTransport ptr, byval as integer) as HRESULT
	get_LocalControl as function(byval as IAMExtTransport ptr, byval as integer ptr) as HRESULT
	GetStatus as function(byval as IAMExtTransport ptr, byval as integer, byval as integer ptr) as HRESULT
	GetTransportBasicParameters as function(byval as IAMExtTransport ptr, byval as integer, byval as integer ptr, byval as LPOLESTR ptr) as HRESULT
	SetTransportBasicParameters as function(byval as IAMExtTransport ptr, byval as integer, byval as integer, byval as LPCOLESTR) as HRESULT
	GetTransportVideoParameters as function(byval as IAMExtTransport ptr, byval as integer, byval as integer ptr) as HRESULT
	SetTransportVideoParameters as function(byval as IAMExtTransport ptr, byval as integer, byval as integer) as HRESULT
	GetTransportAudioParameters as function(byval as IAMExtTransport ptr, byval as integer, byval as integer ptr) as HRESULT
	SetTransportAudioParameters as function(byval as IAMExtTransport ptr, byval as integer, byval as integer) as HRESULT
	put_Mode as function(byval as IAMExtTransport ptr, byval as integer) as HRESULT
	get_Mode as function(byval as IAMExtTransport ptr, byval as integer ptr) as HRESULT
	put_Rate as function(byval as IAMExtTransport ptr, byval as double) as HRESULT
	get_Rate as function(byval as IAMExtTransport ptr, byval as double ptr) as HRESULT
	GetChase as function(byval as IAMExtTransport ptr, byval as integer ptr, byval as integer ptr, byval as HEVENT ptr) as HRESULT
	SetChase as function(byval as IAMExtTransport ptr, byval as integer, byval as integer, byval as HEVENT) as HRESULT
	GetBump as function(byval as IAMExtTransport ptr, byval as integer ptr, byval as integer ptr) as HRESULT
	SetBump as function(byval as IAMExtTransport ptr, byval as integer, byval as integer) as HRESULT
	get_AntiClogControl as function(byval as IAMExtTransport ptr, byval as integer ptr) as HRESULT
	put_AntiClogControl as function(byval as IAMExtTransport ptr, byval as integer) as HRESULT
	GetEditPropertySet as function(byval as IAMExtTransport ptr, byval as integer, byval as integer ptr) as HRESULT
	SetEditPropertySet as function(byval as IAMExtTransport ptr, byval as integer ptr, byval as integer) as HRESULT
	GetEditProperty as function(byval as IAMExtTransport ptr, byval as integer, byval as integer, byval as integer ptr) as HRESULT
	SetEditProperty as function(byval as IAMExtTransport ptr, byval as integer, byval as integer, byval as integer) as HRESULT
	get_EditStart as function(byval as IAMExtTransport ptr, byval as integer ptr) as HRESULT
	put_EditStart as function(byval as IAMExtTransport ptr, byval as integer) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMExtTransport_GetCapability_Proxy alias "IAMExtTransport_GetCapability_Proxy" (byval This as IAMExtTransport ptr, byval Capability as integer, byval pValue as integer ptr, byval pdblValue as double ptr) as HRESULT
declare sub IAMExtTransport_GetCapability_Stub alias "IAMExtTransport_GetCapability_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_put_MediaState_Proxy alias "IAMExtTransport_put_MediaState_Proxy" (byval This as IAMExtTransport ptr, byval State as integer) as HRESULT
declare sub IAMExtTransport_put_MediaState_Stub alias "IAMExtTransport_put_MediaState_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_get_MediaState_Proxy alias "IAMExtTransport_get_MediaState_Proxy" (byval This as IAMExtTransport ptr, byval pState as integer ptr) as HRESULT
declare sub IAMExtTransport_get_MediaState_Stub alias "IAMExtTransport_get_MediaState_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_put_LocalControl_Proxy alias "IAMExtTransport_put_LocalControl_Proxy" (byval This as IAMExtTransport ptr, byval State as integer) as HRESULT
declare sub IAMExtTransport_put_LocalControl_Stub alias "IAMExtTransport_put_LocalControl_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_get_LocalControl_Proxy alias "IAMExtTransport_get_LocalControl_Proxy" (byval This as IAMExtTransport ptr, byval pState as integer ptr) as HRESULT
declare sub IAMExtTransport_get_LocalControl_Stub alias "IAMExtTransport_get_LocalControl_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_GetStatus_Proxy alias "IAMExtTransport_GetStatus_Proxy" (byval This as IAMExtTransport ptr, byval StatusItem as integer, byval pValue as integer ptr) as HRESULT
declare sub IAMExtTransport_GetStatus_Stub alias "IAMExtTransport_GetStatus_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_GetTransportBasicParameters_Proxy alias "IAMExtTransport_GetTransportBasicParameters_Proxy" (byval This as IAMExtTransport ptr, byval Param as integer, byval pValue as integer ptr, byval ppszData as LPOLESTR ptr) as HRESULT
declare sub IAMExtTransport_GetTransportBasicParameters_Stub alias "IAMExtTransport_GetTransportBasicParameters_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_SetTransportBasicParameters_Proxy alias "IAMExtTransport_SetTransportBasicParameters_Proxy" (byval This as IAMExtTransport ptr, byval Param as integer, byval Value as integer, byval pszData as LPCOLESTR) as HRESULT
declare sub IAMExtTransport_SetTransportBasicParameters_Stub alias "IAMExtTransport_SetTransportBasicParameters_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_GetTransportVideoParameters_Proxy alias "IAMExtTransport_GetTransportVideoParameters_Proxy" (byval This as IAMExtTransport ptr, byval Param as integer, byval pValue as integer ptr) as HRESULT
declare sub IAMExtTransport_GetTransportVideoParameters_Stub alias "IAMExtTransport_GetTransportVideoParameters_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_SetTransportVideoParameters_Proxy alias "IAMExtTransport_SetTransportVideoParameters_Proxy" (byval This as IAMExtTransport ptr, byval Param as integer, byval Value as integer) as HRESULT
declare sub IAMExtTransport_SetTransportVideoParameters_Stub alias "IAMExtTransport_SetTransportVideoParameters_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_GetTransportAudioParameters_Proxy alias "IAMExtTransport_GetTransportAudioParameters_Proxy" (byval This as IAMExtTransport ptr, byval Param as integer, byval pValue as integer ptr) as HRESULT
declare sub IAMExtTransport_GetTransportAudioParameters_Stub alias "IAMExtTransport_GetTransportAudioParameters_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_SetTransportAudioParameters_Proxy alias "IAMExtTransport_SetTransportAudioParameters_Proxy" (byval This as IAMExtTransport ptr, byval Param as integer, byval Value as integer) as HRESULT
declare sub IAMExtTransport_SetTransportAudioParameters_Stub alias "IAMExtTransport_SetTransportAudioParameters_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_put_Mode_Proxy alias "IAMExtTransport_put_Mode_Proxy" (byval This as IAMExtTransport ptr, byval Mode as integer) as HRESULT
declare sub IAMExtTransport_put_Mode_Stub alias "IAMExtTransport_put_Mode_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_get_Mode_Proxy alias "IAMExtTransport_get_Mode_Proxy" (byval This as IAMExtTransport ptr, byval pMode as integer ptr) as HRESULT
declare sub IAMExtTransport_get_Mode_Stub alias "IAMExtTransport_get_Mode_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_put_Rate_Proxy alias "IAMExtTransport_put_Rate_Proxy" (byval This as IAMExtTransport ptr, byval dblRate as double) as HRESULT
declare sub IAMExtTransport_put_Rate_Stub alias "IAMExtTransport_put_Rate_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_get_Rate_Proxy alias "IAMExtTransport_get_Rate_Proxy" (byval This as IAMExtTransport ptr, byval pdblRate as double ptr) as HRESULT
declare sub IAMExtTransport_get_Rate_Stub alias "IAMExtTransport_get_Rate_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_GetChase_Proxy alias "IAMExtTransport_GetChase_Proxy" (byval This as IAMExtTransport ptr, byval pEnabled as integer ptr, byval pOffset as integer ptr, byval phEvent as HEVENT ptr) as HRESULT
declare sub IAMExtTransport_GetChase_Stub alias "IAMExtTransport_GetChase_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_SetChase_Proxy alias "IAMExtTransport_SetChase_Proxy" (byval This as IAMExtTransport ptr, byval Enable as integer, byval Offset as integer, byval hEvent as HEVENT) as HRESULT
declare sub IAMExtTransport_SetChase_Stub alias "IAMExtTransport_SetChase_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_GetBump_Proxy alias "IAMExtTransport_GetBump_Proxy" (byval This as IAMExtTransport ptr, byval pSpeed as integer ptr, byval pDuration as integer ptr) as HRESULT
declare sub IAMExtTransport_GetBump_Stub alias "IAMExtTransport_GetBump_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_SetBump_Proxy alias "IAMExtTransport_SetBump_Proxy" (byval This as IAMExtTransport ptr, byval Speed as integer, byval Duration as integer) as HRESULT
declare sub IAMExtTransport_SetBump_Stub alias "IAMExtTransport_SetBump_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_get_AntiClogControl_Proxy alias "IAMExtTransport_get_AntiClogControl_Proxy" (byval This as IAMExtTransport ptr, byval pEnabled as integer ptr) as HRESULT
declare sub IAMExtTransport_get_AntiClogControl_Stub alias "IAMExtTransport_get_AntiClogControl_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_put_AntiClogControl_Proxy alias "IAMExtTransport_put_AntiClogControl_Proxy" (byval This as IAMExtTransport ptr, byval Enable as integer) as HRESULT
declare sub IAMExtTransport_put_AntiClogControl_Stub alias "IAMExtTransport_put_AntiClogControl_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_GetEditPropertySet_Proxy alias "IAMExtTransport_GetEditPropertySet_Proxy" (byval This as IAMExtTransport ptr, byval EditID as integer, byval pState as integer ptr) as HRESULT
declare sub IAMExtTransport_GetEditPropertySet_Stub alias "IAMExtTransport_GetEditPropertySet_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_SetEditPropertySet_Proxy alias "IAMExtTransport_SetEditPropertySet_Proxy" (byval This as IAMExtTransport ptr, byval pEditID as integer ptr, byval State as integer) as HRESULT
declare sub IAMExtTransport_SetEditPropertySet_Stub alias "IAMExtTransport_SetEditPropertySet_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_GetEditProperty_Proxy alias "IAMExtTransport_GetEditProperty_Proxy" (byval This as IAMExtTransport ptr, byval EditID as integer, byval Param as integer, byval pValue as integer ptr) as HRESULT
declare sub IAMExtTransport_GetEditProperty_Stub alias "IAMExtTransport_GetEditProperty_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_SetEditProperty_Proxy alias "IAMExtTransport_SetEditProperty_Proxy" (byval This as IAMExtTransport ptr, byval EditID as integer, byval Param as integer, byval Value as integer) as HRESULT
declare sub IAMExtTransport_SetEditProperty_Stub alias "IAMExtTransport_SetEditProperty_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_get_EditStart_Proxy alias "IAMExtTransport_get_EditStart_Proxy" (byval This as IAMExtTransport ptr, byval pValue as integer ptr) as HRESULT
declare sub IAMExtTransport_get_EditStart_Stub alias "IAMExtTransport_get_EditStart_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMExtTransport_put_EditStart_Proxy alias "IAMExtTransport_put_EditStart_Proxy" (byval This as IAMExtTransport ptr, byval Value as integer) as HRESULT
declare sub IAMExtTransport_put_EditStart_Stub alias "IAMExtTransport_put_EditStart_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type PIAMEXTTRANSPORT as IAMExtTransport ptr

union TIMECODE
	qw as DWORDLONG
end union

type PTIMECODE as TIMECODE ptr

type TIMECODE_SAMPLE
	qwTick as LONGLONG
	timecode as TIMECODE
	dwUser as DWORD
	dwFlags as DWORD
end type

type PTIMECODE_SAMPLE as TIMECODE_SAMPLE ptr
extern IID_IAMTimecodeReader alias "IID_IAMTimecodeReader" as IID

type IAMTimecodeReaderVtbl_ as IAMTimecodeReaderVtbl

type IAMTimecodeReader
	lpVtbl as IAMTimecodeReaderVtbl_ ptr
end type

type IAMTimecodeReaderVtbl
	QueryInterface as function(byval as IAMTimecodeReader ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMTimecodeReader ptr) as ULONG
	Release as function(byval as IAMTimecodeReader ptr) as ULONG
	GetTCRMode as function(byval as IAMTimecodeReader ptr, byval as integer, byval as integer ptr) as HRESULT
	SetTCRMode as function(byval as IAMTimecodeReader ptr, byval as integer, byval as integer) as HRESULT
	put_VITCLine as function(byval as IAMTimecodeReader ptr, byval as integer) as HRESULT
	get_VITCLine as function(byval as IAMTimecodeReader ptr, byval as integer ptr) as HRESULT
	GetTimecode as function(byval as IAMTimecodeReader ptr, byval as PTIMECODE_SAMPLE) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMTimecodeReader_GetTCRMode_Proxy alias "IAMTimecodeReader_GetTCRMode_Proxy" (byval This as IAMTimecodeReader ptr, byval Param as integer, byval pValue as integer ptr) as HRESULT
declare sub IAMTimecodeReader_GetTCRMode_Stub alias "IAMTimecodeReader_GetTCRMode_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTimecodeReader_SetTCRMode_Proxy alias "IAMTimecodeReader_SetTCRMode_Proxy" (byval This as IAMTimecodeReader ptr, byval Param as integer, byval Value as integer) as HRESULT
declare sub IAMTimecodeReader_SetTCRMode_Stub alias "IAMTimecodeReader_SetTCRMode_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTimecodeReader_put_VITCLine_Proxy alias "IAMTimecodeReader_put_VITCLine_Proxy" (byval This as IAMTimecodeReader ptr, byval Line as integer) as HRESULT
declare sub IAMTimecodeReader_put_VITCLine_Stub alias "IAMTimecodeReader_put_VITCLine_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTimecodeReader_get_VITCLine_Proxy alias "IAMTimecodeReader_get_VITCLine_Proxy" (byval This as IAMTimecodeReader ptr, byval pLine as integer ptr) as HRESULT
declare sub IAMTimecodeReader_get_VITCLine_Stub alias "IAMTimecodeReader_get_VITCLine_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTimecodeReader_GetTimecode_Proxy alias "IAMTimecodeReader_GetTimecode_Proxy" (byval This as IAMTimecodeReader ptr, byval pTimecodeSample as PTIMECODE_SAMPLE) as HRESULT
declare sub IAMTimecodeReader_GetTimecode_Stub alias "IAMTimecodeReader_GetTimecode_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type PIAMTIMECODEREADER as IAMTimecodeReader ptr
extern IID_IAMTimecodeGenerator alias "IID_IAMTimecodeGenerator" as IID

type IAMTimecodeGeneratorVtbl_ as IAMTimecodeGeneratorVtbl

type IAMTimecodeGenerator
	lpVtbl as IAMTimecodeGeneratorVtbl_ ptr
end type

type IAMTimecodeGeneratorVtbl
	QueryInterface as function(byval as IAMTimecodeGenerator ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMTimecodeGenerator ptr) as ULONG
	Release as function(byval as IAMTimecodeGenerator ptr) as ULONG
	GetTCGMode as function(byval as IAMTimecodeGenerator ptr, byval as integer, byval as integer ptr) as HRESULT
	SetTCGMode as function(byval as IAMTimecodeGenerator ptr, byval as integer, byval as integer) as HRESULT
	put_VITCLine as function(byval as IAMTimecodeGenerator ptr, byval as integer) as HRESULT
	get_VITCLine as function(byval as IAMTimecodeGenerator ptr, byval as integer ptr) as HRESULT
	SetTimecode as function(byval as IAMTimecodeGenerator ptr, byval as PTIMECODE_SAMPLE) as HRESULT
	GetTimecode as function(byval as IAMTimecodeGenerator ptr, byval as PTIMECODE_SAMPLE) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMTimecodeGenerator_GetTCGMode_Proxy alias "IAMTimecodeGenerator_GetTCGMode_Proxy" (byval This as IAMTimecodeGenerator ptr, byval Param as integer, byval pValue as integer ptr) as HRESULT
declare sub IAMTimecodeGenerator_GetTCGMode_Stub alias "IAMTimecodeGenerator_GetTCGMode_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTimecodeGenerator_SetTCGMode_Proxy alias "IAMTimecodeGenerator_SetTCGMode_Proxy" (byval This as IAMTimecodeGenerator ptr, byval Param as integer, byval Value as integer) as HRESULT
declare sub IAMTimecodeGenerator_SetTCGMode_Stub alias "IAMTimecodeGenerator_SetTCGMode_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTimecodeGenerator_put_VITCLine_Proxy alias "IAMTimecodeGenerator_put_VITCLine_Proxy" (byval This as IAMTimecodeGenerator ptr, byval Line as integer) as HRESULT
declare sub IAMTimecodeGenerator_put_VITCLine_Stub alias "IAMTimecodeGenerator_put_VITCLine_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTimecodeGenerator_get_VITCLine_Proxy alias "IAMTimecodeGenerator_get_VITCLine_Proxy" (byval This as IAMTimecodeGenerator ptr, byval pLine as integer ptr) as HRESULT
declare sub IAMTimecodeGenerator_get_VITCLine_Stub alias "IAMTimecodeGenerator_get_VITCLine_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTimecodeGenerator_SetTimecode_Proxy alias "IAMTimecodeGenerator_SetTimecode_Proxy" (byval This as IAMTimecodeGenerator ptr, byval pTimecodeSample as PTIMECODE_SAMPLE) as HRESULT
declare sub IAMTimecodeGenerator_SetTimecode_Stub alias "IAMTimecodeGenerator_SetTimecode_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTimecodeGenerator_GetTimecode_Proxy alias "IAMTimecodeGenerator_GetTimecode_Proxy" (byval This as IAMTimecodeGenerator ptr, byval pTimecodeSample as PTIMECODE_SAMPLE) as HRESULT
declare sub IAMTimecodeGenerator_GetTimecode_Stub alias "IAMTimecodeGenerator_GetTimecode_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type PIAMTIMECODEGENERATOR as IAMTimecodeGenerator ptr
extern IID_IAMTimecodeDisplay alias "IID_IAMTimecodeDisplay" as IID

type IAMTimecodeDisplayVtbl_ as IAMTimecodeDisplayVtbl

type IAMTimecodeDisplay
	lpVtbl as IAMTimecodeDisplayVtbl_ ptr
end type

type IAMTimecodeDisplayVtbl
	QueryInterface as function(byval as IAMTimecodeDisplay ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMTimecodeDisplay ptr) as ULONG
	Release as function(byval as IAMTimecodeDisplay ptr) as ULONG
	GetTCDisplayEnable as function(byval as IAMTimecodeDisplay ptr, byval as integer ptr) as HRESULT
	SetTCDisplayEnable as function(byval as IAMTimecodeDisplay ptr, byval as integer) as HRESULT
	GetTCDisplay as function(byval as IAMTimecodeDisplay ptr, byval as integer, byval as integer ptr) as HRESULT
	SetTCDisplay as function(byval as IAMTimecodeDisplay ptr, byval as integer, byval as integer) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMTimecodeDisplay_GetTCDisplayEnable_Proxy alias "IAMTimecodeDisplay_GetTCDisplayEnable_Proxy" (byval This as IAMTimecodeDisplay ptr, byval pState as integer ptr) as HRESULT
declare sub IAMTimecodeDisplay_GetTCDisplayEnable_Stub alias "IAMTimecodeDisplay_GetTCDisplayEnable_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTimecodeDisplay_SetTCDisplayEnable_Proxy alias "IAMTimecodeDisplay_SetTCDisplayEnable_Proxy" (byval This as IAMTimecodeDisplay ptr, byval State as integer) as HRESULT
declare sub IAMTimecodeDisplay_SetTCDisplayEnable_Stub alias "IAMTimecodeDisplay_SetTCDisplayEnable_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTimecodeDisplay_GetTCDisplay_Proxy alias "IAMTimecodeDisplay_GetTCDisplay_Proxy" (byval This as IAMTimecodeDisplay ptr, byval Param as integer, byval pValue as integer ptr) as HRESULT
declare sub IAMTimecodeDisplay_GetTCDisplay_Stub alias "IAMTimecodeDisplay_GetTCDisplay_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMTimecodeDisplay_SetTCDisplay_Proxy alias "IAMTimecodeDisplay_SetTCDisplay_Proxy" (byval This as IAMTimecodeDisplay ptr, byval Param as integer, byval Value as integer) as HRESULT
declare sub IAMTimecodeDisplay_SetTCDisplay_Stub alias "IAMTimecodeDisplay_SetTCDisplay_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type PIAMTIMECODEDISPLAY as IAMTimecodeDisplay ptr
extern IID_IAMDevMemoryAllocator alias "IID_IAMDevMemoryAllocator" as IID

type IAMDevMemoryAllocatorVtbl_ as IAMDevMemoryAllocatorVtbl

type IAMDevMemoryAllocator
	lpVtbl as IAMDevMemoryAllocatorVtbl_ ptr
end type

type IAMDevMemoryAllocatorVtbl
	QueryInterface as function(byval as IAMDevMemoryAllocator ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMDevMemoryAllocator ptr) as ULONG
	Release as function(byval as IAMDevMemoryAllocator ptr) as ULONG
	GetInfo as function(byval as IAMDevMemoryAllocator ptr, byval as DWORD ptr, byval as DWORD ptr, byval as DWORD ptr, byval as DWORD ptr) as HRESULT
	CheckMemory as function(byval as IAMDevMemoryAllocator ptr, byval as BYTE ptr) as HRESULT
	Alloc as function(byval as IAMDevMemoryAllocator ptr, byval as BYTE ptr ptr, byval as DWORD ptr) as HRESULT
	Free as function(byval as IAMDevMemoryAllocator ptr, byval as BYTE ptr) as HRESULT
	GetDevMemoryObject as function(byval as IAMDevMemoryAllocator ptr, byval as IUnknown ptr ptr, byval as IUnknown ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMDevMemoryAllocator_GetInfo_Proxy alias "IAMDevMemoryAllocator_GetInfo_Proxy" (byval This as IAMDevMemoryAllocator ptr, byval pdwcbTotalFree as DWORD ptr, byval pdwcbLargestFree as DWORD ptr, byval pdwcbTotalMemory as DWORD ptr, byval pdwcbMinimumChunk as DWORD ptr) as HRESULT
declare sub IAMDevMemoryAllocator_GetInfo_Stub alias "IAMDevMemoryAllocator_GetInfo_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMDevMemoryAllocator_CheckMemory_Proxy alias "IAMDevMemoryAllocator_CheckMemory_Proxy" (byval This as IAMDevMemoryAllocator ptr, byval pBuffer as BYTE ptr) as HRESULT
declare sub IAMDevMemoryAllocator_CheckMemory_Stub alias "IAMDevMemoryAllocator_CheckMemory_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMDevMemoryAllocator_Alloc_Proxy alias "IAMDevMemoryAllocator_Alloc_Proxy" (byval This as IAMDevMemoryAllocator ptr, byval ppBuffer as BYTE ptr ptr, byval pdwcbBuffer as DWORD ptr) as HRESULT
declare sub IAMDevMemoryAllocator_Alloc_Stub alias "IAMDevMemoryAllocator_Alloc_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMDevMemoryAllocator_Free_Proxy alias "IAMDevMemoryAllocator_Free_Proxy" (byval This as IAMDevMemoryAllocator ptr, byval pBuffer as BYTE ptr) as HRESULT
declare sub IAMDevMemoryAllocator_Free_Stub alias "IAMDevMemoryAllocator_Free_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMDevMemoryAllocator_GetDevMemoryObject_Proxy alias "IAMDevMemoryAllocator_GetDevMemoryObject_Proxy" (byval This as IAMDevMemoryAllocator ptr, byval ppUnkInnner as IUnknown ptr ptr, byval pUnkOuter as IUnknown ptr) as HRESULT
declare sub IAMDevMemoryAllocator_GetDevMemoryObject_Stub alias "IAMDevMemoryAllocator_GetDevMemoryObject_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type PAMDEVMEMORYALLOCATOR as IAMDevMemoryAllocator ptr
extern IID_IAMDevMemoryControl alias "IID_IAMDevMemoryControl" as IID

type IAMDevMemoryControlVtbl_ as IAMDevMemoryControlVtbl

type IAMDevMemoryControl
	lpVtbl as IAMDevMemoryControlVtbl_ ptr
end type

type IAMDevMemoryControlVtbl
	QueryInterface as function(byval as IAMDevMemoryControl ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMDevMemoryControl ptr) as ULONG
	Release as function(byval as IAMDevMemoryControl ptr) as ULONG
	QueryWriteSync as function(byval as IAMDevMemoryControl ptr) as HRESULT
	WriteSync as function(byval as IAMDevMemoryControl ptr) as HRESULT
	GetDevId as function(byval as IAMDevMemoryControl ptr, byval as DWORD ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMDevMemoryControl_QueryWriteSync_Proxy alias "IAMDevMemoryControl_QueryWriteSync_Proxy" (byval This as IAMDevMemoryControl ptr) as HRESULT
declare sub IAMDevMemoryControl_QueryWriteSync_Stub alias "IAMDevMemoryControl_QueryWriteSync_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMDevMemoryControl_WriteSync_Proxy alias "IAMDevMemoryControl_WriteSync_Proxy" (byval This as IAMDevMemoryControl ptr) as HRESULT
declare sub IAMDevMemoryControl_WriteSync_Stub alias "IAMDevMemoryControl_WriteSync_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMDevMemoryControl_GetDevId_Proxy alias "IAMDevMemoryControl_GetDevId_Proxy" (byval This as IAMDevMemoryControl ptr, byval pdwDevId as DWORD ptr) as HRESULT
declare sub IAMDevMemoryControl_GetDevId_Stub alias "IAMDevMemoryControl_GetDevId_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type PAMDEVMEMORYCONTROL as IAMDevMemoryControl ptr

enum AMSTREAMSELECTINFOFLAGS
	AMSTREAMSELECTINFO_ENABLED = &h1
	AMSTREAMSELECTINFO_EXCLUSIVE = &h2
end enum

enum AMSTREAMSELECTENABLEFLAGS
	AMSTREAMSELECTENABLE_ENABLE = &h1
	AMSTREAMSELECTENABLE_ENABLEALL = &h2
end enum
extern IID_IAMStreamSelect alias "IID_IAMStreamSelect" as IID

type IAMStreamSelectVtbl_ as IAMStreamSelectVtbl

type IAMStreamSelect
	lpVtbl as IAMStreamSelectVtbl_ ptr
end type

type IAMStreamSelectVtbl
	QueryInterface as function(byval as IAMStreamSelect ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMStreamSelect ptr) as ULONG
	Release as function(byval as IAMStreamSelect ptr) as ULONG
	Count as function(byval as IAMStreamSelect ptr, byval as DWORD ptr) as HRESULT
	Info as function(byval as IAMStreamSelect ptr, byval as integer, byval as AM_MEDIA_TYPE ptr ptr, byval as DWORD ptr, byval as LCID ptr, byval as DWORD ptr, byval as WCHAR ptr ptr, byval as IUnknown ptr ptr, byval as IUnknown ptr ptr) as HRESULT
	Enable as function(byval as IAMStreamSelect ptr, byval as integer, byval as DWORD) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMStreamSelect_Count_Proxy alias "IAMStreamSelect_Count_Proxy" (byval This as IAMStreamSelect ptr, byval pcStreams as DWORD ptr) as HRESULT
declare sub IAMStreamSelect_Count_Stub alias "IAMStreamSelect_Count_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMStreamSelect_Info_Proxy alias "IAMStreamSelect_Info_Proxy" (byval This as IAMStreamSelect ptr, byval lIndex as integer, byval ppmt as AM_MEDIA_TYPE ptr ptr, byval pdwFlags as DWORD ptr, byval plcid as LCID ptr, byval pdwGroup as DWORD ptr, byval ppszName as WCHAR ptr ptr, byval ppObject as IUnknown ptr ptr, byval ppUnk as IUnknown ptr ptr) as HRESULT
declare sub IAMStreamSelect_Info_Stub alias "IAMStreamSelect_Info_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMStreamSelect_Enable_Proxy alias "IAMStreamSelect_Enable_Proxy" (byval This as IAMStreamSelect ptr, byval lIndex as integer, byval dwFlags as DWORD) as HRESULT
declare sub IAMStreamSelect_Enable_Stub alias "IAMStreamSelect_Enable_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type PAMSTREAMSELECT as IAMStreamSelect ptr

enum AMRESCTL_RESERVEFLAGS
	AMRESCTL_RESERVEFLAGS_RESERVE = 0
	AMRESCTL_RESERVEFLAGS_UNRESERVE = &h1
end enum
extern IID_IAMResourceControl alias "IID_IAMResourceControl" as IID

type IAMResourceControlVtbl_ as IAMResourceControlVtbl

type IAMResourceControl
	lpVtbl as IAMResourceControlVtbl_ ptr
end type

type IAMResourceControlVtbl
	QueryInterface as function(byval as IAMResourceControl ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMResourceControl ptr) as ULONG
	Release as function(byval as IAMResourceControl ptr) as ULONG
	Reserve as function(byval as IAMResourceControl ptr, byval as DWORD, byval as PVOID) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMResourceControl_Reserve_Proxy alias "IAMResourceControl_Reserve_Proxy" (byval This as IAMResourceControl ptr, byval dwFlags as DWORD, byval pvReserved as PVOID) as HRESULT
declare sub IAMResourceControl_Reserve_Stub alias "IAMResourceControl_Reserve_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IAMClockAdjust alias "IID_IAMClockAdjust" as IID

type IAMClockAdjustVtbl_ as IAMClockAdjustVtbl

type IAMClockAdjust
	lpVtbl as IAMClockAdjustVtbl_ ptr
end type

type IAMClockAdjustVtbl
	QueryInterface as function(byval as IAMClockAdjust ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMClockAdjust ptr) as ULONG
	Release as function(byval as IAMClockAdjust ptr) as ULONG
	SetClockDelta as function(byval as IAMClockAdjust ptr, byval as REFERENCE_TIME) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMClockAdjust_SetClockDelta_Proxy alias "IAMClockAdjust_SetClockDelta_Proxy" (byval This as IAMClockAdjust ptr, byval rtDelta as REFERENCE_TIME) as HRESULT
declare sub IAMClockAdjust_SetClockDelta_Stub alias "IAMClockAdjust_SetClockDelta_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

enum AM_FILTER_MISC_FLAGS
	AM_FILTER_MISC_FLAGS_IS_RENDERER = &h1
	AM_FILTER_MISC_FLAGS_IS_SOURCE = &h2
end enum
extern IID_IAMFilterMiscFlags alias "IID_IAMFilterMiscFlags" as IID

type IAMFilterMiscFlagsVtbl_ as IAMFilterMiscFlagsVtbl

type IAMFilterMiscFlags
	lpVtbl as IAMFilterMiscFlagsVtbl_ ptr
end type

type IAMFilterMiscFlagsVtbl
	QueryInterface as function(byval as IAMFilterMiscFlags ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMFilterMiscFlags ptr) as ULONG
	Release as function(byval as IAMFilterMiscFlags ptr) as ULONG
	GetMiscFlags as function(byval as IAMFilterMiscFlags ptr) as ULONG
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMFilterMiscFlags_GetMiscFlags_Proxy alias "IAMFilterMiscFlags_GetMiscFlags_Proxy" (byval This as IAMFilterMiscFlags ptr) as ULONG
declare sub IAMFilterMiscFlags_GetMiscFlags_Stub alias "IAMFilterMiscFlags_GetMiscFlags_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IDrawVideoImage alias "IID_IDrawVideoImage" as IID

type IDrawVideoImageVtbl_ as IDrawVideoImageVtbl

type IDrawVideoImage
	lpVtbl as IDrawVideoImageVtbl_ ptr
end type

type IDrawVideoImageVtbl
	QueryInterface as function(byval as IDrawVideoImage ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IDrawVideoImage ptr) as ULONG
	Release as function(byval as IDrawVideoImage ptr) as ULONG
	DrawVideoImageBegin as function(byval as IDrawVideoImage ptr) as HRESULT
	DrawVideoImageEnd as function(byval as IDrawVideoImage ptr) as HRESULT
	DrawVideoImageDraw as function(byval as IDrawVideoImage ptr, byval as HDC, byval as LPRECT, byval as LPRECT) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IDrawVideoImage_DrawVideoImageBegin_Proxy alias "IDrawVideoImage_DrawVideoImageBegin_Proxy" (byval This as IDrawVideoImage ptr) as HRESULT
declare sub IDrawVideoImage_DrawVideoImageBegin_Stub alias "IDrawVideoImage_DrawVideoImageBegin_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDrawVideoImage_DrawVideoImageEnd_Proxy alias "IDrawVideoImage_DrawVideoImageEnd_Proxy" (byval This as IDrawVideoImage ptr) as HRESULT
declare sub IDrawVideoImage_DrawVideoImageEnd_Stub alias "IDrawVideoImage_DrawVideoImageEnd_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDrawVideoImage_DrawVideoImageDraw_Proxy alias "IDrawVideoImage_DrawVideoImageDraw_Proxy" (byval This as IDrawVideoImage ptr, byval hdc as HDC, byval lprcSrc as LPRECT, byval lprcDst as LPRECT) as HRESULT
declare sub IDrawVideoImage_DrawVideoImageDraw_Stub alias "IDrawVideoImage_DrawVideoImageDraw_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IDecimateVideoImage alias "IID_IDecimateVideoImage" as IID

type IDecimateVideoImageVtbl_ as IDecimateVideoImageVtbl

type IDecimateVideoImage
	lpVtbl as IDecimateVideoImageVtbl_ ptr
end type

type IDecimateVideoImageVtbl
	QueryInterface as function(byval as IDecimateVideoImage ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IDecimateVideoImage ptr) as ULONG
	Release as function(byval as IDecimateVideoImage ptr) as ULONG
	SetDecimationImageSize as function(byval as IDecimateVideoImage ptr, byval as integer, byval as integer) as HRESULT
	ResetDecimationImageSize as function(byval as IDecimateVideoImage ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IDecimateVideoImage_SetDecimationImageSize_Proxy alias "IDecimateVideoImage_SetDecimationImageSize_Proxy" (byval This as IDecimateVideoImage ptr, byval lWidth as integer, byval lHeight as integer) as HRESULT
declare sub IDecimateVideoImage_SetDecimationImageSize_Stub alias "IDecimateVideoImage_SetDecimationImageSize_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDecimateVideoImage_ResetDecimationImageSize_Proxy alias "IDecimateVideoImage_ResetDecimationImageSize_Proxy" (byval This as IDecimateVideoImage ptr) as HRESULT
declare sub IDecimateVideoImage_ResetDecimationImageSize_Stub alias "IDecimateVideoImage_ResetDecimationImageSize_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

enum DECIMATION_USAGE
	DECIMATION_LEGACY = 0
	DECIMATION_USE_DECODER_ONLY = DECIMATION_LEGACY+1
	DECIMATION_USE_VIDEOPORT_ONLY = DECIMATION_USE_DECODER_ONLY+1
	DECIMATION_USE_OVERLAY_ONLY = DECIMATION_USE_VIDEOPORT_ONLY+1
	DECIMATION_DEFAULT = DECIMATION_USE_OVERLAY_ONLY+1
end enum

extern IID_IAMVideoDecimationProperties alias "IID_IAMVideoDecimationProperties" as IID

type IAMVideoDecimationPropertiesVtbl_ as IAMVideoDecimationPropertiesVtbl

type IAMVideoDecimationProperties
	lpVtbl as IAMVideoDecimationPropertiesVtbl_ ptr
end type

type IAMVideoDecimationPropertiesVtbl
	QueryInterface as function(byval as IAMVideoDecimationProperties ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMVideoDecimationProperties ptr) as ULONG
	Release as function(byval as IAMVideoDecimationProperties ptr) as ULONG
	QueryDecimationUsage as function(byval as IAMVideoDecimationProperties ptr, byval as DECIMATION_USAGE ptr) as HRESULT
	SetDecimationUsage as function(byval as IAMVideoDecimationProperties ptr, byval as DECIMATION_USAGE) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMVideoDecimationProperties_QueryDecimationUsage_Proxy alias "IAMVideoDecimationProperties_QueryDecimationUsage_Proxy" (byval This as IAMVideoDecimationProperties ptr, byval lpUsage as DECIMATION_USAGE ptr) as HRESULT
declare sub IAMVideoDecimationProperties_QueryDecimationUsage_Stub alias "IAMVideoDecimationProperties_QueryDecimationUsage_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMVideoDecimationProperties_SetDecimationUsage_Proxy alias "IAMVideoDecimationProperties_SetDecimationUsage_Proxy" (byval This as IAMVideoDecimationProperties ptr, byval Usage as DECIMATION_USAGE) as HRESULT
declare sub IAMVideoDecimationProperties_SetDecimationUsage_Stub alias "IAMVideoDecimationProperties_SetDecimationUsage_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IVideoFrameStep alias "IID_IVideoFrameStep" as IID

type IVideoFrameStepVtbl_ as IVideoFrameStepVtbl

type IVideoFrameStep
	lpVtbl as IVideoFrameStepVtbl_ ptr
end type

type IVideoFrameStepVtbl
	QueryInterface as function(byval as IVideoFrameStep ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IVideoFrameStep ptr) as ULONG
	Release as function(byval as IVideoFrameStep ptr) as ULONG
	Step as function(byval as IVideoFrameStep ptr, byval as DWORD, byval as IUnknown ptr) as HRESULT
	CanStep as function(byval as IVideoFrameStep ptr, byval as integer, byval as IUnknown ptr) as HRESULT
	CancelStep as function(byval as IVideoFrameStep ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IVideoFrameStep_Step_Proxy alias "IVideoFrameStep_Step_Proxy" (byval This as IVideoFrameStep ptr, byval dwFrames as DWORD, byval pStepObject as IUnknown ptr) as HRESULT
declare sub IVideoFrameStep_Step_Stub alias "IVideoFrameStep_Step_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoFrameStep_CanStep_Proxy alias "IVideoFrameStep_CanStep_Proxy" (byval This as IVideoFrameStep ptr, byval bMultiple as integer, byval pStepObject as IUnknown ptr) as HRESULT
declare sub IVideoFrameStep_CanStep_Stub alias "IVideoFrameStep_CanStep_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVideoFrameStep_CancelStep_Proxy alias "IVideoFrameStep_CancelStep_Proxy" (byval This as IVideoFrameStep ptr) as HRESULT
declare sub IVideoFrameStep_CancelStep_Stub alias "IVideoFrameStep_CancelStep_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

enum AM_PUSHSOURCE_FLAGS
	AM_PUSHSOURCECAPS_INTERNAL_RM = &h1
	AM_PUSHSOURCECAPS_NOT_LIVE = &h2
	AM_PUSHSOURCECAPS_PRIVATE_CLOCK = &h4
	AM_PUSHSOURCEREQS_USE_STREAM_CLOCK = &h10000
end enum
extern IID_IAMLatency alias "IID_IAMLatency" as IID

type IAMLatencyVtbl_ as IAMLatencyVtbl

type IAMLatency
	lpVtbl as IAMLatencyVtbl_ ptr
end type

type IAMLatencyVtbl
	QueryInterface as function(byval as IAMLatency ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMLatency ptr) as ULONG
	Release as function(byval as IAMLatency ptr) as ULONG
	GetLatency as function(byval as IAMLatency ptr, byval as REFERENCE_TIME ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMLatency_GetLatency_Proxy alias "IAMLatency_GetLatency_Proxy" (byval This as IAMLatency ptr, byval prtLatency as REFERENCE_TIME ptr) as HRESULT
declare sub IAMLatency_GetLatency_Stub alias "IAMLatency_GetLatency_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IAMPushSource alias "IID_IAMPushSource" as IID

type IAMPushSourceVtbl_ as IAMPushSourceVtbl

type IAMPushSource
	lpVtbl as IAMPushSourceVtbl_ ptr
end type

type IAMPushSourceVtbl
	QueryInterface as function(byval as IAMPushSource ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMPushSource ptr) as ULONG
	Release as function(byval as IAMPushSource ptr) as ULONG
	GetLatency as function(byval as IAMPushSource ptr, byval as REFERENCE_TIME ptr) as HRESULT
	GetPushSourceFlags as function(byval as IAMPushSource ptr, byval as ULONG ptr) as HRESULT
	SetPushSourceFlags as function(byval as IAMPushSource ptr, byval as ULONG) as HRESULT
	SetStreamOffset as function(byval as IAMPushSource ptr, byval as REFERENCE_TIME) as HRESULT
	GetStreamOffset as function(byval as IAMPushSource ptr, byval as REFERENCE_TIME ptr) as HRESULT
	GetMaxStreamOffset as function(byval as IAMPushSource ptr, byval as REFERENCE_TIME ptr) as HRESULT
	SetMaxStreamOffset as function(byval as IAMPushSource ptr, byval as REFERENCE_TIME) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMPushSource_GetPushSourceFlags_Proxy alias "IAMPushSource_GetPushSourceFlags_Proxy" (byval This as IAMPushSource ptr, byval pFlags as ULONG ptr) as HRESULT
declare sub IAMPushSource_GetPushSourceFlags_Stub alias "IAMPushSource_GetPushSourceFlags_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMPushSource_SetPushSourceFlags_Proxy alias "IAMPushSource_SetPushSourceFlags_Proxy" (byval This as IAMPushSource ptr, byval Flags as ULONG) as HRESULT
declare sub IAMPushSource_SetPushSourceFlags_Stub alias "IAMPushSource_SetPushSourceFlags_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMPushSource_SetStreamOffset_Proxy alias "IAMPushSource_SetStreamOffset_Proxy" (byval This as IAMPushSource ptr, byval rtOffset as REFERENCE_TIME) as HRESULT
declare sub IAMPushSource_SetStreamOffset_Stub alias "IAMPushSource_SetStreamOffset_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMPushSource_GetStreamOffset_Proxy alias "IAMPushSource_GetStreamOffset_Proxy" (byval This as IAMPushSource ptr, byval prtOffset as REFERENCE_TIME ptr) as HRESULT
declare sub IAMPushSource_GetStreamOffset_Stub alias "IAMPushSource_GetStreamOffset_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMPushSource_GetMaxStreamOffset_Proxy alias "IAMPushSource_GetMaxStreamOffset_Proxy" (byval This as IAMPushSource ptr, byval prtMaxOffset as REFERENCE_TIME ptr) as HRESULT
declare sub IAMPushSource_GetMaxStreamOffset_Stub alias "IAMPushSource_GetMaxStreamOffset_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMPushSource_SetMaxStreamOffset_Proxy alias "IAMPushSource_SetMaxStreamOffset_Proxy" (byval This as IAMPushSource ptr, byval rtMaxOffset as REFERENCE_TIME) as HRESULT
declare sub IAMPushSource_SetMaxStreamOffset_Stub alias "IAMPushSource_SetMaxStreamOffset_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IAMDeviceRemoval alias "IID_IAMDeviceRemoval" as IID

type IAMDeviceRemovalVtbl_ as IAMDeviceRemovalVtbl

type IAMDeviceRemoval
	lpVtbl as IAMDeviceRemovalVtbl_ ptr
end type

type IAMDeviceRemovalVtbl
	QueryInterface as function(byval as IAMDeviceRemoval ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMDeviceRemoval ptr) as ULONG
	Release as function(byval as IAMDeviceRemoval ptr) as ULONG
	DeviceInfo as function(byval as IAMDeviceRemoval ptr, byval as CLSID ptr, byval as WCHAR ptr ptr) as HRESULT
	Reassociate as function(byval as IAMDeviceRemoval ptr) as HRESULT
	Disassociate as function(byval as IAMDeviceRemoval ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMDeviceRemoval_DeviceInfo_Proxy alias "IAMDeviceRemoval_DeviceInfo_Proxy" (byval This as IAMDeviceRemoval ptr, byval pclsidInterfaceClass as CLSID ptr, byval pwszSymbolicLink as WCHAR ptr ptr) as HRESULT
declare sub IAMDeviceRemoval_DeviceInfo_Stub alias "IAMDeviceRemoval_DeviceInfo_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMDeviceRemoval_Reassociate_Proxy alias "IAMDeviceRemoval_Reassociate_Proxy" (byval This as IAMDeviceRemoval ptr) as HRESULT
declare sub IAMDeviceRemoval_Reassociate_Stub alias "IAMDeviceRemoval_Reassociate_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMDeviceRemoval_Disassociate_Proxy alias "IAMDeviceRemoval_Disassociate_Proxy" (byval This as IAMDeviceRemoval ptr) as HRESULT
declare sub IAMDeviceRemoval_Disassociate_Stub alias "IAMDeviceRemoval_Disassociate_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type DVINFO
	dwDVAAuxSrc as DWORD
	dwDVAAuxCtl as DWORD
	dwDVAAuxSrc1 as DWORD
	dwDVAAuxCtl1 as DWORD
	dwDVVAuxSrc as DWORD
	dwDVVAuxCtl as DWORD
	dwDVReserved(0 to 2-1) as DWORD
end type

type PDVINFO as DVINFO ptr

enum DVENCODERRESOLUTION
	DVENCODERRESOLUTION_720x480 = 2012
	DVENCODERRESOLUTION_360x240 = 2013
	DVENCODERRESOLUTION_180x120 = 2014
	DVENCODERRESOLUTION_88x60 = 2015
end enum

enum DVENCODERVIDEOFORMAT
	DVENCODERVIDEOFORMAT_NTSC = 2000
	DVENCODERVIDEOFORMAT_PAL = 2001
end enum

enum DVENCODERFORMAT
	DVENCODERFORMAT_DVSD = 2007
	DVENCODERFORMAT_DVHD = 2008
	DVENCODERFORMAT_DVSL = 2009
end enum
extern IID_IDVEnc alias "IID_IDVEnc" as IID

type IDVEncVtbl_ as IDVEncVtbl

type IDVEnc
	lpVtbl as IDVEncVtbl_ ptr
end type

type IDVEncVtbl
	QueryInterface as function(byval as IDVEnc ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IDVEnc ptr) as ULONG
	Release as function(byval as IDVEnc ptr) as ULONG
	get_IFormatResolution as function(byval as IDVEnc ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr, byval as BYTE, byval as DVINFO ptr) as HRESULT
	put_IFormatResolution as function(byval as IDVEnc ptr, byval as integer, byval as integer, byval as integer, byval as BYTE, byval as DVINFO ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IDVEnc_get_IFormatResolution_Proxy alias "IDVEnc_get_IFormatResolution_Proxy" (byval This as IDVEnc ptr, byval VideoFormat as integer ptr, byval DVFormat as integer ptr, byval Resolution as integer ptr, byval fDVInfo as BYTE, byval sDVInfo as DVINFO ptr) as HRESULT
declare sub IDVEnc_get_IFormatResolution_Stub alias "IDVEnc_get_IFormatResolution_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDVEnc_put_IFormatResolution_Proxy alias "IDVEnc_put_IFormatResolution_Proxy" (byval This as IDVEnc ptr, byval VideoFormat as integer, byval DVFormat as integer, byval Resolution as integer, byval fDVInfo as BYTE, byval sDVInfo as DVINFO ptr) as HRESULT
declare sub IDVEnc_put_IFormatResolution_Stub alias "IDVEnc_put_IFormatResolution_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

enum DVDECODERRESOLUTION
	DVDECODERRESOLUTION_720x480 = 1000
	DVDECODERRESOLUTION_360x240 = 1001
	DVDECODERRESOLUTION_180x120 = 1002
	DVDECODERRESOLUTION_88x60 = 1003
end enum

enum DVRESOLUTION
	DVRESOLUTION_FULL = 1000
	DVRESOLUTION_HALF = 1001
	DVRESOLUTION_QUARTER = 1002
	DVRESOLUTION_DC = 1003
end enum
extern IID_IIPDVDec alias "IID_IIPDVDec" as IID

type IIPDVDecVtbl_ as IIPDVDecVtbl

type IIPDVDec
	lpVtbl as IIPDVDecVtbl_ ptr
end type

type IIPDVDecVtbl
	QueryInterface as function(byval as IIPDVDec ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IIPDVDec ptr) as ULONG
	Release as function(byval as IIPDVDec ptr) as ULONG
	get_IPDisplay as function(byval as IIPDVDec ptr, byval as integer ptr) as HRESULT
	put_IPDisplay as function(byval as IIPDVDec ptr, byval as integer) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IIPDVDec_get_IPDisplay_Proxy alias "IIPDVDec_get_IPDisplay_Proxy" (byval This as IIPDVDec ptr, byval displayPix as integer ptr) as HRESULT
declare sub IIPDVDec_get_IPDisplay_Stub alias "IIPDVDec_get_IPDisplay_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IIPDVDec_put_IPDisplay_Proxy alias "IIPDVDec_put_IPDisplay_Proxy" (byval This as IIPDVDec ptr, byval displayPix as integer) as HRESULT
declare sub IIPDVDec_put_IPDisplay_Stub alias "IIPDVDec_put_IPDisplay_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IDVRGB219 alias "IID_IDVRGB219" as IID

type IDVRGB219Vtbl_ as IDVRGB219Vtbl

type IDVRGB219
	lpVtbl as IDVRGB219Vtbl_ ptr
end type

type IDVRGB219Vtbl
	QueryInterface as function(byval as IDVRGB219 ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IDVRGB219 ptr) as ULONG
	Release as function(byval as IDVRGB219 ptr) as ULONG
	SetRGB219 as function(byval as IDVRGB219 ptr, byval as BOOL) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IDVRGB219_SetRGB219_Proxy alias "IDVRGB219_SetRGB219_Proxy" (byval This as IDVRGB219 ptr, byval bState as BOOL) as HRESULT
declare sub IDVRGB219_SetRGB219_Stub alias "IDVRGB219_SetRGB219_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IDVSplitter alias "IID_IDVSplitter" as IID

type IDVSplitterVtbl_ as IDVSplitterVtbl

type IDVSplitter
	lpVtbl as IDVSplitterVtbl_ ptr
end type

type IDVSplitterVtbl
	QueryInterface as function(byval as IDVSplitter ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IDVSplitter ptr) as ULONG
	Release as function(byval as IDVSplitter ptr) as ULONG
	DiscardAlternateVideoFrames as function(byval as IDVSplitter ptr, byval as integer) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IDVSplitter_DiscardAlternateVideoFrames_Proxy alias "IDVSplitter_DiscardAlternateVideoFrames_Proxy" (byval This as IDVSplitter ptr, byval nDiscard as integer) as HRESULT
declare sub IDVSplitter_DiscardAlternateVideoFrames_Stub alias "IDVSplitter_DiscardAlternateVideoFrames_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

enum AM_AUDIO_RENDERER_STAT_PARAM
	AM_AUDREND_STAT_PARAM_BREAK_COUNT = 1
	AM_AUDREND_STAT_PARAM_SLAVE_MODE = AM_AUDREND_STAT_PARAM_BREAK_COUNT+1
	AM_AUDREND_STAT_PARAM_SILENCE_DUR = AM_AUDREND_STAT_PARAM_SLAVE_MODE+1
	AM_AUDREND_STAT_PARAM_LAST_BUFFER_DUR = AM_AUDREND_STAT_PARAM_SILENCE_DUR+1
	AM_AUDREND_STAT_PARAM_DISCONTINUITIES = AM_AUDREND_STAT_PARAM_LAST_BUFFER_DUR+1
	AM_AUDREND_STAT_PARAM_SLAVE_RATE = AM_AUDREND_STAT_PARAM_DISCONTINUITIES+1
	AM_AUDREND_STAT_PARAM_SLAVE_DROPWRITE_DUR = AM_AUDREND_STAT_PARAM_SLAVE_RATE+1
	AM_AUDREND_STAT_PARAM_SLAVE_HIGHLOWERROR = AM_AUDREND_STAT_PARAM_SLAVE_DROPWRITE_DUR+1
	AM_AUDREND_STAT_PARAM_SLAVE_LASTHIGHLOWERROR = AM_AUDREND_STAT_PARAM_SLAVE_HIGHLOWERROR+1
	AM_AUDREND_STAT_PARAM_SLAVE_ACCUMERROR = AM_AUDREND_STAT_PARAM_SLAVE_LASTHIGHLOWERROR+1
	AM_AUDREND_STAT_PARAM_BUFFERFULLNESS = AM_AUDREND_STAT_PARAM_SLAVE_ACCUMERROR+1
	AM_AUDREND_STAT_PARAM_JITTER = AM_AUDREND_STAT_PARAM_BUFFERFULLNESS+1
end enum
extern IID_IAMAudioRendererStats alias "IID_IAMAudioRendererStats" as IID

type IAMAudioRendererStatsVtbl_ as IAMAudioRendererStatsVtbl

type IAMAudioRendererStats
	lpVtbl as IAMAudioRendererStatsVtbl_ ptr
end type

type IAMAudioRendererStatsVtbl
	QueryInterface as function(byval as IAMAudioRendererStats ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMAudioRendererStats ptr) as ULONG
	Release as function(byval as IAMAudioRendererStats ptr) as ULONG
	GetStatParam as function(byval as IAMAudioRendererStats ptr, byval as DWORD, byval as DWORD ptr, byval as DWORD ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMAudioRendererStats_GetStatParam_Proxy alias "IAMAudioRendererStats_GetStatParam_Proxy" (byval This as IAMAudioRendererStats ptr, byval dwParam as DWORD, byval pdwParam1 as DWORD ptr, byval pdwParam2 as DWORD ptr) as HRESULT
declare sub IAMAudioRendererStats_GetStatParam_Stub alias "IAMAudioRendererStats_GetStatParam_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

enum AM_INTF_SEARCH_FLAGS
	AM_INTF_SEARCH_INPUT_PIN = &h1
	AM_INTF_SEARCH_OUTPUT_PIN = &h2
	AM_INTF_SEARCH_FILTER = &h4
end enum
extern IID_IAMGraphStreams alias "IID_IAMGraphStreams" as IID

type IAMGraphStreamsVtbl_ as IAMGraphStreamsVtbl

type IAMGraphStreams
	lpVtbl as IAMGraphStreamsVtbl_ ptr
end type

type IAMGraphStreamsVtbl
	QueryInterface as function(byval as IAMGraphStreams ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMGraphStreams ptr) as ULONG
	Release as function(byval as IAMGraphStreams ptr) as ULONG
	FindUpstreamInterface as function(byval as IAMGraphStreams ptr, byval as IPin ptr, byval as IID ptr, byval as any ptr ptr, byval as DWORD) as HRESULT
	SyncUsingStreamOffset as function(byval as IAMGraphStreams ptr, byval as BOOL) as HRESULT
	SetMaxGraphLatency as function(byval as IAMGraphStreams ptr, byval as REFERENCE_TIME) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMGraphStreams_FindUpstreamInterface_Proxy alias "IAMGraphStreams_FindUpstreamInterface_Proxy" (byval This as IAMGraphStreams ptr, byval pPin as IPin ptr, byval riid as IID ptr, byval ppvInterface as any ptr ptr, byval dwFlags as DWORD) as HRESULT
declare sub IAMGraphStreams_FindUpstreamInterface_Stub alias "IAMGraphStreams_FindUpstreamInterface_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMGraphStreams_SyncUsingStreamOffset_Proxy alias "IAMGraphStreams_SyncUsingStreamOffset_Proxy" (byval This as IAMGraphStreams ptr, byval bUseStreamOffset as BOOL) as HRESULT
declare sub IAMGraphStreams_SyncUsingStreamOffset_Stub alias "IAMGraphStreams_SyncUsingStreamOffset_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMGraphStreams_SetMaxGraphLatency_Proxy alias "IAMGraphStreams_SetMaxGraphLatency_Proxy" (byval This as IAMGraphStreams ptr, byval rtMaxGraphLatency as REFERENCE_TIME) as HRESULT
declare sub IAMGraphStreams_SetMaxGraphLatency_Stub alias "IAMGraphStreams_SetMaxGraphLatency_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

enum AMOVERLAYFX
	AMOVERFX_NOFX = 0
	AMOVERFX_MIRRORLEFTRIGHT = &h2
	AMOVERFX_MIRRORUPDOWN = &h4
	AMOVERFX_DEINTERLACE = &h8
end enum
extern IID_IAMOverlayFX alias "IID_IAMOverlayFX" as IID

type IAMOverlayFXVtbl_ as IAMOverlayFXVtbl

type IAMOverlayFX
	lpVtbl as IAMOverlayFXVtbl_ ptr
end type

type IAMOverlayFXVtbl
	QueryInterface as function(byval as IAMOverlayFX ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMOverlayFX ptr) as ULONG
	Release as function(byval as IAMOverlayFX ptr) as ULONG
	QueryOverlayFXCaps as function(byval as IAMOverlayFX ptr, byval as DWORD ptr) as HRESULT
	SetOverlayFX as function(byval as IAMOverlayFX ptr, byval as DWORD) as HRESULT
	GetOverlayFX as function(byval as IAMOverlayFX ptr, byval as DWORD ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMOverlayFX_QueryOverlayFXCaps_Proxy alias "IAMOverlayFX_QueryOverlayFXCaps_Proxy" (byval This as IAMOverlayFX ptr, byval lpdwOverlayFXCaps as DWORD ptr) as HRESULT
declare sub IAMOverlayFX_QueryOverlayFXCaps_Stub alias "IAMOverlayFX_QueryOverlayFXCaps_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMOverlayFX_SetOverlayFX_Proxy alias "IAMOverlayFX_SetOverlayFX_Proxy" (byval This as IAMOverlayFX ptr, byval dwOverlayFX as DWORD) as HRESULT
declare sub IAMOverlayFX_SetOverlayFX_Stub alias "IAMOverlayFX_SetOverlayFX_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMOverlayFX_GetOverlayFX_Proxy alias "IAMOverlayFX_GetOverlayFX_Proxy" (byval This as IAMOverlayFX ptr, byval lpdwOverlayFX as DWORD ptr) as HRESULT
declare sub IAMOverlayFX_GetOverlayFX_Stub alias "IAMOverlayFX_GetOverlayFX_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IAMOpenProgress alias "IID_IAMOpenProgress" as IID

type IAMOpenProgressVtbl_ as IAMOpenProgressVtbl

type IAMOpenProgress
	lpVtbl as IAMOpenProgressVtbl_ ptr
end type

type IAMOpenProgressVtbl
	QueryInterface as function(byval as IAMOpenProgress ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMOpenProgress ptr) as ULONG
	Release as function(byval as IAMOpenProgress ptr) as ULONG
	QueryProgress as function(byval as IAMOpenProgress ptr, byval as LONGLONG ptr, byval as LONGLONG ptr) as HRESULT
	AbortOperation as function(byval as IAMOpenProgress ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMOpenProgress_QueryProgress_Proxy alias "IAMOpenProgress_QueryProgress_Proxy" (byval This as IAMOpenProgress ptr, byval pllTotal as LONGLONG ptr, byval pllCurrent as LONGLONG ptr) as HRESULT
declare sub IAMOpenProgress_QueryProgress_Stub alias "IAMOpenProgress_QueryProgress_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMOpenProgress_AbortOperation_Proxy alias "IAMOpenProgress_AbortOperation_Proxy" (byval This as IAMOpenProgress ptr) as HRESULT
declare sub IAMOpenProgress_AbortOperation_Stub alias "IAMOpenProgress_AbortOperation_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IMpeg2Demultiplexer alias "IID_IMpeg2Demultiplexer" as IID

type IMpeg2DemultiplexerVtbl_ as IMpeg2DemultiplexerVtbl

type IMpeg2Demultiplexer
	lpVtbl as IMpeg2DemultiplexerVtbl_ ptr
end type

type IMpeg2DemultiplexerVtbl
	QueryInterface as function(byval as IMpeg2Demultiplexer ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IMpeg2Demultiplexer ptr) as ULONG
	Release as function(byval as IMpeg2Demultiplexer ptr) as ULONG
	CreateOutputPin as function(byval as IMpeg2Demultiplexer ptr, byval as AM_MEDIA_TYPE ptr, byval as LPWSTR, byval as IPin ptr ptr) as HRESULT
	SetOutputPinMediaType as function(byval as IMpeg2Demultiplexer ptr, byval as LPWSTR, byval as AM_MEDIA_TYPE ptr) as HRESULT
	DeleteOutputPin as function(byval as IMpeg2Demultiplexer ptr, byval as LPWSTR) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IMpeg2Demultiplexer_CreateOutputPin_Proxy alias "IMpeg2Demultiplexer_CreateOutputPin_Proxy" (byval This as IMpeg2Demultiplexer ptr, byval pMediaType as AM_MEDIA_TYPE ptr, byval pszPinName as LPWSTR, byval ppIPin as IPin ptr ptr) as HRESULT
declare sub IMpeg2Demultiplexer_CreateOutputPin_Stub alias "IMpeg2Demultiplexer_CreateOutputPin_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMpeg2Demultiplexer_SetOutputPinMediaType_Proxy alias "IMpeg2Demultiplexer_SetOutputPinMediaType_Proxy" (byval This as IMpeg2Demultiplexer ptr, byval pszPinName as LPWSTR, byval pMediaType as AM_MEDIA_TYPE ptr) as HRESULT
declare sub IMpeg2Demultiplexer_SetOutputPinMediaType_Stub alias "IMpeg2Demultiplexer_SetOutputPinMediaType_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMpeg2Demultiplexer_DeleteOutputPin_Proxy alias "IMpeg2Demultiplexer_DeleteOutputPin_Proxy" (byval This as IMpeg2Demultiplexer ptr, byval pszPinName as LPWSTR) as HRESULT
declare sub IMpeg2Demultiplexer_DeleteOutputPin_Stub alias "IMpeg2Demultiplexer_DeleteOutputPin_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

#define MPEG2_PROGRAM_STREAM_MAP &h00000000
#define MPEG2_PROGRAM_ELEMENTARY_STREAM &h00000001
#define MPEG2_PROGRAM_DIRECTORY_PES_PACKET &h00000002
#define MPEG2_PROGRAM_PACK_HEADER &h00000003
#define MPEG2_PROGRAM_PES_STREAM &h00000004
#define MPEG2_PROGRAM_SYSTEM_HEADER &h00000005
#define SUBSTREAM_FILTER_VAL_NONE &h10000000

type STREAM_ID_MAP
	stream_id as ULONG
	dwMediaSampleContent as DWORD
	ulSubstreamFilterValue as ULONG
	iDataOffset as integer
end type

extern IID_IEnumStreamIdMap alias "IID_IEnumStreamIdMap" as IID

type IEnumStreamIdMapVtbl_ as IEnumStreamIdMapVtbl

type IEnumStreamIdMap
	lpVtbl as IEnumStreamIdMapVtbl_ ptr
end type

type IEnumStreamIdMapVtbl
	QueryInterface as function(byval as IEnumStreamIdMap ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IEnumStreamIdMap ptr) as ULONG
	Release as function(byval as IEnumStreamIdMap ptr) as ULONG
	Next as function(byval as IEnumStreamIdMap ptr, byval as ULONG, byval as STREAM_ID_MAP ptr, byval as ULONG ptr) as HRESULT
	Skip as function(byval as IEnumStreamIdMap ptr, byval as ULONG) as HRESULT
	Reset as function(byval as IEnumStreamIdMap ptr) as HRESULT
	Clone as function(byval as IEnumStreamIdMap ptr, byval as IEnumStreamIdMap ptr ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IEnumStreamIdMap_Next_Proxy alias "IEnumStreamIdMap_Next_Proxy" (byval This as IEnumStreamIdMap ptr, byval cRequest as ULONG, byval pStreamIdMap as STREAM_ID_MAP ptr, byval pcReceived as ULONG ptr) as HRESULT
declare sub IEnumStreamIdMap_Next_Stub alias "IEnumStreamIdMap_Next_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEnumStreamIdMap_Skip_Proxy alias "IEnumStreamIdMap_Skip_Proxy" (byval This as IEnumStreamIdMap ptr, byval cRecords as ULONG) as HRESULT
declare sub IEnumStreamIdMap_Skip_Stub alias "IEnumStreamIdMap_Skip_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEnumStreamIdMap_Reset_Proxy alias "IEnumStreamIdMap_Reset_Proxy" (byval This as IEnumStreamIdMap ptr) as HRESULT
declare sub IEnumStreamIdMap_Reset_Stub alias "IEnumStreamIdMap_Reset_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEnumStreamIdMap_Clone_Proxy alias "IEnumStreamIdMap_Clone_Proxy" (byval This as IEnumStreamIdMap ptr, byval ppIEnumStreamIdMap as IEnumStreamIdMap ptr ptr) as HRESULT
declare sub IEnumStreamIdMap_Clone_Stub alias "IEnumStreamIdMap_Clone_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IMPEG2StreamIdMap alias "IID_IMPEG2StreamIdMap" as IID

type IMPEG2StreamIdMapVtbl_ as IMPEG2StreamIdMapVtbl

type IMPEG2StreamIdMap
	lpVtbl as IMPEG2StreamIdMapVtbl_ ptr
end type

type IMPEG2StreamIdMapVtbl
	QueryInterface as function(byval as IMPEG2StreamIdMap ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IMPEG2StreamIdMap ptr) as ULONG
	Release as function(byval as IMPEG2StreamIdMap ptr) as ULONG
	MapStreamId as function(byval as IMPEG2StreamIdMap ptr, byval as ULONG, byval as DWORD, byval as ULONG, byval as integer) as HRESULT
	UnmapStreamId as function(byval as IMPEG2StreamIdMap ptr, byval as ULONG, byval as ULONG ptr) as HRESULT
	EnumStreamIdMap as function(byval as IMPEG2StreamIdMap ptr, byval as IEnumStreamIdMap ptr ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IMPEG2StreamIdMap_MapStreamId_Proxy alias "IMPEG2StreamIdMap_MapStreamId_Proxy" (byval This as IMPEG2StreamIdMap ptr, byval ulStreamId as ULONG, byval MediaSampleContent as DWORD, byval ulSubstreamFilterValue as ULONG, byval iDataOffset as integer) as HRESULT
declare sub IMPEG2StreamIdMap_MapStreamId_Stub alias "IMPEG2StreamIdMap_MapStreamId_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMPEG2StreamIdMap_UnmapStreamId_Proxy alias "IMPEG2StreamIdMap_UnmapStreamId_Proxy" (byval This as IMPEG2StreamIdMap ptr, byval culStreamId as ULONG, byval pulStreamId as ULONG ptr) as HRESULT
declare sub IMPEG2StreamIdMap_UnmapStreamId_Stub alias "IMPEG2StreamIdMap_UnmapStreamId_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMPEG2StreamIdMap_EnumStreamIdMap_Proxy alias "IMPEG2StreamIdMap_EnumStreamIdMap_Proxy" (byval This as IMPEG2StreamIdMap ptr, byval ppIEnumStreamIdMap as IEnumStreamIdMap ptr ptr) as HRESULT
declare sub IMPEG2StreamIdMap_EnumStreamIdMap_Stub alias "IMPEG2StreamIdMap_EnumStreamIdMap_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IRegisterServiceProvider alias "IID_IRegisterServiceProvider" as IID

type IRegisterServiceProviderVtbl_ as IRegisterServiceProviderVtbl

type IRegisterServiceProvider
	lpVtbl as IRegisterServiceProviderVtbl_ ptr
end type

type IRegisterServiceProviderVtbl
	QueryInterface as function(byval as IRegisterServiceProvider ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IRegisterServiceProvider ptr) as ULONG
	Release as function(byval as IRegisterServiceProvider ptr) as ULONG
	RegisterService as function(byval as IRegisterServiceProvider ptr, byval as GUID ptr, byval as IUnknown ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IRegisterServiceProvider_RegisterService_Proxy alias "IRegisterServiceProvider_RegisterService_Proxy" (byval This as IRegisterServiceProvider ptr, byval guidService as GUID ptr, byval pUnkObject as IUnknown ptr) as HRESULT
declare sub IRegisterServiceProvider_RegisterService_Stub alias "IRegisterServiceProvider_RegisterService_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IAMClockSlave alias "IID_IAMClockSlave" as IID

type IAMClockSlaveVtbl_ as IAMClockSlaveVtbl

type IAMClockSlave
	lpVtbl as IAMClockSlaveVtbl_ ptr
end type

type IAMClockSlaveVtbl
	QueryInterface as function(byval as IAMClockSlave ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMClockSlave ptr) as ULONG
	Release as function(byval as IAMClockSlave ptr) as ULONG
	SetErrorTolerance as function(byval as IAMClockSlave ptr, byval as DWORD) as HRESULT
	GetErrorTolerance as function(byval as IAMClockSlave ptr, byval as DWORD ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMClockSlave_SetErrorTolerance_Proxy alias "IAMClockSlave_SetErrorTolerance_Proxy" (byval This as IAMClockSlave ptr, byval dwTolerance as DWORD) as HRESULT
declare sub IAMClockSlave_SetErrorTolerance_Stub alias "IAMClockSlave_SetErrorTolerance_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMClockSlave_GetErrorTolerance_Proxy alias "IAMClockSlave_GetErrorTolerance_Proxy" (byval This as IAMClockSlave ptr, byval pdwTolerance as DWORD ptr) as HRESULT
declare sub IAMClockSlave_GetErrorTolerance_Stub alias "IAMClockSlave_GetErrorTolerance_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IAMGraphBuilderCallback alias "IID_IAMGraphBuilderCallback" as IID

type IAMGraphBuilderCallbackVtbl_ as IAMGraphBuilderCallbackVtbl

type IAMGraphBuilderCallback
	lpVtbl as IAMGraphBuilderCallbackVtbl_ ptr
end type

type IAMGraphBuilderCallbackVtbl
	QueryInterface as function(byval as IAMGraphBuilderCallback ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMGraphBuilderCallback ptr) as ULONG
	Release as function(byval as IAMGraphBuilderCallback ptr) as ULONG
	SelectedFilter as function(byval as IAMGraphBuilderCallback ptr, byval as IMoniker ptr) as HRESULT
	CreatedFilter as function(byval as IAMGraphBuilderCallback ptr, byval as IBaseFilter ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMGraphBuilderCallback_SelectedFilter_Proxy alias "IAMGraphBuilderCallback_SelectedFilter_Proxy" (byval This as IAMGraphBuilderCallback ptr, byval pMon as IMoniker ptr) as HRESULT
declare sub IAMGraphBuilderCallback_SelectedFilter_Stub alias "IAMGraphBuilderCallback_SelectedFilter_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAMGraphBuilderCallback_CreatedFilter_Proxy alias "IAMGraphBuilderCallback_CreatedFilter_Proxy" (byval This as IAMGraphBuilderCallback ptr, byval pFil as IBaseFilter ptr) as HRESULT
declare sub IAMGraphBuilderCallback_CreatedFilter_Stub alias "IAMGraphBuilderCallback_CreatedFilter_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type CodecAPIEventData
	guid as GUID
	dataLength as DWORD
	reserved(0 to 3-1) as DWORD
end type
extern IID_ICodecAPI alias "IID_ICodecAPI" as IID

type ICodecAPIVtbl_ as ICodecAPIVtbl

type ICodecAPI
	lpVtbl as ICodecAPIVtbl_ ptr
end type

type ICodecAPIVtbl
	QueryInterface as function(byval as ICodecAPI ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as ICodecAPI ptr) as ULONG
	Release as function(byval as ICodecAPI ptr) as ULONG
	IsSupported as function(byval as ICodecAPI ptr, byval as GUID ptr) as HRESULT
	IsModifiable as function(byval as ICodecAPI ptr, byval as GUID ptr) as HRESULT
	GetParameterRange as function(byval as ICodecAPI ptr, byval as GUID ptr, byval as VARIANT ptr, byval as VARIANT ptr, byval as VARIANT ptr) as HRESULT
	GetParameterValues as function(byval as ICodecAPI ptr, byval as GUID ptr, byval as VARIANT ptr ptr, byval as ULONG ptr) as HRESULT
	GetDefaultValue as function(byval as ICodecAPI ptr, byval as GUID ptr, byval as VARIANT ptr) as HRESULT
	GetValue as function(byval as ICodecAPI ptr, byval as GUID ptr, byval as VARIANT ptr) as HRESULT
	SetValue as function(byval as ICodecAPI ptr, byval as GUID ptr, byval as VARIANT ptr) as HRESULT
	RegisterForEvent as function(byval as ICodecAPI ptr, byval as GUID ptr, byval as LONG_PTR) as HRESULT
	UnregisterForEvent as function(byval as ICodecAPI ptr, byval as GUID ptr) as HRESULT
	SetAllDefaults as function(byval as ICodecAPI ptr) as HRESULT
	SetValueWithNotify as function(byval as ICodecAPI ptr, byval as GUID ptr, byval as VARIANT ptr, byval as GUID ptr ptr, byval as ULONG ptr) as HRESULT
	SetAllDefaultsWithNotify as function(byval as ICodecAPI ptr, byval as GUID ptr ptr, byval as ULONG ptr) as HRESULT
	GetAllSettings as function(byval as ICodecAPI ptr, byval as IStream ptr) as HRESULT
	SetAllSettings as function(byval as ICodecAPI ptr, byval as IStream ptr) as HRESULT
	SetAllSettingsWithNotify as function(byval as ICodecAPI ptr, byval as IStream ptr, byval as GUID ptr ptr, byval as ULONG ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function ICodecAPI_IsSupported_Proxy alias "ICodecAPI_IsSupported_Proxy" (byval This as ICodecAPI ptr, byval Api as GUID ptr) as HRESULT
declare sub ICodecAPI_IsSupported_Stub alias "ICodecAPI_IsSupported_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICodecAPI_IsModifiable_Proxy alias "ICodecAPI_IsModifiable_Proxy" (byval This as ICodecAPI ptr, byval Api as GUID ptr) as HRESULT
declare sub ICodecAPI_IsModifiable_Stub alias "ICodecAPI_IsModifiable_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICodecAPI_GetParameterRange_Proxy alias "ICodecAPI_GetParameterRange_Proxy" (byval This as ICodecAPI ptr, byval Api as GUID ptr, byval ValueMin as VARIANT ptr, byval ValueMax as VARIANT ptr, byval SteppingDelta as VARIANT ptr) as HRESULT
declare sub ICodecAPI_GetParameterRange_Stub alias "ICodecAPI_GetParameterRange_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICodecAPI_GetParameterValues_Proxy alias "ICodecAPI_GetParameterValues_Proxy" (byval This as ICodecAPI ptr, byval Api as GUID ptr, byval Values as VARIANT ptr ptr, byval ValuesCount as ULONG ptr) as HRESULT
declare sub ICodecAPI_GetParameterValues_Stub alias "ICodecAPI_GetParameterValues_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICodecAPI_GetDefaultValue_Proxy alias "ICodecAPI_GetDefaultValue_Proxy" (byval This as ICodecAPI ptr, byval Api as GUID ptr, byval Value as VARIANT ptr) as HRESULT
declare sub ICodecAPI_GetDefaultValue_Stub alias "ICodecAPI_GetDefaultValue_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICodecAPI_GetValue_Proxy alias "ICodecAPI_GetValue_Proxy" (byval This as ICodecAPI ptr, byval Api as GUID ptr, byval Value as VARIANT ptr) as HRESULT
declare sub ICodecAPI_GetValue_Stub alias "ICodecAPI_GetValue_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICodecAPI_SetValue_Proxy alias "ICodecAPI_SetValue_Proxy" (byval This as ICodecAPI ptr, byval Api as GUID ptr, byval Value as VARIANT ptr) as HRESULT
declare sub ICodecAPI_SetValue_Stub alias "ICodecAPI_SetValue_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICodecAPI_RegisterForEvent_Proxy alias "ICodecAPI_RegisterForEvent_Proxy" (byval This as ICodecAPI ptr, byval Api as GUID ptr, byval userData as LONG_PTR) as HRESULT
declare sub ICodecAPI_RegisterForEvent_Stub alias "ICodecAPI_RegisterForEvent_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICodecAPI_UnregisterForEvent_Proxy alias "ICodecAPI_UnregisterForEvent_Proxy" (byval This as ICodecAPI ptr, byval Api as GUID ptr) as HRESULT
declare sub ICodecAPI_UnregisterForEvent_Stub alias "ICodecAPI_UnregisterForEvent_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICodecAPI_SetAllDefaults_Proxy alias "ICodecAPI_SetAllDefaults_Proxy" (byval This as ICodecAPI ptr) as HRESULT
declare sub ICodecAPI_SetAllDefaults_Stub alias "ICodecAPI_SetAllDefaults_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICodecAPI_SetValueWithNotify_Proxy alias "ICodecAPI_SetValueWithNotify_Proxy" (byval This as ICodecAPI ptr, byval Api as GUID ptr, byval Value as VARIANT ptr, byval ChangedParam as GUID ptr ptr, byval ChangedParamCount as ULONG ptr) as HRESULT
declare sub ICodecAPI_SetValueWithNotify_Stub alias "ICodecAPI_SetValueWithNotify_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICodecAPI_SetAllDefaultsWithNotify_Proxy alias "ICodecAPI_SetAllDefaultsWithNotify_Proxy" (byval This as ICodecAPI ptr, byval ChangedParam as GUID ptr ptr, byval ChangedParamCount as ULONG ptr) as HRESULT
declare sub ICodecAPI_SetAllDefaultsWithNotify_Stub alias "ICodecAPI_SetAllDefaultsWithNotify_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICodecAPI_GetAllSettings_Proxy alias "ICodecAPI_GetAllSettings_Proxy" (byval This as ICodecAPI ptr, byval __MIDL_0016 as IStream ptr) as HRESULT
declare sub ICodecAPI_GetAllSettings_Stub alias "ICodecAPI_GetAllSettings_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICodecAPI_SetAllSettings_Proxy alias "ICodecAPI_SetAllSettings_Proxy" (byval This as ICodecAPI ptr, byval __MIDL_0017 as IStream ptr) as HRESULT
declare sub ICodecAPI_SetAllSettings_Stub alias "ICodecAPI_SetAllSettings_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICodecAPI_SetAllSettingsWithNotify_Proxy alias "ICodecAPI_SetAllSettingsWithNotify_Proxy" (byval This as ICodecAPI ptr, byval __MIDL_0018 as IStream ptr, byval ChangedParam as GUID ptr ptr, byval ChangedParamCount as ULONG ptr) as HRESULT
declare sub ICodecAPI_SetAllSettingsWithNotify_Stub alias "ICodecAPI_SetAllSettingsWithNotify_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IGetCapabilitiesKey alias "IID_IGetCapabilitiesKey" as IID

type IGetCapabilitiesKeyVtbl_ as IGetCapabilitiesKeyVtbl

type IGetCapabilitiesKey
	lpVtbl as IGetCapabilitiesKeyVtbl_ ptr
end type

type IGetCapabilitiesKeyVtbl
	QueryInterface as function(byval as IGetCapabilitiesKey ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IGetCapabilitiesKey ptr) as ULONG
	Release as function(byval as IGetCapabilitiesKey ptr) as ULONG
	GetCapabilitiesKey as function(byval as IGetCapabilitiesKey ptr, byval as HKEY ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IGetCapabilitiesKey_GetCapabilitiesKey_Proxy alias "IGetCapabilitiesKey_GetCapabilitiesKey_Proxy" (byval This as IGetCapabilitiesKey ptr, byval pHKey as HKEY ptr) as HRESULT
declare sub IGetCapabilitiesKey_GetCapabilitiesKey_Stub alias "IGetCapabilitiesKey_GetCapabilitiesKey_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IEncoderAPI alias "IID_IEncoderAPI" as IID

type IEncoderAPIVtbl_ as IEncoderAPIVtbl

type IEncoderAPI
	lpVtbl as IEncoderAPIVtbl_ ptr
end type

type IEncoderAPIVtbl
	QueryInterface as function(byval as IEncoderAPI ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IEncoderAPI ptr) as ULONG
	Release as function(byval as IEncoderAPI ptr) as ULONG
	IsSupported as function(byval as IEncoderAPI ptr, byval as GUID ptr) as HRESULT
	IsAvailable as function(byval as IEncoderAPI ptr, byval as GUID ptr) as HRESULT
	GetParameterRange as function(byval as IEncoderAPI ptr, byval as GUID ptr, byval as VARIANT ptr, byval as VARIANT ptr, byval as VARIANT ptr) as HRESULT
	GetParameterValues as function(byval as IEncoderAPI ptr, byval as GUID ptr, byval as VARIANT ptr ptr, byval as ULONG ptr) as HRESULT
	GetDefaultValue as function(byval as IEncoderAPI ptr, byval as GUID ptr, byval as VARIANT ptr) as HRESULT
	GetValue as function(byval as IEncoderAPI ptr, byval as GUID ptr, byval as VARIANT ptr) as HRESULT
	SetValue as function(byval as IEncoderAPI ptr, byval as GUID ptr, byval as VARIANT ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IEncoderAPI_IsSupported_Proxy alias "IEncoderAPI_IsSupported_Proxy" (byval This as IEncoderAPI ptr, byval Api as GUID ptr) as HRESULT
declare sub IEncoderAPI_IsSupported_Stub alias "IEncoderAPI_IsSupported_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEncoderAPI_IsAvailable_Proxy alias "IEncoderAPI_IsAvailable_Proxy" (byval This as IEncoderAPI ptr, byval Api as GUID ptr) as HRESULT
declare sub IEncoderAPI_IsAvailable_Stub alias "IEncoderAPI_IsAvailable_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEncoderAPI_GetParameterRange_Proxy alias "IEncoderAPI_GetParameterRange_Proxy" (byval This as IEncoderAPI ptr, byval Api as GUID ptr, byval ValueMin as VARIANT ptr, byval ValueMax as VARIANT ptr, byval SteppingDelta as VARIANT ptr) as HRESULT
declare sub IEncoderAPI_GetParameterRange_Stub alias "IEncoderAPI_GetParameterRange_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEncoderAPI_GetParameterValues_Proxy alias "IEncoderAPI_GetParameterValues_Proxy" (byval This as IEncoderAPI ptr, byval Api as GUID ptr, byval Values as VARIANT ptr ptr, byval ValuesCount as ULONG ptr) as HRESULT
declare sub IEncoderAPI_GetParameterValues_Stub alias "IEncoderAPI_GetParameterValues_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEncoderAPI_GetDefaultValue_Proxy alias "IEncoderAPI_GetDefaultValue_Proxy" (byval This as IEncoderAPI ptr, byval Api as GUID ptr, byval Value as VARIANT ptr) as HRESULT
declare sub IEncoderAPI_GetDefaultValue_Stub alias "IEncoderAPI_GetDefaultValue_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEncoderAPI_GetValue_Proxy alias "IEncoderAPI_GetValue_Proxy" (byval This as IEncoderAPI ptr, byval Api as GUID ptr, byval Value as VARIANT ptr) as HRESULT
declare sub IEncoderAPI_GetValue_Stub alias "IEncoderAPI_GetValue_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEncoderAPI_SetValue_Proxy alias "IEncoderAPI_SetValue_Proxy" (byval This as IEncoderAPI ptr, byval Api as GUID ptr, byval Value as VARIANT ptr) as HRESULT
declare sub IEncoderAPI_SetValue_Stub alias "IEncoderAPI_SetValue_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IVideoEncoder alias "IID_IVideoEncoder" as IID

type IVideoEncoderVtbl_ as IVideoEncoderVtbl

type IVideoEncoder
	lpVtbl as IVideoEncoderVtbl_ ptr
end type

type IVideoEncoderVtbl
	QueryInterface as function(byval as IVideoEncoder ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IVideoEncoder ptr) as ULONG
	Release as function(byval as IVideoEncoder ptr) as ULONG
	IsSupported as function(byval as IVideoEncoder ptr, byval as GUID ptr) as HRESULT
	IsAvailable as function(byval as IVideoEncoder ptr, byval as GUID ptr) as HRESULT
	GetParameterRange as function(byval as IVideoEncoder ptr, byval as GUID ptr, byval as VARIANT ptr, byval as VARIANT ptr, byval as VARIANT ptr) as HRESULT
	GetParameterValues as function(byval as IVideoEncoder ptr, byval as GUID ptr, byval as VARIANT ptr ptr, byval as ULONG ptr) as HRESULT
	GetDefaultValue as function(byval as IVideoEncoder ptr, byval as GUID ptr, byval as VARIANT ptr) as HRESULT
	GetValue as function(byval as IVideoEncoder ptr, byval as GUID ptr, byval as VARIANT ptr) as HRESULT
	SetValue as function(byval as IVideoEncoder ptr, byval as GUID ptr, byval as VARIANT ptr) as HRESULT
end type

enum VIDEOENCODER_BITRATE_MODE
	ConstantBitRate = 0
	VariableBitRateAverage = ConstantBitRate+1
	VariableBitRatePeak = VariableBitRateAverage+1
end enum

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
extern IID_IAMDecoderCaps alias "IID_IAMDecoderCaps" as IID

type IAMDecoderCapsVtbl_ as IAMDecoderCapsVtbl

type IAMDecoderCaps
	lpVtbl as IAMDecoderCapsVtbl_ ptr
end type

type IAMDecoderCapsVtbl
	QueryInterface as function(byval as IAMDecoderCaps ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IAMDecoderCaps ptr) as ULONG
	Release as function(byval as IAMDecoderCaps ptr) as ULONG
	GetDecoderCaps as function(byval as IAMDecoderCaps ptr, byval as DWORD, byval as DWORD ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IAMDecoderCaps_GetDecoderCaps_Proxy alias "IAMDecoderCaps_GetDecoderCaps_Proxy" (byval This as IAMDecoderCaps ptr, byval dwCapIndex as DWORD, byval lpdwCap as DWORD ptr) as HRESULT
declare sub IAMDecoderCaps_GetDecoderCaps_Stub alias "IAMDecoderCaps_GetDecoderCaps_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

#include once "win/ddraw.bi"

enum DVD_DOMAIN
	DVD_DOMAIN_FirstPlay = 1
	DVD_DOMAIN_VideoManagerMenu = DVD_DOMAIN_FirstPlay+1
	DVD_DOMAIN_VideoTitleSetMenu = DVD_DOMAIN_VideoManagerMenu+1
	DVD_DOMAIN_Title = DVD_DOMAIN_VideoTitleSetMenu+1
	DVD_DOMAIN_Stop = DVD_DOMAIN_Title+1
end enum

enum DVD_MENU_ID
	DVD_MENU_Title = 2
	DVD_MENU_Root = 3
	DVD_MENU_Subpicture = 4
	DVD_MENU_Audio = 5
	DVD_MENU_Angle = 6
	DVD_MENU_Chapter = 7
end enum

enum DVD_DISC_SIDE
	DVD_SIDE_A = 1
	DVD_SIDE_B = 2
end enum

enum DVD_PREFERRED_DISPLAY_MODE
	DISPLAY_CONTENT_DEFAULT = 0
	DISPLAY_16x9 = 1
	DISPLAY_4x3_PANSCAN_PREFERRED = 2
	DISPLAY_4x3_LETTERBOX_PREFERRED = 3
end enum

type DVD_REGISTER as WORD
type GPRMARRAY as DVD_REGISTER ptr
type SPRMARRAY as DVD_REGISTER ptr

type DVD_ATR
	ulCAT as ULONG
	pbATRI(0 to 768-1) as BYTE
end type

type DVD_VideoATR as BYTE ptr
type DVD_AudioATR as BYTE ptr
type DVD_SubpictureATR as BYTE ptr

enum DVD_FRAMERATE
	DVD_FPS_25 = 1
	DVD_FPS_30NonDrop = 3
end enum

type DVD_TIMECODE
	Hours1:4 as ULONG
	Hours10:4 as ULONG
	Minutes1:4 as ULONG
	Minutes10:4 as ULONG
	Seconds1:4 as ULONG
	Seconds10:4 as ULONG
	Frames1:4 as ULONG
	Frames10:2 as ULONG
	FrameRateCode:2 as ULONG
end type

enum DVD_TIMECODE_FLAGS
	DVD_TC_FLAG_25fps = &h1
	DVD_TC_FLAG_30fps = &h2
	DVD_TC_FLAG_DropFrame = &h4
	DVD_TC_FLAG_Interpolated = &h8
end enum

type DVD_HMSF_TIMECODE
	bHours as BYTE
	bMinutes as BYTE
	bSeconds as BYTE
	bFrames as BYTE
end type

type DVD_PLAYBACK_LOCATION2
	TitleNum as ULONG
	ChapterNum as ULONG
	TimeCode as DVD_HMSF_TIMECODE
	TimeCodeFlags as ULONG
end type

type DVD_PLAYBACK_LOCATION
	TitleNum as ULONG
	ChapterNum as ULONG
	TimeCode as ULONG
end type

type VALID_UOP_SOMTHING_OR_OTHER as DWORD

enum VALID_UOP_FLAG
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

enum DVD_CMD_FLAGS
	DVD_CMD_FLAG_None = 0
	DVD_CMD_FLAG_Flush = &h1
	DVD_CMD_FLAG_SendEvents = &h2
	DVD_CMD_FLAG_Block = &h4
	DVD_CMD_FLAG_StartWhenRendered = &h8
	DVD_CMD_FLAG_EndAfterRendered = &h10
end enum

enum DVD_OPTION_FLAG
	DVD_ResetOnStop = 1
	DVD_NotifyParentalLevelChange = 2
	DVD_HMSF_TimeCodeEvents = 3
	DVD_AudioDuringFFwdRew = 4
end enum

enum DVD_RELATIVE_BUTTON
	DVD_Relative_Upper = 1
	DVD_Relative_Lower = 2
	DVD_Relative_Left = 3
	DVD_Relative_Right = 4
end enum

enum DVD_PARENTAL_LEVEL
	DVD_PARENTAL_LEVEL_8 = &h8000
	DVD_PARENTAL_LEVEL_7 = &h4000
	DVD_PARENTAL_LEVEL_6 = &h2000
	DVD_PARENTAL_LEVEL_5 = &h1000
	DVD_PARENTAL_LEVEL_4 = &h800
	DVD_PARENTAL_LEVEL_3 = &h400
	DVD_PARENTAL_LEVEL_2 = &h200
	DVD_PARENTAL_LEVEL_1 = &h100
end enum

enum DVD_AUDIO_LANG_EXT
	DVD_AUD_EXT_NotSpecified = 0
	DVD_AUD_EXT_Captions = 1
	DVD_AUD_EXT_VisuallyImpaired = 2
	DVD_AUD_EXT_DirectorComments1 = 3
	DVD_AUD_EXT_DirectorComments2 = 4
end enum

enum DVD_SUBPICTURE_LANG_EXT
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

enum DVD_AUDIO_APPMODE
	DVD_AudioMode_None = 0
	DVD_AudioMode_Karaoke = 1
	DVD_AudioMode_Surround = 2
	DVD_AudioMode_Other = 3
end enum

enum DVD_AUDIO_FORMAT
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

enum DVD_KARAOKE_DOWNMIX
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

type DVD_AudioAttributes
	AppMode as DVD_AUDIO_APPMODE
	AppModeData as BYTE
	AudioFormat as DVD_AUDIO_FORMAT
	Language as LCID
	LanguageExtension as DVD_AUDIO_LANG_EXT
	fHasMultichannelInfo as BOOL
	dwFrequency as DWORD
	bQuantization as BYTE
	bNumberOfChannels as BYTE
	dwReserved(0 to 2-1) as DWORD
end type

type DVD_MUA_MixingInfo
	fMixTo0 as BOOL
	fMixTo1 as BOOL
	fMix0InPhase as BOOL
	fMix1InPhase as BOOL
	dwSpeakerPosition as DWORD
end type

type DVD_MUA_Coeff
	log2_alpha as double
	log2_beta as double
end type

type DVD_MultichannelAudioAttributes
	Info(0 to 8-1) as DVD_MUA_MixingInfo
	Coeff(0 to 8-1) as DVD_MUA_Coeff
end type

enum DVD_KARAOKE_CONTENTS
	DVD_Karaoke_GuideVocal1 = &h1
	DVD_Karaoke_GuideVocal2 = &h2
	DVD_Karaoke_GuideMelody1 = &h4
	DVD_Karaoke_GuideMelody2 = &h8
	DVD_Karaoke_GuideMelodyA = &h10
	DVD_Karaoke_GuideMelodyB = &h20
	DVD_Karaoke_SoundEffectA = &h40
	DVD_Karaoke_SoundEffectB = &h80
end enum

enum DVD_KARAOKE_ASSIGNMENT
	DVD_Assignment_reserved0 = 0
	DVD_Assignment_reserved1 = 1
	DVD_Assignment_LR = 2
	DVD_Assignment_LRM = 3
	DVD_Assignment_LR1 = 4
	DVD_Assignment_LRM1 = 5
	DVD_Assignment_LR12 = 6
	DVD_Assignment_LRM12 = 7
end enum

type DVD_KaraokeAttributes
	bVersion as BYTE
	fMasterOfCeremoniesInGuideVocal1 as BOOL
	fDuet as BOOL
	ChannelAssignment as DVD_KARAOKE_ASSIGNMENT
	wChannelContents(0 to 8-1) as WORD
end type

enum DVD_VIDEO_COMPRESSION
	DVD_VideoCompression_Other = 0
	DVD_VideoCompression_MPEG1 = 1
	DVD_VideoCompression_MPEG2 = 2
end enum

type DVD_VideoAttributes
	fPanscanPermitted as BOOL
	fLetterboxPermitted as BOOL
	ulAspectX as ULONG
	ulAspectY as ULONG
	ulFrameRate as ULONG
	ulFrameHeight as ULONG
	Compression as DVD_VIDEO_COMPRESSION
	fLine21Field1InGOP as BOOL
	fLine21Field2InGOP as BOOL
	ulSourceResolutionX as ULONG
	ulSourceResolutionY as ULONG
	fIsSourceLetterboxed as BOOL
	fIsFilmMode as BOOL
end type

enum DVD_SUBPICTURE_TYPE
	DVD_SPType_NotSpecified = 0
	DVD_SPType_Language = 1
	DVD_SPType_Other = 2
end enum

enum DVD_SUBPICTURE_CODING
	DVD_SPCoding_RunLength = 0
	DVD_SPCoding_Extended = 1
	DVD_SPCoding_Other = 2
end enum

type DVD_SubpictureAttributes
	Type as DVD_SUBPICTURE_TYPE
	CodingMode as DVD_SUBPICTURE_CODING
	Language as LCID
	LanguageExtension as DVD_SUBPICTURE_LANG_EXT
end type

enum DVD_TITLE_APPMODE
	DVD_AppMode_Not_Specified = 0
	DVD_AppMode_Karaoke = 1
	DVD_AppMode_Other = 3
end enum

type DVD_TitleAttributes
	AppMode as DVD_TITLE_APPMODE
	VideoAttributes as DVD_VideoAttributes
	ulNumberOfAudioStreams as ULONG
	AudioAttributes(0 to 8-1) as DVD_AudioAttributes
	MultichannelAudioAttributes(0 to 8-1) as DVD_MultichannelAudioAttributes
	ulNumberOfSubpictureStreams as ULONG
	SubpictureAttributes(0 to 32-1) as DVD_SubpictureAttributes
end type

type DVD_MenuAttributes
	fCompatibleRegion(0 to 8-1) as BOOL
	VideoAttributes as DVD_VideoAttributes
	fAudioPresent as BOOL
	AudioAttributes as DVD_AudioAttributes
	fSubpicturePresent as BOOL
	SubpictureAttributes as DVD_SubpictureAttributes
end type

extern IID_IDvdControl alias "IID_IDvdControl" as IID

type IDvdControlVtbl_ as IDvdControlVtbl

type IDvdControl
	lpVtbl as IDvdControlVtbl_ ptr
end type

type IDvdControlVtbl
	QueryInterface as function(byval as IDvdControl ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IDvdControl ptr) as ULONG
	Release as function(byval as IDvdControl ptr) as ULONG
	TitlePlay as function(byval as IDvdControl ptr, byval as ULONG) as HRESULT
	ChapterPlay as function(byval as IDvdControl ptr, byval as ULONG, byval as ULONG) as HRESULT
	TimePlay as function(byval as IDvdControl ptr, byval as ULONG, byval as ULONG) as HRESULT
	StopForResume as function(byval as IDvdControl ptr) as HRESULT
	GoUp as function(byval as IDvdControl ptr) as HRESULT
	TimeSearch as function(byval as IDvdControl ptr, byval as ULONG) as HRESULT
	ChapterSearch as function(byval as IDvdControl ptr, byval as ULONG) as HRESULT
	PrevPGSearch as function(byval as IDvdControl ptr) as HRESULT
	TopPGSearch as function(byval as IDvdControl ptr) as HRESULT
	NextPGSearch as function(byval as IDvdControl ptr) as HRESULT
	ForwardScan as function(byval as IDvdControl ptr, byval as double) as HRESULT
	BackwardScan as function(byval as IDvdControl ptr, byval as double) as HRESULT
	MenuCall as function(byval as IDvdControl ptr, byval as DVD_MENU_ID) as HRESULT
	Resume as function(byval as IDvdControl ptr) as HRESULT
	UpperButtonSelect as function(byval as IDvdControl ptr) as HRESULT
	LowerButtonSelect as function(byval as IDvdControl ptr) as HRESULT
	LeftButtonSelect as function(byval as IDvdControl ptr) as HRESULT
	RightButtonSelect as function(byval as IDvdControl ptr) as HRESULT
	ButtonActivate as function(byval as IDvdControl ptr) as HRESULT
	ButtonSelectAndActivate as function(byval as IDvdControl ptr, byval as ULONG) as HRESULT
	StillOff as function(byval as IDvdControl ptr) as HRESULT
	PauseOn as function(byval as IDvdControl ptr) as HRESULT
	PauseOff as function(byval as IDvdControl ptr) as HRESULT
	MenuLanguageSelect as function(byval as IDvdControl ptr, byval as LCID) as HRESULT
	AudioStreamChange as function(byval as IDvdControl ptr, byval as ULONG) as HRESULT
	SubpictureStreamChange as function(byval as IDvdControl ptr, byval as ULONG, byval as BOOL) as HRESULT
	AngleChange as function(byval as IDvdControl ptr, byval as ULONG) as HRESULT
	ParentalLevelSelect as function(byval as IDvdControl ptr, byval as ULONG) as HRESULT
	ParentalCountrySelect as function(byval as IDvdControl ptr, byval as WORD) as HRESULT
	KaraokeAudioPresentationModeChange as function(byval as IDvdControl ptr, byval as ULONG) as HRESULT
	VideoModePreferrence as function(byval as IDvdControl ptr, byval as ULONG) as HRESULT
	SetRoot as function(byval as IDvdControl ptr, byval as LPCWSTR) as HRESULT
	MouseActivate as function(byval as IDvdControl ptr, byval as POINT) as HRESULT
	MouseSelect as function(byval as IDvdControl ptr, byval as POINT) as HRESULT
	ChapterPlayAutoStop as function(byval as IDvdControl ptr, byval as ULONG, byval as ULONG, byval as ULONG) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IDvdControl_TitlePlay_Proxy alias "IDvdControl_TitlePlay_Proxy" (byval This as IDvdControl ptr, byval ulTitle as ULONG) as HRESULT
declare sub IDvdControl_TitlePlay_Stub alias "IDvdControl_TitlePlay_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_ChapterPlay_Proxy alias "IDvdControl_ChapterPlay_Proxy" (byval This as IDvdControl ptr, byval ulTitle as ULONG, byval ulChapter as ULONG) as HRESULT
declare sub IDvdControl_ChapterPlay_Stub alias "IDvdControl_ChapterPlay_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_TimePlay_Proxy alias "IDvdControl_TimePlay_Proxy" (byval This as IDvdControl ptr, byval ulTitle as ULONG, byval bcdTime as ULONG) as HRESULT
declare sub IDvdControl_TimePlay_Stub alias "IDvdControl_TimePlay_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_StopForResume_Proxy alias "IDvdControl_StopForResume_Proxy" (byval This as IDvdControl ptr) as HRESULT
declare sub IDvdControl_StopForResume_Stub alias "IDvdControl_StopForResume_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_GoUp_Proxy alias "IDvdControl_GoUp_Proxy" (byval This as IDvdControl ptr) as HRESULT
declare sub IDvdControl_GoUp_Stub alias "IDvdControl_GoUp_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_TimeSearch_Proxy alias "IDvdControl_TimeSearch_Proxy" (byval This as IDvdControl ptr, byval bcdTime as ULONG) as HRESULT
declare sub IDvdControl_TimeSearch_Stub alias "IDvdControl_TimeSearch_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_ChapterSearch_Proxy alias "IDvdControl_ChapterSearch_Proxy" (byval This as IDvdControl ptr, byval ulChapter as ULONG) as HRESULT
declare sub IDvdControl_ChapterSearch_Stub alias "IDvdControl_ChapterSearch_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_PrevPGSearch_Proxy alias "IDvdControl_PrevPGSearch_Proxy" (byval This as IDvdControl ptr) as HRESULT
declare sub IDvdControl_PrevPGSearch_Stub alias "IDvdControl_PrevPGSearch_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_TopPGSearch_Proxy alias "IDvdControl_TopPGSearch_Proxy" (byval This as IDvdControl ptr) as HRESULT
declare sub IDvdControl_TopPGSearch_Stub alias "IDvdControl_TopPGSearch_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_NextPGSearch_Proxy alias "IDvdControl_NextPGSearch_Proxy" (byval This as IDvdControl ptr) as HRESULT
declare sub IDvdControl_NextPGSearch_Stub alias "IDvdControl_NextPGSearch_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_ForwardScan_Proxy alias "IDvdControl_ForwardScan_Proxy" (byval This as IDvdControl ptr, byval dwSpeed as double) as HRESULT
declare sub IDvdControl_ForwardScan_Stub alias "IDvdControl_ForwardScan_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_BackwardScan_Proxy alias "IDvdControl_BackwardScan_Proxy" (byval This as IDvdControl ptr, byval dwSpeed as double) as HRESULT
declare sub IDvdControl_BackwardScan_Stub alias "IDvdControl_BackwardScan_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_MenuCall_Proxy alias "IDvdControl_MenuCall_Proxy" (byval This as IDvdControl ptr, byval MenuID as DVD_MENU_ID) as HRESULT
declare sub IDvdControl_MenuCall_Stub alias "IDvdControl_MenuCall_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_Resume_Proxy alias "IDvdControl_Resume_Proxy" (byval This as IDvdControl ptr) as HRESULT
declare sub IDvdControl_Resume_Stub alias "IDvdControl_Resume_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_UpperButtonSelect_Proxy alias "IDvdControl_UpperButtonSelect_Proxy" (byval This as IDvdControl ptr) as HRESULT
declare sub IDvdControl_UpperButtonSelect_Stub alias "IDvdControl_UpperButtonSelect_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_LowerButtonSelect_Proxy alias "IDvdControl_LowerButtonSelect_Proxy" (byval This as IDvdControl ptr) as HRESULT
declare sub IDvdControl_LowerButtonSelect_Stub alias "IDvdControl_LowerButtonSelect_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_LeftButtonSelect_Proxy alias "IDvdControl_LeftButtonSelect_Proxy" (byval This as IDvdControl ptr) as HRESULT
declare sub IDvdControl_LeftButtonSelect_Stub alias "IDvdControl_LeftButtonSelect_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_RightButtonSelect_Proxy alias "IDvdControl_RightButtonSelect_Proxy" (byval This as IDvdControl ptr) as HRESULT
declare sub IDvdControl_RightButtonSelect_Stub alias "IDvdControl_RightButtonSelect_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_ButtonActivate_Proxy alias "IDvdControl_ButtonActivate_Proxy" (byval This as IDvdControl ptr) as HRESULT
declare sub IDvdControl_ButtonActivate_Stub alias "IDvdControl_ButtonActivate_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_ButtonSelectAndActivate_Proxy alias "IDvdControl_ButtonSelectAndActivate_Proxy" (byval This as IDvdControl ptr, byval ulButton as ULONG) as HRESULT
declare sub IDvdControl_ButtonSelectAndActivate_Stub alias "IDvdControl_ButtonSelectAndActivate_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_StillOff_Proxy alias "IDvdControl_StillOff_Proxy" (byval This as IDvdControl ptr) as HRESULT
declare sub IDvdControl_StillOff_Stub alias "IDvdControl_StillOff_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_PauseOn_Proxy alias "IDvdControl_PauseOn_Proxy" (byval This as IDvdControl ptr) as HRESULT
declare sub IDvdControl_PauseOn_Stub alias "IDvdControl_PauseOn_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_PauseOff_Proxy alias "IDvdControl_PauseOff_Proxy" (byval This as IDvdControl ptr) as HRESULT
declare sub IDvdControl_PauseOff_Stub alias "IDvdControl_PauseOff_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_MenuLanguageSelect_Proxy alias "IDvdControl_MenuLanguageSelect_Proxy" (byval This as IDvdControl ptr, byval Language as LCID) as HRESULT
declare sub IDvdControl_MenuLanguageSelect_Stub alias "IDvdControl_MenuLanguageSelect_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_AudioStreamChange_Proxy alias "IDvdControl_AudioStreamChange_Proxy" (byval This as IDvdControl ptr, byval ulAudio as ULONG) as HRESULT
declare sub IDvdControl_AudioStreamChange_Stub alias "IDvdControl_AudioStreamChange_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_SubpictureStreamChange_Proxy alias "IDvdControl_SubpictureStreamChange_Proxy" (byval This as IDvdControl ptr, byval ulSubPicture as ULONG, byval bDisplay as BOOL) as HRESULT
declare sub IDvdControl_SubpictureStreamChange_Stub alias "IDvdControl_SubpictureStreamChange_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_AngleChange_Proxy alias "IDvdControl_AngleChange_Proxy" (byval This as IDvdControl ptr, byval ulAngle as ULONG) as HRESULT
declare sub IDvdControl_AngleChange_Stub alias "IDvdControl_AngleChange_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_ParentalLevelSelect_Proxy alias "IDvdControl_ParentalLevelSelect_Proxy" (byval This as IDvdControl ptr, byval ulParentalLevel as ULONG) as HRESULT
declare sub IDvdControl_ParentalLevelSelect_Stub alias "IDvdControl_ParentalLevelSelect_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_ParentalCountrySelect_Proxy alias "IDvdControl_ParentalCountrySelect_Proxy" (byval This as IDvdControl ptr, byval wCountry as WORD) as HRESULT
declare sub IDvdControl_ParentalCountrySelect_Stub alias "IDvdControl_ParentalCountrySelect_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_KaraokeAudioPresentationModeChange_Proxy alias "IDvdControl_KaraokeAudioPresentationModeChange_Proxy" (byval This as IDvdControl ptr, byval ulMode as ULONG) as HRESULT
declare sub IDvdControl_KaraokeAudioPresentationModeChange_Stub alias "IDvdControl_KaraokeAudioPresentationModeChange_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_VideoModePreferrence_Proxy alias "IDvdControl_VideoModePreferrence_Proxy" (byval This as IDvdControl ptr, byval ulPreferredDisplayMode as ULONG) as HRESULT
declare sub IDvdControl_VideoModePreferrence_Stub alias "IDvdControl_VideoModePreferrence_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_SetRoot_Proxy alias "IDvdControl_SetRoot_Proxy" (byval This as IDvdControl ptr, byval pszPath as LPCWSTR) as HRESULT
declare sub IDvdControl_SetRoot_Stub alias "IDvdControl_SetRoot_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_MouseActivate_Proxy alias "IDvdControl_MouseActivate_Proxy" (byval This as IDvdControl ptr, byval point as POINT) as HRESULT
declare sub IDvdControl_MouseActivate_Stub alias "IDvdControl_MouseActivate_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_MouseSelect_Proxy alias "IDvdControl_MouseSelect_Proxy" (byval This as IDvdControl ptr, byval point as POINT) as HRESULT
declare sub IDvdControl_MouseSelect_Stub alias "IDvdControl_MouseSelect_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl_ChapterPlayAutoStop_Proxy alias "IDvdControl_ChapterPlayAutoStop_Proxy" (byval This as IDvdControl ptr, byval ulTitle as ULONG, byval ulChapter as ULONG, byval ulChaptersToPlay as ULONG) as HRESULT
declare sub IDvdControl_ChapterPlayAutoStop_Stub alias "IDvdControl_ChapterPlayAutoStop_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IDvdInfo alias "IID_IDvdInfo" as IID

type IDvdInfoVtbl_ as IDvdInfoVtbl

type IDvdInfo
	lpVtbl as IDvdInfoVtbl_ ptr
end type

type IDvdInfoVtbl
	QueryInterface as function(byval as IDvdInfo ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IDvdInfo ptr) as ULONG
	Release as function(byval as IDvdInfo ptr) as ULONG
	GetCurrentDomain as function(byval as IDvdInfo ptr, byval as DVD_DOMAIN ptr) as HRESULT
	GetCurrentLocation as function(byval as IDvdInfo ptr, byval as DVD_PLAYBACK_LOCATION ptr) as HRESULT
	GetTotalTitleTime as function(byval as IDvdInfo ptr, byval as ULONG ptr) as HRESULT
	GetCurrentButton as function(byval as IDvdInfo ptr, byval as ULONG ptr, byval as ULONG ptr) as HRESULT
	GetCurrentAngle as function(byval as IDvdInfo ptr, byval as ULONG ptr, byval as ULONG ptr) as HRESULT
	GetCurrentAudio as function(byval as IDvdInfo ptr, byval as ULONG ptr, byval as ULONG ptr) as HRESULT
	GetCurrentSubpicture as function(byval as IDvdInfo ptr, byval as ULONG ptr, byval as ULONG ptr, byval as BOOL ptr) as HRESULT
	GetCurrentUOPS as function(byval as IDvdInfo ptr, byval as VALID_UOP_SOMTHING_OR_OTHER ptr) as HRESULT
	GetAllSPRMs as function(byval as IDvdInfo ptr, byval as SPRMARRAY ptr) as HRESULT
	GetAllGPRMs as function(byval as IDvdInfo ptr, byval as GPRMARRAY ptr) as HRESULT
	GetAudioLanguage as function(byval as IDvdInfo ptr, byval as ULONG, byval as LCID ptr) as HRESULT
	GetSubpictureLanguage as function(byval as IDvdInfo ptr, byval as ULONG, byval as LCID ptr) as HRESULT
	GetTitleAttributes as function(byval as IDvdInfo ptr, byval as ULONG, byval as DVD_ATR ptr) as HRESULT
	GetVMGAttributes as function(byval as IDvdInfo ptr, byval as DVD_ATR ptr) as HRESULT
	GetCurrentVideoAttributes as function(byval as IDvdInfo ptr, byval as DVD_VideoATR ptr) as HRESULT
	GetCurrentAudioAttributes as function(byval as IDvdInfo ptr, byval as DVD_AudioATR ptr) as HRESULT
	GetCurrentSubpictureAttributes as function(byval as IDvdInfo ptr, byval as DVD_SubpictureATR ptr) as HRESULT
	GetCurrentVolumeInfo as function(byval as IDvdInfo ptr, byval as ULONG ptr, byval as ULONG ptr, byval as DVD_DISC_SIDE ptr, byval as ULONG ptr) as HRESULT
	GetDVDTextInfo as function(byval as IDvdInfo ptr, byval as BYTE ptr, byval as ULONG, byval as ULONG ptr) as HRESULT
	GetPlayerParentalLevel as function(byval as IDvdInfo ptr, byval as ULONG ptr, byval as ULONG ptr) as HRESULT
	GetNumberOfChapters as function(byval as IDvdInfo ptr, byval as ULONG, byval as ULONG ptr) as HRESULT
	GetTitleParentalLevels as function(byval as IDvdInfo ptr, byval as ULONG, byval as ULONG ptr) as HRESULT
	GetRoot as function(byval as IDvdInfo ptr, byval as LPSTR, byval as ULONG, byval as ULONG ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IDvdInfo_GetCurrentDomain_Proxy alias "IDvdInfo_GetCurrentDomain_Proxy" (byval This as IDvdInfo ptr, byval pDomain as DVD_DOMAIN ptr) as HRESULT
declare sub IDvdInfo_GetCurrentDomain_Stub alias "IDvdInfo_GetCurrentDomain_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetCurrentLocation_Proxy alias "IDvdInfo_GetCurrentLocation_Proxy" (byval This as IDvdInfo ptr, byval pLocation as DVD_PLAYBACK_LOCATION ptr) as HRESULT
declare sub IDvdInfo_GetCurrentLocation_Stub alias "IDvdInfo_GetCurrentLocation_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetTotalTitleTime_Proxy alias "IDvdInfo_GetTotalTitleTime_Proxy" (byval This as IDvdInfo ptr, byval pulTotalTime as ULONG ptr) as HRESULT
declare sub IDvdInfo_GetTotalTitleTime_Stub alias "IDvdInfo_GetTotalTitleTime_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetCurrentButton_Proxy alias "IDvdInfo_GetCurrentButton_Proxy" (byval This as IDvdInfo ptr, byval pulButtonsAvailable as ULONG ptr, byval pulCurrentButton as ULONG ptr) as HRESULT
declare sub IDvdInfo_GetCurrentButton_Stub alias "IDvdInfo_GetCurrentButton_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetCurrentAngle_Proxy alias "IDvdInfo_GetCurrentAngle_Proxy" (byval This as IDvdInfo ptr, byval pulAnglesAvailable as ULONG ptr, byval pulCurrentAngle as ULONG ptr) as HRESULT
declare sub IDvdInfo_GetCurrentAngle_Stub alias "IDvdInfo_GetCurrentAngle_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetCurrentAudio_Proxy alias "IDvdInfo_GetCurrentAudio_Proxy" (byval This as IDvdInfo ptr, byval pulStreamsAvailable as ULONG ptr, byval pulCurrentStream as ULONG ptr) as HRESULT
declare sub IDvdInfo_GetCurrentAudio_Stub alias "IDvdInfo_GetCurrentAudio_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetCurrentSubpicture_Proxy alias "IDvdInfo_GetCurrentSubpicture_Proxy" (byval This as IDvdInfo ptr, byval pulStreamsAvailable as ULONG ptr, byval pulCurrentStream as ULONG ptr, byval pIsDisabled as BOOL ptr) as HRESULT
declare sub IDvdInfo_GetCurrentSubpicture_Stub alias "IDvdInfo_GetCurrentSubpicture_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetCurrentUOPS_Proxy alias "IDvdInfo_GetCurrentUOPS_Proxy" (byval This as IDvdInfo ptr, byval pUOP as VALID_UOP_SOMTHING_OR_OTHER ptr) as HRESULT
declare sub IDvdInfo_GetCurrentUOPS_Stub alias "IDvdInfo_GetCurrentUOPS_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetAllSPRMs_Proxy alias "IDvdInfo_GetAllSPRMs_Proxy" (byval This as IDvdInfo ptr, byval pRegisterArray as SPRMARRAY ptr) as HRESULT
declare sub IDvdInfo_GetAllSPRMs_Stub alias "IDvdInfo_GetAllSPRMs_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetAllGPRMs_Proxy alias "IDvdInfo_GetAllGPRMs_Proxy" (byval This as IDvdInfo ptr, byval pRegisterArray as GPRMARRAY ptr) as HRESULT
declare sub IDvdInfo_GetAllGPRMs_Stub alias "IDvdInfo_GetAllGPRMs_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetAudioLanguage_Proxy alias "IDvdInfo_GetAudioLanguage_Proxy" (byval This as IDvdInfo ptr, byval ulStream as ULONG, byval pLanguage as LCID ptr) as HRESULT
declare sub IDvdInfo_GetAudioLanguage_Stub alias "IDvdInfo_GetAudioLanguage_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetSubpictureLanguage_Proxy alias "IDvdInfo_GetSubpictureLanguage_Proxy" (byval This as IDvdInfo ptr, byval ulStream as ULONG, byval pLanguage as LCID ptr) as HRESULT
declare sub IDvdInfo_GetSubpictureLanguage_Stub alias "IDvdInfo_GetSubpictureLanguage_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetTitleAttributes_Proxy alias "IDvdInfo_GetTitleAttributes_Proxy" (byval This as IDvdInfo ptr, byval ulTitle as ULONG, byval pATR as DVD_ATR ptr) as HRESULT
declare sub IDvdInfo_GetTitleAttributes_Stub alias "IDvdInfo_GetTitleAttributes_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetVMGAttributes_Proxy alias "IDvdInfo_GetVMGAttributes_Proxy" (byval This as IDvdInfo ptr, byval pATR as DVD_ATR ptr) as HRESULT
declare sub IDvdInfo_GetVMGAttributes_Stub alias "IDvdInfo_GetVMGAttributes_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetCurrentVideoAttributes_Proxy alias "IDvdInfo_GetCurrentVideoAttributes_Proxy" (byval This as IDvdInfo ptr, byval pATR as DVD_VideoATR ptr) as HRESULT
declare sub IDvdInfo_GetCurrentVideoAttributes_Stub alias "IDvdInfo_GetCurrentVideoAttributes_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetCurrentAudioAttributes_Proxy alias "IDvdInfo_GetCurrentAudioAttributes_Proxy" (byval This as IDvdInfo ptr, byval pATR as DVD_AudioATR ptr) as HRESULT
declare sub IDvdInfo_GetCurrentAudioAttributes_Stub alias "IDvdInfo_GetCurrentAudioAttributes_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetCurrentSubpictureAttributes_Proxy alias "IDvdInfo_GetCurrentSubpictureAttributes_Proxy" (byval This as IDvdInfo ptr, byval pATR as DVD_SubpictureATR ptr) as HRESULT
declare sub IDvdInfo_GetCurrentSubpictureAttributes_Stub alias "IDvdInfo_GetCurrentSubpictureAttributes_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetCurrentVolumeInfo_Proxy alias "IDvdInfo_GetCurrentVolumeInfo_Proxy" (byval This as IDvdInfo ptr, byval pulNumOfVol as ULONG ptr, byval pulThisVolNum as ULONG ptr, byval pSide as DVD_DISC_SIDE ptr, byval pulNumOfTitles as ULONG ptr) as HRESULT
declare sub IDvdInfo_GetCurrentVolumeInfo_Stub alias "IDvdInfo_GetCurrentVolumeInfo_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetDVDTextInfo_Proxy alias "IDvdInfo_GetDVDTextInfo_Proxy" (byval This as IDvdInfo ptr, byval pTextManager as BYTE ptr, byval ulBufSize as ULONG, byval pulActualSize as ULONG ptr) as HRESULT
declare sub IDvdInfo_GetDVDTextInfo_Stub alias "IDvdInfo_GetDVDTextInfo_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetPlayerParentalLevel_Proxy alias "IDvdInfo_GetPlayerParentalLevel_Proxy" (byval This as IDvdInfo ptr, byval pulParentalLevel as ULONG ptr, byval pulCountryCode as ULONG ptr) as HRESULT
declare sub IDvdInfo_GetPlayerParentalLevel_Stub alias "IDvdInfo_GetPlayerParentalLevel_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetNumberOfChapters_Proxy alias "IDvdInfo_GetNumberOfChapters_Proxy" (byval This as IDvdInfo ptr, byval ulTitle as ULONG, byval pulNumberOfChapters as ULONG ptr) as HRESULT
declare sub IDvdInfo_GetNumberOfChapters_Stub alias "IDvdInfo_GetNumberOfChapters_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetTitleParentalLevels_Proxy alias "IDvdInfo_GetTitleParentalLevels_Proxy" (byval This as IDvdInfo ptr, byval ulTitle as ULONG, byval pulParentalLevels as ULONG ptr) as HRESULT
declare sub IDvdInfo_GetTitleParentalLevels_Stub alias "IDvdInfo_GetTitleParentalLevels_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo_GetRoot_Proxy alias "IDvdInfo_GetRoot_Proxy" (byval This as IDvdInfo ptr, byval pRoot as LPSTR, byval ulBufSize as ULONG, byval pulActualSize as ULONG ptr) as HRESULT
declare sub IDvdInfo_GetRoot_Stub alias "IDvdInfo_GetRoot_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IDvdCmd alias "IID_IDvdCmd" as IID

type IDvdCmdVtbl_ as IDvdCmdVtbl

type IDvdCmd
	lpVtbl as IDvdCmdVtbl_ ptr
end type

type IDvdCmdVtbl
	QueryInterface as function(byval as IDvdCmd ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IDvdCmd ptr) as ULONG
	Release as function(byval as IDvdCmd ptr) as ULONG
	WaitForStart as function(byval as IDvdCmd ptr) as HRESULT
	WaitForEnd as function(byval as IDvdCmd ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IDvdCmd_WaitForStart_Proxy alias "IDvdCmd_WaitForStart_Proxy" (byval This as IDvdCmd ptr) as HRESULT
declare sub IDvdCmd_WaitForStart_Stub alias "IDvdCmd_WaitForStart_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdCmd_WaitForEnd_Proxy alias "IDvdCmd_WaitForEnd_Proxy" (byval This as IDvdCmd ptr) as HRESULT
declare sub IDvdCmd_WaitForEnd_Stub alias "IDvdCmd_WaitForEnd_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IDvdState alias "IID_IDvdState" as IID

type IDvdStateVtbl_ as IDvdStateVtbl

type IDvdState
	lpVtbl as IDvdStateVtbl_ ptr
end type

type IDvdStateVtbl
	QueryInterface as function(byval as IDvdState ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IDvdState ptr) as ULONG
	Release as function(byval as IDvdState ptr) as ULONG
	GetDiscID as function(byval as IDvdState ptr, byval as ULONGLONG ptr) as HRESULT
	GetParentalLevel as function(byval as IDvdState ptr, byval as ULONG ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IDvdState_GetDiscID_Proxy alias "IDvdState_GetDiscID_Proxy" (byval This as IDvdState ptr, byval pullUniqueID as ULONGLONG ptr) as HRESULT
declare sub IDvdState_GetDiscID_Stub alias "IDvdState_GetDiscID_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdState_GetParentalLevel_Proxy alias "IDvdState_GetParentalLevel_Proxy" (byval This as IDvdState ptr, byval pulParentalLevel as ULONG ptr) as HRESULT
declare sub IDvdState_GetParentalLevel_Stub alias "IDvdState_GetParentalLevel_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IDvdControl2 alias "IID_IDvdControl2" as IID

type IDvdControl2Vtbl_ as IDvdControl2Vtbl

type IDvdControl2
	lpVtbl as IDvdControl2Vtbl_ ptr
end type

type IDvdControl2Vtbl
	QueryInterface as function(byval as IDvdControl2 ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IDvdControl2 ptr) as ULONG
	Release as function(byval as IDvdControl2 ptr) as ULONG
	PlayTitle as function(byval as IDvdControl2 ptr, byval as ULONG, byval as DWORD, byval as IDvdCmd ptr ptr) as HRESULT
	PlayChapterInTitle as function(byval as IDvdControl2 ptr, byval as ULONG, byval as ULONG, byval as DWORD, byval as IDvdCmd ptr ptr) as HRESULT
	PlayAtTimeInTitle as function(byval as IDvdControl2 ptr, byval as ULONG, byval as DVD_HMSF_TIMECODE ptr, byval as DWORD, byval as IDvdCmd ptr ptr) as HRESULT
	Stop as function(byval as IDvdControl2 ptr) as HRESULT
	ReturnFromSubmenu as function(byval as IDvdControl2 ptr, byval as DWORD, byval as IDvdCmd ptr ptr) as HRESULT
	PlayAtTime as function(byval as IDvdControl2 ptr, byval as DVD_HMSF_TIMECODE ptr, byval as DWORD, byval as IDvdCmd ptr ptr) as HRESULT
	PlayChapter as function(byval as IDvdControl2 ptr, byval as ULONG, byval as DWORD, byval as IDvdCmd ptr ptr) as HRESULT
	PlayPrevChapter as function(byval as IDvdControl2 ptr, byval as DWORD, byval as IDvdCmd ptr ptr) as HRESULT
	ReplayChapter as function(byval as IDvdControl2 ptr, byval as DWORD, byval as IDvdCmd ptr ptr) as HRESULT
	PlayNextChapter as function(byval as IDvdControl2 ptr, byval as DWORD, byval as IDvdCmd ptr ptr) as HRESULT
	PlayForwards as function(byval as IDvdControl2 ptr, byval as double, byval as DWORD, byval as IDvdCmd ptr ptr) as HRESULT
	PlayBackwards as function(byval as IDvdControl2 ptr, byval as double, byval as DWORD, byval as IDvdCmd ptr ptr) as HRESULT
	ShowMenu as function(byval as IDvdControl2 ptr, byval as DVD_MENU_ID, byval as DWORD, byval as IDvdCmd ptr ptr) as HRESULT
	Resume as function(byval as IDvdControl2 ptr, byval as DWORD, byval as IDvdCmd ptr ptr) as HRESULT
	SelectRelativeButton as function(byval as IDvdControl2 ptr, byval as DVD_RELATIVE_BUTTON) as HRESULT
	ActivateButton as function(byval as IDvdControl2 ptr) as HRESULT
	SelectButton as function(byval as IDvdControl2 ptr, byval as ULONG) as HRESULT
	SelectAndActivateButton as function(byval as IDvdControl2 ptr, byval as ULONG) as HRESULT
	StillOff as function(byval as IDvdControl2 ptr) as HRESULT
	Pause as function(byval as IDvdControl2 ptr, byval as BOOL) as HRESULT
	SelectAudioStream as function(byval as IDvdControl2 ptr, byval as ULONG, byval as DWORD, byval as IDvdCmd ptr ptr) as HRESULT
	SelectSubpictureStream as function(byval as IDvdControl2 ptr, byval as ULONG, byval as DWORD, byval as IDvdCmd ptr ptr) as HRESULT
	SetSubpictureState as function(byval as IDvdControl2 ptr, byval as BOOL, byval as DWORD, byval as IDvdCmd ptr ptr) as HRESULT
	SelectAngle as function(byval as IDvdControl2 ptr, byval as ULONG, byval as DWORD, byval as IDvdCmd ptr ptr) as HRESULT
	SelectParentalLevel as function(byval as IDvdControl2 ptr, byval as ULONG) as HRESULT
	SelectParentalCountry as function(byval as IDvdControl2 ptr, byval as BYTE ptr) as HRESULT
	SelectKaraokeAudioPresentationMode as function(byval as IDvdControl2 ptr, byval as ULONG) as HRESULT
	SelectVideoModePreference as function(byval as IDvdControl2 ptr, byval as ULONG) as HRESULT
	SetDVDDirectory as function(byval as IDvdControl2 ptr, byval as LPCWSTR) as HRESULT
	ActivateAtPosition as function(byval as IDvdControl2 ptr, byval as POINT) as HRESULT
	SelectAtPosition as function(byval as IDvdControl2 ptr, byval as POINT) as HRESULT
	PlayChaptersAutoStop as function(byval as IDvdControl2 ptr, byval as ULONG, byval as ULONG, byval as ULONG, byval as DWORD, byval as IDvdCmd ptr ptr) as HRESULT
	AcceptParentalLevelChange as function(byval as IDvdControl2 ptr, byval as BOOL) as HRESULT
	SetOption as function(byval as IDvdControl2 ptr, byval as DVD_OPTION_FLAG, byval as BOOL) as HRESULT
	SetState as function(byval as IDvdControl2 ptr, byval as IDvdState ptr, byval as DWORD, byval as IDvdCmd ptr ptr) as HRESULT
	PlayPeriodInTitleAutoStop as function(byval as IDvdControl2 ptr, byval as ULONG, byval as DVD_HMSF_TIMECODE ptr, byval as DVD_HMSF_TIMECODE ptr, byval as DWORD, byval as IDvdCmd ptr ptr) as HRESULT
	SetGPRM as function(byval as IDvdControl2 ptr, byval as ULONG, byval as WORD, byval as DWORD, byval as IDvdCmd ptr ptr) as HRESULT
	SelectDefaultMenuLanguage as function(byval as IDvdControl2 ptr, byval as LCID) as HRESULT
	SelectDefaultAudioLanguage as function(byval as IDvdControl2 ptr, byval as LCID, byval as DVD_AUDIO_LANG_EXT) as HRESULT
	SelectDefaultSubpictureLanguage as function(byval as IDvdControl2 ptr, byval as LCID, byval as DVD_SUBPICTURE_LANG_EXT) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IDvdControl2_PlayTitle_Proxy alias "IDvdControl2_PlayTitle_Proxy" (byval This as IDvdControl2 ptr, byval ulTitle as ULONG, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_PlayTitle_Stub alias "IDvdControl2_PlayTitle_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_PlayChapterInTitle_Proxy alias "IDvdControl2_PlayChapterInTitle_Proxy" (byval This as IDvdControl2 ptr, byval ulTitle as ULONG, byval ulChapter as ULONG, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_PlayChapterInTitle_Stub alias "IDvdControl2_PlayChapterInTitle_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_PlayAtTimeInTitle_Proxy alias "IDvdControl2_PlayAtTimeInTitle_Proxy" (byval This as IDvdControl2 ptr, byval ulTitle as ULONG, byval pStartTime as DVD_HMSF_TIMECODE ptr, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_PlayAtTimeInTitle_Stub alias "IDvdControl2_PlayAtTimeInTitle_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_Stop_Proxy alias "IDvdControl2_Stop_Proxy" (byval This as IDvdControl2 ptr) as HRESULT
declare sub IDvdControl2_Stop_Stub alias "IDvdControl2_Stop_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_ReturnFromSubmenu_Proxy alias "IDvdControl2_ReturnFromSubmenu_Proxy" (byval This as IDvdControl2 ptr, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_ReturnFromSubmenu_Stub alias "IDvdControl2_ReturnFromSubmenu_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_PlayAtTime_Proxy alias "IDvdControl2_PlayAtTime_Proxy" (byval This as IDvdControl2 ptr, byval pTime as DVD_HMSF_TIMECODE ptr, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_PlayAtTime_Stub alias "IDvdControl2_PlayAtTime_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_PlayChapter_Proxy alias "IDvdControl2_PlayChapter_Proxy" (byval This as IDvdControl2 ptr, byval ulChapter as ULONG, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_PlayChapter_Stub alias "IDvdControl2_PlayChapter_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_PlayPrevChapter_Proxy alias "IDvdControl2_PlayPrevChapter_Proxy" (byval This as IDvdControl2 ptr, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_PlayPrevChapter_Stub alias "IDvdControl2_PlayPrevChapter_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_ReplayChapter_Proxy alias "IDvdControl2_ReplayChapter_Proxy" (byval This as IDvdControl2 ptr, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_ReplayChapter_Stub alias "IDvdControl2_ReplayChapter_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_PlayNextChapter_Proxy alias "IDvdControl2_PlayNextChapter_Proxy" (byval This as IDvdControl2 ptr, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_PlayNextChapter_Stub alias "IDvdControl2_PlayNextChapter_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_PlayForwards_Proxy alias "IDvdControl2_PlayForwards_Proxy" (byval This as IDvdControl2 ptr, byval dSpeed as double, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_PlayForwards_Stub alias "IDvdControl2_PlayForwards_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_PlayBackwards_Proxy alias "IDvdControl2_PlayBackwards_Proxy" (byval This as IDvdControl2 ptr, byval dSpeed as double, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_PlayBackwards_Stub alias "IDvdControl2_PlayBackwards_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_ShowMenu_Proxy alias "IDvdControl2_ShowMenu_Proxy" (byval This as IDvdControl2 ptr, byval MenuID as DVD_MENU_ID, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_ShowMenu_Stub alias "IDvdControl2_ShowMenu_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_Resume_Proxy alias "IDvdControl2_Resume_Proxy" (byval This as IDvdControl2 ptr, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_Resume_Stub alias "IDvdControl2_Resume_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SelectRelativeButton_Proxy alias "IDvdControl2_SelectRelativeButton_Proxy" (byval This as IDvdControl2 ptr, byval buttonDir as DVD_RELATIVE_BUTTON) as HRESULT
declare sub IDvdControl2_SelectRelativeButton_Stub alias "IDvdControl2_SelectRelativeButton_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_ActivateButton_Proxy alias "IDvdControl2_ActivateButton_Proxy" (byval This as IDvdControl2 ptr) as HRESULT
declare sub IDvdControl2_ActivateButton_Stub alias "IDvdControl2_ActivateButton_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SelectButton_Proxy alias "IDvdControl2_SelectButton_Proxy" (byval This as IDvdControl2 ptr, byval ulButton as ULONG) as HRESULT
declare sub IDvdControl2_SelectButton_Stub alias "IDvdControl2_SelectButton_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SelectAndActivateButton_Proxy alias "IDvdControl2_SelectAndActivateButton_Proxy" (byval This as IDvdControl2 ptr, byval ulButton as ULONG) as HRESULT
declare sub IDvdControl2_SelectAndActivateButton_Stub alias "IDvdControl2_SelectAndActivateButton_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_StillOff_Proxy alias "IDvdControl2_StillOff_Proxy" (byval This as IDvdControl2 ptr) as HRESULT
declare sub IDvdControl2_StillOff_Stub alias "IDvdControl2_StillOff_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_Pause_Proxy alias "IDvdControl2_Pause_Proxy" (byval This as IDvdControl2 ptr, byval bState as BOOL) as HRESULT
declare sub IDvdControl2_Pause_Stub alias "IDvdControl2_Pause_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SelectAudioStream_Proxy alias "IDvdControl2_SelectAudioStream_Proxy" (byval This as IDvdControl2 ptr, byval ulAudio as ULONG, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_SelectAudioStream_Stub alias "IDvdControl2_SelectAudioStream_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SelectSubpictureStream_Proxy alias "IDvdControl2_SelectSubpictureStream_Proxy" (byval This as IDvdControl2 ptr, byval ulSubPicture as ULONG, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_SelectSubpictureStream_Stub alias "IDvdControl2_SelectSubpictureStream_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SetSubpictureState_Proxy alias "IDvdControl2_SetSubpictureState_Proxy" (byval This as IDvdControl2 ptr, byval bState as BOOL, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_SetSubpictureState_Stub alias "IDvdControl2_SetSubpictureState_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SelectAngle_Proxy alias "IDvdControl2_SelectAngle_Proxy" (byval This as IDvdControl2 ptr, byval ulAngle as ULONG, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_SelectAngle_Stub alias "IDvdControl2_SelectAngle_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SelectParentalLevel_Proxy alias "IDvdControl2_SelectParentalLevel_Proxy" (byval This as IDvdControl2 ptr, byval ulParentalLevel as ULONG) as HRESULT
declare sub IDvdControl2_SelectParentalLevel_Stub alias "IDvdControl2_SelectParentalLevel_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SelectParentalCountry_Proxy alias "IDvdControl2_SelectParentalCountry_Proxy" (byval This as IDvdControl2 ptr, byval bCountry as BYTE ptr) as HRESULT
declare sub IDvdControl2_SelectParentalCountry_Stub alias "IDvdControl2_SelectParentalCountry_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SelectKaraokeAudioPresentationMode_Proxy alias "IDvdControl2_SelectKaraokeAudioPresentationMode_Proxy" (byval This as IDvdControl2 ptr, byval ulMode as ULONG) as HRESULT
declare sub IDvdControl2_SelectKaraokeAudioPresentationMode_Stub alias "IDvdControl2_SelectKaraokeAudioPresentationMode_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SelectVideoModePreference_Proxy alias "IDvdControl2_SelectVideoModePreference_Proxy" (byval This as IDvdControl2 ptr, byval ulPreferredDisplayMode as ULONG) as HRESULT
declare sub IDvdControl2_SelectVideoModePreference_Stub alias "IDvdControl2_SelectVideoModePreference_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SetDVDDirectory_Proxy alias "IDvdControl2_SetDVDDirectory_Proxy" (byval This as IDvdControl2 ptr, byval pszwPath as LPCWSTR) as HRESULT
declare sub IDvdControl2_SetDVDDirectory_Stub alias "IDvdControl2_SetDVDDirectory_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_ActivateAtPosition_Proxy alias "IDvdControl2_ActivateAtPosition_Proxy" (byval This as IDvdControl2 ptr, byval point as POINT) as HRESULT
declare sub IDvdControl2_ActivateAtPosition_Stub alias "IDvdControl2_ActivateAtPosition_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SelectAtPosition_Proxy alias "IDvdControl2_SelectAtPosition_Proxy" (byval This as IDvdControl2 ptr, byval point as POINT) as HRESULT
declare sub IDvdControl2_SelectAtPosition_Stub alias "IDvdControl2_SelectAtPosition_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_PlayChaptersAutoStop_Proxy alias "IDvdControl2_PlayChaptersAutoStop_Proxy" (byval This as IDvdControl2 ptr, byval ulTitle as ULONG, byval ulChapter as ULONG, byval ulChaptersToPlay as ULONG, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_PlayChaptersAutoStop_Stub alias "IDvdControl2_PlayChaptersAutoStop_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_AcceptParentalLevelChange_Proxy alias "IDvdControl2_AcceptParentalLevelChange_Proxy" (byval This as IDvdControl2 ptr, byval bAccept as BOOL) as HRESULT
declare sub IDvdControl2_AcceptParentalLevelChange_Stub alias "IDvdControl2_AcceptParentalLevelChange_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SetOption_Proxy alias "IDvdControl2_SetOption_Proxy" (byval This as IDvdControl2 ptr, byval flag as DVD_OPTION_FLAG, byval fState as BOOL) as HRESULT
declare sub IDvdControl2_SetOption_Stub alias "IDvdControl2_SetOption_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SetState_Proxy alias "IDvdControl2_SetState_Proxy" (byval This as IDvdControl2 ptr, byval pState as IDvdState ptr, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_SetState_Stub alias "IDvdControl2_SetState_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_PlayPeriodInTitleAutoStop_Proxy alias "IDvdControl2_PlayPeriodInTitleAutoStop_Proxy" (byval This as IDvdControl2 ptr, byval ulTitle as ULONG, byval pStartTime as DVD_HMSF_TIMECODE ptr, byval pEndTime as DVD_HMSF_TIMECODE ptr, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_PlayPeriodInTitleAutoStop_Stub alias "IDvdControl2_PlayPeriodInTitleAutoStop_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SetGPRM_Proxy alias "IDvdControl2_SetGPRM_Proxy" (byval This as IDvdControl2 ptr, byval ulIndex as ULONG, byval wValue as WORD, byval dwFlags as DWORD, byval ppCmd as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdControl2_SetGPRM_Stub alias "IDvdControl2_SetGPRM_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SelectDefaultMenuLanguage_Proxy alias "IDvdControl2_SelectDefaultMenuLanguage_Proxy" (byval This as IDvdControl2 ptr, byval Language as LCID) as HRESULT
declare sub IDvdControl2_SelectDefaultMenuLanguage_Stub alias "IDvdControl2_SelectDefaultMenuLanguage_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SelectDefaultAudioLanguage_Proxy alias "IDvdControl2_SelectDefaultAudioLanguage_Proxy" (byval This as IDvdControl2 ptr, byval Language as LCID, byval audioExtension as DVD_AUDIO_LANG_EXT) as HRESULT
declare sub IDvdControl2_SelectDefaultAudioLanguage_Stub alias "IDvdControl2_SelectDefaultAudioLanguage_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdControl2_SelectDefaultSubpictureLanguage_Proxy alias "IDvdControl2_SelectDefaultSubpictureLanguage_Proxy" (byval This as IDvdControl2 ptr, byval Language as LCID, byval subpictureExtension as DVD_SUBPICTURE_LANG_EXT) as HRESULT
declare sub IDvdControl2_SelectDefaultSubpictureLanguage_Stub alias "IDvdControl2_SelectDefaultSubpictureLanguage_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

enum DVD_TextStringType
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

enum DVD_TextCharSet
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

type DVD_DECODER_CAPS
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

#define DVD_AUDIO_CAPS_AC3 &h00000001
#define DVD_AUDIO_CAPS_MPEG2 &h00000002
#define DVD_AUDIO_CAPS_LPCM &h00000004
#define DVD_AUDIO_CAPS_DTS &h00000008
#define DVD_AUDIO_CAPS_SDDS &h00000010
extern IID_IDvdInfo2 alias "IID_IDvdInfo2" as IID

type IDvdInfo2Vtbl_ as IDvdInfo2Vtbl

type IDvdInfo2
	lpVtbl as IDvdInfo2Vtbl_ ptr
end type

type IDvdInfo2Vtbl
	QueryInterface as function(byval as IDvdInfo2 ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IDvdInfo2 ptr) as ULONG
	Release as function(byval as IDvdInfo2 ptr) as ULONG
	GetCurrentDomain as function(byval as IDvdInfo2 ptr, byval as DVD_DOMAIN ptr) as HRESULT
	GetCurrentLocation as function(byval as IDvdInfo2 ptr, byval as DVD_PLAYBACK_LOCATION2 ptr) as HRESULT
	GetTotalTitleTime as function(byval as IDvdInfo2 ptr, byval as DVD_HMSF_TIMECODE ptr, byval as ULONG ptr) as HRESULT
	GetCurrentButton as function(byval as IDvdInfo2 ptr, byval as ULONG ptr, byval as ULONG ptr) as HRESULT
	GetCurrentAngle as function(byval as IDvdInfo2 ptr, byval as ULONG ptr, byval as ULONG ptr) as HRESULT
	GetCurrentAudio as function(byval as IDvdInfo2 ptr, byval as ULONG ptr, byval as ULONG ptr) as HRESULT
	GetCurrentSubpicture as function(byval as IDvdInfo2 ptr, byval as ULONG ptr, byval as ULONG ptr, byval as BOOL ptr) as HRESULT
	GetCurrentUOPS as function(byval as IDvdInfo2 ptr, byval as ULONG ptr) as HRESULT
	GetAllSPRMs as function(byval as IDvdInfo2 ptr, byval as SPRMARRAY ptr) as HRESULT
	GetAllGPRMs as function(byval as IDvdInfo2 ptr, byval as GPRMARRAY ptr) as HRESULT
	GetAudioLanguage as function(byval as IDvdInfo2 ptr, byval as ULONG, byval as LCID ptr) as HRESULT
	GetSubpictureLanguage as function(byval as IDvdInfo2 ptr, byval as ULONG, byval as LCID ptr) as HRESULT
	GetTitleAttributes as function(byval as IDvdInfo2 ptr, byval as ULONG, byval as DVD_MenuAttributes ptr, byval as DVD_TitleAttributes ptr) as HRESULT
	GetVMGAttributes as function(byval as IDvdInfo2 ptr, byval as DVD_MenuAttributes ptr) as HRESULT
	GetCurrentVideoAttributes as function(byval as IDvdInfo2 ptr, byval as DVD_VideoAttributes ptr) as HRESULT
	GetAudioAttributes as function(byval as IDvdInfo2 ptr, byval as ULONG, byval as DVD_AudioAttributes ptr) as HRESULT
	GetKaraokeAttributes as function(byval as IDvdInfo2 ptr, byval as ULONG, byval as DVD_KaraokeAttributes ptr) as HRESULT
	GetSubpictureAttributes as function(byval as IDvdInfo2 ptr, byval as ULONG, byval as DVD_SubpictureAttributes ptr) as HRESULT
	GetDVDVolumeInfo as function(byval as IDvdInfo2 ptr, byval as ULONG ptr, byval as ULONG ptr, byval as DVD_DISC_SIDE ptr, byval as ULONG ptr) as HRESULT
	GetDVDTextNumberOfLanguages as function(byval as IDvdInfo2 ptr, byval as ULONG ptr) as HRESULT
	GetDVDTextLanguageInfo as function(byval as IDvdInfo2 ptr, byval as ULONG, byval as ULONG ptr, byval as LCID ptr, byval as DVD_TextCharSet ptr) as HRESULT
	GetDVDTextStringAsNative as function(byval as IDvdInfo2 ptr, byval as ULONG, byval as ULONG, byval as BYTE ptr, byval as ULONG, byval as ULONG ptr, byval as DVD_TextStringType ptr) as HRESULT
	GetDVDTextStringAsUnicode as function(byval as IDvdInfo2 ptr, byval as ULONG, byval as ULONG, byval as WCHAR ptr, byval as ULONG, byval as ULONG ptr, byval as DVD_TextStringType ptr) as HRESULT
	GetPlayerParentalLevel as function(byval as IDvdInfo2 ptr, byval as ULONG ptr, byval as BYTE ptr) as HRESULT
	GetNumberOfChapters as function(byval as IDvdInfo2 ptr, byval as ULONG, byval as ULONG ptr) as HRESULT
	GetTitleParentalLevels as function(byval as IDvdInfo2 ptr, byval as ULONG, byval as ULONG ptr) as HRESULT
	GetDVDDirectory as function(byval as IDvdInfo2 ptr, byval as LPWSTR, byval as ULONG, byval as ULONG ptr) as HRESULT
	IsAudioStreamEnabled as function(byval as IDvdInfo2 ptr, byval as ULONG, byval as BOOL ptr) as HRESULT
	GetDiscID as function(byval as IDvdInfo2 ptr, byval as LPCWSTR, byval as ULONGLONG ptr) as HRESULT
	GetState as function(byval as IDvdInfo2 ptr, byval as IDvdState ptr ptr) as HRESULT
	GetMenuLanguages as function(byval as IDvdInfo2 ptr, byval as LCID ptr, byval as ULONG, byval as ULONG ptr) as HRESULT
	GetButtonAtPosition as function(byval as IDvdInfo2 ptr, byval as POINT, byval as ULONG ptr) as HRESULT
	GetCmdFromEvent as function(byval as IDvdInfo2 ptr, byval as LONG_PTR, byval as IDvdCmd ptr ptr) as HRESULT
	GetDefaultMenuLanguage as function(byval as IDvdInfo2 ptr, byval as LCID ptr) as HRESULT
	GetDefaultAudioLanguage as function(byval as IDvdInfo2 ptr, byval as LCID ptr, byval as DVD_AUDIO_LANG_EXT ptr) as HRESULT
	GetDefaultSubpictureLanguage as function(byval as IDvdInfo2 ptr, byval as LCID ptr, byval as DVD_SUBPICTURE_LANG_EXT ptr) as HRESULT
	GetDecoderCaps as function(byval as IDvdInfo2 ptr, byval as DVD_DECODER_CAPS ptr) as HRESULT
	GetButtonRect as function(byval as IDvdInfo2 ptr, byval as ULONG, byval as RECT ptr) as HRESULT
	IsSubpictureStreamEnabled as function(byval as IDvdInfo2 ptr, byval as ULONG, byval as BOOL ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IDvdInfo2_GetCurrentDomain_Proxy alias "IDvdInfo2_GetCurrentDomain_Proxy" (byval This as IDvdInfo2 ptr, byval pDomain as DVD_DOMAIN ptr) as HRESULT
declare sub IDvdInfo2_GetCurrentDomain_Stub alias "IDvdInfo2_GetCurrentDomain_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetCurrentLocation_Proxy alias "IDvdInfo2_GetCurrentLocation_Proxy" (byval This as IDvdInfo2 ptr, byval pLocation as DVD_PLAYBACK_LOCATION2 ptr) as HRESULT
declare sub IDvdInfo2_GetCurrentLocation_Stub alias "IDvdInfo2_GetCurrentLocation_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetTotalTitleTime_Proxy alias "IDvdInfo2_GetTotalTitleTime_Proxy" (byval This as IDvdInfo2 ptr, byval pTotalTime as DVD_HMSF_TIMECODE ptr, byval ulTimeCodeFlags as ULONG ptr) as HRESULT
declare sub IDvdInfo2_GetTotalTitleTime_Stub alias "IDvdInfo2_GetTotalTitleTime_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetCurrentButton_Proxy alias "IDvdInfo2_GetCurrentButton_Proxy" (byval This as IDvdInfo2 ptr, byval pulButtonsAvailable as ULONG ptr, byval pulCurrentButton as ULONG ptr) as HRESULT
declare sub IDvdInfo2_GetCurrentButton_Stub alias "IDvdInfo2_GetCurrentButton_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetCurrentAngle_Proxy alias "IDvdInfo2_GetCurrentAngle_Proxy" (byval This as IDvdInfo2 ptr, byval pulAnglesAvailable as ULONG ptr, byval pulCurrentAngle as ULONG ptr) as HRESULT
declare sub IDvdInfo2_GetCurrentAngle_Stub alias "IDvdInfo2_GetCurrentAngle_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetCurrentAudio_Proxy alias "IDvdInfo2_GetCurrentAudio_Proxy" (byval This as IDvdInfo2 ptr, byval pulStreamsAvailable as ULONG ptr, byval pulCurrentStream as ULONG ptr) as HRESULT
declare sub IDvdInfo2_GetCurrentAudio_Stub alias "IDvdInfo2_GetCurrentAudio_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetCurrentSubpicture_Proxy alias "IDvdInfo2_GetCurrentSubpicture_Proxy" (byval This as IDvdInfo2 ptr, byval pulStreamsAvailable as ULONG ptr, byval pulCurrentStream as ULONG ptr, byval pbIsDisabled as BOOL ptr) as HRESULT
declare sub IDvdInfo2_GetCurrentSubpicture_Stub alias "IDvdInfo2_GetCurrentSubpicture_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetCurrentUOPS_Proxy alias "IDvdInfo2_GetCurrentUOPS_Proxy" (byval This as IDvdInfo2 ptr, byval pulUOPs as ULONG ptr) as HRESULT
declare sub IDvdInfo2_GetCurrentUOPS_Stub alias "IDvdInfo2_GetCurrentUOPS_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetAllSPRMs_Proxy alias "IDvdInfo2_GetAllSPRMs_Proxy" (byval This as IDvdInfo2 ptr, byval pRegisterArray as SPRMARRAY ptr) as HRESULT
declare sub IDvdInfo2_GetAllSPRMs_Stub alias "IDvdInfo2_GetAllSPRMs_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetAllGPRMs_Proxy alias "IDvdInfo2_GetAllGPRMs_Proxy" (byval This as IDvdInfo2 ptr, byval pRegisterArray as GPRMARRAY ptr) as HRESULT
declare sub IDvdInfo2_GetAllGPRMs_Stub alias "IDvdInfo2_GetAllGPRMs_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetAudioLanguage_Proxy alias "IDvdInfo2_GetAudioLanguage_Proxy" (byval This as IDvdInfo2 ptr, byval ulStream as ULONG, byval pLanguage as LCID ptr) as HRESULT
declare sub IDvdInfo2_GetAudioLanguage_Stub alias "IDvdInfo2_GetAudioLanguage_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetSubpictureLanguage_Proxy alias "IDvdInfo2_GetSubpictureLanguage_Proxy" (byval This as IDvdInfo2 ptr, byval ulStream as ULONG, byval pLanguage as LCID ptr) as HRESULT
declare sub IDvdInfo2_GetSubpictureLanguage_Stub alias "IDvdInfo2_GetSubpictureLanguage_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetTitleAttributes_Proxy alias "IDvdInfo2_GetTitleAttributes_Proxy" (byval This as IDvdInfo2 ptr, byval ulTitle as ULONG, byval pMenu as DVD_MenuAttributes ptr, byval pTitle as DVD_TitleAttributes ptr) as HRESULT
declare sub IDvdInfo2_GetTitleAttributes_Stub alias "IDvdInfo2_GetTitleAttributes_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetVMGAttributes_Proxy alias "IDvdInfo2_GetVMGAttributes_Proxy" (byval This as IDvdInfo2 ptr, byval pATR as DVD_MenuAttributes ptr) as HRESULT
declare sub IDvdInfo2_GetVMGAttributes_Stub alias "IDvdInfo2_GetVMGAttributes_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetCurrentVideoAttributes_Proxy alias "IDvdInfo2_GetCurrentVideoAttributes_Proxy" (byval This as IDvdInfo2 ptr, byval pATR as DVD_VideoAttributes ptr) as HRESULT
declare sub IDvdInfo2_GetCurrentVideoAttributes_Stub alias "IDvdInfo2_GetCurrentVideoAttributes_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetAudioAttributes_Proxy alias "IDvdInfo2_GetAudioAttributes_Proxy" (byval This as IDvdInfo2 ptr, byval ulStream as ULONG, byval pATR as DVD_AudioAttributes ptr) as HRESULT
declare sub IDvdInfo2_GetAudioAttributes_Stub alias "IDvdInfo2_GetAudioAttributes_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetKaraokeAttributes_Proxy alias "IDvdInfo2_GetKaraokeAttributes_Proxy" (byval This as IDvdInfo2 ptr, byval ulStream as ULONG, byval pAttributes as DVD_KaraokeAttributes ptr) as HRESULT
declare sub IDvdInfo2_GetKaraokeAttributes_Stub alias "IDvdInfo2_GetKaraokeAttributes_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetSubpictureAttributes_Proxy alias "IDvdInfo2_GetSubpictureAttributes_Proxy" (byval This as IDvdInfo2 ptr, byval ulStream as ULONG, byval pATR as DVD_SubpictureAttributes ptr) as HRESULT
declare sub IDvdInfo2_GetSubpictureAttributes_Stub alias "IDvdInfo2_GetSubpictureAttributes_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetDVDVolumeInfo_Proxy alias "IDvdInfo2_GetDVDVolumeInfo_Proxy" (byval This as IDvdInfo2 ptr, byval pulNumOfVolumes as ULONG ptr, byval pulVolume as ULONG ptr, byval pSide as DVD_DISC_SIDE ptr, byval pulNumOfTitles as ULONG ptr) as HRESULT
declare sub IDvdInfo2_GetDVDVolumeInfo_Stub alias "IDvdInfo2_GetDVDVolumeInfo_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetDVDTextNumberOfLanguages_Proxy alias "IDvdInfo2_GetDVDTextNumberOfLanguages_Proxy" (byval This as IDvdInfo2 ptr, byval pulNumOfLangs as ULONG ptr) as HRESULT
declare sub IDvdInfo2_GetDVDTextNumberOfLanguages_Stub alias "IDvdInfo2_GetDVDTextNumberOfLanguages_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetDVDTextLanguageInfo_Proxy alias "IDvdInfo2_GetDVDTextLanguageInfo_Proxy" (byval This as IDvdInfo2 ptr, byval ulLangIndex as ULONG, byval pulNumOfStrings as ULONG ptr, byval pLangCode as LCID ptr, byval pbCharacterSet as DVD_TextCharSet ptr) as HRESULT
declare sub IDvdInfo2_GetDVDTextLanguageInfo_Stub alias "IDvdInfo2_GetDVDTextLanguageInfo_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetDVDTextStringAsNative_Proxy alias "IDvdInfo2_GetDVDTextStringAsNative_Proxy" (byval This as IDvdInfo2 ptr, byval ulLangIndex as ULONG, byval ulStringIndex as ULONG, byval pbBuffer as BYTE ptr, byval ulMaxBufferSize as ULONG, byval pulActualSize as ULONG ptr, byval pType as DVD_TextStringType ptr) as HRESULT
declare sub IDvdInfo2_GetDVDTextStringAsNative_Stub alias "IDvdInfo2_GetDVDTextStringAsNative_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetDVDTextStringAsUnicode_Proxy alias "IDvdInfo2_GetDVDTextStringAsUnicode_Proxy" (byval This as IDvdInfo2 ptr, byval ulLangIndex as ULONG, byval ulStringIndex as ULONG, byval pchwBuffer as WCHAR ptr, byval ulMaxBufferSize as ULONG, byval pulActualSize as ULONG ptr, byval pType as DVD_TextStringType ptr) as HRESULT
declare sub IDvdInfo2_GetDVDTextStringAsUnicode_Stub alias "IDvdInfo2_GetDVDTextStringAsUnicode_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetPlayerParentalLevel_Proxy alias "IDvdInfo2_GetPlayerParentalLevel_Proxy" (byval This as IDvdInfo2 ptr, byval pulParentalLevel as ULONG ptr, byval pbCountryCode as BYTE ptr) as HRESULT
declare sub IDvdInfo2_GetPlayerParentalLevel_Stub alias "IDvdInfo2_GetPlayerParentalLevel_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetNumberOfChapters_Proxy alias "IDvdInfo2_GetNumberOfChapters_Proxy" (byval This as IDvdInfo2 ptr, byval ulTitle as ULONG, byval pulNumOfChapters as ULONG ptr) as HRESULT
declare sub IDvdInfo2_GetNumberOfChapters_Stub alias "IDvdInfo2_GetNumberOfChapters_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetTitleParentalLevels_Proxy alias "IDvdInfo2_GetTitleParentalLevels_Proxy" (byval This as IDvdInfo2 ptr, byval ulTitle as ULONG, byval pulParentalLevels as ULONG ptr) as HRESULT
declare sub IDvdInfo2_GetTitleParentalLevels_Stub alias "IDvdInfo2_GetTitleParentalLevels_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetDVDDirectory_Proxy alias "IDvdInfo2_GetDVDDirectory_Proxy" (byval This as IDvdInfo2 ptr, byval pszwPath as LPWSTR, byval ulMaxSize as ULONG, byval pulActualSize as ULONG ptr) as HRESULT
declare sub IDvdInfo2_GetDVDDirectory_Stub alias "IDvdInfo2_GetDVDDirectory_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_IsAudioStreamEnabled_Proxy alias "IDvdInfo2_IsAudioStreamEnabled_Proxy" (byval This as IDvdInfo2 ptr, byval ulStreamNum as ULONG, byval pbEnabled as BOOL ptr) as HRESULT
declare sub IDvdInfo2_IsAudioStreamEnabled_Stub alias "IDvdInfo2_IsAudioStreamEnabled_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetDiscID_Proxy alias "IDvdInfo2_GetDiscID_Proxy" (byval This as IDvdInfo2 ptr, byval pszwPath as LPCWSTR, byval pullDiscID as ULONGLONG ptr) as HRESULT
declare sub IDvdInfo2_GetDiscID_Stub alias "IDvdInfo2_GetDiscID_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetState_Proxy alias "IDvdInfo2_GetState_Proxy" (byval This as IDvdInfo2 ptr, byval pStateData as IDvdState ptr ptr) as HRESULT
declare sub IDvdInfo2_GetState_Stub alias "IDvdInfo2_GetState_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetMenuLanguages_Proxy alias "IDvdInfo2_GetMenuLanguages_Proxy" (byval This as IDvdInfo2 ptr, byval pLanguages as LCID ptr, byval ulMaxLanguages as ULONG, byval pulActualLanguages as ULONG ptr) as HRESULT
declare sub IDvdInfo2_GetMenuLanguages_Stub alias "IDvdInfo2_GetMenuLanguages_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetButtonAtPosition_Proxy alias "IDvdInfo2_GetButtonAtPosition_Proxy" (byval This as IDvdInfo2 ptr, byval point as POINT, byval pulButtonIndex as ULONG ptr) as HRESULT
declare sub IDvdInfo2_GetButtonAtPosition_Stub alias "IDvdInfo2_GetButtonAtPosition_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetCmdFromEvent_Proxy alias "IDvdInfo2_GetCmdFromEvent_Proxy" (byval This as IDvdInfo2 ptr, byval lParam1 as LONG_PTR, byval pCmdObj as IDvdCmd ptr ptr) as HRESULT
declare sub IDvdInfo2_GetCmdFromEvent_Stub alias "IDvdInfo2_GetCmdFromEvent_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetDefaultMenuLanguage_Proxy alias "IDvdInfo2_GetDefaultMenuLanguage_Proxy" (byval This as IDvdInfo2 ptr, byval pLanguage as LCID ptr) as HRESULT
declare sub IDvdInfo2_GetDefaultMenuLanguage_Stub alias "IDvdInfo2_GetDefaultMenuLanguage_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetDefaultAudioLanguage_Proxy alias "IDvdInfo2_GetDefaultAudioLanguage_Proxy" (byval This as IDvdInfo2 ptr, byval pLanguage as LCID ptr, byval pAudioExtension as DVD_AUDIO_LANG_EXT ptr) as HRESULT
declare sub IDvdInfo2_GetDefaultAudioLanguage_Stub alias "IDvdInfo2_GetDefaultAudioLanguage_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetDefaultSubpictureLanguage_Proxy alias "IDvdInfo2_GetDefaultSubpictureLanguage_Proxy" (byval This as IDvdInfo2 ptr, byval pLanguage as LCID ptr, byval pSubpictureExtension as DVD_SUBPICTURE_LANG_EXT ptr) as HRESULT
declare sub IDvdInfo2_GetDefaultSubpictureLanguage_Stub alias "IDvdInfo2_GetDefaultSubpictureLanguage_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetDecoderCaps_Proxy alias "IDvdInfo2_GetDecoderCaps_Proxy" (byval This as IDvdInfo2 ptr, byval pCaps as DVD_DECODER_CAPS ptr) as HRESULT
declare sub IDvdInfo2_GetDecoderCaps_Stub alias "IDvdInfo2_GetDecoderCaps_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_GetButtonRect_Proxy alias "IDvdInfo2_GetButtonRect_Proxy" (byval This as IDvdInfo2 ptr, byval ulButton as ULONG, byval pRect as RECT ptr) as HRESULT
declare sub IDvdInfo2_GetButtonRect_Stub alias "IDvdInfo2_GetButtonRect_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdInfo2_IsSubpictureStreamEnabled_Proxy alias "IDvdInfo2_IsSubpictureStreamEnabled_Proxy" (byval This as IDvdInfo2 ptr, byval ulStreamNum as ULONG, byval pbEnabled as BOOL ptr) as HRESULT
declare sub IDvdInfo2_IsSubpictureStreamEnabled_Stub alias "IDvdInfo2_IsSubpictureStreamEnabled_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

enum AM_DVD_GRAPH_FLAGS
	AM_DVD_HWDEC_PREFER = &h1
	AM_DVD_HWDEC_ONLY = &h2
	AM_DVD_SWDEC_PREFER = &h4
	AM_DVD_SWDEC_ONLY = &h8
	AM_DVD_NOVPE = &h100
	AM_DVD_VMR9_ONLY = &h800
end enum

enum AM_DVD_STREAM_FLAGS
	AM_DVD_STREAM_VIDEO = &h1
	AM_DVD_STREAM_AUDIO = &h2
	AM_DVD_STREAM_SUBPIC = &h4
end enum

type AM_DVD_RENDERSTATUS
	hrVPEStatus as HRESULT
	bDvdVolInvalid as BOOL
	bDvdVolUnknown as BOOL
	bNoLine21In as BOOL
	bNoLine21Out as BOOL
	iNumStreams as integer
	iNumStreamsFailed as integer
	dwFailedStreamsFlag as DWORD
end type

extern IID_IDvdGraphBuilder alias "IID_IDvdGraphBuilder" as IID

type IDvdGraphBuilderVtbl_ as IDvdGraphBuilderVtbl

type IDvdGraphBuilder
	lpVtbl as IDvdGraphBuilderVtbl_ ptr
end type

type IDvdGraphBuilderVtbl
	QueryInterface as function(byval as IDvdGraphBuilder ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IDvdGraphBuilder ptr) as ULONG
	Release as function(byval as IDvdGraphBuilder ptr) as ULONG
	GetFiltergraph as function(byval as IDvdGraphBuilder ptr, byval as IGraphBuilder ptr ptr) as HRESULT
	GetDvdInterface as function(byval as IDvdGraphBuilder ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	RenderDvdVideoVolume as function(byval as IDvdGraphBuilder ptr, byval as LPCWSTR, byval as DWORD, byval as AM_DVD_RENDERSTATUS ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IDvdGraphBuilder_GetFiltergraph_Proxy alias "IDvdGraphBuilder_GetFiltergraph_Proxy" (byval This as IDvdGraphBuilder ptr, byval ppGB as IGraphBuilder ptr ptr) as HRESULT
declare sub IDvdGraphBuilder_GetFiltergraph_Stub alias "IDvdGraphBuilder_GetFiltergraph_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdGraphBuilder_GetDvdInterface_Proxy alias "IDvdGraphBuilder_GetDvdInterface_Proxy" (byval This as IDvdGraphBuilder ptr, byval riid as IID ptr, byval ppvIF as any ptr ptr) as HRESULT
declare sub IDvdGraphBuilder_GetDvdInterface_Stub alias "IDvdGraphBuilder_GetDvdInterface_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDvdGraphBuilder_RenderDvdVideoVolume_Proxy alias "IDvdGraphBuilder_RenderDvdVideoVolume_Proxy" (byval This as IDvdGraphBuilder ptr, byval lpcwszPathName as LPCWSTR, byval dwFlags as DWORD, byval pStatus as AM_DVD_RENDERSTATUS ptr) as HRESULT
declare sub IDvdGraphBuilder_RenderDvdVideoVolume_Stub alias "IDvdGraphBuilder_RenderDvdVideoVolume_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IDDrawExclModeVideo alias "IID_IDDrawExclModeVideo" as IID

type IDDrawExclModeVideoVtbl_ as IDDrawExclModeVideoVtbl

type IDDrawExclModeVideo
	lpVtbl as IDDrawExclModeVideoVtbl_ ptr
end type

type IDDrawExclModeVideoVtbl
	QueryInterface as function(byval as IDDrawExclModeVideo ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IDDrawExclModeVideo ptr) as ULONG
	Release as function(byval as IDDrawExclModeVideo ptr) as ULONG
	SetDDrawObject as function(byval as IDDrawExclModeVideo ptr, byval as IDirectDraw ptr) as HRESULT
	GetDDrawObject as function(byval as IDDrawExclModeVideo ptr, byval as IDirectDraw ptr ptr, byval as BOOL ptr) as HRESULT
	SetDDrawSurface as function(byval as IDDrawExclModeVideo ptr, byval as IDirectDrawSurface ptr) as HRESULT
	GetDDrawSurface as function(byval as IDDrawExclModeVideo ptr, byval as IDirectDrawSurface ptr ptr, byval as BOOL ptr) as HRESULT
	SetDrawParameters as function(byval as IDDrawExclModeVideo ptr, byval as RECT ptr, byval as RECT ptr) as HRESULT
	GetNativeVideoProps as function(byval as IDDrawExclModeVideo ptr, byval as DWORD ptr, byval as DWORD ptr, byval as DWORD ptr, byval as DWORD ptr) as HRESULT
	SetCallbackInterface as function(byval as IDDrawExclModeVideo ptr, byval as IDDrawExclModeVideoCallback_ ptr, byval as DWORD) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IDDrawExclModeVideo_SetDDrawObject_Proxy alias "IDDrawExclModeVideo_SetDDrawObject_Proxy" (byval This as IDDrawExclModeVideo ptr, byval pDDrawObject as IDirectDraw ptr) as HRESULT
declare sub IDDrawExclModeVideo_SetDDrawObject_Stub alias "IDDrawExclModeVideo_SetDDrawObject_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDDrawExclModeVideo_GetDDrawObject_Proxy alias "IDDrawExclModeVideo_GetDDrawObject_Proxy" (byval This as IDDrawExclModeVideo ptr, byval ppDDrawObject as IDirectDraw ptr ptr, byval pbUsingExternal as BOOL ptr) as HRESULT
declare sub IDDrawExclModeVideo_GetDDrawObject_Stub alias "IDDrawExclModeVideo_GetDDrawObject_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDDrawExclModeVideo_SetDDrawSurface_Proxy alias "IDDrawExclModeVideo_SetDDrawSurface_Proxy" (byval This as IDDrawExclModeVideo ptr, byval pDDrawSurface as IDirectDrawSurface ptr) as HRESULT
declare sub IDDrawExclModeVideo_SetDDrawSurface_Stub alias "IDDrawExclModeVideo_SetDDrawSurface_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDDrawExclModeVideo_GetDDrawSurface_Proxy alias "IDDrawExclModeVideo_GetDDrawSurface_Proxy" (byval This as IDDrawExclModeVideo ptr, byval ppDDrawSurface as IDirectDrawSurface ptr ptr, byval pbUsingExternal as BOOL ptr) as HRESULT
declare sub IDDrawExclModeVideo_GetDDrawSurface_Stub alias "IDDrawExclModeVideo_GetDDrawSurface_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDDrawExclModeVideo_SetDrawParameters_Proxy alias "IDDrawExclModeVideo_SetDrawParameters_Proxy" (byval This as IDDrawExclModeVideo ptr, byval prcSource as RECT ptr, byval prcTarget as RECT ptr) as HRESULT
declare sub IDDrawExclModeVideo_SetDrawParameters_Stub alias "IDDrawExclModeVideo_SetDrawParameters_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDDrawExclModeVideo_GetNativeVideoProps_Proxy alias "IDDrawExclModeVideo_GetNativeVideoProps_Proxy" (byval This as IDDrawExclModeVideo ptr, byval pdwVideoWidth as DWORD ptr, byval pdwVideoHeight as DWORD ptr, byval pdwPictAspectRatioX as DWORD ptr, byval pdwPictAspectRatioY as DWORD ptr) as HRESULT
declare sub IDDrawExclModeVideo_GetNativeVideoProps_Stub alias "IDDrawExclModeVideo_GetNativeVideoProps_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDDrawExclModeVideo_SetCallbackInterface_Proxy alias "IDDrawExclModeVideo_SetCallbackInterface_Proxy" (byval This as IDDrawExclModeVideo ptr, byval pCallback as IDDrawExclModeVideoCallback ptr, byval dwFlags as DWORD) as HRESULT
declare sub IDDrawExclModeVideo_SetCallbackInterface_Stub alias "IDDrawExclModeVideo_SetCallbackInterface_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

enum AM_OVERLAY_NOTIFY_FLAGS
	AM_OVERLAY_NOTIFY_VISIBLE_CHANGE = &h1
	AM_OVERLAY_NOTIFY_SOURCE_CHANGE = &h2
	AM_OVERLAY_NOTIFY_DEST_CHANGE = &h4
end enum
extern IID_IDDrawExclModeVideoCallback alias "IID_IDDrawExclModeVideoCallback" as IID

type IDDrawExclModeVideoCallbackVtbl_ as IDDrawExclModeVideoCallbackVtbl

type IDDrawExclModeVideoCallback
	lpVtbl as IDDrawExclModeVideoCallbackVtbl_ ptr
end type

type IDDrawExclModeVideoCallbackVtbl
	QueryInterface as function(byval as IDDrawExclModeVideoCallback ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IDDrawExclModeVideoCallback ptr) as ULONG
	Release as function(byval as IDDrawExclModeVideoCallback ptr) as ULONG
	OnUpdateOverlay as function(byval as IDDrawExclModeVideoCallback ptr, byval as BOOL, byval as DWORD, byval as BOOL, byval as RECT ptr, byval as RECT ptr, byval as BOOL, byval as RECT ptr, byval as RECT ptr) as HRESULT
	OnUpdateColorKey as function(byval as IDDrawExclModeVideoCallback ptr, byval as COLORKEY ptr, byval as DWORD) as HRESULT
	OnUpdateSize as function(byval as IDDrawExclModeVideoCallback ptr, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IDDrawExclModeVideoCallback_OnUpdateOverlay_Proxy alias "IDDrawExclModeVideoCallback_OnUpdateOverlay_Proxy" (byval This as IDDrawExclModeVideoCallback ptr, byval bBefore as BOOL, byval dwFlags as DWORD, byval bOldVisible as BOOL, byval prcOldSrc as RECT ptr, byval prcOldDest as RECT ptr, byval bNewVisible as BOOL, byval prcNewSrc as RECT ptr, byval prcNewDest as RECT ptr) as HRESULT
declare sub IDDrawExclModeVideoCallback_OnUpdateOverlay_Stub alias "IDDrawExclModeVideoCallback_OnUpdateOverlay_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDDrawExclModeVideoCallback_OnUpdateColorKey_Proxy alias "IDDrawExclModeVideoCallback_OnUpdateColorKey_Proxy" (byval This as IDDrawExclModeVideoCallback ptr, byval pKey as COLORKEY ptr, byval dwColor as DWORD) as HRESULT
declare sub IDDrawExclModeVideoCallback_OnUpdateColorKey_Stub alias "IDDrawExclModeVideoCallback_OnUpdateColorKey_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IDDrawExclModeVideoCallback_OnUpdateSize_Proxy alias "IDDrawExclModeVideoCallback_OnUpdateSize_Proxy" (byval This as IDDrawExclModeVideoCallback ptr, byval dwWidth as DWORD, byval dwHeight as DWORD, byval dwARWidth as DWORD, byval dwARHeight as DWORD) as HRESULT
declare sub IDDrawExclModeVideoCallback_OnUpdateSize_Stub alias "IDDrawExclModeVideoCallback_OnUpdateSize_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IPinConnection alias "IID_IPinConnection" as IID

type IPinConnectionVtbl_ as IPinConnectionVtbl

type IPinConnection
	lpVtbl as IPinConnectionVtbl_ ptr
end type

type IPinConnectionVtbl
	QueryInterface as function(byval as IPinConnection ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IPinConnection ptr) as ULONG
	Release as function(byval as IPinConnection ptr) as ULONG
	DynamicQueryAccept as function(byval as IPinConnection ptr, byval as AM_MEDIA_TYPE ptr) as HRESULT
	NotifyEndOfStream as function(byval as IPinConnection ptr, byval as HANDLE) as HRESULT
	IsEndPin as function(byval as IPinConnection ptr) as HRESULT
	DynamicDisconnect as function(byval as IPinConnection ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IPinConnection_DynamicQueryAccept_Proxy alias "IPinConnection_DynamicQueryAccept_Proxy" (byval This as IPinConnection ptr, byval pmt as AM_MEDIA_TYPE ptr) as HRESULT
declare sub IPinConnection_DynamicQueryAccept_Stub alias "IPinConnection_DynamicQueryAccept_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPinConnection_NotifyEndOfStream_Proxy alias "IPinConnection_NotifyEndOfStream_Proxy" (byval This as IPinConnection ptr, byval hNotifyEvent as HANDLE) as HRESULT
declare sub IPinConnection_NotifyEndOfStream_Stub alias "IPinConnection_NotifyEndOfStream_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPinConnection_IsEndPin_Proxy alias "IPinConnection_IsEndPin_Proxy" (byval This as IPinConnection ptr) as HRESULT
declare sub IPinConnection_IsEndPin_Stub alias "IPinConnection_IsEndPin_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IPinConnection_DynamicDisconnect_Proxy alias "IPinConnection_DynamicDisconnect_Proxy" (byval This as IPinConnection ptr) as HRESULT
declare sub IPinConnection_DynamicDisconnect_Stub alias "IPinConnection_DynamicDisconnect_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IPinFlowControl alias "IID_IPinFlowControl" as IID

type IPinFlowControlVtbl_ as IPinFlowControlVtbl

type IPinFlowControl
	lpVtbl as IPinFlowControlVtbl_ ptr
end type

type IPinFlowControlVtbl
	QueryInterface as function(byval as IPinFlowControl ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IPinFlowControl ptr) as ULONG
	Release as function(byval as IPinFlowControl ptr) as ULONG
	Block as function(byval as IPinFlowControl ptr, byval as DWORD, byval as HANDLE) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IPinFlowControl_Block_Proxy alias "IPinFlowControl_Block_Proxy" (byval This as IPinFlowControl ptr, byval dwBlockFlags as DWORD, byval hEvent as HANDLE) as HRESULT
declare sub IPinFlowControl_Block_Stub alias "IPinFlowControl_Block_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

enum AM_PIN_FLOW_CONTROL_BLOCK_FLAGS
	AM_PIN_FLOW_CONTROL_BLOCK = &h1
end enum

enum AM_GRAPH_CONFIG_RECONNECT_FLAGS
	AM_GRAPH_CONFIG_RECONNECT_DIRECTCONNECT = &h1
	AM_GRAPH_CONFIG_RECONNECT_CACHE_REMOVED_FILTERS = &h2
	AM_GRAPH_CONFIG_RECONNECT_USE_ONLY_CACHED_FILTERS = &h4
end enum

enum REM_FILTER_FLAGS
	REMFILTERF_LEAVECONNECTED = &h1
end enum

enum AM_FILTER_FLAGS
	AM_FILTER_FLAGS_REMOVABLE = &h1
end enum

extern IID_IGraphConfig alias "IID_IGraphConfig" as IID

type IGraphConfigVtbl_ as IGraphConfigVtbl

type IGraphConfig
	lpVtbl as IGraphConfigVtbl_ ptr
end type

type IGraphConfigVtbl
	QueryInterface as function(byval as IGraphConfig ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IGraphConfig ptr) as ULONG
	Release as function(byval as IGraphConfig ptr) as ULONG
	Reconnect as function(byval as IGraphConfig ptr, byval as IPin ptr, byval as IPin ptr, byval as AM_MEDIA_TYPE ptr, byval as IBaseFilter ptr, byval as HANDLE, byval as DWORD) as HRESULT
	Reconfigure as function(byval as IGraphConfig ptr, byval as IGraphConfigCallback_ ptr, byval as PVOID, byval as DWORD, byval as HANDLE) as HRESULT
	AddFilterToCache as function(byval as IGraphConfig ptr, byval as IBaseFilter ptr) as HRESULT
	EnumCacheFilter as function(byval as IGraphConfig ptr, byval as IEnumFilters ptr ptr) as HRESULT
	RemoveFilterFromCache as function(byval as IGraphConfig ptr, byval as IBaseFilter ptr) as HRESULT
	GetStartTime as function(byval as IGraphConfig ptr, byval as REFERENCE_TIME ptr) as HRESULT
	PushThroughData as function(byval as IGraphConfig ptr, byval as IPin ptr, byval as IPinConnection ptr, byval as HANDLE) as HRESULT
	SetFilterFlags as function(byval as IGraphConfig ptr, byval as IBaseFilter ptr, byval as DWORD) as HRESULT
	GetFilterFlags as function(byval as IGraphConfig ptr, byval as IBaseFilter ptr, byval as DWORD ptr) as HRESULT
	RemoveFilterEx as function(byval as IGraphConfig ptr, byval as IBaseFilter ptr, byval as DWORD) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IGraphConfig_Reconnect_Proxy alias "IGraphConfig_Reconnect_Proxy" (byval This as IGraphConfig ptr, byval pOutputPin as IPin ptr, byval pInputPin as IPin ptr, byval pmtFirstConnection as AM_MEDIA_TYPE ptr, byval pUsingFilter as IBaseFilter ptr, byval hAbortEvent as HANDLE, byval dwFlags as DWORD) as HRESULT
declare sub IGraphConfig_Reconnect_Stub alias "IGraphConfig_Reconnect_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IGraphConfig_Reconfigure_Proxy alias "IGraphConfig_Reconfigure_Proxy" (byval This as IGraphConfig ptr, byval pCallback as IGraphConfigCallback ptr, byval pvContext as PVOID, byval dwFlags as DWORD, byval hAbortEvent as HANDLE) as HRESULT
declare sub IGraphConfig_Reconfigure_Stub alias "IGraphConfig_Reconfigure_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IGraphConfig_AddFilterToCache_Proxy alias "IGraphConfig_AddFilterToCache_Proxy" (byval This as IGraphConfig ptr, byval pFilter as IBaseFilter ptr) as HRESULT
declare sub IGraphConfig_AddFilterToCache_Stub alias "IGraphConfig_AddFilterToCache_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IGraphConfig_EnumCacheFilter_Proxy alias "IGraphConfig_EnumCacheFilter_Proxy" (byval This as IGraphConfig ptr, byval pEnum as IEnumFilters ptr ptr) as HRESULT
declare sub IGraphConfig_EnumCacheFilter_Stub alias "IGraphConfig_EnumCacheFilter_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IGraphConfig_RemoveFilterFromCache_Proxy alias "IGraphConfig_RemoveFilterFromCache_Proxy" (byval This as IGraphConfig ptr, byval pFilter as IBaseFilter ptr) as HRESULT
declare sub IGraphConfig_RemoveFilterFromCache_Stub alias "IGraphConfig_RemoveFilterFromCache_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IGraphConfig_GetStartTime_Proxy alias "IGraphConfig_GetStartTime_Proxy" (byval This as IGraphConfig ptr, byval prtStart as REFERENCE_TIME ptr) as HRESULT
declare sub IGraphConfig_GetStartTime_Stub alias "IGraphConfig_GetStartTime_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IGraphConfig_PushThroughData_Proxy alias "IGraphConfig_PushThroughData_Proxy" (byval This as IGraphConfig ptr, byval pOutputPin as IPin ptr, byval pConnection as IPinConnection ptr, byval hEventAbort as HANDLE) as HRESULT
declare sub IGraphConfig_PushThroughData_Stub alias "IGraphConfig_PushThroughData_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IGraphConfig_SetFilterFlags_Proxy alias "IGraphConfig_SetFilterFlags_Proxy" (byval This as IGraphConfig ptr, byval pFilter as IBaseFilter ptr, byval dwFlags as DWORD) as HRESULT
declare sub IGraphConfig_SetFilterFlags_Stub alias "IGraphConfig_SetFilterFlags_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IGraphConfig_GetFilterFlags_Proxy alias "IGraphConfig_GetFilterFlags_Proxy" (byval This as IGraphConfig ptr, byval pFilter as IBaseFilter ptr, byval pdwFlags as DWORD ptr) as HRESULT
declare sub IGraphConfig_GetFilterFlags_Stub alias "IGraphConfig_GetFilterFlags_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IGraphConfig_RemoveFilterEx_Proxy alias "IGraphConfig_RemoveFilterEx_Proxy" (byval This as IGraphConfig ptr, byval pFilter as IBaseFilter ptr, byval Flags as DWORD) as HRESULT
declare sub IGraphConfig_RemoveFilterEx_Stub alias "IGraphConfig_RemoveFilterEx_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IGraphConfigCallback alias "IID_IGraphConfigCallback" as IID

type IGraphConfigCallbackVtbl_ as IGraphConfigCallbackVtbl

type IGraphConfigCallback
	lpVtbl as IGraphConfigCallbackVtbl_ ptr
end type

type IGraphConfigCallbackVtbl
	QueryInterface as function(byval as IGraphConfigCallback ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IGraphConfigCallback ptr) as ULONG
	Release as function(byval as IGraphConfigCallback ptr) as ULONG
	Reconfigure as function(byval as IGraphConfigCallback ptr, byval as PVOID, byval as DWORD) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IGraphConfigCallback_Reconfigure_Proxy alias "IGraphConfigCallback_Reconfigure_Proxy" (byval This as IGraphConfigCallback ptr, byval pvContext as PVOID, byval dwFlags as DWORD) as HRESULT
declare sub IGraphConfigCallback_Reconfigure_Stub alias "IGraphConfigCallback_Reconfigure_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IFilterChain alias "IID_IFilterChain" as IID

type IFilterChainVtbl_ as IFilterChainVtbl

type IFilterChain
	lpVtbl as IFilterChainVtbl_ ptr
end type

type IFilterChainVtbl
	QueryInterface as function(byval as IFilterChain ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IFilterChain ptr) as ULONG
	Release as function(byval as IFilterChain ptr) as ULONG
	StartChain as function(byval as IFilterChain ptr, byval as IBaseFilter ptr, byval as IBaseFilter ptr) as HRESULT
	PauseChain as function(byval as IFilterChain ptr, byval as IBaseFilter ptr, byval as IBaseFilter ptr) as HRESULT
	StopChain as function(byval as IFilterChain ptr, byval as IBaseFilter ptr, byval as IBaseFilter ptr) as HRESULT
	RemoveChain as function(byval as IFilterChain ptr, byval as IBaseFilter ptr, byval as IBaseFilter ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IFilterChain_StartChain_Proxy alias "IFilterChain_StartChain_Proxy" (byval This as IFilterChain ptr, byval pStartFilter as IBaseFilter ptr, byval pEndFilter as IBaseFilter ptr) as HRESULT
declare sub IFilterChain_StartChain_Stub alias "IFilterChain_StartChain_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFilterChain_PauseChain_Proxy alias "IFilterChain_PauseChain_Proxy" (byval This as IFilterChain ptr, byval pStartFilter as IBaseFilter ptr, byval pEndFilter as IBaseFilter ptr) as HRESULT
declare sub IFilterChain_PauseChain_Stub alias "IFilterChain_PauseChain_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFilterChain_StopChain_Proxy alias "IFilterChain_StopChain_Proxy" (byval This as IFilterChain ptr, byval pStartFilter as IBaseFilter ptr, byval pEndFilter as IBaseFilter ptr) as HRESULT
declare sub IFilterChain_StopChain_Stub alias "IFilterChain_StopChain_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFilterChain_RemoveChain_Proxy alias "IFilterChain_RemoveChain_Proxy" (byval This as IFilterChain ptr, byval pStartFilter as IBaseFilter ptr, byval pEndFilter as IBaseFilter ptr) as HRESULT
declare sub IFilterChain_RemoveChain_Stub alias "IFilterChain_RemoveChain_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

#include once "win/ddraw.bi"

enum VMRPresentationFlags
	VMRSample_SyncPoint = &h1
	VMRSample_Preroll = &h2
	VMRSample_Discontinuity = &h4
	VMRSample_TimeValid = &h8
end enum

type VMRPRESENTATIONINFO
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

extern IID_IVMRImagePresenter alias "IID_IVMRImagePresenter" as IID

type IVMRImagePresenterVtbl_ as IVMRImagePresenterVtbl

type IVMRImagePresenter
	lpVtbl as IVMRImagePresenterVtbl_ ptr
end type

type IVMRImagePresenterVtbl
	QueryInterface as function(byval as IVMRImagePresenter ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IVMRImagePresenter ptr) as ULONG
	Release as function(byval as IVMRImagePresenter ptr) as ULONG
	StartPresenting as function(byval as IVMRImagePresenter ptr, byval as DWORD_PTR) as HRESULT
	StopPresenting as function(byval as IVMRImagePresenter ptr, byval as DWORD_PTR) as HRESULT
	PresentImage as function(byval as IVMRImagePresenter ptr, byval as DWORD_PTR, byval as VMRPRESENTATIONINFO ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IVMRImagePresenter_StartPresenting_Proxy alias "IVMRImagePresenter_StartPresenting_Proxy" (byval This as IVMRImagePresenter ptr, byval dwUserID as DWORD_PTR) as HRESULT
declare sub IVMRImagePresenter_StartPresenting_Stub alias "IVMRImagePresenter_StartPresenting_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRImagePresenter_StopPresenting_Proxy alias "IVMRImagePresenter_StopPresenting_Proxy" (byval This as IVMRImagePresenter ptr, byval dwUserID as DWORD_PTR) as HRESULT
declare sub IVMRImagePresenter_StopPresenting_Stub alias "IVMRImagePresenter_StopPresenting_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRImagePresenter_PresentImage_Proxy alias "IVMRImagePresenter_PresentImage_Proxy" (byval This as IVMRImagePresenter ptr, byval dwUserID as DWORD_PTR, byval lpPresInfo as VMRPRESENTATIONINFO ptr) as HRESULT
declare sub IVMRImagePresenter_PresentImage_Stub alias "IVMRImagePresenter_PresentImage_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

enum VMRSurfaceAllocationFlags
	AMAP_PIXELFORMAT_VALID = &h1
	AMAP_3D_TARGET = &h2
	AMAP_ALLOW_SYSMEM = &h4
	AMAP_FORCE_SYSMEM = &h8
	AMAP_DIRECTED_FLIP = &h10
	AMAP_DXVA_TARGET = &h20
end enum

type VMRALLOCATIONINFO
	dwFlags as DWORD
	lpHdr as LPBITMAPINFOHEADER
	lpPixFmt as LPDDPIXELFORMAT
	szAspectRatio as SIZE
	dwMinBuffers as DWORD
	dwMaxBuffers as DWORD
	dwInterlaceFlags as DWORD
	szNativeSize as SIZE
end type

extern IID_IVMRSurfaceAllocator alias "IID_IVMRSurfaceAllocator" as IID

type IVMRSurfaceAllocatorVtbl_ as IVMRSurfaceAllocatorVtbl

type IVMRSurfaceAllocator
	lpVtbl as IVMRSurfaceAllocatorVtbl_ ptr
end type

type IVMRSurfaceAllocatorVtbl
	QueryInterface as function(byval as IVMRSurfaceAllocator ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IVMRSurfaceAllocator ptr) as ULONG
	Release as function(byval as IVMRSurfaceAllocator ptr) as ULONG
	AllocateSurface as function(byval as IVMRSurfaceAllocator ptr, byval as DWORD_PTR, byval as VMRALLOCATIONINFO ptr, byval as DWORD ptr, byval as LPDIRECTDRAWSURFACE7 ptr) as HRESULT
	FreeSurface as function(byval as IVMRSurfaceAllocator ptr, byval as DWORD_PTR) as HRESULT
	PrepareSurface as function(byval as IVMRSurfaceAllocator ptr, byval as DWORD_PTR, byval as LPDIRECTDRAWSURFACE7, byval as DWORD) as HRESULT
	AdviseNotify as function(byval as IVMRSurfaceAllocator ptr, byval as IVMRSurfaceAllocatorNotify_ ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IVMRSurfaceAllocator_AllocateSurface_Proxy alias "IVMRSurfaceAllocator_AllocateSurface_Proxy" (byval This as IVMRSurfaceAllocator ptr, byval dwUserID as DWORD_PTR, byval lpAllocInfo as VMRALLOCATIONINFO ptr, byval lpdwActualBuffers as DWORD ptr, byval lplpSurface as LPDIRECTDRAWSURFACE7 ptr) as HRESULT
declare sub IVMRSurfaceAllocator_AllocateSurface_Stub alias "IVMRSurfaceAllocator_AllocateSurface_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRSurfaceAllocator_FreeSurface_Proxy alias "IVMRSurfaceAllocator_FreeSurface_Proxy" (byval This as IVMRSurfaceAllocator ptr, byval dwID as DWORD_PTR) as HRESULT
declare sub IVMRSurfaceAllocator_FreeSurface_Stub alias "IVMRSurfaceAllocator_FreeSurface_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRSurfaceAllocator_PrepareSurface_Proxy alias "IVMRSurfaceAllocator_PrepareSurface_Proxy" (byval This as IVMRSurfaceAllocator ptr, byval dwUserID as DWORD_PTR, byval lpSurface as LPDIRECTDRAWSURFACE7, byval dwSurfaceFlags as DWORD) as HRESULT
declare sub IVMRSurfaceAllocator_PrepareSurface_Stub alias "IVMRSurfaceAllocator_PrepareSurface_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRSurfaceAllocator_AdviseNotify_Proxy alias "IVMRSurfaceAllocator_AdviseNotify_Proxy" (byval This as IVMRSurfaceAllocator ptr, byval lpIVMRSurfAllocNotify as IVMRSurfaceAllocatorNotify ptr) as HRESULT
declare sub IVMRSurfaceAllocator_AdviseNotify_Stub alias "IVMRSurfaceAllocator_AdviseNotify_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IVMRSurfaceAllocatorNotify alias "IID_IVMRSurfaceAllocatorNotify" as IID

type IVMRSurfaceAllocatorNotifyVtbl_ as IVMRSurfaceAllocatorNotifyVtbl

type IVMRSurfaceAllocatorNotify
	lpVtbl as IVMRSurfaceAllocatorNotifyVtbl_ ptr
end type

type IVMRSurfaceAllocatorNotifyVtbl
	QueryInterface as function(byval as IVMRSurfaceAllocatorNotify ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IVMRSurfaceAllocatorNotify ptr) as ULONG
	Release as function(byval as IVMRSurfaceAllocatorNotify ptr) as ULONG
	AdviseSurfaceAllocator as function(byval as IVMRSurfaceAllocatorNotify ptr, byval as DWORD_PTR, byval as IVMRSurfaceAllocator ptr) as HRESULT
	SetDDrawDevice as function(byval as IVMRSurfaceAllocatorNotify ptr, byval as LPDIRECTDRAW7, byval as HMONITOR) as HRESULT
	ChangeDDrawDevice as function(byval as IVMRSurfaceAllocatorNotify ptr, byval as LPDIRECTDRAW7, byval as HMONITOR) as HRESULT
	RestoreDDrawSurfaces as function(byval as IVMRSurfaceAllocatorNotify ptr) as HRESULT
	NotifyEvent as function(byval as IVMRSurfaceAllocatorNotify ptr, byval as LONG, byval as LONG_PTR, byval as LONG_PTR) as HRESULT
	SetBorderColor as function(byval as IVMRSurfaceAllocatorNotify ptr, byval as COLORREF) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IVMRSurfaceAllocatorNotify_AdviseSurfaceAllocator_Proxy alias "IVMRSurfaceAllocatorNotify_AdviseSurfaceAllocator_Proxy" (byval This as IVMRSurfaceAllocatorNotify ptr, byval dwUserID as DWORD_PTR, byval lpIVRMSurfaceAllocator as IVMRSurfaceAllocator ptr) as HRESULT
declare sub IVMRSurfaceAllocatorNotify_AdviseSurfaceAllocator_Stub alias "IVMRSurfaceAllocatorNotify_AdviseSurfaceAllocator_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRSurfaceAllocatorNotify_SetDDrawDevice_Proxy alias "IVMRSurfaceAllocatorNotify_SetDDrawDevice_Proxy" (byval This as IVMRSurfaceAllocatorNotify ptr, byval lpDDrawDevice as LPDIRECTDRAW7, byval hMonitor as HMONITOR) as HRESULT
declare sub IVMRSurfaceAllocatorNotify_SetDDrawDevice_Stub alias "IVMRSurfaceAllocatorNotify_SetDDrawDevice_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRSurfaceAllocatorNotify_ChangeDDrawDevice_Proxy alias "IVMRSurfaceAllocatorNotify_ChangeDDrawDevice_Proxy" (byval This as IVMRSurfaceAllocatorNotify ptr, byval lpDDrawDevice as LPDIRECTDRAW7, byval hMonitor as HMONITOR) as HRESULT
declare sub IVMRSurfaceAllocatorNotify_ChangeDDrawDevice_Stub alias "IVMRSurfaceAllocatorNotify_ChangeDDrawDevice_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRSurfaceAllocatorNotify_RestoreDDrawSurfaces_Proxy alias "IVMRSurfaceAllocatorNotify_RestoreDDrawSurfaces_Proxy" (byval This as IVMRSurfaceAllocatorNotify ptr) as HRESULT
declare sub IVMRSurfaceAllocatorNotify_RestoreDDrawSurfaces_Stub alias "IVMRSurfaceAllocatorNotify_RestoreDDrawSurfaces_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRSurfaceAllocatorNotify_NotifyEvent_Proxy alias "IVMRSurfaceAllocatorNotify_NotifyEvent_Proxy" (byval This as IVMRSurfaceAllocatorNotify ptr, byval EventCode as LONG, byval Param1 as LONG_PTR, byval Param2 as LONG_PTR) as HRESULT
declare sub IVMRSurfaceAllocatorNotify_NotifyEvent_Stub alias "IVMRSurfaceAllocatorNotify_NotifyEvent_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRSurfaceAllocatorNotify_SetBorderColor_Proxy alias "IVMRSurfaceAllocatorNotify_SetBorderColor_Proxy" (byval This as IVMRSurfaceAllocatorNotify ptr, byval clrBorder as COLORREF) as HRESULT
declare sub IVMRSurfaceAllocatorNotify_SetBorderColor_Stub alias "IVMRSurfaceAllocatorNotify_SetBorderColor_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

enum VMR_ASPECT_RATIO_MODE
	VMR_ARMODE_NONE = 0
	VMR_ARMODE_LETTER_BOX = VMR_ARMODE_NONE+1
end enum

extern IID_IVMRWindowlessControl alias "IID_IVMRWindowlessControl" as IID

type IVMRWindowlessControlVtbl_ as IVMRWindowlessControlVtbl

type IVMRWindowlessControl
	lpVtbl as IVMRWindowlessControlVtbl_ ptr
end type

type IVMRWindowlessControlVtbl
	QueryInterface as function(byval as IVMRWindowlessControl ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IVMRWindowlessControl ptr) as ULONG
	Release as function(byval as IVMRWindowlessControl ptr) as ULONG
	GetNativeVideoSize as function(byval as IVMRWindowlessControl ptr, byval as LONG ptr, byval as LONG ptr, byval as LONG ptr, byval as LONG ptr) as HRESULT
	GetMinIdealVideoSize as function(byval as IVMRWindowlessControl ptr, byval as LONG ptr, byval as LONG ptr) as HRESULT
	GetMaxIdealVideoSize as function(byval as IVMRWindowlessControl ptr, byval as LONG ptr, byval as LONG ptr) as HRESULT
	SetVideoPosition as function(byval as IVMRWindowlessControl ptr, byval as LPRECT, byval as LPRECT) as HRESULT
	GetVideoPosition as function(byval as IVMRWindowlessControl ptr, byval as LPRECT, byval as LPRECT) as HRESULT
	GetAspectRatioMode as function(byval as IVMRWindowlessControl ptr, byval as DWORD ptr) as HRESULT
	SetAspectRatioMode as function(byval as IVMRWindowlessControl ptr, byval as DWORD) as HRESULT
	SetVideoClippingWindow as function(byval as IVMRWindowlessControl ptr, byval as HWND) as HRESULT
	RepaintVideo as function(byval as IVMRWindowlessControl ptr, byval as HWND, byval as HDC) as HRESULT
	DisplayModeChanged as function(byval as IVMRWindowlessControl ptr) as HRESULT
	GetCurrentImage as function(byval as IVMRWindowlessControl ptr, byval as BYTE ptr ptr) as HRESULT
	SetBorderColor as function(byval as IVMRWindowlessControl ptr, byval as COLORREF) as HRESULT
	GetBorderColor as function(byval as IVMRWindowlessControl ptr, byval as COLORREF ptr) as HRESULT
	SetColorKey as function(byval as IVMRWindowlessControl ptr, byval as COLORREF) as HRESULT
	GetColorKey as function(byval as IVMRWindowlessControl ptr, byval as COLORREF ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IVMRWindowlessControl_GetNativeVideoSize_Proxy alias "IVMRWindowlessControl_GetNativeVideoSize_Proxy" (byval This as IVMRWindowlessControl ptr, byval lpWidth as LONG ptr, byval lpHeight as LONG ptr, byval lpARWidth as LONG ptr, byval lpARHeight as LONG ptr) as HRESULT
declare sub IVMRWindowlessControl_GetNativeVideoSize_Stub alias "IVMRWindowlessControl_GetNativeVideoSize_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRWindowlessControl_GetMinIdealVideoSize_Proxy alias "IVMRWindowlessControl_GetMinIdealVideoSize_Proxy" (byval This as IVMRWindowlessControl ptr, byval lpWidth as LONG ptr, byval lpHeight as LONG ptr) as HRESULT
declare sub IVMRWindowlessControl_GetMinIdealVideoSize_Stub alias "IVMRWindowlessControl_GetMinIdealVideoSize_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRWindowlessControl_GetMaxIdealVideoSize_Proxy alias "IVMRWindowlessControl_GetMaxIdealVideoSize_Proxy" (byval This as IVMRWindowlessControl ptr, byval lpWidth as LONG ptr, byval lpHeight as LONG ptr) as HRESULT
declare sub IVMRWindowlessControl_GetMaxIdealVideoSize_Stub alias "IVMRWindowlessControl_GetMaxIdealVideoSize_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRWindowlessControl_SetVideoPosition_Proxy alias "IVMRWindowlessControl_SetVideoPosition_Proxy" (byval This as IVMRWindowlessControl ptr, byval lpSRCRect as LPRECT, byval lpDSTRect as LPRECT) as HRESULT
declare sub IVMRWindowlessControl_SetVideoPosition_Stub alias "IVMRWindowlessControl_SetVideoPosition_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRWindowlessControl_GetVideoPosition_Proxy alias "IVMRWindowlessControl_GetVideoPosition_Proxy" (byval This as IVMRWindowlessControl ptr, byval lpSRCRect as LPRECT, byval lpDSTRect as LPRECT) as HRESULT
declare sub IVMRWindowlessControl_GetVideoPosition_Stub alias "IVMRWindowlessControl_GetVideoPosition_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRWindowlessControl_GetAspectRatioMode_Proxy alias "IVMRWindowlessControl_GetAspectRatioMode_Proxy" (byval This as IVMRWindowlessControl ptr, byval lpAspectRatioMode as DWORD ptr) as HRESULT
declare sub IVMRWindowlessControl_GetAspectRatioMode_Stub alias "IVMRWindowlessControl_GetAspectRatioMode_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRWindowlessControl_SetAspectRatioMode_Proxy alias "IVMRWindowlessControl_SetAspectRatioMode_Proxy" (byval This as IVMRWindowlessControl ptr, byval AspectRatioMode as DWORD) as HRESULT
declare sub IVMRWindowlessControl_SetAspectRatioMode_Stub alias "IVMRWindowlessControl_SetAspectRatioMode_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRWindowlessControl_SetVideoClippingWindow_Proxy alias "IVMRWindowlessControl_SetVideoClippingWindow_Proxy" (byval This as IVMRWindowlessControl ptr, byval hwnd as HWND) as HRESULT
declare sub IVMRWindowlessControl_SetVideoClippingWindow_Stub alias "IVMRWindowlessControl_SetVideoClippingWindow_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRWindowlessControl_RepaintVideo_Proxy alias "IVMRWindowlessControl_RepaintVideo_Proxy" (byval This as IVMRWindowlessControl ptr, byval hwnd as HWND, byval hdc as HDC) as HRESULT
declare sub IVMRWindowlessControl_RepaintVideo_Stub alias "IVMRWindowlessControl_RepaintVideo_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRWindowlessControl_DisplayModeChanged_Proxy alias "IVMRWindowlessControl_DisplayModeChanged_Proxy" (byval This as IVMRWindowlessControl ptr) as HRESULT
declare sub IVMRWindowlessControl_DisplayModeChanged_Stub alias "IVMRWindowlessControl_DisplayModeChanged_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRWindowlessControl_GetCurrentImage_Proxy alias "IVMRWindowlessControl_GetCurrentImage_Proxy" (byval This as IVMRWindowlessControl ptr, byval lpDib as BYTE ptr ptr) as HRESULT
declare sub IVMRWindowlessControl_GetCurrentImage_Stub alias "IVMRWindowlessControl_GetCurrentImage_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRWindowlessControl_SetBorderColor_Proxy alias "IVMRWindowlessControl_SetBorderColor_Proxy" (byval This as IVMRWindowlessControl ptr, byval Clr as COLORREF) as HRESULT
declare sub IVMRWindowlessControl_SetBorderColor_Stub alias "IVMRWindowlessControl_SetBorderColor_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRWindowlessControl_GetBorderColor_Proxy alias "IVMRWindowlessControl_GetBorderColor_Proxy" (byval This as IVMRWindowlessControl ptr, byval lpClr as COLORREF ptr) as HRESULT
declare sub IVMRWindowlessControl_GetBorderColor_Stub alias "IVMRWindowlessControl_GetBorderColor_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRWindowlessControl_SetColorKey_Proxy alias "IVMRWindowlessControl_SetColorKey_Proxy" (byval This as IVMRWindowlessControl ptr, byval Clr as COLORREF) as HRESULT
declare sub IVMRWindowlessControl_SetColorKey_Stub alias "IVMRWindowlessControl_SetColorKey_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRWindowlessControl_GetColorKey_Proxy alias "IVMRWindowlessControl_GetColorKey_Proxy" (byval This as IVMRWindowlessControl ptr, byval lpClr as COLORREF ptr) as HRESULT
declare sub IVMRWindowlessControl_GetColorKey_Stub alias "IVMRWindowlessControl_GetColorKey_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

enum VMRMixerPrefs
	MixerPref_NoDecimation = &h1
	MixerPref_DecimateOutput = &h2
	MixerPref_DecimateMask = &hf
	MixerPref_BiLinearFiltering = &h10
	MixerPref_PointFiltering = &h20
	MixerPref_FilteringMask = &hf0
	MixerPref_RenderTargetRGB = &h100
	MixerPref_RenderTargetYUV420 = &h200
	MixerPref_RenderTargetYUV422 = &h400
	MixerPref_RenderTargetYUV444 = &h800
	MixerPref_RenderTargetReserved = &hf000
	MixerPref_RenderTargetMask = &hff00
end enum

type NORMALIZEDRECT
	left as single
	top as single
	right as single
	bottom as single
end type

type PNORMALIZEDRECT as NORMALIZEDRECT ptr
extern IID_IVMRMixerControl alias "IID_IVMRMixerControl" as IID

type IVMRMixerControlVtbl_ as IVMRMixerControlVtbl

type IVMRMixerControl
	lpVtbl as IVMRMixerControlVtbl_ ptr
end type

type IVMRMixerControlVtbl
	QueryInterface as function(byval as IVMRMixerControl ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IVMRMixerControl ptr) as ULONG
	Release as function(byval as IVMRMixerControl ptr) as ULONG
	SetAlpha as function(byval as IVMRMixerControl ptr, byval as DWORD, byval as single) as HRESULT
	GetAlpha as function(byval as IVMRMixerControl ptr, byval as DWORD, byval as single ptr) as HRESULT
	SetZOrder as function(byval as IVMRMixerControl ptr, byval as DWORD, byval as DWORD) as HRESULT
	GetZOrder as function(byval as IVMRMixerControl ptr, byval as DWORD, byval as DWORD ptr) as HRESULT
	SetOutputRect as function(byval as IVMRMixerControl ptr, byval as DWORD, byval as NORMALIZEDRECT ptr) as HRESULT
	GetOutputRect as function(byval as IVMRMixerControl ptr, byval as DWORD, byval as NORMALIZEDRECT ptr) as HRESULT
	SetBackgroundClr as function(byval as IVMRMixerControl ptr, byval as COLORREF) as HRESULT
	GetBackgroundClr as function(byval as IVMRMixerControl ptr, byval as COLORREF ptr) as HRESULT
	SetMixingPrefs as function(byval as IVMRMixerControl ptr, byval as DWORD) as HRESULT
	GetMixingPrefs as function(byval as IVMRMixerControl ptr, byval as DWORD ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IVMRMixerControl_SetAlpha_Proxy alias "IVMRMixerControl_SetAlpha_Proxy" (byval This as IVMRMixerControl ptr, byval dwStreamID as DWORD, byval Alpha as single) as HRESULT
declare sub IVMRMixerControl_SetAlpha_Stub alias "IVMRMixerControl_SetAlpha_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRMixerControl_GetAlpha_Proxy alias "IVMRMixerControl_GetAlpha_Proxy" (byval This as IVMRMixerControl ptr, byval dwStreamID as DWORD, byval pAlpha as single ptr) as HRESULT
declare sub IVMRMixerControl_GetAlpha_Stub alias "IVMRMixerControl_GetAlpha_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRMixerControl_SetZOrder_Proxy alias "IVMRMixerControl_SetZOrder_Proxy" (byval This as IVMRMixerControl ptr, byval dwStreamID as DWORD, byval dwZ as DWORD) as HRESULT
declare sub IVMRMixerControl_SetZOrder_Stub alias "IVMRMixerControl_SetZOrder_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRMixerControl_GetZOrder_Proxy alias "IVMRMixerControl_GetZOrder_Proxy" (byval This as IVMRMixerControl ptr, byval dwStreamID as DWORD, byval pZ as DWORD ptr) as HRESULT
declare sub IVMRMixerControl_GetZOrder_Stub alias "IVMRMixerControl_GetZOrder_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRMixerControl_SetOutputRect_Proxy alias "IVMRMixerControl_SetOutputRect_Proxy" (byval This as IVMRMixerControl ptr, byval dwStreamID as DWORD, byval pRect as NORMALIZEDRECT ptr) as HRESULT
declare sub IVMRMixerControl_SetOutputRect_Stub alias "IVMRMixerControl_SetOutputRect_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRMixerControl_GetOutputRect_Proxy alias "IVMRMixerControl_GetOutputRect_Proxy" (byval This as IVMRMixerControl ptr, byval dwStreamID as DWORD, byval pRect as NORMALIZEDRECT ptr) as HRESULT
declare sub IVMRMixerControl_GetOutputRect_Stub alias "IVMRMixerControl_GetOutputRect_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRMixerControl_SetBackgroundClr_Proxy alias "IVMRMixerControl_SetBackgroundClr_Proxy" (byval This as IVMRMixerControl ptr, byval ClrBkg as COLORREF) as HRESULT
declare sub IVMRMixerControl_SetBackgroundClr_Stub alias "IVMRMixerControl_SetBackgroundClr_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRMixerControl_GetBackgroundClr_Proxy alias "IVMRMixerControl_GetBackgroundClr_Proxy" (byval This as IVMRMixerControl ptr, byval lpClrBkg as COLORREF ptr) as HRESULT
declare sub IVMRMixerControl_GetBackgroundClr_Stub alias "IVMRMixerControl_GetBackgroundClr_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRMixerControl_SetMixingPrefs_Proxy alias "IVMRMixerControl_SetMixingPrefs_Proxy" (byval This as IVMRMixerControl ptr, byval dwMixerPrefs as DWORD) as HRESULT
declare sub IVMRMixerControl_SetMixingPrefs_Stub alias "IVMRMixerControl_SetMixingPrefs_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRMixerControl_GetMixingPrefs_Proxy alias "IVMRMixerControl_GetMixingPrefs_Proxy" (byval This as IVMRMixerControl ptr, byval pdwMixerPrefs as DWORD ptr) as HRESULT
declare sub IVMRMixerControl_GetMixingPrefs_Stub alias "IVMRMixerControl_GetMixingPrefs_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type VMRGUID
	pGUID as GUID ptr
	GUID as GUID
end type

type VMRMONITORINFO
	guid as VMRGUID
	rcMonitor as RECT
	hMon as HMONITOR
	dwFlags as DWORD
	szDevice(0 to 32-1) as wchar_t
	szDescription(0 to 256-1) as wchar_t
	liDriverVersion as LARGE_INTEGER
	dwVendorId as DWORD
	dwDeviceId as DWORD
	dwSubSysId as DWORD
	dwRevision as DWORD
end type

extern IID_IVMRMonitorConfig alias "IID_IVMRMonitorConfig" as IID

type IVMRMonitorConfigVtbl_ as IVMRMonitorConfigVtbl

type IVMRMonitorConfig
	lpVtbl as IVMRMonitorConfigVtbl_ ptr
end type

type IVMRMonitorConfigVtbl
	QueryInterface as function(byval as IVMRMonitorConfig ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IVMRMonitorConfig ptr) as ULONG
	Release as function(byval as IVMRMonitorConfig ptr) as ULONG
	SetMonitor as function(byval as IVMRMonitorConfig ptr, byval as VMRGUID ptr) as HRESULT
	GetMonitor as function(byval as IVMRMonitorConfig ptr, byval as VMRGUID ptr) as HRESULT
	SetDefaultMonitor as function(byval as IVMRMonitorConfig ptr, byval as VMRGUID ptr) as HRESULT
	GetDefaultMonitor as function(byval as IVMRMonitorConfig ptr, byval as VMRGUID ptr) as HRESULT
	GetAvailableMonitors as function(byval as IVMRMonitorConfig ptr, byval as VMRMONITORINFO ptr, byval as DWORD, byval as DWORD ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IVMRMonitorConfig_SetMonitor_Proxy alias "IVMRMonitorConfig_SetMonitor_Proxy" (byval This as IVMRMonitorConfig ptr, byval pGUID as VMRGUID ptr) as HRESULT
declare sub IVMRMonitorConfig_SetMonitor_Stub alias "IVMRMonitorConfig_SetMonitor_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRMonitorConfig_GetMonitor_Proxy alias "IVMRMonitorConfig_GetMonitor_Proxy" (byval This as IVMRMonitorConfig ptr, byval pGUID as VMRGUID ptr) as HRESULT
declare sub IVMRMonitorConfig_GetMonitor_Stub alias "IVMRMonitorConfig_GetMonitor_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRMonitorConfig_SetDefaultMonitor_Proxy alias "IVMRMonitorConfig_SetDefaultMonitor_Proxy" (byval This as IVMRMonitorConfig ptr, byval pGUID as VMRGUID ptr) as HRESULT
declare sub IVMRMonitorConfig_SetDefaultMonitor_Stub alias "IVMRMonitorConfig_SetDefaultMonitor_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRMonitorConfig_GetDefaultMonitor_Proxy alias "IVMRMonitorConfig_GetDefaultMonitor_Proxy" (byval This as IVMRMonitorConfig ptr, byval pGUID as VMRGUID ptr) as HRESULT
declare sub IVMRMonitorConfig_GetDefaultMonitor_Stub alias "IVMRMonitorConfig_GetDefaultMonitor_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRMonitorConfig_GetAvailableMonitors_Proxy alias "IVMRMonitorConfig_GetAvailableMonitors_Proxy" (byval This as IVMRMonitorConfig ptr, byval pInfo as VMRMONITORINFO ptr, byval dwMaxInfoArraySize as DWORD, byval pdwNumDevices as DWORD ptr) as HRESULT
declare sub IVMRMonitorConfig_GetAvailableMonitors_Stub alias "IVMRMonitorConfig_GetAvailableMonitors_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

enum VMRRenderPrefs
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

enum VMRMode
	VMRMode_Windowed = &h1
	VMRMode_Windowless = &h2
	VMRMode_Renderless = &h4
	VMRMode_Mask = &h7
end enum

#define	MAX_NUMBER_OF_STREAMS = 16

extern IID_IVMRFilterConfig alias "IID_IVMRFilterConfig" as IID

type IVMRFilterConfigVtbl_ as IVMRFilterConfigVtbl

type IVMRFilterConfig
	lpVtbl as IVMRFilterConfigVtbl_ ptr
end type

type IVMRFilterConfigVtbl
	QueryInterface as function(byval as IVMRFilterConfig ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IVMRFilterConfig ptr) as ULONG
	Release as function(byval as IVMRFilterConfig ptr) as ULONG
	SetImageCompositor as function(byval as IVMRFilterConfig ptr, byval as IVMRImageCompositor_ ptr) as HRESULT
	SetNumberOfStreams as function(byval as IVMRFilterConfig ptr, byval as DWORD) as HRESULT
	GetNumberOfStreams as function(byval as IVMRFilterConfig ptr, byval as DWORD ptr) as HRESULT
	SetRenderingPrefs as function(byval as IVMRFilterConfig ptr, byval as DWORD) as HRESULT
	GetRenderingPrefs as function(byval as IVMRFilterConfig ptr, byval as DWORD ptr) as HRESULT
	SetRenderingMode as function(byval as IVMRFilterConfig ptr, byval as DWORD) as HRESULT
	GetRenderingMode as function(byval as IVMRFilterConfig ptr, byval as DWORD ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IVMRFilterConfig_SetImageCompositor_Proxy alias "IVMRFilterConfig_SetImageCompositor_Proxy" (byval This as IVMRFilterConfig ptr, byval lpVMRImgCompositor as IVMRImageCompositor ptr) as HRESULT
declare sub IVMRFilterConfig_SetImageCompositor_Stub alias "IVMRFilterConfig_SetImageCompositor_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRFilterConfig_SetNumberOfStreams_Proxy alias "IVMRFilterConfig_SetNumberOfStreams_Proxy" (byval This as IVMRFilterConfig ptr, byval dwMaxStreams as DWORD) as HRESULT
declare sub IVMRFilterConfig_SetNumberOfStreams_Stub alias "IVMRFilterConfig_SetNumberOfStreams_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRFilterConfig_GetNumberOfStreams_Proxy alias "IVMRFilterConfig_GetNumberOfStreams_Proxy" (byval This as IVMRFilterConfig ptr, byval pdwMaxStreams as DWORD ptr) as HRESULT
declare sub IVMRFilterConfig_GetNumberOfStreams_Stub alias "IVMRFilterConfig_GetNumberOfStreams_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRFilterConfig_SetRenderingPrefs_Proxy alias "IVMRFilterConfig_SetRenderingPrefs_Proxy" (byval This as IVMRFilterConfig ptr, byval dwRenderFlags as DWORD) as HRESULT
declare sub IVMRFilterConfig_SetRenderingPrefs_Stub alias "IVMRFilterConfig_SetRenderingPrefs_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRFilterConfig_GetRenderingPrefs_Proxy alias "IVMRFilterConfig_GetRenderingPrefs_Proxy" (byval This as IVMRFilterConfig ptr, byval pdwRenderFlags as DWORD ptr) as HRESULT
declare sub IVMRFilterConfig_GetRenderingPrefs_Stub alias "IVMRFilterConfig_GetRenderingPrefs_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRFilterConfig_SetRenderingMode_Proxy alias "IVMRFilterConfig_SetRenderingMode_Proxy" (byval This as IVMRFilterConfig ptr, byval Mode as DWORD) as HRESULT
declare sub IVMRFilterConfig_SetRenderingMode_Stub alias "IVMRFilterConfig_SetRenderingMode_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRFilterConfig_GetRenderingMode_Proxy alias "IVMRFilterConfig_GetRenderingMode_Proxy" (byval This as IVMRFilterConfig ptr, byval pMode as DWORD ptr) as HRESULT
declare sub IVMRFilterConfig_GetRenderingMode_Stub alias "IVMRFilterConfig_GetRenderingMode_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IVMRAspectRatioControl alias "IID_IVMRAspectRatioControl" as IID

type IVMRAspectRatioControlVtbl_ as IVMRAspectRatioControlVtbl

type IVMRAspectRatioControl
	lpVtbl as IVMRAspectRatioControlVtbl_ ptr
end type

type IVMRAspectRatioControlVtbl
	QueryInterface as function(byval as IVMRAspectRatioControl ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IVMRAspectRatioControl ptr) as ULONG
	Release as function(byval as IVMRAspectRatioControl ptr) as ULONG
	GetAspectRatioMode as function(byval as IVMRAspectRatioControl ptr, byval as LPDWORD) as HRESULT
	SetAspectRatioMode as function(byval as IVMRAspectRatioControl ptr, byval as DWORD) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IVMRAspectRatioControl_GetAspectRatioMode_Proxy alias "IVMRAspectRatioControl_GetAspectRatioMode_Proxy" (byval This as IVMRAspectRatioControl ptr, byval lpdwARMode as LPDWORD) as HRESULT
declare sub IVMRAspectRatioControl_GetAspectRatioMode_Stub alias "IVMRAspectRatioControl_GetAspectRatioMode_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRAspectRatioControl_SetAspectRatioMode_Proxy alias "IVMRAspectRatioControl_SetAspectRatioMode_Proxy" (byval This as IVMRAspectRatioControl ptr, byval dwARMode as DWORD) as HRESULT
declare sub IVMRAspectRatioControl_SetAspectRatioMode_Stub alias "IVMRAspectRatioControl_SetAspectRatioMode_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

enum VMRDeinterlacePrefs
	DeinterlacePref_NextBest = &h1
	DeinterlacePref_BOB = &h2
	DeinterlacePref_Weave = &h4
	DeinterlacePref_Mask = &h7
end enum

enum VMRDeinterlaceTech
	DeinterlaceTech_Unknown = 0
	DeinterlaceTech_BOBLineReplicate = &h1
	DeinterlaceTech_BOBVerticalStretch = &h2
	DeinterlaceTech_MedianFiltering = &h4
	DeinterlaceTech_EdgeFiltering = &h10
	DeinterlaceTech_FieldAdaptive = &h20
	DeinterlaceTech_PixelAdaptive = &h40
	DeinterlaceTech_MotionVectorSteered = &h80
end enum

type VMRFrequency
	dwNumerator as DWORD
	dwDenominator as DWORD
end type

type VMRVideoDesc
	dwSize as DWORD
	dwSampleWidth as DWORD
	dwSampleHeight as DWORD
	SingleFieldPerSample as BOOL
	dwFourCC as DWORD
	InputSampleFreq as VMRFrequency
	OutputFrameFreq as VMRFrequency
end type

type VMRDeinterlaceCaps
	dwSize as DWORD
	dwNumPreviousOutputFrames as DWORD
	dwNumForwardRefSamples as DWORD
	dwNumBackwardRefSamples as DWORD
	DeinterlaceTechnology as VMRDeinterlaceTech
end type

extern IID_IVMRDeinterlaceControl alias "IID_IVMRDeinterlaceControl" as IID

type IVMRDeinterlaceControlVtbl_ as IVMRDeinterlaceControlVtbl

type IVMRDeinterlaceControl
	lpVtbl as IVMRDeinterlaceControlVtbl_ ptr
end type

type IVMRDeinterlaceControlVtbl
	QueryInterface as function(byval as IVMRDeinterlaceControl ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IVMRDeinterlaceControl ptr) as ULONG
	Release as function(byval as IVMRDeinterlaceControl ptr) as ULONG
	GetNumberOfDeinterlaceModes as function(byval as IVMRDeinterlaceControl ptr, byval as VMRVideoDesc ptr, byval as LPDWORD, byval as LPGUID) as HRESULT
	GetDeinterlaceModeCaps as function(byval as IVMRDeinterlaceControl ptr, byval as LPGUID, byval as VMRVideoDesc ptr, byval as VMRDeinterlaceCaps ptr) as HRESULT
	GetDeinterlaceMode as function(byval as IVMRDeinterlaceControl ptr, byval as DWORD, byval as LPGUID) as HRESULT
	SetDeinterlaceMode as function(byval as IVMRDeinterlaceControl ptr, byval as DWORD, byval as LPGUID) as HRESULT
	GetDeinterlacePrefs as function(byval as IVMRDeinterlaceControl ptr, byval as LPDWORD) as HRESULT
	SetDeinterlacePrefs as function(byval as IVMRDeinterlaceControl ptr, byval as DWORD) as HRESULT
	GetActualDeinterlaceMode as function(byval as IVMRDeinterlaceControl ptr, byval as DWORD, byval as LPGUID) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IVMRDeinterlaceControl_GetNumberOfDeinterlaceModes_Proxy alias "IVMRDeinterlaceControl_GetNumberOfDeinterlaceModes_Proxy" (byval This as IVMRDeinterlaceControl ptr, byval lpVideoDescription as VMRVideoDesc ptr, byval lpdwNumDeinterlaceModes as LPDWORD, byval lpDeinterlaceModes as LPGUID) as HRESULT
declare sub IVMRDeinterlaceControl_GetNumberOfDeinterlaceModes_Stub alias "IVMRDeinterlaceControl_GetNumberOfDeinterlaceModes_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRDeinterlaceControl_GetDeinterlaceModeCaps_Proxy alias "IVMRDeinterlaceControl_GetDeinterlaceModeCaps_Proxy" (byval This as IVMRDeinterlaceControl ptr, byval lpDeinterlaceMode as LPGUID, byval lpVideoDescription as VMRVideoDesc ptr, byval lpDeinterlaceCaps as VMRDeinterlaceCaps ptr) as HRESULT
declare sub IVMRDeinterlaceControl_GetDeinterlaceModeCaps_Stub alias "IVMRDeinterlaceControl_GetDeinterlaceModeCaps_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRDeinterlaceControl_GetDeinterlaceMode_Proxy alias "IVMRDeinterlaceControl_GetDeinterlaceMode_Proxy" (byval This as IVMRDeinterlaceControl ptr, byval dwStreamID as DWORD, byval lpDeinterlaceMode as LPGUID) as HRESULT
declare sub IVMRDeinterlaceControl_GetDeinterlaceMode_Stub alias "IVMRDeinterlaceControl_GetDeinterlaceMode_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRDeinterlaceControl_SetDeinterlaceMode_Proxy alias "IVMRDeinterlaceControl_SetDeinterlaceMode_Proxy" (byval This as IVMRDeinterlaceControl ptr, byval dwStreamID as DWORD, byval lpDeinterlaceMode as LPGUID) as HRESULT
declare sub IVMRDeinterlaceControl_SetDeinterlaceMode_Stub alias "IVMRDeinterlaceControl_SetDeinterlaceMode_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRDeinterlaceControl_GetDeinterlacePrefs_Proxy alias "IVMRDeinterlaceControl_GetDeinterlacePrefs_Proxy" (byval This as IVMRDeinterlaceControl ptr, byval lpdwDeinterlacePrefs as LPDWORD) as HRESULT
declare sub IVMRDeinterlaceControl_GetDeinterlacePrefs_Stub alias "IVMRDeinterlaceControl_GetDeinterlacePrefs_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRDeinterlaceControl_SetDeinterlacePrefs_Proxy alias "IVMRDeinterlaceControl_SetDeinterlacePrefs_Proxy" (byval This as IVMRDeinterlaceControl ptr, byval dwDeinterlacePrefs as DWORD) as HRESULT
declare sub IVMRDeinterlaceControl_SetDeinterlacePrefs_Stub alias "IVMRDeinterlaceControl_SetDeinterlacePrefs_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRDeinterlaceControl_GetActualDeinterlaceMode_Proxy alias "IVMRDeinterlaceControl_GetActualDeinterlaceMode_Proxy" (byval This as IVMRDeinterlaceControl ptr, byval dwStreamID as DWORD, byval lpDeinterlaceMode as LPGUID) as HRESULT
declare sub IVMRDeinterlaceControl_GetActualDeinterlaceMode_Stub alias "IVMRDeinterlaceControl_GetActualDeinterlaceMode_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type VMRALPHABITMAP
	dwFlags as DWORD
	hdc as HDC
	pDDS as LPDIRECTDRAWSURFACE7
	rSrc as RECT
	rDest as NORMALIZEDRECT
	fAlpha as FLOAT
	clrSrcKey as COLORREF
end type

type PVMRALPHABITMAP as VMRALPHABITMAP ptr

#define VMRBITMAP_DISABLE &h00000001
#define VMRBITMAP_HDC &h00000002
#define VMRBITMAP_ENTIREDDS &h00000004
#define VMRBITMAP_SRCCOLORKEY &h00000008
#define VMRBITMAP_SRCRECT &h00000010
extern IID_IVMRMixerBitmap alias "IID_IVMRMixerBitmap" as IID

type IVMRMixerBitmapVtbl_ as IVMRMixerBitmapVtbl

type IVMRMixerBitmap
	lpVtbl as IVMRMixerBitmapVtbl_ ptr
end type

type IVMRMixerBitmapVtbl
	QueryInterface as function(byval as IVMRMixerBitmap ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IVMRMixerBitmap ptr) as ULONG
	Release as function(byval as IVMRMixerBitmap ptr) as ULONG
	SetAlphaBitmap as function(byval as IVMRMixerBitmap ptr, byval as VMRALPHABITMAP ptr) as HRESULT
	UpdateAlphaBitmapParameters as function(byval as IVMRMixerBitmap ptr, byval as PVMRALPHABITMAP) as HRESULT
	GetAlphaBitmapParameters as function(byval as IVMRMixerBitmap ptr, byval as PVMRALPHABITMAP) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IVMRMixerBitmap_SetAlphaBitmap_Proxy alias "IVMRMixerBitmap_SetAlphaBitmap_Proxy" (byval This as IVMRMixerBitmap ptr, byval pBmpParms as VMRALPHABITMAP ptr) as HRESULT
declare sub IVMRMixerBitmap_SetAlphaBitmap_Stub alias "IVMRMixerBitmap_SetAlphaBitmap_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRMixerBitmap_UpdateAlphaBitmapParameters_Proxy alias "IVMRMixerBitmap_UpdateAlphaBitmapParameters_Proxy" (byval This as IVMRMixerBitmap ptr, byval pBmpParms as PVMRALPHABITMAP) as HRESULT
declare sub IVMRMixerBitmap_UpdateAlphaBitmapParameters_Stub alias "IVMRMixerBitmap_UpdateAlphaBitmapParameters_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRMixerBitmap_GetAlphaBitmapParameters_Proxy alias "IVMRMixerBitmap_GetAlphaBitmapParameters_Proxy" (byval This as IVMRMixerBitmap ptr, byval pBmpParms as PVMRALPHABITMAP) as HRESULT
declare sub IVMRMixerBitmap_GetAlphaBitmapParameters_Stub alias "IVMRMixerBitmap_GetAlphaBitmapParameters_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif

type VMRVIDEOSTREAMINFO
	pddsVideoSurface as LPDIRECTDRAWSURFACE7
	dwWidth as DWORD
	dwHeight as DWORD
	dwStrmID as DWORD
	fAlpha as FLOAT
	ddClrKey as DDCOLORKEY
	rNormal as NORMALIZEDRECT
end type

extern IID_IVMRImageCompositor alias "IID_IVMRImageCompositor" as IID

type IVMRImageCompositorVtbl_ as IVMRImageCompositorVtbl

type IVMRImageCompositor
	lpVtbl as IVMRImageCompositorVtbl_ ptr
end type

type IVMRImageCompositorVtbl
	QueryInterface as function(byval as IVMRImageCompositor ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IVMRImageCompositor ptr) as ULONG
	Release as function(byval as IVMRImageCompositor ptr) as ULONG
	InitCompositionTarget as function(byval as IVMRImageCompositor ptr, byval as IUnknown ptr, byval as LPDIRECTDRAWSURFACE7) as HRESULT
	TermCompositionTarget as function(byval as IVMRImageCompositor ptr, byval as IUnknown ptr, byval as LPDIRECTDRAWSURFACE7) as HRESULT
	SetStreamMediaType as function(byval as IVMRImageCompositor ptr, byval as DWORD, byval as AM_MEDIA_TYPE ptr, byval as BOOL) as HRESULT
	CompositeImage as function(byval as IVMRImageCompositor ptr, byval as IUnknown ptr, byval as LPDIRECTDRAWSURFACE7, byval as AM_MEDIA_TYPE ptr, byval as REFERENCE_TIME, byval as REFERENCE_TIME, byval as DWORD, byval as VMRVIDEOSTREAMINFO ptr, byval as UINT) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IVMRImageCompositor_InitCompositionTarget_Proxy alias "IVMRImageCompositor_InitCompositionTarget_Proxy" (byval This as IVMRImageCompositor ptr, byval pD3DDevice as IUnknown ptr, byval pddsRenderTarget as LPDIRECTDRAWSURFACE7) as HRESULT
declare sub IVMRImageCompositor_InitCompositionTarget_Stub alias "IVMRImageCompositor_InitCompositionTarget_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRImageCompositor_TermCompositionTarget_Proxy alias "IVMRImageCompositor_TermCompositionTarget_Proxy" (byval This as IVMRImageCompositor ptr, byval pD3DDevice as IUnknown ptr, byval pddsRenderTarget as LPDIRECTDRAWSURFACE7) as HRESULT
declare sub IVMRImageCompositor_TermCompositionTarget_Stub alias "IVMRImageCompositor_TermCompositionTarget_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRImageCompositor_SetStreamMediaType_Proxy alias "IVMRImageCompositor_SetStreamMediaType_Proxy" (byval This as IVMRImageCompositor ptr, byval dwStrmID as DWORD, byval pmt as AM_MEDIA_TYPE ptr, byval fTexture as BOOL) as HRESULT
declare sub IVMRImageCompositor_SetStreamMediaType_Stub alias "IVMRImageCompositor_SetStreamMediaType_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRImageCompositor_CompositeImage_Proxy alias "IVMRImageCompositor_CompositeImage_Proxy" (byval This as IVMRImageCompositor ptr, byval pD3DDevice as IUnknown ptr, byval pddsRenderTarget as LPDIRECTDRAWSURFACE7, byval pmtRenderTarget as AM_MEDIA_TYPE ptr, byval rtStart as REFERENCE_TIME, byval rtEnd as REFERENCE_TIME, byval dwClrBkGnd as DWORD, byval pVideoStreamInfo as VMRVIDEOSTREAMINFO ptr, byval cStreams as UINT) as HRESULT
declare sub IVMRImageCompositor_CompositeImage_Stub alias "IVMRImageCompositor_CompositeImage_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IVMRVideoStreamControl alias "IID_IVMRVideoStreamControl" as IID

type IVMRVideoStreamControlVtbl_ as IVMRVideoStreamControlVtbl

type IVMRVideoStreamControl
	lpVtbl as IVMRVideoStreamControlVtbl_ ptr
end type

type IVMRVideoStreamControlVtbl
	QueryInterface as function(byval as IVMRVideoStreamControl ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IVMRVideoStreamControl ptr) as ULONG
	Release as function(byval as IVMRVideoStreamControl ptr) as ULONG
	SetColorKey as function(byval as IVMRVideoStreamControl ptr, byval as LPDDCOLORKEY) as HRESULT
	GetColorKey as function(byval as IVMRVideoStreamControl ptr, byval as LPDDCOLORKEY) as HRESULT
	SetStreamActiveState as function(byval as IVMRVideoStreamControl ptr, byval as BOOL) as HRESULT
	GetStreamActiveState as function(byval as IVMRVideoStreamControl ptr, byval as BOOL ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IVMRVideoStreamControl_SetColorKey_Proxy alias "IVMRVideoStreamControl_SetColorKey_Proxy" (byval This as IVMRVideoStreamControl ptr, byval lpClrKey as LPDDCOLORKEY) as HRESULT
declare sub IVMRVideoStreamControl_SetColorKey_Stub alias "IVMRVideoStreamControl_SetColorKey_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRVideoStreamControl_GetColorKey_Proxy alias "IVMRVideoStreamControl_GetColorKey_Proxy" (byval This as IVMRVideoStreamControl ptr, byval lpClrKey as LPDDCOLORKEY) as HRESULT
declare sub IVMRVideoStreamControl_GetColorKey_Stub alias "IVMRVideoStreamControl_GetColorKey_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRVideoStreamControl_SetStreamActiveState_Proxy alias "IVMRVideoStreamControl_SetStreamActiveState_Proxy" (byval This as IVMRVideoStreamControl ptr, byval fActive as BOOL) as HRESULT
declare sub IVMRVideoStreamControl_SetStreamActiveState_Stub alias "IVMRVideoStreamControl_SetStreamActiveState_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRVideoStreamControl_GetStreamActiveState_Proxy alias "IVMRVideoStreamControl_GetStreamActiveState_Proxy" (byval This as IVMRVideoStreamControl ptr, byval lpfActive as BOOL ptr) as HRESULT
declare sub IVMRVideoStreamControl_GetStreamActiveState_Stub alias "IVMRVideoStreamControl_GetStreamActiveState_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IVMRSurface alias "IID_IVMRSurface" as IID

type IVMRSurfaceVtbl_ as IVMRSurfaceVtbl

type IVMRSurface
	lpVtbl as IVMRSurfaceVtbl_ ptr
end type

type IVMRSurfaceVtbl
	QueryInterface as function(byval as IVMRSurface ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IVMRSurface ptr) as ULONG
	Release as function(byval as IVMRSurface ptr) as ULONG
	IsSurfaceLocked as function(byval as IVMRSurface ptr) as HRESULT
	LockSurface as function(byval as IVMRSurface ptr, byval as BYTE ptr ptr) as HRESULT
	UnlockSurface as function(byval as IVMRSurface ptr) as HRESULT
	GetSurface as function(byval as IVMRSurface ptr, byval as LPDIRECTDRAWSURFACE7 ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IVMRSurface_IsSurfaceLocked_Proxy alias "IVMRSurface_IsSurfaceLocked_Proxy" (byval This as IVMRSurface ptr) as HRESULT
declare sub IVMRSurface_IsSurfaceLocked_Stub alias "IVMRSurface_IsSurfaceLocked_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRSurface_LockSurface_Proxy alias "IVMRSurface_LockSurface_Proxy" (byval This as IVMRSurface ptr, byval lpSurface as BYTE ptr ptr) as HRESULT
declare sub IVMRSurface_LockSurface_Stub alias "IVMRSurface_LockSurface_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRSurface_UnlockSurface_Proxy alias "IVMRSurface_UnlockSurface_Proxy" (byval This as IVMRSurface ptr) as HRESULT
declare sub IVMRSurface_UnlockSurface_Stub alias "IVMRSurface_UnlockSurface_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRSurface_GetSurface_Proxy alias "IVMRSurface_GetSurface_Proxy" (byval This as IVMRSurface ptr, byval lplpSurface as LPDIRECTDRAWSURFACE7 ptr) as HRESULT
declare sub IVMRSurface_GetSurface_Stub alias "IVMRSurface_GetSurface_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IVMRImagePresenterConfig alias "IID_IVMRImagePresenterConfig" as IID

type IVMRImagePresenterConfigVtbl_ as IVMRImagePresenterConfigVtbl

type IVMRImagePresenterConfig
	lpVtbl as IVMRImagePresenterConfigVtbl_ ptr
end type

type IVMRImagePresenterConfigVtbl
	QueryInterface as function(byval as IVMRImagePresenterConfig ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IVMRImagePresenterConfig ptr) as ULONG
	Release as function(byval as IVMRImagePresenterConfig ptr) as ULONG
	SetRenderingPrefs as function(byval as IVMRImagePresenterConfig ptr, byval as DWORD) as HRESULT
	GetRenderingPrefs as function(byval as IVMRImagePresenterConfig ptr, byval as DWORD ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IVMRImagePresenterConfig_SetRenderingPrefs_Proxy alias "IVMRImagePresenterConfig_SetRenderingPrefs_Proxy" (byval This as IVMRImagePresenterConfig ptr, byval dwRenderFlags as DWORD) as HRESULT
declare sub IVMRImagePresenterConfig_SetRenderingPrefs_Stub alias "IVMRImagePresenterConfig_SetRenderingPrefs_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRImagePresenterConfig_GetRenderingPrefs_Proxy alias "IVMRImagePresenterConfig_GetRenderingPrefs_Proxy" (byval This as IVMRImagePresenterConfig ptr, byval dwRenderFlags as DWORD ptr) as HRESULT
declare sub IVMRImagePresenterConfig_GetRenderingPrefs_Stub alias "IVMRImagePresenterConfig_GetRenderingPrefs_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IVMRImagePresenterExclModeConfig alias "IID_IVMRImagePresenterExclModeConfig" as IID

type IVMRImagePresenterExclModeConfigVtbl_ as IVMRImagePresenterExclModeConfigVtbl

type IVMRImagePresenterExclModeConfig
	lpVtbl as IVMRImagePresenterExclModeConfigVtbl_ ptr
end type

type IVMRImagePresenterExclModeConfigVtbl
	QueryInterface as function(byval as IVMRImagePresenterExclModeConfig ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IVMRImagePresenterExclModeConfig ptr) as ULONG
	Release as function(byval as IVMRImagePresenterExclModeConfig ptr) as ULONG
	SetRenderingPrefs as function(byval as IVMRImagePresenterExclModeConfig ptr, byval as DWORD) as HRESULT
	GetRenderingPrefs as function(byval as IVMRImagePresenterExclModeConfig ptr, byval as DWORD ptr) as HRESULT
	SetXlcModeDDObjAndPrimarySurface as function(byval as IVMRImagePresenterExclModeConfig ptr, byval as LPDIRECTDRAW7, byval as LPDIRECTDRAWSURFACE7) as HRESULT
	GetXlcModeDDObjAndPrimarySurface as function(byval as IVMRImagePresenterExclModeConfig ptr, byval as LPDIRECTDRAW7 ptr, byval as LPDIRECTDRAWSURFACE7 ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IVMRImagePresenterExclModeConfig_SetXlcModeDDObjAndPrimarySurface_Proxy alias "IVMRImagePresenterExclModeConfig_SetXlcModeDDObjAndPrimarySurface_Proxy" (byval This as IVMRImagePresenterExclModeConfig ptr, byval lpDDObj as LPDIRECTDRAW7, byval lpPrimarySurf as LPDIRECTDRAWSURFACE7) as HRESULT
declare sub IVMRImagePresenterExclModeConfig_SetXlcModeDDObjAndPrimarySurface_Stub alias "IVMRImagePresenterExclModeConfig_SetXlcModeDDObjAndPrimarySurface_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVMRImagePresenterExclModeConfig_GetXlcModeDDObjAndPrimarySurface_Proxy alias "IVMRImagePresenterExclModeConfig_GetXlcModeDDObjAndPrimarySurface_Proxy" (byval This as IVMRImagePresenterExclModeConfig ptr, byval lpDDObj as LPDIRECTDRAW7 ptr, byval lpPrimarySurf as LPDIRECTDRAWSURFACE7 ptr) as HRESULT
declare sub IVMRImagePresenterExclModeConfig_GetXlcModeDDObjAndPrimarySurface_Stub alias "IVMRImagePresenterExclModeConfig_GetXlcModeDDObjAndPrimarySurface_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#endif
extern IID_IVPManager alias "IID_IVPManager" as IID

type IVPManagerVtbl_ as IVPManagerVtbl

type IVPManager
	lpVtbl as IVPManagerVtbl_ ptr
end type

type IVPManagerVtbl
	QueryInterface as function(byval as IVPManager ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function(byval as IVPManager ptr) as ULONG
	Release as function(byval as IVPManager ptr) as ULONG
	SetVideoPortIndex as function(byval as IVPManager ptr, byval as DWORD) as HRESULT
	GetVideoPortIndex as function(byval as IVPManager ptr, byval as DWORD ptr) as HRESULT
end type

#ifdef WIN_INCLUDEPROXY
declare function IVPManager_SetVideoPortIndex_Proxy alias "IVPManager_SetVideoPortIndex_Proxy" (byval This as IVPManager ptr, byval dwVideoPortIndex as DWORD) as HRESULT
declare sub IVPManager_SetVideoPortIndex_Stub alias "IVPManager_SetVideoPortIndex_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IVPManager_GetVideoPortIndex_Proxy alias "IVPManager_GetVideoPortIndex_Proxy" (byval This as IVPManager ptr, byval pdwVideoPortIndex as DWORD ptr) as HRESULT
declare sub IVPManager_GetVideoPortIndex_Stub alias "IVPManager_GetVideoPortIndex_Stub" (byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ICaptureGraphBuilder_FindInterface_Proxy alias "ICaptureGraphBuilder_FindInterface_Proxy" (byval This as ICaptureGraphBuilder ptr, byval pCategory as GUID ptr, byval pf as IBaseFilter ptr, byval riid as IID ptr, byval ppint as any ptr ptr) as HRESULT
declare function ICaptureGraphBuilder_FindInterface_Stub alias "ICaptureGraphBuilder_FindInterface_Stub" (byval This as ICaptureGraphBuilder ptr, byval pCategory as GUID ptr, byval pf as IBaseFilter ptr, byval riid as IID ptr, byval ppint as IUnknown ptr ptr) as HRESULT
declare function ICaptureGraphBuilder2_FindInterface_Proxy alias "ICaptureGraphBuilder2_FindInterface_Proxy" (byval This as ICaptureGraphBuilder2 ptr, byval pCategory as GUID ptr, byval pType as GUID ptr, byval pf as IBaseFilter ptr, byval riid as IID ptr, byval ppint as any ptr ptr) as HRESULT
declare function ICaptureGraphBuilder2_FindInterface_Stub alias "ICaptureGraphBuilder2_FindInterface_Stub" (byval This as ICaptureGraphBuilder2 ptr, byval pCategory as GUID ptr, byval pType as GUID ptr, byval pf as IBaseFilter ptr, byval riid as IID ptr, byval ppint as IUnknown ptr ptr) as HRESULT
declare function IKsPropertySet_Set_Proxy alias "IKsPropertySet_Set_Proxy" (byval This as IKsPropertySet ptr, byval guidPropSet as GUID ptr, byval dwPropID as DWORD, byval pInstanceData as LPVOID, byval cbInstanceData as DWORD, byval pPropData as LPVOID, byval cbPropData as DWORD) as HRESULT
declare function IKsPropertySet_Set_Stub alias "IKsPropertySet_Set_Stub" (byval This as IKsPropertySet ptr, byval guidPropSet as GUID ptr, byval dwPropID as DWORD, byval pInstanceData as byte ptr, byval cbInstanceData as DWORD, byval pPropData as byte ptr, byval cbPropData as DWORD) as HRESULT
declare function IKsPropertySet_Get_Proxy alias "IKsPropertySet_Get_Proxy" (byval This as IKsPropertySet ptr, byval guidPropSet as GUID ptr, byval dwPropID as DWORD, byval pInstanceData as LPVOID, byval cbInstanceData as DWORD, byval pPropData as LPVOID, byval cbPropData as DWORD, byval pcbReturned as DWORD ptr) as HRESULT
declare function IKsPropertySet_Get_Stub alias "IKsPropertySet_Get_Stub" (byval This as IKsPropertySet ptr, byval guidPropSet as GUID ptr, byval dwPropID as DWORD, byval pInstanceData as byte ptr, byval cbInstanceData as DWORD, byval pPropData as byte ptr, byval cbPropData as DWORD, byval pcbReturned as DWORD ptr) as HRESULT
#endif

declare function VARIANT_UserSize alias "VARIANT_UserSize" (byval as uinteger ptr, byval as uinteger, byval as VARIANT ptr) as uinteger
declare function VARIANT_UserMarshal alias "VARIANT_UserMarshal" (byval as uinteger ptr, byval as ubyte ptr, byval as VARIANT ptr) as ubyte ptr
declare function VARIANT_UserUnmarshal alias "VARIANT_UserUnmarshal" (byval as uinteger ptr, byval as ubyte ptr, byval as VARIANT ptr) as ubyte ptr
declare sub VARIANT_UserFree alias "VARIANT_UserFree" (byval as uinteger ptr, byval as VARIANT ptr)

#endif
