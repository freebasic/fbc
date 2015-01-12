#pragma once

#include once "rpc.bi"
#include once "rpcndr.bi"
#include once "windows.bi"
#include once "ole2.bi"
#include once "objidl.bi"
#include once "ddraw.bi"

extern "Windows"

type IDirectDrawVideo as IDirectDrawVideo_
type IQualProp as IQualProp_
type IFullScreenVideo as IFullScreenVideo_
type IFullScreenVideoEx as IFullScreenVideoEx_
type IBaseVideoMixer as IBaseVideoMixer_

#define __amvideo_h__
#define __IDirectDrawVideo_FWD_DEFINED__
#define __IQualProp_FWD_DEFINED__
#define __IFullScreenVideo_FWD_DEFINED__
#define __IFullScreenVideoEx_FWD_DEFINED__
#define __IBaseVideoMixer_FWD_DEFINED__
#define AMDDS_NONE &h00
#define AMDDS_DCIPS &h01
#define AMDDS_PS &h02
#define AMDDS_RGBOVR &h04
#define AMDDS_YUVOVR &h08
#define AMDDS_RGBOFF &h10
#define AMDDS_YUVOFF &h20
#define AMDDS_RGBFLP &h40
#define AMDDS_YUVFLP &h80
#define AMDDS_ALL &hFF
#define AMDDS_DEFAULT AMDDS_ALL
#define AMDDS_YUV ((AMDDS_YUVOFF or AMDDS_YUVOVR) or AMDDS_YUVFLP)
#define AMDDS_RGB ((AMDDS_RGBOFF or AMDDS_RGBOVR) or AMDDS_RGBFLP)
#define AMDSS_PRIMARY (AMDDS_DCIPS or AMDDS_PS)
#define __IDirectDrawVideo_INTERFACE_DEFINED__

type IDirectDrawVideoVtbl
	QueryInterface as function(byval This as IDirectDrawVideo ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectDrawVideo ptr) as ULONG
	Release as function(byval This as IDirectDrawVideo ptr) as ULONG
	GetSwitches as function(byval This as IDirectDrawVideo ptr, byval pSwitches as DWORD ptr) as HRESULT
	SetSwitches as function(byval This as IDirectDrawVideo ptr, byval Switches as DWORD) as HRESULT
	GetCaps as function(byval This as IDirectDrawVideo ptr, byval pCaps as DDCAPS ptr) as HRESULT
	GetEmulatedCaps as function(byval This as IDirectDrawVideo ptr, byval pCaps as DDCAPS ptr) as HRESULT
	GetSurfaceDesc as function(byval This as IDirectDrawVideo ptr, byval pSurfaceDesc as DDSURFACEDESC ptr) as HRESULT
	GetFourCCCodes as function(byval This as IDirectDrawVideo ptr, byval pCount as DWORD ptr, byval pCodes as DWORD ptr) as HRESULT
	SetDirectDraw as function(byval This as IDirectDrawVideo ptr, byval ddraw as IDirectDraw ptr) as HRESULT
	GetDirectDraw as function(byval This as IDirectDrawVideo ptr, byval ddraw as IDirectDraw ptr ptr) as HRESULT
	GetSurfaceType as function(byval This as IDirectDrawVideo ptr, byval pSurfaceType as DWORD ptr) as HRESULT
	SetDefault as function(byval This as IDirectDrawVideo ptr) as HRESULT
	UseScanLine as function(byval This as IDirectDrawVideo ptr, byval UseScanLine as LONG) as HRESULT
	CanUseScanLine as function(byval This as IDirectDrawVideo ptr, byval UseScanLine as LONG ptr) as HRESULT
	UseOverlayStretch as function(byval This as IDirectDrawVideo ptr, byval UseOverlayStretch as LONG) as HRESULT
	CanUseOverlayStretch as function(byval This as IDirectDrawVideo ptr, byval UseOverlayStretch as LONG ptr) as HRESULT
	UseWhenFullScreen as function(byval This as IDirectDrawVideo ptr, byval UseWhenFullScreen as LONG) as HRESULT
	WillUseFullScreen as function(byval This as IDirectDrawVideo ptr, byval UseWhenFullScreen as LONG ptr) as HRESULT
end type

type IDirectDrawVideo_
	lpVtbl as IDirectDrawVideoVtbl ptr
end type

declare function IDirectDrawVideo_GetSwitches_Proxy(byval This as IDirectDrawVideo ptr, byval pSwitches as DWORD ptr) as HRESULT
declare sub IDirectDrawVideo_GetSwitches_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDirectDrawVideo_SetSwitches_Proxy(byval This as IDirectDrawVideo ptr, byval Switches as DWORD) as HRESULT
declare sub IDirectDrawVideo_SetSwitches_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDirectDrawVideo_GetCaps_Proxy(byval This as IDirectDrawVideo ptr, byval pCaps as DDCAPS ptr) as HRESULT
declare sub IDirectDrawVideo_GetCaps_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDirectDrawVideo_GetEmulatedCaps_Proxy(byval This as IDirectDrawVideo ptr, byval pCaps as DDCAPS ptr) as HRESULT
declare sub IDirectDrawVideo_GetEmulatedCaps_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDirectDrawVideo_GetSurfaceDesc_Proxy(byval This as IDirectDrawVideo ptr, byval pSurfaceDesc as DDSURFACEDESC ptr) as HRESULT
declare sub IDirectDrawVideo_GetSurfaceDesc_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDirectDrawVideo_GetFourCCCodes_Proxy(byval This as IDirectDrawVideo ptr, byval pCount as DWORD ptr, byval pCodes as DWORD ptr) as HRESULT
declare sub IDirectDrawVideo_GetFourCCCodes_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDirectDrawVideo_SetDirectDraw_Proxy(byval This as IDirectDrawVideo ptr, byval ddraw as IDirectDraw ptr) as HRESULT
declare sub IDirectDrawVideo_SetDirectDraw_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDirectDrawVideo_GetDirectDraw_Proxy(byval This as IDirectDrawVideo ptr, byval ddraw as IDirectDraw ptr ptr) as HRESULT
declare sub IDirectDrawVideo_GetDirectDraw_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDirectDrawVideo_GetSurfaceType_Proxy(byval This as IDirectDrawVideo ptr, byval pSurfaceType as DWORD ptr) as HRESULT
declare sub IDirectDrawVideo_GetSurfaceType_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDirectDrawVideo_SetDefault_Proxy(byval This as IDirectDrawVideo ptr) as HRESULT
declare sub IDirectDrawVideo_SetDefault_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDirectDrawVideo_UseScanLine_Proxy(byval This as IDirectDrawVideo ptr, byval UseScanLine as LONG) as HRESULT
declare sub IDirectDrawVideo_UseScanLine_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDirectDrawVideo_CanUseScanLine_Proxy(byval This as IDirectDrawVideo ptr, byval UseScanLine as LONG ptr) as HRESULT
declare sub IDirectDrawVideo_CanUseScanLine_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDirectDrawVideo_UseOverlayStretch_Proxy(byval This as IDirectDrawVideo ptr, byval UseOverlayStretch as LONG) as HRESULT
declare sub IDirectDrawVideo_UseOverlayStretch_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDirectDrawVideo_CanUseOverlayStretch_Proxy(byval This as IDirectDrawVideo ptr, byval UseOverlayStretch as LONG ptr) as HRESULT
declare sub IDirectDrawVideo_CanUseOverlayStretch_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDirectDrawVideo_UseWhenFullScreen_Proxy(byval This as IDirectDrawVideo ptr, byval UseWhenFullScreen as LONG) as HRESULT
declare sub IDirectDrawVideo_UseWhenFullScreen_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDirectDrawVideo_WillUseFullScreen_Proxy(byval This as IDirectDrawVideo ptr, byval UseWhenFullScreen as LONG ptr) as HRESULT
declare sub IDirectDrawVideo_WillUseFullScreen_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IQualProp_INTERFACE_DEFINED__

type IQualPropVtbl
	QueryInterface as function(byval This as IQualProp ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IQualProp ptr) as ULONG
	Release as function(byval This as IQualProp ptr) as ULONG
	get_FramesDroppedInRenderer as function(byval This as IQualProp ptr, byval pcFrames as long ptr) as HRESULT
	get_FramesDrawn as function(byval This as IQualProp ptr, byval pcFramesDrawn as long ptr) as HRESULT
	get_AvgFrameRate as function(byval This as IQualProp ptr, byval piAvgFrameRate as long ptr) as HRESULT
	get_Jitter as function(byval This as IQualProp ptr, byval iJitter as long ptr) as HRESULT
	get_AvgSyncOffset as function(byval This as IQualProp ptr, byval piAvg as long ptr) as HRESULT
	get_DevSyncOffset as function(byval This as IQualProp ptr, byval piDev as long ptr) as HRESULT
end type

type IQualProp_
	lpVtbl as IQualPropVtbl ptr
end type

declare function IQualProp_get_FramesDroppedInRenderer_Proxy(byval This as IQualProp ptr, byval pcFrames as long ptr) as HRESULT
declare sub IQualProp_get_FramesDroppedInRenderer_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IQualProp_get_FramesDrawn_Proxy(byval This as IQualProp ptr, byval pcFramesDrawn as long ptr) as HRESULT
declare sub IQualProp_get_FramesDrawn_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IQualProp_get_AvgFrameRate_Proxy(byval This as IQualProp ptr, byval piAvgFrameRate as long ptr) as HRESULT
declare sub IQualProp_get_AvgFrameRate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IQualProp_get_Jitter_Proxy(byval This as IQualProp ptr, byval iJitter as long ptr) as HRESULT
declare sub IQualProp_get_Jitter_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IQualProp_get_AvgSyncOffset_Proxy(byval This as IQualProp ptr, byval piAvg as long ptr) as HRESULT
declare sub IQualProp_get_AvgSyncOffset_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IQualProp_get_DevSyncOffset_Proxy(byval This as IQualProp ptr, byval piDev as long ptr) as HRESULT
declare sub IQualProp_get_DevSyncOffset_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IFullScreenVideo_INTERFACE_DEFINED__

type IFullScreenVideoVtbl
	QueryInterface as function(byval This as IFullScreenVideo ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IFullScreenVideo ptr) as ULONG
	Release as function(byval This as IFullScreenVideo ptr) as ULONG
	CountModes as function(byval This as IFullScreenVideo ptr, byval pModes as LONG ptr) as HRESULT
	GetModeInfo as function(byval This as IFullScreenVideo ptr, byval Mode as LONG, byval pWidth as LONG ptr, byval pHeight as LONG ptr, byval pDepth as LONG ptr) as HRESULT
	GetCurrentMode as function(byval This as IFullScreenVideo ptr, byval pMode as LONG ptr) as HRESULT
	IsModeAvailable as function(byval This as IFullScreenVideo ptr, byval Mode as LONG) as HRESULT
	IsModeEnabled as function(byval This as IFullScreenVideo ptr, byval Mode as LONG) as HRESULT
	SetEnabled as function(byval This as IFullScreenVideo ptr, byval Mode as LONG, byval bEnabled as LONG) as HRESULT
	GetClipFactor as function(byval This as IFullScreenVideo ptr, byval pClipFactor as LONG ptr) as HRESULT
	SetClipFactor as function(byval This as IFullScreenVideo ptr, byval ClipFactor as LONG) as HRESULT
	SetMessageDrain as function(byval This as IFullScreenVideo ptr, byval hwnd as HWND) as HRESULT
	GetMessageDrain as function(byval This as IFullScreenVideo ptr, byval hwnd as HWND ptr) as HRESULT
	SetMonitor as function(byval This as IFullScreenVideo ptr, byval Monitor as LONG) as HRESULT
	GetMonitor as function(byval This as IFullScreenVideo ptr, byval Monitor as LONG ptr) as HRESULT
	HideOnDeactivate as function(byval This as IFullScreenVideo ptr, byval Hide as LONG) as HRESULT
	IsHideOnDeactivate as function(byval This as IFullScreenVideo ptr) as HRESULT
	SetCaption as function(byval This as IFullScreenVideo ptr, byval strCaption as BSTR) as HRESULT
	GetCaption as function(byval This as IFullScreenVideo ptr, byval pstrCaption as BSTR ptr) as HRESULT
	SetDefault as function(byval This as IFullScreenVideo ptr) as HRESULT
end type

type IFullScreenVideo_
	lpVtbl as IFullScreenVideoVtbl ptr
end type

declare function IFullScreenVideo_CountModes_Proxy(byval This as IFullScreenVideo ptr, byval pModes as LONG ptr) as HRESULT
declare sub IFullScreenVideo_CountModes_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFullScreenVideo_GetModeInfo_Proxy(byval This as IFullScreenVideo ptr, byval Mode as LONG, byval pWidth as LONG ptr, byval pHeight as LONG ptr, byval pDepth as LONG ptr) as HRESULT
declare sub IFullScreenVideo_GetModeInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFullScreenVideo_GetCurrentMode_Proxy(byval This as IFullScreenVideo ptr, byval pMode as LONG ptr) as HRESULT
declare sub IFullScreenVideo_GetCurrentMode_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFullScreenVideo_IsModeAvailable_Proxy(byval This as IFullScreenVideo ptr, byval Mode as LONG) as HRESULT
declare sub IFullScreenVideo_IsModeAvailable_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFullScreenVideo_IsModeEnabled_Proxy(byval This as IFullScreenVideo ptr, byval Mode as LONG) as HRESULT
declare sub IFullScreenVideo_IsModeEnabled_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFullScreenVideo_SetEnabled_Proxy(byval This as IFullScreenVideo ptr, byval Mode as LONG, byval bEnabled as LONG) as HRESULT
declare sub IFullScreenVideo_SetEnabled_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFullScreenVideo_GetClipFactor_Proxy(byval This as IFullScreenVideo ptr, byval pClipFactor as LONG ptr) as HRESULT
declare sub IFullScreenVideo_GetClipFactor_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFullScreenVideo_SetClipFactor_Proxy(byval This as IFullScreenVideo ptr, byval ClipFactor as LONG) as HRESULT
declare sub IFullScreenVideo_SetClipFactor_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFullScreenVideo_SetMessageDrain_Proxy(byval This as IFullScreenVideo ptr, byval hwnd as HWND) as HRESULT
declare sub IFullScreenVideo_SetMessageDrain_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFullScreenVideo_GetMessageDrain_Proxy(byval This as IFullScreenVideo ptr, byval hwnd as HWND ptr) as HRESULT
declare sub IFullScreenVideo_GetMessageDrain_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFullScreenVideo_SetMonitor_Proxy(byval This as IFullScreenVideo ptr, byval Monitor as LONG) as HRESULT
declare sub IFullScreenVideo_SetMonitor_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFullScreenVideo_GetMonitor_Proxy(byval This as IFullScreenVideo ptr, byval Monitor as LONG ptr) as HRESULT
declare sub IFullScreenVideo_GetMonitor_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFullScreenVideo_HideOnDeactivate_Proxy(byval This as IFullScreenVideo ptr, byval Hide as LONG) as HRESULT
declare sub IFullScreenVideo_HideOnDeactivate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFullScreenVideo_IsHideOnDeactivate_Proxy(byval This as IFullScreenVideo ptr) as HRESULT
declare sub IFullScreenVideo_IsHideOnDeactivate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFullScreenVideo_SetCaption_Proxy(byval This as IFullScreenVideo ptr, byval strCaption as BSTR) as HRESULT
declare sub IFullScreenVideo_SetCaption_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFullScreenVideo_GetCaption_Proxy(byval This as IFullScreenVideo ptr, byval pstrCaption as BSTR ptr) as HRESULT
declare sub IFullScreenVideo_GetCaption_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFullScreenVideo_SetDefault_Proxy(byval This as IFullScreenVideo ptr) as HRESULT
declare sub IFullScreenVideo_SetDefault_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IFullScreenVideoEx_INTERFACE_DEFINED__

type IFullScreenVideoExVtbl
	QueryInterface as function(byval This as IFullScreenVideoEx ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IFullScreenVideoEx ptr) as ULONG
	Release as function(byval This as IFullScreenVideoEx ptr) as ULONG
	CountModes as function(byval This as IFullScreenVideoEx ptr, byval pModes as LONG ptr) as HRESULT
	GetModeInfo as function(byval This as IFullScreenVideoEx ptr, byval Mode as LONG, byval pWidth as LONG ptr, byval pHeight as LONG ptr, byval pDepth as LONG ptr) as HRESULT
	GetCurrentMode as function(byval This as IFullScreenVideoEx ptr, byval pMode as LONG ptr) as HRESULT
	IsModeAvailable as function(byval This as IFullScreenVideoEx ptr, byval Mode as LONG) as HRESULT
	IsModeEnabled as function(byval This as IFullScreenVideoEx ptr, byval Mode as LONG) as HRESULT
	SetEnabled as function(byval This as IFullScreenVideoEx ptr, byval Mode as LONG, byval bEnabled as LONG) as HRESULT
	GetClipFactor as function(byval This as IFullScreenVideoEx ptr, byval pClipFactor as LONG ptr) as HRESULT
	SetClipFactor as function(byval This as IFullScreenVideoEx ptr, byval ClipFactor as LONG) as HRESULT
	SetMessageDrain as function(byval This as IFullScreenVideoEx ptr, byval hwnd as HWND) as HRESULT
	GetMessageDrain as function(byval This as IFullScreenVideoEx ptr, byval hwnd as HWND ptr) as HRESULT
	SetMonitor as function(byval This as IFullScreenVideoEx ptr, byval Monitor as LONG) as HRESULT
	GetMonitor as function(byval This as IFullScreenVideoEx ptr, byval Monitor as LONG ptr) as HRESULT
	HideOnDeactivate as function(byval This as IFullScreenVideoEx ptr, byval Hide as LONG) as HRESULT
	IsHideOnDeactivate as function(byval This as IFullScreenVideoEx ptr) as HRESULT
	SetCaption as function(byval This as IFullScreenVideoEx ptr, byval strCaption as BSTR) as HRESULT
	GetCaption as function(byval This as IFullScreenVideoEx ptr, byval pstrCaption as BSTR ptr) as HRESULT
	SetDefault as function(byval This as IFullScreenVideoEx ptr) as HRESULT
	SetAcceleratorTable as function(byval This as IFullScreenVideoEx ptr, byval hwnd as HWND, byval hAccel as HACCEL) as HRESULT
	GetAcceleratorTable as function(byval This as IFullScreenVideoEx ptr, byval phwnd as HWND ptr, byval phAccel as HACCEL ptr) as HRESULT
	KeepPixelAspectRatio as function(byval This as IFullScreenVideoEx ptr, byval KeepAspect as LONG) as HRESULT
	IsKeepPixelAspectRatio as function(byval This as IFullScreenVideoEx ptr, byval pKeepAspect as LONG ptr) as HRESULT
end type

type IFullScreenVideoEx_
	lpVtbl as IFullScreenVideoExVtbl ptr
end type

declare function IFullScreenVideoEx_SetAcceleratorTable_Proxy(byval This as IFullScreenVideoEx ptr, byval hwnd as HWND, byval hAccel as HACCEL) as HRESULT
declare sub IFullScreenVideoEx_SetAcceleratorTable_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFullScreenVideoEx_GetAcceleratorTable_Proxy(byval This as IFullScreenVideoEx ptr, byval phwnd as HWND ptr, byval phAccel as HACCEL ptr) as HRESULT
declare sub IFullScreenVideoEx_GetAcceleratorTable_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFullScreenVideoEx_KeepPixelAspectRatio_Proxy(byval This as IFullScreenVideoEx ptr, byval KeepAspect as LONG) as HRESULT
declare sub IFullScreenVideoEx_KeepPixelAspectRatio_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFullScreenVideoEx_IsKeepPixelAspectRatio_Proxy(byval This as IFullScreenVideoEx ptr, byval pKeepAspect as LONG ptr) as HRESULT
declare sub IFullScreenVideoEx_IsKeepPixelAspectRatio_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IBaseVideoMixer_INTERFACE_DEFINED__

type IBaseVideoMixerVtbl
	QueryInterface as function(byval This as IBaseVideoMixer ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IBaseVideoMixer ptr) as ULONG
	Release as function(byval This as IBaseVideoMixer ptr) as ULONG
	SetLeadPin as function(byval This as IBaseVideoMixer ptr, byval iPin as long) as HRESULT
	GetLeadPin as function(byval This as IBaseVideoMixer ptr, byval piPin as long ptr) as HRESULT
	GetInputPinCount as function(byval This as IBaseVideoMixer ptr, byval piPinCount as long ptr) as HRESULT
	IsUsingClock as function(byval This as IBaseVideoMixer ptr, byval pbValue as long ptr) as HRESULT
	SetUsingClock as function(byval This as IBaseVideoMixer ptr, byval bValue as long) as HRESULT
	GetClockPeriod as function(byval This as IBaseVideoMixer ptr, byval pbValue as long ptr) as HRESULT
	SetClockPeriod as function(byval This as IBaseVideoMixer ptr, byval bValue as long) as HRESULT
end type

type IBaseVideoMixer_
	lpVtbl as IBaseVideoMixerVtbl ptr
end type

declare function IBaseVideoMixer_SetLeadPin_Proxy(byval This as IBaseVideoMixer ptr, byval iPin as long) as HRESULT
declare sub IBaseVideoMixer_SetLeadPin_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBaseVideoMixer_GetLeadPin_Proxy(byval This as IBaseVideoMixer ptr, byval piPin as long ptr) as HRESULT
declare sub IBaseVideoMixer_GetLeadPin_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBaseVideoMixer_GetInputPinCount_Proxy(byval This as IBaseVideoMixer ptr, byval piPinCount as long ptr) as HRESULT
declare sub IBaseVideoMixer_GetInputPinCount_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBaseVideoMixer_IsUsingClock_Proxy(byval This as IBaseVideoMixer ptr, byval pbValue as long ptr) as HRESULT
declare sub IBaseVideoMixer_IsUsingClock_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBaseVideoMixer_SetUsingClock_Proxy(byval This as IBaseVideoMixer ptr, byval bValue as long) as HRESULT
declare sub IBaseVideoMixer_SetUsingClock_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBaseVideoMixer_GetClockPeriod_Proxy(byval This as IBaseVideoMixer ptr, byval pbValue as long ptr) as HRESULT
declare sub IBaseVideoMixer_GetClockPeriod_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBaseVideoMixer_SetClockPeriod_Proxy(byval This as IBaseVideoMixer ptr, byval bValue as long) as HRESULT
declare sub IBaseVideoMixer_SetClockPeriod_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define iPALETTE_COLORS 256
#define iEGA_COLORS 16
#define iMASK_COLORS 3
#define iTRUECOLOR 16
#define iRED 0
#define iGREEN 1
#define iBLUE 2
#define iPALETTE 8
#define iMAXBITS 8

type tag_TRUECOLORINFO
	dwBitMasks(0 to 2) as DWORD
	bmiColors(0 to 255) as RGBQUAD
end type

type TRUECOLORINFO as tag_TRUECOLORINFO

type tagVIDEOINFOHEADER
	rcSource as RECT
	rcTarget as RECT
	dwBitRate as DWORD
	dwBitErrorRate as DWORD
	AvgTimePerFrame as REFERENCE_TIME
	bmiHeader as BITMAPINFOHEADER
end type

type VIDEOINFOHEADER as tagVIDEOINFOHEADER

type tagVIDEOINFO
	rcSource as RECT
	rcTarget as RECT
	dwBitRate as DWORD
	dwBitErrorRate as DWORD
	AvgTimePerFrame as REFERENCE_TIME
	bmiHeader as BITMAPINFOHEADER

	union
		bmiColors(0 to 255) as RGBQUAD
		dwBitMasks(0 to 2) as DWORD
		TrueColorInfo as TRUECOLORINFO
	end union
end type

type VIDEOINFO as tagVIDEOINFO

type tagMPEG1VIDEOINFO
	hdr as VIDEOINFOHEADER
	dwStartTimeCode as DWORD
	cbSequenceHeader as DWORD
	bSequenceHeader(0 to 0) as UBYTE
end type

type MPEG1VIDEOINFO as tagMPEG1VIDEOINFO

#define MAX_SIZE_MPEG1_SEQUENCE_INFO 140
#define MPEG1_SEQUENCE_INFO(pv) cptr(const UBYTE ptr, (pv)->bSequenceHeader)

type tagAnalogVideoInfo
	rcSource as RECT
	rcTarget as RECT
	dwActiveWidth as DWORD
	dwActiveHeight as DWORD
	AvgTimePerFrame as REFERENCE_TIME
end type

type ANALOGVIDEOINFO as tagAnalogVideoInfo

type __WIDL_amvideo_generated_name_00000003 as long
enum
	AM_PROPERTY_FRAMESTEP_STEP = &h1
	AM_PROPERTY_FRAMESTEP_CANCEL = &h2
	AM_PROPERTY_FRAMESTEP_CANSTEP = &h3
	AM_PROPERTY_FRAMESTEP_CANSTEPMULTIPLE = &h4
end enum

type AM_PROPERTY_FRAMESTEP as __WIDL_amvideo_generated_name_00000003

type _AM_FRAMESTEP_STEP
	dwFramesToStep as DWORD
end type

type AM_FRAMESTEP_STEP as _AM_FRAMESTEP_STEP

end extern
