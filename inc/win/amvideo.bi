'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   Copyright (C) 2003 Robert Shearman
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
#include once "objidl.bi"
#include once "ddraw.bi"

extern "Windows"

#define __amvideo_h__
#define __IDirectDrawVideo_FWD_DEFINED__
#define __IQualProp_FWD_DEFINED__
#define __IFullScreenVideo_FWD_DEFINED__
#define __IFullScreenVideoEx_FWD_DEFINED__
#define __IBaseVideoMixer_FWD_DEFINED__
const AMDDS_NONE = &h00
const AMDDS_DCIPS = &h01
const AMDDS_PS = &h02
const AMDDS_RGBOVR = &h04
const AMDDS_YUVOVR = &h08
const AMDDS_RGBOFF = &h10
const AMDDS_YUVOFF = &h20
const AMDDS_RGBFLP = &h40
const AMDDS_YUVFLP = &h80
const AMDDS_ALL = &hFF
const AMDDS_DEFAULT = AMDDS_ALL
const AMDDS_YUV = (AMDDS_YUVOFF or AMDDS_YUVOVR) or AMDDS_YUVFLP
const AMDDS_RGB = (AMDDS_RGBOFF or AMDDS_RGBOVR) or AMDDS_RGBFLP
const AMDSS_PRIMARY = AMDDS_DCIPS or AMDDS_PS
#define __IDirectDrawVideo_INTERFACE_DEFINED__
type IDirectDrawVideo as IDirectDrawVideo_

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

#define IDirectDrawVideo_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IDirectDrawVideo_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IDirectDrawVideo_Release(This) (This)->lpVtbl->Release(This)
#define IDirectDrawVideo_GetSwitches(This, pSwitches) (This)->lpVtbl->GetSwitches(This, pSwitches)
#define IDirectDrawVideo_SetSwitches(This, Switches) (This)->lpVtbl->SetSwitches(This, Switches)
#define IDirectDrawVideo_GetCaps(This, pCaps) (This)->lpVtbl->GetCaps(This, pCaps)
#define IDirectDrawVideo_GetEmulatedCaps(This, pCaps) (This)->lpVtbl->GetEmulatedCaps(This, pCaps)
#define IDirectDrawVideo_GetSurfaceDesc(This, pSurfaceDesc) (This)->lpVtbl->GetSurfaceDesc(This, pSurfaceDesc)
#define IDirectDrawVideo_GetFourCCCodes(This, pCount, pCodes) (This)->lpVtbl->GetFourCCCodes(This, pCount, pCodes)
#define IDirectDrawVideo_SetDirectDraw(This, ddraw) (This)->lpVtbl->SetDirectDraw(This, ddraw)
#define IDirectDrawVideo_GetDirectDraw(This, ddraw) (This)->lpVtbl->GetDirectDraw(This, ddraw)
#define IDirectDrawVideo_GetSurfaceType(This, pSurfaceType) (This)->lpVtbl->GetSurfaceType(This, pSurfaceType)
#define IDirectDrawVideo_SetDefault(This) (This)->lpVtbl->SetDefault(This)
#define IDirectDrawVideo_UseScanLine(This, UseScanLine) (This)->lpVtbl->UseScanLine(This, UseScanLine)
#define IDirectDrawVideo_CanUseScanLine(This, UseScanLine) (This)->lpVtbl->CanUseScanLine(This, UseScanLine)
#define IDirectDrawVideo_UseOverlayStretch(This, UseOverlayStretch) (This)->lpVtbl->UseOverlayStretch(This, UseOverlayStretch)
#define IDirectDrawVideo_CanUseOverlayStretch(This, UseOverlayStretch) (This)->lpVtbl->CanUseOverlayStretch(This, UseOverlayStretch)
#define IDirectDrawVideo_UseWhenFullScreen(This, UseWhenFullScreen) (This)->lpVtbl->UseWhenFullScreen(This, UseWhenFullScreen)
#define IDirectDrawVideo_WillUseFullScreen(This, UseWhenFullScreen) (This)->lpVtbl->WillUseFullScreen(This, UseWhenFullScreen)

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
type IQualProp as IQualProp_

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

#define IQualProp_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IQualProp_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IQualProp_Release(This) (This)->lpVtbl->Release(This)
#define IQualProp_get_FramesDroppedInRenderer(This, pcFrames) (This)->lpVtbl->get_FramesDroppedInRenderer(This, pcFrames)
#define IQualProp_get_FramesDrawn(This, pcFramesDrawn) (This)->lpVtbl->get_FramesDrawn(This, pcFramesDrawn)
#define IQualProp_get_AvgFrameRate(This, piAvgFrameRate) (This)->lpVtbl->get_AvgFrameRate(This, piAvgFrameRate)
#define IQualProp_get_Jitter(This, iJitter) (This)->lpVtbl->get_Jitter(This, iJitter)
#define IQualProp_get_AvgSyncOffset(This, piAvg) (This)->lpVtbl->get_AvgSyncOffset(This, piAvg)
#define IQualProp_get_DevSyncOffset(This, piDev) (This)->lpVtbl->get_DevSyncOffset(This, piDev)

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
type IFullScreenVideo as IFullScreenVideo_

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

#define IFullScreenVideo_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IFullScreenVideo_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IFullScreenVideo_Release(This) (This)->lpVtbl->Release(This)
#define IFullScreenVideo_CountModes(This, pModes) (This)->lpVtbl->CountModes(This, pModes)
#define IFullScreenVideo_GetModeInfo(This, Mode, pWidth, pHeight, pDepth) (This)->lpVtbl->GetModeInfo(This, Mode, pWidth, pHeight, pDepth)
#define IFullScreenVideo_GetCurrentMode(This, pMode) (This)->lpVtbl->GetCurrentMode(This, pMode)
#define IFullScreenVideo_IsModeAvailable(This, Mode) (This)->lpVtbl->IsModeAvailable(This, Mode)
#define IFullScreenVideo_IsModeEnabled(This, Mode) (This)->lpVtbl->IsModeEnabled(This, Mode)
#define IFullScreenVideo_SetEnabled(This, Mode, bEnabled) (This)->lpVtbl->SetEnabled(This, Mode, bEnabled)
#define IFullScreenVideo_GetClipFactor(This, pClipFactor) (This)->lpVtbl->GetClipFactor(This, pClipFactor)
#define IFullScreenVideo_SetClipFactor(This, ClipFactor) (This)->lpVtbl->SetClipFactor(This, ClipFactor)
#define IFullScreenVideo_SetMessageDrain(This, hwnd) (This)->lpVtbl->SetMessageDrain(This, hwnd)
#define IFullScreenVideo_GetMessageDrain(This, hwnd) (This)->lpVtbl->GetMessageDrain(This, hwnd)
#define IFullScreenVideo_SetMonitor(This, Monitor) (This)->lpVtbl->SetMonitor(This, Monitor)
#define IFullScreenVideo_GetMonitor(This, Monitor) (This)->lpVtbl->GetMonitor(This, Monitor)
#define IFullScreenVideo_HideOnDeactivate(This, Hide) (This)->lpVtbl->HideOnDeactivate(This, Hide)
#define IFullScreenVideo_IsHideOnDeactivate(This) (This)->lpVtbl->IsHideOnDeactivate(This)
#define IFullScreenVideo_SetCaption(This, strCaption) (This)->lpVtbl->SetCaption(This, strCaption)
#define IFullScreenVideo_GetCaption(This, pstrCaption) (This)->lpVtbl->GetCaption(This, pstrCaption)
#define IFullScreenVideo_SetDefault(This) (This)->lpVtbl->SetDefault(This)

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
type IFullScreenVideoEx as IFullScreenVideoEx_

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

#define IFullScreenVideoEx_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IFullScreenVideoEx_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IFullScreenVideoEx_Release(This) (This)->lpVtbl->Release(This)
#define IFullScreenVideoEx_CountModes(This, pModes) (This)->lpVtbl->CountModes(This, pModes)
#define IFullScreenVideoEx_GetModeInfo(This, Mode, pWidth, pHeight, pDepth) (This)->lpVtbl->GetModeInfo(This, Mode, pWidth, pHeight, pDepth)
#define IFullScreenVideoEx_GetCurrentMode(This, pMode) (This)->lpVtbl->GetCurrentMode(This, pMode)
#define IFullScreenVideoEx_IsModeAvailable(This, Mode) (This)->lpVtbl->IsModeAvailable(This, Mode)
#define IFullScreenVideoEx_IsModeEnabled(This, Mode) (This)->lpVtbl->IsModeEnabled(This, Mode)
#define IFullScreenVideoEx_SetEnabled(This, Mode, bEnabled) (This)->lpVtbl->SetEnabled(This, Mode, bEnabled)
#define IFullScreenVideoEx_GetClipFactor(This, pClipFactor) (This)->lpVtbl->GetClipFactor(This, pClipFactor)
#define IFullScreenVideoEx_SetClipFactor(This, ClipFactor) (This)->lpVtbl->SetClipFactor(This, ClipFactor)
#define IFullScreenVideoEx_SetMessageDrain(This, hwnd) (This)->lpVtbl->SetMessageDrain(This, hwnd)
#define IFullScreenVideoEx_GetMessageDrain(This, hwnd) (This)->lpVtbl->GetMessageDrain(This, hwnd)
#define IFullScreenVideoEx_SetMonitor(This, Monitor) (This)->lpVtbl->SetMonitor(This, Monitor)
#define IFullScreenVideoEx_GetMonitor(This, Monitor) (This)->lpVtbl->GetMonitor(This, Monitor)
#define IFullScreenVideoEx_HideOnDeactivate(This, Hide) (This)->lpVtbl->HideOnDeactivate(This, Hide)
#define IFullScreenVideoEx_IsHideOnDeactivate(This) (This)->lpVtbl->IsHideOnDeactivate(This)
#define IFullScreenVideoEx_SetCaption(This, strCaption) (This)->lpVtbl->SetCaption(This, strCaption)
#define IFullScreenVideoEx_GetCaption(This, pstrCaption) (This)->lpVtbl->GetCaption(This, pstrCaption)
#define IFullScreenVideoEx_SetDefault(This) (This)->lpVtbl->SetDefault(This)
#define IFullScreenVideoEx_SetAcceleratorTable(This, hwnd, hAccel) (This)->lpVtbl->SetAcceleratorTable(This, hwnd, hAccel)
#define IFullScreenVideoEx_GetAcceleratorTable(This, phwnd, phAccel) (This)->lpVtbl->GetAcceleratorTable(This, phwnd, phAccel)
#define IFullScreenVideoEx_KeepPixelAspectRatio(This, KeepAspect) (This)->lpVtbl->KeepPixelAspectRatio(This, KeepAspect)
#define IFullScreenVideoEx_IsKeepPixelAspectRatio(This, pKeepAspect) (This)->lpVtbl->IsKeepPixelAspectRatio(This, pKeepAspect)

declare function IFullScreenVideoEx_SetAcceleratorTable_Proxy(byval This as IFullScreenVideoEx ptr, byval hwnd as HWND, byval hAccel as HACCEL) as HRESULT
declare sub IFullScreenVideoEx_SetAcceleratorTable_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFullScreenVideoEx_GetAcceleratorTable_Proxy(byval This as IFullScreenVideoEx ptr, byval phwnd as HWND ptr, byval phAccel as HACCEL ptr) as HRESULT
declare sub IFullScreenVideoEx_GetAcceleratorTable_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFullScreenVideoEx_KeepPixelAspectRatio_Proxy(byval This as IFullScreenVideoEx ptr, byval KeepAspect as LONG) as HRESULT
declare sub IFullScreenVideoEx_KeepPixelAspectRatio_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFullScreenVideoEx_IsKeepPixelAspectRatio_Proxy(byval This as IFullScreenVideoEx ptr, byval pKeepAspect as LONG ptr) as HRESULT
declare sub IFullScreenVideoEx_IsKeepPixelAspectRatio_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IBaseVideoMixer_INTERFACE_DEFINED__
type IBaseVideoMixer as IBaseVideoMixer_

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

#define IBaseVideoMixer_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IBaseVideoMixer_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IBaseVideoMixer_Release(This) (This)->lpVtbl->Release(This)
#define IBaseVideoMixer_SetLeadPin(This, iPin) (This)->lpVtbl->SetLeadPin(This, iPin)
#define IBaseVideoMixer_GetLeadPin(This, piPin) (This)->lpVtbl->GetLeadPin(This, piPin)
#define IBaseVideoMixer_GetInputPinCount(This, piPinCount) (This)->lpVtbl->GetInputPinCount(This, piPinCount)
#define IBaseVideoMixer_IsUsingClock(This, pbValue) (This)->lpVtbl->IsUsingClock(This, pbValue)
#define IBaseVideoMixer_SetUsingClock(This, bValue) (This)->lpVtbl->SetUsingClock(This, bValue)
#define IBaseVideoMixer_GetClockPeriod(This, pbValue) (This)->lpVtbl->GetClockPeriod(This, pbValue)
#define IBaseVideoMixer_SetClockPeriod(This, bValue) (This)->lpVtbl->SetClockPeriod(This, bValue)

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

const iPALETTE_COLORS = 256
const iEGA_COLORS = 16
const iMASK_COLORS = 3
const iTRUECOLOR = 16
const iRED = 0
const iGREEN = 1
const iBLUE = 2
const iPALETTE = 8
const iMAXBITS = 8

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
const MAX_SIZE_MPEG1_SEQUENCE_INFO = 140
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

#include once "ole-common.bi"
