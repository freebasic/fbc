#ifndef DDRAW_BI
#define DDRAW_BI
''
'' DirectDraw 7 include file (only the DDraw 1 interfaces currently)
'' 
'' ported to FB in nov/2004 by v1ctor (av1ctor@yahoo.com.br)
''
'' completed dec/2004 by DrV (i_am_drv@yahoo.com)
''

#ifndef GUID_DEFINED
#define GUID_DEFINED
type GUID
	 Data1 as uinteger
	 Data2 as ushort
	 Data3 as ushort
	 Data4(7) as ubyte
end type
#endif


type IUnknown_VTBL
	QueryInterface 			as integer
	AddRef 					as integer
	Release 				as function (byval this as any ptr) as integer
end type

type IUnknown
	Vtable					as IUnknown_VTBL ptr
end type

' Flags for DirectDrawEnumerateEx
const DDENUM_ATTACHEDSECONDARYDEVICES%	  = &H00000001
const DDENUM_DETACHEDSECONDARYDEVICES%	  = &H00000002
const DDENUM_NONDISPLAYDEVICES%			  = &H00000004

const REGSTR_KEY_DDHW_DESCRIPTION as string	= "Description"
const REGSTR_KEY_DDHW_DRIVERNAME as string	= "DriverName"
const REGSTR_PATH_DDHW as string 			= "Hardware\DirectDrawDrivers"

const DDCREATE_HARDWAREONLY	as integer		= &H00000001
const DDCREATE_EMULATIONONLY as integer		= &H00000002

type DDRGBA
	 red as ubyte
	 green as ubyte
	 blue as ubyte
	 alpha as ubyte
end type

type DDCOLORKEY
	dwColorSpaceLowValue 		as integer
	dwColorSpaceHighValue 		as integer
end type


type DDBLTFX
    dwSize						as integer
    dwDDFX						as integer
    dwROP						as integer
    dwDDROP						as integer
    dwRotationAngle				as integer
    dwZBufferOpCode				as integer
    dwZBufferLow				as integer
    dwZBufferHigh				as integer
    dwZBufferBaseDest			as integer
    dwZDestConstBitDepth		as integer
    union
		dwZDestConst			as integer
		lpDDSZBufferDest		as any ptr
    end union
    dwZSrcConstBitDepth			as integer
    union
		dwZSrcConst				as integer
		lpDDSZBufferSrc			as any ptr
    end union
    dwAlphaEdgeBlendBitDepth	as integer
    dwAlphaEdgeBlend			as integer
    dwReserved					as integer
    dwAlphaDestConstBitDepth	as integer
    union
		dwAlphaDestConst		as integer
		lpDDSAlphaDest			as any ptr
    end union
    dwAlphaSrcConstBitDepth		as integer
    union
		dwAlphaSrcConst			as integer
		lpDDSAlphaSrc			as any ptr
    end union
    union
		dwFillColor				as integer
		dwFillDepth				as integer
		dwFillPixel				as integer
		lpDDSPattern			as any ptr
    end union
    ddckDestColorkey			as DDCOLORKEY
    ddckSrcColorkey				as DDCOLORKEY
end type


type DDSCAPS
	dwCaps 			as integer
end type

type DDOSCAPS
	 dwCaps as uinteger
end type

type DDSCAPSEX
	 dwCaps2 as uinteger
	 dwCaps3 as uinteger
	 union
	 	  dwCaps4 as uinteger
		  dwVolumeDepth as uinteger
	 end union
end type


type DDSCAPS2
	 dwCaps as uinteger
	 dwCaps2 as uinteger
	 dwCaps3 as uinteger
	 union
	 	  dwCaps4 as uinteger
		  dwVolumeDepth as uinteger
     end union
end type


const DD_ROP_SPACE% = 256 / 32

type DDCAPS
 	dwSize	 				as integer
 	dwCaps	 				as integer
 	dwCaps2	 				as integer
 	dwCKeyCaps	 			as integer
 	dwFXCaps	 			as integer
 	dwFXAlphaCaps			as integer
 	dwPalCaps	 			as integer
 	dwSVCaps	 			as integer
 	dwAlphaBltConstBitDepths	 as integer
 	dwAlphaBltPixelBitDepths	 as integer
 	dwAlphaBltSurfaceBitDepths	 as integer
 	dwAlphaOverlayConstBitDepths	 as integer
 	dwAlphaOverlayPixelBitDepths	 as integer
 	dwAlphaOverlaySurfaceBitDepths	 as integer
 	dwZBufferBitDepths		as integer
 	dwVidMemTotal	 		as integer
 	dwVidMemFree	 		as integer
 	dwMaxVisibleOverlays	as integer
 	dwCurrVisibleOverlays	as integer
 	dwNumFourCCCodes		as integer
 	dwAlignBoundarySrc		as integer
 	dwAlignSizeSrc	 		as integer
 	dwAlignBoundaryDest	 	as integer
 	dwAlignSizeDest			as integer
 	dwAlignStrideAlign		as integer
 	dwRops(0 to DD_ROP_SPACE-1)	 as integer
 	ddsCaps					as DDSCAPS	
 	dwMinOverlayStretch	 	as integer
 	dwMaxOverlayStretch	 	as integer
	dwMinLiveVideoStretch	as integer
 	dwMaxLiveVideoStretch	as integer
 	dwMinHwCodecStretch	 	as integer
 	dwMaxHwCodecStretch	 	as integer
 	dwReserved1	 			as integer
 	dwReserved2	 			as integer
 	dwReserved3	 			as integer
 	dwSVBCaps	 			as integer
 	dwSVBCKeyCaps	 		as integer
 	dwSVBFXCaps	 			as integer
 	dwSVBRops(0 to DD_ROP_SPACE-1)	 as integer
 	dwVSBCaps	 			as	integer
 	dwVSBCKeyCaps	 		as integer
 	dwVSBFXCaps	 			as integer
 	dwVSBRops(0 to DD_ROP_SPACE-1)	 as integer
 	dwSSBCaps	 			as integer
 	dwSSBCKeyCaps	 		as integer
 	dwSSBFXCaps	 			as integer
	dwSSBRops(0 to DD_ROP_SPACE-1)	 as integer
 	dwMaxVideoPorts			as integer
 	dwCurrVideoPorts		as integer
 	dwSVBCaps2	 			as integer
 	dwNLVBCaps	 			as integer
 	dwNLVBCaps2	 			as integer
 	dwNLVBCKeyCaps	 		as integer
 	dwNLVBFXCaps	 		as integer
 	dwNLVBRops(0 to DD_ROP_SPACE-1) as integer
end type

type DDPIXELFORMAT
    dwSize			as integer
    dwFlags			as integer
    dwFourCC		as integer
    union
		dwRGBBitCount		as integer
		dwYUVBitCount		as integer
		dwZBufferBitDepth	as integer
		dwAlphaBitDepth		as integer
    end union
    union
		dwRBitMask			as integer
		dwYBitMask			as integer
    end union
    union
		dwGBitMask			as integer
		dwUBitMask			as integer
    end union
    union
		dwBBitMask			as integer
		dwVBitMask			as integer
    end union
    union
		dwRGBAlphaBitMask	as integer
		dwYUVAlphaBitMask	as integer
		dwRGBZBitMask		as integer
		dwYUVZBitMask		as integer
	end union
end type


type DDOVERLAYFX
    dwSize						as integer
    dwAlphaEdgeBlendBitDepth	as integer
    dwAlphaEdgeBlend			as integer
    dwReserved					as integer
    dwAlphaDestConstBitDepth	as integer
    union
		dwAlphaDestConst		as integer
		lpDDSAlphaDest			as any ptr
    end union
    dwAlphaSrcConstBitDepth		as integer
    union
		dwAlphaSrcConst			as integer
		lpDDSAlphaSrc			as any ptr
    end union
    dckDestColorkey				as DDCOLORKEY
    dckSrcColorkey				as DDCOLORKEY
    dwDDFX						as integer
    dwFlags						as integer
end type


type DDBLTBATCH
    lprDest						as RECT ptr
    lpDDSSrc					as any ptr
    lprSrc						as RECT ptr
    dwFlags						as integer
    lpDDBltFx					as DDBLTFX ptr
end type


type DDGAMMARAMP
	 red(255)					as ushort
	 green(255)					as ushort
	 blue(255)					as ushort
end type


const MAX_DDDEVICEID_STRING = 512

type DDDEVICEIDENTIFIER
	 szDriver					as string * MAX_DDDEVICEID_STRING-1
	 szDescription				as string * MAX_DDDEVICEID_STRING-1

	 liDriverVersion		    as LARGE_INTEGER

	 dwVendorId					as uinteger
	 dwDeviceId					as uinteger
	 dwSubSysId					as uinteger
	 dwRevision					as uinteger

	 guidDeviceIdentifier		as GUID

end type


type DDDEVICEIDENTIFIER2
	 szDriver					as string * MAX_DDDEVICEID_STRING-1
	 szDescription				as string * MAX_DDDEVICEID_STRING-1

	 liDriverVersion			as LARGE_INTEGER

	 dwVendorId					as uinteger
	 dwDeviceId					as uinteger
	 dwSubSysId					as uinteger
	 dwRevision					as uinteger

	 guidDeviceIdentifier		as GUID

	 dwWHQLLevel				as uinteger
end type


type DDSURFACEDESC
    dwSize				as integer
    dwFlags				as integer
    dwHeight			as integer
    dwWidth				as integer
    union
        lPitch			as integer
        dwLinearSize 	as integer
    end union
    dwBackBufferCount	as integer
    union
        dwMipMapCount	as integer
		dwZBufferBitDepth as integer
		dwRefreshRate	as integer
    end union
    dwAlphaBitDepth		as integer
    dwReserved			as integer
    lpSurface			as any ptr
    ddckCKDestOverlay	as DDCOLORKEY
    ddckCKDestBlt		as DDCOLORKEY
    ddckCKSrcOverlay	as DDCOLORKEY
    ddckCKSrcBlt		as DDCOLORKEY
    ddpfPixelFormat		as DDPIXELFORMAT
    ddsCaps				as DDSCAPS
end type

type DDSURFACEDESC2
	 dwSize		   		as uinteger
	 dwFlags			as uinteger
	 dwHeight			as uinteger
	 dwWidth			as uinteger
	 union
	 	  lPitch		as integer
		  dwLinearSize	as uinteger
     end union
	 union
	 	  dwBackBufferCount as uinteger
		  dwDepth			as uinteger
     end union
	 union
	 	  dwMipMapCount		as uinteger
		  dwRefreshRate		as uinteger
		  dwSrcVBHandle		as uinteger
     end union
	 dwAlphaBitDepth as uinteger
	 dwReserved		 as uinteger
	 lpSurface		 as any ptr
	 union
	 	  ddckCKDestOverlay	as DDCOLORKEY
		  dwEmptyFaceColor	as uinteger
     end union
	 ddckCKDestBlt		as DDCOLORKEY
	 ddckCKSrcOverlay	as DDCOLORKEY
	 ddckCKSrcBlt		as DDCOLORKEY
	 union
	 	  ddpfPixelFormat as DDPIXELFORMAT
		  dwFVF			  as uinteger
     end union
	 ddsCaps  			as DDSCAPS2
	 dwTextureStage		as uinteger
end type

' Flags for the IDirectDraw4::GetDeviceIdentifier method
const DDGDI_GETHOSTIDENTIFIER = &H00000001

' "Macros" for interpretting DDEVICEIDENTIFIER2.dwWHQLLevel
private function GET_WHQL_YEAR ( byval dwWHQLLevel as uinteger ) as uinteger
		 GET_WHQL_YEAR = dwWHQLLevel \ &H10000
end function

private function GET_WHQL_MONTH ( byval dwWHQLLevel as uinteger ) as uinteger
		 GET_WHQL_MONTH = (dwWHQLLevel \ &H100) and &H00ff
end function

private function GET_WHQL_DAY ( byval dwWHQLLevel as uinteger ) as uinteger
		 GET_WHQL_DAY = dwWHQLLevel and &Hff
end function

type IDirectDraw_VTBL
	' IUnknown methods
	QueryInterface 			as function (byval this as any ptr, byval riid as integer ptr, byval ppvObj as any ptr) as integer
	AddRef 					as function (byval this as any ptr) as integer
	Release 				as function (byval this as any ptr) as integer
	' IDirectDraw methods
	Compact 				as function (byval this as any ptr) as integer
	CreateClipper 			as function (byval this as any ptr, byval dwFlags as uinteger, byval lplpDDClipper as any ptr, byval pUnkOuter as IUnknown ptr) as integer
	CreatePalette 			as function (byval this as any ptr, byval dwFlags as uinteger, byval lpColorTable as PALETTEENTRY ptr, lplpDDPalette as any ptr, pUnkOuter as IUnknown ptr) as integer
	CreateSurface 			as function (byval this as any ptr, byval arg1 as integer, byval arg2 as integer, byval arg3 as integer) as integer
	DuplicateSurface 		as function (byval this as any ptr, byval lpDDSurface as any ptr, byval lplpDupDDSurface as any ptr) as integer
	EnumDisplayModes 		as function (byval this as any ptr, byval dwFlags as uinteger, byval lpDDSurfaceDesc as DDSURFACEDESC ptr, byval lpContext as any ptr, byval lpEnumCallback as function) as integer
	EnumSurfaces 			as function (byval this as any ptr, byval dwFlags as uinteger, byval lpDDSD as DDSURFACEDESC ptr, byval lpContext as any ptr, byval lpEnumCallback as function) as integer
	FlipToGDISurface 		as function (byval this as any ptr) as integer
	GetCaps 				as function (byval this as any ptr, byval lpDDDriverCaps as DDCAPS ptr, byval lpDDHELCaps as DDCAPS ptr) as integer
	GetDisplayMode 			as function (byval this as any ptr, byval lpDDSurfaceDesc as DDSURFACEDESC ptr) as integer
	GetFourCCCodes 			as function (byval this as any ptr, byval lpNumCodes as uinteger ptr, byval lpCodes as uinteger ptr) as integer
	GetGDISurface 			as function (byval this as any ptr, byval lplpGDIDDSurface as any ptr) as integer
	GetMonitorFequency 		as function (byval this as any ptr, byval lpdwFrequency as uinteger ptr) as integer
	GetScanLine 			as function (byval this as any ptr, byval lpdwScanLine as uinteger ptr) as integer
	GetVerticalBlankStatus 	as function (byval this as any ptr, byval lpbIsInV as integer ptr) as integer
	Initialize 				as function (byval this as any ptr, byval lpGUID as GUID ptr) as integer
	RestoreDisplayMode 		as function (byval this as any ptr) as integer
	SetCooperativeLevel 	as function (byval this as any ptr, byval arg1 as integer, byval arg2 as integer) as integer
	SetDisplayMode 			as function (byval this as any ptr, byval arg1 as integer, byval arg2 as integer, byval arg3 as integer) as integer
	WaitForVerticalBlank 	as function (byval this as any ptr, byval dwFlags as uinteger, byval hEvent as uinteger) as integer
end type

type IDirectDraw
	Vtable					as IDirectDraw_VTBL ptr
end type

type IDirectDrawPalette_VTBL
	' IUnknown methods
	QueryInterface 			as function (byval this as any ptr, byval riid as integer ptr, byval ppvObj as any ptr) as integer
	AddRef 					as function (byval this as any ptr) as integer
	Release 				as function (byval this as any ptr) as integer
    ' IDirectDrawPalette methods
	GetCaps				 	as function (byval this as any ptr, byval lpdwCaps as uinteger ptr) as integer
	GetEntries				as function (byval this as any ptr, byval dwFlags as uinteger, byval dwBase as uinteger, byval dwNumEntries as uinteger, byval lpEntries as PALETTEENTRY ptr) as integer
	Initialize				as function (byval this as any ptr, byval arg1 as uinteger, byval lpPal as PALETTEENTRY ptr) as integer
	SetEntries				as function (byval this as any ptr, byval dwFlags as uinteger, byval dwStartingEntry as uinteger, byval dwCount as uinteger, byval lpEntries as PALETTEENTRY ptr) as integer
end type

type IDirectDrawPalette
	 Vtable			   		as IDirectDrawPalette_VTBL
end type

type IDirectDrawClipper_VTBL
	 ' IUnknown methods
	QueryInterface 			as function (byval this as any ptr, byval riid as integer ptr, byval ppvObj as any ptr) as integer
	AddRef 					as function (byval this as any ptr) as integer
	Release 				as function (byval this as any ptr) as integer
    ' IDirectDrawClipper methods
    GetClipList			 	as function (byval this as any ptr, byval lpRect as RECT ptr, byval lpClipList as RGNDATA ptr, byval lpdwSize as uinteger ptr) as integer
    GetHWnd					as function (byval this as any ptr, byval lphWnd as uinteger) as integer
	Initialize				as function (byval this as any ptr, byval lpDD as any ptr, byval dwFlags as uinteger) as integer
	IsClipListChanged		as function (byval this as any ptr, byval lpbChanged as integer ptr) as integer
	SetClipList				as function (byval this as any ptr, byval lpClipList as RGNDATA ptr, byval dwFlags as uinteger) as integer
	SetHWnd					as function (byval this as any ptr, byval dwFlags as uinteger, byval hWnd as uinteger) as integer
end type

type IDirectDrawClipper
	 Vtable			   		as IDirectDrawClipper_VTBL
end type

type IDirectDrawSurface_VTBL
	' IUnknown methods
	QueryInterface 			as function (byval this as any ptr, byval riid as integer ptr, byval ppvObj as any ptr) as integer
	AddRef 					as function (byval this as any ptr) as integer
	Release 				as function (byval this as any ptr) as integer
	' IDirectDrawSurface methods
	AddAttachedSurface 		as function (byval this as any ptr, byval lpDDSAttachedSurface as any ptr) as integer
	AddOverlayDirtyRect 	as function (byval this as any ptr, byval lpRect as RECT ptr) as integer
	Blt 					as function (byval this as any ptr, byval lpDestRect as RECT ptr, byval lpDDSrcSurface as any ptr, byval lpSrcRect as RECT ptr, byval dwFlags as uinteger, byval lpDDBltFx as DDBLTFX ptr) as integer
	BltBatch 				as function (byval this as any ptr, byval lpDDBltBatch as DDBLTBATCH ptr, byval dwCount as uinteger, byval dwFlag as uinteger) as integer
	BltFast 				as function (byval this as any ptr, byval dwX as uinteger, byval dwY as uinteger, byval lpDDSrcSurface as any ptr, byval lpSrcRect as RECT ptr, byval dwTran as uinteger) as integer
	DeleteAttachedSurface 	as function (byval this as any ptr, byval dwFlags as uinteger, byval lpDDSAttachedSurface as any ptr) as integer
	EnumAttachedSurfaces 	as function (byval this as any ptr, byval lpContext as any ptr, byval lpEnumSurfacesCallback as function) as integer
	EnumOverlayZOrders 		as function (byval this as any ptr, byval dwFlags as uinteger, byval lpContext as any ptr, byval lpfnCallback as function) as integer
	Flip 					as function (byval this as any ptr, byval arg1 as integer, byval arg2 as integer) as integer
	GetAttachedSurface 		as function (byval this as any ptr, byval arg1 as integer, byval arg2 as integer) as integer
	GetBltStatus 			as function (byval this as any ptr, byval dwFlags as uinteger) as integer
	GetCaps 				as function (byval this as any ptr, byval lpDDSCaps as DDSCAPS ptr) as integer
	GetClipper 				as function (byval this as any ptr, byval lplpDDClipper as any ptr) as integer
	GetColorKey 			as function (byval this as any ptr, byval dwFlags as uinteger, byval lpDDColorKey as DDCOLORKEY ptr) as integer
	GetDC 					as function (byval this as any ptr, byval lphDC as any ptr) as integer
	GetFlipStatus 			as function (byval this as any ptr, byval dwFlags as uinteger) as integer
	GetOverlayPosition 		as function (byval this as any ptr, byval lplX as integer ptr, byval lplY as integer ptr) as integer
	GetPalette 				as function (byval this as any ptr, byval lplpDDPalette as any ptr) as integer
	GetPixelFormat 			as function (byval this as any ptr, byval lpDDPixelFormat as DDPIXELFORMAT ptr) as integer
	GetSurfaceDesc 			as function (byval this as any ptr, byval lpDDSurfaceDesc as DDSURFACEDESC ptr) as integer
	Initialize 				as function (byval this as any ptr, byval lpDD as any ptr, byval lpDDSurfaceDesc as DDSURFACEDESC ptr) as integer
	IsLost 					as function (byval this as any ptr) as integer
	Lock 					as function (byval this as any ptr, byval r as RECT ptr, byval arg1 as integer, byval arg2 as integer, byval arg3 as integer) as integer
	ReleaseDC 				as function (byval this as any ptr, byval hDC as uinteger) as integer
	Restore 				as function (byval this as any ptr) as integer
	SetClipper 				as function (byval this as any ptr, byval lpDDClipper as any ptr) as integer
	SetColorKey 			as function (byval this as any ptr, byval dwFlags as uinteger, byval lpDDColorKey as DDCOLORKEY ptr) as integer
	SetOverlayPosition 		as function (byval this as any ptr, byval lX as integer, byval lY as integer) as integer
	SetPalette 				as function (byval this as any ptr, byval lpDDPalette as any ptr) as integer
	Unlock 					as function (byval this as any ptr, byval r as RECT ptr) as integer
	UpdateOverlay 			as function (byval this as any ptr, byval lpSrcRect as RECT ptr, byval lpDDDestSurface as any ptr, byval lpDestRect as RECT ptr, byval dwFlags as uinteger, byval lpDDOverlayFx as DDOVERLAYFX ptr) as integer
	UpdateOverlayDisplay 	as function (byval this as any ptr, byval dwFlags as uinteger) as integer
	UpdateOverlayZOrder 	as function (byval this as any ptr, byval dwFlags as uinteger, byval lpDDSReference as any ptr) as integer
end type

type IDirectDrawSurface
	Vtable					as IDirectDrawSurface_VTBL ptr
end type


type IDirectDrawGammaControl_VTBL
	' IUnknown methods
	QueryInterface 			as function (byval this as any ptr, byval riid as integer ptr, byval ppvObj as any ptr) as integer
	AddRef 					as function (byval this as any ptr) as integer
	Release 				as function (byval this as any ptr) as integer
	' IDirectDrawGammaControl methods
	GetGammaRamp			as function (byval this as any ptr, byval dwFlags as uinteger, byval lpRampData as DDGAMMARAMP ptr) as integer
	SetGammaRamp			as function (byval this as any ptr, byval dwFlags as uinteger, byval lpRampData as DDGAMMARAMP ptr) as integer
end type

type IDirectDrawGammaControl
	 Vtable					as IDirectDrawGammaControl_VTBL ptr
end type

#define DDSD_CAPS  &h00000001	'' default
#define DDSD_HEIGHT  &h00000002
#define DDSD_WIDTH  &h00000004
#define DDSD_PITCH  &h00000008
#define DDSD_BACKBUFFERCOUNT  &h00000020
#define DDSD_ZBUFFERBITDEPTH  &h00000040
#define DDSD_ALPHABITDEPTH  &h00000080
#define DDSD_LPSURFACE  &h00000800
#define DDSD_PIXELFORMAT  &h00001000
#define DDSD_CKDESTOVERLAY  &h00002000
#define DDSD_CKDESTBLT  &h00004000
#define DDSD_CKSRCOVERLAY  &h00008000
#define DDSD_CKSRCBLT  &h00010000
#define DDSD_MIPMAPCOUNT  &h00020000
#define DDSD_REFRESHRATE  &h00040000
#define DDSD_LINEARSIZE  &h00080000
#define DDSD_ALL  &h000ff9ee

type DDOPTSURFACEDESC
	 dwSize			 	as uinteger
	 dwFlags		 	as uinteger
	 ddSCaps		 	as DDSCAPS2
	 ddOSCaps		 	as DDOSCAPS
	 guid			 	as GUID
	 dwCompressionRatio	as uinteger
end type

const DDOSD_GUID as integer		   				= &H00000001
const DDOSD_COMPRESSION_RATIO as integer		= &H00000002
const DDOSD_SCAPS as integer  	 				= &H00000004
const DDOSD_OSCAPS as integer					= &H00000008
const DDOSD_ALL as integer						= &H0000000f

const DDOSDCAPS_OPTCOMPRESSED as integer		= &H00000001
const DDOSDCAPS_OPTREORDERED as integer			= &H00000002
const DDOSDCAPS_MONOLITHICMIPMAP as integer		= &H00000004
const DDOSDCAPS_VALIDSCAPS as integer			= &H30004800
const DDOSDCAPS_VALIDOSCAPS as integer			= &H00000007

type DDCOLORCONTROL
	 dwSize as uinteger
	 dwFlags as uinteger
	 lBrightness as integer
	 lContrast as integer
	 lHue as integer
	 lSaturation as integer
	 lSharpness as integer
	 lGamma as integer
	 lColorEnable as integer
	 dwReserved1 as uinteger
end type

const DDCOLOR_BRIGHTNESS as integer				= &H00000001
const DDCOLOR_CONTRAST as integer				= &H00000002
const DDCOLOR_HUE as integer					= &H00000004
const DDCOLOR_SATURATION as integer				= &H00000008
const DDCOLOR_SHARPNESS as integer				= &H00000010
const DDCOLOR_GAMMA as integer					= &H00000020
const DDCOLOR_COLORENABLE as integer			= &H00000040

'DIRECTDRAWPALETTE CAPABILITIES
#define DDPCAPS_4BIT  &h00000001
#define DDPCAPS_8BITENTRIES  &h00000002
#define DDPCAPS_8BIT  &h00000004
#define DDPCAPS_INITIALIZE  &h00000008
#define DDPCAPS_PRIMARYSURFACE  &h00000010
const DDPCAPS_PRIMARYSURFACELEFT= &h00000020
#define DDPCAPS_ALLOW256  &h00000040
#define DDPCAPS_VSYNC  &h00000080
#define DDPCAPS_1BIT  &h00000100
#define DDPCAPS_2BIT  &h00000200

' DIRECTDRAW SETCOOPERATIVELEVEL FLAGS
#define DDSCL_FULLSCREEN  &h00000001
#define DDSCL_ALLOWREBOOT  &h00000002
#define DDSCL_NOWINDOWCHANGES  &h00000004
#define DDSCL_NORMAL  &h00000008
#define DDSCL_EXCLUSIVE  &h00000010
#define DDSCL_ALLOWMODEX  &h00000040
#define DDSCL_SETFOCUSWINDOW  &h00000080
#define DDSCL_SETDEVICEWINDOW  &h00000100
#define DDSCL_CREATEDEVICEWINDOW  &h00000200

'FLIP FLAGS
#define DDFLIP_WAIT  &h00000001
#define DDFLIP_EVEN  &h00000002
#define DDFLIP_ODD  &h00000004
#define DDFLIP_NOVSYNC  &h00000008
#define DDFLIP_DONOTWAIT  &h00000020

'DIRECTDRAWSURFACE LOCK FLAGS
#define DDLOCK_SURFACEMEMORYPTR  &h00000000	'' default
#define DDLOCK_WAIT  &h00000001
#define DDLOCK_EVENT  &h00000002
#define DDLOCK_READONLY  &h00000010
#define DDLOCK_WRITEONLY  &h00000020
#define DDLOCK_NOSYSLOCK  &h00000800

'DIRECTDRAWSURFACE CAPABILITY FLAGS
#define DDSCAPS_RESERVED1  &h00000001
#define DDSCAPS_ALPHA  &h00000002
#define DDSCAPS_BACKBUFFER  &h00000004
#define DDSCAPS_COMPLEX  &h00000008
#define DDSCAPS_FLIP  &h00000010
#define DDSCAPS_FRONTBUFFER  &h00000020
#define DDSCAPS_OFFSCREENPLAIN  &h00000040
#define DDSCAPS_OVERLAY  &h00000080
#define DDSCAPS_PALETTE  &h00000100
#define DDSCAPS_PRIMARYSURFACE  &h00000200
#define DDSCAPS_PRIMARYSURFACELEFT  &h00000400
#define DDSCAPS_SYSTEMMEMORY  &h00000800
#define DDSCAPS_TEXTURE  &h00001000
#define DDSCAPS_3DDEVICE  &h00002000
#define DDSCAPS_VIDEOMEMORY  &h00004000
#define DDSCAPS_VISIBLE  &h00008000
#define DDSCAPS_WRITEONLY  &h00010000
#define DDSCAPS_ZBUFFER  &h00020000
#define DDSCAPS_OWNDC  &h00040000
#define DDSCAPS_LIVEVIDEO  &h00080000
#define DDSCAPS_HWCODEC  &h00100000
#define DDSCAPS_MODEX  &h00200000
#define DDSCAPS_MIPMAP  &h00400000
#define DDSCAPS_RESERVED2  &h00800000
#define DDSCAPS_ALLOCONLOAD  &h04000000
#define DDSCAPS_VIDEOPORT  &h08000000
#define DDSCAPS_LOCALVIDMEM  &h10000000
#define DDSCAPS_NONLOCALVIDMEM  &h20000000
#define DDSCAPS_STANDARDVGAMODE  &h40000000
#define DDSCAPS_OPTIMIZED  &h80000000

#define DDSCAPS2_RESERVED4  &H00000002
#define DDSCAPS2_HARDWAREDEINTERLACE  &H00000000
#define DDSCAPS2_HINTDYNAMIC  &H00000004
#define DDSCAPS2_HINTSTATIC  &H00000008
#define DDSCAPS2_TEXTUREMANAGE  &H00000010
#define DDSCAPS2_RESERVED1  &H00000020
#define DDSCAPS2_RESERVED2  &H00000040
#define DDSCAPS2_OPAQUE  &H00000080
#define DDSCAPS2_HINTANTIALIASING  &H00000100
#define DDSCAPS2_CUBEMAP  &H00000200
#define DDSCAPS2_CUBEMAP_POSITIVEX  &H00000400
#define DDSCAPS2_CUBEMAP_NEGATIVEX  &H00000800
#define DDSCAPS2_CUBEMAP_POSITIVEY  &H00001000
#define DDSCAPS2_CUBEMAP_NEGATIVEY  &H00002000
#define DDSCAPS2_CUBEMAP_POSITIVEZ  &H00004000
#define DDSCAPS2_CUBEMAP_NEGATIVEZ  &H00008000
#define DDSCAPS2_CUBEMAP_ALLFACES  DDSCAPS2_CUBEMAP_POSITIVEX or _
	  										  	 		   DDSCAPS2_CUBEMAP_NEGATIVEX or _
														   DDSCAPS2_CUBEMAP_POSITIVEY or _
														   DDSCAPS2_CUBEMAP_NEGATIVEY or _
														   DDSCAPS2_CUBEMAP_POSITIVEZ or _
														   DDSCAPS2_CUBEMAP_NEGATIVEZ
#define DDSCAPS2_MIPMAPSUBLEVEL  &H00010000
#define DDSCAPS2_D3DTEXTUREMANAGE  &H00020000
#define DDSCAPS2_DONOTPERSIST  &H00040000
#define DDSCAPS2_STEREOSURFACELEFT  &H00080000
#define DDSCAPS2_VOLUME  &H00200000
#define DDSCAPS2_NOTUSERLOCKABLE  &H00400000
#define DDSCAPS2_POINTS  &H00800000
#define DDSCAPS2_RTPATCHES  &H01000000
#define DDSCAPS2_NPATCHES  &H02000000
#define DDSCAPS2_RESERVED3  &H04000000
#define DDSCAPS2_DISCARDBACKBUFFER  &H10000000
#define DDSCAPS2_ENABLEALPHACHANNEL  &H20000000
#define DDSCAPS2_EXTENDEDFORMATPRIMARY  &H40000000
#define DDSCAPS2_ADDITIONALPRIMARY  &H80000000

#define DDSCAPS3_MULTISAMPLE_MASK  &H0000001F
#define DDSCAPS3_MULTISAMPLE_QUALITY_MASK  &H000000E0
#define DDSCAPS3_MULTISAMPLE_QUALITY_SHIFT  5
#define DDSCAPS3_RESERVED1  &H00000100
#define DDSCAPS3_RESERVED2  &H00000200
#define DDSCAPS3_LIGHTWEIGHTMIPMAP  &H00000400
#define DDSCAPS3_AUTOGENMIPMAP  &H00000800
#define DDSCAPS3_DMAP  &H00001000


' DIRECTDRAW DRIVER CAPABILITY FLAGS
#define DDCAPS_3D  &H00000001
#define DDCAPS_ALIGNBOUNDARYDEST  &H00000002
#define DDCAPS_ALIGNSIZEDEST  &H00000004
#define DDCAPS_ALIGNBOUNDARYSRC  &H00000008
#define DDCAPS_ALIGNSIZESRC  &H00000010
#define DDCAPS_ALIGNSTRIDE  &H00000020
#define DDCAPS_BLT  &H00000040
#define DDCAPS_BLTQUEUE  &H00000080
#define DDCAPS_BLTFOURCC  &H00000100
#define DDCAPS_BLTSTRETCH  &H00000200
#define DDCAPS_GDI  &H00000400
#define DDCAPS_OVERLAY  &H00000800
#define DDCAPS_OVERLAYCANTCLIP  &H00001000
#define DDCAPS_OVERLAYFOURCC  &H00002000
#define DDCAPS_OVERLAYSTRETCH  &H00004000
#define DDCAPS_PALETTE  &H00008000
#define DDCAPS_PALETTEVSYNC  &H00010000
#define DDCAPS_READSCANLINE  &H00020000
#define DDCAPS_RESERVED1  &H00040000
#define DDCAPS_VBI  &H00080000
#define DDCAPS_ZBLTS  &H00100000
#define DDCAPS_ZOVERLAYS  &H00200000
#define DDCAPS_COLORKEY  &H00400000
#define DDCAPS_ALPHA  &H00800000
#define DDCAPS_COLORKEYHWASSIST  &H01000000
#define DDCAPS_NOHARDWARE  &H02000000
#define DDCAPS_BLTCOLORFILL  &H04000000
#define DDCAPS_BANKSWITCHED  &H08000000
#define DDCAPS_BLTDEPTHFILL  &H10000000
#define DDCAPS_CANCLIP  &H20000000
#define DDCAPS_CANCLIPSTRETCHED  &H40000000
#define DDCAPS_CANBLTSYSMEM  &H80000000

' MORE DIRECTDRAW DRIVER CAPABILITY FLAGS (dwCaps2)
#define DDCAPS2_CERTIFIED  &H00000001
#define DDCAPS2_NO2DDURING3DSCENE  &H00000002
#define DDCAPS2_VIDEOPORT  &H00000004
#define DDCAPS2_AUTOFLIPOVERLAY  &H00000008
#define DDCAPS2_CANBOBINTERLEAVED  &H00000010
#define DDCAPS2_CANBOBNONINTERLEAVED  &H00000020
#define DDCAPS2_COLORCONTROLOVERLAY  &H00000040
#define DDCAPS2_COLORCONTROLPRIMARY  &H00000080
#define DDCAPS2_CANDROPZ16BIT  &H00000100
#define DDCAPS2_NONLOCALVIDMEM  &H00000200
#define DDCAPS2_NONLOCALVIDMEMCAPS  &H00000400
#define DDCAPS2_NOPAGELOCKREQUIRED  &H00000800
#define DDCAPS2_WIDESURFACES  &H00001000
#define DDCAPS2_CANFLIPODDEVEN  &H00002000
#define DDCAPS2_CANBOBHARDWARE  &H00004000
#define DDCAPS2_COPYFOURCC  &H00008000
#define DDCAPS2_PRIMARYGAMMA  &H00020000
#define DDCAPS2_CANRENDERWINDOWED  &H00080000
#define DDCAPS2_CANCALIBRATEGAMMA  &H00100000
#define DDCAPS2_FLIPINTERVAL  &H00200000
#define DDCAPS2_FLIPNOVSYNC  &H00400000
#define DDCAPS2_CANMANAGETEXTURE  &H00800000
#define DDCAPS2_TEXMANINNONLOCALVIDMEM  &H01000000
#define DDCAPS2_STEREO  &H02000000
#define DDCAPS2_SYSTONONLOCAL_AS_SYSTOLOCAL  &H04000000
#define DDCAPS2_RESERVED1  &H08000000
#define DDCAPS2_CANMANAGERESOURCE  &H10000000
#define DDCAPS2_DYNAMICTEXTURES  &H20000000
#define DDCAPS2_CANAUTOGENMIPMAP  &H40000000

' DIRECTDRAW FX ALPHA CAPABILITY FLAGS
#define DDFXALPHACAPS_BLTALPHAEDGEBLEND  &H00000001
#define DDFXALPHACAPS_BLTALPHAPIXELS  &H00000002
#define DDFXALPHACAPS_BLTALPHAPIXELSNEG  &H00000004
#define DDFXALPHACAPS_BLTALPHASURFACES  &H00000008
#define DDFXALPHACAPS_BLTALPHASURFACESNEG  &H00000010
#define DDFXALPHACAPS_OVERLAYALPHAEDGEBLEND  &H00000020
#define DDFXALPHACAPS_OVERLAYALPHAPIXELS  &H00000040
#define DDFXALPHACAPS_OVERLAYALPHAPIXELSNEG  &H00000080
#define DDFXALPHACAPS_OVERLAYALPHASURFACES  &H00000100
#define DDFXALPHACAPS_OVERLAYALPHASURFACESNEG  &H00000200

' DIRECTDRAW FX CAPABILITY FLAGS
#define DDFXCAPS_BLTARITHSTRETCHY  &H00000020
#define DDFXCAPS_BLTARITHSTRETCHYN  &H00000010
#define DDFXCAPS_BLTMIRRORLEFTRIGHT  &H00000040
#define DDFXCAPS_BLTMIRRORUPDOWN  &H00000080
#define DDFXCAPS_BLTROTATION  &H00000100
#define DDFXCAPS_BLTROTATION90  &H00000200
#define DDFXCAPS_BLTSHRINKX  &H00000400
#define DDFXCAPS_BLTSHRINKXN  &H00000800
#define DDFXCAPS_BLTSHRINKY  &H00001000
#define DDFXCAPS_BLTSHRINKYN  &H00002000
#define DDFXCAPS_BLTSTRETCHX  &H00004000
#define DDFXCAPS_BLTSTRETCHXN  &H00008000
#define DDFXCAPS_BLTSTRETCHY  &H00010000
#define DDFXCAPS_BLTSTRETCHYN  &H00020000
#define DDFXCAPS_OVERLAYARITHSTRETCHY  &H00040000
#define DDFXCAPS_OVERLAYARITHSTRETCHYN  &H00000008
#define DDFXCAPS_OVERLAYSHRINKX  &H00080000
#define DDFXCAPS_OVERLAYSHRINKXN  &H00100000
#define DDFXCAPS_OVERLAYSHRINKY  &H00200000
#define DDFXCAPS_OVERLAYSHRINKYN  &H00400000
#define DDFXCAPS_OVERLAYSTRETCHX  &H00800000
#define DDFXCAPS_OVERLAYSTRETCHXN  &H01000000
#define DDFXCAPS_OVERLAYSTRETCHY  &H02000000
#define DDFXCAPS_OVERLAYSTRETCHYN  &H04000000
#define DDFXCAPS_OVERLAYMIRRORLEFTRIGHT  &H08000000
#define DDFXCAPS_OVERLAYMIRRORUPDOWN  &H10000000
#define DDFXCAPS_OVERLAYDEINTERLACE  &H20000000
#define DDFXCAPS_BLTALPHA  &H00000001
#define DDFXCAPS_BLTFILTER  DDFXCAPS_BLTARITHSTRETCHY
#define DDFXCAPS_OVERLAYALPHA  &H00000004
#define DDFXCAPS_OVERLAYFILTER  DDFXCAPS_OVERLAYARITHSTRETCHY

' DIRECTDRAW STEREO VIEW CAPABILITIES
#define DDSVCAPS_RESERVED1  &H00000001
#define DDSVCAPS_RESERVED2  &H00000002
#define DDSVCAPS_RESERVED3  &H00000004
#define DDSVCAPS_RESERVED4  &H00000008
#define DDSVCAPS_STEREOSEQUENTIAL  &H00000010

' DIRECTDRAWSURFACE SETPRIVATEDATA CONSTANTS
#define DDSPD_IUNKNOWNPOINTER  &H00000001
#define DDSPD_VOLATILE  &H00000002

' DIRECTDRAW BITDEPTH CONSTANTS
#define DDBD_1  &H00004000
#define DDBD_2  &H00002000
#define DDBD_4  &H00001000
#define DDBD_8  &H00000800
#define DDBD_16  &H00000400
#define DDBD_24  &H00000200
#define DDBD_32  &H00000100

' DIRECTDRAWSURFACE SET/GET COLOR KEY FLAGS
#define DDCKEY_COLORSPACE  &H00000001
#define DDCKEY_DESTBLT  &H00000002
#define DDCKEY_DESTOVERLAY  &H00000004
#define DDCKEY_SRCBLT  &H00000008
#define DDCKEY_SRCOVERLAY  &H00000010

' DIRECTDRAW COLOR KEY CAPABILITY FLAGS
#define DDCKEYCAPS_DESTBLT  &H00000001
#define DDCKEYCAPS_DESTBLTCLRSPACE  &H00000002
#define DDCKEYCAPS_DESTBLTCLRSPACEYUV  &H00000004
#define DDCKEYCAPS_DESTBLTYUV  &H00000008
#define DDCKEYCAPS_DESTOVERLAY  &H00000010
#define DDCKEYCAPS_DESTOVERLAYCLRSPACE  &H00000020
#define DDCKEYCAPS_DESTOVERLAYCLRSPACEYUV  &H00000040
#define DDCKEYCAPS_DESTOVERLAYONEACTIVE  &H00000080
#define DDCKEYCAPS_DESTOVERLAYYUV  &H00000100
#define DDCKEYCAPS_SRCBLT  &H00000200
#define DDCKEYCAPS_SRCBLTCLRSPACE  &H00000400
#define DDCKEYCAPS_SRCBLTCLRSPACEYUV  &H00000800
#define DDCKEYCAPS_SRCBLTYUV  &H00001000
#define DDCKEYCAPS_SRCOVERLAY  &H00002000
#define DDCKEYCAPS_SRCOVERLAYCLRSPACE  &H00004000
#define DDCKEYCAPS_SRCOVERLAYCLRSPACEYUV  &H00008000
#define DDCKEYCAPS_SRCOVERLAYONEACTIVE  &H00010000
#define DDCKEYCAPS_SRCOVERLAYYUV  &H00020000
#define DDCKEYCAPS_NOCOSTOVERLAY  &H00040000

' DIRECTDRAW PIXELFORMAT FLAGS
#define DDPF_ALPHAPIXELS  &H00000001
#define DDPF_ALPHA  &H00000002
#define DDPF_FOURCC  &H00000004
#define DDPF_PALETTEINDEXED4  &H00000008
#define DDPF_PALETTEINDEXEDTO8  &H00000010
#define DDPF_PALETTEINDEXED8  &H00000020
#define DDPF_RGB  &H00000040
#define DDPF_COMPRESSED  &H00000080
#define DDPF_RGBTOYUV  &H00000100
#define DDPF_YUV  &H00000200
#define DDPF_ZBUFFER  &H00000400
#define DDPF_PALETTEINDEXED1  &H00000800
#define DDPF_PALETTEINDEXED2  &H00001000
#define DDPF_ZPIXELS  &H00002000
#define DDPF_STENCILBUFFER  &H00004000
#define DDPF_ALPHAPREMULT  &H00008000
#define DDPF_LUMINANCE  &H00020000
#define DDPF_BUMPLUMINANCE  &H00040000
#define DDPF_BUMPDUDV  &H00080000

'' DIRECTDRAW CALLBACK FLAGS

' DIRECTDRAW ENUMSURFACES FLAGS
#define DDENUMSURFACES_ALL  &H00000001
#define DDENUMSURFACES_MATCH  &H00000002
#define DDENUMSURFACES_NOMATCH  &H00000004
#define DDENUMSURFACES_CANBECREATED  &H00000008
#define DDENUMSURFACES_DOESEXIST  &H00000010

' DIRECTDRAW SETDISPLAYMODE FLAGS
#define DDSDM_STANDARDVGAMODE  &H00000001

' DIRECTDRAW ENUMDISPLAYMODES FLAGS
#define DDEDM_REFRESHRATES  &H00000001
#define DDEDM_STANDARDVGAMODES  &H00000002

' DIRECTDRAW BLT FLAGS
#define DDBLT_ALPHADEST  &H00000001
#define DDBLT_ALPHADESTCONSTOVERRIDE  &H00000002
#define DDBLT_ALPHADESTNEG  &H00000004
#define DDBLT_ALPHADESTSURFACEOVERRIDE  &H00000008
#define DDBLT_ALPHAEDGEBLEND  &H00000010
#define DDBLT_ALPHASRC  &H00000020
#define DDBLT_ALPHASRCCONSTOVERRIDE  &H00000040
#define DDBLT_ALPHASRCNEG  &H00000080
#define DDBLT_ALPHASRCSURFACEOVERRIDE  &H00000100
#define DDBLT_ASYNC  &H00000200
#define DDBLT_COLORFILL  &H00000400
#define DDBLT_DDFX  &H00000800
#define DDBLT_DDROPS  &H00001000
#define DDBLT_KEYDEST  &H00002000
#define DDBLT_KEYDESTOVERRIDE  &H00004000
#define DDBLT_KEYSRC  &H00008000
#define DDBLT_KEYSRCOVERRIDE  &H00010000
#define DDBLT_ROP  &H00020000
#define DDBLT_ROTATIONANGLE  &H00040000
#define DDBLT_ZBUFFER  &H00080000
#define DDBLT_ZBUFFERDESTCONSTOVERRIDE  &H00100000
#define DDBLT_ZBUFFERDESTOVERRIDE  &H00200000
#define DDBLT_ZBUFFERSRCCONSTOVERRIDE  &H00400000
#define DDBLT_ZBUFFERSRCOVERRIDE  &H00800000
#define DDBLT_WAIT  &H01000000
#define DDBLT_DEPTHFILL  &H02000000
#define DDBLT_DONOTWAIT  &H08000000
#define DDBLT_PRESENTATION  &H10000000
#define DDBLT_LAST_PRESENTATION  &H20000000
#define DDBLT_EXTENDED_FLAGS  &H40000000
#define DDBLT_EXTENDED_LINEAR_CONTENT  &H00000004


' BLTFAST FLAGS
#define DDBLTFAST_NOCOLORKEY  &H00000000
#define DDBLTFAST_SRCCOLORKEY  &H00000001
#define DDBLTFAST_DESTCOLORKEY  &H00000002
#define DDBLTFAST_WAIT  &H00000010
#define DDBLTFAST_DONOTWAIT  &H00000020


' DIRECTDRAW SURFACE OVERLAY FLAGS
#define DDOVER_ALPHADEST  &H00000001
#define DDOVER_ALPHADESTCONSTOVERRIDE  &H00000002
#define DDOVER_ALPHADESTNEG  &H00000004
#define DDOVER_ALPHADESTSURFACEOVERRIDE  &H00000008
#define DDOVER_ALPHAEDGEbEND  &H00000010
#define DDOVER_ALPHASRC  &H00000020
#define DDOVER_ALPHASRCCONSTOVERRIDE  &H00000040
#define DDOVER_ALPHASRCNEG  &H00000080
#define DDOVER_ALPHASRCSURFACEOVERRIDE  &H00000100
#define DDOVER_HIDE  &H00000200
#define DDOVER_KEYDEST  &H00000400
#define DDOVER_KEYDESTOVERRIDE  &H00000800
#define DDOVER_KEYSRC  &H00001000
#define DDOVER_KEYSRCOVERRIDE  &H00002000
#define DDOVER_SHOW  &H00004000
#define DDOVER_ADDDIRTYRECT  &H00008000
#define DDOVER_REFRESHDIRTYRECTS  &H00010000
#define DDOVER_REFRESHALL  &H00020000
#define DDOVER_DDFX  &H00080000
#define DDOVER_AUTOFLIP  &H00100000
#define DDOVER_BOB  &H00200000
#define DDOVER_OVERRIDEBOBWEAVE  &H00400000
#define DDOVER_INTERLEAVED  &H00800000
#define DDOVER_BOBHARDWARE  &H01000000
#define DDOVER_ARGBSCALEFACTORS  &H02000000
#define DDOVER_DEGRADEARGBSCALING  &H04000000


' DIRECTDRAWSURFACE BLT FX FLAGS
#define DDBLTFX_ARITHSTRETCHY  &H00000001
#define DDBLTFX_MIRRORLEFTRIGHT  &H00000002
#define DDBLTFX_MIRRORUPDOWN  &H00000004
#define DDBLTFX_NOTEARING  &H00000008
#define DDBLTFX_ROTATE180  &H00000010
#define DDBLTFX_ROTATE270  &H00000020
#define DDBLTFX_ROTATE90  &H00000040
#define DDBLTFX_ZBUFFERRANGE  &H00000080
#define DDBLTFX_ZBUFFERBASEDEST  &H00000100

' DIRECTDRAWSURFACE OVERLAY FX FLAGS
#define DDOVERFX_ARITHSTRETCHY  &H00000001
#define DDOVERFX_MIRRORLEFTRIGHT  &H00000002
#define DDOVERFX_MIRRORUPDOWN  &H00000004
#define DDOVERFX_DEINTERLACE  &H00000008

' DIRECTDRAW WAITFORVERTICALBLANK FLAGS
#define DDWAITVB_BLOCKBEGIN  &H00000001
#define DDWAITVB_BLOCKBEGINEVENT  &H00000002
#define DDWAITVB_BLOCKEND  &H00000004

' DIRECTDRAW GETfIPSTATUS FLAGS
#define DDGFS_CANFLIP  &H00000001
#define DDGFS_ISFLIPDONE  &H00000002

' DIRECTDRAW GETbTSTATUS FLAGS
#define DDGBS_CANBLT  &H00000001
#define DDGBS_ISBLTDONE  &H00000002

' DIRECTDRAW ENUMOVERLAYZORDER FLAGS
#define DDENUMOVERLAYZ_BACKTOFRONT  &H00000000
#define DDENUMOVERLAYZ_FRONTTOBACK  &H00000001

' DIRECTDRAW UPDATEOVERLAYZORDER FLAGS
#define DDOVERZ_SENDTOFRONT  &H00000000
#define DDOVERZ_SENDTOBACK  &H00000001
#define DDOVERZ_MOVEFORWARD  &H00000002
#define DDOVERZ_MOVEBACKWARD  &H00000003
#define DDOVERZ_INSERTINFRONTOF  &H00000004
#define DDOVERZ_INSERTINBACKOF  &H00000005

' DIRECTDRAW SETGAMMARAMP FLAGS
#define DDSGR_CALIBRATE  &H00000001

' DIRECTDRAW STARTMODETEST FLAGS
#define DDSMT_ISTESTREQUIRED  &H00000001

' DIRECTDRAW EVaUATEMODE FLAGS
#define DDEM_MODEPASSED  &H00000001
#define DDEM_MODEFAILED  &H00000002

' DIRECTDRAW RETURN CODES
const DD_OK%                                  = 0
const DD_FALSE%                               = 1

' DIRECTDRAW ENUMCALLBACK RETURN VALUES
const DDENUMRET_CANCEL%                       = 0
const DDENUMRET_OK%                           = 1

'DIRECTDRAW ERRORS
#define DDERR_ALREADYINITIALIZED  (1 shl 31) or (&h876 shl 16) or ( 5 )
#define DDERR_CANNOTATTACHSURFACE  (1 shl 31) or (&h876 shl 16) or ( 10 )
#define DDERR_CANNOTDETACHSURFACE  (1 shl 31) or (&h876 shl 16) or ( 20 )
#define DDERR_CURRENTLYNOTAVAIL  (1 shl 31) or (&h876 shl 16) or ( 40 )
#define DDERR_EXCEPTION  (1 shl 31) or (&h876 shl 16) or ( 55 )
#define DDERR_GENERIC  E_FAIL
#define DDERR_HEIGHTALIGN  (1 shl 31) or (&h876 shl 16) or ( 90 )
#define DDERR_INCOMPATIBLEPRIMARY  (1 shl 31) or (&h876 shl 16) or ( 95 )
#define DDERR_INVALIDCAPS  (1 shl 31) or (&h876 shl 16) or ( 100 )
#define DDERR_INVALIDCLIPLIST  (1 shl 31) or (&h876 shl 16) or ( 110 )
#define DDERR_INVALIDMODE  (1 shl 31) or (&h876 shl 16) or ( 120 )
#define DDERR_INVALIDOBJECT  (1 shl 31) or (&h876 shl 16) or ( 130 )
#define DDERR_INVALIDPARAMS  E_INVALIDARG
#define DDERR_INVALIDPIXELFORMAT  (1 shl 31) or (&h876 shl 16) or ( 145 )
#define DDERR_INVALIDRECT  (1 shl 31) or (&h876 shl 16) or ( 150 )
#define DDERR_LOCKEDSURFACES  (1 shl 31) or (&h876 shl 16) or ( 160 )
#define DDERR_NO3D  (1 shl 31) or (&h876 shl 16) or ( 170 )
#define DDERR_NOALPHAHW  (1 shl 31) or (&h876 shl 16) or ( 180 )
#define DDERR_NOCLIPLIST  (1 shl 31) or (&h876 shl 16) or ( 205 )
#define DDERR_NOCOLORCONVHW  (1 shl 31) or (&h876 shl 16) or ( 210 )
#define DDERR_NOCOOPERATIVELEVELSET  (1 shl 31) or (&h876 shl 16) or ( 212 )
#define DDERR_NOCOLORKEY  (1 shl 31) or (&h876 shl 16) or ( 215 )
#define DDERR_NOCOLORKEYHW  (1 shl 31) or (&h876 shl 16) or ( 220 )
#define DDERR_NODIRECTDRAWSUPPORT  (1 shl 31) or (&h876 shl 16) or ( 222 )
#define DDERR_NOEXCLUSIVEMODE  (1 shl 31) or (&h876 shl 16) or ( 225 )
#define DDERR_NOFLIPHW  (1 shl 31) or (&h876 shl 16) or ( 230 )
#define DDERR_NOGDI  (1 shl 31) or (&h876 shl 16) or ( 240 )
#define DDERR_NOMIRRORHW  (1 shl 31) or (&h876 shl 16) or ( 250 )
#define DDERR_NOTFOUND  (1 shl 31) or (&h876 shl 16) or ( 255 )
#define DDERR_NOOVERLAYHW  (1 shl 31) or (&h876 shl 16) or ( 260 )
#define DDERR_NORASTEROPHW  (1 shl 31) or (&h876 shl 16) or ( 280 )
#define DDERR_NOROTATIONHW  (1 shl 31) or (&h876 shl 16) or ( 290 )
#define DDERR_NOSTRETCHHW  (1 shl 31) or (&h876 shl 16) or ( 310 )
#define DDERR_NOT4BITCOLOR  (1 shl 31) or (&h876 shl 16) or ( 316 )
#define DDERR_NOT4BITCOLORINDEX  (1 shl 31) or (&h876 shl 16) or ( 317 )
#define DDERR_NOT8BITCOLOR  (1 shl 31) or (&h876 shl 16) or ( 320 )
#define DDERR_NOTEXTUREHW  (1 shl 31) or (&h876 shl 16) or ( 330 )
#define DDERR_NOVSYNCHW  (1 shl 31) or (&h876 shl 16) or ( 335 )
#define DDERR_NOZBUFFERHW  (1 shl 31) or (&h876 shl 16) or ( 340 )
#define DDERR_NOZOVERLAYHW  (1 shl 31) or (&h876 shl 16) or ( 350 )
#define DDERR_OUTOFCAPS  (1 shl 31) or (&h876 shl 16) or ( 360 )
#define DDERR_OUTOFMEMORY  E_OUTOFMEMORY
#define DDERR_OUTOFVIDEOMEMORY  (1 shl 31) or (&h876 shl 16) or ( 380 )
#define DDERR_OVERLAYCANTCLIP  (1 shl 31) or (&h876 shl 16) or ( 382 )
#define DDERR_OVERLAYCOLORKEYONLYONEACTIVE  (1 shl 31) or (&h876 shl 16) or ( 384 )
#define DDERR_PALETTEBUSY  (1 shl 31) or (&h876 shl 16) or ( 387 )
#define DDERR_COLORKEYNOTSET  (1 shl 31) or (&h876 shl 16) or ( 400 )
#define DDERR_SURFACEALREADYATTACHED  (1 shl 31) or (&h876 shl 16) or ( 410 )
#define DDERR_SURFACEALREADYDEPENDENT  (1 shl 31) or (&h876 shl 16) or ( 420 )
#define DDERR_SURFACEBUSY  (1 shl 31) or (&h876 shl 16) or ( 430 )
#define DDERR_CANTLOCKSURFACE  (1 shl 31) or (&h876 shl 16) or ( 435 )
#define DDERR_SURFACEISOBSCURED  (1 shl 31) or (&h876 shl 16) or ( 440 )
#define DDERR_SURFACELOST  (1 shl 31) or (&h876 shl 16) or ( 450 )
#define DDERR_SURFACENOTATTACHED  (1 shl 31) or (&h876 shl 16) or ( 460 )
#define DDERR_TOOBIGHEIGHT  (1 shl 31) or (&h876 shl 16) or ( 470 )
#define DDERR_TOOBIGSIZE  (1 shl 31) or (&h876 shl 16) or ( 480 )
#define DDERR_TOOBIGWIDTH  (1 shl 31) or (&h876 shl 16) or ( 490 )
#define DDERR_UNSUPPORTED  E_NOTIMPL
#define DDERR_UNSUPPORTEDFORMAT  (1 shl 31) or (&h876 shl 16) or ( 510 )
#define DDERR_UNSUPPORTEDMASK  (1 shl 31) or (&h876 shl 16) or ( 520 )
#define DDERR_VERTICALBLANKINPROGRESS  (1 shl 31) or (&h876 shl 16) or ( 537 )
#define DDERR_WASSTILLDRAWING  (1 shl 31) or (&h876 shl 16) or ( 540 )
#define DDERR_XALIGN  (1 shl 31) or (&h876 shl 16) or ( 560 )
#define DDERR_INVALIDDIRECTDRAWGUID  (1 shl 31) or (&h876 shl 16) or ( 561 )
#define DDERR_DIRECTDRAWALREADYCREATED  (1 shl 31) or (&h876 shl 16) or ( 562 )
#define DDERR_NODIRECTDRAWHW  (1 shl 31) or (&h876 shl 16) or ( 563 )
#define DDERR_PRIMARYSURFACEALREADYEXISTS  (1 shl 31) or (&h876 shl 16) or ( 564 )
#define DDERR_NOEMULATION  (1 shl 31) or (&h876 shl 16) or ( 565 )
#define DDERR_REGIONTOOSMALL  (1 shl 31) or (&h876 shl 16) or ( 566 )
#define DDERR_CLIPPERISUSINGHWND  (1 shl 31) or (&h876 shl 16) or ( 567 )
#define DDERR_NOCLIPPERATTACHED  (1 shl 31) or (&h876 shl 16) or ( 568 )
#define DDERR_NOHWND  (1 shl 31) or (&h876 shl 16) or ( 569 )
#define DDERR_HWNDSUBCLASSED  (1 shl 31) or (&h876 shl 16) or ( 570 )
#define DDERR_HWNDALREADYSET  (1 shl 31) or (&h876 shl 16) or ( 571 )
#define DDERR_NOPALETTEATTACHED  (1 shl 31) or (&h876 shl 16) or ( 572 )
#define DDERR_NOPALETTEHW  (1 shl 31) or (&h876 shl 16) or ( 573 )
#define DDERR_BLTFASTCANTCLIP  (1 shl 31) or (&h876 shl 16) or ( 574 )
#define DDERR_NOBLTHW  (1 shl 31) or (&h876 shl 16) or ( 575 )
#define DDERR_NODDROPSHW  (1 shl 31) or (&h876 shl 16) or ( 576 )
#define DDERR_OVERLAYNOTVISIBLE  (1 shl 31) or (&h876 shl 16) or ( 577 )
#define DDERR_NOOVERLAYDEST  (1 shl 31) or (&h876 shl 16) or ( 578 )
#define DDERR_INVALIDPOSITION  (1 shl 31) or (&h876 shl 16) or ( 579 )
#define DDERR_NOTAOVERLAYSURFACE  (1 shl 31) or (&h876 shl 16) or ( 580 )
#define DDERR_EXCLUSIVEMODEALREADYSET  (1 shl 31) or (&h876 shl 16) or ( 581 )
#define DDERR_NOTFLIPPABLE  (1 shl 31) or (&h876 shl 16) or ( 582 )
#define DDERR_CANTDUPLICATE  (1 shl 31) or (&h876 shl 16) or ( 583 )
#define DDERR_NOTLOCKED  (1 shl 31) or (&h876 shl 16) or ( 584 )
#define DDERR_CANTCREATEDC  (1 shl 31) or (&h876 shl 16) or ( 585 )
#define DDERR_NODC  (1 shl 31) or (&h876 shl 16) or ( 586 )
#define DDERR_WRONGMODE  (1 shl 31) or (&h876 shl 16) or ( 587 )
#define DDERR_IMPLICITLYCREATED  (1 shl 31) or (&h876 shl 16) or ( 588 )
#define DDERR_NOTPALETTIZED  (1 shl 31) or (&h876 shl 16) or ( 589 )
#define DDERR_UNSUPPORTEDMODE  (1 shl 31) or (&h876 shl 16) or ( 590 )
#define DDERR_NOMIPMAPHW  (1 shl 31) or (&h876 shl 16) or ( 591 )
#define DDERR_INVALIDSURFACETYPE  (1 shl 31) or (&h876 shl 16) or ( 592 )
#define DDERR_NOOPTIMIZEHW  (1 shl 31) or (&h876 shl 16) or ( 600 )
#define DDERR_NOTLOADED  (1 shl 31) or (&h876 shl 16) or ( 601 )
#define DDERR_NOFOCUSWINDOW  (1 shl 31) or (&h876 shl 16) or ( 602 )
#define DDERR_DCALREADYCREATED  (1 shl 31) or (&h876 shl 16) or ( 620 )
#define DDERR_NONONLOCALVIDMEM  (1 shl 31) or (&h876 shl 16) or ( 630 )
#define DDERR_CANTPAGELOCK  (1 shl 31) or (&h876 shl 16) or ( 640 )
#define DDERR_CANTPAGEUNLOCK  (1 shl 31) or (&h876 shl 16) or ( 660 )
#define DDERR_NOTPAGELOCKED  (1 shl 31) or (&h876 shl 16) or ( 680 )
#define DDERR_MOREDATA  (1 shl 31) or (&h876 shl 16) or ( 690 )
#define DDERR_VIDEONOTACTIVE  (1 shl 31) or (&h876 shl 16) or ( 695 )
#define DDERR_DEVICEDOESNTOWNSURFACE  (1 shl 31) or (&h876 shl 16) or ( 699 )


declare function DirectDrawCreate lib "ddraw" alias "DirectDrawCreate" (byval lpGUID as GUID ptr, _
																 		byval lpDD as IDirectDraw ptr, _
																 		byval pUnkOuter as IUnknown ptr) as integer

declare function DirectDrawEnumerate lib "ddraw" alias "DirectDrawEnumerateA" ( byval lpCallback as function, _
				 					 	 		 	   						  	byval lpContext as any ptr) as integer

declare function DirectDrawEnumerateEx lib "ddraw" alias "DirectDrawEnumerateExA" ( byval lpCallback as function, _
				 					   	   		   		 						  	byval lpContext as any ptr, _
																					byval dwFlags as uinteger) as integer

declare function DirectDrawCreateEx lib "ddraw" alias "DirectDrawCreateEx" ( byval lpGuid as GUID ptr, _
				 									  					   	 byval lplpDD as any ptr, _
																			 byval iid as GUID ptr, _
																			 byval pUnkOuter as IUnknown ptr) as integer

declare function DirectDrawCreateClipper lib "ddraw" alias "DirectDrawCreateClipper" ( byval dwFlags as uinteger, _
				 						 	 		 	   							   byval lplpDDClipper as any ptr, _
																					   byval pUnkOuter as IUnknown ptr) as integer

#endif ''DDRAW_BI