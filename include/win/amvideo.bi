''
''
'' amvideo -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_amvideo_bi__
#define __win_amvideo_bi__

#include once "win/ddraw.bi"

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
#define AMDDS_DEFAULT &hFF
#define AMDDS_YUV (&h20 or &h08 or &h80)
#define AMDDS_RGB (&h10 or &h04 or &h40)
#define AMDDS_PRIMARY (&h01 or &h02)

type IDirectDrawVideoVtbl_ as IDirectDrawVideoVtbl

type IDirectDrawVideo
	lpVtbl as IDirectDrawVideoVtbl_ ptr
end type

type IDirectDrawVideoVtbl
	QueryInterface as function(byval as IDirectDrawVideo ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectDrawVideo ptr) as ULONG
	Release as function(byval as IDirectDrawVideo ptr) as ULONG
	GetSwitches as function(byval as IDirectDrawVideo ptr, byval as DWORD ptr) as HRESULT
	SetSwitches as function(byval as IDirectDrawVideo ptr, byval as DWORD) as HRESULT
	GetCaps as function(byval as IDirectDrawVideo ptr, byval as DDCAPS ptr) as HRESULT
	GetEmulatedCaps as function(byval as IDirectDrawVideo ptr, byval as DDCAPS ptr) as HRESULT
	GetSurfaceDesc as function(byval as IDirectDrawVideo ptr, byval as DDSURFACEDESC ptr) as HRESULT
	GetFourCCCodes as function(byval as IDirectDrawVideo ptr, byval as DWORD ptr, byval as DWORD ptr) as HRESULT
	SetDirectDraw as function(byval as IDirectDrawVideo ptr, byval as LPDIRECTDRAW) as HRESULT
	GetDirectDraw as function(byval as IDirectDrawVideo ptr, byval as LPDIRECTDRAW ptr) as HRESULT
	GetSurfaceType as function(byval as IDirectDrawVideo ptr, byval as DWORD ptr) as HRESULT
	SetDefault as function(byval as IDirectDrawVideo ptr) as HRESULT
	UseScanLine as function(byval as IDirectDrawVideo ptr, byval as integer) as HRESULT
	CanUseScanLine as function(byval as IDirectDrawVideo ptr, byval as integer ptr) as HRESULT
	UseOverlayStretch as function(byval as IDirectDrawVideo ptr, byval as integer) as HRESULT
	CanUseOverlayStretch as function(byval as IDirectDrawVideo ptr, byval as integer ptr) as HRESULT
	UseWhenFullScreen as function(byval as IDirectDrawVideo ptr, byval as integer) as HRESULT
	WillUseFullScreen as function(byval as IDirectDrawVideo ptr, byval as integer ptr) as HRESULT
end type

type IQualPropVtbl_ as IQualPropVtbl

type IQualProp
	lpVtbl as IQualPropVtbl_ ptr
end type

type IQualPropVtbl
	QueryInterface as function(byval as IQualProp ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IQualProp ptr) as ULONG
	Release as function(byval as IQualProp ptr) as ULONG
	get_FramesDroppedInRenderer as function(byval as IQualProp ptr, byval as integer ptr) as HRESULT
	get_FramesDrawn as function(byval as IQualProp ptr, byval as integer ptr) as HRESULT
	get_AvgFrameRate as function(byval as IQualProp ptr, byval as integer ptr) as HRESULT
	get_Jitter as function(byval as IQualProp ptr, byval as integer ptr) as HRESULT
	get_AvgSyncOffset as function(byval as IQualProp ptr, byval as integer ptr) as HRESULT
	get_DevSyncOffset as function(byval as IQualProp ptr, byval as integer ptr) as HRESULT
end type

type IFullScreenVideoVtbl_ as IFullScreenVideoVtbl

type IFullScreenVideo
	lpVtbl as IFullScreenVideoVtbl_ ptr
end type

type IFullScreenVideoVtbl
	QueryInterface as function(byval as IFullScreenVideo ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IFullScreenVideo ptr) as ULONG
	Release as function(byval as IFullScreenVideo ptr) as ULONG
	CountModes as function(byval as IFullScreenVideo ptr, byval as integer ptr) as HRESULT
	GetModeInfo as function(byval as IFullScreenVideo ptr, byval as integer, byval as integer ptr, byval as integer ptr, byval as integer ptr) as HRESULT
	GetCurrentMode as function(byval as IFullScreenVideo ptr, byval as integer ptr) as HRESULT
	IsModeAvailable as function(byval as IFullScreenVideo ptr, byval as integer) as HRESULT
	IsModeEnabled as function(byval as IFullScreenVideo ptr, byval as integer) as HRESULT
	SetEnabled as function(byval as IFullScreenVideo ptr, byval as integer, byval as integer) as HRESULT
	GetClipFactor as function(byval as IFullScreenVideo ptr, byval as integer ptr) as HRESULT
	SetClipFactor as function(byval as IFullScreenVideo ptr, byval as integer) as HRESULT
	SetMessageDrain as function(byval as IFullScreenVideo ptr, byval as HWND) as HRESULT
	GetMessageDrain as function(byval as IFullScreenVideo ptr, byval as HWND ptr) as HRESULT
	SetMonitor as function(byval as IFullScreenVideo ptr, byval as integer) as HRESULT
	GetMonitor as function(byval as IFullScreenVideo ptr, byval as integer ptr) as HRESULT
	HideOnDeactivate as function(byval as IFullScreenVideo ptr, byval as integer) as HRESULT
	IsHideOnDeactivate as function(byval as IFullScreenVideo ptr) as HRESULT
	SetCaption as function(byval as IFullScreenVideo ptr, byval as BSTR) as HRESULT
	GetCaption as function(byval as IFullScreenVideo ptr, byval as BSTR ptr) as HRESULT
	SetDefault as function(byval as IFullScreenVideo ptr) as HRESULT
end type

type IFullScreenVideoExVtbl_ as IFullScreenVideoExVtbl

type IFullScreenVideoEx
	lpVtbl as IFullScreenVideoExVtbl_ ptr
end type

type IFullScreenVideoExVtbl
	QueryInterface as function(byval as IFullScreenVideoEx ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IFullScreenVideoEx ptr) as ULONG
	Release as function(byval as IFullScreenVideoEx ptr) as ULONG
	CountModes as function(byval as IFullScreenVideoEx ptr, byval as integer ptr) as HRESULT
	GetModeInfo as function(byval as IFullScreenVideoEx ptr, byval as integer, byval as integer ptr, byval as integer ptr, byval as integer ptr) as HRESULT
	GetCurrentMode as function(byval as IFullScreenVideoEx ptr, byval as integer ptr) as HRESULT
	IsModeAvailable as function(byval as IFullScreenVideoEx ptr, byval as integer) as HRESULT
	IsModeEnabled as function(byval as IFullScreenVideoEx ptr, byval as integer) as HRESULT
	SetEnabled as function(byval as IFullScreenVideoEx ptr, byval as integer, byval as integer) as HRESULT
	GetClipFactor as function(byval as IFullScreenVideoEx ptr, byval as integer ptr) as HRESULT
	SetClipFactor as function(byval as IFullScreenVideoEx ptr, byval as integer) as HRESULT
	SetMessageDrain as function(byval as IFullScreenVideoEx ptr, byval as HWND) as HRESULT
	GetMessageDrain as function(byval as IFullScreenVideoEx ptr, byval as HWND ptr) as HRESULT
	SetMonitor as function(byval as IFullScreenVideoEx ptr, byval as integer) as HRESULT
	GetMonitor as function(byval as IFullScreenVideoEx ptr, byval as integer ptr) as HRESULT
	HideOnDeactivate as function(byval as IFullScreenVideoEx ptr, byval as integer) as HRESULT
	IsHideOnDeactivate as function(byval as IFullScreenVideoEx ptr) as HRESULT
	SetCaption as function(byval as IFullScreenVideoEx ptr, byval as BSTR) as HRESULT
	GetCaption as function(byval as IFullScreenVideoEx ptr, byval as BSTR ptr) as HRESULT
	SetDefault as function(byval as IFullScreenVideoEx ptr) as HRESULT
	SetAcceleratorTable as function(byval as IFullScreenVideoEx ptr, byval as HWND, byval as HACCEL) as HRESULT
	GetAcceleratorTable as function(byval as IFullScreenVideoEx ptr, byval as HWND ptr, byval as HACCEL ptr) as HRESULT
	KeepPixelAspectRatio as function(byval as IFullScreenVideoEx ptr, byval as integer) as HRESULT
	IsKeepPixelAspectRatio as function(byval as IFullScreenVideoEx ptr, byval as integer ptr) as HRESULT
end type

type IBaseVideoMixerVtbl_ as IBaseVideoMixerVtbl

type IBaseVideoMixer
	lpVtbl as IBaseVideoMixerVtbl_ ptr
end type

type IBaseVideoMixerVtbl
	SetLeadPin as function(byval as IBaseVideoMixer ptr, byval as integer) as HRESULT
	GetLeadPin as function(byval as IBaseVideoMixer ptr, byval as integer ptr) as HRESULT
	GetInputPinCount as function(byval as IBaseVideoMixer ptr, byval as integer ptr) as HRESULT
	IsUsingClock as function(byval as IBaseVideoMixer ptr, byval as integer ptr) as HRESULT
	SetUsingClock as function(byval as IBaseVideoMixer ptr, byval as integer) as HRESULT
	GetClockPeriod as function(byval as IBaseVideoMixer ptr, byval as integer ptr) as HRESULT
	SetClockPeriod as function(byval as IBaseVideoMixer ptr, byval as integer) as HRESULT
end type

#define iPALETTE_COLORS 256
#define iEGA_COLORS 16
#define iMASK_COLORS 3
#define iTRUECOLOR 16
#define iRED 0
#define iGREEN 1
#define iBLUE 2
#define iPALETTE 8
#define iMAXBITS 8

type TRUECOLORINFO
	dwBitMasks(0 to 3-1) as DWORD
	bmiColors(0 to 256-1) as RGBQUAD
end type

type VIDEOINFOHEADER
	rcSource as RECT
	rcTarget as RECT
	dwBitRate as DWORD
	dwBitErrorRate as DWORD
	AvgTimePerFrame as REFERENCE_TIME
	bmiHeader as BITMAPINFOHEADER
end type

#define TRUECOLOR(pbmi) (cast(TRUECOLORINFO ptr, cast(LPBYTE, @(pbmi)->bmiHeader)) + (pbmi)->bmiHeader.biSize)
#define COLORS(pbmi) (cast(RGBQUAD ptr, cast(LPBYTE, @(pbmi)->bmiHeader)) + (pbmi)->bmiHeader.biSize)
#define BITMASKS(pbmi) (cast(DWORD ptr, cast(LPBYTE, @(pbmi)->bmiHeader)) + (pbmi)->bmiHeader.biSize)

type VIDEOINFO
	rcSource as RECT
	rcTarget as RECT
	dwBitRate as DWORD
	dwBitErrorRate as DWORD
	AvgTimePerFrame as REFERENCE_TIME
	bmiHeader as BITMAPINFOHEADER
    union
        bmiColors(0 to iPALETTE_COLORS-1) as RGBQUAD
        dwBitMasks(0 to iMASK_COLORS-1) as DWORD
        TrueColorInfo as TRUECOLORINFO
    end union
end type

#define SIZE_EGA_PALETTE (iEGA_COLORS * len(RGBQUAD))
#define SIZE_PALETTE (iPALETTE_COLORS * len(RGBQUAD))
#define SIZE_MASKS (iMASK_COLORS * len(DWORD))
#define SIZE_PREHEADER (FIELD_OFFSET(VIDEOINFOHEADER,bmiHeader))
#define SIZE_VIDEOHEADER (len(BITMAPINFOHEADER) + SIZE_PREHEADER)

#define WIDTHBYTES(bits) ((cuint(bits)+31) and (not 31)) shr 3)
#define DIBWIDTHBYTES(bi) cuint(WIDTHBYTES(cuitn(bi).biWidth * cuint(bi.biBitCount))
#define _DIBSIZE(bi) (DIBWIDTHBYTES(bi) * cuint(bi.biHeight))
#define DIBSIZE(bi) iif( bi.biHeight < 0, (-1)*(_DIBSIZE(bi)), _DIBSIZE(bi))

#define BIT_MASKS_MATCH(pbmi1,pbmi2) (((pbmi1)->dwBitMasks(iRED) = (pbmi2)->dwBitMasks(iRED)) and _
									  ((pbmi1)->dwBitMasks(iGREEN) = (pbmi2)->dwBitMasks(iGREEN)) and _
									  ((pbmi1)->dwBitMasks(iBLUE) = (pbmi2)->dwBitMasks(iBLUE)))

#define RESET_MASKS(pbmi) ZeroMemory(cast(PVOID,pbmi)->dwBitFields,SIZE_MASKS)
#define RESET_HEADER(pbmi) ZeroMemory(cast(PVOID,pbmi),SIZE_VIDEOHEADER)
#define RESET_PALETTE(pbmi) ZeroMemory(cast(PVOID,pbmi)->bmiColors,SIZE_PALETTE)

#define PALETTISED(pbmi) ((pbmi)->bmiHeader.biBitCount <= iPALETTE)
#define PALETTE_ENTRIES(pbmi) (cuint(1) shl (pbmi)->bmiHeader.biBitCount)

#define HEADER(pVideoInfo) @cast(VIDEOINFOHEADER ptr, pVideoInfo)->bmiHeader

type MPEG1VIDEOINFO
	hdr as VIDEOINFOHEADER
	dwStartTimeCode as DWORD
	cbSequenceHeader as DWORD
	bSequenceHeader(0 to 1-1) as UBYTE
end type

#define MAX_SIZE_MPEG1_SEQUENCE_INFO 140
#define SIZE_MPEG1VIDEOINFO(pv) (FIELD_OFFSET(MPEG1VIDEOINFO, bSequenceHeader(0)) + (pv)->cbSequenceHeader)
#define MPEG1_SEQUENCE_INFO(pv) cast(UBYTE ptr,(pv)->bSequenceHeader)

type ANALOGVIDEOINFO
	rcSource as RECT
	rcTarget as RECT
	dwActiveWidth as DWORD
	dwActiveHeight as DWORD
	AvgTimePerFrame as REFERENCE_TIME
end type

enum AM_PROPERTY_FRAMESTEP
	AM_PROPERTY_FRAMESTEP_STEP = &h01
	AM_PROPERTY_FRAMESTEP_CANCEL = &h02
	AM_PROPERTY_FRAMESTEP_CANSTEP = &h03
	AM_PROPERTY_FRAMESTEP_CANSTEPMULTIPLE = &h04
end enum

type AM_FRAMESTEP_STEP
	dwFramesToStep as DWORD
end type

#endif
