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

const DDSD_CAPS					= &h00000001	'' default
const DDSD_HEIGHT				= &h00000002
const DDSD_WIDTH				= &h00000004
const DDSD_PITCH				= &h00000008
const DDSD_BACKBUFFERCOUNT		= &h00000020
const DDSD_ZBUFFERBITDEPTH		= &h00000040
const DDSD_ALPHABITDEPTH		= &h00000080
const DDSD_LPSURFACE			= &h00000800
const DDSD_PIXELFORMAT			= &h00001000
const DDSD_CKDESTOVERLAY		= &h00002000
const DDSD_CKDESTBLT			= &h00004000
const DDSD_CKSRCOVERLAY			= &h00008000
const DDSD_CKSRCBLT				= &h00010000
const DDSD_MIPMAPCOUNT        	= &h00020000
const DDSD_REFRESHRATE			= &h00040000
const DDSD_LINEARSIZE			= &h00080000
const DDSD_ALL					= &h000ff9ee

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
const DDPCAPS_4BIT				= &h00000001
const DDPCAPS_8BITENTRIES		= &h00000002
const DDPCAPS_8BIT				= &h00000004
const DDPCAPS_INITIALIZE		= &h00000008
const DDPCAPS_PRIMARYSURFACE	= &h00000010
const DDPCAPS_PRIMARYSURFACELEFT= &h00000020
const DDPCAPS_ALLOW256			= &h00000040
const DDPCAPS_VSYNC				= &h00000080
const DDPCAPS_1BIT				= &h00000100
const DDPCAPS_2BIT				= &h00000200

' DIRECTDRAW SETCOOPERATIVELEVEL FLAGS
const DDSCL_FULLSCREEN			= &h00000001
const DDSCL_ALLOWREBOOT			= &h00000002
const DDSCL_NOWINDOWCHANGES		= &h00000004
const DDSCL_NORMAL				= &h00000008
const DDSCL_EXCLUSIVE           = &h00000010
const DDSCL_ALLOWMODEX          = &h00000040
const DDSCL_SETFOCUSWINDOW      = &h00000080
const DDSCL_SETDEVICEWINDOW     = &h00000100
const DDSCL_CREATEDEVICEWINDOW  = &h00000200

'FLIP FLAGS
const DDFLIP_WAIT               = &h00000001
const DDFLIP_EVEN               = &h00000002
const DDFLIP_ODD                = &h00000004
const DDFLIP_NOVSYNC			= &h00000008
const DDFLIP_DONOTWAIT			= &h00000020

'DIRECTDRAWSURFACE LOCK FLAGS
const DDLOCK_SURFACEMEMORYPTR	= &h00000000	'' default
const DDLOCK_WAIT				= &h00000001
const DDLOCK_EVENT				= &h00000002
const DDLOCK_READONLY			= &h00000010
const DDLOCK_WRITEONLY			= &h00000020
const DDLOCK_NOSYSLOCK          = &h00000800

'DIRECTDRAWSURFACE CAPABILITY FLAGS
const DDSCAPS_RESERVED1				= &h00000001
const DDSCAPS_ALPHA					= &h00000002
const DDSCAPS_BACKBUFFER			= &h00000004
const DDSCAPS_COMPLEX				= &h00000008
const DDSCAPS_FLIP					= &h00000010
const DDSCAPS_FRONTBUFFER			= &h00000020
const DDSCAPS_OFFSCREENPLAIN		= &h00000040
const DDSCAPS_OVERLAY				= &h00000080
const DDSCAPS_PALETTE				= &h00000100
const DDSCAPS_PRIMARYSURFACE		= &h00000200
const DDSCAPS_PRIMARYSURFACELEFT	= &h00000400
const DDSCAPS_SYSTEMMEMORY			= &h00000800
const DDSCAPS_TEXTURE			    = &h00001000
const DDSCAPS_3DDEVICE              = &h00002000
const DDSCAPS_VIDEOMEMORY			= &h00004000
const DDSCAPS_VISIBLE				= &h00008000
const DDSCAPS_WRITEONLY				= &h00010000
const DDSCAPS_ZBUFFER				= &h00020000
const DDSCAPS_OWNDC					= &h00040000
const DDSCAPS_LIVEVIDEO				= &h00080000
const DDSCAPS_HWCODEC				= &h00100000
const DDSCAPS_MODEX					= &h00200000
const DDSCAPS_MIPMAP                = &h00400000
const DDSCAPS_RESERVED2             = &h00800000
const DDSCAPS_ALLOCONLOAD           = &h04000000
const DDSCAPS_VIDEOPORT				= &h08000000
const DDSCAPS_LOCALVIDMEM           = &h10000000
const DDSCAPS_NONLOCALVIDMEM        = &h20000000
const DDSCAPS_STANDARDVGAMODE       = &h40000000
const DDSCAPS_OPTIMIZED             = &h80000000

const DDSCAPS2_RESERVED4                      = &H00000002
const DDSCAPS2_HARDWAREDEINTERLACE            = &H00000000
const DDSCAPS2_HINTDYNAMIC                    = &H00000004
const DDSCAPS2_HINTSTATIC                     = &H00000008
const DDSCAPS2_TEXTUREMANAGE                  = &H00000010
const DDSCAPS2_RESERVED1                      = &H00000020
const DDSCAPS2_RESERVED2                      = &H00000040
const DDSCAPS2_OPAQUE                         = &H00000080
const DDSCAPS2_HINTANTIALIASING               = &H00000100
const DDSCAPS2_CUBEMAP                        = &H00000200
const DDSCAPS2_CUBEMAP_POSITIVEX              = &H00000400
const DDSCAPS2_CUBEMAP_NEGATIVEX              = &H00000800
const DDSCAPS2_CUBEMAP_POSITIVEY              = &H00001000
const DDSCAPS2_CUBEMAP_NEGATIVEY              = &H00002000
const DDSCAPS2_CUBEMAP_POSITIVEZ              = &H00004000
const DDSCAPS2_CUBEMAP_NEGATIVEZ              = &H00008000
const DDSCAPS2_CUBEMAP_ALLFACES				  = DDSCAPS2_CUBEMAP_POSITIVEX or _
	  										  	 		   DDSCAPS2_CUBEMAP_NEGATIVEX or _
														   DDSCAPS2_CUBEMAP_POSITIVEY or _
														   DDSCAPS2_CUBEMAP_NEGATIVEY or _
														   DDSCAPS2_CUBEMAP_POSITIVEZ or _
														   DDSCAPS2_CUBEMAP_NEGATIVEZ
const DDSCAPS2_MIPMAPSUBLEVEL                 = &H00010000
const DDSCAPS2_D3DTEXTUREMANAGE               = &H00020000
const DDSCAPS2_DONOTPERSIST                   = &H00040000
const DDSCAPS2_STEREOSURFACELEFT              = &H00080000
const DDSCAPS2_VOLUME                         = &H00200000
const DDSCAPS2_NOTUSERLOCKABLE                = &H00400000
const DDSCAPS2_POINTS                         = &H00800000
const DDSCAPS2_RTPATCHES                      = &H01000000
const DDSCAPS2_NPATCHES                       = &H02000000
const DDSCAPS2_RESERVED3                      = &H04000000
const DDSCAPS2_DISCARDBACKBUFFER              = &H10000000
const DDSCAPS2_ENABLEALPHACHANNEL             = &H20000000
const DDSCAPS2_EXTENDEDFORMATPRIMARY          = &H40000000
const DDSCAPS2_ADDITIONALPRIMARY              = &H80000000

const DDSCAPS3_MULTISAMPLE_MASK				  = &H0000001F
const DDSCAPS3_MULTISAMPLE_QUALITY_MASK		  = &H000000E0
const DDSCAPS3_MULTISAMPLE_QUALITY_SHIFT	  = 5
const DDSCAPS3_RESERVED1					  = &H00000100
const DDSCAPS3_RESERVED2					  = &H00000200
const DDSCAPS3_LIGHTWEIGHTMIPMAP			  = &H00000400
const DDSCAPS3_AUTOGENMIPMAP				  = &H00000800
const DDSCAPS3_DMAP							  = &H00001000


' DIRECTDRAW DRIVER CAPABILITY FLAGS
const DDCAPS_3D                       = &H00000001
const DDCAPS_ALIGNBOUNDARYDEST        = &H00000002
const DDCAPS_ALIGNSIZEDEST            = &H00000004
const DDCAPS_ALIGNBOUNDARYSRC         = &H00000008
const DDCAPS_ALIGNSIZESRC             = &H00000010
const DDCAPS_ALIGNSTRIDE              = &H00000020
const DDCAPS_BLT                      = &H00000040
const DDCAPS_BLTQUEUE                 = &H00000080
const DDCAPS_BLTFOURCC                = &H00000100
const DDCAPS_BLTSTRETCH               = &H00000200
const DDCAPS_GDI                      = &H00000400
const DDCAPS_OVERLAY                  = &H00000800
const DDCAPS_OVERLAYCANTCLIP          = &H00001000
const DDCAPS_OVERLAYFOURCC            = &H00002000
const DDCAPS_OVERLAYSTRETCH           = &H00004000
const DDCAPS_PALETTE                  = &H00008000
const DDCAPS_PALETTEVSYNC             = &H00010000
const DDCAPS_READSCANLINE             = &H00020000
const DDCAPS_RESERVED1                = &H00040000
const DDCAPS_VBI                      = &H00080000
const DDCAPS_ZBLTS                    = &H00100000
const DDCAPS_ZOVERLAYS                = &H00200000
const DDCAPS_COLORKEY                 = &H00400000
const DDCAPS_ALPHA                    = &H00800000
const DDCAPS_COLORKEYHWASSIST         = &H01000000
const DDCAPS_NOHARDWARE               = &H02000000
const DDCAPS_BLTCOLORFILL             = &H04000000
const DDCAPS_BANKSWITCHED             = &H08000000
const DDCAPS_BLTDEPTHFILL             = &H10000000
const DDCAPS_CANCLIP                  = &H20000000
const DDCAPS_CANCLIPSTRETCHED         = &H40000000
const DDCAPS_CANBLTSYSMEM             = &H80000000

' MORE DIRECTDRAW DRIVER CAPABILITY FLAGS (dwCaps2)
const DDCAPS2_CERTIFIED              = &H00000001
const DDCAPS2_NO2DDURING3DSCENE       = &H00000002
const DDCAPS2_VIDEOPORT               = &H00000004
const DDCAPS2_AUTOFLIPOVERLAY         = &H00000008
const DDCAPS2_CANBOBINTERLEAVED       = &H00000010
const DDCAPS2_CANBOBNONINTERLEAVED    = &H00000020
const DDCAPS2_COLORCONTROLOVERLAY     = &H00000040
const DDCAPS2_COLORCONTROLPRIMARY     = &H00000080
const DDCAPS2_CANDROPZ16BIT           = &H00000100
const DDCAPS2_NONLOCALVIDMEM          = &H00000200
const DDCAPS2_NONLOCALVIDMEMCAPS      = &H00000400
const DDCAPS2_NOPAGELOCKREQUIRED      = &H00000800
const DDCAPS2_WIDESURFACES            = &H00001000
const DDCAPS2_CANFLIPODDEVEN          = &H00002000
const DDCAPS2_CANBOBHARDWARE          = &H00004000
const DDCAPS2_COPYFOURCC              = &H00008000
const DDCAPS2_PRIMARYGAMMA            = &H00020000
const DDCAPS2_CANRENDERWINDOWED       = &H00080000
const DDCAPS2_CANCALIBRATEGAMMA       = &H00100000
const DDCAPS2_FLIPINTERVAL            = &H00200000
const DDCAPS2_FLIPNOVSYNC             = &H00400000
const DDCAPS2_CANMANAGETEXTURE        = &H00800000
const DDCAPS2_TEXMANINNONLOCALVIDMEM  = &H01000000
const DDCAPS2_STEREO                  = &H02000000
const DDCAPS2_SYSTONONLOCAL_AS_SYSTOLOCAL   = &H04000000
const DDCAPS2_RESERVED1                     = &H08000000
const DDCAPS2_CANMANAGERESOURCE             = &H10000000
const DDCAPS2_DYNAMICTEXTURES               = &H20000000
const DDCAPS2_CANAUTOGENMIPMAP              = &H40000000

' DIRECTDRAW FX ALPHA CAPABILITY FLAGS
const DDFXALPHACAPS_BLTALPHAEDGEBLEND         = &H00000001
const DDFXALPHACAPS_BLTALPHAPIXELS            = &H00000002
const DDFXALPHACAPS_BLTALPHAPIXELSNEG         = &H00000004
const DDFXALPHACAPS_BLTALPHASURFACES          = &H00000008
const DDFXALPHACAPS_BLTALPHASURFACESNEG       = &H00000010
const DDFXALPHACAPS_OVERLAYALPHAEDGEBLEND     = &H00000020
const DDFXALPHACAPS_OVERLAYALPHAPIXELS        = &H00000040
const DDFXALPHACAPS_OVERLAYALPHAPIXELSNEG     = &H00000080
const DDFXALPHACAPS_OVERLAYALPHASURFACES      = &H00000100
const DDFXALPHACAPS_OVERLAYALPHASURFACESNEG   = &H00000200

' DIRECTDRAW FX CAPABILITY FLAGS
const DDFXCAPS_BLTARITHSTRETCHY       = &H00000020
const DDFXCAPS_BLTARITHSTRETCHYN      = &H00000010
const DDFXCAPS_BLTMIRRORLEFTRIGHT     = &H00000040
const DDFXCAPS_BLTMIRRORUPDOWN        = &H00000080
const DDFXCAPS_BLTROTATION            = &H00000100
const DDFXCAPS_BLTROTATION90          = &H00000200
const DDFXCAPS_BLTSHRINKX             = &H00000400
const DDFXCAPS_BLTSHRINKXN            = &H00000800
const DDFXCAPS_BLTSHRINKY             = &H00001000
const DDFXCAPS_BLTSHRINKYN            = &H00002000
const DDFXCAPS_BLTSTRETCHX            = &H00004000
const DDFXCAPS_BLTSTRETCHXN           = &H00008000
const DDFXCAPS_BLTSTRETCHY            = &H00010000
const DDFXCAPS_BLTSTRETCHYN           = &H00020000
const DDFXCAPS_OVERLAYARITHSTRETCHY   = &H00040000
const DDFXCAPS_OVERLAYARITHSTRETCHYN  = &H00000008
const DDFXCAPS_OVERLAYSHRINKX         = &H00080000
const DDFXCAPS_OVERLAYSHRINKXN        = &H00100000
const DDFXCAPS_OVERLAYSHRINKY         = &H00200000
const DDFXCAPS_OVERLAYSHRINKYN        = &H00400000
const DDFXCAPS_OVERLAYSTRETCHX        = &H00800000
const DDFXCAPS_OVERLAYSTRETCHXN       = &H01000000
const DDFXCAPS_OVERLAYSTRETCHY        = &H02000000
const DDFXCAPS_OVERLAYSTRETCHYN       = &H04000000
const DDFXCAPS_OVERLAYMIRRORLEFTRIGHT = &H08000000
const DDFXCAPS_OVERLAYMIRRORUPDOWN    = &H10000000
const DDFXCAPS_OVERLAYDEINTERLACE		= &H20000000
const DDFXCAPS_BLTALPHA               = &H00000001
const DDFXCAPS_BLTFILTER              = DDFXCAPS_BLTARITHSTRETCHY
const DDFXCAPS_OVERLAYALPHA           = &H00000004
const DDFXCAPS_OVERLAYFILTER          = DDFXCAPS_OVERLAYARITHSTRETCHY

' DIRECTDRAW STEREO VIEW CAPABILITIES
const DDSVCAPS_RESERVED1              = &H00000001
const DDSVCAPS_RESERVED2              = &H00000002
const DDSVCAPS_RESERVED3              = &H00000004
const DDSVCAPS_RESERVED4              = &H00000008
const DDSVCAPS_STEREOSEQUENTIAL       = &H00000010

' DIRECTDRAWSURFACE SETPRIVATEDATA CONSTANTS
const DDSPD_IUNKNOWNPOINTER           = &H00000001
const DDSPD_VOLATILE                  = &H00000002

' DIRECTDRAW BITDEPTH CONSTANTS
const DDBD_1                  = &H00004000
const DDBD_2                  = &H00002000
const DDBD_4                  = &H00001000
const DDBD_8                  = &H00000800
const DDBD_16                 = &H00000400
const DDBD_24                 = &H00000200
const DDBD_32                 = &H00000100

' DIRECTDRAWSURFACE SET/GET COLOR KEY FLAGS
const DDCKEY_COLORSPACE       = &H00000001
const DDCKEY_DESTBLT          = &H00000002
const DDCKEY_DESTOVERLAY      = &H00000004
const DDCKEY_SRCBLT           = &H00000008
const DDCKEY_SRCOVERLAY       = &H00000010

' DIRECTDRAW COLOR KEY CAPABILITY FLAGS
const DDCKEYCAPS_DESTBLT                      = &H00000001
const DDCKEYCAPS_DESTBLTCLRSPACE              = &H00000002
const DDCKEYCAPS_DESTBLTCLRSPACEYUV           = &H00000004
const DDCKEYCAPS_DESTBLTYUV                   = &H00000008
const DDCKEYCAPS_DESTOVERLAY                  = &H00000010
const DDCKEYCAPS_DESTOVERLAYCLRSPACE          = &H00000020
const DDCKEYCAPS_DESTOVERLAYCLRSPACEYUV       = &H00000040
const DDCKEYCAPS_DESTOVERLAYONEACTIVE         = &H00000080
const DDCKEYCAPS_DESTOVERLAYYUV               = &H00000100
const DDCKEYCAPS_SRCBLT                       = &H00000200
const DDCKEYCAPS_SRCBLTCLRSPACE               = &H00000400
const DDCKEYCAPS_SRCBLTCLRSPACEYUV            = &H00000800
const DDCKEYCAPS_SRCBLTYUV                    = &H00001000
const DDCKEYCAPS_SRCOVERLAY                   = &H00002000
const DDCKEYCAPS_SRCOVERLAYCLRSPACE           = &H00004000
const DDCKEYCAPS_SRCOVERLAYCLRSPACEYUV        = &H00008000
const DDCKEYCAPS_SRCOVERLAYONEACTIVE          = &H00010000
const DDCKEYCAPS_SRCOVERLAYYUV                = &H00020000
const DDCKEYCAPS_NOCOSTOVERLAY                = &H00040000

' DIRECTDRAW PIXELFORMAT FLAGS
const DDPF_ALPHAPIXELS                        = &H00000001
const DDPF_ALPHA                              = &H00000002
const DDPF_FOURCC                             = &H00000004
const DDPF_PALETTEINDEXED4                    = &H00000008
const DDPF_PALETTEINDEXEDTO8                  = &H00000010
const DDPF_PALETTEINDEXED8                    = &H00000020
const DDPF_RGB                                = &H00000040
const DDPF_COMPRESSED                         = &H00000080
const DDPF_RGBTOYUV                           = &H00000100
const DDPF_YUV                                = &H00000200
const DDPF_ZBUFFER                            = &H00000400
const DDPF_PALETTEINDEXED1                    = &H00000800
const DDPF_PALETTEINDEXED2                    = &H00001000
const DDPF_ZPIXELS                            = &H00002000
const DDPF_STENCILBUFFER                      = &H00004000
const DDPF_ALPHAPREMULT                       = &H00008000
const DDPF_LUMINANCE                          = &H00020000
const DDPF_BUMPLUMINANCE                      = &H00040000
const DDPF_BUMPDUDV                           = &H00080000

'' DIRECTDRAW CALLBACK FLAGS

' DIRECTDRAW ENUMSURFACES FLAGS
const DDENUMSURFACES_ALL                      = &H00000001
const DDENUMSURFACES_MATCH                    = &H00000002
const DDENUMSURFACES_NOMATCH                  = &H00000004
const DDENUMSURFACES_CANBECREATED             = &H00000008
const DDENUMSURFACES_DOESEXIST                = &H00000010

' DIRECTDRAW SETDISPLAYMODE FLAGS
const DDSDM_STANDARDVGAMODE                   = &H00000001

' DIRECTDRAW ENUMDISPLAYMODES FLAGS
const DDEDM_REFRESHRATES                      = &H00000001
const DDEDM_STANDARDVGAMODES                  = &H00000002

' DIRECTDRAW BLT FLAGS
const DDBLT_ALPHADEST                         = &H00000001
const DDBLT_ALPHADESTCONSTOVERRIDE            = &H00000002
const DDBLT_ALPHADESTNEG                      = &H00000004
const DDBLT_ALPHADESTSURFACEOVERRIDE          = &H00000008
const DDBLT_ALPHAEDGEBLEND                    = &H00000010
const DDBLT_ALPHASRC                          = &H00000020
const DDBLT_ALPHASRCCONSTOVERRIDE             = &H00000040
const DDBLT_ALPHASRCNEG                       = &H00000080
const DDBLT_ALPHASRCSURFACEOVERRIDE           = &H00000100
const DDBLT_ASYNC                             = &H00000200
const DDBLT_COLORFILL                         = &H00000400
const DDBLT_DDFX                              = &H00000800
const DDBLT_DDROPS                            = &H00001000
const DDBLT_KEYDEST                           = &H00002000
const DDBLT_KEYDESTOVERRIDE                   = &H00004000
const DDBLT_KEYSRC                            = &H00008000
const DDBLT_KEYSRCOVERRIDE                    = &H00010000
const DDBLT_ROP                               = &H00020000
const DDBLT_ROTATIONANGLE                     = &H00040000
const DDBLT_ZBUFFER                           = &H00080000
const DDBLT_ZBUFFERDESTCONSTOVERRIDE          = &H00100000
const DDBLT_ZBUFFERDESTOVERRIDE               = &H00200000
const DDBLT_ZBUFFERSRCCONSTOVERRIDE           = &H00400000
const DDBLT_ZBUFFERSRCOVERRIDE                = &H00800000
const DDBLT_WAIT                              = &H01000000
const DDBLT_DEPTHFILL                         = &H02000000
const DDBLT_DONOTWAIT                         = &H08000000
const DDBLT_PRESENTATION                      = &H10000000
const DDBLT_LAST_PRESENTATION                 = &H20000000
const DDBLT_EXTENDED_FLAGS                    = &H40000000
const DDBLT_EXTENDED_LINEAR_CONTENT           = &H00000004


' BLTFAST FLAGS
const DDBLTFAST_NOCOLORKEY                    = &H00000000
const DDBLTFAST_SRCCOLORKEY                   = &H00000001
const DDBLTFAST_DESTCOLORKEY                  = &H00000002
const DDBLTFAST_WAIT                          = &H00000010
const DDBLTFAST_DONOTWAIT                     = &H00000020


' DIRECTDRAW SURFACE OVERLAY FLAGS
const DDOVER_ALPHADEST                        = &H00000001
const DDOVER_ALPHADESTCONSTOVERRIDE           = &H00000002
const DDOVER_ALPHADESTNEG                     = &H00000004
const DDOVER_ALPHADESTSURFACEOVERRIDE         = &H00000008
const DDOVER_ALPHAEDGEbEND                   = &H00000010
const DDOVER_ALPHASRC                         = &H00000020
const DDOVER_ALPHASRCCONSTOVERRIDE            = &H00000040
const DDOVER_ALPHASRCNEG                      = &H00000080
const DDOVER_ALPHASRCSURFACEOVERRIDE          = &H00000100
const DDOVER_HIDE                             = &H00000200
const DDOVER_KEYDEST                          = &H00000400
const DDOVER_KEYDESTOVERRIDE                  = &H00000800
const DDOVER_KEYSRC                           = &H00001000
const DDOVER_KEYSRCOVERRIDE                   = &H00002000
const DDOVER_SHOW                             = &H00004000
const DDOVER_ADDDIRTYRECT                     = &H00008000
const DDOVER_REFRESHDIRTYRECTS                = &H00010000
const DDOVER_REFRESHALL                      = &H00020000
const DDOVER_DDFX                             = &H00080000
const DDOVER_AUTOFLIP                         = &H00100000
const DDOVER_BOB                              = &H00200000
const DDOVER_OVERRIDEBOBWEAVE                 = &H00400000
const DDOVER_INTERLEAVED                      = &H00800000
const DDOVER_BOBHARDWARE                      = &H01000000
const DDOVER_ARGBSCALEFACTORS                 = &H02000000
const DDOVER_DEGRADEARGBSCALING               = &H04000000


' DIRECTDRAWSURFACE BLT FX FLAGS
const DDBLTFX_ARITHSTRETCHY                   = &H00000001
const DDBLTFX_MIRRORLEFTRIGHT                 = &H00000002
const DDBLTFX_MIRRORUPDOWN                    = &H00000004
const DDBLTFX_NOTEARING                       = &H00000008
const DDBLTFX_ROTATE180                       = &H00000010
const DDBLTFX_ROTATE270                       = &H00000020
const DDBLTFX_ROTATE90                        = &H00000040
const DDBLTFX_ZBUFFERRANGE                    = &H00000080
const DDBLTFX_ZBUFFERBASEDEST                 = &H00000100

' DIRECTDRAWSURFACE OVERLAY FX FLAGS
const DDOVERFX_ARITHSTRETCHY                  = &H00000001
const DDOVERFX_MIRRORLEFTRIGHT                = &H00000002
const DDOVERFX_MIRRORUPDOWN                   = &H00000004
const DDOVERFX_DEINTERLACE                    = &H00000008

' DIRECTDRAW WAITFORVERTICALBLANK FLAGS
const DDWAITVB_BLOCKBEGIN                     = &H00000001
const DDWAITVB_BLOCKBEGINEVENT                = &H00000002
const DDWAITVB_BLOCKEND                       = &H00000004

' DIRECTDRAW GETfIPSTATUS FLAGS
const DDGFS_CANFLIP                   = &H00000001
const DDGFS_ISFLIPDONE                = &H00000002

' DIRECTDRAW GETbTSTATUS FLAGS
const DDGBS_CANBLT                    = &H00000001
const DDGBS_ISBLTDONE                 = &H00000002

' DIRECTDRAW ENUMOVERLAYZORDER FLAGS
const DDENUMOVERLAYZ_BACKTOFRONT      = &H00000000
const DDENUMOVERLAYZ_FRONTTOBACK      = &H00000001

' DIRECTDRAW UPDATEOVERLAYZORDER FLAGS
const DDOVERZ_SENDTOFRONT             = &H00000000
const DDOVERZ_SENDTOBACK              = &H00000001
const DDOVERZ_MOVEFORWARD             = &H00000002
const DDOVERZ_MOVEBACKWARD            = &H00000003
const DDOVERZ_INSERTINFRONTOF         = &H00000004
const DDOVERZ_INSERTINBACKOF          = &H00000005

' DIRECTDRAW SETGAMMARAMP FLAGS
const DDSGR_CALIBRATE                        = &H00000001

' DIRECTDRAW STARTMODETEST FLAGS
const DDSMT_ISTESTREQUIRED                   = &H00000001

' DIRECTDRAW EVaUATEMODE FLAGS
const DDEM_MODEPASSED                        = &H00000001
const DDEM_MODEFAILED                        = &H00000002

' DIRECTDRAW RETURN CODES
const DD_OK%                                  = 0
const DD_FALSE%                               = 1

' DIRECTDRAW ENUMCALLBACK RETURN VALUES
const DDENUMRET_CANCEL%                       = 0
const DDENUMRET_OK%                           = 1

'DIRECTDRAW ERRORS
const DDERR_ALREADYINITIALIZED		= (1 shl 31) or (&h876 shl 16) or ( 5 )
const DDERR_CANNOTATTACHSURFACE		= (1 shl 31) or (&h876 shl 16) or ( 10 )
const DDERR_CANNOTDETACHSURFACE		= (1 shl 31) or (&h876 shl 16) or ( 20 )
const DDERR_CURRENTLYNOTAVAIL		= (1 shl 31) or (&h876 shl 16) or ( 40 )
const DDERR_EXCEPTION				= (1 shl 31) or (&h876 shl 16) or ( 55 )
const DDERR_GENERIC					= E_FAIL
const DDERR_HEIGHTALIGN				= (1 shl 31) or (&h876 shl 16) or ( 90 )
const DDERR_INCOMPATIBLEPRIMARY		= (1 shl 31) or (&h876 shl 16) or ( 95 )
const DDERR_INVALIDCAPS				= (1 shl 31) or (&h876 shl 16) or ( 100 )
const DDERR_INVALIDCLIPLIST			= (1 shl 31) or (&h876 shl 16) or ( 110 )
const DDERR_INVALIDMODE				= (1 shl 31) or (&h876 shl 16) or ( 120 )
const DDERR_INVALIDOBJECT			= (1 shl 31) or (&h876 shl 16) or ( 130 )
const DDERR_INVALIDPARAMS			= E_INVALIDARG
const DDERR_INVALIDPIXELFORMAT		= (1 shl 31) or (&h876 shl 16) or ( 145 )
const DDERR_INVALIDRECT				= (1 shl 31) or (&h876 shl 16) or ( 150 )
const DDERR_LOCKEDSURFACES			= (1 shl 31) or (&h876 shl 16) or ( 160 )
const DDERR_NO3D					= (1 shl 31) or (&h876 shl 16) or ( 170 )
const DDERR_NOALPHAHW				= (1 shl 31) or (&h876 shl 16) or ( 180 )
const DDERR_NOCLIPLIST				= (1 shl 31) or (&h876 shl 16) or ( 205 )
const DDERR_NOCOLORCONVHW			= (1 shl 31) or (&h876 shl 16) or ( 210 )
const DDERR_NOCOOPERATIVELEVELSET	= (1 shl 31) or (&h876 shl 16) or ( 212 )
const DDERR_NOCOLORKEY				= (1 shl 31) or (&h876 shl 16) or ( 215 )
const DDERR_NOCOLORKEYHW			= (1 shl 31) or (&h876 shl 16) or ( 220 )
const DDERR_NODIRECTDRAWSUPPORT		= (1 shl 31) or (&h876 shl 16) or ( 222 )
const DDERR_NOEXCLUSIVEMODE			= (1 shl 31) or (&h876 shl 16) or ( 225 )
const DDERR_NOFLIPHW				= (1 shl 31) or (&h876 shl 16) or ( 230 )
const DDERR_NOGDI					= (1 shl 31) or (&h876 shl 16) or ( 240 )
const DDERR_NOMIRRORHW				= (1 shl 31) or (&h876 shl 16) or ( 250 )
const DDERR_NOTFOUND				= (1 shl 31) or (&h876 shl 16) or ( 255 )
const DDERR_NOOVERLAYHW				= (1 shl 31) or (&h876 shl 16) or ( 260 )
const DDERR_NORASTEROPHW			= (1 shl 31) or (&h876 shl 16) or ( 280 )
const DDERR_NOROTATIONHW			= (1 shl 31) or (&h876 shl 16) or ( 290 )
const DDERR_NOSTRETCHHW				= (1 shl 31) or (&h876 shl 16) or ( 310 )
const DDERR_NOT4BITCOLOR			= (1 shl 31) or (&h876 shl 16) or ( 316 )
const DDERR_NOT4BITCOLORINDEX		= (1 shl 31) or (&h876 shl 16) or ( 317 )
const DDERR_NOT8BITCOLOR			= (1 shl 31) or (&h876 shl 16) or ( 320 )
const DDERR_NOTEXTUREHW				= (1 shl 31) or (&h876 shl 16) or ( 330 )
const DDERR_NOVSYNCHW				= (1 shl 31) or (&h876 shl 16) or ( 335 )
const DDERR_NOZBUFFERHW				= (1 shl 31) or (&h876 shl 16) or ( 340 )
const DDERR_NOZOVERLAYHW			= (1 shl 31) or (&h876 shl 16) or ( 350 )
const DDERR_OUTOFCAPS				= (1 shl 31) or (&h876 shl 16) or ( 360 )
const DDERR_OUTOFMEMORY				= E_OUTOFMEMORY
const DDERR_OUTOFVIDEOMEMORY		= (1 shl 31) or (&h876 shl 16) or ( 380 )
const DDERR_OVERLAYCANTCLIP			= (1 shl 31) or (&h876 shl 16) or ( 382 )
const DDERR_OVERLAYCOLORKEYONLYONEACTIVE = (1 shl 31) or (&h876 shl 16) or ( 384 )
const DDERR_PALETTEBUSY				= (1 shl 31) or (&h876 shl 16) or ( 387 )
const DDERR_COLORKEYNOTSET			= (1 shl 31) or (&h876 shl 16) or ( 400 )
const DDERR_SURFACEALREADYATTACHED	= (1 shl 31) or (&h876 shl 16) or ( 410 )
const DDERR_SURFACEALREADYDEPENDENT	= (1 shl 31) or (&h876 shl 16) or ( 420 )
const DDERR_SURFACEBUSY				= (1 shl 31) or (&h876 shl 16) or ( 430 )
const DDERR_CANTLOCKSURFACE         = (1 shl 31) or (&h876 shl 16) or ( 435 )
const DDERR_SURFACEISOBSCURED		= (1 shl 31) or (&h876 shl 16) or ( 440 )
const DDERR_SURFACELOST				= (1 shl 31) or (&h876 shl 16) or ( 450 )
const DDERR_SURFACENOTATTACHED		= (1 shl 31) or (&h876 shl 16) or ( 460 )
const DDERR_TOOBIGHEIGHT			= (1 shl 31) or (&h876 shl 16) or ( 470 )
const DDERR_TOOBIGSIZE				= (1 shl 31) or (&h876 shl 16) or ( 480 )
const DDERR_TOOBIGWIDTH				= (1 shl 31) or (&h876 shl 16) or ( 490 )
const DDERR_UNSUPPORTED				= E_NOTIMPL
const DDERR_UNSUPPORTEDFORMAT		= (1 shl 31) or (&h876 shl 16) or ( 510 )
const DDERR_UNSUPPORTEDMASK			= (1 shl 31) or (&h876 shl 16) or ( 520 )
const DDERR_VERTICALBLANKINPROGRESS	= (1 shl 31) or (&h876 shl 16) or ( 537 )
const DDERR_WASSTILLDRAWING			= (1 shl 31) or (&h876 shl 16) or ( 540 )
const DDERR_XALIGN					= (1 shl 31) or (&h876 shl 16) or ( 560 )
const DDERR_INVALIDDIRECTDRAWGUID	= (1 shl 31) or (&h876 shl 16) or ( 561 )
const DDERR_DIRECTDRAWALREADYCREATED = (1 shl 31) or (&h876 shl 16) or ( 562 )
const DDERR_NODIRECTDRAWHW			= (1 shl 31) or (&h876 shl 16) or ( 563 )
const DDERR_PRIMARYSURFACEALREADYEXISTS	= (1 shl 31) or (&h876 shl 16) or ( 564 )
const DDERR_NOEMULATION				= (1 shl 31) or (&h876 shl 16) or ( 565 )
const DDERR_REGIONTOOSMALL			= (1 shl 31) or (&h876 shl 16) or ( 566 )
const DDERR_CLIPPERISUSINGHWND		= (1 shl 31) or (&h876 shl 16) or ( 567 )
const DDERR_NOCLIPPERATTACHED		= (1 shl 31) or (&h876 shl 16) or ( 568 )
const DDERR_NOHWND					= (1 shl 31) or (&h876 shl 16) or ( 569 )
const DDERR_HWNDSUBCLASSED			= (1 shl 31) or (&h876 shl 16) or ( 570 )
const DDERR_HWNDALREADYSET			= (1 shl 31) or (&h876 shl 16) or ( 571 )
const DDERR_NOPALETTEATTACHED		= (1 shl 31) or (&h876 shl 16) or ( 572 )
const DDERR_NOPALETTEHW				= (1 shl 31) or (&h876 shl 16) or ( 573 )
const DDERR_BLTFASTCANTCLIP			= (1 shl 31) or (&h876 shl 16) or ( 574 )
const DDERR_NOBLTHW					= (1 shl 31) or (&h876 shl 16) or ( 575 )
const DDERR_NODDROPSHW				= (1 shl 31) or (&h876 shl 16) or ( 576 )
const DDERR_OVERLAYNOTVISIBLE		= (1 shl 31) or (&h876 shl 16) or ( 577 )
const DDERR_NOOVERLAYDEST			= (1 shl 31) or (&h876 shl 16) or ( 578 )
const DDERR_INVALIDPOSITION			= (1 shl 31) or (&h876 shl 16) or ( 579 )
const DDERR_NOTAOVERLAYSURFACE		= (1 shl 31) or (&h876 shl 16) or ( 580 )
const DDERR_EXCLUSIVEMODEALREADYSET	= (1 shl 31) or (&h876 shl 16) or ( 581 )
const DDERR_NOTFLIPPABLE			= (1 shl 31) or (&h876 shl 16) or ( 582 )
const DDERR_CANTDUPLICATE			= (1 shl 31) or (&h876 shl 16) or ( 583 )
const DDERR_NOTLOCKED				= (1 shl 31) or (&h876 shl 16) or ( 584 )
const DDERR_CANTCREATEDC			= (1 shl 31) or (&h876 shl 16) or ( 585 )
const DDERR_NODC					= (1 shl 31) or (&h876 shl 16) or ( 586 )
const DDERR_WRONGMODE				= (1 shl 31) or (&h876 shl 16) or ( 587 )
const DDERR_IMPLICITLYCREATED		= (1 shl 31) or (&h876 shl 16) or ( 588 )
const DDERR_NOTPALETTIZED			= (1 shl 31) or (&h876 shl 16) or ( 589 )
const DDERR_UNSUPPORTEDMODE			= (1 shl 31) or (&h876 shl 16) or ( 590 )
const DDERR_NOMIPMAPHW				= (1 shl 31) or (&h876 shl 16) or ( 591 )
const DDERR_INVALIDSURFACETYPE      = (1 shl 31) or (&h876 shl 16) or ( 592 )
const DDERR_NOOPTIMIZEHW            = (1 shl 31) or (&h876 shl 16) or ( 600 )
const DDERR_NOTLOADED               = (1 shl 31) or (&h876 shl 16) or ( 601 )
const DDERR_NOFOCUSWINDOW           = (1 shl 31) or (&h876 shl 16) or ( 602 )
const DDERR_DCALREADYCREATED		= (1 shl 31) or (&h876 shl 16) or ( 620 )
const DDERR_NONONLOCALVIDMEM        = (1 shl 31) or (&h876 shl 16) or ( 630 )
const DDERR_CANTPAGELOCK			= (1 shl 31) or (&h876 shl 16) or ( 640 )
const DDERR_CANTPAGEUNLOCK			= (1 shl 31) or (&h876 shl 16) or ( 660 )
const DDERR_NOTPAGELOCKED			= (1 shl 31) or (&h876 shl 16) or ( 680 )
const DDERR_MOREDATA         		= (1 shl 31) or (&h876 shl 16) or ( 690 )
const DDERR_VIDEONOTACTIVE   		= (1 shl 31) or (&h876 shl 16) or ( 695 )
const DDERR_DEVICEDOESNTOWNSURFACE  = (1 shl 31) or (&h876 shl 16) or ( 699 )


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