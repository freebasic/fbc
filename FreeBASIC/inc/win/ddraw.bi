''
''
'' ddraw -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_ddraw_bi__
#define __win_ddraw_bi__

#define COM_NO_WINDOWS_H 1
#include once "win/objbase.bi"

#inclib "ddraw"
#inclib "dxguid"

#ifndef DIRECTDRAW_VERSION
#define DIRECTDRAW_VERSION &h0700
#endif

#ifndef MAKEFOURCC
#define MAKEFOURCC(ch0, ch1, ch2, ch3) (cuint(cubyte(ch0)) or (cuint(cubyte(ch1)) shl 8) or   _
                					   (cuint(cubyte(ch2)) shl 16) or (cuint(cubyte(ch3)) shl 24 ))
#endif

#define FOURCC_DXT1 MAKEFOURCC(asc("D"),asc("X"),asc("T"),asc("1"))
#define FOURCC_DXT2 MAKEFOURCC(asc("D"),asc("X"),asc("T"),asc("2"))
#define FOURCC_DXT3 MAKEFOURCC(asc("D"),asc("X"),asc("T"),asc("3"))
#define FOURCC_DXT4 MAKEFOURCC(asc("D"),asc("X"),asc("T"),asc("4"))
#define FOURCC_DXT5 MAKEFOURCC(asc("D"),asc("X"),asc("T"),asc("5"))

#ifndef CLSID_DirectDraw
DEFINE_GUID(CLSID_DirectDraw,&hD7B70EE0,&h4340,&h11CF,&hB0,&h63,&h00,&h20,&hAF,&hC2,&hCD,&h35)
DEFINE_GUID(CLSID_DirectDraw7,&h3c305196,&h50db,&h11d3,&h9c,&hfe,&h00,&hc0,&h4f,&hd9,&h30,&hc5)
DEFINE_GUID(CLSID_DirectDrawClipper,&h593817A0,&h7DB3,&h11CF,&hA2,&hDE,&h00,&hAA,&h00,&hb9,&h33,&h56)
DEFINE_GUID(IID_IDirectDraw,&h6C14DB80,&hA733,&h11CE,&hA5,&h21,&h00,&h20,&hAF,&h0B,&hE5,&h60)
DEFINE_GUID(IID_IDirectDraw2,&hB3A6F3E0,&h2B43,&h11CF,&hA2,&hDE,&h00,&hAA,&h00,&hB9,&h33,&h56)
DEFINE_GUID(IID_IDirectDraw4,&h9c59509a,&h39bd,&h11d1,&h8c,&h4a,&h00,&hc0,&h4f,&hd9,&h30,&hc5)
DEFINE_GUID(IID_IDirectDraw7,&h15e65ec0,&h3b9c,&h11d2,&hb9,&h2f,&h00,&h60,&h97,&h97,&hea,&h5b)
DEFINE_GUID(IID_IDirectDrawSurface,&h6C14DB81,&hA733,&h11CE,&hA5,&h21,&h00,&h20,&hAF,&h0B,&hE5,&h60)
DEFINE_GUID(IID_IDirectDrawSurface2,&h57805885,&h6eec,&h11cf,&h94,&h41,&ha8,&h23,&h03,&hc1,&h0e,&h27)
DEFINE_GUID(IID_IDirectDrawSurface3,&hDA044E00,&h69B2,&h11D0,&hA1,&hD5,&h00,&hAA,&h00,&hB8,&hDF,&hBB)
DEFINE_GUID(IID_IDirectDrawSurface4,&h0B2B8630,&hAD35,&h11D0,&h8E,&hA6,&h00,&h60,&h97,&h97,&hEA,&h5B)
DEFINE_GUID(IID_IDirectDrawSurface7,&h06675a80,&h3b9b,&h11d2,&hb9,&h2f,&h00,&h60,&h97,&h97,&hea,&h5b)
DEFINE_GUID(IID_IDirectDrawPalette,&h6C14DB84,&hA733,&h11CE,&hA5,&h21,&h00,&h20,&hAF,&h0B,&hE5,&h60)
DEFINE_GUID(IID_IDirectDrawClipper,&h6C14DB85,&hA733,&h11CE,&hA5,&h21,&h00,&h20,&hAF,&h0B,&hE5,&h60)
DEFINE_GUID(IID_IDirectDrawColorControl,&h4B9F0EE0,&h0D7E,&h11D0,&h9B,&h06,&h00,&hA0,&hC9,&h03,&hA3,&hB8)
DEFINE_GUID(IID_IDirectDrawGammaControl,&h69C11C3E,&hB46B,&h11D1,&hAD,&h7A,&h00,&hC0,&h4F,&hC2,&h9B,&h4E)
#endif

type LPDIRECTDRAW as IDirectDraw ptr
type LPDIRECTDRAW2 as IDirectDraw2 ptr
type LPDIRECTDRAW4 as IDirectDraw4 ptr
type LPDIRECTDRAW7 as IDirectDraw7 ptr
type LPDIRECTDRAWSURFACE as IDirectDrawSurface ptr
type LPDIRECTDRAWSURFACE2 as IDirectDrawSurface2 ptr
type LPDIRECTDRAWSURFACE3 as IDirectDrawSurface3 ptr
type LPDIRECTDRAWSURFACE4 as IDirectDrawSurface4 ptr
type LPDIRECTDRAWSURFACE7 as IDirectDrawSurface7 ptr
type LPDIRECTDRAWPALETTE as IDirectDrawPalette ptr
type LPDIRECTDRAWCLIPPER as IDirectDrawClipper ptr
type LPDIRECTDRAWCOLORCONTROL as IDirectDrawColorControl ptr
type LPDIRECTDRAWGAMMACONTROL as IDirectDrawGammaControl ptr
type LPDDFXROP as DDFXROP ptr
type LPDDSURFACEDESC as DDSURFACEDESC ptr
type LPDDSURFACEDESC2 as DDSURFACEDESC2 ptr
type LPDDCOLORCONTROL as DDCOLORCONTROL ptr

#ifdef UNICODE
type LPDDENUMCALLBACK as function (byval as GUID ptr, byval as LPWSTR, byval as LPWSTR, byval as LPVOID) as BOOL
type LPDDENUMCALLBACKEX as function (byval as GUID ptr, byval as LPWSTR, byval as LPWSTR, byval as LPVOID, byval as HMONITOR) as BOOL
type LPDIRECTDRAWENUMERATEEX as function (byval as LPDDENUMCALLBACKEX, byval as LPVOID, byval as DWORD) as HRESULT
declare function DirectDrawEnumerate alias "DirectDrawEnumerateW" (byval lpCallback as LPDDENUMCALLBACK, byval lpContext as LPVOID) as HRESULT
declare function DirectDrawEnumerateEx alias "DirectDrawEnumerateExW" (byval lpCallback as LPDDENUMCALLBACKEX, byval lpContext as LPVOID, byval dwFlags as DWORD) as HRESULT

#else ''UNICODE
type LPDDENUMCALLBACK as function (byval as GUID ptr, byval as LPSTR, byval as LPSTR, byval as LPVOID) as BOOL
type LPDDENUMCALLBACKEX as function (byval as GUID ptr, byval as LPSTR, byval as LPSTR, byval as LPVOID, byval as HMONITOR) as BOOL
type LPDIRECTDRAWENUMERATEEX as function (byval as LPDDENUMCALLBACKEX, byval as LPVOID, byval as DWORD) as HRESULT
declare function DirectDrawEnumerate alias "DirectDrawEnumerateA" (byval lpCallback as LPDDENUMCALLBACK, byval lpContext as LPVOID) as HRESULT
declare function DirectDrawEnumerateEx alias "DirectDrawEnumerateExA" (byval lpCallback as LPDDENUMCALLBACKEX, byval lpContext as LPVOID, byval dwFlags as DWORD) as HRESULT
#endif

declare function DirectDrawCreate alias "DirectDrawCreate" (byval lpGUID as GUID ptr, byval lplpDD as LPDIRECTDRAW ptr, byval pUnkOuter as IUnknown ptr) as HRESULT
declare function DirectDrawCreateEx alias "DirectDrawCreateEx" (byval lpGuid as GUID ptr, byval lplpDD as LPVOID ptr, byval iid as IID ptr, byval pUnkOuter as IUnknown ptr) as HRESULT
declare function DirectDrawCreateClipper alias "DirectDrawCreateClipper" (byval dwFlags as DWORD, byval lplpDDClipper as LPDIRECTDRAWCLIPPER ptr, byval pUnkOuter as IUnknown ptr) as HRESULT

#define DDENUM_ATTACHEDSECONDARYDEVICES &h00000001L
#define DDENUM_DETACHEDSECONDARYDEVICES &h00000002L
#define DDENUM_NONDISPLAYDEVICES &h00000004L
#define REGSTR_KEY_DDHW_DESCRIPTION "Description"
#define REGSTR_KEY_DDHW_DRIVERNAME "DriverName"
#define REGSTR_PATH_DDHW $"Hardware\DirectDrawDrivers"
#define DDCREATE_HARDWAREONLY &h00000001l
#define DDCREATE_EMULATIONONLY &h00000002l

type LPDDENUMMODESCALLBACK as function (byval as LPDDSURFACEDESC, byval as LPVOID) as HRESULT
type LPDDENUMMODESCALLBACK2 as function (byval as LPDDSURFACEDESC2, byval as LPVOID) as HRESULT
type LPDDENUMSURFACESCALLBACK as function (byval as LPDIRECTDRAWSURFACE, byval as LPDDSURFACEDESC, byval as LPVOID) as HRESULT
type LPDDENUMSURFACESCALLBACK2 as function (byval as LPDIRECTDRAWSURFACE4, byval as LPDDSURFACEDESC2, byval as LPVOID) as HRESULT
type LPDDENUMSURFACESCALLBACK7 as function (byval as LPDIRECTDRAWSURFACE7, byval as LPDDSURFACEDESC2, byval as LPVOID) as HRESULT

type DDARGB
	blue as uBYTE
	green as uBYTE
	red as uBYTE
	alpha as uBYTE
end type

type LPDDARGB as DDARGB ptr

type DDRGBA
	red as uBYTE
	green as uBYTE
	blue as uBYTE
	alpha as uBYTE
end type

type LPDDRGBA as DDRGBA ptr

type DDCOLORKEY
	dwColorSpaceLowValue as DWORD
	dwColorSpaceHighValue as DWORD
end type

type LPDDCOLORKEY as DDCOLORKEY ptr

type DDBLTFX
	dwSize as DWORD
	dwDDFX as DWORD
	dwROP as DWORD
	dwDDROP as DWORD
	dwRotationAngle as DWORD
	dwZBufferOpCode as DWORD
	dwZBufferLow as DWORD
	dwZBufferHigh as DWORD
	dwZBufferBaseDest as DWORD
	dwZDestConstBitDepth as DWORD
	union
		dwZDestConst as DWORD
		lpDDSZBufferDest as LPDIRECTDRAWSURFACE
	end union
	dwZSrcConstBitDepth as DWORD
	union
		dwZSrcConst as DWORD
		lpDDSZBufferSrc as LPDIRECTDRAWSURFACE
	end union
	dwAlphaEdgeBlendBitDepth as DWORD
	dwAlphaEdgeBlend as DWORD
	dwReserved as DWORD
	dwAlphaDestConstBitDepth as DWORD
	union
		dwAlphaDestConst as DWORD
		lpDDSAlphaDest as LPDIRECTDRAWSURFACE
	end union
	dwAlphaSrcConstBitDepth as DWORD
	union
		dwAlphaSrcConst as DWORD
		lpDDSAlphaSrc as LPDIRECTDRAWSURFACE
	end union
	union
		dwFillColor as DWORD
		dwFillDepth as DWORD
		dwFillPixel as DWORD
		lpDDSPattern as LPDIRECTDRAWSURFACE
	end union
	ddckDestColorkey as DDCOLORKEY
	ddckSrcColorkey as DDCOLORKEY
end type

type LPDDBLTFX as DDBLTFX ptr

type DDSCAPS
	dwCaps as DWORD
end type

type LPDDSCAPS as DDSCAPS ptr

type DDOSCAPS
	dwCaps as DWORD
end type

type LPDDOSCAPS as DDOSCAPS ptr

type DDSCAPSEX
	dwCaps2 as DWORD
	dwCaps3 as DWORD
	union
		dwCaps4 as DWORD
		dwVolumeDepth as DWORD
	end union
end type

type LPDDSCAPSEX as DDSCAPSEX ptr

type DDSCAPS2
	dwCaps as DWORD
	dwCaps2 as DWORD
	dwCaps3 as DWORD
	union
		dwCaps4 as DWORD
		dwVolumeDepth as DWORD
	end union
end type

type LPDDSCAPS2 as DDSCAPS2 ptr

#define DD_ROP_SPACE (256\32)

type DDCAPS_DX1
	dwSize as DWORD
	dwCaps as DWORD
	dwCaps2 as DWORD
	dwCKeyCaps as DWORD
	dwFXCaps as DWORD
	dwFXAlphaCaps as DWORD
	dwPalCaps as DWORD
	dwSVCaps as DWORD
	dwAlphaBltConstBitDepths as DWORD
	dwAlphaBltPixelBitDepths as DWORD
	dwAlphaBltSurfaceBitDepths as DWORD
	dwAlphaOverlayConstBitDepths as DWORD
	dwAlphaOverlayPixelBitDepths as DWORD
	dwAlphaOverlaySurfaceBitDepths as DWORD
	dwZBufferBitDepths as DWORD
	dwVidMemTotal as DWORD
	dwVidMemFree as DWORD
	dwMaxVisibleOverlays as DWORD
	dwCurrVisibleOverlays as DWORD
	dwNumFourCCCodes as DWORD
	dwAlignBoundarySrc as DWORD
	dwAlignSizeSrc as DWORD
	dwAlignBoundaryDest as DWORD
	dwAlignSizeDest as DWORD
	dwAlignStrideAlign as DWORD
	dwRops(0 to DD_ROP_SPACE-1) as DWORD
	ddsCaps as DDSCAPS
	dwMinOverlayStretch as DWORD
	dwMaxOverlayStretch as DWORD
	dwMinLiveVideoStretch as DWORD
	dwMaxLiveVideoStretch as DWORD
	dwMinHwCodecStretch as DWORD
	dwMaxHwCodecStretch as DWORD
	dwReserved1 as DWORD
	dwReserved2 as DWORD
	dwReserved3 as DWORD
end type

type LPDDCAPS_DX1 as DDCAPS_DX1 ptr

type DDCAPS_DX3
	dwSize as DWORD
	dwCaps as DWORD
	dwCaps2 as DWORD
	dwCKeyCaps as DWORD
	dwFXCaps as DWORD
	dwFXAlphaCaps as DWORD
	dwPalCaps as DWORD
	dwSVCaps as DWORD
	dwAlphaBltConstBitDepths as DWORD
	dwAlphaBltPixelBitDepths as DWORD
	dwAlphaBltSurfaceBitDepths as DWORD
	dwAlphaOverlayConstBitDepths as DWORD
	dwAlphaOverlayPixelBitDepths as DWORD
	dwAlphaOverlaySurfaceBitDepths as DWORD
	dwZBufferBitDepths as DWORD
	dwVidMemTotal as DWORD
	dwVidMemFree as DWORD
	dwMaxVisibleOverlays as DWORD
	dwCurrVisibleOverlays as DWORD
	dwNumFourCCCodes as DWORD
	dwAlignBoundarySrc as DWORD
	dwAlignSizeSrc as DWORD
	dwAlignBoundaryDest as DWORD
	dwAlignSizeDest as DWORD
	dwAlignStrideAlign as DWORD
	dwRops(0 to DD_ROP_SPACE-1) as DWORD
	ddsCaps as DDSCAPS
	dwMinOverlayStretch as DWORD
	dwMaxOverlayStretch as DWORD
	dwMinLiveVideoStretch as DWORD
	dwMaxLiveVideoStretch as DWORD
	dwMinHwCodecStretch as DWORD
	dwMaxHwCodecStretch as DWORD
	dwReserved1 as DWORD
	dwReserved2 as DWORD
	dwReserved3 as DWORD
	dwSVBCaps as DWORD
	dwSVBCKeyCaps as DWORD
	dwSVBFXCaps as DWORD
	dwSVBRops(0 to DD_ROP_SPACE-1) as DWORD
	dwVSBCaps as DWORD
	dwVSBCKeyCaps as DWORD
	dwVSBFXCaps as DWORD
	dwVSBRops(0 to DD_ROP_SPACE-1) as DWORD
	dwSSBCaps as DWORD
	dwSSBCKeyCaps as DWORD
	dwSSBFXCaps as DWORD
	dwSSBRops(0 to DD_ROP_SPACE-1) as DWORD
	dwReserved4 as DWORD
	dwReserved5 as DWORD
	dwReserved6 as DWORD
end type

type LPDDCAPS_DX3 as DDCAPS_DX3 ptr

type DDCAPS_DX5
	dwSize as DWORD
	dwCaps as DWORD
	dwCaps2 as DWORD
	dwCKeyCaps as DWORD
	dwFXCaps as DWORD
	dwFXAlphaCaps as DWORD
	dwPalCaps as DWORD
	dwSVCaps as DWORD
	dwAlphaBltConstBitDepths as DWORD
	dwAlphaBltPixelBitDepths as DWORD
	dwAlphaBltSurfaceBitDepths as DWORD
	dwAlphaOverlayConstBitDepths as DWORD
	dwAlphaOverlayPixelBitDepths as DWORD
	dwAlphaOverlaySurfaceBitDepths as DWORD
	dwZBufferBitDepths as DWORD
	dwVidMemTotal as DWORD
	dwVidMemFree as DWORD
	dwMaxVisibleOverlays as DWORD
	dwCurrVisibleOverlays as DWORD
	dwNumFourCCCodes as DWORD
	dwAlignBoundarySrc as DWORD
	dwAlignSizeSrc as DWORD
	dwAlignBoundaryDest as DWORD
	dwAlignSizeDest as DWORD
	dwAlignStrideAlign as DWORD
	dwRops(0 to DD_ROP_SPACE-1) as DWORD
	ddsCaps as DDSCAPS
	dwMinOverlayStretch as DWORD
	dwMaxOverlayStretch as DWORD
	dwMinLiveVideoStretch as DWORD
	dwMaxLiveVideoStretch as DWORD
	dwMinHwCodecStretch as DWORD
	dwMaxHwCodecStretch as DWORD
	dwReserved1 as DWORD
	dwReserved2 as DWORD
	dwReserved3 as DWORD
	dwSVBCaps as DWORD
	dwSVBCKeyCaps as DWORD
	dwSVBFXCaps as DWORD
	dwSVBRops(0 to DD_ROP_SPACE-1) as DWORD
	dwVSBCaps as DWORD
	dwVSBCKeyCaps as DWORD
	dwVSBFXCaps as DWORD
	dwVSBRops(0 to DD_ROP_SPACE-1) as DWORD
	dwSSBCaps as DWORD
	dwSSBCKeyCaps as DWORD
	dwSSBFXCaps as DWORD
	dwSSBRops(0 to DD_ROP_SPACE-1) as DWORD
	dwMaxVideoPorts as DWORD
	dwCurrVideoPorts as DWORD
	dwSVBCaps2 as DWORD
	dwNLVBCaps as DWORD
	dwNLVBCaps2 as DWORD
	dwNLVBCKeyCaps as DWORD
	dwNLVBFXCaps as DWORD
	dwNLVBRops(0 to DD_ROP_SPACE-1) as DWORD
end type

type LPDDCAPS_DX5 as DDCAPS_DX5 ptr

type DDCAPS_DX6
	dwSize as DWORD
	dwCaps as DWORD
	dwCaps2 as DWORD
	dwCKeyCaps as DWORD
	dwFXCaps as DWORD
	dwFXAlphaCaps as DWORD
	dwPalCaps as DWORD
	dwSVCaps as DWORD
	dwAlphaBltConstBitDepths as DWORD
	dwAlphaBltPixelBitDepths as DWORD
	dwAlphaBltSurfaceBitDepths as DWORD
	dwAlphaOverlayConstBitDepths as DWORD
	dwAlphaOverlayPixelBitDepths as DWORD
	dwAlphaOverlaySurfaceBitDepths as DWORD
	dwZBufferBitDepths as DWORD
	dwVidMemTotal as DWORD
	dwVidMemFree as DWORD
	dwMaxVisibleOverlays as DWORD
	dwCurrVisibleOverlays as DWORD
	dwNumFourCCCodes as DWORD
	dwAlignBoundarySrc as DWORD
	dwAlignSizeSrc as DWORD
	dwAlignBoundaryDest as DWORD
	dwAlignSizeDest as DWORD
	dwAlignStrideAlign as DWORD
	dwRops(0 to DD_ROP_SPACE-1) as DWORD
	ddsOldCaps as DDSCAPS
	dwMinOverlayStretch as DWORD
	dwMaxOverlayStretch as DWORD
	dwMinLiveVideoStretch as DWORD
	dwMaxLiveVideoStretch as DWORD
	dwMinHwCodecStretch as DWORD
	dwMaxHwCodecStretch as DWORD
	dwReserved1 as DWORD
	dwReserved2 as DWORD
	dwReserved3 as DWORD
	dwSVBCaps as DWORD
	dwSVBCKeyCaps as DWORD
	dwSVBFXCaps as DWORD
	dwSVBRops(0 to DD_ROP_SPACE-1) as DWORD
	dwVSBCaps as DWORD
	dwVSBCKeyCaps as DWORD
	dwVSBFXCaps as DWORD
	dwVSBRops(0 to DD_ROP_SPACE-1) as DWORD
	dwSSBCaps as DWORD
	dwSSBCKeyCaps as DWORD
	dwSSBFXCaps as DWORD
	dwSSBRops(0 to DD_ROP_SPACE-1) as DWORD
	dwMaxVideoPorts as DWORD
	dwCurrVideoPorts as DWORD
	dwSVBCaps2 as DWORD
	dwNLVBCaps as DWORD
	dwNLVBCaps2 as DWORD
	dwNLVBCKeyCaps as DWORD
	dwNLVBFXCaps as DWORD
	dwNLVBRops(0 to DD_ROP_SPACE-1) as DWORD
	ddsCaps as DDSCAPS2
end type

type LPDDCAPS_DX6 as DDCAPS_DX6 ptr

type DDCAPS_DX7
	dwSize as DWORD
	dwCaps as DWORD
	dwCaps2 as DWORD
	dwCKeyCaps as DWORD
	dwFXCaps as DWORD
	dwFXAlphaCaps as DWORD
	dwPalCaps as DWORD
	dwSVCaps as DWORD
	dwAlphaBltConstBitDepths as DWORD
	dwAlphaBltPixelBitDepths as DWORD
	dwAlphaBltSurfaceBitDepths as DWORD
	dwAlphaOverlayConstBitDepths as DWORD
	dwAlphaOverlayPixelBitDepths as DWORD
	dwAlphaOverlaySurfaceBitDepths as DWORD
	dwZBufferBitDepths as DWORD
	dwVidMemTotal as DWORD
	dwVidMemFree as DWORD
	dwMaxVisibleOverlays as DWORD
	dwCurrVisibleOverlays as DWORD
	dwNumFourCCCodes as DWORD
	dwAlignBoundarySrc as DWORD
	dwAlignSizeSrc as DWORD
	dwAlignBoundaryDest as DWORD
	dwAlignSizeDest as DWORD
	dwAlignStrideAlign as DWORD
	dwRops(0 to DD_ROP_SPACE-1) as DWORD
	ddsOldCaps as DDSCAPS
	dwMinOverlayStretch as DWORD
	dwMaxOverlayStretch as DWORD
	dwMinLiveVideoStretch as DWORD
	dwMaxLiveVideoStretch as DWORD
	dwMinHwCodecStretch as DWORD
	dwMaxHwCodecStretch as DWORD
	dwReserved1 as DWORD
	dwReserved2 as DWORD
	dwReserved3 as DWORD
	dwSVBCaps as DWORD
	dwSVBCKeyCaps as DWORD
	dwSVBFXCaps as DWORD
	dwSVBRops(0 to DD_ROP_SPACE-1) as DWORD
	dwVSBCaps as DWORD
	dwVSBCKeyCaps as DWORD
	dwVSBFXCaps as DWORD
	dwVSBRops(0 to DD_ROP_SPACE-1) as DWORD
	dwSSBCaps as DWORD
	dwSSBCKeyCaps as DWORD
	dwSSBFXCaps as DWORD
	dwSSBRops(0 to DD_ROP_SPACE-1) as DWORD
	dwMaxVideoPorts as DWORD
	dwCurrVideoPorts as DWORD
	dwSVBCaps2 as DWORD
	dwNLVBCaps as DWORD
	dwNLVBCaps2 as DWORD
	dwNLVBCKeyCaps as DWORD
	dwNLVBFXCaps as DWORD
	dwNLVBRops(0 to DD_ROP_SPACE-1) as DWORD
	ddsCaps as DDSCAPS2
end type

type LPDDCAPS_DX7 as DDCAPS_DX7 ptr

#if DIRECTDRAW_VERSION <= &h300
    type DDCAPS as DDCAPS_DX3
#elseif DIRECTDRAW_VERSION <= &h500
    type DDCAPS as DDCAPS_DX5
#elseif DIRECTDRAW_VERSION <= &h600
    type DDCAPS as DDCAPS_DX6
#else
    type DDCAPS as DDCAPS_DX7
#endif

type LPDDCAPS as DDCAPS ptr

type DDPIXELFORMAT_MultiSampleCaps
	wFlipMSTypes as WORD
	wBltMSTypes as WORD
end type

type DDPIXELFORMAT
	dwSize as DWORD
	dwFlags as DWORD
	dwFourCC as DWORD
	union
		dwRGBBitCount as DWORD
		dwYUVBitCount as DWORD
		dwZBufferBitDepth as DWORD
		dwAlphaBitDepth as DWORD
		dwLuminanceBitCount as DWORD
		dwBumpBitCount as DWORD
		dwPrivateFormatBitCount as DWORD
	end union
	union
		dwRBitMask as DWORD
		dwYBitMask as DWORD
		dwStencilBitDepth as DWORD
		dwLuminanceBitMask as DWORD
		dwBumpDuBitMask as DWORD
		dwOperations as DWORD
	end union
	union
		dwGBitMask as DWORD
		dwUBitMask as DWORD
		dwZBitMask as DWORD
		dwBumpDvBitMask as DWORD
		MultiSampleCaps as DDPIXELFORMAT_MultiSampleCaps
	end union
	union
		dwBBitMask as DWORD
		dwVBitMask as DWORD
		dwStencilBitMask as DWORD
		dwBumpLuminanceBitMask as DWORD
	end union
	union
		dwRGBAlphaBitMask as DWORD
		dwYUVAlphaBitMask as DWORD
		dwLuminanceAlphaBitMask as DWORD
		dwRGBZBitMask as DWORD
		dwYUVZBitMask as DWORD
	end union
end type

type LPDDPIXELFORMAT as DDPIXELFORMAT ptr

type DDOVERLAYFX
	dwSize as DWORD
	dwAlphaEdgeBlendBitDepth as DWORD
	dwAlphaEdgeBlend as DWORD
	dwReserved as DWORD
	dwAlphaDestConstBitDepth as DWORD
	union
		dwAlphaDestConst as DWORD
		lpDDSAlphaDest as LPDIRECTDRAWSURFACE
	end union
	dwAlphaSrcConstBitDepth as DWORD
	union
		dwAlphaSrcConst as DWORD
		lpDDSAlphaSrc as LPDIRECTDRAWSURFACE
	end union
	dckDestColorkey as DDCOLORKEY
	dckSrcColorkey as DDCOLORKEY
	dwDDFX as DWORD
	dwFlags as DWORD
end type

type LPDDOVERLAYFX as DDOVERLAYFX ptr

type DDBLTBATCH
	lprDest as LPRECT
	lpDDSSrc as LPDIRECTDRAWSURFACE
	lprSrc as LPRECT
	dwFlags as DWORD
	lpDDBltFx as LPDDBLTFX
end type

type LPDDBLTBATCH as DDBLTBATCH ptr

type DDGAMMARAMP
	red(0 to 256-1) as WORD
	green(0 to 256-1) as WORD
	blue(0 to 256-1) as WORD
end type

type LPDDGAMMARAMP as DDGAMMARAMP ptr

#define MAX_DDDEVICEID_STRING 512

type DDDEVICEIDENTIFIER
	szDriver as zstring * MAX_DDDEVICEID_STRING
	szDescription as zstring * MAX_DDDEVICEID_STRING
	liDriverVersion as LARGE_INTEGER
	dwVendorId as DWORD
	dwDeviceId as DWORD
	dwSubSysId as DWORD
	dwRevision as DWORD
	guidDeviceIdentifier as GUID
end type

type LPDDDEVICEIDENTIFIER as DDDEVICEIDENTIFIER ptr

type DDDEVICEIDENTIFIER2
	szDriver as zstring * MAX_DDDEVICEID_STRING
	szDescription as zstring * MAX_DDDEVICEID_STRING
	liDriverVersion as LARGE_INTEGER
	dwVendorId as DWORD
	dwDeviceId as DWORD
	dwSubSysId as DWORD
	dwRevision as DWORD
	guidDeviceIdentifier as GUID
	dwWHQLLevel as DWORD
end type

type LPDDDEVICEIDENTIFIER2 as DDDEVICEIDENTIFIER2 ptr

#define DDGDI_GETHOSTIDENTIFIER &h00000001L

#define GET_WHQL_YEAR( dwWHQLLevel ) ( (dwWHQLLevel) \ &h10000 )
#define GET_WHQL_MONTH( dwWHQLLevel ) ( ( (dwWHQLLevel) \ &h100 ) and &h00ff )
#define GET_WHQL_DAY( dwWHQLLevel ) ( (dwWHQLLevel) and &hff )


type LPCLIPPERCALLBACK as function (byval as LPDIRECTDRAWCLIPPER, byval as HWND, byval as DWORD, byval as LPVOID) as DWORD

type IDirectDrawVtbl_ as IDirectDrawVtbl

type IDirectDraw
	lpVtbl as IDirectDrawVtbl_ ptr
end type

type IDirectDrawVtbl
	QueryInterface as function (byval as IDirectDraw ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectDraw ptr) as ULONG
	Release as function (byval as IDirectDraw ptr) as ULONG
	Compact as function (byval as IDirectDraw ptr) as HRESULT
	CreateClipper as function (byval as IDirectDraw ptr, byval as DWORD, byval as LPDIRECTDRAWCLIPPER ptr, byval as IUnknown ptr) as HRESULT
	CreatePalette as function (byval as IDirectDraw ptr, byval as DWORD, byval as LPPALETTEENTRY, byval as LPDIRECTDRAWPALETTE ptr, byval as IUnknown ptr) as HRESULT
	CreateSurface as function (byval as IDirectDraw ptr, byval as LPDDSURFACEDESC, byval as LPDIRECTDRAWSURFACE ptr, byval as IUnknown ptr) as HRESULT
	DuplicateSurface as function (byval as IDirectDraw ptr, byval as LPDIRECTDRAWSURFACE, byval as LPDIRECTDRAWSURFACE ptr) as HRESULT
	EnumDisplayModes as function (byval as IDirectDraw ptr, byval as DWORD, byval as LPDDSURFACEDESC, byval as LPVOID, byval as LPDDENUMMODESCALLBACK) as HRESULT
	EnumSurfaces as function (byval as IDirectDraw ptr, byval as DWORD, byval as LPDDSURFACEDESC, byval as LPVOID, byval as LPDDENUMSURFACESCALLBACK) as HRESULT
	FlipToGDISurface as function (byval as IDirectDraw ptr) as HRESULT
	GetCaps as function (byval as IDirectDraw ptr, byval as LPDDCAPS, byval as LPDDCAPS) as HRESULT
	GetDisplayMode as function (byval as IDirectDraw ptr, byval as LPDDSURFACEDESC) as HRESULT
	GetFourCCCodes as function (byval as IDirectDraw ptr, byval as LPDWORD, byval as LPDWORD) as HRESULT
	GetGDISurface as function (byval as IDirectDraw ptr, byval as LPDIRECTDRAWSURFACE ptr) as HRESULT
	GetMonitorFrequency as function (byval as IDirectDraw ptr, byval as LPDWORD) as HRESULT
	GetScanLine as function (byval as IDirectDraw ptr, byval as LPDWORD) as HRESULT
	GetVerticalBlankStatus as function (byval as IDirectDraw ptr, byval as LPBOOL) as HRESULT
	Initialize as function (byval as IDirectDraw ptr, byval as GUID ptr) as HRESULT
	RestoreDisplayMode as function (byval as IDirectDraw ptr) as HRESULT
	SetCooperativeLevel as function (byval as IDirectDraw ptr, byval as HWND, byval as DWORD) as HRESULT
	SetDisplayMode as function (byval as IDirectDraw ptr, byval as DWORD, byval as DWORD, byval as DWORD) as HRESULT
	WaitForVerticalBlank as function (byval as IDirectDraw ptr, byval as DWORD, byval as HANDLE) as HRESULT
end type

#define IDirectDraw_QueryInterface(p, a, b)         (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectDraw_AddRef(p)                       (p)->lpVtbl->AddRef(p)
#define IDirectDraw_Release(p)                      (p)->lpVtbl->Release(p)
#define IDirectDraw_Compact(p)                      (p)->lpVtbl->Compact(p)
#define IDirectDraw_CreateClipper(p, a, b, c)       (p)->lpVtbl->CreateClipper(p, a, b, c)
#define IDirectDraw_CreatePalette(p, a, b, c, d)    (p)->lpVtbl->CreatePalette(p, a, b, c, d)
#define IDirectDraw_CreateSurface(p, a, b, c)       (p)->lpVtbl->CreateSurface(p, a, b, c)
#define IDirectDraw_DuplicateSurface(p, a, b)       (p)->lpVtbl->DuplicateSurface(p, a, b)
#define IDirectDraw_EnumDisplayModes(p, a, b, c, d) (p)->lpVtbl->EnumDisplayModes(p, a, b, c, d)
#define IDirectDraw_EnumSurfaces(p, a, b, c, d)     (p)->lpVtbl->EnumSurfaces(p, a, b, c, d)
#define IDirectDraw_FlipToGDISurface(p)             (p)->lpVtbl->FlipToGDISurface(p)
#define IDirectDraw_GetCaps(p, a, b)                (p)->lpVtbl->GetCaps(p, a, b)
#define IDirectDraw_GetDisplayMode(p, a)            (p)->lpVtbl->GetDisplayMode(p, a)
#define IDirectDraw_GetFourCCCodes(p, a, b)         (p)->lpVtbl->GetFourCCCodes(p, a, b)
#define IDirectDraw_GetGDISurface(p, a)             (p)->lpVtbl->GetGDISurface(p, a)
#define IDirectDraw_GetMonitorFrequency(p, a)       (p)->lpVtbl->GetMonitorFrequency(p, a)
#define IDirectDraw_GetScanLine(p, a)               (p)->lpVtbl->GetScanLine(p, a)
#define IDirectDraw_GetVerticalBlankStatus(p, a)    (p)->lpVtbl->GetVerticalBlankStatus(p, a)
#define IDirectDraw_Initialize(p, a)                (p)->lpVtbl->Initialize(p, a)
#define IDirectDraw_RestoreDisplayMode(p)           (p)->lpVtbl->RestoreDisplayMode(p)
#define IDirectDraw_SetCooperativeLevel(p, a, b)    (p)->lpVtbl->SetCooperativeLevel(p, a, b)
#define IDirectDraw_SetDisplayMode(p, a, b, c)      (p)->lpVtbl->SetDisplayMode(p, a, b, c)
#define IDirectDraw_WaitForVerticalBlank(p, a, b)   (p)->lpVtbl->WaitForVerticalBlank(p, a, b)


type IDirectDraw2Vtbl_ as IDirectDraw2Vtbl

type IDirectDraw2
	lpVtbl as IDirectDraw2Vtbl_ ptr
end type

type IDirectDraw2Vtbl
	QueryInterface as function (byval as IDirectDraw2 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectDraw2 ptr) as ULONG
	Release as function (byval as IDirectDraw2 ptr) as ULONG
	Compact as function (byval as IDirectDraw2 ptr) as HRESULT
	CreateClipper as function (byval as IDirectDraw2 ptr, byval as DWORD, byval as LPDIRECTDRAWCLIPPER ptr, byval as IUnknown ptr) as HRESULT
	CreatePalette as function (byval as IDirectDraw2 ptr, byval as DWORD, byval as LPPALETTEENTRY, byval as LPDIRECTDRAWPALETTE ptr, byval as IUnknown ptr) as HRESULT
	CreateSurface as function (byval as IDirectDraw2 ptr, byval as LPDDSURFACEDESC, byval as LPDIRECTDRAWSURFACE ptr, byval as IUnknown ptr) as HRESULT
	DuplicateSurface as function (byval as IDirectDraw2 ptr, byval as LPDIRECTDRAWSURFACE, byval as LPDIRECTDRAWSURFACE ptr) as HRESULT
	EnumDisplayModes as function (byval as IDirectDraw2 ptr, byval as DWORD, byval as LPDDSURFACEDESC, byval as LPVOID, byval as LPDDENUMMODESCALLBACK) as HRESULT
	EnumSurfaces as function (byval as IDirectDraw2 ptr, byval as DWORD, byval as LPDDSURFACEDESC, byval as LPVOID, byval as LPDDENUMSURFACESCALLBACK) as HRESULT
	FlipToGDISurface as function (byval as IDirectDraw2 ptr) as HRESULT
	GetCaps as function (byval as IDirectDraw2 ptr, byval as LPDDCAPS, byval as LPDDCAPS) as HRESULT
	GetDisplayMode as function (byval as IDirectDraw2 ptr, byval as LPDDSURFACEDESC) as HRESULT
	GetFourCCCodes as function (byval as IDirectDraw2 ptr, byval as LPDWORD, byval as LPDWORD) as HRESULT
	GetGDISurface as function (byval as IDirectDraw2 ptr, byval as LPDIRECTDRAWSURFACE ptr) as HRESULT
	GetMonitorFrequency as function (byval as IDirectDraw2 ptr, byval as LPDWORD) as HRESULT
	GetScanLine as function (byval as IDirectDraw2 ptr, byval as LPDWORD) as HRESULT
	GetVerticalBlankStatus as function (byval as IDirectDraw2 ptr, byval as LPBOOL) as HRESULT
	Initialize as function (byval as IDirectDraw2 ptr, byval as GUID ptr) as HRESULT
	RestoreDisplayMode as function (byval as IDirectDraw2 ptr) as HRESULT
	SetCooperativeLevel as function (byval as IDirectDraw2 ptr, byval as HWND, byval as DWORD) as HRESULT
	SetDisplayMode as function (byval as IDirectDraw2 ptr, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD) as HRESULT
	WaitForVerticalBlank as function (byval as IDirectDraw2 ptr, byval as DWORD, byval as HANDLE) as HRESULT
	GetAvailableVidMem as function (byval as IDirectDraw2 ptr, byval as LPDDSCAPS, byval as LPDWORD, byval as LPDWORD) as HRESULT
end type

#define IDirectDraw2_QueryInterface(p, a, b)         (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectDraw2_AddRef(p)                       (p)->lpVtbl->AddRef(p)
#define IDirectDraw2_Release(p)                      (p)->lpVtbl->Release(p)
#define IDirectDraw2_Compact(p)                      (p)->lpVtbl->Compact(p)
#define IDirectDraw2_CreateClipper(p, a, b, c)       (p)->lpVtbl->CreateClipper(p, a, b, c)
#define IDirectDraw2_CreatePalette(p, a, b, c, d)    (p)->lpVtbl->CreatePalette(p, a, b, c, d)
#define IDirectDraw2_CreateSurface(p, a, b, c)       (p)->lpVtbl->CreateSurface(p, a, b, c)
#define IDirectDraw2_DuplicateSurface(p, a, b)       (p)->lpVtbl->DuplicateSurface(p, a, b)
#define IDirectDraw2_EnumDisplayModes(p, a, b, c, d) (p)->lpVtbl->EnumDisplayModes(p, a, b, c, d)
#define IDirectDraw2_EnumSurfaces(p, a, b, c, d)     (p)->lpVtbl->EnumSurfaces(p, a, b, c, d)
#define IDirectDraw2_FlipToGDISurface(p)             (p)->lpVtbl->FlipToGDISurface(p)
#define IDirectDraw2_GetCaps(p, a, b)                (p)->lpVtbl->GetCaps(p, a, b)
#define IDirectDraw2_GetDisplayMode(p, a)            (p)->lpVtbl->GetDisplayMode(p, a)
#define IDirectDraw2_GetFourCCCodes(p, a, b)         (p)->lpVtbl->GetFourCCCodes(p, a, b)
#define IDirectDraw2_GetGDISurface(p, a)             (p)->lpVtbl->GetGDISurface(p, a)
#define IDirectDraw2_GetMonitorFrequency(p, a)       (p)->lpVtbl->GetMonitorFrequency(p, a)
#define IDirectDraw2_GetScanLine(p, a)               (p)->lpVtbl->GetScanLine(p, a)
#define IDirectDraw2_GetVerticalBlankStatus(p, a)    (p)->lpVtbl->GetVerticalBlankStatus(p, a)
#define IDirectDraw2_Initialize(p, a)                (p)->lpVtbl->Initialize(p, a)
#define IDirectDraw2_RestoreDisplayMode(p)           (p)->lpVtbl->RestoreDisplayMode(p)
#define IDirectDraw2_SetCooperativeLevel(p, a, b)    (p)->lpVtbl->SetCooperativeLevel(p, a, b)
#define IDirectDraw2_SetDisplayMode(p, a, b, c, d, e) (p)->lpVtbl->SetDisplayMode(p, a, b, c, d, e)
#define IDirectDraw2_WaitForVerticalBlank(p, a, b)   (p)->lpVtbl->WaitForVerticalBlank(p, a, b)
#define IDirectDraw2_GetAvailableVidMem(p, a, b, c)  (p)->lpVtbl->GetAvailableVidMem(p, a, b, c)


type IDirectDraw4Vtbl_ as IDirectDraw4Vtbl

type IDirectDraw4
	lpVtbl as IDirectDraw4Vtbl_ ptr
end type

type IDirectDraw4Vtbl
	QueryInterface as function (byval as IDirectDraw4 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectDraw4 ptr) as ULONG
	Release as function (byval as IDirectDraw4 ptr) as ULONG
	Compact as function (byval as IDirectDraw4 ptr) as HRESULT
	CreateClipper as function (byval as IDirectDraw4 ptr, byval as DWORD, byval as LPDIRECTDRAWCLIPPER ptr, byval as IUnknown ptr) as HRESULT
	CreatePalette as function (byval as IDirectDraw4 ptr, byval as DWORD, byval as LPPALETTEENTRY, byval as LPDIRECTDRAWPALETTE ptr, byval as IUnknown ptr) as HRESULT
	CreateSurface as function (byval as IDirectDraw4 ptr, byval as LPDDSURFACEDESC2, byval as LPDIRECTDRAWSURFACE4 ptr, byval as IUnknown ptr) as HRESULT
	DuplicateSurface as function (byval as IDirectDraw4 ptr, byval as LPDIRECTDRAWSURFACE4, byval as LPDIRECTDRAWSURFACE4 ptr) as HRESULT
	EnumDisplayModes as function (byval as IDirectDraw4 ptr, byval as DWORD, byval as LPDDSURFACEDESC2, byval as LPVOID, byval as LPDDENUMMODESCALLBACK2) as HRESULT
	EnumSurfaces as function (byval as IDirectDraw4 ptr, byval as DWORD, byval as LPDDSURFACEDESC2, byval as LPVOID, byval as LPDDENUMSURFACESCALLBACK2) as HRESULT
	FlipToGDISurface as function (byval as IDirectDraw4 ptr) as HRESULT
	GetCaps as function (byval as IDirectDraw4 ptr, byval as LPDDCAPS, byval as LPDDCAPS) as HRESULT
	GetDisplayMode as function (byval as IDirectDraw4 ptr, byval as LPDDSURFACEDESC2) as HRESULT
	GetFourCCCodes as function (byval as IDirectDraw4 ptr, byval as LPDWORD, byval as LPDWORD) as HRESULT
	GetGDISurface as function (byval as IDirectDraw4 ptr, byval as LPDIRECTDRAWSURFACE4 ptr) as HRESULT
	GetMonitorFrequency as function (byval as IDirectDraw4 ptr, byval as LPDWORD) as HRESULT
	GetScanLine as function (byval as IDirectDraw4 ptr, byval as LPDWORD) as HRESULT
	GetVerticalBlankStatus as function (byval as IDirectDraw4 ptr, byval as LPBOOL) as HRESULT
	Initialize as function (byval as IDirectDraw4 ptr, byval as GUID ptr) as HRESULT
	RestoreDisplayMode as function (byval as IDirectDraw4 ptr) as HRESULT
	SetCooperativeLevel as function (byval as IDirectDraw4 ptr, byval as HWND, byval as DWORD) as HRESULT
	SetDisplayMode as function (byval as IDirectDraw4 ptr, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD) as HRESULT
	WaitForVerticalBlank as function (byval as IDirectDraw4 ptr, byval as DWORD, byval as HANDLE) as HRESULT
	GetAvailableVidMem as function (byval as IDirectDraw4 ptr, byval as LPDDSCAPS2, byval as LPDWORD, byval as LPDWORD) as HRESULT
	GetSurfaceFromDC as function (byval as IDirectDraw4 ptr, byval as HDC, byval as LPDIRECTDRAWSURFACE4 ptr) as HRESULT
	RestoreAllSurfaces as function (byval as IDirectDraw4 ptr) as HRESULT
	TestCooperativeLevel as function (byval as IDirectDraw4 ptr) as HRESULT
	GetDeviceIdentifier as function (byval as IDirectDraw4 ptr, byval as LPDDDEVICEIDENTIFIER, byval as DWORD) as HRESULT
end type

#define IDirectDraw4_QueryInterface(p, a, b)         (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectDraw4_AddRef(p)                       (p)->lpVtbl->AddRef(p)
#define IDirectDraw4_Release(p)                      (p)->lpVtbl->Release(p)
#define IDirectDraw4_Compact(p)                      (p)->lpVtbl->Compact(p)
#define IDirectDraw4_CreateClipper(p, a, b, c)       (p)->lpVtbl->CreateClipper(p, a, b, c)
#define IDirectDraw4_CreatePalette(p, a, b, c, d)    (p)->lpVtbl->CreatePalette(p, a, b, c, d)
#define IDirectDraw4_CreateSurface(p, a, b, c)       (p)->lpVtbl->CreateSurface(p, a, b, c)
#define IDirectDraw4_DuplicateSurface(p, a, b)       (p)->lpVtbl->DuplicateSurface(p, a, b)
#define IDirectDraw4_EnumDisplayModes(p, a, b, c, d) (p)->lpVtbl->EnumDisplayModes(p, a, b, c, d)
#define IDirectDraw4_EnumSurfaces(p, a, b, c, d)     (p)->lpVtbl->EnumSurfaces(p, a, b, c, d)
#define IDirectDraw4_FlipToGDISurface(p)             (p)->lpVtbl->FlipToGDISurface(p)
#define IDirectDraw4_GetCaps(p, a, b)                (p)->lpVtbl->GetCaps(p, a, b)
#define IDirectDraw4_GetDisplayMode(p, a)            (p)->lpVtbl->GetDisplayMode(p, a)
#define IDirectDraw4_GetFourCCCodes(p, a, b)         (p)->lpVtbl->GetFourCCCodes(p, a, b)
#define IDirectDraw4_GetGDISurface(p, a)             (p)->lpVtbl->GetGDISurface(p, a)
#define IDirectDraw4_GetMonitorFrequency(p, a)       (p)->lpVtbl->GetMonitorFrequency(p, a)
#define IDirectDraw4_GetScanLine(p, a)               (p)->lpVtbl->GetScanLine(p, a)
#define IDirectDraw4_GetVerticalBlankStatus(p, a)    (p)->lpVtbl->GetVerticalBlankStatus(p, a)
#define IDirectDraw4_Initialize(p, a)                (p)->lpVtbl->Initialize(p, a)
#define IDirectDraw4_RestoreDisplayMode(p)           (p)->lpVtbl->RestoreDisplayMode(p)
#define IDirectDraw4_SetCooperativeLevel(p, a, b)    (p)->lpVtbl->SetCooperativeLevel(p, a, b)
#define IDirectDraw4_SetDisplayMode(p, a, b, c, d, e) (p)->lpVtbl->SetDisplayMode(p, a, b, c, d, e)
#define IDirectDraw4_WaitForVerticalBlank(p, a, b)   (p)->lpVtbl->WaitForVerticalBlank(p, a, b)
#define IDirectDraw4_GetAvailableVidMem(p, a, b, c)  (p)->lpVtbl->GetAvailableVidMem(p, a, b, c)
#define IDirectDraw4_GetSurfaceFromDC(p, a, b)       (p)->lpVtbl->GetSurfaceFromDC(p, a, b)
#define IDirectDraw4_RestoreAllSurfaces(p)           (p)->lpVtbl->RestoreAllSurfaces(p)
#define IDirectDraw4_TestCooperativeLevel(p)         (p)->lpVtbl->TestCooperativeLevel(p)
#define IDirectDraw4_GetDeviceIdentifier(p,a,b)      (p)->lpVtbl->GetDeviceIdentifier(p,a,b)


type IDirectDraw7Vtbl_ as IDirectDraw7Vtbl

type IDirectDraw7
	lpVtbl as IDirectDraw7Vtbl_ ptr
end type

type IDirectDraw7Vtbl
	QueryInterface as function (byval as IDirectDraw7 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectDraw7 ptr) as ULONG
	Release as function (byval as IDirectDraw7 ptr) as ULONG
	Compact as function (byval as IDirectDraw7 ptr) as HRESULT
	CreateClipper as function (byval as IDirectDraw7 ptr, byval as DWORD, byval as LPDIRECTDRAWCLIPPER ptr, byval as IUnknown ptr) as HRESULT
	CreatePalette as function (byval as IDirectDraw7 ptr, byval as DWORD, byval as LPPALETTEENTRY, byval as LPDIRECTDRAWPALETTE ptr, byval as IUnknown ptr) as HRESULT
	CreateSurface as function (byval as IDirectDraw7 ptr, byval as LPDDSURFACEDESC2, byval as LPDIRECTDRAWSURFACE7 ptr, byval as IUnknown ptr) as HRESULT
	DuplicateSurface as function (byval as IDirectDraw7 ptr, byval as LPDIRECTDRAWSURFACE7, byval as LPDIRECTDRAWSURFACE7 ptr) as HRESULT
	EnumDisplayModes as function (byval as IDirectDraw7 ptr, byval as DWORD, byval as LPDDSURFACEDESC2, byval as LPVOID, byval as LPDDENUMMODESCALLBACK2) as HRESULT
	EnumSurfaces as function (byval as IDirectDraw7 ptr, byval as DWORD, byval as LPDDSURFACEDESC2, byval as LPVOID, byval as LPDDENUMSURFACESCALLBACK7) as HRESULT
	FlipToGDISurface as function (byval as IDirectDraw7 ptr) as HRESULT
	GetCaps as function (byval as IDirectDraw7 ptr, byval as LPDDCAPS, byval as LPDDCAPS) as HRESULT
	GetDisplayMode as function (byval as IDirectDraw7 ptr, byval as LPDDSURFACEDESC2) as HRESULT
	GetFourCCCodes as function (byval as IDirectDraw7 ptr, byval as LPDWORD, byval as LPDWORD) as HRESULT
	GetGDISurface as function (byval as IDirectDraw7 ptr, byval as LPDIRECTDRAWSURFACE7 ptr) as HRESULT
	GetMonitorFrequency as function (byval as IDirectDraw7 ptr, byval as LPDWORD) as HRESULT
	GetScanLine as function (byval as IDirectDraw7 ptr, byval as LPDWORD) as HRESULT
	GetVerticalBlankStatus as function (byval as IDirectDraw7 ptr, byval as LPBOOL) as HRESULT
	Initialize as function (byval as IDirectDraw7 ptr, byval as GUID ptr) as HRESULT
	RestoreDisplayMode as function (byval as IDirectDraw7 ptr) as HRESULT
	SetCooperativeLevel as function (byval as IDirectDraw7 ptr, byval as HWND, byval as DWORD) as HRESULT
	SetDisplayMode as function (byval as IDirectDraw7 ptr, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD) as HRESULT
	WaitForVerticalBlank as function (byval as IDirectDraw7 ptr, byval as DWORD, byval as HANDLE) as HRESULT
	GetAvailableVidMem as function (byval as IDirectDraw7 ptr, byval as LPDDSCAPS2, byval as LPDWORD, byval as LPDWORD) as HRESULT
	GetSurfaceFromDC as function (byval as IDirectDraw7 ptr, byval as HDC, byval as LPDIRECTDRAWSURFACE7 ptr) as HRESULT
	RestoreAllSurfaces as function (byval as IDirectDraw7 ptr) as HRESULT
	TestCooperativeLevel as function (byval as IDirectDraw7 ptr) as HRESULT
	GetDeviceIdentifier as function (byval as IDirectDraw7 ptr, byval as LPDDDEVICEIDENTIFIER2, byval as DWORD) as HRESULT
	StartModeTest as function (byval as IDirectDraw7 ptr, byval as LPSIZE, byval as DWORD, byval as DWORD) as HRESULT
	EvaluateMode as function (byval as IDirectDraw7 ptr, byval as DWORD, byval as DWORD ptr) as HRESULT
end type

#define IDirectDraw7_QueryInterface(p, a, b)         (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectDraw7_AddRef(p)                       (p)->lpVtbl->AddRef(p)
#define IDirectDraw7_Release(p)                      (p)->lpVtbl->Release(p)
#define IDirectDraw7_Compact(p)                      (p)->lpVtbl->Compact(p)
#define IDirectDraw7_CreateClipper(p, a, b, c)       (p)->lpVtbl->CreateClipper(p, a, b, c)
#define IDirectDraw7_CreatePalette(p, a, b, c, d)    (p)->lpVtbl->CreatePalette(p, a, b, c, d)
#define IDirectDraw7_CreateSurface(p, a, b, c)       (p)->lpVtbl->CreateSurface(p, a, b, c)
#define IDirectDraw7_DuplicateSurface(p, a, b)       (p)->lpVtbl->DuplicateSurface(p, a, b)
#define IDirectDraw7_EnumDisplayModes(p, a, b, c, d) (p)->lpVtbl->EnumDisplayModes(p, a, b, c, d)
#define IDirectDraw7_EnumSurfaces(p, a, b, c, d)     (p)->lpVtbl->EnumSurfaces(p, a, b, c, d)
#define IDirectDraw7_FlipToGDISurface(p)             (p)->lpVtbl->FlipToGDISurface(p)
#define IDirectDraw7_GetCaps(p, a, b)                (p)->lpVtbl->GetCaps(p, a, b)
#define IDirectDraw7_GetDisplayMode(p, a)            (p)->lpVtbl->GetDisplayMode(p, a)
#define IDirectDraw7_GetFourCCCodes(p, a, b)         (p)->lpVtbl->GetFourCCCodes(p, a, b)
#define IDirectDraw7_GetGDISurface(p, a)             (p)->lpVtbl->GetGDISurface(p, a)
#define IDirectDraw7_GetMonitorFrequency(p, a)       (p)->lpVtbl->GetMonitorFrequency(p, a)
#define IDirectDraw7_GetScanLine(p, a)               (p)->lpVtbl->GetScanLine(p, a)
#define IDirectDraw7_GetVerticalBlankStatus(p, a)    (p)->lpVtbl->GetVerticalBlankStatus(p, a)
#define IDirectDraw7_Initialize(p, a)                (p)->lpVtbl->Initialize(p, a)
#define IDirectDraw7_RestoreDisplayMode(p)           (p)->lpVtbl->RestoreDisplayMode(p)
#define IDirectDraw7_SetCooperativeLevel(p, a, b)    (p)->lpVtbl->SetCooperativeLevel(p, a, b)
#define IDirectDraw7_SetDisplayMode(p, a, b, c, d, e) (p)->lpVtbl->SetDisplayMode(p, a, b, c, d, e)
#define IDirectDraw7_WaitForVerticalBlank(p, a, b)   (p)->lpVtbl->WaitForVerticalBlank(p, a, b)
#define IDirectDraw7_GetAvailableVidMem(p, a, b, c)  (p)->lpVtbl->GetAvailableVidMem(p, a, b, c)
#define IDirectDraw7_GetSurfaceFromDC(p, a, b)       (p)->lpVtbl->GetSurfaceFromDC(p, a, b)
#define IDirectDraw7_RestoreAllSurfaces(p)           (p)->lpVtbl->RestoreAllSurfaces(p)
#define IDirectDraw7_TestCooperativeLevel(p)         (p)->lpVtbl->TestCooperativeLevel(p)
#define IDirectDraw7_GetDeviceIdentifier(p,a,b)      (p)->lpVtbl->GetDeviceIdentifier(p,a,b)
#define IDirectDraw7_StartModeTest(p,a,b,c)        (p)->lpVtbl->StartModeTest(p,a,b,c)
#define IDirectDraw7_EvaluateMode(p,a,b)           (p)->lpVtbl->EvaluateMode(p,a,b)


type IDirectDrawPaletteVtbl_ as IDirectDrawPaletteVtbl

type IDirectDrawPalette
	lpVtbl as IDirectDrawPaletteVtbl_ ptr
end type

type IDirectDrawPaletteVtbl
	QueryInterface as function (byval as IDirectDrawPalette ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectDrawPalette ptr) as ULONG
	Release as function (byval as IDirectDrawPalette ptr) as ULONG
	GetCaps as function (byval as IDirectDrawPalette ptr, byval as LPDWORD) as HRESULT
	GetEntries as function (byval as IDirectDrawPalette ptr, byval as DWORD, byval as DWORD, byval as DWORD, byval as LPPALETTEENTRY) as HRESULT
	Initialize as function (byval as IDirectDrawPalette ptr, byval as LPDIRECTDRAW, byval as DWORD, byval as LPPALETTEENTRY) as HRESULT
	SetEntries as function (byval as IDirectDrawPalette ptr, byval as DWORD, byval as DWORD, byval as DWORD, byval as LPPALETTEENTRY) as HRESULT
end type

#define IDirectDrawPalette_QueryInterface(p, a, b)      (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectDrawPalette_AddRef(p)                    (p)->lpVtbl->AddRef(p)
#define IDirectDrawPalette_Release(p)                   (p)->lpVtbl->Release(p)
#define IDirectDrawPalette_GetCaps(p, a)                (p)->lpVtbl->GetCaps(p, a)
#define IDirectDrawPalette_GetEntries(p, a, b, c, d)    (p)->lpVtbl->GetEntries(p, a, b, c, d)
#define IDirectDrawPalette_Initialize(p, a, b, c)       (p)->lpVtbl->Initialize(p, a, b, c)
#define IDirectDrawPalette_SetEntries(p, a, b, c, d)    (p)->lpVtbl->SetEntries(p, a, b, c, d)


type IDirectDrawClipperVtbl_ as IDirectDrawClipperVtbl

type IDirectDrawClipper
	lpVtbl as IDirectDrawClipperVtbl_ ptr
end type

type IDirectDrawClipperVtbl
	QueryInterface as function (byval as IDirectDrawClipper ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectDrawClipper ptr) as ULONG
	Release as function (byval as IDirectDrawClipper ptr) as ULONG
	GetClipList as function (byval as IDirectDrawClipper ptr, byval as LPRECT, byval as LPRGNDATA, byval as LPDWORD) as HRESULT
	GetHWnd as function (byval as IDirectDrawClipper ptr, byval as HWND ptr) as HRESULT
	Initialize as function (byval as IDirectDrawClipper ptr, byval as LPDIRECTDRAW, byval as DWORD) as HRESULT
	IsClipListChanged as function (byval as IDirectDrawClipper ptr, byval as BOOL ptr) as HRESULT
	SetClipList as function (byval as IDirectDrawClipper ptr, byval as LPRGNDATA, byval as DWORD) as HRESULT
	SetHWnd as function (byval as IDirectDrawClipper ptr, byval as DWORD, byval as HWND) as HRESULT
end type

#define IDirectDrawClipper_QueryInterface(p, a, b)  (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectDrawClipper_AddRef(p)                (p)->lpVtbl->AddRef(p)
#define IDirectDrawClipper_Release(p)               (p)->lpVtbl->Release(p)
#define IDirectDrawClipper_GetClipList(p, a, b, c)  (p)->lpVtbl->GetClipList(p, a, b, c)
#define IDirectDrawClipper_GetHWnd(p, a)            (p)->lpVtbl->GetHWnd(p, a)
#define IDirectDrawClipper_Initialize(p, a, b)      (p)->lpVtbl->Initialize(p, a, b)
#define IDirectDrawClipper_IsClipListChanged(p, a)  (p)->lpVtbl->IsClipListChanged(p, a)
#define IDirectDrawClipper_SetClipList(p, a, b)     (p)->lpVtbl->SetClipList(p, a, b)
#define IDirectDrawClipper_SetHWnd(p, a, b)         (p)->lpVtbl->SetHWnd(p, a, b)


type IDirectDrawSurfaceVtbl_ as IDirectDrawSurfaceVtbl

type IDirectDrawSurface
	lpVtbl as IDirectDrawSurfaceVtbl_ ptr
end type

type IDirectDrawSurfaceVtbl
	QueryInterface as function (byval as IDirectDrawSurface ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectDrawSurface ptr) as ULONG
	Release as function (byval as IDirectDrawSurface ptr) as ULONG
	AddAttachedSurface as function (byval as IDirectDrawSurface ptr, byval as LPDIRECTDRAWSURFACE) as HRESULT
	AddOverlayDirtyRect as function (byval as IDirectDrawSurface ptr, byval as LPRECT) as HRESULT
	Blt as function (byval as IDirectDrawSurface ptr, byval as LPRECT, byval as LPDIRECTDRAWSURFACE, byval as LPRECT, byval as DWORD, byval as LPDDBLTFX) as HRESULT
	BltBatch as function (byval as IDirectDrawSurface ptr, byval as LPDDBLTBATCH, byval as DWORD, byval as DWORD) as HRESULT
	BltFast as function (byval as IDirectDrawSurface ptr, byval as DWORD, byval as DWORD, byval as LPDIRECTDRAWSURFACE, byval as LPRECT, byval as DWORD) as HRESULT
	DeleteAttachedSurface as function (byval as IDirectDrawSurface ptr, byval as DWORD, byval as LPDIRECTDRAWSURFACE) as HRESULT
	EnumAttachedSurfaces as function (byval as IDirectDrawSurface ptr, byval as LPVOID, byval as LPDDENUMSURFACESCALLBACK) as HRESULT
	EnumOverlayZOrders as function (byval as IDirectDrawSurface ptr, byval as DWORD, byval as LPVOID, byval as LPDDENUMSURFACESCALLBACK) as HRESULT
	Flip as function (byval as IDirectDrawSurface ptr, byval as LPDIRECTDRAWSURFACE, byval as DWORD) as HRESULT
	GetAttachedSurface as function (byval as IDirectDrawSurface ptr, byval as LPDDSCAPS, byval as LPDIRECTDRAWSURFACE ptr) as HRESULT
	GetBltStatus as function (byval as IDirectDrawSurface ptr, byval as DWORD) as HRESULT
	GetCaps as function (byval as IDirectDrawSurface ptr, byval as LPDDSCAPS) as HRESULT
	GetClipper as function (byval as IDirectDrawSurface ptr, byval as LPDIRECTDRAWCLIPPER ptr) as HRESULT
	GetColorKey as function (byval as IDirectDrawSurface ptr, byval as DWORD, byval as LPDDCOLORKEY) as HRESULT
	GetDC as function (byval as IDirectDrawSurface ptr, byval as HDC ptr) as HRESULT
	GetFlipStatus as function (byval as IDirectDrawSurface ptr, byval as DWORD) as HRESULT
	GetOverlayPosition as function (byval as IDirectDrawSurface ptr, byval as LPLONG, byval as LPLONG) as HRESULT
	GetPalette as function (byval as IDirectDrawSurface ptr, byval as LPDIRECTDRAWPALETTE ptr) as HRESULT
	GetPixelFormat as function (byval as IDirectDrawSurface ptr, byval as LPDDPIXELFORMAT) as HRESULT
	GetSurfaceDesc as function (byval as IDirectDrawSurface ptr, byval as LPDDSURFACEDESC) as HRESULT
	Initialize as function (byval as IDirectDrawSurface ptr, byval as LPDIRECTDRAW, byval as LPDDSURFACEDESC) as HRESULT
	IsLost as function (byval as IDirectDrawSurface ptr) as HRESULT
	Lock as function (byval as IDirectDrawSurface ptr, byval as LPRECT, byval as LPDDSURFACEDESC, byval as DWORD, byval as HANDLE) as HRESULT
	ReleaseDC as function (byval as IDirectDrawSurface ptr, byval as HDC) as HRESULT
	Restore as function (byval as IDirectDrawSurface ptr) as HRESULT
	SetClipper as function (byval as IDirectDrawSurface ptr, byval as LPDIRECTDRAWCLIPPER) as HRESULT
	SetColorKey as function (byval as IDirectDrawSurface ptr, byval as DWORD, byval as LPDDCOLORKEY) as HRESULT
	SetOverlayPosition as function (byval as IDirectDrawSurface ptr, byval as LONG, byval as LONG) as HRESULT
	SetPalette as function (byval as IDirectDrawSurface ptr, byval as LPDIRECTDRAWPALETTE) as HRESULT
	Unlock as function (byval as IDirectDrawSurface ptr, byval as LPVOID) as HRESULT
	UpdateOverlay as function (byval as IDirectDrawSurface ptr, byval as LPRECT, byval as LPDIRECTDRAWSURFACE, byval as LPRECT, byval as DWORD, byval as LPDDOVERLAYFX) as HRESULT
	UpdateOverlayDisplay as function (byval as IDirectDrawSurface ptr, byval as DWORD) as HRESULT
	UpdateOverlayZOrder as function (byval as IDirectDrawSurface ptr, byval as DWORD, byval as LPDIRECTDRAWSURFACE) as HRESULT
end type

#define IDirectDrawSurface_QueryInterface(p,a,b)        (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirectDrawSurface_AddRef(p)                    (p)->lpVtbl->AddRef(p)
#define IDirectDrawSurface_Release(p)                   (p)->lpVtbl->Release(p)
#define IDirectDrawSurface_AddAttachedSurface(p,a)      (p)->lpVtbl->AddAttachedSurface(p,a)
#define IDirectDrawSurface_AddOverlayDirtyRect(p,a)     (p)->lpVtbl->AddOverlayDirtyRect(p,a)
#define IDirectDrawSurface_Blt(p,a,b,c,d,e)             (p)->lpVtbl->Blt(p,a,b,c,d,e)
#define IDirectDrawSurface_BltBatch(p,a,b,c)            (p)->lpVtbl->BltBatch(p,a,b,c)
#define IDirectDrawSurface_BltFast(p,a,b,c,d,e)         (p)->lpVtbl->BltFast(p,a,b,c,d,e)
#define IDirectDrawSurface_DeleteAttachedSurface(p,a,b) (p)->lpVtbl->DeleteAttachedSurface(p,a,b)
#define IDirectDrawSurface_EnumAttachedSurfaces(p,a,b)  (p)->lpVtbl->EnumAttachedSurfaces(p,a,b)
#define IDirectDrawSurface_EnumOverlayZOrders(p,a,b,c)  (p)->lpVtbl->EnumOverlayZOrders(p,a,b,c)
#define IDirectDrawSurface_Flip(p,a,b)                  (p)->lpVtbl->Flip(p,a,b)
#define IDirectDrawSurface_GetAttachedSurface(p,a,b)    (p)->lpVtbl->GetAttachedSurface(p,a,b)
#define IDirectDrawSurface_GetBltStatus(p,a)            (p)->lpVtbl->GetBltStatus(p,a)
#define IDirectDrawSurface_GetCaps(p,b)                 (p)->lpVtbl->GetCaps(p,b)
#define IDirectDrawSurface_GetClipper(p,a)              (p)->lpVtbl->GetClipper(p,a)
#define IDirectDrawSurface_GetColorKey(p,a,b)           (p)->lpVtbl->GetColorKey(p,a,b)
#define IDirectDrawSurface_GetDC(p,a)                   (p)->lpVtbl->GetDC(p,a)
#define IDirectDrawSurface_GetFlipStatus(p,a)           (p)->lpVtbl->GetFlipStatus(p,a)
#define IDirectDrawSurface_GetOverlayPosition(p,a,b)    (p)->lpVtbl->GetOverlayPosition(p,a,b)
#define IDirectDrawSurface_GetPalette(p,a)              (p)->lpVtbl->GetPalette(p,a)
#define IDirectDrawSurface_GetPixelFormat(p,a)          (p)->lpVtbl->GetPixelFormat(p,a)
#define IDirectDrawSurface_GetSurfaceDesc(p,a)          (p)->lpVtbl->GetSurfaceDesc(p,a)
#define IDirectDrawSurface_Initialize(p,a,b)            (p)->lpVtbl->Initialize(p,a,b)
#define IDirectDrawSurface_IsLost(p)                    (p)->lpVtbl->IsLost(p)
#define IDirectDrawSurface_Lock(p,a,b,c,d)              (p)->lpVtbl->Lock(p,a,b,c,d)
#define IDirectDrawSurface_ReleaseDC(p,a)               (p)->lpVtbl->ReleaseDC(p,a)
#define IDirectDrawSurface_Restore(p)                   (p)->lpVtbl->Restore(p)
#define IDirectDrawSurface_SetClipper(p,a)              (p)->lpVtbl->SetClipper(p,a)
#define IDirectDrawSurface_SetColorKey(p,a,b)           (p)->lpVtbl->SetColorKey(p,a,b)
#define IDirectDrawSurface_SetOverlayPosition(p,a,b)    (p)->lpVtbl->SetOverlayPosition(p,a,b)
#define IDirectDrawSurface_SetPalette(p,a)              (p)->lpVtbl->SetPalette(p,a)
#define IDirectDrawSurface_Unlock(p,b)                  (p)->lpVtbl->Unlock(p,b)
#define IDirectDrawSurface_UpdateOverlay(p,a,b,c,d,e)   (p)->lpVtbl->UpdateOverlay(p,a,b,c,d,e)
#define IDirectDrawSurface_UpdateOverlayDisplay(p,a)    (p)->lpVtbl->UpdateOverlayDisplay(p,a)
#define IDirectDrawSurface_UpdateOverlayZOrder(p,a,b)   (p)->lpVtbl->UpdateOverlayZOrder(p,a,b)


type IDirectDrawSurface2Vtbl_ as IDirectDrawSurface2Vtbl

type IDirectDrawSurface2
	lpVtbl as IDirectDrawSurface2Vtbl_ ptr
end type

type IDirectDrawSurface2Vtbl
	QueryInterface as function (byval as IDirectDrawSurface2 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectDrawSurface2 ptr) as ULONG
	Release as function (byval as IDirectDrawSurface2 ptr) as ULONG
	AddAttachedSurface as function (byval as IDirectDrawSurface2 ptr, byval as LPDIRECTDRAWSURFACE2) as HRESULT
	AddOverlayDirtyRect as function (byval as IDirectDrawSurface2 ptr, byval as LPRECT) as HRESULT
	Blt as function (byval as IDirectDrawSurface2 ptr, byval as LPRECT, byval as LPDIRECTDRAWSURFACE2, byval as LPRECT, byval as DWORD, byval as LPDDBLTFX) as HRESULT
	BltBatch as function (byval as IDirectDrawSurface2 ptr, byval as LPDDBLTBATCH, byval as DWORD, byval as DWORD) as HRESULT
	BltFast as function (byval as IDirectDrawSurface2 ptr, byval as DWORD, byval as DWORD, byval as LPDIRECTDRAWSURFACE2, byval as LPRECT, byval as DWORD) as HRESULT
	DeleteAttachedSurface as function (byval as IDirectDrawSurface2 ptr, byval as DWORD, byval as LPDIRECTDRAWSURFACE2) as HRESULT
	EnumAttachedSurfaces as function (byval as IDirectDrawSurface2 ptr, byval as LPVOID, byval as LPDDENUMSURFACESCALLBACK) as HRESULT
	EnumOverlayZOrders as function (byval as IDirectDrawSurface2 ptr, byval as DWORD, byval as LPVOID, byval as LPDDENUMSURFACESCALLBACK) as HRESULT
	Flip as function (byval as IDirectDrawSurface2 ptr, byval as LPDIRECTDRAWSURFACE2, byval as DWORD) as HRESULT
	GetAttachedSurface as function (byval as IDirectDrawSurface2 ptr, byval as LPDDSCAPS, byval as LPDIRECTDRAWSURFACE2 ptr) as HRESULT
	GetBltStatus as function (byval as IDirectDrawSurface2 ptr, byval as DWORD) as HRESULT
	GetCaps as function (byval as IDirectDrawSurface2 ptr, byval as LPDDSCAPS) as HRESULT
	GetClipper as function (byval as IDirectDrawSurface2 ptr, byval as LPDIRECTDRAWCLIPPER ptr) as HRESULT
	GetColorKey as function (byval as IDirectDrawSurface2 ptr, byval as DWORD, byval as LPDDCOLORKEY) as HRESULT
	GetDC as function (byval as IDirectDrawSurface2 ptr, byval as HDC ptr) as HRESULT
	GetFlipStatus as function (byval as IDirectDrawSurface2 ptr, byval as DWORD) as HRESULT
	GetOverlayPosition as function (byval as IDirectDrawSurface2 ptr, byval as LPLONG, byval as LPLONG) as HRESULT
	GetPalette as function (byval as IDirectDrawSurface2 ptr, byval as LPDIRECTDRAWPALETTE ptr) as HRESULT
	GetPixelFormat as function (byval as IDirectDrawSurface2 ptr, byval as LPDDPIXELFORMAT) as HRESULT
	GetSurfaceDesc as function (byval as IDirectDrawSurface2 ptr, byval as LPDDSURFACEDESC) as HRESULT
	Initialize as function (byval as IDirectDrawSurface2 ptr, byval as LPDIRECTDRAW, byval as LPDDSURFACEDESC) as HRESULT
	IsLost as function (byval as IDirectDrawSurface2 ptr) as HRESULT
	Lock as function (byval as IDirectDrawSurface2 ptr, byval as LPRECT, byval as LPDDSURFACEDESC, byval as DWORD, byval as HANDLE) as HRESULT
	ReleaseDC as function (byval as IDirectDrawSurface2 ptr, byval as HDC) as HRESULT
	Restore as function (byval as IDirectDrawSurface2 ptr) as HRESULT
	SetClipper as function (byval as IDirectDrawSurface2 ptr, byval as LPDIRECTDRAWCLIPPER) as HRESULT
	SetColorKey as function (byval as IDirectDrawSurface2 ptr, byval as DWORD, byval as LPDDCOLORKEY) as HRESULT
	SetOverlayPosition as function (byval as IDirectDrawSurface2 ptr, byval as LONG, byval as LONG) as HRESULT
	SetPalette as function (byval as IDirectDrawSurface2 ptr, byval as LPDIRECTDRAWPALETTE) as HRESULT
	Unlock as function (byval as IDirectDrawSurface2 ptr, byval as LPVOID) as HRESULT
	UpdateOverlay as function (byval as IDirectDrawSurface2 ptr, byval as LPRECT, byval as LPDIRECTDRAWSURFACE2, byval as LPRECT, byval as DWORD, byval as LPDDOVERLAYFX) as HRESULT
	UpdateOverlayDisplay as function (byval as IDirectDrawSurface2 ptr, byval as DWORD) as HRESULT
	UpdateOverlayZOrder as function (byval as IDirectDrawSurface2 ptr, byval as DWORD, byval as LPDIRECTDRAWSURFACE2) as HRESULT
	GetDDInterface as function (byval as IDirectDrawSurface2 ptr, byval as LPVOID ptr) as HRESULT
	PageLock as function (byval as IDirectDrawSurface2 ptr, byval as DWORD) as HRESULT
	PageUnlock as function (byval as IDirectDrawSurface2 ptr, byval as DWORD) as HRESULT
end type

#define IDirectDrawSurface2_QueryInterface(p,a,b)        (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirectDrawSurface2_AddRef(p)                    (p)->lpVtbl->AddRef(p)
#define IDirectDrawSurface2_Release(p)                   (p)->lpVtbl->Release(p)
#define IDirectDrawSurface2_AddAttachedSurface(p,a)      (p)->lpVtbl->AddAttachedSurface(p,a)
#define IDirectDrawSurface2_AddOverlayDirtyRect(p,a)     (p)->lpVtbl->AddOverlayDirtyRect(p,a)
#define IDirectDrawSurface2_Blt(p,a,b,c,d,e)             (p)->lpVtbl->Blt(p,a,b,c,d,e)
#define IDirectDrawSurface2_BltBatch(p,a,b,c)            (p)->lpVtbl->BltBatch(p,a,b,c)
#define IDirectDrawSurface2_BltFast(p,a,b,c,d,e)         (p)->lpVtbl->BltFast(p,a,b,c,d,e)
#define IDirectDrawSurface2_DeleteAttachedSurface(p,a,b) (p)->lpVtbl->DeleteAttachedSurface(p,a,b)
#define IDirectDrawSurface2_EnumAttachedSurfaces(p,a,b)  (p)->lpVtbl->EnumAttachedSurfaces(p,a,b)
#define IDirectDrawSurface2_EnumOverlayZOrders(p,a,b,c)  (p)->lpVtbl->EnumOverlayZOrders(p,a,b,c)
#define IDirectDrawSurface2_Flip(p,a,b)                  (p)->lpVtbl->Flip(p,a,b)
#define IDirectDrawSurface2_GetAttachedSurface(p,a,b)    (p)->lpVtbl->GetAttachedSurface(p,a,b)
#define IDirectDrawSurface2_GetBltStatus(p,a)            (p)->lpVtbl->GetBltStatus(p,a)
#define IDirectDrawSurface2_GetCaps(p,b)                 (p)->lpVtbl->GetCaps(p,b)
#define IDirectDrawSurface2_GetClipper(p,a)              (p)->lpVtbl->GetClipper(p,a)
#define IDirectDrawSurface2_GetColorKey(p,a,b)           (p)->lpVtbl->GetColorKey(p,a,b)
#define IDirectDrawSurface2_GetDC(p,a)                   (p)->lpVtbl->GetDC(p,a)
#define IDirectDrawSurface2_GetFlipStatus(p,a)           (p)->lpVtbl->GetFlipStatus(p,a)
#define IDirectDrawSurface2_GetOverlayPosition(p,a,b)    (p)->lpVtbl->GetOverlayPosition(p,a,b)
#define IDirectDrawSurface2_GetPalette(p,a)              (p)->lpVtbl->GetPalette(p,a)
#define IDirectDrawSurface2_GetPixelFormat(p,a)          (p)->lpVtbl->GetPixelFormat(p,a)
#define IDirectDrawSurface2_GetSurfaceDesc(p,a)          (p)->lpVtbl->GetSurfaceDesc(p,a)
#define IDirectDrawSurface2_Initialize(p,a,b)            (p)->lpVtbl->Initialize(p,a,b)
#define IDirectDrawSurface2_IsLost(p)                    (p)->lpVtbl->IsLost(p)
#define IDirectDrawSurface2_Lock(p,a,b,c,d)              (p)->lpVtbl->Lock(p,a,b,c,d)
#define IDirectDrawSurface2_ReleaseDC(p,a)               (p)->lpVtbl->ReleaseDC(p,a)
#define IDirectDrawSurface2_Restore(p)                   (p)->lpVtbl->Restore(p)
#define IDirectDrawSurface2_SetClipper(p,a)              (p)->lpVtbl->SetClipper(p,a)
#define IDirectDrawSurface2_SetColorKey(p,a,b)           (p)->lpVtbl->SetColorKey(p,a,b)
#define IDirectDrawSurface2_SetOverlayPosition(p,a,b)    (p)->lpVtbl->SetOverlayPosition(p,a,b)
#define IDirectDrawSurface2_SetPalette(p,a)              (p)->lpVtbl->SetPalette(p,a)
#define IDirectDrawSurface2_Unlock(p,b)                  (p)->lpVtbl->Unlock(p,b)
#define IDirectDrawSurface2_UpdateOverlay(p,a,b,c,d,e)   (p)->lpVtbl->UpdateOverlay(p,a,b,c,d,e)
#define IDirectDrawSurface2_UpdateOverlayDisplay(p,a)    (p)->lpVtbl->UpdateOverlayDisplay(p,a)
#define IDirectDrawSurface2_UpdateOverlayZOrder(p,a,b)   (p)->lpVtbl->UpdateOverlayZOrder(p,a,b)
#define IDirectDrawSurface2_GetDDInterface(p,a)          (p)->lpVtbl->GetDDInterface(p,a)
#define IDirectDrawSurface2_PageLock(p,a)                (p)->lpVtbl->PageLock(p,a)
#define IDirectDrawSurface2_PageUnlock(p,a)              (p)->lpVtbl->PageUnlock(p,a)


type IDirectDrawSurface3Vtbl_ as IDirectDrawSurface3Vtbl

type IDirectDrawSurface3
	lpVtbl as IDirectDrawSurface3Vtbl_ ptr
end type

type IDirectDrawSurface3Vtbl
	QueryInterface as function (byval as IDirectDrawSurface3 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectDrawSurface3 ptr) as ULONG
	Release as function (byval as IDirectDrawSurface3 ptr) as ULONG
	AddAttachedSurface as function (byval as IDirectDrawSurface3 ptr, byval as LPDIRECTDRAWSURFACE3) as HRESULT
	AddOverlayDirtyRect as function (byval as IDirectDrawSurface3 ptr, byval as LPRECT) as HRESULT
	Blt as function (byval as IDirectDrawSurface3 ptr, byval as LPRECT, byval as LPDIRECTDRAWSURFACE3, byval as LPRECT, byval as DWORD, byval as LPDDBLTFX) as HRESULT
	BltBatch as function (byval as IDirectDrawSurface3 ptr, byval as LPDDBLTBATCH, byval as DWORD, byval as DWORD) as HRESULT
	BltFast as function (byval as IDirectDrawSurface3 ptr, byval as DWORD, byval as DWORD, byval as LPDIRECTDRAWSURFACE3, byval as LPRECT, byval as DWORD) as HRESULT
	DeleteAttachedSurface as function (byval as IDirectDrawSurface3 ptr, byval as DWORD, byval as LPDIRECTDRAWSURFACE3) as HRESULT
	EnumAttachedSurfaces as function (byval as IDirectDrawSurface3 ptr, byval as LPVOID, byval as LPDDENUMSURFACESCALLBACK) as HRESULT
	EnumOverlayZOrders as function (byval as IDirectDrawSurface3 ptr, byval as DWORD, byval as LPVOID, byval as LPDDENUMSURFACESCALLBACK) as HRESULT
	Flip as function (byval as IDirectDrawSurface3 ptr, byval as LPDIRECTDRAWSURFACE3, byval as DWORD) as HRESULT
	GetAttachedSurface as function (byval as IDirectDrawSurface3 ptr, byval as LPDDSCAPS, byval as LPDIRECTDRAWSURFACE3 ptr) as HRESULT
	GetBltStatus as function (byval as IDirectDrawSurface3 ptr, byval as DWORD) as HRESULT
	GetCaps as function (byval as IDirectDrawSurface3 ptr, byval as LPDDSCAPS) as HRESULT
	GetClipper as function (byval as IDirectDrawSurface3 ptr, byval as LPDIRECTDRAWCLIPPER ptr) as HRESULT
	GetColorKey as function (byval as IDirectDrawSurface3 ptr, byval as DWORD, byval as LPDDCOLORKEY) as HRESULT
	GetDC as function (byval as IDirectDrawSurface3 ptr, byval as HDC ptr) as HRESULT
	GetFlipStatus as function (byval as IDirectDrawSurface3 ptr, byval as DWORD) as HRESULT
	GetOverlayPosition as function (byval as IDirectDrawSurface3 ptr, byval as LPLONG, byval as LPLONG) as HRESULT
	GetPalette as function (byval as IDirectDrawSurface3 ptr, byval as LPDIRECTDRAWPALETTE ptr) as HRESULT
	GetPixelFormat as function (byval as IDirectDrawSurface3 ptr, byval as LPDDPIXELFORMAT) as HRESULT
	GetSurfaceDesc as function (byval as IDirectDrawSurface3 ptr, byval as LPDDSURFACEDESC) as HRESULT
	Initialize as function (byval as IDirectDrawSurface3 ptr, byval as LPDIRECTDRAW, byval as LPDDSURFACEDESC) as HRESULT
	IsLost as function (byval as IDirectDrawSurface3 ptr) as HRESULT
	Lock as function (byval as IDirectDrawSurface3 ptr, byval as LPRECT, byval as LPDDSURFACEDESC, byval as DWORD, byval as HANDLE) as HRESULT
	ReleaseDC as function (byval as IDirectDrawSurface3 ptr, byval as HDC) as HRESULT
	Restore as function (byval as IDirectDrawSurface3 ptr) as HRESULT
	SetClipper as function (byval as IDirectDrawSurface3 ptr, byval as LPDIRECTDRAWCLIPPER) as HRESULT
	SetColorKey as function (byval as IDirectDrawSurface3 ptr, byval as DWORD, byval as LPDDCOLORKEY) as HRESULT
	SetOverlayPosition as function (byval as IDirectDrawSurface3 ptr, byval as LONG, byval as LONG) as HRESULT
	SetPalette as function (byval as IDirectDrawSurface3 ptr, byval as LPDIRECTDRAWPALETTE) as HRESULT
	Unlock as function (byval as IDirectDrawSurface3 ptr, byval as LPVOID) as HRESULT
	UpdateOverlay as function (byval as IDirectDrawSurface3 ptr, byval as LPRECT, byval as LPDIRECTDRAWSURFACE3, byval as LPRECT, byval as DWORD, byval as LPDDOVERLAYFX) as HRESULT
	UpdateOverlayDisplay as function (byval as IDirectDrawSurface3 ptr, byval as DWORD) as HRESULT
	UpdateOverlayZOrder as function (byval as IDirectDrawSurface3 ptr, byval as DWORD, byval as LPDIRECTDRAWSURFACE3) as HRESULT
	GetDDInterface as function (byval as IDirectDrawSurface3 ptr, byval as LPVOID ptr) as HRESULT
	PageLock as function (byval as IDirectDrawSurface3 ptr, byval as DWORD) as HRESULT
	PageUnlock as function (byval as IDirectDrawSurface3 ptr, byval as DWORD) as HRESULT
	SetSurfaceDesc as function (byval as IDirectDrawSurface3 ptr, byval as LPDDSURFACEDESC, byval as DWORD) as HRESULT
end type

#define IDirectDrawSurface3_QueryInterface(p,a,b)        (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirectDrawSurface3_AddRef(p)                    (p)->lpVtbl->AddRef(p)
#define IDirectDrawSurface3_Release(p)                   (p)->lpVtbl->Release(p)
#define IDirectDrawSurface3_AddAttachedSurface(p,a)      (p)->lpVtbl->AddAttachedSurface(p,a)
#define IDirectDrawSurface3_AddOverlayDirtyRect(p,a)     (p)->lpVtbl->AddOverlayDirtyRect(p,a)
#define IDirectDrawSurface3_Blt(p,a,b,c,d,e)             (p)->lpVtbl->Blt(p,a,b,c,d,e)
#define IDirectDrawSurface3_BltBatch(p,a,b,c)            (p)->lpVtbl->BltBatch(p,a,b,c)
#define IDirectDrawSurface3_BltFast(p,a,b,c,d,e)         (p)->lpVtbl->BltFast(p,a,b,c,d,e)
#define IDirectDrawSurface3_DeleteAttachedSurface(p,a,b) (p)->lpVtbl->DeleteAttachedSurface(p,a,b)
#define IDirectDrawSurface3_EnumAttachedSurfaces(p,a,b)  (p)->lpVtbl->EnumAttachedSurfaces(p,a,b)
#define IDirectDrawSurface3_EnumOverlayZOrders(p,a,b,c)  (p)->lpVtbl->EnumOverlayZOrders(p,a,b,c)
#define IDirectDrawSurface3_Flip(p,a,b)                  (p)->lpVtbl->Flip(p,a,b)
#define IDirectDrawSurface3_GetAttachedSurface(p,a,b)    (p)->lpVtbl->GetAttachedSurface(p,a,b)
#define IDirectDrawSurface3_GetBltStatus(p,a)            (p)->lpVtbl->GetBltStatus(p,a)
#define IDirectDrawSurface3_GetCaps(p,b)                 (p)->lpVtbl->GetCaps(p,b)
#define IDirectDrawSurface3_GetClipper(p,a)              (p)->lpVtbl->GetClipper(p,a)
#define IDirectDrawSurface3_GetColorKey(p,a,b)           (p)->lpVtbl->GetColorKey(p,a,b)
#define IDirectDrawSurface3_GetDC(p,a)                   (p)->lpVtbl->GetDC(p,a)
#define IDirectDrawSurface3_GetFlipStatus(p,a)           (p)->lpVtbl->GetFlipStatus(p,a)
#define IDirectDrawSurface3_GetOverlayPosition(p,a,b)    (p)->lpVtbl->GetOverlayPosition(p,a,b)
#define IDirectDrawSurface3_GetPalette(p,a)              (p)->lpVtbl->GetPalette(p,a)
#define IDirectDrawSurface3_GetPixelFormat(p,a)          (p)->lpVtbl->GetPixelFormat(p,a)
#define IDirectDrawSurface3_GetSurfaceDesc(p,a)          (p)->lpVtbl->GetSurfaceDesc(p,a)
#define IDirectDrawSurface3_Initialize(p,a,b)            (p)->lpVtbl->Initialize(p,a,b)
#define IDirectDrawSurface3_IsLost(p)                    (p)->lpVtbl->IsLost(p)
#define IDirectDrawSurface3_Lock(p,a,b,c,d)              (p)->lpVtbl->Lock(p,a,b,c,d)
#define IDirectDrawSurface3_ReleaseDC(p,a)               (p)->lpVtbl->ReleaseDC(p,a)
#define IDirectDrawSurface3_Restore(p)                   (p)->lpVtbl->Restore(p)
#define IDirectDrawSurface3_SetClipper(p,a)              (p)->lpVtbl->SetClipper(p,a)
#define IDirectDrawSurface3_SetColorKey(p,a,b)           (p)->lpVtbl->SetColorKey(p,a,b)
#define IDirectDrawSurface3_SetOverlayPosition(p,a,b)    (p)->lpVtbl->SetOverlayPosition(p,a,b)
#define IDirectDrawSurface3_SetPalette(p,a)              (p)->lpVtbl->SetPalette(p,a)
#define IDirectDrawSurface3_Unlock(p,b)                  (p)->lpVtbl->Unlock(p,b)
#define IDirectDrawSurface3_UpdateOverlay(p,a,b,c,d,e)   (p)->lpVtbl->UpdateOverlay(p,a,b,c,d,e)
#define IDirectDrawSurface3_UpdateOverlayDisplay(p,a)    (p)->lpVtbl->UpdateOverlayDisplay(p,a)
#define IDirectDrawSurface3_UpdateOverlayZOrder(p,a,b)   (p)->lpVtbl->UpdateOverlayZOrder(p,a,b)
#define IDirectDrawSurface3_GetDDInterface(p,a)          (p)->lpVtbl->GetDDInterface(p,a)
#define IDirectDrawSurface3_PageLock(p,a)                (p)->lpVtbl->PageLock(p,a)
#define IDirectDrawSurface3_PageUnlock(p,a)              (p)->lpVtbl->PageUnlock(p,a)
#define IDirectDrawSurface3_SetSurfaceDesc(p,a,b)        (p)->lpVtbl->SetSurfaceDesc(p,a,b)


type IDirectDrawSurface4Vtbl_ as IDirectDrawSurface4Vtbl

type IDirectDrawSurface4
	lpVtbl as IDirectDrawSurface4Vtbl_ ptr
end type

type IDirectDrawSurface4Vtbl
	QueryInterface as function (byval as IDirectDrawSurface4 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectDrawSurface4 ptr) as ULONG
	Release as function (byval as IDirectDrawSurface4 ptr) as ULONG
	AddAttachedSurface as function (byval as IDirectDrawSurface4 ptr, byval as LPDIRECTDRAWSURFACE4) as HRESULT
	AddOverlayDirtyRect as function (byval as IDirectDrawSurface4 ptr, byval as LPRECT) as HRESULT
	Blt as function (byval as IDirectDrawSurface4 ptr, byval as LPRECT, byval as LPDIRECTDRAWSURFACE4, byval as LPRECT, byval as DWORD, byval as LPDDBLTFX) as HRESULT
	BltBatch as function (byval as IDirectDrawSurface4 ptr, byval as LPDDBLTBATCH, byval as DWORD, byval as DWORD) as HRESULT
	BltFast as function (byval as IDirectDrawSurface4 ptr, byval as DWORD, byval as DWORD, byval as LPDIRECTDRAWSURFACE4, byval as LPRECT, byval as DWORD) as HRESULT
	DeleteAttachedSurface as function (byval as IDirectDrawSurface4 ptr, byval as DWORD, byval as LPDIRECTDRAWSURFACE4) as HRESULT
	EnumAttachedSurfaces as function (byval as IDirectDrawSurface4 ptr, byval as LPVOID, byval as LPDDENUMSURFACESCALLBACK2) as HRESULT
	EnumOverlayZOrders as function (byval as IDirectDrawSurface4 ptr, byval as DWORD, byval as LPVOID, byval as LPDDENUMSURFACESCALLBACK2) as HRESULT
	Flip as function (byval as IDirectDrawSurface4 ptr, byval as LPDIRECTDRAWSURFACE4, byval as DWORD) as HRESULT
	GetAttachedSurface as function (byval as IDirectDrawSurface4 ptr, byval as LPDDSCAPS2, byval as LPDIRECTDRAWSURFACE4 ptr) as HRESULT
	GetBltStatus as function (byval as IDirectDrawSurface4 ptr, byval as DWORD) as HRESULT
	GetCaps as function (byval as IDirectDrawSurface4 ptr, byval as LPDDSCAPS2) as HRESULT
	GetClipper as function (byval as IDirectDrawSurface4 ptr, byval as LPDIRECTDRAWCLIPPER ptr) as HRESULT
	GetColorKey as function (byval as IDirectDrawSurface4 ptr, byval as DWORD, byval as LPDDCOLORKEY) as HRESULT
	GetDC as function (byval as IDirectDrawSurface4 ptr, byval as HDC ptr) as HRESULT
	GetFlipStatus as function (byval as IDirectDrawSurface4 ptr, byval as DWORD) as HRESULT
	GetOverlayPosition as function (byval as IDirectDrawSurface4 ptr, byval as LPLONG, byval as LPLONG) as HRESULT
	GetPalette as function (byval as IDirectDrawSurface4 ptr, byval as LPDIRECTDRAWPALETTE ptr) as HRESULT
	GetPixelFormat as function (byval as IDirectDrawSurface4 ptr, byval as LPDDPIXELFORMAT) as HRESULT
	GetSurfaceDesc as function (byval as IDirectDrawSurface4 ptr, byval as LPDDSURFACEDESC2) as HRESULT
	Initialize as function (byval as IDirectDrawSurface4 ptr, byval as LPDIRECTDRAW, byval as LPDDSURFACEDESC2) as HRESULT
	IsLost as function (byval as IDirectDrawSurface4 ptr) as HRESULT
	Lock as function (byval as IDirectDrawSurface4 ptr, byval as LPRECT, byval as LPDDSURFACEDESC2, byval as DWORD, byval as HANDLE) as HRESULT
	ReleaseDC as function (byval as IDirectDrawSurface4 ptr, byval as HDC) as HRESULT
	Restore as function (byval as IDirectDrawSurface4 ptr) as HRESULT
	SetClipper as function (byval as IDirectDrawSurface4 ptr, byval as LPDIRECTDRAWCLIPPER) as HRESULT
	SetColorKey as function (byval as IDirectDrawSurface4 ptr, byval as DWORD, byval as LPDDCOLORKEY) as HRESULT
	SetOverlayPosition as function (byval as IDirectDrawSurface4 ptr, byval as LONG, byval as LONG) as HRESULT
	SetPalette as function (byval as IDirectDrawSurface4 ptr, byval as LPDIRECTDRAWPALETTE) as HRESULT
	Unlock as function (byval as IDirectDrawSurface4 ptr, byval as LPRECT) as HRESULT
	UpdateOverlay as function (byval as IDirectDrawSurface4 ptr, byval as LPRECT, byval as LPDIRECTDRAWSURFACE4, byval as LPRECT, byval as DWORD, byval as LPDDOVERLAYFX) as HRESULT
	UpdateOverlayDisplay as function (byval as IDirectDrawSurface4 ptr, byval as DWORD) as HRESULT
	UpdateOverlayZOrder as function (byval as IDirectDrawSurface4 ptr, byval as DWORD, byval as LPDIRECTDRAWSURFACE4) as HRESULT
	GetDDInterface as function (byval as IDirectDrawSurface4 ptr, byval as LPVOID ptr) as HRESULT
	PageLock as function (byval as IDirectDrawSurface4 ptr, byval as DWORD) as HRESULT
	PageUnlock as function (byval as IDirectDrawSurface4 ptr, byval as DWORD) as HRESULT
	SetSurfaceDesc as function (byval as IDirectDrawSurface4 ptr, byval as LPDDSURFACEDESC2, byval as DWORD) as HRESULT
	SetPrivateData as function (byval as IDirectDrawSurface4 ptr, byval as GUID ptr, byval as LPVOID, byval as DWORD, byval as DWORD) as HRESULT
	GetPrivateData as function (byval as IDirectDrawSurface4 ptr, byval as GUID ptr, byval as LPVOID, byval as LPDWORD) as HRESULT
	FreePrivateData as function (byval as IDirectDrawSurface4 ptr, byval as GUID ptr) as HRESULT
	GetUniquenessValue as function (byval as IDirectDrawSurface4 ptr, byval as LPDWORD) as HRESULT
	ChangeUniquenessValue as function (byval as IDirectDrawSurface4 ptr) as HRESULT
end type

#define IDirectDrawSurface4_QueryInterface(p,a,b)        (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirectDrawSurface4_AddRef(p)                    (p)->lpVtbl->AddRef(p)
#define IDirectDrawSurface4_Release(p)                   (p)->lpVtbl->Release(p)
#define IDirectDrawSurface4_AddAttachedSurface(p,a)      (p)->lpVtbl->AddAttachedSurface(p,a)
#define IDirectDrawSurface4_AddOverlayDirtyRect(p,a)     (p)->lpVtbl->AddOverlayDirtyRect(p,a)
#define IDirectDrawSurface4_Blt(p,a,b,c,d,e)             (p)->lpVtbl->Blt(p,a,b,c,d,e)
#define IDirectDrawSurface4_BltBatch(p,a,b,c)            (p)->lpVtbl->BltBatch(p,a,b,c)
#define IDirectDrawSurface4_BltFast(p,a,b,c,d,e)         (p)->lpVtbl->BltFast(p,a,b,c,d,e)
#define IDirectDrawSurface4_DeleteAttachedSurface(p,a,b) (p)->lpVtbl->DeleteAttachedSurface(p,a,b)
#define IDirectDrawSurface4_EnumAttachedSurfaces(p,a,b)  (p)->lpVtbl->EnumAttachedSurfaces(p,a,b)
#define IDirectDrawSurface4_EnumOverlayZOrders(p,a,b,c)  (p)->lpVtbl->EnumOverlayZOrders(p,a,b,c)
#define IDirectDrawSurface4_Flip(p,a,b)                  (p)->lpVtbl->Flip(p,a,b)
#define IDirectDrawSurface4_GetAttachedSurface(p,a,b)    (p)->lpVtbl->GetAttachedSurface(p,a,b)
#define IDirectDrawSurface4_GetBltStatus(p,a)            (p)->lpVtbl->GetBltStatus(p,a)
#define IDirectDrawSurface4_GetCaps(p,b)                 (p)->lpVtbl->GetCaps(p,b)
#define IDirectDrawSurface4_GetClipper(p,a)              (p)->lpVtbl->GetClipper(p,a)
#define IDirectDrawSurface4_GetColorKey(p,a,b)           (p)->lpVtbl->GetColorKey(p,a,b)
#define IDirectDrawSurface4_GetDC(p,a)                   (p)->lpVtbl->GetDC(p,a)
#define IDirectDrawSurface4_GetFlipStatus(p,a)           (p)->lpVtbl->GetFlipStatus(p,a)
#define IDirectDrawSurface4_GetOverlayPosition(p,a,b)    (p)->lpVtbl->GetOverlayPosition(p,a,b)
#define IDirectDrawSurface4_GetPalette(p,a)              (p)->lpVtbl->GetPalette(p,a)
#define IDirectDrawSurface4_GetPixelFormat(p,a)          (p)->lpVtbl->GetPixelFormat(p,a)
#define IDirectDrawSurface4_GetSurfaceDesc(p,a)          (p)->lpVtbl->GetSurfaceDesc(p,a)
#define IDirectDrawSurface4_Initialize(p,a,b)            (p)->lpVtbl->Initialize(p,a,b)
#define IDirectDrawSurface4_IsLost(p)                    (p)->lpVtbl->IsLost(p)
#define IDirectDrawSurface4_Lock(p,a,b,c,d)              (p)->lpVtbl->Lock(p,a,b,c,d)
#define IDirectDrawSurface4_ReleaseDC(p,a)               (p)->lpVtbl->ReleaseDC(p,a)
#define IDirectDrawSurface4_Restore(p)                   (p)->lpVtbl->Restore(p)
#define IDirectDrawSurface4_SetClipper(p,a)              (p)->lpVtbl->SetClipper(p,a)
#define IDirectDrawSurface4_SetColorKey(p,a,b)           (p)->lpVtbl->SetColorKey(p,a,b)
#define IDirectDrawSurface4_SetOverlayPosition(p,a,b)    (p)->lpVtbl->SetOverlayPosition(p,a,b)
#define IDirectDrawSurface4_SetPalette(p,a)              (p)->lpVtbl->SetPalette(p,a)
#define IDirectDrawSurface4_Unlock(p,b)                  (p)->lpVtbl->Unlock(p,b)
#define IDirectDrawSurface4_UpdateOverlay(p,a,b,c,d,e)   (p)->lpVtbl->UpdateOverlay(p,a,b,c,d,e)
#define IDirectDrawSurface4_UpdateOverlayDisplay(p,a)    (p)->lpVtbl->UpdateOverlayDisplay(p,a)
#define IDirectDrawSurface4_UpdateOverlayZOrder(p,a,b)   (p)->lpVtbl->UpdateOverlayZOrder(p,a,b)
#define IDirectDrawSurface4_GetDDInterface(p,a)          (p)->lpVtbl->GetDDInterface(p,a)
#define IDirectDrawSurface4_PageLock(p,a)                (p)->lpVtbl->PageLock(p,a)
#define IDirectDrawSurface4_PageUnlock(p,a)              (p)->lpVtbl->PageUnlock(p,a)
#define IDirectDrawSurface4_SetSurfaceDesc(p,a,b)        (p)->lpVtbl->SetSurfaceDesc(p,a,b)
#define IDirectDrawSurface4_SetPrivateData(p,a,b,c,d)    (p)->lpVtbl->SetPrivateData(p,a,b,c,d)
#define IDirectDrawSurface4_GetPrivateData(p,a,b,c)      (p)->lpVtbl->GetPrivateData(p,a,b,c)
#define IDirectDrawSurface4_FreePrivateData(p,a)         (p)->lpVtbl->FreePrivateData(p,a)
#define IDirectDrawSurface4_GetUniquenessValue(p, a)     (p)->lpVtbl->GetUniquenessValue(p, a)
#define IDirectDrawSurface4_ChangeUniquenessValue(p)     (p)->lpVtbl->ChangeUniquenessValue(p)


type IDirectDrawSurface7Vtbl_ as IDirectDrawSurface7Vtbl

type IDirectDrawSurface7
	lpVtbl as IDirectDrawSurface7Vtbl_ ptr
end type

type IDirectDrawSurface7Vtbl
	QueryInterface as function (byval as IDirectDrawSurface7 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectDrawSurface7 ptr) as ULONG
	Release as function (byval as IDirectDrawSurface7 ptr) as ULONG
	AddAttachedSurface as function (byval as IDirectDrawSurface7 ptr, byval as LPDIRECTDRAWSURFACE7) as HRESULT
	AddOverlayDirtyRect as function (byval as IDirectDrawSurface7 ptr, byval as LPRECT) as HRESULT
	Blt as function (byval as IDirectDrawSurface7 ptr, byval as LPRECT, byval as LPDIRECTDRAWSURFACE7, byval as LPRECT, byval as DWORD, byval as LPDDBLTFX) as HRESULT
	BltBatch as function (byval as IDirectDrawSurface7 ptr, byval as LPDDBLTBATCH, byval as DWORD, byval as DWORD) as HRESULT
	BltFast as function (byval as IDirectDrawSurface7 ptr, byval as DWORD, byval as DWORD, byval as LPDIRECTDRAWSURFACE7, byval as LPRECT, byval as DWORD) as HRESULT
	DeleteAttachedSurface as function (byval as IDirectDrawSurface7 ptr, byval as DWORD, byval as LPDIRECTDRAWSURFACE7) as HRESULT
	EnumAttachedSurfaces as function (byval as IDirectDrawSurface7 ptr, byval as LPVOID, byval as LPDDENUMSURFACESCALLBACK7) as HRESULT
	EnumOverlayZOrders as function (byval as IDirectDrawSurface7 ptr, byval as DWORD, byval as LPVOID, byval as LPDDENUMSURFACESCALLBACK7) as HRESULT
	Flip as function (byval as IDirectDrawSurface7 ptr, byval as LPDIRECTDRAWSURFACE7, byval as DWORD) as HRESULT
	GetAttachedSurface as function (byval as IDirectDrawSurface7 ptr, byval as LPDDSCAPS2, byval as LPDIRECTDRAWSURFACE7 ptr) as HRESULT
	GetBltStatus as function (byval as IDirectDrawSurface7 ptr, byval as DWORD) as HRESULT
	GetCaps as function (byval as IDirectDrawSurface7 ptr, byval as LPDDSCAPS2) as HRESULT
	GetClipper as function (byval as IDirectDrawSurface7 ptr, byval as LPDIRECTDRAWCLIPPER ptr) as HRESULT
	GetColorKey as function (byval as IDirectDrawSurface7 ptr, byval as DWORD, byval as LPDDCOLORKEY) as HRESULT
	GetDC as function (byval as IDirectDrawSurface7 ptr, byval as HDC ptr) as HRESULT
	GetFlipStatus as function (byval as IDirectDrawSurface7 ptr, byval as DWORD) as HRESULT
	GetOverlayPosition as function (byval as IDirectDrawSurface7 ptr, byval as LPLONG, byval as LPLONG) as HRESULT
	GetPalette as function (byval as IDirectDrawSurface7 ptr, byval as LPDIRECTDRAWPALETTE ptr) as HRESULT
	GetPixelFormat as function (byval as IDirectDrawSurface7 ptr, byval as LPDDPIXELFORMAT) as HRESULT
	GetSurfaceDesc as function (byval as IDirectDrawSurface7 ptr, byval as LPDDSURFACEDESC2) as HRESULT
	Initialize as function (byval as IDirectDrawSurface7 ptr, byval as LPDIRECTDRAW, byval as LPDDSURFACEDESC2) as HRESULT
	IsLost as function (byval as IDirectDrawSurface7 ptr) as HRESULT
	Lock as function (byval as IDirectDrawSurface7 ptr, byval as LPRECT, byval as LPDDSURFACEDESC2, byval as DWORD, byval as HANDLE) as HRESULT
	ReleaseDC as function (byval as IDirectDrawSurface7 ptr, byval as HDC) as HRESULT
	Restore as function (byval as IDirectDrawSurface7 ptr) as HRESULT
	SetClipper as function (byval as IDirectDrawSurface7 ptr, byval as LPDIRECTDRAWCLIPPER) as HRESULT
	SetColorKey as function (byval as IDirectDrawSurface7 ptr, byval as DWORD, byval as LPDDCOLORKEY) as HRESULT
	SetOverlayPosition as function (byval as IDirectDrawSurface7 ptr, byval as LONG, byval as LONG) as HRESULT
	SetPalette as function (byval as IDirectDrawSurface7 ptr, byval as LPDIRECTDRAWPALETTE) as HRESULT
	Unlock as function (byval as IDirectDrawSurface7 ptr, byval as LPRECT) as HRESULT
	UpdateOverlay as function (byval as IDirectDrawSurface7 ptr, byval as LPRECT, byval as LPDIRECTDRAWSURFACE7, byval as LPRECT, byval as DWORD, byval as LPDDOVERLAYFX) as HRESULT
	UpdateOverlayDisplay as function (byval as IDirectDrawSurface7 ptr, byval as DWORD) as HRESULT
	UpdateOverlayZOrder as function (byval as IDirectDrawSurface7 ptr, byval as DWORD, byval as LPDIRECTDRAWSURFACE7) as HRESULT
	GetDDInterface as function (byval as IDirectDrawSurface7 ptr, byval as LPVOID ptr) as HRESULT
	PageLock as function (byval as IDirectDrawSurface7 ptr, byval as DWORD) as HRESULT
	PageUnlock as function (byval as IDirectDrawSurface7 ptr, byval as DWORD) as HRESULT
	SetSurfaceDesc as function (byval as IDirectDrawSurface7 ptr, byval as LPDDSURFACEDESC2, byval as DWORD) as HRESULT
	SetPrivateData as function (byval as IDirectDrawSurface7 ptr, byval as GUID ptr, byval as LPVOID, byval as DWORD, byval as DWORD) as HRESULT
	GetPrivateData as function (byval as IDirectDrawSurface7 ptr, byval as GUID ptr, byval as LPVOID, byval as LPDWORD) as HRESULT
	FreePrivateData as function (byval as IDirectDrawSurface7 ptr, byval as GUID ptr) as HRESULT
	GetUniquenessValue as function (byval as IDirectDrawSurface7 ptr, byval as LPDWORD) as HRESULT
	ChangeUniquenessValue as function (byval as IDirectDrawSurface7 ptr) as HRESULT
	SetPriority as function (byval as IDirectDrawSurface7 ptr, byval as DWORD) as HRESULT
	GetPriority as function (byval as IDirectDrawSurface7 ptr, byval as LPDWORD) as HRESULT
	SetLOD as function (byval as IDirectDrawSurface7 ptr, byval as DWORD) as HRESULT
	GetLOD as function (byval as IDirectDrawSurface7 ptr, byval as LPDWORD) as HRESULT
end type

#define IDirectDrawSurface7_QueryInterface(p,a,b)        (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirectDrawSurface7_AddRef(p)                    (p)->lpVtbl->AddRef(p)
#define IDirectDrawSurface7_Release(p)                   (p)->lpVtbl->Release(p)
#define IDirectDrawSurface7_AddAttachedSurface(p,a)      (p)->lpVtbl->AddAttachedSurface(p,a)
#define IDirectDrawSurface7_AddOverlayDirtyRect(p,a)     (p)->lpVtbl->AddOverlayDirtyRect(p,a)
#define IDirectDrawSurface7_Blt(p,a,b,c,d,e)             (p)->lpVtbl->Blt(p,a,b,c,d,e)
#define IDirectDrawSurface7_BltBatch(p,a,b,c)            (p)->lpVtbl->BltBatch(p,a,b,c)
#define IDirectDrawSurface7_BltFast(p,a,b,c,d,e)         (p)->lpVtbl->BltFast(p,a,b,c,d,e)
#define IDirectDrawSurface7_DeleteAttachedSurface(p,a,b) (p)->lpVtbl->DeleteAttachedSurface(p,a,b)
#define IDirectDrawSurface7_EnumAttachedSurfaces(p,a,b)  (p)->lpVtbl->EnumAttachedSurfaces(p,a,b)
#define IDirectDrawSurface7_EnumOverlayZOrders(p,a,b,c)  (p)->lpVtbl->EnumOverlayZOrders(p,a,b,c)
#define IDirectDrawSurface7_Flip(p,a,b)                  (p)->lpVtbl->Flip(p,a,b)
#define IDirectDrawSurface7_GetAttachedSurface(p,a,b)    (p)->lpVtbl->GetAttachedSurface(p,a,b)
#define IDirectDrawSurface7_GetBltStatus(p,a)            (p)->lpVtbl->GetBltStatus(p,a)
#define IDirectDrawSurface7_GetCaps(p,b)                 (p)->lpVtbl->GetCaps(p,b)
#define IDirectDrawSurface7_GetClipper(p,a)              (p)->lpVtbl->GetClipper(p,a)
#define IDirectDrawSurface7_GetColorKey(p,a,b)           (p)->lpVtbl->GetColorKey(p,a,b)
#define IDirectDrawSurface7_GetDC(p,a)                   (p)->lpVtbl->GetDC(p,a)
#define IDirectDrawSurface7_GetFlipStatus(p,a)           (p)->lpVtbl->GetFlipStatus(p,a)
#define IDirectDrawSurface7_GetOverlayPosition(p,a,b)    (p)->lpVtbl->GetOverlayPosition(p,a,b)
#define IDirectDrawSurface7_GetPalette(p,a)              (p)->lpVtbl->GetPalette(p,a)
#define IDirectDrawSurface7_GetPixelFormat(p,a)          (p)->lpVtbl->GetPixelFormat(p,a)
#define IDirectDrawSurface7_GetSurfaceDesc(p,a)          (p)->lpVtbl->GetSurfaceDesc(p,a)
#define IDirectDrawSurface7_Initialize(p,a,b)            (p)->lpVtbl->Initialize(p,a,b)
#define IDirectDrawSurface7_IsLost(p)                    (p)->lpVtbl->IsLost(p)
#define IDirectDrawSurface7_Lock(p,a,b,c,d)              (p)->lpVtbl->Lock(p,a,b,c,d)
#define IDirectDrawSurface7_ReleaseDC(p,a)               (p)->lpVtbl->ReleaseDC(p,a)
#define IDirectDrawSurface7_Restore(p)                   (p)->lpVtbl->Restore(p)
#define IDirectDrawSurface7_SetClipper(p,a)              (p)->lpVtbl->SetClipper(p,a)
#define IDirectDrawSurface7_SetColorKey(p,a,b)           (p)->lpVtbl->SetColorKey(p,a,b)
#define IDirectDrawSurface7_SetOverlayPosition(p,a,b)    (p)->lpVtbl->SetOverlayPosition(p,a,b)
#define IDirectDrawSurface7_SetPalette(p,a)              (p)->lpVtbl->SetPalette(p,a)
#define IDirectDrawSurface7_Unlock(p,b)                  (p)->lpVtbl->Unlock(p,b)
#define IDirectDrawSurface7_UpdateOverlay(p,a,b,c,d,e)   (p)->lpVtbl->UpdateOverlay(p,a,b,c,d,e)
#define IDirectDrawSurface7_UpdateOverlayDisplay(p,a)    (p)->lpVtbl->UpdateOverlayDisplay(p,a)
#define IDirectDrawSurface7_UpdateOverlayZOrder(p,a,b)   (p)->lpVtbl->UpdateOverlayZOrder(p,a,b)
#define IDirectDrawSurface7_GetDDInterface(p,a)          (p)->lpVtbl->GetDDInterface(p,a)
#define IDirectDrawSurface7_PageLock(p,a)                (p)->lpVtbl->PageLock(p,a)
#define IDirectDrawSurface7_PageUnlock(p,a)              (p)->lpVtbl->PageUnlock(p,a)
#define IDirectDrawSurface7_SetSurfaceDesc(p,a,b)        (p)->lpVtbl->SetSurfaceDesc(p,a,b)
#define IDirectDrawSurface7_SetPrivateData(p,a,b,c,d)    (p)->lpVtbl->SetPrivateData(p,a,b,c,d)
#define IDirectDrawSurface7_GetPrivateData(p,a,b,c)      (p)->lpVtbl->GetPrivateData(p,a,b,c)
#define IDirectDrawSurface7_FreePrivateData(p,a)         (p)->lpVtbl->FreePrivateData(p,a)
#define IDirectDrawSurface7_GetUniquenessValue(p, a)     (p)->lpVtbl->GetUniquenessValue(p, a)
#define IDirectDrawSurface7_ChangeUniquenessValue(p)     (p)->lpVtbl->ChangeUniquenessValue(p)
#define IDirectDrawSurface7_SetPriority(p,a)             (p)->lpVtbl->SetPriority(p,a)
#define IDirectDrawSurface7_GetPriority(p,a)             (p)->lpVtbl->GetPriority(p,a)
#define IDirectDrawSurface7_SetLOD(p,a)                  (p)->lpVtbl->SetLOD(p,a)
#define IDirectDrawSurface7_GetLOD(p,a)                  (p)->lpVtbl->GetLOD(p,a)


type IDirectDrawColorControlVtbl_ as IDirectDrawColorControlVtbl

type IDirectDrawColorControl
	lpVtbl as IDirectDrawColorControlVtbl_ ptr
end type

type IDirectDrawColorControlVtbl
	QueryInterface as function (byval as IDirectDrawColorControl ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectDrawColorControl ptr) as ULONG
	Release as function (byval as IDirectDrawColorControl ptr) as ULONG
	GetColorControls as function (byval as IDirectDrawColorControl ptr, byval as LPDDCOLORCONTROL) as HRESULT
	SetColorControls as function (byval as IDirectDrawColorControl ptr, byval as LPDDCOLORCONTROL) as HRESULT
end type

#define IDirectDrawColorControl_QueryInterface(p, a, b)  (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectDrawColorControl_AddRef(p)                (p)->lpVtbl->AddRef(p)
#define IDirectDrawColorControl_Release(p)               (p)->lpVtbl->Release(p)
#define IDirectDrawColorControl_GetColorControls(p, a)   (p)->lpVtbl->GetColorControls(p, a)
#define IDirectDrawColorControl_SetColorControls(p, a)   (p)->lpVtbl->SetColorControls(p, a)


type IDirectDrawGammaControlVtbl_ as IDirectDrawGammaControlVtbl

type IDirectDrawGammaControl
	lpVtbl as IDirectDrawGammaControlVtbl_ ptr
end type

type IDirectDrawGammaControlVtbl
	QueryInterface as function (byval as IDirectDrawGammaControl ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectDrawGammaControl ptr) as ULONG
	Release as function (byval as IDirectDrawGammaControl ptr) as ULONG
	GetGammaRamp as function (byval as IDirectDrawGammaControl ptr, byval as DWORD, byval as LPDDGAMMARAMP) as HRESULT
	SetGammaRamp as function (byval as IDirectDrawGammaControl ptr, byval as DWORD, byval as LPDDGAMMARAMP) as HRESULT
end type

#define IDirectDrawGammaControl_QueryInterface(p, a, b)  (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectDrawGammaControl_AddRef(p)                (p)->lpVtbl->AddRef(p)
#define IDirectDrawGammaControl_Release(p)               (p)->lpVtbl->Release(p)
#define IDirectDrawGammaControl_GetGammaRamp(p, a, b)    (p)->lpVtbl->GetGammaRamp(p, a, b)
#define IDirectDrawGammaControl_SetGammaRamp(p, a, b)    (p)->lpVtbl->SetGammaRamp(p, a, b)


type DDSURFACEDESC
	dwSize as DWORD
	dwFlags as DWORD
	dwHeight as DWORD
	dwWidth as DWORD
	union
		lPitch as LONG
		dwLinearSize as DWORD
	end union
	dwBackBufferCount as DWORD
	union
		dwMipMapCount as DWORD
		dwZBufferBitDepth as DWORD
		dwRefreshRate as DWORD
	end union
	dwAlphaBitDepth as DWORD
	dwReserved as DWORD
	lpSurface as LPVOID
	ddckCKDestOverlay as DDCOLORKEY
	ddckCKDestBlt as DDCOLORKEY
	ddckCKSrcOverlay as DDCOLORKEY
	ddckCKSrcBlt as DDCOLORKEY
	ddpfPixelFormat as DDPIXELFORMAT
	ddsCaps as DDSCAPS
end type

type DDSURFACEDESC2
	dwSize as DWORD
	dwFlags as DWORD
	dwHeight as DWORD
	dwWidth as DWORD
	union
		lPitch as LONG
		dwLinearSize as DWORD
	end union
	union
		dwBackBufferCount as DWORD
		dwDepth as DWORD
	end union
	union
		dwMipMapCount as DWORD
		dwRefreshRate as DWORD
		dwSrcVBHandle as DWORD
	end union
	dwAlphaBitDepth as DWORD
	dwReserved as DWORD
	lpSurface as LPVOID
	union
		ddckCKDestOverlay as DDCOLORKEY
		dwEmptyFaceColor as DWORD
	end union
	ddckCKDestBlt as DDCOLORKEY
	ddckCKSrcOverlay as DDCOLORKEY
	ddckCKSrcBlt as DDCOLORKEY
	union
		ddpfPixelFormat as DDPIXELFORMAT
		dwFVF as DWORD
	end union
	ddsCaps as DDSCAPS2
	dwTextureSe as DWORD
end type

#define DDSD_CAPS &h00000001l
#define DDSD_HEIGHT &h00000002l
#define DDSD_WIDTH &h00000004l
#define DDSD_PITCH &h00000008l
#define DDSD_BACKBUFFERCOUNT &h00000020l
#define DDSD_ZBUFFERBITDEPTH &h00000040l
#define DDSD_ALPHABITDEPTH &h00000080l
#define DDSD_LPSURFACE &h00000800l
#define DDSD_PIXELFORMAT &h00001000l
#define DDSD_CKDESTOVERLAY &h00002000l
#define DDSD_CKDESTBLT &h00004000l
#define DDSD_CKSRCOVERLAY &h00008000l
#define DDSD_CKSRCBLT &h00010000l
#define DDSD_MIPMAPCOUNT &h00020000l
#define DDSD_REFRESHRATE &h00040000l
#define DDSD_LINEARSIZE &h00080000l
#define DDSD_TEXTURESTAGE &h00100000l
#define DDSD_FVF &h00200000l
#define DDSD_SRCVBHANDLE &h00400000l
#define DDSD_DEPTH &h00800000l
#define DDSD_ALL &h00fff9eel

type DDOPTSURFACEDESC
	dwSize as DWORD
	dwFlags as DWORD
	ddSCaps as DDSCAPS2
	ddOSCaps as DDOSCAPS
	guid as GUID
	dwCompressionRatio as DWORD
end type

#define DDOSD_GUID &h00000001l
#define DDOSD_COMPRESSION_RATIO &h00000002l
#define DDOSD_SCAPS &h00000004l
#define DDOSD_OSCAPS &h00000008l
#define DDOSD_ALL &h0000000fl
#define DDOSDCAPS_OPTCOMPRESSED &h00000001l
#define DDOSDCAPS_OPTREORDERED &h00000002l
#define DDOSDCAPS_MONOLITHICMIPMAP &h00000004l
#define DDOSDCAPS_VALIDSCAPS &h30004800l
#define DDOSDCAPS_VALIDOSCAPS &h00000007l

type DDCOLORCONTROL
	dwSize as DWORD
	dwFlags as DWORD
	lBrightness as LONG
	lContrast as LONG
	lHue as LONG
	lSaturation as LONG
	lSharpness as LONG
	lGamma as LONG
	lColorEnable as LONG
	dwReserved1 as DWORD
end type

#define DDCOLOR_BRIGHTNESS &h00000001l
#define DDCOLOR_CONTRAST &h00000002l
#define DDCOLOR_HUE &h00000004l
#define DDCOLOR_SATURATION &h00000008l
#define DDCOLOR_SHARPNESS &h00000010l
#define DDCOLOR_GAMMA &h00000020l
#define DDCOLOR_COLORENABLE &h00000040l
#define DDSCAPS_RESERVED1 &h00000001l
#define DDSCAPS_ALPHA &h00000002l
#define DDSCAPS_BACKBUFFER &h00000004l
#define DDSCAPS_COMPLEX &h00000008l
#define DDSCAPS_FLIP &h00000010l
#define DDSCAPS_FRONTBUFFER &h00000020l
#define DDSCAPS_OFFSCREENPLAIN &h00000040l
#define DDSCAPS_OVERLAY &h00000080l
#define DDSCAPS_PALETTE &h00000100l
#define DDSCAPS_PRIMARYSURFACE &h00000200l
#define DDSCAPS_RESERVED3 &h00000400l
#define DDSCAPS_PRIMARYSURFACELEFT &h00000000l
#define DDSCAPS_SYSTEMMEMORY &h00000800l
#define DDSCAPS_TEXTURE &h00001000l
#define DDSCAPS_3DDEVICE &h00002000l
#define DDSCAPS_VIDEOMEMORY &h00004000l
#define DDSCAPS_VISIBLE &h00008000l
#define DDSCAPS_WRITEONLY &h00010000l
#define DDSCAPS_ZBUFFER &h00020000l
#define DDSCAPS_OWNDC &h00040000l
#define DDSCAPS_LIVEVIDEO &h00080000l
#define DDSCAPS_HWCODEC &h00100000l
#define DDSCAPS_MODEX &h00200000l
#define DDSCAPS_MIPMAP &h00400000l
#define DDSCAPS_RESERVED2 &h00800000l
#define DDSCAPS_ALLOCONLOAD &h04000000l
#define DDSCAPS_VIDEOPORT &h08000000l
#define DDSCAPS_LOCALVIDMEM &h10000000l
#define DDSCAPS_NONLOCALVIDMEM &h20000000l
#define DDSCAPS_STANDARDVGAMODE &h40000000l
#define DDSCAPS_OPTIMIZED &h80000000l
#define DDSCAPS2_RESERVED4 &h00000002L
#define DDSCAPS2_HARDWAREDEINTERLACE &h00000000L
#define DDSCAPS2_HINTDYNAMIC &h00000004L
#define DDSCAPS2_HINTSTATIC &h00000008L
#define DDSCAPS2_TEXTUREMANAGE &h00000010L
#define DDSCAPS2_RESERVED1 &h00000020L
#define DDSCAPS2_RESERVED2 &h00000040L
#define DDSCAPS2_OPAQUE &h00000080L
#define DDSCAPS2_HINTANTIALIASING &h00000100L
#define DDSCAPS2_CUBEMAP &h00000200L
#define DDSCAPS2_CUBEMAP_POSITIVEX &h00000400L
#define DDSCAPS2_CUBEMAP_NEGATIVEX &h00000800L
#define DDSCAPS2_CUBEMAP_POSITIVEY &h00001000L
#define DDSCAPS2_CUBEMAP_NEGATIVEY &h00002000L
#define DDSCAPS2_CUBEMAP_POSITIVEZ &h00004000L
#define DDSCAPS2_CUBEMAP_NEGATIVEZ &h00008000L
#define DDSCAPS2_CUBEMAP_ALLFACES (&h00000400L or &h00000800L or &h00001000L or &h00002000L or &h00004000L or &h00008000L)
#define DDSCAPS2_MIPMAPSUBLEVEL &h00010000L
#define DDSCAPS2_D3DTEXTUREMANAGE &h00020000L
#define DDSCAPS2_DONOTPERSIST &h00040000L
#define DDSCAPS2_STEREOSURFACELEFT &h00080000L
#define DDSCAPS2_VOLUME &h00200000L
#define DDSCAPS2_NOTUSERLOCKABLE &h00400000L
#define DDSCAPS2_POINTS &h00800000L
#define DDSCAPS2_RTPATCHES &h01000000L
#define DDSCAPS2_NPATCHES &h02000000L
#define DDSCAPS2_RESERVED3 &h04000000L
#define DDSCAPS2_DISCARDBACKBUFFER &h10000000L
#define DDSCAPS2_ENABLEALPHACHANNEL &h20000000L
#define DDSCAPS2_EXTENDEDFORMATPRIMARY &h40000000L
#define DDSCAPS2_ADDITIONALPRIMARY &h80000000L
#define DDSCAPS3_MULTISAMPLE_MASK &h0000001FL
#define DDSCAPS3_MULTISAMPLE_QUALITY_MASK &h000000E0L
#define DDSCAPS3_MULTISAMPLE_QUALITY_SHIFT 5
#define DDSCAPS3_RESERVED1 &h00000100L
#define DDSCAPS3_RESERVED2 &h00000200L
#define DDSCAPS3_LIGHTWEIGHTMIPMAP &h00000400L
#define DDSCAPS3_AUTOGENMIPMAP &h00000800L
#define DDSCAPS3_DMAP &h00001000L
#define DDCAPS_3D &h00000001l
#define DDCAPS_ALIGNBOUNDARYDEST &h00000002l
#define DDCAPS_ALIGNSIZEDEST &h00000004l
#define DDCAPS_ALIGNBOUNDARYSRC &h00000008l
#define DDCAPS_ALIGNSIZESRC &h00000010l
#define DDCAPS_ALIGNSTRIDE &h00000020l
#define DDCAPS_BLT &h00000040l
#define DDCAPS_BLTQUEUE &h00000080l
#define DDCAPS_BLTFOURCC &h00000100l
#define DDCAPS_BLTSTRETCH &h00000200l
#define DDCAPS_GDI &h00000400l
#define DDCAPS_OVERLAY &h00000800l
#define DDCAPS_OVERLAYCANTCLIP &h00001000l
#define DDCAPS_OVERLAYFOURCC &h00002000l
#define DDCAPS_OVERLAYSTRETCH &h00004000l
#define DDCAPS_PALETTE &h00008000l
#define DDCAPS_PALETTEVSYNC &h00010000l
#define DDCAPS_READSCANLINE &h00020000l
#define DDCAPS_RESERVED1 &h00040000l
#define DDCAPS_VBI &h00080000l
#define DDCAPS_ZBLTS &h00100000l
#define DDCAPS_ZOVERLAYS &h00200000l
#define DDCAPS_COLORKEY &h00400000l
#define DDCAPS_ALPHA &h00800000l
#define DDCAPS_COLORKEYHWASSIST &h01000000l
#define DDCAPS_NOHARDWARE &h02000000l
#define DDCAPS_BLTCOLORFILL &h04000000l
#define DDCAPS_BANKSWITCHED &h08000000l
#define DDCAPS_BLTDEPTHFILL &h10000000l
#define DDCAPS_CANCLIP &h20000000l
#define DDCAPS_CANCLIPSTRETCHED &h40000000l
#define DDCAPS_CANBLTSYSMEM &h80000000l
#define DDCAPS2_CERTIFIED &h00000001l
#define DDCAPS2_NO2DDURING3DSCENE &h00000002l
#define DDCAPS2_VIDEOPORT &h00000004l
#define DDCAPS2_AUTOFLIPOVERLAY &h00000008l
#define DDCAPS2_CANBOBINTERLEAVED &h00000010l
#define DDCAPS2_CANBOBNONINTERLEAVED &h00000020l
#define DDCAPS2_COLORCONTROLOVERLAY &h00000040l
#define DDCAPS2_COLORCONTROLPRIMARY &h00000080l
#define DDCAPS2_CANDROPZ16BIT &h00000100l
#define DDCAPS2_NONLOCALVIDMEM &h00000200l
#define DDCAPS2_NONLOCALVIDMEMCAPS &h00000400l
#define DDCAPS2_NOPAGELOCKREQUIRED &h00000800l
#define DDCAPS2_WIDESURFACES &h00001000l
#define DDCAPS2_CANFLIPODDEVEN &h00002000l
#define DDCAPS2_CANBOBHARDWARE &h00004000l
#define DDCAPS2_COPYFOURCC &h00008000l
#define DDCAPS2_PRIMARYGAMMA &h00020000l
#define DDCAPS2_CANRENDERWINDOWED &h00080000l
#define DDCAPS2_CANCALIBRATEGAMMA &h00100000l
#define DDCAPS2_FLIPINTERVAL &h00200000l
#define DDCAPS2_FLIPNOVSYNC &h00400000l
#define DDCAPS2_CANMANAGETEXTURE &h00800000l
#define DDCAPS2_TEXMANINNONLOCALVIDMEM &h01000000l
#define DDCAPS2_STEREO &h02000000L
#define DDCAPS2_SYSTONONLOCAL_AS_SYSTOLOCAL &h04000000L
#define DDCAPS2_RESERVED1 &h08000000L
#define DDCAPS2_CANMANAGERESOURCE &h10000000L
#define DDCAPS2_DYNAMICTEXTURES &h20000000L
#define DDCAPS2_CANAUTOGENMIPMAP &h40000000L
#define DDFXALPHACAPS_BLTALPHAEDGEBLEND &h00000001l
#define DDFXALPHACAPS_BLTALPHAPIXELS &h00000002l
#define DDFXALPHACAPS_BLTALPHAPIXELSNEG &h00000004l
#define DDFXALPHACAPS_BLTALPHASURFACES &h00000008l
#define DDFXALPHACAPS_BLTALPHASURFACESNEG &h00000010l
#define DDFXALPHACAPS_OVERLAYALPHAEDGEBLEND &h00000020l
#define DDFXALPHACAPS_OVERLAYALPHAPIXELS &h00000040l
#define DDFXALPHACAPS_OVERLAYALPHAPIXELSNEG &h00000080l
#define DDFXALPHACAPS_OVERLAYALPHASURFACES &h00000100l
#define DDFXALPHACAPS_OVERLAYALPHASURFACESNEG &h00000200l
#define DDFXCAPS_BLTARITHSTRETCHY &h00000020l
#define DDFXCAPS_BLTARITHSTRETCHYN &h00000010l
#define DDFXCAPS_BLTMIRRORLEFTRIGHT &h00000040l
#define DDFXCAPS_BLTMIRRORUPDOWN &h00000080l
#define DDFXCAPS_BLTROTATION &h00000100l
#define DDFXCAPS_BLTROTATION90 &h00000200l
#define DDFXCAPS_BLTSHRINKX &h00000400l
#define DDFXCAPS_BLTSHRINKXN &h00000800l
#define DDFXCAPS_BLTSHRINKY &h00001000l
#define DDFXCAPS_BLTSHRINKYN &h00002000l
#define DDFXCAPS_BLTSTRETCHX &h00004000l
#define DDFXCAPS_BLTSTRETCHXN &h00008000l
#define DDFXCAPS_BLTSTRETCHY &h00010000l
#define DDFXCAPS_BLTSTRETCHYN &h00020000l
#define DDFXCAPS_OVERLAYARITHSTRETCHY &h00040000l
#define DDFXCAPS_OVERLAYARITHSTRETCHYN &h00000008l
#define DDFXCAPS_OVERLAYSHRINKX &h00080000l
#define DDFXCAPS_OVERLAYSHRINKXN &h00100000l
#define DDFXCAPS_OVERLAYSHRINKY &h00200000l
#define DDFXCAPS_OVERLAYSHRINKYN &h00400000l
#define DDFXCAPS_OVERLAYSTRETCHX &h00800000l
#define DDFXCAPS_OVERLAYSTRETCHXN &h01000000l
#define DDFXCAPS_OVERLAYSTRETCHY &h02000000l
#define DDFXCAPS_OVERLAYSTRETCHYN &h04000000l
#define DDFXCAPS_OVERLAYMIRRORLEFTRIGHT &h08000000l
#define DDFXCAPS_OVERLAYMIRRORUPDOWN &h10000000l
#define DDFXCAPS_OVERLAYDEINTERLACE &h20000000l
#define DDFXCAPS_BLTALPHA &h00000001l
#define DDFXCAPS_BLTFILTER &h00000020l
#define DDFXCAPS_OVERLAYALPHA &h00000004l
#define DDFXCAPS_OVERLAYFILTER &h00040000l
#define DDSVCAPS_RESERVED1 &h00000001l
#define DDSVCAPS_RESERVED2 &h00000002l
#define DDSVCAPS_RESERVED3 &h00000004l
#define DDSVCAPS_RESERVED4 &h00000008l
#define DDSVCAPS_STEREOSEQUENTIAL &h00000010L
#define DDPCAPS_4BIT &h00000001l
#define DDPCAPS_8BITENTRIES &h00000002l
#define DDPCAPS_8BIT &h00000004l
#define DDPCAPS_INITIALIZE &h00000000l
#define DDPCAPS_PRIMARYSURFACE &h00000010l
#define DDPCAPS_PRIMARYSURFACELEFT &h00000020l
#define DDPCAPS_ALLOW256 &h00000040l
#define DDPCAPS_VSYNC &h00000080l
#define DDPCAPS_1BIT &h00000100l
#define DDPCAPS_2BIT &h00000200l
#define DDPCAPS_ALPHA &h00000400l
#define DDSPD_IUNKNOWNPOINTER &h00000001L
#define DDSPD_VOLATILE &h00000002L
#define DDBD_1 &h00004000l
#define DDBD_2 &h00002000l
#define DDBD_4 &h00001000l
#define DDBD_8 &h00000800l
#define DDBD_16 &h00000400l
#define DDBD_24 &h00000200l
#define DDBD_32 &h00000100l
#define DDCKEY_COLORSPACE &h00000001l
#define DDCKEY_DESTBLT &h00000002l
#define DDCKEY_DESTOVERLAY &h00000004l
#define DDCKEY_SRCBLT &h00000008l
#define DDCKEY_SRCOVERLAY &h00000010l
#define DDCKEYCAPS_DESTBLT &h00000001l
#define DDCKEYCAPS_DESTBLTCLRSPACE &h00000002l
#define DDCKEYCAPS_DESTBLTCLRSPACEYUV &h00000004l
#define DDCKEYCAPS_DESTBLTYUV &h00000008l
#define DDCKEYCAPS_DESTOVERLAY &h00000010l
#define DDCKEYCAPS_DESTOVERLAYCLRSPACE &h00000020l
#define DDCKEYCAPS_DESTOVERLAYCLRSPACEYUV &h00000040l
#define DDCKEYCAPS_DESTOVERLAYONEACTIVE &h00000080l
#define DDCKEYCAPS_DESTOVERLAYYUV &h00000100l
#define DDCKEYCAPS_SRCBLT &h00000200l
#define DDCKEYCAPS_SRCBLTCLRSPACE &h00000400l
#define DDCKEYCAPS_SRCBLTCLRSPACEYUV &h00000800l
#define DDCKEYCAPS_SRCBLTYUV &h00001000l
#define DDCKEYCAPS_SRCOVERLAY &h00002000l
#define DDCKEYCAPS_SRCOVERLAYCLRSPACE &h00004000l
#define DDCKEYCAPS_SRCOVERLAYCLRSPACEYUV &h00008000l
#define DDCKEYCAPS_SRCOVERLAYONEACTIVE &h00010000l
#define DDCKEYCAPS_SRCOVERLAYYUV &h00020000l
#define DDCKEYCAPS_NOCOSTOVERLAY &h00040000l
#define DDPF_ALPHAPIXELS &h00000001l
#define DDPF_ALPHA &h00000002l
#define DDPF_FOURCC &h00000004l
#define DDPF_PALETTEINDEXED4 &h00000008l
#define DDPF_PALETTEINDEXEDTO8 &h00000010l
#define DDPF_PALETTEINDEXED8 &h00000020l
#define DDPF_RGB &h00000040l
#define DDPF_COMPRESSED &h00000080l
#define DDPF_RGBTOYUV &h00000100l
#define DDPF_YUV &h00000200l
#define DDPF_ZBUFFER &h00000400l
#define DDPF_PALETTEINDEXED1 &h00000800l
#define DDPF_PALETTEINDEXED2 &h00001000l
#define DDPF_ZPIXELS &h00002000l
#define DDPF_STENCILBUFFER &h00004000l
#define DDPF_ALPHAPREMULT &h00008000l
#define DDPF_LUMINANCE &h00020000l
#define DDPF_BUMPLUMINANCE &h00040000l
#define DDPF_BUMPDUDV &h00080000l
#define DDENUMSURFACES_ALL &h00000001l
#define DDENUMSURFACES_MATCH &h00000002l
#define DDENUMSURFACES_NOMATCH &h00000004l
#define DDENUMSURFACES_CANBECREATED &h00000008l
#define DDENUMSURFACES_DOESEXIST &h00000010l
#define DDSDM_STANDARDVGAMODE &h00000001l
#define DDEDM_REFRESHRATES &h00000001l
#define DDEDM_STANDARDVGAMODES &h00000002L
#define DDSCL_FULLSCREEN &h00000001l
#define DDSCL_ALLOWREBOOT &h00000002l
#define DDSCL_NOWINDOWCHANGES &h00000004l
#define DDSCL_NORMAL &h00000008l
#define DDSCL_EXCLUSIVE &h00000010l
#define DDSCL_ALLOWMODEX &h00000040l
#define DDSCL_SETFOCUSWINDOW &h00000080l
#define DDSCL_SETDEVICEWINDOW &h00000100l
#define DDSCL_CREATEDEVICEWINDOW &h00000200l
#define DDSCL_MULTITHREADED &h00000400l
#define DDSCL_FPUSETUP &h00000800l
#define DDSCL_FPUPRESERVE &h00001000l
#define DDBLT_ALPHADEST &h00000001l
#define DDBLT_ALPHADESTCONSTOVERRIDE &h00000002l
#define DDBLT_ALPHADESTNEG &h00000004l
#define DDBLT_ALPHADESTSURFACEOVERRIDE &h00000008l
#define DDBLT_ALPHAEDGEBLEND &h00000010l
#define DDBLT_ALPHASRC &h00000020l
#define DDBLT_ALPHASRCCONSTOVERRIDE &h00000040l
#define DDBLT_ALPHASRCNEG &h00000080l
#define DDBLT_ALPHASRCSURFACEOVERRIDE &h00000100l
#define DDBLT_ASYNC &h00000200l
#define DDBLT_COLORFILL &h00000400l
#define DDBLT_DDFX &h00000800l
#define DDBLT_DDROPS &h00001000l
#define DDBLT_KEYDEST &h00002000l
#define DDBLT_KEYDESTOVERRIDE &h00004000l
#define DDBLT_KEYSRC &h00008000l
#define DDBLT_KEYSRCOVERRIDE &h00010000l
#define DDBLT_ROP &h00020000l
#define DDBLT_ROTATIONANGLE &h00040000l
#define DDBLT_ZBUFFER &h00080000l
#define DDBLT_ZBUFFERDESTCONSTOVERRIDE &h00100000l
#define DDBLT_ZBUFFERDESTOVERRIDE &h00200000l
#define DDBLT_ZBUFFERSRCCONSTOVERRIDE &h00400000l
#define DDBLT_ZBUFFERSRCOVERRIDE &h00800000l
#define DDBLT_WAIT &h01000000l
#define DDBLT_DEPTHFILL &h02000000l
#define DDBLT_DONOTWAIT &h08000000l
#define DDBLT_PRESENTATION &h10000000l
#define DDBLT_LAST_PRESENTATION &h20000000l
#define DDBLT_EXTENDED_FLAGS &h40000000l
#define DDBLT_EXTENDED_LINEAR_CONTENT &h00000004l
#define DDBLTFAST_NOCOLORKEY &h00000000
#define DDBLTFAST_SRCCOLORKEY &h00000001
#define DDBLTFAST_DESTCOLORKEY &h00000002
#define DDBLTFAST_WAIT &h00000010
#define DDBLTFAST_DONOTWAIT &h00000020
#define DDFLIP_WAIT &h00000001L
#define DDFLIP_EVEN &h00000002L
#define DDFLIP_ODD &h00000004L
#define DDFLIP_NOVSYNC &h00000008L
#define DDFLIP_INTERVAL2 &h02000000L
#define DDFLIP_INTERVAL3 &h03000000L
#define DDFLIP_INTERVAL4 &h04000000L
#define DDFLIP_STEREO &h00000010L
#define DDFLIP_DONOTWAIT &h00000020L
#define DDOVER_ALPHADEST &h00000001l
#define DDOVER_ALPHADESTCONSTOVERRIDE &h00000002l
#define DDOVER_ALPHADESTNEG &h00000004l
#define DDOVER_ALPHADESTSURFACEOVERRIDE &h00000008l
#define DDOVER_ALPHAEDGEBLEND &h00000010l
#define DDOVER_ALPHASRC &h00000020l
#define DDOVER_ALPHASRCCONSTOVERRIDE &h00000040l
#define DDOVER_ALPHASRCNEG &h00000080l
#define DDOVER_ALPHASRCSURFACEOVERRIDE &h00000100l
#define DDOVER_HIDE &h00000200l
#define DDOVER_KEYDEST &h00000400l
#define DDOVER_KEYDESTOVERRIDE &h00000800l
#define DDOVER_KEYSRC &h00001000l
#define DDOVER_KEYSRCOVERRIDE &h00002000l
#define DDOVER_SHOW &h00004000l
#define DDOVER_ADDDIRTYRECT &h00008000l
#define DDOVER_REFRESHDIRTYRECTS &h00010000l
#define DDOVER_REFRESHALL &h00020000l
#define DDOVER_DDFX &h00080000l
#define DDOVER_AUTOFLIP &h00100000l
#define DDOVER_BOB &h00200000l
#define DDOVER_OVERRIDEBOBWEAVE &h00400000l
#define DDOVER_INTERLEAVED &h00800000l
#define DDOVER_BOBHARDWARE &h01000000l
#define DDOVER_ARGBSCALEFACTORS &h02000000l
#define DDOVER_DEGRADEARGBSCALING &h04000000l
#define DDLOCK_SURFACEMEMORYPTR &h00000000L
#define DDLOCK_WAIT &h00000001L
#define DDLOCK_EVENT &h00000002L
#define DDLOCK_READONLY &h00000010L
#define DDLOCK_WRITEONLY &h00000020L
#define DDLOCK_NOSYSLOCK &h00000800L
#define DDLOCK_NOOVERWRITE &h00001000L
#define DDLOCK_DISCARDCONTENTS &h00002000L
#define DDLOCK_OKTOSWAP &h00002000L
#define DDLOCK_DONOTWAIT &h00004000L
#define DDLOCK_HASVOLUMETEXTUREBOXRECT &h00008000L
#define DDLOCK_NODIRTYUPDATE &h00010000L
#define DDBLTFX_ARITHSTRETCHY &h00000001l
#define DDBLTFX_MIRRORLEFTRIGHT &h00000002l
#define DDBLTFX_MIRRORUPDOWN &h00000004l
#define DDBLTFX_NOTEARING &h00000008l
#define DDBLTFX_ROTATE180 &h00000010l
#define DDBLTFX_ROTATE270 &h00000020l
#define DDBLTFX_ROTATE90 &h00000040l
#define DDBLTFX_ZBUFFERRANGE &h00000080l
#define DDBLTFX_ZBUFFERBASEDEST &h00000100l
#define DDOVERFX_ARITHSTRETCHY &h00000001l
#define DDOVERFX_MIRRORLEFTRIGHT &h00000002l
#define DDOVERFX_MIRRORUPDOWN &h00000004l
#define DDOVERFX_DEINTERLACE &h00000008l
#define DDWAITVB_BLOCKBEGIN &h00000001l
#define DDWAITVB_BLOCKBEGINEVENT &h00000002l
#define DDWAITVB_BLOCKEND &h00000004l
#define DDGFS_CANFLIP &h00000001l
#define DDGFS_ISFLIPDONE &h00000002l
#define DDGBS_CANBLT &h00000001l
#define DDGBS_ISBLTDONE &h00000002l
#define DDENUMOVERLAYZ_BACKTOFRONT &h00000000l
#define DDENUMOVERLAYZ_FRONTTOBACK &h00000001l
#define DDOVERZ_SENDTOFRONT &h00000000l
#define DDOVERZ_SENDTOBACK &h00000001l
#define DDOVERZ_MOVEFORWARD &h00000002l
#define DDOVERZ_MOVEBACKWARD &h00000003l
#define DDOVERZ_INSERTINFRONTOF &h00000004l
#define DDOVERZ_INSERTINBACKOF &h00000005l
#define DDSGR_CALIBRATE &h00000001L
#define DDSMT_ISTESTREQUIRED &h00000001L
#define DDEM_MODEPASSED &h00000001L
#define DDEM_MODEFAILED &h00000002L
#ifndef DD_OK
#define DD_OK                                   S_OK
#define DD_FALSE                                S_FALSE
#endif
#define DDENUMRET_CANCEL 0
#define DDENUMRET_OK 1
#define DDERR_ALREADYINITIALIZED MAKE_DDHRESULT( 5 )
#define DDERR_CANNOTATTACHSURFACE MAKE_DDHRESULT( 10 )
#define DDERR_CANNOTDETACHSURFACE MAKE_DDHRESULT( 20 )
#define DDERR_CURRENTLYNOTAVAIL MAKE_DDHRESULT( 40 )
#define DDERR_EXCEPTION MAKE_DDHRESULT( 55 )
#define DDERR_GENERIC E_FAIL
#define DDERR_HEIGHTALIGN MAKE_DDHRESULT( 90 )
#define DDERR_INCOMPATIBLEPRIMARY MAKE_DDHRESULT( 95 )
#define DDERR_INVALIDCAPS MAKE_DDHRESULT( 100 )
#define DDERR_INVALIDCLIPLIST MAKE_DDHRESULT( 110 )
#define DDERR_INVALIDMODE MAKE_DDHRESULT( 120 )
#define DDERR_INVALIDOBJECT MAKE_DDHRESULT( 130 )
#define DDERR_INVALIDPARAMS E_INVALIDARG
#define DDERR_INVALIDPIXELFORMAT MAKE_DDHRESULT( 145 )
#define DDERR_INVALIDRECT MAKE_DDHRESULT( 150 )
#define DDERR_LOCKEDSURFACES MAKE_DDHRESULT( 160 )
#define DDERR_NO3D MAKE_DDHRESULT( 170 )
#define DDERR_NOALPHAHW MAKE_DDHRESULT( 180 )
#define DDERR_NOSTEREOHARDWARE MAKE_DDHRESULT( 181 )
#define DDERR_NOSURFACELEFT MAKE_DDHRESULT( 182 )
#define DDERR_NOCLIPLIST MAKE_DDHRESULT( 205 )
#define DDERR_NOCOLORCONVHW MAKE_DDHRESULT( 210 )
#define DDERR_NOCOOPERATIVELEVELSET MAKE_DDHRESULT( 212 )
#define DDERR_NOCOLORKEY MAKE_DDHRESULT( 215 )
#define DDERR_NOCOLORKEYHW MAKE_DDHRESULT( 220 )
#define DDERR_NODIRECTDRAWSUPPORT MAKE_DDHRESULT( 222 )
#define DDERR_NOEXCLUSIVEMODE MAKE_DDHRESULT( 225 )
#define DDERR_NOFLIPHW MAKE_DDHRESULT( 230 )
#define DDERR_NOGDI MAKE_DDHRESULT( 240 )
#define DDERR_NOMIRRORHW MAKE_DDHRESULT( 250 )
#define DDERR_NOTFOUND MAKE_DDHRESULT( 255 )
#define DDERR_NOOVERLAYHW MAKE_DDHRESULT( 260 )
#define DDERR_OVERLAPPINGRECTS MAKE_DDHRESULT( 270 )
#define DDERR_NORASTEROPHW MAKE_DDHRESULT( 280 )
#define DDERR_NOROTATIONHW MAKE_DDHRESULT( 290 )
#define DDERR_NOSTRETCHHW MAKE_DDHRESULT( 310 )
#define DDERR_NOT4BITCOLOR MAKE_DDHRESULT( 316 )
#define DDERR_NOT4BITCOLORINDEX MAKE_DDHRESULT( 317 )
#define DDERR_NOT8BITCOLOR MAKE_DDHRESULT( 320 )
#define DDERR_NOTEXTUREHW MAKE_DDHRESULT( 330 )
#define DDERR_NOVSYNCHW MAKE_DDHRESULT( 335 )
#define DDERR_NOZBUFFERHW MAKE_DDHRESULT( 340 )
#define DDERR_NOZOVERLAYHW MAKE_DDHRESULT( 350 )
#define DDERR_OUTOFCAPS MAKE_DDHRESULT( 360 )
#define DDERR_OUTOFMEMORY E_OUTOFMEMORY
#define DDERR_OUTOFVIDEOMEMORY MAKE_DDHRESULT( 380 )
#define DDERR_OVERLAYCANTCLIP MAKE_DDHRESULT( 382 )
#define DDERR_OVERLAYCOLORKEYONLYONEACTIVE MAKE_DDHRESULT( 384 )
#define DDERR_PALETTEBUSY MAKE_DDHRESULT( 387 )
#define DDERR_COLORKEYNOTSET MAKE_DDHRESULT( 400 )
#define DDERR_SURFACEALREADYATTACHED MAKE_DDHRESULT( 410 )
#define DDERR_SURFACEALREADYDEPENDENT MAKE_DDHRESULT( 420 )
#define DDERR_SURFACEBUSY MAKE_DDHRESULT( 430 )
#define DDERR_CANTLOCKSURFACE MAKE_DDHRESULT( 435 )
#define DDERR_SURFACEISOBSCURED MAKE_DDHRESULT( 440 )
#define DDERR_SURFACELOST MAKE_DDHRESULT( 450 )
#define DDERR_SURFACENOTATTACHED MAKE_DDHRESULT( 460 )
#define DDERR_TOOBIGHEIGHT MAKE_DDHRESULT( 470 )
#define DDERR_TOOBIGSIZE MAKE_DDHRESULT( 480 )
#define DDERR_TOOBIGWIDTH MAKE_DDHRESULT( 490 )
#define DDERR_UNSUPPORTED E_NOTIMPL
#define DDERR_UNSUPPORTEDFORMAT MAKE_DDHRESULT( 510 )
#define DDERR_UNSUPPORTEDMASK MAKE_DDHRESULT( 520 )
#define DDERR_INVALIDSTREAM MAKE_DDHRESULT( 521 )
#define DDERR_VERTICALBLANKINPROGRESS MAKE_DDHRESULT( 537 )
#define DDERR_WASSTILLDRAWING MAKE_DDHRESULT( 540 )
#define DDERR_DDSCAPSCOMPLEXREQUIRED MAKE_DDHRESULT( 542 )
#define DDERR_XALIGN MAKE_DDHRESULT( 560 )
#define DDERR_INVALIDDIRECTDRAWGUID MAKE_DDHRESULT( 561 )
#define DDERR_DIRECTDRAWALREADYCREATED MAKE_DDHRESULT( 562 )
#define DDERR_NODIRECTDRAWHW MAKE_DDHRESULT( 563 )
#define DDERR_PRIMARYSURFACEALREADYEXISTS MAKE_DDHRESULT( 564 )
#define DDERR_NOEMULATION MAKE_DDHRESULT( 565 )
#define DDERR_REGIONTOOSMALL MAKE_DDHRESULT( 566 )
#define DDERR_CLIPPERISUSINGHWND MAKE_DDHRESULT( 567 )
#define DDERR_NOCLIPPERATTACHED MAKE_DDHRESULT( 568 )
#define DDERR_NOHWND MAKE_DDHRESULT( 569 )
#define DDERR_HWNDSUBCLASSED MAKE_DDHRESULT( 570 )
#define DDERR_HWNDALREADYSET MAKE_DDHRESULT( 571 )
#define DDERR_NOPALETTEATTACHED MAKE_DDHRESULT( 572 )
#define DDERR_NOPALETTEHW MAKE_DDHRESULT( 573 )
#define DDERR_BLTFASTCANTCLIP MAKE_DDHRESULT( 574 )
#define DDERR_NOBLTHW MAKE_DDHRESULT( 575 )
#define DDERR_NODDROPSHW MAKE_DDHRESULT( 576 )
#define DDERR_OVERLAYNOTVISIBLE MAKE_DDHRESULT( 577 )
#define DDERR_NOOVERLAYDEST MAKE_DDHRESULT( 578 )
#define DDERR_INVALIDPOSITION MAKE_DDHRESULT( 579 )
#define DDERR_NOTAOVERLAYSURFACE MAKE_DDHRESULT( 580 )
#define DDERR_EXCLUSIVEMODEALREADYSET MAKE_DDHRESULT( 581 )
#define DDERR_NOTFLIPPABLE MAKE_DDHRESULT( 582 )
#define DDERR_CANTDUPLICATE MAKE_DDHRESULT( 583 )
#define DDERR_NOTLOCKED MAKE_DDHRESULT( 584 )
#define DDERR_CANTCREATEDC MAKE_DDHRESULT( 585 )
#define DDERR_NODC MAKE_DDHRESULT( 586 )
#define DDERR_WRONGMODE MAKE_DDHRESULT( 587 )
#define DDERR_IMPLICITLYCREATED MAKE_DDHRESULT( 588 )
#define DDERR_NOTPALETTIZED MAKE_DDHRESULT( 589 )
#define DDERR_UNSUPPORTEDMODE MAKE_DDHRESULT( 590 )
#define DDERR_NOMIPMAPHW MAKE_DDHRESULT( 591 )
#define DDERR_INVALIDSURFACETYPE MAKE_DDHRESULT( 592 )
#define DDERR_NOOPTIMIZEHW MAKE_DDHRESULT( 600 )
#define DDERR_NOTLOADED MAKE_DDHRESULT( 601 )
#define DDERR_NOFOCUSWINDOW MAKE_DDHRESULT( 602 )
#define DDERR_NOTONMIPMAPSUBLEVEL MAKE_DDHRESULT( 603 )
#define DDERR_DCALREADYCREATED MAKE_DDHRESULT( 620 )
#define DDERR_NONONLOCALVIDMEM MAKE_DDHRESULT( 630 )
#define DDERR_CANTPAGELOCK MAKE_DDHRESULT( 640 )
#define DDERR_CANTPAGEUNLOCK MAKE_DDHRESULT( 660 )
#define DDERR_NOTPAGELOCKED MAKE_DDHRESULT( 680 )
#define DDERR_MOREDATA MAKE_DDHRESULT( 690 )
#define DDERR_EXPIRED MAKE_DDHRESULT( 691 )
#define DDERR_TESTFINISHED MAKE_DDHRESULT( 692 )
#define DDERR_NEWMODE MAKE_DDHRESULT( 693 )
#define DDERR_D3DNOTINITIALIZED MAKE_DDHRESULT( 694 )
#define DDERR_VIDEONOTACTIVE MAKE_DDHRESULT( 695 )
#define DDERR_NOMONITORINFORMATION MAKE_DDHRESULT( 696 )
#define DDERR_NODRIVERSUPPORT MAKE_DDHRESULT( 697 )
#define DDERR_DEVICEDOESNTOWNSURFACE MAKE_DDHRESULT( 699 )
#define DDERR_NOTINITIALIZED CO_E_NOTINITIALIZED

#define _FACDD &h876
#define MAKE_DDHRESULT( code ) MAKE_HRESULT( 1, _FACDD, code )

#endif
