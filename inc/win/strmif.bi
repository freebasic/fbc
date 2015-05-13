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

#inclib "strmiids"

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
	pbFormat as UBYTE ptr
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
	GetPointer as function(byval as IMediaSample ptr, byval as UBYTE ptr ptr) as HRESULT
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
	pbBuffer as UBYTE ptr
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
	GetPointer as function(byval as IMediaSample2 ptr, byval as UBYTE ptr ptr) as HRESULT
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
	GetProperties as function(byval as IMediaSample2 ptr, byval as DWORD, byval as UBYTE ptr) as HRESULT
	SetProperties as function(byval as IMediaSample2 ptr, byval as DWORD, byval as UBYTE ptr) as HRESULT
end type

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

#define IMediaSeeking_QueryInterface(This,riid,ppvObject) (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)
#define IMediaSeeking_AddRef(This) (This)->lpVtbl -> AddRef(This)
#define IMediaSeeking_Release(This) (This)->lpVtbl -> Release(This)
#define IMediaSeeking_GetCapabilities(This,pCapabilities) (This)->lpVtbl -> GetCapabilities(This,pCapabilities)
#define IMediaSeeking_CheckCapabilities(This,pCapabilities) (This)->lpVtbl -> CheckCapabilities(This,pCapabilities)
#define IMediaSeeking_IsFormatSupported(This,pFormat) (This)->lpVtbl -> IsFormatSupported(This,pFormat)
#define IMediaSeeking_QueryPreferredFormat(This,pFormat) (This)->lpVtbl -> QueryPreferredFormat(This,pFormat)
#define IMediaSeeking_GetTimeFormat(This,pFormat) (This)->lpVtbl -> GetTimeFormat(This,pFormat)
#define IMediaSeeking_IsUsingTimeFormat(This,pFormat) (This)->lpVtbl -> IsUsingTimeFormat(This,pFormat)
#define IMediaSeeking_SetTimeFormat(This,pFormat) (This)->lpVtbl -> SetTimeFormat(This,pFormat)
#define IMediaSeeking_GetDuration(This,pDuration) (This)->lpVtbl -> GetDuration(This,pDuration)
#define IMediaSeeking_GetStopPosition(This,pStop) (This)->lpVtbl -> GetStopPosition(This,pStop)
#define IMediaSeeking_GetCurrentPosition(This,pCurrent) (This)->lpVtbl -> GetCurrentPosition(This,pCurrent)
#define IMediaSeeking_ConvertTimeFormat(This,pTarget,pTargetFormat,Source,pSourceFormat) (This)->lpVtbl -> ConvertTimeFormat(This,pTarget,pTargetFormat,Source,pSourceFormat)
#define IMediaSeeking_SetPositions(This,pCurrent,dwCurrentFlags,pStop,dwStopFlags) (This)->lpVtbl -> SetPositions(This,pCurrent,dwCurrentFlags,pStop,dwStopFlags)
#define IMediaSeeking_GetPositions(This,pCurrent,pStop) (This)->lpVtbl -> GetPositions(This,pCurrent,pStop)
#define IMediaSeeking_GetAvailable(This,pEarliest,pLatest) (This)->lpVtbl -> GetAvailable(This,pEarliest,pLatest)
#define IMediaSeeking_SetRate(This,dRate) (This)->lpVtbl -> SetRate(This,dRate)
#define IMediaSeeking_GetRate(This,pdRate) (This)->lpVtbl -> GetRate(This,pdRate)
#define IMediaSeeking_GetPreroll(This,pllPreroll) (This)->lpVtbl -> GetPreroll(This,pllPreroll)

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

#define IGraphBuilder_QueryInterface(This,riid,ppvObject) (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)
#define IGraphBuilder_AddRef(This) (This)->lpVtbl -> AddRef(This)
#define IGraphBuilder_Release(This) (This)->lpVtbl -> Release(This)
#define IGraphBuilder_AddFilter(This,pFilter,pName) (This)->lpVtbl -> AddFilter(This,pFilter,pName)
#define IGraphBuilder_RemoveFilter(This,pFilter) (This)->lpVtbl -> RemoveFilter(This,pFilter)
#define IGraphBuilder_EnumFilters(This,ppEnum) (This)->lpVtbl -> EnumFilters(This,ppEnum)
#define IGraphBuilder_FindFilterByName(This,pName,ppFilter) (This)->lpVtbl -> FindFilterByName(This,pName,ppFilter)
#define IGraphBuilder_ConnectDirect(This,ppinOut,ppinIn,pmt) (This)->lpVtbl -> ConnectDirect(This,ppinOut,ppinIn,pmt)
#define IGraphBuilder_Reconnect(This,ppin) (This)->lpVtbl -> Reconnect(This,ppin)
#define IGraphBuilder_Disconnect(This,ppin) (This)->lpVtbl -> Disconnect(This,ppin)
#define IGraphBuilder_SetDefaultSyncSource(This) (This)->lpVtbl -> SetDefaultSyncSource(This)
#define IGraphBuilder_Connect(This,ppinOut,ppinIn) (This)->lpVtbl -> Connect(This,ppinOut,ppinIn)
#define IGraphBuilder_Render(This,ppinOut) (This)->lpVtbl -> Render(This,ppinOut)
#define IGraphBuilder_RenderFile(This,lpcwstrFile,lpcwstrPlayList) (This)->lpVtbl -> RenderFile(This,lpcwstrFile,lpcwstrPlayList)
#define IGraphBuilder_AddSourceFilter(This,lpcwstrFileName,lpcwstrFilterName,ppFilter) (This)->lpVtbl -> AddSourceFilter(This,lpcwstrFileName,lpcwstrFilterName,ppFilter)
#define IGraphBuilder_SetLogFile(This,hFile) (This)->lpVtbl -> SetLogFile(This,hFile)
#define IGraphBuilder_Abort(This) (This)->lpVtbl -> Abort(This)
#define IGraphBuilder_ShouldOperationContinue(This) (This)->lpVtbl -> ShouldOperationContinue(This)

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
	SyncRead as function(byval as IAsyncReader ptr, byval as LONGLONG, byval as LONG, byval as UBYTE ptr) as HRESULT
	Length as function(byval as IAsyncReader ptr, byval as LONGLONG ptr, byval as LONGLONG ptr) as HRESULT
	BeginFlush as function(byval as IAsyncReader ptr) as HRESULT
	EndFlush as function(byval as IAsyncReader ptr) as HRESULT
end type


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
	GetStreamCaps as function(byval as IAMStreamConfig ptr, byval as integer, byval as AM_MEDIA_TYPE ptr ptr, byval as UBYTE ptr) as HRESULT
end type

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
	Read as function(byval as IMediaPropertyBag ptr, byval as LPCOLESTR, byval as VARIANT_ ptr, byval as IErrorLog ptr) as HRESULT
	Write as function(byval as IMediaPropertyBag ptr, byval as LPCOLESTR, byval as VARIANT_ ptr) as HRESULT
	EnumProperty as function(byval as IMediaPropertyBag ptr, byval as ULONG, byval as VARIANT_ ptr, byval as VARIANT_ ptr) as HRESULT
end type

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
	CheckMemory as function(byval as IAMDevMemoryAllocator ptr, byval as UBYTE ptr) as HRESULT
	Alloc as function(byval as IAMDevMemoryAllocator ptr, byval as UBYTE ptr ptr, byval as DWORD ptr) as HRESULT
	Free as function(byval as IAMDevMemoryAllocator ptr, byval as UBYTE ptr) as HRESULT
	GetDevMemoryObject as function(byval as IAMDevMemoryAllocator ptr, byval as IUnknown ptr ptr, byval as IUnknown ptr) as HRESULT
end type

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
	get_IFormatResolution as function(byval as IDVEnc ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr, byval as UBYTE, byval as DVINFO ptr) as HRESULT
	put_IFormatResolution as function(byval as IDVEnc ptr, byval as integer, byval as integer, byval as integer, byval as UBYTE, byval as DVINFO ptr) as HRESULT
end type

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
	GetParameterRange as function(byval as ICodecAPI ptr, byval as GUID ptr, byval as VARIANT_ ptr, byval as VARIANT_ ptr, byval as VARIANT_ ptr) as HRESULT
	GetParameterValues as function(byval as ICodecAPI ptr, byval as GUID ptr, byval as VARIANT_ ptr ptr, byval as ULONG ptr) as HRESULT
	GetDefaultValue as function(byval as ICodecAPI ptr, byval as GUID ptr, byval as VARIANT_ ptr) as HRESULT
	GetValue as function(byval as ICodecAPI ptr, byval as GUID ptr, byval as VARIANT_ ptr) as HRESULT
	SetValue as function(byval as ICodecAPI ptr, byval as GUID ptr, byval as VARIANT_ ptr) as HRESULT
	RegisterForEvent as function(byval as ICodecAPI ptr, byval as GUID ptr, byval as LONG_PTR) as HRESULT
	UnregisterForEvent as function(byval as ICodecAPI ptr, byval as GUID ptr) as HRESULT
	SetAllDefaults as function(byval as ICodecAPI ptr) as HRESULT
	SetValueWithNotify as function(byval as ICodecAPI ptr, byval as GUID ptr, byval as VARIANT_ ptr, byval as GUID ptr ptr, byval as ULONG ptr) as HRESULT
	SetAllDefaultsWithNotify as function(byval as ICodecAPI ptr, byval as GUID ptr ptr, byval as ULONG ptr) as HRESULT
	GetAllSettings as function(byval as ICodecAPI ptr, byval as IStream ptr) as HRESULT
	SetAllSettings as function(byval as ICodecAPI ptr, byval as IStream ptr) as HRESULT
	SetAllSettingsWithNotify as function(byval as ICodecAPI ptr, byval as IStream ptr, byval as GUID ptr ptr, byval as ULONG ptr) as HRESULT
end type

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
	GetParameterRange as function(byval as IEncoderAPI ptr, byval as GUID ptr, byval as VARIANT_ ptr, byval as VARIANT_ ptr, byval as VARIANT_ ptr) as HRESULT
	GetParameterValues as function(byval as IEncoderAPI ptr, byval as GUID ptr, byval as VARIANT_ ptr ptr, byval as ULONG ptr) as HRESULT
	GetDefaultValue as function(byval as IEncoderAPI ptr, byval as GUID ptr, byval as VARIANT_ ptr) as HRESULT
	GetValue as function(byval as IEncoderAPI ptr, byval as GUID ptr, byval as VARIANT_ ptr) as HRESULT
	SetValue as function(byval as IEncoderAPI ptr, byval as GUID ptr, byval as VARIANT_ ptr) as HRESULT
end type

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
	GetParameterRange as function(byval as IVideoEncoder ptr, byval as GUID ptr, byval as VARIANT_ ptr, byval as VARIANT_ ptr, byval as VARIANT_ ptr) as HRESULT
	GetParameterValues as function(byval as IVideoEncoder ptr, byval as GUID ptr, byval as VARIANT_ ptr ptr, byval as ULONG ptr) as HRESULT
	GetDefaultValue as function(byval as IVideoEncoder ptr, byval as GUID ptr, byval as VARIANT_ ptr) as HRESULT
	GetValue as function(byval as IVideoEncoder ptr, byval as GUID ptr, byval as VARIANT_ ptr) as HRESULT
	SetValue as function(byval as IVideoEncoder ptr, byval as GUID ptr, byval as VARIANT_ ptr) as HRESULT
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
	pbATRI(0 to 768-1) as UBYTE
end type

type DVD_VideoATR as UBYTE ptr
type DVD_AudioATR as UBYTE ptr
type DVD_SubpictureATR as UBYTE ptr

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
	bHours as UBYTE
	bMinutes as UBYTE
	bSeconds as UBYTE
	bFrames as UBYTE
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
	AppModeData as UBYTE
	AudioFormat as DVD_AUDIO_FORMAT
	Language as LCID
	LanguageExtension as DVD_AUDIO_LANG_EXT
	fHasMultichannelInfo as BOOL
	dwFrequency as DWORD
	bQuantization as UBYTE
	bNumberOfChannels as UBYTE
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
	bVersion as UBYTE
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
	GetDVDTextInfo as function(byval as IDvdInfo ptr, byval as UBYTE ptr, byval as ULONG, byval as ULONG ptr) as HRESULT
	GetPlayerParentalLevel as function(byval as IDvdInfo ptr, byval as ULONG ptr, byval as ULONG ptr) as HRESULT
	GetNumberOfChapters as function(byval as IDvdInfo ptr, byval as ULONG, byval as ULONG ptr) as HRESULT
	GetTitleParentalLevels as function(byval as IDvdInfo ptr, byval as ULONG, byval as ULONG ptr) as HRESULT
	GetRoot as function(byval as IDvdInfo ptr, byval as LPSTR, byval as ULONG, byval as ULONG ptr) as HRESULT
end type

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
	SelectParentalCountry as function(byval as IDvdControl2 ptr, byval as UBYTE ptr) as HRESULT
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
	GetDVDTextStringAsNative as function(byval as IDvdInfo2 ptr, byval as ULONG, byval as ULONG, byval as UBYTE ptr, byval as ULONG, byval as ULONG ptr, byval as DVD_TextStringType ptr) as HRESULT
	GetDVDTextStringAsUnicode as function(byval as IDvdInfo2 ptr, byval as ULONG, byval as ULONG, byval as WCHAR ptr, byval as ULONG, byval as ULONG ptr, byval as DVD_TextStringType ptr) as HRESULT
	GetPlayerParentalLevel as function(byval as IDvdInfo2 ptr, byval as ULONG ptr, byval as UBYTE ptr) as HRESULT
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
	GetCurrentImage as function(byval as IVMRWindowlessControl ptr, byval as UBYTE ptr ptr) as HRESULT
	SetBorderColor as function(byval as IVMRWindowlessControl ptr, byval as COLORREF) as HRESULT
	GetBorderColor as function(byval as IVMRWindowlessControl ptr, byval as COLORREF ptr) as HRESULT
	SetColorKey as function(byval as IVMRWindowlessControl ptr, byval as COLORREF) as HRESULT
	GetColorKey as function(byval as IVMRWindowlessControl ptr, byval as COLORREF ptr) as HRESULT
end type

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
	LockSurface as function(byval as IVMRSurface ptr, byval as UBYTE ptr ptr) as HRESULT
	UnlockSurface as function(byval as IVMRSurface ptr) as HRESULT
	GetSurface as function(byval as IVMRSurface ptr, byval as LPDIRECTDRAWSURFACE7 ptr) as HRESULT
end type

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

declare function VARIANT_UserSize alias "VARIANT_UserSize" (byval as uinteger ptr, byval as uinteger, byval as VARIANT_ ptr) as uinteger
declare function VARIANT_UserMarshal alias "VARIANT_UserMarshal" (byval as uinteger ptr, byval as ubyte ptr, byval as VARIANT_ ptr) as ubyte ptr
declare function VARIANT_UserUnmarshal alias "VARIANT_UserUnmarshal" (byval as uinteger ptr, byval as ubyte ptr, byval as VARIANT_ ptr) as ubyte ptr
declare sub VARIANT_UserFree alias "VARIANT_UserFree" (byval as uinteger ptr, byval as VARIANT_ ptr)

#endif
